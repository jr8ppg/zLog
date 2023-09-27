unit UClusterClient;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Console, ExtCtrls, Menus, AnsiStrings, ComCtrls, IniFiles,
  Console2, OverbyteIcsWndControl, OverbyteIcsTnCnx, OverbyteIcsWSocket,
  UOptions, USpotClass, UzLogConst, HelperLib;

const
  SPOTMAX = 2000;

type
  TClusterClient = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    Edit: TEdit;
    Panel2: TPanel;
    ListBox: TListBox;
    Console: TColorConsole2;
    Splitter1: TSplitter;
    Telnet: TTnCnx;
    buttonConnect: TButton;
    PopupMenu: TPopupMenu;
    Deleteselectedspots1: TMenuItem;
    MainMenu1: TMainMenu;
    menuFunc: TMenuItem;
    menuSettings: TMenuItem;
    N2: TMenuItem;
    menuExit: TMenuItem;
    ZServer: TWSocket;
    panelShowInfo: TPanel;
    timerShowInfo: TTimer;
    procedure buttonCloseClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerProcess(Sender: TObject);
    procedure TelnetDisplay(Sender: TTnCnx; Str: String);
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
  private
    { Private declarations }
    FSpotExpireMin: Integer; // spot expiration time in minutes
    FSpotGroup: Integer;
    FClusterHostname: string;
    FClusterPortNumber: string;
    FClusterLineBreak: Integer;
    FClusterLoginID: string;
    FClusterAutoLogin: Boolean;
    FClusterAutoReconnect: Boolean;
    FClusterRecordLogs: Boolean;
    FClusterUseAllowDenyLists: Boolean;
    FZServerClientName: string;
    FZServerHostname: string;
    FZServerPortNumber: string;
    FCommBuffer: TStringList;
    FCommTemp: string; {command work string}

    FUseClusterLog: Boolean;
    FClusterLog: TextFile;
    FClusterLogFileName: string;
    FDisconnectClicked: Boolean;
    FAutoLogined: Boolean;

    FSpotterList: TStringList;
    FAllowList: TStringList;
    FDenyList: TStringList;

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
  public
    { Public declarations }
  end;

const
  SPOT_COMMAND: array[1..3] of string = ( 'SPOT', 'SPOT2', 'SPOT3' );

var
   ClusterClient: TClusterClient;

implementation

uses
  UzLogGlobal;

{$R *.DFM}

procedure TClusterClient.FormCreate(Sender: TObject);
begin
   FCommBuffer := TStringList.Create;
   FCommTemp := '';
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
   FAllowList := TStringList.Create();
   FAllowList.Sorted := True;
   FAllowList.CaseSensitive := False;
   FAllowList.Duplicates := dupIgnore;
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
   FAllowList.Free();
   FDenyList.Free();
end;

procedure TClusterClient.FormShow(Sender: TObject);
begin
   ShowInfo(True);
end;

procedure TClusterClient.WriteLine(str: string);
begin
   WriteData(str + LineBreakCode[ord(Console.LineBreak)]);
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

      WriteData(Edit.Text + LineBreakCode[ord(Console.LineBreak)]);

      if boo then begin
         WriteConsole(Edit.Text+LineBreakCode[ord(Console.LineBreak)]);
      end;

      Key := Chr($0);
      Edit.Text := '';
   end;
end;

procedure TClusterClient.LoadSettings();
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      Self.Top := ini.ReadInteger('window', 'top', Self.Top);
      Self.Left := ini.ReadInteger('window', 'left', Self.Left);
      Self.Width := ini.ReadInteger('window', 'width', Self.Width);
      Self.Height := ini.ReadInteger('window', 'height', Self.Height);

      FSpotExpireMin := ini.ReadInteger('general', 'spotexpire', 10);
      FSpotGroup := ini.ReadInteger('general', 'spotgroup', 1);
      FClusterHostName := ini.ReadString('cluster', 'hostname', '');
      FClusterPortNumber := ini.ReadString('cluster', 'port', '7000');
      FClusterLineBreak := ini.ReadInteger('cluster', 'linebreak', 0);
      FClusterLoginID := ini.ReadString('cluster', 'loginid', '');
      FClusterAutoLogin := ini.ReadBool('cluster', 'autologin', False);
      FClusterAutoReconnect := ini.ReadBool('cluster', 'autoreconnect', True);
      FClusterRecordLogs := ini.ReadBool('cluster', 'recordlogs', False);
      FClusterUseAllowDenyLists := ini.ReadBool('cluster', 'use_allow_deny_list', False);
      FZServerClientName := ini.ReadString('zserver', 'clientname', '');
      FZServerHostName := ini.ReadString('zserver', 'hostname', '');
      FZServerPortNumber := ini.ReadString('zserver', 'port', '23');
   finally
      ini.Free();
   end;
end;

procedure TClusterClient.SaveSettings();
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      ini.WriteInteger('window', 'top', Self.Top);
      ini.WriteInteger('window', 'left', Self.Left);
      ini.WriteInteger('window', 'width', Self.Width);
      ini.WriteInteger('window', 'height', Self.Height);

      ini.WriteInteger('general', 'spotexpire', FSpotExpireMin);
      ini.WriteInteger('general', 'spotgroup', FSpotGroup);
      ini.WriteString('cluster', 'hostname', FClusterHostName);
      ini.WriteString('cluster', 'port', FClusterPortNumber);
      ini.WriteInteger('cluster', 'linebreak', FClusterLineBreak);
      ini.WriteString('cluster', 'loginid', FClusterLoginID);
      ini.WriteBool('cluster', 'autologin', FClusterAutoLogin);
      ini.WriteBool('cluster', 'autoreconnect', FClusterAutoReconnect);
      ini.WriteBool('cluster', 'recordlogs', FClusterRecordLogs);
      ini.WriteBool('cluster', 'use_allow_deny_list', FClusterUseAllowDenyLists);

      ini.WriteString('zserver', 'clientname', FZServerClientName);
      ini.WriteString('zserver', 'hostname', FZServerHostName);
      ini.WriteString('zserver', 'port', FZServerPortNumber);
   finally
      ini.Free();
   end;
end;

procedure TClusterClient.ImplementOptions();
var
   i: Integer;
begin
   Console.LineBreak := TConsole2LineBreak(FClusterLineBreak);

   i := Pos(':', FClusterHostName);
   if i = 0 then begin
      Telnet.Host := FClusterHostName;
      Telnet.Port := FClusterPortNumber;
   end
   else begin
      Telnet.Host := Copy(FClusterHostName, 1, i - 1);
      Telnet.Port := Copy(FCLusterHostName, i + 1);
   end;

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
   ListBox.Items.AddObject(Sp.ClusterSummary, Sp);
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
   max , i, j: integer;
   str: string;
   Sp : TSpot;
begin
   max := FCommBuffer.Count - 1;
   for i := 0 to max do begin
      WriteConsole(FCommBuffer.Strings[i]);
   end;

   for i := 0 to max do begin
      str := FCommBuffer.Strings[0];

      // Auto Login
      if (FClusterAutoLogin = True) and (FClusterLoginID <> '') and (FAutoLogined = False) then begin
         if (Pos('login:', str) > 0) or
            (Pos('Please enter your call:', str) > 0) or
            (Pos('Please enter your callsign:', str) > 0) then begin
            Sleep(500);
            WriteLine(FClusterLoginID);
            FAutoLogined := True;
         end;
      end;

      for j := 1 to length(str) do begin
         if str[j] = Chr($0A) then begin
            FCommTemp := TrimCRLF(FCommTemp);

            Sp := TSpot.Create;
            if Sp.Analyze(FCommTemp) = True then begin
               ProcessSpot(Sp);

               // Spotterのチェック
               if FClusterUseAllowDenyLists = True then begin
                  if (FDenyList.Count > 0) and (FDenyList.IndexOf(Sp.ReportedBy) >= 0) then begin
                     Sp.Free();
                     FCommTemp := '';
                     Continue;
                  end;
                  if (FAllowList.Count > 0) and (FAllowList.IndexOf(Sp.ReportedBy) = -1) then begin
                     Sp.Free();
                     FCommTemp := '';
                     Continue;
                  end;
               end;

               // Z-Serverへ送信
               if ZServer.State = wsConnected then begin
                  RelaySpot(FCommTemp);
               end
               else if (ZServer.State = wsClosed) and (ZServer.Addr <> '') then begin
                  ZServer.Addr := FZServerHostName;
                  ZServer.Port := FZServerPortNumber;
                  ZServer.Connect();
               end;

               if FSpotterList.IndexOf(Sp.ReportedBy) = -1 then begin
                  FSpotterList.Add(Sp.ReportedBy);
               end;
            end
            else begin
              Sp.Free;
            end;

            FCommTemp := '';
         end
         else begin
            FCommTemp := FCommTemp + str[j];
         end;
      end;

      FCommBuffer.Delete(0);
   end;
end;

procedure TClusterClient.TimerProcess;
begin
   Timer1.Enabled := False;
   try
      // Auto Reconnect
      if (FClusterAutoReconnect = True) and (Telnet.IsConnected() = False) and
         (FDisconnectClicked = False) and (buttonConnect.Caption = 'Connect') then begin
         buttonConnect.Click();
      end;

      CommProcess;
   finally
      Timer1.Enabled := True;
   end;
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

procedure TClusterClient.TelnetDisplay(Sender: TTnCnx; Str: String);
begin
   FCommBuffer.Add(str);
end;

procedure TClusterClient.buttonConnectClick(Sender: TObject);
begin
   if Telnet.IsConnected then begin
      buttonConnect.Caption := 'Disconnecting...';
      FDisconnectClicked := True;
      Telnet.Close;
      ZServer.Close();
   end
   else begin
      LoadAllowDenyList();
      Telnet.Connect;

      ZServer.Addr := FZServerHostName;
      ZServer.Port := FZServerPortNumber;
      ZServer.Connect();

      buttonConnect.Caption := 'Connecting...';
      FDisconnectClicked := False;
      Timer1.Enabled := True;
      Edit.SetFocus;
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
            Console.WriteString('**** Not enough free disk space (Not Record!) ****');
            FUseClusterLog := False;
         end;
      end;

      buttonConnect.Caption := 'Disconnect';
      WriteLineConsole('connected to ' + Telnet.Host);
      Caption := Application.Title + ' - ' + FClusterHostname + ' [' + FZServerClientName + ']';
      FAutoLogined := False;
   except
      on E: Exception do begin
         Console.WriteString(E.Message);
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

   buttonConnect.Caption := 'Connect';
   Caption := Application.Title;

   fname := ExtractFilePath(Application.ExeName) + 'spotter_list.txt';
   FSpotterList.SaveToFile(fname);
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

procedure TClusterClient.TelnetDataAvailable(Sender: TTnCnx; Buffer: Pointer; Len: Integer);
var
   str : string;
begin
   str := string(AnsiStrings.StrPas(PAnsiChar(Buffer)));
   FCommBuffer.Add(str);
end;

procedure TClusterClient.RelaySpot(S: string);
var
   str: string;
begin
   str := ZLinkHeader + ' ' + SPOT_COMMAND[FSpotGroup] + ' ' + S + LineBreakCode[Ord(Console.LineBreak)];
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
      dlg.ClusterHost := FClusterHostname;
      dlg.ClusterPort := FClusterPortNumber;
      dlg.ClusterLineBreak := FClusterLineBreak;
      dlg.ClusterLoginID := FClusterLoginID;
      dlg.ClusterAutoLogin := FClusterAutoLogin;
      dlg.ClusterAutoReconnect := FClusterAutoReconnect;
      dlg.ClusterRecordLogs := FClusterRecordLogs;
      dlg.ClusterUseAllowDenyLists := FClusterUseAllowDenyLists;
      dlg.ZServerClientName := FZServerClientName;
      dlg.ZServerHost := FZServerHostname;
      dlg.ZServerPort := FZServerPortNumber;

      if dlg.ShowModal() = mrCancel then begin
         Exit;
      end;

      FSpotExpireMin := dlg.SportExpireMin;
      FSpotGroup := dlg.SpotGroup;
      FClusterHostname := dlg.ClusterHost;
      FClusterPortNumber := dlg.ClusterPort;
      FClusterLineBreak := dlg.ClusterLineBreak;
      FClusterLoginID := dlg.ClusterLoginID;
      FClusterAutoLogin := dlg.ClusterAutoLogin;
      FClusterAutoReconnect := dlg.ClusterAutoReconnect;
      FClusterRecordLogs := dlg.ClusterRecordLogs;
      FClusterUseAllowDenyLists := dlg.ClusterUseAllowDenyLists;
      FZServerClientName := dlg.ZServerClientName;
      FZServerHostname := dlg.ZServerHost;
      FZServerPortNumber := dlg.ZServerPort;

      ImplementOptions();
      SaveSettings();
   finally
      dlg.Release();
   end;
end;

procedure TClusterClient.WriteLineConsole(str : string);
begin
   WriteConsole(str + LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TClusterClient.ZServerSessionClosed(Sender: TObject; ErrCode: Word);
begin
   ShowInfo(True);
end;

procedure TClusterClient.ZServerSessionConnected(Sender: TObject; ErrCode: Word);
var
   S: string;
begin
   ShowInfo(False);

   // BANDコマンド
   S := ZLinkHeader + ' BAND ' + IntToStr(Ord(bUnknown));
   ZServer.SendStr(S + LineBreakCode[Ord(Console.LineBreak)]);

   // OPERATORコマンドで端末名を送る
   S := ZLinkHeader + ' OPERATOR ' + FZServerClientName;
   ZServer.SendStr(S + LineBreakCode[Ord(Console.LineBreak)]);
end;

procedure TClusterClient.WriteConsole(strText: string);
begin
   Console.WriteString(strText);

   try
      if (FClusterRecordLogs = True) and (FUseClusterLog = True) then begin
         Write(FClusterLog, strText);
         Flush(FClusterLog);
      end;
   except
      on E: Exception do begin
         Console.WriteString(E.Message);
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
   FAllowList.Clear();
   FDenyList.Clear();

   fname := ExtractFilePath(Application.ExeName) + 'spotter_list.txt';
   if FileExists(fname) then begin
      FSpotterList.LoadFromFile(fname);
   end;

   fname := ExtractFilePath(Application.ExeName) + 'spotter_allow.txt';
   if FileExists(fname) then begin
      FAllowList.LoadFromFile(fname);
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

end.
