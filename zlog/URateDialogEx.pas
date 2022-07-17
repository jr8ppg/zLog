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
    SeriesTotalQSOs: TLineSeries;
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
    procedure CreateParams(var Params: TCreateParams); override;
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
  private
    { Private declarations }
    FBand: TBand;
    FLast10QsoRateMax: Double;
    FLast100QsoRateMax: Double;
    FShowLast: Integer;      { Show last x hours. default = 12}
    FGraphSeries: array[b19..bTarget] of TBarSeries;
    FGraphStyle: TQSORateStyle;
    FGraphStartPosition: TQSORateStartPosition;
    function UpdateGraphOriginal(hh: Integer): Integer;
    function UpdateGraphByBand(hh: Integer): Integer;
    function UpdateGraphByRange(hh: Integer): Integer;
    function GetGraphSeries(b: TBand): TBarSeries;
    procedure SetGraphStyle(v: TQSORateStyle);
    procedure SetGraphStartPosition(v: TQSORateStartPosition);
    procedure SetGraphStartPositionUI(v: TQSORateStartPosition);
    procedure TargetToGrid(ATarget: TContestTarget);
    procedure SetBand(b: TBand);
  public
    { Public declarations }
    procedure UpdateGraph;
    procedure InitScoreGrid();
    property GraphSeries[b: TBand]: TBarSeries read GetGraphSeries;
    property GraphStyle: TQSORateStyle read FGraphStyle write SetGraphStyle;
    property GraphStartPosition: TQSORateStartPosition read FGraphStartPosition write SetGraphStartPosition;
    procedure LoadSettings();
    procedure SaveSettings();
    property Band: TBand read FBand write SetBand;
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TRateDialogEx.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

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

   with SeriesTotalQSOs do begin
      Clear();
      VertAxis := aRightAxis;
   end;

   InitScoreGrid();

   LoadSettings();
end;

procedure TRateDialogEx.FormDestroy(Sender: TObject);
begin
//   SaveSettings();
end;

procedure TRateDialogEx.FormShow(Sender: TObject);
begin
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
end;

procedure TRateDialogEx.TimerTimer(Sender: TObject);
begin
   Timer.Enabled := False;
   try
      if Visible = False then begin
         Exit;
      end;

      dmZLogGlobal.Target.UpdateLastRate();
      Last10.Caption := Format('%3.2f', [dmZLogGlobal.Target.Last10QsoRate]) + ' QSOs/hr';
      Max10.Caption := 'max ' + Format('%3.2f', [dmZLogGlobal.Target.Last10QsoRateMax]) + ' QSOs/hr';
      Last100.Caption := Format('%3.2f', [dmZLogGlobal.Target.Last100QsoRate]) + ' QSOs/hr';
      Max100.Caption := 'max ' + Format('%3.2f', [dmZLogGlobal.Target.Last100QsoRateMax]) + ' QSOs/hr';
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
   hour_count: Integer;
   total_count: Integer;
   hour_peak: Integer;
   Str: string;
   _start: TDateTime;
   origin: TDateTime;
   diff: TDateTime;
   H, M, S, ms: Word;
   i: Integer;
   n: Integer;
   hindex: Integer;
   b: TBand;
   start_hour: Integer;

   function CalcStartTime(dt: TDateTime): TDateTime;
   begin
//      Result := dt - (FShowLast - 1) / 24;
      Result := IncHour(dt, (FShowLast * -1) + 1);
   end;
begin
   for b := b19 to bTarget do begin
      FGraphSeries[b].Clear();
   end;
   SeriesTotalQSOs.Clear();
   Chart1.Axes.Bottom.Items.Clear();

   // 基準時刻を求める
   if Log.TotalQSO = 0 then begin
      _start := CalcStartTime( CurrentTime() );
      origin := _start;
   end
   else begin
      case GraphStartPosition of
         spFirstQSO:    _start := Log.QsoList[1].Time;
         spCurrentTime: _start := CalcStartTime( CurrentTime() );
         spLastQSO:     _start := CalcStartTime( Log.QsoList[Log.TotalQSO].Time );
         else           _start := CalcStartTime( CurrentTime() );
      end;

      origin := Log.QsoList[1].Time;
   end;

   DecodeTime(origin, H, M, S, ms);
   origin := Int(origin) + EncodeTime(H, 0, 0, 0);

   DecodeTime(_start, H, M, S, ms);
   _start := Int(_start) + EncodeTime(H, 0, 0, 0);

   // バンド別時間別の集計データを作成
   dmZLogGlobal.Target.UpdateActualQSOs(origin);

   if (_start >= origin) then begin
      diff := _start - origin;
      DecodeTime(diff, H, M, S, ms);
   end
   else begin
      _start := Log.QsoList[1].Time;
      DecodeTime(_start, H, M, S, ms);
      _start := Int(_start) + EncodeTime(H, 0, 0, 0);
      H := 0;
   end;

   // グラフに展開
   total_count := dmZLogGlobal.Target.BeforeGraphCount;
   hour_peak := 0;
   for i := 0 to FShowLast - 1 do begin
      start_hour := GetHour(_start + (1 / 24) * i);
      Str := IntToStr(start_hour);

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

      hour_count := 0;
      if GraphStyle = rsOriginal then begin
         hour_count := UpdateGraphOriginal(H + i + 1);
      end
      else if GraphStyle = rsByBand then begin
         hour_count := UpdateGraphByBand(H + i + 1);
      end
      else if GraphStyle = rsByFreqRange then begin
         hour_count := UpdateGraphByRange(H + i + 1);
      end;

      // 縦軸目盛り調整のための値
      total_count := total_count + hour_count;
      hour_peak := Max(hour_peak, hour_count);
      hour_peak := Max(hour_peak, dmZLogGlobal.Target.Total.Hours[H + i + 1].Target);

      // 累計
      SeriesTotalQSOs.Add(total_count);

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
      FGraphSeries[bTarget].Add(dmZLogGlobal.Target.Total.Hours[H + i + 1].Target);

      // 累計
      SeriesTotalQSOs.Add(total_count);
   end;

   // ZAQの時間見出し
   start_hour := GetHour(origin);
   for i := 0 to 23 do begin
      n := start_hour + i;
      if n >= 24 then begin
         n := n - 24;
      end;
      ScoreGrid.Cells[i + 1, 0] := IntToStr(n);
   end;

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
      Axes.Right.Maximum := ((total_count div 50) + 1) * 50;
      if Axes.Right.Maximum <= 50 then begin
         Axes.Right.Increment := 10;
      end
      else begin
         Axes.Right.Increment := 50;
      end;
   end;

   TargetToGrid(dmZLogGlobal.Target);
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
begin
   FGraphStyle := dmZLogGlobal.Settings.FGraphStyle;
   FGraphStartPosition := dmZLogGlobal.Settings.FGraphStartPosition;
   for b := b19 to HiBand do begin
      GraphSeries[b].SeriesColor := dmZLogGlobal.Settings.FGraphBarColor[b];
      GraphSeries[b].Marks.Font.Color := dmZLogGlobal.Settings.FGraphTextColor[b];
   end;
   SetGraphStartPositionUI(FGraphStartPosition);
   menuAchievementRate.Checked := dmZLogGlobal.Settings.FZaqAchievement;
end;

procedure TRateDialogEx.menuAchievementRateClick(Sender: TObject);
begin
   TargetToGrid(dmZLogGlobal.Target);
   ScoreGrid.Refresh();

   if menuAchievementRate.Checked = True then begin
      ScoreGrid.Cells[0, 35] := '%';
      ScoreGrid.Cells[26, 0] := '%';
   end
   else begin
      ScoreGrid.Cells[0, 35] := 'Win/Loss';
      ScoreGrid.Cells[26, 0] := 'W/L';
   end;
end;

procedure TRateDialogEx.SaveSettings();
var
   b: TBand;
begin
   dmZLogGlobal.Settings.FGraphStyle := GraphStyle;
   dmZLogGlobal.Settings.FGraphStartPosition := GraphStartPosition;
   for b := b19 to HiBand do begin
      dmZLogGlobal.Settings.FGraphBarColor[b] := GraphSeries[b].SeriesColor;
      dmZLogGlobal.Settings.FGraphTextColor[b] := GraphSeries[b].Marks.Font.Color;
   end;
   dmZLogGlobal.Settings.FZaqAchievement := menuAchievementRate.Checked;
end;

//
// ZAQグリッドの描画
//
procedure TRateDialogEx.ScoreGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   strText: string;
   t: Integer;
   r: Integer;
begin
   with ScoreGrid.Canvas do begin
      Font.Size := ScoreGrid.Font.Size;
      Font.Name := ScoreGrid.Font.Name;

      // 現在バンドの行（１行目）
      r := (Ord(FBand) * 2) + 1;

      // 現在バンドの背景色
      if (ARow = (r + 0)) or
         (ARow = (r + 1)) then begin
         Pen.Style := psSolid;
         Pen.Color := RGB($9F, $FF, $FF);
         Brush.Style := bsSolid;
         Brush.Color := RGB($9F, $FF, $FF);
      end
      else begin  // その他のバンドの背景色
         Pen.Style := psSolid;
         Pen.Color := ScoreGrid.Color;
         Brush.Style := bsSolid;
         Brush.Color := ScoreGrid.Color;
      end;
      FillRect(Rect);

      if ACol = 0 then begin        // バンド名表示
         strText := ScoreGrid.Cells[ACol, ARow];
         Font.Color := clBlack;
         TextRect(Rect, strText, [tfLeft, tfVerticalCenter, tfSingleLine]);

         Pen.Color := RGB(220, 220, 220);
         Brush.Style := bsClear;
         Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);
      end
      else if ARow = 0 then begin   // タイトル行（１行目）の表示
         strText := ScoreGrid.Cells[ACol, ARow];
         Font.Color := clBlack;
         TextRect(Rect, strText, [tfCenter, tfVerticalCenter, tfSingleLine]);
         Pen.Color := RGB(220, 220, 220);
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

         Pen.Color := RGB(220, 220, 220);
         Brush.Style := bsClear;
         Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);
      end
      else begin     // TARGET数、QSO数表示
//         t := dmZLogGlobal.Target.Bands[TBand(ARow - 1)].Hours[ACol].Target;
         t := StrToIntDef(ScoreGrid.Cells[ACol, ARow], 0);

//         if checkShowZero.Checked = True then begin
//            strText := IntToStr(t);
//         end
//         else begin
            if t = 0 then begin
               strText := '';
            end
            else begin
               strText := IntToStr(t);
            end;
//         end;
         Font.Color := clBlack;
         TextRect(Rect, strText, [tfRight, tfVerticalCenter, tfSingleLine]);

         // grid line
         Pen.Color := RGB(220, 220, 220);
         Brush.Style := bsClear;

         if ScoreGrid.RowHeights[ARow] >= 2 then begin
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
   ScoreGrid.Refresh();
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

procedure TRateDialogEx.InitScoreGrid();
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
   ScoreGrid.Cells[0, 33] := 'Total';
   ScoreGrid.Cells[0, 34] := '';
   ScoreGrid.Cells[0, 35] := '%';

   for i := 1 to 24 do begin
      ScoreGrid.Cells[i, 0] := '';
      ScoreGrid.ColWidths[i] := 42;
   end;
   ScoreGrid.Cells[25, 0] := 'Total';
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

procedure TRateDialogEx.SetBand(b: TBand);
begin
   FBand := b;
   ScoreGrid.TopRow := Ord(b) * 2 + 1;
   ScoreGrid.Refresh();
end;

end.
