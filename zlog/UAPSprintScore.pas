unit UAPSprintScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons,
  UWPXMulti, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TAPSprintScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    FMultiForm: TWPXMulti;
  public
    { Public declarations }
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure Update; override;
    property MultiForm: TWPXMulti read FMultiForm write FMultiForm;
  end;

implementation

{$R *.DFM}

procedure TAPSprintScore.Reset;
var
   band : TBand;
begin
   for band := b19 to HiBand do begin
      QSO[band] := 0;
      Points[band] := 0;
   end;
end;

procedure TAPSprintScore.AddNoUpdate(var aQSO : TQSO);
begin
   inherited;

   if aQSO.Dupe then begin
      Exit;
   end;

   aQSO.Points := 1;
   Inc(Points[aQSO.Band]);
end;

procedure TAPSprintScore.Update;
var
   TotPts : LongInt;
begin
   // å©èoÇµçs
   Grid.Cells[0, 0] := 'MHz';
   Grid.Cells[1, 0] := 'Points';

   TotPts := 0;
   Grid.Cells[0, 1] := '7';
   Grid.Cells[1, 1] := IntToStr3(Points[b7]);

   Grid.Cells[0, 2] := '14';
   Grid.Cells[1, 2] := IntToStr3(Points[b14]);

   Grid.Cells[0, 3] := '21';
   Grid.Cells[1, 3] := IntToStr3(Points[b21]);

   TotPts := Points[b7] + Points[b14] + Points[b21];
   Grid.Cells[0, 4] := 'Total';
   Grid.Cells[1, 4] := IntToStr3(TotPts);

   Grid.Cells[0, 5] := 'Multi';
   Grid.Cells[1, 5] := IntToStr3(FMultiForm.TotalPrefix);

   Grid.Cells[0, 6] := 'Score';
   Grid.Cells[1, 6] := IntToStr3(TotPts * FMultiForm.TotalPrefix);

   Grid.ColCount := 2;
   Grid.RowCount := 7;
   ClientWidth := (Grid.DefaultColWidth * Grid.ColCount) + (Grid.ColCount * Grid.GridLineWidth);
   ClientHeight := (Grid.DefaultRowHeight * Grid.RowCount) + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
end;

procedure TAPSprintScore.FormShow(Sender: TObject);
begin
   inherited;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.Row := 1;
end;

procedure TAPSprintScore.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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
   end;end;

end.
