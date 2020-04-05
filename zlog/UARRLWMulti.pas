unit UARRLWMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UWWMulti, UMultipliers, StdCtrls, ExtCtrls, JLLabel, Grids, Cologrid,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TARRLWMulti = class(TWWMulti)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ALLASIANFLAG : boolean;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
    procedure CheckMulti(aQSO : TQSO); override;
    function GetInfoAA(aQSO : TQSO) : string; // called from spacebarproc in TAllAsianContest
  end;

implementation

uses UOptions, Main;

{$R *.DFM}

function TARRLWMulti.GetInfoAA(aQSO : TQSO) : string;
begin
  Result := TCountry(CountryList.List[GetCountryIndex(aQSO)]).JustInfo;
end;

procedure TARRLWMulti.CheckMulti(aQSO : TQSO);
var str : string;
    i : integer;
    B : TBand;
begin
end;

function TARRLWMulti.ValidMulti(aQSO : TQSO) : boolean;
begin
  if aQSO.NrRcvd <> '' then
    Result := True
  else
    Result := False;
end;

procedure TARRLWMulti.AddNoUpdate(var aQSO : TQSO);
var str : string;
    B : TBand;
    i, j : integer;
    C : TCountry;
begin
  aQSO.NewMulti1 := False;
  aQSO.NewMulti2 := False;

  i := GetCountryIndex(aQSO);

  C := TCountry(CountryList.List[i]);
  aQSO.Multi1 := C.Country;

  if aQSO.Dupe then
    exit;

  if ALLASIANFLAG = True then
    begin
      aQSO.Points := 0;
      //MainForm.Caption := C.Country+';'+MyCOuntry+';';
      if C.Country = MyCountry then
        begin
          aQSO.Points := 0;
          exit;
        end
      else
        begin
          if C.Continent = 'AS' then
            begin
              case aQSO.Band of
                b19 : aQSO.Points := 3;
                b35, b28 : aQSO.Points := 2;
              else
                aQSO.Points := 1;
              end;
            end
          else
            begin
              case aQSO.Band of
                b19 : aQSO.Points := 9;
                b35, b28 : aQSO.Points := 6;
              else
                aQSO.Points := 3;
              end;
            end;
        end;
    end;


  B := aQSO.Band;

  if C.Worked[B] = False then
    begin
      C.Worked[B] := True;
      aQSO.NewMulti1 := True;
      //Grid.Cells[0,C.GridIndex] := C.Summary;
    end;
end;

procedure TARRLWMulti.FormCreate(Sender: TObject);
var i : integer;
    aQSO : TQSO;
begin
  {inherited; }
  ALLASIANFLAG := False;
  CountryList := TCountryList.Create;
  PrefixList := TPrefixList.Create;

  //LoadCountryDataFromFile('DXCC.DAT');

  if FileExists('CTY.DAT') then
    begin
      LoadCTY_DAT(testIARU, CountryList, PrefixList);
      MainForm.WriteStatusLine('Loaded CTY.DAT', true);
    end
  else
    LoadCountryDataFromFile('DXCC.DAT', CountryList, PrefixList);


  if CountryList.List.Count = 0 then exit;
  {for i := 0 to CountryList.List.Count-1 do
    begin
      ListBox.Items.Add(TCountry(CountryList.List[i]).Summary);
    end;}
  Reset;
  MyContinent := 'AS';
  MyCountry := 'JA';

  if (dmZlogGlobal.Settings._mycall <> '') and (dmZlogGlobal.Settings._mycall <> 'Your callsign') then
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
end;

procedure TARRLWMulti.FormShow(Sender: TObject);
begin
  // inherited;
end;

end.
