unit UWPXScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons,
  UzLogConst, UzLogGlobal, UzLogQSO, UWPXMulti;

type
  TWPXScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    FMultiForm: TWPXMulti;
  public
    { Public declarations }
    AllAsianDXMode : Boolean;
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure UpdateData; override;
    procedure SummaryWriteScore(FileName : string); override;
    property MultiForm: TWPXMulti read FMultiForm write FMultiForm;
  end;

implementation

{$R *.DFM}

procedure TWPXScore.Reset;
var
   band : TBand;
begin
   for band := b19 to HiBand do begin
      QSO[band] := 0;
      Points[band] := 0;
   end;
end;

procedure TWPXScore.AddNoUpdate(var aQSO : TQSO);
begin
   inherited; {points are calculated in WPXMulti}

   if aQSO.Dupe then begin
      Exit;
   end;

   if AllAsianDXMode then begin
      case aQSO.Band of
         b19: aQSO.Points := 3;
         b35, b28 : aQSO.Points := 2;
         b7..b21 : aQSO.Points := 1;
      end;

      if aQSO.Power2 = 777 then begin // asia. see uwpxmulti.addnoupdate
         aQSO.Points := 0;
      end;
   end;

   Inc(Points[aQSO.Band], aQSO.Points);
end;

procedure TWPXScore.UpdateData;
var
   band : TBand;
   TotQSO, TotPts : Integer;
   row : Integer;
begin
   TotQSO := 0;
   TotPts := 0;
   row := 1;

   Grid.Cells[0, 0] := 'MHz';
   Grid.Cells[1, 0] := 'QSOs';
   Grid.Cells[2, 0] := 'Points';

   for band := b19 to b28 do begin
      if NotWARC(band) then begin
         TotQSO := TotQSO + QSO[band];
         TotPts := TotPts + Points[band];

         Grid.Cells[0, row] := '*' + MHzString[band];
         Grid.Cells[1, row] := IntToStr3(QSO[band]);
         Grid.Cells[2, row] := IntToStr3(Points[band]);

         Inc(row);
      end;
   end;

   Grid.Cells[0, 7] := 'Total';
   Grid.Cells[1, 7] := IntToStr3(TotQSO);
   Grid.Cells[2, 7] := IntToStr3(TotPts);

   Grid.Cells[0, 8] := 'Prefixes';
   Grid.Cells[1, 8] := '';
   Grid.Cells[2, 8] := IntToStr3(FMultiForm.TotalPrefix);

   Grid.Cells[0, 9] := 'Score';
   Grid.Cells[1, 9] := '';
   Grid.Cells[2, 9] := IntToStr3(TotPts * FMultiForm.TotalPrefix);

   Grid.ColCount := 3;
   Grid.RowCount := 10;
   ClientWidth := (Grid.DefaultColWidth * Grid.ColCount) + (Grid.ColCount * Grid.GridLineWidth);
   ClientHeight := (Grid.DefaultRowHeight * Grid.RowCount) + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
end;

procedure TWPXScore.SummaryWriteScore(FileName : string);
var
   f : textfile;
   tqso, tpts : LongInt;
   b : TBand;
begin
   tqso := 0;
   tpts := 0; {tmulti := 0; }
   AssignFile(f, FileName);
   Append(f);
   writeln(f, 'MHz           QSOs    Points');
   for b := b19 to b28 do begin
      if NotWARC(b) then begin
         writeln(f, FillRight(MHzString[b],8) + FillLeft(IntToStr(QSO[b]),10) + FillLeft(IntToStr(Points[b]),10) );
         tqso := tqso + QSO[b];
         tpts := tpts + Points[b];
      end;
   end;

   writeln(f, FillRight('Total :',8) + FillLeft(IntToStr(tqso),10) + FillLeft(IntToStr(tpts),10) );
   writeln(f, 'Total prefixes: ' + IntToStr(FMultiForm.TotalPrefix));
   writeln(f, 'Total score : ' + IntToStr(tpts * FMultiForm.TotalPrefix));
   CloseFile(f);
end;

procedure TWPXScore.FormCreate(Sender: TObject);
begin
   inherited;
   AllAsianDXMode := false;
end;

procedure TWPXScore.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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
