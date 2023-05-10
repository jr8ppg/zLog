unit URateDialogEx;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, System.Math, System.DateUtils,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.Series, UOptions, UzLogGlobal, UzLogQSO, UzLogConst, Vcl.ComCtrls,
  Vcl.Grids, UQsoTarget, Vcl.Menus;

type
  TRateDialogEx = class(TForm)
    Timer: TTimer;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Last10: TLabel;
    Last100: TLabel;
    Max10: TLabel;
    Max100: TLabel;
    Panel2: TPanel;
    Chart1: TChart;
    Series1: TBarSeries;
    SeriesActualTotals: TLineSeries;
    SeriesTargetTotals: TLineSeries;
    Label4: TLabel;
    ShowLastCombo: TComboBox;
    Label3: TLabel;
    check3D: TCheckBox;
    Series3: TBarSeries;
    Series2: TBarSeries;
    Series4: TBarSeries;
    Series5: TBarSeries;
    Series6: TBarSeries;
    Series7: TBarSeries;
    Series8: TBarSeries;
    Series9: TBarSeries;
    Series10: TBarSeries;
    Series11: TBarSeries;
    Series12: TBarSeries;
    Series13: TBarSeries;
    Series14: TBarSeries;
    Series15: TBarSeries;
    Series16: TBarSeries;
    Panel3: TPanel;
    radioOriginCurrentTime: TRadioButton;
    radioOriginLastQSO: TRadioButton;
    radioOriginFirstQSO: TRadioButton;
    Series17: TBarSeries;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ScoreGrid: TStringGrid;
    popupScore: TPopupMenu;
    menuAchievementRate: TMenuItem;
    menuWinLoss: TMenuItem;
    TabSheet3: TTabSheet;
    ScoreGrid2: TStringGrid;
    N1: TMenuItem;
    menuDispAlternating: TMenuItem;
    menuDispOrder: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerTimer(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
    procedure ShowLastComboChange(Sender: TObject);
    procedure check3DClick(Sender: TObject);
    procedure radioOriginClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ScoreGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure ScoreGridTopLeftChanged(Sender: TObject);
    procedure ScoreGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure menuAchievementRateClick(Sender: TObject);
    procedure ScoreGrid2DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure menuDispAlternatingClick(Sender: TObject);
  private
    { Private declarations }
    FBand: TBand;
    FLast10QsoRateMax: Double;
    FLast100QsoRateMax: Double;
    FShowLast: Integer;      { Show last x hours. default = 12}
    FGraphSeries: array[b19..bTarget] of TBarSeries;
    FGraphStyle: TQSORateStyle;
    FGraphStartPosition: TQSORateStartPosition;

    FOriginTime: TDateTime;      // グラフの基準日時（原点）
    FStartTime: TDateTime;       // グラフの表示開始日時
    FStartHour: Integer;         // 開始時
    FNowHour: Integer;           // 現在時
    FPreHour: Integer;           // 前回timer時の時

    FZaqBgColor: array[0..3] of TColor;
    FZaqFgColor: array[0..3] of TColor;
    FZaqRowBgColor: array[0..35] of TColor;
    FZaqRowFgColor: array[0..35] of TColor;
    FZaq2RowBgColor: array[0..35] of TColor;
    FZaq2RowFgColor: array[0..35] of TColor;
    function UpdateGraphOriginal(hh: Integer): Integer;
    function UpdateGraphByBand(hh: Integer): Integer;
    function UpdateGraphByRange(hh: Integer): Integer;
    function GetGraphSeries(b: TBand): TBarSeries;
    procedure SetGraphStyle(v: TQSORateStyle);
    procedure SetGraphStartPosition(v: TQSORateStartPosition);
    procedure SetGraphStartPositionUI(v: TQSORateStartPosition);
    procedure TargetToGrid(ATarget: TContestTarget);
    procedure TargetToGrid_type2(ATarget: TContestTarget);
    procedure TargetToGrid2(ATarget: TContestTarget);
    procedure SetBand(b: TBand);

    procedure InitZaqGridTitle();
    procedure InitZaq2GridTitle();
    procedure InitScoreGrid_type1();
    procedure InitScoreGrid_type2();
    procedure InitScoreGrid2();
    procedure InitScoreGridRowColor();

    function GetZaqBgColor(n: Integer): TColor;
    procedure SetZaqBgColor(n: Integer; c: TColor);
    function GetZaqFgColor(n: Integer): TColor;
    procedure SetZaqFgColor(n: Integer; c: TColor);
    function GetOtherBgColor(n: Integer): TColor;
    procedure SetOtherBgColor(n: Integer; c: TColor);
    function GetOtherFgColor(n: Integer): TColor;
    procedure SetOtherFgColor(n: Integer; c: TColor);
  public
    { Public declarations }
    procedure InitScoreGrid();
    procedure UpdateGraph;
    property GraphSeries[b: TBand]: TBarSeries read GetGraphSeries;
    property GraphStyle: TQSORateStyle read FGraphStyle write SetGraphStyle;
    property GraphStartPosition: TQSORateStartPosition read FGraphStartPosition write SetGraphStartPosition;
    procedure LoadSettings();
    procedure SaveSettings();
    procedure Refresh(); overload;
    property Band: TBand read FBand write SetBand;
    property ZaqBgColor[n: Integer]: TColor read GetZaqBgColor write SetZaqBgColor;
    property ZaqFgColor[n: Integer]: TColor read GetZaqFgColor write SetZaqFgColor;
    property OtherBgColor[n: Integer]: TColor read GetOtherBgColor write SetOtherBgColor;
    property OtherFgColor[n: Integer]: TColor read GetOtherFgColor write SetOtherFgColor;
  end;

resourcestring
  SCOREGRID_TOTAL      = 'Total';
  SCOREGRID_TARGET     = 'Target';
  SCOREGRID_DIFF       = 'Diff';
  SCOREGRID_DIFF2      = '+/-';
  SCOREGRID_CUMULATIVE = 'Cumulative';
  SCOREGRID_WINLOSS_L  = 'Win/Loss';
  SCOREGRID_WINLOSS_S  = 'W/L';

implementation

uses
  Main;

{$R *.DFM}

procedure TRateDialogEx.FormCreate(Sender: TObject);
var
   b: TBand;
begin
   PageControl1.ActivePageIndex := 0;
   FBand := b19;
   FLast10QsoRateMax := 0;
   FLast100QsoRateMax := 0;
   FShowLast := 12;
   ShowLastCombo.ItemIndex := 2;

   FGraphSeries[b19] := Series1;
   FGraphSeries[b35] := Series2;
   FGraphSeries[b7] := Series3;
   FGraphSeries[b10] := Series4;
   FGraphSeries[b14] := Series5;
   FGraphSeries[b18] := Series6;
   FGraphSeries[b21] := Series7;
   FGraphSeries[b24] := Series8;
   FGraphSeries[b28] := Series9;
   FGraphSeries[b50] := Series10;
   FGraphSeries[b144] := Series11;
   FGraphSeries[b430] := Series12;
   FGraphSeries[b1200] := Series13;
   FGraphSeries[b2400] := Series14;
   FGraphSeries[b5600] := Series15;
   FGraphSeries[b10g] := Series16;
   FGraphSeries[bTarget] := Series17;

   FGraphStyle := rsOriginal;
   FGraphStartPosition := spCurrentTime;

   with Chart1 do begin
      // グラフ全体
      Title.Caption := '';
      Title.Font.Size := 8;
      Legend.Visible := False;

      // 縦軸（時間毎の交信局数）の目盛り設定
      Axes.Left.Automatic := False;
      Axes.Left.Title.Caption := '';  //'時間毎の交信局数';
      Axes.Left.Title.Font.Size := 8;
      Axes.Left.Maximum := 10;
      Axes.Left.Minimum := 0;
      Axes.Left.Increment := 2;
      Axes.Left.Grid.Visible := False;
      Axes.Left.MinorTickCount := 0;

      // 縦軸（累計）の目盛り設定
      Axes.Right.Automatic := False;
      Axes.Right.Title.Caption := ''; //'交信局数の累計';
      Axes.Right.Title.Font.Size := 8;
      Axes.Right.Maximum := 10;
      Axes.Right.Minimum := 0;
      Axes.Right.Increment := 5;
      Axes.Right.Grid.Visible := False;
      Axes.Right.MinorTickCount := 0;

      // 横軸目盛りの設定
      Axes.Bottom.Title.Caption := '';
      Axes.Bottom.Title.Font.Size := 8;
      Axes.Bottom.MinorTickCount := 0;
   end;

   for b := Low(FGraphSeries) to High(FGraphSeries) do begin
      with FGraphSeries[b] do begin
         Clear();
         VertAxis := aLeftAxis;
         ValueFormat := '#,###';    // 0を出さない
      end;
   end;

   with SeriesActualTotals do begin
      Clear();
      VertAxis := aRightAxis;
   end;

   with SeriesTargetTotals do begin
      Clear();
      VertAxis := aRightAxis;
   end;

   LoadSettings();

   InitScoreGrid();

   FPreHour := GetHour(Now);
end;

procedure TRateDialogEx.FormDestroy(Sender: TObject);
begin
//   SaveSettings();
end;

procedure TRateDialogEx.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);

   UpdateGraph;
   TimerTimer(nil);
   Timer.Enabled := True;
end;

procedure TRateDialogEx.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

procedure TRateDialogEx.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Timer.Enabled := False;
   SaveSettings();
   MainForm.DelTaskbar(Handle);
end;

procedure TRateDialogEx.TimerTimer(Sender: TObject);
var
   h: Integer;
begin
   Timer.Enabled := False;
   try
      if Visible = False then begin
         Exit;
      end;

      // QSO Rate
      dmZLogGlobal.Target.UpdateLastRate();
      Last10.Caption := Format('%3.2f', [dmZLogGlobal.Target.Last10QsoRate]) + ' QSOs/hr';
      Max10.Caption := 'max ' + Format('%3.2f', [dmZLogGlobal.Target.Last10QsoRateMax]) + ' QSOs/hr';
      Last100.Caption := Format('%3.2f', [dmZLogGlobal.Target.Last100QsoRate]) + ' QSOs/hr';
      Max100.Caption := 'max ' + Format('%3.2f', [dmZLogGlobal.Target.Last100QsoRateMax]) + ' QSOs/hr';

      // ZAQ/ZAQ2
      if (PageControl1.ActivePageIndex = 1) or
         (PageControl1.ActivePageIndex = 2) then begin
         // 現在の時を取得
         h := GetHour(Now);

         // 前回時と変われば００分を過ぎたと判定
         if FPreHour <> h then begin
            UpdateGraph();
            FPreHour := h;
         end;
      end;

   finally
      Timer.Enabled := True;
   end;
end;

procedure TRateDialogEx.OKBtnClick(Sender: TObject);
begin
   Close;
   MainForm.SetLastFocus();
end;

procedure TRateDialogEx.radioOriginClick(Sender: TObject);
begin
   if radioOriginFirstQSO.Checked = True then begin
      FGraphStartPosition := spFirstQSO;
   end;
   if radioOriginCurrentTime.Checked = True then begin
      FGraphStartPosition := spCurrentTime;
   end;
   if radioOriginLastQSO.Checked = True then begin
      FGraphStartPosition := spLastQSO;
   end;
   UpdateGraph();
end;

procedure TRateDialogEx.StayOnTopClick(Sender: TObject);
begin
//   If StayOnTop.Checked then
//      FormStyle := fsStayOnTop
//   else
//      FormStyle := fsNormal;
end;

procedure TRateDialogEx.check3DClick(Sender: TObject);
begin
   Chart1.View3D := TCheckBox(Sender).Checked;
end;

procedure TRateDialogEx.UpdateGraph;
var
   actual_hour_count: Integer;
   target_hour_count: Integer;
   actual_total_count: Integer;
   target_total_count: Integer;
   hour_peak: Integer;
   Str: string;
   diff: TDateTime;
   H, M, S, ms: Word;
   i: Integer;
   n: Integer;
   hindex: Integer;
   b: TBand;

   function CalcStartTime(dt: TDateTime): TDateTime;
   begin
//      Result := dt - (FShowLast - 1) / 24;
      Result := IncHour(dt, (FShowLast * -1) + 1);
   end;
begin
   for b := b19 to bTarget do begin
      FGraphSeries[b].Clear();
   end;
   SeriesActualTotals.Clear();
   SeriesTargetTotals.Clear();
   Chart1.Axes.Bottom.Items.Clear();

   // 基準時刻を求める
   if Log.TotalQSO = 0 then begin
      FStartTime := CalcStartTime( CurrentTime() );
      FOriginTime := FStartTime;
   end
   else begin
      case GraphStartPosition of
         spFirstQSO:    FStartTime := Log.BaseTime;   // Log.QsoList[1].Time;
         spCurrentTime: FStartTime := CalcStartTime( IncHour(CurrentTime(), (FShowLast div 2) - 1) );
         spLastQSO:     FStartTime := CalcStartTime( Log.QsoList[Log.TotalQSO].Time );
         else           FStartTime := CalcStartTime( CurrentTime() );
      end;

      FOriginTime := Log.BaseTime;  //Log.QsoList[1].Time;
   end;

   DecodeTime(FOriginTime, H, M, S, ms);
   FOriginTime := Int(FOriginTime) + EncodeTime(H, 0, 0, 0);

   DecodeTime(FStartTime, H, M, S, ms);
   FStartTime := Int(FStartTime) + EncodeTime(H, 0, 0, 0);

   // バンド別時間別の集計データを作成
   dmZLogGlobal.Target.UpdateActualQSOs(FOriginTime, FStartTime);

   if (FStartTime >= FOriginTime) then begin
      diff := FStartTime - FOriginTime;
      DecodeTime(diff, H, M, S, ms);
   end
   else begin
      FStartTime := Log.BaseTime;   //Log.QsoList[1].Time;
      DecodeTime(FStartTime, H, M, S, ms);
      FStartTime := Int(FStartTime) + EncodeTime(H, 0, 0, 0);
      H := 0;
   end;

   // グラフに展開
   actual_total_count := dmZLogGlobal.Target.BeforeGraphCount;
   hour_peak := 0;

   target_total_count := 0;
   for i := 1 to H do begin
      target_total_count := target_total_count + dmZLogGlobal.Target.Total.Hours[i].Target;
   end;

   for i := 0 to FShowLast - 1 do begin
      n := GetHour(FStartTime + (1 / 24) * i);
      Str := IntToStr(n);

//      ScoreGrid.Cells[i + 1, 0] := str;

//      if FShowLast > 12 then begin
//         if (start_hour mod 2) = 1 then begin
//            Str := '';
//         end;
//      end;
//
//      if FShowLast > 24 then begin
//         if (start_hour mod 4) <> 0 then begin
//            Str := '';
//         end;
//      end;

      // 横軸目盛ラベル
      hindex := i * 2;
      Chart1.Axes.Bottom.Items.Add(hindex + 0, Str);

      // 時間帯での実績値
      actual_hour_count := 0;
      if GraphStyle = rsOriginal then begin
         actual_hour_count := UpdateGraphOriginal(H + i + 1);
      end
      else if GraphStyle = rsByBand then begin
         actual_hour_count := UpdateGraphByBand(H + i + 1);
      end
      else if GraphStyle = rsByFreqRange then begin
         actual_hour_count := UpdateGraphByRange(H + i + 1);
      end;

      // 時間帯での目標値
      target_hour_count := dmZLogGlobal.Target.Total.Hours[H + i + 1].Target;

      // 縦軸目盛り調整のための値
      actual_total_count := actual_total_count + actual_hour_count;
      target_total_count := target_total_count + target_hour_count;
      hour_peak := Max(hour_peak, actual_hour_count);
      hour_peak := Max(hour_peak, target_hour_count);

      // 実績値累計
      SeriesActualTotals.Add(actual_total_count);

      // 目標値値累計
      SeriesTargetTotals.Add(target_total_count);

      // 横軸目盛ラベル
      Chart1.Axes.Bottom.Items.Add(hindex + 1, ''{Str + 't'});

      // Target QSOs
      FGraphSeries[b19].Add(0);
      FGraphSeries[b35].Add(0);
      FGraphSeries[b7].Add(0);
      FGraphSeries[b10].Add(0);
      FGraphSeries[b14].Add(0);
      FGraphSeries[b18].Add(0);
      FGraphSeries[b21].Add(0);
      FGraphSeries[b24].Add(0);
      FGraphSeries[b28].Add(0);
      FGraphSeries[b50].Add(0);
      FGraphSeries[b144].Add(0);
      FGraphSeries[b430].Add(0);
      FGraphSeries[b1200].Add(0);
      FGraphSeries[b2400].Add(0);
      FGraphSeries[b5600].Add(0);
      FGraphSeries[b10g].Add(0);
      FGraphSeries[bTarget].Add(target_hour_count);

      // 実績値累計
      SeriesActualTotals.Add(actual_total_count);

      // 実績値累計
      SeriesTargetTotals.Add(target_total_count);
   end;

   // ZAQの時間見出し
   InitZaqGridTitle();

   // ZAQ2の時間見出し
   InitZaq2GridTitle();

   with Chart1 do begin
      // 左側目盛りの調整
      Axes.Left.Maximum := ((hour_peak div 10) + 1) * 10;
      if Axes.Left.Maximum <= 10 then begin
         Axes.Left.Increment := 2;
      end
      else begin
         Axes.Left.Increment := 20;
      end;

      // 右側目盛りの調整
      Axes.Right.Maximum := ((Max(actual_total_count, target_total_count) div 50) + 1) * 50;
      if Axes.Right.Maximum <= 50 then begin
         Axes.Right.Increment := 10;
      end
      else begin
         Axes.Right.Increment := 50;
      end;
   end;

   if menuDispAlternating.Checked = True then begin
      TargetToGrid(dmZLogGlobal.Target);
   end
   else begin
      TargetToGrid_type2(dmZLogGlobal.Target);
   end;

   TargetToGrid2(dmZLogGlobal.Target);
end;

function TRateDialogEx.UpdateGraphOriginal(hh: Integer): Integer;
var
   b: TBand;
   part_count: Integer;
   hour_count: Integer;
begin
   hour_count := 0;

   for b := b19 to b10g do begin
      part_count := dmZLogGlobal.Target.Bands[b].Hours[hh].Actual;

      // この時間帯の合計
      hour_count := hour_count + part_count;
   end;

   // Actual QSOs
   FGraphSeries[b19].Add(hour_count);

   for b := b35 to b10g do begin
      FGraphSeries[b].Add(0);
   end;

   FGraphSeries[bTarget].Add(0);

   Result := hour_count;
end;

function TRateDialogEx.UpdateGraphByBand(hh: Integer): Integer;
var
   b: TBand;
   part_count: Integer;
   hour_count: Integer;
begin
   hour_count := 0;

   for b := b19 to b10g do begin
      part_count := dmZLogGlobal.Target.Bands[b].Hours[hh].Actual;

      // グラフデータの追加
      FGraphSeries[b].Add(part_count);

      // この時間帯の合計
      hour_count := hour_count + part_count;
   end;

   FGraphSeries[bTarget].Add(0);

   Result := hour_count;
end;

function TRateDialogEx.UpdateGraphByRange(hh: Integer): Integer;
var
   part_count: Integer;
   hour_count: Integer;
begin
   hour_count := 0;

   // HF(L)
   part_count := dmZLogGlobal.Target.Bands[b19].Hours[hh].Actual +
                 dmZLogGlobal.Target.Bands[b35].Hours[hh].Actual +
                 dmZLogGlobal.Target.Bands[b7].Hours[hh].Actual +
                 dmZLogGlobal.Target.Bands[b10].Hours[hh].Actual;

   // グラフデータの追加
   FGraphSeries[b19].Add(part_count);
   FGraphSeries[b35].Add(0);
   FGraphSeries[b7].Add(0);
   FGraphSeries[b10].Add(0);

   // この時間帯の合計
   hour_count := hour_count + part_count;

   // HF(H)
   part_count := dmZLogGlobal.Target.Bands[b14].Hours[hh].Actual +
                 dmZLogGlobal.Target.Bands[b18].Hours[hh].Actual +
                 dmZLogGlobal.Target.Bands[b21].Hours[hh].Actual +
                 dmZLogGlobal.Target.Bands[b24].Hours[hh].Actual +
                 dmZLogGlobal.Target.Bands[b28].Hours[hh].Actual;

   // グラフデータの追加
   FGraphSeries[b14].Add(part_count);
   FGraphSeries[b18].Add(0);
   FGraphSeries[b21].Add(0);
   FGraphSeries[b24].Add(0);
   FGraphSeries[b28].Add(0);

   // この時間帯の合計
   hour_count := hour_count + part_count;

   // VHF
   part_count := dmZLogGlobal.Target.Bands[b50].Hours[hh].Actual +
                 dmZLogGlobal.Target.Bands[b144].Hours[hh].Actual;

   // グラフデータの追加
   FGraphSeries[b50].Add(part_count);
   FGraphSeries[b144].Add(0);

   // この時間帯の合計
   hour_count := hour_count + part_count;

   // UHF
   part_count := dmZLogGlobal.Target.Bands[b430].Hours[hh].Actual +
                 dmZLogGlobal.Target.Bands[b1200].Hours[hh].Actual +
                 dmZLogGlobal.Target.Bands[b2400].Hours[hh].Actual;

   // グラフデータの追加
   FGraphSeries[b430].Add(part_count);
   FGraphSeries[b1200].Add(0);

   // この時間帯の合計
   hour_count := hour_count + part_count;

   // SHF
   part_count := dmZLogGlobal.Target.Bands[b5600].Hours[hh].Actual +
                 dmZLogGlobal.Target.Bands[b10g].Hours[hh].Actual;

   // グラフデータの追加
   FGraphSeries[b5600].Add(part_count);
   FGraphSeries[b10g].Add(0);
   FGraphSeries[bTarget].Add(0);

   // この時間帯の合計
   hour_count := hour_count + part_count;

   Result := hour_count;
end;

procedure TRateDialogEx.ShowLastComboChange(Sender: TObject);
begin
   FShowLast := StrToIntDef(ShowLastCombo.Items[ShowLastCombo.ItemIndex], 12);
   UpdateGraph();
end;

function TRateDialogEx.GetGraphSeries(b: TBand): TBarSeries;
begin
   Result := FGraphSeries[b];
end;

procedure TRateDialogEx.LoadSettings();
var
   b: TBand;
   i: Integer;
begin
   FGraphStyle := dmZLogGlobal.Settings.FGraphStyle;
   FGraphStartPosition := dmZLogGlobal.Settings.FGraphStartPosition;
   for b := b19 to HiBand do begin
      GraphSeries[b].SeriesColor := dmZLogGlobal.Settings.FGraphBarColor[b];
      GraphSeries[b].Marks.Font.Color := dmZLogGlobal.Settings.FGraphTextColor[b];
   end;
   SetGraphStartPositionUI(FGraphStartPosition);
   menuAchievementRate.Checked := dmZLogGlobal.Settings.FZaqAchievement;
   menuWinLoss.Checked := Not menuAchievementRate.Checked;

   for i := Low(FZaqBgColor) to High(FZaqBgColor) do begin
      FZaqBgColor[i] := dmZLogGlobal.Settings.FZaqBgColor[i];
      FZaqFgColor[i] := dmZLogGlobal.Settings.FZaqFgColor[i];
   end;

   // 折れ線グラフの色
   SeriesActualTotals.SeriesColor := dmZLogGlobal.Settings.FGraphOtherBgColor[0];
   SeriesTargetTotals.SeriesColor := dmZLogGlobal.Settings.FGraphOtherBgColor[1];
end;

procedure TRateDialogEx.menuAchievementRateClick(Sender: TObject);
begin
   TMenuItem(Sender).Checked := True;

   if menuDispAlternating.Checked = True then begin
      TargetToGrid(dmZLogGlobal.Target);
   end
   else begin
      TargetToGrid_type2(dmZLogGlobal.Target);
   end;
   ScoreGrid.Refresh();

   if menuAchievementRate.Checked = True then begin
      ScoreGrid.Cells[0, 35] := '%';
      ScoreGrid.Cells[26, 0] := '%';
   end
   else begin
      ScoreGrid.Cells[0, 35] := SCOREGRID_WINLOSS_L;
      ScoreGrid.Cells[26, 0] := SCOREGRID_WINLOSS_S;
   end;
end;

procedure TRateDialogEx.menuDispAlternatingClick(Sender: TObject);
var
   R, C: Integer;
begin
   TMenuItem(Sender).Checked := True;
   for R := 0 to ScoreGrid.RowCount - 1 do begin
      for C := 0 to ScoreGrid.ColCount - 1 do begin
         ScoreGrid.Cells[C, R] := '';
      end;
   end;

   ScoreGrid.TopRow := 1;
   InitZaqGridTitle();
   if menuDispAlternating.Checked = True then begin
      InitScoreGrid_type1();
      TargetToGrid(dmZLogGlobal.Target);
   end
   else begin
      InitScoreGrid_type2();
      TargetToGrid_type2(dmZLogGlobal.Target);
   end;

   InitScoreGridRowColor();

   ScoreGrid.Refresh();
end;

procedure TRateDialogEx.SaveSettings();
var
   b: TBand;
   i: Integer;
begin
   dmZLogGlobal.Settings.FGraphStyle := GraphStyle;
   dmZLogGlobal.Settings.FGraphStartPosition := GraphStartPosition;
   for b := b19 to HiBand do begin
      dmZLogGlobal.Settings.FGraphBarColor[b] := GraphSeries[b].SeriesColor;
      dmZLogGlobal.Settings.FGraphTextColor[b] := GraphSeries[b].Marks.Font.Color;
   end;
   dmZLogGlobal.Settings.FZaqAchievement := menuAchievementRate.Checked;

   for i := Low(FZaqBgColor) to High(FZaqBgColor) do begin
      dmZLogGlobal.Settings.FZaqBgColor[i] := FZaqBgColor[i];
      dmZLogGlobal.Settings.FZaqFgColor[i] := FZaqFgColor[i];
   end;

   // 折れ線グラフの色
   dmZLogGlobal.Settings.FGraphOtherBgColor[0] := SeriesActualTotals.SeriesColor;
   dmZLogGlobal.Settings.FGraphOtherBgColor[1] := SeriesTargetTotals.SeriesColor;
end;

procedure TRateDialogEx.Refresh();
begin
   Inherited;
   case PageControl1.ActivePageIndex of
      0: Chart1.Refresh();
      1: ScoreGrid.Refresh();
      2: ScoreGrid2.Refresh();
   end;
end;


//
// ZAQグリッドの描画
//
procedure TRateDialogEx.ScoreGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   strText: string;
   t: Integer;
   r: Integer;

   procedure SetCurrentRowColor(C: TCanvas);
   begin
      C.Pen.Style := psSolid;
      C.Pen.Color := FZaqBgColor[0];
      C.Brush.Style := bsSolid;
      C.Brush.Color := FZaqBgColor[0];
   end;

   procedure SetOtherRowColor(C: TCanvas);
   begin
      C.Pen.Style := psSolid;
      C.Pen.Color := FZaqRowBgColor[ARow];
      C.Brush.Style := bsSolid;
      C.Brush.Color := FZaqRowBgColor[ARow];
   end;
begin
   with ScoreGrid.Canvas do begin
      Font.Size := ScoreGrid.Font.Size;
      Font.Name := ScoreGrid.Font.Name;

      if menuDispAlternating.Checked = True then begin
         // 現在バンドの行（１行目）
         r := (Ord(FBand) * 2) + 1;

         // 現在バンドの背景色
         if (ARow = (r + 0)) or
            (ARow = (r + 1)) then begin
            SetCurrentRowColor(ScoreGrid.Canvas);
            Font.Color := FZaqFgColor[0];
            Font.Style := [fsBold];
         end
         else begin  // その他のバンドの背景色
            SetOtherRowColor(ScoreGrid.Canvas);
            Font.Color := FZaqRowFgColor[ARow];
            Font.Style := [];
         end;
      end
      else begin
         // 現在バンドの行
         r := Ord(FBand) + 1;

         // 現在バンドの背景色
         if (ARow = r + 0) then begin
            SetCurrentRowColor(ScoreGrid.Canvas);
            Font.Color := FZaqFgColor[0];
            Font.Style := [fsBold];
         end
         else begin  // その他のバンドの背景色
            SetOtherRowColor(ScoreGrid.Canvas);
            Font.Color := FZaqRowFgColor[ARow];
            Font.Style := [];
         end;
      end;
      FillRect(Rect);

      if ACol = 0 then begin        // バンド名表示
         strText := ScoreGrid.Cells[ACol, ARow];
         TextRect(Rect, strText, [tfLeft, tfVerticalCenter, tfSingleLine]);

         Pen.Color := FZaqBgColor[3];
         Brush.Style := bsClear;
         Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);
      end
      else if ARow = 0 then begin   // タイトル行（１行目）の表示
         // 文字
         strText := ScoreGrid.Cells[ACol, ARow];
         TextRect(Rect, strText, [tfCenter, tfVerticalCenter, tfSingleLine]);

         // grid line
         Pen.Color := FZaqBgColor[3];
         Brush.Style := bsClear;
         Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);
      end
      else if (ARow = 35) or (ACol = 26) then begin   // 合計行(35)、合計列(26)の表示
         // 達成率/WinLoss
         strText := ScoreGrid.Cells[ACol, ARow];

         if menuAchievementRate.Checked = True then begin
            // 80%以上は青表示
            if StrToFloatDef(strText, 0) >= 80 then begin
               Font.Color := clBlue;
            end
            else begin
               Font.Color := clRed;
            end;
         end
         else begin
            // 勝敗0以上は青
            if StrToFloatDef(strText, 0) >= 0 then begin
               Font.Color := clBlue;
            end
            else begin  // 負け越しは赤
               Font.Color := clRed;
            end;
         end;
         Font.Size := 10;

         TextRect(Rect, strText, [tfRight, tfVerticalCenter, tfSingleLine]);

         Pen.Color := FZaqBgColor[3];
         Brush.Style := bsClear;
         Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);
      end
      else begin     // TARGET数、QSO数表示
         t := StrToIntDef(ScoreGrid.Cells[ACol, ARow], 0);
         if t = 0 then begin
            strText := '';
         end
         else begin
            strText := IntToStr(t);
         end;
         TextRect(Rect, strText, [tfRight, tfVerticalCenter, tfSingleLine]);

         // grid line
         Pen.Color := FZaqBgColor[3];
         Brush.Style := bsClear;

         if ScoreGrid.RowHeights[ARow] >= 2 then begin
            Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);
         end;
      end;
   end;
end;

//
// ZAQ2グリッドの描画
//
procedure TRateDialogEx.ScoreGrid2DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   strText: string;
   r: Integer;
   c: Integer;
   Index: Integer;
   nTarget, nActual: Integer;
begin
   strText := ScoreGrid2.Cells[ACol, ARow];
   with ScoreGrid2.Canvas do begin
      Font.Size := ScoreGrid2.Font.Size;
      Font.Name := ScoreGrid2.Font.Name;

      // 現在バンドの行
      r := Ord(FBand) + 1;

      // 現在時刻の列
      c := FNowHour - FStartHour + 1;

      // 現在バンドの背景色
      if (ARow = r) or (ACol = c) then begin
         Pen.Style := psSolid;
         Pen.Color := FZaqBgColor[0];
         Brush.Style := bsSolid;
         Brush.Color := FZaqBgColor[0];
      end
      else begin  // その他のバンドの背景色
         Pen.Style := psSolid;
         Pen.Color := FZaq2RowBgColor[ARow];
         Brush.Style := bsSolid;
         Brush.Color := FZaq2RowBgColor[ARow];
      end;
      FillRect(Rect);

      if ACol = 0 then begin        // バンド名表示
         Font.Color := clBlack;
         TextRect(Rect, strText, [tfLeft, tfVerticalCenter, tfSingleLine]);

         Pen.Color := FZaqBgColor[3];
         Brush.Style := bsClear;
         Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);
      end
      else if ARow = 0 then begin   // タイトル行（１行目）の表示
         Font.Color := clBlack;
         TextRect(Rect, strText, [tfCenter, tfVerticalCenter, tfSingleLine]);
         Pen.Color := FZaqBgColor[3];
         Brush.Style := bsClear;
         Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);
      end
      else begin     // TARGET数、QSO数表示
         Index := Pos('/', strText);
         if Index <= 0 then begin
            nActual := StrToIntDef(strText, 0);
            nTarget := 0;
            if nActual = 0 then begin
               strText := '';
            end
            else begin
               strText := IntToStr(nActual);
            end;
         end
         else begin
            nTarget := StrToIntDef(Copy(strText, Index + 1), 0);
            nActual := StrToIntDef(Copy(strText, 1, Index - 1), 0);

            // 現在時刻の列はactual/targetの表示にする
            if ACol = c then begin
               // strText := IntToStr(nActual) + '/' + IntToStr(Target);
               ScoreGrid2.ColWidths[ACol] := 80;
            end
            else begin
               ScoreGrid2.ColWidths[ACol] := 30;
               Font.Style := [];
               if nActual = 0 then begin
                  strText := '';
               end
               else begin
                  strText := IntToStr(nActual);
               end;
            end;

            if (nTarget = 0) and (nActual = 0) then begin
               strText := '';
            end;
         end;

         if nActual >= 0 then begin
            Font.Color := clBlack;
         end
         else begin
            Font.Color := clRed;
         end;

         if (ARow = r) and (ACol = c) then begin
            Font.Style := [fsBold];
         end
         else begin
            Font.Style := [];
         end;

         if (ACol = c) then begin
            TextRect(Rect, strText, [tfCenter, tfVerticalCenter, tfSingleLine]);
         end
         else begin
            TextRect(Rect, strText, [tfRight, tfVerticalCenter, tfSingleLine]);
         end;

         // grid line
         Pen.Color := FZaqBgColor[3];
         Brush.Style := bsClear;

         if ScoreGrid2.RowHeights[ARow] >= 2 then begin
            Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);
         end;
      end;
   end;
end;

procedure TRateDialogEx.ScoreGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
   CanSelect := False;
end;

procedure TRateDialogEx.ScoreGridTopLeftChanged(Sender: TObject);
begin
   TStringGrid(Sender).Refresh();
end;

procedure TRateDialogEx.SetGraphStyle(v: TQSORateStyle);
begin
   FGraphStyle := v;
   UpdateGraph();
end;

procedure TRateDialogEx.SetGraphStartPosition(v: TQSORateStartPosition);
begin
   SetGraphStartPositionUI(v);
   FGraphStartPosition := v;
   UpdateGraph();
end;

procedure TRateDialogEx.SetGraphStartPositionUI(v: TQSORateStartPosition);
var
   proc: TNotifyEvent;
begin
   proc := radioOriginFirstQSO.OnClick;
   radioOriginFirstQSO.OnClick := nil;
   radioOriginCurrentTime.OnClick := nil;
   radioOriginLastQSO.OnClick := nil;
   case v of
      spFirstQSO:    radioOriginFirstQSO.Checked := True;
      spCurrentTime: radioOriginCurrentTime.Checked := True;
      spLastQSO:     radioOriginLastQSO.Checked := True;
   end;
   radioOriginFirstQSO.OnClick := proc;
   radioOriginCurrentTime.OnClick := proc;
   radioOriginLastQSO.OnClick := proc;
end;

procedure TRateDialogEx.InitZaqGridTitle();
var
   i, n: Integer;
begin
   FStartHour := GetHour(FOriginTime);
   for i := 0 to 23 do begin
      n := FStartHour + i;
      if n >= 24 then begin
         n := n - 24;
      end;
      ScoreGrid.Cells[i + 1, 0] := IntToStr(n);
   end;
end;

procedure TRateDialogEx.InitZaq2GridTitle();
var
   i, n: Integer;
begin
   FNowHour := GetHour(Now);
   if FNowHour < FStartHour then begin
      FNowHour := FNowHour + FStartHour + (24 - FStartHour);
   end;
   for i := 0 to (FNowHour - FStartHour) do begin
      n := FStartHour + i;
      if n >= 24 then begin
         n := n - 24;
      end;
      ScoreGrid2.Cells[i + 1, 0] := IntToStr(n);
   end;

   if (FNowHour - FStartHour) < 23 then begin
      ScoreGrid2.Cells[(FNowHour - FStartHour) + 1 + 1, 0] := SCOREGRID_DIFF2;
   end;
end;

procedure TRateDialogEx.InitScoreGrid();
begin
   if menuDispAlternating.Checked = True then begin
      InitScoreGrid_type1();
   end
   else begin
      InitScoreGrid_type2();
   end;

   InitScoreGrid2();

   InitScoreGridRowColor();
end;

procedure TRateDialogEx.InitScoreGridRowColor();
var
   R: Integer;
   n: Integer;
begin
   // ZAQ
   n := 0;
   for R := Low(FZaqRowBgColor) to High(FZaqRowBgColor) do begin
      if ScoreGrid.RowHeights[R] = -1 then begin
         Continue;
      end;

      FZaqRowBgColor[R] := FZaqBgColor[n + 1];
      FZaqRowFgColor[R] := FZaqFgColor[n + 1];
      Inc(n);
      n := n and 1;
   end;

   // ZAQ2
   n := 0;
   for R := Low(FZaq2RowBgColor) to High(FZaq2RowBgColor) do begin
      if ScoreGrid2.RowHeights[R] = -1 then begin
         Continue;
      end;

      FZaq2RowBgColor[R] := FZaqBgColor[n + 1];
      FZaq2RowFgColor[R] := FZaqFgColor[n + 1];
      Inc(n);
      n := n and 1;
   end;
end;

procedure TRateDialogEx.InitScoreGrid_type1();
var
   i: Integer;
   b: TBand;
   R: Integer;
begin
   ScoreGrid.Cells[0, 1] := MHzString[b19];
   ScoreGrid.Cells[0, 2] := '';
   ScoreGrid.Cells[0, 3] := MHzString[b35];
   ScoreGrid.Cells[0, 4] := '';
   ScoreGrid.Cells[0, 5] := MHzString[b7];
   ScoreGrid.Cells[0, 6] := '';
   ScoreGrid.Cells[0, 7] := MHzString[b10];
   ScoreGrid.Cells[0, 8] := '';
   ScoreGrid.Cells[0, 9] := MHzString[b14];
   ScoreGrid.Cells[0, 10] := '';
   ScoreGrid.Cells[0, 11] := MHzString[b18];
   ScoreGrid.Cells[0, 12] := '';
   ScoreGrid.Cells[0, 13] := MHzString[b21];
   ScoreGrid.Cells[0, 14] := '';
   ScoreGrid.Cells[0, 15] := MHzString[b24];
   ScoreGrid.Cells[0, 16] := '';
   ScoreGrid.Cells[0, 17] := MHzString[b28];
   ScoreGrid.Cells[0, 18] := '';
   ScoreGrid.Cells[0, 19] := MHzString[b50];
   ScoreGrid.Cells[0, 20] := '';
   ScoreGrid.Cells[0, 21] := MHzString[b144];
   ScoreGrid.Cells[0, 22] := '';
   ScoreGrid.Cells[0, 23] := MHzString[b430];
   ScoreGrid.Cells[0, 24] := '';
   ScoreGrid.Cells[0, 25] := MHzString[b1200];
   ScoreGrid.Cells[0, 26] := '';
   ScoreGrid.Cells[0, 27] := MHzString[b2400];
   ScoreGrid.Cells[0, 28] := '';
   ScoreGrid.Cells[0, 29] := MHzString[b5600];
   ScoreGrid.Cells[0, 30] := '';
   ScoreGrid.Cells[0, 31] := MHzString[b10g];
   ScoreGrid.Cells[0, 32] := '';
   ScoreGrid.Cells[0, 33] := SCOREGRID_TOTAL;
   ScoreGrid.Cells[0, 34] := '';
   ScoreGrid.Cells[0, 35] := '%';

   for i := 1 to 24 do begin
//      ScoreGrid.Cells[i, 0] := '';
      ScoreGrid.ColWidths[i] := 42;
   end;
   ScoreGrid.Cells[25, 0] := SCOREGRID_TOTAL;
   ScoreGrid.ColWidths[25] := 60;
   ScoreGrid.Cells[26, 0] := '%';
   ScoreGrid.ColWidths[26] := 50;

   for b := b19 to b10g do begin
      R := Ord(b) * 2;
      if dmZLogGlobal.Settings._activebands[b] = True then begin
         ScoreGrid.RowHeights[R + 1] := 24;
         ScoreGrid.RowHeights[R + 2] := 24;
      end
      else begin
         ScoreGrid.RowHeights[R + 1] := -1;
         ScoreGrid.RowHeights[R + 2] := -1;
      end;
   end;
end;

procedure TRateDialogEx.InitScoreGrid_type2();
var
   i: Integer;
   b: TBand;
   R: Integer;
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
   ScoreGrid.Cells[0, 17] := SCOREGRID_TOTAL;

   ScoreGrid.Cells[0, 18] := MHzString[b19];
   ScoreGrid.Cells[0, 19] := MHzString[b35];
   ScoreGrid.Cells[0, 20] := MHzString[b7];
   ScoreGrid.Cells[0, 21] := MHzString[b10];
   ScoreGrid.Cells[0, 22] := MHzString[b14];
   ScoreGrid.Cells[0, 23] := MHzString[b18];
   ScoreGrid.Cells[0, 24] := MHzString[b21];
   ScoreGrid.Cells[0, 25] := MHzString[b24];
   ScoreGrid.Cells[0, 26] := MHzString[b28];
   ScoreGrid.Cells[0, 27] := MHzString[b50];
   ScoreGrid.Cells[0, 28] := MHzString[b144];
   ScoreGrid.Cells[0, 29] := MHzString[b430];
   ScoreGrid.Cells[0, 30] := MHzString[b1200];
   ScoreGrid.Cells[0, 31] := MHzString[b2400];
   ScoreGrid.Cells[0, 32] := MHzString[b5600];
   ScoreGrid.Cells[0, 33] := MHzString[b10g];

   ScoreGrid.Cells[0, 34] := SCOREGRID_TOTAL;
   ScoreGrid.Cells[0, 35] := '%';

   for i := 1 to 24 do begin
//      ScoreGrid.Cells[i, 0] := '';
      ScoreGrid.ColWidths[i] := 42;
   end;
   ScoreGrid.Cells[25, 0] := SCOREGRID_TOTAL;
   ScoreGrid.ColWidths[25] := 60;
   ScoreGrid.Cells[26, 0] := '%';
   ScoreGrid.ColWidths[26] := 50;

   // 使用しないバンド非表示(actual)
   R := 1;
   for b := b19 to b10g do begin
      if dmZLogGlobal.Settings._activebands[b] = True then begin
         ScoreGrid.RowHeights[R] := 24;
      end
      else begin
         ScoreGrid.RowHeights[R] := -1;
      end;
      Inc(R);
   end;

   // 合計行分進める
   Inc(R);

   // 使用しないバンド非表示(target)
   for b := b19 to b10g do begin
      if dmZLogGlobal.Settings._activebands[b] = True then begin
         ScoreGrid.RowHeights[R] := 24;
      end
      else begin
         ScoreGrid.RowHeights[R] := -1;
      end;
      Inc(R);
   end;
end;

// ZAQ2用
procedure TRateDialogEx.InitScoreGrid2();
var
   i: Integer;
   b: TBand;
   R: Integer;
begin
   // 行見出し
   ScoreGrid2.Cells[0, 1] := MHzString[b19];
   ScoreGrid2.Cells[0, 2] := MHzString[b35];
   ScoreGrid2.Cells[0, 3] := MHzString[b7];
   ScoreGrid2.Cells[0, 4] := MHzString[b10];
   ScoreGrid2.Cells[0, 5] := MHzString[b14];
   ScoreGrid2.Cells[0, 6] := MHzString[b18];
   ScoreGrid2.Cells[0, 7] := MHzString[b21];
   ScoreGrid2.Cells[0, 8] := MHzString[b24];
   ScoreGrid2.Cells[0, 9] := MHzString[b28];
   ScoreGrid2.Cells[0, 10] := MHzString[b50];
   ScoreGrid2.Cells[0, 11] := MHzString[b144];
   ScoreGrid2.Cells[0, 12] := MHzString[b430];
   ScoreGrid2.Cells[0, 13] := MHzString[b1200];
   ScoreGrid2.Cells[0, 14] := MHzString[b2400];
   ScoreGrid2.Cells[0, 15] := MHzString[b5600];
   ScoreGrid2.Cells[0, 16] := MHzString[b10g];
   ScoreGrid2.Cells[0, 17] := SCOREGRID_TOTAL;
   ScoreGrid2.Cells[0, 18] := SCOREGRID_CUMULATIVE;

   // 列見出し
   for i := 1 to 24 do begin
      ScoreGrid2.Cells[i, 0] := '';
      ScoreGrid2.ColWidths[i] := 30;
   end;

   ScoreGrid2.Cells[25, 0] := SCOREGRID_TOTAL;
   ScoreGrid2.ColWidths[25] := 50;
   ScoreGrid2.Cells[26, 0] := SCOREGRID_TARGET;
   ScoreGrid2.ColWidths[26] := 50;
   ScoreGrid2.Cells[27, 0] := SCOREGRID_DIFF;
   ScoreGrid2.ColWidths[27] := 50;

   // 行高さ
   for b := b19 to b10g do begin
      R := Ord(b);
      if dmZLogGlobal.Settings._activebands[b] = True then begin
         ScoreGrid2.RowHeights[R + 1] := 24;
      end
      else begin
         ScoreGrid2.RowHeights[R + 1] := -1;
      end;
   end;
end;

procedure TRateDialogEx.TargetToGrid(ATarget: TContestTarget);
var
   b: TBand;
   i: Integer;
   R: Integer;
begin
   for b := b19 to b10g do begin
      R := (Ord(b) * 2) + 1;
      for i := 1 to 24 do begin
         ScoreGrid.Cells[i, R + 0] := IntToStr(ATarget.Bands[b].Hours[i].Target);
         ScoreGrid.Cells[i, R + 1] := IntToStr(ATarget.Bands[b].Hours[i].Actual);
         ScoreGrid.Cells[i, 33]       := IntToStr(ATarget.Total.Hours[i].Target);
         ScoreGrid.Cells[i, 34]       := IntToStr(ATarget.Total.Hours[i].Actual);
         if menuAchievementRate.Checked = True then begin
            ScoreGrid.Cells[i, 35]    := FloatToStrF(ATarget.Total.Hours[i].Rate, ffFixed, 1000, 1);
         end
         else begin
            ScoreGrid.Cells[i, 35]    := IntToStr(ATarget.Total.Hours[i].Actual - ATarget.Total.Hours[i].Target);
         end;
      end;
      ScoreGrid.Cells[25, R + 0]   := IntToStr(ATarget.Bands[b].Total.Target);
      ScoreGrid.Cells[25, R + 1]   := IntToStr(ATarget.Bands[b].Total.Actual);

      if menuAchievementRate.Checked = True then begin
         ScoreGrid.Cells[26, R + 1]   := FloatToStrF(ATarget.Bands[b].Total.Rate, ffFixed, 1000, 1);
      end
      else begin
         ScoreGrid.Cells[26, R + 1]   := IntToStr(ATarget.Bands[b].Total.Actual - ATarget.Bands[b].Total.Target);
      end;
   end;

   ScoreGrid.Cells[25, 33]   := IntToStr(ATarget.TotalTotal.Target);
   ScoreGrid.Cells[25, 34]   := IntToStr(ATarget.TotalTotal.Actual);
   if menuAchievementRate.Checked = True then begin
      ScoreGrid.Cells[25, 35]   := FloatToStrF(ATarget.TotalTotal.Rate, ffFixed, 1000, 1);
      ScoreGrid.Cells[26, 34]   := FloatToStrF(ATarget.TotalTotal.Rate, ffFixed, 1000, 1);
   end
   else begin
      ScoreGrid.Cells[25, 35]   := IntToStr(ATarget.TotalTotal.Actual - ATarget.TotalTotal.Target);
      ScoreGrid.Cells[26, 34]   := IntToStr(ATarget.TotalTotal.Actual - ATarget.TotalTotal.Target);
   end;

   ScoreGrid.Refresh();
end;

// ZAQの上段：actual，下段：target表示
procedure TRateDialogEx.TargetToGrid_type2(ATarget: TContestTarget);
var
   b: TBand;
   i: Integer;
   R: Integer;
begin
   R := 1;

   // まずはactual
   for b := b19 to b10g do begin
      for i := 1 to 24 do begin
         ScoreGrid.Cells[i, R] := IntToStr(ATarget.Bands[b].Hours[i].Actual);
      end;

      ScoreGrid.Cells[25, R]   := IntToStr(ATarget.Bands[b].Total.Actual);

      if menuAchievementRate.Checked = True then begin
         ScoreGrid.Cells[26, R]   := FloatToStrF(ATarget.Bands[b].Total.Rate, ffFixed, 1000, 1);
      end
      else begin
         ScoreGrid.Cells[26, R]   := IntToStr(ATarget.Bands[b].Total.Actual - ATarget.Bands[b].Total.Target);
      end;

      Inc(R);
   end;

   // actualの合計行
   for i := 1 to 24 do begin
      ScoreGrid.Cells[i, R]       := IntToStr(ATarget.Total.Hours[i].Actual);
   end;
   Inc(R);

   // target
   for b := b19 to b10g do begin
      for i := 1 to 24 do begin
         ScoreGrid.Cells[i, R] := IntToStr(ATarget.Bands[b].Hours[i].Target);
      end;

      ScoreGrid.Cells[25, R]   := '';
      ScoreGrid.Cells[26, R]   := '';

      Inc(R);
   end;

   // targetの合計行
   for i := 1 to 24 do begin
      ScoreGrid.Cells[i, R]       := IntToStr(ATarget.Total.Hours[i].Target);
   end;
   Inc(R);

   // rate or win/loss
   for i := 1 to 24 do begin
      if menuAchievementRate.Checked = True then begin
         ScoreGrid.Cells[i, R]    := FloatToStrF(ATarget.Total.Hours[i].Rate, ffFixed, 1000, 1);
      end
      else begin
         ScoreGrid.Cells[i, R]    := IntToStr(ATarget.Total.Hours[i].Actual - ATarget.Total.Hours[i].Target);
      end;
   end;
   Inc(R);

   ScoreGrid.Cells[25, 33]   := IntToStr(ATarget.TotalTotal.Target);
   ScoreGrid.Cells[25, 34]   := IntToStr(ATarget.TotalTotal.Actual);
   if menuAchievementRate.Checked = True then begin
      ScoreGrid.Cells[25, 35]   := FloatToStrF(ATarget.TotalTotal.Rate, ffFixed, 1000, 1);
      ScoreGrid.Cells[26, 34]   := FloatToStrF(ATarget.TotalTotal.Rate, ffFixed, 1000, 1);
   end
   else begin
      ScoreGrid.Cells[25, 35]   := IntToStr(ATarget.TotalTotal.Actual - ATarget.TotalTotal.Target);
      ScoreGrid.Cells[26, 34]   := IntToStr(ATarget.TotalTotal.Actual - ATarget.TotalTotal.Target);
   end;

   ScoreGrid.Refresh();
end;

//
// ZAQ2
//
procedure TRateDialogEx.TargetToGrid2(ATarget: TContestTarget);
var
   b: TBand;
   i: Integer;
   R: Integer;
   a: Integer;
   t: Integer;
   h: Integer;
begin
   for b := b19 to b10g do begin
      // 行位置
      R := Ord(b) + 1;

      // 列位置MAX
      h := (FNowHour - FStartHour) + 1;

      // 各時間の列
      for i := 1 to h do begin
         ScoreGrid2.Cells[i, R]  := IntToStr(ATarget.Bands[b].Hours[i].Actual) + '/' +     // 実績値
                                    IntToStr(ATarget.Bands[b].Hours[i].Target);
         ScoreGrid2.Cells[i, 17] := IntToStr(ATarget.Total.Hours[i].Actual) + '/' +        // 合計
                                    IntToStr(ATarget.Total.Hours[i].Target);
         ScoreGrid2.Cells[i, 18] := IntToStr(ATarget.Cumulative.Hours[i].Actual) + '/' +   // 累計
                                    IntToStr(ATarget.Cumulative.Hours[i].Target);
      end;

      // (+/-)
      if h < 24 then begin
         a := ATarget.Bands[b].Total2(h).Actual;
         t := ATarget.Bands[b].Total2(h).Target;
         ScoreGrid2.Cells[h + 1, R] := IntToStr(a - t);        // 実績の差

         a := ATarget.Total.Total2(h).Actual;
         t := ATarget.Total.Total2(h).Target;
         ScoreGrid2.Cells[h + 1, 17] := IntToStr(a - t);       // 合計の差
      end;

      // 合計列
      ScoreGrid2.Cells[25, R] := IntToStr(ATarget.Bands[b].Total.Actual);

      // Target
      ScoreGrid2.Cells[26, R] := IntToStr(ATarget.Bands[b].Total.Target);

      // Diff.
      ScoreGrid2.Cells[27, R] := IntToStr(ATarget.Bands[b].Total.Actual - ATarget.Bands[b].Total.Target);
   end;

   // Total
   ScoreGrid2.Cells[25, 17]   := IntToStr(ATarget.TotalTotal.Actual);

   // Target
   ScoreGrid2.Cells[26, 17]   := IntToStr(ATarget.TotalTotal.Target);

   // Diff.
   ScoreGrid2.Cells[27, 17]   := IntToStr(ATarget.TotalTotal.Actual - ATarget.TotalTotal.Target);

   ScoreGrid2.Refresh();
end;

procedure TRateDialogEx.SetBand(b: TBand);
begin
   FBand := b;

   if menuDispAlternating.Checked = True then begin
      ScoreGrid.TopRow := Ord(b) * 2 + 1;
   end
   else begin
      ScoreGrid.TopRow := 1;
   end;
   ScoreGrid.Refresh();
   ScoreGrid2.Refresh();
end;

function TRateDialogEx.GetZaqBgColor(n: Integer): TColor;
begin
   Result := FZaqBgColor[n];
end;

procedure TRateDialogEx.SetZaqBgColor(n: Integer; c: TColor);
begin
   FZaqBgColor[n] := c;
end;

function TRateDialogEx.GetZaqFgColor(n: Integer): TColor;
begin
   Result := FZaqFgColor[n];
end;

procedure TRateDialogEx.SetZaqFgColor(n: Integer; c: TColor);
begin
   FZaqFgColor[n] := c;
end;

function TRateDialogEx.GetOtherBgColor(n: Integer): TColor;
begin
   case n of
      0: Result := SeriesActualTotals.Color;
      1: Result := SeriesTargetTotals.Color;
      else Result := clRed;
   end;
end;

procedure TRateDialogEx.SetOtherBgColor(n: Integer; c: TColor);
begin
   case n of
      0: SeriesActualTotals.Color := c;
      1: SeriesTargetTotals.Color := c;
   end;
end;

function TRateDialogEx.GetOtherFgColor(n: Integer): TColor;
begin
   case n of
      0: Result := SeriesActualTotals.Marks.Color;
      1: Result := SeriesTargetTotals.Marks.Color;
      else Result := clBlack;
   end;
end;

procedure TRateDialogEx.SetOtherFgColor(n: Integer; c: TColor);
begin
   case n of
      0: SeriesActualTotals.Marks.Color := c;
      1: SeriesTargetTotals.Marks.Color := c;
   end;
end;

end.
