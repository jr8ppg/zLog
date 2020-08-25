unit UComm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Console, ExtCtrls, Menus, AnsiStrings, ComCtrls,
  Console2, USpotClass, CPDrv, UzLogConst, UzLogGlobal, UzLogQSO, HelperLib,
  OverbyteIcsWndControl, OverbyteIcsTnCnx, Vcl.ExtDlgs;

const
  SPOTMAX = 2000;

type
  TCommForm = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    Button1: TButton;
    Edit: TEdit;
    Panel2: TPanel;
    ListBox: TListBox;
    StatusLine: TStatusBar;
    Console: TColorConsole2;
    Splitter1: TSplitter;
    Telnet: TTnCnx;
    ConnectButton: TButton;
    StayOnTop: TCheckBox;
    Relay: TCheckBox;
    cbNotifyCurrentBand: TCheckBox;
    ClusterComm: TCommPortDriver;
    PopupMenu: TPopupMenu;
    menuSaveToFile: TMenuItem;
    SaveTextFileDialog1: TSaveTextFileDialog;
    procedure CommReceiveData(Buffer: Pointer; BufferLength: Word);
    procedure Button1Click(Sender: TObject);
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
    procedure CreateParams(var Params: TCreateParams); override;
    //procedure AsyncCommRxChar(Sender: TObject; Count: Integer);
    procedure FormShow(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
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
  private
    { Private declarations }
    CommBuffer : TStringList;
    CommTemp : string; {command work string}
    CommStarted : boolean;
    _RelayPacketData : boolean;
    function GetFontSize(): Integer;
    procedure SetFontSize(v: Integer);
  public
    { Public declarations }
    SpotList : TSpotList;
    procedure DeleteSpot(_from, _to : integer);
    procedure RenewListBox;
    procedure ProcessSpot(Sp : TSpot);
    procedure PreProcessSpotFromZLink(S : string);
    procedure TransmitSpot(S : string); // local or via network
    procedure ImplementOptions;
    procedure CommProcess;
    procedure WriteData(str : string);
    procedure WriteLine(str : string); // adds linebreak
    procedure WriteLineConsole(str : string);
    procedure WriteConsole(str : string);
    procedure EnableConnectButton(boo : boolean);
    function MaybeConnected : boolean; {returns false if port = telnet and
                                         not connected but doesn't know abt
                                         packet }
    procedure WriteStatusLine(S : string);
    procedure Renew; // red or black
    procedure RemoteConnectButtonPush;
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

implementation

uses
  Main, UOptions, UZLinkForm, URigControl, UBandScope2, UzLogSpc;

{$R *.DFM}

procedure TCommForm.DeleteSpot(_from, _to : integer);
var
   i : integer;
begin
   if _from < 0 then
      exit;

   if _to < _from then
      exit;

   if _to > SpotList.Count - 1 then
      exit;

   for i := _from to _to do begin
      SpotList.Delete(_from);
      ListBox.Items.Delete(_from);
   end;
end;

procedure TCommForm.WriteStatusLine(S : string);
begin
   StatusLine.SimpleText := S;
end;

function TCommForm.MaybeConnected : boolean;
begin
   if (dmZlogGlobal.Settings._clusterport = 7) and (Telnet.IsConnected = False) then
      Result := False
   else
      Result := True;
end;

procedure TCommForm.EnableConnectButton(boo : boolean);
begin
   ConnectButton.Enabled := boo;
end;

procedure TCommForm.WriteLine(str: string);
begin
   WriteData(str + LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TCommForm.WriteLineConsole(str : string);
begin
   Console.WriteString(str+LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TCommForm.WriteConsole(str : string);
begin
   Console.WriteString(str);
end;

procedure TCommForm.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TCommForm.WriteData(str : string);
begin
   case dmZlogGlobal.Settings._clusterport of
      1..6: begin
         if ClusterComm.Connected then begin
            ClusterComm.SendString(AnsiString(str));
         end;
      end;

      7: begin
         if Telnet.IsConnected then begin
            Telnet.SendStr(str);
         end;
      end;
   end;
end;

procedure TCommForm.CommReceiveData(Buffer: Pointer; BufferLength: Word);
var
   str : string;
begin
   str := string(AnsiStrings.StrPas(PAnsiChar(Buffer)));
   CommBuffer.Add(str);
end;

procedure TCommForm.Button1Click(Sender: TObject);
begin
   Close;
end;

procedure TCommForm.EditKeyPress(Sender: TObject; var Key: Char);
var
   boo, noport : boolean;
   s : string;
begin
   noport := False;
   boo := False;

   case dmZlogGlobal.Settings._clusterport of
      0 : noport := True;
      1..6 : boo := dmZlogGlobal.Settings._cluster_com.FLocalEcho;
      7 : boo := dmZlogGlobal.Settings._cluster_telnet.FLocalEcho;
   end;

   s := '';
   if Key = Chr($0D) then begin
      if pos('RELAY', UpperCase(Edit.Text)) = 1 then begin
         if pos('ON', UpperCase(Edit.Text)) > 0 then begin
            _RelayPacketData := True;
         end
         else begin
            _RelayPacketData := False;
         end;

         WriteLineConsole(Edit.Text);
         exit;
      end;

      if noport then begin
         MainForm.ZLinkForm.SendRemoteCluster(Edit.Text);
      end
      else begin
         WriteData(Edit.Text+LineBreakCode[ord(Console.LineBreak)]);
      end;

      if boo then begin
         Console.WriteString(Edit.Text+LineBreakCode[ord(Console.LineBreak)]);
      end;

      Key := Chr($0);
      Edit.Text := '';
   end;

   case Key of
      ^A, ^B, ^C, ^D, ^E, ^F, ^G, {^H,} ^I, ^J, ^K, ^L,
      ^M, ^N, ^O, ^P, ^Q, ^R, ^S, ^T, ^U, ^V, ^W, ^X, ^Y, ^Z: begin
         s := s + Key;
         if noport then begin
            MainForm.ZLinkForm.SendRemoteCluster(s);
         end
         else begin
            WriteData(s);
         end;
      end;
   end;
end;

procedure TCommForm.ImplementOptions;
var
   i: Integer;
begin
   if dmZlogGlobal.Settings._clusterbaud <> 99 then begin
      ClusterComm.BaudRate := TBaudRate(dmZlogGlobal.Settings._clusterbaud+1);
   end;

   if dmZlogGlobal.Settings._clusterport in [1..6] then begin
      ClusterComm.Port := TPortNumber(dmZlogGlobal.Settings._clusterport);
      ClusterComm.Connect;
   end
   else begin
      ClusterComm.Disconnect;
   end;

   case dmZlogGlobal.Settings._clusterport of
      1..6 : Console.LineBreak := TConsole2LineBreak(dmZlogGlobal.Settings._cluster_com.FLineBreak);
      7 :    Console.LineBreak := TConsole2LineBreak(dmZlogGlobal.Settings._cluster_telnet.FLineBreak);
   end;

   i := Pos(':', dmZlogGlobal.Settings._cluster_telnet.FHostName);
   if i = 0 then begin
      Telnet.Host := dmZlogGlobal.Settings._cluster_telnet.FHostName;
      Telnet.Port := IntToStr(dmZlogGlobal.Settings._cluster_telnet.FPortNumber);
   end
   else begin
      Telnet.Host := Copy(dmZlogGlobal.Settings._cluster_telnet.FHostName, 1, i - 1);
      Telnet.Port := Copy(dmZlogGlobal.Settings._cluster_telnet.FHostName, i + 1);
   end;
end;

procedure TCommForm.FormCreate(Sender: TObject);
begin
   _RelayPacketData := False;
   SpotList := TSpotList.Create;
   CommStarted := False;
   CommBuffer := TStringList.Create;
   CommTemp := '';
   Timer1.Enabled := True;
   ImplementOptions;
end;

procedure TCommForm.RenewListBox;
var
   i: Integer;
begin
   ListBox.Clear;
   for i := 0 to SpotList.Count - 1 do begin
      ListBox.AddItem(SpotList[i].ClusterSummary, SpotList[i]);
   end;
   ListBox.ShowLast();
end;

procedure TCommForm.PreProcessSpotFromZLink(S : string);
var
   Sp : TSpot;
   B : TBand;
begin
   Sp := TSpot.Create;
   if Sp.Analyze(S) = True then begin
      B := Sp.Band; // 1.9c modified to filter out unrelevant bands
      if MainForm.BandMenu.Items[ord(B)].Visible and
         MainForm.BandMenu.Items[ord(B)].Enabled then begin

         // データ発生源はZ-Server
         Sp.SpotSource := ssClusterFromZServer;

         ProcessSpot(Sp);
      end
      else begin
         Sp.Free;
      end;
   end
   else begin
      Sp.Free;
   end;
end;

procedure TCommForm.ProcessSpot(Sp : TSpot);
var
   i : integer;
   S : TSpot;
   dupe, _deleted : boolean;
   Expire : double;
begin
   dupe := false;
   _deleted := false;

   Expire := dmZlogGlobal.Settings._spotexpire / (60 * 24);

   for i := SpotList.Count - 1 downto 0 do begin
      S := SpotList[i];
      if Now - S.Time > Expire then begin
         SpotList.Delete(i);
         _deleted := True;
      end;

      if (S.Call = Sp.Call) and (S.FreqHz = Sp.FreqHz) then begin
         dupe := True;
         break;
      end;
   end;

   if _deleted then begin
      RenewListBox;
   end;

   if SpotList.Count > SPOTMAX then begin
      exit;
   end;

   if dupe then begin
      exit;
   end;

   // 交信済みチェック
   SpotCheckWorked(Sp);

   // Spotリストへ追加
   SpotList.Add(Sp);

   if cbNotifyCurrentBand.Checked and (Sp.Band <> Main.CurrentQSO.Band) then begin
   end
   else begin
      MyContest.MultiForm.ProcessCluster(TBaseSpot(Sp));
   end;

   ListBox.AddItem(Sp.ClusterSummary, Sp);
   ListBox.ShowLast();

   // BandScopeに登録
   MainForm.BandScopeAddClusterSpot(Sp);
end;

procedure TCommForm.TransmitSpot(S : string); // local or via network
begin
   if dmZlogGlobal.Settings._clusterport = 0 then begin
      MainForm.ZLinkForm.SendSpotViaNetwork(S);
   end
   else begin
      WriteLine(S);
   end;
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

procedure TCommForm.CommProcess;
var
   max , i, j: integer;
   str: string;
   Sp : TSpot;
begin
   max := CommBuffer.Count - 1;
   for i := 0 to max do begin
      Console.WriteString(CommBuffer.Strings[i]);
   end;

   for i := 0 to max do begin
      str := CommBuffer.Strings[0];
      for j := 1 to length(str) do begin
         if (str[j] = Chr($0D)) or (str[j] = Chr($0A)) then begin
            if _RelayPacketData then begin
               MainForm.ZLinkForm.SendPacketData(TrimCRLF(CommTemp));
            end;

            Sp := TSpot.Create;
            if Sp.Analyze(CommTemp) = True then begin
               // データ発生源はCluster
               Sp.SpotSource := ssCluster;

               ProcessSpot(Sp);

               if Relay.Checked then begin
                  MainForm.ZLinkForm.RelaySpot(CommTemp);
               end;
            end
            else begin
              Sp.Free;
            end;

            CommTemp := '';
         end
         else begin
            CommTemp := CommTemp + str[j];
         end;
      end;

      CommBuffer.Delete(0);
   end;
end;

procedure TCommForm.TimerProcess;
begin
   CommProcess;
end;

procedure TCommForm.FormDestroy(Sender: TObject);
begin
   inherited;
   ClusterComm.Disconnect;
   ClusterComm.Free;
   SpotList.Free();
   CommBuffer.Free();
end;

procedure TCommForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE : MainForm.LastFocus.SetFocus;
   end;
end;

procedure TCommForm.TelnetDisplay(Sender: TTnCnx; Str: String);
begin
   CommBuffer.Add(str);
end;

procedure TCommForm.ConnectButtonClick(Sender: TObject);
begin
   Edit.SetFocus;

   if dmZlogGlobal.Settings._clusterport = 0 then begin
      MainForm.ZLinkForm.PushRemoteConnect;
      exit;
   end;

   if Telnet.IsConnected then begin
      Telnet.Close;
      ConnectButton.Caption := 'Disconnecting...';
   end
   else begin
      Telnet.Connect;
      ConnectButton.Caption := 'Connecting...';
   end;
end;

procedure TCommForm.RemoteConnectButtonPush;
begin
   if (dmZlogGlobal.Settings._clusterport = 0) then begin
      //ZLinkForm.PushRemoteConnect;
      exit;
   end;

   if Telnet.IsConnected then begin
      //Telnet.Close;
      //ConnectButton.Caption := 'Disconnecting...';
   end
   else begin
      Telnet.Connect;
      ConnectButton.Caption := 'Connecting...';
   end;
end;

procedure TCommForm.TelnetSessionConnected(Sender: TTnCnx; Error: Word);
begin
   ConnectButton.Caption := 'Disconnect';
   Console.WriteString('connected to '+Telnet.Host);
end;

procedure TCommForm.TelnetSessionClosed(Sender: TTnCnx; Error: Word);
begin
   Console.WriteString('disconnected...');
   ConnectButton.Caption := 'Connect';
end;

procedure TCommForm.FormShow(Sender: TObject);
begin
   ConnectButton.Enabled := (dmZlogGlobal.Settings._clusterport = 7);
end;

procedure TCommForm.StayOnTopClick(Sender: TObject);
begin
   if StayOnTop.Checked then begin
      FormStyle := fsStayOnTop;
   end
   else begin
      FormStyle := fsNormal;
   end;
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
      if SP.NewMulti then begin
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

   CommBuffer.Add(string(str));
end;

procedure TCommForm.TelnetDataAvailable(Sender: TTnCnx; Buffer: Pointer; Len: Integer);
var
   str : string;
begin
   str := string(AnsiStrings.StrPas(PAnsiChar(Buffer)));
   CommBuffer.Add(str);
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

end.
