unit UTTYConsole;

interface

uses
  WinApi.Windows, WinApi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  UzLogForm, UMMTTY, UzLogConst, UzLogGlobal, Console2, UzLogCW, System.Actions,
  Vcl.ActnList;

const
  ttyMMTTY = 0;
  ttyPSK31 = 1;

type
  TTTYConsole = class(TZLogForm)
    panelLeft: TPanel;
    CallsignList: TListBox;
    Splitter1: TSplitter;
    Timer1: TTimer;
    RXLog: TConsole2;
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
  private
    { Private declarations }
    FTTYMode: Integer;
    FTTYSendBuffer: string;
    FTTYLineBuffer: string; // line buffer for rx data
    FNeedFinishEvent: Boolean;
    FOnSendFinishProc: TPlayMessageFinishedProc;
    procedure SetTTYMode(i: Integer);
    function Sending(): Boolean;
    procedure RXChar(C: AnsiChar);
    procedure TXChar(C: AnsiChar);
    procedure PlayMessageRTTY(no: Integer);
    procedure ApplyShortcut();
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
  public
    { Public declarations }
    procedure SendStrNow(S: String);
    procedure TxClear();
    procedure ToggleTXRX();

    property TTYMode: Integer read FTTYMode write SetTTYMode;
    property FontSize: Integer read GetFontSize write SetFontSize;
    property OnSendFinishProc: TPlayMessageFinishedProc read FOnSendFinishProc write FOnSendFinishProc;
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TTTYConsole.FormCreate(Sender: TObject);
begin
   RXLog.ClrScr;
   FTTYMode := 0;
   FTTYSendBuffer := '';
   FTTYLineBuffer := '';
   FNeedFinishEvent := False;
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
var
   i: integer;
   S: string;
begin
   case Key of
      VK_ESCAPE: begin
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
begin
   Timer1.Enabled := False;
   try
      case FTTYMode of
         ttyMMTTY: begin
            if MMTTYBuffer = '' then
               exit;

            // RXLog.Text := RXLog.Text + MMTTYBuffer;
            for i := 1 to length(MMTTYBuffer) do
               RXChar(AnsiChar(MMTTYBuffer[i]));

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
         end;

         ttyPSK31: begin
            Exit;
         end;
      end;
   finally
      Timer1.Enabled := True;
   end;
end;

procedure TTTYConsole.SetTTYMode(i: Integer);
begin
   if (i >= 2) or (i < 0) then begin
      FTTYMode := 0;
   end
   else begin
      FTTYMode := i;
   end;

   if FTTYMode = 0 then begin
      Caption := 'RTTY Console';
   end;

   if FTTYMode = 1 then begin
      Caption := 'PSK31 Console';
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

         // 長さチェック
         len := Length(S);
         if (len < 3) or (len > 15) then begin
            Continue;
         end;

         // 文字チェック
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

         if CallsignList.Items.IndexOf(S) = -1 then begin
            CallsignList.Items.Add(S);
         end
         else begin
            Break;
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
   case FTTYMode of
      ttyMMTTY: begin
         if Key = Chr($08) then begin
            if FTTYSendBuffer = '' then begin
               if MMTTY_TX then
                  mm_SendStr('X', False);
               Key := 'X';
               exit;
            end
            else begin
               FTTYSendBuffer := copy(FTTYSendBuffer, 1, length(FTTYSendBuffer) - 1);
               exit;
            end;
         end;

         if MMTTY_TX then
            UMMTTY.mm_SendStr(Key, False)
         else begin
            FTTYSendBuffer := FTTYSendBuffer + Key;
         end;
      end;

      ttyPSK31:
         exit;
   end;
end;

procedure TTTYConsole.SendStrNow(S: String);
begin
   case FTTYMode of
      ttyMMTTY: begin
         FNeedFinishEvent := True;
         UMMTTY.mm_SendStr(_CR + _LF + S + _CR + _LF, True);
         TXLog.Lines.Add(S);
      end;

      ttyPSK31:
         exit;
   end;
end;

procedure TTTYConsole.TXLogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case FTTYMode of
      ttyMMTTY: begin
         case Key of
            VK_RIGHT, VK_LEFT, VK_UP, VK_DOWN, VK_DELETE:
               Key := 0;

            VK_RETURN: begin
               if MMTTY_TX then
                  UMMTTY.mm_SendStr(_CR + _LF, False)
               else begin
                  FTTYSendBuffer := FTTYSendBuffer + _CR + _LF;
               end;
            end;
         end;
      end;

      ttyPSK31: begin
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
      MainForm.CallsignEdit.SetFocus;
   end;
end;

function TTTYConsole.Sending(): Boolean;
begin
   Result := False;

   case FTTYMode of
      ttyMMTTY: begin
         Result := MMTTY_TX;
      end;

      ttyPSK31: begin
         Result := False;
      end;
   end;
end;

procedure TTTYConsole.actionControlPTTExecute(Sender: TObject);
begin
   ToggleTXRX();
end;

procedure TTTYConsole.actionPlayMessageAExecute(Sender: TObject);
var
   no: Integer;
   nID: Integer;
begin
   no := TAction(Sender).Tag;
   nID := MainForm.CurrentRigID;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('PlayMessageA(' + IntToStr(no) + ')'));
   {$ENDIF}

   PlayMessageRTTY(no);
end;

procedure TTTYConsole.actionPlayMessageBExecute(Sender: TObject);
var
   no: Integer;
   nID: Integer;
begin
   no := TAction(Sender).Tag;
   nID := MainForm.CurrentRigID;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('PlayMessageB(' + IntToStr(no) + ')'));
   {$ENDIF}

   PlayMessageRTTY(no);
end;

procedure TTTYConsole.PlayMessageRTTY(no: Integer);
var
   S: string;
begin
   S := dmZLogGlobal.CWMessage(3, no);
   if S = '' then begin
      Exit;
   end;

   S := SetStrNoAbbrev(S, CurrentQSO);
   SendStrNow(S);
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
begin
   if MMTTY_TX then begin
      mm_RX;
   end
   else begin
      if FTTYSendBuffer <> '' then begin
         mm_SendStr(FTTYSendBuffer, False);
         FTTYSendBuffer := '';
      end
      else begin
         mm_TX;
      end;
   end;
end;

end.
