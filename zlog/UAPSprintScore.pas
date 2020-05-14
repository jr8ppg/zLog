unit UAPSprintScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons, Math,
  UWPXMulti, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TAPSprintScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  protected
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
  private
    { Private declarations }
    FMultiForm: TWPXMulti;
  public
    { Public declarations }
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure UpdateData; override;
    property MultiForm: TWPXMulti read FMultiForm write FMultiForm;
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

implementation

{$R *.DFM}

procedure TAPSprintScore.FormShow(Sender: TObject);
begin
   inherited;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.Row := 1;
end;

procedure TAPSprintScore.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(TStringGrid(Sender), ACol, ARow, Rect);
end;

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

procedure TAPSprintScore.UpdateData;
var
   TotPts: Integer;
   w: Integer;
   strScore: string;
begin
   // 見出し行
   Grid.Cells[0, 0] := 'MHz';
   Grid.Cells[1, 0] := 'Points';

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

   strScore := IntToStr3(TotPts * FMultiForm.TotalPrefix);
   Grid.Cells[0, 6] := 'Score';
   Grid.Cells[1, 6] := strScore;

   Grid.ColCount := 2;
   Grid.RowCount := 7;

   // カラム幅をセット
   w := Grid.Canvas.TextWidth('9');
   Grid.ColWidths[0] := w * 10;
   Grid.ColWidths[1] := w * Max(10, Length(strScore)+1);

   // グリッドサイズ調整
   AdjustGridSize(Grid, Grid.ColCount, Grid.RowCount);
end;

function TAPSprintScore.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TAPSprintScore.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateData();
end;

end.
