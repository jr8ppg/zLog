unit UserDefinedContest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.StrUtils, Vcl.Forms,
  Generics.Collections, Generics.Defaults;

type
  TUserDefinedContest = class(TObject)
    FFullpath: string;
    FFileName: string;
    FContestName: string;
    FProv: string;
    FCity: string;
    FPower: string;
    FDatFile: string;
    FCoeff: Boolean;
    FSent: string;
    FCwMessageA: array[1..8] of string;
    FCwMessageB: array[1..8] of string;
    FCfgSource: TStringList;
  private
    procedure SetFullPath(v: string);
    function GetCwMessageA(Index: Integer): string;
    procedure SetCwMessageA(Index: Integer; v: string);
    function GetCwMessageB(Index: Integer): string;
    procedure SetCwMessageB(Index: Integer; v: string);
    procedure SetSent(v: string);
    procedure SetProv(v: string);
    procedure SetCity(v: string);
    procedure SetPower(v: string);
    function ParseCommand(strLine: string; var strCmd, strParam: string): Boolean;
    procedure EditParam(strCommand, strNewValue: string);
  public
    constructor Create(); overload;
    constructor Create(strFullPath: string); overload;
    destructor Destroy(); override;
    procedure Load();
    procedure Save();
    class function Parse(strPath: string): TUserDefinedContest; static;
    property Fullpath: string read FFullpath write SetFullpath;
    property Filename: string read FFileName write FFileName;
    property ContestName: string read FContestName write FContestName;
    property Prov: string read FProv write SetProv;
    property City: string read FCity write SetCity;
    property Power: string read FPower write SetPower;
    property DatFile: string read FDatFile write FDatFile;
    property Coeff: Boolean read FCoeff write FCoeff;
    property Sent: string read FSent write SetSent;
    property CwMessageA[Index: Integer]: string read GetCwMessageA write SetCwMessageA;
    property CwMessageB[Index: Integer]: string read GetCwMessageB write SetCwMessageB;
    property CfgSource: TStringList read FCfgSource;
  end;

  TUserDefinedContestList = class(TObjectList<TUserDefinedContest>)
  public
    constructor Create(OwnsObjects: Boolean = True);
  end;

implementation

{ TUserDefinedContest }

constructor TUserDefinedContest.Create();
var
   i: Integer;
begin
   Inherited;
   FCfgSource := TStringList.Create();
   FFullpath := '';
   FFileName := '';
   FContestName := '';
   FProv := '';
   FCity := '';
   FPower := '';
   FDatFile := '';
   FCoeff := False;
   for i := 1 to 8 do begin
      FCwMessageA[i] := '';
      FCwMessageB[i] := '';
   end;
end;

constructor TUserDefinedContest.Create(strFullPath: string);
begin
   Create();
   FullPath := strFullPath;
end;

destructor TUserDefinedContest.Destroy();
begin
   Inherited;
   FCfgSource.Free();
end;

procedure TUserDefinedContest.Load();
begin
   FCfgSource.LoadFromFile(FFullPath);
end;

procedure TUserDefinedContest.Save();
begin
   FCfgSource.SaveToFile(FFullPath);
end;

class function TUserDefinedContest.Parse(strPath: string): TUserDefinedContest;
var
   strLine: string;
   strCmd: string;
   strParam: string;
   D: TUserDefinedContest;
   i: Integer;
begin
   D := TUserDefinedContest.Create(strPath);
   try
      D.Load();

      for i := 0 to D.CfgSource.Count - 1 do begin
         strLine := D.CfgSource[i];

         strLine := Trim(strLine);

         if D.ParseCommand(strLine, strCmd, strParam) = False then begin
            Continue;
         end;

         if strCmd = 'PROV' then begin
            D.Prov := strParam;
         end
         else if strCmd = 'CITY' then begin
            D.City := strParam;
         end
         else if strCmd = 'POWER' then begin
            D.Power := strParam;
         end
         else if strCmd = 'DAT' then begin
            D.DatFile := strParam;
         end
         else if strCmd = 'COEFF' then begin
            if strParam = 'ON' then begin
               D.Coeff := True;
            end
            else begin
               D.Coeff := False;
            end;
         end
         else if strCmd = 'SENDNR' then begin
            D.Sent := strParam;
         end
         else if strCmd = 'F1_A' then begin
            D.FCwMessageA[1] := strParam;
         end
         else if strCmd = 'F2_A' then begin
            D.FCwMessageA[2] := strParam;
         end
         else if strCmd = 'F3_A' then begin
            D.FCwMessageA[3] := strParam;
         end
         else if strCmd = 'F4_A' then begin
            D.FCwMessageA[4] := strParam;
         end
         else if strCmd = 'F5_A' then begin
            D.FCwMessageA[5] := strParam;
         end
         else if strCmd = 'F6_A' then begin
            D.FCwMessageA[6] := strParam;
         end
         else if strCmd = 'F7_A' then begin
            D.FCwMessageA[7] := strParam;
         end
         else if strCmd = 'F8_A' then begin
            D.FCwMessageA[8] := strParam;
         end
         else if strCmd = 'F1_B' then begin
            D.FCwMessageB[1] := strParam;
         end
         else if strCmd = 'F2_B' then begin
            D.FCwMessageB[2] := strParam;
         end
         else if strCmd = 'F3_B' then begin
            D.FCwMessageB[3] := strParam;
         end
         else if strCmd = 'F4_B' then begin
            D.FCwMessageB[4] := strParam;
         end
         else if strCmd = 'F5_B' then begin
            D.FCwMessageB[5] := strParam;
         end
         else if strCmd = 'F6_B' then begin
            D.FCwMessageB[6] := strParam;
         end
         else if strCmd = 'F7_B' then begin
            D.FCwMessageB[7] := strParam;
         end
         else if strCmd = 'F8_B' then begin
            D.FCwMessageB[8] := strParam;
         end;
      end;
   finally
      Result := D;
   end;
end;

procedure TUserDefinedContest.SetFullPath(v: string);
begin
   FFullPath := v;
   FFilename := ExtractFileName(v);
end;

function TUserDefinedContest.GetCwMessageA(Index: Integer): string;
begin
   Result := FCwMessageA[Index];
end;

procedure TUserDefinedContest.SetCwMessageA(Index: Integer; v: string);
begin
   FCwMessageA[Index] := v;
   EditParam('F' + IntToStr(Index) + '_A', v);
end;

function TUserDefinedContest.GetCwMessageB(Index: Integer): string;
begin
   Result := FCwMessageB[Index];
end;

procedure TUserDefinedContest.SetCwMessageB(Index: Integer; v: string);
begin
   FCwMessageB[Index] := v;
end;

procedure TUserDefinedContest.SetSent(v: string);
begin
   FSent := v;
   EditParam('SENDNR', v);
end;

procedure TUserDefinedContest.SetProv(v: string);
begin
   FProv := v;
   EditParam('PROV', v);
end;

procedure TUserDefinedContest.SetCity(v: string);
begin
   FCity := v;
   EditParam('CITY', v);
end;

procedure TUserDefinedContest.SetPower(v: string);
begin
   v := LeftStr(v + '----------------', 13);
   FPower := v;
   EditParam('POWER', v);
end;

function TUserDefinedContest.ParseCommand(strLine: string; var strCmd, strParam: string): Boolean;
var
   p: Integer;
begin
   if strLine = '' then begin
      Result := False;
      Exit;
   end;

   if strLine[1] = ';' then begin
      Result := False;
      Exit;
   end;

   if strLine[1] = '#' then begin
      ContestName := Copy(strLine, 2);
      Result := False;
      Exit;
   end;

   p := Pos(';', strLine);
   if p > 0 then begin
      strLine := Copy(strLine, 1, p - 1);
   end;

   strLine := UpperCase(strLine);

   p := Pos(#$09, strLine);
   if p = 0 then begin
      p := Pos(' ', strLine);
   end;

   if p = 0 then begin
      Result := False;
      Exit;
   end;

   strCmd := Trim(Copy(strLine, 1, p - 1));
   strParam := Trim(Copy(strLine, p + 1));

   Result := True;
end;

procedure TUserDefinedContest.EditParam(strCommand, strNewValue: string);
var
   i: Integer;
   strLine: string;
   strCmd: string;
   strParam: string;
begin
   for i := 0 to CfgSource.Count - 1 do begin
      strLine := CfgSource[i];
      strLine := Trim(strLine);
      if ParseCommand(strLine, strCmd, strParam) = False then begin
         Continue;
      end;

      if strCmd = strCommand then begin
         CfgSource[i] := StringReplace(CfgSource[i], strParam, strNewValue, [rfReplaceAll]);
         Exit;
      end;
   end;

   // ñ≥Ç©Ç¡ÇΩÅI
   CfgSource.Add(strCommand + #09 + strNewValue + ';');
end;

{ TUserDefinedContestList }

constructor TUserDefinedContestList.Create(OwnsObjects: Boolean = True);
begin
   Inherited Create(OwnsObjects);
end;

end.
