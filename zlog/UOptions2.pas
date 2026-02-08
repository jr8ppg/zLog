unit UOptions2;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls, Spin, Vcl.Buttons, System.UITypes,
  Dialogs, Menus, FileCtrl, JvExStdCtrls, JvCombobox, JvColorCombo,
  Generics.Collections, Generics.Defaults, WinApi.CommCtrl, System.Math,
  UIntegerDialog, UzLogConst, UzLogSound, UOperatorEdit, UzLogGlobal,
  UzLogOperatorInfo, UFreqPanel, UFreqMemDialog, UzFreqMemory, UPrePostPlaybackDlg,
  UzLogContest;

type
  TformOptions2 = class(TForm)
    PageControl: TPageControl;
    tabsheetPreferences: TTabSheet;
    tabsheetCategories: TTabSheet;
    tabsheetCW: TTabSheet;
    tabsheetVoice: TTabSheet;
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    groupCategory: TGroupBox;
    radioSingleOp: TRadioButton;
    groupMode: TRadioGroup;
    groupCwMessages: TGroupBox;
    editMessage2: TEdit;
    editMessage3: TEdit;
    editMessage4: TEdit;
    editMessage5: TEdit;
    editMessage6: TEdit;
    editMessage7: TEdit;
    editMessage8: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    editMessage1: TEdit;
    groupMyActiveBands: TGroupBox;
    act19: TCheckBox;
    act35: TCheckBox;
    act7: TCheckBox;
    act14: TCheckBox;
    act21: TCheckBox;
    act28: TCheckBox;
    act50: TCheckBox;
    act144: TCheckBox;
    act430: TCheckBox;
    act1200: TCheckBox;
    act2400: TCheckBox;
    act5600: TCheckBox;
    act101g: TCheckBox;
    GroupBox4: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    vEdit2: TEdit;
    vEdit3: TEdit;
    vEdit4: TEdit;
    vEdit5: TEdit;
    vEdit6: TEdit;
    vEdit7: TEdit;
    vEdit8: TEdit;
    vEdit1: TEdit;
    memo: TLabel;
    OpenDialog: TOpenDialog;
    vButton1: TButton;
    vButton2: TButton;
    vButton3: TButton;
    vButton4: TButton;
    vButton5: TButton;
    vButton6: TButton;
    vButton7: TButton;
    vButton8: TButton;
    act24: TCheckBox;
    act18: TCheckBox;
    act10: TCheckBox;
    tabsheetMisc: TTabSheet;
    rgSearchAfter: TRadioGroup;
    spMaxSuperHit: TSpinEdit;
    Label47: TLabel;
    spBSExpire: TSpinEdit;
    Label48: TLabel;
    Label49: TLabel;
    cbUpdateThread: TCheckBox;
    Label52: TLabel;
    Label53: TLabel;
    spSpotExpire: TSpinEdit;
    cbDisplayDatePartialCheck: TCheckBox;
    tabsheetQuickFunctions: TTabSheet;
    groupSuperCheck: TGroupBox;
    radioSuperCheck0: TRadioButton;
    radioSuperCheck1: TRadioButton;
    radioSuperCheck2: TRadioButton;
    comboPower19: TComboBox;
    comboPower35: TComboBox;
    comboPower7: TComboBox;
    comboPower10: TComboBox;
    comboPower14: TComboBox;
    comboPower18: TComboBox;
    comboPower21: TComboBox;
    comboPower24: TComboBox;
    comboPower28: TComboBox;
    comboPower50: TComboBox;
    comboPower144: TComboBox;
    comboPower430: TComboBox;
    comboPower1200: TComboBox;
    comboPower2400: TComboBox;
    comboPower5600: TComboBox;
    comboPower101g: TComboBox;
    groupNplus1: TGroupBox;
    checkHighlightFullmatch: TCheckBox;
    editFullmatchColor: TEdit;
    buttonFullmatchSelectColor: TButton;
    buttonFullmatchInitColor: TButton;
    tabsheetBandScope1: TTabSheet;
    groupBandscopeBands: TGroupBox;
    checkBs01: TCheckBox;
    checkBs02: TCheckBox;
    checkBs03: TCheckBox;
    checkBs05: TCheckBox;
    checkBs07: TCheckBox;
    checkBs09: TCheckBox;
    checkBs10: TCheckBox;
    checkBs11: TCheckBox;
    checkBs12: TCheckBox;
    checkBs13: TCheckBox;
    checkBs14: TCheckBox;
    checkBs15: TCheckBox;
    checkBs16: TCheckBox;
    checkBs08: TCheckBox;
    checkBs06: TCheckBox;
    checkBs04: TCheckBox;
    groupBandscopeInfoColors: TGroupBox;
    editBSColor1: TEdit;
    buttonBSFore1: TButton;
    buttonBSReset1: TButton;
    Label57: TLabel;
    buttonBSBack1: TButton;
    Label58: TLabel;
    Label59: TLabel;
    editBSColor2: TEdit;
    buttonBSFore2: TButton;
    buttonBSReset2: TButton;
    buttonBSBack2: TButton;
    editBSColor3: TEdit;
    buttonBSFore3: TButton;
    buttonBSReset3: TButton;
    buttonBSBack3: TButton;
    Label60: TLabel;
    editBSColor4: TEdit;
    buttonBSFore4: TButton;
    buttonBSReset4: TButton;
    buttonBSBack4: TButton;
    checkBSBold1: TCheckBox;
    checkBSBold2: TCheckBox;
    checkBSBold3: TCheckBox;
    checkBSBold4: TCheckBox;
    ColorDialog1: TColorDialog;
    tabsheetBandScope2: TTabSheet;
    groupBandscopeSpotSource: TGroupBox;
    Label61: TLabel;
    editBSColor5: TEdit;
    buttonBSBack5: TButton;
    buttonBSReset5: TButton;
    editBSColor7: TEdit;
    buttonBSBack7: TButton;
    buttonBSReset7: TButton;
    groupSpotFreshness: TGroupBox;
    radioFreshness1: TRadioButton;
    radioFreshness2: TRadioButton;
    radioFreshness3: TRadioButton;
    radioFreshness4: TRadioButton;
    editMessage9: TEdit;
    editMessage10: TEdit;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    vEdit9: TEdit;
    vEdit10: TEdit;
    vButton9: TButton;
    vButton10: TButton;
    checkBsCurrent: TCheckBox;
    Label75: TLabel;
    editMessage11: TEdit;
    Label76: TLabel;
    editMessage12: TEdit;
    Label77: TLabel;
    vEdit11: TEdit;
    vButton11: TButton;
    Label78: TLabel;
    vEdit12: TEdit;
    vButton12: TButton;
    editBSColor8: TEdit;
    buttonBSBack8: TButton;
    buttonBSBack9: TButton;
    editBSColor9: TEdit;
    Label69: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    groupCwAddMessages: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    editCQMessage2: TEdit;
    editCQMessage3: TEdit;
    GroupBox16: TGroupBox;
    buttonPlayVoice: TSpeedButton;
    buttonStopVoice: TSpeedButton;
    GroupBox19: TGroupBox;
    Label36: TLabel;
    Label37: TLabel;
    Label82: TLabel;
    vEdit14: TEdit;
    vEdit13: TEdit;
    vButton13: TButton;
    vButton14: TButton;
    groupBandscopeOptions1: TGroupBox;
    checkUseEstimatedMode: TCheckBox;
    checkShowOnlyInBandplan: TCheckBox;
    checkShowJAspots: TCheckBox;
    groupQsyAssist: TGroupBox;
    radioQsyNone: TRadioButton;
    radioQsyCountDown: TRadioButton;
    radioQsyCount: TRadioButton;
    Label86: TLabel;
    editQsyCountDownMinute: TSpinEdit;
    editQsyCountPerHour: TSpinEdit;
    Label87: TLabel;
    groupPartialCheck: TGroupBox;
    Label88: TLabel;
    editPartialCheckColor: TEdit;
    buttonPartialCheckForeColor: TButton;
    buttonPartialCheckInitColor: TButton;
    buttonPartialCheckBackColor: TButton;
    groupAccessibility: TGroupBox;
    Label89: TLabel;
    editFocusedColor: TEdit;
    buttonFocusedBackColor: TButton;
    buttonFocusedInitColor: TButton;
    checkFocusedBold: TCheckBox;
    buttonFocusedForeColor: TButton;
    Label91: TLabel;
    comboTxNo: TComboBox;
    groupOperators: TGroupBox;
    OpListBox: TListBox;
    buttonOpAdd: TButton;
    buttonOpDelete: TButton;
    radioMultiOpMultiTx: TRadioButton;
    radioMultiOpSingleTx: TRadioButton;
    radioMultiOpTwoTx: TRadioButton;
    groupMyQslDefault: TGroupBox;
    radioQslNone: TRadioButton;
    radioPseQsl: TRadioButton;
    radioNoQsl: TRadioButton;
    checkBsNewMulti: TCheckBox;
    checkUseLookupServer: TCheckBox;
    checkSetFreqAfterModeChange: TCheckBox;
    checkAlwaysChangeMode: TCheckBox;
    checkAcceptDuplicates: TCheckBox;
    checkBsAllBands: TCheckBox;
    groupPowerDefs: TGroupBox;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    editPowerH: TEdit;
    editPowerM: TEdit;
    editPowerL: TEdit;
    editPowerP: TEdit;
    checkSelectLastOperator: TCheckBox;
    checkApplyPowerCodeOnBandChange: TCheckBox;
    buttonOpEdit: TButton;
    groupQuickMemo: TGroupBox;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    editQuickMemo1: TEdit;
    editQuickMemo2: TEdit;
    editQuickMemo3: TEdit;
    editQuickMemo4: TEdit;
    editQuickMemo5: TEdit;
    groupQuickQSY: TGroupBox;
    checkSaveCurrentFreq: TCheckBox;
    buttonBSReset8: TButton;
    buttonBSReset9: TButton;
    checkShowDXspots: TCheckBox;
    checkUseNumberLookup: TCheckBox;
    comboVoiceDevice: TComboBox;
    Label38: TLabel;
    checkUseKhzQsyCommand: TCheckBox;
    editMyLatitude: TEdit;
    editMyLongitude: TEdit;
    Label39: TLabel;
    Label42: TLabel;
    listviewFreqMemory: TListView;
    buttonFreqMemAdd: TButton;
    buttonFreqMemEdit: TButton;
    buttonFreqMemDelete: TButton;
    popupVoiceMenu: TPopupMenu;
    menuVoicePlay: TMenuItem;
    N1: TMenuItem;
    menuVoiceClear: TMenuItem;
    menuVoiceStop: TMenuItem;
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
    checkUseReliability7: TCheckBox;
    checkUseReliability8: TCheckBox;
    checkUseReliability9: TCheckBox;
    checkTransparentSrHigh: TCheckBox;
    checkTransparentSrMiddle: TCheckBox;
    checkTransparentSrLow: TCheckBox;
    checkUseReliability5: TCheckBox;
    act104g: TCheckBox;
    comboPower104g: TComboBox;
    act24g: TCheckBox;
    comboPower24g: TComboBox;
    act47g: TCheckBox;
    comboPower47g: TComboBox;
    act77g: TCheckBox;
    comboPower77g: TComboBox;
    act135g: TCheckBox;
    comboPower135g: TComboBox;
    act248g: TCheckBox;
    comboPower248g: TComboBox;
    checkBs19: TCheckBox;
    checkBs20: TCheckBox;
    checkBs18: TCheckBox;
    checkBs17: TCheckBox;
    checkBs22: TCheckBox;
    checkBs21: TCheckBox;
    checkUseResume: TCheckBox;
    groupReliability: TGroupBox;
    radioReliabilityHigh: TRadioButton;
    radioReliabilityMiddle: TRadioButton;
    tabsheetMyStation: TTabSheet;
    groupMyStation: TGroupBox;
    editMyCallsign: TEdit;
    groupMyParameter: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    Label31: TLabel;
    CQZoneEdit: TEdit;
    IARUZoneEdit: TEdit;
    AgeEdit: TEdit;
    groupPreferences: TGroupBox;
    checkUseContestPeriod: TCheckBox;
    checkOutputOutofPeriod: TCheckBox;
    cbAutoEnterSuper: TCheckBox;
    checkDispLongDateTime: TCheckBox;
    cbSaveWhenNoCW: TCheckBox;
    Label40: TLabel;
    Label41: TLabel;
    SaveEvery: TSpinEdit;
    cbJMode: TCheckBox;
    groupExchange: TGroupBox;
    Label19: TLabel;
    SentEdit: TEdit;
    groupQsoListColors: TGroupBox;
    Label32: TLabel;
    Label33: TLabel;
    Label43: TLabel;
    editListColor1: TEdit;
    buttonListBack1: TButton;
    buttonListReset1: TButton;
    editListColor2: TEdit;
    buttonListBack2: TButton;
    buttonListReset2: TButton;
    buttonListFore1: TButton;
    checkListBold1: TCheckBox;
    buttonListFore2: TButton;
    checkListBold2: TCheckBox;
    editListColor3: TEdit;
    buttonListBack3: TButton;
    buttonListReset3: TButton;
    editListColor4: TEdit;
    buttonListBack4: TButton;
    buttonListReset4: TButton;
    checkUseMultiLineTabs: TCheckBox;
    groupUsabilityAfterQsoEdit: TGroupBox;
    Panel2: TPanel;
    Label44: TLabel;
    radioOnOkFocusToQsoList: TRadioButton;
    radioOnOkFocusToNewQso: TRadioButton;
    Panel3: TPanel;
    Label45: TLabel;
    radioOnCancelFocusToQsoList: TRadioButton;
    radioOnCancelFocusToNewQso: TRadioButton;
    buttonVoiceAfterCmd1: TSpeedButton;
    buttonVoiceAfterCmd2: TSpeedButton;
    buttonVoiceAfterCmd3: TSpeedButton;
    buttonVoiceAfterCmd4: TSpeedButton;
    buttonVoiceAfterCmd5: TSpeedButton;
    buttonVoiceAfterCmd6: TSpeedButton;
    buttonVoiceAfterCmd7: TSpeedButton;
    buttonVoiceAfterCmd8: TSpeedButton;
    buttonVoiceAfterCmd9: TSpeedButton;
    buttonVoiceAfterCmd10: TSpeedButton;
    buttonVoiceAfterCmd11: TSpeedButton;
    buttonVoiceAfterCmd12: TSpeedButton;
    buttonAddVoiceAfterCmd2: TSpeedButton;
    buttonAddVoiceAfterCmd3: TSpeedButton;
    checkUseDarkMode: TCheckBox;
    groupOtherRules: TGroupBox;
    Label46: TLabel;
    ScoreCoeffEdit: TEdit;
    panelContestName: TPanel;
    checkDisableShortCutsQSOEdit: TCheckBox;
    IotaEdit: TEdit;
    Label50: TLabel;
    radioWebUpload0: TRadioButton;
    radioWebUpload1: TRadioButton;
    radioWebUpload2: TRadioButton;
    HandleCwEdit: TEdit;
    Label54: TLabel;
    checkUseIncrementalDupeCheck: TCheckBox;
    Label55: TLabel;
    Label56: TLabel;
    editMyGridLoc: TEdit;
    buttonMyGridCalc: TButton;
    buttonMyPositionCalc: TButton;
    Label62: TLabel;
    HandlePhEdit: TEdit;
    comboListColorType2: TComboBox;
    Label74: TLabel;
    Label83: TLabel;
    editCity: TEdit;
    editProv: TEdit;
    rbBankA: TRadioButton;
    rbBankB: TRadioButton;
    rbRTTY: TRadioButton;
    groupKeyerSettings: TGroupBox;
    Label11: TLabel;
    SpeedLabel: TLabel;
    Label13: TLabel;
    WeightLabel: TLabel;
    Label16: TLabel;
    Label12: TLabel;
    Label85: TLabel;
    SpeedBar: TTrackBar;
    WeightBar: TTrackBar;
    ToneSpinEdit: TSpinEdit;
    FIFOCheck: TCheckBox;
    AbbrevEdit: TEdit;
    SideToneCheck: TCheckBox;
    VolumeSpinEdit: TSpinEdit;
    groupCwSettings: TGroupBox;
    Label15: TLabel;
    Label17: TLabel;
    CQmaxSpinEdit: TSpinEdit;
    CQRepEdit: TEdit;
    cbCQSP: TCheckBox;
    checkSendNrAuto: TCheckBox;
    checkUseCQRamdomRepeat: TCheckBox;
    checkNotSendLeadingZeros: TCheckBox;
    checkPaddleReverse: TCheckBox;
    checkExportMemoToAdif: TCheckBox;
    groupWebUpload: TGroupBox;
    Label51: TLabel;
    Label14: TLabel;
    spPartialCloseTime: TSpinEdit;
    Label18: TLabel;
    groupBasicSettings: TGroupBox;
    groupDetailSettings: TGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure buttonOpAddClick(Sender: TObject);
    procedure buttonOpDeleteClick(Sender: TObject);
    procedure SpeedBarChange(Sender: TObject);
    procedure WeightBarChange(Sender: TObject);
    procedure vButtonClick(Sender: TObject);
    procedure CQRepEditKeyPress(Sender: TObject; var Key: Char);
    procedure editMessage1Change(Sender: TObject);
    procedure CWBankClick(Sender: TObject);
    procedure OnNeedSuperCheckLoad(Sender: TObject);
    procedure buttonFullmatchSelectColorClick(Sender: TObject);
    procedure buttonFullmatchInitColorClick(Sender: TObject);
    procedure buttonBSForeClick(Sender: TObject);
    procedure buttonBSBackClick(Sender: TObject);
    procedure checkBSBoldClick(Sender: TObject);
    procedure buttonBSResetClick(Sender: TObject);
    procedure buttonPlayVoiceClick(Sender: TObject);
    procedure buttonStopVoiceClick(Sender: TObject);
    procedure vAdditionalButtonClick(Sender: TObject);
    procedure radioQsyAssistClick(Sender: TObject);
    procedure buttonPartialCheckForeColorClick(Sender: TObject);
    procedure buttonPartialCheckBackColorClick(Sender: TObject);
    procedure buttonPartialCheckInitColorClick(Sender: TObject);
    procedure buttonFocusedBackColorClick(Sender: TObject);
    procedure buttonFocusedInitColorClick(Sender: TObject);
    procedure checkFocusedBoldClick(Sender: TObject);
    procedure buttonFocusedForeColorClick(Sender: TObject);
    procedure radioCategoryClick(Sender: TObject);
    procedure checkUseEstimatedModeClick(Sender: TObject);
    procedure buttonSpotterListClick(Sender: TObject);
    procedure buttonOpEditClick(Sender: TObject);
    procedure checkUseNumberLookupClick(Sender: TObject);
    procedure buttonFreqMemAddClick(Sender: TObject);
    procedure buttonFreqMemEditClick(Sender: TObject);
    procedure buttonFreqMemDeleteClick(Sender: TObject);
    procedure listviewFreqMemoryDblClick(Sender: TObject);
    procedure listviewFreqMemorySelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure vEditEnter(Sender: TObject);
    procedure vEditExit(Sender: TObject);
    procedure menuVoiceClearClick(Sender: TObject);
    procedure menuVoicePlayClick(Sender: TObject);
    procedure menuVoiceStopClick(Sender: TObject);
    procedure vAdditionalEditEnter(Sender: TObject);
    procedure vAdditionalEditExit(Sender: TObject);
    procedure vButtonEnter(Sender: TObject);
    procedure vButtonExit(Sender: TObject);
    procedure vAdditionalButtonEnter(Sender: TObject);
    procedure vAdditionalButtonExit(Sender: TObject);
    procedure vButtonContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure vAdditionalButtonContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure buttonVoiceAfterCmdClick(Sender: TObject);
    procedure buttonAddVoiceAfterCmdClick(Sender: TObject);
    procedure buttonListBackClick(Sender: TObject);
    procedure buttonListForeClick(Sender: TObject);
    procedure checkListBoldClick(Sender: TObject);
    procedure buttonListResetClick(Sender: TObject);
    procedure buttonMyGridCalcClick(Sender: TObject);
    procedure buttonMyPositionCalcClick(Sender: TObject);
  private
    FOriginalHeight: Integer;
    FEditMode: Integer;
    FEditNumber: Integer;
    FActiveTab: Integer;

    FActiveBands: array[b19..HiBand] of TCheckBox;
    FPowerPerBand: array[b19..HiBand] of TComboBox;

    FQSOListColor: array[1..4] of TEdit;
    FQSOListBold: array[1..4] of TCheckBox;

    FTempVoiceConfig: array[1..maxmessage] of TVoiceConfig;
    FTempAdditionalVoiceConfig: array[2..3] of TVoiceConfig;

    FPrePostProcessButton: array[1..maxmessage] of TSpeedButton;
    FAdditionalPrePostProcessButton: array[2..3] of TSpeedButton;

    TempCurrentBank : integer;
    TempCWStrBank : array[1..maxbank,1..maxmessage] of string; // used temporarily while options window is open

    FTempFreqMemList: TFreqMemoryList;

    FBSColor: array[1..15] of TEdit;
    FBSBold: array[1..15] of TCheckBox;
    FBSUseReliability: array[1..15] of TCheckBox;
    FBSTransparent: array[1..15] of TCheckBox;

    FNeedSuperCheckLoad: Boolean;

    FQuickMemoText: array[1..5] of TEdit;

    FEditMessage: array[1..maxmessage] of TEdit;
    FEditAdditionalCQMessage: array[2..3] of TEdit;

    FVoiceEdit: array[1..maxmessage] of TEdit;
    FVoiceButton: array[1..maxmessage] of TButton;
    FAdditionalVoiceEdit: array[2..3] of TEdit;
    FAdditionalVoiceButton: array[2..3] of TButton;

    FVoiceSound: TWaveSound;

    procedure RenewCWStrBankDisp();
    procedure SetEditNumber(no: Integer);
    procedure InitVoice();
    procedure AddFreqMemList(D: TFreqMemory);
    procedure UpdateFreqMemList(listitem: TListItem);
    procedure SetPrePostProcessButtonAttr(i: Integer);
    procedure SetAdditionalPrePostProcessButtonAttr(i: Integer);
    procedure RenewSettings();
    procedure ImplementSettings();
  public
    property EditMode: Integer read FEditMode write FEditMode;
    property EditNumber: Integer read FEditNumber write SetEditNumber;
    property NeedSuperCheckLoad: Boolean read FNeedSuperCheckLoad;
    property EditBank: Integer read TempCurrentBank write TempCurrentBank;
    property ActiveTab: Integer read FActiveTab write FActiveTab;
  end;

implementation

uses
  Main, UzLogCW, UComm, UClusterTelnetSet, UClusterCOMSet, UPortConfigDialog,
  UZlinkTelnetSet, UZLinkForm, URigControl, UPluginManager, USpotterListDlg,
  UDmsToGridDialog, UGridLocator;

const
  QsoListDefaultColor: array[1..4] of TColorSetting = (
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: False ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: False ),
    ( FForeColor: clBlack; FBackColor: $FFF3E5; FBold: False ) ,
    ( FForeColor: clBlack; FBackColor: $E5E5E5; FBold: False )
  );

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
    ( FForeColor: clBlack; FBackColor: $FFFFC0;  FBold: True ),
    ( FForeColor: clBlack; FBackColor: $C0FFFF; FBold: True ),
    ( FForeColor: clBlack; FBackColor: $FFD2FF;  FBold: True )
  );

{$R *.DFM}

procedure TformOptions2.FormCreate(Sender: TObject);
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

   FActiveBands[b19]   := act19;
   FActiveBands[b35]   := act35;
   FActiveBands[b7]    := act7;
   FActiveBands[b10]   := act10;
   FActiveBands[b14]   := act14;
   FActiveBands[b18]   := act18;
   FActiveBands[b21]   := act21;
   FActiveBands[b24]   := act24;
   FActiveBands[b28]   := act28;
   FActiveBands[b50]   := act50;
   FActiveBands[b144]  := act144;
   FActiveBands[b430]  := act430;
   FActiveBands[b1200] := act1200;
   FActiveBands[b2400] := act2400;
   FActiveBands[b5600] := act5600;
   FActiveBands[b10g]  := act101g;
   FActiveBands[b104g] := act104g;
   FActiveBands[b24g]  := act24g;
   FActiveBands[b47g]  := act47g;
   FActiveBands[b77g]  := act77g;
   FActiveBands[b135g] := act135g;
   FActiveBands[b248g] := act248g;

   FPowerPerBand[b19]   := comboPower19;
   FPowerPerBand[b35]   := comboPower35;
   FPowerPerBand[b7]    := comboPower7;
   FPowerPerBand[b10]   := comboPower10;
   FPowerPerBand[b14]   := comboPower14;
   FPowerPerBand[b18]   := comboPower18;
   FPowerPerBand[b21]   := comboPower21;
   FPowerPerBand[b24]   := comboPower24;
   FPowerPerBand[b28]   := comboPower28;
   FPowerPerBand[b50]   := comboPower50;
   FPowerPerBand[b144]  := comboPower144;
   FPowerPerBand[b430]  := comboPower430;
   FPowerPerBand[b1200] := comboPower1200;
   FPowerPerBand[b2400] := comboPower2400;
   FPowerPerBand[b5600] := comboPower5600;
   FPowerPerBand[b10g]  := comboPower101g;
   FPowerPerBand[b104g] := comboPower104g;
   FPowerPerBand[b24g]  := comboPower24g;
   FPowerPerBand[b47g]  := comboPower47g;
   FPowerPerBand[b77g]  := comboPower77g;
   FPowerPerBand[b135g] := comboPower135g;
   FPowerPerBand[b248g] := comboPower248g;

   // QSO List
   FQSOListColor[1] := editListColor1;
   FQSOListColor[2] := editListColor2;
   FQSOListColor[3] := editListColor3;
   FQSOListColor[4] := editListColor4;
   FQSOListBold[1] := checkListBold1;
   FQSOListBold[2] := checkListBold2;
   FQSOListBold[3] := nil;
   FQSOListBold[4] := nil;

   // BandScope
   FBSColor[1] := editBSColor1;
   FBSColor[2] := editBSColor2;
   FBSColor[3] := editBSColor3;
   FBSColor[4] := editBSColor4;
   FBSColor[5] := editBSColor5;
   FBSColor[6] := nil;
   FBSColor[7] := editBSColor7;
   FBSColor[8] := editBSColor8;
   FBSColor[9] := editBSColor9;
   FBSColor[10] := editBSColorSrHigh;
   FBSColor[11] := nil;
   FBSColor[12] := nil;
   FBSColor[13] := editBSColorSrHigh;
   FBSColor[14] := editBSColorSrMiddle;
   FBSColor[15] := editBSColorSrLow;
   FBSBold[1] := checkBSBold1;
   FBSBold[2] := checkBSBold2;
   FBSBold[3] := checkBSBold3;
   FBSBold[4] := checkBSBold4;
   FBSBold[5] := nil;
   FBSBold[6] := nil;
   FBSBold[7] := nil;
   FBSBold[8] := nil;
   FBSBold[9] := nil;
   FBSBold[10] := nil;
   FBSBold[11] := nil;
   FBSBold[12] := nil;
   FBSBold[13] := nil;
   FBSBold[14] := nil;
   FBSBold[15] := nil;
   FBSUseReliability[1] := nil;
   FBSUseReliability[2] := nil;
   FBSUseReliability[3] := nil;
   FBSUseReliability[4] := nil;
   FBSUseReliability[5] := checkUseReliability5;
   FBSUseReliability[6] := nil;
   FBSUseReliability[7] := checkUseReliability7;
   FBSUseReliability[8] := checkUseReliability8;
   FBSUseReliability[9] := checkUseReliability9;
   FBSUseReliability[10] := nil;
   FBSUseReliability[11] := nil;
   FBSUseReliability[12] := nil;
   FBSUseReliability[13] := nil;
   FBSUseReliability[14] := nil;
   FBSUseReliability[15] := nil;
   FBSTransparent[1] := nil;
   FBSTransparent[2] := nil;
   FBSTransparent[3] := nil;
   FBSTransparent[4] := nil;
   FBSTransparent[5] := nil;
   FBSTransparent[6] := nil;
   FBSTransparent[7] := nil;
   FBSTransparent[8] := nil;
   FBSTransparent[9] := nil;
   FBSTransparent[10] := nil;
   FBSTransparent[11] := nil;
   FBSTransparent[12] := nil;
   FBSTransparent[13] := checkTransparentSrHigh;
   FBSTransparent[14] := checkTransparentSrMiddle;
   FBSTransparent[15] := checkTransparentSrLow;

   // Quick QSY
   FTempFreqMemList := TFreqMemoryList.Create();

   // Quick Memo
   FQuickMemoText[1] := editQuickMemo1;
   FQuickMemoText[2] := editQuickMemo2;
   FQuickMemoText[3] := editQuickMemo3;
   FQuickMemoText[4] := editQuickMemo4;
   FQuickMemoText[5] := editQuickMemo5;

   // CW/RTTY
   FEditMessage[1] := editMessage1;
   FEditMessage[2] := editMessage2;
   FEditMessage[3] := editMessage3;
   FEditMessage[4] := editMessage4;
   FEditMessage[5] := editMessage5;
   FEditMessage[6] := editMessage6;
   FEditMessage[7] := editMessage7;
   FEditMessage[8] := editMessage8;
   FEditMessage[9] := editMessage9;
   FEditMessage[10] := editMessage10;
   FEditMessage[11] := editMessage11;
   FEditMessage[12] := editMessage12;

   FEditAdditionalCQMessage[2] := editCQMessage2;
   FEditAdditionalCQMessage[3] := editCQMessage3;

   FPrePostProcessButton[1] := buttonVoiceAfterCmd1;
   FPrePostProcessButton[2] := buttonVoiceAfterCmd2;
   FPrePostProcessButton[3] := buttonVoiceAfterCmd3;
   FPrePostProcessButton[4] := buttonVoiceAfterCmd4;
   FPrePostProcessButton[5] := buttonVoiceAfterCmd5;
   FPrePostProcessButton[6] := buttonVoiceAfterCmd6;
   FPrePostProcessButton[7] := buttonVoiceAfterCmd7;
   FPrePostProcessButton[8] := buttonVoiceAfterCmd8;
   FPrePostProcessButton[9] := buttonVoiceAfterCmd9;
   FPrePostProcessButton[10] := buttonVoiceAfterCmd10;
   FPrePostProcessButton[11] := buttonVoiceAfterCmd11;
   FPrePostProcessButton[12] := buttonVoiceAfterCmd12;
   FAdditionalPrePostProcessButton[2] := buttonAddVoiceAfterCmd2;
   FAdditionalPrePostProcessButton[3] := buttonAddVoiceAfterCmd3;

   // Voice Memory
   InitVoice();

   TempCurrentBank := 1;

   PageControl.ActivePage := tabsheetPreferences;

   FEditMode := 0;
   FEditNumber := 0;

   FNeedSuperCheckLoad := False;
end;

procedure TformOptions2.FormShow(Sender: TObject);
var
   i: Integer;
begin
   ImplementSettings();

   if CheckWin32Version(10, 0) = False then begin
      checkUseDarkMode.Visible := False;
   end;

   // 未入力箇所に色を付ける
   editMyCallsign.Color := ifthen(editMyCallsign.Text = '', $00EADEFF, clWindow);
   CQZoneEdit.Color := ifthen(CQZoneEdit.Text = '', $00EADEFF, clWindow);
   IARUZoneEdit.Color := ifthen(IARUZoneEdit.Text = '', $00EADEFF, clWindow);
   AgeEdit.Color := ifthen(AgeEdit.Text = '', $00EADEFF, clWindow);
   IotaEdit.Color := ifthen(IotaEdit.Text = '', $00EADEFF, clWindow);
   HandleCwEdit.Color := ifthen(HandleCwEdit.Text = '', $00EADEFF, clWindow);
   HandlePhEdit.Color := ifthen(HandlePhEdit.Text = '', $00EADEFF, clWindow);

   // CW/RTTY
   editProv.Color := ifthen(editProv.Text = '', $00EADEFF, clWindow);
   editCity.Color := ifthen(editCity.Text = '', $00EADEFF, clWindow);

   //
   // 画面に反映
   //
   if comboVoiceDevice.Items.Count > 0 then begin
      comboVoiceDevice.ItemIndex := 0;
   end;

   if FEditMode = 0 then begin   // 通常モード
      PageControl.ActivePage := tabsheetMyStation;

      tabsheetMyStation.TabVisible := True;
      tabsheetPreferences.TabVisible := True;
      tabsheetCategories.TabVisible := True;
      tabsheetCW.TabVisible := True;
      tabsheetVoice.TabVisible := True;
      tabsheetMisc.TabVisible := True;
      tabsheetQuickFunctions.TabVisible := True;
      tabsheetBandScope1.TabVisible := True;
      tabsheetBandScope2.TabVisible := True;
   end
   else if FEditMode = 1 then begin // CW
      PageControl.ActivePage := tabsheetCategories;

      tabsheetMyStation.TabVisible := False;
      tabsheetPreferences.TabVisible := False;
      tabsheetCategories.TabVisible := True;
      tabsheetCW.TabVisible := False;
      tabsheetVoice.TabVisible := False;
      tabsheetMisc.TabVisible := False;
      tabsheetQuickFunctions.TabVisible := False;
      tabsheetBandScope1.TabVisible := False;
      tabsheetBandScope2.TabVisible := False;

      if FEditNumber > 0 then begin
         FEditMessage[FEditNumber].SetFocus;
      end;
   end
   else if FEditMode = 2 then begin // Voice
      PageControl.ActivePage := tabsheetVoice;

      tabsheetMyStation.TabVisible := False;
      tabsheetPreferences.TabVisible := False;
      tabsheetCategories.TabVisible := False;
      tabsheetCW.TabVisible := False;
      tabsheetVoice.TabVisible := True;
      tabsheetMisc.TabVisible := False;
      tabsheetQuickFunctions.TabVisible := False;
      tabsheetBandScope1.TabVisible := False;
      tabsheetBandScope2.TabVisible := False;

      if FEditNumber > 0 then begin
         FVoiceButton[FEditNumber].SetFocus();
      end;
   end
   else if FEditMode = 3 then begin
      PageControl.ActivePageIndex := FActiveTab;
   end;

   FNeedSuperCheckLoad := False;

   if radioSingleOp.Checked = True then begin
      radioCategoryClick(radioSingleOp);
   end
   else if radioMultiOpMultiTx.Checked = True then begin
      radioCategoryClick(radioMultiOpMultiTx);
   end
   else if radioMultiOpSingleTx.Checked = True then begin
      radioCategoryClick(radioMultiOpSingleTx);
   end
   else if radioMultiOpTwoTx.Checked = True then begin
      radioCategoryClick(radioMultiOpTwoTx);
   end;

   RenewCWStrBankDisp;

   for i := 0 to FTempFreqMemList.Count - 1 do begin
      AddFreqMemList(FTempFreqMemList[i]);
   end;

   // Quick QSY
   listviewFreqMemory.Selected := nil;
   buttonFreqMemAdd.Enabled := True;
   buttonFreqMemEdit.Enabled := False;
   buttonFreqMemDelete.Enabled := False;

   // DXpediのときはSent欄入力可
   if MyContest is TPedi then begin
      SentEdit.ReadOnly := False;
      SentEdit.Color := clWindow;
   end;
end;

procedure TformOptions2.FormDestroy(Sender: TObject);
begin
   FTempFreqMemList.Free();
   FVoiceSound.Free();
end;

procedure TformOptions2.buttonOKClick(Sender: TObject);
begin
   // 入力された設定を保存
   RenewSettings;

   // 各種フォルダ作成
   dmZLogGlobal.CreateFolders();

   ModalResult := mrOK;
end;

procedure TformOptions2.buttonCancelClick(Sender: TObject);
begin
//   Close;
end;

procedure TformOptions2.radioCategoryClick(Sender: TObject);
var
   n: Integer;

   procedure OperatorsEnable(f: Boolean);
   begin
      OpListBox.Enabled := f;
      buttonOpAdd.Enabled := f;
      buttonOpEdit.Enabled := f;
      buttonOpDelete.Enabled := f;
      checkSelectLastOperator.Enabled := f;
      checkApplyPowerCodeOnBandChange.Enabled := f;
   end;

   function SelectTxNo(): Integer;
   begin
      Result := comboTxNo.Items.IndexOf(IntToStr(dmZLogGlobal.Settings._txnr));
      if Result = -1 then begin
         Result := 0;
      end;
   end;
begin
   n := TRadioButton(Sender).Tag;
   case n of
      // Single-Op
      0: begin
         comboTxNo.Enabled := False;
         comboTxNo.Items.CommaText := '0,1';
         comboTxNo.ItemIndex := SelectTxNo();
      end;

      // Multi-Op/Multi-Tx
      1: begin
         comboTxNo.Enabled := True;
         comboTxNo.Items.CommaText := TXLIST_MM;
         comboTxNo.ItemIndex := SelectTxNo();
      end;

      // Multi-Op/Single-Tx, Multi-Op/Two-Tx
      2, 3: begin
         comboTxNo.Enabled := True;
         comboTxNo.Items.CommaText := TXLIST_MS;
         comboTxNo.ItemIndex := SelectTxNo();
      end;
   end;
end;

procedure TformOptions2.RenewSettings;
var
   r: double;
   i, j: integer;
   b: TBand;
begin
   with dmZLogGlobal do begin

      //
      // My station
      //

      // Callsign
      Settings._mycall := editMyCallsign.Text;

      // My position
      Settings._mygridloc := editMyGridLoc.Text;
      Settings._mylatitude := editMyLatitude.Text;
      Settings._mylongitude := editMyLongitude.Text;

      // Parameters
      Settings._mycqzone := CQZoneEdit.Text;
      Settings._myiaruzone := IARUZoneEdit.Text;
      Settings._myage := AgeEdit.Text;
      Settings._myiota := IotaEdit.Text;
      Settings._myhandle_cw := HandleCwEdit.Text;
      Settings._myhandle_ph := HandlePhEdit.Text;

      // Active bands
      for b := b19 to HiBand do begin
         Settings._activebands[b] := FActiveBands[b].Checked;
         Settings._power[b] := FPowerPerBand[b].Text;
      end;

      // QSL Default
      if radioQslNone.Checked = True then begin
         Settings._qsl_default   := qsNone;
      end
      else if radioPseQsl.Checked = True then begin
         Settings._qsl_default   := qsPseQsl;
      end
      else begin
         Settings._qsl_default   := qsNoQsl;
      end;

      //
      // Preferences
      //

      // General group

      // Use contest period
      Settings._use_contest_period := checkUseContestPeriod.Checked;

      // Output logs out of period
      Settings._output_outofperiod := checkOutputOutofPeriod.Checked;

      // Automatically enter exchange from SuperCheck
      Settings._entersuperexchange := cbAutoEnterSuper.Checked;

      // Display long date time
      Settings._displongdatetime := checkDispLongDateTime.Checked;

      // Save when not sending CW
      Settings._savewhennocw := cbSaveWhenNoCW.Checked;

      // J-Mode
      Settings._jmode := cbJMode.Checked;

      // Save every nn QSOs
      Settings._saveevery := SaveEvery.Value;

      // Use Multiline Tabs
      Settings.FUseMultiLineTabs := checkUseMultiLineTabs.Checked;

      // Use dark mode
      Settings.FUseDarkMode := checkUseDarkMode.Checked;

      // Disable shortcuts during QSO editing
      Settings.FDisableShortCutsQSOEdit := checkDisableShortCutsQSOEdit.Checked;

      // Export Memo field to ADIF
      Settings.FExportMemoToAdif := checkExportMemoToAdif.Checked;

      // Browser component used for WebUpload
      if radioWebUpload0.Checked = True then begin
         Settings.FBrowserForWebUpload := 0;
      end
      else if radioWebUpload1.Checked = True then begin
         Settings.FBrowserForWebUpload := 1;
      end
      else if radioWebUpload2.Checked = True then begin
         Settings.FBrowserForWebUpload := 2;
      end;

      // Focus Position After QSO Edit group
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

      // Power($N) group
      Settings._PowerH := editPowerH.Text;
      Settings._PowerM := editPowerM.Text;
      Settings._PowerL := editPowerL.Text;
      Settings._PowerP := editPowerP.Text;

      // Accessibility group

      // Focused color
      Settings.FAccessibility.FFocusedForeColor := editFocusedColor.Font.Color;
      Settings.FAccessibility.FFocusedBackColor := editFocusedColor.Color;
      Settings.FAccessibility.FFocusedBold := checkFocusedBold.Checked;

      // QSO List
      for i := 1 to 2 do begin
         Settings.FQsoListColors[i].FForeColor := FQSOListColor[i].Font.Color;
         Settings.FQsoListColors[i].FBackColor := FQSOListColor[i].Color;
         Settings.FQsoListColors[i].FBold      := FQSOListBold[i].Checked;
      end;

      Settings.FQsoListColorType2 := comboListColorType2.ItemIndex;

      //
      // Contest rules
      //

      // Exchange
      // Sent欄は表示専用
      if MyContest is TPedi then begin
         MyContest.SentStr := SentEdit.Text;
      end;

      // Prov/City
      Settings.CW._prov := editProv.Text;
      Settings.CW._city := editCity.Text;

      // Category
      if radioSingleOp.Checked = True then begin
         Settings._multiop := ccSingleOp;
      end
      else if radioMultiOpMultiTx.Checked = True then begin
         Settings._multiop := ccMultiOpMultiTx;
      end
      else if radioMultiOpSingleTx.Checked = True then begin
         Settings._multiop := ccMultiOpSingleTx;
      end
      else if radioMultiOpTwoTx.Checked = True then begin
         Settings._multiop := ccMultiOpTwoTx;
      end;

      // #TXNR
      Settings._txnr := StrToIntDef(comboTxNo.Text, 0);

      // Mode
      Settings._mode := TContestMode(groupMode.ItemIndex);

      // Score coeff
      Log.ScoreCoeff := StrToFloatDef(ScoreCoeffEdit.Text, 1);

      // QSY Assist
      Settings._countdown        := radioQsyCountDown.Checked;
      Settings._qsycount         := radioQsyCount.Checked;
      Settings._countdownminute  := editQsyCountDownMinute.Value;
      Settings._countperhour     := editQsyCountPerHour.Value;

      // Operators

      // OpList
      dmZLogGlobal.OpList.Clear();
      for i := 0 to OpListBox.Items.Count - 1 do begin
         var op := TOperatorInfo.Create();
         op.Assign(TOperatorInfo(OpListBox.Items.Objects[i]));
         dmZLogGlobal.OpList.Add(op);
      end;

      // Select last operator on startup
      Settings._selectlastoperator := checkSelectLastOperator.Checked;

      // Apply power code on band change
      Settings._applypoweronbandchg :=  checkApplyPowerCodeOnBandChange.Checked;

      //
      // CW/RTTY
      //

      // Messages
      for i := 1 to maxbank do begin
         for j := 1 to maxmessage do begin
            MyContest.CwMessages[i, j] := TempCWStrBank[i, j];
         end;
      end;

      // TempCurrentBankはCWBankClickでセットされている

      // Additional messages
      MyContest.CwMessageCQ[2] := editCQMessage2.Text;
      MyContest.CwMessageCQ[3] := editCQMessage3.Text;

      // Speed
      Settings.CW._speed := SpeedBar.Position;

      // Weight
      Settings.CW._weight := WeightBar.Position;

      // Que messages
      Settings.CW._FIFO := FIFOCheck.Checked;

      // Sidetone
      Settings.CW._sidetone := SideToneCheck.Checked;
      Settings.CW._sidetone_volume := VolumeSpinEdit.Value;
      Settings.CW._tonepitch := ToneSpinEdit.Value;

      // Abbreviation (019)
      if length(AbbrevEdit.Text) >= 3 then begin
         Settings.CW._zero := AbbrevEdit.Text[1];
         Settings.CW._one := AbbrevEdit.Text[2];
         Settings.CW._nine := AbbrevEdit.Text[3];
      end;

      // CQ rpt. interval (sec)
      r := Settings.CW._cqrepeat;
      Settings.CW._cqrepeat := StrToFloatDef(CQRepEdit.Text, r);

      // CQ max
      Settings.CW._cqmax := CQmaxSpinEdit.Value;

      // Use CQ Random Repeat
      Settings.CW._cq_random_repeat := checkUseCQRamdomRepeat.Checked;

      // Switch CW bank with CQ/SP mode
      Settings._switchcqsp := cbCQSP.Checked;

      // Send NR? automatically
      Settings.CW._send_nr_auto := checkSendNrAuto.Checked;

      // Not send leading zeros in serial number
      Settings.CW._not_send_leading_zeros := checkNotSendLeadingZeros.Checked;

      // Paddle reverse
      Settings.CW._paddlereverse := checkPaddleReverse.Checked;

      //
      // Voice
      //

      // Voice Memory
      for i := 1 to maxmessage do begin
         Settings.FVoiceConfig[i].FSoundFile := FTempVoiceConfig[i].FSoundFile;
         Settings.FVoiceConfig[i].FSoundComment := FVoiceEdit[i].Text;
         Settings.FVoiceConfig[i].FPreProcess.FCommand := FTempVoiceConfig[i].FPreProcess.FCommand;
         Settings.FVoiceConfig[i].FPostProcess.FCommand := FTempVoiceConfig[i].FPostProcess.FCommand;
      end;
      for i := 2 to 3 do begin
         Settings.FAdditionalVoiceConfig[i].FSoundFile := FTempAdditionalVoiceConfig[i].FSoundFile;
         Settings.FAdditionalVoiceConfig[i].FSoundComment := FAdditionalVoiceEdit[i].Text;
         Settings.FAdditionalVoiceConfig[i].FPreProcess.FCommand := FTempAdditionalVoiceConfig[i].FPreProcess.FCommand;
         Settings.FAdditionalVoiceConfig[i].FPostProcess.FCommand := FTempAdditionalVoiceConfig[i].FPostProcess.FCommand;
      end;

      //
      // Misc
      //

      // Start search after
      Settings._searchafter := rgSearchAfter.ItemIndex;

      // Max super check search
      Settings._maxsuperhit := spMaxSuperHit.Value;

      // Delete band scope data after
      Settings._bsexpire := spBSExpire.Value;

      // Delete spot data after
      Settings._spotexpire := spSpotExpire.Value;

      // Display date in partial check
      Settings._displaydatepartialcheck := cbDisplayDatePartialCheck.Checked;

      // Update using a thread
      Settings._renewbythread := cbUpdateThread.Checked;

      // Use incremental dupe check
      Settings.FUseIncrementalDupeCheck := checkUseIncrementalDupeCheck.Checked;

      // Delay before closing the Partial window
      Settings.FPartialCloseTime := spPartialCloseTime.Value;

      // Super Check group

      // SuperCheck
      if radioSuperCheck0.Checked = True then begin
         Settings.FSuperCheck.FSuperCheckMethod := 0;
      end
      else if radioSuperCheck1.Checked = True then begin
         Settings.FSuperCheck.FSuperCheckMethod := 1;
      end
      else begin
         Settings.FSuperCheck.FSuperCheckMethod := 2;
      end;
      Settings.FSuperCheck.FAcceptDuplicates := checkAcceptDuplicates.Checked;

      // N+1 group

      // Highlight FullMatch
      Settings.FSuperCheck.FFullMatchHighlight := checkHighlightFullmatch.Checked;
      Settings.FSuperCheck.FFullMatchColor := editFullmatchColor.Color;

      // Partial Check group
      Settings.FPartialCheck.FCurrentBandForeColor := editPartialCheckColor.Font.Color;
      Settings.FPartialCheck.FCurrentBandBackColor := editPartialCheckColor.Color;

      //
      // Quick functions
      //

      // Quick QSY
      FreqMemList.Assign(FTempFreqMemList);
      Settings.FUseKhzQsyCommand := checkUseKhzQsyCommand.Checked;

      // Quick Memo
      for i := 1 to 5 do begin
         Settings.FQuickMemoText[i] := Trim(FQuickMemoText[i].Text);
      end;

      //
      // Band scope
      //

      // Bands group
      Settings._usebandscope[b19]   := checkBS01.Checked;
      Settings._usebandscope[b35]   := checkBS02.Checked;
      Settings._usebandscope[b7]    := checkBS03.Checked;
      Settings._usebandscope[b10]   := checkBS04.Checked;
      Settings._usebandscope[b14]   := checkBS05.Checked;
      Settings._usebandscope[b18]   := checkBS06.Checked;
      Settings._usebandscope[b21]   := checkBS07.Checked;
      Settings._usebandscope[b24]   := checkBS08.Checked;
      Settings._usebandscope[b28]   := checkBS09.Checked;
      Settings._usebandscope[b50]   := checkBS10.Checked;
      Settings._usebandscope[b144]  := checkBS11.Checked;
      Settings._usebandscope[b430]  := checkBS12.Checked;
      Settings._usebandscope[b1200] := checkBS13.Checked;
      Settings._usebandscope[b2400] := checkBS14.Checked;
      Settings._usebandscope[b5600] := checkBS15.Checked;
      Settings._usebandscope[b10g]  := checkBS16.Checked;
      Settings._usebandscope[b104g]  := checkBS17.Checked;
      Settings._usebandscope[b24g]  := checkBS18.Checked;
      Settings._usebandscope[b47g]  := checkBS19.Checked;
      Settings._usebandscope[b77g]  := checkBS20.Checked;
      Settings._usebandscope[b135g]  := checkBS21.Checked;
      Settings._usebandscope[b248g]  := checkBS22.Checked;
      Settings._usebandscope_current := checkBsCurrent.Checked;
      Settings._usebandscope_newmulti := checkBsNewMulti.Checked;
      Settings._usebandscope_allbands := checkBsAllBands.Checked;

      // Info. colors group
      for i := 1 to 15 do begin
         if FBSColor[i] <> nil then begin
            Settings._bandscopecolor[i].FForeColor := FBSColor[i].Font.Color;
            Settings._bandscopecolor[i].FBackColor := FBSColor[i].Color;
         end;
         if FBSBold[i] = nil then begin
            Settings._bandscopecolor[i].FBold      := False;
         end
         else begin
            Settings._bandscopecolor[i].FBold      := FBSBold[i].Checked;
         end;
         if FBSUseReliability[i] = nil then begin
            Settings._bandscopecolor[i].FUseReliability := False;
         end
         else begin
            Settings._bandscopecolor[i].FUseReliability := FBSUseReliability[i].Checked;
         end;
         if FBSTransparent[i] = nil then begin
            Settings._bandscopecolor[i].FTransparent := False;
         end
         else begin
            Settings._bandscopecolor[i].FTransparent := FBSTransparent[i].Checked;
         end;
      end;

      // Bandscope options group

      // BandScope Options
      Settings._bandscope_use_estimated_mode := checkUseEstimatedMode.Checked;      // 周波数からのモードの推定
      Settings._bandscope_show_only_in_bandplan := checkShowOnlyInBandplan.Checked; // バンド内のみ
      Settings._bandscope_show_ja_spots := checkShowJAspots.Checked;                // JAを表示
      Settings._bandscope_show_dx_spots := checkShowDXspots.Checked;                // DXを表示
      Settings._bandscope_use_number_lookup := checkUseNumberLookup.Checked;        // Number Lookup
      Settings._bandscope_use_lookup_server := checkUseLookupServer.Checked;        // Lookup Server
      Settings._bandscope_setfreq_after_mode_change := checkSetFreqAfterModeChange.Checked;  // モード変更後周波数セット
      Settings._bandscope_always_change_mode := checkAlwaysChangeMode.Checked;      // 常にモード変更
      Settings._bandscope_save_current_freq := checkSaveCurrentFreq.Checked;        // S&P時、現在周波数を保存する
      Settings._bandscope_use_resume := checkUseResume.Checked;                     // レジューム使う

      // Reliability

      // Initial reliability group
      Settings._bandscope_initial_reliability_high := radioReliabilityHigh.Checked;

      //
      // Band scope2
      //

      // Spot Freshness group

      // Spot鮮度表示
      if radioFreshness1.Checked = True then begin
         Settings._bandscope_freshness_mode := 0;           // Remain time1
         Settings._bandscope_freshness_icon := 2;
      end
      else if radioFreshness2.Checked = True then begin
         Settings._bandscope_freshness_mode := 1;           // Remain time2
         Settings._bandscope_freshness_icon := 3;
      end
      else if radioFreshness3.Checked = True then begin
         Settings._bandscope_freshness_mode := 2;           // Remain time3
         Settings._bandscope_freshness_icon := 2;
      end
      else if radioFreshness4.Checked = True then begin
         Settings._bandscope_freshness_mode := 3;           // Elapsed time
         Settings._bandscope_freshness_icon := 5;
      end
      else begin
         Settings._bandscope_freshness_mode := 0;
         Settings._bandscope_freshness_icon := 2;
      end;
   end;
end;

procedure TformOptions2.ImplementSettings();
var
   i, j: Integer;
   b: TBand;
begin
   with dmZLogGlobal do begin

      //
      // My station
      //

      // Callsign
      editMyCallsign.Text := Settings._mycall;

      // My position
      editMyGridLoc.Text := Settings._mygridloc;
      editMyLatitude.Text := Settings._mylatitude;
      editMyLongitude.Text := Settings._mylongitude;

      // Parameters
      CQZoneEdit.Text := Settings._mycqzone;
      IARUZoneEdit.Text := Settings._myiaruzone;
      AgeEdit.Text := Settings._myage;
      IotaEdit.Text := Settings._myiota;
      HandleCwEdit.Text := Settings._myhandle_cw;
      HandlePhEdit.Text := Settings._myhandle_ph;

      // Active bands
      for b := b19 to HiBand do begin
         FActiveBands[b].Checked := Settings._activebands[b];
         FPowerPerBand[b].Text := Settings._power[b];
      end;

      // QSL Default
      if Settings._qsl_default = qsNone then begin
         radioQslNone.Checked := True;
      end
      else if Settings._qsl_default = qsPseQsl then begin
         radioPseQsl.Checked := True;
      end
      else begin
         radioNoQsl.Checked := True;
      end;

      //
      // Preferences
      //

      // General group

      // Use contest period
      checkUseContestPeriod.Checked := Settings._use_contest_period;

      // Output logs out of period
      checkOutputOutofPeriod.Checked := Settings._output_outofperiod;

      // Automatically enter exchange from SuperCheck
      cbAutoEnterSuper.Checked := Settings._entersuperexchange;

      // Display long date time
      checkDispLongDateTime.Checked := Settings._displongdatetime;

      // Save when not sending CW
      cbSaveWhenNoCW.Checked := Settings._savewhennocw;

      // J-Mode
      cbJMode.Checked := Settings._jmode;

      // Save every nn QSOs
      SaveEvery.Value := Settings._saveevery;

      // Use Multiline Tabs
      checkUseMultiLineTabs.Checked := Settings.FUseMultiLineTabs;

      // Use dark mode
      checkUseDarkMode.Checked := Settings.FUseDarkMode;

      // Disable shortcuts during QSO editing
      checkDisableShortCutsQSOEdit.Checked := Settings.FDisableShortCutsQSOEdit;

      // Export Memo field to ADIF
      checkExportMemoToAdif.Checked := Settings.FExportMemoToAdif;

      // Browser component used for WebUpload
      case Settings.FBrowserForWebUpload of
         0: radioWebUpload0.Checked := True;
         1: radioWebUpload1.Checked := True;
         2: radioWebUpload2.Checked := True;
         else radioWebUpload0.Checked := True;
      end;

      // Focus Position After QSO Edit group
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

      // Power($N) group
      editPowerH.Text := Settings._PowerH;
      editPowerM.Text := Settings._PowerM;
      editPowerL.Text := Settings._PowerL;
      editPowerP.Text := Settings._PowerP;

      // Accessibility group

      // Focused color
      editFocusedColor.Font.Color := Settings.FAccessibility.FFocusedForeColor;
      editFocusedColor.Color := Settings.FAccessibility.FFocusedBackColor;
      checkFocusedBold.Checked := Settings.FAccessibility.FFocusedBold;

      // QSO List
      for i := 1 to 2 do begin
         FQSOListColor[i].Font.Color := Settings.FQsoListColors[i].FForeColor;
         FQSOListColor[i].Color      := Settings.FQsoListColors[i].FBackColor;
         FQSOListBold[i].Checked     := Settings.FQsoListColors[i].FBold;
      end;

      comboListColorType2.ItemIndex := Settings.FQsoListColorType2;

      //
      // Contest rules
      //

      panelContestName.Caption := Log.QsoList[0].memo;

      // Exchange
      // Sent欄は表示専用
      SentEdit.Text := MyContest.SentStr;

      // Prov/City
      editProv.Text := Settings.CW._prov;
      editCity.Text := Settings.CW._city;

      // Category
      if ContestCategory = ccSingleOp then begin
         radioSingleOp.Checked := True;
      end
      else if ContestCategory = ccMultiOpMultiTx then begin
         radioMultiOpMultiTx.Checked := True;
      end
      else if ContestCategory = ccMultiOpSingleTx then begin
         radioMultiOpSingleTx.Checked := True;
      end
      else if ContestCategory = ccMultiOpTwoTx then begin
         radioMultiOpTwoTx.Checked := True;
      end;

      // #TXNR
      comboTxNo.Text := IntToStr(Settings._txnr);

      // Mode
      groupMode.ItemIndex := Integer(Settings._mode);

      // Score coeff
      ScoreCoeffEdit.Text := FloatToStr(Log.ScoreCoeff);

      // QSY Assist
      radioQsyNone.Checked          := True;
      radioQsyCountDown.Checked     := Settings._countdown;
      radioQsyCount.Checked         := Settings._qsycount;
      editQsyCountDownMinute.Value  := Settings._countdownminute;
      editQsyCountPerHour.Value     := Settings._countperhour;

      // Operators

      // OpList
      for i := 0 to dmZLogGlobal.OpList.Count - 1 do begin
         var op := TOperatorInfo.Create();
         op.Assign(dmZLogGlobal.OpList[i]);
         OpListBox.Items.AddObject(op.Callsign, op);
      end;

      // Select last operator on startup
      checkSelectLastOperator.Checked := Settings._selectlastoperator;

      // Apply power code on band change
      checkApplyPowerCodeOnBandChange.Checked := Settings._applypoweronbandchg;

      //
      // CW/RTTY
      //

      // Messages
      for i := 1 to maxbank do begin
         for j := 1 to maxmessage do begin
            TempCWStrBank[i, j] := MyContest.CwMessages[i, j];
         end;
      end;

      case TempCurrentBank of
         1: rbBankA.Checked := True;
         2: rbBankB.Checked := True;
         3: rbRTTY.Checked := True;
      end;

      // Additional messages
      editCQMessage2.Text := MyContest.CwMessageCQ[2];
      editCQMessage3.Text := MyContest.CwMessageCQ[3];

      // Speed
      SpeedBar.Position := Settings.CW._speed;
      SpeedLabel.Caption := IntToStr(Settings.CW._speed) + ' wpm';

      // Weight
      WeightBar.Position := Settings.CW._weight;
      WeightLabel.Caption := IntToStr(Settings.CW._weight) + ' %';

      // Que messages
      FIFOCheck.Checked := Settings.CW._FIFO;

      // Sidetone
      SideToneCheck.Checked := Settings.CW._sidetone;
      VolumeSpinEdit.Value := Settings.CW._sidetone_volume;
      ToneSpinEdit.Value := Settings.CW._tonepitch;

      // Abbreviation (019)
      AbbrevEdit.Text := Settings.CW._zero + Settings.CW._one + Settings.CW._nine;

      // CQ rpt. interval (sec)
      CQRepEdit.Text := FloatToStrF(Settings.CW._cqrepeat, ffFixed, 3, 1);

      // CQ max
      CQmaxSpinEdit.Value := Settings.CW._cqmax;

      // Use CQ Random Repeat
      checkUseCQRamdomRepeat.Checked := Settings.CW._cq_random_repeat;

      // Switch CW bank with CQ/SP mode
      cbCQSP.Checked := Settings._switchcqsp;

      // Send NR? automatically
      checkSendNrAuto.Checked := Settings.CW._send_nr_auto;

      // Not send leading zeros in serial number
      checkNotSendLeadingZeros.Checked := Settings.CW._not_send_leading_zeros;

      // Paddle reverse
      checkPaddleReverse.Checked := Settings.CW._paddlereverse;

      //
      // Voice
      //

      // Voice Memory
      for i := 1 to maxmessage do begin
         FTempVoiceConfig[i] := Settings.FVoiceConfig[i];
         if FTempVoiceConfig[i].FSoundFile = '' then begin
            FVoiceButton[i].Caption := 'select';
         end
         else begin
            FVoiceButton[i].Caption := ExtractFileName(FTempVoiceConfig[i].FSoundFile);
         end;
         FVoiceEdit[i].Text := Settings.FVoiceConfig[i].FSoundComment;

         SetPrePostProcessButtonAttr(i);
      end;
      for i := 2 to 3 do begin
         FTempAdditionalVoiceConfig[i] := Settings.FAdditionalVoiceConfig[i];
         if FTempAdditionalVoiceConfig[i].FSoundFile = '' then begin
            FAdditionalVoiceButton[i].Caption := 'select';
         end
         else begin
            FAdditionalVoiceButton[i].Caption := ExtractFileName(FTempAdditionalVoiceConfig[i].FSoundFile);
         end;
         FAdditionalVoiceEdit[i].Text := Settings.FAdditionalVoiceConfig[i].FSoundComment;

         SetAdditionalPrePostProcessButtonAttr(i);
      end;

      //
      // Misc
      //

      // Start search after
      rgSearchAfter.ItemIndex := Settings._searchafter;

      // Max super check search
      spMaxSuperHit.Value := Settings._maxsuperhit;

      // Delete band scope data after
      spBSExpire.Value := Settings._bsexpire;

      // Delete spot data after
      spSpotExpire.Value := Settings._spotexpire;

      // Display date in partial check
      cbDisplayDatePartialCheck.Checked := Settings._displaydatepartialcheck;

      // Update using a thread
      cbUpdateThread.Checked := Settings._renewbythread;

      // Use incremental dupe check
      checkUseIncrementalDupeCheck.Checked := Settings.FUseIncrementalDupeCheck;

      // Delay before closing the Partial window
      spPartialCloseTime.Value := Settings.FPartialCloseTime;

      // Super Check group
      case Settings.FSuperCheck.FSuperCheckMethod of
         0: radioSuperCheck0.Checked := True;
         1: radioSuperCheck1.Checked := True;
         else radioSuperCheck2.Checked := True;
      end;
      checkAcceptDuplicates.Checked := Settings.FSuperCheck.FAcceptDuplicates;

      // N+1 group

      // Highlight FullMatch
      checkHighlightFullmatch.Checked := Settings.FSuperCheck.FFullMatchHighlight;
      editFullmatchColor.Color := Settings.FSuperCheck.FFullMatchColor;

      // Partial Check group
      editPartialCheckColor.Font.Color := Settings.FPartialCheck.FCurrentBandForeColor;
      editPartialCheckColor.Color := Settings.FPartialCheck.FCurrentBandBackColor;

      //
      // Quick functions
      //

      // Quick QSY
      FTempFreqMemList.Assign(FreqMemList);
      checkUseKhzQsyCommand.Checked := Settings.FUseKhzQsyCommand;

      // Quick Memo
      for i := 1 to 5 do begin
         FQuickMemoText[i].Text := Settings.FQuickMemoText[i];
      end;

      //
      // Band scope
      //

      // Bands group
      checkBS01.Checked := Settings._usebandscope[b19];
      checkBS02.Checked := Settings._usebandscope[b35];
      checkBS03.Checked := Settings._usebandscope[b7];
      checkBS04.Checked := Settings._usebandscope[b10];
      checkBS05.Checked := Settings._usebandscope[b14];
      checkBS06.Checked := Settings._usebandscope[b18];
      checkBS07.Checked := Settings._usebandscope[b21];
      checkBS08.Checked := Settings._usebandscope[b24];
      checkBS09.Checked := Settings._usebandscope[b28];
      checkBS10.Checked := Settings._usebandscope[b50];
      checkBS11.Checked := Settings._usebandscope[b144];
      checkBS12.Checked := Settings._usebandscope[b430];
      checkBS13.Checked := Settings._usebandscope[b1200];
      checkBS14.Checked := Settings._usebandscope[b2400];
      checkBS15.Checked := Settings._usebandscope[b5600];
      checkBS16.Checked := Settings._usebandscope[b10g];
      checkBS17.Checked := Settings._usebandscope[b104g];
      checkBS18.Checked := Settings._usebandscope[b24g];
      checkBS19.Checked := Settings._usebandscope[b47g];
      checkBS20.Checked := Settings._usebandscope[b77g];
      checkBS21.Checked := Settings._usebandscope[b135g];
      checkBS22.Checked := Settings._usebandscope[b248g];
      checkBsCurrent.Checked := Settings._usebandscope_current;
      checkBsNewMulti.Checked := Settings._usebandscope_newmulti;
      checkBsAllBands.Checked := Settings._usebandscope_allbands;

      // Info. colors group
      for i := 1 to 15 do begin
         if FBSColor[i] <> nil then begin
            FBSColor[i].Font.Color := Settings._bandscopecolor[i].FForeColor;
            FBSColor[i].Color      := Settings._bandscopecolor[i].FBackColor;
         end;
         if FBSBold[i] <> nil then begin
            FBSBold[i].Checked     := Settings._bandscopecolor[i].FBold;
         end;
         if FBSUseReliability[i] <> nil then begin
            FBSUseReliability[i].Checked := Settings._bandscopecolor[i].FUseReliability;
         end;
         if FBSTransparent[i] <> nil then begin
            FBSTransparent[i].Checked := Settings._bandscopecolor[i].FTransparent;
         end;
      end;

      // Bandscope options group

      // BandScope Options
      checkUseEstimatedMode.Checked := Settings._bandscope_use_estimated_mode;      // 周波数からのモードの推定
      checkShowOnlyInBandplan.Checked := Settings._bandscope_show_only_in_bandplan; // バンド内のみ
      checkShowJAspots.Checked := Settings._bandscope_show_ja_spots;                // JAを表示
      checkShowDXspots.Checked := Settings._bandscope_show_dx_spots;                // DXを表示
      checkUseNumberLookup.Checked := Settings._bandscope_use_number_lookup;        // Number Lookup
      checkUseLookupServer.Checked := Settings._bandscope_use_lookup_server;        // Lookup Server
      checkSetFreqAfterModeChange.Checked := Settings._bandscope_setfreq_after_mode_change;  // モード変更後周波数セット
      checkAlwaysChangeMode.Checked := Settings._bandscope_always_change_mode;      // 常にモード変更
      checkSaveCurrentFreq.Checked := Settings._bandscope_save_current_freq;        // S&P時、現在周波数を保存する
      checkUseResume.Checked := Settings._bandscope_use_resume;                     // レジューム使う

      // Initial reliability group
      radioReliabilityHigh.Checked := Settings._bandscope_initial_reliability_high;
      radioReliabilityMiddle.Checked := not Settings._bandscope_initial_reliability_high;

      // 1Radio時のみ設定可能とする
      if Settings._operate_style = os1Radio then begin
         checkSaveCurrentFreq.Enabled := True;
      end
      else begin
         checkSaveCurrentFreq.Enabled := False;
      end;

      checkUseEstimatedModeClick(nil);
      checkUseNumberLookupClick(nil);

      //
      // Band scope2
      //

      // Spot Freshness group

      // Spot鮮度表示
      case Settings._bandscope_freshness_mode of
         0: radioFreshness1.Checked := True;
         1: radioFreshness2.Checked := True;
         2: radioFreshness3.Checked := True;
         3: radioFreshness4.Checked := True;
         else radioFreshness1.Checked := True;
      end;
   end;
end;

procedure TformOptions2.RenewCWStrBankDisp;
var
   i: Integer;
begin
   for i := 1 to maxmessage do begin
      FEditMessage[i].Text := TempCWStrBank[TempCurrentBank, i];
   end;
end;

procedure TformOptions2.buttonOpAddClick(Sender: TObject);
var
   F: TformOperatorEdit;
   obj: TOperatorInfo;
   op: TOperatorInfo;
begin
   F := TformOperatorEdit.Create(Self);
   try
      if F.ShowModal() <> mrOK then begin
         Exit;
      end;

      obj := TOperatorInfo.Create();
      F.GetObject(obj);

      op := dmZLogGlobal.OpList.ObjectOf(obj.Callsign);
      if op = nil then begin
         OpListBox.Items.AddObject(obj.Callsign, obj);
      end
      else begin
         op.Assign(obj);
         obj.Free();
      end;
   finally
      F.Release();
   end;
end;

procedure TformOptions2.buttonOpEditClick(Sender: TObject);
var
   F: TformOperatorEdit;
   obj: TOperatorInfo;
begin
   if OpListBox.ItemIndex = -1 then begin
      Exit;
   end;

   F := TformOperatorEdit.Create(Self);
   try
      obj := TOperatorInfo(OpListBox.Items.Objects[OpListBox.ItemIndex]);

      F.SetObject(obj);

      if F.ShowModal() <> mrOK then begin
         Exit;
      end;

      F.GetObject(obj);

   finally
      F.Free();
   end;
end;

procedure TformOptions2.buttonOpDeleteClick(Sender: TObject);
begin
   if OpListBox.ItemIndex = -1 then begin
      Exit;
   end;
   OpListBox.Items.Delete(OpListBox.ItemIndex);
end;

procedure TformOptions2.SpeedBarChange(Sender: TObject);
begin
   SpeedLabel.Caption := IntToStr(SpeedBar.Position) + ' wpm';
end;

procedure TformOptions2.WeightBarChange(Sender: TObject);
begin
   WeightLabel.Caption := IntToStr(WeightBar.Position) + ' %';
end;

procedure TformOptions2.vButtonEnter(Sender: TObject);
begin
   popupVoiceMenu.Tag := TButton(Sender).Tag;
end;

procedure TformOptions2.vButtonExit(Sender: TObject);
begin
   popupVoiceMenu.Tag := 0;
end;

procedure TformOptions2.vAdditionalButtonEnter(Sender: TObject);
begin
   popupVoiceMenu.Tag := TButton(Sender).Tag + 100;
end;

procedure TformOptions2.vAdditionalButtonExit(Sender: TObject);
begin
   popupVoiceMenu.Tag := 0;
end;

procedure TformOptions2.vButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
   popupVoiceMenu.Tag := TButton(Sender).Tag;
end;

procedure TformOptions2.vAdditionalButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
   popupVoiceMenu.Tag := TButton(Sender).Tag + 100;
end;

procedure TformOptions2.vButtonClick(Sender: TObject);
begin
   OpenDialog.InitialDir := dmZLogGlobal.SoundPath;
   if OpenDialog.Execute then begin
      FTempVoiceConfig[TButton(Sender).Tag].FSoundFile := OpenDialog.filename;
      TLabel(Sender).Caption := ExtractFileName(OpenDialog.filename);
   end;
end;

procedure TformOptions2.vEditExit(Sender: TObject);
begin
   popupVoiceMenu.Tag := 0;
end;

procedure TformOptions2.vAdditionalEditEnter(Sender: TObject);
begin
   popupVoiceMenu.Tag := TEdit(Sender).Tag + 100;
end;

procedure TformOptions2.vAdditionalEditExit(Sender: TObject);
begin
   popupVoiceMenu.Tag := 0;
end;

procedure TformOptions2.vEditEnter(Sender: TObject);
begin
   popupVoiceMenu.Tag := TEdit(Sender).Tag;
end;

procedure TformOptions2.buttonAddVoiceAfterCmdClick(Sender: TObject);
var
   n: Integer;
   dlg: TformPrePostPlaybackDlg;
begin
   dlg := TformPrePostPlaybackDlg.Create(Self);
   n := TSpeedButton(Sender).Tag;
   try
      dlg.Command := FTempAdditionalVoiceConfig[n].FPostProcess.FCommand;

      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

      FTempAdditionalVoiceConfig[n].FPostProcess.FCommand := dlg.Command;

      SetAdditionalPrePostProcessButtonAttr(n);
   finally
      dlg.Release();
   end;
end;

procedure TformOptions2.vAdditionalButtonClick(Sender: TObject);
begin
   OpenDialog.InitialDir := dmZLogGlobal.SoundPath;
   if OpenDialog.Execute then begin
      FTempAdditionalVoiceConfig[TButton(Sender).Tag].FSoundFile := OpenDialog.filename;
      TLabel(Sender).Caption := ExtractFileName(OpenDialog.filename);
   end;
end;

procedure TformOptions2.radioQsyAssistClick(Sender: TObject);
var
   n: Integer;
begin
   n := TRadioButton(Sender).Tag;
   case n of
      // None
      0: begin
         editQsyCountDownMinute.Enabled := False;
         editQsyCountPerHour.Enabled := False;
      end;

      // Count down
      1: begin
         editQsyCountDownMinute.Enabled := True;
         editQsyCountPerHour.Enabled := False;
         if PageControl.ActivePage = tabsheetCategories then begin
            editQsyCountDownMinute.SetFocus();
         end;
      end;

      // QSY Count / hr
      2: begin
         editQsyCountDownMinute.Enabled := False;
         editQsyCountPerHour.Enabled := True;
         if PageControl.ActivePage = tabsheetCategories then begin
            editQsyCountPerHour.SetFocus();
         end;
      end;
   end;
end;

procedure TformOptions2.OnNeedSuperCheckLoad(Sender: TObject);
begin
   FNeedSuperCheckLoad := True;
end;

procedure TformOptions2.CQRepEditKeyPress(Sender: TObject; var Key: char);
begin
   if (Key < Char(Ord('0'))) then begin
      Exit;
   end;

   if not(SysUtils.CharInSet(Key, ['0' .. '9', '.'])) then begin
      Key := #0;
   end;
end;

procedure TformOptions2.editMessage1Change(Sender: TObject);
var
   i: integer;
begin
   i := TEdit(Sender).Tag;
   TempCWStrBank[TempCurrentBank, i] := TEdit(Sender).Text;
end;

procedure TformOptions2.CWBankClick(Sender: TObject);
begin
   TempCurrentBank := TRadioButton(Sender).Tag;
   RenewCWStrBankDisp;
end;

procedure TformOptions2.checkUseEstimatedModeClick(Sender: TObject);
var
   f: Boolean;
begin
   f := checkUseEstimatedMode.Checked;
   checkAlwaysChangeMode.Enabled := f;
   checkSetFreqAfterModeChange.Enabled := f;
end;

procedure TformOptions2.checkUseNumberLookupClick(Sender: TObject);
var
   f: Boolean;
begin
   f := checkUseNumberLookup.Checked;
   checkUseLookupServer.Enabled := f;
end;

procedure TformOptions2.SetEditNumber(no: Integer);
begin
   if (no >= 1) and (no <= 12) then begin
      FEditNumber := no;
   end;
   if (no = 101) then begin
      FEditNumber := 1;
   end;
   if (no = 102) then begin
      FEditNumber := 1;
   end;
   if (no = 103) then begin
      FEditNumber := 1;
   end;
end;

procedure TformOptions2.buttonFullmatchSelectColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editFullmatchColor.Color;
   if ColorDialog1.Execute = True then begin
      editFullmatchColor.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.buttonListBackClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FQSOListColor[n].Color;
   if ColorDialog1.Execute = True then begin
      FQSOListColor[n].Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.buttonListForeClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FQSOListColor[n].Font.Color;
   if ColorDialog1.Execute = True then begin
      FQSOListColor[n].Font.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.buttonListResetClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   FQSOListColor[n].Font.Color  := QsoListDefaultColor[n].FForeColor;
   FQSOListColor[n].Color       := QsoListDefaultColor[n].FBackColor;
   if Assigned(FQSOListBold[n]) then begin
      FQSOListBold[n].Checked      := QsoListDefaultColor[n].FBold;
   end;
end;

procedure TformOptions2.buttonFullmatchInitColorClick(Sender: TObject);
begin
   editFullmatchColor.Color := clYellow;
end;

procedure TformOptions2.buttonBSForeClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FBSColor[n].Font.Color;
   if ColorDialog1.Execute = True then begin
      FBSColor[n].Font.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.buttonBSBackClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FBSColor[n].Color;
   if ColorDialog1.Execute = True then begin
      FBSColor[n].Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.checkBSBoldClick(Sender: TObject);
var
   n: Integer;
begin
   n := TCheckBox(Sender).Tag;

   if TCheckBox(Sender).Checked = True then begin
      FBSColor[n].Font.Style := FBSColor[n].Font.Style + [fsBold];
   end
   else begin
      FBSColor[n].Font.Style := FBSColor[n].Font.Style - [fsBold];
   end;
end;

procedure TformOptions2.buttonBSResetClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   FBSColor[n].Font.Color  := BandScopeDefaultColor[n].FForeColor;
   FBSColor[n].Color       := BandScopeDefaultColor[n].FBackColor;
   if FBSBold[n] <> nil then begin
      FBSBold[n].Checked      := BandScopeDefaultColor[n].FBold;
   end;
   if FBSUseReliability[n] <> nil then begin
      FBSUseReliability[n].Checked := False;
   end;
   if FBSTransparent[n] <> nil then begin
      FBSTransparent[n].Checked := False;
   end;
end;

procedure TformOptions2.InitVoice();
var
   L: TStringList;
begin
   FVoiceEdit[1] := vEdit1;
   FVoiceEdit[2] := vEdit2;
   FVoiceEdit[3] := vEdit3;
   FVoiceEdit[4] := vEdit4;
   FVoiceEdit[5] := vEdit5;
   FVoiceEdit[6] := vEdit6;
   FVoiceEdit[7] := vEdit7;
   FVoiceEdit[8] := vEdit8;
   FVoiceEdit[9] := vEdit9;
   FVoiceEdit[10] := vEdit10;
   FVoiceEdit[11] := vEdit11;
   FVoiceEdit[12] := vEdit12;
   FVoiceButton[1] := vButton1;
   FVoiceButton[2] := vButton2;
   FVoiceButton[3] := vButton3;
   FVoiceButton[4] := vButton4;
   FVoiceButton[5] := vButton5;
   FVoiceButton[6] := vButton6;
   FVoiceButton[7] := vButton7;
   FVoiceButton[8] := vButton8;
   FVoiceButton[9] := vButton9;
   FVoiceButton[10] := vButton10;
   FVoiceButton[11] := vButton11;
   FVoiceButton[12] := vButton12;
   FAdditionalVoiceButton[2] := vButton13;
   FAdditionalVoiceButton[3] := vButton14;

   FVoiceSound := TWaveSound.Create();

   L := TWaveSound.DeviceList();
   try
      comboVoiceDevice.Items.Assign(L);
   finally
      L.Free();
   end;
end;

procedure TformOptions2.listviewFreqMemoryDblClick(Sender: TObject);
begin
   buttonFreqMemEdit.Click();
end;

procedure TformOptions2.listviewFreqMemorySelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
   buttonFreqMemEdit.Enabled := Selected;
   buttonFreqMemDelete.Enabled := Selected;
end;

procedure TformOptions2.menuVoiceClearClick(Sender: TObject);
var
   n: Integer;
begin
   n := popupVoiceMenu.Tag;
   if n = 0 then begin
      Exit;
   end;

   if (n <= 12) then begin
      FTempVoiceConfig[n].FSoundFile := '';
      FVoiceEdit[n].Text := '';
      FVoiceButton[n].Caption := 'select';
   end
   else begin
      n := n - 100;
      FTempAdditionalVoiceConfig[n].FSoundFile := '';
      FAdditionalVoiceEdit[n].Text := '';
      FAdditionalVoiceButton[n].Caption := 'select';
   end;
end;

procedure TformOptions2.menuVoicePlayClick(Sender: TObject);
var
   n: Integer;
begin
   n := popupVoiceMenu.Tag;
   if n = 0 then begin
      Exit;
   end;

   if (n <= 12) then begin
      if (FTempVoiceConfig[n].FSoundFile <> '') and
         (FileExists(FTempVoiceConfig[n].FSoundFile) = True) then begin
         FVoiceSound.Open(FTempVoiceConfig[n].FSoundFile, comboVoiceDevice.ItemIndex);
         FVoiceSound.Play();
      end;
   end
   else begin
      n := n - 100;
      if (FTempAdditionalVoiceConfig[n].FSoundFile <> '') and
         (FileExists(FTempAdditionalVoiceConfig[n].FSoundFile) = True) then begin
         FVoiceSound.Open(FTempAdditionalVoiceConfig[n].FSoundFile, comboVoiceDevice.ItemIndex);
         FVoiceSound.Play();
      end;
   end;
end;

procedure TformOptions2.menuVoiceStopClick(Sender: TObject);
begin
   FVoiceSound.Stop();
   FVoiceSound.Close();
end;

procedure TformOptions2.buttonPartialCheckForeColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editPartialCheckColor.Font.Color;
   if ColorDialog1.Execute = True then begin
      editPartialCheckColor.Font.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.buttonPartialCheckBackColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editPartialCheckColor.Color;
   if ColorDialog1.Execute = True then begin
      editPartialCheckColor.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.buttonPartialCheckInitColorClick(Sender: TObject);
begin
   editPartialCheckColor.Font.Color := clFuchsia;
   editPartialCheckColor.Color := clWhite;
end;

procedure TformOptions2.buttonFocusedForeColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editFocusedColor.Font.Color;
   if ColorDialog1.Execute = True then begin
      editFocusedColor.Font.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.buttonFocusedBackColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editFocusedColor.Color;
   if ColorDialog1.Execute = True then begin
      editFocusedColor.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.buttonFocusedInitColorClick(Sender: TObject);
begin
   editFocusedColor.Font.Color := clBlack;
   editFocusedColor.Color := clWhite;
   checkFocusedBold.Checked := False;
end;

procedure TformOptions2.buttonFreqMemAddClick(Sender: TObject);
var
   dlg: TformFreqMemDialog;
   D: TFreqMemory;
begin
   dlg := TformFreqMemDialog.Create(Self);
   try
      dlg.TempFreqMemList := FTempFreqMemList;

      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

      D := TFreqMemory.Create();
      D.Frequency := dlg.Frequency;
      D.Mode := dlg.Mode;
      D.RigNo := dlg.RigNo;
      D.Command := dlg.Command;
      D.FixEdgeNo := dlg.FixEdgeNo;
      FTempFreqMemList.Add(D);
      AddFreqMemList(D);
   finally
      dlg.Release();
   end;
end;

procedure TformOptions2.buttonFreqMemEditClick(Sender: TObject);
var
   dlg: TformFreqMemDialog;
   D: TFreqMemory;
begin
   dlg := TformFreqMemDialog.Create(Self);
   try
      dlg.TempFreqMemList := FTempFreqMemList;

      D := listviewFreqMemory.Selected.Data;

      dlg.Frequency := D.Frequency;
      dlg.Mode := D.Mode;
      dlg.RigNo := D.RigNo;
      dlg.Command := D.Command;
      dlg.FixEdgeNo := D.FixEdgeNo;

      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

      D.Frequency := dlg.Frequency;
      D.Mode := dlg.Mode;
      D.RigNo := dlg.RigNo;
      D.Command := dlg.Command;
      D.FixEdgeNo := dlg.FixEdgeNo;

      UpdateFreqMemList(listviewFreqMemory.Selected);
   finally
      dlg.Release();
   end;
end;

procedure TformOptions2.buttonFreqMemDeleteClick(Sender: TObject);
var
   D: TFreqMemory;
begin
   D := listviewFreqMemory.Selected.Data;
   listviewFreqMemory.Selected.Delete();
   FTempFreqMemList.Delete(D);
end;

procedure TformOptions2.checkFocusedBoldClick(Sender: TObject);
begin
   if checkFocusedBold.Checked = True then begin
      editFocusedColor.Font.Style := editFocusedColor.Font.Style + [fsBold];
   end
   else begin
      editFocusedColor.Font.Style := editFocusedColor.Font.Style - [fsBold];
   end;
end;

procedure TformOptions2.checkListBoldClick(Sender: TObject);
var
   n: Integer;
begin
   n := TCheckBox(Sender).Tag;

   if TCheckBox(Sender).Checked = True then begin
      FQSOListColor[n].Font.Style := FQSOListColor[n].Font.Style + [fsBold];
   end
   else begin
      FQSOListColor[n].Font.Style := FQSOListColor[n].Font.Style - [fsBold];
   end;
end;

procedure TformOptions2.buttonPlayVoiceClick(Sender: TObject);
var
   i: Integer;
   n: Integer;
begin
   n := 0;
   try
      for i := 1 to High(FVoiceEdit) do begin
         if (FVoiceEdit[i].Focused = True) or (FVoiceButton[i].Focused = True) then begin
            if FileExists(FTempVoiceConfig[i].FSoundFile) = True then begin
               n := i;
               FVoiceSound.Open(FTempVoiceConfig[i].FSoundFile, comboVoiceDevice.ItemIndex);
               FVoiceSound.Play();
               Exit;
            end;
         end;
      end;
      for i := 2 to 3 do begin
         if (FAdditionalVoiceEdit[i].Focused = True) or (FAdditionalVoiceButton[i].Focused = True) then begin
            if FileExists(FTempAdditionalVoiceConfig[i].FSoundFile) = True then begin
               n := i;
               FVoiceSound.Open(FTempAdditionalVoiceConfig[i].FSoundFile, comboVoiceDevice.ItemIndex);
               FVoiceSound.Play();
               Exit;
            end;
         end;
      end;
   except
      on E: Exception do begin
         Application.MessageBox(PChar(E.Message), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
         if n > 0 then begin
            FVoiceButton[n].Caption := 'select';
            FTempVoiceConfig[n].FSoundFile := '';
         end;
      end;
   end;
end;

procedure TformOptions2.buttonStopVoiceClick(Sender: TObject);
begin
   FVoiceSound.Stop();
   FVoiceSound.Close();
end;

procedure TformOptions2.buttonVoiceAfterCmdClick(Sender: TObject);
var
   n: Integer;
   dlg: TformPrePostPlaybackDlg;
begin
   dlg := TformPrePostPlaybackDlg.Create(Self);
   n := TSpeedButton(Sender).Tag;
   try
      if FTempVoiceConfig[n].FPostProcess.FCommand <> '' then begin
         dlg.Command := FTempVoiceConfig[n].FPostProcess.FCommand;
         dlg.ExecuteAt := eaAfter;
      end
      else begin
         dlg.Command := FTempVoiceConfig[n].FPreProcess.FCommand;
         dlg.ExecuteAt := eaBefore;
      end;

      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

      if dlg.ExecuteAt = eaBefore then begin
         FTempVoiceConfig[n].FPreProcess.FCommand := dlg.Command;
         FTempVoiceConfig[n].FPostProcess.FCommand := '';
      end
      else begin
         FTempVoiceConfig[n].FPreProcess.FCommand := '';
         FTempVoiceConfig[n].FPostProcess.FCommand := dlg.Command;
      end;

      SetPrePostProcessButtonAttr(n);
   finally
      dlg.Release();
   end;
end;

procedure TformOptions2.buttonSpotterListClick(Sender: TObject);
var
   dlg: TformSpotterListDlg;
begin
   dlg := TformSpotterListDlg.Create(Self);
   try

      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

   finally
      dlg.Release();
   end;
end;

procedure TformOptions2.AddFreqMemList(D: TFreqMemory);
var
   listitem: TListItem;
   S: string;
begin
   listitem := listviewFreqMemory.Items.Add();
   listitem.Caption := IntToStr(listviewFreqMemory.Items.Count);
   listitem.SubItems.Add(IntToStr(D.Frequency));
   listitem.SubItems.Add(ModeString[D.Mode]);

   case D.RigNo of
      0: S := 'None';
      1: S := 'RIG-A';
      2: S := 'RIG-B';
      3: S := 'RIG-C';
      else S := '';
   end;
   listitem.SubItems.Add(S);
   listitem.SubItems.Add(D.Command);
   listitem.SubItems.Add(IntToStr(D.FixEdgeNo));
   listitem.Data := D;
end;

procedure TformOptions2.UpdateFreqMemList(listitem: TListItem);
var
   D: TFreqMemory;
   S: string;
begin
   D := listitem.Data;
   listitem.SubItems[0] := IntToStr(D.Frequency);
   listitem.SubItems[1] := ModeString[D.Mode];

   case D.RigNo of
      0: S := 'None';
      1: S := 'RIG-A';
      2: S := 'RIG-B';
      3: S := 'RIG-C';
      else S := '';
   end;
   listitem.SubItems[2] := S;

   listitem.SubItems[3] := D.Command;
   listitem.SubItems[4] := IntToStr(D.FixEdgeNo);
end;

procedure TformOptions2.SetPrePostProcessButtonAttr(i: Integer);
begin
   if (FTempVoiceConfig[i].FPreProcess.FCommand <> '') or
      (FTempVoiceConfig[i].FPostProcess.FCommand <> '') then begin
      FPrePostProcessButton[i].Font.Style := [fsBold];
   end
   else begin
      FPrePostProcessButton[i].Font.Style := [];
   end;
end;

procedure TformOptions2.SetAdditionalPrePostProcessButtonAttr(i: Integer);
begin
   if (FTempAdditionalVoiceConfig[i].FPreProcess.FCommand <> '') or
      (FTempAdditionalVoiceConfig[i].FPostProcess.FCommand <> '') then begin
      FAdditionalPrePostProcessButton[i].Font.Style := [fsBold];
   end
   else begin
      FAdditionalPrePostProcessButton[i].Font.Style := [];
   end;
end;

procedure TformOptions2.buttonMyGridCalcClick(Sender: TObject);
var
   dlg: TformDmsToGridDialog;
begin
   dlg := TformDmsToGridDialog.Create(Self);
   try
      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

      editMyGridLoc.Text := dlg.GridLoc;
      editMyLatitude.Text := dlg.Latitude;
      editMyLongitude.Text := dlg.Longitude;
   finally
      dlg.Release();
   end;

end;

procedure TformOptions2.buttonMyPositionCalcClick(Sender: TObject);
var
   strGridLoc: string;
   latitude, longitude: Extended;
begin
   strGridLoc := UpperCase(editMyGridLoc.Text);
   if Length(strGridLoc) <> 6 then begin
      Exit;
   end;

   glGridToDeg(strGridLoc, latitude, longitude);
   editMyLatitude.Text := Format('%.4f', [latitude]);
   editMyLongitude.Text := Format('%.4f', [longitude]);
end;

end.
