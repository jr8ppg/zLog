unit UZAnalyze;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Classes, System.DateUtils, System.StrUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ClipBrd, Vcl.ComCtrls, UzLogConst, UzLogQSO, UzLogGlobal;

{
タイムチャート
    | 21 22 23 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20|合計
----+------------------------------------------------------------------------+----
 1.9|  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -|   0
 3.5|  -  - 15  9  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -|  24
   7| 29 49  9  -  -  -  -  -  - 36 10  -  - 10 20  - 30 11 12 24 25  2  -  -| 267
  14|  -  -  -  -  -  -  -  -  -  -  -  -  -  7  1  -  -  -  -  -  -  -  -  -|   8
  21|  -  -  -  -  -  -  -  -  -  -  -  -  -  2  -  -  1  -  -  -  -  -  -  -|   3
  50|  1  1  -  -  -  -  -  -  -  -  -  -  -  1  -  -  -  -  -  -  -  -  -  -|   3
 144|  1  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -|   1
 430|  -  -  1  -  -  -  -  -  -  -  -  -  -  -  -  -  -  1  -  -  -  -  -  -|   2
1200|  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -|   0
2400|  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -|   0
5600|  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -|   0
 10G|  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -|   0
----+------------------------------------------------------------------------+----
合計| 31 50 25  9  0  0  0  0  0 36 10  0  0 20 21  0 31 12 12 24 25  2  -  -| 308
累計|      106      115      115      161      202      245      306         |
}

type
  TQsoCount = record
    FQso: Integer;
    FCw: Integer;
    FMulti: Integer;
    FPts: Integer;
  end;

type
  TZAnalyze = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    buttonUpdate: TButton;
    buttonCopy: TButton;
    TabControl1: TTabControl;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buttonUpdateClick(Sender: TObject);
    procedure buttonCopyClick(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private 宣言 }
    FCountData: array[1..25] of array[b19..TBand(17)] of TQsoCount;
    procedure ShowAll(sl: TStrings);
    procedure InitTimeChart();
    procedure TotalTimeChart(Log: TQSOList);
    procedure ShowZAQ(sl: TStrings);
    procedure ShowZAF(sl: TStrings);
  public
    { Public 宣言 }
  end;

implementation

uses
  Main;

{$R *.dfm}

procedure TZAnalyze.FormCreate(Sender: TObject);
begin
   Memo1.Clear();
   InitTimeChart();
end;

procedure TZAnalyze.FormDestroy(Sender: TObject);
begin
   //
end;

procedure TZAnalyze.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.LastFocus.SetFocus;
   end;
end;

procedure TZAnalyze.FormShow(Sender: TObject);
begin
   TotalTimeChart(Log.QsoList);
   ShowAll(Memo1.Lines);
end;

procedure TZAnalyze.TabControl1Change(Sender: TObject);
begin
   ShowAll(Memo1.Lines);
end;

procedure TZAnalyze.buttonUpdateClick(Sender: TObject);
begin
   TotalTimeChart(Log.QsoList);
   ShowAll(Memo1.Lines);
end;

procedure TZAnalyze.buttonCopyClick(Sender: TObject);
begin
   ClipBoard.Open();
   try
      ClipBoard.AsText := Memo1.Text;
   finally
      ClipBoard.Close();
   end;
end;

procedure TZAnalyze.ShowAll(sl: TStrings);
begin
   case TabControl1.TabIndex of
      // ZAF
      0: begin
         ShowZAF(sl);
      end;

      // ZAQ
      1: begin
         ShowZAQ(sl);
      end;
   end;

   Memo1.SelStart := 0;
   Memo1.SelLength := 0;
end;

procedure TZAnalyze.InitTimeChart();
var
   t: Integer;
   b: TBand;
begin
   for t := 1 to 25 do begin
      for b := b19 to TBand(17) do begin
         FCountData[t][b].FQso := 0;
         FCountData[t][b].FCw := 0;
         FCountData[t][b].FMulti := 0;
         FCountData[t][b].FPts := 0;
      end;
   end;
end;

procedure TZAnalyze.TotalTimeChart(Log: TQSOList);
var
   i: Integer;
   qso: TQSO;
   b: TBand;
   m: TMode;
   t: Integer;
   base_dt: TDateTime;
   dt: TDateTime;
   offset_hour: Integer;
begin
   InitTimeChart();

   if Log.Count = 1 then begin
      Exit;
   end;

   base_dt := Log.List[1].Time;

   offset_hour := HourOf(base_dt) - 1;

   for i := 1 to Log.Count - 1 do begin
      qso := Log.List[i];
      b := qso.Band;
      m := qso.Mode;
      dt := qso.Time;

      if DayOf(base_dt) = DayOf(dt) then begin
         t := HourOf(dt) - offset_hour;
      end
      else begin
         t := HourOf(dt) + 24 - offset_hour;
      end;

      if (t < 1) or (t > 24) then begin
         Continue;
      end;

      // QSO
      Inc(FCountData[t][b].FQso);
      Inc(FCountData[25][b].FQso);              // 横計
      Inc(FCountData[t][TBand(16)].FQso);       // 縦計
      Inc(FCountData[25][TBand(16)].FQso);      // 縦横計

      // PTS
      Inc(FCountData[t][b].FPts, qso.Points);
      Inc(FCountData[25][b].FPts, qso.Points);              // 横計
      Inc(FCountData[t][TBand(16)].FPts, qso.Points);       // 縦計
      Inc(FCountData[25][TBand(16)].FPts, qso.Points);      // 縦横計

      // 内CW
      if m = mCW then begin
         Inc(FCountData[t][b].FCw);
         Inc(FCountData[25][b].FCw);            // 横計
         Inc(FCountData[t][TBand(16)].FCw);     // 縦計
         Inc(FCountData[25][TBand(16)].FCw);    // 縦横計
      end;

      // マルチ
//      if Trim(qso.QSO.Multi1) <> '' then begin
      if qso.NewMulti1 = True then begin
         Inc(FCountData[t][b].FMulti);
         Inc(FCountData[25][b].FMulti);         // 横計
         Inc(FCountData[t][TBand(16)].FMulti);  // 縦計
         Inc(FCountData[25][TBand(16)].FMulti); // 縦横計
      end;
   end;

   // 累計
   FCountData[1][TBand(17)].FQso := FCountData[1][TBand(16)].FQso;
   for i := 2 to 24 do begin
      FCountData[i][TBand(17)].FQso := FCountData[i - 1][TBand(17)].FQso + FCountData[i][TBand(16)].FQso;
   end;
end;

procedure TZAnalyze.ShowZAQ(sl: TStrings);
var
   b: TBand;
   t: Integer;
   strText: string;
begin
   sl.Clear();

   sl.Add('＜タイムチャート＞');
   sl.Add('');
   sl.Add('    | 21 22 23 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20|合計');
   sl.Add('----+------------------------------------------------------------------------+----');

   // 明細行
   for b := b19 to HiBand do begin
      if FCountData[25][b].FQso = 0 then begin
         Continue;
      end;

      strText := RightStr('    ' + MHzString[b], 4) + '|';

      for t := 1 to 24 do begin
         if FCountData[t][b].FQso = 0 then begin
            strText := strText + '  -';
         end
         else begin
            strText := strText + RightStr('   ' + IntToStr(FCountData[t][b].FQso), 3);
         end;
      end;

      strText := strText + '|';
      strText := strText + RightStr('    ' + IntToStr(FCountData[25][b].FQso), 4);
      sl.Add(strText);
   end;

   sl.Add('----+------------------------------------------------------------------------+----');

   // 合計行
   strText := '合計|';
   for t := 1 to 24 do begin
      strText := strText + RightStr('   ' + IntToStr(FCountData[t][TBand(16)].FQso), 3);
   end;
   strText := strText + '|';
   strText := strText + RightStr('    ' + IntToStr(FCountData[25][TBand(16)].FQso), 4);
   sl.Add(strText);

   // 累計行
   strText := '累計|';
   for t := 1 to 24 do begin
      if (t mod 3) = 0 then begin
         strText := strText + RightStr('   ' + IntToStr(FCountData[t][TBand(17)].FQso), 3);
      end
      else begin
         strText := strText + '   ';
      end;
   end;
   strText := strText + '|';
//   strText := strText + RightStr('    ' + IntToStr(FCountData[25][TBand(17)].FQso), 4);
   sl.Add(strText);
end;

procedure TZAnalyze.ShowZAF(sl: TStrings);
var
   b: TBand;
   t: Integer;
   strText: string;
   i: Integer;
   cumulative_count: array[b19..TBand(17)] of Integer;
   nLastHour: Integer;
begin
   sl.Clear();

   sl.Add('＜結果＞');
   sl.Add('');

   sl.Add('　バンド　　交信局数　　得点　　マルチ');

   for b := b19 to HiBand do begin
      if FCountData[25][b].FQso = 0 then begin
         Continue;
      end;

      strText := ' ' + RightStr('    ' + MHzString[b], 4) + ' MHz     ' +
                 RightStr('    ' + IntToStr(FCountData[25][b].FQso), 4) + '      ' +
                 RightStr('    ' + IntToStr(FCountData[25][b].FPts), 4) + '    ' +
                 RightStr('    ' + IntToStr(FCountData[25][b].FMulti), 4);
      sl.Add(strText);
   end;

   strText := '  合　計     ' +
              RightStr('     ' + IntToStr(FCountData[25][TBand(16)].FQso), 5) + '     ' +
              RightStr('     ' + IntToStr(FCountData[25][TBand(16)].FPts), 5) + ' × ' +
              RightStr('     ' + IntToStr(FCountData[25][TBand(16)].FMulti), 4) + '  ＝  ' +
              IntToStr(FCountData[25][TBand(16)].FPts * FCountData[25][TBand(16)].FMulti);
   sl.Add(strText);
   sl.Add('');

   nLastHour := 0;
   for i := 24 downto 1 do begin
      if FCountData[i][TBand(16)].FQso > 0 then begin
         nLastHour := i;
         Break;
      end;
   end;

{
＜時間ごとの交信局数＞

      XXXX     XXXX     XXXX     XXXX     XXXX     XXXX     XXXX      XXXX
       3.5        7       14       21       50      144      430       ALL

 [21]    0       29        0        0        1        1        0        31
}
   sl.Add('＜時間ごとの交信局数＞');
   sl.Add('');

   strText := '';
   for b := b19 to HiBand do begin
      if FCountData[25][b].FQso = 0 then begin
         Continue;
      end;

      strText := strText + '     ' + RightStr('    ' + MHzString[b], 4);
   end;

   strText := strText + '       ALL';

   sl.Add('       ' + Trim(strText));
   sl.Add('');

   for i := 1 to nLastHour do begin
      strText := '';

      for b := b19 to HiBand do begin
         if FCountData[25][b].FQso = 0 then begin
            Continue;
         end;

         strText := strText + '     ' + RightStr('    ' + IntToStr(FCountData[i][b].FQso), 4);
      end;

      // ALL
      strText := strText + '      ' + RightStr('    ' + IntToStr(FCountData[i][TBand(16)].FQso), 4);

      // 見出し
      t := 20 + i;
      if t >= 24 then begin
         t := t - 24;
      end;
      strText := ' [' + RightStr('00' + IntToStr(t), 2) + ']' + Copy(strText, 5);

      sl.Add(strText);
   end;

   // 合計
   //Total   24      267        8        3        3        1        2       308
   sl.Add('');
   strText := '';

   for b := b19 to HiBand do begin
      if FCountData[25][b].FQso = 0 then begin
         Continue;
      end;

      strText := strText + '     ' + RightStr('    ' + IntToStr(FCountData[25][b].FQso), 4);
   end;

   // ALL
   strText := strText + '      ' + RightStr('    ' + IntToStr(FCountData[25][TBand(16)].FQso), 4);
   strText := 'Total ' + Copy(strText, 6);

   sl.Add(strText);
   sl.Add('');
   sl.Add('');



   sl.Add('＜時間ごとの累積交信局数＞');
   sl.Add('');

   strText := '';
   for b := b19 to HiBand do begin
      cumulative_count[b] := 0;

      if FCountData[25][b].FQso = 0 then begin
         Continue;
      end;

      strText := strText + '     ' + RightStr('    ' + MHzString[b], 4);
   end;

   cumulative_count[TBand(16)] := 0;
   strText := strText + '       ALL';

   sl.Add('       ' + Trim(strText));
   sl.Add('');

   for i := 1 to nLastHour do begin
      strText := '';

      for b := b19 to HiBand do begin
         if FCountData[25][b].FQso = 0 then begin
            Continue;
         end;

         cumulative_count[b] := cumulative_count[b] + FCountData[i][b].FQso;

         strText := strText + '     ' + RightStr('    ' + IntToStr(cumulative_count[b]), 4);
      end;

      // ALL
      cumulative_count[TBand(16)] := cumulative_count[TBand(16)] + FCountData[i][TBand(16)].FQso;
      strText := strText + '      ' + RightStr('    ' + IntToStr(cumulative_count[TBand(16)]), 4);

      // 見出し
      t := 20 + i;
      if t >= 24 then begin
         t := t - 24;
      end;
      strText := ' [' + RightStr('00' + IntToStr(t), 2) + ']' + Copy(strText, 5);

      sl.Add(strText);
   end;

   sl.Add('');
   sl.Add('');



   sl.Add('＜マルチプライヤーの獲得状況＞');
   sl.Add('');

   strText := '';
   for b := b19 to HiBand do begin
      if FCountData[25][b].FQso = 0 then begin
         Continue;
      end;

      strText := strText + '     ' + RightStr('    ' + MHzString[b], 4);
   end;

   strText := strText + '       ALL';

   sl.Add('       ' + Trim(strText));
   sl.Add('');

   for i := 1 to nLastHour do begin
      strText := '';

      for b := b19 to HiBand do begin
         if FCountData[25][b].FQso = 0 then begin
            Continue;
         end;

         if FCountData[i][b].FMulti = 0 then begin
            strText := strText + '     ' + '   -';
         end
         else begin
            strText := strText + '     ' + RightStr('    ' + IntToStr(FCountData[i][b].FMulti), 4);
         end;
      end;

      // ALL
      if FCountData[i][TBand(16)].FMulti = 0 then begin
         strText := strText + '      ' + '   -';
      end
      else begin
         strText := strText + '      ' + RightStr('    ' + IntToStr(FCountData[i][TBand(16)].FMulti), 4);
      end;

      // 見出し
      t := 20 + i;
      if t >= 24 then begin
         t := t - 24;
      end;
      strText := ' [' + RightStr('00' + IntToStr(t), 2) + ']' + Copy(strText, 5);

      sl.Add(strText);
   end;

   // 合計
   //Total   24      267        8        3        3        1        2       308
   sl.Add('');
   strText := '';

   for b := b19 to HiBand do begin
      if FCountData[25][b].FQso = 0 then begin
         Continue;
      end;

      if FCountData[25][b].FMulti = 0 then begin
         strText := strText + '     ' + '   -';
      end
      else begin
         strText := strText + '     ' + RightStr('    ' + IntToStr(FCountData[25][b].FMulti), 4);
      end;
   end;

   // ALL
   if FCountData[25][TBand(16)].FMulti = 0 then begin
      strText := strText + '      ' + '   -';
   end
   else begin
      strText := strText + '      ' + RightStr('    ' + IntToStr(FCountData[25][TBand(16)].FMulti), 4);
   end;
   strText := 'Total ' + Copy(strText, 6);

   sl.Add(strText);
   sl.Add('');
   sl.Add('');
end;

end.
