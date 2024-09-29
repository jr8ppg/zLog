unit UzFreqMemory;

interface

uses
  Vcl.Forms, System.SysUtils, System.Classes, System.StrUtils,
  Generics.Collections, Generics.Defaults,
  URigCtrlLib, UzLogConst;

type
  TFreqMemory = class
  private
    FCommand: string;
    FFrequency: TFrequency;
    FMode: TMode;
    FFixEdgeNo: Integer;
  public
    constructor Create();
    property Command: string read FCommand write FCommand;
    property Frequency: TFrequency read FFrequency write FFrequency;
    property Mode: TMode read FMode write FMode;
    property FixEdgeNo: Integer read FFixEdgeNo write FFixEdgeNo;
  end;

  TFreqMemoryList = class(TObjectList<TFreqMemory>)
  public
    constructor Create(OwnsObjects: Boolean = True);
    destructor Destroy(); override;
    procedure LoadFromFile(filename: string);
    function IndexOf(strCommand: string): Integer;
    function ObjectOf(strCommand: string): TFreqMemory;
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

         obj := TFreqMemory.Create();
         obj.Command := slLine[0];
         obj.Frequency := StrToIntDef(slLine[1], 0);
         obj.Mode := TextToMode(slLine[2]);
         obj.FixEdgeNo := StrToIntDef(slLine[3], 0);

         if (obj.Command = '') or (obj.Frequency = 0) then begin
            obj.Free();
         end
         else begin
            if IndexOf(obj.Command) = -1 then begin
               Self.Add(obj);
            end;
         end;
      end;

   finally
      slFile.Free();
      slLine.Free();
   end;
end;

end.
