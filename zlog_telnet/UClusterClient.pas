unit UClusterClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  System.AnsiStrings, Vcl.ComCtrls, System.IniFiles, System.DateUtils,
  System.IOUtils,
  OverbyteIcsWndControl, OverbyteIcsTnCnx, OverbyteIcsWSocket, OverbyteIcsTypes,
  UOptions, USpotClass, UzLogConst, HelperLib, UTelnetSetting,
  OverbyteIcsSslBase;

const
  SPOTMAX = 2000;

type
  TLoginStep = ( lsNone = 0, lsReqUser, lsReqPassword, lsLogined, lsLoginIncorrect );

  TClusterClient = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    Panel2: TPanel;
    ListBox: TListBox;
    Splitter1: TSplitter;
    Telnet: TTnCnx;
    PopupMenu: TPopupMenu;
    Deleteselectedspots1: TMenuItem;
    MainMenu1: TMainMenu;
    menuFunc: TMenuItem;
    menuSettings: TMenuItem;
    N2: TMenuItem;
    menuExit: TMenuItem;
    panelShowInfo: TPanel;
    timerShowInfo: TTimer;
    Console: TListBox;
    TabControl1: TTabControl;
    Label1: TLabel;
    labelHostName: TLabel;
    Label2: TLabel;
    labelLoginID: TLabel;
    buttonConnect: TButton;
    timerForceReconnect: TTimer;
    timerReConnect: TTimer;
    Edit: TComboBox;
    ZServer: TSslWSocket;
    ZSslContext: TSslContext;
    timerLoginCheck: TTimer;
    procedure buttonCloseClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerProcess(Sender: TObject);
    procedure buttonConnectClick(Sender: TObject);
    procedure TelnetSessionConnected(Sender: TTnCnx; Error: Word);
    procedure TelnetSessionClosed(Sender: TTnCnx; Error: Word);
    procedure TelnetDataAvailable(Sender: TTnCnx; Buffer: Pointer; Len: Integer);
    procedure ListBoxDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure ListBoxMeasureItem(Control: TWinControl; Index: Integer; var Height: Integer);
    procedure menuSettingsClick(Sender: TObject);
    procedure menuExitClick(Sender: TObject);
    procedure ZServerSessionConnected(Sender: TObject; ErrCode: Word);
    procedure timerShowInfoTimer(Sender: TObject);
    procedure ZServerSessionClosed(Sender: TObject; ErrCode: Word);
    procedure FormShow(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure timerForceReconnectTimer(Sender: TObject);
    procedure timerReConnectTimer(Sender: TObject);
    procedure TabControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure EditSelect(Sender: TObject);
    procedure ZServerSslHandshakeDone(Sender: TObject; ErrCode: Word; PeerCert: TX509Base; var Disconnect: Boolean);
    procedure ZServerDataAvailable(Sender: TObject; ErrCode: Word);
    procedure timerLoginCheckTimer(Sender: TObject);
  private
    { Private declarations }
    FSpotExpireMin: Integer;                       // スポットの生存時間
    FSpotGroup: Integer;                           // スポットの情報グループ

    // Z-Server options
    FZServerClientName: string;                    // この端末名
    FZServerHostname: string;                      // Z-Serverのホスト名
    FZServerPortNumber: string;                    // Z-Serverのポート番号
    FZServerSecure: Boolean;                       // セキュアモードON/OFF
    FZServerLoginId: string;                       // ZServerへのログインID
    FZServerLoginPassword: string;                 // ZServerログイン時のパスワード
    FZServerLoginStep: TLoginStep;                 // 現在のログインステータス

    // Packet Cluster options
    FClusterAutoLogin: Boolean;                    // 自動ログイン
    FClusterAutoReconnect: Boolean;                // 自動再接続
    FClusterRecordLogs: Boolean;                   // 受信ログを保存
    FClusterUseAllowDenyLists: Boolean;            // 許可/拒否リストを使用

    // Auto Reconnect
    FReConnectMax: Integer;                        // 自動再接続の最大回数
    FReConnectCount: Integer;
    FRetryIntervalSec: Integer;                    // 自動再接続の再試行間隔
    FRetryIntervalCount: Integer;

    // Force reconnect
    FUseForceReconnect: Boolean;                   // 強制再接続有無
    FForceReconnectIntervalMin: Integer;           // 強制再接続時間
    FConnectTime: TDateTime;                       // 接続時刻

    FPacketClusterList: TTelnetSettingList;        // PacketCluster接続先リスト

    FSpotterList: TStringList;                     // スポッターリスト
    FAllowList1: TStringList;                      // 許可１リスト
    FAllowList2: TStringList;                      // 許可２リスト
    FDenyList: TStringList;                        // 拒否リスト

    FCommBuffer: TStringList;                      // Cluster側(TELNET側)の受信バッファ

    FUseClusterLog: Boolean;                       // True:Clusterログを記録する
    FClusterLog: TextFile;
    FClusterLogFileName: string;
    FDisconnectClicked: Boolean;                   // True:ボタン操作で切断しました
    FAutoLogined: Boolean;                         // True:Clusterへ自動ログインしました

    FLineBreak: string;
    procedure LoadSettings();
    procedure SaveSettings();
    procedure ImplementOptions;
    procedure ProcessSpot(Sp : TSpot);
    procedure CommProcess;
    procedure WriteLine(str: string);
    procedure WriteData(str : string);
    procedure RelaySpot(S: string);
    procedure WriteLineConsole(str : string);
    procedure WriteConsole(strText: string);
    procedure LoadAllowDenyList();
    procedure ShowInfo(fShow: Boolean);
    procedure AddConsole(str: string);
    procedure SelectSite(Index: Integer);
    procedure ConnectZServer();
    procedure InitProcess();
  public
    { Public declarations }
  end;

const
  SPOT_COMMAND: array[1..3] of string = ( 'SPOT', 'SPOT2', 'SPOT3' );

resourcestring
  UComm_Connect = '接続';
  UComm_Disconnect = '切断';
  UComm_Connecting = '接続中...';
  UComm_Disconnecting = '切断中...';
  UComm_SecondsLeft = '再接続まであと %s 秒';
  UComm_ExceededLimit = '再接続試行回数の上限を超えました';
  UComm_SiteChanging = '既に %s へ接続しています。 切断してもよろしいですか？';

var
   ClusterClient: TClusterClient;

implementation

uses
  UzLogGlobal;

{$R *.DFM}

procedure TClusterClient.FormCreate(Sender: TObject);
begin
   FZServerSecure := False;
   FZServerLoginStep := lsNone;
   FPacketClusterList := TTelnetSettingList.Create();
   FReConnectCount := 0;
   FRetryIntervalCount := 0;
   timerReConnect.Enabled := False;

   FCommBuffer := TStringList.Create;
   Timer1.Enabled := False;
   FAutoLogined := False;
   LoadSettings();
   ImplementOptions();

   FDisconnectClicked := False;
   FUseClusterLog := False;
   FClusterLogFileName := StringReplace(Application.ExeName, '.exe', '_telnet_log_' + FormatDateTime('yyyymmdd', Now) + '.txt', [rfReplaceAll]);

   FSpotterList := TStringList.Create();
   FSpotterList.Sorted := True;
   FSpotterList.CaseSensitive := False;
   FSpotterList.Duplicates := dupIgnore;
   FAllowList1 := TStringList.Create();
   FAllowList1.Sorted := True;
   FAllowList1.CaseSensitive := False;
   FAllowList1.Duplicates := dupIgnore;
   FAllowList2 := TStringList.Create();
   FAllowList2.Sorted := True;
   FAllowList2.CaseSensitive := False;
   FAllowList2.Duplicates := dupIgnore;
   FDenyList := TStringList.Create();
   FDenyList.Sorted := True;
   FDenyList.CaseSensitive := False;
   FDenyList.Duplicates := dupIgnore;
end;

procedure TClusterClient.FormDestroy(Sender: TObject);
begin
   Telnet.Close();
   ZServer.Close();
   SaveSettings();
   FCommBuffer.Free();

   FSpotterList.Free();
   FAllowList1.Free();
   FAllowList2.Free();
   FDenyList.Free();
   FPacketClusterList.Free();
end;

procedure TClusterClient.FormShow(Sender: TObject);
begin
   ShowInfo(True);
end;

procedure TClusterClient.WriteLine(str: string);
begin
   WriteData(str + FLineBreak);
end;

procedure TClusterClient.WriteData(str : string);
begin
   if Telnet.IsConnected then begin
      Telnet.SendStr(str);
   end;
end;

procedure TClusterClient.buttonCloseClick(Sender: TObject);
begin
   Close;
end;

procedure TClusterClient.EditKeyPress(Sender: TObject; var Key: Char);
var
   boo: boolean;
   s : string;
begin
   boo := False;

 //  7 : boo := dmZlogGlobal.Settings._cluster_telnet.FLocalEcho;

   s := '';
   if Key = Chr($0D) then begin

      WriteData(Edit.Text + FLineBreak);

      if boo then begin
         WriteConsole(Edit.Text + FLineBreak);
      end;

      Key := Chr($0);
      Edit.Text := '';
   end;
end;

procedure TClusterClient.EditSelect(Sender: TObject);
var
   inputs: array[0..1] of TInput;
   uSent: UINT;
begin
   // コマンド選択後はEnterキーを押したことにする
   ZeroMemory(@inputs, SizeOf(inputs));

   inputs[0].Itype := INPUT_KEYBOARD;
   inputs[0].ki.wVk := VK_RETURN;

   inputs[1].Itype := INPUT_KEYBOARD;
   inputs[1].ki.wVk := VK_RETURN;
   inputs[1].ki.dwFlags := KEYEVENTF_KEYUP;

   uSent := SendInput(Length(inputs), inputs[0], sizeof(TInput));
end;

procedure TClusterClient.LoadSettings();
var
   ini: TMemIniFile;
   num: Integer;
   i: Integer;
   strKey: string;
   setting: TTelnetSetting;
begin
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      Self.Top := ini.ReadInteger('window', 'top', Self.Top);
      Self.Left := ini.ReadInteger('window', 'left', Self.Left);
      Self.Width := ini.ReadInteger('window', 'width', Self.Width);
      Self.Height := ini.ReadInteger('window', 'height', Self.Height);

      FSpotExpireMin := ini.ReadInteger('general', 'spotexpire', 10);
      FSpotGroup := ini.ReadInteger('general', 'spotgroup', 1);
      FClusterAutoLogin := ini.ReadBool('cluster', 'autologin', False);
      FClusterAutoReconnect := ini.ReadBool('cluster', 'autoreconnect', True);
      FClusterRecordLogs := ini.ReadBool('cluster', 'recordlogs', False);
      FClusterUseAllowDenyLists := ini.ReadBool('cluster', 'use_allow_deny_list', False);

      FReConnectMax    := ini.ReadInteger('cluster', 'ReConnectMax', 10);
      FRetryIntervalSec := ini.ReadInteger('cluster', 'RetryIntervalSec', 180);
      FUseForceReconnect  := ini.ReadBool('cluster', 'ForceReconnect', False);
      FForceReconnectIntervalMin := ini.ReadInteger('cluster', 'ForceReconnectInterval', 6 * 60);

      // Z-Server
      FZServerClientName := ini.ReadString('zserver', 'clientname', '');
      FZServerHostName := ini.ReadString('zserver', 'hostname', '');
      FZServerPortNumber := ini.ReadString('zserver', 'port', '23');
      FZServerSecure := ini.ReadBool('zserver', 'secure', False);
      FZServerLoginId := ini.ReadString('zserver', 'login', 'zloguser');
      FZServerLoginPassword := ini.ReadString('zserver', 'password', '');

      // PacketCluster
      FPacketClusterList.Clear();

      num := ini.ReadInteger('PacketCluster', 'num', 0);
      for i := 1 to num do begin
         strKey := '#' + IntToStr(i);
         setting := TTelnetSetting.Create();
         setting.Name := ini.ReadString('PacketCluster', strKey + '_Name', '');
         setting.HostName := ini.ReadString('PacketCluster', strKey + '_HostName', '');
         setting.LoginId := ini.ReadString('PacketCluster', strKey + '_LoginId', '');
         setting.PortNumber := ini.ReadInteger('PacketCluster', strKey + '_PortNumber', 23);
         setting.LineBreak := ini.ReadInteger('PacketCluster', strKey + '_LineBreak', 0);
         setting.LocalEcho := ini.ReadBool('PacketCluster', strKey + '_LocalEcho', False);
         setting.CommandList := ini.ReadString('PacketCluster', strKey + '_CommandList', '');
         FPacketClusterList.Add(setting);
      end;
   finally
      ini.Free();
   end;
end;

procedure TClusterClient.SaveSettings();
var
   ini: TMemIniFile;
   i: Integer;
   strKey: string;
begin
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      ini.WriteInteger('window', 'top', Self.Top);
      ini.WriteInteger('window', 'left', Self.Left);
      ini.WriteInteger('window', 'width', Self.Width);
      ini.WriteInteger('window', 'height', Self.Height);

      ini.WriteInteger('general', 'spotexpire', FSpotExpireMin);
      ini.WriteInteger('general', 'spotgroup', FSpotGroup);
      ini.WriteBool('cluster', 'autologin', FClusterAutoLogin);
      ini.WriteBool('cluster', 'autoreconnect', FClusterAutoReconnect);
      ini.WriteBool('cluster', 'recordlogs', FClusterRecordLogs);
      ini.WriteBool('cluster', 'use_allow_deny_list', FClusterUseAllowDenyLists);

      ini.WriteInteger('cluster', 'ReConnectMax', FReConnectMax);
      ini.WriteInteger('cluster', 'RetryIntervalSec', FRetryIntervalSec);
      ini.WriteBool('cluster', 'ForceReconnect', FUseForceReconnect);
      ini.WriteInteger('cluster', 'ForceReconnectInterval', FForceReconnectIntervalMin);

      // Z-Server
      ini.WriteString('zserver', 'clientname', FZServerClientName);
      ini.WriteString('zserver', 'hostname', FZServerHostName);
      ini.WriteString('zserver', 'port', FZServerPortNumber);
      ini.WriteBool('zserver', 'secure', FZServerSecure);
      ini.WriteString('zserver', 'login', FZServerLoginId);
      ini.WriteString('zserver', 'password', FZServerLoginPassword);

      // PacketCluster
      ini.EraseSection('PacketCluster');
      ini.WriteInteger('PacketCluster', 'num', FPacketClusterList.Count);
      for i := 0 to FPacketClusterList.Count - 1 do begin
         strKey := '#' + IntToStr(i + 1);
         ini.WriteString('PacketCluster', strKey + '_Name', FPacketClusterList[i].Name);
         ini.WriteString('PacketCluster', strKey + '_HostName', FPacketClusterList[i].HostName);
         ini.WriteString('PacketCluster', strKey + '_LoginId', FPacketClusterList[i].LoginId);
         ini.WriteInteger('PacketCluster', strKey + '_PortNumber', FPacketClusterList[i].PortNumber);
         ini.WriteInteger('PacketCluster', strKey + '_LineBreak', FPacketClusterList[i].LineBreak);
         ini.WriteBool('PacketCluster', strKey + '_LocalEcho', FPacketClusterList[i].LocalEcho);
         ini.WriteString('PacketCluster', strKey + '_CommandList', FPacketClusterList[i].CommandList);
      end;

      ini.UpdateFile();
   finally
      ini.Free();
   end;
end;

procedure TClusterClient.ImplementOptions();
var
   i: Integer;
   setting: TTelnetSetting;
begin
   // Packet Cluster
   TabControl1.Tabs.Clear();
   for i := 0 to FPacketClusterList.Count - 1 do begin
      setting := FPacketClusterList[i];
      TabControl1.Tabs.AddObject(setting.Name, setting);
   end;

   if TabControl1.Tabs.Count > 0 then begin
      TabControl1.TabIndex := 0;
      SelectSite(TabControl1.TabIndex);
      buttonConnect.Enabled := True;
   end
   else begin
      buttonConnect.Enabled := False;
   end;

   // Z-Server
   i := Pos(':', FZServerHostName);
   if i > 0 then begin
      FZServerHostName := Copy(FZServerHostName, 1, i - 1);
      FZServerPortNumber := Copy(FZServerHostName, i + 1);
   end;
   ZServer.Addr := FZServerHostName;
   ZServer.Port := FZServerPortNumber;
end;

procedure TClusterClient.ProcessSpot(Sp : TSpot);
var
   i : integer;
   S : TSpot;
   Expire : double;
begin

   Expire := FSpotExpireMin / (60 * 24);

   for i := ListBox.Items.Count - 1 downto 0 do begin
      S := TSpot(ListBox.Items.Objects[i]);

      // 有効期限切れかチェック
      if Now - S.Time > Expire then begin
         ListBox.Items.Delete(i);
      end;
   end;

   // 同一局かチェック
   for i := 0 to ListBox.Items.Count - 1 do begin
      S := TSpot(ListBox.Items.Objects[i]);

      if (S.Call = Sp.Call) and (S.FreqHz = Sp.FreqHz) then begin
         Exit;
      end;
   end;

   if ListBox.Items.Count > SPOTMAX then begin
      exit;
   end;

   // リストへ追加
   ListBox.Items.BeginUpdate();
   ListBox.Items.AddObject(Sp.ClusterSummary, Sp);
   ListBox.Items.EndUpdate();
   ListBox.ShowLast();
end;

function TrimCRLF(SS : string) : string;
var
   S: string;
begin
   S := SS;
   while (length(S) > 0) and ((S[1] = Chr($0A)) or (S[1] = Chr($0D))) do begin
      Delete(S, 1, 1);
   end;

   while (length(S) > 0) and ((S[length(S)] = Chr($0A)) or (S[length(S)] = Chr($0D))) do begin
      Delete(S, length(S), 1);
   end;

   Result := S;
end;

procedure TClusterClient.CommProcess;
var
   Sp : TSpot;
   strTemp: string;
label
   nextnext;
begin
   while FCommBuffer.Count > 0 do begin
      strTemp := FCommBuffer.Strings[0];

      // Auto Login
      if (FClusterAutoLogin = True) and (labelLoginID.Caption <> '') and (FAutoLogined = False) then begin
         if (Pos('login:', strTemp) > 0) or
            (Pos('Please enter your call:', strTemp) > 0) or
            (Pos('Please enter your callsign:', strTemp) > 0) then begin
            Sleep(500);
            WriteLine(labelLoginID.Caption);
            FAutoLogined := True;
         end;
      end;

      Sp := TSpot.Create;
      if Sp.Analyze(strTemp) = True then begin
         ProcessSpot(Sp);

         // Spotterのチェック
         if FClusterUseAllowDenyLists = True then begin
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

         // Z-Serverへ送信
         if ZServer.State = wsConnected then begin
            RelaySpot(strTemp);
         end
         else if (ZServer.State = wsClosed) and (ZServer.Addr <> '') then begin
            ConnectZServer();
         end;

         if FSpotterList.IndexOf(Sp.ReportedBy) = -1 then begin
            FSpotterList.Add(Sp.ReportedBy);
         end;
      end
      else begin
        Sp.Free;
      end;

nextnext:
      FCommBuffer.Delete(0);
   end;
end;

procedure TClusterClient.TimerProcess;
begin
   Timer1.Enabled := False;
   try
      if (FZServerLoginStep = lsLoginIncorrect) then begin
         buttonConnect.Click();
         Exit;
      end;

      // Auto Reconnect
      if (FClusterAutoReconnect = True) and (Telnet.IsConnected() = False) and
         (FDisconnectClicked = False) and (buttonConnect.Caption = UComm_Connect) then begin

         if (FReConnectCount >= FReConnectMax) then begin
            WriteLineConsole(UComm_ExceededLimit);
//            WriteStatusLine('');
            timerReconnect.Enabled := False;
            FReConnectCount := 0;
            FRetryIntervalCount := 0;
            Exit;
         end;

         if (FRetryIntervalCount <= FRetryIntervalSec) then begin
            Exit;
         end;

         buttonConnect.Click();
         Inc(FReConnectCount);
      end;

      if (FZServerSecure = False) and (ZServer.State = wsConnected) and (Telnet.IsConnected() = True) then begin
         CommProcess;
      end;
      if (FZServerSecure = True) and (FZServerLoginStep = lsLogined) and (ZServer.State = wsConnected) and (Telnet.IsConnected() = True) then begin
         CommProcess;
      end;
   finally
      Timer1.Enabled := True;
   end;
end;

procedure TClusterClient.timerReConnectTimer(Sender: TObject);
var
   S: string;
   C: Integer;
begin
   C := FRetryIntervalSec - FRetryIntervalCount;
   if C < 0 then begin
      C := 0;
   end;

   S := Format(UComm_SecondsLeft, [IntToStr(C)]);
   WriteLineConsole(S);

   Inc(FRetryIntervalCount);
end;

procedure TClusterClient.timerShowInfoTimer(Sender: TObject);
begin
   if TTimer(Sender).Tag = 0 then begin   // OFF
      if panelShowInfo.Height <= 0 then begin
         panelShowInfo.Height := 0;
         panelShowInfo.Visible := False;
         TTimer(Sender).Enabled := False;
      end
      else begin
         panelShowInfo.Height := panelShowInfo.Height - 2;
      end;
   end
   else begin     // ON
      if panelShowInfo.Height >= 28 then begin
         panelShowInfo.Height := 28;
         TTimer(Sender).Enabled := False;
      end
      else begin
         panelShowInfo.Visible := True;
         panelShowInfo.Height := panelShowInfo.Height + 2;
      end;
   end;
end;

procedure TClusterClient.buttonConnectClick(Sender: TObject);
begin
   try
      Edit.SetFocus;
      FRetryIntervalCount := 0;

      if Telnet.IsConnected then begin
         buttonConnect.Caption := UComm_Disconnecting;
         FDisconnectClicked := True;
         Telnet.Close;
         ZServer.Close();
      end
      else begin
         LoadAllowDenyList();
         Telnet.Connect;

         ConnectZServer();

         buttonConnect.Caption := UComm_Connecting;
         FDisconnectClicked := False;
         Timer1.Enabled := True;
      end;
   except
      on E: Exception do begin
         WriteConsole(E.Message);
         Timer1.Enabled := False;
         FClusterAutoReconnect := False;
      end;
   end;
end;

procedure TClusterClient.TelnetSessionConnected(Sender: TTnCnx; Error: Word);
begin
   try
      if FClusterRecordLogs = True then begin
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

      buttonConnect.Caption := UComm_Disconnect;
      WriteLineConsole('connected to ' + Telnet.Host);
      Caption := Application.Title + ' - ' + Telnet.Host + ' [' + FZServerClientName + ']';
      FAutoLogined := False;

      FRetryIntervalCount := 0;
      if Error = 0 then begin
         FReConnectCount := 0;
      end;

      FConnectTime := Now;

      if FForceReconnectIntervalMin > 0 then begin
         timerForceReconnect.Enabled := True;
      end;
   except
      on E: Exception do begin
         AddConsole(E.Message);
         FUseClusterLog := False;
      end;
   end;
end;

procedure TClusterClient.TelnetSessionClosed(Sender: TTnCnx; Error: Word);
var
   fname: string;
begin
   WriteLineConsole('disconnected...');

   if FClusterRecordLogs = True then begin
      CloseFile(FClusterLog);
   end;
   FUseClusterLog := False;

   buttonConnect.Caption := UComm_Connect;
   Caption := Application.Title;

   fname := ExtractFilePath(Application.ExeName) + 'spotter_list.txt';
   FSpotterList.SaveToFile(fname);
end;

procedure TClusterClient.timerForceReconnectTimer(Sender: TObject);
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
   if min >= FForceReconnectIntervalMin then begin
      if Telnet.IsConnected = True then begin
         buttonConnect.Click;

         while (Telnet.State <> wsClosed) do begin
            Application.ProcessMessages();
            Sleep(10);
         end;
      end;

      if Telnet.IsConnected = False then begin
         buttonConnect.Click;
      end;
   end;
   timerForceReconnect.Enabled := True;
end;

procedure TClusterClient.timerLoginCheckTimer(Sender: TObject);
begin
   timerLoginCheck.Enabled := False;
   if FZServerLoginStep <> lsLogined then begin
      FDisconnectClicked := False;
      ZServer.Close();
      Telnet.Close();
      WriteConsole('Z-ServerがSECUREモードではありません');
   end;
end;

procedure TClusterClient.ListBoxMeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
   Height := Abs(TListBox(Control).Font.Height) + 2;
end;

procedure TClusterClient.ListBoxDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
   XOffSet: Integer;
   YOffSet: Integer;
   S : string;
   SP: TSpot;
   H: Integer;
begin
   with (Control as TListBox).Canvas do begin
      FillRect(Rect);								{ clear the rectangle }
      XOffset := 2;								{ provide default offset }

      H := Rect.Bottom - Rect.Top;
      YOffset := (H - Abs(TListBox(Control).Font.Height)) div 2;

      S := (Control as TListBox).Items[Index];
      SP := TSpot(TListBox(Control).Items.Objects[Index]);
      if SP.IsNewMulti then begin
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

      TextOut(Rect.Left + XOffset, Rect.Top + YOffSet, S)								{ display the text }
   end;
end;

procedure TClusterClient.TabControl1Change(Sender: TObject);
begin
   SelectSite(TabControl1.TabIndex);
end;

procedure TClusterClient.TabControl1Changing(Sender: TObject; var AllowChange: Boolean);
var
   S: string;
begin
   // 接続中の場合は切るか確認する
   if Telnet.IsConnected then begin
      S := Format(UComm_SiteChanging, [labelHostName.Caption]);
      if MessageBox(Handle, PChar(S), PChar(Application.Title), MB_YESNO or MB_DEFBUTTON2 or MB_ICONEXCLAMATION) = IDYES then begin
         buttonConnect.Caption := UComm_Disconnecting;
         FDisconnectClicked := True;
         Telnet.Close();
         AllowChange := True;
      end
      else begin
         AllowChange := False;
      end;
   end;
end;

procedure TClusterClient.TelnetDataAvailable(Sender: TTnCnx; Buffer: Pointer; Len: Integer);
var
   str : string;
   i: Integer;
   st: Integer;
   line: string;
begin
   str := string(System.AnsiStrings.StrPas(PAnsiChar(Buffer)));

   st := 1;
   for i := 1 to Length(str) do begin
      if str[i] = #10 then begin
         line := TrimCRLF(Copy(str, st, i - st + 1));
         WriteConsole(line + FLineBreak);
         FCommBuffer.Add(line);
         st := i + 1;
      end;
   end;

   line := TrimCRLF(Copy(str, st));
   if line <> '' then begin
      WriteConsole(line + FLineBreak);
      FCommBuffer.Add(line);
   end;
end;

procedure TClusterClient.RelaySpot(S: string);
var
   str: string;
begin
   str := ZLinkHeader + ' ' + SPOT_COMMAND[FSpotGroup] + ' ' + S + FLineBreak;
   ZServer.SendStr(str);
end;

procedure TClusterClient.menuExitClick(Sender: TObject);
begin
   SaveSettings();
   Close();
end;

procedure TClusterClient.menuSettingsClick(Sender: TObject);
var
   dlg: TOptions;
begin
   dlg := TOptions.Create(Self);
   try
      dlg.SportExpireMin := FSpotExpireMin;
      dlg.SpotGroup := FSpotGroup;

      dlg.ZServerClientName := FZServerClientName;
      dlg.ZServerHost := FZServerHostname;
      dlg.ZServerPort := FZServerPortNumber;
      dlg.ZServerUseSecure := FZServerSecure;
      dlg.ZServerLoginId := FZServerLoginId;
      dlg.ZServerLoginPassword := FZServerLoginPassword;

      dlg.ClusterAutoLogin := FClusterAutoLogin;
      dlg.ClusterAutoReconnect := FClusterAutoReconnect;
      dlg.ClusterRecordLogs := FClusterRecordLogs;
      dlg.ClusterUseAllowDenyLists := FClusterUseAllowDenyLists;

      dlg.ReConnectMax := FReConnectMax;
      dlg.RetryIntervalSec := FRetryIntervalSec;
      dlg.ForceReconnectIntervalMin := FForceReconnectIntervalMin;

      dlg.PacketClusterList := FPacketClusterList;

      if dlg.ShowModal() = mrCancel then begin
         Exit;
      end;

      FSpotExpireMin := dlg.SportExpireMin;
      FSpotGroup := dlg.SpotGroup;
      FClusterAutoLogin := dlg.ClusterAutoLogin;
      FClusterAutoReconnect := dlg.ClusterAutoReconnect;
      FClusterRecordLogs := dlg.ClusterRecordLogs;
      FClusterUseAllowDenyLists := dlg.ClusterUseAllowDenyLists;

      FReConnectMax := dlg.ReConnectMax;
      FRetryIntervalSec := dlg.RetryIntervalSec;
      FForceReconnectIntervalMin := dlg.ForceReconnectIntervalMin;

      FZServerClientName := dlg.ZServerClientName;
      FZServerHostname := dlg.ZServerHost;
      FZServerPortNumber := dlg.ZServerPort;
      FZServerSecure := dlg.ZServerUseSecure;
      FZServerLoginId := dlg.ZServerLoginId;
      FZServerLoginPassword := dlg.ZServerLoginPassword;

      ImplementOptions();
      SaveSettings();
   finally
      dlg.Release();
   end;
end;

procedure TClusterClient.WriteLineConsole(str : string);
begin
   WriteConsole(str + FLineBreak);
end;

procedure TClusterClient.ZServerDataAvailable(Sender: TObject; ErrCode: Word);
const
   BUFSIZE = 2047;
var
   Buf: array [0 .. BUFSIZE] of AnsiChar;
   str: string;
   count: integer;
   P: PAnsiChar;
   line: string;
   i: Integer;
   SL: TStringList;
begin
   if Error <> 0 then begin
      AddConsole('DataAvailable Error=' + IntToStr(Error));
      Exit;
   end;

   SL := TStringList.Create();
   try
      ZeroMemory(@Buf, SizeOf(Buf));

      count := TSslWSocket(Sender).Receive(@Buf, SizeOf(Buf) - 1);
      if count <= 0 then begin
         exit;
      end;

      if count >= BUFSIZE then begin
         count := BUFSIZE;
      end;

      Buf[count] := #0;
      P := @Buf[0];
      str := string(AnsiString(P));

      SL.Text := str;

      for i := 0 to SL.Count - 1 do begin
         line := SL[i];

         if ((FZServerLoginStep = lsReqUser) and (line = 'Login:')) then begin
            ZServer.SendStr(FZServerLoginId);
            FZServerLoginStep := lsReqPassword;
            Continue;
         end;

         if ((FZServerLoginStep = lsReqPassword) and (line = 'Password:')) then begin
            ZServer.SendStr(FZServerLoginPassword);
            FZServerLoginStep := lsLogined;
            Continue;
         end;

         if (FZServerLoginStep = lsLogined) then begin
            if (line = 'bye...') then begin
               FZServerLoginStep := lsLoginIncorrect;
               timerLoginCheck.Enabled := False;
               WriteConsole('Z-Server : ログインできません');
               Telnet.Close();
               ZServer.Close();
               Exit;
            end;

            if (line = 'OK') then begin
               InitProcess();
            end;
         end;
      end;

   finally
      SL.Free();
   end;
end;

procedure TClusterClient.ZServerSessionClosed(Sender: TObject; ErrCode: Word);
begin
   ShowInfo(True);
   FZServerLoginStep := lsNone;
end;

procedure TClusterClient.ZServerSessionConnected(Sender: TObject; ErrCode: Word);
begin
   ShowInfo(False);

   if FZServerSecure = True then begin
      ZServer.StartSslHandshake();
      timerLoginCheck.Enabled := True;
   end
   else begin
      FZServerLoginStep := lsLogined;
      InitProcess();
   end;
end;

procedure TClusterClient.ZServerSslHandshakeDone(Sender: TObject; ErrCode: Word; PeerCert: TX509Base; var Disconnect: Boolean);
begin
   if Error <> 0 then begin
      AddConsole('SslHandshakeDone Error=' + IntToStr(Error));
      Disconnect := True;
      FZServerLoginStep := lsLoginIncorrect;
      Exit;
   end;

   FZServerLoginStep := lsReqUser;
end;

procedure TClusterClient.WriteConsole(strText: string);
begin
   AddConsole(strText);

   try
      if (FClusterRecordLogs = True) and (FUseClusterLog = True) then begin
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

procedure TClusterClient.LoadAllowDenyList();
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

procedure TClusterClient.ShowInfo(fShow: Boolean);
begin
   if fShow = True then begin
      panelShowInfo.Visible := True;
      timerShowInfo.Tag := 1;
   end
   else begin
      timerShowInfo.Tag := 0;
   end;
   timerShowInfo.Enabled := True;
end;

procedure TClusterClient.AddConsole(str: string);
begin
   Console.Items.BeginUpdate();
   Console.Items.Add(str);
   if Console.Items.Count > 1000 then begin
      Console.Items.Delete(0);
   end;
   Console.Items.EndUpdate();
   Console.ShowLast();
end;

procedure TClusterClient.SelectSite(Index: Integer);
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

   Edit.Items.CommaText := setting.CommandList;
end;

procedure TClusterClient.ConnectZServer();
begin
   ZServer.SslEnable := FZServerSecure;         // SSL使用有無
   ZServer.Addr := FZServerHostName;
   ZServer.Port := FZServerPortNumber;
   ZServer.Connect();
end;

procedure TClusterClient.InitProcess();
var
   S: string;
begin
   // BANDコマンド
   S := ZLinkHeader + ' BAND ' + IntToStr(Ord(bUnknown));
   ZServer.SendStr(S + FLineBreak);

   // OPERATORコマンドで端末名を送る
   S := ZLinkHeader + ' OPERATOR ' + FZServerClientName;
   ZServer.SendStr(S + FLineBreak);

   // PCNAMEコマンドで端末名を送る
   S := ZLinkHeader + ' PCNAME ' + FZServerClientName;
   ZServer.SendStr(S + FLineBreak);
end;

end.
