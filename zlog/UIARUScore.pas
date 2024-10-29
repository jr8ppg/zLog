unit UIARUScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons, Math,
  UzLogConst, UzLogGlobal, UzLogQSO, Vcl.Menus;

type
  TIARUScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  protected
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
  private
    { Private declarations }
    BLo, BHi : TBand;
  public
    { Public declarations }
    procedure InitGrid(B0, B1 : TBand);
    procedure UpdateData; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
  end;

implementation

{$R *.DFM}

procedure TIARUScore.FormCreate(Sender: TObject);
begin
   inherited;
   InitGrid(b19, b28);
end;

procedure TIARUScore.AddNoUpdate(var aQSO: TQSO);
var
   band: TBand;
begin
   inherited;

   if aQSO.Dupe then begin
      exit;
   end;

   band := aQSO.band;
   Inc(Points[band], aQSO.Points);
end;

procedure TIARUScore.InitGrid(B0, B1: TBand);
begin
   BLo := B0;
   BHi := B1;
end;

procedure TIARUScore.UpdateData;
var
   band: TBand;
   TotQSO, TotPoints, TotMulti: LongInt;
   row: Integer;
   strScore: string;
   DispColCount: Integer;
   strExtraInfo: string;
   w: Integer;
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
      Grid.Cells[5, 0] := 'CW Q''s';
      Grid.Cells[6, 0] := 'CW %';
      DispColCount := 7;
   end
   else begin
      Grid.Cells[5,0] := '';
      Grid.Cells[6,0] := '';
      DispColCount := 5;
   end;

   // バンド別スコア行
   for band := BLo to BHi do begin
      // WARC除外
      if IsWARC(band) = True then begin
         Continue;
      end;

      // QRVできないバンドは除外
      if dmZlogGlobal.Settings._activebands[band] = False then begin
         Continue;
      end;

      TotPoints := TotPoints + Points[band];
      TotMulti := TotMulti + Multi[band];
      TotQSO := TotQSO + QSO[band];

      // バンド別スコア
      Grid.Cells[0, row] := '*' + MHzString[band];
      Grid.Cells[1, row] := IntToStr(QSO[band]);
      Grid.Cells[2, row] := IntToStr(Points[band]);
      Grid.Cells[3, row] := IntToStr(Multi[band]);

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

      if ShowCWRatio then begin
         Grid.Cells[5, row] := IntToStr(CWQSO[band]);
         if QSO[band] > 0 then begin
            Grid.Cells[6, row] := FloatToStrF(100 * (CWQSO[band] / QSO[band]), ffFixed, 1000, 1);
         end
         else begin
            Grid.Cells[6, row] := '-';
         end;
      end;

      inc(row);
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

procedure TIARUScore.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(TStringGrid(Sender), ACol, ARow, Rect);
end;

function TIARUScore.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TIARUScore.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateData();
end;

end.
