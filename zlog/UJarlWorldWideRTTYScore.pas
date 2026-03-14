unit UJarlWorldWideRTTYScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons, Math,
  UzLogConst, UzLogGlobal, UzLogQSO, Vcl.Menus;

type
  TJarlWorldWideRTTYScore = class(TBasicScore)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    BLo, BHi : TBand;
  public
    { Public declarations }
    procedure InitGrid(B0, B1 : TBand);
    procedure UpdateData; override;
    procedure AddNoUpdate(aQSO: TQSO); override;
  end;

implementation

{$R *.DFM}

procedure TJarlWorldWideRTTYScore.FormCreate(Sender: TObject);
begin
   inherited;
   InitGrid(b35, b28);
end;

procedure TJarlWorldWideRTTYScore.AddNoUpdate(aQSO: TQSO);
var
   band: TBand;
begin
   inherited;

   if aQSO.Dupe then begin
      exit;
   end;

   band := aQSO.band;

//   if FValidQso = True then begin
//      aQSO.Points := 1;
//   end
//   else begin
//      aQSO.Points := 0;
//   end;

   Inc(Points[band], aQSO.Points);
end;

procedure TJarlWorldWideRTTYScore.InitGrid(B0, B1: TBand);
begin
   BLo := B0;
   BHi := B1;
end;

procedure TJarlWorldWideRTTYScore.UpdateData;
var
   band: TBand;
   TotQSO, TotPoints, TotMulti, TotMulti2: LongInt;
   row: Integer;
   strScore: string;
   DispColCount: Integer;
   strExtraInfo: string;
   w: Integer;
begin
   Inherited;

   Grid.ColCount := 8;
   TotQSO := 0;
   TotPoints := 0;
   TotMulti := 0;
   TotMulti2 := 0;
   row := 1;

   // 見出し行
   Grid.Cells[0,0] := 'MHz';
   Grid.Cells[1,0] := 'QSOs';
   Grid.Cells[2,0] := 'Points';
   Grid.Cells[3,0] := 'Multi1';
   Grid.Cells[4,0] := 'Multi2';
   Grid.Cells[5,0] := EXTRAINFO_CAPTION[FExtraInfo];

   if ShowCWRatio then begin
      Grid.Cells[6, 0] := 'CW Q''s';
      Grid.Cells[7, 0] := 'CW %';
      DispColCount := 8;
   end
   else begin
      Grid.Cells[6,0] := '';
      Grid.Cells[7,0] := '';
      DispColCount := 6;
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
      TotMulti2 := TotMulti2 + Multi2[band];
      TotQSO := TotQSO + QSO[band];

      // バンド別スコア
      Grid.Cells[0, row] := '*' + MHzString[band];
      Grid.Cells[1, row] := IntToStr(QSO[band]);
      Grid.Cells[2, row] := IntToStr(Points[band]);
      Grid.Cells[3, row] := IntToStr(Multi[band]);
      Grid.Cells[4, row] := IntToStr(Multi2[band]);

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
      Grid.Cells[5, row] := strExtraInfo;

      if ShowCWRatio then begin
         Grid.Cells[6, row] := IntToStr(CWQSO[band]);
         if QSO[band] > 0 then begin
            Grid.Cells[7, row] := FloatToStrF(100 * (CWQSO[band] / QSO[band]), ffFixed, 1000, 1);
         end
         else begin
            Grid.Cells[7, row] := '-';
         end;
      end;

      inc(row);
   end;

   // 合計行
   Grid.Cells[0, row] := 'Total';
   Grid.Cells[1, row] := IntToStr3(TotQSO);
   Grid.Cells[2, row] := IntToStr3(TotPoints);
   Grid.Cells[3, row] := IntToStr3(TotMulti);
   Grid.Cells[4, row] := IntToStr3(TotMulti2);

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
   Grid.Cells[5, row] := strExtraInfo;

   // CW率
   if ShowCWRatio then begin
      Grid.Cells[6, row] := IntToStr3(TotalCWQSOs);
      if TotPoints > 0 then begin
         Grid.Cells[7, row] := FloatToStrF(100 * (TotalCWQSOs / TotalQSOs), ffFixed, 1000, 1);
      end
      else begin
         Grid.Cells[7, row] := '-';
      end;
   end
   else begin
      Grid.Cells[5, row] := '';
      Grid.Cells[6, row] := '';
   end;
   Inc(row);

   // スコア行
   strScore := IntToStr3(TotPoints * (TotMulti + TotMulti2));
   Grid.Cells[0, row] := 'Score';
   Grid.Cells[1, row] := '';
   Grid.Cells[2, row] := '';
   Grid.Cells[3, row] := strScore;
   Grid.Cells[4, row] := '';
   Grid.Cells[5, row] := '';
   Grid.Cells[6, row] := '';
   Grid.Cells[7, row] := '';
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
   Grid.ColWidths[7] := w * 7;

   // グリッドサイズ調整
   AdjustGridSize(Grid, DispColCount, Grid.RowCount);
end;

end.
