unit Hemibtn;

{*
** THemisphereButton implementation
** Copyright (c) 1997 Christian Schnell
**
** Author: Christian Schnell
**         lulli@cs.tu-berlin.de
**         http://www.cs.tu-berlin.de/~lulli
** 
** History:
**
** .p00 [19970627cs] first release
** .p01 [19970801cs] [sub-release]
**                   removed MATH-usage, added functions ceil() and floor().
** .p02 [19970814cs] [sub-release]
**                   added user-bitmap UserBitmap, lower left pixel is
**                     reserved for transparent color.
** .p03 [19970815cs] renamed UserBitmap to Glyph, added NumGlyphs,
**                     GlyphIndex
**                   stripped CalcImages, fixed: mouse events, default size
**                   added shaded glyphs
**      [19970821cs] added GlyphMapped, AttenControl
**                   added arctan2
**                   changed illumination model
**                     removed fColorBright, redDt, greenDt, blueDt
**                   renamed Pressed to Down
**                   added ParentShowHint, ShowHint
** .p04 [19970823cs] [sub-release]
**      [19970825cs] added FaceShaded
**                   bmIn and bmOut now calculated in one step
**                   bug-fix: Glyph painting on odd width or height
**                   problem: ParentFont seems not possible, TControl.Font is
**                            protected (cannot access Parent.Font!)
**                   added FaceTransparent, GlyphTransparent
** .p05 [19970826cs] [sub-release]
** .p06 [19970831cs] added bmMask, background-clip-mask is now persistent
**                   calling Paint indirectly now (Invalidate), except SetDown
**                   right mouse click ignored now
**                   made changes for Delphi1
**                   [sub-release]
** .p07 [19971006cs] 2nd release (as 2.0)
**                   OK for Delphi1, Delphi2 and Delphi3
** .p08 [19971030cs] 3rd release (as 2.1)
**                   Bug-fix:
**                     - added fFont.Free in destructor
**                     - fixed Delphi1\HemiBtn.dcr (was bad in release 2.0)
**                   Changed:
**                     - New glyph for component-palette, note that if you
**                       are upgrading from release 2.0, you must reinstall
**                       the component to see the new image in your IDE.
*}

interface

uses
  {$IFDEF VER80}
  WinProcs, WinTypes, Menus,
  {$ELSE}
  Windows,
  {$ENDIF}
  SysUtils, Forms, Classes, Controls, Graphics, Math;

const
  cDefaultColor = clGray;   { default face color                          }
  cDefaultWidth = 25;       { default dimensions                          }
  cDefaultHeight = 25;
  cLightX = -0.5773502692;  { vector to light-source,                     }
  cLightY = -0.5773502692;  { left-handed coordinate system               }
  cLightZ =  0.5773502692;  { (points to upper-left corner, Windows-std.) }

type
  THemisphereBevel = (hbNone, hbLowered, hbRaised);

  THemisphereButton = class(TGraphicControl)
  protected
    faceRed, faceGreen, faceBlue : TColor;
    bmUnpressed, bmPressed, bmMask, bmGlpyh: TBitmap;
    oldWidth, oldHeight, fBevelWidth, fGroupIndex,
    fNumGlyphs, fGlyphIndex: Integer;
    GlyphValid, InMousePress, oldDown,
    fDown, fAllowAllUp, fFaceShaded, fGlyphShaded,
    fGlyphMapped, fGlyphTransparent, fFaceTransparent: Boolean;
    fBorderColor, fFaceColor: TColor;
    fOnClick, fOnDblClick: TNotifyEvent;
    fBevelOuter, fBevelInner: THemisphereBevel;
    fOnMouseDown, fOnMouseUp: TMouseEvent;
    fOnMouseMove: TMouseMoveEvent;
    fBorderStyle: TBorderStyle;
    fAttenControl: Double;
    fCaption: String;
    fFont: TFont;
    procedure CalcImages;
    procedure DefineProperties(Filer: TFiler); override;
    function  InsideEllipse(X,Y: Integer): Boolean;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure ReadGlyphValid(Reader: TReader);
    procedure ReadImageGlyph(Stream: TStream);
    procedure ReadImageIn(Stream: TStream);
    procedure ReadImageMask(Stream: TStream);
    procedure ReadImageOut(Stream: TStream);
    procedure RenderBorder(aCanvas: TCanvas; X0,Y0,X1,Y1, bevWidth: Integer; Raised: Boolean);
    procedure RenderButtonFaces(nBorder: Integer; mskBorder, canvUp, canvDown: TCanvas);
    procedure SetAllowAllUp(Value: Boolean);
    procedure SetAttenControl(Value: Double);
    procedure SetBevelInner(Value: THemisphereBevel);
    procedure SetBevelOuter(Value: THemisphereBevel);
    procedure SetBevelWidth(Value: Integer);
    procedure SetBorderColor(Value: TColor);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetBounds(aLeft, aTop, aWidth, aHeight: Integer); override;
    procedure SetCaption(Value: String);
    procedure SetDown(Value: Boolean);
    procedure SetFaceColor(Value: TColor);
    procedure SetFaceShaded(Value: Boolean);
    procedure SetFaceTransparent(Value: Boolean);
    procedure SetFont(Value: TFont);
    procedure SetGlyph(Value: TBitmap);
    procedure SetGlyphIndex(Value: Integer);
    procedure SetGlyphMapped(Value: Boolean);
    procedure SetGlyphShaded(Value: Boolean);
    procedure SetGlyphTransparent(Value: Boolean);
    procedure SetNumGlyphs(Value: Integer);
    procedure WriteGlyphValid(Writer: TWriter);
    procedure WriteImageGlyph(Stream: TStream);
    procedure WriteImageIn(Stream: TStream);
    procedure WriteImageMask(Stream: TStream);
    procedure WriteImageOut(Stream: TStream);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property AllowAllUp: Boolean read fAllowAllUp write SetAllowAllUp;
    property AttenControl: Double read fAttenControl write SetAttenControl;
    property BevelInner: THemisphereBevel read fBevelInner write SetBevelInner;
    property BevelOuter: THemisphereBevel read fBevelOuter write SetBevelOuter;
    property BevelWidth: Integer read fBevelWidth write SetBevelWidth;
    property BorderColor: TColor read fBorderColor write SetBorderColor;
    property BorderStyle: TBorderStyle read fBorderStyle write SetBorderStyle;
    property Caption: String read fCaption write SetCaption;
    property Down: Boolean read fDown write SetDown;
    property Enabled;
    property FaceColor: TColor read fFaceColor write SetFaceColor;
    property FaceShaded: Boolean read fFaceShaded write SetFaceShaded;
    property FaceTransparent: Boolean read fFaceTransparent write SetFaceTransparent;
    property Font: TFont read fFont write SetFont;
    property Glyph: TBitmap read bmGlpyh write SetGlyph stored False; { We store it, TBitmap is buggy }
    property GlyphIndex: Integer read fGlyphIndex write SetGlyphIndex;
    property GlyphShaded: Boolean read fGlyphShaded write SetGlyphShaded;
    property GlyphMapped: Boolean read fGlyphMapped write SetGlyphMapped;
    property GlyphTransparent: Boolean read fGlyphTransparent write SetGlyphTransparent;
    property GroupIndex: Integer read fGroupIndex write fGroupIndex;
    property Hint;
    property NumGlyphs: Integer read fNumGlyphs write SetNumGlyphs;
    property OnClick: TNotifyEvent read fOnClick write fOnClick;
    property OnDblClick: TNotifyEvent read fOnDblClick write fOnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    {$IFNDEF VER80}
    property OnStartDrag;
    {$ENDIF}
    property OnMouseDown: TMouseEvent read fOnMouseDown write fOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read fOnMouseMove write fOnMouseMove;
    property OnMouseUp: TMouseEvent read fOnMouseUp write fOnMouseUp;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
  end;

  procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Rendered', [THemisphereButton]);
end;

function Ceil(X: Double): Longint;
begin
  Result := Trunc(X);
  if Frac(X) > 0 then Inc(Result);
end;

function Floor(X: Double): Longint;
begin
  Result := Trunc(X);
  if Frac(X) < 0 then Dec(Result);
end;

function ArcTan2(Y, X: Double): Double;
begin
   Result := Math.ArcTan2(Y, X);
end;

constructor THemisphereButton.Create(aOwner: TComponent);
begin
  fFont := TFont.Create;
  inherited Create(aOwner);
  bmUnpressed := TBitmap.Create;
  bmPressed := TBitmap.Create;
  bmMask := TBitmap.Create;
  bmGlpyh := TBitmap.Create;
  oldWidth := -1;
  oldHeight := -1;
  fBevelWidth := 2;
  fBevelInner := hbNone;
  fBevelOuter := hbLowered;
  fBorderStyle := bsNone;
  fBorderColor := clGray;
  fNumGlyphs := 1;
  fGlyphIndex := 1;
  fAttenControl := 1.0;
  fFaceShaded := True;
  fGlyphShaded := True;
  fGlyphTransparent := True;
  fFaceColor := cDefaultColor;
  faceRed := cDefaultColor and $ff;
  faceGreen := (cDefaultColor shr 8) and $ff;
  faceBlue := (cDefaultColor shr 16) and $ff;
  inherited SetBounds(Left, Top, cDefaultWidth, cDefaultHeight);
end;

destructor THemisphereButton.Destroy;
begin
  fFont.Free;
  bmUnpressed.Free;
  bmPressed.Free;
  bmMask.Free;
  bmGlpyh.Free;
  inherited Destroy;
end;

procedure THemisphereButton.ReadImageIn(Stream: TStream);
begin
  bmPressed.LoadFromStream(Stream);
end;

procedure THemisphereButton.ReadImageOut(Stream: TStream);
begin
  bmUnpressed.LoadFromStream(Stream);
end;

procedure THemisphereButton.ReadImageMask(Stream: TStream);
begin
  bmMask.LoadFromStream(Stream);
end;

procedure THemisphereButton.ReadImageGlyph(Stream: TStream);
begin
  bmGlpyh.LoadFromStream(Stream);
end;

procedure THemisphereButton.WriteImageIn(Stream: TStream);
begin
  bmPressed.SaveToStream(Stream);
end;

procedure THemisphereButton.WriteImageOut(Stream: TStream);
begin
  bmUnpressed.SaveToStream(Stream);
end;

procedure THemisphereButton.WriteImageMask(Stream: TStream);
begin
  bmMask.SaveToStream(Stream);
end;

procedure THemisphereButton.WriteImageGlyph(Stream: TStream);
begin
  bmGlpyh.SaveToStream(Stream);
end;

procedure THemisphereButton.ReadGlyphValid(Reader: TReader);
begin
  GlyphValid := Reader.ReadBoolean;
end;

procedure THemisphereButton.WriteGlyphValid(Writer: TWriter);
begin
  Writer.WriteBoolean(GlyphValid);
end;

procedure THemisphereButton.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('GlyphValid', ReadGlyphValid, WriteGlyphValid, True);
  Filer.DefineBinaryProperty('ImageOut', ReadImageOut, WriteImageOut, True);
  Filer.DefineBinaryProperty('ImageIn', ReadImageIn, WriteImageIn, True);
  Filer.DefineBinaryProperty('ImageMask', ReadImageMask, WriteImageMask, True);
  Filer.DefineBinaryProperty('ImageGlyph', ReadImageGlyph, WriteImageGlyph, GlyphValid);
end;

procedure THemisphereButton.SetAllowAllUp(Value: Boolean);
var
  i: Integer;
begin
  if Value <> fAllowAllUp then begin
    if (csLoading in ComponentState) or (GroupIndex = 0) then
      fAllowAllUp := Value
    else
      for i:=0 to Owner.ComponentCount-1 do
        if Owner.Components[i] is THemisphereButton then
          if THemisphereButton(Owner.Components[i]).GroupIndex = GroupIndex then
            THemisphereButton(Owner.Components[i]).fAllowAllUp := Value;
  end;
end;

procedure THemisphereButton.SetAttenControl(Value: Double);
begin
  if fAttenControl <> Value then begin
    fAttenControl := Value;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetBevelWidth(Value: Integer);
begin
  if (fBevelWidth <> Value) and (Value >= 1) then begin
    fBevelWidth := Value;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetBevelInner(Value: THemisphereBevel);
begin
  if fBevelInner <> Value then begin
    fBevelInner := Value;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetBevelOuter(Value: THemisphereBevel);
begin
  if fBevelOuter <> Value then begin
    fBevelOuter := Value;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetBorderColor(Value: TColor);
begin
  if fBorderColor <> Value then begin
    fBorderColor := Value;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetBorderStyle(Value: TBorderStyle);
begin
  if fBorderStyle <> Value then begin
    fBorderStyle := Value;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetBounds(aLeft, aTop, aWidth, aHeight: Integer);
begin
  inherited SetBounds(aLeft, aTop, aWidth, aHeight);
  if (aWidth <> oldWidth) or (aHeight <> oldHeight) then begin
    if not (csLoading in ComponentState) then begin
      CalcImages;
      Invalidate;
    end;
    oldWidth := aWidth;
    oldHeight := aHeight;
  end;
end;

procedure THemisphereButton.SetCaption(Value: String);
begin
  if fCaption <> Value then begin
    fCaption := Value;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetDown(Value: Boolean);
begin
  if fDown <> Value then begin
    fDown := Value;
    Paint; {Invalidate;}
  end;
end;

procedure THemisphereButton.SetFaceColor(Value: TColor);
begin
  if fFaceColor <> Value then begin
    faceBlue := (Value shr 16) and $ff;
    faceGreen := (Value shr 8) and $ff;
    faceRed := Value and $ff;
    fFaceColor := Value;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetFaceShaded(Value: Boolean);
begin
  if fFaceShaded <> Value then begin
    fFaceShaded := Value;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetFaceTransparent(Value: Boolean);
begin
  if fFaceTransparent <> Value then begin
    fFaceTransparent := Value;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetFont(Value: TFont);
begin
  fFont.Assign(Value);
  CalcImages;
  Invalidate;
end;

procedure THemisphereButton.SetGlyph(Value: TBitmap);
var
  r: TRect;
begin
  if bmGlpyh <> Value then begin
    if Value = nil then
      GlyphValid := False
    else begin
      GlyphValid := True;
      bmGlpyh.Width := Value.Width;
      bmGlpyh.Height := Value.Height;
      r := Rect(0, 0, Value.Width, Value.Height);
      bmGlpyh.Canvas.CopyRect(r, Value.Canvas, r);
      if (bmGlpyh.Height<>0) and (bmGlpyh.Width mod bmGlpyh.Height=0) then
        fNumGlyphs := bmGlpyh.Width div bmGlpyh.Height
      else
        fNumGlyphs := 1;
      fGlyphIndex := 1;
    end;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetGlyphIndex(Value: Integer);
begin
  if (fGlyphIndex <> Value) and (Value > 0) and
     ((csLoading in ComponentState) or (Value <= fNumGlyphs)) then begin
    fGlyphIndex := Value;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetGlyphMapped(Value: Boolean);
begin
  if fGlyphMapped <> Value then begin
    fGlyphMapped := Value;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetGlyphShaded(Value: Boolean);
begin
  if fGlyphShaded <> Value then begin
    fGlyphShaded := Value;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetGlyphTransparent(Value: Boolean);
begin
  if fGlyphTransparent <> Value then begin
    fGlyphTransparent := Value;
    CalcImages;
    Invalidate;
  end;
end;

procedure THemisphereButton.SetNumGlyphs(Value: Integer);
begin
  if fNumGlyphs <> Value then begin
    fNumGlyphs := Value;
    CalcImages;
    Invalidate;
  end;
end;

function THemisphereButton.InsideEllipse(X,Y: Integer): Boolean;
var
  borderSz: Integer;
  w2, h2: Double;
begin
  w2 := Width/2;
  h2 := Height/2;
  borderSz := 0;
  if fBevelOuter <> hbNone then inc(borderSz, fBevelWidth);
  if fBevelInner <> hbNone then inc(borderSz, fBevelWidth);
  Result := sqr((X-w2)/(w2-borderSz)) + sqr((Y-h2)/(h2-borderSz)) <= 1.0;
end;

procedure THemisphereButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Enabled and InsideEllipse(X,Y) then begin
    if Assigned(fOnMouseDown) then
      fOnMouseDown(Self, Button, Shift, X, Y);
    if (Button = mbLeft) then begin
      InMousePress := True;
      oldDown := Down;
      Down := True;
      if (ssDouble in Shift) and Assigned(fOnDblClick) then
        fOnDblClick(Self);
    end;
  end;
end;

procedure THemisphereButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if InMousePress and not oldDown then
    Down := InsideEllipse(X,Y);
  if Assigned(fOnMouseMove) then
    fOnMouseMove(Self, Shift, X, Y);
end;

procedure THemisphereButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
  aHb: THemisphereButton;
begin
  if InMousePress then begin
    InMousePress := False;
    if InsideEllipse(X,Y) then begin
      if Assigned(fOnClick) then
        fOnClick(Self);
      if GroupIndex = 0 then
        Down := False
      else begin
        if not (not fAllowAllUp and oldDown) then begin
          for i:=0 to Owner.ComponentCount-1 do
            if (Owner.Components[i] is THemisphereButton) and
               (Owner.Components[i] <> Self) then begin
              aHb := THemisphereButton(Owner.Components[i]);
              if aHb.GroupIndex = GroupIndex then
                aHb.Down := False;
            end;
          Down := not oldDown;
        end;
      end;
    end;
  end;
  if Assigned(fOnMouseUp) then
    fOnMouseUp(Self, Button, Shift, X, Y);
end;

procedure THemisphereButton.RenderBorder(aCanvas: TCanvas; X0,Y0,X1,Y1, bevWidth: Integer; Raised: Boolean);
var
  cX, cY, Len2d, Len3d, dirX, dirY, dirZ: Double;
  aGreyVal, nWayDelta: Longint;

  procedure SetPixel(X,Y: Integer; normX, normY, normZ: Double);
  begin
    aGreyVal := 128 + Round(128*(cLightX*normX + cLightY*normY + cLightZ*normZ));
    if aGreyVal > 255 then aGreyVal := 255
    else if aGreyVal < 0 then aGreyVal := 0;
    aCanvas.Pixels[x,y] := (aGreyVal shl 16) or (aGreyVal shl 8) or aGreyVal;
  end;

  procedure SetPixel4Way(X, Y: Integer);
  begin
    if (X=0) and (Y=0) then begin
      SetPixel(0,0,0,0,1);
      exit;
    end;
    Len2d := sqrt(sqr(X)+sqr(Y));
    Len3d := sqrt(sqr(X)+sqr(Y)+sqr(Len2d));
    dirX := -X/Len3d;
    dirY := Y/Len3d;
    dirZ := Len2d/Len3d;
    if not Raised then begin
      dirX := -dirX;
      dirY := -dirY;
    end;
    SetPixel(Ceil(cX+X),  Ceil(cY-Y),  -dirX, -dirY, dirZ);  { Right-Top    }
    SetPixel(Ceil(cX+X),  Floor(cY+Y), -dirX,  dirY, dirZ);  { Right-Bottom }
    SetPixel(Floor(cX-X), Floor(cY+Y),  dirX,  dirY, dirZ);  { Left-Bottom  }
    SetPixel(Floor(cX-X), Ceil(cY-Y),   dirX, -dirY, dirZ);  { Left-Top     }
  end;

  procedure SetPixelNWay(X,Y: Integer);
  var
    i, j: Integer;
  begin
    for i := Y-nWayDelta to Y+nWayDelta do
      for j := X-nWayDelta to X+nWayDelta do
        SetPixel4Way(j, i);
  end;

var
  a, b, x, y, a2, b2, d1, d2: Double;
begin
  nWayDelta := 1 + Ceil(bevWidth/2);
  a := (X1-X0-1) / 2;
  b := (Y1-Y0-1) / 2;
  cX := X0 + a;
  cY := Y0 + b;
  x := 0;
  y := b;
  a2 := sqr(a);
  b2 := sqr(b);
  d1 := b2 - a2*b + a2/4;
  SetPixelNWay(Round(x), Round(y));
  while (a2*(y-0.5) > b2*(x+1)) do begin
    if d1 < 0 then begin
      d1 := d1 + b2*(2*x+3);
      x := x + 1;
    end else begin
      d1 := d1 + b2*(2*x+3)+a2*(-2*y+2);
      x := x + 1;
      y := y - 1;
    end;
    SetPixelNWay(Round(x), Round(y));
  end;
  d2 := b2*sqr(x+0.5)+a2*sqr(y-1)-a2*b2;
  while y > 0 do begin
    if d2 < 0 then begin
      d2 := d2 + b2*(2*x+2)+a2*(-2*y+3);
      x := x + 1;
      y := y - 1;
    end else begin
      d2 := d2 + a2*(-2*y + 3);
      y := y - 1;
    end;
    SetPixelNWay(Round(x), Round(y));
  end;
end;

procedure THemisphereButton.RenderButtonFaces(nBorder: Integer; mskBorder, canvUp, canvDown: TCanvas);
var
  glyWidth, glyHeight, glyXOfs,
  x, y, xlen, ylen, x0, x1, y0, y1,
  gX, gY, w, h: Integer;
  cx, cy, Xe, Ye, Ze, atten: Double;
  rr, gg, bb, rrr, ggg, bbb, transp, col: TColor;
  isFromGlyph: Boolean;

  procedure SetFacePixel(pX, pY: Integer; normX, normY, normZ: Double);
    function CalcRGBAtten: TColor;
    begin
      rrr := rr + Round(rr * atten);
      ggg := gg + Round(gg * atten);
      bbb := bb + Round(bb * atten);
      if rrr < 0 then rrr := 0 else if rrr > 255 then rrr := 255;
      if ggg < 0 then ggg := 0 else if ggg > 255 then ggg := 255;
      if bbb < 0 then bbb := 0 else if bbb > 255 then bbb := 255;
      Result := (bbb shl 16) or (ggg shl 8) or rrr;
    end;
  begin
    isFromGlyph := false;
    if GlyphValid then begin
      if fGlyphMapped then begin
        gX := Floor((glyWidth-1) * arctan2(normZ, -normX) / Pi);
        gY := Floor((glyHeight-1) * arctan2(normZ, -normY) / Pi);
      end else begin { map glyph 1:1 }
        gX := Floor(glyWidth/2 + pX - cx);
        gY := Floor(glyHeight/2 + pY - cy);
      end;
      { [gX, gY] inside glyph? }
      if (gX>=0) and (gX<glyWidth) and (gY>=0) and (gY<glyHeight) then begin
        col := bmGlpyh.Canvas.Pixels[glyXOfs + gX, gY];
        if not fGlyphTransparent or (col <> transp) then begin
          rr := col and 255;
          gg := (col shr 8) and 255;
          bb := (col shr 16) and 255;
          isFromGlyph := true;
        end;
      end;
    end;
    if not isFromGlyph then begin
      if fFaceTransparent then begin
        { enable pixels in bmMask only if not on Border }
        if mskBorder.Pixels[pX, pY] <> clWhite then
          bmMask.Canvas.Pixels[pX, pY] := clWhite;
        exit;
      end;
      rr := faceRed;
      gg := faceGreen;
      bb := faceBlue;
    end;

    if (not isFromGlyph and fFaceShaded) or (isFromGlyph and fGlyphShaded) then begin
      atten := fAttenControl * (cLightX*normX + cLightY*normY + cLightZ*normZ);
      canvUp.Pixels[pX, pY] := CalcRGBAtten;
      atten := -atten;
      canvDown.Pixels[pX, pY] := CalcRGBAtten;
    end else begin
      col := (bb shl 16) or (gg shl 8) or rr;
      canvUp.Pixels[pX, pY] := col;
      canvDown.Pixels[pX, pY] := col;
    end;
  end;

begin
  transp := bmGlpyh.Canvas.Pixels[0, bmGlpyh.Height-1];
  if GlyphValid then begin
    glyHeight := bmGlpyh.Height;
    if fNumGlyphs = 1 then begin
      glyWidth := bmGlpyh.Width;
      glyXOfs := 0;
    end else begin
      glyWidth := bmGlpyh.Width div fNumGlyphs;
      glyXOfs := glyWidth * (fGlyphIndex-1);
    end;
  end;
  cx := Width/2;
  cy := Height/2;
  w := Width - nBorder * fBevelWidth;
  h := Height - nBorder * fBevelWidth;
  ylen := Floor(h/2);
  for y:=0 to ylen do begin
    Ye := y/cy;
    y0 := Floor(cy - y);
    y1 := Ceil(cy + y);
    xlen := Ceil(sqrt(1-sqr(Ye))*w/2);
    if xlen > 1 then
      for x:=0 to xlen do begin
        Xe := x/cx;
        Ze := 1-sqrt(sqr(Xe)+sqr(Ye));
        x0 := Floor(cx - x);
        x1 := Ceil(cx + x);
        SetFacePixel(x1,y0,  Xe,-Ye,Ze);  { Right-Top    }
        SetFacePixel(x1,y1,  Xe, Ye,Ze);  { Right-Bottom }
        SetFacePixel(x0,y1, -Xe, Ye,Ze);  { Left-Bottom  }
        SetFacePixel(x0,y0, -Xe,-Ye,Ze);  { Left-Top     }
      end;
  end;
end;

procedure THemisphereButton.CalcImages;
var
  r: TRect;
  w, h, nBorder: Integer;
  bmTmp, mskMiddle, mskInner,
  bmDown, bmUp, bmBorderOuter, bmBorderInner: TBitmap;

  function NewBitmap(IsMask: Boolean): TBitmap;
  begin
    Result := TBitmap.Create;
    Result.Width := w;
    Result.Height := h;
    if IsMask then begin
      Result.Canvas.Brush.Color := clWhite;
      Result.Canvas.FillRect(r);
      Result.Canvas.Pen.Color := clBlack;
      Result.Canvas.Brush.Color := clBlack;
    end;
  end;

  procedure DrawMasks;
  { All masks (mskMiddle, mskInner and bmMask) contain white pixels
    for background, black for foreground pixels. }
  begin
    if (fBevelOuter = hbNone) and (fBevelInner = hbNone) then
      mskMiddle.Canvas.Ellipse(0,0,w,h)
    else
      mskMiddle.Canvas.Ellipse(fBevelWidth, fBevelWidth, w-fBevelWidth, h-fBevelWidth);
    if (fBevelOuter = hbNone) or (fBevelInner = hbNone) then
      mskInner.Canvas.CopyRect(r, mskMiddle.Canvas, r)
    else
      mskInner.Canvas.Ellipse(2*fBevelWidth, 2*fBevelWidth, w-fBevelWidth*2, h-fBevelWidth*2);
    bmMask.Width := w;
    bmMask.Height := h;
    bmMask.Canvas.Brush.Color := clWhite;
    bmMask.Canvas.FillRect(r);
    bmMask.Canvas.Pen.Color := clBlack;
    bmMask.Canvas.Brush.Color := clBlack;
    bmMask.Canvas.Ellipse(0,0,w,h);
  end;

  procedure DrawBorders;
  var
    ofs: Integer;
  begin
    nBorder := 0;
    if (fBevelOuter = hbNone) and (fBevelInner = hbNone) then
      exit;
    if (fBevelOuter = hbNone) and (fBevelInner <> hbNone) then begin
      nBorder := 1;
      bmBorderOuter := NewBitmap(False);                     { inner border only }
      ofs := Ceil(fBevelWidth / 2);
      RenderBorder(bmBorderOuter.Canvas, ofs, ofs, w-ofs, h-ofs, fBevelWidth, fBevelInner = hbRaised);
      bmBorderOuter.Canvas.CopyMode := cmSrcAnd;             { clip to mskMiddle and !mskOuter }
      bmBorderOuter.Canvas.CopyRect(r, mskMiddle.Canvas, r);
    end else begin
      if (fBevelOuter <> hbNone) then begin                  { outer border }
        inc(nBorder);
        bmBorderOuter := NewBitmap(False);
        ofs := Floor(fBevelWidth / 2);
        RenderBorder(bmBorderOuter.Canvas, ofs, ofs, w-ofs, h-ofs, fBevelWidth, fBevelOuter = hbRaised);
        bmBorderOuter.Canvas.CopyMode := cmSrcAnd;           { clip to mskMiddle and !mskOuter }
        bmBorderOuter.Canvas.CopyRect(r, mskMiddle.Canvas, r);
      end;
      if (fBevelInner <> hbNone) then begin                  { inner border }
        inc(nBorder);
        bmBorderInner := NewBitmap(False);
        ofs := Ceil(fBevelWidth + fBevelWidth/2);
        RenderBorder(bmBorderInner.Canvas, ofs, ofs, w-ofs, h-ofs, fBevelWidth, fBevelInner = hbRaised);
        bmBorderInner.Canvas.CopyMode := cmSrcAnd;           { clip to mskInner and !mskMiddle }
        bmBorderInner.Canvas.CopyRect(r, mskInner.Canvas, r);
        if (fBevelOuter <> hbNone) then begin
          bmTmp.Canvas.CopyMode := cmNotSrcCopy;             { invert & copy }
          bmTmp.Canvas.CopyRect(r, mskMiddle.Canvas, r);
          bmBorderInner.Canvas.CopyRect(r, bmTmp.Canvas, r);
        end;
      end;
    end;
  end;

  procedure DrawCaption;
  var
    tx, ty: Integer;
  begin
    if fCaption = '' then
      exit;
    bmUp.Canvas.Font.Assign(Font);
    bmDown.Canvas.Font.Assign(Font);
    bmUp.Canvas.Brush.Style := bsClear;
    bmDown.Canvas.Brush.Style := bsClear;
    tx := Round((w-2 - bmUp.Canvas.TextWidth(fCaption))/2);
    ty := Round((h-2 - bmUp.Canvas.TextHeight(fCaption))/2);
    bmUp.Canvas.TextOut(tx, ty, fCaption);
    bmDown.Canvas.TextOut(tx, ty, fCaption);
    if fFaceTransparent then begin { paint the caption (in black) into bmMask }
      bmMask.Canvas.Font.Assign(Font);
      bmMask.Canvas.Font.Color := clBlack;
      bmMask.Canvas.Brush.Style := bsClear;
      bmMask.Canvas.TextOut(tx, ty, fCaption);
    end;
  end;

  procedure CombineImages;
  var
    ofs: Integer;
  begin
    bmTmp.Width := w;
    bmTmp.Height := h;
    bmTmp.Canvas.CopyMode := cmNotSrcCopy;  { invert & copy }
    bmTmp.Canvas.CopyRect(r, mskInner.Canvas, r);
    if nBorder > 0 then begin  { clip buttons to !mskInner }
      bmUp.Canvas.CopyMode := cmSrcAnd;
      bmUp.Canvas.CopyRect(r, bmTmp.Canvas, r);
      bmDown.Canvas.CopyMode := cmSrcAnd;
      bmDown.Canvas.CopyRect(r, bmTmp.Canvas, r);
    end;

    bmUnpressed.Width := w; bmUnpressed.Height := h;
    bmUnpressed.Canvas.CopyMode := cmSrcCopy;
    bmUnpressed.Canvas.CopyRect(r, bmUp.Canvas, r);
    bmUnpressed.Canvas.CopyMode := cmSrcPaint;  { OR }
    bmPressed.Width := w; bmPressed.Height := h;
    bmPressed.Canvas.CopyMode := cmSrcCopy;
    bmPressed.Canvas.CopyRect(r, bmDown.Canvas, r);
    bmPressed.Canvas.CopyMode := cmSrcPaint;
    if bmBorderOuter <> nil then begin
      bmUnpressed.Canvas.CopyRect(r, bmBorderOuter.Canvas, r);
      bmPressed.Canvas.CopyRect(r, bmBorderOuter.Canvas, r);
    end;
    if bmBorderInner <> nil then begin
      bmUnpressed.Canvas.CopyRect(r, bmBorderInner.Canvas, r);
      bmPressed.Canvas.CopyRect(r, bmBorderInner.Canvas, r);
    end;
    if fBorderStyle = bsSingle then begin
      ofs := nBorder*fBevelWidth;
      bmUnpressed.Canvas.Pen.Color := fBorderColor;
      bmUnpressed.Canvas.Brush.Style := bsClear;
      bmUnpressed.Canvas.Ellipse(ofs, ofs, bmUnpressed.Width-ofs, bmUnpressed.Height-ofs);
      bmPressed.Canvas.Pen.Color := fBorderColor;
      bmPressed.Canvas.Brush.Style := bsClear;
      bmPressed.Canvas.Ellipse(ofs, ofs, bmPressed.Width-ofs, bmPressed.Height-ofs);
    end;
  end;

begin
  w := Width;
  h := Height;
  if (csLoading in ComponentState) or (w < 2) or (h < 2) then
    exit;
  r := Rect(0,0,w,h);
  bmTmp := nil; mskMiddle := nil; mskInner := nil; bmDown := nil; bmUp := nil;
  bmBorderOuter := nil; bmBorderInner := nil;
  try
    bmTmp := NewBitmap(False);
    bmDown := NewBitmap(False);
    bmUp := NewBitmap(False);
    mskMiddle := NewBitmap(True);
    mskInner := NewBitmap(True);

    DrawMasks;
    DrawBorders;
    RenderButtonFaces(nBorder, mskInner.Canvas, bmUp.Canvas, bmDown.Canvas);
    DrawCaption;

    CombineImages;
  finally
    bmTmp.Free; mskMiddle.Free; mskInner.Free; bmDown.Free; bmUp.Free;
    bmBorderOuter.Free; bmBorderInner.Free;
  end;
end;

procedure THemisphereButton.Paint;
var
  r: TRect;
  w, h: Integer;
  bmBuf, bmTmp: TBitmap;
begin
  if csLoading in ComponentState then
    exit;
  w := bmMask.Width;
  h := bmMask.Height;
  r := Rect(0, 0, w, h);
  bmTmp := nil;
  bmBuf := nil;
  try
    bmBuf := TBitmap.Create;
    bmBuf.Width := w;
    bmBuf.Height := h;
    bmBuf.Canvas.CopyMode := cmSrcCopy;
    bmBuf.Canvas.CopyRect(r, Canvas, r);
    bmBuf.Canvas.CopyMode := cmSrcAnd;
    bmBuf.Canvas.CopyRect(r, bmMask.Canvas, r);  { bmBuf contains erased background }

    bmTmp := TBitmap.Create;
    bmTmp.Width := w;
    bmTmp.Height := h;
    bmTmp.Canvas.CopyRect(r, bmMask.Canvas, r);
    bmTmp.Canvas.CopyMode := cmSrcErase;  { NOT self AND other }
    if fDown then bmTmp.Canvas.CopyRect(r, bmPressed.Canvas, r)
    else bmTmp.Canvas.CopyRect(r, bmUnpressed.Canvas, r);
    bmBuf.Canvas.CopyMode := cmSrcPaint;  { self OR other }
    bmBuf.Canvas.CopyRect(r, bmTmp.Canvas, r);

    Canvas.CopyRect(r, bmBuf.Canvas, r);
  finally
    bmTmp.Free;
    bmBuf.Free;
  end;
end;

end.
