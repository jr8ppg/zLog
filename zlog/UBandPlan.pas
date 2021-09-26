unit UBandPlan;

interface
uses
  System.SysUtils, System.Classes, StrUtils, IniFiles, Forms,
  System.Math, System.DateUtils,
  UzlogConst;

type
  TFreqLimit = record
    Lower: UInt64;
    Upper: UInt64;
  end;
  TFreqLimitArray = array[b19..HiBand] of TFreqLimit;

  TBandPlan = class(TObject)
  private
    FLimit: array [mCW..mOther] of TFreqLimitArray;
    function GetLimit(m: TMode): TFreqLimitArray;
    procedure SetLimit(m: TMode; v: TFreqLimitArray);
    function GetDefaults(m: TMode): TFreqLimitArray;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure LoadFromFile();
    procedure SaveToFile();
    function GetEstimatedMode(Hz: Integer): TMode; overload;
    function GetEstimatedMode(b: TBand; Hz: Integer): TMode; overload;
    function IsInBand(b: TBand; m: TMode; Hz: Integer): Boolean;
    function IsOffBand(b: TBand; m: TMode; Hz: Integer): Boolean;
    function FreqToBand(Hz: Int64): TBand; // Returns -1 if Hz is outside ham bands
    property Limit[m: TMode]: TFreqLimitArray read GetLimit write SetLimit;
    property Defaults[m: TMode]: TFreqLimitArray read GetDefaults;
  end;

const
  default_cw_limit: TFreqLimitArray = (
    ( Lower:     1801000; Upper:     1820000 ),
    ( Lower:     3510000; Upper:     3530000 ),
    ( Lower:     7010000; Upper:     7040000 ),
    ( Lower:    10100000; Upper:    10150000 ),
    ( Lower:    14050000; Upper:    14080000 ),
    ( Lower:    18068000; Upper:    18110000 ),
    ( Lower:    21050000; Upper:    21080000 ),
    ( Lower:    24890000; Upper:    24930000 ),
    ( Lower:    28050000; Upper:    28080000 ),
    ( Lower:    50050000; Upper:    50090000 ),
    ( Lower:   144050000; Upper:   144090000 ),
    ( Lower:   430050000; Upper:   430090000 ),
    ( Lower:  1294000000; Upper:  1294500000 ),
    ( Lower:  2424000000; Upper:  2424500000 ),
    ( Lower:  5760000000; Upper:  5762000000 ),
    ( Lower: 10240000000; Upper: 10242000000 )
  );

  default_ssb_limit: TFreqLimitArray = (
    ( Lower:     1850000; Upper:     1875000 ),
    ( Lower:     3535000; Upper:     3570000 ),
    ( Lower:     7060000; Upper:     7140000 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:    14250000; Upper:    14300000 ),
    ( Lower:    18110000; Upper:    18168000 ),
    ( Lower:    21350000; Upper:    21450000 ),
    ( Lower:    24930000; Upper:    24990000 ),
    ( Lower:    28600000; Upper:    28850000 ),
    ( Lower:    50350000; Upper:    51000000 ),
    ( Lower:   144250000; Upper:   144500000 ),
    ( Lower:   430250000; Upper:   430700000 ),
    ( Lower:  1294000000; Upper:  1294500000 ),
    ( Lower:  2424000000; Upper:  2424500000 ),
    ( Lower:  5760000000; Upper:  5762000000 ),
    ( Lower: 10240000000; Upper: 10242000000 )
  );

  default_fm_limit: TFreqLimitArray = (
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:    29200000; Upper:    29300000 ),
    ( Lower:    51000000; Upper:    52000000 ),
    ( Lower:   144750000; Upper:   145600000 ),
    ( Lower:   432100000; Upper:   434000000 ),
    ( Lower:  1294900000; Upper:  1295800000 ),
    ( Lower:  2427000000; Upper:  2450000000 ),
    ( Lower:  5762000000; Upper:  5765000000 ),
    ( Lower: 10242000000; Upper: 10245000000 )
  );

  default_am_limit: TFreqLimitArray = (
    ( Lower:     1850000; Upper:     1875000 ),
    ( Lower:     3535000; Upper:     3570000 ),
    ( Lower:     7060000; Upper:     7140000 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:    14250000; Upper:    14300000 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:    21350000; Upper:    21450000 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:    28600000; Upper:    28850000 ),
    ( Lower:    50350000; Upper:    51000000 ),
    ( Lower:   144250000; Upper:   144500000 ),
    ( Lower:   430250000; Upper:   430700000 ),
    ( Lower:  1294900000; Upper:  1295800000 ),
    ( Lower:  2427000000; Upper:  2450000000 ),
    ( Lower:  5762000000; Upper:  5765000000 ),
    ( Lower: 10242000000; Upper: 10245000000 )
  );

  default_rtty_limit: TFreqLimitArray = (
    ( Lower:           0; Upper:           0 ),
    ( Lower:     3520000; Upper:     3535000 ),
    ( Lower:     7030000; Upper:     7045000 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:    14070000; Upper:    14112000 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:    21070000; Upper:    21125000 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:    28070000; Upper:    28150000 ),
    ( Lower:    50200000; Upper:    51000000 ),
    ( Lower:   144400000; Upper:   144500000 ),
    ( Lower:   430500000; Upper:   430700000 ),
    ( Lower:  1293000000; Upper:  1294000000 ),
    ( Lower:  2424000000; Upper:  2424500000 ),
    ( Lower:  5760000000; Upper:  5762000000 ),
    ( Lower: 10240000000; Upper: 10242000000 )
  );

  default_other_limit: TFreqLimitArray = (
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 ),
    ( Lower:           0; Upper:           0 )
  );

implementation

{ TBandPlan }

constructor TBandPlan.Create();
begin
   Inherited Create();
end;

destructor TBandPlan.Destroy();
begin
   Inherited;
end;

procedure TBandPlan.LoadFromFile();
var
   ini: TIniFile;
   m: TMode;
   b: TBand;
   strSection: string;
   strKey: string;
   SL: TStringList;
   filename: string;
begin
   filename := ExtractFilePath(Application.ExeName) + 'zlog_bandplan.ini';
   if FileExists(filename) = False then begin
      FLimit[mCW]    := default_cw_limit;
      FLimit[mSSB]   := default_ssb_limit;
      FLimit[mFM]    := default_fm_limit;
      FLimit[mAM]    := default_am_limit;
      FLimit[mRTTY]  := default_rtty_limit;
      FLimit[mOther] := default_other_limit;
      Exit;
   end;

   SL := TStringList.Create();
   ini := TIniFile.Create(filename);
   try
      for m := mCW to mOther do begin
         for b := b19 to b10g do begin
            strSection := ModeString[m];
            strKey := MHzString[b];
            SL.CommaText := ini.ReadString(strSection, strKey, '0,0') + ',';
            FLimit[m][b].Lower := StrToUInt64Def(SL[0], 0);
            FLimit[m][b].Upper := StrToUInt64Def(SL[1], 0);
         end;
      end;
   finally
      ini.Free();
      SL.Free();
   end;
end;

procedure TBandPlan.SaveToFile();
var
   ini: TIniFile;
   m: TMode;
   b: TBand;
   strSection: string;
   strKey: string;
   SL: TStringList;
   filename: string;
begin
   filename := ExtractFilePath(Application.ExeName) + 'zlog_bandplan.ini';

   SL := TStringList.Create();
   ini := TIniFile.Create(filename);
   try
      for m := mCW to mOther do begin
         for b := b19 to b10g do begin
            strSection := ModeString[m];
            strKey := MHzString[b];
            SL.Clear();
            SL.Add(IntToStr(FLimit[m][b].Lower));
            SL.Add(IntToStr(FLimit[m][b].Upper));
            ini.WriteString(strSection, strKey, SL.CommaText);
         end;
      end;
   finally
      ini.Free();
      SL.Free();
   end;
end;

function TBandPlan.GetEstimatedMode(Hz: Integer): TMode;
var
   b: TBand;
begin
   for b := b19 to HiBand do begin
      Result := GetEstimatedMode(b, Hz);
      if Result <> mOther then begin
         Exit;
      end;
   end;
   Result := mOther;
end;

function TBandPlan.GetEstimatedMode(b: TBand; Hz: Integer): TMode;
var
   m: TMode;
   l, u: Integer;
begin
   for m := mCW to mOther do begin
      l := FLimit[m][b].Lower;
      u := FLimit[m][b].Upper;
      if (l <= 0) or (u <= 0) then begin
         Continue;
      end;
      if (l <= Hz) and (u >= Hz) then begin
         Result := m;
         Exit;
      end;
   end;
   Result := mOther;
end;

function TBandPlan.IsInBand(b: TBand; m: TMode; Hz: Integer): Boolean;
var
   l, u: Integer;
begin
   l := FLimit[m][b].Lower;
   u := FLimit[m][b].Upper;

   if (l = 0) and (u = 0) then begin
      Result := False;  // UPPERとLOWERの両方が0はバンド外とする（主にmOther）
      Exit;
   end;

   if (l = 0) and (u >= Hz) then begin
      Result := True;
      Exit;
   end;

   if (l <= Hz) and (u = 0) then begin
      Result := True;
      Exit;
   end;

   if (l <= Hz) and (u >= Hz) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

function TBandPlan.IsOffBand(b: TBand; m: TMode; Hz: Integer): Boolean;
var
   l, u: Integer;
begin
   l := FLimit[m][b].Lower;
   u := FLimit[m][b].Upper;

   if (l = 0) and (u = 0) then begin
      Result := False;
      Exit;
   end;

   if (l > Hz) or (u < Hz) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

function TBandPlan.FreqToBand(Hz: Int64): TBand; // Returns -1 if Hz is outside ham bands
var
   b: TBand;
begin
   case Hz div 1000 of
      1800 .. 1999:
         b := b19;
      3000 .. 3999:
         b := b35;
      6900 .. 7999:
         b := b7;
      9900 .. 11000:
         b := b10;
      13900 .. 14999:
         b := b14;
      17500 .. 18999:
         b := b18;
      20900 .. 21999:
         b := b21;
      23500 .. 24999:
         b := b24;
      27800 .. 29999:
         b := b28;
      49000 .. 59000:
         b := b50;
      140000 .. 149999:
         b := b144;
      400000 .. 450000:
         b := b430;
      1200000 .. 1299999:
         b := b1200;
      2400000..2499999:
         b := b2400;
      5600000..5699999:
         b := b5600;
      10000000..90000000:
         b := b10g;
      else
         b := bUnknown;
   end;

   Result := b;
end;

//function TBandPlan.GetUpperLimit(m: TMode): TFreqLimitArray;
//begin
//   Result := FUpper[m];
//end;
//
//function TBandPlan.GetLowerLimit(m: TMode): TFreqLimitArray;
//begin
//   Result := FLower[m];
//end;

//procedure TBandPlan.SetUpperLimit(m: TMode; v: TFreqLimitArray);
//begin
//   FUpper[m] := v;
//end;
//
//procedure TBandPlan.SetLowerLimit(m: TMode; v: TFreqLimitArray);
//begin
//   FLower[m] := v;
//end;

function TBandPlan.GetLimit(m: TMode): TFreqLimitArray;
begin
   Result := FLimit[m];
end;

procedure TBandPlan.SetLimit(m: TMode; v: TFreqLimitArray);
begin
   FLimit[m] := v;
end;

function TBandPlan.GetDefaults(m: TMode): TFreqLimitArray;
begin
   case m of
      mCW:   Result := default_cw_limit;
      mSSB:  Result := default_ssb_limit;
      mFM:   Result := default_fm_limit;
      mAM:   Result := default_am_limit;
      mRTTY: Result := default_rtty_limit;
      else   Result := default_other_limit;
   end;
end;

end.
