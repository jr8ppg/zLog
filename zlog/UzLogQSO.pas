unit UzLogQSO;

//{$DEFINE ZSERVER}

interface

uses
  System.SysUtils, System.Classes, StrUtils, IniFiles, Forms, Windows, Menus,
  System.DateUtils, Generics.Collections, Generics.Defaults,
  UzlogConst;

type
  TQSOData = packed record
    Time : TDateTime;      {  8 bytes }
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
    Time : TDateTime;      {  8 bytes }
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
    Reserve4: string[101]; { 102 bytes }
    // 384bytes
  end;

  TQSO = class(TObject)
  private
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

    function GetMode2(): TMode;
    function GetPoints(): Integer;

    function GetFileRecord(): TQSOData;
    procedure SetFileRecord(src: TQSOData);
    function GetFileRecordEx(): TQSODataEx;
    procedure SetFileRecordEx(src: TQSODataEx);

    function GetSerialStr(): string;
    function GetTimeStr(): string;
    function GetDateStr(): string;
    function GetBandStr(): string;
    function GetModeStr(): string;
    function GetMode2Str(): string;
    function GetPowerStr(): string;
    function GetNewPowerStr(): string;
    function GetPointStr(): string;
    function GetRSTStr(): string;
    function GetRSTSentStr(): string;
    function GetRSTRcvdStr(): string;
    function GetFreqStr(): string;
    function GetMemoStr(): string;
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
    property Invalid: Boolean read FInvalid write FInvalid;

    property SerialStr: string read GetSerialStr;
    property TimeStr: string read GetTimeStr;
    property DateStr: string read GetDateStr;
    property BandStr: string read GetBandStr;
    property ModeStr: string read GetModeStr;
    property Mode2Str: string read GetMode2Str;
    property PowerStr: string read GetPowerStr;
    property NewPowerStr: string read GetNewPowerStr;
    property PointStr: string read GetPointStr;
    property RSTStr: string read GetRSTStr;
    property RSTSentStr: string read GetRSTSentStr;
    property RSTRcvdStr: string read GetRSTRcvdStr;
    property FreqStr: string read GetFreqStr;
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

  TSortMethod = ( soCallsign = 0, soTime, soBand, soDupeCheck );

  TQSOList = class(TObjectList<TQSO>)
  private
    FCallsignComparer: TQSOCallsignComparer;
    FTimeComparer: TQSOTimeComparer;
    FBandComparer: TQSOBandComparer;
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
    FAllPhone: Boolean;    // True: SSB, FM, AM are same
    procedure Delete(i : Integer);
    procedure ProcessDelete(beforeQSO: TQSO);
    procedure ProcessEdit(afterQSO: TQSO; fAdd: Boolean);
    procedure ProcessInsert(afterQSO: TQSO);
    procedure ProcessLock(xQSO: TQSO);
    procedure ProcessUnlock(xQSO: TQSO);
    procedure SetScoreCoeff(E: Extended);
    function GetScoreCoeff(): Extended;
    function GetActualFreq(b: TBand; strFreq: string): string;
  public
    constructor Create(memo : string);
    destructor Destroy; override;

    function Year: Integer; //returns the year of the 1st qso
    function TotalQSO : Integer;
    function TotalPoints : Integer;
    function TotalCW : Integer;
    function TotalMulti1 : Integer;
    function TotalMulti2 : Integer;

    procedure Add(aQSO : TQSO);
    procedure Insert(i : Integer; aQSO : TQSO);

    procedure DeleteQSO(aQSO: TQSO);

    procedure Backup(Filename: string);


    procedure SaveToFile(Filename : string);
    procedure SaveToFileEx(Filename: string);
    procedure SaveToFilezLogDOSTXT(Filename : string);
    procedure SaveToFilezLogCsv(Filename: string);
    {$IFNDEF ZSERVER}
    procedure SaveToFilezLogALL(Filename : string);
    procedure SaveToFileByTX(Filename : string);
    procedure SaveToFileByCabrillo(Filename: string);
    procedure SaveToFileByHamlog(Filename: string; nRemarks1Option: Integer; nRemarks2Option: Integer; strRemarks1: string; strRemarks2: string);
    {$ENDIF}
    function IsDupe(aQSO : TQSO) : Integer;
    function IsDupe2(aQSO : TQSO; index : Integer; var dupeindex : Integer) : Boolean;
    procedure AddQue(aQSO : TQSO);
    procedure ProcessQue;
    procedure Clear2(); // deletes all QSOs without destroying the List. Keeps List[0] intact
    procedure SortByTime;
    function ContainBand : TBandBool;
    procedure SetDupeFlags;
//    procedure DeleteBand(B : TBand);
    function CheckQSOID(i : Integer) : Boolean;
    procedure RebuildDupeCheckList;
    procedure ClearDupeCheckList;
    function QuickDupe(aQSO : TQSO) : TQSO;
    procedure RemoveDupes;
    function OpQSO(OpName : string) : Integer;

    function IndexOf(aQSO: TQSO): Integer; overload;
    function ObjectOf(callsign: string): TQSO; overload;

    function LoadFromFile(filename: string): Integer;
    function LoadFromFileEx(filename: string): Integer;
    function LoadFromFilezLogCsv(Filename: string): Integer;
//    function MergeFile(filename: string): Integer;

    function IsWorked(strCallsign: string; band: TBand): Boolean;
    function IsNewMulti(band: TBand; multi: string): Boolean;
    procedure RenewMulti();
    {$IFNDEF ZSERVER}
    function IsOtherBandWorked(strCallsign: string; exclude_band: TBand; var workdmulti: string): Boolean;
    function EvaluateQSYCount(nStartIndex: Integer): Integer;
    {$ENDIF}

    property Saved: Boolean read FSaved write FSaved;
    property AcceptDifferentMode: Boolean read FAcceptDifferentMode write FAcceptDifferentMode;
    property CountHigherPoints: Boolean read FCountHigherPoints write FCountHigherPoints;
    property DifferentModePointer: Integer read FDifferentModePointer write FDifferentModePointer; //points to a qso on a different mode but not dupe

    property QsoList: TQSOList read FQsoList;
    property BandList: TQSOListArray read FBandList;

    property ScoreCoeff: Extended read GetScoreCoeff write SetScoreCoeff;

    property AllPhone: Boolean read FAllPhone write FAllPhone;
  end;

implementation

uses
  UzLogGlobal, UzLogExtension;

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
   if UseUTC then begin
      FTime := GetUTC();
   end
   else begin
      FTime := Now;
   end;
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
   i: Integer;
begin
   i := Self.FPower2;
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

   fFreq := StrToFloatDef(strFreq, 0);
   if fFreq = 0 then begin
      Result := Self.BandStr;
      Exit;
   end;

   // FreqがBandと違う場合はBandを返す
   b2 := dmZLogGlobal.BandPlan.FreqToBand(Trunc(fFreq) * 1000);
   if b2 <> Self.Band then begin
      Result := Self.BandStr;
      Exit;
   end;

   strFreq := Format('%.4f', [fFreq / 1000]);

   Result := strFreq;
end;

function TQSO.GetMemoStr(): string;
var
   strMemo: string;
begin
   strMemo := '';

   if FForced = True then begin
      strMemo := '*';
   end;

   if FDupe = True then begin
      if strMemo <> '' then begin
         strMemo := strMemo + ' ';
      end;

      strMemo := strMemo + MEMO_DUPE;
   end;

   if FFreq <> '' then begin
      if strMemo <> '' then begin
         strMemo := strMemo + ' ';
      end;

      strMemo := strMemo + '(' + FFreq + ')';
   end;

   strMemo := strMemo + FMemo;

   if FQsyViolation = True then begin
      if strMemo <> '' then begin
         strMemo := strMemo + ' ';
      end;
      strMemo := strMemo + MEMO_QSY_VIOLATION;
   end;

   Result := strMemo;
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

      mSSB, mFM, mAM: begin
         if IsAllPhone = True then begin
            if aQSO.FMode in [mSSB, mFM, mAM] then begin
               Result := True;
            end;
         end
         else begin
            if aQSO.Mode = mSSB then begin
               Result := True;
            end
            else if aQSO.Mode = mFM then begin
               Result := True;
            end
            else if aQSO.Mode = mAM then begin
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
   Mode2: array[mCW..mOther] of TMode = (mCW, mSSB, mSSB, mSSB, mRTTY, mOther );
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
end;

function TQSO.GetFileRecord(): TQSOData;
begin
   FillChar(Result, SizeOf(Result), #00);
   Result.Time       := FTime;
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
   Result.Reserve    := Byte(FReserve);
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
   FTime       := src.Time;
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
   Result.Time       := FTime;
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
   Result.Reserve    := Byte(FReserve);
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
end;

procedure TQSO.SetFileRecordEx(src: TQSODataEx);
begin
   FTime       := src.Time;
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
end;

{ TQSOList }

constructor TQSOList.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
   FCallsignComparer := TQSOCallsignComparer.Create();
   FTimeComparer := TQSOTimeComparer.Create();
   FBandComparer := TQSOBandComparer.Create();
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
begin
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
begin
   Inherited Create();

   // ADIF_FieldName := 'qth';

   FQsoList := TQSOList.Create();
   FQueList := TQSOList.Create();

   for B := b19 to HiBand do begin
      FDupeCheckList[B] := TQSOList.Create();
      FBandList[B] := TQSOList.Create(False);
   end;

   Q := TQSO.Create;
   Q.Callsign := '';
   Q.Memo := Memo;
   Q.Time := 0;
   Q.RSTSent := 0;
   Q.RSTRcvd := 0;
   FQsoList.Add(Q);

   for B := b19 to HiBand do begin
      FBandList[B].Add(Q);
   end;

   FSaved := True;
   FQueOK := True;
   FAcceptDifferentMode := False;
   FCountHigherPoints := False;
   FDifferentModePointer := 0;
   FAllPhone := True;
end;

destructor TLog.Destroy;
var
   B: TBand;
begin
   for B := b19 to HiBand do begin
      FDupeCheckList[B].Free();
      FBandList[B].Free();
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('QsoList=' + IntToStr(FQsoList.Count)));
   {$ENDIF}

   FQsoList.Free();
   FQueList.Free();

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

procedure TLog.SortByTime;
begin
   if TotalQSO < 2 then begin
      exit;
   end;

   FQSOList.Sort(soTime, FAcceptDifferentMode, FAllPhone);
end;

procedure TLog.Clear2();
var
   i: Integer;
begin
   For i := FQSOList.Count - 1 downto 1 do begin
      Delete(i);
   end;

   ClearDupeCheckList;
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

procedure TLog.Add(aQSO: TQSO);
var
   xQSO: TQSO;
begin
   FQsoList.Add(aQSO);

   xQSO := TQSO.Create;
   xQSO.Assign(aQSO);
   xQSO.Callsign := CoreCall(xQSO.Callsign);
   FDupeCheckList[xQSO.FBand].Add(xQSO);
   FDupeCheckList[xQSO.FBand].Sort(soDupeCheck, FAcceptDifferentMode, FAllPhone);

   FBandList[xQSO.Band].Add(aQSO);

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

   Index := FBandList[aQSO.Band].IndexOf(aQSO);
   if Index > -1 then begin
      FBandList[aQSO.Band].Delete(Index);
   end;

   FQsoList.Delete(i);

   FSaved := False;
   RebuildDupeCheckList;

   zyloLogUpdated(evDeleteQSO, aQSO, nil);
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

   Index := FQSOList.IndexOf(aQSO);
   if Index > -1 then begin
      FQsoList.Delete(Index);
   end;

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

function TLog.CheckQSOID(i: Integer): Boolean;
var
   j, id: Integer;
begin
   Result := False;
   id := i div 100; // last two digits are edit counter
   for j := 1 to TotalQSO do begin
      if id = (FQsoList[j].FReserve3 div 100) then begin
         Result := True;
         break;
      end;
   end;
end;

procedure TLog.Insert(i: Integer; aQSO: TQSO);
begin
   FQsoList.Insert(i, aQSO);
   RebuildDupeCheckList;
   FSaved := False;

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
      Write(f, D);
   end;

   CloseFile(f);

   FSaved := True;
end;

procedure TLog.SaveToFilezLogDOSTXT(Filename: string);
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
procedure TLog.SaveToFilezLogALL(Filename: string);
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

procedure TLog.SaveToFilezLogCsv(Filename: string);
const
   csvheader = '"Date","Time","TimeZone","CallSign","RSTSent","NrSent","RSTRcvd","NrRcvd","Serial","Mode",' +
               '"Band","Power","Multi1","Multi2","NewMulti1","NewMulti2","Points","Operator","Memo","CQ",' +
               '"Dupe","Reserve","TX","Power2","Reserve2","Reserve3","Freq","QsyViolation","PCName","QslState","Invalid"';
var
   F: TextFile;
   i: Integer;
   strText: string;
   Q: TQSO;
   offsetmin: Integer;
   slCsv: TStringList;
begin
   slCsv := TStringList.Create();
   slCsv.StrictDelimiter := True;
   slCsv.QuoteChar := #0;
   try
      AssignFile(F, Filename);
      ReWrite(F);

      offsetmin := FQsoList[0].RSTsent;

      WriteLn(F, csvheader);

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
         slCsv.Add('"' + Q.Callsign + '"');

         // 5列目 相手局へ送ったRST
         slCsv.Add('"' + Q.RSTSentStr + '"');

         // 6列目 相手局へ送ったNumber
         slCsv.Add('"' + Q.NrSent + '"');

         // 7列目 相手局からもらったレポート
         slCsv.Add('"' + Q.RSTRcvdStr + '"');

         // 8列目 相手局へ送ったNumber
         slCsv.Add('"' + Q.NrRcvd + '"');

         // 9列目 シリアルNO
         slCsv.Add(Q.SerialStr);

         // 10列目 Mode
         slCsv.Add('"' + Q.ModeStr + '"');

         // 11列目 Band
         slCsv.Add('"' + Q.BandStr + '"');

         // 1列目 Power
         slCsv.Add('"' + Q.NewPowerStr + '"');

         // 13列目 マルチ１
         slCsv.Add('"' + Q.Multi1 + '"');

         // 14列目 マルチ１
         slCsv.Add('"' + Q.Multi2 + '"');

         // 15列目 Newマルチ１
         slCsv.Add(BoolToStr(Q.NewMulti1, True));

         // 16列目 Newマルチ２
         slCsv.Add(BoolToStr(Q.NewMulti2, True));

         // 17列目 Points
         slCsv.Add(IntToStr(Q.Points));

         // 18列目 Operator
         slCsv.Add('"' + Q.Operator + '"');

         // 19列目 memo
         slCsv.Add('"' + Q.Memo + '"');

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
         slCsv.Add('"' + Q.Freq + '"');

         // 28列目 QsyViolation
         slCsv.Add(BoolToStr(Q.QsyViolation, True));

         // 29列目 PCName
         slCsv.Add('"' + Q.PCName + '"');

         // 30列目 Forced
         slCsv.Add(BoolToStr(Q.Forced, True));

         // 31列目 QslState
         slCsv.Add(IntToStr(Integer(Q.QslState)));

         // 32列目 Invalid
         slCsv.Add(BoolToStr(Q.Invalid, True));

         WriteLn(F, slCsv.DelimitedText);
      end;

      CloseFile(F);
   finally
      slCsv.Free();
   end;
end;

{$IFNDEF ZSERVER}
procedure TLog.SaveToFileByTX(Filename: string);
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
   f: Int64;
   b2: TBand;
const
   FREQ: array[b19..b10g] of string = (
   ' 1800', ' 3500', ' 7000', '10000', '14000', '18000', '21000', '24500',
   '28000', '   50', '  144', '  432', ' 1.2G', ' 2.3G', ' 5.7G', '  10G'
   );
begin
   // FreqがBandと一致しない場合はBandからActualを求める
   f := Trunc(StrToFloatDef(strFreq, 0)) * 1000;
   b2 := dmZLogGlobal.BandPlan.FreqToBand(f);
   if (f = 0) or (b <> b2) or (b > b28) then begin
      Result := FREQ[b];
      Exit;
   end;

   if strFreq = '' then begin
      Result := FREQ[b];
      Exit;
   end;

   s := strFreq;

   p := Pos('.', s);
   if p = 0 then begin
      Result := RightStr('     ' + s, 5);
      Exit;
   end;

   s := Copy(s, 1, p - 1);
   Result := RightStr('     ' + s, 5);
end;

// https://wwrof.org/cabrillo/
// https://wwrof.org/cabrillo/cabrillo-qso-data/
//                              --------info sent------- -------info rcvd--------
//QSO:  freq mo date       time call          rst exch   call          rst exch   t
//QSO: ***** ** yyyy-mm-dd nnnn ************* nnn ****** ************* nnn ****** n
//QSO:  3799 PH 1999-03-06 0711 HC8N           59 700    W1AW           59 CT     0
//QSO:  3799 PH 1999-03-06 0712 HC8N           59 700    N5KO           59 CA     0

{$IFNDEF ZSERVER}
procedure TLog.SaveToFileByCabrillo(Filename: string);
var
   F: TextFile;
   i: Integer;
   strText: string;
   Q: TQSO;
   utc: TDateTime;
   offhour: Integer;
   offsetmin: Integer;
begin
   AssignFile(F, Filename);
   ReWrite(F);

   WriteLn(F, 'START-OF-LOG: 3.0');
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

   offsetmin := FQsoList[0].RSTsent;
   if offsetmin = _USEUTC then begin
      offhour := 0;
   end
   else begin
      offhour := offsetmin div 60;
   end;

   for i := 1 to FQSOList.Count - 1 do begin
      Q := FQSOList[i];

      if Q.Invalid = True then begin
         strText := 'X-QSO: ';
      end
      else begin
         strText := 'QSO: ';
      end;

      strText := strText  + GetActualFreq(Q.Band, Q.Freq) + ' ';

      if Q.Mode = mCW then begin
         strText := strText + 'CW ';
      end
      else if Q.Mode = mSSB then begin
         strText := strText + 'PH ';
      end
      else if Q.Mode = mFM then begin
         strText := strText + 'FM ';
      end
      else if Q.Mode = mRTTY then begin
         strText := strText + 'RY ';
      end
      else begin
         strText := strText + '   ';
      end;

      utc := IncHour(Q.Time, offhour);
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
procedure TLog.SaveToFileByHamlog(Filename: string; nRemarks1Option: Integer; nRemarks2Option: Integer; strRemarks1: string; strRemarks2: string);
var
   F: TextFile;
   i: Integer;
   strText: string;
   Q: TQSO;
   offsetmin: Integer;
   slCsv: TStringList;
begin
   slCsv := TStringList.Create();
   slCsv.StrictDelimiter := True;
   try
      AssignFile(F, Filename);
      ReWrite(F);

      offsetmin := FQsoList[0].RSTsent;

      for i := 1 to FQSOList.Count - 1 do begin
         Q := FQSOList[i];

         slCsv.Clear();

         //1列目　コールサイン
         slCsv.Add(Q.Callsign);

         //2列目　交信年月日（YY/MM/DD）　※「YYYY/MM/DD」でもOKだった記憶
         slCsv.Add(FormatDateTime('yyyy/mm/dd', Q.Time));

         //3列目　交信時分（HH:MM*）　※「*」にはJST…J・UTC…U
         strText := FormatDateTime('HH:MM', Q.Time);
         if offsetmin = _USEUTC then begin
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

         //6列目　周波数
         slCsv.Add(Q.FreqStr);

         //7列目　電波型式
         slCsv.Add(Q.ModeStr);

         //8列目　相手局の運用地コード
         slCsv.Add('');

         //9列目　相手局の運用地グリッドロケータ
         slCsv.Add('');

         //10列目　QSLマーク　※取りあえず「J」を入れておけばOK
         if Q.QslState = qsPseQsl then begin
            slCsv.Add('J  ');
         end
         else begin
            slCsv.Add('N  ');
         end;

         //11列目　相手局の名前・名称
         slCsv.Add('');

         //12列目　相手局の運用地
         slCsv.Add('');

         //13列目　Remarks1
         case nRemarks1Option of
            0: begin
               slCsv.Add(strRemarks1);
            end;

            1: begin
               slCsv.Add(Q.Operator);
            end;

            2: begin
               slCsv.Add(Q.Memo);
            end;

            else begin
               slCsv.Add('');
            end;
         end;

         //14列目　Remarks2
         case nRemarks2Option of
            0: begin
               slCsv.Add(strRemarks2);
            end;

            1: begin
               slCsv.Add(Q.Operator);
            end;

            2: begin
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
      Q.Callsign := CoreCall(Q.Callsign);
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
      if (aQSO.FBand = FQsoList[i].Band) and (str = CoreCall(FQsoList[i].CallSign)) then begin
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
      // 同一QSOは除く
      if FQsoList[i].SameQSOID(aQSO) = True then begin
         Continue;
      end;

      if (aQSO.FBand = FQsoList[i].Band) and (str = CoreCall(FQsoList[i].CallSign)) then begin
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
   i, j: Integer;
   str: string;
   aQSO: TQSO;
   TempList: array [ord('A') .. ord('Z')] of TStringList;
   ch: Char;
   core: string;
   vQSO: TQSO;
   Diff: Integer;
   fQsyViolation: Boolean;
   nQsyCount: Integer;
begin
   if TotalQSO = 0 then
      exit;

   for i := ord('A') to ord('Z') do begin
      TempList[i] := TStringList.Create;
      TempList[i].Sorted := True;
      TempList[i].Capacity := 200;
   end;

   vQSO := nil;
   for i := 1 to TotalQSO do begin
      aQSO := FQsoList[i];
      core := CoreCall(aQSO.CallSign);

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

      if core = '' then
         ch := 'Z'
      else
         ch := core[length(core)];

      if not CharInSet(ch, ['A' .. 'Z']) then
         ch := 'Z';

      if TempList[ord(ch)].Find(str, j) = True then begin
         SetDupeQSO(aQSO);
      end
      else begin
         ResetDupeQSO(aQSO);
         TempList[ord(ch)].Add(str);
      end;

      {$IFNDEF ZSERVER}
      // QSY violation check
      fQsyViolation := False;

      // 今回と前回のバンドが違っている場合、
      if dmZlogGlobal.Settings._countdown then begin
         if (vQSO <> nil) and (vQSO.TX = aQSO.TX) and (vQSO.Band <> aQSO.Band) then begin
            // 設定値以内のQSYならviolation
            Diff := SecondsBetween(aQSO.Time, vQSO.Time);
            if (Diff / 60) <= dmZLogGlobal.Settings._countdownminute then begin
               fQsyViolation := True;
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

      vQSO := aQSO;

      aQSO.QsyViolation := fQsyViolation;
      {$ENDIF}
   end;

   for i := ord('A') to ord('Z') do begin
      TempList[i].Clear;
      TempList[i].Free;
   end;
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


function TLog.LoadFromFile(filename: string): Integer;
var
   Q: TQSO;
   D: TQSOData;
   f: file of TQSOData;
   i: Integer;
begin
   if UpperCase(ExtractFileExt(filename)) = '.ZLOX' then begin
      Result := LoadFromFileEx(filename);
      Exit;
   end;

   AssignFile(f, filename);
   Reset(f);
   Read(f, D);

   Q := nil;
   GLOBALSERIAL := 0;

   for i := 1 to FileSize(f) - 1 do begin
      Read(f, D);

      Q := TQSO.Create();
      Q.FileRecord := D;

      if Q.Reserve3 = 0 then begin
         Q.Reserve3 := dmZLogGlobal.NewQSOID;
      end;

      // 同一QSOが２重に入ってしまった場合の暫定対策
      if IndexOf(Q) = -1 then begin
         Add(Q);
      end
      else begin
         FreeAndNil(Q);
      end;
   end;

   if Q <> nil then begin
      GLOBALSERIAL := (Q.Reserve3 div 10000) mod 10000;
   end;

   CloseFile(f);

   Result := FQsoList.Count;
end;

function TLog.LoadFromFileEx(filename: string): Integer;
var
   Q: TQSO;
   D: TQSODataEx;
   f: file of TQSODataEx;
   i: Integer;
begin
   AssignFile(f, filename);
   Reset(f);
   Read(f, D);

   Q := nil;
   GLOBALSERIAL := 0;

   for i := 1 to FileSize(f) - 1 do begin
      Read(f, D);

      Q := TQSO.Create();
      Q.FileRecordEx := D;

      if Q.Reserve3 = 0 then begin
         Q.Reserve3 := dmZLogGlobal.NewQSOID;
      end;

      // 同一QSOが２重に入ってしまった場合の暫定対策
      if IndexOf(Q) = -1 then begin
         Add(Q);
      end
      else begin
         FreeAndNil(Q);
      end;
   end;

   if Q <> nil then begin
      GLOBALSERIAL := (Q.Reserve3 div 10000) mod 10000;
   end;

   CloseFile(f);

   Result := FQsoList.Count;
end;

function TLog.LoadFromFilezLogCsv(Filename: string): Integer;
var
   i: Integer;
   Q: TQSO;
   offsetmin: Integer;
   slFile: TStringList;
   slLine: TStringList;
   strMsg: string;
   Index: Integer;
begin
   slFile := TStringList.Create();
   slFile.StrictDelimiter := True;
   slLine := TStringList.Create();
   slLine.StrictDelimiter := True;
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
            slLine.CommaText := slFile.Strings[i] + DupeString(',', 32);

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
            Q.Memo := slLine[18];

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

            if Q.Reserve3 = 0 then begin
               Q.Reserve3 := dmZLogGlobal.NewQSOID;
            end;

            Index := IndexOf(Q);
            if Index = -1 then begin
               Add(Q);
            end
            else begin
               FQsoList[Index].Assign(Q);
               FreeAndNil(Q);
            end;
         end;
      except
         on E: Exception do begin
            strMsg := IntToStr(i) + '行目でデータ取り込みエラーが発生しました' + #13#10 + E.Message;
            MessageBox(0, PChar(strMsg), PChar(Application.Title), MB_OK + MB_ICONEXCLAMATION);
         end;
      end;

      Result := FQsoList.Count;
   finally
      slFile.Free();
      slLine.Free();
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

      if FDupeCheckList[band].DupeCheck(Q, FAcceptDifferentMode, FAllPhone) <> nil then begin
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

{$IFNDEF ZSERVER}
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

         R := FDupeCheckList[b].DupeCheck(Q, FAcceptDifferentMode, FAllPhone);
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
      Saved := False;
   end;
end;

{$IFNDEF ZSERVER}
function TLog.EvaluateQSYCount(nStartIndex: Integer): Integer;
var
   nQsyCount: Integer;
   aQSO: TQSO;
   bQSO: TQSO;
   i: Integer;
   Diff: Integer;
begin
   if dmZlogGlobal.Settings._qsycount = False then begin
      Result := 0;
      Exit;
   end;

   nQsyCount := 0;
   aQSO := FQsoList[nStartIndex];

   for i := nStartIndex - 1 downto 1 do begin
      bQSO := FQsoList[i];

      // 時間差が1hourあるか
      Diff := SecondsBetween(aQSO.Time, bQSO.Time);
      if (Diff / 60) > 60 then begin
         Break;
      end;

      // TXが同じでバンドが違えばカウント
      if (aQSO.TX = bQSO.TX) and (aQSO.Band <> bQSO.Band) then begin
         Inc(nQsyCount);
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

{ TQSOCallsignComparer }

function TQSOCallsignComparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := CompareText(Left.Callsign, Right.Callsign);
end;

{ TQSOTimeComparer }

function TQSOTimeComparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := CompareDateTime(Left.Time, Right.Time);
end;

{ TQSOBandComparer }

function TQSOBandComparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := Integer(Left.Band) - Integer(Right.Band);
end;

{ TQSODupeWithoutModeComparer }

function TQSODupeWithoutModeComparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := CompareText(Left.Callsign, Right.Callsign) +
             ((Integer(Left.Band) - Integer(Right.Band)) * 10);
end;

{ TQSODupeWithModeComparer }

function TQSODupeWithModeComparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := CompareText(Left.Callsign, Right.Callsign) +
             ((Integer(Left.Band) - Integer(Right.Band)) * 10) +
             ((Integer(Left.Mode) - Integer(Right.Mode)) * 100);
end;

{ TQSODupeWithMode2Comparer }

function TQSODupeWithMode2Comparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := CompareText(Left.Callsign, Right.Callsign) +
             ((Integer(Left.Band) - Integer(Right.Band)) * 10) +
             ((Integer(Left.Mode2) - Integer(Right.Mode2)) * 100);
end;

end.
