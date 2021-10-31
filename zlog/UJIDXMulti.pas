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
begin
   {inherited; }
   Reset;
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
      if FZoneFlag[B, i] = False then begin
         FZoneFlag[B, i] := True;
         aQSO.NewMulti1 := True;
         FZoneForm.Mark(B,i);
      end;
   end;

   C := dmZLogGlobal.GetPrefix(aQSO).Country;
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
