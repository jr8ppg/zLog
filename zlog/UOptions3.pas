unit UOptions3;

interface

uses
  System.SysUtils, Winapi.Windows, Winapi.Messages, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Forms,
  Vcl.ComCtrls, Vcl.Samples.Spin, Vcl.Buttons, System.UITypes,
  Vcl.Dialogs, Vcl.Menus, Vcl.FileCtrl, WinApi.CommCtrl,
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
    tabsheetWindowStyle: TTabSheet;
    groupUsabilityGeneral: TGroupBox;
    checkUseMultiLineTabs: TCheckBox;
    groupUsabilityAfterQsoEdit: TGroupBox;
    Panel2: TPanel;
    radioOnOkFocusToQsoList: TRadioButton;
    radioOnOkFocusToNewQso: TRadioButton;
    Panel3: TPanel;
    radioOnCancelFocusToQsoList: TRadioButton;
    radioOnCancelFocusToNewQso: TRadioButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    editListColor3: TEdit;
    buttonListBack3: TButton;
    buttonListReset3: TButton;
    Label6: TLabel;
    editListColor4: TEdit;
    buttonListBack4: TButton;
    buttonListReset4: TButton;
    tabsheetBandScope3: TTabSheet;
    groupBandscopeSpotReliability: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    editBSColorSrHigh: TEdit;
    editBSColorSrMiddle: TEdit;
    editBSColorSrLow: TEdit;
    buttonBSBackSrHigh: TButton;
    buttonBSBackSrMiddle: TButton;
    buttonBSBackSrLow: TButton;
    buttonBSResetSrHigh: TButton;
    buttonBSResetSrMiddle: TButton;
    buttonBSResetSrLow: TButton;
    ColorDialog2: TColorDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure buttonListForeClick(Sender: TObject);
    procedure buttonListBackClick(Sender: TObject);
    procedure checkListBoldClick(Sender: TObject);
    procedure buttonListResetClick(Sender: TObject);
    procedure buttonBSBackSqClick(Sender: TObject);
    procedure buttonBSResetClick(Sender: TObject);
  private
    FOriginalHeight: Integer;
    FListColor: array[1..4] of TEdit;
    FListBold: array[1..4] of TCheckBox;

    FBSColor: array[1..15] of TEdit;
    FBSBold: array[1..15] of TCheckBox;
  public
    procedure RenewSettings;
  end;

const
  QsoListDefaultColor: array[1..4] of TColorSetting = (
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: False ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: False ),
    ( FForeColor: clBlack; FBackColor: $FFF3E5; FBold: False ) ,
    ( FForeColor: clBlack; FBackColor: $E5E5E5; FBold: False )
  );

const
  BandScopeDefaultColor: array[1..15] of TColorSetting = (
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clRed;   FBackColor: clWhite; FBold: True ),
    ( FForeColor: clGreen; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clGreen; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clAqua;  FBold: True ),
    ( FForeColor: clBlack; FBackColor: clYellow; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clRed;   FBold: True )
  );

implementation

uses
  Main;

{$R *.DFM}

procedure TformOptions3.FormCreate(Sender: TObject);
var
   rc: TRect;
begin
   FOriginalHeight := ClientHeight;
   PageControl.MultiLine := dmZLogGlobal.Settings.FUseMultiLineTabs;
   SendMessage(PageControl.Handle, TCM_GETITEMRECT, 0, LPARAM(@rc));

   if (PageControl.MultiLine = True) then begin
      ClientHeight := FOriginalHeight + (rc.Bottom - rc.Top);
   end
   else begin
      ClientHeight := FOriginalHeight;
   end;

   // QSO List
   FListColor[1] := editListColor1;
   FListColor[2] := editListColor2;
   FListColor[3] := editListColor3;
   FListColor[4] := editListColor4;
   FListBold[1] := checkListBold1;
   FListBold[2] := checkListBold2;
   FListBold[3] := nil;
   FListBold[4] := nil;

   FBSColor[13] := editBSColorSrHigh;
   FBSColor[14] := editBSColorSrMiddle;
   FBSColor[15] := editBSColorSrLow;

   PageControl.ActivePage := tabsheetRbnOptions;
end;

procedure TformOptions3.FormShow(Sender: TObject);
var
   i: integer;
begin
   with dmZlogGlobal do begin
      // RBN
      checkUseSpcData.Checked := Settings.FClusterUseForSuperCheck;
      spNumOfRbnCount.Value := Settings.FRbnCountForRbnVerified;

      for i := 1 to 2 do begin
         FListColor[i].Font.Color := Settings.FQsoListColors[i].FForeColor;
         FListColor[i].Color      := Settings.FQsoListColors[i].FBackColor;
         FListBold[i].Checked     := Settings.FQsoListColors[i].FBold;
      end;

      // Usability
      checkUseMultiLineTabs.Checked := Settings.FUseMultiLineTabs;
      FListColor[3].Color := Settings.FQsoListFocusedSelColor;
      FListColor[4].Color := Settings.FQsoListUnfocusedSelColor;

      if Settings.FAfterQsoEditOkFocusPos = 0 then begin
         radioOnOkFocusToQsoList.Checked := True;
      end
      else begin
         radioOnOkFocusToNewQso.Checked := True;
      end;
      if Settings.FAfterQsoEditCancelFocusPos = 0 then begin
         radioOnCancelFocusToQsoList.Checked := True;
      end
      else begin
         radioOnCancelFocusToNewQso.Checked := True;
      end;

      // BandScope
      for i := 13 to 15 do begin
         FBSColor[i].Font.Color := Settings._bandscopecolor[i].FForeColor;
         FBSColor[i].Color      := Settings._bandscopecolor[i].FBackColor;
         if FBSBold[i] <> nil then begin
            FBSBold[i].Checked     := Settings._bandscopecolor[i].FBold;
         end;
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

procedure TformOptions3.buttonBSBackSqClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FBSColor[n].Color;
   if ColorDialog1.Execute = True then begin
      FBSColor[n].Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions3.buttonBSResetClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   FBSColor[n].Font.Color  := BandScopeDefaultColor[n].FForeColor;
   FBSColor[n].Color       := BandScopeDefaultColor[n].FBackColor;
   if FBSBold[n] <> nil then begin
      FBSBold[n].Checked      := BandScopeDefaultColor[n].FBold;
   end;
end;

procedure TformOptions3.RenewSettings;
var
   i: integer;
begin
   with dmZLogGlobal do begin
      // RBN
      Settings.FClusterUseForSuperCheck := checkUseSpcData.Checked;
      Settings.FRbnCountForRbnVerified := spNumOfRbnCount.Value;

      for i := 1 to 2 do begin
         Settings.FQsoListColors[i].FForeColor := FListColor[i].Font.Color;
         Settings.FQsoListColors[i].FBackColor := FListColor[i].Color;
         Settings.FQsoListColors[i].FBold      := FListBold[i].Checked;
      end;

      // Usability
      Settings.FUseMultiLineTabs := checkUseMultiLineTabs.Checked;
      Settings.FQsoListFocusedSelColor := FListColor[3].Color;
      Settings.FQsoListUnfocusedSelColor := FListColor[4].Color;

      if radioOnOkFocusToQsoList.Checked = True then begin
         Settings.FAfterQsoEditOkFocusPos := 0;
      end
      else begin
         Settings.FAfterQsoEditOkFocusPos := 1;
      end;
      if radioOnCancelFocusToQsoList.Checked = True then begin
         Settings.FAfterQsoEditCancelFocusPos := 0;
      end
      else begin
         Settings.FAfterQsoEditCancelFocusPos := 1;
      end;

      // BandScope
      for i := 13 to 15 do begin
         Settings._bandscopecolor[i].FForeColor := FBSColor[i].Font.Color;
         Settings._bandscopecolor[i].FBackColor := FBSColor[i].Color;
         if FBSBold[i] = nil then begin
            Settings._bandscopecolor[i].FBold      := False;
         end
         else begin
            Settings._bandscopecolor[i].FBold      := FBSBold[i].Checked;
         end;
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
   if Assigned(FListBold[n]) then begin
      FListBold[n].Checked      := QsoListDefaultColor[n].FBold;
   end;
end;

end.
