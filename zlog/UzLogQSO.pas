unit UzLogQSO;

//{$DEFINE ZSERVER}

interface

uses
  System.SysUtils, System.Classes, StrUtils, IniFiles, Forms, Windows, Menus,
  System.DateUtils, Generics.Collections, Generics.Defaults,
  UzLogConst, HelperLib, UzLogAdif;

type
  TQSODataExHeader = packed record
    case Integer of
      0:(
        MagicNo: array[0..3] of Byte;
        NumRecords: Integer;
      );
      1:(
        Time : TDateTime;
      );
  end;

  TQSOData = packed record
    Header: TQSODataExHeader; {  8 bytes }
    CallSign: string[12];  { 13 bytes }
    NrSent: string[30];    { 31 bytes }
    NrRcvd: string[30];    { 31 bytes }
    filler: Byte;          {  1 byte }
    RSTSent: Word;         {  2 bytes }
    RSTRcvd: Word;         {  2 bytes }
    Serial: Integer;       {  4 bytes }
    Mode: TMode;           {  1 byte }
    Band: TBand;           {  1 byte }
    Power: TPower;         {  1 byte }
    Multi1: string[30];    { 31 bytes }
    Multi2: string[30];    { 31 bytes }
    NewMulti1: Boolean;    {  1 byte }
    NewMulti2: Boolean;    {  1 byte }
    Points: byte;          {  1 byte }
    Operator: string[14];  { 15 bytes Operator's name }
    Memo: string[64];      { 65 bytes max 64 char }
    CQ: Boolean;           {  1 byte }
    Dupe: Boolean;         {  1 byte }
    Reserve: byte;         {  1 byte used for z-link commands }
    TX: byte;              {  1 byte Transmitter number for 2 TX category }
    Power2: Integer;       {  4 bytes used by ARRL DX side only }
    Reserve2: Integer;     {  4 bytes $FF when forcing to log }
    Reserve3: Integer;     {  4 bytes QSO ID# }
    {TTSSSSRRCC   TT:TX#(00-21) SSSS:Serial counter
                                     RR:Random(00-99) CC:Edit counter 00 and up}
  end;

  TQSODataEx = packed record
    Header: TQSODataExHeader; {  8 bytes }
    CallSign: string[12];  { 13 bytes }
    NrSent: string[30];    { 31 bytes }
    NrRcvd: string[30];    { 31 bytes }
    filler: Byte;          {  1 byte }
    RSTSent: Word;         {  2 bytes }
    RSTRcvd: Word;         {  2 bytes }
    Serial: Integer;       {  4 bytes }
    Mode: TMode;           {  1 byte }
    Band: TBand;           {  1 byte }
    Power: TPower;         {  1 byte }
    Multi1: string[30];    { 31 bytes }
    Multi2: string[30];    { 31 bytes }
    NewMulti1: Boolean;    {  1 byte }
    NewMulti2: Boolean;    {  1 byte }
    Points: byte;          {  1 byte }
    Operator: string[14];  { 15 bytes Operator's name }
    Memo: string[64];      { 65 bytes max 64 char }
    CQ: Boolean;           {  1 byte }
    Dupe: Boolean;         {  1 byte }
    Reserve: byte;         {  1 byte used for z-link commands }
    TX: byte;              {  1 byte Transmitter number for 2 TX category }
    Power2: Integer;       {  4 bytes used by ARRL DX side only }
    Reserve2: Integer;     {  4 bytes $FF when forcing to log }
    Reserve3: Integer;     {  4 bytes QSO ID# }
    {TTSSSSRRCC   TT:TX#(00-21) SSSS:Serial counter
                                     RR:Random(00-99) CC:Edit counter 00 and up}
    // 256bytes

    Freq: string[10];      { 11 bytes "1800.0    " - "1200000.0 " }
    QsyViolation: Boolean; { 1 byte }
    PCName: string[10];    { 11 bytes max 10 char }
    Forced: Boolean;       { 1 byte }
    QslState: Byte;        { 1 byte 0:None 1:Pse QSL 2:No QSL }
    Invalid: Boolean;      { 1 byte false:valid true:invalid }
    RbnVerified: Boolean;  { 1 byte false:not verified true:verified }
    Reserve4: string[100]; { 100 bytes }
    // 384bytes
  end;

  TCTestwinHeader = packed record
    QsoCount: WORD;
    filler1: WORD;
    CQsoDataId: DWORD;
    CQsoDataNm: array[0..7] of AnsiChar;
  end;

   TCTestwinQsoData = packed record
      Callsign: array[0..19] of AnsiChar;
      SentNr: array[0..29] of AnsiChar;
      RecvNr: array[0..29] of AnsiChar;
      Mode: WORD;
      Band: WORD;
      TimeId: Int32;
      Time: Int32;
      OpeName: array[0..19] of AnsiChar;
      filler1: WORD;
      filler2: WORD;
      Dupe: WORD;
      Remarks: array[0..49] of AnsiChar;
      Delimiter: WORD;
   end;

  TQSO = class(TObject)
  private
    FIndex: Integer;
    FTime: TDateTime;
    FCallSign: string; { 13 bytes }
    FNrSent: string;
    FNrRcvd: string;
    FRSTSent: Integer; // word;  {2 bytes}
    FRSTRcvd: Integer;
    FSerial: Integer; { 4 bytes ? }
    FMode: TMode; { 1 byte }
    FBand: TBand; { 1 byte }
    FPower: TPower; { 1 byte }
    FMulti1: string;
    FMulti2: string;
    FNewMulti1: Boolean;
    FNewMulti2: Boolean;
    FPoints: Integer;
    FOperator: string; { Operator's name }
    FMemo: string; { max 64 char = 65 bytes }
    FCQ: Boolean; { not used yet }
    FDupe: Boolean;
    FReserve: Integer; { used for z-link commands }
    FTX: Integer; { Transmitter number for 2 TX category }
    FPower2: Integer; { used by ARRL DX side only }
    FReserve2: Integer; { $FF when forcing to log }
    FReserve3: Integer; { QSO ID# }
    {TTSSSSRRCC   TT:TX#(00-21) SSSS:Serial counter
                                      RR:Random(00-99) CC:Edit counter 00 and up}

    FFreq: string;
    FQsyViolation: Boolean;
    FPCName: string;
    FForced: Boolean;
    FQslState: TQslState;
    FInvalid: Boolean;
    FRbnVerified: Boolean;

    function GetMode2(): TMode;
    function GetPoints(): Integer;
    function GetQsoId(): Integer;
    function GetArea(): string;

    function GetFileRecord(): TQSOData;
    procedure SetFileRecord(src: TQSOData);
    function GetFileRecordEx(): TQSODataEx;
    procedure SetFileRecordEx(src: TQSODataEx);

    function GetSerialStr(): string;
    function GetDateTimeStr(): string;
    function GetTimeStr(): string;
    function GetDateStr(): string;
    function GetBandStr(): string;
    function GetBandStr2(): string;
    function GetModeStr(): string;
    function GetMode2Str(): string;
    function GetPowerStr(): string;
    function GetNewPowerStr(): string;
    function GetPointStr(): string;
    function GetRSTStr(): string;
    function GetRSTSentStr(): string;
    function GetRSTRcvdStr(): string;
    function GetFreqStr(): string;
    function GetFreqStr2(): string;
    function GetFreqStr3(): string;
    function GetMemoStr(): string;
    procedure SetInvalid(v: Boolean);
  public
    constructor Create;
    procedure IncTime;
    procedure DecTime;
    function PartialSummary(DispDate: Boolean) : string;
    function CheckCallSummary : string;
    procedure UpdateTime;
    {$IFNDEF ZSERVER}
    function zLogALL : string;
    {$ENDIF}
    function DOSzLogText : string;
    function DOSzLogTextShort : string;
    function QSOinText : string; {for data transfer}
    procedure TextToQSO(str : string); {convert text to bin}
    function QTCStr : string;

//    function SameQSO(aQSO: TQSO) : Boolean;
    function SameQSOID(aQSO: TQSO) : Boolean;
    function SameMode(aQSO: TQSO; IsAllPhone: Boolean): Boolean;
//    function SameMode2(aMode: TMode) : Boolean;

    procedure Assign(src: TQSO);

    property Index: Integer read FIndex write FIndex;
    property Time: TDateTime read FTime write FTime;
    property Callsign: string read FCallsign write FCallsign;
    property NrSent: string read FNrSent write FNrSent;
    property NrRcvd: string read FNrRcvd write FNrRcvd;

    property RSTSent: Integer read FRSTSent write FRSTSent;
    property RSTRcvd: Integer read FRSTRcvd write FRSTRcvd;
    property Serial: Integer read FSerial write FSerial;
    property Mode: TMode read FMode write FMode;
    property Mode2: TMode read GetMode2;
    property Band: TBand read FBand write FBand;
    property Power: TPower read FPower write FPower;
    property Multi1: string read FMulti1 write FMulti1;
    property Multi2: string read FMulti2 write FMulti2;
    property NewMulti1: Boolean read FNewMulti1 write FNewMulti1;
    property NewMulti2: Boolean read FNewMulti2 write FNewMulti2;
    property Points: Integer read GetPoints write FPoints;
    property Operator: string read FOperator write FOperator;
    property Memo: string read FMemo write FMemo;
    property CQ: Boolean read FCQ write FCQ;
    property Dupe: Boolean read FDupe write FDupe;
    property Reserve: Integer read FReserve write FReserve;
    property TX: Integer read FTX write FTX;
    property Power2: Integer read FPower2 write FPower2;
    property Reserve2: Integer read FReserve2 write FReserve2;
    property Reserve3: Integer read FReserve3 write FReserve3;
    property Freq: string read FFreq write FFreq;
    property QsyViolation: Boolean read FQsyViolation write FQsyViolation;
    property PCName: string read FPCName write FPCName;
    property Forced: Boolean read FForced write FForced;
    property QslState: TQslState read FQslState write FQslState;
    property Invalid: Boolean read FInvalid write SetInvalid;
    property QsoId: Integer read GetQsoId;
    property Area: string read GetArea;
    property RbnVerified: Boolean read FRbnVerified write FRbnVerified;

    property SerialStr: string read GetSerialStr;
    property DateTimeStr: string read GetDateTimeStr;
    property TimeStr: string read GetTimeStr;
    property DateStr: string read GetDateStr;
    property BandStr: string read GetBandStr;
    property BandStr2: string read GetBandStr2;
    property ModeStr: string read GetModeStr;
    property Mode2Str: string read GetMode2Str;
    property PowerStr: string read GetPowerStr;
    property NewPowerStr: string read GetNewPowerStr;
    property PointStr: string read GetPointStr;
    property RSTStr: string read GetRSTStr;
    property RSTSentStr: string read GetRSTSentStr;
    property RSTRcvdStr: string read GetRSTRcvdStr;
    property FreqStr: string read GetFreqStr;
    property FreqStr2: string read GetFreqStr2;
    property FreqStr3: string read GetFreqStr3;
    property MemoStr: string read GetMemoStr;

    property FileRecord: TQSOData read GetFileRecord write SetFileRecord;
    property FileRecordEx: TQSODataEx read GetFileRecordEx write SetFileRecordEx;
  end;

  TQSOCallsignComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSOTimeComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSOBandComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSOModeComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSOPowerComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSOTxNoComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSOPointComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSOOperatorComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSOMemoComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSOTxNoBandTimeComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSOTxNoTimeComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSODupeWithoutModeComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSODupeWithModeComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSODupeWithMode2Comparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TSortMethod = ( soCallsign = 0, soTime, soBand, soMode, soPower, soTxNo,
                  soPoint, soOperator, soMemo, soDupeCheck, soTxNoBandTime, soTxNoTime );

  TQSOList = class(TObjectList<TQSO>)
  private
    FCallsignComparer: TQSOCallsignComparer;
    FTimeComparer: TQSOTimeComparer;
    FBandComparer: TQSOBandComparer;
    FModeComparer: TQSOModeComparer;
    FPowerComparer: TQSOPowerComparer;
    FTxNoComparer: TQSOTxNoComparer;
    FPointComparer: TQSOPointComparer;
    FOperatorComparer: TQSOOperatorComparer;
    FMemoComparer: TQSOMemoComparer;
    FDupeWithoutModeComparer: TQSODupeWithoutModeComparer;
    FDupeWithModeComparer: TQSODupeWithModeComparer;
    FDupeWithMode2Comparer: TQSODupeWithMode2Comparer;
  public
    constructor Create(OwnsObjects: Boolean = True);
    destructor Destroy(); override;
    function IndexOf(C: string): Integer; overload;
    function IndexOf(Q: TQSO): Integer; overload;
    function MergeFile(filename: string; fFullMatch: Boolean): Integer;
    function MergeFileEx(filename: string; fFullMatch: Boolean): Integer;
    procedure Sort(SortMethod: TSortMethod; fWithMode: Boolean = False; fAllPhone: Boolean = True); overload;
    function DupeCheck(aQSO: TQSO; fWithMode: Boolean; fAllPhone: Boolean): TQSO;
  end;

  TQSOListArray = array[b19..HiBand] of TQSOList;
  TQSOListArrayByTx = array[0..(MAX_TX - 1)] of TQSOList;

  TLog = class(TObject)
  private
    FSaved : Boolean;
    FQsoList: TQSOList;
    FQueList: TQSOList;
    FQueOK : Boolean;
    FAcceptDifferentMode : Boolean;
    FCountHigherPoints : Boolean;
    FDifferentModePointer : Integer; //points to a qso on a different mode but not dupe
    FDupeCheckList: TQSOListArray;
    FBandList: TQSOListArray;
    FTxList: TQSOListArrayByTx;
    FAllPhone: Boolean;    // True: SSB, FM, AM are same
    FQsoIdDic: TDictionary<Integer, TQSO>;
    FStartTime: TDateTime;
    FEndTime: TDateTime;
    FPeriod: Integer;
    procedure Delete(i : Integer);
    procedure ProcessDelete(beforeQSO: TQSO);
    procedure ProcessEdit(afterQSO: TQSO; fAdd: Boolean);
    procedure ProcessInsert(afterQSO: TQSO);
    procedure ProcessLock(xQSO: TQSO);
    procedure ProcessUnlock(xQSO: TQSO);
    procedure SetScoreCoeff(E: Extended);
    function GetScoreCoeff(): Extended;
    function GetActualFreq(b: TBand; strFreq: string): string;
    function GetEndTime(): TDateTime;
    procedure SetPeriod(v: Integer);
    procedure ImportSetQsoId(Q: TQSO);
    procedure ImportFinish(Q: TQSO);
    {$IFNDEF ZSERVER}
    function GetLastCallsign(): string;
    function GetLastNumber(): string;
    {$ENDIF}
    function IsSameBand(b1: TBand; b2: TBand): Boolean;
  public
    constructor Create(memo : string);
    destructor Destroy; override;

    function Year: Integer; //returns the year of the 1st qso
    function TotalQSO : Integer;
    function TotalPoints : Integer;
    function TotalCW : Integer;
    function TotalMulti1 : Integer;
    function TotalMulti2 : Integer;

    procedure Add(aQSO : TQSO; fNoSort: Boolean = False);
    procedure Insert(i : Integer; aQSO : TQSO);

    procedure DeleteQSO(aQSO: TQSO);

    procedure Backup(Filename: string);


    procedure SaveToFile(Filename : string);
    procedure SaveToFileEx(Filename: string);
    procedure SaveToFileAszLogDOSTXT(Filename : string);
    procedure SaveToFileAszLogCsv(Filename: string);
    {$IFNDEF ZSERVER}
    procedure SaveToFileAszLogALL(Filename : string);
    procedure SaveToFileAsTxtByTX(Filename : string);
    procedure SaveToFileAsCabrillo(Filename: string; nTimeZoneOffset: Integer; slSummaryInfo: TStringList = nil);
    procedure SaveToFileAsHamlog(Filename: string; nRemarks1Option: Integer; nRemarks2Option: Integer; strRemarks1: string; strRemarks2: string; nCodeOption: Integer; nNameOption: Integer; nTimeOption: Integer; strQslStateText: string; nFreqOption: Integer);
    procedure SaveToFileAsHamSupport(Filename: string);
    procedure SaveToFileAsAdif(Filename: string);
    {$ENDIF}
    function IsDupe(aQSO : TQSO) : Integer;
    function IsDupe2(aQSO : TQSO; index : Integer; var dupeindex : Integer) : Boolean;
    procedure AddQue(aQSO : TQSO);
    procedure ProcessQue;
    procedure Clear2(); // deletes all QSOs without destroying the List. Keeps List[0] intact
    procedure SortBy(SortMethod: TSortMethod);
    procedure SortByTime();
    procedure SortByTxNoBandTime();
    procedure SortByTxNoTime();

    function ContainBand : TBandBool;
    procedure SetDupeFlags;
//    procedure DeleteBand(B : TBand);
    function CheckQSOID(qsoid: Integer) : Boolean;
    procedure RebuildDupeCheckList;
    procedure ClearDupeCheckList;
    function QuickDupe(aQSO : TQSO) : TQSO;
    procedure RemoveDupes;
    function OpQSO(OpName : string) : Integer;

    function IndexOf(aQSO: TQSO): Integer; overload;
    function ObjectOf(callsign: string): TQSO; overload;
    function ObjectOf(qsoid: Integer): TQSO; overload;

    function LoadFromFile(filename: string): Integer;
    function LoadFromFileEx(filename: string): Integer;
    {$IFNDEF ZSERVER}
    function LoadFromFileAszLogCsv(Filename: string): Integer;
    function LoadFromFileAsAdif(Filename: string): Integer;
    function LoadFromFileAsCabrillo(Filename: string; nTimeZoneOffset: Integer): Integer;
    function LoadFromFileAsCtestwin(Filename: string): Integer;
    function LoadFromFileAsJarlPubLog(Filename: string): Integer;
//    function MergeFile(filename: string): Integer;

    function IsWorked(strCallsign: string; band: TBand): Boolean;
    {$ENDIF}
    function IsNewMulti(band: TBand; multi: string): Boolean;
    procedure RenewMulti();
    function IsContainsSameQSO(Q: TQSO): Boolean;
    function IsOutOfPeriod(Q: TQSO): Boolean;
    procedure JudgeOutOfPeriod();

    {$IFNDEF ZSERVER}
    function IsOtherBandWorked(strCallsign: string; exclude_band: TBand; var workdmulti: string): Boolean;
    function EvaluateQSYCount(nStartIndex: Integer): Integer;

    function GetLastSerial(aQSO: TQSO): Integer;
    function GetCurrentSerial(aQSO: TQSO): Integer;
    {$ENDIF}

    procedure Renumber();

    property Saved: Boolean read FSaved write FSaved;
    property AcceptDifferentMode: Boolean read FAcceptDifferentMode write FAcceptDifferentMode;
    property CountHigherPoints: Boolean read FCountHigherPoints write FCountHigherPoints;
    property DifferentModePointer: Integer read FDifferentModePointer write FDifferentModePointer; //points to a qso on a different mode but not dupe

    property QsoList: TQSOList read FQsoList;
    property BandList: TQSOListArray read FBandList;
    property TxList: TQSOListArrayByTx read FTxList;

    property ScoreCoeff: Extended read GetScoreCoeff write SetScoreCoeff;

    property AllPhone: Boolean read FAllPhone write FAllPhone;

    property StartTime: TDateTime read FStartTime write FStartTime;
    property EndTime: TDateTime read GetEndTime;
    property Period: Integer read FPeriod write SetPeriod;

    {$IFNDEF ZSERVER}
    property LastCallsign: string read GetLastCallsign;
    property LastNumber: string read GetLastNumber;
    {$ENDIF}
  end;

implementation

uses
  UzLogGlobal, UzLogExtension
  {$IFNDEF ZSERVER}
  , UzLogContest, Main
  {$ENDIF};

{ TQSO }

constructor TQSO.Create;
begin
   Inherited;

   FTime := Date + Time;
   FCallSign := '';
   { FNrSent := ''; }
   FNrRcvd := '';

   if FMode = mCW then begin
      FRSTSent := 599;
      FRSTRcvd := 599;
   end
   else begin
      FRSTSent := 59;
      FRSTRcvd := 59;
   end;

   FSerial := 1;
   FMulti1 := '';
   FMulti2 := '';
   FNewMulti1 := False;
   FNewMulti2 := False;
   FPoints := 1;
   { FOperator := ''; }
   FMemo := '';
   FCQ := False;
   FDupe := False;
   FReserve := 0;
   FTX := 0;
   FPower2 := 500;
   FReserve2 := 0;
   FReserve3 := 0;

   FFreq := '';
   FQsyViolation := False;
   FPCName := '';
   FForced := False;
   FQslState := qsNone;
   FInvalid := False;
   FRbnVerified := False;
end;

procedure TQSO.IncTime;
begin
   Self.FTime := Self.FTime + 1.0 / (24 * 60);
end;

procedure TQSO.DecTime;
begin
   Self.FTime := Self.FTime - 1.0 / (24 * 60);
end;

function TQSO.QSOinText: string; { for data transfer }
var
   slText: TStringList;
begin
   slText := TStringList.Create();
   slText.StrictDelimiter := True;
   slText.Delimiter := _sep;
   try
      slText.Add('ZLOGQSODATA:');
      slText.Add(FloatToStr(Time));
      slText.Add(Callsign);
      slText.Add(NrSent);
      slText.Add(NrRcvd);
      slText.Add(IntToStr(RSTSent));
      slText.Add(IntToStr(RSTRcvd));
      slText.Add(IntToStr(Serial));
      slText.Add(IntToStr(ord(Mode)));
      slText.Add(IntToStr(ord(Band)));
      slText.Add(IntToStr(ord(Power)));
      slText.Add(Multi1);
      slText.Add(Multi2);
      slText.Add(ZBoolToStr(NewMulti1));
      slText.Add(ZBoolToStr(NewMulti2));
      slText.Add(IntToStr(Points));
      slText.Add(Operator);
      slText.Add(Memo);
      slText.Add(ZBoolToStr(CQ));
      slText.Add(ZBoolToStr(Dupe));
      slText.Add(IntToStr(Reserve));
      slText.Add(IntToStr(TX));
      slText.Add(IntToStr(Power2));
      slText.Add(IntToStr(Reserve2));
      slText.Add(IntToStr(Reserve3));
      slText.Add(Freq);
      slText.Add(ZBoolToStr(QsyViolation));
      slText.Add(PCName);
      slText.Add(ZBoolToStr(Forced));
      slText.Add(IntToStr(Integer(QslState)));
      slText.Add(ZBoolToStr(Invalid));

      Result := slText.DelimitedText;
   finally
      slText.Free();
   end;
end;

procedure TQSO.TextToQSO(str: string); { convert text to bin }
var
   slText: TStringList;
begin
   slText := TStringList.Create();
   slText.StrictDelimiter := True;
   slText.Delimiter := _sep;
   try
   try
      // NULL文字があれば削除
      str := StringReplace(str, #00, '', [rfReplaceAll]);

      slText.DelimitedText := str + DupeString(_sep, 30);

      if slText[0] <> 'ZLOGQSODATA:' then begin
         Exit;
      end;

      Time     := StrToFloat(slText[1]);
      CallSign := slText[2];
      NrSent   := slText[3];
      NrRcvd   := slText[4];
      RSTSent  := StrToInt(slText[5]);
      RSTRcvd  := StrToInt(slText[6]);
      Serial   := StrToInt(slText[7]);
      Mode     := TMode(StrToInt(slText[8]));
      Band     := TBand(StrToInt(slText[9]));
      Power    := TPower(StrToInt(slText[10]));
      Multi1   := slText[11];
      Multi2   := slText[12];
      NewMulti1 := ZStrToBool(slText[13]);
      NewMulti2 := ZStrToBool(slText[14]);
      Points   := StrToInt(slText[15]);
      Operator := slText[16];
      Memo     := slText[17];
      CQ       := ZStrToBool(slText[18]);
      Dupe     := ZStrToBool(slText[19]);
      Reserve  := StrToInt(slText[20]);
      TX       := StrToInt(slText[21]);
      Power2   := StrToInt(slText[22]);
      Reserve2 := StrToInt(slText[23]);
      Reserve3 := StrToInt(slText[24]);
      Freq     := slText[25];
      QsyViolation := ZStrToBool(slText[26]);
      PCName   := slText[27];
      Forced   := ZStrToBool(slText[28]);
      QslState  := TQslState(StrToIntDef(slText[29], 0));
      Invalid  := ZStrToBool(slText[30]);
   except
      on EConvertError do begin
         FMemo := 'Convert Error!';
      end;
   end;
   finally
      slText.Free();
   end;
end;

procedure TQSO.UpdateTime;
begin
   {$IFNDEF ZSERVER}
   if Assigned(MyContest) and (MyContest.UseUTC) then begin
      FTime := GetUTC();
   end
   else begin
      FTime := Now;
   end;
   {$ELSE}
   FTime := Now;
   {$ENDIF}
end;

function TQSO.GetSerialStr: string;
var
   S: string;
begin
   S := IntToStr(Self.FSerial);
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
   Result := FormatDateTime('hhnn', Self.Time) + ' ' + Self.CallSign + ' ' + Self.NrRcvd;
end;

function TQSO.GetDateTimeStr: string;
begin
   Result := FormatDateTime('yyyy/mm/dd hh:nn', Self.Time);
end;

function TQSO.GetTimeStr: string;
begin
   Result := FormatDateTime('hh:nn', Self.Time);
end;

function TQSO.GetDateStr: string;
begin
   Result := FormatDateTime('yyyy/mm/dd', Self.Time);
end;

function TQSO.GetBandStr: string;
begin
   if FBand = bUnknown then begin
      Result := 'Unknown';
   end
   else begin
      Result := MHzString[Self.FBand];
   end;
end;

function TQSO.GetBandStr2: string;
begin
   if FBand = bUnknown then begin
      Result := 'Unknown';
   end
   else begin
      Result := ADIFBandString[Self.FBand];
   end;
end;

function TQSO.GetModeStr: string;
begin
   Result := ModeString[Self.FMode];
end;

function TQSO.GetMode2Str: string;
begin
   Result := ModeString2[Self.FMode];
end;

function TQSO.GetPowerStr: string;
var
   power: string;
begin
//   Result := dmZLogGlobal.PowerOfBand2[Band];
   power := NewPowerString[Self.FPower];

   {$IFNDEF ZSERVER}
   if power = 'H' then begin
      Result := dmZLogGlobal.Settings._powerH;
   end
   else if power = 'M' then begin
      Result := dmZLogGlobal.Settings._powerM;
   end
   else if power = 'L' then begin
      Result := dmZLogGlobal.Settings._powerL;
   end
   else if power = 'P' then begin
      Result := dmZLogGlobal.Settings._powerP;
   end
   else begin
      Result := dmZLogGlobal.Settings._powerM;
   end;
   {$ELSE}
   Result := power;
   {$ENDIF}
end;

function TQSO.GetNewPowerStr: string;
begin
   Result := NewPowerString[Self.FPower];
end;

function TQSO.GetPointStr: string;
begin
   Result := IntToStr(Self.FPoints);
end;

function TQSO.GetRSTStr(): string;
begin
   Result := IntToStr(Self.FRSTRcvd);
end;

function TQSO.GetRSTSentStr(): string;
begin
   Result := IntToStr(Self.FRSTSent);
end;

function TQSO.GetRSTRcvdStr(): string;
begin
   Result := IntToStr(Self.FRSTRcvd);
end;

function TQSO.GetFreqStr(): string;
var
   strFreq: string;
   fFreq: Extended;
   b2: TBand;
begin
   strFreq := Self.Freq;

   if strFreq = '' then begin
      Result := Self.BandStr;
      Exit;
   end;

   fFreq := StrToFloatDef(strFreq, 0);
   if fFreq = 0 then begin
      Result := Self.BandStr;
      Exit;
   end;

   {$IFNDEF ZSERVER}
   // FreqがBandと違う場合はBandを返す
   fFreq := StrToFloatDef(strFreq, 0);
   b2 := dmZLogGlobal.BandPlan.FreqToBand(Trunc(fFreq) * 1000);
   if b2 <> Self.Band then begin
      Result := Self.BandStr;
      Exit;
   end;
   {$ENDIF}

   Result := strFreq;
end;

function TQSO.GetFreqStr2(): string;
var
   strFreq: string;
   fFreq: Extended;
begin
   strFreq := Self.Freq;

   fFreq := StrToFloatDef(strFreq, 0);
   if fFreq = 0 then begin
      Result := '';
      Exit;
   end;

   strFreq := Format('%.4f', [fFreq / 1000]);

   Result := strFreq;
end;

// 7117.6
// 7.1176

function TQSO.GetFreqStr3(): string;
var
   strFreq: string;
   fFreq: Extended;
   Index: Integer;
   strMHz: string;
   strkHz: string;
begin
   strFreq := Self.Freq;

   fFreq := StrToFloatDef(strFreq, 0);
   if fFreq = 0 then begin
      Result := '';
      Exit;
   end;

   strFreq := Format('%.4f', [fFreq / 1000]);

   Index := Pos('.', strFreq);
   strMHz := Copy(strFreq, 1, Index - 1);

   strkHz := RightStr(Self.Freq, 5);

   Result := strMHz + '.' + strkHz;
end;

function TQSO.GetMemoStr(): string;
var
   strMemo: string;

   function AddStr(S1, S2: string): string;
   begin
      if S1 <> '' then begin
         Result := S1 + ' ';
      end;
      Result := Result + S2;
   end;
begin
   strMemo := '';

   {$IFNDEF ZSERVER}
   // QSL
   if dmZLogGlobal.Settings._qsl_default <> FQslState then begin
      case FQslState of
         qsNone:   strMemo := AddStr(strMemo, '');
         qsPseQsl: strMemo := AddStr(strMemo, MEMO_PSE_QSL);
         qsNoQsl:  strMemo := AddStr(strMemo, MEMO_NO_QSL);
      end;
   end;
   {$ENDIF}

   if FForced = True then begin
      strMemo := AddStr(strMemo, '*');
   end;

   if FDupe = True then begin
      strMemo := AddStr(strMemo, MEMO_DUPE);
   end;

   if FFreq <> '' then begin
      strMemo := AddStr(strMemo, '(' + FFreq + ')');
   end;

   strMemo := AddStr(strMemo, FMemo);

   if FQsyViolation = True then begin
      strMemo := AddStr(strMemo, MEMO_QSY_VIOLATION);
   end;

   Result := strMemo;
end;

procedure TQSO.SetInvalid(v: Boolean);
begin
   FInvalid := v;
   if v = True then begin
      FMulti1 := '';
      FMulti2 := '';
   end;
end;

function TQSO.PartialSummary(DispDate: Boolean): string;
var
   S: string;
begin
   if DispDate then begin
      S := DateStr + ' ';
   end
   else begin
      S := '';
   end;

   S := S + TimeStr + ' ' +
        FillRight(Self.CallSign, 12) +
        FillRight(Self.NrRcvd, 15) +
        FillRight(BandStr, 5) +
        FillRight(ModeStr, 5);

   Result := S;
end;

function TQSO.CheckCallSummary: string;
var
   S: string;
begin
   S := FillRight(BandStr, 5) +
        TimeStr + ' ' +
        FillRight(Self.CallSign, 12) +
        FillRight(Self.NrRcvd, 15) +
        FillRight(ModeStr, 5);

   Result := S;
end;

function TQSO.DOSzLogText: string;
var
   S, temp: string;
   Year, Month, Day, Hour, Min, Sec, MSec: word;
begin
   S := '';
   DecodeDate(Self.FTime, Year, Month, Day);
   DecodeTime(Self.FTime, Hour, Min, Sec, MSec);
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
   S := S + FillRight(Self.CallSign, 11);
   S := S + FillLeft(IntToStr(Self.RSTSent), 3);
   S := S + FillRight(Self.NrSent, 31);
   S := S + FillLeft(IntToStr(Self.RSTRcvd), 3);
   S := S + FillRight(Self.NrRcvd, 31);

   if Self.NewMulti1 then
      S := S + FillLeft(Self.Multi1, 6)
   else
      S := S + '      ';

   S := S + '  ' + FillLeft(MHzString[Self.Band], 4);
   S := S + '  ' + FillRight(ModeString[Self.Mode], 3);
   S := S + ' ' + FillRight(IntToStr(Self.Points), 2);

   if Self.FOperator <> '' then begin
      S := S + '%%' + Self.Operator + '%%';
   end;

   S := S + Self.MemoStr;

   Result := S;
end;

function TQSO.DOSzLogTextShort: string;
var
   S, temp: string;
   Year, Month, Day, Hour, Min, Sec, MSec: word;
begin
   S := '';
   DecodeDate(Self.Time, Year, Month, Day);
   DecodeTime(Self.Time, Hour, Min, Sec, MSec);
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
   S := S + FillRight(Self.CallSign, 11);
   S := S + FillLeft(IntToStr(Self.RSTSent), 3);
   S := S + FillRight(Self.NrSent, 10);
   S := S + FillLeft(IntToStr(Self.RSTRcvd), 3);
   S := S + FillRight(Self.NrRcvd, 10);

   if Self.NewMulti1 then
      S := S + FillLeft(Self.Multi1, 6)
   else
      S := S + '      ';
   S := S + '  ' + FillLeft(MHzString[Self.Band], 4);
   S := S + '  ' + FillRight(ModeString[Self.Mode], 3);
   S := S + ' ' + FillRight(IntToStr(Self.Points), 2);
   if Self.Operator <> '' then begin
      S := S + '  ' + '%%' + Self.Operator + '%%';
   end;

   S := S + '  ' + Self.MemoStr;

   Result := S;
end;

{$IFNDEF ZSERVER}
function TQSO.zLogALL: string;
var
   S: string;
   nrlen: Integer;
begin
   nrlen := 7;
   S := '';
   S := S + FormatDateTime('yyyy/mm/dd hh":"nn ', Self.Time);
   S := S + FillRight(Self.CallSign, 13);
   S := S + FillRight(IntToStr(Self.RSTSent), 4);
   S := S + FillRight(Self.NrSent, nrlen + 1);
   S := S + FillRight(IntToStr(Self.RSTRcvd), 4);
   S := S + FillRight(Self.NrRcvd, nrlen + 1);

   if Self.NewMulti1 then
      S := S + FillRight(Self.Multi1, 6)
   else
      S := S + '-     ';

   if Self.NewMulti2 then
      S := S + FillRight(Self.Multi2, 6)
   else
      S := S + '-     ';

   S := S + FillRight(MHzString[Self.Band], 5);
   S := S + FillRight(ModeString[Self.Mode], 5);
   S := S + FillRight(IntToStr(Self.Points), 3);

   if Self.Operator <> '' then begin
      S := S + FillRight('%%' + Self.Operator + '%%', 19);
   end;

   if dmZlogGlobal.ContestCategory in [ccMultiOpMultiTx, ccMultiOpSingleTx, ccMultiOpTwoTx] then begin
      S := S + FillRight('TX#' + IntToStr(Self.TX), 6);
   end;

   S := S + Self.MemoStr;
   Result := S;
end;
{$ENDIF}

{
function TQSO.SameQSO(aQSO: TQSO): Boolean;
begin
   if (aQSO.FBand = Self.FBand) and
      (aQSO.FCallSign = Self.FCallSign) and
      (aQSO.FMode = Self.FMode) and
      (aQSO.FDupe = Self.FDupe) and
      (aQSO.FSerial = Self.FSerial) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;
}

function TQSO.SameQSOID(aQSO: TQSO): Boolean;
begin
   if (aQSO.FReserve3 div 100) = (Self.FReserve3 div 100) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

function TQSO.SameMode(aQSO: TQSO; IsAllPhone: Boolean): Boolean;
begin
   Result := False;
   case Self.FMode of
      mCW: begin
         if aQSO.FMode = mCW then begin
            Result := True;
         end;
      end;

      mSSB, mFM, mAM, mDV: begin
         if IsAllPhone = True then begin
            if aQSO.FMode in [mSSB, mFM, mAM, mDV] then begin
               Result := True;
            end;
         end
         else begin
            if aQSO.Mode = Self.FMode then begin
               Result := True;
            end;
         end;
      end;

      mRTTY: begin
         if aQSO.FMode = mRTTY then begin
            Result := True;
         end;
      end;

      mOther: begin
         if aQSO.FMode = mOther then begin
            Result := True;
         end;
      end;

      else begin
         Result := False;
      end;
   end;
end;

{
function TQSO.SameMode2(aMode: TMode): Boolean;
begin
   Result := False;
   case Self.FMode of
      mCW: begin
         if aMode = mCW then begin
            Result := True;
         end;
      end;

      mSSB, mFM, mAM: begin
         if aMode in [mSSB, mFM, mAM] then begin
            Result := True;
         end;
      end;

      mRTTY: begin
         if aMode = mRTTY then begin
            Result := True;
         end;
      end;

      mOther: begin
         if aMode = mOther then begin
            Result := True;
         end;
      end;

      else begin
         Result := False;
      end;
   end;
end;
}

function TQSO.GetMode2(): TMode;
const
   Mode2: array[mCW..LastMode] of TMode = (mCW, mSSB, mSSB, mSSB, mRTTY, mFT4, mFT8, mOther, mDV );
begin
   Result := Mode2[Self.Mode];
end;

function TQSO.GetPoints(): Integer;
begin
   if FInvalid = True then begin
      Result := 0;
   end
   else begin
      Result := FPoints;
   end;
end;

function TQSO.GetQsoId(): Integer;
begin
   Result := FReserve3 div 100;
end;

function TQSO.GetArea(): string;
var
   area: string;
   Index: Integer;
   S1: Char;
   S2: Char;
   S3: Char;
begin
   if IsDomestic(Callsign) = False then begin
      Result := '';
      Exit;
   end;

   Index := Pos('/', Callsign);
   if Index > 0 then begin
      area := Copy(Callsign, Index + 1);
   end
   else begin
      S1 := Callsign[1];
      S2 := Callsign[2];
      S3 := Callsign[3];

      if S1 = '7' then begin
         if (S2 >= 'K') and (S2 <= 'N') then begin
            if (S3 >= '1') and (S3 <= '4') then begin
               Result := '1';
               Exit;
            end;
         end;
      end;

      area := Copy(Callsign, 3, 1);
   end;

   Result := area;
end;

procedure TQSO.Assign(src: TQSO);
begin
   FTime := src.FTime;
   FCallSign := src.FCallSign;
   FNrSent := src.FNrSent;
   FNrRcvd := src.FNrRcvd;
   FRSTSent := src.FRSTSent;
   FRSTRcvd := src.FRSTRcvd;
   FSerial := src.FSerial;
   FMode := src.FMode;
   FBand := src.FBand;
   FPower := src.FPower;
   FMulti1 := src.FMulti1;
   FMulti2 := src.FMulti2;
   FNewMulti1 := src.FNewMulti1;
   FNewMulti2 := src.FNewMulti2;
   FPoints := src.FPoints;
   FOperator := src.FOperator;
   FMemo := src.FMemo;
   FCQ := src.FCQ;
   FDupe := src.FDupe;
   FReserve := src.FReserve;
   FTX := src.FTX;
   FPower2 := src.FPower2;
   FReserve2 := src.FReserve2;
   FReserve3 := src.FReserve3;
   FFreq := src.FFreq;
   FQsyViolation := src.FQsyViolation;
   FPCName := src.FPCName;
   FForced := src.FForced;
   FQslState := src.FQslState;
   FInvalid := src.Invalid;
   FRbnVerified := src.RbnVerified;
end;

function TQSO.GetFileRecord(): TQSOData;
begin
   FillChar(Result, SizeOf(Result), #00);
   Result.Header.Time := FTime;
   Result.CallSign   := ShortString(FCallSign);
   Result.NrSent     := ShortString(FNrSent);
   Result.NrRcvd     := ShortString(FNrRcvd);
   Result.RSTSent    := Word(FRSTSent);
   Result.RSTRcvd    := Word(FRSTRcvd);
   Result.Serial     := FSerial;
   Result.Mode       := FMode;
   Result.Band       := FBand;
   Result.Power      := FPower;
   Result.Multi1     := ShortString(FMulti1);
   Result.Multi2     := ShortString(FMulti2);
   Result.NewMulti1  := FNewMulti1;
   Result.NewMulti2  := FNewMulti2;
   Result.Points     := Byte(FPoints);
   Result.Operator   := ShortString(FOperator);
   Result.Memo       := ShortString(MemoStr);
   Result.CQ         := FCQ;
   Result.Dupe       := FDupe;
   Result.Reserve    := 0;
   Result.TX         := Byte(FTX);
   Result.Power2     := FPower2;
   Result.Reserve2   := FReserve2;
   Result.Reserve3   := FReserve3;
end;

procedure TQSO.SetFileRecord(src: TQSOData);
var
   Index1: Integer;
   Index2: Integer;
   strTemp: string;
begin
   FTime       := src.Header.Time;
   FCallSign   := string(src.CallSign);
   FNrSent     := string(src.NrSent);
   FNrRcvd     := string(src.NrRcvd);
   FRSTSent    := Integer(src.RSTSent);
   FRSTRcvd    := Integer(src.RSTRcvd);
   FSerial     := src.Serial;
   FMode       := src.Mode;
   FBand       := src.Band;
   FPower      := src.Power;
   FMulti1     := string(src.Multi1);
   FMulti2     := string(src.Multi2);
   FNewMulti1  := src.NewMulti1;
   FNewMulti2  := src.NewMulti2;
   FPoints     := Integer(src.Points);
   FOperator   := string(src.Operator);
   FMemo       := string(src.Memo);
   FCQ         := src.CQ;
   FDupe       := src.Dupe;
   FReserve    := Integer(src.Reserve);
   FTX         := Integer(src.TX);
   FPower2     := src.Power2;
   FReserve2   := src.Reserve2;
   FReserve3   := src.Reserve3;

   FFreq := '';
   Index1 := Pos('(', FMemo);
   if Index1 > 0 then begin
      strTemp := Copy(FMemo, Index1 + 1);
      Index2 := Pos(')', strTemp);
      if Index2 > 0 then begin
         FFreq := Copy(strTemp, 1, Index2 - 1);
         FMemo := Copy(strTemp, Index2 + 1);
      end;
   end;

   if Pos(MEMO_DUPE, FMemo) > 0 then begin
      FDupe := True;
      FMemo := Trim(StringReplace(FMemo, MEMO_DUPE, '', [rfReplaceAll]));
   end;
   if Pos(MEMO_QSY_VIOLATION, FMemo) > 0 then begin
      FQsyViolation := True;
      FMemo := Trim(StringReplace(FMemo, MEMO_QSY_VIOLATION, '', [rfReplaceAll]));
   end;
   if Pos('*', FMemo) > 0 then begin
      FForced := True;
      FMemo := Trim(StringReplace(FMemo, '*', '', [rfReplaceAll]));
   end;
   if Pos(MEMO_PSE_QSL, FMemo) > 0 then begin
      FQslState := qsPseQsl;
      FMemo := Trim(StringReplace(FMemo, MEMO_PSE_QSL, '', [rfReplaceAll]));
   end;
   if Pos(MEMO_NO_QSL, FMemo) > 0 then begin
      FQslState := qsNoQsl;
      FMemo := Trim(StringReplace(FMemo, MEMO_NO_QSL, '', [rfReplaceAll]));
   end;

   FInvalid := False;
end;

function TQSO.GetFileRecordEx(): TQSODataEx;
begin
   FillChar(Result, SizeOf(Result), #00);
   Result.Header.Time := FTime;
   Result.CallSign   := ShortString(FCallSign);
   Result.NrSent     := ShortString(FNrSent);
   Result.NrRcvd     := ShortString(FNrRcvd);
   Result.RSTSent    := Word(FRSTSent);
   Result.RSTRcvd    := Word(FRSTRcvd);
   Result.Serial     := FSerial;
   Result.Mode       := FMode;
   Result.Band       := FBand;
   Result.Power      := FPower;
   Result.Multi1     := ShortString(FMulti1);
   Result.Multi2     := ShortString(FMulti2);
   Result.NewMulti1  := FNewMulti1;
   Result.NewMulti2  := FNewMulti2;
   Result.Points     := Byte(FPoints);
   Result.Operator   := ShortString(FOperator);
   Result.Memo       := ShortString(FMemo);
   Result.CQ         := FCQ;
   Result.Dupe       := FDupe;
   Result.Reserve    := 0;
   Result.TX         := Byte(FTX);
   Result.Power2     := FPower2;
   Result.Reserve2   := FReserve2;
   Result.Reserve3   := FReserve3;
   Result.Freq       := ShortString(FFreq);
   Result.QsyViolation := FQsyViolation;
   Result.PCName     := ShortString(FPCName);
   Result.Forced     := FForced;
   Result.QslState   := Byte(FQslState);
   Result.Invalid    := FInvalid;
   Result.RbnVerified := FRbnVerified;
end;

procedure TQSO.SetFileRecordEx(src: TQSODataEx);
begin
   if (src.header.MagicNo[0] = Ord('Z')) and
      (src.header.MagicNo[1] = Ord('L')) and
      (src.header.MagicNo[2] = Ord('O')) and
      (src.header.MagicNo[3] = Ord('X')) then begin
      FTime       := 0;
   end
   else begin
      FTime       := src.Header.Time;
   end;

   FCallSign   := string(src.CallSign);
   FNrSent     := string(src.NrSent);
   FNrRcvd     := string(src.NrRcvd);
   FRSTSent    := Integer(src.RSTSent);
   FRSTRcvd    := Integer(src.RSTRcvd);
   FSerial     := src.Serial;
   FMode       := src.Mode;
   FBand       := src.Band;
   FPower      := src.Power;
   FMulti1     := string(src.Multi1);
   FMulti2     := string(src.Multi2);
   FNewMulti1  := src.NewMulti1;
   FNewMulti2  := src.NewMulti2;
   FPoints     := Integer(src.Points);
   FOperator   := string(src.Operator);
   FMemo       := string(src.Memo);
   FCQ         := src.CQ;
   FDupe       := src.Dupe;
   FReserve    := Integer(src.Reserve);
   FTX         := Integer(src.TX);
   FPower2     := src.Power2;
   FReserve2   := src.Reserve2;
   FReserve3   := src.Reserve3;
   FFreq       := string(src.Freq);
   FQsyViolation := src.QsyViolation;
   FPCName     := string(src.PCName);
   FForced     := src.Forced;
   FQslState   := TQslState(src.QslState);
   FInvalid    := src.Invalid;
   FRbnVerified := src.RbnVerified;
end;

{ TQSOList }

constructor TQSOList.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
   FCallsignComparer := TQSOCallsignComparer.Create();
   FTimeComparer := TQSOTimeComparer.Create();
   FBandComparer := TQSOBandComparer.Create();
   FModeComparer := TQSOModeComparer.Create();
   FPowerComparer := TQSOPowerComparer.Create();
   FTxNoComparer := TQSOTxNoComparer.Create();
   FPointComparer := TQSOPointComparer.Create();
   FOperatorComparer := TQSOOperatorComparer.Create();
   FMemoComparer := TQSOMemoComparer.Create();
   FDupeWithoutModeComparer := TQSODupeWithoutModeComparer.Create();
   FDupeWithModeComparer := TQSODupeWithModeComparer.Create();
   FDupeWithMode2Comparer := TQSODupeWithMode2Comparer.Create();
end;

destructor TQSOList.Destroy();
begin
   Inherited;
   FCallsignComparer.Free();
   FTimeComparer.Free();
   FBandComparer.Free();
   FModeComparer.Free();
   FPowerComparer.Free();
   FTxNoComparer.Free();
   FPointComparer.Free();
   FOperatorComparer.Free();;
   FMemoComparer.Free();
   FDupeWithoutModeComparer.Free();
   FDupeWithModeComparer.Free();
   FDupeWithMode2Comparer.Free();
end;

function TQSOList.IndexOf(C: string): Integer;
var
   i: Integer;
begin
   for i := 1 to Count - 1 do begin
      if Items[i].CallSign = C then begin
         Result := i;
         Exit;
      end;
   end;

   Result := -1;
end;

function TQSOList.IndexOf(Q: TQSO): Integer;
var
   i: Integer;
begin
   for i := 1 to Count - 1 do begin
      if Items[i].SameQSOID(Q) then begin
         Result := i;
         Exit;
      end;
   end;

   Result := -1;
end;

function TQSOList.MergeFile(filename: string; fFullMatch: Boolean): Integer;
var
   qso: TQSO;
   dat: TQSOData;
   f: file of TQSOData;
   i, merged: integer;
   Index: Integer;
begin
   merged := 0;

   if UpperCase(ExtractFileExt(filename)) = '.ZLOX' then begin
      Result := MergeFileEx(filename, fFullMatch);
      Exit;
   end;

   AssignFile(f, filename);
   Reset(f);
   Read(f, dat); // first qso comment

   for i := 1 to FileSize(f) - 1 do begin
      Read(f, dat);

      qso := TQSO.Create;
      qso.FileRecord := dat;

      if fFullMatch = True then begin
         Index := IndexOf(qso);
      end
      else begin
         Index := IndexOf(qso.Callsign);
      end;

      if Index = -1 then begin
         Add(qso);
         Inc(merged);
      end
      else begin
         qso.Free();
      end;
   end;

   CloseFile(f);
   Result := merged;
end;

function TQSOList.MergeFileEx(filename: string; fFullMatch: Boolean): Integer;
var
   qso: TQSO;
   dat: TQSODataEx;
   f: file of TQSODataEx;
   i, merged: integer;
   Index: Integer;
begin
   merged := 0;

   AssignFile(f, filename);
   Reset(f);
   Read(f, dat); // first qso comment

   for i := 1 to FileSize(f) - 1 do begin
      Read(f, dat);

      qso := TQSO.Create;
      qso.FileRecordEx := dat;

      if fFullMatch = True then begin
         Index := IndexOf(qso);
      end
      else begin
         Index := IndexOf(qso.Callsign);
      end;

      if Index = -1 then begin
         Add(qso);
         Inc(merged);
      end
      else begin
         qso.Free();
      end;
   end;

   CloseFile(f);
   Result := merged;
end;

procedure TQSOList.Sort(SortMethod: TSortMethod; fWithMode: Boolean; fAllPhone: Boolean);
var
   i: Integer;
begin
   for i := 0 to Count - 1 do begin
      Items[i].Index := i;
   end;

   case SortMethod of
      soCallsign: begin
         Sort(FCallsignComparer);
      end;

      soTime: begin
         Sort(FTimeComparer);
      end;

      soBand: begin
         Sort(FBandComparer);
      end;

      soMode: begin
         Sort(FModeComparer);
      end;

      soPower: begin
         Sort(FPowerComparer);
      end;

      soTxNo: begin
         Sort(FTxNoComparer);
      end;

      soPoint: begin
         Sort(FPointComparer);
      end;

      soOperator: begin
         Sort(FOperatorComparer);
      end;

      soMemo: begin
         Sort(FMemoComparer);
      end;

      soDupeCheck: begin
         if fWithMode = True then begin
            if fAllPhone = True then begin
               Sort(FDupeWithMode2Comparer);
            end
            else begin
               Sort(FDupeWithModeComparer);
            end;
         end
         else begin
            Sort(FDupeWithoutModeComparer);
         end;
      end;
   end;
end;

function TQSOList.DupeCheck(aQSO: TQSO; fWithMode: Boolean; fAllPhone: Boolean): TQSO;
var
   Index: Integer;
   Q: TQSO;
   C: TComparer<TQSO>;
begin
   Q := TQSO.Create();
   try
      Q.Assign(aQSO);
      Q.Callsign := CoreCall(Q.Callsign);

      if fWithMode = True then begin
         if fAllPhone = True then begin
            C := FDupeWithMode2Comparer;
         end
         else begin
            C := FDupeWithModeComparer;
         end;
      end
      else begin
         C := FDupeWithoutModeComparer;
      end;

      if BinarySearch(Q, Index, C) = True then begin
         Result := Items[Index];
      end
      else begin
         Result := nil;
      end;
   finally
      Q.Free();
   end;
end;

{ TLog }

constructor TLog.Create(Memo: string);
var
   Q: TQSO;
   B: TBand;
   i: Integer;
begin
   Inherited Create();

   // ADIF_FieldName := 'qth';

   FQsoList := TQSOList.Create();
   FQueList := TQSOList.Create();

   for B := b19 to HiBand do begin
      FDupeCheckList[B] := TQSOList.Create();
      FBandList[B] := TQSOList.Create(False);
   end;

   for i := Low(FTxList) to High(FTxList) do begin
      FTxList[i] := TQSOList.Create(False);
   end;

   Q := TQSO.Create;
   Q.Callsign := '';
   Q.Memo := Memo;
   Q.Time := 0;
   Q.RSTSent := 0;
   Q.RSTRcvd := 100;
   FQsoList.Add(Q);

   for B := b19 to HiBand do begin
      FBandList[B].Add(Q);
   end;

   for i := Low(FTxList) to High(FTxList) do begin
      FTxList[i].Add(Q);
   end;

   FSaved := True;
   FQueOK := True;
   FAcceptDifferentMode := False;
   FCountHigherPoints := False;
   FDifferentModePointer := 0;
   FAllPhone := True;
   FQsoIdDic := TDictionary<Integer, TQSO>.Create(120000);
   FStartTime := 0;
end;

destructor TLog.Destroy;
var
   B: TBand;
   i: Integer;
begin
   for B := b19 to HiBand do begin
      FDupeCheckList[B].Free();
      FBandList[B].Free();
   end;

   for i := Low(FTxList) to High(FTxList) do begin
      FTxList[i].Free();
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('QsoList=' + IntToStr(FQsoList.Count)));
   {$ENDIF}

   FQsoList.Free();
   FQueList.Free();
   FQsoIdDic.Free();

   Inherited;
end;

function TLog.ContainBand: TBandBool;
var
   R: TBandBool;
   B: TBand;
   i: Integer;
begin
   for B := b19 to HiBand do begin
      R[B] := False;
   end;

   for i := 1 to TotalQSO do begin
      R[FQSOList[i].FBand] := True;
   end;

   Result := R;
end;

function TLog.Year: Integer;
var
   T: TDateTime;
   y, M, d: word;
begin
   Result := 0;
   if TotalQSO > 0 then
      T := FQSOList[1].FTime
   else
      exit;

   DecodeDate(T, y, M, d);
   Result := y;
end;

procedure TLog.SortBy(SortMethod: TSortMethod);
var
   Q: TQSO;
begin
   if TotalQSO < 2 then begin
      exit;
   end;

   Q := FQSOList[0];
   FQSOList.Extract(Q);
   FQSOList.Sort(SortMethod, FAcceptDifferentMode, FAllPhone);
   FQSOList.Insert(0, Q);

   FSaved := False;
end;

procedure TLog.SortByTime();
var
   Q: TQSO;
begin
   if TotalQSO < 2 then begin
      exit;
   end;

   Q := FQSOList[0];
   FQSOList.Extract(Q);
   FQSOList.Sort(soTime, FAcceptDifferentMode, FAllPhone);
   FQSOList.Insert(0, Q);

   FSaved := False;
end;

procedure TLog.SortByTxNoBandTime();
var
   Q: TQSO;
begin
   if TotalQSO < 2 then begin
      exit;
   end;

   Q := FQSOList[0];
   FQSOList.Extract(Q);
   FQSOList.Sort(soTxNoBandTime, FAcceptDifferentMode, FAllPhone);
   FQSOList.Insert(0, Q);

   FSaved := False;
end;

procedure TLog.SortByTxNoTime();
var
   Q: TQSO;
begin
   if TotalQSO < 2 then begin
      exit;
   end;

   Q := FQSOList[0];
   FQSOList.Extract(Q);
   FQSOList.Sort(soTxNoTime, FAcceptDifferentMode, FAllPhone);
   FQSOList.Insert(0, Q);

   FSaved := False;
end;

procedure TLog.Clear2();
var
   i: Integer;
begin
   For i := FQSOList.Count - 1 downto 1 do begin
      Delete(i);
   end;

   ClearDupeCheckList;
   FQsoIdDic.Clear();
   FSaved := False;
end;

procedure TLog.ClearDupeCheckList;
var
   B: TBand;
begin
   for B := b19 to HiBand do begin
      FDupeCheckList[B].Clear;
   end;
end;

procedure TLog.Add(aQSO: TQSO; fNoSort: Boolean);
var
   xQSO: TQSO;
   b: TBand;
begin
   FQsoList.Add(aQSO);

   xQSO := TQSO.Create;
   xQSO.Assign(aQSO);
   b := xQSO.Band;

   FDupeCheckList[b].Add(xQSO);
   if fNoSort = False then begin
      FDupeCheckList[b].Sort(soDupeCheck, FAcceptDifferentMode, FAllPhone);
   end;

   FBandList[b].Add(aQSO);
   FTxList[xQSO.TX].Add(aQSO);

   if FQsoIdDic.ContainsKey(xQSO.QsoId) = False then begin
      FQsoIdDic.Add(xQSO.QsoId, xQSO);
   end;

   FSaved := False;

   zyloLogUpdated(evInsertQSO, nil, aQSO);
end;

procedure TLog.AddQue(aQSO: TQSO);
var
   xQSO: TQSO;
begin
   xQSO := TQSO.Create;
   xQSO.Assign(aQSO);
   // xQSO.QSO.Reserve := actAdd;
   FQueList.Add(xQSO);
   FSaved := False;
end;

procedure TLog.ProcessQue;
var
   xQSO: TQSO;
begin
   if FQueList.Count = 0 then begin
      exit;
   end;

   Repeat
   until FQueOK;

   while FQueList.Count > 0 do begin

      xQSO := TQSO.Create();
      xQSO.Assign(FQueList[0]);

      case xQSO.FReserve of
         actAdd: begin
            Add(xQSO);
         end;

         actDelete: begin
            ProcessDelete(xQSO);
         end;

         actEdit: begin
            ProcessEdit(xQSO, False);
         end;

         actInsert: begin
            ProcessInsert(xQSO);
            xQSO.Free();
         end;

         actLock: begin
            ProcessLock(xQSO);
         end;

         actUnlock: begin
            ProcessUnlock(xQSO);
         end;

         actEditOrAdd: begin
            ProcessEdit(xQSO, True);
         end;
      end;

      FQueList.Delete(0);
   end;

   FSaved := False;
end;

procedure TLog.ProcessDelete(beforeQSO: TQSO);
var
   i: Integer;
   wQSO: TQSO;
begin
   for i := 1 to TotalQSO do begin
      wQSO := FQsoList[i];
      if beforeQSO.SameQSOID(wQSO) then begin
         Delete(i);
         Break;
      end;
   end;
end;

procedure TLog.ProcessEdit(afterQSO: TQSO; fAdd: Boolean);
var
   i: Integer;
   beforeQSO: TQSO;
   wQSO: TQSO;
begin
   beforeQSO := TQSO.Create();
   try
      for i := 1 to TotalQSO do begin
         wQSO := FQsoList[i];
         if afterQSO.SameQSOID(wQSO) then begin
            beforeQSO.Assign(wQSO);
            wQSO.Assign(afterQSO);  // wQSO = FQsoList[i]
            wQSO.FReserve := actEdit;
            RebuildDupeCheckList;
            zyloLogUpdated(evUpdateQSO, beforeQSO, afterQSO);
            afterQSO.Free();

   			{$IFDEF ZSERVER}
            if FQsoIdDic.ContainsKey(beforeQSO.QsoId) = True then begin
               FQsoIdDic.Remove(beforeQSO.QsoId);
            end;
            FQsoIdDic.Add(wQSO.QsoId, wQSO);
            {$ENDIF}
            Exit;
         end;
      end;

      if fAdd = True then begin
         afterQSO.FReserve := actAdd;
         Add(afterQSO);
      end;
   finally
      beforeQSO.Free();
   end;
end;

procedure TLog.ProcessInsert(afterQSO: TQSO);
var
   i: Integer;
   id: Integer;
   wQSO: TQSO;
   newQSO: TQSO;
begin
   for i := 1 to TotalQSO do begin
      wQSO := FQsoList[i];
      id := afterQSO.FReserve2 div 100;
      if id = (wQSO.FReserve3 div 100) then begin
         newQSO := TQSO.Create;
         newQSO.Assign(afterQSO);
         Insert(i, newQSO);
         Break;
      end;
   end;
end;

procedure TLog.ProcessLock(xQSO: TQSO);
var
   i: Integer;
   wQSO: TQSO;
begin
   for i := 1 to TotalQSO do begin
      wQSO := FQsoList[i];
      if xQSO.SameQSOID(wQSO) then begin
         wQSO.FReserve := actLock;
         Break;
      end;
   end;
end;

procedure TLog.ProcessUnlock(xQSO: TQSO);
var
   i: Integer;
   wQSO: TQSO;
begin
   for i := 1 to TotalQSO do begin
      wQSO := FQsoList[i];
      if xQSO.SameQSOID(wQSO) then begin
         wQSO.FReserve := 0;
         Break;
      end;
   end;
end;

procedure TLog.Delete(i: Integer);
var
   aQSO: TQSO;
   Index: Integer;
begin
   if i > TotalQSO then begin
      Exit;
   end;

   aQSO := FQsoList[i];
   zyloLogUpdated(evDeleteQSO, aQSO, nil);

   Index := FBandList[aQSO.Band].IndexOf(aQSO);
   if Index > -1 then begin
      FBandList[aQSO.Band].Delete(Index);
   end;

   Index := FTxList[aQSO.TX].IndexOf(aQSO);
   if Index > -1 then begin
      FTxList[aQSO.TX].Delete(Index);
   end;

   FQsoList.Delete(i);

   FSaved := False;
   RebuildDupeCheckList;

   FQsoIdDic.Remove(aQSO.QsoId);
end;

procedure TLog.DeleteQSO(aQSO: TQSO);
var
   Index: Integer;
begin
   zyloLogUpdated(evDeleteQSO, aQSO, nil);

   Index := FBandList[aQSO.Band].IndexOf(aQSO);
   if Index > -1 then begin
      FBandList[aQSO.Band].Delete(Index);
   end;

   Index := FTxList[aQSO.TX].IndexOf(aQSO);
   if Index > -1 then begin
      FTxList[aQSO.TX].Delete(Index);
   end;

   Index := FQSOList.IndexOf(aQSO);
   if Index > -1 then begin
      FQsoList.Delete(Index);
   end;

   FQsoIdDic.Remove(aQSO.QsoId);

   FSaved := False;
   RebuildDupeCheckList;
end;

procedure TLog.RemoveDupes;
var
   i: Integer;
   aQSO: TQSO;
begin
   for i := 1 to TotalQSO do begin
      aQSO := FQsoList[i];
      if aQSO.Dupe = True then begin
         Delete(i);
      end;
   end;

   FSaved := False;
   RebuildDupeCheckList;
end;

function TLog.CheckQSOID(qsoid: Integer): Boolean;
var
   id: Integer;
begin
   id := qsoid div 100; // last two digits are edit counter
   Result := FQsoIdDic.ContainsKey(id);
end;

procedure TLog.Insert(i: Integer; aQSO: TQSO);
begin
   FQsoList.Insert(i, aQSO);
   RebuildDupeCheckList;
   FSaved := False;

   if FQsoIdDic.ContainsKey(aQSO.QsoId) = False then begin
      FQsoIdDic.Add(aQSO.QsoId, aQSO);
   end;

   zyloLogUpdated(evInsertQSO, nil, aQSO);
end;

procedure TLog.Backup(Filename: string);
var
   n: Integer;
   backname: string;
   backname2: string;
const
   backext: array[0..2] of string = ('.BAK', '.BK2', '.BK3' );
begin

   for n := High(backext) downto 0 do begin
      backname := ChangeFileExt(Filename, backext[n]);
      if FileExists(backname) = True then begin
         System.SysUtils.DeleteFile(backname);
      end;

      if n >= 1 then begin
         backname2 := ChangeFileExt(Filename, backext[n - 1]);
         if FileExists(backname2) = True then begin
            RenameFile(backname2, backname);
         end;
      end;
   end;

   // .ZLO ==> .BAK
   RenameFile(Filename, backname);
end;

procedure TLog.SaveToFile(Filename: string);
var
   D: TQSOData;
   f: file of TQSOData;
   i: Integer;
begin
   if UpperCase(ExtractFileExt(filename)) = '.ZLOX' then begin
      SaveToFileEx(filename);
      Exit;
   end;

   AssignFile(f, Filename);
   Rewrite(f);

   for i := 0 to TotalQSO do begin // changed from 1 to TotalQSO to 0 to TotalQSO
      D := FQsoList[i].FileRecord;

      if i = 0 then begin
         PDateTime(@D.Reserve2)^ := FStartTime;
      end;

      Write(f, D);
   end;

   CloseFile(f);

   FSaved := True;
end;

procedure TLog.SaveToFileEx(Filename: string);
var
   D: TQSODataEx;
   f: file of TQSODataEx;
   i: Integer;
begin
   AssignFile(f, Filename);
   Rewrite(f);

   for i := 0 to TotalQSO do begin // changed from 1 to TotalQSO to 0 to TotalQSO
      D := FQsoList[i].FileRecordEx;

      if i = 0 then begin
         D.Header.MagicNo[0] := Ord('Z');
         D.Header.MagicNo[1] := Ord('L');
         D.Header.MagicNo[2] := Ord('O');
         D.Header.MagicNo[3] := Ord('X');
         D.Header.NumRecords := TotalQSO;
         PDateTime(Pointer(@D.Reserve2))^ := FStartTime;
      end;

      Write(f, D);
   end;

   CloseFile(f);

   FSaved := True;
end;

procedure TLog.SaveToFileAszLogDOSTXT(Filename: string);
var
   f: textfile;
   i, j, max: Integer;
const
   LongHeader = 'mon day time  callsign      sent                              rcvd                           multi   MHz mode pts memo';
   ShortHeader = 'mon day time  callsign      sent         rcvd      multi   MHz mode pts memo';
begin
   AssignFile(f, Filename);
   Rewrite(f);

   { str := 'zLog for Windows Text File'; }
   max := 0;
   j := 0;
   for i := 1 to TotalQSO do begin
      j := length(FQsoList[i].FNrRcvd);
      if j > max then begin
         max := j;
      end;

      j := length(FQsoList[i].FNrSent);
      if j > max then begin
         max := j;
      end;
   end;

   if j >= 10 then begin
      writeln(f, LongHeader);
      for i := 1 to TotalQSO do begin
         writeln(f, FQsoList[i].DOSzLogText);
      end;
   end
   else begin
      writeln(f, ShortHeader);
      for i := 1 to TotalQSO do begin
         writeln(f, FQsoList[i].DOSzLogTextShort);
      end;
   end;

   CloseFile(f);
end;

{$IFNDEF ZSERVER}
procedure TLog.SaveToFileAszLogALL(Filename: string);
var
   f: textfile;
   Header: string;
   i: Integer;
begin
   Header := 'zLog for Windows '; // +Options.Settings._mycall;
   AssignFile(f, Filename);
   Rewrite(f);

   { str := 'zLog for Windows Text File'; }
   writeln(f, Header);

   for i := 1 to TotalQSO do begin
      writeln(f, FQsoList[i].zLogALL);
   end;

   CloseFile(f);
end;
{$ENDIF}

procedure TLog.SaveToFileAszLogCsv(Filename: string);
const
   csvheader = '"Date","Time","TimeZone","CallSign","RSTSent","NrSent","RSTRcvd","NrRcvd","Serial","Mode",' +
               '"Band","Power","Multi1","Multi2","NewMulti1","NewMulti2","Points","Operator","Memo","CQ",' +
               '"Dupe","Reserve","TX","Power2","Reserve2","Reserve3","Freq","QsyViolation","PCName","Forced","QslState","Invalid","Area","RBN Verified"';
var
   i: Integer;
   strText: string;
   Q: TQSO;
   offsetmin: Integer;
   slCsv: TStringList;
   slFile: TStringList;
begin
   slCsv := TStringList.Create();
   slCsv.StrictDelimiter := True;
   slCsv.QuoteChar := #0;
   slFile := TStringList.Create();
   slFile.StrictDelimiter := True;
   try
      offsetmin := FQsoList[0].RSTsent;

      // CSVヘッダー
      slFile.Add(csvheader);

      for i := 1 to FQSOList.Count - 1 do begin
         Q := FQSOList[i];

         slCsv.Clear();

         // 1列目　交信年月日（YY/MM/DD）
         slCsv.Add(FormatDateTime('yyyy/mm/dd', Q.Time));

         // 2列目　交信時分（HH:MM）
         slCsv.Add(FormatDateTime('HH:MM:SS', Q.Time));

         // 3列目 TimeZone
         if offsetmin = _USEUTC then begin
            strText := 'UTC';
         end
         else begin
            strText := 'JST';
         end;
         slCsv.Add(strText);

         // 4列目 コールサイン
         slCsv.Add2(Q.Callsign);

         // 5列目 相手局へ送ったRST
         slCsv.Add2(Q.RSTSentStr);

         // 6列目 相手局へ送ったNumber
         slCsv.Add2(Q.NrSent);

         // 7列目 相手局からもらったレポート
         slCsv.Add2(Q.RSTRcvdStr);

         // 8列目 相手局へ送ったNumber
         slCsv.Add2(Q.NrRcvd);

         // 9列目 シリアルNO
         slCsv.Add(Q.SerialStr);

         // 10列目 Mode
         slCsv.Add2(Q.ModeStr);

         // 11列目 Band
         slCsv.Add2(Q.BandStr);

         // 1列目 Power
         slCsv.Add2(Q.NewPowerStr);

         // 13列目 マルチ１
         slCsv.Add2(Q.Multi1);

         // 14列目 マルチ１
         slCsv.Add2(Q.Multi2);

         // 15列目 Newマルチ１
         slCsv.Add(BoolToStr(Q.NewMulti1, True));

         // 16列目 Newマルチ２
         slCsv.Add(BoolToStr(Q.NewMulti2, True));

         // 17列目 Points
         slCsv.Add(IntToStr(Q.Points));

         // 18列目 Operator
         slCsv.Add2(Q.Operator);

         // 19列目 memo
         slCsv.Add2(Q.Memo);

         // 20列目 CQ
         slCsv.Add(BoolToStr(Q.CQ, True));

         // 21列目 Dupe
         slCsv.Add(BoolToStr(Q.Dupe, True));

         // 22列目 Reserve
         slCsv.Add(IntToStr(Q.Reserve));

         // 23列目 Reserve
         slCsv.Add(IntToStr(Q.TX));

         // 24列目 Power2
         slCsv.Add(IntToStr(Q.Power2));

         // 25列目 Reserve2
         slCsv.Add(IntToStr(Q.Reserve2));

         // 26列目 Reserve3
         slCsv.Add(IntToStr(Q.Reserve3));

         // 27列目 Freq
         slCsv.Add2(Q.Freq);

         // 28列目 QsyViolation
         slCsv.Add(BoolToStr(Q.QsyViolation, True));

         // 29列目 PCName
         slCsv.Add2(Q.PCName);

         // 30列目 Forced
         slCsv.Add(BoolToStr(Q.Forced, True));

         // 31列目 QslState
         slCsv.Add(IntToStr(Integer(Q.QslState)));

         // 32列目 Invalid
         slCsv.Add(BoolToStr(Q.Invalid, True));

         // 33列目 Area
         slCsv.Add(Q.Area);

         // 34列目 RBN Verified
         slCsv.Add(BoolToStr(Q.RbnVerified, True));

         slFile.Add(slCsv.DelimitedText);
      end;

      slFile.WriteBOM := True;
      slFile.SaveToFile(Filename, TEncoding.UTF8);
   finally
      slCsv.Free();
      slFile.Free();
   end;
end;

{$IFNDEF ZSERVER}
procedure TLog.SaveToFileAsTxtByTX(Filename: string);
var
   f: textfile;
   Header: string;
   i, j: Integer;
   txset: set of byte;
begin
   txset := [];
   for i := 1 to TotalQSO do begin
      txset := txset + [FQsoList[i].FTX];
   end;

   Header := 'zLog for Windows '; // +Options.Settings._mycall;
   System.Delete(Filename, length(Filename) - 2, 3);
   for i := 0 to 255 do begin
      if i in txset then begin
         AssignFile(f, Filename + '.' + IntToStr(i) + '.TX');
         Rewrite(f);
         writeln(f, Header + ' TX# ' + IntToStr(i));
         for j := 1 to TotalQSO do
            if FQsoList[j].FTX = i then
               writeln(f, FQsoList[j].zLogALL);
         CloseFile(f);
      end;
   end;
end;
{$ENDIF}

function TLog.GetActualFreq(b: TBand; strFreq: string): string;
var
   p: Integer;
   s: string;
   f: TFrequency;
   b2: TBand;
begin
   {$IFNDEF ZSERVER}
   // FreqがBandと一致しない場合はBandからActualを求める
   f := Trunc(StrToFloatDef(strFreq, 0)) * 1000;
   b2 := dmZLogGlobal.BandPlan.FreqToBand(f);
   if (f = 0) or (b <> b2) or (b > b28) then begin
      Result := CabrilloBandString[b];
      Exit;
   end;

   if strFreq = '' then begin
      Result := CabrilloBandString[b];
      Exit;
   end;
   {$ENDIF}

   s := strFreq;

   p := Pos('.', s);
   if p = 0 then begin
      Result := RightStr('     ' + s, 5);
      Exit;
   end;

   s := Copy(s, 1, p - 1);
   Result := RightStr('     ' + s, 5);
end;

function TLog.GetEndTime(): TDateTime;
var
   dtNow: TDateTime;
begin
   if FPeriod = 0 then begin
      {$IFNDEF ZSERVER}
      if MyContest.UseUTC = True then begin
         dtNow := GetUTC();
      end
      else begin
         dtNow := Now;
      end;
      {$ELSE}
      dtNow := Now;
      {$ENDIF}

      if (FStartTime <= dtNow) then begin
         Result := dtNow;
      end
      else begin
         Result := FStartTime;
      end;
   end
   else begin
      Result := FEndTime;
   end;
end;

procedure TLog.SetPeriod(v: Integer);
begin
   FPeriod := v;
   FEndTime := IncHour(FStartTime, FPeriod);
end;

{$IFNDEF ZSERVER}

function TLog.GetLastCallsign(): string;
var
   txnr, i: Integer;
begin
   txnr := dmZLogGlobal.Settings._txnr;

   for i := Log.TotalQSO downto 1 do begin
      if Log.QsoList[i].TX = txnr then begin
         Result := Log.QsoList[i].Callsign;
         Exit;
      end;
   end;

   Result := '';
end;

function TLog.GetLastNumber(): string;
var
   txnr, i: Integer;
begin
   txnr := dmZLogGlobal.Settings._txnr;

   for i := Log.TotalQSO downto 1 do begin
      if Log.QsoList[i].TX = txnr then begin
         Result := Log.QsoList[i].NrSent;
         Exit;
      end;
   end;

   Result := '';
end;

function TLog.GetLastSerial(aQSO: TQSO): Integer;
var
   txnr, i: Integer;
   Q: TQSO;
begin
   txnr := dmZLogGlobal.Settings._txnr;

   case MyContest.SerialType of
      stNone: begin
         Result := 0;
         Exit;
      end;

      stAll: begin
         for i := Log.TotalQSO downto 1 do begin
            Q := Log.QsoList[i];
            if Q.TX = txnr then begin
               Result := Q.Serial;
               Exit;
            end;
         end;
      end;

      stBand: begin
         for i := Log.TotalQSO downto 1 do begin
            Q := Log.QsoList[i];
            if (Q.band = aQSO.Band) and (Q.TX = txnr) then begin
               Result := Q.Serial;
               Exit;
            end;
         end;
      end;

      stMultiSingle: begin
         for i := Log.TotalQSO downto 1 do begin
            Q := Log.QsoList[i];
            if (Q.TX = aQSO.TX) then begin
               Result := Q.Serial;
               Exit;
            end;
         end;
      end;
   end;

   Result := 0;
end;

function TLog.GetCurrentSerial(aQSO: TQSO): Integer;
var
   initno: Integer;
begin
   if Log.TotalQSO = 0 then begin
      if MyContest is TGeneralContest then begin
         initno := TGeneralContest(MyContest).Config.SerialArray[aQSO.Band];
      end
      else begin
         initno := 1;
      end;
      Result := initno;
      Exit;
   end;

   Result := GetLastSerial(aQSO) + 1;
end;

{$ENDIF}

// https://wwrof.org/cabrillo/
// https://wwrof.org/cabrillo/cabrillo-qso-data/
//                              --------info sent------- -------info rcvd--------
//QSO:  freq mo date       time call          rst exch   call          rst exch   t
//QSO: ***** ** yyyy-mm-dd nnnn ************* nnn ****** ************* nnn ****** n
//QSO:  3799 PH 1999-03-06 0711 HC8N           59 700    W1AW           59 CT     0
//QSO:  3799 PH 1999-03-06 0712 HC8N           59 700    N5KO           59 CA     0

{$IFNDEF ZSERVER}
procedure TLog.SaveToFileAsCabrillo(Filename: string; nTimeZoneOffset: Integer; slSummaryInfo: TStringList);
var
   F: TextFile;
   i: Integer;
   strText: string;
   Q: TQSO;
   utc: TDateTime;
   offhour: Integer;
   offsetmin: Integer;

   function FillRight(S: string; len: integer): string;
   var
      sjis: AnsiString;
      len2: Integer;
   begin
      sjis := AnsiString(S);
      len2 := Length(sjis);
      if len2 < len then begin
         sjis := sjis + AnsiString(DupeString(' ', len));
         sjis := Copy(sjis, 1, len);
      end;
      Result := String(sjis);
   end;

   function FillLeft(S: string; len: integer): string;
   var
      sjis: AnsiString;
      len2: Integer;
   begin
      sjis := AnsiString(S);
      len2 := Length(sjis);
      if len2 < len then begin
         sjis := AnsiString(DupeString(' ', len)) + sjis;
         sjis := Copy(sjis, Length(sjis) - len + 1, len);
      end;
      Result := String(sjis);
   end;
begin
   AssignFile(F, Filename);
   ReWrite(F);

   WriteLn(F, 'START-OF-LOG: 3.0');

   if slSummaryInfo = nil then begin
      WriteLn(F, 'CALLSIGN: ' + dmZLogGlobal.MyCall);
      WriteLn(F, 'CONTEST: ');
      WriteLn(F, 'CATEGORY-ASSISTED: ');
      WriteLn(F, 'CATEGORY-BAND: ');
      WriteLn(F, 'CATEGORY-MODE: ');
      WriteLn(F, 'CATEGORY-OPERATOR: ');
      WriteLn(F, 'CATEGORY-POWER: ');
      WriteLn(F, 'CATEGORY-STATION: ');
      WriteLn(F, 'CATEGORY-TIME: ');
      WriteLn(F, 'CATEGORY-TRANSMITTER: ');
      WriteLn(F, 'CATEGORY-OVERLAY: ');
      WriteLn(F, 'CERTIFICATE: ');
      WriteLn(F, 'CLAIMED-SCORE: ');
      WriteLn(F, 'CLUB: ');
      WriteLn(F, 'CREATED-BY: ');
      WriteLn(F, 'EMAIL: ');
      WriteLn(F, 'GRID-LOCATOR: ');
      WriteLn(F, 'LOCATION: ');
      WriteLn(F, 'NAME: ');
      WriteLn(F, 'ADDRESS: ');
      WriteLn(F, 'ADDRESS-CITY: ');
      WriteLn(F, 'ADDRESS-STATE-PROVINCE: ');
      WriteLn(F, 'ADDRESS-POSTALCODE: ');
      WriteLn(F, 'ADDRESS-COUNTRY: ');
      WriteLn(F, 'OPERATORS: ');
      WriteLn(F, 'OFFTIME: ');
      WriteLn(F, 'SOAPBOX: ');
   end
   else begin
      for i := 0 to slSummaryInfo.Count - 1 do begin
         WriteLn(F, slSummaryInfo.Strings[i]);
      end;
   end;

   offsetmin := FQsoList[0].RSTsent;
   if offsetmin = _USEUTC then begin
      offhour := 0;
   end
   else begin
      offhour := offsetmin div 60;
   end;

   for i := 1 to FQSOList.Count - 1 do begin
      Q := FQSOList[i];

      if (dmZLogGlobal.Settings._output_outofperiod = False) and
         (IsOutOfPeriod(Q) = True) then begin
         Continue;
      end;

      if Q.Invalid = True then begin
         strText := 'X-QSO: ';
      end
      else begin
         strText := 'QSO: ';
      end;

      strText := strText  + GetActualFreq(Q.Band, Q.Freq) + ' ';
      strText := strText + CabrilloModeString[Q.Mode] + ' ';

      // いったんUTCに統一
      utc := IncHour(Q.Time, offhour);

      // さらに指定のoffsetを足して指定のtime zoneへ
      utc := IncHour(utc, nTimeZoneOffset);

      strText := strText + FormatDateTime('yyyy-mm-dd', utc) + ' ';
      strText := strText + FormatDateTime('hhmm', utc) + ' ';

      strText := strText + FillRight(dmZLogGlobal.MyCall, 13) + ' ';
      strText := strText + FillLeft(IntToStr(Q.RSTSent), 3) + ' ';
      strText := strText + FillRight(Q.NrSent, 6) + ' ';

      strText := strText + FillRight(Q.Callsign, 13) + ' ';
      strText := strText + FillLeft(IntToStr(Q.RSTRcvd), 3) + ' ';
      strText := strText + FillRight(Q.NrRcvd, 6) + ' ';

      // M/S, M/2のみTXNOを出力、それ以外は0固定
      if (dmZLogGlobal.ContestCategory in [ccMultiOpSingleTx, ccMultiOpTwoTx]) then begin
         strText := strText + IntToStr(Q.TX);
      end
      else begin
         strText := strText + '0';
      end;

      WriteLn(F, strText);
   end;

   WriteLn(F, 'END-OF-LOG:');

   CloseFile(F);
end;
{$ENDIF}

{
HAMLOG CSV仕様

1列目　コールサイン
2列目　交信年月日（YY/MM/DD）　※「YYYY/MM/DD」でもOKだった記憶
3列目　交信時分（HH:MM*）　※「*」にはJST…J・UTC…U
4列目　相手局へ送ったレポート
5列目　相手局からもらったレポート
6列目　周波数
7列目　電波型式
8列目　相手局の運用地コード
9列目　相手局の運用地グリッドロケータ
10列目　QSLマーク　※取りあえず「J」を入れておけばOK
11列目　相手局の名前・名称
12列目　相手局の運用地
13列目　Remarks1
14列目　Remarks2
15列目　なんかの識別子

15列目の識別子：
　基本的に国内局…0・海外局…8
　でもそれ以外の場合もある
}
{$IFNDEF ZSERVER}
procedure TLog.SaveToFileAsHamlog(Filename: string; nRemarks1Option: Integer; nRemarks2Option: Integer;
                                 strRemarks1: string; strRemarks2: string;
                                 nCodeOption: Integer; nNameOption: Integer;
                                 nTimeOption: Integer;
                                 strQslStateText: string;
                                 nFreqOption: Integer);
var
   F: TextFile;
   i: Integer;
   strText: string;
   Q: TQSO;
   offsetmin: Integer;
   slCsv: TStringList;
   strQslState: array[qsNone..qsNoQsl] of string;
   strMulti: string;
   newoffsetmin: Integer;
   qsotime: TDateTime;
   offsethour: Integer;
   S: string;

   {
   $URCALL 相手コールサイン
   $MYCALL 自分のコールサイン
   $RSTSENT 送ったRST
   $RSTRECV もらったRST
   $NRSENT  送ったNR
   $NRRECV  もらったNR
   $MEMO Memo欄の内容
   $CTNAME コンテスト名
   $DATE 交信日付(yyyy/mm/dd)
   $TIME 交信時刻(HH:MM)
   $FREQ 71000.0形式
   $BANDF 周波数形式 7M
   $BANDW 波長形式 40m
   $MODE SSB/CW
   $QSL  " JN"のどれか
   $OP   OP名

   $URCALL  Ur callsign
   $MYCALL  My callsign
   $RSTSENT Sent RST
   $RSTRECV Recieved RST
   $NRSENT  Sent NR
   $NRRECV  Recieved NR
   $MEMO    Contents of Memo
   $CTNAME  Contest name
   $DATE    QSO date(ex. yyyy/mm/dd)
   $TIME    QSO time(ex. HH:MM)
   $FREQ    Frequency(ex. 71000.0)
   $BANDF   Band by frequency(ex. 7M)
   $BANDW   Band by wavelength(ex. 40m)
   $MODE    Mode(ex. SSB)
   $QSL     Mark of QSL state
   $OP      Operator name
   }
   function ReplaceHamlogKeyword(Q: TQSO; S: string): string;
   begin
      S := StringReplace(S, '$URCALL',  Q.Callsign, [rfReplaceALL]);
      S := StringReplace(S, '$MYCALL',  dmZLogGlobal.MyCall, [rfReplaceALL]);
      S := StringReplace(S, '$RSTSENT', Q.RSTSentStr, [rfReplaceALL]);
      S := StringReplace(S, '$RSTRECV', Q.RSTRcvdStr, [rfReplaceALL]);
      S := StringReplace(S, '$NRSENT',  Q.NrSent, [rfReplaceALL]);
      S := StringReplace(S, '$NRRECV',  Q.NrRcvd, [rfReplaceALL]);
      S := StringReplace(S, '$MEMO',    Q.Memo, [rfReplaceALL]);
      S := StringReplace(S, '$CTNAME',  MyContest.Name, [rfReplaceALL]);
      S := StringReplace(S, '$DATE',    FormatDateTime('yyyy/mm/dd', qsotime), [rfReplaceALL]);
      S := StringReplace(S, '$TIME',    FormatDateTime('HH:MM', qsotime), [rfReplaceALL]);
      S := StringReplace(S, '$FREQ',    Q.FreqStr, [rfReplaceALL]);
      S := StringReplace(S, '$BANDF',   Q.BandStr, [rfReplaceALL]);
      S := StringReplace(S, '$BANDW',   Q.BandStr2, [rfReplaceALL]);
      S := StringReplace(S, '$MODE',    Q.ModeStr, [rfReplaceALL]);
      S := StringReplace(S, '$QSL',     strQslState[Q.QslState], [rfReplaceALL]);
      S := StringReplace(S, '$OP',      Q.Operator, [rfReplaceALL]);
      S := StringReplace(S, ',',        '_', [rfReplaceALL]);
      S := StringReplace(S, '"',        '\"', [rfReplaceALL]);
      Result := S;
   end;
begin
   strQslState[qsNone]   := Copy(strQslStateText, 1, 1);
   strQslState[qsPseQsl] := Copy(strQslStateText, 2, 1);
   strQslState[qsNoQsl]  := Copy(strQslStateText, 3, 1);

   slCsv := TStringList.Create();
   slCsv.StrictDelimiter := True;
   try
      AssignFile(F, Filename);
      ReWrite(F);

      offsetmin := FQsoList[0].RSTsent;
      if offsetmin = _USEUTC then begin
         offsethour := 0;
      end
      else begin
         offsethour := offsetmin div 60;
      end;

      for i := 1 to FQSOList.Count - 1 do begin
         Q := FQSOList[i];

         strMulti := MyContest.MultiForm.ExtractMulti(Q);

         qsotime := Q.Time;
         case nTimeOption of
            // そのまま出力
            0: begin
               newoffsetmin := offsetmin;
            end;

            // JST統一
            1: begin
               if offsetmin = _USEUTC then begin
                  qsotime := IncHour(qsotime, offsethour);
               end;
               newoffsetmin := offsetmin;
            end;

            // UTC統一
            2: begin
               if offsetmin <> _USEUTC then begin
                  qsotime := IncHour(qsotime, offsethour);
               end;
               newoffsetmin := _USEUTC;
            end;

            else begin
               newoffsetmin := offsetmin;
            end;
         end;

         slCsv.Clear();

         //1列目　コールサイン
         slCsv.Add(Q.Callsign);

         //2列目　交信年月日（YY/MM/DD）　※「YYYY/MM/DD」でもOKだった記憶
         slCsv.Add(FormatDateTime('yyyy/mm/dd', qsotime));

         //3列目　交信時分（HH:MM*）　※「*」にはJST…J・UTC…U
         strText := FormatDateTime('HH:MM', qsotime);
         if newoffsetmin = _USEUTC then begin
            strText := strText + 'U';
         end
         else begin
            strText := strText + 'J';
         end;
         slCsv.Add(strText);

         //4列目　相手局へ送ったレポート
         slCsv.Add(Q.RSTSentStr);

         //5列目　相手局からもらったレポート
         slCsv.Add(Q.RSTRcvdStr);

         //6列目　周波数orバンド/バンド
         if nFreqOption = 0 then begin
            strText := Q.FreqStr2;
            if strText = '' then begin
               strText := Q.BandStr;
            end;
         end
         else begin
            strText := Q.BandStr;
         end;
         slCsv.Add(strText);

         //7列目　電波型式
         slCsv.Add(Q.ModeStr);

         //8列目　相手局の運用地コード
         case nCodeOption of
            1: slCsv.Add(strMulti);
            2: slCsv.Add(Q.NrRcvd);
            else slCsv.Add('');
         end;

         //9列目　相手局の運用地グリッドロケータ
         slCsv.Add('');

         //10列目　QSLマーク　※取りあえず「J」を入れておけばOK
         slCsv.Add(strQslState[Q.QslState] + '  ');

         //11列目　相手局の名前・名称
         if nNameOption = 1 then begin
            slCsv.Add(strMulti);
         end
         else begin
            slCsv.Add('');
         end;

         //12列目　相手局の運用地
         slCsv.Add('');

         //13列目　Remarks1
         case nRemarks1Option of
            1: begin
               S := ReplaceHamlogKeyword(Q, strRemarks1);
               slCsv.Add(S);
            end;

            2: begin
               slCsv.Add(Q.Operator);
            end;

            3: begin
               slCsv.Add(Q.Memo);
            end;

            else begin
               slCsv.Add('');
            end;
         end;

         //14列目　Remarks2
         case nRemarks2Option of
            1: begin
               S := ReplaceHamlogKeyword(Q, strRemarks2);
               slCsv.Add(S);
            end;

            2: begin
               slCsv.Add(Q.Operator);
            end;

            3: begin
               slCsv.Add(Q.Memo);
            end;

            else begin
               slCsv.Add('');
            end;
         end;

         //15列目　なんかの識別子
         //zlistではUTCだと8、JSTは0
         if IsDomestic(Q.Callsign) = True then begin
            strText := '0';
         end
         else begin
            strText := '8';
         end;
         slCsv.Add(strText);

         WriteLn(F, slCsv.CommaText);
      end;

      CloseFile(F);
   finally
      slCsv.Free();
   end;
end;
{$ENDIF}

{$IFNDEF ZSERVER}

// 1 Callsign
// 2 Portable
// 3 Time
// 4 Time End
// 5 RST Sent
// 6 RST Received
// 7 Who Called
// 8 Grid Zone
// 9 My Callsign
// 10 My QTH
// 11 Other QTH
// 12 Other Name
// 13 Band
// 14 Frequency
// 15 Mode
// 16 QSL Card
// 17 QSL Way
// 18 QSL Flag
// 19 Rig Model
// 20 Antenna
// 21 TXPower
// 22 Latitude
// 23 Longitude
// 24 JCC/JGC
// 25 Altitude above sea level
// 26 Weather
// 27 Other Information
// 28 QSL Comment
// 29 NR Sent
// 30 NR Received

procedure TLog.SaveToFileAsHamSupport(Filename: string);
var
   slLine: TStringList;
   slFile: TStringList;
   offsetmin: Integer;
   offsethour: Integer;
   i: Integer;
   Q: TQSO;
   strMulti: string;
   strTime: string;
   qsotime: TDateTime;
   strPortable: string;
   strCallsign: string;
   deg: Extended;
const
   strQslState: array[qsNone..qsNoQsl] of string = ( 'なし', 'BURO', 'なし' );
   strQslFlag: array[qsNone..qsNoQsl] of string = ( '', 'FALSE', '' );

   procedure SplitCallsign(strOriginal: string; var strCallsign: string; var strPortable: string);
   var
      strRight, strLeft: string;
      Index: Integer;
   begin
      Index := Pos('/', strOriginal);
      if Index = -1 then begin
         strCallsign := strOriginal;
         strPortable := '';
         Exit;
      end;

      strLeft := Copy(strOriginal, 1, Index - 1);
      strRight := Copy(strOriginal, Index + 1);

      if Length(strLeft) >= Length(strRight) then begin
         strCallsign := strLeft;
         strPortable := strRight;
      end
      else begin
         strCallsign := strRight;
         strPortable := strLeft;
      end;

      if (strPortable = '1') or
         (strPortable = '2') or
         (strPortable = '3') or
         (strPortable = '4') or
         (strPortable = '5') or
         (strPortable = '6') or
         (strPortable = '7') or
         (strPortable = '8') or
         (strPortable = '9') or
         (strPortable = '0') or
         (strPortable = 'P') or
         (strPortable = 'MM') or
         (strPortable = 'AM') or
         (strPortable = 'SAT') then begin
         // OK
         Exit;
      end
      else begin
         strCallsign := strOriginal;
         strPortable := '';
      end;
   end;
begin
   slLine := TStringList.Create();
   slLine.StrictDelimiter := True;
   slLine.QuoteChar := #0;
   slFile := TStringList.Create();
   slFile.StrictDelimiter := True;

   // CSVヘッダー
   slLine.Clear();
   slLine.Add2('Callsign');
   slLine.Add2('Portable');
   slLine.Add2('Time');
   slLine.Add2('Time End');
   slLine.Add2('RST Sent');
   slLine.Add2('RST Received');
   slLine.Add2('Who Called');
   slLine.Add2('Grid Zone');
   slLine.Add2('My Callsign');
   slLine.Add2('My QTH');
   slLine.Add2('Other QTH');
   slLine.Add2('Other Name');
   slLine.Add2('Band');
   slLine.Add2('Frequency');
   slLine.Add2('Mode');
   slLine.Add2('QSL Card');
   slLine.Add2('QSL Way');
   slLine.Add2('QSL Flag');
   slLine.Add2('Rig Model');
   slLine.Add2('Antenna');
   slLine.Add2('TXPower');
   slLine.Add2('Latitude');
   slLine.Add2('Longitude');
   slLine.Add2('JCC/JCG');
   slLine.Add2('Altitude above sea level');
   slLine.Add2('Weather');
   slLine.Add2('Other Information');
   slLine.Add2('QSL Comment');
   slLine.Add2('NR Sent');
   slLine.Add2('NR Received');
   slLine.Add2('Contest Name');
   slLine.Add2('Contest Points');
   slFile.Add(slLine.DelimitedText);

   try

      offsetmin := FQsoList[0].RSTsent;
      if offsetmin = _USEUTC then begin
         offsethour := 0;
      end
      else begin
         offsethour := offsetmin div 60;
      end;

      for i := 1 to FQSOList.Count - 1 do begin
         Q := FQSOList[i];

         slLine.Clear();

         SplitCallsign(Q.Callsign, strCallsign, strPortable);

         // 1 Callsign
         slLine.Add2(strCallsign);

         // 2 Portable
         slLine.Add2(strPortable);

         // 3 Time YYYY-MM-DD HH:MI:SS +0000(UTC)
         if offsetmin <> _USEUTC then begin
            qsotime := IncHour(Q.Time, offsethour);
         end
         else begin
            qsotime := Q.Time;
         end;
         strTime := FormatDateTime('yyyy-mm-dd hh:nn:ss +0000', qsotime);
         slLine.Add2(strTime);

         // 4 Time End
         slLine.Add2(strTime);

         // 5 RST Sent
         slLine.Add2(Q.RSTSentStr);

         // 6 RST Received
         slLine.Add2(Q.RSTRcvdStr);

         // 7 Who Called
         if Q.CQ = True then begin
            slLine.Add2('you_called_me');
         end
         else begin
            slLine.Add2('me_called_you');
         end;

         // 8 Grid Zone
         slLine.Add2('');

         // 9 My Callsign
         slLine.Add2(dmZLogGlobal.MyCall);

         // 10 My QTH
         slLine.Add2('');

         // 11 Other QTH
         slLine.Add2('');

         // 12 Other Name
         slLine.Add2('');

         // 13 Band
         slLine.Add2('');

         // 14 Frequency
         slLine.Add2(Q.FreqStr3);

         // 15 Mode
         slLine.Add2(Q.ModeStr);

         // 16 QSL Card
         slLine.Add2(strQslState[Q.QslState]);

         // 17 QSL Way
         slLine.Add2('');

         // 18 QSL Flag
         slLine.Add2(strQslFlag[Q.QslState]);

         // 19 Rig Model
         slLine.Add2('');

         // 20 Antenna
         slLine.Add2('');

         // 21 TXPower
         slLine.Add2('');

         // 22 Latitude
         slLine.Add2(dmZLogGlobal.Settings._mylatitude);

         // 23 Longitude
         if dmZLogGlobal.Settings._mylongitude <> '' then begin
            deg := StrToFloatDef(dmZLogGlobal.Settings._mylongitude, 0) * -1;
            slLine.Add2(FloatToStr(deg));
         end
         else begin
            slLine.Add2('');
         end;

         // 24 JCC/JGC
         if (Pos('$Q', MyContest.SentStr) > 0) or
            (Pos('$V', MyContest.SentStr) > 0) then begin
            strMulti := MyContest.MultiForm.ExtractMulti(Q);
         end
         else begin
            strMulti := '';
         end;
         slLine.Add2(strMulti);

         // 25 Altitude above sea level
         slLine.Add2('');

         // 26 Weather
         slLine.Add2('');

         // 27 Other Information
         slLine.Add2(Q.Memo);

         // 28 QSL Comment
         slLine.Add2('');

         // 29 NR Sent
         slLine.Add2(Q.NrSent);

         // 30 NR Received
         slLine.Add2(Q.NrRcvd);

         // 31 Contest Name
         slLine.Add2(FQsoList[0].Memo);

         // 32 Contest Points
         slLine.Add2(IntToStr(Q.Points));

         slFile.Add(slLine.DelimitedText);
      end;

      slFile.SaveToFile(Filename, TEncoding.UTF8);
   finally
      slLine.Free();
      slFile.Free();
   end;
end;

procedure TLog.SaveToFileAsAdif(Filename: string);
var
   f: textfile;
   Header, S, temp: string;
   i: Integer;
   Q: TQSO;
   offsetmin: Integer;
   dbl: double;

   function AdifField(F, V: string): string;
   begin
      if F = '' then begin
         Result := '';
      end
      else begin
         Result := '<' + F + ':' + IntToStr(Length(V)) + '>' + V;
      end;
   end;
begin
   Header := 'ADIF export from zLog for Windows'; // +dmZlogGlobal.Settings._mycall;

   AssignFile(f, filename);
   Rewrite(f);

   { str := 'zLog for Windows Text File'; }
   WriteLn(f, Header);
   WriteLn(f, 'All times in UTC');
   WriteLn(f, '<eoh>');

   offsetmin := Log.QsoList[0].RSTsent;
   { if offsetmin = 0 then // default JST for older versions
     offsetmin := -1*9*60; }
   if offsetmin = _USEUTC then // already recorded in utc
      offsetmin := 0;
   dbl := offsetmin / (24 * 60);

   for i := 1 to Log.TotalQSO do begin
      Q := Log.QsoList[i];

      S := AdifField('qso_date', FormatDateTime('yyyymmdd', Q.Time + dbl));
      S := S + AdifField('time_on', FormatDateTime('hhnn', Q.Time + dbl));
      S := S + AdifField('time_off', FormatDateTime('hhnn', Q.Time + dbl));

      S := S + AdifField('call', Q.Callsign);

      S := S + AdifField('rst_sent', IntToStr(Q.RSTsent));

      if MyContest.SerialType = stNone then begin
         S := S + AdifField('stx_string', Q.NrSent);
      end
      else begin
         S := S + AdifField('stx', IntToStr(Q.Serial));
      end;

      S := S + AdifField('rst_rcvd', IntToStr(Q.RSTRcvd));

      if MyContest.SerialType = stNone then begin
         S := S + AdifField('srx_string', Q.NrRcvd);
      end
      else begin
         S := S + AdifField('srx', Q.NrRcvd);
      end;

      S := S + AdifField(MyContest.ADIF_ExchangeRX_FieldName, MyContest.ADIF_ExchangeRX(Q));

      temp := MyContest.ADIF_ExtraField(Q);
      if temp <> '' then begin
         S := S + AdifField(MyContest.ADIF_ExtraFieldName, temp);
      end;

      S := S + AdifField('band', ADIFBandString[Q.Band]);
      S := S + AdifField('mode', ModeString[Q.mode]);

      if Q.Operator <> '' then begin
         S := S + AdifField('operator', Q.Operator);
      end;

      if Q.Memo <> '' then begin
         S := S + AdifField('comment', Q.Memo);
      end;

      temp := Q.FreqStr2;
      if temp <> '' then begin
         S := S + AdifField('freq', temp);
      end;

      temp := MyContest.AdifContestId;
      if temp <> '' then begin
         S := S + AdifField('contest_id', temp);
      end;

      S := S + '<eor>';

      WriteLn(f, S);
   end;

   CloseFile(f);
end;

{$ENDIF}

procedure TLog.RebuildDupeCheckList;
var
   i: Integer;
   Q: TQSO;
   B: TBand;
begin
   ClearDupeCheckList;

   for i := 1 to FQsoList.Count - 1 do begin
      Q := TQSO.Create();
      Q.Assign(FQsoList[i]);
      FDupeCheckList[Q.FBand].Add(Q);
   end;

   for B := b19 to HiBand do begin
      FDupeCheckList[B].Sort(soDupeCheck, FAcceptDifferentMode, FAllPhone);
   end;
end;

function TLog.QuickDupe(aQSO: TQSO): TQSO;
var
   Q: TQSO;
begin
   // 同一バンドで交信済みか
   Q := FDupeCheckList[aQSO.FBand].DupeCheck(aQSO, FAcceptDifferentMode, FAllPhone);
   if Q = nil then begin   // 未交信
      Result := nil;
      Exit;
   end;

   Result := Q;
end;

function TLog.OpQSO(OpName: string): Integer;
var
   i, j: Integer;
begin
   j := 0;

   for i := 1 to TotalQSO do begin
      if FQsoList[i].Operator = OpName then begin
         inc(j);
      end;
   end;

   Result := j;
end;

function TLog.IsSameBand(b1: TBand; b2: TBand): Boolean;
begin
   if MyContest.Single10G = True then begin
      if b1 = b104g then b1 := b10g;
      if b2 = b104g then b2 := b10g;
   end;
   Result := b1 = b2;
end;

function TLog.IsDupe(aQSO: TQSO): Integer;
var
   x: Integer;
   i: word;
   str: string;
begin
   FDifferentModePointer := 0;
   x := 0;
   str := CoreCall(aQSO.CallSign);

   for i := 1 to TotalQSO do begin
      // 無効QSOは除く
      if FQsoList[i].Invalid then begin
         Continue;
      end;

      if IsSameBand(aQSO.FBand, FQsoList[i].Band) and (str = CoreCall(FQsoList[i].CallSign)) then begin
         if Not(FAcceptDifferentMode) then begin
            x := i;
            break;
         end
         else begin
            if aQSO.SameMode(FQsoList[i], FAllPhone) then begin
               x := i;
               break;
            end
            else { different mode qso exists but not dupe }
            begin
               FDifferentModePointer := i;
            end;
         end;
      end;
   end;
   Result := x;
end;

function TLog.IsDupe2(aQSO: TQSO; index: Integer; var dupeindex: Integer): Boolean;
var
   boo: Boolean;
   i: word;
   str: string;
begin
   boo := False;
   str := CoreCall(aQSO.CallSign);

   for i := 1 to TotalQSO do begin
      // 無効QSOは除く
      if FQsoList[i].Invalid then begin
         Continue;
      end;

      // 同一QSOは除く
      if FQsoList[i].SameQSOID(aQSO) = True then begin
         Continue;
      end;

      if IsSameBand(aQSO.FBand, FQsoList[i].Band) and (str = CoreCall(FQsoList[i].CallSign)) then begin
         if Not(AcceptDifferentMode) or (AcceptDifferentMode and aQSO.SameMode(FQsoList[i], FAllPhone)) then begin
            boo := True;
            if index > 0 then begin
               dupeindex := i;
            end;
            break;
         end;
      end;
   end;
   Result := boo;
end;

procedure TLog.SetDupeFlags;
var
   i: Integer;
   str: string;
   aQSO: TQSO;
   TempList: TDictionary<string, Integer>;
   core: string;
   vQSO: TQSO;
   Diff: Integer;
   fQsyViolation: Boolean;
   nQsyCount: Integer;
   {$IFDEF DEBUG}
   dwTick: DWORD;
   {$ENDIF}
begin
   {$IFDEF DEBUG}
   dwTick := GetTickCount();
   {$ENDIF}

   if TotalQSO = 0 then begin
      exit;
   end;

   TempList := TDictionary<string, Integer>.Create();

   vQSO := nil;
   for i := 1 to TotalQSO do begin
      aQSO := FQsoList[i];
      core := CoreCall(aQSO.CallSign);

      // 無効QSOは除く
      if aQSO.Invalid then begin
         Continue;
      end;

      if AcceptDifferentMode then begin
         if FAllPhone = True then begin
            str := core + aQSO.BandStr + aQSO.Mode2Str
         end
         else begin
            str := core + aQSO.BandStr + aQSO.ModeStr
         end;
      end
      else begin
         str := core + aQSO.BandStr;
      end;

      // DUPE CHECK
      if TempList.ContainsKey(str) = True then begin
         SetDupeQSO(aQSO);
      end
      else begin
         ResetDupeQSO(aQSO);
         TempList.Add(str, 1);
      end;

      {$IFNDEF ZSERVER}
      // QSY violation check
      fQsyViolation := False;

      // 今回と前回のバンドが違っている場合、
      if dmZlogGlobal.Settings._countdown then begin
         if (vQSO <> nil) and (vQSO.TX = aQSO.TX) and (vQSO.Band <> aQSO.Band) then begin
            // 設定値以内のQSYならviolation
            Diff := SecondsBetween(aQSO.Time, vQSO.Time);
            if (Diff / 60) < dmZLogGlobal.Settings._countdownminute then begin
               fQsyViolation := True;
            end
            else begin
               vQSO := aQSO;
            end;
         end
         else begin
            if vQSO = nil then begin
               vQSO := aQSO;
               fQsyViolation := False;
            end
            else begin
               Diff := SecondsBetween(aQSO.Time, vQSO.Time);
               if (Diff / 60) < dmZLogGlobal.Settings._countdownminute then begin
                  fQsyViolation := vQSO.QsyViolation;
               end
               else begin
                  fQsyViolation := False;
               end;
            end;
         end;
      end;

      // 設定回数以上ならviolation
      if dmZlogGlobal.Settings._qsycount then begin
         // 現在QSOから1hour前の交信までのQSY数を数える
         nQsyCount := EvaluateQSYCount(i);

         // QSY数が設定値を超えていたらviolation
         if (nQsyCount > dmZLogGlobal.Settings._countperhour) then begin
            fQsyViolation := True;
         end;
      end;

      aQSO.QsyViolation := fQsyViolation;
      {$ENDIF}
   end;

   TempList.Free();

   {$IFDEF DEBUG}
   dwTick := GetTickCount() - dwTick;
   OutputDebugString(PChar('SetDupeFlags() = ' + IntToStr(dwTick) + ' milisec'));
   {$ENDIF}
end;

function TLog.TotalQSO: Integer;
begin
   Result := FQsoList.Count - 1;
end;

function TLog.TotalPoints: Integer;
var
   points, i: Integer;
begin
   points := 0;

   for i := 1 to TotalQSO do begin
      points := points + FQsoList[i].FPoints;
   end;

   Result := points;
end;

function TLog.TotalCW: Integer;
var
   cnt, i: Integer;
begin
   cnt := 0;
   for i := 1 to TotalQSO do begin
      if FQsoList[i].FMode = mCW then begin
         Inc(cnt);
      end;
   end;

   Result := cnt;
end;

function TLog.TotalMulti1: Integer;
var
   cnt, i: Integer;
begin
   cnt := 0;
   for i := 1 to TotalQSO do begin
      if FQsoList[i].FNewMulti1 then begin
         Inc(cnt);
      end;
   end;

   Result := cnt;
end;

function TLog.TotalMulti2: Integer;
var
   cnt, i: Integer;
begin
   cnt := 0;
   for i := 1 to TotalQSO do begin
      if FQsoList[i].FNewMulti2 then begin
         Inc(cnt);
      end;
   end;

   Result := cnt;
end;

function TLog.IndexOf(aQSO: TQSO): Integer;
var
   i: Integer;
begin
   for i := 1 to TotalQSO do begin
      if FQsoList[i].SameQSOID(aQSO) then begin
         Result := i;
         Exit;
      end;
   end;

   Result := -1;
end;

function TLog.ObjectOf(callsign: string): TQSO;
var
   i: Integer;
begin
   for i := 1 to TotalQSO do begin
      if FQsoList[i].Callsign = callsign then begin
         Result := FQsoList[i];
         Exit;
      end;
   end;

   Result := nil;
end;

function TLog.ObjectOf(qsoid: Integer): TQSO;
var
   aQSO: TQSO;
begin
   if FQsoIdDic.TryGetValue(qsoid, aQSO) = True then begin
      Result := aQSO;
   end
   else begin
      Result := nil;
   end;
end;

function TLog.LoadFromFile(filename: string): Integer;
var
   Q: TQSO;
   D: TQSOData;
   f: file of TQSOData;
   i: Integer;
   {$IFDEF DEBUG}
   dwTick: DWORD;
   {$ENDIF}
begin
   if UpperCase(ExtractFileExt(filename)) = '.ZLOX' then begin
      Result := LoadFromFileEx(filename);
      Exit;
   end;

   AssignFile(f, filename);
   Reset(f);
   Read(f, D);

   if (D.Header.MagicNo[0] = Ord('Z')) and
      (D.Header.MagicNo[1] = Ord('L')) and
      (D.Header.MagicNo[2] = Ord('O')) and
      (D.Header.MagicNo[3] = Ord('X')) then begin
      CloseFile(f);
      Result := LoadFromFileEx(filename);
      Exit;
   end;

   FStartTime := PDateTime(@D.Reserve2)^;

   {$IFDEF DEBUG}
   dwTick := GetTickCount();
   {$ENDIF}

   Q := nil;
   GLOBALSERIAL := 0;

   for i := 1 to FileSize(f) - 1 do begin
      Read(f, D);

      Q := TQSO.Create();
      Q.FileRecord := D;

      ImportSetQsoId(Q);

      // 同一QSOが２重に入ってしまった場合の暫定対策
      if IsContainsSameQSO(Q) = True then begin
         {$IFDEF DEBUG}
         OutputDebugString(PChar('**** Duplicate QSO detected! [' + Q.Callsign + '] ****'));
         {$ENDIF}
         FreeAndNil(Q);
      end
      else begin
         Add(Q, True);
      end;
   end;

   ImportFinish(Q);

   CloseFile(f);

   {$IFDEF DEBUG}
   dwTick := GetTickCount() - dwTick;
   OutputDebugString(PChar('TLog.LoadFromFile() loading time = ' + IntToStr(dwTick) + 'ms'));
   {$ENDIF}

   Result := TotalQSO;
end;

function TLog.LoadFromFileEx(filename: string): Integer;
var
   Q: TQSO;
   D: TQSODataEx;
   f: file of TQSODataEx;
   i: Integer;
   {$IFDEF DEBUG}
   dwTick: DWORD;
   {$ENDIF}
begin
   {$IFDEF DEBUG}
   dwTick := GetTickCount();
   {$ENDIF}

   AssignFile(f, filename);
   Reset(f);
   Read(f, D);

   FStartTime := PDateTime(@D.Reserve2)^;

   Q := nil;
   GLOBALSERIAL := 0;

   for i := 1 to FileSize(f) - 1 do begin
      Read(f, D);

      Q := TQSO.Create();
      Q.FileRecordEx := D;

      ImportSetQsoId(Q);

      // 同一QSOが２重に入ってしまった場合の暫定対策
      if IsContainsSameQSO(Q) = True then begin
         {$IFDEF DEBUG}
         OutputDebugString(PChar('**** Duplicate QSO detected! [' + Q.Callsign + '] ****'));
         {$ENDIF}
         FreeAndNil(Q);
      end
      else begin
         Add(Q, True);
      end;
   end;

   ImportFinish(Q);

   CloseFile(f);

   {$IFDEF DEBUG}
   dwTick := GetTickCount() - dwTick;
   OutputDebugString(PChar('TLog.LoadFromFileEx() loading time = ' + IntToStr(dwTick) + 'ms'));
   {$ENDIF}

   Result := TotalQSO;
end;

{$IFNDEF ZSERVER}

function TLog.LoadFromFileAszLogCsv(Filename: string): Integer;
var
   i: Integer;
   Q: TQSO;
   offsetmin: Integer;
   slFile: TStringList;
   slLine: TStringList;
   slText: TStringList;
   strMsg: string;
begin
   slFile := TStringList.Create();
   slFile.StrictDelimiter := True;
   slLine := TStringList.Create();
   slLine.StrictDelimiter := True;
   slText := TStringList.Create();
   slText.StrictDelimiter := True;
   try
      if FileExists(Filename) = False then begin
         Result := 0;
         Exit;
      end;

      slFile.LoadFromFile(Filename);

      if slFile.Count = 1 then begin
         Result := 0;
         Exit;
      end;

      i := 0;
      try
         for i := 1 to slFile.Count - 1 do begin
            slLine.Clear();
            slLine.CommaText := slFile.Strings[i] + DupeString(',', 34);

            Q := TQSO.Create();

            // 1列目　交信年月日（YY/MM/DD）
            // 2列目　交信時分（HH:MM:SS）
            Q.Time := StrToDateTime(slLine[0] + ' ' + slLine[1]);

            // 3列目 TimeZone
            if i = 1 then begin
               if slLine[2] = 'UTC' then begin
                  offsetmin := _USEUTC;
               end
               else begin
                  offsetmin := 0;
               end;
               FQsoList[0].RSTsent := offsetmin;
            end;

            // 4列目 コールサイン
            Q.Callsign := slLine[3];

            // 5列目 相手局へ送ったRST
            Q.RSTSent := StrToIntDef(slLine[4], 599);

            // 6列目 相手局へ送ったNumber
            Q.NrSent := slLine[5];

            // 7列目 相手局からもらったレポート
            Q.RSTRcvd := StrToIntDef(slLine[6], 599);

            // 8列目 相手局からもらったNumber
            Q.NrRcvd := slLine[7];

            // 9列目 シリアルNO
            Q.Serial := StrToIntDef(slLine[8], 0);

            // 10列目 Mode
            Q.Mode := StrToModeDef(slLine[9], mCW);

            // 11列目 Band
            Q.Band := StrToBandDef(slLine[10], b7);

            // 12列目 Power 0:P 1:L 2:M 3:H
            if slLine[11] = 'P' then Q.Power := TPower(0)
            else if slLine[11] = 'L' then Q.Power := TPower(1)
            else if slLine[11] = 'M' then Q.Power := TPower(2)
            else if slLine[11] = 'H' then Q.Power := TPower(3)
            else Q.Power := TPower(2);

            // 13列目 マルチ１
            Q.Multi1 := slLine[12];

            // 14列目 マルチ２
            Q.Multi2 := slLine[13];

            // 15列目 Newマルチ１
            Q.NewMulti1 := StrToBoolDef(slLine[14], False);

            // 16列目 Newマルチ２
            Q.NewMulti2 := StrToBoolDef(slLine[15], False);

            // 17列目 Points
            Q.Points := StrToIntDef(slLine[16], 0);

            // 18列目 Operator
            Q.Operator := slLine[17];

            // 19列目 memo
            slText.Text := StringReplace(slLine[18], '\n', #13#10, [rfReplaceAll]);
            if slText.Count > 0 then begin
               Q.Memo := slText[0];
            end;

            // 20列目 CQ
            Q.CQ := StrToBoolDef(slLine[19], False);

            // 21列目 Dupe
            Q.Dupe := StrToBoolDef(slLine[20], False);

            // 22列目 Reserve
            Q.Reserve := StrToIntDef(slLine[21], 0);

            // 23列目 TX
            Q.TX := StrtoIntDef(slLine[22], 0);

            // 24列目 Power2
            Q.Power2 := StrToIntDef(slLine[23], 0);

            // 25列目 Reserve2
            Q.Reserve2 := StrToIntDef(slLine[24], 0);

            // 26列目 Reserve3
            Q.Reserve3 := StrToIntDef(slLine[25], 0);

            // 27列目 Freq
            Q.Freq := slLine[26];

            // 28列目 QsyViolation
            Q.QsyViolation := StrToBoolDef(slLine[27], False);

            // 29列目 PCName
            Q.PCName := slLine[28];

            // 30列目 Forced
            Q.Forced := StrToBoolDef(slLine[29], False);

            // 31列目 QslState
            Q.QslState := TQslState(StrToIntDef(slLine[30], 0));

            // 32列目 Invalid
            Q.Invalid := StrToBoolDef(slLine[31], False);

            // 33列目 Area

            // 34列目 RBN Verified
            Q.RbnVerified := StrToBoolDef(slLine[33], False);

            ImportSetQsoId(Q);

            // 同一QSOが２重に入ってしまった場合の暫定対策
            if IsContainsSameQSO(Q) = True then begin
               {$IFDEF DEBUG}
               OutputDebugString(PChar('**** Duplicate QSO detected! [' + Q.Callsign + '] ****'));
               {$ENDIF}
               FreeAndNil(Q);
            end
            else begin
               Add(Q, True);
            end;
         end;

         ImportFinish(Q);
      except
         on E: Exception do begin
            strMsg := IntToStr(i) + '行目でデータ取り込みエラーが発生しました' + #13#10 + E.Message;
            MessageBox(0, PChar(strMsg), PChar(Application.Title), MB_OK + MB_ICONEXCLAMATION);
         end;
      end;

      Result := TotalQSO;
   finally
      slFile.Free();
      slLine.Free();
      slText.Free();
   end;
end;

//
// <qso_date:8>20250312<time_on:4>0253<time_off:4>0253<call:6>JR8PPG<rst_sent:3>599<stx_string:4>106H<rst_rcvd:3>599<srx_string:4>106M<band:3>40m<mode:2>CW<contest_id:11>JA_DOMESTIC<eor>
//
function TLog.LoadFromFileAsAdif(Filename: string): Integer;
var
   i: Integer;
   Q: TQSO;
   offsetmin: Integer;
   S: string;
   dt: string;
   tm: string;
   adif: TAdifFile;
   yy, mm, dd, hh, nn: Word;
   m: TMode;
   defrst: Integer;
   h: Integer;

   //
   function GetMode(adifMode: string): TMode;
   var
      m: TMode;
   begin
      for m := mCW to LastMode do begin
         if ModeString[m] = adifMode then begin
            Result := m;
            Exit;
         end;
      end;
      Result := mOther;
   end;

   //
   function GetBand(adifBand: string): TBand;
   var
      b: TBand;
   begin
      for b := b19 to b10g do begin
         if ADIFBandString[b] = adifBand then begin
            Result := b;
            Exit;
         end;
      end;
      Result := bUnknown;
   end;
begin
   adif := TAdifFile.Create();
   try
      if FileExists(Filename) = False then begin
         Result := 0;
         Exit;
      end;

      // ADIFのロード＆パース
      adif.LoadFromFile(Filename);
      adif.Parse();

      // このコンテストのTimezone
      offsetmin := Log.QsoList[0].RSTsent;
      if offsetmin = _USEUTC then begin
         h := 0;
      end
      else begin
         h := Trunc(Abs(offsetmin / 60));
      end;

      Q := nil;
      for i := 0 to adif.Items.Count - 1 do begin

         Q := TQSO.Create();

         // 1列目　交信年月日（yyyymmdd）
         // 2列目　交信時分（hhnn）
         dt := adif.Items[i].Values['QSO_DATE'];
         tm := adif.Items[i].Values['TIME_ON'];

         yy := StrToIntDef(Copy(dt, 1, 4), 0);
         mm := StrToIntDef(Copy(dt, 5, 2), 0);
         dd := StrToIntDef(Copy(dt, 7, 8), 0);
         hh := StrToIntDef(Copy(tm, 1, 2), 0);
         nn := StrToIntDef(Copy(tm, 3, 2), 0);

         Q.Time := EncodeDateTime(yy, mm, dd, hh, nn, 0, 0);

         // JSTの場合は変換する
         if h <> 0 then begin
            Q.Time := IncHour(Q.Time, h);
         end;

         // モード
         m := GetMode(adif.Items[i].Values['MODE']);

         if (m = mSSB) or (m = mAM) or (m = mFM) then begin
            defrst := 59;
         end
         else begin
            defrst := 599;
         end;

         // コールサイン
         Q.Callsign := adif.Items[i].Values['CALL'];

         // 相手局へ送ったRST
         Q.RSTSent := StrToIntDef(adif.Items[i].Values['RST_SENT'], defrst);

         // 相手局へ送ったNumber
         if MyContest.SerialType = stNone then begin
            Q.NrSent := adif.Items[i].Values['STX_STRING'];
         end
         else begin
            Q.Serial := StrToIntDef(adif.Items[i].Values['STX'], 0);
         end;

         // 相手局からもらったレポート
         Q.RSTRcvd := StrToIntDef(adif.Items[i].Values['RST_RCVD'], defrst);

         // 相手局からもらったNumber
         S := MyContest.ADIF_ExchangeRX_FieldName;
         if S = '' then begin
            if MyContest.SerialType = stNone then begin
               Q.NrRcvd := adif.Items[i].Values['SRX_STRING'];
            end
            else begin
               Q.NrRcvd := adif.Items[i].Values['SRX'];
            end;
         end
         else begin
            Q.NrRcvd := adif.Items[i].Values[S];
         end;

         // Mode
         Q.Mode := m;

         // Band
         Q.Band := GetBand(adif.Items[i].Values['BAND']);

         // 12列目 Power 0:P 1:L 2:M 3:H
         Q.Power := dmZLogGlobal.PowerOfBand[Q.Band];

         // マルチ１
         Q.Multi1 := '';

         // マルチ２
         Q.Multi2 := '';

         // Newマルチ１
         Q.NewMulti1 := False;

         // Newマルチ２
         Q.NewMulti2 := False;

         // Points
         Q.Points := 0;

         // Operator
         Q.Operator := adif.Items[i].Values['OPERATOR'];

         // memo
         Q.Memo := adif.Items[i].Values['COMMENT'];

         // CQ
         Q.CQ := False;

         // Dupe
         Q.Dupe := False;

         // Reserve
         Q.Reserve := 0;

         // TX
         Q.TX := dmZlogGlobal.TXNr;

         // Power2
         Q.Power2 := 0;

         // Reserve2
         Q.Reserve2 := 0;

         // Reserve3
         Q.Reserve3 := 0;

         // 27列目 Freq
         Q.Freq := adif.Items[i].Values['FREQ'];

         // QsyViolation
         Q.QsyViolation := False;

         // PCName
         Q.PCName := dmZLogGlobal.Settings._pcname;

         // Forced
         Q.Forced := False;

         // QslState
         Q.QslState := qsNone;

         // Invalid
         Q.Invalid := False;

         // RBN Verified
         Q.RbnVerified := False;

         ImportSetQsoId(Q);

         Add(Q, True);
      end;

      ImportFinish(Q);

      Result := TotalQSO;
   finally
      adif.Free();
   end;
end;

//
// Cabrilloファイルのインポート
//
//                              --------info sent------- -------info rcvd--------
//QSO:  freq mo date       time call          rst exch   call          rst exch   t
//QSO:  3799 PH 1999-03-06 0712 HC8N           59 700    N5KO           59 CA     0
function TLog.LoadFromFileAsCabrillo(Filename: string; nTimeZoneOffset: Integer): Integer;
var
   slFile: TStringList;
   i: Integer;
   Q: TQSO;
   L: string;
   p: Integer;
   hz: TFrequency;
   S: string;
   m: TMode;
   D, T: string;
   yy, mm, dd, hh, nn: Word;
   b: TBand;
   defrst: Integer;
   offsetmin: Integer;
   offhour: Integer;
   utc: TDateTime;

   function GetStr(instr: string; var p: Integer): string;
   var
      outstr: string;
      len: Integer;
      ch: Char;
      fStart: Boolean;
   begin
      len := Length(instr);

      fStart := False;
      while(p <= len) do begin
         ch := instr[p];

         if (ch = ' ') and (fStart = False) then begin
            Inc(p);
            Continue;
         end
         else begin
            fStart := True;
         end;

         if ((ch = ' ') or (ch = #$13)) and (fStart = True) then begin
            Break;
         end;

         Inc(p);

         outstr := outstr + ch;
      end;

      Result := Trim(outstr);
   end;

   function CbrFreqToBand(freq: string): TBand;
   var
      b: TBand;
   begin
      for b := Low(CabrilloBandString) to High(CabrilloBandString) do begin
         if Trim(CabrilloBandString[b]) = freq then begin
            Result := b;
            Exit;
         end;
      end;
      Result := bUnknown;
   end;
begin
   slFile := TStringList.Create();
   try
      if FileExists(Filename) = False then begin
         Result := 0;
         Exit;
      end;

      slFile.LoadFromFile(Filename);

      offsetmin := FQsoList[0].RSTsent;
      if offsetmin = _USEUTC then begin
         offhour := 0;
      end
      else begin
         offhour := offsetmin div 60;
      end;

      Q := nil;
      for i := 0 to slFile.Count - 1 do begin
         L := slFile[i];

         if Copy(L, 1, 4) <> 'QSO:' then begin
            Continue;
         end;

         Q := TQSO.Create();

         // FREQ/Band
         p := 5;
         S := GetStr(L, p);

         b := CbrFreqToBand(S);
         if b = bUnknown then begin
            hz := StrToIntDef(S, 0) * 1000;
            Q.Freq := Format('%.1f', [hz / 1000]);
            Q.Band := dmZLogGlobal.BandPlan.FreqToBand(hz);
         end
         else begin
            Q.Freq := '';
            Q.Band := b;
         end;

         // Mode
         S := GetStr(L, p);

         Q.Mode := mOther;
         for m := Low(CabrilloModeString) to High(CabrilloModeString) do begin
            if CabrilloModeString[m] = S then begin
               Q.Mode := m;
               Break;
            end;
         end;

         if (m = mSSB) or (m = mAM) or (m = mFM) or (m = mDV) then begin
            defrst := 59;
         end
         else begin
            defrst := 599;
         end;

         // DATE/TIME
         D := GetStr(L, p);
         T := GetStr(L, p);
         yy := StrToIntDef(Copy(D, 1, 4), 1990);
         mm := StrToIntDef(Copy(D, 6, 2), 1);
         dd := StrToIntDef(Copy(D, 9, 2), 1);
         hh := StrToIntDef(Copy(T, 1, 2), 0);
         nn := StrToIntDef(Copy(T, 3, 2), 0);

         utc := EncodeDateTime(yy, mm, dd, hh, nn, 0, 0);

         // いったんUTCに統一
         utc := IncHour(utc, offhour);

         // さらに指定のoffsetを足して指定のtime zoneへ
         utc := IncHour(utc, nTimeZoneOffset);

         Q.Time := utc;

         // UR CALL, RST, NR
         S := GetStr(L, p);

         S := GetStr(L, p);
         Q.RSTSent := StrToIntDef(S, defrst);

         S := GetStr(L, p);
         Q.NrSent := S;

         // MY CALL, RST, NR
         Q.Callsign := GetStr(L, p);
         S := GetStr(L, p);
         Q.RSTRcvd := StrToIntDef(S, defrst);
         S := GetStr(L, p);
         Q.NrRcvd := S;

         // TX#
         S := GetStr(L, p);
         Q.TX := StrToIntDef(S, 0);

         Q.Power := dmZLogGlobal.PowerOfBand[Q.Band];

         ImportSetQsoId(Q);

         Add(Q, True);
      end;

      ImportFinish(Q);

      Result := TotalQSO;
   finally
      slFile.Free();
   end;
end;

//
// CTESTWINのLG8ファイルのインポート
//
function TLog.LoadFromFileAsCtestwin(Filename: string): Integer;
var
   Q: TQSO;
   f: file;
   H: TCTestwinHeader;
   D: TCTestwinQsoData;
   i: Integer;
   b: TBand;
   m: TMode;
   defrst: Integer;
   n: Integer;
   S: string;
   BytesRead: Integer;
   Index: Integer;
   hz: TFrequency;
const
   mode_table: array[0..24] of TMode = (
   // CW,  RTTY,  SSB,  FM,  AM,  ATV,    SSTV,   PSK,    GMSK,   MFSK,
      mCW, mRTTY, mSSB, mFM, mAM, mOther, mOther, mOther, mOther, mOther,
   // QPSK,   FSK,    D-STAR, C4FM, JT65,   JT9,    ISCAT,  FT8,  JT4,    QRA64,
      mOther, mOther, mDV,    mDV,  mOther, mOther, mOther, mFT8, mOther, mOther,
   // MSK144, WSPR,   JTMS,   FT4,  FST4
      mOther, mOther, mOther, mFT4, mOther
   );
   band_table: array[0..22] of TBand = (
      b19, b35, b7, b10, b14, b18, b21, b24, b28, b50,
      b144, b430, b1200, b2400, b5600, b10g, bUnknown, bUnknown, bUnknown, bUnknown,
      bUnknown, bUnknown, bUnknown
   );
begin
   if FileExists(Filename) = False then begin
      Result := 0;
      Exit;
   end;

   AssignFile(f, filename);
   Reset(f, 1);
   BlockRead(f, H, SizeOf(H), BytesRead);

   Q := nil;
   for i := 1 to H.QsoCount do begin
      BlockRead(f, D, SizeOf(D), BytesRead);

      Q := TQSO.Create();

      if D.Mode > High(mode_table) then begin
         m := mOther;
      end
      else begin
         m := mode_table[D.Mode];
      end;

      if (m = mSSB) or (m = mAM) or (m = mFM) then begin
         n := 2;
         defrst := 59;
      end
      else if (m = mCW) or (m = mRTTY) then begin
         n := 3;
         defrst := 599;
      end
      else begin
         n := 0;
         defrst := 59;
      end;

      if D.Band > High(band_table) then begin
         b := bUnknown;
      end
      else begin
         b := band_table[D.Band];
      end;

      if n > 0 then begin
         S := string(D.SentNr);
         Q.RSTSent := StrToIntDef(Copy(S, 1, n), defrst);
         Q.NrSent := Copy(S, n + 1);

         S := string(D.RecvNr);
         Q.RSTRcvd := StrToIntDef(Copy(S, 1, n), defrst);
         Q.NrRcvd := Copy(S, n + 1);
      end
      else begin
         Q.RSTSent := defrst;
         Q.NrSent := string(D.SentNr);

         Q.RSTRcvd := defrst;
         Q.NrRcvd := string(D.RecvNr);
      end;

      Q.Callsign := string(D.Callsign);
      Q.Mode := m;
      Q.Band := b;
      Q.Time := UnixToDateTime(D.Time, False);
      Q.Operator := string(D.OpeName);
      Q.Memo := string(D.Remarks);
      Q.Power := dmZLogGlobal.PowerOfBand[Q.Band];


      Index := Pos('MHz', Q.Memo);
      if Index > 0 then begin
         S := Copy(Q.Memo, 1, Index - 1);
         hz := Trunc(StrToFloatDef(S, 0) * 1000 * 1000);
         Q.Freq := Format('%.1f', [hz / 1000]);
      end
      else begin
         Q.Freq := '';
      end;

      ImportSetQsoId(Q);

      Add(Q, True);
   end;

   ImportFinish(Q);

   Result := TotalQSO;

   CloseFile(f);
end;

//
// JARL publiclogのインポート
//
// 1234567890123456789012345678901234567890123456789012345678901234567890123456
//   50 PH 2025-04-26 2100 JR8xxx        59  18M      JA1xxx        59  10M
//   50 PH 2025-04-26 2101 JR8xxx        59  18M      JA1xxx        59  11M
function TLog.LoadFromFileAsJarlPubLog(Filename: string): Integer;
var
   slFile: TStringList;
   i: Integer;
   Q: TQSO;
   L: string;
   p: Integer;
   S: string;
   m: TMode;
   D, T: string;
   yy, mm, dd, hh, nn: Word;
   b: TBand;
   defrst: Integer;
   jst: TDateTime;
   power: Char;

   function GetStr(instr: string; var p: Integer): string;
   var
      outstr: string;
      len: Integer;
      ch: Char;
      fStart: Boolean;
   begin
      len := Length(instr);

      fStart := False;
      while(p <= len) do begin
         ch := instr[p];

         if (ch = ' ') and (fStart = False) then begin
            Inc(p);
            Continue;
         end
         else begin
            fStart := True;
         end;

         if ((ch = ' ') or (ch = #$13)) and (fStart = True) then begin
            Break;
         end;

         Inc(p);

         outstr := outstr + ch;
      end;

      Result := Trim(outstr);
   end;

   function FreqToBand(freq: string): TBand;
   var
      b: TBand;
   begin
      for b := Low(JarlPubLogMHzString) to High(JarlPubLogMHzString) do begin
         if Trim(JarlPubLogMHzString[b]) = freq then begin
            Result := b;
            Exit;
         end;
      end;
      Result := bUnknown;
   end;
begin
   slFile := TStringList.Create();
   try
      if FileExists(Filename) = False then begin
         Result := 0;
         Exit;
      end;

      slFile.LoadFromFile(Filename);

      Q := nil;
      for i := 0 to slFile.Count - 1 do begin
         L := slFile[i];

         Q := TQSO.Create();

         // FREQ/Band
         p := 1;
         S := GetStr(L, p);

         b := FreqToBand(S);
         Q.Freq := '';
         Q.Band := b;

         // Mode
         S := GetStr(L, p);

         Q.Mode := mOther;
         for m := Low(CabrilloModeString) to High(CabrilloModeString) do begin
            if CabrilloModeString[m] = S then begin
               Q.Mode := m;
               Break;
            end;
         end;

         if (m = mSSB) or (m = mAM) or (m = mFM) then begin
            defrst := 59;
         end
         else begin
            defrst := 599;
         end;

         // DATE/TIME
         D := GetStr(L, p);
         T := GetStr(L, p);
         yy := StrToIntDef(Copy(D, 1, 4), 1990);
         mm := StrToIntDef(Copy(D, 6, 2), 1);
         dd := StrToIntDef(Copy(D, 9, 2), 1);
         hh := StrToIntDef(Copy(T, 1, 2), 0);
         nn := StrToIntDef(Copy(T, 3, 2), 0);

         jst := EncodeDateTime(yy, mm, dd, hh, nn, 0, 0);

         Q.Time := jst;

         // UR CALL, RST, NR
         S := GetStr(L, p);

         S := GetStr(L, p);
         Q.RSTSent := StrToIntDef(S, defrst);

         S := GetStr(L, p);
         Q.NrSent := S;

         // MY CALL, RST, NR
         Q.Callsign := GetStr(L, p);
         S := GetStr(L, p);
         Q.RSTRcvd := StrToIntDef(S, defrst);
         S := GetStr(L, p);
         Q.NrRcvd := S;

         power := RightStr(Q.NrSent, 1)[1];
         case power of
            'H': Q.Power := pwrH;
            'M': Q.Power := pwrM;
            'L': Q.Power := pwrL;
            'P': Q.Power := pwrP;
            else Q.Power := pwrM;
         end;

         ImportSetQsoId(Q);

         Add(Q, True);
      end;

      ImportFinish(Q);

      Result := TotalQSO;
   finally
      slFile.Free();
   end;
end;

procedure TLog.ImportSetQsoId(Q: TQSO);
var
   qsoid: Integer;
begin
   // QSOIDが無ければ発番する
   if Q.Reserve3 = 0 then begin
      repeat
         qsoid := dmZLogGlobal.NewQSOID;
      until CheckQSOID(qsoid) = False;
      Q.Reserve3 := qsoid;
   end;
end;

procedure TLog.ImportFinish(Q: TQSO);
var
   b: TBand;
begin
   // DUPEチェック用Indexをソート
   for b := Low(FDupeCheckList) to High(FDupeCheckList) do begin
      FDupeCheckList[b].Sort(soDupeCheck, FAcceptDifferentMode, FAllPhone);
   end;

   if Q <> nil then begin
      GLOBALSERIAL := (Q.Reserve3 div 10000) mod 10000;
   end;
end;


function TLog.IsWorked(strCallsign: string; band: TBand): Boolean;
var
   Q: TQSO;
begin
   Q := TQSO.Create();
   try
      if Integer(band) = -1 then begin
         Result := False;
         Exit;
      end;

      Q.Callsign := strCallsign;
      Q.Band := band;

      // BandScopeでは正しいモードがわからないためモード無しでのDupeCheckを行う
      if FDupeCheckList[band].DupeCheck(Q, False {FAcceptDifferentMode}, FAllPhone) <> nil then begin
         Result := True;
      end
      else begin
         Result := False;
      end;

      {$IFDEF DEBUG}
      OutputDebugString(PChar('*** IsWorked() = ' + strCallsign + ' ' + BoolToStr(Result, True) + ' ***'));
      {$ENDIF}
   finally
      Q.Free();
   end;
end;

function TLog.IsOtherBandWorked(strCallsign: string; exclude_band: TBand; var workdmulti: string): Boolean;
var
   Q: TQSO;
   R: TQSO;
   b: TBand;
begin
   Q := TQSO.Create();
   try
      for b := Low(FDupeCheckList) to High(FDupeCheckList) do begin
         if dmZLogGlobal.Settings._activebands[b] = False then begin
            Continue;
         end;

         if b = exclude_band then begin
            Continue;
         end;

         Q.Callsign := strCallsign;
         Q.Band := b;

         R := FDupeCheckList[b].DupeCheck(Q, False {FAcceptDifferentMode}, FAllPhone);
         if R <> nil then begin
            workdmulti := R.NrRcvd;
            Result := True;
            Exit;
         end;
      end;

      Result := False;
   finally
      Q.Free();
   end;
end;
{$ENDIF}

function TLog.IsNewMulti(band: TBand; multi: string): Boolean;
var
   i: Integer;
   Q: TQSO;
begin
   for i := 1 to FBandList[band].Count - 1 do begin
      Q := FBandList[band].Items[i];
      if (Q.Invalid = False) and (Q.Multi1 = multi) then begin
         Result := False;
         Exit;
      end;
   end;

   Result := True;
end;

function TLog.GetScoreCoeff(): Extended;
begin
   Result := FQsoList[0].RSTRcvd / 100;
end;

procedure TLog.SetScoreCoeff(E: Extended);
var
   N: Integer;
begin
   N := Trunc(E * 100);
   if FQsoList[0].RSTRcvd <> N then begin
      FQsoList[0].RSTRcvd := N;
      FSaved := False;
   end;
end;

{$IFNDEF ZSERVER}
function TLog.EvaluateQSYCount(nStartIndex: Integer): Integer;
var
   nQsyCount: Integer;
   aQSO: TQSO;
   bQSO: TQSO;
   i: Integer;
   basetime: TDateTime;
   dd, hh: Word;
   dd2, hh2: Word;
   fFound: Boolean;
   offsetmin: Integer;
   offsethour: Integer;
begin
   if dmZlogGlobal.Settings._qsycount = False then begin
      Result := 0;
      Exit;
   end;

   offsetmin := FQsoList[0].RSTsent;
   if offsetmin = _USEUTC then begin
      offsethour := 0;
   end
   else begin
      offsethour := offsetmin div 60;
   end;

   nQsyCount := 0;

   basetime := CurrentQSO.Time;
   dd := DayOf(basetime);
   hh := HourOf(basetime);

   // その時間帯の最初のQSOを探す
   fFound := False;
   for i := nStartIndex downto 1 do begin
      bQSO := FQsoList[i];

      if offsetmin = _USEUTC then begin
         bQSO.Time := IncHour(bQSO.Time, offsethour);
      end;

      dd2 := DayOf(bQSO.Time);
      hh2 := HourOf(bQSO.Time);

      if (dmZLogGlobal.TXNr = bQSO.TX) then begin
         if (dd = dd2) and (hh = hh2) then begin
            nStartIndex := i;
            fFound := True;
         end;

         if ((dd <> dd2) or (hh <> hh2)) then begin
            nStartIndex := i;
            Break;
         end;
      end;
   end;

   // 同じ時間帯のQSOを発見できなかったらQSYなし
   if fFound = False then begin
      Result := nQsyCount;
      Exit;
   end;

   // その時間帯最初のQSOの一つ前
   aQSO := FQsoList[nStartIndex];

   for i := nStartIndex + 1 to FQsoList.Count - 1 do begin
      bQSO := FQsoList[i];

      // TXが同じでバンドが違えばカウント
      if (dmZLogGlobal.TXNr = bQSO.TX) then begin
         dd2 := DayOf(bQSO.Time);
         hh2 := HourOf(bQSO.Time);

         // 日又は時が変わったら終わり
         if ((dd <> dd2) or (hh <> hh2)) then begin
            Break;
         end;

         // 一つ前のQSOとバンドが違えばQSYとする
         if (aQSO.Band <> bQSO.Band) then begin
            Inc(nQsyCount);
         end;
         aQSO := bQSO;
      end;
   end;

   Result := nQsyCount;
end;
{$ENDIF}

procedure TLog.RenewMulti();
var
   multi1: array[b19..HiBand] of TDictionary<string, string>;
   multi2: array[b19..HiBand] of TDictionary<string, string>;
   i: Integer;
   aQSO: TQSO;
   b: TBand;
begin
   for b := b19 to HiBand do begin
      multi1[b] := TDictionary<string, string>.Create();
      multi2[b] := TDictionary<string, string>.Create();
   end;
   try
      for i := 1 to TotalQSO do begin
         aQSO := FQsoList[i];
         aQSO.NewMulti1 := False;
         aQSO.NewMulti2 := False;
      end;

      for i := 1 to TotalQSO do begin
         aQSO := FQsoList[i];

         if aQSO.Invalid = True then begin
            Continue;
         end;
         if aQSO.Dupe = True then begin
            Continue;
         end;

         if aQSO.Multi1 <> '' then begin
            if multi1[aQSO.Band].ContainsKey(aQSO.Multi1) = False then begin
               multi1[aQSO.Band].Add(aQSO.Multi1, aQSO.Callsign);
               aQSO.NewMulti1 := True;
            end;
         end;

         if aQSO.Multi2 <> '' then begin
            if multi2[aQSO.Band].ContainsKey(aQSO.Multi2) = False then begin
               multi2[aQSO.Band].Add(aQSO.Multi2, aQSO.Callsign);
               aQSO.NewMulti2 := True;
            end;
         end;
      end;

   finally
      for b := b19 to HiBand do begin
         multi1[b].Free();
         multi2[b].Free();
      end;
   end;
end;

function TLog.IsContainsSameQSO(Q: TQSO): Boolean;
var
   aQSO: TQSO;
begin
   if FQsoIdDic.TryGetValue(Q.QsoId, aQSO) = True then begin
      if aQSO.Callsign = Q.Callsign then begin
         Result := True;
         Exit;
      end;
   end;

   Result := False;
end;

function TLog.IsOutOfPeriod(Q: TQSO): Boolean;
begin
   {$IFNDEF ZSERVER}
   if MyContest.UseContestPeriod = False then begin
      Result := False;
      Exit;
   end;

   if (Q.Time < FStartTime) or (Q.Time > EndTime) then begin
      Result := True;
      Exit;
   end;
   {$ENDIF}
   Result := False;
end;

procedure TLog.JudgeOutOfPeriod();
var
   i: Integer;
   Q: TQSO;
begin
   for i := 1 to TotalQSO do begin
      Q := FQsoList[i];
      Q.Invalid := IsOutOfPeriod(Q);
   end;
end;

procedure TLog.Renumber();
var
   i: Integer;
   Q: TQSO;
   qsoid: Integer;
begin
   for i := 1 to FQsoList.Count - 1 do begin
      Q := FQsoList[i];

      repeat
         qsoid := dmZLogGlobal.NewQSOID;
      until CheckQSOID(qsoid) = False;
      Q.Reserve3 := qsoid;
   end;
end;

{ TQSOCallsignComparer }

function TQSOCallsignComparer.Compare(const Left, Right: TQSO): Integer;
var
   n: Integer;
begin
   n := CompareText(CoreCall(Left.Callsign), CoreCall(Right.Callsign));
   if n = 0 then begin
      Result := (Left.Index - Right.Index);
   end
   else begin
      Result := n;
   end;
end;

{ TQSOTimeComparer }

function TQSOTimeComparer.Compare(const Left, Right: TQSO): Integer;
begin
   if CompareDateTime(Left.Time, Right.Time) = 0 then begin
      Result := (Left.Index - Right.Index);
   end
   else begin
      Result := CompareDateTime(Left.Time, Right.Time);
   end;
end;

{ TQSOBandComparer }

function TQSOBandComparer.Compare(const Left, Right: TQSO): Integer;
begin
   if Left.Band = Right.Band then begin
      Result := (Left.Index - Right.Index);
   end
   else begin
      Result := Integer(Left.Band) - Integer(Right.Band);
   end;
end;

{ TQSOModeComparer }

function TQSOModeComparer.Compare(const Left, Right: TQSO): Integer;
begin
   if Left.Mode = Right.Mode then begin
      Result := (Left.Index - Right.Index);
   end
   else begin
      Result := Integer(Left.Mode) - Integer(Right.Mode);
   end;
end;

{ TQSOPowerComparer }

function TQSOPowerComparer.Compare(const Left, Right: TQSO): Integer;
begin
   if Left.Power = Right.Power then begin
      Result := (Left.Index - Right.Index);
   end
   else begin
      Result := Integer(Left.Power) - Integer(Right.Power);
   end;
end;

{ TQSOTxNoComparer }

function TQSOTxNoComparer.Compare(const Left, Right: TQSO): Integer;
begin
   if Left.TX = Right.TX then begin
      Result := (Left.Index - Right.Index);
   end
   else begin
      Result := Left.TX - Right.TX;
   end;
end;

{ TQSOPointComparer }

function TQSOPointComparer.Compare(const Left, Right: TQSO): Integer;
begin
   if Left.Points = Right.Points then begin
      Result := (Left.Index - Right.Index);
   end
   else begin
      Result := Left.Points - Right.Points;
   end;
end;

{ TQSOOperatorComparer }

function TQSOOperatorComparer.Compare(const Left, Right: TQSO): Integer;
begin
   if CompareText(Left.Operator, Right.Operator) = 0 then begin
      Result := (Left.Index - Right.Index);
   end
   else begin
      Result := CompareText(Left.Operator, Right.Operator);
   end;
end;

{ TQSOMemoComparer }

function TQSOMemoComparer.Compare(const Left, Right: TQSO): Integer;
begin
   if CompareText(Left.Memo, Right.Memo) = 0 then begin
      Result := (Left.Index - Right.Index);
   end
   else begin
      Result := CompareText(Left.Memo, Right.Memo);
   end;
end;

{ TQSOTxNoBandTimeComparer }

function TQSOTxNoBandTimeComparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := CompareDateTime(Left.Time, Right.Time) +
             ((Integer(Left.Band) - Integer(Right.Band)) * 10) +
             ((Left.TX - Right.TX) * 100);
end;

{ TQSOTxNoTimeComparer }

function TQSOTxNoTimeComparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := CompareDateTime(Left.Time, Right.Time) +
             ((Left.TX - Right.TX) * 10);
end;

{ TQSODupeWithoutModeComparer }

function TQSODupeWithoutModeComparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := CompareText(CoreCall(Left.Callsign), CoreCall(Right.Callsign)) +
             ((Integer(Left.Band) - Integer(Right.Band)) * 10);
end;

{ TQSODupeWithModeComparer }

function TQSODupeWithModeComparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := CompareText(CoreCall(Left.Callsign), CoreCall(Right.Callsign)) +
             ((Integer(Left.Band) - Integer(Right.Band)) * 10) +
             ((Integer(Left.Mode) - Integer(Right.Mode)) * 100);
end;

{ TQSODupeWithMode2Comparer }

function TQSODupeWithMode2Comparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := CompareText(CoreCall(Left.Callsign), CoreCall(Right.Callsign)) +
             ((Integer(Left.Band) - Integer(Right.Band)) * 10) +
             ((Integer(Left.Mode2) - Integer(Right.Mode2)) * 100);
end;

end.
