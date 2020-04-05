unit UKCJScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons,
  UzLOgConst, UzLogGlobal, UzLogQSO;

type
  TKCJScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure Update; override;
  end;

implementation

{$R *.DFM}

procedure TKCJScore.AddNoUpdate(var aQSO: TQSO);
var
   band: TBand;
begin
   inherited;

   if aQSO.Dupe then begin
      Exit;
   end;

   band := aQSO.band;
   // aQSO.points := 1;

   if pos(aQSO.NrRcvd + '$', 'AS$NA$SA$EU$AF$OC$') > 0 then begin
      aQSO.Points := 5;
   end
   else begin
      aQSO.Points := 1;
   end;

   Inc(Points[band], aQSO.Points);
end;

procedure TKCJScore.Update;
var
   band: TBand;
   TotPoints, TotMulti: LongInt;
   row: Integer;
begin
   TotPoints := 0;
   TotMulti := 0;
   row := 1;

   // å©èoÇµçs
   Grid.Cells[0, 0] := 'MHz';
   Grid.Cells[1, 0] := 'Points';
   Grid.Cells[2, 0] := 'Multi';

   for band := b19 to b50 do begin
      if NotWARC(band) then begin
         TotPoints := TotPoints + Points[band];
         TotMulti := TotMulti + Multi[band];

         Grid.Cells[0, row] := '*' + MHzString[band];
         Grid.Cells[1, row] := IntToStr3(Points[band]);
         Grid.Cells[2, row] := IntToStr3(Multi[band]);

         Inc(row);
      end;
   end;

   Grid.Cells[0, 8] := 'Total';
   Grid.Cells[1, 8] := IntToStr3(TotPoints);
   Grid.Cells[2, 8] := IntToStr3(TotMulti);

   Grid.Cells[0, 9] := 'Score';
   Grid.Cells[1, 9] := '';
   Grid.Cells[2, 9] := IntToStr3(TotPoints * TotMulti);

   Grid.ColCount := 3;
   Grid.RowCount := 10;
   ClientWidth := (Grid.DefaultColWidth * Grid.ColCount) + (Grid.ColCount * Grid.GridLineWidth);
   ClientHeight := (Grid.DefaultRowHeight * Grid.RowCount) + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
end;

procedure TKCJScore.FormShow(Sender: TObject);
begin
   inherited;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.Row := 1;
   CWButton.Visible := False;
end;

procedure TKCJScore.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   strText: string;
begin
   inherited;
   strText := TStringGrid(Sender).Cells[ACol, ARow];

   with TStringGrid(Sender).Canvas do begin
      Brush.Color := TStringGrid(Sender).Color;
      Brush.Style := bsSolid;
      FillRect(Rect);

      Font.Name := 'ÇlÇr ÉSÉVÉbÉN';
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
