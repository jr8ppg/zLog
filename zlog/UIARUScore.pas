unit UIARUScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons, Cologrid,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TIARUScore = class(TBasicScore)
    Grid: TMgrid;
    procedure FormCreate(Sender: TObject);
    procedure GridSetting(ARow, Acol: Integer; var Fcolor: Integer;
      var Bold, Italic, underline: Boolean);
  private
    { Private declarations }
    BLo, BHi : TBand;
  public
    procedure InitGrid(B0, B1 : TBand);
    procedure UpdateData; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TIARUScore.AddNoUpdate(var aQSO: TQSO);
var
   band: TBand;
begin
   { BasicScore.AddNoUpdate(aQSO); }
   inherited;
   if aQSO.Dupe then
      exit;

   band := aQSO.band;
   { if aQSO.QSO.NewMulti2 then
     inc(Multi2[band]); }

   inc(Points[band], aQSO.Points); { Points calculated in WWMulti.AddNoUpdate }
end;

procedure TIARUScore.InitGrid(B0, B1: TBand);
var
   B: TBand;
   i: Integer;
begin
   BLo := B0;
   BHi := B1;
   with Grid do begin
      RowCount := 9;
      ColCount := 4;
      Cells[0, 0] := 'MHz';
      Cells[1, 0] := 'QSOs';
      Cells[2, 0] := 'Points';
      Cells[3, 0] := 'Multi';

      i := 1;
      for B := B0 to B1 do begin
         if NotWARC(B) then begin
            Cells[0, i] := MHzString[B];
            inc(i);
         end;
      end;

      Cells[0, i] := 'Total';
      Cells[0, i + 1] := 'Score';
      Color := clBtnFace;
      RowCount := i + 2;
      Height := GridHeight;
   end;
   ClientHeight := Grid.Height + Panel1.Height + 10;
end;

procedure TIARUScore.FormCreate(Sender: TObject);
begin
   inherited;
   InitGrid(b19, b28);
   // ShowCWRatio := True;
end;

procedure TIARUScore.UpdateData;
var
   band: TBand;
   TotQSO, TotPts, TotMulti: LongInt;
   row: Integer;
begin
   TotQSO := 0;
   TotPts := 0;
   TotMulti := 0;

   if ShowCWRatio then begin
      Grid.ColCount := 6;
      Grid.Width := Grid.DefaultColWidth * 6;
   end
   else begin
      Grid.ColCount := 4;
      Grid.Width := Grid.DefaultColWidth * 4;
   end;

   if ShowCWRatio then begin
      Grid.Cells[4, 0] := 'CW Q''s';
      Grid.Cells[5, 0] := 'CW %';
   end;

   row := 1;
   for band := BLo to BHi do begin
      if NotWARC(band) then begin
         Grid.Cells[1, row] := IntToStr(QSO[band]);
         TotQSO := TotQSO + QSO[band];
         Grid.Cells[2, row] := IntToStr(Points[band]);
         TotPts := TotPts + Points[band];
         Grid.Cells[3, row] := IntToStr(Multi[band]);
         TotMulti := TotMulti + Multi[band];

         if ShowCWRatio then begin
            Grid.Cells[4, row] := IntToStr(CWQSO[band]);
            if QSO[band] > 0 then
               Grid.Cells[5, row] := FloatToStrF(100 * (CWQSO[band] / QSO[band]), ffFixed, 1000, 1)
            else
               Grid.Cells[5, row] := '-';
         end;

         inc(row);
      end;
   end;
   Grid.Cells[1, row] := IntToStr(TotQSO);
   Grid.Cells[2, row] := IntToStr(TotPts);
   Grid.Cells[3, row] := IntToStr(TotMulti);
   Grid.Cells[3, row + 1] := IntToStr(TotPts * TotMulti);

   if ShowCWRatio then begin
      Grid.Cells[4, row] := IntToStr(TotalCWQSOs);
      if TotPts > 0 then
         Grid.Cells[5, row] := FloatToStrF(100 * (TotalCWQSOs / TotalQSOs), ffFixed, 1000, 1)
      else
         Grid.Cells[5, row] := '-';
   end;
end;

procedure TIARUScore.GridSetting(ARow, Acol: Integer; var Fcolor: Integer; var Bold, Italic, underline: Boolean);
begin
   inherited;
   if Acol = 0 then
      Fcolor := clBlue
   else if ARow = 0 then
      Fcolor := clGreen
   else
      Fcolor := clBlack;
end;

end.
