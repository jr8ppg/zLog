unit UTTYConsole;

interface

uses
  WinApi.Windows, WinApi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  UzLogForm, UMMTTY, UzLogConst, UzLogGlobal, Console2, UzLogCW, System.Actions,
  Vcl.ActnList;

const
  WM_ZLOG_RTTY_RXCHAR = (WM_USER + 1000);

type
  TTTYConsole = class(TZLogForm)
    panelLeft: TPanel;
    CallsignList: TListBox;
    Splitter1: TSplitter;
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    menuConsole: TMenuItem;
    menuClearRxLog: TMenuItem;
    menuClearTxLog: TMenuItem;
    menuClearCallsignlist: TMenuItem;
    menuClearEverything: TMenuItem;
    menuStayOnTop: TMenuItem;
    TXLog: TMemo;
    N1: TMenuItem;
    panelTx: TPanel;
    panelRx: TPanel;
    panelTxHeader: TPanel;
    Label1: TLabel;
    panelRxHeader: TPanel;
    Label2: TLabel;
    panelLeftHeader: TPanel;
    Label3: TLabel;
    ActionList1: TActionList;
    actionPlayMessageA01: TAction;
    actionPlayMessageA02: TAction;
    actionPlayMessageA03: TAction;
    actionPlayMessageA04: TAction;
    actionPlayMessageA05: TAction;
    actionPlayMessageA06: TAction;
    actionPlayMessageA07: TAction;
    actionPlayMessageA08: TAction;
    actionPlayMessageA09: TAction;
    actionPlayMessageA10: TAction;
    actionPlayMessageA11: TAction;
    actionPlayMessageA12: TAction;
    actionPlayMessageB01: TAction;
    actionPlayMessageB02: TAction;
    actionPlayMessageB03: TAction;
    actionPlayMessageB04: TAction;
    actionPlayMessageB05: TAction;
    actionPlayMessageB06: TAction;
    actionPlayMessageB07: TAction;
    actionPlayMessageB08: TAction;
    actionPlayMessageB09: TAction;
    actionPlayMessageB10: TAction;
    actionPlayMessageB11: TAction;
    actionPlayMessageB12: TAction;
    actionPlayCQA1: TAction;
    actionPlayCQA2: TAction;
    actionPlayCQA3: TAction;
    actionPlayCQB1: TAction;
    actionPlayCQB2: TAction;
    actionPlayCQB3: TAction;
    buttonTXLogClear: TButton;
    buttonRXLogClear: TButton;
    buttonCallListClear: TButton;
    actionControlPTT: TAction;
    actionRttyGrab: TAction;
    popupCallsignList: TPopupMenu;
    actionRttyGrab1: TMenuItem;
    N2: TMenuItem;
    menuCallsignDelete: TMenuItem;
    menuLoadList: TMenuItem;
    menuSaveList: TMenuItem;
    menuDebugSep: TMenuItem;
    RXLog: TColorConsole2;
    N3: TMenuItem;
    menuOptions: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure TXLogKeyPress(Sender: TObject; var Key: Char);
    procedure TXLogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure menuStayOnTopClick(Sender: TObject);
    procedure menuClearRxLogClick(Sender: TObject);
    procedure menuClearTxLogClick(Sender: TObject);
    procedure menuClearCallsignlistClick(Sender: TObject);
    procedure menuClearEverythingClick(Sender: TObject);
    procedure CallsignListClick(Sender: TObject);
    procedure CallsignListDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure buttonCallListClearClick(Sender: TObject);
    procedure buttonRXLogClearClick(Sender: TObject);
    procedure buttonTXLogClearClick(Sender: TObject);
    procedure actionPlayMessageAExecute(Sender: TObject);
    procedure actionPlayMessageBExecute(Sender: TObject);
    procedure actionControlPTTExecute(Sender: TObject);
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
    procedure actionRttyGrabExecute(Sender: TObject);
    procedure menuCallsignDeleteClick(Sender: TObject);
    procedure popupCallsignListPopup(Sender: TObject);
    procedure menuLoadListClick(Sender: TObject);
    procedure menuSaveListClick(Sender: TObject);
    procedure menuOptionsClick(Sender: TObject);
    procedure RXLogSelected(Sender: TObject);
  private
    { Private declarations }
    FTTYSendBuffer: string;
    FTTYSendPos: Integer;   // next character position for FSK one-character transmission
    FTTYLineBuffer: string; // line buffer for rx data
    FNeedFinishEvent: Boolean;
    FAutoPttOff: Boolean;
    FOnSendFinishProc: TPlayMessageFinishedProc;
    FRxCharNo: Integer;
    procedure OnZLogRttyRxChar( var Message: TMessage ); message WM_ZLOG_RTTY_RXCHAR;
    function Sending(): Boolean;
    procedure RXChar(C: AnsiChar);
    procedure TXChar(C: AnsiChar);
    procedure PlayMessageRTTY(no: Integer);
    procedure ApplyShortcut();
    procedure ImplementOptions();
  public
    { Public declarations }
    procedure SendStrNow(S: String);
    procedure TxClear();
    procedure ToggleTXRX();
    procedure Grab();
    procedure RemoveCallsign(strCall: string);
    procedure OneCharSentProc();

    property FontSize: Integer read GetFontSize write SetFontSize;
    property OnSendFinishProc: TPlayMessageFinishedProc read FOnSendFinishProc write FOnSendFinishProc;
  end;

implementation

uses
  Main, URttyOptions, UzColorCoding, UzLogKeyer, URigControl;

{$R *.DFM}

procedure TTTYConsole.FormCreate(Sender: TObject);
begin
   RXLog.ClrScr;
   FTTYSendBuffer := '';
   FTTYSendPos := 0;
   FTTYLineBuffer := '';
   FNeedFinishEvent := False;
   FAutoPttOff := False;
end;

procedure TTTYConsole.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   MainForm.DelTaskbar(Handle);
end;

procedure TTTYConsole.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);
   ApplyShortcut();
   RXLog.ClrScr();
   TXLog.Clear();
   CallsignList.Clear();
   ImplementOptions();
end;

procedure TTTYConsole.FormActivate(Sender: TObject);
begin
   inherited;
   ActionList1.State := asNormal;
   TXLog.SetFocus();
end;

procedure TTTYConsole.FormDeactivate(Sender: TObject);
begin
   inherited;
   ActionList1.State := asSuspended;
end;

procedure TTTYConsole.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE: begin
         FTTYSendPos := 0;
         FTTYSendBuffer := '';
         PostMessage(MainForm.Handle, WM_ZLOG_CQABORT, 0, 2);
         menuClearTxLog.Click();
         Key := 0;
      end;

      VK_NONCONVERT: begin
         toggleTXRX();
         Key := 0;
      end;
   end;
end;

procedure TTTYConsole.Timer1Timer(Sender: TObject);
var
   i: integer;
   nID: Integer;
begin
   Timer1.Enabled := False;
   try
      nID := MainForm.CurrentRX;
      if dmZLogKeyer.TtyRxPort[nID] <> tkpMmtty then begin
         Exit;
      end;

      if MMTTYBuffer = '' then begin
         Exit;
      end;

      // RXLog.Text := RXLog.Text + MMTTYBuffer;
      for i := 1 to Length(MMTTYBuffer) do begin
         RXChar(AnsiChar(MMTTYBuffer[i]));
      end;

      MMTTYBuffer := '';

      if (FNeedFinishEvent = True) then begin
         if Sending() = False then begin
            // fire event
            if Assigned(FOnSendFinishProc) then begin
               FOnSendFinishProc(Self, mRTTY, False, 0);
            end;

            FNeedFinishEvent := False;
         end;
      end;
   finally
      Timer1.Enabled := True;
   end;
end;

procedure TTTYConsole.RXChar(C: AnsiChar);
var
   i, j: integer;
   S: string;
   L: TStringList;
   len: Integer;
   ch: Char;
   nAlph, nNG: Integer;
   nNum: Integer;
   Index: Integer;
label
   xxxx;
begin
   if C in [AnsiChar(0) .. AnsiChar($09), AnsiChar($0B) .. AnsiChar($0C), AnsiChar($0E) .. AnsiChar($1F), AnsiChar($80) .. AnsiChar($FF)] then begin
      Exit;
   end;

   RXLog.WriteChar(C);

   L := TStringList.Create();
   L.Delimiter := ' ';
   L.StrictDelimiter := True;

   if (C = ' ') or (C = _CR) then begin

      L.DelimitedText := FTTYLineBuffer;

      for i := 0 to L.Count - 1 do begin
         S := L.Strings[i];

         // �����`�F�b�N
         len := Length(S);
         if (len < 3) or (len > 15) then begin
            Continue;
         end;

         // �����`�F�b�N
         nAlph := 0;
         nNG := 0;
         nNum := 0;
         for j := 1 to len do begin
            ch := S[j];

            if ((ch >= '0') and (ch <= '9')) then begin
               Inc(nNum);
            end
            else if (((ch >= 'A') and (ch <= 'Z')) or (ch = '/')) then begin
               Inc(nAlph);
            end
            else begin
               Inc(nNG);
            end;
         end;

         if (nNG > 0) or (nNum = 0) or (nAlph = 0) then begin
            Continue;
         end;

         Index := CallsignList.Items.IndexOf(S);
         if Index = -1 then begin
            CallsignList.Items.Insert(0, S);
         end
         else begin
            CallsignList.Items.Delete(Index);
            CallsignList.Items.Insert(0, S);
         end;
      end;

   xxxx:
      i := Pos('599', FTTYLineBuffer);
      if i > 0 then begin
         S := FTTYLineBuffer;
         Delete(S, 1, i + 2);
         S := TrimLeft(S);
         // Caption := Caption + '*' + S;
         if S <> '' then begin
            if CharInSet(S[1], [' ', '/', '-', '|']) then
               Delete(S, 1, 1);

            for i := 1 to length(S) do
               if CharInSet(S[i], ['-', '/']) then
                  S[i] := ' ';

            i := pos(' ', S);
            if i > 0 then
               S := copy(S, 1, i - 1);
            if length(S) > 0 then begin
               if MainForm.RcvdNumberEdit.Text <> S then begin
                  MainForm.RcvdNumberEdit.Text := S;
                  MainForm.RcvdNumberEdit.SelectAll;
               end;
               // TTYLineBuffer := '';
            end;
         end;
      end;
   end;

   if C = _CR then begin
      FTTYLineBuffer := '';
   end
   else begin
      FTTYLineBuffer := FTTYLineBuffer + Char(C);
   end;

   L.Free();
end;

procedure TTTYConsole.TXChar(C: AnsiChar);
begin
   TXLog.Text := TXLog.Text + Char(C);
end;

procedure TTTYConsole.TXLogKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = Chr($08) then begin  // BackSpace
      if dmZLogGlobal.Settings.RTTY.UseFskKeying = True then begin
         if dmZLogKeyer.PTTIsOn = True then begin
            // During FSK transmission, FTTYSendPos points to the next
            // character that has not yet been sent.  BS can delete only
            // a character that is still waiting in the queue.
            if FTTYSendPos <= Length(FTTYSendBuffer) then begin
               Delete(FTTYSendBuffer, Length(FTTYSendBuffer), 1);
               // Leave Key as BS so TXLog also deletes one character.
            end
            else begin
               // Everything already entered has been sent.  It cannot be
               // withdrawn, so queue the conventional correction character.
               FTTYSendBuffer := FTTYSendBuffer + 'X';
               Key := 'X';
            end;
         end
         else begin
            // Before transmission starts, every character in the buffer is
            // still unsent and can therefore be removed normally.
            if FTTYSendBuffer <> '' then begin
               Delete(FTTYSendBuffer, Length(FTTYSendBuffer), 1);
               // Leave Key as BS so TXLog also deletes one character.
            end
            else begin
               // There is nothing that can be deleted. Queue X so it will
               // be transmitted when FSK transmission starts.
               FTTYSendBuffer := 'X';
               Key := 'X';
            end;
         end;
      end
      else begin
         if FTTYSendBuffer = '' then begin
            if MMTTY_TX then
               mm_SendStr('X', False);
            Key := 'X';
         end
         else begin
            FTTYSendBuffer := Copy(FTTYSendBuffer, 1, Length(FTTYSendBuffer) - 1);
         end;
      end;
      Exit;
   end;

   if Key = CR then begin
      Exit;
   end;

   Key := UpCase(Key);

   if Not CharInSet(Key, ['A'..'Z', '0'..'9', '-', '?', ':', '$', '!', '&', '#', '''', '(', ')', '.', ',', '/', '=', '+', ' ']) then begin
      Key := #00;
      Exit;
   end;

   if dmZLogGlobal.Settings.RTTY.UseFskKeying = True then begin
      // FSK transmission is always queued. Even while PTT is on,
      // characters entered here are appended to FTTYSendBuffer and
      // are sent one at a time from OneCharSentProc().
      FTTYSendBuffer := FTTYSendBuffer + Key;
   end
   else begin
      if MMTTY_TX then begin
         UMMTTY.mm_SendStr(Key, False);
      end
      else begin
         FTTYSendBuffer := FTTYSendBuffer + Key;
      end;
   end;
end;

procedure TTTYConsole.SendStrNow(S: String);
begin
   FNeedFinishEvent := True;
   UMMTTY.mm_SendStr(_CR + _LF + S + _CR + _LF, True);
   TXLog.Lines.Add(S);
end;

procedure TTTYConsole.TXLogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_RIGHT, VK_LEFT, VK_UP, VK_DOWN, VK_DELETE:
         Key := 0;

      VK_RETURN: begin
         if dmZLogGlobal.Settings.RTTY.UseFskKeying = True then begin
            // CR/LF is also queued so it follows the same one-character
            // transmission path as normal keyboard input.
            FTTYSendBuffer := FTTYSendBuffer + _CR + _LF;
         end
         else begin
            if MMTTY_TX then begin
               UMMTTY.mm_SendStr(_CR + _LF, False)
            end
            else begin
               FTTYSendBuffer := FTTYSendBuffer + _CR + _LF;
            end;
         end;
      end;
   end;
end;

procedure TTTYConsole.menuStayOnTopClick(Sender: TObject);
begin
   menuStayOnTop.Checked := not(menuStayOnTop.Checked);
   if menuStayOnTop.Checked then begin
      FormStyle := fsStayOnTop;
      menuStayOnTop.Checked := True;
   end
   else begin
      FormStyle := fsNormal;
      menuStayOnTop.Checked := False;
   end;
end;

procedure TTTYConsole.menuClearRxLogClick(Sender: TObject);
begin
   RXLog.ClrScr;
end;

procedure TTTYConsole.menuClearTxLogClick(Sender: TObject);
begin
   TXLog.Clear;
end;

procedure TTTYConsole.menuCallsignDeleteClick(Sender: TObject);
var
   Index: Integer;
begin
   Index := CallsignList.ItemIndex;
   if Index <> -1 then begin
      CallsignList.Items.Delete(Index);
   end;
end;

procedure TTTYConsole.menuClearCallsignlistClick(Sender: TObject);
begin
   CallsignList.Clear;
end;

procedure TTTYConsole.menuClearEverythingClick(Sender: TObject);
begin
   CallsignList.Clear;
   RXLog.ClrScr;
   TXLog.Clear;
end;

procedure TTTYConsole.buttonCallListClearClick(Sender: TObject);
begin
   CallsignList.Clear;
   TXLog.SetFocus();
end;

procedure TTTYConsole.buttonRXLogClearClick(Sender: TObject);
begin
   RXLog.ClrScr;
   TXLog.SetFocus();
end;

procedure TTTYConsole.buttonTXLogClearClick(Sender: TObject);
begin
   TXLog.Clear;
   TXLog.SetFocus();
end;

procedure TTTYConsole.CallsignListClick(Sender: TObject);
begin
   if CallsignList.ItemIndex >= 0 then begin
      MainForm.CallsignEdit.Text := CallsignList.Items[CallsignList.ItemIndex];
      MainForm.CallsignEdit.SelectAll;
   end;
end;

procedure TTTYConsole.CallsignListDblClick(Sender: TObject);
begin
   if CallsignList.ItemIndex >= 0 then begin
      MainForm.CallsignEdit.Text := CallsignList.Items[CallsignList.ItemIndex];
      MainForm.CallsignEdit.SelectAll;
      MainForm.SetLastFocus();
   end;
end;

procedure TTTYConsole.OnZLogRttyRxChar( var Message: TMessage );
var
   CH: AnsiChar;
   rigno: Integer;
begin
   CH := AnsiChar(Message.WParam);
   rigno := Message.LParam;

   if (rigno > 0) and ((MainForm.CurrentRX) <> (rigno - 1)) then begin
      Exit;
   end;

   RXChar(CH);
end;

function TTTYConsole.Sending(): Boolean;
begin
   if dmZLogGlobal.Settings.RTTY.UseFskKeying = True then begin
      Result := dmZLogKeyer.IsPlaying();
   end
   else begin
      Result := MMTTY_TX;
   end;
end;

procedure TTTYConsole.actionControlPTTExecute(Sender: TObject);
begin
   ToggleTXRX();
end;

procedure TTTYConsole.actionPlayMessageAExecute(Sender: TObject);
var
   no: Integer;
begin
   no := TAction(Sender).Tag;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('PlayMessageA(' + IntToStr(no) + ')'));
   {$ENDIF}

   PlayMessageRTTY(no);
end;

procedure TTTYConsole.actionPlayMessageBExecute(Sender: TObject);
var
   no: Integer;
begin
   no := TAction(Sender).Tag;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('PlayMessageB(' + IntToStr(no) + ')'));
   {$ENDIF}

   PlayMessageRTTY(no);
end;

procedure TTTYConsole.actionRttyGrabExecute(Sender: TObject);
begin
   if CallsignList.Items.Count = 0 then begin
      Exit;
   end;

   if CallsignList.ItemIndex = -1 then begin
      CallsignList.ItemIndex := 0;
      MainForm.CallsignEdit.Text := CallsignList.Items[CallsignList.ItemIndex];
      MainForm.CallsignEdit.SelectAll;
      MainForm.SetLastFocus();
   end
   else begin
      if CallsignList.ItemIndex < (CallsignList.Items.Count - 1) then begin
         CallsignList.ItemIndex := CallsignList.ItemIndex + 1;
         MainForm.CallsignEdit.Text := CallsignList.Items[CallsignList.ItemIndex];
         MainForm.CallsignEdit.SelectAll;
         MainForm.SetLastFocus();
      end
      else begin
         CallsignList.ItemIndex := -1;
      end;
   end;
end;

procedure TTTYConsole.PlayMessageRTTY(no: Integer);
var
   S: string;
   nID: Integer;
begin
   S := dmZLogGlobal.CWMessage(3, no);
   if S = '' then begin
      Exit;
   end;

   S := SetStrNoAbbrev(S, CurrentQSO);

   FAutoPttOff := True;

   if dmZLogGlobal.Settings.RTTY.UseFskKeying = True then begin
      nID := MainForm.CurrentTX;
      //zLogSetSendText(nID, S, '');
      //dmZLogKeyer.SendStr(nID, S)
      TXLog.Lines.Add(S);
      if dmZLogKeyer.PTTIsOn = False then begin
         FTTYSendBuffer := S + CR + LF;
         ToggleTXRX();
      end
      else begin
         FTTYSendBuffer := FTTYSendBuffer + S + CR + LF;
      end;
   end
   else begin
      SendStrNow(S);
   end;
end;

procedure TTTYConsole.popupCallsignListPopup(Sender: TObject);
begin
   if (GetAsyncKeyState(VK_SHIFT) < 0) and (GetAsyncKeyState(VK_CONTROL) < 0) then begin
      menuDebugSep.Visible := True;
      menuLoadList.Visible := True;
      menuSaveList.Visible := True;
   end
   else begin
      menuDebugSep.Visible := False;
      menuLoadList.Visible := False;
      menuSaveList.Visible := False;
   end;
end;

procedure TTTYConsole.menuLoadListClick(Sender: TObject);
begin
   CallsignList.Items.LoadFromFile('zlog_rtty_calllist.txt');
end;

procedure TTTYConsole.menuOptionsClick(Sender: TObject);
var
   f: TformRttyOptions;
   i: Integer;
   CC: TColorCoding;
   S: string;
begin
   f := TformRttyOptions.Create(Self);
   try
      f.DefaultColor := dmZLogGlobal.Settings.RTTY.DefaultColor;

      f.ColorCodingList.Clear();
      for i := 0 to dmZLogGlobal.Settings.RTTY.ColorCoding.Count - 1 do begin
         CC := TColorCoding.Create();
         CC.Text := dmZLogGlobal.Settings.RTTY.ColorCoding[i];
         f.ColorCodingList.Add(CC);
      end;

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      dmZLogGlobal.Settings.RTTY.DefaultColor := f.DefaultColor;
      dmZLogGlobal.Settings.RTTY.BackColor := f.BackColor;
      dmZLogGlobal.Settings.RTTY.ForeColor := f.ForeColor;

      dmZLogGlobal.Settings.RTTY.ColorCoding.Clear();
      for i := 0 to f.ColorCodingList.Count - 1 do begin
         S := f.ColorCodingList[i].Text;
         dmZLogGlobal.Settings.RTTY.ColorCoding.Add(S);
      end;

      ImplementOptions();
   finally
      f.Release();
   end;
end;

procedure TTTYConsole.menuSaveListClick(Sender: TObject);
begin
   CallsignList.Items.SaveToFile('zlog_rtty_calllist.txt');
end;

procedure TTTYConsole.RXLogSelected(Sender: TObject);
var
   S: string;
begin
   S := RXLog.SelectedText;
   MainForm.SetYourNumber(S);
end;

procedure TTTYConsole.ApplyShortcut();
begin
   actionPlayMessageA01.ShortCut := MainForm.actionPlayMessageA01.ShortCut;
   actionPlayMessageA02.ShortCut := MainForm.actionPlayMessageA02.ShortCut;
   actionPlayMessageA03.ShortCut := MainForm.actionPlayMessageA03.ShortCut;
   actionPlayMessageA04.ShortCut := MainForm.actionPlayMessageA04.ShortCut;
   actionPlayMessageA05.ShortCut := MainForm.actionPlayMessageA05.ShortCut;
   actionPlayMessageA06.ShortCut := MainForm.actionPlayMessageA06.ShortCut;
   actionPlayMessageA07.ShortCut := MainForm.actionPlayMessageA07.ShortCut;
   actionPlayMessageA08.ShortCut := MainForm.actionPlayMessageA08.ShortCut;
   actionPlayMessageA09.ShortCut := MainForm.actionPlayMessageA09.ShortCut;
   actionPlayMessageA10.ShortCut := MainForm.actionPlayMessageA10.ShortCut;
   actionPlayMessageA11.ShortCut := MainForm.actionPlayMessageA11.ShortCut;
   actionPlayMessageA12.ShortCut := MainForm.actionPlayMessageA12.ShortCut;

   actionPlayMessageB01.ShortCut := MainForm.actionPlayMessageB01.ShortCut;
   actionPlayMessageB02.ShortCut := MainForm.actionPlayMessageB02.ShortCut;
   actionPlayMessageB03.ShortCut := MainForm.actionPlayMessageB03.ShortCut;
   actionPlayMessageB04.ShortCut := MainForm.actionPlayMessageB04.ShortCut;
   actionPlayMessageB05.ShortCut := MainForm.actionPlayMessageB05.ShortCut;
   actionPlayMessageB06.ShortCut := MainForm.actionPlayMessageB06.ShortCut;
   actionPlayMessageB07.ShortCut := MainForm.actionPlayMessageB07.ShortCut;
   actionPlayMessageB08.ShortCut := MainForm.actionPlayMessageB08.ShortCut;
   actionPlayMessageB09.ShortCut := MainForm.actionPlayMessageB09.ShortCut;
   actionPlayMessageB10.ShortCut := MainForm.actionPlayMessageB10.ShortCut;
   actionPlayMessageB11.ShortCut := MainForm.actionPlayMessageB11.ShortCut;
   actionPlayMessageB12.ShortCut := MainForm.actionPlayMessageB12.ShortCut;

   actionPlayCQA1.ShortCut := MainForm.actionPlayCQA1.ShortCut;
   actionPlayCQA2.ShortCut := MainForm.actionPlayCQA2.ShortCut;
   actionPlayCQA3.ShortCut := MainForm.actionPlayCQA3.ShortCut;
   actionPlayCQB1.ShortCut := MainForm.actionPlayCQB1.ShortCut;
   actionPlayCQB2.ShortCut := MainForm.actionPlayCQB2.ShortCut;
   actionPlayCQB3.ShortCut := MainForm.actionPlayCQB3.ShortCut;

   actionControlPTT.ShortCut := MainForm.actionControlPTT.ShortCut;
   actionRttyGrab.ShortCut := MainForm.actionRttyGrab.ShortCut;

   actionPlayMessageA01.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA01.SecondaryShortCuts);
   actionPlayMessageA02.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA02.SecondaryShortCuts);
   actionPlayMessageA03.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA03.SecondaryShortCuts);
   actionPlayMessageA04.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA04.SecondaryShortCuts);
   actionPlayMessageA05.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA05.SecondaryShortCuts);
   actionPlayMessageA06.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA06.SecondaryShortCuts);
   actionPlayMessageA07.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA07.SecondaryShortCuts);
   actionPlayMessageA08.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA08.SecondaryShortCuts);
   actionPlayMessageA09.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA09.SecondaryShortCuts);
   actionPlayMessageA10.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA10.SecondaryShortCuts);
   actionPlayMessageA11.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA11.SecondaryShortCuts);
   actionPlayMessageA12.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA12.SecondaryShortCuts);

   actionPlayMessageB01.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB01.SecondaryShortCuts);
   actionPlayMessageB02.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB02.SecondaryShortCuts);
   actionPlayMessageB03.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB03.SecondaryShortCuts);
   actionPlayMessageB04.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB04.SecondaryShortCuts);
   actionPlayMessageB05.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB05.SecondaryShortCuts);
   actionPlayMessageB06.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB06.SecondaryShortCuts);
   actionPlayMessageB07.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB07.SecondaryShortCuts);
   actionPlayMessageB08.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB08.SecondaryShortCuts);
   actionPlayMessageB09.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB09.SecondaryShortCuts);
   actionPlayMessageB10.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB10.SecondaryShortCuts);
   actionPlayMessageB11.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB11.SecondaryShortCuts);
   actionPlayMessageB12.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB12.SecondaryShortCuts);

   actionPlayCQA2.SecondaryShortCuts.Assign(MainForm.actionPlayCQA2.SecondaryShortCuts);
   actionPlayCQA3.SecondaryShortCuts.Assign(MainForm.actionPlayCQA3.SecondaryShortCuts);
   actionPlayCQB2.SecondaryShortCuts.Assign(MainForm.actionPlayCQB2.SecondaryShortCuts);
   actionPlayCQB3.SecondaryShortCuts.Assign(MainForm.actionPlayCQB3.SecondaryShortCuts);

   actionControlPTT.SecondaryShortCuts.Assign(MainForm.actionControlPTT.SecondaryShortCuts);
   actionRttyGrab.SecondaryShortCuts.Assign(MainForm.actionRttyGrab.SecondaryShortCuts);
end;

function TTTYConsole.GetFontSize(): Integer;
begin
   Result := Inherited;
end;

procedure TTTYConsole.SetFontSize(v: Integer);
begin
   Inherited;
   RXLog.Font.Size := v;
   TXLog.Font.Size := v;
   Callsignlist.Font.Size := v;
end;

procedure TTTYConsole.TxClear();
begin
   TXLog.Clear();
end;

procedure TTTYConsole.ToggleTXRX();
var
   nID: Integer;
   CH: AnsiChar;
begin
   if dmZLogGlobal.Settings.RTTY.UseFskKeying = True then begin
      nID := MainForm.CurrentTX;
      if dmZLogKeyer.PTTIsOn = True then begin
         // Stop transmission only when ToggleTXRX() is explicitly called.
         FTTYSendPos := 0;
         FTTYSendBuffer := '';
         // Cancel the current one-character FSK send as well as PTT.
         // This prevents the previous LTRS/character tail from being
         // processed after the next TX start.
         dmZLogKeyer.FskCancelSend(nID);
         RXLog.WriteString(CR + LF);
      end
      else begin
         FNeedFinishEvent := False;
         dmZLogKeyer.FskControlPTT(nID, True);

         // The first transmit position is 1.
         FTTYSendPos := 1;

         if FTTYSendBuffer <> '' then begin
            CH := AnsiChar(FTTYSendBuffer[FTTYSendPos]);
            dmZLogKeyer.SendChar(nID, CH);
            Inc(FTTYSendPos);
            RXLog.WriteChar(CH);
         end
         else begin
            // Nothing to send: keep the transmitter active by sending LTRS.
            dmZLogKeyer.SendChar(nID, LTRS2);
         end;
      end;
   end
   else begin
      if MMTTY_TX then begin
         mm_RX;
      end
      else begin
         if FTTYSendBuffer <> '' then begin
            mm_SendStr(FTTYSendBuffer, False);
            RXLog.WriteString(_CR + _LF);
            FTTYSendBuffer := '';
         end
         else begin
            mm_TX;
         end;
      end;
   end;
end;

procedure TTTYConsole.Grab();
begin
   actionRttyGrabExecute(nil);
end;

procedure TTTYConsole.RemoveCallsign(strCall: string);
var
   Index: Integer;
begin
   Index := CallsignList.Items.IndexOf(strCall);
   if Index <> -1 then begin
      CallsignList.Items.Delete(Index);
      CallsignList.ItemIndex := -1;
   end;
end;

procedure TTTYConsole.ImplementOptions();
var
   i: Integer;
   CC: TColorCoding;
   fs: TFontStyles;
begin
   RXLog.BackgroundColor := dmZLogGlobal.Settings.RTTY.BackColor;
   RXLog.TextColor := dmZLogGlobal.Settings.RTTY.ForeColor;

   RXLog.ClearColorStrings();

   for i := 0 to dmZLogGlobal.Settings.RTTY.ColorCoding.Count - 1 do begin
      CC := TColorCoding.Create();
      CC.Text := dmZLogGlobal.Settings.RTTY.ColorCoding[i];
      fs := [];
      if CC.Bold then fs := fs + [fsBold];
      if CC.Italic then fs := fs + [fsBold];
      RXLog.AddColorString(CC.Keyword, CC.ForeColor, fs);
      CC.Free();
   end;

   TXLog.Color := dmZLogGlobal.Settings.RTTY.BackColor;
   TXLog.Font.Color := dmZLogGlobal.Settings.RTTY.ForeColor;

   CallsignList.Color := dmZLogGlobal.Settings.RTTY.BackColor;
   CallsignList.Font.Color := dmZLogGlobal.Settings.RTTY.ForeColor;
end;

procedure TTTYConsole.OneCharSentProc();
var
   nID: Integer;
   CH: AnsiChar;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('-----TTYConsole.OneCharSentProc()-----'));
   {$ENDIF}

   if dmZLogGlobal.Settings.RTTY.UseFskKeying = False then begin
      Exit;
   end;

   // FTTYSendPos = 0 means that FSK transmission is not active.
   if FTTYSendPos = 0 then begin
      Exit;
   end;

   nID := MainForm.CurrentTX;

   if FTTYSendPos <= Length(FTTYSendBuffer) then begin
      // Send the next queued character.
      CH := AnsiChar(FTTYSendBuffer[FTTYSendPos]);
      Inc(FTTYSendPos);
      dmZLogKeyer.SendChar(nID, CH);
      PostMessage(Handle, WM_ZLOG_RTTY_RXCHAR, WPARAM(CH), 0);
   end
   else begin
      {$IFDEF DEBUG}
      OutputDebugString(PChar('-----送るものがない-----'));
      {$ENDIF}

      // All queued characters have been sent.  Discard the transmitted
      // portion and wait at position 1 for newly entered characters.
      FTTYSendBuffer := '';
      FTTYSendPos := 1;

      // While there is nothing to send, continuously send LTRS.
      // If a character is entered while this LTRS is being sent, it is
      // appended to FTTYSendBuffer and will be sent on the next callback.
      dmZLogKeyer.SendChar(nID, LTRS2);

      if FAutoPttOff = True then begin
         ToggleTXRX();
         FAutoPttOff := False;
      end;
   end;
end;

end.

