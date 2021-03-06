unit UzLogOperatorInfo;

interface

uses
  System.SysUtils, System.Classes, StrUtils, IniFiles, Forms, Windows, Menus,
  System.DateUtils, Generics.Collections, Generics.Defaults,
  UzlogConst;

type
  TOperatorInfo = class(TObject)
  private
    FCallsign: string;
    FPower: string;
    FAge: string;
    FVoiceFiles: array[1..maxmessage] of string;
    FAdditionalVoiceFiles: array[2..3] of string;
    procedure SetVoiceFile(Index: Integer; S: string);
    function GetVoiceFile(Index: Integer): string;
    procedure SetAdditionalVoiceFile(Index: Integer; S: string);
    function GetAdditionalVoiceFile(Index: Integer): string;
    procedure SetPower(S: string);
  public
    constructor Create();
    destructor Destroy(); override;
    property Callsign: string read FCallsign write FCallsign;
    property Power: string read FPower write SetPower;
    property Age: string read FAge write FAge;
    property VoiceFile[Index: Integer]: string read GetVoiceFile write SetVoiceFile;
    property AdditionalVoiceFile[Index: Integer]: string read GetAdditionalVoiceFile write SetAdditionalVoiceFile;
  end;

  TOperatorInfoList = class(TObjectList<TOperatorInfo>)
  private
  public
    constructor Create(OwnsObjects: Boolean = True);
    destructor Destroy(); override;
    function ObjectOf(callsign: string): TOperatorInfo;
    procedure SaveToIniFile();
    procedure LoadFromIniFile();
    procedure LoadFromOpList();
  end;

implementation

constructor TOperatorInfo.Create();
var
   i: Integer;
begin
   Inherited;
   FCallsign := '';
   FPower := '';
   FAge := '';
   for i := Low(FVoiceFiles) to High(FVoiceFiles) do begin
      FVoiceFiles[i] := '';
   end;
   for i := Low(FAdditionalVoiceFiles) to High(FAdditionalVoiceFiles) do begin
      FAdditionalVoiceFiles[i] := '';
   end;
end;

destructor TOperatorInfo.Destroy();
begin
   Inherited;
end;

function TOperatorInfo.GetVoiceFile(Index: Integer): string;
begin
   Result := FVoiceFiles[Index];
end;

procedure TOperatorInfo.SetVoiceFile(Index: Integer; S: string);
begin
   FVoiceFiles[Index] := S;
end;

function TOperatorInfo.GetAdditionalVoiceFile(Index: Integer): string;
begin
   Result := FAdditionalVoiceFiles[Index];
end;

procedure TOperatorInfo.SetAdditionalVoiceFile(Index: Integer; S: string);
begin
   FAdditionalVoiceFiles[Index] := S;
end;

procedure TOperatorInfo.SetPower(S: string);
begin
   S := S + DupeString('-', 13);
   FPower := Copy(S, 1, 13);
end;

{ TOperatorInfoList }

constructor TOperatorInfoList.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
end;

destructor TOperatorInfoList.Destroy();
begin
   Inherited;
end;

function TOperatorInfoList.ObjectOf(callsign: string): TOperatorInfo;
var
   i: Integer;
begin
   for i := 0 to Count - 1 do begin
      if Items[i].Callsign = callsign then begin
         Result := Items[i];
         Exit;
      end;
   end;

   Result := nil;
end;

procedure TOperatorInfoList.SaveToIniFile();
var
   ini: TIniFile;
   i: Integer;
   j: Integer;
   obj: TOperatorInfo;
   section: string;
   filename: string;
begin
   filename := ExtractFilePath(Application.ExeName) + 'zlog_oplist.ini';
   if FileExists(filename) = True then begin
      System.SysUtils.DeleteFile(fileName);
   end;

   ini := TIniFile.Create(filename);
   try
     ini.WriteInteger('operators', 'num', Count);

     for i := 0 to Count - 1 do begin
         obj := Items[i];

         section := 'Operator#' + IntToStr(i);

         ini.WriteString(section, 'Callsign', obj.Callsign);
         ini.WriteString(section, 'Power', obj.Power);
         ini.WriteString(section, 'Age', obj.Age);

         for j := 1 to maxmessage do begin
            ini.WriteString(section, 'VoiceFile#' + IntToStr(j), obj.VoiceFile[j]);
         end;
         for j := 2 to 3 do begin
            ini.WriteString(section, 'AdditionalVoiceFile#' + IntToStr(j), obj.AdditionalVoiceFile[j]);
         end;
      end;
   finally
      ini.Free();
   end;
end;

procedure TOperatorInfoList.LoadFromIniFile();
var
   ini: TIniFile;
   SL: TStringList;
   i: Integer;
   j: Integer;
   obj: TOperatorInfo;
   section: string;
   strVoiceFile: string;
   S: string;
begin
   SL := TStringList.Create();
   ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'zlog_oplist.ini');;
   try
      ini.ReadSections(SL);

      for i := 0 to SL.Count - 1 do begin
         section := SL[i];

         if Pos('Operator#', section) = 0 then begin
            Continue;
         end;

         S := ini.ReadString(section, 'Callsign', '');
         if S = '' then begin
            Continue;
         end;

         obj := TOperatorInfo.Create();
         obj.Callsign := S;
         obj.Power := ini.ReadString(section, 'Power', '');
         obj.Age := ini.ReadString(section, 'Age', '');

         for j := 1 to maxmessage do begin
            strVoiceFile := ini.ReadString(section, 'VoiceFile#' + IntToStr(j), '');
            if strVoiceFile <> '' then begin
               if FileExists(strVoiceFile) = False then begin
                  strVoiceFile := '';
               end;
            end;
            obj.VoiceFile[j] := strVoiceFile;
         end;

         for j := 2 to 3 do begin
            strVoiceFile := ini.ReadString(section, 'AdditionalVoiceFile#' + IntToStr(j), '');
            if strVoiceFile <> '' then begin
               if FileExists(strVoiceFile) = False then begin
                  strVoiceFile := '';
               end;
            end;
            obj.AdditionalVoiceFile[j] := strVoiceFile;
         end;

         Add(obj);
      end;
   finally
      ini.Free();
      SL.Free();
   end;
end;

procedure TOperatorInfoList.LoadFromOpList();
var
   SL: TStringList;
   filename: string;
   i: Integer;
   obj: TOperatorInfo;
   S: string;
   P: string;
   L: string;
begin
   SL := TStringList.Create();
   try
      filename := ExtractFilePath(Application.ExeName) + 'ZLOG.OP';
      if FileExists(filename) = False then begin
         Exit;
      end;

      SL.LoadFromFile(filename);

      for i := 0 to SL.Count - 1 do begin
         L := Trim(SL[i]);
         if L = ''then begin
            Continue;
         end;

         S := Trim(Copy(L, 1, 20));
         P := Trim(Copy(L, 21));

         obj := TOperatorInfo.Create();
         obj.Callsign := S;
         obj.Power := P;
         obj.Age := '';

         Add(obj);
      end;
   finally
      SL.Free();
   end;
end;

end.
