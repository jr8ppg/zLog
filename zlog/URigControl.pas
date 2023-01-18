unit URigControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, AnsiStrings, Vcl.Grids, System.Math, System.StrUtils,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogKeyer, CPDrv, OmniRig_TLB, Vcl.Buttons;

type
  TIcomInfo = record
    name : string;
    addr : byte;
    minband, maxband : TBand;
    RitCtrl: Boolean;
    XitCtrl: Boolean;
  end;

const
  MAXVIRTUALRIG = 10;
  _nil : AnsiChar = AnsiChar($00);
  _nil2: AnsiString = AnsiChar($00) + AnsiChar($00);
  _nil3: AnsiString = AnsiChar($00) + AnsiChar($00) + AnsiChar($00);
  _nil4: AnsiString = AnsiChar($00) + AnsiChar($00) + AnsiChar($00) + AnsiChar($00);

  MAXICOM = 51;

  ICOMLIST : array[1..MAXICOM] of TIcomInfo =
     (
       (name: 'IC-703';       addr: $68; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-705';       addr: $A4; minband: b19; maxband: b430;   RitCtrl: True;  XitCtrl: True),
       (name: 'IC-706';       addr: $48; minband: b19; maxband: b144;   RitCtrl: False; XitCtrl: False),
       (name: 'IC-706MkII';   addr: $4E; minband: b19; maxband: b144;   RitCtrl: False; XitCtrl: False),
       (name: 'IC-706MkII-G'; addr: $58; minband: b19; maxband: b430;   RitCtrl: False; XitCtrl: False),
       (name: 'IC-707';       addr: $3E; minband: b19; maxband: b28;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-718';       addr: $5E; minband: b19; maxband: b28;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-721(IC-725)'; addr: $28; minband: b19; maxband: b28;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-726';       addr: $30; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-728';       addr: $38; minband: b19; maxband: b28;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-729';       addr: $3A; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-731(IC-735)'; addr: $04; minband: b19; maxband: b28;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-732(IC-737)'; addr: $04; minband: b19; maxband: b28;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-736';       addr: $40; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-738';       addr: $44; minband: b19; maxband: b28;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-746';       addr: $56; minband: b19; maxband: b144;   RitCtrl: False; XitCtrl: False),
       (name: 'IC-746PRO(IC-7400)'; addr: $66; minband: b19; maxband: b144; RitCtrl: False; XitCtrl: False),
       (name: 'IC-7000';      addr: $70; minband: b19; maxband: b430;   RitCtrl: False; XitCtrl: False),
       (name: 'IC-7100';      addr: $88; minband: b19; maxband: b430;   RitCtrl: True;  XitCtrl: False),
       (name: 'IC-7200';      addr: $76; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-7300';      addr: $94; minband: b19; maxband: b50;    RitCtrl: True;  XitCtrl: True),
       (name: 'IC-7400';      addr: $66; minband: b19; maxband: b144;   RitCtrl: False; XitCtrl: False),
       (name: 'IC-7410';      addr: $80; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-750/750A(IC-751)'; addr: $1C; minband: b19; maxband: b28; RitCtrl: False; XitCtrl: False),
       (name: 'IC-756';       addr: $50; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-756PRO';    addr: $5C; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-756PROII';  addr: $64; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-756PRO3';   addr: $6E; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-7600';      addr: $7A; minband: b19; maxband: b50;    RitCtrl: True;  XitCtrl: True),
       (name: 'IC-7610';      addr: $98; minband: b19; maxband: b50;    RitCtrl: True;  XitCtrl: True),
       (name: 'IC-7700';      addr: $74; minband: b19; maxband: b50;    RitCtrl: True;  XitCtrl: True),
       (name: 'IC-78';        addr: $62; minband: b19; maxband: b28;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-7800';      addr: $6A; minband: b19; maxband: b50;    RitCtrl: True;  XitCtrl: True),
       (name: 'IC-7851';      addr: $8E; minband: b19; maxband: b50;    RitCtrl: True;  XitCtrl: True),
       (name: 'IC-760(IC-761)'; addr: $1E; minband: b19; maxband: b28;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-760PRO(IC-765)'; addr: $2C; minband: b19; maxband: b28; RitCtrl: False; XitCtrl: False),
       (name: 'IC-775';       addr: $46; minband: b19; maxband: b28;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-780(IC-781)'; addr: $26; minband: b19; maxband: b28;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-575';       addr: $16; minband: b28; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-820';       addr: $42; minband: b144; maxband: b430;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-821';       addr: $4C; minband: b144; maxband: b430;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-910/911';   addr: $60; minband: b144; maxband: b1200; RitCtrl: False; XitCtrl: False),
       (name: 'IC-970';       addr: $2E; minband: b144; maxband: b1200; RitCtrl: False; XitCtrl: False),
       (name: 'IC-271';       addr: $20; minband: b144; maxband: b144;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-275';       addr: $10; minband: b144; maxband: b144;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-371(IC-471)'; addr: $22; minband: b430; maxband: b430; RitCtrl: False; XitCtrl: False),
       (name: 'IC-375(IC-475)'; addr: $14; minband: b430; maxband: b430; RitCtrl: False; XitCtrl: False),
       (name: 'IC-9100';      addr: $7C; minband: b19; maxband: b1200;   RitCtrl: False; XitCtrl: False),
       (name: 'IC-9700';      addr: $A2; minband: b144; maxband: b1200;  RitCtrl: True;  XitCtrl: False),
       (name: 'IC-1271';      addr: $24; minband: b1200; maxband: b1200; RitCtrl: False; XitCtrl: False),
       (name: 'IC-1275';      addr: $18; minband: b1200; maxband: b1200; RitCtrl: False; XitCtrl: False)
     );

  VFOString : array[0..1] of string =
    ('VFO A', 'VFO B');

  BaudRateToSpeed: array[0..11] of TBaudRate =
    //  0       1       2       3       4       5        6        7        8        9         10        11
    ( br300, br1200, br2400, br4800, br9600, br19200, br38400, br56000, br57600, br115200, br128000, br256000 );

type
  TRig = class
  private
    FFILO : Boolean; // FILO buffer flag used for YAESU
    Name : string;
    _freqoffset: TFrequency; // freq offset for transverters in Hz
    _minband, _maxband : TBand;
    _rignumber : Integer;

    FreqMem : array[b19..b10g, mCW..mOther] of TFrequency;

    TerminatorCode : AnsiChar;
    BufferString : AnsiString;
    _currentfreq : array[0..1] of TFrequency; // in Hz
    _currentband : TBand;
    _currentmode : TMode;
    _currentvfo : integer; // 0 : VFO A; 1 : VFO B
    FComm : TCommPortDriver; // points to the right CommPortDriver
    FPollingTimer: TTimer;
    FPollingInterval: Integer;

    FLastFreq: TFrequency;
    FLastMode: TMode;

    FRitCtrlSupported: Boolean;
    FXitCtrlSupported: Boolean;

    FRit: Boolean;
    FXit: Boolean;
    FRitOffset: Integer;

    ModeWidth : array[mCW..mOther] of Integer; // used in icom

    FLastCall: string;
    FLastRcvd: string;

    FStopRequest: Boolean;

    procedure SetRit(flag: Boolean); virtual;
    procedure SetXit(flag: Boolean); virtual;
    procedure SetRitOffset(offset: Integer); virtual;
    procedure UpdateFreqMem(vfo: Integer; Hz: Integer);
  public
    constructor Create(RigNum : Integer); virtual;
    destructor Destroy; override;
    procedure Initialize(); virtual;
    function Selected : boolean;
    function CurrentFreqHz : TFrequency; //in Hz
    function CurrentFreqKHz : TFrequency;
    function CurrentFreqkHzStr : string;
    procedure PollingProcess; virtual;
    procedure SetMode(Q: TQSO); overload; virtual;
    procedure SetMode(M: TMode); overload; virtual;
    procedure SetBand(Q: TQSO); virtual; // abstract;
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
    procedure MoveToLastFreq; virtual;
    procedure AntSelect(no: Integer); virtual;
    procedure SetStopBits(i : byte);
    procedure SetBaudRate(i : integer);
    procedure StopRequest(); virtual;

    property CommPortDriver: TCommPortDriver read FComm;
    property PollingTimer: TTimer read FPollingTimer write FPollingTimer;
    property FILO: Boolean read FFILO write FFILO;
    property MinBand: TBand read _minband write _minband;
    property MaxBand: TBand read _maxband write _maxband;
    property CurrentBand: TBand read _currentband;
    property CurrentMode: TMode read _currentmode;
//    property PollingInterval: Integer read FPollingInterval write FPollingInterval;

    property RitCtrlSupported: Boolean read FRitCtrlSupported write FRitCtrlSupported;
    property XitCtrlSupported: Boolean read FXitCtrlSupported write FXitCtrlSupported;

    property Rit: Boolean read FRit write SetRit;
    property Xit: Boolean read FXit write SetXit;
    property RitOffset: Integer read FRitOffset write SetRitOffset;
  end;

  TTS690 = class(TRig) // TS-450 as well
  private
    FFineStep: Boolean;
    procedure SetRit(flag: Boolean); override;
    procedure SetXit(flag: Boolean); override;
    procedure SetRitOffset(offset: Integer); override;
  public
    _CWR : boolean; // CW-R flag
    constructor Create(RigNum : integer); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    procedure SetMode(Q : TQSO); override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure ParseBufferString; override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure Reset; override;
    procedure SetVFO(i : integer); override;
    procedure InquireStatus; override;
    procedure AntSelect(no: Integer); override;
  end;

  TTS2000 = class(TTS690)
  private
    procedure SetRitOffset(offset: Integer); override;
  public
    constructor Create(RigNum : integer); override;
    procedure Initialize(); override;
  end;

  TTS2000P = class(TTS2000)
    constructor Create(RigNum : integer); override;
    procedure PollingProcess; override;
    destructor Destroy; override;
    procedure Initialize(); override;
  end;

  TTS570 = class(TTS690)
    constructor Create(RigNum : integer); override;
    procedure Initialize(); override;
  end;

  TICOM = class(TRig) // Icom CI-V
  private
    FMyAddr: Byte;
    FRigAddr: Byte;
    FUseTransceiveMode: Boolean;
    FGetBandAndMode: Boolean;
    FPollingCount: Integer;
    FWaitForResponse: Boolean;
  public
    constructor Create(RigNum : integer); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    procedure SetMode(Q : TQSO); override;
    procedure ExecuteCommand(S : AnsiString); override;
    procedure ParseBufferString; override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure Reset; override;
    procedure SetVFO(i : integer); override;
    procedure InquireStatus; override;
    procedure AntSelect(no: Integer); override;
    procedure ICOMWriteData(S : AnsiString);
    procedure StartPolling();
    procedure PollingProcess; override;
    procedure SetRit(flag: Boolean); override;
    procedure SetXit(flag: Boolean); override;
    procedure SetRitOffset(offset: Integer); override;
    property UseTransceiveMode: Boolean read FUseTransceiveMode write FUseTransceiveMode;
    property GetBandAndModeFlag: Boolean read FGetBandAndMode write FGetBandAndMode;
    property MyAddr: Byte read FMyAddr write FMyAddr;
    property RigAddr: Byte read FRigAddr write FRigAddr;
  end;

  TIC756 = class(TICOM)
    procedure Initialize(); override;
    procedure SetVFO(i : integer); override;
  end;

  TFT1000MP = class(TRig)
    WaitSize : integer;
    constructor Create(RigNum : integer); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    procedure SetMode(Q : TQSO); override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure ParseBufferString; override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure Reset; override;
    procedure SetVFO(i : integer); override;
    procedure InquireStatus; override;
    procedure PollingProcess; override;
    procedure PassOnRxData(S : AnsiString); override;
  end;

  TFT2000 = class(TRig)
    constructor Create(RigNum : integer); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    procedure SetMode(Q : TQSO); override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure ParseBufferString; override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure Reset; override;
    procedure SetVFO(i : integer); override;
    procedure InquireStatus; override;
    procedure AntSelect(no: Integer); override;
    procedure PollingProcess; override;
    procedure PassOnRxData(S : AnsiString); override;
    procedure SetRit(flag: Boolean); override;
    procedure SetXit(flag: Boolean); override;
    procedure SetRitOffset(offset: Integer); override;
  end;

  TMARKVF = class(TFT1000MP)
    procedure ExecuteCommand(S : AnsiString); override;
    procedure RitClear; override;
  end;

  TFT1000 = class(TFT1000MP)
    procedure ExecuteCommand(S: AnsiString); override;
    procedure RitClear; override;
    procedure SetVFO(i : integer); override;
  end;

  TFT1011 = class(TFT1000MP)
    procedure Initialize(); override;
    procedure SetMode(Q : TQSO); override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetVFO(i : integer); override;
    procedure PollingProcess(); override;
  end;

  TMARKV = class(TFT1000MP)
    procedure ExecuteCommand(S: AnsiString); override;
    procedure RitClear; override;
    procedure SetVFO(i : integer); override;
  end;

  TFT847 = class(TFT1000MP)
    FUseCatOnCommand: Boolean;
    constructor Create(RigNum : integer); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure RitClear; override;
    procedure SetVFO(i : integer); override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
    procedure PollingProcess; override;
  end;

  TFT817 = class(TFT847)
    Fchange: Boolean;
    destructor Destroy; override;
    procedure Initialize(); override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
    procedure PollingProcess; override;
  end;

  TFT920 = class(TFT1000MP)
    constructor Create(RigNum : integer); override;
    procedure ExecuteCommand(S: AnsiString); override;
  end;

  TFT991 = class(TFT2000)
    procedure ExecuteCommand(S: AnsiString); override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
  end;

  TFT100 = class(TFT1000MP)
    constructor Create(RigNum : integer); override;
    procedure Initialize(); override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure SetVFO(i : integer); override;
    procedure RitClear; override;
  end;

  TFT710 = class(TFT991)
    procedure RitClear; override;
    procedure SetRit(flag: Boolean); override;
    procedure SetXit(flag: Boolean); override;
    procedure SetRitOffset(offset: Integer); override;
    procedure AntSelect(no: Integer); override;
  end;

  TJST145 = class(TRig) //  or JST245
    CommOn, CommOff : AnsiString;
    constructor Create(RigNum : integer); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    procedure SetMode(Q : TQSO); override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure ParseBufferString; override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure Reset; override;
    procedure SetVFO(i : integer); override;
    procedure InquireStatus; override;
    procedure PollingProcess; override;
  end;

  TOmni = class(TRig)
    constructor Create(RigNum : integer); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    procedure PassOnRxData(S : AnsiString); override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure ParseBufferString; override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
    procedure InquireStatus; override;
    procedure SetVFO(i : integer); override;
    procedure UpdateStatus; override;
    procedure Reset; override;
  end;

  TVirtualRig = class(TRig)
    constructor Create(RigNum : integer); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure ParseBufferString; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
    procedure SetBand(Q: TQSO); override;
    procedure InquireStatus; override;
    procedure SetVFO(i : integer); override;
    procedure Reset; override;
  end;

  TRigArray = array[1..3] of TRig;
  TFreqArray = array [b19..HiBand] of TFrequency;

  TRigControl = class(TForm)
    dispMode: TLabel;
    Button1: TButton;
    RigLabel: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    PollingTimer1: TTimer;
    ZCom1: TCommPortDriver;
    ZCom2: TCommPortDriver;
    dispFreqA: TLabel;
    dispFreqB: TLabel;
    dispVFO: TStaticText;
    btnOmniRig: TButton;
    PollingTimer2: TTimer;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    dispLastFreq: TStaticText;
    Label1: TLabel;
    Label4: TLabel;
    buttonJumpLastFreq: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PollingTimerTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ZCom1ReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: Cardinal);
    procedure btnOmniRigClick(Sender: TObject);
    procedure buttonJumpLastFreqClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FRigs: TRigArray;
    FCurrentRig : TRig;
    FPrevVfo: array[0..1] of Integer;
    FOnVFOChanged: TNotifyEvent;
    FFreqLabel: array[0..1] of TLabel;

    FCurrentRigNumber: Integer;  // 1 or 2
    FMaxRig: Integer;            // default = 2.  may be larger with virtual rigs

    FOmniRig: TOmniRigX;

    procedure VisibleChangeEvent(Sender: TObject);
    procedure RigTypeChangeEvent(Sender: TObject; RigNumber: Integer);
    procedure StatusChangeEvent(Sender: TObject; RigNumber: Integer);
    procedure ParamsChangeEvent(Sender: TObject; RigNumber: Integer; Params: Integer);
    procedure CustomReplyEvent(Sender: TObject; RigNumber: Integer; Command, Reply: OleVariant);
    function BuildRigObject(rignum: Integer): TRig;
  public
    { Public declarations }
    TempFreq: TFreqArray; //  temp. freq storage when rig is not connected. in kHz
    function StatusSummaryFreq(kHz : TFrequency): string; // returns current rig's band freq mode
    function StatusSummaryFreqHz(Hz : TFrequency): string; // returns current rig's band freq mode
    function StatusSummary: string; // returns current rig's band freq mode
    procedure ImplementOptions(rig: Integer = 1);
    procedure Stop();
    function SetCurrentRig(N : integer): Boolean;
    function GetCurrentRig : integer;
    function ToggleCurrentRig : integer;
    function CheckSameBand(B : TBand) : boolean; // returns true if inactive rig is in B
    function IsAvailableBand(B: TBand): Boolean;
    procedure SetSendFreq();
    procedure UpdateFreq(currentvfo, VfoA, VfoB, Last: TFrequency; b: TBand; m: TMode);

    procedure SetRit(fOnOff: Boolean);
    procedure SetXit(fOnOff: Boolean);
    procedure SetRitOffset(offset: Integer);

    property Rig: TRig read FCurrentRig;
    property Rigs: TRigArray read FRigs;
    property MaxRig: Integer read FMaxRig write FMaxRig;

    property OnVFOChanged: TNotifyEvent read FOnVFOChanged write FOnVFOChanged;
  end;

function dec2hex(i: Integer): Integer;

implementation

uses
  UOptions, Main, UFreqList, UZLinkForm, UBandScope2;

{$R *.DFM}

function kHzStr(Hz: TFrequency): string;
var
   S: string;
begin
   S := IntToStr(Hz mod 1000);
   while length(S) < 3 do begin
      S := '0' + S;
   end;

   S := IntToStr(Hz div 1000) + '.' + S;

   Result := S;
end;

function TRigControl.StatusSummaryFreq(kHz: TFrequency): string; // returns current rig's band freq mode
var
   S, ss: string;
begin
   S := '';

   if (dmZLogGlobal.IsMultiStation() = True) then begin
      ss := '30';
   end
   else begin
      ss := IntToStr(Ord(Main.CurrentQSO.Band));
   end;

   ss := FillRight(ss, 3);

   S := ss + S;
   S := S + FillRight(MHzString[Main.CurrentQSO.Band], 5);
   S := S + FillRight(IntToStr(kHz), 8);
   S := S + FillRight(ModeString[Main.CurrentQSO.Mode], 5);

   ss := TimeToStr(CurrentTime);
   if Main.CurrentQSO.CQ then begin
      ss := 'CQ ' + ss + ' ';
   end
   else begin
      ss := 'SP ' + ss + ' ';
   end;

   S := S + ss + ' [' + dmZlogGlobal.Settings._pcname + ']';

   Result := S;
end;

function TRigControl.StatusSummaryFreqHz(Hz: TFrequency): string; // returns current rig's band freq mode
var
   S, ss: string;
begin
   S := '';

   if (dmZLogGlobal.IsMultiStation() = True) then begin
      ss := '30';
   end
   else begin
      ss := IntToStr(Ord(Main.CurrentQSO.Band));
   end;

   ss := FillRight(ss, 3);
   S := ss + S;
   S := S + FillRight(MHzString[Main.CurrentQSO.Band], 5);
   S := S + FillRight(FloatToStrF(Hz / 1000.0, ffFixed, 12, 1), 8);
   S := S + FillRight(ModeString[Main.CurrentQSO.Mode], 5);
   ss := TimeToStr(CurrentTime);

   if Main.CurrentQSO.CQ then begin
      ss := 'CQ ' + ss + ' ';
   end
   else begin
      ss := 'SP ' + ss + ' ';
   end;

   S := S + ss + ' [' + dmZlogGlobal.Settings._pcname + ']';

   Result := S;
end;

function TRigControl.StatusSummary: string; // returns current rig's band freq mode
begin
   Result := '';
   if FCurrentRig = nil then begin
      Exit;
   end;

   if FCurrentRig.CurrentFreqKHz > 60000 then begin
      Result := StatusSummaryFreq(FCurrentRig.CurrentFreqKHz);
   end
   else begin
      Result := StatusSummaryFreqHz(FCurrentRig.CurrentFreqHz);
   end;
end;

function TRigControl.CheckSameBand(B: TBand): Boolean; // returns true if inactive rig is in B
var
   R: TRig;
begin
   Result := False;

   R := FRigs[FCurrentRigNumber];

   if R <> nil then begin
      if R._currentband = B then begin
         Result := True;
      end;
   end;
end;

function TRigControl.IsAvailableBand(B: TBand): Boolean;
begin
   if Rig = nil then begin
      Result := True;
      Exit;
   end;

   if (Rig.MinBand <= B) and (B <= Rig.MaxBand) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

function TRigControl.SetCurrentRig(N: Integer): Boolean;
   procedure SetRigName(rigno: Integer; rigname: string);
   begin
      RigLabel.Caption := 'Current rig : ' + IntToStr(rigno) + ' (' + rigname + ')';
   end;
begin
   if (N > FMaxRig) or (N < 0) then begin
      Result := False;
      Exit;
   end;

   // RIG切り替え
   FCurrentRigNumber := N;
   if ((N = 1) or (N = 2) or (N = 3)) and (FRigs[N] <> nil) then begin
      FCurrentRig := FRigs[FCurrentRigNumber];
      FCurrentRig.InquireStatus;

      SetRigName(FCurrentRigNumber, FCurrentRig.name);
      FCurrentRig.UpdateStatus;
   end
   else begin
      FCurrentRig := nil;
      SetRigName(FCurrentRigNumber, '(none)');
   end;

   Result := True;
end;

function TRigControl.GetCurrentRig: Integer;
begin
   Result := FCurrentRigNumber;
end;

function TRigControl.ToggleCurrentRig: Integer;
var
   i: Integer;
begin
   if FCurrentRigNumber < FMaxRig then begin
      i := FCurrentRigNumber + 1;
   end
   else begin
      i := 1;
   end;

   SetCurrentRig(i); // FCurrentRigNumber is changed by SetCurrentRig;

   Result := FCurrentRigNumber;
end;

procedure TRig.PollingProcess;
begin
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

procedure TRig.SetXit(flag: Boolean);
begin
   FXit := flag;
end;

procedure TRig.SetRitOffset(offset: Integer);
begin
   FRitOffset := offset;
end;

procedure TRig.UpdateFreqMem(vfo: Integer; Hz: Integer);
var
   b: TBand;
begin
   b := dmZLogGlobal.BandPlan.FreqToBand(Hz);
   if b <> bUnknown then begin
      _currentband := b;
   end;
   FreqMem[_currentband, _currentmode] := _currentfreq[vfo];
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

function TRig.Selected: Boolean;
begin
   if _rignumber = MainForm.RigControl.FCurrentRigNumber then
      Result := True
   else
      Result := False;
end;

procedure TTS690.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      WriteData('FR0;FT0;')
   else
      WriteData('FR1;FT1;');

   if Selected then begin
      UpdateStatus;
   end;
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

procedure TICOM.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      ICOMWriteData(AnsiChar($07) + AnsiChar($00))
   else
      ICOMWriteData(AnsiChar($07) + AnsiChar($01));

   if Selected then begin
      UpdateStatus;
   end;
end;

procedure TIC756.Initialize();
begin
   Inherited;
end;

procedure TIC756.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   if _currentvfo <> i then begin
      _currentvfo := i;
      ICOMWriteData(AnsiChar($07) + AnsiChar($B0));
   end;

   if Selected then begin
      UpdateStatus;
   end;
end;

procedure TFT1000MP.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      WriteData(_nil3 + AnsiChar(0) + AnsiChar($05))
   else
      WriteData(_nil3 + AnsiChar(2) + AnsiChar($05));

   if Selected then begin
      UpdateStatus;
   end;
end;

constructor TFT2000.Create(RigNum : integer);
begin
   Inherited;
   TerminatorCode := ';';
   FComm.StopBits := sb2BITS;
   FComm.DataBits := db8BITS;
end;

destructor TFT2000.Destroy;
begin
   FPollingTimer.Enabled := False;
   Inherited;
end;

procedure TFT2000.Initialize();
begin
   Inherited;
   FPollingTimer.Enabled := True;
end;

//
// OPERATING MODE
//        0 1  2  3  4  5  6  7  8  9 10 11
// SET    M D P1 P2 ;
// READ   M D P1 ;
// ANSWER M D P1 P2 ;
// P1: 0:MAIN 1:SUB
// P2: 1:LSB 2:USB 3:CW 4:FM 5:AM 6:RTTY-L 7:CW-R 8:PKT-L 9:RTTY-U A:PKT-FM B:FM-N C:PKY-U
//
procedure TFT2000.SetMode(Q: TQSO);
var
   m: Integer;
begin
   Inherited SetMode(Q);

   case Q.Mode of
      mCW: m := 3;

      mSSB: begin
         if Q.Band <= b7 then begin
            m := 1;
         end
         else begin
            m := 2;
         end;
      end;

      mFM: m := 4;
      mAM: m := 5;
      mRTTY: m := 6;
      else begin
         Exit;
      end;
   end;

   WriteData(AnsiString('MD') + AnsiChar(Ord('0') + _currentvfo) + AnsiChar(Ord('0') + m) + AnsiString(';'));
end;

// こちらでRIG情報を処理する
// 00000 00001111 11111 12 2222222223
// 12345 67890123 45678 90 1234567890
// IF001 07131790 +0000 10 140000;
procedure TFT2000.ExecuteCommand(S: AnsiString);
var
   M: TMode;
   i: Integer;
   strTemp: string;
begin
   try
      if Length(S) <> 27 then begin
         Exit;
      end;

      // Memory Channel
      // 3-5

      // モード
      strTemp := string(S[21]);
      case StrToIntDef(strTemp, 99) of
         1, 2: M := mSSB;
         3, 7: M := mCW;
         4:    M := mFM;
         5:    M := mAM;
         6, 9: M := mRTTY;
         else  M := mOther;
      end;
      _currentmode := M;

      // 周波数(Hz)
      strTemp := string(Copy(S, 6, 8));
      i := StrToIntDef(strTemp, 0);
      _currentfreq[0] := i;

      // バンド(VFO-A)
      if _currentvfo = 0 then begin
         UpdateFreqMem(0, i);
      end;

      // RIT/XIT offset
      strTemp := string(Copy(S, 14, 5));
      FRitOffset := StrToIntDef(strTemp, 0);

      // RIT Status
      strTemp := string(Copy(S, 19, 1));
      FRit := StrToBoolDef(strTemp, False);

      // XIT Status
      strTemp := string(Copy(S, 20, 1));
      FXit := StrToBoolDef(strTemp, False);

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

// TerminatorCodeを受信するまで待って、
// 到着するとExecuteCommand実行
procedure TFT2000.ParseBufferString;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('***FT-2000 [' + string(BufferString) + ']'));
   {$ENDIF}

   if AnsiStrings.RightStr(BufferString, 1) <> TerminatorCode then begin
      Exit;
   end;

   ExecuteCommand(BufferString);

   Reset();
end;

//
// CLAR CLEAR
// SET    R C ;

procedure TFT2000.RitClear;
begin
   Inherited;
   WriteData('RC;');
end;

//
// FREQUENCY VFO-A/B
//        0 1  2  3  4  5  6  7  8  9 10 11
// SET    F A P1 P1 P1 P1 P1 P1 P1 P1 P1 ;
// READ   F A ;
// ANSWER F A P1 P1 P1 P1 P1 P1 P1 P1 P1 ;
//
procedure TFT2000.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
const
   cmd: array[0..1] of AnsiString = ( 'FA', 'FB' );
var
   freq: AnsiString;
begin
   Inherited SetFreq(Hz, fSetLastFreq);

   freq := AnsiStrings.RightStr(AnsiString(DupeString('0', 8)) + AnsiString(IntToStr(Hz)), 8);
   WriteData(cmd[_currentvfo] + freq + ';');
end;

procedure TFT2000.Reset;
begin
   BufferString := '';
end;

//
// VFO SELECT
// SET    V S P1 ;
// READ   V S ;
// ANSWER V S P1 ;
// P1: 0:VFO-A  1:VFO-B
//
procedure TFT2000.SetVFO(i: Integer);
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   WriteData(AnsiString('VS') + AnsiChar(Ord('0') + i) + AnsiString(';'));
end;

procedure TFT2000.InquireStatus;
begin

end;

//
// ANTENNA NUMBER
// SET    A N P1 P2 ;
// READ   A N P1 ;
// ANSWER A N P1 P3 P4 ;
// P1:0(fixed) P2:1/2/5 P3:1/2 P4 0/1
//
procedure TFT2000.AntSelect(no: Integer);
begin
   case no of
      0: Exit;
      1: WriteData('AN01;');
      2: WriteData('AN02;');
   end;
end;

//
// INFORMATION
//        0 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27
// SET
// READ   I F ;
// ANSWER I F ;  P1 P1 P1 P2 P2 P2 P2 P2 P2 P2 P2 P3 P3 P3 P3 P3 P4 P5 P6 P7 P8 P9 P9 P10 ;
// P1: Memory Channel(001-117)
// P2: VFO-A Frequency
// P3: CLAR DIRECTION(+/-) + CLAR OFFSET(0000-9999)Hz
// P4: RX CLAR 0:OFF 1:ON
// P5: TX CLAR 0:OFF 1:ON
// P6: MODE
// P7: 0:VFO 1:Memory 2:Memory Tune 3:QMB 4:QMB-MT
// P8: 0:CTCSS-OFF 1:CTCSS ENC/DEC 2:CTCSS ENC
// P9: Tone Number
// P10: 0:Simplex 1:Plus Shift 2:Minus Shift
//
procedure TFT2000.PollingProcess;
begin
   FPollingTimer.Enabled := False;
   if FStopRequest = True then begin
      Exit;
   end;

   WriteData('IF;');
end;

procedure TFT2000.PassOnRxData(S: AnsiString);
begin
   Inherited PassOnRxData(S);//でよさそう
end;

procedure TFT2000.SetRit(flag: Boolean);
begin
   Inherited;
   if flag = True then begin
      WriteData('RT1;');
   end
   else begin
      WriteData('RT0;');
   end;
end;

procedure TFT2000.SetXit(flag: Boolean);
begin
   Inherited;
   if flag = True then begin
      WriteData('XT1;');
   end
   else begin
      WriteData('XT0;');
   end;
end;

procedure TFT2000.SetRitOffset(offset: Integer);
var
   CMD: AnsiString;
begin
   if FRitOffset = offset then begin
      Exit;
   end;

   if offset = 0 then begin
      WriteData('RC;');
   end
   else if offset < 0 then begin
      WriteData('RC;');
      CMD := AnsiString('RD' + RightStr('0000' + IntToStr(Abs(offset)), 4) + ';');
      WriteData(CMD);
   end
   else if offset > 0 then begin
      WriteData('RC;');
      CMD := AnsiString('RU' + RightStr('0000' + IntToStr(Abs(offset)), 4) + ';');
      WriteData(CMD);
   end;

   Inherited;
end;

procedure TFT1000.ExecuteCommand(S: AnsiString);
var
   i: TFrequency;
   M: TMode;
begin
   try
      if length(S) = 32 then begin
         if _currentvfo = 0 then
            i := Ord(S[8])
         else
            i := Ord(S[8 + 16]);

         case i of
            0, 1:
               M := mSSB;
            2:
               M := mCW;
            3:
               M := mAM;
            4:
               M := mFM;
            5:
               M := mRTTY;
            else
               M := mOther;
         end;
         _currentmode := M;

         i := Ord(S[2]) * 256 * 256 + Ord(S[3]) * 256 + Ord(S[4]);
         i := i * 10;
         _currentfreq[0] := i;
         i := i + _freqoffset;

         if _currentvfo = 0 then begin
            UpdateFreqMem(0, i);
         end;

         i := Ord(S[18]) * 256 * 256 + Ord(S[19]) * 256 + Ord(S[20]);
         i := i * 10;
         _currentfreq[1] := i;
         i := i + _freqoffset;

         if _currentvfo = 1 then begin
            UpdateFreqMem(1, i);
         end;
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT1000.RitClear;
begin
   Inherited;
   WriteData(_nil3 + AnsiChar($FF) + AnsiChar($09));
end;

procedure TFT1000.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      WriteData(_nil3 + AnsiChar(0) + AnsiChar($05))
   else
      WriteData(_nil3 + AnsiChar(1) + AnsiChar($05));

   if Selected then begin
      UpdateStatus;
   end;
end;

procedure TFT1011.Initialize();
begin
   Inherited;
   FPollingTimer.Enabled := False;
end;

procedure TFT1011.SetMode(Q: TQSO);
var
   Command: AnsiString;
   para: byte;
begin
   Inherited SetMode(Q);

   para := 0;

   case Q.Mode of
      mSSB:
         if Q.Band <= b7 then
            para := 0
         else
            para := 1;
      mCW:
         para := 2;
      mFM:
         para := 6;
      mAM:
         para := 4;
      mRTTY:
         para := 8;
      mOther:
         para := $0A;
   end;

   Command := _nil3 + AnsiChar(para) + AnsiChar($0C);
   WriteData(Command);

   _currentmode := Q.Mode;
   if Selected then begin
      UpdateStatus;
   end;
end;

procedure TFT1011.ExecuteCommand(S: AnsiString);
begin
   try
      _currentfreq[0] := 0;
      _currentfreq[1] := 0;
      UpdateFreqMem(0, 0);
      UpdateFreqMem(1, 0);

      if Selected then begin
         UpdateStatus;
      end;
   finally
//      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT1011.RitClear;
begin
   Inherited;
   WriteData(_nil3 + AnsiChar($FF) + AnsiChar($09));
end;

procedure TFT1011.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   fstr: AnsiString;
   i, j: TFrequency;
begin
   i := Hz;
   i := i div 10;

   j := i mod 100;
   fstr := AnsiChar(dec2hex(j));
   i := i div 100;

   j := i mod 100;
   fstr := fstr + AnsiChar(dec2hex(j));
   i := i div 100;

   j := i mod 100;
   fstr := fstr + AnsiChar(dec2hex(j));
   i := i div 100;

   j := i mod 100;
   fstr := fstr + AnsiChar(dec2hex(j));
   // i := i div 100;

   fstr := fstr + AnsiChar($0A);

   WriteData(fstr);

   _currentfreq[_currentvfo] := Hz;
   UpdateFreqMem(_currentvfo, Hz);
   if Selected then begin
      UpdateStatus;
   end;

   Inherited SetFreq(Hz, fSetLastFreq);

   FPollingTimer.Enabled := True;
end;

procedure TFT1011.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      WriteData(_nil3 + AnsiChar(0) + AnsiChar($05))
   else
      WriteData(_nil3 + AnsiChar(1) + AnsiChar($05));

   if Selected then begin
      UpdateStatus;
   end;
end;

procedure TFT1011.PollingProcess;
begin
   FPollingTimer.Enabled := False;
   if FStopRequest = True then begin
      Exit;
   end;

   ExecuteCommand('');
end;

procedure TMARKV.ExecuteCommand(S: AnsiString);
var
   i: TFrequency;
   M: TMode;
begin
   try
      if length(S) = 32 then begin
         if _currentvfo = 0 then
            i := Ord(S[8])
         else
            i := Ord(S[8 + 16]);

         case i of
            0, 1:
               M := mSSB;
            2:
               M := mCW;
            3:
               M := mAM;
            4:
               M := mFM;
            5:
               M := mRTTY;
            else
               M := mOther;
         end;
         _currentmode := M;

         i := (Ord(S[5]) mod 16) * 100000000 + (Ord(S[5]) div 16) * 10000000 + (Ord(S[4]) mod 16) * 1000000 + (Ord(S[4]) div 16) * 100000 +
           (Ord(S[3]) mod 16) * 10000 + (Ord(S[3]) div 16) * 1000 + (Ord(S[2]) mod 16) * 100 + (Ord(S[2]) div 16) * 10;
         _currentfreq[0] := i;
         i := i + _freqoffset;

         if _currentvfo = 0 then begin
            UpdateFreqMem(0, i);
         end;

         i := (Ord(S[21]) div 16) * 100000000 + (Ord(S[21]) mod 16) * 10000000 + (Ord(S[20]) div 16) * 1000000 + (Ord(S[20]) mod 16) * 100000 +
           (Ord(S[19]) div 16) * 10000 + (Ord(S[19]) mod 16) * 1000 + (Ord(S[18]) div 16) * 100 + (Ord(S[18]) mod 16) * 10;
         _currentfreq[1] := i;
         i := i + _freqoffset;

         if _currentvfo = 1 then begin
            UpdateFreqMem(1, i);
         end;
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TMARKV.RitClear;
begin
   Inherited;
   WriteData(_nil3 + AnsiChar($FF) + AnsiChar($09));
end;

procedure TMARKV.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      WriteData(_nil3 + AnsiChar(0) + AnsiChar($05))
   else
      WriteData(_nil3 + AnsiChar(1) + AnsiChar($05));
   if Selected then
      UpdateStatus;
end;

procedure TMARKVF.ExecuteCommand(S: AnsiString);
var
   i: TFrequency;
   M: TMode;
begin
   try
      if length(S) = 32 then begin
         if _currentvfo = 0 then begin
            i := Ord(S[8])
         end
         else begin
            i := Ord(S[8 + 16]);
         end;

         case i of
            0, 1:
               M := mSSB;
            2:
               M := mCW;
            3:
               M := mAM;
            4:
               M := mFM;
            5:
               M := mRTTY;
            else
               M := mOther;
         end;
         _currentmode := M;

         i := Ord(S[2]) * 256 * 256 * 256 + Ord(S[3]) * 256 * 256 + Ord(S[4]) * 256 + Ord(S[5]);
         i := i * 10;
         _currentfreq[0] := i;
         i := i + _freqoffset;

         if _currentvfo = 0 then begin
            UpdateFreqMem(0, i);
         end;

         i := Ord(S[18]) * 256 * 256 * 256 + Ord(S[19]) * 256 * 256 + Ord(S[20]) * 256 + Ord(S[21]);
         i := i * 10;
         _currentfreq[1] := i;
         i := i + _freqoffset;

         if _currentvfo = 1 then begin
            UpdateFreqMem(1, i);
         end;
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TMARKVF.RitClear;
begin
   Inherited;
   WriteData(_nil3 + AnsiChar($FF) + AnsiChar($09));
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

function TRigControl.BuildRigObject(rignum: Integer): TRig;
var
   rname: string;
   i: Integer;
   rig: TRig;
begin
   rig := nil;
   try
      if dmZlogGlobal.RigNameStr[rignum] = 'Omni-Rig' then begin
         rig := TOmni.Create(rignum);
         rig._minband := b19;
         rig._maxband := b1200;
         btnOmniRig.Enabled := True;
      end
      else begin
         btnOmniRig.Enabled := False;
      end;

      if dmZlogGlobal.Settings.FRigControl[rignum].FControlPort in [1 .. 20] then begin
         rname := dmZlogGlobal.RigNameStr[rignum];
         if rname = 'None' then begin
            Exit;
         end;

         if rname = 'TS-690/450' then begin
            rig := TTS690.Create(rignum);
            rig._minband := b19;
            rig._maxband := b50;
         end;
         if rname = 'TS-850' then begin
            rig := TTS690.Create(rignum);
            rig._minband := b19;
            rig._maxband := b28;
         end;
         if rname = 'TS-790' then begin
            rig := TTS690.Create(rignum);
            rig._minband := b144;
            rig._maxband := b1200;
         end;

         if rname = 'TS-570' then begin
            rig := TTS570.Create(rignum);
            rig._minband := b19;
            rig._maxband := b50;
         end;

         if rname = 'TS-590/890/990' then begin
            rig := TTS2000.Create(rignum);
            rig._minband := b19;
            rig._maxband := b50;
         end;

         if rname = 'TS-2000' then begin
            rig := TTS2000.Create(rignum);
            rig._minband := b19;
            rig._maxband := b2400;
         end;

         if rname = 'TS-2000/P' then begin
            rig := TTS2000P.Create(rignum);
            rig._minband := b19;
            rig._maxband := b2400;
         end;

         if rname = 'FT-2000' then begin
            rig:= TFT2000.Create(rignum);
            rig._minband := b19;
            rig._maxband := b50;
         end;

         if rname = 'FT-1000MP' then begin
            rig:= TFT1000MP.Create(rignum);
            rig._minband := b19;
            rig._maxband := b28;
         end;

         if rname = 'MarkV/FT-1000MP' then begin
            rig:= TMARKV.Create(rignum);
            rig._minband := b19;
            rig._maxband := b28;
         end;

         if rname = 'FT-1000MP Mark-V Field' then begin
            rig := TMARKVF.Create(rignum);
            rig._minband := b19;
            rig._maxband := b28;
         end;

         if rname = 'FT-1000' then begin
            rig := TFT1000.Create(rignum);
            rig._minband := b19;
            rig._maxband := b28;
         end;

         if rname = 'FT-1011(PC->RIG)' then begin
            rig := TFT1011.Create(rignum);
            rig._minband := b19;
            rig._maxband := b28;
         end;

         if rname = 'FT-920' then begin
            rig := TFT920.Create(rignum);
            rig._minband := b19;
            rig._maxband := b50;
         end;

         if rname = 'FT-100' then begin
            rig := TFT100.Create(rignum);
            rig._minband := b19;
            rig._maxband := b430;
         end;

         if rname = 'FT-847' then begin
            rig := TFT847.Create(rignum);
            rig._minband := b19;
            rig._maxband := b430;
         end;

         if rname = 'FT-817' then begin
            rig := TFT817.Create(rignum);
            rig._minband := b19;
            rig._maxband := b430;
         end;

         if rname = 'FT-991' then begin
            rig:= TFT991.Create(rignum);
            rig._minband := b19;
            rig._maxband := b430;
         end;

         if rname = 'FT-710' then begin
            rig:= TFT710.Create(rignum);
            rig._minband := b19;
            rig._maxband := b50;
         end;

         if rname = 'JST-145' then begin
            rig := TJST145.Create(rignum);
            rig._minband := b19;
            rig._maxband := b28;
         end;

         if rname = 'JST-245' then begin
            rig := TJST145.Create(rignum);
            rig._minband := b19;
            rig._maxband := b50;
         end;

         if pos('IC-', rname) = 1 then begin
            if (pos('IC-775', rname) = 1) or (pos('IC-756', rname) = 1) then begin
               rig := TIC756.Create(rignum);
            end
            else begin
               rig := TICOM.Create(rignum);
            end;
            TICOM(rig).UseTransceiveMode := dmZLogGlobal.Settings._use_transceive_mode;
            TICOM(rig).GetBandAndModeFlag := dmZLogGlobal.Settings._icom_polling_freq_and_mode;

            for i := 1 to MAXICOM do begin
               if rname = ICOMLIST[i].name then begin
                  break;
               end;
            end;

            rig._minband := ICOMLIST[i].minband;
            rig._maxband := ICOMLIST[i].maxband;
            TICOM(rig).RigAddr := ICOMLIST[i].addr;
            TICOM(rig).RitCtrlSupported := ICOMLIST[i].RitCtrl;
            TICOM(rig).XitCtrlSupported := ICOMLIST[i].XitCtrl;
         end;

         rig.name := rname;
      end;
   finally
      Result := rig;
   end;
end;

procedure TRigControl.ImplementOptions(rig: Integer);
var
   i: Integer;
begin
   Stop();

   if (dmZLogGlobal.Settings._so2r_type = so2rNone) or (dmZLogGlobal.Settings._so2r_use_rig3 = False) then begin
      FMaxRig := 2;
   end
   else begin
      FMaxRig := 3;
   end;

   FRigs[1] := BuildRigObject(1);
   FRigs[2] := BuildRigObject(2);
   FRigs[3] := TVirtualRig.Create(3);

   // RIGコントロールのCOMポートと、CWキーイングのポートが同じなら
   // CWキーイングのCPDrvをRIGコントロールの物にすり替える
   if ((FRigs[1] <> nil) and (dmZlogGlobal.Settings.FRigControl[1].FControlPort = dmZlogGlobal.Settings.FRigControl[1].FKeyingPort)) and
      ((FRigs[2] <> nil) and (dmZlogGlobal.Settings.FRigControl[2].FControlPort = dmZlogGlobal.Settings.FRigControl[2].FKeyingPort)) then begin
      PollingTimer1.Enabled := False;
      dmZLogKeyer.SetCommPortDriver(0, FRigs[1].CommPortDriver);
      PollingTimer1.Enabled := True;

      PollingTimer2.Enabled := False;
      dmZLogKeyer.SetCommPortDriver(1, FRigs[2].CommPortDriver);
      PollingTimer2.Enabled := True;
   end
   else if (FRigs[1] <> nil) and (dmZlogGlobal.Settings.FRigControl[1].FControlPort = dmZlogGlobal.Settings.FRigControl[1].FKeyingPort) then begin
      PollingTimer1.Enabled := False;
      dmZLogKeyer.SetCommPortDriver(0, FRigs[1].CommPortDriver);
      PollingTimer1.Enabled := True;

      dmZLogKeyer.ResetCommPortDriver(1, TKeyingPort(dmZlogGlobal.Settings.FRigControl[2].FKeyingPort));
   end
   else if (FRigs[2] <> nil) and (dmZlogGlobal.Settings.FRigControl[2].FControlPort = dmZlogGlobal.Settings.FRigControl[2].FKeyingPort) then begin
      dmZLogKeyer.ResetCommPortDriver(0, TKeyingPort(dmZlogGlobal.Settings.FRigControl[1].FKeyingPort));

      PollingTimer2.Enabled := False;
      dmZLogKeyer.SetCommPortDriver(1, FRigs[2].CommPortDriver);
      PollingTimer2.Enabled := True;
   end
   else begin
      dmZLogKeyer.ResetCommPortDriver(0, TKeyingPort(dmZlogGlobal.Settings.FRigControl[1].FKeyingPort));
      dmZLogKeyer.ResetCommPortDriver(1, TKeyingPort(dmZlogGlobal.Settings.FRigControl[2].FKeyingPort));
   end;

   for i := 1 to 2 do begin
      if FRigs[i] <> nil then begin
         if dmZlogGlobal.Settings.FRigControl[i].FUseTransverter then begin
            FRigs[i]._freqoffset := 1000 * dmZlogGlobal.Settings.FRigControl[i].FTransverterOffset;
         end
         else begin
            FRigs[i]._freqoffset := 0;
         end;

         // Initialize & Start
         FRigs[i].Initialize();
      end;
   end;

   SetCurrentRig(rig);

   SetSendFreq();
end;

procedure TRigControl.Stop();
var
   i: Integer;
begin
   for i := 1 to 3 do begin
      if Assigned(FRigs[i]) then begin
         FRigs[i].StopRequest();
      end;
   end;

   Timer1.Enabled := False;
   PollingTimer1.Enabled := False;
   PollingTimer2.Enabled := False;

   for i := 1 to 3 do begin
      if Assigned(FRigs[i]) then begin
         FreeAndNil(FRigs[i]);
      end;
   end;
   FCurrentRig := nil;
end;

constructor TRig.Create(RigNum: Integer);
var
   B: TBand;
   M: TMode;
   prtnr: Integer;
begin
   // inherited
   for M := mCW to mOther do begin
      ModeWidth[M] := -1;
   end;

   FFILO := False; // used for YAESU
   _freqoffset := 0;
   _minband := b19;
   _maxband := b10g;
   Name := '';

   _rignumber := RigNum;
   if _rignumber = 1 then begin
      prtnr := dmZlogGlobal.Settings.FRigControl[1].FControlPort;
      FComm := MainForm.RigControl.ZCom1;
      FPollingTimer := MainForm.RigControl.PollingTimer1;
   end
   else begin
      prtnr := dmZlogGlobal.Settings.FRigControl[2].FControlPort;
      FComm := MainForm.RigControl.ZCom2;
      FPollingTimer := MainForm.RigControl.PollingTimer2;
   end;

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
   FComm.HwFlow := hfRTSCTS;
   FComm.SwFlow := sfNONE;
   FComm.EnableDTROnOpen := True;

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
   FLastCall := '';
   FLastRcvd := '';
   FLastFreq := 0;
   FLastMode := _currentmode;

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

   FStopRequest := False;
end;

destructor TRig.Destroy;
begin
   inherited;
   if Assigned(FPollingTimer) then begin
      FPollingTimer.Enabled := False;
   end;
   if Assigned(FComm) then begin
      FComm.Disconnect();
   end;
end;

procedure TRig.Initialize();
begin
   FPollingTimer.Interval := FPollingInterval;
   FComm.Connect();
   if FComm.HwFlow = hfNONE then begin
      FComm.ToggleDTR(False);
      FComm.ToggleRTS(False);
   end;

   FStopRequest := False;
end;

procedure TRig.VFOAEqualsB;
begin
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

procedure TFT1000MP.PassOnRxData(S: AnsiString);
var
   i: Integer;
begin
   if FFILO then begin
      for i := length(S) downto 1 do begin
         BufferString := S[i] + BufferString;
      end;
   end
   else begin
      BufferString := BufferString + S;
   end;

   ParseBufferString;
end;

procedure TRig.MoveToLastFreq;
begin
   SetFreq(FLastFreq, False);

   if FLastMode <> _currentmode then begin
      SetMode(FLastMode);

      // もう一度周波数を設定(side bandずれ対策)
      if dmZLogGlobal.Settings._bandscope_setfreq_after_mode_change = True then begin
         SetFreq(FLastFreq, False);
      end;
   end;
end;

procedure TRig.AntSelect(no: Integer);
begin
   //
end;

constructor TTS690.Create(RigNum: Integer);
begin
   Inherited;
   TerminatorCode := ';';
   FComm.StopBits := sb2BITS;
   _CWR := False;
   FFineStep := False;
end;

procedure TTS690.Initialize();
begin
   Inherited;
   WriteData('AI1;');
end;

constructor TTS2000.Create(RigNum: Integer);
begin
   Inherited;
   TerminatorCode := ';';
   FComm.StopBits := sb1BITS;
end;

procedure TTS2000.Initialize();
begin
   Inherited;
   WriteData('TC 1;');
   WriteData('AI2;');
   WriteData('IF;');
end;

procedure TTS2000.SetRitOffset(offset: Integer);
var
   CMD: AnsiString;
begin
   if FRitOffset = offset then begin
      Exit;
   end;

   if offset = 0 then begin
      WriteData('RC;');
   end
   else if offset < 0 then begin
      WriteData('RC;');
      CMD := AnsiString('RD' + RightStr('00000' + IntToStr(Abs(offset)), 5) + ';');
      WriteData(CMD);
   end
   else if offset > 0 then begin
      WriteData('RC;');
      CMD := AnsiString('RU' + RightStr('00000' + IntToStr(Abs(offset)), 5) + ';');
      WriteData(CMD);
   end;

   Inherited;
end;

constructor TTS2000P.Create(RigNum: Integer);
begin
   Inherited;
end;

procedure TTS2000P.Initialize();
begin
   Inherited;
   FPollingTimer.Enabled := True;
end;

constructor TTS570.Create(RigNum: Integer);
begin
   Inherited;
   TerminatorCode := ';';
   FComm.StopBits := sb1BITS;
end;

procedure TTS570.Initialize();
begin
   Inherited;
   WriteData('TC 1;');
   WriteData('AI2;');
   WriteData('IF;');
end;

constructor TJST145.Create(RigNum: Integer);
begin
   inherited;
   CommOn := 'H1' + _CR;
   CommOff := 'H0' + _CR;
   FComm.StopBits := sb1BITS;
   TerminatorCode := _CR;
end;

procedure TJST145.Initialize();
begin
   Inherited;
   WriteData('I1' + _CR + 'L' + _CR);
end;

constructor TICOM.Create(RigNum: Integer);
begin
   Inherited;
   FPollingCount := 0;
   FUseTransceiveMode := True;
   FComm.StopBits := sb1BITS;
   FComm.HwFlow := hfNONE;
   FComm.SwFlow := sfNONE;
   FComm.EnableDTROnOpen := False;
   FWaitForResponse := False;
   TerminatorCode := AnsiChar($FD);

   FMyAddr := $E0;
   FRigAddr := $01;
end;

procedure TICOM.Initialize();
begin
   Inherited;
   SetVFO(0);
   FPollingTimer.Enabled := True;
end;

procedure TICOM.ICOMWriteData(S: AnsiString);
var
   dwTick: DWORD;
   msg: string;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('[' + IntToStr(_rignumber) + ']*** Enter - TICOM.ICOMWriteData(' + IntToHex(Byte(S[1]), 2) + ') ---'));
   {$ENDIF}

   if FComm.Connected = False then begin
      {$IFDEF DEBUG}
      OutputDebugString(PChar('[' + IntToStr(_rignumber) + '] @@@not connected@@@'));
      {$ENDIF}
      Exit;
   end;

   // コマンド送信時はポーリング中止
   FPollingTimer.Enabled := False;

   // 応答待ち中
   FWaitForResponse := True;

   WriteData(AnsiChar($FE) + AnsiChar($FE) + AnsiChar(FRigAddr) + AnsiChar(FMyAddr) + S + AnsiChar($FD));

   // 応答確認無しなら抜ける
   if dmZLogGlobal.Settings._icom_strict_ack_response = False then begin
      Exit;
   end;

   // $FA/$FB/Response受信まで待ち合わせ
   dwTick := GetTickCount();
   while FWaitForResponse = True do begin
      // 待ってる間重い感じするなら↓
      Application.ProcessMessages();

      // とりあえず5秒だけど、1-3秒位で良さそう　iniファイルに出すか
      if (GetTickCount() - dwTick) > dmZLogGlobal.Settings._icom_response_timeout then begin
         FWaitForResponse := False;
         //FStopRequest := True;
         msg := 'No response from ' + Self.Name;
         {$IFDEF DEBUG}
         msg := msg + ' (' + IntToHex(Byte(S[1])) + ')';
         OutputDebugString(PChar('[' + IntToStr(_rignumber) + '] ' + msg));
         {$ENDIF}
         MainForm.WriteStatusLineRed(msg, True);
         Break;
      end;

      Sleep(1);
   end;

   // ポーリング再開
   StartPolling();

   {$IFDEF DEBUG}
   OutputDebugString(PChar('[' + IntToStr(_rignumber) + ']*** Leave - TICOM.ICOMWriteData(' + IntToHex(Byte(S[1]), 2) + ') ---'));
   {$ENDIF}
end;

procedure TICOM.StartPolling();
begin
   if FStopRequest = True then begin
      FPollingTimer.Enabled := False;
      Exit;
   end;

   // トランシーブモード使わない時はポーリング再開
   if (FUseTransceiveMode = False) then begin
      FPollingTimer.Enabled := True;
   end;

   // トランシーブモード使う場合は１回か２回ポーリングする
   if (FUseTransceiveMode = True) then begin
      if ((FGetBandAndMode = True) and  (FPollingCount < 2)) or
         ((FGetBandAndMode = False) and  (FPollingCount < 1)) then begin
         FPollingTimer.Enabled := True;
      end;
   end;
end;

constructor TFT1000MP.Create(RigNum: Integer);
begin
   inherited;
   WaitSize := 32;
   FComm.StopBits := sb2BITS;
end;

procedure TFT1000MP.Initialize();
begin
   Inherited;
   FPollingTimer.Enabled := True;
end;

constructor TFT847.Create(RigNum: Integer);
begin
   inherited;
   WaitSize := 5;
   FComm.StopBits := sb2BITS;
   FUseCatOnCommand := True;
end;

procedure TFT847.Initialize();
begin
   Inherited;
   if FUseCatOnCommand = True then begin
      WriteData(AnsiChar($00) + AnsiChar($00) + AnsiChar($00) + AnsiChar($00) + AnsiChar($00)); // CAT ON
   end;
   FPollingTimer.Enabled := True;
end;

constructor TFT920.Create(RigNum: Integer);
begin
   Inherited;
   WaitSize := 28;
end;

constructor TFT100.Create(RigNum: Integer);
begin
   Inherited;
   WaitSize := 32;
end;

procedure TFT100.Initialize();
begin
   Inherited;
end;

destructor TTS690.Destroy;
begin
   WriteData('AI0;');
   inherited;
end;

destructor TJST145.Destroy;
begin
   WriteData(CommOff);
   inherited;
end;

destructor TTS2000P.Destroy;
begin
   WriteData('AI0;');
   inherited;
end;

destructor TICOM.Destroy;
begin
   inherited;
end;

destructor TFT1000MP.Destroy;
begin
   inherited;
end;

destructor TFT847.Destroy;
begin
   if FUseCatOnCommand = True then begin
      WriteData(_nil4 + AnsiChar($80));   // CAT OFF
   end;
   inherited;
end;

destructor TFT817.Destroy;
begin
   inherited;
end;

procedure TTS690.ParseBufferString;
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

procedure TJST145.RitClear();
begin
   Inherited;
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

procedure TICOM.ParseBufferString; // same as ts690
var
   i: Integer;
   temp: AnsiString;
begin
   i := pos(TerminatorCode, BufferString);

   while i > 0 do begin
      temp := copy(BufferString, 1, i);
      Delete(BufferString, 1, i);

      ExecuteCommand(temp); // string formatted at excecutecommand
      i := pos(TerminatorCode, BufferString);
   end;
end;

procedure TICOM.PollingProcess;
begin
   FPollingTimer.Enabled := False;

   if FWaitForResponse = True then begin
      Exit;
   end;
   if FStopRequest = True then begin
      Exit;
   end;

   if FGetBandAndMode = False then begin
      ICOMWriteData(AnsiChar($03));
   end
   else begin
      if (FPollingCount and 1) = 0 then begin
         ICOMWriteData(AnsiChar($03));
      end
      else begin
         ICOMWriteData(AnsiChar($04));
      end;
   end;

   Inc(FPollingCount);
   if FPollingCount < 0 then begin
      FPollingCount := 1;
   end;
end;

procedure TICOM.SetRit(flag: Boolean);
begin
   Inherited;

   if FRitCtrlSupported = False then begin
      Exit;
   end;

   if flag = True then begin
      ICOMWriteData(AnsiChar($21) + AnsiChar($01) + AnsiChar($01));
   end
   else begin
      ICOMWriteData(AnsiChar($21) + AnsiChar($01) + AnsiChar($00));
   end;
end;

procedure TICOM.SetXit(flag: Boolean);
begin
   Inherited;

   if FXitCtrlSupported = False then begin
      Exit;
   end;

   if flag = True then begin
      ICOMWriteData(AnsiChar($21) + AnsiChar($02) + AnsiChar($01));
   end
   else begin
      ICOMWriteData(AnsiChar($21) + AnsiChar($02) + AnsiChar($00));
   end;
end;

procedure TICOM.SetRitOffset(offset: Integer);
var
   CMD: AnsiString;
   sign: AnsiString;
   freq: Integer;
   i: Integer;
begin
   if FRitOffset = offset then begin
      Exit;
   end;

   if (FRitCtrlSupported = False) and (FXitCtrlSupported = False) then begin
      Exit;
   end;

   if offset < 0 then begin
      freq := offset * -1;
      sign := AnsiChar($01);
   end
   else begin
      freq := offset;
      sign := AnsiChar($00);
   end;

   CMD := AnsiChar($21) + AnsiChar($00);

   // 10Hz  1Hz
   i := freq mod 100;
   CMD := CMD + AnsiChar((i div 10) * 16 + (i mod 10));
   freq := freq div 100;

   // 1KHz  100Hz
   i := freq mod 100;
   CMD := CMD + AnsiChar((i div 10) * 16 + (i mod 10));
//   freq := freq div 100;

   // plus/minus
   CMD := CMD + sign;

   ICOMWriteData(CMD);

   Inherited;
end;

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

procedure TFT1000MP.PollingProcess;
begin
   FPollingTimer.Enabled := False;
   if FStopRequest = True then begin
      Exit;
   end;

   WriteData(_nil3 + AnsiChar($03) + AnsiChar($10));
end;

procedure TFT847.PollingProcess;
begin
   FPollingTimer.Enabled := False;
   if FStopRequest = True then begin
      Exit;
   end;

   WriteData(_nil4 + AnsiChar($03));
end;

procedure TFT817.PollingProcess;
begin
   FPollingTimer.Enabled := False;
   if FStopRequest = True then begin
      Exit;
   end;

   if Fchange then begin
      BufferString :='';
      Fchange := False;
   end;
   WriteData(_nil4 + AnsiChar($03));
end;

procedure TTS2000P.PollingProcess;
begin
   FPollingTimer.Enabled := False;
   if FStopRequest = True then begin
      Exit;
   end;

   WriteData('IF;');
end;

procedure TJST145.PollingProcess;
begin
end;

procedure TFT1000MP.ParseBufferString;
var
   temp: AnsiString;
begin
   if length(BufferString) > 2048 then begin
      BufferString := '';
   end;

   if WaitSize = 0 then begin
      Exit;
   end;

   if length(BufferString) >= WaitSize then begin
      temp := copy(BufferString, 1, WaitSize);
      ExecuteCommand(temp);
      Delete(BufferString, 1, WaitSize);
   end;
end;

procedure TTS690.SetMode(Q: TQSO);
var
   Command: AnsiString;
   para: AnsiChar;
begin
   Inherited SetMode(Q);

   { 1=LSB, 2=USB, 3=CW, 4=FM, 5=AM, 6=FSK, 7=CW-R, 8=FSK=R }
   para := '3';
   case Q.Mode of
      mSSB:
         if Q.Band <= b7 then
            para := '1'
         else
            para := '2';
      mCW:
         if _CWR then
            para := '7'
         else
            para := '3';
      mFM:
         para := '4';
      mAM:
         para := '5';
      mRTTY:
         para := '6';
   end;

   Command := AnsiString('MD') + para + TerminatorCode;
   WriteData(Command);
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

procedure TICOM.SetMode(Q: TQSO);
var
   Command: AnsiString;
   para: byte;
begin
   Inherited SetMode(Q);

   FPollingTimer.Enabled := False;
   try
      para := 3;
      case Q.Mode of
         mSSB:
            if Q.Band <= b7 then
               para := 0
            else
               para := 1;
         mCW:
            para := 3;
         mFM:
            para := 5;
         mAM:
            para := 2;
         mRTTY:
            para := 4;
      end;

      Command := AnsiChar($06) + AnsiChar(para);

      if ModeWidth[Q.Mode] in [1 .. 3] then begin
         Command := Command + AnsiChar(ModeWidth[Q.Mode]);
      end;

      ICOMWriteData(Command);
   finally
      FPollingCount := 0;
      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT1000MP.SetMode(Q: TQSO);
var
   Command: AnsiString;
   para: byte;
begin
   Inherited SetMode(Q);

   para := 0;

   case Q.Mode of
      mSSB:
         if Q.Band <= b7 then
            para := 0
         else
            para := 1;
      mCW:
         para := 2;
      mFM:
         para := 6;
      mAM:
         para := 4;
      mRTTY:
         para := 8;
      mOther:
         para := $0A;
   end;

   Command := _nil3 + AnsiChar(para) + AnsiChar($0C);
   WriteData(Command);
end;

procedure TRig.SetMode(Q: TQSO);
begin
   _currentmode := Q.Mode;
   FLastMode := _currentmode;
end;

procedure TRig.SetMode(M: TMode);
var
   Q: TQSO;
begin
   Q := TQSO.Create();
   try
      Q.Mode := M;
      Q.Band := dmZLogGlobal.BandPlan.FreqToBand(FLastFreq);
      SetMode(Q);
   finally
      Q.Free();
   end;
end;

procedure TRig.SetBand(Q: TQSO);
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
   AntSelect(dmZLogGlobal.Settings._useant[Q.Band]);
end;

procedure TRig.RitClear();
begin
   FRitOffset := 0;
end;

procedure TRig.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
begin
   if fSetLastFreq = True then begin
      FLastFreq := _currentfreq[_currentvfo];
      FLastMode := _currentmode;
   end;
end;

procedure TTS690.RitClear;
begin
   Inherited;
   WriteData('RC;');
end;

procedure TICOM.RitClear;
var
   Command: AnsiString;
begin
   Inherited;

   if FRitCtrlSupported = False then begin
      Exit;
   end;

   Command := AnsiChar($21) + AnsiChar($00) +
              // 10Hz  1Hz    1KHz  100Hz
              AnsiChar($00) + AnsiChar($00) +
              // 00:+   01:-
              AnsiChar($00);

   ICOMWriteData(Command);
end;

procedure TFT1000MP.RitClear;
begin
   Inherited;
   WriteData(_nil2 + AnsiChar($0F) + AnsiChar($0) + AnsiChar($09));
end;

procedure TTS690.InquireStatus;
begin
   WriteData('IF;');
end;

procedure TTS690.AntSelect(no: Integer);
begin
   case no of
      0: Exit;
      1: WriteData('AN1;');
      2: WriteData('AN2;');
   end;
end;

procedure TTS690.SetRit(flag: Boolean);
begin
   Inherited;
   if flag = True then begin
      WriteData('RT1;');
   end
   else begin
      WriteData('RT0;');
   end;
end;

procedure TTS690.SetXit(flag: Boolean);
begin
   Inherited;
   if flag = True then begin
      WriteData('XT1;');
   end
   else begin
      WriteData('XT0;');
   end;
end;

procedure TTS690.SetRitOffset(offset: Integer);
var
//   CMD: AnsiString;
   i: Integer;
   n: Integer;
begin
   if FRitOffset = offset then begin
      Exit;
   end;

   if offset = 0 then begin
      WriteData('RC;');
   end
   else if offset < 0 then begin
      WriteData('RC;');

      offset := offset * -1;

      if FFineStep = True then begin
         n := offset;
      end
      else begin
         n := offset div 10;
      end;

      for i := 1 to n do begin
         WriteData('RD;');
      end;

//      CMD := AnsiString('RD' + RightStr('00000' + IntToStr(Abs(offset)), 5) + ';');
//      WriteData(CMD);
   end
   else if offset > 0 then begin
      WriteData('RC;');

      if FFineStep = True then begin
         n := offset;
      end
      else begin
         n := offset div 10;
      end;

      for i := 1 to n do begin
         WriteData('RU;');
      end;

//      CMD := AnsiString('RU' + RightStr('00000' + IntToStr(Abs(offset)), 5) + ';');
//      WriteData(CMD);
   end;

   Inherited;
end;

procedure TJST145.InquireStatus;
begin
end;

procedure TICOM.InquireStatus;
begin
end;

procedure TICOM.AntSelect(no: Integer);
begin
   case no of
      0: Exit;
      1: ICOMWriteData(AnsiChar($12) + AnsiChar($00) + AnsiChar($00));
      2: ICOMWriteData(AnsiChar($12) + AnsiChar($01) + AnsiChar($00));
   end;
end;

procedure TFT1000MP.InquireStatus;
begin
end;

procedure TTS690.Reset;
begin
end;

procedure TJST145.Reset;
begin
   BufferString := '';
   WriteData('I1' + _CR + 'L' + _CR);
end;

procedure TICOM.Reset;
begin
end;

procedure TFT1000MP.Reset;
begin
   BufferString := '';
end;

procedure TTS690.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   fstr: AnsiString;
begin
   Inherited SetFreq(Hz, fSetLastFreq);

   fstr := AnsiString(IntToStr(Hz));
   while length(fstr) < 11 do begin
      fstr := '0' + fstr;
   end;

   if _currentvfo = 0 then
      WriteData('FA' + fstr + ';')
   else
      WriteData('FB' + fstr + ';');
end;

procedure TJST145.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   fstr: AnsiString;
begin
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

procedure TICOM.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   fstr: AnsiString;
   freq, i: TFrequency;
begin
   Inherited SetFreq(Hz, fSetLastFreq);

   FPollingTimer.Enabled := False;
   try
      freq := Hz;
      if freq < 0 then // > 2.1GHz is divided by 100 and given a negative value. Not implemented yet
      begin
         fstr := AnsiChar(0);
         freq := -1 * freq;
      end
      else begin
         i := freq mod 100;
         fstr := AnsiChar((i div 10) * 16 + (i mod 10));
         freq := freq div 100;
      end;

      i := freq mod 100;
      fstr := fstr + AnsiChar((i div 10) * 16 + (i mod 10));
      freq := freq div 100;

      i := freq mod 100;
      fstr := fstr + AnsiChar((i div 10) * 16 + (i mod 10));
      freq := freq div 100;

      i := freq mod 100;
      fstr := fstr + AnsiChar((i div 10) * 16 + (i mod 10));
      freq := freq div 100;

      i := freq mod 100;
      fstr := fstr + AnsiChar((i div 10) * 16 + (i mod 10));

      fstr := AnsiChar($05) + fstr;
      ICOMWriteData(fstr);
   finally
      FPollingCount := 0;
      FPollingTimer.Enabled := True;
   end;
end;

procedure TRigControl.VisibleChangeEvent(Sender: TObject);
begin
end;

procedure TRigControl.RigTypeChangeEvent(Sender: TObject; RigNumber: Integer);
begin
end;

procedure TRigControl.StatusChangeEvent(Sender: TObject; RigNumber: Integer);
begin
end;

procedure TRigControl.ParamsChangeEvent(Sender: TObject; RigNumber: Integer; Params: Integer);
var
   b: TBand;
   o_RIG: IRigX;
   R: TRig;
   O: TOmniRigX;
begin
   O := TOmniRigX(Sender);
   if O = nil then begin
      Exit;
   end;

   if RigNumber = 1 then begin
      if O.Rig1.Status <> ST_ONLINE then Exit;
      o_RIG := O.Rig1;
      R := FRigs[1];
   end
   else if RigNumber = 2 then begin
      if O.Rig2.Status <> ST_ONLINE then Exit;
      o_RIG := O.Rig2;
      R := FRigs[2];
   end
   else begin
      Exit;
   end;

   case o_RIG.Vfo of
      PM_VFOA:
         R._currentvfo := 0;
      PM_VFOB:
         R._currentvfo := 1;
   end;

   R._currentfreq[0] := o_RIG.FreqA;
   R._currentfreq[1] := o_RIG.FreqB;

   case o_RIG.Mode of
      PM_CW_U, PM_CW_L:
         R._currentmode := mCW;
      PM_SSB_U, PM_SSB_L:
         R._currentmode := mSSB;
      PM_DIG_U, PM_DIG_L:
         R._currentmode := mOther;
      PM_AM:
         R._currentmode := mAM;
      PM_FM:
         R._currentmode := mFM;
   end;

   if R._currentvfo = 0 then begin
      b := dmZLogGlobal.BandPlan.FreqToBand(R._currentfreq[0]);
      if b <> bUnknown then begin
         R._currentband := b;
      end;
      R.FreqMem[R._currentband, R._currentmode] := R._currentfreq[0];
   end;

   if R._currentvfo = 1 then begin
      b := dmZLogGlobal.BandPlan.FreqToBand(R._currentfreq[1]);
      if b <> bUnknown then begin
         R._currentband := b;
      end;
      R.FreqMem[R._currentband, R._currentmode] := R._currentfreq[1];
   end;

   if R.Selected then
      R.UpdateStatus;
end;

procedure TRigControl.CustomReplyEvent(Sender: TObject; RigNumber: Integer; Command, Reply: OleVariant);
begin
end;

constructor TOmni.Create(RigNum: Integer);
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
   FLastFreq := 0;
   FLastMode := _currentmode;

   for B := b19 to b10g do begin
      for M := mCW to mOther do begin
         FreqMem[B, M] := 0;
      end;
   end;

   With MainForm.RigControl do begin
      ZCom1.Disconnect;
      ZCom2.Disconnect;
      FOmniRig.OnVisibleChange := VisibleChangeEvent;
      FOmniRig.OnRigTypeChange := RigTypeChangeEvent;
      FOmniRig.OnStatusChange := StatusChangeEvent;
      FOmniRig.OnParamsChange := ParamsChangeEvent;
      FOmniRig.OnCustomReply := CustomReplyEvent;
//      OmniRig.Connect;
   end;

   if _rignumber = 1 then begin
      Self.name := 'Omni-Rig: ' + MainForm.RigControl.FOmniRig.Rig1.Get_RigType;
   end
   else begin
      Self.name := 'Omni-Rig: ' + MainForm.RigControl.FOmniRig.Rig2.Get_RigType;
   end;
end;

procedure TOmni.Initialize();
begin
//
end;

procedure TOmni.ExecuteCommand(S: AnsiString);
begin
end;

procedure TOmni.ParseBufferString;
begin
end;

procedure TOmni.RitClear;
begin
   Inherited;
   if _rignumber = 1 then begin
      MainForm.RigControl.FOmniRig.Rig1.ClearRit;
   end
   else if _rignumber = 2 then begin
      MainForm.RigControl.FOmniRig.Rig2.ClearRit;
   end;
end;

procedure TOmni.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   o_RIG: IRigX;
begin
   if _rignumber = 1 then begin
      o_RIG := MainForm.RigControl.FOmniRig.Rig1;
   end
   else begin
      o_RIG := MainForm.RigControl.FOmniRig.Rig2;
   end;

   Inherited SetFreq(Hz, fSetLastFreq);

   if _currentvfo = 0 then
      o_RIG.FreqA := Hz
   else
      o_RIG.FreqB := Hz;
end;

procedure TOmni.SetMode(Q: TQSO);
var
   o_RIG: IRigX;
begin
   Inherited SetMode(Q);

   if _rignumber = 1 then begin
      o_RIG := MainForm.RigControl.FOmniRig.Rig1;
   end
   else begin
      o_RIG := MainForm.RigControl.FOmniRig.Rig2;
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
      o_RIG := MainForm.RigControl.FOmniRig.Rig1;
   end
   else begin
      o_RIG := MainForm.RigControl.FOmniRig.Rig2;
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

procedure TOmni.InquireStatus;
begin
   UpdateStatus;
end;

procedure TOmni.UpdateStatus;
var
   _rname: string;
begin
   inherited;
   if _rignumber = 1 then begin
      if MainForm.RigControl.FOmniRig.Rig1.Status <> ST_ONLINE then Exit;
      _rname := MainForm.RigControl.FOmniRig.Rig1.RigType;
   end
   else begin
      if MainForm.RigControl.FOmniRig.Rig2.Status <> ST_ONLINE then Exit;
      _rname := MainForm.RigControl.FOmniRig.Rig2.RigType;
   end;

   MainForm.RigControl.RigLabel.Caption := 'Current rig : ' + IntToStr(MainForm.RigControl.FCurrentRigNumber) + ' Omni-Rig: ' + _rname;
end;

procedure TOmni.Reset;
begin
end;

destructor TOmni.Destroy;
begin
   With MainForm.RigControl do begin
      FOmniRig.OnVisibleChange := nil;
      FOmniRig.OnRigTypeChange := nil;
      FOmniRig.OnStatusChange := nil;
      FOmniRig.OnParamsChange := nil;
      FOmniRig.OnCustomReply := nil;
//      OmniRig.Disconnect();
   end;
   inherited;
end;

procedure TOmni.PassOnRxData(S: AnsiString);
begin
end;

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
   FLastFreq := 0;
   FLastMode := _currentmode;

   for B := b19 to b10g do begin
      for M := mCW to mOther do begin
         FreqMem[B, M] := 0;
      end;
   end;

   Self.name := 'VirtualRig';
end;

procedure TVirtualRig.Initialize();
begin
//
end;

procedure TVirtualRig.ExecuteCommand(S: AnsiString);
begin
   Inherited;
end;

procedure TVirtualRig.ParseBufferString;
begin
   Inherited;
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

procedure TVirtualRig.SetBand(Q: TQSO);
begin
   _currentband := Q.Band;
end;

procedure TVirtualRig.InquireStatus;
begin
   Inherited;
end;

procedure TVirtualRig.SetVFO(i : integer);
begin
   Inherited;
end;

procedure TVirtualRig.Reset;
begin
   Inherited;
end;

destructor TVirtualRig.Destroy;
begin
   inherited;
end;

function dec2hex(i: Integer): Integer;
begin
   if i < 10 then
      Result := i
   else begin
      Result := 16 * (i div 10) + (i mod 10);
   end;
end;

procedure TFT1000MP.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   fstr: AnsiString;
   i, j: TFrequency;
begin
   Inherited SetFreq(Hz, fSetLastFreq);

   i := Hz;
   i := i div 10;

   j := i mod 100;
   fstr := AnsiChar(dec2hex(j));
   i := i div 100;

   j := i mod 100;
   fstr := fstr + AnsiChar(dec2hex(j));
   i := i div 100;

   j := i mod 100;
   fstr := fstr + AnsiChar(dec2hex(j));
   i := i div 100;

   j := i mod 100;
   fstr := fstr + AnsiChar(dec2hex(j));
   // i := i div 100;

   fstr := fstr + AnsiChar($0A);

   WriteData(fstr);
end;

procedure TTS690.ExecuteCommand(S: AnsiString);
var
   Command: AnsiString;
   strTemp: string;
   i: TFrequency;
   aa: Integer;
   M: TMode;
   b: TBand;
begin
   // RigControl.label1.caption := S;
   if length(S) < 2 then begin
      Exit;
   end;

   Command := S[1] + S[2];

   if (Command = 'FA') or (Command = 'FB') then begin
      if Command = 'FA' then
         aa := 0
      else
         aa := 1;

      strTemp := string(Copy(S, 3, 11));
      i := StrToIntDef(strTemp, 0);
      _currentfreq[aa] := i;
      i := i + _freqoffset; // transverter

      if _currentvfo = aa then begin
         UpdateFreqMem(aa, _currentfreq[aa]);
      end;

      if Selected then
         UpdateStatus;
   end;

   if (Command = 'FT') or (Command = 'FR') then begin // 2.1j
      if S[3] = '0' then
         aa := 0
      else if S[3] = '1' then
         aa := 1
      else
         Exit;

      _currentvfo := aa;

      UpdateFreqMem(aa, _currentfreq[aa]);

      if Selected then
         UpdateStatus;
   end;

   if Command = 'IF' then begin
      if length(S) < 38 then
         Exit;

      case S[31] of
         '0':
            _currentvfo := 0;
         '1':
            _currentvfo := 1;
         // '2' : memory
      end;

      strTemp := string(copy(S, 3, 11));
      i := StrToIntDef(strTemp, 0);
      _currentfreq[_currentvfo] := i;
      i := i + _freqoffset; // transverter

      b := dmZLogGlobal.BandPlan.FreqToBand(i);
      if b <> bUnknown then begin
         _currentband := b;
      end;

      case S[30] of
         '1', '2': begin
            M := mSSB;
         end;

         '3': begin
            M := mCW;
            _CWR := False;
         end;

         '7': begin
            M := mCW;
            _CWR := True;
         end;

         '4': begin
            M := mFM;
         end;

         '5': begin
            M := mAM;
         end;

         '6', '8': begin
            M := mRTTY;
         end;

         else begin
            M := mOther;
         end;
      end;
      _currentmode := M;

      FreqMem[_currentband, _currentmode] := _currentfreq[_currentvfo];

      // RIT/XIT offset
      strTemp := string(Copy(S, 19, 5));
      FRitOffset := StrToIntDef(strTemp, 0);

      // RIT Status
      strTemp := string(Copy(S, 24, 1));
      FRit := StrToBoolDef(strTemp, False);

      // XIT Status
      strTemp := string(Copy(S, 25, 1));
      FXit := StrToBoolDef(strTemp, False);

      if Selected then begin
         UpdateStatus;
      end;
   end;

   if Command = 'MD' then begin
      case S[3] of
         '1', '2':
            M := mSSB;
         '3': begin
               M := mCW;
               _CWR := False;
            end;
         '7': begin
               M := mCW;
               _CWR := True;
            end;
         '4':
            M := mFM;
         '5':
            M := mAM;
         '6', '8':
            M := mRTTY;
         else
            M := mOther;
      end;
      _currentmode := M;
      FreqMem[_currentband, _currentmode] := _currentfreq[_currentvfo];
      if Selected then
         UpdateStatus;
   end;

   if Command = 'FS' then begin
      if S[3] = '1' then begin
         FFineStep := True;
      end
      else begin
         FFineStep := False;
      end;
   end;
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
         _currentmode := M;

         UpdateFreqMem(aa, i);
      end;

      if Selected then
         UpdateStatus;
   end;
end;

procedure TICOM.ExecuteCommand(S: AnsiString);
var
   Command: byte;
   temp: byte;
   freq, i1, i2, i3, i4, i5: TFrequency;
   M: TMode;
   ss: AnsiString;
   Index: Integer;
begin
   ss := S;

   // プリアンブルチェック
   Index := pos(AnsiChar($FE) + AnsiChar($FE), ss);
   if Index = 0 then begin
      Exit;
   end;

   // プリアンブル以前のゴミデータ削除
   if Index > 1 then begin
      Delete(ss, 1, Index - 1);
   end;

   // 最低６バイト必要
   if Length(ss) < 6 then begin
      Exit;
   end;

   // 宛先アドレスチェック
   if not(Ord(ss[3]) in [0, FMyAddr]) then begin
      Exit;
   end;

   // 送信元アドレスチェック
   if ss[4] <> AnsiChar(FRigAddr) then begin
      Exit;
   end;

   try
      // プリアンブル、宛先アドレス、送信元アドレス削除
      Delete(ss, 1, 4);

      // ポストアンブル削除
      Delete(ss, length(ss), 1);

      // コマンド取りだし
      Command := Ord(ss[1]);

      if Length(ss) = 1 then begin
         case Command of
            // NG
            $FA: begin
               Exit;
            end;

            // OK
            $FB: begin
               Exit;
            end;
         end;
         Exit;
      end;

      case Command of
         $01, $04: begin
            temp := Ord(ss[2]);
            case temp of
               0, 1:
                  M := mSSB;
               3, 7:
                  M := mCW;
               5, 6:
                  M := mFM;
               2:
                  M := mAM;
               4, 8:
                  M := mRTTY;
               else
                  M := mOther;
            end;
            _currentmode := M;

            if length(ss) >= 3 then begin
               if Ord(ss[3]) in [1 .. 3] then begin
                  ModeWidth[M] := Ord(ss[3]); // IF width
               end;
            end;

            // 処理タイミングによって、_currentfreqと_currentbandの食い違いが起きるので
            // 一致している場合にFreqMemを更新する
            if dmZLogGlobal.BandPlan.FreqToBand(_currentfreq[_currentvfo]) = _currentband then begin
               FreqMem[_currentband, _currentmode] := _currentfreq[_currentvfo];
            end;

            if Selected then begin
               UpdateStatus;
            end;
         end;

         $00, $03: begin
            if length(ss) < 4 then begin
               Exit;
            end;

            Delete(ss, 1, 1);

            {$IFDEF DEBUG}
            OutputDebugString(PChar(
            IntToHex(Ord(ss[5])) + ' ' +
            IntToHex(Ord(ss[4])) + ' ' +
            IntToHex(Ord(ss[3])) + ' ' +
            IntToHex(Ord(ss[2])) + ' ' +
            IntToHex(Ord(ss[1]))
            ));
            {$ENDIF}

            i1 := (Ord(ss[1]) mod 16) + (Ord(ss[1]) div 16) * 10;
            i2 := (Ord(ss[2]) mod 16) + (Ord(ss[2]) div 16) * 10;
            i3 := (Ord(ss[3]) mod 16) + (Ord(ss[3]) div 16) * 10;
            i4 := (Ord(ss[4]) mod 16) + (Ord(ss[4]) div 16) * 10;

            if length(ss) = 5 then begin
               i5 := (Ord(ss[5]) mod 16) + (Ord(ss[5]) div 16) * 10;
            end
            else begin
               i5 := 0;
            end;

            freq := i1 + 100 * i2 + 10000 * i3 + 1000000 * i4 + 100000000 * i5;
            _currentfreq[_currentvfo] := freq;
            freq := freq + _freqoffset;

            UpdateFreqMem(_currentvfo, freq);

            if Selected then begin
               UpdateStatus;
            end;
         end;
      end;
   finally
      // 応答確認無しならここでポーリング再開
      if dmZLogGlobal.Settings._icom_strict_ack_response = False then begin
         StartPolling();
      end;

      // 応答待ち終了
      FWaitForResponse := False;
   end;
end;

function hex2dec(i: Integer): Integer;
begin
   Result := (i div 16) * 10 + (i mod 16);
end;

procedure TFT100.ExecuteCommand(S: AnsiString);
var
   i: TFrequency;
   M: TMode;
begin
   try
      if length(S) = WaitSize then begin
         case Ord(S[6]) and $7 of
            0, 1:
               M := mSSB;
            2, 3:
               M := mCW;
            4:
               M := mAM;
            6, 7:
               M := mFM;
            5:
               M := mRTTY;
            else
               M := mOther;
         end;
         _currentmode := M;

         i := Ord(S[2]) * 256 * 256 * 256 + Ord(S[3]) * 256 * 256 + Ord(S[4]) * 256 + Ord(S[5]);
         i := round(i * 1.25);
         _currentfreq[0] := i;
         i := Ord(S[18]) * 256 * 256 * 256 + Ord(S[19]) * 256 * 256 + Ord(S[20]) * 256 + Ord(S[21]);
         i := round(i * 1.25);
         _currentfreq[1] := i;

         i := _currentfreq[_currentvfo] + _freqoffset;

         UpdateFreqMem(0, i);
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT100.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      WriteData(_nil3 + AnsiChar(0) + AnsiChar($05))
   else
      WriteData(_nil3 + AnsiChar(1) + AnsiChar($05));
   if Selected then
      UpdateStatus;
end;

procedure TFT100.RitClear;
begin
   Inherited;
end;

procedure TFT920.ExecuteCommand(S: AnsiString);
var
   i: TFrequency;
   M: TMode;
begin
   try
      if length(S) = 28 then begin
         if _currentvfo = 0 then
            i := Ord(S[8])
         else
            i := Ord(S[8 + 14]);

         case i and $07 of
            0:
               M := mSSB;
            1:
               M := mCW;
            2:
               M := mAM;
            3:
               M := mFM;
            4, 5:
               M := mRTTY;
            else
               M := mOther;
         end;
         _currentmode := M;

         i := Ord(S[2]) * 256 * 256 * 256 + Ord(S[3]) * 256 * 256 + Ord(S[4]) * 256 + Ord(S[5]);
         // i := round(i / 1.60);
         _currentfreq[0] := i;
         i := i + _freqoffset;

         if _currentvfo = 0 then begin
            UpdateFreqMem(0, i);
         end;

         i := Ord(S[16]) * 256 * 256 * 256 + Ord(S[17]) * 256 * 256 + Ord(S[18]) * 256 + Ord(S[19]);
         // i := round(i / 1.60);
         _currentfreq[1] := i;
         i := i + _freqoffset;

         if _currentvfo = 1 then begin
            UpdateFreqMem(1, i);
         end;
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT1000MP.ExecuteCommand(S: AnsiString);
var
   i: TFrequency;
   M: TMode;
begin
   try
      if length(S) = 32 then begin
         if _currentvfo = 0 then
            i := Ord(S[8])
         else
            i := Ord(S[8 + 16]);

         case i of
            0, 1:
               M := mSSB;
            2:
               M := mCW;
            3:
               M := mAM;
            4:
               M := mFM;
            5:
               M := mRTTY;
            else
               M := mOther;
         end;
         _currentmode := M;

         i := Ord(S[2]) * 256 * 256 * 256 + Ord(S[3]) * 256 * 256 + Ord(S[4]) * 256 + Ord(S[5]);
         i := round(i / 1.60);
         _currentfreq[0] := i;
         i := i + _freqoffset;

         if _currentvfo = 0 then begin
            UpdateFreqMem(0, i);
         end;

         i := Ord(S[18]) * 256 * 256 * 256 + Ord(S[19]) * 256 * 256 + Ord(S[20]) * 256 + Ord(S[21]);
         i := round(i / 1.60);
         _currentfreq[1] := i;
         i := i + _freqoffset;

         if _currentvfo = 1 then begin
            UpdateFreqMem(1, i);
         end;
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT847.ExecuteCommand(S: AnsiString);
var
   i: TFrequency;
   M: TMode;
begin
   try
      {$IFDEF DEBUG}
      // 7.035.0 CWの場合
      // 00 70 35 00 02 と受信するはず
      OutputDebugString(PChar('FT847 受信電文長=' + IntToStr(Length(S))));
      OutputDebugString(PChar(
      IntToHex(Ord(S[1])) + ' ' +
      IntToHex(Ord(S[2])) + ' ' +
      IntToHex(Ord(S[3])) + ' ' +
      IntToHex(Ord(S[4])) + ' ' +
      IntToHex(Ord(S[5]))
      ));
      {$ENDIF}

      if length(S) = WaitSize then begin
         case Ord(S[5]) mod 16 of // ord(S[5]) and $7?
            0, 1:
               M := mSSB;
            2, 3:
               M := mCW;
            4:
               M := mAM;
            8:
               M := mFM;
            else
               M := mOther;
         end;
         _currentmode := M;

         i := (Ord(S[1]) div 16) * 100000000 +
              (Ord(S[1]) mod 16) * 10000000 +
              (Ord(S[2]) div 16) * 1000000 +
              (Ord(S[2]) mod 16) * 100000 +
              (Ord(S[3]) div 16) * 10000 +
              (Ord(S[3]) mod 16) * 1000 +
              (Ord(S[4]) div 16) * 100 +
              (Ord(S[4]) mod 16) * 10;
         _currentfreq[_currentvfo] := i;
         i := i + _freqoffset;

         UpdateFreqMem(0, i);
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT847.RitClear;
begin
   Inherited;
end;

procedure TFT847.SetVFO(i: Integer);
begin
end;

procedure TFT847.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   fstr: AnsiString;
   i, j: TFrequency;
begin
   Inherited SetFreq(Hz, fSetLastFreq);

   i := Hz;
   i := i div 10;

   j := i mod 100;
   fstr := AnsiChar(dec2hex(j));
   i := i div 100;

   j := i mod 100;
   fstr := AnsiChar(dec2hex(j)) + fstr;
   i := i div 100;

   j := i mod 100;
   fstr := AnsiChar(dec2hex(j)) + fstr;
   i := i div 100;

   j := i mod 100;
   fstr := AnsiChar(dec2hex(j)) + fstr;
   // i := i div 100;

   fstr := fstr + AnsiChar($01);

   WriteData(fstr);
end;

procedure TFT847.SetMode(Q: TQSO);
var
   Command: AnsiString;
   para: byte;
begin
   Inherited SetMode(Q);

   case Q.Mode of
      mSSB:
         if Q.Band <= b7 then
            para := 0
         else
            para := 1;
      mCW:
         para := 2;
      mFM:
         para := 8;
      mAM:
         para := 4;
      else
         para := 0;
   end;

   Command := AnsiChar(para) + _nil3 + AnsiChar($07);
   WriteData(Command);
end;

procedure TFT817.Initialize();
begin
   FUseCatOnCommand := False;
   Fchange := False;
   Inherited;
end;


procedure TFT817.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
begin
   Inherited SetFreq(Hz, fSetLastFreq);

   FPollingTimer.Enabled := False;
   Fchange := True;
   sleep(130);    //waitがないとコマンド連投時に後のコマンドが欠落する
   FPollingTimer.Enabled := True;
end;

procedure TFT817.SetMode(Q: TQSO);
begin
   Inherited SetMode(Q);

   FPollingTimer.Enabled := False;
   Fchange := True;
   sleep(130);  //waitがないとコマンド連投時に後のコマンドが欠落する
   FPollingTimer.Enabled := True;
end;

//   FT-991対応
//  基本はFT-2000と同じ。違いは下記。
//  FT-991の周波数桁数は9桁。なのでmode情報は、1文字後ろへ。
//  rigの状態取得と周波数変更の2点をoverride
//
procedure TFT991.ExecuteCommand(S: AnsiString);
var
   M: TMode;
   i: Integer;
   strTemp: string;
begin
   try
      if Length(S) <> 28 then begin   //全長28文字
         Exit;
      end;

      // モード
      strTemp := string(S[22]);      //22文字目
      case StrToIntDef(strTemp, 99) of
         1, 2: M := mSSB;
         3, 7: M := mCW;
         4:    M := mFM;
         5:    M := mAM;
         6, 9: M := mRTTY;
         else  M := mOther;
      end;
      _currentmode := M;

      // 周波数(Hz)
      strTemp := string(Copy(S, 6, 9));        // 6桁目から9文字
      i := StrToIntDef(strTemp, 0);
      _currentfreq[0] := i;

      // バンド(VFO-A)
      if _currentvfo = 0 then begin
         UpdateFreqMem(0, i);
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT991.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
const
   cmd: array[0..1] of AnsiString = ( 'FA', 'FB' );
var
   freq: AnsiString;
begin
   Inherited SetFreq(Hz, fSetLastFreq);

   freq := AnsiStrings.RightStr(AnsiString(DupeString('0', 9)) + AnsiString(IntToStr(Hz)), 9);  // freq 9桁
   WriteData(cmd[_currentvfo] + freq + ';');
end;

//
// CLAR
//        0 1  2  3  4  5  6  7  8  9 10
// SET    C F P1 P2 P3 P4 P5 P6 P7 P8 ;
// READ   C F P1 P2 P3;
// ANSWER C F P1 P2 P3 P4 P5 P6 P7 P8 ;
// P1: 0:MAIN 1:SUB
// P2: 0:固定
// P3: 0:CLAR設定 1:CLAR周波数
// P3 = 0
//     P4: 0:RX CLAR OFF 1:RX CLAR ON
//     P5: 0:TX CLAR OFF 1:TX CLAR ON
//     P6-P8: 0(固定)
// P3 = 1
//     P4: +:プラスシフト
//         -:マイナスシフト
//     P5-P8: 0000-9999Hz
//
procedure TFT710.RitClear;
begin
   Inherited;
   WriteData('CF001+0000;');
end;

procedure TFT710.SetRit(flag: Boolean);
begin
   Inherited;
   if flag = True then begin
      WriteData('CF00010000;');
   end
   else begin
      WriteData('CF00000000;');
   end;
end;

procedure TFT710.SetXit(flag: Boolean);
begin
   Inherited;
   if flag = True then begin
      WriteData('CF00001000;');
   end
   else begin
      WriteData('CF00000000;');
   end;
end;

procedure TFT710.SetRitOffset(offset: Integer);
var
   CMD: AnsiString;
begin
   if FRitOffset = offset then begin
      Exit;
   end;

   if offset = 0 then begin
      WriteData('CF001+0000;');
   end
   else if offset < 0 then begin
      WriteData('CF001+0000;');
      CMD := AnsiString('CF001-' + RightStr('0000' + IntToStr(Abs(offset)), 4) + ';');
      WriteData(CMD);
   end
   else if offset > 0 then begin
      WriteData('CF001+0000;');
      CMD := AnsiString('CF001+' + RightStr('0000' + IntToStr(Abs(offset)), 4) + ';');
      WriteData(CMD);
   end;

   Inherited;
end;

procedure TFT710.AntSelect(no: Integer);
begin
//
end;

procedure TRig.UpdateStatus;
var
   S: string;
begin
   MainForm.RigControl.dispVFO.Caption := VFOString[_currentvfo];
   if _currentmode <> CurrentQSO.Mode then begin
      MainForm.UpdateMode(_currentmode);
   end;

   MainForm.RigControl.dispMode.Caption := ModeString[_currentmode];
   if _currentband <> CurrentQSO.Band then begin
      MainForm.UpdateBand(_currentband);
   end;

   MainForm.RigControl.UpdateFreq(_currentvfo,
                                  _freqoffset + _currentfreq[0],
                                  _freqoffset + _currentfreq[1],
                                  _freqoffset + FLastFreq,
                                  CurrentQSO.Band,
                                  CurrentQSO.Mode);

   S := 'R' + IntToStr(_rignumber) + ' ' + 'V';
   if _currentvfo = 0 then begin
      S := S + 'A';
   end
   else begin
      S := S + 'B';
   end;

   MainForm.StatusLine.Panels[1].Text := S;

   MainForm.BandScopeMarkCurrentFreq(_currentband, _freqoffset + _currentfreq[_currentvfo]);
end;

procedure TRigControl.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if MainForm.TaskBarList <> nil then begin
      MainForm.TaskBarList.DeleteTab(Self.Handle);
   end;
end;

procedure TRigControl.FormCreate(Sender: TObject);
var
   B: TBand;
begin
   RigLabel.Caption := '';
   FCurrentRig := nil;
   FRigs[1] := nil;
   FRigs[2] := nil;
   FRigs[3] := nil;
   FPrevVfo[0] := 0;
   FPrevVfo[1] := 0;
   FOnVFOChanged := nil;
   FFreqLabel[0] := dispFreqA;
   FFreqLabel[1] := dispFreqB;

   FCurrentRigNumber := 1;
   FMaxRig := 3;

   for B := b19 to HiBand do begin
      TempFreq[B] := 0;
   end;

   FOmniRig := TOmniRigX.Create(Self);
end;

procedure TRigControl.FormDestroy(Sender: TObject);
begin
   FCurrentRig := nil;
   Stop();
end;

procedure TRigControl.Button1Click(Sender: TObject);
begin
   if FCurrentRig <> nil then begin
      FCurrentRig.Reset;
   end;
end;

procedure TRigControl.buttonJumpLastFreqClick(Sender: TObject);
begin
   if FCurrentRig <> nil then begin
      FCurrentRig.MoveToLastFreq();
   end;

   MainForm.CallsignEdit.SetFocus;
   MainForm.SetLastFocus();
end;

procedure TRigControl.Timer1Timer(Sender: TObject);
begin
   Timer1.Enabled := False;
   try
      MainForm.ZLinkForm.SendRigStatus;
   finally
      Timer1.Enabled := True;
   end;
end;

procedure TRigControl.PollingTimerTimer(Sender: TObject);
var
   nRigNo: Integer;
begin
   nRigNo := TTimer(Sender).Tag;
   FRigs[nRigNo].PollingProcess();
end;

procedure TRigControl.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

procedure TRigControl.FormShow(Sender: TObject);
begin
   if MainForm.TaskbarList <> nil then begin
      MainForm.TaskBarList.AddTab(Self.Handle);
      MainForm.TaskBarList.ActivateTab(Self.Handle);
   end;
end;

procedure TRigControl.ZCom1ReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: Cardinal);
var
   i: Integer;
   ptr: PAnsiChar;
   str: AnsiString;
   n: Integer;
begin
   str := '';
   ptr := PAnsiChar(DataPtr);

   for i := 0 to DataSize - 1 do begin
      str := str + AnsiChar(ptr[i]);
   end;

   n := TCommPortDriver(Sender).Tag;
   if (n >= Low(FRigs)) and (n <= High(FRigs)) then begin
      if Assigned(FRigs[n]) then begin
         FRigs[n].PassOnRxData(str)
      end;
   end;
end;

procedure TRigControl.btnOmniRigClick(Sender: TObject);
begin
   MainForm.RigControl.FOmniRig.DialogVisible := True;
end;

procedure TRigControl.SetSendFreq();
var
   sec: Integer;
begin
   sec := dmZLogGlobal.Settings._send_freq_interval;

   Timer1.Interval := sec * 1000;
   Timer1.Enabled := False;

   if sec = 0 then begin
      exit;
   end;

   if FRigs[1] <> nil then begin
      if dmZLogGlobal.Settings._zlinkport <> 0 then begin
         Timer1.Enabled := True;
      end;
   end;
end;

procedure TRigControl.UpdateFreq(currentvfo, VfoA, VfoB, Last: TFrequency; b: TBand; m: TMode);
var
   vfo: array[0..1] of Integer;
begin
   vfo[0] := VfoA;
   vfo[1] := VfoB;

   if Abs(FPrevVfo[currentvfo] - vfo[currentvfo]) > 20 then begin
      if Assigned(FOnVFOChanged) then begin
         FOnVFOChanged(TObject(currentvfo));
      end;
   end;

   dispFreqA.Caption := kHzStr(VfoA) + ' kHz';
   dispFreqB.Caption := kHzStr(VfoB) + ' kHz';
   dispLastFreq.Caption := kHzStr(Last) + ' kHz';
   FPrevVfo[0] := VfoA;
   FPrevVfo[1] := VfoB;

   if dmZLogGlobal.BandPlan.IsInBand(b, m, vfo[currentvfo]) = True then begin
      FFreqLabel[currentvfo].Font.Color := clBlack;
   end
   else begin
      FFreqLabel[currentvfo].Font.Color := clRed;
   end;

   if currentvfo = 0 then begin
      FFreqLabel[0].Font.Style := [fsBold];
      FFreqLabel[1].Font.Style := [];
   end
   else begin
      FFreqLabel[0].Font.Style := [];
      FFreqLabel[1].Font.Style := [fsBold];
   end;
end;

procedure TRigControl.SetRit(fOnOff: Boolean);
begin
   if Rig = nil then begin
      Exit;
   end;

   Rig.Rit := fOnOff;
end;

procedure TRigControl.SetXit(fOnOff: Boolean);
begin
   if Rig = nil then begin
      Exit;
   end;

   Rig.Xit := fOnOff;
end;

procedure TRigControl.SetRitOffset(offset: Integer);
begin
   if Rig = nil then begin
      Exit;
   end;

   if offset = 0 then begin
      Rig.RitClear();
   end
   else begin
      Rig.RitOffset := offset;
   end;
end;

end.
