unit UGeneralMulti2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UACAGMulti, StdCtrls, JLLabel, ExtCtrls, Grids, Menus,
  UzLogConst, UzLogGlobal, UzLogQSO, UWPXMulti, UMultipliers;

const  MAXLOCAL = 31;
       PX_WPX    = 1;
       PX_NORMAL = 2;
       BANDLABELMAX = 30;
type
  TGeneralMulti2 = class(TACAGMulti)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  protected
    BandLabelArray : array[0..BANDLABELMAX] of TRotateLabel;
    procedure UpdateLabelPos(); override;
  private
    { Private declarations }
    function GetPX(aQSO : TQSO) : string;
  public
    { Public declarations }
    PXMulti : Integer;
    _DXTEST : Boolean;
    NoMulti : Boolean;
    WARC: Boolean;
    CutTailingAlphabets : Boolean; // JARL/CUTTAILABT
    LocalString : array[0..MAXLOCAL] of string;
    MinLocalLen : Integer;
    _cut, _lcut, _tail, _ltail : Integer;
    NoCTYMulti : string; // use citylist for these countries
    LocalCTY, LocalCONT : string;
    UndefMulti : Boolean; //
    CountOnce : Boolean; // count multi once regardless of band
    AllowUnlistedMulti : Boolean; // allows unlisted multi to be logged but not counted as a multi.
    function IsLocal(aQSO : TQSO) : Boolean;
    procedure LoadDAT(Filename : string);
    procedure LoadCTY(CTYTYPE : string);
    function ExtractMulti(aQSO : TQSO) : string; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    function ValidMulti(aQSO : TQSO) : Boolean; override;
    procedure CheckMulti(aQSO : TQSO); override;
    procedure Reset; override;
    procedure UpdateData; override;
  end;

implementation

uses Main, UGeneralScore, UzLogExtension;

{$R *.DFM}

function TGeneralMulti2.GetPX(aQSO : TQSO) : string;
var
   s: string;
   i, slash : Integer;
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
   i, j : Integer;
   CTY: TCity;
   CNT: TCountry;
   B: TBand;
   B2: TBand;
   R: Integer;
begin
   i := 0;
   for B := b19 to Hiband do begin
      if (MainForm.BandMenu.Items[Ord(B)].Visible = True) and
         (dmZlogGlobal.Settings._activebands[B] = True) then begin
         BandLabelArray[i].Caption := MHzString[B];
         j := BandLabelArray[i].Height;
         Application.ProcessMessages();
         BandLabelArray[i].Top := 35 - j;
         Inc(i);
      end;
   end;

   for j := i to BANDLABELMAX do begin
      BandLabelArray[j].Caption := '';
   end;

   if Grid.RowCount < CityList.List.Count then begin
      Grid.RowCount := CityList.List.Count;
   end;

   if _DXTEST then begin
      if dmZLogGlobal.CountryList.Count > 0 then begin
         if NoCTYMulti <> '*' then begin
            Grid.RowCount := CityList.List.Count + dmZLogGlobal.CountryList.Count;
         end;
      end;
   end;

   // B=現在バンド
   B := Main.CurrentQSO.Band;

   // CityListをGridにセット
   for i := 0 to CityList.List.Count - 1 do begin
      CTY := TCity(CityList.List[i]);
      if CTY.Worked[B] then begin
         Grid.Cells[0, i] := '~' + CTY.SummaryGeneral;
      end
      else begin
         Grid.Cells[0, i] := CTY.SummaryGeneral;

         if CountOnce then begin
            for B2 := b19 to HiBand do begin
               if CTY.Worked[B2] then begin
                  Grid.Cells[0, i] := '~' + CTY.SummaryGeneral;
                  Break;
               end;
            end;
         end;
      end;
   end;

   // CountryListをGridにセット
   if _DXTEST and (NoCTYMulti <> '*') then begin
      for i := 0 to dmZLogGlobal.CountryList.Count - 1 do begin
         CNT := TCountry(dmZLogGlobal.CountryList.List[i]);
         R := CityList.List.Count + i;

         if CNT.Worked[B] then begin
            Grid.Cells[0, R] := '~' + CNT.SummaryGeneral;
         end
         else begin
            Grid.Cells[0, R] := CNT.SummaryGeneral;

            if CountOnce then begin
               for B2 := b19 to HiBand do begin
                  if CNT.Worked[B2] then begin
                     Grid.Cells[0, R] := '*' + CNT.SummaryGeneral;
                     Break;
                  end;
               end;
            end;
         end;
      end;
   end;

   if checkJumpLatestMulti.Checked = True then begin
      Grid.TopRow := LatestMultiAddition;
   end;
end;

procedure TGeneralMulti2.Reset;
begin
   if dmZLogGlobal.CountryList <> nil then
      dmZLogGlobal.CountryList.Reset;

   if CityList <> nil then
      CityList.Reset;
end;


function TGeneralMulti2.ValidMulti(aQSO : TQSO) : Boolean;
var
   str : string;
   i : Integer;
   C : TCity;
   boo : Boolean;
begin
   if UndefMulti or AllowUnlistedMulti or (PXMulti <> 0) or _DXTEST or NoMulti then begin
      Result := True;
      exit;
   end;

   if zLogValidMultiHookHandler(aQSO, boo) = True then begin
      Result := boo;
      Exit;
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
   i : Integer;
begin
   str := '';
   if zLogExtractMultiHookHandler(aQSO, str) = True then begin
      Result := str;
      Exit;
   end;

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
   i: Integer;
   C : TCity;
   Cty : TCountry;
   boo : Boolean;
label aaa;
begin
   aQSO.NewMulti1 := False;
   if NoMulti then exit;
   aQSO.Power2 := 2; // not local CTY

   if _DXTEST then begin
      Cty := dmZLogGlobal.GetPrefix(aQSO).Country;

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

function TGeneralMulti2.IsLocal(aQSO : TQSO) : Boolean;
var
   i : Integer;
begin
   Result := False;

   if _DXTEST then begin
      if LocalCTY <> '' then begin
         i := aQSO.Power2;
         if (i > -1) and (i < dmZLogGlobal.CountryList.Count) then
            if pos(',' + TCountry(dmZLogGlobal.CountryList.List[i]).Country + ',', ',' + LocalCTY + ',') > 0 then begin
               Result := True;
               exit;
            end;
      end;

      if LocalCONT <> '' then begin
         i := aQSO.Power2;
         if (i > -1) and (i < dmZLogGlobal.CountryList.Count) then
            if pos(',' + TCountry(dmZLogGlobal.CountryList.List[i]).Continent + ',', ',' + LocalCONT + ',') > 0 then begin
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
   if not zLogRequestDAT(Filename, CityList) then
      CityList.LoadFromFile(FileName);
   Reset;
end;

procedure TGeneralMulti2.LoadCTY(CTYTYPE : string);
begin
   _DXTEST := True;
end;

procedure TGeneralMulti2.FormCreate(Sender: TObject);
var
   i : Integer;
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
      BandLabelArray[i].Visible := False;
   end;
end;

procedure TGeneralMulti2.CheckMulti(aQSO : TQSO);
var
   str : string;
   strSjis: AnsiString;
   i : Integer;
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

procedure TGeneralMulti2.FormShow(Sender: TObject);
begin
   inherited;
//   LatestMultiAddition := 0;
//   UpdateData;
end;

procedure TGeneralMulti2.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(Grid, ACol, ARow, Rect);
end;

procedure TGeneralMulti2.UpdateLabelPos();
var
   w, l: Integer;
   B: TBand;
   i: Integer;
   j: Integer;
begin
   w := Grid.Canvas.TextWidth('X');
   l := (w * 33) - 2;
   i := 0;
   j := 0;

   for B := b19 to Hiband do begin
      if (MainForm.BandMenu.Items[Ord(B)].Visible = True) and
         (dmZlogGlobal.Settings._activebands[B] = True) then begin

         if i = 0 then begin
            BandLabelArray[i].Left := l;
         end
         else begin
            BandLabelArray[i].Left := BandLabelArray[j].Left + (w * 2);
         end;
         BandLabelArray[i].Visible := True;

         j := i;
         Inc(i);
      end;
   end;
end;

end.
