unit UzLogGlobal;

interface

uses
  System.SysUtils, System.Classes, StrUtils, IniFiles, Forms, Windows, Menus,
  System.Math, Vcl.Graphics, System.DateUtils, Generics.Collections, Generics.Defaults,
  Vcl.Dialogs, System.UITypes, System.Win.Registry,
  UzLogConst, UzLogQSO, UzLogOperatorInfo, UMultipliers, UBandPlan,
  UQsoTarget;

type
  TCWSettingsParam = record
    _speed : integer;
    _weight : integer;
    _fixwpm : integer;
    _paddlereverse : boolean;
    _sidetone: Boolean;
    _sidetone_volume: Integer;
    _tonepitch : integer;
    _cqmax : integer;
    _cqrepeat : double;
    _cq_random_repeat: Boolean;
    _FIFO : boolean;
    _interval : integer;
    _zero : char;
    _one : char;
    _nine : char;
    CWStrBank : array[1..maxbank,1..maxmessage] of string; //bank 3 is for rtty
    CurrentBank : integer; {for future use?}
    _spacefactor : word; {factor in % for default space between characters}
    _eispacefactor : word;
    _send_nr_auto: Boolean;            // Send NR automatically
    _not_send_leading_zeros: Boolean;  // Not send leading zeros in serial number

    CWStrImported: array[1..maxbank, 1..maxmessage] of Boolean;

    AdditionalCQMessages: array[2..3] of string;
    AdditionalCQMessagesImported: array[2..3] of Boolean;
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
    FRig: Integer;
  end;

  TSuperCheckParam = record
    FSuperCheckMethod: Integer;
    FSuperCheckFolder: string;
    FAcceptDuplicates: Boolean;
    FFullMatchHighlight: Boolean;
    FFullMatchColor: TColor;
  end;

  TPartialCheckParam = record
    FCurrentBandForeColor: TColor;
    FCurrentBandBackColor: TColor;
  end;

  TAccessibilityParam = record
    FFocusedForeColor: TColor;
    FFocusedBackColor: TColor;
    FFocusedBold: Boolean;
  end;

  TColorSetting = record
    FForeColor: TColor;
    FBackColor: TColor;
    FBold: Boolean;
  end;

  TPortConfig = record
    FRts: TPortAction;  // default: PTT
    FDtr: TPortAction;  // default: KEY
  end;

  TRigSetting = record
    FControlPort: Integer; {0 : none 1-4 : com#}
    FControlPortConfig: TPortConfig;
    FSpeed: Integer;
    FRigName: string;
    FKeyingPort: Integer; {1 : LPT1; 2 : LPT2;  11:COM1; 12 : COM2;  21: USB}
    FKeyingPortConfig: TPortConfig;
    FUseTransverter: Boolean;
    FTransverterOffset: Integer;
    FPhoneChgPTT: Boolean;
  end;

  TRigSet = record
    FRig: array[b19..b10g] of Integer;
    FAnt: array[b19..b10g] of Integer;
  end;

  TSettingsParam = record
    _multiop : TContestCategory;  {multi op/ single op}
    _band : integer; {0 = all band; 1 = 1.9MHz 2 = 3.5MHz ...}
    _mode : TContestMode; {0 = Ph/CW; 1 = CW; 2=Ph; 3 = Other}
    _contestmenuno : integer; {selected contest in the menu}
    _mycall : string;

    _selectlastoperator: Boolean;
    _applypoweronbandchg: Boolean;
    _prov : string;
    _city : string;
    _cqzone : string;
    _iaruzone : string;
    _powerH: string;
    _powerM: string;
    _powerL: string;
    _powerP: string;

    ProvCityImported: Boolean;
    ReadOnlyParamImported: Boolean;

    _activebands: array[b19..HiBand] of Boolean;
    _power: array[b19..HiBand] of string;
    _usebandscope: array[b19..HiBand] of Boolean;
    _usebandscope_current: Boolean;
    _usebandscope_newmulti: Boolean;
    _usebandscope_allbands: Boolean;
    _bandscopecolor: array[1..12] of TColorSetting;
    _bandscope_freshness_mode: Integer;
    _bandscope_freshness_icon: Integer;

    _bandscope_use_estimated_mode: Boolean;
    _bandscope_show_only_in_bandplan: Boolean;
    _bandscope_show_ja_spots: Boolean;
    _bandscope_show_dx_spots: Boolean;
    _bandscope_use_lookup_server: Boolean;
    _bandscope_use_resume: Boolean;
    _bandscope_setfreq_after_mode_change: Boolean;
    _bandscope_always_change_mode: Boolean;
    _bandscope_save_current_freq: Boolean;

    CW : TCWSettingsParam;
    _clusterport : integer; {0 : none 1-4 : com# 5 : telnet}

    FRigControl: array[1..5] of TRigSetting;
    FRigSet: array[1..2] of TRigSet;

    _use_transceive_mode: Boolean;              // ICOM only
    _icom_polling_freq_and_mode: Boolean;       // ICOM only
    _icom_response_timeout: Integer;
    _usbif4cw_sync_wpm: Boolean;
    _usbif4cw_gen3_micsel: Boolean;
    _usbif4cw_use_paddle_keyer: Boolean;
    _polling_interval: Integer;
    _memscan_interval: Integer;  // sec

    // WinKeyer
    _use_winkeyer: Boolean;
    _use_wk_9600: Boolean;
    _use_wk_outp_select: Boolean;
    _use_wk_ignore_speed_pot: Boolean;
    _use_wk_always9600: Boolean;

    // Operate Style
    _operate_style: TOperateStyle;

    // SO2R Support
    _so2r_type: TSo2rType;       // 0:none 1:COM port 2:SO2R Neo
    _so2r_tx_port: Integer;      // 0:none 1-20:com1-20
    _so2r_rx_port: Integer;      // 0:none 1-20:com1-20
    _so2r_tx_rigc: Integer;
    _so2r_use_rig3: Boolean;
    _so2r_cq_rpt_interval_sec: Double;
    _so2r_rigsw_after_delay: Integer;
    _so2r_cq_msg_bank: Integer;     // 0:Bank-A 1:Bank-B
    _so2r_cq_msg_number: Integer;   // 1-12
    _so2r_2bsiq_pluswpm: Integer;
    _so2r_ignore_mode_change: Boolean;
    _so2r_rigselect_v28: Boolean;
    _so2r_cqrestart: Boolean;

    _zlinkport : integer; {0 : none 1-4 : com# 5: telnet}
    _clusterbaud : integer; {}

    _cluster_telnet: TCommParam;
    _cluster_com: TCommParam;
    _zlink_telnet: TCommParam;

    _multistationwarning : boolean; // true by default. turn off not new mult warning dialog
    _sentstr : string; {exchanges sent $Q$P$O etc. Set at menu select}

    _rootpath: string;
    _soundpath : string;
    _backuppath : string;
    _cfgdatpath : string;
    _logspath : string;
    _pluginpath: string;
    _pluginlist: string;

    _pttenabled : boolean;
    _pttbefore : word;
    _pttafter  : word;
    _txnr : byte;
    _pcname : string;
    _saveevery : word;
    _scorecoeff : extended;
    _age : string; // all asian
    _allowdupe : boolean;
    _output_outofperiod: Boolean;
    _use_contest_period: Boolean;
    _countdown : boolean;
    _qsycount : boolean;
    _countdownminute: Integer;
    _countperhour: Integer;

    _displongdatetime: Boolean;
    _sameexchange : boolean; //true if exchange is same for all bands. false if serial etc.
    _entersuperexchange : boolean;
    _jmode : boolean;
    _mainfontsize : integer;
    _mainrowheight : integer;

    // RIG Control/general
    _ritclear : boolean; // clear rit after each qso
    _dontallowsameband : boolean; // same band on two rigs?
    _recrigfreq : boolean; // record rig freq in memo
    _autobandmap: boolean;
    _send_freq_interval: Integer;
    _ignore_rig_mode: Boolean;
    _use_ptt_command: Boolean;
    _sync_rig_wpm: Boolean;
    _turnoff_sleep: Boolean;
    _turnon_resume: Boolean;

    _searchafter : integer; // 0 default. for super / partial check
    _savewhennocw : boolean; // def=false. save when cw is not being sent
    _maxsuperhit : integer; // max # qso hit
    _bsexpire : integer; // bandscope expiration time in minutes
    _spotexpire : integer; // spot expiration time in minutes
    _renewbythread : boolean;
    _movetomemo : boolean; // move to memo w/ spacebar when editing past qsos

    _syncserial : boolean; // synchronize serial # over network
    _switchcqsp : boolean; // switch cq/sp modes by shift+F
    _displaydatepartialcheck : boolean;

    _super_check_columns: Integer;
    _super_check2_columns: Integer;

    // QSL Default
    _qsl_default: TQslState;

    // Anti Zeroin
    FUseAntiZeroin: Boolean;
    FAntiZeroinShiftMax: Integer;   // 0-200
    FAntiZeroinRitOff: Boolean;
    FAntiZeroinXitOff: Boolean;
    FAntiZeroinRitClear: Boolean;
    FAntiZeroinXitOn1: Boolean;
    FAntiZeroinXitOn2: Boolean;
    FAntiZeroinAutoCancel: Boolean;
    FAntiZeroinStopCq: Boolean;     // Stop CQ in SP mode

    FQuickQSY: array[1..8] of TQuickQSY;
    FSuperCheck: TSuperCheckParam;
    FPartialCheck: TPartialCheckParam;
    FAccessibility: TAccessibilityParam;

    FQuickMemoText: array[1..5] of string;

    // Voice Memory
    FSoundFiles: array[1..maxmessage] of string;
    FSoundComments: array[1..maxmessage] of string;
    FAdditionalSoundFiles: array[2..3] of string;
    FAdditionalSoundComments: array[2..3] of string;
    FSoundDevice: Integer;

    // Select User Defined Contest
    FImpProvCity: Boolean;
    FImpCwMessage: array[1..4] of Boolean;
    FImpCQMessage: array[1..3] of Boolean;
    FLastCFGFileName: string;

    // スコア表示の追加情報(評価用指数)
    FLastScoreExtraInfo: Integer;

    // Time to change greetings
    FTimeToChangeGreetings: array[0..2] of Integer;

    // Last Band/Mode
    FLastBand: array[0..2] of Integer;
    FLastMode: array[0..2] of Integer;

    // Last CQ mode
    FLastCQMode: Boolean;

    // QSO Rate Graph
    FGraphStyle: TQSORateStyle;
    FGraphStartPosition: TQSORateStartPosition;
    FGraphBarColor: array[b19..HiBand] of TColor;
    FGraphTextColor: array[b19..HiBand] of TColor;
    FGraphOtherBgColor: array[0..1] of TColor;
    FGraphOtherFgColor: array[0..1] of TColor;
    FZaqAchievement: Boolean;
    FZaqBgColor: array[0..3] of TColor;
    FZaqFgColor: array[0..3] of TColor;

    // Cluster Window(Comm)
    FClusterAutoLogin: Boolean;
    FClusterAutoReconnect: Boolean;
    FClusterRelaySpot: Boolean;
    FClusterNotifyCurrentBand: Boolean;
    FClusterRecordLogs: Boolean;
    FClusterIgnoreBEL: Boolean;
    FClusterUseAllowDenyLists: Boolean;
    FClusterIgnoreSHDX: Boolean;
    FClusterReConnectMax: Integer;
    FClusterRetryIntervalSec: Integer;

    // Z-Server Messages(ChatForm)
    FChatFormPopupNewMsg: Boolean;
    FChatFormStayOnTop: Boolean;
    FChatFormRecordLogs: Boolean;
    FChatFormPrompt: Integer;

    // QuickReference
    FQuickRefFontSize: Integer;
    FQuickRefFontFace: string;

    // JARL E-LOG
    FELogSeniorJuniorCategory: string;
    FELogNewComerCategory: string;

    // Band Plan
    FBandPlanPresetList: string;

    // Guard Time after RIG Switch
    FRigSwitchGuardTime: Integer;

    // Last FileFilter Index 1:ZLO 2:ZLOX
    FLastFileFilterIndex: Integer;

    // Base FontFace Name
    FBaseFontName: string;

    // Analyze Options
    FAnalyzeExcludeZeroPoints: Boolean;
    FAnalyzeExcludeZeroHour: Boolean;
    FAnalyzeShowCW: Boolean;

    // COMM PORT TEST
    FCommPortTest: Boolean;

    // Update interval
    FInfoUpdateInterval: Integer;
  end;

  TCommPort = class(TObject)
    FPortName: string;
    FPortNumber: Integer;
    FRigControl: Boolean;
    FKeying: Boolean;
  public
    constructor Create();
    property Name: string read FPortName write FPortName;
    property Number: Integer read FPortNumber write FPortNumber;
    property RigControl: Boolean read FRigControl write FRigControl;
    property Keying: Boolean read FKeying write FKeying;
  end;

  TCommPortComparer = class(TComparer<TCommPort>)
  public
    function Compare(const Left, Right: TCommPort): Integer; override;
  end;

var
  CountDownStartTime : TDateTime = 0.0;
  QSYCount : integer = 0;

var
  SerialContestType : integer;  // 0 if no serial # or SER_ALL, SER_BAND
  SerialNumber: Integer;
  SerialArrayBand : array[b19..HiBand] of Integer;  // initialized in TContest.Create;
  SerialArrayTX : array[0..64] of Integer;

var
  GLOBALSERIAL : integer = 0;
  ZLOCOUNT : integer = 0;

type
  TdmZLogGlobal = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private 宣言 }
    FErrorLogFileName: string;
    FBandPlans: TDictionary<string, TBandPlan>;
    FCurrentBandPlan: string;
    FOpList: TOperatorInfoList;

    FTarget: TContestTarget;

    FCommPortList: TList<TCommPort>;

    FCurrentOperator: TOperatorInfo;

    FMyCountry: string;
    FMyContinent: string;
    FMyCQZone: string;
    FMyITUZone: string;

    FCtyDatLoaded: Boolean;
    FCountryList : TCountryList;
    FPrefixList : TPrefixList;
    function Load_CTYDAT(): Boolean;
    procedure AnalyzeMyCountry();

    procedure LoadIniFile; {loads Settings from zlog.ini}
    procedure LoadCfgParams(ini: TCustomIniFile);

    function GetMyCall(): string;
    procedure SetMyCall(s: string);
    function GetBand(): Integer;
    procedure SetBand(b: Integer);
    function GetMode(): TContestMode;
    procedure SetMode(m: TContestMode);
    function GetMultiOp(): TContestCategory;
    procedure SetMultiOp(i: TContestCategory);
    function GetContestMenuNo() : Integer;
    procedure SetContestMenuNo(i: Integer);
    function GetTXNr(): Byte;
    procedure SetTXNr(i: Byte);
    function GetPTTEnabled(): Boolean;
    function GetRigNameStr(Index: Integer) : string; // returns the selected rig name
    function GetSuperCheckColumns(): Integer;
    procedure SetSuperCheckColumns(v: Integer);
    function GetSuperCheck2Columns(): Integer;
    procedure SetSuperCheck2Columns(v: Integer);
    function GetPowerOfBand(band: TBand): TPower;
    function GetPowerOfBand2(band: TBand): string;
    function GetLastBand(Index: Integer): TBand;
    procedure SetLastBand(Index: Integer; b: TBand);
    function GetLastMode(Index: Integer): TMode;
    procedure SetLastMode(Index: Integer; m: TMode);

    function GetRootPath(): string;
    procedure SetRootPath(v: string);
    function GetCfgDatPath(): string;
    procedure SetCfgDatPath(v: string);
    function GetLogPath(): string;
    procedure SetLogPath(v: string);
    function GetBackupPath(): string;
    procedure SetBackupPath(v: string);
    function GetSoundPath(): string;
    procedure SetSoundPath(v: string);
    function GetPluginPath(): string;
    procedure SetPluginPath(v: string);
    function GetSpcPath(): string;
    procedure SetSpcPath(v: string);
    function GetCurrentBandPlan(): TBandPlan;
    procedure FreeCommPortList();
    function GetCommPortList(): TList<TCommPort>;
    function LoadCommPortList(): TList<TCommPort>;
public
    { Public 宣言 }
    FCurrentFileName : string;
    FLog : TLog;

    Settings : TSettingsParam;

    procedure ClearParamImportedFlag();

    procedure SaveCurrentSettings; {saves Settings to zlog.ini}
    procedure ImplementSettings(_OnCreate: boolean);
    procedure InitializeCW();

    property OpList: TOperatorInfoList read FOpList;
    property MyCall: string read GetMyCall write SetMyCall;
    property Band: Integer read GetBand write SetBand;
    property ContestMode: TContestMode read GetMode write SetMode;
    property ContestCategory: TContestCategory read GetMultiOp write SetMultiOp;
    property ContestMenuNo: Integer read GetContestMenuNo write SetContestMenuNo;
    property TXNr: Byte read GetTXNr write SetTXNr;
    property PTTEnabled: Boolean read GetPTTEnabled;
    property RigNameStr[Index: Integer]: string read GetRigNameStr;
    property SuperCheckColumns: Integer read GetSuperCheckColumns write SetSuperCheckColumns;
    property SuperCheck2Columns: Integer read GetSuperCheck2Columns write SetSuperCheck2Columns;
    property CurrentOperator: TOperatorInfo read FCurrentOperator write FCurrentOperator;

    function GetAge(aQSO : TQSO) : string;
    procedure SetOpPower(aQSO : TQSO);

    procedure SetPaddleReverse(boo : boolean);
    procedure ReversePaddle();

    function CWMessage(bank, no: Integer): string; overload;
//    function CWMessage(no: Integer): string; overload;

    procedure ReadWindowState(ini: TMemIniFile; form: TForm; strWindowName: string = ''; fPositionOnly: Boolean = False);
    procedure WriteWindowState(ini: TMemIniFile; form: TForm; strWindowName: string = '');
    procedure ReadMainFormState(ini: TMemIniFile; var X, Y, W, H: integer; var TB1, TB2: boolean);
    procedure WriteMainFormState(ini: TMemIniFile; X, Y, W, H: integer; TB1, TB2: boolean);

    procedure CreateLog();
    procedure SetLogFileName(filename: string);

    procedure MakeRigList(sl: TStrings);

    function NewQSOID(): Integer;

    function GetGreetingsCode(): string;
    function ExpandCfgDatFullPath(filename: string): string;

    function GetPrefix(strCallsign: string): TPrefix;
    function GetArea(str: string): Integer;
    function GuessCQZone(strCallsign: string): string;
    function IsUSA(): Boolean;
    function IsMultiStation(): Boolean;

    property PowerOfBand[b: TBand]: TPower read GetPowerOfBand;
    property PowerOfBand2[b: TBand]: string read GetPowerOfBand2;

    property LastBand[Index: Integer]: TBand read GetLastBand write SetLastBand;
    property LastMode[Index: Integer]: TMode read GetLastMode write SetLastMode;

    property CtyDatLoaded: Boolean read FCtyDatLoaded;
    property CountryList: TCountryList read FCountryList;
    property PrefixList: TPrefixList read FPrefixList;
    property MyCountry: string read FMyCountry;
    property MyContinent: string read FMyContinent;
    property MyCQZone: string read FMyCQZone;
    property MyITUZone: string read FMyITUZone;
    property BandPlans: TDictionary<string, TBandPlan> read FBandPlans;
    property BandPlan: TBandPlan read GetCurrentBandPlan;
    property Target: TContestTarget read FTarget;

    property RootPath: string read GetRootPath write SetRootPath;
    property CfgDatPath: string read GetCfgDatPath write SetCfgDatPath;
    property LogPath: string read GetLogPath write SetLogPath;
    property BackupPath: string read GetBackupPath write SetBackupPath;
    property SoundPath: string read GetSoundPath write SetSoundPath;
    property PluginPath: string read GetPluginPath write SetPluginPath;
    property SpcPath: string read GetSpcPath write SetSpcPath;

    property CommPortList: TList<TCommPort> read GetCommPortList;

    procedure SelectBandPlan(preset_name: string);

    procedure CreateFolders();
    procedure WriteErrorLog(msg: string);
  end;

function Log(): TLog;
function CurrentFileName(): string;
function Random10 : integer;
function UTCOffset : integer;   //in minutes; utc = localtime + utcoffset
function ContainsDoubleByteChar(S : string) : boolean;
function kHzStr(Hz : TFrequency) : string;
procedure IncEditCounter(aQSO : TQSO);
function ExtractKenNr(S : string) : string; //extracts ken nr from aja#+power
function ExtractPower(S : string) : string;
function IsSHF(B : TBand) : boolean; // true if b >= 2400MHz
function IsMM(S : string) : boolean; // return true if Marine Mobile S is a callsign
function IsWVE(S : string) : boolean; // returns true if W/VE/KH6/KL7 S is country px NOT callsign
function GetHour(T : TDateTime) : integer;
function CurrentTime : TDateTime; {returns in UTC or local time }
function LowCase(C : Char) : Char;
function OldBandOrd(band : TBand) : integer;
function NotWARC(band : TBand) : boolean;
function IsWARC(Band: TBand): Boolean;
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
procedure CenterWindow(formParent, formChild: TForm);
function Power(base, Power: integer): integer;

function StrToBandDef(strMHz: string; defband: TBand): TBand;
function StrToModeDef(strMode: string; defmode: TMode): TMode;

function PartialMatch(A, B: string): Boolean;
function PartialMatch2(strCompare, strTarget: string): Boolean;

function ZBoolToStr(fValue: Boolean): string;
function ZStrToBool(strValue: string): Boolean;

function ZStringToColorDef(str: string; defcolor: TColor): TColor;
function ZColorToString(color: TColor): string;

function ExPos(substr, str: string): Integer;

function LD(S, T: string): Integer;
function LD_dp(str1, str2: string): Integer;
function LD_ond(str1, str2: string): Integer;

function IsDomestic(strCallsign: string): Boolean;
function CheckDiskFreeSpace(strPath: string; nNeed_MegaByte: Integer): Boolean;

//procedure SetQsyViolation(aQSO: TQSO);
//procedure ResetQsyViolation(aQSO: TQSO);
procedure SetDupeQso(aQSO: TQSO);
procedure ResetDupeQso(aQSO: TQSO);

function TextToBand(text: string): TBand;
function TextToMode(text: string): TMode;
function BandToText(b: TBand): string;
function ModeToText(m: TMode): string;
function BandToPower(B: TBand): TPower;

function LoadResourceString(uID: Integer): string;

function IsFullPath(strPath: string): Boolean;
function AdjustPath(v: string): string;

function ExpandEnvironmentVariables(strOriginal: string): string;
procedure FormShowAndRestore(F: TForm);
function LoadFromResourceName(hinst: THandle; filename: string): TStringList;
function GetCommPortsForOldVersion(lpPortNumbers: PULONG; uPortNumbersCount: ULONG; var puPortNumbersFound: ULONG): ULONG;
function TrimCRLF(SS : string) : string;

var
  dmZLogGlobal: TdmZLogGlobal;

implementation

uses
  Main, URigControl, UZLinkForm, UComm, UzLogCW, UClusterTelnetSet, UClusterCOMSet,
  UZlinkTelnetSet, UzLogKeyer;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmZLogGlobal.DataModuleCreate(Sender: TObject);
var
   bandplan: TBandPlan;
   L: TStringList;
   i: Integer;
begin
   FCurrentFileName := '';
   FLog := nil;
//   CreateLog();

   ClearParamImportedFlag();

   LoadIniFile;
   Settings.CW.CurrentBank := 1;

   // オペレーターリスト
   FOpList := TOperatorInfoList.Create();
   FOpList.LoadFromIniFile();
   if FOpList.Count = 0 then begin
      FOpList.LoadFromOpList();
   end;

   FMyContinent := 'AS';
   FMyCountry := 'JA';
   FMyCQZone := '25';
   FMyITUZone := '45';

   FCountryList := TCountryList.Create();
   FPrefixList := TPrefixList.Create();
   FCtyDatLoaded := Load_CTYDAT();

   L := TStringList.Create();
   L.CommaText := Settings.FBandPlanPresetList;
   FBandPlans := TDictionary<string, TBandPlan>.Create();
   for i := 0 to L.Count - 1 do begin
      bandplan := TBandPlan.Create(L.Strings[i]);
      bandplan.LoadFromFile();
      FBandPlans.Add(bandplan.PresetName, bandplan);
   end;
   L.Free();
   FCurrentBandPlan := 'JA';

   FTarget := TContestTarget.Create();
   FTarget.LoadFromFile();

   // COMポートリスト
   FCommPortList := nil;

   // 現在のオペレーター
   FCurrentOperator := nil;

   // エラーログファイル名
   FErrorLogFileName := ExtractFileName(Application.ExeName);
   FErrorLogFileName := StringReplace(FErrorLogFileName, ExtractFileExt(FErrorLogFileName), '', [rfReplaceAll]);
   FErrorLogFileName := FErrorLogFileName + '_errorlog.txt'
end;

procedure TdmZLogGlobal.DataModuleDestroy(Sender: TObject);
var
   bandplan: TBandPlan;
begin
   for bandplan in FBandPlans.Values do begin
      bandplan.Free();
   end;
   FBandPlans.Free();

   FreeCommPortList();

   FTarget.Free();
   FCountryList.Free();
   FPrefixList.Free();
   SaveCurrentSettings();
   FOpList.Free();
   FLog.Free();
end;

procedure TdmZLogGlobal.ClearParamImportedFlag();
var
   i: Integer;
   j: Integer;
   ini: TMemIniFile;
begin
   Settings.ProvCityImported := False;

   for i := 1 to maxbank do begin
      for j := 1 to maxmessage do begin
         Settings.CW.CWStrImported[i, j] := False;
      end;
   end;
   Settings.CW.AdditionalCQMessagesImported[2] := False;
   Settings.CW.AdditionalCQMessagesImported[3] := False;

   // 対象項目を再ロード
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      LoadCfgParams(ini);
   finally
      ini.Free();
   end;
end;

procedure TdmZLogGlobal.LoadCfgParams(ini: TCustomIniFile);
begin
   // Prov/State($V)
   Settings._prov := ini.ReadString('Profiles', 'Province/State', '');

   // CITY
   Settings._city := ini.ReadString('Profiles', 'City', '');

   Settings.CW.CWStrBank[1, 1] := ini.ReadString('CW', 'F1', 'CQ TEST $M TEST');
   Settings.CW.CWStrBank[1, 2] := ini.ReadString('CW', 'F2', '$C 5NN$X');
   Settings.CW.CWStrBank[1, 3] := ini.ReadString('CW', 'F3', 'TU $M TEST');
   Settings.CW.CWStrBank[1, 4] := ini.ReadString('CW', 'F4', 'QSO B4 TU');
end;

procedure TdmZLogGlobal.LoadIniFile;
var
   i: integer;
   s: string;
   ini: TMemIniFile;
   slParam: TStringList;
   b: TBand;
   strKey: string;
begin
   slParam := TStringList.Create();
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
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

      Settings._power[b19]    := ini.ReadString('Profiles', 'Power1.9MHz', 'H');
      Settings._power[b35]    := ini.ReadString('Profiles', 'Power3.5MHz', 'H');
      Settings._power[b7]     := ini.ReadString('Profiles', 'Power7MHz', 'H');
      Settings._power[b10]    := ini.ReadString('Profiles', 'Power10MHz', 'H');
      Settings._power[b14]    := ini.ReadString('Profiles', 'Power14MHz', 'H');
      Settings._power[b18]    := ini.ReadString('Profiles', 'Power18MHz', 'H');
      Settings._power[b21]    := ini.ReadString('Profiles', 'Power21MHz', 'H');
      Settings._power[b24]    := ini.ReadString('Profiles', 'Power24MHz', 'H');
      Settings._power[b28]    := ini.ReadString('Profiles', 'Power28MHz', 'H');
      Settings._power[b50]    := ini.ReadString('Profiles', 'Power50MHz', 'H');
      Settings._power[b144]   := ini.ReadString('Profiles', 'Power144MHz', 'H');
      Settings._power[b430]   := ini.ReadString('Profiles', 'Power430MHz', 'H');
      Settings._power[b1200]  := ini.ReadString('Profiles', 'Power1200MHz', 'H');
      Settings._power[b2400]  := ini.ReadString('Profiles', 'Power2400MHz', 'H');
      Settings._power[b5600]  := ini.ReadString('Profiles', 'Power5600MHz', 'H');
      Settings._power[b10g]   := ini.ReadString('Profiles', 'Power10GHz', 'H');

      // Automatically enter exchange from SuperCheck
      Settings._entersuperexchange := ini.ReadBool('Preferences', 'AutoEnterSuper', False);

      // Display exchange on other bands
      Settings._sameexchange := ini.ReadBool('Preferences', 'SameExchange', False);

      // Display long date time
      Settings._displongdatetime := ini.ReadBool('Preferences', 'DispLongDateTime', False);

      // Multi Station Warning
      Settings._multistationwarning := ini.ReadBool('Preferences', 'MultiStationWarning', True);

      // 10 min count down
      Settings._countdown := ini.ReadBool('Preferences', 'CountDown', False);
      Settings._countdownminute := ini.ReadInteger('Preferences','CountDownMinute', 10);

      // QSY count / hr
      Settings._qsycount := ini.ReadBool('Preferences', 'QSYCount', False);
      Settings._countperhour := ini.ReadInteger('Preferences','CountPerHour', 8);

      // J-mode
      Settings._jmode := ini.ReadBool('Preferences', 'JMode', False);

      // Allow to log dupes
      Settings._allowdupe := True;  //ini.ReadBool('Preferences', 'AllowDupe', True);

      // Output out of contest period
      Settings._output_outofperiod := ini.ReadBool('Preferences', 'OutputOutOfPeriod', False);

      // Use contest period
      Settings._use_contest_period := ini.ReadBool('Preferences', 'UseContestPeriod', True);

      // Save when not sending CW
      Settings._savewhennocw := ini.ReadBool('Preferences', 'SaveWhenNoCW', False);

      // Save every N QSOs
      Settings._saveevery := ini.ReadInteger('Preferences', 'SaveEvery', 3);

      // QSL Default
      Settings._qsl_default := TQslState(ini.ReadInteger('Preferences', 'QslDefault', 0));

      //
      // Categories
      //

      // Operator
      Settings._multiop := TContestCategory(ini.ReadInteger('Categories', 'Operator2', 0));

      // Band
      Settings._band := ini.ReadInteger('Categories', 'Band', 0);

      // Mode
      Settings._mode := TContestMode(ini.ReadInteger('Categories', 'Mode', 0));

      // Select last operator
      Settings._selectlastoperator :=  ini.ReadBool('Categories', 'SelectLastOperator', True);

      // Apply power code on band change
      Settings._applypoweronbandchg :=  ini.ReadBool('Categories', 'ApplyPowerCodeOnBandChange', True);

//      // Prov/State($V)
//      Settings._prov := ini.ReadString('Profiles', 'Province/State', '');
//
//      // CITY
//      Settings._city := ini.ReadString('Profiles', 'City', '');

      // CQ Zone
      Settings._cqzone := ini.ReadString('Profiles', 'CQZone', '');

      // ITU Zone
      Settings._iaruzone := ini.ReadString('Profiles', 'IARUZone', '');

      // Power(HMLP)
      Settings._powerH := ini.ReadString('Profiles', 'PowerH', '1KW');
      Settings._powerM := ini.ReadString('Profiles', 'PowerM', '100');
      Settings._powerL := ini.ReadString('Profiles', 'PowerL', '10');
      Settings._powerP := ini.ReadString('Profiles', 'PowerP', '5');

      // Sent
//      Settings._sentstr := ini.ReadString('Profiles', 'SentStr', '');

      // CFGファイルにもある項目をロード
      LoadCfgParams(ini);

      //
      // CW/RTTY
      //

      // Messages
//      Settings.CW.CWStrBank[1, 1] := ini.ReadString('CW', 'F1', 'CQ TEST $M $M TEST');
//      Settings.CW.CWStrBank[1, 2] := ini.ReadString('CW', 'F2', '$C 5NN$X');
//      Settings.CW.CWStrBank[1, 3] := ini.ReadString('CW', 'F3', 'TU $M TEST');
//      Settings.CW.CWStrBank[1, 4] := ini.ReadString('CW', 'F4', 'QSO B4 TU');
      Settings.CW.CWStrBank[1, 5]  := ini.ReadString('CW', 'F5', 'NR?');
      Settings.CW.CWStrBank[1, 6]  := ini.ReadString('CW', 'F6', '$C?');
      Settings.CW.CWStrBank[1, 7]  := ini.ReadString('CW', 'F7', '$M');
      Settings.CW.CWStrBank[1, 8]  := ini.ReadString('CW', 'F8', '5NN$X');
      Settings.CW.CWStrBank[1, 9]  := ini.ReadString('CW', 'F9', '');
      Settings.CW.CWStrBank[1, 10] := ini.ReadString('CW', 'F10', '');
      Settings.CW.CWStrBank[1, 11] := ini.ReadString('CW', 'F11', '');
      Settings.CW.CWStrBank[1, 12] := ini.ReadString('CW', 'F12', '');

      // Additional CQ Messages
      Settings.CW.AdditionalCQMessages[2] := ini.ReadString('CW', 'CQ2', '');
      Settings.CW.AdditionalCQMessages[3] := ini.ReadString('CW', 'CQ3', '');

      Settings.CW.CWStrBank[3, 1] := ini.ReadString('RTTY', 'F1', 'CQ CQ CQ TEST $M $M $M TEST K');
      Settings.CW.CWStrBank[3, 2] := ini.ReadString('RTTY', 'F2', '$C DE $M 599$X 599$X BK');
      Settings.CW.CWStrBank[3, 3] := ini.ReadString('RTTY', 'F3', 'TU DE $M TEST');
      Settings.CW.CWStrBank[3, 4] := ini.ReadString('RTTY', 'F4', 'QSO B4 TU');
      Settings.CW.CWStrBank[3, 5] := ini.ReadString('RTTY', 'F5', 'NR? NR? AGN BK');

      for i := 6 to maxmessage do begin
         Settings.CW.CWStrBank[3, i] := ini.ReadString('RTTY', 'F' + IntToStr(i), '');
      end;

      for i := 1 to maxmessage do begin
         Settings.CW.CWStrBank[2, i] := ini.ReadString('CW', 'F' + IntToStr(i) + 'B', '');
      end;

      // Switch TAB/; with CW bank
      Settings._switchcqsp := ini.ReadBool('CW', 'CQSP', False);

      // Speed
      Settings.CW._speed := ini.ReadInteger('CW', 'Speed', 25);
      Settings.CW._fixwpm := ini.ReadInteger('CW', 'FixedSpeed', 20);

      // Weight
      Settings.CW._weight := ini.ReadInteger('CW', 'Weight', 50);

      // Paddle reverse
      Settings.CW._paddlereverse := ini.ReadBool('CW', 'PaddleReverse', False);

      // Que messages
      Settings.CW._FIFO := ini.ReadBool('CW', 'FIFO', True);

      // Side Tone
      Settings.CW._sidetone := ini.ReadBool('CW', 'use_sidetone', False);

      // Side Tone Volume
      Settings.CW._sidetone_volume := ini.ReadInteger('CW', 'sidetone_volume', 100);

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

      // Use CQ Random Repeat
      Settings.CW._cq_random_repeat := ini.ReadBool('CW', 'CQRandomRepeat', False);

      // Send NR? automatically
      Settings.CW._send_nr_auto  := ini.ReadBool('CW', 'send_nr_auto', True);

      // Not send leading zeros in serial number
      Settings.CW._not_send_leading_zeros := ini.ReadBool('CW', 'not_send_leading_zeros', False);

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

      //
      // RIG1-5
      //
      for i := 1 to 5 do begin
         s := 'RigControl#' + IntToStr(i);
         Settings.FRigControl[i].FControlPort   := ini.ReadInteger(s, 'ControlPort', 0);
         Settings.FRigControl[i].FControlPortConfig.FRts := TPortAction(ini.ReadInteger(s, 'control_port_rts', Integer(paNone)));
         Settings.FRigControl[i].FControlPortConfig.FDtr := TPortAction(ini.ReadInteger(s, 'control_port_dtr', Integer(paNone)));
         Settings.FRigControl[i].FSpeed         := ini.ReadInteger(s, 'Speed', 0);
         Settings.FRigControl[i].FRigName       := ini.ReadString(s, 'RigName', '');
         Settings.FRigControl[i].FUseTransverter := ini.ReadBool(s, 'UseTransverter', False);
         Settings.FRigControl[i].FTransverterOffset := ini.ReadInteger(s, 'TransverterOffset', 0);
         Settings.FRigControl[i].FKeyingPort    := ini.ReadInteger(s, 'KeyingPort', 0);
         Settings.FRigControl[i].FKeyingPortConfig.FRts := TPortAction(ini.ReadInteger(s, 'keying_port_rts', Integer(paPtt)));
         Settings.FRigControl[i].FKeyingPortConfig.FDtr := TPortAction(ini.ReadInteger(s, 'keying_port_dtr', Integer(paKey)));
         Settings.FRigControl[i].FPhoneChgPTT := ini.ReadBool(s, 'PhoneChgPTT', False);
      end;

      //
      // Set of RIG
      //
      for b := b19 to b10g do begin
         Settings.FRigSet[1].FRig[b] := ini.ReadInteger('RigSetA', 'Rig_' + MHzString[b], 0);
         Settings.FRigSet[1].FAnt[b] := ini.ReadInteger('RigSetA', 'Ant_' + MHzString[b], 0);
         Settings.FRigSet[2].FRig[b] := ini.ReadInteger('RigSetB', 'Rig_' + MHzString[b], 0);
         Settings.FRigSet[2].FAnt[b] := ini.ReadInteger('RigSetB', 'Ant_' + MHzString[b], 0);
      end;

      // USE TRANSCEIVE MODE(ICOM only)
      Settings._use_transceive_mode := ini.ReadBool('Hardware', 'UseTransceiveMode', True);

      // Get band and mode when polling(ICOM only)
      Settings._icom_polling_freq_and_mode := ini.ReadBool('Hardware', 'PollingFreqAndMode', False);

      // Response timeout(ICOM only)
      Settings._icom_response_timeout := ini.ReadInteger('Hardware', 'IcomResponseTimeout', 1000);

      // USBIF4CW Sync WPM
      Settings._usbif4cw_sync_wpm := ini.ReadBool('Hardware', 'Usbif4cwSyncWpm', True);

      // USBIF4CW Use Gen.3 mic. select
      Settings._usbif4cw_gen3_micsel := ini.ReadBool('Hardware', 'Usbif4cwGen3MicSelect', False);

      // Use paddle and keyer
      Settings._usbif4cw_use_paddle_keyer := ini.ReadBool('Hardware', 'Usbif4cwUsePaddleKeyer', False);

      // Polling Interval(milisec)
      Settings._polling_interval := ini.ReadInteger('Hardware', 'PollingInterval', 200);

      // Memory scan interval(sec)
      Settings._memscan_interval := ini.ReadInteger('Hardware', 'MemscanInterval', 30);

      // Use WinKeyer USB
      Settings._use_winkeyer := ini.ReadBool('Hardware', 'UseWinKeyer', False);
      Settings._use_wk_9600 := ini.ReadBool('Hardware', 'UseWk9600', False);
      Settings._use_wk_outp_select := ini.ReadBool('Hardware', 'UseWkOutpSelect', True);
      Settings._use_wk_ignore_speed_pot := ini.ReadBool('Hardware', 'UseWkIgnoreSpeedPot', False);
      Settings._use_wk_always9600 := ini.ReadBool('Hardware', 'UseWkAlways9600', False);

      // Operate Style
      Settings._operate_style := TOperateStyle(ini.ReadInteger('OPERATE_STYLE', 'style', 0));

      // SO2R Support
      Settings._so2r_type  := TSo2rType(ini.ReadInteger('SO2R', 'type', 0));
      Settings._so2r_tx_port  := ini.ReadInteger('SO2R', 'tx_select_port', 0);
      Settings._so2r_rx_port  := ini.ReadInteger('SO2R', 'rx_select_port', 0);
      Settings._so2r_tx_rigc  := ini.ReadInteger('SO2R', 'tx_rigc_option', 0);
      Settings._so2r_use_rig3 := ini.ReadBool('SO2R', 'use_rig3', True);

      Settings._so2r_cq_rpt_interval_sec := ini.ReadFloat('SO2R', 'cq_repeat_interval_sec', 2.0);
      Settings._so2r_rigsw_after_delay := ini.ReadInteger('SO2R', 'rigsw_after_delay', 200);
      Settings._so2r_cq_msg_bank    := ini.ReadInteger('SO2R', 'cq_msg_bank', 1);
      if (Settings._so2r_cq_msg_bank < 1) or (Settings._so2r_cq_msg_bank > 2) then begin
         Settings._so2r_cq_msg_bank := 1;
      end;
      Settings._so2r_cq_msg_number  := ini.ReadInteger('SO2R', 'cq_msg_number', 1);
      if (Settings._so2r_cq_msg_number < 1) or (Settings._so2r_cq_msg_number > 12) then begin
         Settings._so2r_cq_msg_number := 1;
      end;
      Settings._so2r_2bsiq_pluswpm := ini.ReadInteger('SO2R', '2bsiq_pluswpm', 3);
      Settings._so2r_ignore_mode_change := ini.ReadBool('SO2R', 'ignore_mode_change', True);
      Settings._so2r_rigselect_v28 := ini.ReadBool('SO2R', 'rigselect_v28', False);
      Settings._so2r_cqrestart := ini.ReadBool('SO2R', 'cq_restart', True);

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

      // Clear RIT after each QSO
      Settings._ritclear := ini.ReadBool('Hardware', 'RitClear', False);

      // Do not allow two rigs to be on same band
      Settings._dontallowsameband := ini.ReadBool('Rig', 'DontAllowSameBand', False);

      // Record rig frequency in memo
      Settings._recrigfreq := ini.ReadBool('Rig', 'RecordFreqInMemo', True);

      // Automatically create band scope
      Settings._autobandmap := ini.ReadBool('Rig', 'AutoBandMap', False);

      // Send current freq every
      Settings._send_freq_interval := ini.ReadInteger('Rig', 'SendFreqSec', 30);

      // Ignore RIG mode
      Settings._ignore_rig_mode := ini.ReadBool('Rig', 'IgnoreRigMode', False);

      // Use PTT command
      Settings._use_ptt_command := ini.ReadBool('Rig', 'UsePttCommand', False);

      // Sync. rig wpm
      Settings._sync_rig_wpm := ini.ReadBool('Rig', 'SyncRigWpm', False);

      // Turn off when in sleep mode
      Settings._turnoff_sleep := ini.ReadBool('Rig', 'TurnOffWhenSleepMode', True);

      // Turn on when resume
      Settings._turnon_resume := ini.ReadBool('Rig', 'TurnOnWhenResume', False);

      // Anti Zeroin
      Settings.FUseAntiZeroin := ini.ReadBool('Rig', 'use_anti_zeroin', True);
      Settings.FAntiZeroinShiftMax := Min(ini.ReadInteger('Rig', 'anti_zeroin_shift_max', 100), 200);
      Settings.FAntiZeroinRitOff := ini.ReadBool('Rig', 'anti_zeroin_rit_off', False);
      Settings.FAntiZeroinXitOff := ini.ReadBool('Rig', 'anti_zeroin_xit_off', True);
      Settings.FAntiZeroinRitClear := ini.ReadBool('Rig', 'anti_zeroin_rit_clear', False);
      Settings.FAntiZeroinXitOn1 := ini.ReadBool('Rig', 'anti_zeroin_xit_on1', True);
      Settings.FAntiZeroinXitOn2 := ini.ReadBool('Rig', 'anti_zeroin_xit_on2', False);
      Settings.FAntiZeroinAutoCancel := ini.ReadBool('Rig', 'anti_zeroin_auto_cancel', False);
      Settings.FAntiZeroinStopCq := ini.ReadBool('Rig', 'anti_zeroin_stop_cq_in_spmode', False);

      // Guard Time
      Settings.FRigSwitchGuardTime     := ini.ReadInteger('Rig', 'RigSwitchGuardTime', 100);

      // Last FileFilter Index
      Settings.FLastFileFilterIndex    := ini.ReadInteger('Preferences', 'LastFileFilterIndex', 2);

      // Base FontFace Name
      Settings.FBaseFontName           := ini.ReadString('Preferences', 'BaseFontName', 'ＭＳ ゴシック');

      // Analyze Options
      Settings.FAnalyzeExcludeZeroPoints  := ini.ReadBool('Analyze', 'exclude_zero_points', False);
      Settings.FAnalyzeExcludeZeroHour    := ini.ReadBool('Analyze', 'exclude_zero_Hour', False);
      Settings.FAnalyzeShowCW             := ini.ReadBool('Analyze', 'show_cw', False);

      //
      // Path
      //

      // Root
      Settings._rootpath := ini.ReadString('Preferences', 'RootPath', '%ZLOG_ROOT%');

      // CFG/DAT
      Settings._cfgdatpath := ini.ReadString('Preferences', 'CFGDATPath', '');
      Settings._cfgdatpath := AdjustPath(Settings._cfgdatpath);

      // Logs
      Settings._logspath := ini.ReadString('Preferences', 'LogsPath', '');
      Settings._logspath := AdjustPath(Settings._logspath);

      // Back up path
      Settings._backuppath := ini.ReadString('Preferences', 'BackUpPath', '');
      Settings._backuppath := AdjustPath(Settings._backuppath);

      // Sound path
      Settings._soundpath := ini.ReadString('Preferences', 'SoundPath', '');
      Settings._soundpath := AdjustPath(Settings._soundpath);

      // Plugin path
      Settings._pluginpath := ini.ReadString('zylo', 'path', '');
      Settings._pluginpath := AdjustPath(Settings._pluginpath);
      Settings._pluginlist := ini.ReadString('zylo', 'items', '');

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
      Settings._spotexpire := ini.ReadInteger('Misc', 'SpotExpire', 30);

      // Display date in partial check
      Settings._displaydatepartialcheck := ini.ReadBool('Misc', 'DisplayDatePartialCheck', False);

      // Update using a thread
      Settings._renewbythread := ini.ReadBool('Misc', 'UpdateUsingThread', False);

      //
      // ここから隠し設定
      //
      Settings.FInfoUpdateInterval := ini.ReadInteger('Preferences', 'InfoUpdateInterval', 1000);
      Settings.FCommPortTest := ini.ReadBool('Preferences', 'CommPortTest', False);
      Settings._movetomemo := ini.ReadBool('Preferences', 'MoveToMemoWithSpace', False);

      Settings._txnr := ini.ReadInteger('Categories', 'TXNumber', 0);
      Settings._contestmenuno := ini.ReadInteger('Categories', 'Contest', 1);
      Settings._mycall := ini.ReadString('Categories', 'MyCall', '');

      Settings.CW._interval := ini.ReadInteger('CW', 'Interval', 1);

//      Settings._specificcwport := ini.ReadInteger('Hardware', 'UseCWPort', 0 { $037A } );

      Settings._mainfontsize := ini.ReadInteger('Preferences', 'FontSize', 9);
      Settings._mainrowheight := ini.ReadInteger('Preferences', 'RowHeight', 18);

      Settings.CW._spacefactor := ini.ReadInteger('CW', 'SpaceFactor', 100);
      Settings.CW._eispacefactor := ini.ReadInteger('CW', 'EISpaceFactor', 100);

      Settings._super_check_columns := ini.ReadInteger('Windows', 'SuperCheckColumns', 0);
      Settings._super_check2_columns := ini.ReadInteger('Windows', 'SuperCheck2Columns', 0);

      Settings.ReadOnlyParamImported := ini.ReadBool('Categories', 'ReadOnlyParamImported', True);

      // QuickQSY
      for i := Low(Settings.FQuickQSY) to High(Settings.FQuickQSY) do begin
         slParam.CommaText := ini.ReadString('QuickQSY', '#' + IntToStr(i), '0,,') + ',,,,';
         Settings.FQuickQSY[i].FUse := StrToBoolDef(slParam[0], False);
         Settings.FQuickQSY[i].FBand := StrToBandDef(slParam[1], b35);
         Settings.FQuickQSY[i].FMode := StrToModeDef(slParam[2], mSSB);
         Settings.FQuickQSY[i].FRig  := StrToIntDef(slParam[3], 0);
      end;

      // SuperCheck
      Settings.FSuperCheck.FSuperCheckMethod := ini.ReadInteger('SuperCheck', 'Method', 0);
      Settings.FSuperCheck.FSuperCheckFolder := ini.ReadString('SuperCheck', 'Folder', '');
      Settings.FSuperCheck.FAcceptDuplicates := ini.ReadBool('SuperCheck', 'AcceptDuplicates', True);
      Settings.FSuperCheck.FFullMatchHighlight := ini.ReadBool('SuperCheck', 'FullMatchHighlight', True);
      Settings.FSuperCheck.FFullMatchColor := ZStringToColorDef(ini.ReadString('SuperCheck', 'FullMatchColor', '$7fffff'), clYellow);

      // Partial Check
      Settings.FPartialCheck.FCurrentBandForeColor := ZStringToColorDef(ini.ReadString('PartialCheck', 'CurrentBandForeColor', '$ff00ff'), clFuchsia);
      Settings.FPartialCheck.FCurrentBandBackColor := ZStringToColorDef(ini.ReadString('PartialCheck', 'CurrentBandBackColor', '$ffffff'), clWhite);

      // Accessibility
      Settings.FAccessibility.FFocusedForeColor := ZStringToColorDef(ini.ReadString('Accessibility', 'FocusedForeColor', '$000000'), clBlack);
      Settings.FAccessibility.FFocusedBackColor := ZStringToColorDef(ini.ReadString('Accessibility', 'FocusedBackColor', '$ffffff'), clWhite);
      Settings.FAccessibility.FFocusedBold      := ini.ReadBool('Accessibility', 'FocusedBold', False);

      // BandScope
      Settings._usebandscope[b19]   := ini.ReadBool('BandScopeEx', 'BandScope1.9MHz', False);
      Settings._usebandscope[b35]   := ini.ReadBool('BandScopeEx', 'BandScope3.5MHz', False);
      Settings._usebandscope[b7]    := ini.ReadBool('BandScopeEx', 'BandScope7MHz', False);
      Settings._usebandscope[b10]   := ini.ReadBool('BandScopeEx', 'BandScope10MHz', False);
      Settings._usebandscope[b14]   := ini.ReadBool('BandScopeEx', 'BandScope14MHz', False);
      Settings._usebandscope[b18]   := ini.ReadBool('BandScopeEx', 'BandScope18MHz', False);
      Settings._usebandscope[b21]   := ini.ReadBool('BandScopeEx', 'BandScope21MHz', False);
      Settings._usebandscope[b24]   := ini.ReadBool('BandScopeEx', 'BandScope24MHz', False);
      Settings._usebandscope[b28]   := ini.ReadBool('BandScopeEx', 'BandScope28MHz', False);
      Settings._usebandscope[b50]   := ini.ReadBool('BandScopeEx', 'BandScope50MHz', False);
      Settings._usebandscope[b144]  := ini.ReadBool('BandScopeEx', 'BandScope144MHz', False);
      Settings._usebandscope[b430]  := ini.ReadBool('BandScopeEx', 'BandScope430MHz', False);
      Settings._usebandscope[b1200] := ini.ReadBool('BandScopeEx', 'BandScope1200MHz', False);
      Settings._usebandscope[b2400] := ini.ReadBool('BandScopeEx', 'BandScope2400MHz', False);
      Settings._usebandscope[b5600] := ini.ReadBool('BandScopeEx', 'BandScope5600MHz', False);
      Settings._usebandscope[b10g]  := ini.ReadBool('BandScopeEx', 'BandScope10GHz', False);
      Settings._usebandscope_current := ini.ReadBool('BandScope', 'Current', False);
      Settings._usebandscope_newmulti := ini.ReadBool('BandScope', 'NewMulti', False);
      Settings._usebandscope_allbands := ini.ReadBool('BandScope', 'AllBands', False);
      Settings._bandscopecolor[1].FForeColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'ForeColor1', '$000000'), clBlack);
      Settings._bandscopecolor[1].FBackColor := clWhite; //ZStringToColorDef(ini.ReadString('BandScopeEx', 'BackColor1', '$ffffff'), clWhite);
      Settings._bandscopecolor[1].FBold      := ini.ReadBool('BandScopeEx', 'Bold1', True);
      Settings._bandscopecolor[2].FForeColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'ForeColor2', '$0000ff'), clRed);
      Settings._bandscopecolor[2].FBackColor := clWhite; //ZStringToColorDef(ini.ReadString('BandScopeEx', 'BackColor2', '$0000ff'), clRed);
      Settings._bandscopecolor[2].FBold      := ini.ReadBool('BandScopeEx', 'Bold2', True);
      Settings._bandscopecolor[3].FForeColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'ForeColor3', '$008000'), clGreen);
      Settings._bandscopecolor[3].FBackColor := clWhite; //ZStringToColorDef(ini.ReadString('BandScopeEx', 'BackColor3', '$ffffff'), clWhite);
      Settings._bandscopecolor[3].FBold      := ini.ReadBool('BandScopeEx', 'Bold3', True);
      Settings._bandscopecolor[4].FForeColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'ForeColor4', '$008000'), clGreen);
      Settings._bandscopecolor[4].FBackColor := clWhite; //ZStringToColorDef(ini.ReadString('BandScopeEx', 'BackColor4', '$ffffff'), clWhite);
      Settings._bandscopecolor[4].FBold      := ini.ReadBool('BandScopeEx', 'Bold4', True);
      Settings._bandscopecolor[5].FForeColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'ForeColor5', '$000000'), clBlack);
      Settings._bandscopecolor[5].FBackColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'BackColor5', '$ffffff'), clWhite);
      Settings._bandscopecolor[5].FBold      := ini.ReadBool('BandScopeEx', 'Bold5', True);
      Settings._bandscopecolor[6].FForeColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'ForeColor6', '$000000'), clBlack);
      Settings._bandscopecolor[6].FBackColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'BackColor6', '$ffffff'), clWhite);
      Settings._bandscopecolor[6].FBold      := ini.ReadBool('BandScopeEx', 'Bold6', True);
      Settings._bandscopecolor[7].FForeColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'ForeColor7', '$000000'), clBlack);
      Settings._bandscopecolor[7].FBackColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'BackColor7', '$ffffff'), clWhite);
      Settings._bandscopecolor[7].FBold      := ini.ReadBool('BandScopeEx', 'Bold7', True);
      Settings._bandscopecolor[8].FForeColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'ForeColor8', '$000000'), clBlack);
      Settings._bandscopecolor[8].FBackColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'BackColor8', '$ffffff'), clWhite);
      Settings._bandscopecolor[8].FBold      := ini.ReadBool('BandScopeEx', 'Bold8', True);
      Settings._bandscopecolor[9].FForeColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'ForeColor9', '$000000'), clBlack);
      Settings._bandscopecolor[9].FBackColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'BackColor9', '$ffffff'), clWhite);
      Settings._bandscopecolor[9].FBold      := ini.ReadBool('BandScopeEx', 'Bold9', True);
      Settings._bandscopecolor[10].FForeColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'ForeColor10', '$000000'), clBlack);
      Settings._bandscopecolor[10].FBackColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'BackColor10', '$ffffff'), clWhite);
      Settings._bandscopecolor[10].FBold      := ini.ReadBool('BandScopeEx', 'Bold10', True);
      Settings._bandscopecolor[11].FForeColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'ForeColor11', '$000000'), clBlack);
      Settings._bandscopecolor[11].FBackColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'BackColor11', '$ffffff'), clWhite);
      Settings._bandscopecolor[11].FBold      := ini.ReadBool('BandScopeEx', 'Bold11', True);
      Settings._bandscopecolor[12].FForeColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'ForeColor12', '$000000'), clBlack);
      Settings._bandscopecolor[12].FBackColor := ZStringToColorDef(ini.ReadString('BandScopeEx', 'BackColor12', '$ffffff'), clWhite);
      Settings._bandscopecolor[12].FBold      := ini.ReadBool('BandScopeEx', 'Bold12', True);

      Settings._bandscope_freshness_mode := ini.ReadInteger('BandScopeEx', 'freshness_mode', 0);
      Settings._bandscope_freshness_icon := ini.ReadInteger('BandScopeEx', 'freshness_icon', 0);

      Settings._bandscope_use_estimated_mode := ini.ReadBool('BandScopeOptions', 'use_estimated_mode', True);
      Settings._bandscope_show_only_in_bandplan := ini.ReadBool('BandScopeOptions', 'show_only_in_bandplan', True);
      Settings._bandscope_show_ja_spots := ini.ReadBool('BandScopeOptions', 'show_ja_spots', True);
      Settings._bandscope_show_dx_spots := ini.ReadBool('BandScopeOptions', 'show_dx_spots', False);
      Settings._bandscope_use_lookup_server := ini.ReadBool('BandScopeOptions', 'use_lookup_server', False);
      Settings._bandscope_use_resume := ini.ReadBool('BandScopeOptions', 'use_resume', False);
      Settings._bandscope_setfreq_after_mode_change := ini.ReadBool('BandScopeOptions', 'setfreq_after_mode_change', False);
      Settings._bandscope_always_change_mode := ini.ReadBool('BandScopeOptions', 'always_change_mode', True);
      Settings._bandscope_save_current_freq := ini.ReadBool('BandScopeOptions', 'save_current_freq', True);

      // Quick Memo
      Settings.FQuickMemoText[1] := ini.ReadString('QuickMemo', '#1', '');
      Settings.FQuickMemoText[2] := ini.ReadString('QuickMemo', '#2', '');
      Settings.FQuickMemoText[3] := ini.ReadString('QuickMemo', '#3', '');
      Settings.FQuickMemoText[4] := ini.ReadString('QuickMemo', '#4', '');
      Settings.FQuickMemoText[5] := ini.ReadString('QuickMemo', '#5', '');

      // Voice Memory
      for i := 1 to maxmessage do begin
         s := ini.ReadString('Voice', 'F#' + IntToStr(i), '');
         if s = '' then begin
            Settings.FSoundFiles[i] := '';
            Settings.FSoundComments[i] := '';
         end
         else begin
            if FileExists(s) = True then begin
               Settings.FSoundFiles[i] := s;
               Settings.FSoundComments[i] := ini.ReadString('Voice', 'C#' + IntToStr(i), '');
            end
            else begin
               Settings.FSoundFiles[i] := '';
               Settings.FSoundComments[i] := 'file not found';
            end;
         end;
      end;
      for i := 2 to 3 do begin
         s := ini.ReadString('Voice', 'CQ_F#' + IntToStr(i), '');
         if s = '' then begin
            Settings.FAdditionalSoundFiles[i] := '';
            Settings.FAdditionalSoundComments[i] := '';
         end
         else begin
            if FileExists(s) = True then begin
               Settings.FAdditionalSoundFiles[i] := s;
               Settings.FAdditionalSoundComments[i] := ini.ReadString('Voice', 'CQ_C#' + IntToStr(i), '');
            end
            else begin
               Settings.FAdditionalSoundFiles[i] := '';
               Settings.FAdditionalSoundComments[i] := 'file not found';
            end;
         end;
      end;

      // output device
      Settings.FSoundDevice := ini.ReadInteger('Voice', 'device', 0);

      // Select User Defined Contest
      Settings.FImpProvCity := ini.ReadBool('UserDefinedContest', 'imp_prov_city', True);
      Settings.FImpCwMessage[1] := ini.ReadBool('UserDefinedContest', 'imp_f1a', True);
      Settings.FImpCwMessage[2] := ini.ReadBool('UserDefinedContest', 'imp_f2a', True);
      Settings.FImpCwMessage[3] := ini.ReadBool('UserDefinedContest', 'imp_f3a', False);
      Settings.FImpCwMessage[4] := ini.ReadBool('UserDefinedContest', 'imp_f4a', False);
      Settings.FImpCQMessage[2] := ini.ReadBool('UserDefinedContest', 'imp_cq2', False);
      Settings.FImpCQMessage[3] := ini.ReadBool('UserDefinedContest', 'imp_cq3', False);
      Settings.FLastCFGFileName := ini.ReadString('UserDefinedContest', 'last_cfgfilename', '');

      // スコア表示の追加情報(評価用指数)
      Settings.FLastScoreExtraInfo := ini.ReadInteger('Score', 'ExtraInfo', 0);

      // Time to change greetings
      Settings.FTimeToChangeGreetings[0] := ini.ReadInteger('greetings', 'morning', 0);
      Settings.FTimeToChangeGreetings[1] := ini.ReadInteger('greetings', 'afternoon', 12);
      Settings.FTimeToChangeGreetings[2] := ini.ReadInteger('greetings', 'evening', 18);

      // Last Band/Mode
      Settings.FLastBand[0] := ini.ReadInteger('main', 'last_band', 0);
      Settings.FLastMode[0] := ini.ReadInteger('main', 'last_mode', 0);
      Settings.FLastBand[1] := ini.ReadInteger('main', 'last_band1', 0);
      Settings.FLastMode[1] := ini.ReadInteger('main', 'last_mode1', 0);
      Settings.FLastBand[2] := ini.ReadInteger('main', 'last_band2', 0);
      Settings.FLastMode[2] := ini.ReadInteger('main', 'last_mode2', 0);

      // Last CQ mode
      Settings.FLastCQMode := ini.ReadBool('main', 'last_cqmode', False);

      // QSO Rate Graph
      Settings.FGraphStyle := TQSORateStyle(ini.ReadInteger('Graph', 'Style', 0));
      Settings.FGraphStartPosition := TQSORateStartPosition(ini.ReadInteger('Graph', 'StartPosition', 1));
      for b := b19 to HiBand do begin
         strKey := MHzString[b];
         Settings.FGraphBarColor[b]  := ZStringToColorDef(ini.ReadString('Graph', strKey + '_BarColor',  ''), default_graph_bar_color[b]);
         Settings.FGraphTextColor[b] := ZStringToColorDef(ini.ReadString('Graph', strKey + '_TextColor', ''), default_graph_text_color[b]);
      end;

      for i := 0 to 1 do begin
         strKey := IntToStr(i);
         Settings.FGraphOtherBgColor[i] := ZStringToColorDef(ini.ReadString('Graph', 'BgColor' + strKey, ''), default_other_bg_color[i]);
         Settings.FGraphOtherFgColor[i] := ZStringToColorDef(ini.ReadString('Graph', 'FgColor' + strKey, ''), default_other_fg_color[i]);
      end;

      Settings.FZaqAchievement      := ini.ReadBool('rateex_zaq', 'achievement', True);

      for i := 0 to 3 do begin
         strKey := IntToStr(i);
         Settings.FZaqBgColor[i] := ZStringToColorDef(ini.ReadString('rateex_zaq', 'BgColor' + strKey, ''), default_zaq_bg_color[i]);
         Settings.FZaqFgColor[i] := ZStringToColorDef(ini.ReadString('rateex_zaq', 'FgColor' + strKey, ''), default_zaq_fg_color[i]);
      end;

      // Cluster Window(Comm)
      Settings.FClusterAutoLogin       := ini.ReadBool('ClusterWindow', 'AutoLogin', True);
      Settings.FClusterAutoReconnect   := ini.ReadBool('ClusterWindow', 'AutoReconnect', True);
      Settings.FClusterRelaySpot       := ini.ReadBool('ClusterWindow', 'RelaySpot', False);
      Settings.FClusterNotifyCurrentBand := ini.ReadBool('ClusterWindow', 'NotifyCurrentBand', False);
      Settings.FClusterRecordLogs      := ini.ReadBool('ClusterWindow', 'RecordLogs', False);
      Settings.FClusterIgnoreBEL       := ini.ReadBool('ClusterWindow', 'IgnoreBEL', True);
      Settings.FClusterUseAllowDenyLists := ini.ReadBool('ClusterWindow', 'UseAllowDenyLists', False);
      Settings.FClusterIgnoreSHDX      := ini.ReadBool('ClusterWindow', 'IgnoreSHDX', True);
      Settings.FClusterReConnectMax    := ini.ReadInteger('ClusterWindow', 'ReConnectMax', 10);
      Settings.FClusterRetryIntervalSec := ini.ReadInteger('ClusterWindow', 'RetryIntervalSec', 180);

      // Z-Server Messages(ChatForm)
      Settings.FChatFormPopupNewMsg    := ini.ReadBool('ChatWindow', 'PopupNewMsg', False);
      Settings.FChatFormStayOnTop      := ini.ReadBool('ChatWindow', 'StayOnTop', False);
      Settings.FChatFormRecordLogs     := ini.ReadBool('ChatWindow', 'RecordLogs', True);
      Settings.FChatFormPrompt         := ini.ReadInteger('ChatWindow', 'Prompt', 0);

      // Quick Reference
      Settings.FQuickRefFontSize       := ini.ReadInteger('QuickReference', 'FontSize', 9);
      Settings.FQuickRefFontFace       := ini.ReadString('QuickReference', 'FontFace', 'ＭＳ ゴシック');

      // JARL E-LOG
      Settings.FELogSeniorJuniorCategory  := ini.ReadString('ELOG', 'SeniorJunior', 'XS,CS,SOSV,SOJR');
      Settings.FELogNewComerCategory      := ini.ReadString('ELOG', 'NewComer', 'PN');

      // Band Plan
      Settings.FBandPlanPresetList := ini.ReadString('BandPlan', 'PresetNameList', 'JA,DX');
   finally
      ini.Free();
      slParam.Free();
   end;
end;

procedure TdmZLogGlobal.SaveCurrentSettings;
var
   i: integer;
   ini: TMemIniFile;
   slParam: TStringList;
   b: TBand;
   strKey: string;
   s: string;
begin
   slParam := TStringList.Create();
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
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

      ini.WriteString('Profiles', 'Power1.9MHz',   Settings._power[b19]);
      ini.WriteString('Profiles', 'Power3.5MHz',   Settings._power[b35]);
      ini.WriteString('Profiles', 'Power7MHz',     Settings._power[b7]);
      ini.WriteString('Profiles', 'Power10MHz',    Settings._power[b10]);
      ini.WriteString('Profiles', 'Power14MHz',    Settings._power[b14]);
      ini.WriteString('Profiles', 'Power18MHz',    Settings._power[b18]);
      ini.WriteString('Profiles', 'Power21MHz',    Settings._power[b21]);
      ini.WriteString('Profiles', 'Power24MHz',    Settings._power[b24]);
      ini.WriteString('Profiles', 'Power28MHz',    Settings._power[b28]);
      ini.WriteString('Profiles', 'Power50MHz',    Settings._power[b50]);
      ini.WriteString('Profiles', 'Power144MHz',   Settings._power[b144]);
      ini.WriteString('Profiles', 'Power430MHz',   Settings._power[b430]);
      ini.WriteString('Profiles', 'Power1200MHz',  Settings._power[b1200]);
      ini.WriteString('Profiles', 'Power2400MHz',  Settings._power[b2400]);
      ini.WriteString('Profiles', 'Power5600MHz',  Settings._power[b5600]);
      ini.WriteString('Profiles', 'Power10GHz',    Settings._power[b10g]);

      // Automatically enter exchange from SuperCheck
      ini.WriteBool('Preferences', 'AutoEnterSuper', Settings._entersuperexchange);

      // Display exchange on other bands
      ini.WriteBool('Preferences', 'SameExchange', Settings._sameexchange);

      // Display long date time
      ini.WriteBool('Preferences', 'DispLongDateTime', Settings._displongdatetime);

      // Multi Station Warning
      ini.WriteBool('Preferences', 'MultiStationWarning', Settings._multistationwarning);

      // 10 min count down
      ini.WriteBool('Preferences', 'CountDown', Settings._countdown);
      ini.WriteInteger('Preferences','CountDownMinute', Settings._countdownminute);

      // QSY count / hr
      ini.WriteBool('Preferences', 'QSYCount', Settings._qsycount);
      ini.WriteInteger('Preferences','CountPerHour', Settings._countperhour);

      // J-mode
      ini.WriteBool('Preferences', 'JMode', Settings._jmode);

      // Allow to log dupes
      ini.WriteBool('Preferences', 'AllowDupe', Settings._allowdupe);

      // Output out of contest period
      ini.WriteBool('Preferences', 'OutputOutOfPeriod', Settings._output_outofperiod);

      // Use contest period
      ini.WriteBool('Preferences', 'UseContestPeriod', Settings._use_contest_period);

      // Save when not sending CW
      ini.WriteBool('Preferences', 'SaveWhenNoCW', Settings._savewhennocw);

      // Save every N QSOs
      ini.WriteInteger('Preferences', 'SaveEvery', Settings._saveevery);

      // QSL Default
      ini.WriteInteger('Preferences', 'QslDefault', Integer(Settings._qsl_default));

      //
      // Categories
      //

      // Operator
      ini.WriteInteger('Categories', 'Operator2', Integer(Settings._multiop));

      // Band
      ini.WriteInteger('Categories', 'Band', Settings._band);

      // Mode
      ini.WriteInteger('Categories', 'Mode', Integer(Settings._mode));

      // Select last operator
      ini.WriteBool('Categories', 'SelectLastOperator', Settings._selectlastoperator);

      // Apply power code on band change
      ini.WriteBool('Categories', 'ApplyPowerCodeOnBandChange', Settings._applypoweronbandchg);

      if Settings.ProvCityImported = False then begin
         // Prov/State($V)
         ini.WriteString('Profiles', 'Province/State', Settings._prov);

         // CITY
         ini.WriteString('Profiles', 'City', Settings._city);
      end;

      // CQ Zone
      ini.WriteString('Profiles', 'CQZone', Settings._cqzone);

      // ITU Zone
      ini.WriteString('Profiles', 'IARUZone', Settings._iaruzone);

      // Power(HMLP)
      ini.WriteString('Profiles', 'PowerH', Settings._powerH);
      ini.WriteString('Profiles', 'PowerM', Settings._powerM);
      ini.WriteString('Profiles', 'PowerL', Settings._powerL);
      ini.WriteString('Profiles', 'PowerP', Settings._powerP);

      // Sent
//      ini.WriteString('Profiles', 'SentStr', Settings._sentstr);

      //
      // CW/RTTY
      //

      // Messages
      for i := 1 to maxmessage do begin
         if Settings.CW.CWStrImported[1, i] = False then begin
            ini.WriteString('CW', 'F' + IntToStr(i), Settings.CW.CWStrBank[1, i]);
         end;
         ini.WriteString('CW', 'F' + IntToStr(i) + 'B', Settings.CW.CWStrBank[2, i]);
         ini.WriteString('RTTY', 'F' + IntToStr(i), Settings.CW.CWStrBank[3, i]);
      end;

      // Additional CQ Messages
      ini.WriteString('CW', 'CQ2', Settings.CW.AdditionalCQMessages[2]);
      ini.WriteString('CW', 'CQ3', Settings.CW.AdditionalCQMessages[3]);

      // Switch TAB/; with CW bank
      ini.WriteBool('CW', 'CQSP', Settings._switchcqsp);

      // Speed
      ini.WriteInteger('CW', 'Speed', Settings.CW._speed);
      ini.WriteInteger('CW', 'FixedSpeed', Settings.CW._fixwpm);

      // Weight
      ini.WriteInteger('CW', 'Weight', Settings.CW._weight);

      // Paddle reverse
      ini.WriteBool('CW', 'PaddleReverse', Settings.CW._paddlereverse);

      // Que messages
      ini.WriteBool('CW', 'FIFO', Settings.CW._FIFO);

      // Side Tone
      ini.WriteBool('CW', 'use_sidetone', Settings.CW._sidetone);

      // Side Tone Volume
      ini.WriteInteger('CW', 'sidetone_volume', Settings.CW._sidetone_volume);

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

      // Use CQ Random Repeat
      ini.WriteBool('CW', 'CQRandomRepeat', Settings.CW._cq_random_repeat);

      // Send NR? automatically
      ini.WriteBool('CW', 'send_nr_auto', Settings.CW._send_nr_auto);

      // Not send leading zeros in serial number
      ini.ReadBool('CW', 'not_send_leading_zeros', Settings.CW._not_send_leading_zeros);

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

      //
      // RIG1-5
      //
      for i := 1 to 5 do begin
         s := 'RigControl#' + IntToStr(i);
         ini.WriteInteger(s, 'ControlPort', Settings.FRigControl[i].FControlPort);
         ini.WriteInteger(s, 'control_port_rts', Integer(Settings.FRigControl[i].FControlPortConfig.FRts));
         ini.WriteInteger(s, 'control_port_dtr', Integer(Settings.FRigControl[i].FControlPortConfig.FDtr));
         ini.WriteInteger(s, 'Speed', Settings.FRigControl[i].FSpeed);
         ini.WriteString(s, 'RigName', Settings.FRigControl[i].FRigName);
         ini.WriteInteger(s, 'KeyingPort', Settings.FRigControl[i].FKeyingPort);
         ini.WriteBool(s, 'UseTransverter', Settings.FRigControl[i].FUseTransverter);
         ini.WriteInteger(s, 'TransverterOffset', Settings.FRigControl[i].FTransverterOffset);
         ini.WriteInteger(s, 'keying_port_rts', Integer(Settings.FRigControl[i].FKeyingPortConfig.FRts));
         ini.WriteInteger(s, 'keying_port_dtr', Integer(Settings.FRigControl[i].FKeyingPortConfig.FDtr));
         ini.WriteBool(s, 'PhoneChgPTT', Settings.FRigControl[i].FPhoneChgPTT);
      end;

      //
      // Set of RIG
      //
      for b := b19 to b10g do begin
         ini.WriteInteger('RigSetA', 'Rig_' + MHzString[b], Settings.FRigSet[1].FRig[b]);
         ini.WriteInteger('RigSetA', 'Ant_' + MHzString[b], Settings.FRigSet[1].FAnt[b]);
         ini.WriteInteger('RigSetB', 'Rig_' + MHzString[b], Settings.FRigSet[2].FRig[b]);
         ini.WriteInteger('RigSetB', 'Ant_' + MHzString[b], Settings.FRigSet[2].FAnt[b]);
      end;

      // USE TRANSCEIVE MODE(ICOM only)
      ini.WriteBool('Hardware', 'UseTransceiveMode', Settings._use_transceive_mode);

      // Get band and mode when polling(ICOM only)
      ini.WriteBool('Hardware', 'PollingFreqAndMode', Settings._icom_polling_freq_and_mode);

      // Response timeout(ICOM only)
      ini.WriteInteger('Hardware', 'IcomResponseTimeout', Settings._icom_response_timeout);

      // USBIF4CW Sync WPM
      ini.WriteBool('Hardware', 'Usbif4cwSyncWpm', Settings._usbif4cw_sync_wpm);

      // USBIF4CW Use Gen.3 mic. select
      ini.WriteBool('Hardware', 'Usbif4cwGen3MicSelect', Settings._usbif4cw_gen3_micsel);

      // USBIF4CW Use paddle and keyer
      ini.WriteBool('Hardware', 'Usbif4cwUsePaddleKeyer', Settings._usbif4cw_use_paddle_keyer);

      // Polling Interval
      ini.WriteInteger('Hardware', 'PollingInterval', Settings._polling_interval);

      // Memory scan interval(sec)
      ini.WriteInteger('Hardware', 'MemscanInterval', Settings._memscan_interval);

      // Use WinKeyer USB
      ini.WriteBool('Hardware', 'UseWinKeyer', Settings._use_winkeyer);
      ini.WriteBool('Hardware', 'UseWk9600', Settings._use_wk_9600);
      ini.WriteBool('Hardware', 'UseWkOutpSelect', Settings._use_wk_outp_select);
      ini.WriteBool('Hardware', 'UseWkIgnoreSpeedPot', Settings._use_wk_ignore_speed_pot);
      ini.WriteBool('Hardware', 'UseWkAlways9600', Settings._use_wk_always9600);

      // Operate Style
      ini.WriteInteger('OPERATE_STYLE', 'style', Integer(Settings._operate_style));

      // SO2R Support
      ini.WriteInteger('SO2R', 'type', Integer(Settings._so2r_type));
      ini.WriteInteger('SO2R', 'tx_select_port', Settings._so2r_tx_port);
      ini.WriteInteger('SO2R', 'rx_select_port', Settings._so2r_rx_port);
      ini.WriteInteger('SO2R', 'tx_rigc_option', Settings._so2r_tx_rigc);
      ini.WriteBool('SO2R', 'use_rig3', Settings._so2r_use_rig3);

      ini.WriteFloat('SO2R', 'cq_repeat_interval_sec', Settings._so2r_cq_rpt_interval_sec);
      ini.WriteInteger('SO2R', 'rigsw_after_delay', Settings._so2r_rigsw_after_delay);
      ini.WriteInteger('SO2R', 'cq_msg_bank', Settings._so2r_cq_msg_bank);
      ini.WriteInteger('SO2R', 'cq_msg_number', Settings._so2r_cq_msg_number);
      ini.WriteInteger('SO2R', '2bsiq_pluswpm', Settings._so2r_2bsiq_pluswpm);
      ini.WriteBool('SO2R', 'ignore_mode_change', Settings._so2r_ignore_mode_change);
      ini.WriteBool('SO2R', 'rigselect_v28', Settings._so2r_rigselect_v28);
      ini.WriteBool('SO2R', 'cq_restart', Settings._so2r_cqrestart);

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

      // Clear RIT after each QSO
      ini.WriteBool('Hardware', 'RitClear', Settings._ritclear);

      // Do not allow two rigs to be on same band
      ini.WriteBool('Rig', 'DontAllowSameBand', Settings._dontallowsameband);

      // Record rig frequency in memo
      ini.WriteBool('Rig', 'RecordFreqInMemo', Settings._recrigfreq);

      // Automatically create band scope
      ini.WriteBool('Rig', 'AutoBandMap', Settings._autobandmap);

      // Send current freq every
      ini.WriteInteger('Rig', 'SendFreqSec', Settings._send_freq_interval);

      // Ignore RIG mode
      ini.WriteBool('Rig', 'IgnoreRigMode', Settings._ignore_rig_mode);

      // Use PTT command
      ini.WriteBool('Rig', 'UsePttCommand', Settings._use_ptt_command);

      // Sync. rig wpm
      ini.WriteBool('Rig', 'SyncRigWpm', Settings._sync_rig_wpm);

      // Turn off when in sleep mode
      ini.WriteBool('Rig', 'TurnOffWhenSleepMode', Settings._turnoff_sleep);

      // Turn on when resume
      ini.WriteBool('Rig', 'TurnOnWhenResume', Settings._turnon_resume);

      // Anti Zeroin
      ini.WriteBool('Rig', 'use_anti_zeroin', Settings.FUseAntiZeroin);
      ini.WriteInteger('Rig', 'anti_zeroin_shift_max', Settings.FAntiZeroinShiftMax);
      ini.WriteBool('Rig', 'anti_zeroin_rit_off', Settings.FAntiZeroinRitOff);
      ini.WriteBool('Rig', 'anti_zeroin_xit_off', Settings.FAntiZeroinXitOff);
      ini.WriteBool('Rig', 'anti_zeroin_rit_clear', Settings.FAntiZeroinRitClear);
      ini.WriteBool('Rig', 'anti_zeroin_xit_on1', Settings.FAntiZeroinXitOn1);
      ini.WriteBool('Rig', 'anti_zeroin_xit_on2', Settings.FAntiZeroinXitOn2);
      ini.WriteBool('Rig', 'anti_zeroin_auto_cancel', Settings.FAntiZeroinAutoCancel);
      ini.WriteBool('Rig', 'anti_zeroin_stop_cq_in_spmode', Settings.FAntiZeroinStopCq);

      // Guard Time
      ini.WriteInteger('Rig', 'RigSwitchGuardTime', Settings.FRigSwitchGuardTime);

      // Last FileFilter Index
      ini.WriteInteger('Preferences', 'LastFileFilterIndex', Settings.FLastFileFilterIndex);

      // Base FontFace Name
      ini.WriteString('Preferences', 'BaseFontName', Settings.FBaseFontName);

      // Analyze Options
      ini.WriteBool('Analyze', 'exclude_zero_points', Settings.FAnalyzeExcludeZeroPoints);
      ini.WriteBool('Analyze', 'exclude_zero_Hour', Settings.FAnalyzeExcludeZeroHour);
      ini.WriteBool('Analyze', 'show_cw', Settings.FAnalyzeShowCW);

      //
      // Path
      //

      // Root
      ini.WriteString('Preferences', 'RootPath', Settings._rootpath);

      // CFG/DAT
      ini.WriteString('Preferences', 'CFGDATPath', Settings._cfgdatpath);

      // Logs
      ini.WriteString('Preferences', 'LogsPath', Settings._logspath);

      // Back up path
      ini.WriteString('Preferences', 'BackUpPath', Settings._backuppath);

      // Sound path
      ini.WriteString('Preferences', 'SoundPath', Settings._soundpath);

      // Plugin path
      ini.WriteString('zylo', 'path', Settings._pluginpath);
      ini.WriteString('zylo', 'items', Settings._pluginlist);

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
      ini.WriteInteger('Windows', 'SuperCheck2Columns', Settings._super_check2_columns);

      // QuickQSY
      for i := Low(Settings.FQuickQSY) to High(Settings.FQuickQSY) do begin
         slParam.Clear();
         slParam.Add( BoolToStr(Settings.FQuickQSY[i].FUse, False) );
         slParam.Add( MHzString[ Settings.FQuickQSY[i].FBand ]);
         slParam.Add( MODEString[ Settings.FQuickQSY[i].FMode ]);
         slParam.Add( IntToStr(Settings.FQuickQSY[i].FRig) );
         ini.WriteString('QuickQSY', '#' + IntToStr(i), slParam.CommaText);
      end;

      // SuperCheck
      ini.WriteInteger('SuperCheck', 'Method', Settings.FSuperCheck.FSuperCheckMethod);
      ini.WriteString('SuperCheck', 'Folder', Settings.FSuperCheck.FSuperCheckFolder);
      ini.WriteBool('SuperCheck', 'AcceptDuplicates', Settings.FSuperCheck.FAcceptDuplicates);
      ini.WriteBool('SuperCheck', 'FullMatchHighlight', Settings.FSuperCheck.FFullMatchHighlight);
      ini.WriteString('SuperCheck', 'FullMatchColor', ZColorToString(Settings.FSuperCheck.FFullMatchColor));

      // Partial Check
      ini.WriteString('PartialCheck', 'CurrentBandForeColor', ZColorToString(Settings.FPartialCheck.FCurrentBandForeColor));
      ini.WriteString('PartialCheck', 'CurrentBandBackColor', ZColorToString(Settings.FPartialCheck.FCurrentBandBackColor));

      // Accessibility
      ini.WriteString('Accessibility', 'FocusedForeColor', ZColorToString(Settings.FAccessibility.FFocusedForeColor));
      ini.WriteString('Accessibility', 'FocusedBackColor', ZColorToString(Settings.FAccessibility.FFocusedBackColor));
      ini.WriteBool('Accessibility', 'FocusedBold', Settings.FAccessibility.FFocusedBold);

      // BandScope
      ini.WriteBool('BandScopeEx', 'BandScope1.9MHz', Settings._usebandscope[b19]);
      ini.WriteBool('BandScopeEx', 'BandScope3.5MHz', Settings._usebandscope[b35]);
      ini.WriteBool('BandScopeEx', 'BandScope7MHz', Settings._usebandscope[b7]);
      ini.WriteBool('BandScopeEx', 'BandScope10MHz', Settings._usebandscope[b10]);
      ini.WriteBool('BandScopeEx', 'BandScope14MHz', Settings._usebandscope[b14]);
      ini.WriteBool('BandScopeEx', 'BandScope18MHz', Settings._usebandscope[b18]);
      ini.WriteBool('BandScopeEx', 'BandScope21MHz', Settings._usebandscope[b21]);
      ini.WriteBool('BandScopeEx', 'BandScope24MHz', Settings._usebandscope[b24]);
      ini.WriteBool('BandScopeEx', 'BandScope28MHz', Settings._usebandscope[b28]);
      ini.WriteBool('BandScopeEx', 'BandScope50MHz', Settings._usebandscope[b50]);
      ini.WriteBool('BandScopeEx', 'BandScope144MHz', Settings._usebandscope[b144]);
      ini.WriteBool('BandScopeEx', 'BandScope430MHz', Settings._usebandscope[b430]);
      ini.WriteBool('BandScopeEx', 'BandScope1200MHz', Settings._usebandscope[b1200]);
      ini.WriteBool('BandScopeEx', 'BandScope2400MHz', Settings._usebandscope[b2400]);
      ini.WriteBool('BandScopeEx', 'BandScope5600MHz', Settings._usebandscope[b5600]);
      ini.WriteBool('BandScopeEx', 'BandScope10GHz', Settings._usebandscope[b10g]);
      ini.WriteBool('BandScope', 'Current', Settings._usebandscope_current);
      ini.WriteBool('BandScope', 'NewMulti', Settings._usebandscope_newmulti);
      ini.WriteBool('BandScope', 'AllBands', Settings._usebandscope_allbands);

      for i := 1 to 12 do begin
         ini.WriteString('BandScopeEx', 'ForeColor' + IntToStr(i), ZColorToString(Settings._bandscopecolor[i].FForeColor));
         ini.WriteString('BandScopeEx', 'BackColor' + IntToStr(i), ZColorToString(Settings._bandscopecolor[i].FBackColor));
         ini.WriteBool('BandScopeEx', 'Bold' + IntToStr(i), Settings._bandscopecolor[i].FBold);
      end;

      ini.WriteInteger('BandScopeEx', 'freshness_mode', Settings._bandscope_freshness_mode);
      ini.WriteInteger('BandScopeEx', 'freshness_icon', Settings._bandscope_freshness_icon);

      ini.WriteBool('BandScopeOptions', 'use_estimated_mode', Settings._bandscope_use_estimated_mode);
      ini.WriteBool('BandScopeOptions', 'show_only_in_bandplan', Settings._bandscope_show_only_in_bandplan);
      ini.WriteBool('BandScopeOptions', 'show_ja_spots', Settings._bandscope_show_ja_spots);
      ini.WriteBool('BandScopeOptions', 'show_dx_spots', Settings._bandscope_show_dx_spots);
      ini.WriteBool('BandScopeOptions', 'use_lookup_server', Settings._bandscope_use_lookup_server);
      ini.WriteBool('BandScopeOptions', 'use_resume', Settings._bandscope_use_resume);
      ini.WriteBool('BandScopeOptions', 'setfreq_after_mode_change', Settings._bandscope_setfreq_after_mode_change);
      ini.WriteBool('BandScopeOptions', 'always_change_mode', Settings._bandscope_always_change_mode);
      ini.WriteBool('BandScopeOptions', 'save_current_freq', Settings._bandscope_save_current_freq);

      // Quick Memo
      for i := 1 to 5 do begin
         ini.WriteString('QuickMemo', '#' + IntToStr(i), Settings.FQuickMemoText[i]);
      end;

      // Voice Memory
      for i := 1 to maxmessage do begin
         ini.WriteString('Voice', 'F#' + IntToStr(i), Settings.FSoundFiles[i]);
         ini.WriteString('Voice', 'C#' + IntToStr(i), Settings.FSoundComments[i]);
      end;
      for i := 2 to 3 do begin
         ini.WriteString('Voice', 'CQ_F#' + IntToStr(i), Settings.FAdditionalSoundFiles[i]);
         ini.WriteString('Voice', 'CQ_C#' + IntToStr(i), Settings.FAdditionalSoundComments[i]);
      end;

      // output device
      ini.WriteInteger('Voice', 'device', Settings.FSoundDevice);

      // Select User Defined Contest
      ini.WriteBool('UserDefinedContest', 'imp_prov_city', Settings.FImpProvCity);
      ini.WriteBool('UserDefinedContest', 'imp_f1a', Settings.FImpCwMessage[1]);
      ini.WriteBool('UserDefinedContest', 'imp_f2a', Settings.FImpCwMessage[2]);
      ini.WriteBool('UserDefinedContest', 'imp_f3a', Settings.FImpCwMessage[3]);
      ini.WriteBool('UserDefinedContest', 'imp_f4a', Settings.FImpCwMessage[4]);
      ini.WriteBool('UserDefinedContest', 'imp_cq2', Settings.FImpCQMessage[2]);
      ini.WriteBool('UserDefinedContest', 'imp_cq3', Settings.FImpCQMessage[3]);
      ini.WriteString('UserDefinedContest', 'last_cfgfilename', Settings.FLastCFGFileName);

      // スコア表示の追加情報(評価用指数)
      ini.WriteInteger('Score', 'ExtraInfo', Settings.FLastScoreExtraInfo);

      // Last Band/Mode
      ini.WriteInteger('main', 'last_band', Settings.FLastBand[0]);
      ini.WriteInteger('main', 'last_mode', Settings.FLastMode[0]);
      ini.WriteInteger('main', 'last_band1', Settings.FLastBand[1]);
      ini.WriteInteger('main', 'last_mode1', Settings.FLastMode[1]);
      ini.WriteInteger('main', 'last_band2', Settings.FLastBand[2]);
      ini.WriteInteger('main', 'last_mode2', Settings.FLastMode[2]);

      // Last CQ mode
      ini.WriteBool('main', 'last_cqmode', Settings.FLastCQMode);

      // QSO Rate Graph
      ini.WriteInteger('Graph', 'Style', Integer(Settings.FGraphStyle));
      ini.WriteInteger('Graph', 'StartPosition', Integer(Settings.FGraphStartPosition));
      for b := b19 to HiBand do begin
         strKey := MHzString[b];
         ini.WriteString('Graph', strKey + '_BarColor', ZColorToString(Settings.FGraphBarColor[b]));
         ini.WriteString('Graph', strKey + '_TextColor', ZColorToString(Settings.FGraphTextColor[b]));
      end;

      for i := 0 to 1 do begin
         strKey := IntToStr(i);
         ini.WriteString('Graph', 'BgColor' + strKey, ZColorToString(Settings.FGraphOtherBgColor[i]));
         ini.WriteString('Graph', 'FgColor' + strKey, ZColorToString(Settings.FGraphOtherFgColor[i]));
      end;

      ini.WriteBool('rateex_zaq', 'achievement', Settings.FZaqAchievement);

      for i := 0 to 3 do begin
         strKey := IntToStr(i);
         ini.WriteString('rateex_zaq', 'BgColor' + strKey, ZColorToString(Settings.FZaqBgColor[i]));
         ini.WriteString('rateex_zaq', 'FgColor' + strKey, ZColorToString(Settings.FZaqFgColor[i]));
      end;

      // Cluster Window(Comm)
      ini.WriteBool('ClusterWindow', 'AutoLogin', Settings.FClusterAutoLogin);
      ini.WriteBool('ClusterWindow', 'AutoReconnect', Settings.FClusterAutoReconnect);
      ini.WriteBool('ClusterWindow', 'RelaySpot', Settings.FClusterRelaySpot);
      ini.WriteBool('ClusterWindow', 'NotifyCurrentBand', Settings.FClusterNotifyCurrentBand);
      ini.WriteBool('ClusterWindow', 'RecordLogs', Settings.FClusterRecordLogs);
      ini.WriteBool('ClusterWindow', 'IgnoreBEL', Settings.FClusterIgnoreBEL);
      ini.WriteBool('ClusterWindow', 'UseAllowDenyLists', Settings.FClusterUseAllowDenyLists);
      ini.WriteBool('ClusterWindow', 'IgnoreSHDX', Settings.FClusterIgnoreSHDX);
      ini.WriteInteger('ClusterWindow', 'ReConnectMax', Settings.FClusterReConnectMax);
      ini.WriteInteger('ClusterWindow', 'RetryIntervalSec', Settings.FClusterRetryIntervalSec);

      // Z-Server Messages(ChatForm)
      ini.WriteBool('ChatWindow', 'PopupNewMsg', Settings.FChatFormPopupNewMsg);
      ini.WriteBool('ChatWindow', 'StayOnTop', Settings.FChatFormStayOnTop);
      ini.WriteBool('ChatWindow', 'RecordLogs', Settings.FChatFormRecordLogs);
      ini.WriteInteger('ChatWindow', 'Prompt', Settings.FChatFormPrompt);

      // Quick Reference
      ini.WriteInteger('QuickReference', 'FontSize', Settings.FQuickRefFontSize);
      ini.WriteString('QuickReference', 'FontFace', Settings.FQuickRefFontFace);

      // Band Plan
      ini.WriteString('BandPlan', 'PresetNameList', Settings.FBandPlanPresetList);

      ini.UpdateFile();
   finally
      ini.Free();
      slParam.Free();
   end;

   // オペレーターリスト保存
   FOpList.SaveToIniFile();
end;

// 設定反映
procedure TdmZLogGlobal.ImplementSettings(_OnCreate: boolean);
begin
   if _OnCreate = False then begin
      if Settings._band > 0 then begin // single band
         Band := Settings._band; // resets the bandmenu.items.enabled for the single band entry
      end;
   end;

   if MyContest <> nil then begin
      Main.MyContest.SameExchange := Settings._sameexchange;
   end;

   if Settings._zlinkport in [1 .. 6] then begin // zlinkport rs232c
      // ZLinkForm.Transparent := True;
      // no rs232c anymore
   end;

   MainForm.CommForm.ImplementOptions;
   MainForm.ZLinkForm.ImplementOptions;
   MainForm.ChatForm.ImplementOptions;

   InitializeCW();

   // SetBand(Settings._band);
   ContestMode := Settings._mode;

   if Settings._backuppath = '' then begin
      MainForm.BackUp1.Enabled := False;
   end
   else begin
      MainForm.BackUp1.Enabled := True;
   end;
end;

procedure TdmZLogGlobal.InitializeCW();
var
   i: Integer;
begin
   dmZLogKeyer.UseWinKeyer := Settings._use_winkeyer;
   dmZLogKeyer.UseWk9600 := Settings._use_wk_9600;
   dmZLogKeyer.UseWkOutpSelect := Settings._use_wk_outp_select;
   dmZLogKeyer.UseWkIgnoreSpeedPot := Settings._use_wk_ignore_speed_pot;
   dmZLogKeyer.UseWkAlways9600 := Settings._use_wk_always9600;
   dmZLogKeyer.UseWkSo2rNeo := (Settings._so2r_type = so2rNeo);
   dmZLogKeyer.So2rRxSelectPort := TKeyingPort(Settings._so2r_rx_port);
   dmZLogKeyer.So2rTxSelectPort := TKeyingPort(Settings._so2r_tx_port);
   dmZLogKeyer.So2rTxRigC := Settings._so2r_tx_rigc;
   dmZLogKeyer.So2rRigSelectV28 := Settings._so2r_rigselect_v28;

   dmZLogKeyer.UseSideTone := Settings.CW._sidetone;
   dmZLogKeyer.SideToneVolume := Settings.CW._sidetone_volume;

   // CWキーイングポートの設定
   for i := 0 to 4 do begin
      dmZLogKeyer.KeyingPort[i] := TKeyingPort(Settings.FRigControl[i + 1].FKeyingPort);
      dmZLogKeyer.KeyingPortConfig[i] := Settings.FRigControl[i + 1].FKeyingPortConfig;
   end;

   dmZLogKeyer.Usbif4cwSyncWpm := Settings._usbif4cw_sync_wpm;
   dmZLogKeyer.PaddleReverse := Settings.CW._paddlereverse;
   dmZLogKeyer.Gen3MicSelect := Settings._usbif4cw_gen3_micsel;
   dmZLogKeyer.UsePaddleKeyer := Settings._usbif4cw_use_paddle_keyer;

   dmZLogKeyer.FixedSpeed := Settings.CW._fixwpm;

   dmZLogKeyer.SetPTTDelay(Settings._pttbefore, Settings._pttafter);
   dmZLogKeyer.SetPTT(Settings._pttenabled);

   dmZLogKeyer.WPM := Settings.CW._speed;
   dmZLogKeyer.InitWPM := Settings.CW._speed;
   dmZLogKeyer.SetWeight(Settings.CW._weight);
   dmZLogKeyer.SideTonePitch := Settings.CW._tonepitch;

   dmZLogKeyer.SpaceFactor := Settings.CW._spacefactor;
   dmZLogKeyer.EISpaceFactor := Settings.CW._eispacefactor;
end;

function TdmZLogGlobal.GetAge(aQSO: TQSO): string;
var
   op: TOperatorInfo;
begin
   op := FOpList.ObjectOf(aQSO.Operator);
   if op = nil then begin
      Result := Settings._age;
      Exit;
   end;

   // 2023年のAADXルール改正で、マルチOP時は運用者の平均年齢とするため
   // OP別の年齢が設定されていない場合は、全体設定の年齢を使う
   if op.Age = '' then begin
      Result := Settings._age;
   end
   else begin
      Result := op.Age;
   end;
end;

procedure TdmZLogGlobal.SetOpPower(aQSO: TQSO);
var
   P: Char;
   str: string;
   op: TOperatorInfo;
begin
   op := FOpList.ObjectOf(aQSO.Operator);
   if op = nil then begin
      P := dmZLogGlobal.Settings._power[aQSO.Band][1];
   end
   else begin
      str := op.Power;

      P := str[OldBandOrd(aQSO.Band) + 1];
      if P = '-' then begin
         P := UpCase(str[1]);
      end;
   end;

   case P of
      'P':
         aQSO.Power := pwrP;
      'L':
         aQSO.Power := pwrL;
      'M':
         aQSO.Power := pwrM;
      'H':
         aQSO.Power := pwrH;
   end;
end;

function TdmZLogGlobal.GetMyCall(): string;
begin
   Result := Settings._mycall;
end;

procedure TdmZLogGlobal.SetMyCall(s: string);
begin
   Settings._mycall := s;
   AnalyzeMyCountry();
end;

function TdmZLogGlobal.GetBand: integer;
begin
   Result := Settings._band;
end;

procedure TdmZLogGlobal.SetBand(b: integer);
begin
   Settings._band := b;
end;

function TdmZLogGlobal.GetMode: TContestMode;
begin
   Result := Settings._mode;
end;

procedure TdmZLogGlobal.SetMode(m: TContestMode);
begin
   Settings._mode := m;
end;

function TdmZLogGlobal.GetMultiOp(): TContestCategory;
begin
   Result := Settings._multiop;
end;

procedure TdmZLogGlobal.SetMultiOp(i: TContestCategory);
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

function TdmZLogGlobal.GetRigNameStr(Index: Integer): string; // returns the selected rig name
var
   sl: TStringList;
   i: Integer;
begin
   sl := TStringList.Create();
   try
      dmZlogGlobal.MakeRigList(sl);

      i := sl.IndexOf(Settings.FRigControl[Index].FRigName);
      if i = -1 then begin
         Result := sl[0];
      end
      else begin
         Result := sl[i];
      end;
   finally
      sl.Free();
   end;
end;

function TdmZLogGlobal.GetSuperCheckColumns(): Integer;
begin
   Result := Settings._super_check_columns;
end;

procedure TdmZLogGlobal.SetSuperCheckColumns(v: Integer);
begin
   Settings._super_check_columns := v;
end;

function TdmZLogGlobal.GetSuperCheck2Columns(): Integer;
begin
   Result := Settings._super_check2_columns;
end;

procedure TdmZLogGlobal.SetSuperCheck2Columns(v: Integer);
begin
   Settings._super_check2_columns := v;
end;

function TdmZLogGlobal.GetPowerOfBand(band: TBand): TPower;
begin
   if band > HiBand then begin
      Result := pwrM;
      Exit;
   end;

   if Settings._power[band] = 'H' then begin
      Result := pwrH;
   end
   else if Settings._power[band] = 'M' then begin
      Result := pwrM;
   end
   else if Settings._power[band] = 'L' then begin
      Result := pwrL;
   end
   else if Settings._power[band] = 'P' then begin
      Result := pwrP;
   end
   else begin
      Result := pwrM;
   end;
end;

function TdmZLogGlobal.GetPowerOfBand2(band: TBand): string;
begin
   if band > HiBand then begin
      Result := Settings._powerM;
      Exit;
   end;

   if Settings._power[band] = 'H' then begin
      Result := Settings._powerH;
   end
   else if Settings._power[band] = 'M' then begin
      Result := Settings._powerM;
   end
   else if Settings._power[band] = 'L' then begin
      Result := Settings._powerL;
   end
   else if Settings._power[band] = 'P' then begin
      Result := Settings._powerP;
   end
   else begin
      Result := Settings._powerM;
   end;
end;

function TdmZLogGlobal.GetLastBand(Index: Integer): TBand;
begin
   Result := TBand(Settings.FLastBand[Index]);
end;

procedure TdmZLogGlobal.SetLastBand(Index: Integer; b: TBand);
begin
   Settings.FLastBand[Index] := Integer(b);
end;

function TdmZLogGlobal.GetLastMode(Index: Integer): TMode;
begin
   Result := TMode(Settings.FLastMode[Index]);
end;

procedure TdmZLogGlobal.SetLastMode(Index: Integer; m: TMode);
begin
   Settings.FLastMode[Index] := Integer(m);
end;

procedure TdmZLogGlobal.SetPaddleReverse(boo: boolean);
begin
   Settings.CW._paddlereverse := boo;
   dmZlogKeyer.PaddleReverse := boo;
end;

procedure TdmZLogGlobal.ReversePaddle;
begin
   SetPaddleReverse(not(Settings.CW._paddlereverse));
end;

function TdmZLogGlobal.CWMessage(bank, no: integer): string;
var
   S: string;
begin
   if bank = 0 then begin
      if Settings._switchcqsp then begin
         bank := Settings.CW.CurrentBank;
      end
      else begin
         bank := 1;
      end;
   end;

   case no of
      1, 2, 3, 4, 5, 6,
      7, 8, 9, 10, 11, 12: begin
         S := Settings.CW.CWStrBank[bank, no];
      end;

      101: begin
         S := Settings.CW.CWStrBank[bank, 1];
      end;

      102: begin
         S := Settings.CW.AdditionalCQMessages[2];
      end;

      103: begin
         S := Settings.CW.AdditionalCQMessages[3];
      end;

      else begin
         S := '';
      end;
   end;

   // OP別メッセージオーバーライド
   if FCurrentOperator <> nil then begin
      case no of
         1..12: begin
            if FCurrentOperator.CwMessages[bank, no] <> '' then begin
               S := FCurrentOperator.CwMessages[bank, no];
            end;
         end;

         101: begin
            if FCurrentOperator.CwMessages[bank, 1] <> '' then begin
               S := FCurrentOperator.CwMessages[bank, 1];
            end;
         end;

         102: begin
            if FCurrentOperator.AdditionalCwMessages[2] <> '' then begin
               S := FCurrentOperator.AdditionalCwMessages[2];
            end;
         end;

         103: begin
            if FCurrentOperator.AdditionalCwMessages[3] <> '' then begin
               S := FCurrentOperator.AdditionalCwMessages[3];
            end;
         end;
      end;
   end;

   Result := S;
end;

{
function TdmZLogGlobal.CWMessage(no: Integer): string;
var
   S: string;
begin
   if Settings._switchcqsp then begin
      S := Settings.CW.CWStrBank[Settings.CW.CurrentBank, no];
   end
   else begin
      S := Settings.CW.CWStrBank[1, no];
   end;

   Result := S;
end;
}

procedure TdmZLogGlobal.ReadWindowState(ini: TMemIniFile; form: TForm; strWindowName: string; fPositionOnly: Boolean );
var
   l, t, w, h: Integer;
   pt: TPoint;
   mon: TMonitor;
begin
   if strWindowName = '' then begin
      strWindowName := form.Name;
   end;

   l := ini.ReadInteger('Windows', strWindowName + '_X', -1);
   t := ini.ReadInteger('Windows', strWindowName + '_Y', -1);
   h := ini.ReadInteger('Windows', strWindowName + '_H', -1);
   w := ini.ReadInteger('Windows', strWindowName + '_W', -1);

   form.Visible := ini.ReadBool('Windows', strWindowName + '_Open', False);

   pt.X := l;
   pt.Y := t;
   mon := Screen.MonitorFromPoint(pt, mdNearest);
   if l < mon.Left then begin
      l := mon.Left;
   end;
   if (l + w) > (mon.Left + mon.Width) then begin
      l := (mon.Left + mon.Width) - w;
   end;
   if t < mon.Top then begin
      t := mon.Top;
   end;
   if (t + h) > (mon.Top + mon.Height) then begin
      t := (mon.Top + mon.Height) - H;
   end;

   form.Left := l;
   form.Top := t;

   if fPositionOnly = False then begin
      if h >= 0 then begin
         form.Height  := ini.ReadInteger('Windows', strWindowName + '_H', -1);
      end;
      if w >= 0 then begin
         form.Width   := ini.ReadInteger('Windows', strWindowName + '_W', -1);
      end;
   end;
end;

procedure TdmZLogGlobal.WriteWindowState(ini: TMemIniFile; form: TForm; strWindowName: string);
begin
   if strWindowName = '' then begin
      strWindowName := form.Name;
   end;

   ini.WriteBool('Windows', strWindowName + '_Open', form.Visible);
   ini.WriteInteger('Windows', strWindowName + '_X', form.Left);
   ini.WriteInteger('Windows', strWindowName + '_Y', form.Top);
   ini.WriteInteger('Windows', strWindowName + '_H', form.Height);
   ini.WriteInteger('Windows', strWindowName + '_W', form.Width);
end;

procedure TdmZLogGlobal.ReadMainFormState(ini: TMemIniFile; var X, Y, W, H: integer; var TB1, TB2: boolean);
var
   pt: TPoint;
   mon: TMonitor;
begin
   X := ini.ReadInteger('Windows', 'Main_X', 0);
   Y := ini.ReadInteger('Windows', 'Main_Y', 0);
   W := ini.ReadInteger('Windows', 'Main_W', 0);
   H := ini.ReadInteger('Windows', 'Main_H', 0);

   pt.X := X;
   pt.Y := Y;
   mon := Screen.MonitorFromPoint(pt, mdNearest);
   if X < mon.Left then begin
      X := mon.Left;
   end;
   if (X + W) > (mon.Left + mon.Width) then begin
      X := (mon.Left + mon.Width) - W;
   end;
   if Y < mon.Top then begin
      Y := mon.Top;
   end;
   if (Y + H) > (mon.Top + mon.Height) then begin
      Y := (mon.Top + mon.Height) - H;
   end;

   TB1 := ini.ReadBool('Windows', 'Main_ToolBar1', False);
   TB2 := ini.ReadBool('Windows', 'Main_ToolBar2', False);
end;

procedure TdmZLogGlobal.WriteMainFormState(ini: TMemIniFile; X, Y, W, H: integer; TB1, TB2: boolean);
begin
   ini.WriteInteger('Windows', 'Main_X', X);
   ini.WriteInteger('Windows', 'Main_Y', Y);
   ini.WriteInteger('Windows', 'Main_W', W);
   ini.WriteInteger('Windows', 'Main_H', H);
   ini.WriteBool('Windows', 'Main_ToolBar1', TB1);
   ini.WriteBool('Windows', 'Main_ToolBar2', TB2);
end;

procedure TdmZLogGlobal.CreateLog();
begin
   if FLog <> nil then begin
      FLog.Free();
   end;
   FLog := TLog.Create('default');
end;

procedure TdmZLogGlobal.SetLogFileName(filename: string);
begin
   FCurrentFileName := filename;
end;

procedure TdmZLogGlobal.MakeRigList(sl: TStrings);
var
   i: Integer;
begin
   sl.Clear();

   for i := Low(RIGNAMES) to High(RIGNAMES) do begin
      sl.Add(RIGNAMES[i]);
   end;

   for i := Low(ICOMLIST) to High(ICOMLIST) do begin
      sl.Add(ICOMLIST[i].name);
   end;

   sl.Add('Elecraft K3S/K3/KX3/KX2');
   sl.Add('JST-145');
   sl.Add('JST-245');
   sl.Add('Omni-Rig');
end;

function TdmZLogGlobal.NewQSOID(): Integer;
var
   tt, ss, rr: integer;
begin
   tt := Settings._txnr;
   if tt > 21 then
      tt := 21;

   ss := GLOBALSERIAL;
   inc(GLOBALSERIAL);
   if GLOBALSERIAL > 9999 then
      GLOBALSERIAL := 0;

   rr := random(100);

   Result := tt * 100000000 + ss * 10000 + rr * 100;
end;

function TdmZLogGlobal.GetGreetingsCode(): string;
var
   h: Integer;
begin
   h := HourOf(Now);
   if (h < Settings.FTimeToChangeGreetings[0]) then begin
      Result := 'GE';
   end
   else if (h < Settings.FTimeToChangeGreetings[1]) then begin
      Result := 'GM';
   end
   else if (h < Settings.FTimeToChangeGreetings[2]) then begin
      Result := 'GA';
   end
   else begin
      Result := 'GE';
   end;
end;

function TdmZLogGlobal.ExpandCfgDatFullPath(filename: string): string;
var
   fullpath: string;
begin
   if IsFullPath(filename) = True then begin
      Result := filename;
      Exit;
   end;

   fullpath := CfgDatPath + filename;
   if FileExists(fullpath) = False then begin
      fullpath := ExtractFilePath(Application.ExeName) + filename;
      if FileExists(fullpath) = False then begin
//         MessageDlg('DAT file [' + fullpath + '] cannot be opened', mtError, [mbOK], 0);
         Result := '';
         Exit;
      end;
   end;

   Result := fullpath;
end;

function TdmZLogGlobal.Load_CTYDAT(): Boolean;
var
   i: Integer;
   P: TPrefix;
   strFileName: string;
begin
   strFileName := ExtractFilePath(Application.ExeName) + 'CTY.DAT';

   // カントリーリストをロード
   FCountryList.LoadFromFile(strFileName);

   if FileExists(strFileName) = True then begin

      // 各カントリーのprefixを展開
      for i := 0 to FCountryList.Count - 1 do begin
         FPrefixList.Parse(FCountryList[i]);
      end;

      // 並び替え（降順）
      FPrefixList.Sort();

      {$IFDEF DEBUG}
      FPrefixList.SaveToFile('prefixlist.txt');
      {$ENDIF}

      Result := True;
   end
   else begin
      Result := False;
   end;

   // 先頭にUnknown Countryのダミーレコード追加
   P := TPrefix.Create();
   P.Prefix := 'Unknown';
   P.Country := FCountryList[0];
   FPrefixList.Insert(0, P);
end;

function TdmZLogGlobal.GetPrefix(strCallsign: string): TPrefix;
var
   str: string;
   i: integer;
   P: TPrefix;
   strCallRight: string;
   strCallFirst: string;
   l1, l2: Integer;
begin
   if strCallSign = '' then begin
      Result := FPrefixList[0];
      Exit;
   end;

   if FPrefixList.Count = 0 then begin
      Result := FPrefixList[0];
      Exit;
   end;

   // 最初はコール一致確認
   P := FPrefixList.ObjectOf(strCallsign);
   if (P <> nil) and (P.FullMatch = True) then begin
      Result := P;
      Exit;
   end;

   // "/"で分割
   i := Pos('/', strCallSign);
   if i > 0 then begin
      strCallFirst := Copy(strCallSign, 1, i - 1);
      strCallRight := Copy(strCallSign, i + 1);
   end
   else begin
      strCallFirst := strCallSign;
      strCallRight := '';
   end;

   // Marine Mobile はUnknownを返して終わり
   if strCallRight = 'MM' then begin
      Result := FPrefixList[0];
      Exit;
   end;

   // 無視するもの
   if (strCallRight = 'AA') or (strCallRight = 'AT') or (strCallRight = 'AG') or
      (strCallRight = 'AA') or (strCallRight = 'AE') or (strCallRight = 'M') or
      (strCallRight = 'P') or (strCallRight = 'AM') or (strCallRight = 'QRP') or
      (strCallRight = 'A') or (strCallRight = 'KT') or (strCallRight = 'N') or
      (strCallRight = 'T') or
      (strCallRight = '0') or (strCallRight = '1') or (strCallRight = '2') or
      (strCallRight = '3') or (strCallRight = '4') or (strCallRight = '5') or
      (strCallRight = '6') or (strCallRight = '7') or (strCallRight = '8') or
      (strCallRight = '9') then begin
      strCallFirst := Copy(strCallSign, 1, i - 1);
      strCallRight := '';
   end;

   // 短い方をFirstにする
   l1 := Length(strCallFirst);
   l2 := Length(strCallRight);
   if (l1 > 0) and (l2 > 0) and (l1 > l2) then begin
      str := strCallFirst;
      strCallFirst := strCallRight;
      strCallRight := str;
   end;

   // まずは左側から前方一致で
   P := FPrefixList.FindForword(strCallFirst);
   if P <> nil then begin
      Result := P;
      Exit;
   end;

   // 続いて右側を前方一致で
   P := FPrefixList.FindForword(strCallRight);
   if P <> nil then begin
      Result := P;
      Exit;
   end;

   // どこにも該当なし
   Result := FPrefixList[0];
end;

function TdmZLogGlobal.GetArea(str: string): integer;
var
   j, k: integer;
begin
   j := pos('/', str);
   if j > 4 then begin
      for k := Length(str) downto 1 do
         if CharInSet(str[k], ['0' .. '9']) = True then
            break;
   end
   else begin
      for k := 1 to Length(str) do
         if CharInSet(str[k], ['0' .. '9']) = True then
            break;
   end;

   if CharInSet(str[k], ['0' .. '9']) = True then
      k := ord(str[k]) - ord('0')
   else
      k := 6;

   Result := k;
end;

function TdmZLogGlobal.GuessCQZone(strCallsign: string): string;
var
   i, k: integer;
   C: TCountry;
   p: TPrefix;
   str: string;
begin
   p := GetPrefix(strCallsign);
   if p = nil then begin
      Result := '';
      exit;
   end
   else begin
      C := P.Country;
   end;

   str := strCallsign;
   i := StrToIntDef(C.CQZone, 0);

   if (C.Country = 'W') or (C.Country = 'K') then begin
      k := GetArea(str);
      case k of
         1 .. 4:
            i := 5;
         5, 8, 9, 0:
            i := 4;
         6, 7:
            i := 3;
      end;
   end;

   if C.Country = 'VE' then begin
      k := GetArea(str);
      case k of
         1, 2, 9:
            i := 5;
         3 .. 6:
            i := 4;
         7:
            i := 3;
         8:
            i := 1;
         0:
            i := 2;
      end;
   end;

   if C.Country = 'VK' then begin
      k := GetArea(str);
      case k of
         1 .. 5, 7:
            i := 30;
         6, 8:
            i := 29;
         9, 0:
            i := 30; { Should not happen }
      end;
   end;

   if C.Country = 'BY' then begin
      k := GetArea(str);
      case k of
         1 .. 8:
            i := 24;
         9, 0:
            i := 23;
      end;
   end;

   if (C.Country = 'UA') or (C.Country = 'UA0') or (C.Country = 'UA9') then begin
      if (ExPos('U?0', str) > 0) or (pos('R?0', str) > 0) or (pos('R0', str) > 0) then begin
         k := pos('0', str);
         if Length(str) >= k + 1 then
            case str[k + 1] of
               'A', 'B', 'H', 'O', 'P', 'S', 'T', 'U', 'V', 'W':
                  i := 18;
               'Y':
                  i := 23;
               else
                  i := 19;
            end;
      end;

      if (ExPos('U?8', str) > 0) or (ExPos('R?8', str) > 0) then begin
         i := 18;
      end;
      if (ExPos('U?9', str) > 0) or (ExPos('R?9', str) > 0) then begin
         k := pos('9', str);
         if Length(str) >= k + 1 then
            case str[k + 1] of
               'S', 'T', 'W':
                  i := 16;
               'H', 'I', 'O', 'P', 'U', 'V', 'Y', 'Z':
                  i := 18;
               else
                  i := 17;
            end;
      end;
   end;

   if P.OvrCQZone <> '' then begin
      i := StrToIntDef(P.OvrCQZone, 0);
   end;

   if i = 0 then
      Result := ''
   else
      Result := IntToStr(i);
end;

procedure TdmZLogGlobal.AnalyzeMyCountry();
var
   aQSO: TQSO;
   P: TPrefix;
begin
   FMyContinent := 'AS';
   FMyCountry := 'JA';
   FMyCQZone := '25';
   FMyITUZone := '45';

   if CountryList.Count = 0 then begin
      Exit;
   end;

   if (Settings._mycall <> '') and (Settings._mycall <> 'Your call sign') then begin
      aQSO := TQSO.Create;
      aQSO.CallSign := UpperCase(Settings._mycall);

      P := GetPrefix(aQSO.Callsign);
      if P <> nil then begin
         FMyCountry := P.Country.Country;

         if Settings._cqzone = '' then begin
            Settings._cqzone := P.Country.CQZone;
         end;

         FMyCQZone := Settings._cqzone;

         if Settings._iaruzone = '' then begin
            Settings._iaruzone := P.Country.ITUZone;
         end;

         FMyITUZone := Settings._iaruzone;

         if P.OvrContinent = '' then begin
            FMyContinent := P.Country.Continent;
         end
         else begin
            FMyContinent := P.OvrContinent;
         end;
      end;
      aQSO.Free;
   end;
end;

function TdmZLogGlobal.IsUSA(): Boolean;
begin
   if (MyCountry = 'K') or (MyCountry = 'N') or (MyCountry = 'W') then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

function TdmZLogGlobal.IsMultiStation(): Boolean;
begin
   if (ContestCategory = ccMultiOpSingleTx) and (TXNr = 1) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TdmZLogGlobal.SetRootPath(v: string);
begin
   Settings._rootpath := v;
end;

function TdmZLogGlobal.GetCfgDatPath(): string;
begin
   Result := ExpandEnvironmentVariables(Settings._cfgdatpath);
   if IsFullPath(Result) = True then begin
//      Result := Settings._cfgdatpath;
   end
   else begin
      Result := RootPath + Settings._cfgdatpath;
   end;
   Result := IncludeTrailingPathDelimiter(Result);
end;

procedure TdmZLogGlobal.SetCfgDatPath(v: string);
begin
   if Pos(RootPath, v) > 0 then begin
      Settings._cfgdatpath := StringReplace(v, RootPath, '', [rfReplaceAll]);
   end
   else begin
      Settings._cfgdatpath := v;
   end;
end;

function TdmZLogGlobal.GetLogPath(): string;
begin
   Result := ExpandEnvironmentVariables(Settings._logspath);
   if IsFullPath(Result) = True then begin
//      Result := Settings._logspath;
   end
   else begin
      Result := RootPath + Settings._logspath;
   end;
   Result := IncludeTrailingPathDelimiter(Result);
end;

procedure TdmZLogGlobal.SetLogPath(v: string);
begin
   if Pos(RootPath, v) > 0 then begin
      Settings._logspath := StringReplace(v, RootPath, '', [rfReplaceAll]);
   end
   else begin
      Settings._logspath := v;
   end;
end;

function TdmZLogGlobal.GetBackupPath(): string;
begin
   Result := ExpandEnvironmentVariables(Settings._backuppath);
   if IsFullPath(Result) = True then begin
//      Result := Settings._backuppath;
   end
   else begin
      Result := RootPath + Settings._backuppath;
   end;
   Result := IncludeTrailingPathDelimiter(Result);
end;

procedure TdmZLogGlobal.SetBackupPath(v: string);
begin
   if Pos(RootPath, v) > 0 then begin
      Settings._backuppath := StringReplace(v, RootPath, '', [rfReplaceAll]);
   end
   else begin
      Settings._backuppath := v;
   end;
end;

function TdmZLogGlobal.GetSoundPath(): string;
begin
   Result := ExpandEnvironmentVariables(Settings._soundpath);
   if IsFullPath(Result) = True then begin
//      Result := Settings._soundpath;
   end
   else begin
      Result := RootPath + Settings._soundpath;
   end;
   Result := IncludeTrailingPathDelimiter(Result);
end;

procedure TdmZLogGlobal.SetSoundPath(v: string);
begin
   if Pos(RootPath, v) > 0 then begin
      Settings._soundpath := StringReplace(v, RootPath, '', [rfReplaceAll]);
   end
   else begin
      Settings._soundpath := v;
   end;
end;

function TdmZLogGlobal.GetPluginPath(): string;
begin
   Result := ExpandEnvironmentVariables(Settings._pluginpath);
   if IsFullPath(Result) = True then begin
//      Result := Settings._pluginpath;
   end
   else begin
      Result := RootPath + Settings._pluginpath;
   end;
   Result := IncludeTrailingPathDelimiter(Result);
end;

procedure TdmZLogGlobal.SetPluginPath(v: string);
begin
   if Pos(RootPath, v) > 0 then begin
      Settings._pluginpath := StringReplace(v, RootPath, '', [rfReplaceAll]);
   end
   else begin
      Settings._pluginpath := v;
   end;
end;

function TdmZLogGlobal.GetSpcPath(): string;
begin
   Result := ExpandEnvironmentVariables(Settings.FSuperCheck.FSuperCheckFolder);
   if IsFullPath(Result) = True then begin
//      Result := Settings.FSuperCheck.FSuperCheckFolder;
   end
   else begin
      Result := RootPath + Settings.FSuperCheck.FSuperCheckFolder;
   end;
   Result := IncludeTrailingPathDelimiter(Result);
end;

procedure TdmZLogGlobal.SetSpcPath(v: string);
begin
   if Pos(RootPath, v) > 0 then begin
      Settings.FSuperCheck.FSuperCheckFolder := StringReplace(v, RootPath, '', [rfReplaceAll]);
   end
   else begin
      Settings.FSuperCheck.FSuperCheckFolder := v;
   end;
end;

procedure TdmZLogGlobal.SelectBandPlan(preset_name: string);
begin
   if FBandPlans.ContainsKey(preset_name) = False then begin
      Exit;
   end;
   FCurrentBandPlan := preset_name;
end;

procedure TdmZLogGlobal.CreateFolders();
var
   strPath: string;
begin
   // Root
   strPath := RootPath;
   if strPath <> '' then begin
      ForceDirectories(strPath);
   end;

   // CFG/DAT folder
   strPath := CfgDatPath;
   if (strPath <> '') and (DirectoryExists(strPath) = False) then begin
      ForceDirectories(strPath);
   end;

   // Logs folder
   strPath := LogPath;
   if (strPath <> '') and (DirectoryExists(strPath) = False) then begin
      ForceDirectories(strPath);
   end;

   // Backup folder
   strPath := BackupPath;
   if (strPath <> '') and (DirectoryExists(strPath) = False) then begin
      ForceDirectories(strPath);
   end;

   // Sound folder
   strPath := SoundPath;
   if (strPath <> '') and (DirectoryExists(strPath) = False) then begin
      ForceDirectories(strPath);
   end;

   // Plugins folder
   strPath := PluginPath;
   if (strPath <> '') and (DirectoryExists(strPath) = False) then begin
      ForceDirectories(strPath);
   end;

   // Super Check folder
   strPath := SpcPath;
   if (strPath <> '') and (DirectoryExists(strPath) = False) then begin
      ForceDirectories(strPath);
   end;
end;

procedure TdmZLogGlobal.WriteErrorLog(msg: string);
var
   str: string;
   txt: TextFile;
begin
   AssignFile(txt, FErrorLogFileName);
   if FileExists(FErrorLogFileName) then begin
      Reset(txt);
   end
   else begin
      Rewrite(txt);
   end;

   str := FormatDateTime( 'yyyy/mm/dd hh:nn:ss ', Now ) + msg;

   Append( txt );
   WriteLn( txt, str );
   Flush( txt );
   CloseFile( txt );
end;

function TdmZLogGlobal.GetCurrentBandPlan(): TBandPlan;
begin
   Result := BandPlans[FCurrentBandPlan];
end;

procedure TdmZLogGlobal.FreeCommPortList();
var
   O: TObject;
begin
   if Assigned(FCommPortList) then begin
      for O in FCommPortList do begin
         TCommPort(O).Free();
      end;
      FCommPortList.Free();
      FCommPortList := nil;
   end;
end;

function TdmZLogGlobal.GetCommPortList(): TList<TCommPort>;
begin
   FreeCommPortList();

   FCommPortList := LoadCommPortList();

   Result := FCommPortList;
end;

function TdmZLogGlobal.LoadCommPortList(): TList<TCommPort>;
var
   portNumbers: array[0..50] of ULONG;
   numofports: ULONG;
   i: Integer;
   list: TList<TCommPort>;
   O: TCommPort;
   Comparer: TCommPortComparer;
begin
   ZeroMemory(@portNumbers, SizeOf(portNumbers));
   GetCommPortsForOldVersion(@portNumbers, SizeOf(portNumbers) div SizeOf(ULONG), numofports);

   list := TList<TCommPort>.Create();

   O := TCommPort.Create();
   O.Number := 0;
   O.Name := 'None';
   O.RigControl := True;
   O.Keying := True;
   list.Add(O);

   if Settings.FCommPortTest = False then begin
      if numofports > 0 then begin
         for i := 0 to numofports - 1 do begin
            O := TCommPort.Create();
            if portNumbers[i] < 21 then begin
               O.Number := portNumbers[i];
               O.Name := 'COM' + IntToStr(portNumbers[i]);
               O.RigControl := True;
               O.Keying := True;
               list.Add(O);
            end;
         end;
      end;
   end
   else begin
      for i := 1 to 20 do begin
         O := TCommPort.Create();
         O.Number := i;
         O.Name := 'COM' + IntToStr(i);
         O.RigControl := True;
         O.Keying := True;
         list.Add(O);
      end;
   end;

   O := TCommPort.Create();
   O.Number := 21;
   O.Name := 'USBIF4CW';
   O.Keying := True;
   list.Add(O);

   O := TCommPort.Create();
   O.Number := 22;
   O.Name := 'RIG';
   O.Keying := True;
   list.Add(O);

   Comparer := TCommPortComparer.Create();
   list.Sort(Comparer);
   Comparer.Free();

   Result := list;
end;

// ----------------------------------------------------------------------------

{ TCommPort }

constructor TCommPort.Create();
begin
   Inherited;
   FPortName := '';
   FPortNumber := 0;
   FRigControl := False;
   FKeying := False;
end;

{ TCommPortComparer }

function TCommPortComparer.Compare(const Left, Right: TCommPort): Integer;
begin
   Result := Left.Number - Right.Number;
end;

// ----------------------------------------------------------------------------

function Log(): TLog;
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

function kHzStr(Hz: TFrequency): string;
var
   k, kk: TFrequency;
begin
   k := Hz div 1000;
   kk := Hz mod 1000;
   kk := kk div 100;
//   if k > 100000 then
//      Result := IntToStr(k)
//   else
      Result := IntToStr(k) + '.' + IntToStr(kk);
end;

procedure IncEditCounter(aQSO: TQSO);
begin
   if aQSO.Reserve3 mod 100 < 99 then begin
      aQSO.Reserve3 := aQSO.Reserve3 + 1;
   end;
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

   if S = '' then begin
      exit;
   end;

   if CharInSet(S[length(S)], ['H', 'M', 'L', 'P']) then begin
      Result := S[length(S)];
   end;
end;

function IsSHF(B: TBand): Boolean; // true if b >= 2400MHz
begin
   Result := (B >= b2400);
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
   if MyContest.UseUTC then
      Result := GetUTC
   else
      Result := Now;
end;

function LowCase(C: Char): Char;
begin
   if CharInSet(C, ['A' .. 'Z']) then
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

function IsWARC(Band: TBand): Boolean;
begin
   if Band in [b10, b18, b24] then
      Result := True
   else
      Result := False;
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

function StrMore(A, B: string): Boolean; { true if a>b }
var
   i: Integer;
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
   PXA, PXB: integer;
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
   sjis := sjis + AnsiString(DupeString(' ', len));
   sjis := Copy(sjis, 1, len);
   Result := String(sjis);
end;

function FillLeft(S: string; len: integer): string;
var
   sjis: AnsiString;
begin
   sjis := AnsiString(S);
   sjis := AnsiString(DupeString(' ', len)) + sjis;
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

function Compare2(strTarget: string; strCompare: string): Boolean;
var
   i: Integer;
   n1: Integer;
   n2: Integer;
   match_cnt: Integer;
begin
   n1 := Length(strTarget);
   n2 := Length(strCompare);

   if n1 > n2 then begin
      strCompare := strCompare + DupeString(' ', n1 - n2);
   end
   else if n2 > n1 then begin
      strTarget := strTarget + DupeString(' ', n2 - n1);
   end;

   n1 := Length(strTarget);
   match_cnt := 0;
   for i := 1 to n1 do begin
      if strTarget[i] = strCompare[i] then begin
         Inc(match_cnt);
      end;
   end;

   if match_cnt >= (n1 - 1) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

// レーベンシュタイン距離の計算
function LD(S, T: string): Integer;
var
   l1, l2, l3: Integer;
begin
   // 一方が空文字列なら、他方の長さが求める距離
   if S = '' then begin
      Result := Length(T);
      Exit;
   end;

   if T = '' then begin
      Result := Length(S);
      Exit;
   end;

   // 一文字目が一致なら、二文字目以降の距離が求める距離
   if S[1] = T[1] then begin
      Result := LD(Copy(S, 2), Copy(T, 2));
      Exit;
   end;

   // 一文字目が不一致なら、追加／削除／置換のそれぞれを実施し、
   // 残りの文字列についてのコストを計算する

   // Sの先頭に追加
   l1 := LD(S, Copy(T, 2));

   // Sの先頭を削除
   l2 := LD(Copy(S, 2), T);

   // Sの先頭を置換
   l3 := LD(Copy(S, 2), Copy(T, 2));

   // 追加／削除／置換を実施した分コスト（距離）1の消費は確定
   // 残りの文字列についてのコストの最小値を足せば距離となる
   Result := 1 + Min(l1, Min(l2, l3));
end;

// 動的計画法でのレーベンシュタイン距離の計算
function LD_dp(str1, str2: string): Integer;
var
   n1, n2: Integer;
   i: Integer;
   j: Integer;
   d: array[0..100, 0..100] of Integer;
begin
   n1 := Length(str1);
   n2 := Length(str2);

   if (n1 > 100) or (n2 > 100) then begin
      Result := 100;
      Exit;
   end;

   for i := 0 to n1 do begin
      d[i][0] := i;
   end;

   for i := 0 to n2 do begin
      d[0][i] := i;
   end;

   for i := 1 to n1 do begin
      for j := 1 to n2 do begin
         d[i][j] := min(min(d[i - 1][j], d[i][j - 1]) + 1, d[i - 1][j - 1] + ifthen(str1[i] = str2[j], 0, 1));
      end;
   end;

   Result := d[n1][n2];
end;

// O(ND)アルゴリズムでのレーベンシュタイン距離の計算
// １文字の違い（置換）は２となるので使えない
function LD_ond(str1, str2: string): Integer;
var
   n1, n2: Integer;
   x, y: Integer;
   offset: Integer;
   V: array[0..100] of Integer;
   D: Integer;
   k: Integer;
begin
   n1 := Length(str1);
   n2 := Length(str2);

   if (n1 > 100) or (n2 > 100) then begin
      Result := 100;
      Exit;
   end;

   offset := n1;
   V[offset + 1] := 0;

   for D := 0 to (n1 + n2) do begin
      k := -D;
      while(k <= D) do begin
         if ((k = -D) or (k <> D) and (V[k - 1 + offset] < V[k + 1 + offset])) then begin
            x := V[k + 1 + offset];
         end
         else begin
            x := V[k - 1 + offset] + 1;
         end;

         y := x - k;
         while ((x < n1) and (y < n2) and (str1[x + 1] = str2[y + 1])) do begin
            Inc(x);
            Inc(y);
         end;

         V[k + offset] := x;
         if ((x >= n1) and (y >= n2)) then begin
            Result:= D;
            Exit;
         end;

         Inc(k, 2);
      end;
   end;

   Result:= -1;
end;

function PartialMatch(A, B: string): Boolean;
var
   i: integer;
begin
   Result := False;
   if (Pos('.', A) = 0) { and (Pos('?',A)=0) } then begin
      Result := (Pos(A, B) > 0);
   end
   else begin
      if Length(A) > Length(B) then begin
         Exit;
      end;

      for i := 1 to Length(A) do begin
         if A[i] <> '.' then begin
            if A[i] <> B[i] then begin
               Exit;
            end;
         end;
      end;

      Result := True;
   end;
end;

function PartialMatch2(strCompare, strTarget: string): Boolean;
var
   n: Integer;
begin
   n := LD_dp(strTarget, strCompare);
   if n <= 1 then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

function ZBoolToStr(fValue: Boolean): string;
begin
   if fValue = True then begin
      Result := '1';
   end
   else begin
      Result := '0';
   end;
end;

function ZStrToBool(strValue: string): Boolean;
begin
   if (strValue = '0') or (strValue = '') then begin
      Result := False;
   end
   else begin
      Result := True;
   end;
end;

function ZStringToColorDef(str: string; defcolor: TColor): TColor;
begin
   if StrToIntDef( str, -1 ) >= 0 then begin
      Result := StringToColor( str );
   end
   else begin
      Result := defcolor;
   end;
end;

function ZColorToString(color: TColor): string;
begin
   Result := '$' + IntToHex(color, 8);
end;

function ExPos(substr, str: string): Integer;
var
   i, j: integer;
   bad: boolean;
begin
   Result := 0;
   if (Length(substr) > Length(str)) or (substr = '') then
      exit;
   for i := 1 to (Length(str) - Length(substr) + 1) do begin
      bad := false;
      for j := 1 to Length(substr) do begin
         if substr[j] <> '?' then
            if substr[j] <> str[i + j - 1] then
               bad := true;
      end;
      if bad = false then begin
         Result := i;
         exit;
      end;
   end;
end;

// JA1–JS1, 7J1, 8J1–8N1, 7K1–7N4
// JA2–JS2, 7J2, 8J2–8N2
// JA3–JS3, 7J3, 8J3–8N3
// JA4–JS4, 7J4, 8J4–8N4
// JA5–JS5, 7J5, 8J5–8N5
// JA6–JS6, 7J6, 8J6–8N6
// JA7–JS7, 7J7, 8J7–8N7
// JA8–JS8, 7J8, 8J8–8N8
// JA9–JS9, 7J9, 8J9–8N9
// JA0–JS0, 7J0, 8J0–8N0
function IsDomestic(strCallsign: string): Boolean;
var
   S1: Char;
   S2: Char;
   S3: Char;
begin
   if strCallsign = '' then begin
      Result := True;
      Exit;
   end;

   if Length(strCallsign) < 3 then begin
      Result := False;
      Exit;
   end;

   S1 := strCallsign[1];
   S2 := strCallsign[2];
   S3 := strCallsign[3];

   if S1 = 'J' then begin
      if (S2 >= 'A') and (S2 <= 'S') then begin
         Result := True;
         Exit;
      end;
   end;

   if (S1 = '7') and (S2 = 'J') then begin
      Result := True;
      Exit;
   end;

   if S1 = '7' then begin
      if (S2 >= 'K') and (S2 <= 'N') then begin
         if (S3 >= '1') and (S3 <= '4') then begin
            Result := True;
            Exit;
         end;
      end;
   end;

   if S1 = '8' then begin
      if (S2 >= 'J') and (S2 <= 'N') then begin
         Result := True;
         Exit;
      end;
   end;

   Result := False;
end;

function CheckDiskFreeSpace(strPath: string; nNeed_MegaByte: Integer): Boolean;
var
   nAvailable: TLargeInteger;
   nTotalBytes: TLargeInteger;
   nTotalFreeBytes: TLargeInteger;
   nNeedBytes: TLargeInteger;
begin
   nNeedBytes := TLargeInteger(nNeed_MegaByte) * TLargeInteger(1024) * TLargeInteger(1024);

   // 空き容量取得
   if GetDiskFreeSpaceEx(PWideChar(strPath), nAvailable, nTotalBytes, @nTotalFreeBytes) = False then begin
      Result := False;
      Exit;
   end;

   // 空き領域は必要としている容量未満か
   if (nTotalFreeBytes < nNeedBytes) then begin
      Result := False;
      Exit;
   end;

   Result := True;
end;

procedure SetQsyViolation(aQSO: TQSO);
begin
   if Pos(MEMO_QSY_VIOLATION, aQSO.Memo) > 0 then begin
      Exit;
   end;

   if aQSO.Memo <> '' then begin
      aQSO.Memo := aQSO.Memo + ' ';
   end;

   aQSO.Memo := aQSO.Memo + MEMO_QSY_VIOLATION;
end;

procedure ResetQsyViolation(aQSO: TQSO);
begin
   aQSO.Memo := Trim(StringReplace(aQSO.Memo, MEMO_QSY_VIOLATION, '', [rfReplaceAll]));
end;

procedure SetDupeQso(aQSO: TQSO);
begin
   aQSO.Points := 0;
   aQSO.Dupe := True;
end;

procedure ResetDupeQso(aQSO: TQSO);
begin
   aQSO.Dupe := False;
   aQSO.Memo := Trim(StringReplace(aQSO.Memo, MEMO_DUPE, '', [rfReplaceAll]));
end;

function TextToBand(text: string): TBand;
var
   b: TBand;
begin
   for b := Low(MHzString) to High(MHzString) do begin
      if MHzString[b] = text then begin
         Result := b;
         Exit;
      end;
   end;
   Result := bUnknown;
end;

function TextToMode(text: string): TMode;
var
   m: TMode;
begin
   for m := Low(ModeString) to High(ModeString) do begin
      if ModeString[m] = text then begin
         Result := m;
         Exit;
      end;
   end;
   Result := mOther;
end;

function BandToText(b: TBand): string;
begin
   if b = bUnknown then begin
      Result := 'Unknown';
   end
   else begin
      Result := MHzString[b];
   end;
end;

function ModeToText(m: TMode): string;
begin
   if m = mOther then begin
      Result := 'Other';
   end
   else begin
      Result := ModeString[m];
   end;
end;

function BandToPower(B: TBand): TPower;
var
   strPower: string;
begin
   Result := pwrM;
   strPower := dmZLogGlobal.Settings._power[B];
   if strPower = 'H' then Result := pwrH;
   if strPower = 'M' then Result := pwrM;
   if strPower = 'L' then Result := pwrL;
   if strPower = 'P' then Result := pwrP;
end;

function TdmZLogGlobal.GetRootPath(): string;
begin
   Result := ExpandEnvironmentVariables(Settings._rootpath);
   if Settings._rootpath = '' then begin
      Result := ExtractFilePath(Application.ExeName);
   end;
   Result := IncludeTrailingPathDelimiter(Result);
end;

function LoadResourceString(uID: Integer): string;
var
   szText: array[0..1024] of Char;
   nLen: Integer;
   hInst: THandle;
begin
   ZeroMemory(@szText, SizeOf(szText));
   hInst := GetModuleHandle(nil);
   nLen := LoadString(hInst, uID, @szText, SizeOf(szText));
   if nLen > 0 then begin
      Result := StrPas(szText);
   end
   else begin
      Result := '';
   end;
end;

function IsFullPath(strPath: string): Boolean;
begin
   // ２文字目に :\ があるとフルパス判定
   if Pos(':\', strPath) = 2 then begin
      Result := True;
      Exit;
   end;

   // 先頭が \\ の場合もフルパス判定
   if Pos('\\', strPath) = 1 then begin
      Result := True;
      Exit;
   end;

   Result := False;
end;

function AdjustPath(v: string): string;
begin
   if v = '\' then begin
      v := '';
   end;
   Result := v;
end;

function GetEnvVar(strIn: string; startpos: Integer; var strOut: string): Integer;
var
   I: Integer;
   S: string;
   ch: Char;
   fStart: Boolean;
   L: Integer;
begin
   L := Length(strIn);
   S := Copy(strIn, startpos, L - (startpos - 1) );

   strOut := '';
   fStart := False;
   for I := 1 to Length(S) do begin
      ch := S[I];
      if ch = '%' then begin
         if fStart = True then begin
            strOut := strOut + ch;
            Result := (i + 1);
            Exit;
         end
         else begin
            fStart := True;
            strOut := '';
         end;
      end;

      if fStart = True then begin
         strOut := strOut + ch;
      end;
   end;

   Result := -1;
end;

function ExpandEnvironmentVariables(strOriginal: string): string;
var
   I: Integer;
   envstr: string;
   envstr2: string;
   strExpanded: string;
   envvar_value: string;
begin
   strExpanded := strOriginal;
   repeat
      // １文字目から
      I := 1;

      // %～%の文字列を取り出す
      I := GetEnvVar(strExpanded, I, envstr);

      // あった
      if I <> -1 then begin
         // %削除
         envstr2 := StringReplace(envstr, '%', '', [rfReplaceAll]);

         // 環境変数の値で置き換え
         if envstr2 = 'ZLOG_ROOT' then begin
            envvar_value := ExtractFilePath(Application.ExeName);
         end
         else begin
            envvar_value := GetEnvironmentVariable(envstr2);
         end;

         // 展開
         strExpanded := StringReplace(strExpanded, envstr, envvar_value, [rfReplaceAll]);
      end;
   until I = -1;

   Result := strExpanded;
end;

procedure FormShowAndRestore(F: TForm);
begin
   if F.WindowState = wsMinimized then begin
      F.WindowState := wsNormal;
   end;
   F.Show();
end;

function LoadFromResourceName(hinst: THandle; filename: string): TStringList;
var
   RS: TResourceStream;
   SL: TStringList;
   resname: string;
begin
   resname := 'IDF_' + StringReplace(filename, '.', '_', [rfReplaceAll]);

   RS := TResourceStream.Create(hinst, resname, RT_RCDATA);
   SL := TStringList.Create();
   SL.StrictDelimiter := True;
   try
      SL.LoadFromStream(RS);
   finally
      RS.Free();
      Result := SL;
   end;
end;

function GetCommPortsForOldVersion(lpPortNumbers: PULONG; uPortNumbersCount: ULONG; var puPortNumbersFound: ULONG): ULONG;
var
   reg: TRegistry;
   slKey: TStringList;
   i: Integer;
   S: string;
   P: PULONG;
   c: ULONG;
   portnum: Integer;
begin
   slKey := TStringList.Create();
   reg := TRegistry.Create(KEY_READ);
   try
      reg.RootKey := HKEY_LOCAL_MACHINE;
      reg.OpenKey('HARDWARE\DEVICEMAP\SERIALCOMM', False);

      reg.GetValueNames(slKey);

      P := lpPortNumbers;
      c := 0;
      for i := 0 to slKey.Count - 1 do begin
         if c >= uPortNumbersCount then begin
            Break;
         end;

         S := reg.ReadString(slKey[i]);

         S := StringReplace(S, 'COM', '', [rfReplaceAll]);

         portnum := StrToIntDef(S, 0);
         if (portnum >= 1) and (portnum <= 20) then begin
            P^ := portnum;
            Inc(P);
            Inc(c);
         end;
      end;

      puPortNumbersFound := c;
   finally
      reg.Free();
      slKey.Free();
   end;

   Result := 0;
end;

function TrimCRLF(SS : string) : string;
var
   S: string;
begin
   S := SS;
   while (length(S) > 0) and ((S[1] = Chr($0A)) or (S[1] = Chr($0D))) do begin
      Delete(S, 1, 1);
   end;

   while (length(S) > 0) and ((S[length(S)] = Chr($0A)) or (S[length(S)] = Chr($0D))) do begin
      Delete(S, length(S), 1);
   end;

   Result := S;
end;

end.
