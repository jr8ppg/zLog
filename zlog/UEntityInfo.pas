unit UEntityInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Math, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.StrUtils,
  UzLogForm, UzLogGlobal, UMultipliers, SunTime;

type
  TformEntityInfo = class(TZLogForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    Panel2: TPanel;
    panelSunrise: TPanel;
    panelSunset: TPanel;
    panelAzimuth: TPanel;
    panelCQZone: TPanel;
    panelITUZone: TPanel;
    panelContinent: TPanel;
    Panel3: TPanel;
    panelCountryName: TPanel;
    panelCountry: TPanel;
    Label1: TLabel;
    SunTime1: TSunTime;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private êÈåæ }
    FBitmap: TBitmap;
    procedure DrawCompass(angle: Double; latitude: string; longitude: string; distance: string);
    function DegToDms(angle: Single): string;
    function LatitudeDegToDms(angle: Single): string;
    function LongitudeDegToDms(angle: Single): string;
    function IntToStr3(v: integer): string;
  public
    { Public êÈåæ }
    procedure SetData(ctydat: TCountry);
  end;

implementation

{$R *.dfm}

procedure TformEntityInfo.FormCreate(Sender: TObject);
begin
   FBitmap := TBitmap.Create(200, 200);
   FBitmap.PixelFormat := pf24bit;
   SetData(nil);
end;

procedure TformEntityInfo.FormDestroy(Sender: TObject);
begin
   FBitmap.Free();
end;

// https://keisan.casio.jp/exec/system/1257670779
// https://qiita.com/ht_deko/items/358e11a6cc0873eda667
procedure TformEntityInfo.SetData(ctydat: TCountry);
var
   x1, x2, y1, y2: Double;
   dx: Double;
   r: Double;
   distance: Double;
   azimuth: Double;
   angle: Double;
   rect: TRect;
   strLatitude, strLongitude, strDistance: string;
begin
   rect.Top := 0;
   rect.Left := 0;
   rect.Right := 199;
   rect.Bottom := 199;
   FBitmap.Canvas.Pen.Color := clWhite;
   FBitmap.Canvas.Pen.Style := psSolid;
   FBitmap.Canvas.Brush.Color := clWhite;
   FBitmap.Canvas.Brush.Style := bsSolid;
   FBitmap.Canvas.FillRect(rect);
   panelCountryName.Caption := '';
   panelCountry.Caption := '';
   panelCqZone.Caption := '';
   panelItuZone.Caption := '';
   panelContinent.Caption := '';
   strLatitude := '';
   strLongitude := '';
   strDistance := '';
   panelAzimuth.Caption := '';
   panelSunrise.Caption := '';
   panelSunset.Caption := '';

   if ctydat = nil then begin
      Image1.Picture.Assign(FBitmap);
      Exit;
   end;

   // ínãÖÇÃîºåa
   r := 6378.137;

   x1 := StrToFloatDef(dmZLogGlobal.Settings._mylongitude, 0) * -1;
   y1 := StrToFloatDef(dmZLogGlobal.Settings._mylatitude, 0);
   x2 := StrToFloatDef(ctydat.Longitude, 0) * -1;
   y2 := StrToFloatDef(ctydat.Latitude, 0);

   // Deg->Rad
   x1 := DegToRad(x1);
   y1 := DegToRad(y1);
   x2 := DegToRad(x2);
   y2 := DegToRad(y2);

   dx := x2 - x1;

   // ãóó£
   distance := r * ArcCos(Sin(y1) * Sin(y2) + Cos(y1) * Cos(y2) * Cos(dx));

   // ï˚à 
   angle := ArcTan2(Cos(y1) * Tan(y2) - Sin(y1) * Cos(dx), Sin(dx));
   angle := RadToDeg(angle);
   azimuth := FMod(360 + 90 - angle, 360);

   // EntityèÓïÒ
   panelCountryName.Caption := ctydat.CountryName;
   panelCountry.Caption := ctydat.Country;
   panelCqZone.Caption := ctydat.CQZone;
   panelItuZone.Caption := ctydat.ITUZone;
   panelContinent.Caption := ctydat.Continent;

   strLatitude := LatitudeDegToDms(StrToFloatDef(ctydat.Latitude, 0));
   strLongitude := LongitudeDegToDms(StrToFloatDef(ctydat.Longitude, 0) * -1);
   strDistance := IntToStr3(Trunc(distance)) + 'Km';
   panelAzimuth.Caption := IntToStr(Trunc(azimuth));

   // Sunrise/Sunset
   suntime1.Date := Now();
   suntime1.Latitude.Value := StrToFloatDef(ctydat.Latitude, 0);
   suntime1.Longitude.Value := StrToFloatDef(ctydat.Longitude, 0) * 1;
   if IsNan(suntime1.sunrise) then begin
      panelSunrise.Caption := '-';
   end
   else begin
      panelSunrise.Caption := FormatDateTime('mm/dd hh:nn', suntime1.sunrise);
   end;
   if IsNan(suntime1.sunset) then begin
      panelSunset.Caption := '-';
   end
   else begin
      panelSunset.Caption := FormatDateTime('mm/dd hh:nn', suntime1.sunset);
   end;

   // Compass
   DrawCompass(azimuth, strLatitude, strLongitude, strDistance);
end;

procedure TformEntityInfo.DrawCompass(angle: Double; latitude: string; longitude: string; distance: string);
var
   cx, cy, cl: Integer;
   ex, ey: Integer;
   rad: Double;
   w, h: Integer;
   x, y: Integer;
   rr: Integer;
   points: array[0..2] of TPoint;
   S: string;
begin
   cl := 80;
   rr := 200;
   cx := rr div 2;
   cy := rr div 2;
   rad := DegToRad(180 - angle);

   ex := cx + Round(cl * Sin(rad));
   ey := cy + Round(cl * Cos(rad));

   // äOòg
   FBitmap.Canvas.Pen.Color := clBlack;
   FBitmap.Canvas.Pen.Width := 1;
   FBitmap.Canvas.Brush.Style := bsClear;
   FBitmap.Canvas.Ellipse(cx - (cl + 2), cy - (cl + 2), cx + (cl + 2), cy + (cl + 2));

   // ï˚à ï\é¶
   FBitmap.Canvas.Brush.Color := clWhite;
   FBitmap.Canvas.Font.Name := 'ÇlÇr ÉSÉVÉbÉN';
   FBitmap.Canvas.Font.Size := 12;
   w := FBitmap.Canvas.TextWidth('X');
   h := FBitmap.Canvas.TextHeight('X');

   x := (rr - w) div 2;
   FBitmap.Canvas.TextOut(x, 1, 'N');
   FBitmap.Canvas.TextOut(x, rr - h - 1, 'S');

   x := (((rr - cl * 2) div 2)- w) div 2 + 1;
   y := (rr - h) div 2;
   FBitmap.Canvas.TextOut(x, y, 'W');

   x := (rr - cl * 2) div 2;
   x := (rr - x) + ((x - w) div 2) + 1;
   FBitmap.Canvas.TextOut(x, y, 'E');

   // à‹ìxÅEåoìx
   FBitmap.Canvas.Font.Size := 9;
   h := FBitmap.Canvas.TextHeight('X');
   x := 2;
   y := rr - ((h + 0) * 2);
   FBitmap.Canvas.TextOut(x, y, latitude);
   y := rr - ((h + 0) * 1);
   FBitmap.Canvas.TextOut(x, y, longitude);

   x := rr - FBitmap.Canvas.TextWidth(distance) - 2;
   FBitmap.Canvas.TextOut(x, y, distance);

   // ê^ÇÒíÜÇÃä€
   FBitmap.Canvas.Pen.Width := 1;
   FBitmap.Canvas.Brush.Color := clBlack;
   FBitmap.Canvas.Ellipse(cx - 4, cy - 4, cx + 4, cy + 4);

   // ï˚å¸
   FBitmap.Canvas.Pen.Width := 2;
   FBitmap.Canvas.MoveTo(cx, cy);
   FBitmap.Canvas.LineTo(ex, ey);

   // ñÓàÛ
   FBitmap.Canvas.Pen.Width := 1;
   points[0].X := ex;
   points[0].Y := ey;
   points[1].X := ex + Round(20 * Sin(DegToRad(360 - angle - 45)));
   points[1].Y := ey + Round(20 * Cos(DegToRad(360 - angle - 45)));
   points[2].X := ex + Round(20 * Sin(DegToRad(360 - angle + 45)));
   points[2].Y := ey + Round(20 * Cos(DegToRad(360 - angle + 45)));
   FBitmap.Canvas.Polygon(points);

   // äpìxï\é¶
   S := IntToStr(Trunc(angle));
   FBitmap.Canvas.Font.Size := 18;
   FBitmap.Canvas.Brush.Style := bsClear;
   w := FBitmap.Canvas.TextWidth(S);
   h := FBitmap.Canvas.TextHeight('X');
   x := (rr - w) div 2;
   if (angle < 90) or (angle > 270) then begin
      y := cy + 4;
   end
   else begin
      y := cy - h - 4;
   end;
   FBitmap.Canvas.TextOut(x, y, S);

   // ï`âÊ
   Image1.Picture.Assign(FBitmap);
end;

function TformEntityInfo.DegToDms(angle: Single): string;
var
   d: Integer;
   m: Integer;
   s: Integer;
   x: Single;
begin
   d := Trunc(angle);
   x := Frac(angle);
   m := Trunc(SimpleRoundTo(x * 60, -2));
   s := Trunc((SimpleRoundTo(x * 60, -2) - Single(m)) * 60);

   Result := IntToStr(d) + ':' + RightStr('00' + IntToStr(m), 2) + ':' + RightStr('00' + IntToStr(s), 2);
end;

function TformEntityInfo.LatitudeDegToDms(angle: Single): string;
begin
   if angle < 0 then begin
      Result := 'S' + DegToDms(Abs(angle));
   end
   else begin
      Result := 'N' + DegToDms(angle);
   end;
end;

function TformEntityInfo.LongitudeDegToDms(angle: Single): string;
begin
   if angle < 0 then begin
      Result := 'W' + DegToDms(Abs(angle));
   end
   else begin
      Result := 'E' + DegToDms(angle);
   end;
end;

function TformEntityInfo.IntToStr3(v: integer): string;
var
   i: integer;
   c: integer;
   strText: string;
   strFormatedText: string;
begin
   strText := IntToStr(v);
   strFormatedText := '';

   c := 0;
   for i := Length(strText) downto 1 do begin
      if c >= 3 then begin
         strFormatedText := ',' + strFormatedText;
         c := 0;
      end;
      strFormatedText := Copy(strText, i, 1) + strFormatedText;
      inc(c);
   end;

   Result := strFormatedText;
end;

end.
