unit UStatusEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  UzLogQso, UzLogConst;

type
  TformStatusEdit = class(TForm)
    GroupBox2: TGroupBox;
    checkCQ: TCheckBox;
    checkInvalid: TCheckBox;
    GroupBox1: TGroupBox;
    radioQslNone: TRadioButton;
    radioPseQsl: TRadioButton;
    radioNoQsl: TRadioButton;
    Panel2: TPanel;
    OKBtn: TButton;
    CancelBtn: TButton;
  private
    { Private êÈåæ }
    function GetCQ(): Boolean;
    procedure SetCQ(v: Boolean);
    function GetInvalid(): Boolean;
    procedure SetInvalid(v: Boolean);
    function GetQslState(): TQslState;
    procedure SetQslState(v: TQslState);
  public
    { Public êÈåæ }
    property CQ: Boolean read GetCQ write SetCQ;
    property Invalid: Boolean read GetInvalid write SetInvalid;
    property QslState: TQslState read GetQslState write SetQslState;
  end;

implementation

{$R *.dfm}

function TformStatusEdit.GetCQ(): Boolean;
begin
   Result := checkCQ.Checked;
end;

procedure TformStatusEdit.SetCQ(v: Boolean);
begin
   checkCQ.Checked := v;
end;

function TformStatusEdit.GetInvalid(): Boolean;
begin
   Result := checkInvalid.Checked;
end;

procedure TformStatusEdit.SetInvalid(v: Boolean);
begin
   checkInvalid.Checked := v;
end;

function TformStatusEdit.GetQslState(): TQslState;
begin
   if radioQslNone.Checked = True then begin
      Result := qsNone;
   end
   else if radioNoQsl.Checked = True then begin
      Result := qsNoQsl;
   end
   else if radioPseQsl.Checked = True then begin
      Result := qsPseQsl;
   end
   else begin
      Result := qsNone;
   end;
end;

procedure TformStatusEdit.SetQslState(v: TQslState);
begin
   case v of
      qsNone:   radioQslNone.Checked := True;
      qsNoQsl:  radioNoQsl.Checked := True;
      qsPseQsl: radioPseQsl.Checked := True;
      else      radioQslNone.Checked := True;
   end;
end;

end.
