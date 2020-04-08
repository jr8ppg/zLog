unit UNewIOTARef;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TNewIOTARef = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Edit1: TEdit;
    Label1: TLabel;
    Name: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    NewRef : string;
    procedure SetNewRef(S : string);
    function GetName : string;
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TNewIOTARef.SetNewRef(S: string);
begin
   NewRef := S;
   Label1.Caption := 'Add ' + S + ' as a new IOTA reference number?'
end;

function TNewIOTARef.GetName: string;
begin
   Result := Edit1.Text;
end;

procedure TNewIOTARef.FormShow(Sender: TObject);
begin
   Edit1.SetFocus;
end;

end.
