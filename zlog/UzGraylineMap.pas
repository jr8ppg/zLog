unit UzGraylineMap;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  System.Math, Vcl.StdCtrls, System.DateUtils, System.StrUtils, SunTime;

type
  TGraylineTime = class
    FSunrise: TDateTime;
    FSunset: TDateTime;
    FDaytime: Boolean;
    FGrayline: Boolean;
  public
    constructor Create(); overload;
    constructor Create(ASunrise, ASunset: TDateTime); overload;
    procedure Judge(Nowtime: TDateTime);
    property Sunrise: TDateTime read FSunrise write FSunrise;
    property Sunset: TDateTime read FSunset write FSunset;
    property Daytime: Boolean read FDaytime;
    property Grayline: Boolean read FGrayline;
  end;

  TGrayLineMap = class
    FSuntime: TSunTime;
    FTime: array[-180..180] of array[-90..90] of TGraylineTime;
  private
    function GetDayTime(X: Integer; Y: Integer): TGraylineTime;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Calc(Nowtime: TDateTime);
    procedure Judge(Nowtime: TDateTime);
    procedure Draw(bmp: TBitmap; fShowGrayline: Boolean);
    procedure DrawLongitude(bmp: TBitmap; longitude: Extended; penstyle: TPenStyle = psSolid);
    procedure DrawLatitude(bmp: TBitmap; latitude: Extended; penstyle: TPenStyle = psSolid);
    property DayTime[X: Integer; Y: Integer]: TGraylineTime read GetDayTime;
  end;

implementation

constructor TGraylineTime.Create();
begin
   FSunrise := 0;
   FSunset := 0;
   FDaytime := True;
end;

constructor TGraylineTime.Create(ASunrise, ASunset: TDateTime);
begin
   Inherited Create();
   FSunrise := ASunrise;
   FSunset := ASunset;
end;

procedure TGraylineTime.Judge(Nowtime: TDateTime);
begin
   FDaytime := False;
   FGrayline := False;

   // grayline判定
   if (Nowtime >= IncMinute(FSunrise, -30)) and
      (Nowtime <= IncMinute(FSunrise, 30)) then begin
      FGrayline := True;
   end;
   if (Nowtime >= IncMinute(FSunset, -30)) and
      (Nowtime <= IncMinute(FSunset, 30)) then begin
      FGrayline := True;
   end;

   if FSunrise <= FSunset then begin
      if (Nowtime >= FSunrise) and (Nowtime <= FSunset) then begin
         FDaytime := True;
      end
      else begin
         FDaytime := False;
      end;
   end
   else begin
//      if (Nowtime >= FSunset) and (Nowtime <= FSunrise) then begin
//         FDaytime := False;
//      end
//      else begin
//         FDaytime := True;
//      end;
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
begin
   // setrise/sunset
   PrevDay := IncDay(Nowtime, -1);

   // west->east
   for y := 90 downto -90 do begin

      for x := 180 downto -180 do begin

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

         // 日の出
         if IsNan(FSuntime.sunrise) then begin
            FTime[x, y].Sunrise := 0;
         end
         else begin
            FTime[x, y].Sunrise := FSuntime.sunrise;
         end;

//         FTime[x, y].Judge(Nowtime);
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

   for y := 90 downto -90 do begin
      for x := 180 downto -180 do begin
         sunset := FTime[x, y].Sunset;

         // 既にsunsetを過ぎていたらsunriseは翌日について計算する
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

         FTime[x, y].Judge(Nowtime);
      end;
   end;
end;

procedure TGraylineMap.Draw(bmp: TBitmap; fShowGrayline: Boolean);
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

         if fShowGrayline = True then begin
            if C.Grayline = True then begin
               PX := P^[x];

               PX.rgbtRed := Max(PX.rgbtRed - 64, 0);
               PX.rgbtGreen := Max(PX.rgbtGreen - 64, 0);
               PX.rgbtBlue := Max(PX.rgbtBlue - 64, 0);

               P^[x] := PX;
            end
            else if C.DayTime = False then begin
               PX := P^[x];

               PX.rgbtRed := Max(PX.rgbtRed - 110, 0);
               PX.rgbtGreen := Max(PX.rgbtGreen - 110, 0);
               PX.rgbtBlue := Max(PX.rgbtBlue - 110, 0);

               P^[x] := PX;
            end;
         end
         else begin
            if C.DayTime = False then begin
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
