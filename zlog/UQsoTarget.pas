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
    function GetValues(Index: Integer): TQsoTarget;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Refresh();
    procedure Clear();
    procedure ActualClear();
    property Hours[Index: Integer]: TQsoTarget read GetValues;
    property Total: TQsoTarget read FHourTotal;
  end;

  TContestTarget = class(TObject)
  private
    FBandTarget: array[b19..b10g] of THourTarget;
    FBandTotal: THourTarget;   // 縦計
    FTotal: TQsoTarget;    // 縦横計
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
    function UpdateActualQSOs(origin: TDateTime): Integer;
    property Bands[B: TBand]: THourTarget read GetBandTarget;
    property Total: THourTarget read FBandTotal;
    property TotalTotal: TQsoTarget read FTotal;
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
end;

destructor THourTarget.Destroy();
var
   i: Integer;
begin
   for i := Low(FHourTarget) to High(FHourTarget) do begin
      FHourTarget[i].Free();
   end;
   FHourTotal.Free();
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

function THourTarget.GetValues(Index: Integer): TQsoTarget;
begin
   Result := FHourTarget[Index];
end;

{ TContestTarget }

constructor TContestTarget.Create();
var
   b: TBand;
begin
   for b := b19 to b10g do begin
      FBandTarget[b] := THourTarget.Create();
   end;
   FBandTotal := THourTarget.Create();
   FTotal := TQsoTarget.Create();
end;

destructor TContestTarget.Destroy();
var
   b: TBand;
begin
   for b := b19 to b10g do begin
      FBandTarget[b].Free();
   end;
   FBandTotal.Free();
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
   for b := b19 to b10g do begin
      FBandTarget[b].Refresh();
   end;

   FBandTotal.Clear();
   for b := b19 to b10g do begin
      for h := 1 to MAX_HOURS do begin
         FBandTotal.Hours[h].Actual := FBandTotal.Hours[h].Actual + FBandTarget[b].Hours[h].Actual;
         FBandTotal.Hours[h].Target := FBandTotal.Hours[h].Target + FBandTarget[b].Hours[h].Target;
      end;
   end;

   FBandTotal.Refresh();


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
   for b := b19 to b10g do begin
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

function TContestTarget.UpdateActualQSOs(origin: TDateTime): Integer;
var
   total_count: Integer;
   i: Integer;
   aQSO: TQSO;
   diff: TDateTime;
   H, M, S, ms: Word;
   D: Integer;
begin
   ActualClear();

   total_count := 0;
   for i := 1 to Log.TotalQSO do begin
      aQSO := Log.QsoList[i];

      if (aQSO.Points = 0) then begin    // 得点無しはスキップ
         Continue;
      end;

      if (aQSO.Time < origin) then begin // グラフ化以前の交信
         Inc(total_count);
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
      end;
   end;

   Refresh();

   Result := total_count;
end;

procedure TContestTarget.Clear();
var
   b: TBand;
begin
   for b := b19 to b10g do begin
      FBandTarget[b].Clear();
   end;
   FBandTotal.Clear();
   FTotal.Clear();
end;

procedure TContestTarget.ActualClear();
var
   b: TBand;
begin
   for b := b19 to b10g do begin
      FBandTarget[b].ActualClear();
   end;
   FBandTotal.ActualClear();
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
      for b := b19 to b10g do begin
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
