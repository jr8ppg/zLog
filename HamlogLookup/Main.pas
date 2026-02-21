{
  H a m l o g L o o k u p

  COPYRIGHT (c) 2026 JR8PPG
}
unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  System.Math, System.UITypes, System.IniFiles, System.StrUtils,
  Vcl.ExtCtrls, Vcl.ComCtrls, WinApi.CommCtrl, Vcl.Menus, Winapi.WinSock,
  System.Generics.Collections, System.DateUtils,
  UOptions, Hamlog50, HamlogIf;

const
  WM_HAMLOGLOOKUP_INIT = (WM_USER + 1);

type
  TformHamlogLookup = class(TForm)
    editCallsign: TEdit;
    buttonQuery: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    checkZlog: TCheckBox;
    ListView1: TListView;
    timerLogSync: TTimer;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    F1: TMenuItem;
    menuExit: TMenuItem;
    menuOptions: TMenuItem;
    checkStayOnTop: TCheckBox;
    N1: TMenuItem;
    procedure buttonQueryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure timerLogSyncTimer(Sender: TObject);
    procedure checkZlogClick(Sender: TObject);
    procedure editCallsignEnter(Sender: TObject);
    procedure editCallsignExit(Sender: TObject);
    procedure checkAroundClick(Sender: TObject);
    procedure ListView1AdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure menuExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure menuOptionsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure checkStayOnTopClick(Sender: TObject);
    procedure editCallsignKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editCallsignChange(Sender: TObject);
    procedure OnHamlogLookupInit( var Message: TMessage ); message WM_HAMLOGLOOKUP_INIT;
  private
    { Private 宣言 }

    // 設定項目
    FDisplayMax: Integer;
    FPastYears: Integer;
    FScanInterval: Integer;
    FIncremental: Boolean;
    FInitZLogLink: Boolean;

    // zLog
    m_zLogV28: Boolean;

    // zLog/N1MM+/CTESTWIN
    FLoggerWnd: HWND;

    m_strPrevCallsign: string;
    FLogFileName: string;

    FHamlog: THamlogData;
    FHamlogOpend: Boolean;
    FHamlogDatabaseName: string;

    procedure HamlogLookup1(strCallsign: string);
    function FindQso(strCallsign: string): THamlogQsoList;
    function GetCallsign(strCallsign: string): string;
    procedure SetCaption();
    procedure LogWrite(msg: string);

    procedure LoadSettings();
    procedure SaveSettings();

    procedure HamlogOpen();

    function FindZlogWindow(): HWND;
    function Find_zLog(): HWND;

  public
    { Public 宣言 }
    procedure GoZlogLookup();
  end;

var
  formHamlogLookup: TformHamlogLookup;

implementation

uses
   Progress, SelectZlog;

{$R *.dfm}

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.FormCreate(Sender: TObject);
begin
   m_strPrevCallsign := '';
   m_zLogV28 := False;
   FHamlogOpend := False;

   FHamlog := THamlogData.Create();

   FLogFileName := ExtractFilePath(Application.ExeName) +
                   ChangeFileExt(ExtractFileName(Application.ExeName), '') + '_' + FormatDateTime('yyyymmdd', Now) + '.log';

   LoadSettings();
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FHamlog.Close();
   timerLogSync.Enabled := False;
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.FormDestroy(Sender: TObject);
begin
   FHamlog.Free();
   SaveSettings();
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.FormShow(Sender: TObject);
begin
   PostMessage(Handle, WM_HAMLOGLOOKUP_INIT, 0, 0);
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.FormActivate(Sender: TObject);
begin
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.buttonQueryClick(Sender: TObject);
var
   nLen: Integer;
   strCallsign: string;
begin
   if (FHamlogDatabaseName = '') or (FHamlogOpend = False) then begin
      MessageBox(Handle, PChar('HAMLOGデータベースを設定して下さい.'), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      Exit;
   end;

   if editCallsign.Text = '' then begin
      ListView1.Items.Clear();
      StatusBar1.Panels[0].Text := '';
      StatusBar1.Panels[1].Text := '';
      Exit;
   end;

   strCallsign := editCallsign.Text;
   nLen := Length(strCallsign);

   // インクリメンタルサーチは３文字から
   if (FIncremental = True) and (nLen < 3) then begin
      Exit;
   end
   // ５文字の場合は先頭二文字がJAの場合のみ
   else if (FIncremental = False) then begin
      if (nLen = 5) and (Copy(strCallsign, 1, 2) <> 'JA') then begin
         Exit;
      end;
      if (nLen < 6) then begin
         Exit;
      end;
   end;

   // 前回と同じコールは除く
   if (m_strPrevCallsign = strCallsign) then begin
      Exit;
   end;

   // 照会
   HamlogLookup1(editCallsign.Text);

   m_strPrevCallsign := strCallsign;

   editCallsign.SetFocus();
   editCallsign.SelectAll();
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.editCallsignChange(Sender: TObject);
var
   strCallsign: string;
   nLen: Integer;
begin
   if FIncremental = False then begin
      Exit;
   end;

   strCallsign := editCallsign.Text;
   nLen := Length(strCallsign);

   // インクリメンタルサーチは３文字から
   if nLen < 3 then begin
      Exit;
   end;

   // 照会
   HamlogLookup1(editCallsign.Text);

   m_strPrevCallsign := '';
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.editCallsignEnter(Sender: TObject);
begin
   buttonQuery.Default := True;
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.editCallsignExit(Sender: TObject);
begin
   buttonQuery.Default := False;
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.editCallsignKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then begin
      Key := 0;
   end;
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.checkAroundClick(Sender: TObject);
begin
   if editCallsign.Text <> '' then begin
      editCallsign.SetFocus();
      buttonQuery.Click();
   end;
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.checkStayOnTopClick(Sender: TObject);
begin
   if checkStayOnTop.Checked = True then begin
      Self.FormStyle := fsStayOnTop;
   end
   else begin
      Self.FormStyle := fsNormal;
   end;
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.checkZlogClick(Sender: TObject);
begin
   timerLogSync.Enabled := False;
   try
      if checkZLog.Checked = False then begin
         Exit;
      end;

      FLoggerWnd := Find_zlog();
      if FLoggerWnd = 0 then begin
         checkZLog.Checked := False;
         Exit;
      end;

      timerLogSync.Enabled := True;
   finally
      SetCaption();
   end;
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.OnHamlogLookupInit( var Message: TMessage );
begin
   HamlogOpen();
   editCallsign.SetFocus();
   checkZlog.Checked := FInitZLogLink;
   checkZlogClick(checkZlog);
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.HamlogLookup1(strCallsign: string);
var
   i: Integer;
   listitem: TListItem;
   dwTick: DWORD;
   Q: THamlogQso;
   list: THamlogQsoList;
begin
   list := nil;
   dwTick := GetTickCount();
   ListView1.Items.BeginUpdate();
   ListView1.Items.Clear();
   StatusBar1.Panels[0].Text := 'QUERY';
   Application.ProcessMessages();

   // ポータブルはコールサイン本体部のみで
   strCallsign := GetCallsign(strCallsign);

   // 照会
   try
      list := FindQso(strCallsign);

      list.SortByDate(False);

      for i := 0 to Min(FDisplayMax, list.Count) - 1 do begin
         Q := list[i];

         listitem := ListView1.Items.Add();
         listitem.Caption := Q.Callsign;
         listitem.SubItems.Add(Q.Date);
         listitem.SubItems.Add(Q.Time);
         listitem.SubItems.Add(Q.Freq);
         listitem.SubItems.Add(Q.Mode);
         listitem.SubItems.Add(Q.Code);
         listitem.SubItems.Add(Q.Name);
         listitem.SubItems.Add(Q.Qth);
         listitem.SubItems.Add(Q.Rmk1);
         listitem.SubItems.Add(Q.Rmk2);
         listitem.SubItems.Add(Q.QSL);
      end;

      StatusBar1.Panels[0].Text := IntToStr(GetTickCount() - dwTick) + ' ms';
      StatusBar1.Panels[1].Text := IntToStr(list.Count) + 'QSOs';
      StatusBar1.Panels[2].Text := strCallsign;
//      StatusBar1.Panels[3].Text := list.LastUpdate;
      StatusBar1.Panels[4].Text := '';

   finally
      list.Free();
      ListView1.Items.EndUpdate();
   end;
end;

// ----------------------------------------------------------------------------

function TformHamlogLookup.FindQso(strCallsign: string): THamlogQsoList;
var
   list: THamlogQsoList;
   Q: THamlogQso;
   n: Integer;
   l: Integer;
   dtPastLimit: TDateTime;
begin
   list := THamlogQsoList.Create();
   l := Length(strCallsign);
   try
      if FHamlog.FindFirst(strCallsign) = False then begin
         Exit;
      end;

      dtPastLimit := Now();
      dtPastLimit := IncYear(dtPastLimit, FPastYears * -1);

      n := FHamlog.Count;
      Q := FHamlog.Items[n - 1];

      if Copy(GetCallsign(Q.Callsign), 1, l) <> strCallsign then begin
         Exit;
      end;

      if Q.DateTime >= dtPastLimit then begin
         list.Add(Q);
      end;

      while FHamlog.FindNext() = True do begin
//         Application.ProcessMessages();

         n := FHamlog.Count;
         Q := FHamlog.Items[n - 1];

         if Q.DateTime < dtPastLimit then begin
            Continue;
         end;


         if Copy(GetCallsign(Q.Callsign), 1, l) <> strCallsign then begin
            Break;
         end;

         list.Add(Q);
      end;
   finally
      Result := list;
   end;
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.ListView1AdvancedCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
var
   sx, sy, ex, ey: Integer;
   x, y: Integer;
   i: Integer;
   strText: string;
   bg, fg: TColor;
   fs: TFontStyles;
   backrect: TRect;
   rr: TRect;
   offset: Integer;
   colwidth: Integer;
   rect: TRect;
begin
   if Stage = cdPrePaint then begin
      // １行のRect
      rect := Item.DisplayRect(drBounds);

      sx := rect.Left;

      //
      // 文字の描画
      //
      for i := 0 to TListView(Sender).Columns.Count - 1 do begin
         colwidth := ListView_GetColumnWidth( Sender.Handle, i );

         if i = 0 then begin
            strText := Item.Caption;
         end
         else begin
            strText := Item.SubItems[i - 1];
         end;

         fg := clBlack;
         fs := Sender.Canvas.Font.Style;
         fs := fs - [fsBold];
         fs := fs - [fsItalic];
         bg := clWhite;

         // この行が検索対象なら
         if Item.Caption = editCallsign.Text then begin
            fs := fs + [fsBold];
            bg := clYellow;
         end;

         // 選択中
         if Item.Selected = True then begin
            if Focused then begin
               fg := clWhite;
               bg := $FF9933;
            end
            else begin
               fg := clBlack;
               bg := $F0F0F0;
            end;
         end;

         Sender.Canvas.Font.Color := fg;
         Sender.Canvas.Font.Size := 10;
         Sender.Canvas.Brush.Color := bg;
         Sender.Canvas.Font.Style := fs;

         // 背景を塗る

         // 描画領域の特定
         backrect.Top := rect.Top;
         backrect.Bottom := rect.Bottom;
         backrect.Left := sx + 1;
         backrect.Right := sx + colwidth;

         // 背景色の描画
         Sender.Canvas.FillRect(backrect);

         // rr:各アイテムのクリップ領域
         rr.Top := rect.Top;
         rr.Bottom := rect.Bottom;
         rr.Left := sx;
         rr.Right := sx + colwidth - 2;

         offset := 1;

         // 左右寄せ・センタリング
         sy := rect.Top + (((rect.Bottom - rect.Top) - Sender.Canvas.TextHeight('ABC')) div 2);

         x := sx + 2 + offset;
         y := sy;

         // TextRect()はExtTextOut()なのでBrush色では無く
         // 背景色(SetBkColor()した色)で塗られる
         SetTextColor(Sender.Canvas.Handle, fg);
         SetBkColor(Sender.Canvas.Handle, bg);
         SelectObject(Sender.Canvas.Handle, Sender.Canvas.Font.Handle);
         Sender.Canvas.TextRect(rr, x, y, strText);

         // 次の描画位置
         sx := sx + colwidth;
      end;

      //
      // グリッド線の描画
      //
      Sender.Canvas.Pen.Style := psSolid;
      Sender.Canvas.Pen.Color := $F0F0F0;
      Sender.Canvas.Brush.Style := bsClear;

      // 縦線の描画
      sx := rect.Left;
      for i := 0 to TListView(Sender).Columns.Count - 1 do begin
         sx := sx + ListView_GetColumnWidth(Sender.Handle, i);
         sy := rect.Top - 1;
         ex := sx;
         ey := rect.Bottom;

         Sender.Canvas.MoveTo(sx, sy);
         Sender.Canvas.LineTo(ex, ey);
      end;

      Sender.Canvas.Brush.Style := bsSolid;
      Sender.Canvas.Brush.Color := $F0F0F0;
      rr.Top := rect.Top - 1;
      rr.Left := rect.Left;
      rr.Right := rect.Right + 1;
      rr.Bottom := rect.Bottom;
      Sender.Canvas.FrameRect(rr);

      DefaultDraw := False;
   end
   else begin
      DefaultDraw := True;
   end;
end;

// ----------------------------------------------------------------------------

// メニュー：オプション

procedure TformHamlogLookup.menuOptionsClick(Sender: TObject);
var
   dlg: TformOptions;
begin
   dlg := TformOptions.Create(Self);
   try
      FInitZLogLink := checkZlog.Checked;
      checkZlog.Checked := False;
      FHamlog.Close();
      FHamlogOpend := False;

      dlg.DatabaseName := FHamlogDatabaseName;
      dlg.DisplayCount := FDisplayMax;
      dlg.PastYears := FPastYears;
      dlg.Incremental := FIncremental;

      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

      FHamlogDatabaseName := dlg.DatabaseName;
      FDisplayMax := dlg.DisplayCount;
      FPastYears := dlg.PastYears;
      FIncremental := dlg.Incremental;

      SaveSettings();
   finally
      dlg.Release();
      PostMessage(Handle, WM_HAMLOGLOOKUP_INIT, 0, 0);
   end;
end;

// ----------------------------------------------------------------------------

// メニュー：終了

procedure TformHamlogLookup.menuExitClick(Sender: TObject);
begin
   Close();
end;

// ----------------------------------------------------------------------------

// タイマー

procedure TformHamlogLookup.timerLogSyncTimer(Sender: TObject);
begin
   timerLogSync.Enabled := False;
   try
   try
      if FLoggerWnd <> 0 then begin
         GoZlogLookup();
      end;
   except
      on E: Exception do begin
         LogWrite('*** Exception in timerLogSyncTimer() ***');
         LogWrite(E.Message);
         LogWrite(E.StackTrace);
      end;
   end;
   finally
      timerLogSync.Enabled := True;
   end;
end;

// ----------------------------------------------------------------------------

function TformHamlogLookup.GetCallsign(strCallsign: string): string;
var
   Index: Integer;
   strLeft, strRight: string;
begin
   Index := Pos('/', strCallsign);
   if Index = 0 then begin
      Result := strCallsign;
      Exit;
   end;

   strLeft := Copy(strCallsign, 1, Index - 1);
   strRight := Copy(strCallsign, Index + 1);

   if Length(strLeft) >= Length(strRight) then begin
      Result := strLeft;
   end
   else begin
      Result := strRight;
   end;
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.GoZlogLookup();
var
   szWindowText: array[0..1024] of Char;
   nLen: Integer;
//   strText: string;
   strCallsign: string;
//   strCountry, strCQZone, strITUZone, strState: string;
   callsign_atom: ATOM;
begin
   try
      ZeroMemory(@szWindowText, SizeOf(szWindowText));

      if m_zLogV28 = True then begin
         nLen := SendMessage(FLoggerWnd, (WM_USER + 200), 0, 0);
         callsign_atom := LOWORD(nLen);
         if callsign_atom = 0 then begin
            Exit;
         end;

         nLen := GlobalGetAtomName(callsign_atom, PChar(@szWindowText), SizeOf(szWindowText));
         if (nLen = 0) then begin
            Exit;
         end;

         GlobalDeleteAtom(callsign_atom);
      end
      else begin
         nLen := SendMessage(FLoggerWnd, WM_GETTEXT, SizeOf(szWindowText), LPARAM(PChar(@szWindowText)));
      end;

      strCallsign := szWindowText;

      if editCallsign.Text <> strCallsign then begin
         editCallsign.Text := strCallsign;

         if strCallsign = '' then begin
            Exit;
         end;

         buttonQueryClick(nil);
      end;
   finally
   end;
end;

// ----------------------------------------------------------------------------

function TformHamlogLookup.FindZlogWindow(): HWND;
var
   hZlogWnd: HWND;
   szCaption: array[0..1024] of Char;
   strCaption: string;
   nLen: Integer;
   slWindows: TStringList;
   f: TformSelectZLog;
   childwnd: HWND;
begin
   f := TformSelectZLog.Create(Self);
   slWindows := TStringList.Create();
   try
      hZlogWnd := GetTopWindow(0);
      repeat
         nLen := GetWindowText(hZlogWnd, szCaption, SizeOf(szCaption));
         if nLen > 0 then begin
            strCaption := StrPas(szCaption);
            if Pos('zLog - ', strCaption) > 0 then begin
               // 子ウインドウを持たないウインドウは除外
               childwnd := GetWindow(hZlogWnd, GW_CHILD);
               if (childwnd <> 0) then begin
                  slWindows.AddObject(strCaption, TObject(hZlogWnd));
               end;
            end;
         end;

         hZlogWnd := GetNextWindow(hZlogWnd, GW_HWNDNEXT)
      until hZlogWnd = 0;

      if slWindows.Count = 0 then begin
         Result := 0;
      end
      else if slWindows.Count = 1 then begin
         Result := HWND(slWindows.Objects[0]);
      end
      else begin  // >= 2
         f.List := slWindows;
         if f.ShowModal() <> mrOK then begin
            Result := 0;
            Exit;
         end;

         Result := HWND(slWindows.Objects[f.SelectedIndex]);
      end;
   finally
      slWindows.Free();
      f.Release();
   end;
end;

// ----------------------------------------------------------------------------

function TformHamlogLookup.Find_zLog(): HWND;
var
   hZlogWnd: HWND;
   wnd: HWND;
   ver: Integer;
begin
   // zLogのコントロールを調べる
   hZlogWnd := FindZlogWindow();
   if (hZlogWnd = 0) then begin
      Application.MessageBox('zLog 令和Edition V3が見つかりません', PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      Result := 0;
      Exit;
   end;

   // zLog V2.8以降か調べる
   ver := SendMessage(hZlogWnd, (WM_USER + 201), 0, 0);
   if ver >= 2800 then begin
      m_zLogV28 := True;
      Result := hZlogWnd;
      Exit;
   end
   else begin
      m_zLogV28 := False;
   end;

   // 最初の子ウインドウ
   wnd := GetWindow(hZlogWnd, GW_CHILD);
   if (wnd = 0) then begin
      Application.MessageBox('can not find first child window', PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      Result := 0;
      Exit;
   end;

   // 次のウインドウ　たぶんこれが対象のパネル
   wnd := GetWindow(wnd, GW_HWNDNEXT);
   if (wnd = 0) then begin
      Result := 0;
      Exit;
   end;

   // timeのTOvrEdit
   wnd := GetWindow(wnd, GW_CHILD);
   if (wnd = 0) then begin
      Result := 0;
      Exit;
   end;

   // memo欄
   wnd := GetWindow(wnd, GW_HWNDNEXT);
   if (wnd = 0) then begin
      Result := 0;
      Exit;
   end;

   // rcvd
   wnd := GetWindow(wnd, GW_HWNDNEXT);
   if (wnd = 0) then begin
      Result := 0;
      Exit;
   end;

   // callsign
   wnd := GetWindow(wnd, GW_HWNDNEXT);
   if (wnd = 0) then begin
      Result := 0;
      Exit;
   end;

   Result := wnd;
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.SetCaption();
var
   S: string;
begin
   S := 'HAMLOGLookup';

   if (FHamlogDatabaseName = '') or (FHamlogOpend = False) then begin
      checkZlog.Enabled := False;
   end
   else begin
      checkZlog.Enabled := True;
      S := S +  ' - ' + FHamlogDatabaseName;
   end;

   Caption := S;
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.LogWrite(msg: string);
var
   str: string;
   txt: TextFile;
begin
   AssignFile(txt, FLogFileName);
   if FileExists(FLogFileName) then begin
      Reset(txt);
   end
   else begin
      Rewrite(txt);
   end;

   str := FormatDateTime( 'yyyy/mm/dd hh:nn:ss ', Now ) + msg;

   Append( txt );
   WriteLn( txt, str );
   Flush( txt );
   CloseFile( txt );
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.LoadSettings();
var
   ini: TIniFile;
   x, y: Integer;
   w, h: Integer;
   n: Integer;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      x := ini.ReadInteger('SETTINGS', 'X', -1);
      y := ini.ReadInteger('SETTINGS', 'Y', -1);
      w := ini.ReadInteger('SETTINGS', 'W', -1);
      h := ini.ReadInteger('SETTINGS', 'H', -1);
      if (x > -1) and (y > -1) then begin
         Left := x;
         Top := y;
         Position := poDesigned;
      end
      else begin
         Position := poDefaultPosOnly;
      end;

      if w > -1 then begin
         Width := w;
      end;

      if h > -1 then begin
         Height := h;
      end;

      n := ini.ReadInteger('SETTINGS', 'ScanInterval', 500);
      n := Min(Max(n, 100), 3000);
      FScanInterval := n;
      timerLogSync.Interval := n;

      checkStayOnTop.Checked := ini.ReadBool('SETTINGS', 'STAY_ON_TOP', False);
      checkStayOnTopClick(checkStayOnTop);

      FHamlogDatabaseName := ini.ReadString('SETTINGS', 'HamlogDatabase', '');
      if FileExists(FHamlogDatabaseName) = False then begin
         FHamlogDatabaseName := '';
      end;

      FDisplayMax := ini.ReadInteger('SETTINGS', 'DisplayMax', 10);
      FPastYears := ini.ReadInteger('SETTINGS', 'PastYears', 3);
      FIncremental := ini.ReadBool('SETTINGS', 'Incremental', False);

      FInitZLogLink := ini.ReadBool('SETTINGS', 'ZLOG_LINK', False);
   finally
      ini.Free();
   end;
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.SaveSettings();
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      ini.WriteInteger('SETTINGS', 'X', Left);
      ini.WriteInteger('SETTINGS', 'Y', Top);
      ini.WriteInteger('SETTINGS', 'W', Width);
      ini.WriteInteger('SETTINGS', 'H', Height);
      ini.WriteInteger('SETTINGS', 'ScanInterval', FScanInterval);
      ini.WriteBool('SETTINGS', 'ZLOG_LINK', checkZlog.Checked);
      ini.WriteBool('SETTINGS', 'STAY_ON_TOP', checkStayOnTop.Checked);
      ini.WriteString('SETTINGS', 'HamlogDatabase', FHamlogDatabaseName);
      ini.WriteInteger('SETTINGS', 'DisplayMax', FDisplayMax);
      ini.WriteInteger('SETTINGS', 'PastYears', FPastYears);
      ini.WriteBool('SETTINGS', 'Incremental', FIncremental);
   finally
      ini.Free();
   end;
end;

// ----------------------------------------------------------------------------

procedure TformHamlogLookup.HamlogOpen();
begin
   FHamlogOpend := False;

   if FHamlogDatabaseName <> '' then begin
      FHamlogOpend := FHamlog.Open(FHamlogDatabaseName);
      if FHamlogOpend = False then begin
         MessageBox(Handle, PChar('HAMLOGデータベースがオープンできません.'), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
         Exit;
      end;
   end;

   SetCaption();
end;

end.

