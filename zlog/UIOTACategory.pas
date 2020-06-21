unit UIOTACategory;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TIOTACategory = class(TForm)
    OKBtn: TButton;
    GroupBox1: TGroupBox;
    rbIOTA: TRadioButton;
    rbDXCC: TRadioButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure rbDXCCClick(Sender: TObject);
    procedure rbIOTAClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetIOTA : string;
  end;

implementation

{$R *.DFM}

procedure TIOTACategory.rbDXCCClick(Sender: TObject);
begin
   Edit1.Enabled := False;
end;

procedure TIOTACategory.rbIOTAClick(Sender: TObject);
begin
   Edit1.Enabled := True;
end;

function TIOTACategory.GetIOTA: string;
begin
   if rbIOTA.Checked then
      Result := Edit1.Text
   else
      Result := '';
end;

end.
