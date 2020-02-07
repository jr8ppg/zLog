unit UzLogGlobal;

interface

uses
  System.SysUtils, System.Classes, StrUtils, IniFiles, Forms, Windows, Menus,
  UzLogKeyer;

type
  TMode = (mCW, mSSB, mFM, mAM, mRTTY, mOther);
  TBand = (b19, b35, b7, b10, b14, b18, b21, b24, b28, b50, b144, b430, b1200, b2400, b5600, b10g);
  TPower = (p001, p002, p005, p010, p020, p025, p050, p100, p200, p500, p1000);

const  HiBand = b10g;

type
  TBandBool = array[b19..HiBand] of boolean;

const
  // SerialContestType
  _USEUTC = 32767;
  _CR = Chr($0d); // carriage return
  _LF = Chr($0a);
  SER_ALL = 1;
  SER_BAND = 2;
  SER_MS = 3;    // separate serial for run/multi stns

const
  RIGNAMEMAX = 51;
  RIGNAMES : array[0..RIGNAMEMAX] of string =
('None',
 'TS-690/450',
 'TS-850',
 'TS-790',
 'TS-2000',
 'TS-2000/P',
 'FT-817',
 'FT-847',
 'FT-920',
 'FT-100',
 'FT-1000',
 'FT-1000MP',
 'MarkV/FT-1000MP',
 'FT-1000MP Mark-V Field',
 'FT-2000',
 'IC-706',
 'IC-706MkII',
 'IC-706MkII-G',
 'IC-721',
 'IC-726',
 'IC-731',
 'IC-736',
 'IC-746',
 'IC-746PRO',
 'IC-7100',
 'IC-7300',
 'IC-7400',
 'IC-7410',
 'IC-750',
 'IC-756',
 'IC-756PRO',
 'IC-756PROII',
 'IC-756PRO3',
 'IC-760',
 'IC-760PRO',
 'IC-775',
 'IC-780',
 'IC-7610',
 'IC-7700',
 'IC-7800',
 'IC-7851',
 'IC-820',
 'IC-821',
 'IC-910',
 'IC-970',
 'IC-9100',
 'IC-9700',
 'IC-275',
 'IC-375',
 'JST-145',
 'JST-245',
 'Omni-Rig');

const maxbank = 3; // bank 3 reserved for rtty
      maxstr = 8;
      maxmaxstr = 12; // f11 and f12 only accessible via zlog.ini

const
  ZLinkHeader = '#ZLOG#';
  actAdd = $0A;
  actDelete = $0D;
  actInsert = $07;
  actEdit = $0E;
  actLock = $AA;
  actUnlock = $BB;

  LineBreakCode : array [0..2] of string
    = (Chr($0d)+Chr($0a), Chr($0d), Chr($0a));
  _sep = '~'; {separator character}

const
  NewPowerString : array[p001..p1000] of string =
                       ('P', 'L', 'M', 'H',  '',  '',  '',  '',  '',  '',  '');

const
  MHzString: array[b19..HiBand] of string = ('1.9','3.5','7','10','14',
                                             '18','21','24','28','50','144',
                                             '430','1200','2400','5600','10G');

  BandString: array[b19..HiBand] of string = ('1.9 MHz','3.5 MHz','7 MHz','10 MHz',
                                             '14 MHz', '18 MHz','21 MHz','24 MHz','28 MHz',
                                             '50 MHz','144 MHz','430 MHz','1200 MHz','2400 MHz',
                                             '5600 MHz','10 GHz & up');

  ADIFBandString : array[b19..HiBand] of string = ('160m','80m','40m','30m',
                                             '20m', '17m','15m','12m','10m',
                                             '6m','2m','70cm','23cm','13cm',
                                             '6cm','3cm');

  ModeString : array[mCW..mOther] of string = ('CW','SSB','FM','AM','RTTY','Other');

  pwrP = TPower(0);
  pwrL = TPower(1);
  pwrM = TPower(2);
  pwrH = TPower(3);

type
  TQSOData = record
    Time : TDateTime;
    CallSign : string[12];  {13 bytes}
    NrSent : string[30];
    NrRcvd : string[30];
    RSTSent : Smallint;//word;  {2 bytes}
    RSTRcvd : word;
    Serial : integer;  {4 bytes ?}
    Mode : TMode;  {1 byte}
    Band : TBand;  {1 byte}
    Power : TPower; {1 byte}
    Multi1 : string[30];
    Multi2 : string[30];
    NewMulti1 : boolean;
    NewMulti2 : boolean;
    Points : byte;
    Operator : string[14]; {Operator's name}
    Memo : string[64]; {max 64 char = 65 bytes}
    CQ : boolean; {not used yet}
    Dupe : boolean;
    Reserve : byte; {used for z-link commands}
    TX : byte; {Transmitter number for 2 TX category}
    Power2 : integer; {used by ARRL DX side only}
    Reserve2 : integer; { $FF when forcing to log}
    Reserve3 : integer; {QSO ID#}
                        {TTSSSSRRCC   TT:TX#(00-21) SSSS:Serial counter
                                      RR:Random(00-99) CC:Edit counter 00 and up}
  end;

  TQSO = class
    QSO : TQSOData;
    constructor Create;
    procedure IncTime;
    procedure DecTime;
    function SerialStr : string;
    function TimeStr : string;
    function DateStr : string;
    function BandStr : string;
    function ModeStr : string;
    function PowerStr : string;
    function NewPowerStr : string;
    function PointStr : string;
    function RSTStr : string;
    function RSTSentStr : string;
    function PartialSummary(DispDate: boolean) : string;
    function CheckCallSummary : string;
    procedure UpdateTime;
    function zLogALL : string;
    function DOSzLogText : string;
    function DOSzLogTextShort : string;
    function QSOinText : string; {for data transfer}
    procedure TextToQSO(str : string); {convert text to bin}
    function QTCStr : string;
  end;

  TQSOList = class
    Saved : boolean;
    List : TList;
    QueList : TList;
    QueOK : boolean;
    AcceptDifferentMode : Boolean;
    CountHigherPoints : Boolean;
    DifferentModePointer : integer; //points to a qso on a different mode but not dupe
    DupeCheckList : array[b19..HiBand] of TStringList;
    function Year: integer; //returns the year of the 1st qso
    function TotalQSO : integer;
    function TotalPoints : integer;
    function TotalCW : integer;
    function TotalMulti1 : integer;
    function TotalMulti2 : integer;
    constructor Create(memo : string);
    destructor Destroy; override;
    procedure Add(aQSO : TQSO);
    procedure Delete(i : integer);
    procedure Insert(i : integer; aQSO : TQSO);
    procedure SaveToFile(Filename : string);
    procedure SaveToFilezLogDOSTXT(Filename : string);
    procedure SaveToFilezLogALL(Filename : string);
    procedure SaveToFileByTX(Filename : string);
    procedure LoadFromFile(Filename : string);
    function IsDupe(aQSO : TQSO) : integer;
    function IsDupe2(aQSO : TQSO; index : integer; var dupeindex : integer) : boolean;
    procedure AddQue(aQSO : TQSO);
    procedure ProcessQue;
    procedure Clear; // deletes all QSOs without destroying the List. Keeps List[0] intact
    procedure SortByTime;
    function ContainBand : TBandBool;
    procedure SetDupeFlags;
    procedure DeleteBand(B : TBand);
    function CheckQSOID(i : integer) : boolean;
    procedure RebuildDupeCheckList;
    procedure ClearDupeCheckList;
    function QuickDupe(aQSO : TQSO) : TQSO;
    procedure RemoveDupes;
    function OpQSO(OpName : string) : integer;
  end;


type
  TCWSettingsParam = record
    _speed : integer;
    _weight : integer;
    _fixwpm : integer;
    _paddlereverse : boolean;
    _tonepitch : integer;
    _cqmax : integer;
    _cqrepeat : double;
    _FIFO : boolean;
    _interval : integer;
    _paddle : boolean;
    _zero : char;
    _one : char;
    _nine : char;
    CWStrBank : array[1..maxbank,1..maxmaxstr] of string[255]; //bank 3 is for rtty
    CQStrBank : array[0..2] of string[255];
    CurrentBank : integer; {for future use?}
    _spacefactor : word; {factor in % for default space between characters}
    _eispacefactor : word;

  end;

  TCommParam = record
    FHostName: string;
    FPortNumber: Integer;
    FBaudRate: Integer;
    FLineBreak: Integer;
    FLocalEcho: Boolean;
  end;

  TQuickQSY = record
    FUse: Boolean;
    FBand: TBand;
    FMode: TMode;
  end;

  TSettingsParam = record
    _AFSK : boolean; // Use AFSK instead of RTTY for rig control
    _dontallowsameband : boolean; // same band on two rigs?
    _BandData : array[b19..b10g] of byte; {band data output}
    _multiop : integer;  {multi op/ single op}
    _band : integer; {0 = all band; 1 = 1.9MHz 2 = 3.5MHz ...}
    _mode : integer; {0 = Ph/CW; 1 = CW; 2=Ph; 3 = Other}
    _contestmenuno : integer; {selected contest in the menu}
    _mycall : string[15];
    _prov : string[15];
    _city : string[50];
    _cqzone : string[3];
    _iaruzone : string[3];
    _sendfreq : double;

    _autobandmap: boolean;
    _activebands : array[b19..HiBand] of boolean;
    CW : TCWSettingsParam;
    _clusterport : integer; {0 : none 1-4 : com# 5 : telnet}

    _rigport:  array[1..2] of Integer; {0 : none 1-4 : com#}
    _rigspeed: array[1..2] of Integer;
    _rigname:  array[1..2] of Integer;

    _use_transceive_mode: Boolean;
    _polling_interval: Integer;

    _zlinkport : integer; {0 : none 1-4 : com# 5: telnet}
    _clusterbaud : integer; {}

    _cluster_telnet: TCommParam;
    _cluster_com: TCommParam;
    _zlink_telnet: TCommParam;

    _multistationwarning : boolean; // true by default. turn off not new mult warning dialog
    _lptnr : integer; {1 : LPT1; 2 : LPT2;  11:COM1; 12 : COM2;  21: USB}
    _sentstr : string; {exchanges sent $Q$P$O etc. Set at menu select}

    _backuppath : string;
    _cfgdatpath : string;
    _logspath : string;

    _pttenabled : boolean;
    _pttbefore : word;
    _pttafter  : word;
    _txnr : byte;
    _pcname : string;
    _saveevery : word;
    _scorecoeff : extended;
    _age : string[3]; // all asian
    _allowdupe : boolean;
    _countdown : boolean;
    _qsycount : boolean;

    _sameexchange : boolean; //true if exchange is same for all bands. false if serial etc.
    _entersuperexchange : boolean;
    _jmode : boolean;
    _mainfontsize : integer;
    _mainrowheight : integer;
    //_updatetimeonenter : boolean;
    _ritclear : boolean; // clear rit after each qso
    _searchafter : integer; // 0 default. for super / partial check
    _banddatamode : integer; // 0 : none, 1 : radio1, 2 : radio2, 3 : active
    _savewhennocw : boolean; // def=false. save when cw is not being sent
    _multistation : boolean; // warn when logging non-newmulti qso
    _maxsuperhit : integer; // max # qso hit
    _bsexpire : integer; // bandscope expiration time in minutes
    _spotexpire : integer; // spot expiration time in minutes
    _renewbythread : boolean;
    _movetomemo : boolean; // move to memo w/ spacebar when editing past qsos
    _bsminfreqarray : array[b19..HiBand, mCW..mOther] of Integer; // kHz
    _bsmaxfreqarray : array[b19..HiBand, mCW..mOther] of Integer; // kHz
    _recrigfreq : boolean; // record rig freq in memo

    _transverter1 : boolean;
    _transverter2 : boolean;
    _transverteroffset1 : integer;
    _transverteroffset2 : integer;
    _syncserial : boolean; // synchronize serial # over network
    _switchcqsp : boolean; // switch cq/sp modes by shift+F
    _displaydatepartialcheck : boolean;

    _super_check_columns: Integer;

    FQuickQSY: array[1..8] of TQuickQSY;
  end;

var
  DEBUGMODE : boolean = false;
  CONTESTNAME : string = '';

var
  CountDownStartTime : TDateTime = 0.0;
  QSYCount : integer = 0;

var
  UseUTC : boolean = False;

var
  SerialContestType : integer;  // 0 if no serial # or SER_ALL, SER_BAND
  SerialArray : array [b19..HiBand] of integer;  // initialized in TContest.Create;
  SerialArrayTX : array[0..64] of integer;

type
  TdmZLogGlobal = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private 宣言 }
    procedure LoadIniFile; {loads Settings from zlog.ini}
    procedure LoadIniFileBS(ini: TIniFile); // called from loadinifile

    function GetMyCall(): string;
    procedure SetMyCall(s: string);
    function GetBand(): Integer;
    procedure SetBand(b: Integer);
    function GetMode(): Integer;
    procedure SetMode(m: Integer);
    function GetMultiOp(): Integer;
    procedure SetMultiOp(i: Integer);
    function GetContestMenuNo() : Integer;
    procedure SetContestMenuNo(i: Integer);
    function GetSpeed(): Integer;
    procedure SetSpeed(i: Integer);
    function GetFIFO(): Boolean;
    procedure SetFIFO(b: Boolean);
    function GetTXNr(): Byte;
    procedure SetTXNr(i: Byte);
    function GetPTTEnabled(): Boolean;
    function GetRigNameStr(Index: Integer) : string; // returns the selected rig name
    function GetSuperCheckColumns(): Integer;
    procedure SetSuperCheckColumns(v: Integer);
    function GetCQMax(): Integer;
    procedure SetCQMax(i : integer);
    function GetCQRepeat(): Double;
    procedure SetCQRepeat(r : double);
    function GetSendFreq(): Double;
    procedure SetSendFreq(r : double);
    procedure SetPaddle(boo : boolean);      // unuse
public
    { Public 宣言 }
    FCurrentFileName : string;
    FLog : TQSOList;

    CurrentPower : array[b19..HiBand] of TPower;
    CurrentPower2 : array[b19..HiBand] of integer; {Power2 for ARRLDX}
    OpList : TStringList;
    Settings : TSettingsParam;

    procedure SaveCurrentSettings; {saves Settings to zlog.ini}
    procedure ImplementSettings(_OnCreate: boolean);

    property MyCall: string read GetMyCall write SetMyCall;
    property Band: Integer read GetBand write SetBand;
    property Mode: Integer read GetMode write SetMode;
    property MultiOp: Integer read GetMultiOp write SetMultiOp;
    property ContestMenuNo: Integer read GetContestMenuNo write SetContestMenuNo;
    property Speed: Integer read GetSpeed write SetSpeed;
    property FIFO: Boolean read GetFIFO write SetFIFO;
    property TXNr: Byte read GetTXNr write SetTXNr;
    property PTTEnabled: Boolean read GetPTTEnabled;
    property CQMax: Integer read GetCQMax write SetCQMax;
    property CQRepeat: Double read GetCQRepeat write SetCQRepeat;
    property SendFreq: Double read GetSendFreq write SetSendFreq;
    property RigNameStr[Index: Integer]: string read GetRigNameStr;
    property SuperCheckColumns: Integer read GetSuperCheckColumns write SetSuperCheckColumns;

    function GetAge(aQSO : TQSO) : string;
    procedure SetOpPower(var aQSO : TQSO);

    procedure SetWeight(i : integer);
    procedure SetTonePitch(i : integer);
    procedure SetScoreCoeff(E : Extended);

    procedure SetPaddleReverse(boo : boolean);
    procedure ReversePaddle();

    function CWMessage(bank, i : integer) : shortstring;

    procedure ReadWindowState(form: TForm; strWindowName: string = ''; fPositionOnly: Boolean = False);
    procedure WriteWindowState(form: TForm; strWindowName: string = '');
    procedure ReadMainFormState(var X, Y, W, H: integer; var TB1, TB2: boolean);
    procedure WriteMainFormState(X, Y, W, H: integer; TB1, TB2: boolean);

    procedure LoadOpList();
    procedure SaveOpList();

    procedure CreateLog();
    procedure SetLogFileName(filename: string);
  end;

function Log(): TQSOList;
function CurrentFileName(): string;
function Random10 : integer;
function UTCOffset : integer;   //in minutes; utc = localtime + utcoffset
function ContainsDoubleByteChar(S : string) : boolean;
function kHzStr(Hz : integer) : string;
procedure IncEditCounter(var aQSO : TQSO);
function ExtractKenNr(S : string) : string; //extracts ken nr from aja#+power
function ExtractPower(S : string) : string;
function IsSHF(B : TBand) : boolean; // true if b >= 2400MHz
function PartialMatch(A, B : string) : boolean; // true if b matches pattern a
function IsMM(S : string) : boolean; // return true if Marine Mobile S is a callsign
function IsWVE(S : string) : boolean; // returns true if W/VE/KH6/KL7 S is country px NOT callsign
function GetHour(T : TDateTime) : integer;
function CurrentTime : TDateTime; {returns in UTC or local time }
function LowCase(C : Char) : Char;
function OldBandOrd(band : TBand) : integer;
function NotWARC(band : TBand) : boolean;
function SameQSO(aQSO, bQSO : TQSO) : boolean;
function SameQSOID(aQSO, bQSO : TQSO) : boolean;
function StrMore(a, b : string) : boolean; // true if a>b
function PXMore(a, b : string) : boolean; // JA1 > XE
function PXIndex(s : string) : integer; // AA = 0 AB = 1 etc
function PXMoreX(a, b : string) : boolean; // double char index
function HexStrToInt(str : string) : integer;
function Less(x, y : integer): integer;
function More(x, y : integer): integer;
function FillRight(s : string; len : integer) : string;
function FillLeft(s : string; len : integer) : string;
function GetUTC: TDateTime;
function GetContestName(Filename: string) : string;
function CoreCall(call : string) : string;
function UsesCoeff(Filename: string) : boolean;
function SameMode(aQSO, bQSO: TQSO): Boolean;
function SameMode2(aMode, bMode : TMode) : boolean;
procedure CenterWindow(formParent, formChild: TForm);
function Power(base, Power: integer): integer;

function StrToBandDef(strMHz: string; defband: TBand): TBand;
function StrToModeDef(strMode: string; defmode: TMode): TMode;

var
  dmZLogGlobal: TdmZLogGlobal;

implementation

uses
  Main, URigControl, UZLinkForm, UComm, UzLogCW, UClusterTelnetSet, UClusterCOMSet,
  UZlinkTelnetSet;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmZLogGlobal.DataModuleCreate(Sender: TObject);
var
   b: TBand;
begin
   FCurrentFileName := '';
   FLog := nil;
   CreateLog();

   for b := b19 to b10g do begin
      CurrentPower[b] := pwrP;
      CurrentPower2[b] := 500;
   end;

   LoadIniFile;
   Settings.CW.CurrentBank := 1;

   // オペレーターリスト
   OpList := TStringList.Create();
   LoadOpList();
end;

procedure TdmZLogGlobal.DataModuleDestroy(Sender: TObject);
begin
   OpList.Free();
   FLog.Free();
end;

procedure TdmZLogGlobal.LoadIniFileBS(ini: TIniFile);
var
   b: TBand;
   m: TMode;
begin
   Settings._bsminfreqarray[b19, mCW] := ini.ReadInteger('BandScope', '1.9MHzCWmin', 1800);
   Settings._bsminfreqarray[b19, mSSB] := ini.ReadInteger('BandScope', '1.9MHzPHmin', 1800);
   Settings._bsmaxfreqarray[b19, mCW] := ini.ReadInteger('BandScope', '1.9MHzCWmax', 1950);
   Settings._bsmaxfreqarray[b19, mSSB] := ini.ReadInteger('BandScope', '1.9MHzPHmax', 1950);
   Settings._bsminfreqarray[b35, mCW] := ini.ReadInteger('BandScope', '3.5MHzCWmin', 3500);
   Settings._bsminfreqarray[b35, mSSB] := ini.ReadInteger('BandScope', '3.5MHzPHmin', 3500);
   Settings._bsmaxfreqarray[b35, mCW] := ini.ReadInteger('BandScope', '3.5MHzCWmax', 3800);
   Settings._bsmaxfreqarray[b35, mSSB] := ini.ReadInteger('BandScope', '3.5MHzPHmax', 3800);
   Settings._bsminfreqarray[b7, mCW] := ini.ReadInteger('BandScope', '7MHzCWmin', 7000);
   Settings._bsminfreqarray[b7, mSSB] := ini.ReadInteger('BandScope', '7MHzPHmin', 7000);
   Settings._bsmaxfreqarray[b7, mCW] := ini.ReadInteger('BandScope', '7MHzCWmax', 7200);
   Settings._bsmaxfreqarray[b7, mSSB] := ini.ReadInteger('BandScope', '7MHzPHmax', 7200);
   Settings._bsminfreqarray[b10, mCW] := ini.ReadInteger('BandScope', '10MHzCWmin', 10100);
   Settings._bsminfreqarray[b10, mSSB] := ini.ReadInteger('BandScope', '10MHzPHmin', 10100);
   Settings._bsmaxfreqarray[b10, mCW] := ini.ReadInteger('BandScope', '10MHzCWmax', 10150);
   Settings._bsmaxfreqarray[b10, mSSB] := ini.ReadInteger('BandScope', '10MHzPHmax', 10150);
   Settings._bsminfreqarray[b14, mCW] := ini.ReadInteger('BandScope', '14MHzCWmin', 14000);
   Settings._bsminfreqarray[b14, mSSB] := ini.ReadInteger('BandScope', '14MHzPHmin', 14000);
   Settings._bsmaxfreqarray[b14, mCW] := ini.ReadInteger('BandScope', '14MHzCWmax', 14350);
   Settings._bsmaxfreqarray[b14, mSSB] := ini.ReadInteger('BandScope', '14MHzPHmax', 14350);
   Settings._bsminfreqarray[b18, mCW] := ini.ReadInteger('BandScope', '18MHzCWmin', 18060);
   Settings._bsminfreqarray[b18, mSSB] := ini.ReadInteger('BandScope', '18MHzPHmin', 18060);
   Settings._bsmaxfreqarray[b18, mCW] := ini.ReadInteger('BandScope', '18MHzCWmax', 18170);
   Settings._bsmaxfreqarray[b18, mSSB] := ini.ReadInteger('BandScope', '18MHzPHmax', 18170);
   Settings._bsminfreqarray[b21, mCW] := ini.ReadInteger('BandScope', '21MHzCWmin', 21000);
   Settings._bsminfreqarray[b21, mSSB] := ini.ReadInteger('BandScope', '21MHzPHmin', 21000);
   Settings._bsmaxfreqarray[b21, mCW] := ini.ReadInteger('BandScope', '21MHzCWmax', 21450);
   Settings._bsmaxfreqarray[b21, mSSB] := ini.ReadInteger('BandScope', '21MHzPHmax', 21450);
   Settings._bsminfreqarray[b24, mCW] := ini.ReadInteger('BandScope', '24MHzCWmin', 24890);
   Settings._bsminfreqarray[b24, mSSB] := ini.ReadInteger('BandScope', '24MHzPHmin', 24890);
   Settings._bsmaxfreqarray[b24, mCW] := ini.ReadInteger('BandScope', '24MHzCWmax', 24990);
   Settings._bsmaxfreqarray[b24, mSSB] := ini.ReadInteger('BandScope', '24MHzPHmax', 24990);
   Settings._bsminfreqarray[b28, mCW] := ini.ReadInteger('BandScope', '28MHzCWmin', 28000);
   Settings._bsminfreqarray[b28, mSSB] := ini.ReadInteger('BandScope', '28MHzPHmin', 28000);
   Settings._bsmaxfreqarray[b28, mCW] := ini.ReadInteger('BandScope', '28MHzCWmax', 28500);
   Settings._bsmaxfreqarray[b28, mSSB] := ini.ReadInteger('BandScope', '28MHzPHmax', 28500);

   Settings._bsminfreqarray[b50, mCW] := ini.ReadInteger('BandScope', '50MHzCWmin', 50000);
   Settings._bsminfreqarray[b50, mSSB] := ini.ReadInteger('BandScope', '50MHzPHmin', 50000);
   Settings._bsmaxfreqarray[b50, mCW] := ini.ReadInteger('BandScope', '50MHzCWmax', 51000);
   Settings._bsmaxfreqarray[b50, mSSB] := ini.ReadInteger('BandScope', '50MHzPHmax', 51000);
   Settings._bsminfreqarray[b144, mCW] := ini.ReadInteger('BandScope', '144MHzCWmin', 144000);
   Settings._bsminfreqarray[b144, mSSB] := ini.ReadInteger('BandScope', '144MHzPHmin', 144600);
   Settings._bsmaxfreqarray[b144, mCW] := ini.ReadInteger('BandScope', '144MHzCWmax', 145600);
   Settings._bsmaxfreqarray[b144, mSSB] := ini.ReadInteger('BandScope', '144MHzPHmax', 145600);
   Settings._bsminfreqarray[b430, mCW] := ini.ReadInteger('BandScope', '430MHzCWmin', 430000);
   Settings._bsminfreqarray[b430, mSSB] := ini.ReadInteger('BandScope', '430MHzPHmin', 430000);
   Settings._bsmaxfreqarray[b430, mCW] := ini.ReadInteger('BandScope', '430MHzCWmax', 434000);
   Settings._bsmaxfreqarray[b430, mSSB] := ini.ReadInteger('BandScope', '430MHzPHmax', 434000);

   Settings._bsminfreqarray[b1200, mCW] := ini.ReadInteger('BandScope', '1200MHzCWmin', 1294000);
   Settings._bsminfreqarray[b1200, mSSB] := ini.ReadInteger('BandScope', '1200MHzPHmin', 1294600);
   Settings._bsmaxfreqarray[b1200, mCW] := ini.ReadInteger('BandScope', '1200MHzCWmax', 1294500);
   Settings._bsmaxfreqarray[b1200, mSSB] := ini.ReadInteger('BandScope', '1200MHzPHmax', 1295000);
   Settings._bsminfreqarray[b2400, mCW] := ini.ReadInteger('BandScope', '2400MHzCWmin', 2400000);
   Settings._bsminfreqarray[b2400, mSSB] := ini.ReadInteger('BandScope', '2400MHzPHmin', 2400000);
   Settings._bsmaxfreqarray[b2400, mCW] := ini.ReadInteger('BandScope', '2400MHzCWmax', 2410000);
   Settings._bsmaxfreqarray[b2400, mSSB] := ini.ReadInteger('BandScope', '2400MHzPHmax', 2410000);
   Settings._bsminfreqarray[b5600, mCW] := ini.ReadInteger('BandScope', '5600MHzCWmin', 5600000);
   Settings._bsminfreqarray[b5600, mSSB] := ini.ReadInteger('BandScope', '5600MHzPHmin', 5600000);
   Settings._bsmaxfreqarray[b5600, mCW] := ini.ReadInteger('BandScope', '5600MHzCWmax', 5610000);
   Settings._bsmaxfreqarray[b5600, mSSB] := ini.ReadInteger('BandScope', '5600MHzPHmax', 5610000);

   for b := b19 to HiBand do begin
      for m := mFM to mOther do begin
         Settings._bsminfreqarray[b, m] := Settings._bsminfreqarray[b, mSSB];
         Settings._bsmaxfreqarray[b, m] := Settings._bsmaxfreqarray[b, mSSB];
      end;
   end;
end;

procedure TdmZLogGlobal.LoadIniFile;
var
   i: integer;
   b: TBand;
   s: string;
   ini: TIniFile;
   slParam: TStringList;
begin
   slParam := TStringList.Create();
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      // Band Scope
      LoadIniFileBS(ini);

      //
      // Preferences
      //

      // Active bands
      Settings._activebands[b19] := ini.ReadBool('Profiles', 'Active1.9MHz', True);
      Settings._activebands[b35] := ini.ReadBool('Profiles', 'Active3.5MHz', True);
      Settings._activebands[b7] := ini.ReadBool('Profiles', 'Active7MHz', True);
      Settings._activebands[b10] := ini.ReadBool('Profiles', 'Active10MHz', True);
      Settings._activebands[b14] := ini.ReadBool('Profiles', 'Active14MHz', True);
      Settings._activebands[b18] := ini.ReadBool('Profiles', 'Active18MHz', True);
      Settings._activebands[b21] := ini.ReadBool('Profiles', 'Active21MHz', True);
      Settings._activebands[b24] := ini.ReadBool('Profiles', 'Active24MHz', True);
      Settings._activebands[b28] := ini.ReadBool('Profiles', 'Active28MHz', True);
      Settings._activebands[b50] := ini.ReadBool('Profiles', 'Active50MHz', True);
      Settings._activebands[b144] := ini.ReadBool('Profiles', 'Active144MHz', True);
      Settings._activebands[b430] := ini.ReadBool('Profiles', 'Active430MHz', True);
      Settings._activebands[b1200] := ini.ReadBool('Profiles', 'Active1200MHz', True);
      Settings._activebands[b2400] := ini.ReadBool('Profiles', 'Active2400MHz', True);
      Settings._activebands[b5600] := ini.ReadBool('Profiles', 'Active5600MHz', True);
      Settings._activebands[b10g] := ini.ReadBool('Profiles', 'Active10GHz', True);

      // Automatically enter exchange from SuperCheck
      Settings._entersuperexchange := ini.ReadBool('Preferences', 'AutoEnterSuper', False);

      // Display exchange on other bands
      Settings._sameexchange := ini.ReadBool('Preferences', 'SameExchange', False);

      // Multi Station Warning
      Settings._multistationwarning := ini.ReadBool('Preferences', 'MultiStationWarning', True);

      // 10 min count down
      Settings._countdown := ini.ReadBool('Preferences', 'CountDown', False);

      // QSY count / hr
      Settings._qsycount := ini.ReadBool('Preferences', 'QSYCount', False);

      // J-mode
      Settings._jmode := ini.ReadBool('Preferences', 'JMode', False);

      // Allow to log dupes
      Settings._allowdupe := ini.ReadBool('Preferences', 'AllowDupe', False);

      // Save when not sending CW
      Settings._savewhennocw := ini.ReadBool('Preferences', 'SaveWhenNoCW', False);

      // Save every N QSOs
      Settings._saveevery := ini.ReadInteger('Preferences', 'SaveEvery', 3);

      // Back up path
      Settings._backuppath := ini.ReadString('Preferences', 'BackUpPath', '');
      if Settings._backuppath <> '' then begin
         Settings._backuppath := IncludeTrailingPathDelimiter(Settings._backuppath);
      end;

      //
      // Categories
      //

      // Operator
      Settings._multiop := ini.ReadInteger('Categories', 'Operator2', 0);

      // Band
      Settings._band := ini.ReadInteger('Categories', 'Band', 0);

      // Mode
      Settings._mode := ini.ReadInteger('Categories', 'Mode', 0);

      // Prov/State($V)
      Settings._prov := ini.ReadString('Profiles', 'Province/State', '');

      // CITY
      Settings._city := ini.ReadString('Profiles', 'City', '');

      // CQ Zone
      Settings._cqzone := ini.ReadString('Profiles', 'CQZone', '');

      // ITU Zone
      Settings._iaruzone := ini.ReadString('Profiles', 'IARUZone', '');

      // Sent

      // Multi Station
      Settings._multistation := ini.ReadBool('Categories', 'MultiStn', False);

      //
      // CW/RTTY
      //

      // Messages
      Settings.CW.CWStrBank[1, 1] := ini.ReadString('CW', 'F1', 'CQ TEST $M $M TEST');
      Settings.CW.CWStrBank[1, 2] := ini.ReadString('CW', 'F2', '$C 5NN$X');
      Settings.CW.CWStrBank[1, 3] := ini.ReadString('CW', 'F3', 'TU $M TEST');
      Settings.CW.CWStrBank[1, 4] := ini.ReadString('CW', 'F4', 'QSO B4 TU');
      Settings.CW.CWStrBank[1, 5] := ini.ReadString('CW', 'F5', 'NR?');

      for i := 6 to maxstr do begin
         Settings.CW.CWStrBank[1, i] := ini.ReadString('CW', 'F' + IntToStr(i), '');
      end;

      Settings.CW.CWStrBank[3, 1] := ini.ReadString('RTTY', 'F1', 'CQ CQ CQ TEST $M $M $M TEST K');
      Settings.CW.CWStrBank[3, 2] := ini.ReadString('RTTY', 'F2', '$C DE $M 599$X 599$X BK');
      Settings.CW.CWStrBank[3, 3] := ini.ReadString('RTTY', 'F3', 'TU DE $M TEST');
      Settings.CW.CWStrBank[3, 4] := ini.ReadString('RTTY', 'F4', 'QSO B4 TU');
      Settings.CW.CWStrBank[3, 5] := ini.ReadString('RTTY', 'F5', 'NR? NR? AGN BK');

      for i := 6 to maxstr do begin
         Settings.CW.CWStrBank[3, i] := ini.ReadString('RTTY', 'F' + IntToStr(i), '');
      end;

      for i := 1 to maxstr do begin
         Settings.CW.CWStrBank[2, i] := ini.ReadString('CW', 'F' + IntToStr(i) + 'B', '');
      end;

      for i := 11 to 12 do begin
         Settings.CW.CWStrBank[1, i] := ini.ReadString('CW', 'F' + IntToStr(i), '');
         Settings.CW.CWStrBank[2, i] := ini.ReadString('CW', 'F' + IntToStr(i) + 'B', '');
         Settings.CW.CWStrBank[3, i] := ini.ReadString('RTTY', 'F' + IntToStr(i), '');
      end;

      Settings.CW.CQStrBank[1] := ini.ReadString('CW', 'CQ2', '');
      Settings.CW.CQStrBank[2] := ini.ReadString('CW', 'CQ3', '');

      // Switch TAB/; with CW bank
      Settings._switchcqsp := ini.ReadBool('CW', 'CQSP', False);

      // Speed
      Settings.CW._speed := ini.ReadInteger('CW', 'Speed', 25);
      Settings.CW._fixwpm := ini.ReadInteger('CW', 'FixedSpeed', 20);

      // Weight
      Settings.CW._weight := ini.ReadInteger('CW', 'Weight', 50);

      // Paddle enabled
      Settings.CW._paddle := ini.ReadBool('CW', 'PaddleEnabled', True);

      // Paddle reverse
      Settings.CW._paddlereverse := ini.ReadBool('CW', 'PaddleReverse', False);

      // Que messages
      Settings.CW._FIFO := ini.ReadBool('CW', 'FIFO', True);

      // Tone Pitch (Hz)
      Settings.CW._tonepitch := ini.ReadInteger('CW', 'Pitch', 800);

      // CQ max
      Settings.CW._cqmax := ini.ReadInteger('CW', 'CQMax', 15);

      // Abbreviation (019)
      s := ini.ReadString('CW', 'Zero', 'O');
      Settings.CW._zero := char(s[1]);

      s := ini.ReadString('CW', 'One', 'A');
      Settings.CW._one := char(s[1]);

      s := ini.ReadString('CW', 'Nine', 'N');
      Settings.CW._nine := char(s[1]);

      // CQ repeat interval (sec)
      Settings.CW._cqrepeat := ini.ReadFloat('CW', 'CQRepeat', 2.0);

      //
      // Hardware
      //

      // Ports

      // PacketCluster
      Settings._clusterport := ini.ReadInteger('Hardware', 'PacketCluster', 0);

      // COM
      Settings._clusterbaud := ini.ReadInteger('Hardware', 'PacketClusterBaud', 6);
      Settings._cluster_com.FLineBreak := ini.ReadInteger('PacketCluster', 'COMlinebreak', 0);
      Settings._cluster_com.FLocalEcho := ini.ReadBool('PacketCluster', 'COMlocalecho', False);

      // TELNET
      Settings._cluster_telnet.FHostName := ini.ReadString('PacketCluster', 'TELNEThost', '');
      Settings._cluster_telnet.FPortNumber := ini.ReadInteger('PacketCluster', 'TELNETport', 23);
      Settings._cluster_telnet.FLineBreak := ini.ReadInteger('PacketCluster', 'TELNETlinebreak', 0);
      Settings._cluster_telnet.FLocalEcho := ini.ReadBool('PacketCluster', 'TELNETlocalecho', False);

      // Z-Link (Z-Server)
      Settings._zlinkport := ini.ReadInteger('Hardware', 'Z-Link', 0);

      // PC Name
      Settings._pcname := ini.ReadString('Z-Link', 'PCName', '');

      // Sync. SerialNumber
      Settings._syncserial := ini.ReadBool('Z-Link', 'SyncSerial', False);

      // COM(unuse)
//      Settings._zlinklinebreakCOM := ini.ReadInteger('Z-Link', 'COMlinebreak', 0);
//      Settings._zlinklocalechoCOM := ini.ReadBool('Z-Link', 'COMlocalecho', False);

      // TELNET
      Settings._zlink_telnet.FHostName := ini.ReadString('Z-Link', 'TELNEThost', '');
      Settings._zlink_telnet.FLineBreak := ini.ReadInteger('Z-Link', 'TELNETlinebreak', 0);
      Settings._zlink_telnet.FLocalEcho := ini.ReadBool('Z-Link', 'TELNETlocalecho', False);

      // RIG1
      Settings._rigport[1] := ini.ReadInteger('Hardware', 'Rig', 0);
      Settings._rigname[1] := ini.ReadInteger('Hardware', 'RigName', 0);
      Settings._rigspeed[1] := ini.ReadInteger('Hardware', 'RigSpeed', 0);
      Settings._transverter1 := ini.ReadBool('Hardware', 'Transverter1', False);
      Settings._transverteroffset1 := ini.ReadInteger('Hardware', 'Transverter1Offset', 0);

      // RIG2
      Settings._rigport[2] := ini.ReadInteger('Hardware', 'Rig2', 0);
      Settings._rigname[2] := ini.ReadInteger('Hardware', 'RigName2', 0);
      Settings._rigspeed[2] := ini.ReadInteger('Hardware', 'RigSpeed2', 0);
      Settings._transverter2 := ini.ReadBool('Hardware', 'Transverter2', False);
      Settings._transverteroffset2 := ini.ReadInteger('Hardware', 'Transverter2Offset', 0);

      // USE TRANSCEIVE MODE(ICOM only)
      Settings._use_transceive_mode := ini.ReadBool('Hardware', 'UseTransceiveMode', True);

      // Polling Interval
      Settings._polling_interval := ini.ReadInteger('Hardware', 'PollingInterval', 200);

      // CW/PTT port
      Settings._lptnr := ini.ReadInteger('Hardware', 'CWLPTPort', 0);

      // CW PTT control

      // Enable PTT control
      Settings._pttenabled := ini.ReadBool('Hardware', 'PTTEnabled', False);

      // Before TX (ms)
      Settings._pttbefore := ini.ReadInteger('Hardware', 'PTTBefore', 25);

      // After TX paddle/keybd (ms)
      Settings._pttafter := ini.ReadInteger('Hardware', 'PTTAfter', 0);

      //
      // Rig control
      //

      // Band data (LPT)
      Settings._banddatamode := ini.ReadInteger('Rig', 'BandDataMode', 1);

      Settings._BandData[b19] := ini.ReadInteger('Hardware', 'BandData1.9MHz', 0);
      Settings._BandData[b35] := ini.ReadInteger('Hardware', 'BandData3.5MHz', 1);
      Settings._BandData[b7] := ini.ReadInteger('Hardware', 'BandData7MHz', 2);
      Settings._BandData[b10] := ini.ReadInteger('Hardware', 'BandData10MHz', 3);
      Settings._BandData[b14] := ini.ReadInteger('Hardware', 'BandData14MHz', 4);
      Settings._BandData[b18] := ini.ReadInteger('Hardware', 'BandData18MHz', 5);
      Settings._BandData[b21] := ini.ReadInteger('Hardware', 'BandData21MHz', 6);
      Settings._BandData[b24] := ini.ReadInteger('Hardware', 'BandData24MHz', 7);
      Settings._BandData[b28] := ini.ReadInteger('Hardware', 'BandData28MHz', 8);
      Settings._BandData[b50] := ini.ReadInteger('Hardware', 'BandData50MHz', 9);
      Settings._BandData[b144] := ini.ReadInteger('Hardware', 'BandData144MHz', 10);
      Settings._BandData[b430] := ini.ReadInteger('Hardware', 'BandData430MHz', 11);
      Settings._BandData[b1200] := ini.ReadInteger('Hardware', 'BandData1200MHz', 12);
      Settings._BandData[b2400] := ini.ReadInteger('Hardware', 'BandData2400MHz', 13);
      Settings._BandData[b5600] := ini.ReadInteger('Hardware', 'BandData5600MHz', 14);
      Settings._BandData[b10g] := ini.ReadInteger('Hardware', 'BandData10GHz', 15);

      // Clear RIT after each QSO
      Settings._ritclear := ini.ReadBool('Hardware', 'RitClear', False);

      // Do not allow two rigs to be on same band
      Settings._dontallowsameband := ini.ReadBool('Rig', 'DontAllowSameBand', False);

      // Record rig frequency in memo
      Settings._recrigfreq := ini.ReadBool('Rig', 'RecordFreqInMemo', False);

      // Use AFSK mode for RTTY
      Settings._AFSK := ini.ReadBool('Rig', 'UseAFSK', False);

      // Automatically create band scope
      Settings._autobandmap := ini.ReadBool('Rig', 'AutoBandMap', False);

      // Send current freq every
      Settings._sendfreq := ini.ReadFloat('Rig', 'SendFreq', 1.0);

      //
      // Path
      //

      // CFG/DAT
      Settings._cfgdatpath := ini.ReadString('Preferences', 'CFGDATPath', '');
      if Settings._cfgdatpath <> '' then begin
         Settings._cfgdatpath := IncludeTrailingPathDelimiter(Settings._cfgdatpath);
      end;

      // Logs
      Settings._logspath := ini.ReadString('Preferences', 'LogsPath', '');
      if Settings._logspath <> '' then begin
         Settings._logspath := IncludeTrailingPathDelimiter(Settings._logspath);
      end;

      //
      // Misc
      //

      // Start search after
      Settings._searchafter := ini.ReadInteger('Misc', 'SearchAfter', 0);

      // Max super check search
      Settings._maxsuperhit := ini.ReadInteger('Misc', 'MaxSuperHit', 100);

      // Delete band scope data after
      Settings._bsexpire := ini.ReadInteger('Misc', 'BandScopeExpire', 60);

      // Delete spot data after
      Settings._spotexpire := ini.ReadInteger('Misc', 'SpotExpire', 90);

      // Display date in partial check
      Settings._displaydatepartialcheck := ini.ReadBool('Misc', 'DisplayDatePartialCheck', False);

      // Update using a thread
      Settings._renewbythread := ini.ReadBool('Misc', 'UpdateUsingThread', False);

      //
      // ここから隠し設定
      //

      Settings._movetomemo := ini.ReadBool('Preferences', 'MoveToMemoWithSpace', False);

      s := ini.ReadString('Profiles', 'Power', '');
      b := b19;
      if length(s) > 13 then begin
         s := Copy(s, 1, 13);
      end;

      for i := 1 to length(s) do begin
         case UpCase(s[i]) of
            'P':
               CurrentPower[b] := pwrP;
            'L':
               CurrentPower[b] := pwrL;
            'M':
               CurrentPower[b] := pwrM;
            'H':
               CurrentPower[b] := pwrH;
         end;

         repeat
            inc(b);
         until NotWARC(b);
      end;

      Settings._txnr := ini.ReadInteger('Categories', 'TXNumber', 0);
      Settings._contestmenuno := ini.ReadInteger('Categories', 'Contest', 1);
      Settings._mycall := ini.ReadString('Categories', 'MyCall', 'Your call sign');

      Settings.CW._interval := ini.ReadInteger('CW', 'Interval', 1);

//      Settings._specificcwport := ini.ReadInteger('Hardware', 'UseCWPort', 0 { $037A } );

      Settings._mainfontsize := ini.ReadInteger('Preferences', 'FontSize', 9);
      Settings._mainrowheight := ini.ReadInteger('Preferences', 'RowHeight', 18);

      Settings.CW._spacefactor := ini.ReadInteger('CW', 'SpaceFactor', 100);
      Settings.CW._eispacefactor := ini.ReadInteger('CW', 'EISpaceFactor', 100);

      Settings._super_check_columns := ini.ReadInteger('Windows', 'SuperCheckColumns', 0);

      // QuickQSY
      for i := Low(Settings.FQuickQSY) to High(Settings.FQuickQSY) do begin
         slParam.CommaText := ini.ReadString('QuickQSY', '#' + IntToStr(i), '0,,') + ',,,';
         Settings.FQuickQSY[i].FUse := StrToBoolDef(slParam[0], False);
         Settings.FQuickQSY[i].FBand := StrToBandDef(slParam[1], b35);
         Settings.FQuickQSY[i].FMode := StrToModeDef(slParam[2], mSSB);
      end;
   finally
      ini.Free();
      slParam.Free();
   end;
end;

procedure TdmZLogGlobal.SaveCurrentSettings;
var
   i: integer;
   ini: TIniFile;
   slParam: TStringList;
begin
   slParam := TStringList.Create();
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      //
      // Preferences
      //

      // Active bands
      ini.WriteBool('Profiles', 'Active1.9MHz', Settings._activebands[b19]);
      ini.WriteBool('Profiles', 'Active3.5MHz', Settings._activebands[b35]);
      ini.WriteBool('Profiles', 'Active7MHz', Settings._activebands[b7]);
      ini.WriteBool('Profiles', 'Active10MHz', Settings._activebands[b10]);
      ini.WriteBool('Profiles', 'Active14MHz', Settings._activebands[b14]);
      ini.WriteBool('Profiles', 'Active18MHz', Settings._activebands[b18]);
      ini.WriteBool('Profiles', 'Active21MHz', Settings._activebands[b21]);
      ini.WriteBool('Profiles', 'Active24MHz', Settings._activebands[b24]);
      ini.WriteBool('Profiles', 'Active28MHz', Settings._activebands[b28]);
      ini.WriteBool('Profiles', 'Active50MHz', Settings._activebands[b50]);
      ini.WriteBool('Profiles', 'Active144MHz', Settings._activebands[b144]);
      ini.WriteBool('Profiles', 'Active430MHz', Settings._activebands[b430]);
      ini.WriteBool('Profiles', 'Active1200MHz', Settings._activebands[b1200]);
      ini.WriteBool('Profiles', 'Active2400MHz', Settings._activebands[b2400]);
      ini.WriteBool('Profiles', 'Active5600MHz', Settings._activebands[b5600]);
      ini.WriteBool('Profiles', 'Active10GHz', Settings._activebands[b10g]);

      // Automatically enter exchange from SuperCheck
      ini.WriteBool('Preferences', 'AutoEnterSuper', Settings._entersuperexchange);

      // Display exchange on other bands
      ini.WriteBool('Preferences', 'SameExchange', Settings._sameexchange);

      // Multi Station Warning
      ini.WriteBool('Preferences', 'MultiStationWarning', Settings._multistationwarning);

      // 10 min count down
      ini.WriteBool('Preferences', 'CountDown', Settings._countdown);

      // QSY count / hr
      ini.WriteBool('Preferences', 'QSYCount', Settings._qsycount);

      // J-mode
      ini.WriteBool('Preferences', 'JMode', Settings._jmode);

      // Allow to log dupes
      ini.WriteBool('Preferences', 'AllowDupe', Settings._allowdupe);

      // Save when not sending CW
      ini.WriteBool('Preferences', 'SaveWhenNoCW', Settings._savewhennocw);

      // Save every N QSOs
      ini.WriteInteger('Preferences', 'SaveEvery', Settings._saveevery);

      // Back up path
      ini.WriteString('Preferences', 'BackUpPath', Settings._backuppath);

      //
      // Categories
      //

      // Operator
      ini.WriteInteger('Categories', 'Operator2', Settings._multiop);

      // Band
      ini.WriteInteger('Categories', 'Band', Settings._band);

      // Mode
      ini.WriteInteger('Categories', 'Mode', Settings._mode);

      // Prov/State($V)
      ini.WriteString('Profiles', 'Province/State', Settings._prov);

      // CITY
      ini.WriteString('Profiles', 'City', Settings._city);

      // CQ Zone
      ini.WriteString('Profiles', 'CQZone', Settings._cqzone);

      // ITU Zone
      ini.WriteString('Profiles', 'IARUZone', Settings._iaruzone);

      // Sent

      // Multi Station
      ini.WriteBool('Categories', 'MultiStn', Settings._multistation);

      //
      // CW/RTTY
      //

      // Messages
      for i := 1 to maxstr do begin
         ini.WriteString('CW', 'F' + IntToStr(i), Settings.CW.CWStrBank[1, i]);
         ini.WriteString('CW', 'F' + IntToStr(i) + 'B', Settings.CW.CWStrBank[2, i]);
         ini.WriteString('RTTY', 'F' + IntToStr(i), Settings.CW.CWStrBank[3, i]);
      end;

      for i := 11 to 12 do begin
         ini.WriteString('CW', 'F' + IntToStr(i), Settings.CW.CWStrBank[1, i]);
         ini.WriteString('CW', 'F' + IntToStr(i) + 'B', Settings.CW.CWStrBank[2, i]);
         ini.WriteString('RTTY', 'F' + IntToStr(i), Settings.CW.CWStrBank[3, i]);
      end;

      ini.WriteString('CW', 'CQ2', Settings.CW.CQStrBank[1]);
      ini.WriteString('CW', 'CQ3', Settings.CW.CQStrBank[2]);

      // Switch TAB/; with CW bank
      ini.WriteBool('CW', 'CQSP', Settings._switchcqsp);

      // Speed
      ini.WriteInteger('CW', 'Speed', Settings.CW._speed);
      ini.WriteInteger('CW', 'FixedSpeed', Settings.CW._fixwpm);

      // Weight
      ini.WriteInteger('CW', 'Weight', Settings.CW._weight);

      // Paddle enabled
      ini.WriteBool('CW', 'PaddleEnabled', Settings.CW._paddle);

      // Paddle reverse
      ini.WriteBool('CW', 'PaddleReverse', Settings.CW._paddlereverse);

      // Que messages
      ini.WriteBool('CW', 'FIFO', Settings.CW._FIFO);

      // Tone Pitch (Hz)
      ini.WriteInteger('CW', 'Pitch', Settings.CW._tonepitch);

      // CQ max
      ini.WriteInteger('CW', 'CQMax', Settings.CW._cqmax);

      // Abbreviation (019)
      ini.WriteString('CW', 'Zero', Settings.CW._zero);
      ini.WriteString('CW', 'One', Settings.CW._one);
      ini.WriteString('CW', 'Nine', Settings.CW._nine);

      // CQ repeat interval (sec)
      ini.WriteFloat('CW', 'CQRepeat', Settings.CW._cqrepeat);

      //
      // Hardware
      //

      // Ports

      // PacketCluster
      ini.WriteInteger('Hardware', 'PacketCluster', Settings._clusterport);

      // COM
      ini.WriteInteger('Hardware', 'PacketClusterBaud', Settings._clusterbaud);
      ini.WriteInteger('PacketCluster', 'COMlinebreak', Settings._cluster_com.FLineBreak);
      ini.WriteBool('PacketCluster', 'COMlocalecho', Settings._cluster_com.FLocalEcho);

      // TELNET
      ini.WriteString('PacketCluster', 'TELNEThost', Settings._cluster_telnet.FHostName);
      ini.WriteInteger('PacketCluster', 'TELNETport', Settings._cluster_telnet.FPortNumber);
      ini.WriteInteger('PacketCluster', 'TELNETlinebreak', Settings._cluster_telnet.FLineBreak);
      ini.WriteBool('PacketCluster', 'TELNETlocalecho', Settings._cluster_telnet.FLocalEcho);

      // Z-Link (Z-Server)
      ini.WriteInteger('Hardware', 'Z-Link', Settings._zlinkport);

      // PC Name
      ini.WriteString('Z-Link', 'PCName', Settings._pcname);

      // Sync. SerialNumber
      ini.WriteBool('Z-Link', 'SyncSerial', Settings._syncserial);

      // COM(unuse)
//      ini.WriteInteger('Z-Link', 'COMlinebreak', Settings._zlinklinebreakCOM);
//      ini.WriteBool('Z-Link', 'COMlocalecho', Settings._zlinklocalechoCOM);

      // TELNET
      ini.WriteString('Z-Link', 'TELNEThost', Settings._zlink_telnet.FHostName);
      ini.WriteInteger('Z-Link', 'TELNETlinebreak', Settings._zlink_telnet.FLineBreak);
      ini.WriteBool('Z-Link', 'TELNETlocalecho', Settings._zlink_telnet.FLocalEcho);

      // RIG1
      ini.WriteInteger('Hardware', 'Rig', Settings._rigport[1]);
      ini.WriteInteger('Hardware', 'RigName', Settings._rigname[1]);
      ini.WriteInteger('Hardware', 'RigSpeed', Settings._rigspeed[1]);
      ini.WriteBool('Hardware', 'Transverter1', Settings._transverter1);
      ini.WriteInteger('Hardware', 'Transverter1Offset', Settings._transverteroffset1);

      // RIG2
      ini.WriteInteger('Hardware', 'Rig2', Settings._rigport[2]);
      ini.WriteInteger('Hardware', 'RigName2', Settings._rigname[2]);
      ini.WriteInteger('Hardware', 'RigSpeed2', Settings._rigspeed[2]);
      ini.WriteBool('Hardware', 'Transverter2', Settings._transverter2);
      ini.WriteInteger('Hardware', 'Transverter2Offset', Settings._transverteroffset2);

      // USE TRANSCEIVE MODE(ICOM only)
      ini.WriteBool('Hardware', 'UseTransceiveMode', Settings._use_transceive_mode);

      // Polling Interval
      ini.WriteInteger('Hardware', 'PollingInterval', Settings._polling_interval);

      // CW/PTT port
      ini.WriteInteger('Hardware', 'CWLPTPort', Settings._lptnr);

      // CW PTT control

      // Enable PTT control
      ini.WriteBool('Hardware', 'PTTEnabled', Settings._pttenabled);

      // Before TX (ms)
      ini.WriteInteger('Hardware', 'PTTBefore', Settings._pttbefore);

      // After TX paddle/keybd (ms)
      ini.WriteInteger('Hardware', 'PTTAfter', Settings._pttafter);

      //
      // Rig control
      //

      // Band data (LPT)
      ini.WriteInteger('Rig', 'BandDataMode', Settings._banddatamode);

      // Clear RIT after each QSO
      ini.WriteBool('Hardware', 'RitClear', Settings._ritclear);

      // Do not allow two rigs to be on same band
      ini.WriteBool('Rig', 'DontAllowSameBand', Settings._dontallowsameband);

      // Record rig frequency in memo
      ini.WriteBool('Rig', 'RecordFreqInMemo', Settings._recrigfreq);

      // Use AFSK mode for RTTY
      ini.WriteBool('Rig', 'UseAFSK', Settings._AFSK);

      // Automatically create band scope
      ini.WriteBool('Rig', 'AutoBandMap', Settings._autobandmap);

      // Send current freq every
      ini.WriteFloat('Rig', 'SendFreq', Settings._sendfreq);

      //
      // Path
      //

      // CFG/DAT
      ini.WriteString('Preferences', 'CFGDATPath', Settings._cfgdatpath);

      // Logs
      ini.WriteString('Preferences', 'LogsPath', Settings._logspath);

      //
      // Misc
      //

      // Start search after
      ini.WriteInteger('Misc', 'SearchAfter', Settings._searchafter);

      // Max super check search
      ini.WriteInteger('Misc', 'MaxSuperHit', Settings._maxsuperhit);

      // Delete band scope data after
      ini.WriteInteger('Misc', 'BandScopeExpire', Settings._bsexpire);

      // Delete spot data after
      ini.WriteInteger('Misc', 'SpotExpire', Settings._spotexpire);

      // Display date in partial check
      ini.WriteBool('Misc', 'DisplayDatePartialCheck', Settings._displaydatepartialcheck);

      // Update using a thread
      ini.WriteBool('Misc', 'UpdateUsingThread', Settings._renewbythread);

      //
      // ここから隠し設定
      //

      ini.WriteBool('Preferences', 'MoveToMemoWithSpace', Settings._movetomemo);

      ini.WriteInteger('Categories', 'Contest', Settings._contestmenuno);
      ini.WriteInteger('Categories', 'TXNumber', Settings._txnr);
      ini.WriteString('Categories', 'MyCall', Settings._mycall);

      ini.WriteInteger('CW', 'Interval', Settings.CW._interval);

      ini.WriteInteger('Preferences', 'FontSize', Settings._mainfontsize);
      ini.WriteInteger('Preferences', 'RowHeight', Settings._mainrowheight);

      ini.WriteInteger('Windows', 'SuperCheckColumns', Settings._super_check_columns);

      // QuickQSY
      for i := Low(Settings.FQuickQSY) to High(Settings.FQuickQSY) do begin
         slParam.Clear();
         slParam.Add( BoolToStr(Settings.FQuickQSY[i].FUse, False) );
         slParam.Add( MHzString[ Settings.FQuickQSY[i].FBand ]);
         slParam.Add( MODEString[ Settings.FQuickQSY[i].FMode ]);
         ini.WriteString('QuickQSY', '#' + IntToStr(i), slParam.CommaText);
      end;
   finally
      ini.Free();
      slParam.Free();
   end;

   // オペレーターリスト保存
   SaveOpList();
end;

// 設定反映
procedure TdmZLogGlobal.ImplementSettings(_OnCreate: boolean);
var
   m: TMenuItem;
   i, j: integer;
   b: TBand;
begin
   with dmZlogGlobal do begin
      if _OnCreate = False then begin
         for b := b19 to HiBand do begin
            MainForm.BandMenu.Items[ord(b)].Enabled := Settings._activebands[b];
         end;

         if Settings._band > 0 then begin // single band
            Band := Settings._band; // resets the bandmenu.items.enabled for the single band entry
         end;
      end;

      if MyContest <> nil then begin
         Main.MyContest.SameExchange := Settings._sameexchange;
      end;

      RigControl.SetBandMask;

      if Settings._zlinkport in [1 .. 6] then begin // zlinkport rs232c
         // ZLinkForm.Transparent := True;
         // no rs232c anymore
      end;

      CommForm.EnableConnectButton(Settings._clusterport = 7);

      CommForm.ImplementOptions;
      ZLinkForm.ImplementOptions;
      dmZlogKeyer.UseSideTone := False;

      Case Settings._lptnr of
         0: begin
            dmZlogKeyer.KeyingPort := tkpNone;
         end;

         1 .. 20: begin
            RigControl.SetSerialCWKeying(Settings._lptnr);
            dmZlogKeyer.KeyingPort := TKeyingPort(Settings._lptnr);
         end;

         21: begin // usb
            dmZlogKeyer.KeyingPort := tkpUSB;

            if Settings.CW._paddle then begin
               dmZlogKeyer.PaddlePort := $99;   // use
            end
            else begin
               dmZlogKeyer.PaddlePort := $00;   // not use
            end;
         end;
      end;

      dmZlogKeyer.SetPTTDelay(Settings._pttbefore, Settings._pttafter);
      dmZlogKeyer.SetPTT(Settings._pttenabled);

      // SetBand(Settings._band);
      Mode := Settings._mode;
      SetPaddleReverse(Settings.CW._paddlereverse);
      Speed := Settings.CW._speed;
      SetWeight(Settings.CW._weight);
      CQMax := Settings.CW._cqmax;
      CQRepeat := Settings.CW._cqrepeat;
      SendFreq := Settings._sendfreq;
      SetTonePitch(Settings.CW._tonepitch);
      dmZlogKeyer.RandCQStr[1] := SetStr(Settings.CW.CQStrBank[1], CurrentQSO);
      dmZlogKeyer.RandCQStr[2] := SetStr(Settings.CW.CQStrBank[2], CurrentQSO);

      dmZlogKeyer.SpaceFactor := Settings.CW._spacefactor;
      dmZlogKeyer.EISpaceFactor := Settings.CW._eispacefactor;

      if Settings._backuppath = '' then begin
         MainForm.BackUp1.Enabled := False;
      end
      else begin
         MainForm.BackUp1.Enabled := True;
      end;

      if Settings._multistation = True then begin
         Settings._txnr := 2;
      end;

      if not(_OnCreate) then begin
         j := MainForm.OpMenu.Items.Count;
         if j > 0 then begin
            for i := 1 to j do begin
               MainForm.OpMenu.Items.Delete(0);
            end;
         end;

         if OpList.Count > 0 then begin
            m := TMenuItem.Create(Self);
            m.Caption := 'Clear';
            m.OnClick := MainForm.OpMenuClick;
            MainForm.OpMenu.Items.Add(m);
            for i := 0 to OpList.Count - 1 do begin
               m := TMenuItem.Create(Self);
               m.Caption := TrimRight(Copy(OpList.Strings[i], 1, 20));
               m.OnClick := MainForm.OpMenuClick;
               MainForm.OpMenu.Items.Add(m);
            end;
         end;
      end;
   end;
end;

function TdmZLogGlobal.GetAge(aQSO: TQSO): string;
var
   str: string;
   i: integer;
begin
   Result := '??';

   if aQSO.QSO.Operator = '' then begin
      Result := Settings._age;
   end
   else begin
      for i := 0 to OpList.Count - 1 do begin
         if TrimRight(Copy(OpList.Strings[i], 1, 20)) = aQSO.QSO.Operator then begin
            str := OpList.Strings[i];
            if length(str) <= 20 then begin
               exit;
            end;

            System.Delete(str, 1, 20);

            str := Trim(str);
            Result := str;
         end;
      end;
   end;
end;

procedure TdmZLogGlobal.SetOpPower(var aQSO: TQSO);
var
   str: string;
   i: integer;
   P: char;
begin
   for i := 0 to OpList.Count - 1 do begin
      if TrimRight(Copy(OpList.Strings[i], 1, 20)) = aQSO.QSO.Operator then begin
         str := OpList.Strings[i];
         if length(str) <= 20 then begin
            exit;
         end;

         System.Delete(str, 1, 20);

         if OldBandOrd(aQSO.QSO.Band) + 1 <= length(str) then
            P := str[OldBandOrd(aQSO.QSO.Band) + 1]
         else
            P := UpCase(str[1]);

         case P of
            'P':
               aQSO.QSO.Power := pwrP;
            'L':
               aQSO.QSO.Power := pwrL;
            'M':
               aQSO.QSO.Power := pwrM;
            'H':
               aQSO.QSO.Power := pwrH;
         end;
      end;
   end;
end;

function TdmZLogGlobal.GetMyCall(): string;
begin
   Result := Settings._mycall;
end;

procedure TdmZLogGlobal.SetMyCall(s: string);
begin
   Settings._mycall := s;
end;

function TdmZLogGlobal.GetBand: integer;
begin
   Result := Settings._band;
end;

procedure TdmZLogGlobal.SetBand(b: integer);
var
   BB: TBand;
begin
   Settings._band := b;
   if b > 0 then begin
      Main.CurrentQSO.QSO.Band := TBand(b - 1);
      MainForm.BandEdit.Text := Main.CurrentQSO.BandStr;
      for BB := b19 to HiBand do
         MainForm.BandMenu.Items[ord(BB)].Enabled := False;
      MainForm.BandMenu.Items[b - 1].Enabled := True;
   end
   else begin
      for BB := b19 to HiBand do
         MainForm.BandMenu.Items[ord(BB)].Enabled := True;
   end;
end;

function TdmZLogGlobal.GetMode: integer;
begin
   Result := Settings._mode;
end;

procedure TdmZLogGlobal.SetMode(m: integer);
begin
   Settings._mode := m;
end;

function TdmZLogGlobal.GetMultiOp(): Integer;
begin
   Result := Settings._multiop;
end;

procedure TdmZLogGlobal.SetMultiOp(i: integer);
begin
   Settings._multiop := i;
end;

function TdmZLogGlobal.GetContestMenuNo(): Integer;
begin
   Result := Settings._contestmenuno;
end;

procedure TdmZLogGlobal.SetContestMenuNo(i: integer);
begin
   Settings._contestmenuno := i;
end;

function TdmZLogGlobal.GetSpeed(): Integer;
begin
   Result := Settings.CW._speed;
end;

procedure TdmZLogGlobal.SetSpeed(i: integer);
begin
   if i in [0 .. 60] then begin
      Settings.CW._speed := i;
      dmZlogKeyer.WPM := Settings.CW._speed;
   end;
end;

function TdmZLogGlobal.GetFIFO(): Boolean;
begin
   Result := Settings.CW._FIFO;
end;

procedure TdmZLogGlobal.SetFIFO(b: boolean);
begin
   Settings.CW._FIFO := b;
end;

function TdmZLogGlobal.GetTXNr(): Byte;
begin
   Result := Settings._txnr;
end;

procedure TdmZLogGlobal.SetTXNr(i: Byte);
begin
   Settings._txnr := i;
end;

function TdmZLogGlobal.GetPTTEnabled: Boolean;
begin
   Result := Settings._pttenabled;
end;

procedure TdmZLogGlobal.SetScoreCoeff(E: extended);
begin
   Settings._scorecoeff := E;
   TQSO(Log.List[0]).QSO.RSTRcvd := Trunc(E * 100);
end;

procedure TdmZLogGlobal.SetWeight(i: integer);
begin
   if i in [0 .. 100] then
      Settings.CW._weight := i;

   dmZlogKeyer.SetWeight(Settings.CW._weight);
end;

procedure TdmZLogGlobal.SetTonePitch(i: integer);
begin
   Settings.CW._tonepitch := i;
   dmZlogKeyer.SideTonePitch := i;
end;

function TdmZLogGlobal.GetRigNameStr(Index: Integer): string; // returns the selected rig name
begin
   Result := RIGNAMES[Settings._rigname[Index]];
end;

function TdmZLogGlobal.GetSuperCheckColumns(): Integer;
begin
   Result := Settings._super_check_columns;
end;

procedure TdmZLogGlobal.SetSuperCheckColumns(v: Integer);
begin
   Settings._super_check_columns := v;
end;

function TdmZLogGlobal.GetCQMax(): Integer;
begin
   Result := Settings.CW._cqmax;
end;

procedure TdmZLogGlobal.SetCQMax(i: integer);
begin
   Settings.CW._cqmax := i;
   dmZlogKeyer.CQLoopMax := i;
end;

function TdmZLogGlobal.GetCQRepeat(): Double;
begin
   Result := Settings.CW._cqrepeat;
end;

procedure TdmZLogGlobal.SetCQRepeat(r: Double);
begin
   Settings.CW._cqrepeat := r;
   dmZlogKeyer.CQRepeatIntervalSec := r;
end;

function TdmZLogGlobal.GetSendFreq(): Double;
begin
   Result := Settings._sendfreq;
end;

procedure TdmZLogGlobal.SetSendFreq(r: double);
begin
   Settings._sendfreq := r;

   RigControl.Timer1.Interval := Trunc(r * 60000);
   RigControl.Timer1.Enabled := False;

   if r = 0 then begin
      exit;
   end;

   if Settings._rigport[1] <> 0 then begin
      if Settings._zlinkport <> 0 then begin
         if Settings._rigname[1] <> 0 then begin
            RigControl.Timer1.Enabled := True;
         end;
      end;
   end;
end;

procedure TdmZLogGlobal.SetPaddle(boo: boolean);
begin
   Settings.CW._paddle := boo;
end;

procedure TdmZLogGlobal.SetPaddleReverse(boo: boolean);
begin
   Settings.CW._paddlereverse := boo;
   dmZlogKeyer.SetReversePaddle(boo);
end;

procedure TdmZLogGlobal.ReversePaddle;
begin
   SetPaddleReverse(not(Settings.CW._paddlereverse));
end;

function TdmZLogGlobal.CWMessage(bank, i: integer): shortstring;
begin
   Result := Settings.CW.CWStrBank[bank, i];
end;

procedure TdmZLogGlobal.ReadWindowState(form: TForm; strWindowName: string; fPositionOnly: Boolean );
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      if strWindowName = '' then begin
         strWindowName := form.Name;
      end;

      form.Visible := ini.ReadBool('Windows', strWindowName + '_Open', False);
      form.Left    := ini.ReadInteger('Windows', strWindowName + '_X', 10);
      form.Top     := ini.ReadInteger('Windows', strWindowName + '_Y', 10);
      if fPositionOnly = False then begin
         form.Height  := ini.ReadInteger('Windows', strWindowName + '_H', 10);
         form.Width   := ini.ReadInteger('Windows', strWindowName + '_W', 10);
      end;
   finally
      ini.Free();
   end;
end;

procedure TdmZLogGlobal.WriteWindowState(form: TForm; strWindowName: string);
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      if strWindowName = '' then begin
         strWindowName := form.Name;
      end;

      ini.WriteBool('Windows', strWindowName + '_Open', form.Visible);
      ini.WriteInteger('Windows', strWindowName + '_X', form.Left);
      ini.WriteInteger('Windows', strWindowName + '_Y', form.Top);
      ini.WriteInteger('Windows', strWindowName + '_H', form.Height);
      ini.WriteInteger('Windows', strWindowName + '_W', form.Width);
   finally
      ini.Free();
   end;
end;

procedure TdmZLogGlobal.ReadMainFormState(var X, Y, W, H: integer; var TB1, TB2: boolean);
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      X := ini.ReadInteger('Windows', 'Main_X', 0);
      Y := ini.ReadInteger('Windows', 'Main_Y', 0);
      W := ini.ReadInteger('Windows', 'Main_W', 0);
      H := ini.ReadInteger('Windows', 'Main_H', 0);
      TB1 := ini.ReadBool('Windows', 'Main_ToolBar1', False);
      TB2 := ini.ReadBool('Windows', 'Main_ToolBar2', False);
   finally
      ini.Free();
   end;
end;

procedure TdmZLogGlobal.WriteMainFormState(X, Y, W, H: integer; TB1, TB2: boolean);
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      ini.WriteInteger('Windows', 'Main_X', X);
      ini.WriteInteger('Windows', 'Main_Y', Y);
      ini.WriteInteger('Windows', 'Main_W', W);
      ini.WriteInteger('Windows', 'Main_H', H);
      ini.WriteBool('Windows', 'Main_ToolBar1', TB1);
      ini.WriteBool('Windows', 'Main_ToolBar2', TB2);
   finally
      ini.Free();
   end;
end;

procedure TdmZLogGlobal.LoadOpList();
var
   filename: string;
begin
   try
      filename := ExtractFilePath(Application.EXEName) + 'ZLOG.OP';
      if FileExists(filename) = False then begin
         Exit;
      end;

      OpList.LoadFromFile(filename);
   except
      on EFOpenError do begin
      end;
   end;

end;

procedure TdmZLogGlobal.SaveOpList();
begin
   OpList.SaveToFile(ExtractFilePath(Application.EXEName) + 'ZLOG.OP');
end;

procedure TdmZLogGlobal.CreateLog();
begin
   if FLog <> nil then begin
      FLog.Free();
   end;
   FLog := TQSOList.Create('default');
end;

procedure TdmZLogGlobal.SetLogFileName(filename: string);
begin
   FCurrentFileName := filename;
end;

function Log(): TQSOList;
begin
   Result := dmZLogGlobal.FLog;
end;

function CurrentFileName(): string;
begin
   Result := dmZLogGlobal.FCurrentFileName;
end;

function Random10: integer;
var
   H, M, S, ms: word;
begin
   DecodeTime(Now, H, M, S, ms);
   Result := S mod 10;
end;

function UTCOffset: integer;
var
   TZinfo: TTimeZoneInformation;
begin
   GetTimeZoneInformation(TZinfo);
   Result := TZinfo.Bias;
end;

function ContainsDoubleByteChar(S: string): Boolean;
var
   i: integer;
begin
   Result := false;
   for i := 1 to length(S) do
      if ByteType(S, i) <> mbSingleByte then begin
         Result := True;
         break;
      end;
end;

function kHzStr(Hz: integer): string;
var
   k, kk: integer;
begin
   k := Hz div 1000;
   kk := Hz mod 1000;
   kk := kk div 100;
   if k > 100000 then
      Result := IntToStr(k)
   else
      Result := IntToStr(k) + '.' + IntToStr(kk);
end;

procedure IncEditCounter(var aQSO: TQSO);
begin
   if aQSO.QSO.Reserve3 mod 100 < 99 then
      inc(aQSO.QSO.Reserve3);
end;

function ExtractKenNr(S: string): string; // extracts ken nr from aja#+power
var
   str: string;
begin
   Result := '';
   str := copy(S, 1, 2);
   Result := str;
end;

function ExtractPower(S: string): string; // extracts power code. returns '' if no power
begin
   Result := '';
   if S = '' then
      exit;
   if S[length(S)] in ['H', 'M', 'L', 'P'] then
      Result := S[length(S)];
end;

function IsSHF(B: TBand): Boolean; // true if b >= 2400MHz
begin
   Result := (B >= b2400);
end;

function PartialMatch(A, B: string): Boolean; // true if b matches pattern a
var
   i: integer;
begin
   Result := false;
   if (Pos('.', A) = 0) { and (Pos('?',A)=0) } then
      Result := (Pos(A, B) > 0)
   else begin
      if length(A) > length(B) then
         exit;
      for i := 1 to length(A) do
         if A[i] <> '.' then
            if A[i] <> B[i] then
               exit;
      Result := True;
   end;
end;

function IsMM(S: string): Boolean;
begin
   if Pos('/MM', S) > 0 then
      Result := True
   else
      Result := false;
end;

function IsWVE(S: string): Boolean;
begin
   if (S = 'K') or (S = 'W') or (S = 'N') or (S = 'KH6') or (S = 'KL7') or (S = 'KL') or (S = 'VE') then
      Result := True
   else
      Result := false;
end;

function GetLocale: String;
var
   Buf: PChar;
begin
   Buf := StrAlloc(256);
   GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_SENGCOUNTRY, Buf, 256);
   Result := StrPas(Buf);
   StrDisPose(Buf);
end;

function GetHour(T: TDateTime): integer;
var
   H, M, S, ms: word;
begin
   DecodeTime(T, H, M, S, ms);
   Result := H;
end;

function CurrentTime: TDateTime;
begin
   if UseUTC then
      Result := GetUTC
   else
      Result := Now;
end;

function LowCase(C: Char): Char;
begin
   if C in ['A' .. 'Z'] then
      Result := Chr(ord(C) - ord('A') + ord('a'))
   else
      Result := C;
end;

function OldBandOrd(Band: TBand): integer;
begin
   case Band of
      b19 .. b7:
         Result := ord(Band);
      b14:
         Result := ord(Band) - 1;
      b21:
         Result := ord(Band) - 2;
      b28 .. HiBand:
         Result := ord(Band) - 3;
      else
         Result := 0;
   end;
end;

function NotWARC(Band: TBand): Boolean;
begin
   if Band in [b10, b18, b24] then
      Result := false
   else
      Result := True;
end;

function GetUTC: TDateTime;
var
   stUTC: TSystemTime;
begin
   GetSystemTime(stUTC);
   // TDateTimes are doubles with the time expressed as the
   // fractional component so we can add them together in
   // this situation
   Result := EncodeDate(stUTC.wYear, stUTC.wMonth, stUTC.wDay) + EncodeTime(stUTC.wHour, stUTC.wMinute, stUTC.wSecond, stUTC.wMilliseconds);
end;

function SameQSO(aQSO, bQSO: TQSO): Boolean;
begin
   if (aQSO.QSO.Band = bQSO.QSO.Band) and (aQSO.QSO.CallSign = bQSO.QSO.CallSign) and (aQSO.QSO.Mode = bQSO.QSO.Mode) and
      (aQSO.QSO.Dupe = bQSO.QSO.Dupe) and (aQSO.QSO.Serial = bQSO.QSO.Serial) then
      Result := True
   else
      Result := false;
end;

function SameQSOID(aQSO, bQSO: TQSO): Boolean;
begin
   if (aQSO.QSO.Reserve3 div 100) = (bQSO.QSO.Reserve3 div 100) then
      Result := True
   else
      Result := false;
end;

function StrMore(A, B: string): Boolean; { true if a>b }
var
   i, j: integer;
begin
   for i := 1 to Less(length(A), length(B)) do begin
      if ord(A[i]) > ord(B[i]) then begin
         Result := True;
         exit;
      end;
      if ord(A[i]) < ord(B[i]) then begin
         Result := false;
         exit;
      end;
   end;
   if length(A) > length(B) then
      Result := True
   else
      Result := false;
end;

function PXMore(A, B: string): Boolean; { true if a>b }
var
   i, j: integer;
begin
   if A[1] = B[1] then begin
      if length(A) > length(B) then begin
         Result := false;
         exit;
      end;
      if length(A) < length(B) then begin
         Result := True;
         exit;
      end;
      Result := StrMore(A, B);
      exit;
   end;
   Result := StrMore(A, B);
end;

function PXIndex(S: string): integer;
var
   i, j: integer;
begin
   Result := 0;
   if length(S) = 0 then
      exit;
   if length(S) = 1 then begin
      case S[1] of
         'A' .. 'Z':
            Result := ord(S[1]) - ord('A') + 37 * 37;
         '0' .. '9':
            Result := ord(S[1]) - ord('0') + 37 * 37 + 26;
         '/':
            Result := 37 * 37 + 36;
      end;
   end
   else begin
      i := 0;
      j := 0;
      case S[1] of
         'A' .. 'Z':
            i := ord(S[1]) - ord('A');
         '0' .. '9':
            i := ord(S[1]) - ord('0') + 26;
         '/':
            i := 36;
      end;
      case S[2] of
         'A' .. 'Z':
            i := ord(S[2]) - ord('A');
         '0' .. '9':
            i := ord(S[2]) - ord('0') + 26;
         '/':
            i := 36;
      end;
      Result := i * 37 + j;
   end;
end;

function PXMoreX(A, B: string): Boolean; { true if a>b }
var
   i, j, PXA, PXB: integer;
begin
   PXA := PXIndex(A);
   PXB := PXIndex(B);
   if PXA = PXB then begin
      if length(A) > length(B) then begin
         Result := false;
         exit;
      end;
      if length(A) < length(B) then begin
         Result := True;
         exit;
      end;
      Result := StrMore(A, B);
      exit;
   end;
   Result := PXA > PXB;
end;

function HexStrToInt(str: string): integer;
var
   i, j, digit: integer;
begin
   i := 0;
   for j := length(str) downto 1 do begin
      case str[j] of
         '0' .. '9':
            digit := ord(str[j]) - ord('0');
         'a' .. 'f':
            digit := ord(str[j]) - ord('a') + 10;
         'A' .. 'F':
            digit := ord(str[j]) - ord('A') + 10;
         else begin
               Result := -1;
               exit;
            end;
      end;
      i := i + Power(16, length(str) - j) * digit;
   end;
   Result := i;
end;

function Less(x, y: integer): integer;
begin
   if x > y then
      Result := y
   else
      Result := x;
end;

function More(x, y: integer): integer;
begin
   if x > y then
      Result := x
   else
      Result := y;
end;

function FillRight(S: string; len: integer): string;
var
   sjis: AnsiString;
begin
   sjis := AnsiString(S);
   sjis := sjis + DupeString(' ', len);
   sjis := Copy(sjis, 1, len);
   Result := String(sjis);
end;

function FillLeft(S: string; len: integer): string;
var
   sjis: AnsiString;
begin
   sjis := AnsiString(S);
   sjis := DupeString(' ', len) + sjis;
   sjis := Copy(sjis, Length(sjis) - len + 1, len);
   Result := String(sjis);
end;

function GetContestName(Filename: string): string;
var
   zfile: textfile;
   str, rstr: string;
begin
   str := ExtractFileName(Filename);

   if FileExists(Filename) = false then begin
      Result := str + ' does not exist';
      exit;
   end;

   System.Assign(zfile, Filename);
   System.reset(zfile);
   while not(eof(zfile)) do begin
      readln(zfile, rstr);
      if rstr[1] = '#' then begin
         Delete(rstr, 1, 1);
         str := rstr;
         break;
      end;
   end;
   System.CloseFile(zfile);
   Result := str;
end;

function CoreCall(call: string): string;
var
   p: integer;
   str: string;
begin
   str := call;
   p := Pos('/', str);
   if p > 4 then
      Delete(str, p, 255);
   Result := str;
end;

function UsesCoeff(Filename: string): Boolean;
var
   zfile: textfile;
   str, rstr: string;
   check: Boolean;
begin
   Result := false;
   str := ExtractFileName(Filename);
   System.Assign(zfile, Filename);
{$I-}
   System.reset(zfile);
{$I+}
   check := (IOresult = 0);
   if check then begin
      while not(eof(zfile)) do begin
         readln(zfile, rstr);
         rstr := Uppercase(rstr);
         if Pos('COEFF', rstr) = 1 then begin
            if Pos('ON', rstr) > 0 then
               Result := True;
         end;
      end;
      System.CloseFile(zfile);
   end;
end;

function SameMode(aQSO, bQSO: TQSO): Boolean;
begin
   Result := false;
   case aQSO.QSO.Mode of
      mCW:
         if bQSO.QSO.Mode = mCW then
            Result := True;
      mSSB, mFM, mAM:
         if bQSO.QSO.Mode in [mSSB, mFM, mAM] then
            Result := True;
      mRTTY:
         if bQSO.QSO.Mode = mRTTY then
            Result := True;
      mOther:
         if bQSO.QSO.Mode = mOther then
            Result := True;
   end;
end;

function SameMode2(aMode, bMode: TMode): Boolean;
begin
   Result := false;
   case aMode of
      mCW:
         if bMode = mCW then
            Result := True;
      mSSB, mFM, mAM:
         if bMode in [mSSB, mFM, mAM] then
            Result := True;
      mRTTY:
         if bMode = mRTTY then
            Result := True;
      mOther:
         if bMode = mOther then
            Result := True;
   end;
end;

procedure CenterWindow(formParent, formChild: TForm);
begin
   formChild.Left := formParent.Left + ((formParent.Width - formChild.Width) div 2);
   formChild.Top := formParent.Top + ((formParent.Height - formChild.Height) div 2);
end;

function Power(base, Power: integer): integer;
var
   i, j: integer;
begin
   j := 1;
   for i := 1 to Power do
      j := j * base;
   Result := j;
end;

procedure TQSO.IncTime;
var
   T: TDateTime;
begin
   Self.QSO.Time := Self.QSO.Time + 1.0 / (24 * 60);
end;

procedure TQSO.DecTime;
var
   T: TDateTime;
begin
   Self.QSO.Time := Self.QSO.Time - 1.0 / (24 * 60);
end;

function TQSO.QSOinText: string; { for data transfer }
var
   str: string;
begin
   str := 'ZLOGQSODATA:' + _sep;
   // str := str + DateTimeToStr(QSO.Time) + _sep;
   str := str + FloatToStr(QSO.Time) + _sep;
   str := str + QSO.CallSign + _sep;
   str := str + QSO.NrSent + _sep;
   str := str + QSO.NrRcvd + _sep;
   str := str + IntToStr(QSO.RSTSent) + _sep;
   str := str + IntToStr(QSO.RSTRcvd) + _sep;
   str := str + IntToStr(QSO.Serial) + _sep;
   str := str + IntToStr(ord(QSO.Mode)) + _sep;
   str := str + IntToStr(ord(QSO.Band)) + _sep;
   str := str + IntToStr(ord(QSO.Power)) + _sep;
   str := str + QSO.Multi1 + _sep;
   str := str + QSO.Multi2 + _sep;
   if QSO.NewMulti1 then
      str := str + '1' + _sep
   else
      str := str + '0' + _sep;
   if QSO.NewMulti2 then
      str := str + '1' + _sep
   else
      str := str + '0' + _sep;
   str := str + IntToStr(QSO.Points) + _sep;
   str := str + QSO.Operator + _sep;
   str := str + QSO.Memo + _sep;
   if QSO.CQ then
      str := str + '1' + _sep
   else
      str := str + '0' + _sep;
   if QSO.Dupe then
      str := str + '1' + _sep
   else
      str := str + '0' + _sep;
   str := str + IntToStr(QSO.Reserve) + _sep;
   str := str + IntToStr(QSO.TX) + _sep;
   str := str + IntToStr(QSO.Power2) + _sep;
   str := str + IntToStr(QSO.Reserve2) + _sep;
   str := str + IntToStr(QSO.Reserve3);

   Result := str;
end;

procedure TQSO.TextToQSO(str: string); { convert text to bin }
var
   _Items: array [0 .. 25] of string;
   i, j: integer;
begin
   for i := 0 to 25 do
      _Items[i] := '';
   j := 0;
   for i := 1 to length(str) do begin
      if str[i] = _sep then
         inc(j)
      else
         _Items[j] := _Items[j] + str[i];
   end;

   if _Items[0] <> 'ZLOGQSODATA:' then
      exit;
   // QSO.Time := StrToDateTime(_Items[1]);
   try
      QSO.Time := StrToFloat(_Items[1]);
      QSO.CallSign := _Items[2];
      QSO.NrSent := _Items[3];
      QSO.NrRcvd := _Items[4];
      QSO.RSTSent := StrToInt(_Items[5]);
      QSO.RSTRcvd := StrToInt(_Items[6]);
      QSO.Serial := StrToInt(_Items[7]);
      QSO.Mode := TMode(StrToInt(_Items[8]));
      QSO.Band := TBand(StrToInt(_Items[9]));
      QSO.Power := TPower(StrToInt(_Items[10]));
      QSO.Multi1 := _Items[11];
      QSO.Multi2 := _Items[12];
      QSO.NewMulti1 := StrToInt(_Items[13]) = 1;
      QSO.NewMulti2 := StrToInt(_Items[14]) = 1;
      QSO.Points := StrToInt(_Items[15]);
      QSO.Operator := _Items[16];
      QSO.Memo := _Items[17];
      QSO.CQ := StrToInt(_Items[18]) = 1;
      QSO.Dupe := StrToInt(_Items[19]) = 1;
      QSO.Reserve := StrToInt(_Items[20]);
      QSO.TX := StrToInt(_Items[21]);
      QSO.Power2 := StrToInt(_Items[22]);
      QSO.Reserve2 := StrToInt(_Items[23]);
      QSO.Reserve3 := StrToInt(_Items[24]);
   except
      on EConvertError do
         QSO.Memo := 'Convert Error!';
   end;
   { if QSO.Dupe then
     str := str + '1' + _sep
     else
     str := str + '0' + _sep;
     str := str + IntToStr(QSO.Reserve); }
end;

constructor TQSO.Create;
begin
   with QSO do begin
      Time := Date + Time;
      CallSign := '';
      { NrSent := ''; }
      NrRcvd := '';
      if Mode = mCW then begin
         RSTSent := 599;
         RSTRcvd := 599;
      end
      else begin
         RSTSent := 59;
         RSTRcvd := 59;
      end;

      Serial := 1;
      { Mode := mCW;
        Band := b7; }
      Multi1 := '';
      Multi2 := '';
      NewMulti1 := false;
      NewMulti2 := false;
      Points := 1;
      { Operator := ''; }
      Memo := '';
      CQ := false;
      Dupe := false;
      Reserve := 0;
      TX := 0;
      Power2 := 500;
      Reserve2 := 0;
      Reserve3 := 0;
   end;
end;

procedure TQSO.UpdateTime;
begin
   if UseUTC then
      QSO.Time := GetUTC
   else
      QSO.Time := Now;
end;

function TQSO.SerialStr: string;
var
   S: string;
begin
   S := IntToStr(Self.QSO.Serial);
   case length(S) of
      1:
         S := '00' + S;
      2:
         S := '0' + S;
   end;
   Result := S;
end;

function TQSO.QTCStr: string;
begin
   Result := FormatDateTime('hhnn', Self.QSO.Time) + ' ' + Self.QSO.CallSign + ' ' + Self.QSO.NrRcvd;
end;

function TQSO.TimeStr: string;
begin
   Result := FormatDateTime('hh:nn', Self.QSO.Time);
end;

function TQSO.DateStr: string;
begin
   Result := FormatDateTime('yy/mm/dd', Self.QSO.Time);
end;

function TQSO.BandStr: string;
begin
   Result := MHzString[Self.QSO.Band];
end;

function TQSO.ModeStr: string;
begin
   Result := ModeString[Self.QSO.Mode];
end;

function TQSO.PowerStr: string;
var
   i: integer;
begin
   i := Self.QSO.Power2;
   case i of
      9999:
         Result := 'KW';
      10000:
         Result := '1KW';
      10001:
         Result := 'K';
      else
         Result := IntToStr(i);
   end;
end;

function TQSO.NewPowerStr: string;
begin
   Result := NewPowerString[Self.QSO.Power];
end;

function TQSO.PointStr: string;
begin
   Result := IntToStr(Self.QSO.Points);
end;

function TQSO.RSTStr: string;
begin
   Result := IntToStr(Self.QSO.RSTRcvd);
end;

function TQSO.RSTSentStr: string;
begin
   Result := IntToStr(Self.QSO.RSTSent);
end;

function TQSO.PartialSummary(DispDate: Boolean): string;
var
   S: string;
begin
   if DispDate then
      S := DateStr + ' '
   else
      S := '';
   S := S + TimeStr + ' ';
   S := S + FillRight(Self.QSO.CallSign, 12);
   S := S + FillRight(Self.QSO.NrRcvd, 15);
   S := S + FillRight(BandStr, 5);
   S := S + FillRight(ModeStr, 5);
   Result := S;
end;

function TQSO.CheckCallSummary: string;
var
   S: string;
begin
   S := '';
   S := S + FillRight(BandStr, 5);
   S := S + TimeStr + ' ';
   S := S + FillRight(Self.QSO.CallSign, 12);
   S := S + FillRight(Self.QSO.NrRcvd, 15);
   S := S + FillRight(ModeStr, 5);
   Result := S;
end;

function TQSO.DOSzLogText: string;
var
   S, temp: string;
   Year, Month, Day, Hour, Min, Sec, MSec: word;
begin
   S := '';
   DecodeDate(Self.QSO.Time, Year, Month, Day);
   DecodeTime(Self.QSO.Time, Hour, Min, Sec, MSec);
   S := S + FillLeft(IntToStr(Month), 3) + ' ' + FillLeft(IntToStr(Day), 3) + ' ';

   temp := IntToStr(Hour * 100 + Min);
   case length(temp) of
      1:
         temp := '000' + temp;
      2:
         temp := '00' + temp;
      3:
         temp := '0' + temp;
   end;

   S := S + temp + ' ';
   S := S + FillRight(Self.QSO.CallSign, 11);
   S := S + FillLeft(IntToStr(Self.QSO.RSTSent), 3);
   S := S + FillRight(Self.QSO.NrSent, 31);
   S := S + FillLeft(IntToStr(Self.QSO.RSTRcvd), 3);
   S := S + FillRight(Self.QSO.NrRcvd, 31);

   if Self.QSO.NewMulti1 then
      S := S + FillLeft(Self.QSO.Multi1, 6)
   else
      S := S + '      ';
   S := S + '  ' + FillLeft(MHzString[Self.QSO.Band], 4);
   S := S + '  ' + FillRight(ModeString[Self.QSO.Mode], 3);
   S := S + ' ' + FillRight(IntToStr(Self.QSO.Points), 2);
   if Self.QSO.Operator <> '' then
      // S := S + ' ' + '%%'+ Self.QSO.Operator +'%%';
      S := S + '%%' + Self.QSO.Operator + '%%';
   // S := S + ' ' + Self.QSO.memo;
   S := S + Self.QSO.Memo;
   Result := S;
end;

function TQSO.DOSzLogTextShort: string;
var
   S, temp: string;
   Year, Month, Day, Hour, Min, Sec, MSec: word;
begin
   S := '';
   DecodeDate(Self.QSO.Time, Year, Month, Day);
   DecodeTime(Self.QSO.Time, Hour, Min, Sec, MSec);
   S := S + FillLeft(IntToStr(Month), 3) + ' ' + FillLeft(IntToStr(Day), 3) + ' ';

   temp := IntToStr(Hour * 100 + Min);
   case length(temp) of
      1:
         temp := '000' + temp;
      2:
         temp := '00' + temp;
      3:
         temp := '0' + temp;
   end;

   S := S + temp + ' ';
   S := S + FillRight(Self.QSO.CallSign, 11);
   S := S + FillLeft(IntToStr(Self.QSO.RSTSent), 3);
   S := S + FillRight(Self.QSO.NrSent, 10);
   S := S + FillLeft(IntToStr(Self.QSO.RSTRcvd), 3);
   S := S + FillRight(Self.QSO.NrRcvd, 10);

   if Self.QSO.NewMulti1 then
      S := S + FillLeft(Self.QSO.Multi1, 6)
   else
      S := S + '      ';
   S := S + '  ' + FillLeft(MHzString[Self.QSO.Band], 4);
   S := S + '  ' + FillRight(ModeString[Self.QSO.Mode], 3);
   S := S + ' ' + FillRight(IntToStr(Self.QSO.Points), 2);
   if Self.QSO.Operator <> '' then
      S := S + '  ' + '%%' + Self.QSO.Operator + '%%';
   S := S + '  ' + Self.QSO.Memo;
   Result := S;
end;

function TQSO.zLogALL: string;
var
   S, temp: string;
   nrlen: integer;
begin
   nrlen := 7;
   S := '';
   S := S + FormatDateTime('yyyy/mm/dd hh":"nn ', Self.QSO.Time);
   S := S + FillRight(Self.QSO.CallSign, 13);
   S := S + FillRight(IntToStr(Self.QSO.RSTSent), 4);
   S := S + FillRight(Self.QSO.NrSent, nrlen + 1);
   S := S + FillRight(IntToStr(Self.QSO.RSTRcvd), 4);
   S := S + FillRight(Self.QSO.NrRcvd, nrlen + 1);

   if Self.QSO.NewMulti1 then
      S := S + FillRight(Self.QSO.Multi1, 6)
   else
      S := S + '-     ';
   if Self.QSO.NewMulti2 then
      S := S + FillRight(Self.QSO.Multi2, 6)
   else
      S := S + '-     ';
   S := S + FillRight(MHzString[Self.QSO.Band], 5);
   S := S + FillRight(ModeString[Self.QSO.Mode], 5);
   S := S + FillRight(IntToStr(Self.QSO.Points), 3);
   if Self.QSO.Operator <> '' then
      S := S + FillRight('%%' + Self.QSO.Operator + '%%', 19);

   if dmZlogGlobal.MultiOp > 0 then begin
      S := S + FillRight('TX#' + IntToStr(Self.QSO.TX), 6);
   end;

   S := S + Self.QSO.Memo;
   Result := S;
end;

function TQSOList.ContainBand: TBandBool;
var
   R: TBandBool;
   B: TBand;
   i: integer;
begin
   for B := b19 to HiBand do begin
      R[B] := false;
   end;

   for i := 1 to TotalQSO do begin
      R[TQSO(List[i]).QSO.Band] := True;
   end;

   Result := R;
end;

constructor TQSOList.Create(Memo: string);
var
   Q: TQSO;
   B: TBand;
begin
   // ADIF_FieldName := 'qth';
   List := TList.Create;
   QueList := TList.Create;

   for B := b19 to HiBand do begin
      DupeCheckList[B] := TStringList.Create;
      DupeCheckList[B].Sorted := True;
      DupeCheckList[B].Duplicates := dupAccept;
   end;

   Q := TQSO.Create;
   Q.QSO.Memo := Memo;
   Q.QSO.Time := 1.0000;
   Q.QSO.Time := -1;
   Q.QSO.RSTSent := 0;
   List.Add(Q);

   Saved := True;
   QueOK := True;
   AcceptDifferentMode := false;
   CountHigherPoints := false;
   DifferentModePointer := 0;
end;

function TQSOList.Year: integer;
var
   T: TDateTime;
   y, M, d: word;
begin
   Result := 0;
   if TotalQSO > 0 then
      T := TQSO(List[1]).QSO.Time
   else
      exit;
   DecodeDate(T, y, M, d);
   Result := y;
end;

procedure TQSOList.SortByTime;
var
   i: integer;
   boo: Boolean;
begin
   if TotalQSO < 2 then
      exit;
   boo := True;
   while boo do begin
      boo := false;
      for i := 1 to TotalQSO - 1 do
         if TQSO(List[i]).QSO.Time > TQSO(List[i + 1]).QSO.Time then begin
            List.Exchange(i, i + 1);
            boo := True;
         end;
   end;
end;

procedure TQSOList.Clear;
var
   i, max: integer;
   aQSO: TQSO;
begin
   max := List.Count - 1;
   For i := 1 to max do begin
      aQSO := List[1];
      aQSO.Free;
      List.Delete(1);
   end;
   List.Pack;
   ClearDupeCheckList;
   Saved := false;
end;

procedure TQSOList.ClearDupeCheckList;
var
   B: TBand;
begin
   for B := b19 to HiBand do
      DupeCheckList[B].Clear;
end;

procedure TQSOList.Add(aQSO: TQSO);
var
   xQSO: TQSO;
begin
   xQSO := TQSO.Create;
   xQSO.QSO := aQSO.QSO;
   List.Add(xQSO);

   DupeCheckList[xQSO.QSO.Band].AddObject(CoreCall(xQSO.QSO.CallSign), xQSO);

   Saved := false;
end;

procedure TQSOList.AddQue(aQSO: TQSO);
var
   xQSO: TQSO;
begin
   xQSO := TQSO.Create;
   xQSO.QSO := aQSO.QSO;
   // xQSO.QSO.Reserve := actAdd;
   QueList.Add(xQSO);
   Saved := false;
end;

procedure TQSOList.ProcessQue;
var
   xQSO, yQSO, zQSO, wQSO: TQSO;
   i, j, id: integer;
begin
   if QueList.Count = 0 then
      exit;
   Repeat
   until QueOK;
   while QueList.Count > 0 do begin
      xQSO := TQSO(QueList[0]);
      case xQSO.QSO.Reserve of
         actAdd:
            Add(xQSO);
         actDelete: begin
               for i := 1 to TotalQSO do begin
                  yQSO := TQSO(List[i]);
                  if SameQSOID(xQSO, yQSO) then begin
                     Self.Delete(i);
                     break;
                  end;
               end;
            end;
         actEdit: begin
               for i := 1 to TotalQSO do begin
                  yQSO := TQSO(List[i]);
                  if SameQSOID(xQSO, yQSO) then begin
                     // TQSO(List[i]).QSO := xQSO.QSO;
                     yQSO.QSO := xQSO.QSO;
                     RebuildDupeCheckList;
                     break;
                  end;
               end;
               {
                 if QueList.Count = 1 then
                 exit;
                 for j := 1 to QueList.Count - 1 do
                 if TQSO(QueList[j]).QSO.Reserve = actEdit then
                 break;
                 yQSO := TQSO(QueList[j]);
                 if yQSO.QSO.Reserve <> actEdit then exit;

                 for i := 1 to TotalQSO do
                 begin
                 zQSO := TQSO(List[i]);
                 if SameQSO(xQSO, zQSO) then
                 begin
                 TQSO(List[i]).QSO := yQSO.QSO;
                 break;
                 end;
                 end;

                 QueList.Delete(j); }
            end;
         actInsert: begin
               for i := 1 to TotalQSO do begin
                  yQSO := TQSO(List[i]);
                  id := xQSO.QSO.Reserve2 div 100;
                  if id = (yQSO.QSO.Reserve3 div 100) then begin
                     wQSO := TQSO.Create;
                     wQSO.QSO := xQSO.QSO;
                     Insert(i, wQSO);
                     break;
                  end;
               end;
               {
                 if QueList.Count = 1 then
                 exit;
                 for j := 1 to QueList.Count - 1 do
                 if TQSO(QueList[j]).QSO.Reserve = actInsert then
                 break;
                 yQSO := TQSO(QueList[j]);
                 if yQSO.QSO.Reserve <> actInsert then exit;


                 for i := 1 to TotalQSO do
                 begin
                 zQSO := TQSO(List[i]);
                 if SameQSO(xQSO, zQSO) then
                 begin
                 wQSO := TQSO.Create;
                 wQSO.QSO := yQSO.QSO;
                 Insert(i, wQSO);
                 break;
                 end;
                 end;
                 QueList.Delete(j); }
            end;
         actLock: begin
               for i := 1 to TotalQSO do begin
                  zQSO := TQSO(List[i]);
                  if SameQSOID(xQSO, zQSO) then begin
                     TQSO(List[i]).QSO.Reserve := actLock;
                     break;
                  end;
               end;
            end;
         actUnlock: begin
               for i := 1 to TotalQSO do begin
                  zQSO := TQSO(List[i]);
                  if SameQSOID(xQSO, zQSO) then begin
                     TQSO(List[i]).QSO.Reserve := 0;
                     break;
                  end;
               end;
            end;
      end;
      TQSO(QueList[0]).Free; // added 0.23
      QueList.Delete(0);
      QueList.Pack;
   end;
   Saved := false;
end;

procedure TQSOList.Delete(i: integer);
var
   aQSO: TQSO;
begin
   if i <= TotalQSO then begin
      aQSO := TQSO(List[i]);
      aQSO.Free;
      List.Delete(i);
      List.Pack;
      { List[i]:=nil;
        List.Pack; }
      Saved := false;
      RebuildDupeCheckList;
   end;
end;

procedure TQSOList.RemoveDupes;
var
   i: integer;
   aQSO: TQSO;
begin
   for i := 1 to TotalQSO do begin
      aQSO := TQSO(List[i]);
      if Pos('-DUPE-', aQSO.QSO.Memo) > 0 then begin
         List[i] := nil;
         aQSO.Free;
      end;
   end;
   List.Pack;
   Saved := false;
   RebuildDupeCheckList;
end;

procedure TQSOList.DeleteBand(B: TBand);
var
   i: integer;
begin
   for i := 1 to TotalQSO do
      if TQSO(List[i]).QSO.Band = B then begin
         TQSO(List[i]).Free;
         List[i] := nil;
         Saved := false;
      end;
   RebuildDupeCheckList;
   List.Pack;
end;

function TQSOList.CheckQSOID(i: integer): Boolean;
var
   j, id: integer;
begin
   Result := false;
   id := i div 100; // last two digits are edit counter
   for j := 1 to TotalQSO do begin
      if id = (TQSO(List[j]).QSO.Reserve3 div 100) then begin
         Result := True;
         break;
      end;
   end;
end;

procedure TQSOList.Insert(i: integer; aQSO: TQSO);
begin
   List.Insert(i, aQSO);
   RebuildDupeCheckList;
   Saved := false;
end;

procedure TQSOList.SaveToFile(Filename: string);
var
   f: file of TQSOData;
   i: integer;
   back: string;
begin
   back := ChangeFileExt(Filename, '.BAK');
   if FileExists(back) then begin
      System.SysUtils.DeleteFile(back);
   end;
   RenameFile(Filename, back);

   AssignFile(f, Filename);
   Rewrite(f);

   for i := 0 to TotalQSO do begin // changed from 1 to TotalQSO to 0 to TotalQSO
      Write(f, TQSO(List[i]).QSO);
   end;

   CloseFile(f);

   Saved := True;
end;

procedure TQSOList.SaveToFilezLogDOSTXT(Filename: string);
var
   f: textfile;
   str: string;
   i, j, max: integer;
const
   LongHeader = 'mon day time  callsign      sent                              rcvd                           multi   MHz mode pts memo';
   ShortHeader = 'mon day time  callsign      sent         rcvd      multi   MHz mode pts memo';
begin
   AssignFile(f, Filename);
   Rewrite(f);
   { str := 'zLog for Windows Text File'; }
   max := 0;
   for i := 1 to TotalQSO do begin
      j := length(TQSO(List[i]).QSO.NrRcvd);
      if j > max then
         max := j;
      j := length(TQSO(List[i]).QSO.NrSent);
      if j > max then
         max := j;
   end;
   if j >= 10 then begin
      writeln(f, LongHeader);
      for i := 1 to TotalQSO do
         writeln(f, TQSO(List[i]).DOSzLogText);
   end
   else begin
      writeln(f, ShortHeader);
      for i := 1 to TotalQSO do
         writeln(f, TQSO(List[i]).DOSzLogTextShort);
   end;
   CloseFile(f);
end;

procedure TQSOList.SaveToFilezLogALL(Filename: string);
var
   f: textfile;
   Header: string;
   i, max: integer;
begin
   Header := 'zLog for Windows '; // +Options.Settings._mycall;
   AssignFile(f, Filename);
   Rewrite(f);
   { str := 'zLog for Windows Text File'; }
   max := 0;
   writeln(f, Header);
   for i := 1 to TotalQSO do
      writeln(f, TQSO(List[i]).zLogALL);
   CloseFile(f);
end;

procedure TQSOList.SaveToFileByTX(Filename: string);
var
   f: textfile;
   Header: string;
   i, j: integer;
   txset: set of byte;
begin
   txset := [];
   for i := 1 to TotalQSO do
      txset := txset + [TQSO(List[i]).QSO.TX];
   Header := 'zLog for Windows '; // +Options.Settings._mycall;
   System.Delete(Filename, length(Filename) - 2, 3);
   for i := 0 to 255 do
      if i in txset then begin
         AssignFile(f, Filename + '.' + IntToStr(i) + '.TX');
         Rewrite(f);
         writeln(f, Header + ' TX# ' + IntToStr(i));
         for j := 1 to TotalQSO do
            if TQSO(List[j]).QSO.TX = i then
               writeln(f, TQSO(List[j]).zLogALL);
         CloseFile(f);
      end;
end;

procedure TQSOList.LoadFromFile(Filename: string);
begin
end;

destructor TQSOList.Destroy;
var
   i: integer;
begin
   for i := 0 to List.Count - 1 do begin
      if List[i] <> nil then
         TQSO(List[i]).Free;
   end;
   List.Free;
end;

procedure TQSOList.RebuildDupeCheckList;
var
   i: integer;
   Q: TQSO;
begin
   ClearDupeCheckList;
   for i := 0 to List.Count - 1 do begin
      Q := TQSO(List[i]);
      DupeCheckList[Q.QSO.Band].AddObject(CoreCall(Q.QSO.CallSign), Q);
   end;
end;

function TQSOList.QuickDupe(aQSO: TQSO): TQSO;
var
   i: integer;
   S: string;
   Q, Q2: TQSO;
begin
   Result := nil;
   Q := nil;
   S := CoreCall(aQSO.QSO.CallSign);
   i := DupeCheckList[aQSO.QSO.Band].IndexOf(S);
   if (i >= 0) and (i < DupeCheckList[aQSO.QSO.Band].Count) then begin
      Q := TQSO(DupeCheckList[aQSO.QSO.Band].Objects[i]);
      if Q.QSO.Band = aQSO.QSO.Band then
         Result := Q;
   end;

   if AcceptDifferentMode and (Q <> nil) then begin
      if aQSO.QSO.Mode <> Q.QSO.Mode then begin
         Result := nil;
         for i := 0 to DupeCheckList[aQSO.QSO.Band].Count - 1 do begin
            if S = DupeCheckList[aQSO.QSO.Band][i] then begin
               Q2 := TQSO(DupeCheckList[aQSO.QSO.Band].Objects[i]);
               if aQSO.QSO.Mode = Q2.QSO.Mode then begin
                  Result := Q2;
                  exit;
               end;
            end;
         end;
      end;
   end;
end;

function TQSOList.OpQSO(OpName: string): integer;
var
   i, j: integer;
begin
   j := 0;
   for i := 1 to TotalQSO do
      if TQSO(List[i]).QSO.Operator = OpName then
         inc(j);
   Result := j;
end;

function TQSOList.IsDupe(aQSO: TQSO): integer;
var
   x: integer;
   i: word;
   str: string;
begin
   DifferentModePointer := 0;
   x := 0;
   str := CoreCall(aQSO.QSO.CallSign);
   for i := 1 to TotalQSO do begin
      if (aQSO.QSO.Band = TQSO(List[i]).QSO.Band) and (str = CoreCall(TQSO(List[i]).QSO.CallSign)) then begin
         if Not(AcceptDifferentMode) then begin
            x := i;
            break;
         end
         else begin
            if SameMode(aQSO, TQSO(List[i])) then begin
               x := i;
               break;
            end
            else { different mode qso exists but not dupe }
            begin
               DifferentModePointer := i;
            end;
         end;
      end;
   end;
   Result := x;
end;

function TQSOList.IsDupe2(aQSO: TQSO; index: integer; var dupeindex: integer): Boolean;
var
   boo: Boolean;
   i: word;
   str: string;
begin
   boo := false;
   str := CoreCall(aQSO.QSO.CallSign);
   for i := 1 to TotalQSO do begin
      if (aQSO.QSO.Band = TQSO(List[i]).QSO.Band) and (str = CoreCall(TQSO(List[i]).QSO.CallSign)) and ((index <= 0) or (index <> i)) then begin
         if Not(AcceptDifferentMode) or (AcceptDifferentMode and SameMode(aQSO, TQSO(List[i]))) then begin
            boo := True;
            if index > 0 then
               dupeindex := i;
            break;
         end;
      end;
   end;
   Result := boo;
end;

procedure TQSOList.SetDupeFlags;
var
   i, j: integer;
   str, temp: string;
   aQSO: TQSO;
   TempList: array [ord('A') .. ord('Z')] of TStringList;
   ch: Char;
   core: string;
begin
   if TotalQSO = 0 then
      exit;
   for i := ord('A') to ord('Z') do begin
      TempList[i] := TStringList.Create;
      TempList[i].Sorted := True;
      TempList[i].Capacity := 200;
   end;

   for i := 1 to TotalQSO do begin
      aQSO := TQSO(List[i]);
      core := CoreCall(aQSO.QSO.CallSign);
      if AcceptDifferentMode then
         str := core + aQSO.BandStr + aQSO.ModeStr
      else
         str := core + aQSO.BandStr;

      if core = '' then
         ch := 'Z'
      else
         ch := core[length(core)];

      if not(ch in ['A' .. 'Z']) then
         ch := 'Z';

      if TempList[ord(ch)].Find(str, j) = True then begin
         aQSO.QSO.Points := 0;
         aQSO.QSO.Dupe := True;
         temp := aQSO.QSO.Memo;
         if Pos('-DUPE-', temp) = 0 then
            aQSO.QSO.Memo := '-DUPE- ' + temp;
      end
      else begin
         aQSO.QSO.Dupe := false;
         temp := aQSO.QSO.Memo;
         if Pos('-DUPE-', temp) = 1 then
            aQSO.QSO.Memo := copy(temp, 8, 255);
         TempList[ord(ch)].Add(str);
      end;
   end;
   for i := ord('A') to ord('Z') do begin
      TempList[i].Clear;
      TempList[i].Free;
   end;
end;

function TQSOList.TotalQSO: integer;
begin
   Result := List.Count - 1;
end;

function TQSOList.TotalPoints: integer;
var
   Count, i: integer;
begin
   Count := 0;
   for i := 1 to TotalQSO do
      Count := TQSO(List.Items[i]).QSO.Points + Count;
   Result := Count;
end;

function TQSOList.TotalCW: integer;
var
   Count, i: integer;
begin
   Count := 0;
   for i := 1 to TotalQSO do
      if TQSO(List.Items[i]).QSO.Mode = mCW then
         inc(Count);
   Result := Count;
end;

function TQSOList.TotalMulti1: integer;
var
   Count, i: integer;
begin
   Count := 0;
   for i := 1 to TotalQSO do
      if TQSO(List.Items[i]).QSO.NewMulti1 then
         inc(Count);
   Result := Count;
end;

function TQSOList.TotalMulti2: integer;
var
   Count, i: integer;
begin
   Count := 0;
   for i := 1 to TotalQSO do
      if TQSO(List.Items[i]).QSO.NewMulti2 then
         inc(Count);
   Result := Count;
end;

function StrToBandDef(strMHz: string; defband: TBand): TBand;
var
   i: TBand;
begin
   for i := Low(BandString) to High(BandString) do begin
      if MHzString[i] = strMHz then begin
         Result := TBand(i);
         Exit;
      end;
   end;
   Result := defband;
end;

function StrToModeDef(strMode: string; defmode: TMode): TMode;
var
   i: TMode;
begin
   for i := Low(ModeString) to High(ModeString) do begin
      if ModeString[i] = strMode then begin
         Result := TMode(i);
         Exit;
      end;
   end;
   Result := defmode;
end;

end.
