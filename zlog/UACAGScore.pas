unit UACAGScore;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Menus, Buttons, Math,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TACAGScore = class(TBasicScore)
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

uses
  Main;

{$R *.DFM}

procedure TACAGScore.FormShow(Sender: TObject);
begin
   inherited;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.Row := 1;
end;

procedure TACAGScore.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(TStringGrid(Sender), ACol, ARow, Rect);
end;

procedure TACAGScore.AddNoUpdate(var aQSO : TQSO);
var
   band : TBand;
begin
   inherited;

   if aQSO.Dupe then begin
      Exit;
   end;

   band := aQSO.band;
   aQSO.points := 1;
   Inc(Points[band]);
end;

procedure TACAGScore.UpdateData;
var
   band: TBand;
   TotQSO, TotPoints, TotMulti: Integer;
   row: integer;
   mb: TMenuItem;
   w: Integer;
   strScore: string;
   DispColCount: Integer;
begin
   TotQSO := 0;
   TotPoints := 0;
   TotMulti := 0;
   row := 1;

   // 見出し行
   Grid.Cells[0,0] := 'MHz';
   Grid.Cells[1,0] := 'Points';
   Grid.Cells[2,0] := 'Multi';

   if ShowCWRatio then begin
      Grid.Cells[3,0] := 'CW Q''s';
      Grid.Cells[4,0] := 'CW %';
      DispColCount := 5;
   end
   else begin
      Grid.Cells[3,0] := '';
      Grid.Cells[4,0] := '';
      DispColCount := 3;
   end;

   // バンド別スコア行
   for band := b35 to HiBand do begin
      if NotWARC(band) then begin
         TotPoints := TotPoints + Points[band];
         TotMulti := TotMulti + Multi[band];
         TotQSO := TotQSO + QSO[band];

         mb := MainForm.BandMenu.Items[ord(band)];
         if mb.Visible and mb.Enabled then begin
            Grid.Cells[0, row] := '*' + MHzString[band];
            Grid.Cells[1, row] := IntToStr3(Points[band]);
            Grid.Cells[2, row] := IntToStr3(Multi[band]);

            if ShowCWRatio then begin
               Grid.Cells[3, row] := IntToStr3(CWQSO[band]);
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
      end;
   end;

   // 合計行
   Grid.Cells[0, row] := 'Total';
   Grid.Cells[1, row] := IntToStr3(TotPoints);
   Grid.Cells[2, row] := IntToStr3(TotMulti);

   if ShowCWRatio then begin
      Grid.Cells[3, row] := IntToStr3(TotalCWQSOs);
      if TotQSO > 0 then begin
         Grid.Cells[4, row] := FloatToStrF(100 * (TotalCWQSOs / TotQSO), ffFixed, 1000, 1);
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

procedure TACAGScore.Reset;
begin
   inherited;
end;

procedure TACAGScore.Add(var aQSO : TQSO);
begin
   inherited;
end;

function TACAGScore.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TACAGScore.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateData();
end;

end.
