unit UZAnalyze;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Math,
  System.SysUtils, System.Classes, System.DateUtils, System.StrUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ClipBrd, Vcl.ComCtrls, Generics.Collections, Generics.Defaults,
  UzLogConst, UzLogQSO, UzLogGlobal, UzLogContest;

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
    FMultiCw: Integer;
    FMulti2: Integer;
    FMulti2Cw: Integer;
    FPts: Integer;
  end;

  TQsoCount2 = record
    FQso: array[1..12] of Integer;
    FCw: array[1..12] of Integer;
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
    checkShowCW: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buttonUpdateClick(Sender: TObject);
    procedure buttonCopyClick(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OnAnalyzeUpdate( var Message: TMessage ); message WM_ANALYZE_UPDATE;
    procedure buttonSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private 宣言 }
    FStartHour: Integer;
    FCountData: array[1..49] of array[b19..TBand(17)] of TQsoCount;
    FCountData2: array[1..49] of array[b19..TBand(17)] of TQsoCount2;
    FOpCount: TList<TOpCount>;
    FZADSupport: Boolean;
    FMultiGet: array[02..114] of array[b19..b10g] of Integer;
    FMultiGet2: array[b19..b10g] of TList<string>;
    procedure ShowAll(sl: TStrings);
    procedure InitTimeChart();
    procedure TotalTimeChart(qsolist: TQSOList);
    function GetAreaNumber(strCallsign: string): Integer;
    function GetLastHour(): Integer;
    procedure ShowZAQ(sl: TStrings);
    procedure ShowZAF(sl: TStrings; fShowCW: Boolean);
    procedure ShowZAF_Result(sl: TStrings; fShowCW: Boolean);
    procedure ShowZAF_Time(nLastHour: Integer; sl: TStrings; fShowCW: Boolean);
    procedure ShowZAF_Accumulation(nLastHour: Integer; sl: TStrings; fShowCW: Boolean);
    procedure ShowZAF_Multi(nLastHour: Integer; sl: TStrings; fShowCW: Boolean);
    procedure ShowZAF_Multi2(nLastHour: Integer; sl: TStrings; fShowCW: Boolean);
    procedure ShowZAA(sl: TStrings; fShowCW: Boolean);
    procedure ShowZAA2(sl: TStrings; b: TBand; fShowCW: Boolean);
    procedure ShowZAA_band(sl: TStrings; b: TBand; nLastHour: Integer; fShowCW: Boolean);
    function HourText(hh: Integer): string;
    function QsoToStr(cnt: Integer; len: Integer; zero: Boolean = False): string;
    function CwToStr(cnt: Integer; len: Integer): string;
    function CwToStrR(cnt: Integer; len: Integer): string;
    procedure ShowZAD(sl: TStrings);
    procedure ShowZOP(sl: TStrings; fShowCW: Boolean);
    function GetExcludeZeroPoint(): Boolean;
    procedure SetExcludeZeroPoint(v: Boolean);
    function GetExcludeZeroHour(): Boolean;
    procedure SetExcludeZeroHour(v: Boolean);
    function GetShowCW(): Boolean;
    procedure SetShowCW(v: Boolean);
  public
    { Public 宣言 }
    property ExcludeZeroPoints: Boolean read GetExcludeZeroPoint write SetExcludeZeroPoint;
    property ExcludeZeroHour: Boolean read GetExcludeZeroHour write SetExcludeZeroHour;
    property ShowCW: Boolean read GetShowCW write SetShowCW;
  end;

implementation

uses
  Main;

{$R *.dfm}

procedure TZAnalyze.FormCreate(Sender: TObject);
var
   b: TBand;
begin
   FOpCount := TList<TOpCount>.Create();

   for b := b19 to b10g do begin
      FMultiGet2[b] := TList<string>.Create();
   end;

   Memo1.Clear();
   InitTimeChart();
end;

procedure TZAnalyze.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   MainForm.DelTaskbar(Handle);
end;

procedure TZAnalyze.FormDestroy(Sender: TObject);
var
   i: Integer;
   b: TBand;
begin
   for i := FOpCount.Count - 1 downto 0 do begin
      FOpCount[i].Free();
      FOpCount.Delete(i);
   end;
   FOpCount.Free();

   for b := b19 to b10g do begin
      FMultiGet2[b].Free();
   end;
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
   MainForm.AddTaskbar(Handle);

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

function TZAnalyze.GetExcludeZeroPoint(): Boolean;
begin
   Result := checkExcludeZeroPoint.Checked;
end;

procedure TZAnalyze.SetExcludeZeroPoint(v: Boolean);
begin
   checkExcludeZeroPoint.Checked := v;
end;

function TZAnalyze.GetExcludeZeroHour(): Boolean;
begin
   Result := checkExcludeZeroHour.Checked;
end;

procedure TZAnalyze.SetExcludeZeroHour(v: Boolean);
begin
   checkExcludeZeroHour.Checked := v;
end;

function TZAnalyze.GetShowCW(): Boolean;
begin
   Result := checkShowCW.Checked;
end;

procedure TZAnalyze.SetShowCW(v: Boolean);
begin
   checkShowCW.Checked := v;
end;

procedure TZAnalyze.ShowAll(sl: TStrings);
var
   fShowCW: Boolean;
begin
   sl.BeginUpdate();
   try
      fShowCW := checkShowCW.Checked;

      case TabControl1.TabIndex of
         // ZAF
         0: begin
            ShowZAF(sl, fShowCW);
         end;

         // ZAQ
         1: begin
            ShowZAQ(sl);
         end;

         // ZAA
         2: begin
            ShowZAA2(sl, Main.CurrentQSO.Band, fShowCW);
         end;

         // ZAA(ALL)
         3: begin
            ShowZAA(sl, fShowCW);
         end;

         // ZAD
         4: begin
            ShowZAD(sl);
         end;

         // ZOP
         5: begin
            ShowZOP(sl, fShowCW);
         end;
      end;
   finally
      sl.EndUpdate();
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
         FCountData[t][b].FMultiCw := 0;
         FCountData[t][b].FMulti2 := 0;
         FCountData[t][b].FMulti2Cw := 0;
         FCountData[t][b].FPts := 0;
      end;
   end;

   for t := 1 to 49 do begin
      for b := b19 to TBand(17) do begin
         for a := 1 to 12 do begin
            FCountData2[t][b].FQso[a] := 0;
            FCountData2[t][b].FCw[a] := 0;
            FCountData2[t][b].FUnknown := 0;
         end;
      end;
   end;

   FZADSupport := False;
   for b := b19 to b10g do begin
      for i := 02 to 114 do begin
         FMultiGet[i][b] := 0;
      end;

      FMultiGet2[b].Clear();
   end;

   for i := FOpCount.Count - 1 downto 0 do begin
      FOpCount[i].Free();
      FOpCount.Delete(i);
   end;
end;

procedure TZAnalyze.TotalTimeChart(qsolist: TQSOList);
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

   if qsolist.Count = 1 then begin
      Exit;
   end;

   if (MyContest is TALLJAContest) or
      (MyContest is TSixDownContest) or
      (MyContest is TFDContest) then begin
      FZADSupport := True;
   end;

   base_dt := ifthen(MyContest.UseContestPeriod, Log.StartTime, qsolist.List[1].Time);

   offset_hour := HourOf(base_dt) - 1;
   FStartHour := HourOf(base_dt);

   for i := 1 to qsolist.Count - 1 do begin
      qso := qsolist.List[i];
      b := qso.Band;
      m := qso.Mode;
      dt := qso.Time;

      if (qso.Invalid = True) then begin     // 無効もスキップ
         Continue;
      end;

      if (qso.Time < base_dt) then begin     // 開始時間前の交信はスキップ
         Continue;
      end;

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
      if qso.NewMulti1 = True then begin
         Inc(FCountData[t][b].FMulti);
         Inc(FCountData[HTOTAL][b].FMulti);              // 横計
         Inc(FCountData[t][VTOTAL].FMulti);              // 縦計
         Inc(FCountData[HTOTAL][VTOTAL].FMulti);         // 縦横計

         if qso.Mode = mCW then begin
            Inc(FCountData[t][b].FMultiCw);
            Inc(FCountData[HTOTAL][b].FMultiCw);              // 横計
            Inc(FCountData[t][VTOTAL].FMultiCw);              // 縦計
            Inc(FCountData[HTOTAL][VTOTAL].FMultiCw);         // 縦横計
         end;
      end;

      // マルチ
      if qso.NewMulti2 = True then begin
         Inc(FCountData[t][b].FMulti2);
         Inc(FCountData[HTOTAL][b].FMulti2);              // 横計
         Inc(FCountData[t][VTOTAL].FMulti2);              // 縦計
         Inc(FCountData[HTOTAL][VTOTAL].FMulti2);         // 縦横計

         if qso.Mode = mCW then begin
            Inc(FCountData[t][b].FMulti2Cw);
            Inc(FCountData[HTOTAL][b].FMulti2Cw);              // 横計
            Inc(FCountData[t][VTOTAL].FMulti2Cw);              // 縦計
            Inc(FCountData[HTOTAL][VTOTAL].FMulti2Cw);         // 縦横計
         end;
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

         if qso.Mode = mCW then begin
            Inc(FCountData2[t][b].FCw[a]);
            Inc(FCountData2[t][b].FCw[11]);                // 横計
            Inc(FCountData2[HTOTAL][b].FCw[a]);            // 縦計
            Inc(FCountData2[HTOTAL][b].FCw[11]);           // 縦横計
         end;
      end;

      // マルチ
      if (FZADSupport = True) and (qso.NewMulti1 = True) then begin
         if b < b2400 then begin
            multi := StrToIntDef(qso.Multi1, 0);
            if (multi >= 2) and (multi <= 114) then begin
               Inc(FMultiGet[multi][qso.Band]);
            end;
         end
         else begin  // >= b2400
            multi := StrToIntDef(Copy(qso.Multi1, 1, 2), 0);
            if multi = 1 then begin
               Inc(FMultiGet[101][qso.Band]);      // 北海道は101にカウント
            end
            else if (multi >= 2) and (multi <= 48) then begin
               Inc(FMultiGet[multi][qso.Band]);
            end;
         end;
         FMultiGet2[qso.Band].Add(qso.Multi1);
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
         if Result = 0 then begin
            Result := 10;
         end;
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

procedure TZAnalyze.ShowZAF(sl: TStrings; fShowCW: Boolean);
var
   nLastHour: Integer;
begin
   sl.Clear();
   nLastHour := GetLastHour();

   // ＜結果＞
   ShowZAF_Result(sl, fShowCW);

   //＜時間ごとの交信局数＞
   ShowZAF_Time(nLastHour, sl, fShowCW);

   //＜時間ごとの累積交信局数＞　（括弧内は電信の内数）
   ShowZAF_Accumulation(nLastHour, sl, fShowCW);

   // ＜マルチプライヤーの獲得状況＞　（括弧内は電信の内数）
   ShowZAF_Multi(nLastHour, sl, fShowCW);

   // ＜マルチプライヤー２の獲得状況＞　（括弧内は電信の内数）
   if FCountData[HTOTAL][VTOTAL].FMulti2 > 0 then begin
      ShowZAF_Multi2(nLastHour, sl, fShowCW);
   end;
end;

//＜結果＞
procedure TZAnalyze.ShowZAF_Result(sl: TStrings; fShowCW: Boolean);
var
   strText: string;
   b: TBand;
begin
   sl.Add('＜結果＞');
   sl.Add('');

   if FCountData[HTOTAL][VTOTAL].FMulti2 = 0 then begin
      sl.Add('　バンド　　交信局数　　得点　　マルチ');
   end
   else begin
      sl.Add('　バンド　　交信局数　　得点　　マルチ  マルチ2');
   end;

   for b := b19 to HiBand do begin
      if FCountData[HTOTAL][b].FQso = 0 then begin
         Continue;
      end;

      strText := ' ' + RightStr('    ' + MHzString[b], 4) + ' MHz    ' +
                 RightStr('     ' + IntToStr(FCountData[HTOTAL][b].FQso), 5) + '     ' +
                 RightStr('     ' + IntToStr(FCountData[HTOTAL][b].FPts), 5) + '   ' +
                 RightStr('     ' + IntToStr(FCountData[HTOTAL][b].FMulti), 5);

      if FCountData[HTOTAL][VTOTAL].FMulti2 > 0 then begin
         strText := strText + '   ' + RightStr('     ' + IntToStr(FCountData[HTOTAL][b].FMulti2), 5);
      end;

      sl.Add(strText);
   end;

   strText := '  合　計    ';
   if FCountData[HTOTAL][VTOTAL].FMulti2 = 0 then begin
      strText := strText +
                 RightStr('      ' + IntToStr(FCountData[HTOTAL][VTOTAL].FQso), 6) + '    ' +
                 RightStr('      ' + IntToStr(FCountData[HTOTAL][VTOTAL].FPts), 6) + ' ×' +
                 RightStr('     ' + IntToStr(FCountData[HTOTAL][VTOTAL].FMulti), 5) + '  ＝  ' +
                 IntToStr(FCountData[HTOTAL][VTOTAL].FPts * FCountData[HTOTAL][VTOTAL].FMulti);
   end
   else  begin
      strText := strText +
                 RightStr('      ' + IntToStr(FCountData[HTOTAL][VTOTAL].FQso), 6) + '    ' +
                 RightStr('      ' + IntToStr(FCountData[HTOTAL][VTOTAL].FPts), 6) + ' ×' +
                 RightStr('     ' + IntToStr(FCountData[HTOTAL][VTOTAL].FMulti), 5) + '   ' +
                 RightStr('     ' + IntToStr(FCountData[HTOTAL][VTOTAL].FMulti2), 5) + '  ＝  ' +
                 IntToStr(FCountData[HTOTAL][VTOTAL].FPts * (FCountData[HTOTAL][VTOTAL].FMulti + FCountData[HTOTAL][VTOTAL].FMulti2));
   end;
   sl.Add(strText);
   sl.Add('');
end;

//＜時間ごとの交信局数＞
//
//12345XXXXX12345XXXXX12345XXXXX12345XXXXX12345XXXXX12345XXXXX12345XXXXX12345XXXXX
//       1.9       3.5         7        14        21        28        50       ALL
//
// [21]    0        29         0         0         1         1        0         31
// [22]  111(111)  118(118)   22(19)     0         0         0        0         41(38)
// [23]    3        12         0         0         2         0        17        34
//
//Total    0       133(16)   423(2)     47         5         4         1       613(18)
//
procedure TZAnalyze.ShowZAF_Time(nLastHour: Integer; sl: TStrings; fShowCW: Boolean);
var
   strText: string;
   b: TBand;
   i: Integer;
begin
   if fShowCW = True then begin
      sl.Add('＜時間ごとの交信局数＞　（括弧内は電信の内数）');
   end
   else begin
      sl.Add('＜時間ごとの交信局数＞');
   end;
   sl.Add('');

   strText := '';
   for b := b19 to HiBand do begin
      if FCountData[HTOTAL][b].FQso = 0 then begin
         Continue;
      end;

      if fShowCW = True then begin
         strText := strText + '     ' + RightStr('     ' + MHzString[b], 5);
      end
      else begin
         strText := strText + '    ' + RightStr('     ' + MHzString[b], 5);
      end;
   end;

   if fShowCW = True then begin
      strText := strText + '       ALL';
   end
   else begin
      strText := strText + '      ALL';
   end;

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

         if fShowCW = True then begin
            strText := strText + RightStr('     ' + IntToStr(FCountData[i][b].FQso), 5) +
                       CwToStr(FCountData[i][b].FCw, 5);
         end
         else begin
            strText := strText + RightStr('     ' + IntToStr(FCountData[i][b].FQso), 5) + '    ';
         end;
      end;

      // ALL
      if fShowCW = True then begin
         strText := strText + RightStr('    ' + IntToStr(FCountData[i][VTOTAL].FQso), 5) +
                    Trim(CwToStr(FCountData[i][VTOTAL].FCw, 5));
      end
      else begin
         strText := strText + RightStr('    ' + IntToStr(FCountData[i][VTOTAL].FQso), 5);
      end;

      // 見出し
      strText := ' [' + HourText(i) + ']' + strText;

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

      if fShowCW = True then begin
         strText := strText + QsoToStr(FCountData[HTOTAL][b].FQso, 5) +
                              CwToStr(FCountData[HTOTAL][b].FCw, 5);
      end
      else begin
         strText := strText + QsoToStr(FCountData[HTOTAL][b].FQso, 5) + '    ';
      end;
   end;

   // ALL
   if fShowCW = True then begin
      strText := strText + QsoToStr(FCountData[HTOTAL][VTOTAL].FQso, 5) +
                           Trim(CwToStr(FCountData[HTOTAL][VTOTAL].FCw, 6));
   end
   else begin
      strText := strText + QsoToStr(FCountData[HTOTAL][VTOTAL].FQso, 5);
   end;
   strText := 'Total' + strText;

   sl.Add(strText);
   sl.Add('');
   sl.Add('');
end;

//＜時間ごとの累積交信局数＞　（括弧内は電信の内数）
//
//12345XXXXX12345XXXXX12345XXXXX12345XXXXX12345XXXXX12345XXXXX12345XXXXX12345XXXXX
//       1.9       3.5         7        14        21        28        50       ALL
//
// [21]    0         0        50         0         0         2         0        52
// [22]    0        19        60         0         0         2         1        82
// [23]    0        56(5)     60         0         0         2         1       119(5)
// [20]    0       133(16)   423(2)     47         5         4         1       613(18)
//
procedure TZAnalyze.ShowZAF_Accumulation(nLastHour: Integer; sl: TStrings; fShowCW: Boolean);
var
   strText: string;
   b: TBand;
   i: Integer;
   accumulation_count: array[b19..CTOTAL] of Integer;
   accumulation_count2: array[b19..CTOTAL] of Integer;
begin
   if fShowCW = True then begin
      sl.Add('＜時間ごとの累積交信局数＞　（括弧内は電信の内数）');
   end
   else begin
      sl.Add('＜時間ごとの累積交信局数＞');
   end;
   sl.Add('');

   strText := '';
   for b := b19 to HiBand do begin
      accumulation_count[b] := 0;
      accumulation_count2[b] := 0;

      if FCountData[HTOTAL][b].FQso = 0 then begin
         Continue;
      end;

      if fShowCW = True then begin
         strText := strText + '     ' + RightStr('     ' + MHzString[b], 5);
      end
      else begin
         strText := strText + '    ' + RightStr('     ' + MHzString[b], 5);
      end;
   end;

   if fShowCW = True then begin
      strText := strText + '       ALL';
   end
   else begin
      strText := strText + '      ALL';
   end;

   accumulation_count[VTOTAL] := 0;
   accumulation_count2[VTOTAL] := 0;

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

         accumulation_count[b] := accumulation_count[b] + FCountData[i][b].FQso;
         accumulation_count2[b] := accumulation_count2[b] + FCountData[i][b].FCw;

         if fShowCW = True then begin
            strText := strText + QsoToStr(accumulation_count[b], 5) +
                                 CwToStr(accumulation_count2[b], 5);
         end
         else begin
            strText := strText + QsoToStr(accumulation_count[b], 5) + '    ';
         end;
      end;

      // ALL
      accumulation_count[VTOTAL] := accumulation_count[VTOTAL] + FCountData[i][VTOTAL].FQso;
      accumulation_count2[VTOTAL] := accumulation_count2[VTOTAL] + FCountData[i][VTOTAL].FCw;

      if fShowCW = True then begin
         strText := strText + QsoToStr(accumulation_count[VTOTAL], 5) +
                              Trim(CwToStr(accumulation_count2[VTOTAL], 6));
      end
      else begin
         strText := strText + QsoToStr(accumulation_count[VTOTAL], 5);
      end;

      // 見出し
      strText := ' [' + HourText(i) + ']' + strText;

      sl.Add(strText);
   end;

   sl.Add('');
   sl.Add('');
end;

// ＜マルチプライヤーの獲得状況＞　（括弧内は電信の内数）
//
//       3.5        7       14       21       50      430       ALL
//
// [21]    -       43        -        -        2        -        45
// [22]   19        9        -        -        -        1        29
// [23]   31(4)     -        -        -        -        -        31(4)
// [00]   12        1(1)     -        -        -        -        13(1)
// [20]    3        6        -        -        2        -        11
//
//Total  111(13)  303(1)    44        5        4        1       468(14)
procedure TZAnalyze.ShowZAF_Multi(nLastHour: Integer; sl: TStrings; fShowCW: Boolean);
var
   strText: string;
   b: TBand;
   i: Integer;
begin
   if fShowCW = True then begin
      sl.Add('＜マルチプライヤーの獲得状況＞　（括弧内は電信の内数）');
   end
   else begin
      sl.Add('＜マルチプライヤーの獲得状況＞');
   end;
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
            strText := strText + '   -' + '     ';
         end
         else begin
            if fShowCW = True then begin
               strText := strText + QsoToStr(FCountData[i][b].FMulti, 4) +
                                    CwToStr(FCountData[i][b].FMultiCw, 5);
            end
            else begin
               strText := strText + QsoToStr(FCountData[i][b].FMulti, 4) + '     ';
            end;
         end;
      end;

      // ALL
      if FCountData[i][VTOTAL].FMulti = 0 then begin
         strText := strText + '    -';
      end
      else begin
         if fShowCW = True then begin
            strText := strText + QsoToStr(FCountData[i][VTOTAL].FMulti, 5) +
                                 Trim(CwToStr(FCountData[i][VTOTAL].FMultiCw, 5));
         end
         else begin
            strText := strText + QsoToStr(FCountData[i][VTOTAL].FMulti, 5);
         end;
      end;

      // 見出し
      strText := ' [' + HourText(i) + '] ' + strText;

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
         strText := strText + '   -' + '     ';
      end
      else begin
         if fShowCW = True then begin
            strText := strText + QsoToStr(FCountData[HTOTAL][b].FMulti, 4) +
                                 CwToStr(FCountData[HTOTAL][b].FMultiCw, 5);
         end
         else begin
            strText := strText + QsoToStr(FCountData[HTOTAL][b].FMulti, 4) + '     ';
         end;
      end;
   end;

   // ALL
   if FCountData[HTOTAL][VTOTAL].FMulti = 0 then begin
      strText := strText + '    -';
   end
   else begin
      if fShowCW = True then begin
         strText := strText + QsoToStr(FCountData[HTOTAL][VTOTAL].FMulti, 5) +
                              Trim(CwToStr(FCountData[HTOTAL][VTOTAL].FMultiCw, 5));
      end
      else begin
         strText := strText + QsoToStr(FCountData[HTOTAL][VTOTAL].FMulti, 5);
      end;
   end;
   strText := 'Total ' + strText;

   sl.Add(strText);
   sl.Add('');
   sl.Add('');
end;

// ＜マルチプライヤーの獲得状況＞　（括弧内は電信の内数）
//
//       3.5        7       14       21       50      430       ALL
//
// [21]    -       43        -        -        2        -        45
// [22]   19        9        -        -        -        1        29
// [23]   31(4)     -        -        -        -        -        31(4)
// [00]   12        1(1)     -        -        -        -        13(1)
// [20]    3        6        -        -        2        -        11
//
//Total  111(13)  303(1)    44        5        4        1       468(14)
procedure TZAnalyze.ShowZAF_Multi2(nLastHour: Integer; sl: TStrings; fShowCW: Boolean);
var
   strText: string;
   b: TBand;
   i: Integer;
begin
   if fShowCW = True then begin
      sl.Add('＜マルチプライヤー２の獲得状況＞　（括弧内は電信の内数）');
   end
   else begin
      sl.Add('＜マルチプライヤー２の獲得状況＞');
   end;
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

         if FCountData[i][b].FMulti2 = 0 then begin
            strText := strText + '   -' + '     ';
         end
         else begin
            if fShowCW = True then begin
               strText := strText + QsoToStr(FCountData[i][b].FMulti2, 4) +
                                    CwToStr(FCountData[i][b].FMulti2Cw, 5);
            end
            else begin
               strText := strText + QsoToStr(FCountData[i][b].FMulti2, 4) + '     ';
            end;
         end;
      end;

      // ALL
      if FCountData[i][VTOTAL].FMulti2 = 0 then begin
         strText := strText + '    -';
      end
      else begin
         if fShowCW = True then begin
            strText := strText + QsoToStr(FCountData[i][VTOTAL].FMulti2, 5) +
                                 Trim(CwToStr(FCountData[i][VTOTAL].FMulti2Cw, 5));
         end
         else begin
            strText := strText + QsoToStr(FCountData[i][VTOTAL].FMulti2, 5);
         end;
      end;

      // 見出し
      strText := ' [' + HourText(i) + '] ' + strText;

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

      if FCountData[HTOTAL][b].FMulti2 = 0 then begin
         strText := strText + '   -' + '     ';
      end
      else begin
         if fShowCW = True then begin
            strText := strText + QsoToStr(FCountData[HTOTAL][b].FMulti2, 4) +
                                 CwToStr(FCountData[HTOTAL][b].FMulti2Cw, 5);
         end
         else begin
            strText := strText + QsoToStr(FCountData[HTOTAL][b].FMulti2, 4) + '     ';
         end;
      end;
   end;

   // ALL
   if FCountData[HTOTAL][VTOTAL].FMulti2 = 0 then begin
      strText := strText + '    -';
   end
   else begin
      if fShowCW = True then begin
         strText := strText + QsoToStr(FCountData[HTOTAL][VTOTAL].FMulti2, 5) +
                              Trim(CwToStr(FCountData[HTOTAL][VTOTAL].FMulti2Cw, 5));
      end
      else begin
         strText := strText + QsoToStr(FCountData[HTOTAL][VTOTAL].FMulti2, 5);
      end;
   end;
   strText := 'Total ' + strText;

   sl.Add(strText);
   sl.Add('');
   sl.Add('');
end;

{
＜時間およびエリアごとの交信局数＞　（括弧内は電信の内数）

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
 [22]    3(3)  6(4)  4(3)  1(1)  1(1)  5(5)  -     2(2)  -     -     22(19) 117(19)
Total   91    27    33    21     8    29    18    17    10    13    267
1234512345123456123456123456123456123456                        123456712345678
}
procedure TZAnalyze.ShowZAA(sl: TStrings; fShowCW: Boolean);
var
   b: TBand;
   nLastHour: Integer;
   strText: string;
begin
   sl.Clear();

   nLastHour := GetLastHour();

   if fShowCW = True then begin
      strText := '＜時間およびエリアごとの交信局数＞　（括弧内は電信の内数）';
   end
   else begin
      strText := '＜時間およびエリアごとの交信局数＞';
   end;

   sl.Add(strText);
   sl.Add('');

   for b := b19 to HiBand do begin
      if FCountData2[HTOTAL][b].FQso[11] = 0 then begin
         Continue;
      end;
      ShowZAA_band(sl, b, nLastHour, fShowCW);
   end;
end;

procedure TZAnalyze.ShowZAA2(sl: TStrings; b: TBand; fShowCW: Boolean);
var
   nLastHour: Integer;
   strText: string;
begin
   sl.Clear();

   nLastHour := GetLastHour();

   if fShowCW = True then begin
      strText := '＜時間およびエリアごとの交信局数＞　（括弧内は電信の内数）';
   end
   else begin
      strText := '＜時間およびエリアごとの交信局数＞';
   end;

   sl.Add(strText);
   sl.Add('');

   ShowZAA_band(sl, b, nLastHour, fShowCW);
end;

//        12123412123412123412123412123412123412123412123412123412123412312345
// [22]    3(3)  6(4)  4(3)  1(1)  1(1)  5(5)  -     2(2)  -     -     22(19) 117(19)
//Total   91(91)27    33    21     8    29    18    17    10    13    267
procedure TZAnalyze.ShowZAA_band(sl: TStrings; b: TBand; nLastHour: Integer; fShowCW: Boolean);
var
   i: Integer;
   strText: string;
   r: Integer;
   r2: Integer;
begin
   strText := '[' + MHzString[b] + ' MHz]';
   sl.Add(strText);
   strText := '         1     2     3     4     5     6     7     8     9     0     合計    累積';
   sl.Add(strText);
   sl.Add('');

   r := 0;
   r2 := 0;
   for i := 1 to nLastHour do begin
      // ０局の時間帯は除く
      if checkExcludeZeroHour.Checked = True then begin
         if FCountData2[i][b].FQso[11] = 0 then begin
            Continue;
         end;
      end;

      // 見出し
      strText := ' [' + HourText(i) + ']   ';

      r := r + FCountData2[i][b].FQso[11];
      r2 := r2 + FCountData2[i][b].FCw[11];

      if fShowCW = True then begin
         strText := strText + QsoToStr(FCountData2[i][b].FQso[1], 2, True) +
                              CwToStr(FCountData2[i][b].FCw[1], 4);
         strText := strText + QsoToStr(FCountData2[i][b].FQso[2], 2, True) +
                              CwToStr(FCountData2[i][b].FCw[2], 4);
         strText := strText + QsoToStr(FCountData2[i][b].FQso[3], 2, True) +
                              CwToStr(FCountData2[i][b].FCw[3], 4);
         strText := strText + QsoToStr(FCountData2[i][b].FQso[4], 2, True) +
                              CwToStr(FCountData2[i][b].FCw[4], 4);
         strText := strText + QsoToStr(FCountData2[i][b].FQso[5], 2, True) +
                              CwToStr(FCountData2[i][b].FCw[5], 4);
         strText := strText + QsoToStr(FCountData2[i][b].FQso[6], 2, True) +
                              CwToStr(FCountData2[i][b].FCw[6], 4);
         strText := strText + QsoToStr(FCountData2[i][b].FQso[7], 2, True) +
                              CwToStr(FCountData2[i][b].FCw[7], 4);
         strText := strText + QsoToStr(FCountData2[i][b].FQso[8], 2, True) +
                              CwToStr(FCountData2[i][b].FCw[8], 4);
         strText := strText + QsoToStr(FCountData2[i][b].FQso[9], 2, True) +
                              CwToStr(FCountData2[i][b].FCw[9], 4);
         strText := strText + QsoToStr(FCountData2[i][b].FQso[10], 2, True) +
                              CwToStr(FCountData2[i][b].FCw[10], 4);
         strText := strText + QsoToStr(FCountData2[i][b].FQso[11], 3, True) +
                              CwToStr(FCountData2[i][b].FCw[11], 5);
         strText := strText + QsoToStr(r, 3, True) +
                              Trim(CwToStr(r2, 5));
      end
      else begin
         strText := strText + QsoToStr(FCountData2[i][b].FQso[1], 2, True) + '    ';
         strText := strText + QsoToStr(FCountData2[i][b].FQso[2], 2, True) + '    ';
         strText := strText + QsoToStr(FCountData2[i][b].FQso[3], 2, True) + '    ';
         strText := strText + QsoToStr(FCountData2[i][b].FQso[4], 2, True) + '    ';
         strText := strText + QsoToStr(FCountData2[i][b].FQso[5], 2, True) + '    ';
         strText := strText + QsoToStr(FCountData2[i][b].FQso[6], 2, True) + '    ';
         strText := strText + QsoToStr(FCountData2[i][b].FQso[7], 2, True) + '    ';
         strText := strText + QsoToStr(FCountData2[i][b].FQso[8], 2, True) + '    ';
         strText := strText + QsoToStr(FCountData2[i][b].FQso[9], 2, True) + '    ';
         strText := strText + QsoToStr(FCountData2[i][b].FQso[10], 2, True) + '    ';
         strText := strText + QsoToStr(FCountData2[i][b].FQso[11], 3, True) + '     ';
         strText := strText + QsoToStr(r, 3, True);
      end;
      sl.Add(strText);
   end;

   //Total   17     3     3     2     -     1     3     3     -     2     34
   //       (17)   (3)   (3)   (2)         (1)   (3)   (3)         (2)   (34)
   strText := 'Total  ';
   strText := strText + QsoToStr(FCountData2[HTOTAL][b].FQso[1], 3, True) + '   ';
   strText := strText + QsoToStr(FCountData2[HTOTAL][b].FQso[2], 3, True) + '   ';
   strText := strText + QsoToStr(FCountData2[HTOTAL][b].FQso[3], 3, True) + '   ';
   strText := strText + QsoToStr(FCountData2[HTOTAL][b].FQso[4], 3, True) + '   ';
   strText := strText + QsoToStr(FCountData2[HTOTAL][b].FQso[5], 3, True) + '   ';
   strText := strText + QsoToStr(FCountData2[HTOTAL][b].FQso[6], 3, True) + '   ';
   strText := strText + QsoToStr(FCountData2[HTOTAL][b].FQso[7], 3, True) + '   ';
   strText := strText + QsoToStr(FCountData2[HTOTAL][b].FQso[8], 3, True) + '   ';
   strText := strText + QsoToStr(FCountData2[HTOTAL][b].FQso[9], 3, True) + '   ';
   strText := strText + QsoToStr(FCountData2[HTOTAL][b].FQso[10], 3, True) + '   ';
   strText := strText + QsoToStr(FCountData2[HTOTAL][b].FQso[11], 4, True) + '   ';
   sl.Add(strText);

   if fShowCW = True then begin
      strText := '      ';
      strText := strText + CwToStrR(FCountData2[HTOTAL][b].FCw[1], 5) + ' ';
      strText := strText + CwToStrR(FCountData2[HTOTAL][b].FCw[2], 5) + ' ';
      strText := strText + CwToStrR(FCountData2[HTOTAL][b].FCw[3], 5) + ' ';
      strText := strText + CwToStrR(FCountData2[HTOTAL][b].FCw[4], 5) + ' ';
      strText := strText + CwToStrR(FCountData2[HTOTAL][b].FCw[5], 5) + ' ';
      strText := strText + CwToStrR(FCountData2[HTOTAL][b].FCw[6], 5) + ' ';
      strText := strText + CwToStrR(FCountData2[HTOTAL][b].FCw[7], 5) + ' ';
      strText := strText + CwToStrR(FCountData2[HTOTAL][b].FCw[8], 5) + ' ';
      strText := strText + CwToStrR(FCountData2[HTOTAL][b].FCw[9], 5) + ' ';
      strText := strText + CwToStrR(FCountData2[HTOTAL][b].FCw[10], 5) + '  ';
      strText := strText + CwToStrR(FCountData2[HTOTAL][b].FCw[11], 5);
      sl.Add(strText);
   end;

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

function TZAnalyze.QsoToStr(cnt: Integer; len: Integer; zero: Boolean): string;
begin
   if cnt = 0 then begin
      if zero = True then begin
         Result := DupeString(' ', len - 1) + '-';
      end
      else begin
         Result := DupeString(' ', len - 1) + '0';
      end;
   end
   else begin
      Result := RightStr(DupeString(' ', len) + IntToStr(cnt), len);
   end;
end;

function TZAnalyze.CwToStr(cnt: Integer; len: Integer): string;
begin
   if cnt = 0 then begin
      Result := DupeString(' ', len);
   end
   else begin
      Result := LeftStr('(' + IntToStr(cnt) + ')' + DupeString(' ', len), len);
   end;
end;

function TZAnalyze.CwToStrR(cnt: Integer; len: Integer): string;
begin
   if cnt = 0 then begin
      Result := DupeString(' ', len);
   end
   else begin
      Result := RightStr(DupeString(' ', len) + '(' + IntToStr(cnt) + ')', len);
   end;
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
   n: Integer;
   strText: string;

   // とれたマルチ／とれなかったマルチ
   procedure BuildMultiGet(fGet: Boolean);
   var
      b: TBand;
      i: Integer;
      strText: string;
      strMulti: string;
      fJudge: Boolean;
   begin
      // まずは1200Mまで
      for b := b19 to b1200 do begin
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
            if fGet = True then begin
               fJudge := FMultiGet[i][b] > 0;
            end
            else begin
               fJudge := FMultiGet[i][b] = 0;
            end;

            if fJudge then begin
               strMulti := ' ' + IntToStr(i);
               if Length(strText + strMulti) >= 80 then begin
                  sl.Add(strText);
                  strText := '';
               end;

               strText := strText + strMulti;
            end;
         end;

         // 本州マルチ
         for i := 2 to 48 do begin
            if fGet = True then begin
               fJudge := FMultiGet[i][b] > 0;
            end
            else begin
               fJudge := FMultiGet[i][b] = 0;
            end;

            if fJudge then begin
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

      // 2400以上はとれたマルチのみ
      if fGet = True then begin
         for b := b2400 to b10g do begin
            // 交信の無いバンド除く
            if FCountData[HTOTAL][b].FQso = 0 then begin
               Continue;
            end;

            // 取得リスト並び替え
            FMultiGet2[b].Sort();

            // バンド見出し
            strText := '[' + BandString[b] + ']';
            sl.Add(strText);

            // マルチ取得リストから取り出し
            strText := '';
            for i := 0 to FMultiGet2[b].Count - 1 do begin
               strMulti := ' ' + FMultiGet2[b][i];
               if Length(strText + strMulti) >= 80 then begin
                  sl.Add(strText);
                  strText := '';
               end;

               strText := strText + strMulti;
            end;

            if strText <> '' then begin
               sl.Add(strText);
            end;
            sl.Add('');
         end;
      end;
   end;

   // マルチマップの表示キャラ取得
   function GetMultiCountChar(multi: Integer; b: TBand): string;
   const
      multichar = '123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
   var
      cntstr: string;
   begin
      if FMultiGet[multi][b] > 0 then begin
         if b < b2400 then begin
            cntstr := '*';
         end
         else begin
            n := FMultiGet[multi][b];
            if n > 35 then begin
               n := 35;
            end;
            cntstr := multichar[n];
         end;
      end
      else begin
         cntstr := '.';
      end;

      Result := cntstr;
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
   strTitle := '    0000000001111100000000111111111122222222223333333333444444444';
   sl.Add(strTitle);
   strTitle := '    1234567890123423456789012345678901234567890123456789012345678';
   sl.Add(strTitle);

   for b := b19 to b10g do begin
      // WARCバンド除く
      if (b = b10) or (b = b18) or (b = b24) then begin
         Continue;
      end;

      // 交信の無いバンド除く
      if FCountData[HTOTAL][b].FQso = 0 then begin
         Continue;
      end;

      // バンド名
      strText := RightStr('    ' + MHzString[b], 4);

      // 北海道マルチ
      for i := 101 to 114 do begin
         strText := strText + GetMultiCountChar(i, b);
      end;

      // 本州マルチ
      for i := 2 to 48 do begin
         strText := strText + GetMultiCountChar(i, b);
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
procedure TZAnalyze.ShowZOP(sl: TStrings; fShowCW: Boolean);
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
         if (cw = 0) or (fShowCW = False) then begin
            strText2 := strText2 + LeftStr(tt_str + DupeString(' ', 9), 9);
         end
         else begin
            strText2 := strText2 + LeftStr(tt_str + '(' + cw_str + ')' + DupeString(' ', 9), 9);
         end;
      end;

      // ALL(横計)
      tt_str := RightStr('    ' + IntToStr(all_tt), 4);
      cw_str := IntToStr(all_cw);
      if (all_cw = 0) or (fShowCW = False) then begin
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
         if (cw = 0) or (fShowCW = False) then begin
            strText2 := strText2 + LeftStr(tt_str + DupeString(' ', 9), 9);
         end
         else begin
            strText2 := strText2 + LeftStr(tt_str + '(' + cw_str + ')' + DupeString(' ', 9), 9);
         end;
      end;

      // ALL(横計)
      tt_str := RightStr('    ' + IntToStr(all_tt), 4);
      cw_str := IntToStr(all_cw);
      if (all_cw = 0) or (fShowCW = False) then begin
         strText2 := strText2 + LeftStr(tt_str + DupeString(' ', 10), 10);
      end
      else begin
         strText2 := strText2 + LeftStr(tt_str + '(' + cw_str + ')' + DupeString(' ', 10), 10);
      end;

      Result := strText2;
   end;

   function BuildTitle(len: Integer): string;
   var
      b: TBand;
      l: Integer;
      strTitle: string;
   begin
      strTitle := DupeString(' ', len);
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

      if len = 9 then begin
         strTitle := strTitle + ' ';
      end;

      strTitle := strTitle + 'ALL';

      Result := strTitle;
   end;

begin
   sl.Clear();

   // OP別交信数
   if fShowCW = True then begin
      strText := '＜オペレータ別交信局数＞　（括弧内は電信の内数）';
   end
   else begin
      strText := '＜オペレータ別交信局数＞';
   end;
   sl.Add(strText);
   sl.Add('');

   // バンド見出し
   strTitle := BuildTitle(10);
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
   if fShowCW = True then begin
      strText := '＜オペレータ別取得マルチ＞　（括弧内は電信の内数）';
   end
   else begin
      strText := '＜オペレータ別取得マルチ＞';
   end;
   sl.Add(strText);
   sl.Add('');

   // バンド別見出し
   strTitle := BuildTitle(9);
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
