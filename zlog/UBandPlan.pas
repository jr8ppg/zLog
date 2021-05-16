unit UBandPlan;

interface
uses
  System.SysUtils, System.Classes, StrUtils, IniFiles, Forms,
  System.Math, System.DateUtils,
  UzlogConst;

type
  TFreqLimitArray = array[b19..HiBand] of Integer;
  TBandPlan = class(TObject)
  private
    FUpper: array [mCW..mOther] of TFreqLimitArray;
    FLower: array [mCW..mOther] of TFreqLimitArray;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure LoadFromFile();
    function GetEstimatedMode(Hz: Integer): TMode; overload;
    function GetEstimatedMode(b: TBand; Hz: Integer): TMode; overload;
    function IsInBand(b: TBand; m: TMode; Hz: Integer): Boolean;
    function IsOffBand(b: TBand; m: TMode; Hz: Integer): Boolean;
    function FreqToBand(Hz: Integer; default: Integer = -1): TBand; // Returns -1 if Hz is outside ham bands
  end;

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
            FLower[m][b] := StrToIntDef(SL[0], 0);
            FUpper[m][b] := StrToIntDef(SL[1], 0);
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
      l := FLower[m][b];
      u := FUpper[m][b];
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
   l := FLower[m][b];
   u := FUpper[m][b];

   if (l = 0) and (u = 0) then begin
      Result := True;
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
   l := FLower[m][b];
   u := FUpper[m][b];

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

function TBandPlan.FreqToBand(Hz: Integer; default: Integer): TBand; // Returns -1 if Hz is outside ham bands
var
   b: TBand;
begin
   b := TBand(default);
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
   end;

   Result := b;
end;

end.
