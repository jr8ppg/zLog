unit UzFreqMemory;

interface

uses
  Vcl.Forms, System.SysUtils, System.Classes, System.StrUtils,
  Generics.Collections, Generics.Defaults,
  UzLogConst;

type
  TFreqMemory = class
  private
    FCommand: string;
    FFrequency: TFrequency;
    FMode: TMode;
    FRigNo: Integer;
    FFixEdgeNo: Integer;
  public
    constructor Create();
    procedure Assign(src: TFreqMemory);
    property Command: string read FCommand write FCommand;
    property Frequency: TFrequency read FFrequency write FFrequency;
    property Mode: TMode read FMode write FMode;
    property RigNo: Integer read FRigNo write FRigNo;
    property FixEdgeNo: Integer read FFixEdgeNo write FFixEdgeNo;
  end;

  TFreqMemoryList = class(TObjectList<TFreqMemory>)
  public
    constructor Create(OwnsObjects: Boolean = True);
    destructor Destroy(); override;
    procedure LoadFromFile(filename: string);
    procedure SaveToFile(filename: string);
    function IndexOf(strCommand: string): Integer;
    function ObjectOf(strCommand: string): TFreqMemory;
    procedure Delete(obj: TFreqMemory); overload;
    procedure Assign(src: TFreqMemoryList);
  end;

implementation

uses
  UzLogGlobal;

{ TFreqMemory }

constructor TFreqMemory.Create();
begin
   Inherited;
   FCommand := '';
   FFrequency := 0;
   FMode := mCW;
end;

procedure TFreqMemory.Assign(src: TFreqMemory);
begin
   FCommand := src.Command;
   FFrequency := src.Frequency;
   FMode := src.Mode;
   FRigNo := src.RigNo;
   FFixEdgeNo := src.FixEdgeNo;
end;

{ TFreqMemoryList }

constructor TFreqMemoryList.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
end;

destructor TFreqMemoryList.Destroy();
begin
   Inherited;
end;

function TFreqMemoryList.IndexOf(strCommand: string): Integer;
var
   i: Integer;
begin
   for i := 0 to Count - 1 do begin
      if Items[i].Command = strCommand then begin
         Result := i;
         Exit;
      end;
   end;
   Result := -1;
end;

function TFreqMemoryList.ObjectOf(strCommand: string): TFreqMemory;
var
   i: Integer;
begin
   for i := 0 to Count - 1 do begin
      if Items[i].Command = strCommand then begin
         Result := Items[i];
         Exit;
      end;
   end;
   Result := nil;
end;

procedure TFreqMemoryList.LoadFromFile(filename: string);
var
   i: Integer;
   slFile: TStringList;
   slLine: TStringList;
   obj: TFreqMemory;
   S: string;
begin
   slFile := TStringList.Create();
   slLine := TStringList.Create();
   try
      filename := ExtractFilePath(Application.ExeName) + filename;
      if FileExists(filename) = False then begin
         Exit;
      end;

      slFile.LoadFromFile(filename);

      for i := 0 to slFile.Count - 1 do begin
         S := slFile[i];
         if (Copy(S, 1, 1) = ';') or (Copy(S, 1, 1) = '#') then begin
            Continue;
         end;

         slLine.CommaText := S + ',,,,';

         if (slLine[0] = '') or (StrToIntDef(slLine[1], 0) = 0) then begin
            Continue;
         end;

         if IndexOf(slLine[0]) >= 0 then begin
            Continue;
         end;

         obj := TFreqMemory.Create();
         obj.Command := slLine[0];
         obj.Frequency := StrToIntDef(slLine[1], 0);
         obj.Mode := TextToMode(slLine[2]);
         obj.FixEdgeNo := StrToIntDef(slLine[3], 0);
         obj.RigNo := StrToIntDef(slLine[4], 0);
         Self.Add(obj);
      end;

   finally
      slFile.Free();
      slLine.Free();
   end;
end;

procedure TFreqMemoryList.SaveToFile(filename: string);
var
   i: Integer;
   slFile: TStringList;
   slLine: TStringList;
   obj: TFreqMemory;
begin
   slFile := TStringList.Create();
   slLine := TStringList.Create();
   try
      filename := ExtractFilePath(Application.ExeName) + filename;

      for i := 0 to Count - 1 do begin
         obj := Items[i];

         slLine.Clear();
         slLine.Add(obj.Command);
         slLine.Add(IntToStr(obj.Frequency));
         slLine.Add(ModeToText(obj.Mode));
         slLine.Add(IntToStr(obj.FixEdgeNo));
         slLine.Add(IntToStr(obj.RigNo));

         slFile.Add(slLine.CommaText);
      end;

      slFile.SaveToFile(filename);
   finally
      slFile.Free();
      slLine.Free();
   end;
end;

procedure TFreqMemoryList.Delete(obj: TFreqMemory);
var
   i: Integer;
begin
   for i := 0 to Count - 1 do begin
      if Items[i] = obj then begin
         Items[i].Free();
         Delete(i);
         Exit;
      end;
   end;
end;

procedure TFreqMemoryList.Assign(src: TFreqMemoryList);
var
   i: Integer;
   D: TFreqMemory;
begin
   Clear();
   for i := 0 to src.Count - 1 do begin
      D := TFreqMemory.Create();
      D.Assign(src.Items[i]);
      Add(D);
   end;
end;

end.
