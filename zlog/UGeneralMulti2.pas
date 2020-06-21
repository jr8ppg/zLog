unit UGeneralMulti2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UACAGMulti, StdCtrls, JLLabel, ExtCtrls, checklst, Grids, Menus,
  UzLogConst, UzLogGlobal, UzLogQSO, Cologrid, UWPXMulti, UMultipliers;

const  MAXLOCAL = 31;
       PX_WPX    = 1;
       PX_NORMAL = 2;
       BANDLABELMAX = 30;
type
  TGeneralMulti2 = class(TACAGMulti)
    procedure FormCreate(Sender: TObject);
    procedure GridSetting(ARow, Acol: Integer; var Fcolor: Integer;
      var Bold, Italic, underline: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function GetPX(aQSO : TQSO) : string;
  public
    BandLabelArray : array[0..BANDLABELMAX] of TRotateLabel;

    PXMulti : integer;

    _DXTEST : boolean;
    NoCTYMulti : string; // use citylist for these countries
    LocalCTY, LocalCONT : string;

    LocalString : array[0..MAXLOCAL] of string;
    MinLocalLen : integer;
    _cut, _lcut, _tail, _ltail : integer;
    UndefMulti : boolean; //
    CountOnce : boolean; // count multi once regardless of band
    CutTailingAlphabets : boolean; // JARL/CUTTAILABT
    AllowUnlistedMulti : boolean; // allows unlisted multi to be logged but not counted as a multi.
    NoMulti : boolean;
    WARC: Boolean;
    function IsLocal(aQSO : TQSO) : boolean;
    procedure LoadDAT(Filename : string);
    procedure LoadCTY(CTYTYPE : string);
    function ExtractMulti(aQSO : TQSO) : string; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
    procedure CheckMulti(aQSO : TQSO); override;
    procedure Reset; override;
    procedure UpdateData; override;
    { Public declarations }
  end;

implementation

uses Main, UGeneralScore;

{$R *.DFM}

function TGeneralMulti2.GetPX(aQSO : TQSO) : string;
var
   s: string;
   i, slash : integer;
begin
   Result := '';
   s := aQSO.Callsign;
   if s = '' then
      exit;

   slash := pos('/',s);
   if PXMulti = PX_WPX then begin
      Result := UWPXMulti.GetWPXPrefix(aQSO);
      exit;
   end
   else begin
      if slash > 4 then begin
         s := copy(s, 1, slash-1);
      end;

      if slash in [1..4] then begin
         Delete(s, 1, slash);
      end;

      i := length(s) + 1;
      repeat
         dec(i)
      until (i = 0) or CharInSet(s[i], ['0'..'9']);

      Result := copy(s,1,i);
      exit;
   end;
end;

procedure TGeneralMulti2.UpdateData;
var
   i, j : integer;
   C : TCity;
   str : string;
   B : TBand;
begin
   i := 0;
   for B := b19 to Hiband do begin
      if (MainForm.BandMenu.Items[Ord(B)].Visible = True) and
         (dmZlogGlobal.Settings._activebands[B] = True) then begin
          BandLabelArray[i].Caption := MHzString[B];
          j := BandLabelArray[i].Height;
          Application.ProcessMessages();
          BandLabelArray[i].Top := 35 - j;
          inc(i);
      end;
   end;

   for j := i to BANDLABELMAX do begin
      BandLabelArray[j].Caption := '';
   end;

   if Grid.RowCount < CityList.List.Count then begin
      Grid.RowCount := CityList.List.Count;
   end;

   if _DXTEST then begin
      if CountryList.Count > 0 then begin
         if NoCTYMulti <> '*' then begin
            Grid.RowCount := CityList.List.Count + CountryList.Count;
         end;
      end;
   end;

   for i := 0 to CityList.List.Count - 1 do begin
      C := TCity(CityList.List[i]);
      str := C.SummaryGeneral;
      Grid.Cells[0, i] := str;
   end;

   if CityList.List.Count = 0 then begin
      i := 0;
   end
   else begin
      i := CityList.List.Count - 1;
   end;

   if _DXTEST and (NoCTYMulti <> '*') then begin
      for j := 0 to CountryList.Count - 1 do begin
         Grid.Cells[0, i + j] := TCountry(CountryList.List[j]).SummaryGeneral;
      end;
   end;

   Grid.TopRow := LatestMultiAddition;
end;

procedure TGeneralMulti2.Reset;
begin
   if CountryList <> nil then
      CountryList.Reset;

   if CityList <> nil then
      CityList.Reset;
end;


function TGeneralMulti2.ValidMulti(aQSO : TQSO) : boolean;
var
   str : string;
   i : integer;
   C : TCity;
   boo : boolean;
begin
   if UndefMulti or AllowUnlistedMulti or (PXMulti <> 0) or _DXTEST or NoMulti then begin
      Result := True;
      exit;
   end;

   str := ExtractMulti(aQSO);
   boo := false;
   for i := 0 to CityList.List.Count-1 do begin
      C := TCity(CityList.List[i]);
      if pos(','+str+',', ','+C.CityNumber+',') > 0 then begin
         boo := true;
         break;
      end;
   end;

   Result := boo;
end;

function TGeneralMulti2.ExtractMulti(aQSO : TQSO) : string;
var
   str : string;
   i : integer;
begin
   str := aQSO.NrRcvd;

   if PXMulti <> 0 then begin
      Result := GetPX(aQSO);
      exit;
   end;

   if CutTailingAlphabets then begin // deletes any tailing non-digits
      for i := length(str) downto 1 do
         if CharInSet(str[i], ['0'..'9']) then
            break;

      if (i = 1) and CharInSet(str[1], ['0'..'9']) then
         str := ''
      else
         str := copy(str, 1, i);
   end;

   if IsLocal(aQSO) then begin
      if _lcut <> 0 then begin
         if _lcut > 0 then
            Delete(str, length(str)-_lcut+1, _lcut)
         else
            Delete(str, 1, _lcut * -1);
      end
      else begin {lcut = 0}
         if _ltail <> 0 then
            if _ltail > 0 then
               str := copy(str, length(str)-_ltail+1, _ltail)
            else
               str := copy(str, 1, -1*_ltail);
      end;
   end
   else begin {not local}
      if _cut <> 0 then begin
         if _cut > 0 then
            Delete(str, length(str)-_cut+1, _cut)
         else
            Delete(str, 1, _cut * -1);
      end
      else begin {cut = 0}
         if _tail <> 0 then
            if _tail > 0 then
               str := copy(str, length(str)-_tail+1, _tail)
            else
               str := copy(str, 1, -1*_tail);
      end;
   end;

   Result := str;
end;

procedure TGeneralMulti2.AddNoUpdate(var aQSO : TQSO);
var
   str, str2 : string;
   B : TBand;
   i: integer;
   C : TCity;
   Cty : TCountry;
   boo : Boolean;
label aaa;
begin
   aQSO.NewMulti1 := False;
   if NoMulti then exit;
   aQSO.Power2 := 2; // not local CTY

   if _DXTEST then begin
      Cty := GetPrefix(aQSO).Country;

      aQSO.Power2 := Cty.Index;

      if NoCtyMulti = '*' then
         goto aaa;

      if pos(',' + Cty.Country + ',', ',' + NoCTYMulti + ',') > 0 then
         goto aaa;


      aQSO.Multi1 := Cty.Country;

      if aQSO.Dupe then
         exit;

      LatestMultiAddition := CityList.List.Count + Cty.Index;

      if CountOnce then begin // multi once regardless of band
         boo := false;
         for B := b19 to HiBand do begin
             if Cty.Worked[B] then begin
                 boo := true;
                 break;
             end;
         end;

         if boo = false then begin
            aQSO.NewMulti1 := True;
            Cty.Worked[aQSO.Band] := True;
         end;
      end
      else begin // new multi each band
         if Cty.Worked[aQSO.Band] = False then begin
            aQSO.NewMulti1 := True;
            Cty.Worked[aQSO.Band] := True;
         end;
      end;

      exit;
   end;

aaa:
   str := ExtractMulti(aQSO);
   aQSO.Multi1 := str;

   if aQSO.Dupe then
      exit;

   for i := 0 to CityList.List.Count-1 do begin
      C := TCity(CityList.List[i]);

      str2 := ','+C.CityNumber+',';         //  for alternative exchange
      if pos (','+str+',', str2) > 0 then begin
         if C.Worked[aQSO.band] = False then begin
            C.Worked[aQSO.band] := True;
            aQSO.NewMulti1 := True;
         end;

         LatestMultiAddition := C.Index;
         exit;
      end;
   end;

   // no match with CityList

   if AllowUnlistedMulti then begin
      exit;
   end;

   if UndefMulti or (PXMulti <> 0) then begin
      C := TCity.Create;
      C.CityNumber := str;
      C.Worked[aQSO.Band] := True;
      CityList.AddAndSort(C);
      aQSO.NewMulti1 := True;
      LatestMultiAddition := C.Index;
   end;
end;

function TGeneralMulti2.IsLocal(aQSO : TQSO) : boolean;
var
   i : integer;
begin
   Result := False;

   if _DXTEST then begin
      if LocalCTY <> '' then begin
         i := aQSO.Power2;
         if i < CountryList.Count then
            if pos(',' + TCountry(CountryList.List[i]).Country + ',', ',' + LocalCTY + ',') > 0 then begin
               Result := True;
               exit;
            end;
      end;

      if LocalCONT <> '' then begin
         i := aQSO.Power2;
         if i < CountryList.Count then
            if pos(',' + TCountry(CountryList.List[i]).Continent + ',', ',' + LocalCONT + ',') > 0 then begin
               Result := True;
               exit;
            end;
      end;
   end;

   for i := 0 to MAXLOCAL do begin
      if LocalString[i] = '' then begin
         exit;
      end
      else begin
         if (Pos(LocalString[i], aQSO.NrRcvd) = 1) and
            (Length(aQSO.NrRcvd) >= MinLocalLen) then begin
            Result := True;
            exit;
         end;
      end;
   end;
end;

procedure TGeneralMulti2.LoadDAT(Filename : string);
begin
   CityList.LoadFromFile(FileName);
   Reset;
end;

procedure TGeneralMulti2.LoadCTY(CTYTYPE : string);
begin
   CountryList := TCountryList.Create;
   PrefixList := TPrefixList.Create;
   _DXTEST := True;

   if LoadCTY_DAT() = False then begin
      Exit;
   end;

   MainForm.WriteStatusLine('Loaded CTY.DAT', true);

   AnalyzeMyCountry;
end;

procedure TGeneralMulti2.FormCreate(Sender: TObject);
var
   i : integer;
begin
   //inherited;
   LatestMultiAddition := 0;
   Label1R9.Visible := True;
   CityList := TCityList.Create;
   UndefMulti := False;
   NoMulti := False;
   CountOnce := False;
   CutTailingAlphabets := False;
   AllowUnlistedMulti := False;
   PXMulti := 0;
   _DXTEST := false;
   NoCtyMulti := '';
   LocalCTY := '';
   LocalCONT := '';
   //SetActiveBands;

   Label1R9.Visible := False;
   Label3R5.Visible := False;
   Label7.Visible := False;
   Label14.Visible := False;
   Label21.Visible := False;
   Label28.Visible := False;
   Label50.Visible := False;
   Label144.Visible := False;
   Label430.Visible := False;
   Label1200.Visible := False;
   Label2400.Visible := False;
   Label5600.Visible := False;
   Label10G.Visible := False;

   for i := 0 to BANDLABELMAX do begin
      BandLabelArray[i] := TRotateLabel.Create(Self);
      BandLabelArray[i].Parent := Panel;
      BandLabelArray[i].Escapement := 90;
      BandLabelArray[i].Alignment := taleftjustify;
      BandLabelArray[i].Font := Label1R9.Font;
      BandLabelArray[i].TextStyle := tsNone;
      BandLabelArray[i].Left := Label1R9.Left + Trunc(12.15*i);
      BandLabelArray[i].Top := 10;
      //BandLabelArray[i].Height := 1;
      BandLabelArray[i].AutoSize := True;
      BandLabelArray[i].Caption := '';
   end;
end;

procedure TGeneralMulti2.CheckMulti(aQSO : TQSO);
var
   str : string;
   strSjis: AnsiString;
   i : integer;
   C : TCity;
begin
   if ValidMulti(aQSO) then
      str := ExtractMulti(aQSO)
   else
      str := aQSO.NrRcvd;

   if str = '' then
      exit;

   for i := 0 to CityList.List.Count-1 do begin
      C := TCity(CityList.List[i]);
      if pos(','+str+',', ','+C.CityNumber+',') > 0 then begin
         Grid.TopRow := i;
         str := C.Summary2;
         strSjis := AnsiString(str);

         if C.Worked[aQSO.Band] then
            Insert('Worked on this band. ',strSjis, 27)
         else
            Insert('Needed on this band. ',strSjis, 27);

         str := String(strSjis);
         MainForm.WriteStatusLine(str, false);
         exit;
      end;
   end;

   if UndefMulti then
      MainForm.WriteStatusLine(str+ ' : '+'Not worked on any band', false)
   else
      MainForm.WriteStatusLine('Invalid number', false);
end;

procedure TGeneralMulti2.GridSetting(ARow, Acol: Integer;
  var Fcolor: Integer; var Bold, Italic, underline: Boolean);
var
   B, B2 : TBand;
   C : TCountry;
begin
   //inherited;
   B := Main.CurrentQSO.Band;
   if _DXTEST then begin
      if ARow > CityList.List.Count - 1 then begin
         C := TCountry(CountryList.List[ARow - CityList.List.Count]);
         if C.Worked[B] then begin
            FColor := clRed;
         end
         else begin
            if CountOnce then begin
               for B2 := b19 to HiBand do begin
                  if C.Worked[B2] then begin
                     FColor := clRed;
                     exit;
                  end;
               end;
            end;
            FColor := clBlack;
         end;
         exit;
      end;
   end;

   if ARow > CityList.List.Count - 1 then
      exit;

   if TCity(CityList.List[ARow]).Worked[B] then begin
      FColor := clRed
   end
   else begin
      FColor := clBlack;

      if CountOnce then begin
         for B2 := b19 to HiBand do begin
            if TCity(CityList.List[ARow]).Worked[B2] then begin
                FColor := clRed;
                exit;
            end;
         end;
      end;
   end;
end;

procedure TGeneralMulti2.FormShow(Sender: TObject);
begin
   inherited;
   LatestMultiAddition := 0;
   UpdateData;
end;

end.
