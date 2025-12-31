unit UWWScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls, Buttons, Math,
  UBasicScore, UzLogConst, UzLogGlobal, UzLogQSO, Vcl.Menus;

type
  TWWScore = class(TBasicScore)
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); overload;
    procedure Renew; override;
    procedure Reset; override;
    procedure AddNoUpdate(aQSO: TQSO); override;
    procedure UpdateData; override;
  end;

var
  WWScore: TWWScore;

implementation

{$R *.DFM}

constructor TWWScore.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
end;

procedure TWWScore.FormCreate(Sender: TObject);
begin
   inherited;
   Grid.Canvas.Font.Name := 'ＭＳ ゴシック';
end;

procedure TWWScore.FormShow(Sender: TObject);
begin
   inherited;
   CWButton.Visible := False;
end;

procedure TWWScore.Renew;
var
   i: Integer;
   band: TBand;
begin
   Reset;
   for i := 1 to Log.TotalQSO do begin
      band := Log.QsoList[i].band;
      inc(QSO[band]);
      inc(Points[band],Log.QsoList[i].Points);

      if Log.QsoList[i].NewMulti1 then begin
        inc(Multi[band]);
      end;

      if Log.QsoList[i].NewMulti2 then begin
        inc(Multi2[band]);
      end;
   end;
end;

procedure TWWScore.Reset;
var
   band : TBand;
begin
   for band := b19 to HiBand do begin
      QSO[band] := 0;
      CWQSO[band] := 0;
      Points[band] := 0;
      Multi[band] := 0;
      Multi2[band] := 0;
   end;
end;

procedure TWWScore.AddNoUpdate(aQSO: TQSO);
var
   band: TBand;
begin
   Inherited;

   if aQSO.Dupe then begin
      exit;
   end;

   band := aQSO.band;

   if FValidQso = True then begin
      {Points calculated in WWMulti.AddNoUpdate}
   end
   else begin
      aQSO.Points := 0;
   end;

   Inc(Points[band], aQSO.Points);
end;

procedure TWWScore.UpdateData;
var
   band : TBand;
   TotQSO, TotPts, TotMulti, TotMulti2: Integer;
   row: Integer;
   i: Integer;
   h: Integer;
   w: Integer;
   strScore: string;
begin
   Grid.ColCount := 5;
   TotQSO := 0;
   TotPts := 0;
   TotMulti := 0;
   TotMulti2 := 0;
   row := 1;

   // 見出し行
   Grid.Cells[0, 0] := 'MHz';
   Grid.Cells[1, 0] := 'QSOs';
   Grid.Cells[2, 0] := 'Points';
   Grid.Cells[3, 0] := 'Multi';
   Grid.Cells[4, 0] := 'Multi2';

   for band := b19 to b28 do begin
      // WARC除外
      if IsWARC(band) = True then begin
         Continue;
      end;

      // QRVできないバンドは除外
      if dmZlogGlobal.Settings._activebands[band] = False then begin
         Continue;
      end;

      TotQSO := TotQSO + QSO[band];
      TotPts := TotPts + Points[band];
      TotMulti := TotMulti + Multi[band];
      TotMulti2 := TotMulti2 + Multi2[band];

      Grid.Cells[0, row] := '*' + MHzString[band];
      Grid.Cells[1, row] := IntToStr3(QSO[band]);
      Grid.Cells[2, row] := IntToStr3(Points[band]);
      Grid.Cells[3, row] := IntToStr3(Multi[band]);
      Grid.Cells[4, row] := IntToStr3(Multi2[band]);

      Inc(row);
   end;

   // 合計行
   Grid.Cells[0, row] := 'Total';
   Grid.Cells[1, row] := IntToStr3(TotQSO);
   Grid.Cells[2, row] := IntToStr3(TotPts);
   Grid.Cells[3, row] := IntToStr3(TotMulti);
   Grid.Cells[4, row] := IntToStr3(TotMulti2);
   Inc(row);

   // スコア行
   strScore:= IntToStr3(TotPts * (TotMulti + TotMulti2));
   Grid.Cells[0, row] := 'Score';
   Grid.Cells[1, row] := '';
   Grid.Cells[2, row] := '';
   Grid.Cells[3, row] := '';
   Grid.Cells[4, row] := strScore;
   Inc(row);

   // 行数をセット
   Grid.ColCount := 5;
   Grid.RowCount := row;

   // カラム幅をセット
   w := Grid.Canvas.TextWidth('9');
   Grid.ColWidths[0] := w * 6;
   Grid.ColWidths[1] := w * 7;
   Grid.ColWidths[2] := w * 7;
   Grid.ColWidths[3] := w * 7;
   Grid.ColWidths[4] := w * Max(8, Length(strScore)+1);

   // 幅調整
   w := 0;
   for i := 0 to Grid.ColCount - 1 do begin
      w := w + Grid.ColWidths[i];
   end;
   w := w + (Grid.ColCount * Grid.GridLineWidth) + 2;
   ClientWidth := Max(w, 200);

   // 高さ調整
   h := 0;
   for i := 0 to Grid.RowCount - 1 do begin
      h := h + Grid.RowHeights[i];
   end;
   h := h + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
   ClientHeight := h;
end;

end.
