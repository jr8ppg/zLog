unit UWAEScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, Buttons, ExtCtrls, Math,
  UzLogConst, UzLogGlobal, UzLogQSO, Vcl.Menus;

const
  BandFactor : array[b19..b28] of integer =
           (0, 4, 3, 0, 2, 0, 2, 0, 2);    // multi bonus factor

type
  TWAEScore = class(TBasicScore)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    QTCs : array[b19..b28] of integer;
  public
    procedure Reset; override;
    procedure Renew; override;
    procedure AddNoUpdate(aQSO: TQSO); override;
    procedure UpdateData; override;
  end;

implementation

{$R *.DFM}

procedure TWAEScore.FormShow(Sender: TObject);
begin
   inherited;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.Row := 1;
end;

procedure TWAEScore.Reset;
var
   B: TBand;
begin
   inherited;
   for B := b19 to b28 do begin
      QTCs[B] := 0;
   end;
end;

procedure TWAEScore.Renew;
var
   i: word;
   band: TBand;
begin
   Reset;
   for i := 1 to Log.TotalQSO do begin
      band := Log.QsoList[i].band;
      Inc(QSO[band]);
      Inc(Points[band], Log.QsoList[i].Points);

      if Log.QsoList[i].NewMulti1 then begin
         Inc(Multi[band]);
      end;
      if pos('[QTC', Log.QsoList[i].Memo) > 0 then begin
         Inc(QTCs[band]);
      end;
   end;
end;

procedure TWAEScore.AddNoUpdate(aQSO: TQSO);
var
   band: TBand;
begin
   inherited;

   if aQSO.Dupe then begin
      Exit;
   end;

   if aQSO.Multi1 = 'Non-EU' then begin
      Exit;
   end;

   band := aQSO.band;

   if FValidQso = True then begin
      aQSO.Points := 1;
   end
   else begin
      aQSO.Points := 0;
   end;

   Inc(Points[band], aQSO.Points);

   if FValidQso = True then begin
      if pos('[QTC', aQSO.Memo) > 0 then begin
         Inc(QTCs[band]);
      end;
   end;
end;

procedure TWAEScore.UpdateData;
var
   band: TBand;
   TotQSO, TotMulti, TotQTCs: LongInt;
   row: integer;
   w: Integer;
   strScore: string;
begin
   Grid.ColCount := 4;
   TotQSO := 0;
   TotMulti := 0;
   TotQTCs := 0;
   row := 1;

   // 見出し行
   Grid.Cells[0,0] := 'MHz';
   Grid.Cells[1,0] := 'QSOs';
   Grid.Cells[2,0] := 'Points';
   Grid.Cells[3,0] := 'Multi';

   for band := b35 to b28 do begin
      // WARC除外
      if IsWARC(band) = True then begin
         Continue;
      end;

      // QRVできないバンドは除外
      if dmZlogGlobal.Settings._activebands[band] = False then begin
         Continue;
      end;

      TotQSO := TotQSO + QSO[band];
      TotQTCs := TotQTCs + QTCs[band];
      TotMulti := TotMulti + BandFactor[band] * Multi[band];

      Grid.Cells[0, row] := '*' + MHzString[band];
      Grid.Cells[1, row] := IntToStr3(QSO[band]);
      Grid.Cells[2, row] := IntToStr3(QTCs[band]);
      Grid.Cells[3, row] := IntToStr3(BandFactor[band] * Multi[band]);

      Inc(row);
   end;

   // 合計行
   Grid.Cells[0, row] := 'Total';
   Grid.Cells[1, row] := IntToStr3(TotQSO);
   Grid.Cells[2, row] := IntToStr3(TotQTCs);
   Grid.Cells[3, row] := IntToStr3(TotMulti);
   Inc(row);

   // スコア行
   strScore := IntToStr3((TotQSO + TotQTCs) * TotMulti);
   Grid.Cells[0, row] := 'Score';
   Grid.Cells[1, row] := '';
   Grid.Cells[2, row] := '';
   Grid.Cells[3, row] := strScore;
   Inc(row);

   Grid.ColCount := 4;
   Grid.RowCount := row;

   // カラム幅をセット
   w := Grid.Canvas.TextWidth('9');
   Grid.ColWidths[0] := w * 6;
   Grid.ColWidths[1] := w * 7;
   Grid.ColWidths[2] := w * 7;
   Grid.ColWidths[3] := w * Max(8, Length(strScore)+1);

   // グリッドサイズ調整
   AdjustGridSize(Grid, Grid.ColCount, Grid.RowCount);
end;

end.
