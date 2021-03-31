unit UFunctionKeyPanel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ButtonGroup, Vcl.ActnList, Vcl.Menus;

type
  TformFunctionKeyPanel = class(TForm)
    ButtonGroup1: TButtonGroup;
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
  protected
    function GetFontSize(): Integer;
    procedure SetFontSize(v: Integer);
  private
    { Private êÈåæ }
    procedure ButtonClick(n: Integer);
    function GetMyAction(shortcutstr: string): TAction;
  public
    { Public êÈåæ }
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

implementation

{$R *.dfm}

uses
  Main;

procedure TformFunctionKeyPanel.FormCreate(Sender: TObject);
begin
//
end;

procedure TformFunctionKeyPanel.FormShow(Sender: TObject);
var
   act: TAction;
   i: Integer;
   s: string;
begin
   for i := 0 to 11 do begin
      s := 'F' + IntToStr(i + 1);
      act := GetMyAction(s);
      if act = nil then begin
         ButtonGroup1.Items[i].Caption := '';
      end
      else begin
         ButtonGroup1.Items[i].Caption := s + ':' + act.Hint;
      end;
   end;
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

end.
