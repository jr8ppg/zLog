unit UALLJAScore;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons, Math,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TALLJAScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  protected
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure UpdateData; override;
    procedure Reset; override;
    procedure Add(var aQSO : TQSO); override;
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

implementation

{$R *.DFM}

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
   aQSO.points := 1;
   Inc(points[band]);
end;

procedure TALLJAScore.UpdateData;
var
   band: TBand;
   TotPoints, TotMulti: Integer;
   row: Integer;
   w: Integer;
   strScore: string;
   DispColCount: Integer;
begin
   TotPoints := 0;
   TotMulti := 0;
   row := 1;

   // 見出し行
   Grid.Cells[0,0] := 'MHz';
   Grid.Cells[1,0] := 'Points';
   Grid.Cells[2,0] := 'Multi';

   if ShowCWRatio then begin
      Grid.Cells[3, 0] := 'CW Q''s';
      Grid.Cells[4, 0] := 'CW %';
      DispColCount := 5;
   end
   else begin
      Grid.Cells[3,0] := '';
      Grid.Cells[4,0] := '';
      DispColCount := 3;
   end;

   // バンド別スコア行
   for band := b35 to b50 do begin
      // WARC除外
      if IsWARC(band) = True then begin
         Continue;
      end;

      // QRVできないバンドは除外
      if dmZlogGlobal.Settings._activebands[band] = False then begin
         Continue;
      end;

      // バンド別スコア
      Grid.Cells[0, row] := '*' + MHzString[band];
      Grid.Cells[1, row] := IntToStr(points[band]);
      TotPoints := TotPoints + points[band];
      Grid.Cells[2, row] := IntToStr(Multi[band]);
      TotMulti := TotMulti + Multi[band];
      if ShowCWRatio then begin
         Grid.Cells[3, row] := IntToStr(CWQSO[band]);
         if QSO[band] > 0 then begin
            Grid.Cells[4, row] := FloatToStrF(100 * (CWQSO[band] / QSO[band]), ffFixed, 1000, 1);
         end
         else begin
            Grid.Cells[4, row] := '-';
         end;
      end
      else begin
         Grid.Cells[3, row] := '';
         Grid.Cells[4, row] := '';
      end;

      Inc(row);
   end;

   // 合計行
   Grid.Cells[0, row] := 'Total';
   Grid.Cells[1, row] := IntToStr3(TotPoints);
   Grid.Cells[2, row] := IntToStr3(TotMulti);

   if ShowCWRatio then begin
      Grid.Cells[3, row] := IntToStr3(TotalCWQSOs);
      if TotPoints > 0 then begin
         Grid.Cells[4, row] := FloatToStrF(100 * (TotalCWQSOs / TotalQSOs), ffFixed, 1000, 1);
      end
      else begin
         Grid.Cells[4, row] := '-';
      end;
   end
   else begin
      Grid.Cells[3, row] := '';
      Grid.Cells[4, row] := '';
   end;
   Inc(row);

   // スコア行
   strScore := IntToStr3(TotPoints * TotMulti);
   Grid.Cells[0, row] := 'Score';
   Grid.Cells[1, row] := '';
   Grid.Cells[2, row] := strScore;
   Grid.Cells[3, row] := '';
   Grid.Cells[4, row] := '';
   Inc(row);

   // 行数をセット
   Grid.RowCount := row;

   // カラム幅をセット
   w := Grid.Canvas.TextWidth('9');
   Grid.ColWidths[0] := w * 6;
   Grid.ColWidths[1] := w * 7;
   Grid.ColWidths[2] := w * Max(8, Length(strScore)+1);
   Grid.ColWidths[3] := w * 7;
   Grid.ColWidths[4] := w * 7;

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

end.
