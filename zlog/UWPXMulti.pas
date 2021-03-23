unit UWPXMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UWWMulti, UMultipliers, StdCtrls, JLLabel, ExtCtrls, Grids,
  UComm, USpotClass, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TWPXMulti = class(TWWMulti)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GoButtonClick(Sender: TObject);
  private
    { Private declarations }
    WPXList : TStringList;
  public
    { Public declarations }
    procedure RefreshGrid; override;
    procedure SavePXList(filename : string);
    function TotalPrefix : integer;
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
    procedure ProcessCluster(var Sp : TBaseSpot); override;
    procedure UpdateData; override;
  end;

function GetWPXPrefix(aQSO : TQSO) : string;

implementation

uses UOptions, Main;

{$R *.DFM}

procedure TWPXMulti.RefreshGrid;
var
   i: Integer;
begin
   Grid.RowCount := WPXList.Count;
   for i := Grid.TopRow to Grid.TopRow + Grid.VisibleRowCount - 1 do begin
      if (i > Grid.RowCount - 1) then begin
         exit;
      end
      else begin
         if (i >= 0) and (i < WPXList.Count) then begin
            Grid.Cells[0, i] := WPXList[i];
         end
         else
            Grid.Cells[0, i] := '';
      end;
   end;
end;

procedure TWPXMulti.SavePXList(filename: string);
begin
   WPXList.SaveToFile(filename);
end;

function TWPXMulti.TotalPrefix: Integer;
begin
   Result := WPXList.Count;
end;

function GetWPXPrefix(aQSO: TQSO): string;
var
   str, temp: string;
   i, j, k: Integer;
   boo: Boolean;
begin
   str := aQSO.CallSign;
   i := pos('/', str);
   if i > 0 then begin
      temp := copy(str, i + 1, 255);
      if (temp = 'AA') or (temp = 'AT') or (temp = 'AG') or (temp = 'AA') or (temp = 'AE') or (temp = 'M') or (temp = 'P') or (temp = 'AM') or
         (temp = 'QRP') or (temp = 'A') or (temp = 'KT') or (temp = 'MM') then begin
         str := copy(str, 1, i - 1) { cut /AA /M etc }
      end
      else begin
         if (length(temp) = 1) and CharInSet(temp[1], ['0' .. '9']) then begin { JA1ZLO/2 }
            j := 1;

            repeat
               inc(j);
            until CharInSet(str[j], ['0' .. '9']) or (length(str) < j);

            str := copy(str, 1, j);
            str[j] := temp[1];
            Result := str;
            exit;
         end
         else begin
            if i > 4 then begin { JA1ZLO/JD1, KH0AM/W6 etc NOT KH0/AD6AJ }
               boo := false;
               k := 0;
               for j := 1 to length(temp) do begin
                  if CharInSet(temp[j], ['0' .. '9']) then begin
                     k := j; // holds the pos of last numeral
                     boo := true;
                  end;
               end;

               if boo = false then begin
                  temp := temp + '0' { AD6AJ/PA => PA0 }
               end
               else begin
                  if CharInSet(temp[length(temp)], ['A' .. 'Z']) then begin // /VP2E etc
                     temp := copy(temp, 1, k);
                  end;
               end;

               Result := temp;
               exit;
            end
            else begin { KH0/AD6AJ }
               temp := copy(str, 1, i - 1);
               boo := false;
               k := 0;
               for j := 1 to length(temp) do begin
                  if CharInSet(temp[j], ['0' .. '9']) then begin
                     boo := true;
                     k := j;
                  end;
               end;

               if boo = false then begin
                  temp := temp + '0' { PA/AD6AJ => PA0 }
               end
               else begin
                  if CharInSet(temp[length(temp)], ['A' .. 'Z']) then begin
                     temp := copy(temp, 1, k);
                  end;
               end;

               Result := temp;
               exit;
            end;
         end;
      end;
   end;

   j := 1;

   repeat
      inc(j);
   until (length(str) < j) or CharInSet(str[j], ['0' .. '9']);

   if j > length(str) then begin { XEFTA etc => XE0 }
      Result := copy(str, 1, 2) + '0';
      exit;
   end;

   j := length(str) + 1;

   repeat
      dec(j);
   until (j = 1) or CharInSet(str[j], ['0' .. '9']);

   Result := copy(str, 1, j);
end;

procedure TWPXMulti.FormCreate(Sender: TObject);
var
   aQSO: TQSO;
   C: TCountry;
begin
   { inherited; }
   WPXList := TStringList.Create;
   WPXList.Sorted := true;
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

   if (dmZlogGlobal.Settings._mycall <> '') and (dmZlogGlobal.Settings._mycall <> 'Your call sign') then begin
      aQSO := TQSO.Create;
      aQSO.CallSign := UpperCase(dmZlogGlobal.Settings._mycall);
      C := GetPrefix(aQSO).Country;
      MyCountry := C.Country;
      MyContinent := C.Continent;
      aQSO.Free;
   end;

   // WWZone.Reset;
end;

procedure TWPXMulti.FormDestroy(Sender: TObject);
begin
   inherited;
   WPXList.Free();
   CountryList.Free();
   PrefixList.Free();
end;

procedure TWPXMulti.Reset;
begin
   WPXList.Clear;
end;

procedure TWPXMulti.UpdateData;
begin
   RefreshGrid;
end;

procedure TWPXMulti.AddNoUpdate(var aQSO: TQSO);
var
   str: string;
   C: TCountry;
   P: TPrefix;
   _cont: string;
begin
   aQSO.NewMulti1 := false;
   str := GetWPXPrefix(aQSO);
   aQSO.Multi1 := str;
   aQSO.Points := 0;

   if aQSO.Dupe then
      exit;

   if WPXList.IndexOf(str) >= 0 then begin
   end
   else begin
      WPXList.Add(str);
      aQSO.NewMulti1 := true;
   end;

   P := GetPrefix(aQSO);
   if P = nil then // /MM
   begin
      aQSO.Points := 0;
      exit;
   end;
   C := P.Country;

   if P.OvrContinent = '' then
      _cont := C.Continent
   else
      _cont := P.OvrContinent;

   if _cont = 'AS' then
      aQSO.Power2 := 777; // flag for all asian mode (dx side)

   // MAINFORM.WRITESTATUSLINE(C.COUNTRY);

   if C.Country = MyCountry then begin
      aQSO.Points := 1;
      exit;
   end;

   if MyContinent = _cont then
      if MyContinent = 'NA' then
         if aQSO.Band in [b19 .. b7] then
            aQSO.Points := 4
         else
            aQSO.Points := 2
      else if aQSO.Band in [b19 .. b7] then
         aQSO.Points := 2
      else
         aQSO.Points := 1
   else if aQSO.Band in [b19 .. b7] then
      aQSO.Points := 6
   else
      aQSO.Points := 3;

end;

function TWPXMulti.ValidMulti(aQSO: TQSO): Boolean;
var
   str: string;
   i: Integer;
begin
   str := aQSO.NrRcvd;
   i := StrToIntDef(str, -1);
   if i >= 0 then
      Result := true
   else
      Result := false;
end;

procedure TWPXMulti.ProcessCluster(var Sp: TBaseSpot);
var
   i: Integer;
   temp, px: string;
   boo: Boolean;
   aQSO: TQSO;
begin
   aQSO := TQSO.Create;
   aQSO.CallSign := Sp.Call;
   aQSO.Band := Sp.Band;

   Sp.NewCty := false;
   Sp.NewZone := false;
   Sp.Worked := false;
   if Log.IsDupe(aQSO) > 0 then begin
      Sp.Worked := true;
      aQSO.Free;
      exit;
   end;

   temp := aQSO.CallSign;

   px := GetWPXPrefix(aQSO);

   boo := false;
   for i := 0 to WPXList.Count - 1 do
      if px = WPXList[i] then
         boo := true;

   if boo = false then begin
      temp := temp + '  new prefix : ' + px;
      Sp.NewCty := true;
   end;

   if Sp.NewMulti { Pos('new', temp) > 0 } then begin
      temp := temp + ' at ' + MHzString[aQSO.Band] + 'MHz';
      MainForm.CommForm.WriteStatusLine(temp);
      // CommForm.Show;
   end;

   aQSO.Free;
end;

procedure TWPXMulti.GoButtonClick(Sender: TObject);
var
   temp: string;
   i: Integer;
begin
   temp := Edit1.Text;
   for i := 0 to WPXList.Count - 1 do begin
      if pos(temp, WPXList[i]) = 1 then begin
         Grid.TopRow := i;
         break;
      end;
   end;
end;

end.
