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
    { Private éŒ¾ }
public
    { Public éŒ¾ }
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

end.
