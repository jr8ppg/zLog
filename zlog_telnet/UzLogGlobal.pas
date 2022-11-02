unit UzLogGlobal;

interface

uses
  System.SysUtils, System.Classes, StrUtils, IniFiles, Forms, Windows, Menus,
  System.Math, Vcl.Graphics, UzLogConst;

type
  TdmZLogGlobal = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private 宣言 }
public
    { Public 宣言 }
  end;

function kHzStr(Hz : integer) : string;
function FillRight(S: string; len: integer): string;
function FillLeft(S: string; len: integer): string;

function StrToBandDef(strMHz: string; defband: TBand): TBand;
function StrToModeDef(strMode: string; defmode: TMode): TMode;
function GetBandIndex(Hz: Integer; default: Integer = -1): Integer; // Returns -1 if Hz is outside ham bands

function ZBoolToStr(fValue: Boolean): string;
function ZStrToBool(strValue: string): Boolean;

function ZStringToColorDef(str: string; defcolor: TColor): TColor;

function IsDomestic(strCallsign: string): Boolean;
function CheckDiskFreeSpace(strPath: string; nNeed_MegaByte: Integer): Boolean;

var
  dmZLogGlobal: TdmZLogGlobal;

implementation

{$R *.dfm}

procedure TdmZLogGlobal.DataModuleCreate(Sender: TObject);
begin
//
end;

procedure TdmZLogGlobal.DataModuleDestroy(Sender: TObject);
begin
//
end;

function kHzStr(Hz: integer): string;
var
   k, kk: integer;
begin
   k := Hz div 1000;
   kk := Hz mod 1000;
   kk := kk div 100;
   if k > 100000 then
      Result := IntToStr(k)
   else
      Result := IntToStr(k) + '.' + IntToStr(kk);
end;

function FillRight(S: string; len: integer): string;
var
   sjis: AnsiString;
begin
   sjis := AnsiString(S);
   sjis := sjis + AnsiString(DupeString(' ', len));
   sjis := Copy(sjis, 1, len);
   Result := String(sjis);
end;

function FillLeft(S: string; len: integer): string;
var
   sjis: AnsiString;
begin
   sjis := AnsiString(S);
   sjis := AnsiString(DupeString(' ', len)) + sjis;
   sjis := Copy(sjis, Length(sjis) - len + 1, len);
   Result := String(sjis);
end;

function StrToBandDef(strMHz: string; defband: TBand): TBand;
var
   i: TBand;
begin
   for i := Low(BandString) to High(BandString) do begin
      if MHzString[i] = strMHz then begin
         Result := TBand(i);
         Exit;
      end;
   end;
   Result := defband;
end;

function StrToModeDef(strMode: string; defmode: TMode): TMode;
var
   i: TMode;
begin
   for i := Low(ModeString) to High(ModeString) do begin
      if ModeString[i] = strMode then begin
         Result := TMode(i);
         Exit;
      end;
   end;
   Result := defmode;
end;

function GetBandIndex(Hz: Integer; default: Integer): Integer; // Returns -1 if Hz is outside ham bands
var
   i: Integer;
begin
   i := default;
   case Hz div 1000 of
      1800 .. 1999:
         i := 0;
      3000 .. 3999:
         i := 1;
      6900 .. 7999:
         i := 2;
      9900 .. 11000:
         i := 3;
      13900 .. 14999:
         i := 4;
      17500 .. 18999:
         i := 5;
      20900 .. 21999:
         i := 6;
      23500 .. 24999:
         i := 7;
      27800 .. 29999:
         i := 8;
      49000 .. 59000:
         i := 9;
      140000 .. 149999:
         i := 10;
      400000 .. 450000:
         i := 11;
      1200000 .. 1299999:
         i := 12;
      2400000..2499999:
         i := 13;
      5600000..5699999:
         i := 14;
      10000000..90000000:
         i := 15;
   end;

   Result := i;
end;

function ZBoolToStr(fValue: Boolean): string;
begin
   if fValue = True then begin
      Result := '1';
   end
   else begin
      Result := '0';
   end;
end;

function ZStrToBool(strValue: string): Boolean;
begin
   if strValue = '0' then begin
      Result := False;
   end
   else begin
      Result := True;
   end;
end;

function ZStringToColorDef(str: string; defcolor: TColor): TColor;
begin
   if StrToIntDef( str, -1 ) >= 0 then begin
      Result := StringToColor( str );
   end
   else begin
      Result := defcolor;
   end;
end;

// JA1–JS1, 7J1, 8J1–8N1, 7K1–7N4
// JA2–JS2, 7J2, 8J2–8N2
// JA3–JS3, 7J3, 8J3–8N3
// JA4–JS4, 7J4, 8J4–8N4
// JA5–JS5, 7J5, 8J5–8N5
// JA6–JS6, 7J6, 8J6–8N6
// JA7–JS7, 7J7, 8J7–8N7
// JA8–JS8, 7J8, 8J8–8N8
// JA9–JS9, 7J9, 8J9–8N9
// JA0–JS0, 7J0, 8J0–8N0
function IsDomestic(strCallsign: string): Boolean;
var
   S1: Char;
   S2: Char;
   S3: Char;
begin
   S1 := strCallsign[1];
   S2 := strCallsign[2];
   S3 := strCallsign[3];

   if S1 = 'J' then begin
      if (S2 >= 'A') and (S2 <= 'S') then begin
         Result := True;
         Exit;
      end;
   end;

   if (S1 = '7') and (S2 = 'J') then begin
      Result := True;
      Exit;
   end;

   if S1 = '7' then begin
      if (S2 >= 'K') and (S2 <= 'N') then begin
         if (S3 >= '1') and (S3 <= '4') then begin
            Result := True;
            Exit;
         end;
      end;
   end;

   if S1 = '8' then begin
      if (S2 >= 'J') and (S2 <= 'N') then begin
         Result := True;
         Exit;
      end;
   end;

   Result := False;
end;

function CheckDiskFreeSpace(strPath: string; nNeed_MegaByte: Integer): Boolean;
var
   nAvailable: TLargeInteger;
   nTotalBytes: TLargeInteger;
   nTotalFreeBytes: TLargeInteger;
   nNeedBytes: TLargeInteger;
begin
   nNeedBytes := TLargeInteger(nNeed_MegaByte) * TLargeInteger(1024) * TLargeInteger(1024);

   // 空き容量取得
   if GetDiskFreeSpaceEx(PWideChar(strPath), nAvailable, nTotalBytes, @nTotalFreeBytes) = False then begin
      Result := False;
      Exit;
   end;

   // 空き領域は必要としている容量未満か
   if (nTotalFreeBytes < nNeedBytes) then begin
      Result := False;
      Exit;
   end;

   Result := True;
end;

end.
