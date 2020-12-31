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
  JvComponentBase, JvHidControllerClass, CPDrv
  {$IFDEF USESIDETONE},ToneGen, UzLogSound, Vcl.ExtCtrls{$ENDIF};

const
  charmax = 256;
  codemax = 16;
  MAXWPM = 50;
  MINWPM = 5;
  _inccw = $80;
  _deccw = $81;

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

  TdmZLogKeyer = class(TDataModule)
    HidController: TJvHidDeviceController;
    ZComKeying: TCommPortDriver;
    WinkeyerTimer: TTimer;
    RepeatTimer: TTimer;
    procedure DoDeviceChanges(Sender: TObject);
    function DoEnumeration(HidDev: TJvHidDevice; const Index: Integer) : Boolean;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure HidControllerDeviceData(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
    procedure HidControllerDeviceUnplug(HidDev: TJvHidDevice);
    procedure HidControllerRemoval(HidDev: TJvHidDevice);
    procedure ZComKeyingReceiveData(Sender: TObject; DataPtr: Pointer;
      DataSize: Cardinal);
    procedure WinkeyerTimerTimer(Sender: TObject);
    procedure RepeatTimerTimer(Sender: TObject);
  private
    { Private 宣言 }
    FComKeying: TCommPortDriver;

    FMonitorThread: TKeyerMonitorThread;

    FUSBIF4CW_Detected: Boolean;
    FUSBIF4CW: TJvHIDDevice;
    FUSBIF4CW_Version: Long;

    {$IFDEF USESIDETONE}
    FTone: TSideTone;
    {$ENDIF}

    FUsbPortDataLock: TRTLCriticalSection;
    FPrevUsbPortData: Byte;
    FUsbPortData: Byte;

    FUsbPortIn: TUsbPortDataArray;
    FUsbPortOut: TUsbPortDataArray;

    FPrevPortIn: array[0..7] of Byte;

    FUserFlag: Boolean; // can be set to True by user. set to False only when ClrBuffer is called or "  is reached in the sending buffer. // 1.9z2 used in QTCForm
    FVoiceFlag: Integer;  //temporary

    FKeyingPort: TKeyingPort;

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

    FKeyerWPM: Integer; //word;
    FKeyerWeight: Integer; //word;
    FUseFixedSpeed: Boolean;
    FFixedSpeed: Integer;
    FBeforeSpeed: Integer;

    FUseSideTone: Boolean;
    FSideTonePitch: Integer;       {side tone pitch}

    FPaddleReverse: Boolean;

    FOnCallsignSentProc: TNotifyEvent;
    FOnPaddleEvent: TNotifyEvent;

    // False: PTT=RTS,KEY=DTR
    // True:  PTT=DTR,KEY=RTS
    FKeyingSignalReverse: Boolean;

    FUsbDetecting: Boolean;
    FUsbif4cwSyncWpm: Boolean;

    FUseWinKeyer: Boolean;
    FWkInitializeMode: Boolean;
    FWkRevision: Integer;
    FWkStatus: Integer;
    FWkSpeed: Integer;
    FWkEcho: Integer;
    FWkLastMessage: string;

    FOnSpeedChanged: TNotifyEvent;

    procedure Sound();
    procedure NoSound();

    procedure SetCWSendBufChar( C : char ); {Adds a char to the end of buffer}
    function DecodeCommands(S: string): string;
    procedure CW_ON;
    procedure CW_OFF;
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
    procedure SetKeyingPort(port: TKeyingPort);
    procedure SendUsbPortData();
    procedure COM_ON(port: TKeyingPort);
    procedure COM_OFF();
    procedure USB_ON();
    procedure USB_OFF();
    procedure SetPaddleReverse(fReverse: Boolean);
    procedure SetUseSideTone(fUse: Boolean);

    procedure WinKeyerOpen(nPort: TKeyingPort);
    procedure WinKeyerClose();
    procedure WinKeyerSetSpeed(nWPM: Integer);
    procedure WinKeyerSetSideTone(fOn: Boolean);
    procedure WinkeyerControlPTT(fOn: Boolean);
    procedure WinkeyerSetPTTDelay(before, after: Byte);
  public
    { Public 宣言 }
    procedure InitializeBGK(msec: Integer); {Initializes BGK. msec is interval}
    procedure CloseBGK; {Closes BGK}

    function PTTIsOn : Boolean;
    function IsPlaying : Boolean;
    function Paused : Boolean; {Returns True if SendOK is False}
    function CallSignSent : Boolean; {Returns True if realtime callsign is sent already}

    procedure ControlPTT(PTTON : Boolean); {Sets PTT on/off}
    procedure TuneOn;

    procedure SetCallSign(S: string); {Update realtime callsign}
    procedure ClrBuffer; {Stops CW and clears buffer}
    procedure CancelLastChar; {BackSpace}

    procedure PauseCW; {Pause}
    procedure ResumeCW; {Resume}

    procedure SendStr(sStr: string); {Sends a string (Overwrites buffer)}
    procedure SendStrLoop(S: string); {Sends a string (repeat CQmax times)}
    procedure SendStrFIFO(sStr: string); {Sends a string (adds to buffer)}

    procedure SetCWSendBuf(b: byte; S: string); {Sets str to buffer but does not start sending}
    procedure SetCWSendBufCharPTT( C : char ); {Adds a char to the end of buffer. Also controls PTT if enabled. Called from Keyboard}

    procedure SetRigFlag(i : Integer); // 0 : no rigs, 1 : rig 1, etc
    procedure SetVoiceFlag(i : Integer); // 0 : no rigs, 1 : rig 1, etc

    procedure SetPTT(_on : Boolean);
    procedure SetPTTDelay(before, after : word);
    procedure SetWeight(W : word); {Sets the weight 0-100 %}

    property RandCQStr[Index: Integer]: string write SetRandCQStr;

    property CQLoopCount: Integer read FCQLoopCount write SetCQLoopCount;
    property CQLoopMax: Integer read FCQLoopMax write SetCQLoopMax;
    property CQRepeatIntervalSec: Double read FCQRepeatIntervalSec write SetCQRepeatInterval;

    property WPM: Integer read FKeyerWPM write SetWPM;
    property UseSideTone: Boolean read FUseSideTone write SetUseSideTone;
    property SideTonePitch: Integer read FSideTonePitch write SetSideTonePitch;
    property SpaceFactor: Integer read FSpaceFactor write SetSpaceFactor;
    property EISpaceFactor: Integer read FEISpaceFactor write SetEISpaceFactor;

    property USBIF4CW_Detected: Boolean read FUSBIF4CW_Detected;
    property UserFlag: Boolean read FUserFlag write FUserFlag;
    property KeyingPort: TKeyingPort read FKeyingPort write SetKeyingPort;

    property OnCallsignSentProc: TNotifyEvent read FOnCallsignSentProc write FOnCallsignSentProc;
    property OnPaddle: TNotifyEvent read FOnPaddleEvent write FOnPaddleEvent;
    property OnSpeedChanged: TNotifyEvent read FOnSpeedChanged write FOnSpeedChanged;
    property KeyingSignalReverse: Boolean read FKeyingSignalReverse write FKeyingSignalReverse;

    property UsbPortIn: TUsbPortDataArray read FUsbPortIn;
    property UsbPortOut: TUsbPortDataArray read FUsbPortOut;

    property Usbif4cwSyncWpm: Boolean read FUsbif4cwSyncWpm write FUsbif4cwSyncWpm;
    property PaddleReverse: Boolean read FPaddleReverse write SetPaddleReverse;

    // USBIF4CW support
    function usbif4cwSetWPM(nID: Integer; nWPM: Integer): Long;
    function usbif4cwSetPTTParam(nId: Integer; nLen1: Byte; nLen2: Byte): Long;
    function usbif4cwSetPTT(nId: Integer; tx: Byte): Long;
    function usbif4cwGetVersion(nId: Integer): Long;
    function usbif4cwSetPaddle(nId: Integer; param: Byte): Long;

    // 1Port Control support
    procedure SetCommPortDriver(CP: TCommPortDriver);
    procedure ResetCommPortDriver(port: TKeyingPort);

    // WinKeyer support
    property UseWinKeyer: Boolean read FUseWinKeyer write FUseWinKeyer;
    procedure WinkeyerSendCallsign(S: string);
    procedure WinkeyerSendStr(S: string);
    procedure WinKeyerClear();

    procedure IncCWSpeed();
    procedure DecCWSpeed();
    procedure ToggleFixedSpeed();
    property FixedSpeed: Integer read FFixedSpeed write FFixedSpeed;
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
begin
   WinKeyerTimer.Enabled := False;
   RepeatTimer.Enabled := False;
   FInitialized := False;
   FComKeying := ZComKeying;
   FUseWinKeyer := False;
   FOnSpeedChanged := nil;
   FUseFixedSpeed := False;
   FBeforeSpeed := 0;
   FFixedSpeed := 0;

   {$IFDEF USESIDETONE}
   FTone := TSideTone.Create(700);

   {$ENDIF}

   FUSBIF4CW_Detected := False;
   FUSBIF4CW := nil;
   FUSBIF4CW_Version := 0;

   InitializeCriticalSection(FUsbPortDataLock);
   FPrevUsbPortData := $00;
   FUsbPortData := $FF;

   FUserFlag := False;
   FVoiceFlag := 0;

   FSpaceFactor := 100; {space length factor in %}
   FEISpaceFactor := 100; {space length factor after E and I}

   FMonitorThread := nil;
   FOnCallsignSentProc := nil;
   FOnPaddleEvent := nil;
   FKeyingSignalReverse := False;
   FUsbif4cwSyncWpm := False;

   ZeroMemory(@FPrevPortIn, SizeOf(FPrevPortIn));

   KeyingPort := tkpNone;
end;

procedure TdmZLogKeyer.DataModuleDestroy(Sender: TObject);
begin
   {$IFDEF USESIDETONE}
   FTone.Free();
   {$ENDIF}
   FMonitorThread.Free();
   COM_OFF();
   USB_OFF();
end;

procedure TdmZLogKeyer.DoDeviceChanges(Sender: TObject);
begin
   if FKeyingPort <> tkpUSB then begin
      Exit;
   end;

   USB_OFF();

   HidController.Enumerate;
   repeat
      Sleep(1);
   until FUsbDetecting = False;
end;

function TdmZLogKeyer.DoEnumeration(HidDev: TJvHidDevice; const Index: Integer) : Boolean;
var
   n: Integer;
   s: string;
begin
   FUsbDetecting := True;
   try
      if FKeyingPort <> tkpUSB then begin
         Result := True;
         Exit;
      end;

      if (HidDev.Attributes.ProductID = USBIF4CW_PRODID) and
         (HidDev.Attributes.VendorID = USBIF4CW_VENDORID) then begin
         if HidDev.CheckOut() = True then begin
            FUSBIF4CW := HidDev;
            FUSBIF4CW.OpenFile;
            FUSBIF4CW_Detected := True;

            n := Pos('Ver.', HidDev.ProductName);
            if n > 0 then begin
               s := Copy(HidDev.ProductName, n + 4); // 2.3
               FUSBIF4CW_Version := Trunc(StrToFloatDef(s, 0) * 10);
            end;

            Result := False;
            Exit;
         end;
      end;

      Result := True;
   finally
      FUsbDetecting := False;
   end;
end;

procedure TdmZLogKeyer.HidControllerDeviceData(HidDev: TJvHidDevice;
  ReportID: Byte; const Data: Pointer; Size: Word);
var
   {$IFDEF DEBUG}
   s: string;
   {$ENDIF}
   p: PBYTE;
begin
   if FKeyingPort <> tkpUSB then begin
      Exit;
   end;

   p := Data;

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
   if (p[0] <> FPrevPortIn[0]) or
      (p[1] <> FPrevPortIn[1]) or
      (p[2] <> FPrevPortIn[2]) or
      (p[3] <> FPrevPortIn[3]) or
      (p[4] <> FPrevPortIn[4]) or
      (p[5] <> FPrevPortIn[5]) or
      (p[6] <> FPrevPortIn[6]) or
      (p[7] <> FPrevPortIn[7]) then begin
      {$IFDEF DEBUG}
      OutputDebugString(PChar('***HidControllerDeviceData*** ReportID=' + IntToHex(ReportID,2) + ' DATA=' + s));
      {$ENDIF}

      // Port Data In
      FUsbPortIn[0] := p[6];
      FUsbPortIn[1] := p[7];

      // パドル入力があったか？
      if ((FUsbPortIn[1] and $01) = 0) or
         ((FUsbPortIn[1] and $04) = 0) then begin
         {$IFDEF DEBUG}
         OutputDebugString(PChar('**PADDLE IN**'));
         {$ENDIF}

         // fire event
         if usbif4cwGetVersion(0) >= 20 then begin
            if Assigned(FOnPaddleEvent) then begin
               FOnPaddleEvent(Self);
            end;
         end;
      end;

      CopyMemory(@FPrevPortIn, p, 8);
   end;
end;

procedure TdmZLogKeyer.HidControllerDeviceUnplug(HidDev: TJvHidDevice);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('***HidControllerDeviceUnplug()***'));
   {$ENDIF}
   USB_OFF();
end;

procedure TdmZLogKeyer.HidControllerRemoval(HidDev: TJvHidDevice);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('***HidControllerRemoval()***'));
   {$ENDIF}
end;

procedure TdmZLogKeyer.SetRigFlag(i: Integer); // 0 : no rigs, 1 : rig 1, etc
begin
   if FKeyingPort = tkpUSB then begin
      EnterCriticalSection(FUsbPortDataLock);

      case i of
         0, 1:
            FUsbPortData := FUsbPortData or $04;
         2:
            FUsbPortData := FUsbPortData and $FB;
         else
            FUsbPortData := FUsbPortData;
      end;
      SendUsbPortData();
      LeaveCriticalSection(FUsbPortDataLock);
      Exit;
   end;
end;

procedure TdmZLogKeyer.SetVoiceFlag(i : Integer); // 0 : no rigs, 1 : rig 1, etc
begin
   if FKeyingPort = tkpUSB then begin
      EnterCriticalSection(FUsbPortDataLock);
      if i = 1 then begin
         FUsbPortData := FUsbPortData and $F7;
      end
      else begin
         FUsbPortData := FUsbPortData or $08;
      end;
      SendUsbPortData();
      LeaveCriticalSection(FUsbPortDataLock);
      Exit;
   end;
end;

procedure TdmZLogKeyer.Sound();
begin
   {$IFDEF USESIDETONE}
   FTone.Play();
   {$ENDIF}
end;

procedure TdmZLogKeyer.NoSound();
begin
   {$IFDEF USESIDETONE}
   FTone.Stop();
   {$ENDIF}
end;

procedure TdmZLogKeyer.ControlPTT(PTTON: Boolean);
begin
   FPTTFLAG := PTTON;

   if FKeyingPort = tkpUSB then begin
      EnterCriticalSection(FUsbPortDataLock);
      if PTTON then begin
         FUsbPortData := FUsbPortData and $FD;
      end
      else begin
         FUsbPortData := FUsbPortData or $02;
      end;
      SendUsbPortData();
      LeaveCriticalSection(FUsbPortDataLock);
      Exit;
   end;

   if (FKeyingPort in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = False) then begin
      if FKeyingSignalReverse = False then begin
         FComKeying.ToggleRTS(PTTON);
      end
      else begin
         FComKeying.ToggleDTR(PTTON);
      end;
      Exit;
   end;

   if (FKeyingPort in [tkpSerial1..tkpSerial20]) and (FUseWinKeyer = True) then begin
      WinkeyerControlPTT(PTTON);
   end;
end;

procedure TdmZLogKeyer.SetPTT(_on: Boolean);
begin
   FPTTEnabled := _on;

   if FKeyingPort = tkpUSB then begin
      if _on = True then begin
         usbif4cwSetPTTParam(0, FPttDelayBeforeTime, FPttDelayAfterTime);
      end
      else begin
         ControlPTT(False);
         usbif4cwSetPTTParam(0, 0, 0);
      end;
   end;
end;

function TdmZLogKeyer.PTTIsOn: Boolean;
begin
   Result := FPTTFLAG;
end;

procedure TdmZLogKeyer.SetPTTDelay(before, after: word);
begin
   if FUseWinkeyer = True then begin
      WinkeyerSetPTTDelay(before, after);
   end
   else begin
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
      FTone.Frequency := FSideTonePitch;
      {$ENDIF}
   end;
end;

procedure TdmZLogKeyer.SetCWSendBufChar(C: char);
var
   m: byte;
begin
   for m := 1 to codemax do
      FCWSendBuf[0, codemax * (tailcwstrptr - 1) + m] := FCodeTable[Ord(C)][m];

   inc(tailcwstrptr);
   if tailcwstrptr > charmax then
      tailcwstrptr := 1;

   for m := 1 to codemax do
      FCWSendBuf[0, codemax * (tailcwstrptr - 1) + m] := $FF;
end;

procedure TdmZLogKeyer.SetCWSendBufCharPTT(C: char);
var
   m: Integer;
begin
   if UseWinKeyer = True then begin
      WinKeyerSendStr(C);
      Exit;
   end;

   if FPTTEnabled and Not(PTTIsOn) then begin
      ControlPTT(True);
      FKeyingCounter := FPttDelayBeforeCount;
   end;

   // SendOK := False;
   for m := 1 to codemax do
      FCWSendBuf[0, codemax * (tailcwstrptr - 1) + m] := FCodeTable[Ord(C)][m];

   if FPTTEnabled then begin
      FPttHoldCounter := FPttDelayAfterCount;
      FCWSendBuf[0, codemax * (tailcwstrptr - 1) + codemax + 1] := $A2; { holds PTT until pttafter expires }

      inc(tailcwstrptr);
      if tailcwstrptr > charmax then
         tailcwstrptr := 1;

      Exit;
   end;

   inc(tailcwstrptr);
   if tailcwstrptr > charmax then
      tailcwstrptr := 1;

   for m := 1 to codemax do
      FCWSendBuf[0, codemax * (tailcwstrptr - 1) + m] := $FF;
   // SendOK := True;
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
   n, m, Len: word;
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

   Len := length(SS);
   for n := 1 to Len do begin
      if SS[n] = ':' then { callsign 1st char }
         callsignptr := n;

      for m := 1 to codemax do
         FCWSendBuf[b, codemax * (n - 1) + m] := FCodeTable[Ord(SS[n])][m];
   end;

   FCWSendBuf[b, codemax * Len + 1] := $FF;
end;

procedure TdmZLogKeyer.SendStr(sStr: string);
var
   SS: string;
begin
   if sStr = '' then
      Exit;

   SS := DecodeCommands(sStr);

   if FPTTEnabled { and Not(PTTIsOn) } then
      SS := '(' + SS + ')';

   SetCWSendBuf(0, SS);
   cwstrptr := 1;
   FSendOK := True;
   FKeyingCounter := 1;
end;

procedure TdmZLogKeyer.SendStrLoop(S: string);
var
   SS: string;
begin
   SS := S;
   SS := DecodeCommands(S);

   if FPTTEnabled then begin
      SS := '(' + SS + ')';
   end;

   if FUseWinKeyer = True then begin
      FWkLastMessage := SS;
      WinkeyerSendStr(SS);
   end
   else begin
      SS := SS + '@';

      FCQLoopCount := 1;
   //   SendStr(SS + '@');

      SetCWSendBuf(0, SS);
      cwstrptr := 1;
      FSendOK := True;
      FKeyingCounter := 1;
   end;
end;

procedure TdmZLogKeyer.SendStrFIFO(sStr: string);
var
   n: Integer;
   SS: string;
begin
   { StringBuffer := StringBuffer + sStr; }
   SS := DecodeCommands(sStr);
   if FPTTEnabled then
      SS := '(' + SS + ')';

   for n := 1 to length(SS) do begin
      if SS[n] = ':' then { callsign 1st char }
         callsignptr := n;

      SetCWSendBufChar(SS[n]);
   end;
end;

procedure TdmZLogKeyer.CW_ON;
begin
   case FKeyingPort of
      tkpSerial1..tkpSerial20: begin
         if FKeyingSignalReverse = False then begin
            FComKeying.ToggleDTR(True);
         end
         else begin
            FComKeying.ToggleRTS(True);
         end;
      end;

      tkpUSB: begin
         EnterCriticalSection(FUsbPortDataLock);
         FUsbPortData := FUsbPortData and $FE;
         SendUsbPortData();
         LeaveCriticalSection(FUsbPortDataLock);
      end;
   end;
end;

procedure TdmZLogKeyer.CW_OFF;
begin
   case FKeyingPort of
      tkpSerial1..tkpSerial20: begin
         if FKeyingSignalReverse = False then begin
            FComKeying.ToggleDTR(False);
         end
         else begin
            FComKeying.ToggleRTS(False);
         end;
      end;

      tkpUSB: begin
         EnterCriticalSection(FUsbPortDataLock);
         FUsbPortData := FUsbPortData or $01;
         SendUsbPortData();
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

      if FKeyingPort <> tkpUSB then begin
         CW_OFF;
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
         ControlPTT(True);
      end;

      $1F: begin
         ControlPTT(False);
      end;

      0: begin
         CW_OFF;
         if FUseSideTone then begin
            NoSound();
         end;
         FKeyingCounter := FBlank1Count;
      end;

      2: begin { normal space x space factor (%) }
         CW_OFF;
         if FUseSideTone then begin
            NoSound();
         end;
         FKeyingCounter := Trunc(FBlank3Count * FSpaceFactor / 100);
      end;

      $E: begin { normal space x space factor x eispacefactor(%) }
         CW_OFF;
         if FUseSideTone then begin
            NoSound();
         end;
         FKeyingCounter := Trunc(FBlank3Count * (FSpaceFactor / 100) * (FEISpaceFactor / 100));
      end;

      1: begin
         CW_ON;
         if FUseSideTone then begin
            Sound();
         end;

         FKeyingCounter := FDotCount;
      end;

      3: begin
         CW_ON;
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
               ControlPTT(False);
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
            FSelectedBuf := FCQLoopCount mod 3; // random(3);
            if FSelectedBuf > 2 then begin
               FSelectedBuf := 0;
            end;

            if FSelectedBuf in [1 .. 2] then begin
               if FRandCQStr[FSelectedBuf] = '' then begin
                  FSelectedBuf := 0;
               end;
            end;
         end;
         cwstrptr := 0;
      end;

      $DD: begin
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
   end;

   Inc(cwstrptr);
end; { TimerProcess }

procedure TdmZLogKeyer.SetWPM(wpm: Integer);
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

      if (FKeyingPort = tkpUSB) and (FUsbif4cwSyncWpm = True) then begin
         usbif4cwSetWPM(0, FKeyerWPM);
      end;

      if (FKeyingPort in [tkpSerial1 .. tkpSerial20]) and (FUseWinKeyer = True) then begin
         WinKeyerSetSpeed(FKeyerWPM);
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
   WPM := 25;

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
   FCodeTable[Ord('-')][9] := 3;
   FCodeTable[Ord('-')][10] := 2;
   FCodeTable[Ord('-')][11] := 9;

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

   if FMonitorThread = nil then begin
      FMonitorThread := TKeyerMonitorThread.Create(Self);
   end;
   FMonitorThread.Start();

   FInitialized := True;
end;

procedure TdmZLogKeyer.CloseBGK();
begin
   ControlPTT(False);

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

   CW_OFF;

   KeyingPort := tkpNone;
end;

procedure TdmZLogKeyer.PauseCW;
begin
   FSendOK := False;

   CW_OFF;
   if FUseSideTone then begin
      NoSound();
   end;

   if FPTTEnabled then begin
      ControlPTT(False);
   end;
end;

procedure TdmZLogKeyer.ResumeCW;
begin
   if FPTTEnabled then begin
      ControlPTT(True);
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
      CW_OFF;

      FUserFlag := False;
   end;

   FSendOK := True;
   FCQLoopCount := 0;

   if FPTTEnabled then begin
      ControlPTT(False);
   end;
end;

procedure TdmZLogKeyer.CancelLastChar;
var
   m: Integer;
begin
   if ((tailcwstrptr - 1) * codemax + 1) > (cwstrptr) then begin
      dec(tailcwstrptr, 1);
      for m := 1 to codemax do begin
         FCWSendBuf[FSelectedBuf, codemax * (tailcwstrptr - 1) + m] := $FF;
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
   if (cwstrptr > 1) and FSendOK then
      Result := True
   else
      Result := False;
end;

procedure TdmZLogKeyer.SetRandCQStr(Index: Integer; cqstr: string);
begin
   FRandCQStr[Index] := cqstr;

   if FPTTEnabled then begin
      cqstr := '(' + cqstr + ')';
   end;
   cqstr := cqstr + '@';
   SetCWSendBuf(Index, cqstr);
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

procedure TdmZLogKeyer.SetKeyingPort(port: TKeyingPort);
begin
//   if FKeyingPort = port then begin
//      Exit;
//   end;

   FKeyingPort := port;
   case port of
      tkpNone: begin
         COM_OFF();
         USB_OFF();
      end;

      tkpSerial1 .. tkpSerial20: begin
         USB_OFF();
         COM_ON(port);
      end;

      tkpUSB: begin
         COM_OFF();
         USB_ON();
      end;
   end;
end;

procedure TdmZLogKeyer.TuneOn;
begin
   ClrBuffer;
   FSendOK := False;
   if FPTTEnabled then begin
      ControlPTT(True);
   end;
   CW_ON;

   if FUseSideTone then begin
      Sound();
   end;
end;

procedure TdmZLogKeyer.SendUsbPortData();
var
//   BR: DWORD;
   OutReport: array[0..8] of Byte;
begin
   if FUSBIF4CW = nil then begin
      Exit;
   end;
   if FUsbPortData = FPrevUsbPortData then begin
      Exit;
   end;

   OutReport[0] := 0;
   OutReport[1] := 1;
   OutReport[2] := FUsbPortData;
   OutReport[3] := 0;
   OutReport[4] := 0;
   OutReport[5] := 0;
   OutReport[6] := 0;
   OutReport[7] := 0;
   OutReport[8] := 0;
   FUSBIF4CW.SetOutputReport(OutReport, 9);
   FPrevUsbPortData := FUsbPortData;
//   FUSBIF4CW.WriteFile(OutReport, FUSBIF4CW.Caps.OutputReportByteLength, BR);
end;

procedure TdmZLogKeyer.COM_ON(port: TKeyingPort);
begin
   if FUseWinKeyer = True then begin
      WinKeyerOpen(port);
   end
   else begin
      if FComKeying.Connected = False then begin
         FComKeying.Port := TPortNumber(port);
         FComKeying.Connect;
      end;
      FComKeying.ToggleDTR(False);
      FComKeying.ToggleRTS(False);
   end;
end;

procedure TdmZLogKeyer.COM_OFF();
begin
   if FUseWinKeyer = True then begin
      WinKeyerClose();
   end
   else begin
      FComKeying.Disconnect();
   end;
end;

procedure TdmZLogKeyer.USB_ON();
begin
   HidController.Enumerate();
   repeat
      Sleep(1);
   until FUsbDetecting = False;
   ZeroMemory(@FPrevPortIn, SizeOf(FPrevPortIn));
   FPrevUsbPortData := $00;
   FUsbPortData := $FF;
   SendUsbPortData();
end;

procedure TdmZLogKeyer.USB_OFF();
begin
   if FUSBIF4CW <> nil then begin
      HidController.CheckIn(FUSBIF4CW);
      FUSBIF4CW_Detected := False;
      FUSBIF4CW := nil;
   end;
end;

procedure TdmZLogKeyer.SetPaddleReverse(fReverse: Boolean);
begin
   FPaddleReverse := fReverse;
   if FKeyingPort = tkpUSB then begin
      if fReverse = True then begin
         usbif4cwSetPaddle(0, 1);
      end
      else begin
         usbif4cwSetPaddle(0, 0);
      end;
   end;
end;

procedure TdmZLogKeyer.SetUseSideTone(fUse: Boolean);
begin
   FUseSideTone := fUse;
   if fUse = False then begin
      NoSound();
   end;
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
   if FUSBIF4CW = nil then begin
      Result := -1;
      Exit;
   end;

   if usbif4cwGetVersion(0) < 20 then begin
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
   FUSBIF4CW.SetOutputReport(OutReport, 9);
   Result := 0;
end;

function TdmZLogKeyer.usbif4cwSetPTTParam(nId: Integer; nLen1: Byte; nLen2: Byte): Long;
var
   OutReport: array[0..8] of Byte;
   P: Byte;
begin
   if FUSBIF4CW = nil then begin
      Result := -1;
      Exit;
   end;

   if usbif4cwGetVersion(0) < 20 then begin
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
      FUSBIF4CW.SetOutputReport(OutReport, 9);
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
   FUSBIF4CW.SetOutputReport(OutReport, 9);

   Result := 0;
end;

function TdmZLogKeyer.usbif4cwSetPTT(nId: Integer; tx: Byte): Long;
var
   OutReport: array[0..8] of Byte;
begin
   if FUSBIF4CW = nil then begin
      Result := -1;
      Exit;
   end;

   if usbif4cwGetVersion(0) < 20 then begin
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
   FUSBIF4CW.SetOutputReport(OutReport, 9);
   Result := 0;
end;

function TdmZLogKeyer.usbif4cwGetVersion(nId: Integer): Long;
begin
   Result := FUSBIF4CW_Version;
end;

function TdmZLogKeyer.usbif4cwSetPaddle(nId: Integer; param: Byte): Long;
var
   OutReport: array[0..8] of Byte;
begin
   if FUSBIF4CW = nil then begin
      Result := -1;
      Exit;
   end;

   if usbif4cwGetVersion(0) < 20 then begin
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
   FUSBIF4CW.SetOutputReport(OutReport, 9);
   Result := 0;
end;

procedure TdmZLogKeyer.SetCommPortDriver(CP: TCommPortDriver);
begin
   if FComKeying = CP then begin
      Exit;
   end;

   COM_OFF();
   FComKeying := CP;
//   COM_ON(FKeyingPort);

   FKeyingPort := TKeyingPort(CP.Port);
end;

procedure TdmZLogKeyer.ResetCommPortDriver(port: TKeyingPort);
begin
   if FComKeying = ZComKeying then begin
      Exit;
   end;

//   COM_OFF();
   FComKeying := ZComKeying;
//   COM_ON(FKeyingPort);

   KeyingPort := port;
end;

procedure TdmZLogKeyer.WinKeyerOpen(nPort: TKeyingPort);
var
   Buff: array[0..10] of Byte;
   dwTick: DWORD;
begin
   FWkInitializeMode := False;
   FWkRevision := 0;
   FWkStatus := 0;
   FWkSpeed := 0;
   FWkEcho := 0;
   FWkLastMessage := '';
   WinkeyerTimer.Enabled := False;
   RepeatTimer.Enabled := False;
   RepeatTimer.Interval := Trunc(FCQRepeatIntervalSec * 1000);

   //1) Open serial communications port. Use 1200 baud, 8 data bits, no parity
   FComKeying.Port := TPortNumber(nPort);
   FComKeying.BaudRate := br1200;
   FComKeying.Connect();

   //2) To power up WK enable DTR and disable RTS
   FComKeying.ToggleDTR(True);
   FComKeying.ToggleRTS(False);

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
   FComKeying.SendData(@Buff, 2);
   Sleep(100);
   Buff[0] := $FF;
   FComKeying.SendData(@Buff, 1);

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
   FComKeying.SendData(@Buff, 2);

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

   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_GET_SPEEDPOT_CMD;
   FComKeying.SendData(@Buff, 1);
end;

procedure TdmZLogKeyer.WinKeyerClose();
begin
   FComKeying.Disconnect();
end;

procedure TdmZLogKeyer.WinKeyerSetSpeed(nWPM: Integer);
var
   Buff: array[0..10] of Byte;
begin
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_SETWPM_CMD;
   Buff[1] := nWPM;
   FComKeying.SendData(@Buff, 2);
end;

procedure TdmZLogKeyer.WinKeyerClear();
var
   Buff: array[0..10] of Byte;
begin
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_CLEAR_CMD;
   FComKeying.SendData(@Buff, 1);
   FWkLastMessage := '';
end;

procedure TdmZLogKeyer.WinKeyerSetSideTone(fOn: Boolean);
var
   Buff: array[0..10] of Byte;
begin
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_SIDETONE_CMD;
   if fOn = True then begin
      Buff[1] := $06;
   end
   else begin
      Buff[1] := $86;
   end;
   FComKeying.SendData(@Buff, 2);
end;

procedure TdmZLogKeyer.WinkeyerControlPTT(fOn: Boolean);
var
   Buff: array[0..10] of Byte;
begin
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_PTT_CMD;
   if fOn = True then begin
      Buff[1] := WK_PTT_ON;
   end
   else begin
      Buff[1] := WK_PTT_OFF;
   end;
   FComKeying.SendData(@Buff, 2);
end;

procedure TdmZLogKeyer.WinkeyerSetPTTDelay(before, after: Byte);
var
   Buff: array[0..10] of Byte;
begin
   FillChar(Buff, SizeOf(Buff), 0);
   Buff[0] := WK_SET_PTTDELAY_CMD;
   Buff[1] := before;
   Buff[2] := after;
   FComKeying.SendData(@Buff, 3);
end;

procedure TdmZLogKeyer.WinkeyerSendCallsign(S: string);
var
   dwTick: DWORD;
begin
   FComKeying.SendString(AnsiString(S));

   // 送信中になるまで待機
   dwTick := GetTickCount();
   while true do begin
      Application.ProcessMessages();
      if (FWkStatus and WK_STATUS_BUSY) = WK_STATUS_BUSY then begin
//         OutputDebugString(PChar('BREAK'));
         Break;
      end;

      // 1sec
      if (GetTickCount() - dwTick) >= 1000 then begin
         Break;
      end;
   end;

   // 送信終了まで待機
   dwTick := GetTickCount();
   while true do begin
      Application.ProcessMessages();
      if (FWkStatus and WK_STATUS_BUSY) = 0 then begin
//         OutputDebugString(PChar('BREAK'));
         Break;
      end;

      // 10sec
      if (GetTickCount() - dwTick) >= 10000 then begin
         Break;
      end;
   end;

   if Assigned(FOnCallsignSentProc) then begin
      FOnCallsignSentProc(nil);
   end;
end;

procedure TdmZLogKeyer.WinkeyerSendStr(S: string);
begin
   if FPTTEnabled { and Not(PTTIsOn) } then begin
      S := '(' + S + ')';
   end;

   // PTT ON/OFF
   S := StringReplace(S, '(', #18#01, [rfReplaceAll]);
   S := StringReplace(S, ')', #18#00, [rfReplaceAll]);

   // AR
   S := StringReplace(S, 'a', #$1b + 'AR', [rfReplaceAll]);

   // BK
   S := StringReplace(S, 'b', #$1b + 'BK', [rfReplaceAll]);
   S := StringReplace(S, '~', #$1b + 'BK', [rfReplaceAll]);

   // KN
   S := StringReplace(S, 'k', #$1b + 'KN', [rfReplaceAll]);

   // SK
   S := StringReplace(S, 's', #$1b + 'SK', [rfReplaceAll]);

   // unsupport
   S := StringReplace(S, '_', '', [rfReplaceAll]);
   S := StringReplace(S, ':', '', [rfReplaceAll]);
   S := StringReplace(S, '*', '', [rfReplaceAll]);

   FComKeying.SendString(AnsiString(S));
end;

procedure TdmZLogKeyer.ZComKeyingReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: Cardinal);
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

         if ((b and $c0) = $c0) then begin    // STATUS
            // 送信中→送信終了に変わったら、リピートタイマー起動
            if (FWkLastMessage <> '') and ((FWkStatus and WK_STATUS_BUSY) = WK_STATUS_BUSY) and ((b and WK_STATUS_BUSY) = 0) then begin
               RepeatTimer.Enabled := True;
            end;

            // STATUSを保存
            FWkStatus := b;

            {$IFDEF DEBUG}
            OutputDebugString(PChar('WinKey STATUS=[' + IntToHex(b, 2) + ']'));
            {$ENDIF}
         end
         else if ((b and $c0) = $80) then begin   // POT POSITION
            newwpm := (b and $3F);
            FWkSpeed := newwpm;
            WinkeyerTimer.Enabled := True;
         end
         else begin  // ECHO TEST
            FWkEcho := b;
         end;
      end;
   end;
end;

procedure TdmZLogKeyer.WinkeyerTimerTimer(Sender: TObject);
begin
   WinkeyerTimer.Enabled := False;

   SetWPM(FWkSpeed);

   if Assigned(FOnSpeedChanged) then begin
      FOnSpeedChanged(Self);
   end;
end;

procedure TdmZLogKeyer.RepeatTimerTimer(Sender: TObject);
begin
   WinKeyerSendStr(FWkLastMessage);
   RepeatTimer.Enabled := False;
end;

procedure TdmZLogKeyer.IncCWSpeed();
//var
//   i : integer;
begin
   WPM := WPM + 1;

//   i := dmZLogGlobal.Settings.CW._speed + 1;
//   if i > MAXWPM then begin
//      i := MAXWPM;
//   end;
//   dmZLogGlobal.Speed := i;
//
//   MainForm.SpeedBar.Position := i;
//   MainForm.SpeedLabel.Caption := IntToStr(i) + ' wpm';

   if Assigned(FOnSpeedChanged) then begin
      FOnSpeedChanged(Self);
   end;
end;

procedure TdmZLogKeyer.DecCWSpeed();
//var
//   i : integer;
begin
   WPM := WPM - 1;

//   i := dmZLogGlobal.Settings.CW._speed - 1;
//   if i < MINWPM then begin
//      i := MINWPM;
//   end;
//   dmZLogGlobal.Speed := i;
//
//   MainForm.SpeedBar.Position := i;
//   MainForm.SpeedLabel.Caption := IntToStr(i) + ' wpm';

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

end.
