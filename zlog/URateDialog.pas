unit URateDialog;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, System.Math, System.DateUtils,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.Series, UOptions, UzLogGlobal, UzLogQSO, UzLogConst;

type
  TRateDialog = class(TForm)
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
  private
    { Private declarations }
    FLast10QsoRateMax: Double;
    FLast100QsoRateMax: Double;
    FShowLast: Integer;      { Show last x hours. default = 12}
    FGraphSeries: array[b19..b10g] of TBarSeries;
    FGraphStyle: TQSORateStyle;
    FGraphStartPosition: TQSORateStartPosition;
    function GetGraphSeries(b: TBand): TBarSeries;
    procedure SetGraphStyle(v: TQSORateStyle);
    procedure SetGraphStartPosition(v: TQSORateStartPosition);
    procedure SetGraphStartPositionUI(v: TQSORateStartPosition);
  public
    { Public declarations }
    procedure UpdateGraph;
    property GraphSeries[b: TBand]: TBarSeries read GetGraphSeries;
    property GraphStyle: TQSORateStyle read FGraphStyle write SetGraphStyle;
    property GraphStartPosition: TQSORateStartPosition read FGraphStartPosition write SetGraphStartPosition;
    procedure LoadSettings();
    procedure SaveSettings();
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TRateDialog.FormCreate(Sender: TObject);
var
   b: TBand;
begin
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

   LoadSettings();
end;

procedure TRateDialog.FormDestroy(Sender: TObject);
begin
   SaveSettings();
end;

procedure TRateDialog.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);

   UpdateGraph;
   Timer.Enabled := True;
end;

procedure TRateDialog.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

procedure TRateDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Timer.Enabled := False;

   MainForm.DelTaskbar(Handle);
end;

procedure TRateDialog.TimerTimer(Sender: TObject);
var
   Last: TDateTime;
   Diff, Rate: double;
   i: LongInt;
   mytx, k: integer;
   aQSO: TQSO;
begin
   Timer.Enabled := False;
   try
      if Visible = False then begin
         Exit;
      end;

      i := Log.TotalQSO;
      if i < 10 then begin
         Exit;
      end;

      mytx := dmZlogGlobal.TXNr;

      k := 0;
      repeat
         aQSO := Log.QsoList[i];
         if aQSO.TX = mytx then begin
            inc(k);
         end;

         dec(i)
      until (i = 1) or (k = 10);

      if (k = 10) then begin
         Last := aQSO.time;
         Diff := (CurrentTime - Last) * 24.0;
         Rate := 10 / Diff;

         FLast10QsoRateMax := Max(FLast10QsoRateMax, Rate);

         Last10.Caption := Format('%3.2f', [Rate]) + ' QSOs/hr';
         Max10.Caption := 'max ' + Format('%3.2f', [FLast10QsoRateMax]) + ' QSOs/hr';
      end
      else begin
         Exit;
      end;

      i := Log.TotalQSO;
      k := 0;
      repeat
         aQSO := Log.QsoList[i];
         if aQSO.TX = mytx then begin
            inc(k);
         end;
         dec(i)
      until (i = 1) or (k = 100);

      if k = 100 then begin
         Last := aQSO.time;
         Diff := (CurrentTime - Last) * 24.0;
         Rate := 100 / Diff;

         FLast100QsoRateMax := Max(FLast100QsoRateMax, Rate);

         Last100.Caption := Format('%3.2f', [Rate]) + ' QSOs/hr';
         Max100.Caption := 'max ' + Format('%3.2f', [FLast100QsoRateMax]) + ' QSOs/hr';
      end;
   finally
      Timer.Enabled := True;
   end;
end;

procedure TRateDialog.OKBtnClick(Sender: TObject);
begin
   Close;
   MainForm.SetLastFocus();
end;

procedure TRateDialog.radioOriginClick(Sender: TObject);
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

procedure TRateDialog.StayOnTopClick(Sender: TObject);
begin
//   If StayOnTop.Checked then
//      FormStyle := fsStayOnTop
//   else
//      FormStyle := fsNormal;
end;

procedure TRateDialog.check3DClick(Sender: TObject);
begin
   Chart1.View3D := TCheckBox(Sender).Checked;
end;

procedure TRateDialog.UpdateGraph;
var
   hour_count: Integer;
   total_count: Integer;
   hour_peak: Integer;
   part_count: Integer;
   Str: string;
   _start: TDateTime;
   H, M, S, ms: Word;
   D: Integer;
   i: Integer;
   b: TBand;
   aQSO: TQSO;
   diff: TDateTime;
   count_array: array[0..48] of array[b19..b10g] of Integer;

   function CalcStartTime(dt: TDateTime): TDateTime;
   begin
      Result := dt - (FShowLast - 1) / 24;
   end;
begin
   for b := b19 to b10g do begin
      FGraphSeries[b].Clear();
   end;
   SeriesTotalQSOs.Clear();
   Chart1.Axes.Bottom.Items.Clear();

   if Log.TotalQSO = 0 then begin
      _start := CalcStartTime( CurrentTime() );
   end
   else begin
      case GraphStartPosition of
         spFirstQSO:    _start := ifthen(MyContest.UseContestPeriod, Log.StartTime, Log.QsoList[1].Time);
         spCurrentTime: _start := CalcStartTime( CurrentTime() );
         spLastQSO:     _start := ifthen(MyContest.UseContestPeriod, IncHour(Log.EndTime, (FShowLast * -1)), CalcStartTime( Log.QsoList[Log.TotalQSO].Time ));
         else           _start := CalcStartTime( CurrentTime() );
      end;
   end;

   DecodeTime(_start, H, M, S, ms);
   _start := Int(_start) + EncodeTime(H, 0, 0, 0);

//   if Log.TotalQSO = 0 then begin
//      Exit;
//   end;

//   if TQSO(Log.List[Log.TotalQSO]).QSO.time < _start then begin
//      Exit;
//   end;

   for i := 0 to 48 do begin
      for b := b19 to b10g do begin
         count_array[i][b] := 0;
      end;
   end;

   total_count := 0;
   for i := 1 to Log.TotalQSO do begin
      aQSO := Log.QsoList[i];

      if (aQSO.Points = 0) then begin    // 得点無しはスキップ
         Continue;
      end;

      if (aQSO.Invalid = True) then begin    // 無効もスキップ
         Continue;
      end;

      if (aQSO.Time < _start) then begin // グラフ化以前の交信
         Inc(total_count);
      end
      else begin
         diff := aQSO.Time - _start;
         DecodeTime(diff, H, M, S, ms);
         D := Trunc(DaySpan(aQSO.Time, _start));
         H := H + (D * 24);
         if (H > 47) then begin
            Continue;
         end;

         Inc(count_array[H][aQSO.Band]);
      end;
   end;

   hour_peak := 0;
   for i := 0 to FShowLast - 1 do begin
      Str := IntToStr(GetHour(_start + (1 / 24) * i));

      if FShowLast > 12 then begin
         if (GetHour(_start + (1 / 24) * i) mod 2) = 1 then begin
            Str := '';
         end;
      end;

      if FShowLast > 24 then begin
         if (GetHour(_start + (1 / 24) * i) mod 4) <> 0 then begin
            Str := '';
         end;
      end;

      // 横軸目盛ラベル
      Chart1.Axes.Bottom.Items.Add(i, Str);

      hour_count := 0;
      if GraphStyle = rsOriginal then begin
         for b := b19 to b10g do begin
            part_count := count_array[i][b];

            // この時間帯の合計
            hour_count := hour_count + part_count;
         end;

         // グラフデータの追加
         FGraphSeries[b19].Add(hour_count);
      end
      else if GraphStyle = rsByBand then begin
         for b := b19 to b10g do begin
            part_count := count_array[i][b];

            // グラフデータの追加
            FGraphSeries[b].Add(part_count);

            // この時間帯の合計
            hour_count := hour_count + part_count;
         end;
      end
      else if GraphStyle = rsByFreqRange then begin
         // HF(L)
         part_count := count_array[i][b19] +
                       count_array[i][b35] +
                       count_array[i][b7] +
                       count_array[i][b10];

         // グラフデータの追加
         FGraphSeries[b19].Add(part_count);

         // この時間帯の合計
         hour_count := hour_count + part_count;

         // HF(H)
         part_count := count_array[i][b14] +
                       count_array[i][b18] +
                       count_array[i][b21] +
                       count_array[i][b24] +
                       count_array[i][b28];

         // グラフデータの追加
         FGraphSeries[b14].Add(part_count);

         // この時間帯の合計
         hour_count := hour_count + part_count;

         // VHF
         part_count := count_array[i][b50] +
                       count_array[i][b144];

         // グラフデータの追加
         FGraphSeries[b50].Add(part_count);

         // この時間帯の合計
         hour_count := hour_count + part_count;

         // UHF
         part_count := count_array[i][b430] +
                       count_array[i][b1200] +
                       count_array[i][b2400];

         // グラフデータの追加
         FGraphSeries[b430].Add(part_count);

         // この時間帯の合計
         hour_count := hour_count + part_count;

         // SHF
         part_count := count_array[i][b5600] +
                       count_array[i][b10g];

         // グラフデータの追加
         FGraphSeries[b5600].Add(part_count);

         // この時間帯の合計
         hour_count := hour_count + part_count;
      end;

      // 縦軸目盛り調整のための値
      total_count := total_count + hour_count;
      hour_peak := Max(hour_peak, hour_count);

      // 累計
      SeriesTotalQSOs.Add(total_count);
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
end;

procedure TRateDialog.ShowLastComboChange(Sender: TObject);
begin
   FShowLast := StrToIntDef(ShowLastCombo.Items[ShowLastCombo.ItemIndex], 12);
   UpdateGraph();
end;

function TRateDialog.GetGraphSeries(b: TBand): TBarSeries;
begin
   Result := FGraphSeries[b];
end;

procedure TRateDialog.LoadSettings();
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
end;

procedure TRateDialog.SaveSettings();
var
   b: TBand;
begin
   dmZLogGlobal.Settings.FGraphStyle := GraphStyle;
   dmZLogGlobal.Settings.FGraphStartPosition := GraphStartPosition;
   for b := b19 to HiBand do begin
      dmZLogGlobal.Settings.FGraphBarColor[b] := GraphSeries[b].SeriesColor;
      dmZLogGlobal.Settings.FGraphTextColor[b] := GraphSeries[b].Marks.Font.Color;
   end;
end;

procedure TRateDialog.SetGraphStyle(v: TQSORateStyle);
begin
   FGraphStyle := v;
   UpdateGraph();
end;

procedure TRateDialog.SetGraphStartPosition(v: TQSORateStartPosition);
begin
   SetGraphStartPositionUI(v);
   FGraphStartPosition := v;
   UpdateGraph();
end;

procedure TRateDialog.SetGraphStartPositionUI(v: TQSORateStartPosition);
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

end.
