unit UGrayline;

//
// Grayline
//

// The world map was taken from the following website:
// https://www.freeworldmaps.net/physical.html

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  System.Math, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.DateUtils, System.StrUtils, Vcl.Imaging.pngimage,
  SunTime, UzLogForm, UzLogGlobal;

type
  TDaytime = class
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

  TGrayLine = class
    FTime: array[-180..180] of array[-90..90] of TDayTime;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Calc(Nowtime: TDateTime);
    procedure Judge(Nowtime: TDateTime);
    procedure Draw(bmp: TBitmap);
    procedure DrawLongitude(bmp: TBitmap; longitude: Extended; penstyle: TPenStyle = psSolid);
    procedure DrawLatitude(bmp: TBitmap; latitude: Extended; penstyle: TPenStyle = psSolid);
  end;

type
  TformGrayline = class(TZLogForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private êÈåæ }
    FPrevUtc: TDateTime;

    FGrayline: TGrayLine;

    FWorldmap: TBitmap;

    procedure GraylineProc();
  public
    { Public êÈåæ }
  end;

implementation

{$R *.dfm}

procedure TformGrayline.FormCreate(Sender: TObject);
var
   png: TPngImage;
begin
   FPrevUtc := 0;
   FGrayline := TGrayline.Create();

   png := TPngImage.Create();
   png.LoadFromResourceName(SysInit.HInstance, 'IDB_WORLDMAP');

   FWorldmap := TBitmap.Create(png.Width, png.Height);
   FWorldmap.PixelFormat := pf24bit;
   FWorldmap.Dormant();
   FWorldmap.Canvas.Draw(0, 0, png);

   Image1.Picture.Bitmap.Assign(FWorldmap);

   png.Free();
end;

procedure TformGrayline.FormDestroy(Sender: TObject);
begin
   Timer1.Enabled := False;
   FGrayline.Free();
   FWorldmap.Free();
end;

procedure TformGrayline.FormHide(Sender: TObject);
begin
   Timer1.Enabled := False;
end;

procedure TformGrayline.FormResize(Sender: TObject);
begin
   GraylineProc();
end;

procedure TformGrayline.FormShow(Sender: TObject);
begin
   Timer1Timer(nil);
   Timer1.Interval := 60 * 1000 * 5;   // 5min.
   Timer1.Enabled := True;
end;

procedure TformGrayline.GraylineProc();
var
   bmp: TBitmap;
   mylongitude: Extended;
begin
   bmp := TBitmap.Create();
   bmp.Assign(FWorldmap);

   // grayline
   FGrayline.Draw(bmp);

   // ê‘ìπ
   FGrayline.DrawLatitude(bmp, 0, psDash);

   // éqåﬂê¸
   FGrayline.DrawLongitude(bmp, 0, psDash);

   // é©ï™ÇÃà íu
   if dmZLogGlobal.Settings._mylongitude <> '' then begin
      mylongitude := StrToFloatDef(dmZLogGlobal.Settings._mylongitude, 0) * -1;
      FGrayline.DrawLongitude(bmp, mylongitude);
   end;

   Image1.Picture.Bitmap.Assign(bmp);
   bmp.Free();
end;

procedure TformGrayline.Timer1Timer(Sender: TObject);
var
   utc: TDateTime;
begin
   utc := Now;
   utc := IncHour(utc, -9);

   // ì˙Ç™ïœÇÌÇ¡ÇΩÇÁåvéZ
   if DayOf(utc) <> DayOf(FPrevUtc) then begin
      FGrayline.Calc(utc);
      FPrevUtc := utc;
   end;

   // graylineîªíË
   FGrayline.Judge(utc);

   // ï`âÊÉÅÉCÉì
   GraylineProc();
end;

constructor TDaytime.Create();
begin
   FSunrise := 0;
   FSunset := 0;
   FDaytime := True;
end;

constructor TDaytime.Create(ASunrise, ASunset: TDateTime);
begin
   Inherited Create();
   FSunrise := ASunrise;
   FSunset := ASunset;
end;

procedure TDayTime.Judge(Nowtime: TDateTime);
begin
   FDaytime := False;
   FGrayline := False;

   if (Nowtime >= IncMinute(FSunrise, -30)) and
      (Nowtime <= IncMinute(FSunrise, 30)) then begin
      FGrayline := True;
   end;
   if (Nowtime >= IncMinute(FSunset, -30)) and
      (Nowtime <= IncMinute(FSunset, 30)) then begin
      FGrayline := True;
   end;

   // åªç›éûçèÇ™ñÈñæÇØâﬂÇ¨Ç»ÇÁíãä‘
   if Nowtime >= FSunrise then begin
      FDaytime := True;
   end;

   // åªç›éûçèÇ™ì˙ñvÇâﬂÇ¨ÇƒÇ¢ÇΩÇÁñÈ
   if Nowtime >= FSunset then begin
      FDaytime := False;
   end;
end;

constructor TGrayline.Create();
var
   x, y: Integer;
begin
   for y := 90 downto -90 do begin
      for x := 180 downto -180 do begin
         FTime[x, y] := TDaytime.Create();
      end;
   end;
end;

destructor TGrayline.Destroy();
var
   x, y: Integer;
begin
   for y := 90 downto -90 do begin
      for x := 180 downto -180 do begin
         FTime[x, y].Free();
      end;
   end;
end;

procedure TGrayline.Calc(Nowtime: TDateTime);
var
   suntime: TSunTime;
   x, y: Integer;
begin
   // setrise/sunset
   suntime := TSunTime.Create(nil);
   suntime.UseSysTimeZone := False;
   suntime.TimeZone := 0;
   suntime.Date := Nowtime;

   // west->east
   for y := 90 downto -90 do begin
      for x := 180 downto -180 do begin

         suntime.Latitude.Value := y;
         suntime.Longitude.Value := x;

         if IsNan(suntime.sunrise) then begin
            FTime[x, y].Sunrise := 0;
         end
         else begin
            FTime[x, y].Sunrise := suntime.sunrise;
         end;

         if IsNan(suntime.sunset) then begin
            FTime[x, y].Sunset := 0;
         end
         else begin
            FTime[x, y].Sunset := suntime.sunset;
         end;

//         FTime[x, y].Judge(Nowtime);
      end;
   end;

   suntime.Free();
end;

procedure TGrayline.Judge(Nowtime: TDateTime);
var
   x, y: Integer;
begin
   for y := 90 downto -90 do begin
      for x := 180 downto -180 do begin
         FTime[x, y].Judge(Nowtime);
      end;
   end;
end;

procedure TGrayline.Draw(bmp: TBitmap);
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
   C: TDaytime;
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
      end;
   end;
end;

procedure TGrayline.DrawLongitude(bmp: TBitmap; longitude: Extended; penstyle: TPenStyle);
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

procedure TGrayline.DrawLatitude(bmp: TBitmap; latitude: Extended; penstyle: TPenStyle);
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

end.
