unit UOptions;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls, Spin, Vcl.Buttons, System.UITypes,
  Dialogs, Menus, FileCtrl, JvExStdCtrls, JvCombobox, JvColorCombo,
  UIntegerDialog, UzLogConst, UzLogGlobal, UzLogSound, UOperatorEdit, UzLogOperatorInfo;

type
  TformOptions = class(TForm)
    PageControl: TPageControl;
    tabsheetPreferences: TTabSheet;
    tabsheetCategories: TTabSheet;
    tabsheetCW: TTabSheet;
    tabsheetVoice: TTabSheet;
    tabsheetHardware: TTabSheet;
    tabsheetRigControl: TTabSheet;
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    GroupBox1: TGroupBox;
    radioSingleOp: TRadioButton;
    ModeGroup: TRadioGroup;
    GroupBox2: TGroupBox;
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
    SpeedBar: TTrackBar;
    Label11: TLabel;
    SpeedLabel: TLabel;
    Label13: TLabel;
    WeightBar: TTrackBar;
    WeightLabel: TLabel;
    CQmaxSpinEdit: TSpinEdit;
    ToneSpinEdit: TSpinEdit;
    Label15: TLabel;
    Label16: TLabel;
    CQRepEdit: TEdit;
    Label17: TLabel;
    FIFOCheck: TCheckBox;
    AbbrevEdit: TEdit;
    Label12: TLabel;
    ProvEdit: TEdit;
    CItyEdit: TEdit;
    Label14: TLabel;
    Label18: TLabel;
    SentEdit: TEdit;
    Label19: TLabel;
    GroupBox3: TGroupBox;
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
    act10g: TCheckBox;
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
    CQZoneEdit: TEdit;
    IARUZoneEdit: TEdit;
    Label34: TLabel;
    Label35: TLabel;
    groupOptCwPtt: TGroupBox;
    Label38: TLabel;
    PTTEnabledCheckBox: TCheckBox;
    Label39: TLabel;
    BeforeEdit: TEdit;
    AfterEdit: TEdit;
    AllowDupeCheckBox: TCheckBox;
    SaveEvery: TSpinEdit;
    Label40: TLabel;
    Label41: TLabel;
    rbBankA: TRadioButton;
    rbBankB: TRadioButton;
    cbDispExchange: TCheckBox;
    cbJMode: TCheckBox;
    comboRig1Port: TComboBox;
    comboRig1Name: TComboBox;
    Label43: TLabel;
    comboRig2Port: TComboBox;
    comboRig2Name: TComboBox;
    tabsheetMisc: TTabSheet;
    cbRITClear: TCheckBox;
    cbDontAllowSameBand: TCheckBox;
    SendFreqEdit: TEdit;
    Label45: TLabel;
    Label46: TLabel;
    cbSaveWhenNoCW: TCheckBox;
    rgSearchAfter: TRadioGroup;
    spMaxSuperHit: TSpinEdit;
    Label47: TLabel;
    spBSExpire: TSpinEdit;
    Label48: TLabel;
    Label49: TLabel;
    cbUpdateThread: TCheckBox;
    cbRecordRigFreq: TCheckBox;
    cbTransverter1: TCheckBox;
    cbTransverter2: TCheckBox;
    tabsheetPath: TTabSheet;
    Label50: TLabel;
    editCfgDatFolder: TEdit;
    buttonBrowseCFGDATPath: TButton;
    Label51: TLabel;
    editLogsFolder: TEdit;
    buttonBrowseLogsPath: TButton;
    rbRTTY: TRadioButton;
    cbCQSP: TCheckBox;
    cbAutoEnterSuper: TCheckBox;
    Label52: TLabel;
    Label53: TLabel;
    spSpotExpire: TSpinEdit;
    cbDisplayDatePartialCheck: TCheckBox;
    cbAutoBandMap: TCheckBox;
    comboRig1Speed: TComboBox;
    comboRig2Speed: TComboBox;
    comboCwPttPort1: TComboBox;
    tabsheetQuickQSY: TTabSheet;
    checkUseQuickQSY01: TCheckBox;
    comboQuickQsyBand01: TComboBox;
    comboQuickQsyMode01: TComboBox;
    checkUseQuickQSY02: TCheckBox;
    comboQuickQsyBand02: TComboBox;
    comboQuickQsyMode02: TComboBox;
    checkUseQuickQSY03: TCheckBox;
    comboQuickQsyBand03: TComboBox;
    comboQuickQsyMode03: TComboBox;
    checkUseQuickQSY04: TCheckBox;
    comboQuickQsyBand04: TComboBox;
    comboQuickQsyMode04: TComboBox;
    checkUseQuickQSY05: TCheckBox;
    comboQuickQsyBand05: TComboBox;
    comboQuickQsyMode05: TComboBox;
    checkUseQuickQSY06: TCheckBox;
    comboQuickQsyBand06: TComboBox;
    comboQuickQsyMode06: TComboBox;
    checkUseQuickQSY07: TCheckBox;
    comboQuickQsyBand07: TComboBox;
    comboQuickQsyMode07: TComboBox;
    checkUseQuickQSY08: TCheckBox;
    comboQuickQsyBand08: TComboBox;
    comboQuickQsyMode08: TComboBox;
    Label54: TLabel;
    Label33: TLabel;
    GroupBox8: TGroupBox;
    radioSuperCheck0: TRadioButton;
    radioSuperCheck1: TRadioButton;
    radioSuperCheck2: TRadioButton;
    buttonBrowseBackupPath: TButton;
    editBackupFolder: TEdit;
    Label56: TLabel;
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
    comboPower10g: TComboBox;
    GroupBox5: TGroupBox;
    checkHighlightFullmatch: TCheckBox;
    editFullmatchColor: TEdit;
    buttonFullmatchSelectColor: TButton;
    buttonFullmatchInitColor: TButton;
    tabsheetBandScope1: TTabSheet;
    GroupBox9: TGroupBox;
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
    GroupBox10: TGroupBox;
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
    checkSendNrAuto: TCheckBox;
    comboQuickQsyRig01: TComboBox;
    Label62: TLabel;
    comboQuickQsyRig02: TComboBox;
    comboQuickQsyRig03: TComboBox;
    comboQuickQsyRig04: TComboBox;
    comboQuickQsyRig05: TComboBox;
    comboQuickQsyRig06: TComboBox;
    comboQuickQsyRig07: TComboBox;
    comboQuickQsyRig08: TComboBox;
    tabsheetQuickMemo: TTabSheet;
    GroupBox11: TGroupBox;
    Label63: TLabel;
    editQuickMemo1: TEdit;
    Label64: TLabel;
    editQuickMemo2: TEdit;
    Label65: TLabel;
    editQuickMemo3: TEdit;
    Label66: TLabel;
    editQuickMemo4: TEdit;
    Label67: TLabel;
    editQuickMemo5: TEdit;
    tabsheetBandScope2: TTabSheet;
    GroupBox12: TGroupBox;
    Label61: TLabel;
    editBSColor5: TEdit;
    buttonBSFore5: TButton;
    buttonBSBack5: TButton;
    checkBSBold5: TCheckBox;
    buttonBSReset5: TButton;
    Label68: TLabel;
    editBSColor6: TEdit;
    buttonBSFore6: TButton;
    buttonBSBack6: TButton;
    checkBSBold6: TCheckBox;
    buttonBSReset6: TButton;
    editBSColor7: TEdit;
    buttonBSFore7: TButton;
    buttonBSBack7: TButton;
    checkBSBold7: TCheckBox;
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
    Label74: TLabel;
    buttonBrowseSoundPath: TButton;
    editSoundFolder: TEdit;
    Label90: TLabel;
    buttonBrowsePluginPath: TButton;
    editPluginsFolder: TEdit;
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
    editBSColor7_2: TEdit;
    buttonBSBack7_2: TButton;
    buttonBSBack7_3: TButton;
    editBSColor7_3: TEdit;
    Label69: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    groupUsif4cw: TGroupBox;
    checkUsbif4cwSyncWpm: TCheckBox;
    checkUsbif4cwPaddleReverse: TCheckBox;
    GroupBox14: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    editCQMessage2: TEdit;
    editCQMessage3: TEdit;
    GroupBox15: TGroupBox;
    checkUseAntiZeroin: TCheckBox;
    editMaxShift: TEdit;
    Label28: TLabel;
    Label29: TLabel;
    updownAntiZeroinShiftMax: TUpDown;
    checkAntiZeroinAutoCancel: TCheckBox;
    updownSendFreqInterval: TUpDown;
    SideToneCheck: TCheckBox;
    GroupBox16: TGroupBox;
    comboVoiceDevice: TComboBox;
    buttonPlayVoice: TSpeedButton;
    buttonStopVoice: TSpeedButton;
    checkUseWinKeyer: TCheckBox;
    checkAntiZeroinStopCq: TCheckBox;
    checkUseCQRamdomRepeat: TCheckBox;
    GroupBox17: TGroupBox;
    GroupBox18: TGroupBox;
    checkAntiZeroinRitOff: TCheckBox;
    checkAntiZeroinXitOff: TCheckBox;
    checkAntiZeroinRitClear: TCheckBox;
    checkAntiZeroinXitOn1: TCheckBox;
    checkAntiZeroinXitOn2: TCheckBox;
    GroupBox19: TGroupBox;
    Label36: TLabel;
    Label37: TLabel;
    Label82: TLabel;
    vEdit14: TEdit;
    vEdit13: TEdit;
    vButton13: TButton;
    vButton14: TButton;
    GroupBox20: TGroupBox;
    checkUseEstimatedMode: TCheckBox;
    checkShowOnlyInBandplan: TCheckBox;
    checkShowOnlyDomestic: TCheckBox;
    groupOptCI_V: TGroupBox;
    comboIcomMode: TComboBox;
    comboIcomMethod: TComboBox;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    VolumeSpinEdit: TSpinEdit;
    groupQsyAssist: TGroupBox;
    radioQsyNone: TRadioButton;
    radioQsyCountDown: TRadioButton;
    radioQsyCount: TRadioButton;
    Label86: TLabel;
    editQsyCountDownMinute: TSpinEdit;
    editQsyCountPerHour: TSpinEdit;
    Label87: TLabel;
    GroupBox22: TGroupBox;
    Label88: TLabel;
    editPartialCheckColor: TEdit;
    buttonPartialCheckForeColor: TButton;
    buttonPartialCheckInitColor: TButton;
    buttonPartialCheckBackColor: TButton;
    GroupBox23: TGroupBox;
    Label89: TLabel;
    editFocusedColor: TEdit;
    buttonFocusedBackColor: TButton;
    buttonFocusedInitColor: TButton;
    checkFocusedBold: TCheckBox;
    buttonFocusedForeColor: TButton;
    checkNotSendLeadingZeros: TCheckBox;
    Label91: TLabel;
    comboTxNo: TComboBox;
    GroupBox24: TGroupBox;
    OpListBox: TListBox;
    buttonOpAdd: TButton;
    buttonOpDelete: TButton;
    radioMultiOpMultiTx: TRadioButton;
    radioMultiOpSingleTx: TRadioButton;
    radioMultiOpTwoTx: TRadioButton;
    comboCwPttPort2: TComboBox;
    groupRig1: TGroupBox;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    groupRig2: TGroupBox;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    groupSo2rSupport: TGroupBox;
    radioSo2rZLog: TRadioButton;
    radioSo2rNeo: TRadioButton;
    comboSo2rRxSelectPort: TComboBox;
    radioSo2rNone: TRadioButton;
    checkWk9600: TCheckBox;
    tabsheetNetwork: TTabSheet;
    groupNetwork: TGroupBox;
    Label30: TLabel;
    Port: TLabel;
    Label32: TLabel;
    Label55: TLabel;
    ClusterCombo: TComboBox;
    buttonClusterSettings: TButton;
    ZLinkCombo: TComboBox;
    buttonZLinkSettings: TButton;
    editZLinkPcName: TEdit;
    checkZLinkSyncSerial: TCheckBox;
    groupRig3: TGroupBox;
    Label99: TLabel;
    comboCwPttPort3: TComboBox;
    GroupBox6: TGroupBox;
    Label31: TLabel;
    comboSo2rTxSelectPort: TComboBox;
    Label42: TLabel;
    groupWinKeyer: TGroupBox;
    checkWkOutportSelect: TCheckBox;
    GroupBox7: TGroupBox;
    groupSo2rCqOption: TGroupBox;
    Label44: TLabel;
    editSo2rCqRptIntervalSec: TEdit;
    Label100: TLabel;
    panelSo2rMessageNumber: TPanel;
    radioSo2rCqMsgBankA: TRadioButton;
    radioSo2rCqMsgBankB: TRadioButton;
    comboSo2rCqMsgNumber: TComboBox;
    Label101: TLabel;
    editSo2rRigSwAfterDelay: TEdit;
    checkWkIgnoreSpeedPot: TCheckBox;
    GroupBox13: TGroupBox;
    radioQslNone: TRadioButton;
    radioPseQsl: TRadioButton;
    radioNoQsl: TRadioButton;
    checkBsNewMulti: TCheckBox;
    tabsheetFont: TTabSheet;
    GroupBox21: TGroupBox;
    comboFontBase: TJvFontComboBox;
    Label102: TLabel;
    Label103: TLabel;
    GroupBox25: TGroupBox;
    comboAnt19: TComboBox;
    comboAnt35: TComboBox;
    comboAnt7: TComboBox;
    comboAnt10: TComboBox;
    comboAnt14: TComboBox;
    comboAnt18: TComboBox;
    comboAnt21: TComboBox;
    comboAnt24: TComboBox;
    comboAnt28: TComboBox;
    comboAnt50: TComboBox;
    comboAnt144: TComboBox;
    comboAnt430: TComboBox;
    comboAnt1200: TComboBox;
    comboAnt2400: TComboBox;
    comboAnt5600: TComboBox;
    comboAnt10g: TComboBox;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    checkUseLookupServer: TCheckBox;
    checkSetFreqAfterModeChange: TCheckBox;
    checkAlwaysChangeMode: TCheckBox;
    buttonSpotterList: TButton;
    checkAcceptDuplicates: TCheckBox;
    editRootFolder: TEdit;
    Label120: TLabel;
    buttonBrowseRootFolder: TButton;
    Label121: TLabel;
    buttonBrowseSpcPath: TButton;
    editSpcFolder: TEdit;
    checkCwReverseSignal3: TCheckBox;
    checkCwReverseSignal2: TCheckBox;
    checkCwReverseSignal1: TCheckBox;
    checkIcomStrictAck: TCheckBox;
    editIcomResponseTimout: TEdit;
    Label122: TLabel;
    checkDispLongDateTime: TCheckBox;
    procedure buttonOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buttonOpAddClick(Sender: TObject);
    procedure buttonOpDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure SpeedBarChange(Sender: TObject);
    procedure WeightBarChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vButtonClick(Sender: TObject);
    procedure ClusterComboChange(Sender: TObject);
    procedure buttonClusterSettingsClick(Sender: TObject);
    procedure ZLinkComboChange(Sender: TObject);
    procedure buttonZLinkSettingsClick(Sender: TObject);
    procedure BrowsePathClick(Sender: TObject);
    procedure PTTEnabledCheckBoxClick(Sender: TObject);
    procedure CQRepEditKeyPress(Sender: TObject; var Key: Char);
    procedure editMessage1Change(Sender: TObject);
    procedure CWBankClick(Sender: TObject);
    procedure cbTransverter1Click(Sender: TObject);
    procedure comboRig1NameChange(Sender: TObject);
    procedure comboRig2NameChange(Sender: TObject);
    procedure checkUseQuickQSYClick(Sender: TObject);
    procedure OnNeedSuperCheckLoad(Sender: TObject);
    procedure buttonFullmatchSelectColorClick(Sender: TObject);
    procedure buttonFullmatchInitColorClick(Sender: TObject);
    procedure buttonBSForeClick(Sender: TObject);
    procedure buttonBSBackClick(Sender: TObject);
    procedure checkBSBoldClick(Sender: TObject);
    procedure buttonBSResetClick(Sender: TObject);
    procedure buttonPlayVoiceClick(Sender: TObject);
    procedure buttonStopVoiceClick(Sender: TObject);
    procedure OpListBoxDblClick(Sender: TObject);
    procedure vAdditionalButtonClick(Sender: TObject);
    procedure comboIcomModeChange(Sender: TObject);
    procedure radioQsyAssistClick(Sender: TObject);
    procedure buttonPartialCheckForeColorClick(Sender: TObject);
    procedure buttonPartialCheckBackColorClick(Sender: TObject);
    procedure buttonPartialCheckInitColorClick(Sender: TObject);
    procedure buttonFocusedBackColorClick(Sender: TObject);
    procedure buttonFocusedInitColorClick(Sender: TObject);
    procedure checkFocusedBoldClick(Sender: TObject);
    procedure buttonFocusedForeColorClick(Sender: TObject);
    procedure radioCategoryClick(Sender: TObject);
    procedure comboCwPttPortChange(Sender: TObject);
    procedure checkUseWinKeyerClick(Sender: TObject);
    procedure radioSo2rClick(Sender: TObject);
    procedure checkUseEstimatedModeClick(Sender: TObject);
    procedure buttonSpotterListClick(Sender: TObject);
  private
    FEditMode: Integer;
    FEditNumber: Integer;
    FTempVoiceFiles : array[1..maxmessage] of string;
    FTempAdditionalVoiceFiles : array[2..3] of string;
    TempCurrentBank : integer;
    TempCWStrBank : array[1..maxbank,1..maxmessage] of string; // used temporarily while options window is open

    FTempClusterTelnet: TCommParam;
    FTempClusterCom: TCommParam;
    FTempZLinkTelnet: TCommParam;

    FQuickQSYCheck: array[1..8] of TCheckBox;
    FQuickQSYBand: array[1..8] of TComboBox;
    FQuickQSYMode: array[1..8] of TComboBox;
    FQuickQSYRig: array[1..8] of TComboBox;

    FBSColor: array[1..73] of TEdit;
    FBSBold: array[1..7] of TCheckBox;

    FNeedSuperCheckLoad: Boolean;

    FQuickMemoText: array[1..5] of TEdit;

    FEditMessage: array[1..maxmessage] of TEdit;

    FVoiceEdit: array[1..maxmessage] of TEdit;
    FVoiceButton: array[1..maxmessage] of TButton;
    FVoiceSound: TWaveSound;
    FAdditionalVoiceEdit: array[2..3] of TEdit;
    FAdditionalVoiceButton: array[2..3] of TButton;

    procedure RenewCWStrBankDisp();
    procedure InitRigNames();
    procedure SetEditNumber(no: Integer);
    procedure InitVoice();
  public
    procedure RenewSettings; {Reads controls and updates Settings}
    property EditMode: Integer read FEditMode write FEditMode;
    property EditNumber: Integer read FEditNumber write SetEditNumber;
    property NeedSuperCheckLoad: Boolean read FNeedSuperCheckLoad;
    property EditBank: Integer read TempCurrentBank write TempCurrentBank;
  end;

const
  BandScopeDefaultColor: array[1..7] of TColorSetting = (
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clRed;   FBackColor: clWhite; FBold: True ),
    ( FForeColor: clGreen; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clGreen; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True )
  );

resourcestring
  // COMポート設定
  COM_PORT_SETTING = 'COM port settings';

  // TELNET設定
  TELNET_SETTING = 'TELNET settings';

  // SuperCheck用のファイルが保存されているフォルダを選択して下さい
  SELECT_SPC_FOLDER = 'Select the folder where the files for SuperCheck';

  // フォルダの参照
  SELECT_FOLDER = 'Select folder';

  // オフセット周波数を kHz で入力してください
  PLEASE_INPUT_OFFSET_FREQ = 'Please input the offset frequency in kHz';

  // プラグインのフォルダが変更されました。インストールされたプラグインは無効になります。よろしいですか？
  Installed_Plugins_Disabled = 'Plugins folder changed. Installed plugins will be disabled. Are you sure?';

  // 以降のバンドも同じ設定に変更しますか？
  DoYouWantTheFollowingBandsToHaveTheSameSettins = 'Do you want the following bands to have the same settings?';

  // zLogルートフォルダはフルパスで入力して下さい。
  EnterTheFullPathOfRootFolder = 'Enter the full path of the zLog root folder';

  // zLogルートフォルダが存在しません
  zLogRootFolderNotExist = 'zLog root folder does not exist';

implementation

uses Main, UzLogCW, UComm, UClusterTelnetSet, UClusterCOMSet,
  UZlinkTelnetSet, UZLinkForm, URigControl, UPluginManager, USpotterListDlg;

{$R *.DFM}

procedure TformOptions.radioCategoryClick(Sender: TObject);
var
   n: Integer;
begin
   n := TRadioButton(Sender).Tag;
   case n of
      // Single-Op
      0: begin
         comboTxNo.Enabled := False;
         comboTxNo.Items.CommaText := '0,1';
         comboTxNo.ItemIndex := 0;
         OpListBox.Enabled := False;
         buttonOpAdd.Enabled := False;
         buttonOpDelete.Enabled := False;
      end;

      // Multi-Op/Multi-Tx
      1: begin
         comboTxNo.Enabled := True;
         comboTxNo.Items.CommaText := TXLIST_MM;
         comboTxNo.ItemIndex := 0;
         OpListBox.Enabled := True;
         buttonOpAdd.Enabled := True;
         buttonOpDelete.Enabled := True;
      end;

      // Multi-Op/Single-Tx, Multi-Op/Two-Tx
      2, 3: begin
         comboTxNo.Enabled := True;
         comboTxNo.Items.CommaText := TXLIST_MS;
         comboTxNo.ItemIndex := 0;
         OpListBox.Enabled := True;
         buttonOpAdd.Enabled := True;
         buttonOpDelete.Enabled := True;
      end;
   end;
end;

procedure TformOptions.RenewSettings;
var
   r: double;
   i, j: integer;

   procedure SetRigControlParam(no: Integer; C, S, N, K: TComboBox; T, R: TCheckBox);
   begin
      with dmZlogGlobal do begin
         if Assigned(C) then begin
            Settings.FRigControl[no].FControlPort := C.ItemIndex;
         end;

         if Assigned(S) then begin
            Settings.FRigControl[no].FSpeed := S.ItemIndex;
         end;

         if Assigned(N) then begin
            if N.ItemIndex <= 0 then begin
               Settings.FRigControl[no].FRigName := '';
            end
            else begin
               Settings.FRigControl[no].FRigName := N.Text;
            end;
         end;

         if Assigned(K) then begin
            if (K.ItemIndex >= 1) and (K.ItemIndex <= 20) then begin
               Settings.FRigControl[no].FKeyingPort := K.ItemIndex;
            end
            else if K.ItemIndex = 21 then begin    // USB
               Settings.FRigControl[no].FKeyingPort := 21;
            end
            else begin
               Settings.FRigControl[no].FKeyingPort := 0;
            end;
         end;

         if Assigned(T) then begin
            Settings.FRigControl[no].FUseTransverter := T.Checked;
         end;

         if Assigned(R) then begin
            Settings.FRigControl[no].FKeyingIsRTS := R.Checked;
         end;
      end;
   end;
begin
   with dmZlogGlobal do begin
      Settings._savewhennocw := cbSaveWhenNoCW.Checked;
      Settings._jmode := cbJMode.Checked;
      Settings._searchafter := rgSearchAfter.ItemIndex;
      Settings._renewbythread := cbUpdateThread.Checked;
      Settings._displaydatepartialcheck := cbDisplayDatePartialCheck.Checked;

      Settings._maxsuperhit := spMaxSuperHit.Value;

      Settings._activebands[b19] := act19.Checked;
      Settings._activebands[b35] := act35.Checked;
      Settings._activebands[b7] := act7.Checked;
      Settings._activebands[b10] := act10.Checked;
      Settings._activebands[b14] := act14.Checked;
      Settings._activebands[b18] := act18.Checked;
      Settings._activebands[b21] := act21.Checked;
      Settings._activebands[b24] := act24.Checked;
      Settings._activebands[b28] := act28.Checked;
      Settings._activebands[b50] := act50.Checked;
      Settings._activebands[b144] := act144.Checked;
      Settings._activebands[b430] := act430.Checked;
      Settings._activebands[b1200] := act1200.Checked;
      Settings._activebands[b2400] := act2400.Checked;
      Settings._activebands[b5600] := act5600.Checked;
      Settings._activebands[b10g] := act10g.Checked;

      Settings._power[b19] := comboPower19.Text;
      Settings._power[b35] := comboPower35.Text;
      Settings._power[b7] := comboPower7.Text;
      Settings._power[b10] := comboPower10.Text;
      Settings._power[b14] := comboPower14.Text;
      Settings._power[b18] := comboPower18.Text;
      Settings._power[b21] := comboPower21.Text;
      Settings._power[b24] := comboPower24.Text;
      Settings._power[b28] := comboPower28.Text;
      Settings._power[b50] := comboPower50.Text;
      Settings._power[b144] := comboPower144.Text;
      Settings._power[b430] := comboPower430.Text;
      Settings._power[b1200] := comboPower1200.Text;
      Settings._power[b2400] := comboPower2400.Text;
      Settings._power[b5600] := comboPower5600.Text;
      Settings._power[b10g] := comboPower10g.Text;

      Settings._mode := TContestMode(ModeGroup.ItemIndex);

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

      Settings._prov := ProvEdit.Text;
      Settings._city := CityEdit.Text;
      Settings._cqzone := CQZoneEdit.Text;
      Settings._iaruzone := IARUZoneEdit.Text;

      {
        Settings.CW.CWStrBank[1,1] := Edit1.Text;
        Settings.CW.CWStrBank[1,2] := Edit2.Text;
        Settings.CW.CWStrBank[1,3] := Edit3.Text;
        Settings.CW.CWStrBank[1,4] := Edit4.Text;
        Settings.CW.CWStrBank[1,5] := Edit5.Text;
        Settings.CW.CWStrBank[1,6] := Edit6.Text;
        Settings.CW.CWStrBank[1,7] := Edit7.Text;
        Settings.CW.CWStrBank[1,8] := Edit8.Text;

        Settings.CW.CQStrBank[0] := Edit1.Text;
      }

      for i := 1 to maxbank do begin
         for j := 1 to maxmessage do begin
            Settings.CW.CWStrBank[i, j] := TempCWStrBank[i, j];
         end;
      end;

      Settings.CW.AdditionalCQMessages[2] := editCQMessage2.Text;
      Settings.CW.AdditionalCQMessages[3] := editCQMessage3.Text;

      Settings._bsexpire := spBSExpire.Value;
      Settings._spotexpire := spSpotExpire.Value;

      r := Settings.CW._cqrepeat;
      Settings.CW._cqrepeat := StrToFloatDef(CQRepEdit.Text, r);

      Settings.CW._speed := SpeedBar.Position;
      Settings.CW._weight := WeightBar.Position;
      Settings.CW._paddlereverse := checkUsbif4cwPaddleReverse.Checked;
      Settings.CW._FIFO := FIFOCheck.Checked;
      Settings.CW._sidetone := SideToneCheck.Checked;
      Settings.CW._sidetone_volume := VolumeSpinEdit.Value;
      Settings.CW._tonepitch := ToneSpinEdit.Value;
      Settings.CW._cqmax := CQmaxSpinEdit.Value;

      Settings.CW._cq_random_repeat := checkUseCQRamdomRepeat.Checked;
      Settings._switchcqsp := cbCQSP.Checked;

      if length(AbbrevEdit.Text) >= 3 then begin
         Settings.CW._zero := AbbrevEdit.Text[1];
         Settings.CW._one := AbbrevEdit.Text[2];
         Settings.CW._nine := AbbrevEdit.Text[3];
      end;

      // Send NR? automatically
      Settings.CW._send_nr_auto := checkSendNrAuto.Checked;

      // Not send leading zeros in serial number
      Settings.CW._not_send_leading_zeros := checkNotSendLeadingZeros.Checked;

      Settings._clusterport := ClusterCombo.ItemIndex;
   //   Settings._clusterbaud := ClusterCOMSet.BaudCombo.ItemIndex;

      //
      // RIG1-3
      //
      SetRigControlParam(1, comboRig1Port, comboRig1Speed, comboRig1Name, comboCwPttPort1, cbTransverter1, checkCwReverseSignal1);
      SetRigControlParam(2, comboRig2Port, comboRig2Speed, comboRig2Name, comboCwPttPort2, cbTransverter2, checkCwReverseSignal2);
      SetRigControlParam(3, nil,           nil,            nil,           comboCwPttPort3, nil,            checkCwReverseSignal3);

      //
      // ICOM CI-V options
      //
      if comboIcomMode.ItemIndex = 0 then begin
         Settings._use_transceive_mode := True;
      end
      else begin
         Settings._use_transceive_mode := False;
      end;

      if comboIcomMethod.ItemIndex = 0 then begin
         Settings._icom_polling_freq_and_mode := True;
      end
      else begin
         Settings._icom_polling_freq_and_mode := False;
      end;

      Settings._icom_strict_ack_response := checkIcomStrictAck.Checked;
      Settings._icom_response_timeout := StrToIntDef(editIcomResponseTimout.Text, 1000);

      Settings._usbif4cw_sync_wpm := checkUsbif4cwSyncWpm.Checked;

      Settings._zlinkport := ZLinkCombo.ItemIndex;
      Settings._pcname := editZLinkPcName.Text;
      Settings._syncserial := checkZLinkSyncSerial.Checked;

      Settings._pttenabled := PTTEnabledCheckBox.Checked;

      Settings._saveevery        := SaveEvery.Value;

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

      // QSY Assist
      Settings._countdown        := radioQsyCountDown.Checked;
      Settings._qsycount         := radioQsyCount.Checked;
      Settings._countdownminute  := editQsyCountDownMinute.Value;
      Settings._countperhour     := editQsyCountPerHour.Value;

      i := Settings._pttbefore;
      Settings._pttbefore := StrToIntDef(BeforeEdit.Text, i);

      i := Settings._pttafter;
      Settings._pttafter := StrToIntDef(AfterEdit.Text, i);

      // Use Winkeyer
      Settings._use_winkeyer := checkUseWinkeyer.Checked;
      Settings._use_wk_9600 := checkWk9600.Checked;
      Settings._use_wk_outp_select := checkWkOutportSelect.Checked;
      Settings._use_wk_ignore_speed_pot := checkWkIgnoreSpeedPot.Checked;

      // SO2R Support
      if radioSo2rNone.Checked = True then begin
         Settings._so2r_type := so2rNone;
      end
      else if radioSo2rZLog.Checked = True then begin
         Settings._so2r_type := so2rCom;
      end
      else begin
         Settings._so2r_type := so2rNeo;
      end;
      Settings._so2r_tx_port := comboSo2rTxSelectPort.ItemIndex;
      Settings._so2r_rx_port := comboSo2rRxSelectPort.ItemIndex;

      r := Settings._so2r_cq_rpt_interval_sec;
      Settings._so2r_cq_rpt_interval_sec := StrToFloatDef(editSo2rCqRptIntervalSec.Text, r);
      Settings._so2r_rigsw_after_delay := StrToIntDef(editSo2rRigSwAfterDelay.Text, 200);
      if radioSo2rCqMsgBankA.Checked = True then begin
         Settings._so2r_cq_msg_bank := 1;
      end
      else begin
         Settings._so2r_cq_msg_bank := 2;
      end;
      Settings._so2r_cq_msg_number  := comboSo2rCqMsgNumber.ItemIndex + 1;

//      Settings._sentstr := SentEdit.Text;

      //
      // Folders
      //
      Settings._rootpath := editRootFolder.Text;
      Settings._cfgdatpath := editCfgDatFolder.Text;
      Settings._logspath := editLogsFolder.Text;
      Settings._backuppath := editBackupFolder.Text;
      Settings._soundpath := editSoundFolder.Text;

      if IncludeTrailingPathDelimiter(editPluginsFolder.Text) <> IncludeTrailingPathDelimiter(Settings._pluginpath) then begin
         if Application.MessageBox(PChar(Installed_Plugins_Disabled), PChar(Application.Title), MB_YESNO or MB_ICONEXCLAMATION) = IDYES then begin
            Settings._pluginpath := editPluginsFolder.Text;
         end;
      end;

      Settings.FSuperCheck.FSuperCheckFolder := editSpcFolder.Text;

      Settings._allowdupe := AllowDupeCheckBox.Checked;
      Settings._sameexchange := cbDispExchange.Checked;
      Settings._entersuperexchange := cbAutoEnterSuper.Checked;
      Settings._displongdatetime := checkDispLongDateTime.Checked;

      Settings._cluster_telnet := FTempClusterTelnet;
      Settings._cluster_com := FTempClusterCom;
      Settings._zlink_telnet := FTempZLinkTelnet;

      //
      // Rig Control
      //

      // general
      Settings._ritclear := cbRITClear.Checked;
      Settings._dontallowsameband := cbDontAllowSameBand.Checked;
      Settings._recrigfreq := cbRecordRigFreq.Checked;
      Settings._autobandmap := cbAutoBandMap.Checked;
      Settings._send_freq_interval := updownSendFreqInterval.Position;

      // Ant Control
      Settings._useant[b19]   := comboAnt19.ItemIndex;
      Settings._useant[b35]   := comboAnt35.ItemIndex;
      Settings._useant[b7]    := comboAnt7.ItemIndex;
      Settings._useant[b10]   := comboAnt10.ItemIndex;
      Settings._useant[b14]   := comboAnt14.ItemIndex;
      Settings._useant[b18]   := comboAnt18.ItemIndex;
      Settings._useant[b21]   := comboAnt21.ItemIndex;
      Settings._useant[b24]   := comboAnt24.ItemIndex;
      Settings._useant[b28]   := comboAnt28.ItemIndex;
      Settings._useant[b50]   := comboAnt50.ItemIndex;
      Settings._useant[b144]  := comboAnt144.ItemIndex;
      Settings._useant[b430]  := comboAnt430.ItemIndex;
      Settings._useant[b1200] := comboAnt1200.ItemIndex;
      Settings._useant[b2400] := comboAnt2400.ItemIndex;
      Settings._useant[b5600] := comboAnt5600.ItemIndex;
      Settings._useant[b10g]  := comboAnt10g.ItemIndex;

      // Anti Zeroin
      Settings.FUseAntiZeroin := checkUseAntiZeroin.Checked;
      Settings.FAntiZeroinShiftMax := updownAntiZeroinShiftMax.Position;
      Settings.FAntiZeroinRitOff := checkAntiZeroinRitOff.Checked;
      Settings.FAntiZeroinXitOff := checkAntiZeroinXitOff.Checked;
      Settings.FAntiZeroinRitClear := checkAntiZeroinRitClear.Checked;
      Settings.FAntiZeroinXitOn1 := checkAntiZeroinXitOn1.Checked;
      Settings.FAntiZeroinXitOn2 := checkAntiZeroinXitOn2.Checked;
      Settings.FAntiZeroinAutoCancel := checkAntiZeroinAutoCancel.Checked;
      Settings.FAntiZeroinStopCq := checkAntiZeroinStopCq.Checked;

      // Quick QSY
      for i := Low(FQuickQSYCheck) to High(FQuickQSYCheck) do begin
         Settings.FQuickQSY[i].FUse := FQuickQSYCheck[i].Checked;
         if FQuickQSYBand[i].ItemIndex = -1 then begin
            Settings.FQuickQSY[i].FBand := b35;
         end
         else begin
            Settings.FQuickQSY[i].FBand := TBand(FQuickQSYBand[i].ItemIndex);
         end;

         if FQuickQSYMode[i].ItemIndex = -1 then begin
            Settings.FQuickQSY[i].FMode := mCW;
         end
         else begin
            Settings.FQuickQSY[i].FMode := TMode(FQuickQSYMode[i].ItemIndex);
         end;

         Settings.FQuickQSY[i].FRig := FQuickQSYRig[i].ItemIndex;
      end;

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
      Settings.FSuperCheck.FFullMatchHighlight := checkHighlightFullmatch.Checked;
      Settings.FSuperCheck.FFullMatchColor := editFullmatchColor.Color;

      // Partial Check
      Settings.FPartialCheck.FCurrentBandForeColor := editPartialCheckColor.Font.Color;
      Settings.FPartialCheck.FCurrentBandBackColor := editPartialCheckColor.Color;

      // Accessibility
      Settings.FAccessibility.FFocusedForeColor := editFocusedColor.Font.Color;
      Settings.FAccessibility.FFocusedBackColor := editFocusedColor.Color;
      Settings.FAccessibility.FFocusedBold := checkFocusedBold.Checked;

      // Band Scope
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
      Settings._usebandscope_current := checkBsCurrent.Checked;
      Settings._usebandscope_newmulti := checkBsNewMulti.Checked;

      for i := 1 to 7 do begin
         Settings._bandscopecolor[i].FForeColor := FBSColor[i].Font.Color;
         Settings._bandscopecolor[i].FBackColor := FBSColor[i].Color;
         Settings._bandscopecolor[i].FBold      := FBSBold[i].Checked;
      end;
      Settings._bandscopecolor[7].FBackColor2 := FBSColor[72].Color;
      Settings._bandscopecolor[7].FBackColor3 := FBSColor[73].Color;

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

      // BandScope Options
      Settings._bandscope_use_estimated_mode := checkUseEstimatedMode.Checked;      // 周波数からのモードの推定
      Settings._bandscope_show_only_in_bandplan := checkShowOnlyInBandplan.Checked; // バンド内のみ
      Settings._bandscope_show_only_domestic := checkShowOnlyDomestic.Checked;      // 国内のみ
      Settings._bandscope_use_lookup_server := checkUseLookupServer.Checked;        // Lookup Server
      Settings._bandscope_setfreq_after_mode_change := checkSetFreqAfterModeChange.Checked;  // モード変更後周波数セット
      Settings._bandscope_always_change_mode := checkAlwaysChangeMode.Checked;      // 常にモード変更

      // Quick Memo
      for i := 1 to 5 do begin
         Settings.FQuickMemoText[i] := Trim(FQuickMemoText[i].Text);
      end;

      // Voice Memory
      for i := 1 to maxmessage do begin
         Settings.FSoundFiles[i] := FTempVoiceFiles[i];
         Settings.FSoundComments[i] := FVoiceEdit[i].Text;
      end;
      for i := 2 to 3 do begin
         Settings.FAdditionalSoundFiles[i] := FTempAdditionalVoiceFiles[i];
         Settings.FAdditionalSoundComments[i] := FAdditionalVoiceEdit[i].Text;
      end;
      Settings.FSoundDevice := comboVoiceDevice.ItemIndex;

      // Font
      Settings.FBaseFontName := comboFontBase.FontName;
   end;
end;

procedure TformOptions.buttonOKClick(Sender: TObject);
var
   S: string;
begin
   // zLogルートフォルダのチェック
   S := editRootFolder.Text;
   if (S <> '') and (S <> '%ZLOG_ROOT%') then begin
      if IsFullPath(S) = False then begin
         Application.MessageBox(PChar(EnterTheFullPathOfRootFolder), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
         Exit;
      end;
      if SysUtils.DirectoryExists(S) = False then begin
         Application.MessageBox(PChar(zLogRootFolderNotExist), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
         Exit;
      end;
   end;

   // 入力された設定を保存
   RenewSettings;

   // 各種フォルダ作成
   dmZLogGlobal.CreateFolders();

   ModalResult := mrOK;
end;

procedure TformOptions.RenewCWStrBankDisp;
var
   i: Integer;
begin
   for i := 1 to maxmessage do begin
      FEditMessage[i].Text := TempCWStrBank[TempCurrentBank, i];
      if dmZLogGlobal.Settings.CW.CWStrImported[TempCurrentBank, i] = True then begin
         FEditMessage[i].Color := clBtnFace;
         FEditMessage[i].ReadOnly := dmZLogGlobal.Settings.ReadOnlyParamImported;
      end
      else begin
         FEditMessage[i].Color := clWindow;
         FEditMessage[i].ReadOnly := False;
      end;
   end;
end;

procedure TformOptions.FormShow(Sender: TObject);
var
   i, j: integer;

   procedure GetRigControlParam(no: Integer; C, S, N, K: TComboBox; T, R: TCheckBox);
   begin
      with dmZlogGlobal do begin
         if Assigned(C) then begin
            C.ItemIndex := Settings.FRigControl[no].FControlPort;
         end;

         if Assigned(S) then begin
            S.ItemIndex := Settings.FRigControl[no].FSpeed;
         end;

         if Assigned(N) then begin
            if Settings.FRigControl[no].FRigName = '' then begin
               N.ItemIndex := 0;
            end
            else begin
               N.ItemIndex := N.Items.Indexof(Settings.FRigControl[no].FRigName);
            end;
         end;

         if Assigned(K) then begin
            if (Settings.FRigControl[no].FKeyingPort >= 1) and (Settings.FRigControl[no].FKeyingPort <= 20) then begin
               K.ItemIndex := Settings.FRigControl[no].FKeyingPort;
            end
            else if Settings.FRigControl[no].FKeyingPort = 21 then begin    // USB
               K.ItemIndex := 21;
            end
            else begin
               K.ItemIndex := 0;
            end;
         end;

         if Assigned(T) then begin
            T.Checked := Settings.FRigControl[no].FUseTransverter;
         end;

         if Assigned(R) then begin
            R.Checked := Settings.FRigControl[no].FKeyingIsRTS;
         end;
      end;
   end;
begin
   with dmZlogGlobal do begin
      FTempClusterTelnet := Settings._cluster_telnet;
      FTempClusterCom := Settings._cluster_com;
      FTempZLinkTelnet := Settings._zlink_telnet;

      cbSaveWhenNoCW.Checked := Settings._savewhennocw;
      cbJMode.Checked := Settings._jmode;

      rgSearchAfter.ItemIndex := Settings._searchafter;
      spMaxSuperHit.Value := Settings._maxsuperhit;
      spBSExpire.Value := Settings._bsexpire;
      spSpotExpire.Value := Settings._spotexpire;
      cbUpdateThread.Checked := Settings._renewbythread;
      cbDisplayDatePartialCheck.Checked := Settings._displaydatepartialcheck;

      act19.Checked := Settings._activebands[b19];
      act35.Checked := Settings._activebands[b35];
      act7.Checked := Settings._activebands[b7];
      act10.Checked := Settings._activebands[b10];
      act14.Checked := Settings._activebands[b14];
      act18.Checked := Settings._activebands[b18];
      act21.Checked := Settings._activebands[b21];
      act24.Checked := Settings._activebands[b24];
      act28.Checked := Settings._activebands[b28];
      act50.Checked := Settings._activebands[b50];
      act144.Checked := Settings._activebands[b144];
      act430.Checked := Settings._activebands[b430];
      act1200.Checked := Settings._activebands[b1200];
      act2400.Checked := Settings._activebands[b2400];
      act5600.Checked := Settings._activebands[b5600];
      act10g.Checked := Settings._activebands[b10g];

      comboPower19.Text := Settings._power[b19];
      comboPower35.Text := Settings._power[b35];
      comboPower7.Text := Settings._power[b7];
      comboPower10.Text := Settings._power[b10];
      comboPower14.Text := Settings._power[b14];
      comboPower18.Text := Settings._power[b18];
      comboPower21.Text := Settings._power[b21];
      comboPower24.Text := Settings._power[b24];
      comboPower28.Text := Settings._power[b28];
      comboPower50.Text := Settings._power[b50];
      comboPower144.Text := Settings._power[b144];
      comboPower430.Text := Settings._power[b430];
      comboPower1200.Text := Settings._power[b1200];
      comboPower2400.Text := Settings._power[b2400];
      comboPower5600.Text := Settings._power[b5600];
      comboPower10g.Text := Settings._power[b10g];

      // Category
      if ContestCategory = ccSingleOp then begin
         radioSingleOp.Checked := True;
      end
      else if ContestCategory = ccMultiOpMultiTx then begin
         radioMultiOpMultiTx.Checked := True
      end
      else if ContestCategory = ccMultiOpSingleTx then begin
         radioMultiOpSingleTx.Checked := True
      end
      else if ContestCategory = ccMultiOpTwoTx then begin
         radioMultiOpTwoTx.Checked := True
      end;
//      case ContestCategory of
//         ccSingleOp:          radioSingleOp.Checked := True;
//         ccMultiOpMultiTx:    radioMultiOpMultiTx.Checked := True;
//         ccMultiOpSingleTx:   radioMultiOpSingleTx.Checked := True;
//         ccMultiOpTwoTx:      radioMultiOpTwoTx.Checked := True;
//      end;

      // #TXNR
      comboTxNo.ItemIndex := comboTxNo.Items.IndexOf(IntToStr(Settings._txnr));

      ModeGroup.ItemIndex := Integer(Settings._mode);
      { OpListBox.Items := OpList; }

      for i := 1 to maxbank do begin
         for j := 1 to maxmessage do begin
            TempCWStrBank[i, j] := Settings.CW.CWStrBank[i, j];
         end;
      end;

      case TempCurrentBank of
         1:
            rbBankA.Checked := True;
         2:
            rbBankB.Checked := True;
         3:
            rbRTTY.Checked := True;
      end;

      RenewCWStrBankDisp;

      editCQMessage2.Text := Settings.CW.AdditionalCQMessages[2];
      editCQMessage3.Text := Settings.CW.AdditionalCQMessages[3];

      CQRepEdit.Text := FloatToStrF(Settings.CW._cqrepeat, ffFixed, 3, 1);
      SpeedBar.Position := Settings.CW._speed;
      SpeedLabel.Caption := IntToStr(Settings.CW._speed) + ' wpm';
      WeightBar.Position := Settings.CW._weight;
      checkUsbif4cwPaddleReverse.Checked := Settings.CW._paddlereverse;
      WeightLabel.Caption := IntToStr(Settings.CW._weight) + ' %';
      FIFOCheck.Checked := Settings.CW._FIFO;
      SideToneCheck.Checked := Settings.CW._sidetone;
      VolumeSpinEdit.Value := Settings.CW._sidetone_volume;
      ToneSpinEdit.Value := Settings.CW._tonepitch;
      CQmaxSpinEdit.Value := Settings.CW._cqmax;
      AbbrevEdit.Text := Settings.CW._zero + Settings.CW._one + Settings.CW._nine;

      ProvEdit.Text := Settings._prov;
      CityEdit.Text := Settings._city;
      if Settings.ProvCityImported = True then begin
         ProvEdit.Color := clBtnFace;
         CityEdit.Color := clBtnFace;
         ProvEdit.ReadOnly := Settings.ReadOnlyParamImported;
         CityEdit.ReadOnly := Settings.ReadOnlyParamImported;
      end
      else begin
         ProvEdit.Color := clWindow;
         CityEdit.Color := clWindow;
         ProvEdit.ReadOnly := False;
         CityEdit.ReadOnly := False;
      end;

      CQZoneEdit.Text := Settings._cqzone;
      IARUZoneEdit.Text := Settings._iaruzone;

      AllowDupeCheckBox.Checked := Settings._allowdupe;

      ClusterCombo.ItemIndex := Settings._clusterport;
      ZLinkCombo.ItemIndex := Settings._zlinkport;
      editZLinkPcName.Text := Settings._pcname;
      checkZLinkSyncSerial.Checked := Settings._syncserial;

      //
      // RIG1-3
      //
      GetRigControlParam(1, comboRig1Port, comboRig1Speed, comboRig1Name, comboCwPttPort1, cbTransverter1, checkCwReverseSignal1);
      GetRigControlParam(2, comboRig2Port, comboRig2Speed, comboRig2Name, comboCwPttPort2, cbTransverter2, checkCwReverseSignal2);
      GetRigControlParam(3, nil,           nil,            nil,           comboCwPttPort3, nil,            checkCwReverseSignal3);

      //
      // ICOM CI-V options
      //
      if Settings._use_transceive_mode = True then begin
         comboIcomMode.ItemIndex := 0;
      end
      else begin
         comboIcomMode.ItemIndex := 1;
      end;

      if Settings._icom_polling_freq_and_mode = True then begin
         comboIcomMethod.ItemIndex := 0;
      end
      else begin
         comboIcomMethod.ItemIndex := 1;
      end;

      comboIcomModeChange(nil);

      checkIcomStrictAck.Checked := Settings._icom_strict_ack_response;
      editIcomResponseTimout.Text := IntToStr(Settings._icom_response_timeout);

      checkUsbif4cwSyncWpm.Checked := Settings._usbif4cw_sync_wpm;

      // Packet Cluster通信設定ボタン
      buttonClusterSettings.Enabled := True;
      ClusterComboChange(nil);

      // ZLink通信設定ボタン
      buttonZLinkSettings.Enabled := True;
      ZLinkComboChange(nil);

      SaveEvery.Value := Settings._saveevery;

      // Use Winkeyer
      checkUseWinkeyer.Checked := Settings._use_winkeyer;
      checkWk9600.Checked := Settings._use_wk_9600;
      checkWkOutportSelect.Checked := Settings._use_wk_outp_select;
      checkWkIgnoreSpeedPot.Checked := Settings._use_wk_ignore_speed_pot;

      // SO2R Support
      case Settings._so2r_type of
         so2rNone: begin
            radioSo2rNone.Checked := True;
            radioSo2rClick(radioSo2rNone);
         end;

         so2rCom: begin
            radioSo2rZLog.Checked := True;
            radioSo2rClick(radioSo2rZLog);
         end;

         so2rNeo: begin
            radioSo2rNeo.Checked := True;
            radioSo2rClick(radioSo2rNeo);
         end;
      end;
      comboSo2rTxSelectPort.ItemIndex := Settings._so2r_tx_port;
      comboSo2rRxSelectPort.ItemIndex := Settings._so2r_rx_port;

      editSo2rCqRptIntervalSec.Text := FloatToStrF(Settings._so2r_cq_rpt_interval_sec, ffFixed, 3, 1);
      editSo2rRigSwAfterDelay.Text := IntToStr(Settings._so2r_rigsw_after_delay);

      if Settings._so2r_cq_msg_bank = 1 then begin
         radioSo2rCqMsgBankA.Checked := True;
      end
      else begin
         radioSo2rCqMsgBankB.Checked := True;
      end;
      comboSo2rCqMsgNumber.ItemIndex := Settings._so2r_cq_msg_number - 1;

      // Sent欄は表示専用
      SentEdit.Text := Settings._sentstr;

      //
      // Folders
      //
      editRootFolder.Text := Settings._rootpath;
      editCfgDatFolder.Text := Settings._cfgdatpath;
      editLogsFolder.Text := Settings._logspath;
      editBackupFolder.Text := Settings._backuppath;
      editSoundFolder.Text := Settings._soundpath;
      editPluginsFolder.Text := Settings._pluginpath;
      editSpcFolder.Text := Settings.FSuperCheck.FSuperCheckFolder;

      PTTEnabledCheckBox.Checked := Settings._pttenabled;

      BeforeEdit.Text := IntToStr(Settings._pttbefore);
      AfterEdit.Text := IntToStr(Settings._pttafter);
      if PTTEnabledCheckBox.Checked then begin
         BeforeEdit.Enabled := True;
         AfterEdit.Enabled := True;
      end
      else begin
         BeforeEdit.Enabled := False;
         AfterEdit.Enabled := False;
      end;
      checkUseCQRamdomRepeat.Checked := Settings.CW._cq_random_repeat;
      cbCQSP.Checked := Settings._switchcqsp;

      // Send NR? automatically
      checkSendNrAuto.Checked := Settings.CW._send_nr_auto;

      // Not send leading zeros in serial number
      checkNotSendLeadingZeros.Checked := Settings.CW._not_send_leading_zeros;

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

      // QSY Assist
      radioQsyNone.Checked          := True;
      radioQsyCountDown.Checked     := Settings._countdown;
      radioQsyCount.Checked         := Settings._qsycount;
      editQsyCountDownMinute.Value  := Settings._countdownminute;
      editQsyCountPerHour.Value     := Settings._countperhour;

      cbDispExchange.Checked := Settings._sameexchange;
      cbAutoEnterSuper.Checked := Settings._entersuperexchange;
      checkDispLongDateTime.Checked := Settings._displongdatetime;

      //
      // Rig Control
      //

      // general
      cbRITClear.Checked := Settings._ritclear;
      cbDontAllowSameBand.Checked := Settings._dontallowsameband;
      cbRecordRigFreq.Checked := Settings._recrigfreq;
      cbAutoBandMap.Checked := Settings._autobandmap;
      updownSendFreqInterval.Position := Settings._send_freq_interval;

      // Ant Control
      comboAnt19.ItemIndex    := Settings._useant[b19];
      comboAnt35.ItemIndex    := Settings._useant[b35];
      comboAnt7.ItemIndex     := Settings._useant[b7];
      comboAnt10.ItemIndex    := Settings._useant[b10];
      comboAnt14.ItemIndex    := Settings._useant[b14];
      comboAnt18.ItemIndex    := Settings._useant[b18];
      comboAnt21.ItemIndex    := Settings._useant[b21];
      comboAnt24.ItemIndex    := Settings._useant[b24];
      comboAnt28.ItemIndex    := Settings._useant[b28];
      comboAnt50.ItemIndex    := Settings._useant[b50];
      comboAnt144.ItemIndex   := Settings._useant[b144];
      comboAnt430.ItemIndex   := Settings._useant[b430];
      comboAnt1200.ItemIndex  := Settings._useant[b1200];
      comboAnt2400.ItemIndex  := Settings._useant[b2400];
      comboAnt5600.ItemIndex  := Settings._useant[b5600];
      comboAnt10g.ItemIndex   := Settings._useant[b10g];

      // Anti Zeroin
      checkUseAntiZeroin.Checked := Settings.FUseAntiZeroin;
      updownAntiZeroinShiftMax.Position := Settings.FAntiZeroinShiftMax;
      checkAntiZeroinRitOff.Checked := Settings.FAntiZeroinRitOff;
      checkAntiZeroinXitOff.Checked := Settings.FAntiZeroinXitOff;
      checkAntiZeroinRitClear.Checked := Settings.FAntiZeroinRitClear;
      checkAntiZeroinXitOn1.Checked := Settings.FAntiZeroinXitOn1;
      checkAntiZeroinXitOn2.Checked := Settings.FAntiZeroinXitOn2;
      checkAntiZeroinAutoCancel.Checked := Settings.FAntiZeroinAutoCancel;
      checkAntiZeroinStopCq.Checked := Settings.FAntiZeroinStopCq;

      // Quick QSY
      for i := Low(FQuickQSYCheck) to High(FQuickQSYCheck) do begin
         FQuickQSYCheck[i].Checked := dmZLogGlobal.Settings.FQuickQSY[i].FUse;
         if FQuickQSYCheck[i].Checked = True then begin
            FQuickQSYBand[i].ItemIndex := Integer(Settings.FQuickQSY[i].FBand);
            FQuickQSYMode[i].ItemIndex := Integer(Settings.FQuickQSY[i].FMode);
         end
         else begin
            FQuickQSYBand[i].ItemIndex := -1;
            FQuickQSYMode[i].ItemIndex := -1;
         end;
         FQuickQSYRig[i].ItemIndex := Settings.FQuickQSY[i].FRig;

         FQuickQSYBand[i].Enabled := FQuickQSYCheck[i].Checked;
         FQuickQSYMode[i].Enabled := FQuickQSYCheck[i].Checked;
         FQuickQSYRig[i].Enabled  := FQuickQSYCheck[i].Checked;
      end;

      // SuperCheck
      case Settings.FSuperCheck.FSuperCheckMethod of
         0: radioSuperCheck0.Checked := True;
         1: radioSuperCheck1.Checked := True;
         else radioSuperCheck2.Checked := True;
      end;
      checkAcceptDuplicates.Checked := Settings.FSuperCheck.FAcceptDuplicates;
      checkHighlightFullmatch.Checked := Settings.FSuperCheck.FFullMatchHighlight;
      editFullmatchColor.Color := Settings.FSuperCheck.FFullMatchColor;

      // Partial Check
      editPartialCheckColor.Font.Color := Settings.FPartialCheck.FCurrentBandForeColor;
      editPartialCheckColor.Color := Settings.FPartialCheck.FCurrentBandBackColor;

      // Accessibility
      editFocusedColor.Font.Color := Settings.FAccessibility.FFocusedForeColor;
      editFocusedColor.Color := Settings.FAccessibility.FFocusedBackColor;
      checkFocusedBold.Checked := Settings.FAccessibility.FFocusedBold;

      // Band Scope
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
      checkBsCurrent.Checked := Settings._usebandscope_current;
      checkBsNewMulti.Checked := Settings._usebandscope_newmulti;

      for i := 1 to 7 do begin
         FBSColor[i].Font.Color := Settings._bandscopecolor[i].FForeColor;
         FBSColor[i].Color      := Settings._bandscopecolor[i].FBackColor;
         FBSBold[i].Checked     := Settings._bandscopecolor[i].FBold;
      end;
      FBSColor[72].Color      := Settings._bandscopecolor[7].FBackColor2;
      FBSColor[73].Color      := Settings._bandscopecolor[7].FBackColor3;

      // Spot鮮度表示
      case Settings._bandscope_freshness_mode of
         0: radioFreshness1.Checked := True;
         1: radioFreshness2.Checked := True;
         2: radioFreshness3.Checked := True;
         3: radioFreshness4.Checked := True;
         else radioFreshness1.Checked := True;
      end;

      // BandScope Options
      checkUseEstimatedMode.Checked := Settings._bandscope_use_estimated_mode;      // 周波数からのモードの推定
      checkShowOnlyInBandplan.Checked := Settings._bandscope_show_only_in_bandplan; // バンド内のみ
      checkShowOnlyDomestic.Checked := Settings._bandscope_show_only_domestic;      // 国内のみ
      checkUseLookupServer.Checked := Settings._bandscope_use_lookup_server;        // Lookup Server
      checkSetFreqAfterModeChange.Checked := Settings._bandscope_setfreq_after_mode_change;  // モード変更後周波数セット
      checkAlwaysChangeMode.Checked := Settings._bandscope_always_change_mode;      // 常にモード変更
      checkUseEstimatedModeClick(nil);

      // Quick Memo
      for i := 1 to 5 do begin
         FQuickMemoText[i].Text := Settings.FQuickMemoText[i];
      end;

      // Voice Memory
      for i := 1 to maxmessage do begin
         FTempVoiceFiles[i] := Settings.FSoundFiles[i];
         if FTempVoiceFiles[i] = '' then begin
            FVoiceButton[i].Caption := 'select';
         end
         else begin
            FVoiceButton[i].Caption := ExtractFileName(FTempVoiceFiles[i]);
         end;
         FVoiceEdit[i].Text := Settings.FSoundComments[i];
      end;
      for i := 2 to 3 do begin
         FTempAdditionalVoiceFiles[i] := Settings.FAdditionalSoundFiles[i];
         if FTempAdditionalVoiceFiles[i] = '' then begin
            FAdditionalVoiceButton[i].Caption := 'select';
         end
         else begin
            FAdditionalVoiceButton[i].Caption := ExtractFileName(FTempAdditionalVoiceFiles[i]);
         end;
         FAdditionalVoiceEdit[i].Text := Settings.FAdditionalSoundComments[i];
      end;
      comboVoiceDevice.ItemIndex := Settings.FSoundDevice;

      // Font
      comboFontBase.FontName := Settings.FBaseFontName;
   end;

   if FEditMode = 0 then begin   // 通常モード
      tabsheetPreferences.TabVisible := True;
      tabsheetCategories.TabVisible := True;
      tabsheetCW.TabVisible := True;
      tabsheetVoice.TabVisible := True;
      tabsheetHardware.TabVisible := True;
      tabsheetRigControl.TabVisible := True;
      tabsheetPath.TabVisible := True;
      tabsheetMisc.TabVisible := True;
      tabsheetQuickQSY.TabVisible := True;
      tabsheetBandScope1.TabVisible := True;
      tabsheetBandScope2.TabVisible := True;
      tabsheetQuickMemo.TabVisible := True;
   end
   else if FEditMode = 1 then begin // CW
      PageControl.ActivePage := tabsheetCW;

      tabsheetPreferences.TabVisible := False;
      tabsheetCategories.TabVisible := False;
      tabsheetCW.TabVisible := True;
      tabsheetVoice.TabVisible := False;
      tabsheetHardware.TabVisible := False;
      tabsheetRigControl.TabVisible := False;
      tabsheetPath.TabVisible := False;
      tabsheetMisc.TabVisible := False;
      tabsheetQuickQSY.TabVisible := False;
      tabsheetBandScope1.TabVisible := False;
      tabsheetBandScope2.TabVisible := False;
      tabsheetQuickMemo.TabVisible := False;

      if FEditNumber > 0 then begin
         FEditMessage[FEditNumber].SetFocus;
      end;
   end
   else if FEditMode = 2 then begin // Voice
      PageControl.ActivePage := tabsheetVoice;

      tabsheetPreferences.TabVisible := False;
      tabsheetCategories.TabVisible := False;
      tabsheetCW.TabVisible := False;
      tabsheetVoice.TabVisible := True;
      tabsheetHardware.TabVisible := False;
      tabsheetRigControl.TabVisible := False;
      tabsheetPath.TabVisible := False;
      tabsheetMisc.TabVisible := False;
      tabsheetQuickQSY.TabVisible := False;
      tabsheetBandScope1.TabVisible := False;
      tabsheetBandScope2.TabVisible := False;
      tabsheetQuickMemo.TabVisible := False;

      if FEditNumber > 0 then begin
         FVoiceButton[FEditNumber].SetFocus();
      end;
   end;

   FNeedSuperCheckLoad := False;
end;

procedure TformOptions.buttonOpAddClick(Sender: TObject);
var
   F: TformOperatorEdit;
   obj: TOperatorInfo;
begin
   F := TformOperatorEdit.Create(Self);
   try
      if F.ShowModal() <> mrOK then begin
         Exit;
      end;

      obj := TOperatorInfo.Create();
      F.GetObject(obj);

      OpListBox.Items.AddObject(obj.Callsign, obj);
      dmZLogGlobal.OpList.Add(obj);
   finally
      F.Release();
   end;
end;

procedure TformOptions.buttonOpDeleteClick(Sender: TObject);
var
   obj: TOperatorInfo;
   i: Integer;
begin
   if OpListBox.ItemIndex = -1 then begin
      Exit;
   end;
   obj := TOperatorInfo(OpListBox.Items.Objects[OpListBox.ItemIndex]);
   OpListBox.Items.Delete(OpListBox.ItemIndex);
   i := dmZLogGlobal.OpList.IndexOf(obj);
   if i >= 0 then begin
      dmZLogGlobal.OpList.Delete(i);
   end;
end;

procedure TformOptions.FormCreate(Sender: TObject);
var
   i: integer;
   b: TBand;
   m: TMode;
begin
   FQuickQSYCheck[1]    := checkUseQuickQSY01;
   FQuickQSYBand[1]     := comboQuickQsyBand01;
   FQuickQSYMode[1]     := comboQuickQsyMode01;
   FQuickQSYRig[1]      := comboQuickQsyRig01;
   FQuickQSYCheck[2]    := checkUseQuickQSY02;
   FQuickQSYBand[2]     := comboQuickQsyBand02;
   FQuickQSYMode[2]     := comboQuickQsyMode02;
   FQuickQSYRig[2]      := comboQuickQsyRig02;
   FQuickQSYCheck[3]    := checkUseQuickQSY03;
   FQuickQSYBand[3]     := comboQuickQsyBand03;
   FQuickQSYMode[3]     := comboQuickQsyMode03;
   FQuickQSYRig[3]      := comboQuickQsyRig03;
   FQuickQSYCheck[4]    := checkUseQuickQSY04;
   FQuickQSYBand[4]     := comboQuickQsyBand04;
   FQuickQSYMode[4]     := comboQuickQsyMode04;
   FQuickQSYRig[4]      := comboQuickQsyRig04;
   FQuickQSYCheck[5]    := checkUseQuickQSY05;
   FQuickQSYBand[5]     := comboQuickQsyBand05;
   FQuickQSYMode[5]     := comboQuickQsyMode05;
   FQuickQSYRig[5]      := comboQuickQsyRig05;
   FQuickQSYCheck[6]    := checkUseQuickQSY06;
   FQuickQSYBand[6]     := comboQuickQsyBand06;
   FQuickQSYMode[6]     := comboQuickQsyMode06;
   FQuickQSYRig[6]      := comboQuickQsyRig06;
   FQuickQSYCheck[7]    := checkUseQuickQSY07;
   FQuickQSYBand[7]     := comboQuickQsyBand07;
   FQuickQSYMode[7]     := comboQuickQsyMode07;
   FQuickQSYRig[7]      := comboQuickQsyRig07;
   FQuickQSYCheck[8]    := checkUseQuickQSY08;
   FQuickQSYBand[8]     := comboQuickQsyBand08;
   FQuickQSYMode[8]     := comboQuickQsyMode08;
   FQuickQSYRig[8]      := comboQuickQsyRig08;
   for b := Low(MHzString) to High(MHzString) do begin
      FQuickQsyBand[1].Items.Add(MHZString[b]);
   end;
   for m := Low(ModeString) to High(ModeString) do begin
      FQuickQsyMode[1].Items.Add(MODEString[m]);
   end;
   for i := 2 to High(FQuickQsyBand) do begin
      FQuickQsyBand[i].Items.Assign(FQuickQsyBand[1].Items);
      FQuickQsyMode[i].Items.Assign(FQuickQsyMode[1].Items);
   end;

   // BandScope
   FBSColor[1] := editBSColor1;
   FBSColor[2] := editBSColor2;
   FBSColor[3] := editBSColor3;
   FBSColor[4] := editBSColor4;
   FBSColor[5] := editBSColor5;
   FBSColor[6] := editBSColor6;
   FBSColor[7] := editBSColor7;
   FBSColor[72] := editBSColor7_2;
   FBSColor[73] := editBSColor7_3;
   FBSBold[1] := checkBSBold1;
   FBSBold[2] := checkBSBold2;
   FBSBold[3] := checkBSBold3;
   FBSBold[4] := checkBSBold4;
   FBSBold[5] := checkBSBold5;
   FBSBold[6] := checkBSBold6;
   FBSBold[7] := checkBSBold7;

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

   // Voice Memory
   InitVoice();

   TempCurrentBank := 1;

   // OpList
   for i := 0 to dmZlogGlobal.OpList.Count - 1 do begin
      OpListBox.Items.AddObject(dmZlogGlobal.OpList[i].Callsign, dmZlogGlobal.OpList[i]);
   end;

   PageControl.ActivePage := tabsheetPreferences;

   InitRigNames();

   FEditMode := 0;
   FEditNumber := 0;

   FNeedSuperCheckLoad := False;
end;

procedure TformOptions.buttonCancelClick(Sender: TObject);
begin
//   Close;
end;

procedure TformOptions.OpListBoxDblClick(Sender: TObject);
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

procedure TformOptions.SpeedBarChange(Sender: TObject);
begin
   SpeedLabel.Caption := IntToStr(SpeedBar.Position) + ' wpm';
end;

procedure TformOptions.WeightBarChange(Sender: TObject);
begin
   WeightLabel.Caption := IntToStr(WeightBar.Position) + ' %';
end;

procedure TformOptions.FormDestroy(Sender: TObject);
begin
   FVoiceSound.Free();
end;

procedure TformOptions.vButtonClick(Sender: TObject);
begin
   OpenDialog.InitialDir := dmZLogGlobal.SoundPath;
   if OpenDialog.Execute then begin
      FTempVoiceFiles[TButton(Sender).Tag] := OpenDialog.filename;
      TLabel(Sender).Caption := ExtractFileName(OpenDialog.filename);
   end;
end;

procedure TformOptions.vAdditionalButtonClick(Sender: TObject);
begin
   OpenDialog.InitialDir := dmZLogGlobal.SoundPath;
   if OpenDialog.Execute then begin
      FTempAdditionalVoiceFiles[TButton(Sender).Tag] := OpenDialog.filename;
      TLabel(Sender).Caption := ExtractFileName(OpenDialog.filename);
   end;
end;

procedure TformOptions.ClusterComboChange(Sender: TObject);
begin
   buttonClusterSettings.Enabled := True;
   buttonSpotterList.Enabled := True;

   case ClusterCombo.ItemIndex of
      0: begin
         buttonClusterSettings.Enabled := False;
         buttonSpotterList.Enabled := False;
      end;

      1 .. 6: begin
         buttonClusterSettings.Caption := COM_PORT_SETTING;
      end;

      7: begin
         buttonClusterSettings.Caption := TELNET_SETTING;
      end;
   end;
end;

procedure TformOptions.buttonClusterSettingsClick(Sender: TObject);
var
   f: TForm;
begin
   if (ClusterCombo.ItemIndex >= 1) and (ClusterCombo.ItemIndex <= 6) then begin
      f := TformClusterCOMSet.Create(Self);
      try
         TformClusterCOMSet(f).BaudRate  := FTempClusterCom.FBaudRate;
         TformClusterCOMSet(f).LineBreak := FTempClusterCom.FLineBreak;
         TformClusterCOMSet(f).LocalEcho := FTempClusterCom.FLocalEcho;

         if f.ShowModal() <> mrOK then begin
            Exit;
         end;

         FTempClusterCom.FBaudRate  := TformClusterCOMSet(f).BaudRate;
         FTempClusterCom.FLineBreak := TformClusterCOMSet(f).LineBreak;
         FTempClusterCom.FLocalEcho := TformClusterCOMSet(f).LocalEcho;
      finally
         f.Release();
      end;
   end
   else if ClusterCombo.ItemIndex = 7 then begin
      f := TformClusterTelnetSet.Create(Self);
      try
         TformClusterTelnetSet(f).HostName   := FTempClusterTelnet.FHostName;
         TformClusterTelnetSet(f).LineBreak  := FTempClusterTelnet.FLineBreak;
         TformClusterTelnetSet(f).LocalEcho  := FTempClusterTelnet.FLocalEcho;
         TformClusterTelnetSet(f).PortNumber := FTempClusterTelnet.FPortNumber;

         if f.ShowModal() <> mrOK then begin
            Exit;
         end;

         FTempClusterTelnet.FHostName   := TformClusterTelnetSet(f).HostName;
         FTempClusterTelnet.FLineBreak  := TformClusterTelnetSet(f).LineBreak;
         FTempClusterTelnet.FLocalEcho  := TformClusterTelnetSet(f).LocalEcho;
         FTempClusterTelnet.FPortNumber := TformClusterTelnetSet(f).PortNumber;
      finally
         f.Release();
      end;
   end;
end;

procedure TformOptions.ZLinkComboChange(Sender: TObject);
begin
   if ZLinkCombo.ItemIndex = 0 then begin
      buttonZLinkSettings.Enabled := False;
   end
   else begin
      buttonZLinkSettings.Enabled := True;
   end;
end;

procedure TformOptions.buttonZLinkSettingsClick(Sender: TObject);
var
   F: TformZLinkTelnetSet;
begin
   F := TformZLinkTelnetSet.Create(Self);
   try
      F.HostName  := FTempZLinkTelnet.FHostName;
      F.LineBreak := FTempZLinkTelnet.FLineBreak;
      F.LocalEcho := FTempZLinkTelnet.FLocalEcho;

      if F.ShowModal() <> mrOK then begin
         exit;
      end;

      FTempZLinkTelnet.FHostName  := F.HostName;
      FTempZLinkTelnet.FLineBreak := F.LineBreak;
      FTempZLinkTelnet.FLocalEcho := F.LocalEcho;
   finally
      F.Release();
   end;
end;

procedure TformOptions.BrowsePathClick(Sender: TObject);
var
   strDir: string;
begin
   case TButton(Sender).Tag of
      0:
         strDir := editRootFolder.Text;
      10:
         strDir := editCfgDatFolder.Text;
      20:
         strDir := editLogsFolder.Text;
      30:
         strDir := editBackupFolder.Text;
      40:
         strDir := editSoundFolder.Text;
      50:
         strDir := editPluginsFolder.Text;
      60:
         strDir := editSpcFolder.Text;
   end;

   if SelectDirectory(SELECT_FOLDER, '', strDir, [sdNewFolder, sdNewUI, sdValidateDir], Self) = False then begin
      exit;
   end;

   case TButton(Sender).Tag of
      // Root
      0:
         editRootFolder.Text := strDir;

      // CFG/DAT
      10:
         editCfgDatFolder.Text := strDir;

      // Logs
      20:
         editLogsFolder.Text := strDir;

      // Backup
      30:
         editBackupFolder.Text := strDir;

      // Sound(Voice)
      40:
         editSoundFolder.Text := strDir;

      // Plugins
      50:
         editPluginsFolder.Text := strDir;

      // Super Check
      60: begin
         editSpcFolder.Text := strDir;
         FNeedSuperCheckLoad := True;
      end;
   end;
end;

procedure TformOptions.PTTEnabledCheckBoxClick(Sender: TObject);
begin
   if PTTEnabledCheckBox.Checked then begin
      BeforeEdit.Enabled := True;
      AfterEdit.Enabled := True;
   end
   else begin
      BeforeEdit.Enabled := False;
      AfterEdit.Enabled := False;
   end;
end;

procedure TformOptions.radioQsyAssistClick(Sender: TObject);
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
         editQsyCountDownMinute.SetFocus();
      end;

      // QSY Count / hr
      2: begin
         editQsyCountDownMinute.Enabled := False;
         editQsyCountPerHour.Enabled := True;
         editQsyCountPerHour.SetFocus();
      end;
   end;
end;

procedure TformOptions.radioSo2rClick(Sender: TObject);
var
   n: Integer;
begin
   n := TRadioButton(Sender).Tag;
   case n of
      0: begin
         comboSo2rTxSelectPort.Enabled := False;
         comboSo2rRxSelectPort.Enabled := False;
      end;

      1: begin
         comboSo2rTxSelectPort.Enabled := True;
         comboSo2rRxSelectPort.Enabled := True;
      end;

      2: begin
         comboSo2rTxSelectPort.Enabled := False;
         comboSo2rRxSelectPort.Enabled := False;
      end;
   end;
end;

procedure TformOptions.OnNeedSuperCheckLoad(Sender: TObject);
begin
   FNeedSuperCheckLoad := True;
end;

procedure TformOptions.CQRepEditKeyPress(Sender: TObject; var Key: char);
begin
   if (Key < Char(Ord('0'))) then begin
      Exit;
   end;

   if not(SysUtils.CharInSet(Key, ['0' .. '9', '.'])) then begin
      Key := #0;
   end;
end;

procedure TformOptions.editMessage1Change(Sender: TObject);
var
   i: integer;
begin
   i := TEdit(Sender).Tag;
   TempCWStrBank[TempCurrentBank, i] := TEdit(Sender).Text;
end;

procedure TformOptions.CWBankClick(Sender: TObject);
begin
   TempCurrentBank := TRadioButton(Sender).Tag;
   RenewCWStrBankDisp;
end;

procedure TformOptions.cbTransverter1Click(Sender: TObject);
var
   i, r: integer;
   F: TIntegerDialog;
begin
   F := TIntegerDialog.Create(Self);
   try
      r := TCheckBox(Sender).Tag;
      r := r - 100;

      if TCheckBox(Sender).Checked then begin
         i := dmZlogGlobal.Settings.FRigControl[r].FTransverterOffset;

         F.Init(i, PLEASE_INPUT_OFFSET_FREQ);
         if F.ShowModal() <> mrOK then begin
            Exit;
         end;

         i := F.GetValue;
         if i = -1 then begin
            Exit;
         end;

         dmZlogGlobal.Settings.FRigControl[r].FTransverterOffset := i;
      end;
   finally
      F.Release();
   end;
end;

procedure TformOptions.comboCwPttPortChange(Sender: TObject);
var
   Index: Integer;
   rigno: Integer;
begin
   Index := TComboBox(Sender).ItemIndex;
   rigno := TComboBox(Sender).Tag;

   if (Index = 0) or (Index = 21) then begin
      if rigno = 1 then begin
         checkUseWinKeyer.Enabled := False;
         checkUseWinKeyer.Checked := False;
         checkWk9600.Enabled := False;
         checkWkOutportSelect.Enabled := False;
         checkWkIgnoreSpeedPot.Enabled := False;
      end;
   end
   else begin
      checkUseWinKeyer.Enabled := True;
      checkWk9600.Enabled := True;
      checkWkOutportSelect.Enabled := True;
      checkWkIgnoreSpeedPot.Enabled := True;
   end;
end;

procedure TformOptions.comboIcomModeChange(Sender: TObject);
begin
   if comboIcomMode.ItemIndex = 0 then begin
      comboIcomMethod.Enabled := False;
      comboIcomMethod.ItemIndex := 0;
   end
   else begin
      comboIcomMethod.Enabled := True;
   end;
end;

procedure TformOptions.comboRig1NameChange(Sender: TObject);
begin
   if comboRig1Name.ItemIndex = comboRig1Name.Items.Count - 1 then begin
      comboRig2Name.ItemIndex := comboRig2Name.Items.Count - 1;
      comboRig1Port.ItemIndex := 0;
      comboRig1Port.Enabled := False;
      comboRig1Speed.Enabled := False;
      comboRig2Port.Enabled := False;
      comboRig2Speed.Enabled := False;
   end
   else begin
      comboRig1Port.Enabled := True;
      comboRig1Speed.Enabled := True;
      if comboRig2Name.ItemIndex = comboRig2Name.Items.Count - 1 then begin
         comboRig2Name.ItemIndex := 0;
         comboRig2Port.ItemIndex := 0;
         comboRig2Port.Enabled := True;
         comboRig2Speed.Enabled := True;
      end;
   end;
end;

procedure TformOptions.comboRig2NameChange(Sender: TObject);
begin
   if comboRig2Name.ItemIndex = comboRig2Name.Items.Count - 1 then begin
      comboRig1Name.ItemIndex := comboRig1Name.Items.Count - 1;
      comboRig2Port.ItemIndex := 0;
      comboRig2Port.Enabled := False;
      comboRig2Speed.Enabled := False;
      comboRig1Port.Enabled := False;
      comboRig1Speed.Enabled := False;
   end
   else begin
      comboRig2Port.Enabled := True;
      comboRig2Speed.Enabled := True;
      if comboRig1Name.ItemIndex = comboRig1Name.Items.Count - 1 then begin
         comboRig1Name.ItemIndex := 0;
         comboRig1Port.ItemIndex := 0;
         comboRig1Port.Enabled := True;
         comboRig1Speed.Enabled := True;
      end;
   end;
end;

procedure TformOptions.checkUseEstimatedModeClick(Sender: TObject);
var
   f: Boolean;
begin
   f := checkUseEstimatedMode.Checked;
   checkAlwaysChangeMode.Enabled := f;
   checkSetFreqAfterModeChange.Enabled := f;
end;

procedure TformOptions.checkUseQuickQSYClick(Sender: TObject);
var
   no: Integer;
begin
   no := TCheckBox(Sender).Tag;
   FQuickQSYBand[no].Enabled := FQuickQSYCheck[no].Checked;
   FQuickQSYMode[no].Enabled := FQuickQSYCheck[no].Checked;
   FQuickQSYRig[no].Enabled  := FQuickQSYCheck[no].Checked;
end;

procedure TformOptions.checkUseWinKeyerClick(Sender: TObject);
begin
   if TCheckBox(Sender).Checked = True then begin
      comboCwPttPort2.ItemIndex := comboCwPttPort1.ItemIndex;
   end;
end;

procedure TformOptions.InitRigNames();
begin
   comboRig1Name.Items.Clear;
   comboRig2Name.Items.Clear;

   dmZlogGlobal.MakeRigList(comboRig1Name.Items);

   comboRig2Name.Items.Assign(comboRig1Name.Items);
end;

procedure TformOptions.SetEditNumber(no: Integer);
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

procedure TformOptions.buttonFullmatchSelectColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editFullmatchColor.Color;
   if ColorDialog1.Execute = True then begin
      editFullmatchColor.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions.buttonFullmatchInitColorClick(Sender: TObject);
begin
   editFullmatchColor.Color := clYellow;
end;

procedure TformOptions.buttonBSForeClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FBSColor[n].Font.Color;
   if ColorDialog1.Execute = True then begin
      FBSColor[n].Font.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions.buttonBSBackClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FBSColor[n].Color;
   if ColorDialog1.Execute = True then begin
      FBSColor[n].Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions.checkBSBoldClick(Sender: TObject);
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

   if n = 7 then begin
      if TCheckBox(Sender).Checked = True then begin
         FBSColor[72].Font.Style := FBSColor[72].Font.Style + [fsBold];
         FBSColor[73].Font.Style := FBSColor[73].Font.Style + [fsBold];
      end
      else begin
         FBSColor[72].Font.Style := FBSColor[72].Font.Style - [fsBold];
         FBSColor[73].Font.Style := FBSColor[73].Font.Style - [fsBold];
      end;
   end;
end;

procedure TformOptions.buttonBSResetClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   FBSColor[n].Font.Color  := BandScopeDefaultColor[n].FForeColor;
   FBSColor[n].Color       := BandScopeDefaultColor[n].FBackColor;
   FBSBold[n].Checked      := BandScopeDefaultColor[n].FBold;

   if (n = 7) then begin
      FBSColor[72].Color   := BandScopeDefaultColor[7].FBackColor2;
      FBSColor[73].Color   := BandScopeDefaultColor[7].FBackColor3;
   end;
end;

procedure TformOptions.InitVoice();
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
   FAdditionalVoiceEdit[2] := vEdit13;
   FAdditionalVoiceEdit[3] := vEdit14;
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

procedure TformOptions.buttonPartialCheckForeColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editPartialCheckColor.Font.Color;
   if ColorDialog1.Execute = True then begin
      editPartialCheckColor.Font.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions.buttonPartialCheckBackColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editPartialCheckColor.Color;
   if ColorDialog1.Execute = True then begin
      editPartialCheckColor.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions.buttonPartialCheckInitColorClick(Sender: TObject);
begin
   editPartialCheckColor.Font.Color := clFuchsia;
   editPartialCheckColor.Color := clWhite;
end;

procedure TformOptions.buttonFocusedForeColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editFocusedColor.Font.Color;
   if ColorDialog1.Execute = True then begin
      editFocusedColor.Font.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions.buttonFocusedBackColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editFocusedColor.Color;
   if ColorDialog1.Execute = True then begin
      editFocusedColor.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions.buttonFocusedInitColorClick(Sender: TObject);
begin
   editFocusedColor.Font.Color := clBlack;
   editFocusedColor.Color := clWhite;
   checkFocusedBold.Checked := False;
end;

procedure TformOptions.checkFocusedBoldClick(Sender: TObject);
begin
   if checkFocusedBold.Checked = True then begin
      editFocusedColor.Font.Style := editFocusedColor.Font.Style + [fsBold];
   end
   else begin
      editFocusedColor.Font.Style := editFocusedColor.Font.Style - [fsBold];
   end;
end;

procedure TformOptions.buttonPlayVoiceClick(Sender: TObject);
var
   i: Integer;
   n: Integer;
begin
   n := 0;
   try
      for i := 1 to High(FVoiceEdit) do begin
         if (FVoiceEdit[i].Focused = True) or (FVoiceButton[i].Focused = True) then begin
            if FileExists(FTempVoiceFiles[i]) = True then begin
               FVoiceSound.Open(FTempVoiceFiles[i], comboVoiceDevice.ItemIndex);
               FVoiceSound.Play();
               Exit;
            end;
         end;
      end;
      for i := 2 to 3 do begin
         if (FAdditionalVoiceEdit[i].Focused = True) or (FAdditionalVoiceButton[i].Focused = True) then begin
            if FileExists(FTempAdditionalVoiceFiles[i]) = True then begin
               FVoiceSound.Open(FTempAdditionalVoiceFiles[i], comboVoiceDevice.ItemIndex);
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
            FTempVoiceFiles[n] := '';
         end;
      end;
   end;
end;

procedure TformOptions.buttonStopVoiceClick(Sender: TObject);
begin
   FVoiceSound.Stop();
   FVoiceSound.Close();
end;

procedure TformOptions.buttonSpotterListClick(Sender: TObject);
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

end.
