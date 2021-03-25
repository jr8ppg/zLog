unit UCheckCountry;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UCheckWin, StdCtrls, ExtCtrls, UWWMulti, UMultipliers,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TCheckCountry = class(TCheckWin)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    TempCountry : TCountry; // holds the last country analyzed;
    TempZone : integer;
  public
    { Public declarations }
    ParentMulti : TWWMulti;
    procedure Renew(aQSO : TQSO); override;
    function NotNewMulti(B : TBand) : boolean;
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TCheckCountry.Renew(aQSO: TQSO);
var
   cty: string;
   i: LongInt;
   z, row: integer;
   B: TBand;
   C: TCountry;
   S, PartialStr: string;
   BoxFlags: array [0 .. 20] of boolean;
begin
   ResetListBox;
   if length(aQSO.Callsign) = 0 then begin
      exit;
   end;

   for i := 0 to 20 do begin
      BoxFlags[i] := False;
   end;

   C := dmZLogGlobal.GetPrefix(aQSO).Country;
   TempCountry := C;
   Caption := C.Country + ': ' + C.CountryName + ' ' + C.Continent;
   cty := C.Country;
   PartialStr := aQSO.Callsign;
   if cty <> '' then begin
      for i := Log.TotalQSO downto 1 do begin
         if cty = Log.QsoList[i].Multi2 then begin
            B := Log.QsoList[i].Band;
            row := BandRow[B];
            if row >= 0 then begin
               if BoxFlags[row] = False then begin
                  ListBox.Items.Delete(row);
                  ListBox.Items.Insert(row, Main.MyContest.CheckWinSummary(Log.QsoList[i]));
                  BoxFlags[row] := True;
               end
               else begin
                  if Log.QsoList[i].Callsign = PartialStr then begin
                     ListBox.Items.Delete(row);
                     ListBox.Items.Insert(row, Main.MyContest.CheckWinSummary(Log.QsoList[i]));
                  end;
               end;
            end;
         end;
      end;
   end;

   z := StrToIntDef(aQSO.NrRcvd, 0);
   TempZone := z;
   if z in [1 .. 40] then begin
      for B := b19 to b28 do begin
         if BandRow[B] >= 0 then begin
            if ParentMulti.Zone[B, z] = False then begin
               S := ListBox.Items[BandRow[B]];
               S := FillRight(S, 27) + 'Zone ' + FillRight(IntToStr(z), 2) + ' NEEDED';
               ListBox.Items.Delete(BandRow[B]);
               ListBox.Items.Insert(BandRow[B], S);
            end;
         end;
      end;
   end;
end;

procedure TCheckCountry.FormCreate(Sender: TObject);
begin
   inherited;
   TempCountry := nil;
end;

function TCheckCountry.NotNewMulti(B: TBand): boolean;
var
   newcountry, newzone: boolean;
begin
   if TempCountry <> nil then
      newcountry := not(TempCountry.Worked[B])
   else
      newcountry := False;

   if TempZone <> 0 then
      newzone := not(ParentMulti.Zone[B, TempZone])
   else
      newzone := False;

   Result := not(newzone or newcountry);
end;

end.
