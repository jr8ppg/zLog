unit UJIDX_DX_Score;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, StdCtrls, ExtCtrls, Grids, Buttons,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TJIDX_DX_Score = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Renew; override;
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure UpdateData; override;
    procedure CalcPoints(var aQSO : TQSO); virtual;
  end;

var
  JIDX_DX_Score: TJIDX_DX_Score;

implementation

{$R *.DFM}

procedure TJIDX_DX_Score.Renew;
var
   i: Integer;
   band: TBand;
begin
   Reset;
   for i := 1 to Log.TotalQSO do begin
      band := TQSO(Log.List[i]).band;
      Inc(QSO[band]);
      Inc(Points[band], TQSO(Log.List[i]).Points);
      if TQSO(Log.List[i]).NewMulti1 then begin
         Inc(Multi[band]);
      end;
   end;
end;

procedure TJIDX_DX_Score.Reset;
var
   band: TBand;
begin
   for band := b19 to HiBand do begin
      QSO[band] := 0;
      CWQSO[band] := 0;
      Points[band] := 0;
      Multi[band] := 0;
   end;
end;

procedure TJIDX_DX_Score.CalcPoints(var aQSO: TQSO);
begin
   case aQSO.band of
      b19:
         aQSO.Points := 4;
      b35:
         aQSO.Points := 2;
      b7 .. b21:
         aQSO.Points := 1;
      b28:
         aQSO.Points := 2;
      else
         aQSO.Points := 0;
   end;
end;

procedure TJIDX_DX_Score.FormShow(Sender: TObject);
begin
   inherited;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.Row := 1;
   CWButton.Visible := False;
end;

procedure TJIDX_DX_Score.AddNoUpdate(var aQSO: TQSO);
begin
   inherited;

   if aQSO.Dupe then begin
      Exit;
   end;

   CalcPoints(aQSO);
   Inc(Points[aQSO.band], aQSO.Points);
end;

procedure TJIDX_DX_Score.UpdateData;
var
   band: TBand;
   TotQSO, TotPts, TotMulti: LongInt;
   row: Integer;
begin
   TotQSO := 0;
   TotPts := 0;
   TotMulti := 0;
   row := 1;

   // å©èoÇµçs
   Grid.Cells[0,0] := 'MHz';
   Grid.Cells[1,0] := 'QSOs';
   Grid.Cells[2,0] := 'Points';
   Grid.Cells[3,0] := 'Multi';

   for band := b19 to b28 do begin
      if NotWARC(band) then begin
         TotQSO := TotQSO + QSO[band];
         TotPts := TotPts + Points[band];
         TotMulti := TotMulti + Multi[band];

         Grid.Cells[0, row] := '*' + MHzString[band];
         Grid.Cells[1, row] := IntToStr3(QSO[band]);
         Grid.Cells[2, row] := IntToStr3(Points[band]);
         Grid.Cells[3, row] := IntToStr3(Multi[band]);

         Inc(row);
      end;
   end;

   Grid.Cells[0, 7] := 'Total';
   Grid.Cells[1, 7] := IntToStr3(TotQSO);
   Grid.Cells[2, 7] := IntToStr3(TotPts);
   Grid.Cells[3, 7] := IntToStr3(TotMulti);

   Grid.Cells[0, 8] := 'Score';
   Grid.Cells[1, 8] := '';
   Grid.Cells[2, 8] := '';
   Grid.Cells[3, 8] := IntToStr3(TotPts * TotMulti);

   Grid.ColCount := 4;
   Grid.RowCount := 9;
   ClientWidth := (Grid.DefaultColWidth * Grid.ColCount) + (Grid.ColCount * Grid.GridLineWidth);
   ClientHeight := (Grid.DefaultRowHeight * Grid.RowCount) + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
end;

procedure TJIDX_DX_Score.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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
