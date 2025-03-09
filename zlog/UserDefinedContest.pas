unit UserDefinedContest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.StrUtils, Vcl.Forms,
  Generics.Collections, Generics.Defaults,
  UzLogConst, UzLogGlobal;

const
  MAXLOCAL = 31;
  PX_WPX    = 1;
  PX_NORMAL = 2;

  band_without_warc_table: array[1..13] of TBand = ( b19, b35, b7, b14, b21, b28, b50, b144, b430, b1200, b2400, b5600, b10g );

type
  TPointsTable = array[b19..HiBand, mCW..mOther] of Integer;
  PTPointsTable = ^TPointsTable;
  TPowerTable = array[b19..HiBand] of string;
  TSerialTable = array[b19..HiBand] of Integer;
  TAlphabetPointsTable = array[ord('0')..ord('Z')] of Integer;
  TLocalStringTable = array[0..MAXLOCAL] of string;

  TUserDefinedContest = class(TObject)
    FFullpath: string;
    FFileName: string;
    FContestName: string;
    FProv: string;
    FCity: string;
    FPower: string;
    FCoeff: Boolean;
    FSent: string;
    FCwMessageA: array[1..8] of string;
    FCwMessageB: array[1..8] of string;
    FCwMessageCQ: array[1..3] of string;
    FCfgSource: TStringList;

    FPointsTable: TPointsTable;
    FLocalPointsTable: TPointsTable;

    FSameCTYPoints: Boolean;
    FSameCTYPointsTable: TPointsTable;

    FSameCONTPointsTable: TPointsTable;
    FSameCONTPoints: Boolean;

    FSpecialCallPointsTable: TPointsTable;
    FSpecialCalls: string;  // special callsigns for specialcallpointstable

    FLocalCountry: string;
    FLocalContinental: string;

    FLocalString: TLocalStringTable;

    FAlphabetPoints: Boolean;
    FAlphabetPointsTable: TAlphabetPointsTable;

    FMinLocalLen: Integer;
    FDatFileName: string;

    FUseCtyDat: Boolean;

    FCountMultiOnce: Boolean;
    FNoCountryMulti: string;
    FAcceptDifferentMode: Boolean;

    FCut: Integer;
    FLCut: Integer;
    FTail: Integer;
    FLTail: Integer;

    FUndefMulti: Boolean;
    FCutTailingAlphabets: Boolean;
    FAllowUnlistedMulti: Boolean;
    FNoMulti: Boolean;
    FUseMulti2: Boolean;

    FPXMulti: Integer;
    FSerialContestType: TSerialType;

    FPowerTable: TPowerTable;
    FSerialArray: TSerialTable;

    FCountHigherPoints: Boolean;
    FUseWarcBand: Boolean;

    FUseUTC: Boolean;

    FBandPlan: string;

    FUseContestPeriod: Boolean;
    FStartTime: Integer;
    FPeriod: Integer;

    FContestId: string;
  private
    procedure SetFullPath(v: string);
    function GetCwMessageA(Index: Integer): string;
    procedure SetCwMessageA(Index: Integer; v: string);
    function GetCwMessageB(Index: Integer): string;
    procedure SetCwMessageB(Index: Integer; v: string);
    function GetCwMessageCQ(Index: Integer): string;
    procedure SetCwMessageCQ(Index: Integer; v: string);
    procedure SetSent(v: string);
    procedure SetProv(v: string);
    procedure SetCity(v: string);
    procedure SetPower(v: string);
    procedure SetUseUTC(v: Boolean);
    procedure SetUseContestPeriod(v: Boolean);
    procedure SetStartTime(v: Integer);
    procedure SetPeriod(v: Integer);
    function ParseCommand(strLine: string; var strCmd, strParam: string): Boolean;
    procedure EditParam(strCommand, strNewValue: string);
    procedure ClearPointsTable(var PT: TPointsTable);
    class procedure ParseAlphaPt(D: TUserDefinedContest; strParam: string; digit: Integer);
    class function GetBand(strBand: string): TBand;
    class procedure SetPointsTable(PT: PTPointsTable; str: string);
    class function ParseOnOff(strOn: string): Boolean;
    class function ParseIntDef(strParam: string; def: Integer): Integer;
    function GetBandLow(): TBand;
    function GetBandHigh(): TBand;
  public
    constructor Create(); overload;
    constructor Create(strFullPath: string); overload;
    destructor Destroy(); override;
    procedure Load();
    procedure Save();
    class function Parse(strPath: string): TUserDefinedContest; static;
    property Fullpath: string read FFullpath write SetFullpath;
    property Filename: string read FFileName write FFileName;
    property ContestName: string read FContestName write FContestName;
    property Prov: string read FProv write SetProv;
    property City: string read FCity write SetCity;
    property Power: string read FPower write SetPower;
    property Coeff: Boolean read FCoeff write FCoeff;
    property Sent: string read FSent write SetSent;
    property CwMessageA[Index: Integer]: string read GetCwMessageA write SetCwMessageA;
    property CwMessageB[Index: Integer]: string read GetCwMessageB write SetCwMessageB;
    property CwMessageCQ[Index: Integer]: string read GetCwMessageCQ write SetCwMessageCQ;
    property CfgSource: TStringList read FCfgSource;

    property PointsTable: TPointsTable read FPointsTable;
    property LocalPointsTable: TPointsTable read FLocalPointsTable;

    property SameCTYPoints: Boolean read FSameCTYPoints;
    property SameCTYPointsTable: TPointsTable read FSameCTYPointsTable;

    property SameCONTPointsTable: TPointsTable read FSameCONTPointsTable;
    property SameCONTPoints: Boolean read FSameCONTPoints;

    property SpecialCallPointsTable: TPointsTable read FSpecialCallPointsTable;
    property SpecialCalls: string read FSpecialCalls;

    property LocalCountry: string read FLocalCountry;
    property LocalContinental: string read FLocalContinental;

    property LocalString: TLocalStringTable read FLocalString;

    property AlphabetPoints: Boolean read FAlphabetPoints;
    property AlphabetPointsTable: TAlphabetPointsTable read FAlphabetPointsTable;

    property MinLocalLen: Integer read FMinLocalLen;
    property DatFileName: string read FDatFileName;

    property UseCtyDat: Boolean read FUseCtyDat;

    property CountMultiOnce: Boolean read FCountMultiOnce;
    property NoCountryMulti: string read FNoCountryMulti;
    property AcceptDifferentMode: Boolean read FAcceptDifferentMode;

    property Cut: Integer read FCut;
    property LCut: Integer read FLCut;
    property Tail: Integer read FTail;
    property LTail: Integer read FLTail;

    property UndefMulti: Boolean read FUndefMulti;
    property CutTailingAlphabets: Boolean read FCutTailingAlphabets;
    property AllowUnlistedMulti: Boolean read FAllowUnlistedMulti;
    property NoMulti: Boolean read FNoMulti write FNoMulti;
    property UseMulti2: Boolean read FUseMulti2 write FUseMulti2;

    property PXMulti: Integer read FPXMulti;
    property SerialContestType: TSerialType read FSerialContestType;

    property PowerTable: TPowerTable read FPowerTable;
    property SerialArray: TSerialTable read FSerialArray;

    property CountHigherPoints: Boolean read FCountHigherPoints;
    property UseWarcBand: Boolean read FUseWarcBand;

    property UseUTC: Boolean read FUseUTC write SetUseUTC;

    property BandLow: TBand read GetBandLow;
    property BandHigh: TBand read GetBandHigh;

    property BandPlan: string read FBandPlan;

    property UseContestPeriod: Boolean read FUseContestPeriod write SetUseContestPeriod;
    property StartTime: Integer read FStartTime write SetStartTime;
    property Period: Integer read FPeriod write SetPeriod;

    property ContestId: string read FContestId write FContestId;
  end;

  TUserDefinedContestList = class(TObjectList<TUserDefinedContest>)
  public
    constructor Create(OwnsObjects: Boolean = True);
  end;

implementation

{ TUserDefinedContest }

constructor TUserDefinedContest.Create();
var
   i: Integer;
   B: TBand;
begin
   Inherited;
   FCfgSource := TStringList.Create();
   FFullpath := '';
   FFileName := '';
   FContestName := '';
   FProv := '';
   FCity := '';
   FPower := '';
   FCoeff := True;
   for i := 1 to 8 do begin
      FCwMessageA[i] := '';
      FCwMessageB[i] := '';
   end;

   for i := 1 to 3 do begin
      FCwMessageCQ[i] := '';
   end;

   ClearPointsTable(FPointsTable);
   ClearPointsTable(FLocalPointsTable);

   FSameCTYPoints := False;
   ClearPointsTable(FSameCTYPointsTable);

   FSameCONTPoints := False;
   ClearPointsTable(FSameCONTPointsTable);

   ClearPointsTable(FSpecialCallPointsTable);
   FSpecialCalls := '';

   FLocalCountry := '';
   FLocalContinental := '';

   for i := 0 to High(FLocalString) do begin
      FLocalString[i] := '';
   end;

   FAlphabetPoints := False;

   for i := Low(FAlphabetPointsTable) to High(FAlphabetPointsTable) do begin
      FAlphabetPointsTable[i] := 0;
   end;

   FMinLocalLen := 0;
   FDatFileName := '';

   FUseCtyDat := False;

   FCountMultiOnce := False;
   FNoCountryMulti := '';
   FAcceptDifferentMode := False;

   FCut := 0;
   FLCut := 0;
   FTail := 0;
   FLTail := 0;

   FUndefMulti := False;
   FCutTailingAlphabets := False;
   FAllowUnlistedMulti := False;
   FNoMulti := False;
   FUseMulti2 := False;
   FPXMulti := 0;
   FSerialContestType := stNone;
   FCountHigherPoints := False;
   FUseWarcBand := False;

   FUseUTC := False;

   for B := b19 to HiBand do begin
      FSerialArray[B] := 1;
   end;

   FBandPlan := '';

   FUseContestPeriod := False;
   FStartTime := -1;
   FPeriod := 24;

   FContestId := '';
end;

constructor TUserDefinedContest.Create(strFullPath: string);
begin
   Create();
   FullPath := strFullPath;
end;

destructor TUserDefinedContest.Destroy();
begin
   Inherited;
   FCfgSource.Free();
end;

procedure TUserDefinedContest.Load();
begin
   FCfgSource.LoadFromFile(FFullPath);
end;

procedure TUserDefinedContest.Save();
begin
   FCfgSource.SaveToFile(FFullPath);
end;

procedure TUserDefinedContest.ClearPointsTable(var PT: TPointsTable);
var
   B: TBand;
   M: TMode;
begin
   for B := b19 to HiBand do begin
      for M := mCW to mOther do begin
         PT[B, M] := 1;
      end;
   end;
end;

class function TUserDefinedContest.Parse(strPath: string): TUserDefinedContest;
var
   strLine: string;
   strCmd: string;
   strParam: string;
   strTmp: string;
   D: TUserDefinedContest;
   i: Integer;
   j: Integer;
   k: Integer;
   B: TBand;
   SL: TStringList;
begin
   D := TUserDefinedContest.Create(strPath);
   SL := TStringList.Create();
   try
      D.Load();

      for i := 0 to D.CfgSource.Count - 1 do begin
         strLine := D.CfgSource[i];

         strLine := Trim(strLine);

         if D.ParseCommand(strLine, strCmd, strParam) = False then begin
            Continue;
         end;

         if strCmd = 'PROV' then begin
            D.Prov := UpperCase(strParam);
         end
         else if strCmd = 'CITY' then begin
            D.City := UpperCase(strParam);
         end
         else if strCmd = 'POWER' then begin
            D.Power := UpperCase(strParam);
         end
         else if strCmd = 'COEFF' then begin
            D.Coeff := ParseOnOff(strParam);
         end
         else if strCmd = 'SENDNR' then begin
            D.Sent := strParam;
         end
         else if strCmd = 'F1_A' then begin
            D.FCwMessageA[1] := strParam;
         end
         else if strCmd = 'F2_A' then begin
            D.FCwMessageA[2] := strParam;
         end
         else if strCmd = 'F3_A' then begin
            D.FCwMessageA[3] := strParam;
         end
         else if strCmd = 'F4_A' then begin
            D.FCwMessageA[4] := strParam;
         end
         else if strCmd = 'F5_A' then begin
            D.FCwMessageA[5] := strParam;
         end
         else if strCmd = 'F6_A' then begin
            D.FCwMessageA[6] := strParam;
         end
         else if strCmd = 'F7_A' then begin
            D.FCwMessageA[7] := strParam;
         end
         else if strCmd = 'F8_A' then begin
            D.FCwMessageA[8] := strParam;
         end
         else if strCmd = 'F1_B' then begin
            D.FCwMessageB[1] := strParam;
         end
         else if strCmd = 'F2_B' then begin
            D.FCwMessageB[2] := strParam;
         end
         else if strCmd = 'F3_B' then begin
            D.FCwMessageB[3] := strParam;
         end
         else if strCmd = 'F4_B' then begin
            D.FCwMessageB[4] := strParam;
         end
         else if strCmd = 'F5_B' then begin
            D.FCwMessageB[5] := strParam;
         end
         else if strCmd = 'F6_B' then begin
            D.FCwMessageB[6] := strParam;
         end
         else if strCmd = 'F7_B' then begin
            D.FCwMessageB[7] := strParam;
         end
         else if strCmd = 'F8_B' then begin
            D.FCwMessageB[8] := strParam;
         end
         else if strCmd = 'CQ2' then begin
            D.FCwMessageCQ[2] := strParam;
         end
         else if strCmd = 'CQ3' then begin
            D.FCwMessageCQ[3] := strParam;
         end;

         if Pos('PT', strCmd) = 1 then begin
            strTmp := Copy(strCmd, 3, 3);
            B := GetBand(strTmp);

            strParam := UpperCase(strParam);
            if Length(strParam) >= 2 then begin
               D.FPointsTable[B, mSSB] := StrToIntDef(strParam[1], 1);
               D.FPointsTable[B, mCW]  := StrToIntDef(strParam[2], 1);
            end;
            if Length(strParam) >= 3 then begin
               D.FPointsTable[B, mFM]  := StrToIntDef(strParam[3], 1);
            end;
            if Length(strParam) >= 4 then begin
               D.FPointsTable[B, mAM]  := StrToIntDef(strParam[4], 1);
            end;
         end;

         if Pos('LPT', strCmd) = 1 then begin
            strTmp := Copy(strCmd, 4, 3);
            B := GetBand(strTmp);

            strParam := UpperCase(strParam);
            if Length(strParam) >= 2 then begin
               D.FLocalPointsTable[B, mSSB] := StrToIntDef(strParam[1], 1);
               D.FLocalPointsTable[B, mCW]  := StrToIntDef(strParam[2], 1);
            end;
            if Length(strParam) >= 3 then begin
               D.FLocalPointsTable[B, mFM]  := StrToIntDef(strParam[3], 1);
            end;
            if Length(strParam) >= 4 then begin
               D.FLocalPointsTable[B, mAM]  := StrToIntDef(strParam[4], 1);
            end;
         end;

         if Pos('XPT', strCmd) = 1 then begin
            strTmp := Copy(strCmd, 4, 3);
            B := GetBand(strTmp);

            strParam := UpperCase(strParam);
            if Length(strParam) >= 4 then begin
               D.FPointsTable[B, mSSB] := StrToIntDef(strParam[1] + strParam[2], 1);
               D.FPointsTable[B, mCW]  := StrToIntDef(strParam[3] + strParam[4], 1);
            end;
            if Length(strParam) >= 6 then begin
               D.FPointsTable[B, mFM]  := StrToIntDef(strParam[5] + strParam[6], 1);
            end;
            if Length(strParam) >= 8 then begin
               D.FPointsTable[B, mAM]  := StrToIntDef(strParam[7] + strParam[8], 1);
            end;
         end;

         if Pos('XLPT', strCmd) = 1 then begin
            strTmp := Copy(strCmd, 5, 3);
            B := GetBand(strTmp);

            strParam := UpperCase(strParam);
            if Length(strParam) >= 4 then begin
               D.FLocalPointsTable[B, mSSB] := StrToIntDef(strParam[1] + strParam[2], 1);
               D.FLocalPointsTable[B, mCW]  := StrToIntDef(strParam[3] + strParam[4], 1);
            end;
            if Length(strParam) >= 6 then begin
               D.FLocalPointsTable[B, mFM]  := StrToIntDef(strParam[5] + strParam[6], 1);
            end;
            if Length(strParam) >= 8 then begin
               D.FLocalPointsTable[B, mAM]  := StrToIntDef(strParam[7] + strParam[8], 1);
            end;
         end;

         if strCmd = 'SAMECTYPT' then begin
            SetPointsTable(@D.SameCTYPointsTable, strParam);
            D.FSameCTYPoints := True;
         end;

         if strCmd = 'SAMECONTPT' then begin
            SetPointsTable(@D.SameCONTPointsTable, strParam);
            D.FSameCONTPoints := True;
         end;

         if strCmd = 'LOCALPT' then begin
            SetPointsTable(@D.LocalPointsTable, strParam);
         end;

         if strCmd = 'DEFAULTPT' then begin
            SetPointsTable(@D.FPointsTable, strParam);
         end;

         if strCmd = 'SPECIALCALLPT' then begin
            SetPointsTable(@D.SpecialCallPointsTable, strParam);
         end;

         if strCmd = 'SPECIALCALLS' then begin
            strParam := UpperCase(strParam);
            if D.FSpecialCalls <> '' then begin
               D.FSpecialCalls := D.FSpecialCalls + ',' + strParam;
            end
            else begin
               D.FSpecialCalls := strParam;
            end;
         end;

         if strCmd = 'LOCALCTY' then begin
            D.FLocalCountry := UpperCase(strParam)
         end;

         if strCmd = 'LOCALCONT' then begin
            D.FLocalContinental := UpperCase(strParam)
         end;

         if strCmd = 'LOCAL' then begin
            SL.CommaText := UpperCase(strParam);
            for k := 0 to SL.Count - 1 do begin
               if k > MAXLOCAL then begin
                  Break;
               end;
               D.FLocalString[k] := SL.Strings[k];
            end;
         end;

         if strCmd = 'ALPHAPT' then begin
            strParam := UpperCase(strParam);
            D.FAlphabetPoints := True;
            ParseAlphaPt(D, strParam, 2);
         end;

         if strCmd = 'ALPHAPT2' then begin
            strParam := UpperCase(strParam);
            D.FAlphabetPoints := True;
            ParseAlphaPt(D, strParam, 3);
         end;

         if strCmd = 'LOCMIN' then begin
            D.FMinLocalLen := ParseIntDef(strParam, D.MinLocalLen);
         end;

         if strCmd = 'DAT' then begin
            strTmp := strParam;
            if Pos('.', strTmp) = 0 then begin
               strTmp := strTmp + '.DAT';
            end;

            D.FDatFileName := strTmp;
         end;

         if strCmd = 'TIME' then begin
            if UpperCase(strParam) = 'UTC' then begin
               D.FUseUTC := True;
            end;
         end;

         if strCmd = 'CTY' then begin
            D.FUseCtyDat := True;
         end;

         if strCmd = 'COUNTMULTIONCE' then begin
            D.FCountMultiOnce := ParseOnOff(strParam);
         end;

         if strCmd = 'NOCTYMULTI' then begin
            D.FNoCountryMulti := UpperCase(strParam)
         end;

         if strCmd = 'MODE' then begin
            D.FAcceptDifferentMode := ParseOnOff(strParam);
         end;

         if strCmd = 'CUT' then begin
            D.FCut := ParseIntDef(strParam, D.Cut);
         end;

         if strCmd = 'LCUT' then begin
            D.FLCut := ParseIntDef(strParam, D.LCut);
         end;

         if strCmd = 'TAIL' then begin
            D.FTail := ParseIntDef(strParam, D.Tail);
         end;

         if strCmd = 'LTAIL' then begin
            D.FLTail := ParseIntDef(strParam, D.LTail);
         end;

         if strCmd = 'UNDEFMULTI' then begin
            D.FUndefMulti := ParseOnOff(strParam);
         end;

         if strCmd = 'JARL' then begin
            D.FCutTailingAlphabets := ParseOnOff(strParam);
         end;

         if strCmd = 'CUTTAILABT' then // equivalent to JARL
         begin
            D.FCutTailingAlphabets := ParseOnOff(strParam);
         end;

         if strCmd = 'POWER' then begin
            strParam := UpperCase(strParam);
            B := b19;
            for j := 1 to length(strParam) do begin
               D.FPowerTable[B] := strParam[j];

               if B < HiBand then begin
                  repeat
                     inc(B);
                     D.FPowerTable[B] := '-';
                  until NotWARC(B);
               end;
            end;
         end;

         if strCmd = 'UNLISTEDMULTI' then begin
            D.FAllowUnlistedMulti := ParseOnOff(strParam);
         end;

         if strCmd = 'NOMULTI' then begin
            D.NoMulti := ParseOnOff(strParam);
         end;

         if strCmd = 'PXMULTI' then begin
            strParam := UpperCase(strParam);
            if strParam = 'NORMAL' then begin
               D.FPXMulti := PX_Normal;
            end;
            if strParam = 'WPX' then begin
               D.FPXMulti := PX_WPX;
            end;
            if strParam = 'OFF' then begin
               D.FPXMulti := 0;
            end;
         end;

         if strCmd = 'SERIAL' then begin
            strParam := UpperCase(strParam);
            if strParam = 'ALL' then begin
               D.FSerialContestType := stAll;
            end;
            if strParam = 'BAND' then begin
               D.FSerialContestType := stBand;
            end;
         end;

         if strCmd = 'SERIALSTART' then begin
            for B := b19 to HiBand do begin
               D.FSerialArray[B] := StrToIntDef(strParam, 1);
            end;
         end;

         if strCmd = 'COUNTHIGH' then begin
            D.FCountHigherPoints := ParseOnOff(strParam);
         end;

         if strCmd = 'WARC' then begin
            D.FUseWarcBand := ParseOnOff(strParam);
         end;

         if strCmd = 'EXIT' then begin
            Break;
         end;

         if strCmd = 'BANDPLAN' then begin
            D.FBandPlan := UpperCase(strParam);
         end;

         if strCmd = 'USEPERIOD' then begin
            D.FUseContestPeriod := ParseOnOff(strParam);
         end;

         if strCmd = 'STARTTIME' then begin
            D.FStartTime := StrToIntDef(strParam, -1);
         end;

         if strCmd = 'PERIOD' then begin
            D.FPeriod := StrToIntDef(strParam, 0);
         end;

         if strCmd = 'USEMULTI2' then begin
            D.FUseMulti2 := ParseOnOff(strParam);
         end;

         if strCmd = 'CONTESTID' then begin
            D.FContestId := UpperCase(strParam);
         end;
      end;
   finally
      SL.Free();
      Result := D;
   end;
end;

class procedure TUserDefinedContest.ParseAlphaPt(D: TUserDefinedContest; strParam: string; digit: Integer);
var
   i: Integer;
   j: Integer;
   n: Integer;
   S: string;
   cnt: Integer;
begin
   cnt := Length(strParam) div digit;
   for i := 1 to cnt do begin
      n := ((i - 1) * digit) + 1;
      if (i = cnt) then begin
         S := Copy(strParam, n);     // 最後は末尾まで取得
      end
      else begin
         S := Copy(strParam, n, digit);
      end;

      // ?nの場合は全要素に点数をセットする
      if S[1] = '?' then begin
         for j := ord('0') to ord('Z') do begin
            // 0点の要素のみ
            if D.FAlphabetPointsTable[j] = 0 then begin
               D.FAlphabetPointsTable[j] := StrToIntDef(Copy(S, 2), 0);
            end;
         end;
      end
      else if CharInSet(S[1], ['0' .. 'Z']) = True then begin  // [0-Z]nの場合は該当要素に点数をセットする
         D.FAlphabetPointsTable[ord(S[1])] := StrToIntDef(Copy(S, 2), 0);
      end
   end;
end;

class function TUserDefinedContest.GetBand(strBand: string): TBand;
var
   B: TBand;
begin
   if strBand = '1.9' then begin
      B := b19;
   end
   else if strBand = '3.5' then begin
      B := b35;
   end
   else if strBand = '7' then begin
      B := b7;
   end
   else if strBand = '10' then begin
      B := b10;
   end
   else if strBand = '14' then begin
      B := b14;
   end
   else if strBand = '18' then begin
      B := b18;
   end
   else if strBand = '21' then begin
      B := b21;
   end
   else if strBand = '24' then begin
      B := b24;
   end
   else if strBand = '28' then begin
      B := b28;
   end
   else if strBand = '50' then begin
      B := b50;
   end
   else if strBand = '144' then begin
      B := b144;
   end
   else if strBand = '430' then begin
      B := b430;
   end
   else if strBand = '120' then begin
      B := b1200;
   end
   else if strBand = '240' then begin
      B := b2400;
   end
   else if strBand = '560' then begin
      B := b5600;
   end
   else if strBand = '10G' then begin
      B := b10g;
   end
   else begin
      B := b19;
   end;

   Result := B;
end;

class procedure TUserDefinedContest.SetPointsTable(PT: PTPointsTable; str: string);
var
   i, k: Integer;
   tempstr, pstr: string;
   B: TBand;
begin
   tempstr := str + ',';
   B := b19;

   while pos(',', tempstr) > 0 do begin
      i := pos(',', tempstr);
      if i > 0 then begin
         pstr := copy(tempstr, 1, i - 1);
      end
      else begin
         exit;
      end;

      k := StrToIntDef(pstr, 0);
      PT[B, mCW] := k;
      delete(tempstr, 1, i);

      i := pos(',', tempstr);
      if i > 0 then begin
         pstr := copy(tempstr, 1, i - 1);
      end
      else begin
         exit;
      end;

      k := StrToIntDef(pstr, 0);
      PT[B, mSSB] := k;
      PT[B, mFM] := k;
      PT[B, mAM] := k;
      delete(tempstr, 1, i);

      repeat
         inc(B);
      until NotWARC(B);
   end;
end;

class function TUserDefinedContest.ParseOnOff(strOn: string): Boolean;
begin
   if UpperCase(strOn) = 'ON' then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

class function TUserDefinedContest.ParseIntDef(strParam: string; def: Integer): Integer;
var
   w: Integer;
begin
   w := StrToIntDef(strParam, -99);
   if w <> -99 then begin
      Result := w;
   end
   else begin
      Result := def;
   end;
end;

procedure TUserDefinedContest.SetFullPath(v: string);
begin
   FFullPath := v;
   FFilename := ExtractFileName(v);
end;

function TUserDefinedContest.GetCwMessageA(Index: Integer): string;
begin
   Result := FCwMessageA[Index];
end;

procedure TUserDefinedContest.SetCwMessageA(Index: Integer; v: string);
begin
   FCwMessageA[Index] := v;
   EditParam('F' + IntToStr(Index) + '_A', v);
end;

function TUserDefinedContest.GetCwMessageB(Index: Integer): string;
begin
   Result := FCwMessageB[Index];
end;

procedure TUserDefinedContest.SetCwMessageB(Index: Integer; v: string);
begin
   FCwMessageB[Index] := v;
   EditParam('F' + IntToStr(Index) + '_B', v);
end;

function TUserDefinedContest.GetCwMessageCQ(Index: Integer): string;
begin
   Result := FCwMessageCQ[Index];
end;

procedure TUserDefinedContest.SetCwMessageCQ(Index: Integer; v: string);
begin
   FCwMessageCQ[Index] := v;
   EditParam('CQ' + IntToStr(Index), v);
end;

procedure TUserDefinedContest.SetSent(v: string);
begin
   FSent := v;
   EditParam('SENDNR', v);
end;

procedure TUserDefinedContest.SetProv(v: string);
begin
   FProv := v;
   EditParam('PROV', v);
end;

procedure TUserDefinedContest.SetCity(v: string);
begin
   FCity := v;
   EditParam('CITY', v);
end;

procedure TUserDefinedContest.SetPower(v: string);
begin
   v := LeftStr(v + '----------------', 13);
   FPower := v;
   EditParam('POWER', v);
end;

procedure TUserDefinedContest.SetUseUTC(v: Boolean);
begin
   FUseUTC := v;
   if v = True then begin
      EditParam('TIME', 'UTC');
   end
   else begin
      EditParam('TIME', 'JST');
   end;
end;

procedure TUserDefinedContest.SetUseContestPeriod(v: Boolean);
begin
   FUseContestPeriod := v;
   if v = True then begin
      EditParam('USEPERIOD', 'ON');
   end
   else begin
      EditParam('USEPERIOD', 'OFF');
   end;
end;

procedure TUserDefinedContest.SetStartTime(v: Integer);
begin
   FStartTime := v;
   EditParam('STARTTIME', IntToStr(v));
end;

procedure TUserDefinedContest.SetPeriod(v: Integer);
begin
   FPeriod := v;
   EditParam('PERIOD', IntToStr(v));
end;

function TUserDefinedContest.ParseCommand(strLine: string; var strCmd, strParam: string): Boolean;
var
   p: Integer;
begin
   if strLine = '' then begin
      Result := False;
      Exit;
   end;

   if strLine[1] = ';' then begin
      Result := False;
      Exit;
   end;

   if strLine[1] = '#' then begin
      ContestName := Copy(strLine, 2);
      Result := False;
      Exit;
   end;

   p := Pos(';', strLine);
   if p > 0 then begin
      strLine := Copy(strLine, 1, p - 1);
   end;

   p := Pos(#$09, strLine);
   if p = 0 then begin
      p := Pos(' ', strLine);
   end;

   if p = 0 then begin
      Result := False;
      Exit;
   end;

   strCmd := UpperCase(Trim(Copy(strLine, 1, p - 1)));
   strParam := Trim(Copy(strLine, p + 1));

   Result := True;
end;

procedure TUserDefinedContest.EditParam(strCommand, strNewValue: string);
var
   i: Integer;
   strLine: string;
   strCmd: string;
   strParam: string;
begin
   for i := 0 to CfgSource.Count - 1 do begin
      strLine := CfgSource[i];
      strLine := Trim(strLine);
      if ParseCommand(strLine, strCmd, strParam) = False then begin
         Continue;
      end;

      if strCmd = strCommand then begin
         if strParam = '' then begin
            CfgSource[i] := StringReplace(CfgSource[i], strCommand + #09, strCommand + #09 + strNewValue, [rfReplaceAll,rfIgnoreCase]);
         end
         else begin
            CfgSource[i] := StringReplace(CfgSource[i], strParam, strNewValue, [rfReplaceAll,rfIgnoreCase]);
         end;
         Exit;
      end;
   end;

   // 無かった！
   CfgSource.Add(strCommand + #09 + strNewValue + ';');
end;

function TUserDefinedContest.GetBandLow(): TBand;
var
   i: Integer;
begin
   for i := 1 to 13 do begin
      if FPower[i] <> '-' then begin
         Result := band_without_warc_table[i];
         Exit;
      end;
   end;
   Result := b19;
end;

function TUserDefinedContest.GetBandHigh(): TBand;
var
   i: Integer;
begin
   for i := 13 downto 1 do begin
      if FPower[i] <> '-' then begin
         Result := band_without_warc_table[i];
         Exit;
      end;
   end;
   Result := b50;
end;

{ TUserDefinedContestList }

constructor TUserDefinedContestList.Create(OwnsObjects: Boolean = True);
begin
   Inherited Create(OwnsObjects);
end;

end.
