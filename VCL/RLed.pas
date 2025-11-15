unit RLed;

interface

uses
  WinApi.Windows, WinApi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  System.Math, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TRLed = class(TGraphicControl)
  private
    FColorLow: TColor;
    FColorHi: TColor;
    FOrientation: TTrackBarOrientation;
    FMaxValue: Longint;
    FBackColor: TColor;
    FBarSize: word;
    FPosition: longint;
    FBreakPos: byte;
    FPeekPosition: longint;
    FPeekHold: Boolean;
    FHoldTime: Integer;
    FHoldStart: DWORD;
    procedure SetColorHi(const Value: TColor);
    procedure SetColorLow(const Value: TColor);
    procedure SetOrientation(const Value: TTrackBarOrientation);
    procedure SetMaxValue(const Value: Longint);
    procedure SetBackColor(const Value: TColor);
    procedure SetBarSize(const Value: word);
    procedure SetPosition(const Value: longint);
    procedure SetBreakPos(const Value: byte);
    procedure SetHoldTime(const Value: Integer);
    { Private declarations }
  protected
    { Protected declarations }
    BarCount:longint;
    procedure Paint; override;
    procedure RecalcBarCount;
    function BlendColor(clr: TColor): TColor;
    function inHi(I: Integer;Pro:byte): boolean;
  public
    { Public declarations }
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function InPos(i: Integer): boolean;
    function InPosPeek(i: Integer): boolean;
  published
    { Published declarations }
    property ColorLow:TColor read FColorLow write SetColorLow;
    property ColorHi:TColor read FColorHi write SetColorHi;
    property Orientation:TTrackBarOrientation read FOrientation write SetOrientation default trVertical;
    property MaxValue: Longint read FMaxValue write SetMaxValue;
    property BackColor:TColor read FBackColor write SetBackColor;
    property BarSize:word read FBarSize write SetBarSize;
    property Position:longint read FPosition write SetPosition;
    property BreakPos:byte read FBreakPos write SetBreakPos;
    property PeekHold: Boolean read FPeekHold write FPeekHold default True;
    property HoldTime: Integer read FHoldTime write SetHoldTime;
    property Constraints;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property Align;
    property Anchors;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property DragCursor;
    property DragKind;
    property DragMode;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TRLed]);
end;

{ TRLed }

function TRLed.BlendColor(clr: TColor): TColor;
begin
  Result := RGB(GetRValue(clr) div 3, GetgValue(clr) div 3, GetbValue(clr) div 3);
end;

constructor TRLed.Create(Owner: TComponent);
begin
  inherited CReate(Owner);
  FPeekHold := True;
  FHoldTime := 500;

  Width := 25;  // Change inherited properties
  Height := 152;
  FMaxValue := 100;
  FBackColor := clBlack;
  FColorLow := clLime;
  FColorHi := clRed;
  FBarSize := 5;
  FOrientation := trVertical;
  FPOsition := 0;
  FBreakPos := 35;
  RecalcBarCount;
end;

destructor TRLed.Destroy;
begin
  inherited Destroy;
end;

function TRLed.inHi;
begin
  Result := i < Round(BarCount / 100 * Pro);
end;

function TRLed.InPos(i: Integer): boolean;
var
  bTemp: byte;
begin
  bTemp := round((FPosition / FMaxValue) * 100);
  result := i > BarCount - Round(BarCount / 100 * bTemp);
end;

function TRLed.InPosPeek(i: Integer): boolean;
var
  bTemp: byte;
begin
  if (FPeekPosition = 0) or (FPeekHold = False) then begin
     Result := False;
     Exit;
  end;

  bTemp := round((FPeekPosition / FMaxValue) * 100);
  Result := i = BarCount - Round(BarCount / 100 * bTemp);
end;

procedure TRLed.Paint;
var
  TB:TBitmap;
  i:word;
begin
  TB := TBitmap.Create;
  tb.Width := Width;
  tb.Height := Height;
  tb.Canvas.Brush.Color := BackColor;
  tb.Canvas.FillRect(rect(0, 0, Width, Height));
  RecalcBarCount;

  case FOrientation of
    trVertical: begin
      for i := 1 to BarCount do begin
        if inHi(i, FBreakPos) then begin
          if not InPos(i) then begin
            if InPosPeek(BarCount - i + 1) then begin
              tb.Canvas.Brush.Color := ColorHi;
            end
            else begin
              tb.Canvas.Brush.Color := BlendColor(ColorHi);
            end;
          end
          else begin
            tb.Canvas.Brush.Color := ColorHi;
          end;
        end
        else if not InPos(i) then begin
          if InPosPeek(BarCount - i + 1) then begin
            tb.Canvas.Brush.Color := ColorLow;
          end
          else begin
            tb.Canvas.Brush.Color := BlendColor(ColorLow);
          end;
        end
        else begin
          tb.Canvas.Brush.Color := ColorLow;
        end;

        tb.Canvas.FillRect(rect(2,(i - 1) * barSize + 2, width - 2, (i - 1) * barSize + BarSize));
      end;
    end;

    trHorizontal: begin
      for i := 1 to BarCount do begin
        if inHi(BarCount - i, FBreakPos) then begin
          if not InPos(BarCount - i + 1) then begin
            if InPosPeek(BarCount - i + 1) then begin
              tb.Canvas.Brush.Color := ColorHi;
            end
            else begin
              tb.Canvas.Brush.Color := BlendColor(ColorHi);
            end;
          end
          else begin
            tb.Canvas.Brush.Color := ColorHi;
          end;
        end
        else if not InPos(BarCount - i + 1) then begin
          if InPosPeek(BarCount - i + 1) then begin
            tb.Canvas.Brush.Color := ColorLow;
          end
          else begin
            tb.Canvas.Brush.Color := BlendColor(ColorLow);
          end;
        end
        else begin
          tb.Canvas.Brush.Color := ColorLow;
        end;

        tb.Canvas.FillRect(rect((i - 1) * barSize + 2, 2, (i - 1) * barSize + BarSize, height - 2));
      end;
    end;
  end;

  Canvas.CopyRect(Rect(0, 0, width, height), tb.canvas,Rect(0, 0, width, height));
  TB.free;
end;

procedure TRLed.RecalcBarCount;
begin
  if FOrientation=trVertical then
    BarCount := (Height - 2) div (FBarSize)
  else
    BarCount := (Width - 2) div (FBarSize)
end;

procedure TRLed.SetBackColor(const Value: TColor);
begin
  FBackColor := Value;
  paint;
end;

procedure TRLed.SetBarSize(const Value: word);
begin
  if (FBarSize <> Value) and
     ((FOrientation = trVertical) and (Value < Height - 4)) or
     ((FOrientation = trHorizontal) and (Value < Width - 4))
  then begin
    FBarSize := Value;
    RecalcBarCount;
    Paint;
  end;
end;

procedure TRLed.SetBreakPos(const Value: byte);
begin
  if not Value > 100 then begin
    FBreakPos := Value;
    Paint;
  end;
end;

procedure TRLed.SetColorHi(const Value: TColor);
begin
  FColorHi := Value;
  Paint;
end;

procedure TRLed.SetColorLow(const Value: TColor);
begin
  if FColorLow <> Value then begin
    FColorLow := Value;
    Paint;
  end;
end;

procedure TRLed.SetMaxValue(const Value: Longint);
begin
  if FMaxValue <> Value then begin
    FMaxValue := Value;
    Paint;
  end;
end;

procedure TRLed.SetOrientation(const Value: TTrackBarOrientation);
begin
  if FOrientation <> Value then begin
    FOrientation := Value;
    //Change Orientation
    if ComponentState * [csLoading, csUpdating] = [] then
      SetBounds(Left, Top, Height, Width);
    Paint;
  end;
end;

procedure TRLed.SetPosition(const Value: longint);
var
   dwTick: DWORD;
begin
  if Value <= FMaxValue then begin
    if FHoldStart = 0 then begin
      if FPeekPosition < Value then begin
        FPeekPosition := Value;
      end
      else begin
        FHoldStart := GetTickCount();
      end;
    end
    else begin
      dwTick := GetTickCount();
      if (dwTick - FHoldStart) > FHoldTime then begin
        FHoldStart := 0;
        FPeekPosition := FPosition;
      end;
    end;

    FPosition := Value;
    Paint;
  end;
end;

procedure TRLed.SetHoldTime(const Value: Integer);
begin
  FHoldTime := Value;
end;

end.

