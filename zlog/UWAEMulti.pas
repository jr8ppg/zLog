unit UWAEMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UARRLWMulti, Grids, StdCtrls, ExtCtrls, JLLabel, UMultipliers,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TWAEMulti = class(TARRLWMulti)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddNoUpdate(aQSO: TQSO); override;
    function GetInfo(aQSO: TQSO): string; override;
    procedure UpdateData; override;
  end;

implementation

{$R *.DFM}

procedure TWAEMulti.FormCreate(Sender: TObject);
begin
   inherited;
   // ShowContinent('EU');
end;

procedure TWAEMulti.AddNoUpdate(aQSO: TQSO);
var
   B: TBand;
   P: TPrefix;
   C: TCountry;
begin
   aQSO.NewMulti1 := False;
   aQSO.NewMulti2 := False;

   P := dmZLogGlobal.GetPrefix(aQSO.Callsign);
   C := P.Country;

   if (P = nil) or (P.OvrContinent = '') then begin
      aQSO.Continent := C.Continent;
   end
   else begin
      aQSO.Continent := P.OvrContinent;
   end;

   aQSO.Entity := C.Country;

   if C.Continent <> 'EU' then begin
      aQSO.Points := 0;
      aQSO.Multi1 := 'Non-EU';
      exit;
   end;

   aQSO.Multi1 := C.Country;

   if aQSO.Dupe then begin
      Exit;
   end;

   if Not(aQSO.Mode in ContestModeSet[FContestMode]) then begin
      Exit;
   end;

   B := aQSO.Band;

   if C.Worked[B] = False then begin
      C.Worked[B] := True;
      aQSO.NewMulti1 := True;
      // Grid.Cells[0,C.GridIndex] := C.Summary;
   end;
end;

function TWAEMulti.GetInfo(aQSO: TQSO): string;
var
   temp, temp2: string;
   B: TBand;
   C: TCountry;
begin
   C := dmZLogGlobal.GetPrefix(aQSO.Callsign).Country;
   if C.CountryName = 'Unknown' then begin
      Result := 'Unknown CTY';
      exit;
   end;
   temp := '';
   temp := C.Country + ' ' + C.Continent + ' ';

   if C.Continent <> 'EU' then begin
      temp := 'NOT EUROPE ' + temp;
      Result := temp;
      exit;
   end;

   temp2 := '';
   if C.Worked[aQSO.Band] = False then
      temp2 := 'CTY';

   if temp2 <> '' then
      temp2 := 'NEW ' + temp2;

   temp := temp + temp2 + ' ';

   temp := temp + 'needed on : ';
   for B := b19 to b28 do
      if NotWARC(B) then
         if C.Worked[B] = False then
            temp := temp + MHzString[B] + ' ';

   Result := temp;
end;

procedure TWAEMulti.UpdateData;
begin
   ShowContinent('EU');
   RefreshGrid;
   // RefreshZone;
   RenewCluster;
   RenewBandScope;
end;

end.
