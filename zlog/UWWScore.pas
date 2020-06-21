unit UWWScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls, Buttons, Math,
  UBasicScore, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TWWScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
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
    procedure SummaryWriteScore(FileName : string); override;
    property FontSize: Integer read GetFontSize write SetFontSize;
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

procedure TWWScore.FormCreate(Sender: TObject);
begin
   inherited;
   Grid.Canvas.Font.Name := 'ＭＳ ゴシック';
end;

procedure TWWScore.FormShow(Sender: TObject);
begin
   inherited;
   CWButton.Visible := False;
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

      Font.Size := FFontSize;

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

procedure TWWScore.Renew;
var
   i: Integer;
   band: TBand;
begin
   Reset;
   for i := 1 to Log.TotalQSO do begin
      band := Log.QsoList[i].band;
      inc(QSO[band]);
      inc(Points[band],Log.QsoList[i].Points);

      if Log.QsoList[i].NewMulti1 then begin
        inc(Multi[band]);
      end;

      if Log.QsoList[i].NewMulti2 then begin
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

procedure TWWScore.UpdateData;
var
   band : TBand;
   TotQSO, TotPts, TotMulti, TotMulti2: Integer;
   row: Integer;
   i: Integer;
   h: Integer;
   w: Integer;
   strScore: string;
begin
   TotQSO := 0;
   TotPts := 0;
   TotMulti := 0;
   TotMulti2 := 0;
   row := 1;

   // 見出し行
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

   // 合計行
   Grid.Cells[0, 7] := 'Total';
   Grid.Cells[1, 7] := IntToStr3(TotQSO);
   Grid.Cells[2, 7] := IntToStr3(TotPts);
   Grid.Cells[3, 7] := IntToStr3(TotMulti);
   Grid.Cells[4, 7] := IntToStr3(TotMulti2);

   // スコア行
   strScore:= IntToStr3(TotPts * (TotMulti + TotMulti2));
   Grid.Cells[0, 8] := 'Score';
   Grid.Cells[1, 8] := '';
   Grid.Cells[2, 8] := '';
   Grid.Cells[3, 8] := '';
   Grid.Cells[4, 8] := strScore;

   // 行数をセット
   Grid.ColCount := 5;
   Grid.RowCount := 9;

   // カラム幅をセット
   w := Grid.Canvas.TextWidth('9');
   Grid.ColWidths[0] := w * 6;
   Grid.ColWidths[1] := w * 7;
   Grid.ColWidths[2] := w * 7;
   Grid.ColWidths[3] := w * 7;
   Grid.ColWidths[4] := w * Max(8, Length(strScore)+1);

   // 幅調整
   w := 0;
   for i := 0 to Grid.ColCount - 1 do begin
      w := w + Grid.ColWidths[i];
   end;
   w := w + (Grid.ColCount * Grid.GridLineWidth) + 2;
   ClientWidth := Max(w, 200);

   // 高さ調整
   h := 0;
   for i := 0 to Grid.RowCount - 1 do begin
      h := h + Grid.RowHeights[i];
   end;
   h := h + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
   ClientHeight := h;
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

function TWWScore.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TWWScore.SetFontSize(v: Integer);
var
   i: Integer;
   h: Integer;
begin
   Inherited;
   Grid.Font.Size := v;
   Grid.Canvas.Font.size := v;

   h := Abs(Grid.Font.Height) + 6;

   Grid.DefaultRowHeight := h;

   for i := 0 to Grid.RowCount - 1 do begin
      Grid.RowHeights[i] := h;
   end;

   UpdateData();
end;

end.
