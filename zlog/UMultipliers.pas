unit UMultipliers;

interface

uses
  SysUtils, Windows, Classes, Dialogs, Forms, UITypes,
  Generics.Collections, Generics.Defaults,
  UzLogConst;  //, UzLogQSO;

const
  MAXCQZONE = 40;

type
  TCountry = class(TObject)
    FName: string;            // Japan, Hawaii, etc
    FCQZone: string;          // CQ Zone
    FITUZone: string;         // ITU Zone
    FContinent: string;       // 大陸
    FLatitude: string;        // 緯度
    FLongitude: string;       // 経度
    FUTCOffset: Integer;      // UTCに対する時差
    FCode: string;            // JA, KH6 etc
    FPrefixes: string;        // 代表プリフィックス

    FWorked: array[b19..HiBand] of Boolean;
    FIndex: Integer;
    FGridIndex: Integer;  // where it is listed in the Grid (row)

    function GetWorked(Index: TBand): Boolean;
    procedure SetWorked(Index: TBand; Value: Boolean);
  public
    constructor Create(); overload;
    constructor Create(strText: string); overload;

    function Summary : string;
    function SummaryWAE : string;
    function Summary2 : string;
    function SummaryARRL10 : string;
    function SummaryGeneral : string;
    function JustInfo : string; // returns cty name, px and continent

    procedure Parse(strText: string);
    property CountryName: string read FName write FName;
    property CQZone: string read FCQZone write FCQZone;
    property ITUZone: string read FITUZone write FITUZone;
    property Continent: string read FContinent write FContinent;
    property Latitude: string read FLatitude write FLatitude;
    property Longitude: string read FLongitude write FLongitude;
    property UTCOffset: Integer read FUTCOffset write FUTCOffset;
    property Country: string read FCode write FCode;
    property Prefixes: string read FPrefixes write FPrefixes;
    property Worked[Index: TBand]: Boolean read GetWorked write SetWorked;
    property Index: Integer read FIndex write FIndex;
    property GridIndex: Integer read FGridIndex write FGridIndex;
  end;

  TCountryList = class(TObjectList<TCountry>)
  private
  public
    constructor Create(OwnsObjects: Boolean = True);
    procedure LoadFromFile(strFileName: string);
    procedure Reset();
  end;

  TPrefix = class(TObject)
    FPrefix: string;
    FOvrCQZone: string;         // override zone
    FOvrITUZone: string;
    FOvrContinent: string;  // override continent
    FCountry: TCountry;
    FFullMatch: Boolean;
  public
    constructor Create();
    property Prefix: string read FPrefix write FPrefix;
    property OvrCQZone: string read FOvrCQZone write FOvrCQZone;
    property OvrITUZone: string read FOvrITUZone write FOvrITUZone;
    property OvrContinent: string read FOvrContinent write FOvrContinent;
    property Country: TCountry read FCountry write FCountry;
    property FullMatch: Boolean read FFullMatch write FFullMatch;
  end;

  TPrefixComparer = class(TComparer<TPrefix>)
  public
    function Compare(const Left, Right: TPrefix): Integer; override;
  end;

  TPrefixList = class(TObjectList<TPrefix>)
  private
    FPrefixComparer: TPrefixComparer;
  public
    constructor Create(OwnsObjects: Boolean = True);
    destructor Destroy(); override;
    procedure Parse(cty: TCountry);
    procedure Sort(); overload;
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

implementation

uses
  Main, UzLogGlobal;

constructor TCountryList.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
end;

procedure TCountryList.LoadFromFile(strFileName: string);
var
   mem: TMemoryStream;
   i: Integer;
   ch: AnsiChar;
   buf: Byte;
   strLine: string;
   C: TCountry;
begin
   mem := TMemoryStream.Create();
   try
      C := TCountry.Create();
      C.CountryName := 'Unknown';
      Add(C);

      if FileExists(strFileName) = False then begin
         Exit;
      end;

      mem.LoadFromFile(strFileName);
      mem.Position := 0;

      strLine := '';
      for i := 0 to mem.Size - 1 do begin
         mem.Read(buf, 1);
         ch := AnsiChar(buf);

         if ch = AnsiChar($0d) then begin
            Continue;
         end;
         if ch = AnsiChar($0a) then begin
            Continue;
         end;

         if ch = ';' then begin
            C := TCountry.Create(strLine);
            C.Index := Count;
            Add(C);
            strLine := '';
         end
         else begin
            strLine := strLine + Char(ch);
         end;
      end;

   finally
      mem.Free();
   end;
end;

procedure TCountryList.Reset();
var
   i: Integer;
   B: TBand;
begin
   for i := 0 to Count - 1 do begin
      for B := b19 to HiBand do begin
         TCountry(List[i]).Worked[B] := False;
      end;
   end;
end;

function TCountry.Summary: string;
var
   temp: string;
   B: TBand;
begin
   if pos('WAEDC', MyContest.Name) > 0 then begin
      Result := SummaryWAE;
      exit;
   end;

   if CountryName = 'Unknown' then begin
      Result := 'Unknown Country';
      exit;
   end;

   temp := '';
   temp := FillRight(Country, 7) +
           StringReplace(FillRight(CountryName, 28), '&', '&&', [rfReplaceAll]) +
           FillRight(CQZone, 2) + ' ' + // ver 0.23
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
           StringReplace(FillRight(CountryName, 28), '&', '&&', [rfReplaceAll]) +
           '   ' + Continent + '    ';

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
begin
   if CountryName = 'Unknown' then begin
      Result := 'Unknown Country';
      exit;
   end;

   temp := '';
   temp := FillRight(Country, 6) +
           StringReplace(FillRight(CountryName, 16), '&', '&&', [rfReplaceAll]) + ' ' +
           FillRight(CQZone, 2) + ' ' + // ver 0.23
           Continent + ' ' +
           FillRight(ITUZone, 2) + '  ';

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
   temp := FillRight(Country, 7) +
           StringReplace(FillRight(CountryName, 28), '&', '&&', [rfReplaceAll]) +
           Continent + '  ';
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
                 StringReplace(FillRight(CountryName, 28), '&', '&&', [rfReplaceAll]) +
                 Continent + '  ';

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
           StringReplace(FillRight(CountryName, 28), '&', '&&', [rfReplaceAll]) +
           Continent + '  ';

   Result := temp;
end;

constructor TCountry.Create();
var
   B: TBand;
begin
   Inherited;

   FName := '';
   FCQZone := '';
   FITUZone := '';
   FContinent := '';
   FLatitude := '';
   FLongitude := '';
   FUTCOffset := 0;
   FCode := '';
   FPrefixes := '';

   for B := b19 to HiBand do begin
      Worked[B] := false;
   end;

   FIndex := -1;
   FGridIndex := -1;
end;

constructor TCountry.Create(strText: string);
begin
   Inherited Create();
   Parse(strText);
end;

procedure TCountry.Parse(strText: string);
var
   slLine: TStringList;
   i: Integer;
begin
   slLine := TStringList.Create();
   slLine.StrictDelimiter := True;
   slLine.Delimiter := ':';
   try
      slLine.DelimitedText := strText;

      for i := 0 to slLine.Count - 1 do begin
         slLine[i] := Trim(slLine[i]);
      end;

      FName       := slLine[0];
      FCQZone     := slLine[1];
      FITUZone    := slLine[2];
      FContinent  := slLine[3];
      FLatitude   := slLine[4];
      FLongitude  := slLine[5];
      FUTCOffset  := StrToIntDef(slLine[6], 0);
      FCode       := slLine[7];
      FPrefixes   := slLine[8];

   finally
      slLine.Free();
   end;
end;

function TCountry.GetWorked(Index: TBand): Boolean;
begin
   Result := FWorked[Index];
end;

procedure TCountry.SetWorked(Index: TBand; Value: Boolean);
begin
   FWorked[Index] := Value;
end;

constructor TPrefix.Create();
begin
   Inherited;
   FPrefix := '';
   FOvrCQZone := '';
   FOvrITUZone := '';
   FOvrContinent := '';
   FCountry := nil;
   FFullMatch := False;
end;

constructor TPrefixList.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
   FPrefixComparer := TPrefixComparer.Create();
end;

destructor TPrefixList.Destroy();
begin
   Inherited;
   FPrefixComparer.Free();
end;

procedure TPrefixList.Parse(cty: TCountry);
var
   i: Integer;
   slText: TStringList;
   P: TPrefix;
   strPrefix: string;
   strOvrCQZone: string;
   strOvrITUZone: string;
   strOvrContinent: string;
   strUnused: string;
   fFullMatch: Boolean;

   function ExtractNumber(var strPrefix: string; strBegin, strEnd: string): string;
   var
      p1, p2: Integer;
   begin
      p1 := Pos(strBegin, strPrefix);
      if p1 <= 0 then begin
         Result := '';
         Exit;
      end;

      p2 := Pos(strEnd, strPrefix, p1 + 1);
      if p2 <= 0 then begin
         p2 := Length(strPrefix);
      end;

      Result := Copy(strPrefix, p1 + 1, p2 - p1 - 1);
      System.Delete(strPrefix, p1, p2 - p1 + 1);
   end;
begin
   slText := TStringList.Create();
   slText.StrictDelimiter := True;
   try
      slText.CommaText := cty.Prefixes;

      for i := 0 to slText.Count - 1 do begin
         strPrefix := Trim(slText[i]);

         // =で始まる物は完全一致コール
         if strPrefix[1] = '=' then begin
            strPrefix := Copy(strPrefix, 2);
            fFullMatch := True;
         end
         else begin
            fFullMatch := False;
         end;

         // ()はOverride CQ Zone
         strOvrCQZone := ExtractNumber(strPrefix, '(', ')');

         // []はOverride ITU Zone
         strOvrITUZone := ExtractNumber(strPrefix, '[', ']');

         // {}はOverride Continent
         strOvrContinent := ExtractNumber(strPrefix, '{', '}');

         // <#/#>はOverride latitude/longitude
         strUnused := ExtractNumber(strPrefix, '<', '>');

         // ~#~はOverride UTCOffset
         strUnused := ExtractNumber(strPrefix, '~', '~');

         P := TPrefix.Create();
         P.Prefix := strPrefix;
         P.Country := cty;
         P.OvrCQZone := strOvrCQZone;
         P.OvrITUZone := strOvrITUZone;
         P.OvrContinent := strOvrContinent;
         P.FFullMatch := fFullMatch;
         Add(P);
      end;

   finally
      slText.Free();
   end;
end;

procedure TPrefixList.Sort();
begin
   Sort(FPrefixComparer);
end;

{ TPrefixComparer }

function TPrefixComparer.Compare(const Left, Right: TPrefix): Integer;
begin
   Result := CompareText(Right.Prefix, Left.Prefix);
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
           FillRight(_cityname, 24) + ' ';

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
           FillRight(CityName, 20) + ' ';

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

end.
