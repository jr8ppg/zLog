unit UPediScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons,
  UzLogCOnst, UzLogGlobal, UzLogQSO, Vcl.Menus;

type
  TPediScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  protected
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
  private
    { Private declarations }
    Stats: array[b19..HiBand, mCW..LastMode] of integer;
  public
    { Public declarations }
    procedure UpdateData; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    procedure Reset; override;
    procedure SummaryWriteScore(FileName : string); override;
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

implementation

{$R *.DFM}

procedure TPediScore.FormShow(Sender: TObject);
begin
   inherited;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.Row := 1;
   CWButton.Visible := False;
end;

procedure TPediScore.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(TStringGrid(Sender), ACol, ARow, Rect);
end;

procedure TPediScore.SummaryWriteScore(FileName: string);
var
   f: textfile;
   b: TBand;
   M: TMode;
   TotQSO, TotBandQSO: LongInt;
   ModeQSO: array [mCW .. LastMode] of Integer;
begin
   AssignFile(f, FileName);
   Append(f);

   write(f, 'MHz     ');
   for M := mCW to LastMode do begin
      write(f, FillLeft(ModeString[M], 6));
   end;

   write(f, '   QSO');
   writeln(f);

   TotQSO := 0;
   for M := mCW to LastMode do begin
      ModeQSO[M] := 0;
   end;

   for b := b19 to HiBand do begin
      TotBandQSO := 0;
      write(f, FillRight(MHzString[b], 8));

      for M := mCW to LastMode do begin
         write(f, FillLeft(IntToStr(Stats[b, M]), 6));
         Inc(TotBandQSO, Stats[b, M]);
         Inc(ModeQSO[M], Stats[b, M]);
      end;
      Inc(TotQSO, TotBandQSO);

      write(f, FillLeft(IntToStr(TotBandQSO), 6));
      writeln(f);
   end;

   write(f, FillRight('Total', 8));

   for M := mCW to LastMode do begin
      write(f, FillLeft(IntToStr(ModeQSO[M]), 6));
   end;
   writeln(f, FillLeft(IntToStr(TotQSO), 6));

   CloseFile(f);
end;

procedure TPediScore.UpdateData;
var
   b: TBand;
   M: TMode;
   TotQSO, TotBandQSO: LongInt;
   ModeQSO: array [mCW .. LastMode] of Integer;
   w: Integer;
begin
   TotQSO := 0;

   Grid.Cells[0, 0] := 'MHz';
   Grid.Cells[1, 0] := 'Total';
   Grid.Cells[2, 0] := 'CW';
   Grid.Cells[3, 0] := 'SSB';
   Grid.Cells[4, 0] := 'FM';
   Grid.Cells[5, 0] := 'AM';
   Grid.Cells[6, 0] := 'RTTY';
   Grid.Cells[7, 0] := 'FT4';
   Grid.Cells[8, 0] := 'FT8';
   Grid.Cells[9, 0] := 'Other';
   Grid.Cells[10, 0] := 'DV';

   for M := mCW to LastMode do begin
      ModeQSO[M] := 0;
   end;

   for b := b19 to HiBand do begin
      TotBandQSO := 0;

      Grid.Cells[0, ord(b) + 1] := '*' + MHzString[b];
      for M := mCW to LastMode do begin
         Grid.Cells[ord(M) + 2, ord(b) + 1] := IntToStr3(Stats[b, M]);

         Inc(TotBandQSO, Stats[b, M]);
         Inc(ModeQSO[M], Stats[b, M]);
      end;

      Inc(TotQSO, TotBandQSO);

      Grid.Cells[1, ord(b) + 1] := IntToStr3(TotBandQSO);
   end;

   Grid.Cells[0, ord(HiBand) + 2] := 'Total';
   Grid.Cells[1, ord(HiBand) + 2] := IntToStr3(TotQSO);

   for M := mCW to LastMode do begin
      Grid.Cells[ord(M) + 2, ord(HiBand) + 2] := IntToStr3(ModeQSO[M]);
   end;

   Grid.ColCount := 11;
   Grid.RowCount := 18;

   // カラム幅をセット
   w := Grid.Canvas.TextWidth('9');
   Grid.ColWidths[0] := w * 6;
   Grid.ColWidths[1] := w * 7;
   Grid.ColWidths[2] := w * 7;
   Grid.ColWidths[3] := w * 7;
   Grid.ColWidths[4] := w * 7;
   Grid.ColWidths[5] := w * 7;
   Grid.ColWidths[6] := w * 7;
   Grid.ColWidths[7] := w * 7;
   Grid.ColWidths[8] := w * 7;
   Grid.ColWidths[9] := w * 7;
   Grid.ColWidths[10] := w * 7;

   // グリッドサイズ調整
   AdjustGridSize(Grid, Grid.ColCount, Grid.RowCount);
end;

procedure TPediScore.AddNoUpdate(var aQSO: TQSO);
begin
   aQSO.points := 1;
   Inc(Stats[aQSO.band, aQSO.Mode]);
end;

procedure TPediScore.Reset;
var
   b: TBand;
   M: TMode;
begin
   for b := b19 to HiBand do begin
      for M := mCW to LastMode do begin
         Stats[b, M] := 0;
      end;
   end;
end;

function TPediScore.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TPediScore.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateData();
end;

end.
