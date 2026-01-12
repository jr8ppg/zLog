unit UDmsToGridDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, UGridLocator;

type
  TformDmsToGridDialog = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    editLatitudeD: TEdit;
    editLatitudeM: TEdit;
    editLatitudeS: TEdit;
    editLongitudeD: TEdit;
    editLongitudeM: TEdit;
    editLongitudeS: TEdit;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    buttonCalc: TButton;
    GroupBox2: TGroupBox;
    Label39: TLabel;
    Label42: TLabel;
    editMyGridLoc: TEdit;
    editMyLatitude: TEdit;
    editMyLongitude: TEdit;
    Label56: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure buttonCalcClick(Sender: TObject);
  private
    { Private êÈåæ }
    function GetGridLoc(): string;
    function GetLatitude(): string;
    function GetLongitude(): string;
  public
    { Public êÈåæ }
    property GridLoc: string read GetGridLoc;
    property Latitude: string read GetLatitude;
    property Longitude: string read GetLongitude;
  end;

implementation

{$R *.dfm}

procedure TformDmsToGridDialog.FormCreate(Sender: TObject);
begin
   editLatitudeD.Text := '';
   editLatitudeM.Text := '';
   editLatitudeS.Text := '';
   editLongitudeD.Text := '';
   editLongitudeM.Text := '';
   editLongitudeS.Text := '';
   editMyGridLoc.Text := '';
   editMyLatitude.Text := '';
   editMyLongitude.Text := '';
end;

procedure TformDmsToGridDialog.buttonCalcClick(Sender: TObject);
var
   deg: Extended;
   d, m, s: Integer;
   latitude, longitude: Extended;
begin
   // Latitude
   d := StrToIntDef(editLatitudeD.Text, 0);
   m := StrToIntDef(editLatitudeM.Text, 0);
   s := StrToIntDef(editLatitudeS.Text, 0);
   deg := glDmsToDeg(d, m, s);
   editMyLatitude.Text := Format('%.4f', [deg]);
   latitude := deg;

   // Longtitude
   d := StrToIntDef(editLongitudeD.Text, 0);
   m := StrToIntDef(editLongitudeM.Text, 0);
   s := StrToIntDef(editLongitudeS.Text, 0);
   deg := glDmsToDeg(d, m, s);
   editMyLongitude.Text := Format('%.4f', [deg * -1]);
   longitude := deg;

   // GRID Loc.
   editMyGridLoc.Text := glDegToGrid(latitude, longitude);
end;

function TformDmsToGridDialog.GetGridLoc(): string;
begin
   Result := editMyGridLoc.Text;
end;

function TformDmsToGridDialog.GetLatitude(): string;
begin
   Result := editMyLatitude.Text;
end;

function TformDmsToGridDialog.GetLongitude(): string;
begin
   Result := editMyLongitude.Text;
end;

end.
