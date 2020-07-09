unit UTextEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, ActnList, System.Actions;

type
  TTextEditor = class(TForm)
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    Memo1: TMemo;
    ActionList1: TActionList;
    actionSelectAll: TAction;
    procedure buttonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actionSelectAllExecute(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private êÈåæ }
    function GetText(): string;
    procedure SetText(v: string);
  public
    { Public êÈåæ }
    property Text: string read GetText write SetText;
  end;

implementation

{$R *.dfm}

procedure TTextEditor.FormCreate(Sender: TObject);
begin
   Memo1.Text := '';
end;

procedure TTextEditor.FormShow(Sender: TObject);
begin
    Memo1.SetFocus();
end;

procedure TTextEditor.buttonOKClick(Sender: TObject);
begin
//
end;

procedure TTextEditor.Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Key = $1B) then buttonCancel.Click;
end;

procedure TTextEditor.actionSelectAllExecute(Sender: TObject);
begin
    Memo1.SelectAll();
end;

function TTextEditor.GetText(): string;
begin
   Result := Memo1.Text;
end;

procedure TTextEditor.SetText(v: string);
begin
   Memo1.Text := v;
end;

end.
