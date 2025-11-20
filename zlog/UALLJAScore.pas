unit UALLJAScore;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons, Math,
  UzLogConst, UzLogGlobal, UzLogQSO, Vcl.Menus;

type
  TBandPointArray = array[b19..HiBand] of Integer;
  TALLJAScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  protected
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
  private
    { Private declarations }
    FLowBand: TBand;
    FHighBand: TBand;
    FPointTable: TBandPointArray;
    function GetPointTable(Index: TBand): Integer;
    procedure SetPointTable(Index: TBand; v: Integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; LowBand: TBand; HighBand: TBand); reintroduce;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure UpdateData; override;
    procedure Reset; override;
    procedure Add(var aQSO : TQSO); override;
    property FontSize: Integer read GetFontSize write SetFontSize;
    property PointTable[Index: TBand]: Integer read GetPointTable write SetPointTable;
  end;

implementation

{$R *.DFM}

constructor TALLJAScore.Create(AOwner: TComponent; LowBand: TBand; HighBand: TBand);
begin
   Inherited Create(AOwner);
   FLowBand := LowBand;
   FHighBand := HighBand;
   FPointTable[b19] := 1;
   FPointTable[b35] := 1;
   FPointTable[b7] := 1;
   FPointTable[b10] := 1;
   FPointTable[b14] := 1;
   FPointTable[b18] := 1;
   FPointTable[b21] := 1;
   FPointTable[b24] := 1;
   FPointTable[b28] := 1;
   FPointTable[b50] := 1;
   FPointTable[b144] := 1;
   FPointTable[b430] := 1;
   FPointTable[b1200] := 1;
   FPointTable[b2400] := 1;
   FPointTable[b5600] := 1;
   FPointTable[b10g] := 1;
end;

procedure TALLJAScore.FormShow(Sender: TObject);
begin
   inherited;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.Row := 1;
end;

procedure TALLJAScore.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(TStringGrid(Sender), ACol, ARow, Rect);
end;

procedure TALLJAScore.AddNoUpdate(var aQSO: TQSO);
var
   band: TBand;
begin
   inherited;

   if aQSO.Dupe then begin
      Exit;
   end;

   band := aQSO.band;
   aQSO.points := FPointTable[band];
   Inc(Points[band], aQSO.points);
end;

procedure TALLJAScore.UpdateData;
var
   band: TBand;
   TotQSO, TotPoints, TotMulti: Integer;
   row: Integer;
   w: Integer;
   strScore: string;
   DispColCount: Integer;
   strExtraInfo: string;
begin
   Inherited;

   TotQSO := 0;
   TotPoints := 0;
   TotMulti := 0;
   row := 1;

   // 見出し行
   Grid.Cells[0,0] := 'MHz';
   Grid.Cells[1,0] := 'QSOs';
   Grid.Cells[2,0] := 'Points';
   Grid.Cells[3,0] := 'Multi';
   Grid.Cells[4,0] := EXTRAINFO_CAPTION[FExtraInfo];

   if ShowCWRatio then begin
      Grid.Cells[5,0] := 'CW Q''s';
      Grid.Cells[6,0] := 'CW %';
      DispColCount := 7;
   end
   else begin
      Grid.Cells[5,0] := '';
      Grid.Cells[6,0] := '';
      DispColCount := 5;
   end;

   // バンド別スコア行
   for band := FLowBand to FHighBand do begin
      // WARC除外
      if IsWARC(band) = True then begin
         Continue;
      end;

      // QRVできないバンドは除外
      if dmZlogGlobal.Settings._activebands[band] = False then begin
         Continue;
      end;

      // 10G
      if band = b104g then begin
         Continue;
      end;

      TotPoints := TotPoints + Points[band];
      TotMulti := TotMulti + Multi[band];
      TotQSO := TotQSO + QSO[band];

      // バンド別スコア
      Grid.Cells[0, row] := '*' + MHzString[band];
      Grid.Cells[1, row] := IntToStr3(QSO[band]);
      Grid.Cells[2, row] := IntToStr3(Points[band]);
      Grid.Cells[3, row] := IntToStr3(Multi[band]);

      // Multi率
      strExtraInfo := '';
      case FExtraInfo of
         0: begin
            if QSO[band] > 0 then begin
               strExtraInfo := FloatToStrF((Multi[band] / QSO[band] * 100), ffFixed, 1000, 1);
            end;
         end;

         1: begin
            if Multi[band] > 0 then begin
               strExtraInfo := FloatToStrF((Points[band] / Multi[band]), ffFixed, 1000, 1);
            end;
         end;

         2: begin
            if QSO[band] > 0 then begin
               strExtraInfo := FloatToStrF((Points[band] * Multi[band] / QSO[band]), ffFixed, 1000, 1);
            end;
         end;
      end;
      Grid.Cells[4, row] := strExtraInfo;

      // CW率
      if ShowCWRatio then begin
         Grid.Cells[5, row] := IntToStr3(CWQSO[band]);
         if QSO[band] > 0 then begin
            Grid.Cells[6, row] := FloatToStrF(100 * (CWQSO[band] / QSO[band]), ffFixed, 1000, 1);
         end
         else begin
            Grid.Cells[6, row] := '-';
         end;
      end
      else begin
         Grid.Cells[5, row] := '';
         Grid.Cells[6, row] := '';
      end;

      Inc(row);
   end;

   // 合計行
   Grid.Cells[0, row] := 'Total';
   Grid.Cells[1, row] := IntToStr3(TotQSO);
   Grid.Cells[2, row] := IntToStr3(TotPoints);
   Grid.Cells[3, row] := IntToStr3(TotMulti);

   // Multi率
   strExtraInfo := '';
   case FExtraInfo of
      0: begin
         if TotQSO > 0 then begin
            strExtraInfo := FloatToStrF((TotMulti / TotQSO * 100), ffFixed, 1000, 1);
         end;
      end;

      1: begin
         if TotMulti > 0 then begin
            strExtraInfo := FloatToStrF((TotPoints / TotMulti), ffFixed, 1000, 1);
         end;
      end;

      2: begin
         if TotQSO > 0 then begin
            strExtraInfo := FloatToStrF((TotPoints * TotMulti / TotQSO), ffFixed, 1000, 1);
         end;
      end;
   end;
   Grid.Cells[4, row] := strExtraInfo;

   // CW率
   if ShowCWRatio then begin
      Grid.Cells[5, row] := IntToStr3(TotalCWQSOs);
      if TotPoints > 0 then begin
         Grid.Cells[6, row] := FloatToStrF(100 * (TotalCWQSOs / TotalQSOs), ffFixed, 1000, 1);
      end
      else begin
         Grid.Cells[6, row] := '-';
      end;
   end
   else begin
      Grid.Cells[5, row] := '';
      Grid.Cells[6, row] := '';
   end;
   Inc(row);

   // スコア行
   strScore := IntToStr3(TotPoints * TotMulti);
   Grid.Cells[0, row] := 'Score';
   Grid.Cells[1, row] := '';
   Grid.Cells[2, row] := '';
   Grid.Cells[3, row] := strScore;
   Grid.Cells[4, row] := '';
   Grid.Cells[5, row] := '';
   Grid.Cells[6, row] := '';
   Inc(row);

   // 行数をセット
   Grid.RowCount := row;

   // カラム幅をセット
   w := Grid.Canvas.TextWidth('9');
   Grid.ColWidths[0] := w * 6;
   Grid.ColWidths[1] := w * 7;
   Grid.ColWidths[2] := w * 7;
   Grid.ColWidths[3] := w * Max(8, Length(strScore)+1);
   Grid.ColWidths[4] := w * 7;
   Grid.ColWidths[5] := w * 7;
   Grid.ColWidths[6] := w * 7;

   // グリッドサイズ調整
   AdjustGridSize(Grid, DispColCount, Grid.RowCount);
end;

procedure TALLJAScore.Reset;
begin
   inherited;
end;

procedure TALLJAScore.Add(var aQSO: TQSO);
begin
   inherited;
end;

function TALLJAScore.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TALLJAScore.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateData();
end;

function TALLJAScore.GetPointTable(Index: TBand): Integer;
begin
   Result := FPointTable[Index];
end;

procedure TALLJAScore.SetPointTable(Index: TBand; v: Integer);
begin
   FPointTable[Index] := v;
end;

end.
