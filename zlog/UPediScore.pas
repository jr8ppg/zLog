unit UPediScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons,
  UzLogCOnst, UzLogGlobal, UzLogQSO;

type
  TPediScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    Stats: array[b19..HiBand, mCW..mOther] of integer;
  public
    { Public declarations }
    procedure UpdateData; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    procedure Reset; override;
    procedure SummaryWriteScore(FileName : string); override;
  end;

//var
//  PediScore: TPediScore;

implementation

{$R *.DFM}

procedure TPediScore.SummaryWriteScore(FileName: string);
var
   f: textfile;
   b: TBand;
   M: TMode;
   TotQSO, TotBandQSO: LongInt;
   ModeQSO: array [mCW .. mOther] of Integer;
begin
   AssignFile(f, FileName);
   Append(f);

   write(f, 'MHz     ');
   for M := mCW to mOther do begin
      write(f, FillLeft(ModeString[M], 6));
   end;

   write(f, '   QSO');
   writeln(f);

   TotQSO := 0;
   for M := mCW to mOther do begin
      ModeQSO[M] := 0;
   end;

   for b := b19 to HiBand do begin
      TotBandQSO := 0;
      write(f, FillRight(MHzString[b], 8));

      for M := mCW to mOther do begin
         write(f, FillLeft(IntToStr(Stats[b, M]), 6));
         Inc(TotBandQSO, Stats[b, M]);
         Inc(ModeQSO[M], Stats[b, M]);
      end;
      Inc(TotQSO, TotBandQSO);

      write(f, FillLeft(IntToStr(TotBandQSO), 6));
      writeln(f);
   end;

   write(f, FillRight('Total', 8));

   for M := mCW to mOther do begin
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
   ModeQSO: array [mCW .. mOther] of Integer;
begin
   TotQSO := 0;

   Grid.Cells[0, 0] := 'MHz';
   Grid.Cells[1, 0] := 'Total';
   Grid.Cells[2, 0] := 'CW';
   Grid.Cells[3, 0] := 'SSB';
   Grid.Cells[4, 0] := 'FM';
   Grid.Cells[5, 0] := 'AM';
   Grid.Cells[6, 0] := 'RTTY';
   Grid.Cells[7, 0] := 'Other';

   for M := mCW to mOther do begin
      ModeQSO[M] := 0;
   end;

   for b := b19 to HiBand do begin
      TotBandQSO := 0;

      Grid.Cells[0, ord(b) + 1] := '*' + MHzString[b];
      for M := mCW to mOther do begin
         Grid.Cells[ord(M) + 2, ord(b) + 1] := IntToStr3(Stats[b, M]);

         Inc(TotBandQSO, Stats[b, M]);
         Inc(ModeQSO[M], Stats[b, M]);
      end;

      Inc(TotQSO, TotBandQSO);

      Grid.Cells[1, ord(b) + 1] := IntToStr3(TotBandQSO);
   end;

   Grid.Cells[0, ord(HiBand) + 2] := 'Total';
   Grid.Cells[1, ord(HiBand) + 2] := IntToStr3(TotQSO);

   for M := mCW to mOther do begin
      Grid.Cells[ord(M) + 2, ord(HiBand) + 2] := IntToStr3(ModeQSO[M]);
   end;

   Grid.ColCount := 8;
   Grid.RowCount := 17;
   ClientWidth := (Grid.DefaultColWidth * Grid.ColCount) + (Grid.ColCount * Grid.GridLineWidth);
   ClientHeight := (Grid.DefaultRowHeight * Grid.RowCount) + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
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
      for M := mCW to mOther do begin
         Stats[b, M] := 0;
      end;
   end;
end;

procedure TPediScore.FormShow(Sender: TObject);
begin
   inherited;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.Row := 1;
   CWButton.Visible := False;
end;

procedure TPediScore.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   strText: string;
begin
   inherited;
   strText := TStringGrid(Sender).Cells[ACol, ARow];

   with TStringGrid(Sender).Canvas do begin
      Brush.Color := TStringGrid(Sender).Color;
      Brush.Style := bsSolid;
      FillRect(Rect);

      Font.Name := 'ÇlÇr ÉSÉVÉbÉN';
      Font.Size := 11;

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

end.
