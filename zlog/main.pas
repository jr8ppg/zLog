unit Main;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, Grids,
  ShlObj, ComObj,
  UzLogGlobal, UBasicMulti, UBasicScore, UALLJAMulti,
  UOptions, UEditDialog, UGeneralMulti2,
  UzLogCW, Hemibtn, ShellAPI, UITypes, UzLogKeyer,
  OEdit, URigControl, UConsolePad, URenewThread, USpotClass,
  UMMTTY, UTTYConsole, UELogJarl1, UELogJarl2, UQuickRef,
  UWWMulti, UWWScore, UWWZone, UARRLWMulti, UQTCForm, System.Actions,
  Vcl.ActnList;


const
  WM_ZLOG_INIT = (WM_USER + 100);
  WM_ZLOG_SETGRIDCOL = (WM_USER + 101);

const
  MaxGridQSO = 3000;

var
  GLOBALSERIAL : integer = 0;
  ZLOCOUNT : integer = 0;

type
  TBasicEdit = class
  private
    colSerial : integer;
    colTime : integer;
    colCall : integer;
    colrcvdRST : integer;
    colrcvdNumber : integer;
    colMode : integer;
    colPower : integer;
    colNewPower : integer;
    colBand : integer;
    colPoint : integer;
    colMemo : integer;
    colOp : integer;
    colNewMulti1 : integer;
    colNewMulti2 : integer;
    colsentRST : integer;
    colsentNumber : integer;
    colCQ : integer;
    DispQSO : integer;
    function GetLeft(col : integer) : integer;
    Procedure WriteQSO(R: integer; aQSO : TQSO);
  public
    IndexArray : array[1..MaxGridQSO] of word; {contains the index to Log}
    SerialWid : integer;
    TimeWid : integer;
    CallSignWid : integer;
    rcvdRSTWid : integer;
    NumberWid : integer;
    BandWid : integer;
    ModeWid : integer;
    NewPowerWid : integer;
    PointWid : integer;
    OpWid : integer;
    MemoWid : integer;
    NewMulti1Wid : integer;
    NewMulti2Wid : integer;

    DirectEdit : boolean;
    BeforeEdit : string; // temp var for directedit mode

    constructor Create(AOwner: TComponent); virtual;
    procedure SetDirectEdit(Direct : boolean);
    procedure Add(aQSO : TQSO); virtual;
    procedure ResetTopRow;
    procedure Renew; virtual;
    procedure SetGridWidth;
    procedure SetEditFields;
    function GetNewMulti1(aQSO : TQSO) : string; virtual;
    procedure RefreshScreen;
  end;

  TGeneralEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TALLJAEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TIARUEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TARRLDXEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TACAGEdit = class(TALLJAEdit)
  private
  public
    // constructor Create; override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TWWEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TKCJEdit = class(TWWEdit)
  private
  public
    //constructor Create; override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TDXCCEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TWPXEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TJA0Edit = class(TWPXEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TSerialGeneralEdit = class(TWPXEdit)
  private
  public
    formMulti: TGeneralMulti2;
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TIOTAEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TWanted = class
    Multi : string;
    Bands : set of TBand;
    constructor Create;
  end;

  TContest = class
    WantedList : TList;

    MultiForm: TBasicMulti;
    ScoreForm: TBasicScore;
    PastEditForm: TEditDialog;
    ZoneForm: TWWZone;

    Name : string;
    SameExchange : boolean; // true by default. false when serial number etc
    MultiFound : boolean; // used in spacebarproc

    constructor Create(N : string); virtual;
    destructor Destroy; override;
    procedure PostWanted(S : string);
    procedure DelWanted(S : string);
    procedure ClearWanted;
    function QTHString : string; virtual;
    procedure LogQSO(var aQSO : TQSO; Local : boolean); virtual;
    procedure ShowScore; virtual;
    procedure ShowMulti; virtual;
    procedure Renew; virtual;
    {procedure LoadFromFile(FileName : string); virtual; }
    procedure EditCurrentRow; virtual;
    procedure ChangeBand(Up : boolean); virtual;
    procedure ChangeMode; virtual;
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
  end;

  TPedi = class(TContest)
    constructor Create(N : string); override;
  end;

  TALLJAContest = class(TContest)
    constructor Create(N : string); override;
    function QTHString : string; override;
    procedure DispExchangeOnOtherBands; override;
    function CheckWinSummary(aQSO : TQSO) : string; override;
  end;

  TKCJContest = class(TContest)
    constructor Create(N : string); override;
    function QTHString : string; override;
    //procedure DispExchangeOnOtherBands; override;
    function CheckWinSummary(aQSO : TQSO) : string; override;
  end;

  TACAGContest = class(TContest)
    constructor Create(N : string); override;
    procedure DispExchangeOnOtherBands; override;
  end;

  TFDContest = class(TContest)
    constructor Create(N : string); override;
    function QTHString : string; override;
    procedure DispExchangeOnOtherBands; override;
  end;

  TSixDownContest = class(TContest)
    constructor Create(N : string); override;
    function QTHString : string; override;
    procedure DispExchangeOnOtherBands; override;
  end;

  TGeneralContest = class(TContest)
    constructor Create(N, CFGFileName: string);
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
    function QTHString : string; override;
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
    constructor Create(N : string); override;
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
    constructor Create(N : string); override;
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
    EditUndoItem: TMenuItem;
    EditCutItem: TMenuItem;
    EditCopyItem: TMenuItem;
    EditPasteItem: TMenuItem;
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
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    MultiButton: TSpeedButton;
    SpeedButton8: TSpeedButton;
    CWToolBar: TPanel;
    LogButton: TSpeedButton;
    EditPanel: TPanel;
    RcvdRSTEdit: TEdit;
    BandEdit: TEdit;
    ModeEdit: TEdit;
    PointEdit: TEdit;
    OpEdit: TEdit;
    OptionsButton: TSpeedButton;
    OpMenu: TPopupMenu;
    SuperCheckButtpn: TSpeedButton;
    CWStopButton: TSpeedButton;
    CWPauseButton: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedBar: TTrackBar;
    SpeedLabel: TLabel;
    Button1: TButton;
    CWPlayButton: TSpeedButton;
    Timer1: TTimer;
    InsertQSO1: TMenuItem;
    N10GHzup1: TMenuItem;
    Export1: TMenuItem;
    TXTSaveDialog: TSaveDialog;
    SerialEdit: TEdit;
    SpeedButton2: TSpeedButton;
    CWF1: THemisphereButton;
    CWF2: THemisphereButton;
    CWF3: THemisphereButton;
    CWF4: THemisphereButton;
    CWF5: THemisphereButton;
    CWF6: THemisphereButton;
    CWF7: THemisphereButton;
    CWF8: THemisphereButton;
    HemisphereButton8: THemisphereButton;
    HemisphereButton9: THemisphereButton;
    HemisphereButton10: THemisphereButton;
    Windows1: TMenuItem;
    Help1: TMenuItem;
    menuAbout: TMenuItem;
    N3: TMenuItem;
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
    N5: TMenuItem;
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
    NewPowerEdit: TEdit;
    NewPowerMenu: TPopupMenu;
    P1: TMenuItem;
    L1: TMenuItem;
    M1: TMenuItem;
    H1: TMenuItem;
    CheckCall1: TMenuItem;
    CreateDupeCheckSheetZPRINT1: TMenuItem;
    memo1: TMenuItem;
    rst1: TMenuItem;
    callsign1: TMenuItem;
    View1: TMenuItem;
    ShowCurrentBandOnly: TMenuItem;
    SortbyTime1: TMenuItem;
    pushqso1: TMenuItem;
    pullqso1: TMenuItem;
    CallsignEdit: TOvrEdit;
    NumberEdit: TOvrEdit;
    MemoEdit: TOvrEdit;
    TimeEdit: TOvrEdit;
    DateEdit: TOvrEdit;
    ZServerIcon: TImage;
    memo21: TMenuItem;
    PrintLogSummaryzLog1: TMenuItem;
    GeneralSaveDialog: TSaveDialog;
    mPXListWPX: TMenuItem;
    mSummaryFile: TMenuItem;
    op1: TMenuItem;
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
    SpeedButton15: TSpeedButton;
    VoicePlayButton: TSpeedButton;
    VoiceF1: THemisphereButton;
    VoiceF3: THemisphereButton;
    VoiceF2: THemisphereButton;
    VoiceF4: THemisphereButton;
    VoiceF5: THemisphereButton;
    VoiceF6: THemisphereButton;
    VoiceF7: THemisphereButton;
    VoiceF8: THemisphereButton;
    HemisphereButton1: THemisphereButton;
    CQRepeatVoice1: THemisphereButton;
    CQRepeatVoice2: THemisphereButton;
    Bandscope1: TMenuItem;
    mnChangeTXNr: TMenuItem;
    mnGridAddNewPX: TMenuItem;
    Togglerig1: TMenuItem;
    mnHideCWPhToolBar: TMenuItem;
    mnHideMenuToolbar: TMenuItem;
    Scratchsheet1: TMenuItem;
    OpenDialog1: TOpenDialog;
    IncreaseFontSize1: TMenuItem;
    mnMMTTY: TMenuItem;
    mnTTYConsole: TMenuItem;
    QTC1: TMenuItem;
    mnNewBandScope: TMenuItem;
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
    actionCheckPartial: TAction;
    menuClearCallAndRst: TMenuItem;
    actionInsertBandScope: TAction;
    actionInsertBandScope2: TAction;
    actionInsertBandScope3: TAction;
    DecreaseFontSize1: TMenuItem;
    actionIncreaseFontSize: TAction;
    actionDecreaseFontSize: TAction;
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
    procedure EditUndo(Sender: TObject);
    procedure EditCut(Sender: TObject);
    procedure EditCopy(Sender: TObject);
    procedure EditPaste(Sender: TObject);
    procedure HelpContents(Sender: TObject);
    procedure HelpSearch(Sender: TObject);
    procedure HelpHowToUse(Sender: TObject);
    procedure HelpAbout(Sender: TObject);
    procedure CommonEditKeyProcess(Sender: TObject; var Key: Char);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure CallsignEditChange(Sender: TObject);
    procedure NumberEditChange(Sender: TObject);
    procedure BandMenuClick(Sender: TObject);
    procedure BandEditClick(Sender: TObject);
    procedure ModeMenuClick(Sender: TObject);
    procedure MemoEditChange(Sender: TObject);
    procedure ModeEditClick(Sender: TObject);
    procedure GridMenuPopup(Sender: TObject);
    procedure DeleteQSO1Click(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditQSOClick(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridDblClick(Sender: TObject);
    procedure PartialClick(Sender: TObject);
    procedure CallsignEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ScoreClick(Sender: TObject);
    procedure MultiClick(Sender: TObject);
    procedure RateClick(Sender: TObject);
    procedure LogButtonClick(Sender: TObject);
    procedure OptionsButtonClick(Sender: TObject);
    procedure SuperCheckButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CWFButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedBarChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CWStopButtonClick(Sender: TObject);
    procedure VoiceStopButtonClick(Sender: TObject);
    procedure SetCQ(CQ : boolean);
    procedure CQRepeatClick1(Sender: TObject);
    procedure CQRepeatClick2(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure OpMenuClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CWPauseButtonClick(Sender: TObject);
    procedure CWPlayButtonClick(Sender: TObject);
    procedure RcvdRSTEditChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure InsertQSO1Click(Sender: TObject);
    procedure MemoEditKeyPress(Sender: TObject; var Key: Char);
    procedure VoiceFButtonClick(Sender: TObject);
    procedure TimeEditChange(Sender: TObject);
    procedure Export1Click(Sender: TObject);
    procedure ClusterClick(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SerialEditChange(Sender: TObject);
    procedure GridBandChangeClick(Sender: TObject);
    procedure ZLinkmonitor1Click(Sender: TObject);
    procedure Load1Click(Sender: TObject);
    procedure SortbyTime1Click(Sender: TObject);
    procedure menuAboutClick(Sender: TObject);
    procedure DateEditChange(Sender: TObject);
    procedure TimeEditDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure menuOptionsClick(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure CWF1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure HemisphereButton8MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Backup1Click(Sender: TObject);
    procedure CWKeyboard1Click(Sender: TObject);
    procedure EditEnter(Sender: TObject);
    procedure mnMergeClick(Sender: TObject);
    procedure ZServer1Click(Sender: TObject);
    procedure ConnecttoZServer1Click(Sender: TObject);
    procedure GridModeChangeClick(Sender: TObject);
    procedure GridOperatorClick(Sender: TObject);
    procedure SendSpot1Click(Sender: TObject);
    procedure NumberEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NewPowerMenuClick(Sender: TObject);
    procedure NewPowerEditClick(Sender: TObject);
    procedure OpEditClick(Sender: TObject);
    procedure CheckCall1Click(Sender: TObject);
    procedure GridClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CreateDupeCheckSheetZPRINT1Click(Sender: TObject);
    procedure MemoHotKeyEnter(Sender: TObject);
    procedure memo1Click(Sender: TObject);
    procedure rst1Click(Sender: TObject);
    procedure callsign1Click(Sender: TObject);
    procedure ShowCurrentBandOnlyClick(Sender: TObject);
    procedure pushqso1Click(Sender: TObject);
    procedure pullqso1Click(Sender: TObject);
    procedure GridTopLeftChanged(Sender: TObject);
    procedure TXTSaveDialogTypeChange(Sender: TObject);
    procedure GridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure memo21Click(Sender: TObject);
    procedure StatusLineResize(Sender: TObject);
    procedure PrintLogSummaryzLog1Click(Sender: TObject);
    procedure CQRepeatVoice2Click(Sender: TObject);
    procedure CQRepeatVoice1Click(Sender: TObject);
    procedure mPXListWPXClick(Sender: TObject);
    procedure mSummaryFileClick(Sender: TObject);
    procedure op1Click(Sender: TObject);
    procedure GridPowerChangeClick(Sender: TObject);
    procedure RigControl1Click(Sender: TObject);
    procedure Console1Click(Sender: TObject);
    procedure MergeFile1Click(Sender: TObject);
    procedure RunningFrequencies1Click(Sender: TObject);
    procedure mnCheckCountryClick(Sender: TObject);
    procedure mnCheckMultiClick(Sender: TObject);
    procedure StatusLineDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure Bandscope1Click(Sender: TObject);
    procedure mnChangeTXNrClick(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure mnGridAddNewPXClick(Sender: TObject);
    procedure GridSelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
    procedure GridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure GridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure Togglerig1Click(Sender: TObject);
    procedure mnHideCWPhToolBarClick(Sender: TObject);
    procedure mnHideMenuToolbarClick(Sender: TObject);
    procedure Scratchsheet1Click(Sender: TObject);
    procedure mnMMTTYClick(Sender: TObject);
    procedure mnTTYConsoleClick(Sender: TObject);
    procedure SwitchCWBank(Action : integer);
    procedure QTC1Click(Sender: TObject);
    procedure mnNewBandScopeClick(Sender: TObject);
    procedure menuQuickReferenceClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure CreateELogJARL1Click(Sender: TObject);
    procedure CreateELogJARL2Click(Sender: TObject);

    procedure OnZLogInit( var Message: TMessage ); message WM_ZLOG_INIT;
    procedure OnZLogSetGridCol( var Message: TMessage ); message WM_ZLOG_SETGRIDCOL;
    procedure actionQuickQSYExecute(Sender: TObject);
    procedure actionPlayMessageAExecute(Sender: TObject);
    procedure actionPlayMessageBExecute(Sender: TObject);
    procedure actionCheckMultiExecute(Sender: TObject);
    procedure actionCheckPartialExecute(Sender: TObject);
    procedure menuClearCallAndRstClick(Sender: TObject);
    procedure actionInsertBandScopeExecute(Sender: TObject);
    procedure actionInsertBandScope3Execute(Sender: TObject);
    procedure actionIncreaseFontSizeExecute(Sender: TObject);
    procedure actionDecreaseFontSizeExecute(Sender: TObject);
  private
    TempQSOList : TList;
    clStatusLine : TColor;
    OldCallsign, OldNumber : string;
    defaultTextColor : TColor;

    SaveInBackGround: Boolean;
    TabPressed: boolean;
    TabPressed2: boolean; // for moving focus to numberedit
    LastTabPress: TDateTime;

    FPostContest: Boolean;

    // Quick Reference
    FQuickRef: TQuickRef;

    procedure MyIdleEvent(Sender: TObject; var Done: boolean);
    procedure MyMessageEvent(var Msg: TMsg; var Handled: boolean);

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
    procedure InitWPX(OpGroupIndex: Integer);
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
    function GetFirstAvailableBand(): TBand;
    procedure SetWindowCaption();
    procedure RestoreWindowsPos();
  public
    EditScreen : TBasicEdit;
    LastFocus : TEdit;
    procedure LoadNewContestFromFile(FileName : string);
    procedure RenewCWToolBar;
    procedure RenewVoiceToolBar;
    procedure RenewBandMenu();
    procedure OnTabPress;
    procedure DownKeyPress;
    procedure PushQSO(aQSO : TQSO);
    procedure PullQSO;
    procedure SetR(var aQSO : TQSO); // RST
    procedure SetS(var aQSO : TQSO);

    //procedure SetQSOBand(var aQSO : TQSO; Up : boolean);
    function GetNextBand(BB : TBand; Up : boolean) : TBand;

    procedure SetQSOMode(var aQSO : TQSO);
    procedure WriteStatusLine(S : string; WriteConsole : boolean);
    procedure WriteStatusLineRed(S : string; WriteConsole : boolean);
    procedure CallsignSentProc(Sender: TObject); // called when callsign is sent;
    procedure Update10MinTimer; //10 min countdown
    procedure ProcessConsoleCommand(S : string);
    procedure UpdateBand(B : TBand); // takes care of window disp
    procedure UpdateMode(M : TMode);
    {procedure LogQSO(aQSO : TQSO);  }
    function MergeFile(Filename : string) : integer; // merges filename to current data. returns #QSOs added
    function NewQSOID : integer;
    procedure DisableNetworkMenus;
    procedure EnableNetworkMenus;
    procedure SaveFileAndBackUp;
    procedure ReEvaluateCountDownTimer;
    procedure ReEvaluateQSYCount;
    procedure RestoreWindowStates;
    procedure RecordWindowStates;
    procedure SwitchLastQSOBandMode;
    procedure IncFontSize();
    procedure DecFontSize();
    procedure SetFontSize(font_size: Integer);
    procedure AutoInput(D : TBSData);
    procedure ConsoleRigBandSet(B: TBand);

    procedure ShowBandMenu(b: TBand);
    procedure HideBandMenu(b: TBand);
    procedure HideBandMenuHF();
    procedure HideBandMenuWARC();
    procedure HideBandMenuVU(fInclude50: Boolean = True);

    procedure QSY(b: TBand; m: TMode);
    procedure PlayMessage(bank: Integer; no: Integer);
    procedure InsertBandScope(fShiftKey: Boolean);
  end;

var
  MainForm: TMainForm;
  CurrentQSO: TQSO;

var
  MyContest : TContest = nil;

implementation

uses UPartials, UALLJAEditDialog, UAbout, URateDialog, UMenu, UACAGMulti,
  USuperCheck, UACAGScore, UALLJAScore, UComm,
  UJIDXMulti, UJIDXScore, UJIDXScore2, UZLinkForm, UWPXMulti, UWPXScore,
  UPediScore, UCWKeyBoard, UJIDX_DX_Multi, UJIDX_DX_Score, UChat,
  UGeneralScore, USpotForm, UFDMulti, UARRLDXMulti,
  UARRLDXScore, UAPSprintScore, UJA0Multi, UJA0Score,
  UKCJMulti, USixDownMulti, USixDownScore, UIARUMulti,
  UIARUScore, UAllAsianScore, UIOTAMulti, {UIOTACategory,} UARRL10Multi,
  UARRL10Score, UFreqList, UCheckCall2, UCheckCountry, UCheckMulti,
  UBandScope2, UIntegerDialog, UNewPrefix, UKCJScore, UScratchSheet,
  UWAEScore, UWAEMulti, USummaryInfo,
  UAgeDialog, UMultipliers, UUTCDialog, UZServerInquiry, UNewIOTARef;

{$R *.DFM}

function TMainForm.NewQSOID: integer;
var
   tt, ss, rr: integer;
begin
   tt := dmZlogGlobal.Settings._txnr;
   if tt > 21 then
      tt := 21;
   ss := GLOBALSERIAL;
   inc(GLOBALSERIAL);
   if GLOBALSERIAL > 9999 then
      GLOBALSERIAL := 0;
   rr := random(100);
   Result := tt * 100000000 + ss * 10000 + rr * 100;
end;

function TMainForm.MergeFile(filename: string): integer;
var
   Q: TQSO;
   f: file of TQSOdata;
   i, j, merged: integer;
   boo: boolean;
begin
   merged := 0;
   Q := TQSO.Create;
   System.assign(f, filename);
   reset(f);
   read(f, Q.QSO); // first qso comment
   for i := 1 to FileSize(f) - 1 do begin
      read(f, Q.QSO);
      boo := False;
      for j := 1 to Log.TotalQSO do
         if SameQSO(Q, TQSO(Log.List[j])) then begin
            boo := True;
            break;
         end;
      if boo = False then begin
         Log.Add(Q);
         inc(merged);
      end;
   end;
   System.close(f);
   Q.Free;
   Result := merged;
end;

procedure TMainForm.ReEvaluateCountDownTimer;
var
   mytx, i: integer;
   TL: TList;
   Q, QQ: TQSO;
begin

   TL := TList.Create;
   mytx := dmZlogGlobal.TXNr;
   for i := 1 to Log.TotalQSO do
      if TQSO(Log.List[i]).QSO.TX = mytx then
         TL.Add(TQSO(Log.List[i]));
   Q := nil;
   if TL.Count = 0 then begin
      CountDownStartTime := 0;
      exit;
   end;
   Q := TQSO(TL[TL.Count - 1]);
   for i := TL.Count - 2 downto 0 do // if there's only 1 qso then it won't loop
   begin
      QQ := TQSO(TL[i]);
      if QQ.QSO.Band <> Q.QSO.Band then begin
         CountDownStartTime := Q.QSO.Time;
         break;
      end
      else
         Q := QQ;
   end;
   CountDownStartTime := Q.QSO.Time;
   TL.Free;
end;

procedure TMainForm.ReEvaluateQSYCount;
var
   mytx, i: integer;
   TL: TList;
   Q, QQ: TQSO;
   aTime: TDateTime;
   Hr, Min, Sec, mSec: word;
begin
   if dmZlogGlobal.Settings._qsycount = False then
      exit;

   TL := TList.Create;
   mytx := dmZlogGlobal.TXNr;
   for i := 1 to Log.TotalQSO do
      if TQSO(Log.List[i]).QSO.TX = mytx then
         TL.Add(TQSO(Log.List[i]));
   Q := nil;
   QSYCount := 0;
   if TL.Count = 0 then
      exit;

   Q := TQSO(TL[TL.Count - 1]);

   aTime := CurrentTime;
   DecodeTime(aTime, Hr, Min, Sec, mSec);
   aTime := EncodeTime(Hr, 0, 0, 0);
   aTime := Int(CurrentTime) + aTime;

   for i := TL.Count - 2 downto 0 do // if there's only 1 qso then it won't loop
   begin
      QQ := TQSO(TL[i]);
      if QQ.QSO.Time < aTime then
         break;
      if QQ.QSO.Band <> Q.QSO.Band then
         inc(QSYCount);
      Q := QQ;
   end;

   TL.Free;
end;

procedure TMainForm.WriteStatusLine(S: string; WriteConsole: boolean);
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
      ConsolePad.AddLine(S);
end;

procedure TMainForm.WriteStatusLineRed(S: string; WriteConsole: boolean);
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
      ConsolePad.AddLine(S);
end;

procedure TMainForm.PushQSO(aQSO: TQSO);
const
   TEMPQSOMAX = 5;
var
   i: integer;
   Q: TQSO;
begin
   i := TempQSOList.Count;
   Q := TQSO.Create;
   Q.QSO := aQSO.QSO;
   TempQSOList.Insert(0, Q);
   if TempQSOList.Count > TEMPQSOMAX then begin
      i := TempQSOList.Count;
      Q := TQSO(TempQSOList[i - 1]);
      TempQSOList.Delete(i - 1);
      Q.Free;
   end;
end;

procedure TMainForm.PullQSO;
var
   i: integer;
begin
   i := TempQSOList.Count;
   if i > 0 then begin
      CurrentQSO.QSO := TQSO(TempQSOList[0]).QSO;

      CallsignEdit.Text := CurrentQSO.QSO.Callsign;
      NumberEdit.Text := CurrentQSO.QSO.NrRcvd;
      BandEdit.Text := MHzString[CurrentQSO.QSO.Band];
      NewPowerEdit.Text := NewPowerString[CurrentQSO.QSO.Power];
      PointEdit.Text := CurrentQSO.PointStr;
      RcvdRSTEdit.Text := CurrentQSO.RSTStr;
      CurrentQSO.UpdateTime;
      TimeEdit.Text := CurrentQSO.TimeStr;
      DateEdit.Text := CurrentQSO.DateStr;
      // ModeEdit.Text := CurrentQSO.ModeStr;

      ModeEdit.Text := ModeString[CurrentQSO.QSO.mode];

      If CurrentQSO.QSO.mode in [mSSB .. mAM] then begin
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
      TempQSOList.Move(0, i - 1);
   end;
end;

procedure TMainForm.RenewCWToolBar;
var
   i: integer;
begin
   SpeedBar.Position := dmZlogGlobal.Speed;
   SpeedLabel.Caption := IntToStr(dmZlogGlobal.Speed) + ' wpm';
   i := dmZlogGlobal.Settings.CW.CurrentBank;
   CWF1.Hint := dmZlogGlobal.CWMessage(i, 1);
   CWF2.Hint := dmZlogGlobal.CWMessage(i, 2);
   CWF3.Hint := dmZlogGlobal.CWMessage(i, 3);
   CWF4.Hint := dmZlogGlobal.CWMessage(i, 4);
   CWF5.Hint := dmZlogGlobal.CWMessage(i, 5);
   CWF6.Hint := dmZlogGlobal.CWMessage(i, 6);
   CWF7.Hint := dmZlogGlobal.CWMessage(i, 7);
   CWF8.Hint := dmZlogGlobal.CWMessage(i, 8);
end;

procedure TMainForm.RenewVoiceToolBar;
begin
   { if dmZlogGlobal.SideTone then
     SideToneButton.Down := True
     else
     SideToneButton.Down := False;
     SpeedBar.Position := dmZlogGlobal.Speed;
     SpeedLabel.Caption := IntToStr(dmZlogGlobal.Speed)+' wpm';
     CWF1.Hint := dmZlogGlobal.CWMessage(1, 1);
     CWF2.Hint := dmZlogGlobal.CWMessage(1, 2);
     CWF3.Hint := dmZlogGlobal.CWMessage(1, 3);
     CWF4.Hint := dmZlogGlobal.CWMessage(1, 4);
     CWF5.Hint := dmZlogGlobal.CWMessage(1, 5);
     CWF6.Hint := dmZlogGlobal.CWMessage(1, 6);
     CWF7.Hint := dmZlogGlobal.CWMessage(1, 7);
     CWF8.Hint := dmZlogGlobal.CWMessage(1, 8); }
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
   assign(f, filename);
   rewrite(f);
   S := FillRight('Year:', 12) + IntToStr(Log.Year);
   writeln(f, S);
   writeln(f);
   writeln(f, Name);
   writeln(f);
   S := FillRight('Callsign:', 12) + dmZlogGlobal.MyCall;
   writeln(f, S);
   writeln(f);
   writeln(f, 'Country: ');
   writeln(f);
   S := FillRight('Category:', 12);
   if dmZlogGlobal.MultiOp > 0 then
      S := S + 'Multi Operator  '
   else
      S := S + 'Single Operator  ';
   if dmZlogGlobal.Band = 0 then
      S := S + 'All band'
   else
      S := S + MHzString[TBand(Ord(dmZlogGlobal.Band) - 1)];
   S := S + '  ';
   case dmZlogGlobal.mode of
      0:
         S := S + 'Phone/CW';
      1:
         S := S + 'CW';
      2:
         S := S + 'Phone';
   end;
   writeln(f, S);
   writeln(f);
   writeln(f, 'Band(MHz)      QSOs         Points       Multi.');

   writeln(f, 'Total');
   writeln(f, 'Score');

   writeln(f);

   close(f);
end;

function TARRL10Contest.CheckWinSummary(aQSO: TQSO): string; // returns summary for checkcall etc.
var
   str: string;
begin
   str := aQSO.CheckCallSummary;
   if aQSO.QSO.mode = mCW then
      Insert('CW ', str, 5)
   else
      Insert('Ph ', str, 5);
   Result := str;
end;

function TContest.CheckWinSummary(aQSO: TQSO): string; // returns summary for checkcall etc.
begin
   Result := aQSO.CheckCallSummary;
end;

function TContest.QTHString: string;
begin
   Result := dmZlogGlobal.Settings._city;
end;

procedure TContest.SetPoints(var aQSO: TQSO);
begin
end;

Procedure TContest.DispExchangeOnOtherBands;
var
   boo: boolean;
   j: integer;
   B: TBand;
begin
   boo := False;
   for j := 1 to Log.TotalQSO do begin
      if CurrentQSO.QSO.Callsign = TQSO(Log.List[j]).QSO.Callsign then begin
         boo := True;
         break;
      end;
   end;
   if boo then begin
      MainForm.NumberEdit.Text := TQSO(Log.List[j]).QSO.NrRcvd;
      CurrentQSO.QSO.NrRcvd := TQSO(Log.List[j]).QSO.NrRcvd;
   end
   else { check SubLog 0.23 }
   begin
      { for B := b19 to HiBand do
        begin
        for j := 1 to SubLog[B].TotalQSO do
        begin
        if CurrentQSO.QSO.callsign = TQSO(SubLog[B].List[j]).QSO.callsign then
        begin
        MainForm.NumberEdit.Text := TQSO(SubLog[B].List[j]).QSO.NrRcvd;
        CurrentQSO.QSO.NrRcvd := TQSO(SubLog[B].List[j]).QSO.NrRcvd;
        exit;
        end;
        end;
        end; }
   end;
end;

Procedure TACAGContest.DispExchangeOnOtherBands;
var
   boo: boolean;
   j: integer;
   B: TBand;
   str: string;
begin
   boo := False;
   for j := 1 to Log.TotalQSO do begin
      if CurrentQSO.QSO.Callsign = TQSO(Log.List[j]).QSO.Callsign then begin
         boo := True;
         break;
      end;
   end;
   if boo then begin
      MainForm.NumberEdit.Text := TQSO(Log.List[j]).QSO.NrRcvd;
      CurrentQSO.QSO.NrRcvd := TQSO(Log.List[j]).QSO.NrRcvd;
   end
   else { check SubLog 0.23 }
   begin
      { for B := b19 to HiBand do
        begin
        for j := 1 to SubLog[B].TotalQSO do
        begin
        if CurrentQSO.QSO.callsign = TQSO(SubLog[B].List[j]).QSO.callsign then
        begin
        MainForm.NumberEdit.Text := TQSO(SubLog[B].List[j]).QSO.NrRcvd;
        CurrentQSO.QSO.NrRcvd := TQSO(SubLog[B].List[j]).QSO.NrRcvd;
        exit;
        end;
        end;
        end; }
   end;

   // added for acag
   str := MainForm.NumberEdit.Text;
   if str <> '' then
      if str[length(str)] in ['H', 'M', 'L', 'P'] then begin
         MainForm.NumberEdit.SelStart := length(str) - 1;
         MainForm.NumberEdit.SelLength := 1;
      end;
end;

Procedure TALLJAContest.DispExchangeOnOtherBands;
var
   boo: boolean;
   j: integer;
   B: TBand;
   str: string;
begin
   boo := False;
   for j := 1 to Log.TotalQSO do begin
      if CurrentQSO.QSO.Callsign = TQSO(Log.List[j]).QSO.Callsign then begin
         boo := True;
         break;
      end;
   end;
   if boo then begin
      MainForm.NumberEdit.Text := TQSO(Log.List[j]).QSO.NrRcvd;
      CurrentQSO.QSO.NrRcvd := TQSO(Log.List[j]).QSO.NrRcvd;
   end
   else { check SubLog 0.23 }
   begin
      { for B := b19 to HiBand do
        begin
        for j := 1 to SubLog[B].TotalQSO do
        begin
        if CurrentQSO.QSO.callsign = TQSO(SubLog[B].List[j]).QSO.callsign then
        begin
        MainForm.NumberEdit.Text := TQSO(SubLog[B].List[j]).QSO.NrRcvd;
        CurrentQSO.QSO.NrRcvd := TQSO(SubLog[B].List[j]).QSO.NrRcvd;
        exit;
        end;
        end;
        end; }
   end;

   // added for allja (same as acag)
   str := MainForm.NumberEdit.Text;
   if str <> '' then
      if str[length(str)] in ['H', 'M', 'L', 'P'] then begin
         MainForm.NumberEdit.SelStart := length(str) - 1;
         MainForm.NumberEdit.SelLength := 1;
      end;
end;

Procedure TFDContest.DispExchangeOnOtherBands;
var
   j: integer;
   B: TBand;
   str: string;
   currshf: boolean;
   pastQSO, tempQSO: TQSO;

label
   med;

begin

   currshf := IsSHF(CurrentQSO.QSO.Band);
   pastQSO := nil;
   tempQSO := nil;

   for j := 1 to Log.TotalQSO do begin
      if CurrentQSO.QSO.Callsign = TQSO(Log.List[j]).QSO.Callsign then begin
         if currshf = IsSHF(TQSO(Log.List[j]).QSO.Band) then begin
            pastQSO := TQSO(Log.List[j]);
            break;
         end
         else begin
            tempQSO := TQSO(Log.List[j]);
         end;
      end;
   end;

   if pastQSO = nil then { check SubLog 0.23 }
   begin
      {
        for B := b19 to HiBand do
        begin
        for j := 1 to SubLog[B].TotalQSO do
        begin
        if CurrentQSO.QSO.callsign = TQSO(SubLog[B].List[j]).QSO.callsign then
        begin
        if currshf = IsSHF(TQSO(SubLog[B].List[j]).QSO.Band) then
        begin
        pastQSO := TQSO(SubLog[B].List[j]);
        goto med;
        end
        else
        begin
        tempQSO := TQSO(SubLog[B].List[j]);
        end;
        end;
        end;
        end; }
   end;

med:
   if pastQSO <> nil then begin
      MainForm.NumberEdit.Text := pastQSO.QSO.NrRcvd;
      CurrentQSO.QSO.NrRcvd := pastQSO.QSO.NrRcvd;
   end
   else begin
      if tempQSO <> nil then begin
         if currshf = True then begin
            if length(tempQSO.QSO.NrRcvd) > 3 then
               str := '01' + ExtractPower(tempQSO.QSO.NrRcvd)
            else
               str := tempQSO.QSO.NrRcvd;
            MainForm.NumberEdit.Text := str;
            CurrentQSO.QSO.NrRcvd := str;
         end
         else begin
            str := ExtractKenNr(tempQSO.QSO.NrRcvd) + ExtractPower(tempQSO.QSO.NrRcvd);
            MainForm.NumberEdit.Text := str;
            CurrentQSO.QSO.NrRcvd := str;
         end;
      end
      else // if tempQSO = nil
      begin
         exit;
      end;
   end;

   // added for acag
   str := MainForm.NumberEdit.Text;
   if str <> '' then
      if str[length(str)] in ['H', 'M', 'L', 'P'] then begin
         MainForm.NumberEdit.SelStart := length(str) - 1;
         MainForm.NumberEdit.SelLength := 1;
      end;
end;

Procedure TSixDownContest.DispExchangeOnOtherBands;
var
   j: integer;
   B: TBand;
   str: string;
   currshf: boolean;
   pastQSO, tempQSO: TQSO;

label
   med;

begin

   currshf := IsSHF(CurrentQSO.QSO.Band);
   pastQSO := nil;
   tempQSO := nil;

   for j := 1 to Log.TotalQSO do begin
      if CurrentQSO.QSO.Callsign = TQSO(Log.List[j]).QSO.Callsign then begin
         if currshf = IsSHF(TQSO(Log.List[j]).QSO.Band) then begin
            pastQSO := TQSO(Log.List[j]);
            break;
         end
         else begin
            tempQSO := TQSO(Log.List[j]);
         end;
      end;
   end;

   if pastQSO = nil then { check SubLog 0.23 }
   begin
      { for B := b19 to HiBand do
        begin
        for j := 1 to SubLog[B].TotalQSO do
        begin
        if CurrentQSO.QSO.callsign = TQSO(SubLog[B].List[j]).QSO.callsign then
        begin
        if currshf = IsSHF(TQSO(SubLog[B].List[j]).QSO.Band) then
        begin
        pastQSO := TQSO(SubLog[B].List[j]);
        goto med;
        end
        else
        begin
        tempQSO := TQSO(SubLog[B].List[j]);
        end;
        end;
        end;
        end; }
   end;

med:
   if pastQSO <> nil then begin
      MainForm.NumberEdit.Text := pastQSO.QSO.NrRcvd;
      CurrentQSO.QSO.NrRcvd := pastQSO.QSO.NrRcvd;
   end
   else begin
      if tempQSO <> nil then begin
         if currshf = True then begin
            if length(tempQSO.QSO.NrRcvd) > 3 then
               str := '01' + ExtractPower(tempQSO.QSO.NrRcvd)
            else
               str := tempQSO.QSO.NrRcvd;
            MainForm.NumberEdit.Text := str;
            CurrentQSO.QSO.NrRcvd := str;
         end
         else begin
            str := ExtractKenNr(tempQSO.QSO.NrRcvd) + ExtractPower(tempQSO.QSO.NrRcvd);
            MainForm.NumberEdit.Text := str;
            CurrentQSO.QSO.NrRcvd := str;
         end;
      end
      else // if tempQSO = nil
      begin
         exit;
      end;
   end;

   // added for acag
   str := MainForm.NumberEdit.Text;
   if str <> '' then begin
      if str[length(str)] in ['H', 'M', 'L', 'P'] then begin
         MainForm.NumberEdit.SelStart := length(str) - 1;
         MainForm.NumberEdit.SelLength := 1;
      end;
   end;
end;

Procedure TContest.SpaceBarProc;
begin
   MultiFound := False;
   if (MainForm.NumberEdit.Text = '') and (SameExchange = True) then begin
      DispExchangeOnOtherBands;
      if MainForm.NumberEdit.Text <> '' then
         MultiFound := True;
   end;
   if dmZlogGlobal.Settings._entersuperexchange and (SuperCheck.Rcvd_Estimate <> '') then
      if MainForm.NumberEdit.Text = '' then
         if CoreCall(SuperCheck.FirstDataCall) = CoreCall(MainForm.CallsignEdit.Text) then begin
            MainForm.NumberEdit.Text := TrimRight(SuperCheck.Rcvd_Estimate);
            MultiFound := True;
         end;

   if CheckMulti.Visible then
      CheckMulti.Renew(CurrentQSO);
end;

Procedure TIOTAContest.SpaceBarProc;
begin
   inherited;
   if MultiFound and (TIOTAMulti(MyContest.MultiForm).ExtractMulti(CurrentQSO) = '') then // serial number
      MainForm.NumberEdit.Text := '';
end;

procedure TMainForm.SetR(var aQSO: TQSO); // r of RST
var
   i: integer;
begin
   i := aQSO.QSO.RSTRcvd;
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
   aQSO.QSO.RSTRcvd := i;
   // RcvdRSTEdit.Text := CurrentQSO.RSTStr;
end;

procedure TMainForm.SetS(var aQSO: TQSO);
var
   i: integer;
begin
   i := aQSO.QSO.RSTRcvd;
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

   aQSO.QSO.RSTRcvd := i;
   // RcvdRSTEdit.Text := CurrentQSO.RSTStr;
end;

function TMainForm.GetNextBand(BB: TBand; Up: boolean): TBand;
var
   B0, B: TBand;
   boo: boolean;
label
   xxx;
label
   top;
begin
   Result := BB;

   boo := False;
   for B := b19 to HiBand do begin
      if BandMenu.Items[Ord(B)].Visible and BandMenu.Items[Ord(B)].Enabled then begin
         boo := True;
      end;
   end;

   if boo = False then begin
      exit; { No QRVable and Contest allowed band }
   end;

   B0 := BB;

top:
   if Up then begin
      if B0 = HiBand then
         B0 := b19
      else
         inc(B0);
      for B := B0 to HiBand do
         if BandMenu.Items[Ord(B)].Visible and BandMenu.Items[Ord(B)].Enabled then begin
            if dmZlogGlobal.Settings._dontallowsameband and RigControl.CheckSameBand(B) then begin
            end
            else
               goto xxx;
         end;

      for B := b19 to B0 do
         if BandMenu.Items[Ord(B)].Visible and BandMenu.Items[Ord(B)].Enabled then begin
            if dmZlogGlobal.Settings._dontallowsameband and RigControl.CheckSameBand(B) then begin
            end
            else
               goto xxx;
         end;
   end
   else begin
      if B0 = b19 then
         B0 := HiBand
      else
         dec(B0);

      for B := B0 downto b19 do begin
         if BandMenu.Items[Ord(B)].Visible and BandMenu.Items[Ord(B)].Enabled then begin
            if dmZlogGlobal.Settings._dontallowsameband and RigControl.CheckSameBand(B) then begin
            end
            else
               goto xxx;
         end;
      end;

      for B := HiBand downto B0 do begin
         if BandMenu.Items[Ord(B)].Visible and BandMenu.Items[Ord(B)].Enabled then begin
            if dmZlogGlobal.Settings._dontallowsameband and RigControl.CheckSameBand(B) then begin
            end
            else
               goto xxx;
         end;
      end;
   end;

xxx:

   if RigControl.Rig <> nil then begin // keep band within Rig
      if (B > RigControl.Rig.MaxBand) or (B < RigControl.Rig.MinBand) then begin
         B0 := B;
         goto top;
      end;
   end;

   Result := B;
end;

procedure TMainForm.BandMenuClick(Sender: TObject);
begin
   QSY(TBand(TMenuItem(Sender).Tag), CurrentQSO.QSO.Mode);
   LastFocus.SetFocus;
end;

procedure TMainForm.UpdateBand(B: TBand); // called from rigcontrol too
begin

   dmZlogGlobal.CurrentPower[CurrentQSO.QSO.Band] := CurrentQSO.QSO.Power;
   dmZlogGlobal.CurrentPower2[CurrentQSO.QSO.Band] := CurrentQSO.QSO.Power2;

   BandEdit.Text := MHzString[B];

   if SerialEdit.Visible then
      if SerialContestType = SER_BAND then begin
         SerialArray[CurrentQSO.QSO.Band] := CurrentQSO.QSO.Serial;
         CurrentQSO.QSO.Serial := SerialArray[B];
         SerialEdit.Text := CurrentQSO.SerialStr;
      end;

   CurrentQSO.QSO.Band := B;

   { BGK32LIB._bandmask := (dmZlogGlobal.Settings._BandData[B] * 16);
     BGK32LIB.UpdateDataPort; }
   RigControl.SetBandMask;

   if MyContest <> nil then begin
      MyContest.SetPoints(CurrentQSO);
   end;

   PointEdit.Text := CurrentQSO.PointStr; // ver 0.23

   ZLinkForm.SendBand; // ver 0.41

   if NewPowerEdit.Visible then begin
      CurrentQSO.QSO.Power := dmZlogGlobal.CurrentPower[B];
      dmZlogGlobal.SetOpPower(CurrentQSO);
      NewPowerEdit.Text := CurrentQSO.NewPowerStr;
   end;

   if MyContest <> nil then begin
      if MyContest.MultiForm.Visible then begin
         MyContest.MultiForm.Update;
      end;
   end;

   if PartialCheck.Visible then begin
      PartialCheck.Update(CurrentQSO);
   end;

   if ShowCurrentBandOnly.Checked then begin
      EditScreen.Renew;
      EditScreen.RefreshScreen;
   end;

   // LastFocus.SetFocus;
   // BandScope.SetBandMode(CurrentQSO.QSO.Band, CurrentQSO.QSO.Mode);
   BandScope2.SetBandMode(CurrentQSO.QSO.Band, CurrentQSO.QSO.mode);

   if dmZlogGlobal.Settings._countdown and (CountDownStartTime > 0) then begin
      WriteStatusLineRed('Less than 10 min since last QSY!', False);
   end;

   if RigControl.Rig = nil then begin
      ZLinkForm.SendFreqInfo(round(RigControl.TempFreq[B] * 1000));
   end;
end;

procedure TMainForm.UpdateMode(M: TMode);
begin
   ModeEdit.Text := ModeString[M];
   CurrentQSO.QSO.mode := M;
   If M in [mSSB, mFM, mAM] then begin
      CurrentQSO.QSO.RSTRcvd := 59;
      CurrentQSO.QSO.RSTsent := 59;
      RcvdRSTEdit.Text := '59';
      Grid.Align := alNone;
      SSBToolBar.Visible := True;
      CWToolBar.Visible := False;
      Grid.Align := alClient;
   end
   else begin
      CurrentQSO.QSO.RSTRcvd := 599;
      CurrentQSO.QSO.RSTsent := 599;
      RcvdRSTEdit.Text := '599';
      Grid.Align := alNone;
      CWToolBar.Visible := True;
      SSBToolBar.Visible := False;
      Grid.Align := alClient;
   end;

   if MyContest <> nil then begin
      if MyContest.MultiForm.Visible then begin
         MyContest.MultiForm.Update;
      end;
   end;

   if MyContest <> nil then begin
      MyContest.SetPoints(CurrentQSO);
   end;

   PointEdit.Text := CurrentQSO.PointStr;

   // BandScope.SetBandMode(CurrentQSO.QSO.Band, CurrentQSO.QSO.Mode);
   BandScope2.SetBandMode(CurrentQSO.QSO.Band, CurrentQSO.QSO.mode);
end;

procedure TContest.ChangeBand(Up: boolean);
begin
   MainForm.UpdateBand(MainForm.GetNextBand(CurrentQSO.QSO.Band, Up));
   if RigControl.Rig <> nil then begin
      RigControl.Rig.SetBand(CurrentQSO);
      if CurrentQSO.QSO.mode = mSSB then
         RigControl.Rig.SetMode(CurrentQSO);
      RigControl.SetBandMask;
   end;
end;

procedure TMainForm.SetQSOMode(var aQSO: TQSO);
var
   maxmode: TMode;
begin
   maxmode := mOther;
   case aQSO.QSO.Band of
      b19 .. b28:
         maxmode := mSSB;
      b50:
         maxmode := mAM;
      b144 .. HiBand:
         maxmode := mFM;
   end;
   if Pos('Pedition', MyContest.Name) > 0 then
      maxmode := mOther;
   if aQSO.QSO.mode < maxmode then
      inc(aQSO.QSO.mode)
   else
      aQSO.QSO.mode := mCW;
end;

procedure TContest.ChangeMode;
begin
   MainForm.SetQSOMode(CurrentQSO);
   MainForm.UpdateMode(CurrentQSO.QSO.mode);

   if RigControl.Rig <> nil then begin
      RigControl.Rig.SetMode(CurrentQSO);
   end;
end;

procedure TContest.ChangePower;
begin
   if CurrentQSO.QSO.Power = pwrH then
      CurrentQSO.QSO.Power := pwrP
   else
      inc(CurrentQSO.QSO.Power);
   MainForm.NewPowerEdit.Text := CurrentQSO.NewPowerStr;
end;

constructor TWanted.Create;
begin
   Multi := '';
   Bands := [];
end;

constructor TContest.Create(N: string);
var
   i: integer;
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
   CONTESTNAME := N; // zlogglobal

   Log.AcceptDifferentMode := False;
   Log.CountHigherPoints := False;

   TQSO(Log.List[0]).QSO.Callsign := dmZlogGlobal.Settings._mycall; // Callsign
   TQSO(Log.List[0]).QSO.Memo := N; // Contest name
//   TQSO(Log.List[0]).QSO.RSTsent := UTCOffset; // UTC = $FFFF else UTC + x hrs;
   TQSO(Log.List[0]).QSO.RSTRcvd := 0; // or Field Day coefficient

   SerialContestType := 0;

   for B := b19 to HiBand do
      SerialArray[B] := 1;

   for i := 0 to 64 do
      SerialArrayTX[i] := 1;
end;

procedure TContest.PostWanted(S: string);
var
   ss, mm: string;
   i, BB: integer;
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
   i, BB: integer;
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
   i: integer;
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
   aQSO.QSO.NrSent := S;
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
   Result := aQSO.QSO.NrRcvd;
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
   Result := aQSO.QSO.Multi1;
end;

procedure TContest.ADIF_Export(filename: string);
var
   f: textfile;
   Header, S, temp: string;
   i: integer;
   aQSO: TQSO;
   offsetmin: integer;
   dbl: double;
begin
   Header := 'ADIF export from zLog for Windows'; // +dmZlogGlobal.Settings._mycall;
   assignfile(f, filename);
   rewrite(f);
   { str := 'zLog for Windows Text File'; }
   writeln(f, Header);
   writeln(f, 'All times in UTC');
   writeln(f, 'Yohei Yokobayashi AD6AJ/JJ1MED');
   writeln(f, '<eoh>');
   offsetmin := TQSO(Log.List[0]).QSO.RSTsent;
   { if offsetmin = 0 then // default JST for older versions
     offsetmin := -1*9*60; }
   if offsetmin = _USEUTC then // already recorded in utc
      offsetmin := 0;
   dbl := offsetmin / (24 * 60);
   for i := 1 to Log.TotalQSO do begin
      aQSO := TQSO(Log.List[i]);
      S := '<qso_date:8>';
      S := S + FormatDateTime('yyyymmdd', aQSO.QSO.Time + dbl);
      S := S + '<time_on:4>' + FormatDateTime('hhnn', aQSO.QSO.Time + dbl);
      S := S + '<time_off:4>' + FormatDateTime('hhnn', aQSO.QSO.Time + dbl);

      temp := aQSO.QSO.Callsign;
      S := S + '<call:' + IntToStr(length(temp)) + '>' + temp;

      temp := IntToStr(aQSO.QSO.RSTsent);
      S := S + '<rst_sent:' + IntToStr(length(temp)) + '>' + temp;

      if SerialContestType <> 0 then begin
         temp := IntToStr(aQSO.QSO.Serial);
         S := S + '<stx:' + IntToStr(length(temp)) + '>' + temp;
      end;

      temp := IntToStr(aQSO.QSO.RSTRcvd);
      S := S + '<rst_rcvd:' + IntToStr(length(temp)) + '>' + temp;

      temp := ADIF_ExchangeRX(aQSO);
      S := S + '<' + ADIF_ExchangeRX_FieldName + ':' + IntToStr(length(temp)) + '>' + temp;

      temp := ADIF_ExtraField(aQSO);
      if temp <> '' then begin
         S := S + '<' + ADIF_ExtraFieldName + ':' + IntToStr(length(temp)) + '>' + temp;
      end;

      temp := ADIFBandString[aQSO.QSO.Band];
      S := S + '<band:' + IntToStr(length(temp)) + '>' + temp;

      temp := ModeString[aQSO.QSO.mode];
      S := S + '<mode:' + IntToStr(length(temp)) + '>' + temp;

      if aQSO.QSO.Operator <> '' then begin
         temp := aQSO.QSO.Operator;
         S := S + '<operator:' + IntToStr(length(temp)) + '>' + temp;
      end;

      if aQSO.QSO.Memo <> '' then begin
         temp := aQSO.QSO.Memo;
         S := S + '<comment:' + IntToStr(length(temp)) + '>' + temp;
      end;

      S := S + '<eor>';

      writeln(f, S);
   end;
   close(f);
end;

procedure TContest.LogQSO(var aQSO: TQSO; Local: boolean);
var
   i, T, mytx: integer;
   R: word;
   boo: boolean;
begin
   if Log.TotalQSO > 0 then begin
      T := Log.TotalQSO;
      mytx := dmZlogGlobal.TXNr;
      if { Local = True } mytx = aQSO.QSO.TX then // same tx # could be through network
      begin
         boo := False;
         for i := T downto 1 do begin
            if TQSO(Log.List[i]).QSO.TX = mytx then begin
               boo := True;
               break;
            end;
         end;
         if (boo = False) or (boo and (TQSO(Log.List[i]).QSO.Band <> aQSO.QSO.Band)) then begin
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
     aQSO.QSO.Memo := 'MULT '+aQSO.QSO.Memo; }

   if Local = False then
      aQSO.QSO.Reserve2 := $AA; // some multi form and editscreen uses this flag
   MultiForm.Add(aQSO);
   aQSO.QSO.Reserve2 := $00;

   ScoreForm.Add(aQSO);
   aQSO.QSO.Reserve := actAdd;
   Log.AddQue(aQSO);
   Log.ProcessQue;

   if Local = False then
      aQSO.QSO.Reserve2 := $AA; // some multi form and editscreen uses this flag
   MainForm.EditScreen.Add(aQSO);

   // synchronization of serial # over network
   if dmZlogGlobal.Settings._syncserial and (SerialContestType <> 0) and (Local = False) then begin
      if SerialContestType = SER_MS then // WPX M/S type. Separate serial for mult/run
      begin
         SerialArrayTX[aQSO.QSO.TX] := aQSO.QSO.Serial + 1;
         if aQSO.QSO.TX = dmZlogGlobal.Settings._txnr then begin
            CurrentQSO.QSO.Serial := aQSO.QSO.Serial + 1;
            MainForm.SerialEdit.Text := CurrentQSO.SerialStr;
         end;
      end
      else begin
         SerialArray[aQSO.QSO.Band] := aQSO.QSO.Serial + 1;
         if (SerialContestType = SER_ALL) or ((SerialContestType = SER_BAND) and (CurrentQSO.QSO.Band = aQSO.QSO.Band)) then begin
            CurrentQSO.QSO.Serial := aQSO.QSO.Serial + 1;
            MainForm.SerialEdit.Text := CurrentQSO.SerialStr;
         end;
      end;
   end;

   aQSO.QSO.Reserve2 := $00;

   MainForm.ReEvaluateQSYCount;

   if RateDialog.Visible then
      RateDialog.UpdateGraph;

   if dmZlogGlobal.Settings._multistation then
      if Local { (mytx = aQSO.QSO.TX) } and (aQSO.QSO.NewMulti1 = False) and (aQSO.QSO.NewMulti2 = False) and (dmZlogGlobal.Settings._multistationwarning)
      then begin
         R := MessageDlg('This station is not a new multiplier, but will be logged anyway.', mtError, [mbOK], 0); { HELP context 0 }
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
   i, j: integer;
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
      aQSO := TQSO(Log.List[i]);

      if Log.CountHigherPoints = True then begin
         j := Log.IsDupe(aQSO); // called to set log.differentmodepointer
      end;

      MultiForm.AddNoUpdate(aQSO);
      ScoreForm.AddNoUpdate(aQSO);
   end;

   MultiForm.Update;
   ScoreForm.Update;
   MultiForm.RenewBandScope;
end;

procedure TContest.EditCurrentRow;
var
   R: integer;
   _top, _row: integer;
begin
   // R := MainForm.Grid.Row;
   _row := MainForm.Grid.Row;
   R := MainForm.EditScreen.IndexArray[_row];
   _top := MainForm.Grid.TopRow;

   if (R <= Log.TotalQSO) and (R > 0) then begin
      if TQSO(Log.List[R]).QSO.Reserve = actLock then begin
         MainForm.WriteStatusLine('This QSO is currently locked', False);
         exit;
      end;

      PastEditForm.Init(TQSO(Log.List[R]), R, _ActChange);

      if PastEditForm.ShowModal = mrOK then begin
         if PartialCheck.Visible and PartialCheck._CheckCall then
            PartialCheck.CheckPartial(CurrentQSO);
         { if SuperCheck.Visible then
           SuperCheck.CheckSuper(CurrentQSO); }
         if CheckCall2.Visible then
            CheckCall2.Renew(CurrentQSO);
      end;

      MainForm.Grid.TopRow := _top;
      MainForm.Grid.Row := _row;

      MainForm.EditScreen.RefreshScreen;
   end;
end;

constructor TJIDXContest.Create(N: string);
begin
   inherited;
   MultiForm := TJIDXMulti.Create(MainForm);
   ScoreForm := TJIDXScore2.Create(MainForm);
   ZoneForm := TWWZone.Create(MainForm);
   TJIDXMulti(MultiForm).ZoneForm := ZoneForm;
   CheckCountry.ParentMulti := TWWMulti(MultiForm);
   UseUTC := True;
   TQSO(Log.List[0]).QSO.RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
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
   TQSO(Log.List[0]).QSO.RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
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
   TQSO(Log.List[0]).QSO.RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
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
   TQSO(Log.List[0]).QSO.RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
end;

procedure TAllAsianContest.SetPoints(var aQSO: TQSO);
begin
   AllAsianScore.CalcPoints(aQSO);
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
   TQSO(Log.List[0]).QSO.RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
end;

procedure TJIDXContestDX.SetPoints(var aQSO: TQSO);
begin
   JIDX_DX_Score.CalcPoints(aQSO);
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
   TQSO(Log.List[0]).QSO.RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   TQSO(Log.List[0]).QSO.Serial := $01; // uses serial number
   SerialContestType := SER_ALL;
   SameExchange := False;
   dmZlogGlobal.Settings._sameexchange := SameExchange;
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
   TQSO(Log.List[0]).QSO.RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   TQSO(Log.List[0]).QSO.Serial := $01; // uses serial number
   SerialContestType := SER_ALL;
   SameExchange := False;
   dmZlogGlobal.Settings._sameexchange := SameExchange;
end;

destructor TWAEContest.Destroy();
begin
   QTCForm.Release();
end;

function TIOTAContest.QTHString: string;
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
   TQSO(Log.List[0]).QSO.RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   TQSO(Log.List[0]).QSO.Serial := $01; // uses serial number
   SerialContestType := SER_ALL;
end;

constructor TARRL10Contest.Create(N: string);
begin
   inherited;

   MultiForm := TARRL10Multi.Create(MainForm);
   ScoreForm := TARRL10Score.Create(MainForm);
   ZoneForm := TWWZone.Create(MainForm);
   CheckMulti.ListCWandPh := True;

   PastEditForm := TALLJAEditDialog.Create(MainForm);

   UseUTC := True;
   Log.AcceptDifferentMode := True;
   TQSO(Log.List[0]).QSO.RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   TQSO(Log.List[0]).QSO.Serial := $01; // uses serial number
   SerialContestType := SER_ALL;
   SameExchange := False;
   dmZlogGlobal.Settings._sameexchange := SameExchange;
end;

constructor TJA0Contest.Create(N: string);
begin
   inherited;
   MultiForm := TJA0Multi.Create(MainForm);
   ScoreForm := TJA0Score.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);

   TQSO(Log.List[0]).QSO.Serial := $01; // uses serial number
   SerialContestType := SER_ALL;
   SameExchange := False;
   dmZlogGlobal.Settings._sameexchange := SameExchange;
end;

constructor TJA0ContestZero.Create(N: string);
begin
   inherited;

   TJA0Multi(MultiForm).JA0 := True;

   TQSO(Log.List[0]).QSO.Serial := $01; // uses serial number
   SerialContestType := SER_ALL;
   SameExchange := False;
   dmZlogGlobal.Settings._sameexchange := SameExchange;

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
   TQSO(Log.List[0]).QSO.RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   TQSO(Log.List[0]).QSO.Serial := $01; // uses serial number
   SerialContestType := SER_ALL;

   SameExchange := False;
   dmZlogGlobal.Settings._sameexchange := SameExchange;
end;

constructor TCQWWContest.Create(N: string);
begin
   inherited;
   MultiForm := TWWMulti.Create(MainForm);
   ScoreForm := TWWScore.Create(MainForm);
   ZoneForm := TWWZone.Create(MainForm);
   TWWMulti(MultiForm).ZoneForm := ZoneForm;
   MultiForm.Reset();

   CheckCountry.ParentMulti := TWWMulti(MultiForm);

   PastEditForm := TALLJAEditDialog.Create(MainForm);

   UseUTC := True;
   TQSO(Log.List[0]).QSO.RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
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
   CurrentQSO.QSO.NrRcvd := temp;
   // end;

   { This section moved from tcontest.spacebarproc }
   // if (MainForm.NumberEdit.Text = '') and (SameExchange = True)then
   DispExchangeOnOtherBands;
   if CheckMulti.Visible then
      CheckMulti.Renew(CurrentQSO);
   { This section moved from tcontest.spacebarproc }

   if CheckCountry.Visible then
      CheckCountry.Renew(CurrentQSO);

   if dmZlogGlobal.Settings._multistation then begin
      if CheckCountry.Visible = False then
         CheckCountry.Renew(CurrentQSO);
      if CheckCountry.NotNewMulti(CurrentQSO.QSO.Band) then begin
         MainForm.WriteStatusLineRed('NOT a new multiplier. (This is a multi stn)', False);
         exit;
      end;
   end;

   MainForm.WriteStatusLine(MultiForm.GetInfo(CurrentQSO), False);
end;

procedure TWAEContest.SpaceBarProc;
var
   temp: string;
begin
   inherited;
   if CheckCountry.Visible then
      CheckCountry.Renew(CurrentQSO);

   if dmZlogGlobal.Settings._multistation then begin
      if CheckCountry.Visible = False then
         CheckCountry.Renew(CurrentQSO);
      if CheckCountry.NotNewMulti(CurrentQSO.QSO.Band) then begin
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
   S := S + FillRight(aQSO.QSO.Callsign, 12);
   S := S + FillRight(aQSO.QSO.NrRcvd, 4);
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
   TQSO(Log.List[0]).QSO.RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
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
      CurrentQSO.QSO.NrRcvd := temp;
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
      TQSO(Log.List[0]).QSO.RSTsent := _USEUTC
   else
      TQSO(Log.List[0]).QSO.RSTsent := UTCOffset;
   // UTC = $FFFF else UTC + x hrs;
   {
     UseUTC := True;
     TQSO(Log.List[0]).QSO.RSTSent := $FFFF; //JST = 0; UTC = $FFFF
   }
end;

constructor TALLJAContest.Create(N: string);
begin
   inherited;
   MultiForm := TALLJAMulti.Create(MainForm);
   ScoreForm := TALLJAScore.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);
end;

constructor TKCJContest.Create(N: string);
begin
   inherited;
   MultiForm := TKCJMulti.Create(MainForm);
   ScoreForm := TKCJScore.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);
end;

function TALLJAContest.QTHString: string;
begin
   Result := dmZlogGlobal.Settings._prov;
end;

function TKCJContest.QTHString: string;
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
   S := S + FillRight(aQSO.QSO.Callsign, 12);
   S := S + FillRight(aQSO.QSO.NrRcvd, 5);
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
   S := S + FillRight(aQSO.QSO.Callsign, 12);
   S := S + FillRight(aQSO.QSO.NrRcvd, 3);
   // S := S + FillRight(aQSO.ModeStr, 4);
   Result := S;
end;

function TFDContest.QTHString: string;
begin
   if CurrentQSO.QSO.Band <= b1200 then
      Result := dmZlogGlobal.Settings._prov
   else
      Result := dmZlogGlobal.Settings._city;
end;

function TSixDownContest.QTHString: string;
begin
   if CurrentQSO.QSO.Band <= b1200 then
      Result := dmZlogGlobal.Settings._prov
   else
      Result := dmZlogGlobal.Settings._city;
end;

constructor TACAGContest.Create(N: string);
begin
   inherited;
   MultiForm := TACAGMulti.Create(MainForm);
   ScoreForm := TACAGScore.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);
end;

constructor TFDContest.Create(N: string);
begin
   inherited;
   MultiForm := TFDMulti.Create(MainForm);
   ScoreForm := TACAGScore.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);
end;

constructor TSixDownContest.Create(N: string);
begin
   inherited;
   MultiForm := TSixDownMulti.Create(MainForm);
   ScoreForm := TSixDownScore.Create(MainForm);
   PastEditForm := TALLJAEditDialog.Create(MainForm);
end;

constructor TGeneralContest.Create(N, CFGFileName: string);
begin
   inherited Create(N);
   MultiForm := TGeneralMulti2.Create(MainForm);
   ScoreForm := TGeneralScore.Create(MainForm);
   TGeneralScore(ScoreForm).formMulti := TGeneralMulti2(MultiForm);
   TGeneralScore(ScoreForm).LoadCFG(CFGFileName);
   PastEditForm := TALLJAEditDialog.Create(MainForm);

   if SerialContestType = 0 then begin
      MainForm.EditScreen := TGeneralEdit.Create(MainForm);
   end
   else begin
      MainForm.EditScreen := TSerialGeneralEdit.Create(MainForm);
      TSerialGeneralEdit(MainForm.EditScreen).formMulti := TGeneralMulti2(MultiForm);
      TQSO(Log.List[0]).QSO.Serial := $01; // uses serial number
      SameExchange := False;
      dmZlogGlobal.Settings._sameexchange := SameExchange;
   end;
end;

procedure TGeneralContest.SetPoints(var aQSO: TQSO);
begin
   TGeneralScore(ScoreForm).CalcPoints(aQSO);
end;

constructor TBasicEdit.Create(AOwner: TComponent);
var
   i, j: integer;
begin
   Inherited Create();

   for i := 1 to MaxGridQSO do
      IndexArray[i] := 0;

   DispQSO := 0;
   DirectEdit := False;

   with MainForm.Grid do begin
      ColCount := 10;
      colSerial := -1;
      colTime := 1;
      colCall := -1;
      colrcvdRST := -1;
      colrcvdNumber := -1;
      colMode := -1;
      colPower := -1;
      colNewPower := -1;
      colBand := -1;
      colPoint := -1;
      colMemo := -1;
      colSerial := -1;
      colOp := -1;
      colNewMulti1 := -1;
      colNewMulti2 := -1;
      colsentRST := -1;
      colsentNumber := -1;
      colCQ := -1;
      // Align := alTop;
      FixedCols := 0;
      FixedRows := 1;
      ColCount := 10;
      Height := 291;
      DefaultRowHeight := 17;

      SerialWid := 4;
      TimeWid := 6;
      CallSignWid := 12;
      rcvdRSTWid := 4;
      NumberWid := 10;
      BandWid := 4;
      ModeWid := 4;
      NewPowerWid := 2;
      PointWid := 3;
      OpWid := 8;
      MemoWid := 10;
      NewMulti1Wid := 3;
      NewMulti2Wid := 0;
   end;

   MainForm.SerialEdit.Visible := False;
   MainForm.NewPowerEdit.Visible := False;
   MainForm.ModeEdit.Visible := True;

   for i := 1 to MainForm.Grid.RowCount - 1 do
      for j := 0 to MainForm.Grid.ColCount - 1 do
         MainForm.Grid.Cells[j, i] := '';
end;

procedure TBasicEdit.SetDirectEdit(Direct: boolean);
begin
   if Direct then begin
      MainForm.Grid.Options := MainForm.Grid.Options + [goEditing { , goAlwaysShowEditor } ];
      MainForm.Grid.Options := MainForm.Grid.Options - [goRowSelect];
      DirectEdit := True;
   end
   else begin
      MainForm.Grid.Options := MainForm.Grid.Options - [goEditing, goAlwaysShowEditor];
      MainForm.Grid.Options := MainForm.Grid.Options + [goRowSelect];
      DirectEdit := False;
   end;
end;

procedure TBasicEdit.Add(aQSO: TQSO);
var
   i: integer;
begin
   if MainForm.ShowCurrentBandOnly.Checked and (aQSO.QSO.Band <> CurrentQSO.QSO.Band) then begin
      Exit;
   end;

   with MainForm.Grid do begin

      inc(DispQSO);

      WriteQSO(DispQSO, aQSO);
      IndexArray[DispQSO] := Log.TotalQSO;

      i := DispQSO - VisibleRowCount;

      if (MainForm.Grid.Focused = False) and (aQSO.QSO.Reserve2 <> $AA) { local } then begin
         if i > 0 then
            TopRow := i + 1
         else
            TopRow := 1;
      end
      else begin // ver 2.0x
         if (aQSO.QSO.Reserve2 = $AA) { not local } and (MainForm.Grid.Focused = False) then begin
            if i > 0 then begin
               TopRow := i + 1; // ver 2.0x
            end;
         end;
      end;

      DefaultDrawing := True;

      RefreshScreen;
   end;
end;

Procedure TBasicEdit.WriteQSO(R: integer; aQSO: TQSO);
var
   temp: string;
begin
   with MainForm.Grid do begin
      if colSerial >= 0 then
         Cells[colSerial, R] := aQSO.SerialStr;
      if colTime >= 0 then
         Cells[colTime, R] := aQSO.TimeStr;
      if colCall >= 0 then
         Cells[colCall, R] := aQSO.QSO.Callsign;
      if colrcvdRST >= 0 then
         Cells[colrcvdRST, R] := aQSO.RSTStr;
      if colrcvdNumber >= 0 then
         Cells[colrcvdNumber, R] := aQSO.QSO.NrRcvd;
      if colBand >= 0 then
         Cells[colBand, R] := aQSO.BandStr;
      if colMode >= 0 then
         Cells[colMode, R] := aQSO.ModeStr;
      if colPower >= 0 then
         Cells[colPower, R] := aQSO.PowerStr;
      if colNewPower >= 0 then
         Cells[colNewPower, R] := aQSO.NewPowerStr;
      if colPoint >= 0 then
         Cells[colPoint, R] := aQSO.PointStr;
      if colOp >= 0 then begin
         temp := IntToStr(aQSO.QSO.TX);
         if dmZlogGlobal.Settings._multiop = 2 then begin
            case aQSO.QSO.TX of
               1:
                  temp := 'R';
               2:
                  temp := 'M';
            end;
         end;
         Cells[colOp, R] := temp + ' ' + aQSO.QSO.Operator;
      end;
      IntToStr(aQSO.QSO.Reserve3);

      if colNewMulti1 >= 0 then
         Cells[colNewMulti1, R] := GetNewMulti1(aQSO);

      if colMemo >= 0 then
         Cells[colMemo, R] := aQSO.QSO.Memo; // + IntToStr(aQSO.QSO.Reserve3);
      if aQSO.QSO.Reserve = actLock then
         Cells[colMemo, R] := 'locked';
   end;
end;

procedure TBasicEdit.RefreshScreen;
var
   i, j: integer;
begin
   with MainForm.Grid do begin
      for i := TopRow to TopRow + VisibleRowCount - 1 do begin
         if (i > RowCount - 1) or (i = 0) then begin
            exit;
         end;

         if (IndexArray[i] > 0) and (IndexArray[i] < Log.TotalQSO + 1) then begin
            WriteQSO(i, TQSO(Log.List[IndexArray[i]]));
         end
         else begin
            for j := 0 to ColCount - 1 do begin
               Cells[j, i] := '';
            end;
         end;
      end;
   end;
end;

procedure TBasicEdit.ResetTopRow;
var
   i: integer;
begin
   i := DispQSO - MainForm.Grid.VisibleRowCount + 1;
   if i > 0 then begin
      MainForm.Grid.TopRow := i;
   end
   else begin
      MainForm.Grid.TopRow := 1;
   end;
end;

procedure TBasicEdit.Renew;
var
   R: word;
   i, _row: integer;
begin
   for i := 1 to MaxGridQSO do begin
      IndexArray[i] := 0;
   end;

   DispQSO := 0;
   R := Log.TotalQSO;

   with MainForm.Grid do begin
      TopRow := 1;
      _row := Row;
      Enabled := False;

      for i := 1 to R do begin
         if MainForm.ShowCurrentBandOnly.Checked then begin
            if CurrentQSO.QSO.Band = TQSO(Log.List[i]).QSO.Band then begin
               inc(DispQSO);
               IndexArray[DispQSO] := i;
            end;
         end
         else begin
            inc(DispQSO);
            IndexArray[i] := i;
         end;
      end;

      Enabled := True;

      RefreshScreen; // this is not enough!!!!

      if _row > RowCount - 1 then
         Row := RowCount - 1
      else
         Row := _row;
      // Refresh;
   end;
end;

procedure TBasicEdit.SetGridWidth;
var
   i: Integer;
   nColWidth: Integer;
   nRowHeight: Integer;
begin
   with MainForm.Grid do begin

      nColWidth := Canvas.TextWidth('0') + 1;
      nRowHeight := Canvas.TextHeight('0') + 4;

      DefaultRowHeight := nRowHeight;

      if colSerial >= 0 then begin
         Cells[colSerial, 0] := 'serial';
         ColWidths[colSerial] := SerialWid * nColWidth;
      end;
      MainForm.SerialEdit.Tag := colSerial;

      if colTime >= 0 then begin
         Cells[colTime, 0] := 'time';
         ColWidths[colTime] := TimeWid * nColWidth;
      end;
      MainForm.TimeEdit.Tag := colTime;

      if colCall >= 0 then begin
         Cells[colCall, 0] := 'call';
         ColWidths[colCall] := CallSignWid * nColWidth;
      end;
      MainForm.CallsignEdit.Tag := colCall;

      if colrcvdRST >= 0 then begin
         Cells[colrcvdRST, 0] := 'RST';
         ColWidths[colrcvdRST] := rcvdRSTWid * nColWidth;
      end;
      MainForm.RcvdRSTEdit.Tag := colrcvdRST;

      if colrcvdNumber >= 0 then begin
         Cells[colrcvdNumber, 0] := 'rcvd';
         ColWidths[colrcvdNumber] := NumberWid * nColWidth;
      end;
      MainForm.NumberEdit.Tag := colrcvdNumber;

      if colBand >= 0 then begin
         Cells[colBand, 0] := 'band';
         ColWidths[colBand] := BandWid * nColWidth;
      end;
      MainForm.BandEdit.Tag := colBand;

      if colMode >= 0 then begin
         Cells[colMode, 0] := 'mod';
         ColWidths[colMode] := ModeWid * nColWidth;
      end;
      MainForm.ModeEdit.Tag := colMode;

      if colNewPower >= 0 then begin
         Cells[colNewPower, 0] := 'pwr';
         ColWidths[colNewPower] := NewPowerWid * nColWidth;
      end;
      MainForm.NewPowerEdit.Tag := colNewPower;

      if colPoint >= 0 then begin
         Cells[colPoint, 0] := 'pts';
         ColWidths[colPoint] := PointWid * nColWidth;
      end;
      MainForm.PointEdit.Tag := colPoint;

      if colNewMulti1 >= 0 then begin
         Cells[colNewMulti1, 0] := 'new';
         ColWidths[colNewMulti1] := NewMulti1Wid * nColWidth;
      end;

      if colNewMulti2 >= 0 then begin
         Cells[colNewMulti2, 0] := 'new';
         ColWidths[colNewMulti2] := NewMulti2Wid * nColWidth;
      end;

      if colOp >= 0 then begin
         Cells[colOp, 0] := 'op';
         ColWidths[colOp] := OpWid * nColWidth;
      end;
      MainForm.OpEdit.Tag := colOp;

      if colMemo >= 0 then begin
         Cells[colMemo, 0] := 'memo';
         ColWidths[colMemo] := MemoWid * nColWidth;
      end;
      MainForm.MemoEdit.Tag := colMemo;

      Refresh();
   end;
end;

function TBasicEdit.GetLeft(col: integer): integer;
var
   i, j: integer;
begin
   if col = 0 then begin
      Result := 0;
      exit;
   end;
   j := 0;
   for i := 0 to col - 1 do
      j := j + MainForm.Grid.ColWidths[i] + 1;
   Result := j;
end;

Procedure TBasicEdit.SetEditFields;
var
   h: Integer;
begin
   with MainForm do begin
      h := MainForm.Grid.RowHeights[0];
      EditPanel.Height := h + 10;

      if colSerial >= 0 then begin
         SerialEdit.Width := MainForm.Grid.ColWidths[colSerial];
         SerialEdit.Height := h;
         SerialEdit.Left := GetLeft(colSerial);
      end;
      if colTime >= 0 then begin
         TimeEdit.Width := MainForm.Grid.ColWidths[colTime];
         TimeEdit.Height := h;
         TimeEdit.Left := GetLeft(colTime);
         DateEdit.Width := TimeEdit.Width;
         DateEdit.Left := TimeEdit.Left;
      end;
      if colCall >= 0 then begin
         CallsignEdit.Width := MainForm.Grid.ColWidths[colCall];
         CallsignEdit.Height := h;
         CallsignEdit.Left := GetLeft(colCall);
      end;
      if colrcvdRST >= 0 then begin
         RcvdRSTEdit.Width := MainForm.Grid.ColWidths[colrcvdRST];
         RcvdRSTEdit.Height := h;
         RcvdRSTEdit.Left := GetLeft(colrcvdRST);
      end;
      if colrcvdNumber >= 0 then begin
         NumberEdit.Width := MainForm.Grid.ColWidths[colrcvdNumber];
         NumberEdit.Height := h;
         NumberEdit.Left := GetLeft(colrcvdNumber);
      end;
      if colBand >= 0 then begin
         BandEdit.Width := MainForm.Grid.ColWidths[colBand];
         BandEdit.Height := h;
         BandEdit.Left := GetLeft(colBand);
      end;
      if colMode >= 0 then begin
         ModeEdit.Width := MainForm.Grid.ColWidths[colMode];
         ModeEdit.Height := h;
         ModeEdit.Left := GetLeft(colMode);
      end;
      if colNewPower >= 0 then begin
         NewPowerEdit.Width := MainForm.Grid.ColWidths[colNewPower];
         NewPowerEdit.Height := h;
         NewPowerEdit.Left := GetLeft(colNewPower);
      end;
      if colPoint >= 0 then begin
         PointEdit.Width := MainForm.Grid.ColWidths[colPoint];
         PointEdit.Height := h;
         PointEdit.Left := GetLeft(colPoint);
      end;
      if colOp >= 0 then begin
         OpEdit.Width := MainForm.Grid.ColWidths[colOp];
         OpEdit.Height := h;
         OpEdit.Left := GetLeft(colOp);
      end;
      if colMemo >= 0 then begin
         MemoEdit.Left := GetLeft(colMemo);
         MemoEdit.Width := EditPanel.Width - MemoEdit.Left - 3;
         MemoEdit.Height := h;
      end;
   end;
end;

function TBasicEdit.GetNewMulti1(aQSO: TQSO): string;
begin
   if aQSO.QSO.NewMulti1 then
      Result := '*'
   else
      Result := '';
end;

constructor TGeneralEdit.Create;
begin
   inherited;

   colTime := 0;
   colCall := 1;
   colrcvdRST := 2;
   colrcvdNumber := 3;
   colBand := 4;
   colMode := 5;
   colPoint := 6;
   colNewMulti1 := 7;

   if Pos('$P', dmZlogGlobal.Settings._sentstr) > 0 then begin
      colNewPower := 8;
      colOp := 9;
      colMemo := 10;
      MainForm.Grid.ColCount := 11;
      MainForm.NewPowerEdit.Visible := True;
   end
   else begin
      colOp := 8;
      colMemo := 9;
      MainForm.Grid.ColCount := 10;
   end;

   if dmZlogGlobal.MultiOp > 0 then begin
      OpWid := 6;
      MemoWid := 7;
   end
   else begin
      OpWid := 0;
      MemoWid := 13;
      MainForm.OpEdit.Visible := False;
   end;

   SetGridWidth;
   SetEditFields;
end;

constructor TARRLDXEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

   colTime := 0;
   colCall := 1;
   colrcvdRST := 2;
   colrcvdNumber := 3;
   colBand := 4;
   colMode := 5;
   colPoint := 6;
   colNewMulti1 := 7;
   colPower := 8;
   colOp := 9;
   colMemo := 10;
   MainForm.Grid.ColCount := 11;
   if dmZlogGlobal.MultiOp > 0 then begin
      OpWid := 6;
      MemoWid := 7;
   end
   else begin
      OpWid := 0;
      MemoWid := 13;
      MainForm.OpEdit.Visible := False;
   end;

   NumberWid := 3;

   SetGridWidth;
   SetEditFields;
end;

constructor TWWEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   colTime := 0;
   colCall := 1;
   colrcvdRST := 2;
   colrcvdNumber := 3;
   colBand := 4;
   { colMode := 5; }
   { colPower := 6; }
   colPoint := 5;
   colNewMulti1 := 6;
   // colNewMulti2 := 7;
   colOp := 7;
   colMemo := 8;
   MainForm.Grid.ColCount := 9;
   MainForm.ModeEdit.Visible := False;
   NumberWid := 3;
   NewMulti1Wid := 6;

   if dmZlogGlobal.MultiOp > 0 then begin
      OpWid := 6;
      MemoWid := 10;
   end
   else begin
      OpWid := 0;
      MemoWid := 16;
      MainForm.OpEdit.Visible := False;
   end;

   SetGridWidth;
   SetEditFields;
end;

function TWWEdit.GetNewMulti1(aQSO: TQSO): string;
var
   str: string;
begin
   if aQSO.QSO.NewMulti1 then
      str := FillRight(aQSO.QSO.Multi1, 3)
   else
      str := '   ';
   if aQSO.QSO.NewMulti2 then
      str := str + aQSO.QSO.Multi2;
   Result := str;
end;

function TKCJEdit.GetNewMulti1(aQSO: TQSO): string;
var
   str: string;
begin
   if aQSO.QSO.NewMulti1 then
      str := aQSO.QSO.Multi1
   else
      str := '';
   Result := str;
end;

constructor TDXCCEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   colTime := 0;
   colCall := 1;
   colrcvdRST := 2;
   colrcvdNumber := 3;
   colBand := 4;
   { colMode := 5; }
   { colPower := 6; }
   colPoint := 5;
   colNewMulti1 := 6;
   colOp := 7;
   colMemo := 8;
   MainForm.Grid.ColCount := 9;
   MainForm.ModeEdit.Visible := False;

   NumberWid := 4;
   NewMulti1Wid := 5;

   if dmZlogGlobal.MultiOp > 0 then begin
      OpWid := 6;
      MemoWid := 10;
   end
   else begin
      OpWid := 0;
      MemoWid := 16;
      MainForm.OpEdit.Visible := False;
   end;

   SetGridWidth;
   SetEditFields;
end;

function TDXCCEdit.GetNewMulti1(aQSO: TQSO): string;
begin
   if aQSO.QSO.NewMulti1 then
      Result := aQSO.QSO.Multi1
   else
      Result := '';
end;

constructor TWPXEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   colSerial := 0;
   colTime := 1;
   colCall := 2;
   colrcvdRST := 3;
   colrcvdNumber := 4;
   colBand := 5;
   { colMode := 5; }
   { colPower := 6; }
   colPoint := 6;
   colNewMulti1 := 7;
   colOp := 8;
   colMemo := 9;

   SerialWid := 4;
   TimeWid := 4;
   CallSignWid := 8;
   rcvdRSTWid := 3;
   NumberWid := 4;
   BandWid := 3;
   PointWid := 2;
   OpWid := 6;
   MemoWid := 7;
   NewMulti1Wid := 5;

   MainForm.Grid.Cells[colNewMulti1, 0] := 'prefix';

   MainForm.Grid.ColCount := 10;
   MainForm.ModeEdit.Visible := False;
   MainForm.SerialEdit.Visible := True;
   if dmZlogGlobal.MultiOp > 0 then begin
      OpWid := 6;
      MemoWid := 10;
   end
   else begin
      OpWid := 0;
      MemoWid := 16;
      MainForm.OpEdit.Visible := False;
   end;

   SetGridWidth;
   SetEditFields;
end;

constructor TJA0Edit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   MainForm.Grid.ColCount := 11;

   colSerial := 0;
   colTime := 1;
   colCall := 2;
   colrcvdRST := 3;
   colrcvdNumber := 4;
   colBand := 5;
   colMode := 6;
   colPoint := 7;
   colNewMulti1 := 8;
   colOp := 9;
   colMemo := 10;

   MainForm.ModeEdit.Visible := True;
   MainForm.SerialEdit.Visible := True;
   if dmZlogGlobal.MultiOp > 0 then begin
      OpWid := 6;
      MemoWid := 10;
   end
   else begin
      OpWid := 0;
      MemoWid := 16;
      MainForm.OpEdit.Visible := False;
   end;

   SetGridWidth;
   SetEditFields;
end;

function TWPXEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   temp := '  ' + aQSO.QSO.Multi1;
   if aQSO.QSO.NewMulti1 then
      temp[1] := '*';
   Result := temp;
end;

constructor TSerialGeneralEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   colSerial := 0;
   colTime := 1;
   colCall := 2;
   colrcvdRST := 3;
   colrcvdNumber := 4;
   colBand := 5;
   colMode := 6;
   { colPower := 6; }
   colPoint := 7;
   colNewMulti1 := 8;
   colOp := 9;
   colMemo := 10;

   SerialWid := 4;
   TimeWid := 4;
   CallSignWid := 8;
   rcvdRSTWid := 3;
   NumberWid := 4;
   BandWid := 3;
   ModeWid := 3;
   PointWid := 2;
   OpWid := 6;
   MemoWid := 7;
   NewMulti1Wid := 5;

   MainForm.Grid.Cells[colNewMulti1, 0] := 'prefix';

   MainForm.Grid.ColCount := 11;
   MainForm.ModeEdit.Visible := True;
   MainForm.SerialEdit.Visible := True;
   if dmZlogGlobal.MultiOp > 0 then begin
      OpWid := 6;
      MemoWid := 7;
   end
   else begin
      OpWid := 0;
      MemoWid := 13;
      MainForm.OpEdit.Visible := False;
   end;

   SetGridWidth;
   SetEditFields;
end;

function TSerialGeneralEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   Result := '';
   if formMulti.PXMulti = 0 then begin
      if aQSO.QSO.NewMulti1 then
         Result := aQSO.QSO.Multi1;
   end
   else begin
      temp := '  ' + aQSO.QSO.Multi1;
      if aQSO.QSO.NewMulti1 then
         temp[1] := '*';
      Result := temp;
   end;
end;

constructor TIOTAEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   colSerial := 0;
   colTime := 1;
   colCall := 2;
   colrcvdRST := 3;
   colrcvdNumber := 4;
   colBand := 5;
   colMode := 6;
   { colPower := 6; }
   colPoint := 7;
   colNewMulti1 := 8;
   colOp := 9;
   colMemo := 10;

   SerialWid := 4;
   TimeWid := 4;
   CallSignWid := 8;
   rcvdRSTWid := 3;
   NumberWid := 6;
   BandWid := 3;
   ModeWid := 3;
   PointWid := 2;
   OpWid := 6;
   MemoWid := 7;
   NewMulti1Wid := 5;

   // MainForm.Grid.Cells[colNewMulti1,0] := '';

   MainForm.Grid.ColCount := 11;
   // MainForm.ModeEdit.Visible := False;
   MainForm.SerialEdit.Visible := True;
   if dmZlogGlobal.MultiOp > 0 then begin
      OpWid := 6;
      MemoWid := 5;
   end
   else begin
      OpWid := 0;
      MemoWid := 11;
      MainForm.OpEdit.Visible := False;
   end;

   SetGridWidth;
   SetEditFields;
end;

function TIOTAEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   // temp := '  '+aQSO.QSO.Multi1;
   if aQSO.QSO.NewMulti1 then
      temp := aQSO.QSO.Multi1;
   Result := temp;
end;

function TGeneralEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.QSO.NewMulti1 then
      temp := aQSO.QSO.Multi1
   else
      temp := '';
   Result := temp;
end;

constructor TALLJAEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOWner);

   colTime := 0;
   colCall := 1;
   colrcvdRST := 2;
   colrcvdNumber := 3;
   colBand := 4;
   colMode := 5;
   colPoint := 6;
   colNewMulti1 := 7;
   colNewPower := 8;
   colOp := 9;
   colMemo := 10;
   MainForm.Grid.ColCount := 11;
   MainForm.NewPowerEdit.Visible := True;
   if dmZlogGlobal.MultiOp > 0 then begin
      OpWid := 6;
      MemoWid := 7;
   end
   else begin
      OpWid := 0;
      MemoWid := 13;
      MainForm.OpEdit.Visible := False;
   end;

   SetGridWidth;
   SetEditFields;
end;

function TALLJAEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.QSO.NewMulti1 then
      temp := aQSO.QSO.Multi1
   else
      temp := '';
   Result := temp;
end;

constructor TIARUEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

   colTime := 0;
   colCall := 1;
   colrcvdRST := 2;
   colrcvdNumber := 3;
   colBand := 4;
   colMode := 5;
   colPoint := 6;
   colNewMulti1 := 7;
   // colNewPower := 8;
   colOp := 8;
   colMemo := 9;

   NumberWid := 4;
   BandWid := 3;
   NewMulti1Wid := 4;

   MainForm.Grid.ColCount := 10;
   // MainForm.NewPowerEdit.Visible := True;
   if dmZlogGlobal.MultiOp > 0 then begin
      OpWid := 6;
      MemoWid := 11;
   end
   else begin
      OpWid := 0;
      MemoWid := 17;
      MainForm.OpEdit.Visible := False;
   end;

   SetGridWidth;
   SetEditFields;
end;

function TIARUEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.QSO.NewMulti1 then
      temp := aQSO.QSO.Multi1
   else
      temp := '';
   Result := temp;
end;

function TARRLDXEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.QSO.NewMulti1 then
      temp := aQSO.QSO.Multi1
   else
      temp := '';
   Result := temp;
end;

function TACAGEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.QSO.NewMulti1 then
      temp := '*'
   else
      temp := '';
   Result := temp;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
   i, j, mSec: integer;
   M: TMenuItem;
   S, ss: string;
begin
   if GetAsyncKeyState(VK_SHIFT) < 0 then begin
      DEBUGMODE := True;
   end;

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
   Application.OnHint := ShowHint;

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
         dmZLogKeyer.InitializeBGK(mSec);
      end;
   end;

   RenewCWToolBar;
   LastFocus := CallsignEdit; { the place to set focus when ESC is pressed from Grid }

   CurrentQSO := TQSO.Create;
   Randomize;
   GLOBALSERIAL := Random10 * 1000; // for qso id

   with CurrentQSO.QSO do begin
      NrSent := '';
      mode := mCW;
      Band := b7;

      Operator := '';
      TX := dmZlogGlobal.TXNr;
      Reserve3 := NewQSOID;
   end;

   NumberEdit.Text := '';
   BandEdit.Text := MHzString[CurrentQSO.QSO.Band];
   NewPowerEdit.Text := NewPowerString[CurrentQSO.QSO.Power];
   PointEdit.Text := CurrentQSO.PointStr;
   RcvdRSTEdit.Text := CurrentQSO.RSTStr;
   CurrentQSO.UpdateTime;
   TimeEdit.Text := CurrentQSO.TimeStr;
   DateEdit.Text := CurrentQSO.DateStr;

   if dmZlogGlobal.Settings._backuppath = '' then begin
      Backup1.Enabled := False;
   end;

   if dmZlogGlobal.OpList.Count > 0 then begin
      for i := 0 to dmZlogGlobal.OpList.Count - 1 do begin
         M := TMenuItem.Create(Self);
         M.Caption := TrimRight(copy(dmZlogGlobal.OpList.Strings[i], 1, 20));
         M.OnClick := OpMenuClick;
         OpMenu.Items.Add(M);
         { M.Free; }
      end;
   end;

   FQuickRef := TQuickRef.Create(Self);

   TempQSOList := TList.Create;

   RestoreWindowsPos();

   dmZLogKeyer.ControlPTT(False);
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

   { Add code to create a new file }
   PostMessage(Handle, WM_ZLOG_INIT, 0, 0);
end;

procedure TMainForm.FileOpen(Sender: TObject);
begin
   OpenDialog.Title := 'Open file';

   OpenDialog.InitialDir := dmZlogGlobal.Settings._logspath;

   if OpenDialog.Execute then begin
      WriteStatusLine('Loading...', False);
      dmZLogGlobal.SetLogFileName(OpenDialog.filename);
      LoadNewContestFromFile(OpenDialog.filename);
      MyContest.Renew;
      WriteStatusLine('', False);
      SetWindowCaption();
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

function ExecuteFile(const filename, Params, DefaultDir: string; ShowCmd: integer): THandle;
var
   zFileName, zParams, zDir: array [0 .. 79] of Char;
begin
   Result := ShellExecute(MainForm.Handle, nil, StrPCopy(zFileName, filename), StrPCopy(zParams, Params), StrPCopy(zDir, DefaultDir), ShowCmd);
end;

procedure TMainForm.FilePrint(Sender: TObject);
var
   R: integer;
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
   X: integer;
begin
   dmZlogGlobal.ReadWindowState(CheckCall2);
   dmZlogGlobal.ReadWindowState(PartialCheck);
   dmZlogGlobal.ReadWindowState(SuperCheck);
   dmZlogGlobal.ReadWindowState(CheckMulti);
   dmZlogGlobal.ReadWindowState(CWKeyBoard);
   dmZlogGlobal.ReadWindowState(RigControl, '', True);
   dmZlogGlobal.ReadWindowState(BandScope2);
   dmZlogGlobal.ReadWindowState(ChatForm);
   dmZlogGlobal.ReadWindowState(FreqList);
   dmZlogGlobal.ReadWindowState(CommForm);
   dmZlogGlobal.ReadWindowState(ScratchSheet);

   X := dmZlogGlobal.SuperCheckColumns;
   SuperCheck.ListBox.Columns := X;
   SuperCheck.SpinEdit.Value := X;
end;

procedure TMainForm.RecordWindowStates;
begin
   dmZlogGlobal.WriteWindowState(CheckCall2);
   dmZlogGlobal.WriteWindowState(PartialCheck);
   dmZlogGlobal.WriteWindowState(SuperCheck);
   dmZlogGlobal.WriteWindowState(CheckMulti);
   dmZlogGlobal.WriteWindowState(CWKeyBoard);
   dmZlogGlobal.WriteWindowState(RigControl);
   dmZlogGlobal.WriteWindowState(BandScope2);
   dmZlogGlobal.WriteWindowState(ChatForm);
   dmZlogGlobal.WriteWindowState(FreqList);
   dmZlogGlobal.WriteWindowState(CommForm);
   dmZlogGlobal.WriteWindowState(ScratchSheet);

   dmZlogGlobal.WriteMainFormState(Left, top, Width, Height, mnHideCWPhToolBar.Checked, mnHideMenuToolbar.Checked);
   dmZlogGlobal.SuperCheckColumns := SuperCheck.ListBox.Columns;
end;

procedure TMainForm.FileExit(Sender: TObject);
begin
   Close();
end;

procedure TMainForm.EditUndo(Sender: TObject);
begin
   { Add code to perform Edit Undo }
end;

procedure TMainForm.EditCut(Sender: TObject);
begin
   { Add code to perform Edit Cut }
end;

procedure TMainForm.EditCopy(Sender: TObject);
begin
   { Add code to perform Edit Copy }
end;

procedure TMainForm.EditPaste(Sender: TObject);
begin
   { Add code to perform Edit Paste }
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

procedure TMainForm.ConsoleRigBandSet(B: TBand);
var
   Q: TQSO;
begin
   Q := TQSO.Create;
   Q.QSO.Band := B;

   if RigControl.Rig <> nil then begin
      RigControl.Rig.SetBand(Q);

      if CurrentQSO.QSO.mode = mSSB then begin
         RigControl.Rig.SetMode(CurrentQSO);
      end;

      RigControl.SetBandMask; // ver 1.9z
   end;

   UpdateBand(Q.QSO.Band);

   Q.Free;
end;

procedure TMainForm.ProcessConsoleCommand(S: string);
var
   i: double;
   j: integer;
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
         ZLinkForm.PostWanted(CurrentQSO.QSO.Band, temp);
         MyContest.PostWanted(IntToStr(Ord(CurrentQSO.QSO.Band)) + ' ' + temp);
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

         ZLinkForm.DelWanted(CurrentQSO.QSO.Band, temp);
         MyContest.DelWanted(IntToStr(Ord(CurrentQSO.QSO.Band)) + ' ' + temp);
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
      if TTYConsole <> nil then begin
         TTYConsole.Show;
      end;
   end;

   if S = 'MMTTY' then begin
      mnMMTTY.Tag := 1;
      mnMMTTY.Caption := 'Exit MMTTY';
      mnTTYConsole.Visible := True;
      Application.CreateForm(TTTYConsole, TTYConsole);
      TTYConsole.SetTTYMode(ttyMMTTY);
      InitializeMMTTY(Handle);
   end;

   if S = 'OP' then begin
      for j := 1 to OpMenu.Items.Count - 1 do begin
         ConsolePad.AddLine(FillRight(OpMenu.Items[j].Caption, 15) + FillLeft(IntToStr(Log.OpQSO(temp2)), 5));
      end;
      ConsolePad.AddLine('');
   end;

   if (S = 'DELDUPES') or (S = 'DELDUPE') then begin
      Log.RemoveDupes;
      MyContest.Renew;
   end;

   if S = 'EXITMMTTY' then begin
      TTYConsole.close;
      TTYConsole.Destroy;
      ExitMMTTY;
   end;

   if S = 'MMCLR' then begin
      MMTTYBuffer := '';
   end;

   if S = 'SF' then begin
      ZLinkForm.SendRigStatus;
   end;

   if S = 'CQ' then begin
      SetCQ(True);
   end;

   if S = 'SP' then begin
      SetCQ(False);
   end;

   if S = 'CQ?' then begin
      if CurrentQSO.QSO.CQ then
         WriteStatusLine('CQ status : CQ', False)
      else
         WriteStatusLine('CQ status : SP', False);
   end;

   if (S = 'MUL') or (S = 'MULTI') or (S = 'MULT') then begin
      dmZlogGlobal.Settings._multistation := True;
      dmZlogGlobal.TXNr := 2;
      CurrentQSO.QSO.TX := dmZlogGlobal.TXNr;
      WriteStatusLine('Multi station', True);

      if SerialEdit.Visible then
         if (dmZlogGlobal.Settings._syncserial) and (SerialContestType = SER_MS) then begin
            CurrentQSO.QSO.Serial := SerialArrayTX[CurrentQSO.QSO.TX];
            SerialEdit.Text := CurrentQSO.SerialStr;
         end;

      SetWindowCaption();
      ReEvaluateCountDownTimer;
      ReEvaluateQSYCount;
   end;

   if S = 'RUN' then begin
      dmZlogGlobal.Settings._multistation := False;
      dmZlogGlobal.TXNr := 1;
      CurrentQSO.QSO.TX := dmZlogGlobal.TXNr;
      WriteStatusLine('Running station', True);

      if SerialEdit.Visible then
         if (dmZlogGlobal.Settings._syncserial) and (SerialContestType = SER_MS) then begin
            CurrentQSO.QSO.Serial := SerialArrayTX[CurrentQSO.QSO.TX];
            SerialEdit.Text := CurrentQSO.SerialStr;
         end;

      SetWindowCaption();
      ReEvaluateCountDownTimer;
      ReEvaluateQSYCount;
   end;

   if S = 'SERIALTYPE' then begin
      WriteStatusLine('SerialContestType = ' + IntToStr(SerialContestType), True);
   end;

   if S = 'TUNE' then begin
      CtrlZCQLoop := True;
      dmZLogKeyer.TuneOn;
   end;

   if (S = 'LF') or (S = 'LASTF') then
      if RigControl.Rig <> nil then
         RigControl.Rig.MoveToLastFreq;

   if S = 'TV' then
      if RigControl.Rig <> nil then
         RigControl.Rig.ToggleVFO;

   if S = 'VA' then
      if RigControl.Rig <> nil then
         RigControl.Rig.SetVFO(0);

   if S = 'VB' then
      if RigControl.Rig <> nil then
         RigControl.Rig.SetVFO(1);

   if S = 'RC' then
      if RigControl.Rig <> nil then
         RigControl.Rig.RitClear;

   if S = 'YAESUTEST' then
      if RigControl.Rig <> nil then
         RigControl.Rig.FILO := not(RigControl.Rig.FILO);

   if S = 'SC' then
      SuperCheckButtonClick(Self);

   if S = 'RESET' then
      if RigControl.Rig <> nil then
         RigControl.Rig.reset;

   if S = 'R1' then
      RigControl.SetCurrentRig(1);

   if S = 'R2' then
      RigControl.SetCurrentRig(2);

   if Pos('R', S) = 1 then
      if length(S) = 2 then begin
         case S[2] of
            '3' .. '9':
               RigControl.SetCurrentRig(Ord(S[2]) - Ord('0'));
         end;
      end;

   if S = 'TR' then begin
      RigControl.ToggleCurrentRig;
   end;

   if Pos('MAXRIG', S) = 1 then begin
      if length(temp) = 6 then
         WriteStatusLine('MAXRIG = ' + IntToStr(RigControl._maxrig), True)
      else begin
         Delete(temp, 1, 6);
         temp := TrimRight(temp);
         try
            j := StrToInt(temp);
         except
            on EConvertError do
               exit;
         end;
         if (j >= 2) and (j <= 9) then
            RigControl._maxrig := j;
         WriteStatusLine('MAXRIG set to ' + IntToStr(j), True)
      end;
   end;

   if Pos('TXNR', S) = 1 then begin
      if length(temp) = 4 then
         WriteStatusLine('TX# = ' + IntToStr(dmZlogGlobal.Settings._txnr), True)
      else begin
         Delete(temp, 1, 4);
         temp := TrimRight(temp);
         try
            j := StrToInt(temp);
         except
            on EConvertError do
               exit;
         end;
         if (j >= 0) and (j <= 99) then begin
            dmZlogGlobal.TXNr := j;
         end;

         CurrentQSO.QSO.TX := dmZlogGlobal.TXNr;
         WriteStatusLine('TX# set to ' + IntToStr(dmZlogGlobal.Settings._txnr), True);
         ReEvaluateQSYCount;
      end;
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
         ChatForm.PCNameSet := True;
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

   // if (S = 'VOICEON') then
   // begin
   // SetVoiceFlag(1);
   // end;
   //
   // if (S = 'VOICEOFF') then
   // begin
   // SetVoiceFlag(0);
   // end;

   if (S = 'TEST2') then begin
      BandScope2.MarkCurrentFreq(7060000);
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
   end;

   i := StrToFloatDef(S, 0);

   if (i > 1799) and (i < 1000000) then begin
      if RigControl.Rig <> nil then begin
         RigControl.Rig.SetFreq(round(i * 1000));
         if CurrentQSO.QSO.mode = mSSB then
            RigControl.Rig.SetMode(CurrentQSO);
         // ZLinkForm.SendRigStatus;
         ZLinkForm.SendFreqInfo(round(i * 1000));
      end
      else begin
         RigControl.TempFreq[CurrentQSO.QSO.Band] := i;
         ZLinkForm.SendFreqInfo(round(i * 1000));
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
end;

procedure TMainForm.CommonEditKeyProcess(Sender: TObject; var Key: Char);
var
   E: TEdit;
   i: integer;
   str: string;
begin
   E := TEdit(Sender);

   case Key of
      ^A: begin
         E.SelStart := 0;
         E.SelLength := 0;
         Key := #0;
      end;

      ^E: begin
         E.SelStart := length(E.Text);
         E.SelLength := 0;
         Key := #0;
      end;

      ^B: begin
         i := E.SelStart;
         if i > 0 then
            E.SelStart := i - 1;
         Key := #0;
      end;

      ^f: begin
         i := E.SelStart;
         if i < length(E.Text) then
            E.SelStart := i + 1;
         Key := #0;
      end;

      ^H: begin
         Key := Chr($08);
      end;

      ^D: begin
         i := E.SelStart;
         str := E.Text;
         if i < length(E.Text) then
            Delete(str, i + 1, 1);
         E.Text := str;
         E.SelStart := i;
         Key := #0;
      end;

      ^j: begin
         i := E.SelStart;
         str := E.Text;
         str := copy(str, 1, i);
         E.Text := str;
         E.SelStart := length(str);
         Key := #0;
      end;
   end;
end;

procedure TMainForm.IncFontSize();
var
   j: integer;
begin
   j := EditPanel.Font.Size;
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
   j: integer;
begin
   j := EditPanel.Font.Size;
   if j > 9 then begin
      Dec(j);
   end
   else begin
      j := 21;
   end;

   SetFontSize(j);
end;

procedure TMainForm.SetFontSize(font_size: Integer);
begin
   EditPanel.Font.Size := font_size;
   Grid.Font.Size := font_size;
   Grid.Refresh();

   dmZlogGlobal.Settings._mainfontsize := font_size;
   dmZlogGlobal.SaveCurrentSettings();

   PostMessage(Handle, WM_ZLOG_SETGRIDCOL, 0, 0);
end;

procedure TMainForm.SwitchCWBank(Action: integer); // 0 : toggle; 1,2 bank#)
var
   j: integer;
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
      j := clGreen;
      WriteStatusLine('CW Bank A', False)
   end
   else begin
      j := clMaroon;
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
   CWF1.FaceColor := j;
   CWF2.FaceColor := j;
   CWF3.FaceColor := j;
   CWF4.FaceColor := j;
   CWF5.FaceColor := j;
   CWF6.FaceColor := j;
   CWF7.FaceColor := j;
   CWF8.FaceColor := j;
end;

procedure TMainForm.EditKeyPress(Sender: TObject; var Key: Char);
var
   Q: TQSO;
begin
   CommonEditKeyProcess(Sender, Key);

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
      '@': begin
         MyContest.MultiForm.SelectAndAddNewPrefix(CurrentQSO.QSO.Callsign);
         Key := #0;
      end;

      '\': begin
         dmZLogKeyer.ControlPTT(not(dmZLogKeyer.PTTIsOn)); // toggle PTT;
         Key := #0;
      end;

      'X', 'x': begin
         if GetAsyncKeyState(VK_SHIFT) < 0 then begin
            RigControl.ToggleCurrentRig;
            Key := #0;
         end;
      end;

      '!': begin
         ToggleFixedSpeed;
         Key := #0;
      end;

      '-': begin // up key
         ToggleFixedSpeed;
         Key := #0;
      end;

      'V', 'v': begin
         if GetAsyncKeyState(VK_SHIFT) < 0 then begin
            if RigControl.Rig <> nil then
               RigControl.Rig.ToggleVFO;
            Key := #0;
         end;
      end;

      ^i: begin
         if PartialCheck.Visible then begin
            if PartialCheck.HitNumber > 0 then
               CallsignEdit.Text := PartialCheck.HitCall
            else if SuperCheck.Visible then
               if SuperCheck.HitNumber > 0 then
                  CallsignEdit.Text := SuperCheck.HitCall;
         end
         else begin // partial check is not visible
            if SuperCheck.Visible then
               if SuperCheck.HitNumber > 0 then
                  CallsignEdit.Text := SuperCheck.HitCall;
         end;
         Key := #0;
      end;

      '+', ';': begin
         DownKeyPress;
         Key := #0;
      end;

      ^O: begin
         CurrentQSO.DecTime;
         TimeEdit.Text := CurrentQSO.TimeStr;
         DateEdit.Text := CurrentQSO.DateStr;
         Key := #0;
      end;

      ^P: begin
         CurrentQSO.IncTime;
         TimeEdit.Text := CurrentQSO.TimeStr;
         DateEdit.Text := CurrentQSO.DateStr;
         Key := #0;
      end;

      ^W: begin
         TEdit(Sender).Clear;
         WriteStatusLine('', False);
         Key := #0;
      end;

      ^R: begin
         dmZlogGlobal.ReversePaddle;
         Key := #0;
      end;

      ^K: begin
         EditedSinceTABPressed := tabstate_normal;
         CallsignEdit.Clear;
         NumberEdit.Clear;
         MemoEdit.Clear;
         Key := #0;
         CallsignEdit.SetFocus;
         WriteStatusLine('', False);
      end;

      'Z', 'z': begin
         if GetAsyncKeyState(VK_SHIFT) < 0 then begin
            if CurrentQSO.QSO.mode = mCW then begin
               CQRepeatClick1(Sender);
            end
            else begin
               // CQRepeatVoice1Click(Sender);
            end;
            Key := #0;
         end;
      end;

      ^Z: begin
         if CurrentQSO.QSO.mode = mCW then
            CQRepeatClick2(Sender)
         else
            // CQRepeatVoice2Click(Sender);
            Key := #0;
      end;

      ^T: begin
         CtrlZCQLoop := True;
         dmZLogKeyer.TuneOn;
      end;

      Char($1B): { ESC } begin
         CWStopButtonClick(Self);
         // VoiceStopButtonClick(Self);
         Key := #0;
      end;

      ' ': begin
         if (TEdit(Sender).Name = 'NumberEdit') or (TEdit(Sender).Name = 'TimeEdit') or (TEdit(Sender).Name = 'DateEdit') then begin
            Key := #0;
            if FPostContest and (TEdit(Sender).Name = 'NumberEdit') then begin
               if TimeEdit.Visible then
                  TimeEdit.SetFocus;
               if DateEdit.Visible then
                  DateEdit.SetFocus;
            end
            else
               CallsignEdit.SetFocus;
         end
         else begin { if space is pressed when Callsign edit is in focus }
            Key := #0;

            Q := Log.QuickDupe(CurrentQSO);
            if Q <> nil then begin
               MessageBeep(0);
               if dmZLogGlobal.Settings._allowdupe = True then begin
                  WriteStatusLineRed(Q.PartialSummary(dmZlogGlobal.Settings._displaydatepartialcheck), True);
                  NumberEdit.SetFocus;
                  exit;
               end;
               CallsignEdit.SelectAll;
               WriteStatusLineRed(Q.PartialSummary(dmZlogGlobal.Settings._displaydatepartialcheck), True);
               exit;
            end
            else begin { if not dupe }
               MyContest.SpaceBarProc;
            end;

            NumberEdit.SetFocus;
         end;
      end;

      'Y', 'y': begin
         if GetAsyncKeyState(VK_SHIFT) < 0 then begin
            IncCWSpeed;
            Key := #0;
         end;
      end;

      'F', 'f': begin
         if GetAsyncKeyState(VK_SHIFT) < 0 then begin
            SwitchCWBank(0);
            Key := #0;
         end;
      end;

      'T', 't': begin
         if GetAsyncKeyState(VK_SHIFT) < 0 then begin
            CurrentQSO.UpdateTime;
            TimeEdit.Text := CurrentQSO.TimeStr;
            DateEdit.Text := CurrentQSO.DateStr;
            Key := #0;
         end;
      end;

      'U', 'u': begin
         if GetAsyncKeyState(VK_SHIFT) < 0 then begin
            DecCWSpeed;
            Key := #0;
         end;
      end;

      'B', 'b': begin
         if GetAsyncKeyState(VK_SHIFT) < 0 then begin
            MyContest.ChangeBand(True);
            Key := #0;
         end;
      end;

      'R', 'r': begin
         if GetAsyncKeyState(VK_SHIFT) < 0 then begin
            SetR(CurrentQSO);
            RcvdRSTEdit.Text := CurrentQSO.RSTStr;
            Key := #0;
         end;
      end;

      'S', 's': begin
         if GetAsyncKeyState(VK_SHIFT) < 0 then begin
            SetS(CurrentQSO);
            RcvdRSTEdit.Text := CurrentQSO.RSTStr;
            Key := #0;
         end;
      end;

      'M', 'm': begin
         if GetAsyncKeyState(VK_SHIFT) < 0 then begin
            MyContest.ChangeMode;
            Key := #0;
         end;
      end;

      'P', 'p': begin
         if GetAsyncKeyState(VK_SHIFT) < 0 then begin
            MyContest.ChangePower;
            Key := #0;
         end;
      end;

      // Enter / SHIFT+Enter
      Char($0D): begin
         if CallsignEdit.Focused and (Pos(',', CallsignEdit.Text) = 1) then begin
            ProcessConsoleCommand(CallsignEdit.Text);
            CallsignEdit.Text := '';
         end
         else begin
            if GetAsyncKeyState(VK_SHIFT) < 0 then begin
               CurrentQSO.QSO.Reserve2 := $FF;
            end;

            LogButtonClick(Self);
         end;
         Key := #0;
      end;
   end;
   { of case }
end;

procedure TMainForm.CallsignEditChange(Sender: TObject);
begin
   CurrentQSO.QSO.Callsign := CallsignEdit.Text;

   dmZLogKeyer.SetCallSign(CallsignEdit.Text);

   if EditedSinceTABPressed = tabstate_tabpressedbutnotedited then begin
      EditedSinceTABPressed := tabstate_tabpressedandedited;
   end;

   if PartialCheck.Visible and PartialCheck._CheckCall then begin
      PartialCheck.CheckPartial(CurrentQSO);
   end;

   if SuperCheck.Visible then begin
      SuperCheck.CheckSuper(CurrentQSO);
   end;

   if CheckCall2.Visible then begin
      CheckCall2.Renew(CurrentQSO);
   end;
end;

procedure TMainForm.NumberEditChange(Sender: TObject);
begin
   CurrentQSO.QSO.NrRcvd := NumberEdit.Text;
end;

procedure TMainForm.BandEditClick(Sender: TObject);
begin
   BandMenu.Popup(Left + BandEdit.Left + 20, Top + EditPanel.top + BandEdit.top);
end;

procedure TMainForm.ModeMenuClick(Sender: TObject);
begin
   QSY(CurrentQSO.QSO.Band, TMode(TMenuItem(Sender).Tag));
   LastFocus.SetFocus;
end;

procedure TMainForm.MemoEditChange(Sender: TObject);
begin
   CurrentQSO.QSO.Memo := MemoEdit.Text;
end;

procedure TMainForm.ModeEditClick(Sender: TObject);
begin
   ModeMenu.Popup(Left + ModeEdit.Left + 20, Top + EditPanel.top + ModeEdit.top);
end;

procedure TMainForm.GridMenuPopup(Sender: TObject);
var
   i: integer;
   M: TMenuItem;
begin
   SendSpot1.Enabled := CommForm.MaybeConnected;

   mChangePower.Visible := NewPowerEdit.Visible;

   for i := 0 to Ord(HiBand) do begin
      GBand.Items[i].Visible := BandMenu.Items[i].Visible;
      GBand.Items[i].Enabled := BandMenu.Items[i].Enabled;
   end;

   for i := 1 to GOperator.Count do
      GOperator.Delete(0);

   if dmZlogGlobal.OpList.Count > 0 then begin
      M := TMenuItem.Create(Self);
      M.Caption := 'Clear';
      M.OnClick := GridOperatorClick;
      GOperator.Add(M);
      for i := 0 to dmZlogGlobal.OpList.Count - 1 do begin
         M := TMenuItem.Create(Self);
         M.Caption := dmZlogGlobal.OpList.Strings[i];
         M.OnClick := GridOperatorClick;
         GOperator.Add(M);
      end;
   end;

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
   f: file of TQSOdata;
   D: TQSOdata;
   Q: TQSO;
   i: word;
   boo, Boo2: boolean;
begin
   { Log.Free; }
   Q := TQSO.Create;

   Q.QSO := TQSO(Log.List[0]).QSO;
   boo := Log.AcceptDifferentMode;
   Boo2 := Log.CountHigherPoints;

   dmZLogGlobal.CreateLog();

   Log.AcceptDifferentMode := boo;
   Log.CountHigherPoints := Boo2;

   TQSO(Log.List[0]).QSO := Q.QSO; // contest info is set to current contest.

   System.assign(f, filename);
   reset(f);
   read(f, D);
   { if D.memo = 'ALLJA' then }

   { MyContest.Free;
     MyContest := TALLJAContest.Create; }

   GLOBALSERIAL := 0;

   for i := 1 to FileSize(f) - 1 do begin
      read(f, D);
      Q.QSO := D;
      if Q.QSO.Reserve3 = 0 then
         Q.QSO.Reserve3 := NewQSOID;
      Log.Add(Q);
   end;

   GLOBALSERIAL := (Q.QSO.Reserve3 div 10000) mod 10000;

   System.close(f);

   CurrentQSO.QSO := Q.QSO;
   CurrentQSO.QSO.Band := Q.QSO.Band;
   CurrentQSO.QSO.mode := Q.QSO.mode;
   CurrentQSO.QSO.Callsign := '';
   CurrentQSO.QSO.NrRcvd := '';
   CurrentQSO.QSO.Time := Date + Time;
   CurrentQSO.QSO.TX := dmZlogGlobal.TXNr;
   CurrentQSO.QSO.Serial := Q.QSO.Serial;
   CurrentQSO.QSO.Memo := '';

   inc(CurrentQSO.QSO.Serial);

   // inc(SerialArray[CurrentQSO.QSO.Band]);
   SerialArray[CurrentQSO.QSO.Band] := CurrentQSO.QSO.Serial;

   SerialEdit.Text := CurrentQSO.SerialStr;
   TimeEdit.Text := CurrentQSO.TimeStr;
   DateEdit.Text := CurrentQSO.DateStr;
   CallsignEdit.Text := CurrentQSO.QSO.Callsign;
   RcvdRSTEdit.Text := CurrentQSO.RSTStr;
   NumberEdit.Text := CurrentQSO.QSO.NrRcvd;
   ModeEdit.Text := CurrentQSO.ModeStr;
   BandEdit.Text := CurrentQSO.BandStr;
   NewPowerEdit.Text := CurrentQSO.NewPowerStr;
   PointEdit.Text := CurrentQSO.PointStr;
   OpEdit.Text := CurrentQSO.QSO.Operator;
   { CallsignEdit.SetFocus; }
   WriteStatusLine('', False);
   Q.Free;
   Log.Saved := True;
end;

Procedure TMainForm.DeleteCurrentRow;
var
   R: integer;
begin
   { ZLinkForm.DeleteQSO(TQSO(Log.List[Grid.Row]));
     Log.Delete(Grid.Row);
     MyContest.Renew; }
   R := EditScreen.IndexArray[Grid.Row];
   if (R > 0) and (R <= Log.TotalQSO) then begin
      ZLinkForm.DeleteQSO(TQSO(Log.List[R]));
      Log.Delete(R);
      MyContest.Renew;
      Dec(EditScreen.DispQSO);
   end;
end;

Procedure TMainForm.MultipleDelete(A, B: LongInt);
var
   i, j: LongInt;
begin
   for i := B downto A do begin
      j := EditScreen.IndexArray[i];
      if TQSO(Log.List[j]).QSO.Reserve = actLock then begin
      end
      else begin
         if (j > 0) and (j <= Log.TotalQSO) then begin
            ZLinkForm.DeleteQSO(TQSO(Log.List[j]));
            Log.Delete(j);
            Dec(EditScreen.DispQSO);
         end;
      end;
   end;
   MyContest.Renew;
end;

procedure TMainForm.DeleteQSO1Click(Sender: TObject);
var
   _top, _bottom, _oldtop: LongInt;
   R: word;
begin
   with Grid do begin
      _oldtop := TopRow;
      _top := Selection.top;
      _bottom := Selection.Bottom;
   end;
   if _top = _bottom then begin
      if TQSO(Log.List[EditScreen.IndexArray[_top]]).QSO.Reserve = actLock then begin
         WriteStatusLine('This QSO is currently locked', True);
         exit;
      end;
      R := MessageDlg('Are you sure to delete this QSO?', mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
      if R = mrNo then
         exit;
      DeleteCurrentRow
   end
   else begin
      if (_top < Log.TotalQSO) and (_bottom <= Log.TotalQSO) then begin
         R := MessageDlg('Are you sure to delete these QSO''s?', mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
         if R = mrNo then
            exit;
         // if ShowCurrentBandOnly.Checked = False then
         MultipleDelete(_top, _bottom);
         { else
           begin
           end; }
      end;
   end;
   // Grid.TopRow := _oldtop;
   EditScreen.RefreshScreen;
end;

procedure TMainForm.GridKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
   case Key of
      VK_DELETE: begin
            DeleteQSO1Click(Self);
            Grid.SetFocus;
         end;
      VK_INSERT: begin
            InsertQSO1Click(Self);
            Grid.SetFocus;
         end;
      VK_RETURN:
         if EditScreen.DirectEdit = False then
            MyContest.EditCurrentRow;
      VK_ESCAPE: begin
            if EditScreen.DirectEdit then begin
               if Grid.EditorMode then begin
                  Grid.Cells[Grid.col, Grid.Row] := EditScreen.BeforeEdit;
                  Grid.EditorMode := False;
               end
               else begin
                  Grid.LeftCol := 0;
                  EditScreen.ResetTopRow;
                  LastFocus.SetFocus;
               end;
            end
            else begin
               Grid.LeftCol := 0;
               EditScreen.ResetTopRow;
               LastFocus.SetFocus;
            end;
         end;
   end;
end;

procedure TMainForm.EditQSOClick(Sender: TObject);
begin
   MyContest.EditCurrentRow;
end;

procedure TMainForm.OnTabPress;
var
   S: ShortString;
   Q: TQSO;
begin
   { not dupe }
   if Main.CurrentQSO.QSO.mode in [mSSB, mFM, mAM] then begin
      Q := Log.QuickDupe(CurrentQSO);
      if Q <> nil then begin
         WriteStatusLineRed(Q.PartialSummary(dmZlogGlobal.Settings._displaydatepartialcheck), True);
         CallsignEdit.SelectAll;
         CallsignEdit.SetFocus;
         // SendVoice(4);
         exit;
      end;

      MyContest.SpaceBarProc;
      NumberEdit.SetFocus;
      // SendVoice(2);
      exit;
   end;

   if Main.CurrentQSO.QSO.mode = mRTTY then begin
      TabPressed := True;
      if TTYConsole <> nil then
         TTYConsole.SendStrNow(SetStrNoAbbrev(dmZlogGlobal.CWMessage(3, 2), CurrentQSO));
      MyContest.SpaceBarProc;
      NumberEdit.SetFocus;
      exit;
   end;

   if NumberEdit.Text = '' then begin
      CurrentQSO.UpdateTime;
      TimeEdit.Text := CurrentQSO.TimeStr;
      DateEdit.Text := CurrentQSO.DateStr;
   end;

   TabPressed := True;
   TabPressed2 := True;

   if dmZlogGlobal.Settings._switchcqsp then begin
      S := SetStr(dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 2), CurrentQSO);
      {
        if dmZlogGlobal.Settings.CW.CurrentBank = 2 then
        NumberEdit.SetFocus; }
   end
   else begin
      S := SetStr(dmZlogGlobal.CWMessage(1, 2), CurrentQSO);
   end;

   dmZLogKeyer.ClrBuffer;
   dmZLogKeyer.PauseCW;
   if dmZlogGlobal.PTTEnabled then begin
      S := S + ')'; // PTT is turned on in ResumeCW
   end;

   dmZLogKeyer.SetCWSendBuf(0, S);
   dmZLogKeyer.SetCallSign(CurrentQSO.QSO.Callsign);
   dmZLogKeyer.ResumeCW;

   if dmZlogGlobal.Settings._switchcqsp then begin
      CallsignSentProc(nil);
   end;
end;

procedure TMainForm.DownKeyPress;
var
   S: ShortString;
begin
   if CallsignEdit.Text = '' then begin
      exit;
   end;

   case CurrentQSO.QSO.mode of
      mCW: begin
            if Not(MyContest.MultiForm.ValidMulti(CurrentQSO)) then begin
               if dmZlogGlobal.Settings._switchcqsp then begin
                  S := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 5);
               end
               else begin
                  S := dmZlogGlobal.CWMessage(1, 5);
               end;

               S := SetStr(S, CurrentQSO);
               if dmZlogGlobal.FIFO then begin
                  dmZLogKeyer.SendStrFIFO(S);
               end
               else begin
                  dmZLogKeyer.SendStr(S);
               end;

               WriteStatusLine('Invalid Number', False);
               NumberEdit.SetFocus;
               NumberEdit.SelectAll;
               exit;
            end;

            if dmZlogGlobal.Settings._switchcqsp then begin
               S := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, 3);
            end
            else begin
               S := dmZlogGlobal.CWMessage(1, 3);
            end;

            S := SetStr(S, CurrentQSO);
            if dmZlogGlobal.FIFO then begin
               dmZLogKeyer.SendStrFIFO(S);
            end
            else begin
               dmZLogKeyer.SendStr(S);
            end;

            dmZLogKeyer.SetCallSign(CallsignEdit.Text);
            LogButtonClick(Self);
         end;

      mRTTY: begin
            if Not(MyContest.MultiForm.ValidMulti(CurrentQSO)) then begin
               S := dmZlogGlobal.CWMessage(3, 5);
               S := SetStrNoAbbrev(S, CurrentQSO);
               if TTYConsole <> nil then begin
                  TTYConsole.SendStrNow(S);
               end;
               WriteStatusLine('Invalid Number', False);
               NumberEdit.SetFocus;
               NumberEdit.SelectAll;
               exit;
            end;

            S := dmZlogGlobal.CWMessage(3, 3);

            S := SetStrNoAbbrev(S, CurrentQSO);
            if TTYConsole <> nil then begin
               TTYConsole.SendStrNow(S);
            end;

            LogButtonClick(Self);
         end;

      mSSB, mFM, mAM: begin
            if Not(MyContest.MultiForm.ValidMulti(CurrentQSO)) then begin
               // SendVoice(5);
               WriteStatusLine('Invalid Number', False);
               NumberEdit.SetFocus;
               NumberEdit.SelectAll;
               exit;
            end;

            // SendVoice(3);
            LogButtonClick(Self);
         end;
   end;
end;

procedure TMainForm.EditKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
   case Key of
      { MUHENKAN KEY }
      29: begin
            dmZLogKeyer.ControlPTT(not(dmZLogKeyer.PTTIsOn)); // toggle PTT;
         end;

      VK_DOWN: begin
            DownKeyPress;
            Key := 0;
         end;

      VK_INSERT: begin {
              if TEdit(Sender).Name = 'CallsignEdit' then
              begin
              OnTabPress;
              Key := 0;
              end;
            }
         end;

      VK_UP: begin
            Grid.Row := Grid.RowCount - 1;
            if EditScreen.DirectEdit then begin
               Grid.col := TEdit(Sender).Tag;
            end;

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

            // if (CtrlZCQLoopVoice = True) and (TEdit(Sender).Name = 'CallsignEdit') then begin
            // CtrlZBreakVoice;
            // end;

            if (dmZlogGlobal.Settings._jmode) and (TEdit(Sender).Name = 'CallsignEdit') then begin
               if CallsignEdit.Text = '' then begin
                  if Key <> Ord('7') then begin
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

procedure TMainForm.PartialClick(Sender: TObject);
begin
   PartialCheck.Show;
   if ActiveControl = NumberEdit then
      PartialCheck.CheckPartialNumber(CurrentQSO)
   else
      PartialCheck.CheckPartial(CurrentQSO);
end;

procedure TMainForm.CallsignEditKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
   { if PartialCheck.Visible and PartialCheck._CheckCall then
     PartialCheck.CheckPartial(CurrentQSO);
     if SuperCheck.Visible then
     SuperCheck.CheckSuper(CurrentQSO);
     if CheckCall2.Visible then
     CheckCall2.Renew(CurrentQSO); }
end;

procedure TMainForm.ScoreClick(Sender: TObject);
begin
   MyContest.ShowScore;
end;

procedure TMainForm.MultiClick(Sender: TObject);
begin
   MyContest.ShowMulti;
end;

procedure TMainForm.RateClick(Sender: TObject);
begin
   RateDialog.Show;
end;

procedure TMainForm.LogButtonClick(Sender: TObject);
var
   _dupe, i, j: integer;
   workedZLO: boolean;
   st, st2: string;
   B: TBand;
label
   med;
begin
   EditedSinceTABPressed := tabstate_normal;

   _dupe := Log.IsDupe(CurrentQSO);
   if (_dupe = 0) or (CurrentQSO.QSO.Reserve2 = $FF) then // $FF when forcing to log
   begin
      if (MyContest.MultiForm.ValidMulti(CurrentQSO) = False) and (CurrentQSO.QSO.Reserve2 <> $FF) then begin
         WriteStatusLine('Invalid Number', False);
         NumberEdit.SetFocus;
         NumberEdit.SelectAll;
         exit;
      end;
      if CurrentQSO.QSO.Callsign = '' then begin
         WriteStatusLine('Callsign not entered', False);
         CallsignEdit.SetFocus;
         exit;
      end;
      if CurrentQSO.QSO.Reserve2 = $FF then begin
         CurrentQSO.QSO.Reserve2 := $00; { set it back }
         CurrentQSO.QSO.Memo := '* ' + CurrentQSO.QSO.Memo;
      end;

   med:
      MyContest.SetNrSent(CurrentQSO);

      repeat
         i := NewQSOID;
      until Log.CheckQSOID(i) = False;

      CurrentQSO.QSO.Reserve3 := i;

      { if dmZlogGlobal.Settings._recrigfreq = True then
        if RigControl.Rig <> nil then
        CurrentQSO.QSO.Memo := CurrentQSO.QSO.Memo + '('+RigControl.Rig.CurrentFreqkHzStr+')';
      }
      if RigControl.Rig <> nil then begin
         if dmZlogGlobal.Settings._recrigfreq = True then
            CurrentQSO.QSO.Memo := CurrentQSO.QSO.Memo + '(' + RigControl.Rig.CurrentFreqkHzStr + ')';

         if dmZlogGlobal.Settings._autobandmap then begin
            j := RigControl.Rig.CurrentFreqHz;
            if j > 0 then
               BandScope2.CreateBSData(CurrentQSO, j);
         end;
      end;
      // if MyContest.Name = 'Pedition mode' then
      if not FPostContest then
         CurrentQSO.UpdateTime;

      MyContest.LogQSO(CurrentQSO, True);

      workedZLO := False;
      if CurrentQSO.QSO.Callsign = 'JA1ZLO' then begin
         if MyContest.Name = 'ALL JA コンテスト' then
            if CurrentQSO.QSO.Points > 0 then begin
               inc(ZLOCOUNT);
               workedZLO := True;
            end;
      end;

      if CurrentFileName <> '' then begin
         if Log.TotalQSO mod dmZlogGlobal.Settings._saveevery = 0 then begin
            if dmZlogGlobal.Settings._savewhennocw then
               SaveInBackGround := True
            else
               SaveFileAndBackUp;
         end;
      end;
      ZLinkForm.SendQSO(CurrentQSO); { ZLinkForm checks if Z-Link is ON }

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

      if (dmZlogGlobal.Settings._ritclear = True) and (RigControl.Rig <> nil) then
         RigControl.Rig.RitClear;

      inc(CurrentQSO.QSO.Serial);
      SerialArrayTX[dmZlogGlobal.TXNr] := CurrentQSO.QSO.Serial;

      if Not(FPostContest) then
         CurrentQSO.UpdateTime;
      CurrentQSO.QSO.Callsign := '';
      CurrentQSO.QSO.NrRcvd := '';
      CurrentQSO.QSO.Memo := '';

      CurrentQSO.QSO.NewMulti1 := False;
      CurrentQSO.QSO.NewMulti2 := False;

      CurrentQSO.QSO.Dupe := False;
      // CurrentQSO.QSO.CQ := False;

      CurrentQSO.QSO.Reserve2 := 0;
      CurrentQSO.QSO.Reserve3 := 0;
      CurrentQSO.QSO.TX := dmZlogGlobal.TXNr;

      if CurrentQSO.QSO.mode in [mCW, mRTTY] then begin
         CurrentQSO.QSO.RSTRcvd := 599;
      end
      else begin
         CurrentQSO.QSO.RSTRcvd := 59;
      end;

      SerialEdit.Text := CurrentQSO.SerialStr;
      TimeEdit.Text := CurrentQSO.TimeStr;
      DateEdit.Text := CurrentQSO.DateStr;
      CallsignEdit.Text := CurrentQSO.QSO.Callsign;
      RcvdRSTEdit.Text := CurrentQSO.RSTStr;
      NumberEdit.Text := CurrentQSO.QSO.NrRcvd;
      ModeEdit.Text := CurrentQSO.ModeStr;
      BandEdit.Text := CurrentQSO.BandStr;
      NewPowerEdit.Text := CurrentQSO.NewPowerStr;
      PointEdit.Text := CurrentQSO.PointStr;
      OpEdit.Text := CurrentQSO.QSO.Operator;
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
   end
   else begin
      if dmZLogGlobal.Settings._allowdupe = True then begin
         CurrentQSO.QSO.Dupe := True;
         CurrentQSO.QSO.Points := 0;
         CurrentQSO.QSO.NewMulti1 := False;
         CurrentQSO.QSO.NewMulti2 := False;
         CurrentQSO.QSO.Multi1 := '';
         CurrentQSO.QSO.Multi2 := '';
         CurrentQSO.QSO.Memo := '-DUPE- ' + CurrentQSO.QSO.Memo;
         goto med;
      end
      else begin
         CallsignEdit.SetFocus;
         CallsignEdit.SelectAll;
         WriteStatusLine('Dupe', False);
      end;
   end;
end;

procedure TMainForm.OptionsButtonClick(Sender: TObject);
begin
   menuOptions.Click();
end;

procedure TMainForm.SuperCheckButtonClick(Sender: TObject);
begin
   SuperCheck.Show;
   SuperCheck.CheckSuper(CurrentQSO);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
   if FPostContest then begin
      MessageDlg('To change the date, double click the time field.', mtInformation, [mbOK], 0); { HELP context 0 }
   end;

   PostMessage(Handle, WM_ZLOG_INIT, 0, 0);
end;

procedure TMainForm.CWFButtonClick(Sender: TObject);
var
   i: integer;
   S: string[255];
begin
   i := THemisphereButton(Sender).Tag;
   if i in [1 .. 9] then begin
      if i = 9 then begin
         i := 1; { CQ button }
         SetCQ(True);
      end;

      S := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank, i);
      S := SetStr(S, CurrentQSO);
      zLogSendStr(S);
   end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
   FQuickRef.Release();
//   dmZLogKeyer.CloseBGK;
end;

procedure TMainForm.SpeedBarChange(Sender: TObject);
begin
   dmZlogGlobal.Speed := SpeedBar.Position;
   SpeedLabel.Caption := IntToStr(SpeedBar.Position) + ' wpm';

   if LastFocus <> nil then begin
      LastFocus.SetFocus;
   end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
   TIOTAMulti(MyContest.MultiForm).Show;
end;

procedure TMainForm.CWStopButtonClick(Sender: TObject);
begin
   dmZLogKeyer.ClrBuffer;
   CWPlayButton.Visible := False;
   CWPauseButton.Visible := True;
end;

procedure TMainForm.VoiceStopButtonClick(Sender: TObject);
// var i : integer;
begin
   // UzLogVoice.StopVoice;
end;

procedure TMainForm.SetCQ(CQ: boolean);
begin
   CurrentQSO.QSO.CQ := CQ;

   { if CQ then
     StatusLine.Panels[1].Text := 'CQ'
     else
     StatusLine.Panels[1].Text := 'SP'; }

   ZLinkForm.SendRigStatus;

   if RigControl.Rig = nil then
      ZLinkForm.SendFreqInfo(round(RigControl.TempFreq[CurrentQSO.QSO.Band] * 1000));

   if dmZlogGlobal.Settings._switchcqsp then begin
      if CQ then
         SwitchCWBank(1)
      else
         SwitchCWBank(2);
   end;
end;

procedure TMainForm.CQRepeatClick1(Sender: TObject);
var
   S: ShortString;
begin
   S := dmZlogGlobal.CWMessage(1, 1);
   S := SetStr(UpperCase(S), CurrentQSO);
   dmZLogKeyer.SendStrLoop(S);
   SetCQ(True);
end;

procedure TMainForm.CQRepeatClick2(Sender: TObject);
var
   S: ShortString;
begin
   CtrlZCQLoop := True;
   S := dmZlogGlobal.CWMessage(1, 1);
   S := SetStr(UpperCase(S), CurrentQSO);
   dmZLogKeyer.SendStrLoop(S);
   dmZLogKeyer.RandCQStr[1] := SetStr(dmZlogGlobal.Settings.CW.CQStrBank[1], CurrentQSO);
   dmZLogKeyer.RandCQStr[2] := SetStr(dmZlogGlobal.Settings.CW.CQStrBank[2], CurrentQSO);
   SetCQ(True);
end;

procedure TMainForm.SpeedButton12Click(Sender: TObject);
begin
   { dmZlogGlobal.Show;
     dmZlogGlobal.PageControl.ActivePage := dmZlogGlobal.CWTabSheet; }
   CWKeyBoard.Show;
end;

procedure TMainForm.SpeedButton15Click(Sender: TObject);
begin
//   Options.Show;
//   Options.PageControl.ActivePage := Options.VoiceTabSheet;
end;

procedure TMainForm.OpMenuClick(Sender: TObject);
var
   O: string;
begin
   O := TMenuItem(Sender).Caption;

   if O = 'Clear' then begin
      O := '';
   end;

   OpEdit.Text := O;
   CurrentQSO.QSO.Operator := O;

   LastFocus.SetFocus;
   dmZlogGlobal.SetOpPower(CurrentQSO);
   NewPowerEdit.Text := CurrentQSO.NewPowerStr;
   ZLinkForm.SendOperator;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
   { if ActiveControl is TEdit then
     if (TEdit(ActiveControl) = CallsignEdit) or
     (TEdit(ActiveControl) = NumberEdit) then
     if Key = VK_DOWN then
     begin
     Key := 0;
     DownKeyPress;
     end; }
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

procedure TMainForm.RcvdRSTEditChange(Sender: TObject);
var
   i: Integer;
begin
   if CurrentQSO.QSO.mode in [mCW, mRTTY] then begin
      i := 599;
   end
   else begin
      i := 59;
   end;

   CurrentQSO.QSO.RSTRcvd := StrToIntDef(RcvdRSTEdit.Text, i);
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
//   dmZlogGlobal.SetTonePitch(dmZlogGlobal.Settings.CW._tonepitch);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   dmZLogKeyer.CloseBGK;
   RecordWindowStates;

   if MMTTYRunning then begin
      ExitMMTTY;
   end;

   CheckCall2.Release();
   PartialCheck.Release();
   SuperCheck.Release();
   CheckMulti.Release();
   CWKeyBoard.Release();
   RigControl.Release();
   BandScope2.Release();
   ChatForm.Release();
   FreqList.Release();
   CommForm.Release();
   ScratchSheet.Release();
   RateDialog.Release();
   ZServerInquiry.Release();
   ZLinkForm.Release();
   SpotForm.Release();
   ConsolePad.Release();
   CheckCountry.Release();

   if MyContest <> nil then begin
      dmZlogGlobal.WriteWindowState(MyContest.MultiForm, 'MultiForm');
      dmZlogGlobal.WriteWindowState(MyContest.ScoreForm, 'ScoreForm');
      MyContest.Free;
   end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
   R: Integer;
begin
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
   Diff: TDateTime;
   Min, Sec: integer;
   S: string;
begin
   S := TimeToStr(CurrentTime);
   if length(S) = 7 then
      S := '0' + S;
   S := S + ' ';
   if dmZlogGlobal.Settings._countdown then begin
      if CountDownStartTime > 0 then begin
         Diff := CurrentTime - CountDownStartTime;
         if Diff * 24 * 60 > 10.00 then begin
            CountDownStartTime := 0;
            // StatusLine.Panels[1].Text := '';
            S := S + '[QSY OK]';
         end
         else begin
            if Diff > 0 then begin
               Min := Trunc(10 - Diff * 24 * 60);
               Sec := Trunc(integer(round(600 - Diff * 24 * 60 * 60)) mod 60);
               if Min = 10 then
                  S := S + IntToStr(Min)
               else
                  S := S + '0' + IntToStr(Min);
               if Sec >= 10 then
                  S := S + ':' + IntToStr(Sec)
               else
                  S := S + ':0' + IntToStr(Sec);
            end;
         end;
      end
      else // Countdownstarttime = 0;
      begin
         S := S + '[QSY OK]';
      end;
   end
   else begin
      // s := '';
   end;

   if dmZlogGlobal.Settings._qsycount then begin
      S := S + 'QSY# ' + IntToStr(QSYCount);
   end;

   StatusLine.Panels[2].Text := S;
end;

procedure TMainForm.CallsignSentProc(Sender: TObject);
var
   Q: TQSO;
   S: ShortString;
begin
   try
      if CallsignEdit.Focused then begin
         Q := Log.QuickDupe(CurrentQSO);
         if TabPressed2 and (Q <> nil) then begin
            dmZLogKeyer.ClrBuffer;
            WriteStatusLineRed(Q.PartialSummary(dmZlogGlobal.Settings._displaydatepartialcheck), True);

            if dmZlogGlobal.Settings._switchcqsp then begin
               if dmZlogGlobal.Settings.CW.CurrentBank = 2 then begin
                  CallsignEdit.SelectAll;
                  exit;
               end;
            end;

            S := ' ' + SetStr(dmZlogGlobal.CWMessage(1, 4), CurrentQSO);
            dmZLogKeyer.SendStr(S);
            dmZLogKeyer.SetCallSign(CurrentQSO.QSO.Callsign);

            CallsignEdit.SelectAll;

            exit; { BECAREFUL!!!!!!!!!!!!!!!!!!!!!!!! }
         end;

         if TabPressed2 then begin
            MyContest.SpaceBarProc;
            NumberEdit.SetFocus;
            EditedSinceTABPressed := tabstate_tabpressedbutnotedited; // UzLogCW
         end;
      end;

      dmZLogKeyer.ResumeCW;
   finally
      TabPressed := False;
      TabPressed2 := False;
   end;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
   S: ShortString;
begin
   Update10MinTimer;

   if not FPostContest then begin
      CurrentQSO.UpdateTime;
      S := CurrentQSO.TimeStr;
      if S <> TimeEdit.Text then begin
         TimeEdit.Text := S;
      end;
   end;
end;

procedure TMainForm.InsertQSO1Click(Sender: TObject);
var
   _top, _bottom, _oldtop: LongInt;
   R: integer;
begin
   with Grid do begin
      _oldtop := TopRow;
      _top := Selection.top;
      _bottom := Selection.Bottom;
   end;

   if _top = _bottom then begin
      R := EditScreen.IndexArray[Grid.Row];
      if R <= Log.TotalQSO then begin
         MyContest.PastEditForm.Init(TQSO(Log.List[R]), R, _ActInsert);
         MyContest.PastEditForm.ShowModal;
         EditScreen.Renew;
      end;
   end
   else begin
   end;

   Grid.TopRow := _oldtop;
   EditScreen.RefreshScreen;
end;

procedure TMainForm.MemoEditKeyPress(Sender: TObject; var Key: Char);
begin
   CommonEditKeyProcess(Sender, Key);
   case Key of
      'X', 'x': begin
         if GetAsyncKeyState(VK_SHIFT) < 0 then begin
            RigControl.ToggleCurrentRig;
            Key := #0;
         end;
      end;

      'V', 'v': begin
         if GetAsyncKeyState(VK_SHIFT) < 0 then begin
            if RigControl.Rig <> nil then
               RigControl.Rig.ToggleVFO;
            Key := #0;
         end;
      end;

      '+', ';': begin
         DownKeyPress;
         Key := #0;
      end;

      ^W: begin
         TEdit(Sender).Clear;
         Key := #0;
      end;

      ^R: begin
         dmZlogGlobal.ReversePaddle;
         Key := #0;
      end;

      ^K: begin
         EditedSinceTABPressed := tabstate_normal;
         CallsignEdit.Clear;
         NumberEdit.Clear;
         MemoEdit.Clear;
         Key := #0;
         CallsignEdit.SetFocus;
      end;

      ^Z: begin
         if CurrentQSO.QSO.mode = mCW then
            CQRepeatClick2(Sender);
         Key := #0;
      end;

      Chr($1B): { ESC } begin
         CWStopButtonClick(Self);
         VoiceStopButtonClick(Self);
         Key := #0;
      end;

      Chr($0D): begin
         LogButtonClick(Self);
         Key := #0;
      end;
   end;
   { of case }
end;

procedure TMainForm.VoiceFButtonClick(Sender: TObject);
begin
   // SendVoice(THemisphereButton(Sender).Tag);
end;

procedure TMainForm.TimeEditChange(Sender: TObject);
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
         // T := CurrentQSO.QSO.Time;
         exit;
      end;
   end;
   CurrentQSO.QSO.Time := Int(CurrentQSO.QSO.Time) + Frac(T);
end;

procedure TMainForm.Export1Click(Sender: TObject);
var
   f, ext: string;
begin
   TXTSaveDialog.filename := copy(CurrentFileName, 1, length(CurrentFileName) - length(ExtractFileExt(CurrentFileName)));

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

      { Add code to save current file under SaveDialog.FileName }
   end;
end;

procedure TMainForm.ClusterClick(Sender: TObject);
begin
   CommForm.Show;
end;

procedure TMainForm.SpeedButton9Click(Sender: TObject);
begin
   ZLinkForm.Show;
end;

procedure TMainForm.SerialEditChange(Sender: TObject);
var
   i: integer;
begin
   i := StrToIntDef(SerialEdit.Text, 0);

   if i > 0 then begin
      CurrentQSO.QSO.Serial := i;
   end;
end;

procedure TMainForm.GridBandChangeClick(Sender: TObject);
var
   i, j, _top, _bottom: integer;
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
      R := EditScreen.IndexArray[_top];
      if (R > 0) and (R <= Log.TotalQSO) then begin
         aQSO := TQSO(Log.List[R]);
         IncEditCounter(aQSO);
         aQSO.QSO.Band := B;
         ZLinkForm.EditQSObyID(aQSO); // added 0.24
      end;
   end
   else begin
      if { (ShowCurrentBandOnly.Checked = False) and } (_top < Log.TotalQSO) and (_bottom <= Log.TotalQSO) then begin
         R := MessageDlg('Are you sure to change the band for these QSO''s?', mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
         if R = mrNo then
            exit;
         for i := _top to _bottom do begin
            j := EditScreen.IndexArray[i]; // 1.4b
            if (j > 0) and (j <= Log.TotalQSO) then begin
               aQSO := TQSO(Log.List[j]);
               aQSO.QSO.Band := B;
               IncEditCounter(aQSO);
               ZLinkForm.EditQSObyID(aQSO); // 0.24
            end;
         end;
      end;
   end;
   // aQSO.Free;
   i := Grid.TopRow;
   MyContest.Renew;
   Grid.TopRow := i;
   EditScreen.RefreshScreen;
end;

procedure TMainForm.ZLinkmonitor1Click(Sender: TObject);
begin
   ZLinkForm.Show;
end;

procedure TMainForm.Load1Click(Sender: TObject);
begin
   ZLinkForm.LoadLogFromZLink;
   {
     if ZLinkForm.Transparent then
     ZLinkForm.LoadLogFromZLink   // clears current log
     else
     ZLinkForm.LoadLogFromZServer;  // does not clear }
end;

procedure TMainForm.SortbyTime1Click(Sender: TObject);
begin
   Log.SortByTime;
   EditScreen.Renew;
   EditScreen.RefreshScreen;
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

procedure TMainForm.DateEditChange(Sender: TObject);
var
   T: TDateTime;
begin
   try
      T := StrToDate(DateEdit.Text);
   except
      on EConvertError do begin
         // T := CurrentQSO.QSO.Time;
         exit;
      end;
   end;
   CurrentQSO.QSO.Time := Int(T) + Frac(CurrentQSO.QSO.Time);
end;

procedure TMainForm.TimeEditDblClick(Sender: TObject);
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
var
   i: integer;
begin
   i := ClientWidth - Grid.GridWidth;
   if i <> 0 then begin
      Grid.ColWidths[Grid.ColCount - 1] := Grid.ColWidths[Grid.ColCount - 1] + i;
      if EditScreen <> nil then begin
         EditScreen.SetEditFields;
      end;
   end;
end;

procedure TMainForm.menuOptionsClick(Sender: TObject);
var
   f: TformOptions;
begin
   f := TformOptions.Create(Self);
   try
      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      RenewCWToolBar;
      RenewVoiceToolBar;

      MyContest.ScoreForm.Update();
      MyContest.MultiForm.Update();

      // リグコントロール開始
      RigControl.ImplementOptions;

      SetWindowCaption();

      LastFocus.SetFocus;
   finally
      f.Release();
   end;
end;

procedure TMainForm.Edit1Click(Sender: TObject);
var
   f: TformOptions;
begin
   f := TformOptions.Create(Self);
   try
      f.PageControl.ActivePage := f.CWTabSheet;
      case TMenuItem(Sender).Tag of
         1:
            f.Edit1.SetFocus;
         2:
            f.Edit2.SetFocus;
         3:
            f.Edit3.SetFocus;
         4:
            f.Edit4.SetFocus;
         5:
            f.Edit5.SetFocus;
         6:
            f.Edit6.SetFocus;
         7:
            f.Edit7.SetFocus;
         8:
            f.Edit8.SetFocus;
      end;

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      RenewCWToolBar;
      RenewVoiceToolBar;
      LastFocus.SetFocus;
   finally
      f.Release();
   end;
end;

procedure TMainForm.CWF1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
   CWFMenu.Items[0].Tag := THemisphereButton(Sender).Tag;
end;

procedure TMainForm.HemisphereButton8MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
   CWFMenu.Items[0].Tag := 1;
end;

procedure TMainForm.Backup1Click(Sender: TObject);
var
   P: string;
begin
   P := dmZlogGlobal.Settings._backuppath;
   if (P = '') or (P = '\') then begin
      P := ExtractFilePath(Application.ExeName);
   end;

   ForceDirectories(P);

   Log.SaveToFile(P + ExtractFileName(CurrentFileName));
end;

procedure TMainForm.CWKeyboard1Click(Sender: TObject);
begin
   CWKeyBoard.Show;
end;

procedure TMainForm.EditEnter(Sender: TObject);
var
   P: integer;
begin
   LastFocus := TEdit(Sender);
   if TEdit(Sender).Name = 'CallsignEdit' then begin
      P := Pos('.', CallsignEdit.Text);
      if P > 0 then begin
         CallsignEdit.SelStart := P - 1;
         CallsignEdit.SelLength := 1;
      end;
   end;
end;

procedure TMainForm.mnMergeClick(Sender: TObject);
begin
   ZLinkForm.MergeLogWithZServer;
end;

procedure TMainForm.ZServer1Click(Sender: TObject);
begin
   ChatForm.Show;
end;

procedure TMainForm.ConnecttoZServer1Click(Sender: TObject);
begin
   ZLinkForm.ZSocket.Addr := dmZlogGlobal.Settings._zlink_telnet.FHostName;
   ZLinkForm.ZSocket.Port := 'telnet';
   if ZLinkForm.ZServerConnected then begin
      ZLinkForm.DisconnectedByMenu := True;
      ZLinkForm.ZSocket.close;
   end
   else begin
      ZLinkForm.ZSocket.Connect;
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
   i, j, _top, _bottom: integer;
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
      R := EditScreen.IndexArray[_top];
      if (R > 0) and (R <= Log.TotalQSO) then begin
         aQSO := TQSO(Log.List[R]); // added 0.24

         if M in [mSSB, mAM, mFM] then begin
            if not(aQSO.QSO.mode in [mSSB, mAM, mFM]) then begin
               aQSO.QSO.RSTsent := aQSO.QSO.RSTsent div 10;
               aQSO.QSO.RSTRcvd := aQSO.QSO.RSTRcvd div 10;
            end;
         end
         else begin
            if aQSO.QSO.mode in [mSSB, mAM, mFM] then begin
               aQSO.QSO.RSTsent := aQSO.QSO.RSTsent * 10 + 9;
               aQSO.QSO.RSTRcvd := aQSO.QSO.RSTRcvd * 10 + 9;
            end;
         end;

         aQSO.QSO.mode := M;
         IncEditCounter(aQSO);
         ZLinkForm.EditQSObyID(aQSO); // added 0.24
      end;
   end
   else begin
      if { (ShowCurrentBandOnly.Checked = False) and } (_top < Log.TotalQSO) and (_bottom <= Log.TotalQSO) then begin
         R := MessageDlg('Are you sure to change the mode for these QSO''s?', mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
         if R = mrNo then
            exit;
         for i := _top to _bottom do begin
            j := EditScreen.IndexArray[i];
            if (j > 0) and (j <= Log.TotalQSO) then begin
               aQSO := TQSO(Log.List[j]); // 0.24

               if M in [mSSB, mAM, mFM] then begin
                  if not(aQSO.QSO.mode in [mSSB, mAM, mFM]) then begin
                     aQSO.QSO.RSTsent := aQSO.QSO.RSTsent div 10;
                     aQSO.QSO.RSTRcvd := aQSO.QSO.RSTRcvd div 10;
                  end;
               end
               else begin
                  if aQSO.QSO.mode in [mSSB, mAM, mFM] then begin
                     aQSO.QSO.RSTsent := aQSO.QSO.RSTsent * 10 + 9;
                     aQSO.QSO.RSTRcvd := aQSO.QSO.RSTRcvd * 10 + 9;
                  end;
               end;

               aQSO.QSO.mode := M;
               IncEditCounter(aQSO);
               ZLinkForm.EditQSObyID(aQSO); // 0.24
            end;
         end;
      end;
   end;
   // aQSO.Free;
   i := Grid.TopRow;
   MyContest.Renew;
   Grid.TopRow := i;
   EditScreen.RefreshScreen;
end;

procedure TMainForm.GridOperatorClick(Sender: TObject);
var
   i, j, _top, _bottom: integer;
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
      R := EditScreen.IndexArray[_top];
      if (R > 0) and (R <= Log.TotalQSO) then begin
         aQSO := TQSO(Log.List[R]); // added 0.24
         aQSO.QSO.Operator := OpName;
         IncEditCounter(aQSO);
         ZLinkForm.EditQSObyID(aQSO); // added 0.24
      end;
   end
   else begin
      if (_top < Log.TotalQSO) and (_bottom <= Log.TotalQSO) then begin
         R := MessageDlg('Are you sure to change the operator names for these QSO''s?', mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
         if R = mrNo then
            exit;

         for i := _top to _bottom do begin
            j := EditScreen.IndexArray[i];
            if (j > 0) and (j <= Log.TotalQSO) then begin
               aQSO := TQSO(Log.List[j]); // 0.24
               aQSO.QSO.Operator := OpName;
               IncEditCounter(aQSO);
               ZLinkForm.EditQSObyID(aQSO); // 0.24
            end;
         end;
      end;
   end;
   // aQSO.Free;
   i := Grid.TopRow;
   MyContest.Renew;
   Grid.TopRow := i;
   EditScreen.RefreshScreen;
end;

procedure TMainForm.SendSpot1Click(Sender: TObject);
var
   _top, _bottom: integer;
   R: word;
begin
   with Grid do begin
      _top := Selection.top;
      _bottom := Selection.Bottom;
   end;

   if _top = _bottom then begin
      R := EditScreen.IndexArray[Grid.Row];
      if R <= Log.TotalQSO then begin
         SpotForm.Open(TQSO(Log.List[R]));
      end;
   end;
end;

procedure TMainForm.NumberEditKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
   if PartialCheck.Visible and not(PartialCheck._CheckCall) then
      PartialCheck.CheckPartialNumber(CurrentQSO);

   if CheckMulti.Visible then
      CheckMulti.Renew(CurrentQSO);
end;

procedure TMainForm.NewPowerMenuClick(Sender: TObject);
begin
   NewPowerEdit.Text := NewPowerString[TPower(TMenuItem(Sender).Tag)];
   CurrentQSO.QSO.Power := TPower(TMenuItem(Sender).Tag);
   LastFocus.SetFocus;
end;

procedure TMainForm.NewPowerEditClick(Sender: TObject);
begin
   NewPowerMenu.Popup(Left + NewPowerEdit.Left + 20, Top + EditPanel.top + NewPowerEdit.top);
end;

procedure TMainForm.OpEditClick(Sender: TObject);
begin
   OpMenu.Popup(Left + OpEdit.Left + 20, Top + EditPanel.top + OpEdit.top);
end;

procedure TMainForm.CheckCall1Click(Sender: TObject);
begin
   CheckCall2.Show;
end;

procedure TMainForm.GridClick(Sender: TObject);
begin
   if not(CheckCall2.Visible) then
      exit;
   // CheckCall.Renew(TQSO(Log.List[Grid.Row]));
   CheckCall2.Renew(TQSO(Log.List[EditScreen.IndexArray[Grid.Row]]));
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
   LastFocus.SetFocus;
end;

procedure TMainForm.CreateDupeCheckSheetZPRINT1Click(Sender: TObject);
var
   R: integer;
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

procedure TMainForm.memo1Click(Sender: TObject);
begin
   MemoEdit.SetFocus;
end;

procedure TMainForm.rst1Click(Sender: TObject);
begin
   RcvdRSTEdit.SetFocus;
end;

procedure TMainForm.callsign1Click(Sender: TObject);
begin
   CallsignEdit.SetFocus;
end;

procedure TMainForm.ShowCurrentBandOnlyClick(Sender: TObject);
begin
   ShowCurrentBandOnly.Checked := not(ShowCurrentBandOnly.Checked);
   EditScreen.Renew;
   EditScreen.RefreshScreen;
end;

procedure TMainForm.pushqso1Click(Sender: TObject);
begin
   PushQSO(CurrentQSO);
end;

procedure TMainForm.pullqso1Click(Sender: TObject);
begin
   PullQSO;
end;

procedure TMainForm.GridTopLeftChanged(Sender: TObject);
begin
   EditScreen.RefreshScreen;

   if Grid.LeftCol <> 0 then
      Grid.LeftCol := 0;
end;

procedure TMainForm.TXTSaveDialogTypeChange(Sender: TObject);
var
   i: integer;
begin
   i := TXTSaveDialog.FilterIndex;
   if i = 2 then
      TXTSaveDialog.DefaultExt := 'txt'
   else
      TXTSaveDialog.DefaultExt := 'all';
end;

procedure TMainForm.GridMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
   if EditScreen <> nil then
      EditScreen.SetEditFields;
end;

procedure TMainForm.memo21Click(Sender: TObject);
begin
   NumberEdit.SetFocus;
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

procedure TMainForm.CQRepeatVoice2Click(Sender: TObject);
begin
   // CtrlZCQLoopVoice := True;
   // CQLoopVoice;
   // SetCQ(True);
end;

procedure TMainForm.CQRepeatVoice1Click(Sender: TObject);
begin
   // CQLoopVoice;
   // SetCQ(True);
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
var
   str: string;
begin
   GeneralSaveDialog.DefaultExt := 'zsm';
   GeneralSaveDialog.Filter := 'Summary files (*.zsm)|*.zsm';
   GeneralSaveDialog.Title := 'Save summary file';
   if CurrentFileName <> '' then begin
      str := CurrentFileName;
      str := copy(str, 0, length(str) - length(ExtractFileExt(str)));
      str := str + '.zsm';
      GeneralSaveDialog.filename := str;
   end;
   if GeneralSaveDialog.Execute then
      MyContest.ScoreForm.SaveSummary(GeneralSaveDialog.filename);
end;

procedure TMainForm.op1Click(Sender: TObject);
begin
   OpEditClick(Self);
end;

procedure TMainForm.GridPowerChangeClick(Sender: TObject);
var
   i, j, _top, _bottom: integer;
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
      R := EditScreen.IndexArray[_top];
      if (R > 0) and (R <= Log.TotalQSO) then begin
         aQSO := TQSO(Log.List[R]); // added 0.24
         aQSO.QSO.Power := P;
         IncEditCounter(aQSO);
         ZLinkForm.EditQSObyID(aQSO); // added 0.24
      end;
   end
   else begin
      if (_top < Log.TotalQSO) and (_bottom <= Log.TotalQSO) then begin
         R := MessageDlg('Are you sure to change the power for these QSO''s?', mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
         if R = mrNo then
            exit;
         for i := _top to _bottom do begin
            j := EditScreen.IndexArray[i];
            if (j > 0) and (j <= Log.TotalQSO) then begin
               aQSO := TQSO(Log.List[j]);
               aQSO.QSO.Power := P;
               IncEditCounter(aQSO);
               ZLinkForm.EditQSObyID(aQSO);
            end;
         end;
      end;
   end;
   // aQSO.Free;
   i := Grid.TopRow;
   MyContest.Renew;
   Grid.TopRow := i;
   EditScreen.RefreshScreen;
end;

procedure TMainForm.RigControl1Click(Sender: TObject);
begin
   RigControl.Show;
end;

procedure TMainForm.Console1Click(Sender: TObject);
begin
   ConsolePad.Show;
end;

procedure TMainForm.MergeFile1Click(Sender: TObject);
var
   ff: string;
   i: integer;
begin
   OpenDialog.Title := 'Merge file';
   if OpenDialog.Execute then begin
      WriteStatusLine('Merging...', False);
      ff := OpenDialog.filename;
      if ff = CurrentFileName then begin
         WriteStatusLine('Cannot merge current file', True);
         exit;
      end;

      i := MergeFile(ff);
      if i > 0 then begin
         Log.SortByTime;
         MyContest.Renew;
         // EditScreen.Renew;
         EditScreen.RefreshScreen;
         FileSave(Self);
      end;
      WriteStatusLine(IntToStr(i) + ' QSO(s) merged.', True);
   end;
end;

procedure TMainForm.RunningFrequencies1Click(Sender: TObject);
begin
   FreqList.Show;
end;

procedure TMainForm.SaveFileAndBackUp;
begin
   Log.SaveToFile(CurrentFileName); // this is where the file is saved!!!
   Backup1Click(Self); // 0.32
end;

procedure TMainForm.mnCheckCountryClick(Sender: TObject);
begin
   CheckCountry.Show;
end;

procedure TMainForm.mnCheckMultiClick(Sender: TObject);
begin
   CheckMulti.Show;
end;

procedure TMainForm.StatusLineDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
begin
   if Panel = StatusLine.Panels[0] then begin
      StatusBar.Canvas.Font.Color := clStatusLine;
      StatusBar.Canvas.TextOut(Rect.Left + 1, Rect.top + 1, Panel.Text);
   end;
end;

procedure TMainForm.Bandscope1Click(Sender: TObject);
begin
   // BandScope.Show;
   BandScope2.Show; // BS2 test
end;

procedure TMainForm.mnChangeTXNrClick(Sender: TObject);
var
   i, j, _top, _bottom, NewTX, R: integer;
   aQSO: TQSO;
   F: TIntegerDialog;
begin
   F := TIntegerDialog.Create(Self);
   try
      with Grid do begin
         _top := Selection.top;
         _bottom := Selection.Bottom;
      end;

      if _top = _bottom then begin
         R := EditScreen.IndexArray[_top];
         if (R > 0) and (R <= Log.TotalQSO) then begin
            aQSO := TQSO(Log.List[R]);

            F.Init(dmZlogGlobal.Settings._txnr, 'Enter new TX#');
            if F.ShowModal <> mrOK then begin
               Exit;
            end;

            NewTX := F.GetValue;

            if (NewTX >= 0) and (NewTX <= 255) then begin
               IncEditCounter(aQSO);
               aQSO.QSO.TX := NewTX;
               // aQSO.QSO.Memo := 'TX#'+IntToStr(aQSO.QSO.TX)+' '+aQSO.QSO.Memo;
               ZLinkForm.EditQSObyID(aQSO); // added 0.24
            end;
         end;
      end
      else begin
         if (_top < Log.TotalQSO) and (_bottom <= Log.TotalQSO) then begin
            R := MessageDlg('Are you sure to change the TX# for these QSO''s?', mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
            if R = mrNo then
               exit;

            aQSO := TQSO(Log.List[EditScreen.IndexArray[_top]]);

            F.Init(dmZlogGlobal.Settings._txnr, 'Enter new TX#');
            if F.ShowModal <> mrOK then begin
               Exit;
            end;

            NewTX := F.GetValue;

            if (NewTX > 255) or (NewTX < 0) then begin
               Exit;
            end;

            for i := _top to _bottom do begin
               j := EditScreen.IndexArray[i]; // 1.4b
               if (j > 0) and (j <= Log.TotalQSO) then begin
                  aQSO := TQSO(Log.List[j]);
                  aQSO.QSO.TX := NewTX;
                  // aQSO.QSO.Memo := 'TX#'+IntToStr(aQSO.QSO.TX)+' '+aQSO.QSO.Memo;
                  IncEditCounter(aQSO);
                  ZLinkForm.EditQSObyID(aQSO); // 0.24
               end;
            end;
         end;
      end;

      i := Grid.TopRow;
      MyContest.Renew;
      Grid.TopRow := i;
      EditScreen.RefreshScreen;
   finally
      F.Release();
   end;
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
   Row, ind: LongInt;
   S: string;
begin
   Row := Grid.Row;
   if Row > 0 then begin
      ind := EditScreen.IndexArray[Row];
      if (ind > 0) and (ind <= Log.TotalQSO) then begin
         S := TQSO(Log.List[ind]).QSO.Callsign;
         MyContest.MultiForm.SelectAndAddNewPrefix(S);
      end;
   end;
end;

procedure TMainForm.GridSelectCell(Sender: TObject; col, Row: integer; var CanSelect: boolean);
begin
   if EditScreen.DirectEdit then begin
      EditScreen.BeforeEdit := Grid.Cells[col, Row];
      if (col = CallsignEdit.Tag) or (col = NumberEdit.Tag) or (col = MemoEdit.Tag) then
         Grid.Options := Grid.Options + [goEditing]
      else
         Grid.Options := Grid.Options - [goEditing];
      {
        if Grid.EditorMode then
        WriteStatusLine('EDITMODE=TRUE', False)
        else
        WriteStatusLine('EDITMODE=False',False); }
   end;
end;

procedure TMainForm.GridSetEditText(Sender: TObject; ACol, ARow: integer; const Value: String);
begin
   WriteStatusLine('SetEditTextCalled', False);
end;

procedure TMainForm.GridGetEditText(Sender: TObject; ACol, ARow: integer; var Value: String);
begin
   WriteStatusLine('GetEditTextCalled', False);
end;

procedure TMainForm.Togglerig1Click(Sender: TObject);
begin
   // WriteStatusLine('Alt+.',False);
   RigControl.ToggleCurrentRig;
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

procedure TMainForm.Scratchsheet1Click(Sender: TObject);
begin
   ScratchSheet.Show;
end;

procedure TMainForm.SwitchLastQSOBandMode;
var
   T, mytx, i: integer;
   boo: boolean;
begin
   if Log.TotalQSO > 0 then begin
      T := Log.TotalQSO;
      mytx := dmZlogGlobal.TXNr;
      boo := False;
      for i := T downto 1 do begin
         if TQSO(Log.List[i]).QSO.TX = mytx then begin
            boo := True;
            break;
         end;
      end;

      if boo = True then begin

         UpdateBand(TQSO(Log.List[i]).QSO.Band);
         if RigControl.Rig <> nil then begin
            RigControl.Rig.SetBand(CurrentQSO);
            if CurrentQSO.QSO.mode = mSSB then
               RigControl.Rig.SetMode(CurrentQSO);
         end;
         UpdateMode(TQSO(Log.List[i]).QSO.mode);
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
      Application.CreateForm(TTTYConsole, TTYConsole);
      repeat
      until TTYConsole <> nil;
      TTYConsole.SetTTYMode(ttyMMTTY);
      InitializeMMTTY(Handle);
      TTYConsole.Show;
      TTYConsole.SetFocus;
      exit;
   end
   else begin
      mnMMTTY.Tag := 0;
      mnMMTTY.Caption := 'Load MMTTY';
      mnTTYConsole.Visible := False;
      TTYConsole.close;
      TTYConsole.Destroy;
      ExitMMTTY;
      exit;
   end;
end;

procedure TMainForm.mnTTYConsoleClick(Sender: TObject);
begin
   TTYConsole.Show;
end;

procedure TMainForm.QTC1Click(Sender: TObject);
begin
   if MyContest.Name <> 'WAEDC Contest' then begin
      Exit;
   end;

   TWAEContest(MyContest).QTCForm.Show;
   if CurrentQSO.QSO.Callsign = '' then begin
      if Log.TotalQSO >= 2 then begin
         TWAEContest(MyContest).QTCForm.OpenQTC(TQSO(Log.List[Log.TotalQSO]));
      end;
   end
   else begin
      TWAEContest(MyContest).QTCForm.OpenQTC(Main.CurrentQSO);
   end;
end;

procedure TMainForm.menuClearCallAndRstClick(Sender: TObject);
begin
   CallsignEdit.Clear();
   NumberEdit.Clear();
   WriteStatusLine('', False);
   CallsignEdit.SetFocus;
end;

procedure TMainForm.mnNewBandScopeClick(Sender: TObject);
var
   i: integer;
begin
   for i := 1 to BSMax do begin // BS2test...
      if uBandScope2.BandScopeArray[i] = nil then begin
         uBandScope2.BandScopeArray[i] := TBandScope2.Create(Self);
         uBandScope2.BandScopeArray[i].ArrayNumber := i;
         uBandScope2.BandScopeArray[i].Show;
         uBandScope2.BandScopeArray[i].SetBandMode(CurrentQSO.QSO.Band, CurrentQSO.QSO.mode);
         exit;
      end;
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
   AutoInput(TBSData(BSList2[0]));
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

procedure TMainForm.MyIdleEvent(Sender: TObject; var Done: boolean);
var
   boo: boolean;
begin
   boo := dmZlogKeyer.IsPlaying;

   if boo then begin
      if CurrentQSO.QSO.mode = mCW then begin
         CWPauseButton.Enabled := True;
         CWPauseButton.Visible := True;
         CWPlayButton.Visible := False;
         CWStopButton.Enabled := True;
      end
      else begin
      end;
   end
   else begin
      // if Paused = False then
      if CurrentQSO.QSO.mode = mCW then begin
         TabPressed := False;
      end;

      if SaveInBackGround = True then begin
         SaveFileAndBackUp;
         SaveInBackGround := False;
      end;

      CWPauseButton.Enabled := False;

      if not(dmZlogKeyer.Paused) then begin
         CWStopButton.Enabled := False;
      end
      else begin
         CWStopButton.Enabled := True;
      end;
   end;

   if CurrentQSO.QSO.mode = mRTTY then begin
      if TTYConsole <> nil then begin
         if TTYConsole.Sending = False then begin
            TabPressed := False;
         end;
      end;
   end;

   if HiWord(GetKeyState(VK_TAB)) <> 0 then begin
      if not(TabPressed) and (CallsignEdit.Focused or NumberEdit.Focused) then begin
         if Trunc((Now - LastTabPress) * 24 * 60 * 60 * 1000) > 100 then begin
            OnTabPress;
         end;

         LastTabPress := Now;
      end;
   end;

   Done := True;
end;

procedure TMainForm.MyMessageEvent(var Msg: TMsg; var Handled: boolean);
begin
   if MMTTYInitialized then begin
      UMMTTY.ProcessMMTTYMessage(Msg, Handled);
   end;
end;

procedure TMainForm.OnZLogInit( var Message: TMessage );
var
   menu: TMenuForm;
   E: Extended;
   c, r: Integer;
begin
   menu := TMenuForm.Create(Self);
   try
      if menu.ShowModal() = mrCancel then begin
         Close();
         Exit;
      end;

      dmZlogGlobal.SetLogFileName('');

      CurrentQSO.QSO.Serial := 1;
      mPXListWPX.Visible := False;

      dmZlogGlobal.MultiOp := menu.OpGroupIndex;

      dmZlogGlobal.Band := menu.BandGroupIndex;

      dmZlogGlobal.Mode := menu.ModeGroupIndex;

      dmZlogGlobal.MyCall := menu.Callsign;

      dmZlogGlobal.ContestMenuNo := menu.ContestNumber;

      if menu.OpGroupIndex > 0 then begin
         dmZlogGlobal.TXNr := menu.TxNumber;    // TX#
         if dmZlogGlobal.Settings._pcname = '' then begin
            dmZlogGlobal.Settings._pcname := 'PC' + IntToStr(menu.TxNumber);
         end;
      end;

      E := menu.ScoreCoeff;
      dmZlogGlobal.SetScoreCoeff(E);

      FPostContest := menu.PostContest;

      dmZlogGlobal.SaveCurrentSettings;

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
            InitWPX(menu.OpGroupIndex);
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

      if menu.ModeGroupIndex = 1 then begin
         CurrentQSO.QSO.Mode := mCW;
         CurrentQSO.QSO.RSTRcvd := 599;
         CurrentQSO.QSO.RSTSent := 599;
      end
      else begin
         CurrentQSO.QSO.mode := mSSB;
         CurrentQSO.QSO.RSTRcvd := 59;
         CurrentQSO.QSO.RSTSent := 59;
      end;

      // ファイル名の指定が無い場合は選択ダイアログを出す
      if CurrentFileName = '' then begin
         OpenDialog.InitialDir := dmZlogGlobal.Settings._logspath;

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

      MyContest.Renew;
      EditScreen.Renew;
      ReEvaluateCountDownTimer;
      ReEvaluateQSYCount;

      if menu.ModeGroupIndex = 0 then begin
         MyContest.ScoreForm.CWButton.Visible := True
      end
      else begin
         MyContest.ScoreForm.CWButton.Visible := False;
      end;

      // 設定反映
      dmZlogGlobal.ImplementSettings(False);

      RestoreWindowStates;
      dmZlogGlobal.ReadWindowState(MyContest.MultiForm, 'MultiForm', False);
      dmZlogGlobal.ReadWindowState(MyContest.ScoreForm, 'ScoreForm', True);

      if Pos('WAEDC', MyContest.Name) > 0 then begin
         MessageDlg('QTC can be sent by pressing Ctrl+Q', mtInformation, [mbOK], 0);
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
      CurrentQSO.QSO.Band := GetFirstAvailableBand();

      BandEdit.Text := MHzString[CurrentQSO.QSO.Band];
      CurrentQSO.QSO.TX := dmZlogGlobal.TXNr;

      if CurrentQSO.QSO.mode in [mCW, mRTTY] then begin
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

      // CurrentQSO.QSO.Serial := SerialArray[b19]; // in case SERIALSTART is defined. SERIALSTART applies to all bands.
      SerialEdit.Text := CurrentQSO.SerialStr;

      // フォントサイズの設定
      SetFontSize(dmZlogGlobal.Settings._mainfontsize);

      EditScreen.ResetTopRow; // added 2.2e
      EditScreen.RefreshScreen; // added 2,2e

      UpdateBand(CurrentQSO.QSO.Band);
      UpdateMode(CurrentQSO.QSO.mode);
      BandScope2.SetBandMode(CurrentQSO.QSO.Band, CurrentQSO.QSO.mode);

      MyContest.ScoreForm.Update();
      MyContest.MultiForm.Update();

      if FPostContest then begin
         TimeEdit.SetFocus;
      end
      else begin
         CallsignEdit.SetFocus;
      end;

      LastFocus := CallsignEdit; { the place to set focus when ESC is pressed from Grid }

      // リグコントロール開始
      RigControl.ImplementOptions;
   finally
      menu.Release();
   end;
end;

procedure TMainForm.OnZLogSetGridCol( var Message: TMessage );
begin
   EditScreen.SetGridWidth();
   EditScreen.SetEditFields();
end;

procedure TMainForm.InitALLJA();
begin
   BandMenu.Items[Ord(b19)].Visible := False;
   HideBandMenuWARC();

   EditScreen := TALLJAEdit.Create(Self);

   MyContest := TALLJAContest.Create('ALL JA コンテスト');
   QTHString := dmZlogGlobal.Settings._prov;
   dmZlogGlobal.Settings._sentstr := '$V$P';
end;

procedure TMainForm.Init6D();
begin
   HideBandMenuHF();
   HideBandMenuWARC();

   EditScreen := TACAGEdit.Create(Self);

   MyContest := TSixDownContest.Create('6m and DOWNコンテスト');
   QTHString := dmZlogGlobal.Settings._city;
   dmZlogGlobal.Settings._sentstr := '$Q$P';
end;

procedure TMainForm.InitFD();
begin
   BandMenu.Items[Ord(b19)].Visible := False;
   HideBandMenuWARC();

   EditScreen := TACAGEdit.Create(Self);

   MyContest := TFDContest.Create('フィールドデーコンテスト');
   QTHString := dmZlogGlobal.Settings._city;
   dmZlogGlobal.Settings._sentstr := '$Q$P';
end;

procedure TMainForm.InitACAG();
begin
   BandMenu.Items[Ord(b19)].Visible := False;
   HideBandMenuWARC();

   EditScreen := TACAGEdit.Create(Self);

   MyContest := TACAGContest.Create('全市全郡コンテスト');
   QTHString := dmZlogGlobal.Settings._city;
   dmZlogGlobal.Settings._sentstr := '$Q$P';
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

   QTHString := dmZlogGlobal.Settings._city;
   dmZlogGlobal.Settings._sentstr := '$S';
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

   QTHString := dmZlogGlobal.Settings._city;
   dmZlogGlobal.Settings._sentstr := '$S';
end;

procedure TMainForm.InitKCJ();
begin
   BandMenu.Items[Ord(b19)].Visible := True;
   HideBandMenuWARC();
   HideBandMenuVU(False);

   EditScreen := TKCJEdit.Create(Self);

   MyContest := TKCJContest.Create('KCJ コンテスト');
   QTHString := dmZlogGlobal.Settings._prov;
   dmZlogGlobal.Settings._sentstr := 'TK';
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
      QTHString := dmZlogGlobal.Settings._prov;
      dmZlogGlobal.Settings._sentstr := '';
   finally
      F.Release();
   end;
end;

procedure TMainForm.InitUserDefined(ContestName, ConfigFile: string);
begin
   QTHString := dmZlogGlobal.Settings._city;
   dmZlogGlobal.Settings._sentstr := '$Q';
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
   // QTHString := dmZlogGlobal.Settings._city;
   dmZlogGlobal.Settings._sentstr := '$Z';
   QTHString := UMultipliers.MyZone;
end;

procedure TMainForm.InitWPX(OpGroupIndex: Integer);
begin
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TWPXEdit.Create(Self);

   MyContest := TCQWPXContest.Create('CQ WPX Contest');

   if OpGroupIndex = 1 then begin
      SerialContestType := SER_BAND;
   end;
   if OpGroupIndex = 2 then begin
      SerialContestType := SER_MS;
   end;

   QTHString := dmZlogGlobal.Settings._city;
   dmZlogGlobal.Settings._sentstr := '$S';
   mPXListWPX.Visible := True;
end;

procedure TMainForm.InitJIDX();
begin
   if MyCountry = 'JA' then begin
      mnCheckCountry.Visible := True;
      mnCheckMulti.Caption := 'Check Zone';
      EditScreen := TWWEdit.Create(Self);
      MyContest := TJIDXContest.Create('JIDX Contest (JA)');
   end
   else begin
      EditScreen := TGeneralEdit.Create(Self);
      HideBandMenuVU();
      MyContest := TJIDXContestDX.Create('JIDX Contest (DX)');
   end;

   QTHString := dmZlogGlobal.Settings._prov;
   dmZlogGlobal.Settings._sentstr := '$V';
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
   QTHString := dmZlogGlobal.Settings._city;
   // TQSO(Log.List[0]).QSO.memo := 'WPX Contest';
   dmZlogGlobal.Settings._sentstr := '$S';
end;

procedure TMainForm.InitARRL_W();
begin
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TDXCCEdit.Create(Self);

   MyContest := TARRLDXContestW.Create('ARRL International DX Contest (W/VE)');
   QTHString := dmZlogGlobal.Settings._prov;
   dmZlogGlobal.Settings._sentstr := '$V';
end;

procedure TMainForm.InitARRL_DX();
begin
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TARRLDXEdit.Create(Self);

   MyContest := TARRLDXContestDX.Create('ARRL International DX Contest (DX)');
   QTHString := dmZlogGlobal.Settings._prov;
   dmZlogGlobal.Settings._sentstr := '$N';
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

   if TARRL10Multi(MyContest.MultiForm).IsUSA then begin
      EditScreen := TDXCCEdit.Create(Self);
      dmZlogGlobal.Settings._sentstr := '$V';
   end
   else begin
      EditScreen := TIOTAEdit.Create(Self);
      dmZlogGlobal.Settings._sentstr := '$S';
   end;

   // QTHString := dmZlogGlobal.Settings._city;
//   dmZlogGlobal.Settings._sentstr := '$S';
end;

procedure TMainForm.InitIARU();
begin
   HideBandMenuVU();

   EditScreen := TIARUEdit.Create(Self);

   MyContest := TIARUContest.Create('IARU HF World Championship');
   // QTHString := dmZlogGlobal.Settings._city;
   dmZlogGlobal.Settings._sentstr := '$I';
   QTHString := MyZone;
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
      QTHString := dmZlogGlobal.Settings._prov;
      dmZlogGlobal.Settings._sentstr := '$A';

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
   // QTHString := dmZlogGlobal.Settings._city;
   dmZlogGlobal.Settings._sentstr := '$S$Q';
end;

procedure TMainForm.InitWAE();
begin
   BandMenu.Items[Ord(b19)].Visible := False;
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TWPXEdit.Create(Self);

   MyContest := TWAEContest.Create('WAEDC Contest');
   // QTHString := dmZlogGlobal.Settings._prov;
   dmZlogGlobal.Settings._sentstr := '$S';
end;

procedure TMainForm.ShowBandMenu(b: TBand);
begin
   BandMenu.Items[Ord(b)].Visible := True;
end;

procedure TMainForm.HideBandMenu(b: TBand);
begin
   BandMenu.Items[Ord(b)].Visible := False;
end;

procedure TMainForm.HideBandMenuHF();
begin
   BandMenu.Items[Ord(b19)].Visible := False;
   BandMenu.Items[Ord(b35)].Visible := False;
   BandMenu.Items[Ord(b7)].Visible := False;
   BandMenu.Items[Ord(b14)].Visible := False;
   BandMenu.Items[Ord(b21)].Visible := False;
   BandMenu.Items[Ord(b28)].Visible := False;
end;

procedure TMainForm.HideBandMenuWARC();
begin
   BandMenu.Items[Ord(b10)].Visible := False;
   BandMenu.Items[Ord(b18)].Visible := False;
   BandMenu.Items[Ord(b24)].Visible := False;
end;

procedure TMainForm.HideBandMenuVU(fInclude50: Boolean);
begin
   if fInclude50 = True then begin
      BandMenu.Items[Ord(b50)].Visible := False;
   end;
   BandMenu.Items[Ord(b144)].Visible := False;
   BandMenu.Items[Ord(b430)].Visible := False;
   BandMenu.Items[Ord(b1200)].Visible := False;
   BandMenu.Items[Ord(b2400)].Visible := False;
   BandMenu.Items[Ord(b5600)].Visible := False;
   BandMenu.Items[Ord(b10G)].Visible := False;
end;

function TMainForm.GetNumOfAvailableBands(): Integer;
var
   c: Integer;
   b: TBand;
begin
   c := 0;
   for b := b19 to HiBand do begin
      if (BandMenu.Items[Ord(b)].Visible = True) and
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
      if (BandMenu.Items[Ord(b)].Visible = True) then begin
         dmZlogGlobal.Settings._activebands[b] := True;
      end;
   end;
end;

function TMainForm.GetFirstAvailableBand(): TBand;
var
   b: TBand;
begin
   for b := b19 to HiBand do begin
      if (BandMenu.Items[Ord(b)].Visible = True) and
         (dmZlogGlobal.Settings._activebands[b] = True) then begin
         Result := b;
         Exit;
      end;
   end;

   for b := b19 to HiBand do begin
      if (BandMenu.Items[Ord(b)].Visible = True) then begin
         Result := b;
         Exit;
      end;
   end;

   Result := b19;
end;

procedure TMainForm.SetWindowCaption();
var
   strCap: string;
begin
   strCap := 'zLog for Windows';

   if dmZlogGlobal.Settings._multistation = True then begin
      strCap := strCap + ' - Multi station';
   end
   else begin
      strCap := strCap + ' - Running station';
   end;

   if dmZlogGlobal.Settings._zlinkport <> 0 then begin
      if dmZlogGlobal.Settings._pcname <> '' then begin
          strCap := strCap + ' [' + dmZlogGlobal.Settings._pcname + ']';
      end;
   end;

   strCap := strCap + ' - ' + ExtractFileName(CurrentFileName);

   Caption := strCap;
end;

procedure TMainForm.QSY(b: TBand; m: TMode);
begin
   if CurrentQSO.QSO.band <> b then begin
      UpdateBand(b);

      if RigControl.Rig <> nil then begin
         RigControl.Rig.SetBand(CurrentQSO);
      end;
   end;

   if CurrentQSO.QSO.mode <> m then begin
      UpdateMode(m);

      if RigControl.Rig <> nil then begin
         RigControl.Rig.SetMode(CurrentQSO);
      end;
   end;
end;

// F1～F8
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

   PlayMessage(cb, no);
end;

// F9
procedure TMainForm.actionCheckMultiExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('CheckMulti()'));
   {$ENDIF}

   MyContest.MultiForm.CheckMulti(CurrentQSO);

   LastFocus.SetFocus;
end;

// F10
procedure TMainForm.actionCheckPartialExecute(Sender: TObject);
begin
   PartialCheck.Show;

   if ActiveControl = NumberEdit then begin
      PartialCheck.CheckPartialNumber(CurrentQSO);
   end
   else begin
      PartialCheck.CheckPartial(CurrentQSO);
   end;

   LastFocus.SetFocus;
end;

// SHIFT+F1～F8
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

// CTRL+F1～F8
procedure TMainForm.actionQuickQSYExecute(Sender: TObject);
var
   no: Integer;
   b: TBand;
   m: TMode;
begin
   no := TAction(Sender).Tag;

   if dmZLogGlobal.Settings.FQuickQSY[no].FUse = False then begin
      Exit;
   end;

   b := dmZLogGlobal.Settings.FQuickQSY[no].FBand;
   m := dmZLogGlobal.Settings.FQuickQSY[no].FMode;

   QSY(b, m);

   LastFocus.SetFocus;
end;

procedure TMainForm.PlayMessage(bank: Integer; no: Integer);
var
   S: string;
begin
   case CurrentQSO.QSO.mode of
      mCW: begin
         S := dmZlogGlobal.CWMessage(bank, no);
         S := SetStr(S, CurrentQSO);
         zLogSendStr(S);
      end;

      mSSB, mFM, mAM: begin
//         SendVoice(i);
      end;

      mRTTY: begin
         S := dmZlogGlobal.CWMessage(3, no);
         S := SetStrNoAbbrev(S, CurrentQSO);
         if TTYConsole <> nil then begin
            TTYConsole.SendStrNow(S);
         end;
      end;

      else begin
         // NO OPERATION
      end;
   end;
end;

// CTRL+Enter, CTRL+N
procedure TMainForm.actionInsertBandScopeExecute(Sender: TObject);
begin
   InsertBandScope(False);
end;

// CTRL+SHIFT+N
procedure TMainForm.actionInsertBandScope3Execute(Sender: TObject);
begin
   InsertBandScope(True);
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
         BandScope2.CreateBSData(CurrentQSO, round(E * 1000));
      end;

      Result := True;
   end;
begin
   if RigControl.Rig <> nil then begin
      nFreq := RigControl.Rig.CurrentFreqHz;
      if nFreq > 0 then begin
         BandScope2.CreateBSData(CurrentQSO, nFreq);
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

// CTRL+S フォントサイズ↑
procedure TMainForm.actionIncreaseFontSizeExecute(Sender: TObject);
begin
   IncFontSize;
end;

// CTRL+SHIFT+S フォントサイズ↓
procedure TMainForm.actionDecreaseFontSizeExecute(Sender: TObject);
begin
   DecFontSize();
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

end.

