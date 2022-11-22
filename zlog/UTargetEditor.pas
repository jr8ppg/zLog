unit UTargetEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls, System.DateUtils,
  UzLogConst, UzLogQSO, UQsoTarget, Vcl.Menus, Vcl.Clipbrd;

type
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
    popupScore: TPopupMenu;
    menuCopy: TMenuItem;
    menuPaste: TMenuItem;
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
    procedure FormDestroy(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure ScoreGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ScoreGridTopLeftChanged(Sender: TObject);
    procedure menuCopyClick(Sender: TObject);
    procedure popupScorePopup(Sender: TObject);
    procedure menuPasteClick(Sender: TObject);
  private
    { Private �錾 }
    FTarget: TContestTarget;
    procedure ShowWarcBand(fShow: Boolean);
    procedure TargetToGrid(ATarget: TContestTarget);
    procedure GridToTarget(ATarget: TContestTarget);
  public
    { Public �錾 }
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

   FTarget := TContestTarget.Create();

   for i := 1 to 24 do begin
      ScoreGrid.Cells[i, 0] := IntToStr(i);
      ScoreGrid.ColWidths[i] := 35;
   end;
   ScoreGrid.Cells[25, 0] := 'Total';
   ScoreGrid.ColWidths[25] := 64;

   TargetToGrid(dmZLogGlobal.Target);
   GridToTarget(FTarget);
   FTarget.Refresh();
   TargetToGrid(FTarget);
end;

procedure TTargetEditor.FormDestroy(Sender: TObject);
begin
   FTarget.Free();
end;

procedure TTargetEditor.FormShow(Sender: TObject);
begin
   ShowWarcBand(checkShowWarc.Checked);
end;

procedure TTargetEditor.buttonAdjustClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   FTarget.Adjust(n);

   TargetToGrid(FTarget);
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
   OpenDialog1.InitialDir := dmZLogGlobal.LogPath;
   if OpenDialog1.Execute(Self.Handle) = False then begin
      Exit;
   end;

   FTarget.Clear();

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

         // ���_0�͏���
         if aQSO.Points = 0 then begin
            Continue;
         end;

         diff := aQSO.Time - origin;
         DecodeTime(diff, H, M, S, ms);
         d := Trunc(DaySpan(aQSO.Time, origin));
         h := h + (d * 24);

         if h > 24 then begin
            Continue;
         end;

         FTarget.Bands[aQSO.Band].Hours[h + 1].IncTarget();
      end;

      FTarget.Refresh();

      TargetToGrid(FTarget);
   finally
      log.Free();
   end;
end;

procedure TTargetEditor.buttonOKClick(Sender: TObject);
begin
   GridToTarget(dmZLogGlobal.Target);
   dmZLogGlobal.Target.SaveToFile();
   ModalResult := mrOK;
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
      ScoreGrid.RowHeights[4] := -1;
      ScoreGrid.RowHeights[6] := -1;
      ScoreGrid.RowHeights[8] := -1;
   end;
end;

procedure TTargetEditor.TargetToGrid(ATarget: TContestTarget);
var
   b: TBand;
   i: Integer;
begin
   for b := b19 to b10g do begin
      for i := 1 to 24 do begin
         ScoreGrid.Cells[i, Ord(b)+1] := IntToStr(ATarget.Bands[b].Hours[i].Target);
         ScoreGrid.Cells[i, 17]       := IntToStr(ATarget.Total.Hours[i].Target);
      end;
      ScoreGrid.Cells[25, Ord(b)+1]   := IntToStr(ATarget.Bands[b].Total.Target);
   end;

   ScoreGrid.Refresh();
end;

procedure TTargetEditor.GridToTarget(ATarget: TContestTarget);
var
   b: TBand;
   i: Integer;
begin
   for b := b19 to b10g do begin
      for i := 1 to 24 do begin
         ATarget.Bands[b].Hours[i].Target := StrToIntDef(ScoreGrid.Cells[i, Ord(b)+1], 0);
      end;
   end;
end;

procedure TTargetEditor.popupScorePopup(Sender: TObject);
begin
   if ClipBoard.HasFormat(CF_TEXT) = True then begin
      menuPaste.Enabled := True;
   end
   else begin
      menuPaste.Enabled := False;
   end;
end;

procedure TTargetEditor.menuCopyClick(Sender: TObject);
var
   b: TBand;
   i: Integer;
   slText: TStringList;
   slLine: TStringList;
begin
   slText := TStringList.Create();
   slLine := TStringList.Create();
   slLine.StrictDelimiter := True;
   slLine.Delimiter := #09;
   try
      slLine.Add('');
      for i := 1 to 24 do begin
         slLine.Add(IntToStr(i));
      end;
      slText.Add(slLine.DelimitedText);

      for b := b19 to b10g do begin

         slLine.Clear();
         slLine.Add(BandString[b]);

         for i := 1 to 24 do begin
            slLine.Add(ScoreGrid.Cells[i, Ord(b)+1]);
         end;

         slText.Add(slLine.DelimitedText);
      end;

      ClipBoard.AsText := slText.Text;
   finally
      slText.Free();
      slLine.Free();
   end;
end;

procedure TTargetEditor.menuPasteClick(Sender: TObject);
var
   b: TBand;
   i: Integer;
   j: Integer;
   slText: TStringList;
   slLine: TStringList;
   strBand: string;
   txt: string;

   function FindBand(strBand: string): TBand;
   var
      b: TBand;
   begin
      for b := Low(BandString) to High(BandString) do begin
         if BandString[b] = strBand then begin
            Result := b;
            Exit;
         end;
      end;

      Result := TBand(-1);
   end;
begin
   slText := TStringList.Create();
   slLine := TStringList.Create();
   slLine.StrictDelimiter := True;
   slLine.Delimiter := #09;
   try
      slText.Text := ClipBoard.AsText;

      for i := 1 to slText.Count - 1 do begin
         // �P�s��肾��
         slLine.DelimitedText := slText[i];

         // �Q�T���ږ����̓p�X
         if slLine.Count < 25 then begin
            Continue;
         end;

         // �P��ڂ̓o���h
         strBand := slLine[0];

         b := FindBand(strBand);
         if b = TBand(-1) then begin
            Continue;
         end;

         // �Q��ڈȍ~�͖ڕW�l
         for j := 1 to 24 do begin
            txt := slLine[j];

            // ���͂��ꂽ�l���i�[
            FTarget.Bands[b].Hours[j].Target := StrToIntDef(txt, 0);
         end;
      end;

      // ���v�Čv�Z
      FTarget.Refresh();

      // ��ʂɕ\��
      TargetToGrid(FTarget);
   finally
      slText.Free();
      slLine.Free();
   end;
end;

procedure TTargetEditor.ScoreGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   strText: string;
   t: Integer;
begin
   with ScoreGrid.Canvas do begin
      Font.Size := ScoreGrid.Font.Size;
      Font.Name := ScoreGrid.Font.Name;

      Pen.Style := psSolid;
      Pen.Color := ScoreGrid.Color;
      Brush.Style := bsSolid;
      Brush.Color := ScoreGrid.Color;
      FillRect(Rect);

      if ACol = 0 then begin           // �o���h��
         strText := ScoreGrid.Cells[ACol, ARow];
         TextRect(Rect, strText, [tfLeft, tfVerticalCenter, tfSingleLine]);

         Pen.Color := RGB(220, 220, 220);
         Brush.Style := bsClear;
         Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);
      end
      else if ARow = 0 then begin      // ���o���s
         strText := ScoreGrid.Cells[ACol, ARow];
         TextRect(Rect, strText, [tfCenter, tfVerticalCenter, tfSingleLine]);

         Pen.Color := RGB(220, 220, 220);
         Brush.Style := bsClear;
         Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);
      end
      else if ACol = 25 then begin     // �����v��
         strText := ScoreGrid.Cells[ACol, ARow];
         TextRect(Rect, strText, [tfRight, tfVerticalCenter, tfSingleLine]);

         Pen.Color := RGB(220, 220, 220);
         Brush.Style := bsClear;
         Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);
      end
      else begin                       // �ڕW�l
         t := FTarget.Bands[TBand(ARow - 1)].Hours[ACol].Target;

         if checkShowZero.Checked = True then begin
            strText := IntToStr(t);
         end
         else begin
            if t = 0 then begin
               strText := '';
            end
            else begin
               strText := IntToStr(t);
            end;
         end;
         TextRect(Rect, strText, [tfRight, tfVerticalCenter, tfSingleLine]);

         Pen.Color := RGB(220, 220, 220);
         Brush.Style := bsClear;

         Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);

         if gdSelected in State then begin
            Pen.Color := RGB(80, 80, 80);
            Pen.Style := psDot;
            Brush.Style := bsClear;
            Rectangle(Rect);
         end;
      end;
   end;
end;

procedure TTargetEditor.ScoreGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
//
end;

procedure TTargetEditor.ScoreGridSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
var
   b: TBand;
   h: Integer;
begin
   if ARow > 16 then begin
      Exit;
   end;
   if ACol > 24 then begin
      Exit;
   end;

   b := TBand(Ord(ARow) - 1);
   h := ACol;

   // ���͂��ꂽ�l���i�[
   FTarget.Bands[b].Hours[h].Target := StrToIntDef(Value, 0);

   // ���v�Čv�Z
   FTarget.Refresh();

   // ���v�s�ɕ\���i�c�v�j
   ScoreGrid.Cells[ACol, 17] := IntToStr(FTarget.Total.Hours[h].Target);

   // �ĕ`��
   ScoreGrid.Refresh();
end;

procedure TTargetEditor.ScoreGridTopLeftChanged(Sender: TObject);
begin
   ScoreGrid.Refresh();
end;

end.
