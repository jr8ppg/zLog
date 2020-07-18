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

  TQsoCount2 = record
    FQso: array[1..12] of Integer;
    FUnknown: Integer;
  end;

type
  TZAnalyze = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    buttonUpdate: TButton;
    buttonCopy: TButton;
    TabControl1: TTabControl;
    checkExcludeZeroPoint: TCheckBox;
    checkExcludeZeroHour: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buttonUpdateClick(Sender: TObject);
    procedure buttonCopyClick(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private 宣言 }
    FCountData: array[1..25] of array[b19..TBand(17)] of TQsoCount;
    FCountData2: array[1..25] of array[b19..TBand(17)] of TQsoCount2;
    procedure ShowAll(sl: TStrings);
    procedure InitTimeChart();
    procedure TotalTimeChart(Log: TQSOList);
    function GetAreaNumber(strCallsign: string): Integer;
    function GetLastHour(): Integer;
    procedure ShowZAQ(sl: TStrings);
    procedure ShowZAF(sl: TStrings);
    procedure ShowZAA(sl: TStrings);
    procedure ShowZAA2(sl: TStrings; b: TBand);
    procedure ShowZAA_band(sl: TStrings; b: TBand; nLastHour: Integer);
  public
    { Public 宣言 }
  end;

implementation

uses
  Main;

{$R *.dfm}

procedure TZAnalyze.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

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
   Memo1.SelStart := 0;
   Memo1.SelLength := 0;
end;

procedure TZAnalyze.TabControl1Change(Sender: TObject);
begin
   ShowAll(Memo1.Lines);
   Memo1.SelStart := 0;
   Memo1.SelLength := 0;
end;

procedure TZAnalyze.buttonUpdateClick(Sender: TObject);
begin
   TotalTimeChart(Log.QsoList);
   ShowAll(Memo1.Lines);
   Memo1.SelStart := 0;
   Memo1.SelLength := 0;
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

      // ZAA
      2: begin
         ShowZAA2(sl, Main.CurrentQSO.Band);
      end;

      // ZAA(ALL)
      3: begin
         ShowZAA(sl);
      end;
   end;
end;

procedure TZAnalyze.InitTimeChart();
var
   t: Integer;
   b: TBand;
   a: Integer;
begin
   for t := 1 to 25 do begin
      for b := b19 to TBand(17) do begin
         FCountData[t][b].FQso := 0;
         FCountData[t][b].FCw := 0;
         FCountData[t][b].FMulti := 0;
         FCountData[t][b].FPts := 0;
      end;
   end;

   for t := 1 to 25 do begin
      for b := b19 to TBand(17) do begin
         for a := 1 to 12 do begin
            FCountData2[t][b].FQso[a] := 0;
            FCountData2[t][b].FUnknown := 0;
         end;
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
   a: Integer;
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

      if checkExcludeZeroPoint.Checked = True then begin
         if qso.Points = 0 then begin
            Continue;
         end;
      end;

      if DayOf(base_dt) = DayOf(dt) then begin
         t := HourOf(dt) - offset_hour;
      end
      else begin
         t := HourOf(dt) + 24 - offset_hour;
      end;

      if (t < 1) or (t > 24) then begin
         Continue;
      end;

      // エリア判定
      a := GetAreaNumber(qso.Callsign);

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

      // エリア別
      if a = -1 then begin
         Inc(FCountData2[t][b].FUnknown);
      end
      else begin
         Inc(FCountData2[t][b].FQso[a]);
         Inc(FCountData2[t][b].FQso[11]);          // 横計
         Inc(FCountData2[25][b].FQso[a]);          // 縦計
         Inc(FCountData2[25][b].FQso[11]);         // 縦横計
      end;
   end;

   // 累計
   FCountData[1][TBand(17)].FQso := FCountData[1][TBand(16)].FQso;
   for i := 2 to 24 do begin
      FCountData[i][TBand(17)].FQso := FCountData[i - 1][TBand(17)].FQso + FCountData[i][TBand(16)].FQso;
   end;
end;

function TZAnalyze.GetAreaNumber(strCallsign: string): Integer;
var
   a: Integer;
   p: Integer;
   s: string;
begin
   p := Pos('/', strCallsign);
   if p > 0 then begin
      s := Copy(strCallsign, p + 1);
      if CharInSet(s[1], ['0'..'9']) = True then begin
         Result := StrToIntdef(s[1], -1);
         Exit;
      end;
   end;

   a := StrToIntDef(strCallsign[3], -1);
   if a = 0 then begin
      a := 10;
   end;

   // prefixで判定
   if strCallsign[1] = 'J' then begin
      Result := a;
      Exit;
   end;

   s := Copy(strCallsign, 1, 2);
   if ((s = '7K') or (s = '7L') or (s = '7M') or (s = '7N')) and
       ((a >= 1) and (a <= 4)) then begin
      a := 1;
   end;

   Result := a;
end;

function TZAnalyze.GetLastHour(): Integer;
var
   i: Integer;
begin
   for i := 24 downto 1 do begin
      if FCountData[i][TBand(16)].FQso > 0 then begin
         Result := i;
         Exit;
      end;
   end;

   Result := 1;
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

   nLastHour := GetLastHour();

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
      // ０局の時間帯は除く
      if checkExcludeZeroHour.Checked = True then begin
         if FCountData[i][TBand(16)].FQso = 0 then begin
            Continue;
         end;
      end;

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
      // ０局の時間帯は除く
      if checkExcludeZeroHour.Checked = True then begin
         if FCountData[i][TBand(16)].FQso = 0 then begin
            Continue;
         end;
      end;

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
      // ０局の時間帯は除く
      if checkExcludeZeroHour.Checked = True then begin
         if FCountData[i][TBand(16)].FQso = 0 then begin
            Continue;
         end;
      end;

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

{
＜時間およびエリアごとの交信局数＞

[7 MHz]
         1     2     3     4     5     6     7     8     9     0     合計    累積

 [21]    -     1     1     7     3    11     -     6     -     -     29      29
 [22]   15     1     3     1     2    12     6     6     2     1     49      78
 [23]    5     1     1     -     -     1     -     -     -     1      9      87
 [00]    -     -     -     -     -     -     -     -     -     -      -      87
 [06]    9     9     6     5     1     1     1     1     2     1     36     123
 [07]    2     -     4     -     -     1     2     -     -     1     10     133
 [10]    4     -     2     1     -     -     1     -     1     1     10     143
 [11]    7     3     -     1     -     -     3     2     1     3     20     163
 [13]   16     3     3     2     -     -     1     2     1     2     30     193
 [14]    4     2     1     1     -     -     -     -     2     1     11     204
 [15]    6     4     2     -     -     -     -     -     -     -     12     216
 [16]    7     3     5     2     2     2     2     -     -     1     24     240
 [17]   14     -     5     1     -     1     2     -     1     1     25     265
 [18]    2     -     -     -     -     -     -     -     -     -      2     267

Total   91    27    33    21     8    29    18    17    10    13    267
1234512345123456123456123456123456123456                        123456712345678
}
procedure TZAnalyze.ShowZAA(sl: TStrings);
var
   b: TBand;
   nLastHour: Integer;
   strText: string;
begin
   sl.Clear();

   nLastHour := GetLastHour();

   strText := '＜時間およびエリアごとの交信局数＞';
   sl.Add(strText);
   sl.Add('');

   for b := b19 to HiBand do begin
      if FCountData2[25][b].FQso[11] = 0 then begin
         Continue;
      end;
      ShowZAA_band(sl, b, nLastHour);
   end;
end;

procedure TZAnalyze.ShowZAA2(sl: TStrings; b: TBand);
var
   nLastHour: Integer;
   strText: string;
begin
   sl.Clear();

   nLastHour := GetLastHour();

   strText := '＜時間およびエリアごとの交信局数＞';
   sl.Add(strText);
   sl.Add('');

   ShowZAA_band(sl, b, nLastHour);
end;

procedure TZAnalyze.ShowZAA_band(sl: TStrings; b: TBand; nLastHour: Integer);
var
   i: Integer;
   t: Integer;
   strText: string;
   r: Integer;

   function CountStr(cnt: Integer): string;
   begin
      if cnt = 0 then begin
         Result := '-';
      end
      else begin
         Result := IntToStr(cnt);
      end;
   end;
begin
   strText := '[' + MHzString[b] + ' MHz]';
   sl.Add(strText);
   strText := '         1     2     3     4     5     6     7     8     9     0     合計    累積';
   sl.Add(strText);
   sl.Add('');

   r := 0;
   for i := 1 to nLastHour do begin
      // ０局の時間帯は除く
      if checkExcludeZeroHour.Checked = True then begin
         if FCountData2[i][b].FQso[11] = 0 then begin
            Continue;
         end;
      end;

      // 見出し
      t := 20 + i;
      if t >= 24 then begin
         t := t - 24;
      end;
      strText := ' [' + RightStr('00' + IntToStr(t), 2) + ']';

      r := r + FCountData2[i][b].FQso[11];

      strText := strText + RightStr('     ' + CountStr(FCountData2[i][b].FQso[1]), 5);
      strText := strText + RightStr('      ' + CountStr(FCountData2[i][b].FQso[2]), 6);
      strText := strText + RightStr('      ' + CountStr(FCountData2[i][b].FQso[3]), 6);
      strText := strText + RightStr('      ' + CountStr(FCountData2[i][b].FQso[4]), 6);
      strText := strText + RightStr('      ' + CountStr(FCountData2[i][b].FQso[5]), 6);
      strText := strText + RightStr('      ' + CountStr(FCountData2[i][b].FQso[6]), 6);
      strText := strText + RightStr('      ' + CountStr(FCountData2[i][b].FQso[7]), 6);
      strText := strText + RightStr('      ' + CountStr(FCountData2[i][b].FQso[8]), 6);
      strText := strText + RightStr('      ' + CountStr(FCountData2[i][b].FQso[9]), 6);
      strText := strText + RightStr('      ' + CountStr(FCountData2[i][b].FQso[10]), 6);
      strText := strText + RightStr('       ' + CountStr(FCountData2[i][b].FQso[11]), 7);
      strText := strText + RightStr('        ' + CountStr(r), 8);
      sl.Add(strText);
   end;

   strText := 'Total';
   strText := strText + RightStr('     ' + CountStr(FCountData2[25][b].FQso[1]), 5);
   strText := strText + RightStr('      ' + CountStr(FCountData2[25][b].FQso[2]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[25][b].FQso[3]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[25][b].FQso[4]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[25][b].FQso[5]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[25][b].FQso[6]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[25][b].FQso[7]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[25][b].FQso[8]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[25][b].FQso[9]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[25][b].FQso[10]), 6);
   strText := strText + RightStr('       ' + CountStr(FCountData2[25][b].FQso[11]), 7);
   sl.Add(strText);

   sl.Add('');
   sl.Add('');
   sl.Add('');
end;

end.
