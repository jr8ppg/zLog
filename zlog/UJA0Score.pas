unit UJA0Score;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons, Math,
  UzLogConst, UzLogGlobal, UzLogQSO, Vcl.Menus;

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
    JA0Band : TBand;
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure UpdateData; override;
    function IsJA0(aQSO : TQSO) : boolean;
    procedure SetBand(B : TBand);
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
begin
   // 見出し行
   Grid.Cells[0,0] := 'MHz';
   Grid.Cells[1,0] := 'QSO';
   Grid.Cells[2,0] := 'Points';
   Grid.Cells[3,0] := 'Multi';

   if (JA0Band = b21) or (JA0Band = b28) then begin
      Grid.Cells[1, 1] := IntToStr3(QSO[b21]);
      Grid.Cells[2, 1] := IntToStr3(Points[b21]);
      Grid.Cells[3, 1] := IntToStr3(Multi[b21]);
      Grid.Cells[1, 2] := IntToStr3(QSO[b28]);
      Grid.Cells[2, 2] := IntToStr3(Points[b28]);
      Grid.Cells[3, 2] := IntToStr3(Multi[b28]);
      Grid.Cells[3, 3] := IntToStr3((Points[b21] + Points[b28]) * (Multi[b21] + Multi[b28]));
   end
   else begin
      Grid.Cells[1, 1] := IntToStr3(QSO[JA0Band]);
      Grid.Cells[2, 1] := IntToStr3(Points[JA0Band]);
      Grid.Cells[3, 1] := IntToStr3(Multi[JA0Band]);
      Grid.Cells[1, 2] := '';
      Grid.Cells[2, 2] := '';
      Grid.Cells[3, 2] := IntToStr3(Points[JA0Band] * Multi[JA0Band]);
      Grid.Cells[3, 3] := '';
   end;
end;

procedure TJA0Score.SetBand(B : TBand);
var
   w: Integer;
begin
   JA0Band := B;
   if (B = b21) or (B = b28) then begin
      Grid.RowCount := 4;
      Grid.Cells[0, 1] := MHzString[b21];
      Grid.Cells[0, 2] := MHzString[b28];
      Grid.Cells[0, 3] := 'Score';
   end
   else begin
      Grid.RowCount := 3;
      Grid.Cells[0, 1] := MHzString[JA0Band];
      Grid.Cells[0, 2] := 'Score';
      Grid.Cells[0, 3] := '';
   end;

   // カラム幅をセット
   w := Grid.Canvas.TextWidth('9');
   Grid.ColWidths[0] := w * 8;
   Grid.ColWidths[1] := w * 8;
   Grid.ColWidths[2] := w * 9;
   Grid.ColWidths[3] := w * Max(8, Length(Grid.Cells[3, 2])+1);

   // グリッドサイズ調整
   AdjustGridSize(Grid, Grid.ColCount, Grid.RowCount);
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
