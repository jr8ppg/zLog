unit UNRDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TNRDialog = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    editSentNR: TEdit;
    checkAutoAddPowerCode: TCheckBox;
    editSentNR2: TEdit;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private êÈåæ }
    function GetNewSentNR(): string;
    procedure SetNewSentNR(v: string);
    function GetNewSentNR2(): string;
    procedure SetNewSentNR2(v: string);
    function GetAutoAddPowerCode(): Boolean;
    procedure SetAutoAddPowerCode(v: Boolean);
  public
    { Public êÈåæ }
    property NewSentNR: string read GetNewSentNR write SetNewSentNR;
    property NewSentNR2: string read GetNewSentNR2 write SetNewSentNR2;
    property AutoAddPowerCode: Boolean read GetAutoAddPowerCode write SetAutoAddPowerCode;
  end;

implementation

{$R *.dfm}

procedure TNRDialog.FormCreate(Sender: TObject);
begin
   editSentNR.Text := '';
end;

function TNRDialog.GetNewSentNR(): string;
begin
   Result := editSentNR.Text;
end;

procedure TNRDialog.SetNewSentNR(v: string);
begin
   editSentNR.Text := v;
end;

function TNRDialog.GetNewSentNR2(): string;
begin
   Result := editSentNR2.Text;
end;

procedure TNRDialog.SetNewSentNR2(v: string);
begin
   editSentNR2.Text := v;
end;

function TNRDialog.GetAutoAddPowerCode(): Boolean;
begin
   Result := checkAutoAddPowerCode.Checked;
end;

procedure TNRDialog.SetAutoAddPowerCode(v: Boolean);
begin
   checkAutoAddPowerCode.Checked := v;
end;

end.
