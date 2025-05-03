unit UCWKeyBoard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Winapi.RichEdit, Vcl.ComCtrls,
  System.Math, System.SyncObjs,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogCW, UzLogKeyer, URigCtrlLib,
  UzLogForm, Vcl.Samples.Spin;

const
  WM_ZLOG_UPDATE_PROGRESS = (WM_USER + 1);

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
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
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
    procedure ConsoleProtectChange(Sender: TObject; StartPos, EndPos: Integer; var AllowChange: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure OnZLogUpdateProgress( var Message: TMessage ); message WM_ZLOG_UPDATE_PROGRESS;
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    FCounter: Integer;
    FCountMax: Integer;
    FSendPos: Integer;
    FDonePos: Integer;
    FBitmap: TBitmap;
    FTickCount: DWORD;
    procedure PlayMessage(nID: Integer; cb: Integer; no: Integer);
    procedure PlayProsigns(msg: string);
    function GetProsignsChar(msg: string): Char;
    procedure ApplyShortcut();
    procedure SendChar(C: Char);
    function GetUnsentChars(): Integer;
    procedure StartCountdown();
    procedure ShowProgress();
    procedure InitProgress();
  protected
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
    procedure UpdateFontSize(v: Integer); override;
  public
    { Public declarations }
    procedure OneCharSentProc();
    procedure Clear();
    procedure Reset();
    procedure Finish();
    property FontSize: Integer read GetFontSize write SetFontSize;
    property UnsentChars: Integer read GetUnsentChars;
  end;

var
  CWKbdSync: TCriticalSection;

implementation

uses
  Main;

{$R *.DFM}

procedure TCWKeyBoard.FormCreate(Sender: TObject);
var
   dwLangOption: DWORD;
begin
   FBitmap := TBitmap.Create();
   FSendPos := 0;
   FDonePos := 0;
   Console.Clear();
   Console.Font.Charset := DEFAULT_CHARSET;
   Console.Font.Name := dmZLogGlobal.Settings.FBaseFontName;

   dwLangOption := SendMessage(Console.Handle, EM_GETLANGOPTIONS, 0, 0);
   dwLangOption := dwLangOption and (not (IMF_DUALFONT or IMF_AUTOFONT));
   SendMessage(Console.Handle, EM_SETLANGOPTIONS, 0, dwLangOption);

   Console.DefAttributes.Charset := DEFAULT_CHARSET;
   Console.DefAttributes.Name := Console.Font.Name;
   Console.DefAttributes.Size := Console.Font.Size;
   Console.SelAttributes.Charset := DEFAULT_CHARSET;
   Console.SelAttributes.Name := Console.Font.Name;
   Console.SelAttributes.Size := Console.Font.Size;
end;

procedure TCWKeyBoard.FormShow(Sender: TObject);
begin
   Inherited;
   ApplyShortcut();
   InitProgress();
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

procedure TCWKeyBoard.FormDestroy(Sender: TObject);
begin
   inherited;
   FBitmap.Free();
end;

procedure TCWKeyBoard.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE: begin
         PostMessage(MainForm.Handle, WM_ZLOG_CQABORT, 0, 2);
         buttonClear.Click();
      end;
   end;
end;

procedure TCWKeyBoard.FormResize(Sender: TObject);
begin
   inherited;
   InitProgress();
end;

procedure TCWKeyBoard.ConsoleKeyPress(Sender: TObject; var Key: Char);
var
   K: Char;
begin
   CWKbdSync.Enter();
   try
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

      // ���M�\�����ȊO�Ȃ�p�X
      if (Not CharInSet(K, ['A'..'Z', '0'..'9', '?', '/', '-', '=', 'a', 'b', 't', 'k', 's', 'v', '~', '_', '.', '(', ')', ' ', #13])) then begin
         Key := #00;
         Exit;
      end;
   finally
      CWKbdSync.Leave();
   end;

   // CQ���[�v���Ȃ璆�~����
   SendMessage(MainForm.Handle, WM_ZLOG_CQABORT, 1, 0);

   // �P�������M
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
   Clear();
end;

procedure TCWKeyBoard.SpinEdit1Change(Sender: TObject);
begin
   inherited;
   Console.SetFocus();
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
   PlayProsigns('[AR]');
end;

procedure TCWKeyBoard.actionPlayMessageBKExecute(Sender: TObject);
begin
   PlayProsigns('[BK]');
end;

procedure TCWKeyBoard.actionPlayMessageBTExecute(Sender: TObject);
begin
   PlayProsigns('[BT]');
end;

procedure TCWKeyBoard.actionPlayMessageKNExecute(Sender: TObject);
begin
   PlayProsigns('[KN]');
end;

procedure TCWKeyBoard.actionPlayMessageSKExecute(Sender: TObject);
begin
   PlayProsigns('[SK]');
end;

procedure TCWKeyBoard.actionPlayMessageVAExecute(Sender: TObject);
begin
   PlayProsigns('[VA]');
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

   Console.SelStart := Length(Console.Text);
   Console.SelAttributes.Name := Console.Font.Name;
   Console.SelAttributes.Size := Console.Font.Size;

   Console.SelText := S;

   SendChar(Console.Text[FSendPos + 1]);
end;

procedure TCWKeyBoard.PlayProsigns(msg: string);
var
   ch: Char;
begin
   Console.SelStart := Length(Console.Text);
   Console.SelText := msg;

   if MainForm.StartCWKeyboard = False then begin
      ch := GetProsignsChar(msg);
      SendChar(ch);
   end;
end;

function TCWKeyBoard.GetProsignsChar(msg: string): Char;
var
   ch: Char;
begin
   ch := #00;
   if msg = '[AR]' then ch := 'a';
   if msg = '[SK]' then ch := 's';
   if msg = '[VA]' then ch := 's';
   if msg = '[KN]' then ch := 'k';
   if msg = '[BK]' then ch := 'b';
   if msg = '[BT]' then ch := 't';
   Result := ch;
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
   Dec(FCounter);
   ShowProgress();
   if FCounter <= 0 then begin
      Timer1.Enabled := False;
      ShowProgress();
      {$IFDEF DEBUG}
      OutputDebugString(PChar('tick=' + IntToStr(GetTickCount() - FTickCount) + ' milisec.'));
      {$ENDIF}
      buttonClear.Click();
   end;
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
   if (C = #13) or (C = #10) or (c = #00) then begin
      SendMessage(Handle, WM_ZLOG_UPDATE_PROGRESS, 0, 0);
      OneCharSentProc();
      Exit;
   end;

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

   // ���M�ʒu���F��t����
   PostMessage(Handle, WM_ZLOG_UPDATE_PROGRESS, 0, 0);
end;

procedure TCWKeyBoard.OneCharSentProc();
var
   fEnd: Boolean;
   ch: Char;
   S: string;
   len: Integer;
   S2: string;
begin
   Timer1.Enabled := False;
   S := Console.Text;
   CWKbdSync.Enter();
   try
      fEnd := False;

      // �����M���O�����Ȃ�I��
      if UnsentChars = 0 then begin
         fEnd := True;
      end;

      // ���M�ʒu��i�߂�
      len := Length(S);
      if (FSendPos + 1) > len then begin
         Exit;
      end;

      // �O�񑗂�������
      ch := S[FSendPos + 1];

      if ch = '[' then begin
         Inc(FSendPos, 4);
         Inc(FDonePos, 4);
      end
      else if ch = #13 then begin
         Inc(FSendPos, 2);
         Inc(FDonePos);
      end
      else begin
         Inc(FSendPos);
         Inc(FDonePos);
      end;

      if fEnd = True then begin
         MainForm.StartCWKeyboard := False;
         StartCountdown();
         Exit;
      end;

      // ���M�ʒu�������𒴂�����I��
      if (FSendPos + 1) > len then begin
         MainForm.StartCWKeyboard := False;
         StartCountdown();
         Exit;
      end;

      // ���ɑ��镶��
      ch := S[FSendPos + 1];
      if ch = '[' then begin
         S2 := Copy(S, FSendPos + 1, 4);
         ch := GetProsignsChar(S2);
      end;
   finally
      CWKbdSync.Leave();
   end;

   // �P�������M
   SendChar(ch);

   Console.SelStart := len;
end;

procedure TCWKeyBoard.Clear();
begin
   Reset();
   Console.Clear;
   dmZLogKeyer.ClrBuffer();
   MainForm.StartCWKeyboard := False;
end;

procedure TCWKeyBoard.Reset();
begin
   CWKbdSync.Enter();
   try
      Timer1.Enabled := False;
      FSendPos := 0;
      FDonePos := 0;
      FCounter := 0;
      ShowProgress();
      Console.SelStart := 0;
      Console.SelLength := Length(Console.Text);
      Console.SelAttributes.Protected := False;
      Console.SelAttributes.BackColor := clWIndow;
      Console.SelAttributes.Color := clBlack;
      Console.SelStart := 0;
      Console.SelLength := 0;
      Console.Refresh();
   finally
      CWKbdSync.Leave();
   end;
end;

procedure TCWKeyBoard.Finish();
begin
   buttonClear.Click();
end;

function TCWKeyBoard.GetUnsentChars(): Integer;
var
   n: Integer;
begin
   n := Length(Console.Text);
   Result := n - (FSendPos + 1);

   {$IFDEF DEBUG}
   OutputDebugString(PChar('Unsent = [' + IntToStr(Result) + ']'));
   {$ENDIF}
end;

// RichEdit�ł̉��s�́AText�̒���CR LF�̂Q���������ǁA�\����͂P�����ƂȂ��Ă��邽��
// ���M�ʒu�Ƒ��M�ς݂̕\���ʒu��ʂɊǗ�����K�v������

procedure TCWKeyBoard.OnZLogUpdateProgress( var Message: TMessage );
var
   ch: Char;
   S: string;
   len: Integer;
begin
   CWKbdSync.Enter();
   try
      // ���M�ς݈ʒu
      Console.SelStart := FDonePos;

      // ���M�ʒu����P�������F��t����
      S := Console.Text;
      len := Length(S);

      if (FSendPos + 1) > len then begin
         Exit;
      end;

      ch := S[FSendPos + 1];
      if ch = '[' then begin
         Console.SelLength := 4;
      end
      else begin
         Console.SelLength := 1;
      end;

      // ���M�ς݂͐�
      Console.SelAttributes.BackColor := clBlue;
      Console.SelAttributes.Color := clWhite;
      Console.SelAttributes.Protected := True;

      // �F�����ɖ߂�
      Console.SelStart := len;
      Console.SelLength := 0;
      Console.SelAttributes.Protected := False;
      Console.SelAttributes.BackColor := clWindow;
      Console.SelAttributes.Color := clBlack;

      Console.Refresh();
   finally
      CWKbdSync.Leave();
   end;
end;

procedure TCWKeyBoard.StartCountdown();
var
   sec: Integer;
begin
   sec := SpinEdit1.Value;

   // 60 milisec�����肵�Ă���
   Timer1.Interval := 60;

   // 60 milisec�Ŏw��b���ł̃J�E���g��
   FCountMax := Trunc(sec * 1000 / Timer1.Interval);
   FCounter := FCountMax;

   ShowProgress();

   FTickCount := GetTickCount();
   Timer1.Enabled := True;
end;

procedure TCWKeyBoard.ShowProgress();
var
   h, w: Integer;
   white_w, blue_w: Integer;
   rect: TRect;
begin
   h := FBitmap.Height;
   w := FBitmap.Width;

   if FCountMax = 0 then begin
      blue_w := 0;
   end
   else begin
      blue_w := Trunc(w * (FCounter / FCountMax));
   end;
   white_w := w - blue_w;

   with FBitmap.Canvas do begin
      if white_w > 0 then begin
         rect.Top := 0;
         rect.Left := w - white_w;
         rect.Bottom := h - 1;
         rect.Right := w - 1;

         Brush.Color := clWhite;
         Brush.Style := bsSolid;
         Pen.Color := clWhite;
         Pen.Style := psSolid;
         FillRect(rect);
      end;

      if blue_w > 0 then begin
         rect.Top := 0;
         rect.Left := 0;
         rect.Bottom := h - 1;
         rect.Right := blue_w - 1;

         Brush.Color := clBlue;
         Brush.Style := bsSolid;
         Pen.Color := clBlue;
         Pen.Style := psSolid;
         FillRect(rect);
      end;
   end;

   Image1.Picture.Bitmap.Assign(FBitmap);
end;

procedure TCWKeyBoard.InitProgress();
begin
   FBitmap.Width := Image1.Width;
   FBitmap.Height := Image1.Height;
   FBitmap.PixelFormat := pf24bit;
   Image1.Picture.Bitmap.Assign(FBitmap);
end;

initialization
   CWKbdSync := TCriticalSection.Create();

finalization
   CWKbdSync.Free();

end.
