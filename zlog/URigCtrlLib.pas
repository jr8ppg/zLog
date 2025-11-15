unit URigCtrlLib;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, AnsiStrings, System.Math, System.StrUtils,
  System.SyncObjs, Generics.Collections,
  UzLogConst, UzLogGlobal, UzLogQSO, CPDrv, OmniRig_TLB;

const
  VFOString : array[0..1] of string =
    ('VFO A', 'VFO B');

  BaudRateToSpeed: array[0..11] of TBaudRate =
    //  0       1       2       3       4       5        6        7        8        9         10        11
    ( br300, br1200, br2400, br4800, br9600, br19200, br38400, br56000, br57600, br115200, br128000, br256000 );

type
  TRigUpdateStatusEvent = procedure(Sender: TObject; rigno: Integer; currentvfo, VfoA, VfoB, Last: TFrequency; b: TBand; m: TMode) of object;
  TRigErrorEvent = procedure(Sender: TObject; msg: string) of object;

  TRig = class;

  TMemCh = class
    FFreq: TFrequency;
    FMode: TMode;
    FRig: TRig;
  public
    constructor Create(); overload;
    constructor Create(AOwner: TRig); overload;
    destructor Destroy(); override;
    procedure Call();
    procedure Write(f: TFrequency; m: TMode);
    procedure Clear();
  end;
  TMemChArray = array[1..6] of TMemCh;

  TRig = class
  protected
    FFILO : Boolean; // FILO buffer flag used for YAESU
    _minband, _maxband : TBand;
    FName : string;
    TerminatorCode : AnsiChar;
    BufferString : AnsiString;
    _currentfreq : array[0..1] of TFrequency; // in Hz
    _currentband : TBand;
    _currentmode : TMode;
    _currentvfo : integer; // 0 : VFO A; 1 : VFO B
    FPollingTimer: TTimer;
    FPollingInterval: Integer;
    FUsePolling: Boolean;
    FInitialPolling: Boolean;
    FPollingCount: Integer;
    FComm : TCommPortDriver; // points to the right CommPortDriver
    ModeWidth : array[mCW..mOther] of Integer; // used in icom
    FFreqMem : array[b19..b10g, mCW..mOther] of TFrequency;
    _freqoffset: TFrequency; // freq offset for transverters in Hz
    _rignumber : Integer;
    FRitCtrlSupported: Boolean;
    FXitCtrlSupported: Boolean;

    FRit: Boolean;
    FXit: Boolean;
    FRitOffset: Integer;
    FSMeterValue: array[0..1] of Integer;
    FSMeterMax: Integer;

    FStopRequest: Boolean;

    FPlayMessageCwSupported: Boolean;
    FPlayMessagePhSupported: Boolean;
    FControlPTTSupported: Boolean;
    FFixEdgeSelectSupported: Boolean;

    FOnUpdateStatus: TRigUpdateStatusEvent;
    FOnError: TRigErrorEvent;

    FIgnoreRigMode: Boolean;

    procedure SetRit(flag: Boolean); virtual;
    procedure SetXit(flag: Boolean); virtual;
    procedure SetRitOffset(offset: Integer); virtual;
    procedure UpdateFreqMem(vfo: Integer; Hz: TFrequency; M: TMode);
    function ConvertProsignsStr(msg: string): string;
  private
    FPortConfig: TPortConfig;

    FUseMemChScan: Boolean;
    FMemCh: TMemChArray;
    FMemScan: Boolean;
    FMemScanInterval: Integer;
    FMemScanCount: Integer;
    FMemScanNo: Integer;
    function GetCurrentFreq(Index: Integer): TFrequency;
    procedure SetCurrentFreq(Index: Integer; freq: TFrequency);
    function GetFreqMem(b: TBand; m: TMode): TFrequency;
    procedure SetFreqMem(b: TBand; m: TMode; freq: TFrequency);
    function GetSMeter(vfo: Integer): Integer;
  public
    constructor Create(RigNum : Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand); virtual;
    destructor Destroy; override;
    procedure Initialize(); virtual;
    function Selected : boolean;
    function CurrentFreqHz : TFrequency; //in Hz
    function CurrentFreqKHz : TFrequency;
    function CurrentFreqkHzStr : string;
    procedure PollingProcess(); virtual;
    procedure MemScanProcess(); virtual;
    procedure SetMode(Q: TQSO); overload; virtual;
    procedure SetMode(M: TMode); overload; virtual;
    procedure SetDataMode(fOn: Boolean); virtual;
    procedure SetBand(rigset: Integer; Q: TQSO); virtual; // abstract;
    procedure ExecuteCommand(S : AnsiString); virtual; abstract;
    procedure PassOnRxData(S : AnsiString); virtual;
    procedure ParseBufferString; virtual; abstract;
    procedure RitClear(); virtual;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); virtual;
    procedure Reset; virtual; abstract; // called when user wants to reset the rig
                                        // after power outage etc
    procedure SetVFO(i : integer); virtual; abstract; // A:0, B:1
    procedure ToggleVFO;
    procedure VFOAEqualsB; virtual;
    procedure UpdateStatus; virtual;// Renews RigControl Window and Main Window
    procedure WriteData(str : AnsiString);
    procedure InquireStatus; virtual; abstract;
    procedure MoveToLastFreq(fFreq: TFrequency; lastmode: TMode);
    procedure AntSelect(no: Integer); virtual;
    procedure FixEdgeSelect(no: Integer); virtual;
    procedure SetStopBits(i : byte);
    procedure SetBaudRate(i : integer);
    procedure StopRequest(); virtual;

    procedure SetWPM(wpm: Integer); virtual;
    procedure PlayMessageCW(msg: string); virtual;
    procedure StopMessageCW(); virtual;
    procedure ControlPTT(fOn: Boolean); virtual;

    property Name: string read FName write FName;
    property CommPortDriver: TCommPortDriver read FComm;
    property PollingTimer: TTimer read FPollingTimer write FPollingTimer;
    property FILO: Boolean read FFILO write FFILO;
    property MinBand: TBand read _minband write _minband;
    property MaxBand: TBand read _maxband write _maxband;
    property CurrentBand: TBand read _currentband write _currentband;
    property CurrentMode: TMode read _currentmode write _currentmode;
    property RigNumber: Integer read _rignumber;
    property CurrentVFO: Integer read _currentvfo write _currentvfo;
    property FreqOffset: TFrequency read _freqoffset write _freqoffset;
    property CurrentFreq[Index: Integer]: TFrequency read GetCurrentFreq write SetCurrentFreq;
    property FreqMem[b: TBand; m: TMode]: TFrequency read GetFreqMem write SetFreqMem;
    property SMeter[Index: Integer]: Integer read GetSMeter;
//    property PollingInterval: Integer read FPollingInterval write FPollingInterval;
    property IgnoreMode: Boolean read FIgnoreRigMode write FIgnoreRigMode;

    property RitCtrlSupported: Boolean read FRitCtrlSupported write FRitCtrlSupported;
    property XitCtrlSupported: Boolean read FXitCtrlSupported write FXitCtrlSupported;

    property Rit: Boolean read FRit write SetRit;
    property Xit: Boolean read FXit write SetXit;
    property RitOffset: Integer read FRitOffset write SetRitOffset;

    property PlayMessageCwSupported: Boolean read FPlayMessageCwSupported write FPlayMessageCwSupported;
    property PlayMessagePhSupported: Boolean read FPlayMessagePhSupported write FPlayMessagePhSupported;
    property ControlPTTSupported: Boolean read FControlPTTSupported write FControlPTTSupported;
    property FixEdgeSelectSupported: Boolean read FFixEdgeSelectSupported write FFixEdgeSelectSupported;

    property PortConfig: TPortConfig read FPortConfig write FPortConfig;
    property UsePolling: Boolean read FUsePolling write FUsePolling;

    property UseMemChScan: Boolean read FUseMemChScan write FUseMemChScan;
    property MemCh: TMemChArray read FMemCh;
    property MemScan: Boolean read FMemScan write FMemScan;
    property MemScanNo: Integer read FMemScanNo;

    property OnUpdateStatus: TRigUpdateStatusEvent read FOnUpdateStatus write FOnUpdateStatus;
    property OnError: TRigErrorEvent read FOnError write FOnError;
  end;

  TJST145 = class(TRig) //  or JST245
    CommOn, CommOff : AnsiString;
  public
    constructor Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand); override;
    destructor Destroy; override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure Initialize(); override;
    procedure InquireStatus; override;
    procedure ParseBufferString; override;
    procedure PollingProcess; override;
    procedure Reset; override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
    procedure SetVFO(i : integer); override;
  end;

  TOmni = class(TRig)
  private
    FOmniRig: TOmniRigX;
  public
    constructor Create(RigNum : integer; AOmniRig: TOmniRigX); reintroduce;
    destructor Destroy; override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure Initialize(); override;
    procedure InquireStatus; override;
    procedure ParseBufferString; override;
    procedure PassOnRxData(S : AnsiString); override;
    procedure Reset; override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
    procedure SetVFO(i : integer); override;
  end;

  TVirtualRig = class(TRig)
    constructor Create(RigNum: Integer); reintroduce;
    destructor Destroy; override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure Initialize(); override;
    procedure InquireStatus; override;
    procedure ParseBufferString; override;
    procedure Reset; override;
    procedure SetBand(rigset: Integer; Q: TQSO); override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
    procedure SetVFO(i : integer); override;
  end;

  TRigArray = array[1..5] of TRig;

function hex2dec(i: Integer): Integer;
function dec2hex(i: Integer): Integer;

implementation

uses
  Main;

{ TRig }

constructor TRig.Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand);
var
   B: TBand;
   M: TMode;
   prtnr: Integer;
   i: Integer;
begin
   // inherited
   for M := mCW to mOther do begin
      ModeWidth[M] := -1;
   end;

   FFILO := False; // used for YAESU
   _freqoffset := 0;
   _minband := MinBand;
   _maxband := MaxBand;
   Name := '';

   _rignumber := RigNum;

   FComm := AComm;
   FPollingTimer := ATimer;
   FUsePolling := True;
   FInitialPolling := False;
   FPollingCount := 0;
   prtnr := APort;

   FSMeterValue[0] := 0;
   FSMeterValue[1] := 0;
   FSMeterMax := 0;

//   if _rignumber = 1 then begin
//      prtnr := dmZlogGlobal.Settings.FRigControl[1].FControlPort;
//      FComm := MainForm.RigControl.ZCom1;
//      FPollingTimer := MainForm.RigControl.PollingTimer1;
//   end
//   else begin
//      prtnr := dmZlogGlobal.Settings.FRigControl[2].FControlPort;
//      FComm := MainForm.RigControl.ZCom2;
//      FPollingTimer := MainForm.RigControl.PollingTimer2;
//   end;

   // 9600bps以下は200msec, 19200bps以上は100msec
   if dmZlogGlobal.Settings.FRigControl[RigNum].FSpeed <= 4 then begin
      FPollingInterval := Min(dmZLogGlobal.Settings._polling_interval, 150);   // milisec
   end
   else begin
      FPollingInterval := Min(dmZLogGlobal.Settings._polling_interval, 75);    // milisec
   end;

   FComm.Disconnect;
   FComm.Port := TPortNumber(prtnr);
   FComm.BaudRate := BaudRateToSpeed[ dmZlogGlobal.Settings.FRigControl[RigNum].FSpeed ];
   FComm.HwFlow := hfNONE;
   FComm.SwFlow := sfNONE;
   FComm.EnableDTROnOpen := False;

   TerminatorCode := ';';
   BufferString := '';

   _currentmode := Main.CurrentQSO.Mode; // mCW;

   _currentband := b19;
   B := Main.CurrentQSO.Band;
   if (B >= _minband) and (B <= _maxband) then begin
      _currentband := B;
   end;

   _currentfreq[0] := 0;
   _currentfreq[1] := 0;
   _currentvfo := 0; // VFO A
   FIgnoreRigMode := False;

   // LastMode := mCW;
   for B := b19 to b10g do begin
      for M := mCW to mOther do begin
         FreqMem[B, M] := 0;
      end;
   end;

   FRitCtrlSupported := True;
   FXitCtrlSupported := True;

   FRit := False;
   FXit := False;
   FRitOffset := 0;

   FOnUpdateStatus := nil;
   FOnError := nil;

   FStopRequest := False;

   FPlayMessageCwSupported := False;
   FPlayMessagePhSupported := False;
   FControlPTTSupported := False;
   FFixEdgeSelectSupported := False;

   FPortConfig.FRts := paNone;
   FPortConfig.FDtr := paNone;

   FUseMemChScan := True;
   for i := Low(FMemCh) to High(FMemCh) do begin
      FMemCh[i] := TMemCh.Create(Self);
   end;
   FMemScan := False;
   FMemScanInterval := dmZLogGlobal.Settings._memscan_interval * 1000;
   FMemScanCount := 0;
   FMemScanNo := 1;
end;

destructor TRig.Destroy;
var
   i: Integer;
begin
   inherited;
   if Assigned(FPollingTimer) then begin
      FPollingTimer.Enabled := False;
   end;
   if Assigned(FComm) then begin
      FComm.Disconnect();
   end;

   for i := Low(FMemCh) to High(FMemCh) do begin
      FMemCh[i].Free();
   end;
end;

procedure TRig.Initialize();
begin
   FPollingTimer.Interval := FPollingInterval;
   FComm.Connect();

   case FPortConfig.FRts of
      paAlwaysOn: begin
         FComm.HwFlow := hfNone;
         FComm.ToggleRTS(True);
      end;

      paAlwaysOff: begin
         FComm.HwFlow := hfNone;
         FComm.ToggleRTS(False);
      end;

      paHandshake: begin
         FComm.HwFlow := hfRtsCts;
         FComm.ToggleRTS(True);
      end

      else begin
         FComm.HwFlow := hfNone;
         FComm.ToggleRTS(True);
      end;
   end;

   case FPortConfig.FDtr of
      paAlwaysOn: begin
         FComm.ToggleDTR(True);
      end;

      paNone, paAlwaysOff: begin
         FComm.ToggleDTR(False);
      end;

      else begin
         FComm.ToggleDTR(True);
      end;
   end;

   FStopRequest := False;
end;

procedure TRig.VFOAEqualsB;
begin
end;

procedure TRig.UpdateStatus;
begin
   if Assigned(FOnUpdateStatus) then begin
      FOnUpdateStatus(Self, _rignumber,
                      _currentvfo,
                      _freqoffset + _currentfreq[0],
                      _freqoffset + _currentfreq[1],
                      _freqoffset + _currentfreq[_currentvfo],
                      _currentband,
                      _currentmode);
   end;
end;

function TRig.CurrentFreqHz(): TFrequency;
begin
   Result := _currentfreq[_currentvfo] + _freqoffset;
end;

function TRig.CurrentFreqKHz(): TFrequency;
begin
   Result := (_currentfreq[_currentvfo] + _freqoffset) div 1000;
end;

function TRig.CurrentFreqkHzStr(): string;
begin
   Result := UzLogGlobal.kHzStr(CurrentFreqHz);
end;

procedure TRig.PassOnRxData(S: AnsiString);
begin
   BufferString := BufferString + S;
   ParseBufferString;
end;

procedure TRig.ToggleVFO;
begin
   if _currentvfo = 0 then
      SetVFO(1)
   else
      SetVFO(0);
end;

procedure TRig.WriteData(str: AnsiString);
begin
   // repeat until Comm.OutQueCount = 0;
   if FComm = nil then begin
      Exit;
   end;

   if FComm.Connected then begin
      FComm.SendString(str);
   end;
end;

procedure TRig.PollingProcess();
begin
end;

procedure TRig.MemScanProcess();
var
   msec: Integer;
begin
   if (FMemCh[1].FFreq = 0) and
      (FMemCh[2].FFreq = 0) and
      (FMemCh[3].FFreq = 0) and
      (FMemCh[4].FFreq = 0) and
      (FMemCh[5].FFreq = 0) and
      (FMemCh[6].FFreq = 0) then begin
      Exit;
   end;

   // 経過時間
   msec := FMemScanCount * FPollingInterval;

   // スキャン間隔経過か？
   if (msec > FMemScanInterval) then begin
      // 次のMemCh番号
      repeat
         Inc(FMemScanNo);
         if FMemScanNo > High(FMemCh) then begin
            FMemScanNo := 1;
         end;
      until FMemCh[FMemScanNo].FFreq > 0;

      // 次のMemChに移る
      FMemCh[FMemScanNo].Call();

      // カウントは０から
      FMemScanCount := 0;
   end
   else begin
      Inc(FMemScanCount);
   end;
end;

procedure TRig.SetStopBits(i: byte);
begin
   case i of
      1:
         FComm.StopBits := sb1BITS;
      2:
         FComm.StopBits := sb2BITS;
   end;
end;

procedure TRig.SetRit(flag: Boolean);
begin
   FRit := flag;
end;

procedure TRig.SetRitOffset(offset: Integer);
begin
   FRitOffset := offset;
end;

procedure TRig.SetXit(flag: Boolean);
begin
   FXit := flag;
end;

procedure TRig.UpdateFreqMem(vfo: Integer; Hz: TFrequency; M: TMode);
var
   b: TBand;
begin
   b := dmZLogGlobal.BandPlan.FreqToBand(Hz);
   if b <> bUnknown then begin
      _currentband := b;
   end;
   FreqMem[_currentband, M] := _currentfreq[vfo];
end;

procedure TRig.SetBaudRate(i: Integer);
begin
   case i of
      300:     FComm.BaudRate := br300;
      1200:    FComm.BaudRate := br1200;
      2400:    FComm.BaudRate := br2400;
      4800:    FComm.BaudRate := br4800;
      9600:    FComm.BaudRate := br9600;
      19200:   FComm.BaudRate := br19200;
      38400:   FComm.BaudRate := br38400;
   end;
end;

procedure TRig.StopRequest();
begin
   FStopRequest := True;
end;

procedure TRig.SetWPM(wpm: Integer);
begin
//
end;

procedure TRig.PlayMessageCW(msg: string);
begin
//
end;

procedure TRig.StopMessageCW();
begin
//
end;

procedure TRig.ControlPTT(fOn: Boolean);
begin
//
end;

function TRig.Selected: Boolean;
begin
   if _rignumber = MainForm.RigControl.CurrentRigNumber then
      Result := True
   else
      Result := False;
end;

procedure TRig.MoveToLastFreq(fFreq: TFrequency; lastmode: TMode);
begin
   SetFreq(fFreq, False);

   if lastmode <> _currentmode then begin
      SetMode(lastmode);

      // もう一度周波数を設定(side bandずれ対策)
      if dmZLogGlobal.Settings._bandscope_setfreq_after_mode_change = True then begin
         SetFreq(fFreq, False);
      end;
   end;
end;

procedure TRig.AntSelect(no: Integer);
begin
   //
end;

procedure TRig.FixEdgeSelect(no: Integer);
begin
   //
end;

procedure TRig.SetMode(Q: TQSO);
begin
   _currentmode := Q.Mode;
end;

procedure TRig.SetMode(M: TMode);
var
   Q: TQSO;
begin
   Q := TQSO.Create();
   try
      Q.Mode := M;
      Q.Band := dmZLogGlobal.BandPlan.FreqToBand(_currentfreq[_currentvfo]);
      SetMode(Q);
   finally
      Q.Free();
   end;
end;

procedure TRig.SetDataMode(fOn: Boolean);
begin
//
end;

procedure TRig.SetBand(rigset: Integer; Q: TQSO);
var
   f: TFrequency;
begin
   if (Q.Band < _minband) or (Q.Band > _maxband) then begin
      Exit;
   end;

   // 周波数を記憶している場合
   if FreqMem[Q.Band, Q.Mode] > 0 then begin
      f := FreqMem[Q.Band, Q.Mode];
   end
   else begin
      // 周波数を記憶していない場合はバンドプランの下限値を使う
      f := dmZLogGlobal.BandPlan.Limit[Q.Mode][Q.Band].Lower;
      if f = 0 then begin
         f := dmZLogGlobal.BandPlan.Limit[mCW][Q.Band].Lower;
      end;
   end;

   if f = 0 then begin
      Exit;
   end;

   _currentband := Q.Band;

   SetFreq(f, Q.CQ);

   // Antenna Select
   AntSelect(dmZLogGlobal.Settings.FRigSet[rigset].FAnt[Q.Band]);
end;

procedure TRig.RitClear();
begin
   FRitOffset := 0;
end;

procedure TRig.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
begin
   if fSetLastFreq = True then begin
   end;
end;

function TRig.GetCurrentFreq(Index: Integer): TFrequency;
begin
   Result := _currentFreq[Index];
end;

procedure TRig.SetCurrentFreq(Index: Integer; freq: TFrequency);
begin
   _currentFreq[Index] := freq;
end;

function TRig.GetFreqMem(b: TBand; m: TMode): TFrequency;
begin
   Result := FFreqMem[b, m];
end;

procedure TRig.SetFreqMem(b: TBand; m: TMode; freq: TFrequency);
begin
   FFreqMem[b, m] := freq;
end;

function TRig.ConvertProsignsStr(msg: string): string;
begin
   msg := StringReplace(msg, '[AR]', 'a', [rfReplaceAll]);
   msg := StringReplace(msg, '[SK]', 's', [rfReplaceAll]);
   msg := StringReplace(msg, '[VA]', 's', [rfReplaceAll]);
   msg := StringReplace(msg, '[KN]', 'k', [rfReplaceAll]);
   msg := StringReplace(msg, '[BK]', 'b', [rfReplaceAll]);
   msg := StringReplace(msg, '[BT]', 't', [rfReplaceAll]);
   Result := msg;
end;

function TRig.GetSMeter(vfo: Integer): Integer;
begin
   Result := FSMeterValue[vfo];
end;

{ TJST145 }

constructor TJST145.Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand);
begin
   inherited;
   CommOn := 'H1' + _CR;
   CommOff := 'H0' + _CR;
   FComm.StopBits := sb1BITS;
   TerminatorCode := _CR;
end;

destructor TJST145.Destroy;
begin
   WriteData(CommOff);
   inherited;
end;

procedure TJST145.ExecuteCommand(S: AnsiString);
var
   Command: AnsiString;
   strTemp: string;
   i: TFrequency;
   aa: Integer;
   // B : TBand;
   M: TMode;
   ss: AnsiString;
begin
   // RigControl.label1.caption := S;
   if length(S) < 10 then
      Exit;
   Command := S[1] + S[2];
   if S[1] = 'I' then
      Command := 'I';
   if (Command = 'LA') or (Command = 'LB') or (Command = 'I') then begin
      ss := S;
      Delete(ss, 1, length(Command));
      if Command = 'LA' then
         aa := 0
      else
         aa := 1;
      if Command = 'I' then
         aa := _currentvfo;

      strTemp := string(copy(ss, 4, 8));
      i := StrToIntDef(strTemp, 0);
      _currentfreq[aa] := i;
      i := i + _freqoffset;

      if _currentvfo = aa then begin
         case ss[3] of
            '2', '3':
               M := mSSB;
            '1':
               M := mCW;
            '5':
               M := mFM;
            '4':
               M := mAM;
            '0':
               M := mRTTY;
            else
               M := mOther;
         end;

         if FIgnoreRigMode = False then begin
            _currentmode := M;
         end;

         UpdateFreqMem(aa, i, M);
      end;

      if Selected then
         UpdateStatus;
   end;
end;

procedure TJST145.Initialize();
begin
   Inherited;
   WriteData('I1' + _CR + 'L' + _CR);
end;

procedure TJST145.InquireStatus;
begin
//
end;

procedure TJST145.ParseBufferString; // cloned from TS690
var
   i: Integer;
   temp: AnsiString;
begin
   i := pos(TerminatorCode, BufferString);
   while i > 0 do begin
      temp := copy(BufferString, 1, i);
      Delete(BufferString, 1, i);
      ExecuteCommand(temp);
      i := pos(TerminatorCode, BufferString);
   end;
end;

procedure TJST145.PollingProcess;
begin
end;

procedure TJST145.Reset;
begin
   BufferString := '';
   WriteData('I1' + _CR + 'L' + _CR);
end;

procedure TJST145.RitClear();
begin
   Inherited;
end;

procedure TJST145.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   fstr: AnsiString;
begin
   Hz := Hz - _freqoffset;
   Inherited SetFreq(Hz, fSetLastFreq);

   fstr := AnsiString(IntToStr(Hz));
   while length(fstr) < 8 do begin
      fstr := '0' + fstr;
   end;

   if _currentvfo = 0 then
      WriteData(CommOn + 'F' + fstr + 'A' + AnsiChar(_CR) + CommOff)
   else
      WriteData(CommOn + 'F' + fstr + 'B' + AnsiChar(_CR) + CommOff);
   WriteData('I1' + _CR);
end;

procedure TJST145.SetMode(Q: TQSO);
var
   para: AnsiString;
begin
   Inherited SetMode(Q);

   para := '';
   case Q.Mode of
      mSSB:
         if Q.Band <= b7 then
            para := 'D3'
         else
            para := 'D2';
      mCW:
         para := 'D1';
      mFM:
         para := 'D5';
      mAM:
         para := 'D4';
      mRTTY:
         para := 'D9';
      else begin
            Exit;
         end;
   end;

   WriteData(CommOn + para + AnsiChar(_CR) + CommOff);
   WriteData('I1' + AnsiChar(_CR));
end;

procedure TJST145.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      WriteData(CommOn + 'FA' + _CR + CommOff)
   else
      WriteData(CommOn + 'FB' + _CR + CommOff);

   WriteData('I1' + _CR);

   if Selected then begin
      UpdateStatus;
   end;
end;

{ TOmni }

constructor TOmni.Create(RigNum: Integer; AOmniRig: TOmniRigX);
var
   M: TMode;
   B: TBand;
begin
   FOmniRig := AOmniRig;
   for M := mCW to mOther do begin
      ModeWidth[M] := -1;
   end;

   FFILO := False; // used for YAESU
   _freqoffset := 0;
   _minband := b19;
   _maxband := b10g;
   Name := '';
   _rignumber := RigNum;
   TerminatorCode := ';';
   BufferString := '';

   _currentmode := Main.CurrentQSO.Mode; // mCW;

   _currentband := b19;
   B := Main.CurrentQSO.Band;
   if (B >= _minband) and (B <= _maxband) then
      _currentband := B;

   _currentfreq[0] := 0;
   _currentfreq[1] := 0;
   _currentvfo := 0; // VFO A

   for B := b19 to b10g do begin
      for M := mCW to mOther do begin
         FreqMem[B, M] := 0;
      end;
   end;

   FUseMemChScan := False;
end;

procedure TOmni.ExecuteCommand(S: AnsiString);
begin
//
end;

procedure TOmni.Initialize();
begin
//
end;

procedure TOmni.InquireStatus;
var
   o_RIG: IRigX;
begin
   if _rignumber = 1 then begin
      o_RIG := FOmniRig.Rig1;
   end
   else begin
      o_RIG := FOmniRig.Rig2;
   end;

   case o_RIG.Vfo of
      PM_VFOA, PM_VFOAA: _currentfreq[0] := o_RIG.FreqA;
      PM_VFOB, PM_VFOAB: _currentfreq[1] := o_RIG.FreqB;
      else     _currentfreq[0] := o_RIG.Freq;
   end;

   UpdateStatus;
end;

procedure TOmni.ParseBufferString;
begin
end;

procedure TOmni.RitClear;
begin
   Inherited;
   if _rignumber = 1 then begin
      FOmniRig.Rig1.ClearRit;
   end
   else if _rignumber = 2 then begin
      FOmniRig.Rig2.ClearRit;
   end;
end;

procedure TOmni.PassOnRxData(S: AnsiString);
begin
//
end;

procedure TOmni.Reset;
begin
end;

destructor TOmni.Destroy;
begin
   inherited;
end;

procedure TOmni.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   o_RIG: IRigX;
begin
   Hz := Hz - _freqoffset;

   if _rignumber = 1 then begin
      o_RIG := FOmniRig.Rig1;
   end
   else begin
      o_RIG := FOmniRig.Rig2;
   end;

   Inherited SetFreq(Hz, fSetLastFreq);

   o_RIG.SetSimplexMode(Hz);
   _currentfreq[0] := Hz;

   UpdateStatus();
end;

procedure TOmni.SetMode(Q: TQSO);
var
   o_RIG: IRigX;
begin
   Inherited SetMode(Q);

   if _rignumber = 1 then begin
      o_RIG := FOmniRig.Rig1;
   end
   else begin
      o_RIG := FOmniRig.Rig2;
   end;

   case Q.Mode of
      mSSB:
         if Q.Band <= b7 then
            o_RIG.Mode := PM_SSB_L
         else
            o_RIG.Mode := PM_SSB_U;
      mCW:
         o_RIG.Mode := PM_CW_U;
      mFM:
         o_RIG.Mode := PM_FM;
      mAM:
         o_RIG.Mode := PM_AM;
      mRTTY:
         o_RIG.Mode := PM_DIG_L;
   end;
end;

procedure TOmni.SetVFO(i: Integer);
var
   o_RIG: IRigX;
begin
   if _rignumber = 1 then begin
      o_RIG := FOmniRig.Rig1;
   end
   else begin
      o_RIG := FOmniRig.Rig2;
   end;

   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;

   if i = 0 then
      o_RIG.Vfo := PM_VFOA
   else
      o_RIG.Vfo := PM_VFOB;

   if Selected then
      UpdateStatus;
end;

{ TVirtualRig }

constructor TVirtualRig.Create(RigNum: Integer);
var
   M: TMode;
   B: TBand;
begin
   for M := mCW to mOther do begin
      ModeWidth[M] := -1;
   end;

   FFILO := False; // used for YAESU
   _freqoffset := 0;
   _minband := b19;
   _maxband := b10g;
   Name := '';
   _rignumber := RigNum;
   TerminatorCode := ';';
   BufferString := '';

   _currentmode := Main.CurrentQSO.Mode; // mCW;

   _currentband := b19;
   B := Main.CurrentQSO.Band;
   if (B >= _minband) and (B <= _maxband) then
      _currentband := B;

   _currentfreq[0] := 0;
   _currentfreq[1] := 0;
   _currentvfo := 0; // VFO A

   for B := b19 to b10g do begin
      for M := mCW to mOther do begin
         FreqMem[B, M] := 0;
      end;
   end;

   Self.name := 'VirtualRig';

   FUseMemChScan := False;
end;

destructor TVirtualRig.Destroy;
begin
   inherited;
end;

procedure TVirtualRig.ExecuteCommand(S: AnsiString);
begin
   Inherited;
end;

procedure TVirtualRig.Initialize();
begin
//
end;

procedure TVirtualRig.InquireStatus;
begin
   Inherited;
end;

procedure TVirtualRig.ParseBufferString;
begin
   Inherited;
end;

procedure TVirtualRig.Reset;
begin
   Inherited;
end;

procedure TVirtualRig.SetBand(rigset: Integer; Q: TQSO);
begin
   _currentband := Q.Band;
end;

procedure TVirtualRig.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   b: TBand;
begin
   b := dmZLogGlobal.BandPlan.FreqToBand(Hz);
   _currentband := b;
end;

procedure TVirtualRig.SetMode(Q: TQSO);
begin
   Inherited SetMode(Q);

   _currentmode := Q.Mode;
end;

procedure TVirtualRig.SetVFO(i : integer);
begin
   Inherited;
end;

{ TMemCh }

constructor TMemCh.Create();
begin
   FFreq := 0;
   FMode := mCW;
   FRig := nil;
end;

constructor TMemCh.Create(AOwner: TRig);
begin
   Inherited Create();
   FRig := AOwner;
end;

destructor TMemCh.Destroy();
begin
//
end;

procedure TMemCh.Call();
var
   f: TFrequency;
   m: TMode;
begin
   f := FFreq;
   m := FMode;
   if f > 0 then begin
      FRig.SetFreq(f, False);
      FRig.SetMode(m);
   end;
end;

procedure TMemCh.Write(f: TFrequency; m: TMode);
begin
   FFreq := f;
   FMode := m;
end;

procedure TMemCh.Clear();
begin
   FFreq := 0;
   FMode := mCW;
end;

function hex2dec(i: Integer): Integer;
begin
   Result := (i div 16) * 10 + (i mod 16);
end;

function dec2hex(i: Integer): Integer;
begin
   if i < 10 then
      Result := i
   else begin
      Result := 16 * (i div 10) + (i mod 10);
   end;
end;

{
function HexStr(S: string): string;
var
   i, j, k: Integer;
   ss: string;
   B: byte;
const
   _HEX: array [0 .. 15] of char = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
begin
   ss := '';
   for i := 1 to length(S) do begin
      B := Ord(S[i]);
      j := B div 16;
      k := B mod 16;
      if (j < 16) and (k < 16) then
         ss := ss + '&' + _HEX[j] + _HEX[k]
      else
         ss := ss + '&xx';
   end;
   Result := ss;
end;
}

{
function HexText(binstr: string): string;
var
   i, hex: Integer;
var
   x: string;
const
   hexarray = '0123456789ABCDEF';
begin
   x := '';
   for i := 1 to length(binstr) do begin
      hex := Ord(binstr[i]);
      x := x + '&' + hexarray[hex div 16 + 1] + hexarray[hex mod 16 + 1];
   end;
   Result := x;
end;
}

end.
