unit UzLogGlobal;

interface

uses
  System.SysUtils, System.Classes, StrUtils, IniFiles, Forms, Windows, Menus,
  System.Math, Vcl.Graphics,
  UzLogConst, UzLogQSO;

var
  UseUTC : boolean = False;

var
  GLOBALSERIAL : integer = 0;
  ZLOCOUNT : integer = 0;

type
  TdmZLogGlobal = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private 宣言 }
    FErrorLogFileName: string;
public
    { Public 宣言 }
    FLog : TLog;

    procedure ReadWindowState(form: TForm; strWindowName: string = ''; fPositionOnly: Boolean = False);
    procedure WriteWindowState(form: TForm; strWindowName: string = '');
    procedure ReadMainFormState(var X, Y, W, H: integer; var TB1, TB2: boolean);
    procedure WriteMainFormState(X, Y, W, H: integer; TB1, TB2: boolean);

    procedure CreateLog();

    function NewQSOID(): Integer;
    procedure WriteErrorLog(msg: string);
  end;

function Log(): TLog;
function Random10 : integer;
function UTCOffset : integer;   //in minutes; utc = localtime + utcoffset
function kHzStr(Hz : integer) : string;
procedure IncEditCounter(aQSO : TQSO);
function ExtractKenNr(S : string) : string; //extracts ken nr from aja#+power
function ExtractPower(S : string) : string;
function IsSHF(B : TBand) : boolean; // true if b >= 2400MHz
function IsMM(S : string) : boolean; // return true if Marine Mobile S is a callsign
function IsWVE(S : string) : boolean; // returns true if W/VE/KH6/KL7 S is country px NOT callsign
function GetHour(T : TDateTime) : integer;
function CurrentTime : TDateTime; {returns in UTC or local time }
function LowCase(C : Char) : Char;
function OldBandOrd(band : TBand) : integer;
function NotWARC(band : TBand) : boolean;
function IsWARC(Band: TBand): Boolean;
function StrMore(a, b : string) : boolean; // true if a>b
function PXMore(a, b : string) : boolean; // JA1 > XE
function PXIndex(s : string) : integer; // AA = 0 AB = 1 etc
function PXMoreX(a, b : string) : boolean; // double char index
function HexStrToInt(str : string) : integer;
function Less(x, y : integer): integer;
function More(x, y : integer): integer;
function FillRight(s : string; len : integer) : string;
function FillLeft(s : string; len : integer) : string;
function GetUTC: TDateTime;
function CoreCall(call : string) : string;
procedure CenterWindow(formParent, formChild: TForm);
function Power(base, Power: integer): integer;

function StrToBandDef(strMHz: string; defband: TBand): TBand;
function StrToModeDef(strMode: string; defmode: TMode): TMode;
function GetBandIndex(Hz: Integer; default: Integer = -1): Integer; // Returns -1 if Hz is outside ham bands

function ZBoolToStr(fValue: Boolean): string;
function ZStrToBool(strValue: string): Boolean;

function ZStringToColorDef(str: string; defcolor: TColor): TColor;
function IsDomestic(strCallsign: string): Boolean;
function CheckDiskFreeSpace(strPath: string; nNeed_MegaByte: Integer): Boolean;

//procedure SetQsyViolation(aQSO: TQSO);
//procedure ResetQsyViolation(aQSO: TQSO);
procedure SetDupeQso(aQSO: TQSO);
procedure ResetDupeQso(aQSO: TQSO);

function TextToBand(text: string): TBand;
function TextToMode(text: string): TMode;

function LoadFromResourceName(hinst: THandle; filename: string): TStringList;
function TrimCRLF(SS : string) : string;

var
  dmZLogGlobal: TdmZLogGlobal;

implementation

{$R *.dfm}

procedure TdmZLogGlobal.DataModuleCreate(Sender: TObject);
begin
   FLog := nil;
end;

procedure TdmZLogGlobal.DataModuleDestroy(Sender: TObject);
begin
   FLog.Free();
end;

procedure TdmZLogGlobal.ReadWindowState(form: TForm; strWindowName: string; fPositionOnly: Boolean );
var
   ini: TIniFile;
   l, t, w, h: Integer;
   pt: TPoint;
   mon: TMonitor;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      if strWindowName = '' then begin
         strWindowName := form.Name;
      end;

      l := ini.ReadInteger('Windows', strWindowName + '_X', -1);
      t := ini.ReadInteger('Windows', strWindowName + '_Y', -1);
      h := ini.ReadInteger('Windows', strWindowName + '_H', -1);
      w := ini.ReadInteger('Windows', strWindowName + '_W', -1);

      form.Visible := ini.ReadBool('Windows', strWindowName + '_Open', False);

      pt.X := l;
      pt.Y := t;
      mon := Screen.MonitorFromPoint(pt, mdNearest);
      if l < mon.Left then begin
         l := mon.Left;
      end;
      if (l + w) > (mon.Left + mon.Width) then begin
         l := (mon.Left + mon.Width) - w;
      end;
      if t < mon.Top then begin
         t := mon.Top;
      end;
      if (t + h) > (mon.Top + mon.Height) then begin
         t := (mon.Top + mon.Height) - H;
      end;

      form.Left := l;
      form.Top := t;

      if fPositionOnly = False then begin
         if h >= 0 then begin
            form.Height  := ini.ReadInteger('Windows', strWindowName + '_H', -1);
         end;
         if w >= 0 then begin
            form.Width   := ini.ReadInteger('Windows', strWindowName + '_W', -1);
         end;
      end;
   finally
      ini.Free();
   end;
end;

procedure TdmZLogGlobal.WriteWindowState(form: TForm; strWindowName: string);
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      if strWindowName = '' then begin
         strWindowName := form.Name;
      end;

      ini.WriteBool('Windows', strWindowName + '_Open', form.Visible);
      ini.WriteInteger('Windows', strWindowName + '_X', form.Left);
      ini.WriteInteger('Windows', strWindowName + '_Y', form.Top);
      ini.WriteInteger('Windows', strWindowName + '_H', form.Height);
      ini.WriteInteger('Windows', strWindowName + '_W', form.Width);
   finally
      ini.Free();
   end;
end;

procedure TdmZLogGlobal.ReadMainFormState(var X, Y, W, H: integer; var TB1, TB2: boolean);
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      X := ini.ReadInteger('Windows', 'Main_X', 0);
      Y := ini.ReadInteger('Windows', 'Main_Y', 0);
      W := ini.ReadInteger('Windows', 'Main_W', 0);
      H := ini.ReadInteger('Windows', 'Main_H', 0);
      TB1 := ini.ReadBool('Windows', 'Main_ToolBar1', False);
      TB2 := ini.ReadBool('Windows', 'Main_ToolBar2', False);
   finally
      ini.Free();
   end;
end;

procedure TdmZLogGlobal.WriteMainFormState(X, Y, W, H: integer; TB1, TB2: boolean);
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      ini.WriteInteger('Windows', 'Main_X', X);
      ini.WriteInteger('Windows', 'Main_Y', Y);
      ini.WriteInteger('Windows', 'Main_W', W);
      ini.WriteInteger('Windows', 'Main_H', H);
      ini.WriteBool('Windows', 'Main_ToolBar1', TB1);
      ini.WriteBool('Windows', 'Main_ToolBar2', TB2);
   finally
      ini.Free();
   end;
end;

procedure TdmZLogGlobal.CreateLog();
begin
   if FLog <> nil then begin
      FLog.Free();
   end;
   FLog := TLog.Create('default');
end;

function TdmZLogGlobal.NewQSOID(): Integer;
var
   tt, ss, rr: integer;
begin
   tt := 21;
   if tt > 21 then
      tt := 21;

   ss := GLOBALSERIAL;
   inc(GLOBALSERIAL);
   if GLOBALSERIAL > 9999 then
      GLOBALSERIAL := 0;

   rr := random(100);

   Result := tt * 100000000 + ss * 10000 + rr * 100;
end;

procedure TdmZLogGlobal.WriteErrorLog(msg: string);
var
   str: string;
   txt: TextFile;
begin
   AssignFile(txt, FErrorLogFileName);
   if FileExists(FErrorLogFileName) then begin
      Reset(txt);
   end
   else begin
      Rewrite(txt);
   end;

   str := FormatDateTime( 'yyyy/mm/dd hh:nn:ss ', Now ) + msg;

   Append( txt );
   WriteLn( txt, str );
   Flush( txt );
   CloseFile( txt );
end;

function Log(): TLog;
begin
   Result := dmZLogGlobal.FLog;
end;

function Random10: integer;
var
   H, M, S, ms: word;
begin
   DecodeTime(Now, H, M, S, ms);
   Result := S mod 10;
end;

function UTCOffset: integer;
var
   TZinfo: TTimeZoneInformation;
begin
   GetTimeZoneInformation(TZinfo);
   Result := TZinfo.Bias;
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

procedure IncEditCounter(aQSO: TQSO);
begin
   if aQSO.Reserve3 mod 100 < 99 then begin
      aQSO.Reserve3 := aQSO.Reserve3 + 1;
   end;
end;

function ExtractKenNr(S: string): string; // extracts ken nr from aja#+power
var
   str: string;
begin
   Result := '';
   str := copy(S, 1, 2);
   Result := str;
end;

function ExtractPower(S: string): string; // extracts power code. returns '' if no power
begin
   Result := '';

   if S = '' then begin
      exit;
   end;

   if CharInSet(S[length(S)], ['H', 'M', 'L', 'P']) then begin
      Result := S[length(S)];
   end;
end;

function IsSHF(B: TBand): Boolean; // true if b >= 2400MHz
begin
   Result := (B >= b2400);
end;

function IsMM(S: string): Boolean;
begin
   if Pos('/MM', S) > 0 then
      Result := True
   else
      Result := false;
end;

function IsWVE(S: string): Boolean;
begin
   if (S = 'K') or (S = 'W') or (S = 'N') or (S = 'KH6') or (S = 'KL7') or (S = 'KL') or (S = 'VE') then
      Result := True
   else
      Result := false;
end;

function GetLocale: String;
var
   Buf: PChar;
begin
   Buf := StrAlloc(256);
   GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_SENGCOUNTRY, Buf, 256);
   Result := StrPas(Buf);
   StrDisPose(Buf);
end;

function GetHour(T: TDateTime): integer;
var
   H, M, S, ms: word;
begin
   DecodeTime(T, H, M, S, ms);
   Result := H;
end;

function CurrentTime: TDateTime;
begin
   if UseUTC then
      Result := GetUTC
   else
      Result := Now;
end;

function LowCase(C: Char): Char;
begin
   if CharInSet(C, ['A' .. 'Z']) then
      Result := Chr(ord(C) - ord('A') + ord('a'))
   else
      Result := C;
end;

function OldBandOrd(Band: TBand): integer;
begin
   case Band of
      b19 .. b7:
         Result := ord(Band);
      b14:
         Result := ord(Band) - 1;
      b21:
         Result := ord(Band) - 2;
      b28 .. HiBand:
         Result := ord(Band) - 3;
      else
         Result := 0;
   end;
end;

function NotWARC(Band: TBand): Boolean;
begin
   if Band in [b10, b18, b24] then
      Result := false
   else
      Result := True;
end;

function IsWARC(Band: TBand): Boolean;
begin
   if Band in [b10, b18, b24] then
      Result := True
   else
      Result := False;
end;

function GetUTC: TDateTime;
var
   stUTC: TSystemTime;
begin
   GetSystemTime(stUTC);
   // TDateTimes are doubles with the time expressed as the
   // fractional component so we can add them together in
   // this situation
   Result := EncodeDate(stUTC.wYear, stUTC.wMonth, stUTC.wDay) + EncodeTime(stUTC.wHour, stUTC.wMinute, stUTC.wSecond, stUTC.wMilliseconds);
end;

function StrMore(A, B: string): Boolean; { true if a>b }
var
   i: Integer;
begin
   for i := 1 to Less(length(A), length(B)) do begin
      if ord(A[i]) > ord(B[i]) then begin
         Result := True;
         exit;
      end;
      if ord(A[i]) < ord(B[i]) then begin
         Result := false;
         exit;
      end;
   end;
   if length(A) > length(B) then
      Result := True
   else
      Result := false;
end;

function PXMore(A, B: string): Boolean; { true if a>b }
begin
   if A[1] = B[1] then begin
      if length(A) > length(B) then begin
         Result := false;
         exit;
      end;

      if length(A) < length(B) then begin
         Result := True;
         exit;
      end;

      Result := StrMore(A, B);

      exit;
   end;

   Result := StrMore(A, B);
end;

function PXIndex(S: string): integer;
var
   i, j: integer;
begin
   Result := 0;
   if length(S) = 0 then
      exit;
   if length(S) = 1 then begin
      case S[1] of
         'A' .. 'Z':
            Result := ord(S[1]) - ord('A') + 37 * 37;
         '0' .. '9':
            Result := ord(S[1]) - ord('0') + 37 * 37 + 26;
         '/':
            Result := 37 * 37 + 36;
      end;
   end
   else begin
      i := 0;
      j := 0;
      case S[1] of
         'A' .. 'Z':
            i := ord(S[1]) - ord('A');
         '0' .. '9':
            i := ord(S[1]) - ord('0') + 26;
         '/':
            i := 36;
      end;
      case S[2] of
         'A' .. 'Z':
            i := ord(S[2]) - ord('A');
         '0' .. '9':
            i := ord(S[2]) - ord('0') + 26;
         '/':
            i := 36;
      end;
      Result := i * 37 + j;
   end;
end;

function PXMoreX(A, B: string): Boolean; { true if a>b }
var
   PXA, PXB: integer;
begin
   PXA := PXIndex(A);
   PXB := PXIndex(B);
   if PXA = PXB then begin
      if length(A) > length(B) then begin
         Result := false;
         exit;
      end;
      if length(A) < length(B) then begin
         Result := True;
         exit;
      end;
      Result := StrMore(A, B);
      exit;
   end;
   Result := PXA > PXB;
end;

function HexStrToInt(str: string): integer;
var
   i, j, digit: integer;
begin
   i := 0;
   for j := length(str) downto 1 do begin
      case str[j] of
         '0' .. '9':
            digit := ord(str[j]) - ord('0');
         'a' .. 'f':
            digit := ord(str[j]) - ord('a') + 10;
         'A' .. 'F':
            digit := ord(str[j]) - ord('A') + 10;
         else begin
               Result := -1;
               exit;
            end;
      end;
      i := i + Power(16, length(str) - j) * digit;
   end;
   Result := i;
end;

function Less(x, y: integer): integer;
begin
   if x > y then
      Result := y
   else
      Result := x;
end;

function More(x, y: integer): integer;
begin
   if x > y then
      Result := x
   else
      Result := y;
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

function CoreCall(call: string): string;
var
   p: integer;
   str: string;
begin
   str := call;
   p := Pos('/', str);
   if p > 4 then
      Delete(str, p, 255);
   Result := str;
end;

procedure CenterWindow(formParent, formChild: TForm);
begin
   formChild.Left := formParent.Left + ((formParent.Width - formChild.Width) div 2);
   formChild.Top := formParent.Top + ((formParent.Height - formChild.Height) div 2);
end;

function Power(base, Power: integer): integer;
var
   i, j: integer;
begin
   j := 1;
   for i := 1 to Power do
      j := j * base;
   Result := j;
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

function Compare2(strTarget: string; strCompare: string): Boolean;
var
   i: Integer;
   n1: Integer;
   n2: Integer;
   match_cnt: Integer;
begin
   n1 := Length(strTarget);
   n2 := Length(strCompare);

   if n1 > n2 then begin
      strCompare := strCompare + DupeString(' ', n1 - n2);
   end
   else if n2 > n1 then begin
      strTarget := strTarget + DupeString(' ', n2 - n1);
   end;

   n1 := Length(strTarget);
   match_cnt := 0;
   for i := 1 to n1 do begin
      if strTarget[i] = strCompare[i] then begin
         Inc(match_cnt);
      end;
   end;

   if match_cnt >= (n1 - 1) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
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
   if (strValue = '0') or (strValue = '') then begin
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

function ZColorToString(color: TColor): string;
begin
   Result := '$' + IntToHex(color, 8);
end;

function ExPos(substr, str: string): Integer;
var
   i, j: integer;
   bad: boolean;
begin
   Result := 0;
   if (Length(substr) > Length(str)) or (substr = '') then
      exit;
   for i := 1 to (Length(str) - Length(substr) + 1) do begin
      bad := false;
      for j := 1 to Length(substr) do begin
         if substr[j] <> '?' then
            if substr[j] <> str[i + j - 1] then
               bad := true;
      end;
      if bad = false then begin
         Result := i;
         exit;
      end;
   end;
end;

// JA1?JS1, 7J1, 8J1?8N1, 7K1?7N4
// JA2?JS2, 7J2, 8J2?8N2
// JA3?JS3, 7J3, 8J3?8N3
// JA4?JS4, 7J4, 8J4?8N4
// JA5?JS5, 7J5, 8J5?8N5
// JA6?JS6, 7J6, 8J6?8N6
// JA7?JS7, 7J7, 8J7?8N7
// JA8?JS8, 7J8, 8J8?8N8
// JA9?JS9, 7J9, 8J9?8N9
// JA0?JS0, 7J0, 8J0?8N0
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

procedure SetQsyViolation(aQSO: TQSO);
begin
   if Pos(MEMO_QSY_VIOLATION, aQSO.Memo) > 0 then begin
      Exit;
   end;

   if aQSO.Memo <> '' then begin
      aQSO.Memo := aQSO.Memo + ' ';
   end;

   aQSO.Memo := aQSO.Memo + MEMO_QSY_VIOLATION;
end;

procedure ResetQsyViolation(aQSO: TQSO);
begin
   aQSO.Memo := Trim(StringReplace(aQSO.Memo, MEMO_QSY_VIOLATION, '', [rfReplaceAll]));
end;

procedure SetDupeQso(aQSO: TQSO);
begin
   aQSO.Points := 0;
   aQSO.Dupe := True;
end;

procedure ResetDupeQso(aQSO: TQSO);
begin
   aQSO.Dupe := False;
   aQSO.Memo := Trim(StringReplace(aQSO.Memo, MEMO_DUPE, '', [rfReplaceAll]));
end;

function TextToBand(text: string): TBand;
var
   b: TBand;
begin
   for b := Low(MHzString) to High(MHzString) do begin
      if MHzString[b] = text then begin
         Result := b;
         Exit;
      end;
   end;
   Result := bUnknown;
end;

function TextToMode(text: string): TMode;
var
   m: TMode;
begin
   for m := Low(ModeString) to High(ModeString) do begin
      if ModeString[m] = text then begin
         Result := m;
         Exit;
      end;
   end;
   Result := mOther;
end;

function LoadFromResourceName(hinst: THandle; filename: string): TStringList;
var
   RS: TResourceStream;
   SL: TStringList;
   resname: string;
begin
   resname := 'IDF_' + StringReplace(filename, '.', '_', [rfReplaceAll]);

   RS := TResourceStream.Create(hinst, resname, RT_RCDATA);
   SL := TStringList.Create();
   SL.StrictDelimiter := True;
   try
      SL.LoadFromStream(RS);
   finally
      RS.Free();
      Result := SL;
   end;
end;

function TrimCRLF(SS : string) : string;
var
   S: string;
begin
   S := SS;
   while (length(S) > 0) and ((S[1] = Chr($0A)) or (S[1] = Chr($0D))) do begin
      Delete(S, 1, 1);
   end;

   while (length(S) > 0) and ((S[length(S)] = Chr($0A)) or (S[length(S)] = Chr($0D))) do begin
      Delete(S, length(S), 1);
   end;

   Result := S;
end;

end.
