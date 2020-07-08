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
  private
    { Private declarations }
    procedure PlayMessage(cb: Integer; no: Integer);
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
   actionPlayMessageA01.ShortCut := MainForm.actionPlayMessageA01.ShortCut;
   actionPlayMessageA02.ShortCut := MainForm.actionPlayMessageA02.ShortCut;
   actionPlayMessageA03.ShortCut := MainForm.actionPlayMessageA03.ShortCut;
   actionPlayMessageA04.ShortCut := MainForm.actionPlayMessageA04.ShortCut;
   actionPlayMessageA05.ShortCut := MainForm.actionPlayMessageA05.ShortCut;
   actionPlayMessageA06.ShortCut := MainForm.actionPlayMessageA06.ShortCut;
   actionPlayMessageA07.ShortCut := MainForm.actionPlayMessageA07.ShortCut;
   actionPlayMessageA08.ShortCut := MainForm.actionPlayMessageA08.ShortCut;
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
   actionPlayMessageB11.ShortCut := MainForm.actionPlayMessageB11.ShortCut;
   actionPlayMessageB12.ShortCut := MainForm.actionPlayMessageB12.ShortCut;

   actionPlayMessageA01.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA01.SecondaryShortCuts);
   actionPlayMessageA02.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA02.SecondaryShortCuts);
   actionPlayMessageA03.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA03.SecondaryShortCuts);
   actionPlayMessageA04.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA04.SecondaryShortCuts);
   actionPlayMessageA05.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA05.SecondaryShortCuts);
   actionPlayMessageA06.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA06.SecondaryShortCuts);
   actionPlayMessageA07.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA07.SecondaryShortCuts);
   actionPlayMessageA08.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA08.SecondaryShortCuts);
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
   actionPlayMessageB11.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB11.SecondaryShortCuts);
   actionPlayMessageB12.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB12.SecondaryShortCuts);
end;

procedure TCWKeyBoard.FormShow(Sender: TObject);
begin
   Console.SetFocus;
end;

procedure TCWKeyBoard.ConsoleKeyPress(Sender: TObject; var Key: Char);
var
   K: Char;
begin
   if Key = Chr($1B) then
      exit;

   if Key = Chr($08) then begin
      dmZLogKeyer.CancelLastChar;
   end
   else begin
      if HiWord(GetKeyState(VK_SHIFT)) <> 0 then
         K := LowCase(Key)
      else
         K := UpCase(Key);

      dmZLogKeyer.SetCWSendBufCharPTT(K);
      Key := K;
   end;
end;

procedure TCWKeyBoard.buttonOKClick(Sender: TObject);
begin
   Close;
   MainForm.LastFocus.SetFocus;
end;

procedure TCWKeyBoard.buttonClearClick(Sender: TObject);
begin
   Console.Clear;
end;

procedure TCWKeyBoard.actionPlayMessageAExecute(Sender: TObject);
var
   no: Integer;
   cb: Integer;
begin
   no := TAction(Sender).Tag;
   cb := dmZlogGlobal.Settings.CW.CurrentBank;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('PlayMessageA(' + IntToStr(cb) + ',' + IntToStr(no) + ')'));
   {$ENDIF}

   PlayMessage(cb, no);
end;

procedure TCWKeyBoard.actionPlayMessageBExecute(Sender: TObject);
var
   no: Integer;
   cb: Integer;
begin
   no := TAction(Sender).Tag;
   cb := dmZlogGlobal.Settings.CW.CurrentBank;

   if cb = 1 then
      cb := 2
   else
      cb := 1;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('PlayMessageB(' + IntToStr(cb) + ',' + IntToStr(no) + ')'));
   {$ENDIF}

   PlayMessage(cb, no);
end;

procedure TCWKeyBoard.actionPlayMessageARExecute(Sender: TObject);
begin
   dmZLogKeyer.SetCWSendBufCharPTT('a');
   Console.Text := Console.Text + '[AR]';
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionPlayMessageBKExecute(Sender: TObject);
begin
   dmZLogKeyer.SetCWSendBufCharPTT('b');
   Console.Text := Console.Text + '[BK]';
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionPlayMessageKNExecute(Sender: TObject);
begin
   dmZLogKeyer.SetCWSendBufCharPTT('k');
   Console.Text := Console.Text + '[KN]';
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionPlayMessageSKExecute(Sender: TObject);
begin
   dmZLogKeyer.SetCWSendBufCharPTT('s');
   Console.Text := Console.Text + '[SK]';
   Console.SelStart := Length(Console.Text);
end;

procedure TCWKeyBoard.actionESCExecute(Sender: TObject);
begin
   if dmZLogKeyer.IsPlaying then begin
      dmZLogKeyer.ClrBuffer;
      dmZLogKeyer.ControlPTT(False);
   end
   else begin
      dmZLogKeyer.ControlPTT(False);
      MainForm.LastFocus.SetFocus;
   end;
end;

procedure TCWKeyBoard.PlayMessage(cb: Integer; no: Integer);
var
   S: string;
   i: Integer;
begin
   S := dmZlogGlobal.CWMessage(cb, no);
   S := SetStr(S, CurrentQSO);
   zLogSendStr(S);

   while Pos(':***********', S) > 0 do begin
      i := Pos(':***********', S);
      Delete(S, i, 12);
      Insert(CurrentQSO.Callsign, S, i);
   end;

   ClipBoard.AsText := S;
   Console.PasteFromClipBoard;
end;

end.
