unit UKCJScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons, Math,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TKCJScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
  protected
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure UpdateData; override;
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

implementation

{$R *.DFM}

procedure TKCJScore.FormShow(Sender: TObject);
begin
   inherited;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.Row := 1;
   CWButton.Visible := False;
end;

procedure TKCJScore.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(TStringGrid(Sender), ACol, ARow, Rect);
end;

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

procedure TKCJScore.UpdateData;
var
   band: TBand;
   TotPoints, TotMulti: LongInt;
   row: Integer;
   w: Integer;
   strScore: string;
begin
   TotPoints := 0;
   TotMulti := 0;
   row := 1;

   // 見出し行
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

   // 合計行
   Grid.Cells[0, 8] := 'Total';
   Grid.Cells[1, 8] := IntToStr3(TotPoints);
   Grid.Cells[2, 8] := IntToStr3(TotMulti);

   // スコア行
   strScore := IntToStr3(TotPoints * TotMulti);
   Grid.Cells[0, 9] := 'Score';
   Grid.Cells[1, 9] := '';
   Grid.Cells[2, 9] := strScore;

   Grid.ColCount := 3;
   Grid.RowCount := 10;

   // カラム幅をセット
   w := Grid.Canvas.TextWidth('9');
   Grid.ColWidths[0] := w * 6;
   Grid.ColWidths[1] := w * 7;
   Grid.ColWidths[2] := w * Max(8, Length(strScore)+1);

   // グリッドサイズ調整
   AdjustGridSize(Grid, Grid.ColCount, Grid.RowCount);
end;

function TKCJScore.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TKCJScore.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateData();
end;

end.
