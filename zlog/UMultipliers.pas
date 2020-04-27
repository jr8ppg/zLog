unit UMultipliers;

interface

uses
  SysUtils, Windows, Classes, Dialogs, Forms, UITypes, UzLogGlobal;

const testCQWW = $03;
      MAXCQZONE = 40;
      testIARU = $09;
      testDXCCWWZone = $05;
      MaxIndex = 37*37+36;
var
      _DATFileName : string = '';

type
  TCountry = class
    Country : string[40]; {JA, KH6 etc}
    CountryName : string[40]; {Japan, Hawaii, etc}
    Zone : integer;
    Continent : string[3];
    Worked : array[b19..HiBand] of boolean;
    GridIndex : integer;  // where it is listed in the Grid (row)
    constructor Create;
    function Summary : string;
    function SummaryWAE : string;
    function Summary2 : string;
    function SummaryARRL10 : string;
    function SummaryGeneral : string;
    function JustInfo : string; // returns cty name, px and continent
  end;

  TCountryList = class
    List : TList;
    constructor Create;
    destructor Destroy; override;
    procedure Reset;
  end;

  TPrefix = class
    Prefix : string[12];
    Index : integer;
    Length : integer;
    OvrZone : integer;         // override zone
    OvrContinent : string[3];  // override continent
    constructor Create;
  end;

  TPrefixList = class
    ListIndexX : array[0..MaxIndex] of integer;
    List : TList;
    constructor Create;
    destructor Destroy; override;
    procedure AddListX(PX : TPrefix);
    procedure InitIndexX;
  end;

  TCity = class
    CityNumber : string;
    CityName : string;
    PrefNumber : string;
    PrefName : string;
    Worked : array[b19..HiBand] of boolean;
    Index : integer;
    constructor Create;
    function Abbrev : string;
    function Summary : string;
    function SummaryGeneral : string;
    function Summary2 : string;
    function FDSummary(LowBand : TBand) : string;
  end;

  TCityList = class
    List : TList;
    SortedMultiList : TStringList;
    constructor Create;
    destructor Destroy; override;
    procedure Reset;
    function GetCity(Name : string) : TCity;
    procedure LoadFromFile(filename : string);
    function AddAndSort(C : TCity) : integer; // returns the index inserted
  end;

var
  CountryList : TCountryList;
  PrefixList : TPrefixList;
  MyCountry, MyContinent, MyZone : string[255];

procedure LoadCTY_DAT(TEST : byte; var L : TCountryList; var PL : TPrefixList);
procedure LoadCountryDataFromFile(filename : string; var L : TCountryList; var PL : TPrefixList);
function GetPrefixX(aQSO : TQSO; PL : TPrefixList): TPrefix;
function GetPrefix(aQSO : TQSO) : TPrefix;
function GetCountryIndex(aQSO : TQSO): integer;
function GetArea(str : string) : integer;
function GuessCQZone(aQSO : TQSO) : string;
procedure AnalyzeMyCountry;

implementation

uses
  Main;

procedure TPrefixList.AddListX(PX: TPrefix);
var
   j, k: integer;
   p: string;
   boo: boolean;
begin
   p := PX.Prefix;
   if List.Count = 0 then begin
      List.Add(PX);
      exit;
   end
   else begin
      boo := false;
      if boo = false then
         k := 0;
      for j := k to List.Count - 1 do begin
         if PXMoreX(p, TPrefix(List[j]).Prefix) = false then begin
            List.Insert(j, PX);
            exit;
         end;
      end;
      List.Add(PX);
   end;
end;

constructor TCountryList.Create;
begin
   List := TList.Create;
end;

destructor TCountryList.Destroy;
var
   i: integer;
begin
   List.Pack;

   for i := 0 to List.Count - 1 do begin
      TCountry(List[i]).Free;
   end;

   List.Free;
end;

procedure TCountryList.Reset;
var
   i: integer;
   B: TBand;
begin
   for i := 0 to List.Count - 1 do
      for B := b19 to HiBand do
         TCountry(List[i]).Worked[B] := false;
end;

function TCountry.Summary: string;
var
   temp: string;
   B: TBand;
begin
   if pos('WAEDC', CONTESTNAME) > 0 then begin
      Result := SummaryWAE;
      exit;
   end;

   if CountryName = 'Unknown' then begin
      Result := 'Unknown Country';
      exit;
   end;

   temp := '';
   temp := FillRight(Country, 7) +
           FillRight(CountryName, 28) +
           FillRight(IntToStr(Zone), 2) + ' ' + // ver 0.23
           Continent + '  ';

   for B := b19 to b28 do begin
      if NotWARC(B) then begin
         if Worked[B] then
            temp := temp + '* '
         else
            temp := temp + '. ';
      end;
   end;

   Result := temp;
end;

function TCountry.SummaryWAE: string;
var
   temp: string;
   B: TBand;
begin
   if CountryName = 'Unknown' then begin
      Result := 'Unknown Country';
      exit;
   end;

   temp := '';
   temp := FillRight(Country, 7) +
           FillRight(CountryName, 28) + '   ' + Continent + '    ';

   for B := b35 to b28 do begin
      if NotWARC(B) then begin
         if Worked[B] then
            temp := temp + '* '
         else
            temp := temp + '. ';
      end;
   end;

   Result := temp;
end;

function TCountry.SummaryGeneral: string;
var
   temp: string;
   B: TBand;
   temp2: string[15];
begin
   if CountryName = 'Unknown' then begin
      Result := 'Unknown Country';
      exit;
   end;

   temp := '';
   temp2 := CountryName;
   temp := FillRight(Country, 6) +
           FillRight(temp2, 16) +
           FillRight(IntToStr(Zone), 2) + ' ' + // ver 0.23
           Continent + '  ';

   for B := b19 to HiBand do begin
      if (MainForm.BandMenu.Items[Ord(B)].Visible = True) and
         (dmZlogGlobal.Settings._activebands[B] = True) then begin
         if Worked[B] then begin
            temp := temp + '* ';
         end
         else begin
            temp := temp + '. ';
         end;
      end;
   end;

   Result := temp;
end;

function TCountry.Summary2: string;
var
   temp: string;
   B: TBand;
   i: integer;
begin
   if CountryName = 'Unknown' then begin
      Result := 'Unknown';
      exit;
   end;

   temp := '';
   temp := FillRight(Country, 7) + FillRight(CountryName, 28) + Continent + '  ';
   temp := temp + 'worked on : ';

   for B := b19 to b28 do begin
      if NotWARC(B) then begin
         if Worked[B] then
            temp := temp + MHzString[B] + ' '
         else
            for i := 1 to Length(MHzString[B]) do begin
               temp := temp + ' ';
            end;
      end;
   end;

   Result := temp;
end;

function TCountry.SummaryARRL10: string;
var
   temp: string;
   B: TBand;
begin
   if CountryName = 'Unknown' then begin
      Result := ' Unknown country';
      exit;
   end;

   temp := ' ' + FillRight(Country, 7) +
                 FillRight(CountryName, 28) + Continent + '  ';

   if IsWVE(Country) then begin
      Result := temp + 'N/A';
      exit;
   end;

   for B := b19 to b35 do
      if Worked[B] then
         temp := temp + '*  '
      else
         temp := temp + '.  ';

   Result := temp;
end;

function TCountry.JustInfo: string;
var
   temp: string;
begin
   if CountryName = 'Unknown' then begin
      Result := 'Unknown';
      exit;
   end;

   temp := '';
   temp := FillRight(Country, 7) +
           FillRight(CountryName, 28) + Continent + '  ';

   Result := temp;
end;

constructor TCountry.Create;
var
   B: TBand;
begin
   for B := b19 to HiBand do
      Worked[B] := false;

   Country := '';
   CountryName := '';
   Zone := 0;
   Continent := '';
end;

constructor TPrefix.Create;
begin
   Prefix := '';
   Index := 0;
   Length := 0;
   OvrZone := 0;
   OvrContinent := '';
end;

constructor TPrefixList.Create;
var
   i: integer;
begin
   List := TList.Create;
   { for i := 0 to 255 do
     ListIndex[i] := -1; }
   for i := 0 to MaxIndex do
      ListIndexX[i] := -1;
end;

destructor TPrefixList.Destroy;
var
   i: integer;
begin
   List.Pack;
   for i := 0 to List.Count - 1 do
      TPrefix(List[i]).Free;
   List.Free;
end;

procedure TPrefixList.InitIndexX;
var
   i, j: integer;
   s: string;
begin
   for i := List.Count - 1 downto 0 do begin
      s := TPrefix(List[i]).Prefix;
      j := PXIndex(s);
      if j >= 0 then
         ListIndexX[j] := i;
   end;
end;

procedure LoadCTY_DAT(TEST: byte; var L: TCountryList; var PL: TPrefixList);
var
   f: textfile;
   str, temp, temp2: string;
   C: TCountry;
   p: TPrefix;
   i, mii, j, k, m: integer;
begin
   _DATFileName := 'CTY.DAT';
   System.assign(f, 'CTY.DAT');
   try
      System.Reset(f);
   except
      on EFOpenError do begin
         exit;
      end;
   end;

   // readln(f, str);
   C := TCountry.Create;
   C.CountryName := 'Unknown';
   L.List.Add(C);
   while not(eof(f)) do begin
      readln(f, str);

      if (pos('*', str) > 0) and (TEST <> testCQWW) then // Cty only for CQWW
      begin
         repeat
            readln(f, str);
         until (eof(f)) or (pos(':', str) > 0);
         if eof(f) then
            exit;
      end;

      C := TCountry.Create;

      i := pos(':', str);
      if i > 0 then begin
         C.CountryName := copy(str, 1, i - 1);
         Delete(str, 1, i);
         str := TrimLeft(str);
      end;

      i := pos(':', str);
      if i > 0 then begin
         temp := copy(str, 1, i - 1);
         j := StrToIntDef(temp, 0);

         if (TEST in [testCQWW, testDXCCWWZone]) then
            C.Zone := j;

         Delete(str, 1, i);
         str := TrimLeft(str);
      end;

      i := pos(':', str);
      if i > 0 then begin
         temp := copy(str, 1, i - 1);
         j := StrToIntDef(temp, 0);

         if (TEST = testIARU) then
            C.Zone := j;

         Delete(str, 1, i);
         str := TrimLeft(str);
      end;

      i := pos(':', str);
      if i > 0 then begin
         temp := copy(str, 1, i - 1);
         if pos(temp + ';', 'AS;AF;EU;NA;SA;OC;') > 0 then
            C.Continent := temp;
         Delete(str, 1, i);
         str := TrimLeft(str);
      end;

      i := pos(':', str); // latitude
      if i > 0 then begin
         Delete(str, 1, i);
         str := TrimLeft(str);
      end;

      i := pos(':', str); // longitude
      if i > 0 then begin
         Delete(str, 1, i);
         str := TrimLeft(str);
      end;

      i := pos(':', str); // utc offset
      if i > 0 then begin
         Delete(str, 1, i);
         str := TrimLeft(str);
      end;

      i := pos(':', str);
      if i > 0 then begin
         temp := copy(str, 1, i - 1);
         if temp[1] = '*' then
            Delete(temp, 1, 1);

         C.Country := temp;
      end;

      L.List.Add(C);
      i := L.List.Count - 1;
      C.GridIndex := i;

      repeat
         mii := 1;
         readln(f, str);
         str := TrimLeft(str);
         repeat
            temp := '';
            repeat
               temp := temp + str[mii];
               inc(mii)
            until (str[mii] = ',') or (str[mii] = ';') or (mii > Length(str));

            p := TPrefix.Create;

            if (pos('(', temp) > 0) then begin
               j := pos('(', temp);
               k := pos(')', temp);
               if k > j + 1 then begin
                  temp2 := copy(temp, j + 1, k - j - 1);
                  m := StrToIntDef(temp2, 0);

                  if (m > 0) and (TEST in [testCQWW, testDXCCWWZone]) then
                     p.OvrZone := m;
               end;
               Delete(temp, j, k - j + 1);
            end;

            if (pos('[', temp) > 0) then begin
               j := pos('[', temp);
               k := pos(']', temp);
               if k > j + 1 then begin
                  temp2 := copy(temp, j + 1, k - j - 1);
                  m := StrToIntDef(temp2, 0);

                  if (m > 0) and (TEST = testIARU) then
                     p.OvrZone := m;
               end;
               Delete(temp, j, k - j + 1);
            end;

            if (pos('{', temp) > 0) then begin
               j := pos('{', temp);
               k := pos('}', temp);
               if k > j + 1 then begin
                  temp2 := copy(temp, j + 1, k - j - 1);
                  if pos(temp2 + ';', 'AS;AF;EU;NA;SA;OC;') > 0 then
                     p.OvrContinent := temp2;
               end;
               Delete(temp, j, k - j + 1);
            end;

            if (pos('<', temp) > 0) then // lat, long override. ignore
            begin
               j := pos('<', temp);
               k := pos('>', temp);
               Delete(temp, j, k - j + 1);
            end;

            p.Prefix := temp;
            p.Index := i;
            p.Length := Length(temp);

            PL.AddListX(p); // 1.31
            inc(mii);
         until (mii >= Length(str) + 1);
      until str[mii - 1] = ';';
   end;

   PL.InitIndexX;
   close(f);
end;

procedure LoadCountryDataFromFile(filename: string; var L: TCountryList; var PL: TPrefixList);
var
   f: textfile;
   str, temp: string;
   C: TCountry;
   p: TPrefix;
   i, mii, j: integer;
begin
   _DATFileName := filename;
   System.assign(f, filename);
   try
      System.Reset(f);
   except
      on EFOpenError do begin
         exit;
      end;
   end;
   readln(f, str);
   C := TCountry.Create;
   C.CountryName := 'Unknown';
   L.List.Add(C);
   while not(eof(f)) do begin
      readln(f, str);
      if pos('end of file', LowerCase(str)) > 0 then
         break;

      C := TCountry.Create;
      C.CountryName := TrimRight(copy(str, 1, 26));
      temp := TrimLeft(TrimRight(copy(str, 27, 2)));
      i := StrToIntDef(temp, 0);
      if (i < 0) or (i > 90 { maxzone } ) then
         i := 0;

      C.Zone := i;
      C.Country := TrimRight(copy(str, 32, 7));

      case C.Zone of
         1 .. 8:
            C.Continent := 'NA';
         9 .. 13:
            C.Continent := 'SA';
         14 .. 16, 40:
            C.Continent := 'EU';
         17 .. 26:
            C.Continent := 'AS';
         27 .. 32:
            C.Continent := 'OC';
         33 .. 39:
            C.Continent := 'AF';
      end;

      if CharInSet(str[39], ['A', 'O', 'E']) = True then begin
         temp := str[39] + str[40];
         if temp = 'AS' then
            C.Continent := 'AS';
         if temp = 'AN' then
            C.Continent := 'AN';
         if temp = 'AF' then
            C.Continent := 'AF';
         if temp = 'EU' then
            C.Continent := 'EU';
         if temp = 'OC' then
            C.Continent := 'OC';
         if temp = 'NA' then
            C.Continent := 'NA';
         if temp = 'SA' then
            C.Continent := 'SA';
      end;

      L.List.Add(C);
      i := L.List.Count - 1;
      C.GridIndex := i;

      repeat
         mii := 3;
         readln(f, str);
         repeat
            temp := '';
            repeat
               temp := temp + str[mii];
               inc(mii)
            until (str[mii] = ',') or (str[mii] = ';');
            p := TPrefix.Create;
            p.Prefix := temp;
            p.Index := i;
            p.Length := Length(temp);
            { j := 0;
              if PL.List.Count > 0 then
              for j := 0 to PL.List.Count-1 do
              begin
              if TPrefix(PL.List[j]).Length <= P.Length then
              break;
              end;
              PL.List.Insert(j, P); }
            PL.AddListX(p); // 1.31
            inc(mii);
         until mii = Length(str) + 1;
      until str[mii - 1] = ';';
   end;
   mii := 0;
   close(f);
   PL.InitIndexX;
end;

function GetPrefixX(aQSO: TQSO; PL: TPrefixList): TPrefix;
var
   str, temp, firststr: string;
   i, x, j, k, len, pind: integer;
   boo: boolean;
begin
   Result := nil;
   str := aQSO.QSO.CallSign;
   if str = '' then
      exit;
   pind := PXIndex(str);
   i := pos('/', str);
   if i > 0 then begin
      // if there's a perfect match then go with it
      len := Length(str);
      x := PL.ListIndexX[pind];
      if x >= 0 then begin
         for j := x to PL.List.Count - 1 do begin
            if TPrefix(PL.List[j]).Prefix = str then begin
               Result := TPrefix(PL.List[j]);
               exit;
            end;
            if len > TPrefix(PL.List[j]).Length then
               break;
         end;
      end;

      temp := copy(str, i + 1, 255);
      if temp = 'MM' then { Marine Mobile }
      begin
         Result := nil;
         exit;
      end;
      if (temp = 'AA') or (temp = 'AT') or (temp = 'AG') or (temp = 'AA') or (temp = 'AE') or (temp = 'M') or (temp = 'P') or (temp = 'AM') or
        (temp = 'QRP') or (temp = 'A') or (temp = 'KT') or (temp = 'N') or (temp = 'T') then
         str := copy(str, 1, i - 1) { cut /AA /M etc }
      else if (Length(temp) = 1) and (CharInSet(temp[1], ['0' .. '9']) = True) then
         str := copy(str, 1, i - 1) { cut /0 /1 etc }
      else if i > 4 then { JA1ZLO/JD1, KH0AM/W6 etc NOT KH0/AD6AJ }
      begin
         if i = 5 then // kh7k/ad6aj etc or w6aa/kh0
         begin // if the first part exactly matches with a prefix, it will return that prefix
            boo := false;
            firststr := copy(str, 1, 4);
            if x >= 0 then
               for k := x to PL.List.Count - 1 do begin
                  if TPrefix(PL.List[k]).Prefix = firststr then begin
                     boo := true;
                     break;
                  end;
                  if PXIndex(TPrefix(PL.List[k]).Prefix) <> pind then
                     break;
               end;
            if boo then begin
               Result := TPrefix(PL.List[k]);
               exit;
            end;
         end;
         str := temp;
      end;
   end;

   boo := false;
   if str = '' then
      exit;

   if pos('KG4', str) = 1 then begin
      if Length(str) = 6 then
         str := 'AD4AJ';
   end;

   pind := PXIndex(str);
   x := PL.ListIndexX[pind];
   if x < 0 then begin
      pind := PXIndex(copy(str, 1, 1));
      x := PL.ListIndexX[pind];
   end;

   if x < 0 then
      exit;

   for j := pind + 1 to MaxIndex do
      if PL.ListIndexX[j] >= 0 then
         break;

   for i := x to PL.ListIndexX[j] - 1 do begin
      if pos(TPrefix(PL.List[i]).Prefix, str) = 1 then begin
         boo := true;
         break;
      end;
   end;

   if boo then
      Result := TPrefix(PL.List[i])
   else begin
      x := PL.ListIndexX[PXIndex(copy(str, 1, 1))];
      if x >= 0 then
         Result := TPrefix(PL.List[x])
      else
         Result := nil;
   end;

end;

function GetPrefix(aQSO: TQSO): TPrefix;
begin
   Result := GetPrefixX(aQSO, PrefixList);
end;

function GetCountryIndex(aQSO: TQSO): integer;
begin
   if GetPrefix(aQSO) <> nil then
      Result := TPrefix(GetPrefix(aQSO)).Index
   else
      Result := 0;
end;

function GetArea(str: string): integer;
var
   j, k: integer;
begin
   j := pos('/', str);
   if j > 4 then begin
      for k := Length(str) downto 1 do
         if CharInSet(str[k], ['0' .. '9']) = True then
            break;
   end
   else begin
      for k := 1 to Length(str) do
         if CharInSet(str[k], ['0' .. '9']) = True then
            break;
   end;

   if CharInSet(str[k], ['0' .. '9']) = True then
      k := ord(str[k]) - ord('0')
   else
      k := 6;

   Result := k;
end;

function expos(substr, str: string): integer;
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

function GuessCQZone(aQSO: TQSO): string;
var
   i, k: integer;
   C: TCountry;
   p: TPrefix;
   str: string;
begin
   p := GetPrefix(aQSO);
   if p = nil then begin
      Result := '';
      exit;
   end
   else
      C := TCountry(CountryList.List[p.Index]);
   str := aQSO.QSO.CallSign;
   i := C.Zone;

   if (C.Country = 'W') or (C.Country = 'K') then begin
      k := GetArea(str);
      case k of
         1 .. 4:
            i := 5;
         5, 8, 9, 0:
            i := 4;
         6, 7:
            i := 3;
      end;
   end;

   if C.Country = 'VE' then begin
      k := GetArea(str);
      case k of
         1, 2, 9:
            i := 5;
         3 .. 6:
            i := 4;
         7:
            i := 3;
         8:
            i := 1;
         0:
            i := 2;
      end;
   end;

   if C.Country = 'VK' then begin
      k := GetArea(str);
      case k of
         1 .. 5, 7:
            i := 30;
         6, 8:
            i := 29;
         9, 0:
            i := 30; { Should not happen }
      end;
   end;

   if C.Country = 'BY' then begin
      k := GetArea(str);
      case k of
         1 .. 8:
            i := 24;
         9, 0:
            i := 23;
      end;
   end;

   if (C.Country = 'UA') or (C.Country = 'UA0') or (C.Country = 'UA9') then begin
      if (expos('U?0', str) > 0) or (pos('R?0', str) > 0) or (pos('R0', str) > 0) then begin
         k := pos('0', str);
         if Length(str) >= k + 1 then
            case str[k + 1] of
               'A', 'B', 'H', 'O', 'P', 'S', 'T', 'U', 'V', 'W':
                  i := 18;
               'Y':
                  i := 23;
               else
                  i := 19;
            end;
      end;

      if (expos('U?8', str) > 0) or (expos('R?8', str) > 0) then begin
         i := 18;
      end;
      if (expos('U?9', str) > 0) or (pos('R?9', str) > 0) then begin
         k := pos('9', str);
         if Length(str) >= k + 1 then
            case str[k + 1] of
               'S', 'T', 'W':
                  i := 16;
               'H', 'I', 'O', 'P', 'U', 'V', 'Y', 'Z':
                  i := 18;
               else
                  i := 17;
            end;
      end;
   end;

   if p.OvrZone > 0 then
      i := p.OvrZone;

   if i = 0 then
      Result := ''
   else
      Result := IntToStr(i);
end;

procedure AnalyzeMyCountry;
var
   aQSO: TQSO;
   i: integer;
   p: TPrefix;
begin
   MyContinent := 'AS';
   MyCountry := 'JA';
   MyZone := '25';

   if (dmZlogGlobal.Settings._mycall <> '') and (dmZlogGlobal.Settings._mycall <> 'Your call sign') then begin
      aQSO := TQSO.Create;
      aQSO.QSO.CallSign := Uppercase(dmZlogGlobal.Settings._mycall);

      p := GetPrefix(aQSO);
      // i := GetCountryIndex(aQSO);
      if p = nil then
         i := 0
      else
         i := p.Index;

      if i > 0 then begin
         MyCountry := TCountry(CountryList.List[i]).Country;
         // MyZone := IntToStr(TCountry(CountryList.List[i]).Zone);

         if dmZlogGlobal.Settings._cqzone = '' then
            dmZlogGlobal.Settings._cqzone := GuessCQZone(aQSO);
         MyZone := dmZlogGlobal.Settings._cqzone;

         // MyContinent := TCountry(CountryList.List[i]).Continent;
         if p.OvrContinent = '' then
            MyContinent := TCountry(CountryList.List[i]).Continent
         else
            MyContinent := p.OvrContinent;
      end;
      aQSO.Free;
   end;
end;

constructor TCity.Create;
var
   B: TBand;
begin
   for B := b19 to HiBand do
      Worked[B] := false;

   CityNumber := '';
   CityName := '';
   PrefNumber := '';
   PrefName := '';
end;

function TCity.Abbrev: string;
var
   str: string;
begin
   str := CityNumber;
   if pos(',', str) > 0 then
      str := copy(str, 1, pos(',', str) - 1);
   Result := str;
end;

function TCity.Summary: string;
var
   temp, _cityname: string;
   B: TBand;
begin
   temp := '';
   if Length(CityName) > 20 then begin
      _cityname := copy(CityName, 1, 20);
   end
   else begin
      _cityname := CityName;
   end;

   temp := FillRight( { CityNumber } Abbrev, 7) +
           FillRight(_cityname, 20) + ' ';

   for B := b19 to HiBand do begin
      if NotWARC(B) then begin
         if (MainForm.BandMenu.Items[Ord(B)].Visible = True) and
            (dmZlogGlobal.Settings._activebands[B] = True) then begin
            if Worked[B] then begin
               temp := temp + '* ';
            end
            else begin
               temp := temp + '. ';
            end;
         end
         else begin
            temp := temp + '  ';
         end;
      end;
   end;

   Result := ' ' + temp;
end;

function TCity.SummaryGeneral: string;
var
   temp, _cityname: string;
   B: TBand;
begin
   temp := '';
   if Length(CityName) > 20 then begin
      _cityname := copy(CityName, 1, 20);
   end
   else begin
      _cityname := CityName;
   end;

   temp := FillRight( { CityNumber } Abbrev, 7) +
           FillRight(_cityname, 20) + ' ';

   for B := b19 to HiBand do begin
      if (MainForm.BandMenu.Items[Ord(B)].Visible = True) and
         (dmZlogGlobal.Settings._activebands[B] = True) then begin
         if Worked[B] then begin
            temp := temp + '* ';
         end
         else begin
            temp := temp + '. ';
         end;
      end;
   end;

   Result := ' ' + temp;
end;

function TCity.FDSummary(LowBand: TBand): string;
var
   temp: string;
   B: TBand;
begin
   temp := '';
   temp := FillRight(CityNumber, 7) +
           FillRight(CityName, 20) + ' ' + '  ';

   for B := LowBand to HiBand do begin
      if NotWARC(B) then begin
         if B in [b19 .. b1200] then begin
            if Length(Self.CityNumber) <= 3 then
               if Worked[B] then
                  temp := temp + '* '
               else
                  temp := temp + '. '
            else
               temp := temp + '  ';
         end
         else begin // 2.4G and upper
            if Length(Self.CityNumber) > 3 then
               if Worked[B] then
                  temp := temp + '* '
               else
                  temp := temp + '. '
            else
               temp := temp + '  ';
         end;
      end;
   end;

   Result := ' ' + temp;
end;

function TCity.Summary2: string;
var
   temp: string;
   B: TBand;
begin
   temp := '';
   temp := FillRight( { CityNumber } Abbrev, 7) +
           FillRight(CityName, 20) + ' Worked on : ';

   for B := b35 to HiBand do begin
      if Worked[B] then
         temp := temp + ' ' + MHzString[B]
      else
         temp := temp + '';
   end;

   Result := temp;
end;

constructor TCityList.Create;
begin
   List := TList.Create;
   SortedMultiList := TStringList.Create;
   SortedMultiList.Sorted := true;
end;

procedure TCityList.Reset;
var
   i: integer;
   B: TBand;
begin
   for i := 0 to List.Count - 1 do
      for B := b19 to HiBand do
         TCity(List[i]).Worked[B] := false;
end;

function TCityList.GetCity(Name: string): TCity;
var
   i: integer;
begin
   Result := nil;
   i := SortedMultiList.IndexOf(Name);
   if i >= 0 then
      Result := TCity(SortedMultiList.Objects[i]);
end;

destructor TCityList.Destroy;
var
   i: integer;
begin
   for i := 0 to List.Count - 1 do begin
      if List[i] <> nil then
         TCity(List[i]).Free;
   end;
   List.Free;
   SortedMultiList.Clear;
   SortedMultiList.Free;
end;

procedure TCityList.LoadFromFile(filename: string);
var
   f: textfile;
   str: string;
   C: TCity;
   i: integer;
   fullpath: string;
begin
   fullpath := filename;
   if FileExists(fullpath) = False then begin
      fullpath := dmZLogGlobal.Settings._cfgdatpath + filename;
      if FileExists(fullpath) = False then begin
         fullpath := ExtractFilePath(Application.ExeName) + filename;
         if FileExists(fullpath) = False then begin
            MessageDlg('DAT file [' + fullpath + '] cannot be opened', mtError, [mbOK], 0);
            Exit;
         end;
      end;
   end;

   Assign(f, fullpath);
   System.Reset(f);
   ReadLn(f, str);

   while not(eof(f)) do begin
      ReadLn(f, str);
      if pos('end of file', LowerCase(str)) > 0 then begin
         break;
      end;

      C := TCity.Create;

      i := pos(' ', str);
      if i > 1 then begin
         C.CityNumber := copy(str, 1, i - 1);
      end;

      Delete(str, 1, i);
      C.CityName := TrimRight(TrimLeft(str));

      C.Index := List.Count;

      List.Add(C);
      SortedMultiList.AddObject(C.CityNumber, C);
   end;

   closefile(f);
end;

function TCityList.AddAndSort(C: TCity): integer;
var
   i: integer;
begin
   if List.Count = 0 then begin
      List.Add(C);
      Result := 0;
      exit;
   end;

   for i := 0 to List.Count - 1 do begin
      if StrMore(TCity(List[i]).CityNumber, C.CityNumber) then begin
         List.Insert(i, C);
         Result := i;
         exit;
      end;
   end;

   List.Add(C);

   Result := List.Count - 1;
end;

initialization
   CountryList := nil;
   PrefixList := nil;
   MyContinent := 'AS';
   MyCountry := 'JA';
   MyZone := '25';

end.
