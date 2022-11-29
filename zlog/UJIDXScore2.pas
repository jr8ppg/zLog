unit UJIDXScore2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons, Math,
  UzLogConst, UzLogGlobal, UzLogQSO, Vcl.Menus;

type
  TJIDXScore2 = class(TBasicScore)
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
    Multi2 : array[b19..HiBand] of LongInt;
    constructor Create(AOwner: TComponent); override;
    procedure Renew; override;
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure UpdateData; override;
    procedure CalcPoints(var aQSO : TQSO);
    property FontSize: Integer read GetFontSize write SetFontSize;
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

procedure TJIDXScore2.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(TStringGrid(Sender), ACol, ARow, Rect);
end;

procedure TJIDXScore2.Renew;
var
   i: Integer;
   band : TBand;
begin
   Reset;

   for i := 1 to Log.TotalQSO do begin
      band := Log.QsoList[i].band;
      Inc(QSO[band]);
      Inc(Points[band], Log.QsoList[i].Points);

      if Log.QsoList[i].NewMulti1 then begin
         Inc(Multi[band]);
      end;

      if Log.QsoList[i].NewMulti2 then begin
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
   w: Integer;
   strScore: string;
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
      // WARC除外
      if IsWARC(band) = True then begin
         Continue;
      end;

      // QRVできないバンドは除外
      if dmZlogGlobal.Settings._activebands[band] = False then begin
         Continue;
      end;

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

   // 合計行
   Grid.Cells[0, row] := 'Total';
   Grid.Cells[1, row] := IntToStr3(TotQSO);
   Grid.Cells[2, row] := IntToStr3(TotPts);
   Grid.Cells[3, row] := IntToStr3(TotMulti);
   Grid.Cells[4, row] := IntToStr3(TotMulti2);
   Inc(row);

   // スコア行
   strScore := IntToStr(TotPts * (TotMulti + TotMulti2));
   Grid.Cells[0, row] := 'Score';
   Grid.Cells[1, row] := '';
   Grid.Cells[2, row] := '';
   Grid.Cells[3, row] := '';
   Grid.Cells[4, row] := strScore;
   Inc(row);

   Grid.ColCount := 5;
   Grid.RowCount := row;

   // カラム幅をセット
   w := Grid.Canvas.TextWidth('9');
   Grid.ColWidths[0] := w * 6;
   Grid.ColWidths[1] := w * 7;
   Grid.ColWidths[2] := w * 7;
   Grid.ColWidths[3] := w * 7;
   Grid.ColWidths[4] := w * Max(8, Length(strScore)+1);

   // グリッドサイズ調整
   AdjustGridSize(Grid, Grid.ColCount, Grid.RowCount);
end;

function TJIDXScore2.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TJIDXScore2.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateData();
end;

end.
