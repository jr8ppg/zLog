unit UCWKeyBoard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ClipBrd, System.Actions, Vcl.ActnList,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogCW, UzLogKeyer, URigCtrlLib,
  UzLogForm, Vcl.ComCtrls;

type
  TCWKeyBoard = class(TZLogForm)
    Panel1: TPanel;
    buttonOK: TButton;
    buttonClear: TButton;
    ActionList1: TActionList;
    actionPlayMessageA01: TAction;
    actionPlayMessageA02: TAction;
    actionPlayMessageA03: TAction;
    actionPlayMessageA04: TAction;
    actionPlayMessageA05: TAction;
    actionPlayMessageA06: TAction;
    actionPlayMessageA07: TAction;
    actionPlayMessageA08: TAction;
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
    actionPlayMessageB11: TAction;
    actionPlayMessageB12: TAction;
    actionPlayMessageAR: TAction;
    actionPlayMessageBK: TAction;
    actionPlayMessageKN: TAction;
    actionPlayMessageSK: TAction;
    actionPlayMessageA09: TAction;
    actionPlayMessageA10: TAction;
    actionPlayMessageB09: TAction;
    actionPlayMessageB10: TAction;
    actionPlayCQA2: TAction;
    actionPlayCQA3: TAction;
    actionPlayCQB2: TAction;
    actionPlayCQB3: TAction;
    actionDecreaseCwSpeed: TAction;
    actionIncreaseCwSpeed: TAction;
    actionPlayCQA1: TAction;
    actionPlayCQB1: TAction;
    actionPlayMessageBT: TAction;
    actionPlayMessageVA: TAction;
    Console: TRichEdit;
    Timer1: TTimer;
    procedure ConsoleKeyPress(Sender: TObject; var Key: Char);
    procedure buttonOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buttonClearClick(Sender: TObject);
    procedure actionPlayMessageAExecute(Sender: TObject);
    procedure actionPlayMessageBExecute(Sender: TObject);
    procedure actionPlayMessageARExecute(Sender: TObject);
    procedure actionPlayMessageBKExecute(Sender: TObject);
    procedure actionPlayMessageKNExecute(Sender: TObject);
    procedure actionPlayMessageSKExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actionDecreaseCwSpeedExecute(Sender: TObject);
    procedure actionIncreaseCwSpeedExecute(Sender: TObject);
    procedure actionPlayMessageBTExecute(Sender: TObject);
    procedure actionPlayMessageVAExecute(Sender: TObject);
    procedure ConsoleProtectChange(Sender: TObject; StartPos, EndPos: Integer;
      var AllowChange: Boolean);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FSentPos: Integer;
    FFontSize: Integer;
    procedure PlayMessage(nID: Integer; cb: Integer; no: Integer);
    procedure ApplyShortcut();
    procedure SendChar(C: Char);
    function GetUnsentChars(): Integer;
  protected
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
    procedure UpdateFontSize(v: Integer); override;
  public
    { Public declarations }
    procedure OneCharSentProc();
    procedure Reset();
    procedure Finish();
    property FontSize: Integer read GetFontSize write SetFontSize;
    property UnsentChars: Integer read GetUnsentChars;
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TCWKeyBoard.FormCreate(Sender: TObject);
begin
   FSentPos := 0;
   Console.Clear();
   Console.Font.Name := dmZLogGlobal.Settings.FBaseFontName;

   Console.DefAttributes.Name := Console.Font.Name;
   Console.DefAttributes.Size := Console.Font.Size;
end;

procedure TCWKeyBoard.FormShow(Sender: TObject);
begin
   Inherited;
   ApplyShortcut();
   Console.SetFocus;
end;

procedure TCWKeyBoard.FormActivate(Sender: TObject);
begin
   ActionList1.State := asNormal;
   Console.SetFocus();
end;

procedure TCWKeyBoard.FormDeactivate(Sender: TObject);
begin
   ActionList1.State := asSuspended;
end;

procedure TCWKeyBoard.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE: begin
         PostMessage(MainForm.Handle, WM_ZLOG_CQABORT, 0, 2);
      end;
   end;
end;

procedure TCWKeyBoard.ConsoleKeyPress(Sender: TObject; var Key: Char);
var
   K: Char;
   nID: Integer;
   rig: TRig;
begin
   if Key = Chr($1B) then begin
      Exit;
   end;

   if GetAsyncKeyState(VK_CONTROL) < 0 then begin
      Exit;
   end;

   if GetAsyncKeyState(VK_SHIFT) < 0 then begin
      K := LowCase(Key);
   end
   else begin
      K := UpCase(Key);
   end;

   // 送信可能文字以外ならパス
   if (Not CharInSet(K, ['A'..'Z', '0'..'9', '?', '/', '-', '=', 'a', 'b', 't', 'k', 's', 'v', '~', '_', '.', '(', ')',' '])) then begin
      Key := #00;
      Exit;
   end;

   // CQループ中なら中止する
   SendMessage(MainForm.Handle, WM_ZLOG_CQABORT, 1, 0);

   // １文字送信
   if MainForm.StartCWKeyboard = False then begin
      SendChar(K);
   end;

   Key := K;
end;

procedure TCWKeyBoard.ConsoleProtectChange(Sender: TObject; StartPos,
  EndPos: Integer; var AllowChange: Boolean);
begin
   inherited;
   AllowChange := True;
end;

procedure TCWKeyBoard.buttonOKClick(Sender: TObject);
begin
   Close;
   MainForm.SetLastFocus();
end;

procedure TCWKeyBoard.buttonClearClick(Sender: TObject);
begin
   Reset();
   Console.Clear;
   dmZLogKeyer.ClrBuffer();
   MainForm.StartCWKeyboard := False;
end;

procedure TCWKeyBoard.actionPlayMessageAExecute(Sender: TObject);
var
   no: Integer;
   cb: Integer;
   nID: Integer;
begin
   no := TAction(Sender).Tag;
   cb := dmZlogGlobal.Settings.CW.CurrentBank;
   nID := MainForm.CurrentRigID;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('PlayMessageA(' + IntToStr(cb) + ',' + IntToStr(no) + ')'));
   {$ENDIF}

   PlayMessage(nID, cb, no);
end;

procedure TCWKeyBoard.actionPlayMessageBExecute(Sender: TObject);
var
   no: Integer;
   cb: Integer;
   nID: Integer;
begin
   no := TAction(Sender).Tag;
   cb := dmZlogGlobal.Settings.CW.CurrentBank;
   nID := MainForm.CurrentRigID;

   if cb = 1 then
      cb := 2
   else
      cb := 1;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('PlayMessageB(' + IntToStr(cb) + ',' + IntToStr(no) + ')'));
   {$ENDIF}

   PlayMessage(nID, cb, no);
end;

procedure TCWKeyBoard.actionPlayMessageARExecute(Sender: TObject);
begin
   SendChar('a');
   ClipBoard.AsText := '[AR]';
   Console.PasteFromClipBoard;
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionPlayMessageBKExecute(Sender: TObject);
begin
   SendChar('b');
   ClipBoard.AsText := '[BK]';
   Console.PasteFromClipBoard;
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionPlayMessageBTExecute(Sender: TObject);
begin
   SendChar('t');
   ClipBoard.AsText := '[BT]';
   Console.PasteFromClipBoard;
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionPlayMessageKNExecute(Sender: TObject);
begin
   SendChar('k');
   ClipBoard.AsText := '[KN]';
   Console.PasteFromClipBoard;
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionPlayMessageSKExecute(Sender: TObject);
begin
   SendChar('s');
   ClipBoard.AsText := '[SK]';
   Console.PasteFromClipBoard;
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionPlayMessageVAExecute(Sender: TObject);
begin
   SendChar('s');
   ClipBoard.AsText := '[VA]';
   Console.PasteFromClipBoard;
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionIncreaseCwSpeedExecute(Sender: TObject);
begin
   dmZLogKeyer.IncCWSpeed();
   SetFocus();
end;

procedure TCWKeyBoard.actionDecreaseCwSpeedExecute(Sender: TObject);
begin
   dmZLogKeyer.DecCWSpeed();
   SetFocus();
end;

procedure TCWKeyBoard.PlayMessage(nID: Integer; cb: Integer; no: Integer);
var
   S: string;
   i: Integer;
begin
   S := dmZlogGlobal.CWMessage(cb, no);
   if S = '' then begin
      Exit;
   end;

   S := SetStr(S, CurrentQSO);

   while Pos(':***********', S) > 0 do begin
      i := Pos(':***********', S);
      Delete(S, i, 12);
      Insert(CurrentQSO.Callsign, S, i);
   end;

   ClipBoard.AsText := S;
   Console.PasteFromClipBoard;
   Console.SelStart := Length(Console.Text);

   SendChar(Console.Text[FSentPos + 1]);
end;

procedure TCWKeyBoard.ApplyShortcut();
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

   actionDecreaseCwSpeed.ShortCut := MainForm.actionDecreaseCwSpeed.ShortCut;
   actionIncreaseCwSpeed.ShortCut := MainForm.actionIncreaseCwSpeed.ShortCut;

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

   actionDecreaseCwSpeed.SecondaryShortCuts.Assign(MainForm.actionDecreaseCwSpeed.SecondaryShortCuts);
   actionIncreaseCwSpeed.SecondaryShortCuts.Assign(MainForm.actionIncreaseCwSpeed.SecondaryShortCuts);
end;

function TCWKeyBoard.GetFontSize(): Integer;
begin
   Inherited;
   Result := Console.Font.Size;
end;

procedure TCWKeyBoard.SetFontSize(v: Integer);
begin
   Inherited;
   UpdateFontSize(v);
end;

procedure TCWKeyBoard.Timer1Timer(Sender: TObject);
begin
   inherited;
   Timer1.Enabled := False;
   buttonClear.Click();
end;

procedure TCWKeyBoard.UpdateFontSize(v: Integer);
begin
   Console.Font.Size := v;
   Console.DefAttributes.Size := v;
end;

procedure TCWKeyBoard.SendChar(C: Char);
var
   nID: Integer;
   rig: TRig;
begin
   MainForm.StartCWKeyboard := True;

   nID := MainForm.GetTxRigID();

   if dmZLogKeyer.KeyingPort[nID] = tkpRIG then begin
      rig := MainForm.RigControl.Rigs[nID + 1];
      if rig <> nil then begin
         rig.PlayMessageCW(C);
         dmZLogKeyer.OnSendFinishProc(dmZLogKeyer, mCW, False);
      end;
   end
   else begin
      dmZLogKeyer.SetCWSendBufCharPTT(nID, C);
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('C=[' + C + ']'));
   {$ENDIF}
end;

procedure TCWKeyBoard.OneCharSentProc();
var
   fEnd: Boolean;
begin
   fEnd := False;
   Timer1.Enabled := False;

   if UnsentChars = 0 then begin
      fEnd := True;
   end;

   Console.SelStart := FSentPos;
   if Copy(Console.Text, FSentPos + 1, 1) = '[' then begin
      Console.SelLength := 4;
      Inc(FSentPos, 4);
   end
   else begin
      Console.SelLength := 1;
      Inc(FSentPos);
   end;

   Console.SelAttributes.BackColor := clBlue;
   Console.SelAttributes.Color := clWhite;
   Console.SelAttributes.Protected := True;

   Console.SelStart := Length(Console.Text);

   if fEnd = True then begin
      MainForm.StartCWKeyboard := False;
      Timer1.Enabled := True;
      Exit;
   end;

   SendChar(Console.Text[FSentPos + 1]);
end;

procedure TCWKeyBoard.Reset();
begin
   FSentPos := 0;
   Console.SelStart := 0;
   Console.SelLength := Length(Console.Text);
   Console.SelAttributes.Protected := False;
   Console.SelAttributes.BackColor := clWIndow;
   Console.SelAttributes.Color := clBlack;
   Console.SelStart := 0;
   Console.SelLength := 0;
   Console.Refresh();
end;

procedure TCWKeyBoard.Finish();
begin
   buttonClear.Click();
end;

function TCWKeyBoard.GetUnsentChars(): Integer;
var
   n: Integer;
   i: Integer;
begin
   n := 0;
   for i := 0 to Console.Lines.Count - 1 do begin
      n := n + Length(Console.Lines[i]);
   end;
   Result := n - (FSentPos + 1);

   {$IFDEF DEBUG}
   OutputDebugString(PChar('Unsent = [' + IntToStr(Result) + ']'));
   {$ENDIF}
end;

end.
