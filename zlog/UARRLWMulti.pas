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
    procedure FormDestroy(Sender: TObject);
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

function TARRLWMulti.GetInfoAA(aQSO: TQSO): string;
var
   P: TPrefix;
begin
   P := GetPrefix(aQSO);
   P.Country.JustInfo;
end;

procedure TARRLWMulti.CheckMulti(aQSO: TQSO);
begin
end;

function TARRLWMulti.ValidMulti(aQSO: TQSO): boolean;
begin
   if aQSO.NrRcvd <> '' then
      Result := True
   else
      Result := False;
end;

procedure TARRLWMulti.AddNoUpdate(var aQSO: TQSO);
var
   B: TBand;
   C: TCountry;
   P: TPrefix;
begin
   aQSO.NewMulti1 := False;
   aQSO.NewMulti2 := False;

   P := GetPrefix(aQSO);
   C := P.Country;
   aQSO.Multi1 := C.Country;

   if aQSO.Dupe then begin
      exit;
   end;

   if ALLASIANFLAG = True then begin
      aQSO.Points := 0;
      // MainForm.Caption := C.Country+';'+MyCOuntry+';';
      if C.Country = MyCountry then begin
         aQSO.Points := 0;
         exit;
      end
      else begin
         if C.Continent = 'AS' then begin
            case aQSO.Band of
               b19:
                  aQSO.Points := 3;
               b35, b28:
                  aQSO.Points := 2;
               else
                  aQSO.Points := 1;
            end;
         end
         else begin
            case aQSO.Band of
               b19:
                  aQSO.Points := 9;
               b35, b28:
                  aQSO.Points := 6;
               else
                  aQSO.Points := 3;
            end;
         end;
      end;
   end;

   B := aQSO.Band;

   if C.Worked[B] = False then begin
      C.Worked[B] := True;
      aQSO.NewMulti1 := True;
      // Grid.Cells[0,C.GridIndex] := C.Summary;
   end;
end;

procedure TARRLWMulti.FormCreate(Sender: TObject);
var
   aQSO: TQSO;
   C: TCountry;
begin
   { inherited; }
   ALLASIANFLAG := False;
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
      C := GetPrefix(aQSO).Country;
      MyCountry := C.Country;
      MyContinent := C.Continent;
      aQSO.Free;
   end;
end;

procedure TARRLWMulti.FormDestroy(Sender: TObject);
begin
   inherited;
   CountryList.Free();
   PrefixList.Free();
end;

procedure TARRLWMulti.FormShow(Sender: TObject);
begin
   // inherited;
end;

end.
