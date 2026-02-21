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
    procedure AddNoUpdate(aQSO: TQSO); override;
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TJIDXMulti.FormCreate(Sender: TObject);
begin
   {inherited; }
   Reset;
end;

procedure TJIDXMulti.AddNoUpdate(aQSO: TQSO);
var
   str: string;
   B: TBand;
   i: integer;
   P: TPrefix;
   C: TCountry;
begin
   aQSO.NewMulti1 := False;
   aQSO.NewMulti2 := False;
   str := aQSO.NrRcvd;
   aQSO.Multi1 := str;

   if aQSO.Dupe then begin
      Exit;
   end;

   if Not(aQSO.Mode in ContestModeSet[FContestMode]) then begin
      Exit;
   end;

   B := aQSO.band;
   i := StrToIntDef(str, 0);

   if i in [1..MAXCQZONE] then begin
      if FZoneFlag[B, i] = False then begin
         FZoneFlag[B, i] := True;
         aQSO.NewMulti1 := True;
         FZoneForm.Mark(B,i);
      end;
   end;

   P := dmZLogGlobal.GetPrefix(aQSO.Callsign);
   C := P.Country;

   if (P = nil) or (P.OvrContinent = '') then begin
      aQSO.Continent := C.Continent;
   end
   else begin
      aQSO.Continent := P.OvrContinent;
   end;

   aQSO.Entity := C.Country;

   if C.Country = '' then begin // unknown cty. e.g. MM
      Exit;
   end;

   FMostRecentCty := C;
   aQSO.Multi2 := C.Country;

   if C.Worked[B] = False then begin
      C.Worked[B] := True;
      aQSO.NewMulti2 := True;
      Grid.Cells[0,C.GridIndex] := C.Summary;
   end;
end;

end.
