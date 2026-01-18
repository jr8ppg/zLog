unit UDmsToGridDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.Math, UGridLocator;

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
    procedure editLatitudeDKeyPress(Sender: TObject; var Key: Char);
    procedure editLongitudeDChange(Sender: TObject);
    procedure editMChange(Sender: TObject);
    procedure editLatitudeDChange(Sender: TObject);
    procedure editSChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private éŒ¾ }
    function RangeCheck(edit: TEdit; minvalue, maxValue: Integer): Boolean;
    function GetGridLoc(): string;
    function GetLatitude(): string;
    function GetLongitude(): string;
  public
    { Public éŒ¾ }
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

procedure TformDmsToGridDialog.FormShow(Sender: TObject);
begin
   buttonOK.Enabled := False;
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
   editMyLongitude.Text := Format('%.4f', [deg]);
   longitude := deg;

   // GRID Loc.
   editMyGridLoc.Text := glDegToGrid(latitude, longitude);

   buttonOK.Enabled := True;
end;

procedure TformDmsToGridDialog.editLatitudeDChange(Sender: TObject);
var
   fResult: Boolean;
begin
   fResult := RangeCheck(TEdit(Sender), -89, 89);
   buttonCalc.Enabled := fResult;
end;

procedure TformDmsToGridDialog.editLongitudeDChange(Sender: TObject);
var
   fResult: Boolean;
begin
   fResult := RangeCheck(TEdit(Sender), -179, 179);
   buttonCalc.Enabled := fResult;
end;

procedure TformDmsToGridDialog.editMChange(Sender: TObject);
var
   fResult: Boolean;
begin
   fResult := RangeCheck(TEdit(Sender), 0, 59);
   buttonCalc.Enabled := fResult;
end;

procedure TformDmsToGridDialog.editSChange(Sender: TObject);
var
   fResult: Boolean;
begin
   fResult := RangeCheck(TEdit(Sender), 0, 59);
   buttonCalc.Enabled := fResult;
end;

procedure TformDmsToGridDialog.editLatitudeDKeyPress(Sender: TObject; var Key: Char);
begin
   if Key >= #20 then begin
      if CharInSet(Key, ['0','1','2','3','4','5','6','7','8','9','-']) = False then begin
         Key := #00
      end;
   end;
end;

function TformDmsToGridDialog.RangeCheck(edit: TEdit; minvalue, maxValue: Integer): Boolean;
var
   n: Integer;
begin
   Result := False;
   try
      if edit.Text = '' then begin
         Result := False;
         Exit;
      end;

      n := StrToIntDef(edit.Text, 0);
      if (n < minvalue) or (n > maxvalue) then begin
         Result := False;
         Exit;
      end;

      Result := True;
   finally
      edit.Color := ifthen(Result = False, $00EADEFF, clWindow);
   end;
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
