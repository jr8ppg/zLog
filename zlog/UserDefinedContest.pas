unit UserDefinedContest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Forms,
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
    FCwMessageA: array[1..8] of string;
    FCwMessageB: array[1..8] of string;
  private
    function GetCwMessageA(Index: Integer): string;
    procedure SetCwMessageA(Index: Integer; v: string);
    function GetCwMessageB(Index: Integer): string;
    procedure SetCwMessageB(Index: Integer; v: string);
  public
    constructor Create();
    class function Parse(strPath: string): TUserDefinedContest; static;
    property Fullpath: string read FFullpath write FFullpath;
    property Filename: string read FFileName write FFileName;
    property ContestName: string read FContestName write FContestName;
    property Prov: string read FProv write FProv;
    property City: string read FCity write FCity;
    property Power: string read FPower write FPower;
    property DatFile: string read FDatFile write FDatFile;
    property Coeff: Boolean read FCoeff write FCoeff;
    property CwMessageA[Index: Integer]: string read GetCwMessageA write SetCwMessageA;
    property CwMessageB[Index: Integer]: string read GetCwMessageB write SetCwMessageB;
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

class function TUserDefinedContest.Parse(strPath: string): TUserDefinedContest;
var
   F: TextFile;
   strLine: string;
   strCmd: string;
   strParam: string;
   p: Integer;
   D: TUserDefinedContest;
begin
   D := TUserDefinedContest.Create();
   try
      AssignFile(F, strPath);
      Reset(F);

      while(Eof(F) = False) do begin
         ReadLn(F, strLine);

         strLine := Trim(strLine);

         if strLine = '' then begin
            Continue;
         end;

         if strLine[1] = ';' then begin
            Continue;
         end;

         if strLine[1] = '#' then begin
            D.ContestName := Copy(strLine, 2);
            Continue;
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
            Continue;
         end;

         strCmd := Trim(Copy(strLine, 1, p - 1));
         strParam := Trim(Copy(strLine, p + 1));

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

      CloseFile(F);
   finally
      Result := D;
   end;
end;

function TUserDefinedContest.GetCwMessageA(Index: Integer): string;
begin
   Result := FCwMessageA[Index];
end;

procedure TUserDefinedContest.SetCwMessageA(Index: Integer; v: string);
begin
   FCwMessageA[Index] := v;
end;

function TUserDefinedContest.GetCwMessageB(Index: Integer): string;
begin
   Result := FCwMessageB[Index];
end;

procedure TUserDefinedContest.SetCwMessageB(Index: Integer; v: string);
begin
   FCwMessageB[Index] := v;
end;

{ TUserDefinedContestList }

constructor TUserDefinedContestList.Create(OwnsObjects: Boolean = True);
begin
   Inherited Create(OwnsObjects);
end;

end.
