unit UWPXMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UWWMulti, UMultipliers, StdCtrls, JLLabel, ExtCtrls, Grids, Cologrid,
  UComm, USpotClass, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TWPXMulti = class(TWWMulti)
    procedure FormCreate(Sender: TObject);
    procedure GoButtonClick(Sender: TObject);
    procedure GridSetting(ARow, Acol: Integer; var Fcolor: Integer;
      var Bold, Italic, underline: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    WPXList : TStringList;
    procedure RefreshGrid; override;
    procedure SavePXList(filename : string);
    function TotalPrefix : integer;
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
    procedure ProcessCluster(var Sp : TBaseSpot); override;
    procedure Update; override;
  end;

function GetWPXPrefix(aQSO : TQSO) : string;

implementation

uses UOptions, {UComm,} Main;

{$R *.DFM}

procedure TWPXMulti.RefreshGrid;
var i : integer;
begin
  Grid.RowCount := WPXList.Count;
  for i := Grid.TopRow to Grid.TopRow + Grid.VisibleRowCount - 1 do
    begin
      if (i > Grid.RowCount - 1) then
        begin
          exit;
        end
      else
        begin
          if (i >= 0) and (i < WPXList.Count) then
            begin
              Grid.Cells[0, i] := WPXList[i];
            end
          else
            Grid.Cells[0, i] := '';
        end;
    end;
end;

procedure TWPXMulti.SavePXList(filename : string);
begin
  WPXList.SaveToFile(filename);
end;

function TWPXMulti.TotalPrefix : integer;
begin
  Result := WPXList.Count;
end;

function GetWPXPrefix(aQSO : TQSO) : string;
var str, temp : string;
    i, j, k : integer;
    boo : boolean;
begin
  str := aQSO.CallSign;
  i := pos('/', str);
  if i > 0 then
    begin
      temp := copy(str, i + 1, 255);
      if (temp='AA') or (temp='AT') or (temp='AG') or (temp='AA') or
         (temp='AE') or (temp='M') or (temp='P') or (temp='AM') or
         (temp='QRP') or (temp='A') or (temp='KT') or (temp='MM')  then
        str := copy(str, 1, i - 1)  {cut /AA /M etc}
      else
        if (length(temp) = 1) and (temp[1] in ['0'..'9']) then {JA1ZLO/2}
          begin
            j := 1;
            repeat
              inc(j);
            until (str[j] in ['0'..'9']) or (length(str) < j);
            str := copy(str, 1, j);
            str[j] := temp[1];
            Result := str;
            exit;
          end
        else
          if i > 4 then {JA1ZLO/JD1, KH0AM/W6 etc NOT KH0/AD6AJ}
            begin
              boo := false;
              for j := 1 to length(temp) do
                if temp[j] in ['0'..'9'] then
                  begin
                    k := j; // holds the pos of last numeral
                    boo := true;
                  end;
              if boo = False then
                temp := temp + '0'  {AD6AJ/PA => PA0}
              else
                begin
                  if temp[length(temp)] in ['A'..'Z'] then // /VP2E etc
                    temp := copy(temp, 1, k);
                end;
              Result := temp;
              exit;
            end
          else  {KH0/AD6AJ}
            begin
              temp := copy(str, 1, i-1);
              boo := false;
              for j := 1 to length(temp) do
                if temp[j] in ['0'..'9'] then
                  begin
                    boo := true;
                    k := j;
                  end;
              if boo = False then
                temp := temp + '0'  {PA/AD6AJ => PA0}
              else
                begin
                  if temp[length(temp)] in ['A'..'Z'] then
                    temp := copy(temp, 1, k);
                end;
              Result := temp;
              exit;
            end
    end;
  j := 1;

  repeat
    inc(j);
  until (length(str) < j) or (str[j] in ['0'..'9']);

  if j > length(str) then {XEFTA etc => XE0}
    begin
      Result := copy(str, 1, 2) + '0';
      exit;
    end;

  j := length(str) + 1;

  repeat
    dec(j);
  until (j = 1) or ( (str[j]) in ['0'..'9'] );

  {while (j < length(str)) and (str[j+1] in ['0'..'9']) do
    inc(j);}

  {if j + 1 <= length(str) then
    if str[j+1] in ['0'..'9'] then
      inc(j);}

  Result := copy(str, 1, j);
end;

procedure TWPXMulti.FormCreate(Sender: TObject);
var i : integer;
    aQSO : TQSO;
begin
  {inherited; }
  WPXList := TStringList.Create;
  WPXList.Sorted := True;
  CountryList := TCountryList.Create;
  PrefixList := TPrefixList.Create;

//LoadCountryDataFromFile('CQWW.DAT');
  if FileExists('CTY.DAT') then
    begin
      LoadCTY_DAT(testCQWW, CountryList, PrefixList);
      MainForm.WriteStatusLine('Loaded CTY.DAT', true);
    end
  else
    LoadCountryDataFromFile('CQWW.DAT', CountryList, PrefixList);

  if CountryList.List.Count = 0 then exit;
  Reset;
  MyContinent := 'AS';
  MyCountry := 'JA';

  if (dmZlogGlobal.Settings._mycall <> '') and (dmZlogGlobal.Settings._mycall <> 'Your call sign') then
    begin
      aQSO := TQSO.Create;
      aQSO.callsign := UpperCase(dmZlogGlobal.Settings._mycall);
      i := GetCountryIndex(aQSO);
      if i > 0 then
        begin
          MyCountry := TCountry(CountryList.List[i]).Country;
          MyContinent := TCountry(CountryList.List[i]).Continent;
        end;
      aQSO.Free;
    end;

  // WWZone.Reset;
end;

procedure TWPXMulti.Reset;
begin
  WPXList.Clear;
end;

procedure TWPXMulti.Update;
begin
  RefreshGrid;
end;

procedure TWPXMulti.AddNoUpdate(var aQSO : TQSO);
var str : string;
    i, max : integer;
    C : TCountry;
    P : TPrefix;
    _cont : string[3];
begin
  aQSO.NewMulti1 := False;
  str := GetWPXPrefix(aQSO);
  aQSO.Multi1 := str;
  aQSO.Points := 0;

  if aQSO.Dupe then
    exit;

  if WPXList.IndexOf(str) >= 0 then
    begin
    end
  else
    begin
      WPXList.Add(str);
      aQSO.NewMulti1 := True;
    end;

  P := GetPrefix(aQSO);
  if P = nil then  // /MM
    begin
      aQSO.Points := 0;
      exit;
    end;
  C := TCountry(CountryList.List[P.Index]);

  if P.OvrContinent = '' then
    _cont := C.Continent
  else
    _cont := P.OvrContinent;

  if _cont = 'AS' then
    aQSO.Power2 := 777; // flag for all asian mode (dx side)

//MAINFORM.WRITESTATUSLINE(C.COUNTRY);

  if C.Country = MyCountry then
    begin
      aQSO.Points := 1;
      exit;
    end;

  if MyContinent = _cont then
    if MyContinent = 'NA' then
      if aQSO.Band in [b19..b7] then
        aQSO.Points := 4
      else
        aQSO.Points := 2
    else
      if aQSO.Band in [b19..b7] then
        aQSO.Points := 2
      else
        aQSO.Points := 1
   else
     if aQSO.Band in [b19..b7] then
       aQSO.Points := 6
     else
       aQSO.Points := 3;

end;

function TWPXMulti.ValidMulti(aQSO : TQSO) : boolean;
var
   str : string;
   i : integer;
begin
   str := aQSO.NrRcvd;
   i := StrToIntDef(str, -1);
   if i >= 0 then
      Result := True
   else
      Result := False;
end;

procedure TWPXMulti.ProcessCluster(var Sp : TBaseSpot);
var Z, C, i : integer;
    temp, px : string;
    boo : boolean;
    aQSO : TQSO;
begin
  aQSO := TQSO.Create;
  aQSO.Callsign := Sp.Call;
  aQSO.Band := Sp.Band;

  Sp.NewCty := False;
  Sp.NewZone := False;
  Sp.Worked := False;
  if Log.IsDupe(aQSO) > 0 then
    begin
      Sp.Worked := True;
      aQSO.Free;
      exit;
    end;

  temp := aQSO.CallSign;

  px := GetWPXPrefix(aQSO);

  boo := False;
  for i := 0 to WPXList.Count - 1 do
    if px = WPXList[i] then
      boo := True;
  if boo = False then
    begin
      temp := temp + '  new prefix : ' + px;
      Sp.NewCty := True;
    end;
  if Sp.NewMulti {Pos('new', temp) > 0} then
    begin
      temp := temp + ' at ' + MHzString[aQSO.band]+ 'MHz';
      CommForm.WriteStatusLine(temp);
      //CommForm.Show;
    end;
  aQSO.Free;
end;

procedure TWPXMulti.GoButtonClick(Sender: TObject);
var temp : string;
    i : integer;
begin
  temp := Edit1.Text;
  for i := 0 to WPXList.Count-1 do
    begin
      if pos(temp, WPXList[i]) = 1 then
        begin
          Grid.TopRow := i;
          break;
        end;
    end;
end;

procedure TWPXMulti.GridSetting(ARow, Acol: Integer; var Fcolor: Integer;
  var Bold, Italic, underline: Boolean);
begin
  //inherited;
  FColor := clBlack;
end;

end.
