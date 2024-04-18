unit UOptions;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls, Spin, Vcl.Buttons, System.UITypes,
  Dialogs, Menus, FileCtrl, JvExStdCtrls, JvCombobox, JvColorCombo,
  Generics.Collections, Generics.Defaults,
  UIntegerDialog, UzLogConst, UzLogGlobal, UzLogSound, UOperatorEdit, UzLogOperatorInfo;

type
  TformOptions = class(TForm)
    PageControl: TPageControl;
    tabsheetHardware1: TTabSheet;
    tabsheetRigControl: TTabSheet;
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    OpenDialog: TOpenDialog;
    cbRITClear: TCheckBox;
    cbDontAllowSameBand: TCheckBox;
    SendFreqEdit: TEdit;
    Label45: TLabel;
    Label46: TLabel;
    cbRecordRigFreq: TCheckBox;
    tabsheetPath: TTabSheet;
    Label50: TLabel;
    editCfgDatFolder: TEdit;
    buttonBrowseCFGDATPath: TButton;
    Label51: TLabel;
    editLogsFolder: TEdit;
    buttonBrowseLogsPath: TButton;
    cbAutoBandMap: TCheckBox;
    buttonBrowseBackupPath: TButton;
    editBackupFolder: TEdit;
    Label56: TLabel;
    ColorDialog1: TColorDialog;
    Label74: TLabel;
    buttonBrowseSoundPath: TButton;
    editSoundFolder: TEdit;
    Label90: TLabel;
    buttonBrowsePluginPath: TButton;
    editPluginsFolder: TEdit;
    groupUsif4cw: TGroupBox;
    checkUsbif4cwSyncWpm: TCheckBox;
    groupRcMagicalCalling: TGroupBox;
    checkUseAntiZeroin: TCheckBox;
    editMaxShift: TEdit;
    Label28: TLabel;
    Label29: TLabel;
    updownAntiZeroinShiftMax: TUpDown;
    checkAntiZeroinAutoCancel: TCheckBox;
    updownSendFreqInterval: TUpDown;
    checkAntiZeroinStopCq: TCheckBox;
    GroupBox17: TGroupBox;
    GroupBox18: TGroupBox;
    checkAntiZeroinRitOff: TCheckBox;
    checkAntiZeroinXitOff: TCheckBox;
    checkAntiZeroinRitClear: TCheckBox;
    checkAntiZeroinXitOn1: TCheckBox;
    checkAntiZeroinXitOn2: TCheckBox;
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
    groupRig5: TGroupBox;
    Label99: TLabel;
    comboRig5Keying: TComboBox;
    tabsheetFont: TTabSheet;
    GroupBox21: TGroupBox;
    comboFontBase: TJvFontComboBox;
    Label102: TLabel;
    Label103: TLabel;
    tabsheetHardware3: TTabSheet;
    groupOptCI_V: TGroupBox;
    Label83: TLabel;
    Label84: TLabel;
    comboIcomMode: TComboBox;
    comboIcomMethod: TComboBox;
    groupOptCwPtt: TGroupBox;
    Label38: TLabel;
    Label39: TLabel;
    PTTEnabledCheckBox: TCheckBox;
    BeforeEdit: TEdit;
    AfterEdit: TEdit;
    groupWinKeyer: TGroupBox;
    checkUseWinKeyer: TCheckBox;
    checkWk9600: TCheckBox;
    checkWkOutportSelect: TCheckBox;
    checkWkIgnoreSpeedPot: TCheckBox;
    groupRig1: TGroupBox;
    Label43: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    comboRig1Name: TComboBox;
    comboRig1Control: TComboBox;
    comboRig1Speed: TComboBox;
    comboRig1Keying: TComboBox;
    checkRig1Xvt: TCheckBox;
    groupRig2: TGroupBox;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    checkRig2Xvt: TCheckBox;
    comboRig2Name: TComboBox;
    comboRig2Control: TComboBox;
    comboRig2Speed: TComboBox;
    comboRig2Keying: TComboBox;
    groupRig3: TGroupBox;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    checkRig3Xvt: TCheckBox;
    comboRig3Name: TComboBox;
    comboRig3Control: TComboBox;
    comboRig3Speed: TComboBox;
    comboRig3Keying: TComboBox;
    groupRig4: TGroupBox;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    checkRig4Xvt: TCheckBox;
    comboRig4Name: TComboBox;
    comboRig4Control: TComboBox;
    comboRig4Speed: TComboBox;
    comboRig4Keying: TComboBox;
    tabsheetHardware2: TTabSheet;
    groupRigSetA: TGroupBox;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    comboRigA_b19: TComboBox;
    comboRigA_b35: TComboBox;
    comboRigA_b7: TComboBox;
    comboRigA_b10: TComboBox;
    comboRigA_b14: TComboBox;
    comboRigA_b18: TComboBox;
    comboRigA_b21: TComboBox;
    comboRigA_b24: TComboBox;
    comboRigA_b28: TComboBox;
    comboRigA_b50: TComboBox;
    comboRigA_b144: TComboBox;
    comboRigA_b430: TComboBox;
    comboRigA_b1200: TComboBox;
    comboRigA_b2400: TComboBox;
    comboRigA_b5600: TComboBox;
    comboRigA_b10g: TComboBox;
    groupRigSetB: TGroupBox;
    Label144: TLabel;
    Label145: TLabel;
    Label146: TLabel;
    Label147: TLabel;
    Label148: TLabel;
    Label149: TLabel;
    Label150: TLabel;
    Label151: TLabel;
    Label152: TLabel;
    Label153: TLabel;
    Label154: TLabel;
    Label155: TLabel;
    Label156: TLabel;
    Label157: TLabel;
    Label158: TLabel;
    Label159: TLabel;
    comboRigB_b19: TComboBox;
    comboRigB_b35: TComboBox;
    comboRigB_b7: TComboBox;
    comboRigB_b10: TComboBox;
    comboRigB_b14: TComboBox;
    comboRigB_b18: TComboBox;
    comboRigB_b21: TComboBox;
    comboRigB_b24: TComboBox;
    comboRigB_b28: TComboBox;
    comboRigB_b50: TComboBox;
    comboRigB_b144: TComboBox;
    comboRigB_b430: TComboBox;
    comboRigB_b1200: TComboBox;
    comboRigB_b2400: TComboBox;
    comboRigB_b5600: TComboBox;
    comboRigB_b10g: TComboBox;
    comboRigA_Antb19: TComboBox;
    comboRigA_Antb35: TComboBox;
    comboRigA_Antb7: TComboBox;
    comboRigA_Antb10: TComboBox;
    comboRigA_Antb14: TComboBox;
    comboRigA_Antb18: TComboBox;
    comboRigA_Antb21: TComboBox;
    comboRigA_Antb24: TComboBox;
    comboRigA_Antb28: TComboBox;
    comboRigA_Antb50: TComboBox;
    comboRigA_Antb144: TComboBox;
    comboRigA_Antb430: TComboBox;
    comboRigA_Antb1200: TComboBox;
    comboRigA_Antb2400: TComboBox;
    comboRigA_Antb5600: TComboBox;
    comboRigA_Antb10g: TComboBox;
    comboRigB_Antb19: TComboBox;
    comboRigB_Antb35: TComboBox;
    comboRigB_Antb7: TComboBox;
    comboRigB_Antb10: TComboBox;
    comboRigB_Antb14: TComboBox;
    comboRigB_Antb18: TComboBox;
    comboRigB_Antb21: TComboBox;
    comboRigB_Antb24: TComboBox;
    comboRigB_Antb28: TComboBox;
    comboRigB_Antb50: TComboBox;
    comboRigB_Antb144: TComboBox;
    comboRigB_Antb430: TComboBox;
    comboRigB_Antb1200: TComboBox;
    comboRigB_Antb2400: TComboBox;
    comboRigB_Antb5600: TComboBox;
    comboRigB_Antb10g: TComboBox;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    buttonSpotterList: TButton;
    editRootFolder: TEdit;
    buttonBrowseRootFolder: TButton;
    buttonBrowseSpcPath: TButton;
    editSpcFolder: TEdit;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    editIcomResponseTimout: TEdit;
    checkGen3MicSelect: TCheckBox;
    checkIgnoreRigMode: TCheckBox;
    checkTurnoffSleep: TCheckBox;
    checkTurnonResume: TCheckBox;
    checkUsbif4cwUsePaddle: TCheckBox;
    buttonRig1PortConfig: TButton;
    buttonPortConfigCW1: TButton;
    buttonPortConfigCW2: TButton;
    buttonRig2PortConfig: TButton;
    buttonPortConfigCW3: TButton;
    buttonRig3PortConfig: TButton;
    buttonPortConfigCW4: TButton;
    buttonRig4PortConfig: TButton;
    buttonPortConfigCW5: TButton;
    buttonXvtConfig1: TButton;
    buttonXvtConfig2: TButton;
    buttonXvtConfig3: TButton;
    buttonXvtConfig4: TButton;
    checkRig1ChangePTT: TCheckBox;
    checkRig2ChangePTT: TCheckBox;
    checkRig3ChangePTT: TCheckBox;
    checkRig4ChangePTT: TCheckBox;
    tabsheetOperateStyle: TTabSheet;
    groupSo2rSupport: TGroupBox;
    Label115: TLabel;
    Label116: TLabel;
    GroupBox7: TGroupBox;
    GroupBox6: TGroupBox;
    Label31: TLabel;
    Label42: TLabel;
    comboSo2rRxSelectPort: TComboBox;
    comboSo2rTxSelectPort: TComboBox;
    radioSo2rNeo: TRadioButton;
    radioSo2rNone: TRadioButton;
    radioSo2rCom: TRadioButton;
    groupSo2rCqOption: TGroupBox;
    Label44: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    editSo2rCqRptIntervalSec: TEdit;
    panelSo2rMessageNumber: TPanel;
    radioSo2rCqMsgBankA: TRadioButton;
    radioSo2rCqMsgBankB: TRadioButton;
    comboSo2rCqMsgNumber: TComboBox;
    editSo2rRigSwAfterDelay: TEdit;
    spinSo2rAccelerateCW: TSpinEdit;
    GroupBox1: TGroupBox;
    radio1Radio: TRadioButton;
    radio2Radio: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    checkWkAlways9600: TCheckBox;
    groupRcSleepMode: TGroupBox;
    groupRcGeneral: TGroupBox;
    groupRcMemoryScan: TGroupBox;
    editMemScanInterval: TEdit;
    updownMemScanInterval: TUpDown;
    Label4: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    comboSo2rTxRigC: TComboBox;
    checkSo2rIgnoreModeChange: TCheckBox;
    checkUsePttCommand: TCheckBox;
    checkRigSelectV28: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure ClusterComboChange(Sender: TObject);
    procedure buttonClusterSettingsClick(Sender: TObject);
    procedure ZLinkComboChange(Sender: TObject);
    procedure buttonZLinkSettingsClick(Sender: TObject);
    procedure BrowsePathClick(Sender: TObject);
    procedure PTTEnabledCheckBoxClick(Sender: TObject);
    procedure checkRig1AXvtClick(Sender: TObject);
    procedure comboRig1NameChange(Sender: TObject);
    procedure comboRig3NameChange(Sender: TObject);
    procedure comboIcomModeChange(Sender: TObject);
    procedure comboCwPttPortChange(Sender: TObject);
    procedure checkUseWinKeyerClick(Sender: TObject);
    procedure radioSo2rClick(Sender: TObject);
    procedure comboRigA_b19Change(Sender: TObject);
    procedure comboRigA_Antb19Change(Sender: TObject);
    procedure comboRigB_b19Change(Sender: TObject);
    procedure comboRigB_Antb19Change(Sender: TObject);
    procedure buttonSpotterListClick(Sender: TObject);
    procedure buttonPortConfigRigClick(Sender: TObject);
    procedure buttonPortConfigCWClick(Sender: TObject);
    procedure buttonXvtConfigClick(Sender: TObject);
    procedure checkRigXvtClick(Sender: TObject);
    procedure comboRigControlChange(Sender: TObject);
    procedure NumberEditKeyPress(Sender: TObject; var Key: Char);
    procedure radio1RadioClick(Sender: TObject);
    procedure radio2RadioClick(Sender: TObject);
  private
//    FEditMode: Integer;
//    FEditNumber: Integer;
//    FActiveTab: Integer;

    FTempClusterTelnet: TCommParam;
    FTempClusterCom: TCommParam;
    FTempZLinkTelnet: TCommParam;

    FNeedSuperCheckLoad: Boolean;

    FRigSetA_rig: array[b19..b10g] of TComboBox;
    FRigSetA_ant: array[b19..b10g] of TComboBox;
    FRigSetB_rig: array[b19..b10g] of TComboBox;
    FRigSetB_ant: array[b19..b10g] of TComboBox;

    FRigConfig: array[1..5] of TGroupBox;
    FRigControlPort: array[1..5] of TComboBox;
    FRigControlPortConfig: array[1..5] of TButton;
    FRigControlSpeed: array[1..5] of TComboBox;
    FRigName: array[1..5] of TComboBox;
    FKeyingPort: array[1..5] of TComboBox;
    FKeyingPortConfig: array[1..5] of TButton;
    FRigXvt: array[1..5] of TCheckBox;
    FRigXvtConfig: array[1..5] of TButton;
    FRigPhoneChgPTT: array[1..5] of TCheckBox;
    procedure InitRigNames();
    function CheckRigSetting(): Boolean;
    procedure EnableRigConfig(Index: Integer; fEnable: Boolean);
    procedure Assign1Radio();
    procedure Assign2Radio();
  public
    procedure RenewSettings();
    procedure ImplementSettings();
  end;

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

  //　RIG-%d の %s はどのバンドにも割り当てされていません. 今すぐ割り当てますか？
  RigIsNotAssignedToAntBand = 'RIG-%d %s is not assigned to any band. Do you want to assign it now?';

  // リグが割り当てられていないバンドがあります. 今すぐ割り当てますか？
  BandsHaveNoRigsAssigned = 'There are bands that have no rigs assigned. Do you want to assign them now?';

implementation

uses
  Main, UzLogCW, UComm, UClusterTelnetSet, UClusterCOMSet, UPortConfigDialog,
  UZlinkTelnetSet, UZLinkForm, URigControl, USpotterListDlg;

{$R *.DFM}

procedure TformOptions.FormCreate(Sender: TObject);
var
   i: integer;
   CP: TCommPort;
   list: TList<TCommPort>;
begin
   FRigConfig[1] := groupRig1;
   FRigConfig[2] := groupRig2;
   FRigConfig[3] := groupRig3;
   FRigConfig[4] := groupRig4;
   FRigConfig[5] := groupRig5;
   FRigControlPort[1] := comboRig1Control;
   FRigControlPort[2] := comboRig2Control;
   FRigControlPort[3] := comboRig3Control;
   FRigControlPort[4] := comboRig4Control;
   FRigControlPort[5] := nil;
   FRigControlPortConfig[1] := buttonRig1PortConfig;
   FRigControlPortConfig[2] := buttonRig2PortConfig;
   FRigControlPortConfig[3] := buttonRig3PortConfig;
   FRigControlPortConfig[4] := buttonRig4PortConfig;
   FRigControlPortConfig[5] := nil;
   FRigControlSpeed[1] := comboRig1Speed;
   FRigControlSpeed[2] := comboRig2Speed;
   FRigControlSpeed[3] := comboRig3Speed;
   FRigControlSpeed[4] := comboRig4Speed;
   FRigControlSpeed[5] := nil;
   FRigName[1] := comboRig1Name;
   FRigName[2] := comboRig2Name;
   FRigName[3] := comboRig3Name;
   FRigName[4] := comboRig4Name;
   FRigName[5] := nil;
   FKeyingPort[1] := comboRig1Keying;
   FKeyingPort[2] := comboRig2Keying;
   FKeyingPort[3] := comboRig3Keying;
   FKeyingPort[4] := comboRig4Keying;
   FKeyingPort[5] := comboRig5Keying;
   FKeyingPortConfig[1] := buttonPortConfigCW1;
   FKeyingPortConfig[2] := buttonPortConfigCW2;
   FKeyingPortConfig[3] := buttonPortConfigCW3;
   FKeyingPortConfig[4] := buttonPortConfigCW4;
   FKeyingPortConfig[5] := buttonPortConfigCW5;
   FRigXvt[1] := checkRig1Xvt;
   FRigXvt[2] := checkRig2Xvt;
   FRigXvt[3] := checkRig3Xvt;
   FRigXvt[4] := checkRig4Xvt;
   FRigXvt[5] := nil;
   FRigXvtConfig[1] := buttonXvtConfig1;
   FRigXvtConfig[2] := buttonXvtConfig2;
   FRigXvtConfig[3] := buttonXvtConfig3;
   FRigXvtConfig[4] := buttonXvtConfig4;
   FRigXvtConfig[5] := nil;
   FRigPhoneChgPTT[1] := checkRig1ChangePTT;
   FRigPhoneChgPTT[2] := checkRig2ChangePTT;
   FRigPhoneChgPTT[3] := checkRig3ChangePTT;
   FRigPhoneChgPTT[4] := checkRig4ChangePTT;
   FRigPhoneChgPTT[5] := nil;

   // Set of RIG
   FRigSetA_rig[b19]    := comboRigA_b19;
   FRigSetA_rig[b35]    := comboRigA_b35;
   FRigSetA_rig[b7]     := comboRigA_b7;
   FRigSetA_rig[b10]    := comboRigA_b10;
   FRigSetA_rig[b14]    := comboRigA_b14;
   FRigSetA_rig[b18]    := comboRigA_b18;
   FRigSetA_rig[b21]    := comboRigA_b21;
   FRigSetA_rig[b24]    := comboRigA_b24;
   FRigSetA_rig[b28]    := comboRigA_b28;
   FRigSetA_rig[b50]    := comboRigA_b50;
   FRigSetA_rig[b144]   := comboRigA_b144;
   FRigSetA_rig[b430]   := comboRigA_b430;
   FRigSetA_rig[b1200]  := comboRigA_b1200;
   FRigSetA_rig[b2400]  := comboRigA_b2400;
   FRigSetA_rig[b5600]  := comboRigA_b5600;
   FRigSetA_rig[b10g]   := comboRigA_b10g;

   FRigSetA_ant[b19]    := comboRigA_Antb19;
   FRigSetA_ant[b35]    := comboRigA_Antb35;
   FRigSetA_ant[b7]     := comboRigA_Antb7;
   FRigSetA_ant[b10]    := comboRigA_Antb10;
   FRigSetA_ant[b14]    := comboRigA_Antb14;
   FRigSetA_ant[b18]    := comboRigA_Antb18;
   FRigSetA_ant[b21]    := comboRigA_Antb21;
   FRigSetA_ant[b24]    := comboRigA_Antb24;
   FRigSetA_ant[b28]    := comboRigA_Antb28;
   FRigSetA_ant[b50]    := comboRigA_Antb50;
   FRigSetA_ant[b144]   := comboRigA_Antb144;
   FRigSetA_ant[b430]   := comboRigA_Antb430;
   FRigSetA_ant[b1200]  := comboRigA_Antb1200;
   FRigSetA_ant[b2400]  := comboRigA_Antb2400;
   FRigSetA_ant[b5600]  := comboRigA_Antb5600;
   FRigSetA_ant[b10g]   := comboRigA_Antb10g;

   FRigSetB_rig[b19]    := comboRigB_b19;
   FRigSetB_rig[b35]    := comboRigB_b35;
   FRigSetB_rig[b7]     := comboRigB_b7;
   FRigSetB_rig[b10]    := comboRigB_b10;
   FRigSetB_rig[b14]    := comboRigB_b14;
   FRigSetB_rig[b18]    := comboRigB_b18;
   FRigSetB_rig[b21]    := comboRigB_b21;
   FRigSetB_rig[b24]    := comboRigB_b24;
   FRigSetB_rig[b28]    := comboRigB_b28;
   FRigSetB_rig[b50]    := comboRigB_b50;
   FRigSetB_rig[b144]   := comboRigB_b144;
   FRigSetB_rig[b430]   := comboRigB_b430;
   FRigSetB_rig[b1200]  := comboRigB_b1200;
   FRigSetB_rig[b2400]  := comboRigB_b2400;
   FRigSetB_rig[b5600]  := comboRigB_b5600;
   FRigSetB_rig[b10g]   := comboRigB_b10g;

   FRigSetB_ant[b19]    := comboRigB_Antb19;
   FRigSetB_ant[b35]    := comboRigB_Antb35;
   FRigSetB_ant[b7]     := comboRigB_Antb7;
   FRigSetB_ant[b10]    := comboRigB_Antb10;
   FRigSetB_ant[b14]    := comboRigB_Antb14;
   FRigSetB_ant[b18]    := comboRigB_Antb18;
   FRigSetB_ant[b21]    := comboRigB_Antb21;
   FRigSetB_ant[b24]    := comboRigB_Antb24;
   FRigSetB_ant[b28]    := comboRigB_Antb28;
   FRigSetB_ant[b50]    := comboRigB_Antb50;
   FRigSetB_ant[b144]   := comboRigB_Antb144;
   FRigSetB_ant[b430]   := comboRigB_Antb430;
   FRigSetB_ant[b1200]  := comboRigB_Antb1200;
   FRigSetB_ant[b2400]  := comboRigB_Antb2400;
   FRigSetB_ant[b5600]  := comboRigB_Antb5600;
   FRigSetB_ant[b10g]   := comboRigB_Antb10g;

   PageControl.ActivePage := tabsheetOperateStyle;

   InitRigNames();

   // CommPorts
   comboRig1Control.Items.Clear();
   comboRig2Control.Items.Clear();
   comboRig3Control.Items.Clear();
   comboRig4Control.Items.Clear();
   comboRig1Keying.Items.Clear();
   comboRig2Keying.Items.Clear();
   comboRig3Keying.Items.Clear();
   comboRig4Keying.Items.Clear();
   comboRig5Keying.Items.Clear();
   comboSo2rTxSelectPort.Items.Clear();
   comboSo2rRxSelectPort.Items.Clear();

   list := dmZLogGlobal.CommPortList;
   for i := 0 to list.Count - 1 do begin
      CP := list[i];
      if CP.RigControl = True then begin
         comboRig1Control.Items.AddObject(CP.Name, CP);
         comboRig2Control.Items.AddObject(CP.Name, CP);
         comboRig3Control.Items.AddObject(CP.Name, CP);
         comboRig4Control.Items.AddObject(CP.Name, CP);
         comboSo2rTxSelectPort.Items.AddObject(CP.Name, CP);
         comboSo2rRxSelectPort.Items.AddObject(CP.Name, CP);
      end;
      if CP.Keying = True then begin
         comboRig1Keying.Items.AddObject(CP.Name, CP);
         comboRig2Keying.Items.AddObject(CP.Name, CP);
         comboRig3Keying.Items.AddObject(CP.Name, CP);
         comboRig4Keying.Items.AddObject(CP.Name, CP);
         comboRig5Keying.Items.AddObject(CP.Name, CP);
      end;
   end;
end;

procedure TformOptions.FormShow(Sender: TObject);
begin
   ImplementSettings();

   if radio1Radio.Checked = True then begin
      radio1RadioClick(radio1Radio);
   end
   else begin
      radio2RadioClick(radio2Radio);
   end;
end;

procedure TformOptions.FormDestroy(Sender: TObject);
begin
//
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

   // RIG設定のチェック
   if CheckRigSetting() = False then begin
      Exit;
   end;

   // 入力された設定を保存
   RenewSettings;

   // 各種フォルダ作成
   dmZLogGlobal.CreateFolders();

   ModalResult := mrOK;
end;

procedure TformOptions.buttonCancelClick(Sender: TObject);
begin
//   Close;
end;

procedure TformOptions.radio1RadioClick(Sender: TObject);
begin
   EnableRigConfig(3, False);
   EnableRigConfig(4, False);
   Assign1Radio();
end;

procedure TformOptions.radio2RadioClick(Sender: TObject);
begin
   EnableRigConfig(3, True);
   EnableRigConfig(4, True);
   Assign2Radio();
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
         comboSo2rTxRigC.Enabled := False;
         checkRigSelectV28.Enabled := False;
      end;

      1: begin
         comboSo2rTxSelectPort.Enabled := True;
         comboSo2rRxSelectPort.Enabled := True;
         comboSo2rTxRigC.Enabled := True;
         checkRigSelectV28.Enabled := True;
      end;

      2: begin
         comboSo2rTxSelectPort.Enabled := False;
         comboSo2rRxSelectPort.Enabled := False;
         comboSo2rTxRigC.Enabled := False;
         checkRigSelectV28.Enabled := False;
      end;
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

procedure TformOptions.checkRig1AXvtClick(Sender: TObject);
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

procedure TformOptions.checkRigXvtClick(Sender: TObject);
var
   r: Integer;
begin
   r := TCheckBox(Sender).Tag;
   FRigXvtConfig[r].Enabled := TCheckBox(Sender).Checked;
end;

procedure TformOptions.comboCwPttPortChange(Sender: TObject);
var
   Index: Integer;
   rigno: Integer;
   combo: TComboBox;
begin
   combo := TComboBox(Sender);
   Index := TCommPort(combo.Items.Objects[combo.ItemIndex]).Number;
   rigno := TComboBox(Sender).Tag;

   if (Index = 0) or (Index = 21) then begin
      if rigno = 1 then begin
         checkUseWinKeyer.Enabled := False;
         checkUseWinKeyer.Checked := False;
         checkWk9600.Enabled := False;
         checkWkOutportSelect.Enabled := False;
         checkWkIgnoreSpeedPot.Enabled := False;
         checkWkAlways9600.Enabled := False;
      end;
      checkUseWinKeyer.Checked := False;
      FKeyingPortConfig[rigno].Enabled := False;
   end
   else begin
      checkUseWinKeyer.Enabled := True;
      checkWk9600.Enabled := True;
      checkWkOutportSelect.Enabled := True;
      checkWkIgnoreSpeedPot.Enabled := True;
      checkWkAlways9600.Enabled := True;
      FKeyingPortConfig[rigno].Enabled := True;
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

procedure TformOptions.comboRigControlChange(Sender: TObject);
var
   r: Integer;
   cp: TCommPort;
   combo: TComboBox;
begin
   combo := TComboBox(Sender);
   r := combo.Tag;
   cp := TCommPort(combo.items.Objects[combo.ItemIndex]);
   if (cp <> nil) and ((cp.Number >= 1) and (cp.Number <= 20)) then begin
      FRigControlPortConfig[r].Enabled := True;
   end
   else begin
      FRigControlPortConfig[r].Enabled := False;
   end;
end;

procedure TformOptions.comboRig1NameChange(Sender: TObject);
begin
   // 選択されているのがOmni-Rigの場合
//   if comboRig1AName.ItemIndex = comboRig1AName.Items.Count - 1 then begin
//      comboRig1BName.ItemIndex := comboRig1BName.Items.Count - 1;
//      comboRig2AName.ItemIndex := comboRig2AName.Items.Count - 1;
//      comboRig2BName.ItemIndex := comboRig2BName.Items.Count - 1;
//      comboRig1AControl.ItemIndex := 0;
//
//      comboRig1AControl.Enabled := False;
//      comboRig1ASpeed.Enabled := False;
//      comboRig1BControl.Enabled := False;
//      comboRig1BSpeed.Enabled := False;
//      comboRig2AControl.Enabled := False;
//      comboRig2ASpeed.Enabled := False;
//      comboRig2BControl.Enabled := False;
//      comboRig2BSpeed.Enabled := False;
//   end
//   else begin
//      comboRig1AControl.Enabled := True;
//      comboRig1ASpeed.Enabled := True;
//      if comboRig2AName.ItemIndex = comboRig2AName.Items.Count - 1 then begin
//         comboRig2AName.ItemIndex := 0;
//         comboRig2AControl.ItemIndex := 0;
//         comboRig2AControl.Enabled := True;
//         comboRig2ASpeed.Enabled := True;
//         comboRig2BControl.Enabled := True;
//         comboRig2BSpeed.Enabled := True;
//      end;
//   end;
end;

procedure TformOptions.comboRig3NameChange(Sender: TObject);
begin
//   if comboRig2AName.ItemIndex = comboRig2AName.Items.Count - 1 then begin
//      comboRig1AName.ItemIndex := comboRig1AName.Items.Count - 1;
//      comboRig2AControl.ItemIndex := 0;
//      comboRig2AControl.Enabled := False;
//      comboRig2ASpeed.Enabled := False;
//      comboRig2BControl.Enabled := False;
//      comboRig2BSpeed.Enabled := False;
//      comboRig1AControl.Enabled := False;
//      comboRig1ASpeed.Enabled := False;
//      comboRig1BControl.Enabled := False;
//      comboRig1BSpeed.Enabled := False;
//   end
//   else begin
//      comboRig2AControl.Enabled := True;
//      comboRig2ASpeed.Enabled := True;
//      if comboRig1AName.ItemIndex = comboRig1AName.Items.Count - 1 then begin
//         comboRig1AName.ItemIndex := 0;
//         comboRig1AControl.ItemIndex := 0;
//         comboRig1AControl.Enabled := True;
//         comboRig1ASpeed.Enabled := True;
//      end;
//   end;
end;

procedure TformOptions.comboRigA_b19Change(Sender: TObject);
var
   b: TBand;
begin
   if Application.MessageBox(PChar(DoYouWantTheFollowingBandsToHaveTheSameSettins), PChar(Application.Title), MB_YESNO or MB_ICONEXCLAMATION) = IDNO then begin
      Exit;
   end;

   for b := TBand(TComboBox(Sender).Tag + 1) to b10g do begin
      FRigSetA_rig[b].ItemIndex := TComboBox(Sender).ItemIndex;
   end;
end;

procedure TformOptions.comboRigA_Antb19Change(Sender: TObject);
var
   b: TBand;
begin
   if Application.MessageBox(PChar(DoYouWantTheFollowingBandsToHaveTheSameSettins), PChar(Application.Title), MB_YESNO or MB_ICONEXCLAMATION) = IDNO then begin
      Exit;
   end;

   for b := TBand(TComboBox(Sender).Tag + 1) to b10g do begin
      FRigSetA_ant[b].ItemIndex := TComboBox(Sender).ItemIndex;
   end;
end;

procedure TformOptions.comboRigB_b19Change(Sender: TObject);
var
   b: TBand;
begin
   if Application.MessageBox(PChar(DoYouWantTheFollowingBandsToHaveTheSameSettins), PChar(Application.Title), MB_YESNO or MB_ICONEXCLAMATION) = IDNO then begin
      Exit;
   end;

   for b := TBand(TComboBox(Sender).Tag + 1) to b10g do begin
      FRigSetB_rig[b].ItemIndex := TComboBox(Sender).ItemIndex;
   end;
end;

procedure TformOptions.comboRigB_Antb19Change(Sender: TObject);
var
   b: TBand;
begin
   if Application.MessageBox(PChar(DoYouWantTheFollowingBandsToHaveTheSameSettins), PChar(Application.Title), MB_YESNO or MB_ICONEXCLAMATION) = IDNO then begin
      Exit;
   end;

   for b := TBand(TComboBox(Sender).Tag + 1) to b10g do begin
      FRigSetB_ant[b].ItemIndex := TComboBox(Sender).ItemIndex;
   end;
end;

procedure TformOptions.checkUseWinKeyerClick(Sender: TObject);
begin
   if TCheckBox(Sender).Checked = True then begin
      comboRig2Keying.ItemIndex := comboRig1Keying.ItemIndex;
      comboRig3Keying.ItemIndex := comboRig1Keying.ItemIndex;
      comboRig4Keying.ItemIndex := comboRig1Keying.ItemIndex;
   end;
end;

procedure TformOptions.InitRigNames();
begin
   comboRig1Name.Items.Clear;
   comboRig2Name.Items.Clear;
   comboRig3Name.Items.Clear;
   comboRig4Name.Items.Clear;

   dmZlogGlobal.MakeRigList(comboRig1Name.Items);

   comboRig2Name.Items.Assign(comboRig1Name.Items);
   comboRig3Name.Items.Assign(comboRig1Name.Items);
   comboRig4Name.Items.Assign(comboRig1Name.Items);
end;

procedure TformOptions.buttonPortConfigCWClick(Sender: TObject);
var
   f: TformPortConfig;
   r: Integer;
begin
   f := TformPortConfig.Create(Self);
   try
      r := TButton(sender).Tag;

      f.PortName := FKeyingPort[r].Text;
      f.PortConfig := dmZLogGlobal.Settings.FRigControl[r].FKeyingPortConfig;

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      dmZLogGlobal.Settings.FRigControl[r].FKeyingPortConfig := f.PortConfig;
   finally
      f.Release();
   end;
end;

procedure TformOptions.buttonPortConfigRigClick(Sender: TObject);
var
   f: TformPortConfig;
   r: Integer;
begin
   f := TformPortConfig.Create(Self);
   try
      r := TButton(sender).Tag;

      f.PortName := FRigControlPort[r].Text;
      f.PortConfig := dmZLogGlobal.Settings.FRigControl[r].FControlPortConfig;

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      dmZLogGlobal.Settings.FRigControl[r].FControlPortConfig := f.PortConfig;
   finally
      f.Release();
   end;
end;

procedure TformOptions.buttonXvtConfigClick(Sender: TObject);
var
   i, r: integer;
   F: TIntegerDialog;
begin
   F := TIntegerDialog.Create(Self);
   try
      r := TButton(Sender).Tag;

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
   finally
      F.Release();
   end;
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

procedure TformOptions.NumberEditKeyPress(Sender: TObject; var Key: char);
begin
   if (Key < Char(Ord('0'))) then begin
      Exit;
   end;

   if not(SysUtils.CharInSet(Key, ['0' .. '9', '.'])) then begin
      Key := #0;
   end;
end;

procedure TformOptions.RenewSettings();
var
   r: double;
   b: TBand;

   procedure SetRigControlParam(no: Integer; C, S, N, K: TComboBox; T: TCheckBox);
   var
      KeyPort: Integer;
   begin
      with dmZLogGlobal do begin
         if Assigned(C) then begin
            Settings.FRigControl[no].FControlPort := TCommPort(C.Items.Objects[C.ItemIndex]).Number;
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
            KeyPort := TCommPort(K.Items.Objects[K.ItemIndex]).Number;
            if (KeyPort >= 1) and (KeyPort <= 22) then begin
               Settings.FRigControl[no].FKeyingPort := KeyPort;
            end
            else begin
               Settings.FRigControl[no].FKeyingPort := 0;
            end;
         end;

         if Assigned(T) then begin
            Settings.FRigControl[no].FUseTransverter := T.Checked;
         end;

         if Assigned(FRigPhoneChgPTT[no]) then begin
            Settings.FRigControl[no].FPhoneChgPTT := FRigPhoneChgPTT[no].Checked;
         end;
      end;
   end;
begin
   with dmZLogGlobal do begin
      //
      // Operate style
      //
      if radio1Radio.Checked = True then begin
         Settings._operate_style := os1Radio;
      end
      else begin
         Settings._operate_style := os2Radio;
      end;

      // SO2R Support
      if radioSo2rNone.Checked = True then begin
         Settings._so2r_type := so2rNone;
      end
      else if radioSo2rCom.Checked = True then begin
         Settings._so2r_type := so2rCom;
      end
      else begin
         Settings._so2r_type := so2rNeo;
      end;

      Settings._so2r_tx_port := TCommPort(comboSo2rTxSelectPort.Items.Objects[comboSo2rTxSelectPort.ItemIndex]).Number;
      Settings._so2r_rx_port := TCommPort(comboSo2rRxSelectPort.Items.Objects[comboSo2rRxSelectPort.ItemIndex]).Number;
      Settings._so2r_tx_rigc := comboSo2rTxRigC.ItemIndex;
      Settings._so2r_rigselect_v28 := checkRigSelectV28.Checked;

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
      Settings._so2r_2bsiq_pluswpm  := spinSo2rAccelerateCW.Value;
      Settings._so2r_ignore_mode_change := checkSo2rIgnoreModeChange.Checked;

      //
      // Hardware1
      //

      // RIG1-5
      SetRigControlParam(1, comboRig1Control, comboRig1Speed, comboRig1Name, comboRig1Keying, checkRig1Xvt);
      SetRigControlParam(2, comboRig2Control, comboRig2Speed, comboRig2Name, comboRig2Keying, checkRig2Xvt);
      SetRigControlParam(3, comboRig3Control, comboRig3Speed, comboRig3Name, comboRig3Keying, checkRig3Xvt);
      SetRigControlParam(4, comboRig4Control, comboRig4Speed, comboRig4Name, comboRig4Keying, checkRig4Xvt);
      SetRigControlParam(5, nil,              nil,            nil,           comboRig5Keying, nil);

      //
      // Hardware2
      //

      // Set of RIG
      for b := b19 to b10g do begin
         Settings.FRigSet[1].FRig[b] := FRigSetA_rig[b].ItemIndex;
         Settings.FRigSet[1].FAnt[b] := FRigSetA_ant[b].ItemIndex;
         Settings.FRigSet[2].FRig[b] := FRigSetB_rig[b].ItemIndex;
         Settings.FRigSet[2].FAnt[b] := FRigSetB_ant[b].ItemIndex;
      end;

      //
      // Hardware3
      //

      // ICOM CI-V options
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

      Settings._icom_response_timeout := StrToIntDef(editIcomResponseTimout.Text, 1000);

      // CW/PTT Control
      Settings._pttenabled := PTTEnabledCheckBox.Checked;
      Settings._pttbefore := StrToIntDef(BeforeEdit.Text, Settings._pttbefore);
      Settings._pttafter := StrToIntDef(AfterEdit.Text, Settings._pttafter);

      // USBIF4CW
      Settings._usbif4cw_sync_wpm := checkUsbif4cwSyncWpm.Checked;
      Settings._usbif4cw_gen3_micsel := checkGen3MicSelect.Checked;
      Settings._usbif4cw_use_paddle_keyer := checkUsbif4cwUsePaddle.Checked;

      // Use Winkeyer
      Settings._use_winkeyer := checkUseWinkeyer.Checked;
      Settings._use_wk_9600 := checkWk9600.Checked;
      Settings._use_wk_outp_select := checkWkOutportSelect.Checked;
      Settings._use_wk_ignore_speed_pot := checkWkIgnoreSpeedPot.Checked;
      Settings._use_wk_always9600 := checkWkAlways9600.Checked;

      //
      // Rig control
      //

      // general
      Settings._ritclear := cbRITClear.Checked;
      Settings._dontallowsameband := cbDontAllowSameBand.Checked;
      Settings._recrigfreq := cbRecordRigFreq.Checked;
      Settings._autobandmap := cbAutoBandMap.Checked;
      Settings._send_freq_interval := updownSendFreqInterval.Position;
      Settings._ignore_rig_mode := checkIgnoreRigMode.Checked;
      Settings._memscan_interval := updownMemScanInterval.Position;
      Settings._use_ptt_command := checkUsePttCommand.Checked;

      // supports sleep mode
      Settings._turnoff_sleep := checkTurnoffSleep.Checked;
      Settings._turnon_resume := checkTurnonResume.Checked;

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

      //
      // Network
      //
      Settings._clusterport := ClusterCombo.ItemIndex;
      Settings._cluster_telnet := FTempClusterTelnet;
      Settings._cluster_com := FTempClusterCom;

      Settings._zlinkport := ZLinkCombo.ItemIndex;
      Settings._pcname := editZLinkPcName.Text;
      Settings._syncserial := checkZLinkSyncSerial.Checked;
      Settings._zlink_telnet := FTempZLinkTelnet;


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


      //
      // Fonts
      //
      Settings.FBaseFontName := comboFontBase.FontName;
   end;
end;

procedure TformOptions.ImplementSettings();
var
   b: TBand;
   i: Integer;

   procedure GetRigControlParam(no: Integer; C, S, N, K: TComboBox; T: TCheckBox);
   var
      i: Integer;
   begin
      with dmZlogGlobal do begin
         if Assigned(C) then begin
            C.ItemIndex := 0;
            for i := 0 to C.Items.Count - 1 do begin
               if TCommPort(C.Items.Objects[i]).Number = Settings.FRigControl[no].FControlPort then begin
                  C.ItemIndex := i;
                  C.OnChange(C);
                  Break;
               end;
            end;
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
            K.ItemIndex := 0;
            for i := 0 to K.Items.Count - 1 do begin
               if TCommPort(K.Items.Objects[i]).Number = Settings.FRigControl[no].FKeyingPort then begin
                  K.ItemIndex := i;
                  K.OnChange(K);
                  Break;
               end;
            end;
         end;

         if Assigned(T) then begin
            T.Checked := Settings.FRigControl[no].FUseTransverter;
            T.OnClick(T);
         end;

         if Assigned(FRigPhoneChgPTT[no]) then begin
            FRigPhoneChgPTT[no].Checked := Settings.FRigControl[no].FPhoneChgPTT;
         end;
      end;
   end;
begin
   with dmZlogGlobal do begin
      //
      // Operate style
      //
      case Settings._operate_style of
         os1Radio: begin
            radio1Radio.Checked := True;
         end;

         os2Radio: begin
            radio2Radio.Checked := True;
         end;

         else begin
            radio1Radio.Checked := True;
         end;
      end;

      // SO2R Support
      case Settings._so2r_type of
         so2rNone: begin
            radioSo2rNone.Checked := True;
            radioSo2rClick(radioSo2rNone);
         end;

         so2rCom: begin
            radioSo2rCom.Checked := True;
            radioSo2rClick(radioSo2rCom);
         end;

         so2rNeo: begin
            radioSo2rNeo.Checked := True;
            radioSo2rClick(radioSo2rNeo);
         end;
      end;

      // TX Selector
      comboSo2rTxSelectPort.ItemIndex := 0;
      for i := 0 to comboSo2rTxSelectPort.Items.Count - 1 do begin
         if TCommPort(comboSo2rTxSelectPort.Items.Objects[i]).Number = Settings._so2r_tx_port then begin
            comboSo2rTxSelectPort.ItemIndex := i;
            Break;
         end;
      end;

      // RX Selector
      comboSo2rRxSelectPort.ItemIndex := 0;
      for i := 0 to comboSo2rRxSelectPort.Items.Count - 1 do begin
         if TCommPort(comboSo2rRxSelectPort.Items.Objects[i]).Number = Settings._so2r_rx_port then begin
            comboSo2rRxSelectPort.ItemIndex := i;
            Break;
         end;
      end;

      comboSo2rTxRigC.ItemIndex := Settings._so2r_tx_rigc;
      checkRigSelectV28.Checked := Settings._so2r_rigselect_v28;

      editSo2rCqRptIntervalSec.Text := FloatToStrF(Settings._so2r_cq_rpt_interval_sec, ffFixed, 3, 1);
      editSo2rRigSwAfterDelay.Text := IntToStr(Settings._so2r_rigsw_after_delay);

      if Settings._so2r_cq_msg_bank = 1 then begin
         radioSo2rCqMsgBankA.Checked := True;
      end
      else begin
         radioSo2rCqMsgBankB.Checked := True;
      end;
      comboSo2rCqMsgNumber.ItemIndex := Settings._so2r_cq_msg_number - 1;

      spinSo2rAccelerateCW.Value:= Settings._so2r_2bsiq_pluswpm;
      checkSo2rIgnoreModeChange.Checked := Settings._so2r_ignore_mode_change;


      //
      // Hardware1
      //

      // RIG1-5
      GetRigControlParam(1, comboRig1Control, comboRig1Speed, comboRig1Name, comboRig1Keying, checkRig1Xvt);
      GetRigControlParam(2, comboRig2Control, comboRig2Speed, comboRig2Name, comboRig2Keying, checkRig2Xvt);
      GetRigControlParam(3, comboRig3Control, comboRig3Speed, comboRig3Name, comboRig3Keying, checkRig3Xvt);
      GetRigControlParam(4, comboRig4Control, comboRig4Speed, comboRig4Name, comboRig4Keying, checkRig4Xvt);
      GetRigControlParam(5, nil,              nil,            nil,           comboRig5Keying, nil);


      //
      // Hardware2
      //

      // Set of RIG
      for b := b19 to b10g do begin
         FRigSetA_rig[b].ItemIndex := Settings.FRigSet[1].FRig[b];
         FRigSetA_ant[b].ItemIndex := Settings.FRigSet[1].FAnt[b];
         FRigSetB_rig[b].ItemIndex := Settings.FRigSet[2].FRig[b];
         FRigSetB_ant[b].ItemIndex := Settings.FRigSet[2].FAnt[b];
      end;

      //
      // Hardware3
      //

      // ICOM CI-V options
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

      editIcomResponseTimout.Text := IntToStr(Settings._icom_response_timeout);

      // CW/PTT control
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

      // USBIF4CW
      checkUsbif4cwSyncWpm.Checked := Settings._usbif4cw_sync_wpm;
      checkGen3MicSelect.Checked := Settings._usbif4cw_gen3_micsel;
      checkUsbif4cwUsePaddle.Checked := Settings._usbif4cw_use_paddle_keyer;

      // Use Winkeyer
      checkUseWinkeyer.Checked := Settings._use_winkeyer;
      checkWk9600.Checked := Settings._use_wk_9600;
      checkWkOutportSelect.Checked := Settings._use_wk_outp_select;
      checkWkIgnoreSpeedPot.Checked := Settings._use_wk_ignore_speed_pot;
      checkWkAlways9600.Checked := Settings._use_wk_always9600;

      //
      // Rig control
      //

      // general
      cbRITClear.Checked := Settings._ritclear;
      cbDontAllowSameBand.Checked := Settings._dontallowsameband;
      cbRecordRigFreq.Checked := Settings._recrigfreq;
      cbAutoBandMap.Checked := Settings._autobandmap;
      updownSendFreqInterval.Position := Settings._send_freq_interval;
      checkIgnoreRigMode.Checked := Settings._ignore_rig_mode;
      updownMemScanInterval.Position := Settings._memscan_interval;
      checkUsePttCommand.Checked := Settings._use_ptt_command;

      // supports sleep mode
      checkTurnoffSleep.Checked := Settings._turnoff_sleep;
      checkTurnonResume.Checked := Settings._turnon_resume;

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

      //
      // Network
      //
      FTempClusterTelnet := Settings._cluster_telnet;
      FTempClusterCom := Settings._cluster_com;
      ClusterCombo.ItemIndex := Settings._clusterport;

      FTempZLinkTelnet := Settings._zlink_telnet;
      ZLinkCombo.ItemIndex := Settings._zlinkport;
      editZLinkPcName.Text := Settings._pcname;
      checkZLinkSyncSerial.Checked := Settings._syncserial;

      // Packet Cluster通信設定ボタン
      buttonClusterSettings.Enabled := True;
      ClusterComboChange(nil);

      // ZLink通信設定ボタン
      buttonZLinkSettings.Enabled := True;
      ZLinkComboChange(nil);

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

      //
      // Fonts
      //
      comboFontBase.FontName := Settings.FBaseFontName;
   end;
end;

function TformOptions.CheckRigSetting(): Boolean;
var
   text: string;
   rigno: Integer;
   band: TBand;
   rig_a_assign: Integer;
   rig_b_assign: Integer;
   rig_a_noassign: Integer;
   rig_b_noassign: Integer;
begin
   // 1Radio時はRIG-1/2のみ使用可
   if radio1Radio.Checked = True then begin
      FRigControlPort[3].ItemIndex := 0;
      FRigControlPort[4].ItemIndex := 0;
      Result := True;
      Exit;
   end;

   // リグ設定が無いのに割当がある場合は消去する
   for rigno := 1 to 4 do begin
      if (FRigControlPort[rigno].ItemIndex = 0) or (FRigName[rigno].ItemIndex = 0) then begin
         // RIG-Aでの使用あり？
         for band := Low(FRigSetA_rig) to High(FRigSetA_rig) do begin
            //
            if FRigSetA_rig[band].ItemIndex = rigno then begin
               FRigSetA_rig[band].ItemIndex := 0;
            end;
         end;

         // RIG-Bでの使用あり？
         for band := Low(FRigSetB_rig) to High(FRigSetB_rig) do begin
            if FRigSetB_rig[band].ItemIndex = rigno then begin
               FRigSetB_rig[band].ItemIndex := 0;
            end;
         end;
      end;
   end;

   // 各RIGに割当バンドがあるかチェック
   for rigno := 1 to 4 do begin
      // RIG使用有無
      rig_a_assign := 0;
      rig_b_assign := 0;
      if (FRigControlPort[rigno].ItemIndex > 0) and (FRigName[rigno].ItemIndex > 0) then begin
         // RIG-Aでの使用あり？
         for band := Low(FRigSetA_rig) to High(FRigSetA_rig) do begin
            //
            if FRigSetA_rig[band].ItemIndex = rigno then begin
               Inc(rig_a_assign);
            end;
         end;

         // RIG-Bでの使用あり？
         for band := Low(FRigSetB_rig) to High(FRigSetB_rig) do begin
            if FRigSetB_rig[band].ItemIndex = rigno then begin
               Inc(rig_b_assign);
            end;
         end;

         // 割当が無かった
         if (rig_a_assign = 0) and (rig_b_assign = 0) then begin
            text := Format(RigIsNotAssignedToAntBand, [rigno, FRigName[rigno].Items[FRigName[rigno].ItemIndex]]);
            if Application.MessageBox(PChar(text), PChar(Application.Title), MB_YESNO or MB_ICONEXCLAMATION) = IDYES then begin
               PageControl.ActivePage := tabsheetHardware2;
               Result := False;
               Exit;
            end;
         end;
      end;
   end;

   // RIG割当なしのバンド確認
   rig_a_noassign := 0;
   rig_b_noassign := 0;
   for band := Low(FRigSetA_rig) to High(FRigSetA_rig) do begin
      // RIG-A
      if FRigSetA_rig[band].ItemIndex = 0 then begin
         Inc(rig_a_noassign);
      end;

      // RIG-B
      if FRigSetB_rig[band].ItemIndex = 0 then begin
         Inc(rig_b_noassign);
      end;
   end;

   if (rig_a_noassign > 0) or (rig_b_noassign > 0) then begin
      if Application.MessageBox(PChar(BandsHaveNoRigsAssigned), PChar(Application.Title), MB_YESNO or MB_ICONEXCLAMATION) = IDYES then begin
         PageControl.ActivePage := tabsheetHardware2;
         Result := False;
         Exit;
      end;
   end;

   Result := True;
end;

procedure TformOptions.EnableRigConfig(Index: Integer; fEnable: Boolean);
begin
   if FRigControlPort[Index] <> nil then begin
      FRigControlPort[Index].Enabled := fEnable;

      if fEnable = False then begin
         FRigControlPort[Index].ItemIndex := 0;
      end;
   end;

   if FRigControlPortConfig[Index] <> nil then begin
      FRigControlPortConfig[Index].Enabled := fEnable;
   end;

   if FRigControlSpeed[Index] <> nil then begin
      FRigControlSpeed[Index].Enabled := fEnable;
   end;

   if FRigName[Index] <> nil then begin
      FRigName[Index].Enabled := fEnable;
   end;

   if FKeyingPort[Index] <> nil then begin
      FKeyingPort[Index].Enabled := fEnable;
   end;

   if FKeyingPortConfig[Index] <> nil then begin
      FKeyingPortConfig[Index].Enabled := fEnable;
   end;

   if FRigXvt[Index] <> nil then begin
      FRigXvt[Index].Enabled := fEnable;
   end;

   if FRigXvtConfig[Index] <> nil then begin
      FRigXvtConfig[Index].Enabled := fEnable;
   end;

   if FRigPhoneChgPTT[Index] <> nil then begin
      FRigPhoneChgPTT[Index].Enabled := fEnable;
   end;

   FRigConfig[Index].Enabled := fEnable;
end;

procedure TformOptions.Assign1Radio();
var
   b: TBand;
begin
   for b := b19 to b10g do begin
      FRigSetA_rig[b].ItemIndex := 1;
      FRigSetA_rig[b].Enabled := False;
      FRigSetB_rig[b].ItemIndex := 2;
      FRigSetB_rig[b].Enabled := False;
   end;
end;

procedure TformOptions.Assign2Radio();
var
   b: TBand;
begin
   for b := b19 to b10g do begin
      FRigSetA_rig[b].Enabled := True;
      FRigSetB_rig[b].Enabled := True;
   end;
end;

end.
