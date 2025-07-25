﻿unit UzLogKeyer;

//
// zLog for Windows
// CW Keyer Module
//

// サイドトーンを使用する場合、下記の定義を有効にする 要ToneGen.pas
{$DEFINE USESIDETONE}

interface

uses
  System.SysUtils, System.Classes, Windows, MMSystem, Math, Forms,
  Messages, JvComponentBase, JvHidControllerClass, CPDrv, Generics.Collections,
  System.SyncObjs, System.StrUtils,
  UzLogConst, UzLogGlobal, WinKeyer, UParallelPort
  {$IFDEF USESIDETONE},ToneGen, UzLogSound, Vcl.ExtCtrls{$ENDIF};

const
  charmax = 256;
  codemax = 16;
  MAXWPM = 50;
  MINWPM = 5;
  _inccw = $80;
  _deccw = $81;
  MAXPORT = 4;
  CR = #$0d;
  LF = #$0a;

const
  WM_USER_WKSENDNEXTCHAR = (WM_USER + 1);
  WM_USER_WKCHANGEWPM = (WM_USER + 2);
  WM_USER_WKPADDLE = (WM_USER + 3);
  WM_USER_WKSENDNEXTCHAR2 = (WM_USER + 4);
  WM_USER_POST_PADDLE = (WM_USER + 5);

const
  USBIF4CW_KEY = $01;
  USBIF4CW_PTT = $02;
  USBIF4CW_RIG = $04;
  USBIF4CW_MIC = $08;
  USBIF4CW_KEY_MASK = (not USBIF4CW_KEY);
  USBIF4CW_PTT_MASK = (not USBIF4CW_PTT);
  USBIF4CW_RIG_MASK = (not USBIF4CW_RIG);
  USBIF4CW_MIC_MASK = (not USBIF4CW_MIC);

const
  PARALLEL_KEY = 0;
  PARALLEL_PTT = 1;
  PARALLEL_TX0 = 2;
  PARALLEL_TX1 = 3;
  PARALLEL_RX0 = 4;
  PARALLEL_RX1 = 5;
  PARALLEL_RX2 = 6;
  PARALLEL_BLEND = 7;

type
  TKeyingPort = (tkpNone,
                 tkpSerial1, tkpSerial2, tkpSerial3, tkpSerial4, tkpSerial5,
                 tkpSerial6, tkpSerial7, tkpSerial8, tkpSerial9, tkpSerial10,
                 tkpSerial11, tkpSerial12, tkpSerial13, tkpSerial14, tkpSerial15,
                 tkpSerial16, tkpSerial17, tkpSerial18, tkpSerial19, tkpSerial20,
                 tkpUSB, tkpRIG, tkpParallel);

type
  CodeData = array[1..codemax] of byte;
  CodeTableType = array[0..255] of CodeData;

type
  TdmZLogKeyer = class;
  TWkStatusEvent = procedure(Sender: TObject; tx: Integer; rx: Integer; ptt: Boolean) of object;
  TCommandEvent = procedure(Sender: TObject; nCommand: Integer) of object;

  TKeyerMonitorThread = class(TThread)
  private
    { Private declarations }
    FKeyer: TdmZLogKeyer;
    procedure DotheJob;
  protected
    procedure Execute; override;
  public
    constructor Create(AKeyer: TdmZLogKeyer);
  end;

  TPaddleThread = class(TThread)
  private
    { Private declarations }
    FKeyer: TdmZLogKeyer;
  protected
    procedure Execute; override;
  public
    constructor Create(AKeyer: TdmZLogKeyer);
  end;

  TUsbPortDataArray = array[0..1] of Byte;

  TUsbPortInfo = class
    FPrevUsbPortData: Byte;
    FUsbPortData: Byte;

    FUsbPortIn: TUsbPortDataArray;
    FUsbPortOut: TUsbPortDataArray;

    FPrevPortIn: array[0..7] of Byte;
  public
    constructor Create();
    procedure Clear();
    procedure SetKeyFlag(fOn: Boolean);
    procedure SetPttFlag(fOn: Boolean);
    procedure SetVoiceFlag(flag: Integer);
    procedure SetRigFlag(flag: Integer);
  end;

  TUsbInfo = record
    FUSBIF4CW: TJvHIDDevice;
    FPORTDATA: TUsbPortInfo;
  end;

  TdmZLogKeyer = class(TDataModule)
    ZComKeying1: TCommPortDriver;
    ZComKeying2: TCommPortDriver;
    ZComRxRigSelect: TCommPortDriver;
    ZComKeying3: TCommPortDriver;
    ZComTxRigSelect: TCommPortDriver;
    ZComKeying4: TCommPortDriver;
    ZComKeying5: TCommPortDriver;
    procedure WndMethod(var msg: TMessage);
    procedure DoDeviceChanges(Sender: TObject);
    function DoEnumeration(HidDev: TJvHidDevice; const Index: Integer) : Boolean;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure HidControllerDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
    procedure HidControllerDeviceUnplug(HidDev: TJvHidDevice);
    procedure HidControllerRemoval(HidDev: TJvHidDevice);
    procedure ZComKeying1ReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: DWORD);
    procedure HidControllerDeviceCreateError(Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo; var Handled, RetryCreate: Boolean);
  private
    { Private 宣言 }
    FDefautCom: array[0..MAXPORT] of TCommPortDriver;
    FComKeying: array[0..MAXPORT] of TCommPortDriver;

    FMonitorThread: TKeyerMonitorThread;
    FPaddleThread: TPaddleThread;

    HidController: TJvHidDeviceController;
    usbdevlist: TList<TJvHIDDevice>;
    usbinflist: TList<TUsbPortInfo>;
    FUSBIF4CW_Detected: Boolean;
    FGen3MicSelect: Boolean;

    FUsbInfo: array[0..MAXPORT] of TUsbInfo;

    FParallelPort: TParallelPort;

    // 現在送信中のポートID
    FWkRx: Integer;
    FWkTx: Integer;

    // 現在送信中のRIGSET
    FWkRxRigSet: Integer;
    FWkTxRigSet: Integer;

    FPrevRxRigSet: Integer;
    FPrevRxRigNo: Integer;
    FPrevTxRigSet: Integer;
    FPrevTxRigNo: Integer;

    {$IFDEF USESIDETONE}
    FTone: TSideTone;
    {$ENDIF}

    FUserFlag: Boolean; // can be set to True by user. set to False only when ClrBuffer is called or "  is reached in the sending buffer. // 1.9z2 used in QTCForm
    FVoiceFlag: Integer;  //temporary

    FKeyingPort: array[0..MAXPORT] of TKeyingPort;
    FKeyingPortConfig: array[0..MAXPORT] of TPortConfig;
    FSameOtrsp: Boolean;

    FSpaceFactor: Integer; {space length factor in %}
    FEISpaceFactor: Integer; {space length factor after E and I}

    FSelectedBuf: Integer; {0..2}

    FCWSendBuf: array[0..2, 1..charmax * codemax] of byte;
    FSendChar: Boolean;

    FCodeTable: CodeTableType;

    FInitialized: Boolean;

    FPTTFLAG : Boolean; {internal PTT flag}
    FSendOK : Boolean;{TRUE if OK to send}
    FTune: Boolean;
    FPTTEnabled : Boolean;
    FTimerID : UINT;  {CW timer ID}

    FTimerMilliSec: Integer; //word; {CW timer interval}
    FTimerMicroSec: Integer; //word;{CW timer interval in microsec }
    FKeyingCounter: Integer; // word;      {CW timer counter}

    FPttDelayBeforeCount: Integer;
    FPttDelayAfterCount: Integer;
    FPttHoldCounter: Integer; {counter used to hold PTT in paddle wait}

    FPttDelayBeforeTime: Byte;
    FPttDelayAfterTime: Byte;

    cwstrptr: Integer;
    tailcwstrptr: Integer;
    paddle_waiting: Boolean; {true if ready to receive paddle input}
    mousetail: Integer; {pointer in CWSendBuf}
    p_char_count: Integer; {counter which determines the end of a word}
                           {set in m_set and decremented in $AA }
    mouX, mouY: Integer;  { 1 or 3 dot or dash}

    callsignptr: Integer; {char pos. not absolute pos}

    FDotCount: Integer;
    FDashCount: Integer;
    FBlank1Count: Integer;
    FBlank3Count: Integer;

    FKeyerWPM: Integer; //word;
    FKeyerInitWPM: Integer;
    FKeyerWeight: Integer; //word;
    FUseFixedSpeed: Boolean;
    FFixedSpeed: Integer;
    FBeforeSpeed: Integer;

    FUseSideTone: Boolean;
    FSideToneVolume: Integer;
    FSideTonePitch: Integer;       {side tone pitch}

    FUsePaddleKeyer: Boolean;

    FPaddleReverse: Boolean;
    FPaddleSqueeze: Boolean;

    FOnCallsignSentProc: TNotifyEvent;
    FOnPaddleEvent: TNotifyEvent;
    FOnOneCharSentProc: TNotifyEvent;
    FOnSendFinishProc: TPlayMessageFinishedProc;
    FOnWkStatusProc: TWkStatusEvent;
    FOnSpeedChanged: TNotifyEvent;
    FTemporarySpeedChange: Boolean;
    FOnCommand: TCommandEvent;

    FUsbDetecting: Boolean;
    FUsbif4cwSyncWpm: Boolean;

    // WinKeyer and SO2R Neo support
    FUseWinKeyer: Boolean;
    FUseWk9600: Boolean;
    FUseWkOutpSelect: Boolean;
    FUseWkIgnoreSpeedPot: Boolean;
    FUseWkAlways9600: Boolean;
    FWkInitializeMode: Boolean;
    FWkRevision: Integer;
    FWkStatus: Integer;
    FWkEcho: Integer;
    FWkLastMessage: string;
    FWkCallsignIndex: Integer;
    FWkCallsignStr: string;
    FWkAbort: Boolean;
    FWkLastSendChar: Char;
    FSo2rNeoCanRxSel: Boolean;
    FSo2rNeoUseRxSelect: Boolean;
    FWkMessageIndex: Integer;
    FWkMessageStr: string;
    FWkSendStatus: TWinKeyerSendStatus;

    // SO2R support
    FSo2rType: TSo2rType;
    FSo2rRxSelectPort: TKeyingPort;
    FSo2rTxSelectPort: TKeyingPort;
    FSo2rTxRigC: Integer;
    FRigSelectV28: Boolean;
    FSo2rOtrspPort: TKeyingPort;

    FWnd: HWND;

    FUseCanSend: Boolean;
    FPrevDSR: Boolean;

    // TX select sub
    procedure SetTxRigFlag_com(rigset: Integer);
    procedure SetTxRigFlag_com_v28(rigset: Integer);
    procedure SetTxRigFlag_so2rneo(rigset: Integer);
    procedure SetTxRigFlag_usbif4cw(rigset: Integer);
    procedure SetTxRigFlag_otrsp(rigset: Integer);
    procedure SetTxRigFlag_parallel(rigset, rigno: Integer);

    // RX select sub
    procedure SetRxRigFlag_com(rigset, rigno: Integer);
    procedure SetRxRigFlag_com_v28(rigset, rigno: Integer);
    procedure SetRxRigFlag_so2rneo(rigset, rigno: Integer);
    procedure SetRxRigFlag_otrsp(rigset, rigno: Integer);
    procedure SetRxRigFlag_parallel(rigset, rigno: Integer; both: Boolean);

    procedure Sound();
    procedure NoSound();

    procedure SetCWSendBufChar(b: Integer; C: Char); {Adds a char to the end of buffer}
    procedure SetCWSendBufFinish(b: Integer);
    function DecodeCommands(S: string): string;
    procedure CW_ON(nID: Integer);
    procedure CW_OFF(nID: Integer);
    function CanSend(nID: Integer): Boolean;
    procedure TimerProcess(uTimerID, uMessage: Word; dwUser, dw1, dw2: Longint); stdcall;
    procedure IncWPM; {Increases CW speed by 1WPM}
    procedure DecWPM; {Decreases CW speed by 1WPM}
    procedure ChangeWPM(sign: Integer; change: Integer);
    procedure SetCWSendBufChar2(C: char; CharPos: word);
    procedure ExpandCWSendBuffer(b: Integer; SS: string);

    procedure SetWPM(wpm: Integer); {Sets CW speed 1-60 wpm}
    procedure SetSideTonePitch(Hertz: Integer); {Sets the pitch of the side tone}
    procedure SetSpaceFactor(R: Integer);
    procedure SetEISpaceFactor(R: Integer);
    function  GetKeyingPort(Index: Integer): TKeyingPort;
    procedure SetKeyingPort(Index: Integer; port: TKeyingPort);
    procedure SendUsbPortData(nID: Integer);
    procedure COM_ON();
    procedure COM_OFF();
    procedure USB_ON();
    procedure USB_OFF();
    procedure SetUseSideTone(fUse: Boolean);
    procedure SetSideToneVolume(v: Integer);

    procedure m_set(b: Byte);

    procedure WinKeyerOpen(nPort: TKeyingPort);
    procedure WinKeyerClose();
    procedure WinKeyerSetSpeed(nWPM: Integer);
    procedure WinKeyerSetSideTone(fOn: Boolean);
//    procedure WinKeyerSetPinCfg(fUsePttPort: Boolean);
    procedure WinKeyerSetPTTDelay(before, after: Byte);
    procedure WinKeyerSetMode(mode: Byte);

    procedure SetSo2rRxSelectPort(port: TKeyingPort);
    procedure SetSo2rTxSelectPort(port: TKeyingPort);
    procedure SetSo2rOtrspPort(port: TKeyingPort);

    function GetKeyingPortConfig(Index: Integer): TPortConfig;
    procedure SetKeyingPortConfig(Index: Integer; v: TPortConfig);
    procedure DumpSendBuf();
    procedure SetOtrspPortParam(CP: TCommPortDriver);
    procedure WinKeyerSleep(dwMilidec: DWORD);
  public
    { Public 宣言 }
    procedure InitializeBGK(msec: Integer); {Initializes BGK. msec is interval}
    procedure CloseBGK; {Closes BGK}

    function PTTIsOn : Boolean;
    function IsPlaying : Boolean;
    function Paused : Boolean; {Returns True if SendOK is False}
    function CallSignSent : Boolean; {Returns True if realtime callsign is sent already}

    procedure ControlPTT(nID: Integer; PTTON : Boolean; fPhonePTT: Boolean = False); {Sets PTT on/off}
    procedure ResetPTT();
    procedure TuneOn(nID: Integer);

    procedure SetCallSign(S: string); {Update realtime callsign}
    procedure ClrBuffer; {Stops CW and clears buffer}
    procedure CancelLastChar; {BackSpace}

    procedure PauseCW; {Pause}
    procedure ResumeCW; {Resume}

    procedure SendStr(nID: Integer; sStr: string); {Sends a string (Overwrites buffer)}
    procedure SendStrFIFO(nID: Integer; sStr: string); {Sends a string (adds to buffer)}

    procedure SetCWSendBuf(b: byte; S: string); {Sets str to buffer but does not start sending}
    procedure SetCWSendBufCharPTT(nID: Integer; C: char); {Adds a char to the end of buffer. Also controls PTT if enabled. Called from Keyboard}

    // TX select
    procedure SetTxRigFlag(rigset, rigno: Integer; mode: TMode); // 0 : no rigs, 1 : rig 1, etc

    // RX select
    procedure SetRxRigFlag(rigset, rigno: Integer; fForce: Boolean = False);

    // Voice select
    procedure SetVoiceFlag(flag: Integer); // 0 : no rigs, 1 : rig 1, etc

    // Antenna select
    procedure AntSelect(rigset, ant_no: Integer);

    procedure SetPTT(_on : Boolean);
    procedure SetPTTDelay(before, after : word);
    procedure SetWeight(W : word); {Sets the weight 0-100 %}

    property WPM: Integer read FKeyerWPM write SetWPM;
    property InitWPM: Integer read FKeyerInitWPM write FKeyerInitWPM;
    property UseSideTone: Boolean read FUseSideTone write SetUseSideTone;
    property SideToneVolume: Integer read FSideToneVolume write SetSideToneVolume;
    property SideTonePitch: Integer read FSideTonePitch write SetSideTonePitch;
    property SideTone: TSideTone read FTone;
    property SpaceFactor: Integer read FSpaceFactor write SetSpaceFactor;
    property EISpaceFactor: Integer read FEISpaceFactor write SetEISpaceFactor;

    property USBIF4CW_Detected: Boolean read FUSBIF4CW_Detected;
    property UserFlag: Boolean read FUserFlag write FUserFlag;
    property KeyingPort[Index: Integer]: TKeyingPort read GetKeyingPort write SetKeyingPort;

    property OnCallsignSentProc: TNotifyEvent read FOnCallsignSentProc write FOnCallsignSentProc;
    property OnPaddle: TNotifyEvent read FOnPaddleEvent write FOnPaddleEvent;
    property OnOneCharSentProc: TNotifyEvent read FOnOneCharSentProc write FOnOneCharSentProc;
    property OnSendFinishProc: TPlayMessageFinishedProc read FOnSendFinishProc write FOnSendFinishProc;
    property OnSpeedChanged: TNotifyEvent read FOnSpeedChanged write FOnSpeedChanged;
    property OnWkStatusProc: TWkStatusEvent read FOnWkStatusProc write FOnWkStatusProc;
    property OnCommand: TCommandEvent read FOnCommand write FOnCommand;
    property KeyingPortConfig[Index: Integer]: TPortConfig read GetKeyingPortConfig write SetKeyingPortConfig;

    property Usbif4cwSyncWpm: Boolean read FUsbif4cwSyncWpm write FUsbif4cwSyncWpm;
    property UsePaddleKeyer: Boolean read FUsePaddleKeyer write FUsePaddleKeyer;
    property PaddleReverse: Boolean read FPaddleReverse write FPaddleReverse;
    property Gen3MicSelect: Boolean read FGen3MicSelect write FGen3MicSelect;
    property UseCanSend: Boolean read FUseCanSend write FUseCanSend;

    // paddle support
    procedure PaddleProc(PaddleStatus: Byte);

    // USBIF4CW support
    function usbif4cwSetWPM(nID: Integer; nWPM: Integer): Long;
    function usbif4cwSetPTTParam(nId: Integer; nLen1: Byte; nLen2: Byte): Long;
    function usbif4cwSetPTT(nId: Integer; tx: Byte): Long;
    function usbif4cwGetVersion(nId: Integer): Long;
    function usbif4cwSetPaddle(nId: Integer; param: Byte): Long;
    procedure usbif4cwSetPort(port: Integer; value: Boolean);

    // 1Port Control support
    procedure SetCommPortDriver(Index: Integer; CP: TCommPortDriver);
    procedure ResetCommPortDriver(Index: Integer; port: TKeyingPort);

    // WinKeyer support
    property UseWinKeyer: Boolean read FUseWinKeyer write FUseWinKeyer;
    property UseWk9600: Boolean read FUseWk9600 write FUseWk9600;
    property UseWkOutpSelect: Boolean read FUseWkOutpSelect write FUseWkOutpSelect;
    property UseWkIgnoreSpeedPot: Boolean read FUseWkIgnoreSpeedPot write FUseWkIgnoreSpeedPot;
    property UseWkAlways9600: Boolean read FUseWkAlways9600 write FUseWkAlways9600;
    property WinKeyerRevision: Integer read FWkRevision;
    procedure WinKeyerSendCharEx(C: Char);
    procedure WinKeyerSendChar(C: Char);
    procedure WinKeyerSendStr(nID: Integer; S: string);
    procedure WinKeyerSendStr2(S: string);
    function WinKeyerBuildMessage(S: string): string;
    procedure WinKeyerControlPTT(fOn: Boolean);
    procedure WinKeyerAbort();
    procedure WinKeyerClear();
    procedure WinKeyerCancelLastChar();
    procedure WinKeyerSendCommand(cmd: Byte; p1: Byte);
    procedure WinKeyerSendMessage(S: string);
    procedure WinKeyerTuneOn();
    procedure WinKeyerTuneOff();
    procedure WinKeyerSetPinCfg(fUsePttPort: Boolean);

    // SO2R support
    property So2rType: TSo2rType read FSo2rType write FSo2rType;
    property So2rRigSelectV28: Boolean read FRigSelectV28 write FRigSelectV28;
    property So2rRxSelectPort: TKeyingPort read FSo2rRxSelectPort write SetSo2rRxSelectPort;
    property So2rTxSelectPort: TKeyingPort read FSo2rTxSelectPort write SetSo2rTxSelectPort;
    property So2rTxRigC: Integer read FSo2rTxRigC write FSo2rTxRigC;
    property So2rOtrspPort: TKeyingPort read FSo2rOtrspPort write SetSo2rOtrspPort;

    // SO2R Neo support
    property So2rNeoUseRxSelect: Boolean read FSo2rNeoUseRxSelect write FSo2rNeoUseRxSelect;
    procedure So2rNeoSetAudioBlendMode(fOn: Boolean);
    procedure So2rNeoSetAudioBlendRatio(ratio: Integer);
    procedure So2rNeoSwitchRig(tx: Integer; rx: Integer);
    procedure So2rNeoReverseRx(tx: Integer);
    procedure So2rNeoNormalRx(tx: Integer);
    property So2rNeoCanRxSel: Boolean read FSo2rNeoCanRxSel write FSo2rNeoCanRxSel;

    // Parallel port support
    procedure ParallelSetAudioBothMode(fOn: Boolean);
    procedure ParallelSetAudioBlendMode(fOn: Boolean);

    procedure IncCWSpeed();
    procedure DecCWSpeed();
    procedure ToggleFixedSpeed();
    procedure ResetSpeed();
    property FixedSpeed: Integer read FFixedSpeed write FFixedSpeed;

    property ParallelPort: TParallelPort read FParallelPort;

    procedure Open();
    procedure Close();
  end;

var
  dmZLogKeyer: TdmZLogKeyer;
  CWBufferSync: TCriticalSection;
  UsbPortDataLock: TCriticalSection;

const
  USBIF4CW_VENDORID = $BFE;
  USBIF4CW_PRODID = $E00;

const
  BGKCALLMAX = 16;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TimerCallback(uTimerID, uMessage: word; dwUser, dw1, dw2: Longint); stdcall;
begin
   dmZLogKeyer.TimerProcess(uTimerID, uMessage, dwUser, dw1, dw2);
end;

procedure TdmZLogKeyer.DataModuleCreate(Sender: TObject);
var
   i: Integer;
begin
   FInitialized := False;
   FDefautCom[0] := ZComKeying1;
   FDefautCom[1] := ZComKeying2;
   FDefautCom[2] := ZComKeying3;
   FDefautCom[3] := ZComKeying4;
   FDefautCom[4] := ZComKeying5;
   FComKeying[0] := FDefautCom[0];
   FComKeying[1] := FDefautCom[1];
   FComKeying[2] := FDefautCom[2];
   FComKeying[3] := FDefautCom[3];
   FComKeying[4] := FDefautCom[4];
   FUseWinKeyer := False;
   FUseWk9600 := False;
   FUseWkOutpSelect := True;
   FUseWkIgnoreSpeedPot := False;
   FUseWkAlways9600 := False;
   FOnSpeedChanged := nil;
   FTemporarySpeedChange := False;
   FOnCommand := nil;
   FUseFixedSpeed := False;
   FBeforeSpeed := 0;
   FFixedSpeed := 0;
   FSo2rType := so2rNone;
   FSo2rNeoCanRxSel := False;
   FSo2rNeoUseRxSelect := False;
   FSo2rRxSelectPort := tkpNone;
   FSo2rTxSelectPort := tkpNone;
   FSo2rTxRigC := 0;
   FRigSelectV28 := False;
   FSo2rOtrspPort := tkpNone;
   FSameOtrsp := False;
   FTune := False;
   FUseCanSend := False;
   FPrevDSR := True;

   FWnd := AllocateHWnd(WndMethod);
   usbdevlist := TList<TJvHidDevice>.Create();
   usbinflist := TList<TUsbPortInfo>.Create();

   {$IFDEF USESIDETONE}
   if TSideTone.NumDevices() = 0 then begin
      FTone := nil;
   end
   else begin
      FTone := TSideTone.Create(700);
   end;
   {$ENDIF}

   HidController := TJvHidDeviceController.Create(Self, HidControllerDeviceCreateError, nil);
   HidController.OnDeviceChange := DoDeviceChanges;
   HidController.OnDeviceData := HidControllerDeviceData;
   HidController.OnDeviceUnplug := HidControllerDeviceUnplug;
   HidController.OnRemoval := HidControllerRemoval;
   HidController.OnEnumerate := DoEnumeration;
   FUSBIF4CW_Detected := False;

   for i := 0 to MAXPORT do begin
      FUsbInfo[i].FUSBIF4CW := nil;
      FUsbInfo[i].FPORTDATA := nil;
   end;

   FParallelPort := TParallelPort.Create();

   FUserFlag := False;
   FVoiceFlag := 0;

   FWkTx := 0;
   FWkRx := 0;
   FWkTxRigSet := 0;
   FWkRxRigSet := 0;

   FPrevRxRigSet := 0;
   FPrevRxRigNo := 0;
   FPrevTxRigSet := 0;

   FSpaceFactor := 100; {space length factor in %}
   FEISpaceFactor := 100; {space length factor after E and I}

   FMonitorThread := nil;
   FPaddleThread := nil;
   FOnCallsignSentProc := nil;
   FOnOneCharSentProc := nil;
   FOnSendFinishProc := nil;
   FOnPaddleEvent := nil;
   FUsbif4cwSyncWpm := False;
   FGen3MicSelect := False;

   for i := 0 to MAXPORT do begin
      KeyingPort[i] := tkpNone;
      FKeyingPortConfig[i].FRts := paPtt;
      FKeyingPortConfig[i].FDtr := paKey;
   end;

   tailcwstrptr := 1;
   cwstrptr := 0;
end;

procedure TdmZLogKeyer.DataModuleDestroy(Sender: TObject);
var
   i: Integer;
begin
   {$IFDEF USESIDETONE}
   FTone.Free();
   {$ENDIF}
   FMonitorThread.Free();
   FPaddleThread.Free();
   COM_OFF();
   USB_OFF();
   FParallelPort.Close();
   DeallocateHWnd(FWnd);
   usbdevlist.Free();

   for i := 0 to usbinflist.Count -1 do begin
      usbinflist[i].Free();
   end;
   usbinflist.Free();

   HidController.Free();
   FParallelPort.Free();
end;

// Device抜去時、Unplug->Removal->Changeの順でfire eventする
procedure TdmZLogKeyer.DoDeviceChanges(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('***HidControllerDeviceChanges()***'));
   {$ENDIF}

   Open();
end;

function TdmZLogKeyer.DoEnumeration(HidDev: TJvHidDevice; const Index: Integer) : Boolean;
begin
   FUsbDetecting := True;
   try
      // FNumUsbif4cw := HidController.CountByID(USBIF4CW_VENDORID, USBIF4CW_PRODID);

      if (HidDev.Attributes.ProductID = USBIF4CW_PRODID) and
         (HidDev.Attributes.VendorID = USBIF4CW_VENDORID) then begin
         if HidDev.CheckOut() = True then begin
            HidDev.OpenFile();
            usbdevlist.Add(HidDev);
            usbinflist.Add(TUsbPortInfo.Create());
            FUSBIF4CW_Detected := True;
         end;
      end;

      Result := True;
   finally
      FUsbDetecting := False;
   end;
end;

procedure TdmZLogKeyer.HidControllerDeviceCreateError(
  Controller: TJvHidDeviceController; PnPInfo: TJvHidPnPInfo; var Handled,
  RetryCreate: Boolean);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('***HidControllerDeviceCreateError()***'));
   OutputDebugString(PChar('***[' + PnPInfo.DevicePath + ']***'));
   OutputDebugString(PChar('***[' + IntToHex(PnPInfo.DeviceID, 8) + ']***'));
   OutputDebugString(PChar('***[' + PnPInfo.DeviceDescr + ']***'));
   OutputDebugString(PChar('***[' + PnPInfo.Driver + ']***'));
   OutputDebugString(PChar('***[' + PnPInfo.HardwareID.Text + ']***'));
   OutputDebugString(PChar('***[' + PnPInfo.Service + ']***'));
   {$ENDIF}

   Handled := True;
end;

procedure TdmZLogKeyer.HidControllerDeviceData(HidDev: TJvHidDevice;
  ReportID: Byte; const Data: Pointer; Size: Word);
var
   {$IFDEF DEBUG}
   s: string;
   {$ENDIF}
   p: PBYTE;
   nID: BYTE;
   fPaddleRight: Boolean;
   fPaddleLeft: Boolean;
begin
   if (FKeyingPort[0] <> tkpUSB) and
      (FKeyingPort[1] <> tkpUSB) and
      (FKeyingPort[2] <> tkpUSB) and
      (FKeyingPort[3] <> tkpUSB) and
      (FKeyingPort[4] <> tkpUSB) then begin
      Exit;
   end;

   p := Data;

   if FUsbInfo[0].FUSBIF4CW = HidDev then begin
      nID := 0;
   end
   else if FUsbInfo[1].FUSBIF4CW = HidDev then begin
      nID := 1;
   end
   else if FUsbInfo[2].FUSBIF4CW = HidDev then begin
      nID := 2;
   end
   else if FUsbInfo[3].FUSBIF4CW = HidDev then begin
      nID := 3;
   end
   else if FUsbInfo[4].FUSBIF4CW = HidDev then begin
      nID := 4;
   end
   else begin
      Exit;
   end;
   {$IFDEF DEBUG}
//   OutputDebugString(PChar('**ID=[' + IntToStr(nID) + ']**'));
   {$ENDIF}

   {$IFDEF DEBUG}
   s := IntToHex(p[0], 2) + ' ' +
        IntToHex(p[1], 2) + ' ' +
        IntToHex(p[2], 2) + ' ' +
        IntToHex(p[3], 2) + ' ' +
        IntToHex(p[4], 2) + ' ' +
        IntToHex(p[5], 2) + ' ' +
        IntToHex(p[6], 2) + ' ' +
        IntToHex(p[7], 2);
   {$ENDIF}

   // 前回とステータスに変化があったら
   if (p[0] <> FUsbInfo[nID].FPORTDATA.FPrevPortIn[0]) or
      (p[1] <> FUsbInfo[nID].FPORTDATA.FPrevPortIn[1]) or
      (p[2] <> FUsbInfo[nID].FPORTDATA.FPrevPortIn[2]) or
      (p[3] <> FUsbInfo[nID].FPORTDATA.FPrevPortIn[3]) or
      (p[4] <> FUsbInfo[nID].FPORTDATA.FPrevPortIn[4]) or
      (p[5] <> FUsbInfo[nID].FPORTDATA.FPrevPortIn[5]) or
      (p[6] <> FUsbInfo[nID].FPORTDATA.FPrevPortIn[6]) or
      (p[7] <> FUsbInfo[nID].FPORTDATA.FPrevPortIn[7]) then begin
      {$IFDEF DEBUG}
//      OutputDebugString(PChar('***HidControllerDeviceData*** ReportID=' + IntToHex(ReportID,2) + ' DATA=' + s));
      {$ENDIF}

      // Port Data In
      FUsbInfo[nID].FPORTDATA.FUsbPortIn[0] := p[6];
      FUsbInfo[nID].FPORTDATA.FUsbPortIn[1] := p[7];

      // パドル状況
      fPaddleRight := (FUsbInfo[nID].FPORTDATA.FUsbPortIn[1] and $04) = 0;
      fPaddleLeft := (FUsbInfo[nID].FPORTDATA.FUsbPortIn[1] and $01) = 0;

      if ((FUsePaddleKeyer = False) and (usbif4cwGetVersion(nID) >= 20)) then begin
         // パドル入力があったか？
         if fPaddleRight or fPaddleLeft then begin
            {$IFDEF DEBUG}
            OutputDebugString(PChar('**PADDLE IN**'));
            {$ENDIF}

            // fire event
            if Assigned(FOnPaddleEvent) then begin
               FOnPaddleEvent(Self);
            end;
         end;
      end;

      CopyMemory(@FUsbInfo[nID].FPORTDATA.FPrevPortIn, p, 8);
   end;
end;

procedure TdmZLogKeyer.HidControllerDeviceUnplug(HidDev: TJvHidDevice);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('***HidControllerDeviceUnplug()***'));
   {$ENDIF}
end;

procedure TdmZLogKeyer.HidControllerRemoval(HidDev: TJvHidDevice);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('***HidControllerRemoval()***'));
   {$ENDIF}
end;

procedure TdmZLogKeyer.SetTxRigFlag(rigset, rigno: Integer; mode: TMode); // 0 : no rigs, 1 : rig 1, etc
begin
   if (rigset = 0) or (rigset = 1) then begin
      FWkTxRigSet := 0;
   end
   else if (rigset = 2) then begin
      FWkTxRigSet := 1;
   end
   else begin
      FWkTxRigSet := 2;
   end;

   case FSo2rType of
      so2rNone: begin
         // USBIF4CWでのRIG SELECT
         SetTxRigFlag_usbif4cw(rigset);

         // WinKeyerの場合
         if (FKeyingPort[0] in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = True) then begin
            if mode = mCW then begin
               WinKeyerSetPinCfg(True);
            end
            else begin
               WinKeyerSetPinCfg(False);
            end;
         end;
      end;

      // COMポートでのRIG SELECT
      so2rCom: begin
         if (FSo2rTxSelectPort in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = False) then begin
            if FRigSelectV28 = True then begin
               SetTxRigFlag_com_v28(rigset);
            end
            else begin
               SetTxRigFlag_com(rigset);
            end;
         end;
      end;

      // SO2R Neoの場合
      so2rNeo: begin
         if (FKeyingPort[0] in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = True) then begin
            SetTxRigFlag_so2rneo(rigset);
         end;
      end;

      // OTRSPの場合
      so2rOtrsp: begin
         // 前回と同じrigsetなら出力しない
         if (FPrevTxRigSet = rigset) and (FPrevTxRigNo = rigno) then begin
            Exit;
         end;
         if (FSo2rOtrspPort in [tkpSerial1..tkpSerial20]) then begin
            SetTxRigFlag_otrsp(rigset);
         end;
      end;

      // パラレルポートの場合
      so2rParallel: begin
         SetTxRigFlag_parallel(rigset, rigno);
      end;
   end;

   FPrevTxRigSet := rigset;
   FPrevTxRigNo := rigno;
end;

procedure TdmZLogKeyer.SetTxRigFlag_com(rigset: Integer); // 0 : no rigs, 1 : rig 1, etc
   procedure SelectRigA();
   begin
      ZComTxRigSelect.ToggleDTR(False);
      ZComTxRigSelect.ToggleRTS(False);
   end;

   procedure SelectRigB();
   begin
      ZComTxRigSelect.ToggleDTR(True);
      ZComTxRigSelect.ToggleRTS(False);
   end;

   procedure SelectRigC();
   begin
      ZComTxRigSelect.ToggleDTR(False);
      ZComTxRigSelect.ToggleRTS(True);
   end;
begin
   case rigset of
      // RIG-A
      0, 1: begin
         SelectRigA();
      end;

      // RIG-B
      2: begin
         SelectRigB();
      end;

      // RIG-C
      else begin
         case FSo2rTxRigC of
            // RIG-C
            0: begin
               SelectRigC();
            end;

            // Same RIG-A
            1: begin
               SelectRigA();
            end;

            // Same RIG-B
            2: begin
               SelectRigB();
            end;
         end;
      end;
   end;
end;

procedure TdmZLogKeyer.SetTxRigFlag_com_v28(rigset: Integer);
begin
   case rigset of
      0: begin
         ZComTxRigSelect.ToggleDTR(False);
         ZComTxRigSelect.ToggleRTS(False);
      end;

      1: begin
         ZComTxRigSelect.ToggleDTR(True);
         ZComTxRigSelect.ToggleRTS(False);
      end;

      2: begin
         ZComTxRigSelect.ToggleDTR(False);
         ZComTxRigSelect.ToggleRTS(True);
      end;

      3: begin
         ZComTxRigSelect.ToggleDTR(True);
         ZComTxRigSelect.ToggleRTS(True);
      end;
   end;
end;

procedure TdmZLogKeyer.SetTxRigFlag_so2rneo(rigset: Integer);
begin
   if rigset = 2 then begin
      So2rNeoSwitchRig(1, FWkRxRigSet);
   end
   else begin
      So2rNeoSwitchRig(0, FWkRxRigSet);
   end;
end;

procedure TdmZLogKeyer.SetTxRigFlag_usbif4cw(rigset: Integer);
var
   i: Integer;
begin
   for i := 0 to MAXPORT do begin
      if FKeyingPort[i] = tkpUSB then begin
         if Assigned(FUsbInfo[i].FPORTDATA) then begin
            UsbPortDataLock.Enter();
            FUsbInfo[i].FPORTDATA.SetRigFlag(FWkTxRigSet);
            if FGen3MicSelect = False then begin
               FUsbInfo[i].FPORTDATA.SetVoiceFlag(FWkTxRigSet);
            end;
            SendUsbPortData(i);
            UsbPortDataLock.Leave();
         end;
      end;
   end;
end;

procedure TdmZLogKeyer.SetTxRigFlag_otrsp(rigset: Integer);
begin
   if rigset = 1 then begin
      ZComTxRigSelect.SendString('TX1' + CR);
   end;
   if rigset = 2 then begin
      ZComTxRigSelect.SendString('TX2' + CR);
   end;
end;

procedure TdmZLogKeyer.SetTxRigFlag_parallel(rigset, rigno: Integer);
begin
   case rigno of
      1: begin
         FParallelPort.ResetBit(PARALLEL_TX0);
         FParallelPort.ResetBit(PARALLEL_TX1);
      end;

      2: begin
         FParallelPort.ResetBit(PARALLEL_TX0);
         FParallelPort.SetBit(PARALLEL_TX1);
      end;

      3: begin
         FParallelPort.SetBit(PARALLEL_TX0);
         FParallelPort.ResetBit(PARALLEL_TX1);
      end;

      4: begin
         FParallelPort.SetBit(PARALLEL_TX0);
         FParallelPort.SetBit(PARALLEL_TX1);
      end;
   end;

   FParallelPort.Write();
end;

//
// rigset 1: 左
//        2: 右
// rigno  1: HF
//        2: VU
//        3: HF
//        4: VU
//
procedure TdmZLogKeyer.SetRxRigFlag(rigset, rigno: Integer; fForce: Boolean);
begin
   if (rigset = 0) or (rigset = 1) then begin
      FWkRxRigSet := 0;
   end
   else if (rigset = 2) then begin
      FWkRxRigSet := 1;
   end
   else begin
      FWkRxRigSet := 2;
   end;

   case FSo2rType of
      so2rNone: begin

      end;

      // COMポートでのRIG SELECT
      so2rCom: begin
         if (FSo2rRxSelectPort in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = False) then begin
            if FRigSelectV28 = True then begin
               SetRxRigFlag_com_v28(rigset, rigno);
            end
            else begin
               SetRxRigFlag_com(rigset, rigno);
            end;
         end;
      end;

      // SO2R Neoの場合
      so2rNeo: begin
         if (FKeyingPort[0] in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = True) then begin
            SetRxRigFlag_so2rneo(rigset, rigno);
         end;
      end;

      // OTRSPの場合
      so2rOtrsp: begin
         // 前回と同じrigsetなら出力しない
         if (FPrevRxRigSet = rigset) and (FPrevRxRigNo = rigno) and (fForce = False) then begin
            Exit;
         end;

         if (FSo2rOtrspPort in [tkpSerial1..tkpSerial20]) then begin
            SetRxRigFlag_otrsp(rigset, rigno);
         end;
      end;

      // パラレルポートの場合
      so2rParallel: begin
         SetRxRigFlag_parallel(rigset, rigno, False);
      end;
   end;

   FPrevRxRigSet := rigset;
   FPrevRxRigNo := rigno;
end;

procedure TdmZLogKeyer.SetRxRigFlag_com(rigset, rigno: Integer);
begin
   // 左右選択
   case rigset of
      // 左
      1: begin
         case rigno of
            // HF
            1, 3: begin
               ZComRxRigSelect.ToggleDTR(False);
            end;

            // VU
            2, 4: begin
               ZComRxRigSelect.ToggleDTR(True);
            end;
         end;
      end;

      // 右
      2: begin
         case rigno of
            // HF
            1, 3: begin
               ZComRxRigSelect.ToggleRTS(False);
            end;

            // VU
            2, 4: begin
               ZComRxRigSelect.ToggleRTS(True);
            end;
         end;
      end;

      // 下
      else begin
         // 左
         case rigno of
            // HF
            1, 3: begin
               ZComRxRigSelect.ToggleDTR(False);
            end;

            // VU
            2, 4: begin
               ZComRxRigSelect.ToggleDTR(True);
            end;
         end;

         // 右
         ZComRxRigSelect.ToggleRTS(True);
      end;
   end;
end;

procedure TdmZLogKeyer.SetRxRigFlag_com_v28(rigset, rigno: Integer);
begin
   case rigset of
      0: begin
         ZComRxRigSelect.ToggleDTR(False);
         ZComRxRigSelect.ToggleRTS(False);
      end;

      1: begin
         ZComRxRigSelect.ToggleDTR(True);
         ZComRxRigSelect.ToggleRTS(False);
      end;

      2: begin
         ZComRxRigSelect.ToggleDTR(False);
         ZComRxRigSelect.ToggleRTS(True);
      end;

      3: begin
         ZComRxRigSelect.ToggleDTR(True);
         ZComRxRigSelect.ToggleRTS(True);
      end;
   end;
end;

procedure TdmZLogKeyer.SetRxRigFlag_so2rneo(rigset, rigno: Integer);
begin
   if rigset = 2 then begin
      So2rNeoSwitchRig(FWkTxRigSet, 1);
   end
   else begin
      So2rNeoSwitchRig(FWkTxRigSet, 0);
   end;
end;

procedure TdmZLogKeyer.SetRxRigFlag_otrsp(rigset, rigno: Integer);
begin
   if rigset = 1 then begin
      ZComTxRigSelect.SendString('RX1' + CR);
   end;
   if rigset = 2 then begin
      ZComTxRigSelect.SendString('RX2' + CR);
   end;
end;

procedure TdmZLogKeyer.SetRxRigFlag_parallel(rigset, rigno: Integer; both: Boolean);
begin
   if both = True then begin
      FParallelPort.SetBit(PARALLEL_RX0);
   end
   else begin
      FParallelPort.ResetBit(PARALLEL_RX0);
   end;

   case rigset of
      1: begin
         case rigno of
            1: begin
               FParallelPort.ResetBit(PARALLEL_RX1);
               FParallelPort.ResetBit(PARALLEL_RX2);
            end;

            3: begin
               FParallelPort.ResetBit(PARALLEL_RX1);
               FParallelPort.SetBit(PARALLEL_RX2);
            end;
         end;
      end;

      2: begin
         case rigno of
            2: begin
               FParallelPort.SetBit(PARALLEL_RX1);
               FParallelPort.ResetBit(PARALLEL_RX2);
            end;

            4: begin
               FParallelPort.SetBit(PARALLEL_RX1);
               FParallelPort.SetBit(PARALLEL_RX2);
            end;
         end;
      end;
   end;
   FParallelPort.Write();
end;

procedure TdmZLogKeyer.SetVoiceFlag(flag: Integer); // 0 : no rigs, 1 : rig 1, etc
var
   i: Integer;
begin
   if FGen3MicSelect = False then begin
      Exit;
   end;

   // USBIF4CW gen.3による音声選択
   for i := 0 to MAXPORT do begin
      if FKeyingPort[i] = tkpUSB then begin
         UsbPortDataLock.Enter();
         if Assigned(FUsbInfo[i].FPORTDATA) then begin
            FUsbInfo[i].FPORTDATA.SetVoiceFlag(flag);
            SendUsbPortData(i);
         end;
         UsbPortDataLock.Leave();
      end;
   end;
end;

procedure TdmZLogKeyer.AntSelect(rigset, ant_no: Integer);
begin
   case FSo2rType of
      so2rOtrsp: begin
         ZComTxRigSelect.SendString(AnsiString('AUX' + IntToStr(rigset) + RightStr('00' + IntToStr(ant_no), 2) + CR));
      end;
   end;
end;

procedure TdmZLogKeyer.Sound();
begin
   {$IFDEF USESIDETONE}
   if Assigned(FTone) then begin
      FTone.Play();
   end;
   {$ENDIF}
end;

procedure TdmZLogKeyer.NoSound();
begin
   {$IFDEF USESIDETONE}
   if Assigned(FTone) then begin
      FTone.Stop();
   end;
   {$ENDIF}
end;

procedure TdmZLogKeyer.ControlPTT(nID: Integer; PTTON: Boolean; fPhonePTT: Boolean);
begin
   try
      FPTTFLAG := PTTON;
      FWkTx := nID;

      // USBIF4CW
      if FKeyingPort[nID] = tkpUSB then begin
         UsbPortDataLock.Enter();
         if Assigned(FUsbInfo[nID].FPORTDATA) then begin
            FUsbInfo[nID].FPORTDATA.SetPttFlag(PTTON);
            if UsePaddleKeyer = False then begin
               SendUsbPortData(nID);
            end;
         end;
         UsbPortDataLock.Leave();
         Exit;
      end;

      // COM port
      if (FKeyingPort[nID] in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = False) then begin
         if FKeyingPortConfig[nID].FRts = paPtt then begin
            if fPhonePTT = False then begin
               FComKeying[nID].ToggleRTS(PTTON);   // CW
            end
            else begin
               FComKeying[nID].ToggleDTR(PTTON);   // PH
            end;
         end;
         if FKeyingPortConfig[nID].FDtr = paPtt then begin
            if fPhonePTT = False then begin
               FComKeying[nID].ToggleDTR(PTTON);   // CW
            end
            else begin
               FComKeying[nID].ToggleRTS(PTTON);   // PH
            end;
         end;
         Exit;
      end;

      // WinKeyer
      if (FKeyingPort[nID] in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = True) then begin
         WinkeyerControlPTT(PTTON);
      end;

      if (FKeyingPort[nID] in [tkpParallel]) then begin
         if PTTON then begin
            FParallelPort.SetBit(PARALLEL_PTT);
         end
         else begin
            FParallelPort.ResetBit(PARALLEL_PTT);
         end;
         FParallelPort.Write();
      end;
   finally
      {$IFDEF DEBUG}
      OutputDebugString(PChar('*** ControlPTT ***'));
      {$ENDIF}
      if Assigned(FOnWkStatusProc) then begin
         FOnWkStatusProc(Self, FWkTx, FWkRx, PTTON);
      end;
   end;
end;

procedure TdmZLogKeyer.ResetPTT();
var
   nID: Integer;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** Enter -- ResetPTT ***'));
   {$ENDIF}
   try
      FPTTFLAG := False;

      for nID := 0 to MAXPORT do begin
         if FKeyingPort[nID] = tkpUSB then begin
            UsbPortDataLock.Enter();
            if Assigned(FUsbInfo[nID].FPORTDATA) then begin
               FUsbInfo[nID].FPORTDATA.SetPttFlag(False);
               SendUsbPortData(nID);
            end;
            UsbPortDataLock.Leave();
         end;

         if (FKeyingPort[nID] in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = False) then begin
            if FKeyingPortConfig[nID].FRts = paPtt then begin
               FComKeying[nID].ToggleRTS(False);
            end;
            if FKeyingPortConfig[nID].FDtr = paPtt then begin
               FComKeying[nID].ToggleDTR(False);
            end;
         end;

         if (FKeyingPort[nID] in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = True) then begin
            WinkeyerControlPTT(False);
         end;
      end;
   finally
      {$IFDEF DEBUG}
      OutputDebugString(PChar('*** Leave -- ResetPTT ***'));
      {$ENDIF}
   end;
end;

procedure TdmZLogKeyer.SetPTT(_on: Boolean);
var
   i: Integer;
begin
   FPTTEnabled := _on;

   for i := 0 to MAXPORT do begin
      if FKeyingPort[i] = tkpUSB then begin
         if _on = True then begin
            usbif4cwSetPTTParam(i, FPttDelayBeforeTime, FPttDelayAfterTime);
         end
         else begin
//            ControlPTT(i, False);
            usbif4cwSetPTTParam(i, 0, 0);
         end;
      end;
   end;
end;

function TdmZLogKeyer.PTTIsOn: Boolean;
begin
   Result := FPTTFLAG;
end;

procedure TdmZLogKeyer.SetPTTDelay(before, after: word);
begin
   if FTimerMicroSec = 0 then begin
      Exit;
   end;

   before := Min(before, 255);
   before := Max(before, 1);

   FPttDelayBeforeCount := Trunc(before * 1000 / FTimerMicroSec);
   FPttDelayBeforeTime := before;

   after := Min(after, 255);
   after := Max(after, 1);

   FPttDelayAfterCount := Trunc(after * 1000 / FTimerMicroSec);
   FPttDelayAfterTime := after;
end;

function TdmZLogKeyer.Paused: Boolean;
begin
   Result := not FSendOK;
end;

procedure TdmZLogKeyer.SetSideTonePitch(Hertz: Integer);
begin
   if Hertz < 2500 then begin
      FSideTonePitch := Hertz;
      {$IFDEF USESIDETONE}
      if Assigned(FTone) then begin
         FTone.Frequency := FSideTonePitch;
      end;
      {$ENDIF}
   end;
end;

procedure TdmZLogKeyer.SetCWSendBufChar(b: Integer; C: Char);
var
   m: Integer;
begin
//   CWBufferSync.Enter();
   try
      for m := 1 to codemax do begin
         FCWSendBuf[b, codemax * (tailcwstrptr - 1) + m] := FCodeTable[Ord(C)][m];
      end;

      inc(tailcwstrptr);
      if tailcwstrptr > charmax then begin
         tailcwstrptr := 1;
      end;
   finally
//      CWBufferSync.Leave();
   end;
end;

procedure TdmZLogKeyer.SetCWSendBufFinish(b: Integer);
var
   m: Integer;
begin
   for m := 1 to codemax do begin
      FCWSendBuf[b, codemax * (tailcwstrptr - 1) + m] := $FF;
   end;
   FPrevDSR := True;
end;

procedure TdmZLogKeyer.SetCWSendBufCharPTT(nID: Integer; C: Char);
var
   S: string;
   m: Integer;
begin
   if UseWinKeyer = True then begin
      FWkAbort := False;

      // 特殊文字をデコード
      S := WinKeyerBuildMessage(C);

      // 初回送信？
      if FWkSendStatus = wkssNone then begin
         // PTT-ON
         ControlPTT(nID, True);

         // SO2R Neo利用時はRIG切り替え・・・TX=RXで
         if FSo2rType = so2rNeo then begin
            So2rNeoSwitchRig(nID, nID)
         end;

         // 送信中
         FWkSendStatus := wkssMessage;

         // S[1]が$1bは合わせ文字 $1bはecho backしない
         if Char(S[1]) = Char($1b) then begin
            FWkMessageIndex := 1;
            FWkMessageStr := Copy(S, 2);
            FComKeying[0].SendString(AnsiString(S));
         end
         else begin  // 通常キャラクタ
            FWkMessageIndex := 1;
            FWkMessageStr := S;
            C := FWkMessageStr[FWkMessageIndex];
            WinKeyerSendCharEx(C);
         end;
      end
      else begin
         if Char(S[1]) = Char($1b) then begin
            FWkMessageIndex := 1;
            FWkMessageStr := FWkMessageStr + Copy(S, 2);
            FComKeying[0].SendString(AnsiString(S));
         end
         else begin
            FWkMessageStr := FWkMessageStr + S;
         end;
      end;
      Exit;
   end
   else begin  // COM/USB
      if FPTTEnabled and Not(PTTIsOn) then begin
         ControlPTT(nID, True);
         FKeyingCounter := FPttDelayBeforeCount;
      end;

      // SendOK := False;

      CWBufferSync.Enter();
      try
         // set send char
         for m := 1 to codemax do begin
            FCWSendBuf[0, codemax * (tailcwstrptr - 1) + m] := FCodeTable[Ord(C)][m];
         end;

         if FPTTEnabled then begin
            FPttHoldCounter := FPttDelayAfterCount;

            { holds PTT until pttafter expires }
            FCWSendBuf[0, codemax * (tailcwstrptr - 1) + codemax + 1] := $A2; { holds PTT until pttafter expires }
         end;

         inc(tailcwstrptr);
         if tailcwstrptr > charmax then begin
            tailcwstrptr := 1;
         end;

         // set finish char
         SetCWSendBufFinish(0);

         if cwstrptr = 0 then begin
            cwstrptr := 1;
         end;

         FSendOK := True;
      finally
         CWBufferSync.Leave();
      end;
   end;
end;

function TdmZLogKeyer.DecodeCommands(S: string): string;
var
   SS: string;
   n, j, k: word;
begin
   SS := S;
   while pos('\', SS) > 0 do // \+ incwpm \- decwpm
   begin
      n := pos('\', SS);
      SS[n] := '_'; // just to avoid infinite loop
      // if n < (length(SS) - 2) then
      if n <= (length(SS) - 2) then // bug fix
      begin
         if SS[n + 1] = '+' then begin
            if CharInSet(SS[n + 2], ['1' .. '9']) = True then begin
               k := Ord(SS[n + 2]) - Ord('0');
               delete(SS, n, 3);
               for j := 1 to k do
                  insert(Chr(_inccw), SS, n);
            end;
         end;
         if SS[n + 1] = '-' then begin
            if CharInSet(SS[n + 2], ['1' .. '9']) = True then begin
               k := Ord(SS[n + 2]) - Ord('0');
               delete(SS, n, 3);
               for j := 1 to k do begin
                  insert(Chr(_deccw), SS, n);
               end;
            end;
         end;
      end;

   end;
   Result := SS;
end;

procedure TdmZLogKeyer.SetCWSendBuf(b: byte; S: string);
var
   SS: string;
begin
   SS := S;

   CWBufferSync.Enter();
   try
      tailcwstrptr := 1;

      ExpandCWSendBuffer(b, SS);

      SetCWSendBufFinish(b);

      cwstrptr := 1;
   finally
      CWBufferSync.Leave();
   end;
end;

procedure TdmZLogKeyer.SendStr(nID: Integer; sStr: string);
var
   SS: string;
   CW: string;
begin
   if sStr = '' then
      Exit;

   if ((nID >= 0) and (nID <= 4)) then begin
      CW := Char($90 + nID);
   end
   else begin
      CW := Char($90);
   end;

   SS := sStr;

   if FPTTEnabled then begin
      SS := '(' + SS + ')';
   end;

   SS := CW + SS;

   SetCWSendBuf(0, SS);

   FSendOK := True;
   FKeyingCounter := 1;
end;

procedure TdmZLogKeyer.SendStrFIFO(nID: Integer; sStr: string);
var
   SS: string;
   CW: string;
begin
   if ((nID >= 0) and (nID <= 4)) then begin
      CW := Char($90 + nID);
   end
   else begin
      CW := Char($90);
   end;

   SS := sStr;

   if FPTTEnabled then begin
      SS := '(' + SS + ')';
   end;

   SS := CW + SS;

   CWBufferSync.Enter();
   try
      ExpandCWSendBuffer(0, SS);

      SetCWSendBufFinish(0);

      if cwstrptr = 0 then begin
         cwstrptr := 1;
      end;
   finally
      CWBufferSync.Leave();
   end;
end;

procedure TdmZLogKeyer.ExpandCWSendBuffer(b: Integer; SS: string);
var
   n: Integer;
   ptr: Integer;
begin
   n := 1;
   ptr := 1;
   while n <= Length(SS) do begin
      if SS[n] = ':' then begin { callsign 1st char }
         callsignptr := ptr
      end;

      if SS[n] = '@' then begin
         FCodeTable[Ord('@')][2] := StrToIntDef(SS[n + 1], 0);
         FCodeTable[Ord('@')][3] := StrToIntDef(SS[n + 2], 0);
         FCodeTable[Ord('@')][4] := StrToIntDef(SS[n + 3], 0);
         SetCWSendBufChar(b, '@');
         Inc(n, 3)
      end
      else if SS[n] = '\' then begin
         if SS[n + 1] = '+' then begin
            FCodeTable[Ord('w')][2] := 0;
         end
         else begin
            FCodeTable[Ord('w')][2] := 1;
         end;
         FCodeTable[Ord('w')][3] := StrToIntDef(SS[n + 2], 0);
         SetCWSendBufChar(b, 'w');
         Inc(n, 2)
      end
      else begin
         SetCWSendBufChar(b, SS[n]);
      end;

      Inc(n);
      Inc(ptr);
   end;
end;

procedure TdmZLogKeyer.CW_ON(nID: Integer);
begin
   case FKeyingPort[nID] of
      tkpSerial1..tkpSerial20: begin
         if FKeyingPortConfig[nID].FRts = paKey then begin
            FComKeying[nID].ToggleRTS(True);
         end;
         if FKeyingPortConfig[nID].FDtr = paKey then begin
            FComKeying[nID].ToggleDTR(True);
         end;
      end;

      tkpUSB: begin
         UsbPortDataLock.Enter();
         if Assigned(FUsbInfo[nID].FPORTDATA) then begin
            FUsbInfo[nID].FPORTDATA.SetKeyFlag(True);
            if UsePaddleKeyer = False then begin
               SendUsbPortData(nID);
            end;
         end;
         UsbPortDataLock.Leave();
      end;

      tkpParallel: begin
         FParallelPort.SetBit(PARALLEL_KEY);
         FParallelPort.Write();
      end;
   end;
end;

procedure TdmZLogKeyer.CW_OFF(nID: Integer);
begin
   case FKeyingPort[nID] of
      tkpSerial1..tkpSerial20: begin
         if FKeyingPortConfig[nID].FRts = paKey then begin
            FComKeying[nID].ToggleRTS(False);
         end;
         if FKeyingPortConfig[nID].FDtr = paKey then begin
            FComKeying[nID].ToggleDTR(False);
         end;
      end;

      tkpUSB: begin
         UsbPortDataLock.Enter();
         if Assigned(FUsbInfo[nID].FPORTDATA) then begin
            FUsbInfo[nID].FPORTDATA.SetKeyFlag(False);
            if UsePaddleKeyer = False then begin
               SendUsbPortData(nID);
            end;
         end;
         UsbPortDataLock.Leave();
      end;

      tkpParallel: begin
         FParallelPort.ResetBit(PARALLEL_KEY);
         FParallelPort.Write();
      end;
   end;
end;

function TdmZLogKeyer.CanSend(nID: Integer): Boolean;
var
   status: TLineStatusSet;
   fCurDSR: Boolean;
begin
   if FSo2rType <> so2rOtrsp then begin
      Result := True;
      Exit;
   end;
   if FUseCanSend = False then begin
      Result := True;
      Exit;
   end;
   if FComKeying[nID] = nil then begin
      Result := True;
      Exit;
   end;

   // 現在のDSR状態取得
   status := FComKeying[nID].GetLineStatus();
   fCurDSR := lsDSR in status;

   // DSRがOFF→ONの変化でSend不可とする
   if (FPrevDSR = False) and (fCurDSR = True) then begin
      Result := False;
   end
   else begin
      Result := True;
   end;

   // 今回値を保存
   FPrevDSR := fCurDSR;
end;

procedure TdmZLogKeyer.TimerProcess(uTimerID, uMessage: word; dwUser, dw1, dw2: Longint); stdcall;
var
   nCommand: Integer;
   cmd: Byte;
   wpm_change: Integer;
   wpm_sign: Integer;

   procedure Finish();
   begin
      CWBufferSync.Enter();
      try
         cwstrptr := 0;
         callsignptr := 0;
         mousetail:=1;
         tailcwstrptr := 1;
         paddle_waiting := True;
         FCWSendBuf[FSelectedBuf, 1] := $FF;
         FSendChar := False;
      finally
         CWBufferSync.Leave();
      end;

      if FKeyingPort[FWkTx] <> tkpUSB then begin
         CW_OFF(FWkTx);
      end;

      if FUseSideTone then begin
         NoSound();
      end;

      { if PTTEnabled then  // 1.3c
        ControlPTT(False); } // PTT doesn't work with \
   end;
begin
   if FKeyingCounter > 0 then begin
      Dec(FKeyingCounter);
      Exit;
   end;

   if FSendOK = False then begin
      Exit;
   end;

   if cwstrptr = 0 then begin
      Exit;
   end;

   if (CanSend(FWkTx) = False) then begin
      Finish();
      if Assigned(FOnSendFinishProc) then begin
         FOnSendFinishProc(Self, mCW, False);
      end;
      FSendOK := False;
      Exit;
   end;

   CWBufferSync.Enter();
   try
      cmd := FCWSendBuf[FSelectedBuf, cwstrptr];
   finally
      CWBufferSync.Leave();
   end;

   case cmd of
      $55: begin { set ptt delay before }
         FKeyingCounter := FPttDelayBeforeCount;
      end;

      $10: begin
         ControlPTT(FWkTx, True);
      end;

      $1F: begin
         ControlPTT(FWkTx, False);
      end;

      0: begin
         CW_OFF(FWkTx);
         if FUseSideTone then begin
            NoSound();
         end;
         FKeyingCounter := FBlank1Count;
         FSendChar := True;
      end;

      2: begin { normal space x space factor (%) }
         CW_OFF(FWkTx);
         if FUseSideTone then begin
            NoSound();
         end;
         FKeyingCounter := Trunc(FBlank3Count * FSpaceFactor / 100);
      end;

      $E: begin { normal space x space factor x eispacefactor(%) }
         CW_OFF(FWkTx);
         if FUseSideTone then begin
            NoSound();
         end;
         FKeyingCounter := Trunc(FBlank3Count * (FSpaceFactor / 100) * (FEISpaceFactor / 100));
      end;

      // dot
      1: begin
         CW_ON(FWkTx);
         if FUseSideTone then begin
            Sound();
         end;

         FKeyingCounter := FDotCount;
         FSendChar := True;
      end;

      // dash
      3: begin
         CW_ON(FWkTx);
         if FUseSideTone then begin
            Sound();
         end;

         FKeyingCounter := FDashCount;
         FSendChar := True;
      end;

      // next char
      9: begin
         CWBufferSync.Enter();
         try
            cwstrptr := (cwstrptr div codemax + 1) * codemax;
         finally
            CWBufferSync.Leave();
         end;

         if Assigned(FOnOneCharSentProc) and FSendChar then begin
            FOnOneCharSentProc(Self);
         end;
      end;

      // repeat
      $A: begin
         CWBufferSync.Enter();
         try
            cwstrptr := 0;
            tailcwstrptr := 1;
         finally
            CWBufferSync.Leave();
         end;
      end;

      $A1: begin
         FPttHoldCounter := FPttDelayAfterCount;
      end;

      $A2: begin
         if FPttHoldCounter <= 0 then begin
            Finish();
            if FPTTEnabled then begin
               ControlPTT(FWkTx, False);
            end;
         end
         else begin
            Dec(FPttHoldCounter);
         end;
         Exit;
      end;

      $A3: begin
         if FPttHoldCounter > 0 then begin
            Dec(FPttHoldCounter);
            Exit;
         end;
      end;

      $AA: begin {paddle waiting routine. if p_char_count expires, }
         paddle_waiting := True;
         if p_char_count <= 0 then begin

            if FPTTEnabled then begin
               CWBufferSync.Enter();
               try
                  FPttHoldCounter := FPttDelayAfterCount;
                  FCWSendBuf[FSelectedBuf, cwstrptr] := $A2;
                  FCWSendBuf[FSelectedBuf, cwstrptr + 1] := $FF;
               finally
                  CWBufferSync.Leave();
               end;
               Exit;
            end;

            CWBufferSync.Enter();
            try
               cwstrptr := 1;
               mousetail := 1;
               paddle_waiting := True;
               FCWSendBuf[FSelectedBuf, 1] := $FF;
            finally
               CWBufferSync.Leave();
            end;
         end
         else begin
           dec(p_char_count);
         end;
         Exit;
      end;

      $BB: begin
         CWBufferSync.Enter();
         try
            Dec(cwstrptr);
         finally
            CWBufferSync.Leave();
         end;
      end;

      $EE: begin { cwstrptr:=(BGKcall+callmax-1)*codemax; }
      end;

      $FA: begin
         CWBufferSync.Enter();
         try
            Dec(cwstrptr);
         finally
            CWBufferSync.Leave();
         end;
      end;

      $FF: begin { SendOK:=False; }
         Finish();

         if Assigned(FOnSendFinishProc) then begin
            {$IFDEF DEBUG}
            OutputDebugString(PChar(' *** FOnSendFinishProc() called in TimerProcess() ***'));
            {$ENDIF}
            FOnSendFinishProc(Self, mCW, False);
         end;

         FSendOK := False;
         Exit;
      end;

      $99: begin { pause }
         FSendChar := False;
         FSendOK := False;
      end;

      $41: begin
         IncWPM;
         FSendChar := True;
      end;

      $42: begin
         DecWPM;
         FSendChar := True;
      end;

      $43: begin
         CWBufferSync.Enter();
         try
            FSendChar := False;
            Inc(cwstrptr);
            wpm_sign := FCWSendBuf[FSelectedBuf, cwstrptr];
            Inc(cwstrptr);
            wpm_change := FCWSendBuf[FSelectedBuf, cwstrptr];
         finally
            CWBufferSync.Leave();
         end;

         ChangeWPM(wpm_sign, wpm_change);

         if Assigned(FOnOneCharSentProc) then begin
            FOnOneCharSentProc(Self);
            FOnOneCharSentProc(Self);
            FOnOneCharSentProc(Self);
         end;
      end;

      $0B: begin
         FUserFlag := False;
      end;

      $20: begin
         FWkTx := 0;
         FSendChar := False;
      end;

      $21: begin
         FWkTx := 1;
         FSendChar := False;
      end;

      $22: begin
         FWkTx := 2;
         FSendChar := False;
      end;

      $23: begin
         FWkTx := 3;
         FSendChar := False;
      end;

      $24: begin
         FWkTx := 4;
         FSendChar := False;
      end;

      $30: begin
         CWBufferSync.Enter();
         try
            FSendChar := False;

            Inc(cwstrptr);
            nCommand := FCWSendBuf[FSelectedBuf, cwstrptr] * 100;
            Inc(cwstrptr);
            nCommand := nCommand + FCWSendBuf[FSelectedBuf, cwstrptr] * 10;
            Inc(cwstrptr);
            nCommand := nCommand + FCWSendBuf[FSelectedBuf, cwstrptr];
         finally
            CWBufferSync.Leave();
         end;

         if Assigned(FOnOneCharSentProc) then begin
            FOnOneCharSentProc(Self);
            FOnOneCharSentProc(Self);
            FOnOneCharSentProc(Self);
            FOnOneCharSentProc(Self);
         end;

         if Assigned(FOnCommand) then begin
            FOnCommand(Self, nCommand);
         end;
      end;
   end;

   CWBufferSync.Enter();
   try
      Inc(cwstrptr);
   finally
      CWBufferSync.Leave();
   end;
end; { TimerProcess }

procedure TdmZLogKeyer.SetWPM(wpm: Integer);
var
   i: Integer;
begin
   if FKeyerWPM = wpm then begin
      Exit;
   end;

   if (wpm <= MAXWPM) and (wpm >= MINWPM) then begin
      if wpm * FTimerMicroSec = 0 then begin
         Exit;
      end;

      FDotCount := Trunc((2 * FKeyerWeight / 100) * (1200000 / (wpm * FTimerMicroSec)));
      FBlank1Count := Trunc((2 * (1 - FKeyerWeight / 100)) * (1200000 / (wpm * FTimerMicroSec)));
      FDashCount := FDotCount * 3;
      FBlank3Count := FBlank1Count * 3;

      FKeyerWPM := wpm;

      if (FTemporarySpeedChange = False) then begin
         for i := 0 to MAXPORT do begin
            if FKeyingPort[i] <> tkpNone then begin
               if (FKeyingPort[i] = tkpUSB) and (FUsbif4cwSyncWpm = True) then begin
                  usbif4cwSetWPM(i, FKeyerWPM);
               end;

               if (FKeyingPort[i] in [tkpSerial1 .. tkpSerial20]) and (FUseWinKeyer = True) then begin
                  WinKeyerSetSpeed(FKeyerWPM);
               end;
            end;
         end;
      end;

      if Assigned(FOnSpeedChanged) then begin
         FOnSpeedChanged(Self);
      end;
   end;
end;

procedure TdmZLogKeyer.InitializeBGK(msec: Integer);
var
   n, m: word;
begin
   FPTTFLAG := False;

   callsignptr := 0; { points to the 1st char of realtime updated callsign }
   FSelectedBuf := 0;
   FSendChar := False;
   cwstrptr := 1;
   tailcwstrptr := 1;
   mousetail := 1;
   FTimerMilliSec := msec; { timer interval, default = 1}
   FTimerMicroSec := FTimerMilliSec * 1000;

   for n := 0 to 255 do begin
      for m := 1 to codemax do begin
         FCodeTable[n, m] := $FF;
      end;
   end;

   for m := 0 to 2 do begin
      FCWSendBuf[m, 1] := $FF;
   end;

   FSendOK := True;
   FKeyingCounter := 10;

   SideTonePitch := 800; { 800 Hz }

   FKeyerWeight := 50;
   FUseSideTone := True;
   FUsePaddleKeyer := False;
   FPaddleReverse := False;
   FPaddleSqueeze := False;
   FKeyerWPM := 1;
   FKeyerInitWPM := 1;

   timeBeginPeriod(1);

   FTimerID := timeSetEvent(FTimerMilliSec, 0, @TimerCallback, 0, time_Periodic);

   FPTTEnabled := False;
   SetPTTDelay(50, 50); { 50ms/50ms }

   FCodeTable[Ord('A')][1] := 1;
   FCodeTable[Ord('A')][2] := 0;
   FCodeTable[Ord('A')][3] := 3;
   FCodeTable[Ord('A')][4] := 2;
   FCodeTable[Ord('A')][5] := 9;

   FCodeTable[Ord('B')][1] := 3;
   FCodeTable[Ord('B')][2] := 0;
   FCodeTable[Ord('B')][3] := 1;
   FCodeTable[Ord('B')][4] := 0;
   FCodeTable[Ord('B')][5] := 1;
   FCodeTable[Ord('B')][6] := 0;
   FCodeTable[Ord('B')][7] := 1;
   FCodeTable[Ord('B')][8] := 2;
   FCodeTable[Ord('B')][9] := 9;

   FCodeTable[Ord('C')][1] := 3;
   FCodeTable[Ord('C')][2] := 0;
   FCodeTable[Ord('C')][3] := 1;
   FCodeTable[Ord('C')][4] := 0;
   FCodeTable[Ord('C')][5] := 3;
   FCodeTable[Ord('C')][6] := 0;
   FCodeTable[Ord('C')][7] := 1;
   FCodeTable[Ord('C')][8] := 2;
   FCodeTable[Ord('C')][9] := 9;

   FCodeTable[Ord('D')][1] := 3;
   FCodeTable[Ord('D')][2] := 0;
   FCodeTable[Ord('D')][3] := 1;
   FCodeTable[Ord('D')][4] := 0;
   FCodeTable[Ord('D')][5] := 1;
   FCodeTable[Ord('D')][6] := 2;
   FCodeTable[Ord('D')][7] := 9;

   FCodeTable[Ord('E')][1] := 1;
   FCodeTable[Ord('E')][2] := $E;
   FCodeTable[Ord('E')][3] := 9;

   FCodeTable[Ord('F')][1] := 1;
   FCodeTable[Ord('F')][2] := 0;
   FCodeTable[Ord('F')][3] := 1;
   FCodeTable[Ord('F')][4] := 0;
   FCodeTable[Ord('F')][5] := 3;
   FCodeTable[Ord('F')][6] := 0;
   FCodeTable[Ord('F')][7] := 1;
   FCodeTable[Ord('F')][8] := 2;
   FCodeTable[Ord('F')][9] := 9;

   FCodeTable[Ord('G')][1] := 3;
   FCodeTable[Ord('G')][2] := 0;
   FCodeTable[Ord('G')][3] := 3;
   FCodeTable[Ord('G')][4] := 0;
   FCodeTable[Ord('G')][5] := 1;
   FCodeTable[Ord('G')][6] := 2;
   FCodeTable[Ord('G')][7] := 9;

   FCodeTable[Ord('H')][1] := 1;
   FCodeTable[Ord('H')][2] := 0;
   FCodeTable[Ord('H')][3] := 1;
   FCodeTable[Ord('H')][4] := 0;
   FCodeTable[Ord('H')][5] := 1;
   FCodeTable[Ord('H')][6] := 0;
   FCodeTable[Ord('H')][7] := 1;
   FCodeTable[Ord('H')][8] := 2;
   FCodeTable[Ord('H')][9] := 9;

   FCodeTable[Ord('I')][1] := 1;
   FCodeTable[Ord('I')][2] := 0;
   FCodeTable[Ord('I')][3] := 1;
   FCodeTable[Ord('I')][4] := 0;
   FCodeTable[Ord('I')][5] := $E;
   FCodeTable[Ord('I')][6] := 9;

   FCodeTable[Ord('J')][1] := 1;
   FCodeTable[Ord('J')][2] := 0;
   FCodeTable[Ord('J')][3] := 3;
   FCodeTable[Ord('J')][4] := 0;
   FCodeTable[Ord('J')][5] := 3;
   FCodeTable[Ord('J')][6] := 0;
   FCodeTable[Ord('J')][7] := 3;
   FCodeTable[Ord('J')][8] := 2;
   FCodeTable[Ord('J')][9] := 9;

   FCodeTable[Ord('K')][1] := 3;
   FCodeTable[Ord('K')][2] := 0;
   FCodeTable[Ord('K')][3] := 1;
   FCodeTable[Ord('K')][4] := 0;
   FCodeTable[Ord('K')][5] := 3;
   FCodeTable[Ord('K')][6] := 2;
   FCodeTable[Ord('K')][7] := 9;

   FCodeTable[Ord('L')][1] := 1;
   FCodeTable[Ord('L')][2] := 0;
   FCodeTable[Ord('L')][3] := 3;
   FCodeTable[Ord('L')][4] := 0;
   FCodeTable[Ord('L')][5] := 1;
   FCodeTable[Ord('L')][6] := 0;
   FCodeTable[Ord('L')][7] := 1;
   FCodeTable[Ord('L')][8] := 2;
   FCodeTable[Ord('L')][9] := 9;

   FCodeTable[Ord('M')][1] := 3;
   FCodeTable[Ord('M')][2] := 0;
   FCodeTable[Ord('M')][3] := 3;
   FCodeTable[Ord('M')][4] := 0;
   FCodeTable[Ord('M')][5] := 2;
   FCodeTable[Ord('M')][6] := 9;

   FCodeTable[Ord('N')][1] := 3;
   FCodeTable[Ord('N')][2] := 0;
   FCodeTable[Ord('N')][3] := 1;
   FCodeTable[Ord('N')][4] := 0;
   FCodeTable[Ord('N')][5] := 2;
   FCodeTable[Ord('N')][6] := 9;

   FCodeTable[Ord('O')][1] := 3;
   FCodeTable[Ord('O')][2] := 0;
   FCodeTable[Ord('O')][3] := 3;
   FCodeTable[Ord('O')][4] := 0;
   FCodeTable[Ord('O')][5] := 3;
   FCodeTable[Ord('O')][6] := 2;
   FCodeTable[Ord('O')][7] := 9;

   FCodeTable[Ord('P')][1] := 1;
   FCodeTable[Ord('P')][2] := 0;
   FCodeTable[Ord('P')][3] := 3;
   FCodeTable[Ord('P')][4] := 0;
   FCodeTable[Ord('P')][5] := 3;
   FCodeTable[Ord('P')][6] := 0;
   FCodeTable[Ord('P')][7] := 1;
   FCodeTable[Ord('P')][8] := 2;
   FCodeTable[Ord('P')][9] := 9;

   FCodeTable[Ord('Q')][1] := 3;
   FCodeTable[Ord('Q')][2] := 0;
   FCodeTable[Ord('Q')][3] := 3;
   FCodeTable[Ord('Q')][4] := 0;
   FCodeTable[Ord('Q')][5] := 1;
   FCodeTable[Ord('Q')][6] := 0;
   FCodeTable[Ord('Q')][7] := 3;
   FCodeTable[Ord('Q')][8] := 2;
   FCodeTable[Ord('Q')][9] := 9;

   FCodeTable[Ord('R')][1] := 1;
   FCodeTable[Ord('R')][2] := 0;
   FCodeTable[Ord('R')][3] := 3;
   FCodeTable[Ord('R')][4] := 0;
   FCodeTable[Ord('R')][5] := 1;
   FCodeTable[Ord('R')][6] := 2;
   FCodeTable[Ord('R')][7] := 9;

   FCodeTable[Ord('S')][1] := 1;
   FCodeTable[Ord('S')][2] := 0;
   FCodeTable[Ord('S')][3] := 1;
   FCodeTable[Ord('S')][4] := 0;
   FCodeTable[Ord('S')][5] := 1;
   FCodeTable[Ord('S')][6] := 2;
   FCodeTable[Ord('S')][7] := 9;

   FCodeTable[Ord('T')][1] := 3;
   FCodeTable[Ord('T')][2] := 2;
   FCodeTable[Ord('T')][3] := 9;

   FCodeTable[Ord('U')][1] := 1;
   FCodeTable[Ord('U')][2] := 0;
   FCodeTable[Ord('U')][3] := 1;
   FCodeTable[Ord('U')][4] := 0;
   FCodeTable[Ord('U')][5] := 3;
   FCodeTable[Ord('U')][6] := 2;
   FCodeTable[Ord('U')][7] := 9;

   FCodeTable[Ord('V')][1] := 1;
   FCodeTable[Ord('V')][2] := 0;
   FCodeTable[Ord('V')][3] := 1;
   FCodeTable[Ord('V')][4] := 0;
   FCodeTable[Ord('V')][5] := 1;
   FCodeTable[Ord('V')][6] := 0;
   FCodeTable[Ord('V')][7] := 3;
   FCodeTable[Ord('V')][8] := 2;
   FCodeTable[Ord('V')][9] := 9;

   FCodeTable[Ord('W')][1] := 1;
   FCodeTable[Ord('W')][2] := 0;
   FCodeTable[Ord('W')][3] := 3;
   FCodeTable[Ord('W')][4] := 0;
   FCodeTable[Ord('W')][5] := 3;
   FCodeTable[Ord('W')][6] := 2;
   FCodeTable[Ord('W')][7] := 9;

   FCodeTable[Ord('X')][1] := 3;
   FCodeTable[Ord('X')][2] := 0;
   FCodeTable[Ord('X')][3] := 1;
   FCodeTable[Ord('X')][4] := 0;
   FCodeTable[Ord('X')][5] := 1;
   FCodeTable[Ord('X')][6] := 0;
   FCodeTable[Ord('X')][7] := 3;
   FCodeTable[Ord('X')][8] := 2;
   FCodeTable[Ord('X')][9] := 9;

   FCodeTable[Ord('Y')][1] := 3;
   FCodeTable[Ord('Y')][2] := 0;
   FCodeTable[Ord('Y')][3] := 1;
   FCodeTable[Ord('Y')][4] := 0;
   FCodeTable[Ord('Y')][5] := 3;
   FCodeTable[Ord('Y')][6] := 0;
   FCodeTable[Ord('Y')][7] := 3;
   FCodeTable[Ord('Y')][8] := 2;
   FCodeTable[Ord('Y')][9] := 9;

   FCodeTable[Ord('Z')][1] := 3;
   FCodeTable[Ord('Z')][2] := 0;
   FCodeTable[Ord('Z')][3] := 3;
   FCodeTable[Ord('Z')][4] := 0;
   FCodeTable[Ord('Z')][5] := 1;
   FCodeTable[Ord('Z')][6] := 0;
   FCodeTable[Ord('Z')][7] := 1;
   FCodeTable[Ord('Z')][8] := 2;
   FCodeTable[Ord('Z')][9] := 9;

   FCodeTable[Ord(' ')][1] := 0;
   // FCodeTable[Ord(' ')][2]:=$22;
   FCodeTable[Ord(' ')][2] := 2;
   FCodeTable[Ord(' ')][3] := 9;

   FCodeTable[Ord('_')][1] := 0;
   FCodeTable[Ord('_')][2] := 9;

   FCodeTable[Ord('1')][1] := 1;
   FCodeTable[Ord('1')][2] := 0;
   FCodeTable[Ord('1')][3] := 3;
   FCodeTable[Ord('1')][4] := 0;
   FCodeTable[Ord('1')][5] := 3;
   FCodeTable[Ord('1')][6] := 0;
   FCodeTable[Ord('1')][7] := 3;
   FCodeTable[Ord('1')][8] := 0;
   FCodeTable[Ord('1')][9] := 3;
   FCodeTable[Ord('1')][10] := 2;
   FCodeTable[Ord('1')][11] := 9;

   FCodeTable[Ord('2')][1] := 1;
   FCodeTable[Ord('2')][2] := 0;
   FCodeTable[Ord('2')][3] := 1;
   FCodeTable[Ord('2')][4] := 0;
   FCodeTable[Ord('2')][5] := 3;
   FCodeTable[Ord('2')][6] := 0;
   FCodeTable[Ord('2')][7] := 3;
   FCodeTable[Ord('2')][8] := 0;
   FCodeTable[Ord('2')][9] := 3;
   FCodeTable[Ord('2')][10] := 2;
   FCodeTable[Ord('2')][11] := 9;

   FCodeTable[Ord('3')][1] := 1;
   FCodeTable[Ord('3')][2] := 0;
   FCodeTable[Ord('3')][3] := 1;
   FCodeTable[Ord('3')][4] := 0;
   FCodeTable[Ord('3')][5] := 1;
   FCodeTable[Ord('3')][6] := 0;
   FCodeTable[Ord('3')][7] := 3;
   FCodeTable[Ord('3')][8] := 0;
   FCodeTable[Ord('3')][9] := 3;
   FCodeTable[Ord('3')][10] := 2;
   FCodeTable[Ord('3')][11] := 9;

   FCodeTable[Ord('4')][1] := 1;
   FCodeTable[Ord('4')][2] := 0;
   FCodeTable[Ord('4')][3] := 1;
   FCodeTable[Ord('4')][4] := 0;
   FCodeTable[Ord('4')][5] := 1;
   FCodeTable[Ord('4')][6] := 0;
   FCodeTable[Ord('4')][7] := 1;
   FCodeTable[Ord('4')][8] := 0;
   FCodeTable[Ord('4')][9] := 3;
   FCodeTable[Ord('4')][10] := 2;
   FCodeTable[Ord('4')][11] := 9;

   FCodeTable[Ord('5')][1] := 1;
   FCodeTable[Ord('5')][2] := 0;
   FCodeTable[Ord('5')][3] := 1;
   FCodeTable[Ord('5')][4] := 0;
   FCodeTable[Ord('5')][5] := 1;
   FCodeTable[Ord('5')][6] := 0;
   FCodeTable[Ord('5')][7] := 1;
   FCodeTable[Ord('5')][8] := 0;
   FCodeTable[Ord('5')][9] := 1;
   FCodeTable[Ord('5')][10] := 2;
   FCodeTable[Ord('5')][11] := 9;

   FCodeTable[Ord('6')][1] := 3;
   FCodeTable[Ord('6')][2] := 0;
   FCodeTable[Ord('6')][3] := 1;
   FCodeTable[Ord('6')][4] := 0;
   FCodeTable[Ord('6')][5] := 1;
   FCodeTable[Ord('6')][6] := 0;
   FCodeTable[Ord('6')][7] := 1;
   FCodeTable[Ord('6')][8] := 0;
   FCodeTable[Ord('6')][9] := 1;
   FCodeTable[Ord('6')][10] := 2;
   FCodeTable[Ord('6')][11] := 9;

   FCodeTable[Ord('7')][1] := 3;
   FCodeTable[Ord('7')][2] := 0;
   FCodeTable[Ord('7')][3] := 3;
   FCodeTable[Ord('7')][4] := 0;
   FCodeTable[Ord('7')][5] := 1;
   FCodeTable[Ord('7')][6] := 0;
   FCodeTable[Ord('7')][7] := 1;
   FCodeTable[Ord('7')][8] := 0;
   FCodeTable[Ord('7')][9] := 1;
   FCodeTable[Ord('7')][10] := 2;
   FCodeTable[Ord('7')][11] := 9;

   FCodeTable[Ord('8')][1] := 3;
   FCodeTable[Ord('8')][2] := 0;
   FCodeTable[Ord('8')][3] := 3;
   FCodeTable[Ord('8')][4] := 0;
   FCodeTable[Ord('8')][5] := 3;
   FCodeTable[Ord('8')][6] := 0;
   FCodeTable[Ord('8')][7] := 1;
   FCodeTable[Ord('8')][8] := 0;
   FCodeTable[Ord('8')][9] := 1;
   FCodeTable[Ord('8')][10] := 2;
   FCodeTable[Ord('8')][11] := 9;

   FCodeTable[Ord('9')][1] := 3;
   FCodeTable[Ord('9')][2] := 0;
   FCodeTable[Ord('9')][3] := 3;
   FCodeTable[Ord('9')][4] := 0;
   FCodeTable[Ord('9')][5] := 3;
   FCodeTable[Ord('9')][6] := 0;
   FCodeTable[Ord('9')][7] := 3;
   FCodeTable[Ord('9')][8] := 0;
   FCodeTable[Ord('9')][9] := 1;
   FCodeTable[Ord('9')][10] := 2;
   FCodeTable[Ord('9')][11] := 9;

   FCodeTable[Ord('0')][1] := 3;
   FCodeTable[Ord('0')][2] := 0;
   FCodeTable[Ord('0')][3] := 3;
   FCodeTable[Ord('0')][4] := 0;
   FCodeTable[Ord('0')][5] := 3;
   FCodeTable[Ord('0')][6] := 0;
   FCodeTable[Ord('0')][7] := 3;
   FCodeTable[Ord('0')][8] := 0;
   FCodeTable[Ord('0')][9] := 3;
   FCodeTable[Ord('0')][10] := 2;
   FCodeTable[Ord('0')][11] := 9;

   FCodeTable[Ord('-')][1] := 3;
   FCodeTable[Ord('-')][2] := 0;
   FCodeTable[Ord('-')][3] := 1;
   FCodeTable[Ord('-')][4] := 0;
   FCodeTable[Ord('-')][5] := 1;
   FCodeTable[Ord('-')][6] := 0;
   FCodeTable[Ord('-')][7] := 1;
   FCodeTable[Ord('-')][8] := 0;
   FCodeTable[Ord('-')][9] := 1;
   FCodeTable[Ord('-')][10] := 0;
   FCodeTable[Ord('-')][11] := 3;
   FCodeTable[Ord('-')][12] := 2;
   FCodeTable[Ord('-')][13] := 9;

   FCodeTable[Ord('"')][1] := $0B; // set UserFlag to False
   FCodeTable[Ord('"')][2] := 9;

   FCodeTable[Ord('=')][1] := 3;
   FCodeTable[Ord('=')][2] := 0;
   FCodeTable[Ord('=')][3] := 1;
   FCodeTable[Ord('=')][4] := 0;
   FCodeTable[Ord('=')][5] := 1;
   FCodeTable[Ord('=')][6] := 0;
   FCodeTable[Ord('=')][7] := 1;
   FCodeTable[Ord('=')][8] := 0;
   FCodeTable[Ord('=')][9] := 3;
   FCodeTable[Ord('=')][10] := 2;
   FCodeTable[Ord('=')][11] := 9;

   FCodeTable[Ord('/')][1] := 3;
   FCodeTable[Ord('/')][2] := 0;
   FCodeTable[Ord('/')][3] := 1;
   FCodeTable[Ord('/')][4] := 0;
   FCodeTable[Ord('/')][5] := 1;
   FCodeTable[Ord('/')][6] := 0;
   FCodeTable[Ord('/')][7] := 3;
   FCodeTable[Ord('/')][8] := 0;
   FCodeTable[Ord('/')][9] := 1;
   FCodeTable[Ord('/')][10] := 2;
   FCodeTable[Ord('/')][11] := 9;

   // AR
   FCodeTable[Ord('a')][1] := 1;
   FCodeTable[Ord('a')][2] := 0;
   FCodeTable[Ord('a')][3] := 3;
   FCodeTable[Ord('a')][4] := 0;
   FCodeTable[Ord('a')][5] := 1;
   FCodeTable[Ord('a')][6] := 0;
   FCodeTable[Ord('a')][7] := 3;
   FCodeTable[Ord('a')][8] := 0;
   FCodeTable[Ord('a')][9] := 1;
   FCodeTable[Ord('a')][10] := 2;
   FCodeTable[Ord('a')][11] := 9;

   // BK
   FCodeTable[Ord('b')][1] := 3;
   FCodeTable[Ord('b')][2] := 0;
   FCodeTable[Ord('b')][3] := 1;
   FCodeTable[Ord('b')][4] := 0;
   FCodeTable[Ord('b')][5] := 1;
   FCodeTable[Ord('b')][6] := 0;
   FCodeTable[Ord('b')][7] := 1;
   FCodeTable[Ord('b')][8] := 0;
   FCodeTable[Ord('b')][9] := 3;
   FCodeTable[Ord('b')][10] := 0;
   FCodeTable[Ord('b')][11] := 1;
   FCodeTable[Ord('b')][12] := 0;
   FCodeTable[Ord('b')][13] := 3;
   FCodeTable[Ord('b')][14] := 2;
   FCodeTable[Ord('b')][15] := 9;

   // VA
   FCodeTable[Ord('s')][1] := 1;
   FCodeTable[Ord('s')][2] := 0;
   FCodeTable[Ord('s')][3] := 1;
   FCodeTable[Ord('s')][4] := 0;
   FCodeTable[Ord('s')][5] := 1;
   FCodeTable[Ord('s')][6] := 0;
   FCodeTable[Ord('s')][7] := 3;
   FCodeTable[Ord('s')][8] := 0;
   FCodeTable[Ord('s')][9] := 1;
   FCodeTable[Ord('s')][10] := 0;
   FCodeTable[Ord('s')][11] := 3;
   FCodeTable[Ord('s')][12] := 2;
   FCodeTable[Ord('s')][13] := 9;

   // KN
   FCodeTable[Ord('k')][1] := 3;
   FCodeTable[Ord('k')][2] := 0;
   FCodeTable[Ord('k')][3] := 1;
   FCodeTable[Ord('k')][4] := 0;
   FCodeTable[Ord('k')][5] := 3;
   FCodeTable[Ord('k')][6] := 0;
   FCodeTable[Ord('k')][7] := 3;
   FCodeTable[Ord('k')][8] := 0;
   FCodeTable[Ord('k')][9] := 1;
   FCodeTable[Ord('k')][10] := 2;
   FCodeTable[Ord('k')][11] := 9;

   // BT
   FCodeTable[Ord('t')][1] := 3;
   FCodeTable[Ord('t')][2] := 0;
   FCodeTable[Ord('t')][3] := 1;
   FCodeTable[Ord('t')][4] := 0;
   FCodeTable[Ord('t')][5] := 1;
   FCodeTable[Ord('t')][6] := 0;
   FCodeTable[Ord('t')][7] := 1;
   FCodeTable[Ord('t')][8] := 0;
   FCodeTable[Ord('t')][9] := 3;
   FCodeTable[Ord('t')][10] := 2;
   FCodeTable[Ord('t')][11] := 9;   { Next char }

   // ?
   FCodeTable[Ord('?')][1] := 1;
   FCodeTable[Ord('?')][2] := 0;
   FCodeTable[Ord('?')][3] := 1;
   FCodeTable[Ord('?')][4] := 0;
   FCodeTable[Ord('?')][5] := 3;
   FCodeTable[Ord('?')][6] := 0;
   FCodeTable[Ord('?')][7] := 3;
   FCodeTable[Ord('?')][8] := 0;
   FCodeTable[Ord('?')][9] := 1;
   FCodeTable[Ord('?')][10] := 0;
   FCodeTable[Ord('?')][11] := 1;
   FCodeTable[Ord('?')][12] := 2;
   FCodeTable[Ord('?')][13] := 9;

   // BK
   FCodeTable[Ord('~')][1] := 3;
   FCodeTable[Ord('~')][2] := 0;
   FCodeTable[Ord('~')][3] := 1;
   FCodeTable[Ord('~')][4] := 0;
   FCodeTable[Ord('~')][5] := 1;
   FCodeTable[Ord('~')][6] := 0;
   FCodeTable[Ord('~')][7] := 1;
   FCodeTable[Ord('~')][8] := 0;
   FCodeTable[Ord('~')][9] := 3;
   FCodeTable[Ord('~')][10] := 0;
   FCodeTable[Ord('~')][11] := 1;
   FCodeTable[Ord('~')][12] := 0;
   FCodeTable[Ord('~')][13] := 3;
   FCodeTable[Ord('~')][14] := 2;
   FCodeTable[Ord('~')][15] := 9;

   FCodeTable[Ord(']')][1] := 4;
   FCodeTable[Ord(']')][2] := 5;
   FCodeTable[Ord(']')][3] := 9;

   FCodeTable[Ord('#')][1] := $BB;

   FCodeTable[Ord('*')][1] := 9;    { skips to the next char }
   FCodeTable[Ord(':')][1] := 9;    { skips to the next char; callsign 1st char }

   FCodeTable[Ord('^')][1] := $99;  { pause }
   FCodeTable[Ord('^')][2] := 9;

   FCodeTable[Ord('(')][1] := $10;  { PTT on }
   FCodeTable[Ord('(')][2] := $55;  { set PTT delay }
   FCodeTable[Ord('(')][3] := 9;

   FCodeTable[Ord(')')][1] := $A1;  { set Hold Counter }
   FCodeTable[Ord(')')][2] := $A3;  { set PTT delay }
   FCodeTable[Ord(')')][3] := $1F;  { PTT off }
   FCodeTable[Ord(')')][4] := 9;

   FCodeTable[_inccw][1] := $41;    { IncWPM }
   FCodeTable[_inccw][2] := 9;

   FCodeTable[Ord('u')][1] := $41;  { IncWPM }
   FCodeTable[Ord('u')][2] := 9;

   FCodeTable[_deccw][1] := $42;    { DecWPM }
   FCodeTable[_deccw][2] := 9;

   FCodeTable[Ord('w')][1] := $43;  { ChangeWPM }
   FCodeTable[Ord('w')][2] := 0;
   FCodeTable[Ord('w')][3] := 0;
   FCodeTable[Ord('w')][4] := 9;

   for n := 1 to codemax do begin
      FCodeTable[Ord('%')][n] := $EE;
   end;

   for n := 1 to codemax do begin
      FCodeTable[Ord('{')][n] := $14;
   end;

   FCodeTable[$90][1] := $20;
   FCodeTable[$90][2] := 9;
   FCodeTable[$91][1] := $21;
   FCodeTable[$91][2] := 9;
   FCodeTable[$92][1] := $22;
   FCodeTable[$92][2] := 9;
   FCodeTable[$93][1] := $23;
   FCodeTable[$93][2] := 9;
   FCodeTable[$94][1] := $24;
   FCodeTable[$94][2] := 9;

   FCodeTable[Ord('@')][1] := $30;    { Execute Command }
   FCodeTable[Ord('@')][2] := 0;
   FCodeTable[Ord('@')][3] := 0;
   FCodeTable[Ord('@')][4] := 0;
   FCodeTable[Ord('@')][5] := 9;

   if FMonitorThread = nil then begin
      FMonitorThread := TKeyerMonitorThread.Create(Self);
   end;
   FMonitorThread.Start();

   if FPaddleThread = nil then begin
      FPaddleThread := TPaddleThread.Create(Self);
   end;
   FPaddleThread.Start();

   FInitialized := True;
end;

procedure TdmZLogKeyer.CloseBGK();
begin
   ControlPTT(0, False);
   ControlPTT(1, False);
   ControlPTT(2, False);
   ControlPTT(3, False);
   ControlPTT(4, False);

   if Assigned(FMonitorThread) then begin
      FMonitorThread.Terminate();
      FMonitorThread.Free();
      FMonitorThread := nil;
   end;

   if Assigned(FPaddleThread) then begin
      FPaddleThread.Terminate();
      FPaddleThread.Free();
      FPaddleThread := nil;
   end;

   if FInitialized = False then begin
      Exit;
   end;

   timeKillEvent(FTimerID);
   timeEndPeriod(1);

   if FUseSideTone then begin
      NoSound();
   end;

   CW_OFF(0);
   CW_OFF(1);
   CW_OFF(2);
   CW_OFF(3);
   CW_OFF(4);

   KeyingPort[0] := tkpNone;
   KeyingPort[1] := tkpNone;
   KeyingPort[2] := tkpNone;
   KeyingPort[3] := tkpNone;
   KeyingPort[4] := tkpNone;

   if ZComTxRigSelect.Connected then begin
      ZComTxRigSelect.Disconnect();
   end;
   if ZComRxRigSelect.Connected then begin
      ZComRxRigSelect.Disconnect();
   end;
end;

procedure TdmZLogKeyer.PauseCW;
begin
   if FUseWinKeyer = True then begin
      Exit;
   end;

   FSendOK := False;

   CW_OFF(FWkTx);
   if FUseSideTone then begin
      NoSound();
   end;

   if FPTTEnabled then begin
      ControlPTT(FWkTx, False);
   end;
end;

procedure TdmZLogKeyer.ResumeCW;
begin
   if FUseWinKeyer = True then begin
      Exit;
   end;

   if FPTTEnabled then begin
//      ControlPTT(FWkTx, True);
      FKeyingCounter := FPttDelayBeforeCount;
   end;

   FSendOK := True;
end;

procedure TdmZLogKeyer.IncWPM;
begin
   FTemporarySpeedChange := True;
   if FKeyerWPM < MAXWPM then begin
      WPM := FKeyerWPM + 1;
   end;
   FTemporarySpeedChange := False;
end;

procedure TdmZLogKeyer.DecWPM;
begin
   FTemporarySpeedChange := True;
   if FKeyerWPM > MINWPM then begin
      WPM := FKeyerWPM - 1;
   end;
   FTemporarySpeedChange := False;
end;

procedure TdmZLogKeyer.ChangeWPM(sign: Integer; change: Integer);
var
   new_wpm: Integer;
begin
   FTemporarySpeedChange := True;

   if sign = 0 then begin
      new_wpm := FKeyerWPM + change;
   end
   else begin
      new_wpm := FKeyerWPM - change;
   end;

   if (new_wpm >= MINWPM) and (new_wpm <= MAXWPM) then begin
      WPM := new_wpm;
   end;

   FTemporarySpeedChange := False;
end;

procedure TdmZLogKeyer.SetWeight(W: word);
begin
   if W in [0 .. 100] then begin
      FKeyerWeight := W;
      WPM := FKeyerWPM;
   end;
end;

procedure TdmZLogKeyer.ClrBuffer;
var
   m: Integer;
   mode: Byte;
begin
   if FUseWinKeyer = True then begin
      if FTune = True then begin
         WinKeyerTuneOff();
         FTune := False;
      end;

      WinKeyerClear();

      // Set PTT Mode(PINCFG)
      WinKeyerSetPinCfg(True);

      // set serial echo back to on
      mode := WK_SETMODE_SERIALECHOBACK;
      // Paddle reverse
      if FPaddleReverse = True then begin
         mode := mode or WK_SETMODE_PADDLESWAP;
      end;
      WinKeyerSetMode(mode);
   end
   else begin
      FTune := False;
      { SendOK:=False; }
      { StringBuffer := ''; }

      CWBufferSync.Enter();
      try
         for m := 0 to 2 do begin
            FCWSendBuf[m, 1] := $FF;
         end;
         cwstrptr := 0;
         FSelectedBuf := 0; // ver 2.1b
         FSendChar := False;
         callsignptr := 0;
         tailcwstrptr := 1;
         mousetail := 1;
         paddle_waiting := True;


      if FUseSideTone then begin
         NoSound();
      end;
      CW_OFF(FWkTx);
      ResetSpeed();
      FUserFlag := False;

      FSendOK := True;

      finally
         CWBufferSync.Leave();
      end;
   end;

   if FPTTEnabled then begin
      ControlPTT(FWkTx, False);
   end;

   if Assigned(FOnOneCharSentProc) then begin
      FOnOneCharSentProc(nil);
   end;
end;

procedure TdmZLogKeyer.CancelLastChar;
begin
   if FUseWinKeyer = True then begin
      WinKeyerCancelLastChar();
   end
   else begin
      CWBufferSync.Enter();
      try
         if ((tailcwstrptr - 1) * codemax + 1) > (cwstrptr) then begin
            Dec(tailcwstrptr, 1);
            if tailcwstrptr <= 0 then begin
               tailcwstrptr := 1;
            end;
            SetCWSendBufFinish(0);
         end;
      finally
         CWBufferSync.Leave();
      end;
   end;
end;

procedure TdmZLogKeyer.SetCWSendBufChar2(C: char; CharPos: word);
var
   m: Integer;
begin
   for m := 1 to codemax do begin
      FCWSendBuf[0, codemax * (CharPos - 1) + m] := FCodeTable[Ord(C)][m];
   end;
end;

procedure TdmZLogKeyer.SetCallSign(S: string);
var
   SS: string;
   i: Integer;
begin
   S := StringReplace(S, '.', '?', [rfReplaceAll]);
   i := Pos('?', S);
   if i > 0 then begin
      S := Copy(S, 1, i);
   end;

   if FUseWinKeyer = True then begin
      FWkCallsignStr := S;
   end
   else begin
      // 送信中は0文字にはできない
      if (IsPlaying = True) and (S = '') then begin
         Exit;
      end;

      FWkCallsignStr := S;

      if callsignptr = 0 then begin
         Exit;
      end;

      SS := S + '*********************';

      SS[BGKCALLMAX] := '^'; { pause }

      for i := 1 to BGKCALLMAX do begin
         SetCWSendBufChar2(char(SS[i]), callsignptr + i - 1);
      end;

      {$IFDEF DEBUG}
      DumpSendBuf();
      {$ENDIF}
   end;
end;

procedure TdmZLogKeyer.DumpSendBuf();
var
   i: Integer;
   j: Integer;
   p: Integer;
   ch: Byte;
   S: string;
begin
   OutputDebugString(PChar('*** dump cw buffer ***'));
   OutputDebugString(PChar('NO:00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F'));
   for i := 1 to charmax do begin
      p := ((i - 1) * codemax) + 1;
      ch := FCWSendBuf[0, p];
      if ch = $ff then begin
         Break;
      end;

      S := '';
      for j := 1 to codemax do begin
         p := ((i - 1) * codemax) + j;
         ch := FCWSendBuf[0, p];
         S := S + IntToHex(ch, 2) + ' ';
      end;
      OutputDebugString(PChar(RightStr('00' + IntToStr(i), 2) + ':' + S));
   end;
   OutputDebugString(PChar('*** end ***'));
end;

function TdmZLogKeyer.CallSignSent: Boolean;
begin
   CWBufferSync.Enter();
   try
      Result := False;

      if (callsignptr > 0) and (cwstrptr > 1) then begin
         if FCWSendBuf[0, cwstrptr - 1] = $99 then begin
            Result := True;
            callsignptr := 0;
         end;
      end;
   finally
      CWBufferSync.Leave();
   end;
end;

function TdmZLogKeyer.IsPlaying: Boolean;
begin
   if FUseWinKeyer = False then begin
      if ((cwstrptr > 1) and FSendOK) or (FTune = True) then
         Result := True
      else
         Result := False;
   end
   else begin
      if (FTune = True) then begin
         Result := True;
         Exit;
      end;

      if ((FWkStatus and WK_STATUS_BUSY) = WK_STATUS_BUSY) then begin
         Result := True;
      end
      else begin
         Result := False;
      end;
   end;
end;

procedure TdmZLogKeyer.SetSpaceFactor(R: Integer);
begin
   if R > 0 then begin
      FSpaceFactor := R;
   end;
end;

procedure TdmZLogKeyer.SetEISpaceFactor(R: Integer);
begin
   if R > 0 then begin
      FEISpaceFactor := R;
   end;
end;

function TdmZLogKeyer.GetKeyingPort(Index: Integer): TKeyingPort;
begin
   Result := FKeyingPort[Index];
end;

procedure TdmZLogKeyer.SetKeyingPort(Index: Integer; port: TKeyingPort);
begin
   FKeyingPort[Index] := port;
end;

procedure TdmZLogKeyer.Open();
var
   i: Integer;
   usb_no: Integer;
   fUseUSB: Boolean;
   fUseCOM: Boolean;
   fUseParallel: Boolean;

   procedure UsbInfoClear(n: Integer);
   begin
      FUsbInfo[n].FUSBIF4CW := nil;
      FUsbInfo[n].FPORTDATA := nil;
   end;

   procedure UsbInfoClearAll();
   var
      i: Integer;
   begin
      for i := 0 to 2 do begin
         UsbInfoClear(i);
      end;
   end;

   function GetUsbDev(no: Integer): TJvHidDevice;
   begin
      if usbdevlist.Count = 0 then begin
         Result := nil;
         Exit;
      end;

      if usbdevlist.Count >= (no + 1) then begin
         Result := usbdevlist[no];
      end
      else begin
         Result := usbdevlist[0];
      end;
   end;

   function GetUsbInf(no: Integer): TUsbPortInfo;
   begin
      if usbinflist.Count = 0 then begin
         Result := nil;
         Exit;
      end;

      if usbinflist.Count >= (no + 1) then begin
         Result := usbinflist[no];
      end
      else begin
         Result := usbinflist[0];
      end;
   end;
begin
   if FUsePaddleKeyer = True then begin
      HidController.OnDeviceData := nil;
   end
   else begin
      HidController.OnDeviceData := HidControllerDeviceData;
   end;

   USB_OFF();
   HidController.Enumerate;
   repeat
      Sleep(1);
   until FUsbDetecting = False;

   fUseUSB := False;
   fUseCOM := False;
   fUseParallel := False;
   UsbInfoClearAll();

   // RIG1/RIG2/RIG3全て無し
   if (FKeyingPort[0] = tkpNone) and
      (FKeyingPort[1] = tkpNone) and
      (FKeyingPort[2] = tkpNone) and
      (FKeyingPort[3] = tkpNone) and
      (FKeyingPort[4] = tkpNone) then begin
      COM_OFF();
      USB_OFF();
      Exit;
   end;

   //
   usb_no := 0;
   for i := 0 to MAXPORT do begin
      if (FKeyingPort[i] = tkpUSB) then begin
         FUsbInfo[i].FUSBIF4CW := GetUsbDev(usb_no);
         FUsbInfo[i].FPORTDATA := GetUsbInf(usb_no);
         Inc(usb_no);
         fUseUSB := True;
         FComKeying[i] := nil;
      end
      else if (FKeyingPort[i] = tkpNone) then begin
         FKeyingPort[i] := tkpNone;
         FComKeying[i] := nil;
      end
      else if (FKeyingPort[i] = tkpParallel) then begin
         fUseParallel := TParallelPort.IsParallelPortPresent();
         if fUseParallel = False then begin
            FKeyingPort[i] := tkpNone;
         end;
         FComKeying[i] := nil;
      end
      else begin
         fUseCom := True;
      end;
   end;

   // RIG1がCOMポートで
   if (FKeyingPort[0] in [tkpSerial1 .. tkpSerial20]) then begin
      // RIG1 = RIG2 なら RIG1
      if (FKeyingPort[0] = FKeyingPort[1]) then begin
         FComKeying[1] := FComKeying[0];
      end;

      // RIG1 = RIG3 なら RIG1
      if (FKeyingPort[0] = FKeyingPort[2]) then begin
         FComKeying[2] := FComKeying[0];
      end;

      // RIG2 = RIG3 なら RIG2
      if (FKeyingPort[1] = FKeyingPort[2]) then begin
         FComKeying[2] := FComKeying[1];
      end;
   end;

   // RIG-1/2のKeyingポートとOTRSPポートが同じ場合
   if ((FSo2rType = so2rOtrsp) and
       (FKeyingPort[0] = FKeyingPort[1]) and
       (FKeyingPort[0] = FSo2rOtrspPort)) then begin
      FSameOtrsp := True;
      FComKeying[0] := ZComTxRigSelect;
      FComKeying[1] := ZComTxRigSelect;
   end
   else begin
      FSameOtrsp := False;
   end;

   if fUseUSB = True then begin
      USB_ON();
   end;
   if fUseCOM = True then begin
      COM_ON();
   end;

   // RIG選択用ポート
   case FSo2rType of
      so2rNone: begin

      end;

      so2rCom: begin
         // RX
         if FSo2rRxSelectPort <> tkpNone then begin
            ZComRxRigSelect.Port := TPortNumber(FSo2rRxSelectPort);
            ZComRxRigSelect.Connect();
            ZComRxRigSelect.ToggleDTR(False);
            ZComRxRigSelect.ToggleRTS(False);
         end;

         // TX
         if FSo2rTxSelectPort <> tkpNone then begin
            ZComTxRigSelect.Port := TPortNumber(FSo2rTxSelectPort);
            ZComTxRigSelect.Connect();
            ZComTxRigSelect.ToggleDTR(False);
            ZComTxRigSelect.ToggleRTS(False);
         end;
      end;

      so2rNeo: begin

      end;

      so2rOtrsp: begin
         if (FSo2rOtrspPort <> tkpNone) and (FSameOtrsp = False) then begin
            ZComTxRigSelect.Port := TPortNumber(FSo2rOtrspPort);
            SetOtrspPortParam(ZComTxRigSelect);
            ZComTxRigSelect.Connect();
            ZComTxRigSelect.ToggleDTR(False);
            ZComTxRigSelect.ToggleRTS(False);
         end;
      end;

      so2rParallel: begin
         fUseParallel := TParallelPort.IsParallelPortPresent();
         if fUseParallel = False then begin
            FSo2rType := so2rNone;
         end;
      end;
   end;

   if fUseParallel = True then begin
      FParallelPort.Open();
   end;
end;

procedure TdmZLogKeyer.Close();
begin
   COM_OFF();
   USB_OFF();

   // RIG選択用ポート
   // RX
   if FSo2rRxSelectPort <> tkpNone then begin
      ZComRxRigSelect.ToggleDTR(False);
      ZComRxRigSelect.ToggleRTS(False);
      ZComRxRigSelect.Disconnect();
   end;

   // TX
   if FSo2rTxSelectPort <> tkpNone then begin
      ZComTxRigSelect.ToggleDTR(False);
      ZComTxRigSelect.ToggleRTS(False);
      ZComTxRigSelect.Disconnect();
   end;

   // OTRSP
   if FSo2rOtrspPort <> tkpNone then begin
      ZComTxRigSelect.Disconnect();
   end;

   // パラレルポート
   FParallelPort.Close();
end;

procedure TdmZLogKeyer.TuneOn(nID: Integer);
begin
   ClrBuffer;
   FSendOK := False;

   FTune := True;

   if FPTTEnabled then begin
      ControlPTT(nID, True);
   end;

   if (FUseWinKeyer = False) then begin
      CW_ON(nID);

      if FUseSideTone then begin
         Sound();
      end;
   end
   else begin
      // WinKeyer
      WinkeyerTuneOn();
   end;
end;

procedure TdmZLogKeyer.SendUsbPortData(nID: Integer);
var
//   BR: DWORD;
   OutReport: array[0..8] of Byte;
begin
   if FUsbInfo[nID].FUSBIF4CW = nil then begin
      Exit;
   end;
   if FUsbInfo[nID].FPORTDATA.FUsbPortData = FUsbInfo[nID].FPORTDATA.FPrevUsbPortData then begin
      Exit;
   end;

   OutReport[0] := 0;
   OutReport[1] := 1;
   OutReport[2] := FUsbInfo[nID].FPORTDATA.FUsbPortData;
   OutReport[3] := 0;
   OutReport[4] := 0;
   OutReport[5] := 0;
   OutReport[6] := 0;
   OutReport[7] := 0;
   OutReport[8] := 0;
   FUsbInfo[nID].FUSBIF4CW.SetOutputReport(OutReport, 9);
   FUsbInfo[nID].FPORTDATA.FPrevUsbPortData := FUsbInfo[nID].FPORTDATA.FUsbPortData;
//   FUSBIF4CW.WriteFile(OutReport, FUSBIF4CW.Caps.OutputReportByteLength, BR);
end;

procedure TdmZLogKeyer.COM_ON();
var
   i: Integer;
begin
   if FUseWinKeyer = True then begin
      WinKeyerOpen(FKeyingPort[0]);
      Exit;
   end;

   for i := 0 to MAXPORT do begin
      if FComKeying[i] = nil then begin
         Continue;
      end;

      if FComKeying[i].Connected = False then begin
         FComKeying[i].Port := TPortNumber(FKeyingPort[i]);
         if FSameOtrsp = True then begin
            SetOtrspPortParam(FComKeying[i]);
         end;
         FComKeying[i].Connect;
      end;

      if FKeyingPortConfig[i].FRts = paAlwaysOn then begin
         FComKeying[i].ToggleRTS(True);
      end
      else begin
         FComKeying[i].ToggleRTS(False);
      end;

      if FKeyingPortConfig[i].FDtr = paAlwaysOn then begin
         FComKeying[i].ToggleDTR(True);
      end
      else begin
         FComKeying[i].ToggleDTR(False);
      end;

      FComKeying[i].ToggleDTR(False);
      FComKeying[i].ToggleRTS(False);
   end;
end;

procedure TdmZLogKeyer.COM_OFF();
var
   i: Integer;
begin
   if FUseWinKeyer = True then begin
      WinKeyerClose();
      Exit;
   end;

   for i := 0 to 2 do begin
      if FComKeying[i] = nil then begin
         Continue;
      end;

      FComKeying[i].Disconnect();
   end;
end;

procedure TdmZLogKeyer.USB_ON();
var
   i: Integer;
begin
   for i := 0 to 2 do begin
      if FUsbInfo[i].FUSBIF4CW <> nil then begin
         FUsbInfo[i].FPORTDATA.Clear();

         // TXセレクト
         FUsbInfo[i].FPORTDATA.SetRigFlag(FWkTxRigSet);
         if FGen3MicSelect = False then begin
            FUsbInfo[i].FPORTDATA.SetVoiceFlag(FWkTxRigSet);
         end;

         // 送信
         SendUsbPortData(i);

         // パドル動作をセット
         if FPaddleReverse = True then begin
            usbif4cwSetPaddle(i, 1);
            mouX := 3;
            mouY := 1;
         end
         else begin
            usbif4cwSetPaddle(i, 0);
            mouX := 1;
            mouY := 3;
         end;

         // WPMをセット
         usbif4cwSetWPM(i, FKeyerWPM);
      end;
   end;
end;

procedure TdmZLogKeyer.USB_OFF();
var
   i: Integer;
   HidDev: TJvHidDevice;
begin
   for i := 0 to usbdevlist.Count - 1 do begin
      HidDev := usbdevlist[i];
      HidController.CheckIn(HidDev);
   end;
   usbdevlist.Clear();

   FUsbInfo[0].FUSBIF4CW := nil;
   FUsbInfo[1].FUSBIF4CW := nil;
   FUsbInfo[2].FUSBIF4CW := nil;

   FUSBIF4CW_Detected := False;
end;

procedure TdmZLogKeyer.SetUseSideTone(fUse: Boolean);
begin
   FUseSideTone := fUse;
   if fUse = False then begin
      NoSound();
   end;

   if FUseWinKeyer = True then begin
      WinKeyerSetSideTone(fUse);
   end;
end;

procedure TdmZLogKeyer.SetSideToneVolume(v: Integer);
begin
   FSideToneVolume := v;
   {$IFDEF USESIDETONE}
   if Assigned(FTone) then begin
      FTone.Volume := v;
   end;
   {$ENDIF}
end;

{ TKeyerMonitorThread }

constructor TKeyerMonitorThread.Create(AKeyer: TdmZLogKeyer);
begin
   inherited Create(True);
   FKeyer := AKeyer;
end;

procedure TKeyerMonitorThread.DotheJob;
begin
   if Assigned(FKeyer.OnCallsignSentProc) then begin
      {$IFDEF DEBUG}
      OutputDebugString(PChar('*** TKeyerMonitorThread.DotheJob ****'));
      {$ENDIF}
      FKeyer.OnCallsignSentProc(TObject(FKeyer.FWkTxRigSet));
   end;
end;

procedure TKeyerMonitorThread.Execute;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** begin - TKeyerMonitorThread.Execute - ****'));
   {$ENDIF}
   repeat
      SleepEx(2, False);
      if FKeyer.CallsignSent then begin
         Synchronize(DotheJob);
      end;
   until Terminated;
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** end - TKeyerMonitorThread.Execute - ****'));
   {$ENDIF}
end;

{ TPaddleThread }

constructor TPaddleThread.Create(AKeyer: TdmZLogKeyer);
begin
   inherited Create(True);
   FKeyer := AKeyer;
end;

procedure TPaddleThread.Execute;
var
   OutReport : array[0..8] of byte;
   InReport : array[0..8] of byte;
   BR : DWORD;
label nextnext;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** begin - TPaddleThread.Execute - ****'));
   {$ENDIF}
   repeat
      SleepEx(1, False);

      if FKeyer.FUsbInfo[0].FUSBIF4CW = nil then begin
         Sleep(10);
         goto nextnext;
      end;

      if FKeyer.UsePaddleKeyer = False then begin
         Sleep(10);
         goto nextnext;
      end;

      UsbPortDataLock.Enter();
      InReport[0] := 0;
      InReport[1] := 4;
      InReport[2] := $0F;
      InReport[3] := 4;
      InReport[4] := 0;
      InReport[5] := 0;
      InReport[6] := 0;
      InReport[7] := 0;
      InReport[8] := 0;
      FKeyer.FUsbInfo[0].FUSBIF4CW.ReadFile(InReport, FKeyer.FUsbInfo[0].FUSBIF4CW.Caps.InputReportByteLength, BR);
      UsbPortDataLock.Leave();

      if (InReport[1] = 4) and (InReport[3] = 4) and (InReport[2] <> $F) then begin
         FKeyer.PaddleProc((InReport[2] and $05));
      end;

      UsbPortDataLock.Enter();
      if FKeyer.FUsbInfo[0].FPORTDATA.FUsbPortData = FKeyer.FUsbInfo[0].FPORTDATA.FPrevUsbPortData then begin
         OutReport[0] := 0;
         OutReport[1] := 4;
         OutReport[2] := $0F;
         OutReport[3] := 4;
         OutReport[4] := 0;
         OutReport[5] := 0;
         OutReport[6] := 0;
         OutReport[7] := 0;
         OutReport[8] := 0;
         FKeyer.FUsbInfo[0].FUSBIF4CW.WriteFile(OutReport, FKeyer.FUsbInfo[0].FUSBIF4CW.Caps.OutputReportByteLength, BR);
      end
      else begin
         FKeyer.SendUsbPortData(0);
      end;
      UsbPortDataLock.Leave();

nextnext:
   until Terminated;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** end - TPaddleThread.Execute - ****'));
   {$ENDIF}
end;

procedure TdmZLogKeyer.m_set(b: Byte);
begin
   FSendOK := False;
   CWBufferSync.Enter();
   try
      if FPTTEnabled and (mousetail = 1) then begin
         ControlPTT(FWkTx, True);
         FCWSendBuf[0, 1] := $55; {set PTT delay}
         inc(mousetail);
      end;

      if (mousetail + 2) > (charmax * codemax) then mousetail := 1;

      {$IFDEF DEBUG}
      OutputDebugString(PChar('m_set: mousetail=' + IntToStr(mousetail) + ' cwstrptr=' + IntToStr(cwstrptr)));
      {$ENDIF}

      FCWSendBuf[0, mousetail]     := b;
      FCWSendBuf[0, mousetail + 1] := 0;
      FCWSendBuf[0, mousetail + 2] := $AA;
      inc(mousetail, 2);
      p_char_count := (FDotCount * 3) div 2;
   finally
      CWBufferSync.Leave();
      FSendOK := True;
      paddle_waiting := False;
   end;
end;

procedure TdmZLogKeyer.PaddleProc(PaddleStatus: Byte);
var
   ptr: Integer;
begin
   if cwstrptr = 0 then begin
      cwstrptr := 1;
   end;

   case mousetail - cwstrptr of
      0: begin
         case PaddleStatus of
            $00: begin { both }
               ptr := mousetail - 2;
               if ptr < 1 then begin
                  Exit;
               end;

               case FCWSendBuf[0, ptr] of
                  1 : m_set(3);
                  3 : m_set(1);
               end;
            end;

            $01: begin {dit}
               if paddle_waiting then m_set(mouX);
            end;

            $04: begin {dah}
               if paddle_waiting then m_set(mouY);
            end;
         end;
      end;

      1: begin
         ptr := cwstrptr - 1;
         if ptr < 1 then begin
            Exit;
         end;

         case PaddleStatus of
            $00: begin
               case FCWSendBuf[0, ptr] of
                  1: m_set(3);
                  3: m_set(1);
               end;
            end;

            $01: begin
               if FCWSendBuf[0, ptr] = mouY then
                  m_set(mouX);
            end;

            $04: begin
               if FCWSendBuf[0, ptr] = mouX then
                  m_set(mouY);
            end;
         end;
      end;

      else begin
         if (PaddleStatus = $01) or (PaddleStatus = $04) then begin
            if abs(mousetail - cwstrptr) > 5 then begin
               FSelectedBuf := 0;
               cwstrptr := 1;
               mousetail := 1;
               FKeyingCounter := 1;
               paddle_waiting := True;
               m_set(0);
            end;
         end;
      end;
   end;
end;

function TdmZLogKeyer.usbif4cwSetWPM(nID: Integer; nWPM: Integer): Long;
var
   OutReport: array[0..8] of Byte;
   P: Byte;
begin
   if FUsbInfo[nID].FUSBIF4CW = nil then begin
      Result := -1;
      Exit;
   end;

   if usbif4cwGetVersion(nID) < 20 then begin
      Result := -2;
      Exit;
   end;

   nWPM := Max(nWPM, 5);
   nWPM := Min(nWPM, 50);

   P := Round(600 / nWPM);

   OutReport[0] := nID;
   OutReport[1] := $24;
   OutReport[2] := P;
   OutReport[3] := 0;
   OutReport[4] := 0;
   OutReport[5] := 0;
   OutReport[6] := 0;
   OutReport[7] := 0;
   OutReport[8] := $FC;
   FUsbInfo[nID].FUSBIF4CW.SetOutputReport(OutReport, 9);
   Result := 0;
end;

function TdmZLogKeyer.usbif4cwSetPTTParam(nID: Integer; nLen1: Byte; nLen2: Byte): Long;
var
   OutReport: array[0..8] of Byte;
   P: Byte;
begin
   if FUsbInfo[nID].FUSBIF4CW = nil then begin
      Result := -1;
      Exit;
   end;

   if usbif4cwGetVersion(nID) < 20 then begin
      Result := -2;
      Exit;
   end;

   if (nLen1 = 0) and (nLen2 = 0) then begin    // 両方0はOFF
      P := 0;
   end
   else begin
      P := 1;
      nLen1 := Min(nLen1, 254);                 // 最大値は254ms
      nLen2 := Max(nLen2, 50);                  // afterが50ms未満は動作がおかしくなる模様
      nLen2 := Min(nLen2, 254);                 // 最大値は254ms
      OutReport[0] := nID;
      OutReport[1] := $22;
      OutReport[2] := nLen1;
      OutReport[3] := nLen2;
      OutReport[4] := 0;
      OutReport[5] := 0;
      OutReport[6] := 0;
      OutReport[7] := 0;
      OutReport[8] := 0;
      FUsbInfo[nID].FUSBIF4CW.SetOutputReport(OutReport, 9);
   end;

   OutReport[0] := nID;
   OutReport[1] := $25;
   OutReport[2] := P;
   OutReport[3] := 0;
   OutReport[4] := 0;
   OutReport[5] := 0;
   OutReport[6] := 0;
   OutReport[7] := 0;
   OutReport[8] := 0;
   FUsbInfo[nID].FUSBIF4CW.SetOutputReport(OutReport, 9);

   Result := 0;
end;

function TdmZLogKeyer.usbif4cwSetPTT(nID: Integer; tx: Byte): Long;
var
   OutReport: array[0..8] of Byte;
begin
   if FUsbInfo[nID].FUSBIF4CW = nil then begin
      Result := -1;
      Exit;
   end;

   if usbif4cwGetVersion(nID) < 20 then begin
      Result := -2;
      Exit;
   end;

   OutReport[0] := nID;
   OutReport[1] := $35;
   OutReport[2] := 0;
   OutReport[3] := tx;
   OutReport[4] := 0;
   OutReport[5] := 0;
   OutReport[6] := 0;
   OutReport[7] := 0;
   OutReport[8] := $FC;
   FUsbInfo[nID].FUSBIF4CW.SetOutputReport(OutReport, 9);
   Result := 0;
end;

function TdmZLogKeyer.usbif4cwGetVersion(nID: Integer): Long;
var
   HidDev: TJvHidDevice;
   n: Integer;
   s: string;
   ver: Long;
begin
   HidDev := FUsbInfo[nID].FUSBIF4CW;
   if HidDev = nil then begin
      Result := 0;
      Exit;
   end;

   n := Pos('Ver.', HidDev.ProductName);
   if n > 0 then begin
      s := Copy(HidDev.ProductName, n + 4); // 2.3
      ver := Trunc(StrToFloatDef(s, 0) * 10);
   end
   else begin
      ver := 0;
   end;

   Result := ver;
end;

function TdmZLogKeyer.usbif4cwSetPaddle(nID: Integer; param: Byte): Long;
var
   OutReport: array[0..8] of Byte;
begin
   if FUsbInfo[nID].FUSBIF4CW = nil then begin
      Result := -1;
      Exit;
   end;

   if usbif4cwGetVersion(nID) < 20 then begin
      Result := -2;
      Exit;
   end;

   OutReport[0] := nID;
   OutReport[1] := $26;
   OutReport[2] := 0;
   OutReport[3] := 0;
   OutReport[4] := param;
   OutReport[5] := 0;
   OutReport[6] := 0;
   OutReport[7] := 0;
   OutReport[8] := $FC;
   FUsbInfo[nID].FUSBIF4CW.SetOutputReport(OutReport, 9);
   Result := 0;
end;

procedure TdmZLogKeyer.usbif4cwSetPort(port: Integer; value: Boolean);
var
   i: Integer;
   v: Integer;
begin
   if value then v := 1 else v := 0;
   for i := 0 to MAXPORT do begin
      if FKeyingPort[i] = tkpUSB then begin
         UsbPortDataLock.Enter();
         if Assigned(FUsbInfo[i].FPORTDATA) then begin
            case port of
               0: FUsbInfo[i].FPORTDATA.SetKeyFlag(value);
               1: FUsbInfo[i].FPORTDATA.SetPttFlag(value);
               2: FUsbInfo[i].FPORTDATA.SetRigFlag(v);
               3: FUsbInfo[i].FPORTDATA.SetVoiceFlag(v);
            end;
            SendUsbPortData(i);
         end;
         UsbPortDataLock.Leave();
      end;
   end;
end;

procedure TdmZLogKeyer.SetCommPortDriver(Index: Integer; CP: TCommPortDriver);
begin
   if FComKeying[Index] = CP then begin
      Exit;
   end;

   COM_OFF();
   FComKeying[Index] := CP;
//   COM_ON(FKeyingPort);

   if Assigned(CP) then begin
      FKeyingPort[Index] := TKeyingPort(CP.Port);
   end
   else begin
      FKeyingPort[Index] := tkpNone;
   end;
end;

procedure TdmZLogKeyer.ResetCommPortDriver(Index: Integer; port: TKeyingPort);
begin
   if FComKeying[Index] = FDefautCom[Index] then begin
      Exit;
   end;

//   COM_OFF();
   FComKeying[Index] := FDefautCom[Index];
//   COM_ON(FKeyingPort);

   KeyingPort[Index] := port;
end;

procedure TdmZLogKeyer.WinKeyerOpen(nPort: TKeyingPort);
var
   Buff: array[0..10] of Byte;
   dwTick: DWORD;
   mode: Byte;
begin
   FWkInitializeMode := False;
   FWkRevision := 0;
   FWkStatus := 0;
   FWkEcho := 0;
   FWkLastMessage := '';
   FWkSendStatus := wkssNone;
   FWkAbort := False;

   //1) Open serial communications port. Use 1200 baud, 8 data bits, no parity
   FComKeying[0].Port := TPortNumber(nPort);
   if (FSo2rType = so2rNeo) or (FUseWkAlways9600 = True) then begin
      FComKeying[0].BaudRate := br9600;
   end
   else begin
      FComKeying[0].BaudRate := br1200;
   end;
   FComKeying[0].Connect();

   //2) To power up WK enable DTR and disable RTS
   FComKeying[0].ToggleDTR(True);
   FComKeying[0].ToggleRTS(False);

   //3) Delay for ? second to allow WK to finish init
   Sleep(500);

   //4) Purge the receive port to make sure there are no stray Rx characters sitting in the
   // buffer. This is done by simply reading the port until empty.

   //5) Issue a calibration command:
   //Byte 0: ADMIN_CMD
   //Byte 1: ADMIN_CAL
   //Byte 2: 0xFF
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_ADMIN_CMD;
   Buff[1] := WK_ADMIN_CAL;
   FComKeying[0].SendData(@Buff, 2);
   Sleep(100);
   Buff[0] := $FF;
   FComKeying[0].SendData(@Buff, 1);

   // Baud rate change must be handled in a specific way. Since most applications expect WK3 to run at
   // 1200 baud, this is always the default and will be reinstated whenever WK3 is closed. If an
   // application wants to run at 9600 baud, it must start out at 1200 baud mode and then issue the Set
   // High Baud command. When the application closes it should issue a WK close command which will
   // reset the baud rate to 1200.
   if (FSo2rType <> so2rNeo) and (FUseWk9600 = True) and (FUseWkAlways9600 = False) then begin
      FillChar(Buff, SizeOf(Buff), 0);
      Buff[0] := WK_ADMIN_CMD;
      Buff[1] := WK_ADMIN_SET_HIGH_BAUD;
      FComKeying[0].SendData(@Buff, 2);
      Sleep(50);
      FComKeying[0].BaudRate := br9600;
   end;

   //6) Check to make sure WK is attached and operational
   //Byte 0: ADMIN_CMD
   //Byte 1: ADMIN_ECHO
   //Byte 2: 0x55
//   FMemo[n].Lines.Add('---6) Check to make sure WK is attached and operational---');
//   Buff[0] := WK_ADMIN_CMD;
//   Buff[1] := WK_ADMIN_ECHO;
//   Buff[2] := $55;
//   FCP[n].SendData(@Buff, 3);

   //Now read Rx until 0x55 is returned or you reach a 1 second timeout, if you timed
   //out that means WK is not connected, the serial port selection is incorrect, there is
   //something wrong with the cable or WK itself is no working.

   //7) Now it’s time to officially open the WK interface, this is done by the following
   //command sequence:
   // Byte 0: ADMIN_CMD
   // Byte 1: ADMIN_OPEN
   FWkInitializeMode := True;
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_ADMIN_CMD;
   Buff[1] := WK_ADMIN_OPEN;
   FComKeying[0].SendData(@Buff, 2);
   WinKeyerSleep(50);

   // set to WK2 mode
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_ADMIN_CMD;
   Buff[1] := WK_ADMIN_SET_WK2_MODE;
   FComKeying[0].SendData(@Buff, 2);
   WinKeyerSleep(50);

   // set serial echo back to on
   mode := WK_SETMODE_SERIALECHOBACK;
   // Paddle reverse
   if FPaddleReverse = True then begin
      mode := mode or WK_SETMODE_PADDLESWAP;
   end;
   WinKeyerSetMode(mode);

   //set speed pot range  5 to 50wpm
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_SET_SPEEDPOT_CMD;
   Buff[1] := $05;    // min 5wpm
   Buff[2] := $32;    //range 50wpm
   Buff[3] := $00;
   FComKeying[0].SendData(@Buff, 4);

   dwTick := GetTickCount();
   while FWkRevision = 0 do begin
      Application.ProcessMessages();
      if (GetTickCount() - dwTick) >= 1000 then begin
         Exit;
      end;
   end;
   FWkInitializeMode := False;

   // WK will respond with its firmware revision byte to let you know it opened
   // correctly. If it does not respond with in ? second (very unlikely if the echo
   // command completed properly) something went wrong and needs to be addressed
   // before continuing.

//   Buff[0] := WK_SET_SPEEDPOT_CMD;
//   Buff[1] := updown1.Min;
//   Buff[2] := updown1.Max - updown1.Min;
//   Buff[3] := 0;
//   FComKeying.SendData(@Buff, 4);
//
//   Sleep(200);

   // 現在のSPEED POT位置を取得
   if FSo2rType <> so2rNeo then begin
      FillChar(Buff, SizeOf(Buff), 0);
      Buff[0] := WK_GET_SPEEDPOT_CMD;
      FComKeying[0].SendData(@Buff, 1);
      Sleep(50);
   end;

   // Set PTT Mode(PINCFG)
   WinKeyerSetPinCfg(True);

   // Set PTT Delay time
   WinKeyerSetPTTDelay(FPttDelayBeforeTime, FPttDelayAfterTime);

   // Set keying speed
   WinKeyerSetSpeed(FKeyerWPM);

   // SideTone
   WinKeyerSetSideTone(FUseSideTone);
end;

procedure TdmZLogKeyer.WinKeyerClose();
var
   Buff: array[0..4] of Byte;
begin
   if Assigned(FComKeying[0]) = False then Exit;
   if FComKeying[0].Connected = False then Exit;

   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_ADMIN_CMD;
   Buff[1] := WK_ADMIN_CLOSE;
   FComKeying[0].SendData(@Buff, 2);
   WinKeyerSleep(50);
   FComKeying[0].Disconnect();
end;

procedure TdmZLogKeyer.WinKeyerSetSpeed(nWPM: Integer);
var
   Buff: array[0..10] of Byte;
begin
   if Assigned(FComKeying[0]) = False then Exit;
   if FComKeying[0].Connected = False then Exit;

   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_SETWPM_CMD;
   Buff[1] := nWPM;
   FComKeying[0].SendData(@Buff, 2);
//   WinKeyerSleep(50);
end;

procedure TdmZLogKeyer.WinKeyerAbort();
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** WinKeyerAbort ***'));
   {$ENDIF}

   FWkAbort := True;
   if Assigned(FOnSendFinishProc) then begin
      FOnSendFinishProc(nil, mCW, True);
   end;
end;

procedure TdmZLogKeyer.WinKeyerClear();
var
   Buff: array[0..10] of Byte;
begin
   if FWkSendStatus = wkssNone then begin
      FillChar(Buff, SizeOf(Buff), 0);
      Buff[0] := WK_CLEAR_CMD;
      FComKeying[0].SendData(@Buff, 1);
      FWkLastMessage := '';
      FWkAbort := False;
      FWkSendStatus := wkssNone;
      FWkMessageStr := '';
      FWkMessageIndex := 1;
      FWkStatus := 0;
//      WinKeyerSleep(50);
   end
   else begin
      FWkAbort := True;
   end;
end;

procedure TdmZLogKeyer.WinKeyerSetSideTone(fOn: Boolean);
var
   Buff: array[0..10] of Byte;
begin
   if Assigned(FComKeying[0]) = False then Exit;
   if FComKeying[0].Connected = False then Exit;

   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_SIDETONE_CMD;
   if fOn = True then begin
      Buff[1] := $06;
   end
   else begin
      Buff[1] := $86;
   end;
   FComKeying[0].SendData(@Buff, 2);
   WinKeyerSleep(50);
end;

procedure TdmZLogKeyer.WinKeyerSetPinCfg(fUsePttPort: Boolean);
var
   Buff: array[0..10] of Byte;
begin
   // Set PINCFG
   //     1010 1100
   //     A    C
   // b7 b6 b5 b4 b3 b2 b1 b0
   //              K  K  S  P
   //              e  e  i  T
   //              y  y  d  T
   //              1  2  e
   // b0は0でPTT制御をzLogが行う、1でPTT制御をWinKeyerが行う
   // b2とb3はdatasheetと現物は逆になっている
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_SET_PINCFG_CMD;
   Buff[1] := $a0;

   // PTT制御有無
   if fUsePttPort = True then begin
      Buff[1] := Buff[1] or $1;
   end
   else begin
      Buff[1] := Buff[1] and $fe;
   end;

   // サイドトーン有無
   if FUseSideTone = True then begin
      Buff[1] := Buff[1] or $2;
   end;

   // b2とb3の両方を0にするとKEY/PTT両方が全く出力されなくなる
   if FUseWkOutpSelect = True then begin
      if FWkTxRigSet = 0 then begin
         Buff[1] := Buff[1] or $4;
      end
      else if FWkTxRigSet = 1 then begin
         Buff[1] := Buff[1] or $8;
      end
      else begin
         // RIG3は全く出力しなくて良い
         //Buff[1] := Buff[1] or $c;  // $4 + $8
      end;
   end
   else begin
      // RIG選択を使用しない時は両方に出力する
      Buff[1] := Buff[1] or $c;  // $4 + $8
   end;

   FComKeying[0].SendData(@Buff, 2);
   WinKeyerSleep(50);

   FPTTFLAG := False;
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_PTT_CMD;
   Buff[1] := WK_PTT_OFF;
   FComKeying[0].SendData(@Buff, 2);
   WinKeyerSleep(50);
end;

// PTT On/Off <18><nn> nn = 01 PTT on, n = 00 PTT off
//
// This command allows the PTT output to be used for a custom purpose.
// The command is operational only when PTT is disabled
// (see PINCFG command on page 9).
procedure TdmZLogKeyer.WinKeyerControlPTT(fOn: Boolean);
var
   Buff: array[0..10] of Byte;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** WinKeyerControlPTT ***'));
   {$ENDIF}

   FPTTFLAG := fOn;

   if FPttEnabled = False then begin
      Exit;
   end;

   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_PTT_CMD;
   if fOn = True then begin
      Buff[1] := WK_PTT_ON;
   end
   else begin
      Buff[1] := WK_PTT_OFF;
   end;

   FComKeying[0].SendData(@Buff, 2);
//   WinKeyerSleep(50);

   if Assigned(FOnWkStatusProc) then begin
      FOnWkStatusProc(nil, FWkTxRigSet, FWkRxRigSet, FPTTFLAG);
   end;
end;

procedure TdmZLogKeyer.WinKeyerSetPTTDelay(before, after: Byte);
var
   Buff: array[0..10] of Byte;
begin
   if Assigned(FComKeying[0]) = False then Exit;
   if FComKeying[0].Connected = False then Exit;

   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_SET_PTTDELAY_CMD;
   Buff[1] := before div 10;
   Buff[2] := after div 10;
   FComKeying[0].SendData(@Buff, 3);
   WinKeyerSleep(50);
end;

procedure TdmZLogKeyer.WinKeyerSetMode(mode: Byte);
var
   Buff: array[0..10] of Byte;
begin
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_SETMODE_CMD;
   Buff[1] := mode;
   FComKeying[0].SendData(@Buff, 2);
   WinKeyerSleep(50);
end;

procedure TdmZLogKeyer.WinKeyerSendChar(C: Char);
var
   S: string;
begin
   case C of
      ' ', 'A'..'Z', '0'..'9', '/', '?', '.', 'a', 'b', 'k', 's', 't', 'v', '-', '=': begin
         S := C;
         FWkLastSendChar := C;
         FComKeying[0].SendString(AnsiString(S));
      end;
   end;
end;

procedure TdmZLogKeyer.WinKeyerSendCharEx(C: Char);
var
   nCommand: Integer;
begin
   if C = '@' then begin
      nCommand := StrToIntDef(FWkMessageStr[FWkMessageIndex + 1], 0) * 100;
      nCommand := nCommand + StrToIntDef(FWkMessageStr[FWkMessageIndex + 2], 0) * 10;
      nCommand := nCommand + StrToIntDef(FWkMessageStr[FWkMessageIndex + 3], 0);
      Inc(FWkMessageIndex, 3);

      if Assigned(FOnCommand) then begin
         FOnCommand(Self, nCommand);
      end;

      PostMessage(FWnd, WM_USER_WKSENDNEXTCHAR2, 0, 0);
   end
   else begin
      WinKeyerSendChar(C);
   end;
end;

//
// WinKeyerメッセージ送信（未使用）
// 一度に送るため途中訂正不可
//
procedure TdmZLogKeyer.WinKeyerSendStr(nID: Integer; S: string);
begin
   if FWkAbort = True then begin
      Exit;
   end;

   FWkTx := nID;

   ControlPTT(nID, True);

   if FSo2rType = so2rNeo then begin
      So2rNeoReverseRx(nID);
   end;

   S := WinKeyerBuildMessage(S);

   FComKeying[0].SendString(AnsiString(S));
end;

//
// WinKeyerメッセージ送信
// エコーバックを待って１文字ずつ送信する方式
// $Cがあったらコールサイン送信を行う
//
procedure TdmZLogKeyer.WinKeyerSendStr2(S: string);
var
   C: Char;
   SS: string;
begin
   if FWkAbort = True then begin
      Exit;
   end;

   S := WinKeyerBuildMessage(S);

   FWkAbort := False;
   FWkMessageIndex := 1;
   FWkMessageStr := S;
   FWkSendStatus := wkssMessage;
   FWkLastSendChar := Char(0);
   C := FWkMessageStr[FWkMessageIndex];

   if C = Char($1c) then begin
      Inc(FWkMessageIndex);
      SS := C + FWkMessageStr[FWkMessageIndex];
      FComKeying[0].SendString(AnsiString(SS));

      if Assigned(FOnOneCharSentProc) then begin
         FOnOneCharSentProc(Self);
         FOnOneCharSentProc(Self);
         FOnOneCharSentProc(Self);
      end;

      PostMessage(FWnd, WM_USER_WKSENDNEXTCHAR2, 0, 0);
      Exit;
   end;

   if C = '|' then begin
      SS := C;
      FComKeying[0].SendString(AnsiString(SS));

      if Assigned(FOnOneCharSentProc) then begin
         FOnOneCharSentProc(Self);
      end;

      PostMessage(FWnd, WM_USER_WKSENDNEXTCHAR2, 0, 0);
      Exit;
   end;

   if C = '$' then begin
      // CWモニターを１文字進める
      if Assigned(FOnOneCharSentProc) then begin
         FOnOneCharSentProc(Self);
      end;

      Inc(FWkMessageIndex);

      C := FWkMessageStr[FWkMessageIndex];
      if C = 'C' then begin
         // CWモニターを１文字進める
         if Assigned(FOnOneCharSentProc) then begin
            FOnOneCharSentProc(Self);
         end;

         FWkSendStatus := wkssCallsign;
         FWkCallsignIndex := 0;
         PostMessage(FWnd, WM_USER_WKSENDNEXTCHAR, 0, 0);
         Exit;
      end;
   end;

   WinKeyerSendCharEx(C);
end;

function TdmZLogKeyer.WinKeyerBuildMessage(S: string): string;
var
   p: Integer;
   n: Integer;
   S2: string;
   S3: string;
   wpm: Integer;
begin
   // PTT ON/OFF
//   S := StringReplace(S, '(', #$18#01, [rfReplaceAll]);
//   S := StringReplace(S, ')', #$18#00, [rfReplaceAll]);
   S := StringReplace(S, '(', '', [rfReplaceAll]);
   S := StringReplace(S, ')', '', [rfReplaceAll]);

   // AR
   S := StringReplace(S, 'a', #$1b + 'AR', [rfReplaceAll]);

   // BK
   S := StringReplace(S, 'b', #$1b + 'BK', [rfReplaceAll]);
   S := StringReplace(S, '~', #$1b + 'BK', [rfReplaceAll]);

   // BT
   S := StringReplace(S, 't', #$1b + 'BT', [rfReplaceAll]);

   // KN
   S := StringReplace(S, 'k', #$1b + 'KN', [rfReplaceAll]);

   // SK/VA
   S := StringReplace(S, 's', #$1b + 'SK', [rfReplaceAll]);
   S := StringReplace(S, 'v', #$1b + 'VA', [rfReplaceAll]);

   // GAP
   // Winkeyer2 interprets the | character (hex 0x7C) as a 1/2 dit delay time. The | character can be included in a
   // text string to add extra emphasis to similar sounding sequences. An example is W1OMO, sending it as
   // W1|O|M|O makes it easier to copy.
   S := StringReplace(S, '_', '|', [rfReplaceAll]);

   S := StringReplace(S, '.', '?', [rfReplaceAll]);

   // unsupport
   S := StringReplace(S, ':', '', [rfReplaceAll]);
   S := StringReplace(S, '*', '', [rfReplaceAll]);
   S := StringReplace(S, '@', '', [rfReplaceAll]);

   // \+1..9, \-1..9
   wpm := FKeyerWPM;
   while Pos('\', S) > 0 do begin
      p := Pos('\', S);
      S2 := Copy(S, p, 3);
      n := StrToIntDef(S2[3], 0);
      if n > 0 then begin
         if S2[2] = '+' then begin
            wpm := wpm + n;
         end
         else if S2[2] = '-' then begin
            wpm := wpm - n;
         end
         else begin
            //
         end;
         S3 := #$1c + Chr(wpm);
         S := StringReplace(S, S2, S3, [rfReplaceAll]);
      end;
   end;

   Result := S;
end;

procedure TdmZLogKeyer.WinKeyerCancelLastChar();
var
   Buff: array[0..10] of Byte;
begin
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_BACKSPACE_CMD;
   FComKeying[0].SendData(@Buff, 1);
end;

procedure TdmZLogKeyer.WinKeyerSendCommand(cmd: Byte; p1: Byte);
var
   Buff: array[0..10] of Byte;
begin
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := cmd;
   Buff[1] := p1;
   FComKeying[0].SendData(@Buff, 2);
end;

procedure TdmZLogKeyer.WinKeyerSendMessage(S: string);
begin
   FComKeying[0].SendString(AnsiString(S));
end;

procedure TdmZLogKeyer.WinKeyerTuneOn();
begin
   WinKeyerSendCommand(WK_KEY_IMMEDIATE_CMD, WK_KEY_IMMEDIATE_KEYDOWN);
end;

procedure TdmZLogKeyer.WinKeyerTuneOff();
begin
   WinKeyerSendCommand(WK_KEY_IMMEDIATE_CMD, WK_KEY_IMMEDIATE_KEYUP);
end;

procedure TdmZLogKeyer.ZComKeying1ReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: DWORD);
var
   i: Integer;
   b: Byte;
   PP: PByte;
   newwpm: Integer;
   C: Char;
begin
   PP := DataPtr;

   if FUseWinKeyer = True then begin
      if FWkInitializeMode = True then begin
         FWkRevision := (PP)^;
         Exit;
      end;

      {$IFDEF DEBUG}
      OutputDebugString(PChar('WinKey DataSize=[' + IntToStr(DataSize) + ']'));
      {$ENDIF}

      for i := 0 to DataSize - 1 do begin
         b := (PP + i)^;

      {$IFDEF DEBUG}
      OutputDebugString(PChar('WinKey Data(' + IntToStr(i) + ')=[' + IntToHex(b, 2) + ']'));
      {$ENDIF}

         if FWkAbort = True then begin
            if FWkSendStatus <> wkssNone then begin
               if Assigned(FOnSendFinishProc) then begin
                  FOnSendFinishProc(nil, mCW, True);
               end;
            end;
            FWkSendStatus := wkssNone;
            ClrBuffer();
            Break;
         end;

         if ((b and $c0) = $c0) then begin    // STATUS
            // Paddle break
            // IDLE->ACTIVE
            if ((FWkStatus and WK_STATUS_BREAKIN) = 0) and
               ((b and WK_STATUS_BREAKIN) = WK_STATUS_BREAKIN) then begin
               PostMessage(FWnd, WM_USER_WKPADDLE, 0, 1);
               {$IFDEF DEBUG}
               OutputDebugString(PChar('WinKey Paddle Active [' + IntToHex(b, 2) + ']'));
               {$ENDIF}
            end;

            // ACTIVE->IDLE
            if ((FWkStatus and WK_STATUS_BREAKIN) = WK_STATUS_BREAKIN) and
               ((b and WK_STATUS_BREAKIN) = 0) then begin
               PostMessage(FWnd, WM_USER_WKPADDLE, 0, 0);
               {$IFDEF DEBUG}
               OutputDebugString(PChar('WinKey Paddle Deactive [' + IntToHex(b, 2) + ']'));
               {$ENDIF}
            end;

            // 送信中→送信終了に変わったら、リピートタイマー起動
            if (FWkSendStatus = wkssMessage) and (FWkLastMessage <> '') and ((FWkStatus and WK_STATUS_BUSY) = WK_STATUS_BUSY) and ((b and WK_STATUS_BUSY) = 0) then begin

               if Assigned(FOnSendFinishProc) then begin
                  {$IFDEF DEBUG}
                  OutputDebugString(PChar(' *** FOnSendFinishProc() called in ZComKeying1ReceiveData() ***'));
                  {$ENDIF}
                  FOnSendFinishProc(Self, mCW, False);
               end;
            end;

            // STATUSを保存
            FWkStatus := b;

//            {$IFDEF DEBUG}
//            OutputDebugString(PChar('WinKey STATUS=[' + IntToHex(b, 2) + ']'));
//            {$ENDIF}
         end
         else if ((b and $c0) = $80) then begin   // POT POSITION
            if FUseWkIgnoreSpeedPot = False then begin
               newwpm := (b and $3F);
               PostMessage(FWnd, WM_USER_WKCHANGEWPM, 0, newwpm);
            end;
         end
         else begin  // ECHO TEST
            FWkEcho := b;

            {$IFDEF DEBUG}
            OutputDebugString(PChar('WinKey ECHOBACK=[' + IntToHex(b, 2) + '(' + Chr(b) + ')]'));
            {$ENDIF}

            // ECHO BACK文字確認
            if (Char(b) <> FWkLastSendChar) then begin
               {$IFDEF DEBUG}
               OutputDebugString(PChar('WinKey BAD ECHOBACK'));
               {$ENDIF}
               Exit;
            end;

            // コールサイン送信中
            if (FWkSendStatus = wkssCallsign) and
               (Length(FWkCallsignStr) >= FWkCallsignIndex) then begin
               // 次の文字を送信
               PostMessage(FWnd, WM_USER_WKSENDNEXTCHAR, 0, 0);
               Exit;
            end;

            // 通常メッセージ送信中
            if (FWkSendStatus = wkssMessage) and
               (Length(FWkMessageStr) >= FWkMessageIndex) then begin

               // CWモニターを１文字進める
               if Assigned(FOnOneCharSentProc) then begin
                  FOnOneCharSentProc(Self);
               end;

               // 次の文字を取得
               if (Length(FWkMessageStr) > FWkMessageIndex) then begin
                  C := FWkMessageStr[FWkMessageIndex + 1];
                  if (C = '$') then begin

                     // CWモニターを１文字進める
                     if Assigned(FOnOneCharSentProc) then begin
                        FOnOneCharSentProc(Self);
                     end;

                     Inc(FWkMessageIndex);
                     C := FWkMessageStr[FWkMessageIndex + 1];
                     if (C = 'C') then begin

                        // CWモニターを１文字進める
                        if Assigned(FOnOneCharSentProc) then begin
                           FOnOneCharSentProc(Self);
                        end;

                        Inc(FWkMessageIndex);

                        // コールサイン送信に移行
                        FWkSendStatus := wkssCallsign;
                        FWkCallsignIndex := 0;
                        PostMessage(FWnd, WM_USER_WKSENDNEXTCHAR, 0, 0);
                        Exit;
                     end;
                  end;
               end;

               // 次の文字を送信
               PostMessage(FWnd, WM_USER_WKSENDNEXTCHAR2, 0, 0);
               Exit;
            end;
         end;
      end;
   end;
end;

procedure TdmZLogKeyer.IncCWSpeed();
begin
   FKeyerInitWPM := FKeyerInitWPM + 1;
   WPM := WPM + 1;
end;

procedure TdmZLogKeyer.DecCWSpeed();
begin
   FKeyerInitWPM := FKeyerInitWPM - 1;
   WPM := WPM - 1;
end;

procedure TdmZLogKeyer.ToggleFixedSpeed();
var
   i : integer;
begin
   FUseFixedSpeed := not(FUseFixedSpeed);

   if FUseFixedSpeed then begin
      i := FFixedSpeed;
      FBeforeSpeed := WPM;
   end
   else begin
      i := FBeforeSpeed;
   end;

   if (i >= MINWPM) and (i <= MAXWPM) then begin
      WPM := i;
   end;

   if Assigned(FOnSpeedChanged) then begin
      FOnSpeedChanged(Self);
   end;
end;

procedure TdmZLogKeyer.ResetSpeed();
begin
   WPM := InitWPM;
end;

procedure TdmZLogKeyer.WndMethod(var msg: TMessage);
var
   C: Char;
   nID: Integer;
   SS: string;
begin
   case msg.Msg of
      WM_USER_WKSENDNEXTCHAR: begin
         Inc(FWkCallsignIndex);
         if FWkCallsignIndex <= Length(FWkCallsignStr) then begin
            C := FWkCallsignStr[FWkCallsignIndex];
            WinKeyerSendChar(C);
         end
         else begin
            FWkSendStatus := wkssMessage;

            if Assigned(FOnCallsignSentProc) then begin
               FOnCallsignSentProc(Self);
            end;

            PostMessage(FWnd, WM_USER_WKSENDNEXTCHAR2, 0, 0);
         end;

         msg.Result := 0;
      end;

      WM_USER_WKSENDNEXTCHAR2: begin
         Inc(FWkMessageIndex);
         if FWkMessageIndex <= Length(FWkMessageStr) then begin
            C := FWkMessageStr[FWkMessageIndex];

            if C = Char($1c) then begin
               Inc(FWkMessageIndex);
               SS := C + FWkMessageStr[FWkMessageIndex];
               FComKeying[0].SendString(AnsiString(SS));

               if Assigned(FOnOneCharSentProc) then begin
                  FOnOneCharSentProc(Self);
                  FOnOneCharSentProc(Self);
                  FOnOneCharSentProc(Self);
               end;

               PostMessage(FWnd, WM_USER_WKSENDNEXTCHAR2, 0, 0);
            end
            else if C = '|' then begin
               SS := C;
               FComKeying[0].SendString(AnsiString(SS));

               if Assigned(FOnOneCharSentProc) then begin
                  FOnOneCharSentProc(Self);
               end;

               PostMessage(FWnd, WM_USER_WKSENDNEXTCHAR2, 0, 0);
            end
            else begin
               WinKeyerSendCharEx(C);
            end;
         end
         else begin
            FWkSendStatus := wkssNone;
            FWkMessageIndex := 1;
            FWkMessageStr := '';
            FWkStatus := 0;

            {$IFDEF DEBUG}
            OutputDebugString(PChar(' *** Send Finish !!! ***'));
            {$ENDIF}

            if Assigned(FOnSendFinishProc) then begin
               {$IFDEF DEBUG}
               OutputDebugString(PChar(' *** FOnSendFinishProc() called in WndMethod() ***'));
               {$ENDIF}
               FOnSendFinishProc(Self, mCW, False);
            end;
         end;

         msg.Result := 0;
      end;

      WM_USER_WKCHANGEWPM: begin
         FKeyerInitWPM := msg.LParam;
         SetWPM(msg.LParam);
         msg.Result := 0;
      end;

      WM_USER_WKPADDLE: begin
         if msg.LParam = 0 then begin
            {$IFDEF DEBUG}
            OutputDebugString(PChar('WinKey WM_USER_WKPADDLE --- OFF ---'));
            {$ENDIF}
         end
         else begin
            {$IFDEF DEBUG}
            OutputDebugString(PChar('WinKey WM_USER_WKPADDLE --- ON ---'));
            {$ENDIF}
            if Assigned(FOnPaddleEvent) then begin
               if FWkSendStatus <> wkssNone then begin
                  FOnPaddleEvent(Self);
               end;
            end;
         end;

         msg.Result := 0;
      end;

      WM_USER_POST_PADDLE: begin
         nID := msg.WParam;
         if FKeyingPort[nID] = tkpUSB then begin
            if Assigned(FUsbInfo[nID].FPORTDATA) then begin
               UsbPortDataLock.Enter();
               FUsbInfo[nID].FPORTDATA.SetRigFlag(FWkTxRigSet);
               if FGen3MicSelect = False then begin
                  FUsbInfo[nID].FPORTDATA.SetVoiceFlag(FWkTxRigSet);
               end;
               SendUsbPortData(nID);
               UsbPortDataLock.Leave();
            end;
         end;
      end;

      else begin
         msg.Result := DefWindowProc(FWnd, msg.Msg, msg.WParam, msg.LParam);
      end;
   end;
end;

//
// SO2R Neo のAudioブレンドON/OFF
// fOn: TrueでON
//
procedure TdmZLogKeyer.So2rNeoSetAudioBlendMode(fOn: Boolean);
var
   Buff: array[0..10] of Byte;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** So2rNeoSetAudioBlendMode ***'));
   {$ENDIF}

   if FSo2rType <> so2rNeo then begin
      Exit;
   end;

   FillChar(Buff, SizeOf(Buff), 0);
   if fOn = True then begin
      Buff[0] := $87;
   end
   else begin
      Buff[0] := $86;
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('CMD=[' + IntToHex(Buff[0], 2) + ']'));
   {$ENDIF}

   FComKeying[0].SendData(@Buff, 1);
end;

//
// SO2R Neo のAudioブレンド割合の設定
// ratio: 0-255
//
procedure TdmZLogKeyer.So2rNeoSetAudioBlendRatio(ratio: Integer);
var
   Buff: array[0..10] of Byte;
   bRatio: Byte;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** So2rNeoSetAudioBlendRatio ***'));
   {$ENDIF}

   if FSo2rType <> so2rNeo then begin
      Exit;
   end;

   bRatio := Trunc(255 * (ratio / 100));

   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := $c0 or ((bRatio shr 4) and $0f);
   Buff[1] := $c0 or (bRatio and $0f);

   {$IFDEF DEBUG}
   OutputDebugString(PChar('CMD=[' + IntToHex(Buff[0], 2) + '][' + IntToHex(Buff[1], 2) + ']'));
   {$ENDIF}

   FComKeying[0].SendData(@Buff, 2);
end;

//
// SO2R Neo のTX/RX変更コマンド
// tx: 0 or 1
// rx: 0: 1/1
//     1: 2/2
//     2: 1/2
//
procedure TdmZLogKeyer.So2rNeoSwitchRig(tx: Integer; rx: Integer);
var
   Buff: array[0..10] of Byte;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** So2rNeoSwitchRig ***'));
   {$ENDIF}

   if FSo2rType <> so2rNeo then begin
      Exit;
   end;

   FillChar(Buff, SizeOf(Buff), 0);

   if tx = 0 then begin
      if rx = 0 then begin
         Buff[0] := $90;
      end
      else if rx = 1 then begin
         Buff[0] := $91;
      end
      else begin
         Buff[0] := $92;
      end;
   end
   else begin
      if rx = 0 then begin
         Buff[0] := $94;
      end
      else if rx = 1 then begin
         Buff[0] := $95;
      end
      else begin
         Buff[0] := $96;
      end;
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('CMD=[' + IntToHex(Buff[0], 2) + ']'));
   {$ENDIF}

   FComKeying[0].SendData(@Buff, 1);

   FWkTxRigSet := tx;
   FWkRxRigSet := rx;
   if Assigned(FOnWkStatusProc) then begin
      FOnWkStatusProc(nil, FWkTxRigSet, FWkRxRigSet, FPTTFLAG);
   end;
end;

procedure TdmZLogKeyer.So2rNeoReverseRx(tx: Integer);
var
   rx: Integer;
const
   reverse_rig: array[0..2] of Integer = ( 1, 0, 2 );
begin
   if FSo2rType <> so2rNeo then begin
      Exit;
   end;

   if FSo2rNeoUseRxSelect = False then begin
      Exit;
   end;

   rx := reverse_rig[tx];
   So2rNeoSwitchRig(tx, rx);
end;

procedure TdmZLogKeyer.So2rNeoNormalRx(tx: Integer);
begin
   try
      if FSo2rType <> so2rNeo then begin
         Exit;
      end;

      if FSo2rNeoCanRxSel = True then begin
         Exit;
      end;

      So2rNeoSwitchRig(tx, 2);
   finally
      FSo2rNeoCanRxSel := False;
   end;
end;

procedure TdmZLogKeyer.SetSo2rRxSelectPort(port: TKeyingPort);
begin
   FSo2rRxSelectPort := port;
end;

procedure TdmZLogKeyer.SetSo2rTxSelectPort(port: TKeyingPort);
begin
   FSo2rTxSelectPort := port;
end;

procedure TdmZLogKeyer.SetSo2rOtrspPort(port: TKeyingPort);
begin
   FSo2rOtrspPort := port;
end;

function TdmZLogKeyer.GetKeyingPortConfig(Index: Integer): TPortConfig;
begin
   Result := FKeyingPortConfig[Index];
end;

procedure TdmZLogKeyer.SetKeyingPortConfig(Index: Integer; v: TPortConfig);
begin
   FKeyingPortConfig[Index] := v;
end;

procedure TdmZLogKeyer.SetOtrspPortParam(CP: TCommPortDriver);
begin
   CP.BaudRate := br9600;
   CP.StopBits := sb1Bits;
   CP.Parity := ptNone;
   CP.DataBits := db8Bits;
   CP.HwFlow := hfNONE;
end;

procedure TdmZLogKeyer.ParallelSetAudioBothMode(fOn: Boolean);
begin
   if FSo2rType <> so2rParallel then begin
      Exit;
   end;

   if fOn = True then begin
      FParallelPort.SetBit(PARALLEL_RX0);
   end
   else begin
      FParallelPort.ResetBit(PARALLEL_RX0);
   end;
   FParallelPort.Write();
end;

procedure TdmZLogKeyer.ParallelSetAudioBlendMode(fOn: Boolean);
begin
   if FSo2rType <> so2rParallel then begin
      Exit;
   end;

   if fOn = True then begin
      FParallelPort.SetBit(PARALLEL_BLEND);
   end
   else begin
      FParallelPort.ResetBit(PARALLEL_BLEND);
   end;
   FParallelPort.Write();
end;

procedure TdmZLogKeyer.WinKeyerSleep(dwMilidec: DWORD);
begin
   if dmZLogGlobal.Settings._use_wk_delay = True then begin
      if dmZLogGlobal.Settings._wk_delaytime = 0 then begin
         Sleep(dwMilidec);
      end
      else begin
         Sleep(dmZLogGlobal.Settings._wk_delaytime);
      end;
   end;
end;

{ TUSBPortInfo }

constructor TUsbPortInfo.Create();
begin
   Inherited;
   Clear();
end;

procedure TUsbPortInfo.Clear();
begin
   FPrevUsbPortData := $00;
   FUsbPortData := $FF;
   ZeroMemory(@FPrevPortIn, SizeOf(FPrevPortIn));
end;

procedure TUsbPortInfo.SetKeyFlag(fOn: Boolean);
begin
   if fOn = True then begin
      FUsbPortData := FUsbPortData and USBIF4CW_KEY_MASK;
   end
   else begin
      FUsbPortData := FUsbPortData or USBIF4CW_KEY;
   end;
end;

procedure TUsbPortInfo.SetPttFlag(fOn: Boolean);
begin
   if fOn = True then begin
      FUsbPortData := FUsbPortData and USBIF4CW_PTT_MASK;
   end
   else begin
      FUsbPortData := FUsbPortData or USBIF4CW_PTT;
   end;
end;

procedure TUsbPortInfo.SetRigFlag(flag: Integer);
begin
   if flag = 1 then begin
      FUsbPortData := FUsbPortData and USBIF4CW_RIG_MASK;
   end
   else if flag = 0 then begin
      FUsbPortData := FUsbPortData or USBIF4CW_RIG;
   end;
end;

procedure TUsbPortInfo.SetVoiceFlag(flag: Integer);
begin
   if flag = 1 then begin
      FUsbPortData := FUsbPortData and USBIF4CW_MIC_MASK;
   end
   else begin
      FUsbPortData := FUsbPortData or USBIF4CW_MIC;
   end;
end;

initialization
   CWBufferSync := TCriticalSection.Create();
   UsbPortDataLock := TCriticalSection.Create();

finalization
   CWBufferSync.Free();
   UsbPortDataLock.Free();

end.
