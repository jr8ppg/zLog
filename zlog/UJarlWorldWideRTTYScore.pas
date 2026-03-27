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
  published
    property UseMulti2;
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
   COL: Integer;
begin
   Inherited;

   if FUseMulti2 = False then begin
      Grid.ColCount := 7;
   end
   else begin
      Grid.ColCount := 8;
   end;
   TotQSO := 0;
   TotPoints := 0;
   TotMulti := 0;
   TotMulti2 := 0;
   row := 1;

   // 見出し行
   COL := 0;
   Grid.Cells[COL,0] := 'MHz';
   Inc(COL);
   Grid.Cells[COL,0] := 'QSOs';
   Inc(COL);
   Grid.Cells[COL,0] := 'Points';
   Inc(COL);
   Grid.Cells[COL,0] := 'Multi1';
   Inc(COL);

   if FUseMulti2 = True then begin
      Grid.Cells[COL,0] := 'Multi2';
      Inc(COL);
   end;

   Grid.Cells[COL,0] := EXTRAINFO_CAPTION[FExtraInfo];
   Inc(COL);

   if ShowCWRatio then begin
      Grid.Cells[COL, 0] := 'CW Q''s';
      Inc(COL);
      Grid.Cells[COL, 0] := 'CW %';
      Inc(COL);
      DispColCount := COL;
   end
   else begin
      Grid.Cells[COL,0] := '';
      Inc(COL);
      Grid.Cells[COL,0] := '';
      Inc(COL);
      DispColCount := COL - 2;
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
      COL := 0;
      Grid.Cells[COL, row] := '*' + MHzString[band];
      Inc(COL);
      Grid.Cells[COL, row] := IntToStr(QSO[band]);
      Inc(COL);
      Grid.Cells[COL, row] := IntToStr(Points[band]);
      Inc(COL);
      Grid.Cells[COL, row] := IntToStr(Multi[band]);
      Inc(COL);

      if FUseMulti2 = True then begin
         Grid.Cells[COL, row] := IntToStr(Multi2[band]);
         Inc(COL);
      end;

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
      Grid.Cells[COL, row] := strExtraInfo;
      Inc(COL);

      if ShowCWRatio then begin
         Grid.Cells[COL, row] := IntToStr(CWQSO[band]);
         Inc(COL);

         if QSO[band] > 0 then begin
            Grid.Cells[COL, row] := FloatToStrF(100 * (CWQSO[band] / QSO[band]), ffFixed, 1000, 1);
            Inc(COL);
         end
         else begin
            Grid.Cells[COL, row] := '-';
            Inc(COL);
         end;
      end;

      Inc(row);
   end;

   // 合計行
   COL := 0;
   Grid.Cells[COL, row] := 'Total';
   Inc(COL);
   Grid.Cells[COL, row] := IntToStr3(TotQSO);
   Inc(COL);
   Grid.Cells[COL, row] := IntToStr3(TotPoints);
   Inc(COL);
   Grid.Cells[COL, row] := IntToStr3(TotMulti);
   Inc(COL);
   if FUseMulti2 = True then begin
      Grid.Cells[COL, row] := IntToStr3(TotMulti2);
      Inc(COL);
   end;

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
   Grid.Cells[COL, row] := strExtraInfo;
   Inc(COL);

   // CW率
   if ShowCWRatio then begin
      Grid.Cells[COL, row] := IntToStr3(TotalCWQSOs);
      Inc(COL);
      if TotPoints > 0 then begin
         Grid.Cells[COL, row] := FloatToStrF(100 * (TotalCWQSOs / TotalQSOs), ffFixed, 1000, 1);
         Inc(COL);
      end
      else begin
         Grid.Cells[COL, row] := '-';
         Inc(COL);
      end;
   end
   else begin
      Grid.Cells[COL, row] := '';
      Inc(COL);
      Grid.Cells[COL, row] := '';
      Inc(COL);
   end;
   Inc(row);

   // スコア行
   strScore := IntToStr3(TotPoints * (TotMulti + TotMulti2));
   COL := 0;
   Grid.Cells[COL, row] := 'Score';      // MHz
   Inc(COL);
   Grid.Cells[COL, row] := '';           // QSOs
   Inc(COL);
   Grid.Cells[COL, row] := '';           // Points
   Inc(COL);
   Grid.Cells[COL, row] := strScore;     // Multi1
   Inc(COL);
   if FUseMulti2 = True then begin
      Grid.Cells[COL, row] := '';           // Multi2
      Inc(COL);
   end;
   Grid.Cells[COL, row] := '';           // Extra Info.
   Inc(COL);
   Grid.Cells[COL, row] := '';           // CW Q
   Inc(COL);
   Grid.Cells[COL, row] := '';           // CW %
   Inc(COL);
   Inc(row);

   // 行数をセット
   Grid.RowCount := row;

   // カラム幅をセット
   w := Grid.Canvas.TextWidth('9');
   COL := 0;
   Grid.ColWidths[COL] := w * 6;            // MHz
   Inc(COL);
   Grid.ColWidths[COL] := w * 7;            // QSOs
   Inc(COL);
   Grid.ColWidths[COL] := w * 7;            // Points
   Inc(COL);
   Grid.ColWidths[COL] := w * Max(8, Length(strScore) + 1);   // Multi1
   Inc(COL);
   if FUseMulti2 = True then begin
      Grid.ColWidths[COL] := w * 7;            // Multi2
      Inc(COL);
   end;
   Grid.ColWidths[COL] := w * 7;            // Extra Info.
   Inc(COL);
   Grid.ColWidths[COL] := w * 7;            // CW Q
   Inc(COL);
   Grid.ColWidths[COL] := w * 7;            // CW %
   Inc(COL);

   // グリッドサイズ調整
   AdjustGridSize(Grid, DispColCount, Grid.RowCount);
end;

end.
