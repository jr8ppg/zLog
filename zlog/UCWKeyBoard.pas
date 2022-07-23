unit UCWKeyBoard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ClipBrd, System.Actions, Vcl.ActnList,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogCW, UzLogKeyer;

type
  TCWKeyBoard = class(TForm)
    Console: TMemo;
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
    actionESC: TAction;
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
    procedure ConsoleKeyPress(Sender: TObject; var Key: Char);
    procedure buttonOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure buttonClearClick(Sender: TObject);
    procedure actionPlayMessageAExecute(Sender: TObject);
    procedure actionPlayMessageBExecute(Sender: TObject);
    procedure actionPlayMessageARExecute(Sender: TObject);
    procedure actionPlayMessageBKExecute(Sender: TObject);
    procedure actionPlayMessageKNExecute(Sender: TObject);
    procedure actionPlayMessageSKExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actionESCExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure actionDecreaseCwSpeedExecute(Sender: TObject);
    procedure actionIncreaseCwSpeedExecute(Sender: TObject);
    procedure actionPlayMessageBTExecute(Sender: TObject);
    procedure actionPlayMessageVAExecute(Sender: TObject);
  private
    { Private declarations }
    procedure PlayMessage(nID: Integer; cb: Integer; no: Integer);
    procedure ApplyShortcut();
  public
    { Public declarations }
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TCWKeyBoard.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TCWKeyBoard.FormCreate(Sender: TObject);
begin
   Console.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
end;

procedure TCWKeyBoard.FormShow(Sender: TObject);
begin
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

procedure TCWKeyBoard.ConsoleKeyPress(Sender: TObject; var Key: Char);
var
   K: Char;
   nID: Integer;
begin
   if Key = Chr($1B) then begin
      Exit;
   end;

   if Key = Chr($08) then begin
      dmZLogKeyer.CancelLastChar;
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

   nID := MainForm.CurrentRigID;

   dmZLogKeyer.SetCWSendBufCharPTT(nID, K);

   Key := K;
end;

procedure TCWKeyBoard.buttonOKClick(Sender: TObject);
begin
   Close;
   MainForm.SetLastFocus();
end;

procedure TCWKeyBoard.buttonClearClick(Sender: TObject);
begin
   Console.Clear;
   dmZLogKeyer.ClrBuffer();
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
   dmZLogKeyer.SetCWSendBufCharPTT(MainForm.CurrentRigID, 'a');
   Console.Text := Console.Text + '[AR]';
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionPlayMessageBKExecute(Sender: TObject);
begin
   dmZLogKeyer.SetCWSendBufCharPTT(MainForm.CurrentRigID, 'b');
   Console.Text := Console.Text + '[BK]';
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionPlayMessageBTExecute(Sender: TObject);
begin
   dmZLogKeyer.SetCWSendBufCharPTT(MainForm.CurrentRigID, 't');
   Console.Text := Console.Text + '[BT]';
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionPlayMessageKNExecute(Sender: TObject);
begin
   dmZLogKeyer.SetCWSendBufCharPTT(MainForm.CurrentRigID,'k');
   Console.Text := Console.Text + '[KN]';
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionPlayMessageSKExecute(Sender: TObject);
begin
   dmZLogKeyer.SetCWSendBufCharPTT(MainForm.CurrentRigID,'s');
   Console.Text := Console.Text + '[SK]';
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionPlayMessageVAExecute(Sender: TObject);
begin
   dmZLogKeyer.SetCWSendBufCharPTT(MainForm.CurrentRigID,'s');
   Console.Text := Console.Text + '[VA]';
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionESCExecute(Sender: TObject);
begin
   if dmZLogKeyer.IsPlaying then begin
      dmZLogKeyer.ClrBuffer;
      dmZLogKeyer.ControlPTT(MainForm.CurrentRigID, False);
   end
   else begin
      dmZLogKeyer.ControlPTT(MainForm.CurrentRigID, False);
      MainForm.SetLastFocus();
   end;
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

   zLogSendStr2(nID, S, CurrentQSO);

   while Pos(':***********', S) > 0 do begin
      i := Pos(':***********', S);
      Delete(S, i, 12);
      Insert(CurrentQSO.Callsign, S, i);
   end;

   ClipBoard.AsText := S;
   Console.PasteFromClipBoard;
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

end.
