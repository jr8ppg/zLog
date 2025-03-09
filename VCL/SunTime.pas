{------------------------------------------------------------------------------}
{                                                                              }
{  TSunTime v1.11 -- Calculates times of sunrise, sunset, and solar noon.      }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{  The algorithm is derived from code appearing at                             }
{  http://www.srrb.noaa.gov/highlights/sunrise/sunrise.html                    }
{                                                                              }
{------------------------------------------------------------------------------}
{                                                                              }
{  Thanks to:                                                                  }
{                                                                              }
{    :: Laurent PIERRE <laurent.pierre@rivage.com>                             }
{       for providing the time zone functions                                  }
{    :: Marco Gosselink <marco@gosselink.org>                                  }
{       for fixing the bug in calculating the time zone as Day-in-month format }
{                                                                              }
{------------------------------------------------------------------------------}

{$B-} // Complete Boolean Evaluation Off
{$R-} // Range Checking Off
{$Q-} // Overflow Checking Off
{$O+} // Optimization On

unit SunTime;

interface

uses
  Windows, Messages, SysUtils, Classes;

type

  TAngle = class(TPersistent)
  private
    fDegrees: Word;
    fMinutes: Word;
    fSeconds: Word;
    fNegative: Boolean;
    fUpdateCount: Integer;
    fUpdated: Boolean;
    fOnChange: TNotifyEvent;
    procedure SetMinutes(Value: Word);
    procedure SetSeconds(Value: Word);
    procedure SetNegative(Value: Boolean);
    procedure SetValue(AValue: Extended);
    function GetValue: Extended;
    procedure SetRadians(AValue: Extended);
    function GetRadians: Extended;
    procedure DoChange;
  protected
    procedure SetDegrees(Value: Word); virtual;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
  public
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;
    procedure Assign(Source: TPersistent); override;
    procedure Put(ADegrees: Integer; AMinutes, ASeconds: Word);
    property Negative: Boolean read fNegative write SetNegative;
    property Degrees: Word read fDegrees write SetDegrees;
    property Minutes: Word read fMinutes write SetMinutes;
    property Seconds: Word read fSeconds write SetSeconds;
    property Value: Extended read GetValue write SetValue;
    property Radians: Extended read GetRadians write SetRadians;
  end;

  TLatitudeDir = (dNorth, dSouth);

  TLatitude = class(TAngle)
  private
    procedure SetDir(Value: TLatitudeDir);
    function GetDir: TLatitudeDir;
  protected
    procedure SetDegrees(Value: Word); override;
  public
    procedure Put(ADegrees, AMinutes, ASeconds: Word; ADir: TLatitudeDir);
  published
    property Dir: TLatitudeDir read GetDir write SetDir default dNorth;
    property Degrees;
    property Minutes;
    property Seconds;
  end;

  TLongitudeDir = (dWest, dEast);

  TLongitude = class(TAngle)
  private
    procedure SetDir(Value: TLongitudeDir);
    function GetDir: TLongitudeDir;
  protected
    procedure SetDegrees(Value: Word); override;
  public
    procedure Put(ADegrees, AMinutes, ASeconds: Word; ADir: TLongitudeDir);
  published
    property Dir: TLongitudeDir read GetDir write SetDir default dWest;
    property Degrees;
    property Minutes;
    property Seconds;
  end;

  TZenith = class(TAngle)
  public
    procedure Put(ADegrees, AMinutes, ASeconds: Word);
  published
    property Degrees;
    property Minutes;
    property Seconds;
  end;

  TSunTime = class(TComponent)
  private
    fDate: TDateTime;
    fTimeZone: Extended;
    fUseSysTimeZone: Boolean;
    fLatitude: TLatitude;
    fLongitude: TLongitude;
    fZenithDistance: TZenith;
    fSunrise: TDateTime;
    fSunset: TDateTime;
    fNoon: TDateTime;
    fReady: Boolean;
    procedure SetDate(Value: TDateTime);
    procedure SetUseSysTimeZone(Value: Boolean);
    procedure SetTimeZone(Value: Extended);
    procedure SetLatitude(Value: TLatitude);
    procedure SetLongitude(Value: TLongitude);
    procedure SetZenithDistance(Value: TZenith);
    function GetSunTime(Index: Integer): TDateTime;
    function IsTimeZoneStored: Boolean;
    procedure ParametersChanged(Sender: TObject);
    function UTCMinutesToLocalTime(const Minutes: Extended): TDateTime;
    procedure CalcTimes;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Date: TDateTime read fDate write SetDate;
    property Sunrise: TDateTime index 1 read GetSunTime;
    property Sunset: TDateTime index 2 read GetSunTime;
    property Noon: TDateTime index 3 read GetSunTime;
  published
    property UseSysTimeZone: Boolean read fUseSysTimeZone write SetUseSysTimeZone default True;
    property TimeZone: Extended read fTimeZone write SetTimeZone stored IsTimeZoneStored;
    property Latitude: TLatitude read fLatitude write SetLatitude;
    property Longitude: TLongitude read fLongitude write SetLongitude;
    property ZenithDistance: TZenith read fZenithDistance write SetZenithDistance;
  end;

procedure Register;

implementation

uses
  Math;

procedure Register;
begin
  RegisterComponents('Delphi Area', [TSunTime]);
end;

{ Helper functions }

// Adjusts the value in the range [L, H)
procedure Adjust(var Value: Extended; const L, H: Extended);
begin
  while Value < L do
    Value := Value + H;
  while Value >= H do
    Value := Value - H;
end;

// Converts degrees to radians
function D2R(const D: Extended): Extended;
begin
  Result := D * Pi / 180.0;
end;

// Converts radians to degrees
function R2D(const R: Extended): Extended;
begin
  Result := R * 180.0 / Pi;
end;

// Converts a date to julian day
function DateToJulian(const Date: TDateTime): Extended;
var
  Year, Month, Day: Word;
  A, B: Integer;
begin
  DecodeDate(Date, Year, Month, Day);
  if Month <= 2 then
  begin
    Dec(Year);
    Inc(Month, 12);
  end;
  A := Year div 100;
  B := 2 - A + A div 4;
  Result := Floor(365.25 * (Year + 4716)) + Floor(30.6001 * (Month + 1)) + Day + B - 1524.5;
end;

{ Time Zone Functions }

function DayOfWeek(const DateTime: TDateTime): Byte;
begin
  // Sunday = 0, Saturday = 1, ...
  Result := DateTimeToTimeStamp(DateTime).Date mod 7;
end;

function DayOfMonthToDate(ADay, ADayOfWeek, AMonth, AYear: Word): TDateTime;
var
  Offset: Integer;
  TempDate: TDateTime;
  DaysInMonth: Word;
begin
  if ADay < 5 then
  begin
    // Start with the first day of the month
    TempDate := EncodeDate(AYear, AMonth, 1);
    Offset := ADayOfWeek - DayOfWeek(TempDate);
    if Offset < 0 then Offset := Offset + 7;
    Result := TempDate + Offset + 7 * (ADay - 1);
  end
  else
  begin
    // Take the last day of the month
    DaysInMonth := MonthDays[(AMonth = 2) and IsLeapYear(AYear), AMonth];
    TempDate := EncodeDate(AYear, AMonth, DaysInMonth);
    Offset := DayOfWeek(TempDate) - ADayOfWeek;
    if Offset < 0 then Offset := Offset + 7;
    Result := TempDate - Offset;
  end;
end;

function GetBiasMinutesAtDateTime(const ADateTime: TDateTime): Integer;
const
  TIME_ZONE_ID_INVALID  = $FFFFFFFF;
  TIME_ZONE_ID_UNKNOWN  = 0;
  TIME_ZONE_ID_STANDARD = 1;
  TIME_ZONE_ID_DAYLIGHT = 2;
var
  Info: TTimeZoneInformation;
  StdDateTime, DltDateTime: TDateTime;
  AdjustOffset: Integer;
  AYear, NotUsed: Word;
begin
  FillChar(Info, SizeOf(Info), 0);
  GetTimeZoneInformation(Info);
  Result := Info.Bias;
  // Daylight Time is in use
  if (Info.StandardDate.wMonth <> 0) and (Info.DaylightDate.wMonth <> 0) then
  begin
    DecodeDate(ADateTime, AYear, NotUsed, NotUsed);
    with Info.StandardDate do
    begin
      if wYear = 0 then
        // Day-in-month format
        StdDateTime := DayOfMonthToDate(wDay, wDayOfWeek, wMonth, AYear)
                     + EncodeTime(wHour, wMinute, wSecond, wMilliseconds)
      else
        // Absolute format (exact date and time)
        StdDateTime := EncodeDate(AYear, wMonth, wDay)
                     + EncodeTime(wHour, wMinute, wSecond, wMilliseconds);
    end;
    with Info.DaylightDate do
    begin
      if wYear = 0 then
        // Day-in-month format
        DltDateTime := DayOfMonthToDate(wDay, wDayOfWeek, wMonth, AYear)
                     + EncodeTime(wHour, wMinute, wSecond, wMilliseconds)
      else
        // Absolute format (exact date and time)
        DltDateTime := EncodeDate(AYear, wMonth, wDay)
                     + EncodeTime(wHour, wMinute, wSecond, wMilliseconds);
    end;
    if StdDateTime < DltDateTime then
      if (ADateTime < StdDateTime) or (ADateTime > DltDateTime) then
        AdjustOffset := Info.DaylightBias
      else
        AdjustOffset := Info.StandardBias
    else
      if (ADateTime > DltDateTime) and (ADateTime < StdDateTime) then
        AdjustOffset := Info.DaylightBias
      else
        AdjustOffset := Info.StandardBias;
    Inc(Result, AdjustOffset);
  end;
end;

{ Solar Position Functions }

type TAMPM = (AM, PM);

// Convert Julian Day to centuries since J2000.0
//   JD : the Julian Day to convert
function GetTimeJulianCent(const JD: Extended): Extended;
begin
   Result := (JD - 2451545.0) / 36525.0;
end;

// Returms the Geometric Mean Longitude of the Sun (in degrees)
//   T : number of Julian centuries since J2000.0
function GetGeomMeanLongSun(const T: Extended): Extended;
begin
  Result := 280.46646 + T * (36000.76983 + 0.0003032 * T);
  Adjust(Result, 0, 360);
end;

// Returns the Geometric Mean Anomaly of the Sun (in degrees)
//   T : number of Julian centuries since J2000.0
function GetGeomMeanAnomalySun(const T: Extended): Extended;
begin
  Result := 357.52911 + T * (35999.05029 - 0.0001537 * T);
end;

// Returns the eccentricity of earth's orbit (unitless)
//   T : number of Julian centuries since J2000.0
function GetEccentricityEarthOrbit(const T: Extended): Extended;
begin
   Result := 0.016708634 - T * (0.000042037 + 0.0000001267 * T);
end;

// Returns the equation of center for the sun (in degrees)
//   T : number of Julian centuries since J2000.0
function GetSunEquationOfCenter(const T: Extended): Extended;
var
  M: Extended;
begin
  M := GetGeomMeanAnomalySun(T);
  Result := Sin(D2R(M)) * (1.914602 - T * (0.004817 + 0.000014 * T))
          + Sin(2 * D2R(M)) * (0.019993 - 0.000101 * T) + Sin(3 * D2R(M)) * 0.000289;
end;

// Returns the true longitude of the sun (in degrees)
//   T : number of Julian centuries since J2000.0
function GetSunTrueLong(const T: Extended): Extended;
var
  L0: Extended;
  C: Extended;
begin
  L0 := GetGeomMeanLongSun(T);
  C := GetSunEquationOfCenter(T);
  Result := L0 + C;
end;

// Returns the true anomaly of the sun (in degrees)
//   T : number of Julian centuries since J2000.0
function GetSunTrueAnomaly(const T: Extended): Extended;
var
  M: Extended;
  C: Extended;
begin
  M := GetGeomMeanAnomalySun(T);
  C := GetSunEquationOfCenter(T);
  Result := M + C;
end;

// Returns the distance to the sun (in AUs)
//   T : number of Julian centuries since J2000.0
function GetSunRadVector(const T: Extended): Extended;
var
  V: Extended;
  E: Extended;
begin
  V := GetSunTrueAnomaly(T);
  E := GetEccentricityEarthOrbit(T);
  Result := (1.000001018 * (1 - E * E)) / (1 + E * Cos(D2R(V)));
end;

// Returns the apparent longitude of the sun (in degrees)
//   T : number of Julian centuries since J2000.0
function GetSunApparentLong(const T: Extended): Extended;
var
  O: Extended;
  Omega: Extended;
begin
  O := GetSunTrueLong(T);
  Omega := 125.04 - 1934.136 * T;
  Result := O - 0.00569 - 0.00478 * Sin(D2R(Omega));
end;

// Returns the mean obliquity of the ecliptic (in degrees)
//   T : number of Julian centuries since J2000.0
function GetMeanObliquityOfEcliptic(const T: Extended): Extended;
var
  Seconds: Extended;
begin
  Seconds := 21.448 - T * (46.8150 + T * (0.00059 - T * (0.001813)));
  Result := 23.0 + (26.0 + (Seconds / 60.0)) / 60.0;
end;

// Returns the corrected obliquity of the ecliptic (in degrees)
//   T : number of Julian centuries since J2000.0
function GetObliquityCorrection(const T: Extended): Extended;
var
  E0: Extended;
  Omega: Extended;
begin
  E0 := GetMeanObliquityOfEcliptic(T);
  Omega := 125.04 - 1934.136 * T;
  Result := E0 + 0.00256 * Cos(D2R(Omega));
end;

// Returns the right ascension of the sun (in degrees)
//   T : number of Julian centuries since J2000.0
function GetSunRtAscension(const T: Extended): Extended;
var
  E: Extended;
  Lambda: Extended;
begin
  E := GetObliquityCorrection(T);
  Lambda := GetSunApparentLong(T);
  Result := R2D(ArcTan2(Cos(D2R(E)) * Sin(D2R(Lambda)), Cos(D2R(Lambda))));
end;

// Returns the declination of the sun (in degrees)
//   T : number of Julian centuries since J2000.0
function GetSunDeclination(const T: Extended): Extended;
var
  E: Extended;
  Lambda: Extended;
begin
  E := GetObliquityCorrection(T);
  Lambda := GetSunApparentLong(T);
  Result := R2D(ArcSin(Sin(D2R(E)) * Sin(D2R(Lambda))));
end;

// Returns the difference between true solar time and mean (in minutes of time)
//   T : number of Julian centuries since J2000.0
function GetEquationOfTime(const T: Extended): Extended;
var
  Epsilon: Extended;
  L0: Extended;
  E: Extended;
  M: Extended;
  Y: Extended;
  ETime: Extended;
begin
  Epsilon := GetObliquityCorrection(T);
  L0 := GetGeomMeanLongSun(T);
  E := GetEccentricityEarthOrbit(T);
  M := GetGeomMeanAnomalySun(T);
  Y := Sqr(Tan(D2R(Epsilon) / 2.0));
  ETime := Y * Sin(2 * D2R(L0)) - 2.0 * E * Sin(D2R(M))
         + 4.0 * E * Y * Sin(D2R(M)) * Cos(2 * D2R(L0))
         - 0.5 * Y * Y * Sin(4 * D2R(L0)) - 1.25 * E * E * Sin(2 * D2R(M));
  Result := R2D(ETime) * 4.0;
end;

//  Returns the hour angle of the sun at the zenith distance for the
//  latitude (in degrees)
//    Latitude : latitude of observer (in degrees)
//    SolarDec : declination angle of sun (in degrees)
//   ZD : zenith distance of the sun (in degrees)
//   When: morning or evening?
function GetSunHourAngleOfZenithDistance(const Latitude, SolarDec,
  ZD: Extended; When: TAMPM): Extended;
var
  L: Extended;
  SD: Extended;
  HAarg: Extended;
begin
  L := D2R(Latitude);
  SD := D2R(SolarDec);
  HAarg := Cos(D2R(ZD)) / (Cos(L) * Cos(SD)) - Tan(L) * Tan(SD);
  Result := R2D(ArcCos(HAarg));
  if When = PM then
    Result := -Result;
end;

// Returms the Universal Coordinated Time (UTC) of solar noon for the given
// day at the given location on earth (in minutes)
//   JD : julian day
//   Longitude : longitude of observer (in degrees)
function GetSolarNoonUTC(const JD, Longitude: Extended): Extended;
var
  T: Extended;
  ETime: Extended;
begin
  T := GetTimeJulianCent(JD + 0.5 + Longitude / 360.0);
  ETime := GetEquationOfTime(T);
  Result := 720 + (Longitude * 4) - ETime;
end;

// Returns the Universal Coordinated Time (UTC) of sunrise at the zenith
// distance for the given day at the given location on earth (in minutes)
//   JD : julian day
//   Latitude : latitude of observer (in degrees)
//   Longitude : longitude of observer (in degrees)
//   ZD : zenith distance of the sun (in degrees)
//   When: morning or evening?
function GetSolarTimeOfZenithDistanceUTC(const JD, Latitude, Longitude,
  ZD: Extended; When: TAMPM): Extended;
var
  NoonMin: Extended;
  NoonT: Extended;
  ETime: Extended;
  SolarDec: Extended;
  HourAngle: Extended;
  Delta: Extended;
  TimeDiff: Extended;
  TimeUTC: Extended;
  NewT: Extended;
begin
  NoonMin := GetSolarNoonUTC(JD, Longitude);
  NoonT := GetTimeJulianCent(JD + NoonMin / 1440.0);
  ETime := GetEquationOfTime(NoonT);
  SolarDec := GetSunDeclination(NoonT);
  HourAngle := GetSunHourAngleOfZenithDistance(Latitude, SolarDec, ZD, When);
  Delta := Longitude - HourAngle;
  TimeDiff := 4 * Delta;
  TimeUTC := 720 + TimeDiff - ETime;
  NewT := GetTimeJulianCent(JD + TimeUTC / 1440.0);
  ETime := GetEquationOfTime(NewT);
  SolarDec := GetSunDeclination(NewT);
  HourAngle := GetSunHourAngleOfZenithDistance(Latitude, SolarDec, ZD, When);
  Delta := Longitude - HourAngle;
  TimeDiff := 4 * Delta;
  TimeUTC := 720 + timeDiff - ETime;
  Result := TimeUTC;
end;

{ TAngle }

procedure TAngle.DoChange;
begin
  if fUpdateCount = 0 then
  begin
    fUpdated := False;
    if Assigned(OnChange) then
      OnChange(Self);
  end
  else
    fUpdated := True;
end;

procedure TAngle.SetDegrees(Value: Word);
begin
  if Degrees <> Value then
  begin
    fDegrees := Value mod 360;
    DoChange;
  end;
end;

procedure TAngle.SetMinutes(Value: Word);
begin
  if Minutes <> Value then
  begin
    if Value >= 60 then
    begin
      fMinutes := Value mod 60;
      Degrees := Degrees + Value div 60;
    end
    else
    begin
      fMinutes := Value;
      DoChange;
    end;
  end;
end;

procedure TAngle.SetSeconds(Value: Word);
begin
  if Seconds <> Value then
  begin
    if Value >= 60 then
    begin
      fSeconds := Value mod 60;
      Minutes := Minutes + Value div 60;
    end
    else
    begin
      fSeconds := Value;
      DoChange;
    end;
  end;
end;

procedure TAngle.SetNegative(Value: Boolean);
begin
  if Negative <> Value then
  begin
    fNegative := Value;
    DoChange;
  end;
end;

procedure TAngle.SetValue(AValue: Extended);
begin
  BeginUpdate;
  try
    Negative := (AValue < 0);
    AValue := Abs(AValue);
    Degrees := Trunc(AValue);
    AValue := Frac(AValue);
    Minutes := Trunc(AValue * 60);
    AValue := Frac(AValue * 60);
    Seconds := Trunc(AValue * 60);
  finally
    EndUpdate;
  end;
end;

function TAngle.GetValue: Extended;
begin
  Result := Degrees + Minutes / 60 + Seconds / 3600;
  if Negative then Result := -Result;
end;

function TAngle.GetRadians: Extended;
begin
  Result := D2R(Value);
end;

procedure TAngle.SetRadians(AValue: Extended);
begin
  Value := R2D(AValue);
end;

procedure TAngle.Assign(Source: TPersistent);
begin
  if Source is TAngle then
    Value := TAngle(Source).Value
  else
    inherited Assign(Source);
end;

procedure TAngle.Put(ADegrees: Integer; AMinutes, ASeconds: Word);
begin
  BeginUpdate;
  try
    Negative := (ADegrees < 0);
    Degrees := Abs(ADegrees);
    Minutes := AMinutes;
    Seconds := ASeconds;
  finally
    EndUpdate;
  end;
end;

procedure TAngle.BeginUpdate;
begin
  Inc(fUpdateCount);
end;

procedure TAngle.EndUpdate;
begin
  Dec(fUpdateCount);
  if (fUpdateCount = 0) and fUpdated then
    DoChange;
end;

{ TLatitude }

function TLatitude.GetDir: TLatitudeDir;
begin
  if Negative then
    Result := dSouth
  else
    Result := dNorth;
end;

procedure TLatitude.SetDir(Value: TLatitudeDir);
begin
  Negative := (Value = dSouth);
end;

procedure TLatitude.SetDegrees(Value: Word);
begin
  while Value > 90 do
    Dec(Value, 90);
  inherited SetDegrees(Value);
end;

procedure TLatitude.Put(ADegrees, AMinutes, ASeconds: Word; ADir: TLatitudeDir);
begin
  if ADir = dNorth then
    inherited Put(ADegrees, AMinutes, ASeconds)
  else
    inherited Put(-ADegrees, AMinutes, ASeconds);
end;

{ TLongitude }

function TLongitude.GetDir: TLongitudeDir;
begin
  if Negative then
    Result := dEast
  else
    Result := dWest;
end;

procedure TLongitude.SetDir(Value: TLongitudeDir);
begin
  Negative := (Value = dEast);
end;

procedure TLongitude.SetDegrees(Value: Word);
begin
  while Value > 180 do
    Dec(Value, 180);
  inherited SetDegrees(Value);
end;

procedure TLongitude.Put(ADegrees, AMinutes, ASeconds: Word; ADir: TLongitudeDir);
begin
  if ADir = dWest then
    inherited Put(ADegrees, AMinutes, ASeconds)
  else
    inherited Put(-ADegrees, AMinutes, ASeconds);
end;

{ TZenith }

procedure TZenith.Put(ADegrees, AMinutes, ASeconds: Word);
begin
  inherited Put(ADegrees, AMinutes, ASeconds);
end;

{ TSunTime }

constructor TSunTime.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fLatitude := TLatitude.Create;
  fLatitude.OnChange := ParametersChanged;
  fLongitude := TLongitude.Create;
  fLongitude.OnChange := ParametersChanged;
  fZenithDistance := TZenith.Create;
  fZenithDistance.Put(90, 50, 0);
  fZenithDistance.OnChange := ParametersChanged;
  fDate := Now;
  SetUseSysTimeZone(True);
end;

destructor TSunTime.Destroy;
begin
  fLatitude.Free;
  fLongitude.Free;
  fZenithDistance.Free;
  inherited Destroy;
end;

procedure TSunTime.SetDate(Value: TDateTime);
begin
  if Date <> Value then
  begin
    fDate := Value;
    if UseSysTimeZone then
      fTimeZone := -GetBiasMinutesAtDateTime(Date) / 60;
    ParametersChanged(nil);
  end;
end;

procedure TSunTime.SetUseSysTimeZone(Value: Boolean);
begin
  if UseSysTimeZone <> Value then
  begin
    fUseSysTimeZone := Value;
    if UseSysTimeZone then
    begin
      fTimeZone := -GetBiasMinutesAtDateTime(Date) / 60;
      ParametersChanged(nil);
    end;
  end;
end;

procedure TSunTime.SetTimeZone(Value: Extended);
begin
  if (TimeZone <> Value) and (Value >= -12) and (Value <= +12) then
  begin
    fTimeZone := Value;
    fUseSysTimeZone := False;
    ParametersChanged(nil);
  end;
end;

procedure TSunTime.SetLatitude(Value: TLatitude);
begin
  fLatitude.Assign(Value);
end;

procedure TSunTime.SetLongitude(Value: TLongitude);
begin
  fLongitude.Assign(Value);
end;

procedure TSunTime.SetZenithDistance(Value: TZenith);
begin
  fZenithDistance.Assign(Value);
end;

function TSunTime.IsTimeZoneStored: Boolean;
begin
  Result := not UseSysTimeZone and (TimeZone <> 0);
end;

function TSunTime.GetSunTime(Index: Integer): TDateTime;
begin
  if not fReady then
    CalcTimes;
  case Index of
    1: Result := fSunrise;
    2: Result := fSunset;
    3: Result := fNoon;
  else
    Result := 0;
  end;
end;

procedure TSunTime.ParametersChanged(Sender: TObject);
begin
  fReady := False;
end;

function TSunTime.UTCMinutesToLocalTime(const Minutes: Extended): TDateTime;
begin
  if UseSysTimeZone then
  begin
    Result := Trunc(Date) + (Minutes / (60 * 24));
    Result := Result - (GetBiasMinutesAtDateTime(Result) / (60 * 24));
  end
  else
    Result := Trunc(Date) + (Minutes / 60 + TimeZone) / 24;
end;

procedure TSunTime.CalcTimes;
var
  JD: Extended;
  Minutes: Extended;
begin
  JD := DateToJulian(Date);
  try
    Minutes := GetSolarTimeOfZenithDistanceUTC(JD,
      Latitude.Value, Longitude.Value, ZenithDistance.Value, AM);
    fSunrise := UTCMinutesToLocalTime(Minutes);
  except
    fSunrise := 0;  // No sunrise
  end;
  try
    Minutes := GetSolarTimeOfZenithDistanceUTC(JD,
      Latitude.Value, Longitude.Value, ZenithDistance.Value, PM);
    fSunset := UTCMinutesToLocalTime(Minutes);
  except
    fSunset := 0;  // No sunset
  end;
  try
    Minutes := GetSolarNoonUTC(JD, Longitude.Value);
    fNoon := UTCMinutesToLocalTime(Minutes);
  except
    fNoon := 0;    // No solar noon
  end;
  fReady := True;
end;

end.

