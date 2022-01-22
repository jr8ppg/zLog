unit Main;

{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StrUtils,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, Grids,
  ShlObj, ComObj, System.Actions, Vcl.ActnList, System.IniFiles, System.Math,
  System.DateUtils,
  UzLogGlobal, UBasicMulti, UBasicScore, UALLJAMulti,
  UOptions, UEditDialog, UGeneralMulti2,
  UzLogCW, Hemibtn, ShellAPI, UITypes, UzLogKeyer,
  OEdit, URigControl, UConsolePad, URenewThread, USpotClass,
  UMMTTY, UTTYConsole, UELogJarl1, UELogJarl2, UQuickRef, UZAnalyze,
  UPartials, URateDialog, URateDialogEx, USuperCheck, USuperCheck2, UComm, UCWKeyBoard, UChat,
  UZServerInquiry, UZLinkForm, USpotForm, UFreqList, UCheckCall2,
  UCheckMulti, UCheckCountry, UScratchSheet, UBandScope2, HelperLib,
  UWWMulti, UWWScore, UWWZone, UARRLWMulti, UQTCForm, UzLogQSO, UzLogConst, UzLogSpc,
  UCwMessagePad, UNRDialog, UVoiceForm, UzLogOperatorInfo, UFunctionKeyPanel,
  UQsyInfo, UserDefinedContest, UPluginManager, UQsoEdit, USo2rNeoCp, UInformation;

const
  WM_ZLOG_INIT = (WM_USER + 100);
  WM_ZLOG_SETGRIDCOL = (WM_USER + 101);
  WM_ZLOG_SPCDATALOADED = (WM_USER + 102);

type
  TEditPanel = record
    SerialEdit: TEdit;        // 0
    TimeEdit: TOvrEdit;       // 1
    DateEdit: TOvrEdit;       // 1
    CallsignEdit: TOvrEdit;   // 2
    rcvdRSTEdit: TEdit;       // 3
    rcvdNumber: TOvrEdit;     // 4
    ModeEdit: TEdit;          // 5
    PowerEdit: TEdit;         // 6
    BandEdit: TEdit;          // 7
    PointEdit: TEdit;         // 8
    OpEdit: TEdit;            // 9
    MemoEdit: TOvrEdit;       // 10
    NewMulti1Edit: TEdit;     // 11
    NewMulti2Edit: TEdit;     // 12
    CurrentBand: TBand;
    CurrentMode: TMode;
  end;
  TEditPanelArray = array[0..2] of TEditPanel;

  TWanted = class
    Multi : string;
    Bands : set of TBand;
    constructor Create;
  end;

  TContest = class
  protected
    FNeedCtyDat: Boolean;
    FUseCoeff: Boolean;
  private
    procedure SelectPowerCode();
  public
    WantedList : TList;

    MultiForm: TBasicMulti;
    ScoreForm: TBasicScore;
    PastEditForm: TEditDialog;
    ZoneForm: TWWZone;

    Name : string;
    SameExchange : Boolean; // true by default. false when serial number etc
    MultiFound : Boolean; // used in spacebarproc

    SentStr: string;

    constructor Create(N : string); virtual;
    destructor Destroy; override;
    procedure PostWanted(S : string);
    procedure DelWanted(S : string);
    procedure ClearWanted;
    function QTHString(aQSO: TQSO) : string; virtual;
    procedure LogQSO(var aQSO : TQSO; Local : Boolean); virtual;
    procedure ShowScore; virtual;
    procedure ShowMulti; virtual;
    procedure Renew; virtual;
    {procedure LoadFromFile(FileName : string); virtual; }
    procedure EditCurrentRow; virtual;
    procedure ChangePower; virtual;
    procedure DispExchangeOnOtherBands; virtual;
    procedure SpaceBarProc; virtual; {called when space is pressed when Callsign Edit
                                      is in focus AND the callsign is not DUPE}
    procedure SetNrSent(var aQSO : TQSO); virtual;
    procedure SetPoints(var aQSO : TQSO); virtual; {Sets QSO.points according to band/mode}
                                                {called from ChangeBand/ChangeMode}
    procedure SetBand(B : TBand); virtual; {JA0}
    procedure WriteSummary(filename : string); // creates summary file
    function CheckWinSummary(aQSO : TQSO) : string; virtual; // returns summary for checkcall etc.
    function ADIF_ExchangeRX_FieldName : string; virtual;
    function ADIF_ExchangeRX(aQSO : TQSO) : string; virtual;
    function ADIF_ExtraFieldName : string; virtual;
    function ADIF_ExtraField(aQSO : TQSO) : string; virtual;
    procedure ADIF_Export(FileName : string);

    property NeedCtyDat: Boolean read FNeedCtyDat;
    property UseCoeff: Boolean read FUseCoeff;
  end;

  TPedi = class(TContest)
    constructor Create(N : string); override;
  end;

  TALLJAContest = class(TContest)
    constructor Create(N : string); override;
    function QTHString(aQSO: TQSO): string; override;
    procedure DispExchangeOnOtherBands; override;
    function CheckWinSummary(aQSO : TQSO) : string; override;
  end;

  TKCJContest = class(TContest)
    constructor Create(N : string); override;
    function QTHString(aQSO: TQSO): string; override;
    //procedure DispExchangeOnOtherBands; override;
    function CheckWinSummary(aQSO : TQSO) : string; override;
  end;

  TACAGContest = class(TContest)
    constructor Create(N : string); override;
    procedure DispExchangeOnOtherBands; override;
  end;

  TFDContest = class(TContest)
    constructor Create(N : string); override;
    function QTHString(aQSO: TQSO): string; override;
    procedure DispExchangeOnOtherBands; override;
  end;

  TSixDownContest = class(TContest)
    constructor Create(N : string); override;
    function QTHString(aQSO: TQSO): string; override;
    procedure DispExchangeOnOtherBands; override;
  end;

  TGeneralContest = class(TContest)
    FConfig: TUserDefinedContest;
  public
    constructor Create(N, CFGFileName: string); reintroduce;
    destructor Destroy(); override;
    procedure SetPoints(var aQSO : TQSO); override;
  end;

  TCQWPXContest = class(TContest)
    constructor Create(N : string); override;
    function ADIF_ExtraFieldName : string; override;
    function ADIF_ExtraField(aQSO : TQSO) : string; override;
  end;

  TWAEContest = class(TContest)
    QTCForm: TQTCForm;
    constructor Create(N : string); override;
    destructor Destroy(); override;
    procedure SpaceBarProc; override;
  end;

  TIOTAContest = class(TContest)
    constructor Create(N : string); override;
    function QTHString(aQSO: TQSO): string; override;
    procedure SpaceBarProc; override;
  end;

  TARRL10Contest = class(TContest)
    constructor Create(N : string); override;
    function CheckWinSummary(aQSO : TQSO) : string; override;
  end;

  TJA0Contest = class(TContest)
    constructor Create(N : string); override;
    procedure SetBand(B : TBand); override;
    procedure Renew; override;
  end;

  TJA0ContestZero = class(TJA0Contest)
    constructor Create(N : string); override;
  end;

  TAPSprint = class(TContest)
    constructor Create(N : string); override;
  end;

  TCQWWContest = class(TContest)
    constructor Create(N : string; fJIDX: Boolean = False); reintroduce;
    procedure SpaceBarProc; override;
    procedure ShowMulti; override;
    function CheckWinSummary(aQSO : TQSO) : string; override;
    function ADIF_ExchangeRX_FieldName : string; override;
  end;

  TIARUContest = class(TContest)
    constructor Create(N : string); override;
    //function CheckWinSummary(aQSO : TQSO) : string; override;
    procedure SpaceBarProc; override;
    function ADIF_ExchangeRX_FieldName : string; override;
  end;

  TJIDXContest = class(TCQWWContest)
    constructor Create(N : string); overload;
    procedure SetPoints(var aQSO : TQSO); override;
  end;

  TJIDXContestDX = class(TContest)
    constructor Create(N : string); override;
    procedure SetPoints(var aQSO : TQSO); override;
  end;

  TARRLDXContestDX = class(TContest)
    constructor Create(N : string); override;
    function ADIF_ExchangeRX_FieldName : string; override;
  end;

  TARRLDXContestW = class(TContest)
    constructor Create(N : string); override;
    procedure SpaceBarProc; override;
    function ADIF_ExchangeRX_FieldName : string; override;
  end;

  TAllAsianContest = class(TContest)
    constructor Create(N : string); override;
    procedure SetPoints(var aQSO : TQSO); override;
    procedure SpaceBarProc; override;
    function ADIF_ExchangeRX_FieldName : string; override;
  end;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    FilePrintItem: TMenuItem;
    FilePrintSetupItem: TMenuItem;
    FileExitItem: TMenuItem;
    StatusLine: TStatusBar;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Grid: TStringGrid;
    BandMenu: TPopupMenu;
    N19MHz: TMenuItem;
    N35MHz: TMenuItem;
    N7MHz: TMenuItem;
    N14MHz: TMenuItem;
    N21MHz: TMenuItem;
    N28MHz: TMenuItem;
    N50MHz: TMenuItem;
    N144MHz: TMenuItem;
    N430MHz: TMenuItem;
    N1200MHz: TMenuItem;
    N2400MHz: TMenuItem;
    N5600MHz: TMenuItem;
    ModeMenu: TPopupMenu;
    CW1: TMenuItem;
    SSB1: TMenuItem;
    FM1: TMenuItem;
    AM1: TMenuItem;
    RTTY1: TMenuItem;
    Other1: TMenuItem;
    GridMenu: TPopupMenu;
    EditQSO: TMenuItem;
    DeleteQSO1: TMenuItem;
    MainToolBar: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    PartialCheckButton: TSpeedButton;
    ScoreButton: TSpeedButton;
    MultiButton: TSpeedButton;
    RateButton: TSpeedButton;
    CWToolBar: TPanel;
    LogButton: TSpeedButton;
    EditPanel1R: TPanel;
    RcvdRSTEdit1: TEdit;
    BandEdit1: TEdit;
    ModeEdit1: TEdit;
    PointEdit1: TEdit;
    OpEdit1: TEdit;
    OptionsButton: TSpeedButton;
    OpMenu: TPopupMenu;
    SuperCheckButtpn: TSpeedButton;
    CWStopButton: TSpeedButton;
    CWPauseButton: TSpeedButton;
    buttonCwKeyboard: TSpeedButton;
    SpeedBar: TTrackBar;
    SpeedLabel: TLabel;
    Button1: TButton;
    CWPlayButton: TSpeedButton;
    Timer1: TTimer;
    InsertQSO1: TMenuItem;
    N10GHzup1: TMenuItem;
    Export1: TMenuItem;
    TXTSaveDialog: TSaveDialog;
    SerialEdit1: TEdit;
    PacketClusterButton: TSpeedButton;
    CWF1: THemisphereButton;
    CWF2: THemisphereButton;
    CWF3: THemisphereButton;
    CWF4: THemisphereButton;
    CWF5: THemisphereButton;
    CWF6: THemisphereButton;
    CWF7: THemisphereButton;
    CWF8: THemisphereButton;
    CWCQ1: THemisphereButton;
    CWCQ2: THemisphereButton;
    CWCQ3: THemisphereButton;
    Windows1: TMenuItem;
    Help1: TMenuItem;
    menuAbout: TMenuItem;
    HelpZyLO: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    HowtoUseHelp1: TMenuItem;
    SearchforHelpOn1: TMenuItem;
    Contents1: TMenuItem;
    Score1: TMenuItem;
    Multipliers1: TMenuItem;
    QSOrate1: TMenuItem;
    PacketCluster1: TMenuItem;
    SuperCheck1: TMenuItem;
    PartialCheck1: TMenuItem;
    GBand: TMenuItem;
    Changemode: TMenuItem;
    GOperator: TMenuItem;
    G1R9MHz: TMenuItem;
    G3R5MHz: TMenuItem;
    G7MHz: TMenuItem;
    G14MHz: TMenuItem;
    G21MHz: TMenuItem;
    G28MHz: TMenuItem;
    G50MHz: TMenuItem;
    G144MHz: TMenuItem;
    G430MHz: TMenuItem;
    G1200MHz: TMenuItem;
    G2400MHz: TMenuItem;
    G5600MHz: TMenuItem;
    G10GHz: TMenuItem;
    ZLinkmonitor1: TMenuItem;
    menuOptions: TMenuItem;
    CWFMenu: TPopupMenu;
    Edit1: TMenuItem;
    N10MHz1: TMenuItem;
    N18MHz1: TMenuItem;
    N24MHz1: TMenuItem;
    Backup1: TMenuItem;
    CWKeyboard1: TMenuItem;
    ZServer1: TMenuItem;
    Network1: TMenuItem;
    mnDownload: TMenuItem;
    mnMerge: TMenuItem;
    ConnecttoZServer1: TMenuItem;
    N6: TMenuItem;
    G10MHz: TMenuItem;
    G18MHz: TMenuItem;
    G24MHz: TMenuItem;
    CW2: TMenuItem;
    SSB2: TMenuItem;
    FM2: TMenuItem;
    AM2: TMenuItem;
    RTTY2: TMenuItem;
    Other2: TMenuItem;
    Clear1: TMenuItem;
    SendSpot1: TMenuItem;
    PowerEdit1: TEdit;
    NewPowerMenu: TPopupMenu;
    P1: TMenuItem;
    L1: TMenuItem;
    M1: TMenuItem;
    H1: TMenuItem;
    CheckCall1: TMenuItem;
    CreateDupeCheckSheetZPRINT1: TMenuItem;
    View1: TMenuItem;
    ShowCurrentBandOnly: TMenuItem;
    SortbyTime1: TMenuItem;
    CallsignEdit1: TOvrEdit;
    NumberEdit1: TOvrEdit;
    MemoEdit1: TOvrEdit;
    TimeEdit1: TOvrEdit;
    DateEdit1: TOvrEdit;
    ZServerIcon: TImage;
    PrintLogSummaryzLog1: TMenuItem;
    GeneralSaveDialog: TSaveDialog;
    mPXListWPX: TMenuItem;
    mSummaryFile: TMenuItem;
    mChangePower: TMenuItem;
    H2: TMenuItem;
    M2: TMenuItem;
    L2: TMenuItem;
    P2: TMenuItem;
    RigControl1: TMenuItem;
    Console1: TMenuItem;
    MergeFile1: TMenuItem;
    RunningFrequencies1: TMenuItem;
    mnCheckCountry: TMenuItem;
    mnCheckMulti: TMenuItem;
    SSBToolBar: TPanel;
    VoiceStopButton: TSpeedButton;
    VoicePauseButton: TSpeedButton;
    buttonVoiceOption: TSpeedButton;
    VoicePlayButton: TSpeedButton;
    VoiceF1: THemisphereButton;
    VoiceF3: THemisphereButton;
    VoiceF2: THemisphereButton;
    VoiceF4: THemisphereButton;
    VoiceF5: THemisphereButton;
    VoiceF6: THemisphereButton;
    VoiceF7: THemisphereButton;
    VoiceF8: THemisphereButton;
    VoiceCQ1: THemisphereButton;
    VoiceCQ2: THemisphereButton;
    VoiceCQ3: THemisphereButton;
    Bandscope1: TMenuItem;
    mnChangeTXNr: TMenuItem;
    mnGridAddNewPX: TMenuItem;
    mnHideCWPhToolBar: TMenuItem;
    mnHideMenuToolbar: TMenuItem;
    Scratchsheet1: TMenuItem;
    OpenDialog1: TOpenDialog;
    IncreaseFontSize1: TMenuItem;
    mnMMTTY: TMenuItem;
    mnTTYConsole: TMenuItem;
    menuQuickReference: TMenuItem;
    CreateELogJARL1: TMenuItem;
    CreateELogJARL2: TMenuItem;
    ActionList1: TActionList;
    actionQuickQSY01: TAction;
    actionQuickQSY02: TAction;
    actionQuickQSY03: TAction;
    actionQuickQSY04: TAction;
    actionQuickQSY05: TAction;
    actionQuickQSY06: TAction;
    actionQuickQSY07: TAction;
    actionQuickQSY08: TAction;
    actionPlayMessageA01: TAction;
    actionPlayMessageA02: TAction;
    actionPlayMessageA03: TAction;
    actionPlayMessageA04: TAction;
    actionPlayMessageA05: TAction;
    actionPlayMessageA06: TAction;
    actionPlayMessageA07: TAction;
    actionPlayMessageA08: TAction;
    actionPlayMessageB01: TAction;
    actionPlayMessageB02: TAction;
    actionPlayMessageB03: TAction;
    actionPlayMessageB04: TAction;
    actionPlayMessageB05: TAction;
    actionPlayMessageB06: TAction;
    actionPlayMessageB07: TAction;
    actionPlayMessageB08: TAction;
    actionPlayMessageA11: TAction;
    actionPlayMessageA12: TAction;
    actionPlayMessageB11: TAction;
    actionPlayMessageB12: TAction;
    actionCheckMulti: TAction;
    actionShowCheckPartial: TAction;
    actionInsertBandScope: TAction;
    actionInsertBandScope2: TAction;
    actionInsertBandScope3: TAction;
    DecreaseFontSize1: TMenuItem;
    actionIncreaseFontSize: TAction;
    actionDecreaseFontSize: TAction;
    menuAnalyze: TMenuItem;
    actionPageUp: TAction;
    actionPageDown: TAction;
    actionMoveTop: TAction;
    actionMoveLeft: TAction;
    actionMoveRight: TAction;
    actionMoveLast: TAction;
    actionDeleteOneChar: TAction;
    actionPullQso: TAction;
    actionDeleteLeftOneChar: TAction;
    actionGetPartialCheck: TAction;
    actionDeleteRight: TAction;
    actionClearCallAndRpt: TAction;
    actionShowCurrentBandOnly: TAction;
    actionIncreaseTime: TAction;
    actionDecreaseTime: TAction;
    actionQTC: TAction;
    actionReversePaddle: TAction;
    actionPushQso: TAction;
    actionFieldClear: TAction;
    actionCQRepeat: TAction;
    actionCwTune: TAction;
    actionShowSuperCheck: TAction;
    actionShowZlinkMonitor: TAction;
    actionBackup: TAction;
    actionFocusCallsign: TAction;
    actionFocusMemo: TAction;
    actionFocusNumber: TAction;
    actionFocusOp: TAction;
    actionShowCWKeyboard: TAction;
    actionShowPacketCluster: TAction;
    actionShowConsolePad: TAction;
    actionFocusRst: TAction;
    actionShowScratchSheet: TAction;
    actionShowRigControl: TAction;
    actoinClearCallAndNumAftFocus: TAction;
    actionShowZServerChat: TAction;
    actionToggleRig: TAction;
    actionShowTeletypeConsole: TAction;
    actionShowBandScope: TAction;
    actionShowFreqList: TAction;
    actionShowAnalyze: TAction;
    actionShowScore: TAction;
    actionShowMultipliers: TAction;
    actionShowQsoRate: TAction;
    actionShowCheckCall: TAction;
    actionShowCheckMulti: TAction;
    actionShowCheckCountry: TAction;
    actionQsoStart: TAction;
    actionQsoComplete: TAction;
    actionNop: TAction;
    actionRegNewPrefix: TAction;
    actionControlPTT: TAction;
    actionShowSuperCheck2: TAction;
    N11: TMenuItem;
    actionGetSuperCheck2: TAction;
    SPCMenu: TPopupMenu;
    actionChangeBand: TAction;
    actionChangeMode: TAction;
    actionChangePower: TAction;
    actionChangeCwBank: TAction;
    actionChangeR: TAction;
    actionChangeS: TAction;
    actionSetCurTime: TAction;
    actionDecreaseCwSpeed: TAction;
    actionIncreaseCwSpeed: TAction;
    actionCQRepeat2: TAction;
    actionToggleVFO: TAction;
    actionEditLastQSO: TAction;
    actionQuickMemo1: TAction;
    actionQuickMemo2: TAction;
    actionCwMessagePad: TAction;
    CWMessagePad1: TMenuItem;
    actionCorrectSentNr: TAction;
    actionSetLastFreq: TAction;
    menuCorrectNR: TMenuItem;
    N2: TMenuItem;
    actionQuickMemo3: TAction;
    actionQuickMemo4: TAction;
    actionQuickMemo5: TAction;
    actionPlayMessageA09: TAction;
    actionPlayMessageA10: TAction;
    actionPlayMessageB09: TAction;
    actionPlayMessageB10: TAction;
    CWF9: THemisphereButton;
    CWF10: THemisphereButton;
    VoiceF9: THemisphereButton;
    VoiceF10: THemisphereButton;
    VoiceFMenu: TPopupMenu;
    menuVoiceEdit: TMenuItem;
    actionCQAbort: TAction;
    CWF11: THemisphereButton;
    CWF12: THemisphereButton;
    VoiceF11: THemisphereButton;
    VoiceF12: THemisphereButton;
    actionPlayCQA2: TAction;
    actionPlayCQA3: TAction;
    actionPlayCQB1: TAction;
    actionPlayCQB3: TAction;
    actionPlayCQA1: TAction;
    actionPlayCQB2: TAction;
    panelCQMode: TPanel;
    actionToggleCqSp: TAction;
    SideToneButton: TSpeedButton;
    actionCQRepeatIntervalUp: TAction;
    actionCQRepeatIntervalDown: TAction;
    actionSetCQMessage1: TAction;
    actionSetCQMessage2: TAction;
    actionSetCQMessage3: TAction;
    actionToggleRit: TAction;
    actionToggleXit: TAction;
    actionRitClear: TAction;
    actionToggleAntiZeroin: TAction;
    actionAntiZeroin: TAction;
    actionFunctionKeyPanel: TAction;
    menuShowFunctionKeyPanel: TMenuItem;
    menuBandPlanSettings: TMenuItem;
    menuQSORateSettings: TMenuItem;
    menuSettings: TMenuItem;
    actionShowQsoRateEx: TAction;
    QSORateEx1: TMenuItem;
    menuTargetEditor: TMenuItem;
    actionShowQsyInfo: TAction;
    menuShowQSYInfo: TMenuItem;
    menuPluginManager: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    EditPanel2R: TPanel;
    RcvdRSTEdit2A: TEdit;
    BandEdit2A: TEdit;
    ModeEdit2A: TEdit;
    CallsignEdit2A: TOvrEdit;
    NumberEdit2A: TOvrEdit;
    TimeEdit2: TOvrEdit;
    DateEdit2: TOvrEdit;
    RigPanelA: TPanel;
    RigPanelShape2A: TShape;
    RigPanelB: TPanel;
    RigPanelShape2B: TShape;
    CallsignEdit2B: TOvrEdit;
    NumberEdit2B: TOvrEdit;
    RcvdRSTEdit2B: TEdit;
    BandEdit2B: TEdit;
    ModeEdit2B: TEdit;
    SerialEdit2A: TEdit;
    SerialEdit2B: TEdit;
    RigPanelC: TPanel;
    RigPanelShape2C: TShape;
    CallsignEdit2C: TOvrEdit;
    NumberEdit2C: TOvrEdit;
    RcvdRSTEdit2C: TEdit;
    BandEdit2C: TEdit;
    ModeEdit2C: TEdit;
    SerialEdit2C: TEdit;
    actionShowSo2rNeoCp: TAction;
    actionSo2rNeoSelRx1: TAction;
    actionSo2rNeoSelRx2: TAction;
    actionSo2rNeoSelRxBoth: TAction;
    menuShowSO2RNeoCp: TMenuItem;
    actionSelectRig1: TAction;
    actionSelectRig2: TAction;
    actionSelectRig3: TAction;
    actionSo2rNeoCanRxSel: TAction;
    actionShowInformation: TAction;
    menuShowInformation: TMenuItem;
    actionToggleAutoRigSwitch: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ShowHint(Sender: TObject);
    procedure FileNew(Sender: TObject);
    procedure FileOpen(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure FileSaveAs(Sender: TObject);
    procedure FilePrint(Sender: TObject);
    procedure FilePrintSetup(Sender: TObject);
    procedure FileExit(Sender: TObject);
    procedure HelpContents(Sender: TObject);
    procedure HelpSearch(Sender: TObject);
    procedure HelpHowToUse(Sender: TObject);
    procedure HelpAbout(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure CallsignEdit1Change(Sender: TObject);
    procedure NumberEdit1Change(Sender: TObject);
    procedure BandMenuClick(Sender: TObject);
    procedure BandEdit1Click(Sender: TObject);
    procedure ModeMenuClick(Sender: TObject);
    procedure MemoEdit1Change(Sender: TObject);
    procedure ModeEdit1Click(Sender: TObject);
    procedure GridMenuPopup(Sender: TObject);
    procedure DeleteQSO1Click(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditQSOClick(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridDblClick(Sender: TObject);
    procedure CallsignEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LogButtonClick(Sender: TObject);
    procedure OptionsButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CWFButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedBarChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CWStopButtonClick(Sender: TObject);
    procedure VoiceStopButtonClick(Sender: TObject);
    procedure SetCQ(CQ : Boolean);
    function  IsCQ(): Boolean;
    procedure CQRepeatClick1(Sender: TObject);
    procedure CQRepeatClick2(Sender: TObject);
    procedure buttonCwKeyboardClick(Sender: TObject);
    procedure buttonVoiceOptionClick(Sender: TObject);
    procedure OpMenuClick(Sender: TObject);
    procedure CWPauseButtonClick(Sender: TObject);
    procedure CWPlayButtonClick(Sender: TObject);
    procedure RcvdRSTEdit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure InsertQSO1Click(Sender: TObject);
    procedure VoiceFButtonClick(Sender: TObject);
    procedure TimeEdit1Change(Sender: TObject);
    procedure Export1Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SerialEdit1Change(Sender: TObject);
    procedure GridBandChangeClick(Sender: TObject);
    procedure Load1Click(Sender: TObject);
    procedure SortbyTime1Click(Sender: TObject);
    procedure menuAboutClick(Sender: TObject);
    procedure HelpZyLOClick(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure TimeEdit1DblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure menuOptionsClick(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure CWFMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditEnter(Sender: TObject);
    procedure mnMergeClick(Sender: TObject);
    procedure ConnecttoZServer1Click(Sender: TObject);
    procedure GridModeChangeClick(Sender: TObject);
    procedure GridOperatorClick(Sender: TObject);
    procedure SendSpot1Click(Sender: TObject);
    procedure NumberEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NewPowerMenuClick(Sender: TObject);
    procedure PowerEdit1Click(Sender: TObject);
    procedure OpEdit1Click(Sender: TObject);
    procedure GridClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CreateDupeCheckSheetZPRINT1Click(Sender: TObject);
    procedure MemoHotKeyEnter(Sender: TObject);
    procedure GridTopLeftChanged(Sender: TObject);
    procedure TXTSaveDialogTypeChange(Sender: TObject);
    procedure GridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StatusLineResize(Sender: TObject);
    procedure PrintLogSummaryzLog1Click(Sender: TObject);
    procedure VoiceCQ3Click(Sender: TObject);
    procedure VoiceCQ2Click(Sender: TObject);
    procedure mPXListWPXClick(Sender: TObject);
    procedure mSummaryFileClick(Sender: TObject);
    procedure GridPowerChangeClick(Sender: TObject);
    procedure MergeFile1Click(Sender: TObject);
    procedure StatusLineDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure mnChangeTXNrClick(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure mnGridAddNewPXClick(Sender: TObject);
    procedure GridSelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
    procedure GridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure GridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure mnHideCWPhToolBarClick(Sender: TObject);
    procedure mnHideMenuToolbarClick(Sender: TObject);
    procedure mnMMTTYClick(Sender: TObject);
    procedure SwitchCWBank(Action : Integer);
    procedure menuQuickReferenceClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure CreateELogJARL1Click(Sender: TObject);
    procedure CreateELogJARL2Click(Sender: TObject);

    procedure OnZLogInit( var Message: TMessage ); message WM_ZLOG_INIT;
    procedure OnZLogSetGridCol( var Message: TMessage ); message WM_ZLOG_SETGRIDCOL;
    procedure OnZLogSpcDataLoaded( var Message: TMessage ); message WM_ZLOG_SPCDATALOADED;
    procedure actionQuickQSYExecute(Sender: TObject);
    procedure actionPlayMessageAExecute(Sender: TObject);
    procedure actionPlayMessageBExecute(Sender: TObject);
    procedure actionCheckMultiExecute(Sender: TObject);
    procedure actionShowCheckPartialExecute(Sender: TObject);
    procedure actionInsertBandScopeExecute(Sender: TObject);
    procedure actionInsertBandScope3Execute(Sender: TObject);
    procedure actionIncreaseFontSizeExecute(Sender: TObject);
    procedure actionDecreaseFontSizeExecute(Sender: TObject);
    procedure actionPageUpExecute(Sender: TObject);
    procedure actionPageDownExecute(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure actionMoveTopExecute(Sender: TObject);
    procedure actionMoveLeftExecute(Sender: TObject);
    procedure actionDeleteOneCharExecute(Sender: TObject);
    procedure actionMoveRightExecute(Sender: TObject);
    procedure actionMoveLastExecute(Sender: TObject);
    procedure actionPullQsoExecute(Sender: TObject);
    procedure actionDeleteLeftOneCharExecute(Sender: TObject);
    procedure actionGetPartialCheckExecute(Sender: TObject);
    procedure actionDeleteRightExecute(Sender: TObject);
    procedure actionClearCallAndRptExecute(Sender: TObject);
    procedure actionShowCurrentBandOnlyExecute(Sender: TObject);
    procedure actionDecreaseTimeExecute(Sender: TObject);
    procedure actionIncreaseTimeExecute(Sender: TObject);
    procedure actionQTCExecute(Sender: TObject);
    procedure actionReversePaddleExecute(Sender: TObject);
    procedure actionPushQsoExecute(Sender: TObject);
    procedure actionFieldClearExecute(Sender: TObject);
    procedure actionCQRepeatExecute(Sender: TObject);
    procedure actionCwTuneExecute(Sender: TObject);
    procedure actionShowSuperCheckExecute(Sender: TObject);
    procedure actionShowZlinkMonitorExecute(Sender: TObject);
    procedure actionBackupExecute(Sender: TObject);
    procedure actionFocusCallsignExecute(Sender: TObject);
    procedure actionFocusMemoExecute(Sender: TObject);
    procedure actionFocusNumberExecute(Sender: TObject);
    procedure actionFocusOpExecute(Sender: TObject);
    procedure actionShowCWKeyboardExecute(Sender: TObject);
    procedure actionShowPacketClusterExecute(Sender: TObject);
    procedure actionShowConsolePadExecute(Sender: TObject);
    procedure actionFocusRstExecute(Sender: TObject);
    procedure actionShowScratchSheetExecute(Sender: TObject);
    procedure actionShowRigControlExecute(Sender: TObject);
    procedure actoinClearCallAndNumAftFocusExecute(Sender: TObject);
    procedure actionShowZServerChatExecute(Sender: TObject);
    procedure actionToggleRigExecute(Sender: TObject);
    procedure actionShowTeletypeConsoleExecute(Sender: TObject);
    procedure actionShowBandScopeExecute(Sender: TObject);
    procedure actionShowFreqListExecute(Sender: TObject);
    procedure actionShowAnalyzeExecute(Sender: TObject);
    procedure actionShowScoreExecute(Sender: TObject);
    procedure actionShowMultipliersExecute(Sender: TObject);
    procedure actionShowQsoRateExecute(Sender: TObject);
    procedure actionShowCheckCallExecute(Sender: TObject);
    procedure actionShowCheckMultiExecute(Sender: TObject);
    procedure actionShowCheckCountryExecute(Sender: TObject);
    procedure actionQsoStartExecute(Sender: TObject);
    procedure actionQsoCompleteExecute(Sender: TObject);
    procedure EditExit(Sender: TObject);
    procedure actionNopExecute(Sender: TObject);
    procedure actionRegNewPrefixExecute(Sender: TObject);
    procedure actionControlPTTExecute(Sender: TObject);
    procedure actionShowSuperCheck2Execute(Sender: TObject);
    procedure actionGetSuperCheck2Execute(Sender: TObject);
    procedure actionChangeBandExecute(Sender: TObject);
    procedure actionChangeModeExecute(Sender: TObject);
    procedure actionChangePowerExecute(Sender: TObject);
    procedure actionChangeCwBankExecute(Sender: TObject);
    procedure actionChangeRExecute(Sender: TObject);
    procedure actionChangeSExecute(Sender: TObject);
    procedure actionSetCurTimeExecute(Sender: TObject);
    procedure actionDecreaseCwSpeedExecute(Sender: TObject);
    procedure actionIncreaseCwSpeedExecute(Sender: TObject);
    procedure actionCQRepeat2Execute(Sender: TObject);
    procedure actionToggleVFOExecute(Sender: TObject);
    procedure actionEditLastQSOExecute(Sender: TObject);
    procedure actionQuickMemo1Execute(Sender: TObject);
    procedure actionQuickMemo2Execute(Sender: TObject);
    procedure actionCwMessagePadExecute(Sender: TObject);
    procedure actionCorrectSentNrExecute(Sender: TObject);
    procedure actionSetLastFreqExecute(Sender: TObject);
    procedure actionQuickMemo3Execute(Sender: TObject);
    procedure menuVoiceEditClick(Sender: TObject);
    procedure VoiceFMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actionCQAbortExecute(Sender: TObject);
    procedure GridEnter(Sender: TObject);
    procedure GridExit(Sender: TObject);
    procedure actionToggleCqSpExecute(Sender: TObject);
    procedure SideToneButtonClick(Sender: TObject);
    procedure actionCQRepeatIntervalUpExecute(Sender: TObject);
    procedure actionCQRepeatIntervalDownExecute(Sender: TObject);
    procedure actionSetCQMessageExecute(Sender: TObject);
    procedure panelCQModeClick(Sender: TObject);
    procedure actionToggleRitExecute(Sender: TObject);
    procedure actionToggleXitExecute(Sender: TObject);
    procedure actionRitClearExecute(Sender: TObject);
    procedure actionToggleAntiZeroinExecute(Sender: TObject);
    procedure actionAntiZeroinExecute(Sender: TObject);
    procedure actionFunctionKeyPanelExecute(Sender: TObject);
    procedure menuBandPlanSettingsClick(Sender: TObject);
    procedure menuQSORateSettingsClick(Sender: TObject);
    procedure actionShowQsoRateExExecute(Sender: TObject);
    procedure menuTargetEditorClick(Sender: TObject);
    procedure actionShowQsyInfoExecute(Sender: TObject);
    procedure menuPluginManagerClick(Sender: TObject);
    procedure actionShowSo2rNeoCpExecute(Sender: TObject);
    procedure actionSo2rNeoSelRxExecute(Sender: TObject);
    procedure actionSelectRigExecute(Sender: TObject);
    procedure actionSo2rNeoCanRxSelExecute(Sender: TObject);
    procedure actionShowInformationExecute(Sender: TObject);
    procedure actionToggleAutoRigSwitchExecute(Sender: TObject);
  private
    FRigControl: TRigControl;
    FPartialCheck: TPartialCheck;
    FRateDialog: TRateDialog;
    FRateDialogEx: TRateDialogEx;
    FSuperCheck: TSuperCheck;
    FSuperCheck2: TSuperCheck2;        // N+1
    FCommForm: TCommForm;
    FCWKeyBoard: TCWKeyBoard;
    FChatForm: TChatForm;
    FZServerInquiry: TZServerInquiry;
    FZLinkForm: TZLinkForm;
    FSpotForm: TSpotForm;
    FConsolePad: TConsolePad;
    FFreqList: TFreqList;
    FCheckCall2: TCheckCall2;
    FCheckMulti: TCheckMulti;
    FCheckCountry: TCheckCountry;
    FScratchSheet: TScratchSheet;
    FBandScopeEx: TBandScopeArray;
    FBandScope: TBandScope2;
    FQuickRef: TQuickRef;              // Quick Reference
    FZAnalyze: TZAnalyze;              // Analyze window
    FCWMessagePad: TCwMessagePad;
    FVoiceForm: TVoiceForm;
    FFunctionKeyPanel: TformFunctionKeyPanel;
    FQsyInfoForm: TformQsyInfo;
    FSo2rNeoCp: TformSo2rNeoCp;
    FInformation: TformInformation;
    FTTYConsole: TTTYConsole;

    FInitialized: Boolean;

    FTempQSOList: TQSOList;
    clStatusLine : TColor;
    OldCallsign, OldNumber : string;
    defaultTextColor : TColor;

    SaveInBackGround: Boolean;
    TabPressed: Boolean;
    TabPressed2: Boolean; // for moving focus to numberedit
    LastTabPress: TDateTime;

    FPostContest: Boolean;

    // Super Check用データ
    FSpcDataLoading: Boolean;
    FSuperChecked: Boolean;
    FSuperCheckList: TSuperList;
    FTwoLetterMatrix: TSuperListTwoLetterMatrix;
    FSpcHitCall: string;
    FSpcHitNumber: integer;
    FSpcFirstDataCall: string;
    FSpcRcvd_Estimate: string;
    FNPlusOneThread: TSuperCheckNPlusOneThread;
    FSuperCheckDataLoadThread: TSuperCheckDataLoadThread;

    // Current CQ Message
    FCurrentCQMessageNo: Integer;

    FQsyFromBS: Boolean;

    // QSY Violation (10 min rule / per hour)
    FQsyViolation: Boolean;

    FCurrentRig: Integer;
    FEditPanel: TEditPanelArray;

    procedure MyIdleEvent(Sender: TObject; var Done: Boolean);
    procedure MyMessageEvent(var Msg: TMsg; var Handled: Boolean);

    procedure DeleteCurrentRow;
    Procedure MultipleDelete(A, B : LongInt);

    procedure InitALLJA();
    procedure Init6D();
    procedure InitFD();
    procedure InitACAG();
    procedure InitALLJA0_JA0(BandGroupIndex: Integer);
    procedure InitALLJA0_Other(BandGroupIndex: Integer);
    procedure InitKCJ();
    procedure InitDxPedi();
    procedure InitUserDefined(ContestName, ConfigFile: string);
    procedure InitCQWW();
    procedure InitWPX(ContestCategory: TContestCategory);
    procedure InitJIDX();
    procedure InitAPSprint();
    procedure InitARRL_W();
    procedure InitARRL_DX();
    procedure InitARRL10m();
    procedure InitIARU();
    procedure InitAllAsianDX();
    procedure InitIOTA();
    procedure InitWAE();
    function GetNumOfAvailableBands(): Integer;
    procedure AdjustActiveBands();
    function GetFirstAvailableBand(defband: TBand): TBand;
    procedure SetWindowCaption();
    procedure RestoreWindowsPos();

    procedure LoadNewContestFromFile(FileName : string);
    procedure RenewCWToolBar;
    procedure RenewVoiceToolBar;
    procedure RenewBandMenu();
    procedure PushQSO(aQSO : TQSO);
    procedure PullQSO;
    procedure OnTabPress;
    procedure DownKeyPress;
    procedure RestoreWindowStates;
    procedure RecordWindowStates;
    procedure SwitchLastQSOBandMode;
    procedure CallsignSentProc(Sender: TObject); // called when callsign is sent;
    procedure Update10MinTimer; //10 min countdown
    procedure SaveFileAndBackUp;
    procedure ChangeTxNr(txnr: Byte);
    procedure IncFontSize();
    procedure DecFontSize();
    procedure SetFontSize(font_size: Integer);
    procedure QSY(b: TBand; m: TMode; r: Integer);
    procedure PlayMessage(bank: Integer; no: Integer);
    procedure PlayMessageCW(bank: Integer; no: Integer);
    procedure PlayMessagePH(no: Integer);
    procedure PlayMessageRTTY(no: Integer);
    procedure OnVoicePlayStarted(Sender: TObject);
    procedure OnVoicePlayFinished(Sender: TObject);
    procedure OnPaddle(Sender: TObject);
    procedure InsertBandScope(fShiftKey: Boolean);
    procedure WriteKeymap();
    procedure ReadKeymap();
    procedure ResetKeymap();
    procedure SetShortcutEnabled(shortcut: string; fEnabled: Boolean);
    procedure CQRepeatProc();

    // Super Check関係
    procedure SuperCheckDataLoad();
    procedure SuperCheckInitData();
    procedure SuperCheckFreeData();
    procedure CheckSuper(aQSO: TQSO);
    procedure CheckSuper2(aQSO: TQSO);
    procedure TerminateNPlusOne();
    procedure TerminateSuperCheckDataLoad();
    procedure OnSPCMenuItemCick(Sender: TObject);

    procedure DoMessageSendFinish(Sender: TObject);
    procedure DoWkAbortProc(Sender: TObject);
    procedure DoWkStatusProc(Sender: TObject; tx: Integer; rx: Integer; ptt: Boolean);
    procedure DoSendRepeatProc(Sender: TObject; nLoopCount: Integer);
    procedure DoCwSpeedChange(Sender: TObject);
    procedure DoVFOChange(Sender: TObject);
    procedure ApplyCQRepeatInterval();
    procedure ShowToggleStatus(text: string; fON: Boolean);
    procedure SetListWidth();
    procedure SelectOperator(O: string);
    procedure SetEditColor(edit: TEdit; fHighlight: Boolean);
    function ScanNextBand(B0: TBand): TBand;
    function ScanPrevBand(B0: TBand): TBand;
    function IsAvailableBand(B: TBand): Boolean;
    function GetCurrentRigID(): Integer;
    function GetCurrentEditPanel(): TEditPanel;

    function GetSerialEdit(): TEdit;      // 0
    function GetDateEdit(): TEdit;        // 1
    function GetTimeEdit(): TEdit;        // 1
    function GetCallsignEdit(): TEdit;    // 2
    function GetRSTEdit(): TEdit;         // 3
    function GetNumberEdit(): TEdit;      // 4
    function GetModeEdit(): TEdit;        // 5
    function GetPowerEdit(): TEdit;       // 6
    function GetBandEdit(): TEdit;        // 7
    function GetPointEdit(): TEdit;       // 8
    function GetOpEdit(): TEdit;          // 9
    function GetMemoEdit(): TEdit;        // 10
    function GetNewMulti1Edit(): TEdit;   // 11
    function GetNewMulti2Edit(): TEdit;   // 12
    procedure InitQsoEditPanel();
    procedure UpdateQsoEditPanel(rig: Integer);
    procedure SwitchRig(rig: Integer);
    procedure ShowCurrentQSO();

    procedure GridAdd(aQSO: TQSO);
    procedure GridWriteQSO(R: Integer; aQSO: TQSO);
    procedure GridClearQSO(R: Integer);
    procedure SetGridWidth(editor: TBasicEdit);
    function GetGridColmunLeft(col: Integer): Integer;
    procedure SetEditFields1R(editor: TBasicEdit);
  public
    EditScreen : TBasicEdit;
    LastFocus : TEdit;
    procedure SetR(var aQSO : TQSO); // RST
    procedure SetS(var aQSO : TQSO);

    function GetNextBand(BB : TBand; Up : Boolean) : TBand;

    procedure GridRefreshScreen(fSelectRow: Boolean = True);

    procedure SetQSOMode(aQSO : TQSO);
    procedure WriteStatusLine(S : string; WriteConsole : Boolean);
    procedure WriteStatusLineRed(S : string; WriteConsole : Boolean);
    procedure ProcessConsoleCommand(S : string);
    procedure UpdateBand(B : TBand); // takes care of window disp
    procedure UpdateMode(M : TMode);
    procedure DisableNetworkMenus;
    procedure EnableNetworkMenus;
    procedure ReEvaluateCountDownTimer;
    procedure ReEvaluateQSYCount;
    procedure AutoInput(D : TBSData);
    procedure ConsoleRigBandSet(B: TBand);

    procedure ShowBandMenu(b: TBand);
    procedure HideBandMenu(b: TBand);
    procedure HideBandMenuHF();
    procedure HideBandMenuWARC();
    procedure HideBandMenuVU(fInclude50: Boolean = True);

    procedure HighlightCallsign(fHighlight: Boolean);
    procedure BandScopeNotifyWorked(aQSO: TQSO);
    procedure SetYourCallsign(strCallsign, strNumber: string);
    procedure SetFrequency(freq: Integer);
    procedure BSRefresh();
    procedure BuildOpListMenu(P: TPopupMenu; OnClickHandler: TNotifyEvent);
    procedure BuildOpListMenu2(P: TMenuItem; OnClickHandler: TNotifyEvent);
    procedure BuildTxNrMenu2(P: TMenuItem; OnClickHandler: TNotifyEvent);

    procedure BandScopeAddSelfSpot(aQSO: TQSO; nFreq: Int64);
    procedure BandScopeAddSelfSpotFromNetwork(BSText: string);
    procedure BandScopeAddClusterSpot(Sp: TSpot);
    procedure BandScopeMarkCurrentFreq(B: TBand; Hz: Integer);
    procedure BandScopeUpdateSpot(aQSO: TQSO);

    procedure InitBandMenu();

    procedure SetStatusLine(strText: string);

    procedure DoFunctionKey(no: Integer);

    property RigControl: TRigControl read FRigControl;
    property PartialCheck: TPartialCheck read FPartialCheck;
    property CommForm: TCommForm read FCommForm;
    property ChatForm: TChatForm read FChatForm;
    property ZServerInquiry: TZServerInquiry read FZServerInquiry;
    property ZLinkForm: TZLinkForm read FZLinkForm;
    property FreqList: TFreqList read FFreqList;
    property ScratchSheet: TScratchSheet read FScratchSheet;
    property SuperCheckList: TSuperList read FSuperCheckList;

    property CurrentRigID: Integer read GetCurrentRigID;
    property CurrentEditPanel: TEditPanel read GetCurrentEditPanel;
    property EditPanel: TEditPanelArray read FEditPanel;

    property SerialEdit: TEdit read GetSerialEdit;
    property DateEdit: TEdit read GetDateEdit;
    property TimeEdit: TEdit read GetTimeEdit;
    property CallsignEdit: TEdit read GetCallsignEdit;
    property RcvdRSTEdit: TEdit read GetRSTEdit;
    property NumberEdit: TEdit read GetNumberEdit;
    property ModeEdit: TEdit read GetModeEdit;
    property PowerEdit: TEdit read GetPowerEdit;
    property BandEdit: TEdit read GetBandEdit;
    property PointEdit: TEdit read GetPointEdit;
    property OpEdit: TEdit read GetOpEdit;
    property MemoEdit: TEdit read GetMemoEdit;
    property NewMultiEdit1: TEdit read GetNewMulti1Edit;
    property NewMultiEdit2: TEdit read GetNewMulti2Edit;
  end;

var
  MainForm: TMainForm;
  CurrentQSO: TQSO;

var
  MyContest : TContest = nil;

implementation

uses
  UALLJAEditDialog, UAbout, UMenu, UACAGMulti,
  UALLJAScore,
  UJIDXMulti, UJIDXScore, UJIDXScore2, UWPXMulti, UWPXScore,
  UPediScore, UJIDX_DX_Multi, UJIDX_DX_Score,
  UGeneralScore, UFDMulti, UARRLDXMulti,
  UARRLDXScore, UAPSprintScore, UJA0Multi, UJA0Score,
  UKCJMulti, USixDownMulti, UIARUMulti,
  UIARUScore, UAllAsianScore, UIOTAMulti, {UIOTACategory,} UARRL10Multi,
  UARRL10Score,
  UIntegerDialog, UNewPrefix, UKCJScore,
  UWAEScore, UWAEMulti, USummaryInfo, UBandPlanEditDialog, UGraphColorDialog,
  UAgeDialog, UMultipliers, UUTCDialog, UNewIOTARef, Progress, UzLogExtension,
  UTargetEditor, UExportHamlog;

{$R *.DFM}

procedure TMainForm.ReEvaluateCountDownTimer;
var
   mytx, i: Integer;
   TL: TQSOList;
   Q, QQ: TQSO;
   diff: TDateTime;
begin
   TL := TQSOList.Create();
   try
      mytx := dmZlogGlobal.TXNr;
      for i := 1 to Log.TotalQSO do begin
         if Log.QsoList[i].TX = mytx then begin
            Q := TQSO.Create();
            Q.Assign(Log.QsoList[i]);
            TL.Add(Q);
         end;
      end;

      if TL.Count = 0 then begin
         CountDownStartTime := 0;
         Exit;
      end;

      Q := TL[TL.Count - 1];
      for i := TL.Count - 1 downto 0 do begin // if there's only 1 qso then it won't loop
         QQ := TL[i];
         if QQ.Band <> Q.Band then begin
            // バンド変更があっても10分以上経過でOK
            diff := Q.Time - QQ.Time;
            if Diff * 24 * 60 > 10.00 then begin
               CountDownStartTime := 0;
            end
            else begin
               CountDownStartTime := Q.Time;
            end;
            break;
         end
         else begin
            Q := QQ;
         end;
      end;

//      CountDownStartTime := Q.Time;
   finally
      TL.Free;
   end;
end;

procedure TMainForm.ReEvaluateQSYCount;
begin
   QSYCount := Log.EvaluateQSYCount(Log.TotalQSO);
end;

procedure TMainForm.WriteStatusLine(S: string; WriteConsole: Boolean);
begin
   if ContainsDoubleByteChar(S) then begin
      StatusLine.Font.Name := 'ＭＳ Ｐゴシック';
      StatusLine.Font.Charset := 128; // shift jis
   end
   else begin
      StatusLine.Font.Name := 'MS Sans Serif';
      StatusLine.Font.Charset := 0; // shift jis
   end;
   clStatusLine := clWindowText;
   StatusLine.Panels[0].Text := S;
   if WriteConsole then
      FConsolePad.AddLine(S);
end;

procedure TMainForm.WriteStatusLineRed(S: string; WriteConsole: Boolean);
begin
   clStatusLine := clRed;
   if ContainsDoubleByteChar(S) then begin
      StatusLine.Font.Name := 'ＭＳ Ｐゴシック';
      StatusLine.Font.Charset := 128; // shift jis
   end
   else begin
      StatusLine.Font.Name := 'MS Sans Serif';
      StatusLine.Font.Charset := 0; // shift jis
   end;
   StatusLine.Panels[0].Text := S;
   if WriteConsole then
      FConsolePad.AddLine(S);
end;

procedure TMainForm.PushQSO(aQSO: TQSO);
const
   TEMPQSOMAX = 5;
var
   i: Integer;
   Q: TQSO;
begin
   Q := TQSO.Create;
   Q.Assign(aQSO);
   FTempQSOList.Insert(0, Q);

   if FTempQSOList.Count > TEMPQSOMAX then begin
      i := FTempQSOList.Count;
      Q := FTempQSOList[i - 1];
      FTempQSOList.Delete(i - 1);
      Q.Free;
   end;
end;

procedure TMainForm.PullQSO;
var
   i: Integer;
begin
   i := FTempQSOList.Count;
   if i > 0 then begin
      CurrentQSO.Assign(FTempQSOList[0]);
      CurrentQSO.UpdateTime;

      with CurrentEditPanel do begin
         CallsignEdit.Text := CurrentQSO.Callsign;
         CurrentEditPanel.rcvdNumber.Text := CurrentQSO.NrRcvd;
         CurrentEditPanel.BandEdit.Text := MHzString[CurrentQSO.Band];
         CurrentEditPanel.PowerEdit.Text := NewPowerString[CurrentQSO.Power];
         CurrentEditPanel.PointEdit.Text := CurrentQSO.PointStr;
         CurrentEditPanel.RcvdRSTEdit.Text := CurrentQSO.RSTStr;
         TimeEdit.Text := CurrentQSO.TimeStr;
         DateEdit.Text := CurrentQSO.DateStr;
         ModeEdit.Text := ModeString[CurrentQSO.Mode];
      end;

      If CurrentQSO.Mode in [mSSB .. mAM] then begin
         Grid.Align := alNone;
         SSBToolBar.Visible := True;
         CWToolBar.Visible := False;
         Grid.Align := alClient;
      end
      else begin
         Grid.Align := alNone;
         CWToolBar.Visible := True;
         SSBToolBar.Visible := False;
         Grid.Align := alClient;
      end;
      FTempQSOList.Move(0, i - 1);
   end;
end;

procedure TMainForm.RenewCWToolBar;
var
   i: Integer;
begin
   SpeedBar.Position := dmZLogKeyer.WPM;
   SpeedLabel.Caption := IntToStr(SpeedBar.Position) + ' wpm';
   FInformation.WPM := dmZLogKeyer.WPM;
   i := dmZlogGlobal.Settings.CW.CurrentBank;
   CWF1.Hint := dmZlogGlobal.CWMessage(i, 1);
   CWF2.Hint := dmZlogGlobal.CWMessage(i, 2);
   CWF3.Hint := dmZlogGlobal.CWMessage(i, 3);
   CWF4.Hint := dmZlogGlobal.CWMessage(i, 4);
   CWF5.Hint := dmZlogGlobal.CWMessage(i, 5);
   CWF6.Hint := dmZlogGlobal.CWMessage(i, 6);
   CWF7.Hint := dmZlogGlobal.CWMessage(i, 7);
   CWF8.Hint := dmZlogGlobal.CWMessage(i, 8);
   CWF9.Hint := dmZlogGlobal.CWMessage(i, 9);
   CWF10.Hint := dmZlogGlobal.CWMessage(i, 10);
   CWF11.Hint := dmZlogGlobal.CWMessage(i, 11);
   CWF12.Hint := dmZlogGlobal.CWMessage(i, 12);
   SideToneButton.Down := dmZlogGlobal.Settings.CW._sidetone;
end;

procedure TMainForm.RenewVoiceToolBar;
begin
   VoiceF1.Hint := dmZLogGlobal.Settings.FSoundComments[1];
   VoiceF2.Hint := dmZLogGlobal.Settings.FSoundComments[2];
   VoiceF3.Hint := dmZLogGlobal.Settings.FSoundComments[3];
   VoiceF4.Hint := dmZLogGlobal.Settings.FSoundComments[4];
   VoiceF5.Hint := dmZLogGlobal.Settings.FSoundComments[5];
   VoiceF6.Hint := dmZLogGlobal.Settings.FSoundComments[6];
   VoiceF7.Hint := dmZLogGlobal.Settings.FSoundComments[7];
   VoiceF8.Hint := dmZLogGlobal.Settings.FSoundComments[8];
   VoiceF9.Hint := dmZLogGlobal.Settings.FSoundComments[9];
   VoiceF10.Hint := dmZLogGlobal.Settings.FSoundComments[10];
   VoiceF11.Hint := dmZLogGlobal.Settings.FSoundComments[11];
   VoiceF12.Hint := dmZLogGlobal.Settings.FSoundComments[12];
end;

procedure TMainForm.RenewBandMenu();
var
   i: Integer;
begin
   for i := 0 to BandMenu.Items.Count - 1 do begin
      BandMenu.Items[i].Visible := True;
   end;
end;

procedure TContest.SetBand(B: TBand);
begin
end;

procedure TContest.WriteSummary(filename: string); // creates summary file
var
   f: textfile;
   S: string;
begin
   if Log.Year = 0 then
      exit;

   AssignFile(f, filename);
   Rewrite(f);

   S := FillRight('Year:', 12) + IntToStr(Log.Year);
   WriteLn(f, S);
   WriteLn(f);
   WriteLn(f, Name);
   WriteLn(f);
   S := FillRight('Callsign:', 12) + dmZlogGlobal.MyCall;
   WriteLn(f, S);
   WriteLn(f);
   WriteLn(f, 'Country: ');
   WriteLn(f);
   S := FillRight('Category:', 12);

   if dmZlogGlobal.ContestCategory = ccSingleOp then begin
      S := S + 'Single Operator  ';
   end
   else begin
      S := S + 'Multi Operator  ';
   end;

   if dmZlogGlobal.Band = 0 then
      S := S + 'All band'
   else
      S := S + MHzString[TBand(Ord(dmZlogGlobal.Band) - 1)];

   S := S + '  ';
   case dmZlogGlobal.ContestMode of
      cmMix:
         S := S + 'Phone/CW';
      cmCw:
         S := S + 'CW';
      cmPh:
         S := S + 'Phone';
   end;

   WriteLn(f, S);
   WriteLn(f);
   WriteLn(f, 'Band(MHz)      QSOs         Points       Multi.');

   WriteLn(f, 'Total');
   WriteLn(f, 'Score');

   WriteLn(f);

   CloseFile(f);
end;

function TARRL10Contest.CheckWinSummary(aQSO: TQSO): string; // returns summary for checkcall etc.
var
   str: string;
begin
   str := aQSO.CheckCallSummary;
   if aQSO.mode = mCW then
      Insert('CW ', str, 5)
   else
      Insert('Ph ', str, 5);

   Result := str;
end;

function TContest.CheckWinSummary(aQSO: TQSO): string; // returns summary for checkcall etc.
begin
   Result := aQSO.CheckCallSummary;
end;

function TContest.QTHString(aQSO: TQSO): string;
begin
   Result := dmZlogGlobal.Settings._city;
end;

procedure TContest.SetPoints(var aQSO: TQSO);
begin
end;

procedure TContest.DispExchangeOnOtherBands;
var
   Q: TQSO;
begin
   Q := Log.ObjectOf(CurrentQSO.Callsign);
   if Q = nil then begin
      Exit;
   end;

   MainForm.NumberEdit.Text := Q.NrRcvd;
   CurrentQSO.NrRcvd := Q.NrRcvd;
end;

procedure TContest.SelectPowerCode();
var
   str: string;
begin
   str := MainForm.NumberEdit.Text;
   if str <> '' then begin
      if CharInSet(str[length(str)], ['H', 'M', 'L', 'P']) then begin
         MainForm.NumberEdit.SelStart := length(str) - 1;
         MainForm.NumberEdit.SelLength := 1;
      end;
   end;
end;

procedure TACAGContest.DispExchangeOnOtherBands;
begin
   Inherited;

   // added for acag
   SelectPowerCode();
end;

procedure TALLJAContest.DispExchangeOnOtherBands;
begin
   Inherited;

   // added for allja (same as acag)
   SelectPowerCode();
end;

Procedure TFDContest.DispExchangeOnOtherBands;
var
   j: Integer;
   str: string;
   currshf: Boolean;
   pastQSO, tempQSO: TQSO;
begin
   currshf := IsSHF(CurrentQSO.Band);
   pastQSO := nil;
   tempQSO := nil;

   for j := 1 to Log.TotalQSO do begin
      if CurrentQSO.Callsign = Log.QsoList[j].Callsign then begin
         if currshf = IsSHF(Log.QsoList[j].Band) then begin
            pastQSO := Log.QsoList[j];
            break;
         end
         else begin
            tempQSO := Log.QsoList[j];
         end;
      end;
   end;

   if pastQSO <> nil then begin
      MainForm.NumberEdit.Text := pastQSO.NrRcvd;
      CurrentQSO.NrRcvd := pastQSO.NrRcvd;
   end
   else begin
      if tempQSO <> nil then begin
         if currshf = True then begin
            if length(tempQSO.NrRcvd) > 3 then
               str := '01' + ExtractPower(tempQSO.NrRcvd)
            else
               str := tempQSO.NrRcvd;
            MainForm.NumberEdit.Text := str;
            CurrentQSO.NrRcvd := str;
         end
         else begin
            str := ExtractKenNr(tempQSO.NrRcvd) + ExtractPower(tempQSO.NrRcvd);
            MainForm.NumberEdit.Text := str;
            CurrentQSO.NrRcvd := str;
         end;
      end
      else // if tempQSO = nil
      begin
         exit;
      end;
   end;

   // added for acag
   SelectPowerCode();
end;

Procedure TSixDownContest.DispExchangeOnOtherBands;
var
   j: Integer;
   str: string;
   currshf: Boolean;
   pastQSO, tempQSO: TQSO;
begin
   currshf := IsSHF(CurrentQSO.Band);
   pastQSO := nil;
   tempQSO := nil;

   for j := 1 to Log.TotalQSO do begin
      if CurrentQSO.Callsign = Log.QsoList[j].Callsign then begin
         if currshf = IsSHF(Log.QsoList[j].Band) then begin
            pastQSO := Log.QsoList[j];
            break;
         end
         else begin
            tempQSO := Log.QsoList[j];
         end;
      end;
   end;

   if pastQSO <> nil then begin
      MainForm.NumberEdit.Text := pastQSO.NrRcvd;
      CurrentQSO.NrRcvd := pastQSO.NrRcvd;
   end
   else begin
      if tempQSO <> nil then begin
         if currshf = True then begin
            if length(tempQSO.NrRcvd) > 3 then
               str := '01' + ExtractPower(tempQSO.NrRcvd)
            else
               str := tempQSO.NrRcvd;
            MainForm.NumberEdit.Text := str;
            CurrentQSO.NrRcvd := str;
         end
         else begin
            str := ExtractKenNr(tempQSO.NrRcvd) + ExtractPower(tempQSO.NrRcvd);
            MainForm.NumberEdit.Text := str;
            CurrentQSO.NrRcvd := str;
         end;
      end
      else // if tempQSO = nil
      begin
         exit;
      end;
   end;

   // added for acag
   SelectPowerCode();
end;

Procedure TContest.SpaceBarProc;
begin
   MultiFound := False;
   if (MainForm.NumberEdit.Text = '') and (SameExchange = True) then begin
      DispExchangeOnOtherBands;
      if MainForm.NumberEdit.Text <> '' then
         MultiFound := True;
   end;
   if dmZlogGlobal.Settings._entersuperexchange and (MainForm.FSpcRcvd_Estimate <> '') then
      if MainForm.NumberEdit.Text = '' then
         if CoreCall(MainForm.FSpcFirstDataCall) = CoreCall(MainForm.CallsignEdit.Text) then begin
            MainForm.NumberEdit.Text := TrimRight(MainForm.FSpcRcvd_Estimate);
            MultiFound := True;
         end;

   if MainForm.FCheckMulti.Visible then
      MainForm.FCheckMulti.Renew(CurrentQSO);
end;

Procedure TIOTAContest.SpaceBarProc;
begin
   inherited;
   if MultiFound and (TIOTAMulti(MyContest.MultiForm).ExtractMulti(CurrentQSO) = '') then // serial number
      MainForm.NumberEdit.Text := '';
end;

procedure TMainForm.SetR(var aQSO: TQSO); // r of RST
var
   i: Integer;
begin
   i := aQSO.RSTRcvd;

   if i < 100 then begin
      if i > 50 then
         i := 10 + (i mod 10)
      else
         i := i + 10;
   end
   else begin
      if i > 500 then
         i := 100 + (i mod 100)
      else
         i := i + 100;
   end;

   aQSO.RSTRcvd := i;
   // RcvdRSTEdit.Text := CurrentQSO.RSTStr;
end;

procedure TMainForm.SetS(var aQSO: TQSO);
var
   i: Integer;
begin
   i := aQSO.RSTRcvd;
   if i < 100 then begin
      if (i mod 10) = 9 then
         i := 10 * (i div 10) + 1
      else
         i := i + 1;
   end
   else begin
      if ((i div 10) mod 10) = 9 then
         i := 100 * (i div 100) + 10 + (i mod 10)
      else
         i := i + 10;
   end;

   aQSO.RSTRcvd := i;
   // RcvdRSTEdit.Text := CurrentQSO.RSTStr;
end;

function TMainForm.GetNextBand(BB: TBand; Up: Boolean): TBand;
begin
   if Up then begin
      Result := ScanNextBand(BB);
   end
   else begin
      Result := ScanPrevBand(BB);
   end;
end;

function TMainForm.ScanNextBand(B0: TBand): TBand;
var
   B: TBand;
begin
   Result := B0;

   if B0 = HiBand then begin
      B0 := b19;
   end
   else begin
      inc(B0);
   end;

   for B := B0 to HiBand do begin
      if IsAvailableBand(B) = True then begin
         Result := B;
         Exit;
      end;
   end;

   for B := b19 to B0 do begin
      if IsAvailableBand(B) = True then begin
         Result := B;
         Exit;
      end;
   end;
end;

function TMainForm.ScanPrevBand(B0: TBand): TBand;
var
   B: TBand;
begin
   Result := B0;

   if B0 = b19 then begin
      B0 := HiBand;
   end
   else begin
      dec(B0);
   end;

   for B := B0 downto b19 do begin
      if IsAvailableBand(B) = True then begin
         Result := B;
         Exit;
      end;
   end;

   for B := HiBand downto B0 do begin
      if IsAvailableBand(B) = True then begin
         Result := B;
         Exit;
      end;
   end;
end;

function TMainForm.IsAvailableBand(B: TBand): Boolean;
begin
   if (BandMenu.Items[Ord(B)].Visible = True) and
      (BandMenu.Items[Ord(B)].Enabled = True) and
      (RigControl.IsAvailableBand(B) = True) and
      ((dmZlogGlobal.Settings._dontallowsameband = False) or (RigControl.CheckSameBand(B) = False)) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TMainForm.BandMenuClick(Sender: TObject);
begin
   QSY(TBand(TMenuItem(Sender).Tag), CurrentQSO.Mode, 0);
   LastFocus.SetFocus;
end;

procedure TMainForm.UpdateBand(B: TBand); // called from rigcontrol too
var
   bb: TBand;
begin
   BandEdit.Text := MHzString[B];

   if SerialEdit.Visible then
      if SerialContestType = SER_BAND then begin
         SerialArray[CurrentQSO.Band] := CurrentQSO.Serial;
         CurrentQSO.Serial := SerialArray[B];
         SerialEdit.Text := CurrentQSO.SerialStr;
      end;

   CurrentQSO.Band := B;

   if MyContest <> nil then begin
      MyContest.SetPoints(CurrentQSO);
   end;

   PointEdit.Text := CurrentQSO.PointStr; // ver 0.23

   FZLinkForm.SendBand; // ver 0.41

   CurrentQSO.Power := dmZlogGlobal.PowerOfBand[B];
   dmZlogGlobal.SetOpPower(CurrentQSO);
   if Assigned(PowerEdit) and PowerEdit.Visible then begin
      PowerEdit.Text := CurrentQSO.NewPowerStr;
   end;

   if MyContest <> nil then begin
      if MyContest.MultiForm.Visible then begin
         MyContest.MultiForm.UpdateData;
      end;
   end;

   if FPartialCheck.Visible then begin
      FPartialCheck.UpdateData(CurrentQSO);
   end;

   if ShowCurrentBandOnly.Checked then begin
      GridRefreshScreen();
   end;

   if dmZlogGlobal.Settings._countdown and (CountDownStartTime > 0) then begin
      WriteStatusLineRed('Less than 10 min since last QSY!', False);
      FQsyViolation := True;
   end;

   if dmZlogGlobal.Settings._qsycount and (QSYCount > dmZLogGlobal.Settings._countperhour) then begin
      WriteStatusLineRed('QSY count exceeded limit!', False);
      FQsyViolation := True;
   end;

   if RigControl.Rig = nil then begin
      FZLinkForm.SendFreqInfo(round(RigControl.TempFreq[B] * 1000));
   end;

   for bb := Low(FBandScopeEx) to High(FBandScopeEx) do begin
      FBandScopeEx[bb].Select := False;
   end;
   FBandScopeEx[B].Select := True;

   if FBandScope.CurrentBand <> B then begin
      FBandScope.CurrentBand := B;
      FBandScope.CopyList(FBandScopeEx[B]);
   end;
   FBandScope.Select := True;

   FRateDialogEx.Band := CurrentQSO.Band;
end;

procedure TMainForm.UpdateMode(M: TMode);
begin
   ModeEdit.Text := ModeString[M];
   CurrentQSO.Mode := M;
   If M in [mSSB, mFM, mAM] then begin
      CurrentQSO.RSTRcvd := 59;
      CurrentQSO.RSTsent := 59;
      RcvdRSTEdit.Text := '59';
      Grid.Align := alNone;
      SSBToolBar.Visible := True;
      CWToolBar.Visible := False;
      Grid.Align := alClient;
   end
   else begin
      CurrentQSO.RSTRcvd := 599;
      CurrentQSO.RSTsent := 599;
      RcvdRSTEdit.Text := '599';
      Grid.Align := alNone;
      CWToolBar.Visible := True;
      SSBToolBar.Visible := False;
      Grid.Align := alClient;
   end;

   if MyContest <> nil then begin
      if MyContest.MultiForm.Visible then begin
         MyContest.MultiForm.UpdateData;
      end;
   end;

   if MyContest <> nil then begin
      MyContest.SetPoints(CurrentQSO);
   end;

   PointEdit.Text := CurrentQSO.PointStr;

   FFunctionKeyPanel.UpdateInfo();
end;

procedure TMainForm.SetQSOMode(aQSO: TQSO);
var
   maxmode: TMode;
begin
   if dmZLogGlobal.ContestMode = cmAll then begin
      maxmode := mOther;
   end
   else begin
      maxmode := mOther;
      case aQSO.Band of
         b19 .. b24:
            maxmode := mSSB;
         b28:
            maxmode := mFM;
         b50:
            maxmode := mAM;
         b144 .. HiBand:
            maxmode := mFM;
      end;
   end;

   if Pos('Pedition', MyContest.Name) > 0 then begin
      maxmode := mOther;
   end;

   if aQSO.Mode < maxmode then begin
      aQSO.Mode := TMode(Integer(aQSO.Mode) + 1);
   end
   else begin
      aQSO.Mode := mCW;
   end;
end;

procedure TContest.ChangePower;
begin
   if CurrentQSO.Power = pwrH then begin
      CurrentQSO.Power := pwrP;
   end
   else begin
      CurrentQSO.Power := TPower(Integer(CurrentQSO.Power) + 1);
   end;

   if Assigned(MainForm.PowerEdit) then begin
      MainForm.PowerEdit.Text := CurrentQSO.NewPowerStr;
   end;
end;

constructor TWanted.Create;
begin
   Multi := '';
   Bands := [];
end;

constructor TContest.Create(N: string);
var
   i: Integer;
   B: TBand;
begin
   MultiForm := nil;
   ScoreForm := nil;
   ZoneForm := nil;
   PastEditForm := nil;
   WantedList := TList.Create;

   SameExchange := True;
   dmZlogGlobal.Settings._sameexchange := SameExchange;
   MainForm.MultiButton.Enabled := True; // toolbar
   MainForm.Multipliers1.Enabled := True; // menu
   MainForm.mnCheckCountry.Visible := False; // checkcountry window
   MainForm.mnCheckMulti.Caption := 'Check Multi';
   Name := N;

   Log.AcceptDifferentMode := False;
   Log.CountHigherPoints := False;

   Log.QsoList[0].Callsign := dmZlogGlobal.Settings._mycall; // Callsign
   Log.QsoList[0].Memo := N; // Contest name
   Log.QsoList[0].RSTsent := UTCOffset; // UTC = $FFFF else UTC + x hrs;
   Log.QsoList[0].RSTRcvd := 0; // or Field Day coefficient

   SerialContestType := 0;

   for B := b19 to HiBand do
      SerialArray[B] := 1;

   for i := 0 to 64 do
      SerialArrayTX[i] := 1;

   SentStr := '';

   FNeedCtyDat := False;
   FUseCoeff := False;
end;

procedure TContest.PostWanted(S: string);
var
   ss, mm: string;
   i, BB: Integer;
   W: TWanted;

begin
   ss := copy(S, 1, 2);
   ss := TrimRight(ss);

   BB := StrToInt(ss);
   if BB <= Ord(HiBand) then begin
      mm := copy(S, 3, 255);
      mm := TrimLeft(mm);
      mm := TrimRight(mm);
      for i := 0 to WantedList.Count - 1 do begin
         W := TWanted(WantedList[i]);
         if W.Multi = mm then begin
            W.Bands := W.Bands + [TBand(BB)];
            exit;
         end;
      end;
      W := TWanted.Create;
      W.Multi := mm;
      W.Bands := [TBand(BB)];
      WantedList.Add(W);
   end;
end;

procedure TContest.DelWanted(S: string);
var
   ss, mm: string;
   i, BB: Integer;
   W: TWanted;
begin
   ss := copy(S, 1, 2);
   ss := TrimRight(ss);

   BB := StrToInt(ss);
   if BB <= Ord(HiBand) then begin
      mm := copy(S, 3, 255);
      mm := TrimLeft(mm);
      mm := TrimRight(mm);
      for i := 0 to WantedList.Count - 1 do begin
         W := TWanted(WantedList[i]);
         if W.Multi = mm then begin
            W.Bands := W.Bands - [TBand(BB)];
            if W.Bands = [] then begin
               W.Free;
               WantedList.Delete(i);
               WantedList.Pack;
            end;
            exit;
         end;
      end;
   end;
end;

procedure TContest.ClearWanted;
var
   W: TWanted;
   i: Integer;
begin
   for i := 0 to WantedList.Count - 1 do begin
      W := TWanted(WantedList[i]);
      W.Free;
   end;
   WantedList.Clear;
end;

destructor TContest.Destroy;
begin
   inherited;

   WantedList.Free();

   if Assigned(MultiForm) then begin
      MultiForm.Release();
   end;
   if Assigned(ScoreForm) then begin
      ScoreForm.Release();
   end;
   if Assigned(ZoneForm) then begin
      ZoneForm.Release();
   end;
   if Assigned(PastEditForm) then begin
      PastEditForm.Release();
   end;
end;

procedure TContest.SetNrSent(var aQSO: TQSO);
var
   S: string;
begin
   S := SetStrNoAbbrev(dmZlogGlobal.Settings._sentstr, aQSO);

   S := StringReplace(S, '_', '', [rfReplaceAll]);

   aQSO.NrSent := S;
end;

function TContest.ADIF_ExchangeRX_FieldName: string;
begin
   if SerialContestType <> 0 then
      Result := 'srx'
   else
      Result := 'qth';
end;

function TCQWWContest.ADIF_ExchangeRX_FieldName: string;
begin
   Result := 'cqz';
end;

function TIARUContest.ADIF_ExchangeRX_FieldName: string;
begin
   Result := 'ituz';
end;

function TARRLDXContestDX.ADIF_ExchangeRX_FieldName: string;
begin
   Result := 'state';
end;

function TARRLDXContestW.ADIF_ExchangeRX_FieldName: string;
begin
   Result := 'rx_pwr';
end;

function TAllAsianContest.ADIF_ExchangeRX_FieldName: string;
begin
   Result := 'age';
end;

function TContest.ADIF_ExchangeRX(aQSO: TQSO): string;
begin
   Result := aQSO.NrRcvd;
end;

function TContest.ADIF_ExtraFieldName: string;
begin
   Result := '';
end;

function TContest.ADIF_ExtraField(aQSO: TQSO): string;
begin
   Result := '';
end;

function TCQWPXContest.ADIF_ExtraFieldName: string;
begin
   Result := 'pfx';
end;

function TCQWPXContest.ADIF_ExtraField(aQSO: TQSO): string;
begin
   Result := aQSO.Multi1;
end;

procedure TContest.ADIF_Export(filename: string);
var
   f: textfile;
   Header, S, temp: string;
   i: Integer;
   aQSO: TQSO;
   offsetmin: Integer;
   dbl: double;
begin
   Header := 'ADIF export from zLog for Windows'; // +dmZlogGlobal.Settings._mycall;

   AssignFile(f, filename);
   Rewrite(f);

   { str := 'zLog for Windows Text File'; }
   WriteLn(f, Header);
   WriteLn(f, 'All times in UTC');
   WriteLn(f, '<eoh>');

   offsetmin := Log.QsoList[0].RSTsent;
   { if offsetmin = 0 then // default JST for older versions
     offsetmin := -1*9*60; }
   if offsetmin = _USEUTC then // already recorded in utc
      offsetmin := 0;
   dbl := offsetmin / (24 * 60);

   for i := 1 to Log.TotalQSO do begin
      aQSO := Log.QsoList[i];
      S := '<qso_date:8>';
      S := S + FormatDateTime('yyyymmdd', aQSO.Time + dbl);
      S := S + '<time_on:4>' + FormatDateTime('hhnn', aQSO.Time + dbl);
      S := S + '<time_off:4>' + FormatDateTime('hhnn', aQSO.Time + dbl);

      temp := aQSO.Callsign;
      S := S + '<call:' + IntToStr(length(temp)) + '>' + temp;

      temp := IntToStr(aQSO.RSTsent);
      S := S + '<rst_sent:' + IntToStr(length(temp)) + '>' + temp;

      if SerialContestType <> 0 then begin
         temp := IntToStr(aQSO.Serial);
         S := S + '<stx:' + IntToStr(length(temp)) + '>' + temp;
      end;

      temp := IntToStr(aQSO.RSTRcvd);
      S := S + '<rst_rcvd:' + IntToStr(length(temp)) + '>' + temp;

      temp := ADIF_ExchangeRX(aQSO);
      S := S + '<' + ADIF_ExchangeRX_FieldName + ':' + IntToStr(length(temp)) + '>' + temp;

      temp := ADIF_ExtraField(aQSO);
      if temp <> '' then begin
         S := S + '<' + ADIF_ExtraFieldName + ':' + IntToStr(length(temp)) + '>' + temp;
      end;

      temp := ADIFBandString[aQSO.Band];
      S := S + '<band:' + IntToStr(length(temp)) + '>' + temp;

      temp := ModeString[aQSO.mode];
      S := S + '<mode:' + IntToStr(length(temp)) + '>' + temp;

      if aQSO.Operator <> '' then begin
         temp := aQSO.Operator;
         S := S + '<operator:' + IntToStr(length(temp)) + '>' + temp;
      end;

      if aQSO.Memo <> '' then begin
         temp := aQSO.Memo;
         S := S + '<comment:' + IntToStr(length(temp)) + '>' + temp;
      end;

      S := S + '<eor>';

      WriteLn(f, S);
   end;

   CloseFile(f);
end;

procedure TContest.LogQSO(var aQSO: TQSO; Local: Boolean);
var
   i, T, mytx: Integer;
   boo: Boolean;
begin
   if Log.TotalQSO > 0 then begin
      T := Log.TotalQSO;
      mytx := dmZlogGlobal.TXNr;
      if { Local = True } mytx = aQSO.TX then // same tx # could be through network
      begin
         boo := False;
         for i := T downto 1 do begin
            if Log.QsoList[i].TX = mytx then begin
               boo := True;
               break;
            end;
         end;
         if (boo = False) or (boo and (Log.QsoList[i].Band <> aQSO.Band)) then begin
            CountDownStartTime := CurrentTime; // Now;
         end;
      end;
   end
   else // log.total = 0
   begin
      CountDownStartTime := CurrentTime;
   end;
   { if Local then
     if dmZlogGlobal.Settings._multistation = True then
     aQSO.Memo := 'MULT '+aQSO.Memo; }

   if Local = False then
      aQSO.Reserve2 := $AA; // some multi form and editscreen uses this flag
   MultiForm.AddNoUpdate(aQSO);
   aQSO.Reserve2 := $00;
   ScoreForm.AddNoUpdate(aQSO);

   aQSO.Reserve := actAdd;
   Log.AddQue(aQSO);
   Log.ProcessQue;

   MultiForm.UpdateData;
   ScoreForm.UpdateData;

   if Local = False then
      aQSO.Reserve2 := $AA; // some multi form and editscreen uses this flag

   MainForm.GridAdd(aQSO);

   // synchronization of serial # over network
   if dmZlogGlobal.Settings._syncserial and (SerialContestType <> 0) and (Local = False) then begin
      if SerialContestType = SER_MS then // WPX M/S type. Separate serial for mult/run
      begin
         SerialArrayTX[aQSO.TX] := aQSO.Serial + 1;
         if aQSO.TX = dmZlogGlobal.TXNr then begin
            CurrentQSO.Serial := aQSO.Serial + 1;
            MainForm.SerialEdit.Text := CurrentQSO.SerialStr;
         end;
      end
      else begin
         SerialArray[aQSO.Band] := aQSO.Serial + 1;
         if (SerialContestType = SER_ALL) or ((SerialContestType = SER_BAND) and (CurrentQSO.Band = aQSO.Band)) then begin
            CurrentQSO.Serial := aQSO.Serial + 1;
            MainForm.SerialEdit.Text := CurrentQSO.SerialStr;
         end;
      end;
   end;

   aQSO.Reserve2 := $00;

   MainForm.ReEvaluateQSYCount;

   if MainForm.FRateDialog.Visible then begin
      MainForm.FRateDialog.UpdateGraph;
   end;
   if MainForm.FRateDialogEx.Visible then begin
      MainForm.FRateDialogEx.UpdateGraph;
   end;

   // M/S時、本来Multi StationはNEW MULTIしか交信できない
   if (dmZLogGlobal.IsMultiStation() = True) then begin
      if Local { (mytx = aQSO.TX) } and (aQSO.NewMulti1 = False) and (aQSO.NewMulti2 = False) and (dmZlogGlobal.Settings._multistationwarning)
      then begin
         MessageDlg('This station is not a new multiplier, but will be logged anyway.', mtError, [mbOK], 0); { HELP context 0 }
      end;
   end;
end;

procedure TContest.ShowScore;
begin
   ScoreForm.Show;
end;

procedure TContest.ShowMulti;
begin
   MultiForm.Show;
end;

procedure TContest.Renew;
var
   i: Integer;
   aQSO: TQSO;
begin
   if dmZlogGlobal.Settings._renewbythread then begin
      RequestRenewThread;
      exit;
   end;

   MultiForm.reset;
   ScoreForm.reset;

   Log.SetDupeFlags;

   for i := 1 to Log.TotalQSO do begin
      aQSO := Log.QsoList[i];

      if Log.CountHigherPoints = True then begin
         Log.IsDupe(aQSO); // called to set log.differentmodepointer
      end;

      MultiForm.AddNoUpdate(aQSO);
      ScoreForm.AddNoUpdate(aQSO);
   end;

   MultiForm.UpdateData;
   ScoreForm.UpdateData;
   MultiForm.RenewBandScope;
end;

procedure TContest.EditCurrentRow;
var
   R: Integer;
   aQSO: TQSO;
begin
   R := MainForm.Grid.Row;

   aQSO := TQSO(MainForm.Grid.Objects[0, R]);
   if aQSO = nil then begin
      Exit;
   end;

   if aQSO.Reserve = actLock then begin
      MainForm.WriteStatusLine('This QSO is currently locked', False);
      exit;
   end;

   PastEditForm.Init(aQSO, _ActChange);

   if PastEditForm.ShowModal <> mrOK then begin
      Exit;
   end;

   MainForm.GridWriteQSO(R, aQSO);

   if MainForm.FPartialCheck.Visible and MainForm.FPartialCheck._CheckCall then begin
      MainForm.FPartialCheck.CheckPartial(CurrentQSO);
   end;

   if MainForm.FCheckCall2.Visible then begin
      MainForm.FCheckCall2.Renew(CurrentQSO);
   end;
end;

constructor TJIDXContest.Create(N: string);
begin
   inherited Create(N, True);    //   <-TCQWWContestからの継承なのでinherited不可
   MultiForm := TJIDXMulti.Create(MainForm);
   ScoreForm := TJIDXScore2.Create(MainForm);
   ZoneForm := TWWZone.Create(MainForm);
   TJIDXMulti(MultiForm).ZoneForm := ZoneForm;
   MainForm.FCheckCountry.ParentMulti := TWWMulti(MultiForm);
   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   SentStr := '$V';
   FNeedCtyDat := True;
end;

procedure TJIDXContest.SetPoints(var aQSO: TQSO);
begin
   TJIDXScore2(ScoreForm).CalcPoints(aQSO);
end;

constructor TARRLDXContestDX.Create(N: string);
begin
   inherited;
   MultiForm := TARRLDXMulti.Create(MainForm);
   ScoreForm := TARRLDXScore.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);

   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   SentStr := '$N';
   FNeedCtyDat := True;
end;

constructor TARRLDXContestW.Create(N: string);
begin
   inherited;
   MultiForm := TARRLWMulti.Create(MainForm);
   TARRLWMulti(MultiForm).ALLASIANFLAG := False;
   ScoreForm := TARRLDXScore.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);
   ZoneForm := TWWZone.Create(MainForm);

   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   SentStr := '$V';
   FNeedCtyDat := True;
end;

constructor TAllAsianContest.Create(N: string);
begin
   inherited;

   MultiForm := TARRLWMulti.Create(MainForm);
   TARRLWMulti(MultiForm).ALLASIANFLAG := True;
   ScoreForm := TAllAsianScore.Create(MainForm);
   ZoneForm := TWWZone.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);

   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   SentStr := '$A';
end;

procedure TAllAsianContest.SetPoints(var aQSO: TQSO);
begin
   TAllAsianScore(ScoreForm).CalcPoints(aQSO);
end;

procedure TAllAsianContest.SpaceBarProc;
begin
   inherited;
   MainForm.WriteStatusLine(MultiForm.GetInfo(CurrentQSO), False);
end;

constructor TJIDXContestDX.Create(N: string);
begin
   inherited;
   MultiForm := TJIDX_DX_Multi.Create(MainForm);
   ScoreForm := TJIDX_DX_Score.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);
   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   SentStr := '$V';
   FNeedCtyDat := True;
end;

procedure TJIDXContestDX.SetPoints(var aQSO: TQSO);
begin
   TJIDX_DX_Score(ScoreForm).CalcPoints(aQSO);
end;

constructor TCQWPXContest.Create(N: string);
begin
   inherited;
   MultiForm := TWPXMulti.Create(MainForm);
   ScoreForm := TWPXScore.Create(MainForm);
   ZoneForm := nil;
   MultiForm.Reset();

   PastEditForm := TALLJAEditDialog.Create(MainForm);

   TWPXScore(ScoreForm).MultiForm := TWPXMulti(MultiForm);

   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   Log.QsoList[0].Serial := $01; // uses serial number
   SerialContestType := SER_ALL;
   SameExchange := False;
   dmZlogGlobal.Settings._sameexchange := SameExchange;
   SentStr := '$S';
   FNeedCtyDat := True;
end;

constructor TWAEContest.Create(N: string);
begin
   inherited;

   MultiForm := TWAEMulti.Create(MainForm);
   ScoreForm := TWAEScore.Create(MainForm);
   ZoneForm := TWWZone.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);
   QTCForm := TQTCForm.Create(MainForm);

   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   Log.QsoList[0].Serial := $01; // uses serial number
   SerialContestType := SER_ALL;
   SameExchange := False;
   dmZlogGlobal.Settings._sameexchange := SameExchange;
   SentStr := '$S';
   FNeedCtyDat := True;
end;

destructor TWAEContest.Destroy();
begin
   QTCForm.Release();
end;

function TIOTAContest.QTHString(aQSO: TQSO): string;
begin
   Result := TIOTAMulti(MultiForm).MyIOTA;
end;

constructor TIOTAContest.Create(N: string);
begin
   inherited;

   MultiForm := TIOTAMulti.Create(MainForm);
   ScoreForm := TIARUScore.Create(MainForm);
   TIARUScore(ScoreForm).InitGrid(b35, b28);
   PastEditForm := TALLJAEditDialog.Create(MainForm);

   UseUTC := True;
   Log.AcceptDifferentMode := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   Log.QsoList[0].Serial := $01; // uses serial number
   SerialContestType := SER_ALL;
   SentStr := '$S$Q';
   FNeedCtyDat := True;
end;

constructor TARRL10Contest.Create(N: string);
begin
   inherited;

   MultiForm := TARRL10Multi.Create(MainForm);
   ScoreForm := TARRL10Score.Create(MainForm);
   ZoneForm := TWWZone.Create(MainForm);
   MainForm.FCheckMulti.ListCWandPh := True;

   PastEditForm := TALLJAEditDialog.Create(MainForm);

   UseUTC := True;
   Log.AcceptDifferentMode := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   Log.QsoList[0].Serial := $01; // uses serial number
   SerialContestType := SER_ALL;
   SameExchange := False;
   dmZlogGlobal.Settings._sameexchange := SameExchange;
   FNeedCtyDat := True;
end;

constructor TJA0Contest.Create(N: string);
begin
   inherited;
   MultiForm := TJA0Multi.Create(MainForm);
   ScoreForm := TJA0Score.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);

   Log.QsoList[0].Serial := $01; // uses serial number
   SerialContestType := SER_ALL;
   SameExchange := False;
   dmZlogGlobal.Settings._sameexchange := SameExchange;
   SentStr := '$S';
end;

constructor TJA0ContestZero.Create(N: string);
begin
   inherited;

   TJA0Multi(MultiForm).JA0 := True;

   Log.QsoList[0].Serial := $01; // uses serial number
   SerialContestType := SER_ALL;
   SameExchange := False;
   dmZlogGlobal.Settings._sameexchange := SameExchange;
   SentStr := '$S';
end;

procedure TJA0Contest.SetBand(B: TBand);
begin
   TJA0Score(ScoreForm).SetBand(B);
   if (B = b21) or (B = b28) then begin
      MainForm.BandMenu.Items[Ord(b21)].Enabled := True;
      MainForm.BandMenu.Items[Ord(b28)].Enabled := True;
      MainForm.BandMenu.Items[Ord(b21)].Visible := True;
      MainForm.BandMenu.Items[Ord(b28)].Visible := True;
   end
   else begin
      MainForm.BandMenu.Items[Ord(B)].Visible := True;
   end;
end;

procedure TJA0Contest.Renew;
var
   B: TBand;
begin
   inherited;
   B := TJA0Score(ScoreForm).JA0Band;
   if (B = b21) or (B = b28) then begin
      MainForm.BandMenu.Items[Ord(b21)].Enabled := True;
      MainForm.BandMenu.Items[Ord(b28)].Enabled := True;
      MainForm.BandMenu.Items[Ord(b21)].Visible := True;
      MainForm.BandMenu.Items[Ord(b28)].Visible := True;
   end
   else begin
      MainForm.BandMenu.Items[Ord(B)].Visible := True;
   end;
end;

constructor TAPSprint.Create(N: string);
begin
   inherited;
   MultiForm := TWPXMulti.Create(MainForm);
   ScoreForm := TAPSprintScore.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);
   ZoneForm := TWWZone.Create(MainForm);

   TAPSprintScore(ScoreForm).MultiForm := TWPXMulti(MultiForm);

   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   Log.QsoList[0].Serial := $01; // uses serial number
   SerialContestType := SER_ALL;

   SameExchange := False;
   dmZlogGlobal.Settings._sameexchange := SameExchange;
   SentStr := '$S';
end;

constructor TCQWWContest.Create(N: string; fJIDX: Boolean);
begin
   inherited Create(N);

   if fJIDX = False then begin
      MultiForm := TWWMulti.Create(MainForm);
      ScoreForm := TWWScore.Create(MainForm);
      ZoneForm := TWWZone.Create(MainForm);
      TWWMulti(MultiForm).ZoneForm := ZoneForm;
      MultiForm.Reset();
   end;

   MainForm.FCheckCountry.ParentMulti := TWWMulti(MultiForm);

   PastEditForm := TALLJAEditDialog.Create(MainForm);

   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   SentStr := '$Z';
   FNeedCtyDat := True;
end;

procedure TCQWWContest.SpaceBarProc;
var
   temp: string;
begin
   // inherited;
   { if MainForm.NumberEdit.Text = '' then
     begin }
   temp := MultiForm.GuessZone(CurrentQSO);
   MainForm.NumberEdit.Text := temp;
   CurrentQSO.NrRcvd := temp;
   // end;

   { This section moved from tcontest.spacebarproc }
   // if (MainForm.NumberEdit.Text = '') and (SameExchange = True)then
   DispExchangeOnOtherBands;
   if MainForm.FCheckMulti.Visible then
      MainForm.FCheckMulti.Renew(CurrentQSO);
   { This section moved from tcontest.spacebarproc }

   if MainForm.FCheckCountry.Visible then
      MainForm.FCheckCountry.Renew(CurrentQSO);

   if (dmZLogGlobal.IsMultiStation() = True) then begin
      if MainForm.FCheckCountry.Visible = False then
         MainForm.FCheckCountry.Renew(CurrentQSO);
      if MainForm.FCheckCountry.NotNewMulti(CurrentQSO.Band) then begin
         MainForm.WriteStatusLineRed('NOT a new multiplier. (This is a multi stn)', False);
         exit;
      end;
   end;

   MainForm.WriteStatusLine(MultiForm.GetInfo(CurrentQSO), False);
end;

procedure TWAEContest.SpaceBarProc;
begin
   inherited;
   if MainForm.FCheckCountry.Visible then
      MainForm.FCheckCountry.Renew(CurrentQSO);

   if (dmZLogGlobal.IsMultiStation() = True) then begin
      if MainForm.FCheckCountry.Visible = False then
         MainForm.FCheckCountry.Renew(CurrentQSO);
      if MainForm.FCheckCountry.NotNewMulti(CurrentQSO.Band) then begin
         MainForm.WriteStatusLineRed('NOT a new multiplier. (This is a multi stn)', False);
         exit;
      end;
   end;

   MainForm.WriteStatusLine(MultiForm.GetInfo(CurrentQSO), False);
end;

procedure TCQWWContest.ShowMulti;
begin
   MultiForm.Show;
   ZoneForm.Show;
end;

function TCQWWContest.CheckWinSummary(aQSO: TQSO): string;
var
   S: string;
begin
   S := '';
   S := S + FillRight(aQSO.BandStr, 5);
   S := S + aQSO.TimeStr + ' ';
   S := S + FillRight(aQSO.Callsign, 12);
   S := S + FillRight(aQSO.NrRcvd, 4);
   Result := S;
end;

constructor TIARUContest.Create(N: string);
begin
   inherited;

   MultiForm := TIARUMulti.Create(MainForm);
   ScoreForm := TIARUScore.Create(MainForm);
   ZoneForm := TWWZone.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);

   UseUTC := True;
   Log.AcceptDifferentMode := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   SentStr := '$I';
   FNeedCtyDat := True;
end;

procedure TIARUContest.SpaceBarProc;
var
   temp: string;
begin
   inherited;
   MainForm.WriteStatusLine(MultiForm.GetInfo(CurrentQSO), False);
   if (MultiFound = False) and (MainForm.NumberEdit.Text = '') then begin
      temp := MultiForm.GuessZone(CurrentQSO);
      MainForm.NumberEdit.Text := temp;
      CurrentQSO.NrRcvd := temp;
   end;
end;

procedure TARRLDXContestW.SpaceBarProc;
begin
   inherited;
   MainForm.WriteStatusLine(MultiForm.GetInfo(CurrentQSO), False);
end;

constructor TPedi.Create(N: string);
begin
   inherited;
   MultiForm := TBasicMulti.Create(MainForm);
   ScoreForm := TPediScore.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);

   Log.AcceptDifferentMode := True;
   if UseUTC then
      Log.QsoList[0].RSTsent := _USEUTC
   else
      Log.QsoList[0].RSTsent := UTCOffset;
   // UTC = $FFFF else UTC + x hrs;
   {
     UseUTC := True;
     Log.QsoList[0].RSTSent := $FFFF; //JST = 0; UTC = $FFFF
   }

   SentStr := '';
end;

constructor TALLJAContest.Create(N: string);
begin
   inherited;
   MultiForm := TALLJAMulti.Create(MainForm);
   ScoreForm := TALLJAScore.Create(MainForm, b19, b50);
   PastEditForm := TALLJAEditDialog.Create(MainForm);
   SentStr := '$V$P';
end;

constructor TKCJContest.Create(N: string);
begin
   inherited;
   MultiForm := TKCJMulti.Create(MainForm);
   ScoreForm := TKCJScore.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);
   SentStr := 'TK';
end;

function TALLJAContest.QTHString(aQSO: TQSO): string;
begin
   Result := dmZlogGlobal.Settings._prov;
end;

function TKCJContest.QTHString(aQSO: TQSO): string;
begin
   Result := dmZlogGlobal.Settings._prov;
   // get the kcj code;
end;

function TALLJAContest.CheckWinSummary(aQSO: TQSO): string;
var
   S: string;
begin
   S := '';
   S := S + FillRight(aQSO.BandStr, 5);
   S := S + aQSO.TimeStr + ' ';
   S := S + FillRight(aQSO.Callsign, 12);
   S := S + FillRight(aQSO.NrRcvd, 5);
   S := S + FillRight(aQSO.ModeStr, 4);
   Result := S;
end;

function TKCJContest.CheckWinSummary(aQSO: TQSO): string;
var
   S: string;
begin
   S := '';
   S := S + FillRight(aQSO.BandStr, 5);
   S := S + aQSO.TimeStr + ' ';
   S := S + FillRight(aQSO.Callsign, 12);
   S := S + FillRight(aQSO.NrRcvd, 3);
   // S := S + FillRight(aQSO.ModeStr, 4);
   Result := S;
end;

function TFDContest.QTHString(aQSO: TQSO): string;
begin
   if aQSO.Band <= b1200 then
      Result := dmZlogGlobal.Settings._prov
   else
      Result := dmZlogGlobal.Settings._city;
end;

function TSixDownContest.QTHString(aQSO: TQSO): string;
begin
   if aQSO.Band <= b1200 then
      Result := dmZlogGlobal.Settings._prov
   else
      Result := dmZlogGlobal.Settings._city;
end;

constructor TACAGContest.Create(N: string);
begin
   inherited;
   MultiForm := TACAGMulti.Create(MainForm);
   ScoreForm := TALLJAScore.Create(MainForm, b19, HiBand);
   PastEditForm := TALLJAEditDialog.Create(MainForm);
   SentStr := '$Q$P';
end;

constructor TFDContest.Create(N: string);
begin
   inherited;
   MultiForm := TFDMulti.Create(MainForm);
   ScoreForm := TALLJAScore.Create(MainForm, b19, HiBand);
   PastEditForm := TALLJAEditDialog.Create(MainForm);
   SentStr := '$Q$P';
   FUseCoeff := True;
end;

constructor TSixDownContest.Create(N: string);
begin
   inherited;
   MultiForm := TSixDownMulti.Create(MainForm);
   ScoreForm := TALLJAScore.Create(MainForm, b50, HiBand);
   TALLJAScore(ScoreForm).PointTable[b2400] := 2;
   TALLJAScore(ScoreForm).PointTable[b5600] := 2;
   TALLJAScore(ScoreForm).PointTable[b10g] := 2;
   PastEditForm := TALLJAEditDialog.Create(MainForm);
   SentStr := '$Q$P';
end;

constructor TGeneralContest.Create(N, CFGFileName: string);
var
   B: TBand;
begin
   inherited Create(N);
   MultiForm := TGeneralMulti2.Create(MainForm);
   ScoreForm := TGeneralScore.Create(MainForm);
   TGeneralScore(ScoreForm).formMulti := TGeneralMulti2(MultiForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);

   FConfig := TUserDefinedContest.Parse(CFGFileName);
   TGeneralScore(ScoreForm).Config := FConfig;
   TGeneralMulti2(MultiForm).Config := FConfig;

   TGeneralMulti2(MultiForm).LoadDAT(FConfig.DatFileName);
   dmZlogGlobal.Settings._sentstr         := FConfig.Sent;

   Log.AcceptDifferentMode                := FConfig.AcceptDifferentMode;
   Log.CountHigherPoints                  := FConfig.CountHigherPoints;

   if FConfig.UseUTC = True then begin
      UseUTC := True;
      Log.QsoList[0].RSTSent := _USEUTC; // JST = 0; UTC = $FFFF
   end;


   for B := b19 to High(FConfig.PowerTable) do begin
      if FConfig.PowerTable[B] = '-' then begin
         MainForm.HideBandMenu(B);
      end;
   end;

   if FConfig.UseWarcBand = True then begin
      MainForm.BandMenu.Items[ord(b10)].Visible := True;
      MainForm.BandMenu.Items[ord(b18)].Visible := True;
      MainForm.BandMenu.Items[ord(b24)].Visible := True;
   end
   else begin
      MainForm.HideBandMenuWarc();
   end;

   SerialContestType := FConfig.SerialContestType;

   for B := b19 to High(FConfig.SerialArray) do begin
      SerialArray[B] := FConfig.SerialArray[B];
   end;

   if SerialContestType = 0 then begin
      MainForm.EditScreen := TGeneralEdit.Create(MainForm);
   end
   else begin
      MainForm.EditScreen := TSerialGeneralEdit.Create(MainForm);

      MainForm.Grid.Cells[MainForm.EditScreen.colNewMulti1, 0] := 'prefix';

      TSerialGeneralEdit(MainForm.EditScreen).formMulti := TGeneralMulti2(MultiForm);

      Log.QsoList[0].Serial := $01; // uses serial number
      SameExchange := False;
      dmZlogGlobal.Settings._sameexchange := SameExchange;
   end;

   SentStr := dmZlogGlobal.Settings._sentstr;

   FNeedCtyDat := FConfig.UseCtyDat;
   FUseCoeff   := FConfig.Coeff;
end;

destructor TGeneralContest.Destroy();
begin
   Inherited;
   FConfig.Free();
end;

procedure TGeneralContest.SetPoints(var aQSO: TQSO);
begin
   TGeneralScore(ScoreForm).CalcPoints(aQSO);
end;

procedure TMainForm.GridAdd(aQSO: TQSO);
var
   L: TQSOList;
begin
   if ShowCurrentBandOnly.Checked and (aQSO.Band <> CurrentQSO.Band) then begin
      Exit;
   end;

   if ShowCurrentBandOnly.Checked then begin
      L := Log.BandList[CurrentQSO.Band];
   end
   else begin
      L := Log.QsoList;
   end;

   GridWriteQSO(L.Count, aQSO);

   GridRefreshScreen;
end;

procedure TMainForm.GridWriteQSO(R: Integer; aQSO: TQSO);
var
   temp: string;
   editor: TBasicEdit;
begin
   editor := EditScreen;
   with Grid do begin
      Objects[0, R] := aQSO;

      if editor.colSerial >= 0 then
         Cells[editor.colSerial, R] := aQSO.SerialStr;

      if editor.colTime >= 0 then
         Cells[editor.colTime, R] := aQSO.TimeStr;

      if editor.colCall >= 0 then
         Cells[editor.colCall, R] := aQSO.Callsign;

      if editor.colrcvdRST >= 0 then
         Cells[editor.colrcvdRST, R] := aQSO.RSTStr;

      if editor.colrcvdNumber >= 0 then
         Cells[editor.colrcvdNumber, R] := aQSO.NrRcvd;

      if editor.colBand >= 0 then
         Cells[editor.colBand, R] := aQSO.BandStr;

      if editor.colMode >= 0 then
         Cells[editor.colMode, R] := aQSO.ModeStr;

      if editor.colNewPower >= 0 then
         Cells[editor.colNewPower, R] := aQSO.NewPowerStr;

      if editor.colPoint >= 0 then
         Cells[editor.colPoint, R] := aQSO.PointStr;

      if editor.colOp >= 0 then begin
         temp := IntToStr(aQSO.TX);
         if dmZlogGlobal.ContestCategory = ccMultiOpSingleTx then begin
            case aQSO.TX of
               0:
                  temp := 'R';
               1:
                  temp := 'M';
            end;
         end;
         Cells[editor.colOp, R] := temp + ' ' + aQSO.Operator;
      end;
      IntToStr(aQSO.Reserve3);

      if editor.colNewMulti1 >= 0 then
         Cells[editor.colNewMulti1, R] := editor.GetNewMulti1(aQSO);

      if editor.colMemo >= 0 then
         Cells[editor.colMemo, R] := aQSO.Memo; // + IntToStr(aQSO.Reserve3);

      if aQSO.Reserve = actLock then
         Cells[editor.colMemo, R] := 'locked';
   end;
end;

procedure TMainForm.GridClearQSO(R: Integer);
var
   i: Integer;
begin
   with Grid do begin
      Objects[0, R] := nil;
      for i := 0 to ColCount - 1 do begin
         Cells[i, R] := '';
      end;
   end;
end;

procedure TMainForm.GridRefreshScreen(fSelectRow: Boolean);
var
   i: Integer;
   L: TQSOList;
begin
   if ShowCurrentBandOnly.Checked then begin
      L := Log.BandList[CurrentQSO.Band];
   end
   else begin
      L := Log.QsoList;
   end;
   Grid.Tag := Integer(L);

   Grid.RowCount := (((L.Count div 50) + 1) * 50) + 1;

   for i := 1 to L.Count - 1 do begin
      GridWriteQSO(i, L.Items[i]);
   end;

   for i := L.Count to Grid.RowCount - 1 do begin
      GridClearQSO(i);
   end;

   Grid.ShowLast(L.Count - 1);

   Grid.Refresh;
end;

procedure TMainForm.SetGridWidth(editor: TBasicEdit);
var
   nColWidth: Integer;
   nRowHeight: Integer;
   fVisible: Boolean;
begin
   with Grid do begin
      ColCount := editor.GridColCount;

      nColWidth := Canvas.TextWidth('0') + 1;
      nRowHeight := Canvas.TextHeight('0') + 4;

      DefaultRowHeight := nRowHeight;

      // Serial Number
      if editor.colSerial >= 0 then begin
         Cells[editor.colSerial, 0] := 'serial';
         ColWidths[editor.colSerial] := editor.SerialWid * nColWidth;
         SerialEdit.Visible := True;
      end
      else begin
         SerialEdit.Visible := False;
      end;

      // Time
      if editor.colTime >= 0 then begin
         Cells[editor.colTime, 0] := 'time';
         ColWidths[editor.colTime] := editor.TimeWid * nColWidth;
      end;

      // Callsign
      if editor.colCall >= 0 then begin
         Cells[editor.colCall, 0] := 'call';
         ColWidths[editor.colCall] := editor.CallSignWid * nColWidth;
      end;

      // Rcvd RST
      if editor.colrcvdRST >= 0 then begin
         Cells[editor.colrcvdRST, 0] := 'RST';
         ColWidths[editor.colrcvdRST] := editor.rcvdRSTWid * nColWidth;
      end;

      // Rcvd NR
      if editor.colrcvdNumber >= 0 then begin
         Cells[editor.colrcvdNumber, 0] := 'rcvd';
         ColWidths[editor.colrcvdNumber] := editor.NumberWid * nColWidth;
      end;

      // Band
      if editor.colBand >= 0 then begin
         Cells[editor.colBand, 0] := 'band';
         ColWidths[editor.colBand] := editor.BandWid * nColWidth;
      end;

      // Mode
      if editor.colMode >= 0 then begin
         Cells[editor.colMode, 0] := 'mod';
         ColWidths[editor.colMode] := editor.ModeWid * nColWidth;
         ModeEdit.Visible := True;
      end
      else begin
         ModeEdit.Visible := False;
      end;

      // Power
      if editor.colNewPower >= 0 then begin
         Cells[editor.colNewPower, 0] := 'pwr';
         ColWidths[editor.colNewPower] := editor.NewPowerWid * nColWidth;
         fVisible := True;
      end
      else begin
         fVisible := False;
      end;
      if Assigned(PowerEdit) then begin
         PowerEdit.Visible := fVisible;
      end;

      // Point
      if editor.colPoint >= 0 then begin
         Cells[editor.colPoint, 0] := 'pts';
         ColWidths[editor.colPoint] := editor.PointWid * nColWidth;
      end;

      // New Multi1
      if editor.colNewMulti1 >= 0 then begin
         Cells[editor.colNewMulti1, 0] := 'new';
         ColWidths[editor.colNewMulti1] := editor.NewMulti1Wid * nColWidth;
      end;

      // New Multi2
      if editor.colNewMulti2 >= 0 then begin
         Cells[editor.colNewMulti2, 0] := 'new';
         ColWidths[editor.colNewMulti2] := editor.NewMulti2Wid * nColWidth;
      end;

      // Operator
      if editor.colOp >= 0 then begin
         Cells[editor.colOp, 0] := 'op';
         ColWidths[editor.colOp] := editor.OpWid * nColWidth;
         fVisible := True;
      end
      else begin
         fVisible := False;
      end;
      if Assigned(OpEdit) then begin
         OpEdit.Visible := fVisible;
      end;

      // Memo
      if editor.colMemo >= 0 then begin
         Cells[editor.colMemo, 0] := 'memo';
         ColWidths[editor.colMemo] := editor.MemoWid * nColWidth;
      end;

      Refresh();
   end;
end;

function TMainForm.GetGridColmunLeft(col: Integer): Integer;
var
   i, j: Integer;
begin
   if col = 0 then begin
      Result := 0;
      exit;
   end;

   j := 0;
   for i := 0 to col - 1 do begin
      j := j + Grid.ColWidths[i] + 1;
   end;

   Result := j;
end;

procedure TMainForm.SetEditFields1R(editor: TBasicEdit);
var
   h: Integer;

   procedure LayoutEdit(col: Integer; edit: TEdit);
   begin
      if col >= 0 then begin
         edit.Width := Grid.ColWidths[col];
         edit.Height := h;
         edit.Left := GetGridColmunLeft(col);
      end;
   end;
begin
   h := Grid.RowHeights[0];
   EditPanel1R.Height := h + 10;

   // Serial Number
   LayoutEdit(editor.colSerial, SerialEdit1);

   // Time
   LayoutEdit(editor.colTime, TimeEdit1);
   DateEdit1.Width := TimeEdit1.Width;
   DateEdit1.Left := TimeEdit1.Left;
   DateEdit1.Height := TimeEdit1.Height;

   // Callsign
   LayoutEdit(editor.colCall, CallsignEdit1);

   // Rcvd RST
   LayoutEdit(editor.colrcvdRST, RcvdRSTEdit1);

   // Rcvd NR
   LayoutEdit(editor.colrcvdNumber, NumberEdit1);

   // Band
   LayoutEdit(editor.colBand, BandEdit1);

   // Mode
   LayoutEdit(editor.colMode, ModeEdit1);

   // Mode
   LayoutEdit(editor.colNewPower, PowerEdit1);

   // Mode
   LayoutEdit(editor.colPoint, PointEdit1);

   // Operator
   LayoutEdit(editor.colOp, OpEdit1);

   // Memo
   LayoutEdit(editor.colMemo, MemoEdit1);
//   if editor.colMemo >= 0 then begin
//      MemoEdit.Left := GetGridColmunLeft(editor.colMemo);
      MemoEdit1.Width := EditPanel1R.Width - MemoEdit1.Left - 3;
//      MemoEdit.Height := h;
//   end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
   i, j, mSec: Integer;
   S, ss: string;
   b: TBand;
begin
   FInitialized   := False;

   // QSO Editパネルの初期設定
   InitQsoEditPanel();
   UpdateQsoEditPanel(1);

   FRigControl    := TRigControl.Create(Self);
   FRigControl.OnVFOChanged := DoVFOChange;
   FPartialCheck  := TPartialCheck.Create(Self);
   FRateDialog    := TRateDialog.Create(Self);
   FRateDialogEx  := TRateDialogEx.Create(Self);
   FSuperCheck    := TSuperCheck.Create(Self);
   FSuperCheck2   := TSuperCheck2.Create(Self);
   FCommForm      := TCommForm.Create(Self);
   FCWKeyBoard    := TCWKeyBoard.Create(Self);
   FChatForm      := TChatForm.Create(Self);
   FZServerInquiry := TZServerInquiry.Create(Self);
   FZLinkForm     := TZLinkForm.Create(Self);
   FSpotForm      := TSpotForm.Create(Self);
   FConsolePad    := TConsolePad.Create(Self);
   FFreqList      := TFreqList.Create(Self);
   FCheckCall2    := TCheckCall2.Create(Self);
   FCheckMulti    := TCheckMulti.Create(Self);
   FCheckCountry  := TCheckCountry.Create(Self);
   FScratchSheet  := TScratchSheet.Create(Self);
   FQuickRef      := TQuickRef.Create(Self);
   FZAnalyze      := TZAnalyze.Create(Self);
   FCWMessagePad  := TCwMessagePad.Create(Self);
   FVoiceForm     := TVoiceForm.Create(Self);
   FVoiceForm.OnNotifyStarted  := OnVoicePlayStarted;
   FVoiceForm.OnNotifyFinished := OnVoicePlayFinished;
   FFunctionKeyPanel := TformFunctionKeyPanel.Create(Self);
   FQsyInfoForm   := TformQsyInfo.Create(Self);
   FSo2rNeoCp     := TformSo2rNeoCp.Create(Self);
   FInformation   := TformInformation.Create(Self);
   FTTYConsole    := nil;

   FCurrentCQMessageNo := 101;
   FQsyFromBS := False;

   for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
      FBandScopeEx[b] := TBandScope2.Create(Self, b);
   end;
   FBandScope := TBandScope2.Create(Self, b19);
   FBandScope.CurrentBandOnly := True;

   FNPlusOneThread := nil;
   FSuperCheckDataLoadThread := nil;
   FSpcDataLoading := False;
   FSuperChecked := False;
   FSuperCheckList := nil;
   for i := 0 to 255 do begin
      for j := 0 to 255 do begin
         FTwoLetterMatrix[i, j] := nil;
      end;
   end;

   ReadKeymap();

   defaultTextColor := CallsignEdit.Font.Color;
   OldCallsign := '';
   OldNumber := '';

   EditScreen := nil;
   clStatusLine := clWindowText;
   mSec := dmZlogGlobal.Settings.CW._interval;
   S := '';

   SaveInBackGround := False;
   TabPressed := False;
   TabPressed2 := False;
   LastTabPress := Now;
   FPostContest := False;

   Application.OnIdle := MyIdleEvent;
   Application.OnMessage := MyMessageEvent;
//   Application.OnHint := ShowHint;

   for i := 0 to ParamCount do begin
      S := S + ' ' + ParamStr(i);
      ss := ParamStr(i);
      if Pos('/I', UpperCase(ss)) = 1 then begin
         Delete(ss, 1, 2);
         j := StrToIntDef(ss, 0);
         if (j > 0) and (j < 100) then begin
            mSec := j;
         end;
      end;
   end;

   if (Pos('/NOBGK', UpperCase(S)) = 0) then begin
      if GetAsyncKeyState(VK_SHIFT) = 0 then begin
         dmZLogKeyer.OnCallsignSentProc := CallsignSentProc;
         dmZLogKeyer.OnPaddle := OnPaddle;
         dmZLogKeyer.OnSpeedChanged := DoCwSpeedChange;
         dmZLogKeyer.OnSendFinishProc := DoMessageSendFinish;
         dmZLogKeyer.OnWkAbortProc := DoWkAbortProc;
         dmZLogKeyer.OnWkStatusProc := DoWkStatusProc;
         dmZLogKeyer.OnSendRepeatEvent := DoSendRepeatProc;
         dmZLogKeyer.InitializeBGK(mSec);
      end;
   end;

   RenewCWToolBar;
   LastFocus := CallsignEdit; { the place to set focus when ESC is pressed from Grid }

   CurrentQSO := TQSO.Create;
   Randomize;
   GLOBALSERIAL := Random10 * 1000; // for qso id

   with CurrentQSO do begin
      NrSent := '';
      mode := mCW;
      Band := b7;

      Operator := '';
      TX := dmZlogGlobal.TXNr;
      Reserve3 := dmZlogGlobal.NewQSOID();
   end;

   NumberEdit.Text := '';
   BandEdit.Text := MHzString[CurrentQSO.Band];
   PowerEdit.Text := NewPowerString[CurrentQSO.Power];
   PointEdit.Text := CurrentQSO.PointStr;
   RcvdRSTEdit.Text := CurrentQSO.RSTStr;
   CurrentQSO.UpdateTime;
   TimeEdit.Text := CurrentQSO.TimeStr;
   DateEdit.Text := CurrentQSO.DateStr;

   if dmZlogGlobal.Settings._backuppath = '' then begin
      Backup1.Enabled := False;
   end;

   BuildOpListMenu(OpMenu, OpMenuClick);

   FTempQSOList := TQSOList.Create();

   RestoreWindowsPos();

   dmZLogKeyer.ControlPTT(0, False);
   dmZLogKeyer.ControlPTT(1, False);

   // フォントサイズの設定
   SetFontSize(dmZlogGlobal.Settings._mainfontsize);
   FFunctionKeyPanel.Init();

   {$IFDEF WIN32}
   menuPluginManager.Visible := False;
   {$ENDIF}

   zyloRuntimeLaunch;
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
   WriteStatusLine(Application.Hint, False);
end;

procedure TMainForm.FileNew(Sender: TObject);
var
   R: word;
begin
   if Log.Saved = False then begin
      R := MessageDlg('Save changes to ' + CurrentFileName + ' ?', mtConfirmation, [mbYes, mbNo, mbCancel], 0); { HELP context 0 }
      case R of
         mrYes:
            FileSave(Sender);
         mrCancel:
            exit;
      end;
   end;

   Grid.Row := 1;
   Grid.Col := 1;

   zyloContestClosed;

   { Add code to create a new file }
   PostMessage(Handle, WM_ZLOG_INIT, 0, 0);
end;

procedure TMainForm.FileOpen(Sender: TObject);
begin
   OpenDialog.Title := 'Open file';
   OpenDialog.InitialDir := dmZlogGlobal.Settings._logspath;
   OpenDialog.FileName := '';

   if OpenDialog.Execute then begin
      zyloContestClosed;
      WriteStatusLine('Loading...', False);
      dmZLogGlobal.SetLogFileName(OpenDialog.filename);
      LoadNewContestFromFile(OpenDialog.filename);
      MyContest.Renew;
      WriteStatusLine('', False);
      SetWindowCaption();
      GridRefreshScreen(False);
      FRateDialog.UpdateGraph();
      FRateDialogEx.UpdateGraph();
   end;
end;

procedure TMainForm.FileSave(Sender: TObject);
begin
   if CurrentFileName <> '' then begin
      Log.SaveToFile(CurrentFileName);
   end
   else begin
      FileSaveAs(Self);
   end;
   { Add code to save current file under current name }
end;

procedure TMainForm.FileSaveAs(Sender: TObject);
begin
   if SaveDialog.Execute then begin
      Log.SaveToFile(SaveDialog.filename);
      dmZLogGlobal.SetLogFileName(SaveDialog.filename);
      SetWindowCaption();
      { Add code to save current file under SaveDialog.FileName }
   end;
end;

function ExecuteFile(const filename, Params, DefaultDir: string; ShowCmd: Integer): THandle;
var
   zFileName, zParams, zDir: array [0 .. 79] of Char;
begin
   Result := ShellExecute(MainForm.Handle, nil, StrPCopy(zFileName, filename), StrPCopy(zParams, Params), StrPCopy(zDir, DefaultDir), ShowCmd);
end;

procedure TMainForm.FilePrint(Sender: TObject);
var
   R: Integer;
   S: string;
begin

   if Log.Saved = False then begin
      R := MessageDlg('Save changes to ' + CurrentFileName + ' ?', mtConfirmation, [mbYes, mbNo, mbCancel], 0); { HELP context 0 }
      case R of
         mrYes:
            FileSave(Sender);
         mrCancel:
            exit;
      end;
   end;

   R := ExecuteFile('zprintw', // CurrentFileName,
      ExtractFileName(CurrentFileName), ExtractFilePath(ParamStr(0)), SW_SHOW);

   if R > 32 then
      exit; { successful }

   S := 'Unknown error';
   case R of
      0:
         S := 'Out of memory or resources';
      ERROR_FILE_NOT_FOUND:
         S := 'ZPRINTW.EXE not found';
   end;
   WriteStatusLine(S, True);
end;

procedure TMainForm.FilePrintSetup(Sender: TObject);
begin
   // PrinterSetup.Execute;
end;

procedure TMainForm.RestoreWindowStates;
var
   b: TBand;
begin
   dmZlogGlobal.ReadWindowState(FCheckCall2);
   dmZlogGlobal.ReadWindowState(FPartialCheck);
   dmZlogGlobal.ReadWindowState(FSuperCheck);
   dmZlogGlobal.ReadWindowState(FSuperCheck2);
   dmZlogGlobal.ReadWindowState(FCheckMulti);
   dmZlogGlobal.ReadWindowState(FCWKeyBoard);
   dmZlogGlobal.ReadWindowState(FRigControl, '', True);
   dmZlogGlobal.ReadWindowState(FChatForm);
   dmZlogGlobal.ReadWindowState(FFreqList);
   dmZlogGlobal.ReadWindowState(FCommForm);
   dmZlogGlobal.ReadWindowState(FScratchSheet);
   dmZlogGlobal.ReadWindowState(FRateDialog);
   dmZlogGlobal.ReadWindowState(FRateDialogEx);
   dmZlogGlobal.ReadWindowState(FZAnalyze);
   dmZlogGlobal.ReadWindowState(FCwMessagePad);
   dmZlogGlobal.ReadWindowState(FFunctionKeyPanel);
   dmZlogGlobal.ReadWindowState(FQsyInfoForm);
   dmZlogGlobal.ReadWindowState(FSo2rNeoCp, '', True);
   dmZlogGlobal.ReadWindowState(FInformation);
   dmZlogGlobal.ReadWindowState(FZLinkForm);

   for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
      dmZlogGlobal.ReadWindowState(FBandScopeEx[b], 'BandScope(' + MHzString[b] + ')');
   end;
   dmZlogGlobal.ReadWindowState(FBandScope, 'BandScope');

   FSuperCheck.Columns := dmZlogGlobal.SuperCheckColumns;
   FSuperCheck2.Columns := dmZlogGlobal.SuperCheck2Columns;
end;

procedure TMainForm.RecordWindowStates;
var
   b: TBand;
begin
   dmZlogGlobal.WriteWindowState(FCheckCall2);
   dmZlogGlobal.WriteWindowState(FPartialCheck);
   dmZlogGlobal.WriteWindowState(FSuperCheck);
   dmZlogGlobal.WriteWindowState(FSuperCheck2);
   dmZlogGlobal.WriteWindowState(FCheckMulti);
   dmZlogGlobal.WriteWindowState(FCWKeyBoard);
   dmZlogGlobal.WriteWindowState(FRigControl);
   dmZlogGlobal.WriteWindowState(FChatForm);
   dmZlogGlobal.WriteWindowState(FFreqList);
   dmZlogGlobal.WriteWindowState(FCommForm);
   dmZlogGlobal.WriteWindowState(FScratchSheet);
   dmZlogGlobal.WriteWindowState(FRateDialog);
   dmZlogGlobal.WriteWindowState(FRateDialogEx);
   dmZlogGlobal.WriteWindowState(FZAnalyze);
   dmZlogGlobal.WriteWindowState(FCwMessagePad);
   dmZlogGlobal.WriteWindowState(FFunctionKeyPanel);
   dmZlogGlobal.WriteWindowState(FQsyInfoForm);
   dmZlogGlobal.WriteWindowState(FSo2rNeoCp);
   dmZlogGlobal.WriteWindowState(FInformation);
   dmZlogGlobal.WriteWindowState(FZLinkForm);

   for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
      dmZlogGlobal.WriteWindowState(FBandScopeEx[b], 'BandScope(' + MHzString[b] + ')');
   end;
   dmZlogGlobal.WriteWindowState(FBandScope, 'BandScope');

   dmZlogGlobal.WriteMainFormState(Left, top, Width, Height, mnHideCWPhToolBar.Checked, mnHideMenuToolbar.Checked);
   dmZlogGlobal.SuperCheckColumns := FSuperCheck.Columns;
   dmZlogGlobal.SuperCheck2Columns := FSuperCheck2.Columns;
end;

procedure TMainForm.FileExit(Sender: TObject);
begin
   Close();
end;

procedure TMainForm.HelpContents(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTENTS, 0);
end;

procedure TMainForm.HelpSearch(Sender: TObject);
const
   EmptyString: PChar = '';
begin
   Application.HelpCommand(HELP_PARTIALKEY, LongInt(EmptyString));
end;

procedure TMainForm.HelpHowToUse(Sender: TObject);
begin
   Application.HelpCommand(HELP_HELPONHELP, 0);
end;

procedure TMainForm.HelpAbout(Sender: TObject);
begin
   menuAbout.Click();
end;

procedure TMainForm.HelpZyLOClick(Sender: TObject);
begin
   UPluginManager.BrowseURL(UPluginManager.URL_MANUAL);
end;

procedure TMainForm.ConsoleRigBandSet(B: TBand);
var
   Q: TQSO;
begin
   Q := TQSO.Create;
   Q.Band := B;

   if RigControl.Rig <> nil then begin
      RigControl.Rig.SetBand(Q);

      if CurrentQSO.Mode = mSSB then begin
         RigControl.Rig.SetMode(CurrentQSO);
      end;
   end;

   UpdateBand(Q.Band);

   Q.Free;
end;

procedure TMainForm.ProcessConsoleCommand(S: string);
var
   i: double;
   j: Integer;
   temp, temp2: string;
begin
   Delete(S, 1, 1);
   temp := S;

   // if S = 'ELOG' then
   // ELogJapanese.ShowModal;

   if Pos('WANTED', S) = 1 then begin
      Delete(temp, 1, 6);
      temp := TrimRight(temp);
      if temp <> '' then begin
         if CharInSet(temp[1], ['_', '/', '-']) = True then begin
            Delete(temp, 1, 1);
         end;
         FZLinkForm.PostWanted(CurrentQSO.Band, temp);
         MyContest.PostWanted(IntToStr(Ord(CurrentQSO.Band)) + ' ' + temp);
      end;
   end;

   if (Pos('CLEARWANTED', S) = 1) or (S = 'CLRWANTED') then begin
      MyContest.ClearWanted;
   end;

   if Pos('DELWANTED', S) = 1 then begin
      Delete(temp, 1, 9);
      temp := TrimRight(temp);
      if temp <> '' then begin
         if CharInSet(temp[1], ['_', '/', '-']) = True then begin
            Delete(temp, 1, 1);
         end;

         FZLinkForm.DelWanted(CurrentQSO.Band, temp);
         MyContest.DelWanted(IntToStr(Ord(CurrentQSO.Band)) + ' ' + temp);
      end;
   end;

   if (Pos('AUTOBANDSCOPE', S) = 1) or (Pos('AUTOBANDMAP', S) = 1) or (Pos('AUTOBS', S) = 1) then begin
      if Pos('OFF', S) > 0 then begin
         dmZlogGlobal.Settings._autobandmap := False;
         WriteStatusLine('Automatic band map OFF', False);
      end
      else begin
         dmZlogGlobal.Settings._autobandmap := True;
         WriteStatusLine('Automatic band map ON', False);
      end
   end;

   if S = 'T' then begin
      if FTTYConsole <> nil then begin
         FTTYConsole.Show;
      end;
   end;

   if S = 'MMTTY' then begin
      if Not Assigned(FTTYConsole) then begin
         mnMMTTY.Tag := 0;
         mnMMTTY.Click();
      end;
   end;

   if S = 'OP' then begin
      for j := 1 to OpMenu.Items.Count - 1 do begin
         FConsolePad.AddLine(FillRight(OpMenu.Items[j].Caption, 15) + FillLeft(IntToStr(Log.OpQSO(temp2)), 5));
      end;
      FConsolePad.AddLine('');
   end;

   if (S = 'DELDUPES') or (S = 'DELDUPE') then begin
      Log.RemoveDupes;
      MyContest.Renew;
   end;

   if S = 'EXITMMTTY' then begin
      if Assigned(FTTYConsole) then begin
         mnMMTTY.Tag := 1;
         mnMMTTY.Click();
      end;
   end;

   if S = 'MMCLR' then begin
      MMTTYBuffer := '';
   end;

   if S = 'SF' then begin
      FZLinkForm.SendRigStatus;
   end;

   if S = 'CQ' then begin
      SetCQ(True);
   end;

   if S = 'SP' then begin
      SetCQ(False);
   end;

   if S = 'CQ?' then begin
      if CurrentQSO.CQ then
         WriteStatusLine('CQ status : CQ', False)
      else
         WriteStatusLine('CQ status : SP', False);
   end;

   if ((S = 'MUL') or (S = 'MULTI') or (S = 'MULT')) and (dmZLogGlobal.ContestCategory = ccMultiOpSingleTx) then begin
      ChangeTxNr(1);

      if SerialEdit.Visible then begin
         if (dmZlogGlobal.Settings._syncserial) and (SerialContestType = SER_MS) then begin
            CurrentQSO.Serial := SerialArrayTX[CurrentQSO.TX];
            SerialEdit.Text := CurrentQSO.SerialStr;
         end;
      end;
   end;

   if (S = 'RUN') and (dmZLogGlobal.ContestCategory = ccMultiOpSingleTx) then begin
      ChangeTxNr(0);

      if SerialEdit.Visible then begin
         if (dmZlogGlobal.Settings._syncserial) and (SerialContestType = SER_MS) then begin
            CurrentQSO.Serial := SerialArrayTX[CurrentQSO.TX];
            SerialEdit.Text := CurrentQSO.SerialStr;
         end;
      end;
   end;

   if S = 'SERIALTYPE' then begin
      WriteStatusLine('SerialContestType = ' + IntToStr(SerialContestType), True);
   end;

   if S = 'TUNE' then begin
      actionCwTune.Execute();
   end;

   if (S = 'LF') or (S = 'LASTF') then begin
      actionSetLastFreq.Execute();
   end;

   if S = 'TV' then
      if RigControl.Rig <> nil then
         RigControl.Rig.ToggleVFO;

   if S = 'VA' then
      if RigControl.Rig <> nil then
         RigControl.Rig.SetVFO(0);

   if S = 'VB' then
      if RigControl.Rig <> nil then
         RigControl.Rig.SetVFO(1);

   if S = 'YAESUTEST' then
      if RigControl.Rig <> nil then
         RigControl.Rig.FILO := not(RigControl.Rig.FILO);

   if S = 'SC' then begin
      actionShowSuperCheck.Execute();
   end;

   if S = 'RESET' then begin
      if RigControl.Rig <> nil then
         RigControl.Rig.reset;
   end;

   if S = 'R1' then begin
      actionSelectRig1.Execute();
   end;

   if S = 'R2' then begin
      actionSelectRig2.Execute();
   end;

   if S = 'R3' then begin
      actionSelectRig3.Execute();
   end;

   if S = 'TR' then begin
      actionToggleRig.Execute();
   end;

   if Pos('TXNR', S) = 1 then begin
      if length(temp) = 4 then
         WriteStatusLine('TX# = ' + IntToStr(dmZlogGlobal.TXNr), True)
      else begin
         Delete(temp, 1, 4);
         j := StrToIntDef(temp, 0);

         ChangeTxNr(j);
      end;
   end;

   if (S = 'RUN1') and (dmZLogGlobal.ContestCategory = ccMultiOpTwoTx) then begin
      ChangeTxNr(0);
   end;

   if (S = 'RUN2') and (dmZLogGlobal.ContestCategory = ccMultiOpTwoTx) then begin
      ChangeTxNr(1);
   end;

   if Pos('PCNAME', S) = 1 then begin
      if length(temp) = 6 then
         WriteStatusLine('PC name is ' + dmZlogGlobal.Settings._pcname, True)
      else begin
         Delete(temp, 1, 7);
         temp := TrimRight(temp);
         dmZlogGlobal.Settings._pcname := temp;
         dmZlogGlobal.SaveCurrentSettings();
         // dmZlogGlobal.Ini.SetString('Z-Link', 'PCName', temp);
         WriteStatusLine('PC name set to ' + dmZlogGlobal.Settings._pcname, True);
      end;
   end;

   if (S = '19') then
      ConsoleRigBandSet(b19);

   if (S = '35') or (S = '3') or (S = '37') or (S = '38') then
      ConsoleRigBandSet(b35);

   if (S = '7') then
      ConsoleRigBandSet(b7);

   if (S = '10') then
      ConsoleRigBandSet(b10);

   if (S = '14') then
      ConsoleRigBandSet(b14);

   if (S = '18') then
      ConsoleRigBandSet(b18);

   if (S = '21') then
      ConsoleRigBandSet(b21);

   if (S = '24') then
      ConsoleRigBandSet(b24);

   if (S = '28') then
      ConsoleRigBandSet(b28);

   if (S = '50') then
      ConsoleRigBandSet(b50);

   if (S = '144') then
      ConsoleRigBandSet(b144);

   if (S = '430') then
      ConsoleRigBandSet(b430);

   if (S = '1200') then
      ConsoleRigBandSet(b1200);

   if (S = '2400') then
      ConsoleRigBandSet(b2400);

   if (S = '5600') then
      ConsoleRigBandSet(b5600);

   if (S = '10G') then
      ConsoleRigBandSet(b10G);

   if (S = 'VOICEON') then begin
      dmZLogKeyer.SetVoiceFlag(1);
   end;

   if (S = 'VOICEOFF') then begin
      dmZLogKeyer.SetVoiceFlag(0);
   end;

   if (S = 'MOVETOMEMO') then begin
      dmZlogGlobal.Settings._movetomemo := True;
   end;

   if (S = 'LQ') or (S = 'L') then
      SwitchLastQSOBandMode;

   if S = 'CWOFF' then begin
      dmZLogKeyer.CloseBGK;
   end;

   if S = 'CWON' then begin
      dmZLogKeyer.InitializeBGK(dmZlogGlobal.Settings.CW._interval);
      dmZLogGlobal.InitializeCW();
   end;

   i := StrToFloatDef(S, 0);

   if (i > 1799) and (i < 1000000) then begin
      if RigControl.Rig <> nil then begin
         RigControl.Rig.SetFreq(round(i * 1000), IsCQ());
         if CurrentQSO.Mode = mSSB then
            RigControl.Rig.SetMode(CurrentQSO);
         // ZLinkForm.SendRigStatus;
         FZLinkForm.SendFreqInfo(round(i * 1000));
      end
      else begin
         RigControl.TempFreq[CurrentQSO.Band] := i;
         FZLinkForm.SendFreqInfo(round(i * 1000));
      end;
   end;

   if Pos('SYNCSERIAL', S) = 1 then begin
      if Pos('OFF', S) > 0 then
         dmZlogGlobal.Settings._syncserial := False
      else
         dmZlogGlobal.Settings._syncserial := True;
   end;

   if Pos('QSYCOUNT', S) = 1 then begin
      if Pos('OFF', S) > 0 then
         dmZlogGlobal.Settings._qsycount := False
      else
         dmZlogGlobal.Settings._qsycount := True;
   end;

   if (Pos('HELP', S) = 1) or (S = 'H') then begin
      menuQuickReference.Click();
   end;

   if (Pos('MULTWARN', S) = 1) or (Pos('MULTW', S) = 1) or (Pos('MW', S) = 1) then begin
      if Pos('OFF', S) > 0 then
         dmZlogGlobal.Settings._multistationwarning := False
      else
         dmZlogGlobal.Settings._multistationwarning := True;
   end;

   if S = 'WRITEKEYMAP' then begin
      WriteKeymap();
   end;

   if S = 'READKEYMAP' then begin
      ReadKeymap();
   end;

   if S = 'RESETKEYMAP' then begin
      ResetKeymap();
   end;

   if S = 'CQRPTUP' then begin
      actionCqRepeatIntervalUp.Execute();
      Exit;
   end;
   if S = 'CQRPTDN' then begin
      actionCqRepeatIntervalDown.Execute();
      Exit;
   end;
   if Pos('CQRPT', S) = 1 then begin
      S := StringReplace(S, 'CQRPT', '', [rfReplaceAll]);
      dmZLogGlobal.Settings.CW._cqrepeat := StrToFloatDef(S, 2.0);
      ApplyCQRepeatInterval();
      Exit;
   end;

   if S = 'CQ1' then begin
      actionSetCqMessage1.Execute();
   end;
   if S = 'CQ2' then begin
      actionSetCqMessage2.Execute();
   end;
   if S = 'CQ3' then begin
      actionSetCqMessage3.Execute();
   end;

   if S = 'RIT' then begin
      actionToggleRit.Execute();
   end;
   if S = 'XIT' then begin
      actionToggleXit.Execute();
   end;
   if (S = 'RC') or (S = 'RCLR') then begin
      actionRitClear.Execute();
   end;
   if S = 'MC' then begin
      actionToggleAntiZeroin.Execute();
   end;
   if S = 'AZ' then begin
      actionAntiZeroin.Execute();
   end;
end;

procedure TMainForm.ChangeTxNr(txnr: Byte);
begin
   case dmZLogGlobal.ContestCategory of
      ccSingleOp: Exit;
      ccMultiOpMultiTx: begin
         if {(txnr < 0) or} (txnr > 9) then begin
            Exit;
         end;

         WriteStatusLine('TX# set to ' + IntToStr(txnr), True);
      end;

      ccMultiOpSingleTx: begin
         if (txnr <> 0) and (txnr <> 1) then begin
            Exit;
         end;

         if txnr = 0 then begin
            WriteStatusLine('Running station', True);
         end
         else begin
            WriteStatusLine('Multi station', True);
         end;
      end;

      ccMultiOpTwoTx: begin
         if (txnr <> 0) and (txnr <> 1) then begin
            Exit;
         end;

         WriteStatusLine('TX# set to ' + IntToStr(txnr), True);
      end;
   end;

   dmZlogGlobal.TXNr := txnr;
   CurrentQSO.TX := dmZlogGlobal.TXNr;

   SetWindowCaption();
   ReEvaluateCountDownTimer;
   ReEvaluateQSYCount;
end;

procedure TMainForm.IncFontSize();
var
   j: Integer;
begin
   j := EditPanel1R.Font.Size;
   if j < 21 then begin
      Inc(j);
   end
   else begin
      j := 9;
   end;

   SetFontSize(j);
end;

procedure TMainForm.DecFontSize();
var
   j: Integer;
begin
   j := EditPanel1R.Font.Size;
   if j > 9 then begin
      Dec(j);
   end
   else begin
      j := 21;
   end;

   SetFontSize(j);
end;

procedure TMainForm.SetFontSize(font_size: Integer);
var
   b: TBand;
begin
   EditPanel1R.Font.Size := font_size;
   Grid.Font.Size := font_size;
   Grid.Refresh();

   dmZlogGlobal.Settings._mainfontsize := font_size;

   PostMessage(Handle, WM_ZLOG_SETGRIDCOL, 0, 0);

   FSuperCheck.FontSize := font_size;
   FSuperCheck2.FontSize := font_size;
   FPartialCheck.FontSize := font_size;
   FCommForm.FontSize := font_size;
   if MyContest <> nil then begin
      MyContest.ScoreForm.FontSize := font_size;
      MyContest.MultiForm.FontSize := font_size;
   end;

   for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
      FBandScopeEx[b].FontSize := font_size;
   end;
   FBandScope.FontSize := font_size;

   FCWMessagePad.FontSize := font_size;

   FFreqList.FontSize := font_size;
   FCheckCall2.FontSize := font_size;
   FCheckMulti.FontSize := font_size;
   FCheckCountry.FontSize := font_size;
   FFunctionKeyPanel.FontSize := font_size;
end;

procedure TMainForm.SwitchCWBank(Action: Integer); // 0 : toggle; 1,2 bank#)
var
   back_color: TColor;
begin
   if Action = 0 then begin
      if dmZlogGlobal.Settings.CW.CurrentBank = 1 then
         dmZlogGlobal.Settings.CW.CurrentBank := 2
      else
         dmZlogGlobal.Settings.CW.CurrentBank := 1;
   end
   else
      dmZlogGlobal.Settings.CW.CurrentBank := Action;

   if dmZlogGlobal.Settings.CW.CurrentBank = 1 then begin
      back_color := clGreen;
      WriteStatusLine('CW Bank A', False)
   end
   else begin
      back_color := clMaroon;
      WriteStatusLine('CW Bank B', False);
   end;

   CWF1.Hint := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 1);
   CWF2.Hint := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 2);
   CWF3.Hint := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 3);
   CWF4.Hint := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 4);
   CWF5.Hint := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 5);
   CWF6.Hint := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 6);
   CWF7.Hint := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 7);
   CWF8.Hint := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 8);
   CWF9.Hint := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 9);
   CWF10.Hint := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 10);
   CWF11.Hint := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 11);
   CWF12.Hint := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 12);
   CWF1.FaceColor := back_color;
   CWF2.FaceColor := back_color;
   CWF3.FaceColor := back_color;
   CWF4.FaceColor := back_color;
   CWF5.FaceColor := back_color;
   CWF6.FaceColor := back_color;
   CWF7.FaceColor := back_color;
   CWF8.FaceColor := back_color;
   CWF9.FaceColor := back_color;
   CWF10.FaceColor := back_color;
   CWF11.FaceColor := back_color;
   CWF12.FaceColor := back_color;

   FFunctionKeyPanel.UpdateInfo();
end;

procedure TMainForm.EditKeyPress(Sender: TObject; var Key: Char);
var
   Q: TQSO;
   S: string;
begin
   if CallsignEdit.Font.Color = clGrayText then begin
      if Key <> ' ' then begin
         CallsignEdit.Text := OldCallsign;
         NumberEdit.Text := OldNumber;
      end;

      CallsignEdit.Font.Color := defaultTextColor;
      NumberEdit.Font.Color := defaultTextColor;

      if Key <> ' ' then begin
         exit;
      end;
   end;

   case Key of
      '!': begin
         dmZLogKeyer.ToggleFixedSpeed();
         Key := #0;
      end;

      '-': begin // up key
         dmZLogKeyer.ToggleFixedSpeed();
         Key := #0;
      end;

      ' ': begin
         if Sender = CallsignEdit then begin { if space is pressed when Callsign edit is in focus }
            Key := #0;

            if CallsignEdit.Text = '' then begin
               NumberEdit.SetFocus;
               Exit;
            end;

            Q := Log.QuickDupe(CurrentQSO);
            if Q <> nil then begin
               MessageBeep(0);

               if dmZLogGlobal.Settings._allowdupe = True then begin
                  MyContest.SpaceBarProc;
                  NumberEdit.SetFocus;
               end
               else begin
                  CallsignEdit.SelectAll;
               end;

               WriteStatusLineRed(Q.PartialSummary(dmZlogGlobal.Settings._displaydatepartialcheck), True);
               Exit;
            end
            else begin { if not dupe }
               WriteStatusLine('', False);
               MyContest.SpaceBarProc;
            end;

            NumberEdit.SetFocus;
         end
         else begin
            Key := #0;
            if FPostContest and
               ((Sender = NumberEdit1) or (Sender = NumberEdit2A) or (Sender = NumberEdit2B)) then begin
               if TimeEdit.Visible then
                  TimeEdit.SetFocus;
               if DateEdit.Visible then
                  DateEdit.SetFocus;
            end
            else begin
               CallsignEdit.SetFocus;
            end;
         end;
      end;

      // Enter / SHIFT+Enter
      Char($0D): begin
         S := CallsignEdit.Text;
         if CallsignEdit.Focused and (Pos(',', S) = 1) then begin
            CallsignEdit.Text := '';
            ProcessConsoleCommand(S);
         end
         else begin
            if GetAsyncKeyState(VK_SHIFT) < 0 then begin
               CurrentQSO.Reserve2 := $FF;
            end;

            LogButtonClick(Self);
         end;
         Key := #0;
      end;
   end;
   { of case }
end;

procedure TMainForm.CallsignEdit1Change(Sender: TObject);
begin
   CurrentQSO.Callsign := CallsignEdit.Text;

   dmZLogKeyer.SetCallSign(CallsignEdit.Text);

   if EditedSinceTABPressed = tabstate_tabpressedbutnotedited then begin
      EditedSinceTABPressed := tabstate_tabpressedandedited;
   end;

   if FPartialCheck.Visible and FPartialCheck._CheckCall then begin
      FPartialCheck.CheckPartial(CurrentQSO);
   end;

   if FSuperCheck.Visible then begin
      CheckSuper(CurrentQSO);
   end;

   if FSuperCheck2.Visible then begin
      CheckSuper2(CurrentQSO);
   end;

   if FCheckCall2.Visible then begin
      FCheckCall2.Renew(CurrentQSO);
   end;
end;

procedure TMainForm.NumberEdit1Change(Sender: TObject);
begin
   CurrentQSO.NrRcvd := NumberEdit.Text;

   if Assigned(MyContest) then begin
      if MyContest.MultiForm.IsIncrementalSearchPresent = True then begin
         MyContest.MultiForm.CheckMulti(CurrentQSO);
      end;
   end;
end;

procedure TMainForm.BandEdit1Click(Sender: TObject);
var
   e: TEdit;
   pt: TPoint;
begin
   e := TEdit(Sender);
   pt.X := e.Left + 20;
   pt.Y := e.Top;
   pt := TPanel(e.Parent).ClientToScreen(pt);

   BandMenu.Popup(pt.X, pt.Y);
end;

procedure TMainForm.ModeMenuClick(Sender: TObject);
begin
   QSY(CurrentQSO.Band, TMode(TMenuItem(Sender).Tag), 0);
   LastFocus.SetFocus;
end;

procedure TMainForm.MemoEdit1Change(Sender: TObject);
begin
   CurrentQSO.Memo := MemoEdit.Text;
end;

procedure TMainForm.ModeEdit1Click(Sender: TObject);
var
   e: TEdit;
   pt: TPoint;
begin
   e := TEdit(Sender);
   pt.X := e.Left + 20;
   pt.Y := e.Top;
   pt := TPanel(e.Parent).ClientToScreen(pt);

   ModeMenu.Popup(pt.X, pt.Y);
end;

procedure TMainForm.GridMenuPopup(Sender: TObject);
var
   i: Integer;
begin
   SendSpot1.Enabled := FCommForm.MaybeConnected;

   mChangePower.Visible := PowerEdit1.Visible;

   for i := 0 to Ord(HiBand) do begin
      GBand.Items[i].Visible := BandMenu.Items[i].Visible;
      GBand.Items[i].Enabled := BandMenu.Items[i].Enabled;
   end;

   BuildOpListMenu2(GOperator, GridOperatorClick);
   BuildTxNrMenu2(mnChangeTXNr, mnChangeTXNrClick);

   if Grid.Row > Log.TotalQSO then begin
      for i := 0 to GridMenu.Items.Count - 1 do
         GridMenu.Items[i].Enabled := False;
   end
   else begin
      for i := 0 to GridMenu.Items.Count - 1 do
         GridMenu.Items[i].Enabled := True;
   end;
end;

procedure TMainForm.LoadNewContestFromFile(filename: string);
var
   Q: TQSO;
   boo, Boo2: Boolean;
   i: Integer;
   b: TBand;
begin
   // 一度はCreateLogされてる前提
   Q := TQSO.Create();
   Q.Assign(Log.QsoList[0]);
   boo := Log.AcceptDifferentMode;
   Boo2 := Log.CountHigherPoints;

   dmZLogGlobal.CreateLog();

   Log.AcceptDifferentMode := boo;
   Log.CountHigherPoints := Boo2;
   Log.QsoList[0].Assign(Q); // contest info is set to current contest.
   Q.Free();

   Log.LoadFromFile(filename);

   // 各バンドのSerialを復帰
   // SerialArrayには次の番号を入れる
   for b := b19 to HiBand do begin
      SerialArray[b] := 0;
   end;
   for i := 1 to Log.TotalQSO do begin
      Q := Log.QsoList[i];
      SerialArray[Q.Band] := Q.Serial;
   end;
   for b := b19 to HiBand do begin
      Inc(SerialArray[b]);
   end;

   // 最後のレコード取りだし
   Q := Log.QsoList[Log.TotalQSO];

   // 現在QSOへセット
   CurrentQSO.Assign(Q);
   CurrentQSO.Band := Q.Band;
   CurrentQSO.Mode := Q.Mode;
   CurrentQSO.Callsign := '';
   CurrentQSO.NrRcvd := '';
   CurrentQSO.Time := Date + Time;
   CurrentQSO.TX := dmZlogGlobal.TXNr;
//   CurrentQSO.Serial := SerialArray[Q.Band];
   CurrentQSO.Memo := '';

   // 画面に表示
   ShowCurrentQSO();

   WriteStatusLine('', False);

   Log.Saved := True;
end;

Procedure TMainForm.DeleteCurrentRow;
var
   aQSO: TQSO;
begin
   aQSO := TQSO(Grid.Objects[0, Grid.Row]);
   FZLinkForm.DeleteQSO(aQSO);
   Log.DeleteQSO(aQSO);
   MyContest.Renew;
end;

Procedure TMainForm.MultipleDelete(A, B: LongInt);
var
   i: Integer;
   aQSO: TQSO;
begin
   for i := B downto A do begin
      aQSO := TQSO(Grid.Objects[0, i]);
      if aQSO.Reserve = actLock then begin
         //
      end
      else begin
         FZLinkForm.DeleteQSO(aQSO);
         Log.DeleteQSO(aQSO);
      end;
   end;

   MyContest.Renew;
end;

procedure TMainForm.DeleteQSO1Click(Sender: TObject);
var
   _top, _bottom: LongInt;
   R: word;
   aQSO: TQSO;
   L: TQSOList;
begin
   with Grid do begin
      _top := Selection.top;
      _bottom := Selection.Bottom;
   end;

   if _top = _bottom then begin
      aQSO := TQSO(Grid.Objects[0, _top]);
      if aQSO.Reserve = actLock then begin
         WriteStatusLine('This QSO is currently locked', True);
         exit;
      end;
      R := MessageDlg('Are you sure to delete this QSO?', mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
      if R = mrNo then
         exit;

      DeleteCurrentRow;
   end
   else begin
      if ShowCurrentBandOnly.Checked then begin
         L := Log.BandList[CurrentQSO.Band];
      end
      else begin
         L := Log.QsoList;
      end;

      if (_top < L.Count - 1) and (_bottom <= L.Count - 1) then begin
         R := MessageDlg('Are you sure to delete these QSO''s?', mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
         if R = mrNo then begin
            exit;
         end;

         MultipleDelete(_top, _bottom);
      end;
   end;

   Log.SetDupeFlags;

   GridRefreshScreen();
end;

procedure TMainForm.GridKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
   L: TQSOList;
begin
   if ShowCurrentBandOnly.Checked then begin
      L := Log.BandList[CurrentQSO.Band];
   end
   else begin
      L := Log.QsoList;
   end;

   case Key of
      VK_DELETE: begin
            DeleteQSO1Click(Self);
            Grid.SetFocus;
      end;

      VK_INSERT: begin
            InsertQSO1Click(Self);
            Grid.SetFocus;
      end;

      VK_RETURN: begin
         MyContest.EditCurrentRow;
      end;

      VK_ESCAPE: begin
         Grid.LeftCol := 0;
         Grid.ShowLast(L.Count - 1);
         LastFocus.SetFocus;
      end;
   end;
end;

procedure TMainForm.EditQSOClick(Sender: TObject);
begin
   MyContest.EditCurrentRow;
end;

procedure TMainForm.OnTabPress;
var
   S: String;
   Q: TQSO;
   nID: Integer;
begin
   // PHONE
   if Main.CurrentQSO.Mode in [mSSB, mFM, mAM] then begin
      Q := Log.QuickDupe(CurrentQSO);
      if Q <> nil then begin  // dupe
         // ALLOW DUPEしない場合は4番を送出
         if dmZLogGlobal.Settings._allowdupe = False then begin
            CallsignEdit.SelectAll;
            CallsignEdit.SetFocus;
            PlayMessage(1, 4);
         end
         else begin
            MyContest.SpaceBarProc;
            NumberEdit.SetFocus;
            PlayMessage(1, 2);
         end;

         S := Q.PartialSummary(dmZlogGlobal.Settings._displaydatepartialcheck);
         WriteStatusLineRed(S, True);
         Exit;
      end
      else begin  // not dupe
         MyContest.SpaceBarProc;
         NumberEdit.SetFocus;
         PlayMessage(1, 2);
         Exit;
      end;
   end;

   // RTTY
   if Main.CurrentQSO.Mode = mRTTY then begin
      TabPressed := True;
      if FTTYConsole <> nil then
         FTTYConsole.SendStrNow(SetStrNoAbbrev(dmZlogGlobal.CWMessage(3, 2), CurrentQSO));
      MyContest.SpaceBarProc;
      NumberEdit.SetFocus;
      exit;
   end;

   // CW
   if NumberEdit.Text = '' then begin
      CurrentQSO.UpdateTime;
      TimeEdit.Text := CurrentQSO.TimeStr;
      DateEdit.Text := CurrentQSO.DateStr;
   end;

   TabPressed := True;
   TabPressed2 := True;

   S := dmZlogGlobal.CWMessage(2);
   S := SetStr(S, CurrentQSO);

   if dmZLogKeyer.UseWinKeyer = True then begin

      if dmZLogGlobal.Settings._so2r_type = so2rNeo then begin
         nID := GetCurrentRigID();
         dmZLogKeyer.So2rNeoReverseRx(nID)
      end;

      dmZLogKeyer.WinKeyerClear();
      dmZLogKeyer.WinKeyerControlPTT(True);

      if (CurrentQSO.CQ = True) or (dmZlogGlobal.Settings._switchcqsp = False) then begin
         dmZLogKeyer.WinkeyerSendCallsign(CurrentQSO.Callsign);
      end
      else begin
         CallsignSentProc(nil);
      end;
   end
   else begin
      dmZLogKeyer.ClrBuffer;
      dmZLogKeyer.PauseCW;
      if dmZlogGlobal.PTTEnabled then begin
         S := S + ')'; // PTT is turned on in ResumeCW
      end;

      dmZLogKeyer.SetCWSendBuf(0, S);
      if (CurrentQSO.CQ = True) or (dmZlogGlobal.Settings._switchcqsp = False) then begin
         dmZLogKeyer.SetCallSign(CurrentQSO.Callsign);
      end;
      dmZLogKeyer.ResumeCW;
   end;

//   if dmZlogGlobal.Settings._switchcqsp then begin
//      CallsignSentProc(nil);
//   end;
end;

procedure TMainForm.DownKeyPress;
var
   S: String;
   nID: Integer;
begin
   if CallsignEdit.Text = '' then begin
      exit;
   end;

   case CurrentQSO.Mode of
      mCW: begin
            if Not(MyContest.MultiForm.ValidMulti(CurrentQSO)) then begin
               // NR?自動送出使う場合
               if dmZlogGlobal.Settings.CW._send_nr_auto = True then begin
                  nID := GetCurrentRigID();
                  S := dmZlogGlobal.CWMessage(5);
                  zLogSendStr2(nID, S, CurrentQSO);
               end;

               WriteStatusLine('Invalid number', False);
               NumberEdit.SetFocus;
               NumberEdit.SelectAll;
               exit;
            end;

            // TU $M TEST
            nID := GetCurrentRigID();
            S := dmZlogGlobal.CWMessage(3);
            zLogSendStr2(nID, S, CurrentQSO);

            LogButtonClick(Self);
         end;

      mRTTY: begin
            if Not(MyContest.MultiForm.ValidMulti(CurrentQSO)) then begin
               S := dmZlogGlobal.CWMessage(3, 5);
               S := SetStrNoAbbrev(S, CurrentQSO);
               if FTTYConsole <> nil then begin
                  FTTYConsole.SendStrNow(S);
               end;
               WriteStatusLine('Invalid number', False);
               NumberEdit.SetFocus;
               NumberEdit.SelectAll;
               exit;
            end;

            S := dmZlogGlobal.CWMessage(3, 3);

            S := SetStrNoAbbrev(S, CurrentQSO);
            if FTTYConsole <> nil then begin
               FTTYConsole.SendStrNow(S);
            end;

            LogButtonClick(Self);
         end;

      mSSB, mFM, mAM: begin
            if Not(MyContest.MultiForm.ValidMulti(CurrentQSO)) then begin
               PlayMessage(1, 5);
               WriteStatusLine('Invalid number', False);
               NumberEdit.SetFocus;
               NumberEdit.SelectAll;
               exit;
            end;

            PlayMessage(1, 3);
            LogButtonClick(Self);
         end;
   end;
end;

procedure TMainForm.EditKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
   case Key of
      { MUHENKAN KEY }
      VK_NONCONVERT: begin
         {$IFDEF DEBUG}
         OutputDebugString(PChar('[無変換]'));
         {$ENDIF}
         actionControlPTT.Execute();
      end;

      VK_UP: begin
         Grid.Row := TQSOList(Grid.Tag).Count - 1;

         LastFocus := TEdit(Sender);
         Grid.SetFocus;

         Key := 0;
      end;

      Ord('A') .. Ord('Z'), Ord('0') .. Ord('9'): begin
         if Shift <> [] then begin
            exit;
         end;

         if (CtrlZCQLoop = True) and (TEdit(Sender).Name = 'CallsignEdit') then begin
            CtrlZBreak;
         end;

         if (FVoiceForm.CtrlZCQLoopVoice = True) and (TEdit(Sender).Name = 'CallsignEdit') then begin
            FVoiceForm.CtrlZBreakVoice();
         end;

         if (dmZlogGlobal.Settings._jmode) and (TEdit(Sender).Name = 'CallsignEdit') then begin
            if CallsignEdit.Text = '' then begin
               if (Key <> Ord('7')) and (Key <> Ord('8')) then begin
                  CallsignEdit.Text := 'J';
                  CallsignEdit.SelStart := 1;
               end;
            end;
         end;
      end;
   end;
end;

procedure TMainForm.GridDblClick(Sender: TObject);
begin
   MyContest.EditCurrentRow;
end;

procedure TMainForm.GridEnter(Sender: TObject);
begin
   SetShortcutEnabled('Esc', False);
end;

procedure TMainForm.GridExit(Sender: TObject);
begin
   SetShortcutEnabled('Esc', True);
end;

procedure TMainForm.CallsignEdit1KeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
   { if PartialCheck.Visible and PartialCheck._CheckCall then
     PartialCheck.CheckPartial(CurrentQSO);
     if SuperCheck.Visible then
     SuperCheck.CheckSuper(CurrentQSO);
     if CheckCall2.Visible then
     CheckCall2.Renew(CurrentQSO); }
end;

procedure TMainForm.LogButtonClick(Sender: TObject);
var
   _dupe, i, j: Integer;
   workedZLO: Boolean;
   st, st2: string;
   B: TBand;
begin
   EditedSinceTABPressed := tabstate_normal;

   // Callsign入力チェック
   if CurrentQSO.Callsign = '' then begin
      WriteStatusLine('Callsign not entered', False);
      CallsignEdit.SetFocus;
      Exit;
   end;

   // DUPEチェック
   _dupe := Log.IsDupe(CurrentQSO);

   if CurrentQSO.Reserve2 = $00 then begin   // 通常入力
      // DUPE
      if _dupe <> 0 then begin
         // DUPEは入力しない
         if dmZLogGlobal.Settings._allowdupe = False then begin
            CallsignEdit.SetFocus;
            CallsignEdit.SelectAll;
            WriteStatusLine('Dupe', False);
            Exit;
         end
         else begin // DUPEをallow
            CurrentQSO.Dupe := True;
            CurrentQSO.Points := 0;
            CurrentQSO.NewMulti1 := False;
            CurrentQSO.NewMulti2 := False;
            CurrentQSO.Multi1 := '';
            CurrentQSO.Multi2 := '';
            CurrentQSO.Memo := MEMO_DUPE + ' ' + CurrentQSO.Memo;
         end;
      end
      else begin  // UNIQUE!
         // 無効マルチは入力できない
         if MyContest.MultiForm.ValidMulti(CurrentQSO) = False then begin
            WriteStatusLine('Invalid number', False);
            NumberEdit.SetFocus;
            NumberEdit.SelectAll;
            Exit;
         end;
      end;
   end
   else begin     // 強制入力
      if _dupe <> 0 then begin
         CurrentQSO.Dupe := True;
      end;
      CurrentQSO.Points := 0;
      CurrentQSO.NewMulti1 := False;
      CurrentQSO.NewMulti2 := False;
      CurrentQSO.Multi1 := '';
      CurrentQSO.Multi2 := '';
      CurrentQSO.Memo := '* ' + CurrentQSO.Memo;
      CurrentQSO.Reserve2 := $00;
   end;

   // ここからがLoggingメイン処理
   MyContest.SetNrSent(CurrentQSO);

   repeat
      i := dmZlogGlobal.NewQSOID();
   until Log.CheckQSOID(i) = False;

   CurrentQSO.Reserve3 := i;

   if RigControl.Rig <> nil then begin
      // memo欄に周波数を記録
      if dmZlogGlobal.Settings._recrigfreq = True then begin
         CurrentQSO.Memo := CurrentQSO.Memo + '(' + RigControl.Rig.CurrentFreqkHzStr + ')';
      end;

      // 自動bandmap
      if dmZlogGlobal.Settings._autobandmap then begin
         j := RigControl.Rig.CurrentFreqHz;
         if j > 0 then begin
            BandScopeAddSelfSpot(CurrentQSO, j);
         end;
      end;
   end;

   // QSY Violation
   if FQsyViolation = True then begin
      SetQsyViolation(CurrentQSO);
   end;

   // if MyContest.Name = 'Pedition mode' then
   if not FPostContest then begin
      CurrentQSO.UpdateTime;
   end;

   // ログに記録
   MyContest.LogQSO(CurrentQSO, True);

   workedZLO := False;
   if CurrentQSO.Callsign = 'JA1ZLO' then begin
      if MyContest.Name = 'ALL JA コンテスト' then begin
         if CurrentQSO.Points > 0 then begin
            inc(ZLOCOUNT);
            workedZLO := True;
         end;
      end;
   end;

   // 自動保存
   if CurrentFileName <> '' then begin
      if Log.TotalQSO mod dmZlogGlobal.Settings._saveevery = 0 then begin
         if dmZlogGlobal.Settings._savewhennocw then
            SaveInBackGround := True
         else
            SaveFileAndBackUp;
      end;
   end;

   // 他のzLogに送信
   FZLinkForm.SendQSO(CurrentQSO); { ZLinkForm checks if Z-Link is ON }

   // WANTEDリスト交信
   st := MyContest.MultiForm.ExtractMulti(CurrentQSO);
   if st <> '' then begin
      for i := 0 to MyContest.WantedList.Count - 1 do begin
         if st = TWanted(MyContest.WantedList[i]).Multi then begin
            st2 := '';
            for B := b19 to HiBand do
               if B in TWanted(MyContest.WantedList[i]).Bands then
                  st2 := st2 + ' ' + BandString[B];
            MessageDlg(st + ' is wanted by' + st2, mtInformation, [mbOK], 0);
         end;
      end;
   end;

   if CurrentQSO.Mode = mCW then begin
      if RigControl.Rig <> nil then begin
         // RITクリア
         if (dmZlogGlobal.Settings._ritclear = True) or
            (dmZlogGlobal.Settings.FAntiZeroinAutoCancel = True) then begin
            RigControl.Rig.RitClear;
         end;

         // Anti Zeroin
         if dmZlogGlobal.Settings.FAntiZeroinAutoCancel = True then begin
            RigControl.Rig.Xit := False;
         end;
      end;
   end;

   // BandScopeの更新
   BandScopeNotifyWorked(CurrentQSO);

   // 次のＱＳＯの準備
   CurrentQSO.Serial := CurrentQSO.Serial + 1;
   SerialArrayTX[dmZlogGlobal.TXNr] := CurrentQSO.Serial;

   if Not(FPostContest) then
      CurrentQSO.UpdateTime;

   CurrentQSO.Callsign := '';
   CurrentQSO.NrRcvd := '';
   CurrentQSO.Memo := '';

   CurrentQSO.NewMulti1 := False;
   CurrentQSO.NewMulti2 := False;

   CurrentQSO.Dupe := False;
   // CurrentQSO.CQ := False;

   CurrentQSO.Reserve2 := 0;
   CurrentQSO.Reserve3 := 0;
   CurrentQSO.TX := dmZlogGlobal.TXNr;

   if CurrentQSO.Mode in [mCW, mRTTY] then begin
      CurrentQSO.RSTRcvd := 599;
   end
   else begin
      CurrentQSO.RSTRcvd := 59;
   end;

   SerialEdit.Text := CurrentQSO.SerialStr;
   TimeEdit.Text := CurrentQSO.TimeStr;
   DateEdit.Text := CurrentQSO.DateStr;
   CallsignEdit.Text := CurrentQSO.Callsign;
   RcvdRSTEdit.Text := CurrentQSO.RSTStr;
   NumberEdit.Text := CurrentQSO.NrRcvd;
   ModeEdit.Text := CurrentQSO.ModeStr;
   BandEdit.Text := CurrentQSO.BandStr;
   PowerEdit.Text := CurrentQSO.NewPowerStr;
   PointEdit.Text := CurrentQSO.PointStr;
   OpEdit.Text := CurrentQSO.Operator;
   MemoEdit.Text := '';

   if FPostContest then begin
      TimeEdit.SetFocus;
   end
   else begin
      CallsignEdit.SetFocus;
   end;

   WriteStatusLine('', False);

   if workedZLO then begin
      WriteStatusLine('QSOありがとうございます', False);
   end;
end;

procedure TMainForm.OptionsButtonClick(Sender: TObject);
begin
   menuOptions.Click();
end;

procedure TMainForm.panelCQModeClick(Sender: TObject);
begin
   actionToggleCqSp.Execute();
end;

procedure TMainForm.FormShow(Sender: TObject);
var
   X, Y, W, H: Integer;
   B, BB: Boolean;
begin
   dmZlogGlobal.ReadMainFormState(X, Y, W, H, B, BB);
   if (W > 0) and (H > 0) then begin
      if B then begin
         mnHideCWPhToolBar.Checked := True;
         CWToolBar.Height := 1;
         SSBToolBar.Height := 1;
      end;
      if BB then begin
         mnHideMenuToolbar.Checked := True;
         MainToolBar.Height := 1;
      end;
      Left := X;
      top := Y;
      Width := W;
      Height := H;
   end;

   if FPostContest then begin
      MessageDlg('To change the date, double click the time field.', mtInformation, [mbOK], 0); { HELP context 0 }
   end;

   PostMessage(Handle, WM_ZLOG_INIT, 0, 0);

//   zyloRuntimeLaunch;
end;

procedure TMainForm.CWFButtonClick(Sender: TObject);
var
   i: Integer;
begin
   i := THemisphereButton(Sender).Tag;
   PlayMessage(dmZlogGlobal.Settings.CW.CurrentBank, i);
end;

procedure TMainForm.FormDeactivate(Sender: TObject);
begin
   ActionList1.State := asSuspended;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
   b: TBand;
begin
   FCheckCall2.Release();
   FPartialCheck.Release();
   FSuperCheck.Release();
   FSuperCheck2.Release();
   FCheckMulti.Release();
   FCWKeyBoard.Release();
   FRigControl.Release();
   FChatForm.Release();
   FFreqList.Release();
   FCommForm.Release();
   FScratchSheet.Release();
   FRateDialog.Release();
   FRateDialogEx.Release();
   FZServerInquiry.Release();
   FZLinkForm.Release();
   FSpotForm.Release();
   FConsolePad.Release();
   FCheckCountry.Release();

   for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
      FBandScopeEx[b].Release();
   end;
   FBandScope.Release();

   if MyContest <> nil then begin
      dmZlogGlobal.WriteWindowState(MyContest.MultiForm, 'MultiForm');
      dmZlogGlobal.WriteWindowState(MyContest.ScoreForm, 'ScoreForm');
      MyContest.Free;
   end;

   EditScreen.Free();
   FTempQSOList.Free();
   FQuickRef.Release();
   FZAnalyze.Release();
   FCWMessagePad.Release();
   FVoiceForm.Release();
   FFunctionKeyPanel.Release();
   FQsyInfoForm.Release();
   FSo2rNeoCp.Release();
   FInformation.Release();

   if Assigned(FTTYConsole) then begin
      FTTYConsole.Release();
   end;

   CurrentQSO.Free();

   SuperCheckFreeData();

   zyloContestClosed;
   zyloRuntimeFinish;
end;

procedure TMainForm.SpeedBarChange(Sender: TObject);
begin
   dmZLogKeyer.WPM := SpeedBar.Position;
   dmZLogGlobal.Settings.CW._speed := SpeedBar.Position;
   SpeedLabel.Caption := IntToStr(SpeedBar.Position) + ' wpm';

   FInformation.WPM := SpeedBar.Position;

   if Active = True then begin
      if LastFocus <> nil then begin
         LastFocus.SetFocus;
      end;
   end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
   TIOTAMulti(MyContest.MultiForm).Show;
end;

procedure TMainForm.CWStopButtonClick(Sender: TObject);
begin
   CtrlZCQLoop := False;
   dmZLogKeyer.ClrBuffer;
   CWPlayButton.Visible := False;
   CWPauseButton.Visible := True;
   dmZLogKeyer.WinKeyerAbort();
end;

procedure TMainForm.VoiceStopButtonClick(Sender: TObject);
begin
   FVoiceForm.StopVoice;
end;

procedure TMainForm.SetCQ(CQ: Boolean);
begin
   CurrentQSO.CQ := CQ;

   FInformation.CQMode := CQ;

   if CQ = True then begin
      panelCQMode.Caption := 'CQ';
      panelCQMode.Font.Color := clBlue;
   end
   else begin
      panelCQMode.Caption := 'SP';
      panelCQMode.Font.Color := clFuchsia;

      // Stop CQ in SP modeがON
      if (dmZLogGlobal.Settings.FUseAntiZeroin = True) then begin
         // CQ停止
         if (dmZLogGlobal.Settings.FAntiZeroinStopCq = True) then begin
            actionCQAbort.Execute();
         end;
      end;
   end;

   FZLinkForm.SendRigStatus;

   if RigControl.Rig = nil then begin
      FZLinkForm.SendFreqInfo(round(RigControl.TempFreq[CurrentQSO.Band] * 1000));
   end;

   if dmZlogGlobal.Settings._switchcqsp then begin
      if CQ then
         SwitchCWBank(1)
      else
         SwitchCWBank(2);
   end;

   if (dmZLogGlobal.Settings.FUseAntiZeroin = True) and (CQ = True) and (CurrentQSO.Mode = mCW) then begin
      if RigControl.Rig <> nil then begin
         if dmZLogGlobal.Settings.FAntiZeroinRitOff = True then begin
            RigControl.Rig.Rit := False;
         end;
         if dmZLogGlobal.Settings.FAntiZeroinXitOff = True then begin
            RigControl.Rig.Xit := False;
         end;
         if dmZLogGlobal.Settings.FAntiZeroinRitClear = True then begin
            RigControl.Rig.RitClear();
         end;
      end;
   end;
end;

function TMainForm.IsCQ(): Boolean;
begin
   Result := CurrentQSO.CQ;
end;

procedure TMainForm.CQRepeatClick1(Sender: TObject);
begin
   SetCQ(True);
   CtrlZCQLoop := False;
   CQRepeatProc();
end;

procedure TMainForm.CQRepeatClick2(Sender: TObject);
begin
   SetCQ(True);
   CtrlZCQLoop := True;
   CQRepeatProc();
end;

procedure TMainForm.CQRepeatProc();
var
   S: String;
   nID: Integer;
begin
   S := dmZlogGlobal.CWMessage(1, FCurrentCQMessageNo);
   S := SetStr(UpperCase(S), CurrentQSO);
   nID := GetCurrentRigID();

   if dmZLogKeyer.KeyingPort[nID] = tkpNone then begin
      WriteStatusLineRed('CW port is not set', False);
      Exit;
   end
   else begin
      WriteStatusLine('', False);
   end;

   dmZLogKeyer.SendStrLoop(nID, S);
end;


procedure TMainForm.buttonCwKeyboardClick(Sender: TObject);
begin
   FCWKeyBoard.Show;
end;

procedure TMainForm.SideToneButtonClick(Sender: TObject);
begin
   dmZlogGlobal.Settings.CW._sidetone := TSpeedButton(Sender).Down;
   dmZlogKeyer.UseSideTone := dmZlogGlobal.Settings.CW._sidetone;
end;

procedure TMainForm.buttonVoiceOptionClick(Sender: TObject);
var
   f: TformOptions;
begin
   f := TformOptions.Create(Self);
   try
      f.EditMode := 2;
      f.EditNumber := 1;

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      RenewVoiceToolBar;

      LastFocus.SetFocus;
   finally
      f.Release();
   end;
end;

procedure TMainForm.OpMenuClick(Sender: TObject);
begin
   SelectOperator(TMenuItem(Sender).Caption);
end;

procedure TMainForm.CWPauseButtonClick(Sender: TObject);
begin
   if dmZLogKeyer.IsPlaying = False then
      exit;

   dmZLogKeyer.PauseCW;
   CWPauseButton.Visible := False;
   CWPlayButton.Visible := True;
end;

procedure TMainForm.CWPlayButtonClick(Sender: TObject);
begin
   dmZLogKeyer.ResumeCW;
   CWPlayButton.Visible := False;
   CWPauseButton.Visible := True;
end;

procedure TMainForm.RcvdRSTEdit1Change(Sender: TObject);
var
   i: Integer;
begin
   if CurrentQSO.Mode in [mCW, mRTTY] then begin
      i := 599;
   end
   else begin
      i := 59;
   end;

   CurrentQSO.RSTRcvd := StrToIntDef(RcvdRSTEdit.Text, i);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FChatForm.RenewOptions();
   FCommForm.RenewOptions();
   FRateDialogEx.SaveSettings();

   Timer1.Enabled := False;
   TerminateNPlusOne();
   TerminateSuperCheckDataLoad();
   dmZLogKeyer.CloseBGK;

   if FInitialized = True then begin
      RecordWindowStates;
   end;

   if MMTTYRunning then begin
      ExitMMTTY;
   end;

   // Last Band/Mode
   dmZLogGlobal.LastBand := CurrentQSO.Band;
   dmZLogGlobal.LastMode := CurrentQSO.Mode;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
   R: Integer;
begin
   if Log = nil then begin
      Exit;
   end;

   if Log.Saved = False then begin
      R := MessageDlg('Save changes to ' + CurrentFileName + ' ?', mtConfirmation, [mbYes, mbNo, mbCancel], 0); { HELP context 0 }
      case R of
         mrYes: begin
            CanClose := True;
            FileSave(Sender);
         end;
         mrCancel: begin
            CanClose := False;
            exit;
         end;
      end;
   end;
end;

procedure TMainForm.Update10MinTimer;
var
   Diff: Integer;
   Min, Sec: Integer;
   S: string;
   S2: string;
   fQsyOK: Boolean;
   nCountDownMinute: Integer;
begin
   S := TimeToStr(CurrentTime);
   if length(S) = 7 then begin
      S := '0' + S;
   end;

   fQsyOK := False;

   S2 := '';
   if dmZlogGlobal.Settings._countdown then begin
      nCountDownMinute := dmZLogGlobal.Settings._countdownminute;

      if CountDownStartTime > 0 then begin
         Diff := SecondsBetween(CurrentTime , CountDownStartTime);
         if (Diff / 60) > nCountDownMinute then begin
            CountDownStartTime := 0;
            S2 := 'QSY OK';
            fQsyOK := True;
            FQsyViolation := False;
         end
         else begin
            Diff := (nCountDownMinute * 60) - Diff;
            Min := Diff div 60;
            Sec := Diff - (Min * 60);
            if Min = 0 then begin
               S2 := IntToStr(Sec);
            end
            else begin
               S2 := RightStr('00' + IntToStr(Min), 2);
               S2 := S2 + ':' + RightStr('00' + IntToStr(Sec), 2);
            end;
         end;
      end
      else // Countdownstarttime = 0;
      begin
         S2 := 'QSY OK';
         fQsyOK := True;
         FQsyViolation := False;
      end;
   end
   else begin
      S2 := '';
   end;

   if dmZlogGlobal.Settings._qsycount then begin
      S2 := 'QSY# ' + IntToStr(QSYCount);

      if QSYCount < dmZLogGlobal.Settings._countperhour then begin
         fQsyOK := True;
         FQsyViolation := False;
      end
      else begin
         fQsyOK := False;
         FQsyViolation := True;
      end;
   end;

   StatusLine.Panels[2].Text := S;
   FInformation.Time := S;

   FQsyInfoForm.SetQsyInfo(fQsyOK, S2);
end;

procedure TMainForm.CallsignSentProc(Sender: TObject);
var
   Q: TQSO;
   S: String;
   nID: Integer;

   procedure WinKeyerQSO();
   begin
      if dmZLogKeyer.UseWinKeyer = True then begin
         S := dmZlogGlobal.CWMessage(2);
         S := StringReplace(S, '$C', '', [rfReplaceAll]);
         S := SetStr(S, CurrentQSO);
         dmZLogKeyer.WinkeyerSendStr2(S);
      end;
   end;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- Begin CallsignSentProc() ---'));
   {$ENDIF}
   try
//      if CallsignEdit.Focused then begin
         Q := Log.QuickDupe(CurrentQSO);
         if TabPressed2 and (Q <> nil) then begin
            // ステータスバーにDUPE表示
            WriteStatusLineRed(Q.PartialSummary(dmZlogGlobal.Settings._displaydatepartialcheck), True);

            // ALLOW DUPEしない場合は4番を送出
            if dmZLogGlobal.Settings._allowdupe = False then begin
               // 先行して送出されている2番をクリア
               if dmZLogKeyer.UseWinKeyer = False then begin
                  dmZLogKeyer.ClrBuffer;
               end;

               if dmZlogGlobal.Settings._switchcqsp then begin
                  if dmZlogGlobal.Settings.CW.CurrentBank = 2 then begin
                     CallsignEdit.SelectAll;
                     exit;
                  end;
               end;

               // 4番(QSO B4 TU)送出
               S := ' ' + SetStr(dmZlogGlobal.CWMessage(1, 4), CurrentQSO);
               nID := GetCurrentRigID();
               if dmZLogKeyer.UseWinKeyer = True then begin
                  zLogSendStr(nID, S);
               end
               else begin
                  dmZLogKeyer.SendStr(nID, S);
                  dmZLogKeyer.SetCallSign(CurrentQSO.Callsign);
               end;

               CallsignEdit.SelectAll;

               exit; { BECAREFUL!!!!!!!!!!!!!!!!!!!!!!!! }
            end
            else begin  // ALLOW DUPE!
               WinKeyerQSO();
            end;
         end
         else begin  // NOT DUPE
            WinKeyerQSO();
         end;

         if TabPressed2 then begin
            MyContest.SpaceBarProc;
            NumberEdit.SetFocus;
            EditedSinceTABPressed := tabstate_tabpressedbutnotedited; // UzLogCW
         end;
//      end;

   finally
      dmZLogKeyer.ResumeCW;
      TabPressed := False;
      TabPressed2 := False;
   end;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
   S: String;
begin
   Timer1.Enabled := False;
   try
      Update10MinTimer;

      if not FPostContest then begin
         CurrentQSO.UpdateTime;
         S := CurrentQSO.TimeStr;
         if S <> TimeEdit.Text then begin
            TimeEdit.Text := S;
         end;
      end;
   finally
      Timer1.Enabled := True;
   end;
end;

procedure TMainForm.InsertQSO1Click(Sender: TObject);
var
   _top, _bottom, _oldtop: LongInt;
   aQSO: TQSO;
begin
   with Grid do begin
      _oldtop := TopRow;
      _top := Selection.top;
      _bottom := Selection.Bottom;
   end;

   if _top = _bottom then begin
      aQSO := TQSO(Grid.Objects[0, Grid.Row]);
      MyContest.PastEditForm.Init(aQSO, _ActInsert);
      MyContest.PastEditForm.ShowModal;
   end;

   Grid.TopRow := _oldtop;

   Log.SetDupeFlags;

   GridRefreshScreen();
end;

procedure TMainForm.VoiceFMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   VoiceFMenu.Items[0].Tag := THemisphereButton(Sender).Tag;
end;

procedure TMainForm.VoiceFButtonClick(Sender: TObject);
var
   n: Integer;
begin
   n := THemisphereButton(Sender).Tag;
   PlayMessage(1, n);
end;

procedure TMainForm.TimeEdit1Change(Sender: TObject);
var
   T: TDateTime;
   str: string;
begin
   str := TimeEdit.Text;
   if (length(str) = 4) and (Pos(':', str) = 0) then
      str := str[1] + str[2] + ':' + str[3] + str[4];
   try
      T := StrToTime(str);
   except
      on EConvertError do begin
         // T := CurrentQSO.Time;
         exit;
      end;
   end;
   CurrentQSO.Time := Int(CurrentQSO.Time) + Frac(T);
end;

procedure TMainForm.Export1Click(Sender: TObject);
var
   f, ext: string;
   dlg: TformExportHamlog;
begin
   TXTSaveDialog.InitialDir := ExtractFilePath(CurrentFileName);
   TXTSaveDialog.FileName := ChangeFileExt(ExtractFileName(CurrentFileName), '');

   if TXTSaveDialog.Execute then begin
      f := TXTSaveDialog.filename;
      ext := UpperCase(ExtractFileExt(f));
      if ext = '.ALL' then begin
         Log.SaveToFilezLogALL(f);
         { delete(f, length(f) - 3, 4);
           f := f + '.sum';
           MyContest.WriteSummary(f); }
      end;
      if ext = '.TXT' then begin
         Log.SaveToFilezLogDOSTXT(f);
      end;
      if ext = '.TX' then begin
         Log.SaveToFileByTX(f);
      end;
      if ext = '.ADI' then begin
         MyContest.ADIF_Export(f);
      end;
      if ext = '.CBR' then begin
         Log.SaveToFileByCabrillo(f);
      end;
      if ext = '.CSV' then begin
         dlg := TformExportHamlog.Create(Self);
         try
            if dlg.ShowModal() = mrCancel then begin
               Exit;
            end;
            Log.SaveToFileByHamlog(f, dlg.Remarks1Option, dlg.Remarks2Option, dlg.Remarks1, dlg.Remarks2);
         finally
            dlg.Release();
         end;
      end;

      { Add code to save current file under SaveDialog.FileName }
   end;
end;

procedure TMainForm.SpeedButton9Click(Sender: TObject);
begin
   FZLinkForm.Show;
end;

procedure TMainForm.SerialEdit1Change(Sender: TObject);
var
   i: Integer;
begin
   i := StrToIntDef(SerialEdit.Text, 0);

   if i > 0 then begin
      CurrentQSO.Serial := i;
   end;
end;

procedure TMainForm.GridBandChangeClick(Sender: TObject);
var
   i, _top, _bottom: Integer;
   R: word;
   B: TBand;
   aQSO: TQSO;
begin
   B := TBand(TMenuItem(Sender).Tag);
   // aQSO := TQSO.Create;
   with Grid do begin
      _top := Selection.top;
      _bottom := Selection.Bottom;
   end;

   if _top = _bottom then begin
      aQSO := TQSO(Grid.Objects[0, _top]);
      IncEditCounter(aQSO);
      aQSO.Band := B;
      FZLinkForm.EditQSObyID(aQSO); // added 0.24
   end
   else begin
      if { (ShowCurrentBandOnly.Checked = False) and } (_top < Log.TotalQSO) and (_bottom <= Log.TotalQSO) then begin
         R := MessageDlg('Are you sure to change the band for these QSO''s?', mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
         if R = mrNo then
            exit;
         for i := _top to _bottom do begin
            aQSO := TQSO(Grid.Objects[0, i]);
            aQSO.Band := B;
            IncEditCounter(aQSO);
            FZLinkForm.EditQSObyID(aQSO); // 0.24
         end;
      end;
   end;
   // aQSO.Free;
   i := Grid.TopRow;
   MyContest.Renew;
   Grid.TopRow := i;
   GridRefreshScreen();
   Log.Saved := False;
end;

procedure TMainForm.Load1Click(Sender: TObject);
begin
   FZLinkForm.LoadLogFromZLink;
   {
     if ZLinkForm.Transparent then
     ZLinkForm.LoadLogFromZLink   // clears current log
     else
     ZLinkForm.LoadLogFromZServer;  // does not clear }
end;

procedure TMainForm.SortbyTime1Click(Sender: TObject);
begin
   Log.SortByTime;
   GridRefreshScreen();
end;

procedure TMainForm.menuAboutClick(Sender: TObject);
var
   f: TAboutBox;
begin
   f := TAboutBox.Create(Self);
   try
      f.ShowModal();
   finally
      f.Release();
   end;
end;

procedure TMainForm.DateEdit1Change(Sender: TObject);
var
   T: TDateTime;
begin
   try
      T := StrToDate(DateEdit.Text);
   except
      on EConvertError do begin
         // T := CurrentQSO.Time;
         exit;
      end;
   end;
   CurrentQSO.Time := Int(T) + Frac(CurrentQSO.Time);
end;

procedure TMainForm.TimeEdit1DblClick(Sender: TObject);
begin
   if TEdit(Sender).Name = 'TimeEdit' then begin
      TimeEdit.Visible := False;
      DateEdit.Visible := True;
      // TimeLabel.Caption := 'date';
   end
   else begin
      TimeEdit.Visible := True;
      DateEdit.Visible := False;
      // TimeLabel.Caption := 'time';
   end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
   SetListWidth();
end;

procedure TMainForm.menuOptionsClick(Sender: TObject);
var
   f: TformOptions;
   b: TBand;
begin
   f := TformOptions.Create(Self);
   try
      // KeyingとRigControlを一旦終了
      dmZLogKeyer.ResetCommPortDriver(0, TKeyingPort(dmZlogGlobal.Settings._keyingport[1]));
      dmZLogKeyer.ResetCommPortDriver(1, TKeyingPort(dmZlogGlobal.Settings._keyingport[2]));
      RigControl.Stop();

      f.EditMode := 0;

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      dmZlogGlobal.ImplementSettings(False);
      dmZlogGlobal.SaveCurrentSettings();
      InitBandMenu();

      RenewCWToolBar;
      RenewVoiceToolBar;

      InitQsoEditPanel();
      UpdateQsoEditPanel(1);
      LastFocus := CallsignEdit;
      ShowCurrentQSO();

      MyContest.ScoreForm.UpdateData();
      MyContest.MultiForm.UpdateData();

      FCheckCall2.ResetListBox();
      FCheckMulti.ResetListBox();
      FCheckCountry.ResetListBox();
      FRateDialogEx.InitScoreGrid();
      FFunctionKeyPanel.UpdateInfo();

      SetWindowCaption();

      // SuperCheck再ロード
      if f.NeedSuperCheckLoad = True then begin
         SuperCheckDataLoad();
      end;

      // BandScope再設定
      for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
         FBandScopeEx[b].FreshnessType := dmZLogGlobal.Settings._bandscope_freshness_mode;
         FBandScopeEx[b].IconType := dmZLogGlobal.Settings._bandscope_freshness_icon;
      end;
      FBandScope.FreshnessType := dmZLogGlobal.Settings._bandscope_freshness_mode;
      FBandScope.IconType := dmZLogGlobal.Settings._bandscope_freshness_icon;
      actionShowBandScope.Execute();

      // OpList再ロード
      BuildOpListMenu(OpMenu, OpMenuClick);

      // Voice初期化
      FVoiceForm.Init();
   finally
      f.Release();

      // リグコントロール/Keying再開
      RigControl.ImplementOptions;

      // Accessibility
      if LastFocus.Visible then begin
         EditExit(LastFocus);
         EditEnter(LastFocus);
         LastFocus.SetFocus;
      end;
   end;
end;

procedure TMainForm.Edit1Click(Sender: TObject);
var
   f: TformOptions;
begin
   f := TformOptions.Create(Self);
   try
      f.EditMode := 1;
      f.EditNumber := TMenuItem(Sender).Tag;
      case CurrentQSO.Mode of
         mCW, mOther: begin
            if TMenuItem(Sender).Tag >= 101 then begin
               f.EditBank := 1;
            end
            else begin
               f.EditBank := dmZLogGlobal.Settings.CW.CurrentBank;
            end;
         end;
         mRTTY: f.EditBank := 3;
      end;

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      RenewCWToolBar;
      FFunctionKeyPanel.UpdateInfo();

      LastFocus.SetFocus;
   finally
      f.Release();
   end;
end;

procedure TMainForm.menuVoiceEditClick(Sender: TObject);
var
   f: TformOptions;
begin
   f := TformOptions.Create(Self);
   try
      f.EditMode := 2;
      f.EditNumber := TMenuItem(Sender).Tag;

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      RenewVoiceToolBar;
      FFunctionKeyPanel.UpdateInfo();

      LastFocus.SetFocus;
   finally
      f.Release();
   end;
end;

procedure TMainForm.menuBandPlanSettingsClick(Sender: TObject);
var
   f: TBandPlanEditDialog;
   m: TMode;
begin
   f := TBandPlanEditDialog.Create(Self);
   try
      for m := mCW to mOther do begin
         f.Limit[m] := dmZLogGlobal.BandPlan.Limit[m];
      end;

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      for m := mCW to mOther do begin
         dmZLogGlobal.BandPlan.Limit[m] := f.Limit[m];
      end;
      dmZLogGlobal.BandPlan.SaveToFile();
   finally
      f.Release();
   end;
end;

procedure TMainForm.menuQSORateSettingsClick(Sender: TObject);
var
   f: TGraphColorDialog;
   b: TBand;
begin
   f := TGraphColorDialog.Create(Self);
   try
      f.Style := FRateDialog.GraphStyle;
      f.StartPosition := FRateDialog.GraphStartPosition;
      for b := b19 to HiBand do begin
         f.BarColor[b] := FRateDialog.GraphSeries[b].SeriesColor;
         f.TextColor[b] := FRateDialog.GraphSeries[b].Marks.Font.Color;
      end;

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      FRateDialog.GraphStyle := f.Style;
      FRateDialog.GraphStartPosition := f.StartPosition;
      for b := b19 to HiBand do begin
         FRateDialog.GraphSeries[b].SeriesColor := f.BarColor[b];
         FRateDialog.GraphSeries[b].Marks.Font.Color := f.TextColor[b];
      end;
      FRateDialog.SaveSettings();

      FRateDialogEx.GraphStyle := f.Style;
      FRateDialogEx.GraphStartPosition := f.StartPosition;
      for b := b19 to HiBand do begin
         FRateDialogEx.GraphSeries[b].SeriesColor := f.BarColor[b];
         FRateDialogEx.GraphSeries[b].Marks.Font.Color := f.TextColor[b];
      end;
   finally
      f.Release();
   end;
end;

procedure TMainForm.menuTargetEditorClick(Sender: TObject);
var
   dlg: TTargetEditor;
begin
   dlg := TTargetEditor.Create(Self);
   try
      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

      FRateDialogEx.UpdateGraph();
   finally
      dlg.Release();
   end;
end;

procedure TMainForm.menuPluginManagerClick(Sender: TObject);
begin
   MarketForm.Show;
end;

procedure TMainForm.CWFMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   CWFMenu.Items[0].Tag := THemisphereButton(Sender).Tag;
end;

procedure TMainForm.EditEnter(Sender: TObject);
var
   P: Integer;
   edit: TEdit;
   rig: Integer;
begin
   LastFocus := TEdit(Sender);
   edit := TEdit(Sender);
   rig := edit.Tag;

   // SO2Rの場合、現在RIGとクリックされたControlのRIGが違うと強制切り替え
   if dmZLogGlobal.Settings._so2r_type <> so2rNone then begin
      if FCurrentRig <> rig then begin
         if RigControl.SetCurrentRig(rig) = True then begin
            SwitchRig(rig);
         end;
      end;
   end;

   SetEditColor(TEdit(Sender), False);

   if (edit = CallsignEdit1) or
      (edit = CallsignEdit2A) or (edit = CallsignEdit2B) or (edit = CallsignEdit2C) then begin
      P := Pos('.', edit.Text);
      if P > 0 then begin
         edit.SelStart := P - 1;
         edit.SelLength := 1;
      end;
   end;

   actionQsoStart.Enabled:= True;
   actionQsoComplete.Enabled:= True;
end;

procedure TMainForm.EditExit(Sender: TObject);
begin
   with TEdit(Sender) do begin
      Font.Color := clBlack;
      Color := clWhite;
      Font.Style := Font.Style - [fsBold];
   end;

   actionQsoStart.Enabled:= False;
   actionQsoComplete.Enabled:= False;
end;

procedure TMainForm.mnMergeClick(Sender: TObject);
begin
   FZLinkForm.MergeLogWithZServer;
end;

procedure TMainForm.ConnecttoZServer1Click(Sender: TObject);
begin
   FZLinkForm.ZSocket.Addr := dmZlogGlobal.Settings._zlink_telnet.FHostName;
   FZLinkForm.ZSocket.Port := 'telnet';
   if FZLinkForm.ZServerConnected then begin
      FZLinkForm.DisconnectedByMenu := True;
      FZLinkForm.ZSocket.close;
   end
   else begin
      FZLinkForm.ZSocket.Connect;
   end;
end;

procedure TMainForm.DisableNetworkMenus;
begin
   mnDownload.Enabled := False;
   mnMerge.Enabled := False;
end;

procedure TMainForm.EnableNetworkMenus;
begin
   mnDownload.Enabled := True;
   mnMerge.Enabled := True;
end;

procedure TMainForm.GridModeChangeClick(Sender: TObject);
var
   i, _top, _bottom: Integer;
   R: word;
   M: TMode;
   aQSO: TQSO;
begin
   M := TMode(TMenuItem(Sender).Tag);
   // aQSO := TQSO.Create;
   with Grid do begin
      _top := Selection.top;
      _bottom := Selection.Bottom;
   end;
   if _top = _bottom then begin
      aQSO := TQSO(Grid.Objects[0, _top]);

      if M in [mSSB, mAM, mFM] then begin
         if not(aQSO.mode in [mSSB, mAM, mFM]) then begin
            aQSO.RSTsent := aQSO.RSTsent div 10;
            aQSO.RSTRcvd := aQSO.RSTRcvd div 10;
         end;
      end
      else begin
         if aQSO.mode in [mSSB, mAM, mFM] then begin
            aQSO.RSTsent := aQSO.RSTsent * 10 + 9;
            aQSO.RSTRcvd := aQSO.RSTRcvd * 10 + 9;
         end;
      end;

      aQSO.mode := M;
      IncEditCounter(aQSO);
      FZLinkForm.EditQSObyID(aQSO); // added 0.24
   end
   else begin
      if { (ShowCurrentBandOnly.Checked = False) and } (_top < Log.TotalQSO) and (_bottom <= Log.TotalQSO) then begin
         R := MessageDlg('Are you sure to change the mode for these QSO''s?', mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
         if R = mrNo then
            exit;

         for i := _top to _bottom do begin
            aQSO := TQSO(Grid.Objects[0, i]);

            if M in [mSSB, mAM, mFM] then begin
               if not(aQSO.mode in [mSSB, mAM, mFM]) then begin
                  aQSO.RSTsent := aQSO.RSTsent div 10;
                  aQSO.RSTRcvd := aQSO.RSTRcvd div 10;
               end;
            end
            else begin
               if aQSO.mode in [mSSB, mAM, mFM] then begin
                  aQSO.RSTsent := aQSO.RSTsent * 10 + 9;
                  aQSO.RSTRcvd := aQSO.RSTRcvd * 10 + 9;
               end;
            end;

            aQSO.mode := M;
            IncEditCounter(aQSO);
            FZLinkForm.EditQSObyID(aQSO); // 0.24
         end;
      end;
   end;
   // aQSO.Free;
   i := Grid.TopRow;
   MyContest.Renew;
   Grid.TopRow := i;
   GridRefreshScreen();
   Log.Saved := False;
end;

procedure TMainForm.GridOperatorClick(Sender: TObject);
var
   i, _top, _bottom: Integer;
   R: word;
   OpName: string;
   aQSO: TQSO;
begin
   OpName := TMenuItem(Sender).Caption;
   if OpName = 'Clear' then
      OpName := '';
   // aQSO := TQSO.Create;
   with Grid do begin
      _top := Selection.top;
      _bottom := Selection.Bottom;
   end;

   if _top = _bottom then begin
      aQSO := TQSO(Grid.Objects[0, _top]);
      aQSO.Operator := OpName;
      IncEditCounter(aQSO);
      FZLinkForm.EditQSObyID(aQSO); // added 0.24
   end
   else begin
      if (_top < Log.TotalQSO) and (_bottom <= Log.TotalQSO) then begin
         R := MessageDlg('Are you sure to change the operator names for these QSO''s?', mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
         if R = mrNo then
            exit;

         for i := _top to _bottom do begin
            aQSO := TQSO(Grid.Objects[0, i]);
            aQSO.Operator := OpName;
            IncEditCounter(aQSO);
            FZLinkForm.EditQSObyID(aQSO); // 0.24
         end;
      end;
   end;
   // aQSO.Free;
   i := Grid.TopRow;
   MyContest.Renew;
   Grid.TopRow := i;
   GridRefreshScreen();
   Log.Saved := False;
end;

procedure TMainForm.SendSpot1Click(Sender: TObject);
var
   _top, _bottom: Integer;
   aQSO: TQSO;
begin
   with Grid do begin
      _top := Selection.top;
      _bottom := Selection.Bottom;
   end;

   if _top = _bottom then begin
      aQSO := TQSO(Grid.Objects[0, Grid.Row]);
      FSpotForm.Open(aQSO);
   end;
end;

procedure TMainForm.NumberEdit1KeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
   if FPartialCheck.Visible and not(FPartialCheck._CheckCall) then
      FPartialCheck.CheckPartialNumber(CurrentQSO);

   if FCheckMulti.Visible then
      FCheckMulti.Renew(CurrentQSO);
end;

procedure TMainForm.NewPowerMenuClick(Sender: TObject);
begin
   PowerEdit.Text := NewPowerString[TPower(TMenuItem(Sender).Tag)];
   CurrentQSO.Power := TPower(TMenuItem(Sender).Tag);
   LastFocus.SetFocus;
end;

procedure TMainForm.PowerEdit1Click(Sender: TObject);
begin
   NewPowerMenu.Popup(Left + PowerEdit.Left + 20, Top + EditPanel1R.top + PowerEdit.top);
end;

procedure TMainForm.OpEdit1Click(Sender: TObject);
begin
   OpMenu.Popup(Left + OpEdit.Left + 20, Top + EditPanel1R.top + OpEdit.top);
end;

procedure TMainForm.GridClick(Sender: TObject);
var
   aQSO: TQSO;
begin
   if FCheckCall2.Visible = False then begin
      exit;
   end;

   aQSO := TQSO(Grid.Objects[0, Grid.Row]);
   if aQSO = nil then begin
      Exit;
   end;

   FCheckCall2.Renew(aQSO);
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
   ActionList1.State := asNormal;
   if LastFocus.Visible then begin
      LastFocus.SetFocus;
   end;
end;

procedure TMainForm.CreateDupeCheckSheetZPRINT1Click(Sender: TObject);
var
   R: Integer;
   S: string;
begin
   if Log.Saved = False then begin
      R := MessageDlg('Save changes to ' + CurrentFileName + ' ?', mtConfirmation, [mbYes, mbNo, mbCancel], 0); { HELP context 0 }
      case R of
         mrYes:
            FileSave(Sender);
         mrCancel:
            exit;
      end;
   end;

   R := ExecuteFile('zlistw', '/ro ' + ExtractFileName(CurrentFileName), ExtractFilePath(ParamStr(0)), SW_SHOW);
   if R > 32 then
      exit; { successful }
   S := 'Unknown error';
   case R of
      0:
         S := 'Out of memory or resources';
      ERROR_FILE_NOT_FOUND:
         S := 'ZLISTW.EXE not found';
   end;
   WriteStatusLine(S, True);
end;

procedure TMainForm.MemoHotKeyEnter(Sender: TObject);
begin
   MemoEdit.SetFocus;
end;

procedure TMainForm.GridTopLeftChanged(Sender: TObject);
begin
//   EditScreen.RefreshScreen;

   if Grid.LeftCol <> 0 then
      Grid.LeftCol := 0;
end;

procedure TMainForm.TXTSaveDialogTypeChange(Sender: TObject);
var
   i: Integer;
begin
   i := TXTSaveDialog.FilterIndex;
   if i = 2 then
      TXTSaveDialog.DefaultExt := 'txt'
   else
      TXTSaveDialog.DefaultExt := 'all';
end;

procedure TMainForm.GridMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if EditScreen <> nil then begin
      SetEditFields1R(EditScreen);
   end;
end;

procedure TMainForm.StatusLineResize(Sender: TObject);
begin
   StatusLine.Panels[2].Width := 100;
   if RigControl.Rig <> nil then
      StatusLine.Panels[1].Width := 47
   else
      StatusLine.Panels[1].Width := 0;
   StatusLine.Panels[0].Width := StatusLine.Width - 100 - StatusLine.Panels[1].Width;
end;

procedure TMainForm.PrintLogSummaryzLog1Click(Sender: TObject);
begin
   // PrinterDialog.Execute;
end;

procedure TMainForm.VoiceCQ3Click(Sender: TObject);
begin
   SetCQ(True);
   FVoiceForm.CtrlZCQLoopVoice := True;
   FVoiceForm.CQLoopVoice(FCurrentCQMessageNo);
end;

procedure TMainForm.VoiceCQ2Click(Sender: TObject);
begin
   SetCQ(True);
   FVoiceForm.CtrlZCQLoopVoice := False;
   FVoiceForm.CQLoopVoice(FCurrentCQMessageNo);
end;

procedure TMainForm.mPXListWPXClick(Sender: TObject);
var
   str: string;
begin
   GeneralSaveDialog.DefaultExt := 'px';
   GeneralSaveDialog.Filter := 'Prefix list files (*.px)|*.px';
   GeneralSaveDialog.Title := 'Save prefix list';

   if CurrentFileName <> '' then begin
      str := CurrentFileName;
      str := copy(str, 0, length(str) - length(ExtractFileExt(str)));
      str := str + '.px';
      GeneralSaveDialog.filename := str;
   end;

   if GeneralSaveDialog.Execute then begin
      TWPXMulti(MyContest.MultiForm).SavePXList(GeneralSaveDialog.filename);
   end;
end;

procedure TMainForm.mSummaryFileClick(Sender: TObject);
begin
   GeneralSaveDialog.DefaultExt := 'zsm';
   GeneralSaveDialog.Filter := 'Summary files (*.zsm)|*.zsm';
   GeneralSaveDialog.Title := 'Save summary file';

   if CurrentFileName <> '' then begin
      GeneralSaveDialog.InitialDir := ExtractFilePath(CurrentFileName);
      GeneralSaveDialog.FileName := ChangeFileExt(ExtractFileName(CurrentFileName), '.zsm');
   end;

   if GeneralSaveDialog.Execute then
      MyContest.ScoreForm.SaveSummary(GeneralSaveDialog.filename);
end;

procedure TMainForm.GridPowerChangeClick(Sender: TObject);
var
   i, _top, _bottom: Integer;
   R: word;
   P: TPower;
   aQSO: TQSO;
begin
   P := TPower(TMenuItem(Sender).Tag);
   // aQSO := TQSO.Create;
   with Grid do begin
      _top := Selection.top;
      _bottom := Selection.Bottom;
   end;

   if _top = _bottom then begin
      aQSO := TQSO(Grid.Objects[0, _top]);
      aQSO.Power := P;
      IncEditCounter(aQSO);
      FZLinkForm.EditQSObyID(aQSO); // added 0.24
   end
   else begin
      if (_top < Log.TotalQSO) and (_bottom <= Log.TotalQSO) then begin
         R := MessageDlg('Are you sure to change the power for these QSO''s?', mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
         if R = mrNo then
            exit;

         for i := _top to _bottom do begin
            aQSO := TQSO(Grid.Objects[0, i]);
            aQSO.Power := P;
            IncEditCounter(aQSO);
            FZLinkForm.EditQSObyID(aQSO);
         end;
      end;
   end;

   i := Grid.TopRow;
   MyContest.Renew;
   Grid.TopRow := i;
   GridRefreshScreen();
   Log.Saved := False;
end;

procedure TMainForm.MergeFile1Click(Sender: TObject);
var
   ff: string;
   i: Integer;
begin
   OpenDialog.Title := 'Merge file';
   OpenDialog.InitialDir := dmZlogGlobal.Settings._logspath;
   OpenDialog.FileName := '';

   if OpenDialog.Execute then begin
      WriteStatusLine('Merging...', False);
      ff := OpenDialog.filename;
      if ff = CurrentFileName then begin
         WriteStatusLine('Cannot merge current file', True);
         exit;
      end;

      i := Log.QsoList.MergeFile(ff, True);
      if i > 0 then begin
         Log.SortByTime;
         MyContest.Renew;
         // EditScreen.Renew;
         GridRefreshScreen();
         FileSave(Self);
      end;
      WriteStatusLine(IntToStr(i) + ' QSO(s) merged.', True);
   end;
end;

procedure TMainForm.SaveFileAndBackUp;
begin
   Log.SaveToFile(CurrentFileName); // this is where the file is saved!!!
   actionBackup.Execute();
end;

procedure TMainForm.StatusLineDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
begin
   if Panel = StatusLine.Panels[0] then begin
      StatusBar.Canvas.Font.Color := clStatusLine;
      StatusBar.Canvas.TextOut(Rect.Left + 1, Rect.top + 1, Panel.Text);
   end;
end;

procedure TMainForm.mnChangeTXNrClick(Sender: TObject);
var
   i, _top, _bottom, NewTX, R: Integer;
   aQSO: TQSO;
   M: TMenuItem;
begin
   M := TMenuItem(Sender);
   NewTx := StrToIntDef(M.Caption, 0);
   if (NewTX > 255) or (NewTX < 0) then begin
      Exit;
   end;

   _top := Grid.Selection.top;
   _bottom := Grid.Selection.Bottom;

   if _top = _bottom then begin
      aQSO := TQSO(Grid.Objects[0, _top]);

      IncEditCounter(aQSO);
      aQSO.TX := NewTX;
      FZLinkForm.EditQSObyID(aQSO); // added 0.24
   end
   else begin
      if (_top < Log.TotalQSO) and (_bottom <= Log.TotalQSO) then begin
         R := MessageDlg('Are you sure to change the TX# for these QSO''s?', mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
         if R = mrNo then begin
            exit;
         end;

         for i := _top to _bottom do begin
            aQSO := TQSO(Grid.Objects[0, i]);
            aQSO.TX := NewTX;
            IncEditCounter(aQSO);
            FZLinkForm.EditQSObyID(aQSO); // 0.24
         end;
      end;
   end;

   i := Grid.TopRow;
   MyContest.Renew;
   Grid.TopRow := i;
   GridRefreshScreen();
   Log.Saved := False;
end;

procedure TMainForm.GridKeyPress(Sender: TObject; var Key: Char);
begin
   case Key of
      'a' .. 'z':
         Key := Chr(Ord('A') + Ord(Key) - Ord('a'));
      ^P, '-': begin
            if Grid.Row > 1 then
               Grid.Row := Grid.Row - 1;
         end;
      ^N, '+': begin
            if Grid.Row < Grid.RowCount - 1 then
               Grid.Row := Grid.Row + 1;
         end;
   end;
end;

procedure TMainForm.mnGridAddNewPXClick(Sender: TObject);
var
   aQSO: TQSO;
begin
   if Grid.Row > 0 then begin
      aQSO := TQSO(Grid.Objects[0, Grid.Row]);
      MyContest.MultiForm.SelectAndAddNewPrefix(aQSO.Callsign);
   end;
end;

procedure TMainForm.GridSelectCell(Sender: TObject; col, Row: Integer; var CanSelect: Boolean);
begin
   //
end;

procedure TMainForm.GridSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: String);
begin
   WriteStatusLine('SetEditTextCalled', False);
end;

procedure TMainForm.GridGetEditText(Sender: TObject; ACol, ARow: Integer; var Value: String);
begin
   WriteStatusLine('GetEditTextCalled', False);
end;

procedure TMainForm.mnHideCWPhToolBarClick(Sender: TObject);
begin
   if mnHideCWPhToolBar.Checked = False then begin
      Grid.Align := alNone;
      CWToolBar.Height := 1;
      SSBToolBar.Height := 1;
      mnHideCWPhToolBar.Checked := True;
      Grid.Align := alClient;
   end
   else begin
      Grid.Align := alNone;
      CWToolBar.Height := 33;
      SSBToolBar.Height := 33;
      mnHideCWPhToolBar.Checked := False;
      Grid.Align := alClient;
   end;
   FormResize(Self);
end;

procedure TMainForm.mnHideMenuToolbarClick(Sender: TObject);
begin
   if mnHideMenuToolbar.Checked = False then begin
      Grid.Align := alNone;
      MainToolBar.Height := 1;
      mnHideMenuToolbar.Checked := True;
      Grid.Align := alClient;
   end
   else begin
      Grid.Align := alNone;
      MainToolBar.Height := 33;
      mnHideMenuToolbar.Checked := False;
      Grid.Align := alClient;
   end;
   FormResize(Self);
end;

procedure TMainForm.SwitchLastQSOBandMode;
var
   T, mytx, i: Integer;
   boo: Boolean;
begin
   if Log.TotalQSO > 0 then begin
      T := Log.TotalQSO;
      mytx := dmZlogGlobal.TXNr;
      boo := False;
      for i := T downto 1 do begin
         if Log.QsoList[i].TX = mytx then begin
            boo := True;
            break;
         end;
      end;

      if boo = True then begin

         UpdateBand(Log.QsoList[i].Band);
         if RigControl.Rig <> nil then begin
            RigControl.Rig.SetBand(CurrentQSO);
            if CurrentQSO.Mode = mSSB then
               RigControl.Rig.SetMode(CurrentQSO);
         end;

         UpdateMode(Log.QsoList[i].mode);

         if RigControl.Rig <> nil then
            RigControl.Rig.SetMode(CurrentQSO);

         LastFocus.SetFocus;
      end;
   end;
end;

procedure TMainForm.mnMMTTYClick(Sender: TObject);
begin
   if mnMMTTY.Tag = 0 then begin
      mnMMTTY.Tag := 1;
      mnMMTTY.Caption := 'Exit MMTTY';
      mnTTYConsole.Visible := True;

      FTTYConsole := TTTYConsole.Create(Self);
      dmZlogGlobal.ReadWindowState(FTTYConsole);

      dmZLogKeyer.CloseBGK();

      FTTYConsole.SetTTYMode(ttyMMTTY);
      InitializeMMTTY(Handle);

      FTTYConsole.Show;
      FTTYConsole.SetFocus;
   end
   else begin
      mnMMTTY.Tag := 0;
      mnMMTTY.Caption := 'Load MMTTY';
      mnTTYConsole.Visible := False;

      dmZlogGlobal.WriteWindowState(FTTYConsole);

      FTTYConsole.Close();
      FTTYConsole.Release();

      ExitMMTTY;

      dmZLogKeyer.InitializeBGK(dmZlogGlobal.Settings.CW._interval);
      dmZLogGlobal.InitializeCW();
   end;
end;

procedure TMainForm.AutoInput(D: TBSData);
begin
   OldCallsign := CallsignEdit.Text;
   OldNumber := NumberEdit.Text;
   CallsignEdit.Text := D.Call;
   NumberEdit.Text := D.Number;
   CallsignEdit.Font.Color := clGrayText;
   NumberEdit.Font.Color := clGrayText;
end;

procedure TMainForm.menuQuickReferenceClick(Sender: TObject);
begin
   FQuickRef.Show();
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
begin
//   AutoInput(TBSData(BSList2[0]));
end;

procedure TMainForm.CreateELogJARL1Click(Sender: TObject);
var
   f: TformELogJarl1;
begin
   f := TformELogJarl1.Create(Self);
   try
      f.ShowModal();
   finally
      f.Release();
   end;
end;

procedure TMainForm.CreateELogJARL2Click(Sender: TObject);
var
   f: TformELogJarl2;
begin
   f := TformELogJarl2.Create(Self);
   try
      f.ShowModal();
   finally
      f.Release();
   end;
end;

procedure TMainForm.MyIdleEvent(Sender: TObject; var Done: Boolean);
var
   fPlaying: Boolean;
begin
   if (CurrentQSO.Mode = mCW) then begin
      if (dmZLogGlobal.Settings._use_winkeyer = True) then begin
         CWPauseButton.Visible := False;
      end
      else begin
         CWPauseButton.Visible := True;
      end;
   end;

   fPlaying := dmZlogKeyer.IsPlaying;

   if fPlaying then begin
      if CurrentQSO.Mode = mCW then begin
         CWPauseButton.Enabled := True;
         CWPlayButton.Visible := False;
         CWStopButton.Enabled := True;
      end
      else begin
      end;
   end
   else begin
      // if Paused = False then
      if CurrentQSO.Mode = mCW then begin
         TabPressed := False;
      end;

      if SaveInBackGround = True then begin
         SaveFileAndBackUp;
         SaveInBackGround := False;
      end;

      CWPauseButton.Enabled := False;
      CWStopButton.Enabled := False;
   end;

   if CurrentQSO.Mode = mRTTY then begin
      if FTTYConsole <> nil then begin
         if FTTYConsole.Sending = False then begin
            TabPressed := False;
         end;
      end;
   end;

   Done := True;
end;

procedure TMainForm.MyMessageEvent(var Msg: TMsg; var Handled: Boolean);
begin
   zyloWindowMessage(msg);
   if MMTTYInitialized then begin
      UMMTTY.ProcessMMTTYMessage(Msg, Handled);
   end;
end;

procedure TMainForm.OnZLogInit( var Message: TMessage );
var
   menu: TMenuForm;
   c, r: Integer;
   i, j: Integer;
begin
   FInitialized := False;

   SuperCheckDataLoad();

   menu := TMenuForm.Create(Self);
   try
      if menu.ShowModal() = mrCancel then begin
         Close();
         Exit;
      end;

      dmZlogGlobal.SetLogFileName('');

      CurrentQSO.Serial := 1;
      mPXListWPX.Visible := False;

      dmZlogGlobal.ContestCategory := menu.ContestCategory;

      dmZlogGlobal.Band := menu.BandGroupIndex;

      dmZlogGlobal.ContestMode := menu.ContestMode;

      dmZlogGlobal.MyCall := menu.Callsign;

      dmZlogGlobal.ContestMenuNo := menu.ContestNumber;

      if menu.ContestCategory in [ccMultiOpMultiTx, ccMultiOpSingleTx, ccMultiOpTwoTx] then begin
         dmZlogGlobal.TXNr := menu.TxNumber;    // TX#
         if dmZlogGlobal.Settings._pcname = '' then begin
            dmZlogGlobal.Settings._pcname := 'PC' + IntToStr(menu.TxNumber);
         end;
      end;

      FPostContest := menu.PostContest;

      { Open New Contest from main menu }
      if MyContest <> nil then begin
         MyContest.Free;
      end;

      dmZLogGlobal.CreateLog();

      for r := 0 to Grid.RowCount - 1 do begin
         for c := 0 to Grid.ColCount - 1 do begin
            Grid.Cells[c, r] := '';
         end;
      end;

      if EditScreen <> nil then begin
         EditScreen.Free;
      end;

      RenewBandMenu();

      with Grid do begin
         ColCount := 10;
         FixedCols := 0;
         FixedRows := 1;
         ColCount := 10;
         Height := 291;
         DefaultRowHeight := 17;
      end;
//      SerialEdit.Visible := False;
//      PowerEdit.Visible := False;
//      ModeEdit.Visible := True;

      for i := 1 to Grid.RowCount - 1 do
         for j := 0 to Grid.ColCount - 1 do
            Grid.Cells[j, i] := '';

      case dmZlogGlobal.ContestMenuNo of
         // ALL JA
         0: begin
            InitALLJA();
         end;

         // 6m & DOWN
         1: begin
            Init6D();
         end;

         // FIELD DAY
         2: begin
            InitFD();
         end;

         // ACAG
         3: begin
            InitACAG();
         end;

         // ALL JA0(JA0)
         4: begin
            InitALLJA0_JA0(menu.BandGroupIndex);
         end;

         // ALL JA0(other)
         5: begin
            InitALLJA0_Other(menu.BandGroupIndex);
         end;

         // KCJ
         6: begin
            InitKCJ();
         end;

         // DX pedi
         8: begin
            InitDxPedi();
         end;

         // User Defined
         9: begin
            InitUserDefined(menu.GeneralName, menu.CFGFileName);
         end;

         // CQWW
         10: begin
            InitCQWW();
         end;

         // WPX
         11: begin
            InitWPX(menu.ContestCategory);
         end;

         // JIDX
         // now determines JA/DX from callsign
         7, 12: begin
            InitJIDX();
         end;

         // AP Sprint
         13: begin
            InitAPSprint();
         end;

         // ARRL DX(W/VE)
         14: begin
            InitARRL_W();
         end;

         // ARRL(DX)
         15: begin
            InitARRL_DX();
         end;

         // ARRL 10m
         16: begin
            InitARRL10m();
         end;

         // IARU HF
         17: begin
            InitIARU();
         end;

         // All Asian DX(Asia)
         18: begin
            InitAllAsianDX();
         end;

         // IOTA
         19: begin
            InitIOTA();
         end;

         // WAEDC(DX)
         20: begin
            InitWAE();
         end;
      end;

      SetGridWidth(EditScreen);
      SetEditFields1R(EditScreen);

      // #201 モード選択によって動作を変える(NEW CONTESTのみ)
      case menu.ContestMode of
         // PH/CW
         cmMix: begin
            CurrentQSO.Mode := dmZLogGlobal.LastMode;
         end;

         // CW
         cmCw: begin
            CurrentQSO.Mode := mCW;
         end;

         // PH
         cmPh: begin
            CurrentQSO.Mode := mSSB;
         end;

         // Other
         else begin
            CurrentQSO.Mode := dmZLogGlobal.LastMode;
         end;
      end;

      if (CurrentQSO.Mode = mCW) or (CurrentQSO.Mode = mRTTY) then begin
         CurrentQSO.RSTRcvd := 599;
         CurrentQSO.RSTSent := 599;
      end
      else begin
         CurrentQSO.RSTRcvd := 59;
         CurrentQSO.RSTSent := 59;
      end;

      // ファイル名の指定が無い場合は選択ダイアログを出す
      if CurrentFileName = '' then begin
         OpenDialog.InitialDir := dmZlogGlobal.Settings._logspath;
         OpenDialog.FileName := '';

         if OpenDialog.Execute then begin
            dmZLogGlobal.SetLogFileName(OpenDialog.FileName);

            if FileExists(OpenDialog.FileName) then begin
               LoadNewContestFromFile(OpenDialog.FileName);
            end;

            SetWindowCaption();
         end
         else begin // user hit cancel
            MessageDlg('Data will NOT be saved until you enter the file name', mtWarning, [mbOK], 0); { HELP context 0 }
         end;
      end;

      // 局種係数
      Log.ScoreCoeff := menu.ScoreCoeff;

      // Sentは各コンテストで設定された値
      dmZlogGlobal.Settings._sentstr := MyContest.SentStr;

      MyContest.Renew;
      GridRefreshScreen();
      ReEvaluateCountDownTimer;
      ReEvaluateQSYCount;

      // Issues #148 [CW]ボタンは常に表示にする
//      if menu.ModeGroupIndex = 0 then begin
         MyContest.ScoreForm.CWButton.Visible := True;
//      end
//      else begin
//         MyContest.ScoreForm.CWButton.Visible := False;
//      end;

      MyContest.ScoreForm.FontSize := Grid.Font.Size;

      // 設定反映
      dmZlogGlobal.ImplementSettings(False);
      InitBandMenu();
      SideToneButton.Down := dmZlogGlobal.Settings.CW._sidetone;

      RestoreWindowStates;
      dmZlogGlobal.ReadWindowState(MyContest.MultiForm, 'MultiForm', False);
      dmZlogGlobal.ReadWindowState(MyContest.ScoreForm, 'ScoreForm', True);

      if Pos('WAEDC', MyContest.Name) > 0 then begin
         MessageBox(Handle, PChar('QTC can be sent by pressing Ctrl+Q'), PChar(Application.Title), MB_ICONINFORMATION or MB_OK);
      end;

      CurrentQSO.UpdateTime;
      TimeEdit.Text := CurrentQSO.TimeStr;

      // この時点でコンテストが必要とするバンドはBandMenuで表示されているもの
      // コンテストで必要なバンドかつActiveBandがONの数（＝使用可能）を数える
      c := GetNumOfAvailableBands();

      // 使用可能なバンドが無いときは必要バンドをONにする
      if c = 0 then begin
         AdjustActiveBands();
         MessageDlg('Active Bands adjusted to the required bands', mtInformation, [mbOK], 0);
      end;

      // 低いバンドから使用可能なバンドを探して最初のバンドとする
      CurrentQSO.Band := GetFirstAvailableBand(dmZLogGlobal.LastBand);
      FRateDialogEx.Band := CurrentQSO.Band;

      CurrentQSO.Serial := SerialArray[CurrentQSO.Band];
      SerialEdit.Text := CurrentQSO.SerialStr;

      BandEdit.Text := MHzString[CurrentQSO.Band];
      CurrentQSO.TX := dmZlogGlobal.TXNr;

      // マルチオペの場合は最後のOPをセット
      if (dmZlogGlobal.ContestCategory in [ccMultiOpMultiTx, ccMultiOpSingleTx, ccMultiOpTwoTx]) and
         (Log.TotalQSO > 0) then begin
         SelectOperator(Log.QsoList.Last.Operator);
      end;

      // 最初はCQモードから
      SetCQ(True);

      if CurrentQSO.Mode in [mCW, mRTTY] then begin
         Grid.Align := alNone;
         CWToolBar.Visible := True;
         SSBToolBar.Visible := False;
         Grid.Align := alClient;
      end
      else begin
         Grid.Align := alNone;
         SSBToolBar.Visible := True;
         CWToolBar.Visible := False;
         Grid.Align := alClient;
      end;

      ModeEdit.Text := CurrentQSO.ModeStr;
      RcvdRSTEdit.Text := CurrentQSO.RSTStr;

      // CurrentQSO.Serial := SerialArray[b19]; // in case SERIALSTART is defined. SERIALSTART applies to all bands.
      SerialEdit.Text := CurrentQSO.SerialStr;

      // フォントサイズの設定
//      SetFontSize(dmZlogGlobal.Settings._mainfontsize);
//      Application.ProcessMessages();

      Grid.Row := 1;
      Grid.ShowLast(Log.TotalQSO);
      GridRefreshScreen();

      MyContest.MultiForm.FontSize := dmZlogGlobal.Settings._mainfontsize;

      // QSY Assist
      CountDownStartTime := 0;
//      QSYCount := 0;

      // M/S,M/2の場合はQsyAssist強制
      if (dmZLogGlobal.ContestCategory in [ccMultiOpSingleTx, ccMultiOpTwoTx]) then begin
         if (dmZLogGlobal.Settings._qsycount = False) and (dmZLogGlobal.Settings._countdown = False) then begin
            dmZLogGlobal.Settings._countdown := True;
         end;
      end;

      UpdateBand(CurrentQSO.Band);
      UpdateMode(CurrentQSO.Mode);

      MyContest.ScoreForm.UpdateData();
      MyContest.MultiForm.UpdateData();

      if FPostContest then begin
         TimeEdit.SetFocus;
      end
      else begin
         CallsignEdit.SetFocus;
      end;

      FormResize(Self);

      LastFocus := CallsignEdit; { the place to set focus when ESC is pressed from Grid }

      // リグコントロール開始
      RigControl.ImplementOptions;

      // CTY.DATが必要なコンテストでロードされていない場合はお知らせする
      if (MyContest.NeedCtyDat = True) and (dmZLogGlobal.CtyDatLoaded = False) then begin
         WriteStatusLineRed('CTY.DAT not loaded', True);
      end;

      // 初期化完了
      FInitialized := True;
      Timer1.Enabled := True;
      zyloContestOpened(MyContest.Name, menu.CFGFileName);

   finally
      menu.Release();
   end;
end;

procedure TMainForm.OnZLogSetGridCol( var Message: TMessage );
begin
   SetListWidth();
end;

procedure TMainForm.OnZLogSpcDataLoaded( var Message: TMessage );
begin
   FSuperCheck.ListBox.Clear();
   FSuperCheck2.ListBox.Clear();
   FSpcDataLoading := False;
end;

procedure TMainForm.InitALLJA();
begin
//   BandMenu.Items[Ord(b19)].Visible := False;
   HideBandMenuWARC();
   HideBandMenuVU(False);

   EditScreen := TALLJAEdit.Create(Self);

   MyContest := TALLJAContest.Create('ALL JA コンテスト');
end;

procedure TMainForm.Init6D();
begin
   HideBandMenuHF();
   HideBandMenuWARC();

   EditScreen := TACAGEdit.Create(Self);

   MyContest := TSixDownContest.Create('6m and DOWNコンテスト');
end;

procedure TMainForm.InitFD();
begin
//   BandMenu.Items[Ord(b19)].Visible := False;
   HideBandMenuWARC();

   EditScreen := TACAGEdit.Create(Self);

   MyContest := TFDContest.Create('フィールドデーコンテスト');
end;

procedure TMainForm.InitACAG();
begin
//   BandMenu.Items[Ord(b19)].Visible := False;
   HideBandMenuWARC();

   EditScreen := TACAGEdit.Create(Self);

   MyContest := TACAGContest.Create('全市全郡コンテスト');
end;

procedure TMainForm.InitALLJA0_JA0(BandGroupIndex: Integer);
begin
   HideBandMenuHF();
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TJA0Edit.Create(Self);

   MyContest := TJA0ContestZero.Create('ALL JA0 コンテスト (JA0)');

   case BandGroupIndex of
      // 3.5M
      2: begin
         MyContest.SetBand(b35);
         ShowBandMenu(b35);
      end;

      // 7M
      3: begin
         MyContest.SetBand(b7);
         ShowBandMenu(b7);
      end;

      // 21/28M
      7, 9: begin
         MyContest.SetBand(b21);
         dmZlogGlobal.Settings._band := 0;
         ShowBandMenu(b21);
         ShowBandMenu(b28);
      end;
   end;
end;

procedure TMainForm.InitALLJA0_Other(BandGroupIndex: Integer);
begin
   HideBandMenuHF();
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TJA0Edit.Create(Self);

   MyContest := TJA0Contest.Create('ALL JA0 コンテスト (Others)');

   case BandGroupIndex of
      // 3.5M
      2: begin
         MyContest.SetBand(b35);
         ShowBandMenu(b35);
      end;

      // 7M
      3: begin
         MyContest.SetBand(b7);
         ShowBandMenu(b7);
      end;

      // 21/28M
      7, 9: begin
         MyContest.SetBand(b21);
         dmZlogGlobal.Settings._band := 0;
         ShowBandMenu(b21);
         ShowBandMenu(b28);
      end;
   end;
end;

procedure TMainForm.InitKCJ();
begin
   BandMenu.Items[Ord(b19)].Visible := True;
   HideBandMenuWARC();
   HideBandMenuVU(False);

   EditScreen := TKCJEdit.Create(Self);

   MyContest := TKCJContest.Create('KCJ コンテスト');
end;

procedure TMainForm.InitDxPedi();
var
   F: TUTCDialog;
begin
   F := TUTCDialog.Create(Self);
   try
      F.ShowModal();

      UseUTC := F.UseUTC;

      MultiButton.Enabled := False; // toolbar
      Multipliers1.Enabled := False; // menu

      EditScreen := TGeneralEdit.Create(Self);

      MyContest := TPedi.Create('Pedition mode');
   finally
      F.Release();
   end;
end;

procedure TMainForm.InitUserDefined(ContestName, ConfigFile: string);
begin
   zyloContestSwitch(ContestName, ConfigFile);
   MyContest := TGeneralContest.Create(ContestName, ConfigFile);
end;

procedure TMainForm.InitCQWW();
begin
   HideBandMenuWARC();
   HideBandMenuVU();


   mnCheckCountry.Visible := True;
   mnCheckMulti.Caption := 'Check Zone';
   EditScreen := TWWEdit.Create(Self);

   MyContest := TCQWWContest.Create('CQWW DX Contest');
end;

procedure TMainForm.InitWPX(ContestCategory: TContestCategory);
begin
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TWPXEdit.Create(Self);

   Grid.Cells[EditScreen.colNewMulti1, 0] := 'prefix';

   MyContest := TCQWPXContest.Create('CQ WPX Contest');

   case ContestCategory of
      ccSingleOp:          SerialContestType := SER_ALL;
      ccMultiOpMultiTx:    SerialContestType := SER_BAND;
      ccMultiOpSingleTx:   SerialContestType := SER_MS;
      ccMultiOpTwoTx:      SerialContestType := SER_MS;
   end;

   mPXListWPX.Visible := True;
end;

procedure TMainForm.InitJIDX();
begin
   HideBandMenuWARC();
   HideBandMenuVU();

   if dmZLogGlobal.MyCountry = 'JA' then begin
      mnCheckCountry.Visible := True;
      mnCheckMulti.Caption := 'Check Zone';
      EditScreen := TWWEdit.Create(Self);
      MyContest := TJIDXContest.Create('JIDX Contest (JA)');
   end
   else begin
      EditScreen := TGeneralEdit.Create(Self);
      MyContest := TJIDXContestDX.Create('JIDX Contest (DX)');
   end;
end;

procedure TMainForm.InitAPSprint();
begin
   BandMenu.Items[Ord(b19)].Visible := False;
   BandMenu.Items[Ord(b35)].Visible := False;
   BandMenu.Items[Ord(b28)].Visible := False;
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TWPXEdit.Create(Self);

   MyContest := TAPSprint.Create('Asia Pacific Sprint');
   // Log.QsoList[0].memo := 'WPX Contest';
end;

procedure TMainForm.InitARRL_W();
begin
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TDXCCEdit.Create(Self);

   MyContest := TARRLDXContestW.Create('ARRL International DX Contest (W/VE)');
end;

procedure TMainForm.InitARRL_DX();
begin
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TARRLDXEdit.Create(Self);

   MyContest := TARRLDXContestDX.Create('ARRL International DX Contest (DX)');
end;

procedure TMainForm.InitARRL10m();
begin
   BandMenu.Items[Ord(b19)].Visible := False;
   BandMenu.Items[Ord(b35)].Visible := False;
   BandMenu.Items[Ord(b7)].Visible := False;
   BandMenu.Items[Ord(b14)].Visible := False;
   BandMenu.Items[Ord(b21)].Visible := False;
   HideBandMenuWARC();
   HideBandMenuVU();

   MyContest := TARRL10Contest.Create('ARRL 10m Contest');

   if dmZLogGlobal.IsUSA() then begin
      EditScreen := TDXCCEdit.Create(Self);
      MyContest.SentStr := '$V';
   end
   else begin
      EditScreen := TIOTAEdit.Create(Self);
      MyContest.SentStr := '$S';
   end;
end;

procedure TMainForm.InitIARU();
begin
   HideBandMenuVU();

   EditScreen := TIARUEdit.Create(Self);

   MyContest := TIARUContest.Create('IARU HF World Championship');
end;

procedure TMainForm.InitAllAsianDX();
var
   F: TAgeDialog;
begin
   F := TAgeDialog.Create(Self);
   try
      HideBandMenuWARC();
      HideBandMenuVU();

      EditScreen := TDXCCEdit.Create(Self);

      MyContest := TAllAsianContest.Create('All Asian DX Contest (Asia)');

      if F.ShowModal() <> mrOK then begin
         Exit;
      end;

      dmZLogGlobal.Settings._age := F.Age;
   finally
      F.Release();
   end;
end;

procedure TMainForm.InitIOTA();
begin
   BandMenu.Items[Ord(b19)].Visible := False;
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TIOTAEdit.Create(Self);

   MyContest := TIOTAContest.Create('IOTA Contest');
end;

procedure TMainForm.InitWAE();
begin
   BandMenu.Items[Ord(b19)].Visible := False;
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TWPXEdit.Create(Self);

   MyContest := TWAEContest.Create('WAEDC Contest');
end;

procedure TMainForm.ShowBandMenu(b: TBand);
begin
   BandMenu.Items[Ord(b)].Visible := True;
   BandMenu.Items[Ord(b)].Enabled := True;
end;

procedure TMainForm.HideBandMenu(b: TBand);
begin
   BandMenu.Items[Ord(b)].Visible := False;
   BandMenu.Items[Ord(b)].Enabled := False;
end;

procedure TMainForm.HideBandMenuHF();
begin
   BandMenu.Items[Ord(b19)].Visible := False;
   BandMenu.Items[Ord(b35)].Visible := False;
   BandMenu.Items[Ord(b7)].Visible := False;
   BandMenu.Items[Ord(b14)].Visible := False;
   BandMenu.Items[Ord(b21)].Visible := False;
   BandMenu.Items[Ord(b28)].Visible := False;
   BandMenu.Items[Ord(b19)].Enabled := False;
   BandMenu.Items[Ord(b35)].Enabled := False;
   BandMenu.Items[Ord(b7)].Enabled := False;
   BandMenu.Items[Ord(b14)].Enabled := False;
   BandMenu.Items[Ord(b21)].Enabled := False;
   BandMenu.Items[Ord(b28)].Enabled := False;
end;

procedure TMainForm.HideBandMenuWARC();
begin
   BandMenu.Items[Ord(b10)].Visible := False;
   BandMenu.Items[Ord(b18)].Visible := False;
   BandMenu.Items[Ord(b24)].Visible := False;
   BandMenu.Items[Ord(b10)].Enabled := False;
   BandMenu.Items[Ord(b18)].Enabled := False;
   BandMenu.Items[Ord(b24)].Enabled := False;
end;

procedure TMainForm.HideBandMenuVU(fInclude50: Boolean);
begin
   if fInclude50 = True then begin
      BandMenu.Items[Ord(b50)].Visible := False;
      BandMenu.Items[Ord(b50)].Enabled := False;
   end;
   BandMenu.Items[Ord(b144)].Visible := False;
   BandMenu.Items[Ord(b430)].Visible := False;
   BandMenu.Items[Ord(b1200)].Visible := False;
   BandMenu.Items[Ord(b2400)].Visible := False;
   BandMenu.Items[Ord(b5600)].Visible := False;
   BandMenu.Items[Ord(b10G)].Visible := False;
   BandMenu.Items[Ord(b144)].Enabled := False;
   BandMenu.Items[Ord(b430)].Enabled := False;
   BandMenu.Items[Ord(b1200)].Enabled := False;
   BandMenu.Items[Ord(b2400)].Enabled := False;
   BandMenu.Items[Ord(b5600)].Enabled := False;
   BandMenu.Items[Ord(b10G)].Enabled := False;
end;

function TMainForm.GetNumOfAvailableBands(): Integer;
var
   c: Integer;
   b: TBand;
begin
   c := 0;
   for b := b19 to HiBand do begin
      if (BandMenu.Items[Ord(b)].Enabled = True) and
         (dmZlogGlobal.Settings._activebands[b] = True) then begin
         Inc(c);
      end;
   end;

   Result := c;
end;

procedure TMainForm.AdjustActiveBands();
var
   b: TBand;
begin
   for b := b19 to HiBand do begin
      if (BandMenu.Items[Ord(b)].Enabled = True) then begin
         dmZlogGlobal.Settings._activebands[b] := True;
      end;
   end;
end;

function TMainForm.GetFirstAvailableBand(defband: TBand): TBand;
var
   b: TBand;
begin
   if (BandMenu.Items[Ord(defband)].Enabled = True) and
      (dmZlogGlobal.Settings._activebands[defband] = True) then begin
      Result := defband;
      Exit;
   end;

   for b := b19 to HiBand do begin
      if (BandMenu.Items[Ord(b)].Enabled = True) and
         (dmZlogGlobal.Settings._activebands[b] = True) then begin
         Result := b;
         Exit;
      end;
   end;

   for b := b19 to HiBand do begin
      if (BandMenu.Items[Ord(b)].Enabled = True) then begin
         Result := b;
         Exit;
      end;
   end;

   Result := b19;
end;

procedure TMainForm.SetWindowCaption();
var
   strCap: string;
   strTxNo: string;
begin
   // SingleOP以外はTX#を表示する
   if dmZLogGlobal.ContestCategory = ccSingleOp then begin
      strTxNo := '';
   end
   else begin
      strTxNo := '[TX#' + IntToStr(dmZLogGlobal.TXNr) + '] ';
   end;

   strCap := strTxNo + 'zLog for Windows';

   // M/Sの場合は RUN/MULTI表示を追加
   if dmZLogGlobal.ContestCategory = ccMultiOpSingleTx then begin
      if dmZlogGlobal.TXNr = 0 then begin
         strCap := strCap + ' - Running station';
      end
      else begin
         strCap := strCap + ' - Multi station';
      end;
   end;

   // Z-LINK利用時はPC名表示を追加
   if dmZlogGlobal.Settings._zlinkport <> 0 then begin
      if dmZlogGlobal.Settings._pcname <> '' then begin
          strCap := strCap + ' [' + dmZlogGlobal.Settings._pcname + ']';
      end;
   end;

   // 使用中のファイル名
   strCap := strCap + ' - ' + ExtractFileName(CurrentFileName);

   Caption := strCap;
end;

procedure TMainForm.QSY(b: TBand; m: TMode; r: Integer);
begin
   if r <> 0 then begin
      if RigControl.SetCurrentRig(r) = True then begin
         SwitchRig(r);
      end;
   end;

   if CurrentQSO.band <> b then begin
      UpdateBand(b);

      if RigControl.Rig <> nil then begin
         RigControl.Rig.SetBand(CurrentQSO);
      end;
   end;

   if CurrentQSO.Mode <> m then begin
      UpdateMode(m);
   end;

   if RigControl.Rig <> nil then begin
      RigControl.Rig.SetMode(CurrentQSO);
   end;
end;

procedure TMainForm.PlayMessage(bank: Integer; no: Integer);
var
   nID: Integer;
begin
   WriteStatusLine('', False);

   nID := GetCurrentRigID();

   case CurrentQSO.Mode of
      mCW: begin
         if dmZLogKeyer.KeyingPort[nID] = tkpNone then begin
            WriteStatusLineRed('CW port is not set', False);
            Exit;
         end;
         WriteStatusLine('', False);
         PlayMessageCW(bank, no);
      end;

      mSSB, mFM, mAM: begin
         PlayMessagePH(no);
      end;

      mRTTY: begin
         PlayMessageRTTY(no);
      end;

      else begin
         // NO OPERATION
      end;
   end;
end;

procedure TMainForm.PlayMessageCW(bank: Integer; no: Integer);
var
   S: string;
   nID: Integer;
begin
   if no >= 101 then begin
      SetCQ(True);
      bank := dmZlogGlobal.Settings.CW.CurrentBank;
      S := dmZlogGlobal.CWMessage(bank, FCurrentCQMessageNo);
   end
   else begin
      S := dmZlogGlobal.CWMessage(bank, no);
   end;

   if S = '' then begin
      Exit;
   end;

   nID := GetCurrentRigID();
   zLogSendStr2(nID, S, CurrentQSO);
end;

procedure TMainForm.PlayMessagePH(no: Integer);
begin
   case no of
      1, 2, 3, 4, 5, 6,
      7, 8, 9, 10, 11, 12: begin
         FVoiceForm.SendVoice(no);
      end;

      101: begin
         FVoiceForm.SendVoice(FCurrentCQMessageNo);
         SetCQ(True);
      end;

      102: begin
         FVoiceForm.SendVoice(102);
         SetCQ(True);
      end;

      103: begin
         FVoiceForm.SendVoice(103);
         SetCQ(True);
      end;
   end;
end;

procedure TMainForm.PlayMessageRTTY(no: Integer);
var
   S: string;
begin
   if FTTYConsole = nil then begin
      Exit;
   end;

   S := dmZlogGlobal.CWMessage(3, no);

   if S = '' then begin
      Exit;
   end;

   S := SetStrNoAbbrev(S, CurrentQSO);
   FTTYConsole.SendStrNow(S);
end;

procedure TMainForm.OnVoicePlayStarted(Sender: TObject);
begin
   VoiceStopButton.Enabled := True;
end;

procedure TMainForm.OnVoicePlayFinished(Sender: TObject);
begin
   VoiceStopButton.Enabled := False;
end;

procedure TMainForm.OnPaddle(Sender: TObject);
begin
   actionCQAbort.Execute();
end;

// バンドスコープへ追加
procedure TMainForm.InsertBandScope(fShiftKey: Boolean);
var
   nFreq: Integer;

   function InputFreq(): Boolean;
   var
      E: Extended;
      F: TIntegerDialog;
   begin
      F := TIntegerDialog.Create(Self);
      try
         F.SetLabel('Enter frequency in kHz');

         if F.ShowModal() <> mrOK then begin
            Result := False;
            Exit;
         end;

         E := F.GetValueExtended;
      finally
         F.Release();
      end;

      if E > 1000 then begin
         BandScopeAddSelfSpot(CurrentQSO, Round(E * 1000));
      end;

      Result := True;
   end;
begin
   if RigControl.Rig <> nil then begin
      nFreq := RigControl.Rig.CurrentFreqHz;
      if nFreq > 0 then begin
         BandScopeAddSelfSpot(CurrentQSO, nFreq);
      end
      else begin
         if InputFreq() = False then begin
            Exit;
         end;
      end;
   end
   else begin// no rig control
      if InputFreq() = False then begin
         Exit;
      end;
   end;

   if fShiftKey = False then begin
      CallsignEdit.Clear;
      CallsignEdit.SetFocus();
      NumberEdit.Clear;
   end;
end;

// #00-#07 CTRL+F1～F8
procedure TMainForm.actionQuickQSYExecute(Sender: TObject);
var
   no: Integer;
   b: TBand;
   m: TMode;
   r: Integer;
begin
   no := TAction(Sender).Tag;

   if dmZLogGlobal.Settings.FQuickQSY[no].FUse = False then begin
      Exit;
   end;

   b := dmZLogGlobal.Settings.FQuickQSY[no].FBand;
   m := dmZLogGlobal.Settings.FQuickQSY[no].FMode;
   r := dmZLogGlobal.Settings.FQuickQSY[no].FRig;

   QSY(b, m, r);

   LastFocus.SetFocus;
end;

// #08 Super Checkウインドウの表示 Ctrl+F10
procedure TMainForm.actionShowSuperCheckExecute(Sender: TObject);
begin
   FSuperCheck.Show;
   CheckSuper(CurrentQSO);

   LastFocus.SetFocus;
end;

// #09 Z-Link Monitor Ctrl+F12
procedure TMainForm.actionShowZlinkMonitorExecute(Sender: TObject);
begin
   FZLinkForm.Show;
end;

// #10-#17 F1～F8
// #20-#21 F11, F12
procedure TMainForm.actionPlayMessageAExecute(Sender: TObject);
var
   no: Integer;
   cb: Integer;
begin
   no := TAction(Sender).Tag;
   cb := dmZlogGlobal.Settings.CW.CurrentBank;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('PlayMessageA(' + IntToStr(cb) + ',' + IntToStr(no) + ')'));
   {$ENDIF}

   if RigControl.Rig <> nil then begin
      if dmZLogGlobal.Settings.FAntiZeroinXitOn2 = True then begin
         if RigControl.Rig.Xit = False then begin
            actionAntiZeroin.Execute();
         end;
      end;
   end;

   PlayMessage(cb, no);
end;

// #18 F9
procedure TMainForm.actionCheckMultiExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('CheckMulti()'));
   {$ENDIF}

   MyContest.MultiForm.CheckMulti(CurrentQSO);

   LastFocus.SetFocus;
end;

// #19 F10
procedure TMainForm.actionShowCheckPartialExecute(Sender: TObject);
begin
   FPartialCheck.Show;

   if ActiveControl = NumberEdit then begin
      FPartialCheck.CheckPartialNumber(CurrentQSO);
   end
   else begin
      FPartialCheck.CheckPartial(CurrentQSO);
   end;

   LastFocus.SetFocus;
end;

// #22-#29 SHIFT+F1～F8
// #30-#31 SHIFT+F11, SHIFT+F12
procedure TMainForm.actionPlayMessageBExecute(Sender: TObject);
var
   no: Integer;
   cb: Integer;
begin
   no := TAction(Sender).Tag;
   cb := dmZlogGlobal.Settings.CW.CurrentBank;

   if cb = 1 then
      cb := 2
   else
      cb := 1;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('PlayMessageB(' + IntToStr(cb) + ',' + IntToStr(no) + ')'));
   {$ENDIF}

   PlayMessage(cb, no);
end;

// #32, #33 CTRL+Enter, CTRL+N
procedure TMainForm.actionInsertBandScopeExecute(Sender: TObject);
begin
   InsertBandScope(False);
end;

// #34 CTRL+SHIFT+N
procedure TMainForm.actionInsertBandScope3Execute(Sender: TObject);
begin
   InsertBandScope(True);
end;

// #35 CTRL+S フォントサイズ↑
procedure TMainForm.actionIncreaseFontSizeExecute(Sender: TObject);
begin
   IncFontSize;
end;

// #36 CTRL+SHIFT+S フォントサイズ↓
procedure TMainForm.actionDecreaseFontSizeExecute(Sender: TObject);
begin
   DecFontSize();
end;

// #37 PageUp
procedure TMainForm.actionPageDownExecute(Sender: TObject);
var
   p: Integer;
begin
   if Log.QsoList.Count <= Grid.VisibleRowCount then begin
      Exit;
   end;

   p := Grid.TopRow;
   p := p + (Grid.VisibleRowCount div 2);
   if p > (Log.QsoList.Count - Grid.VisibleRowCount) then begin
      p := (Log.QsoList.Count - Grid.VisibleRowCount);
   end;
   Grid.TopRow := p
end;

// #38 PageDown
procedure TMainForm.actionPageUpExecute(Sender: TObject);
var
   p: Integer;
begin
   if Log.QsoList.Count <= Grid.VisibleRowCount then begin
      Exit;
   end;

   p := Grid.TopRow;
   p := p - (Grid.VisibleRowCount div 2);
   if p < 0 then begin
      p := 1;
   end;
   Grid.TopRow := p
end;

// #39 フィールドの先頭へ移動
procedure TMainForm.actionMoveTopExecute(Sender: TObject);
begin
   if ActiveControl is TOvrEdit then begin
      TOvrEdit(ActiveControl).SelStart := 0;
      TOvrEdit(ActiveControl).SelLength := 0;
   end;
end;

// #40 キャレットを左に移動
procedure TMainForm.actionMoveLeftExecute(Sender: TObject);
var
   i: Integer;
begin
   if ActiveControl is TOvrEdit then begin
      i := TOvrEdit(ActiveControl).SelStart;
      if i > 0 then begin
         TOvrEdit(ActiveControl).SelStart := i - 1;
      end;
   end;
end;

// #41 キャレット位置の文字を消去
procedure TMainForm.actionDeleteOneCharExecute(Sender: TObject);
var
   i: Integer;
   str: string;
begin
   if ActiveControl is TOvrEdit then begin
      i := TOvrEdit(ActiveControl).SelStart;
      str := TOvrEdit(ActiveControl).Text;

      if i < Length(TOvrEdit(ActiveControl).Text) then begin
         Delete(str, i + 1, 1);
      end;

      TOvrEdit(ActiveControl).Text := str;
      TOvrEdit(ActiveControl).SelStart := i;
   end;
end;

// #42 キャレットを最後に移動
procedure TMainForm.actionMoveLastExecute(Sender: TObject);
begin
   if ActiveControl is TOvrEdit then begin
      TOvrEdit(ActiveControl).SelStart := Length(TOvrEdit(ActiveControl).Text);
      TOvrEdit(ActiveControl).SelLength := 0;
   end;
end;

// #43 キャレットを右に移動
procedure TMainForm.actionMoveRightExecute(Sender: TObject);
var
   i: Integer;
begin
   if ActiveControl is TOvrEdit then begin
      i := TOvrEdit(ActiveControl).SelStart;
      if i < Length(TOvrEdit(ActiveControl).Text) then begin
         TOvrEdit(ActiveControl).SelStart := i + 1;
      end;
   end;
end;

// #44 一時メモリーよりＱＳＯ呼び出し
procedure TMainForm.actionPullQsoExecute(Sender: TObject);
begin
   PullQSO();
end;

// #45 キャレットの左一文字を削除(BackSpaceと同じ)
procedure TMainForm.actionDeleteLeftOneCharExecute(Sender: TObject);
var
   i: Integer;
   str: string;
begin
   if ActiveControl is TOvrEdit then begin
      i := TOvrEdit(ActiveControl).SelStart;
      if i > 0 then begin
         str := TOvrEdit(ActiveControl).Text;
         Delete(str, i, 1);
         TOvrEdit(ActiveControl).Text := str;
         TOvrEdit(ActiveControl).SelStart := i;
      end;
   end;
end;

// #46 パーシャルチェックorスーパーチェックより取り込み
procedure TMainForm.actionGetPartialCheckExecute(Sender: TObject);
   procedure SetCallsign(strCallsign: string);
   begin
      CallsignEdit.Text := strCallsign;
      CallSignEdit.SelStart := Length(CallsignEdit.Text);
   end;
begin
   if FPartialCheck.Visible then begin
      if FPartialCheck.HitNumber > 0 then begin
         SetCallsign(FPartialCheck.HitCall);
         Exit;
      end;
   end;

   if FSuperCheck.Visible then begin
      if FSpcHitNumber > 0 then begin
         SetCallsign(FSpcHitCall);
         Exit;
      end;
   end;
end;

// #47 キャレット位置より右を削除
procedure TMainForm.actionDeleteRightExecute(Sender: TObject);
var
   i: Integer;
   str: string;
begin
   if ActiveControl is TOvrEdit then begin
      i := TOvrEdit(ActiveControl).SelStart;
      str := TOvrEdit(ActiveControl).Text;
      str := Copy(str, 1, i);
      TOvrEdit(ActiveControl).Text := str;
      TOvrEdit(ActiveControl).SelStart := Length(str);
   end;
end;

// #48 コールサインフィールドとナンバーフィールドの内容をすべて削除
procedure TMainForm.actionClearCallAndRptExecute(Sender: TObject);
begin
   EditedSinceTABPressed := tabstate_normal;
   CallsignEdit.Clear;
   NumberEdit.Clear;
   MemoEdit.Clear;
   CallsignEdit.SetFocus;
   WriteStatusLine('', False);
end;

// #49 同じバンドのみ表示
procedure TMainForm.actionShowCurrentBandOnlyExecute(Sender: TObject);
begin
   ShowCurrentBandOnly.Checked := not(ShowCurrentBandOnly.Checked);
   GridRefreshScreen();
end;

// #50 時刻を１分戻す
procedure TMainForm.actionDecreaseTimeExecute(Sender: TObject);
begin
   CurrentQSO.DecTime;
   TimeEdit.Text := CurrentQSO.TimeStr;
   DateEdit.Text := CurrentQSO.DateStr;
end;

// #51 時刻を１分進める
procedure TMainForm.actionIncreaseTimeExecute(Sender: TObject);
begin
   CurrentQSO.IncTime;
   TimeEdit.Text := CurrentQSO.TimeStr;
   DateEdit.Text := CurrentQSO.DateStr;
end;

// #52 QTC送信
procedure TMainForm.actionQTCExecute(Sender: TObject);
begin
   if MyContest.Name <> 'WAEDC Contest' then begin
      Exit;
   end;

   TWAEContest(MyContest).QTCForm.Show;
   if CurrentQSO.Callsign = '' then begin
      if Log.TotalQSO >= 2 then begin
         TWAEContest(MyContest).QTCForm.OpenQTC(Log.QsoList[Log.TotalQSO]);
      end;
   end
   else begin
      TWAEContest(MyContest).QTCForm.OpenQTC(Main.CurrentQSO);
   end;
end;

// #53 パドルリバース
procedure TMainForm.actionReversePaddleExecute(Sender: TObject);
begin
   dmZlogGlobal.ReversePaddle;
end;

// #54 CW Tune
procedure TMainForm.actionCwTuneExecute(Sender: TObject);
var
   nID: Integer;
begin
   if CurrentQSO.Mode = mCW then begin
      CtrlZCQLoop := True;
      nID := GetCurrentRigID();
      dmZLogKeyer.TuneOn(nID);
   end;
end;

// #55 全ての入力フィールドの内容を一時メモリに保存（最大5つ）
procedure TMainForm.actionPushQsoExecute(Sender: TObject);
begin
   PushQSO(CurrentQSO);
end;

// #56 現在の入力フィールドをクリア
procedure TMainForm.actionFieldClearExecute(Sender: TObject);
begin
   if ActiveControl is TOvrEdit then begin
      TOvrEdit(ActiveControl).Clear;
      WriteStatusLine('', False);
   end;
   if ActiveControl is TEdit then begin
      TEdit(ActiveControl).Clear;
      WriteStatusLine('', False);
   end;
end;

// #57 ＣＱ送出
procedure TMainForm.actionCQRepeatExecute(Sender: TObject);
begin
   case CurrentQSO.Mode of
      mCW: CQRepeatClick2(Sender);
      mSSB, mFM, mAM: VoiceCQ3Click(Sender);
   end;
end;

// #58 Backup / Alt+B
procedure TMainForm.actionBackupExecute(Sender: TObject);
var
   P: string;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('---actionBackupExecute---'));
   {$ENDIF}

   P := dmZlogGlobal.Settings._backuppath;
   if (P = '') or (P = '\') then begin
      P := ExtractFilePath(Application.ExeName);
   end;

   if DirectoryExists(P) = False then begin
      ForceDirectories(P);
   end;

   P := P + ExtractFileName(CurrentFileName) + '.BAK';
   Log.Backup(P);
   Log.SaveToFile(P);
end;

// #59 Callsignにフォーカス移動 / Alt+C
procedure TMainForm.actionFocusCallsignExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('---actionFocusCallsignExecute---'));
   {$ENDIF}
   CallsignEdit.SetFocus;
end;

// #60 CW Keyboard / Alt+K
procedure TMainForm.actionShowCWKeyboardExecute(Sender: TObject);
begin
   FCWKeyBoard.Show;
end;

// #61 Memo欄にフォーカス移動 / Alt+M
procedure TMainForm.actionFocusMemoExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('---actionFocusMemoExecute---'));
   {$ENDIF}
   MemoEdit.SetFocus;
end;

// #62 Number欄にフォーカス移動 / Alt+N
procedure TMainForm.actionFocusNumberExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('---actionFocusNumberExecute---'));
   {$ENDIF}
   NumberEdit.SetFocus;
end;

// #63 OP欄にフォーカス移動
procedure TMainForm.actionFocusOpExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('---actionFocusOpExecute---'));
   {$ENDIF}
   OpEdit1Click(Self);
end;

// #64 Packet Cluster / Alt+P
procedure TMainForm.actionShowPacketClusterExecute(Sender: TObject);
begin
   FCommForm.Show;
   LastFocus.SetFocus();
end;

// #65 Console Pad / Alt+Q
procedure TMainForm.actionShowConsolePadExecute(Sender: TObject);
begin
   FConsolePad.Show;
end;

// #66 RST欄にフォーカス移動 / Alt+R
procedure TMainForm.actionFocusRstExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('---actionFocusRstExecute---'));
   {$ENDIF}
   RcvdRSTEdit.SetFocus;
end;

// #67 Scratch Sheet / Alt+S
procedure TMainForm.actionShowScratchSheetExecute(Sender: TObject);
begin
   FScratchSheet.Show;
end;

// #68 RIG Control / Alt+T
procedure TMainForm.actionShowRigControlExecute(Sender: TObject);
begin
   RigControl.Show;
   LastFocus.SetFocus();
end;

// #69 CallsignとNumberをクリアしてコールサイン欄にフォーカス / Alt+W
procedure TMainForm.actoinClearCallAndNumAftFocusExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('---actoinClearCallAndNumAftFocusExecute---'));
   {$ENDIF}
   CallsignEdit.Clear();
   NumberEdit.Clear();
   MemoEdit.Clear();
   WriteStatusLine('', False);
   CallsignEdit.SetFocus;
end;

// #70 Z-Serverのチャットウインドウ / Alt+Z
procedure TMainForm.actionShowZServerChatExecute(Sender: TObject);
begin
   FChatForm.Show;
end;

// #71 RIG切り替え / Alt+. , Shift+X
procedure TMainForm.actionToggleRigExecute(Sender: TObject);
var
   rig: Integer;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- #71 ToggleRIG ---'));
   {$ENDIF}
   CtrlZCQLoop := False;
   dmZLogKeyer.CQLoopCount := 999;
   rig := RigControl.ToggleCurrentRig();
   SwitchRig(rig);
end;

// #72 BandScope
procedure TMainForm.actionShowBandScopeExecute(Sender: TObject);
var
   b: TBand;
begin
   for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
      if dmZLogGlobal.Settings._usebandscope[b] = True then begin
         FBandScopeEx[b].Show();
      end
      else begin
         FBandScopeEx[b].Hide();
      end;
   end;
   if dmZLogGlobal.Settings._usebandscope_current = True then begin
      FBandScope.Show();
   end
   else begin
      FBandScope.Hide();
   end;
end;

// #73 Running Frequencies
procedure TMainForm.actionShowFreqListExecute(Sender: TObject);
begin
   FFreqList.Show;
end;

// #74 Teletype Console
procedure TMainForm.actionShowTeletypeConsoleExecute(Sender: TObject);
begin
   if Assigned(FTTYConsole) then begin
      FTTYConsole.Show;
   end;
end;

// #75 analyzeウインドウ
procedure TMainForm.actionShowAnalyzeExecute(Sender: TObject);
begin
   FZAnalyze.Show();
   LastFocus.SetFocus();
end;

// #76 Scoreウインドウ
procedure TMainForm.actionShowScoreExecute(Sender: TObject);
begin
   MyContest.ShowScore;
end;

// #77 マルチウインドウ
procedure TMainForm.actionShowMultipliersExecute(Sender: TObject);
begin
   MyContest.ShowMulti;
end;

// #78 QSO Rateウインドウ
procedure TMainForm.actionShowQsoRateExecute(Sender: TObject);
begin
   FRateDialog.Show;
end;

// #79 Check Callウインドウ
procedure TMainForm.actionShowCheckCallExecute(Sender: TObject);
begin
   FCheckCall2.Show;
   LastFocus.SetFocus();
end;

// #80 Check Multiウインドウ
procedure TMainForm.actionShowCheckMultiExecute(Sender: TObject);
begin
   FCheckMulti.Show;
   LastFocus.SetFocus();
end;

// #81 Check Countryウインドウ
procedure TMainForm.actionShowCheckCountryExecute(Sender: TObject);
begin
   FCheckCountry.Show;
   LastFocus.SetFocus();
end;

// #82 交信開始 / TAB
// 相手のコールサインとナンバーを送信し(F2)ナンバーフィールドに移動、ただしデュープならばQSO B4を送信(F4)
procedure TMainForm.actionQsoStartExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('---actionQsoStartExecute---'));
   {$ENDIF}

   if not(TabPressed) and (CallsignEdit.Focused or NumberEdit.Focused) then begin
      if Trunc((Now - LastTabPress) * 24 * 60 * 60 * 1000) > 100 then begin
         OnTabPress;
      end;

      LastTabPress := Now;
   end;
end;

// #83 交信完了 / ↓
// TUと自局のコールサインを送信し(F3)QSOを確定、ただしナンバーが有効でない場合はNR?を送信(F5)
procedure TMainForm.actionQsoCompleteExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('---actionQsoCompleteExecute---'));
   {$ENDIF}
   DownKeyPress;
end;

// #84 No Operation
procedure TMainForm.actionNopExecute(Sender: TObject);
begin
   //
end;

// #85 新しいプリフィックスの登録
procedure TMainForm.actionRegNewPrefixExecute(Sender: TObject);
begin
   MyContest.MultiForm.SelectAndAddNewPrefix(CurrentQSO.Callsign);
end;

// #86 PTT制御出力の手動トグル
procedure TMainForm.actionControlPTTExecute(Sender: TObject);
var
   nID: Integer;
begin
   nID := GetCurrentRigID();

   dmZLogKeyer.ControlPTT(nID, not(dmZLogKeyer.PTTIsOn)); // toggle PTT;
end;

// #87 N+1ウインドウの表示
procedure TMainForm.actionShowSuperCheck2Execute(Sender: TObject);
begin
   FSuperCheck2.Show;
   CheckSuper2(CurrentQSO);

   LastFocus.SetFocus;
end;

// #88 N+1より取り込み
procedure TMainForm.actionGetSuperCheck2Execute(Sender: TObject);
var
   i: Integer;
   m: TMenuItem;
   pt: TPoint;
begin
   if FSuperCheck2.Visible = False then begin
      Exit;
   end;

   case FSuperCheck2.Count of
      0: begin
         Exit;
      end;

      1: begin
         CallsignEdit.Text := FSuperCheck2.Items[0];
         CallSignEdit.SelStart := Length(CallsignEdit.Text);
         Exit;
      end;

      else begin
         SPCMenu.Items.Clear();

         for i := 0 to FSuperCheck2.Count - 1 do begin
            m := TMenuItem.Create(Self);
            m.Caption := FSuperCheck2.Items[i];
            m.OnClick := OnSPCMenuItemCick;
            SPCMenu.Items.Add(m);
         end;

         pt.X := CallsignEdit.Left;
         pt.Y := CallsignEdit.Top;
         pt := CallsignEdit.ClientToScreen(pt);
         SPCMenu.Popup(pt.X, pt.Y);
      end;
   end;
end;

// #89 バンド変更 Shift+B
procedure TMainForm.actionChangeBandExecute(Sender: TObject);
begin
   UpdateBand(GetNextBand(CurrentQSO.Band, True));

   if RigControl.Rig <> nil then begin
      RigControl.Rig.SetBand(CurrentQSO);

      if CurrentQSO.Mode = mSSB then begin
         RigControl.Rig.SetMode(CurrentQSO);
      end;
   end;
end;

// #90 モード変更 Shift+M
procedure TMainForm.actionChangeModeExecute(Sender: TObject);
begin
   SetQSOMode(CurrentQSO);
   UpdateMode(CurrentQSO.Mode);

   if RigControl.Rig <> nil then begin
      RigControl.Rig.SetMode(CurrentQSO);
   end;
end;

// #91 パワー変更 Shift+P
procedure TMainForm.actionChangePowerExecute(Sender: TObject);
begin
   MyContest.ChangePower;
end;

// #92 CWバンク変更 Shift+F
procedure TMainForm.actionChangeCwBankExecute(Sender: TObject);
begin
   SwitchCWBank(0);
end;

// #93 了解度(R)変更 Shift+R
procedure TMainForm.actionChangeRExecute(Sender: TObject);
begin
   SetR(CurrentQSO);
   RcvdRSTEdit.Text := CurrentQSO.RSTStr;
end;

// #94 信号強度(S)変更 Shift+S
procedure TMainForm.actionChangeSExecute(Sender: TObject);
begin
   SetS(CurrentQSO);
   RcvdRSTEdit.Text := CurrentQSO.RSTStr;
end;

// #95 時刻フィールドを現在時刻にセットする Shift+T
procedure TMainForm.actionSetCurTimeExecute(Sender: TObject);
begin
   CurrentQSO.UpdateTime;
   TimeEdit.Text := CurrentQSO.TimeStr;
   DateEdit.Text := CurrentQSO.DateStr;
end;

// #96 QRU Shift+U
procedure TMainForm.actionDecreaseCwSpeedExecute(Sender: TObject);
begin
   dmZLogKeyer.DecCWSpeed();
end;

// #97 QRQ Shift+Y
procedure TMainForm.actionIncreaseCwSpeedExecute(Sender: TObject);
begin
   dmZLogKeyer.IncCWSpeed();
end;

// #98 連続CQ、ESCを押さないと送信解除しない Shift+Z
procedure TMainForm.actionCQRepeat2Execute(Sender: TObject);
begin
   case CurrentQSO.Mode of
      mCW: CQRepeatClick1(Sender);
      mSSB, mFM, mAM: VoiceCQ2Click(Sender);
   end;
end;

// #99 VFOのトグル
procedure TMainForm.actionToggleVFOExecute(Sender: TObject);
begin
   if RigControl.Rig <> nil then begin
      RigControl.Rig.ToggleVFO;
   end;
end;

// #100 最後の交信のエディット
procedure TMainForm.actionEditLastQSOExecute(Sender: TObject);
begin
   Grid.Row := Log.QsoList.Count - 1;

   LastFocus := TEdit(ActiveControl);
   Grid.SetFocus;

   MyContest.EditCurrentRow;
end;

// #101 PSE QSL
procedure TMainForm.actionQuickMemo1Execute(Sender: TObject);
var
   strTemp: string;
   strPseQsl: string;
   strNoQsl: string;
begin
   strPseQsl := dmZlogGlobal.Settings.FQuickMemoText[1];
   strNoQsl  := dmZlogGlobal.Settings.FQuickMemoText[2];

   strTemp := MemoEdit.Text;
   if Pos(strNoQsl, strTemp) > 0 then begin
      strTemp := Trim(StringReplace(strTemp, strNoQsl, '', [rfReplaceAll]));
   end;

   if Pos(strPseQsl, strTemp) = 0 then begin
      strTemp := strPseQsl + ' ' + strTemp;
   end
   else begin
      strTemp := Trim(StringReplace(strTemp, strPseQsl, '', [rfReplaceAll]));
   end;

   MemoEdit.Text := strTemp;
end;

// #102 NO QSL
procedure TMainForm.actionQuickMemo2Execute(Sender: TObject);
var
   strTemp: string;
   strPseQsl: string;
   strNoQsl: string;
begin
   strPseQsl := dmZlogGlobal.Settings.FQuickMemoText[1];
   strNoQsl  := dmZlogGlobal.Settings.FQuickMemoText[2];

   strTemp := MemoEdit.Text;
   if Pos(strPseQsl, strTemp) > 0 then begin
      strTemp := Trim(StringReplace(strTemp, strPseQsl, '', [rfReplaceAll]));
   end;

   if Pos(strNoQsl, strTemp) = 0 then begin
      strTemp := strNoQsl + ' ' + strTemp;
   end
   else begin
      strTemp := Trim(StringReplace(strTemp, strNoQsl, '', [rfReplaceAll]));
   end;

   MemoEdit.Text := strTemp;
end;

// #103 CW Message Pad
procedure TMainForm.actionCwMessagePadExecute(Sender: TObject);
begin
   FCWMessagePad.Show();
end;

// #104 Correct NR
procedure TMainForm.actionCorrectSentNrExecute(Sender: TObject);
var
   F: TNRDialog;
   i: Integer;
   strNewNR: string;
   strNewNR2: string;
   B: TBand;
   Q: TQSO;
begin
   F := TNRDialog.Create(Self);
   try
      if Log.TotalQSO = 0 then begin
         Exit;
      end;

      F.NewSentNR := Log.QSOList[1].NrSent;
      F.NewSentNR2 := Log.QSOList[1].NrSent;

      if F.ShowModal() <> mrOK then begin
         Exit;
      end;

      strNewNR := F.NewSentNR;
      strNewNR2 := F.NewSentNR2;

      for i := 1 to Log.QSOList.Count - 1 do begin
         Q := Log.QSOList[i];

         B := Q.Band;
         if B < b2400 then begin
            if F.AutoAddPowerCode = True then begin
               Q.NrSent := strNewNR + dmZlogGlobal.Settings._power[B];
            end
            else begin
               Q.NrSent := strNewNR;
            end;
         end
         else begin
            if F.AutoAddPowerCode = True then begin
               Q.NrSent := strNewNR2 + dmZlogGlobal.Settings._power[B];
            end
            else begin
               Q.NrSent := strNewNR2;
            end;
         end;
      end;

      Log.Saved := False;
   finally
      F.Release();
   end;
end;

// #105 Jump to the last frequency
procedure TMainForm.actionSetLastFreqExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('---actionSetLastFreqExecute---'));
   {$ENDIF}
   if RigControl.Rig <> nil then begin
      RigControl.Rig.MoveToLastFreq;
   end;

   SetCQ(True);
end;

// #106,#107,#108 QuickMemo3-5
procedure TMainForm.actionQuickMemo3Execute(Sender: TObject);
var
   strQuickMemoText: string;
   strTemp: string;
   n: Integer;
begin
   // 設定された文字列を取得
   n := TAction(Sender).Tag;
   strQuickMemoText := dmZlogGlobal.Settings.FQuickMemoText[n];
   if strQuickMemoText = '' then begin
      Exit;
   end;

   // 現在の内容を取得
   strTemp := MemoEdit.Text;

   // 未設定ならmemo欄に挿入、設定済みなら削除
   if Pos(strQuickMemoText, strTemp) = 0 then begin
      strTemp := strQuickMemoText + ' ' + strTemp;
   end
   else begin
      strTemp := Trim(StringReplace(strTemp, strQuickMemoText + ' ', '', [rfReplaceAll]));
      strTemp := Trim(StringReplace(strTemp, strQuickMemoText, '', [rfReplaceAll]));
   end;

   MemoEdit.Text := strTemp;
end;

// #113 CW/Voice送出中止 ESC
procedure TMainForm.actionCQAbortExecute(Sender: TObject);
begin
   WriteStatusLine('', False);

   CWStopButtonClick(Self);
   VoiceStopButtonClick(Self);

   TabPressed := False;
   TabPressed2 := False;

   // ２回やらないようにPTT ControlがOFFの場合にPTT OFFする
   if dmZLogGlobal.Settings._pttenabled = False then begin
      dmZLogKeyer.ControlPTT(0, False);
      dmZLogKeyer.ControlPTT(1, False);
   end;
end;

// #120 CQモード、SPモードのトグル
procedure TMainForm.actionToggleCqSpExecute(Sender: TObject);
begin
   SetCQ(Not IsCQ());
end;

// #121 CQ間隔UP
procedure TMainForm.actionCQRepeatIntervalUpExecute(Sender: TObject);
begin
   dmZLogGlobal.Settings.CW._cqrepeat := dmZLogGlobal.Settings.CW._cqrepeat + 1.0;
   ApplyCQRepeatInterval();
end;

// #122 CQ間隔DOWN
procedure TMainForm.actionCQRepeatIntervalDownExecute(Sender: TObject);
begin
   dmZLogGlobal.Settings.CW._cqrepeat := dmZLogGlobal.Settings.CW._cqrepeat - 1.0;
   ApplyCQRepeatInterval();
end;

// #123,#124,#125 CQメッセージ1～3の選択
procedure TMainForm.actionSetCQMessageExecute(Sender: TObject);
var
   msg: string;
begin
   FCurrentCQMessageNo := TAction(Sender).Tag;
   msg := 'Set CQ Message to ' + IntToStr(FCurrentCQMessageNo - 100);
   WriteStatusLine(msg, False);
end;

// #126 Toggle RIT
procedure TMainForm.actionToggleRitExecute(Sender: TObject);
begin
   if RigControl.Rig = nil then begin
      Exit;
   end;

   RigControl.Rig.Rit := not RigControl.Rig.Rit;
   ShowToggleStatus('RIT', RigControl.Rig.Rit);
end;

// #127 Toggle XIT
procedure TMainForm.actionToggleXitExecute(Sender: TObject);
begin
   if RigControl.Rig = nil then begin
      Exit;
   end;

   RigControl.Rig.Xit := not RigControl.Rig.Xit;
   ShowToggleStatus('XIT', RigControl.Rig.Xit);
end;

// #128 RIT Clear
procedure TMainForm.actionRitClearExecute(Sender: TObject);
begin
   RigControl.SetRitOffset(0);
   WriteStatusLine('RIT/XIT Offset Cleared', False);
end;

// #129 Magical Calling機能のON/OFF
procedure TMainForm.actionToggleAntiZeroinExecute(Sender: TObject);
begin
   dmZLogGlobal.Settings.FUseAntiZeroin := not dmZLogGlobal.Settings.FUseAntiZeroin;
   ShowToggleStatus('Magical Calling', dmZLogGlobal.Settings.FUseAntiZeroin);
end;

// #130 AntiZeroin
procedure TMainForm.actionAntiZeroinExecute(Sender: TObject);
var
   offset: Integer;
   randmax: Integer;
begin
   if CurrentQSO.Mode <> mCW then begin
      Exit;
   end;
   if dmZLogGlobal.Settings.FUseAntiZeroin = False then begin
      Exit;
   end;
   if CurrentQSO.CQ = True then begin
      Exit;
   end;

   Randomize();

   // 振れ幅
   randmax := (dmZLogGlobal.Settings.FAntiZeroinShiftMax div 10) + 1;
   offset := Random(randmax) * 10;    // 200Hz未満で

   // ＋か－か
   if Random(2) = 1 then begin
      offset := offset * -1;
   end;

   RigControl.Rig.Rit := False;
   RigControl.Rig.Xit := True;
   RigControl.Rig.RitOffset := offset;

   WriteStatusLine('** Anti Zeroin **', False);
end;

// #131 Function Key Panel
procedure TMainForm.actionFunctionKeyPanelExecute(Sender: TObject);
begin
   FFunctionKeyPanel.Show();
   LastFocus.SetFocus();
end;

// #132 Rate Dialog Ex
procedure TMainForm.actionShowQsoRateExExecute(Sender: TObject);
begin
   FRateDialogEx.Show();
end;

// #133 QSY Infomation
procedure TMainForm.actionShowQsyInfoExecute(Sender: TObject);
begin
   FQsyInfoForm.Show();
end;

// #134 SO2R Neo Control Panel
procedure TMainForm.actionShowSo2rNeoCpExecute(Sender: TObject);
begin
   FSo2rNeoCp.Show();
end;

// #135-137 SO2R Neo Select RX N
procedure TMainForm.actionSo2rNeoSelRxExecute(Sender: TObject);
var
   tx: Integer;
   rx: Integer;
begin
   rx := TAction(Sender).Tag;
   tx := GetCurrentRigID();
   dmZLogKeyer.So2rNeoSwitchRig(tx, rx);
end;

// #138-140 Select Rig N
procedure TMainForm.actionSelectRigExecute(Sender: TObject);
var
   rig: Integer;
begin
   rig := TAction(Sender).Tag;
   if RigControl.SetCurrentRig(rig) = True then begin
      SwitchRig(rig);
   end;
end;

// #141 SO2R Neo Cancel auto RX select
procedure TMainForm.actionSo2rNeoCanRxSelExecute(Sender: TObject);
var
   fCancel: Boolean;
begin
   fCancel := not dmZLogKeyer.So2rNeoCanRxSel;
   dmZLogKeyer.So2rNeoCanRxSel := fCancel;
   FSo2rNeoCp.CanRxSel := fCancel;
end;

// #142 Information Window
procedure TMainForm.actionShowInformationExecute(Sender: TObject);
begin
   FInformation.Show();
end;

// #143 Toggle Auto RIG switch
procedure TMainForm.actionToggleAutoRigSwitchExecute(Sender: TObject);
begin
   FInformation.AutoRigSwitch := not FInformation.AutoRigSwitch;
end;

procedure TMainForm.RestoreWindowsPos();
var
   X, Y, W, H: Integer;
   B, BB: Boolean;
   mon: TMonitor;
   pt: TPoint;
begin
   dmZlogGlobal.ReadMainFormState(X, Y, W, H, B, BB);

   if (W > 0) and (H > 0) then begin
      pt.X := X;
      pt.Y := Y;
      mon := Screen.MonitorFromPoint(pt, mdNearest);
      if X < mon.Left then begin
         X := mon.Left;
      end;
      if X > (mon.Left + mon.Width) then begin
         X := (mon.Left + mon.Width) - W;
      end;
      if Y < mon.Top then begin
         Y := mon.Top;
      end;
      if Y > (mon.Top + mon.Height) then begin
         Y := (mon.Top + mon.Height) - H;
      end;

      if B then begin
         mnHideCWPhToolBar.Checked := True;
         CWToolBar.Height := 1;
         SSBToolBar.Height := 1;
      end;

      if BB then begin
         mnHideMenuToolbar.Checked := True;
         MainToolBar.Height := 1;
      end;
      Position := poDesigned;
      Left := X;
      top := Y;
      Width := W;
      Height := H;
   end
   else begin
      Position := poScreenCenter;
   end;
end;

procedure TMainForm.WriteKeymap();
var
   i: Integer;
   ini: TIniFile;
begin
   ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'zlog_key.ini');
   try
      for i := 0 to ActionList1.ActionCount - 1 do begin
         ini.WriteString('shortcut', IntToStr(i), ShortcutToText(ActionList1.Actions[i].ShortCut));
         ini.WriteString('secondary', IntToStr(i), ActionList1.Actions[i].SecondaryShortCuts.CommaText);
      end;
   finally
      ini.Free();
   end;
end;

procedure TMainForm.ReadKeymap();
var
   i: Integer;
   ini: TIniFile;
   filename: string;
   shortcut: TShortcut;

   procedure ClearShortcut();
   var
      i: Integer;
   begin
      for i := 0 to ActionList1.ActionCount - 1 do begin
         ActionList1.Actions[i].ShortCut := 0;
      end;
   end;

   function IsShortcutUsed(shortcut: TShortcut): Boolean;
   var
      i: Integer;
   begin
      if shortcut = 0 then begin
         Result := False;
         Exit;
      end;

      for i := 0 to ActionList1.ActionCount - 1 do begin
         if ActionList1.Actions[i].ShortCut = shortcut then begin
            Result := True;
            Exit;
         end;
      end;

      Result := False;
   end;
begin
   filename := ExtractFilePath(Application.ExeName) + 'zlog_key.ini';
   if FileExists(filename) = False then begin
      ResetKeymap();
      Exit;
   end;

   ini := TIniFile.Create(filename);
   try
      // 一旦全部クリア
      ClearShortcut();

      for i := 0 to ActionList1.ActionCount - 1 do begin
         // shortcut設定読み込み
         shortcut := TextToShortcut(ini.ReadString('shortcut', IntToStr(i), default_primary_shortcut[i]));

         // そのshortcutは使用済みなら次
         if IsShortcutUsed(shortcut) = True then begin
            Continue;
         end;

         // 未使用なら設定
         ActionList1.Actions[i].ShortCut := shortcut;
         ActionList1.Actions[i].Hint := ini.ReadString('text', IntToStr(i), '');
         ActionList1.Actions[i].SecondaryShortCuts.CommaText := ini.ReadString('secondary', IntToStr(i), default_secondary_shortcut[i]);
      end;
   finally
      ini.Free();
   end;
end;

procedure TMainForm.ResetKeymap();
var
   i: Integer;
begin
   for i := 0 to ActionList1.ActionCount - 1 do begin
      ActionList1.Actions[i].ShortCut := TextToShortcut(default_primary_shortcut[i]);
      ActionList1.Actions[i].SecondaryShortCuts.CommaText := default_secondary_shortcut[i];
   end;
end;

procedure TMainForm.SetShortcutEnabled(shortcut: string; fEnabled: Boolean);
var
   i: Integer;
   sc: Word;
begin
   sc := TextToShortcut(shortcut);
   for i := 0 to ActionList1.ActionCount - 1 do begin
      if ActionList1.Actions[i].ShortCut = sc then begin
         ActionList1.Actions[i].Enabled := fEnabled;
      end;
   end;
end;

procedure TMainForm.SuperCheckDataLoad();
begin
   TerminateSuperCheckDataLoad();

   FSpcDataLoading := True;
   FSuperCheck.ListBox.Clear();
   FSuperCheck.ListBox.Items.Add(SPC_LOADING_TEXT);
   FSuperCheck2.ListBox.Clear();
   FSuperCheck2.ListBox.Items.Add(SPC_LOADING_TEXT);

   SuperCheckInitData();

   FSuperCheckDataLoadThread := TSuperCheckDataLoadThread.Create(FSuperCheckList, @FTwoLetterMatrix);
end;

procedure TMainForm.SuperCheckInitData();
var
   i: Integer;
   j: Integer;
begin
   SuperCheckFreeData();

   FSuperCheckList := TSuperList.Create(True);

   for i := 0 to 255 do begin // 2.1f
      for j := 0 to 255 do begin
         FTwoLetterMatrix[i, j] := TSuperList.Create(True);
      end;
   end;
end;

procedure TMainForm.SuperCheckFreeData();
var
   i: Integer;
   j: Integer;
begin
   if Assigned(FSuperCheckList) then begin
      FreeAndNil(FSuperCheckList);
   end;

   for i := 0 to 255 do begin // 2.1f
      for j := 0 to 255 do begin
         if Assigned(FTwoLetterMatrix[i, j]) then begin
            FreeAndNil(FTwoLetterMatrix[i, j]);
         end;
      end;
   end;
end;

// Super Check検索の実行
procedure TMainForm.CheckSuper(aQSO: TQSO);
var
   PartialStr: string;
   i: integer;
   maxhit, hit: integer;
   sd, FirstData: TSuperData;
   L: TSuperList;
begin
   if FSpcDataLoading = True then begin
      Exit;
   end;

   FSpcHitNumber := 0;
   FSpcHitCall := '';
   FSuperCheck.Clear();
   PartialStr := aQSO.callsign;
   FirstData := nil;

   // 検索対象がserchafter以下 searchafterは0,1,2
   if dmZlogGlobal.Settings._searchafter >= Length(PartialStr) then begin
      Exit;
   end;

   // ,で始まるコマンド
   if Pos(',', PartialStr) = 1 then begin
      Exit;
   end;

   // Max super check search デフォルトは1
   maxhit := dmZlogGlobal.Settings._maxsuperhit;

   // ポータブル除く
   PartialStr := CoreCall(PartialStr);

   // 検索対象無し
   if PartialStr = '' then begin
      Exit;
   end;

   hit := 0;

   if (Length(PartialStr) >= 2) and (Pos('.', PartialStr) = 0) then begin
      L := FTwoLetterMatrix[Ord(PartialStr[1]), Ord(PartialStr[2])];
   end
   else begin
      L := FSuperCheckList;
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('[' + PartialStr + '] L=' + IntToStr(L.Count)));
   {$ENDIF}

   for i := 0 to L.Count - 1 do begin
      sd := TSuperData(L[i]);
      if FSuperCheck.Count = 0 then begin
         FirstData := sd;
      end;

      if PartialMatch(PartialStr, sd.callsign) then begin
         if hit = 0 then begin
            FSpcHitCall := sd.callsign;
         end;

         FSuperCheck.Add(sd.Text);

         inc(hit);
      end;

      if hit >= maxhit then begin
         break;
      end;
   end;

   FSpcHitNumber := hit;

   FSpcFirstDataCall := '';
   FSpcRcvd_Estimate := '';

   if FSpcHitNumber > 0 then begin
      FSpcFirstDataCall := FirstData.callsign;
      FSpcRcvd_Estimate := FirstData.number;
   end;

   FSuperChecked := True;
end;

// N+1検索の実行
procedure TMainForm.CheckSuper2(aQSO: TQSO);
var
   PartialStr: string;
begin
   if FSpcDataLoading = True then begin
      Exit;
   end;

   HighlightCallsign(False);

   PartialStr := aQSO.callsign;

   // ,で始まるコマンド
   if Pos(',', PartialStr) = 1 then begin
      Exit;
   end;

   // 先行スレッドいれば終了させる
   TerminateNPlusOne();
   FSuperCheck2.Clear();

   // ポータブル除く
   PartialStr := CoreCall(PartialStr);

   // 検索対象無し
   if PartialStr = '' then begin
      Exit;
   end;

   // N+1の実行
   if (Length(PartialStr) >= 3) then begin
      FNPlusOneThread := TSuperCheckNPlusOneThread.Create(FSuperCheckList, FSuperCheck2.ListBox, PartialStr);
   end;
end;

procedure TMainForm.TerminateNPlusOne();
begin
   // 先行スレッドいれば終了させる
   if Assigned(FNPlusOneThread) then begin
      FNPlusOneThread.Terminate();
      FNPlusOneThread.WaitFor();
      FNPlusOneThread.Free();
      FNPlusOneThread := nil;
   end;
end;

procedure TMainForm.TerminateSuperCheckDataLoad();
begin
   // 先行スレッドいれば終了させる
   if Assigned(FSuperCheckDataLoadThread) then begin
      FSuperCheckDataLoadThread.Terminate();
      FSuperCheckDataLoadThread.WaitFor();
      FSuperCheckDataLoadThread.Free();
      FSuperCheckDataLoadThread := nil;
   end;
end;

procedure TMainForm.OnSPCMenuItemCick(Sender: TObject);
begin
   CallsignEdit.Text := TMenuItem(Sender).Caption;
   CallSignEdit.SelStart := Length(CallsignEdit.Text);
end;

procedure TMainForm.HighlightCallsign(fHighlight: Boolean);
begin
   SetEditColor(CallsignEdit, fHighlight);
end;

procedure TMainForm.BandScopeNotifyWorked(aQSO: TQSO);
var
   b: TBand;
begin
   for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
      FBandScopeEx[b].NotifyWorked(aQSO);
   end;
   FBandScope.NotifyWorked(aQSO);
end;

procedure TMainForm.SetYourCallsign(strCallsign, strNumber: string);
begin
   CurrentQSO.CallSign := strCallsign;
   CallsignEdit.Text := strCallsign;
   NumberEdit.Text := '';
   CallSignEdit.SelStart := Length(CallsignEdit.Text);
   if strCallsign = '' then begin
      CallsignEdit.SetFocus();
      Exit;
   end;

//   MyContest.SpaceBarProc;

   if NumberEdit.Text = '' then begin
      if strNumber <> '' then begin
         NumberEdit.Text := strNumber;
         NumberEdit.SelStart := Length(NumberEdit.Text);
      end
      else begin
         MyContest.SpaceBarProc;
      end;
   end;

   MyContest.MultiForm.SetNumberEditFocus;
end;

// Cluster or BandScopeから呼ばれる
procedure TMainForm.SetFrequency(freq: Integer);
var
   b: TBand;
   Q: TQSO;
begin
   if freq = 0 then begin
      Exit;
   end;

   FQsyFromBS := True;

   b := dmZLogGlobal.BandPlan.FreqToBand(freq);

   if RigControl.Rig <> nil then begin
      // RIGにfreq設定
      RigControl.Rig.SetFreq(freq, IsCQ());

      if dmZLogGlobal.Settings._bandscope_use_estimated_mode = True then begin
         Q := TQSO.Create();
         Q.Band := b;
         Q.Mode := dmZLogGlobal.BandPlan.GetEstimatedMode(freq);
         RigControl.Rig.SetMode(Q);
         Q.Free();
      end;

      RigControl.Rig.UpdateStatus();

      // Zeroin避け
      if dmZLogGlobal.Settings.FAntiZeroinXitOn1 = True then begin
         actionAntiZeroin.Execute();
      end;
   end
   else begin
      // バンド変更
      UpdateBand(b);
   end;

   // SPモードへ変更
   SetCQ(False);
end;

procedure TMainForm.BSRefresh();
var
   b: TBand;
begin
   for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
      if dmZLogGlobal.Settings._usebandscope[b] = False then begin
         Continue;
      end;

      FBandScopeEx[b].RewriteBandScope();
   end;
   FBandScope.RewriteBandScope();
end;

procedure TMainForm.BuildOpListMenu(P: TPopupMenu; OnClickHandler: TNotifyEvent);
var
   i: Integer;
   M: TMenuItem;
begin
   for i := P.Items.Count - 1 downto 0 do begin
      P.Items.Delete(i);
   end;

   if dmZlogGlobal.OpList.Count = 0 then begin
      Exit;
   end;

   M := TMenuItem.Create(Self);
   M.Caption := 'Clear';
   M.OnClick := OnClickHandler;
   P.Items.Add(m);

   for i := 0 to dmZlogGlobal.OpList.Count - 1 do begin
      M := TMenuItem.Create(Self);
      M.Caption := Trim(dmZlogGlobal.OpList[i].Callsign);
      M.OnClick := OnClickHandler;
      P.Items.Add(m);
   end;
end;

procedure TMainForm.BuildOpListMenu2(P: TMenuItem; OnClickHandler: TNotifyEvent);
var
   i: Integer;
   M: TMenuItem;
begin
   for i := P.Count - 1 downto 0 do begin
      P.Delete(i);
   end;

   if dmZlogGlobal.OpList.Count = 0 then begin
      Exit;
   end;

   M := TMenuItem.Create(Self);
   M.Caption := 'Clear';
   M.OnClick := OnClickHandler;
   P.Add(m);

   for i := 0 to dmZlogGlobal.OpList.Count - 1 do begin
      M := TMenuItem.Create(Self);
      M.Caption := Trim(dmZlogGlobal.OpList[i].Callsign);
      M.OnClick := OnClickHandler;
      P.Add(m);
   end;
end;

procedure TMainForm.BuildTxNrMenu2(P: TMenuItem; OnClickHandler: TNotifyEvent);
var
   i: Integer;
   M: TMenuItem;
   L: TStringList;
begin
   L := TStringList.Create();
   try
      for i := P.Count - 1 downto 0 do begin
         P.Delete(i);
      end;

      case dmZlogGlobal.ContestCategory of
         ccSingleOp: begin
            P.Visible := False;
            Exit;
         end;

         ccMultiOpMultiTx: begin
            P.Visible := True;
            L.CommaText := TXLIST_MM;
         end;

         ccMultiOpSingleTx, ccMultiOpTwoTx: begin
            P.Visible := True;
            L.CommaText := TXLIST_MS;
         end;
      end;

      for i := 0 to L.Count - 1 do begin
         M := TMenuItem.Create(Self);
         M.Caption := Trim(L[i]);
         M.OnClick := OnClickHandler;
         P.Add(m);
      end;
   finally
      L.Free();
   end;
end;

procedure TMainForm.BandScopeAddSelfSpot(aQSO: TQSO; nFreq: Int64);
begin
   FBandScopeEx[aQSO.Band].AddSelfSpot(aQSO, nFreq);
   FBandScope.AddSelfSpot(aQSO, nFreq);
end;

procedure TMainForm.BandScopeAddSelfSpotFromNetwork(BSText: string);
var
   b: TBand;
begin
   for b := b19 to b50 do begin
      FBandScopeEx[b].AddSelfSpotFromNetwork(BSText);
   end;
   FBandScope.AddSelfSpotFromNetwork(BSText);
end;

procedure TMainForm.BandScopeAddClusterSpot(Sp: TSpot);
begin
   FBandScopeEx[Sp.Band].AddClusterSpot(Sp);
   FBandScope.AddClusterSpot(Sp);
end;

procedure TMainForm.BandScopeMarkCurrentFreq(B: TBand; Hz: Integer);
begin
   FBandScopeEx[B].MarkCurrentFreq(Hz);
   FBandScope.MarkCurrentFreq(Hz);
end;

procedure TMainForm.BandScopeUpdateSpot(aQSO: TQSO);
begin
   FBandScopeEx[aQSO.Band].SetSpotWorked(aQSO);

   if FBandScope.CurrentBand = aQSO.Band then begin
      FBandScope.SetSpotWorked(aQSO);
   end;
end;

procedure TMainForm.InitBandMenu();
var
   b: TBand;
begin
   for b := b19 to HiBand do begin
      BandMenu.Items[ord(b)].Enabled := ({BandMenu.Items[ord(b)].Enabled and} dmZLogGlobal.Settings._activebands[b]);
   end;
end;

procedure TMainForm.DoCwSpeedChange(Sender: TObject);
var
   i: Integer;
begin
   i := dmZLogKeyer.WPM;
   dmZLogGlobal.Settings.CW._speed := i;
   SpeedBar.Position := i;
   SpeedLabel.Caption := IntToStr(i) + ' wpm';
   FInformation.WPM := i;
end;

procedure TMainForm.DoVFOChange(Sender: TObject);
begin
   if FInitialized = False then begin
      Exit;
   end;

   // AntiZeroin利用時
   if (dmZLogGlobal.Settings.FUseAntiZeroin = True) and (FQsyFromBS = False) then begin
      // XIT OFF
      RigControl.SetXit(False);
   end;

   SetCQ(False);

   FQsyFromBS := False;
end;

procedure TMainForm.SetStatusLine(strText: string);
begin
   StatusLine.Panels[1].Text := strText;
   FInformation.RigInfo := strText;
end;

procedure TMainForm.ApplyCQRepeatInterval();
var
   msg: string;
begin
   dmZLogGlobal.Settings.CW._cqrepeat := Max(Min(dmZLogGlobal.Settings.CW._cqrepeat, 60), 0);
   dmZLogKeyer.CQRepeatIntervalSec := dmZLogGlobal.Settings.CW._cqrepeat;

   msg := 'CQ Repeat Int. ' + Format('%.1f', [dmZLogGlobal.Settings.CW._cqrepeat]) + ' sec.';
   WriteStatusLine(msg, False);
end;

procedure TMainForm.ShowToggleStatus(text: string; fON: Boolean);
const
   strOffOn: array[False..True] of string = ('OFF', 'ON');
var
   msg: string;
begin
   msg := 'Set ' + text + ' to ' + strOffOn[fOn];
   WriteStatusLine(msg, False);
end;

procedure TMainForm.DoFunctionKey(no: Integer);
var
   i: Integer;
   act: TAction;
   shortcut: Word;
begin
   shortcut := TextToShortCut('F1') + (no - 1);
   for i := 0 to ActionList1.ActionCount - 1 do begin
      act := TAction(ActionList1.Actions[i]);
      if act.ShortCut = shortcut then begin
         {$IFDEF DEBUG}
         OutputDebugString(PChar('Action=[' + act.Name + ']'));
         {$ENDIF}
//       act.Execute();
         act.OnExecute(act);
         Exit;
      end;
   end;
end;

procedure TMainForm.SetListWidth();
var
   i: Integer;
begin
   i := ClientWidth - Grid.GridWidth;
   if i <> 0 then begin
      Grid.ColWidths[Grid.ColCount - 1] := Grid.ColWidths[Grid.ColCount - 1] + i;
   end;

   if EditScreen <> nil then begin
      SetEditFields1R(EditScreen);
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('FormResize():VisibleRowCount=' + IntToStr(MainForm.Grid.VisibleRowCount)));
   {$ENDIF}
end;

procedure TMainForm.SelectOperator(O: string);
var
   op: TOperatorInfo;
begin
   if O = 'Clear' then begin
      O := '';
      op := nil;
   end
   else begin
      op := dmZlogGlobal.OpList.ObjectOf(O);
   end;

   OpEdit.Text := O;
   CurrentQSO.Operator := O;

   LastFocus.SetFocus;
   dmZlogGlobal.SetOpPower(CurrentQSO);
   PowerEdit.Text := CurrentQSO.NewPowerStr;
   FZLinkForm.SendOperator;

   // Change Voice Files
   FVoiceForm.SetOperator(op);
end;

procedure TMainForm.SetEditColor(edit: TEdit; fHighlight: Boolean);
begin
   with edit do begin
      if (dmZlogGlobal.Settings.FSuperCheck.FFullMatchHighlight = True) and
         (fHighlight = True) then begin
         Color := dmZlogGlobal.Settings.FSuperCheck.FFullMatchColor;
      end
      else begin
         Color := dmZLogGlobal.Settings.FAccessibility.FFocusedBackColor;
      end;

      Font.Color := dmZLogGlobal.Settings.FAccessibility.FFocusedForeColor;
      if dmZLogGlobal.Settings.FAccessibility.FFocusedBold = True then begin
         Font.Style := Font.Style + [fsBold];
      end
      else begin
         Font.Style := Font.Style - [fsBold];
      end;
   end;
end;

function TMainForm.GetCurrentRigID(): Integer;
var
   n: Integer;
begin
   n := RigControl.GetCurrentRig;
   if ((n = 1) or (n = 2) or (n = 3)) then begin
      Result := n - 1;
   end
   else begin
      Result := 0;
   end;
end;

function TMainForm.GetCurrentEditPanel(): TEditPanel;
begin
   Result := FEditPanel[CurrentRigID];
end;

function TMainForm.GetSerialEdit(): TEdit;      // 0
begin
   Result := FEditPanel[CurrentRigID].SerialEdit;
end;

function TMainForm.GetDateEdit(): TEdit;        // 1
begin
   Result := FEditPanel[CurrentRigID].DateEdit;
end;

function TMainForm.GetTimeEdit(): TEdit;        // 1
begin
   Result := FEditPanel[CurrentRigID].TimeEdit;
end;

function TMainForm.GetCallsignEdit(): TEdit;    // 2
begin
   Result := FEditPanel[CurrentRigID].CallsignEdit;
end;

function TMainForm.GetRSTEdit(): TEdit;         // 3
begin
   Result := FEditPanel[CurrentRigID].rcvdRSTEdit;
end;

function TMainForm.GetNumberEdit(): TEdit;      // 4
begin
   Result := FEditPanel[CurrentRigID].rcvdNumber;
end;

function TMainForm.GetModeEdit(): TEdit;        // 5
begin
   Result := FEditPanel[CurrentRigID].ModeEdit;
end;

function TMainForm.GetPowerEdit(): TEdit;       // 6
begin
   Result := FEditPanel[CurrentRigID].PowerEdit;
end;

function TMainForm.GetBandEdit(): TEdit;        // 7
begin
   Result := FEditPanel[CurrentRigID].BandEdit;
end;

function TMainForm.GetPointEdit(): TEdit;       // 8
begin
   Result := FEditPanel[CurrentRigID].PointEdit;
end;

function TMainForm.GetOpEdit(): TEdit;          // 9
begin
   Result := FEditPanel[CurrentRigID].OpEdit;
end;

function TMainForm.GetMemoEdit(): TEdit;        // 10
begin
   Result := FEditPanel[CurrentRigID].MemoEdit;
end;

function TMainForm.GetNewMulti1Edit(): TEdit;   // 11
begin
   Result := FEditPanel[CurrentRigID].NewMulti1Edit;
end;

function TMainForm.GetNewMulti2Edit(): TEdit;   // 12
begin
   Result := FEditPanel[CurrentRigID].NewMulti2Edit;
end;

procedure TMainForm.InitQsoEditPanel();
begin
   Grid.Align := alNone;

   if dmZLogGlobal.Settings._so2r_type = so2rNone then begin
      // 1R
      FEditPanel[0].SerialEdit   := SerialEdit1;
      FEditPanel[0].DateEdit     := DateEdit1;
      FEditPanel[0].TimeEdit     := TimeEdit1;
      FEditPanel[0].CallsignEdit := CallsignEdit1;
      FEditPanel[0].rcvdRSTEdit  := rcvdRSTEdit1;
      FEditPanel[0].rcvdNumber   := NumberEdit1;
      FEditPanel[0].ModeEdit     := ModeEdit1;
      FEditPanel[0].PowerEdit    := PowerEdit1;
      FEditPanel[0].BandEdit     := BandEdit1;
      FEditPanel[0].PointEdit    := PointEdit1;
      FEditPanel[0].OpEdit       := OpEdit1;
      FEditPanel[0].MemoEdit     := MemoEdit1;

      FEditPanel[1].SerialEdit   := SerialEdit1;
      FEditPanel[1].DateEdit     := DateEdit1;
      FEditPanel[1].TimeEdit     := TimeEdit1;
      FEditPanel[1].CallsignEdit := CallsignEdit1;
      FEditPanel[1].rcvdRSTEdit  := rcvdRSTEdit1;
      FEditPanel[1].rcvdNumber   := NumberEdit1;
      FEditPanel[1].ModeEdit     := ModeEdit1;
      FEditPanel[1].PowerEdit    := PowerEdit1;
      FEditPanel[1].BandEdit     := BandEdit1;
      FEditPanel[1].PointEdit    := PointEdit1;
      FEditPanel[1].OpEdit       := OpEdit1;
      FEditPanel[1].MemoEdit     := MemoEdit1;

      EditPanel1R.Visible := True;
      EditPanel2R.Visible := False;
   end
   else begin  // 2R
      FEditPanel[0].SerialEdit   := SerialEdit2A;
      FEditPanel[0].DateEdit     := DateEdit2;
      FEditPanel[0].TimeEdit     := TimeEdit2;
      FEditPanel[0].CallsignEdit := CallsignEdit2A;
      FEditPanel[0].rcvdRSTEdit  := rcvdRSTEdit2A;
      FEditPanel[0].rcvdNumber   := NumberEdit2A;
      FEditPanel[0].ModeEdit     := ModeEdit2A;
      FEditPanel[0].PowerEdit    := nil;
      FEditPanel[0].BandEdit     := BandEdit2A;
      FEditPanel[0].PointEdit    := nil;
      FEditPanel[0].OpEdit       := nil;
      FEditPanel[0].MemoEdit     := nil;

      FEditPanel[1].SerialEdit   := SerialEdit2B;
      FEditPanel[1].DateEdit     := DateEdit2;
      FEditPanel[1].TimeEdit     := TimeEdit2;
      FEditPanel[1].CallsignEdit := CallsignEdit2B;
      FEditPanel[1].rcvdRSTEdit  := rcvdRSTEdit2B;
      FEditPanel[1].rcvdNumber   := NumberEdit2B;
      FEditPanel[1].ModeEdit     := ModeEdit2B;
      FEditPanel[1].PowerEdit    := nil;
      FEditPanel[1].BandEdit     := BandEdit2B;
      FEditPanel[1].PointEdit    := nil;
      FEditPanel[1].OpEdit       := nil;
      FEditPanel[1].MemoEdit     := nil;

      FEditPanel[2].SerialEdit   := SerialEdit2C;
      FEditPanel[2].DateEdit     := DateEdit2;
      FEditPanel[2].TimeEdit     := TimeEdit2;
      FEditPanel[2].CallsignEdit := CallsignEdit2C;
      FEditPanel[2].rcvdRSTEdit  := rcvdRSTEdit2C;
      FEditPanel[2].rcvdNumber   := NumberEdit2C;
      FEditPanel[2].ModeEdit     := ModeEdit2C;
      FEditPanel[2].PowerEdit    := nil;
      FEditPanel[2].BandEdit     := BandEdit2C;
      FEditPanel[2].PointEdit    := nil;
      FEditPanel[2].OpEdit       := nil;
      FEditPanel[2].MemoEdit     := nil;

      EditPanel1R.Visible := False;
      EditPanel2R.Visible := True;
   end;
   Grid.Align := alClient;
end;

procedure TMainForm.UpdateQsoEditPanel(rig: Integer);

   procedure SetWhite(id: Integer);
   begin
//      FEditPanel[id].SerialEdit.Color := clWindow;
//      FEditPanel[id].DateEdit.Color := clWindow;
//      FEditPanel[id].TimeEdit.Color := clWindow;
      FEditPanel[id].CallsignEdit.Color := clWindow;
      FEditPanel[id].rcvdRSTEdit.Color := clWindow;
      FEditPanel[id].rcvdNumber.Color := clWindow;
      FEditPanel[id].ModeEdit.Color := clWindow;
      FEditPanel[id].BandEdit.Color := clWindow;
      FEditPanel[id].ModeEdit.Enabled := True;
      FEditPanel[id].BandEdit.Enabled := True;
   end;

   procedure SetGlay(id: Integer);
   begin
//      FEditPanel[id].SerialEdit.Color := clBtnFace;
//      FEditPanel[id].DateEdit.Color := clBtnFace;
//      FEditPanel[id].TimeEdit.Color := clBtnFace;
      FEditPanel[id].CallsignEdit.Color := clBtnFace;
      FEditPanel[id].rcvdRSTEdit.Color := clBtnFace;
      FEditPanel[id].rcvdNumber.Color := clBtnFace;
      FEditPanel[id].ModeEdit.Color := clBtnFace;
      FEditPanel[id].BandEdit.Color := clBtnFace;
      FEditPanel[id].ModeEdit.Enabled := False;
      FEditPanel[id].BandEdit.Enabled := False;
   end;
begin
   FCurrentRig := rig;
   if dmZLogGlobal.Settings._so2r_type = so2rNone then begin
      Exit;
   end
   else begin
      if rig = 1 then begin
         RigPanelShape2A.Pen.Color := clBlue;
         RigPanelShape2B.Pen.Color := clBlack;
         RigPanelShape2C.Pen.Color := clBlack;
         SetWhite(0);
         SetGlay(1);
         SetGlay(2);
      end
      else if rig = 2 then begin
         RigPanelShape2A.Pen.Color := clBlack;
         RigPanelShape2B.Pen.Color := clBlue;
         RigPanelShape2C.Pen.Color := clBlack;
         SetGlay(0);
         SetWhite(1);
         SetGlay(2);
      end
      else begin
         RigPanelShape2A.Pen.Color := clBlack;
         RigPanelShape2B.Pen.Color := clBlack;
         RigPanelShape2C.Pen.Color := clBlue;
         SetGlay(0);
         SetGlay(1);
         SetWhite(2);
      end;
      if Assigned(RigControl) then begin
         if Assigned(RigControl.Rigs[rig]) then begin
            UpdateBand(RigControl.Rigs[rig].CurrentBand);
            UpdateMode(RigControl.Rigs[rig].CurrentMode);
         end;
      end;
   end;
end;

procedure TMainForm.SwitchRig(rig: Integer);
begin
   if dmZLogGlobal.Settings._so2r_type <> so2rNone then begin
      UpdateQsoEditPanel(rig);
      if LastFocus = FEditPanel[rig - 1].rcvdNumber then begin
         EditEnter(FEditPanel[rig - 1].rcvdNumber);
      end
      else begin
         FEditPanel[rig - 1].CallsignEdit.SetFocus();
         EditEnter(FEditPanel[rig - 1].CallsignEdit);
      end;
      FSo2rNeoCp.Rx := rig - 1;
   end;
end;

procedure TMainForm.ShowCurrentQSO();
begin
//   SerialEdit.Text := CurrentQSO.SerialStr;
   TimeEdit.Text := CurrentQSO.TimeStr;
   DateEdit.Text := CurrentQSO.DateStr;
   CallsignEdit.Text := CurrentQSO.Callsign;
   RcvdRSTEdit.Text := CurrentQSO.RSTStr;
   NumberEdit.Text := CurrentQSO.NrRcvd;
   ModeEdit.Text := CurrentQSO.ModeStr;
   BandEdit.Text := CurrentQSO.BandStr;
   PowerEdit.Text := CurrentQSO.NewPowerStr;
   PointEdit.Text := CurrentQSO.PointStr;
   OpEdit.Text := CurrentQSO.Operator;
   { CallsignEdit.SetFocus; }
end;

procedure TMainForm.DoMessageSendFinish(Sender: TObject);
var
   tx: Integer;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** DoMessageSendFinish ***'));
   {$ENDIF}
   tx := GetCurrentRigID();
   dmZLogKeyer.ControlPTT(tx, False);

   if dmZLogGlobal.Settings._so2r_type = so2rNeo then begin
      dmZLogKeyer.So2rNeoNormalRx(tx);
      FSo2rNeoCp.CanRxSel := False;
   end;
end;

procedure TMainForm.DoWkAbortProc(Sender: TObject);
var
   tx: Integer;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** DoWkAbortProc ***'));
   {$ENDIF}
   tx := GetCurrentRigID();
   dmZLogKeyer.ControlPTT(tx, False);

   if dmZLogGlobal.Settings._so2r_type = so2rNeo then begin
      dmZLogKeyer.So2rNeoNormalRx(tx);
      FSo2rNeoCp.CanRxSel := False;
   end;
end;

procedure TMainForm.DoWkStatusProc(Sender: TObject; tx: Integer; rx: Integer; ptt: Boolean);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** DoWkStatusProc(' + IntToStr(tx) + ', ' + IntToStr(rx) + ', ' + BoolToStr(ptt) + ') ***'));
   {$ENDIF}
   FSo2rNeoCp.Rx := rx;
   FSo2rNeoCp.Ptt := ptt;
   FInformation.Ptt := ptt;
end;

procedure TMainForm.DoSendRepeatProc(Sender: TObject; nLoopCount: Integer);
var
   rig: Integer;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** DoSendRepeatProc ***'));
   {$ENDIF}

   rig := RigControl.GetCurrentRig();

   if FInformation.AutoRigSwitch = True then begin
      if rig = 1 then begin
         rig := 2;
      end
      else begin
         rig := 1;
      end;
   end;

   RigControl.SetCurrentRig(rig);
   SwitchRig(rig);
end;

end.
