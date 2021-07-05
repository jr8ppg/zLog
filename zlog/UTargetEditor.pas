unit UTargetEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls, System.DateUtils,
  UzLogConst, UzLogQSO;

type
  TQsoByHour = array[1..25] of Integer;

  TTargetEditor = class(TForm)
    ScoreGrid: TStringGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    buttonLoadZLO: TButton;
    OpenDialog1: TOpenDialog;
    buttonAdjust5: TButton;
    buttonAdjust10: TButton;
    checkShowWarc: TCheckBox;
    checkShowZero: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ScoreGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure buttonLoadZLOClick(Sender: TObject);
    procedure buttonAdjustClick(Sender: TObject);
    procedure checkShowWarcClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ScoreGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure checkShowZeroClick(Sender: TObject);
  private
    { Private êÈåæ }
    FQsoByBand: array[b19..bTarget] of TQsoByHour;
    procedure ShowWarcBand(fShow: Boolean);
    procedure GridBandClear(b: TBand);
  public
    { Public êÈåæ }
    procedure ClearTarget();
    procedure TargetToGrid();
    procedure GridToTarget();
    procedure TotalCountHour(h: Integer);
    procedure TotalCountBand(b: TBand);
    procedure TotalCountAll();
  end;

implementation

uses
  UzLogGlobal;

{$R *.dfm}

procedure TTargetEditor.FormCreate(Sender: TObject);
var
   i: Integer;
begin
   ScoreGrid.Cells[0, 1] := MHzString[b19];
   ScoreGrid.Cells[0, 2] := MHzString[b35];
   ScoreGrid.Cells[0, 3] := MHzString[b7];
   ScoreGrid.Cells[0, 4] := MHzString[b10];
   ScoreGrid.Cells[0, 5] := MHzString[b14];
   ScoreGrid.Cells[0, 6] := MHzString[b18];
   ScoreGrid.Cells[0, 7] := MHzString[b21];
   ScoreGrid.Cells[0, 8] := MHzString[b24];
   ScoreGrid.Cells[0, 9] := MHzString[b28];
   ScoreGrid.Cells[0, 10] := MHzString[b50];
   ScoreGrid.Cells[0, 11] := MHzString[b144];
   ScoreGrid.Cells[0, 12] := MHzString[b430];
   ScoreGrid.Cells[0, 13] := MHzString[b1200];
   ScoreGrid.Cells[0, 14] := MHzString[b2400];
   ScoreGrid.Cells[0, 15] := MHzString[b5600];
   ScoreGrid.Cells[0, 16] := MHzString[b10g];
   ScoreGrid.Cells[0, 17] := 'Total';

   for i := 1 to 24 do begin
      ScoreGrid.Cells[i, 0] := IntToStr(i);
      ScoreGrid.ColWidths[i] := 35;
   end;
   ScoreGrid.Cells[25, 0] := 'Total';
   ScoreGrid.ColWidths[25] := 64;

   ClearTarget();

   TargetToGrid();
end;

procedure TTargetEditor.FormShow(Sender: TObject);
begin
   ShowWarcBand(checkShowWarc.Checked);
end;

procedure TTargetEditor.buttonAdjustClick(Sender: TObject);
var
   b: TBand;
   i: Integer;
   n: Integer;
begin
   n := TButton(Sender).Tag;

   for b := b19 to b10g do begin
      for i := 1 to 24 do begin
         if FQsoByBand[b][i] = 0 then begin
            Continue;
         end;
         if FQsoByBand[b][i] <= n then begin
            Continue;
         end;

         FQsoByBand[b][i] := ((FQsoByBand[b][i] div n) + 1) * n;
      end;
   end;

   TotalCountAll();

   TargetToGrid();
end;

procedure TTargetEditor.buttonLoadZLOClick(Sender: TObject);
var
   log: TLog;
   origin: TDateTime;
   i: Integer;
   h, m, s, ms, d: Word;
   aQSO: TQSO;
   diff: TDateTime;
begin
   OpenDialog1.InitialDir := dmZLogGlobal.Settings._logspath;
   if OpenDialog1.Execute(Self.Handle) = False then begin
      Exit;
   end;

   log := TLog.Create('');
   try
      log.LoadFromFile(OpenDialog1.FileName);

      if log.TotalQSO = 0 then begin
         Exit;
      end;

      origin := Log.QsoList[1].Time;
      DecodeTime(origin, h, m, s, ms);
      origin := Int(origin) + EncodeTime(h, 0, 0, 0);

      for i := 1 to log.TotalQSO do begin
         aQSO := log.QsoList[i];
         diff := aQSO.Time - origin;
         DecodeTime(diff, H, M, S, ms);
         d := Trunc(DaySpan(aQSO.Time, origin));
         h := h + (d * 24);

         Inc(FQsoByBand[aQSO.Band][h]);
      end;

      TotalCountAll();

      TargetToGrid();
   finally
      log.Free();
   end;
end;

procedure TTargetEditor.checkShowWarcClick(Sender: TObject);
begin
   ShowWarcBand(checkShowWarc.Checked);
end;

procedure TTargetEditor.checkShowZeroClick(Sender: TObject);
begin
   ScoreGrid.Refresh();
end;

procedure TTargetEditor.ShowWarcBand(fShow: Boolean);
begin
   if fShow = True then begin
      ScoreGrid.RowHeights[4] := ScoreGrid.DefaultRowHeight;
      ScoreGrid.RowHeights[6] := ScoreGrid.DefaultRowHeight;
      ScoreGrid.RowHeights[8] := ScoreGrid.DefaultRowHeight;
   end
   else begin
      ScoreGrid.RowHeights[4] := 0;
      ScoreGrid.RowHeights[6] := 0;
      ScoreGrid.RowHeights[8] := 0;
   end;
end;

procedure TTargetEditor.GridBandClear(b: TBand);
var
   i: Integer;
begin
   for i := 0 to 24 do begin
      FQsoByBand[b][i] := 0;
      ScoreGrid.Cells[i, Ord(b)+1] := '';
   end;
end;

procedure TTargetEditor.ClearTarget();
var
   b: TBand;
   i: Integer;
begin
   for b := b19 to b10g do begin
      for i := 1 to 24 do begin
         FQsoByBand[b][i] := 0;
      end;
   end;
end;

procedure TTargetEditor.TargetToGrid();
var
   b: TBand;
   i: Integer;
begin
   for b := b19 to bTarget do begin
      for i := 1 to 25 do begin
         ScoreGrid.Cells[i, Ord(b)+1] := IntToStr(FQsoByBand[b][i]);
      end;
   end;
end;

procedure TTargetEditor.GridToTarget();
var
   b: TBand;
   i: Integer;
begin
   for b := b19 to bTarget do begin
      for i := 1 to 25 do begin
         FQsoByBand[b][i] := StrToIntDef(ScoreGrid.Cells[i, Ord(b)+1], 0);
      end;
   end;
end;

procedure TTargetEditor.ScoreGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   strText: string;
begin
   with ScoreGrid.Canvas do begin
      Font.Size := ScoreGrid.Font.Size;
      Font.Name := ScoreGrid.Font.Name;

      Pen.Style := psSolid;
      Pen.Color := ScoreGrid.Color;
      Brush.Style := bsSolid;
      Brush.Color := ScoreGrid.Color;
      FillRect(Rect);

      if ACol = 0 then begin
         strText := ScoreGrid.Cells[ACol, ARow];
         TextRect(Rect, strText, [tfLeft, tfVerticalCenter, tfSingleLine]);
      end
      else if ARow = 0 then begin
         strText := ScoreGrid.Cells[ACol, ARow];
         TextRect(Rect, strText, [tfCenter, tfVerticalCenter, tfSingleLine]);
      end
      else begin
         if checkShowZero.Checked = True then begin
            strText := IntToStr(FQsoByBand[TBand(ARow - 1)][ACol]);
         end
         else begin
            if FQsoByBand[TBand(ARow - 1)][ACol] = 0 then begin
               strText := '';
            end
            else begin
               strText := IntToStr(FQsoByBand[TBand(ARow - 1)][ACol]);
            end;
         end;
         TextRect(Rect, strText, [tfRight, tfVerticalCenter, tfSingleLine]);
      end;
   end;
end;

procedure TTargetEditor.ScoreGridSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
var
   b: TBand;
   h: Integer;
begin
   b := TBand(Ord(ARow) - 1);
   h := ACol;
   FQsoByBand[b][h] := StrToIntDef(Value, 0);

   TotalCountHour(h);
   TotalCountBand(b);

   ScoreGrid.Cells[ACol, 17] := IntToStr(FQsoByBand[bTarget][h]);

   ScoreGrid.Refresh();
end;

procedure TTargetEditor.TotalCountHour(h: Integer);
var
   b: TBand;
   nTotal: Integer;
begin
   nTotal := 0;
   for b := b19 to b10g do begin
      nToTal := nTotal + FQsoByBand[b][h];
   end;

   FQsoByBand[bTarget][h] := nTotal;
end;

procedure TTargetEditor.TotalCountBand(b: TBand);
var
   h: Integer;
   nTotal: Integer;
begin
   nTotal := 0;
   for h := 1 to 24 do begin
      nToTal := nTotal + FQsoByBand[b][h];
   end;

   FQsoByBand[b][25] := nTotal;
end;

procedure TTargetEditor.TotalCountAll();
var
   b: TBand;
   i: Integer;
begin
   for b := b19 to b10g do begin
      TotalCountBand(b);
   end;
   for i := 1 to 24 do begin
      TotalCountHour(i);
   end;

   TotalCountBand(bTarget);
   TotalCountHour(25);
end;

end.
