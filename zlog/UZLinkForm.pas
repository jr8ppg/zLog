unit UZLinkForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, UITypes, System.NetEncoding, Generics.Collections,
  OverbyteIcsWndControl, OverbyteIcsWSocket, OverbyteIcsTypes,
  UzLogConst, UzLogGlobal, UzLogQSO, UScratchSheet, HelperLib;

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
    Timer1: TTimer;
    ZSocket: TWSocket;
    Console: TListBox;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    CommStarted : boolean;

    FCommBuffer : TStringList;
    FCommandQue : TStringList;

    FLineBreak: string;

    // temporary list to hold Z-Server QSOID list
    // created when GETQSOIDS is issued and destroyed
    // when all merge process is finished. List of TQSOID
    FMergeTempList: TDictionary<Integer, TQSOID>;

    FDownloadFileName: string;
    FFileData: TStringList;

    procedure EnableConnectButton(boo : boolean);
    procedure CommProcess;
    procedure ProcessCommand;
    procedure QsoIDsProc(S: string);
    procedure EndQsoIDsProc();
    procedure SendMergeTempList; // request to send the qsos in the MergeTempList
    procedure SendQSO_PUTLOG(aQSO : TQSO);
    procedure Process_PutFileOk();
    procedure Process_PutFile(S: string);
    procedure AddConsole(str: string);
  public
    { Public declarations }
    DisconnectedByMenu : boolean;
    procedure ImplementOptions;
    procedure WriteData(str : string);
    procedure SendBand; {Sends current band (to Z-Server) #ZLOG# BAND 3 etc}
    procedure SendOperator;
    procedure SendPcName();
    procedure SendQSO(aQSO : TQSO);
    procedure RelaySpot(S : string); //called from CommForm to relay spot info
    procedure SendSpotViaNetwork(S : string);
    procedure SendFreqInfo(Hz: TFrequency);
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
    procedure GetFile(filename: string; download_folder: string);
    procedure PutFile(filepath: string);
  end;

resourcestring
  This_will_delete_all_data_and_loads_data_using_zlink = 'This will delete all data and loads data using Z-Link';
  ZServer_connection_failed = 'Z-Server connection failed.';
  Connect_ZSERVER = 'Connect to Z-Server';
  Disconnect_ZSERVER = 'Disconnect from Z-Server';
  FileDownloadFailed = 'File download failed. (%s)';
  FileDownloadSuccessfully = 'File download completed successfully.';
  NoFilesFoundToUpload = 'No files found to upload.';
  FileUploadSuccessfully = 'File upload completed successfully.';

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
      ZSocket.SendStr(str + FLineBreak);
   end;
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

procedure TZLinkForm.MergeLogWithZServer;
var
   str: string;
begin
   str := ZLinkHeader + ' BEGINMERGE';
   WriteData(str + FLineBreak);
end;

procedure TZLinkForm.SendRemoteCluster(S: string);
var
   str: string;
begin
   str := ZLinkHeader + ' SENDCLUSTER ' + S;
   WriteData(str + FLineBreak);
end;

procedure TZLinkForm.SendPacketData(S: string);
var
   str: string;
begin
   str := ZLinkHeader + ' SENDPACKET ' + S;
   WriteData(str + FLineBreak);
end;

procedure TZLinkForm.SendScratchMessage(S: string);
var
   str: string;
begin
   str := ZLinkHeader + ' SENDSCRATCH ' + S;
   WriteData(str + FLineBreak);
end;

procedure TZLinkForm.SendBandScopeData(BSText: string);
var
   str: string;
begin
   str := ZLinkHeader + ' BSDATA ' + BSText;
   WriteData(str + FLineBreak);
end;

procedure TZLinkForm.PostWanted(Band: TBand; Mult: string);
var
   str: string;
begin
   str := ZLinkHeader + ' POSTWANTED ' + IntToStr(Ord(Band)) + ' ' + Mult;
   WriteData(str + FLineBreak);
end;

procedure TZLinkForm.DelWanted(Band: TBand; Mult: string);
var
   str: string;
begin
   str := ZLinkHeader + ' DELWANTED ' + IntToStr(Ord(Band)) + ' ' + Mult;
   WriteData(str + FLineBreak);
end;

procedure TZLinkForm.PushRemoteConnect;
var
   str: string;
begin
   str := ZLinkHeader + ' CONNECTCLUSTER';
   WriteData(str + FLineBreak);
end;

procedure TZLinkForm.SendMergeTempList;
var
   count, i: integer;
   qid: TQSOID;
   str: string;
   list: TArray<TPair<Integer,TQSOID>>;
begin
   try
      count := FMergeTempList.Count;
      if count = 0 then begin
         Exit;
      end;

      list := FMergeTempList.ToArray();

      i := 0;
      str := '';
      while i <= count - 1 do begin
         repeat
            qid := list[i].Value;
            str := str + IntToStr(qid.FullQSOID) + ' ';
            inc(i);
         until (i = count) or (i mod 20 = 0);
         WriteData(ZLinkHeader + ' ' + 'GETLOGQSOID ' + str);
         str := ''; // 2.0q
      end;

      WriteData(ZLinkHeader + ' ' + 'SENDRENEW');
   finally
      for i := 0 to Length(list) - 1 do begin
         list[i].Value.Free();
      end;
      FMergeTempList.Free();
   end;
end;

procedure TZLinkForm.ProcessCommand;
var
   temp: string;
   aQSO: TQSO;
   i: integer;
   str: string;
begin
   while FCommandQue.Count > 0 do begin
      temp := FCommandQue.Strings[0];
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

      if pos('BEGINMERGE-OK', temp) = 1 then begin
         str := ZLinkHeader + ' GETQSOIDS';
         FMergeTempList := TDictionary<Integer,TQSOID>.Create();
         WriteData(str);
      end;

      if pos('BEGINMERGE-NG', temp) = 1 then begin
         //
      end;

      if pos('QSOIDS', temp) = 1 then begin
         Delete(temp, 1, 7);
         QsoIDsProc(temp);
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
         if (aQSO.Callsign <> '') and (Log.CheckQSOID(aQSO.Reserve3) = False) then begin
            MyContest.LogQSO(aQSO, false);
            MainForm.GridRefreshScreen(False, True);
            MainForm.BandScopeNotifyWorked(aQSO);
         end
         else begin
            dmZLogGlobal.WriteErrorLog('TZLinkForm.ProcessCommand)');
            dmZLogGlobal.WriteErrorLog(temp);
         end;
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
         MainForm.GridRefreshScreen(False, True);
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
         MainForm.GridRefreshScreen(False, True);
         aQSO.Free;
      end;

      if pos('PUTLOGEX ', temp) = 1 then begin
         aQSO := TQSO.Create;
         Delete(temp, 1, 9);
         aQSO.TextToQSO(temp);
         if (Log.CheckQSOID(aQSO.Reserve3) = False) then begin
            aQSO.Reserve := actEditOrAdd;
            Log.AddQue(aQSO);
         end;
         aQSO.Free;
      end;

      if pos('PUTLOG ', temp) = 1 then begin
         aQSO := TQSO.Create;
         Delete(temp, 1, 7);
         aQSO.TextToQSO(temp);
         if (Log.CheckQSOID(aQSO.Reserve3) = False) then begin
            aQSO.Reserve := actAdd;
            Log.AddQue(aQSO);
         end;
         aQSO.Free;
      end;

      if pos('RENEW', temp) = 1 then begin
         Log.ProcessQue;
         Log.SortBy(soTime);
         Log.RebuildDupeCheckList();
         MainForm.RenewScore();
      end;

      if pos('SENDLOG', temp) = 1 then begin
         for i := 1 to Log.TotalQSO do begin
            // repeat until AsyncComm.OutQueCount = 0;
            SendQSO_PUTLOG(Log.QsoList[i]);
         end;
         // repeat until AsyncComm.OutQueCount = 0;
         WriteData(ZLinkHeader + ' ' + 'RENEW');
      end;

      if pos('PUTFILE-OK', temp) = 1 then begin
         Process_PutFileOk();
      end
      else if Pos('PUTFILE', temp) = 1 then begin
         Process_PutFile(temp);
      end;

      if Pos('FILEDATA', temp) = 1 then begin
         Delete(temp, 1, 9);
         FFileData.Add(temp);
      end;

      FCommandQue.Delete(0);
   end;
end;

procedure TZLinkForm.DeleteQSO(aQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' DELQSO ' + aQSO.QSOinText;
      WriteData(str);
   end;
end;

procedure TZLinkForm.DeleteQsoEx(aQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' EXDELQSO ' + aQSO.QSOinText;
      WriteData(str);
   end;
end;

procedure TZLinkForm.Renew();
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' RENEW ';
      WriteData(str);
   end;
end;

procedure TZLinkForm.LockQSO(aQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      // aQSO.QSO.Reserve := actLock;
      str := ZLinkHeader + ' LOCKQSO ' + aQSO.QSOinText;
      WriteData(str);
   end;
end;

procedure TZLinkForm.UnLockQSO(aQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      // aQSO.QSO.Reserve := actUnLock;
      str := ZLinkHeader + ' UNLOCKQSO ' + aQSO.QSOinText;
      WriteData(str);
   end;
end;

procedure TZLinkForm.SendBand;
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' BAND ' + IntToStr(Ord(Main.CurrentQSO.Band));
      WriteData(str);
   end;
end;

procedure TZLinkForm.SendOperator;
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' OPERATOR ' + Main.CurrentQSO.Operator;
      WriteData(str);
   end;
end;

procedure TZLinkForm.SendPcName();
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' PCNAME ' + dmZlogGlobal.Settings._pcname;
      WriteData(str);
   end;
end;

procedure TZLinkForm.SendFreqInfo(Hz: TFrequency);
var
   str: string;
begin
   if Hz = 0 then
      exit;

   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
//      if Hz > 60000 then
//         str := MainForm.RigControl.StatusSummaryFreq(round(Hz / 1000))
//      else
//         str := MainForm.RigControl.StatusSummaryFreqHz(Hz);

      str := MainForm.RigControl.StatusSummaryFreqHz(Hz);
      if str = '' then
         exit;

      MainForm.FreqList.ProcessFreqData(str);
      str := ZLinkHeader + ' FREQ ' + str;
      WriteData(str);
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
      WriteData(str);
   end;
end;

procedure TZLinkForm.RelaySpot(S: string);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' SPOT ' + S;
      WriteData(str);
   end;
end;

procedure TZLinkForm.SendSpotViaNetwork(S: string);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' SENDSPOT ' + S;
      WriteData(str);
   end;
end;

procedure TZLinkForm.SendQSO(aQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' PUTQSO ' + aQSO.QSOinText;
      WriteData(str);
   end;
end;

procedure TZLinkForm.SendQSO_PUTLOG(aQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' PUTLOG ' + aQSO.QSOinText;
      WriteData(str);
   end;
end;

procedure TZLinkForm.EditQSObyID(aQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      str := ZLinkHeader + ' EDITQSOTO ' + aQSO.QSOinText;
      WriteData(str);
   end;
end;

procedure TZLinkForm.InsertQSO(bQSO: TQSO);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      // repeat until AsyncComm.OutQueCount = 0;
      str := ZLinkHeader + ' INSQSO ' + bQSO.QSOinText;
      WriteData(str);
   end;
end;

procedure TZLinkForm.QsoIDsProc(S: string);
var
   i: Integer;
   j: Integer;
   temp2: string;
   qid: TQSOID;
begin
   i := pos(' ', S);
   while i > 1 do begin
      temp2 := copy(S, 1, i - 1);
      Delete(S, 1, i);
      j := StrToInt(temp2);

      qid := TQSOID.Create;
      qid.FullQSOID := j;
      qid.QSOIDwoCounter := j div 100;

      if FMergeTempList.ContainsKey(qid.QSOIDwoCounter) = False then begin
         FMergeTempList.Add(qid.QSOIDwoCounter, qid);
      end
      else begin
         qid.Free();
      end;

      i := pos(' ', S);
   end;
end;

procedure TZLinkForm.EndQsoIDsProc();
var
   aQSO: TQSO;
   fFoundQso: Boolean;
   fNeedToRenew: Boolean;
   i: Integer;
   qid: TQSOID;
   qsoid: Integer;
begin
   fNeedToRenew := False;

   for i := 1 to Log.TotalQSO do begin
      aQSO := Log.QsoList[i];

      fFoundQso := False;

      qsoid := aQSO.Reserve3 div 100;

      if FMergeTempList.TryGetValue(qsoid, qid) = True then begin
         fFoundQso := True;

         if aQSO.Reserve3 = qid.FullQSOID then begin // exactly the same qso
            FMergeTempList.Remove(qsoid);
            qid.Free;
         end
         else begin // counter is different
            if qid.FullQSOID > aQSO.Reserve3 then begin // serverdata is newer
               // qid qso must be sent as editqsoto command;
            end
            else begin // local data is newer
               FMergeTempList.Remove(qsoid);
               qid.Free;

               WriteData(ZLinkHeader + ' ' + 'EDITQSOTO ' + aQSO.QSOinText);
               // aQSO moved to ToSendList (but edit)
               // or just ask to send immediately
            end;
         end;
      end;

      if fFoundQso = False then begin
         SendQSO_PUTLOG(aQSO);
         // add aQSO to ToSendList;
         // or just send putlog ...
         // renew after done.
      end;

      fNeedToRenew := true;
   end;

   // getqsos from MergeTempList; (whatever is left)
   // Free MergeTempList;
   if fNeedToRenew then begin
      WriteData(ZLinkHeader + ' ' + 'RENEW');
   end;

   SendMergeTempList;

   // マージ終了
   WriteData(ZLinkHeader + ' ' + 'ENDMERGE');
end;

procedure TZLinkForm.CommProcess;
var
   x: integer;
   strTemp: string;
begin
   CommProcessing := true;

   while FCommBuffer.Count > 0 do begin
      strTemp := FCommBuffer.Strings[0];

      x := pos(ZLinkHeader, strTemp);
      if x > 0 then begin
         strTemp := copy(strTemp, x, 255);
         FCommandQue.Add(strTemp);
      end
      else begin
         dmZLogGlobal.WriteErrorLog('TZLinkForm.CommProcess()');
         dmZLogGlobal.WriteErrorLog(strTemp);
      end;

      FCommBuffer.Delete(0);
   end;

   ProcessCommand;

   CommProcessing := false;
end;

procedure TZLinkForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   MainForm.DelTaskbar(Handle);
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

   CommStarted := False;
   FCommBuffer := TStringList.Create();
   FCommandQue := TStringList.Create();
   FFileData := TStringList.Create();
   Timer1.Enabled := True;

   ImplementOptions;

   FLineBreak := LineBreakCode[dmZlogGlobal.Settings._zlink_telnet.FLineBreak];
end;

procedure TZLinkForm.FormDestroy(Sender: TObject);
begin
   FCommBuffer.Free();
   FCommandQue.Free();
   FFileData.Free();
end;

procedure TZLinkForm.EnableConnectButton(boo : boolean);
begin
   ConnectButton.Enabled := boo;
end;

procedure TZLinkForm.ImplementOptions;
begin
   try
      EnableConnectButton((dmZlogGlobal.Settings._zlinkport = 1) and (dmZlogGlobal.Settings._zlink_telnet.FHostName <> ''));
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
      WriteData(Edit.Text);
      if boo then begin
         AddConsole(Edit.Text);
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

procedure TZLinkForm.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);
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
         AddConsole(E.Message);
      end;
   end;
end;

procedure TZLinkForm.LoadLogFromZLink;
var
   R: Word;
begin
   R := MessageDlg(This_will_delete_all_data_and_loads_data_using_zlink, mtConfirmation, [mbOK, mbCancel], 0); { HELP context 0 }
   if R = mrCancel then begin
      exit;
   end;

   Log.Clear2();
   WriteData(ZLinkHeader + ' ' + 'SENDLOG');
end;

procedure TZLinkForm.ZSocketDataAvailable(Sender: TObject; Error: Word);
var
   Buf: array [0 .. 2047] of AnsiChar;
   str: string;
   count: integer;
   P: PAnsiChar;
   st: Integer;
   line: string;
   i: Integer;
begin
   ZeroMemory(@Buf, SizeOf(Buf));
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

   st := 1;
   for i := 1 to Length(str) do begin
      if str[i] = #10 then begin
         line := TrimCRLF(Copy(str, st, i - st + 1));
         AddConsole(line);
         FCommBuffer.Add(line);
         st := i + 1;
      end;
   end;

   line := TrimCRLF(Copy(str, st));
   if line <> '' then begin
      AddConsole(line);
      FCommBuffer.Add(line);
   end;
end;

procedure TZLinkForm.ZSocketSessionClosed(Sender: TObject; Error: Word);
begin
   AddConsole('disconnected...');
   ConnectButton.Caption := 'Connect';
   MainForm.menuConnectToZServer.Caption := Connect_ZSERVER;
   MainForm.ZServerIcon.Visible := false;
   MainForm.DisableNetworkMenus;
   MainForm.ChatForm.SetConnectStatus(False);

   if DisconnectedByMenu = false then begin
      MessageDlg(ZServer_connection_failed, mtError, [mbOK], 0); { HELP context 0 }
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
   MainForm.menuConnectToZServer.Caption := Disconnect_ZSERVER; // 0.23
   AddConsole('connected to ' + ZSocket.Addr);
   SendBand; { tell Z-Server current band }
   SendOperator;
   SendPcName();
   MainForm.ZServerInquiry.ShowModal;
   MainForm.ZServerIcon.Visible := true;
   MainForm.EnableNetworkMenus;
   MainForm.ChatForm.SetConnectStatus(True);
end;

procedure TZLinkForm.GetFile(filename: string; download_folder: string);
var
   str: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      if DirectoryExists(download_folder) = False then begin
         ForceDirectories(download_folder);
      end;

      FDownloadFileName := IncludeTrailingPathDelimiter(download_folder) + filename;

      str := ZLinkHeader + ' GETFILE ' + filename;
      WriteData(str);
   end;
end;

procedure TZLinkForm.Process_PutFile(S: string);
var
   mem: TMemoryStream;
   base64: TBase64Encoding;
   sl: TStringList;
   i: Integer;
   str: string;
   file_name: string;
   file_size: Integer;
   line_count: Integer;
   bytes: TBytes;
   bakfile: string;
   text1: string;
   text2: string;
begin
   Delete(S, 1, 8);

   base64 := TBase64Encoding.Create();
   mem := TMemoryStream.Create();
   sl := TStringList.Create();
   sl.StrictDelimiter := True;
   try
      sl.CommaText := Trim(S) + ',,,';
      file_name := sl[0];
      file_size := StrToIntDef(sl[1], 0);
      line_count := StrToIntDef(sl[2], 0);

      if (sl[0] = 'ERROR') then begin
         text1 := Format(FileDownloadFailed, [sl[1]]);
         PostMessage(MainForm.Handle, WM_ZLOG_SHOWMESSAGE, WPARAM(PChar(text1)), MB_OK or MB_ICONEXCLAMATION);
         Exit;
      end;

      sl.Clear();
      for i := 0 to FFileData.Count - 1 do begin
         Application.ProcessMessages();
         str := FFileData[i];
         sl.Add(str);
      end;

      bytes := base64.DecodeStringToBytes(sl.Text);

      mem.Size := Length(bytes);
      mem.Position := 0;
      mem.WriteBuffer(bytes, Length(bytes));

      file_name := ExtractFilePath(FDownloadFileName) + file_name;

      if FileExists(file_name) = True then begin
         bakfile := ChangeFileExt(file_name, '.' + FormatDateTime('yyyymmddhhnnss', Now));
         CopyFile(PChar(file_name), PChar(bakfile), False);
      end;

      mem.SaveToFile(file_name);

      {$IFDEF DEBUG}
      FFileData.SaveToFile(ChangeFileExt(file_name, '.txt'));
      {$ENDIF}

      FFileData.Clear();

      text1 := FileDownloadSuccessfully;
      text2 := ExtractFileName(file_name);
      PostMessage(MainForm.Handle, WM_ZLOG_FILEDOWNLOAD_COMPLETE, WPARAM(PChar(text1)), LPARAM(PChar(text2)));
   finally
      mem.Free();
      base64.Free();
      sl.Free();
   end;
end;

procedure TZLinkForm.PutFile(filepath: string);
var
   sl: TStringList;
   file_size: Integer;
   line_count: Integer;
   i: Integer;
   base64: TBase64Encoding;
   mem: TMemoryStream;
   str: string;
   text: string;
   filename: string;
   c: Integer;
   sendbuf: string;
begin
   if dmZlogGlobal.Settings._zlinkport in [1 .. 7] then begin
      base64 := TBase64Encoding.Create();
      mem := TMemoryStream.Create();
      sl := TStringList.Create();
      try
         if FileExists(filepath) = False then begin
            text := NoFilesFoundToUpload;
            PostMessage(MainForm.Handle, WM_ZLOG_SHOWMESSAGE, WPARAM(PChar(text)), MB_OK or MB_ICONINFORMATION);
            Exit;
         end;

         filename := ExtractFileName(filepath);
         mem.LoadFromFile(filepath);
         mem.Position := 0;
         sl.Text := base64.EncodeBytesToString(mem.Memory, mem.Size);

         {$IFDEF DEBUG}
         sl.SaveToFile(ChangeFileExt(filepath, '.txt'));
         {$ENDIF}

         file_size := mem.Size;
         line_count := sl.Count;
         sendbuf := '';
         c := 0;
         for i := 0 to sl.Count - 1 do begin
            Application.ProcessMessages();

            if c >= 5000 then begin
               ZSocket.SendStr(sendbuf);

               c := 0;
               sendbuf := '';
            end;

            sendbuf := sendbuf + ZLinkHeader + ' FILEDATA ' + sl[i] + #13#10;
            Inc(c);
         end;

         ZSocket.SendStr(sendbuf);

         str := ZLinkHeader + ' PUTFILE ' + filename + ',' + IntToStr(file_size) + ',' + IntToStr(line_count);
         WriteData(str);
      finally
         mem.Free();
         base64.Free();
         sl.Free();
      end;
   end;
end;

procedure TZLinkForm.Process_PutFileOk();
var
   text: string;
begin
   text := FileUploadSuccessfully;
   PostMessage(MainForm.Handle, WM_ZLOG_SHOWMESSAGE, WPARAM(PChar(text)), MB_OK or MB_ICONINFORMATION);
end;

procedure TZLinkForm.AddConsole(str: string);
begin
   if Pos('FILEDATA', str) > 0 then begin
      Exit;
   end;

   Console.Items.BeginUpdate();
   Console.Items.Add(str);
   if Console.Items.Count > 1000 then begin
      Console.Items.Delete(0);
   end;
   Console.Items.EndUpdate();
   Console.ShowLast();
end;

end.
