unit UOptions3;

interface

uses
  System.SysUtils, Winapi.Windows, Winapi.Messages, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Forms,
  Vcl.ComCtrls, Vcl.Samples.Spin, Vcl.Buttons, System.UITypes,
  Vcl.Dialogs, Vcl.Menus, Vcl.FileCtrl,
  Generics.Collections, Generics.Defaults,
  UzLogConst, UzLogGlobal;

type
  TformOptions3 = class(TForm)
    PageControl: TPageControl;
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    ColorDialog1: TColorDialog;
    tabsheetRbnOptions: TTabSheet;
    groupQsoListColors: TGroupBox;
    Label61: TLabel;
    editListColor1: TEdit;
    buttonListBack1: TButton;
    buttonListReset1: TButton;
    Label68: TLabel;
    editListColor2: TEdit;
    buttonListBack2: TButton;
    buttonListReset2: TButton;
    groupGeneral: TGroupBox;
    checkUseSpcData: TCheckBox;
    buttonListFore1: TButton;
    checkListBold1: TCheckBox;
    buttonListFore2: TButton;
    checkListBold2: TCheckBox;
    Label1: TLabel;
    spNumOfRbnCount: TSpinEdit;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure buttonListForeClick(Sender: TObject);
    procedure buttonListBackClick(Sender: TObject);
    procedure checkListBoldClick(Sender: TObject);
    procedure buttonListResetClick(Sender: TObject);
  private
    FListColor: array[1..2] of TEdit;
    FListBold: array[1..2] of TCheckBox;
  public
    procedure RenewSettings;
  end;

const
  QsoListDefaultColor: array[1..2] of TColorSetting = (
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: False ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: False )
  );

implementation

uses
  Main;

{$R *.DFM}

procedure TformOptions3.FormCreate(Sender: TObject);
begin
   // QSO List
   FListColor[1] := editListColor1;
   FListColor[2] := editListColor2;
   FListBold[1] := checkListBold1;
   FListBold[2] := checkListBold2;

   PageControl.ActivePage := tabsheetRbnOptions;
end;

procedure TformOptions3.FormShow(Sender: TObject);
var
   i: integer;
begin
   with dmZlogGlobal do begin
      checkUseSpcData.Checked := Settings.FClusterUseForSuperCheck;
      spNumOfRbnCount.Value := Settings.FRbnCountForRbnVerified;

      for i := 1 to 2 do begin
         FListColor[i].Font.Color := Settings.FQsoListColors[i].FForeColor;
         FListColor[i].Color      := Settings.FQsoListColors[i].FBackColor;
         FListBold[i].Checked     := Settings.FQsoListColors[i].FBold;
      end;
   end;

   PageControl.ActivePageIndex := 0;
end;

procedure TformOptions3.FormDestroy(Sender: TObject);
begin
//
end;

procedure TformOptions3.buttonOKClick(Sender: TObject);
begin
   // 入力された設定を保存
   RenewSettings;

   ModalResult := mrOK;
end;

procedure TformOptions3.buttonCancelClick(Sender: TObject);
begin
//   Close;
end;

procedure TformOptions3.RenewSettings;
var
   i: integer;
begin
   with dmZLogGlobal do begin
      Settings.FClusterUseForSuperCheck := checkUseSpcData.Checked;
      Settings.FRbnCountForRbnVerified := spNumOfRbnCount.Value;

      for i := 1 to 2 do begin
         Settings.FQsoListColors[i].FForeColor := FListColor[i].Font.Color;
         Settings.FQsoListColors[i].FBackColor := FListColor[i].Color;
         Settings.FQsoListColors[i].FBold      := FListBold[i].Checked;
      end;

   end;
end;

procedure TformOptions3.buttonListForeClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FListColor[n].Font.Color;
   if ColorDialog1.Execute = True then begin
      FListColor[n].Font.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions3.buttonListBackClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FListColor[n].Color;
   if ColorDialog1.Execute = True then begin
      FListColor[n].Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions3.checkListBoldClick(Sender: TObject);
var
   n: Integer;
begin
   n := TCheckBox(Sender).Tag;

   if TCheckBox(Sender).Checked = True then begin
      FListColor[n].Font.Style := FListColor[n].Font.Style + [fsBold];
   end
   else begin
      FListColor[n].Font.Style := FListColor[n].Font.Style - [fsBold];
   end;
end;

procedure TformOptions3.buttonListResetClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   FListColor[n].Font.Color  := QsoListDefaultColor[n].FForeColor;
   FListColor[n].Color       := QsoListDefaultColor[n].FBackColor;
   FListBold[n].Checked      := QsoListDefaultColor[n].FBold;
end;

end.
