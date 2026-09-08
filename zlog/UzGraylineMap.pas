unit UzGraylineMap;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  System.Math, Vcl.StdCtrls, System.DateUtils, System.StrUtils, SunTime;

const
  GRAYOFFSET = 30;
  GRAYOFFSET_TIMEVALUE = (1 / 1440 * GRAYOFFSET);

type
  TGrayState = ( gsDaytime, gsNight, gsGrayline1, gsGrayline2 );

  TGraylineTime = class
    FSunrise: TDateTime;
    FSunset: TDateTime;
    FGrayState: TGrayState;

    FSunriseMin: TDateTime;
    FSunriseMax: TDateTime;
    FSunsetMin: TDateTime;
    FSunsetMax: TDateTime;
  private
    procedure SetSunrise(v: TDateTime);
    procedure SetSunset(v: TDateTime);
  public
    constructor Create(); overload;
    constructor Create(ASunrise, ASunset: TDateTime); overload;
    procedure Judge(Nowtime: TDateTime; fShowGrayline: Boolean);
    property Sunrise: TDateTime read FSunrise write SetSunrise;
    property Sunset: TDateTime read FSunset write SetSunset;
    property GrayState: TGrayState read FGrayState;
    property SunriseMin: TDateTime read FSunriseMin;
    property SunsetMin: TDateTime read FSunsetMin;
    property SunriseMax: TDateTime read FSunriseMax;
    property SunsetMax: TDateTime read FSunsetMax;
  end;

  TGrayLineMap = class
    FSuntime: TSunTime;
    FTime: array[-180..180] of array[-90..90] of TGraylineTime;
  private
    FShowGrayline: Boolean;
    procedure CalcFastStates(Nowtime: TDateTime; UpdateTimes: Boolean);
    function GetDayTime(X: Integer; Y: Integer): TGraylineTime;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Calc(Nowtime: TDateTime);
    procedure Judge(Nowtime: TDateTime);
    procedure Draw(bmp: TBitmap; ycutoff: Integer);
    procedure DrawLongitude(bmp: TBitmap; longitude: Extended; penstyle: TPenStyle = psSolid);
    procedure DrawLatitude(bmp: TBitmap; latitude: Extended; penstyle: TPenStyle = psSolid);
    procedure DrawTime(bmp: TBitmap; time: DWORD);
    property DayTime[X: Integer; Y: Integer]: TGraylineTime read GetDayTime;
    property ShowGrayline: Boolean read FShowGrayline write FShowGrayline;
  end;

implementation

constructor TGraylineTime.Create();
begin
   FSunrise := 0;
   FSunset := 0;
   FSunriseMin := 0;
   FSunsetMin := 0;
   FSunriseMax := 0;
   FSunsetMax := 0;
   FGrayState := gsDaytime;
end;

constructor TGraylineTime.Create(ASunrise, ASunset: TDateTime);
begin
   Inherited Create();
   FSunrise := ASunrise;
   FSunset := ASunset;
end;

procedure TGraylineTime.Judge(Nowtime: TDateTime; fShowGrayline: Boolean);
begin
   // grayline”»’è
   if fShowGrayline = True then begin
      if (Nowtime >= FSunriseMin) and (Nowtime <= FSunriseMax) then begin
         FGrayState := gsGrayline1;
         Exit;
      end;
      if (Nowtime >= FSunsetMin) and (Nowtime <= FSunsetMax) then begin
         FGrayState := gsGrayline2;
         Exit;
      end;

      if FSunrise <= FSunset then begin
         if (Nowtime > FSunriseMax) and (Nowtime < FSunsetMin) then begin
            FGrayState := gsDaytime;
         end
         else begin
            FGrayState := gsNight;
         end;
      end
      else begin
         if (Nowtime > FSunsetMax) and (Nowtime < FSunriseMin) then begin
            FGrayState := gsNight;
         end
         else begin
            FGrayState := gsDaytime;
         end;
      end;
   end
   else begin
      if FSunrise <= FSunset then begin
         if (Nowtime >= FSunrise) and (Nowtime <= FSunset) then begin
            FGrayState := gsDaytime;
         end
         else begin
            FGrayState := gsNight;
         end;
      end
      else begin
         if (Nowtime >= FSunset) and (Nowtime <= FSunrise) then begin
            FGrayState := gsNight;
         end
         else begin
            FGrayState := gsDaytime;
         end;
      end;
   end;
end;

procedure TGraylineTime.SetSunrise(v: TDateTime);
begin
   if v = 0 then begin
      FSunrise := v;
      FSunriseMin := 0;
      FSunriseMax := 0;
   end
   else begin
      FSunrise := v;
      FSunriseMin := v - GRAYOFFSET_TIMEVALUE;
      FSunriseMax := v + GRAYOFFSET_TIMEVALUE;
   end;
end;

procedure TGraylineTime.SetSunset(v: TDateTime);
begin
   if v = 0 then begin
      FSunset := v;
      FSunsetMin := 0;
      FSunsetMax := 0;
   end
   else begin
      FSunset := v;
      FSunsetMin := v - GRAYOFFSET_TIMEVALUE;
      FSunsetMax := v + GRAYOFFSET_TIMEVALUE;
   end;
end;

{ TGraylineMap }

constructor TGraylineMap.Create();
var
   x, y: Integer;
begin
   FSuntime := TSunTime.Create(nil);
   FSuntime.UseSysTimeZone := False;
   FSuntime.TimeZone := 0;
   FShowGrayline := True;

   for y := 90 downto -90 do begin
      for x := 180 downto -180 do begin
         FTime[x, y] := TGraylineTime.Create();
      end;
   end;
end;

destructor TGraylineMap.Destroy();
var
   x, y: Integer;
begin
   for y := 90 downto -90 do begin
      for x := 180 downto -180 do begin
         FTime[x, y].Free();
      end;
   end;

   FSuntime.Free();
end;

function Normalize180(A: Double): Double; inline;
begin
   while A > 180.0 do A := A - 360.0;
   while A < -180.0 do A := A + 360.0;
   Result := A;
end;

procedure CalcSolarPositionUTC(ADateTime: TDateTime;
   out Declination, EqTime, SubSolarWest: Double);
var
   JD, T, L0, M, Ecc, C, TrueLong, Omega: Double;
   MeanObliq, ObliqCorr, Y, Sin2L0, SinM, Cos2L0, Sin4L0, Sin2M: Double;
   UtcMinutes: Double;
begin
   // NOAA Solar Calculator formulae.
   // ADateTime is UTC.  Delphi TDateTime 0 = 1899-12-30 00:00.
   JD := ADateTime + 2415018.5;
   T := (JD - 2451545.0) / 36525.0;

   L0 := 280.46646 + T * (36000.76983 + T * 0.0003032);
   L0 := L0 - Floor(L0 / 360.0) * 360.0;

   M := 357.52911 + T * (35999.05029 - 0.0001537 * T);
   Ecc := 0.016708634 - T * (0.000042037 + 0.0000001267 * T);

   C := Sin(DegToRad(M)) * (1.914602 - T * (0.004817 + 0.000014 * T))
      + Sin(DegToRad(2.0 * M)) * (0.019993 - 0.000101 * T)
      + Sin(DegToRad(3.0 * M)) * 0.000289;

   TrueLong := L0 + C;
   Omega := 125.04 - 1934.136 * T;

   MeanObliq := 23.0 + (26.0 +
      (21.448 - T * (46.815 + T * (0.00059 - T * 0.001813))) / 60.0) / 60.0;
   ObliqCorr := MeanObliq + 0.00256 * Cos(DegToRad(Omega));

   Declination := RadToDeg(ArcSin(
      Sin(DegToRad(ObliqCorr)) * Sin(DegToRad(TrueLong - 0.00569 - 0.00478 * Sin(DegToRad(Omega))))));

   Y := Sqr(Tan(DegToRad(ObliqCorr) / 2.0));
   Sin2L0 := Sin(2.0 * DegToRad(L0));
   SinM := Sin(DegToRad(M));
   Cos2L0 := Cos(2.0 * DegToRad(L0));
   Sin4L0 := Sin(4.0 * DegToRad(L0));
   Sin2M := Sin(2.0 * DegToRad(M));

   EqTime := 4.0 * RadToDeg(
        Y * Sin2L0
      - 2.0 * Ecc * SinM
      + 4.0 * Ecc * Y * SinM * Cos2L0
      - 0.5 * Y * Y * Sin4L0
      - 1.25 * Ecc * Ecc * Sin2M);

   // Longitude convention in this unit is WEST positive / EAST negative.
   // At the subsolar longitude the solar hour angle is zero.
   UtcMinutes := Frac(ADateTime) * 1440.0;
   if UtcMinutes < 0 then UtcMinutes := UtcMinutes + 1440.0;
   SubSolarWest := Normalize180((UtcMinutes + EqTime) / 4.0 - 180.0);
end;

procedure TGraylineMap.CalcFastStates(Nowtime: TDateTime; UpdateTimes: Boolean);
const
   SUNRISE_ALTITUDE = -0.833; // atmospheric refraction + solar radius
   GRAY_ANGLE = GRAYOFFSET * 0.25; // 30 min * 15 deg/hour = 7.5 deg
var
   x, y: Integer;
   Declination, EqTime, SubSolarWest: Double;
   Phi, Delta, SinPhi, CosPhi, SinDelta, CosDelta: Double;
   CosH0, H0, H, D: Double;
   State: TGrayState;
   BaseDate, SolarNoonMin, SunriseMin, SunsetMin: Double;
begin
   CalcSolarPositionUTC(Nowtime, Declination, EqTime, SubSolarWest);
   Delta := DegToRad(Declination);
   SinDelta := Sin(Delta);
   CosDelta := Cos(Delta);
   BaseDate := Trunc(Nowtime);

   // Only one ArcCos is required per latitude (181 calls total).
   for y := -90 to 90 do begin
      Phi := DegToRad(y);
      SinPhi := Sin(Phi);
      CosPhi := Cos(Phi);

      if Abs(CosPhi * CosDelta) < 1.0E-12 then begin
         // Pole: determine day/night from current solar altitude.
         if SinPhi * SinDelta >= Sin(DegToRad(SUNRISE_ALTITUDE)) then
            H0 := 180.0
         else
            H0 := 0.0;
      end
      else begin
         CosH0 := (Sin(DegToRad(SUNRISE_ALTITUDE)) - SinPhi * SinDelta) /
                  (CosPhi * CosDelta);

         if CosH0 >= 1.0 then
            H0 := 0.0              // polar night
         else if CosH0 <= -1.0 then
            H0 := 180.0            // midnight sun
         else
            H0 := RadToDeg(ArcCos(CosH0));
      end;

      for x := -180 to 180 do begin
         // Local solar hour angle.  x is WEST-positive longitude.
         H := SubSolarWest - x;
         if H > 180.0 then
            H := H - 360.0
         else if H < -180.0 then
            H := H + 360.0;

         if (H0 > 0.0) and (H0 < 180.0) then begin
            D := Abs(Abs(H) - H0);
            if FShowGrayline and (D <= GRAY_ANGLE) then begin
               if H < 0.0 then
                  State := gsGrayline1       // sunrise side
               else
                  State := gsGrayline2;      // sunset side
            end
            else if Abs(H) < H0 then
               State := gsDaytime
            else
               State := gsNight;
         end
         else if H0 >= 180.0 then
            State := gsDaytime
         else
            State := gsNight;

         FTime[x, y].FGrayState := State;

         // Keep public Sunrise/Sunset values available at low cost.
         // This is only needed on the initial Calc; Judge does not use them.
         if UpdateTimes then begin
            if (H0 > 0.0) and (H0 < 180.0) then begin
               SolarNoonMin := 720.0 + 4.0 * x - EqTime;
               SunriseMin := SolarNoonMin - 4.0 * H0;
               SunsetMin := SolarNoonMin + 4.0 * H0;
               FTime[x, y].Sunrise := BaseDate + SunriseMin / 1440.0;
               FTime[x, y].Sunset := BaseDate + SunsetMin / 1440.0;
            end
            else begin
               FTime[x, y].Sunrise := 0;
               FTime[x, y].Sunset := 0;
            end;
         end;
      end;
   end;
end;

procedure TGraylineMap.Calc(Nowtime: TDateTime);
begin
   CalcFastStates(Nowtime, True);
end;

procedure TGraylineMap.Judge(Nowtime: TDateTime);
begin
   CalcFastStates(Nowtime, False);
end;

procedure TGraylineMap.Draw(bmp: TBitmap; ycutoff: Integer);
type
   TRGBTripleArray = array[0..5000] of TRGBTriple;
   PTRGBTripleArray = ^TRGBTripleArray;
var
   bmp_w, bmp_h: Integer;
   x, y, xx, yy: Integer;
   w_rate, h_rate: Double;
   P: PTRGBTripleArray;
   State: TGrayState;
   Offset: Integer;
   R, G, B: Integer;
begin
   bmp_w := bmp.Width;
   bmp_h := bmp.Height;
   if (bmp_w <= 0) or (bmp_h <= 0) then Exit;

   // pf24bit is required for TRGBTriple ScanLine access.
   if bmp.PixelFormat <> pf24bit then
      bmp.PixelFormat := pf24bit;

   w_rate := 360.0 / bmp_w;
   h_rate := (180.0 - (ycutoff * 2.0)) / bmp_h;

   for y := 0 to bmp_h - 1 do begin
      P := bmp.ScanLine[y];
      yy := (90 - ycutoff) - Trunc(y * h_rate);
      if yy > 90 then yy := 90;
      if yy < -90 then yy := -90;

      for x := 0 to bmp_w - 1 do begin
         // Fast path for the native 360-pixel map avoids a floating multiply.
         if bmp_w = 360 then
            xx := 180 - x
         else
            xx := 180 - Trunc(x * w_rate);

         if xx > 180 then xx := 180;
         if xx < -180 then xx := -180;

         State := FTime[xx, yy].FGrayState;

         case State of
            gsNight:
               Offset := 110;

            gsGrayline1, gsGrayline2:
               if FShowGrayline then
                  Offset := 64
               else
                  Offset := 0;
         else
            Offset := 0;
         end;

         if Offset <> 0 then begin
            R := Integer(P^[x].rgbtRed) - Offset;
            G := Integer(P^[x].rgbtGreen) - Offset;
            B := Integer(P^[x].rgbtBlue) - Offset;
            if R < 0 then R := 0;
            if G < 0 then G := 0;
            if B < 0 then B := 0;
            P^[x].rgbtRed := Byte(R);
            P^[x].rgbtGreen := Byte(G);
            P^[x].rgbtBlue := Byte(B);
         end;
      end;
   end;
end;

procedure TGraylineMap.DrawLongitude(bmp: TBitmap; longitude: Extended; penstyle: TPenStyle);
var
   w_rate: Extended;
   x: Integer;
begin
   w_rate := bmp.Width / 360;

   x := Trunc((180 + longitude) * w_rate);

   bmp.Canvas.Brush.Style := bsClear;
   bmp.Canvas.Pen.Style := penstyle;
   bmp.Canvas.Pen.Color := clRed;
   bmp.Canvas.Pen.Width := 1;
   bmp.Canvas.MoveTo(x, 0);
   bmp.Canvas.LineTo(x, bmp.Height - 1);
end;

procedure TGraylineMap.DrawLatitude(bmp: TBitmap; latitude: Extended; penstyle: TPenStyle);
var
   h_rate: Extended;
   y: Integer;
begin
   h_rate := bmp.Height / 180;

   y := Trunc((90 + latitude) * h_rate);

   bmp.Canvas.Brush.Style := bsClear;
   bmp.Canvas.Pen.Style := penstyle;
   bmp.Canvas.Pen.Color := clRed;
   bmp.Canvas.Pen.Width := 1;
   bmp.Canvas.MoveTo(0, y);
   bmp.Canvas.LineTo(bmp.Width - 1, y);
end;

procedure TGraylineMap.DrawTime(bmp: TBitmap; time: DWORD);
var
   x: Integer;
   y: Integer;
   S: string;
begin
   S := 'Calculation time: ' + IntToStr(time) + ' milisec';

   bmp.Canvas.Brush.Style := bsClear;
   bmp.Canvas.Pen.Style := psClear;
   bmp.Canvas.Font.Size := 9;
   bmp.Canvas.Font.Color := clWhite;
   bmp.Canvas.Font.Name := '‚l‚r ‚oƒSƒVƒbƒN';

   x := bmp.Width - bmp.Canvas.TextWidth(S) - 4;
   y := bmp.Height - bmp.Canvas.TextHeight(S) - 4;

   bmp.Canvas.TextOut(x, y, S);
end;

function TGraylineMap.GetDayTime(X: Integer; Y: Integer): TGraylineTime;
begin
   Result := FTime[X,Y];
end;

end.

