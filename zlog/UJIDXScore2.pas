unit UJIDXScore2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TJIDXScore2 = class(TBasicScore)
    Grid: TStringGrid;
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Multi2 : array[b19..HiBand] of LongInt;
    constructor Create(AOwner: TComponent); override;
    procedure Renew; override;
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure UpdateData; override;
    procedure CalcPoints(var aQSO : TQSO);
  end;

implementation

{$R *.DFM}

constructor TJIDXScore2.Create(AOwner: TComponent);
var
   band : TBand;
begin
   inherited Create(AOwner);

   for band := b19 to HiBand do begin
      Multi2[band] := 0;
   end;
end;

procedure TJIDXScore2.FormShow(Sender: TObject);
begin
   inherited;
   CWButton.Visible := False;
end;

procedure TJIDXScore2.Renew;
var
   i: Integer;
   band : TBand;
begin
   Reset;

   for i := 1 to Log.TotalQSO do begin
      band := TQSO(Log.List[i]).band;
      Inc(QSO[band]);
      Inc(Points[band],TQSO(Log.List[i]).Points);

      if TQSO(Log.List[i]).NewMulti1 then begin
         Inc(Multi[band]);
      end;

      if TQSO(Log.List[i]).NewMulti2 then begin
         Inc(Multi2[band]);
      end;
   end;
end;

procedure TJIDXScore2.Reset;
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

procedure TJIDXScore2.CalcPoints(var aQSO : TQSO);
begin
   case aQSO.Band of
      b19 : aQSO.Points := 4;
      b35 : aQSO.Points := 2;
      b7..b21 : aQSO.Points := 1;
      b28 : aQSO.Points := 2;
      else
         aQSO.Points := 0;
   end;
end;

procedure TJIDXScore2.AddNoUpdate(var aQSO : TQSO);
begin
   inherited;

   if aQSO.Dupe then begin
      Exit;
   end;

   if aQSO.NewMulti2 then begin
      Inc(Multi2[aQSO.Band]);
   end;

   CalcPoints(aQSO);

   Inc(Points[aQSO.Band], aQSO.Points);
end;

procedure TJIDXScore2.UpdateData;
var
   band: TBand;
   TotQSO, TotPts, TotMulti, TotMulti2: Integer;
   row: Integer;
begin
   TotQSO := 0;
   TotPts := 0;
   TotMulti := 0;
   TotMulti2 := 0;
   row := 1;

   Grid.Cells[0, 0] := 'MHz';
   Grid.Cells[1, 0] := 'QSOs';
   Grid.Cells[2, 0] := 'Points';
   Grid.Cells[3, 0] := 'Multi';
   Grid.Cells[4, 0] := 'Multi2';

   for band := b19 to b28 do begin
      if NotWARC(band) then begin
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
   end;

   Grid.Cells[0, 7] := 'Total';
   Grid.Cells[1, 7] := IntToStr3(TotQSO);
   Grid.Cells[2, 7] := IntToStr3(TotPts);
   Grid.Cells[3, 7] := IntToStr3(TotMulti);
   Grid.Cells[4, 7] := IntToStr3(TotMulti2);

   Grid.Cells[0, 8] := 'Score';
   Grid.Cells[1, 8] := '';
   Grid.Cells[2, 8] := '';
   Grid.Cells[3, 8] := '';
   Grid.Cells[4, 8] := IntToStr(TotPts * (TotMulti + TotMulti2));

   Grid.ColCount := 5;
   Grid.RowCount := 9;
   ClientWidth := (Grid.DefaultColWidth * Grid.ColCount) + (Grid.ColCount * Grid.GridLineWidth);
   ClientHeight := (Grid.DefaultRowHeight * Grid.RowCount) + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
end;

procedure TJIDXScore2.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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
