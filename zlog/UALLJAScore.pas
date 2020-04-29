unit UALLJAScore;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TALLJAScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure UpdateData; override;
    procedure Reset; override;
    procedure Add(var aQSO : TQSO); override;
  end;

implementation

{$R *.DFM}

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
   end
   else begin
      Grid.Cells[3,0] := '';
      Grid.Cells[4,0] := '';
   end;

   // バンド別スコア行
   for band := b35 to b50 do begin
      if NotWARC(band) then begin
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
   Grid.Cells[0, row] := 'Score';
   Grid.Cells[1, row] := '';
   Grid.Cells[2, row] := IntToStr3(TotPoints * TotMulti);
   Grid.Cells[3, row] := '';
   Grid.Cells[4, row] := '';
   Inc(row);

   Grid.RowCount := row;
   ClientWidth := (Grid.DefaultColWidth * Grid.ColCount) + (Grid.ColCount * Grid.GridLineWidth);
   ClientHeight := (Grid.DefaultRowHeight * Grid.RowCount) + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
end;

procedure TALLJAScore.Reset;
begin
   inherited;
end;

procedure TALLJAScore.Add(var aQSO: TQSO);
begin
   inherited;
end;

procedure TALLJAScore.FormShow(Sender: TObject);
begin
   inherited;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.Row := 1;
end;

procedure TALLJAScore.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   strText: string;
begin
   inherited;
   strText := TStringGrid(Sender).Cells[ACol, ARow];

   with TStringGrid(Sender).Canvas do begin
      Brush.Color := TStringGrid(Sender).Color;
      Brush.Style := bsSolid;
      FillRect(Rect);

      Font.Name := 'ＭＳ ゴシック';
      Font.Size := 11;

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

end.
