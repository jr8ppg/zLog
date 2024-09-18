﻿unit Main;

{
  zLog for Windows 令和Edition

  Copyright 1997-2005 by Yohei Yokobayashi.
  Portions created by JR8PPG are Copyright (C) 2019-2023 JR8PPG.

  This software is released under the MIT License.
}

{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StrUtils,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, Grids,
  ShlObj, ComObj, System.Actions, Vcl.ActnList, System.IniFiles, System.Math,
  System.DateUtils, System.SyncObjs, System.Generics.Collections, System.Zip,
  Winapi.MMSystem, JvExControls, JvLED,
  UzLogGlobal, UBasicMulti, UBasicScore, UALLJAMulti,
  UOptions, UOptions2, UEditDialog, UGeneralMulti2,
  UzLogCW, Hemibtn, ShellAPI, UITypes, UzLogKeyer,
  OEdit, URigControl, URigCtrlLib, UConsolePad, USpotClass,
  UMMTTY, UTTYConsole, UELogJarl1, UELogJarl2, UELogJarlEx, UELogCabrillo, UQuickRef, UZAnalyze,
  UPartials, URateDialog, URateDialogEx, USuperCheck, USuperCheck2, UComm, UCWKeyBoard, UChat,
  UZServerInquiry, UZLinkForm, USpotForm, UFreqList, UCheckCall2,
  UCheckMulti, UCheckCountry, UScratchSheet, UBandScope2, HelperLib,
  UWWMulti, UWWScore, UWWZone, UARRLWMulti, UQTCForm, UzLogQSO, UzLogConst, UzLogSpc,
  UCwMessagePad, UNRDialog, UzLogOperatorInfo, UFunctionKeyPanel, Progress,
  UQsyInfo, UserDefinedContest, UPluginManager, UQsoEdit, USo2rNeoCp, UInformation,
  UWinKeyerTester, UStatusEdit, UMessageManager, UzLogContest, UFreqTest, UBandPlan,
  UCWMonitor, UzLogForm;

const
  WM_ZLOG_INIT = (WM_USER + 100);
  WM_ZLOG_SETGRIDCOL = (WM_USER + 101);
  WM_ZLOG_SPCDATALOADED = (WM_USER + 102);
  WM_ZLOG_CQREPEAT_CONTINUE = (WM_USER + 103);
  WM_ZLOG_SPACEBAR_PROC = (WM_USER + 104);
  WM_ZLOG_SWITCH_RIG = (WM_USER + 105);
  WM_ZLOG_RESET_TX = (WM_USER + 106);
  WM_ZLOG_INVERT_TX = (WM_USER + 107);
  WM_ZLOG_SWITCH_RX = (WM_USER + 108);
  WM_ZLOG_SWITCH_TXRX = (WM_USER + 109);
  WM_ZLOG_AFTER_DELAY = (WM_USER + 110);
  WM_ZLOG_SETCQ = (WM_USER + 111);
  WM_ZLOG_SET_CQ_LOOP = (WM_USER + 112);
  WM_ZLOG_CALLSIGNSENT = (WM_USER + 113);
  WM_ZLOG_SWITCH_TX = (WM_USER + 114);
  WM_ZLOG_SETCURRENTQSO = (WM_USER + 115);
  WM_ZLOG_TABKEYPRESS = (WM_USER + 116);
  WM_ZLOG_DOWNKEYPRESS = (WM_USER + 117);
  WM_ZLOG_PLAYMESSAGEA = (WM_USER + 118);
  WM_ZLOG_PLAYMESSAGEB = (WM_USER + 119);
  WM_ZLOG_PLAYCQ = (WM_USER + 120);
  WM_ZLOG_TOGGLE_PTT = (WM_USER + 121);
  WM_ZLOG_SHOWMESSAGE = (WM_USER + 122);
  WM_ZLOG_FILEDOWNLOAD_COMPLETE = (WM_USER + 123);
  WM_ZLOG_SETFOCUS = (WM_USER + 124);
  WM_ZLOG_GETCALLSIGN = (WM_USER + 200);
  WM_ZLOG_GETVERSION = (WM_USER + 201);
  WM_ZLOG_SETPTTSTATE = (WM_USER + 202);
  WM_ZLOG_SETTXINDICATOR = (WM_USER + 203);
  WM_ZLOG_SETFOCUS_CALLSIGN = (WM_USER + 204);
  WM_ZLOG_SETSTATUSTEXT = (WM_USER + 205);
  WM_ZLOG_MOVELASTFREQ = (WM_USER + 206);
  WM_ZLOG_SHOWOPTIONS = (WM_USER + 207);
  WM_ZLOG_CQABORT = (WM_USER + 208);

type
  TEditPanel = record
    SerialEdit: TEdit;        // 0
    TimeEdit: TOvrEdit;       // 1
    DateEdit: TOvrEdit;       // 1
    CallsignEdit: TOvrEdit;   // 2
    rcvdRSTEdit: TEdit;       // 3
    NumberEdit: TOvrEdit;     // 4
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
    TxLed: TJvLED;
  end;
  TEditPanelArray = array[0..2] of TEditPanel;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    FilePrintItem: TMenuItem;
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
    Options2Button: TSpeedButton;
    OpMenu: TPopupMenu;
    SuperCheckButtpn: TSpeedButton;
    CWStopButton: TSpeedButton;
    CWPauseButton: TSpeedButton;
    buttonCwKeyboard: TSpeedButton;
    SpeedBar: TTrackBar;
    SpeedLabel: TLabel;
    CWPlayButton: TSpeedButton;
    Timer1: TTimer;
    InsertQSO1: TMenuItem;
    N10GHzup1: TMenuItem;
    Export1: TMenuItem;
    FileExportDialog: TSaveDialog;
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
    N5: TMenuItem;
    Score1: TMenuItem;
    Multipliers1: TMenuItem;
    QSOrate1: TMenuItem;
    PacketCluster1: TMenuItem;
    SuperCheck1: TMenuItem;
    PartialCheck1: TMenuItem;
    menuChangeBand: TMenuItem;
    menuChangeMode: TMenuItem;
    menuChangeOperator: TMenuItem;
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
    menuDownloadAllLogs: TMenuItem;
    menuMergeAllLogs: TMenuItem;
    menuConnectToZServer: TMenuItem;
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
    PluginMenu: TMenuItem;
    View1: TMenuItem;
    menuShowCurrentBandOnly: TMenuItem;
    menuSortByTime: TMenuItem;
    CallsignEdit1: TOvrEdit;
    NumberEdit1: TOvrEdit;
    MemoEdit1: TOvrEdit;
    TimeEdit1: TOvrEdit;
    DateEdit1: TOvrEdit;
    ZServerIcon: TImage;
    GeneralSaveDialog: TSaveDialog;
    mPXListWPX: TMenuItem;
    mSummaryFile: TMenuItem;
    menuChangePower: TMenuItem;
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
    menuChangeTXNr: TMenuItem;
    mnGridAddNewPX: TMenuItem;
    mnHideCWPhToolBar: TMenuItem;
    mnHideMenuToolbar: TMenuItem;
    Scratchsheet1: TMenuItem;
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
    actionToggleSo2r2bsiq: TAction;
    checkUseRig3: TCheckBox;
    actionSo2rNeoToggleAutoRxSelect: TAction;
    actionToggleTx: TAction;
    ledTx2A: TJvLED;
    ledTx2B: TJvLED;
    actionToggleSo2rWait: TAction;
    actionToggleRx: TAction;
    actionMatchRxToTx: TAction;
    actionMatchTxToRx: TAction;
    labelRig1Title: TLabel;
    labelRig2Title: TLabel;
    ledTx2C: TJvLED;
    labelRig3Title: TLabel;
    checkWithRig1: TCheckBox;
    checkWithRig2: TCheckBox;
    actionSo2rToggleRigPair: TAction;
    MainPanel: TPanel;
    EditUpperLeftPanel: TPanel;
    EditUpperRightPanel: TGridPanel;
    timerCqRepeat: TTimer;
    FileImportDialog: TOpenDialog;
    actionChangeTxNr0: TAction;
    actionChangeTxNr1: TAction;
    actionChangeTxNr2: TAction;
    actionPseQsl: TAction;
    actionNoQsl: TAction;
    ToolBarPanel: TPanel;
    menuSortByTxNo: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N12: TMenuItem;
    Sort1: TMenuItem;
    menuSortByCallsign: TMenuItem;
    menuSortByMode: TMenuItem;
    menuSortByBand: TMenuItem;
    menuSortByPower: TMenuItem;
    menuSortByPoint: TMenuItem;
    menuSortByOperator: TMenuItem;
    menuSortByMemo: TMenuItem;
    N13: TMenuItem;
    menuEditStatus: TMenuItem;
    comboBandPlan: TComboBox;
    actionShowMsgMgr: TAction;
    ShowMessageManagerSO2R1: TMenuItem;
    actionChangeBand2: TAction;
    actionChangeMode2: TAction;
    actionChangePower2: TAction;
    menuUsersGuide: TMenuItem;
    menuPortal: TMenuItem;
    menuCorrectStartTime: TMenuItem;
    FT41: TMenuItem;
    FT81: TMenuItem;
    actionToggleTxNr: TAction;
    panelOutOfPeriod: TPanel;
    timerOutOfPeriod: TTimer;
    menuChangeSentNr: TMenuItem;
    menuChangeDate: TMenuItem;
    actionShowCWMonitor: TAction;
    menuShowCWMonitor: TMenuItem;
    panelShowInfo: TPanel;
    linklabelInfo: TLinkLabel;
    timerShowInfo: TTimer;
    actionShowCurrentTxOnly: TAction;
    menuShowThisTXonly: TMenuItem;
    menuShowOnlySpecifiedTX: TMenuItem;
    menuShowTx0: TMenuItem;
    menuShowTx1: TMenuItem;
    menuShowTx2: TMenuItem;
    menuShowTx3: TMenuItem;
    menuShowTx4: TMenuItem;
    menuShowTx5: TMenuItem;
    menuShowTx6: TMenuItem;
    menuShowTx7: TMenuItem;
    menuShowTx8: TMenuItem;
    menuShowTx9: TMenuItem;
    CreateCabrillo: TMenuItem;
    menuHardwareSettings: TMenuItem;
    actionLogging: TAction;
    actionSetRigWPM: TAction;
    N3: TMenuItem;
    menuDownloadOplist: TMenuItem;
    menuUploadOplist: TMenuItem;
    menuDownloadSounds: TMenuItem;
    N14: TMenuItem;
    menuUploadSounds: TMenuItem;
    OptionsButton: TSpeedButton;
    buttonCancelOutOfPeriod: TSpeedButton;
    CreateJARLELog: TMenuItem;
    actionToggleMemScan: TAction;
    actionToggleF2A: TAction;
    buttonF2A: TSpeedButton;
    menuQTC: TMenuItem;
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
    procedure FormShow(Sender: TObject);
    procedure CWFButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedBarChange(Sender: TObject);
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
    procedure menuDownloadAllLogsClick(Sender: TObject);
    procedure menuSortByTimeClick(Sender: TObject);
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
    procedure menuMergeAllLogsClick(Sender: TObject);
    procedure menuConnectToZServerClick(Sender: TObject);
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
    procedure GridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StatusLineResize(Sender: TObject);
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
    procedure OnZLogCqRepeatContinue( var Message: TMessage ); message WM_ZLOG_CQREPEAT_CONTINUE;
    procedure OnZLogSpaceBarProc( var Message: TMessage ); message WM_ZLOG_SPACEBAR_PROC;
    procedure OnZLogSwitchRig( var Message: TMessage ); message WM_ZLOG_SWITCH_RIG;
    procedure OnZLogPlayMessageA( var Message: TMessage ); message WM_ZLOG_PLAYMESSAGEA;
    procedure OnZLogPlayMessageB( var Message: TMessage ); message WM_ZLOG_PLAYMESSAGEB;
    procedure OnZLogPlayCQ( var Message: TMessage ); message WM_ZLOG_PLAYCQ;
    procedure OnZLogTogglePtt( var Message: TMessage ); message WM_ZLOG_TOGGLE_PTT;
    procedure OnZLogShowMessage( var Message: TMessage ); message WM_ZLOG_SHOWMESSAGE;
    procedure OnZLogFileDownloadComplete( var Message: TMessage ); message WM_ZLOG_FILEDOWNLOAD_COMPLETE;
    procedure OnZLogSetFocus( var Message: TMessage ); message WM_ZLOG_SETFOCUS;
    procedure OnZLogResetTx( var Message: TMessage ); message WM_ZLOG_RESET_TX;
    procedure OnZLogInvertTx( var Message: TMessage ); message WM_ZLOG_INVERT_TX;
    procedure OnZLogSwitchRx( var Message: TMessage ); message WM_ZLOG_SWITCH_RX;
    procedure OnZLogSwitchTx( var Message: TMessage ); message WM_ZLOG_SWITCH_TX;
    procedure OnZLogSwitchTxRx( var Message: TMessage ); message WM_ZLOG_SWITCH_TXRX;
    procedure OnZLogAfterDelay( var Message: TMessage ); message WM_ZLOG_AFTER_DELAY;
    procedure OnZLogSetCq( var Message: TMessage ); message WM_ZLOG_SETCQ;
    procedure OnZLogSetCQLoop( var Message: TMessage ); message WM_ZLOG_SET_CQ_LOOP;
    procedure OnZLogCallsignSent( var Message: TMessage ); message WM_ZLOG_CALLSIGNSENT;
    procedure OnZLogSetCurrentQso( var Message: TMessage ); message WM_ZLOG_SETCURRENTQSO;
    procedure OnZLogTabKeyPress( var Message: TMessage ); message WM_ZLOG_TABKEYPRESS;
    procedure OnZLogDownKeyPress( var Message: TMessage ); message WM_ZLOG_DOWNKEYPRESS;
    procedure OnZLogGetCallsign( var Message: TMessage ); message WM_ZLOG_GETCALLSIGN;
    procedure OnZLogGetVersion( var Message: TMessage ); message WM_ZLOG_GETVERSION;
    procedure OnZLogSetPttState( var Message: TMessage ); message WM_ZLOG_SETPTTSTATE;
    procedure OnZLogSetTxIndicator( var Message: TMessage ); message WM_ZLOG_SETTXINDICATOR;
    procedure OnZLogSetFocusCallsign( var Message: TMessage ); message WM_ZLOG_SETFOCUS_CALLSIGN;
    procedure OnZLogSetStatusText( var Message: TMessage ); message WM_ZLOG_SETSTATUSTEXT;
    procedure OnZLogMoveLastFreq( var Message: TMessage ); message WM_ZLOG_MOVELASTFREQ;
    procedure OnZLogShowOptions( var Message: TMessage ); message WM_ZLOG_SHOWOPTIONS;
    procedure OnZLogCqAbortProc( var Message: TMessage ); message WM_ZLOG_CQABORT;
    procedure OnDeviceChange( var Message: TMessage ); message WM_DEVICECHANGE;
    procedure OnPowerBroadcast( var Message: TMessage ); message WM_POWERBROADCAST;
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
    procedure actionToggleSo2r2bsiqExecute(Sender: TObject);
    procedure checkUseRig3Click(Sender: TObject);
    procedure actionSo2rNeoToggleAutoRxSelectExecute(Sender: TObject);
    procedure actionToggleTxExecute(Sender: TObject);
    procedure actionToggleSo2rWaitExecute(Sender: TObject);
    procedure actionToggleRxExecute(Sender: TObject);
    procedure actionMatchRxToTxExecute(Sender: TObject);
    procedure actionMatchTxToRxExecute(Sender: TObject);
    procedure labelRig3TitleClick(Sender: TObject);
    procedure checkWithRigClick(Sender: TObject);
    procedure actionSo2rToggleRigPairExecute(Sender: TObject);
    procedure timerCqRepeatTimer(Sender: TObject);
    procedure FileExportDialogTypeChange(Sender: TObject);
    procedure actionChangeTxNrExecute(Sender: TObject);
    procedure actionPseQslExecute(Sender: TObject);
    procedure actionNoQslExecute(Sender: TObject);
    procedure menuSortByTxNoBandTimeClick(Sender: TObject);
    procedure menuSortByClick(Sender: TObject);
    procedure menuEditStatusClick(Sender: TObject);
    procedure comboBandPlanChange(Sender: TObject);
    procedure actionShowMsgMgrExecute(Sender: TObject);
    procedure menuUsersGuideClick(Sender: TObject);
    procedure menuPortalClick(Sender: TObject);
    procedure menuCorrectStartTimeClick(Sender: TObject);
    procedure FileMenuClick(Sender: TObject);
    procedure actionToggleTxNrExecute(Sender: TObject);
    procedure timerOutOfPeriodTimer(Sender: TObject);
    procedure menuChangeSentNrClick(Sender: TObject);
    procedure menuChangeDateClick(Sender: TObject);
    procedure actionShowCWMonitorExecute(Sender: TObject);
    procedure timerShowInfoTimer(Sender: TObject);
    procedure actionShowCurrentTxOnlyExecute(Sender: TObject);
    procedure menuShowOnlyTxClick(Sender: TObject);
    procedure View1Click(Sender: TObject);
    procedure CreateCabrilloClick(Sender: TObject);
    procedure menuHardwareSettingsClick(Sender: TObject);
    procedure actionLoggingExecute(Sender: TObject);
    procedure actionSetRigWPMExecute(Sender: TObject);
    procedure menuDownloadOplistClick(Sender: TObject);
    procedure menuUploadOplistClick(Sender: TObject);
    procedure menuUploadSoundsClick(Sender: TObject);
    procedure menuDownloadSoundsClick(Sender: TObject);
    procedure buttonCancelOutOfPeriodClick(Sender: TObject);
    procedure CreateJARLELogClick(Sender: TObject);
    procedure actionToggleMemScanExecute(Sender: TObject);
    procedure actionToggleF2AExecute(Sender: TObject);
    procedure buttonF2AClick(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
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
    FConsolePad: TConsolePad;
    FFreqList: TFreqList;
    FCheckCall2: TCheckCall2;
    FCheckMulti: TCheckMulti;
    FCheckCountry: TCheckCountry;
    FScratchSheet: TScratchSheet;
    FBandScopeEx: TBandScopeArray;
    FBandScope: TBandScope2;
    FBandScopeNewMulti: TBandScope2;
    FBandScopeAllBands: TBandScope2;
    FQuickRef: TQuickRef;              // Quick Reference
    FZAnalyze: TZAnalyze;              // Analyze window
    FCWMessagePad: TCwMessagePad;
    FMessageManager: TformMessageManager;
    FFunctionKeyPanel: TformFunctionKeyPanel;
    FQsyInfoForm: TformQsyInfo;
    FSo2rNeoCp: TformSo2rNeoCp;
    FInformation: TformInformation;
    FTTYConsole: TTTYConsole;
    FWinKeyerTester: TformWinKeyerTester;
    FFreqTest: TformFreqTest;
    FCWMonitor: TformCWMonitor;
    FProgress: TformProgress;

    FInitialized: Boolean;

    FPrevTotalQSO: Integer;
    FTempQSOList: TQSOList;
    clStatusLine : TColor;
    OldCallsign, OldNumber : string;
    defaultTextColor : TColor;

    SaveInBackGround: Boolean;
    FLastTabPress: TDateTime;

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
    FQsyCountPrevHour: string;

    FCurrentRx: Integer;
    FCurrentTx: Integer;
    FEditPanel: TEditPanelArray;
    FRigSwitchTime: TDateTime;
    FKeyPressedRigID: array[0..4] of Integer;

    // NEW CQRepeat
    FCQLoopRunning: Boolean;
    FCQLoopCount: Integer;
    FCQLoopStartRig: Integer;
    FCtrlZCQLoop: Boolean;
    FCQRepeatStartMode: TMode;
    FCQRepeatPlaying: Boolean;
    FTabKeyPressed: array[0..4] of Boolean;
    FDownKeyPressed: array[0..4] of Boolean;
    FOtherKeyPressed: array[0..4] of Boolean;
    F2bsiqStart: Boolean;

    FCQRepeatCount: Integer;
    FCQRepeatInterval: Integer;

    FCurrentRigSet: Integer; // 現在のRIGSET 1/2/3
    FWaitForQsoFinish: array[0..4] of Boolean;

    // バンドスコープからのJUMP用
    FPrev2bsiqMode: Boolean;
    FLastFreq: array[1..3] of TFrequency;
    FLastMode: array[1..3] of TMode;

    FPastEditMode: Boolean;
    FFilterTx: Integer;

    FTaskbarList: ITaskbarList;

    FFirstOutOfContestPeriod: Boolean;
    FOutOfContestPeriod: Boolean;
    FPrevOutOfContestPeriod: Boolean;

    FRigModeBackup: TMode;
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
    procedure OnDownKeyPress;
    procedure RestoreWindowStates;
    procedure RecordWindowStates;
    procedure SwitchLastQSOBandMode;
    procedure CallsignSentProc(Sender: TObject); // called when callsign is sent;
    procedure Update10MinTimer; //10 min countdown
    procedure SaveFileAndBackUp;
    procedure ChangeTxNr(txnr: Integer);
    procedure IncFontSize();
    procedure DecFontSize();
    procedure SetFontSize(font_size: Integer);
    procedure QSY(b: TBand; m: TMode; r: Integer);
    procedure OnPlayMessageA(no: Integer);
    procedure OnPlayMessageB(no: Integer);
    procedure PlayMessage(mode: TMode; bank: Integer; no: Integer; fResetTx: Boolean);
    procedure PlayMessageCW(bank: Integer; no: Integer; fResetTx: Boolean);
    procedure PlayMessagePH(no: Integer; fResetTx: Boolean);
    procedure PlayMessageRTTY(no: Integer);
    procedure OnVoicePlayStarted(Sender: TObject);
    procedure OnOneCharSentProc(Sender: TObject);
    procedure OnPlayMessageFinished(Sender: TObject; mode: TMode; fAbort: Boolean);
    procedure OnPaddle(Sender: TObject);
    procedure InsertBandScope(fShiftKey: Boolean);
    procedure WriteKeymap();
    procedure ReadKeymap();
    procedure ResetKeymap();
    procedure SetShortcutEnabled(shortcut: string; fEnabled: Boolean);
    procedure CQRepeatProc(nSpeedUp: Integer; fFirst: Boolean);

    // Super Check関係
    procedure SuperCheckDataLoad();
    procedure SuperCheckInitData();
    procedure SuperCheckFreeData();
    procedure CheckSuper(aQSO: TQSO);
    procedure CheckSuper2(aQSO: TQSO);
    procedure TerminateNPlusOne();
    procedure TerminateSuperCheckDataLoad();
    procedure OnSPCMenuItemCick(Sender: TObject);

    procedure DoCwCommandProc(Sebder: TObject; nCommand: Integer);
    procedure DoWkStatusProc(Sender: TObject; tx: Integer; rx: Integer; ptt: Boolean);
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
    procedure InitQsoEditPanel();
    procedure UpdateQsoEditPanel(rig: Integer);
    procedure SwitchRig(rigset: Integer);
    procedure SwitchTxRx(tx_rig, rx_rig: Integer);
    procedure SwitchTx(rigset: Integer);
    procedure SwitchRx(rigset: Integer; focusonly: Boolean = False);
    procedure ShowTxIndicator();
    procedure InvertTx();
    procedure ShowCurrentQSO();

    procedure GridAdd(aQSO: TQSO);
    procedure GridWriteQSO(R: Integer; aQSO: TQSO);
    procedure GridClearQSO(R: Integer);
    procedure SetGridWidth(editor: TBasicEdit);
    function GetGridColmunLeft(col: Integer): Integer;
    procedure SetEditFields1R(editor: TBasicEdit);
    function GetNextRigID(curid: Integer): Integer;

    procedure UpdateBandAndMode();
    procedure CancelCqRepeat();
    procedure ResetTx(rigset: Integer);
    procedure StopMessage(mode: TMode);
    procedure ControlPTT(fOn: Boolean);
    procedure VoiceControl(fOn: Boolean);
    procedure TogglePTTfor2bsiq();
    procedure OnNonconvertKeyProc();
    procedure OnUpKeyProc(Sender: TObject);
    procedure OnAlphaNumericKeyProc(Sender: TObject; var Key: word);
    procedure UpdateCurrentQSO();
    procedure CQAbort(fReturnStartRig: Boolean);
    procedure SpaceBarProc(nID: Integer);
    procedure ShowToolBar(M: TMode);
    procedure InitSerialPanel();
    procedure DispSerialNumber(aQSO: TQSO);
    procedure InitSerialNumber();
    procedure RestoreSerialNumber();
    procedure SetInitSerialNumber(aQSO: TQSO);
    procedure SetNextSerialNumber(aQSO: TQSO);
    procedure SetNextSerialNumber2(aQSO: TQSO; Local : Boolean);
    procedure SetNextSerialNumber3(aQSO: TQSO);
    procedure ScrollGrid();
    procedure SetCurrentQSO(nID: Integer);
    procedure EditCurrentRow();
    procedure AssignControls(nID: Integer; var C, N, B, M, S, O: TEdit);
    procedure CallSpaceBarProc(C, N, B: TEdit);
    procedure ShowSentNumber();
    procedure SetCqRepeatMode(fOn: Boolean; fFirst: Boolean);
    procedure StartCqRepeatTimer();
    procedure StopCqRepeatTimer();
    function Is2bsiq(): Boolean;
    procedure LogButtonProc(nID: Integer; Q: TQSO);
    function InputStartTime(fNeedSave: Boolean): Boolean;
    procedure EnableShiftKeyAction(fEnable: Boolean);
    procedure ShowOutOfContestPeriod(fShow: Boolean);
    procedure ShowOptionsDialog(nEditMode: Integer; nEditNumer: Integer; nEditBank: Integer; nActiveTab: Integer);
    procedure ShowInfoPanel(text: string; handler: TSysLinkEvent; fShow: Boolean);
    procedure DoNewDataArrived(Sender: TObject; const Link: string; LinkType: TSysLinkType);
    function GetQsoList(): TQSOList;
    procedure JarlMemberCheck();
    procedure ExportHamlog(f: string);
    procedure SetRigWpm(wpm: Integer);
    procedure ExtractSoundFiles(zipfilename: string);
    function CompressSoundFiles(): Boolean;
    procedure SaveLastFreq();
    procedure ShowCtyChk();
    procedure SetEnableF2A();
    procedure SetF2AMode();
    procedure ResetF2AMode();
    procedure F2AOff();
    procedure OnChangeFontSize(Sender: TObject; font_size: Integer);
    procedure SetupQTC();
  public
    EditScreen : TBasicEdit;
    LastFocus : TEdit;
    procedure SetR(var aQSO : TQSO); // RST
    procedure SetS(var aQSO : TQSO);

    function GetNextBand(BB : TBand; Up : Boolean) : TBand;

    procedure GridRefreshScreen(fSelectRow: Boolean = False; fNewData: Boolean = False);

    procedure SetQSOMode(aQSO: TQSO; fUp: Boolean);
    procedure WriteStatusLine(S: string; fWriteConsole: Boolean);
    procedure WriteStatusLineRed(S: string; fWriteConsole: Boolean);
    procedure WriteStatusText(S: string; fRed, fWriteConsole: Boolean);
    procedure ProcessConsoleCommand(S : string);
    procedure UpdateBand(B : TBand); // takes care of window disp
    procedure UpdateMode(M : TMode);
    procedure DisableNetworkMenus;
    procedure EnableNetworkMenus;
    procedure ReEvaluateCountDownTimer;
    procedure ReEvaluateQSYCount;
    procedure AutoInput(D : TBSData);
    procedure ConsoleRigBandSet(B: TBand);
    procedure RenewScore();

    procedure ShowBandMenu(b: TBand);
    procedure HideBandMenu(b: TBand);
    procedure HideBandMenuHF();
    procedure HideBandMenuWARC();
    procedure HideBandMenuVU(fInclude50: Boolean = True);

    procedure HighlightCallsign(fHighlight: Boolean);
    procedure BandScopeNotifyWorked(aQSO: TQSO);
    procedure SetYourCallsign(strCallsign, strNumber: string);
    procedure SetFrequency(freq: TFrequency);
    procedure Restore2bsiqMode();
    procedure BSRefresh();
    procedure BuildOpListMenu2(P: TMenuItem; OnClickHandler: TNotifyEvent);
    procedure BuildTxNrMenu2(P: TMenuItem; OnClickHandler: TNotifyEvent);

    procedure BandScopeAddSelfSpot(aQSO: TQSO; nFreq: TFrequency);
    procedure BandScopeAddSelfSpotFromNetwork(BSText: string);
    procedure BandScopeAddClusterSpot(Sp: TSpot);
    procedure BandScopeMarkCurrentFreq(B: TBand; Hz: TFrequency);
    procedure BandScopeUpdateSpot(aQSO: TQSO);
    procedure BandScopeApplyBandPlan();

    procedure InitBandMenu();

    procedure ShowRigControlInfo(strText: string);

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
    property MessageManager: TformMessageManager read FMessageManager;
    property CWMonitor: TformCWMonitor read FCWMonitor;

    property CurrentRigID: Integer read GetCurrentRigID;
    property CurrentTX: Integer read FCurrentTX;
    property CurrentRX: Integer read FCurrentRX;
//    property TabKeyPressedRigID: Integer read FKeyPressedRigID;
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
    procedure AddTaskbar(Handle: THandle);
    procedure DelTaskbar(Handle: THandle);

    procedure SetLastFocus();

    procedure MsgMgrAddQue(nID: Integer; S: string; aQSO: TQSO);
    procedure MsgMgrContinueQue();
    function GetTxRigID(nTxRigSet: Integer = -1): Integer;
  end;

  TBandScopeNotifyThread = class(TThread)
  private
    FParent: TForm;
    FQso: TQSO;
  protected
    procedure Execute; override;
  public
    constructor Create(formParent: TForm; aQSO: TQSO);
  end;

resourcestring
  TMainForm_Enter_Frequency = 'Enter frequency in kHz';
  TMainForm_Comfirm_Delete_Qso = 'Are you sure to delete this QSO?';
  TMainForm_Comfirm_Delete_Qsos = 'Are you sure to delete these QSO''s?';
  TMainForm_New_Multi_Only = 'This station is not a new multiplier, but will be logged anyway.';
  TMainForm_Change_Date = 'To change the date, double click the time field.';
  TMainForm_Confirm_Save_Changes = 'Save changes to %s ?';
  TMainForm_Active_Band_Adjusted = 'Active Bands adjusted to the required bands';
  TMainForm_Change_Band_QSOs = 'Are you sure to change the band for these QSO''s?';
  TMainForm_Change_Mode_QSOs = 'Are you sure to change the mode for these QSO''s?';
  TMainForm_Change_Operator_QSOs = 'Are you sure to change the operator names for these QSO''s?';
  TMainForm_Change_Power_QSOs = 'Are you sure to change the power for these QSO''s?';
  TMainForm_Change_TXNO_QSOs = 'Are you sure to change the TX# for these QSO''s?';
  TMainForm_Need_File_Name = 'Data will NOT be saved until you enter the file name';
  TMainForm_QTC_Sent = 'QTC can be sent by pressing %s';
  TMainForm_QTC_no_shortcut_keys = 'No shortcut keys are assigned for QTC';
  TMainForm_Less_Than_10min = 'Less than 10 min since last QSY!';
  TMainForm_QSY_Count_Exceeded = 'QSY count exceeded limit!';
  TMainForm_Loading_now = 'Loading...';
  TMainForm_Switch_CW_Bank_A = 'CW Bank A';
  TMainForm_Switch_CW_Bank_B = 'CW Bank B';
  TMainForm_This_QSO_is_locked = 'This QSO is currently locked';
  TMainForm_Invalid_number = 'Invalid number';
  TMainForm_Callsign_not_entered = 'Callsign not entered';
  TMainForm_Dupe_qso = 'Dupe';
  TMainForm_Thankyou_for_your_qso = 'Thank you for the QSO with JA1ZLO';
  TMainForm_CW_port_is_no_set = 'CW port is not set';
  TMainForm_Not_a_new_multi = 'NOT a new multiplier. (This is a multi stn)';
  TMainForm_Cannot_merge_current_file = 'Cannot merge current file';
  TMainForm_Merging_now = 'Merging...';
  TMainForm_Some_qsos_merged = '%s QSO(s) merged.';
  TMainForm_CtyDat_not_loaded = 'CTY.DAT not loaded';
  TMainForm_RIT_XIT_Cleared = 'RIT/XIT Offset Cleared';
  TMainForm_Anti_zeroin = '** Anti Zeroin **';
  TMainForm_Set_CQ_Repeat_Int = 'CQ Repeat Int. %.1f sec.';
  TMainForm_Invalid_zone = 'Invalid zone';
  TMainForm_JudgePeriod = 'Do you want to judge whether all QSOs are within the contest period?';
  TMainForm_EmptyOpList = 'Operator list is empty.';
  TMainForm_Setup_SentNR_first = 'Setup Prov/State and City code first';
  TMainForm_New_QSO_Arrived = 'New QSO data has arrived. click here to view.';
  TMainForm_Select_Operator = 'Please select an operator';
  TMainForm_JARL_Member_Info = 'JARL Member information.';
  TMainForm_Inquire_JARL_Member_Info = 'Querying QSL transfer status.';
  TMainForm_UserDat_not_loaded = ' not loaded';
  TMainForm_ZserverNotConfigured = 'Z-Server settings are not configured.';
  TMainForm_ComfirmUploadOpList = 'Upload the operator list to Z-Server. Are you sure?';
  TMainForm_ComfirmDownloadOpList = 'Would you like to download the operator list?' + #13#10 + 'Overwrite the existing operator list.';
  TMainForm_DownloadFile = 'Downloading...';
  TMainForm_UploadFile = 'Uploading...';
  TMainForm_SoundFileFolderNotSet = 'Sound file folder not set.';
  TMainForm_Compressing = 'Compressing...';
  TMainForm_FailedToCompressSoundFiles = 'Failed to compress sound files.';
  TMainForm_FileNotFound = 'file not found.';
  TMainForm_ComfirmUploadSound = 'Upload the sound file to Z-Server. Are you sure?';
  TMainForm_ComfirmDownloadSound = 'Would you like to download the sound file?' + #13#10 + 'Overwrite the existing sound file.';
  TMainForm_ConfirmRewindSerialNumber = 'Do you want to rewind the serial number?';
  TMainForm_ConfirmContestPeriod = 'Do you want to change the contest period to "not used"?';
  TMainForm_ConfirmOverwrite = '[%s] file already exists. overwrite?';
  TMainForm_ConfirmModeConvert = 'Mode contains old Other, convert to new Other?';  // 'モードにOther(旧)が含まれています。Other(新)に変換しますか？'
  TMainForm_No_QTC_Message = 'No messages to send in QTC';  // 'QTCで送るメッセージはありません'
  TMainForm_Assigned_Another_Function = 'CTRL+Q is assigned to another function. Do you want to take it?';  // 'CTRL+Qは他の機能にアサインされています。横取りしますか？'

var
  MainForm: TMainForm;
  CurrentQSO: TQSO;

var
  MyContest : TContest = nil;

implementation

uses
  UAbout, UMenu, UACAGMulti,
  UALLJAScore,
  UJIDXMulti, UJIDXScore, UJIDXScore2, UWPXMulti, UWPXScore,
  UPediScore, UJIDX_DX_Multi, UJIDX_DX_Score,
  UGeneralScore, UFDMulti, UARRLDXMulti,
  UARRLDXScore, UAPSprintScore, UJA0Multi, UJA0Score,
  UKCJMulti, USixDownMulti, UIARUMulti,
  UIARUScore, UAllAsianScore, UIOTAMulti, {UIOTACategory,} UARRL10Multi,
  UARRL10Score,
  UIntegerDialog, UNewPrefix, UKCJScore, UJarlMemberInfo,
  UWAEScore, UWAEMulti, USummaryInfo, UBandPlanEditDialog, UGraphColorDialog,
  UAgeDialog, UMultipliers, UUTCDialog, UNewIOTARef, UzLogExtension,
  UTargetEditor, UExportHamlog, UExportCabrillo, UStartTimeDialog, UDateDialog,
  UCountryChecker;

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

procedure TMainForm.WriteStatusLine(S: string; fWriteConsole: Boolean);
begin
   WriteStatusText(S, False, fWriteConsole);
end;

procedure TMainForm.WriteStatusLineRed(S: string; fWriteConsole: Boolean);
begin
   WriteStatusText(S, True, fWriteConsole);
end;

procedure TMainForm.WriteStatusText(S: string; fRed, fWriteConsole: Boolean);
var
   text_atom: ATOM;
   wRed, wConsole: WORD;
begin
   if fRed = False then begin
      wRed := 0;
   end
   else begin
      wRed := 1;
   end;

   if fWriteConsole = False then begin
      wConsole := 0;
   end
   else begin
      wConsole := 1;
   end;

   text_atom := AddAtom(PChar(S));
   SendMessage(Handle, WM_ZLOG_SETSTATUSTEXT, MAKEWPARAM(wRed, wConsole), MAKELPARAM(text_atom, 0));
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
         CurrentEditPanel.NumberEdit.Text := CurrentQSO.NrRcvd;
         CurrentEditPanel.BandEdit.Text := MHzString[CurrentQSO.Band];
         CurrentEditPanel.PowerEdit.Text := NewPowerString[CurrentQSO.Power];
         CurrentEditPanel.PointEdit.Text := CurrentQSO.PointStr;
         CurrentEditPanel.RcvdRSTEdit.Text := CurrentQSO.RSTStr;
         TimeEdit.Text := CurrentQSO.TimeStr;
         DateEdit.Text := CurrentQSO.DateStr;
         ModeEdit.Text := ModeString[CurrentQSO.Mode];
      end;

      ShowToolBar(CurrentQSO.Mode);

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
   FInformation.So2rMode := (dmZLogGlobal.Settings._operate_style = os2Radio);
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
   nextband: TBand;
   rig: TRig;
   maxband, minband: TBand;
   original: TBand;
begin
   original := B0;

   // 次のバンド候補
   nextband := B0;
   if nextband >= HiBand then begin
      nextband := b19;
   end
   else begin
      Inc(nextband);
   end;

   // 次のバンドに対応したリグはあるか
   rig := RigControl.GetRig(FCurrentRigSet, nextband);
   if rig = nil then begin // ない
      rig := RigControl.GetRig(FCurrentRigSet, B0);
      if rig = nil then begin
         B0 := nextband;
         minband := b19;
         maxband := HiBand;
      end
      else begin
         minband := rig.MinBand;
         maxband := rig.MaxBand;
      end;
   end
   else begin  // あった
      B0 := nextband;
      minband := rig.MinBand;
      maxband := rig.MaxBand;
   end;

   // minband～maxband内をスキャン
   for B := B0 to maxband do begin
      if IsAvailableBand(B) = True then begin
         Result := B;
         Exit;
      end;
   end;

   for B := minband to B0 do begin
      if IsAvailableBand(B) = True then begin
         Result := B;
         Exit;
      end;
   end;

   Result := original;
end;

function TMainForm.ScanPrevBand(B0: TBand): TBand;
var
   B: TBand;
   prevband: TBand;
   rig: TRig;
   maxband, minband: TBand;
   original: TBand;
begin
   original := B0;

   // 次のバンド候補
   prevband := B0;
   if prevband <= b19 then begin
      prevband := HiBand;
   end
   else begin
      Dec(prevband);
   end;

   // 前のバンドに対応したリグはあるか
   rig := RigControl.GetRig(FCurrentRigSet, prevband);
   if rig = nil then begin // ない
      rig := RigControl.GetRig(FCurrentRigSet, B0);
      if rig = nil then begin
         B0 := prevband;
         minband := b19;
         maxband := HiBand;
      end
      else begin
         minband := rig.MinBand;
         maxband := rig.MaxBand;
      end;
   end
   else begin  // あった
      B0 := prevband;
      minband := rig.MinBand;
      maxband := rig.MaxBand;
   end;

   // minband～maxband内をスキャン
   for B := B0 downto minband do begin
      if IsAvailableBand(B) = True then begin
         Result := B;
         Exit;
      end;
   end;

   for B := maxband downto B0 do begin
      if IsAvailableBand(B) = True then begin
         Result := B;
         Exit;
      end;
   end;

   Result := original;
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
   rig: TRig;
begin
   BandEdit.Text := MHzString[B];

   // Serial Numberをバンドに合わせて表示
   CurrentQSO.Band := B;
   DispSerialNumber(CurrentQSO);

   if MyContest <> nil then begin
      MyContest.SetPoints(CurrentQSO);
   end;

   PointEdit.Text := CurrentQSO.PointStr; // ver 0.23

   FZLinkForm.SendBand; // ver 0.41

   // シングルＯＰ時は電力符号の設定を行う
   if dmZLogGlobal.ContestCategory = ccSingleOp then begin
      CurrentQSO.Power := dmZlogGlobal.PowerOfBand[B];
   end
   else begin
      // マルチＯＰ時はバンド変更時のOP別電力符号のセットはオプション設定に従う
      if dmZLogGlobal.Settings._applypoweronbandchg = True then begin
         dmZLogGlobal.SetOpPower(CurrentQSO);
      end;
   end;

   if Assigned(PowerEdit) and PowerEdit.Visible then begin
      PowerEdit.Text := CurrentQSO.NewPowerStr;
   end;
   if Assigned(OpEdit) and OpEdit.Visible then begin
      OpEdit.Text := CurrentQSO.Operator;
   end;

   if MyContest <> nil then begin
      if MyContest.MultiForm.Visible then begin
         MyContest.MultiForm.UpdateData;
      end;
   end;

   if FPartialCheck.Visible then begin
      FPartialCheck.UpdateData(CurrentQSO);
   end;

   if menuShowCurrentBandOnly.Checked then begin
      GridRefreshScreen();
   end;

   if dmZlogGlobal.Settings._countdown and (CountDownStartTime > 0) then begin
      WriteStatusLineRed(TMainForm_Less_Than_10min, False);
   end;

   if dmZlogGlobal.Settings._qsycount and (QSYCount > dmZLogGlobal.Settings._countperhour) then begin
      WriteStatusLineRed(TMainForm_QSY_Count_Exceeded, False);
   end;

   rig := RigControl.GetRig(FCurrentRigSet, B);
   if rig = nil then begin
      if B <= HiBand then begin
         FZLinkForm.SendFreqInfo(RigControl.TempFreq[B] * 1000);
      end;
   end
   else begin
      dmZLogKeyer.SetRxRigFlag(FCurrentRigSet, rig.RigNumber);
   end;

   if B <= HiBand then begin
      for bb := Low(FBandScopeEx) to High(FBandScopeEx) do begin
         FBandScopeEx[bb].Select := False;
      end;
      FBandScopeEx[B].Select := True;

      if FBandScope.CurrentBand <> B then begin
         FBandScope.CurrentBand := B;
      end;
      FBandScope.Select := True;
   end;

   FRateDialogEx.Band := CurrentQSO.Band;

   ShowSentNumber();

   SetEnableF2A();
end;

procedure TMainForm.UpdateMode(M: TMode);
begin
   ModeEdit.Text := ModeString[M];
   CurrentQSO.Mode := M;
   If M in [mSSB, mFM, mAM] then begin
      CurrentQSO.RSTRcvd := 59;
      CurrentQSO.RSTsent := 59;
      RcvdRSTEdit.Text := '59';

      // USBIF4CW gen3で音声使う際は、PHでPTT制御あり
      if dmZLogGlobal.Settings._usbif4cw_gen3_micsel = True then begin
         dmZLogGlobal.Settings._pttenabled_ph := True;
      end;
   end
   else begin
      CurrentQSO.RSTRcvd := 599;
      CurrentQSO.RSTsent := 599;
      RcvdRSTEdit.Text := '599';

      // USBIF4CW gen3で音声使う際は、CWでPTT制御なし
      if dmZLogGlobal.Settings._usbif4cw_gen3_micsel = True then begin
         dmZLogGlobal.Settings._pttenabled_ph := False;
      end;
   end;

   ShowToolBar(M);

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

   ShowSentNumber();

   SetEnableF2A();
end;

procedure TMainForm.SetQSOMode(aQSO: TQSO; fUp: Boolean);
var
   maxmode: TMode;
begin
   if dmZLogGlobal.ContestMode = cmAll then begin
      maxmode := mRTTY;
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

   if fUp = True then begin
      if aQSO.Mode < maxmode then begin
         aQSO.Mode := TMode(Integer(aQSO.Mode) + 1);
      end
      else begin
         aQSO.Mode := mCW;
      end;
   end
   else begin
      if aQSO.Mode > mCW then begin
         aQSO.Mode := TMode(Integer(aQSO.Mode) - 1);
      end
      else begin
         aQSO.Mode := maxmode;
      end;
   end;
end;

procedure TMainForm.GridAdd(aQSO: TQSO);
var
   L: TQSOList;
begin
   if menuShowCurrentBandOnly.Checked and (aQSO.Band <> CurrentQSO.Band) then begin
      Exit;
   end;

   L := GetQsoList();

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

      if editor.colTime >= 0 then begin
         if dmZLogGlobal.Settings._displongdatetime = True then begin
            Cells[editor.colTime, R] := aQSO.DateTimeStr;
         end
         else begin
            Cells[editor.colTime, R] := aQSO.TimeStr;
         end;
      end;

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

      if editor.colPoint >= 0 then begin
         if aQSO.Invalid = True then begin
            Cells[editor.colPoint, R] := '0';
         end
         else begin
            Cells[editor.colPoint, R] := aQSO.PointStr;
         end;
      end;

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

      if editor.colNewMulti2 >= 0 then
         Cells[editor.colNewMulti2, R] := editor.GetNewMulti2(aQSO);

      if editor.colMemo >= 0 then
         Cells[editor.colMemo, R] := aQSO.MemoStr; // + IntToStr(aQSO.Reserve3);

      if aQSO.Reserve = actLock then
         Cells[editor.colMemo, R] := 'locked';

      if aQSO.Invalid = True then
         Cells[editor.colMemo, R] := 'Invalid';
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

procedure TMainForm.GridRefreshScreen(fSelectRow: Boolean; fNewData: Boolean);
var
   i: Integer;
   L: TQSOList;
begin
   if (FPastEditMode = True) and (fNewData = True) and
      ((Log.TotalQSO - Grid.VisibleRowCount) > Grid.TopRow) then begin
      ShowInfoPanel(TMainForm_New_QSO_Arrived, DoNewDataArrived, True);
      Exit;
   end;

   Grid.BeginUpdate();
   try
      L := GetQsoList();
      Grid.Tag := NativeInt(L);

      if Grid.VisibleRowCount > L.Count then begin
         Grid.RowCount := Grid.VisibleRowCount + 1;   // +1はFixedRowの分
      end
      else begin
         Grid.RowCount := L.Count;                    // TQSOListのCountは元々1多い
      end;

      for i := 1 to L.Count - 1 do begin
         GridWriteQSO(i, L.Items[i]);
      end;

      for i := L.Count to Grid.RowCount - 1 do begin
         GridClearQSO(i);
      end;

      if fSelectRow = False then begin
         Grid.ShowLast(L.Count - 1);
      end;
   finally
      Grid.EndUpdate();
   end;
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
         SerialEdit1.Visible := True;
      end
      else begin
         SerialEdit1.Visible := False;
      end;

      // Time
      if editor.colTime >= 0 then begin
         if dmZLogGlobal.Settings._displongdatetime = True then begin
            editor.TimeWid := 16;
         end;

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
         Cells[editor.colNewMulti1, 0] := 'multi';
         ColWidths[editor.colNewMulti1] := editor.NewMulti1Wid * nColWidth;
      end;

      // New Multi2
      if editor.colNewMulti2 >= 0 then begin
         Cells[editor.colNewMulti2, 0] := 'multi2';
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
   InitAtomTable(509);

   // taskbar表示用リスト
   FTaskbarList := CreateComObject(CLSID_TaskbarList) as ITaskBarList;

   F2bsiqStart := False;
   FWaitForQsoFinish[0] := False;
   FWaitForQsoFinish[1] := False;
   FWaitForQsoFinish[2] := False;

   // フォント設定
   Grid.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
   EditPanel1R.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
   EditPanel2R.Font.Name := dmZLogGlobal.Settings.FBaseFontName;

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
   FConsolePad    := TConsolePad.Create(Self);
   FFreqList      := TFreqList.Create(Self);
   FCheckCall2    := TCheckCall2.Create(Self);
   FCheckMulti    := TCheckMulti.Create(Self);
   FCheckCountry  := TCheckCountry.Create(Self);
   FScratchSheet  := TScratchSheet.Create(Self);
   FQuickRef      := TQuickRef.Create(Self);
   FZAnalyze      := TZAnalyze.Create(Self);
   FCWMessagePad  := TCwMessagePad.Create(Self);
   FMessageManager := TformMessageManager.Create(Self);
   FMessageManager.OnNotifyStarted  := OnVoicePlayStarted;
   FMessageManager.OnNotifyFinished := OnPlayMessageFinished;
   FFunctionKeyPanel := TformFunctionKeyPanel.Create(Self);
   FQsyInfoForm   := TformQsyInfo.Create(Self);
   FSo2rNeoCp     := TformSo2rNeoCp.Create(Self);
   FInformation   := TformInformation.Create(Self);
   FTTYConsole    := nil;
   FWinKeyerTester := TformWinKeyerTester.Create(Self);
   FFreqTest      := TformFreqTest.Create(Self);
   FCWMonitor     := TformCWMonitor.Create(Self);
   FProgress      := TformProgress.Create(Self);

   FSuperCheck.OnChangeFontSize := OnChangeFontSize;
   FSuperCheck2.OnChangeFontSize := OnChangeFontSize;
   FPartialCheck.OnChangeFontSize := OnChangeFontSize;
   FCommForm.OnChangeFontSize := OnChangeFontSize;
//   if MyContest <> nil then begin
//      MyContest.ScoreForm.FontSize := font_size;   // TBasicScore
//      MyContest.MultiForm.FontSize := font_size;   // TBasicMulti
//   end;

   FCWKeyboard.OnChangeFontSize := OnChangeFontSize;
   FCWMessagePad.OnChangeFontSize := OnChangeFontSize;

   FFreqList.OnChangeFontSize := OnChangeFontSize;
   FCheckCall2.OnChangeFontSize := OnChangeFontSize;
   FCheckMulti.OnChangeFontSize := OnChangeFontSize;
   FCheckCountry.OnChangeFontSize := OnChangeFontSize;
   FFunctionKeyPanel.OnChangeFontSize := OnChangeFontSize;
   FChatForm.OnChangeFontSize := OnChangeFontSize;

   FCurrentCQMessageNo := 101;
   FCQLoopRunning := False;
   FCQLoopStartRig := 1;
   FCtrlZCQLoop := False;
   FCQRepeatPlaying := False;

   for i := 0 to 4 do begin
      FTabKeyPressed[i] := False;
      FDownKeyPressed[i] := False;
      FOtherKeyPressed[i] := False;
      FKeyPressedRigID[i] := 0;
   end;
   FRigSwitchTime := Now();
   FPastEditMode := False;
   FQsyViolation := False;
   FQsyCountPrevHour := '';
   FPrevTotalQSO := 0;

   // Out of contest period表示
   FFirstOutOfContestPeriod := True;
   FOutOfContestPeriod := False;
   FPrevOutOfContestPeriod := False;
   panelOutOfPeriod.Height := 0;

   FQsyFromBS := False;

   // バンド別用
   for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
      FBandScopeEx[b] := TBandScope2.Create(Self, b);
      FBandScopeEx[b].UseResume := dmZLogGlobal.Settings._bandscope_use_resume;
      FBandScopeEx[b].Resume();
   end;

   // 現在バンド用
   FBandScope := TBandScope2.Create(Self, b19);
   FBandScope.CurrentBandOnly := True;
   FBandScope.UseResume := dmZLogGlobal.Settings._bandscope_use_resume;
   FBandScope.Resume();

   // ニューマルチ用
   FBandScopeNewMulti := TBandScope2.Create(Self, bUnknown);
   FBandScopeNewMulti.NewMultiOnly := True;
   FBandScopeNewMulti.UseResume := dmZLogGlobal.Settings._bandscope_use_resume;
   FBandScopeNewMulti.Resume();

   // 全バンド用
   FBandScopeAllBands := TBandScope2.Create(Self, bUnknown);
   FBandScopeAllBands.AllBands := True;
   FBandScopeAllBands.UseResume := dmZLogGlobal.Settings._bandscope_use_resume;
   FBandScopeAllBands.Resume();

   // Super Check
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

   // BandPlan Selector
   comboBandPlan.Items.CommaText := dmZLogGlobal.Settings.FBandPlanPresetList;
   comboBandPlan.ItemIndex := 0;

   FCurrentRigSet := 1;
   EditScreen := nil;
   clStatusLine := clWindowText;
   mSec := dmZlogGlobal.Settings.CW._interval;
   S := '';

   SaveInBackGround := False;
   FLastTabPress := Now;
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

   // initialize keyer
   dmZLogKeyer.OnCallsignSentProc := CallsignSentProc;
   dmZLogKeyer.OnPaddle := OnPaddle;
   dmZLogKeyer.OnSpeedChanged := DoCwSpeedChange;
   dmZLogKeyer.OnOneCharSentProc := OnOneCharSentProc;
   dmZLogKeyer.OnSendFinishProc := OnPlayMessageFinished;
   dmZLogKeyer.OnWkStatusProc := DoWkStatusProc;
   dmZLogKeyer.OnCommand := DoCwCommandProc;
   dmZLogKeyer.InitializeBGK(mSec);

   RenewCWToolBar;
   LastFocus := CallsignEdit; { the place to set focus when ESC is pressed from Grid }

   CurrentQSO := TQSO.Create;
   CurrentQSO.QslState := dmZLogGlobal.Settings._qsl_default;
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

   if dmZlogGlobal.BackupPath = '' then begin
      Backup1.Enabled := False;
   end;

   BuildOpListMenu2(OpMenu.Items, OpMenuClick);

   FTempQSOList := TQSOList.Create();

   RestoreWindowsPos();

   dmZLogKeyer.ResetPTT();

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
   S: string;
begin
   if Log.Saved = False then begin
      S := Format(TMainForm_Confirm_Save_Changes, [CurrentFileName]);
      R := MessageDlg(S, mtConfirmation, [mbYes, mbNo, mbCancel], 0); { HELP context 0 }
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
   OpenDialog.InitialDir := dmZlogGlobal.LogPath;
   OpenDialog.FileName := '';
   OpenDialog.FilterIndex := dmZLogGlobal.Settings.FLastFileFilterIndex;

   if OpenDialog.Execute then begin
      zyloContestClosed;
      WriteStatusLine(TMainForm_Loading_now, False);
      dmZLogGlobal.SetLogFileName(OpenDialog.filename);
      LoadNewContestFromFile(OpenDialog.filename);
      WriteStatusLine('', False);
      SetWindowCaption();
      RenewScore();
      FRateDialog.UpdateGraph();
      FRateDialogEx.UpdateGraph();
      dmZLogGlobal.Settings.FLastFileFilterIndex := OpenDialog.FilterIndex;
      
      if MyContest.ClassType = TGeneralContest then
        zyloContestOpened(MyContest.Name, TGeneralContest(MyContest).Config.FileName)
      else
        zyloContestOpened(MyContest.Name, '');
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
var
   S: string;
begin
   SaveDialog.InitialDir := dmZlogGlobal.LogPath;
   SaveDialog.FileName := '';
   SaveDialog.FilterIndex := dmZLogGlobal.Settings.FLastFileFilterIndex;

   if SaveDialog.Execute then begin

      // 上書き確認
      if FileExists(SaveDialog.filename) then begin
         S := Format(TMainForm_ConfirmOverwrite, [SaveDialog.filename]);
         if MessageBox(Handle, PChar(S), PChar(Application.Title), MB_YESNO or MB_DEFBUTTON2 or MB_ICONEXCLAMATION) = IDNO then begin
            Exit;
         end;
      end;

      Log.SaveToFile(SaveDialog.filename);
      dmZLogGlobal.SetLogFileName(SaveDialog.filename);
      SetWindowCaption();
      { Add code to save current file under SaveDialog.FileName }
      dmZLogGlobal.Settings.FLastFileFilterIndex := SaveDialog.FilterIndex;
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
      S := Format(TMainForm_Confirm_Save_Changes, [CurrentFileName]);
      R := MessageDlg(TMainForm_Confirm_Save_Changes, mtConfirmation, [mbYes, mbNo, mbCancel], 0); { HELP context 0 }
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
   ini: TMemIniFile;
   b: TBand;
begin
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      dmZlogGlobal.ReadWindowState(ini, FCheckCall2);
      dmZlogGlobal.ReadWindowState(ini, FPartialCheck);
      dmZlogGlobal.ReadWindowState(ini, FSuperCheck);
      dmZlogGlobal.ReadWindowState(ini, FSuperCheck2);
      dmZlogGlobal.ReadWindowState(ini, FCheckMulti);
      dmZlogGlobal.ReadWindowState(ini, FCWKeyBoard);
      dmZlogGlobal.ReadWindowState(ini, FRigControl, '', True);
      dmZlogGlobal.ReadWindowState(ini, FChatForm);
      dmZlogGlobal.ReadWindowState(ini, FConsolePad);
      dmZlogGlobal.ReadWindowState(ini, FFreqList);
      dmZlogGlobal.ReadWindowState(ini, FCommForm);
      dmZlogGlobal.ReadWindowState(ini, FScratchSheet);
      dmZlogGlobal.ReadWindowState(ini, FRateDialog);
      dmZlogGlobal.ReadWindowState(ini, FRateDialogEx);
      dmZlogGlobal.ReadWindowState(ini, FZAnalyze);
      dmZlogGlobal.ReadWindowState(ini, FCwMessagePad);
      dmZlogGlobal.ReadWindowState(ini, FFunctionKeyPanel);
      dmZlogGlobal.ReadWindowState(ini, FQsyInfoForm);
      dmZlogGlobal.ReadWindowState(ini, FSo2rNeoCp, '', True);
      dmZlogGlobal.ReadWindowState(ini, FInformation);
      dmZlogGlobal.ReadWindowState(ini, FZLinkForm);
      dmZlogGlobal.ReadWindowState(ini, FWinKeyerTester);
      dmZlogGlobal.ReadWindowState(ini, FFreqTest);
      dmZlogGlobal.ReadWindowState(ini, FMessageManager);
      dmZlogGlobal.ReadWindowState(ini, FCWMonitor);

      for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
         FBandScopeEx[b].LoadSettings(ini, 'BandScope(' + MHzString[b] + ')');
      end;
      FBandScope.LoadSettings(ini, 'BandScope');
      FBandScopeNewMulti.LoadSettings(ini, 'BandScopeNewMulti');
      FBandScopeAllBands.LoadSettings(ini, 'BandScopeAllBands');

      FSuperCheck.Columns := dmZlogGlobal.SuperCheckColumns;
      FSuperCheck2.Columns := dmZlogGlobal.SuperCheck2Columns;

      FZAnalyze.ExcludeZeroPoints := dmZLogGlobal.Settings.FAnalyzeExcludeZeroPoints;
      FZAnalyze.ExcludeZeroHour := dmZLogGlobal.Settings.FAnalyzeExcludeZeroHour;
      FZAnalyze.ShowCW := dmZLogGlobal.Settings.FAnalyzeShowCW;

      dmZlogGlobal.ReadWindowState(ini, MyContest.MultiForm, 'MultiForm', False);
      dmZlogGlobal.ReadWindowState(ini, MyContest.ScoreForm, 'ScoreForm', True);
   finally
      ini.Free();
   end;
end;

procedure TMainForm.RecordWindowStates;
var
   ini: TMemIniFile;
   b: TBand;
begin
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      dmZlogGlobal.WriteWindowState(ini, FCheckCall2);
      dmZlogGlobal.WriteWindowState(ini, FPartialCheck);
      dmZlogGlobal.WriteWindowState(ini, FSuperCheck);
      dmZlogGlobal.WriteWindowState(ini, FSuperCheck2);
      dmZlogGlobal.WriteWindowState(ini, FCheckMulti);
      dmZlogGlobal.WriteWindowState(ini, FCWKeyBoard);
      dmZlogGlobal.WriteWindowState(ini, FRigControl);
      dmZlogGlobal.WriteWindowState(ini, FChatForm);
      dmZlogGlobal.WriteWindowState(ini, FConsolePad);
      dmZlogGlobal.WriteWindowState(ini, FFreqList);
      dmZlogGlobal.WriteWindowState(ini, FCommForm);
      dmZlogGlobal.WriteWindowState(ini, FScratchSheet);
      dmZlogGlobal.WriteWindowState(ini, FRateDialog);
      dmZlogGlobal.WriteWindowState(ini, FRateDialogEx);
      dmZlogGlobal.WriteWindowState(ini, FZAnalyze);
      dmZlogGlobal.WriteWindowState(ini, FCwMessagePad);
      dmZlogGlobal.WriteWindowState(ini, FFunctionKeyPanel);
      dmZlogGlobal.WriteWindowState(ini, FQsyInfoForm);
      dmZlogGlobal.WriteWindowState(ini, FSo2rNeoCp);
      dmZlogGlobal.WriteWindowState(ini, FInformation);
      dmZlogGlobal.WriteWindowState(ini, FZLinkForm);
      dmZlogGlobal.WriteWindowState(ini, FWinKeyerTester);
      dmZlogGlobal.WriteWindowState(ini, FFreqTest);
      dmZlogGlobal.WriteWindowState(ini, FMessageManager);
      dmZlogGlobal.WriteWindowState(ini, FCWMonitor);

      for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
         FBandScopeEx[b].SaveSettings(ini, 'BandScope(' + MHzString[b] + ')');
      end;
      FBandScope.SaveSettings(ini, 'BandScope');
      FBandScopeNewMulti.SaveSettings(ini, 'BandScopeNewMulti');
      FBandScopeAllBands.SaveSettings(ini, 'BandScopeAllBands');

      dmZLogGlobal.WriteMainFormState(ini, Left, top, Width, Height, mnHideCWPhToolBar.Checked, mnHideMenuToolbar.Checked);
      dmZLogGlobal.SuperCheckColumns := FSuperCheck.Columns;
      dmZLogGlobal.SuperCheck2Columns := FSuperCheck2.Columns;

      dmZLogGlobal.Settings.FAnalyzeExcludeZeroPoints := FZAnalyze.ExcludeZeroPoints;
      dmZLogGlobal.Settings.FAnalyzeExcludeZeroHour := FZAnalyze.ExcludeZeroHour;
      dmZLogGlobal.Settings.FAnalyzeShowCW := FZAnalyze.ShowCW;

      if MyContest <> nil then begin
         dmZlogGlobal.WriteWindowState(ini, MyContest.MultiForm, 'MultiForm');
         dmZlogGlobal.WriteWindowState(ini, MyContest.ScoreForm, 'ScoreForm');
      end;

      ini.UpdateFile();
   finally
      ini.Free();
   end;
end;

procedure TMainForm.FileMenuClick(Sender: TObject);
begin
   menuCorrectStartTime.Enabled := MyContest.UseContestPeriod;
end;

procedure TMainForm.FileExit(Sender: TObject);
begin
   Close();
end;

procedure TMainForm.FileExportDialogTypeChange(Sender: TObject);
var
   L: TStringList;
   E: TStringList;
   Index: Integer;
begin
   L := TStringList.Create();
   L.StrictDelimiter := True;
   L.Delimiter := '|';
   L.DelimitedText := FileExportDialog.Filter;

   Index := FileExportDialog.FilterIndex - 1;
   Index := Index * 2 + 1;

   E := TStringList.Create();
   E.StrictDelimiter := True;
   E.Delimiter := ';';
   E.DelimitedText := L.Strings[Index];

   FileExportDialog.DefaultExt := Copy(E.Strings[0], 3);

   L.Free();
   E.Free();
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
   rig: TRig;
begin
   Q := TQSO.Create;
   Q.Band := B;

   UpdateBand(Q.Band);

   rig := RigControl.GetRig(FCurrentRigSet, B);
   if rig <> nil then begin
      rig.SetBand(FCurrentRigSet, Q);

      if CurrentQSO.Mode = mSSB then begin
         Rig.SetMode(CurrentQSO);
      end;

      // Antenna Select
      if (FCurrentRigSet = 1) or (FCurrentRigSet = 2) then begin
         rig.AntSelect(dmZLogGlobal.Settings.FRigSet[FCurrentRigSet].FAnt[Q.Band]);
      end;

      RigControl.SetCurrentRig(rig.RigNumber);
      dmZLogKeyer.SetRxRigFlag(FCurrentRigSet, rig.RigNumber);
   end;

   Q.Free;
end;

procedure TMainForm.ProcessConsoleCommand(S: string);
var
   j: Integer;
   temp, temp2: string;
   rig: TRig;
   khz: TFrequency;
begin
   Delete(S, 1, 1);
   temp := S;

   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));

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
      RenewScore();
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
   end;

   if (S = 'RUN') and (dmZLogGlobal.ContestCategory = ccMultiOpSingleTx) then begin
      ChangeTxNr(0);
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

   if S = 'TV' then begin
      if rig <> nil then
         rig.ToggleVFO;
   end;

   if S = 'VA' then begin
      if rig <> nil then
         rig.SetVFO(0);
   end;

   if S = 'VB' then begin
      if rig <> nil then
         rig.SetVFO(1);
   end;

   if S = 'YAESUTEST' then begin
      if rig <> nil then
         rig.FILO := not(rig.FILO);
   end;

   if S = 'SC' then begin
      actionShowSuperCheck.Execute();
   end;

   if S = 'RESET' then begin
      if rig <> nil then
         rig.Reset;
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

   if S = 'TRX' then begin
      actionToggleRx.Execute();
   end;

   if S = 'TTX' then begin
      actionToggleTx.Execute();
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

   khz := StrToIntDef(S, 0);

   if (khz > 1799) and (khz < 1000000) then begin
      if rig <> nil then begin
         rig.SetFreq(khz * 1000, IsCQ());
         if CurrentQSO.Mode = mSSB then begin
            rig.SetMode(CurrentQSO);
         end;
         FZLinkForm.SendFreqInfo(khz * 1000);
      end
      else begin
         RigControl.TempFreq[CurrentQSO.Band] := khz;
         FZLinkForm.SendFreqInfo(khz * 1000);
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

   if S = 'WKTEST' then begin
      FWinKeyerTester.Show();
   end;

   if S = 'FREQTEST' then begin
      FFreqTest.Show();
   end;

   if S = 'MSGMGR' then begin
      FMessageManager.Show();
   end;

   if S = 'WAIT' then begin
      actionToggleSo2rWait.Execute();
   end;

   if S = '2BSIQ' then begin
      actionToggleSo2r2bsiq.Execute();
   end;

   if S = 'RX2TX' then begin
      actionMatchRxToTx.Execute();
   end;

   if S = 'TX2RX' then begin
      actionMatchTxToRx.Execute();
   end;

   if S = 'RENEW' then begin
      RenewScore();
   end;

   if S = 'SHOWINFO' then begin
      ShowInfoPanel(TMainForm_New_QSO_Arrived, DoNewDataArrived, True);
   end;
   if S = 'HIDEINFO' then begin
      ShowInfoPanel('', nil, False);
   end;

   if S = 'CTYCHK' then begin
      ShowCtyChk();
   end;
end;

procedure TMainForm.ChangeTxNr(txnr: Integer);
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

   SetNextSerialNumber3(CurrentQSO);
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

   OnChangeFontSize(Self, j);
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

   OnChangeFontSize(Self, j);
end;

procedure TMainForm.SetFontSize(font_size: Integer);
var
   h: Integer;
begin
   Grid.Font.Size := font_size;
   h := Grid.Canvas.TextHeight('A');
   Grid.DefaultRowHeight := h + 4;
   Grid.Refresh();

   EditPanel1R.Font.Size := font_size;
   CallsignEdit1.Font.Size := font_size;
   NumberEdit1.Font.Size := font_size;
   DateEdit1.Height := h + 6;
   TimeEdit1.Height := h + 6;
   CallsignEdit1.Height := h + 6;
   RcvdRSTEdit1.Height := h + 6;
   NumberEdit1.Height := h + 6;
   ModeEdit1.Height := h + 6;
   BandEdit1.Height := h + 6;
   PointEdit1.Height := h + 6;
   PowerEdit1.Height := h + 6;
   OpEdit1.Height := h + 6;
   MemoEdit1.Height := h + 6;
   SerialEdit1.Height := h + 6;
   EditPanel1R.Height := h + 6 + 8;

   dmZlogGlobal.Settings._mainfontsize := font_size;

   PostMessage(Handle, WM_ZLOG_SETGRIDCOL, 0, 0);
end;

procedure TMainForm.OnChangeFontSize(Sender: TObject; font_size: Integer);
var
   i: Integer;
   f: TForm;
begin
   SetFontSize(font_size);
   for i := 0 to Screen.FormCount - 1 do begin
      f := Screen.Forms[i];
      if (f <> Sender) and (f is TZLogForm) then begin
         TZLogForm(f).FontSize := font_size;
      end;
   end;
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
      WriteStatusLine(TMainForm_Switch_CW_Bank_A, False)
   end
   else begin
      back_color := clMaroon;
      WriteStatusLine(TMainForm_Switch_CW_Bank_B, False);
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
   S: string;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('BEGIN - TMainForm.EditKeyPress() Key = [' + Key + ']'));
   {$ENDIF}

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
         // memo欄は入力可
         if TEdit(Sender).Tag = 1000 then begin
            if dmZlogGlobal.Settings._movetomemo then begin
               Key := #0;
               CallsignEdit.SetFocus;
            end;
            Exit;
         end;

         if Sender = CallsignEdit then begin { if space is pressed when Callsign edit is in focus }
            Key := #0;

            if CallsignEdit.Text = '' then begin
               NumberEdit.SetFocus;
               Exit;
            end;

            FKeyPressedRigID[FCurrentRigSet - 1] := CurrentRigID;
            SpaceBarProc(FKeyPressedRigID[FCurrentRigSet - 1]);
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

   {$IFDEF DEBUG}
   OutputDebugString(PChar('END - TMainForm.EditKeyPress() - '));
   {$ENDIF}
end;

procedure TMainForm.SpaceBarProc(nID: Integer);
var
   Q: TQSO;
   S: string;
   C, N, B, M, SE, OP: TEdit;
begin
   AssignControls(nID, C, N, B, M, SE, OP);

   Q := Log.QuickDupe(CurrentQSO);
   if Q <> nil then begin
      MessageBeep(0);

      if dmZLogGlobal.Settings._allowdupe = True then begin
         CallSpacebarProc(C, N, B);
         N.SetFocus();
      end
      else begin
         C.SelectAll;
      end;

      S := Q.PartialSummary(dmZlogGlobal.Settings._displaydatepartialcheck);
      WriteStatusLineRed(S, True);
   end
   else begin { if not dupe }
      CallSpacebarProc(C, N, B);
      N.SetFocus();
      WriteStatusLine('', False);
   end;
end;

procedure TMainForm.CallsignEdit1Change(Sender: TObject);
var
   C, N, B, M, SE, OP: TEdit;
begin
   AssignControls(FCurrentRigSet - 1, C, N, B, M, SE, OP);

   CurrentQSO.Callsign := C.Text;

   // SO2Rなので送受が同じ場合のみコールセットする
   if (FCurrentRigSet - 1) = FCurrentTx then begin
      dmZLogKeyer.SetCallSign(C.Text);
   end;

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
   aQSO: TQSO;
   C: Integer;
begin
   SendSpot1.Enabled := FCommForm.MaybeConnected;

   menuChangePower.Visible := PowerEdit1.Visible;

   for i := 0 to Ord(HiBand) do begin
      menuChangeBand.Items[i].Visible := BandMenu.Items[i].Visible;
      menuChangeBand.Items[i].Enabled := BandMenu.Items[i].Enabled;
   end;

   BuildOpListMenu2(menuChangeOperator, GridOperatorClick);
   BuildTxNrMenu2(menuChangeTXNr, mnChangeTXNrClick);

   if Grid.Row > Log.TotalQSO then begin
      for i := 0 to GridMenu.Items.Count - 1 do
         GridMenu.Items[i].Enabled := False;
   end
   else begin
      for i := 0 to GridMenu.Items.Count - 1 do
         GridMenu.Items[i].Enabled := True;
   end;

   // 選択範囲が全て同じ日付かチェックする
   C := 0;
   menuChangeDate.Enabled := True;
   aQSO := TQSO(Grid.Objects[0, Grid.Selection.Top]);
   for i := Grid.Selection.Top + 1 to Grid.Selection.Bottom do begin
      if (Grid.Objects[0, i] = nil) or (aQSO.DateStr <> TQSO(Grid.Objects[0, i]).DateStr) then begin
         menuChangeDate.Enabled := False;
         Break;
      end
      else begin
         Inc(C);
      end;
   end;

   if C = 0 then begin
      menuChangeDate.Enabled := False;
   end;
end;

procedure TMainForm.LoadNewContestFromFile(filename: string);
var
   Q: TQSO;
   bak_acceptdiff: Boolean;
   bak_counthigher: Boolean;
   bak_coeff: Extended;
   S: string;

   function IsOldOtherExist(): Boolean;
   var
      i: Integer;
      Q: TQSO;
   begin
      for i := 1 to Log.TotalQSO do begin
         Q := Log.QsoList[i];
         if Q.Mode = TMode(5) then begin
            Result := True;
            Exit;
         end;
      end;

      Result := False;
      Exit;
   end;

   procedure ConvertModeOther();
   var
      i: Integer;
      Q: TQSO;
   begin
      for i := 1 to Log.TotalQSO do begin
         Q := Log.QsoList[i];
         if Q.Mode = TMode(5) then begin
            Q.Mode := mOther;
         end;
      end;
   end;
begin
   // 一度はCreateLogされてる前提
   Q := TQSO.Create();
   Q.Assign(Log.QsoList[0]);
   bak_acceptdiff := Log.AcceptDifferentMode;
   bak_counthigher := Log.CountHigherPoints;
   bak_coeff := Log.ScoreCoeff;

   dmZLogGlobal.CreateLog();

   Log.ScoreCoeff := bak_coeff;
   Log.AcceptDifferentMode := bak_acceptdiff;
   Log.CountHigherPoints := bak_counthigher;
   Log.QsoList[0].Assign(Q); // contest info is set to current contest.
   Q.Free();

   Log.LoadFromFile(filename);

   // ZLOで旧Otherがある場合
   S := UpperCase(ExtractFileExt(filename));
   if (S = '.ZLO') and (IsOldOtherExist() = True) then begin
      if MessageBox(Handle, PChar(TMainForm_ConfirmModeConvert), PChar(Application.Title), MB_YESNO or MB_DEFBUTTON2 or MB_ICONEXCLAMATION) = IDYES then begin
         ConvertModeOther();
         dmZLogGlobal.SetLogFileName(ChangeFileExt(CurrentFileName, '.ZLOX'));
      end;
   end;

   // 最後のレコード取りだし
   if Log.TotalQSO > 0 then begin
      // 各バンドのSerialを復帰
      RestoreSerialNumber();

      Q := Log.QsoList[Log.TotalQSO];

      // 現在QSOへセット
      CurrentQSO.Assign(Q);
      CurrentQSO.Band := Q.Band;
      CurrentQSO.Mode := Q.Mode;
      CurrentQSO.Callsign := '';
      CurrentQSO.NrRcvd := '';
      CurrentQSO.Time := Date + Time;
      CurrentQSO.TX := dmZlogGlobal.TXNr;
      CurrentQSO.Memo := '';
   end;

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
   RenewScore();
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
         FZLinkForm.DeleteQsoEx(aQSO);
         Log.DeleteQSO(aQSO);
      end;
   end;

   FZLinkForm.Renew();

   RenewScore();
end;

procedure TMainForm.DeleteQSO1Click(Sender: TObject);
var
   _top, _bottom: LongInt;
   aQSO: TQSO;
   L: TQSOList;
   fLastQso: Boolean;
begin
   with Grid do begin
      _top := Selection.top;
      _bottom := Selection.Bottom;
   end;

   if _top = _bottom then begin
      aQSO := TQSO(Grid.Objects[0, _top]);
      if aQSO.Reserve = actLock then begin
         WriteStatusLine(TMainForm_This_QSO_is_locked, True);
         exit;
      end;

      // 最終QSO判定
      fLastQso := Log.QSOList.Last.SameQSOID(aQSO);

      // 削除確認
      if MessageBox(Handle, PChar(TMainForm_Comfirm_Delete_Qso), PChar(Application.Title), MB_YESNO or MB_DEFBUTTON2 or MB_ICONEXCLAMATION) = IDNO then begin
         Exit;
      end;

      // 選択行を削除
      DeleteCurrentRow;

      // シリアルナンバーで最後のQSOの場合は、番号を巻き戻すか確認する
      if (SerialContestType <> 0) and (fLastQso) then begin
         if MessageBox(Handle, PChar(TMainForm_ConfirmRewindSerialNumber), PChar(Application.Title), MB_YESNO or MB_DEFBUTTON2 or MB_ICONEXCLAMATION) = IDYES then begin
            if Log.TotalQSO = 0 then begin
               InitSerialNumber();
            end
            else begin
               RestoreSerialNumber();
            end;
            SetInitSerialNumber(CurrentQSO);
            DispSerialNumber(CurrentQSO);
         end;
      end;
   end
   else begin
      L := GetQsoList();

      if (_top < L.Count - 1) and (_bottom <= L.Count - 1) then begin
         // 削除確認
         if MessageBox(Handle, PChar(TMainForm_Comfirm_Delete_Qsos), PChar(Application.Title), MB_YESNO or MB_DEFBUTTON2 or MB_ICONEXCLAMATION) = IDNO then begin
            Exit;
         end;

         MultipleDelete(_top, _bottom);
      end;
   end;

   Log.SetDupeFlags;

   GridRefreshScreen();

   // BandScopeの更新
   BandScopeNotifyWorked(nil);
end;

procedure TMainForm.GridKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
   L: TQSOList;
begin
   L := GetQsoList();

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
         EditCurrentRow;
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
   EditCurrentRow;
end;

procedure TMainForm.OnTabPress();
begin
   // TABキー連打対策か？ 100ミリ秒ではあまり対策になっていない
   if MilliSecondsBetween(Now(), FLastTabPress) <= 100 then begin
      {$IFDEF DEBUG}
      OutputDebugString(PChar('*** OnTabPress - last tab press ***'));
      {$ENDIF}
      Exit;
   end;
   FLastTabPress := Now;

   // RIG Switch後のガードタイム
   if MilliSecondsBetween(Now(), FRigSwitchTime) <= dmZLogGlobal.Settings.FRigSwitchGuardTime then begin
      {$IFDEF DEBUG}
      OutputDebugString(PChar('*** OnTabPress - guard time ***'));
      {$ENDIF}
      Exit;
   end;

   if CallsignEdit.Text = '' then begin
      {$IFDEF DEBUG}
      OutputDebugString(PChar('*** OnTabPress - empty callsign ***'));
      {$ENDIF}
      Exit;
   end;

   // CQリピート停止
   timerCqRepeat.Enabled := False;
   FMessageManager.ClearQue2();
   FCQRepeatPlaying := True;

   // WAIT=OFFの場合はキューをクリア
   if FInformation.IsWait = False then begin
      FMessageManager.ClearQue();
   end;

   FMessageManager.AddQue(WM_ZLOG_TABKEYPRESS, FCurrentRx, FCurrentTx);
   FMessageManager.ContinueQue();
end;

procedure TMainForm.OnZLogTabKeyPress( var Message: TMessage );
var
   S: String;
   Q: TQSO;
   nRxID: Integer;
   nTxID: Integer;
   nTxRigID: Integer;
   curQSO: TQSO;
   C, N, B, M, SE, OP: TEdit;
   mode: TMode;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('------ >>> Enter OnTabPress ------'));
   {$ENDIF}
   curQSO := TQSO.Create();
   try
      nRxID := Message.WParam;
      nTxID := Message.LParam;

      FTabKeyPressed[nRxID] := True;
      FOtherKeyPressed[nRxID] := False;
      FKeyPressedRigID[nRxID] := nRxID;

      // 確定待ち
      FWaitForQsoFinish[nRxID] := True;

      AssignControls(FKeyPressedRigID[nRxID], C, N, B, M, SE, OP);

      curQSO.Callsign := C.Text;
      curQSO.NrRcvd   := N.Text;
      curQSO.Band     := TextToBand(B.Text);
      curQSO.Mode     := TextToMode(M.Text);
      curQSO.Operator := OP.Text;
      dmZlogGlobal.SetOpPower(curQSO);
      curQSO.Serial   := StrToIntDef(SE.Text, 1);

      // SO2Rモード
      if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
         // 2BSIQ OFFの場合はTXをRXにあわせる
         // CQ+S&P
         // 現在RIGがRIG2(SP)ならRIG1(CQ)へ戻る
         if Is2bsiq() = False then begin
            if nTxID <> nRxID then begin
               nTxID := nRxID;
               ResetTx(nTxID + 1);
               SetCQ(False);
            end;
         end;

         // 2BSIQ ON
         if Is2bsiq() = True then begin
            // TABキーを押した方にTXを合わせる
            nTxID := nRxID;
            ResetTx(nTxID + 1);

            // RXはTXの反対側へ
            nRxID := GetNextRigID(nTxID);
            SwitchRx(nRxID + 1);
         end;
      end;

      // ↓はTX側のモードを取得する
      mode := TextToMode(FEditPanel[nTxID].ModeEdit.Text);
      if mode = mOther then begin
         mode := curQSO.Mode;
      end;

      // PHONE
      if mode in [mSSB, mFM, mAM] then begin
         Q := Log.QuickDupe(curQSO);
         if Q <> nil then begin  // dupe
            // ALLOW DUPEしない場合は4番を送出
            if dmZLogGlobal.Settings._allowdupe = False then begin
               C.SelectAll;
               C.SetFocus;
               PlayMessage(mode, 1, 4, False);
            end
            else begin
               CallSpaceBarProc(C, N, B);
               PlayMessage(mode, 1, 2, False);
            end;

            S := Q.PartialSummary(dmZlogGlobal.Settings._displaydatepartialcheck);
            WriteStatusLineRed(S, True);
         end
         else begin  // not dupe
            CallSpaceBarProc(C, N, B);
            PlayMessage(mode, 1, 2, False);
         end;

         Exit;
      end;

      // RTTY
      if mode = mRTTY then begin
         if FTTYConsole <> nil then
            FTTYConsole.SendStrNow(SetStrNoAbbrev(dmZlogGlobal.CWMessage(3, 2), curQSO));

         CallSpaceBarProc(C, N, B);

         FCQRepeatPlaying := False;

         Exit;
      end;

      // CW

      // CWポート設定チェック
      nTxRigID := GetTxRigID(nTxID + 1);
      if dmZLogKeyer.KeyingPort[nTxRigID] = tkpNone then begin
         WriteStatusLineRed(TMainForm_CW_port_is_no_set, False);
         Exit;
      end;

      if N.Text = '' then begin
         curQSO.UpdateTime;
         TimeEdit.Text := curQSO.TimeStr;
         DateEdit.Text := curQSO.DateStr;
      end;

      S := dmZlogGlobal.CWMessage(0, 2);
      S := SetStr(S, curQSO);

      if dmZLogKeyer.UseWinKeyer = True then begin

         if dmZLogGlobal.Settings._so2r_type = so2rNeo then begin
            dmZLogKeyer.So2rNeoReverseRx(nRxID)
         end;

         zLogSendStr2(nTxRigID, S, curQSO);
      end
      else begin
         {$IFDEF DEBUG}
         OutputDebugString(PChar(S));
         {$ENDIF}
         zLogSendStr2(nTxRigID, S, curQSO);
      end;

      // SO2Rモードの場合
      if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
         // 2BSIQ=OFF
         if (Is2bsiq() = False) then begin
            // 送受が異なる場合はpickupなので、TXを戻す
            if nTxID <> nRxID then begin
               nTxID := nRxID;
               ResetTx(nTxID + 1);
               //SetCQ(True);
            end;
         end;
      end;

      // キーイングがRIGの場合、送信完了を待たない
      if dmZLogKeyer.KeyingPort[nTxRigID] = tkpRig then begin
         CallsignSentProc(nil);
      end;
   finally
      curQSO.Free();
      {$IFDEF DEBUG}
      OutputDebugString(PChar('------ <<< Leave OnTabPress ------'));
      {$ENDIF}
   end;
end;

procedure TMainForm.OnDownKeyPress();
begin
   // RIG Switch後のガードタイム
   if MilliSecondsBetween(Now(), FRigSwitchTime) <= dmZLogGlobal.Settings.FRigSwitchGuardTime then begin
      Exit;
   end;

   if CallsignEdit.Text = '' then begin
      {$IFDEF DEBUG}
      OutputDebugString(PChar('*** OnDownKeyPress - empty callsign ***'));
      {$ENDIF}
      Exit;
   end;

   // CQリピート停止
   timerCqRepeat.Enabled := False;
   FMessageManager.ClearQue2();
   FCQRepeatPlaying := True;

   // WAIT=OFFの場合はキューをクリア
   if FInformation.IsWait = False then begin
      FMessageManager.ClearQue();
   end;

   FMessageManager.AddQue(WM_ZLOG_DOWNKEYPRESS, FCurrentRx, FCurrentTx);
   FMessageManager.ContinueQue();
end;

procedure TMainForm.OnZLogDownKeyPress( var Message: TMessage );
var
   S: String;
   nRxID: Integer;
   nTxID: Integer;
   nTxRigID: Integer;
   curQSO: TQSO;
   mode: TMode;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('------ >>> Enter OnDownkeyPress ------'));
   {$ENDIF}

   curQSO := TQSO.Create();
   try
      nRxID := Message.WParam;
      nTxID := Message.LParam;

      FDownKeyPressed[nRxID] := True;
      FKeyPressedRigID[nRxID] := nRxID;

      FOtherKeyPressed[0] := False;
      FOtherKeyPressed[1] := False;
      FOtherKeyPressed[2] := False;

      // 確定待ちクリア
      FWaitForQsoFinish[nRxID] := False;

      SetCurrentQso(nRxID);
      curQSO.Assign(CurrentQSO);

      // SO2Rモードの場合
      if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
         // 2BSIQ=OFF
         if (Is2bsiq() = False) then begin
            // ↓キーを押した方にTXを合わせる
            if nTxID <> nRxID then begin
               nTxID := nRxID;
               ResetTx(nTxID + 1);
               SetCQ(False);
            end;
         end;

         // 2BSIQ=ON
         if (Is2bsiq() = True) then begin
            // ↓キーを押した方にTXを合わせる
            nTxID := nRxID;
            ResetTx(nTxID + 1);

            // RXは反対側へ
            nRxID := GetNextRigID(nTxID);
            SwitchRx(nRxID + 1);
         end;
      end;

      // ↓はTX側のモードを取得する
      mode := TextToMode(FEditPanel[nTxID].ModeEdit.Text);
      if mode = mOther then begin
         mode := curQSO.Mode;
      end;

      case mode of
         mCW: begin
            // CWポート設定チェック
            nTxRigID := GetTxRigID(nTxID + 1);
            if dmZLogKeyer.KeyingPort[nTxRigID] = tkpNone then begin
               WriteStatusLineRed(TMainForm_CW_port_is_no_set, False);
               Exit;
            end;

            if Not(MyContest.MultiForm.ValidMulti(curQSO)) then begin
               // NR?自動送出使う場合
               if dmZlogGlobal.Settings.CW._send_nr_auto = True then begin
                  S := dmZlogGlobal.CWMessage(0, 5);
                  zLogSendStr2(nTxRigID, S, curQSO);
               end;

               WriteStatusLine(TMainForm_Invalid_number, False);
               FEditPanel[nTxID].NumberEdit.SetFocus;
               FEditPanel[nTxID].NumberEdit.SelectAll;

               Exit;
            end;

            // TU $M TEST
            S := dmZlogGlobal.CWMessage(0, 3);

            {$IFDEF DEBUG}
            OutputDebugString(PChar(S));
            {$ENDIF}
            zLogSendStr2(nTxRigID, S, curQSO);

            // ログに記録
            LogButtonProc(nTxID, curQSO);

            // SO2Rモードの場合
            if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
               // 2BSIQ=OFF
               if (Is2bsiq() = False) then begin
                  // 送受が異なる場合はpickupなので、TXを戻す
                  if FCurrentTx <> FCurrentRx then begin
                     nTxID := nRxID;
                     ResetTx(nTxID + 1);
                     SetCQ(True);
                  end;
               end;
            end;
         end;

         mRTTY: begin
            if Not(MyContest.MultiForm.ValidMulti(curQSO)) then begin
               S := dmZlogGlobal.CWMessage(3, 5);
               S := SetStrNoAbbrev(S, curQSO);
               if FTTYConsole <> nil then begin
                  FTTYConsole.SendStrNow(S);
               end;
               WriteStatusLine(TMainForm_Invalid_number, False);
               NumberEdit.SetFocus;
               NumberEdit.SelectAll;
               FCQRepeatPlaying := False;
               exit;
            end;

            S := dmZlogGlobal.CWMessage(3, 3);

            S := SetStrNoAbbrev(S, curQSO);
            if FTTYConsole <> nil then begin
               FTTYConsole.SendStrNow(S);
            end;

            LogButtonProc(nTxID, curQSO);
         end;

         mSSB, mFM, mAM: begin
            if Not(MyContest.MultiForm.ValidMulti(curQSO)) then begin
               PlayMessage(mode, 1, 5, False);
               WriteStatusLine(TMainForm_Invalid_number, False);
               NumberEdit.SetFocus;
               NumberEdit.SelectAll;
               exit;
            end;

            PlayMessage(mode, 1, 3, False);
            LogButtonProc(nTxID, curQSO);
         end;
      end;

      CurrentQSO.Assign(curQSO);
   finally
      curQSO.Free();

      {$IFDEF DEBUG}
      OutputDebugString(PChar('------ <<< Leave OnDownkeyPress ------'));
      {$ENDIF}
   end;
end;

procedure TMainForm.EditKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
   case Key of
      { MUHENKAN KEY }
      VK_NONCONVERT: begin
         OnNonconvertKeyProc();
         Key := 0;
      end;

      VK_UP: begin
         OnUpKeyProc(Sender);
         Key := 0;
      end;

      Ord('A') .. Ord('Z'), Ord('0') .. Ord('9'): begin
         if Shift <> [] then begin
            Exit;
         end;

         OnAlphaNumericKeyProc(Sender, Key);
      end;
   end;
end;

procedure TMainForm.GridDblClick(Sender: TObject);
var
   C: Integer;
begin
   // セル境界でのダブルクリックの場合、列幅を適正化する
   C := Grid.GetColBoundary();
   if C >= 0 then begin
      Grid.AdjustColWidth(C);
      Exit;
   end;

   // 選択行を編集
   EditCurrentRow;
end;

procedure TMainForm.GridEnter(Sender: TObject);
begin
   FPastEditMode := True;
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
begin
   LogButtonProc(FCurrentRx, CurrentQSO);
end;

procedure TMainForm.LogButtonProc(nID: Integer; Q: TQSO);
var
   _dupe, i: Integer;
   Hz: TFrequency;
   workedZLO: Boolean;
   st, st2: string;
   B: TBand;
   band_bakup: TBand;
   rig: TRig;

   function FindPrevQSO(): Integer;
   var
      i: Integer;
   begin
      for i := Log.QsoList.Count - 1 downto 1 do begin
         if Log.QsoList[i].TX = Q.TX then begin
            Result := i;
            Exit;
         end;
      end;
      Result := -1;
   end;

begin
   band_bakup := Q.Band;

   EditedSinceTABPressed := tabstate_normal;

   // Callsign入力チェック
   if Q.Callsign = '' then begin
      WriteStatusLine(TMainForm_Callsign_not_entered, False);
      CallsignEdit.SetFocus;
      Exit;
   end;

   // 初期値セット
   Q.Points := 0;
   Q.NewMulti1 := False;
   Q.NewMulti2 := False;
   Q.Invalid := False;
   Q.TX := dmZlogGlobal.TXNr;
   Q.Forced := False;
   Q.Dupe := False;
   Q.Freq := '';

   // DUPEチェック
   _dupe := Log.IsDupe(Q);

   if Q.Reserve2 = $00 then begin   // 通常入力
      // DUPE
      if _dupe <> 0 then begin
         // DUPEは入力しない
         if dmZLogGlobal.Settings._allowdupe = False then begin
            FEditPanel[nID].CallsignEdit.SetFocus;
            FEditPanel[nID].CallsignEdit.SelectAll;
            WriteStatusLine(TMainForm_Dupe_qso, False);
            Exit;
         end
         else begin // DUPEをallow
            Q.Dupe := True;
            Q.Multi1 := '';
            Q.Multi2 := '';
            Q.Reserve2 := $00;
         end;
      end;

      // 無効マルチは入力できない
      if MyContest.MultiForm.ValidMulti(Q) = False then begin
         WriteStatusLine(TMainForm_Invalid_number, False);
         FEditPanel[nID].NumberEdit.SetFocus;
         FEditPanel[nID].NumberEdit.SelectAll;
         Exit;
      end;

      Q.Forced := False;
   end
   else begin     // 強制入力
      if _dupe <> 0 then begin
         Q.Dupe := True;
      end;
      Q.Forced := True;
      Q.Multi1 := '';
      Q.Multi2 := '';
      Q.Reserve2 := $00;
   end;

   // ここからがLoggingメイン処理
   MyContest.SetNrSent(Q);

   repeat
      i := dmZlogGlobal.NewQSOID();
   until Log.CheckQSOID(i) = False;

   Q.Reserve3 := i;

   rig := RigControl.GetRig(nID + 1, Q.Band);
   if (rig <> nil) and (RigControl.GetCurrentRig() <> 5) then begin
      // RIGの周波数を取得
      Hz := rig.CurrentFreqHz;

      // 周波数が取得できたら(>0)記録する
      if Hz > 0 then begin
         // 周波数を記録
         if dmZlogGlobal.Settings._recrigfreq = True then begin
            Q.Freq := rig.CurrentFreqkHzStr;
         end;

         // 自動bandmap
         if dmZlogGlobal.Settings._autobandmap then begin
            BandScopeAddSelfSpot(Q, Hz);
         end;
      end;
   end;

   // QSY Violation
   i := FindPrevQSO();
   if (i > 0) and (Log.QsoList[i].Band <> band_bakup) then begin
      Q.QsyViolation := FQsyViolation;
      if FQsyViolation = False then begin
         CountDownStartTime := CurrentTime; // Now;
      end;
   end
   else begin
      if i = -1 then begin
         CountDownStartTime := CurrentTime; // Now;
         Q.QsyViolation := False;
      end
      else begin
         if FQsyViolation = True then begin
            Q.QsyViolation := Log.QsoList[i].QsyViolation;
         end
         else begin
            Q.QsyViolation := False;
         end;
      end;
   end;

   // PCName
   Q.PCName := dmZLogGlobal.Settings._pcname;

   // if MyContest.Name = 'Pedition mode' then
   if not FPostContest then begin
      Q.UpdateTime;
   end;

   // コンテスト開始前かチェック
   if MyContest.UseContestPeriod = True then begin
      Q.Invalid := FOutOfContestPeriod;
   end;

   // MOP
   if dmZLogGlobal.ContestCategory in [ccMultiOpMultiTx, ccMultiOpSingleTx, ccMultiOpTwoTx] then begin
      if dmZLogGlobal.CurrentOperator = nil then begin
         // 今のOPがOpListにいない
         if dmZLogGlobal.Settings._pcname <> '' then begin
            Q.Operator := dmZLogGlobal.Settings._pcname;
         end
         else begin
            Q.Operator := '';
         end;
      end;
   end;

   // ログに記録
   Q.Band := band_bakup;
   MyContest.LogQSO(Q, True);

   Q.Reserve2 := $AA; // some multi form and editscreen uses this flag

   GridAdd(Q);

   Q.Reserve2 := $00;

   ReEvaluateQSYCount;

   if FRateDialog.Visible then begin
      FRateDialog.UpdateGraph;
   end;
   if FRateDialogEx.Visible then begin
      FRateDialogEx.UpdateGraph;
   end;

   // M/S時、本来Multi StationはNEW MULTIしか交信できない
   if (dmZLogGlobal.IsMultiStation() = True) then begin
      if (Q.NewMulti1 = False) and (Q.NewMulti2 = False) and (dmZlogGlobal.Settings._multistationwarning)
      then begin
         MessageDlg(TMainForm_New_Multi_Only, mtError, [mbOK], 0); { HELP context 0 }
      end;
   end;

   // シリアルナンバーを更新
   SetNextSerialNumber2(Q, True);

   workedZLO := False;
   if Q.Callsign = 'JA1ZLO' then begin
      if MyContest.Name = 'ALL JA コンテスト' then begin
         if Q.Points > 0 then begin
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
   FZLinkForm.SendQSO(Q); { ZLinkForm checks if Z-Link is ON }

   // WANTEDリスト交信
   st := MyContest.MultiForm.ExtractMulti(Q);
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

   if Q.Mode = mCW then begin
      if (rig <> nil) and (RigControl.GetCurrentRig() <> 5) then begin
         // RITクリア
         if (dmZlogGlobal.Settings._ritclear = True) or
            (dmZlogGlobal.Settings.FAntiZeroinAutoCancel = True) then begin
            rig.RitClear;
         end;

         // Anti Zeroin
         if dmZlogGlobal.Settings.FAntiZeroinAutoCancel = True then begin
            rig.Xit := False;
         end;
      end;
   end;

   // BandScopeの更新
   BandScopeNotifyWorked(Q);

   // 次のＱＳＯの準備

   SetNextSerialNumber(Q);

   if Not(FPostContest) then
      Q.UpdateTime;

   Q.Callsign := '';
   Q.NrRcvd := '';
   Q.Memo := '';
   Q.QslState := dmZLogGlobal.Settings._qsl_default;

   Q.Dupe := False;
   // CurrentQSO.CQ := False;

   Q.Reserve2 := 0;
   Q.Reserve3 := 0;

   if Q.Mode in [mCW, mRTTY] then begin
      Q.RSTRcvd := 599;
   end
   else begin
      Q.RSTRcvd := 59;
   end;

   if dmZLogGlobal.CurrentOperator = nil then begin
      Q.Operator := '';
   end;

   FEditPanel[nID].TimeEdit.Text := Q.TimeStr;
   FEditPanel[nID].DateEdit.Text := Q.DateStr;
   FEditPanel[nID].CallsignEdit.Text := Q.Callsign;
   FEditPanel[nID].RcvdRSTEdit.Text := Q.RSTStr;
   FEditPanel[nID].NumberEdit.Text := Q.NrRcvd;
   FEditPanel[nID].ModeEdit.Text := Q.ModeStr;
   FEditPanel[nID].BandEdit.Text := Q.BandStr;
   FEditPanel[nID].PowerEdit.Text := Q.NewPowerStr;
   FEditPanel[nID].PointEdit.Text := Q.PointStr;
   FEditPanel[nID].OpEdit.Text := Q.Operator;
   FEditPanel[nID].MemoEdit.Text := '';

   if (dmZLogGlobal.Settings._operate_style = os1Radio) or
      ((dmZLogGlobal.Settings._operate_style = os2Radio) and (Is2bsiq() = False)) then begin
      if FPostContest then begin
         TimeEdit.SetFocus;
      end
      else begin
         PostMessage(Handle, WM_ZLOG_SETFOCUS, 0, 0);
      end;
   end;

   WriteStatusLine('', False);

   if workedZLO then begin
      WriteStatusLine(TMainForm_Thankyou_for_your_qso, False);
   end;

   // Analyzeウインドウが表示されている場合は表示更新する
   if FZAnalyze.Visible then begin
      PostMessage(FZAnalyze.Handle, WM_ANALYZE_UPDATE, 0, 0);
   end;
end;

procedure TMainForm.panelCQModeClick(Sender: TObject);
begin
   actionToggleCqSp.Execute();
end;

procedure TMainForm.FormShow(Sender: TObject);
var
   ini: TMemIniFile;
   X, Y, W, H: Integer;
   B, BB: Boolean;
begin
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      dmZlogGlobal.ReadMainFormState(ini, X, Y, W, H, B, BB);
      if (W > 0) and (H > 0) then begin
         if B then begin
            mnHideCWPhToolBar.Checked := True;
         end;
         if BB then begin
            mnHideMenuToolbar.Checked := True;
         end;
         ShowToolBar(mOther);

         Left := X;
         top := Y;
         Width := W;
         Height := H;
      end;

      if FPostContest then begin
         MessageDlg(TMainForm_Change_Date, mtInformation, [mbOK], 0); { HELP context 0 }
      end;

      PostMessage(Handle, WM_ZLOG_INIT, 0, 0);

   //   zyloRuntimeLaunch;
   finally
      ini.Free();
   end;
end;

procedure TMainForm.CWFButtonClick(Sender: TObject);
var
   i: Integer;
begin
   i := THemisphereButton(Sender).Tag;
   PlayMessage(mCW, dmZlogGlobal.Settings.CW.CurrentBank, i, True);
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
   FConsolePad.Release();
   FCheckCountry.Release();

   for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
      FBandScopeEx[b].Suspend();
      FBandScopeEx[b].Close();
      FBandScopeEx[b].Release();
   end;
   FBandScope.Suspend();
   FBandScope.Close();
   FBandScope.Release();

   FBandScopeNewMulti.Suspend();
   FBandScopeNewMulti.Close();
   FBandScopeNewMulti.Release();

   FBandScopeAllBands.Suspend();
   FBandScopeAllBands.Close();
   FBandScopeAllBands.Release();

   if MyContest is TWAEContest then begin
      TWAEContest(MyContest).QTCForm.Release();
   end;

   if MyContest <> nil then begin
      MyContest.Free;
   end;

   EditScreen.Free();
   FTempQSOList.Free();
   FQuickRef.Release();
   FZAnalyze.Release();
   FCWMessagePad.Release();
   FMessageManager.Release();
   FFunctionKeyPanel.Release();
   FQsyInfoForm.Release();
   FSo2rNeoCp.Release();
   FInformation.Release();
   FWinKeyerTester.Release();
   FFreqTest.Release();
   FCWMonitor.Release();
   FProgress.Release();

   if Assigned(FTTYConsole) then begin
      FTTYConsole.Release();
   end;

   CurrentQSO.Free();

   FTaskbarList := nil;

   SuperCheckFreeData();

   zyloContestClosed;
   zyloRuntimeFinish;
end;

procedure TMainForm.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
   font_size: Integer;
begin
   // CTRL+UPでフォントサイズDOWN
   if GetAsyncKeyState(VK_CONTROL) < 0 then begin
      font_size := Grid.Font.Size;
      Dec(font_size);
      if font_size < 6 then begin
         font_size := 6;
      end;

      SetFontSize(font_size);

      // さらにSHIFTキーを押していると他のWindowも変更する
      if GetAsyncKeyState(VK_SHIFT) < 0 then begin
         OnChangeFontSize(Self, font_size);
      end;

      Refresh();

      Handled := True;
   end;
end;

procedure TMainForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
   font_size: Integer;
begin
   // CTRL+UPでフォントサイズUP
   if GetAsyncKeyState(VK_CONTROL) < 0 then begin
      font_size := Grid.Font.Size;
      Inc(font_size);
      if font_size > 28 then begin
         font_size := 28;
      end;

      SetFontSize(font_size);

      // さらにSHIFTキーを押していると他のWindowも変更する
      if GetAsyncKeyState(VK_SHIFT) < 0 then begin
         OnChangeFontSize(Self, font_size);
      end;

      Refresh();

      Handled := True;
   end;
end;

procedure TMainForm.SpeedBarChange(Sender: TObject);
begin
   dmZLogKeyer.WPM := SpeedBar.Position;
   dmZLogKeyer.InitWPM := SpeedBar.Position;
   dmZLogGlobal.Settings.CW._speed := SpeedBar.Position;
   SpeedLabel.Caption := IntToStr(SpeedBar.Position) + ' wpm';

   FInformation.WPM := SpeedBar.Position;

   if Active = True then begin
      if LastFocus <> nil then begin
         LastFocus.SetFocus;
      end;
   end;
end;

procedure TMainForm.CWStopButtonClick(Sender: TObject);
var
   rig: TRig;
   nID: Integer;
begin
   nID := GetTxRigID();
   if dmZLogKeyer.KeyingPort[nID] = tkpRIG then begin
      rig := MainForm.RigControl.Rigs[nID + 1];
      if rig <> nil then begin
         rig.StopMessageCW();
         dmZLogKeyer.OnSendFinishProc(dmZLogKeyer, mCW, True);
      end;
   end
   else begin
      if dmZLogKeyer.IsPlaying = False then begin
         Exit;
      end;

      dmZLogKeyer.ClrBuffer;
   end;

   CWPlayButton.Visible := False;
   CWPauseButton.Visible := True;
   FCQRepeatPlaying := False;
end;

procedure TMainForm.VoiceStopButtonClick(Sender: TObject);
begin
//   CancelCqRepeat();
   FMessageManager.StopVoice;
   FCQRepeatPlaying := False;

   // 元々Finishイベントで行っていたがCQループとの
   // 兼ね合いでFinishイベントをやめたのでこちらに変更
   VoiceStopButton.Enabled := False;
   VoiceControl(False);
end;

procedure TMainForm.SetCQ(CQ: Boolean);
var
   rig: TRig;
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

   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if rig = nil then begin
      FZLinkForm.SendFreqInfo(RigControl.TempFreq[CurrentQSO.Band] * 1000);
   end;

   if dmZlogGlobal.Settings._switchcqsp then begin
      if CQ then
         SwitchCWBank(1)
      else
         SwitchCWBank(2);
   end;

   if (dmZLogGlobal.Settings.FUseAntiZeroin = True) and (CQ = True) and (CurrentQSO.Mode = mCW) then begin
      if rig <> nil then begin
         if dmZLogGlobal.Settings.FAntiZeroinRitOff = True then begin
            rig.Rit := False;
         end;
         if dmZLogGlobal.Settings.FAntiZeroinXitOff = True then begin
            rig.Xit := False;
         end;
         if dmZLogGlobal.Settings.FAntiZeroinRitClear = True then begin
            rig.RitClear();
         end;
      end;
   end;
end;

function TMainForm.IsCQ(): Boolean;
begin
   Result := CurrentQSO.CQ;
end;

procedure TMainForm.labelRig3TitleClick(Sender: TObject);
begin
   checkUseRig3.Checked := not checkUseRig3.Checked;
end;

procedure TMainForm.CQRepeatClick1(Sender: TObject);
begin
   if FCQRepeatPlaying = True then begin
      Exit;
   end;

   FCtrlZCQLoop := False;
   SetCqRepeatMode(True, True);
end;

procedure TMainForm.CQRepeatClick2(Sender: TObject);
begin
   if FCQRepeatPlaying = True then begin
      Exit;
   end;

   FCtrlZCQLoop := True;
   SetCqRepeatMode(True, True);
end;

procedure TMainForm.CQRepeatProc(nSpeedUp: Integer; fFirst: Boolean);
var
   bank: Integer;
   msgno: Integer;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('**** CQRepeatProc() ****'));
   {$ENDIF}

   try
   // 確定待ち中で、現在の受信と次の送信が同じRIGの場合はパス
   if (dmZLogGlobal.Settings._operate_style = os2Radio) and
      (FWaitForQsoFinish[FCurrentRigSet - 1] = True) then begin
      {$IFDEF DEBUG}
      OutputDebugString(PChar('**** QSO確定待ち ****'));
      {$ENDIF}
      Exit;
   end;

   // CQリピート中
   FCQRepeatPlaying := True;

   // Wait=OFFなら全部クリア
   if FInformation.IsWait = False then begin
      FMessageManager.ClearQue();
   end;

   // 1Radioの場合
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin
      // 現在の周波数とモードを記憶
      if (fFirst = True) and (dmZLogGlobal.Settings._bandscope_save_current_freq = False)then begin
         SaveLastFreq();
      end;
   end;

   // 2Radioの場合
   // CQ+S&P
   // 現在RIGがRIG2(SP)ならRIG1(CQ)へ戻る
   if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
      if (Is2bsiq() = False) then begin
         // 開始時RIG(RUN)と現在TXが異なる場合はCQはかけない
         if ((FCQLoopStartRig - 1) <> FCurrentTx) then begin
            {$IFDEF DEBUG}
            OutputDebugString(PChar('**** 開始時RIG(RUN)と現在TXが異なる場合はCQはかけない ****'));
            {$ENDIF}
//            FCQRepeatPlaying := False;
//            Exit;
         end;
      end;

      // 現在の周波数とモードを記憶
      if (fFirst = True) then begin
         SaveLastFreq();
      end;
   end;

   WriteStatusLine('', False);

//   currig := RigControl.GetCurrentRig();

   // SO2Rの場合
   if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
      // 2BSIQの場合
      if Is2bsiq() = True then begin
         // TXとRXが違う場合、RXをTXに合わせてからInvertTxする
         if CurrentTx <> CurrentRx then begin
            FMessageManager.AddQue(WM_ZLOG_SWITCH_RX, 2, 0);
            FMessageManager.AddQue(WM_ZLOG_AFTER_DELAY, 0, 0);
            FMessageManager.AddQue(WM_ZLOG_INVERT_TX, 0, 0);
         end;

         // TXとRXが同じだったらInvertTxする
         if CurrentTx = CurrentRx then begin
            // InvertTx();
            FMessageManager.AddQue(WM_ZLOG_INVERT_TX, 0, 0);
         end;
      end;

      // 何かキーが押された
      if (FOtherKeyPressed[FCurrentRigSet - 1] = True) then begin
         {$IFDEF DEBUG}
         OutputDebugString(PChar('**** Other Key ****'));
         {$ENDIF}
         FCQRepeatPlaying := False;
         Exit;
      end;

      // TABか↓キー押されていたらここまで
//      if (FTabKeyPressed[FCurrentRigSet - 1] = True) or (FDownKeyPressed[FCurrentRigSet - 1] = True) then begin
//         {$IFDEF DEBUG}
//         OutputDebugString(PChar('**** TAB or DOWN ****'));
//         {$ENDIF}
//         Exit;
//      end;
   end;

   // CQモードに変更
   FMessageManager.AddQue(WM_ZLOG_SETCQ, 1, 0);

   // 自動リグ変更の場合Messageを切り替える
   if (dmZLogGlobal.Settings._operate_style = os2Radio) and
      (Is2bsiq() = True) then begin
      bank := dmZLogGlobal.Settings._so2r_cq_msg_bank;
      msgno := dmZLogGlobal.Settings._so2r_cq_msg_number;
   end
   else begin
      bank := 1;
      msgno := FCurrentCQMessageNo;
   end;

   // CQ送信
   FMessageManager.AddQue(WM_ZLOG_PLAYCQ, MAKEWPARAM(bank, msgno), MAKELPARAM(nSpeedUp, 0));

   finally
      FMessageManager.ContinueQue();
   end;
end;

// CQリピートタイマー
procedure TMainForm.timerCqRepeatTimer(Sender: TObject);
begin
   Dec(FCQRepeatCount);
   FInformation.CqRptCountDown := FCQRepeatCount div 10;
   if (FCQRepeatCount <= 0) then begin
      timerCqRepeat.Enabled := False;
      {$IFDEF DEBUG}
      OutputDebugString(PChar('＊＊＊＊＊CQリピートタイマー＊＊＊＊＊'));
      {$ENDIF}
      FMessageManager.AddQue(WM_ZLOG_CQREPEAT_CONTINUE, 0, 0);
      FMessageManager.ContinueQue();
   end;
end;

// Out of contest period表示用
procedure TMainForm.timerOutOfPeriodTimer(Sender: TObject);
begin
   if TTimer(Sender).Tag = 0 then begin   // OFF
      if panelOutOfPeriod.Height <= 0 then begin
         panelOutOfPeriod.Height := 0;
         panelOutOfPeriod.Visible := False;
         TTimer(Sender).Enabled := False;
      end
      else begin
         panelOutOfPeriod.Height := panelOutOfPeriod.Height - 2;
      end;
   end
   else begin     // ON
      if panelOutOfPeriod.Height >= 28 then begin
         panelOutOfPeriod.Height := 28;
         TTimer(Sender).Enabled := False;
      end
      else begin
         panelOutOfPeriod.Visible := True;
         panelOutOfPeriod.Height := panelOutOfPeriod.Height + 2;
      end;
   end;
end;

// 汎用のInfoPanel
procedure TMainForm.timerShowInfoTimer(Sender: TObject);
begin
   if TTimer(Sender).Tag = 0 then begin   // OFF
      if panelShowInfo.Height <= 0 then begin
         panelShowInfo.Height := 0;
         panelShowInfo.Visible := False;
         TTimer(Sender).Enabled := False;
      end
      else begin
         panelShowInfo.Height := panelShowInfo.Height - 2;
      end;
   end
   else begin     // ON
      if panelShowInfo.Height >= 28 then begin
         panelShowInfo.Height := 28;
         TTimer(Sender).Enabled := False;
      end
      else begin
         panelShowInfo.Visible := True;
         panelShowInfo.Height := panelShowInfo.Height + 2;
      end;
   end;
end;

procedure TMainForm.buttonCancelOutOfPeriodClick(Sender: TObject);
begin
   if MessageBox(Handle, PChar(TMainForm_ConfirmContestPeriod), PChar(Application.Title), MB_YESNO or MB_DEFBUTTON2 or MB_ICONEXCLAMATION) = IDNO then begin
      Exit;
   end;
   dmZLogGlobal.Settings._use_contest_period := False;
end;

procedure TMainForm.buttonCwKeyboardClick(Sender: TObject);
begin
   FormShowAndRestore(FCWKeyBoard);
end;

procedure TMainForm.buttonF2AClick(Sender: TObject);
begin
   if dmZLogGlobal.Settings._use_f2a = False then begin
      Exit;
   end;

   if buttonF2A.Down = True then begin
      SetF2AMode();
   end
   else begin
      ResetF2AMode();
   end;
end;

procedure TMainForm.SetEnableF2A();
begin
   if (currentQSO.Band >= b28) then begin
      buttonF2A.Enabled := True;
      actionToggleF2A.Enabled := True;
   end
   else begin
      buttonF2A.Enabled := False;
      actionToggleF2A.Enabled := False;
   end;
end;

procedure TMainForm.SetF2AMode();
var
   rig: TRig;
begin
   // PTT delayをF2A用の値に変更する
   dmZLogKeyer.SetPTTDelay(dmZLogGlobal.Settings._f2a_before, dmZLogGlobal.Settings._f2a_after);
   dmZLogKeyer.SetPTT(dmZLogGlobal.Settings._f2a_ptt);

   // サイドトーン設定をON
   dmZLogKeyer.UseSideTone := True;

   // サイドトーンの出力先を変更
   dmZLogKeyer.SideTone.DeviceID := dmZLogGlobal.Settings._f2a_device;
   dmZLogKeyer.SideTone.Volume := dmZLogGlobal.Settings._f2a_volume;

   // リグをFMにする(要値保存)
   FRigModeBackup := CurrentQSO.Mode;
   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      rig.IgnoreMode := True;
      rig.SetMode(mFM);
      while rig.CurrentMode <> mFM do begin
         Application.ProcessMessages();
      end;
      rig.SetDataMode(True);
      UpdateMode(mCW);
   end;

   // 本来のキーイングを止める
end;

procedure TMainForm.ResetF2AMode();
var
   rig: TRig;
begin
   // リグのモードを戻す
   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      rig.IgnoreMode := dmZLogGlobal.Settings._ignore_rig_mode;
      rig.SetDataMode(False);
      rig.SetMode(FRigModeBackup);
      UpdateMode(FRigModeBackup);
   end;

   // PTT delayを元に戻す
   dmZLogKeyer.SetPTTDelay(dmZLogGlobal.Settings._pttbefore_cw, dmZLogGlobal.Settings._pttafter_cw);
   dmZLogKeyer.SetPTT(dmZLogGlobal.Settings._pttenabled_cw);

   // サイドトーン設定を戻す
   dmZLogKeyer.UseSideTone := dmZLogGlobal.Settings.CW._sidetone;

   // サイドトーンの出力先を戻す
   dmZLogKeyer.SideTone.DeviceID := WAVE_MAPPER;
   dmZLogKeyer.SideTone.Volume := dmZLogGlobal.Settings.CW._sidetone_volume;

   // 本来のキーイングを再開
end;

procedure TMainForm.F2AOff();
begin
   if buttonF2A.Down then begin
      buttonF2A.Down := False;
      ResetF2AMode();
   end;
end;

procedure TMainForm.SideToneButtonClick(Sender: TObject);
begin
   dmZlogGlobal.Settings.CW._sidetone := TSpeedButton(Sender).Down;
   dmZlogKeyer.UseSideTone := dmZlogGlobal.Settings.CW._sidetone;
end;

procedure TMainForm.buttonVoiceOptionClick(Sender: TObject);
begin
   ShowOptionsDialog(2, 1, 1, 0);
   RenewVoiceToolBar;
   LastFocus.SetFocus;
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
   FCommForm.Disconnect();
   FRateDialogEx.SaveSettings();

   // F2Aモード解除
   F2AOff();

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
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin
      dmZLogGlobal.LastBand[0] := CurrentQSO.Band;
      dmZLogGlobal.LastMode[0] := CurrentQSO.Mode;
   end
   else begin
      dmZLogGlobal.LastBand[0] := TextToBand(FEditPanel[0].BandEdit.Text);
      dmZLogGlobal.LastMode[0] := TextToMode(FEditPanel[0].ModeEdit.Text);
      dmZLogGlobal.LastBand[1] := TextToBand(FEditPanel[1].BandEdit.Text);
      dmZLogGlobal.LastMode[1] := TextToMode(FEditPanel[1].ModeEdit.Text);
      dmZLogGlobal.LastBand[2] := TextToBand(FEditPanel[2].BandEdit.Text);
      dmZLogGlobal.LastMode[2] := TextToMode(FEditPanel[2].ModeEdit.Text);
   end;

   // SO2R
   dmZLogGlobal.Settings._so2r_use_rig3 := checkUseRig3.Checked;

   // Last CQ mode
   dmZLogGlobal.Settings.FLastCQMode := IsCQ();
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
   R: Integer;
   S: string;
begin
   if Log = nil then begin
      Exit;
   end;

   if Log.Saved = False then begin
      S := Format(TMainForm_Confirm_Save_Changes, [CurrentFileName]);
      R := MessageDlg(S, mtConfirmation, [mbYes, mbNo, mbCancel], 0); { HELP context 0 }
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
   strTxNo: string;
   strHour: string;
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
         if (Diff / 60) >= nCountDownMinute then begin
            CountDownStartTime := 0;
            S2 := 'QSY OK';
            fQsyOK := True;
            FQsyViolation := False;
         end
         else begin
            FQsyViolation := True;
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

      // "時"が変わったらカウンターリセット
      strHour := Copy(S, 1, 2);
      if FQsyCountPrevHour <> strHour then begin
         QsyCount := 0;
         FQsyCountPrevHour := strHour;
      end;

      // QSY回数を数える
      ReEvaluateQsyCount();

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

   StatusLine.Panels[3].Text := S;
   FInformation.Time := S;

   // SingleOP以外はTX#を表示する
   if dmZLogGlobal.ContestCategory = ccSingleOp then begin
      strTxNo := '';
   end
   else begin
      strTxNo := 'TX#' + IntToStr(dmZLogGlobal.TXNr);
   end;

   FQsyInfoForm.SetQsyInfo(fQsyOK, strTxNo, S2);
end;

procedure TMainForm.CallsignSentProc(Sender: TObject);
var
   Q: TQSO;
   S: String;
   nID: Integer;
   curQSO: TQSO;
   C, N, B, M, SE, OP: TEdit;
begin
   nID := FCurrentTx;   //Integer(Sender); //FKeyPressedRigID;   //Integer(Sender);
   curQSO := TQSO.Create();

   AssignControls(nID, C, N, B, M, SE, OP);

   // .か?があるときは以降の送信は行わない
   if (Pos('.', C.Text) > 0) or (Pos('?', C.Text) > 0) then begin
      dmZLogKeyer.ClrBuffer();
      OnPlayMessageFinished(Sender, mCW, True);
      Exit;
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- ☆☆☆Begin CallsignSentProc() ID = [' + IntToStr(nID) + ']'));
   {$ENDIF}
   try
      curQSO.Callsign := C.Text;
      curQSO.Band     := TextToBand(B.Text);
      curQSO.Mode     := TextToMode(M.Text);
      curQSO.Operator := OP.Text;
      dmZLogGlobal.SetOpPower(curQSO);

      Q := Log.QuickDupe(curQSO);
      if FTabKeyPressed[nID] and (Q <> nil) then begin
         // ステータスバーにDUPE表示
         WriteStatusLineRed(Q.PartialSummary(dmZlogGlobal.Settings._displaydatepartialcheck), True);

         // ALLOW DUPEしない場合は4番を送出
         if dmZLogGlobal.Settings._allowdupe = False then begin
            // 先行して送出されている2番をクリア
            if dmZLogKeyer.UseWinKeyer = False then begin
               FMessageManager.ClearQue();
//               dmZLogKeyer.ClrBuffer;
            end;

            if dmZlogGlobal.Settings._switchcqsp then begin
               if dmZlogGlobal.Settings.CW.CurrentBank = 2 then begin
                  C.SelectAll;
                  exit;
               end;
            end;

            // 4番(QSO B4 TU)送出
            S := ' ' + dmZlogGlobal.CWMessage(1, 4);
//            nID := FCurrentTx;
            FMessageManager.AddQue(0, S, curQSO);

//            if dmZLogKeyer.UseWinKeyer = True then begin
//               FMessageManager.AddQue(True, nID, S, CurrentQSO);
//            end
//            else begin
//               dmZLogKeyer.SendStr(nID, S);
//               dmZLogKeyer.SetCallSign(CurrentQSO.Callsign);
//            end;

            C.SelectAll;

            exit; { BECAREFUL!!!!!!!!!!!!!!!!!!!!!!!! }
         end;
      end;

      if FTabKeyPressed[nID] then begin
         CallSpaceBarProc(C, N, B);
         if Is2bsiq() = False then begin
            N.SetFocus();
         end;
         EditedSinceTABPressed := tabstate_tabpressedbutnotedited; // UzLogCW
      end;

//      FMessageManager.ContinueQue();
   finally
      dmZLogKeyer.ResumeCW;
      curQSO.Free();
      {$IFDEF DEBUG}
      OutputDebugString(PChar('--- End CallsignSentProc() ---'));
      {$ENDIF}
   end;
end;

procedure TMainForm.AssignControls(nID: Integer; var C, N, B, M, S, O: TEdit);
begin
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin
      C := CallsignEdit1;
      N := NumberEdit1;
      B := BandEdit1;
      M := ModeEdit1;
      S := SerialEdit1;
      O := OpEdit1;
   end
   else begin
      C := FEditPanel[nID].CallsignEdit;
      N := FEditPanel[nID].NumberEdit;
      B := FEditPanel[nID].BandEdit;
      M := FEditPanel[nID].ModeEdit;
      S := FEditPanel[nID].SerialEdit;
      O := FEditPanel[nID].OpEdit;
   end;
end;

procedure TMainForm.CallSpaceBarProc(C, N, B: TEdit);
var
   strNumber: string;
   str: string;
   Q: TQSO;
begin
   Q := TQSO.Create();
   Q.Callsign := C.Text;
   Q.NrRcvd := N.Text;
   Q.Band := TextToBand(B.Text);

   strNumber := MyContest.SpaceBarProc(C.Text, N.Text, Q.Band);

   if dmZlogGlobal.Settings._entersuperexchange and (FSpcRcvd_Estimate <> '') then begin
      if strNumber = '' then begin
         if CoreCall(FSpcFirstDataCall) = CoreCall(C.Text) then begin
            strNumber := TrimRight(FSpcRcvd_Estimate);
            MyContest.MultiFound := True;
         end;
      end;
   end;

   if FCheckMulti.Visible then begin
      FCheckMulti.Renew(Q);
   end;

   if FCheckCountry.Visible then begin
      FCheckCountry.Renew(Q);
   end;

   N.Text := strNumber;

   if (MyContest is TALLJAContest) or
      (MyContest is TSixDownContest) or
      (MyContest is TFDContest) or
      (MyContest is TACAGContest) then begin
      str := N.Text;
      if str <> '' then begin
         if CharInSet(str[length(str)], ['H', 'M', 'L', 'P']) then begin
            N.SelStart := length(str) - 1;
            N.SelLength := 1;
         end;
      end;
   end;

//   if (dmZLogGlobal.Settings._so2r_type = so2rNone) or
//      ((dmZLogGlobal.Settings._so2r_type <> so2rNone) and (Is2bsiq() = False)) or
//      ((dmZLogGlobal.Settings._so2r_type <> so2rNone) and (Is2bsiq() = True) and (FCurrentTX = FCurrentRx)) then begin
//      N.SetFocus;
//   end;

   if (MyContest is TCQWWContest) or
      (MyContest is TWAEContest) then begin
      if (dmZLogGlobal.IsMultiStation() = True) then begin
         if FCheckCountry.Visible = False then begin
            FCheckCountry.Renew(Q);
         end;

         if FCheckCountry.NotNewMulti(Q.Band) then begin
            WriteStatusLineRed(TMainForm_Not_a_new_multi, False);
            Exit;
         end;
      end;
   end;

   str := MyContest.MultiForm.GetInfo(Q);
   if str <> '' then begin
      WriteStatusLine(str, False);
   end;

   Q.Free();
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

      // Out of contest period表示
      FOutOfContestPeriod := Log.IsOutOfPeriod(CurrentQSO) and MyContest.UseContestPeriod;
      if (FPrevOutOfContestPeriod <> FOutOfContestPeriod) or (FFirstOutOfContestPeriod = True) then begin
         if panelOutOfPeriod.Visible <> FOutOfContestPeriod then begin
            ShowOutOfContestPeriod(FOutOfContestPeriod);
            FPrevOutOfContestPeriod := FOutOfContestPeriod;
            FFirstOutOfContestPeriod := False;
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
   PlayMessage(mSSB, 1, n, True);
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
   dlg2: TformExportCabrillo;
begin
   FileExportDialog.InitialDir := ExtractFilePath(CurrentFileName);
   FileExportDialog.FileName := ChangeFileExt(ExtractFileName(CurrentFileName), '');

   if FileExportDialog.Execute() = False then begin
      Exit;
   end;

   f := FileExportDialog.filename;
   ext := UpperCase(ExtractFileExt(f));

   if ext = '' then begin
      f := f + '.' + FileExportDialog.DefaultExt;
      ext := '.' + UpperCase(FileExportDialog.DefaultExt);
   end;

   if zyloExportFile(f) then Exit;

   if ext = '.ALL' then begin
      Log.SaveToFilezLogALL(f);
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
      dlg2 := TformExportCabrillo.Create(Self);
      try
         if dlg2.ShowModal() = mrCancel then begin
            Exit;
         end;
         Log.SaveToFileByCabrillo(f, dlg2.TimeZoneOffset);
      finally
         dlg2.Release();
      end;
   end;

   if ext = '.CSV' then begin
      if FileExportDialog.FilterIndex = 7 then begin
         ExportHamlog(f);
      end
      else begin
         Log.SaveToFilezLogCsv(f);
      end;
   end

   { Add code to save current file under SaveDialog.FileName }
end;

procedure TMainForm.SpeedButton9Click(Sender: TObject);
begin
   FormShowAndRestore(FZLinkForm);
end;

procedure TMainForm.SerialEdit1Change(Sender: TObject);
var
   i: Integer;
begin
   i := StrToIntDef(TEdit(Sender).Text, 0);

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
         R := MessageDlg(TMainForm_Change_Band_QSOs, mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
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

   ScrollGrid();
   Log.Saved := False;
end;

procedure TMainForm.menuSortByTimeClick(Sender: TObject);
begin
   Log.SortByTime();
   GridRefreshScreen();
end;

procedure TMainForm.menuSortByTxNoBandTimeClick(Sender: TObject);
begin
   Log.SortByTxNoBandTime();
   GridRefreshScreen();
end;

procedure TMainForm.menuShowOnlyTxClick(Sender: TObject);
var
   seltx: Integer;
begin
   seltx := TMenuItem(Sender).Tag;
   if FFilterTx = seltx then begin
      menuShowOnlySpecifiedTX.Checked := False;
   end
   else begin
      menuShowOnlySpecifiedTX.Checked := True;
   end;
   FFilterTx := seltx;
   menuShowCurrentBandOnly.Checked := False;
   menuShowThisTxOnly.Checked := False;
   GridRefreshScreen();
end;

procedure TMainForm.menuSortByClick(Sender: TObject);
begin
   Log.SortBy(TSortMethod(TMenuItem(Sender).Tag));
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
   if (TEdit(Sender).Name = 'TimeEdit1') or (TEdit(Sender).Name = 'TimeEdit2') then begin
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
   buttonCancelOutOfPeriod.Left := panelOutOfPeriod.Width - 26;
end;

procedure TMainForm.menuHardwareSettingsClick(Sender: TObject);
var
   f: TformOptions;
   rig: Integer;
begin
   f := TformOptions.Create(Self);
   rig := RigControl.GetCurrentRig();
   try
      // メモリースキャン解除
      RigControl.MemScanOff();

      // F2Aモード解除
      F2AOff();

      // KeyingとRigControlを一旦終了
      FRigControl.ForcePowerOff();
      CancelCqRepeat();
      dmZLogGlobal.Settings._so2r_use_rig3 := checkUseRig3.Checked;

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      checkUseRig3.Checked := dmZLogGlobal.Settings._so2r_use_rig3;
      dmZlogGlobal.ImplementSettings(False);
      dmZlogGlobal.SaveCurrentSettings();
      InitBandMenu();

      RenewCWToolBar;
      RenewVoiceToolBar;

      InitQsoEditPanel();
      InitSerialPanel();
      UpdateQsoEditPanel(rig);
      LastFocus := CallsignEdit;
      ShowCurrentQSO();

      SetWindowCaption();

      ZLinkForm.SendPcName();
   finally
      f.Release();

      // リグコントロール/Keying再開
      WriteStatusLine('', False);
      FRigControl.ForcePowerOn();

      // Accessibility
      if LastFocus.Visible then begin
         EditExit(LastFocus);
         EditEnter(LastFocus);
         LastFocus.SetFocus;
      end;
   end;
end;

procedure TMainForm.menuOptionsClick(Sender: TObject);
begin
   ShowOptionsDialog(0, 0, 1, 0);
end;

procedure TMainForm.ShowOptionsDialog(nEditMode: Integer; nEditNumer: Integer; nEditBank: Integer; nActiveTab: Integer);
var
   f: TformOptions2;
   b: TBand;
begin
   f := TformOptions2.Create(Self);
   try
      f.EditMode := nEditMode;
      f.EditNumber := nEditNumer;
      f.EditBank := nEditBank;
      f.ActiveTab := nActiveTab;

      // メモリースキャン解除
      RigControl.MemScanOff();

      // F2Aモード解除
      F2AOff();

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      checkUseRig3.Checked := dmZLogGlobal.Settings._so2r_use_rig3;
      dmZlogGlobal.ImplementSettings(False);
      dmZlogGlobal.SaveCurrentSettings();
      InitBandMenu();

      RenewCWToolBar;
      RenewVoiceToolBar;

      InitQsoEditPanel();
      InitSerialPanel();
      LastFocus := CallsignEdit;
      ShowCurrentQSO();

      FCheckCall2.ResetListBox();
      FCheckMulti.ResetListBox();
      FCheckCountry.ResetListBox();
      FRateDialogEx.InitScoreGrid();
      FRateDialogEx.UpdateGraph();
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
         FBandScopeEx[b].UseResume := dmZLogGlobal.Settings._bandscope_use_resume;
      end;
      FBandScope.FreshnessType := dmZLogGlobal.Settings._bandscope_freshness_mode;
      FBandScope.IconType := dmZLogGlobal.Settings._bandscope_freshness_icon;
      FBandScope.UseResume := dmZLogGlobal.Settings._bandscope_use_resume;
      FBandScopeNewMulti.FreshnessType := dmZLogGlobal.Settings._bandscope_freshness_mode;
      FBandScopeNewMulti.IconType := dmZLogGlobal.Settings._bandscope_freshness_icon;
      FBandScopeNewMulti.UseResume := dmZLogGlobal.Settings._bandscope_use_resume;
      FBandScopeAllBands.FreshnessType := dmZLogGlobal.Settings._bandscope_freshness_mode;
      FBandScopeAllBands.IconType := dmZLogGlobal.Settings._bandscope_freshness_icon;
      FBandScopeAllBands.UseResume := dmZLogGlobal.Settings._bandscope_use_resume;
      actionShowBandScope.Execute();

      // OpList再ロード
      BuildOpListMenu2(OpMenu.Items, OpMenuClick);

      // Voice初期化
      FMessageManager.Init();

      // QSY Violation
      RenewScore();

      // Band再設定
      UpdateBand(CurrentQSO.Band);

      // QSL交換初期値
      CurrentQSO.QslState := dmZLogGlobal.Settings._qsl_default;
   finally
      f.Release();

      // リグコントロール/Keying再開
      WriteStatusLine('', False);

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
   nEditBank: Integer;
begin
   case CurrentQSO.Mode of
      mCW, mOther: begin
         if TMenuItem(Sender).Tag >= 101 then begin
            nEditBank := 1;
         end
         else begin
            nEditBank := dmZLogGlobal.Settings.CW.CurrentBank;
         end;
      end;
      mRTTY: nEditBank := 3;
      else nEditBank := 1;
   end;

   ShowOptionsDialog(1, TMenuItem(Sender).Tag, nEditBank, 0);
   RenewCWToolBar;
   FFunctionKeyPanel.UpdateInfo();
   LastFocus.SetFocus;
end;

procedure TMainForm.menuVoiceEditClick(Sender: TObject);
begin
   ShowOptionsDialog(2, TMenuItem(Sender).Tag, 1, 0);
   RenewVoiceToolBar;
   FFunctionKeyPanel.UpdateInfo();
end;

procedure TMainForm.menuBandPlanSettingsClick(Sender: TObject);
var
   f: TBandPlanEditDialog;
   Index: Integer;
begin
   f := TBandPlanEditDialog.Create(Self);
   try
      Index := comboBandPlan.ItemIndex;

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      comboBandPlan.Items.CommaText := dmZLogGlobal.Settings.FBandPlanPresetList;

      if comboBandPlan.Items.Count <= Index then begin
         comboBandPlan.ItemIndex := 0;
      end
      else begin
         comboBandPlan.ItemIndex := Index;
      end;

      BandScopeApplyBandPlan();
   finally
      f.Release();
   end;
end;

procedure TMainForm.menuQSORateSettingsClick(Sender: TObject);
var
   f: TGraphColorDialog;
   b: TBand;
   i: Integer;
begin
   f := TGraphColorDialog.Create(Self);
   try
      f.Style := FRateDialog.GraphStyle;
      f.StartPosition := FRateDialog.GraphStartPosition;
      for b := b19 to HiBand do begin
         f.BarColor[b] := FRateDialog.GraphSeries[b].SeriesColor;
         f.TextColor[b] := FRateDialog.GraphSeries[b].Marks.Font.Color;
      end;
      for i := 0 to 3 do begin
         f.ZaqBgColor[i] := FRateDialogEx.ZaqBgColor[i];
         f.ZaqFgColor[i] := FRateDialogEx.ZaqFgColor[i];
      end;
      for i := 0 to 1 do begin
         f.OtherBgColor[i] := FRateDialogEx.OtherBgColor[i];
         f.OtherFgColor[i] := FRateDialogEx.OtherFgColor[i];
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
      for i := 0 to 3 do begin
         FRateDialogEx.ZaqBgColor[i] := f.ZaqBgColor[i];
         FRateDialogEx.ZaqFgColor[i] := f.ZaqFgColor[i];
      end;
      for i := 0 to 1 do begin
         FRateDialogEx.OtherBgColor[i] := f.OtherBgColor[i];
         FRateDialogEx.OtherFgColor[i] := f.OtherFgColor[i];
      end;

      FRateDialogEx.Refresh();
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
   FormShowAndRestore(MarketForm);
end;

procedure TMainForm.CWFMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   CWFMenu.Items[0].Tag := THemisphereButton(Sender).Tag;
end;

procedure TMainForm.EditEnter(Sender: TObject);
var
   P: Integer;
   edit: TEdit;
begin
   LastFocus := TEdit(Sender);
   edit := TEdit(Sender);
   if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
      FCurrentRigSet := edit.Tag;
   end;

   if FPastEditMode = True then begin
      ShowInfoPanel('', nil, False);
      GridRefreshScreen();
      FPastEditMode := False;
   end;

   // SO2Rの場合、現在RIGとクリックされたControlのRIGが違うと強制切り替え
   if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
      if FCurrentRx <> (FCurrentRigSet - 1) then begin
         SwitchRig(FCurrentRigSet);
         FCQLoopStartRig := FCurrentRigSet;
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

   SetCurrentQSO(FCurrentRigSet - 1);

   actionQsoStart.Enabled:= True;
   actionQsoComplete.Enabled:= True;

   // memo欄ではSHIFTキーを使うaction禁止
   if TEdit(Sender).Tag = 1000 then begin
      EnableShiftKeyAction(False);
   end;
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

   // memo欄ではSHIFTキーを使うaction禁止
   if TEdit(Sender).Tag = 1000 then begin
      EnableShiftKeyAction(True);
   end;
end;

procedure TMainForm.menuConnectToZServerClick(Sender: TObject);
begin
   if dmZlogGlobal.Settings._zlink_telnet.FHostName = '' then begin
      MessageBox(Handle, PChar(TMainForm_ZserverNotConfigured), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      Exit;
   end;

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

procedure TMainForm.menuDownloadAllLogsClick(Sender: TObject);
begin
   FZLinkForm.LoadLogFromZLink;
   {
     if ZLinkForm.Transparent then
     ZLinkForm.LoadLogFromZLink   // clears current log
     else
     ZLinkForm.LoadLogFromZServer;  // does not clear }
end;

procedure TMainForm.menuMergeAllLogsClick(Sender: TObject);
begin
   FZLinkForm.MergeLogWithZServer;
end;

procedure TMainForm.menuDownloadOplistClick(Sender: TObject);
begin
   if MessageBox(Handle, PChar(TMainForm_ComfirmDownloadOpList), PChar(Application.Title), MB_YESNO or MB_ICONEXCLAMATION or MB_DEFBUTTON2) = IDNO then begin
      Exit;
   end;

   FProgress.Title := TMainForm_DownloadFile;
   FProgress.Text := ZLOG_OPLIST_INI;
   FProgress.Show();
   Enabled := False;

   // ファイルダウンロード
   FZLinkForm.GetFile(ZLOG_OPLIST_INI, ExtractFilePath(Application.ExeName));
end;

procedure TMainForm.menuDownloadSoundsClick(Sender: TObject);
begin
   if dmZLogGlobal.SoundPath = '' then begin
      MessageBox(Handle, PChar(TMainForm_SoundFileFolderNotSet), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      Exit;
   end;

   if MessageBox(Handle, PChar(TMainForm_ComfirmDownloadSound), PChar(Application.Title), MB_YESNO or MB_ICONEXCLAMATION or MB_DEFBUTTON2) = IDNO then begin
      Exit;
   end;

   FProgress.Title := TMainForm_DownloadFile;
   FProgress.Text := ZLOG_SOUND_FILES;
   FProgress.Show();
   Enabled := False;

   // ファイルダウンロード
   FZLinkForm.GetFile(ZLOG_SOUND_FILES, dmZLogGlobal.SoundPath);
end;

procedure TMainForm.menuUploadOplistClick(Sender: TObject);
begin
   if MessageBox(Handle, PChar(TMainForm_ComfirmUploadOpList), PChar(Application.Title), MB_YESNO or MB_ICONEXCLAMATION or MB_DEFBUTTON2) = IDNO then begin
      Exit;
   end;

   FProgress.Title := TMainForm_UploadFile;
   FProgress.Text := ZLOG_OPLIST_INI;
   FProgress.Show();
   Enabled := False;

   FZLinkForm.PutFile(ExtractFilePath(Application.ExeName) + ZLOG_OPLIST_INI);
end;

procedure TMainForm.menuUploadSoundsClick(Sender: TObject);
begin
   if dmZLogGlobal.SoundPath = '' then begin
      MessageBox(Handle, PChar(TMainForm_SoundFileFolderNotSet), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      Exit;
   end;

   if MessageBox(Handle, PChar(TMainForm_ComfirmUploadSound), PChar(Application.Title), MB_YESNO or MB_ICONEXCLAMATION or MB_DEFBUTTON2) = IDNO then begin
      Exit;
   end;

   FProgress.Title := TMainForm_Compressing;
   FProgress.Text := dmZLogGlobal.SoundPath;
   FProgress.Show();
   Enabled := False;

   // ZIPファイル作成
   if CompressSoundFiles() = False then begin
      MessageBox(Handle, PChar(TMainForm_FailedToCompressSoundFiles), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      FProgress.Hide();
      Enabled := True;
      Exit;
   end;

   FProgress.Title := TMainForm_UploadFile;
   FProgress.Text := ZLOG_SOUND_FILES;

   // ZIPファイルアップロード
   FZLinkForm.PutFile(dmZLogGlobal.SoundPath + ZLOG_SOUND_FILES);
end;

procedure TMainForm.DisableNetworkMenus;
begin
   menuDownloadAllLogs.Enabled := False;
   menuMergeAllLogs.Enabled := False;
   menuDownloadOplist.Enabled := False;
   menuUploadOplist.Enabled := False;
   menuDownloadSounds.Enabled := False;
   menuUploadSounds.Enabled := False;
end;

procedure TMainForm.EnableNetworkMenus;
begin
   menuDownloadAllLogs.Enabled := True;
   menuMergeAllLogs.Enabled := True;
   menuDownloadOplist.Enabled := True;
   menuUploadOplist.Enabled := True;
   menuDownloadSounds.Enabled := True;
   menuUploadSounds.Enabled := True;
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
         R := MessageDlg(TMainForm_Change_Mode_QSOs, mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
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

   ScrollGrid();
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
         R := MessageDlg(TMainForm_Change_Operator_QSOs, mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
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

   ScrollGrid();
   Log.Saved := False;
end;

procedure TMainForm.menuEditStatusClick(Sender: TObject);
var
   dlg: TformStatusEdit;
   i: Integer;
   aQSO: TQSO;
begin
   dlg := TformStatusEdit.Create(Self);
   try
      // 選択行の先頭の値を初期値として採用
      i := Grid.Selection.Top;
      aQSO := TQSO(Grid.Objects[0, i]);
      dlg.Invalid  := aQSO.Invalid;
      dlg.CQ       := aQSO.CQ;
      dlg.QslState := aQSO.QslState;

      // ダイアログ表示
      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

      // 選択範囲に反映
      for i := Grid.Selection.Top to Grid.Selection.Bottom do begin
         aQSO := TQSO(Grid.Objects[0, i]);
         if aQSO.Reserve = actLock then begin
            Continue;
         end;

         aQSO.Invalid  := dlg.Invalid;
         aQSO.CQ       := dlg.CQ;
         aQSO.QslState := dlg.QslState;
      end;

      // スコア再計算
      MyContest.Renew();

      // 画面リフレッシュ
      GridRefreshScreen(True);

      // バンドスコープリフレッシュ
      BSRefresh();

      // 未セーブです
      Log.Saved := False;

      // 画面リフレッシュ
      GridRefreshScreen(True);
   finally
      dlg.Free();
   end;
end;

procedure TMainForm.SendSpot1Click(Sender: TObject);
var
   _top, _bottom: Integer;
   aQSO: TQSO;
   F: TSpotForm;
begin
   with Grid do begin
      _top := Selection.top;
      _bottom := Selection.Bottom;
   end;

   if _top = _bottom then begin
      aQSO := TQSO(Grid.Objects[0, Grid.Row]);

      F := TSpotForm.Create(Self);
      try
         F.Open(aQSO);
         F.ShowModal();
      finally
         F.Release();
      end;
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
   ShowSentNumber();
end;

procedure TMainForm.PowerEdit1Click(Sender: TObject);
var
   e: TEdit;
   pt: TPoint;
begin
   e := TEdit(Sender);
   pt.X := e.Left + 20;
   pt.Y := e.Top;
   pt := TPanel(e.Parent).ClientToScreen(pt);
   NewPowerMenu.Popup(pt.X, pt.Y);
end;

procedure TMainForm.OpEdit1Click(Sender: TObject);
var
   e: TEdit;
   pt: TPoint;
begin
   if dmZlogGlobal.OpList.Count = 0 then begin
      MessageBox(Handle, PChar(TMainForm_EmptyOpList), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      Exit;
   end;

   e := TEdit(Sender);
   pt.X := e.Left + 20;
   pt.Y := e.Top;
   pt := TPanel(e.Parent).ClientToScreen(pt);
   OpMenu.Popup(pt.X, pt.Y);
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
      S := Format(TMainForm_Confirm_Save_Changes, [CurrentFileName]);
      R := MessageDlg(S, mtConfirmation, [mbYes, mbNo, mbCancel], 0); { HELP context 0 }
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
   FPastEditMode := True;

   if Grid.LeftCol <> 0 then
      Grid.LeftCol := 0;
end;

procedure TMainForm.GridMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if EditScreen <> nil then begin
      SetEditFields1R(EditScreen);
   end;
end;

procedure TMainForm.StatusLineResize(Sender: TObject);
var
   rig: TRig;
begin
   StatusLine.Panels[3].Width := 60;

   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if rig <> nil then
      StatusLine.Panels[2].Width := 50
   else
      StatusLine.Panels[2].Width := 0;

   StatusLine.Panels[1].Width := 80;

   StatusLine.Panels[0].Width := StatusLine.Width - (StatusLine.Panels[1].Width + StatusLine.Panels[2].Width + StatusLine.Panels[3].Width);
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

// Correct start time
procedure TMainForm.menuCorrectStartTimeClick(Sender: TObject);
begin
   if InputStartTime(False) = False then begin
      Exit;
   end;
   Log.Period := MyContest.Period;

   if MessageBox(Handle, PChar(TMainForm_JudgePeriod), PChar(Application.Title), MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2) = IDYES then begin
      // 期間内再判定
      Log.JudgeOutOfPeriod();
      Log.SetDupeFlags;
   end;

   // 保存する
   Log.Saved := False;
   if (CurrentFileName <> '') then begin
      Log.SaveToFile(CurrentFileName);
   end;

   // 画面リフレッシュ
   RenewScore();

   // 期間外再表示
   FFirstOutOfContestPeriod := True;
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
         R := MessageDlg(TMainForm_Change_Power_QSOs, mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
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

   ScrollGrid();
   Log.Saved := False;
end;

procedure TMainForm.menuChangeDateClick(Sender: TObject);
var
   F: TDateDialog;
   i: Integer;
   newDate: TDateTime;
   Q: TQSO;
   seltop, selbottom: Integer;
begin
   F := TDateDialog.Create(Self);
   try
      seltop := Grid.Selection.Top;
      selbottom := Grid.Selection.Bottom;

      F.CurrentDate := TQSO(Grid.Objects[0, seltop]).Time;

      if F.ShowModal() <> mrOK then begin
         Exit;
      end;

      newDate := F.NewDate;

      for i := seltop to selbottom do begin
         Q := TQSO(Grid.Objects[0, i]);
         Q.Time := DateOf(newDate) + TimeOf(Q.Time);
      end;

      ScrollGrid();
      Log.Saved := False;
   finally
      F.Release();
   end;
end;

procedure TMainForm.menuChangeSentNrClick(Sender: TObject);
var
   F: TNRDialog;
   i: Integer;
   strNewNR: string;
   strNewNR2: string;
   B: TBand;
   Q: TQSO;
   seltop, selbottom: Integer;
begin
   F := TNRDialog.Create(Self);
   try
      seltop := Grid.Selection.Top;
      selbottom := Grid.Selection.Bottom;

      F.NewSentNR := TQSO(Grid.Objects[0, seltop]).NrSent;
      F.NewSentNR2 := TQSO(Grid.Objects[0, seltop]).NrSent;

      if F.ShowModal() <> mrOK then begin
         Exit;
      end;

      strNewNR := F.NewSentNR;
      strNewNR2 := F.NewSentNR2;

      for i := seltop to selbottom do begin
         Q := TQSO(Grid.Objects[0, i]);

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

      ScrollGrid();
      Log.Saved := False;
   finally
      F.Release();
   end;
end;

procedure TMainForm.MergeFile1Click(Sender: TObject);
var
   ff: string;
   ext: string;
   i: Integer;
   S: string;
begin
   FileImportDialog.InitialDir := dmZlogGlobal.LogPath;
   FileImportDialog.FileName := '';

   if FileImportDialog.Execute() = False then begin
      Exit;
   end;

   ff := FileImportDialog.filename;
   if ff = CurrentFileName then begin
      WriteStatusLine(TMainForm_Cannot_merge_current_file, True);
      Exit;
   end;

   i := 0;

   ext := UpperCase(ExtractFileExt(ff));

   if ext = '.ZLO' then begin
      WriteStatusLine(TMainForm_Merging_now, False);

      i := Log.QsoList.MergeFile(ff, True);
   end;

   if ext = '.ZLOX' then begin
      WriteStatusLine(TMainForm_Merging_now, False);

      i := Log.QsoList.MergeFileEx(ff, True);
   end;

   if ext = '.CSV' then begin
      i := Log.LoadFromFilezLogCsv(ff);
   end;

   if i = 0 then begin
      (* if none of the avobe formats succeeed *)
      i := zyloImportFile(ff);
   end;

   if i > 0 then begin
      Log.SortByTime;
      RenewScore();
      FileSave(Self);
   end;

   S := Format(TMainForm_Some_qsos_merged, [IntToStr(i)]);
   WriteStatusLine(S, True);

   // Analyzeウインドウが表示されている場合は表示更新する
   if FZAnalyze.Visible then begin
      PostMessage(FZAnalyze.Handle, WM_ANALYZE_UPDATE, 0, 0);
   end;
end;

procedure TMainForm.SaveFileAndBackUp;
begin
   Log.SaveToFile(CurrentFileName); // this is where the file is saved!!!
   actionBackup.Execute();
end;

procedure TMainForm.StatusLineDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
var
   S: string;
   R: TRect;
   x, y, h: Integer;
begin
   S := Panel.Text;
   R := Rect;
   if Panel.Index = 0 then begin
      StatusBar.Canvas.Font.Color := clStatusLine;
   end
   else begin
      StatusBar.Canvas.Font.Color := clWindowText;
   end;

   h := StatusBar.Canvas.TextHeight(S);
   x := Rect.Left + 1;
   y := Rect.Top + (((Rect.Bottom - Rect.Top) - h) div 2);
   StatusBar.Canvas.TextOut(x, y, S);
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
         R := MessageDlg(TMainForm_Change_TXNO_QSOs, mtConfirmation, [mbYes, mbNo], 0); { HELP context 0 }
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

   ScrollGrid();
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
      mnHideCWPhToolBar.Checked := True;
   end
   else begin
      mnHideCWPhToolBar.Checked := False;
   end;
   ShowToolBar(CurrentQSO.Mode);
end;

procedure TMainForm.mnHideMenuToolbarClick(Sender: TObject);
begin
   if mnHideMenuToolbar.Checked = False then begin
      mnHideMenuToolbar.Checked := True;
   end
   else begin
      mnHideMenuToolbar.Checked := False;
   end;
   ShowToolBar(CurrentQSO.Mode);
end;

procedure TMainForm.SwitchLastQSOBandMode;
var
   T, mytx, i: Integer;
   boo: Boolean;
   rig: TRig;
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

         rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));

         if rig <> nil then begin
            rig.SetBand(FCurrentRigSet, CurrentQSO);

            if CurrentQSO.Mode = mSSB then begin
               rig.SetMode(CurrentQSO);
            end;

            // Antenna Select
            if (FCurrentRigSet = 1) or (FCurrentRigSet = 2) then begin
               rig.AntSelect(dmZLogGlobal.Settings.FRigSet[FCurrentRigSet].FAnt[CurrentQSO.Band]);
            end;
         end;

         UpdateMode(Log.QsoList[i].mode);

         if rig <> nil then begin
            rig.SetMode(CurrentQSO);
         end;

         LastFocus.SetFocus;
      end;
   end;
end;

procedure TMainForm.mnMMTTYClick(Sender: TObject);
var
   ini: TMemIniFile;
begin
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      if mnMMTTY.Tag = 0 then begin
         mnMMTTY.Tag := 1;
         mnMMTTY.Caption := 'Exit MMTTY';
         mnTTYConsole.Visible := True;

         FTTYConsole := TTTYConsole.Create(Self);
         dmZlogGlobal.ReadWindowState(ini, FTTYConsole);

         dmZLogKeyer.CloseBGK();

         FTTYConsole.SetTTYMode(ttyMMTTY);
         InitializeMMTTY(Handle);

         FormShowAndRestore(FTTYConsole);
         FTTYConsole.SetFocus;
      end
      else begin
         mnMMTTY.Tag := 0;
         mnMMTTY.Caption := 'Load MMTTY';
         mnTTYConsole.Visible := False;

         dmZlogGlobal.WriteWindowState(ini, FTTYConsole);
         ini.UpdateFile();

         FTTYConsole.Close();
         FTTYConsole.Release();
         FTTYConsole := nil;

         ExitMMTTY;

         dmZLogKeyer.InitializeBGK(dmZlogGlobal.Settings.CW._interval);
         dmZLogGlobal.InitializeCW();
      end;
   finally
      ini.Free();
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
   FormShowAndRestore(FQuickRef);
end;

procedure TMainForm.menuPortalClick(Sender: TObject);
begin
   ShellExecute(Handle, 'open', PChar('https://zlog.org/'), nil, nil, SW_SHOW);
end;

procedure TMainForm.menuUsersGuideClick(Sender: TObject);
begin
   ShellExecute(Handle, 'open', PChar('https://use.zlog.org/'), nil, nil, SW_SHOW);
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

procedure TMainForm.CreateJARLELogClick(Sender: TObject);
var
   f: TformELogJarlEx;
begin
   f := TformELogJarlEx.Create(Self);
   try
      f.ShowModal();
   finally
      f.Release();
   end;
end;

procedure TMainForm.CreateCabrilloClick(Sender: TObject);
var
   f: TformELogCabrillo;
begin
   f := TformELogCabrillo.Create(Self);
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
      end;

      if SaveInBackGround = True then begin
         SaveFileAndBackUp;
         SaveInBackGround := False;
      end;

      CWPauseButton.Enabled := False;
      CWStopButton.Enabled := False;

      if (FInitialized = True) and (FPrevTotalQSO <> Log.TotalQSO) then begin
         if Assigned(FRateDialog) then begin
            FRateDialog.UpdateGraph();
         end;
         if Assigned(FRateDialogEx) then begin
            FRateDialogEx.UpdateGraph();
         end;
         FPrevTotalQSO := Log.TotalQSO;
      end;
   end;

   if CurrentQSO.Mode = mRTTY then begin
      if FTTYConsole <> nil then begin
         if FTTYConsole.Sending = False then begin
         end;
      end;
   end;

   // MOPでOPが未選択の場合
   if FPastEditMode = False then begin
      if dmZLogGlobal.ContestCategory in [ccMultiOpMultiTx, ccMultiOpSingleTx, ccMultiOpTwoTx] then begin
         if dmZLogGlobal.CurrentOperator = nil then begin
            ShowInfoPanel(TMainForm_Select_Operator, nil, True);
         end
         else begin
            ShowInfoPanel('', nil, False);
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
   b: Integer;
   BB: TBand;
   rigno: Integer;
   Q: TQSO;
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

      InitSerialNumber();
      mPXListWPX.Visible := False;

      dmZlogGlobal.ContestCategory := menu.ContestCategory;

      // SO2RはSingleOpのみが設定可能
      if dmZLogGlobal.ContestCategory <> ccSingleOp then begin
         if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
            dmZLogGlobal.Settings._operate_style := os1Radio;
            InitQsoEditPanel();
            UpdateQsoEditPanel(1);
            LastFocus := CallsignEdit;
         end;
      end;

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

      // 0:ALL BAND 1～:SINGLE BAND
      b := menu.BandGroupIndex;
      if b > 0 then begin
         CurrentQSO.Band := TBand(b - 1);

         BandEdit.Text := CurrentQSO.BandStr;

         for BB := b19 to HiBand do begin
            BandMenu.Items[ord(BB)].Enabled := False;
         end;

         BandMenu.Items[b - 1].Enabled := True;
      end
      else begin
         for BB := b19 to HiBand do begin
            BandMenu.Items[ord(BB)].Enabled := True;
         end;
      end;

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

      MyContest.ScoreForm.OnChangeFontSize := OnChangeFontSize;
      MyContest.MultiForm.OnChangeFontSize := OnChangeFontSize;

      MultiButton.Enabled := True; // toolbar
      Multipliers1.Enabled := True; // menu
      mnCheckCountry.Visible := False; // checkcountry window

      SetGridWidth(EditScreen);
      SetEditFields1R(EditScreen);
      InitSerialPanel();

      // #201 モード選択によって動作を変える(NEW CONTESTのみ)
      case menu.ContestMode of
         // PH/CW
         cmMix: begin
            CurrentQSO.Mode := dmZLogGlobal.LastMode[0];
            if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
               FEditPanel[0].ModeEdit.Text := ModeToText(dmZLogGlobal.LastMode[0]);
               FEditPanel[1].ModeEdit.Text := ModeToText(dmZLogGlobal.LastMode[1]);
               FEditPanel[2].ModeEdit.Text := ModeToText(dmZLogGlobal.LastMode[2]);
            end;
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
            CurrentQSO.Mode := dmZLogGlobal.LastMode[0];
            if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
               FEditPanel[0].ModeEdit.Text := ModeToText(dmZLogGlobal.LastMode[0]);
               FEditPanel[1].ModeEdit.Text := ModeToText(dmZLogGlobal.LastMode[1]);
               FEditPanel[2].ModeEdit.Text := ModeToText(dmZLogGlobal.LastMode[2]);
            end;
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

      // 局種係数
      if MyContest.UseCoeff = True then begin
         Log.ScoreCoeff := menu.ScoreCoeff;
      end;

      // ファイル名の指定が無い場合は選択ダイアログを出す
      if CurrentFileName = '' then begin
         OpenDialog.InitialDir := dmZlogGlobal.LogPath;
         OpenDialog.FileName := '';
         OpenDialog.FilterIndex := dmZLogGlobal.Settings.FLastFileFilterIndex;

         if OpenDialog.Execute then begin
            dmZLogGlobal.SetLogFileName(OpenDialog.FileName);

            if FileExists(OpenDialog.FileName) then begin
               LoadNewContestFromFile(OpenDialog.FileName);
            end
            else begin
               Log.SaveToFile(OpenDialog.FileName);
            end;

            dmZLogGlobal.Settings.FLastFileFilterIndex := OpenDialog.FilterIndex;
         end
         else begin // user hit cancel
            MessageDlg(TMainForm_Need_File_Name, mtWarning, [mbOK], 0); { HELP context 0 }
         end;
      end;

      // 開始時刻
      if (MyContest.UseContestPeriod = True) and (Log.StartTime = 0) then begin
         InputStartTime(True);
      end;

      // コンテスト期間
      Log.Period := MyContest.Period;

      SetWindowCaption();

      // Sentは各コンテストで設定された値
      dmZlogGlobal.Settings._sentstr := MyContest.SentStr;

      RenewScore();

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

      // Ctrl+Qを押すとQTCを送信できます
      SetupQTC();

      CurrentQSO.UpdateTime;
      TimeEdit.Text := CurrentQSO.TimeStr;

      // この時点でコンテストが必要とするバンドはBandMenuで表示されているもの
      // コンテストで必要なバンドかつActiveBandがONの数（＝使用可能）を数える
      c := GetNumOfAvailableBands();

      // 使用可能なバンドが無いときは必要バンドをONにする
      if c = 0 then begin
         AdjustActiveBands();
         MessageDlg(TMainForm_Active_Band_Adjusted, mtInformation, [mbOK], 0);
      end;

      // 低いバンドから使用可能なバンドを探して最初のバンドとする
      if (MyContest.BandLow <= dmZLogGlobal.LastBand[0]) and (MyContest.BandHigh >= dmZLogGlobal.LastBand[0]) then begin
         CurrentQSO.Band := GetFirstAvailableBand(dmZLogGlobal.LastBand[0]);
      end
      else begin
         AdjustActiveBands();
         CurrentQSO.Band := MyContest.BandLow;
      end;

      if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
         for i := 0 to 2 do begin
            FEditPanel[i].BandEdit.Text := BandToText(dmZLogGlobal.LastBand[i]);
         end;
      end;
      FRateDialogEx.Band := CurrentQSO.Band;

      BandEdit.Text := MHzString[CurrentQSO.Band];
      CurrentQSO.TX := dmZlogGlobal.TXNr;

      ModeEdit.Text := CurrentQSO.ModeStr;
      RcvdRSTEdit.Text := CurrentQSO.RSTStr;

      // マルチオペの場合は最後のOPをセット
      if (dmZlogGlobal.ContestCategory in [ccMultiOpMultiTx, ccMultiOpSingleTx, ccMultiOpTwoTx]) and
         (Log.TotalQSO > 0) then begin
         if (dmZLogGlobal.Settings._selectlastoperator = True) then begin
            SelectOperator(Log.QsoList.Last.Operator);
         end
         else begin
            SelectOperator('Clear');
         end;
      end;

      // 最初はCQモードから
      SetCQ(dmZLogGlobal.Settings.FLastCQMode);

      ShowToolBar(CurrentQSO.Mode);

      // CurrentQSO.Serial := SerialArray[b19]; // in case SERIALSTART is defined. SERIALSTART applies to all bands.
      SetInitSerialNumber(CurrentQSO);
      DispSerialNumber(CurrentQSO);

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
            RenewScore();
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

      // SO2R
      if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
         checkUseRig3.Checked := dmZLogGlobal.Settings._so2r_use_rig3;
      end;

      // Select BandPlan
      i := comboBandPlan.Items.IndexOf(MyContest.BandPlan);
      if i = -1 then begin
         i := 0;
      end;
      comboBandPlan.ItemIndex := i;
      dmZLogGlobal.SelectBandPlan(MyContest.BandPlan);

      // リグコントロール開始
      FRigControl.ForcePowerOn();

      if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
         // 右側のバンドとモードを取得＆設定
         for BB := b19 to b10g do begin
            rigno := dmZLogGlobal.Settings.FRigSet[2].FRig[BB];
            if (rigno <> 0) and (RigControl.Rigs[rigno] <> nil) then begin
               FEditPanel[1].ModeEdit.Text := ModeString[RigControl.Rigs[rigno].CurrentMode];
               FEditPanel[1].BandEdit.Text := MHzString[RigControl.Rigs[rigno].CurrentBand];
               Break;
            end;
         end;

         // 下側のバンドとモードを設定
         if (RigControl.Rigs[5] <> nil) then begin
            Q := TQSO.Create();
            Q.Band := dmZLogGlobal.LastBand[2];
            Q.Mode := dmZLogGlobal.LastMode[2];
            RigControl.Rigs[5].SetBand(2, Q);
            RigControl.Rigs[5].SetMode(Q);
            Q.Free();
         end;
      end;

      // CTY.DATが必要なコンテストでロードされていない場合はお知らせする
      if (MyContest.NeedCtyDat = True) and (dmZLogGlobal.CtyDatLoaded = False) then begin
         WriteStatusLineRed(TMainForm_CtyDat_not_loaded, True);
      end;

      // User Defined ContestでDATファイルがロードされていない場合はお知らせする
      if (MyContest is TGeneralContest) and (TGeneralContest(MyContest).UserDatLoaded = False) then begin
         WriteStatusLineRed(TGeneralContest(MyContest).Config.DatFileName + TMainForm_UserDat_not_loaded, True);
      end;

      // 最初はRIG1から
      SwitchRig(1);

      // Analyzeウインドウが表示されている場合は表示更新する
      if FZAnalyze.Visible then begin
         PostMessage(FZAnalyze.Handle, WM_ANALYZE_UPDATE, 0, 0);
      end;

      StatusLineResize(nil);
      ShowSentNumber();

      // 初期化完了
      FInitialized := True;
      Timer1.Interval := dmZLogGlobal.Settings.FInfoUpdateInterval;
      Timer1.Enabled := True;
      zyloContestOpened(MyContest.Name, menu.CFGFileName);

      // Sent NRチェック
      if ((Pos('$V', dmZLogGlobal.Settings._sentstr) > 0) and (dmZLogGlobal.Settings._prov = '')) or
         ((Pos('$Q', dmZLogGlobal.Settings._sentstr) > 0) and (dmZLogGlobal.Settings._city = '')) or
         ((dmZLogGlobal.Settings._prov = '') and (dmZLogGlobal.Settings._city = '')) then begin
         if (MyContest is TGeneralContest) then begin
            dmZLogGlobal.Settings.ReadOnlyParamImported := False;
         end;
         MessageBox(Handle, PChar(TMainForm_Setup_SentNR_first), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
         PostMessage(Handle, WM_ZLOG_SHOWOPTIONS, 0, 0);
      end;
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
   FSuperCheck.Clear();
   FSuperCheck2.Clear();
   FSpcDataLoading := False;
end;

procedure TMainForm.OnZLogCqRepeatContinue( var Message: TMessage );
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('>>> Enter - OnZLogCqRepeatContinue() '));
   {$ENDIF}
   CQRepeatProc(Message.WParam, False);
   {$IFDEF DEBUG}
   OutputDebugString(PChar('>>> Leave - OnZLogCqRepeatContinue() '));
   {$ENDIF}
end;

procedure TMainForm.OnZLogSpaceBarProc( var Message: TMessage );
begin
   SpaceBarProc(Message.WParam);
end;

procedure TMainForm.OnZLogSwitchRig( var Message: TMessage );
var
   rig: Integer;
   proc: Integer;
begin
//   rig := Message.WParam;
   proc := Message.LParam;

   rig := FCurrentRigSet;  //RigControl.GetCurrentRig();
   rig := GetNextRigID(rig - 1) + 1;

   if proc = 0 then begin
      SwitchRig(rig);
   end
   else begin
      SwitchTx(rig);
      SwitchRx(rig);
   end;
end;

procedure TMainForm.OnZLogPlayMessageA( var Message: TMessage );
begin
   OnPlayMessageA(Message.WParam);
end;

procedure TMainForm.OnZLogPlayMessageB( var Message: TMessage );
begin
   OnPlayMessageB(Message.WParam);
end;

procedure TMainForm.OnZLogPlayCQ( var Message: TMessage );
var
   bank: Integer;
   msgno: Integer;
   nID: Integer;
   mode: TMode;
   S: string;
   nSpeedUp: Integer;
   n: Integer;
   RandCQStr: array[1..2] of string;
begin
   bank := Message.WParamLo;
   msgno := Message.WParamHi;
   nSpeedUp := Message.LParamLo;

   // 送信側RIGのモードを判定
   nID := FCurrentTx;

   // TODO:↓はTX側のモードを取得する
   mode := TextToMode(FEditPanel[nID].ModeEdit.Text);
   if mode = mOther then begin
      mode := CurrentQSO.Mode;
   end;

   FCQRepeatStartMode := mode;

   if mode = mCW then begin
      if (dmZLogGlobal.Settings.CW._cq_random_repeat = True) and (FCQLoopCount > 4) then begin
         RandCQStr[1] := SetStr(dmZLogGlobal.Settings.CW.AdditionalCQMessages[2], CurrentQSO);
         RandCQStr[2] := SetStr(dmZLogGlobal.Settings.CW.AdditionalCQMessages[3], CurrentQSO);

         n := FCQLoopCount mod 3; // random(3);
         if n > 2 then begin
            n := 0;
         end;

         if n in [1 .. 2] then begin
            if RandCQStr[n] = '' then begin
               n := 0;
            end;
         end;

         if n = 0 then begin
            S := dmZlogGlobal.CWMessage(bank, msgno);
            S := SetStr(UpperCase(S), CurrentQSO);
         end
         else begin
            S := RandCQStr[n];
         end;
      end
      else begin
         S := dmZlogGlobal.CWMessage(bank, msgno);
         S := SetStr(UpperCase(S), CurrentQSO);
      end;

      // CWポート設定チェック
      nID := GetTxRigID();
      if dmZLogKeyer.KeyingPort[nID] = tkpNone then begin
         WriteStatusLineRed(TMainForm_CW_port_is_no_set, False);
         FCQRepeatPlaying := False;
         Exit;
      end;

      if (nSpeedUp > 0) then begin
         S := '\+' + IntToStr(nSpeedUp) + S + '\-' + IntToStr(nSpeedUp);
      end;

      // TODO: ここを1shotにすればOK
      FMessageManager.AddQue(0, S, nil);
   end
   else begin
      // Voice再生(1shot)
      FMessageManager.AddQue(0, msgno);
   end;
end;

procedure TMainForm.OnZLogTogglePtt( var Message: TMessage );
begin
   TogglePTTfor2bsiq();
end;

procedure TMainForm.OnZLogShowMessage( var Message: TMessage );
var
   strMessage: string;
   uType: UINT;
begin
   strMessage := StrPas(PChar(Message.WParam));
   uType := Message.LParam;

   FProgress.Hide();
   Enabled := True;

   MessageBox(Handle, PChar(strMessage), PChar(Application.Title), uType);
end;

procedure TMainForm.OnZLogFileDownloadComplete( var Message: TMessage );
var
   strMessage: string;
   strFileName: string;
   zipfilename: string;
begin
   try
      strMessage := StrPas(PChar(Message.WParam));
      strFileName := StrPas(PChar(Message.LParam));

      // OPLIST再ロード
      if strFileName = ZLOG_OPLIST_INI then begin
         dmZLogGlobal.OpList.LoadFromIniFile();
         BuildOpListMenu2(OpMenu.Items, OpMenuClick);
      end;

      // SOUNDS.ZIP展開
      if strFileName = ZLOG_SOUND_FILES then begin
         zipfilename := dmZLogGlobal.SoundPath + ZLOG_SOUND_FILES;

         if FileExists(zipfilename) = False then begin
            MessageBox(Handle, PChar(ZLOG_SOUND_FILES + ' ' + TMainForm_FileNotFound), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
            FProgress.Hide();
            Enabled := True;
            Exit;
         end;

         FProgress.Title := 'ファイルを展開しています・・・';
         ExtractSoundFiles(zipfilename);
      end;

      FProgress.Hide();
      Enabled := True;

      MessageBox(Handle, PChar(strMessage), PChar(Application.Title), MB_OK or MB_ICONINFORMATION);
   except
      on E: Exception do begin
         FProgress.Hide();
         Enabled := True;
         MessageBox(Handle, PChar(E.Message), PChar(Application.Title), MB_OK or MB_ICONINFORMATION);
      end;
   end;
end;

procedure TMainForm.OnZLogSetFocus( var Message: TMessage );
begin
   if Message.WParam = 0 then begin
      CallsignEdit.SetFocus();
   end
   else begin
      NumberEdit.SetFocus();
   end;
end;

procedure TMainForm.OnZLogResetTx( var Message: TMessage );
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('>>> Enter - OnZLogResetTx() '));
   {$ENDIF}
   case Message.WParam of
      // 現在のRXに合わせる
      0: begin
         ResetTx(FCurrentRx + 1);
      end;

      // 指定のRIG
      1: begin
         ResetTx(Message.LParam + 1);
      end;
   end;
   {$IFDEF DEBUG}
   OutputDebugString(PChar('<<< Leave - OnZLogResetTx() '));
   {$ENDIF}
end;

procedure TMainForm.OnZLogInvertTx( var Message: TMessage );
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('>>> Enter - OnZLogInvertTx() '));
   {$ENDIF}
   InvertTx();
   {$IFDEF DEBUG}
   OutputDebugString(PChar('<<< Leave - OnZLogInvertTx() '));
   {$ENDIF}
end;

procedure TMainForm.OnZLogSwitchRx( var Message: TMessage );
var
   rx: Integer;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('>>> Enter - OnZLogSwitchRx() '));
   {$ENDIF}
   case Message.WParam of
      // 反対側へ
      0: begin
         rx := GetNextRigID(Message.LParam);
         SwitchRx(rx + 1);
      end;

      // TXに合わせる
      1: begin
         SwitchRx(Message.LParam + 1);
      end;

      // TXに合わせる
      2: begin
         SwitchRx(FCurrentTx + 1);
      end;

      // TXの反対側へ
      3: begin
         rx := GetNextRigID(FCurrentTx);
         SwitchRx(rx + 1);
      end;
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('<<< Leave - OnZLogSwitchRx() '));
   {$ENDIF}
end;

procedure TMainForm.OnZLogSwitchTx( var Message: TMessage );
var
   tx: Integer;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('>>> Enter - OnZLogSwitchTx() '));
   {$ENDIF}
   case Message.WParam of
      // 反対側へ
      0: begin
         tx := GetNextRigID(FCurrentTx);
         SwitchTx(tx + 1);
      end;

      // RXに合わせる
      1: begin
         SwitchTx(FCurrentRx + 1);
      end;

      // 指定のTXへ
      2: begin
         tx := Message.LParam;
         SwitchTx(tx + 1);
      end;
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('<<< Leave - OnZLogSwitchTx() '));
   {$ENDIF}
end;

procedure TMainForm.OnZLogSwitchTxRx( var Message: TMessage );
begin
   SwitchTxRx(Message.WParam, Message.LParam);
end;

procedure TMainForm.OnZLogAfterDelay( var Message: TMessage );
//var
//   dwTick: DWORD;
begin
//   dwTick := GetTickCount();
//   while True do begin
//      if (GetTickCount() - dwTick) >= (dmZLogGlobal.Settings._so2r_rigsw_after_delay) then begin
//         Break;
//      end;
//      Application.ProcessMessages();
//   end;
end;

procedure TMainForm.OnZLogSetCq( var Message: TMessage );
begin
   if (Message.WParam = 0) then begin
      SetCQ(False);
   end
   else begin
      SetCQ(True);
   end;
end;

procedure TMainForm.OnZLogSetCQLoop( var Message: TMessage );
begin
   StartCqRepeatTimer();
end;

procedure TMainForm.OnZLogCallsignSent( var Message: TMessage );
begin
   CallsignSentProc(TObject(Message.LParam));
end;

procedure TMainForm.OnZLogSetCurrentQso( var Message: TMessage );
var
   callsign_atom: ATOM;
   S: string;
begin
   SetCurrentQso(Message.WParam);

   S := CurrentQso.Callsign;
   callsign_atom := GlobalAddAtom(PChar(S));

   Message.ResultLo := callsign_atom;
   Message.ResultHi := 0;
end;

procedure TMainForm.OnZLogGetCallsign( var Message: TMessage );
var
   callsign_atom: ATOM;
   S: string;
begin
   S := CallsignEdit.Text;
   callsign_atom := GlobalAddAtom(PChar(S));

   Message.ResultLo := callsign_atom;
   Message.ResultHi := 0;
end;

procedure TMainForm.OnZLogGetVersion( var Message: TMessage );
begin
   Message.Result := 2800;
end;

procedure TMainForm.OnZLogSetPttState( var Message: TMessage );
begin
   FInformation.Ptt := Boolean(Message.WParam);
end;

procedure TMainForm.OnZLogSetTxIndicator( var Message: TMessage );
begin
   ShowTxIndicator();
end;

procedure TMainForm.OnZLogSetFocusCallsign( var Message: TMessage );
var
   nID: Integer;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** OnZLogSetFocusCallsign() w = ' + IntToStr(Message.WParam) + ' ***'));
   {$ENDIF}
   nID := Message.WParam;
   if FEditPanel[nID].CallsignEdit.Text <> '' then begin
      if FEditPanel[nID].NumberEdit.Visible and FEditPanel[nID].NumberEdit.Enabled then begin
         FEditPanel[nID].NumberEdit.SetFocus();
         FEditPanel[nID].NumberEdit.SelStart := Length(FEditPanel[nID].NumberEdit.Text);
         LastFocus := FEditPanel[nID].NumberEdit;
      end;
   end
   else begin
      if FEditPanel[nID].CallsignEdit.Visible and FEditPanel[nID].CallsignEdit.Enabled then begin
         FEditPanel[nID].CallsignEdit.SetFocus();
         FEditPanel[nID].CallsignEdit.SelStart := Length(FEditPanel[nID].CallsignEdit.Text);
         LastFocus := FEditPanel[nID].CallsignEdit;
      end;
   end;
end;

procedure TMainForm.OnZLogSetStatusText( var Message: TMessage );
var
   text_atom: ATOM;
   szBuffer: array[0..255] of Char;
   statustext: string;
   fWriteConsole: Boolean;
begin
   if Message.WParamLo = 0 then begin
      clStatusLine := clBlack;
   end
   else begin
      clStatusLine := clRed;
   end;

   if Message.WParamHi = 0 then begin
      fWriteConsole := False;
   end
   else begin
      fWriteConsole := True;
   end;

   text_atom := Message.LParamLo;

   ZeroMemory(@szBuffer, SizeOf(szBuffer));
   GetAtomName(text_atom, @szBuffer, SizeOf(szBuffer));
   DeleteAtom(text_atom);

   statustext := StrPas(szBuffer);

//   if ContainsDoubleByteChar(S) then begin
//      StatusLine.Font.Name := 'ＭＳ Ｐゴシック';
//      StatusLine.Font.Charset := 128; // shift jis
//   end
//   else begin
//      StatusLine.Font.Name := 'MS Sans Serif';
//      StatusLine.Font.Charset := 0; // shift jis
//   end;

   StatusLine.Panels[0].Text := statustext;

   if fWriteConsole then
      FConsolePad.AddLine(statustext);
end;

procedure TMainForm.OnZLogMoveLastFreq( var Message: TMessage );
begin
   actionSetLastFreq.Execute();
end;

procedure TMainForm.OnZLogShowOptions( var Message: TMessage );
begin
   ShowOptionsDialog(3, 0, 1, 1);
end;

procedure TMainForm.OnZLogCqAbortProc( var Message: TMessage );
var
   fRun: Boolean;
   fPlay: Boolean;
begin
   fRun := FCQLoopRunning;
   fPlay := FCQRepeatPlaying or dmZLogKeyer.IsPlaying();

   case Message.WParam of
      // 無条件に中止
      0: begin
         CQAbort(True);
      end;

      // CQLoop実行中なら中止
      1: begin
         if fRun = True then begin
            CQAbort(True);
         end;
      end;
   end;

   // フォーカス移動
   if Message.LParam = 1 then begin
      SetLastFocus();
   end;

   // CQループなし＆送信なしならフォーカス移動
   if Message.LParam = 2 then begin
      if (fRun = False) and (fPlay = False) then begin
         SetLastFocus();
      end;
   end;
end;

procedure TMainForm.OnDeviceChange( var Message: TMessage );
begin
   case Message.WParam of
      // DBT_DEVICEARRIVAL
      $8000: begin
         //
      end;

      // DBT_DEVICEREMOVECOMPLETE
      $8004: begin
         CQAbort(True);
         FRigControl.ForcePowerOff();
      end;
   end;
end;

procedure TMainForm.OnPowerBroadcast( var Message: TMessage );
begin
   case Message.WParam of
      PBT_APMRESUMESUSPEND: begin
         if dmZLogGlobal.Settings._turnon_resume then begin
            FRigControl.ForcePowerOn();
         end;
      end;

      PBT_APMSUSPEND: begin
         if dmZLogGlobal.Settings._turnoff_sleep then begin
            CQAbort(True);
            FRigControl.ForcePowerOff();
         end;
      end;
   end;
end;

procedure TMainForm.InitALLJA();
begin
//   BandMenu.Items[Ord(b19)].Visible := False;
   HideBandMenuWARC();
   HideBandMenuVU(False);

   EditScreen := TALLJAEdit.Create(Self);

   MyContest := TALLJAContest.Create(Self, 'ALL JA コンテスト');
end;

procedure TMainForm.Init6D();
begin
   HideBandMenuHF();
   HideBandMenuWARC();

   EditScreen := TACAGEdit.Create(Self);

   MyContest := TSixDownContest.Create(Self, '6m and DOWNコンテスト');
end;

procedure TMainForm.InitFD();
begin
//   BandMenu.Items[Ord(b19)].Visible := False;
   HideBandMenuWARC();

   EditScreen := TACAGEdit.Create(Self);

   MyContest := TFDContest.Create(Self, 'フィールドデーコンテスト');
end;

procedure TMainForm.InitACAG();
begin
//   BandMenu.Items[Ord(b19)].Visible := False;
   HideBandMenuWARC();

   EditScreen := TACAGEdit.Create(Self);

   MyContest := TACAGContest.Create(Self, '全市全郡コンテスト');
end;

procedure TMainForm.InitALLJA0_JA0(BandGroupIndex: Integer);
begin
   HideBandMenuHF();
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TJA0Edit.Create(Self);

   MyContest := TJA0ContestZero.Create(Self, 'ALL JA0 コンテスト (JA0)');

   case BandGroupIndex of
      // 1.9M
      1: begin
         TJA0Score(MyContest.ScoreForm).SetBand(b19);
         ShowBandMenu(b19);
      end;

      // 3.5M
      2: begin
         TJA0Score(MyContest.ScoreForm).SetBand(b35);
         ShowBandMenu(b35);
      end;

      // 7M
      3: begin
         TJA0Score(MyContest.ScoreForm).SetBand(b7);
         ShowBandMenu(b7);
      end;

      // 21/28M
      7, 9: begin
         TJA0Score(MyContest.ScoreForm).SetBand(b7);
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

   MyContest := TJA0Contest.Create(Self, 'ALL JA0 コンテスト (Others)');

   case BandGroupIndex of
      // 1.9M
      1: begin
         TJA0Score(MyContest.ScoreForm).SetBand(b19);
         ShowBandMenu(b19);
      end;

      // 3.5M
      2: begin
         TJA0Score(MyContest.ScoreForm).SetBand(b35);
         ShowBandMenu(b35);
      end;

      // 7M
      3: begin
         TJA0Score(MyContest.ScoreForm).SetBand(b7);
         ShowBandMenu(b7);
      end;

      // 21/28M
      7, 9: begin
         TJA0Score(MyContest.ScoreForm).SetBand(b21);
         dmZlogGlobal.Settings._band := 0;
         ShowBandMenu(b21);
         ShowBandMenu(b28);
      end;
   end;
end;

procedure TMainForm.InitDxPedi();
var
   F: TUTCDialog;
begin
   F := TUTCDialog.Create(Self);
   try
      F.ShowModal();

      MultiButton.Enabled := False; // toolbar
      Multipliers1.Enabled := False; // menu

      EditScreen := TGeneralEdit.Create(Self, False);

      MyContest := TPedi.Create(Self, 'Pedition mode');
      MyContest.UseUTC := F.UseUTC;
   finally
      F.Release();
   end;
end;

procedure TMainForm.InitUserDefined(ContestName, ConfigFile: string);
var
   B: TBand;
begin
   zyloContestSwitch(ContestName, ConfigFile);
   MyContest := TGeneralContest.Create(Self, ContestName, ConfigFile);

   for B := b19 to High(TGeneralContest(MyContest).Config.PowerTable) do begin
      if TGeneralContest(MyContest).Config.PowerTable[B] = '-' then begin
         HideBandMenu(B);
      end;
   end;

   if TGeneralContest(MyContest).Config.UseWarcBand = True then begin
      BandMenu.Items[ord(b10)].Visible := True;
      BandMenu.Items[ord(b18)].Visible := True;
      BandMenu.Items[ord(b24)].Visible := True;
   end
   else begin
      HideBandMenuWarc();
   end;

   if SerialContestType = 0 then begin
      EditScreen := TGeneralEdit.Create(Self, TGeneralContest(MyContest).Config.UseMulti2);
   end
   else begin
      EditScreen := TSerialGeneralEdit.Create(Self);

      Grid.Cells[MainForm.EditScreen.colNewMulti1, 0] := 'prefix';

      TSerialGeneralEdit(MainForm.EditScreen).formMulti := TGeneralMulti2(MyContest.MultiForm);

      Log.QsoList[0].Serial := $01; // uses serial number
      MyContest.SameExchange := False;
      dmZlogGlobal.Settings._sameexchange := MyContest.SameExchange;
   end;
end;

procedure TMainForm.InitCQWW();
begin
   HideBandMenuWARC();
   HideBandMenuVU();


   mnCheckCountry.Visible := True;
   mnCheckMulti.Caption := 'Check Zone';
   EditScreen := TWWEdit.Create(Self);

   MyContest := TCQWWContest.Create(Self, 'CQWW DX Contest', dmZLogGlobal.ContestMode);
   FCheckCountry.ParentMulti := TWWMulti(MyContest.MultiForm);
end;

procedure TMainForm.InitWPX(ContestCategory: TContestCategory);
begin
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TWPXEdit.Create(Self);

   Grid.Cells[EditScreen.colNewMulti1, 0] := 'prefix';

   MyContest := TCQWPXContest.Create(Self, 'CQ WPX Contest', dmZLogGlobal.ContestMode);

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
      MyContest := TJIDXContest.Create(Self, 'JIDX Contest (JA)', dmZLogGlobal.ContestMode);
   end
   else begin
      EditScreen := TGeneralEdit.Create(Self, False);
      MyContest := TJIDXContestDX.Create(Self, 'JIDX Contest (DX)', dmZLogGlobal.ContestMode);
   end;
   FCheckCountry.ParentMulti := TWWMulti(MyContest.MultiForm);
end;

procedure TMainForm.InitAPSprint();
begin
   BandMenu.Items[Ord(b19)].Visible := False;
   BandMenu.Items[Ord(b35)].Visible := False;
   BandMenu.Items[Ord(b28)].Visible := False;
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TWPXEdit.Create(Self);

   MyContest := TAPSprint.Create(Self, 'Asia Pacific Sprint');
end;

procedure TMainForm.InitARRL_W();
begin
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TDXCCEdit.Create(Self);

   MyContest := TARRLDXContestW.Create(Self, 'ARRL International DX Contest (W/VE)', dmZLogGlobal.ContestMode);
end;

procedure TMainForm.InitARRL_DX();
begin
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TARRLDXEdit.Create(Self);

   MyContest := TARRLDXContestDX.Create(Self, 'ARRL International DX Contest (DX)', dmZLogGlobal.ContestMode);
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

   MyContest := TARRL10Contest.Create(Self, 'ARRL 10m Contest');

   if dmZLogGlobal.IsUSA() then begin
      EditScreen := TDXCCEdit.Create(Self);
      MyContest.SentStr := '$V';
   end
   else begin
      EditScreen := TIOTAEdit.Create(Self);
      MyContest.SentStr := '$S';
   end;

   FCheckMulti.ListCWandPh := True;
end;

procedure TMainForm.InitIARU();
begin
   HideBandMenuVU();

   EditScreen := TIARUEdit.Create(Self);

   MyContest := TIARUContest.Create(Self, 'IARU HF Championship');
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

      MyContest := TAllAsianContest.Create(Self, 'All Asian DX Contest (Asia)', dmZLogGlobal.ContestMode);

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

   MyContest := TIOTAContest.Create(Self, 'IOTA Contest');
end;

procedure TMainForm.InitWAE();
begin
   BandMenu.Items[Ord(b19)].Visible := False;
   HideBandMenuWARC();
   HideBandMenuVU();

   EditScreen := TWPXEdit.Create(Self);

   MyContest := TWAEContest.Create(Self, 'WAEDC Contest', dmZLogGlobal.ContestMode);
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
   for b := MyContest.BandLow to MyContest.BandHigh do begin
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
      if (BandMenu.Items[Ord(b)].Visible = True) then begin
         dmZlogGlobal.Settings._activebands[b] := True;
         BandMenu.Items[Ord(b)].Enabled := True;
      end;
   end;
end;

function TMainForm.GetFirstAvailableBand(defband: TBand): TBand;
var
   b: TBand;
begin
   if defband <> bUnknown then begin
      if (BandMenu.Items[Ord(defband)].Enabled = True) and
         (dmZlogGlobal.Settings._activebands[defband] = True) then begin
         Result := defband;
         Exit;
      end;
   end;

   for b := b19 to HiBand do begin
      if (BandMenu.Items[Ord(b)].Visible = True) and
         (dmZlogGlobal.Settings._activebands[b] = True) then begin
         BandMenu.Items[Ord(b)].Enabled := True;
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
   strCap := 'zLog for Windows';

   // SingleOP以外はTX#を表示する
   if dmZLogGlobal.ContestCategory = ccSingleOp then begin
      strTxNo := ' ';
   end
   else begin
      strTxNo := ' [TX#' + IntToStr(dmZLogGlobal.TXNr) + ']';
   end;

   strCap := strCap + strTxNo;

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
   if CurrentFileName <> '' then begin
      strCap := strCap + ' - ' + ExtractFileName(CurrentFileName);
   end;

   Caption := strCap;
end;

procedure TMainForm.QSY(b: TBand; m: TMode; r: Integer);
var
   rig: TRig;
begin
   if r <> 0 then begin
      SwitchRig(r);
   end;

   rig := RigControl.GetRig(FCurrentRigSet, b);
   if CurrentQSO.band <> b then begin
      UpdateBand(b);

      if rig <> nil then begin
         // バンド変更
         rig.SetBand(FCurrentRigSet, CurrentQSO);

         // RIG変更
         FRigControl.SetCurrentRig(rig.RigNumber);

         // Antenna Select
         if (FCurrentRigSet = 1) or (FCurrentRigSet = 2) then begin
            rig.AntSelect(dmZLogGlobal.Settings.FRigSet[FCurrentRigSet].FAnt[b]);
         end;

         // RIG Select
         dmZLogKeyer.SetRxRigFlag(FCurrentRigSet, rig.RigNumber);
      end;
   end;

   // SO2Rではモード変更不要
   if (dmZLogGlobal.Settings._operate_style = os1Radio) or
      ((dmZLogGlobal.Settings._operate_style = os2Radio) and (dmZLogGlobal.Settings._so2r_ignore_mode_change = False)) then begin
      if CurrentQSO.Mode <> m then begin
         UpdateMode(m);
      end;
   end;

   if rig <> nil then begin
      rig.SetMode(CurrentQSO);
   end;
end;

procedure TMainForm.OnPlayMessageA(no: Integer);
var
   cb: Integer;
   rig: TRig;
   mode: TMode;
begin
   cb := dmZlogGlobal.Settings.CW.CurrentBank;
   FOtherKeyPressed[FCurrentRigSet - 1] := True;
   FTabKeyPressed[FCurrentRigSet - 1] := False;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('PlayMessageA(' + IntToStr(cb) + ',' + IntToStr(no) + ')'));
   {$ENDIF}

   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      if dmZLogGlobal.Settings.FAntiZeroinXitOn2 = True then begin
         if rig.Xit = False then begin
            actionAntiZeroin.Execute();
         end;
      end;
   end;

   mode := TextToMode(FEditPanel[FCurrentRx].ModeEdit.Text);
   if mode = mOther then begin
      mode := CurrentQSO.Mode;
   end;

   PlayMessage(mode, cb, no, True);
end;

procedure TMainForm.OnPlayMessageB(no: Integer);
var
   cb: Integer;
   rig: TRig;
begin
   cb := dmZlogGlobal.Settings.CW.CurrentBank;
   FOtherKeyPressed[FCurrentRigSet - 1] := True;
   FTabKeyPressed[FCurrentRigSet - 1] := False;

   if cb = 1 then
      cb := 2
   else
      cb := 1;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('PlayMessageB(' + IntToStr(cb) + ',' + IntToStr(no) + ')'));
   {$ENDIF}

   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      if dmZLogGlobal.Settings.FAntiZeroinXitOn2 = True then begin
         if rig.Xit = False then begin
            actionAntiZeroin.Execute();
         end;
      end;
   end;

   PlayMessage(CurrentQSO.Mode, cb, no, True);
end;

procedure TMainForm.PlayMessage(mode: TMode; bank: Integer; no: Integer; fResetTx: Boolean);
var
   nID: Integer;
   m: TMode;
begin
   WriteStatusLine('', False);

   // 2R:CQ+S&P時、F1/F2/F3以外はSPモード
   if (dmZLogGlobal.Settings._operate_style = os2Radio) and
      (Is2bsiq() = False) then begin
      if no > 3 then begin
         SetCQ(False);
      end;
   end;

   if FInformation.IsWait = False then begin
      FMessageManager.ClearQue();
      nID := FCurrentTx;
      m := TextToMode(FEditPanel[nID].ModeEdit.Text);
      StopMessage(m);
   end;

   case mode of
      mCW: begin
         // CWポート設定チェック
         nID := GetTxRigID();
         if dmZLogKeyer.KeyingPort[nID] = tkpNone then begin
            WriteStatusLineRed(TMainForm_CW_port_is_no_set, False);
            Exit;
         end;
         WriteStatusLine('', False);
         PlayMessageCW(bank, no, fResetTx);
      end;

      mSSB, mFM, mAM: begin
         PlayMessagePH(no, fResetTx);
      end;

      mRTTY: begin
         PlayMessageRTTY(no);
      end;

      else begin
         // NO OPERATION
      end;
   end;
end;

procedure TMainForm.PlayMessageCW(bank: Integer; no: Integer; fResetTx: Boolean);
var
   S: string;
begin
   if no >= 101 then begin
      bank := dmZlogGlobal.Settings.CW.CurrentBank;
      S := dmZLogGlobal.CWMessage(bank, FCurrentCQMessageNo);
   end
   else begin
      S := dmZLogGlobal.CWMessage(bank, no);
   end;

   if S = '' then begin
      Exit;
   end;

//   SetCurrentQSO(FCurrentRigSet - 1);
   SetCurrentQSO(FCurrentTx);

   // リピート停止
   timerCqRepeat.Enabled := False;
   FMessageManager.ClearQue2();

   if no >= 101 then begin
      FMessageManager.AddQue(WM_ZLOG_SETCQ, 1, 0);
   end;

   // Fキー操作ではTXをRXと同じにする
   if (fResetTx = True) then begin
      FMessageManager.AddQue(WM_ZLOG_SWITCH_TX, 1, 0);

      // 2BSIQ=OFF
      if (Is2bsiq() = False) then begin
         // ↓キーを押した方にTXを合わせる
         if FCurrentTx <> FCurrentRx then begin
            FMessageManager.AddQue(WM_ZLOG_SETCQ, 0, 0);
         end;
      end;

      // 2BSIQ=ON
      if (Is2bsiq() = True) then begin
         // RXは反対側へ
         FMessageManager.AddQue(WM_ZLOG_SWITCH_RX, 3, 0);
      end;
   end;

   // 電文送信
   FMessageManager.AddQue(0, S, CurrentQSO);

   // SO2Rモードの場合
   if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
      // 2BSIQ=OFF
      if (Is2bsiq() = False) then begin
         // 送受が異なる場合はpickupなので、TXを戻す
         if FCurrentTx <> FCurrentRx then begin
            FMessageManager.AddQue(WM_ZLOG_RESET_TX, 1, FCurrentTx);
            FMessageManager.AddQue(WM_ZLOG_SETCQ, 1, 0);
         end;
      end;
   end;

   FMessageManager.ContinueQue();
end;

procedure TMainForm.PlayMessagePH(no: Integer; fResetTx: Boolean);
begin
   if no >= 101 then begin
      FMessageManager.AddQue(WM_ZLOG_SETCQ, 1, 0);
   end;

   // リピート停止
   timerCqRepeat.Enabled := False;
   FMessageManager.ClearQue2();

   // Fキー操作ではTXをRXと同じにする
   if (fResetTx = True) then begin
      FMessageManager.AddQue(WM_ZLOG_SWITCH_TX, 1, 0);

      // 2BSIQ=OFF
      if (Is2bsiq() = False) then begin
         // ↓キーを押した方にTXを合わせる
         if FCurrentTx <> FCurrentRx then begin
            FMessageManager.AddQue(WM_ZLOG_SETCQ, 0, 0);
         end;
      end;

      // 2BSIQ=ON
      if (Is2bsiq() = True) then begin
         // RXは反対側へ
         FMessageManager.AddQue(WM_ZLOG_SWITCH_RX, 3, 0);
      end;
   end;

   // 音声再生
   // CWの→ FMessageManager.AddQue(0, S, CurrentQSO); と同等
   case no of
      1, 2, 3, 4, 5, 6,
      7, 8, 9, 10, 11, 12: begin
         FMessageManager.AddQue(0, no);
      end;

      101: begin
         FMessageManager.AddQue(0, FCurrentCQMessageNo);
      end;

      102: begin
         FMessageManager.AddQue(0, 102);
      end;

      103: begin
         FMessageManager.AddQue(0, 103);
      end;
   end;

   // SO2Rモードの場合
   if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
      // 2BSIQ=OFF
      if (Is2bsiq() = False) then begin
         // 送受が異なる場合はpickupなので、TXを戻す
         if FCurrentTx <> FCurrentRx then begin
            FMessageManager.AddQue(WM_ZLOG_RESET_TX, 1, FCurrentTx);
            FMessageManager.AddQue(WM_ZLOG_SETCQ, 1, 0);
         end;
      end;
   end;

   FMessageManager.ContinueQue();
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
   VoiceControl(True);
end;

procedure TMainForm.OnOneCharSentProc(Sender: TObject);
begin
   if Sender = nil then begin
      //FCWMonitor.ClearSendingText();
   end
   else begin
      FCWMonitor.OneCharSentProc();
   end;
end;

procedure TMainForm.OnPlayMessageFinished(Sender: TObject; mode: TMode; fAbort: Boolean);
var
   tx: Integer;
   rx: Integer;
   nSpeedUp: Integer;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- OnPlayMessageFinished ---'));
   {$ENDIF}

   nSpeedUp := 0;
   FMessageManager.ClearText();
   FCWMonitor.ClearSendingText();

   try
      tx := GetTxRigID();
      rx := FCurrentRigSet - 1;

      if mode = mCW then begin
         // PTT-OFF
         ControlPTT(False);

         if dmZLogGlobal.Settings._so2r_type = so2rNeo then begin
            if FSo2rNeoCp.UseRxSelect = True then begin
               dmZLogKeyer.So2rNeoNormalRx(tx);
            end;
      //      FSo2rNeoCp.CanRxSel := False;
            PostMessage(FSo2rNeoCp.Handle, WM_ZLOG_SO2RNEO_CANRXSEL, Integer(False), 0);
         end;
      end
      else begin
         // PTT-OFF
         VoiceControl(False);

         VoiceStopButton.Enabled := False;
      end;

      // 再生中OFF
      FCQRepeatPlaying := False;

      // 規定回数CQかけたら終了
      Inc(FCQLoopCount);
      if FCQLoopCount >= dmZLogGlobal.Settings.CW._cqmax then begin
         CancelCqRepeat();
         FTabKeyPressed[tx] := False;
         FDownKeyPressed[tx] := False;
         FOtherKeyPressed[rx] := False;
         Exit;
      end;

      // Ctrl+Zでのキー入力
      if (FCtrlZCQLoop = True) then begin
//         CancelCqRepeat();
//         FTabKeyPressed[tx] := False;
//         FDownKeyPressed[tx] := False;
//         FOtherKeyPressed[rx] := False;
//         Exit;
      end;

      // 中止
      if fAbort = True then begin
         CancelCqRepeat();
         FTabKeyPressed[tx] := False;
         FDownKeyPressed[tx] := False;
         FOtherKeyPressed[rx] := False;
         Exit;
      end;

      // TABキー押下後
      if FTabKeyPressed[tx] = True then begin
         // SO2R
         if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
            // CQ+SP
            if (Is2bsiq() = False) and (FCQLoopRunning = True) then begin
//               if (CurrentQSO.CQ = False) and (dmZlogGlobal.Settings._switchcqsp = True) then begin
//                  PostMessage(Handle, WM_ZLOG_SPACEBAR_PROC, FKeyPressedRigID[tx], 0);
//               end;
            end;

            // 2BSIQ
            if (Is2bsiq() = True) and (FCQLoopRunning = True) then begin
               nSpeedUp := dmZLogGlobal.Settings._so2r_2bsiq_pluswpm;
            end;
         end;
      end;

      // DOWNキー押下後
      if FDownKeyPressed[tx] = True then begin
         FCQLoopCount := 0;

         // SO2R
         if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
            // 2BSIQ
            if (Is2bsiq() = True) and (FCQLoopRunning = True) then begin
//               FMessageManager.AddQue(WM_ZLOG_SET_LOOP_PAUSE, 0, 0);
            end;
         end;
      end;

      // その他キー
      if FOtherKeyPressed[rx] = True then begin
         if (FCQLoopRunning = True) then begin
//            FMessageManager.AddQue(WM_ZLOG_SET_LOOP_PAUSE, 1, 0);
         end;
         FOtherKeyPressed[rx] := False;
         Exit;
      end;

      // CQリピート再開
      if (FCQLoopRunning = True) then begin
         // TAB or ↓キーは即実行
         if (dmZLogGlobal.Settings._operate_style = os2Radio) and
            (Is2bsiq() = True) then begin
            if ((FTabKeyPressed[tx] = True) or (FDownKeyPressed[tx] = True)) then begin
               FTabKeyPressed[tx] := False;
               FDownKeyPressed[tx] := False;
               FOtherKeyPressed[rx] := False;
               FMessageManager.AddQue(WM_ZLOG_CQREPEAT_CONTINUE, nSpeedUp, 0);
            end
            else begin
               FMessageManager.AddQue(WM_ZLOG_SET_CQ_LOOP, 0, 0);
            end;
         end
         else begin  // タイマー再開
            FTabKeyPressed[tx] := False;
            FDownKeyPressed[tx] := False;
            FOtherKeyPressed[rx] := False;
            FMessageManager.AddQue(WM_ZLOG_SET_CQ_LOOP, 0, 0);
         end;
      end;
   finally
      FMessageManager.ContinueQue();
   end;
end;

procedure TMainForm.OnPaddle(Sender: TObject);
begin
   CQAbort(False);
end;

// バンドスコープへ追加
procedure TMainForm.InsertBandScope(fShiftKey: Boolean);
var
   nFreq: TFrequency;
   rig: TRig;

   function InputFreq(): Boolean;
   var
      E: Extended;
      F: TIntegerDialog;
   begin
      F := TIntegerDialog.Create(Self);
      try
         F.SetLabel(TMainForm_Enter_Frequency);

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
   SetCurrentQSO(FCurrentRigSet - 1);

   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      nFreq := rig.CurrentFreqHz;
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
   FormShowAndRestore(FSuperCheck);
   CheckSuper(CurrentQSO);

   LastFocus.SetFocus;
end;

// #09 Z-Link Monitor Ctrl+F12
procedure TMainForm.actionShowZlinkMonitorExecute(Sender: TObject);
begin
   FormShowAndRestore(FZLinkForm);
end;

// #10-#17 F1～F8
// #20-#21 F11, F12
procedure TMainForm.actionPlayMessageAExecute(Sender: TObject);
var
   no: Integer;
//   cb: Integer;
//   rig: TRig;
begin
   no := TAction(Sender).Tag;
   OnPlayMessageA(no);
//   cb := dmZlogGlobal.Settings.CW.CurrentBank;
//   FOtherKeyPressed[FCurrentRigSet - 1] := True;
//
//   {$IFDEF DEBUG}
//   OutputDebugString(PChar('PlayMessageA(' + IntToStr(cb) + ',' + IntToStr(no) + ')'));
//   {$ENDIF}
//
//   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
//   if rig <> nil then begin
//      if dmZLogGlobal.Settings.FAntiZeroinXitOn2 = True then begin
//         if rig.Xit = False then begin
//            actionAntiZeroin.Execute();
//         end;
//      end;
//   end;
//
//   PlayMessage(cb, no, True);
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
   FormShowAndRestore(FPartialCheck);

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
//   cb: Integer;
//   rig: TRig;
begin
   no := TAction(Sender).Tag;
   OnPlayMessageB(no);
//   cb := dmZlogGlobal.Settings.CW.CurrentBank;
//   FOtherKeyPressed[FCurrentRigSet - 1] := True;
//
//   if cb = 1 then
//      cb := 2
//   else
//      cb := 1;
//
//   {$IFDEF DEBUG}
//   OutputDebugString(PChar('PlayMessageB(' + IntToStr(cb) + ',' + IntToStr(no) + ')'));
//   {$ENDIF}
//
//   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
//   if rig <> nil then begin
//      if dmZLogGlobal.Settings.FAntiZeroinXitOn2 = True then begin
//         if rig.Xit = False then begin
//            actionAntiZeroin.Execute();
//         end;
//      end;
//   end;
//
//   PlayMessage(cb, no, True);
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
   if Assigned(MemoEdit) then MemoEdit.Clear;
   CallsignEdit.SetFocus;
   WriteStatusLine('', False);
end;

// #49 同じバンドのみ表示
procedure TMainForm.actionShowCurrentBandOnlyExecute(Sender: TObject);
begin
   menuShowCurrentBandOnly.Checked := not menuShowCurrentBandOnly.Checked;
   menuShowThisTxOnly.Checked := False;
   menuShowOnlySpecifiedTX.Checked := False;
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

   if CurrentQSO.Callsign = '' then begin
      if Log.TotalQSO >= 2 then begin
         TWAEContest(MyContest).QTCForm.Show;
         TWAEContest(MyContest).QTCForm.OpenQTC(Log.QsoList[Log.TotalQSO]);
      end
      else begin
         MessageBox(Handle, PChar(TMainForm_No_QTC_Message), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      end;
   end
   else begin
      TWAEContest(MyContest).QTCForm.Show;
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
      FCtrlZCQLoop := True;
      nID := GetTxRigID();
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
   if FCQRepeatPlaying = True then begin
      Exit;
   end;

   if FInformation.Is2bsiq = True then begin
      F2bsiqStart := True;
   end;

   FCtrlZCQLoop := True;
   SetCqRepeatMode(True, True);
end;

// #58 Backup / Alt+B
procedure TMainForm.actionBackupExecute(Sender: TObject);
var
   P: string;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('---actionBackupExecute---'));
   {$ENDIF}

   P := dmZlogGlobal.BackupPath;
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
   FormShowAndRestore(FCWKeyBoard);
end;

// #61 Memo欄にフォーカス移動 / Alt+M
procedure TMainForm.actionFocusMemoExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('---actionFocusMemoExecute---'));
   {$ENDIF}
   if Assigned(MemoEdit) then MemoEdit.SetFocus;
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
   OpEdit1Click(OpEdit);
end;

// #64 Packet Cluster / Alt+P
procedure TMainForm.actionShowPacketClusterExecute(Sender: TObject);
begin
   FormShowAndRestore(FCommForm);
   LastFocus.SetFocus();
end;

// #65 Console Pad / Alt+Q
procedure TMainForm.actionShowConsolePadExecute(Sender: TObject);
begin
   FormShowAndRestore(FConsolePad);
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
   FormShowAndRestore(FScratchSheet);
end;

// #68 RIG Control / Alt+T
procedure TMainForm.actionShowRigControlExecute(Sender: TObject);
begin
   FormShowAndRestore(FRigControl);
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
   if Assigned(MemoEdit) then MemoEdit.Clear();
   WriteStatusLine('', False);
   CallsignEdit.SetFocus;
end;

// #70 Z-Serverのチャットウインドウ / Alt+Z
procedure TMainForm.actionShowZServerChatExecute(Sender: TObject);
begin
   FormShowAndRestore(FChatForm);
end;

// #71 TX/RX RIG切り替え / Alt+. , Shift+X
procedure TMainForm.actionToggleRigExecute(Sender: TObject);
var
   rig: Integer;
   nID: Integer;
   mode: TMode;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- #71 Toggle RIG ---'));
   {$ENDIF}

   // CQ Repeat 中止
   SetCqRepeatMode(False, False);

   nID := FCurrentTx;
   mode := TextToMode(FEditPanel[nID].ModeEdit.Text);
   StopMessage(mode);

   // メモリースキャン中なら中止する
   RigControl.MemScanOff();

   // F2Aモード解除(暫定) 2Radio対応時は削除
   F2AOff();

   // 1Rの場合
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin
      rig := FCurrentRigSet;
//      rig := RigControl.GetCurrentRig();
      rig := GetNextRigID(rig - 1) + 1;
      SwitchRig(rig);
   end
   else begin
      // 2Rの場合
      if FCurrentTX = FCurrentRX then begin
         rig := FCurrentRigSet;
         rig := GetNextRigID(rig - 1) + 1;
         SwitchRig(rig);
         FCQLoopStartRig := rig;
      end
      else begin
         // RXにTXを合わせる
         SwitchTx(FCurrentRx + 1);
      end;
   end;

   UpdateCurrentQSO();
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

   if dmZLogGlobal.Settings._usebandscope_newmulti = True then begin
      FBandScopeNewMulti.Show();
   end
   else begin
      FBandScopeNewMulti.Hide();
   end;

   if dmZLogGlobal.Settings._usebandscope_allbands = True then begin
      FBandScopeAllBands.Show();
   end
   else begin
      FBandScopeAllBands.Hide();
   end;
end;

// #73 Running Frequencies
procedure TMainForm.actionShowFreqListExecute(Sender: TObject);
begin
   FormShowAndRestore(FFreqList);
end;

// #74 Teletype Console
procedure TMainForm.actionShowTeletypeConsoleExecute(Sender: TObject);
begin
   if Assigned(FTTYConsole) then begin
      FormShowAndRestore(FTTYConsole);
   end;
end;

// #75 analyzeウインドウ
procedure TMainForm.actionShowAnalyzeExecute(Sender: TObject);
begin
   FormShowAndRestore(FZAnalyze);
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
   FormShowAndRestore(FRateDialog);
end;

// #79 Check Callウインドウ
procedure TMainForm.actionShowCheckCallExecute(Sender: TObject);
begin
   FormShowAndRestore(FCheckCall2);
   LastFocus.SetFocus();
end;

// #80 Check Multiウインドウ
procedure TMainForm.actionShowCheckMultiExecute(Sender: TObject);
begin
   FormShowAndRestore(FCheckMulti);
   LastFocus.SetFocus();
end;

// #81 Check Countryウインドウ
procedure TMainForm.actionShowCheckCountryExecute(Sender: TObject);
begin
   FormShowAndRestore(FCheckCountry);
   LastFocus.SetFocus();
end;

// #82 交信開始 / TAB
// 相手のコールサインとナンバーを送信し(F2)ナンバーフィールドに移動、ただしデュープならばQSO B4を送信(F4)
procedure TMainForm.actionQsoStartExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- BEGIN - actionQsoStartExecute---'));
   {$ENDIF}

   OnTabPress;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- END - actionQsoStartExecute---'));
   {$ENDIF}
end;

// #83 交信完了 / ↓
// TUと自局のコールサインを送信し(F3)QSOを確定、ただしナンバーが有効でない場合はNR?を送信(F5)
procedure TMainForm.actionQsoCompleteExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- BEGIN - actionQsoCompleteExecute---'));
   {$ENDIF}

   OnDownKeyPress;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- END - actionQsoCompleteExecute---'));
   {$ENDIF}
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
begin
   OnNonconvertKeyProc();
end;

// #87 N+1ウインドウの表示
procedure TMainForm.actionShowSuperCheck2Execute(Sender: TObject);
begin
   FormShowAndRestore(FSuperCheck2);
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

// #089, #157 バンド変更 Shift+B
procedure TMainForm.actionChangeBandExecute(Sender: TObject);
var
   rig: TRig;
   b: TBand;
begin
   if TAction(Sender).Tag = 0 then begin
      b := GetNextBand(CurrentQSO.Band, True);
   end
   else begin
      b := GetNextBand(CurrentQSO.Band, False);
   end;
   UpdateBand(b);

   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      rig.SetBand(FCurrentRigSet, CurrentQSO);

      if CurrentQSO.Mode = mSSB then begin
         rig.SetMode(CurrentQSO);
      end;

      // Antenna Select
      if (FCurrentRigSet = 1) or (FCurrentRigSet = 2) then begin
         rig.AntSelect(dmZLogGlobal.Settings.FRigSet[FCurrentRigSet].FAnt[CurrentQSO.Band]);
      end;

      RigControl.SetCurrentRig(rig.RigNumber);
      dmZLogKeyer.SetTxRigFlag(FCurrentRigSet);
   end;
end;

// #090, #158 モード変更 Shift+M
procedure TMainForm.actionChangeModeExecute(Sender: TObject);
var
   rig: TRig;
begin
   if TAction(Sender).Tag = 0 then begin
      SetQSOMode(CurrentQSO, True);
   end
   else begin
      SetQSOMode(CurrentQSO, False);
   end;
   UpdateMode(CurrentQSO.Mode);

   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      rig.SetMode(CurrentQSO);
   end;
end;

// #091, #159 パワー変更 Shift+P
procedure TMainForm.actionChangePowerExecute(Sender: TObject);
begin
   if TAction(Sender).Tag = 0 then begin
      if CurrentQSO.Power = pwrH then begin
         CurrentQSO.Power := pwrP;
      end
      else begin
         CurrentQSO.Power := TPower(Integer(CurrentQSO.Power) + 1);
      end;
   end
   else begin
      if CurrentQSO.Power = pwrP then begin
         CurrentQSO.Power := pwrH;
      end
      else begin
         CurrentQSO.Power := TPower(Integer(CurrentQSO.Power) - 1);
      end;
   end;

   if Assigned(PowerEdit) then begin
      PowerEdit.Text := CurrentQSO.NewPowerStr;
   end;

   ShowSentNumber();
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
   if FCQRepeatPlaying = True then begin
      Exit;
   end;

   if FInformation.Is2bsiq = True then begin
      F2bsiqStart := True;
   end;

   FCtrlZCQLoop := False;
   SetCqRepeatMode(True, True);
end;

// #99 VFOのトグル
procedure TMainForm.actionToggleVFOExecute(Sender: TObject);
var
   rig: TRig;
begin
   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      rig.ToggleVFO;
   end;
end;

// #100 最後の交信のエディット
procedure TMainForm.actionEditLastQSOExecute(Sender: TObject);
begin
   Grid.Row := Log.QsoList.Count - 1;

   LastFocus := TEdit(ActiveControl);
   Grid.SetFocus;

   EditCurrentRow;
end;

// #103 CW Message Pad
procedure TMainForm.actionCwMessagePadExecute(Sender: TObject);
begin
   FormShowAndRestore(FCWMessagePad);
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
var
   rig: TRig;
   b: TBand;
   rigset: Integer;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('---actionSetLastFreqExecute---'));
   {$ENDIF}

   rigset := FCurrentRigSet;

   // last freq.が無ければ何もしない
   if FLastFreq[rigset] = 0 then begin
      Exit;
   end;

   // last freqのバンドを求める
   b := dmZLogGlobal.BandPlan.FreqToBand(FLastFreq[rigset]);

   // last freqに適したリグを探す
   rig := RigControl.GetRig(FCurrentRigSet, b);
   if rig <> nil then begin
      FRigControl.SetCurrentRig(rig.RigNumber);

      rig.MoveToLastFreq(FLastFreq[rigset], FLastMode[rigset]);

      while RigControl.PrevVFO[0] <> FLastFreq[rigset] do begin
         Application.ProcessMessages();
      end;
   end;

   Restore2bsiqMode();

   SetCQ(True);

   // ALT+W
   actoinClearCallAndNumAftFocus.Execute();
end;

// #101,#102,#106,#107,#108 QuickMemo3-5
procedure TMainForm.actionQuickMemo3Execute(Sender: TObject);
var
   strQuickMemoText: string;
   strTemp: string;
   n: Integer;
begin
   if not Assigned(MemoEdit) then begin
      Exit;
   end;

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
   CQAbort(True);
end;

// #120 CQモード、SPモードのトグル
procedure TMainForm.actionToggleCqSpExecute(Sender: TObject);
begin
   SetCQ(Not IsCQ());
end;

// #121 CQ間隔UP
procedure TMainForm.actionCQRepeatIntervalUpExecute(Sender: TObject);
begin
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin
      dmZLogGlobal.Settings.CW._cqrepeat := dmZLogGlobal.Settings.CW._cqrepeat + 1.0;
   end
   else begin
      dmZLogGlobal.Settings._so2r_cq_rpt_interval_sec := dmZLogGlobal.Settings._so2r_cq_rpt_interval_sec + 1.0;
   end;
   ApplyCQRepeatInterval();
end;

// #122 CQ間隔DOWN
procedure TMainForm.actionCQRepeatIntervalDownExecute(Sender: TObject);
begin
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin
      dmZLogGlobal.Settings.CW._cqrepeat := dmZLogGlobal.Settings.CW._cqrepeat - 1.0;
   end
   else begin
      dmZLogGlobal.Settings._so2r_cq_rpt_interval_sec := dmZLogGlobal.Settings._so2r_cq_rpt_interval_sec - 1.0;
   end;
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
var
   rig: TRig;
begin
   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if rig = nil then begin
      Exit;
   end;

   rig.Rit := not rig.Rit;
   ShowToggleStatus('RIT', rig.Rit);
end;

// #127 Toggle XIT
procedure TMainForm.actionToggleXitExecute(Sender: TObject);
var
   rig: TRig;
begin
   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if rig = nil then begin
      Exit;
   end;

   rig.Xit := not rig.Xit;
   ShowToggleStatus('XIT', rig.Xit);
end;

// #128 RIT Clear
procedure TMainForm.actionRitClearExecute(Sender: TObject);
var
   rig: TRig;
begin
   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      rig.RitClear();
   end;

   WriteStatusLine(TMainForm_RIT_XIT_Cleared, False);
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
   rig: TRig;
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

   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if rig = nil then begin
      Exit;
   end;
   if rig.XitCtrlSupported = False then begin
      Exit;
   end;

   Randomize();

   // 振れ幅
   randmax := (Max(dmZLogGlobal.Settings.FAntiZeroinShiftMax, 10) div 10) + 1;

   // 振れ幅0は除く
   repeat
      offset := Random(randmax) * 10;    // 200Hz未満で
   until offset <> 0;

   // ＋か－か
   if Random(2) = 1 then begin
      offset := offset * -1;
   end;

   rig.Rit := False;
   rig.Xit := True;
   rig.RitOffset := offset;

   WriteStatusLine(TMainForm_Anti_zeroin, False);
end;

// #131 Function Key Panel
procedure TMainForm.actionFunctionKeyPanelExecute(Sender: TObject);
begin
   FormShowAndRestore(FFunctionKeyPanel);
   LastFocus.SetFocus();
end;

// #132 Rate Dialog Ex
procedure TMainForm.actionShowQsoRateExExecute(Sender: TObject);
begin
   FormShowAndRestore(FRateDialogEx);
end;

// #133 QSY Infomation
procedure TMainForm.actionShowQsyInfoExecute(Sender: TObject);
begin
   FormShowAndRestore(FQsyInfoForm);
end;

// #134 SO2R Neo Control Panel
procedure TMainForm.actionShowSo2rNeoCpExecute(Sender: TObject);
begin
   FormShowAndRestore(FSo2rNeoCp);
end;

// #135-137 SO2R Neo Select RX N
procedure TMainForm.actionSo2rNeoSelRxExecute(Sender: TObject);
var
   tx: Integer;
   rx: Integer;
begin
   rx := TAction(Sender).Tag;
   tx := FCurrentTx;
   dmZLogKeyer.So2rNeoSwitchRig(tx, rx);
end;

// #138-140 Select Rig N
procedure TMainForm.actionSelectRigExecute(Sender: TObject);
var
   rig: Integer;
begin
   rig := TAction(Sender).Tag;
   SwitchRig(rig);
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
   FormShowAndRestore(FInformation);
end;

// #143 SO2R Toggle 2BSIQ
procedure TMainForm.actionToggleSo2r2bsiqExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- #143 SO2R Toggle 2BSIQ ---'));
   {$ENDIF}
   FInformation.Is2bsiq := not FInformation.Is2bsiq;
end;

// #144 SO2R Neo Toggle Auto RX select
procedure TMainForm.actionSo2rNeoToggleAutoRxSelectExecute(Sender: TObject);
begin
   FSo2rNeoCp.ToggleRxSelect();
end;

// #145 SO2R Toggle TX
procedure TMainForm.actionToggleTxExecute(Sender: TObject);
var
   tx: Integer;
   rig: TRig;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- #145 ToggleTx ---'));
   {$ENDIF}
   SetCqRepeatMode(False, False);
   FCQLoopCount := 999;
   dmZLogKeyer.ClrBuffer();

   // メモリースキャン中なら中止する
   RigControl.MemScanOff();

   // F2Aモード解除(暫定) 2Radio対応時は削除
   F2AOff();

   tx := GetNextRigID(FCurrentTx);

   FCurrentTx := tx;
   FInformation.Tx := tx;

   rig := RigControl.GetRig(tx + 1, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      dmZLogKeyer.SetTxRigFlag(tx + 1);
   end;

   UpdateMode(TextToMode(FEditPanel[FCurrentTx].ModeEdit.Text));

   ShowTxIndicator();
end;

// #146 SO2R Toggle Wait Message
procedure TMainForm.actionToggleSo2rWaitExecute(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- #146 SO2R Toggle Wait Message ---'));
   {$ENDIF}
   FInformation.IsWait := not FInformation.IsWait;
end;

// #147 SO2R Toggle RX
procedure TMainForm.actionToggleRxExecute(Sender: TObject);
var
   rx: Integer;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- #147 ToggleRx ---'));
   {$ENDIF}

   // メモリースキャン中なら中止する
   RigControl.MemScanOff();

   // F2Aモード解除(暫定) 2Radio対応時は削除
   F2AOff();

   rx := GetNextRigID(FCurrentRx);
   SwitchRx(rx + 1);
end;

// #148 SO2R Match RX to TX
procedure TMainForm.actionMatchRxToTxExecute(Sender: TObject);
var
   tx: Integer;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- #148 Match RX to TX ---'));
   {$ENDIF}

   // メモリースキャン中なら中止する
   RigControl.MemScanOff();

   // F2Aモード解除(暫定) 2Radio対応時は削除
   F2AOff();

   tx := FCurrentTx;
   SwitchRx(tx + 1);
end;

// #149 SO2R Match TX to RX
procedure TMainForm.actionMatchTxToRxExecute(Sender: TObject);
var
   rx: Integer;
begin
   // CQ Repeat 中止
   SetCqRepeatMode(False, False);

   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- #149 Match TX to RX ---'));
   {$ENDIF}

   // メモリースキャン中なら中止する
   RigControl.MemScanOff();

   // F2Aモード解除(暫定) 2Radio対応時は削除
   F2AOff();

   rx := FCurrentRx;
   SwitchTx(rx + 1);
end;

// #150 SO2R Toggle Rig Pair
procedure TMainForm.actionSo2rToggleRigPairExecute(Sender: TObject);
const
  rig1: array[0..3] of Boolean = ( False, True, False, True );
  rig2: array[0..3] of Boolean = ( False, False, True, True );
var
   n: Integer;

   function FindIndex(): Integer;
   var
      i: Integer;
   begin
      for i := 0 to 3 do begin
         if (rig1[i] = checkWithRig1.Checked) and (rig2[i] = checkWithRig2.Checked) then begin
            Result := i;
            Exit;
         end;
      end;
      Result := 0;
   end;
begin
   n := FindIndex();

   Inc(n);
   if n > 3 then begin
      n := 1;
   end;

   checkWithRig1.Checked := rig1[n];
   checkWithRig2.Checked := rig2[n];
end;

// #151-#153 Change TX NR
procedure TMainForm.actionChangeTxNrExecute(Sender: TObject);
var
   txnr: Integer;
begin
   txnr := TAction(Sender).Tag;
   ChangeTxNr(txnr);
end;

// #154 Pse QSL
procedure TMainForm.actionPseQslExecute(Sender: TObject);
begin
   CurrentQSO.QslState := qsPseQsl;
   WriteStatusLine(MEMO_PSE_QSL, False);
end;

// #155 No QSL
procedure TMainForm.actionNoQslExecute(Sender: TObject);
begin
   CurrentQSO.QslState := qsNoQsl;
   WriteStatusLine(MEMO_NO_QSL, False);
end;

// #156 Show MessageManager
procedure TMainForm.actionShowMsgMgrExecute(Sender: TObject);
begin
   FormShowAndRestore(FMessageManager);
end;

// #160 Toggle TxNr
procedure TMainForm.actionToggleTxNrExecute(Sender: TObject);
var
   txnr: Integer;
begin
   txnr := dmZlogGlobal.TXNr;
   Inc(txnr);
   if txnr > 1 then begin
      txnr := 0;
   end;
   ChangeTxNr(txnr);
end;

// #161 Show CW Monitor
procedure TMainForm.actionShowCWMonitorExecute(Sender: TObject);
begin
   FCWMonitor.Show();
end;

// #162 Show current TX only
procedure TMainForm.actionShowCurrentTxOnlyExecute(Sender: TObject);
begin
   menuShowCurrentBandOnly.Checked := False;
   menuShowThisTxOnly.Checked := not menuShowThisTxOnly.Checked;
   menuShowOnlySpecifiedTX.Checked := False;
   GridRefreshScreen();
end;

// #163 QSO Complete (logging only)
procedure TMainForm.actionLoggingExecute(Sender: TObject);
begin
   if (CurrentQSO.Callsign <> '') and (CurrentQSO.NrRcvd <> '') then begin
      LogButtonProc(FCurrentRx, CurrentQSO);
   end;
end;

// #164 Send WPM command to RIG
procedure TMainForm.actionSetRigWPMExecute(Sender: TObject);
var
   wpm: Integer;
begin
   wpm := dmZLogKeyer.WPM;
   SetRigWpm(wpm);
end;

// #165 Toggle Memory-Scan
procedure TMainForm.actionToggleMemScanExecute(Sender: TObject);
var
   scanrigset: Integer;
   b: TBand;
begin
   case FCurrentRigSet of
      1: scanrigset := 2;
      2: scanrigset := 1;
      else Exit;
   end;

   b := TextToBand(FEditPanel[scanrigset - 1].BandEdit.Text);

   RigControl.ToggleMemScan(scanrigset, b);
end;

// #166 Toggle F2A
procedure TMainForm.actionToggleF2AExecute(Sender: TObject);
begin
   buttonF2A.Down := not buttonF2A.Down;
   buttonF2AClick(buttonF2A);
end;

procedure TMainForm.RestoreWindowsPos();
var
   X, Y, W, H: Integer;
   B, BB: Boolean;
   mon: TMonitor;
   pt: TPoint;
   ini: TMemIniFile;
begin
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      dmZlogGlobal.ReadMainFormState(ini, X, Y, W, H, B, BB);

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
         end;
         if BB then begin
            mnHideMenuToolbar.Checked := True;
         end;
         ShowToolBar(mOther);

         Position := poDesigned;
         Left := X;
         top := Y;
         Width := W;
         Height := H;
      end
      else begin
         Position := poScreenCenter;
      end;
   finally
      ini.Free();
   end;
end;

procedure TMainForm.WriteKeymap();
var
   i: Integer;
   ini: TMemIniFile;
begin
   ini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + 'zlog_key.ini');
   try
      for i := 0 to ActionList1.ActionCount - 1 do begin
         ini.WriteString('shortcut', IntToStr(i), ShortcutToText(ActionList1.Actions[i].ShortCut));
         ini.WriteString('secondary', IntToStr(i), ActionList1.Actions[i].SecondaryShortCuts.CommaText);
      end;

      ini.UpdateFile();
   finally
      ini.Free();
   end;
end;

procedure TMainForm.ReadKeymap();
var
   i: Integer;
   ini: TMemIniFile;
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

   ini := TMemIniFile.Create(filename);
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
   FSuperCheck.DataLoad();
   FSuperCheck2.DataLoad();

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
   FSuperCheckList.AcceptDuplicates := dmZLogGlobal.Settings.FSuperCheck.FAcceptDuplicates;

   for i := 0 to 255 do begin // 2.1f
      for j := 0 to 255 do begin
         FTwoLetterMatrix[i, j] := TSuperList.Create(True);
         FTwoLetterMatrix[i, j].AcceptDuplicates := dmZLogGlobal.Settings.FSuperCheck.FAcceptDuplicates;
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
   PartialStrOrg: string;
   i: integer;
   maxhit, hit: integer;
   sd, FirstData: TSuperData;
   L: TSuperList;
   SI: TSuperIndex;
   j: Integer;
   {$IFDEF DEBUG}
   dwTick: DWORD;
   loop_count: Integer;
   {$ENDIF}
label
   loop_end;
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
   PartialStrOrg := PartialStr;
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
   dwTick := GetTickCount();
   loop_count := 0;
   {$ENDIF}
   FSuperCheck.BeginUpdate();
   for i := 0 to L.Count - 1 do begin
      SI := L[i];

      for j := 0 to SI.List.Count - 1 do begin
         sd := SI.List[j];

         if FSuperCheck.Count = 0 then begin
            FirstData := sd;
         end;

         if sd.Callsign = PartialStrOrg then begin
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
            goto loop_end;
         end;

         {$IFDEF DEBUG}
         Inc(loop_count);
         {$ENDIF}
      end;
   end;
loop_end:
   FSuperCheck.EndUpdate();

   FSpcHitNumber := hit;

   FSpcFirstDataCall := '';
   FSpcRcvd_Estimate := '';

   if FSpcHitNumber > 0 then begin
      FSpcFirstDataCall := FirstData.callsign;
      FSpcRcvd_Estimate := FirstData.number;
   end;

   FSuperChecked := True;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('SuperCheck Finished [' + IntToStr(GetTickCount() - dwTick) + '] milisec loop_count=' +IntTostr(loop_count)));
   {$ENDIF}
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
//   PartialStr := CoreCall(PartialStr);

   // 検索対象無し
   if PartialStr = '' then begin
      Exit;
   end;

   // N+1の実行
   if (Length(PartialStr) >= 3) then begin
      FNPlusOneThread := TSuperCheckNPlusOneThread.Create(FSuperCheckList, FSuperCheck2, PartialStr);
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
   t: TBandScopeNotifyThread;
begin
   if dmZLogGlobal.Settings._renewbythread = True then begin
      t := TBandScopeNotifyThread.Create(Self, aQSO);
      t.Start();
   end
   else begin
      for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
         FBandScopeEx[b].NotifyWorked(aQSO);
      end;
      FBandScope.NotifyWorked(aQSO);
      FBandScopeNewMulti.NotifyWorked(aQSO);
      FBandScopeAllBands.NotifyWorked(aQSO);
   end;
end;

procedure TMainForm.SetYourCallsign(strCallsign, strNumber: string);
var
   nID: Integer;
   C, N, B, M, SE, OP: TEdit;
begin
   nID := FCurrentRx;

   AssignControls(nID, C, N, B, M, SE, OP);

   CurrentQSO.CallSign := strCallsign;

   C.Text := strCallsign;
   C.SelStart := Length(C.Text);
   N.Text := '';

   if strCallsign = '' then begin
      C.SetFocus();
      Exit;
   end;

//   MyContest.SpaceBarProc;

   if N.Text = '' then begin
      if strNumber <> '' then begin
         N.Text := strNumber;
         N.SelStart := Length(N.Text);
      end
      else begin
         CallSpaceBarProc(C, N, B);
      end;
   end;

   MyContest.MultiForm.SetNumberEditFocus;
end;

// Cluster or BandScopeから呼ばれる
procedure TMainForm.SetFrequency(freq: TFrequency);
var
   b: TBand;
   Q: TQSO;
   m: TMode;
   rig: TRig;
   rigset: Integer;
   nID: Integer;
   mode: TMode;
begin
   if freq = 0 then begin
      Exit;
   end;

   // 1Radioの場合
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin
      // CQモードなら現在の周波数とモードを記憶
      if (IsCQ() = True) and (dmZLogGlobal.Settings._bandscope_save_current_freq = True)then begin
         SaveLastFreq();
      end;
   end;

   // 2Radioの場合、現在の2BSIQ状態を保存してOFFにする
   if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
      FPrev2bsiqMode := FInformation.Is2bsiq;
      if (Is2bsiq() = True) then begin
         FInformation.Is2bsiq := False;
         F2bsiqStart := False;
         FCQRepeatPlaying := False;
      end;
   end;

   // CQ中止
   if FCurrentTx = FCurrentRx then begin
      CQAbort(False);
   end;

   // SPモードへ変更
   SetCQ(False);

   FQsyFromBS := True;

   rigset := CurrentRx + 1;

   b := dmZLogGlobal.BandPlan.FreqToBand(freq);

   rig := RigControl.GetRig(rigset, b);
   if rig <> nil then begin
      // RIGにfreq設定
      rig.SetFreq(freq, False);

      FRigControl.SetCurrentRig(rig.RigNumber);

      if dmZLogGlobal.Settings._bandscope_use_estimated_mode = True then begin
         Q := TQSO.Create();
         Q.Band := b;

         // 周波数より推定モード取得
         Q.Mode := dmZLogGlobal.BandPlan.GetEstimatedMode(freq);

         // 現在のモードと異なる or 常にモードセットなら
         m := TextToMode(FEditPanel[rigset - 1].ModeEdit.Text);
         if (m <> Q.Mode) or (dmZLogGlobal.Settings._bandscope_always_change_mode = True) then begin
            // 推定モードセット
	        rig.SetMode(Q);

            // もう一度周波数を設定(side bandずれ対策)
            if dmZLogGlobal.Settings._bandscope_setfreq_after_mode_change = True then begin
               rig.SetFreq(freq, False);
            end;
         end;

         Q.Free();
      end;

      // Antenna Select
      if (rigset = 1) or (rigset = 2) then begin
         rig.AntSelect(dmZLogGlobal.Settings.FRigSet[rigset].FAnt[b]);
      end;

      rig.UpdateStatus();

      // Zeroin避け
      if dmZLogGlobal.Settings.FAntiZeroinXitOn1 = True then begin
         actionAntiZeroin.Execute();
      end;

      // RIG切替信号
//      dmZLogKeyer.SetTxRigFlag(FCurrentRigSet);
      dmZLogKeyer.SetRxRigFlag(rigset, rig.RigNumber);
   end
   else begin
      // バンド変更
      UpdateBand(b);
   end;

   // CQをかける

   // 送信側RIGのモードを判定
   nID := FCurrentTx;

   // TX側のモードを取得する
   mode := TextToMode(FEditPanel[nID].ModeEdit.Text);

   // 送信していなければCQをかける
   if (mode = mCW) and (dmZLogKeyer.IsPlaying = False) and
      (Is2bsiq() = True) then begin
      if FCurrentTx <> FCurrentRx then begin
         actionCQRepeat.Execute();
      end;
   end;
end;

procedure TMainForm.Restore2bsiqMode();
begin
   if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
      FInformation.Is2bsiq := FPrev2bsiqMode;
      if FPrev2bsiqMode = True then begin
         F2bsiqStart := True;

         // 送受の入れ替えは送信していないとき
         if dmZLogKeyer.IsPlaying() = False then begin
            actionToggleRx.Execute();
            InvertTx();
         end;

         // CQ再開
         timerCqRepeat.Enabled := dmZLogGlobal.Settings._so2r_cqrestart;
      end;
      FCQRepeatPlaying := False;
   end;
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
   FBandScopeNewMulti.RewriteBandScope();
   FBandScopeAllBands.RewriteBandScope();
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

procedure TMainForm.BandScopeAddSelfSpot(aQSO: TQSO; nFreq: TFrequency);
var
   b: TBand;
begin
   b := dmZLogGlobal.BandPlan.FreqToBand(nFreq);
   FBandScopeEx[b].AddSelfSpot(aQSO.Callsign, aQSO.NrRcvd, b, aQSO.Mode, nFreq);
   FBandScope.AddSelfSpot(aQSO.Callsign, aQSO.NrRcvd, b, aQSO.Mode, nFreq);

   // コンテストが必要とするバンドかつ自分がQRVできるバンドのスポットのみ
   if (BandMenu.Items[Ord(b)].Enabled = True) and
      (dmZlogGlobal.Settings._activebands[b] = True) then begin
      FBandScopeAllBands.AddSelfSpot(aQSO.Callsign, aQSO.NrRcvd, b, aQSO.Mode, nFreq);
   end;
end;

procedure TMainForm.BandScopeAddSelfSpotFromNetwork(BSText: string);
var
   b: TBand;
begin
   for b := b19 to b50 do begin
      FBandScopeEx[b].AddSelfSpotFromNetwork(BSText);
   end;
   FBandScope.AddSelfSpotFromNetwork(BSText);
   FBandScopeAllBands.AddSelfSpotFromNetwork(BSText);
end;

procedure TMainForm.BandScopeAddClusterSpot(Sp: TSpot);
begin
   FBandScopeEx[Sp.Band].AddClusterSpot(Sp);
   FBandScope.AddClusterSpot(Sp);

   if Sp.IsNewMulti = True then begin
      FBandScopeNewMulti.AddClusterSpot(Sp);
   end;

   // コンテストが必要とするバンドかつ自分がQRVできるバンドのスポットのみ
   if (BandMenu.Items[Ord(Sp.Band)].Enabled = True) and
      (dmZlogGlobal.Settings._activebands[Sp.Band] = True) then begin
      FBandScopeAllBands.AddClusterSpot(Sp);
   end;
end;

procedure TMainForm.BandScopeMarkCurrentFreq(B: TBand; Hz: TFrequency);
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

   FBandScopeNewMulti.SetSpotWorked(aQSO);
   FBandScopeAllBands.SetSpotWorked(aQSO);
end;

procedure TMainForm.BandScopeApplyBandPlan();
var
   b: TBand;
begin
   for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
      FBandScopeEx[b].JudgeEstimatedMode();
   end;
   FBandScope.JudgeEstimatedMode();
   FBandScopeNewMulti.JudgeEstimatedMode();
   FBandScopeAllBands.JudgeEstimatedMode();
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
   wpm: Integer;
begin
   wpm := dmZLogKeyer.WPM;
   dmZLogGlobal.Settings.CW._speed := wpm;
   SpeedBar.Position := wpm;
   SpeedLabel.Caption := IntToStr(wpm) + ' wpm';
   FInformation.WPM := wpm;
   SetRigWpm(wpm);
end;

procedure TMainForm.DoVFOChange(Sender: TObject);
var
   rig: TRig;
begin
   if FInitialized = False then begin
      Exit;
   end;

   // AntiZeroin利用時
   if (dmZLogGlobal.Settings.FUseAntiZeroin = True) and (FQsyFromBS = False) then begin
      // XIT OFF
      rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
      if rig <> nil then begin
         rig.Xit := False;
      end;
   end;

   if FCurrentTX = FCurrentRx then begin
      SetCQ(False);
   end;

   FQsyFromBS := False;
end;

procedure TMainForm.ApplyCQRepeatInterval();
var
   msg: string;
   interval: double;
begin
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin
      interval := Max(Min(dmZLogGlobal.Settings.CW._cqrepeat, 60), 0);
      dmZLogGlobal.Settings.CW._cqrepeat := interval;
   end
   else begin
      interval := Max(Min(dmZLogGlobal.Settings._so2r_cq_rpt_interval_sec, 60), 0);
      dmZLogGlobal.Settings._so2r_cq_rpt_interval_sec := interval;
   end;

   msg := Format(TMainForm_Set_CQ_Repeat_Int, [interval]);
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

   // Set current operator
   dmZLogGlobal.CurrentOperator := op;

   // Change Voice Files
   FMessageManager.SetOperator(op);

   ShowSentNumber();

   FFunctionKeyPanel.UpdateInfo();
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
//   n := RigControl.GetCurrentRig;
   n := FCurrentRigSet;
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
   Result := FEditPanel[CurrentRigID].NumberEdit;
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

procedure TMainForm.InitQsoEditPanel();
begin
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin
      // 1R
      FEditPanel[0].SerialEdit   := SerialEdit1;
      FEditPanel[0].DateEdit     := DateEdit1;
      FEditPanel[0].TimeEdit     := TimeEdit1;
      FEditPanel[0].CallsignEdit := CallsignEdit1;
      FEditPanel[0].rcvdRSTEdit  := rcvdRSTEdit1;
      FEditPanel[0].NumberEdit   := NumberEdit1;
      FEditPanel[0].ModeEdit     := ModeEdit1;
      FEditPanel[0].PowerEdit    := PowerEdit1;
      FEditPanel[0].BandEdit     := BandEdit1;
      FEditPanel[0].PointEdit    := PointEdit1;
      FEditPanel[0].OpEdit       := OpEdit1;
      FEditPanel[0].MemoEdit     := MemoEdit1;
      FEditPanel[0].TxLed        := nil;

      FEditPanel[1].SerialEdit   := SerialEdit1;
      FEditPanel[1].DateEdit     := DateEdit1;
      FEditPanel[1].TimeEdit     := TimeEdit1;
      FEditPanel[1].CallsignEdit := CallsignEdit1;
      FEditPanel[1].rcvdRSTEdit  := rcvdRSTEdit1;
      FEditPanel[1].NumberEdit   := NumberEdit1;
      FEditPanel[1].ModeEdit     := ModeEdit1;
      FEditPanel[1].PowerEdit    := PowerEdit1;
      FEditPanel[1].BandEdit     := BandEdit1;
      FEditPanel[1].PointEdit    := PointEdit1;
      FEditPanel[1].OpEdit       := OpEdit1;
      FEditPanel[1].MemoEdit     := MemoEdit1;
      FEditPanel[1].TxLed        := nil;

      FEditPanel[2].SerialEdit   := SerialEdit1;
      FEditPanel[2].DateEdit     := DateEdit1;
      FEditPanel[2].TimeEdit     := TimeEdit1;
      FEditPanel[2].CallsignEdit := CallsignEdit1;
      FEditPanel[2].rcvdRSTEdit  := rcvdRSTEdit1;
      FEditPanel[2].NumberEdit   := NumberEdit1;
      FEditPanel[2].ModeEdit     := ModeEdit1;
      FEditPanel[2].PowerEdit    := PowerEdit1;
      FEditPanel[2].BandEdit     := BandEdit1;
      FEditPanel[2].PointEdit    := PointEdit1;
      FEditPanel[2].OpEdit       := OpEdit1;
      FEditPanel[2].MemoEdit     := MemoEdit1;
      FEditPanel[2].TxLed        := nil;

      EditPanel1R.Visible := True;
      EditPanel2R.Visible := False;
   end
   else begin  // 2R
      FEditPanel[0].SerialEdit   := SerialEdit2A;
      FEditPanel[0].DateEdit     := DateEdit2;
      FEditPanel[0].TimeEdit     := TimeEdit2;
      FEditPanel[0].CallsignEdit := CallsignEdit2A;
      FEditPanel[0].rcvdRSTEdit  := rcvdRSTEdit2A;
      FEditPanel[0].NumberEdit   := NumberEdit2A;
      FEditPanel[0].ModeEdit     := ModeEdit2A;
      FEditPanel[0].PowerEdit    := nil;
      FEditPanel[0].BandEdit     := BandEdit2A;
      FEditPanel[0].PointEdit    := nil;
      FEditPanel[0].OpEdit       := nil;
      FEditPanel[0].MemoEdit     := nil;
      FEditPanel[0].TxLed        := ledTx2A;

      FEditPanel[1].SerialEdit   := SerialEdit2B;
      FEditPanel[1].DateEdit     := DateEdit2;
      FEditPanel[1].TimeEdit     := TimeEdit2;
      FEditPanel[1].CallsignEdit := CallsignEdit2B;
      FEditPanel[1].rcvdRSTEdit  := rcvdRSTEdit2B;
      FEditPanel[1].NumberEdit   := NumberEdit2B;
      FEditPanel[1].ModeEdit     := ModeEdit2B;
      FEditPanel[1].PowerEdit    := nil;
      FEditPanel[1].BandEdit     := BandEdit2B;
      FEditPanel[1].PointEdit    := nil;
      FEditPanel[1].OpEdit       := nil;
      FEditPanel[1].MemoEdit     := nil;
      FEditPanel[1].TxLed        := ledTx2B;

      FEditPanel[2].SerialEdit   := SerialEdit2C;
      FEditPanel[2].DateEdit     := DateEdit2;
      FEditPanel[2].TimeEdit     := TimeEdit2;
      FEditPanel[2].CallsignEdit := CallsignEdit2C;
      FEditPanel[2].rcvdRSTEdit  := rcvdRSTEdit2C;
      FEditPanel[2].NumberEdit   := NumberEdit2C;
      FEditPanel[2].ModeEdit     := ModeEdit2C;
      FEditPanel[2].PowerEdit    := nil;
      FEditPanel[2].BandEdit     := BandEdit2C;
      FEditPanel[2].PointEdit    := nil;
      FEditPanel[2].OpEdit       := nil;
      FEditPanel[2].MemoEdit     := nil;
      FEditPanel[2].TxLed        := ledTx2C;

      EditPanel1R.Visible := False;
      EditPanel2R.Visible := True;

      ShowTxIndicator();
   end;
end;

procedure TMainForm.UpdateQsoEditPanel(rig: Integer);

   procedure SetWhite(id: Integer);
   begin
      FEditPanel[id].SerialEdit.Color := clWindow;
//      FEditPanel[id].DateEdit.Color := clWindow;
//      FEditPanel[id].TimeEdit.Color := clWindow;
      FEditPanel[id].CallsignEdit.Color := clWindow;
      FEditPanel[id].rcvdRSTEdit.Color := clWindow;
      FEditPanel[id].NumberEdit.Color := clWindow;
      FEditPanel[id].ModeEdit.Color := clWindow;
      FEditPanel[id].BandEdit.Color := clWindow;
      FEditPanel[id].ModeEdit.Enabled := True;
      FEditPanel[id].BandEdit.Enabled := True;
   end;

   procedure SetGlay(id: Integer);
   begin
      FEditPanel[id].SerialEdit.Color := clBtnFace;
//      FEditPanel[id].DateEdit.Color := clBtnFace;
//      FEditPanel[id].TimeEdit.Color := clBtnFace;
      FEditPanel[id].CallsignEdit.Color := clBtnFace;
      FEditPanel[id].rcvdRSTEdit.Color := clBtnFace;
      FEditPanel[id].NumberEdit.Color := clBtnFace;
      FEditPanel[id].ModeEdit.Color := clBtnFace;
      FEditPanel[id].BandEdit.Color := clBtnFace;
      FEditPanel[id].ModeEdit.Enabled := False;
      FEditPanel[id].BandEdit.Enabled := False;
   end;

   procedure SetRigTitleColor(rig1, rig2, rig3: Boolean);
   const
      title_color: array[False .. True] of TColor = (clBlack, clBlue);
   begin
      labelRig1Title.Font.Color := title_color[rig1];
      labelRig2Title.Font.Color := title_color[rig2];
      if checkUseRig3.Checked = True then begin
         labelRig3Title.Font.Color := title_color[rig3];
      end
      else begin
         labelRig3Title.Font.Color := clGray;
      end;
   end;
begin
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin
      LastFocus := CallsignEdit1;
      Exit;
   end
   else begin
      if rig = 1 then begin
         RigPanelShape2A.Pen.Color := clBlue;
         RigPanelShape2B.Pen.Color := clBlack;
         RigPanelShape2C.Pen.Color := clBlack;
         SetRigTitleColor(True, False, False);
         SetWhite(0);
         SetGlay(1);
         SetGlay(2);
      end
      else if rig = 2 then begin
         RigPanelShape2A.Pen.Color := clBlack;
         RigPanelShape2B.Pen.Color := clBlue;
         RigPanelShape2C.Pen.Color := clBlack;
         SetRigTitleColor(False, True, False);
         SetGlay(0);
         SetWhite(1);
         SetGlay(2);
      end
      else begin
         RigPanelShape2A.Pen.Color := clBlack;
         RigPanelShape2B.Pen.Color := clBlack;
         RigPanelShape2C.Pen.Color := clBlue;
         SetRigTitleColor(False, False, True);
         SetGlay(0);
         SetGlay(1);
         SetWhite(2);
      end;
//      if Assigned(RigControl) then begin
//         if Assigned(RigControl.Rigs[rig]) then begin
//            UpdateBand(RigControl.Rigs[rig].CurrentBand);
//            UpdateMode(RigControl.Rigs[rig].CurrentMode);
//         end;
//      end;
   end;
end;

procedure TMainForm.SwitchRig(rigset: Integer);
var
   rig: TRig;
begin
   FRigSwitchTime := Now();
   FCurrentRigSet := rigset;
   FCurrentRx := rigset - 1;
   FCurrentTx := rigset - 1;
   FInformation.Rx := rigset - 1;
   FInformation.Tx := rigset - 1;

   rig := RigControl.GetRig(rigset, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      RigControl.SetCurrentRig(rig.RigNumber);
      dmZLogKeyer.SetTxRigFlag(rigset);
      dmZLogKeyer.SetRxRigFlag(rigset, rig.RigNumber);
      RigControl.LastFreq := FLastFreq[rigset];
   end;

   UpdateBandAndMode();

   if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
      UpdateQsoEditPanel(rigset);
      if LastFocus = FEditPanel[rigset - 1].NumberEdit then begin
         EditEnter(FEditPanel[rigset - 1].NumberEdit);
      end
      else begin
         SendMessage(Handle, WM_ZLOG_SETFOCUS_CALLSIGN, rigset - 1, 0);
      end;

      if dmZLogGlobal.Settings._so2r_type = so2rNeo then begin
         PostMessage(FSo2rNeoCp.Handle, WM_ZLOG_SO2RNEO_SETRX, rigset - 1, 0);
      end;
   end;

   // ShowTxIndicator();
   PostMessage(Handle, WM_ZLOG_SETTXINDICATOR, 0, 0);

   UpdateCurrentQSO();
end;

procedure TMainForm.SwitchTxRx(tx_rig, rx_rig: Integer);
var
   rig: TRig;
begin
   // CQ Repeat 中止
   SetCqRepeatMode(False, False);

   FCurrentTx := tx_rig - 1;
   FInformation.Tx := tx_rig - 1;
   ShowTxIndicator();

   rig := RigControl.GetRig(tx_rig, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      dmZLogKeyer.SetTxRigFlag(tx_rig);
      dmZLogKeyer.SetRxRigFlag(rx_rig, rig.RigNumber);
   end;

   FCurrentRx := rx_rig - 1;
   FInformation.Rx := rx_rig - 1;

   FEditPanel[rx_rig - 1].CallsignEdit.SetFocus();

   if dmZLogGlobal.Settings._so2r_type = so2rNeo then begin
      PostMessage(FSo2rNeoCp.Handle, WM_ZLOG_SO2RNEO_SETRX, rx_rig - 1, 0);
   end;

   UpdateCurrentQSO();
end;

procedure TMainForm.SwitchTx(rigset: Integer);
var
   rig: TRig;
begin
   // CQ Repeat 中止
//   SetCqRepeatMode(False);

   FCurrentTx := rigset - 1;
   FInformation.Tx := rigset - 1;
   ShowTxIndicator();

   rig := RigControl.GetRig(rigset, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      dmZLogKeyer.SetTxRigFlag(rigset);
   end;

   if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
      UpdateQsoEditPanel(rigset);
      if LastFocus = FEditPanel[rigset - 1].NumberEdit then begin
         EditEnter(FEditPanel[rigset - 1].NumberEdit);
      end
      else begin
         FEditPanel[rigset - 1].CallsignEdit.SetFocus();
         EditEnter(FEditPanel[rigset - 1].CallsignEdit);
      end;
//      FSo2rNeoCp.Rx := rig - 1;
   end;
end;

procedure TMainForm.SwitchRx(rigset: Integer; focusonly: Boolean);
var
   rig: TRig;
begin
   FCurrentRx := rigset - 1;
   FInformation.Rx := rigset - 1;
   FCurrentRigSet := rigset;

   if focusonly = False then begin
      rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
      if Assigned(rig) then begin
         RigControl.SetCurrentRig(rig.RigNumber);
//         dmZLogKeyer.SetTxRigFlag(FCurrentRigSet);
         dmZLogKeyer.SetRxRigFlag(rigset, rig.RigNumber);
         UpdateBand(rig.CurrentBand);
         UpdateMode(rig.CurrentMode);
         RigControl.LastFreq := FLastFreq[rigset];
      end;
   end;

   if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
      UpdateQsoEditPanel(rigset);
      if LastFocus = FEditPanel[rigset - 1].NumberEdit then begin
//         EditEnter(FEditPanel[rigset - 1].NumberEdit);
      end
      else begin
         SendMessage(Handle, WM_ZLOG_SETFOCUS_CALLSIGN, rigset - 1, 0);
      end;
//      FSo2rNeoCp.Rx := rig - 1;

      if dmZLogGlobal.Settings._so2r_type = so2rNeo then begin
         PostMessage(FSo2rNeoCp.Handle, WM_ZLOG_SO2RNEO_SETRX, rigset - 1, 0);
      end;

      UpdateCurrentQSO();
   end;
end;

procedure TMainForm.ShowTxIndicator();
var
   i: Integer;
begin
   for i := 0 to 2 do begin
      if Assigned(FEditPanel[i].TxLed) then begin
         if i = FCurrentTx then begin
            FEditPanel[i].TxLed.Status := True;
         end
         else begin
            FEditPanel[i].TxLed.Status := False;
         end;
      end;
   end;
end;

procedure TMainForm.InvertTx();
var
   tx: Integer;
   rig: TRig;
begin
   tx := GetNextRigID(FCurrentRx);

   FCurrentTx := tx;
   FInformation.Tx := tx;

   rig := RigControl.GetRig(tx + 1, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      dmZLogKeyer.SetTxRigFlag(tx + 1);
   end;

   // ShowTxIndicator();
   PostMessage(Handle, WM_ZLOG_SETTXINDICATOR, 0, 0);
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

// WinKeyer状態変更イベント
procedure TMainForm.DoWkStatusProc(Sender: TObject; tx: Integer; rx: Integer; ptt: Boolean);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** DoWkStatusProc(' + IntToStr(tx) + ', ' + IntToStr(rx) + ', ' + BoolToStr(ptt) + ') ***'));
   {$ENDIF}
//   FSo2rNeoCp.Rx := rx;
   if dmZLogGlobal.Settings._so2r_type = so2rNeo then begin
      PostMessage(FSo2rNeoCp.Handle, WM_ZLOG_SO2RNEO_SETRX, rx, 0);
   end;

   PostMessage(Handle, WM_ZLOG_SETPTTSTATE, Integer(ptt), 0);

   if dmZLogGlobal.Settings._so2r_type = so2rNeo then begin
      PostMessage(FSo2rNeoCp.Handle, WM_ZLOG_SO2RNEO_SETPTT, Integer(ptt), 0);
   end;
end;

// CW電文中のコマンド処理イベント(@001～)
procedure TMainForm.DoCwCommandProc(Sebder: TObject; nCommand: Integer);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** DoCwCommandProc(' + IntToStr(nCommand) + ') ***'));
   {$ENDIF}

   if ActionList1.ActionCount <= nCommand then begin
      {$IFDEF DEBUG}
      OutputDebugString(PChar('*** Command no too large ***'));
      {$ENDIF}
      Exit;
   end;

   ActionList1.Actions[nCommand].Execute();
end;

procedure TMainForm.checkUseRig3Click(Sender: TObject);
var
   rig: Integer;
begin
//   rig := RigControl.GetCurrentRig();
   rig := FCurrentRigSet;

   if checkUseRig3.Checked = True then begin
      RigControl.MaxRig := 3;
      CallsignEdit2C.Enabled := True;
      RcvdRSTEdit2C.Enabled := True;
      NumberEdit2C.Enabled := True;
      BandEdit2C.Enabled := True;
      ModeEdit2C.Enabled := True;
      SerialEdit2C.Enabled := True;
      RigPanelShape2C.Pen.Color := clBlack;
      labelRig3Title.Font.Color := clBlack;

      FEditPanel[rig - 1].CallsignEdit.SetFocus();
   end
   else begin
      if rig = 3 then begin
         rig := 1;
      end;
      RigControl.MaxRig := 2;
      SwitchRig(rig);
      CallsignEdit2C.Enabled := False;
      RcvdRSTEdit2C.Enabled := False;
      NumberEdit2C.Enabled := False;
      BandEdit2C.Enabled := False;
      ModeEdit2C.Enabled := False;
      SerialEdit2C.Enabled := False;
      RigPanelShape2C.Pen.Color := clGray;
      labelRig3Title.Font.Color := clGray;
   end;
end;

procedure TMainForm.SetLastFocus();
begin
   if Visible = False then Exit;
   if not Assigned(LastFocus) then Exit;
   LastFocus.SetFocus;
end;

procedure TMainForm.checkWithRigClick(Sender: TObject);
begin
   //
end;

procedure TMainForm.comboBandPlanChange(Sender: TObject);
begin
   dmZLogGlobal.SelectBandPlan(comboBandPlan.Text);
   SetLastFocus();
   BandScopeApplyBandPlan();
end;

function TMainForm.GetNextRigID(curid: Integer): Integer;
var
   nextid: Integer;

   function ToggleRigID(id: Integer): Integer;
   begin
      Inc(id);
      if id >= RigControl.MaxRig then begin
         id := 0;
      end;
      Result := id;
   end;
begin
   if (dmZLogGlobal.Settings._operate_style = os2Radio) and
      (RigControl.MaxRig = 3) then begin
      // RIG1,RIG2両方にチェックがある場合と
      // RIG1,RIG2両方にチェックがない場合
      // RIG1-RIG3を巡回
      if ((checkWithRig1.Checked = True) and (checkWithRig2.Checked = True)) or
         ((checkWithRig1.Checked = False) and (checkWithRig2.Checked = False)) then begin
         Result := ToggleRigID(curid);
         Exit;
      end;

      if curid = 0 then begin
         // 現在RIG1で、RIG3にチェックがあってRIG1とペアなら、RIG1-RIG3をトグル
         if (checkWithRig1.Checked = True) then begin
            nextid := 2;
         end
         else begin  // そうでなければRIG1-RIG2でトグル
            nextid := 1;
         end;
      end
      else if curid = 1 then begin
         // 現在RIG2で、RIG3にチェックがあってRIG2とペアなら、RIG2-RIG3をトグル
         if (checkWithRig2.Checked = True) then begin
            nextid := 2;
         end
         else begin  // そうでなければRIG1-RIG2でトグル
            nextid := 0;
         end;
      end
      else begin
         // 現在RIG3ならチェックのある方とペア
         if checkWithRig1.Checked = True then begin
            nextid := 0;
         end
         else if checkWithRig2.Checked = True then begin
            nextid := 1;
         end
         else begin
            nextid := 2;
         end;
      end;
   end
   else begin
      nextid := ToggleRigID(curid);
   end;

   Result := nextid;
end;

procedure TMainForm.UpdateBandAndMode();
var
   rig: TRig;
begin
   // SetCurrentRig()はToggleRig内で既に行われている

   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(BandEdit.Text));
   if Assigned(rig) then begin
      RigControl.SetCurrentRig(rig.RigNumber);
      dmZLogKeyer.SetTxRigFlag(FCurrentRigSet);
      UpdateBand(rig.CurrentBand);
      UpdateMode(rig.CurrentMode);
   end
   else begin
      UpdateBand(TextToBand(FEditPanel[FCurrentTx].BandEdit.Text));
      UpdateMode(TextToMode(FEditPanel[FCurrentTx].ModeEdit.Text));
   end;
end;

procedure TMainForm.CancelCqRepeat();
begin
   SetCqRepeatMode(False, False);
end;

procedure TMainForm.ResetTx(rigset: Integer);
var
   rigno: Integer;
   rig: TRig;
begin
//   rigno := FCurrentRigSet;   //RigControl.GetCurrentRig();
   rigno := rigset - 1;
   FCurrentTx := rigno;
   FInformation.Tx := rigno;

   rig := RigControl.GetRig(rigset, TextToBand(BandEdit.Text));
   if rig <> nil then begin
      dmZLogKeyer.SetTxRigFlag(rigset);
   end;

   // ShowTxIndicator();
   SendMessage(Handle, WM_ZLOG_SETTXINDICATOR, 0, 0);
end;

procedure TMainForm.StopMessage(mode: TMode);
begin
   if mode = mCW then begin
      CWStopButtonClick(Self);
   end
   else if (mode = mSSB) or (mode = mFM) or (mode = mAM) then begin
      VoiceStopButtonClick(Self);
   end;
end;

procedure TMainForm.ControlPTT(fOn: Boolean);
var
   nID: Integer;
begin
   nID := GetTxRigID();
   if dmZLogGlobal.Settings._use_winkeyer = True then begin
      dmZLogKeyer.WinKeyerControlPTT2(fOn);
   end
   else begin
      dmZLogKeyer.ControlPTT(nID, fOn);
   end;
end;

procedure TMainForm.View1Click(Sender: TObject);
begin
   if dmZLogGlobal.ContestCategory = ccSingleOp then begin
      menuShowThisTXonly.Visible := False;
      menuShowOnlySpecifiedTX.Visible := False;
   end
   else begin
      menuShowThisTXonly.Visible := True;
      menuShowOnlySpecifiedTX.Visible := True;
   end;
end;

procedure TMainForm.VoiceControl(fOn: Boolean);
var
   nID: Integer;
   r: Integer;
   fPhonePTT: Boolean;
begin
   nID := GetTxRigID();
   r := nID + 1;

   fPhonePTT := dmZLogGlobal.Settings.FRigControl[r].FPhoneChgPTT;

   if fOn = True then begin
      dmZLogKeyer.SetVoiceFlag(1);
      if dmZLogGlobal.Settings._pttenabled_ph then begin
         dmZLogKeyer.ControlPTT(nID, True, fPhonePTT);
         Sleep(dmZLogGlobal.Settings._pttbefore_ph);
      end;
   end
   else begin
      if dmZLogGlobal.Settings._pttenabled_ph then begin
         Sleep(dmZLogGlobal.Settings._pttafter_ph);
         dmZLogKeyer.ControlPTT(nID, False, fPhonePTT);
      end;
      dmZLogKeyer.SetVoiceFlag(0);
   end;
end;

procedure TMainForm.TogglePTTfor2bsiq();
var
   fBeforePTT: Boolean;
begin
   // 現在のPTT状態
   fBeforePTT := dmZLogKeyer.PTTIsOn;

   if fBeforePTT = True then begin
      ControlPTT(False);
   end
   else begin
      // TXをRXに合わせる
      if FCurrentTx <> FCurrentRx then begin
         ResetTx(FCurrentRigSet);
      end;

      if FCQLoopRunning = True then begin
         timerCqRepeat.Enabled := False;
         FMessageManager.ClearQue2();
      end;

      ControlPTT(True);
   end;
end;

procedure TMainForm.OnNonconvertKeyProc();
var
   fBeforePTT: Boolean;
   fPTT: Boolean;
   nID: Integer;
   mode: TMode;
   band: TBand;
   rig: TRig;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('[無変換]'));
   {$ENDIF}

   // PTT制御無効なら何もしない
   if ((dmZLogGlobal.Settings._pttenabled_cw = False) and
       (dmZLogGlobal.Settings._pttenabled_ph = False)) then begin
      Exit;
   end;

   // 現在のPTT状態
   fBeforePTT := dmZLogKeyer.PTTIsOn;

   // 現在のモード
   nID := FCurrentTx;
   mode := TextToMode(FEditPanel[nID].ModeEdit.Text);
   band := TextToBand(FEditPanel[nID].BandEdit.Text);

   // 2BSIQ時は受信中の方でPTT制御する
   if (dmZLogGlobal.Settings._operate_style = os2Radio) and
      (Is2bsiq() = True) then begin
      // 再生中なら
      if FMessageManager.IsPlaying = True then begin
         // CQを中止して
//         CQAbort(False);

         StopMessage(mode);

         // TXをRXに合わせる
         if FCurrentTx <> FCurrentRx then begin
            ResetTx(FCurrentRigSet);
         end;

         // PTT ON
         fPTT := True;
      end
      else begin
         if fBeforePTT = True then begin
            fPTT := False;
         end
         else begin
            // TXをRXに合わせる
            if FCurrentTx <> FCurrentRx then begin
               ResetTx(FCurrentRigSet);
            end;

            if FCQLoopRunning = True then begin
               timerCqRepeat.Enabled := False;
               FMessageManager.ClearQue2();
            end;

            fPTT := True;
         end;
      end;
   end
   else begin
      // 再生中なら
      if FMessageManager.IsPlaying = True then begin
         // CQを中止して
         CQAbort(False);

         // PTT ON
         fPTT := True;
      end
      else begin
         // PTTをトグル
         if fBeforePTT = True then begin
            fPTT := False;
         end
         else begin
            fPTT := True;
         end;
      end;
   end;

   rig := RigControl.GetRig(FCurrentRigSet, band);
   if (rig <> nil) and (rig.ControlPTTSupported = True) and
      (dmZLogGlobal.Settings._use_ptt_command = True) then begin
      rig.ControlPTT(fPTT);
   end;

   if mode = mCW then begin
      ControlPTT(fPTT);
   end
   else begin
      VoiceControl(fPTT);
   end;
end;

procedure TMainForm.OnUpKeyProc(Sender: TObject);
var
   L: TQSOList;
begin
   L := TQSOList(Grid.Tag);
   if L.Count = 1 then begin
      Grid.Row := 1;
   end
   else begin
      Grid.Row := L.Count - 1;
   end;
   LastFocus := TEdit(Sender);
   Grid.SetFocus;
end;

procedure TMainForm.OnAlphaNumericKeyProc(Sender: TObject; var Key: word);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('BEGIN - TMainForm.OnAlphaNumericKeyProc() Key = ' + IntToStr(Key)));
   {$ENDIF}

   // CQリピート停止
//   timerCqRepeat.Enabled := False;
//   FMessageManager.ClearQue2();

   // CQループ中のキー入力割り込み
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin
      if (FCtrlZCQLoop = True) and (Sender = CallsignEdit) then begin
         CancelCqRepeat();
         if FCQRepeatStartMode = mCW then begin
            dmZLogKeyer.ClrBuffer;
            FCWMonitor.ClearSendingText();
         end
         else begin
            FMessageManager.StopVoice();
            VoiceControl(False);
         end;
      end;
   end
   else begin
      if Is2bsiq() = False then begin
         if (FCtrlZCQLoop = True) and (Sender = CallsignEdit) and (FCurrentTx = FCurrentRx) then begin
            CancelCqRepeat();
            if FCQRepeatStartMode = mCW then begin
               dmZLogKeyer.ClrBuffer;
               FCWMonitor.ClearSendingText();
            end
            else begin
               FMessageManager.StopVoice();
               VoiceControl(False);
            end;
         end;
      end
      else begin
         FOtherKeyPressed[FCurrentRigSet - 1] := True;
      end;
   end;

   // J-Modeの処理
   if (dmZlogGlobal.Settings._jmode) and (Sender = CallsignEdit) then begin
      if CallsignEdit.Text = '' then begin
         if (Key <> Ord('7')) and (Key <> Ord('8')) then begin
            CallsignEdit.Text := 'J';
            CallsignEdit.SelStart := 1;
         end;
      end;
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('END - TMainForm.OnAlphaNumericKeyProc() Key = ' + IntToStr(Key)));
   {$ENDIF}
end;

procedure TMainForm.UpdateCurrentQSO();
begin
   if Assigned(CallsignEdit.OnChange) then begin
      CallsignEdit.OnChange(nil);
   end;
   CurrentQSO.NrRcvd := NumberEdit.Text;
   CurrentQSO.Band := TextToBand(BandEdit.Text);
   CurrentQSO.Mode := TextToMode(ModeEdit.Text);
end;

procedure TMainForm.CQAbort(fReturnStartRig: Boolean);
var
   nID: Integer;
   mode: TMode;
begin
   WriteStatusLine('', False);

   SetCqRepeatMode(False, False);

   nID := FCurrentTx;
   mode := TextToMode(FEditPanel[nID].ModeEdit.Text);
   StopMessage(mode);
   FMessageManager.ClearQue();
   FCWMonitor.ClearSendingText();

   // メモリースキャン解除
   RigControl.MemScanOff();

   // F2Aモード解除
   F2AOff();

   // ２回やらないようにPTT ControlがOFFの場合にPTT OFFする
   if (((mode = mCW) and (dmZLogGlobal.Settings._pttenabled_cw = False) and (dmZLogKeyer.UseWinKeyer = False)) or
       ((mode <> mCW) and (dmZLogGlobal.Settings._pttenabled_ph = False))) then begin
      dmZLogKeyer.ResetPTT();
   end;

   // 2R:2BSIQ OFFの場合はRIG1に戻す
   if fReturnStartRig = True then begin
      if (dmZLogGlobal.Settings._operate_style = os2Radio) then begin
         if (Is2bsiq() = False) then begin
            // TXとRXが違う場合は、RXに合わせる
            SwitchRig(FCQLoopStartRig);
         end
         else begin
            if FCurrentRx <> FCurrentTx then begin
               SwitchTx(FCurrentRx + 1);
            end;
         end;
      end;
   end;

   // 1R:TXとRXを合わせる
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin
      if FCurrentTx <> FCurrentRx then begin
         SwitchRig(FCurrentRx + 1);
      end;
   end;

   F2bsiqStart := False;
end;

procedure TMainForm.ShowToolBar(M: TMode);
var
 v: Boolean;
 h: Integer;
begin
   // CW/PH ToolBar
   if (mnHideCWPhToolBar.Checked = False) then begin
      if M in [mCW, mRTTY] then begin
         if CWToolBar.Visible = False then begin
            CWToolBar.Visible := True;
            SSBToolBar.Visible := False;
         end;
      end
      else begin
         if SSBToolBar.Visible = False then begin
            SSBToolBar.Visible := True;
            CWToolBar.Visible := False;
         end;
      end;
   end
   else begin
      CWToolBar.Visible := False;
      SSBToolBar.Visible := False;
   end;

   // Main ToolBar
   MainToolBar.Visible := not mnHideMenuToolbar.Checked;

   if (mnHideMenuToolbar.Checked = True) and (mnHideCWPhToolBar.Checked = True) then begin
      v := False;
      h := ToolBarPanel.Height;
   end
   else if ((mnHideMenuToolbar.Checked = True) and (mnHideCWPhToolBar.Checked = False)) or
           ((mnHideMenuToolbar.Checked = False) and (mnHideCWPhToolBar.Checked = True)) then begin
      v := True;
      h := 33;
   end
   else begin
      v := True;
      h := 66;
   end;

   if ToolBarPanel.Visible <> v then begin
      ToolBarPanel.Visible := v;
   end;
   if ToolBarPanel.Height <> h then begin
      ToolBarPanel.Height := h;
   end;
end;

procedure TMainForm.InitSerialPanel();
begin
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin

   end
   else begin
      if SerialContestType = 0 then begin
         SerialEdit2A.Visible := False;
         SerialEdit2B.Visible := False;
         SerialEdit2C.Visible := False;
      end
      else begin
         SerialEdit2A.Visible := True;
         SerialEdit2B.Visible := True;
         SerialEdit2C.Visible := True;
      end;
   end;
end;

procedure TMainForm.DispSerialNumber(aQSO: TQSO);
begin
   case SerialContestType of
      0: begin
         Exit;
      end;

      SER_ALL: begin
         aQSO.Serial := SerialNumber;
      end;

      SER_BAND: begin
         aQSO.Serial := SerialArrayBand[aQSO.Band];
      end;

      SER_MS: begin
         aQSO.Serial := SerialArrayTX[aQSO.TX];
      end;
   end;

   if dmZLogGlobal.Settings._so2r_type = so2rNone then begin
      SerialEdit.Text := aQSO.SerialStr;
   end
   else begin
      SerialEdit2A.Text := aQSO.SerialStr;
      SerialEdit2B.Text := aQSO.SerialStr;
      SerialEdit2C.Text := aQSO.SerialStr;
   end;

   ShowSentNumber();
end;

procedure TMainForm.InitSerialNumber();
var
   b: TBand;
   i: Integer;
begin
   SerialNumber := 1;

   for B := b19 to HiBand do begin
      SerialArrayBand[B] := 1;
   end;

   for i := Low(SerialArrayTx) to High(SerialArrayTx) do begin
      SerialArrayTX[i] := 1;
   end;
end;

procedure TMainForm.RestoreSerialNumber();
var
   b: TBand;
   i: Integer;
   Q: TQSO;
begin
   for b := b19 to HiBand do begin
      SerialArrayBand[b] := 0;
   end;

   for i := Low(SerialArrayTx) to High(SerialArrayTx) do begin
      SerialArrayTx[i] := 0;
   end;

   for i := 1 to Log.TotalQSO do begin
      Q := Log.QsoList[i];
      SerialNumber := Q.Serial;
      SerialArrayBand[Q.Band] := Q.Serial;
      SerialArrayTx[Q.Tx] := Q.Serial;
   end;

   // SerialNumber,SerialArrayには次の番号を入れる
   Inc(SerialNumber);

   for b := b19 to HiBand do begin
      Inc(SerialArrayBand[b]);
   end;

   for i := Low(SerialArrayTx) to High(SerialArrayTx) do begin
      Inc(SerialArrayTx[i]);
   end;
end;

procedure TMainForm.SetInitSerialNumber(aQSO: TQSO);
begin
   case SerialContestType of
      0: begin
         //
      end;

      SER_ALL: begin
         aQSO.Serial := SerialNumber;
      end;

      SER_BAND: begin
         aQSO.Serial := SerialArrayBand[aQSO.Band];
      end;

      SER_MS: begin
         aQSO.Serial := SerialArrayTX[aQSO.TX];
      end;
   end;
end;

procedure TMainForm.SetNextSerialNumber(aQSO: TQSO);
begin
   case SerialContestType of
      0: begin
         //
      end;

      SER_ALL: begin
         Inc(SerialNumber);
      end;

      SER_BAND: begin
         Inc(SerialArrayBand[aQSO.Band]);
      end;

      SER_MS: begin
         Inc(SerialArrayTX[aQSO.TX]);
      end;
   end;

   DispSerialNumber(aQSO);
end;

procedure TMainForm.SetNextSerialNumber2(aQSO: TQSO; Local : Boolean);
begin
   // synchronization of serial # over network
   if dmZlogGlobal.Settings._syncserial and (SerialContestType <> 0) and (Local = False) then begin
      if SerialContestType = SER_MS then begin // WPX M/S type. Separate serial for mult/run
         SerialArrayTX[aQSO.TX] := aQSO.Serial + 1;
         if aQSO.TX = dmZlogGlobal.TXNr then begin
            aQSO.Serial := aQSO.Serial + 1;
         end;
      end
      else begin
         SerialArrayBand[aQSO.Band] := aQSO.Serial + 1;
         if (SerialContestType = SER_ALL) or ((SerialContestType = SER_BAND)) then begin
            aQSO.Serial := aQSO.Serial + 1;
         end;
      end;

      DispSerialNumber(aQSO);
   end;
end;

procedure TMainForm.SetNextSerialNumber3(aQSO: TQSO);
begin
   if (dmZlogGlobal.Settings._syncserial) and (SerialContestType = SER_MS) then begin
      aQSO.Serial := SerialArrayTX[aQSO.TX];
      DispSerialNumber(aQSO);
   end;
end;

procedure TMainForm.RenewScore();
begin
   MyContest.Renew;

   // 画面リフレッシュ
   GridRefreshScreen();

   // バンドスコープリフレッシュ
   BSRefresh();

   ReEvaluateCountDownTimer;
   ReEvaluateQSYCount;
end;

procedure TMainForm.ScrollGrid();
var
   i: Integer;
begin
   i := Grid.TopRow;
   MyContest.Renew;
   Grid.TopRow := i;
   GridRefreshScreen();
   BSRefresh();
end;

procedure TMainForm.MsgMgrAddQue(nID: Integer; S: string; aQSO: TQSO);
begin
   FMessageManager.AddQue(nID, S, aQSO);
end;

procedure TMainForm.MsgMgrContinueQue();
begin
   FMessageManager.ContinueQue();
end;

// RigSet(1,2,3) to RigID(0,1,2,3,4)
function TMainForm.GetTxRigID(nTxRigSet: Integer): Integer;
var
   rig: TRig;
   i: Integer;
begin
   if nTxRigSet = -1 then begin
      nTxRigSet := FCurrentTx + 1;
   end;

   // 1Radioで1台もControlが無い場合、
   // RIG-1から順にチェックして、KeyingPortが設定されているRIGを返す
   if (dmZLogGlobal.Settings._operate_style = os1Radio) and
      (dmZLogGlobal.Settings.FRigControl[1].FControlPort = 0) and
      (dmZLogGlobal.Settings.FRigControl[2].FControlPort = 0) and
      (dmZLogGlobal.Settings.FRigControl[3].FControlPort = 0) and
      (dmZLogGlobal.Settings.FRigControl[4].FControlPort = 0) then begin
      for i := 1 to 5 do begin
         if (dmZLogGlobal.Settings.FRigControl[i].FKeyingPort > 0) then begin
            Result := i - 1;
            Exit;
         end;
      end;

      // 設定が無ければRIG-1を返す
      Result := 0;
      Exit;
   end;

   rig := RigControl.GetRig(nTxRigSet, TextToBand(BandEdit.Text));
   if rig = nil then begin
      Result := 0;
   end
   else begin
      Result := rig.RigNumber - 1;
   end;
end;

procedure TMainForm.SetCurrentQSO(nID: Integer);
begin
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin
      CurrentQSO.Callsign := CallsignEdit.Text;
      CurrentQSO.Mode := TextToMode(ModeEdit.Text);
      CurrentQSO.Band := TextToBand(BandEdit.Text);
      CurrentQSO.NrRcvd := NumberEdit.Text;
   end
   else begin
      CurrentQSO.Callsign := FEditPanel[nID].CallsignEdit.Text;
      CurrentQSO.Mode := TextToMode(FEditPanel[nID].ModeEdit.Text);
      CurrentQSO.Band := TextToBand(FEditPanel[nID].BandEdit.Text);
      CurrentQSO.NrRcvd := FEditPanel[nID].NumberEdit.Text;
   end;
end;

procedure TMainForm.EditCurrentRow();
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
      WriteStatusLine(TMainForm_This_QSO_is_locked, False);
      exit;
   end;

   MyContest.PastEditForm.Init(aQSO, _ActChange);

   if MyContest.PastEditForm.ShowModal <> mrOK then begin
      Exit;
   end;

   GridWriteQSO(R, aQSO);

   if FPartialCheck.Visible and FPartialCheck._CheckCall then begin
      FPartialCheck.CheckPartial(CurrentQSO);
   end;

   if FCheckCall2.Visible then begin
      FCheckCall2.Renew(CurrentQSO);
   end;

   // 画面リフレッシュ
   GridRefreshScreen(True);

   // バンドスコープリフレッシュ
   BSRefresh();
end;

procedure TMainForm.SetCqRepeatMode(fOn: Boolean; fFirst: Boolean);
var
   i: Integer;
begin
   FInformation.CqRepeat := fOn;

   for i := 0 to 4 do begin
      FWaitForQsoFinish[i] := False;
      FTabKeyPressed[i] := False;
      FDownKeyPressed[i] := False;
      FOtherKeyPressed[i] := False;
   end;

   if fOn = False then begin
      timerCqRepeat.Enabled := False;
      FCQLoopCount := 0;
      FCQLoopRunning := False;
      FCtrlZCQLoop := False;
      FCQRepeatPlaying := False;
   end
   else begin
      FCQRepeatPlaying := True;
      FCQLoopRunning := True;
      FCQLoopCount := 0;
      FCQLoopStartRig := (FCurrentTx + 1); //FCurrentRigSet;
      CQRepeatProc(0, fFirst);
   end;
end;

procedure TMainForm.StartCqRepeatTimer();
var
   interval: Double;
begin
   if (dmZLogGlobal.Settings._operate_style = os2Radio) and
      (Is2bsiq() = True) then begin
      interval := dmZLogGlobal.Settings._so2r_cq_rpt_interval_sec;
   end
   else begin
      interval := dmZLogGlobal.Settings.CW._cqrepeat;
   end;
   FCQRepeatInterval := Trunc(interval);
   FCQRepeatCount := FCQRepeatInterval * 10;

   // CQリピート開始
   timerCqRepeat.Interval := 100;
   timerCqRepeat.Enabled := True;
end;

procedure TMainForm.StopCqRepeatTimer();
begin
   FInformation.CqRptCountDown := 0;
end;

function TMainForm.Is2bsiq(): Boolean;
begin
   if (FInformation.Is2bsiq = True) and
      (F2bsiqStart = True) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TMainForm.AddTaskbar(Handle: THandle);
begin
   if FTaskbarList <> nil then begin
      FTaskBarList.AddTab(Handle);
      FTaskBarList.ActivateTab(Handle);
   end;
end;

procedure TMainForm.DelTaskbar(Handle: THandle);
begin
   if FTaskBarList <> nil then begin
      FTaskBarList.DeleteTab(Handle);
   end;
end;

procedure TMainForm.ShowSentNumber();
begin
   StatusLine.Panels[1].Text := CurrentQSO.RSTSentStr + ' ' + SetStrNoAbbrev(dmZLogGlobal.Settings._sentstr, CurrentQSO);
end;

procedure TMainForm.ShowRigControlInfo(strText: string);
begin
   StatusLine.Panels[2].Text := strText;
end;

function TMainForm.InputStartTime(fNeedSave: Boolean): Boolean;
var
   dlg: TStartTimeDialog;
   dt: TDateTime;
   yy, mm, dd, hh, nn, ss, ms: Word;
begin
   dlg := TStartTimeDialog.Create(Self);
   try
      // 開始時間が未設定なら現在日時よりそれっぽい開始時間を設定する
      if Log.StartTime = 0 then begin
         if MyContest.UseUTC = True then begin
            dt := GetUTC();
         end
         else begin
            dt := Now;
         end;

         if MyContest.StartTime = 0 then begin
            dt := IncDay(dt, 1);
         end;

         DecodeDateTime(dt, yy, mm, dd, hh, nn, ss, ms);

         // 開始時間未定義か
         if MyContest.StartTime = -1 then begin
            dlg.BaseTime := EncodeDateTime(yy, mm, dd, hh, 0, 0, 0);
         end
         else begin
            dlg.BaseTime := EncodeDateTime(yy, mm, dd, MyContest.StartTime, 0, 0, 0);
         end;
      end
      else begin  // 設定済みはファイルより
         dlg.BaseTime := Log.StartTime;
      end;

      dlg.UseUtc := MyContest.UseUTC;

      if dlg.ShowModal() <> mrOK then begin
         Result := False;
         Exit;
      end;

      Log.StartTime := dlg.BaseTime;
      Log.Saved := False;
      if (fNeedSave = True) and (CurrentFileName <> '') then begin
         Log.SaveToFile(CurrentFileName);
      end;

      Result := True;
   finally
      dlg.Release();
   end;
end;

procedure TMainForm.EnableShiftKeyAction(fEnable: Boolean);
var
   i: Integer;
   j: Integer;
   act: TContainedAction;
   shortcut: TShortcut;
begin
   for i := 0 to ActionList1.ActionCount - 1 do begin
      act := ActionList1.Actions[i];
      shortcut := act.ShortCut;
      if (shortcut and scShift) <> 0 then begin
         act.Enabled := fEnable;
      end;

      for j := 0 to act.SecondaryShortCuts.Count - 1 do begin
         shortcut := act.SecondaryShortCuts.ShortCuts[j];
         if (shortcut and scShift) <> 0 then begin
            act.Enabled := fEnable;
         end;
      end;
   end;
end;

procedure TMainForm.ShowOutOfContestPeriod(fShow: Boolean);
begin
   panelOutOfPeriod.Visible := True;
   buttonCancelOutOfPeriod.Left := panelOutOfPeriod.Width - 26;
   if fShow = True then begin
      timerOutOfPeriod.Tag := 1;
   end
   else begin
      timerOutOfPeriod.Tag := 0;
   end;
   timerOutOfPeriod.Enabled := True;
end;

procedure TMainForm.ShowInfoPanel(text: string; handler: TSysLinkEvent; fShow: Boolean);
begin
   if (panelShowInfo.Visible = fShow) then begin
      Exit;
   end;

   panelShowInfo.Visible := True;
   if fShow = True then begin
      if Assigned(handler) then begin
         linklabelInfo.Caption := '<A HREF="' + text + '">' + text + '</A>';
      end
      else begin
         linklabelInfo.Caption := text;
      end;

      linklabelInfo.OnLinkClick := handler;
      linklabelInfo.Left := (panelShowInfo.Width - linklabelInfo.width) div 2;
      timerShowInfo.Tag := 1;
   end
   else begin
      timerShowInfo.Tag := 0;
      linklabelInfo.OnLinkClick := nil;
   end;
   timerShowInfo.Enabled := True;
end;

procedure TMainForm.DoNewDataArrived(Sender: TObject; const Link: string; LinkType: TSysLinkType);
begin
   FPastEditMode := False;
   GridRefreshScreen();
   ShowInfoPanel('', nil, False);
   SetLastFocus();
end;

function TMainForm.GetQsoList(): TQSOList;
var
   L: TQSOList;
begin
   if menuShowCurrentBandOnly.Checked then begin
      L := Log.BandList[CurrentQSO.Band];
   end
   else if menuShowThisTxOnly.Checked then begin
      L := Log.TxList[CurrentQSO.TX];
   end
   else if menuShowOnlySpecifiedTX.Checked then begin
      L := Log.TxList[FFilterTx];
   end
   else begin
      L := Log.QsoList;
   end;

   Result := L;
end;

procedure TMainForm.JarlMemberCheck();
var
   i: Integer;
   web: TformJarlMemberInfo;
   list: TJarlMemberInfoList;
   O: TJarlMemberInfo;
   Q: TQSO;
   S: string;
   dic: TDictionary<string, TJarlMemberInfo>;
   arr: TArray<TPair<string,TJarlMemberInfo>>;
begin
   web := TformJarlMemberInfo.Create(Self);
   list := TJarlMemberInfoList.Create();
   dic := TDictionary<string, TJarlMemberInfo>.Create();
   web.Title := TMainForm_JARL_Member_Info;
   web.Text := TMainForm_Inquire_JARL_Member_Info;
   web.Show();
   web.IndicatorAnimate := True;
   Enabled := False;

   try
      for i := 1 to Log.TotalQSO do begin
         Q := Log.QsoList[i];

         S := CoreCall(Q.Callsign);

         if IsDomestic(S) = False then begin
            Continue;
         end;

         if dic.ContainsKey(S) = False then begin
            O := TJarlMemberInfo.Create();
            O.Callsign := S;
            dic.Add(S, O);
            list.Add(O);
         end;

         if (list.Count = 20) then begin
            web.QueryMemberInfo(list);
            list.Clear();
         end;
      end;

      if (list.Count > 0) then begin
         web.QueryMemberInfo(list);
         list.Clear();
      end;

      for i := 1 to Log.TotalQSO do begin
         Q := Log.QsoList[i];

         S := CoreCall(Q.Callsign);
         if dic.TryGetValue(S, O) then begin
            if O.Transfer = False then begin
               Q.QslState := qsNoQsl;
            end;
         end;
      end;

      Log.Saved := False;
   finally
      Enabled := True;
      web.IndicatorAnimate := False;
      web.Hide();
      arr := dic.ToArray();
      for i := dic.count - 1 downto 0 do begin
         arr[i].Value.Free();
      end;
      web.Release();
      dic.Free();
      list.Free();
   end;
end;

procedure TMainForm.ExportHamlog(f: string);
var
   dlg: TformExportHamlog;
begin
   dlg := TformExportHamlog.Create(Self);
   try
      if dlg.ShowModal() = mrCancel then begin
         Exit;
      end;

      if dlg.InquireJarlMemberInfo = True then begin
         JarlMemberCheck();
      end;

      Log.SaveToFileByHamlog(f, dlg.Remarks1Option, dlg.Remarks2Option, dlg.Remarks1, dlg.Remarks2, dlg.CodeOption, dlg.NameOption, dlg.TimeOption, dlg.QslStateText);
   finally
      dlg.Release();
   end;
end;

procedure TMainForm.SetRigWpm(wpm: Integer);
var
   nID: Integer;
   rig: TRig;
begin
   if dmZLogGlobal.Settings._sync_rig_wpm = False then begin
      Exit;
   end;

   nID := GetTxRigID();
   rig := RigControl.Rigs[nID + 1];
   if rig <> nil then begin
      rig.SetWPM(wpm);
   end;
end;

procedure TMainForm.ExtractSoundFiles(zipfilename: string);
var
   zip: TZipFile;
   filename: string;
   path: string;
   i: Integer;
   bakfile: string;
begin
   zip := TZipFile.Create();
   try
      zip.Open(zipfilename, zmRead);

      for i := 0 to zip.FileCount - 1 do begin
         Application.ProcessMessages();

         filename := zip.FileNames[i];
         path := dmZLogGlobal.SoundPath + filename;

         if FileExists(path) = True then begin
            bakfile := ChangeFileExt(path, '.' + FormatDateTime('yyyymmddhhnnss', Now));
            CopyFile(PChar(path), PChar(bakfile), False);
         end;

         zip.Extract(filename, dmZLogGlobal.SoundPath, True);
      end;

   finally
      zip.Free();
   end;
end;

function TMainForm.CompressSoundFiles(): Boolean;
var
   zip: TZipFile;
   filename: string;
   filelist: TStringList;
   i: Integer;

   procedure dir(strFolder: string; strPattern: string; flist: TStringList);
   var
      F: TSearchRec;
      path: string;
      ret: Integer;
      ext: string;
   begin
      ret := FindFirst(strFolder + strPattern, faAnyFile, f);

      while ret = 0 do begin
         if ((F.Attr and faDirectory) = 0) and
            ((F.Attr and faVolumeID) = 0) and
            ((F.Attr and faSysFile) = 0) then begin
            ext := ExtractFileExt(UpperCase(F.Name));
            if (ext = '.WAV') or (ext = '.MP3') then begin
               path := strFolder + f.Name;
               path := StringReplace(path, '\', '/', [rfReplaceAll]);
               flist.Add(path);
            end;
         end;

         if (f.Attr and faDirectory) <> 0 then begin
            if (f.Name <> '.') and (f.Name <> '..') then begin
               path := IncludeTrailingPathDelimiter(strFolder + f.Name);
               dir(path, strPattern, flist);
            end;
         end;

         ret := FindNext(f);
      end;

      FindClose(f);
   end;
begin
   filelist := TStringList.Create();
   zip := TZipFile.Create();
   try
   try
      filename := dmZLogGlobal.SoundPath + ZLOG_SOUND_FILES;

      if FileExists(filename) = True then begin
         DeleteFile(filename);
      end;

      zip.Open(filename, zmWrite);

      ChDir(dmZLogGlobal.SoundPath);

      dir('', '*.*', filelist);

      for i := 0 to filelist.Count - 1 do begin
         Application.ProcessMessages();

         zip.Add(filelist[i]);
      end;

      zip.Close();

      Result := True;
   except
      on E: Exception do begin
         MessageBox(Handle, PChar(E.Message), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
         Result := False;
      end;
   end;
   finally
      zip.Free();
      filelist.Free();
   end;
end;

procedure TMainForm.SaveLastFreq();
var
   rig: TRig;
begin
   // 現在の周波数とモードを記憶
   rig := RigControl.GetRig(FCurrentRigSet, TextToBand(FEditPanel[FCurrentRigSet - 1].BandEdit.Text));
   if (rig = nil) then begin
      FLastFreq[FCurrentRigSet] := 0;
      FLastMode[FCurrentRigSet] := mCW;
   end
   else begin
      FLastFreq[FCurrentRigSet] := rig.CurrentFreqHz;
      FLastMode[FCurrentRigSet] := rig.CurrentMode;
   end;

   // リグコントロール画面に表示
   RigControl.LastFreq := FLastFreq[FCurrentRigSet];
end;

procedure TMainForm.ShowCtyChk();
var
   f: TformCountryChecker;
begin
   f := TformCountryChecker.Create(Self);
   try
      f.ShowModal();
   finally
      f.Release();
   end;
end;

procedure TMainForm.SetupQTC();
var
   S: string;

   procedure ClearCtrlQ();
   var
      i: Integer;
      shortcut: TShortCut;
   begin
      shortcut := TextToShortCut('CTRL+Q');
      for i := 0 to ActionList1.ActionCount - 1 do begin
         if ActionList1.Actions[i].ShortCut = shortcut then begin
            ActionList1.Actions[i].ShortCut := 0;
            Exit;
         end;
      end;
   end;

   function IsCtrlQAssignedQTC(): Boolean;
   var
      i: Integer;
      shortcut: TShortCut;
   begin
      shortcut := TextToShortCut('CTRL+Q');
      for i := 0 to ActionList1.ActionCount - 1 do begin
         if (ActionList1.Actions[i] <> actionQTC) and (ActionList1.Actions[i].ShortCut = shortcut) then begin
            Result := False;
            Exit;
         end;
         if (ActionList1.Actions[i] = actionQTC) and (ActionList1.Actions[i].ShortCut = shortcut) then begin
            Result := True;
            Exit;
         end;
      end;
      Result := False;
   end;
begin
   if Pos('WAEDC', MyContest.Name) > 0 then begin
      menuQTC.Visible := True;
      actionQTC.Enabled := True;

      // CTRL+Qが他の機能に割り当てられている場合
      if IsCtrlQAssignedQTC() = False then begin
         if MessageBox(Handle, PChar(TMainForm_Assigned_Another_Function), PChar(Application.Title), MB_YESNO or MB_DEFBUTTON2 or MB_ICONEXCLAMATION) = IDYES then begin
            ClearCtrlQ();
            actionQTC.ShortCut := TextToShortCut('CTRL+Q');
         end;
      end;

      // ショートカットの有無チェック
      if actionQTC.ShortCut = 0 then begin
         S := TMainForm_QTC_no_shortcut_keys;
      end
      else begin
         S := Format(TMainForm_QTC_Sent, [ShortCutToText(actionQTC.ShortCut)]);
      end;

      MessageBox(Handle, PChar(S), PChar(Application.Title), MB_ICONEXCLAMATION or MB_OK);
   end
   else begin
      menuQTC.Visible := False;
      actionQTC.Enabled := False;
   end;
end;

{ TBandScopeNotifyThread }

constructor TBandScopeNotifyThread.Create(formParent: TForm; aQSO: TQSO);
begin
   Inherited Create(True);
   FreeOnTerminate := True;
   FParent := formParent;
   FQso := TQSO.Create();
   FQso.Assign(aQSO);
end;

procedure TBandScopeNotifyThread.Execute();
var
   b: TBand;
begin
   with TMainForm(FParent) do begin
      for b := Low(FBandScopeEx) to High(FBandScopeEx) do begin
         FBandScopeEx[b].NotifyWorked(FQso);
      end;
      FBandScope.NotifyWorked(FQso);
      FBandScopeNewMulti.NotifyWorked(FQso);
      FBandScopeAllBands.NotifyWorked(FQso);
   end;

   FQso.Free();
   Terminate();
end;

end.

