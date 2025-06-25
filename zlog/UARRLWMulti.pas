unit UARRLWMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UWWMulti, UMultipliers, StdCtrls, ExtCtrls, JLLabel, Grids,
  UzLogConst, UzLogGlobal, UzLogQSO, USpotClass;

type
  TARRLWMulti = class(TWWMulti)
    procedure FormCreate(Sender: TObject);
  protected
  private
    { Private declarations }
  public
    { Public declarations }
    ALLASIANFLAG : boolean;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
    procedure CheckMulti(aQSO : TQSO); override;
    function GetInfo(aQSO: TQSO): string; override;
    procedure ProcessCluster(var Sp : TBaseSpot); override;
  end;

implementation

uses
  Main;

{$R *.DFM}

function TARRLWMulti.GetInfo(aQSO: TQSO): string;
begin
   Result := dmZLogGlobal.GetPrefix(aQSO.Callsign).Country.JustInfo;
end;

procedure TARRLWMulti.CheckMulti(aQSO: TQSO);
begin
   //
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

   P := dmZLogGlobal.GetPrefix(aQSO.Callsign);
   C := P.Country;
   aQSO.Multi1 := C.Country;

   if C.Index = -1 then begin
      Grid.TopRow := 0;
   end
   else begin
      Grid.TopRow := C.Index;
   end;

   if aQSO.Dupe then begin
      exit;
   end;

   if ALLASIANFLAG = True then begin
      aQSO.Points := 0;
      // MainForm.Caption := C.Country+';'+MyCOuntry+';';
      if C.Country = dmZLogGlobal.MyCountry then begin
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
begin
   { inherited; }
   ALLASIANFLAG := False;

   Reset;
end;

procedure TARRLWMulti.ProcessCluster(var Sp : TBaseSpot);
begin
   Inherited;

   if ALLASIANFLAG = True then begin
      Sp.NewZone := False;
   end;
end;

end.
