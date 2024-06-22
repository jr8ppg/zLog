unit UWWMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicMulti, StdCtrls, JLLabel, ExtCtrls, Grids, StrUtils,
  UzLogConst, UzLogGlobal, UzLogQSO, USpotClass, UComm, UMultipliers, UWWZone;

const
  WM_ZLOG_UPDATELABEL = (WM_USER + 100);

type
  TZoneArray = array[b19..HiBand, 1..40] of Boolean;
  TWWMulti = class(TBasicMulti)
    Panel: TPanel;
    Panel1: TPanel;
    buttonGo: TButton;
    Edit1: TEdit;
    RotateLabel1: TRotateLabel;
    RotateLabel2: TRotateLabel;
    RotateLabel3: TRotateLabel;
    RotateLabel4: TRotateLabel;
    RotateLabel5: TRotateLabel;
    RotateLabel6: TRotateLabel;
    SortBy: TRadioGroup;
    StayOnTop: TCheckBox;
    Grid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GoButtonClick(Sender: TObject);
    procedure SortByClick(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
    procedure GridTopLeftChanged(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
  private
    { Private declarations }
    procedure GoForwardMatch(strCode: string);
  protected
    FZoneForm: TWWZone;
    FZoneFlag: TZoneArray;
    FMostRecentCty: TCountry;
    FGridReverse: array[0..500] of integer; {pointer from grid row to countrylist index}
    procedure SetFontSize(v: Integer); override;
    procedure OnZLogUpdateLabel( var Message: TMessage ); message WM_ZLOG_UPDATELABEL;
    procedure UpdateLabelPos(); virtual;
  public
    { Public declarations }

    procedure AddNewPrefix(PX : string; CtyIndex : integer); override;
    procedure SelectAndAddNewPrefix(Call : string); override;
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    procedure Add(var aQSO : TQSO); override; // only calls addnoupdate but no update
    procedure UpdateData; override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
    function GuessZone(strCallsign: string) : string; override;
    function GetInfo(aQSO : TQSO): string; override;
    procedure ProcessCluster(var Sp : TBaseSpot); override;
    procedure SortZone; virtual;
    procedure SortContinent; virtual;
    procedure SortDefault; virtual;
    procedure ShowContinent(CT: string);
    procedure CheckMulti(aQSO : TQSO); override;
    procedure RefreshGrid; virtual;
    procedure RefreshZone;
    procedure ProcessSpotData(var S : TBaseSpot); override;
    property ZoneForm: TWWZone read FZoneForm write FZoneForm;
    property Zone: TZoneArray read FZoneFlag write FZoneFlag;
  end;

implementation

uses
  UOptions, Main, UNewPrefix;

{$R *.DFM}

{
procedure TWWMulti.AddNewPrefixToFile(NewPX : string; CtyIndex : integer);
var
   L : TStringList;
   C : TCountry;
   cname, s : string;
   i, j, p : integer;
label xxx;
begin
   L := TStringList.Create;
   try
      L.LoadFromFile(_DATFileName);

      C := TCountry(CountryList.List[CtyIndex]);
      cname := TrimRight(C.CountryName);
      if _DATFileName = 'CTY.DAT' then begin
         for i := 0 to L.Count - 1 do begin
            s := L[i];
            if s[1] <> ' ' then begin
               p := pos(':', s);
               if p > 0 then
                  s := TrimRight(copy(s, 1, p - 1))
               else
                  s := '';

               if cname = s then begin
                  for j := i + 1 to L.Count - 1 do begin
                     s := TrimRight(L[j]);
                     if pos(';', s) = length(s) then begin
                        s := copy(s, 1, length(s) - 1);
                        s := s + ',' + NewPX + ';';
                        L[j] := s;
                        goto xxx;
                     end;
                  end;
               end;
            end;
         end;
      end
      else begin
         for i := 0 to L.Count - 1 do begin
            s := L[i];
            if s[1] <> ' ' then begin
               s := copy(s, 1, 26);
               s := TrimRight(s);
               if cname = s then begin
                  for j := i + 1 to L.Count - 1 do begin
                     s := TrimRight(L[j]);
                     if pos(';', s) = length(s) then begin
                        s := copy(s, 1, length(s) - 1);
                        s := s + ',' + NewPX + ';';
                        L[j] := s;
                        goto xxx;
                     end;
                  end;
               end;
            end;
         end;
      end;
   xxx:
      L.SaveToFile(_DATFileName);
   finally
      L.Free;
   end;
end;
}

procedure TWWMulti.AddNewPrefix(PX : string; CtyIndex : integer);
var
   P : TPrefix;
begin
   P := TPrefix.Create;
   P.Prefix := PX;
   P.Country := dmZLogGlobal.CountryList[CtyIndex];
   dmZLogGlobal.PrefixList.Add(P);

//   AddNewPrefixToFile(P.Prefix, P.Index);
   Main.MyContest.Renew;
end;

procedure TWWMulti.SelectAndAddNewPrefix(Call : string);
var
   F: TNewPrefix;
begin
   F := TNewPrefix.Create(Self);
   try
      F.Init(dmZLogGlobal.CountryList, Call);
      if F.ShowModal() <> mrOK then begin
         Exit;
      end;

      if (F.Prefix <> '') and (F.CtyIndex >= 0) then begin
         AddNewPrefix(F.Prefix, F.CtyIndex);
      end;
   finally
      F.Release();
   end;
end;

procedure TWWMulti.Add(var aQSO : TQSO);
begin
   AddNoUpdate(aQSO);

   if (aQSO.Reserve2 <> $AA) and (FMostRecentCty <> nil) then begin
      Grid.TopRow := FMostRecentCty.GridIndex;
   end;

   RefreshGrid;
   RefreshZone;

   AddSpot(aQSO);
end;

procedure TWWMulti.UpdateData;
begin
   case SortBy.ItemIndex of
      0 : SortDefault;
      1 : SortZone;
   end;

   RefreshGrid;
   RefreshZone;
   RenewCluster;
   RenewBandScope;
end;

procedure TWWMulti.SortDefault;
var
   i: integer;
begin
   if dmZLogGlobal.CountryList.Count = 0 then begin
      exit;
   end;

   for i := 0 to dmZLogGlobal.CountryList.Count-1 do begin
      TCountry(dmZLogGlobal.CountryList.List[i]).GridIndex := i;
      FGridReverse[i] := i;
   end;
end;

procedure TWWMulti.SortZone;
var
   i, j, x: integer;
   strZone: string;
begin
   if dmZLogGlobal.CountryList.Count = 0 then begin
      exit;
   end;

   FGridReverse[0] := 0;
   x := 1;
   for i := 1 to 40 do begin
      strZone := RightStr('00' + IntToStr(i), 2);
      for j := 1 to dmZLogGlobal.CountryList.Count - 1 do begin
         if TCountry(dmZLogGlobal.CountryList.List[j]).CQZone = strZone then begin
            TCountry(dmZLogGlobal.CountryList.List[j]).GridIndex := x;
            FGridReverse[x] := j;
            inc(x);
         end;
      end;
   end;
end;

procedure TWWMulti.SortContinent;
var
   i, j, x: integer;
   cont : array[0..5] of string;
begin
   cont[0] := 'AS';
   cont[1] := 'AF';
   cont[2] := 'EU';
   cont[3] := 'NA';
   cont[4] := 'SA';
   cont[5] := 'OC';
   if dmZLogGlobal.CountryList.Count = 0 then exit;
   FGridReverse[0] := 0;
   x := 1;

   for i := 0 to 5 do begin
      for j := 1 to dmZLogGlobal.CountryList.Count - 1 do begin
         if TCountry(dmZLogGlobal.CountryList.List[j]).Continent = cont[i] then begin
            TCountry(dmZLogGlobal.CountryList.List[j]).GridIndex := x;
            FGridReverse[x] := j;
            inc(x);
         end;
      end;
   end;
end;

procedure TWWMulti.ShowContinent(CT: string);
var
   i, j, x: integer;
   cont : array[0..5] of string[3];
begin
   cont[0] := 'AS';
   cont[1] := 'AF';
   cont[2] := 'EU';
   cont[3] := 'NA';
   cont[4] := 'SA';
   cont[5] := 'OC';

   if dmZLogGlobal.CountryList.Count = 0 then begin
      exit;
   end;

   FGridReverse[0] := 0;

   for i := 1 to 500 do
      FGridReverse[i] := -1;

   x := 1;

   for j := 1 to dmZLogGlobal.CountryList.Count - 1 do begin
      if TCountry(dmZLogGlobal.CountryList.List[j]).Continent = CT then begin
         TCountry(dmZLogGlobal.CountryList.List[j]).GridIndex := x;
         FGridReverse[x] := j;
         inc(x);
      end
      else begin
         TCountry(dmZLogGlobal.CountryList.List[j]).GridIndex := 0;
         //GridReverse[x] := -1;
         //inc(x);
      end;
   end;

   Grid.RowCount := x;
end;

procedure TWWMulti.Reset;
var
   B : TBand;
   i : integer;
begin
   if Assigned(FZoneForm) then begin
      FZoneForm.Reset;
   end;

   for B := b19 to HiBand do begin
      for i := 1 to MAXCQZONE do begin
         FZoneFlag[B, i] := False;
      end;
   end;

   if dmZLogGlobal.CountryList.Count = 0 then exit;

   for i := 0 to dmZLogGlobal.CountryList.Count-1 do begin
      for B := b19 to HiBand do begin
         TCountry(dmZLogGlobal.CountryList.List[i]).Worked[B] := false;
      end;
   end;

   case SortBy.ItemIndex of
      0 : SortDefault;
      1 : SortZone;
   end;

   Grid.RowCount := dmZLogGlobal.CountryList.Count;
end;

procedure TWWMulti.RefreshGrid;
var
   i , k : integer;
   C: TCountry;
   B: TBand;
begin
   B := Main.CurrentQSO.Band;
   if B = bUnknown then begin
      Exit;
   end;

   for i := Grid.TopRow to Grid.TopRow + Grid.VisibleRowCount - 1 do begin
      if (i > Grid.RowCount - 1) then begin
         exit;
      end
      else begin
         k := FGridReverse[i];
         C := TCountry(dmZLogGlobal.CountryList.List[k]);
         if (k >= 0) and (k < dmZLogGlobal.CountryList.Count) then begin
            if C.Worked[B] = True then begin
               Grid.Cells[0, i] := '~' + C.Summary;
            end
            else begin
               Grid.Cells[0, i] := C.Summary;
            end;
         end
         else begin
            Grid.Cells[0, i] := '';
         end;
      end;
   end;

   Grid.Refresh();
end;

procedure TWWMulti.RefreshZone;
var
   i : integer;
   B : TBand;
begin
   if Not Assigned(FZoneForm) then begin
      Exit;
   end;

   FZoneForm.Reset;

   for B := b19 to b28 do begin
      if NotWARC(B) then begin
         for i := 1 to 40 do begin
            if Zone[B, i] then begin
               FZoneForm.Mark(B, i);
            end;
         end;
      end;
   end;
end;

procedure TWWMulti.FormCreate(Sender: TObject);
begin
   Inherited;
   FZoneForm := nil;
   FMostRecentCty := nil;
   MainForm.mnGridAddNewPX.Visible := True;
end;

procedure TWWMulti.FormResize(Sender: TObject);
begin
   Inherited;
   AdjustGridSize(Grid);
   RefreshGrid;
end;

procedure TWWMulti.AddNoUpdate(var aQSO : TQSO);
var
   str: string;
   B: TBand;
   i: integer;
   C: TCountry;
   P: TPrefix;
   _cont: string;
begin
   aQSO.NewMulti1 := False;
   aQSO.NewMulti2 := False;
   str := aQSO.NrRcvd;
   aQSO.Multi1 := str;
   aQSO.Multi2 := '';

   if aQSO.Dupe then
      exit;

   B := aQSO.band;
   i := StrToIntDef(str, 0);

   if i in [1..MAXCQZONE] then begin
      if FZoneFlag[B, i] = False then begin
        FZoneFlag[B, i] := True;
        aQSO.NewMulti1 := True;
      end;
   end;

   P := dmZLogGlobal.GetPrefix(aQSO.Callsign);

   if P = nil then begin
      aQSO.Points := 0;
      aQSO.Multi1 := 'Unknown';
      aQSO.Memo := '** UNKNOWN CTY ** '+aQSO.Memo;
      exit;
   end;

   C := P.Country;
   FMostRecentCty := C;

   aQSO.Multi2 := C.Country;

   if C.Worked[B] = False then begin
      C.Worked[B] := True;
      aQSO.NewMulti2 := True;
      //Grid.Cells[0,C.GridIndex] := C.Summary;
    end;

   if P.OvrContinent = '' then
      _cont := C.Continent
   else
      _cont := P.OvrContinent;

   if dmZLogGlobal.MyCountry = C.Country then
      aQSO.points := 0
   else begin
      if dmZLogGlobal.MyContinent = _cont then begin
         if dmZLogGlobal.MyContinent = 'NA' then
            aQSO.points := 2
         else
            aQSO.points := 1;
      end
      else begin
         aQSO.points := 3;
      end;
   end;
end;

function TWWMulti.ValidMulti(aQSO : TQSO) : boolean;
var
   str : string;
   i : integer;
begin
   str := aQSO.NrRcvd;
   i := StrToIntDef(str, 0);

   if i in [1..MAXCQZONE] then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TWWMulti.FormShow(Sender: TObject);
begin
   Inherited;
   AdjustGridSize(Grid);
   UpdateData();
   PostMessage(Handle, WM_ZLOG_UPDATELABEL, 0, 0);

   if Assigned(FZoneForm) then begin
      FZoneForm.Show;
   end;
end;

function TWWMulti.GuessZone(strCallsign: string) : string;
begin
   Result := dmZLogGlobal.GuessCQZone(strCallsign);
end;

function TWWMulti.GetInfo(aQSO : TQSO) : string;
var
   temp, temp2 : string;
   B : TBand;
   i : integer;
   C : TCountry;
begin
   C := dmZLogGlobal.GetPrefix(aQSO.Callsign).Country;
   if C.CountryName = 'Unknown' then begin
      Result := 'Unknown CTY';
      exit;
   end;

   GoForwardMatch(C.Country);

   temp := '';
   temp := C.Country + ' ' + C.Continent + ' ';

   temp2 := '';
   if C.Worked[aQSO.Band] = false then
      temp2 := 'CTY';

   i := StrToIntDef(aQSO.NrRcvd, 0);
   if i in [1..40] then begin
      if Zone[aQSO.Band, i] = False then begin
         temp2 := temp2 + ' ZONE';
      end;
   end;

   if temp2 <> '' then
      temp2 := 'NEW '+temp2;

   temp := temp + temp2 + ' ';

   temp := temp + 'needed on : ';
   for B := b19 to b28 do
      if NotWARC(B) then
         if C.Worked[B]=False then
            temp := temp + MHzString[B] + ' ';

   Result := temp;
end;


procedure TWWMulti.GoButtonClick(Sender: TObject);
begin
   GoForwardMatch(Edit1.Text);
end;

procedure TWWMulti.GoForwardMatch(strCode: string);
var
   i: Integer;
   l: Integer;

   function GetRowIndex(Index: Integer): Integer;
   var
      i: Integer;
   begin
      for i := 0 to High(FGridReverse) do begin
         if FGridReverse[i] = Index then begin
            Result := i;
            Exit;
         end;
      end;

      Result := 0;
   end;
begin
   l := Length(strCode);
   for i := 0 to dmZLogGlobal.CountryList.Count - 1 do begin
      if (strCode = Copy(TCountry(dmZLogGlobal.CountryList.List[i]).Country, 1, l)) then begin
         Grid.TopRow := GetRowIndex(i);
         Break;
      end;
   end;
end;

procedure TWWMulti.Edit1Change(Sender: TObject);
begin
   GoForwardMatch(Edit1.Text);
end;

procedure TWWMulti.Edit1Enter(Sender: TObject);
begin
   buttonGo.Default := True;
end;

procedure TWWMulti.Edit1Exit(Sender: TObject);
begin
   buttonGo.Default := False;
end;

procedure TWWMulti.ProcessCluster(var Sp : TBaseSpot);
var
   Z: integer;
   C: TCountry;
   temp : string;
   aQSO : TQSO;
begin
   aQSO := TQSO.Create;
   try
      aQSO.Callsign := Sp.Call;
      aQSO.Band := Sp.Band;

      Sp.NewCty := False;
      Sp.NewZone := False;

      // CQ Zoneを求める
      temp := GuessZone(aQSO.Callsign);
      Z := StrToIntDef(temp, 0);

      // Countryを求める
      C := dmZLogGlobal.GetPrefix(aQSO.Callsign).Country;
      Sp.Zone := Z;
      Sp.CtyIndex := C.Index;

      // NEWマルチチェック
      temp := aQSO.CallSign;
      if (Z > 0) and (Zone[aQSO.band, Z] = False) then begin {and not singlebander on other band}
         temp := temp + '  new zone : ' + GuessZone(aQSO.Callsign);
         Sp.NewZone := True;
      end;

      if (C.Worked[aQSO.Band] = false) then begin
         temp := temp + '  new country : ' + (C.Country);
         Sp.NewCty := True;
      end;

      if Sp.IsNewMulti = True then begin
         temp := temp + ' at ' + MHzString[aQSO.band]+ 'MHz';
         MainForm.WriteStatusText(temp, True, True);
      end;
   finally
      aQSO.Free;
   end;
end;

procedure TWWMulti.SortByClick(Sender: TObject);
begin
   Inherited;

   case SortBy.ItemIndex of
      0 : SortDefault;
      1 : SortZone;
      2 : SortContinent;
   end;

   RefreshGrid;
end;

procedure TWWMulti.CheckMulti(aQSO : TQSO);
var
   str : string;
   i : integer;
   B : TBand;
begin
   str := aQSO.NrRcvd;
   i := StrToIntDef(str, 0);

   if i in [1..MAXCQZONE] then begin
      str := 'Zone '+IntToStr(i)+ ' : ';
      if Zone[aQSO.Band, i] then
         str := str + 'Worked on this band. '
      else
         str := str + 'Needed on this band. ';

      str := str + 'Worked on : ';
      for B := b19 to b28 do begin
         if Zone[B, i] then begin
            str := str + MHzString[B] + ' ';
         end;
      end;

      MainForm.WriteStatusLine(str, false);
   end
   else begin
      MainForm.WriteStatusLine(TMainForm_Invalid_zone, false);
   end;
end;

procedure TWWMulti.StayOnTopClick(Sender: TObject);
begin
   if StayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
end;

procedure TWWMulti.ProcessSpotData(var S : TBaseSpot);
begin
   ProcessCluster(S);
end;

procedure TWWMulti.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateLabelPos();
   UpdateData();
end;

procedure TWWMulti.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(Grid, ACol, ARow, Rect);
end;

procedure TWWMulti.GridTopLeftChanged(Sender: TObject);
begin
   //inherited;
   RefreshGrid;
end;

procedure TWWMulti.UpdateLabelPos();
var
   w, l: Integer;
begin
   w := Grid.Canvas.TextWidth('X');
   l := (w * 42) - 2;
   RotateLabel1.Left := l;
   RotateLabel2.Left := RotateLabel1.Left + (w * 2);
   RotateLabel3.Left := RotateLabel2.Left + (w * 2);
   RotateLabel4.Left := RotateLabel3.Left + (w * 2);
   RotateLabel5.Left := RotateLabel4.Left + (w * 2);
   RotateLabel6.Left := RotateLabel5.Left + (w * 2);
end;

procedure TWWMulti.OnZLogUpdateLabel( var Message: TMessage );
begin
   Application.ProcessMessages();
   UpdateLabelPos();
end;

end.
