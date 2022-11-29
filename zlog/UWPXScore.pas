unit UWPXScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons, Math,
  UzLogConst, UzLogGlobal, UzLogQSO, UWPXMulti, Vcl.Menus;

type
  TWPXScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
  protected
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
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
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

implementation

{$R *.DFM}

procedure TWPXScore.FormCreate(Sender: TObject);
begin
   inherited;
   AllAsianDXMode := false;
end;

procedure TWPXScore.FormShow(Sender: TObject);
begin
   inherited;
   CWButton.Visible := False;
end;

procedure TWPXScore.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(TStringGrid(Sender), ACol, ARow, Rect);
end;

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
   w: Integer;
   strScore: string;
begin
   TotQSO := 0;
   TotPts := 0;
   row := 1;

   Grid.Cells[0, 0] := 'MHz';
   Grid.Cells[1, 0] := 'QSOs';
   Grid.Cells[2, 0] := 'Points';

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

      Grid.Cells[0, row] := '*' + MHzString[band];
      Grid.Cells[1, row] := IntToStr3(QSO[band]);
      Grid.Cells[2, row] := IntToStr3(Points[band]);

      Inc(row);
   end;

   // 合計行
   Grid.Cells[0, row] := 'Total';
   Grid.Cells[1, row] := IntToStr3(TotQSO);
   Grid.Cells[2, row] := IntToStr3(TotPts);
   Inc(row);

   // マルチ行
   Grid.Cells[0, row] := 'Prefixes';
   Grid.Cells[1, row] := '';
   Grid.Cells[2, row] := IntToStr3(FMultiForm.TotalPrefix);
   Inc(row);

   // スコア行
   strScore := IntToStr3(TotPts * FMultiForm.TotalPrefix);
   Grid.Cells[0, row] := 'Score';
   Grid.Cells[1, row] := '';
   Grid.Cells[2, row] := strScore;
   Inc(row);

   Grid.ColCount := 3;
   Grid.RowCount := row;

   // カラム幅をセット
   w := Grid.Canvas.TextWidth('9');
   Grid.ColWidths[0] := w * 9;
   Grid.ColWidths[1] := w * 9;
   Grid.ColWidths[2] := w * Max(9, Length(strScore)+1);

   // グリッドサイズ調整
   AdjustGridSize(Grid, Grid.ColCount, Grid.RowCount);
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

function TWPXScore.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TWPXScore.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateData();
end;

end.
