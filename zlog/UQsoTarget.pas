unit UQsoTarget;

interface

uses
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
  end;

  THourTarget = class(TObject)
  private
    FHourTarget: array[1..24] of TQsoTarget;
    FHourTotal: TQsoTarget;
    function GetValues(Index: Integer): TQsoTarget;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Refresh();
    property Hours[Index: Integer]: TQsoTarget read GetValues;
    property Total: TQsoTarget read FHourTotal;
  end;

  TContestTarget = class(TObject)
  private
    FBandTarget: array[b19..b10g] of THourTarget;
    FBandTotal: TQsoTarget;
    function GetValues(B: TBand): THourTarget;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure LoadFromFile(filename: string);
    procedure SaveToFile(filename: string);
    procedure Refresh();
    property Bands[B: TBand]: THourTarget read GetValues;
    property Total: TQsoTarget read FBandTotal;
  end;

implementation

{ TQsoTarget }

constructor TQsoTarget.Create();
begin
   FActual := 0;
   FTarget := 0;
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
   FHourTotal.Actual := 0;
   FHourTotal.Target := 0;
   for i := 1 to 24 do begin
      FHourTotal.Actual := FHourTotal.Actual + FHourTarget[i].Actual;
      FHourTotal.Target := FHourTotal.Target + FHourTarget[i].Target;
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
   FBandTotal := TQsoTarget.Create();
end;

destructor TContestTarget.Destroy();
var
   b: TBand;
begin
   for b := b19 to b10g do begin
      FBandTarget[b].Free();
   end;
   FBandTotal.Free();
end;

function TContestTarget.GetValues(B: TBand): THourTarget;
begin
   Result := FBandTarget[B];
end;

procedure TContestTarget.Refresh();
var
   b: TBand;
begin
   FBandTotal.Actual := 0;
   FBandTotal.Target := 0;
   for b := b19 to b10g do begin
      FBandTotal.Actual := FBandTotal.Actual + FBandTarget[b].Total.Actual;
      FBandTotal.Target := FBandTotal.Target + FBandTarget[b].Total.Target;
   end;
end;

procedure TContestTarget.LoadFromFile(filename: string);
begin
//
end;

procedure TContestTarget.SaveToFile(filename: string);
begin
//
end;

end.
