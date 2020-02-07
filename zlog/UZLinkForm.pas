unit UZLinkForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Console2, StdCtrls, ComCtrls, UzLogGlobal,
  UScratchSheet, OverbyteIcsWndControl, OverbyteIcsWSocket;

type
  TQSOID = class
    FullQSOID : integer;
    QSOIDwoCounter : integer;
  end;

  TZLinkForm = class(TForm)
    StatusLine: TStatusBar;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Edit: TEdit;
    Button: TButton;
    Console: TColorConsole2;
    Timer1: TTimer;
    Button3: TButton;
    ZSocket: TWSocket;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonClick(Sender: TObject);
    //procedure AsyncCommRxChar(Sender: TObject; Count: Integer);
    //procedure AsyncCommError(Sender: TObject; Errors: Integer);
    procedure Button3Click(Sender: TObject);
    procedure ZSocketDataAvailable(Sender: TObject; Error: Word);
    procedure ZSocketSessionClosed(Sender: TObject; Error: Word);
    procedure ZSocketSessionConnected(Sender: TObject; Error: Word);
  private
    { Private declarations }
    CommTemp : string[255]; {command work string}
    CommStarted : boolean;
  public
    { Public declarations }
    //Transparent : boolean; // only for loading log from ZServer. False by default
    CommBuffer : TStringList;
    CommandQue : TStringList;
    MergeTempList : TList; // temporary list to hold Z-Server QSOID list
                           // created when GETQSOIDS is issued and destroyed
                           // when all merge process is finished. List of TQSOID
    DisconnectedByMenu : boolean;
    procedure CommProcess;
    procedure ImplementOptions;
    procedure WriteData(str : string);
    procedure SendMergeTempList; // request to send the qsos in the MergeTempList
    procedure ProcessCommand;
    procedure SendBand; {Sends current band (to Z-Server) #ZLOG# BAND 3 etc}
    procedure SendOperator;
    procedure SendQSO(aQSO : TQSO);
    procedure SendQSO_PUTLOG(aQSO : TQSO);
    procedure RelaySpot(S : string); //called from CommForm to relay spot info
    procedure SendSpotViaNetwork(S : string);
    procedure SendFreqInfo(Hz : integer);
    procedure SendRigStatus;
    procedure SendLogToZServer;
    procedure MergeLogWithZServer;
    procedure DeleteQSO(aQSO : TQSO);
    //procedure SendQSOLog(aQSO : TQSO);
    procedure LockQSO(aQSO : TQSO);
    procedure UnLockQSO(aQSO : TQSO);
    //procedure EditQSO(aQSO, bQSO : TQSO);
    procedure EditQSObyID(aQSO : TQSO);
    procedure InsertQSO(bQSO : TQSO);
    procedure LoadLogFromZLink;
    //procedure LoadLogFromZServer;
    function ZServerConnected : boolean;
    procedure GetCurrentBandData(B : TBand); // loads data from Z-Server to main Log. Issues SENDCURRENT n
    procedure SendRemoteCluster(S : String);
    procedure SendPacketData(S : String);
    procedure SendScratchMessage(S : string);
    procedure SendNewPrefix(PX : string; CtyIndex : integer);
    procedure SendBandScopeData(BSText : string);
    procedure PostWanted(Band: TBand; Mult : string);
    procedure DelWanted(Band: TBand; Mult : string);
    procedure PushRemoteConnect; // connect button in cluster win
  end;

var
  ZLinkForm: TZLinkForm;

implementation

uses
  Main, UOptions, UChat, UZServerInquiry, UComm, URigControl, UFreqList,
  UBandScope2;

var
  CommProcessing : boolean; // commprocess flag;

{$R *.DFM}

procedure TZLinkForm.WriteData(str : string);
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

procedure TZLinkForm.Button2Click(Sender: TObject);
begin
  if Self.FormStyle = fsStayOnTop then
    begin
      Self.FormStyle := fsNormal;
      Button2.Caption := 'Stay on Top';
    end
  else
    begin
      Self.FormStyle := fsStayOnTop;
      Button2.Caption := 'Normal';
    end;
end;

procedure TZLinkForm.Timer1Timer(Sender: TObject);
begin
  if not(CommProcessing) then
    CommProcess;
end;

procedure TZLinkForm.SendLogToZServer;
var i : integer;
    str : string;
    R : TBandBool;
    B : TBand;
begin
  if Log.TotalQSO = 0 then exit;
  R := Log.ContainBand;
  for B := b19 to HiBand do
    if R[B] then
      begin
        str := ZLinkHeader + ' RESET ' + IntToStr(Ord(B));
        //repeat until AsyncComm.OutQueCount = 0;
        WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
      end;

  for i := 1 to Log.TotalQSO do
    begin
      //repeat until AsyncComm.OutQueCount = 0;
      SendQSO_PUTLOG(TQSO(Log.List[i]));
    end;

  for B := b19 to HiBand do
    if R[B] then
      begin
        str := ZLinkHeader + ' ENDLOG ' + IntToStr(Ord(B));
        //repeat until AsyncComm.OutQueCount = 0;
        WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
      end;
end;

procedure TZLinkForm.MergeLogWithZServer;
var str : string;
begin
  str := ZLinkHeader + ' GETQSOIDS';
  MergeTempList := TList.Create;
  WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TZlinkForm.SendRemoteCluster(S : string);
var str : string;
begin
  str := ZLinkHeader + ' SENDCLUSTER ' + S;
  WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TZlinkForm.SendPacketData(S : string);
var str : string;
begin
  str := ZLinkHeader + ' SENDPACKET ' + S;
  WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TZlinkForm.SendScratchMessage(S : string);
var str : string;
begin
  str := ZLinkHeader + ' SENDSCRATCH ' + S;
  WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TZlinkForm.SendNewPrefix(PX : string; CtyIndex : integer);
var str : string;   // NEWPX xxx...NEWPX
begin
  str := ZLinkHeader + ' NEWPX ';
  str := str + FillRight(IntToStr(CtyIndex), 6)+PX;
  WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TZlinkForm.SendBandScopeData(BSText : string);
var str : string;
begin
  str := ZLinkHeader + ' BSDATA '+BSText;
  WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TZlinkForm.PostWanted(Band: TBand; Mult : string);
var str : string;
begin
  str := ZLinkHeader + ' POSTWANTED '+ IntToStr(Ord(Band))+' ' + Mult;
  WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TZlinkForm.DelWanted(Band: TBand; Mult : string);
var str : string;
begin
  str := ZLinkHeader + ' DELWANTED '+ IntToStr(Ord(Band))+' ' + Mult;
  WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TZlinkForm.PushRemoteConnect;
var str : string;
begin
  str := ZLinkHeader + ' CONNECTCLUSTER';
  WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TZLinkForm.SendMergeTempList;
var count, i : integer;
    qid : TQSOID;
    str : string;
begin
  count := MergeTempList.Count;
  if count = 0 then
    begin
      MergeTempList.Free;
      exit;
    end;
  i := 0;
  str := '';
  while i <= count - 1 do
    begin
      repeat
        qid := TQSOID(MergeTempList[i]);
        str := str + IntToStr(qid.FullQSOID)+' ';
        qid.free;
        inc(i);
      until (i = count) or (i mod 20 = 0);
      WriteData(ZLinkHeader+' '+'GETLOGQSOID '+str+LineBreakCode[ord(Console.LineBreak)]);
      str := ''; // 2.0q
    end;
  WriteData(ZLinkHeader+' '+'SENDRENEW'+LineBreakCode[ord(Console.LineBreak)]);
  MergeTempList.Free;
end;

procedure TZLinkForm.ProcessCommand;
var temp, temp2 : string;
    aQSO : TQSO;
    i, j : integer;
    B : TBand;
    qid : TQSOID;
    boo, needtorenew : boolean;
begin
  while CommandQue.Count > 0 do
    begin
      temp := CommandQue.Strings[0];
      temp := copy(temp, length(ZLinkHeader)+2, 255);

      {if pos('TRANSPARENT', temp) = 1 then
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
        end;  }

      if pos('FREQ', temp) = 1 then
        begin
          temp := copy(temp, 6, 255);
          FreqList.ProcessFreqData(temp);
        end;

      if pos('QSOIDS', temp) = 1 then
        begin
          Delete(temp, 1, 7);
          i := pos(' ', temp);
          while i > 1 do
            begin
              temp2 := copy(temp, 1, i-1);
              Delete(temp, 1, i);
              j := StrToInt(temp2);
              qid := TQSOID.Create;
              qid.FullQSOID := j;
              qid.QSOIDwoCounter := j div 100;
              MergeTempList.Add(qid);
              i := pos(' ', temp);
            end;
        end;

      if pos('ENDQSOIDS', temp) = 1 then
        begin
          for i := 1 to Log.TotalQSO do
            begin
              aQSO := TQSO(Log.List[i]);

              boo := false;
              needtorenew := false;
              for j := 0 to MergeTempList.Count - 1 do
                begin
                  qid := TQSOID(MergeTempList[j]);
                  if (aQSO.QSO.Reserve3 div 100) = qid.QSOIDwoCounter then
                    begin
                      if aQSO.QSO.Reserve3 = qid.FullQSOID then // exactly the same qso
                        begin
                          MergeTempList.Delete(j);
                          qid.free;
                          boo := true;
                          break;
                        end
                      else // counter is different
                        begin
                          if qid.FullQSOID > aQSO.QSO.Reserve3 then // serverdata is newer
                            begin
                              boo := true;
                              WriteData(ZLinkHeader+' '+'SENDQSOIDEDIT '+
                                        IntToStr(qid.FullQSOID)+LineBreakCode[ord(Console.LineBreak)]);
                              qid.free;
                              break;
                              // qid qso must be sent as editqsoto command;
                            end
                          else  // local data is newer
                            begin
                              boo := true;
                              MergeTempList.Delete(j);
                              WriteData(ZLinkHeader+' '+'EDITQSOTO '+aQSO.QSOinText+LineBreakCode[ord(Console.LineBreak)]);
                              qid.free;
                              break;
                              // aQSO moved to ToSendList (but edit)
                              // or just ask to send immediately
                            end;
                        end;
                    end;
                end;
                if boo = false then
                  begin
                    SendQSO_PUTLOG(aQSO);
                    needtorenew := true;
                    // add aQSO to ToSendList;
                    // or just send putlog ...
                    // renew after done.
                  end;
            end;
          // getqsos from MergeTempList; (whatever is left)
          // Free MergeTempList;
          if needtorenew then
            WriteData(ZLinkHeader+' '+'RENEW'+LineBreakCode[ord(Console.LineBreak)]);
          SendMergeTempList;
        end;

      if pos('PROMPTUPDATE', temp) = 1 then  // file loaded on ZServer
        begin
         { if MessageDlg('The file on Z-Server has been updated. Do you want to download the data now?',
                           mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            LoadLogFromZServer; }
        end;
      if pos('NEWPX', temp) = 1 then
        begin
          Delete(temp, 1, 6);
          try
            i := StrToInt(TrimRight(copy(temp, 1, 6)));
          except
            on EConvertError do
              i := -1;
          end;
          if i >= 0 then
            begin
              Delete(temp, 1, 6);
              if temp <> '' then
                MyContest.MultiForm.AddNewPrefix(temp, i);
            end;
        end;
      if pos('PUTMESSAGE', temp) = 1 then
        begin
          Delete(temp, 1, 11);
          if pos('!', temp) = 1 then
            begin
              Delete(temp, 1, 1);
              MainForm.WriteStatusLineRed(temp, true);
            end
          else
            MainForm.WriteStatusLine(temp, false);
          ChatForm.Add(temp);
        end;
      if pos('POSTWANTED', temp) = 1 then
        begin
          temp := copy(temp, 12, 255);
          MyContest.PostWanted(temp);
        end;
      if pos('DELWANTED', temp) = 1 then
        begin
          temp := copy(temp, 11, 255);
          MyContest.DelWanted(temp);
        end;
      if pos('SPOT ', temp) = 1 then
        begin
          temp := copy(temp, 6, 255);
          CommForm.PreProcessSpotFromZLink(temp);
        end;
      if pos('BSDATA ', temp) = 1 then
        begin
          temp := copy(temp, 8, 255);
          BandScope2.ProcessBSDataFromNetwork(temp);
        end;
      if pos('SENDSPOT ', temp) = 1 then
        begin
          temp := copy(temp, 10, 255);
          CommForm.WriteLine(temp);
        end;
      if pos('SENDCLUSTER ', temp) = 1 then // remote manipulation of cluster console
        begin
          temp := copy(temp, 13, 255);
          CommForm.WriteLine(temp);
        end;
      if pos('SENDPACKET ', temp) = 1 then
        begin
          temp := copy(temp, 12, 255);
          CommForm.WriteLineConsole(temp);
        end;
      if pos('SENDSCRATCH ', temp) = 1 then
        begin
          temp := copy(temp, 13, 255);
          ScratchSheet.AddBuffer(temp);
          ScratchSheet.Update;
        end;
       if pos('CONNECTCLUSTER', temp) = 1 then
         begin
           CommForm.RemoteConnectButtonPush;
         end;
      if pos('PUTQSO ', temp) = 1 then
        begin
          aQSO := TQSO.Create;
          temp := copy(temp, 8, 255);
          aQSO.TextToQSO(temp);
          MyContest.LogQSO(aQSO, False);
          aQSO.Free;
        end;
      if pos('DELQSO ', temp) = 1 then
        begin
          aQSO := TQSO.Create;
          Delete(temp, 1, 7);
          //temp := copy(temp, 8, 255);
          aQSO.TextToQSO(temp);
          aQSO.QSO.Reserve := actDelete;
          Log.AddQue(aQSO);
          Log.ProcessQue;
          MyContest.Renew;
          MainForm.EditScreen.Renew;
          aQSO.Free;
        end;
      if pos('INSQSOAT ', temp) = 1 then
        begin
          aQSO := TQSO.Create;
          Delete(temp, 1, 9);
          aQSO.TextToQSO(temp);
          aQSO.QSO.Reserve := actInsert;
          Log.AddQue(aQSO);
          //Log.ProcessQue;
          //MyContest.Renew;
          aQSO.Free;
        end;
      if pos('LOCKQSO', temp) = 1 then
        begin
          aQSO := TQSO.Create;
          temp := copy(temp, 9, 255);
          aQSO.TextToQSO(temp);
          aQSO.QSO.Reserve := actLock;
          Log.AddQue(aQSO);
          Log.ProcessQue;
          MyContest.Renew;
          aQSO.Free;
        end;
      if pos('UNLOCKQSO', temp) = 1 then
        begin
          aQSO := TQSO.Create;
          temp := copy(temp, 11, 255);
          aQSO.TextToQSO(temp);
          aQSO.QSO.Reserve := actUnlock;
          Log.AddQue(aQSO);
          Log.ProcessQue;
          MyContest.Renew;
          aQSO.Free;
        end;
      if pos('EDITQSOTO ', temp) = 1 then
        begin
          aQSO := TQSO.Create;
          temp := copy(temp, 11, 255);
          aQSO.TextToQSO(temp);
          aQSO.QSO.Reserve := actEdit;
          Log.AddQue(aQSO);
          Log.ProcessQue;
          MyContest.Renew;
          MainForm.EditScreen.Renew;
          aQSO.Free;
        end;
      if pos('INSQSO ', temp) = 1 then
        begin
          aQSO := TQSO.Create;
          Delete(temp, 1, 7);
          aQSO.TextToQSO(temp);
          aQSO.QSO.Reserve := actInsert;
          Log.AddQue(aQSO);
          Log.ProcessQue;
          MyContest.Renew;
          MainForm.EditScreen.Renew;
          aQSO.Free;
        end;
      if pos('PUTLOG ', temp) = 1 then
        begin
          //ZLinkForm.caption := 'PUTLOG';
          aQSO := TQSO.Create;
          Delete(temp, 1, 7);
          aQSO.TextToQSO(temp);
          aQSO.QSO.Reserve := actAdd;
          Log.AddQue(aQSO);
          aQSO.Free;
        end;
      if pos('RENEW', temp) = 1 then
        begin
          Log.ProcessQue;
          MyContest.Renew;
          MainForm.EditScreen.Renew;
        end;
      if pos('SENDLOG', temp) = 1 then
        begin
          for i := 1 to Log.TotalQSO do
            begin
              //repeat until AsyncComm.OutQueCount = 0;
              SendQSO_PUTLOG(TQSO(Log.List[i]));
            end;
          //repeat until AsyncComm.OutQueCount = 0;
          WriteData(ZLinkHeader+' '+'RENEW'+LineBreakCode[ord(Console.LineBreak)]);
        end;
      CommandQue.Delete(0);
    end;
end;

procedure TZLinkForm.DeleteQSO(aQSO : TQSO);
var
   str : string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1..7] then begin
      str := ZLinkHeader + ' DELQSO '+aQSO.QSOinText;
      WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.LockQSO(aQSO : TQSO);
var
   str : string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1..7] then begin
      // aQSO.QSO.Reserve := actLock;
      str := ZLinkHeader + ' LOCKQSO '+aQSO.QSOinText;
      WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.UnLockQSO(aQSO : TQSO);
var
   str : string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1..7] then begin
      // aQSO.QSO.Reserve := actUnLock;
      str := ZLinkHeader + ' UNLOCKQSO '+aQSO.QSOinText;
      WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.SendBand;
var
   str : string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1..7] then begin
      str := ZLinkHeader + ' BAND '+IntToStr(ord(Main.CurrentQSO.QSO.Band));
      WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.SendOperator;
var
   str : string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1..7] then begin
      str := ZLinkHeader + ' OPERATOR '+Main.CurrentQSO.QSO.Operator;
      WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.SendFreqInfo(Hz : Integer);
var
   str : string;
begin
   if Hz = 0 then
      exit;

   if dmZlogGlobal.Settings._zlinkport in [1..7] then begin
      if Hz > 60000 then
        str := RigControl.StatusSummaryFreq(round(Hz / 1000))
      else
        str := RigControl.StatusSummaryFreqHz(Hz);

      if str = '' then
        exit;

      FreqList.ProcessFreqData(str);
      str := ZLinkHeader + ' FREQ '+ str;
      WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.SendRigStatus;
var
   str : string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1..7] then begin
      str := RigControl.StatusSummary;
      if str = '' then begin
         exit;
      end;

      FreqList.ProcessFreqData(str);
      str := ZLinkHeader + ' FREQ '+ str;
      WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.RelaySpot(S : string);
var
   str : string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1..7] then begin
      str := ZLinkHeader + ' SPOT '+S;
      WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.SendSpotViaNetwork(S : string);
var
   str : string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1..7] then begin
      str := ZLinkHeader + ' SENDSPOT '+S;
      WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.SendQSO(aQSO : TQSO);
var
   str : string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1..7] then begin
      str := ZLinkHeader + ' PUTQSO '+aQSO.QSOinText;
      WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.SendQSO_PUTLOG(aQSO : TQSO);
var
   str : string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1..7] then begin
      str := ZLinkHeader + ' PUTLOG '+aQSO.QSOinText;
      WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.EditQSObyID(aQSO : TQSO);
var
   str : string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1..7] then begin
      str := ZLinkHeader + ' EDITQSOTO ' +aQSO.QSOinText;
      WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.InsertQSO(bQSO : TQSO);
var
   str : string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1..7] then begin
      //repeat until AsyncComm.OutQueCount = 0;
      str := ZLinkHeader + ' INSQSO ' +bQSO.QSOinText;
      WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
   end;
end;

procedure TZLinkForm.CommProcess;
var
   max , i, j, x : integer;
   str, currstr : string;
begin
   CommProcessing := True;
   max := CommBuffer.Count - 1;
   if max < 0 then begin
      CommProcessing := False;
      exit;
   end;

   for i := 0 to max do begin
      Console.WriteString(CommBuffer.Strings[i]);
   end;

   for i := 0 to max do begin
      str := CommBuffer.Strings[0];
      for j := 1 to length(str) do begin
         if str[j] = Chr($0D) then begin
            x := Pos(ZLinkHeader, CommTemp);
            if x > 0 then begin
               //MainForm.WriteStatusLine(CommTemp);
               //CHATFORM.ADD(COMMTEMP);
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

   CommProcessing := False;
end;

procedure TZLinkForm.FormCreate(Sender: TObject);
begin
   //Transparent := False;
   DisconnectedByMenu := False;
   CommProcessing := False;
   MergeTempList := nil;

   if dmZlogGlobal.Settings._zlinkport in [1..6] then begin
      //Transparent := True; // rs-232c
      // no rs232c allowed!
   end;

   CommStarted := False;
   CommBuffer := TStringList.Create;
   CommandQue := TStringList.Create;
   CommTemp := '';
   Timer1.Enabled := True;
   ImplementOptions;
end;

procedure TZLinkForm.ImplementOptions;
begin
   try
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
   boo: Boolean;
begin
   boo := dmZlogGlobal.Settings._zlink_telnet.FLocalEcho;

   if Key = Chr($0D) then begin
      WriteData(Edit.Text+LineBreakCode[ord(Console.LineBreak)]);
      if boo then begin
         Console.WriteString(Edit.Text+LineBreakCode[ord(Console.LineBreak)]);
      end;

      Key := Chr($0);
      Edit.Text := '';
   end;
end;

procedure TZLinkForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE : MainForm.LastFocus.SetFocus;
   end;
end;

function TZLinkForm.ZServerConnected : boolean;
begin
   Result := (ZSocket.State = wsConnected);
end;

procedure TZLinkForm.ButtonClick(Sender: TObject);
begin
   if (ZSocket.State = wsConnected) then begin
      Button.Caption := 'Disconnecting...';
      ZSocket.Close;
   end
   else begin
      Button.Caption := 'Connecting...';
      ZSocket.Addr := dmZlogGlobal.Settings._zlink_telnet.FHostName;
      ZSocket.Port := 'telnet';
      ZSocket.Connect;
   end;
end;

procedure TZLinkForm.Button3Click(Sender: TObject);
var
   i : integer;
begin
   for i := 1 to Log.TotalQSO do begin
      //repeat until AsyncComm.OutQueCount = 0;
      SendQSO(TQSO(Log.List[i]));
   end;

   //repeat until AsyncComm.OutQueCount = 0;
   WriteData(ZLinkHeader+' '+'RENEW'+LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TZLinkForm.LoadLogFromZLink;
var R : word;
begin
   R := MessageDlg('This will delete all data and loads data using Z-Link', mtConfirmation,
                  [mbOK, mbCancel], 0); {HELP context 0}
   if R = mrCancel then begin
      exit;
   end;

   Log.Clear;
   WriteData(ZLinkHeader+' '+'SENDLOG'+LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TZLinkForm.GetCurrentBandData(B : TBand);
var
   str : string;
begin
   str := ZLinkHeader + ' SENDCURRENT ' + IntToStr(Ord(B));
   //repeat until AsyncComm.OutQueCount = 0;
   WriteData(str+LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TZLinkForm.ZSocketDataAvailable(Sender: TObject; Error: Word);
var
   Buf : array[0..2047] of AnsiChar;
   str : string;
   Count, i : integer;
   P: PAnsiChar;
begin
   if Error <> 0 then begin
      exit;
   end;

   Count := TWSocket(Sender).Receive(@Buf, SizeOf(Buf)-1);
   if Count <= 0 then begin
      exit;
   end;

   Buf[Count] := #0;
   P := @Buf[0];
   str := StrPas(P);
   CommBuffer.Add(str);
end;

procedure TZLinkForm.ZSocketSessionClosed(Sender: TObject; Error: Word);
var
   R : word;
begin
   Console.WriteString('disconnected...');
   Button.Caption := 'Connect';
   MainForm.ConnectToZServer1.Caption := 'Connect to Z-Server';
   MainForm.ZServerIcon.Visible := False;
   MainForm.DisableNetworkMenus;

   if DisconnectedByMenu = False then begin
      R := MessageDlg('Z-Server connection failed.', mtError,
                  [mbOK], 0); {HELP context 0}
   end
   else begin
      DisconnectedByMenu := False;
   end;
end;

procedure TZLinkForm.ZSocketSessionConnected(Sender: TObject; Error: Word);
begin
   Button.Caption := 'Disconnect';
   MainForm.ConnectToZServer1.Caption := 'Disconnect Z-Server'; // 0.23
   Console.WriteString('connected to '+ZSocket.Addr+LineBreakCode[ord(Console.LineBreak)]);
   SendBand; {tell Z-Server current band}
   SendOperator;
   ZServerInquiry.ShowModal;
   MainForm.ZServerIcon.Visible := True;
   MainForm.EnableNetworkMenus;
end;

end.
