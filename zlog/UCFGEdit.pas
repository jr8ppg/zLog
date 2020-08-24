unit UCFGEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.StrUtils, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TCFGEdit = class(TForm)
    buttonOK: TButton;
    buttonCancel: TButton;
    Label1: TLabel;
    editSent: TEdit;
    Label2: TLabel;
    editProv: TEdit;
    Label3: TLabel;
    editCity: TEdit;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    editCWF1A: TEdit;
    editCWF2A: TEdit;
    Label6: TLabel;
    editCWF3A: TEdit;
    Label7: TLabel;
    editCWF4A: TEdit;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    checkBand01: TCheckBox;
    checkBand02: TCheckBox;
    checkBand03: TCheckBox;
    checkBand04: TCheckBox;
    checkBand05: TCheckBox;
    checkBand06: TCheckBox;
    checkBand07: TCheckBox;
    checkBand08: TCheckBox;
    checkBand09: TCheckBox;
    checkBand10: TCheckBox;
    checkBand11: TCheckBox;
    checkBand12: TCheckBox;
    checkBand13: TCheckBox;
    checkBand14: TCheckBox;
    checkBand15: TCheckBox;
    checkBand16: TCheckBox;
    procedure buttonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private êÈåæ }
    FCwMessageA: array[1..4] of TEdit;
    FBandToUse: array[1..16] of TCheckBox;
    function GetSent(): string;
    procedure SetSent(v: string);
    function GetProv(): string;
    procedure SetProv(v: string);
    function GetCity(): string;
    procedure SetCity(v: string);
    function GetPower(): string;
    procedure SetPower(v: string);
    function GetCwMessageA(Index: Integer): string;
    procedure SetCwMessageA(Index: Integer; v: string);
  public
    { Public êÈåæ }
    property Sent: string read GetSent write SetSent;
    property Prov: string read GetProv write SetProv;
    property City: string read GetCity write SetCity;
    property Power: string read GetPower write SetPower;
    property CwMessageA[Index: Integer]: string read GetCwMessageA write SetCwMessageA;
  end;

implementation

{$R *.dfm}

procedure TCFGEdit.FormCreate(Sender: TObject);
begin
   editSent.Text := '';
   editProv.Text := '';
   editCity.Text := '';
   FCwMessageA[1] := editCWF1A;
   FCwMessageA[2] := editCWF2A;
   FCwMessageA[3] := editCWF3A;
   FCwMessageA[4] := editCWF4A;
   FBandToUse[1] := checkBand01;
   FBandToUse[2] := checkBand02;
   FBandToUse[3] := checkBand03;
   FBandToUse[4] := checkBand04;
   FBandToUse[5] := checkBand05;
   FBandToUse[6] := checkBand06;
   FBandToUse[7] := checkBand07;
   FBandToUse[8] := checkBand08;
   FBandToUse[9] := checkBand09;
   FBandToUse[10] := checkBand10;
   FBandToUse[11] := checkBand11;
   FBandToUse[12] := checkBand12;
   FBandToUse[13] := checkBand13;
   FBandToUse[14] := checkBand14;
   FBandToUse[15] := checkBand15;
   FBandToUse[16] := checkBand16;
end;

procedure TCFGEdit.buttonOKClick(Sender: TObject);
begin
   ModalResult := mrOK;
end;

function TCFGEdit.GetSent(): string;
begin
   Result := editSent.Text;
end;

procedure TCFGEdit.SetSent(v: string);
begin
   editSent.Text := v;
end;

function TCFGEdit.GetProv(): string;
begin
   Result := editProv.Text;
end;

procedure TCFGEdit.SetProv(v: string);
begin
   editProv.Text := v;
end;

function TCFGEdit.GetCity(): string;
begin
   Result := editCity.Text;
end;

procedure TCFGEdit.SetCity(v: string);
begin
   editCity.Text := v;
end;

function TCFGEdit.GetPower(): string;
var
   i: Integer;
   s: string;
begin
   s := '';

   for i := 1 to 16 do begin
      if FBandToUse[i].Checked = False then begin
         s := s + '-';
      end
      else begin
         s := s + 'H';
      end;
   end;

   Result := s;
end;

procedure TCFGEdit.SetPower(v: string);
var
   i: Integer;
begin
   v := LeftStr(v + '----------------', 16);
   for i := 1 to 16 do begin
      if v[i] = '-' then begin
         FBandToUse[i].Checked := False;
      end
      else begin
         FBandToUse[i].Checked := True;
      end;
   end;
end;

function TCFGEdit.GetCwMessageA(Index: Integer): string;
begin
   Result := FCwMessageA[Index].Text;
end;

procedure TCFGEdit.SetCwMessageA(Index: Integer; v: string);
begin
   FCwMessageA[Index].Text := v;
end;

end.
