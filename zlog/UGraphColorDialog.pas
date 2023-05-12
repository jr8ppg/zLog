unit UGraphColorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, UzLogConst;

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
    ColorDialog1: TColorDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    groupDrawStyle: TGroupBox;
    radioDrawStyle1: TRadioButton;
    radioDrawStyle2: TRadioButton;
    radioDrawStyle3: TRadioButton;
    groupDrawStartPos: TGroupBox;
    radioDrawStartPos1: TRadioButton;
    radioDrawStartPos2: TRadioButton;
    radioDrawStartPos3: TRadioButton;
    GroupBox5: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    editColor15: TEdit;
    buttonFG15: TButton;
    buttonReset15: TButton;
    buttonBG15: TButton;
    editColor16: TEdit;
    buttonFG16: TButton;
    buttonReset16: TButton;
    buttonBG16: TButton;
    TabSheet4: TTabSheet;
    GroupBox6: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    editZaqTitleLine: TEdit;
    buttonZaqFgTitle: TButton;
    buttonZaqResetTitle: TButton;
    buttonZaqBgTitle: TButton;
    editZaqOddLine: TEdit;
    buttonZaqFgOdd: TButton;
    buttonZaqResetOdd: TButton;
    buttonZaqBgOdd: TButton;
    editZaqEvenLine: TEdit;
    buttonZaqFgEven: TButton;
    buttonZaqResetEven: TButton;
    buttonZaqBgEven: TButton;
    TabSheet5: TTabSheet;
    GroupBox7: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    editActualColor: TEdit;
    buttonActualFg: TButton;
    buttonActualReset: TButton;
    buttonActualBg: TButton;
    editTargetColor: TEdit;
    buttonTargetFg: TButton;
    buttonTargetReset: TButton;
    buttonTargetBg: TButton;
    Label21: TLabel;
    editZaqGridLine: TEdit;
    buttonZaqFgGrid: TButton;
    buttonZaqResetGrid: TButton;
    buttonZaqBgGrid: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonFGClick(Sender: TObject);
    procedure buttonBGClick(Sender: TObject);
    procedure buttonResetClick(Sender: TObject);
    procedure buttonZaqFgClick(Sender: TObject);
    procedure buttonZaqBgClick(Sender: TObject);
    procedure buttonZaqResetClick(Sender: TObject);
    procedure buttonOtherFgClick(Sender: TObject);
    procedure buttonOtherBgClick(Sender: TObject);
    procedure buttonOtherResetClick(Sender: TObject);
  private
    { Private êÈåæ }
    FGraphColor: array[b19..b10g] of TEdit;
    FOtherColor: array[0..1] of TEdit;
    FZaqColor: array[0..3] of TEdit;
    function GetBarColor(b: TBand): TColor;
    procedure SetBarColor(b: TBand; c: TColor);
    function GetTextColor(b: TBand): TColor;
    procedure SetTextColor(b: TBand; c: TColor);
    function GetStyle(): TQSORateStyle;
    procedure SetStyle(v: TQSORateStyle);
    function GetStartPosition(): TQSORateStartPosition;
    procedure SetStartPosition(v: TQSORateStartPosition);
    function GetZaqBgColor(n: Integer): TColor;
    procedure SetZaqBgColor(n: Integer; c: TColor);
    function GetZaqFgColor(n: Integer): TColor;
    procedure SetZaqFgColor(n: Integer; c: TColor);
    function GetOtherBgColor(n: Integer): TColor;
    procedure SetOtherBgColor(n: Integer; c: TColor);
    function GetOtherFgColor(n: Integer): TColor;
    procedure SetOtherFgColor(n: Integer; c: TColor);
  public
    { Public êÈåæ }
    property BarColor[b: TBand]: TColor read GetBarColor write SetBarColor;
    property TextColor[b: TBand]: TColor read GetTextColor write SetTextColor;
    property Style: TQSORateStyle read GetStyle write SetStyle;
    property StartPosition: TQSORateStartPosition read GetStartPosition write SetStartPosition;
    property ZaqBgColor[n: Integer]: TColor read GetZaqBgColor write SetZaqBgColor;
    property ZaqFgColor[n: Integer]: TColor read GetZaqFgColor write SetZaqFgColor;
    property OtherBgColor[n: Integer]: TColor read GetOtherBgColor write SetOtherBgColor;
    property OtherFgColor[n: Integer]: TColor read GetOtherFgColor write SetOtherFgColor;
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
   FOtherColor[0]       := editActualColor;
   FOtherColor[1]       := editTargetColor;
   FZaqColor[0]         := editZaqTitleLine;
   FZaqColor[1]         := editZaqOddLine;
   FZaqColor[2]         := editZaqEvenLine;
   FZaqColor[3]         := editZaqGridLine;
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

function TGraphColorDialog.GetStyle(): TQSORateStyle;
begin
   if radioDrawStyle1.Checked = True then begin
      Result := rsOriginal;
   end
   else if radioDrawStyle2.Checked = True then begin
      Result := rsByBand;
   end
   else if radioDrawStyle3.Checked = True then begin
      Result := rsByFreqRange;
   end
   else begin
      Result := rsOriginal;
   end;
end;

procedure TGraphColorDialog.SetStyle(v: TQSORateStyle);
begin
   case v of
      rsOriginal:    radioDrawStyle1.Checked := True;
      rsByBand:      radioDrawStyle2.Checked := True;
      rsByFreqRange: radioDrawStyle3.Checked := True;
      else           radioDrawStyle1.Checked := True;
   end;
end;

function TGraphColorDialog.GetStartPosition(): TQSORateStartPosition;
begin
   if radioDrawStartPos1.Checked = True then begin
      Result := spFirstQSO;
   end
   else if radioDrawStartPos2.Checked = True then begin
      Result := spCurrentTime;
   end
   else if radioDrawStartPos3.Checked = True then begin
      Result := spLastQSO;
   end
   else begin
      Result := spFirstQSO;
   end;
end;

procedure TGraphColorDialog.SetStartPosition(v: TQSORateStartPosition);
begin
   case v of
      spFirstQSO:    radioDrawStartPos1.Checked := True;
      spCurrentTime: radioDrawStartPos2.Checked := True;
      spLastQSO:     radioDrawStartPos3.Checked := True;
      else           radioDrawStartPos1.Checked := True;
   end;
end;

procedure TGraphColorDialog.buttonZaqBgClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FZaqColor[n].Color;
   if ColorDialog1.Execute = True then begin
      FZaqColor[n].Color := ColorDialog1.Color;
   end;
end;

procedure TGraphColorDialog.buttonZaqFgClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FZaqColor[n].Font.Color;
   if ColorDialog1.Execute = True then begin
      FZaqColor[n].Font.Color := ColorDialog1.Color;
   end;
end;

procedure TGraphColorDialog.buttonZaqResetClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   FZaqColor[n].Color := default_zaq_bg_color[n];
   FZaqColor[n].Font.Color := default_zaq_fg_color[n];
end;

function TGraphColorDialog.GetZaqBgColor(n: Integer): TColor;
begin
   Result := FZaqColor[n].Color;
end;

procedure TGraphColorDialog.SetZaqBgColor(n: Integer; c: TColor);
begin
   FZaqColor[n].Color := c;
end;

function TGraphColorDialog.GetZaqFgColor(n: Integer): TColor;
begin
   Result := FZaqColor[n].Font.Color;
end;

procedure TGraphColorDialog.SetZaqFgColor(n: Integer; c: TColor);
begin
   FZaqColor[n].Font.Color := c;
end;

procedure TGraphColorDialog.buttonOtherBgClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FOtherColor[n].Color;
   if ColorDialog1.Execute = True then begin
      FOtherColor[n].Color := ColorDialog1.Color;
   end;
end;

procedure TGraphColorDialog.buttonOtherFgClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FOtherColor[n].Font.Color;
   if ColorDialog1.Execute = True then begin
      FOtherColor[n].Font.Color := ColorDialog1.Color;
   end;
end;

procedure TGraphColorDialog.buttonOtherResetClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   FOtherColor[n].Color := default_other_bg_color[n];
   FOtherColor[n].Font.Color := default_other_fg_color[n];
end;

function TGraphColorDialog.GetOtherBgColor(n: Integer): TColor;
begin
   Result := FOtherColor[n].Color;
end;

procedure TGraphColorDialog.SetOtherBgColor(n: Integer; c: TColor);
begin
   FOtherColor[n].Color := c;
end;

function TGraphColorDialog.GetOtherFgColor(n: Integer): TColor;
begin
   Result := FOtherColor[n].Font.Color;
end;

procedure TGraphColorDialog.SetOtherFgColor(n: Integer; c: TColor);
begin
   FOtherColor[n].Font.Color := c;
end;

end.
