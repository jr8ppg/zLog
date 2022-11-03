unit UZLinkForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Console2, StdCtrls, ComCtrls, UITypes,
  OverbyteIcsWndControl, OverbyteIcsWSocket, Generics.Collections,
  UzLogConst, UzLogGlobal, UzLogQSO, UScratchSheet;

type
  TQSOID = class
    FullQSOID : integer;
    QSOIDwoCounter : integer;
  end;

  TZLinkForm = class(TForm)
    StatusLine: TStatusBar;
    Panel1: TPanel;
    Edit: TEdit;
    ConnectButton: TButton;
    Console: TColorConsole2;
    Timer1: TTimer;
    ZSocket: TWSocket;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ConnectButtonClick(Sender: TObject);
    procedure ZSocketDataAvailable(Sender: TObject; Error: Word);
    procedure ZSocketSessionClosed(Sender: TObject; Error: Word);
    procedure ZSocketSessionConnected(Sender: TObject; Error: Word);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    CommTemp : string; {command work string}
    CommStarted : boolean;

    CommBuffer : TStringList;
    CommandQue : TStringList;

    FMergeTempList: TList<TQSOID>; // temporary list to hold Z-Server QSOID list
                           // created when GETQSOIDS is issued and destroyed
                           // when all merge process is finished. List of TQSOID

    procedure EnableConnectButton(boo : boolean);
    procedure CommProcess;
    procedure ProcessCommand;
    procedure EndQsoIDsProc();
    procedure SendMergeTempList; // request to send the qsos in the MergeTempList
    procedure SendQSO_PUTLOG(aQSO : TQSO);

    { unused commands
    procedure SendLogToZServer;
    procedure GetCurrentBandData(B : TBand); // loads data from Z-Server to main Log. Issues SENDCURRENT n
    procedure SendNewPrefix(PX : string; CtyIndex : integer);
    }
  public
    { Public declarations }
    //Transparent : boolean; // only for loading log from ZServer. False by default
    DisconnectedByMenu : boolean;
    procedure ImplementOptions;
    procedure WriteData(str : string);
    procedure SendBand; {Sends current band (to Z-Server) #ZLOG# BAND 3 etc}
    procedure SendOperator;
    procedure SendQSO(aQSO : TQSO);
    procedure RelaySpot(S : string); //called from CommForm to relay spot info
    procedure SendSpotViaNetwork(S : string);
    procedure SendFreqInfo(Hz: Int64);
    procedure SendRigStatus;
    procedure MergeLogWithZServer;
    procedure DeleteQSO(aQSO : TQSO);
    procedure DeleteQsoEx(aQSO: TQSO);
    procedure Renew();
    procedure LockQSO(aQSO : TQSO);
    procedure UnLockQSO(aQSO : TQSO);
    procedure EditQSObyID(aQSO : TQSO);
    procedure InsertQSO(bQSO : TQSO);
    procedure LoadLogFromZLink;
    function ZServerConnected : boolean;
    procedure SendRemoteCluster(S : String);
    procedure SendPacketData(S : String);
    procedure SendScratchMessage(S : string);
    procedure SendBandScopeData(BSText : string);
    procedure PostWanted(Band: TBand; Mult : string);
    procedure DelWanted(Band: TBand; Mult : string);
    procedure PushRemoteConnect; // connect button in cluster win
  end;

implementation

uses
  Main, UOptions, UChat, UZServerInquiry, UComm, URigControl, UFreqList,
  UBandScope2;

var
  CommProcessing : boolean; // commprocess flag;

{$R *.DFM}

procedure TZLinkForm.WriteData(str: string);
begin
   if ZSocket.State = wsConnected then begin
      ZSocket.SendStr(str);
   end;
end;

procedure TZLinkForm.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TZLinkForm.Button1Click(Sender: TObject);
begin
   Close;
end;

procedure TZLinkForm.Timer1Timer(Sender: TObject);
begin
   Timer1.Enabled := False;
   try
      if not(CommProcessing) then
         CommProcess;
   finally
      Timer1.Enabled := True;
   end;
end;

{
procedure TZLinkForm.SendLogToZServer;
var
   i: integer;
   str: string;
   R: TBandBool;
   B: TBand;
begin
   if Log.TotalQSO = 0 then
      exit;
   R := Log.ContainBand;
   for B := b19 to HiBand do
      if R[B] then begin
         str := ZLinkHeader + ' RESET ' + IntToStr(Ord(B));
         // repeat until AsyncComm.OutQueCount = 0;
         WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
      end;

   for i := 1 to Log.TotalQSO do begin
      // repeat until AsyncComm.OutQueCount = 0;
      SendQSO_PUTLOG(Log.QsoList[i]);
   end;

   for B := b19 to HiBand do
      if R[B] then begin
         str := ZLinkHeader + ' ENDLOG ' + IntToStr(Ord(B));
         // repeat until AsyncComm.OutQueCount = 0;
         WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
      end;
end;
}

procedure TZLinkForm.MergeLogWithZServer;
var
   str: string;
begin
   str := ZLinkHeader + ' GETQSOIDS';
   FMergeTempList := TList<TQSOID>.Create;
   WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
end;

procedure TZLinkForm.SendRemoteCluster(S: string);
var
   str: string;
begin
   str := ZLinkHeader + ' SENDCLUSTER ' + S;
   WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
end;

procedure TZLinkForm.SendPacketData(S: string);
var
   str: string;
begin
   str := ZLinkHeader + ' SENDPACKET ' + S;
   WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
end;

procedure TZLinkForm.SendScratchMessage(S: string);
var
   str: string;
begin
   str := ZLinkHeader + ' SENDSCRATCH ' + S;
   WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
end;

{
procedure TZLinkForm.SendNewPrefix(PX: string; CtyIndex: integer);
var
   str: string; // NEWPX xxx...NEWPX
begin
   str := ZLinkHeader + ' NEWPX ';
   str := str + FillRight(IntToStr(CtyIndex), 6) + PX;
   WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
end;
}

procedure TZLinkForm.SendBandScopeData(BSText: string);
var
   str: string;
begin
   str := ZLinkHeader + ' BSDATA ' + BSText;
   WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
end;

procedure TZLinkForm.PostWanted(Band: TBand; Mult: string);
var
   str: string;
begin
   str := ZLinkHeader + ' POSTWANTED ' + IntToStr(Ord(Band)) + ' ' + Mult;
   WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
end;

procedure TZLinkForm.DelWanted(Band: TBand; Mult: string);
var
   str: string;
begin
   str := ZLinkHeader + ' DELWANTED ' + IntToStr(Ord(Band)) + ' ' + Mult;
   WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
end;

procedure TZLinkForm.PushRemoteConnect;
var
   str: string;
begin
   str := ZLinkHeader + ' CONNECTCLUSTER';
   WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
end;

procedure TZLinkForm.SendMergeTempList;
var
   count, i: integer;
   qid: TQSOID;
   str: string;
begin
   try
      count := FMergeTempList.Count;
      if count = 0 then begin
         Exit;
      end;

      i := 0;
      str := '';
      while i <= count - 1 do begin
         repeat
            qid := FMergeTempList[i];
            str := str + IntToStr(qid.FullQSOID) + ' ';
            inc(i);
         until (i = count) or (i mod 20 = 0);
         WriteData(ZLinkHeader + ' ' + 'GETLOGQSOID ' + str + LineBreakCode[Ord(Console.LineBreak)]);
         str := ''; // 2.0q
      end;

      WriteData(ZLinkHeader + ' ' + 'SENDRENEW' + LineBreakCode[Ord(Console.LineBreak)]);
   finally
      for i := FMergeTempList.Count - 1 downto 0 do begin
         FMergeTempList[i].Free();
         FMergeTempList.Delete(i);
      end;
      FMergeTempList.Free();
   end;
end;

procedure TZLinkForm.ProcessCommand;
var
   temp, temp2: string;
   aQSO: TQSO;
   i, j: integer;
   qid: TQSOID;
begin
   while CommandQue.count > 0 do begin
      temp := CommandQue.Strings[0];
      temp := copy(temp, length(ZLinkHeader) + 2, 255);

      { if pos('TRANSPARENT', temp) = 1 then
        begin
        Delete(temp, 1, 12);
        if pos('ON', temp) = 1 then
        begin
        Transparent := True;
        MainForm.LoadCurrent.Enabled := False;
        MainForm.UploadZServer.Enabled := False;
        ZServerInquiry.TransparentOn;
        end
        else
        begin
        Transparent := False;
        MainForm.LoadCurrent.Enabled := True;
        MainForm.UploadZServer.Enabled := True;
        end;
        end; }

      if pos('FREQ', temp) = 1 then begin
         temp := copy(temp, 6, 255);
         MainForm.FreqList.ProcessFreqData(temp);
      end;

      if pos('QSOIDS', temp) = 1 then begin
         Delete(temp, 1, 7);
         i := pos(' ', temp);
         while i > 1 do begin
            temp2 := copy(temp, 1, i - 1);
            Delete(temp, 1, i);
            j := StrToInt(temp2);
            qid := TQSOID.Create;
            qid.FullQSOID := j;
            qid.QSOIDwoCounter := j div 100;
            FMergeTempList.Add(qid);
            i := pos(' ', temp);
         end;
      end;

      if pos('ENDQSOIDS', temp) = 1 then begin
         EndQsoIDsProc();
      end;

      if pos('PROMPTUPDATE', temp) = 1 then begin // file loaded on ZServer
         { if MessageDlg('The file on Z-Server has been updated. Do you want to download the data now?',
           mtConfirmation, [mbYes, mbNo], 0) = mrYes then
           LoadLogFromZServer; }
      end;

      if pos('NEWPX', temp) = 1 then begin
         Delete(temp, 1, 6);

         i := StrToIntDef(TrimRight(copy(temp, 1, 6)), -1);
         if i >= 0 then begin
            Delete(temp, 1, 6);
            if temp <> '' then
               MyContest.MultiForm.AddNewPrefix(temp, i);
         end;
      end;

      if pos('PUTMESSAGE', temp) = 1 then begin
         Delete(temp, 1, 11);
         if pos('!', temp) = 1 then begin
            Delete(temp, 1, 1);
            MainForm.WriteStatusLineRed(temp, true);
         end
         else
            MainForm.WriteStatusLine(temp, false);
         MainForm.ChatForm.Add(temp);
      end;

      if pos('POSTWANTED', temp) = 1 then begin
         temp := copy(temp, 12, 255);
         MyContest.PostWanted(temp);
      end;

      if pos('DELWANTED', temp) = 1 then begin
         temp := copy(temp, 11, 255);
         MyContest.DelWanted(temp);
      end;

      if pos('SPOT ', temp) = 1 then begin
         temp := copy(temp, 6, 255);
         MainForm.CommForm.PreProcessSpotFromZLink(temp, 1);
      end;

      if pos('SPOT2 ', temp) = 1 then begin
         temp := copy(temp, 7, 255);
         MainForm.CommForm.PreProcessSpotFromZLink(temp, 2);
      end;

      if pos('SPOT3 ', temp) = 1 then begin
         temp := copy(temp, 7, 255);
         MainForm.CommForm.PreProcessSpotFromZLink(temp, 3);
      end;

      if pos('BSDATA ', temp) = 1 then begin
         temp := copy(temp, 8, 255);
         MainForm.BandScopeAddSelfSpotFromNetwork(temp);
      end;

      if pos('SENDSPOT ', temp) = 1 then begin
         temp := copy(temp, 10, 255);
         MainForm.CommForm.WriteLine(temp);
      end;

      if pos('SENDCLUSTER ', temp) = 1 then begin // remote manipulation of cluster console
         temp := copy(temp, 13, 255);
         MainForm.CommForm.WriteLine(temp);
      end;

      if pos('SENDPACKET ', temp) = 1 then begin
         temp := copy(temp, 12, 255);
         MainForm.CommForm.WriteLineConsole(temp);
      end;

      if pos('SENDSCRATCH ', temp) = 1 then begin
         temp := copy(temp, 13, 255);
         MainForm.ScratchSheet.AddBuffer(temp);
         MainForm.ScratchSheet.UpdateData;
      end;

      if pos('CONNECTCLUSTER', temp) = 1 then begin
         MainForm.CommForm.RemoteConnectButtonPush;
      end;

      if pos('PUTQSO ', temp) = 1 then begin
         aQSO := TQSO.Create;
         temp := copy(temp, 8, 255);
         aQSO.TextToQSO(temp);
         MyContest.LogQSO(aQSO, false);
         MainForm.GridRefreshScreen;
         MainForm.BandScopeNotifyWorked(aQSO);
         aQSO.Free;
      end;

      if pos('DELQSO ', temp) = 1 then begin
         aQSO := TQSO.Create;
         Delete(temp, 1, 7);
         aQSO.TextToQSO(temp);
         aQSO.Reserve := actDelete;
         Log.AddQue(aQSO);
         Log.ProcessQue;
         MyContest.Renew;
         MainForm.GridRefreshScreen;
         aQSO.Free;
      end;

      if pos('EXDELQSO ', temp) = 1 then begin
         aQSO := TQSO.Create;
         Delete(temp, 1, 9);
         aQSO.TextToQSO(temp);
         aQSO.Reserve := actDelete;
         Log.AddQue(aQSO);
         Log.ProcessQue;
         MainForm.GridRefreshScreen;
         aQSO.Free;
      end;

      if pos('INSQSOAT ', temp) = 1 then begin
         aQSO := TQSO.Create;
         Delete(temp, 1, 9);
         aQSO.TextToQSO(temp);
         aQSO.Reserve := actInsert;
         Log.AddQue(aQSO);
         // Log.ProcessQue;
         // MyContest.Renew;
         MainForm.GridRefreshScreen;
         aQSO.Free;
      end;

      if pos('LOCKQSO', temp) = 1 then begin
         aQSO := TQSO.Create;
         temp := copy(temp, 9, 255);
         aQSO.TextToQSO(temp);
         aQSO.Reserve := actLock;
         Log.AddQue(aQSO);
         Log.ProcessQue;
         MyContest.Renew;
         MainForm.GridRefreshScreen();
         aQSO.Free;
      end;

      if pos('UNLOCKQSO', temp) = 1 then begin
         aQSO := TQSO.Create;
         temp := copy(temp, 11, 255);
         aQSO.TextToQSO(temp);
         aQSO.Reserve := actUnlock;
         Log.AddQue(aQSO);
         Log.ProcessQue;
         MyContest.Renew;
         MainForm.GridRefreshScreen();
         aQSO.Free;
      end;

      if pos('EDITQSOTO ', temp) = 1 then begin
         aQSO := TQSO.Create;
         temp := copy(temp, 11, 255);
         aQSO.TextToQSO(temp);
         aQSO.Reserve := actEdit;
         Log.AddQue(aQSO);
         Log.ProcessQue;
         MyContest.Renew;
         MainForm.GridRefreshScreen;
         aQSO.Free;
      end;

      if pos('INSQSO ', temp) = 1 then begin
         aQSO := TQSO.Create;
         Delete(temp, 1, 7);
         aQSO.TextToQSO(temp);
         aQSO.Reserve := actInsert;
         Log.AddQue(aQSO);
         Log.ProcessQue;
         MyContest.Renew;
         MainForm.GridRefreshScreen;
         aQSO.Free;
      end;

      if pos('PUTLOGEX ', temp) = 1 then begin
         aQSO := TQSO.Create;
         Delete(temp, 1, 9);
         aQSO.TextToQSO(temp);
         aQSO.Reserve := actEditOrAdd;
         Log.AddQue(aQSO);
         aQSO.Free;
      end;

      if pos('PUTLOG ', temp) = 1 then begin
         aQSO := TQSO.Create;
         Delete(temp, 1, 7);
         aQSO.TextToQSO(temp);
         aQSO.Reserve := actAdd;
         Log.AddQue(aQSO);
         aQSO.Free;
      end;

      if pos('RENEW', temp) = 1 then begin
         Log.ProcessQue;
         MyContest.Renew;
         MainForm.GridRefreshScreen;
      end;

      if pos('SENDLOG', temp) = 1 then begin
         for i := 1 to Log.TotalQSO do begin
            // repeat until AsyncComm.OutQueCount = 0;
            SendQSO_PUTLOG(Log.QsoList[i]);
         end;
         // repeat until AsyncComm.OutQueCount = 0;
         WriteData(ZLinkHeader + ' ' + 'RENEW' + LineBreakCode[Ord(Console.LineBreak)]);
      end;

      CommandQue.Delete(0);
   end;
end;

procedure TZLinkForm.DeleteQSO(aQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' DELQSO ' + aQSO.QSOinText;
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.DeleteQsoEx(aQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' EXDELQSO ' + aQSO.QSOinText;
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.Renew();
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' RENEW ';
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.LockQSO(aQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      // aQSO.QSO.Reserve := actLock;
      str := ZLinkHeader + ' LOCKQSO ' + aQSO.QSOinText;
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.UnLockQSO(aQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      // aQSO.QSO.Reserve := actUnLock;
      str := ZLinkHeader + ' UNLOCKQSO ' + aQSO.QSOinText;
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.SendBand;
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' BAND ' + IntToStr(Ord(Main.CurrentQSO.Band));
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.SendOperator;
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' OPERATOR ' + Main.CurrentQSO.Operator;
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.SendFreqInfo(Hz: Int64);
var
   str: string;
begin
   if Hz = 0 then
      exit;

   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      if Hz > 60000 then
         str := MainForm.RigControl.StatusSummaryFreq(round(Hz / 1000))
      else
         str := MainForm.RigControl.StatusSummaryFreqHz(Hz);

      if str = '' then
         exit;

      MainForm.FreqList.ProcessFreqData(str);
      str := ZLinkHeader + ' FREQ ' + str;
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.SendRigStatus;
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := MainForm.RigControl.StatusSummary;
      if str = '' then begin
         exit;
      end;

      MainForm.FreqList.ProcessFreqData(str);
      str := ZLinkHeader + ' FREQ ' + str;
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.RelaySpot(S: string);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' SPOT ' + S;
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.SendSpotViaNetwork(S: string);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' SENDSPOT ' + S;
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.SendQSO(aQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' PUTQSO ' + aQSO.QSOinText;
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.SendQSO_PUTLOG(aQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' PUTLOG ' + aQSO.QSOinText;
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.EditQSObyID(aQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' EDITQSOTO ' + aQSO.QSOinText;
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.InsertQSO(bQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      // repeat until AsyncComm.OutQueCount = 0;
      str := ZLinkHeader + ' INSQSO ' + bQSO.QSOinText;
      WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.EndQsoIDsProc();
var
   aQSO: TQSO;
   fFoundQso: Boolean;
   fNeedToRenew: Boolean;
   i: Integer;
   j: Integer;
   qid: TQSOID;
begin
   fNeedToRenew := False;

   for i := 1 to Log.TotalQSO do begin
      aQSO := Log.QsoList[i];

      fFoundQso := False;

      for j := 0 to FMergeTempList.Count - 1 do begin
         qid := FMergeTempList[j];
         if (aQSO.Reserve3 div 100) = qid.QSOIDwoCounter then begin
            fFoundQso := True;

            if aQSO.Reserve3 = qid.FullQSOID then begin // exactly the same qso
               FMergeTempList.Delete(j);
               qid.Free;
               break;
            end
            else begin // counter is different
               if qid.FullQSOID > aQSO.Reserve3 then begin // serverdata is newer
                  break;
                  // qid qso must be sent as editqsoto command;
               end
               else begin // local data is newer
                  FMergeTempList.Delete(j);
                  qid.Free;

                  WriteData(ZLinkHeader + ' ' + 'EDITQSOTO ' + aQSO.QSOinText + LineBreakCode[Ord(Console.LineBreak)]);
                  break;
                  // aQSO moved to ToSendList (but edit)
                  // or just ask to send immediately
               end;
            end;
         end;
      end;

      if fFoundQso = False then begin
         SendQSO_PUTLOG(aQSO);
         fNeedToRenew := true;
         // add aQSO to ToSendList;
         // or just send putlog ...
         // renew after done.
      end;
   end;

   // getqsos from MergeTempList; (whatever is left)
   // Free MergeTempList;
   if fNeedToRenew then begin
      WriteData(ZLinkHeader + ' ' + 'RENEW' + LineBreakCode[Ord(Console.LineBreak)]);
   end;

   SendMergeTempList;
end;

procedure TZLinkForm.CommProcess;
var
   max, i, j, x: integer;
   str: string;
begin
   CommProcessing := true;
   max := CommBuffer.count - 1;
   if max < 0 then begin
      CommProcessing := false;
      exit;
   end;

   for i := 0 to max do begin
      Console.WriteString(CommBuffer.Strings[i]);
   end;

   for i := 0 to max do begin
      str := CommBuffer.Strings[0];
      for j := 1 to length(str) do begin
         if str[j] = Chr($0D) then begin
            x := pos(ZLinkHeader, CommTemp);
            if x > 0 then begin
               // MainForm.WriteStatusLine(CommTemp);
               // CHATFORM.ADD(COMMTEMP);
               CommTemp := copy(CommTemp, x, 255);
               CommandQue.Add(CommTemp);
            end;

            CommTemp := '';
         end
         else begin
            CommTemp := CommTemp + str[j];
         end;
      end;

      CommBuffer.Delete(0);
   end;

   ProcessCommand;

   CommProcessing := false;
end;

procedure TZLinkForm.FormCreate(Sender: TObject);
begin
   // Transparent := False;
   DisconnectedByMenu := false;
   CommProcessing := false;
   FMergeTempList := nil;

   if dmZlogGlobal.Settings._zlinkport in [1 .. 6] then begin
      // Transparent := True; // rs-232c
      // no rs232c allowed!
   end;

   CommStarted := false;
   CommBuffer := TStringList.Create;
   CommandQue := TStringList.Create;
   CommTemp := '';
   Timer1.Enabled := true;
   ImplementOptions;
end;

procedure TZLinkForm.FormDestroy(Sender: TObject);
begin
   CommBuffer.Free();
   CommandQue.Free();
end;

procedure TZLinkForm.EnableConnectButton(boo : boolean);
begin
   ConnectButton.Enabled := boo;
end;

procedure TZLinkForm.ImplementOptions;
begin
   try
      EnableConnectButton((dmZlogGlobal.Settings._zlinkport = 1) and (dmZlogGlobal.Settings._zlink_telnet.FHostName <> ''));
      Console.LineBreak := TConsole2LineBreak(dmZlogGlobal.Settings._zlink_telnet.FLineBreak);
      ZSocket.Addr := dmZlogGlobal.Settings._zlink_telnet.FHostName;
   except
      on ESocketException do begin
         MainForm.WriteStatusLine('Cannnot resolve host name', true);
      end;
   end;
end;

procedure TZLinkForm.EditKeyPress(Sender: TObject; var Key: Char);
var
   boo: boolean;
begin
   boo := dmZlogGlobal.Settings._zlink_telnet.FLocalEcho;

   if Key = Chr($0D) then begin
      WriteData(Edit.Text + LineBreakCode[Ord(Console.LineBreak)]);
      if boo then begin
         Console.WriteString(Edit.Text + LineBreakCode[Ord(Console.LineBreak)]);
      end;

      Key := Chr($0);
      Edit.Text := '';
   end;
end;

procedure TZLinkForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

function TZLinkForm.ZServerConnected: boolean;
begin
   Result := (ZSocket.State = wsConnected);
end;

procedure TZLinkForm.ConnectButtonClick(Sender: TObject);
begin
   try
      if (ZSocket.State = wsConnected) then begin
         DisconnectedByMenu := True;
         ConnectButton.Caption := 'Disconnecting...';
         ZSocket.Close;
      end
      else begin
         ConnectButton.Caption := 'Connecting...';
         ZSocket.Addr := dmZlogGlobal.Settings._zlink_telnet.FHostName;
         ZSocket.Port := 'telnet';
         ZSocket.Connect;
      end;
   except
      on E: Exception do begin
         Console.WriteString(E.Message + LineBreakCode[Ord(Console.LineBreak)]);
      end;
   end;
end;

procedure TZLinkForm.LoadLogFromZLink;
var
   R: Word;
begin
   R := MessageDlg('This will delete all data and loads data using Z-Link', mtConfirmation, [mbOK, mbCancel], 0); { HELP context 0 }
   if R = mrCancel then begin
      exit;
   end;

   Log.Clear2();
   WriteData(ZLinkHeader + ' ' + 'SENDLOG' + LineBreakCode[Ord(Console.LineBreak)]);
end;

{
procedure TZLinkForm.GetCurrentBandData(B: TBand);
var
   str: string;
begin
   str := ZLinkHeader + ' SENDCURRENT ' + IntToStr(Ord(B));
   // repeat until AsyncComm.OutQueCount = 0;
   WriteData(str + LineBreakCode[Ord(Console.LineBreak)]);
end;
}

procedure TZLinkForm.ZSocketDataAvailable(Sender: TObject; Error: Word);
var
   Buf: array [0 .. 2047] of AnsiChar;
   str: string;
   count: integer;
   P: PAnsiChar;
begin
   if Error <> 0 then begin
      exit;
   end;

   count := TWSocket(Sender).Receive(@Buf, SizeOf(Buf) - 1);
   if count <= 0 then begin
      exit;
   end;

   Buf[count] := #0;
   P := @Buf[0];
   str := string(AnsiString(P));
   // str := StrPas(P);
   CommBuffer.Add(str);
end;

procedure TZLinkForm.ZSocketSessionClosed(Sender: TObject; Error: Word);
begin
   Console.WriteString('disconnected...');
   ConnectButton.Caption := 'Connect';
   MainForm.ConnectToZServer1.Caption := 'Connect to Z-Server';
   MainForm.ZServerIcon.Visible := false;
   MainForm.DisableNetworkMenus;
   MainForm.ChatForm.SetConnectStatus(False);

   if DisconnectedByMenu = false then begin
      MessageDlg('Z-Server connection failed.', mtError, [mbOK], 0); { HELP context 0 }
   end
   else begin
      DisconnectedByMenu := false;
   end;
end;

procedure TZLinkForm.ZSocketSessionConnected(Sender: TObject; Error: Word);
begin
   if Error <> 0 then begin
      Exit;
   end;

   ConnectButton.Caption := 'Disconnect';
   MainForm.ConnectToZServer1.Caption := 'Disconnect Z-Server'; // 0.23
   Console.WriteString('connected to ' + ZSocket.Addr + LineBreakCode[Ord(Console.LineBreak)]);
   SendBand; { tell Z-Server current band }
   SendOperator;
   MainForm.ZServerInquiry.ShowModal;
   MainForm.ZServerIcon.Visible := true;
   MainForm.EnableNetworkMenus;
   MainForm.ChatForm.SetConnectStatus(True);
end;

end.
