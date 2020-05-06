unit URateDialog;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, System.Math,
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
    OKBtn: TButton;
    StayOnTop: TCheckBox;
    Chart1: TChart;
    Series1: TBarSeries;
    Series2: TLineSeries;
    Label4: TLabel;
    ShowLastCombo: TComboBox;
    Label3: TLabel;
    check3D: TCheckBox;
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
  private
    { Private declarations }
    FLast10QsoRateMax: Double;
    FLast100QsoRateMax: Double;
    FShowLast: Integer;      { Show last x hours. default = 12}
  public
    { Public declarations }
    procedure UpdateGraph;
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TRateDialog.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TRateDialog.FormCreate(Sender: TObject);
begin
   FLast10QsoRateMax := 0;
   FLast100QsoRateMax := 0;
   FShowLast := 12;
   ShowLastCombo.ItemIndex := 2;

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

   with Series1 do begin
      Clear();
      VertAxis := aLeftAxis;
      ValueFormat := '#,###';    // 0を出さない
   end;

   with Series2 do begin
      Clear();
      VertAxis := aRightAxis;
   end;
end;

procedure TRateDialog.FormShow(Sender: TObject);
begin
   UpdateGraph;
   Timer.Enabled := True;
end;

procedure TRateDialog.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.LastFocus.SetFocus;
   end;
end;

procedure TRateDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Timer.Enabled := False;
end;

procedure TRateDialog.TimerTimer(Sender: TObject);
var
   Last: TDateTime;
   Diff, Rate: double;
   i: LongInt;
   mytx, k: integer;
   aQSO: TQSO;
begin
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
      aQSO := Log.QsoList[k];
      if aQSO.TX = mytx then begin
         inc(k);
      end;

      dec(i)
   until (i = 0) or (k = 10);

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
   until (i = 0) or (k = 100);

   if k = 100 then begin
      Last := aQSO.time;
      Diff := (CurrentTime - Last) * 24.0;
      Rate := 100 / Diff;

      FLast100QsoRateMax := Max(FLast100QsoRateMax, Rate);

      Last100.Caption := Format('%3.2f', [Rate]) + ' QSOs/hr';
      Max100.Caption := 'max ' + Format('%3.2f', [FLast100QsoRateMax]) + ' QSOs/hr';
   end;
end;

procedure TRateDialog.OKBtnClick(Sender: TObject);
begin
   Close;
   MainForm.LastFocus.SetFocus;
end;

procedure TRateDialog.StayOnTopClick(Sender: TObject);
begin
   If StayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
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
   Str: string;
   _start: TDateTime;
   H, M, S, ms: Word;
   i: Integer;
   aQSO: TQSO;
   diff: TDateTime;
   count_array: array[0..48] of Integer;
begin
   Series1.Clear();
   Series2.Clear();
   Chart1.Axes.Bottom.Items.Clear();

   _start := CurrentTime() - (FShowLast - 1) / 24;
   DecodeTime(_start, H, M, S, ms);
   _start := Int(_start) + EncodeTime(H, 0, 0, 0);

//   if Log.TotalQSO = 0 then begin
//      Exit;
//   end;

//   if TQSO(Log.List[Log.TotalQSO]).QSO.time < _start then begin
//      Exit;
//   end;

   for i := 0 to 48 do begin
      count_array[i] := 0;
   end;

   total_count := 0;
   for i := 1 to Log.TotalQSO do begin
      aQSO := Log.QsoList[i];

      if (aQSO.Points = 0) then begin    // 得点無しはスキップ
         Continue;
      end;

      if (aQSO.Time < _start) then begin // グラフ化以前の交信
         Inc(total_count);
      end
      else begin
         diff := aQSO.Time - _start;
         DecodeTime(diff, H, M, S, ms);
         if (H > 47) then begin
            Continue;
         end;

         Inc(count_array[H]);
      end;
   end;

   hour_peak := 0;
   for i := 0 to FShowLast - 1 do begin
      hour_count := count_array[i];

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

      // 縦軸目盛り調整のための値
      total_count := total_count + hour_count;
      hour_peak := Max(hour_peak, hour_count);

      // 横軸目盛ラベル
      Chart1.Axes.Bottom.Items.Add(i, Str);

      // グラフデータの追加
      Series1.Add(hour_count);
      Series2.Add(total_count);
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
   UpdateGraph;
end;

end.
