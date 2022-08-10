unit UZAnalyze;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Classes, System.DateUtils, System.StrUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ClipBrd, Vcl.ComCtrls, Generics.Collections, Generics.Defaults,
  UzLogConst, UzLogQSO, UzLogGlobal;

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

const
  WM_ANALYZE_UPDATE = (WM_USER + 100);

const
  HTOTAL = 49;
  VTOTAL = TBand(16);
  CTOTAL = TBand(17);
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

  TOpCount = class(TObject)
    FOpName: string;
    FQsoCountPH: array[b19..b10g] of Integer;
    FQsoCountCW: array[b19..b10g] of Integer;
    FMultiCountPH: array[b19..b10g] of Integer;
    FMultiCountCW: array[b19..b10g] of Integer;
  public
    constructor Create();
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
    buttonSave: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buttonUpdateClick(Sender: TObject);
    procedure buttonCopyClick(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure OnAnalyzeUpdate( var Message: TMessage ); message WM_ANALYZE_UPDATE;
    procedure buttonSaveClick(Sender: TObject);
  private
    { Private 宣言 }
    FStartHour: Integer;
    FCountData: array[1..49] of array[b19..TBand(17)] of TQsoCount;
    FCountData2: array[1..49] of array[b19..TBand(17)] of TQsoCount2;
    FOpCount: TList<TOpCount>;
    FZADSupport: Boolean;
    FMultiGet: array[02..114] of array[b19..b50] of Boolean;
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
    function HourText(hh: Integer): string;
    procedure ShowZAD(sl: TStrings);
    procedure ShowZOP(sl: TStrings);
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
   FOpCount := TList<TOpCount>.Create();
   Memo1.Clear();
   InitTimeChart();
end;

procedure TZAnalyze.FormDestroy(Sender: TObject);
var
   i: Integer;
begin
   for i := FOpCount.Count - 1 downto 0 do begin
      FOpCount[i].Free();
      FOpCount.Delete(i);
   end;
   FOpCount.Free();
end;

procedure TZAnalyze.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
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

procedure TZAnalyze.buttonSaveClick(Sender: TObject);
var
   fname: string;
begin
   fname := CurrentFileName();

   // ZAF
   TabControl1.TabIndex := 0;
   TabControl1Change(nil);
   fname := ChangeFileExt(fname, '.ZAF');
   Memo1.Lines.SaveToFile(fname);

   // ZAQ
   TabControl1.TabIndex := 1;
   TabControl1Change(nil);
   fname := ChangeFileExt(fname, '.ZAQ');
   Memo1.Lines.SaveToFile(fname);

   // ZAA
   TabControl1.TabIndex := 3;
   TabControl1Change(nil);
   fname := ChangeFileExt(fname, '.ZAA');
   Memo1.Lines.SaveToFile(fname);

   // ZAD
   TabControl1.TabIndex := 4;
   TabControl1Change(nil);
   fname := ChangeFileExt(fname, '.ZAD');
   Memo1.Lines.SaveToFile(fname);

   // ZAD
   TabControl1.TabIndex := 5;
   TabControl1Change(nil);
   fname := ChangeFileExt(fname, '.ZOP');
   Memo1.Lines.SaveToFile(fname);
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

      // ZAD
      4: begin
         ShowZAD(sl);
      end;

      // ZOP
      5: begin
         ShowZOP(sl);
      end;
   end;
end;

procedure TZAnalyze.InitTimeChart();
var
   t: Integer;
   b: TBand;
   a: Integer;
   i: Integer;
begin
   for t := 1 to 49 do begin
      for b := b19 to TBand(17) do begin
         FCountData[t][b].FQso := 0;
         FCountData[t][b].FCw := 0;
         FCountData[t][b].FMulti := 0;
         FCountData[t][b].FPts := 0;
      end;
   end;

   for t := 1 to 49 do begin
      for b := b19 to TBand(17) do begin
         for a := 1 to 12 do begin
            FCountData2[t][b].FQso[a] := 0;
            FCountData2[t][b].FUnknown := 0;
         end;
      end;
   end;

   FZADSupport := False;
   for b := b19 to b50 do begin
      for i := 02 to 114 do begin
         FMultiGet[i][b] := False;
      end;
   end;

   for i := FOpCount.Count - 1 downto 0 do begin
      FOpCount[i].Free();
      FOpCount.Delete(i);
   end;
end;

procedure TZAnalyze.TotalTimeChart(Log: TQSOList);
var
   i: Integer;
   j: Integer;
   qso: TQSO;
   b: TBand;
   m: TMode;
   t: Integer;
   a: Integer;
   base_dt: TDateTime;
   dt: TDateTime;
   offset_hour: Integer;
   O: TOpCount;
   multi: Integer;

   function FindOperator(opname: string): Integer;
   var
      i: Integer;
   begin
      for i := 0 to FOpCount.Count - 1 do begin
         if FOpCount[i].FOpName = qso.Operator then begin
            Result := i;
            Exit;
         end;
      end;
      Result := -1;
   end;
begin
   InitTimeChart();

   if Log.Count = 1 then begin
      Exit;
   end;

   if (MyContest is TALLJAContest) or
      (MyContest is TSixDownContest) or
      (MyContest is TFDContest) then begin
      FZADSupport := True;
   end;

   base_dt := Log.List[1].Time;

   offset_hour := HourOf(base_dt) - 1;
   FStartHour := HourOf(base_dt);

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

      if (t < 1) or (t > 48) then begin
         Continue;
      end;

      // エリア判定
      a := GetAreaNumber(qso.Callsign);

      // QSO
      Inc(FCountData[t][b].FQso);
      Inc(FCountData[HTOTAL][b].FQso);                   // 横計
      Inc(FCountData[t][VTOTAL].FQso);                   // 縦計
      Inc(FCountData[HTOTAL][VTOTAL].FQso);              // 縦横計

      // PTS
      Inc(FCountData[t][b].FPts, qso.Points);
      Inc(FCountData[HTOTAL][b].FPts, qso.Points);       // 横計
      Inc(FCountData[t][VTOTAL].FPts, qso.Points);       // 縦計
      Inc(FCountData[HTOTAL][VTOTAL].FPts, qso.Points);  // 縦横計

      // 内CW
      if m = mCW then begin
         Inc(FCountData[t][b].FCw);
         Inc(FCountData[HTOTAL][b].FCw);                 // 横計
         Inc(FCountData[t][VTOTAL].FCw);                 // 縦計
         Inc(FCountData[HTOTAL][VTOTAL].FCw);            // 縦横計
      end;

      // マルチ
//      if Trim(qso.QSO.Multi1) <> '' then begin
      if qso.NewMulti1 = True then begin
         Inc(FCountData[t][b].FMulti);
         Inc(FCountData[HTOTAL][b].FMulti);              // 横計
         Inc(FCountData[t][VTOTAL].FMulti);              // 縦計
         Inc(FCountData[HTOTAL][VTOTAL].FMulti);         // 縦横計
      end;

      // エリア別
      if a = -1 then begin
         Inc(FCountData2[t][b].FUnknown);
      end
      else begin
         Inc(FCountData2[t][b].FQso[a]);
         Inc(FCountData2[t][b].FQso[11]);                // 横計
         Inc(FCountData2[HTOTAL][b].FQso[a]);            // 縦計
         Inc(FCountData2[HTOTAL][b].FQso[11]);           // 縦横計
      end;

      // マルチ
      if (FZADSupport = True) and (qso.NewMulti1 = True) then begin
         multi := StrToIntDef(qso.Multi1, 0);
         if (multi >= 2) and (multi <= 114) then begin
            if (qso.Band >= b19) and (qso.Band <= b50) then begin
               FMultiGet[multi][qso.Band] := True;
            end;
         end;
      end;

      // Op別 (ZOP)
      j := FindOperator(qso.Operator);
      if j = -1 then begin
         O := TOpCount.Create();
         O.FOpName := qso.Operator;
         FOpCount.Add(O);
      end
      else begin
         O := FOpCount[j];
      end;

      if qso.Mode = mCW then begin
         Inc(O.FQsoCountCW[b]);
         if qso.NewMulti1 = True then begin
            Inc(O.FMultiCountCW[b]);
         end;
      end
      else begin
         Inc(O.FQsoCountPH[b]);
         if qso.NewMulti1 = True then begin
            Inc(O.FMultiCountPH[b]);
         end;
      end;
   end;

   // 累計
   FCountData[1][CTOTAL].FQso := FCountData[1][VTOTAL].FQso;
   for i := 2 to 48 do begin
      FCountData[i][CTOTAL].FQso := FCountData[i - 1][CTOTAL].FQso + FCountData[i][VTOTAL].FQso;
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
   for i := 48 downto 1 do begin
      if FCountData[i][VTOTAL].FQso > 0 then begin
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
   i: Integer;
   nLastIndex: Integer;
begin
   sl.Clear();

   sl.Add('＜タイムチャート＞');
   sl.Add('');

   // どこまで交信があるか調べる
   nLastIndex := GetLastHour();

   // 見出し（上）
   strText := '    |';
   for i := 1 to nLastIndex do begin
      strText := strText + ' ' + HourText(i);
   end;
   strText := strText + '|合計';
   sl.Add(strText);

   strText := '----+';
   for i := 1 to nLastIndex do begin
      strText := strText + '---';
   end;
   strText := strText + '+----';
   sl.Add(strText);

   // 明細行
   for b := b19 to HiBand do begin
      // １局も交信が無いバンドは除く
      if FCountData[HTOTAL][b].FQso = 0 then begin
         Continue;
      end;

      strText := RightStr('    ' + MHzString[b], 4) + '|';

      for t := 1 to nLastIndex do begin
         if FCountData[t][b].FQso = 0 then begin
            strText := strText + '  -';
         end
         else begin
            strText := strText + RightStr('   ' + IntToStr(FCountData[t][b].FQso), 3);
         end;
      end;

      strText := strText + '|';
      strText := strText + RightStr('    ' + IntToStr(FCountData[HTOTAL][b].FQso), 4);
      sl.Add(strText);
   end;

   // 見出し（下）
   strText := '----+';
   for i := 1 to nLastIndex do begin
      strText := strText + '---';
   end;
   strText := strText + '+----';
   sl.Add(strText);

   // 合計行
   strText := '合計|';
   for t := 1 to nLastIndex do begin
      strText := strText + RightStr('   ' + IntToStr(FCountData[t][VTOTAL].FQso), 3);
   end;
   strText := strText + '|';
   strText := strText + RightStr('    ' + IntToStr(FCountData[HTOTAL][VTOTAL].FQso), 4);
   sl.Add(strText);

   // 累計行
   strText := '累計|';
   for t := 1 to nLastIndex do begin
      if (t mod 3) = 0 then begin
         if FCountData[t][CTOTAL].FQso < 1000 then begin
            strText := strText + RightStr('   ' + IntToStr(FCountData[t][CTOTAL].FQso), 3);
         end
         else begin
            strText := Copy(strText, 1, Length(strText) - 1);
            strText := strText + RightStr('    ' + IntToStr(FCountData[t][CTOTAL].FQso), 4);
         end;
      end
      else begin
         strText := strText + '   ';
      end;
   end;
   strText := strText + '|';
//   strText := strText + RightStr('    ' + IntToStr(FCountData[HTOTAL][CTOTAL].FQso), 4);
   sl.Add(strText);
end;

procedure TZAnalyze.ShowZAF(sl: TStrings);
var
   b: TBand;
   strText: string;
   i: Integer;
   cumulative_count: array[b19..CTOTAL] of Integer;
   nLastHour: Integer;
begin
   sl.Clear();

   sl.Add('＜結果＞');
   sl.Add('');

   sl.Add('　バンド　　交信局数　　得点　　マルチ');

   for b := b19 to HiBand do begin
      if FCountData[HTOTAL][b].FQso = 0 then begin
         Continue;
      end;

      strText := ' ' + RightStr('    ' + MHzString[b], 4) + ' MHz     ' +
                 RightStr('    ' + IntToStr(FCountData[HTOTAL][b].FQso), 4) + '      ' +
                 RightStr('    ' + IntToStr(FCountData[HTOTAL][b].FPts), 4) + '    ' +
                 RightStr('    ' + IntToStr(FCountData[HTOTAL][b].FMulti), 4);
      sl.Add(strText);
   end;

   strText := '  合　計     ' +
              RightStr('     ' + IntToStr(FCountData[HTOTAL][VTOTAL].FQso), 5) + '     ' +
              RightStr('     ' + IntToStr(FCountData[HTOTAL][VTOTAL].FPts), 5) + ' × ' +
              RightStr('     ' + IntToStr(FCountData[HTOTAL][VTOTAL].FMulti), 4) + '  ＝  ' +
              IntToStr(FCountData[HTOTAL][VTOTAL].FPts * FCountData[HTOTAL][VTOTAL].FMulti);
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
      if FCountData[HTOTAL][b].FQso = 0 then begin
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
         if FCountData[i][VTOTAL].FQso = 0 then begin
            Continue;
         end;
      end;

      strText := '';

      for b := b19 to HiBand do begin
         if FCountData[HTOTAL][b].FQso = 0 then begin
            Continue;
         end;

         strText := strText + '     ' + RightStr('    ' + IntToStr(FCountData[i][b].FQso), 4);
      end;

      // ALL
      strText := strText + '      ' + RightStr('    ' + IntToStr(FCountData[i][VTOTAL].FQso), 4);

      // 見出し
      strText := ' [' + HourText(i) + ']' + Copy(strText, 5);

      sl.Add(strText);
   end;

   // 合計
   //Total   24      267        8        3        3        1        2       308
   sl.Add('');
   strText := '';

   for b := b19 to HiBand do begin
      if FCountData[HTOTAL][b].FQso = 0 then begin
         Continue;
      end;

      strText := strText + '     ' + RightStr('    ' + IntToStr(FCountData[HTOTAL][b].FQso), 4);
   end;

   // ALL
   strText := strText + '      ' + RightStr('    ' + IntToStr(FCountData[HTOTAL][VTOTAL].FQso), 4);
   strText := 'Total ' + Copy(strText, 6);

   sl.Add(strText);
   sl.Add('');
   sl.Add('');



   sl.Add('＜時間ごとの累積交信局数＞');
   sl.Add('');

   strText := '';
   for b := b19 to HiBand do begin
      cumulative_count[b] := 0;

      if FCountData[HTOTAL][b].FQso = 0 then begin
         Continue;
      end;

      strText := strText + '     ' + RightStr('    ' + MHzString[b], 4);
   end;

   cumulative_count[VTOTAL] := 0;
   strText := strText + '       ALL';

   sl.Add('       ' + Trim(strText));
   sl.Add('');

   for i := 1 to nLastHour do begin
      // ０局の時間帯は除く
      if checkExcludeZeroHour.Checked = True then begin
         if FCountData[i][VTOTAL].FQso = 0 then begin
            Continue;
         end;
      end;

      strText := '';

      for b := b19 to HiBand do begin
         if FCountData[HTOTAL][b].FQso = 0 then begin
            Continue;
         end;

         cumulative_count[b] := cumulative_count[b] + FCountData[i][b].FQso;

         strText := strText + '     ' + RightStr('    ' + IntToStr(cumulative_count[b]), 4);
      end;

      // ALL
      cumulative_count[VTOTAL] := cumulative_count[VTOTAL] + FCountData[i][VTOTAL].FQso;
      strText := strText + '      ' + RightStr('    ' + IntToStr(cumulative_count[VTOTAL]), 4);

      // 見出し
      strText := ' [' + HourText(i) + ']' + Copy(strText, 5);

      sl.Add(strText);
   end;

   sl.Add('');
   sl.Add('');



   sl.Add('＜マルチプライヤーの獲得状況＞');
   sl.Add('');

   strText := '';
   for b := b19 to HiBand do begin
      if FCountData[HTOTAL][b].FQso = 0 then begin
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
         if FCountData[i][VTOTAL].FQso = 0 then begin
            Continue;
         end;
      end;

      strText := '';

      for b := b19 to HiBand do begin
         if FCountData[HTOTAL][b].FQso = 0 then begin
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
      if FCountData[i][VTOTAL].FMulti = 0 then begin
         strText := strText + '      ' + '   -';
      end
      else begin
         strText := strText + '      ' + RightStr('    ' + IntToStr(FCountData[i][VTOTAL].FMulti), 4);
      end;

      // 見出し
      strText := ' [' + HourText(i) + ']' + Copy(strText, 5);

      sl.Add(strText);
   end;

   // 合計
   //Total   24      267        8        3        3        1        2       308
   sl.Add('');
   strText := '';

   for b := b19 to HiBand do begin
      if FCountData[HTOTAL][b].FQso = 0 then begin
         Continue;
      end;

      if FCountData[HTOTAL][b].FMulti = 0 then begin
         strText := strText + '     ' + '   -';
      end
      else begin
         strText := strText + '     ' + RightStr('    ' + IntToStr(FCountData[HTOTAL][b].FMulti), 4);
      end;
   end;

   // ALL
   if FCountData[HTOTAL][VTOTAL].FMulti = 0 then begin
      strText := strText + '      ' + '   -';
   end
   else begin
      strText := strText + '      ' + RightStr('    ' + IntToStr(FCountData[HTOTAL][VTOTAL].FMulti), 4);
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
      if FCountData2[HTOTAL][b].FQso[11] = 0 then begin
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
      strText := ' [' + HourText(i) + ']';

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
   strText := strText + RightStr('     ' + CountStr(FCountData2[HTOTAL][b].FQso[1]), 5);
   strText := strText + RightStr('      ' + CountStr(FCountData2[HTOTAL][b].FQso[2]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[HTOTAL][b].FQso[3]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[HTOTAL][b].FQso[4]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[HTOTAL][b].FQso[5]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[HTOTAL][b].FQso[6]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[HTOTAL][b].FQso[7]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[HTOTAL][b].FQso[8]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[HTOTAL][b].FQso[9]), 6);
   strText := strText + RightStr('      ' + CountStr(FCountData2[HTOTAL][b].FQso[10]), 6);
   strText := strText + RightStr('       ' + CountStr(FCountData2[HTOTAL][b].FQso[11]), 7);
   sl.Add(strText);

   sl.Add('');
   sl.Add('');
   sl.Add('');
end;

function TZAnalyze.HourText(hh: Integer): string;
var
   t: Integer;
begin
   t := FStartHour + hh - 1;
   if t >= 24 then begin
      t := t - 24;
   end;

   Result := RightStr('00' + IntToStr(t), 2);
end;

procedure TZAnalyze.OnAnalyzeUpdate( var Message: TMessage );
begin
   buttonUpdateClick(nil);
end;

{
＜とれたマルチ＞

[7 MHz]
 101 102 103 104 105 106 108 109 110 112 114 02 03 04 05 06 07 08 09 10 11 12
 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38
 39 40 41 42 43 44 45 46 47

＜とれなかったマルチ＞

[7 MHz]
 107 111 113 48 49 50

＜マルチマップ＞

    11111111111111
    000000000111110000000011111111112222222222333333333344444444445
    123456789012342345678901234567890123456789012345678901234567890
 1.9..****.*......*********************.*****..*.*.**..*****.***...
 3.5*.****.**..*..**************************.********.**********...
   7******.***.*.***********************************************...
  14..****.***.*************************************************...
  21..****.***.*..***********************************.**********...
  28*.**.*.**..*..***.***********.*******************.**********...
  50....**.*......*.....******..*.******************************...
}
procedure TZAnalyze.ShowZAD(sl: TStrings);
var
   strTitle: string;
   b: TBand;
   i: Integer;
   strText: string;

   procedure BuildMultiGet(fGet: Boolean);
   var
      b: TBand;
      i: Integer;
      strText: string;
      strMulti: string;
   begin
      for b := b19 to b50 do begin
         // WARCバンド除く
         if (b = b10) or (b = b18) or (b = b24) then begin
            Continue;
         end;

         // 交信の無いバンド除く
         if FCountData[HTOTAL][b].FQso = 0 then begin
            Continue;
         end;

         // バンド見出し
         strText := '[' + BandString[b] + ']';
         sl.Add(strText);

         // 北海道マルチ
         strText := '';
         for i := 101 to 114 do begin
            if FMultiGet[i][b] = fGet then begin
               strMulti := ' ' + IntToStr(i);
               if Length(strText + strMulti) >= 80 then begin
                  sl.Add(strText);
                  strText := '';
               end;

               strText := strText + strMulti;
            end;
         end;

         // 本州マルチ
         for i := 2 to 50 do begin
            if FMultiGet[i][b] = fGet then begin
               strMulti := ' ' + RightStr('00' + IntToStr(i), 2);
               if Length(strText + strMulti) >= 80 then begin
                  sl.Add(strText);
                  strText := '';
               end;

               strText := strText + strMulti;
            end;
         end;

         if strText <> '' then begin
            sl.Add(strText);
         end;
         sl.Add('');
      end;
   end;
begin
   sl.Clear();

   if FZADSupport = False then begin
      strText := 'サポートされていないコンテストです';
      sl.Add(strText);
      Exit;
   end;

   strTitle := '＜とれたマルチ＞';
   sl.Add(strTitle);
   sl.Add('');
   BuildMultiGet(True);
   sl.Add('');

   strTitle := '＜とれなかったマルチ＞';
   sl.Add(strTitle);
   sl.Add('');
   BuildMultiGet(False);
   sl.Add('');

   strTitle := '＜マルチマップ＞';
   sl.Add(strTitle);
   sl.Add('');
   strTitle := '    11111111111111';
   sl.Add(strTitle);
   strTitle := '    000000000111110000000011111111112222222222333333333344444444445';
   sl.Add(strTitle);
   strTitle := '    123456789012342345678901234567890123456789012345678901234567890';
   sl.Add(strTitle);

   for b := b19 to b50 do begin
      // WARCバンド除く
      if (b = b10) or (b = b18) or (b = b24) then begin
         Continue;
      end;

      // 交信の無いバンド除く
      if FCountData[HTOTAL][b].FQso = 0 then begin
         Continue;
      end;

      strText := RightStr('    ' + MHzString[b], 4);

      for i := 101 to 114 do begin
         if FMultiGet[i][b] = True then begin
            strText := strText + '*';
         end
         else begin
            strText := strText + '.';
         end;
      end;

      for i := 2 to 50 do begin
         if FMultiGet[i][b] = True then begin
            strText := strText + '*';
         end
         else begin
            strText := strText + '.';
         end;
      end;

      sl.Add(strText);
   end;
   sl.Add('');
end;

{
＜オペレータ別交信局数＞　（括弧内は電信の内数）

         1.9      3.5        7       14       21       28       50       ALL

1234567891234567891234567891234567891234567891234567891234567891234567891234567890
JA8xxx   191(191) 106(106) 318(318) 351(351) 130(130) 129(129) 123(123) 1348(1348)
JH8xxx    12(12)  263(263) 338(338) 120(120) 323(323) 235(235)  19(19)  1310(1310)

Total    203(203) 369(369) 656(656) 471(471) 453(453) 364(364) 142(142) 2658(2658)


＜オペレータ別取得マルチ＞　（括弧内は電信の内数）

123456789123456789123456789123456789123456789123456789123456789123456789123456789
         1.9      3.5        7       14       21       28       50       ALL

JA8xxx    38(38)   15(15)   48(48)   51(51)   35(35)   43(43)   27(27)   257(257)
JH8xxx     5(5)    37(37)    9(9)     5(5)    18(18)    7(7)    14(14)    95(95)

Total     43(43)   52(52)   57(57)   56(56)   53(53)   50(50)   41(41)   352(352)
}
procedure TZAnalyze.ShowZOP(sl: TStrings);
var
   b: TBand;
   strText: string;
   strText2: string;
   strTitle: string;
   i: Integer;
   l: Integer;
   O: TOpCount;
   TT1: TOpCount;
   TT2: TOpCount;

   function BuildQsoCount(O: TOpCount): string;
   var
      b: TBand;
      strText2: string;
      all_tt: Integer;
      all_cw: Integer;
      tt: Integer;
      cw: Integer;
      tt_str: string;
      cw_str: string;
   begin
      strText2 := LeftStr(O.FOpName + DupeString(' ', 9), 9);
      all_tt := 0;
      all_cw := 0;
      for b := b19 to b10g do begin
         if FCountData[HTOTAL][b].FQso = 0 then begin
            Continue;
         end;

         tt := O.FQsoCountPH[b] + O.FQsoCountCW[b];
         cw := O.FQsoCountCW[b];
         Inc(all_tt, tt);
         Inc(all_cw, cw);
         tt_str := RightStr('    ' + IntToStr(tt), 4);
         cw_str := IntToStr(cw);
         if cw = 0 then begin
            strText2 := strText2 + LeftStr(tt_str + DupeString(' ', 9), 9);
         end
         else begin
            strText2 := strText2 + LeftStr(tt_str + '(' + cw_str + ')' + DupeString(' ', 9), 9);
         end;
      end;

      // ALL(横計)
      tt_str := RightStr('    ' + IntToStr(all_tt), 4);
      cw_str := IntToStr(all_cw);
      if all_cw = 0 then begin
         strText2 := strText2 + LeftStr(tt_str + DupeString(' ', 10), 10);
      end
      else begin
         strText2 := strText2 + LeftStr(tt_str + '(' + cw_str + ')' + DupeString(' ', 10), 10);
      end;

      Result := strText2;
   end;

   function BuildMultiCount(O: TOpCount): string;
   var
      b: TBand;
      strText2: string;
      all_tt: Integer;
      all_cw: Integer;
      tt: Integer;
      cw: Integer;
      tt_str: string;
      cw_str: string;
   begin
      strText2 := LeftStr(O.FOpName + DupeString(' ', 9), 9);
      all_tt := 0;
      all_cw := 0;
      for b := b19 to b10g do begin
         if FCountData[HTOTAL][b].FQso = 0 then begin
            Continue;
         end;

         tt := O.FMultiCountPH[b] + O.FMultiCountCW[b];
         cw := O.FMultiCountCW[b];
         Inc(all_tt, tt);
         Inc(all_cw, cw);
         tt_str := RightStr('    ' + IntToStr(tt), 3);
         cw_str := IntToStr(cw);
         if cw = 0 then begin
            strText2 := strText2 + LeftStr(tt_str + DupeString(' ', 9), 9);
         end
         else begin
            strText2 := strText2 + LeftStr(tt_str + '(' + cw_str + ')' + DupeString(' ', 9), 9);
         end;
      end;

      // ALL(横計)
      tt_str := RightStr('    ' + IntToStr(all_tt), 4);
      cw_str := IntToStr(all_cw);
      if all_cw = 0 then begin
         strText2 := strText2 + LeftStr(tt_str + DupeString(' ', 10), 10);
      end
      else begin
         strText2 := strText2 + LeftStr(tt_str + '(' + cw_str + ')' + DupeString(' ', 10), 10);
      end;

      Result := strText2;
   end;
begin
   sl.Clear();

   // OP別交信数
   strText := '＜オペレータ別交信局数＞　（括弧内は電信の内数）';
   sl.Add(strText);
   sl.Add('');

   // バンド見出し
   strTitle := DupeString(' ', 9);
   for b := b19 to b10g do begin
      if FCountData[HTOTAL][b].FQso = 0 then begin
         Continue;
      end;

      l := Length(MHzString[b]);
      if l < 3 then begin
         strTitle := strTitle + LeftStr(DupeString(' ', 3 - L) + MHzString[b] + DupeString(' ', 9), 9);
      end
      else begin
         strTitle := strTitle + LeftStr(MHzString[b] + DupeString(' ', 9), 9);
      end;
   end;
   strTitle := strTitle + ' ALL     ';
   sl.Add(strTitle);
   sl.Add('');

   // OP別
   TT1 := TOpCount.Create();
   TT1.FOpName := 'Total';
   for i := 0 to FOpCount.Count - 1 do begin
      O := FOpCount[i];
      strText2 := BuildQsoCount(O);
      sl.Add(strText2);

      for b := b19 to b10g do begin
         if FCountData[HTOTAL][b].FQso = 0 then begin
            Continue;
         end;
         Inc(TT1.FQsoCountPH[b], O.FQsoCountPH[b]);
         Inc(TT1.FQsoCountCW[b], O.FQsoCountCW[b]);
      end;
   end;
   sl.Add('');

   // 縦計
   strText2 := BuildQsoCount(TT1);
   sl.Add(strText2);
   sl.Add('');

   // OP別マルチ
   strText := '＜オペレータ別取得マルチ＞　（括弧内は電信の内数）';
   sl.Add(strText);
   sl.Add('');

   // バンド別見出し
   sl.Add(strTitle);
   sl.Add('');

   // OP別
   TT2 := TOpCount.Create();
   TT2.FOpName := 'Total';
   for i := 0 to FOpCount.Count - 1 do begin
      O := FOpCount[i];
      strText2 := BuildMultiCount(O);
      sl.Add(strText2);

      for b := b19 to b10g do begin
         if FCountData[HTOTAL][b].FQso = 0 then begin
            Continue;
         end;

         Inc(TT2.FMultiCountPH[b], O.FMultiCountPH[b]);
         Inc(TT2.FMultiCountCW[b], O.FMultiCountCW[b]);
      end;
   end;
   sl.Add('');

   // 縦計
   strText2 := BuildMultiCount(TT2);
   sl.Add(strText2);
   sl.Add('');

   TT1.Free();
   TT2.Free();
end;

{ TOpCount }

constructor TOpCount.Create();
var
   b: TBand;
begin
   Inherited;
   for b := b19 to b10g do begin
      FQsoCountPH[b] := 0;
      FQsoCountCW[b] := 0;
      FMultiCountPH[b] := 0;
      FMultiCountCW[b] := 0;
   end;
end;

end.
