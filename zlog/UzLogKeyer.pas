unit UzLogKeyer;

//
// zLog for Windows
// CW Keyer Module
//

// サイドトーンを使用する場合、下記の定義を有効にする 要ToneGen.pas
//{$DEFINE USESIDETONE}

interface

uses
  System.SysUtils, System.Classes, Windows, MMSystem,
  JvComponentBase, JvHidControllerClass, CPDrv
  {$IFDEF USESIDETONE},ToneGen{$ENDIF};

const
  charmax = 256;
  codemax = 16;
  MAXWPM = 60;
  MINWPM = 1;
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

  TKeyerPaddleThread = class(TThread)
  private
    { Private declarations }
    FKeyer: TdmZLogKeyer;
    FWaitMS: Integer; // wait time in ms
  protected
    procedure Execute; override;
  public
    constructor Create(AKeyer: TdmZLogKeyer);
  end;

  TdmZLogKeyer = class(TDataModule)
    HidController: TJvHidDeviceController;
    ZComKeying: TCommPortDriver;
    procedure DoDeviceChanges(Sender: TObject);
    function DoEnumeration(HidDev: TJvHidDevice; const Index: Integer) : Boolean;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private 宣言 }
    FMonitorThread: TKeyerMonitorThread;
    FPaddleThread: TKeyerPaddleThread;

    FUSBIF4CW_Detected: Boolean;
    FUSBIF4CW: TJvHIDDevice;

    {$IFDEF USESIDETONE}
    FTone: TToneGen;
    {$ENDIF}

    FPrevUsbPortData: Byte;
    FUsbPortData: Byte;

    // mask data for data port
    _bandmask: byte; //bit mask for band data

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

    FUseSideTone: Boolean;
    FSideTonePitch: Integer;       {side tone pitch}

    {Paddle related variables}
    FPaddlePort: Integer; {paddle input port. PRTport -1 }
    FPaddleWaiting: Boolean; {True if ready to receive paddle input}
    FEndOfWordCounter: Integer; {counter which determines the end of a word}
                       {set in m_set and decremented in $AA }
    mouX, mouY : word;  { 1 or 3 dot or dash}

    FOnCallsignSentProc: TNotifyEvent;

    // False: PTT=RTS,KEY=DTR
    // True:  PTT=DTR,KEY=RTS
    FKeyingSignalReverse: Boolean;

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

    procedure SetBandMask(bandmask: Byte);
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

    procedure PaddleProcessUSB;

    procedure SetRigFlag(i : Integer); // 0 : no rigs, 1 : rig 1, etc
    procedure SetPTT(_on : Boolean);
    procedure SetPTTDelay(before, after : word);
    procedure SetWeight(W : word); {Sets the weight 0-100 %}
    procedure SetReversePaddle(boo : Boolean);

    property PaddlePort: Integer read FPaddlePort write FPaddlePort;

    property RandCQStr[Index: Integer]: string write SetRandCQStr;

    property CQLoopCount: Integer read FCQLoopCount write SetCQLoopCount;
    property CQLoopMax: Integer read FCQLoopMax write SetCQLoopMax;
    property CQRepeatIntervalSec: Double read FCQRepeatIntervalSec write SetCQRepeatInterval;

    property WPM: Integer read FKeyerWPM write SetWPM;
    property UseSideTone: Boolean read FUseSideTone write FUseSideTone;
    property SideTonePitch: Integer read FSideTonePitch write SetSideTonePitch;
    property SpaceFactor: Integer read FSpaceFactor write SetSpaceFactor;
    property EISpaceFactor: Integer read FEISpaceFactor write SetEISpaceFactor;

    property USBIF4CW_Detected: Boolean read FUSBIF4CW_Detected;
    property BandMask: Byte read _bandmask write SetBandMask;
    property UserFlag: Boolean read FUserFlag write FUserFlag;
    property KeyingPort: TKeyingPort read FKeyingPort write FKeyingPort;

    property OnCallsignSentProc: TNotifyEvent read FOnCallsignSentProc write FOnCallsignSentProc;

    procedure SetSerialCWKeying(PortNr : integer);

    property KeyingSignalReverse: Boolean read FKeyingSignalReverse write FKeyingSignalReverse;
  end;

var
  dmZLogKeyer: TdmZLogKeyer;

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
begin
   FInitialized := False;

   {$IFDEF USESIDETONE}
   FTone := TToneGen.Create(nil);
   FTone.Waveform := tgSine;
   FTone.Duration := 100;
   FTone.Loop := True;
   FTone.Frequency := 700;
   {$ENDIF}

   FUSBIF4CW_Detected := False;
   FUSBIF4CW := nil;

   FPrevUsbPortData := $FF;
   FUsbPortData := $FF;

   Bandmask := $00; //bit mask for band data

   FUserFlag := False;
   FVoiceFlag := 0;

   FKeyingPort := tkpNone;

   FSpaceFactor := 100; {space length factor in %}
   FEISpaceFactor := 100; {space length factor after E and I}

   FMonitorThread := nil;
   FOnCallsignSentProc := nil;

   FPaddleThread := nil;
   FEndOfWordCounter := 0;

   FKeyingSignalReverse := False;
end;

procedure TdmZLogKeyer.DataModuleDestroy(Sender: TObject);
begin
   {$IFDEF USESIDETONE}
   FTone.Free();
   {$ENDIF}
   ZComKeying.Disconnect;
   FMonitorThread.Free();
   FPaddleThread.Free();
end;

procedure TdmZLogKeyer.DoDeviceChanges(Sender: TObject);
begin
   if FUSBIF4CW <> nil then begin
      HidController.CheckIn(FUSBIF4CW);
      FUSBIF4CW_Detected := False;
   end;

   HidController.Enumerate;
end;

function TdmZLogKeyer.DoEnumeration(HidDev: TJvHidDevice; const Index: Integer) : Boolean;
begin
   with HidDev do begin
      if (Attributes.ProductID = USBIF4CW_PRODID) and (Attributes.VendorID = USBIF4CW_VENDORID) then begin
         if HidController.CheckOutByIndex(FUSBIF4CW, Index) = True then begin
            FUSBIF4CW.OpenFile;
            FUSBIF4CW_Detected := True;
            Result := False;
            Exit;
         end;
      end;
   end;

   Result := True;
end;

procedure TdmZLogKeyer.SetRigFlag(i: Integer); // 0 : no rigs, 1 : rig 1, etc
begin
   if FKeyingPort = tkpUSB then begin
      FUsbPortData := (not(_bandmask) and $F0) or (FUsbPortData and $0F);

      case i of
         0, 1:
            FUsbPortData := FUsbPortData or $04;
         2:
            FUsbPortData := FUsbPortData and $FB;
         else
            FUsbPortData := FUsbPortData;
      end;

      Exit;
   end;
end;

procedure TdmZLogKeyer.Sound();
begin
   {$IFDEF USESIDETONE}
   FTone.Play;
   {$ENDIF}
end;

procedure TdmZLogKeyer.NoSound();
begin
   {$IFDEF USESIDETONE}
   FTone.Stop;
   {$ENDIF}
end;

procedure TdmZLogKeyer.ControlPTT(PTTON: Boolean);
begin
   FPTTFLAG := PTTON;

   if FKeyingPort = tkpUSB then begin
      if PTTON then begin
         FUsbPortData := FUsbPortData and $FD;
      end
      else begin
         FUsbPortData := FUsbPortData or $02;
      end;

      Exit;
   end;

   if FKeyingPort in [tkpSerial1..tkpSerial20] then begin
      if FKeyingSignalReverse = False then begin
         ZComKeying.ToggleRTS(PTTON);
      end
      else begin
         ZComKeying.ToggleDTR(PTTON);
      end;
      Exit;
   end;
end;

procedure TdmZLogKeyer.SetPTT(_on: Boolean);
begin
   FPTTEnabled := _on;
end;

function TdmZLogKeyer.PTTIsOn: Boolean;
begin
   Result := FPTTFLAG;
end;

procedure TdmZLogKeyer.SetPTTDelay(before, after: word);
var
   i: Integer;
begin
   if FTimerMicroSec = 0 then
      Exit;

   if before = 0 then
      i := 1
   else
      i := before;

   FPttDelayBeforeCount := Trunc(i * 1000 / FTimerMicroSec);

   if after = 0 then
      i := 1
   else
      i := after;

   FPttDelayAfterCount := Trunc(i * 1000 / FTimerMicroSec);
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
   SS := DecodeCommands(S);
   if FPTTEnabled then
      SS := '(' + SS + ')';

   FCQLoopCount := 1;
   SendStr(SS + '@');
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
            ZComKeying.ToggleDTR(True);
         end
         else begin
            ZComKeying.ToggleRTS(True);
         end;
      end;

      tkpUSB: begin
         FUsbPortData := FPrevUsbPortData and $FE;
      end;
   end;
end;

procedure TdmZLogKeyer.CW_OFF;
begin
   case FKeyingPort of
      tkpSerial1..tkpSerial20: begin
         if FKeyingSignalReverse = False then begin
            ZComKeying.ToggleDTR(False);
         end
         else begin
            ZComKeying.ToggleRTS(False);
         end;
      end;

      tkpUSB: begin
         FUsbPortData := FPrevUsbPortData or $01;
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
      FPaddleWaiting := True;
      FCWSendBuf[FSelectedBuf, 1] := $FF;

      if FKeyingPort <> tkpUSB then begin
         CW_OFF;
      end;

      NoSound;
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
         NoSound;
         FKeyingCounter := FBlank1Count;
      end;

      2: begin { normal space x space factor (%) }
         CW_OFF;
         NoSound;
         FKeyingCounter := Trunc(FBlank3Count * FSpaceFactor / 100);
      end;

      $E: begin { normal space x space factor x eispacefactor(%) }
         CW_OFF;
         NoSound;
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

      $A2: begin
         if FPttHoldCounter <= 0 then begin
            Finish();
            ControlPTT(False);
         end
         else begin
            Dec(FPttHoldCounter);
            Exit;
         end;
      end;

      $AA: begin { paddle waiting routine. if p_char_count expires, }
         FPaddleWaiting := True;
         if FEndOfWordCounter = 0 then begin

            if FPTTEnabled then begin
               FPttHoldCounter := FPttDelayAfterCount;
               FCWSendBuf[FSelectedBuf, cwstrptr] := $A2;
               Exit;
            end;

            cwstrptr := 1;
            mousetail := 1;
            FPaddleWaiting := True;
            FCWSendBuf[FSelectedBuf, 1] := $FF;
         end
         else begin
            Dec(FEndOfWordCounter);
         end;

         Exit;
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
   if (wpm <= MAXWPM) and (wpm >= MINWPM) then begin
      if wpm * FTimerMicroSec = 0 then begin
         Exit;
      end;

      FDotCount := Trunc((2 * FKeyerWeight / 100) * (1200000 / (wpm * FTimerMicroSec)));
      FBlank1Count := Trunc((2 * (1 - FKeyerWeight / 100)) * (1200000 / (wpm * FTimerMicroSec)));
      FDashCount := FDotCount * 3;
      FBlank3Count := FBlank1Count * 3;

      FKeyerWPM := wpm;
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

   paddleport := $00;
   mouX := 1;
   mouY := 3;

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

   FCodeTable[Ord(')')][1] := $1F; { PTT off }
   FCodeTable[Ord(')')][2] := 9;

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

   if FPaddleThread = nil then begin
      FPaddleThread := TKeyerPaddleThread.Create(Self);
   end;
   FPaddleThread.Start();

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

   NoSound;

   CW_OFF;

   ZComKeying.Disconnect;
end;

procedure TdmZLogKeyer.PauseCW;
begin
   FSendOK := False;

   NoSound;
   CW_OFF;

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
   FPaddleWaiting := True;
   NoSound;
   FSendOK := True;
   FCQLoopCount := 0;
   CW_OFF;

   FUserFlag := False;

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
   SetCWSendBuf(Index, '(' + cqstr + ')@');
end;

procedure TdmZLogKeyer.PaddleProcessUSB;
var
   OutReport: array [0 .. 8] of byte;
   InReport: array [0 .. 8] of byte;
   BR: DWORD;
   PaddleStatus: byte;

   procedure m_set(b: word);
   begin
      if FPTTEnabled and (mousetail = 1) then begin
         ControlPTT(True);
         FCWSendBuf[0, 1] := $55; { set PTT delay }
         inc(mousetail);
      end;

      if (mousetail + 2) > (charmax * codemax) then begin
         mousetail := 1;
      end;

      FCWSendBuf[0, mousetail] := b;
      FCWSendBuf[0, mousetail + 1] := 0;
      FCWSendBuf[0, mousetail + 2] := $AA;
      inc(mousetail, 2);
      FEndOfWordCounter := (FDotCount * 3) div 2;
      FSendOK := True;
      { inLoop:=False; } // not sure what it was used for}
      FPaddleWaiting := False;
   end;
begin
   if FUSBIF4CW = nil then begin
      Exit;
   end;

   if FKeyingPort <> tkpUSB then begin
      Exit;
   end;

   if FPaddlePort = 0 then begin
      Exit;
   end;

   InReport[0] := 0;
   InReport[1] := 4;
   InReport[2] := $0F;
   InReport[3] := 4;
   InReport[4] := 0;
   InReport[5] := 0;
   InReport[6] := 0;
   InReport[7] := 0;
   InReport[8] := 0;
   FUSBIF4CW.ReadFile(InReport, FUSBIF4CW.Caps.InputReportByteLength, BR);

   if (InReport[1] = 4) and (InReport[3] = 4) and (InReport[2] <> $F) then begin
      PaddleStatus := $05 and InReport[2];
      case mousetail - cwstrptr of
         0: begin
            case PaddleStatus of
               $00: { both }
                  case FCWSendBuf[0, mousetail - 2] of
                     1:
                        m_set(3);
                     3:
                        m_set(1);
                  end;
               $01: { dot }
                  if FPaddleWaiting then
                     m_set(mouX);
               $04: { dash }
                  if FPaddleWaiting then
                     m_set(mouY);
            end;
         end;

         1: begin
            case PaddleStatus of
               $00:
                  case FCWSendBuf[0, cwstrptr - 1] of
                     1:
                        m_set(3);
                     3:
                        m_set(1);
                  end;
               $01:
                  if FCWSendBuf[0, cwstrptr - 1] = mouY then
                     m_set(mouX);
               $04:
                  if FCWSendBuf[0, cwstrptr - 1] = mouX then
                     m_set(mouY);
            end;
         end;

         else begin
            if (PaddleStatus = $01) or (PaddleStatus = $04) then begin
               if abs(mousetail - cwstrptr) > 5 then begin
                  FSelectedBuf := 0;
                  cwstrptr := 1;
                  mousetail := 1;
                  FKeyingCounter := 1;
                  FPaddleWaiting := True;
                  m_set(0);
               end;
            end;
         end;
      end;
   end;

   if FUsbPortData = FPrevUsbPortData then begin
      OutReport[0] := 0;
      OutReport[1] := 4;
      OutReport[2] := $0F;
      OutReport[3] := 4;
      OutReport[4] := 0;
      OutReport[5] := 0;
      OutReport[6] := 0;
      OutReport[7] := 0;
      OutReport[8] := 0;
   end
   else begin
      OutReport[0] := 0;
      OutReport[1] := 1;
      OutReport[2] := FUsbPortData;
      OutReport[3] := 0;
      OutReport[4] := 0;
      OutReport[5] := 0;
      OutReport[6] := 0;
      OutReport[7] := 0;
      OutReport[8] := 0;
      FPrevUsbPortData := FUsbPortData;
   end;
   FUSBIF4CW.WriteFile(OutReport, FUSBIF4CW.Caps.OutputReportByteLength, BR);
end;

procedure TdmZLogKeyer.SetReversePaddle(boo: Boolean);
begin
   if boo then begin
      mouX := 3;
      mouY := 1;
   end
   else begin
      mouX := 1;
      mouY := 3;
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

procedure TdmZLogKeyer.TuneOn;
begin
   ClrBuffer;
   FSendOK := False;
   ControlPTT(True);
   CW_ON;

   if FUseSideTone then begin
      Sound();
   end;
end;

procedure TdmZLogKeyer.SetBandMask(bandmask: Byte);
begin
   _bandmask := bandmask;
   FUsbPortData := (not(_bandmask) and $F0) or (FUsbPortData and $0F);
end;

procedure TdmZLogKeyer.SetSerialCWKeying(PortNr: Integer);
begin
   ZComKeying.Port := TPortNumber(PortNr);
   ZComKeying.Connect;
   ZComKeying.ToggleDTR(False);
   ZComKeying.ToggleRTS(False);
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

{ TKeyerPaddleThread }

constructor TKeyerPaddleThread.Create(AKeyer: TdmZLogKeyer);
begin
   inherited Create(True);
   FKeyer := AKeyer;
end;

procedure TKeyerPaddleThread.Execute;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** begin - TKeyerPaddleThread.Execute - ****'));
   {$ENDIF}
   if FKeyer.USBIF4CW_Detected = True then begin
      FWaitMS := 1;
   end
   else begin
      FWaitMS := 2;
   end;

   repeat
      Sleep(FWaitMS);

      FKeyer.PaddleProcessUSB;

   until Terminated;
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** end - TKeyerPaddleThread.Execute - ****'));
   {$ENDIF}
end;

end.
