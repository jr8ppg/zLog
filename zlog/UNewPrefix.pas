unit UNewPrefix;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, {UWWMulti}UMultipliers, UzLogGlobal;

type
  TNewPrefix = class(TForm)
    cbCountry: TComboBox;
    PXEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Prefix : string;
    CtyIndex : integer;
    procedure Init(CL : TCountryList; PX : string);
  end;

implementation

{$R *.DFM}

procedure TNewPrefix.Init(CL: TCountryList; PX: string);
var
   i: integer;
   C: TCountry;
   s: string;
begin
   cbCountry.Items.Clear;
   for i := 0 to CL.Count - 1 do begin
      C := CL[i];
      s := FillRight(C.Country, 10) + C.CountryName;
      cbCountry.Items.Add(s);
   end;
   cbCountry.ItemIndex := -1;
   cbCountry.Text := 'Select a country';
   PXEdit.Text := PX;
end;

procedure TNewPrefix.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   cbCountry.Items.Clear;
end;

procedure TNewPrefix.OKButtonClick(Sender: TObject);
begin
   CtyIndex := cbCountry.ItemIndex;
   Prefix := PXEdit.Text;
   Close;
end;

procedure TNewPrefix.CancelButtonClick(Sender: TObject);
begin
   CtyIndex := -1;
   Prefix := '';
   Close;
end;

end.
