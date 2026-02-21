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
    groupGeneral: TGroupBox;
    checkUseSpcData: TCheckBox;
    Label1: TLabel;
    spNumOfRbnCount: TSpinEdit;
    Label2: TLabel;
    tabsheetWindowStyle: TTabSheet;
    ColorDialog2: TColorDialog;
    checkUseRbnAnalyze: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
  private
    FOriginalHeight: Integer;
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

   PageControl.ActivePage := tabsheetRbnOptions;
end;

procedure TformOptions3.FormShow(Sender: TObject);
begin
   with dmZlogGlobal do begin
      // RBN
      checkUseSpcData.Checked := Settings.FClusterUseForSuperCheck;
      spNumOfRbnCount.Value := Settings.FRbnCountForRbnVerified;
      checkUseRbnAnalyze.Checked := Settings.FUseRbnAnalyze;
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
begin
   with dmZLogGlobal do begin
      // RBN
      Settings.FClusterUseForSuperCheck := checkUseSpcData.Checked;
      Settings.FRbnCountForRbnVerified := spNumOfRbnCount.Value;
      Settings.FUseRbnAnalyze := checkUseRbnAnalyze.Checked;
   end;
end;

end.
