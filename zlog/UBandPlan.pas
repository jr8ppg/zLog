unit UBandPlan;

interface
uses
  System.SysUtils, System.Classes, StrUtils, IniFiles, Forms,
  System.Math, System.DateUtils,
  UzLogConst;

type
  TFreqLimit = record
    Lower: TFrequency;
    Upper: TFrequency;
  end;
  TFreqLimitArray = array[b19..HiBand] of TFreqLimit;

  TBandPlan = class(TObject)
  private
    FPresetName: string;
    FLimit: array [mCW..mOther] of TFreqLimitArray;
    function GetLimit(m: TMode): TFreqLimitArray;
    procedure SetLimit(m: TMode; v: TFreqLimitArray);
    function GetFileName(): string;
  public
    constructor Create(); overload;
    constructor Create(preset: string); overload;
    destructor Destroy(); override;
    procedure LoadFromFile();
    procedure SaveToFile();
    function GetEstimatedMode(Hz: TFrequency): TMode; overload;
    function GetEstimatedMode(b: TBand; Hz: TFrequency): TMode; overload;
    function IsInBand(b: TBand; m: TMode; Hz: TFrequency): Boolean;
    function IsOffBand(b: TBand; m: TMode; Hz: TFrequency): Boolean;
    function FreqToBand(Hz: TFrequency): TBand; // Returns -1 if Hz is outside ham bands
    property Limit[m: TMode]: TFreqLimitArray read GetLimit write SetLimit;
    property PresetName: string read FPresetName write FPresetName;
    class function GetDefaults(Index: Integer; m: TMode): TFreqLimitArray;
  end;

const
  // CW
  default_cw_limit: array[0..1] of TFreqLimitArray = (
    // JA
    (
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
    ),
    // DX
    (
      ( Lower:     1800000; Upper:     1912500 ),
      ( Lower:     3500000; Upper:     3805000 ),
      ( Lower:     7000000; Upper:     7200000 ),
      ( Lower:    10100000; Upper:    10150000 ),
      ( Lower:    14000000; Upper:    14350000 ),
      ( Lower:    18068000; Upper:    18168000 ),
      ( Lower:    21000000; Upper:    21450000 ),
      ( Lower:    24890000; Upper:    24990000 ),
      ( Lower:    28000000; Upper:    29000000 ),
      ( Lower:    50000000; Upper:    51000000 ),
      ( Lower:   144020000; Upper:   144500000 ),
      ( Lower:   430000000; Upper:   430700000 ),
      ( Lower:  1294000000; Upper:  1294500000 ),
      ( Lower:  2424000000; Upper:  2424500000 ),
      ( Lower:  5760000000; Upper:  5762000000 ),
      ( Lower: 10240000000; Upper: 10242000000 )
    )
  );

  // SSB
  default_ssb_limit: array[0..1] of TFreqLimitArray = (
    // JA
    (
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
    ),
    // DX
    (
      ( Lower:     1845000; Upper:     1875000 ),
      ( Lower:     3535000; Upper:     3805000 ),
      ( Lower:     7045000; Upper:     7200000 ),
      ( Lower:           0; Upper:           0 ),
      ( Lower:    14100000; Upper:    14350000 ),
      ( Lower:    18110000; Upper:    18168000 ),
      ( Lower:    21150000; Upper:    21450000 ),
      ( Lower:    24930000; Upper:    24990000 ),
      ( Lower:    28200000; Upper:    29000000 ),
      ( Lower:    50100000; Upper:    51000000 ),
      ( Lower:   144100000; Upper:   144500000 ),
      ( Lower:   430100000; Upper:   430700000 ),
      ( Lower:  1294000000; Upper:  1294500000 ),
      ( Lower:  2424000000; Upper:  2424500000 ),
      ( Lower:  5760000000; Upper:  5762000000 ),
      ( Lower: 10240000000; Upper: 10242000000 )
    )
  );

  // FM
  default_fm_limit: array[0..1] of TFreqLimitArray = (
    // JA
    (
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
      ( Lower:  2425000000; Upper:  2450000000 ),
      ( Lower:  5757000000; Upper:  5760000000 ),
      ( Lower: 10237000000; Upper: 10240000000 )
    ),
    // DX
    (
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
      ( Lower:  5757000000; Upper:  5760000000 ),
      ( Lower: 10237000000; Upper: 10240000000 )
    )
  );

  // AM
  default_am_limit: array[0..1] of TFreqLimitArray = (
    // JA
    (
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
      ( Lower:  5757000000; Upper:  5760000000 ),
      ( Lower: 10237000000; Upper: 10240000000 )
    ),
    // DX
    (
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
      ( Lower:  5757000000; Upper:  5760000000 ),
      ( Lower: 10237000000; Upper: 10240000000 )
    )
  );

  // RTTY
  default_rtty_limit: array[0..1] of TFreqLimitArray = (
    // JA
    (
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
    ),
    // DX
    (
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
    )
  );

  // OTHER
  default_other_limit: array[0..1] of TFreqLimitArray = (
    // JA
    (
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
    ),
    // DX
    (
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
    )
  );

implementation

{ TBandPlan }

constructor TBandPlan.Create();
begin
   Inherited Create();
   FPresetName := 'JA';
end;

constructor TBandPlan.Create(preset: string);
begin
   Inherited Create();
   FPresetName := preset;
end;

destructor TBandPlan.Destroy();
begin
   Inherited;
end;

procedure TBandPlan.LoadFromFile();
var
   ini: TMemIniFile;
   m: TMode;
   b: TBand;
   strSection: string;
   strKey: string;
   SL: TStringList;
   filename: string;
   Index: Integer;
begin
   filename := GetFileName();
   if FileExists(filename) = False then begin
      if FPresetName = 'DX' then begin
         Index := 1;
      end
      else begin
         Index := 0;
      end;
      FLimit[mCW]    := default_cw_limit[Index];
      FLimit[mSSB]   := default_ssb_limit[Index];
      FLimit[mFM]    := default_fm_limit[Index];
      FLimit[mAM]    := default_am_limit[Index];
      FLimit[mRTTY]  := default_rtty_limit[Index];
      FLimit[mOther] := default_other_limit[Index];
      Exit;
   end;

   SL := TStringList.Create();
   ini := TMemIniFile.Create(filename);
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
   ini: TMemIniFile;
   m: TMode;
   b: TBand;
   strSection: string;
   strKey: string;
   SL: TStringList;
   filename: string;
begin
   filename := GetFileName();

   SL := TStringList.Create();
   ini := TMemIniFile.Create(filename);
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

      ini.UpdateFile();
   finally
      ini.Free();
      SL.Free();
   end;
end;

function TBandPlan.GetEstimatedMode(Hz: TFrequency): TMode;
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

function TBandPlan.GetEstimatedMode(b: TBand; Hz: TFrequency): TMode;
var
   m: TMode;
   l, u: TFrequency;
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

function TBandPlan.IsInBand(b: TBand; m: TMode; Hz: TFrequency): Boolean;
var
   l, u: TFrequency;
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

function TBandPlan.IsOffBand(b: TBand; m: TMode; Hz: TFrequency): Boolean;
var
   l, u: TFrequency;
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

function TBandPlan.FreqToBand(Hz: TFrequency): TBand; // Returns -1 if Hz is outside ham bands
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
      5600000..5899999:
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

class function TBandPlan.GetDefaults(Index: Integer; m: TMode): TFreqLimitArray;
begin
   case m of
      mCW:   Result := default_cw_limit[Index];
      mSSB:  Result := default_ssb_limit[Index];
      mFM:   Result := default_fm_limit[Index];
      mAM:   Result := default_am_limit[Index];
      mRTTY: Result := default_rtty_limit[Index];
      else   Result := default_other_limit[Index];
   end;
end;

function TBandPlan.GetFileName(): string;
begin
   if FPresetName = 'JA' then begin
      Result := ExtractFilePath(Application.ExeName) + 'zlog_bandplan.ini';
   end
   else begin
      Result := ExtractFilePath(Application.ExeName) + 'zlog_bandplan_' + FPresetName + '.ini';
   end;
end;

end.
