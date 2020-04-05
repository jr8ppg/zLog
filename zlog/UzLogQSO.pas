unit UzLogQSO;

interface

uses
  System.SysUtils, System.Classes, StrUtils, IniFiles, Forms, Windows, Menus,
  Generics.Collections, Generics.Defaults,
  UzlogConst;

type
  TQSOData = record
    Time : TDateTime;
    CallSign : string[12];  {13 bytes}
    NrSent : string[30];
    NrRcvd : string[30];
    RSTSent : Smallint;//word;  {2 bytes}
    RSTRcvd : word;
    Serial : Integer;  {4 bytes ?}
    Mode : TMode;  {1 byte}
    Band : TBand;  {1 byte}
    Power : TPower; {1 byte}
    Multi1 : string[30];
    Multi2 : string[30];
    NewMulti1 : Boolean;
    NewMulti2 : Boolean;
    Points : byte;
    Operator : string[14]; {Operator's name}
    Memo : string[64]; {max 64 char = 65 bytes}
    CQ : Boolean; {not used yet}
    Dupe : Boolean;
    Reserve : byte; {used for z-link commands}
    TX : byte; {Transmitter number for 2 TX category}
    Power2 : Integer; {used by ARRL DX side only}
    Reserve2 : Integer; { $FF when forcing to log}
    Reserve3 : Integer; {QSO ID#}
                        {TTSSSSRRCC   TT:TX#(00-21) SSSS:Serial counter
                                      RR:Random(00-99) CC:Edit counter 00 and up}
  end;

  TQSO = class
  private
    FTime : TDateTime;
    FCallSign : string[12];  {13 bytes}
    FNrSent : string[30];
    FNrRcvd : string[30];
    FRSTSent : Smallint;//word;  {2 bytes}
    FRSTRcvd : word;
    FSerial : Integer;  {4 bytes ?}
    FMode : TMode;  {1 byte}
    FBand : TBand;  {1 byte}
    FPower : TPower; {1 byte}
    FMulti1 : string[30];
    FMulti2 : string[30];
    FNewMulti1 : Boolean;
    FNewMulti2 : Boolean;
    FPoints : byte;
    FOperator : string[14]; {Operator's name}
    FMemo : string[64]; {max 64 char = 65 bytes}
    FCQ : Boolean; {not used yet}
    FDupe : Boolean;
    FReserve : byte; {used for z-link commands}
    FTX : byte; {Transmitter number for 2 TX category}
    FPower2 : Integer; {used by ARRL DX side only}
    FReserve2 : Integer; { $FF when forcing to log}
    FReserve3 : Integer; {QSO ID#}
                         {TTSSSSRRCC   TT:TX#(00-21) SSSS:Serial counter
                                      RR:Random(00-99) CC:Edit counter 00 and up}
    function GetCallsign(): string;
    procedure SetCallsign(v: string);
    function GetNrSent(): string;
    procedure SetNrSent(v: string);
    function GetNrRcvd(): string;
    procedure SetNrRcvd(v: string);
    function GetRSTSent(): Integer;
    procedure SetRSTSent(v: Integer);
    function GetRSTRcvd(): Integer;
    procedure SetRSTRcvd(v: Integer);
    function GetMulti1(): string;
    procedure SetMulti1(v: string);
    function GetMulti2(): string;
    procedure SetMulti2(v: string);
    function GetPoints(): Integer;
    procedure SetPoints(v: Integer);
    function GetOperator(): string;
    procedure SetOperator(v: string);
    function GetMemo(): string;
    procedure SetMemo(v: string);
    function GetReserve(): Integer;
    procedure SetReserve(v: Integer);
    function GetTX(): Integer;
    procedure SetTX(v: Integer);

    function GetFileRecord(): TQSOData;
    procedure SetFileRecord(src: TQSOData);
  public
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
    function PartialSummary(DispDate: Boolean) : string;
    function CheckCallSummary : string;
    procedure UpdateTime;
    function zLogALL : string;
    function DOSzLogText : string;
    function DOSzLogTextShort : string;
    function QSOinText : string; {for data transfer}
    procedure TextToQSO(str : string); {convert text to bin}
    function QTCStr : string;

    function SameQSO(aQSO: TQSO) : Boolean;
    function SameQSOID(aQSO: TQSO) : Boolean;
    function SameMode(aQSO: TQSO): Boolean;
    function SameMode2(aMode: TMode) : Boolean;

    procedure Assign(src: TQSO);

    property Time: TDateTime read FTime write FTime;
    property Callsign: string read GetCallsign write SetCallsign;
    property NrSent: string read GetNrSent write SetNrSent;
    property NrRcvd: string read GetNrRcvd write SetNrRcvd;
    property RSTSent: Integer read GetRSTSent write SetRSTSent;
    property RSTRcvd: Integer read GetRSTRcvd write SetRSTRcvd;
    property Serial: Integer read FSerial write FSerial;
    property Mode: TMode read FMode write FMode;
    property Band: TBand read FBand write FBand;
    property Power: TPower read FPower write FPower;
    property Multi1: string read GetMulti1 write SetMulti1;
    property Multi2: string read GetMulti2 write SetMulti2;
    property NewMulti1: Boolean read FNewMulti1 write FNewMulti1;
    property NewMulti2: Boolean read FNewMulti2 write FNewMulti2;
    property Points: Integer read GetPoints write SetPoints;
    property Operator: string read GetOperator write SetOperator;
    property Memo: string read GetMemo write SetMemo;
    property CQ: Boolean read FCQ write FCQ;
    property Dupe: Boolean read FDupe write FDupe;
    property Reserve: Integer read GetReserve write SetReserve;
    property TX: Integer read GetTX write SetTX;
    property Power2: Integer read FPower2 write FPower2;
    property Reserve2: Integer read FReserve2 write FReserve2;
    property Reserve3: Integer read FReserve3 write FReserve3;

    property FileRecord: TQSOData read GetFileRecord write SetFileRecord;
  end;

  TQSOList = class(TObjectList<TQSO>)
  private
    FSaved : Boolean;
    FQueList : TList;
    FQueOK : Boolean;
    FAcceptDifferentMode : Boolean;
    FCountHigherPoints : Boolean;
    FDifferentModePointer : Integer; //points to a qso on a different mode but not dupe
    FDupeCheckList : array[b19..HiBand] of TStringList;
  public
    constructor Create(memo : string; OwnsObjects: Boolean = True);
    destructor Destroy; override;

    function Year: Integer; //returns the year of the 1st qso
    function TotalQSO : Integer;
    function TotalPoints : Integer;
    function TotalCW : Integer;
    function TotalMulti1 : Integer;
    function TotalMulti2 : Integer;

    procedure Add(aQSO : TQSO);
    procedure Delete(i : Integer);
    procedure Insert(i : Integer; aQSO : TQSO);
    procedure SaveToFile(Filename : string);
    procedure SaveToFilezLogDOSTXT(Filename : string);
    procedure SaveToFilezLogALL(Filename : string);
    procedure SaveToFileByTX(Filename : string);
    function IsDupe(aQSO : TQSO) : Integer;
    function IsDupe2(aQSO : TQSO; index : Integer; var dupeindex : Integer) : Boolean;
    procedure AddQue(aQSO : TQSO);
    procedure ProcessQue;
    procedure Clear; // deletes all QSOs without destroying the List. Keeps List[0] intact
    procedure SortByTime;
    function ContainBand : TBandBool;
    procedure SetDupeFlags;
    procedure DeleteBand(B : TBand);
    function CheckQSOID(i : Integer) : Boolean;
    procedure RebuildDupeCheckList;
    procedure ClearDupeCheckList;
    function QuickDupe(aQSO : TQSO) : TQSO;
    procedure RemoveDupes;
    function OpQSO(OpName : string) : Integer;

    function IndexOf(aQSO: TQSO): Integer; overload;
    function ObjectOf(callsign: string): TQSO; overload;

    function LoadFromFile(filename: string): Integer;
    function MergeFile(filename: string): Integer;

    property Saved: Boolean read FSaved write FSaved;
    property AcceptDifferentMode: Boolean read FAcceptDifferentMode write FAcceptDifferentMode;
    property CountHigherPoints: Boolean read FCountHigherPoints write FCountHigherPoints;
    property DifferentModePointer: Integer read FDifferentModePointer write FDifferentModePointer; //points to a qso on a different mode but not dupe
  end;

implementation

uses
  UzLogGlobal;

{ TQSO }

constructor TQSO.Create;
begin
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
   str: string;
begin
   str := 'ZLOGQSODATA:' + _sep;
   // str := str + DateTimeToStr(QSO.Time) + _sep;
   str := str + FloatToStr(Time) + _sep;
   str := str + CallSign + _sep;
   str := str + NrSent + _sep;
   str := str + NrRcvd + _sep;
   str := str + IntToStr(RSTSent) + _sep;
   str := str + IntToStr(RSTRcvd) + _sep;
   str := str + IntToStr(Serial) + _sep;
   str := str + IntToStr(ord(Mode)) + _sep;
   str := str + IntToStr(ord(Band)) + _sep;
   str := str + IntToStr(ord(Power)) + _sep;
   str := str + Multi1 + _sep;
   str := str + Multi2 + _sep;

   if NewMulti1 then
      str := str + '1' + _sep
   else
      str := str + '0' + _sep;

   if NewMulti2 then
      str := str + '1' + _sep
   else
      str := str + '0' + _sep;

   str := str + IntToStr(Points) + _sep;
   str := str + Operator + _sep;
   str := str + Memo + _sep;

   if CQ then
      str := str + '1' + _sep
   else
      str := str + '0' + _sep;

   if Dupe then
      str := str + '1' + _sep
   else
      str := str + '0' + _sep;

   str := str + IntToStr(Reserve) + _sep;
   str := str + IntToStr(TX) + _sep;
   str := str + IntToStr(Power2) + _sep;
   str := str + IntToStr(Reserve2) + _sep;
   str := str + IntToStr(Reserve3);

   Result := str;
end;

procedure TQSO.TextToQSO(str: string); { convert text to bin }
var
   _Items: array [0 .. 25] of string;
   i, j: Integer;
begin
   for i := 0 to 25 do begin
      _Items[i] := '';
   end;

   j := 0;
   for i := 1 to length(str) do begin
      if str[i] = _sep then
         inc(j)
      else
         _Items[j] := _Items[j] + str[i];
   end;

   if _Items[0] <> 'ZLOGQSODATA:' then begin
      exit;
   end;

   // QSO.Time := StrToDateTime(_Items[1]);
   try
      Time := StrToFloat(_Items[1]);
      CallSign := _Items[2];
      NrSent := _Items[3];
      NrRcvd := _Items[4];
      RSTSent := StrToInt(_Items[5]);
      RSTRcvd := StrToInt(_Items[6]);
      Serial := StrToInt(_Items[7]);
      Mode := TMode(StrToInt(_Items[8]));
      Band := TBand(StrToInt(_Items[9]));
      Power := TPower(StrToInt(_Items[10]));
      Multi1 := _Items[11];
      Multi2 := _Items[12];
      NewMulti1 := StrToInt(_Items[13]) = 1;
      NewMulti2 := StrToInt(_Items[14]) = 1;
      Points := StrToInt(_Items[15]);
      Operator := _Items[16];
      Memo := _Items[17];
      CQ := StrToInt(_Items[18]) = 1;
      Dupe := StrToInt(_Items[19]) = 1;
      Reserve := StrToInt(_Items[20]);
      TX := StrToInt(_Items[21]);
      Power2 := StrToInt(_Items[22]);
      Reserve2 := StrToInt(_Items[23]);
      Reserve3 := StrToInt(_Items[24]);
   except
      on EConvertError do begin
         FMemo := 'Convert Error!';
      end;
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

function TQSO.SerialStr: string;
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

function TQSO.TimeStr: string;
begin
   Result := FormatDateTime('hh:nn', Self.Time);
end;

function TQSO.DateStr: string;
begin
   Result := FormatDateTime('yy/mm/dd', Self.Time);
end;

function TQSO.BandStr: string;
begin
   Result := MHzString[Self.FBand];
end;

function TQSO.ModeStr: string;
begin
   Result := ModeString[Self.FMode];
end;

function TQSO.PowerStr: string;
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

function TQSO.NewPowerStr: string;
begin
   Result := NewPowerString[Self.FPower];
end;

function TQSO.PointStr: string;
begin
   Result := IntToStr(Self.FPoints);
end;

function TQSO.RSTStr: string;
begin
   Result := IntToStr(Self.FRSTRcvd);
end;

function TQSO.RSTSentStr: string;
begin
   Result := IntToStr(Self.FRSTSent);
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
   S := S + FillRight(Self.CallSign, 12);
   S := S + FillRight(Self.NrRcvd, 15);
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
   S := S + FillRight(Self.CallSign, 12);
   S := S + FillRight(Self.NrRcvd, 15);
   S := S + FillRight(ModeStr, 5);
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

   S := S + Self.Memo;

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

   S := S + '  ' + Self.Memo;

   Result := S;
end;

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

   if dmZlogGlobal.MultiOp > 0 then begin
      S := S + FillRight('TX#' + IntToStr(Self.TX), 6);
   end;

   S := S + Self.Memo;
   Result := S;
end;

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

function TQSO.SameQSOID(aQSO: TQSO): Boolean;
begin
   if (aQSO.FReserve3 div 100) = (Self.FReserve3 div 100) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

function TQSO.SameMode(aQSO: TQSO): Boolean;
begin
   Result := False;
   case Self.FMode of
      mCW: begin
         if aQSO.FMode = mCW then begin
            Result := True;
         end;
      end;

      mSSB, mFM, mAM: begin
         if aQSO.FMode in [mSSB, mFM, mAM] then begin
            Result := True;
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
end;

function TQSO.GetCallsign(): string;
begin
   Result := string(FCallsign);
end;

procedure TQSO.SetCallsign(v: string);
begin
   FCallsign := ShortString(v);
end;

function TQSO.GetNrSent(): string;
begin
   Result := string(FNrSent);
end;

procedure TQSO.SetNrSent(v: string);
begin
   FNrSent := ShortString(v);
end;

function TQSO.GetNrRcvd(): string;
begin
   Result := string(FNrRcvd);
end;

procedure TQSO.SetNrRcvd(v: string);
begin
   FNrRcvd := ShortString(v);
end;

function TQSO.GetRSTSent(): Integer;
begin
   Result := Integer(FRSTSent);
end;

procedure TQSO.SetRSTSent(v: Integer);
begin
   FRSTSent := SmallInt(v);
end;

function TQSO.GetRSTRcvd(): Integer;
begin
   Result := Integer(FRSTRcvd);
end;

procedure TQSO.SetRSTRcvd(v: Integer);
begin
   FRSTRcvd := Word(v);
end;

function TQSO.GetMulti1(): string;
begin
   Result := string(FMulti1);
end;

procedure TQSO.SetMulti1(v: string);
begin
   FMulti1 := ShortString(v);
end;

function TQSO.GetMulti2(): string;
begin
   Result := string(FMulti2);
end;

procedure TQSO.SetMulti2(v: string);
begin
   FMulti2 := ShortString(v);
end;

function TQSO.GetPoints(): Integer;
begin
   Result := Integer(FPoints);
end;

procedure TQSO.SetPoints(v: Integer);
begin
   FPoints := Byte(v);
end;

function TQSO.GetOperator(): string;
begin
   Result := string(FOperator);
end;

procedure TQSO.SetOperator(v: string);
begin
   FOperator := ShortString(v);
end;

function TQSO.GetMemo(): string;
begin
   Result := string(FMemo);
end;

procedure TQSO.SetMemo(v: string);
begin
   FMemo := ShortString(v);
end;

function TQSO.GetReserve(): Integer;
begin
   Result := Integer(FReserve);
end;

procedure TQSO.SetReserve(v: Integer);
begin
   FReserve := Byte(v);
end;

function TQSO.GetTX(): Integer;
begin
   Result := Integer(FTX);
end;

procedure TQSO.SetTX(v: Integer);
begin
   FTX := Byte(v);
end;

function TQSO.GetFileRecord(): TQSOData;
begin
   Result.Time := FTime;
   Result.CallSign := FCallSign;
   Result.NrSent := FNrSent;
   Result.NrRcvd := FNrRcvd;
   Result.RSTSent := FRSTSent;
   Result.RSTRcvd := FRSTRcvd;
   Result.Serial := FSerial;
   Result.Mode := FMode;
   Result.Band := FBand;
   Result.Power := FPower;
   Result.Multi1 := FMulti1;
   Result.Multi2 := FMulti2;
   Result.NewMulti1 := FNewMulti1;
   Result.NewMulti2 := FNewMulti2;
   Result.Points := FPoints;
   Result.Operator := FOperator;
   Result.Memo := FMemo;
   Result.CQ := FCQ;
   Result.Dupe := FDupe;
   Result.Reserve := FReserve;
   Result.TX := FTX;
   Result.Power2 := FPower2;
   Result.Reserve2 := FReserve2;
   Result.Reserve3 := FReserve3;
end;

procedure TQSO.SetFileRecord(src: TQSOData);
begin
   FTime := src.Time;
   FCallSign := src.CallSign;
   FNrSent := src.NrSent;
   FNrRcvd := src.NrRcvd;
   FRSTSent := src.RSTSent;
   FRSTRcvd := src.RSTRcvd;
   FSerial := src.Serial;
   FMode := src.Mode;
   FBand := src.Band;
   FPower := src.Power;
   FMulti1 := src.Multi1;
   FMulti2 := src.Multi2;
   FNewMulti1 := src.NewMulti1;
   FNewMulti2 := src.NewMulti2;
   FPoints := src.Points;
   FOperator := src.Operator;
   FMemo := src.Memo;
   FCQ := src.CQ;
   FDupe := src.Dupe;
   FReserve := src.Reserve;
   FTX := src.TX;
   FPower2 := src.Power2;
   FReserve2 := src.Reserve2;
   FReserve3 := src.Reserve3;
end;

{ TQSOList }

constructor TQSOList.Create(Memo: string; OwnsObjects: Boolean);
var
   Q: TQSO;
   B: TBand;
begin
   Inherited Create(OwnsObjects);

   // ADIF_FieldName := 'qth';
   FQueList := TList.Create;

   for B := b19 to HiBand do begin
      FDupeCheckList[B] := TStringList.Create;
      FDupeCheckList[B].Sorted := True;
      FDupeCheckList[B].Duplicates := dupAccept;
   end;

   Q := TQSO.Create;
   Q.Memo := Memo;
   Q.Time := 1.0000;
   Q.Time := -1;
   Q.RSTSent := 0;
   Add(Q);

   FSaved := True;
   FQueOK := True;
   FAcceptDifferentMode := False;
   FCountHigherPoints := False;
   FDifferentModePointer := 0;
end;

function TQSOList.ContainBand: TBandBool;
var
   R: TBandBool;
   B: TBand;
   i: Integer;
begin
   for B := b19 to HiBand do begin
      R[B] := False;
   end;

   for i := 1 to TotalQSO do begin
      R[TQSO(List[i]).FBand] := True;
   end;

   Result := R;
end;

function TQSOList.Year: Integer;
var
   T: TDateTime;
   y, M, d: word;
begin
   Result := 0;
   if TotalQSO > 0 then
      T := TQSO(List[1]).FTime
   else
      exit;

   DecodeDate(T, y, M, d);
   Result := y;
end;

procedure TQSOList.SortByTime;
var
   i: Integer;
   boo: Boolean;
begin
   if TotalQSO < 2 then
      exit;

   boo := True;
   while boo do begin
      boo := False;
      for i := 1 to TotalQSO - 1 do
         if TQSO(List[i]).FTime > TQSO(List[i + 1]).FTime then begin
            Exchange(i, i + 1);
            boo := True;
         end;
   end;
end;

procedure TQSOList.Clear;
var
   i, max: Integer;
   aQSO: TQSO;
begin
   max := Count - 1;
   For i := 1 to max do begin
      aQSO := List[1];
      aQSO.Free;
      Delete(1);
   end;

   Pack;
   ClearDupeCheckList;
   FSaved := False;
end;

procedure TQSOList.ClearDupeCheckList;
var
   B: TBand;
begin
   for B := b19 to HiBand do begin
      FDupeCheckList[B].Clear;
   end;
end;

procedure TQSOList.Add(aQSO: TQSO);
var
   xQSO: TQSO;
begin
   Inherited Add(aQSO);

   xQSO := TQSO.Create;
   xQSO.Assign(aQSO);

   FDupeCheckList[xQSO.FBand].AddObject(CoreCall(xQSO.CallSign), xQSO);

   FSaved := False;
end;

procedure TQSOList.AddQue(aQSO: TQSO);
var
   xQSO: TQSO;
begin
   xQSO := TQSO.Create;
   xQSO.Assign(aQSO);
   // xQSO.QSO.Reserve := actAdd;
   FQueList.Add(xQSO);
   FSaved := False;
end;

procedure TQSOList.ProcessQue;
var
   xQSO, yQSO, zQSO, wQSO: TQSO;
   i, id: Integer;
begin
   if FQueList.Count = 0 then begin
      exit;
   end;

   Repeat
   until FQueOK;

   while FQueList.Count > 0 do begin

      xQSO := TQSO(FQueList[0]);

      case xQSO.FReserve of
         actAdd: begin
            Add(xQSO);
         end;

         actDelete: begin
               for i := 1 to TotalQSO do begin
                  yQSO := TQSO(List[i]);
                  if xQSO.SameQSOID(yQSO) then begin
                     Self.Delete(i);
                     break;
                  end;
               end;
         end;

         actEdit: begin
            for i := 1 to TotalQSO do begin
               yQSO := TQSO(List[i]);
               if xQSO.SameQSOID(yQSO) then begin
                  // TQSO(List[i]).QSO := xQSO.QSO;
                  yQSO.Assign(xQSO);
                  RebuildDupeCheckList;
                  break;
               end;
            end;
         end;

         actInsert: begin
            for i := 1 to TotalQSO do begin
               yQSO := TQSO(List[i]);
               id := xQSO.FReserve2 div 100;
               if id = (yQSO.FReserve3 div 100) then begin
                  wQSO := TQSO.Create;
                  wQSO.Assign(xQSO);
                  Insert(i, wQSO);
                  break;
               end;
            end;
         end;

         actLock: begin
            for i := 1 to TotalQSO do begin
               zQSO := TQSO(List[i]);
               if xQSO.SameQSOID(zQSO) then begin
                  TQSO(List[i]).FReserve := actLock;
                  break;
               end;
            end;
         end;

         actUnlock: begin
            for i := 1 to TotalQSO do begin
               zQSO := TQSO(List[i]);
               if xQSO.SameQSOID(zQSO) then begin
                  TQSO(List[i]).FReserve := 0;
                  break;
               end;
            end;
         end;
      end;

      TQSO(FQueList[0]).Free; // added 0.23
      FQueList.Delete(0);
      FQueList.Pack;
   end;

   FSaved := False;
end;

procedure TQSOList.Delete(i: Integer);
var
   aQSO: TQSO;
begin
   if i <= TotalQSO then begin
      aQSO := TQSO(List[i]);
      aQSO.Free;
      Delete(i);
      Pack;

      FSaved := False;
      RebuildDupeCheckList;
   end;
end;

procedure TQSOList.RemoveDupes;
var
   i: Integer;
   aQSO: TQSO;
begin
   for i := 1 to TotalQSO do begin
      aQSO := Items[i];
      if Pos('-DUPE-', aQSO.Memo) > 0 then begin
         Delete(i);
         aQSO.Free;
      end;
   end;
   Pack;

   FSaved := False;
   RebuildDupeCheckList;
end;

procedure TQSOList.DeleteBand(B: TBand);
var
   i: Integer;
begin
   for i := 1 to TotalQSO do begin
      if TQSO(List[i]).FBand = B then begin
         TQSO(List[i]).Free;
         List[i] := nil;
         FSaved := False;
      end;
   end;

   RebuildDupeCheckList;
   Pack;
end;

function TQSOList.CheckQSOID(i: Integer): Boolean;
var
   j, id: Integer;
begin
   Result := False;
   id := i div 100; // last two digits are edit counter
   for j := 1 to TotalQSO do begin
      if id = (TQSO(List[j]).FReserve3 div 100) then begin
         Result := True;
         break;
      end;
   end;
end;

procedure TQSOList.Insert(i: Integer; aQSO: TQSO);
begin
   Insert(i, aQSO);
   RebuildDupeCheckList;
   FSaved := False;
end;

procedure TQSOList.SaveToFile(Filename: string);
var
   D: TQSOData;
   f: file of TQSOData;
   i: Integer;
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
      D := Items[i].FileRecord;
      Write(f, D);
   end;

   CloseFile(f);

   FSaved := True;
end;

procedure TQSOList.SaveToFilezLogDOSTXT(Filename: string);
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
      j := length(TQSO(List[i]).FNrRcvd);
      if j > max then begin
         max := j;
      end;

      j := length(TQSO(List[i]).FNrSent);
      if j > max then begin
         max := j;
      end;
   end;

   if j >= 10 then begin
      writeln(f, LongHeader);
      for i := 1 to TotalQSO do begin
         writeln(f, TQSO(List[i]).DOSzLogText);
      end;
   end
   else begin
      writeln(f, ShortHeader);
      for i := 1 to TotalQSO do begin
         writeln(f, TQSO(List[i]).DOSzLogTextShort);
      end;
   end;

   CloseFile(f);
end;

procedure TQSOList.SaveToFilezLogALL(Filename: string);
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
      writeln(f, TQSO(List[i]).zLogALL);
   end;

   CloseFile(f);
end;

procedure TQSOList.SaveToFileByTX(Filename: string);
var
   f: textfile;
   Header: string;
   i, j: Integer;
   txset: set of byte;
begin
   txset := [];
   for i := 1 to TotalQSO do
      txset := txset + [TQSO(List[i]).FTX];
   Header := 'zLog for Windows '; // +Options.Settings._mycall;
   System.Delete(Filename, length(Filename) - 2, 3);
   for i := 0 to 255 do
      if i in txset then begin
         AssignFile(f, Filename + '.' + IntToStr(i) + '.TX');
         Rewrite(f);
         writeln(f, Header + ' TX# ' + IntToStr(i));
         for j := 1 to TotalQSO do
            if TQSO(List[j]).FTX = i then
               writeln(f, TQSO(List[j]).zLogALL);
         CloseFile(f);
      end;
end;

destructor TQSOList.Destroy;
//var
//   i: Integer;
begin
//   for i := 0 to Count - 1 do begin
//      if List[i] <> nil then begin
//         TQSO(List[i]).Free;
//      end;
//   end;
end;

procedure TQSOList.RebuildDupeCheckList;
var
   i: Integer;
   Q: TQSO;
begin
   ClearDupeCheckList;
   for i := 0 to Count - 1 do begin
      Q := TQSO(List[i]);
      FDupeCheckList[Q.FBand].AddObject(CoreCall(Q.CallSign), Q);
   end;
end;

function TQSOList.QuickDupe(aQSO: TQSO): TQSO;
var
   i: Integer;
   S: string;
   Q, Q2: TQSO;
begin
   Result := nil;
   Q := nil;
   S := CoreCall(aQSO.CallSign);
   i := FDupeCheckList[aQSO.FBand].IndexOf(S);
   if (i >= 0) and (i < FDupeCheckList[aQSO.FBand].Count) then begin
      Q := TQSO(FDupeCheckList[aQSO.FBand].Objects[i]);
      if Q.FBand = aQSO.FBand then
         Result := Q;
   end;

   if FAcceptDifferentMode and (Q <> nil) then begin
      if aQSO.FMode <> Q.FMode then begin
         Result := nil;
         for i := 0 to FDupeCheckList[aQSO.FBand].Count - 1 do begin
            if S = FDupeCheckList[aQSO.FBand][i] then begin
               Q2 := TQSO(FDupeCheckList[aQSO.FBand].Objects[i]);
               if aQSO.FMode = Q2.FMode then begin
                  Result := Q2;
                  exit;
               end;
            end;
         end;
      end;
   end;
end;

function TQSOList.OpQSO(OpName: string): Integer;
var
   i, j: Integer;
begin
   j := 0;

   for i := 1 to TotalQSO do begin
      if TQSO(List[i]).Operator = OpName then begin
         inc(j);
      end;
   end;

   Result := j;
end;

function TQSOList.IsDupe(aQSO: TQSO): Integer;
var
   x: Integer;
   i: word;
   str: string;
begin
   FDifferentModePointer := 0;
   x := 0;
   str := CoreCall(aQSO.CallSign);

   for i := 1 to TotalQSO do begin
      if (aQSO.FBand = TQSO(List[i]).Band) and (str = CoreCall(TQSO(List[i]).CallSign)) then begin
         if Not(FAcceptDifferentMode) then begin
            x := i;
            break;
         end
         else begin
            if aQSO.SameMode(TQSO(List[i])) then begin
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

function TQSOList.IsDupe2(aQSO: TQSO; index: Integer; var dupeindex: Integer): Boolean;
var
   boo: Boolean;
   i: word;
   str: string;
begin
   boo := False;
   str := CoreCall(aQSO.CallSign);

   for i := 1 to TotalQSO do begin
      if (aQSO.FBand = TQSO(List[i]).Band) and (str = CoreCall(TQSO(List[i]).CallSign)) and ((index <= 0) or (index <> i)) then begin
         if Not(AcceptDifferentMode) or (AcceptDifferentMode and aQSO.SameMode(Items[i])) then begin
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
   i, j: Integer;
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
      core := CoreCall(aQSO.CallSign);

      if AcceptDifferentMode then
         str := core + aQSO.BandStr + aQSO.ModeStr
      else
         str := core + aQSO.BandStr;

      if core = '' then
         ch := 'Z'
      else
         ch := core[length(core)];

      if not CharInSet(ch, ['A' .. 'Z']) then
         ch := 'Z';

      if TempList[ord(ch)].Find(str, j) = True then begin
         aQSO.Points := 0;
         aQSO.Dupe := True;
         temp := aQSO.Memo;
         if Pos('-DUPE-', temp) = 0 then begin
            aQSO.Memo := '-DUPE- ' + temp;
         end;
      end
      else begin
         aQSO.Dupe := False;

         temp := aQSO.Memo;
         if Pos('-DUPE-', temp) = 1 then begin
            aQSO.Memo := copy(temp, 8, 255);
         end;

         TempList[ord(ch)].Add(str);
      end;
   end;

   for i := ord('A') to ord('Z') do begin
      TempList[i].Clear;
      TempList[i].Free;
   end;
end;

function TQSOList.TotalQSO: Integer;
begin
   Result := Count - 1;
end;

function TQSOList.TotalPoints: Integer;
var
   points, i: Integer;
begin
   points := 0;

   for i := 1 to TotalQSO do begin
      points := points + TQSO(Items[i]).FPoints;
   end;

   Result := points;
end;

function TQSOList.TotalCW: Integer;
var
   cnt, i: Integer;
begin
   cnt := 0;
   for i := 1 to TotalQSO do begin
      if TQSO(Items[i]).FMode = mCW then begin
         Inc(cnt);
      end;
   end;

   Result := cnt;
end;

function TQSOList.TotalMulti1: Integer;
var
   cnt, i: Integer;
begin
   cnt := 0;
   for i := 1 to TotalQSO do begin
      if TQSO(Items[i]).FNewMulti1 then begin
         Inc(cnt);
      end;
   end;

   Result := cnt;
end;

function TQSOList.TotalMulti2: Integer;
var
   cnt, i: Integer;
begin
   cnt := 0;
   for i := 1 to TotalQSO do begin
      if TQSO(Items[i]).FNewMulti2 then begin
         Inc(cnt);
      end;
   end;

   Result := cnt;
end;

function TQSOList.IndexOf(aQSO: TQSO): Integer;
var
   i: Integer;
begin
   for i := 1 to TotalQSO do begin
      if Items[i].SameQSO(aQSO) then begin
         Result := i;
         Exit;
      end;
   end;

   Result := -1;
end;

function TQSOList.ObjectOf(callsign: string): TQSO;
var
   i: Integer;
begin
   for i := 1 to TotalQSO do begin
      if Items[i].Callsign = callsign then begin
         Result := Items[i];
         Exit;
      end;
   end;

   Result := nil;
end;


function TQSOList.LoadFromFile(filename: string): Integer;
var
   Q: TQSO;
   D: TQSOData;
   f: file of TQSOData;
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
      Q.FileRecord := D;

      if Q.Reserve3 = 0 then begin
         Q.Reserve3 := dmZLogGlobal.NewQSOID;
      end;

      Log.Add(Q);
   end;

   if Q <> nil then begin
      GLOBALSERIAL := (Q.Reserve3 div 10000) mod 10000;
   end;

   CloseFile(f);

   Result := i;
end;

function TQSOList.MergeFile(filename: string): Integer;
var
   qso: TQSO;
   dat: TQSOData;
   f: file of TQSOData;
   i, merged: integer;
begin
   merged := 0;

   AssignFile(f, filename);
   Reset(f);
   Read(f, dat); // first qso comment

   for i := 1 to FileSize(f) - 1 do begin
      Read(f, dat);

      qso := TQSO.Create;
      qso.FileRecord := dat;

      if IndexOf(qso) = -1 then begin
         Add(qso);
         Inc(merged);
      end
      else begin
         qso.Free();
      end;
   end;

   System.close(f);
   Result := merged;
end;

end.
