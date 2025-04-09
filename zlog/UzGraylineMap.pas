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
    function GetDayTime(X: Integer; Y: Integer): TGraylineTime;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Calc(Nowtime: TDateTime);
    procedure Judge(Nowtime: TDateTime);
    procedure Draw(bmp: TBitmap);
    procedure DrawLongitude(bmp: TBitmap; longitude: Extended; penstyle: TPenStyle = psSolid);
    procedure DrawLatitude(bmp: TBitmap; latitude: Extended; penstyle: TPenStyle = psSolid);
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
   // grayline判定
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

procedure TGraylineMap.Calc(Nowtime: TDateTime);
var
   x, y: Integer;
   PrevDay: TDateTime;
   NextDay: TDateTime;
   sunset: TDateTime;
begin
   // setrise/sunset
   NextDay := IncDay(Nowtime, 1);
   PrevDay := IncDay(Nowtime, -1);

   // north->south
   for y := 90 downto -90 do begin
      // west->east
      for x := 180 downto -180 do begin
         // 地点セット
         FSuntime.Latitude.Value := y;
         FSuntime.Longitude.Value := x;

         // 西経部は１日戻す
         if x > 0 then begin
            FSuntime.Date := PrevDay;
         end
         else begin
            FSuntime.Date := Nowtime;
         end;

         // 日の入り
         if IsNan(FSuntime.sunset) then begin
            FTime[x, y].Sunset := 0;
         end
         else begin
            FTime[x, y].Sunset := FSuntime.sunset;
         end;

         // 既にsunsetを過ぎていたらsunriseは翌日について計算する
         sunset := FTime[x, y].SunsetMax;
         if ((sunset > 0) and (Nowtime > sunset)) then begin
            // 東経部は１日進める
            if x < 0 then begin
               FSuntime.Date := NextDay;
            end
            else begin
               FSuntime.Date := Nowtime;
            end;
         end;

         // 日の出
         if IsNan(FSuntime.sunrise) then begin
            FTime[x, y].Sunrise := 0;
         end
         else begin
            FTime[x, y].Sunrise := FSuntime.sunrise;
         end;

         // 昼夜判定
         FTime[x, y].Judge(Nowtime, FShowGrayline);
      end;
   end;
end;

procedure TGraylineMap.Judge(Nowtime: TDateTime);
var
   x, y: Integer;
   NextDay: TDateTime;
   sunset: TDateTime;
begin
   NextDay := IncDay(Nowtime, 1);

   // north->south
   for y := 90 downto -90 do begin
      // west->east
      for x := 180 downto -180 do begin
         // 各地点について昼夜判定
         FTime[x, y].Judge(Nowtime, FShowGrayline);

         // 既にsunsetを過ぎていたらsunriseは翌日について計算する
         sunset := FTime[x, y].SunsetMax;
         if (sunset > 0) and (Nowtime > sunset) then begin

            FSuntime.Latitude.Value := y;
            FSuntime.Longitude.Value := x;

            // 東経部は１日進める
            if x < 0 then begin
               FSuntime.Date := NextDay;
            end
            else begin
               FSuntime.Date := Nowtime;
            end;

            // 日の出
            if IsNan(FSuntime.sunrise) then begin
               FTime[x, y].Sunrise := 0;
            end
            else begin
               FTime[x, y].Sunrise := FSuntime.sunrise;
            end;

            // 日の入り
            if IsNan(FSuntime.sunset) then begin
               FTime[x, y].Sunset := 0;
            end
            else begin
               FTime[x, y].Sunset := FSuntime.sunset;
            end;
         end;
      end;
   end;
end;

procedure TGraylineMap.Draw(bmp: TBitmap);
type
   TRGBTripleArray = array[0..5000] of TRGBTriple;
   PTRGBTripleArray = ^TRGBTripleArray;
var
   bmp_w: Integer;
   bmp_h: Integer;
   w_rate: Extended;
   h_rate: Extended;
   x, y: Integer;
   xx, yy: Integer;
   P: PTRGBTripleArray;
   C: TGraylineTime;
   PX: RGBTriple;
begin
   bmp_w := bmp.Width;
   bmp_h := bmp.Height;
   w_rate := 360 / bmp_w;
   h_rate := 180 / bmp_h;

   for y := 0 to bmp_h - 1 do begin

      P := bmp.ScanLine[y];

      for x := 0 to bmp_w - 1 do begin
         xx := 180 - Trunc(x * w_rate);
         yy := 90 - Trunc(y * h_rate);

         C := FTime[xx, yy];

         if FShowGrayline = True then begin
            if C.GrayState = gsGrayline1 then begin
               PX := P^[x];

               PX.rgbtRed := Max(PX.rgbtRed - 64, 0);
               PX.rgbtGreen := Max(PX.rgbtGreen - 64, 0);
               PX.rgbtBlue := Max(PX.rgbtBlue - 64, 0);

               P^[x] := PX;
            end
            else if C.GrayState = gsGrayline2 then begin
               PX := P^[x];

               {$IFDEF DEBUG}
               PX.rgbtRed := Max(PX.rgbtRed - 32, 0);
               PX.rgbtGreen := Max(PX.rgbtGreen - 80, 0);
               PX.rgbtBlue := Max(PX.rgbtBlue - 80, 0);
               {$ELSE}
               PX.rgbtRed := Max(PX.rgbtRed - 64, 0);
               PX.rgbtGreen := Max(PX.rgbtGreen - 64, 0);
               PX.rgbtBlue := Max(PX.rgbtBlue - 64, 0);
               {$ENDIF}

               P^[x] := PX;
            end
            else if C.GrayState = gsNight then begin
               PX := P^[x];

               PX.rgbtRed := Max(PX.rgbtRed - 110, 0);
               PX.rgbtGreen := Max(PX.rgbtGreen - 110, 0);
               PX.rgbtBlue := Max(PX.rgbtBlue - 110, 0);

               P^[x] := PX;
            end;
         end
         else begin
            if C.GrayState = gsNight then begin
               PX := P^[x];

               PX.rgbtRed := Max(PX.rgbtRed - 110, 0);
               PX.rgbtGreen := Max(PX.rgbtGreen - 110, 0);
               PX.rgbtBlue := Max(PX.rgbtBlue - 110, 0);

               P^[x] := PX;
            end;
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

function TGraylineMap.GetDayTime(X: Integer; Y: Integer): TGraylineTime;
begin
   Result := FTime[X,Y];
end;

end.
