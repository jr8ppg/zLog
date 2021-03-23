unit UJIDXMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UWWMulti, UMultipliers, StdCtrls, JLLabel, ExtCtrls, Grids,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TJIDXMulti = class(TWWMulti)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddNoUpdate(var aQSO : TQSO); override;
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TJIDXMulti.FormCreate(Sender: TObject);
var
   aQSO : TQSO;
   P: TPrefix;
begin
   {inherited; }
   CountryList := TCountryList.Create;
   PrefixList := TPrefixList.Create;

   if LoadCTY_DAT() = False then begin
      Exit;
   end;

   MainForm.WriteStatusLine('Loaded CTY.DAT', true);

   if CountryList.Count = 0 then begin
      Exit;
   end;

   Reset;
   MyContinent := 'AS';
   MyCountry := 'JA';

   if (dmZlogGlobal.Settings._mycall <> '') and (dmZlogGlobal.Settings._mycall <> 'Your callsign') then begin
      aQSO := TQSO.Create;
      aQSO.callsign := UpperCase(dmZlogGlobal.Settings._mycall);

      P := GetPrefix(aQSO);
      MyCountry := P.Country.Country;
      MyContinent := P.Country.Continent;

      aQSO.Free;
   end;
end;

procedure TJIDXMulti.AddNoUpdate(var aQSO : TQSO);
var
   str : string;
   B: TBand;
   i: integer;
   C: TCountry;
begin
   aQSO.NewMulti1 := False;
   aQSO.NewMulti2 := False;
   str := aQSO.NrRcvd;
   aQSO.Multi1 := str;

   if aQSO.Dupe then begin
      exit;
   end;

   B := aQSO.band;
   i := StrToIntDef(str, 0);

   if i in [1..MAXCQZONE] then begin
      if Zone[B,i] = False then begin
         Zone[B,i] := True;
         aQSO.NewMulti1 := True;
         FZoneForm.Mark(B,i);
      end;
   end;

   C := GetPrefix(aQSO).Country;
   if C.Country = '' then begin // unknown cty. e.g. MM
      exit;
   end;

   MostRecentCty := C;
   aQSO.Multi2 := C.Country;

   if C.Worked[B] = False then begin
      C.Worked[B] := True;
      aQSO.NewMulti2 := True;
      Grid.Cells[0,C.GridIndex] := C.Summary;
   end;
end;

end.
