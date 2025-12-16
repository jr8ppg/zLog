unit UJA0Score;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons, Math,
  UzLogConst, UzLogGlobal, UzLogQSO, Vcl.Menus;

const
  JA0Band: array[0..4] of TBand = ( b19, b35, b7, b21, b28 );

type
  TJA0Score = class(TBasicScore)
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
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure UpdateData; override;
    function IsJA0(aQSO : TQSO) : boolean;
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

implementation

uses Main;

{$R *.DFM}

procedure TJA0Score.FormShow(Sender: TObject);
begin
   inherited;
   CWButton.Visible := False;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.Row := 1;
end;

procedure TJA0Score.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(TStringGrid(Sender), ACol, ARow, Rect);
end;

procedure TJA0Score.Reset;
var
   band : TBand;
begin
   for band := b19 to HiBand do begin
      QSO[band] := 0;
      Points[band] := 0;
      Multi[band] := 0;
   end;
end;

function TJA0Score.IsJA0(aQSO : TQSO) : boolean;
begin
   if Pos('0',aQSO.CallSign) > 0 then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TJA0Score.AddNoUpdate(var aQSO : TQSO);
begin
   inherited;

   if aQSO.Dupe then begin
      Exit;
   end;

   if IsJA0(aQSO) then begin
      aQSO.Points := 3;
   end
   else begin
      aQSO.Points := 1;
   end;

   Inc(Points[aQSO.band], aQSO.Points);
end;

procedure TJA0Score.UpdateData;
var
   band: TBand;
   TotQSO, TotPoints, TotMulti: Integer;
   row: Integer;
   i: Integer;
   DispColCount: Integer;
   strScore: string;
   w: Integer;
begin
   TotQSO := 0;
   TotPoints := 0;
   TotMulti := 0;
   row := 1;

   // 見出し行
   Grid.Cells[0,0] := 'MHz';
   Grid.Cells[1,0] := 'QSO';
   Grid.Cells[2,0] := 'Points';
   Grid.Cells[3,0] := 'Multi';

   if ShowCWRatio then begin
      Grid.Cells[4,0] := 'CW Q''s';
      Grid.Cells[5,0] := 'CW %';
      DispColCount := 6;
   end
   else begin
      Grid.Cells[4,0] := '';
      Grid.Cells[5,0] := '';
      DispColCount := 4;
   end;

   // バンド別スコア行
   for i := Low(JA0Band) to High(JA0Band) do begin
      band := JA0Band[i];

      // QRVできないバンドは除外
      if dmZLogGlobal.Settings._activebands[band] = False then begin
         Continue;
      end;

      TotPoints := TotPoints + Points[band];
      TotMulti := TotMulti + Multi[band];
      TotQSO := TotQSO + QSO[band];

      // バンド別スコア
      Grid.Cells[0, row] := '*' + MHzString[band];
      Grid.Cells[1, row] := IntToStr3(QSO[band]);
      Grid.Cells[2, row] := IntToStr3(Points[band]);
      Grid.Cells[3, row] := IntToStr3(Multi[band]);

      // CW率
      if ShowCWRatio then begin
         Grid.Cells[4, row] := IntToStr3(CWQSO[band]);
         if QSO[band] > 0 then begin
            Grid.Cells[5, row] := FloatToStrF(100 * (CWQSO[band] / QSO[band]), ffFixed, 1000, 1);
         end
         else begin
            Grid.Cells[5, row] := '-';
         end;
      end
      else begin
         Grid.Cells[4, row] := '';
         Grid.Cells[5, row] := '';
      end;

      Inc(row);
   end;

   // 合計行
   Grid.Cells[0, row] := 'Total';
   Grid.Cells[1, row] := IntToStr3(TotQSO);
   Grid.Cells[2, row] := IntToStr3(TotPoints);
   Grid.Cells[3, row] := IntToStr3(TotMulti);

   // CW率
   if ShowCWRatio then begin
      Grid.Cells[4, row] := IntToStr3(TotalCWQSOs);
      if TotPoints > 0 then begin
         Grid.Cells[5, row] := FloatToStrF(100 * (TotalCWQSOs / TotalQSOs), ffFixed, 1000, 1);
      end
      else begin
         Grid.Cells[5, row] := '-';
      end;
   end
   else begin
      Grid.Cells[4, row] := '';
      Grid.Cells[5, row] := '';
   end;
   Inc(row);

   // スコア行
   strScore := IntToStr3(TotPoints * TotMulti);
   Grid.Cells[0, row] := 'Score';
   Grid.Cells[1, row] := '';
   Grid.Cells[2, row] := '';
   Grid.Cells[3, row] := strScore;
   Grid.Cells[4, row] := '';
   Grid.Cells[5, row] := '';
   Inc(row);

   // 行数をセット
   Grid.RowCount := row;

   // カラム幅をセット
   w := Grid.Canvas.TextWidth('9');
   Grid.ColWidths[0] := w * 6;
   Grid.ColWidths[1] := w * 7;
   Grid.ColWidths[2] := w * 7;
   Grid.ColWidths[3] := w * Max(8, Length(strScore)+1);
   Grid.ColWidths[4] := w * 7;
   Grid.ColWidths[5] := w * 7;

   // グリッドサイズ調整
   AdjustGridSize(Grid, DispColCount, Grid.RowCount);
end;

function TJA0Score.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TJA0Score.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateData();
end;

end.
