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
    procedure SetVoiceFile(Index: Integer; S: string);
    function GetVoiceFile(Index: Integer): string;
  public
    constructor Create();
    destructor Destroy(); override;
    property Callsign: string read FCallsign write FCallsign;
    property Power: string read FPower write FPower;
    property Age: string read FAge write FAge;
    property VoiceFile[Index: Integer]: string read GetVoiceFile write SetVoiceFile;
  end;

  TOperatorInfoList = class(TObjectList<TOperatorInfo>)
  private
  public
    constructor Create(OwnsObjects: Boolean = True);
    destructor Destroy(); override;
    function ObjectOf(callsign: string): TOperatorInfo;
    procedure SaveToIniFile();
    procedure LoadFromIniFile();
  end;

implementation

constructor TOperatorInfo.Create();
begin
   Inherited;
   FCallsign := '';
   FPower := '';
   FAge := '';
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

         Add(obj);
      end;
   finally
      ini.Free();
      SL.Free();
   end;
end;

end.
