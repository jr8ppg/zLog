unit UWWScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls, Buttons,
  UBasicScore, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TWWScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    Multi2 : array[b19..HiBand] of LongInt;
    constructor Create(AOwner: TComponent); override;
    procedure Renew; override;
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure Update; override;
    procedure SummaryWriteScore(FileName : string); override;
  end;

var
  WWScore: TWWScore;

implementation

{$R *.DFM}

constructor TWWScore.Create(AOwner: TComponent);
var
   band : TBand;
begin
   inherited Create(AOwner);

   for band := b19 to HiBand do begin
      Multi2[band] := 0;
   end;
end;

procedure TWWScore.FormShow(Sender: TObject);
begin
   inherited;
   CWButton.visible := False;
end;

procedure TWWScore.Renew;
var
   i: Integer;
   band: TBand;
begin
   Reset;
   for i := 1 to Log.TotalQSO do begin
      band := Log.Items[i].band;
      inc(QSO[band]);
      inc(Points[band],Log.Items[i].Points);

      if Log.Items[i].NewMulti1 then begin
        inc(Multi[band]);
      end;

      if Log.Items[i].NewMulti2 then begin
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

procedure TWWScore.AddNoUpdate(var aQSO : TQSO);
var
   P: Integer;
   band: TBand;
begin
   {BasicScore.AddNoUpdate(aQSO);}
   inherited;

   if aQSO.Dupe then begin
      exit;
   end;

   band := aQSO.band;
   if aQSO.NewMulti2 then begin
      Inc(Multi2[band]);
   end;

   Inc(Points[band], aQSO.Points); {Points calculated in WWMulti.AddNoUpdate}
end;

procedure TWWScore.Update;
var
   band : TBand;
   TotQSO, TotPts, TotMulti, TotMulti2: Integer;
   row: Integer;
begin
   TotQSO := 0;
   TotPts := 0;
   TotMulti := 0;
   TotMulti2 := 0;
   row := 1;

   // å©èoÇµçs
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
   Grid.Cells[4, 8] := IntToStr3(TotPts * (TotMulti + TotMulti2));

   Grid.ColCount := 5;
   Grid.RowCount := 9;
   ClientWidth := (Grid.DefaultColWidth * Grid.ColCount) + (Grid.ColCount * Grid.GridLineWidth);
   ClientHeight := (Grid.DefaultRowHeight * Grid.RowCount) + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
end;

procedure TWWScore.SummaryWriteScore(FileName : string);
var
   f : textfile;
   tqso, tpts, tmulti, tmulti2 : LongInt;
   b : TBand;
begin
   tqso := 0; tpts := 0; tmulti := 0; tmulti2 := 0;
   AssignFile(f, FileName);
   Append(f);
   writeln(f, 'MHz           QSOs    Points    Zones  Countries');
   for b := b19 to b28 do begin
      if NotWARC(b) then begin
         writeln(f, FillRight(MHzString[b],8)+FillLeft(IntToStr(QSO[b]),10)+
                  FillLeft(IntToStr(Points[b]),10)+FillLeft(IntToStr(Multi[b]),10)+
                  FillLeft(IntToStr(Multi2[b]),10));
         tqso := tqso + QSO[b];
         tpts := tpts + Points[b];
         tmulti := tmulti + Multi[b];
         tmulti2 := tmulti2 + Multi2[b];
      end;
   end;
   writeln(f, FillRight('Total :',8)+FillLeft(IntToStr(tqso),10)+
             FillLeft(IntToStr(tpts),10)+FillLeft(IntToStr(tmulti),10)+
             FIllLeft(IntToStr(tmulti2),10) );
   writeln(f,'Total score : ' + IntToStr(tpts*(tmulti+tmulti2)));
   CloseFile(f);
end;

procedure TWWScore.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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
