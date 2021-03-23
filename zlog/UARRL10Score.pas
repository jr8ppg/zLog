unit UARRL10Score;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons, Math,
  UzLogConst, UzLogGlobal, UzLogQSO, Vcl.Menus;

type
  TARRL10Score = class(TBasicScore)
    Grid: TStringGrid;
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  protected
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateData; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
  end;

implementation

{$R *.DFM}

procedure TARRL10Score.UpdateData;
var
   strScore: string;
begin
   CWButton.Visible := False;

   Grid.RowCount := 6;
   Grid.ColCount := 2;
   Grid.Cells[0, 0] := 'QSO';
   Grid.Cells[0, 1] := 'Ph';
   Grid.Cells[0, 2] := 'CW';
   Grid.Cells[0, 3] := 'Pts';
   Grid.Cells[0, 4] := 'Multi';
   Grid.Cells[0, 5] := 'Score';

   strScore := IntToStr3(Points[b28] * Multi[b28]);
   Grid.Cells[1, 0] := IntToStr3(QSO[b28]);
   Grid.Cells[1, 1] := IntToStr3(QSO[b28] - CWQSO[b28]);
   Grid.Cells[1, 2] := IntToStr3(CWQSO[b28]);
   Grid.Cells[1, 3] := IntToStr3(Points[b28]);
   Grid.Cells[1, 4] := IntToStr3(Multi[b28]);
   Grid.Cells[1, 5] := strScore;

   // カラム幅をセット
   Grid.ColWidths[0] := 100;
   Grid.ColWidths[1] := 100;

   // グリッドサイズ調整
   AdjustGridSize(Grid, 2, Grid.RowCount);
end;

procedure TARRL10Score.AddNoUpdate(var aQSO: TQSO);
var
   i: Integer;
begin
   { BasicScore.AddNoUpdate(aQSO); }
   inherited;

   aQSO.Points := 0;
   if aQSO.Dupe then
      exit;

   if aQSO.Mode = mCW then begin
      i := length(aQSO.Callsign) - 1;
      if (pos('/N', aQSO.Callsign) = i) or (pos('/T', aQSO.Callsign) = i) then
         aQSO.Points := 8 // novice or technician cw qso : 8pts
      else
         aQSO.Points := 4;
   end
   else if aQSO.Mode in [mSSB, mFM, mAM] then begin
      aQSO.Points := 2;
   end;

   inc(Points[b28], aQSO.Points);
end;

procedure TARRL10Score.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(TStringGrid(Sender), ACol, ARow, Rect);
end;

function TARRL10Score.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TARRL10Score.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateData();
end;

end.
