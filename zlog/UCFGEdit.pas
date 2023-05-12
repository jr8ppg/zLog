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
    GroupBox4: TGroupBox;
    Label4: TLabel;
    Label9: TLabel;
    comboStartTime: TComboBox;
    comboPeriod: TComboBox;
    checkUseUTC: TCheckBox;
    checkNoDefinedStartTime: TCheckBox;
    Label10: TLabel;
    procedure buttonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure checkNoDefinedStartTimeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private êÈåæ }
    FCwMessageA: array[1..4] of TEdit;
    FBandToUse: array[1..13] of TCheckBox;
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
    function GetUseUTC(): Boolean;
    procedure SetUseUTC(v: Boolean);
    function GetStartTime(): Integer;
    procedure SetStartTime(v: Integer);
    function GetPeriod(): Integer;
    procedure SetPeriod(v: Integer);
  public
    { Public êÈåæ }
    property Sent: string read GetSent write SetSent;
    property Prov: string read GetProv write SetProv;
    property City: string read GetCity write SetCity;
    property Power: string read GetPower write SetPower;
    property CwMessageA[Index: Integer]: string read GetCwMessageA write SetCwMessageA;
    property UseUTC: Boolean read GetUseUTC write SetUseUTC;
    property StartTime: Integer read GetStartTime write SetStartTime;
    property Period: Integer read GetPeriod write SetPeriod;
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

   // WARCÉoÉìÉhÇÕä‹ÇﬂÇ»Ç¢
   FBandToUse[1] := checkBand01;       // 1.9M
   FBandToUse[2] := checkBand02;       // 3.5M
   FBandToUse[3] := checkBand03;       // 7M
   FBandToUse[4] := checkBand05;       // 14M
   FBandToUse[5] := checkBand07;       // 21M
   FBandToUse[6] := checkBand09;       // 28M
   FBandToUse[7] := checkBand10;       // 50M
   FBandToUse[8] := checkBand11;       // 144M
   FBandToUse[9] := checkBand12;       // 430M
   FBandToUse[10] := checkBand13;      // 1.2G
   FBandToUse[11] := checkBand14;      // 2.4G
   FBandToUse[12] := checkBand15;      // 5.6G
   FBandToUse[13] := checkBand16;      // 10Gup
end;

procedure TCFGEdit.FormShow(Sender: TObject);
begin
   checkNoDefinedStartTimeClick(nil);
end;

procedure TCFGEdit.buttonOKClick(Sender: TObject);
begin
   ModalResult := mrOK;
end;

procedure TCFGEdit.checkNoDefinedStartTimeClick(Sender: TObject);
begin
   if checkNoDefinedStartTime.Checked = True then begin
      comboStartTime.Enabled := False;
      comboPeriod.Enabled := False;
   end
   else begin
      comboStartTime.Enabled := True;
      comboPeriod.Enabled := True;
   end;
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

   for i := Low(FBandToUse) to High(FBandToUse) do begin
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
   v := LeftStr(v + '----------------', 13);
   for i := Low(FBandToUse) to High(FBandToUse) do begin
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

function TCFGEdit.GetUseUTC(): Boolean;
begin
   Result := checkUseUTC.Checked;
end;

procedure TCFGEdit.SetUseUTC(v: Boolean);
begin
   checkUseUTC.Checked := v;
end;

function TCFGEdit.GetStartTime(): Integer;
begin
   if checkNoDefinedStartTime.Checked = True then begin
      Result := -1;
   end
   else begin
      Result := StrToIntDef(comboStartTime.Text, -1);
   end;
end;

procedure TCFGEdit.SetStartTime(v: Integer);
begin
   if v = -1 then begin
      checkNoDefinedStartTime.Checked := True;
      comboStartTime.Text := '';
   end
   else begin
      checkNoDefinedStartTime.Checked := False;
      comboStartTime.Text := IntToStr(v);
   end;
end;

function TCFGEdit.GetPeriod(): Integer;
begin
   Result := StrToIntDef(comboPeriod.Text, -1);
end;

procedure TCFGEdit.SetPeriod(v: Integer);
begin
   comboPeriod.Text := IntToStr(v);
end;

end.
