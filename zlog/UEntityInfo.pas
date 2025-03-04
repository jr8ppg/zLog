unit UEntityInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Math, Vcl.StdCtrls, Vcl.ExtCtrls,
  UzLogForm, UzLogGlobal, UMultipliers;

type
  TformEntityInfo = class(TZLogForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    editCountryName: TEdit;
    editCqZone: TEdit;
    editItuZone: TEdit;
    editContinent: TEdit;
    Image1: TImage;
    labelAzimuth: TLabel;
    labelLongitude: TLabel;
    labelLatitude: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private éŒ¾ }
    FBitmap: TBitmap;
    procedure DrawCompass(angle: Double);
  public
    { Public éŒ¾ }
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
   editCountryName.Text := '';
   editCqZone.Text := '';
   editItuZone.Text := '';
   editContinent.Text := '';
   labelLatitude.Caption := '';
   labelLongitude.Caption := '';
   labelAzimuth.Caption := '';

   if ctydat = nil then begin
      Image1.Picture.Assign(FBitmap);
      Exit;
   end;

   // ’n‹…‚Ì”¼Œa
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

   // ‹——£
   distance := r * ArcCos(Sin(y1) * Sin(y2) + Cos(y1) * Cos(y2) * Cos(dx));

   // •ûˆÊ
   angle := ArcTan2(Cos(y1) * Tan(y2) - Sin(y1) * Cos(dx), Sin(dx));
   angle := RadToDeg(angle);
   azimuth := FMod(360 + 90 - angle, 360);

   editCountryName.Text := ctydat.CountryName;
   editCqZone.Text := ctydat.CQZone;
   editItuZone.Text := ctydat.ITUZone;
   editContinent.Text := ctydat.Continent;
   labelLatitude.Caption := ctydat.Latitude;
   labelLongitude.Caption := ctydat.Longitude;
//   editDistance.Text := FloatToStr(distance);
   labelAzimuth.Caption := IntToStr(Trunc(azimuth));

   DrawCompass(azimuth);
end;

procedure TformEntityInfo.DrawCompass(angle: Double);
var
   cx, cy, cl: Integer;
   ex, ey: Integer;
   rad: Double;
   w, h: Integer;
   x, y: Integer;
   rr: Integer;
   points: array[0..2] of TPoint;
begin
   cl := 80;
   rr := 200;
   cx := rr div 2;
   cy := rr div 2;
   rad := DegToRad(180 - angle);

   ex := cx + Round(cl * Sin(rad));
   ey := cy + Round(cl * Cos(rad));

   // ŠO˜g
   FBitmap.Canvas.Pen.Color := clBlack;
   FBitmap.Canvas.Pen.Width := 1;
   FBitmap.Canvas.Brush.Style := bsClear;
   FBitmap.Canvas.Ellipse(cx - (cl + 2), cy - (cl + 2), cx + (cl + 2), cy + (cl + 2));

   // •ûˆÊ•\Ž¦
   FBitmap.Canvas.Brush.Color := clWhite;
   FBitmap.Canvas.Font.Name := '‚l‚r ƒSƒVƒbƒN';
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

   // •ûŒü
   FBitmap.Canvas.Pen.Width := 2;
   FBitmap.Canvas.MoveTo(cx, cy);
   FBitmap.Canvas.LineTo(ex, ey);

   // –îˆó
   FBitmap.Canvas.Pen.Width := 1;
   FBitmap.Canvas.Brush.Color := clBlack;
   points[0].X := ex;
   points[0].Y := ey;
   points[1].X := ex + Round(20 * Sin(DegToRad(360 - angle - 45)));
   points[1].Y := ey + Round(20 * Cos(DegToRad(360 - angle - 45)));
   points[2].X := ex + Round(20 * Sin(DegToRad(360 - angle + 45)));
   points[2].Y := ey + Round(20 * Cos(DegToRad(360 - angle + 45)));
   FBitmap.Canvas.Polygon(points);

   // •`‰æ
   Image1.Picture.Assign(FBitmap);
end;

end.
