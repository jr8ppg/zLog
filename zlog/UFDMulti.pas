unit UFDMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UACAGMulti, StdCtrls, JLLabel, ExtCtrls, Grids,
  UzLogConst, UzLogGlobal, UzLogQSO, UMultipliers;

type
  TFDMulti = class(TACAGMulti)
    procedure FormCreate(Sender: TObject);
  protected
    sband : TBand; // b35 by default. b50 @ 6m&D
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
    procedure CheckMulti(aQSO : TQSO); override;
    procedure UpdateData; override;
  end;

implementation

uses Main;

{$R *.DFM}

procedure TFDMulti.CheckMulti(aQSO: TQSO);
var
   str: string;
   i: Integer;
   C: TCity;
begin
   // inherited;
   str := aQSO.NrRcvd;

   if str = '' then
      exit;

   if CharInSet(str[length(str)], ['H', 'P', 'L', 'M']) then begin
      System.Delete(str, length(str), 1);
   end;

   if aQSO.Band in [b19 .. b1200] then begin
      if not(length(str) in [2 .. 3]) then begin
         MainForm.WriteStatusLine('Invalid number', false);
         exit;
      end;
   end;

   if aQSO.Band in [b2400 .. HiBand] then begin
      if not(length(str) in [4 .. 6]) then begin
         MainForm.WriteStatusLine('Invalid number', false);
         exit;
      end;
   end;

   for i := 0 to CityList.List.Count - 1 do begin
      C := TCity(CityList.List[i]);
      if str = C.CityNumber then begin
         // ListBox.TopIndex := i;
         Grid.TopRow := i;
         str := C.Summary2;
         if C.Worked[aQSO.Band] then
            Insert('Worked on this band. ', str, 27)
         else
            Insert('Needed on this band. ', str, 27);
         MainForm.WriteStatusLine(str, false);
         exit;
      end;
   end;

   MainForm.WriteStatusLine('Invalid number', false);
end;

function TFDMulti.ValidMulti(aQSO: TQSO): Boolean;
var
   str: string;
   i: Integer;
   C: TCity;
   boo: Boolean;
begin
   Result := false;
   str := aQSO.NrRcvd;
   if aQSO.Band in [b19 .. b1200] then begin
      if not(length(str) in [3 .. 4]) then
         exit;
   end
   else begin
      if not(length(str) in [5 .. 7]) then
         exit;
   end;

   if not CharInSet(str[length(str)], ['P', 'L', 'M', 'H']) then
      exit;

   Delete(str, length(str), 1);

   boo := false;
   for i := 0 to CityList.List.Count - 1 do begin
      C := TCity(CityList.List[i]);
      if str = C.CityNumber then begin
         boo := true;
         break;
      end;
   end;

   Result := boo;
end;

procedure TFDMulti.AddNoUpdate(var aQSO: TQSO);
var
   str: string;
   C: TCity;
begin
   aQSO.NewMulti1 := false;
   str := aQSO.NrRcvd;
   Delete(str, length(str), 1);
   aQSO.Multi1 := str;

   if aQSO.Dupe then
      exit;

   C := CityList.GetCity(str);
   if C <> nil then begin
      if C.Worked[aQSO.Band] = false then begin
         C.Worked[aQSO.Band] := true;
         aQSO.NewMulti1 := true;
      end;
      LatestMultiAddition := C.Index;
   end;
end;

procedure TFDMulti.Reset;
var
   i, j: Integer;
   B: TBand;
   str: string;
begin
   if CityList.List.Count = 0 then
      exit;

   // j := ListBox.TopIndex;
   j := Grid.TopRow;
   // ListBox.Items.Clear;
   Grid.RowCount := 0;
   Grid.RowCount := CityList.List.Count;

   for i := 0 to CityList.List.Count - 1 do begin
      for B := b19 to HiBand do
         TCity(CityList.List[i]).Worked[B] := false;
      str := TCity(CityList.List[i]).FDSummary(sband);
      Grid.Cells[0, i] := str;
      // ListBox.Items.Add(str);
      // ListBox.Checked[i] := False;
   end;

   Grid.TopRow := j;
end;

procedure TFDMulti.FormCreate(Sender: TObject);
begin
   LatestMultiAddition := 0;
   sband := b19;
   CityList := TCityList.Create;
   CityList.LoadFromFile('XPO.DAT');
   CityList.LoadFromFile('ACAG.DAT');
   if CityList.List.Count = 0 then
      exit;

   Reset;
end;

procedure TFDMulti.UpdateData;
var
   B: TBand;
   i: Integer;
   C: TCity;
   _top: Integer;
const
   kenmax = 62;
begin
   B := Main.CurrentQSO.Band;

   for i := 0 to CityList.List.Count - 1 do begin
      C := TCity(CityList.List[i]);
      B := Main.CurrentQSO.Band;
      if C.Worked[B] then begin
         Grid.Cells[0, i] := '~' + C.FDSummary(sband);
      end
      else begin
         Grid.Cells[0, i] := C.FDSummary(sband);
      end;
   end;

   _top := LatestMultiAddition;
   if (B in [b19 .. b1200]) and (_top > kenmax) then
      _top := 0;

   if (B in [b2400 .. b10G]) and (_top <= kenmax) then
      _top := kenmax + 1;

   Grid.TopRow := _top;
end;

end.
