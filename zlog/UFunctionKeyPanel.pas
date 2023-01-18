unit UFunctionKeyPanel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ButtonGroup, Vcl.ActnList, Vcl.Menus,
  Vcl.ExtCtrls, UzLogConst, System.Actions;

type
  TformFunctionKeyPanel = class(TForm)
    ButtonGroup1: TButtonGroup;
    Timer1: TTimer;
    ActionList1: TActionList;
    actionChangeCwBank: TAction;
    procedure FormCreate(Sender: TObject);
    procedure ButtonGroup1Items0Click(Sender: TObject);
    procedure ButtonGroup1Items1Click(Sender: TObject);
    procedure ButtonGroup1Items2Click(Sender: TObject);
    procedure ButtonGroup1Items3Click(Sender: TObject);
    procedure ButtonGroup1Items4Click(Sender: TObject);
    procedure ButtonGroup1Items5Click(Sender: TObject);
    procedure ButtonGroup1Items6Click(Sender: TObject);
    procedure ButtonGroup1Items7Click(Sender: TObject);
    procedure ButtonGroup1Items8Click(Sender: TObject);
    procedure ButtonGroup1Items9Click(Sender: TObject);
    procedure ButtonGroup1Items10Click(Sender: TObject);
    procedure ButtonGroup1Items11Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure actionChangeCwBankExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  protected
    function GetFontSize(): Integer;
    procedure SetFontSize(v: Integer);
  private
    { Private êÈåæ }
    FPrevShift: Boolean;
    FFKeyAction1: array[1..12] of TAction;
    FFKeyAction2: array[1..12] of TAction;
    procedure ButtonClick(n: Integer);
    function GetMyAction(shortcutstr: string): TAction;
  public
    { Public êÈåæ }
    procedure Init();
    procedure UpdateInfo();
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

implementation

{$R *.dfm}

uses
  Main, UzLogGlobal;

procedure TformFunctionKeyPanel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   if MainForm.TaskBarList <> nil then begin
      MainForm.TaskBarList.DeleteTab(Self.Handle);
   end;
end;

procedure TformFunctionKeyPanel.FormCreate(Sender: TObject);
var
   i: Integer;
begin
   FPrevShift := False;

   for i := 1 to 12 do begin
      FFKeyAction1[i] := nil;
      FFKeyAction2[i] := nil;
   end;

   actionChangeCwBank.ShortCut := MainForm.actionChangeCwBank.ShortCut;
   actionChangeCwBank.SecondaryShortCuts.Assign(MainForm.actionChangeCwBank.SecondaryShortCuts);
end;

procedure TformFunctionKeyPanel.FormActivate(Sender: TObject);
begin
   ActionList1.State := asNormal;
end;

procedure TformFunctionKeyPanel.FormDeactivate(Sender: TObject);
begin
   ActionList1.State := asSuspended;
end;

procedure TformFunctionKeyPanel.FormHide(Sender: TObject);
begin
   Timer1.Enabled := False;
end;

procedure TformFunctionKeyPanel.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

procedure TformFunctionKeyPanel.FormShow(Sender: TObject);
begin
   if MainForm.TaskbarList <> nil then begin
      MainForm.TaskBarList.AddTab(Self.Handle);
      MainForm.TaskBarList.ActivateTab(Self.Handle);
   end;

   Timer1.Enabled := True;
   UpdateInfo();
end;

procedure TformFunctionKeyPanel.Init();
var
   i: Integer;
   s: string;
begin
   for i := 1 to 12 do begin
      s := 'F' + IntToStr(i);
      FFKeyAction1[i] := GetMyAction(s);

      s := 'Shift+F' + IntToStr(i);
      FFKeyAction2[i] := GetMyAction(s);
   end;
end;

procedure TformFunctionKeyPanel.UpdateInfo();
var
   act: TAction;
   i: Integer;
   s: string;
   cb: Integer;
const
   title_prefix: array[1..2] of string = ('[A]', '[B]' );
begin
   cb := dmZlogGlobal.Settings.CW.CurrentBank;
   if FPrevShift = True then begin
      if cb = 1 then begin
         cb := 2;
      end
      else begin
         cb := 1;
      end;
   end;

   for i := 0 to 11 do begin
      s := 'F' + IntToStr(i + 1);
      if cb = 1 then begin
         act := FFKeyAction1[i + 1];
      end
      else begin
         act := FFKeyAction2[i + 1];
      end;
      if act = nil then begin
         ButtonGroup1.Items[i].Caption := '';
      end
      else begin
         if (CurrentQSO.Mode = mCW) and (Pos('Play', act.Name) > 0) then begin
            if act.Hint = '' then begin
               ButtonGroup1.Items[i].Caption := s + ':' + dmZLogGlobal.Settings.CW.CWStrBank[cb, i + 1];
            end
            else begin
               ButtonGroup1.Items[i].Caption := s + ':' + act.Hint;
            end;
         end
         else begin
            ButtonGroup1.Items[i].Caption := s + ':' + act.Hint;
         end;
      end;
   end;

   Caption := title_prefix[cb] + ' Function Key';
end;

procedure TformFunctionKeyPanel.ButtonGroup1Items0Click(Sender: TObject);
begin
   ButtonClick(1);
end;

procedure TformFunctionKeyPanel.ButtonGroup1Items1Click(Sender: TObject);
begin
   ButtonClick(2);
end;

procedure TformFunctionKeyPanel.ButtonGroup1Items2Click(Sender: TObject);
begin
   ButtonClick(3);
end;

procedure TformFunctionKeyPanel.ButtonGroup1Items3Click(Sender: TObject);
begin
   ButtonClick(4);
end;

procedure TformFunctionKeyPanel.ButtonGroup1Items4Click(Sender: TObject);
begin
   ButtonClick(5);
end;

procedure TformFunctionKeyPanel.ButtonGroup1Items5Click(Sender: TObject);
begin
   ButtonClick(6);
end;

procedure TformFunctionKeyPanel.ButtonGroup1Items6Click(Sender: TObject);
begin
   ButtonClick(7);
end;

procedure TformFunctionKeyPanel.ButtonGroup1Items7Click(Sender: TObject);
begin
   ButtonClick(8);
end;

procedure TformFunctionKeyPanel.ButtonGroup1Items8Click(Sender: TObject);
begin
   ButtonClick(9);
end;

procedure TformFunctionKeyPanel.ButtonGroup1Items9Click(Sender: TObject);
begin
   ButtonClick(10);
end;

procedure TformFunctionKeyPanel.ButtonGroup1Items10Click(Sender: TObject);
begin
   ButtonClick(11);
end;

procedure TformFunctionKeyPanel.ButtonGroup1Items11Click(Sender: TObject);
begin
   ButtonClick(12);
end;

procedure TformFunctionKeyPanel.actionChangeCwBankExecute(Sender: TObject);
begin
   MainForm.SwitchCWBank(0);
   MainForm.LastFocus.SetFocus();
end;

procedure TformFunctionKeyPanel.ButtonClick(n: Integer);
begin
   MainForm.DoFunctionKey(n);
   MainForm.LastFocus.SetFocus();
end;

function TformFunctionKeyPanel.GetMyAction(shortcutstr: string): TAction;
var
   i: Integer;
   act: TAction;
   shortcut: Word;
begin
   shortcut := TextToShortCut(shortcutstr);
   for i := 0 to MainForm.ActionList1.ActionCount - 1 do begin
      act := TAction(MainForm.ActionList1.Actions[i]);
      if act.ShortCut = shortcut then begin
         Result := act;
         Exit;
      end;
   end;
   Result := nil;
end;

function TformFunctionKeyPanel.GetFontSize(): Integer;
begin
   Result := ButtonGroup1.Font.Size;
end;

procedure TformFunctionKeyPanel.SetFontSize(v: Integer);
begin
   Inherited;
   ButtonGroup1.Font.Size := v;
   ButtonGroup1.Canvas.Font.Size := v;
   ButtonGroup1.ButtonHeight := ButtonGroup1.Canvas.TextHeight('X') + 8;
   ButtonGroup1.ButtonWidth := ButtonGroup1.Canvas.TextWidth('X') * 16 + 8;
end;

procedure TformFunctionKeyPanel.Timer1Timer(Sender: TObject);
var
   fShift: Boolean;
begin
   Timer1.Enabled := False;
   try
      if GetAsyncKeyState(VK_SHIFT) < 0 then begin
         fShift := True;
      end
      else begin
         fShift := False;
      end;

      if FPrevShift <> fShift then begin
         FPrevShift := fShift;
         UpdateInfo();
      end;
   finally
      Timer1.Enabled := True;
   end;
end;

end.
