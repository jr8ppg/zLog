unit UBasicScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Math, Grids, Vcl.Menus,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogForm;

type
  TBandPointArray = array[b19..HiBand] of Integer;

  TBasicScore = class(TZLogForm)
    Panel1: TPanel;
    Button1: TButton;
    StayOnTop: TCheckBox;
    CWButton: TSpeedButton;
    popupExtraInfo: TPopupMenu;
    menuMultiRate: TMenuItem;
    menuPtsPerMulti: TMenuItem;
    menuPtsPerQSO: TMenuItem;
    Grid: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
    procedure CWButtonClick(Sender: TObject);
    procedure menuExtraInfoClick(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: LongInt; Rect: TRect; State: TGridDrawState);
  protected
    FExtraInfo: Integer;
    FContestMode: TContestMode;
    FValidQso: Boolean;
    procedure AdjustGridSize(Grid: TStringGrid; ColCount, RowCount: Integer);
    function GetScore(): Integer;
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
  private
    { Private declarations }
    procedure Draw_GridCell(Grid: TStringGrid; ACol, ARow: Integer; Rect: TRect);
    procedure SetGridFontSize(Grid: TStringGrid; font_size: Integer);
  public
    { Public declarations }
    QSO : array[b19..HiBand] of LongInt;
    CWQSO : array[b19..HiBand] of LongInt;
    FMQSO : array[b19..HiBand] of LongInt;
    Points : array[b19..HiBand] of LongInt;
    Multi : array[b19..HiBand] of LongInt;
    Multi2 : array[b19..HiBand] of LongInt;
    ShowCWRatio : boolean;
    constructor Create(AOwner: TComponent); overload;
    constructor Create(AOwner: TComponent; LowBand: TBand; HighBand: TBand; M: TContestMode); overload; virtual; abstract;
    procedure Renew; virtual;
    procedure UpdateData; virtual;
    procedure AddNoUpdate(aQSO: TQSO); virtual;
    procedure Add(aQSO: TQSO); virtual; {calculates points}
    procedure Reset; virtual;
    function TotalCWQSOs : integer;
    function TotalQSOs : integer;
    function QPMStr(B: TBand) : string; // returns QSO,Pts,Mult for JARL E-log
    function TotalQPMStr: string;
    function _TotalMulti : integer;
    function _TotalPoints : integer;
    function IntToStr3(v: Integer): string;
    property Score: Integer read GetScore;
    property ContestMode: TContestMode read FContestMode write FContestMode;
  published
    property FontSize;
    property OnChangeFontSize;
  end;

const
  EXTRAINFO_CAPTION: array[0..2] of string = ( 'Multi%', 'Pts/M', 'Pts/Q' );

implementation

uses
  Main;

{$R *.DFM}

constructor TBasicScore.Create(AOwner: TComponent);
begin
   Inherited Create(AOwner);
   FContestMode := cmMix;
   ShowCWRatio := False;
   Reset;

   case dmZLogGlobal.Settings.FLastScoreExtraInfo of
      0: menuMultiRate.Checked := True;
      1: menuPtsPerMulti.Checked := True;
      2: menuPtsPerQSO.Checked := True;
      else menuMultiRate.Checked := True;
   end;
end;

procedure TBasicScore.Renew;
var
   i: Word;
   band: TBand;
begin
   Reset;
   for i := 1 to Log.TotalQSO do begin
      band := Log.QsoList[i].band;
      inc(QSO[band]);
      inc(Points[band], Log.QsoList[i].Points);
      if Log.QsoList[i].NewMulti1 then
         inc(Multi[band]);
   end;
end;

procedure TBasicScore.UpdateData;
begin
   if menuMultiRate.Checked = True then begin
      FExtraInfo := 0;
   end
   else if menuPtsPerMulti.Checked = True then begin
      FExtraInfo := 1;
   end
   else if menuPtsPerQSO.Checked = True then begin
      FExtraInfo := 2;
   end
   else begin
      FExtraInfo := 0;
   end;
   dmZLogGlobal.Settings.FLastScoreExtraInfo := FExtraInfo;
end;

procedure TBasicScore.AddNoUpdate(aQSO: TQSO);
var
   B: TBand;
begin
   FValidQso := False;

   B := aQSO.band;

   if aQSO.Dupe then begin
      Exit;
   end;

   case FContestMode of
      cmMix: begin
         if aQSO.mode in ContestModeSet[cmMix] then begin
            Inc(QSO[B]);
            FValidQso := True;
         end;
         if aQSO.mode in ContestModeSet[cmCW] then begin
            Inc(CWQSO[B]);
            FValidQso := True;
         end;
         if aQSO.mode = mFM then begin
            Inc(FMQSO[B]);
            FValidQso := True;
         end;
      end;

      cmCw: begin
         if aQSO.mode in ContestModeSet[cmCW] then begin
            Inc(QSO[B]);
            Inc(CWQSO[B]);
            FValidQso := True;
         end;
      end;

      cmPh: begin
         if aQSO.mode in ContestModeSet[cmPh] then begin
            Inc(QSO[B]);
            FValidQso := True;
         end;
         if aQSO.mode = mFM then begin
            Inc(FMQSO[B]);
            FValidQso := True;
         end;
      end;

      cmRtty: begin
         if aQSO.mode in ContestModeSet[cmRtty] then begin
            Inc(QSO[B]);
            FValidQso := True;
         end;
      end;

      cmAll: begin
         Inc(QSO[B]);
         FValidQso := True;
         if aQSO.mode in ContestModeSet[cmCW] then begin
            Inc(CWQSO[B]);
         end;
         if aQSO.mode = mFM then begin
            Inc(FMQSO[B]);
         end;
      end;
   end;

   if aQSO.NewMulti1 then begin
      Inc(Multi[B]);
   end;

   if aQSO.NewMulti2 then begin
      Inc(Multi2[B]);
   end;
end;

procedure TBasicScore.Add(aQSO: TQSO);
begin
   if aQSO.Invalid = True then begin
      Exit;
   end;

   AddNoUpdate(aQSO);
   UpdateData;
end;

procedure TBasicScore.Reset;
var
   band: TBand;
begin
   for band := b19 to HiBand do begin
      QSO[band] := 0;
      CWQSO[band] := 0;
      FMQSO[band] := 0;
      Points[band] := 0;
      Multi[band] := 0;
      Multi2[band] := 0;
   end;
end;

procedure TBasicScore.Button1Click(Sender: TObject);
begin
   Close;
end;

procedure TBasicScore.FormCreate(Sender: TObject);
begin
   StayOnTop.Checked := False;
end;

procedure TBasicScore.StayOnTopClick(Sender: TObject);
begin
   If StayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
end;

function TBasicScore.TotalCWQSOs: integer;
var
   B: TBand;
   i: integer;
begin
   i := 0;
   for B := b19 to HiBand do
      i := i + CWQSO[B];
   Result := i;
end;

function TBasicScore.TotalQSOs: integer;
var
   B: TBand;
   i: integer;
begin
   i := 0;
   for B := b19 to HiBand do
      i := i + QSO[B];
   Result := i;
end;

procedure TBasicScore.CWButtonClick(Sender: TObject);
begin
   if CWButton.Down then
      ShowCWRatio := True
   else
      ShowCWRatio := False;

   UpdateData;
end;

function TBasicScore.QPMStr(B: TBand): string; // returns QSO,Pts,Mult for JARL E-log
begin
   Result := IntToStr(QSO[B]) + ',' + IntToStr(Points[B]) + ',' + IntToStr(Multi[B]);
end;

function TBasicScore.TotalQPMStr: string; // returns QSO,Pts,Mult for JARL E-log
begin
   Result := IntToStr(TotalQSOs) + ',' + IntToStr(_TotalPoints) + ',' + IntToStr(_TotalMulti);
end;

function TBasicScore._TotalMulti: integer;
var
   B: TBand;
   i: integer;
begin
   i := 0;
   for B := b19 to HiBand do
      i := i + Multi[B];
   Result := i;
end;

function TBasicScore._TotalPoints: integer;
var
   B: TBand;
   i: integer;
begin
   i := 0;
   for B := b19 to HiBand do
      i := i + Points[B];
   Result := i;
end;

function TBasicScore.IntToStr3(v: integer): string;
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
      Inc(c);
   end;

   Result := strFormatedText;
end;

procedure TBasicScore.menuExtraInfoClick(Sender: TObject);
begin
   UpdateData();
end;

procedure TBasicScore.Draw_GridCell(Grid: TStringGrid; ACol, ARow: Integer; Rect: TRect);
var
   strText: string;
begin
   strText := Grid.Cells[ACol, ARow];

   with Grid.Canvas do begin
      Font.Name := 'ÇlÇr ÉSÉVÉbÉN';
      Brush.Color := Grid.Color;
      Brush.Style := bsSolid;
      FillRect(Rect);

      Font.Size := FFontSize;

      if Copy(strText, 1, 1) = '*' then begin
         strText := Copy(strText, 2);
         Font.Color := clBlue;
      end
      else begin
         Font.Color := clBlack;
      end;

      TextRect(Rect, strText, [tfRight,tfVerticalCenter,tfSingleLine]);
   end;
end;

procedure TBasicScore.AdjustGridSize(Grid: TStringGrid; ColCount, RowCount: Integer);
var
   i: Integer;
   h: Integer;
   w: Integer;
begin
   // ïùí≤êÆ
   w := 0;
   for i := 0 to ColCount - 1 do begin
      w := w + Grid.ColWidths[i];
   end;
   w := w + (Grid.ColCount * Grid.GridLineWidth) + 2;
   ClientWidth := Max(w, 200);

   // çÇÇ≥í≤êÆ
   h := 0;
   for i := 0 to RowCount - 1 do begin
      h := h + Grid.RowHeights[i];
   end;
   h := h + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
   ClientHeight := h;
end;

procedure TBasicScore.SetGridFontSize(Grid: TStringGrid; font_size: Integer);
var
   i: Integer;
   h: Integer;
begin
   Grid.Font.Size := font_size;
   Grid.Canvas.Font.size := font_size;

   h := Abs(Grid.Font.Height) + 6;

   Grid.DefaultRowHeight := h;

   for i := 0 to Grid.RowCount - 1 do begin
      Grid.RowHeights[i] := h;
   end;
end;

function TBasicScore.GetScore(): Integer;
var
   B: TBand;
   pts, m1, m2: Integer;
begin
   pts := 0;
   m1 := 0;
   m2 := 0;
   for B := b19 to HiBand do begin
      pts := pts + Points[B];
      m1 := m1 + Multi[B];
      m2 := m2 + Multi2[B];
   end;

   Result := pts * (m1 + m2);
end;

procedure TBasicScore.GridDrawCell(Sender: TObject; ACol, ARow: LongInt; Rect: TRect; State: TGridDrawState);
var
   strText: string;
begin
   inherited;

   strText := Grid.Cells[ACol, ARow];

   with Grid.Canvas do begin
      Font.Name := 'ÇlÇr ÉSÉVÉbÉN';
      Brush.Color := dmZLogGlobal.ZBackColor;
      Brush.Style := bsSolid;
      FillRect(Rect);

      Font.Size := FFontSize;

      if Copy(strText, 1, 1) = '*' then begin
         strText := Copy(strText, 2);
         Font.Color := dmZLogGlobal.ZNormalTextColor2;
      end
      else begin
         Font.Color := dmZLogGlobal.ZNormalTextColor1;
      end;

      TextRect(Rect, strText, [tfRight,tfVerticalCenter,tfSingleLine]);
   end;
end;

function TBasicScore.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TBasicScore.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateData();
end;

end.
