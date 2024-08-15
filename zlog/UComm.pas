unit UComm;

{$I+}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, AnsiStrings, ComCtrls, Vcl.ClipBrd,
  Vcl.ExtDlgs, System.SyncObjs, System.DateUtils,
  OverbyteIcsWndControl, OverbyteIcsTnCnx, OverbyteIcsWSocket,
  USpotClass, CPDrv, UzLogConst, UzLogGlobal, UzLogQSO, HelperLib, UTelnetSetting;

const
  SPOTMAX = 20000;

type
  TCommProcessThread = class(TThread)
  private
    FParent: TForm;
  protected
    procedure Execute; override;
  public
    constructor Create(formParent: TForm);
  end;

  TCommForm = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    Edit: TEdit;
    Panel2: TPanel;
    ListBox: TListBox;
    StatusLine: TStatusBar;
    Splitter1: TSplitter;
    Telnet: TTnCnx;
    ConnectButton: TButton;
    checkAutoLogin: TCheckBox;
    checkRelaySpot: TCheckBox;
    PopupMenu: TPopupMenu;
    menuSaveToFile: TMenuItem;
    SaveTextFileDialog1: TSaveTextFileDialog;
    checkAutoReconnect: TCheckBox;
    checkRecordLogs: TCheckBox;
    popupCommand: TPopupMenu;
    menuPasteCommand: TMenuItem;
    checkUseAllowDenyLists: TCheckBox;
    timerReConnect: TTimer;
    checkIgnoreBEL: TCheckBox;
    Console: TListBox;
    TabControl1: TTabControl;
    Label1: TLabel;
    labelHostName: TLabel;
    Label2: TLabel;
    labelLoginID: TLabel;
    checkForceReconnect: TCheckBox;
    timerForceReconnect: TTimer;
    procedure CommReceiveData(Buffer: Pointer; BufferLength: Word);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure TimerProcess(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TelnetDisplay(Sender: TTnCnx; Str: String);
    procedure ConnectButtonClick(Sender: TObject);
    procedure TelnetSessionConnected(Sender: TTnCnx; Error: Word);
    procedure TelnetSessionClosed(Sender: TTnCnx; Error: Word);
    procedure FormShow(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
    procedure ListBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormActivate(Sender: TObject);
    procedure ClusterCommReceiveData(Sender: TObject; DataPtr: Pointer;
      DataSize: Cardinal);
    procedure TelnetDataAvailable(Sender: TTnCnx; Buffer: Pointer;
      Len: Integer);
    procedure ListBoxMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure menuSaveToFileClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure menuPasteCommandClick(Sender: TObject);
    procedure timerReConnectTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabControl1Change(Sender: TObject);
    procedure timerForceReconnectTimer(Sender: TObject);
  private
    { Private declarations }
    FCommBuffer : TStringList;
    FCommStarted : boolean;
    FRelayPacketData : boolean;
    FSpotListLastCleanup: TDateTime;
    FLineBreak: string;

    FUseClusterLog: Boolean;
    FClusterLog: TextFile;
    FClusterLogFileName: string;
    FDisconnectClicked: Boolean;

    FAutoLogined: Boolean;

    FCommProcessThread: TCommProcessThread;

    FSpotterList: TStringList;
    FAllowList1: TStringList;
    FAllowList2: TStringList;
    FDenyList: TStringList;

    // Auto Reconnect
    FReConnectMax: Integer;
    FReConnectCount: Integer;
    FRetryIntervalSec: Integer;
    FRetryIntervalCount: Integer;

    // Force reconnect
    FConnectTime: TDateTime;

    procedure DeleteSpot(_from, _to : integer);

    function GetFontSize(): Integer;
    procedure SetFontSize(v: Integer);

    procedure CommProcess;
    procedure ProcessSpot(Sp: TSpot);
    procedure Cleanup();

    procedure WriteData(str : string);
    procedure WriteConsole(strText: string);
    procedure AddConsole(str: string);

    function GetLocalEcho(): Boolean;
    procedure TerminateCommProcessThread();
    procedure LoadAllowDenyList();
    function DeleteControlChar(S: string): string;
    procedure SelectSite(Index: Integer);
  public
    { Public declarations }
    procedure PreProcessSpotFromZLink(S : string; N: Integer);
    procedure TransmitSpot(S : string); // local or via network
    procedure ImplementOptions();
    procedure RenewOptions();
    procedure Renew; // red or black
    procedure RemoteConnectButtonPush;
    function MaybeConnected : boolean; {returns false if port = telnet and
                                         not connected but doesn't know abt
                                         packet }

    procedure WriteLine(str : string); // adds linebreak
    procedure WriteLineConsole(str : string);
    procedure WriteStatusLine(S : string);

    procedure Disconnect();

    property FontSize: Integer read GetFontSize write SetFontSize;

    property DenyList: TStringList read FDenyList;
  end;

resourcestring
  UComm_Connect = 'Connect';
  UComm_Disconnect = 'Disconnect';
  UComm_Connecting = 'Connecting...';
  UComm_Disconnecting = 'Disconnecting...';
  UComm_SecondsLeft = '%s seconds left to reconnect';
  UComm_ExceededLimit = 'reconnection attempts exceeded limit';

var
  CommBufferLock: TCriticalSection;

implementation

uses
  Main, UOptions, UZLinkForm, URigControl, UBandScope2, UzLogSpc;

{$R *.DFM}

procedure TCommForm.DeleteSpot(_from, _to : integer);
var
   i : integer;
begin
   try
      if _from < 0 then begin
         Exit;
      end;

      if _to < _from then begin
         Exit;
      end;

      ListBox.Items.BeginUpdate();
      for i := _from to _to do begin
         TSpot(ListBox.Items.Objects[_from]).Free();
         ListBox.Items.Delete(_from);
      end;
      ListBox.Items.EndUpdate();
   finally
   end;
end;

procedure TCommForm.WriteStatusLine(S : string);
begin
   StatusLine.SimpleText := S;
end;

function TCommForm.MaybeConnected : boolean;
begin
   Result := Telnet.IsConnected;
end;

procedure TCommForm.WriteLine(str: string);
begin
   WriteData(str + FLineBreak);
end;

procedure TCommForm.WriteLineConsole(str : string);
begin
   WriteConsole(str + FLineBreak);
end;

procedure TCommForm.WriteConsole(strText: string);
begin
   AddConsole(strText);

   try
      if (checkRecordLogs.Checked = True) and (FUseClusterLog = True) then begin
         Write(FClusterLog, strText);
         Flush(FClusterLog);
      end;
   except
      on E: Exception do begin
         AddConsole(E.Message);
         FUseClusterLog := False;
         CloseFile(FClusterLog);
      end;
   end;
end;

procedure TCommForm.AddConsole(str: string);
begin
   str := DeleteControlChar(str);
   Console.Items.BeginUpdate();
   Console.Items.Add(str);
   if Console.Items.Count > 1000 then begin
      Console.Items.Delete(0);
   end;
   Console.Items.EndUpdate();
   Console.ShowLast();
end;

procedure TCommForm.WriteData(str : string);
begin
   if Telnet.IsConnected then begin
      Telnet.SendStr(str);
   end;
end;

procedure TCommForm.CommReceiveData(Buffer: Pointer; BufferLength: Word);
var
   str : string;
begin
   str := string(AnsiStrings.StrPas(PAnsiChar(Buffer)));
   CommBufferLock.Enter();
   FCommBuffer.Add(str);
   CommBufferLock.Leave();
end;

procedure TCommForm.EditKeyPress(Sender: TObject; var Key: Char);
var
   fLocalEcho: Boolean;
   s : string;
begin
   fLocalEcho := GetLocalEcho();

   s := '';
   if Key = Chr($0D) then begin
      if pos('RELAY', UpperCase(Edit.Text)) = 1 then begin
         if pos('ON', UpperCase(Edit.Text)) > 0 then begin
            FRelayPacketData := True;
         end
         else begin
            FRelayPacketData := False;
         end;

         WriteLineConsole(Edit.Text);
         exit;
      end;

      if TabControl1.Tabs.Count = 0 then begin
         MainForm.ZLinkForm.SendRemoteCluster(Edit.Text);
      end
      else begin
         WriteData(Edit.Text + FLineBreak);
      end;

      if fLocalEcho then begin
         WriteLineConsole(Edit.Text);
      end;

      Key := Chr($0);
      Edit.Text := '';
      Exit;
   end;

   case Key of
      ^A, ^B, ^C, ^D, ^E, ^F, ^G, {^H,} ^I, ^J, ^K, ^L,
      ^M, ^N, ^O, ^P, ^Q, ^R, ^S, ^T, ^U, ^V, ^W, ^X, ^Y, ^Z: begin
         s := s + Key;

         if TabControl1.Tabs.Count = 0 then begin
            MainForm.ZLinkForm.SendRemoteCluster(s);
         end
         else begin
            WriteData(s);
         end;
      end;
   end;
end;

procedure TCommForm.SelectSite(Index: Integer);
var
   i: Integer;
   setting: TTelnetSetting;
begin
   setting := TTelnetSetting(TabControl1.Tabs.Objects[Index]);

   labelHostName.Caption := setting.HostName;

   FLineBreak := LineBreakCode[setting.LineBreak];

   i := Pos(':', setting.HostName);
   if i = 0 then begin
      Telnet.Host := setting.HostName;
      Telnet.Port := IntToStr(setting.PortNumber);
   end
   else begin
      Telnet.Host := Copy(setting.HostName, 1, i - 1);
      Telnet.Port := Copy(setting.HostName, i + 1);
   end;

   if setting.LoginId = '' then begin
      labelLoginID.Caption := '<Your callsign>';
   end
   else begin
      labelLoginId.Caption := setting.LoginId;
   end;
end;

procedure TCommForm.ImplementOptions();
var
   i: Integer;
   setting: TTelnetSetting;
begin
   TabControl1.Tabs.Clear();
   for i := 0 to dmZLogGlobal.PacketClusterList.Count - 1 do begin
      setting := dmZLogGlobal.PacketClusterList[i];
      TabControl1.Tabs.AddObject(setting.Name, setting);
   end;

   if TabControl1.Tabs.Count > 0 then begin
      TabControl1.TabIndex := 0;
      SelectSite(TabControl1.TabIndex);
      ConnectButton.Enabled := True;
   end
   else begin
      ConnectButton.Enabled := False;
   end;

   checkAutoLogin.Checked     := dmZLogGlobal.Settings.FClusterAutoLogin;
   checkAutoReconnect.Checked := dmZLogGlobal.Settings.FClusterAutoReconnect;
   checkRelaySpot.Checked     := dmZLogGlobal.Settings.FClusterRelaySpot;
   checkRecordLogs.Checked    := dmZLogGlobal.Settings.FClusterRecordLogs;
   checkIgnoreBEL.Checked     := dmZLogGlobal.Settings.FClusterIgnoreBEL;
   checkUseAllowDenyLists.Checked := dmZLogGlobal.Settings.FClusterUseAllowDenyLists;
   checkForceReconnect.Checked := dmZLogGlobal.Settings.FClusterForceReconnect;
end;

procedure TCommForm.RenewOptions();
begin
   dmZLogGlobal.Settings.FClusterAutoLogin      := checkAutoLogin.Checked;
   dmZLogGlobal.Settings.FClusterAutoReconnect  := checkAutoReconnect.Checked;
   dmZLogGlobal.Settings.FClusterRelaySpot      := checkRelaySpot.Checked;
   dmZLogGlobal.Settings.FClusterRecordLogs     := checkRecordLogs.Checked;
   dmZLogGlobal.Settings.FClusterIgnoreBEL      := checkIgnoreBEL.Checked;
   dmZLogGlobal.Settings.FClusterUseAllowDenyLists := checkUseAllowDenyLists.Checked;
   dmZLogGlobal.Settings.FClusterForceReconnect := checkForceReconnect.Checked;
end;

procedure TCommForm.FormCreate(Sender: TObject);
begin
   ListBox.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
   Console.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
   FRelayPacketData := False;
   FSpotListLastCleanup := Now;
   FCommStarted := False;
   FCommBuffer := TStringList.Create;
   FSpotterList := TStringList.Create();
   FSpotterList.Duplicates := dupIgnore;
   FSpotterList.Sorted := True;
   FSpotterList.CaseSensitive := False;
   FAllowList1 := TStringList.Create();
   FAllowList1.Duplicates := dupIgnore;
   FAllowList1.Sorted := True;
   FAllowList1.CaseSensitive := False;
   FAllowList2 := TStringList.Create();
   FAllowList2.Duplicates := dupIgnore;
   FAllowList2.Sorted := True;
   FAllowList2.CaseSensitive := False;
   FDenyList := TStringList.Create();
   FDenyList.Duplicates := dupIgnore;
   FDenyList.Sorted := True;
   FDenyList.CaseSensitive := False;

   FReConnectMax := dmZLogGlobal.Settings.FClusterReConnectMax;
   FReConnectCount := 0;
   FRetryIntervalSec := dmZLogGlobal.Settings.FClusterRetryIntervalSec;
   FRetryIntervalCount := 0;
   timerReConnect.Enabled := False;

   ImplementOptions();

   FDisconnectClicked := False;
   FUseClusterLog := False;
   FClusterLogFileName := StringReplace(Application.ExeName, '.exe', '_telnet_log_' + FormatDateTime('yyyymmdd', Now) + '.txt', [rfReplaceAll]);
   FAutoLogined := False;
   FCommProcessThread := nil;
end;

procedure TCommForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Disconnect();

   MainForm.DelTaskbar(Handle);
end;

procedure TCommForm.PreProcessSpotFromZLink(S : string; N: Integer);
var
   Sp : TSpot;
begin
   Sp := TSpot.Create;
   if Sp.Analyze(S) = True then begin

      // データ発生源はZ-Server
      Sp.SpotSource := ssClusterFromZServer;
      Sp.SpotGroup := N;

      ProcessSpot(Sp);
   end
   else begin
      Sp.Free;
   end;
end;

procedure TCommForm.ProcessSpot(Sp: TSpot);
var
   isJA: Boolean;
begin
   try
      // ５分ごとに期限切れSpotを消す
      if MinutesBetween(Now, FSpotListLastCleanup) > 5 then begin
         Cleanup();
         FSpotListLastCleanup := Now;
      end;

      // このコンテストで使用しないバンドは除く
      if (MainForm.BandMenu.Items[ord(Sp.Band)].Visible = False) or
         (MainForm.BandMenu.Items[ord(Sp.Band)].Enabled = False) then begin
         Sp.Free();
         Exit;
      end;

      // JAかDXか判定
      isJA := IsDomestic(Sp.Call);

      // JA
      if (dmZLogGlobal.Settings._bandscope_show_ja_spots = False) and (isJA = True) then begin
         Sp.Free();
         Exit;
      end;

      // DX
      if (dmZLogGlobal.Settings._bandscope_show_dx_spots = False) and (isJA = False) then begin
         Sp.Free();
         Exit;
      end;

      // 周波数よりモードを決める
      // この時点でmOtherならBAND PLAN外と見なして良い
      Sp.Mode := dmZLogGlobal.BandPlan.GetEstimatedMode(Sp.FreqHz);

      // BAND PLAN内？
      if dmZLogGlobal.Settings._bandscope_show_only_in_bandplan = True then begin
         if dmZLogGlobal.BandPlan.IsInBand(Sp.Band, Sp.Mode, Sp.FreqHz) = False then begin
            Sp.Free();
            Exit;
         end;
      end;

      // 交信済みチェック
      SpotCheckWorked(Sp);

      // Spotterリストに登録
      if (Sp.ReportedBy <> '') and (FSpotterList.IndexOf(Sp.ReportedBy) = -1) then begin
         FSpotterList.Add(Sp.ReportedBy);
         {$IFDEF DEBUG}
         OutputDebugString(PChar('This reporter [' + Sp.ReportedBy + '] has been added to your spotter list'));
         {$ENDIF}
      end;

      // リスト表示上限は1000
      ListBox.Items.BeginUpdate();
      ListBox.AddItem(Sp.ClusterSummary, Sp);
      if ListBox.Items.Count > 1000 then begin
         TSpot(ListBox.Items.Objects[0]).Free();
         ListBox.Items.Delete(0);
      end;
      ListBox.Items.EndUpdate();
      ListBox.ShowLast();

      // BandScopeに登録
      MainForm.BandScopeAddClusterSpot(Sp);
   except
      on E: Exception do begin
         dmZLogGlobal.WriteErrorLog('TCommForm.ProcessSpot()');
         dmZLogGlobal.WriteErrorLog(Sp.InText());
         dmZLogGlobal.WriteErrorLog(E.Message);
         dmZLogGlobal.WriteErrorLog(E.StackTrace);
      end;
   end;
end;

procedure TCommForm.Cleanup();
var
   i: Integer;
   Expire: TDateTime;
   S: TSpot;
begin
   Expire := dmZlogGlobal.Settings._spotexpire / (60 * 24);

   ListBox.Items.BeginUpdate();
   for i := ListBox.Count - 1 downto 0 do begin
      S := TSpot(ListBox.Items.Objects[i]);
      if Now - S.Time > Expire then begin
         S.Free();
         ListBox.Items.Delete(i);
      end;
   end;
   ListBox.Items.EndUpdate();
end;

procedure TCommForm.TransmitSpot(S : string); // local or via network
begin
   if TabControl1.Tabs.Count = 0 then begin
      MainForm.ZLinkForm.SendSpotViaNetwork(S);
   end
   else begin
      WriteLine(S);
   end;
end;

procedure TCommForm.CommProcess;
var
   strTemp: string;
   Sp : TSpot;
   setting: TTelnetSetting;
label
   nextnext;
begin
   setting := TTelnetSetting(TabControl1.Tabs.Objects[TabControl1.TabIndex]);
   while FCommBuffer.Count > 0 do begin
      strTemp := FCommBuffer.Strings[0];

      WriteLineConsole(strTemp);

      // Auto Login
      if (checkAutoLogin.Checked = True) and (FAutoLogined = False) then begin
         if (Pos('login:', strTemp) > 0) or
            (Pos('Please enter your call:', strTemp) > 0) or
            (Pos('Please enter your callsign:', strTemp) > 0) then begin
            Sleep(500);

            if setting.LoginId = '' then begin
               WriteLine(dmZlogGlobal.MyCall);
            end
            else begin
               WriteLine(setting.LoginId);
            end;

            FAutoLogined := True;
         end;
      end;

      if FRelayPacketData then begin
         MainForm.ZLinkForm.SendPacketData(strTemp);
      end;

      Sp := TSpot.Create;
      if Sp.Analyze(strTemp) = True then begin

         // Spotterのチェック
         if checkUseAllowDenyLists.Checked = True then begin
            if (FDenyList.Count > 0) and (FDenyList.IndexOf(Sp.ReportedBy) >= 0) then begin
               {$IFDEF DEBUG}
               OutputDebugString(PChar('This reporter [' + Sp.ReportedBy + '] has been rejected by the deny list'));
               {$ENDIF}
               Sp.Free();
               goto nextnext;
            end;

            if (FAllowList1.Count > 0) and (FAllowList1.IndexOf(Sp.ReportedBy) >= 0) then begin
               Sp.ReliableSpotter := True;
            end
            else if (FAllowList2.Count > 0) and (FAllowList2.IndexOf(Sp.ReportedBy) >= 0) then begin
               Sp.ReliableSpotter := False;
            end
            else if (FAllowList1.Count = 0) and (FAllowList2.Count = 0) then begin
               Sp.ReliableSpotter := True;
            end
            else begin
               {$IFDEF DEBUG}
               OutputDebugString(PChar('This reporter [' + Sp.ReportedBy + '] is not on the allow list'));
               {$ENDIF}
               Sp.Free();
               goto nextnext;
            end;
         end;

         // データ発生源はCluster
         Sp.SpotSource := ssCluster;

         ProcessSpot(Sp);

         if checkRelaySpot.Checked then begin
            MainForm.ZLinkForm.RelaySpot(strTemp);
         end;
      end
      else begin
        Sp.Free;
      end;

nextnext:
      CommBufferLock.Enter();
      FCommBuffer.Delete(0);
      CommBufferLock.Leave();

      {$IFDEF DEBUG}
//      var S := Format('MSpots=%d DSpots=%d CSpots=%d', [FSpotList.Count, ListBox.Items.Count, Console.Items.Count]);
//      WriteStatusLine(S);
      {$ENDIF}
   end;
end;

procedure TCommForm.TimerProcess;
begin
   Timer1.Enabled := False;
   try
      // Auto Reconnect
      if (checkAutoReconnect.Checked = True) and (Telnet.IsConnected() = False) and
         (FDisconnectClicked = False) and (ConnectButton.Caption = UComm_Connect) then begin

         if (FReConnectCount >= FReConnectMax) then begin
            WriteLineConsole(UComm_ExceededLimit);
            WriteStatusLine('');
            timerReconnect.Enabled := False;
            FReConnectCount := 0;
            FRetryIntervalCount := 0;
            Exit;
         end;

         if (FRetryIntervalCount <= FRetryIntervalSec) then begin
            Exit;
         end;

         ConnectButton.Click();
         Inc(FReConnectCount);
      end;
   finally
      Timer1.Enabled := True;
   end;
end;

procedure TCommForm.timerReConnectTimer(Sender: TObject);
var
   S: string;
   C: Integer;
begin
   C := FRetryIntervalSec - FRetryIntervalCount;
   if C < 0 then begin
      C := 0;
   end;

   S := Format(UComm_SecondsLeft, [IntToStr(C)]);
   WriteStatusLine(S);

   Inc(FRetryIntervalCount);
end;

procedure TCommForm.FormDestroy(Sender: TObject);
var
   i: Integer;
begin
   Telnet.Close;

   TerminateCommProcessThread();

   for i := 0 to ListBox.Count - 1 do begin
      TSpot(ListBox.Items.Objects[i]).Free();
   end;

//   FSpotList.Free();
   FCommBuffer.Free();

   FSpotterList.Free();
   FAllowList1.Free();
   FAllowList2.Free();
   FDenyList.Free();
end;

procedure TCommForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

procedure TCommForm.TelnetDisplay(Sender: TTnCnx; Str: String);
begin
   CommBufferLock.Enter();
   FCommBuffer.Add(str);
   CommBufferLock.Leave();
end;

procedure TCommForm.ConnectButtonClick(Sender: TObject);
begin
   try
      Edit.SetFocus;

      WriteStatusLine('');
      FRetryIntervalCount := 0;

      if TabControl1.Tabs.Count = 0 then begin
         MainForm.ZLinkForm.PushRemoteConnect;
         exit;
      end;

      if Telnet.IsConnected then begin
         ConnectButton.Caption := UComm_Disconnecting;
         FDisconnectClicked := True;
         Telnet.Close;
      end
      else begin
         LoadAllowDenyList();
         Telnet.Connect;
         ConnectButton.Caption := UComm_Connecting;
         FDisconnectClicked := False;
         Timer1.Enabled := True;
         FCommProcessThread := TCommProcessThread.Create(Self);
         FCommProcessThread.Start();
      end;
   except
      on E: Exception do begin
         WriteConsole(E.Message);
         Timer1.Enabled := False;
         checkAutoReconnect.Checked := False;
      end;
   end;
end;

procedure TCommForm.RemoteConnectButtonPush;
begin
   if TabControl1.Tabs.Count = 0 then begin
      //ZLinkForm.PushRemoteConnect;
      exit;
   end;

   if Telnet.IsConnected then begin
      //Telnet.Close;
      //ConnectButton.Caption := 'Disconnecting...';
   end
   else begin
      Telnet.Connect;
      ConnectButton.Caption := UComm_Connecting;
   end;
end;

procedure TCommForm.TelnetSessionConnected(Sender: TTnCnx; Error: Word);
begin
   try
      if checkRecordLogs.Checked = True then begin
         // 300Mの空き容量があった場合にrecordする
         if CheckDiskFreeSpace(ExtractFilePath(FClusterLogFileName), 300) = True then begin
            AssignFile(FClusterLog, FClusterLogFileName);

            if FileExists(FClusterLogFileName) = True then begin
               Append(FClusterLog);
            end
            else begin
               Rewrite(FClusterLog);
            end;

            FUseClusterLog := True;
         end
         else begin
            AddConsole('**** Not enough free disk space (Not Record!) ****');
            FUseClusterLog := False;
         end;
      end;

      checkAutoLogin.Enabled := False;
      checkAutoReconnect.Enabled := False;
      checkRelaySpot.Enabled := False;
      checkRecordLogs.Enabled := False;
      checkIgnoreBEL.Enabled := False;
      checkUseAllowDenyLists.Enabled := False;
      checkForceReconnect.Enabled := False;

      ConnectButton.Caption := UComm_Disconnect;
      WriteLineConsole('connected to ' + Telnet.Host);

      timerReConnect.Enabled := False;

      FAutoLogined := False;

      FRetryIntervalCount := 0;
      if Error = 0 then begin
         FReConnectCount := 0;
      end;

      FConnectTime := Now;
      timerForceReconnect.Enabled := True;
   except
      on E: Exception do begin
         AddConsole(E.Message);
         FUseClusterLog := False;
      end;
   end;
end;

procedure TCommForm.TelnetSessionClosed(Sender: TTnCnx; Error: Word);
var
   fname: string;
begin
   WriteLineConsole('disconnected...');

   if (checkRecordLogs.Checked = True) and (FUseClusterLog = True) then begin
      CloseFile(FClusterLog);
   end;
   FUseClusterLog := False;

   checkAutoLogin.Enabled := True;
   checkAutoReconnect.Enabled := True;
   checkRelaySpot.Enabled := True;
   checkRecordLogs.Enabled := True;
   checkIgnoreBEL.Enabled := True;
   checkUseAllowDenyLists.Enabled := True;
   checkForceReconnect.Enabled := True;
   ConnectButton.Caption := UComm_Connect;

   fname := ExtractFilePath(Application.ExeName) + 'spotter_list.txt';
   FSpotterList.SaveToFile(fname);

   fname := ExtractFilePath(Application.ExeName) + 'spotter_deny.txt';
   FDenyList.SaveToFile(fname);

   if FDisconnectClicked = False then begin
      timerReConnect.Enabled := True;
   end;
   TerminateCommProcessThread();
   timerForceReconnect.Enabled := False;
end;

procedure TCommForm.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);

   ConnectButton.Enabled := True;
end;

procedure TCommForm.ListBoxDblClick(Sender: TObject);
var
   Sp : TSpot;
begin
   if ListBox.ItemIndex = -1 then begin
      Exit;
   end;

   if ListBox.Items[ListBox.ItemIndex] = '' then begin
      Exit;
   end;

   Sp := TSpot(ListBox.Items.Objects[ListBox.ItemIndex]);
   if Sp = nil then begin
      Exit;
   end;

   // 相手局をセット
   MainForm.SetYourCallsign(Sp.Call, Sp.Number);

   // 周波数をセット
   MainForm.SetFrequency(Sp.FreqHz);
end;

procedure TCommForm.ListBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_RETURN: begin
         ListBoxDblClick(Self);
      end;

      VK_DELETE: begin
         DeleteSpot(ListBox.ItemIndex, ListBox.ItemIndex);
      end;
   end;
end;

procedure TCommForm.ListBoxMeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
   Height := Abs(TListBox(Control).Font.Height) + 2;
end;

procedure TCommForm.ListBoxDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
   XOffSet: Integer;
   YOffSet: Integer;
   S : string;
   H: Integer;
   SP: TSpot;
begin
   with (Control as TListBox).Canvas do begin
      FillRect(Rect);								{ clear the rectangle }
      XOffset := 2;								{ provide default offset }

      H := Rect.Bottom - Rect.Top;
      YOffset := (H - Abs(TListBox(Control).Font.Height)) div 2;

      S := TListBox(Control).Items[Index];
      SP := TSpot(TListBox(Control).Items.Objects[Index]);
      if SP.IsNewMulti = True then begin
         if odSelected in State then begin
            Font.Color := clFuchsia;
         end
         else begin
            Font.Color := clRed;
         end;
      end
      else begin
         if SP.Worked then begin
            if odSelected in State then begin
               Font.Color := clWhite;
            end
            else begin
               Font.Color := clBlack;
            end;
         end
         else begin
            if odSelected in State then begin
               Font.Color := clYellow;
            end
            else begin
               Font.Color := clGreen;
            end;
         end;
      end;

      TextOut(Rect.Left + XOffset, Rect.Top + YOffSet, S);
   end;
end;

procedure TCommForm.Renew;
begin
   ListBox.Refresh;
end;

procedure TCommForm.FormActivate(Sender: TObject);
begin
  {if StayOnTop.Checked = False then
    FormStyle := fsNormal;}
end;


procedure TCommForm.Button1Click(Sender: TObject);
begin
   Telnet.Close();
end;

procedure TCommForm.ClusterCommReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: Cardinal);
var
   i: Integer;
   ptr: PAnsiChar;
   str: AnsiString;
begin
   str := '';
   ptr := PAnsiChar(DataPtr);

   for i := 0 to DataSize - 1 do begin
      str := str + AnsiChar(ptr[i]);
   end;

   CommBufferLock.Enter();
   FCommBuffer.Add(string(str));
   CommBufferLock.Leave();
end;

procedure TCommForm.TabControl1Change(Sender: TObject);
begin
   SelectSite(TabControl1.TabIndex);
end;

procedure TCommForm.TelnetDataAvailable(Sender: TTnCnx; Buffer: Pointer; Len: Integer);
var
   str: string;
   st: Integer;
   line: string;
   i: Integer;
begin
   str := string(AnsiStrings.StrPas(PAnsiChar(Buffer)));

   // BELコード削除
   if checkIgnoreBEL.Checked = True then begin
      str := StringReplace(str, #07, '', [rfReplaceAll]);
   end;

   // CRLFで分割
   CommBufferLock.Enter();

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

   CommBufferLock.Leave();
end;

function TCommForm.GetFontSize(): Integer;
begin
   Result := ListBox.Font.Size;
end;

procedure TCommForm.SetFontSize(v: Integer);
begin
   ListBox.Font.Size := v;
   Console.Font.Size := v;
end;

procedure TCommForm.menuPasteCommandClick(Sender: TObject);
var
   i: Integer;
   slText: TStringList;
   fLocalEcho: Boolean;
   strCommand: string;
begin
   fLocalEcho := GetLocalEcho();
   ClipBoard.Open();
   slText := TStringList.Create();
   try
      if ClipBoard.HasFormat(CF_TEXT) = False then begin
         Exit;
      end;

      slText.Text := ClipBoard.AsText;
      for i := 0 to slText.Count - 1 do begin
         strCommand := slText.Strings[i];
         WriteData(strCommand + FLineBreak);

         if fLocalEcho then begin
            WriteLineConsole(strCommand);
         end;

         Sleep(100);
      end;
   finally
      ClipBoard.Close();
      slText.Free();
   end;
end;

procedure TCommForm.menuSaveToFileClick(Sender: TObject);
var
   i: Integer;
   F: TextFile;
begin
   if SaveTextFileDialog1.Execute() = False then begin
      Exit;
   end;

   AssignFile(F, SaveTextFileDialog1.FileName);
   Rewrite(F);

   for i := 0 to ListBox.Items.Count - 1 do begin
      WriteLn(F, ListBox.Items[i]);
   end;

   CloseFile(F);
end;

procedure TCommForm.Disconnect();
begin
   if Telnet.IsConnected = True then begin
      Telnet.Close();
   end;
end;

function TCommForm.GetLocalEcho(): Boolean;
var
   obj: TTelnetSetting;
begin
   obj := TTelnetSetting(TabControl1.Tabs.Objects[TabControl1.TabIndex]);
   Result := obj.LocalEcho;
end;

procedure TCommForm.TerminateCommProcessThread();
begin
   if Assigned(FCommProcessThread) then begin
      FCommProcessThread.Terminate();
      FCommProcessThread.WaitFor();
      FCommProcessThread.Free();
      FCommProcessThread := nil;
   end;
end;

procedure TCommForm.timerForceReconnectTimer(Sender: TObject);
var
   diff: TDateTime;
   D, H, M, S, ms: Word;
   min: Integer;
begin
   timerForceReconnect.Enabled := False;
   diff := Now - FConnectTime;
   DecodeTime(diff, H, M, S, ms);
   D := Trunc(DaySpan(Now, FConnectTime));

   min := (D * 24 * 60) + (H * 60) + M;
   if min >= dmZLogGlobal.Settings.FClusterForceReconnectIntervalMin then begin
      if Telnet.IsConnected = True then begin
         ConnectButton.Click;

         while (Telnet.State <> wsClosed) do begin
            Application.ProcessMessages();
            Sleep(10);
         end;
      end;

      if Telnet.IsConnected = False then begin
         ConnectButton.Click;
      end;
   end;
   timerForceReconnect.Enabled := True;
end;

procedure TCommForm.LoadAllowDenyList();
var
   fname: string;
begin
   FSpotterList.Clear();
   FAllowList1.Clear();
   FAllowList2.Clear();
   FDenyList.Clear();

   fname := ExtractFilePath(Application.ExeName) + 'spotter_list.txt';
   if FileExists(fname) then begin
      FSpotterList.LoadFromFile(fname);
   end;

   fname := ExtractFilePath(Application.ExeName) + 'spotter_allow.txt';
   if FileExists(fname) then begin
      FAllowList1.LoadFromFile(fname);
   end;

   fname := ExtractFilePath(Application.ExeName) + 'spotter_allow2.txt';
   if FileExists(fname) then begin
      FAllowList2.LoadFromFile(fname);
   end;

   fname := ExtractFilePath(Application.ExeName) + 'spotter_deny.txt';
   if FileExists(fname) then begin
      FDenyList.LoadFromFile(fname);
   end;
end;

function TCommForm.DeleteControlChar(S: string): string;
var
   i: Integer;
   C: Char;
   OutStr: string;
begin
   OutStr := '';
   for i := 1 to Length(S) do begin
      C := S[i];
      if (Ord(C) >= $20) and (Ord(C) <= $7F) then begin
         OutStr := OutStr + C;
      end;
   end;

   Result := OutStr;
end;

{ TCommProcessThread }

constructor TCommProcessThread.Create(formParent: TForm);
begin
   inherited Create(True);
   FParent := formParent;
end;

procedure TCommProcessThread.Execute();
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** begin - TCommProcessThread.Execute - ****'));
   {$ENDIF}

   repeat
      Sleep(100);
      TCommForm(FParent).CommProcess;
   until Terminated;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** end - TCommProcessThread.Execute - ****'));
   {$ENDIF}
end;

initialization
   CommBufferLock := TCriticalSection.Create();

finalization
   CommBufferLock.Free();

end.
