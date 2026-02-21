unit UQsoTarget;

interface

uses
  Vcl.Forms, System.SysUtils, System.Classes, System.AnsiStrings, System.Math,
  System.DateUtils, UzLogConst, UzLogQSO;

const
  MAX_HOURS = 48;

type

  TQsoTarget = class(TObject)
  private
    FActual: Integer;
    FTarget: Integer;
    function GetRate(): Double;
  public
    constructor Create();
    property Actual: Integer read FActual write FActual;
    property Target: Integer read FTarget write FTarget;
    property Rate: Double read GetRate;
    procedure Clear();
    procedure ActualClear();
    procedure IncActual();
    procedure IncTarget();
  end;

  THourTarget = class(TObject)
  private
    FHourTarget: array[1..MAX_HOURS] of TQsoTarget;
    FHourTotal: TQsoTarget;   // 横計
    FTotal2: TQsoTarget;   // 1～tohourまでの累計
    function GetValues(Index: Integer): TQsoTarget;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Refresh();
    procedure Clear();
    procedure ActualClear();
    property Hours[Index: Integer]: TQsoTarget read GetValues;
    property Total: TQsoTarget read FHourTotal;
    function Total2(tohour: Integer): TQsoTarget;
  end;

  TContestTarget = class(TObject)
  private
    FBandTarget: array[b19..HiBand] of THourTarget;
    FBandTotal: THourTarget;   // 縦計
    FBandCumulative: THourTarget;   // 縦計
    FTotal: TQsoTarget;    // 縦横計
    FLast10QsoRate: Extended;
    FLast100QsoRate: Extended;
    FLast10QsoRateMax: Extended;
    FLast100QsoRateMax: Extended;
    FBeforeGraphCount: Integer;
    function GetBandTarget(B: TBand): THourTarget;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure LoadFromFile(filename: string); overload;
    procedure SaveToFile(filename: string); overload;
    procedure LoadFromFile(); overload;
    procedure SaveToFile(); overload;
    procedure Clear();
    procedure ActualClear();
    procedure Refresh();
    procedure Adjust(n: Integer);
    function UpdateActualQSOs(origin, start: TDateTime): Integer;
    procedure UpdateLastRate();
    property Bands[B: TBand]: THourTarget read GetBandTarget;
    property Total: THourTarget read FBandTotal;
    property TotalTotal: TQsoTarget read FTotal;
    property Cumulative: THourTarget read FBandCumulative;
    property Last10QsoRate: Extended read FLast10QsoRate;
    property Last100QsoRate: Extended read FLast100QsoRate;
    property Last10QsoRateMax: Extended read FLast10QsoRateMax;
    property Last100QsoRateMax: Extended read FLast100QsoRateMax;
    property BeforeGraphCount: Integer read FBeforeGraphCount;
  end;

implementation

uses
  UzLogGlobal;

{ TQsoTarget }

constructor TQsoTarget.Create();
begin
   Clear();
end;

function TQsoTarget.GetRate(): Double;
begin
   if FTarget = 0 then begin
      Result := 0;
   end
   else begin
      Result := FActual / FTarget * 100;
   end;
end;

procedure TQsoTarget.Clear();
begin
   FActual := 0;
   FTarget := 0;
end;

procedure TQsoTarget.ActualClear();
begin
   FActual := 0;
end;

procedure TQsoTarget.IncActual();
begin
   Inc(FActual);
end;

procedure TQsoTarget.IncTarget();
begin
   Inc(FTarget);
end;

{ THourTarget }

constructor THourTarget.Create();
var
   i: Integer;
begin
   for i := Low(FHourTarget) to High(FHourTarget) do begin
      FHourTarget[i] := TQsoTarget.Create();
   end;
   FHourTotal := TQsoTarget.Create();
   FTotal2 := TQsoTarget.Create();
end;

destructor THourTarget.Destroy();
var
   i: Integer;
begin
   for i := Low(FHourTarget) to High(FHourTarget) do begin
      FHourTarget[i].Free();
   end;
   FHourTotal.Free();
   FTotal2.Free();
end;

procedure THourTarget.Refresh();
var
   i: Integer;
begin
   FHourTotal.Clear();
   for i := Low(FHourTarget) to High(FHourTarget) do begin
      FHourTotal.Actual := FHourTotal.Actual + FHourTarget[i].Actual;
      FHourTotal.Target := FHourTotal.Target + FHourTarget[i].Target;
   end;
end;

procedure THourTarget.Clear();
var
   i: Integer;
begin
   FHourTotal.Clear();
   for i := Low(FHourTarget) to High(FHourTarget) do begin
      FHourTarget[i].Clear();
   end;
end;

procedure THourTarget.ActualClear();
var
   i: Integer;
begin
   FHourTotal.ActualClear();
   for i := Low(FHourTarget) to High(FHourTarget) do begin
      FHourTarget[i].ActualClear();
   end;
end;

function THourTarget.Total2(tohour: Integer): TQsoTarget;
var
   i: Integer;
begin
   FTotal2.Clear();

   for i := 1 to tohour do begin
      FTotal2.Target := FTotal2.Target + FHourTarget[i].Target;
      FTotal2.Actual := FTotal2.Actual + FHourTarget[i].Actual;
   end;

   Result := FTotal2;
end;

function THourTarget.GetValues(Index: Integer): TQsoTarget;
begin
   Result := FHourTarget[Index];
end;

{ TContestTarget }

constructor TContestTarget.Create();
var
   b: TBand;
begin
   for b := b19 to HiBand do begin
      FBandTarget[b] := THourTarget.Create();
   end;
   FBandTotal := THourTarget.Create();
   FBandCumulative := THourTarget.Create();
   FTotal := TQsoTarget.Create();

   FLast10QsoRateMax := 0;
   FLast100QsoRateMax := 0;
   FBeforeGraphCount := 0;
end;

destructor TContestTarget.Destroy();
var
   b: TBand;
begin
   for b := b19 to HiBand do begin
      FBandTarget[b].Free();
   end;
   FBandTotal.Free();
   FBandCumulative.Free();
   FTotal.Free();
end;

function TContestTarget.GetBandTarget(B: TBand): THourTarget;
begin
   Result := FBandTarget[B];
end;

procedure TContestTarget.Refresh();
var
   b: TBand;
   h: Integer;
begin
   for b := b19 to HiBand do begin
      FBandTarget[b].Refresh();
   end;

   FBandTotal.Clear();
   for b := b19 to HiBand do begin
      for h := 1 to MAX_HOURS do begin
         FBandTotal.Hours[h].Actual := FBandTotal.Hours[h].Actual + FBandTarget[b].Hours[h].Actual;
         FBandTotal.Hours[h].Target := FBandTotal.Hours[h].Target + FBandTarget[b].Hours[h].Target;
      end;
   end;

   FBandCumulative.Clear();
   for h := 1 to MAX_HOURS do begin
      if h > 1 then begin
         FBandCumulative.Hours[h].Actual := FBandCumulative.Hours[h - 1].Actual;
         FBandCumulative.Hours[h].Target := FBandCumulative.Hours[h - 1].Target;
      end;
      FBandCumulative.Hours[h].Actual := FBandCumulative.Hours[h].Actual + FBandTotal.Hours[h].Actual;
      FBandCumulative.Hours[h].Target := FBandCumulative.Hours[h].Target + FBandTotal.Hours[h].Target;
   end;

   FBandTotal.Refresh();
   FBandCumulative.Refresh();

   FTotal.Clear();

   FTotal.Actual := FBandTotal.Total.Actual;
   FTotal.Target := FBandTotal.Total.Target;
end;

procedure TContestTarget.Adjust(n: Integer);
var
   b: TBand;
   i: Integer;
   t: Integer;
begin
   for b := b19 to HiBand do begin
      for i := 1 to MAX_HOURS do begin
         t := FBandTarget[b].Hours[i].Target;

         if t = 0 then begin
            Continue;
         end;
         if t <= n then begin
            Continue;
         end;

         FBandTarget[b].Hours[i].Target := ((t div n) + 1) * n;
      end;
   end;

   Refresh();
end;

function TContestTarget.UpdateActualQSOs(origin, start: TDateTime): Integer;
var
   i: Integer;
   aQSO: TQSO;
   diff: TDateTime;
   H, M, S, ms: Word;
   D: Integer;
   c10: Integer;
   c100: Integer;
   mytx: Integer;
begin
   ActualClear();

   FBeforeGraphCount := 0;
   c10 := 0;
   c100 := 0;

   mytx := dmZlogGlobal.TXNr;

   for i := Log.TotalQSO downto 1 do begin
      aQSO := Log.QsoList[i];

      if (aQSO.Points = 0) then begin        // 得点無しはスキップ
         Continue;
      end;

      if (aQSO.Invalid = True) then begin    // 無効もスキップ
         Continue;
      end;

      if (aQSO.Time < origin) then begin     // コンテスト開始前の交信
         Continue;
      end
      else begin
         diff := aQSO.Time - origin;
         DecodeTime(diff, H, M, S, ms);
         D := Trunc(DaySpan(aQSO.Time, origin));
         H := H + (D * 24);
         if (H > 47) then begin
            Continue;
         end;

         FBandTarget[aQSO.Band].Hours[H + 1].IncActual();

         if (aQSO.Time < start) then begin // グラフ化以前の交信
            Inc(FBeforeGraphCount);
         end;
      end;

      if aQSO.TX = mytx then begin
         Inc(c10);
         Inc(c100);
      end;

      if (c10 = 10) then begin
         diff := (CurrentTime - aQSO.Time) * 24.0;
         FLast10QsoRate := 10 / Diff;

         FLast10QsoRateMax := Max(FLast10QsoRateMax, FLast10QsoRate);
      end;

      if c100 = 100 then begin
         Diff := (CurrentTime - aQSO.time) * 24.0;
         FLast100QsoRate := 100 / Diff;

         FLast100QsoRateMax := Max(FLast100QsoRateMax, FLast100QsoRate);
      end;
   end;

   Refresh();

   Result := FBeforeGraphCount;
end;

procedure TContestTarget.UpdateLastRate();
var
   i: Integer;
   aQSO: TQSO;
   c10, c100: Integer;
   diff: TDateTime;
   mytx: Integer;
begin
   mytx := dmZlogGlobal.TXNr;
   c10 := 0;
   c100 := 0;
   for i := Log.TotalQSO downto 1 do begin
      aQSO := Log.QsoList[i];

      if (aQSO.Points = 0) then begin    // 得点無しはスキップ
         Continue;
      end;

      if aQSO.TX = mytx then begin
         Inc(c10);
         Inc(c100);
      end;

      if (c10 = 10) then begin
         diff := (CurrentTime - aQSO.Time) * 24.0;
         FLast10QsoRate := 10 / Diff;

         FLast10QsoRateMax := Max(FLast10QsoRateMax, FLast10QsoRate);
      end;

      if c100 = 100 then begin
         Diff := (CurrentTime - aQSO.time) * 24.0;
         FLast100QsoRate := 100 / Diff;

         FLast100QsoRateMax := Max(FLast100QsoRateMax, FLast100QsoRate);
         Break;
      end;
   end;
end;

procedure TContestTarget.Clear();
var
   b: TBand;
begin
   for b := b19 to HiBand do begin
      FBandTarget[b].Clear();
   end;
   FBandTotal.Clear();
   FBandCumulative.Clear();
   FTotal.Clear();
end;

procedure TContestTarget.ActualClear();
var
   b: TBand;
begin
   for b := b19 to HiBand do begin
      FBandTarget[b].ActualClear();
   end;
   FBandTotal.ActualClear();
   FBandCumulative.ActualClear();
   FTotal.ActualClear();
end;

procedure TContestTarget.LoadFromFile();
begin
   LoadFromFile(ExtractFilePath(Application.ExeName) + 'zlog_target.txt');
end;

procedure TContestTarget.LoadFromFile(filename: string);
var
   slText: TStringList;
   slLine: TStringList;
   b: TBand;
   h: Integer;
   n: Integer;
   i: Integer;
begin
   if FileExists(filename) = False then begin
      Exit;
   end;

   slText := TStringList.Create();
   slLine := TStringList.Create();
   try
      slText.LoadFromFile(filename);

      Clear();

      for i := 0 to slText.Count - 1 do begin
         slLine.CommaText := slText[i];

         if slLine.Count < 25 then begin
            Continue;
         end;

         n := StrToIntDef(slLine[0], 0);
         b := TBand(n);

         for h := 1 to slLine.Count - 1 do begin
            n := StrToIntDef(slLine[h], 0);

            FBandTarget[b].Hours[h].Target := n;
         end;
      end;

      Refresh();
   finally
      slText.Free();
      slLine.Free();
   end;
end;

procedure TContestTarget.SaveToFile();
begin
   SaveToFile(ExtractFilePath(Application.ExeName) + 'zlog_target.txt');
end;

procedure TContestTarget.SaveToFile(filename: string);
var
   slText: TStringList;
   slLine: TStringList;
   b: TBand;
   h: Integer;
   n: Integer;
   strPath: string;
begin
   strPath := ExtractFilePath(filename);
   if (strPath <> '') and (DirectoryExists(strPath) = False) then begin
      ForceDirectories(strPath);
   end;

   slText := TStringList.Create();
   slLine := TStringList.Create();
   try
      for b := b19 to hiBand do begin
         slLine.Clear();
         slLine.Add(IntToStr(Ord(b)));

         for h := 1 to MAX_HOURS do begin
            n := FBandTarget[b].Hours[h].Target;
            slLine.Add(IntToStr(n));
         end;

         slText.Add(slLine.CommaText);
      end;

      slText.SaveToFile(filename);
   finally
      slText.Free();
      slLine.Free();
   end;
end;

end.
