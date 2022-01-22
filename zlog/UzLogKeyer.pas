unit UzLogKeyer;

//
// zLog for Windows
// CW Keyer Module
//

// サイドトーンを使用する場合、下記の定義を有効にする 要ToneGen.pas
{$DEFINE USESIDETONE}

interface

uses
  System.SysUtils, System.Classes, Windows, MMSystem, Math, Forms,
  Messages, JvComponentBase, JvHidControllerClass, CPDrv, Generics.Collections
  {$IFDEF USESIDETONE},ToneGen, UzLogSound, Vcl.ExtCtrls{$ENDIF};

const
  charmax = 256;
  codemax = 16;
  MAXWPM = 50;
  MINWPM = 5;
  _inccw = $80;
  _deccw = $81;

const
  WM_USER_WKSENDNEXTCHAR = (WM_USER + 1);
  WM_USER_WKCHANGEWPM = (WM_USER + 2);
  WM_USER_WKPADDLE = (WM_USER + 3);
  WM_USER_WKSENDNEXTCHAR2 = (WM_USER + 4);

type
  TKeyingPort = (tkpNone,
                 tkpSerial1, tkpSerial2, tkpSerial3, tkpSerial4, tkpSerial5,
                 tkpSerial6, tkpSerial7, tkpSerial8, tkpSerial9, tkpSerial10,
                 tkpSerial11, tkpSerial12, tkpSerial13, tkpSerial14, tkpSerial15,
                 tkpSerial16, tkpSerial17, tkpSerial18, tkpSerial19, tkpSerial20,
                 tkpUSB);

type
  CodeData = array[1..codemax] of byte;
  CodeTableType = array[0..255] of CodeData;

type
  TdmZLogKeyer = class;
  TSendRepeatEvent = procedure(Sender: TObject; nLoopCount: Integer) of object;
  TWkStatusEvent = procedure(Sender: TObject; tx: Integer; rx: Integer; ptt: Boolean) of object;

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

  TUsbPortDataArray = array[0..1] of Byte;

  TUsbInfo = record
    FUSBIF4CW: TJvHIDDevice;

    FPrevUsbPortData: Byte;
    FUsbPortData: Byte;

    FUsbPortIn: TUsbPortDataArray;
    FUsbPortOut: TUsbPortDataArray;

    FPrevPortIn: array[0..7] of Byte;
  end;

  TdmZLogKeyer = class(TDataModule)
    ZComKeying1: TCommPortDriver;
    RepeatTimer: TTimer;
    ZComKeying2: TCommPortDriver;
    ZComRigSelect: TCommPortDriver;
    procedure WndMethod(var msg: TMessage);
    procedure DoDeviceChanges(Sender: TObject);
    function DoEnumeration(HidDev: TJvHidDevice; const Index: Integer) : Boolean;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure HidControllerDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
    procedure HidControllerDeviceUnplug(HidDev: TJvHidDevice);
    procedure HidControllerRemoval(HidDev: TJvHidDevice);
    procedure ZComKeying1ReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: Cardinal);
    procedure RepeatTimerTimer(Sender: TObject);
    procedure HidControllerDeviceCreateError(Controller: TJvHidDeviceController;
      PnPInfo: TJvHidPnPInfo; var Handled, RetryCreate: Boolean);
  private
    { Private 宣言 }
    FDefautCom: array[0..1] of TCommPortDriver;
    FComKeying: array[0..1] of TCommPortDriver;

    FMonitorThread: TKeyerMonitorThread;

    HidController: TJvHidDeviceController;
    usbdevlist: TList<TJvHIDDevice>;
    FUSBIF4CW_Detected: Boolean;

    FUsbInfo: array[0..1] of TUsbInfo;

    // 現在送信中のポートID
    FCurrentID: Integer;

    {$IFDEF USESIDETONE}
    FTone: TSideTone;
    {$ENDIF}

    FUsbPortDataLock: TRTLCriticalSection;

    FUserFlag: Boolean; // can be set to True by user. set to False only when ClrBuffer is called or "  is reached in the sending buffer. // 1.9z2 used in QTCForm
    FVoiceFlag: Integer;  //temporary

    FKeyingPort: array[0..1] of TKeyingPort;

    FSpaceFactor: Integer; {space length factor in %}
    FEISpaceFactor: Integer; {space length factor after E and I}

    FSelectedBuf: Integer; {0..2}

    FCWSendBuf: array[0..2, 1..charmax * codemax] of byte;

    FCodeTable: CodeTableType;

    FRandCQStr: array[1..2] of string;

    FInitialized: Boolean;

    FPTTFLAG : Boolean; {internal PTT flag}
    FSendOK : Boolean;{TRUE if OK to send}
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

    cwstrptr : word;
    tailcwstrptr : word;
    mousetail : word; {pointer in CWSendBuf}

    callsignptr : word; {char pos. not absolute pos}

    FDotCount: Integer;
    FDashCount: Integer;
    FBlank1Count: Integer;
    FBlank3Count: Integer;

    FCQLoopCount: Integer; //word;
    FCQLoopMax: Integer; //word;
    FCQRepeatIntervalSec: Double;
    FCQRepeatIntervalCount: Integer;
    FUseRandomRepeat: Boolean;

    FKeyerWPM: Integer; //word;
    FKeyerWeight: Integer; //word;
    FUseFixedSpeed: Boolean;
    FFixedSpeed: Integer;
    FBeforeSpeed: Integer;

    FUseSideTone: Boolean;
    FSideToneVolume: Integer;
    FSideTonePitch: Integer;       {side tone pitch}

    FPaddleReverse: Boolean;

    FOnCallsignSentProc: TNotifyEvent;
    FOnPaddleEvent: TNotifyEvent;
    FOnSendRepeatEvent: TSendRepeatEvent;
    FOnSendFinishProc: TNotifyEvent;
    FOnWkAbortProc: TNotifyEvent;
    FOnWkStatusProc: TWkStatusEvent;

    // False: PTT=RTS,KEY=DTR
    // True:  PTT=DTR,KEY=RTS
    FKeyingSignalReverse: Boolean;

    FUsbDetecting: Boolean;
    FUsbif4cwSyncWpm: Boolean;

    // WinKeyer and SO2R Neo support
    FUseWinKeyer: Boolean;
    FWkInitializeMode: Boolean;
    FWkRevision: Integer;
    FWkStatus: Integer;
    FWkEcho: Integer;
    FWkLastMessage: string;
    FWkCallsignSending: Boolean;
    FWkCallsignIndex: Integer;
    FWkCallsignStr: string;
    FOnSpeedChanged: TNotifyEvent;
    FWkAbort: Boolean;
    FUseWkSo2rNeo: Boolean;
    FWkRx: Integer;
    FWkTx: Integer;
    FSo2rNeoCanRxSel: Boolean;

    FWkMessageSending: Boolean;
    FWkMessageIndex: Integer;
    FWkMessageStr: string;

    // SO2R support
    FSo2rSelectPort: TKeyingPort;

    FWnd: HWND;

    procedure Sound();
    procedure NoSound();

    procedure SetCWSendBufChar(b: Integer; C: Char); {Adds a char to the end of buffer}
    procedure SetCWSendBufFinish(b: Integer);
    function DecodeCommands(S: string): string;
    procedure CW_ON(nID: Integer);
    procedure CW_OFF(nID: Integer);
    procedure TimerProcess(uTimerID, uMessage: Word; dwUser, dw1, dw2: Longint); stdcall;
    procedure IncWPM; {Increases CW speed by 1WPM}
    procedure DecWPM; {Decreases CW speed by 1WPM}
    procedure SetCWSendBufChar2(C: char; CharPos: word);

    procedure SetRandCQStr(Index: Integer; cqstr: string);

    procedure SetCQLoopCount(cnt: Integer);
    procedure SetCQLoopMax(cnt: Integer);
    procedure SetCQRepeatInterval(sec: Double); {Sets the pause between repeats}

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
    procedure SetPaddleReverse(fReverse: Boolean);
    procedure SetUseSideTone(fUse: Boolean);
    procedure SetSideToneVolume(v: Integer);

    procedure WinKeyerOpen(nPort: TKeyingPort);
    procedure WinKeyerClose();
    procedure WinKeyerSetSpeed(nWPM: Integer);
    procedure WinKeyerSetSideTone(fOn: Boolean);
    procedure WinKeyerSetPTTMode(fUse: Boolean);
    procedure WinKeyerSetPTTDelay(before, after: Byte);
    procedure WinKeyerSetMode(mode: Byte);

    procedure SetSo2rSelectPort(port: TKeyingPort);
  public
    { Public 宣言 }
    procedure InitializeBGK(msec: Integer); {Initializes BGK. msec is interval}
    procedure CloseBGK; {Closes BGK}

    function PTTIsOn : Boolean;
    function IsPlaying : Boolean;
    function Paused : Boolean; {Returns True if SendOK is False}
    function CallSignSent : Boolean; {Returns True if realtime callsign is sent already}

    procedure ControlPTT(nID: Integer; PTTON : Boolean); {Sets PTT on/off}
    procedure TuneOn(nID: Integer);

    procedure SetCallSign(S: string); {Update realtime callsign}
    procedure ClrBuffer; {Stops CW and clears buffer}
    procedure CancelLastChar; {BackSpace}

    procedure PauseCW; {Pause}
    procedure ResumeCW; {Resume}

    procedure SendStr(nID: Integer; sStr: string); {Sends a string (Overwrites buffer)}
    procedure SendStrLoop(nID: Integer; S: string); {Sends a string (repeat CQmax times)}
    procedure SendStrFIFO(nID: Integer; sStr: string); {Sends a string (adds to buffer)}

    procedure SetCWSendBuf(b: byte; S: string); {Sets str to buffer but does not start sending}
    procedure SetCWSendBufCharPTT(nID: Integer; C: char); {Adds a char to the end of buffer. Also controls PTT if enabled. Called from Keyboard}

    procedure SetRigFlag(flag: Integer); // 0 : no rigs, 1 : rig 1, etc
    procedure SetVoiceFlag(flag: Integer); // 0 : no rigs, 1 : rig 1, etc

    procedure SetPTT(_on : Boolean);
    procedure SetPTTDelay(before, after : word);
    procedure SetWeight(W : word); {Sets the weight 0-100 %}

    property RandCQStr[Index: Integer]: string write SetRandCQStr;

    property CQLoopCount: Integer read FCQLoopCount write SetCQLoopCount;
    property CQLoopMax: Integer read FCQLoopMax write SetCQLoopMax;
    property CQRepeatIntervalSec: Double read FCQRepeatIntervalSec write SetCQRepeatInterval;
    property UseRandomRepeat: Boolean read FUseRandomRepeat write FUseRandomRepeat;

    property WPM: Integer read FKeyerWPM write SetWPM;
    property UseSideTone: Boolean read FUseSideTone write SetUseSideTone;
    property SideToneVolume: Integer read FSideToneVolume write SetSideToneVolume;
    property SideTonePitch: Integer read FSideTonePitch write SetSideTonePitch;
    property SpaceFactor: Integer read FSpaceFactor write SetSpaceFactor;
    property EISpaceFactor: Integer read FEISpaceFactor write SetEISpaceFactor;

    property USBIF4CW_Detected: Boolean read FUSBIF4CW_Detected;
    property UserFlag: Boolean read FUserFlag write FUserFlag;
    property KeyingPort[Index: Integer]: TKeyingPort read GetKeyingPort write SetKeyingPort;

    property OnCallsignSentProc: TNotifyEvent read FOnCallsignSentProc write FOnCallsignSentProc;
    property OnPaddle: TNotifyEvent read FOnPaddleEvent write FOnPaddleEvent;
    property OnSendRepeatEvent: TSendRepeatEvent read FOnSendRepeatEvent write FOnSendRepeatEvent;
    property OnSendFinishProc: TNotifyEvent read FOnSendFinishProc write FOnSendFinishProc;
    property OnSpeedChanged: TNotifyEvent read FOnSpeedChanged write FOnSpeedChanged;
    property OnWkAbortProc: TNotifyEvent read FOnWkAbortProc write FOnWkAbortProc;
    property OnWkStatusProc: TWkStatusEvent read FOnWkStatusProc write FOnWkStatusProc;
    property KeyingSignalReverse: Boolean read FKeyingSignalReverse write FKeyingSignalReverse;

//    property UsbPortIn: TUsbPortDataArray read FUsbPortIn;
//    property UsbPortOut: TUsbPortDataArray read FUsbPortOut;

    property Usbif4cwSyncWpm: Boolean read FUsbif4cwSyncWpm write FUsbif4cwSyncWpm;
    property PaddleReverse: Boolean read FPaddleReverse write SetPaddleReverse;

    // USBIF4CW support
    function usbif4cwSetWPM(nID: Integer; nWPM: Integer): Long;
    function usbif4cwSetPTTParam(nId: Integer; nLen1: Byte; nLen2: Byte): Long;
    function usbif4cwSetPTT(nId: Integer; tx: Byte): Long;
    function usbif4cwGetVersion(nId: Integer): Long;
    function usbif4cwSetPaddle(nId: Integer; param: Byte): Long;

    // 1Port Control support
    procedure SetCommPortDriver(Index: Integer; CP: TCommPortDriver);
    procedure ResetCommPortDriver(Index: Integer; port: TKeyingPort);

    // WinKeyer support
    property UseWinKeyer: Boolean read FUseWinKeyer write FUseWinKeyer;
    property WinKeyerRevision: Integer read FWkRevision;
    property WkCallsignSending: Boolean read FWkCallsignSending write FWkCallsignSending;
    procedure WinKeyerSendCallsign(S: string);
    procedure WinKeyerSendChar(C: Char);
    procedure WinKeyerSendStr(nID: Integer; S: string);
    procedure WinKeyerSendStr2(S: string);
    function WinKeyerBuildMessage(S: string): string;
    procedure WinKeyerControlPTT(fOn: Boolean);
    procedure WinKeyerAbort();
    procedure WinKeyerClear();
    procedure WinKeyerCancelLastChar();

    // SO2R support
    property So2rSelectPort: TKeyingPort read FSo2rSelectPort write SetSo2rSelectPort;

    // SO2R Neo support
    property UseWkSo2rNeo: Boolean read FUseWkSo2rNeo write FUseWkSo2rNeo;
    procedure So2rNeoSetAudioBlendMode(fOn: Boolean);
    procedure So2rNeoSetAudioBlendRatio(ratio: Byte);
    procedure So2rNeoSwitchRig(tx: Integer; rx: Integer);
    procedure So2rNeoReverseRx(tx: Integer);
    procedure So2rNeoNormalRx(tx: Integer);
    property So2rNeoCanRxSel: Boolean read FSo2rNeoCanRxSel write FSo2rNeoCanRxSel;

    procedure IncCWSpeed();
    procedure DecCWSpeed();
    procedure ToggleFixedSpeed();
    property FixedSpeed: Integer read FFixedSpeed write FFixedSpeed;

    procedure Open();
  end;

var
  dmZLogKeyer: TdmZLogKeyer;

const
  USBIF4CW_VENDORID = $BFE;
  USBIF4CW_PRODID = $E00;

const
  BGKCALLMAX = 16;

implementation

uses
  WinKeyer;

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
   RepeatTimer.Enabled := False;
   FInitialized := False;
   FDefautCom[0] := ZComKeying1;
   FDefautCom[1] := ZComKeying2;
   FComKeying[0] := FDefautCom[0];
   FComKeying[1] := FDefautCom[1];
   FUseWinKeyer := False;
   FOnSpeedChanged := nil;
   FUseFixedSpeed := False;
   FBeforeSpeed := 0;
   FFixedSpeed := 0;
   FUseRandomRepeat := True;
   FUseWkSo2rNeo := False;
   FSo2rNeoCanRxSel := False;
   FSo2rSelectPort := tkpNone;

   FWnd := AllocateHWnd(WndMethod);
   usbdevlist := TList<TJvHidDevice>.Create();

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

   for i := 0 to 1 do begin
      FUsbInfo[i].FUSBIF4CW := nil;
      FUsbInfo[i].FPrevUsbPortData := $00;
      FUsbInfo[i].FUsbPortData := $FF;
      ZeroMemory(@FUsbInfo[i].FPrevPortIn, SizeOf(FUsbInfo[i].FPrevPortIn));
   end;

   InitializeCriticalSection(FUsbPortDataLock);

   FUserFlag := False;
   FVoiceFlag := 0;

   FSpaceFactor := 100; {space length factor in %}
   FEISpaceFactor := 100; {space length factor after E and I}

   FMonitorThread := nil;
   FOnCallsignSentProc := nil;
   FOnSendRepeatEvent := nil;
   FOnSendFinishProc := nil;
   FOnPaddleEvent := nil;
   FOnWkAbortProc := nil;
   FKeyingSignalReverse := False;
   FUsbif4cwSyncWpm := False;

   KeyingPort[0] := tkpNone;
   KeyingPort[1] := tkpNone;
end;

procedure TdmZLogKeyer.DataModuleDestroy(Sender: TObject);
begin
   {$IFDEF USESIDETONE}
   FTone.Free();
   {$ENDIF}
   FMonitorThread.Free();
   COM_OFF();
   USB_OFF();
   DeallocateHWnd(FWnd);
   usbdevlist.Free();
   HidController.Free();
end;

// Device抜去時、Unplug->Removal->Changeの順でfire eventする
procedure TdmZLogKeyer.DoDeviceChanges(Sender: TObject);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('***HidControllerDeviceChanges()***'));
   {$ENDIF}

   USB_OFF();

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
begin
   if (FKeyingPort[0] <> tkpUSB) and
      (FKeyingPort[1] <> tkpUSB) then begin
      Exit;
   end;

   p := Data;

   if FUsbInfo[0].FUSBIF4CW = HidDev then begin
      nID := 0;
   end
   else if FUsbInfo[1].FUSBIF4CW = HidDev then begin
      nID := 1;
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
   if (p[0] <> FUsbInfo[nID].FPrevPortIn[0]) or
      (p[1] <> FUsbInfo[nID].FPrevPortIn[1]) or
      (p[2] <> FUsbInfo[nID].FPrevPortIn[2]) or
      (p[3] <> FUsbInfo[nID].FPrevPortIn[3]) or
      (p[4] <> FUsbInfo[nID].FPrevPortIn[4]) or
      (p[5] <> FUsbInfo[nID].FPrevPortIn[5]) or
      (p[6] <> FUsbInfo[nID].FPrevPortIn[6]) or
      (p[7] <> FUsbInfo[nID].FPrevPortIn[7]) then begin
      {$IFDEF DEBUG}
      OutputDebugString(PChar('***HidControllerDeviceData*** ReportID=' + IntToHex(ReportID,2) + ' DATA=' + s));
      {$ENDIF}

      // Port Data In
      FUsbInfo[nID].FUsbPortIn[0] := p[6];
      FUsbInfo[nID].FUsbPortIn[1] := p[7];

      // パドル入力があったか？
      if ((FUsbInfo[nID].FUsbPortIn[1] and $01) = 0) or
         ((FUsbInfo[nID].FUsbPortIn[1] and $04) = 0) then begin
         {$IFDEF DEBUG}
         OutputDebugString(PChar('**PADDLE IN**'));
         {$ENDIF}

         // fire event
         if usbif4cwGetVersion(nID) >= 20 then begin
            if Assigned(FOnPaddleEvent) then begin
               FOnPaddleEvent(Self);
            end;
         end;
      end;

      CopyMemory(@FUsbInfo[nID].FPrevPortIn, p, 8);
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

procedure TdmZLogKeyer.SetRigFlag(flag: Integer); // 0 : no rigs, 1 : rig 1, etc
var
   i: Integer;
begin
   if (flag = 0) or (flag = 1) then begin
      FCurrentID := 0;
   end
   else begin
      FCurrentID := 1;
   end;

   // COMポートでのRIG SELECT
   if (FSo2RSelectPort in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = False) then begin
      case flag of
         0: begin
            ZComRigSelect.ToggleDTR(False);
            ZComRigSelect.ToggleRTS(False);
         end;

         1: begin
            ZComRigSelect.ToggleDTR(True);
            ZComRigSelect.ToggleRTS(False);
         end;

         2: begin
            ZComRigSelect.ToggleDTR(False);
            ZComRigSelect.ToggleRTS(True);
         end;
      end;
      Exit;
   end;

   // SO2R Neoの場合
   if (FKeyingPort[0] in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = True) and (FUseWkSo2rNeo = True) then begin
      case flag of
         0: begin
            So2rNeoSwitchRig(0, 0);
         end;

         1: begin
            So2rNeoSwitchRig(0, 0);
         end;

         2: begin
            So2rNeoSwitchRig(1, 1);
         end;
      end;
      Exit;
   end;

   // WinKeyerの場合
   if (FKeyingPort[0] in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = True) and (FUseWkSo2rNeo = False) then begin
      if flag = 0 then flag := 1;
//         So2rNeoSwitchRig(flag - 1, flag - 1);

      Exit;
   end;

   for i := 0 to 1 do begin
      // USBIF4CWでのRIG SELECT
      if FKeyingPort[i] = tkpUSB then begin
         EnterCriticalSection(FUsbPortDataLock);
         case flag of
            0, 1: begin
               FUsbInfo[i].FUsbPortData := FUsbInfo[i].FUsbPortData or $04;
            end;

            2: begin
               FUsbInfo[i].FUsbPortData := FUsbInfo[i].FUsbPortData and $FB;
            end;

            else begin
               FUsbInfo[i].FUsbPortData := FUsbInfo[i].FUsbPortData;
            end;
         end;

         SendUsbPortData(i);
         LeaveCriticalSection(FUsbPortDataLock);
      end;
   end;
end;

procedure TdmZLogKeyer.SetVoiceFlag(flag: Integer); // 0 : no rigs, 1 : rig 1, etc
var
   i: Integer;
begin
   for i := 0 to 1 do begin
      if FKeyingPort[i] = tkpUSB then begin
         EnterCriticalSection(FUsbPortDataLock);
         if flag = 1 then begin
            FUsbInfo[i].FUsbPortData := FUsbInfo[i].FUsbPortData and $F7;
         end
         else begin
            FUsbInfo[i].FUsbPortData := FUsbInfo[i].FUsbPortData or $08;
         end;

         SendUsbPortData(i);
         LeaveCriticalSection(FUsbPortDataLock);
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

procedure TdmZLogKeyer.ControlPTT(nID: Integer; PTTON: Boolean);
begin
   try
      FPTTFLAG := PTTON;

      if FKeyingPort[nID] = tkpUSB then begin
         EnterCriticalSection(FUsbPortDataLock);
         if PTTON then begin
            FUsbInfo[nID].FUsbPortData := FUsbInfo[nID].FUsbPortData and $FD;
         end
         else begin
            FUsbInfo[nID].FUsbPortData := FUsbInfo[nID].FUsbPortData or $02;
         end;
         SendUsbPortData(nID);
         LeaveCriticalSection(FUsbPortDataLock);
         Exit;
      end;

      if (FKeyingPort[nID] in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = False) then begin
         if FKeyingSignalReverse = False then begin
            FComKeying[nID].ToggleRTS(PTTON);
         end
         else begin
            FComKeying[nID].ToggleDTR(PTTON);
         end;
         Exit;
      end;

      if (FKeyingPort[nID] in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = True) then begin
         if PTTON = True then begin
            WinKeyerSetPTTMode(True);
            WinkeyerControlPTT(PTTON);
         end
         else begin
            WinkeyerControlPTT(PTTON);
            WinKeyerSetPTTMode(False);
         end;
      end;
   finally
      if Assigned(FOnWkStatusProc) then begin
         FOnWkStatusProc(Self, nId, nId, PTTON);
      end;
   end;
end;

procedure TdmZLogKeyer.SetPTT(_on: Boolean);
var
   i: Integer;
begin
   FPTTEnabled := _on;

   for i := 0 to 1 do begin
      if FKeyingPort[i] = tkpUSB then begin
         if _on = True then begin
            usbif4cwSetPTTParam(i, FPttDelayBeforeTime, FPttDelayAfterTime);
         end
         else begin
            ControlPTT(i, False);
            usbif4cwSetPTTParam(i, 0, 0);
         end;
      end;

      if (FKeyingPort[i] in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = True) then begin
         WinKeyerSetPTTDelay(FPttDelayBeforeTime, FPttDelayAfterTime);
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

procedure TdmZLogKeyer.SetCQLoopCount(cnt: Integer);
begin
   FCQLoopCount := cnt;
end;

procedure TdmZLogKeyer.SetCQLoopMax(cnt: Integer);
begin
   FCQLoopMax := cnt;
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
   for m := 1 to codemax do begin
      FCWSendBuf[b, codemax * (tailcwstrptr - 1) + m] := FCodeTable[Ord(C)][m];
   end;

   inc(tailcwstrptr);
   if tailcwstrptr > charmax then begin
      tailcwstrptr := 1;
   end;
end;

procedure TdmZLogKeyer.SetCWSendBufFinish(b: Integer);
var
   m: Integer;
begin
   for m := 1 to codemax do begin
      FCWSendBuf[b, codemax * (tailcwstrptr - 1) + m] := $FF;
   end;
end;

procedure TdmZLogKeyer.SetCWSendBufCharPTT(nID: Integer; C: Char);
begin
   if UseWinKeyer = True then begin
      FWkAbort := False;
      ControlPTT(nID, True);
      FWkMessageStr := FWkMessageStr + C;

      if FWkMessageSending = False then begin
         if FUseWkSo2rNeo = True then begin
            So2rNeoSwitchRig(nID, nID)
         end;

         C := FWkMessageStr[FWkMessageIndex];
         WinKeyerSendChar(C);
         FWkMessageSending := True;
      end;
      Exit;
   end;

   if FPTTEnabled and Not(PTTIsOn) then begin
      ControlPTT(nID, True);
      FKeyingCounter := FPttDelayBeforeCount;
   end;

   // SendOK := False;

   // select keying port
   SetCWSendBufChar(0, Char($90 + nID));

   // set send char
   SetCWSendBufChar(0, C);

   if FPTTEnabled then begin
      FPttHoldCounter := FPttDelayAfterCount;

      { holds PTT until pttafter expires }
      SetCWSendBufChar(0, Char($A2));

      FSendOK := True;
      Exit;
   end;

   // set finish char
   SetCWSendBufFinish(0);

   FSendOK := True;
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
   n, Len: word;
   Code: Integer;
   SS: string;
begin
   SS := S;
   if SS[1] = '>' then begin
      Val(SS[2] + SS[3], n, Code);
      WPM := n;
      SS := copy(SS, 4, 255);
   end;

   SS := DecodeCommands(SS);

   tailcwstrptr := 1;

   Len := length(SS);
   for n := 1 to Len do begin
      if SS[n] = ':' then begin { callsign 1st char }
         callsignptr := n;
      end;

      SetCWSendBufChar(b, SS[n]);
   end;

   SetCWSendBufFinish(b);
end;

procedure TdmZLogKeyer.SendStr(nID: Integer; sStr: string);
var
   SS: string;
   CW: string;
begin
   if sStr = '' then
      Exit;

   if ((nID = 0) or (nID = 1)) then begin
      CW := Char($90 + nID);
   end
   else begin
      CW := Char($90);
   end;

   SS := SS + DecodeCommands(sStr);

   if FPTTEnabled { and Not(PTTIsOn) } then begin
      SS := '(' + SS + ')';
   end;

   SS := CW + SS;

   SetCWSendBuf(0, SS);
   cwstrptr := 1;
   FSendOK := True;
   FKeyingCounter := 1;
end;

procedure TdmZLogKeyer.SendStrLoop(nID: Integer; S: string);
var
   SS: string;
   CW: string;
begin
   SS := S;
   CW := '';

   FCQLoopCount := 1;

   if FUseWinKeyer = True then begin
      WinKeyerClear();
      FWkLastMessage := SS;
      WinkeyerSendStr(nID, SS);
   end
   else begin
      if ((nID = 0) or (nID = 1)) then begin
         CW := Char($90 + nID);
      end
      else begin
         CW := Char($90);
      end;

      SS := DecodeCommands(S);

      if FPTTEnabled then begin
         SS := '(' + SS + ')';
      end;

      SS := CW + SS + '@';

      SetCWSendBuf(0, SS);
      cwstrptr := 1;
      FSendOK := True;
      FKeyingCounter := 1;
   end;
end;

procedure TdmZLogKeyer.SendStrFIFO(nID: Integer; sStr: string);
var
   n: Integer;
   SS: string;
   CW: string;
begin
   if ((nID = 0) or (nID = 1)) then begin
      CW := Char($90 + nID);
   end
   else begin
      CW := Char($90);
   end;

   { StringBuffer := StringBuffer + sStr; }
   SS := SS + DecodeCommands(sStr);
   if FPTTEnabled then begin
      SS := '(' + SS + ')';
   end;

   SS := CW + SS;

   for n := 1 to length(SS) do begin
      if SS[n] = ':' then { callsign 1st char }
         callsignptr := n;

      SetCWSendBufChar(0, SS[n]);
   end;

   SetCWSendBufFinish(0);
end;

procedure TdmZLogKeyer.CW_ON(nID: Integer);
begin
   case FKeyingPort[nID] of
      tkpSerial1..tkpSerial20: begin
         if FKeyingSignalReverse = False then begin
            FComKeying[nID].ToggleDTR(True);
         end
         else begin
            FComKeying[nID].ToggleRTS(True);
         end;
      end;

      tkpUSB: begin
         EnterCriticalSection(FUsbPortDataLock);
         FUsbInfo[nID].FUsbPortData := FUsbInfo[nID].FUsbPortData and $FE;
         SendUsbPortData(nID);
         LeaveCriticalSection(FUsbPortDataLock);
      end;
   end;
end;

procedure TdmZLogKeyer.CW_OFF(nID: Integer);
begin
   case FKeyingPort[nID] of
      tkpSerial1..tkpSerial20: begin
         if FKeyingSignalReverse = False then begin
            FComKeying[nID].ToggleDTR(False);
         end
         else begin
            FComKeying[nID].ToggleRTS(False);
         end;
      end;

      tkpUSB: begin
         EnterCriticalSection(FUsbPortDataLock);
         FUsbInfo[nID].FUsbPortData := FUsbInfo[nID].FUsbPortData or $01;
         SendUsbPortData(nID);
         LeaveCriticalSection(FUsbPortDataLock);
      end;
   end;
end;

procedure TdmZLogKeyer.TimerProcess(uTimerID, uMessage: word; dwUser, dw1, dw2: Longint); stdcall;

   procedure Finish();
   begin
      cwstrptr := 0;
      callsignptr := 0;
      mousetail := 1;
      tailcwstrptr := 1;
      FCWSendBuf[FSelectedBuf, 1] := $FF;

      if FKeyingPort[FCurrentID] <> tkpUSB then begin
         CW_OFF(FCurrentID);
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

   case FCWSendBuf[FSelectedBuf, cwstrptr] of
      $55: begin { set ptt delay before }
         FKeyingCounter := FPttDelayBeforeCount;
      end;

      $10: begin
         ControlPTT(FCurrentID, True);
      end;

      $1F: begin
         ControlPTT(FCurrentID, False);
      end;

      0: begin
         CW_OFF(FCurrentID);
         if FUseSideTone then begin
            NoSound();
         end;
         FKeyingCounter := FBlank1Count;
      end;

      2: begin { normal space x space factor (%) }
         CW_OFF(FCurrentID);
         if FUseSideTone then begin
            NoSound();
         end;
         FKeyingCounter := Trunc(FBlank3Count * FSpaceFactor / 100);
      end;

      $E: begin { normal space x space factor x eispacefactor(%) }
         CW_OFF(FCurrentID);
         if FUseSideTone then begin
            NoSound();
         end;
         FKeyingCounter := Trunc(FBlank3Count * (FSpaceFactor / 100) * (FEISpaceFactor / 100));
      end;

      1: begin
         CW_ON(FCurrentID);
         if FUseSideTone then begin
            Sound();
         end;

         FKeyingCounter := FDotCount;
      end;

      3: begin
         CW_ON(FCurrentID);
         if FUseSideTone then begin
            Sound();
         end;

         FKeyingCounter := FDashCount;
      end;

      // 4 : begin
      // if BGKsidetone then sound(Hz);
      // SetPort(PRTport, GetPort(PRTport) or $80);
      // sss:=100; {30 ms}
      // end;
      // 5 : begin SetPort(PRTport, GetPort(PRTport) and $7F); nosound; sss:=_bl1; end; {???}
      (*
        0 : begin SetPort(PRTport, GetPort(PRTport) and $FE); nosound; sss:=_bl1; end;
        2 : begin SetPort(PRTport, GetPort(PRTport) and $FE); nosound; sss:=_bl3; end;
        1 : begin
        SetPort(PRTport, GetPort(PRTport) or $01);
        if BGKsidetone then sound(Hz);
        sss:=_dot;
        end;
        3 : begin
        SetPort(PRTport, GetPort(PRTport) or $01);
        if BGKsidetone then sound(Hz);
        sss:=_dash;
        end;
        4 : begin
        if BGKsidetone then sound(Hz);
        SetPort(PRTport, GetPort(PRTport) or $80);
        sss:=100; {30 ms}
        end;
        5 : begin SetPort(PRTport, GetPort(PRTport) and $7F); nosound; sss:=_bl1; end;
      *)

      9: begin
         cwstrptr := (cwstrptr div codemax + 1) * codemax;
      end;

      $A1: begin
         FPttHoldCounter := FPttDelayAfterCount;
      end;

      $A2: begin
         if FPttHoldCounter <= 0 then begin
            Finish();
            if FPTTEnabled then begin
               ControlPTT(FCurrentID, False);
            end;
         end
         else begin
            Dec(FPttHoldCounter);
            Exit;
         end;
      end;

      $A3: begin
         if FPttHoldCounter > 0 then begin
            Dec(FPttHoldCounter);
            Exit;
         end;
      end;

      $BB: begin
         Dec(cwstrptr);
      end;

      $CC: begin
         Inc(FCQLoopCount);
         if FCQLoopCount > FCQLoopMax then begin
            FCWSendBuf[FSelectedBuf, 1] := $FF;
            FCQLoopCount := 0;
            FSelectedBuf := 0;
            Finish();
         end
         else if FCQLoopCount > 4 then begin
            if FUseRandomRepeat = True then begin
               FSelectedBuf := FCQLoopCount mod 3; // random(3);
               if FSelectedBuf > 2 then begin
                  FSelectedBuf := 0;
               end;

               if FSelectedBuf in [1 .. 2] then begin
                  if FRandCQStr[FSelectedBuf] = '' then begin
                     FSelectedBuf := 0;
                  end;
               end;
            end
            else begin
               FSelectedBuf := 0;
            end;
         end;
         cwstrptr := 0;
      end;

      $DD: begin
         if Assigned(FOnSendRepeatEvent) then begin
            FOnSendRepeatEvent(Self, FCQLoopCount);
         end;
         FKeyingCounter := FCQRepeatIntervalCount;
      end;

      $C1: begin { voice }
         inc(FCQLoopCount);
         if FCQLoopCount > FCQLoopMax then begin
            FSendOK := False;
            cwstrptr := 0;
         end
         else begin
            cwstrptr := 0;
         end;
      end;

      $D1: begin { sss:=voiceLoopCount; }
      end;

      $EE: begin { cwstrptr:=(BGKcall+callmax-1)*codemax; }
      end;

      $FA: begin
         Dec(cwstrptr);
      end;

      $FF: begin { SendOK:=False; }
         Finish();
         FSendOK := False;
      end;

      $99: begin { pause }
         FSendOK := False;
      end;

      $41: begin
         IncWPM;
      end;

      $42: begin
         DecWPM;
      end;

      $0B: begin
         FUserFlag := False;
      end;

      $20: begin
         FCurrentID := 0;
      end;

      $21: begin
         FCurrentID := 1;
      end;
   end;

   Inc(cwstrptr);
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

      for i := 0 to 1 do begin
         if (FKeyingPort[i] = tkpUSB) and (FUsbif4cwSyncWpm = True) then begin
            usbif4cwSetWPM(i, FKeyerWPM);
         end;

         if (FKeyingPort[i] in [tkpSerial1 .. tkpSerial20]) and (FUseWinKeyer = True) then begin
            WinKeyerSetSpeed(FKeyerWPM);
         end;

         if Assigned(FOnSpeedChanged) then begin
            FOnSpeedChanged(Self);
         end;
      end;
   end;
end;

procedure TdmZLogKeyer.SetCQRepeatInterval(sec: Double);
begin
   if FTimerMicroSec = 0 then begin
      FTimerMicroSec := 1000;
   end;

   FCQRepeatIntervalCount := Trunc(sec * 1000000 / FTimerMicroSec);
   FCQRepeatIntervalSec := sec;
end;

procedure TdmZLogKeyer.InitializeBGK(msec: Integer);
var
   n, m: word;
begin
   FRandCQStr[1] := '';
   FRandCQStr[2] := '';

   FPTTFLAG := False;

   callsignptr := 0; { points to the 1st char of realtime updated callsign }
   FSelectedBuf := 0;
   cwstrptr := 1;
   tailcwstrptr := 1;
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
   FPaddleReverse := False;
   FKeyerWPM := 1;

   CQRepeatIntervalSec := 2.0;
   CQLoopCount := 0;
   CQLoopMax := 15;

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
   FCodeTable[Ord('t')][11] := 9;

   FCodeTable[Ord('p')][1] := 1;
   FCodeTable[Ord('p')][2] := 0;
   FCodeTable[Ord('p')][3] := 9;

   FCodeTable[Ord('q')][1] := 3;
   FCodeTable[Ord('q')][2] := 0;
   FCodeTable[Ord('q')][3] := 9;

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

   FCodeTable[Ord('@')][1] := $DD;
   FCodeTable[Ord('@')][2] := $CC;

   FCodeTable[Ord('|')][1] := $D1;
   FCodeTable[Ord('|')][2] := $C1;

   FCodeTable[Ord(']')][1] := 4;
   FCodeTable[Ord(']')][2] := 5;
   FCodeTable[Ord(']')][3] := 9;

   FCodeTable[Ord('<')][1] := $B0;
   FCodeTable[Ord('<')][2] := $B1;
   FCodeTable[Ord('<')][3] := $B2;
   FCodeTable[Ord('<')][4] := $DD;
   FCodeTable[Ord('<')][5] := $C1;

   FCodeTable[Ord('#')][1] := $BB;

   FCodeTable[Ord('*')][1] := 9; { skips to the next char }
   FCodeTable[Ord(':')][1] := 9; { skips to the next char; callsign 1st char }

   FCodeTable[Ord('^')][1] := $99; { pause }
   FCodeTable[Ord('^')][2] := 9;

   FCodeTable[Ord('(')][1] := $10; { PTT on }
   FCodeTable[Ord('(')][2] := $55; { set PTT delay }
   FCodeTable[Ord('(')][3] := 9;

   FCodeTable[Ord(')')][1] := $A1; { set Hold Counter }
   FCodeTable[Ord(')')][2] := $A3; { set PTT delay }
   FCodeTable[Ord(')')][3] := $1F; { PTT off }
   FCodeTable[Ord(')')][4] := 9;

   FCodeTable[_inccw][1] := $41; { IncWPM }
   FCodeTable[_inccw][2] := 9;

   FCodeTable[Ord('u')][1] := $41; { IncWPM }
   FCodeTable[Ord('u')][2] := 9;

   FCodeTable[_deccw][1] := $42; { DecWPM }
   FCodeTable[_deccw][2] := 9;

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

   if FMonitorThread = nil then begin
      FMonitorThread := TKeyerMonitorThread.Create(Self);
   end;
   FMonitorThread.Start();

   FInitialized := True;
end;

procedure TdmZLogKeyer.CloseBGK();
begin
   ControlPTT(0, False);
   ControlPTT(1, False);

   if Assigned(FMonitorThread) then begin
      FMonitorThread.Terminate();
      FMonitorThread.Free();
      FMonitorThread := nil;
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

   KeyingPort[0] := tkpNone;
   KeyingPort[1] := tkpNone;
end;

procedure TdmZLogKeyer.PauseCW;
begin
   if FUseWinKeyer = True then begin
      Exit;
   end;

   FSendOK := False;

   CW_OFF(FCurrentID);
   if FUseSideTone then begin
      NoSound();
   end;

   if FPTTEnabled then begin
      ControlPTT(FCurrentID, False);
   end;
end;

procedure TdmZLogKeyer.ResumeCW;
begin
   if FUseWinKeyer = True then begin
      Exit;
   end;

   if FPTTEnabled then begin
      ControlPTT(FCurrentID, True);
      FKeyingCounter := FPttDelayBeforeCount;
   end;

   FSendOK := True;
end;

procedure TdmZLogKeyer.IncWPM;
begin
   if FKeyerWPM < MAXWPM then begin
      WPM := FKeyerWPM + 1;
   end;
end;

procedure TdmZLogKeyer.DecWPM;
begin
   if FKeyerWPM > MINWPM then begin
      WPM := FKeyerWPM - 1;
   end;
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
begin
   if FUseWinKeyer = True then begin
      WinKeyerClear();
   end
   else begin
      { SendOK:=False; }
      { StringBuffer := ''; }
      for m := 0 to 2 do begin
         FCWSendBuf[m, 1] := $FF;
      end;
      cwstrptr := 0;
      FSelectedBuf := 0; // ver 2.1b
      callsignptr := 0;
      mousetail := 1;
      tailcwstrptr := 1;
      if FUseSideTone then begin
         NoSound();
      end;
      CW_OFF(FCurrentID);

      FUserFlag := False;

      FSendOK := True;

      if FPTTEnabled then begin
         ControlPTT(FCurrentID, False);
      end;
   end;

   FCQLoopCount := 0;
end;

procedure TdmZLogKeyer.CancelLastChar;
begin
   if FUseWinKeyer = True then begin
      WinKeyerCancelLastChar();
   end
   else begin
      if ((tailcwstrptr - 1) * codemax + 1) > (cwstrptr) then begin
         dec(tailcwstrptr, 1);
         SetCWSendBufFinish(0);
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
   i: word;
begin
   FWkCallsignStr := S;

   if callsignptr = 0 then begin
      Exit;
   end;

   SS := S + '*********************';

   while pos('.', SS) > 0 do begin
      SS[pos('.', SS)] := '?';
   end;

   SS[BGKCALLMAX] := '^'; { pause }

   for i := 1 to BGKCALLMAX do begin
      SetCWSendBufChar2(char(SS[i]), callsignptr + i - 1);
   end;
end;

function TdmZLogKeyer.CallSignSent: Boolean;
begin
   Result := False;

   if callsignptr > 0 then begin
      if FCWSendBuf[0, cwstrptr - 1] = $99 then begin
         Result := True;
         callsignptr := 0;
      end;
   end;
end;

function TdmZLogKeyer.IsPlaying: Boolean;
begin
   if FUseWinKeyer = False then begin
      if (cwstrptr > 1) and FSendOK then
         Result := True
      else
         Result := False;
   end
   else begin
      if ((FWkStatus and WK_STATUS_BUSY) = WK_STATUS_BUSY) then begin
         Result := True;
      end
      else begin
         Result := False;
      end;
   end;
end;

procedure TdmZLogKeyer.SetRandCQStr(Index: Integer; cqstr: string);
begin
   FRandCQStr[Index] := cqstr;

   if FUseWinKeyer = False then begin
      if FPTTEnabled then begin
         cqstr := '(' + cqstr + ')';
      end;
      cqstr := cqstr + '@';
      SetCWSendBuf(Index, cqstr);
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
   procedure UsbInfoClear(n: Integer);
   begin
      FUsbInfo[n].FUSBIF4CW := nil;
      FUsbInfo[n].FPrevUsbPortData := $00;
      FUsbInfo[n].FUsbPortData := $FF;
   end;

   procedure UsbInfoClearAll();
   var
      i: Integer;
   begin
      for i := 0 to 1 do begin
         UsbInfoClear(i);
      end;
   end;
begin
   HidController.Enumerate;
   repeat
      Sleep(1);
   until FUsbDetecting = False;

   // RIG1/RIG2共に無し
   if (FKeyingPort[0] = tkpNone) and
      (FKeyingPort[1] = tkpNone) then begin
      COM_OFF();
      USB_OFF();
//      FComKeying[0] := nil;
//      FComKeying[1] := nil;
      UsbInfoClearAll();
      Exit;
   end;

   // RIG1/RIG2共にUSB
   if ((FKeyingPort[0] = tkpUSB) and (FKeyingPort[1] = tkpUSB)) then begin
      case usbdevlist.Count of
         0: begin
            FKeyingPort[0] := tkpNone;
            FKeyingPort[1] := tkpNone;
            UsbInfoClearAll();
         end;

         1: begin
            FUsbInfo[0].FUSBIF4CW := usbdevlist[0];
            FUsbInfo[1].FUSBIF4CW := usbdevlist[0];
         end;

         2: begin
            FUsbInfo[0].FUSBIF4CW := usbdevlist[0];
            FUsbInfo[1].FUSBIF4CW := usbdevlist[1];
         end;
      end;

      COM_OFF();
      USB_ON();
   end;

   // RIG1がUSB,RIG2がなし
   if ((FKeyingPort[0] = tkpUSB) and (FKeyingPort[1] = tkpNone)) then begin
      case usbdevlist.Count of
         0: begin
            FKeyingPort[0] := tkpNone;
            FKeyingPort[1] := tkpNone;
            UsbInfoClearAll();
         end;

         1, 2: begin
            FUsbInfo[0].FUSBIF4CW := usbdevlist[0];
            UsbInfoClear(1);
         end;
      end;

      COM_OFF();
      USB_ON();
      Exit;
   end;

   // RIG1がなし,RIG2がUSB
   if ((FKeyingPort[0] = tkpNone) and (FKeyingPort[1] = tkpUSB)) then begin
      case usbdevlist.Count of
         0: begin
            FKeyingPort[0] := tkpNone;
            FKeyingPort[1] := tkpNone;
            UsbInfoClearAll();
         end;

         1, 2: begin
            UsbInfoClear(0);
            FUsbInfo[1].FUSBIF4CW := usbdevlist[0];
         end;
      end;

      COM_OFF();
      USB_ON();
      Exit;
   end;

   // RIG1,RIG2がCOMポート
   if ((FKeyingPort[0] in [tkpSerial1 .. tkpSerial20]) and
       (FKeyingPort[1] in [tkpSerial1 .. tkpSerial20])) or
      ((FKeyingPort[0] in [tkpSerial1 .. tkpSerial20]) and
       (FKeyingPort[1] =tkpNone)) then begin
      USB_OFF();
      COM_ON();
      Exit;
   end;

   // RIG1がCOMポート,RIG2がUSB
   if ((FKeyingPort[0] in [tkpSerial1 .. tkpSerial20]) and (FKeyingPort[1] = tkpUSB)) then begin
      case usbdevlist.Count of
         0: begin
            FKeyingPort[0] := tkpNone;
            FKeyingPort[1] := tkpNone;
            UsbInfoClearAll();
         end;

         1, 2: begin
            UsbInfoClear(0);
            FUsbInfo[1].FUSBIF4CW := usbdevlist[0];
         end;
      end;

      USB_ON();
      COM_ON();
   end;

   // RIG1がUSB,RIG2がCOMポート
   if ((FKeyingPort[0] = tkpUSB) and (FKeyingPort[1] in [tkpSerial1 .. tkpSerial20])) then begin
      case usbdevlist.Count of
         0: begin
            FKeyingPort[0] := tkpNone;
            FKeyingPort[1] := tkpNone;
            UsbInfoClearAll();
         end;

         1, 2: begin
            FUsbInfo[0].FUSBIF4CW := usbdevlist[0];
            UsbInfoClear(1);
         end;
      end;

      USB_ON();
      COM_ON();
   end;
end;

procedure TdmZLogKeyer.TuneOn(nID: Integer);
begin
   ClrBuffer;
   FSendOK := False;

   if FPTTEnabled then begin
      ControlPTT(nID, True);
   end;

   CW_ON(nID);

   if FUseSideTone then begin
      Sound();
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
   if FUsbInfo[nID].FUsbPortData = FUsbInfo[nID].FPrevUsbPortData then begin
      Exit;
   end;

   OutReport[0] := 0;
   OutReport[1] := 1;
   OutReport[2] := FUsbInfo[nID].FUsbPortData;
   OutReport[3] := 0;
   OutReport[4] := 0;
   OutReport[5] := 0;
   OutReport[6] := 0;
   OutReport[7] := 0;
   OutReport[8] := 0;
   FUsbInfo[nID].FUSBIF4CW.SetOutputReport(OutReport, 9);
   FUsbInfo[nID].FPrevUsbPortData := FUsbInfo[nID].FUsbPortData;
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

   for i := 0 to 1 do begin
      if FComKeying[i] = nil then begin
         Continue;
      end;

      if FComKeying[i].Connected = False then begin
         FComKeying[i].Port := TPortNumber(FKeyingPort[i]);
         FComKeying[i].Connect;
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

   for i := 0 to 1 do begin
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
//   HidController.Enumerate();
//   repeat
//      Sleep(1);
//   until FUsbDetecting = False;

   for i := 0 to 1 do begin
      if FUsbInfo[i].FUSBIF4CW <> nil then begin
         ZeroMemory(@FUsbInfo[i].FPrevPortIn, SizeOf(FUsbInfo[i].FPrevPortIn));
         FUsbInfo[i].FPrevUsbPortData := $00;
         FUsbInfo[i].FUsbPortData := $FF;
         SendUsbPortData(i);
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

   FUSBIF4CW_Detected := False;
end;

procedure TdmZLogKeyer.SetPaddleReverse(fReverse: Boolean);
var
   i: Integer;
begin
   FPaddleReverse := fReverse;

   for i := 0 to 1 do begin
      if FKeyingPort[i] = tkpUSB then begin
         if fReverse = True then begin
            usbif4cwSetPaddle(i, 1);
         end
         else begin
            usbif4cwSetPaddle(i, 0);
         end;
      end;
   end;
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
      FKeyer.OnCallsignSentProc(FKeyer);
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

procedure TdmZLogKeyer.SetCommPortDriver(Index: Integer; CP: TCommPortDriver);
begin
   if FComKeying[Index] = CP then begin
      Exit;
   end;

   COM_OFF();
   FComKeying[Index] := CP;
//   COM_ON(FKeyingPort);

   FKeyingPort[Index] := TKeyingPort(CP.Port);
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
begin
   FWkInitializeMode := False;
   FWkRevision := 0;
   FWkStatus := 0;
   FWkEcho := 0;
   FWkLastMessage := '';
   FWkCallsignSending := False;
   FWkAbort := False;
   RepeatTimer.Enabled := False;
   RepeatTimer.Interval := Trunc(FCQRepeatIntervalSec * 1000);

   //1) Open serial communications port. Use 1200 baud, 8 data bits, no parity
   FComKeying[0].Port := TPortNumber(nPort);
   if FUseWkSo2rNeo = True then begin
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
   if FUseWkSo2rNeo = False then begin
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
   if FUseWkSo2rNeo = False then begin
      FillChar(Buff, SizeOf(Buff), 0);
      Buff[0] := WK_GET_SPEEDPOT_CMD;
      FComKeying[0].SendData(@Buff, 1);
   end;

   // Set PTT Mode(PINCFG)
   WinKeyerSetPTTMode(True);

   // Set PTT Delay time
   WinKeyerSetPTTDelay(FPttDelayBeforeTime, FPttDelayAfterTime);

   // Set keying speed
   WinKeyerSetSpeed(FKeyerWPM);

   // SideTone
   WinKeyerSetSideTone(FUseSideTone);

   // set serial echo back to on
   WinKeyerSetMode(WK_SETMODE_SERIALECHOBACK);
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
end;

procedure TdmZLogKeyer.WinKeyerAbort();
begin
   FWkAbort := True;
   if Assigned(FOnWkAbortProc) then begin
      FOnWkAbortProc(nil);
   end;
end;

procedure TdmZLogKeyer.WinKeyerClear();
var
   Buff: array[0..10] of Byte;
begin
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_CLEAR_CMD;
   FComKeying[0].SendData(@Buff, 1);
   FWkLastMessage := '';
   FWkAbort := False;
   WinKeyerSetPTTMode(False);
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
end;

procedure TdmZLogKeyer.WinKeyerSetPTTMode(fUse: Boolean);
var
   Buff: array[0..10] of Byte;
begin
   // Set PINCFG
   //     1010 1100
   //     A    C
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_SET_PINCFG_CMD;
   Buff[1] := $ac;
   if fUse = False then begin
      Buff[1] := Buff[1] or $1;
   end;
   if FUseSideTone = True then begin
      Buff[1] := Buff[1] or $2;
   end;
   FComKeying[0].SendData(@Buff, 2);
end;

// PTT On/Off <18><nn> nn = 01 PTT on, n = 00 PTT off
procedure TdmZLogKeyer.WinKeyerControlPTT(fOn: Boolean);
var
   Buff: array[0..10] of Byte;
begin
   if FPTTEnabled = False then begin
      Exit;
   end;

   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_PTT_CMD;
   if fOn = True then begin
      if FPTTFLAG = True then begin
         Exit;
      end;
      Buff[1] := WK_PTT_ON;
      FPTTFLAG := True;
   end
   else begin
      if FPTTFLAG = False then begin
         Exit;
      end;
      Buff[1] := WK_PTT_OFF;
      FPTTFLAG := False;
   end;

   FComKeying[0].SendData(@Buff, 2);

   if Assigned(FOnWkStatusProc) then begin
      FOnWkStatusProc(nil, FWkTx, FWkRx, FPTTFLAG);
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
   Buff[1] := before;
   Buff[2] := after;
   FComKeying[0].SendData(@Buff, 3);
end;

procedure TdmZLogKeyer.WinKeyerSetMode(mode: Byte);
var
   Buff: array[0..10] of Byte;
begin
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_SETMODE_CMD;
   Buff[1] := mode;
   FComKeying[0].SendData(@Buff, 2);
end;

procedure TdmZLogKeyer.WinKeyerSendCallsign(S: string);
var
   C: Char;
begin
   if S = '' then begin
      Exit;
   end;

   FWkAbort := False;
   FWkCallsignIndex := 1;
   FWkCallsignStr := S;
   C := FWkCallsignStr[FWkCallsignIndex];
   WinKeyerSendChar(C);
   FWkCallsignSending := True;
end;

procedure TdmZLogKeyer.WinKeyerSendChar(C: Char);
var
   S: string;
begin
   case C of
      ' ', 'A'..'Z', '0'..'9', '/', '?', '.', 'a', 'b', 'k', 's', 't', 'v', '-', '=': begin
         S := C;
         WinKeyerSendStr(FCurrentID, S);
      end;
   end;
end;

procedure TdmZLogKeyer.WinKeyerSendStr(nID: Integer; S: string);
begin
   if FWkAbort = True then begin
      Exit;
   end;

   FCurrentID := nID;

   ControlPTT(nID, True);

   S := WinKeyerBuildMessage(S);

   FComKeying[0].SendString(AnsiString(S));
end;

procedure TdmZLogKeyer.WinKeyerSendStr2(S: string);
var
   C: Char;
begin
   if FWkAbort = True then begin
      Exit;
   end;

   S := WinKeyerBuildMessage(S);

   FWkAbort := False;
   FWkMessageIndex := 1;
   FWkMessageStr := S;
   C := FWkMessageStr[FWkMessageIndex];
   WinKeyerSendChar(C);
   FWkMessageSending := True;
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

procedure TdmZLogKeyer.ZComKeying1ReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: Cardinal);
var
   i: Integer;
   b: Byte;
   PP: PByte;
   newwpm: Integer;
begin
   PP := DataPtr;

   if FUseWinKeyer = True then begin
      if FWkInitializeMode = True then begin
         FWkRevision := (PP)^;
         Exit;
      end;

      for i := 0 to DataSize - 1 do begin
         b := (PP + i)^;

         if FWkAbort = True then begin
            FWkAbort := False;
            FWkCallsignSending := False;
            FWkLastMessage := '';
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

            //コールサイン送信時：１文字送信終了
//            if (FWkCallsignSending = True) and ((FWkStatus and WK_STATUS_BUSY) = WK_STATUS_BUSY) and ((b and WK_STATUS_BUSY) = 0) then begin
//               {$IFDEF DEBUG}
//               OutputDebugString(PChar('WinKey BUSY->IDLE [' + IntToHex(b, 2) + ']'));
//               {$ENDIF}
//
//               // 次の文字を送信
//               PostMessage(FWnd, WM_USER_WKSENDNEXTCHAR, 0, 0);
//            end;

            // コールサイン送信時：１文字送信開始
//            if (FWkCallsignSending = True) and ((FWkStatus and WK_STATUS_BUSY) = 0) and ((b and WK_STATUS_BUSY) = WK_STATUS_BUSY) then begin
//               {$IFDEF DEBUG}
//               OutputDebugString(PChar('WinKey IDLE->BUSY [' + IntToHex(b, 2) + ']'));
//               {$ENDIF}
//            end;

            // 送信中→送信終了に変わったら、リピートタイマー起動
            if (FWkCallsignSending = False) and (FWkLastMessage <> '') and ((FWkStatus and WK_STATUS_BUSY) = WK_STATUS_BUSY) and ((b and WK_STATUS_BUSY) = 0) then begin

               if Assigned(FOnSendFinishProc) then begin
                  {$IFDEF DEGBUG}
                  OutputDebugString(PChar(' *** FOnSendFinishProc() called ***'));
                  {$ENDIF}
                  FOnSendFinishProc(Self);
               end;

               if FCQLoopCount < FCQLoopMax then begin
                  {$IFDEF DEGBUG}
                  OutputDebugString(PChar(' *** RepeatTimer started ***'));
                  {$ENDIF}
                  RepeatTimer.Enabled := True;
                  Inc(FCQLoopCount);
               end;
            end;

            // STATUSを保存
            FWkStatus := b;

//            {$IFDEF DEBUG}
//            OutputDebugString(PChar('WinKey STATUS=[' + IntToHex(b, 2) + ']'));
//            {$ENDIF}
         end
         else if ((b and $c0) = $80) then begin   // POT POSITION
            newwpm := (b and $3F);
            PostMessage(FWnd, WM_USER_WKCHANGEWPM, 0, newwpm);
         end
         else begin  // ECHO TEST
            FWkEcho := b;

            {$IFDEF DEBUG}
//            OutputDebugString(PChar('WinKey ECHOBACK=[' + IntToHex(b, 2) + '(' + Chr(b) + ')]'));
            {$ENDIF}

            // コールサイン送信
            if (FWkCallsignSending = True) and (Char(b) = FWkCallsignStr[FWkCallsignIndex]) then begin
               // 次の文字を送信
               PostMessage(FWnd, WM_USER_WKSENDNEXTCHAR, 0, 0);
            end;

            // 通常メッセージ送信
            if (FWkMessageSending = True) and (Char(b) = FWkMessageStr[FWkMessageIndex]) then begin
               // 次の文字を送信
               PostMessage(FWnd, WM_USER_WKSENDNEXTCHAR2, 0, 0);
            end;
         end;
      end;
   end;
end;

procedure TdmZLogKeyer.RepeatTimerTimer(Sender: TObject);
var
   n: Integer;
   S: string;
begin
   RepeatTimer.Enabled := False;

   if (FUseRandomRepeat = True) and (FCQLoopCount > 4) then begin
      n := FCQLoopCount mod 3; // random(3);
      if n > 2 then begin
         n := 0;
      end;

      if n in [1 .. 2] then begin
         if FRandCQStr[n] = '' then begin
            n := 0;
         end;
      end;

      if n = 0 then begin
         S := FWkLastMessage;
      end
      else begin
         S := FRandCQStr[n];
      end;
   end
   else begin
      S := FWkLastMessage;
   end;

   if Assigned(FOnSendRepeatEvent) then begin
      FOnSendRepeatEvent(Self, FCQLoopCount);
   end;

   WinKeyerSendStr(FCurrentID, S);
end;

procedure TdmZLogKeyer.IncCWSpeed();
begin
   WPM := WPM + 1;

   if Assigned(FOnSpeedChanged) then begin
      FOnSpeedChanged(Self);
   end;
end;

procedure TdmZLogKeyer.DecCWSpeed();
begin
   WPM := WPM - 1;

   if Assigned(FOnSpeedChanged) then begin
      FOnSpeedChanged(Self);
   end;
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

procedure TdmZLogKeyer.WndMethod(var msg: TMessage);
var
   C: Char;
begin
   case msg.Msg of
      WM_USER_WKSENDNEXTCHAR: begin
         Inc(FWkCallsignIndex);
         if FWkCallsignIndex <= Length(FWkCallsignStr) then begin
            C := FWkCallsignStr[FWkCallsignIndex];
            WinKeyerSendChar(C);
         end
         else begin
            FWkCallsignSending := False;

            if Assigned(FOnCallsignSentProc) then begin
               FOnCallsignSentProc(Self);
            end;
         end;

         msg.Result := 0;
      end;

      WM_USER_WKSENDNEXTCHAR2: begin
         Inc(FWkMessageIndex);
         if FWkMessageIndex <= Length(FWkMessageStr) then begin
            C := FWkMessageStr[FWkMessageIndex];
            WinKeyerSendChar(C);
         end
         else begin
            FWkMessageSending := False;
            FWkMessageIndex := 1;
            FWkMessageStr := '';

            {$IFDEF DEGBUG}
            OutputDebugString(PChar(' *** Send Finish !!! ***'));
            {$ENDIF}

            if Assigned(FOnSendFinishProc) then begin
               {$IFDEF DEGBUG}
               OutputDebugString(PChar(' *** FOnSendFinishProc() called ***'));
               {$ENDIF}
               FOnSendFinishProc(Self);
            end;
         end;

         msg.Result := 0;
      end;

      WM_USER_WKCHANGEWPM: begin
         SetWPM(msg.LParam);
         msg.Result := 0;
      end;

      WM_USER_WKPADDLE: begin
//         WinKeyerClear();

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
               FOnPaddleEvent(Self);
            end;
         end;

         msg.Result := 0;
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
   FillChar(Buff, SizeOf(Buff), 0);
   if fOn = True then begin
      Buff[0] := $86;
   end
   else begin
      Buff[0] := $87;
   end;
   FComKeying[0].SendData(@Buff, 1);
end;

//
// SO2R Neo のAudioブレンド割合の設定
// ratio: 0-255
//
procedure TdmZLogKeyer.So2rNeoSetAudioBlendRatio(ratio: Byte);
var
   Buff: array[0..10] of Byte;
begin
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := $c0 or ((ratio shr 4) and $0f);
   Buff[1] := $c0 or (ratio and $0f);
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

   FComKeying[0].SendData(@Buff, 1);

   FWkTx := tx;
   FWkRx := rx;
   if Assigned(FOnWkStatusProc) then begin
      FOnWkStatusProc(nil, FWkTx, FWkRx, FPTTFLAG);
   end;
end;

procedure TdmZLogKeyer.So2rNeoReverseRx(tx: Integer);
var
   rx: Integer;
const
   reverse_rig: array[0..2] of Integer = ( 1, 0, 2 );
begin
   rx := reverse_rig[tx];
   So2rNeoSwitchRig(tx, rx);
end;

procedure TdmZLogKeyer.So2rNeoNormalRx(tx: Integer);
begin
   try
      if FSo2rNeoCanRxSel = True then begin
         Exit;
      end;

      So2rNeoSwitchRig(tx, 2);
   finally
      FSo2rNeoCanRxSel := False;
   end;
end;

procedure TdmZLogKeyer.SetSo2rSelectPort(port: TKeyingPort);
begin
   FSo2rSelectPort := port;
end;

end.
