unit UJIDX_DX_Score;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, StdCtrls, ExtCtrls, Grids, Buttons, Math,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TJIDX_DX_Score = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  protected
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Renew; override;
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure UpdateData; override;
    procedure CalcPoints(var aQSO : TQSO); virtual;
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

implementation

{$R *.DFM}

procedure TJIDX_DX_Score.FormShow(Sender: TObject);
begin
   inherited;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.Row := 1;
   CWButton.Visible := False;
end;

procedure TJIDX_DX_Score.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(TStringGrid(Sender), ACol, ARow, Rect);
end;

procedure TJIDX_DX_Score.Renew;
var
   i: Integer;
   band: TBand;
begin
   Reset;
   for i := 1 to Log.TotalQSO do begin
      band := Log.QsoList[i].band;
      Inc(QSO[band]);
      Inc(Points[band], Log.QsoList[i].Points);
      if Log.QsoList[i].NewMulti1 then begin
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
   w: Integer;
   strScore: string;
begin
   TotQSO := 0;
   TotPts := 0;
   TotMulti := 0;
   row := 1;

   // 見出し行
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

   // 合計行
   Grid.Cells[0, 7] := 'Total';
   Grid.Cells[1, 7] := IntToStr3(TotQSO);
   Grid.Cells[2, 7] := IntToStr3(TotPts);
   Grid.Cells[3, 7] := IntToStr3(TotMulti);

   // スコア行
   strScore := IntToStr3(TotPts * TotMulti);
   Grid.Cells[0, 8] := 'Score';
   Grid.Cells[1, 8] := '';
   Grid.Cells[2, 8] := '';
   Grid.Cells[3, 8] := strScore;

   Grid.ColCount := 4;
   Grid.RowCount := 9;

   // カラム幅をセット
   w := Grid.Canvas.TextWidth('9');
   Grid.ColWidths[0] := w * 6;
   Grid.ColWidths[1] := w * 7;
   Grid.ColWidths[2] := w * 7;
   Grid.ColWidths[3] := w * Max(8, Length(strScore)+1);

   // グリッドサイズ調整
   AdjustGridSize(Grid, Grid.ColCount, Grid.RowCount);
end;

function TJIDX_DX_Score.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TJIDX_DX_Score.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateData();
end;

end.
