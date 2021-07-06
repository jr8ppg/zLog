unit UQsoTarget;

interface

uses
  System.SysUtils, System.Classes, System.AnsiStrings, System.Math,
  UzLogConst;

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
    procedure IncActual();
    procedure IncTarget();
  end;

  THourTarget = class(TObject)
  private
    FHourTarget: array[1..24] of TQsoTarget;
    FHourTotal: TQsoTarget;   // â°åv
    function GetValues(Index: Integer): TQsoTarget;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Refresh();
    procedure Clear();
    property Hours[Index: Integer]: TQsoTarget read GetValues;
    property Total: TQsoTarget read FHourTotal;
  end;

  TContestTarget = class(TObject)
  private
    FBandTarget: array[b19..b10g] of THourTarget;
    FBandTotal: array[b19..b10g] of THourTarget;   // ècåv
    FTotal: TQsoTarget;    // ècâ°åv
    function GetValues(B: TBand): THourTarget;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure LoadFromFile(filename: string);
    procedure SaveToFile(filename: string);
    procedure Clear();
    procedure Refresh();
    procedure Adjust(n: Integer);
    property Bands[B: TBand]: THourTarget read GetValues;
    property Total: TQsoTarget read FTotal;
  end;

implementation

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
   for i := 1 to 24 do begin
      FHourTarget[i] := TQsoTarget.Create();
   end;
   FHourTotal := TQsoTarget.Create();
end;

destructor THourTarget.Destroy();
var
   i: Integer;
begin
   for i := 1 to 24 do begin
      FHourTarget[i].Free();
   end;
   FHourTotal.Free();
end;

procedure THourTarget.Refresh();
var
   i: Integer;
begin
   FHourTotal.Clear();
   for i := 1 to 24 do begin
      FHourTotal.Actual := FHourTotal.Actual + FHourTarget[i].Actual;
      FHourTotal.Target := FHourTotal.Target + FHourTarget[i].Target;
   end;
end;

procedure THourTarget.Clear();
var
   i: Integer;
begin
   FHourTotal.Clear();
   for i := 1 to 24 do begin
      FHourTarget[i].Clear();
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
      FBandTotal[b] := THourTarget.Create();
   end;
   FTotal := TQsoTarget.Create();
end;

destructor TContestTarget.Destroy();
var
   b: TBand;
begin
   for b := b19 to b10g do begin
      FBandTarget[b].Free();
      FBandTotal[b].Free();
   end;
   FTotal.Free();
end;

function TContestTarget.GetValues(B: TBand): THourTarget;
begin
   Result := FBandTarget[B];
end;

procedure TContestTarget.Refresh();
var
   b: TBand;
   h: Integer;
begin
   for b := b19 to b10g do begin
      FBandTotal[b].Clear();
      for h := 1 to 24 do begin
         FBandTotal[b].Hours[h].Actual := FBandTotal[b].Hours[h].Actual + FBandTarget[b].Hours[h].Actual;
         FBandTotal[b].Hours[h].Target := FBandTotal[b].Hours[h].Target + FBandTarget[b].Hours[h].Target;
      end;
   end;
end;

procedure TContestTarget.Adjust(n: Integer);
var
   b: TBand;
   i: Integer;
   t: Integer;
begin
   for b := b19 to b10g do begin
      for i := 1 to 24 do begin
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

procedure TContestTarget.Clear();
var
   b: TBand;
begin
   for b := b19 to b10g do begin
      FBandTotal[b].Clear();
      FBandTarget[b].Clear();
   end;
   FTotal.Clear();
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
   finally
      slText.Free();
      slLine.Free();
   end;
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

         for h := 1 to 24 do begin
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
