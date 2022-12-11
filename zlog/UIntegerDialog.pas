unit UIntegerDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TIntegerDialog = class(TForm)
    Label1: TLabel;
    Edit: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    //Value : integer;
    Cancelled : boolean;
  public
    procedure Init(i: integer; S: string);
    function GetValue(): integer;
    function GetValueExtended(): Extended;
    function GetValueString(): string;
    procedure SetLabel(S : string);
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TIntegerDialog.Init(i: integer; S: string);
begin
   Edit.Text := IntToStr(i);
   SetLabel(S);
end;

function TIntegerDialog.GetValue: integer;
begin
   if Cancelled then begin
      Result := 0;
      exit;
   end;

   Result := StrToIntDef(Edit.Text, -1);
end;

function TIntegerDialog.GetValueExtended: extended;
begin
   Result := StrToFloatDef(Edit.Text, -1);
end;

function TIntegerDialog.GetValueString(): string;
begin
   Result := Edit.Text;
end;

procedure TIntegerDialog.SetLabel(S: string);
var
   w: integer;
begin
   Label1.Caption := S;
   w := Width - Label1.Width;
   if w > 0 then
      Label1.Left := w div 2
end;

procedure TIntegerDialog.FormCreate(Sender: TObject);
begin
   Caption := Application.Title;
end;

procedure TIntegerDialog.FormShow(Sender: TObject);
begin
   Edit.Left := (Width - Edit.Width) div 2;
   Button1.Left := Edit.Left - 16;
   Button2.Left := Edit.Left + Edit.Width + 16 - Button2.Width;
   Cancelled := False;
end;

procedure TIntegerDialog.Button2Click(Sender: TObject);
begin
   Cancelled := True;
   Edit.Text := '';
end;

end.
