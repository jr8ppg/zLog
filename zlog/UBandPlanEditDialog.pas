unit UBandPlanEditDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  UBandPlan, UzLogConst;

type
  TBandPlanEditDialog = class(TForm)
    Panel1: TPanel;
    TabControl1: TTabControl;
    buttonOK: TButton;
    buttonCancel: TButton;
    labelBand01: TLabel;
    labelBand02: TLabel;
    labelBand03: TLabel;
    labelBand04: TLabel;
    labelBand05: TLabel;
    labelBand06: TLabel;
    labelBand07: TLabel;
    labelBand08: TLabel;
    labelBand09: TLabel;
    labelBand10: TLabel;
    labelBand11: TLabel;
    labelBand12: TLabel;
    labelBand13: TLabel;
    labelBand14: TLabel;
    labelBand15: TLabel;
    labelBand16: TLabel;
    editLower01: TEdit;
    editLower02: TEdit;
    editLower03: TEdit;
    editLower04: TEdit;
    editLower05: TEdit;
    editLower06: TEdit;
    editLower07: TEdit;
    editLower08: TEdit;
    editLower09: TEdit;
    editLower10: TEdit;
    editLower11: TEdit;
    editLower12: TEdit;
    editLower13: TEdit;
    editLower14: TEdit;
    editLower15: TEdit;
    editLower16: TEdit;
    Label17: TLabel;
    editUpper01: TEdit;
    editUpper02: TEdit;
    editUpper03: TEdit;
    editUpper04: TEdit;
    editUpper05: TEdit;
    editUpper06: TEdit;
    editUpper07: TEdit;
    editUpper08: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    editUpper09: TEdit;
    Label20: TLabel;
    editUpper10: TEdit;
    editUpper11: TEdit;
    editUpper12: TEdit;
    editUpper13: TEdit;
    editUpper14: TEdit;
    editUpper15: TEdit;
    editUpper16: TEdit;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    buttonLoadDefaults: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure buttonOKClick(Sender: TObject);
    procedure buttonLoadDefaultsClick(Sender: TObject);
  private
    { Private êÈåæ }
    FTmpLimit: array [mCW..mOther] of TFreqLimitArray;
    FLabelArray: array[b19..HiBand] of TLabel;
    FLowerEditArray: array[b19..HiBand] of TEdit;
    FUpperEditArray: array[b19..HiBand] of TEdit;

    procedure ShowBandPlan(m: TMode);
    procedure SaveBandPlan(m: TMode);

    function GetLimit(m: TMode): TFreqLimitArray;
    procedure SetLimit(m: TMode; v: TFreqLimitArray);
  public
    { Public êÈåæ }
    property Limit[m: TMode]: TFreqLimitArray read GetLimit write SetLimit;
  end;

implementation

{$R *.dfm}

uses UzLogGlobal;

procedure TBandPlanEditDialog.FormCreate(Sender: TObject);
var
   m: TMode;
   b: TBand;
begin
   for m := mCW to mOther do begin
      FTmpLimit[m] := dmZLogGlobal.BandPlan.Limit[m];
   end;

   FLabelArray[b19]     := labelBand01;
   FLabelArray[b35]     := labelBand02;
   FLabelArray[b7]      := labelBand03;
   FLabelArray[b10]     := labelBand04;
   FLabelArray[b14]     := labelBand05;
   FLabelArray[b18]     := labelBand06;
   FLabelArray[b21]     := labelBand07;
   FLabelArray[b24]     := labelBand08;
   FLabelArray[b28]     := labelBand09;
   FLabelArray[b50]     := labelBand10;
   FLabelArray[b144]    := labelBand11;
   FLabelArray[b430]    := labelBand12;
   FLabelArray[b1200]   := labelBand13;
   FLabelArray[b2400]   := labelBand14;
   FLabelArray[b5600]   := labelBand15;
   FLabelArray[b10g]    := labelBand16;

   for b := b19 to HiBand do begin
      FLabelArray[b].Caption := BandString[b];
   end;

   FLowerEditArray[b19]    := editLower01;
   FLowerEditArray[b35]    := editLower02;
   FLowerEditArray[b7]     := editLower03;
   FLowerEditArray[b10]    := editLower04;
   FLowerEditArray[b14]    := editLower05;
   FLowerEditArray[b18]    := editLower06;
   FLowerEditArray[b21]    := editLower07;
   FLowerEditArray[b24]    := editLower08;
   FLowerEditArray[b28]    := editLower09;
   FLowerEditArray[b50]    := editLower10;
   FLowerEditArray[b144]   := editLower11;
   FLowerEditArray[b430]   := editLower12;
   FLowerEditArray[b1200]  := editLower13;
   FLowerEditArray[b2400]  := editLower14;
   FLowerEditArray[b5600]  := editLower15;
   FLowerEditArray[b10g]   := editLower16;

   FUpperEditArray[b19]    := editUpper01;
   FUpperEditArray[b35]    := editUpper02;
   FUpperEditArray[b7]     := editUpper03;
   FUpperEditArray[b10]    := editUpper04;
   FUpperEditArray[b14]    := editUpper05;
   FUpperEditArray[b18]    := editUpper06;
   FUpperEditArray[b21]    := editUpper07;
   FUpperEditArray[b24]    := editUpper08;
   FUpperEditArray[b28]    := editUpper09;
   FUpperEditArray[b50]    := editUpper10;
   FUpperEditArray[b144]   := editUpper11;
   FUpperEditArray[b430]   := editUpper12;
   FUpperEditArray[b1200]  := editUpper13;
   FUpperEditArray[b2400]  := editUpper14;
   FUpperEditArray[b5600]  := editUpper15;
   FUpperEditArray[b10g]   := editUpper16;
end;

procedure TBandPlanEditDialog.FormDestroy(Sender: TObject);
begin
//
end;

procedure TBandPlanEditDialog.FormShow(Sender: TObject);
begin
   ShowBandPlan(TMode(TTabControl(Sender).TabIndex));
end;

procedure TBandPlanEditDialog.buttonOKClick(Sender: TObject);
begin
   SaveBandPlan(TMode(TTabControl(Sender).TabIndex));
end;

procedure TBandPlanEditDialog.buttonLoadDefaultsClick(Sender: TObject);
var
   m: TMode;
begin
   m := TMode(TabControl1.TabIndex);
   FTmpLimit[m] := dmZLogGlobal.BandPlan.Defaults[m];
   ShowBandPlan(m);
end;

procedure TBandPlanEditDialog.TabControl1Change(Sender: TObject);
begin
   ShowBandPlan(TMode(TTabControl(Sender).TabIndex));
end;

procedure TBandPlanEditDialog.TabControl1Changing(Sender: TObject; var AllowChange: Boolean);
begin
   SaveBandPlan(TMode(TTabControl(Sender).TabIndex));
end;

procedure TBandPlanEditDialog.ShowBandPlan(m: TMode);
var
   b: TBand;
begin
   for b := b19 to Hiband do begin
      FLowerEditArray[b].Text := IntToStr(FTmpLimit[m][b].Lower div 1000);
      FUpperEditArray[b].Text := IntToStr(FTmpLimit[m][b].Upper div 1000);
   end;
end;

procedure TBandPlanEditDialog.SaveBandPlan(m: TMode);
var
   b: TBand;
begin
   for b := b19 to Hiband do begin
      FTmpLimit[m][b].Lower := StrToUInt64Def(FLowerEditArray[b].Text, 0) * 1000;
      FTmpLimit[m][b].Upper := StrToUInt64Def(FUpperEditArray[b].Text, 0) * 1000;
   end;
end;

function TBandPlanEditDialog.GetLimit(m: TMode): TFreqLimitArray;
begin
   Result := FTmpLimit[m];
end;

procedure TBandPlanEditDialog.SetLimit(m: TMode; v: TFreqLimitArray);
begin
   FTmpLimit[m] := v;
end;

end.
