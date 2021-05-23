unit UGraphColorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  UzLogConst;

type
  TGraphColorDialog = class(TForm)
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label57: TLabel;
    editColor01: TEdit;
    buttonFG01: TButton;
    buttonReset01: TButton;
    buttonBG01: TButton;
    Label1: TLabel;
    editColor02: TEdit;
    buttonFG02: TButton;
    buttonReset02: TButton;
    buttonBG02: TButton;
    Label2: TLabel;
    editColor03: TEdit;
    buttonFG03: TButton;
    buttonReset03: TButton;
    buttonBG03: TButton;
    Label3: TLabel;
    editColor04: TEdit;
    buttonFG04: TButton;
    buttonReset04: TButton;
    buttonBG04: TButton;
    Label4: TLabel;
    editColor05: TEdit;
    buttonFG05: TButton;
    buttonReset05: TButton;
    buttonBG05: TButton;
    Label5: TLabel;
    editColor06: TEdit;
    buttonFG06: TButton;
    buttonReset06: TButton;
    buttonBG06: TButton;
    Label6: TLabel;
    editColor07: TEdit;
    buttonFG07: TButton;
    buttonReset07: TButton;
    buttonBG07: TButton;
    Label7: TLabel;
    editColor08: TEdit;
    buttonFG08: TButton;
    buttonReset08: TButton;
    buttonBG08: TButton;
    Label8: TLabel;
    editColor09: TEdit;
    buttonFG09: TButton;
    buttonReset09: TButton;
    buttonBG09: TButton;
    Label9: TLabel;
    editColor10: TEdit;
    buttonFG10: TButton;
    buttonReset10: TButton;
    buttonBG10: TButton;
    Label10: TLabel;
    editColor11: TEdit;
    buttonFG11: TButton;
    buttonReset11: TButton;
    buttonBG11: TButton;
    Label11: TLabel;
    editColor12: TEdit;
    buttonFG12: TButton;
    buttonReset12: TButton;
    buttonBG12: TButton;
    Label12: TLabel;
    editColor13: TEdit;
    buttonFG13: TButton;
    buttonReset13: TButton;
    buttonBG13: TButton;
    Label13: TLabel;
    editColor14: TEdit;
    buttonFG14: TButton;
    buttonReset14: TButton;
    buttonBG14: TButton;
    Label14: TLabel;
    editColor15: TEdit;
    buttonFG15: TButton;
    buttonReset15: TButton;
    buttonBG15: TButton;
    Label15: TLabel;
    editColor16: TEdit;
    buttonFG16: TButton;
    buttonReset16: TButton;
    buttonBG16: TButton;
    ColorDialog1: TColorDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonFGClick(Sender: TObject);
    procedure buttonBGClick(Sender: TObject);
    procedure buttonResetClick(Sender: TObject);
  private
    { Private êÈåæ }
    FGraphColor: array[b19..HiBand] of TEdit;
    function GetBarColor(b: TBand): TColor;
    procedure SetBarColor(b: TBand; c: TColor);
    function GetTextColor(b: TBand): TColor;
    procedure SetTextColor(b: TBand; c: TColor);
  public
    { Public êÈåæ }
    property BarColor[b: TBand]: TColor read GetBarColor write SetBarColor;
    property TextColor[b: TBand]: TColor read GetTextColor write SetTextColor;
  end;

implementation

{$R *.dfm}

procedure TGraphColorDialog.buttonBGClick(Sender: TObject);
var
   b: TBand;
begin
   b := TBand(TButton(Sender).Tag);

   ColorDialog1.Color := FGraphColor[b].Color;
   if ColorDialog1.Execute = True then begin
      FGraphColor[b].Color := ColorDialog1.Color;
   end;
end;

procedure TGraphColorDialog.buttonFGClick(Sender: TObject);
var
   b: TBand;
begin
   b := TBand(TButton(Sender).Tag);

   ColorDialog1.Color := FGraphColor[b].Font.Color;
   if ColorDialog1.Execute = True then begin
      FGraphColor[b].Font.Color := ColorDialog1.Color;
   end;
end;

procedure TGraphColorDialog.buttonResetClick(Sender: TObject);
var
   b: TBand;
begin
   b := TBand(TButton(Sender).Tag);
   FGraphColor[b].Color := default_graph_bar_color[b];
   FGraphColor[b].Font.Color := default_graph_text_color[b];
end;

procedure TGraphColorDialog.FormCreate(Sender: TObject);
begin
   FGraphColor[b19]     := editColor01;
   FGraphColor[b35]     := editColor02;
   FGraphColor[b7]      := editColor03;
   FGraphColor[b10]     := editColor04;
   FGraphColor[b14]     := editColor05;
   FGraphColor[b18]     := editColor06;
   FGraphColor[b21]     := editColor07;
   FGraphColor[b24]     := editColor08;
   FGraphColor[b28]     := editColor09;
   FGraphColor[b50]     := editColor10;
   FGraphColor[b144]    := editColor11;
   FGraphColor[b430]    := editColor12;
   FGraphColor[b1200]   := editColor13;
   FGraphColor[b2400]   := editColor14;
   FGraphColor[b5600]   := editColor15;
   FGraphColor[b10g]    := editColor16;
end;

procedure TGraphColorDialog.FormDestroy(Sender: TObject);
begin
//
end;

function TGraphColorDialog.GetBarColor(b: TBand): TColor;
begin
   Result := FGraphColor[b].Color;
end;

procedure TGraphColorDialog.SetBarColor(b: TBand; c: TColor);
begin
   FGraphColor[b].Color := c;
end;

function TGraphColorDialog.GetTextColor(b: TBand): TColor;
begin
   Result := FGraphColor[b].Font.Color;
end;

procedure TGraphColorDialog.SetTextColor(b: TBand; c: TColor);
begin
   FGraphColor[b].Font.Color := c;
end;

end.
