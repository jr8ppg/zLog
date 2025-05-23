unit UARRL10Multi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, JLLabel,
  UzLogConst, UzLogGlobal, UzLogQSO, USpotClass, UARRLDXMulti, UWWMulti, UMultipliers;

type
  TARRL10Multi = class(TWWMulti)
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    LatestMultiAddition : integer; // grid top
    procedure UpdateLabelPos(); override;
  private
    { Private declarations }
    StateList : TStateList;
  public
    { Public declarations }
    procedure UpdateData; override;
    procedure Add(var aQSO : TQSO); override;
    procedure SortDefault; override;
    procedure SortZone; override;
    procedure Reset; override;
    procedure RefreshGrid; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
    procedure CheckMulti(aQSO : TQSO); override;
    function GetInfo(aQSO: TQSO): string; override;
    function ExtractMulti(aQSO : TQSO) : string; override;
    procedure ProcessCluster(var Sp : TBaseSpot); override;
    procedure ProcessSpotData(var S : TBaseSpot); override;
  end;

implementation

uses
  Main;

{$R *.DFM}

function TARRL10Multi.GetInfo(aQSO: TQSO): string;
begin
   Result := dmZLogGlobal.GetPrefix(aQSO.Callsign).Country.JustInfo;
end;

procedure TARRL10Multi.CheckMulti(aQSO: TQSO);
var
   S: TState;
   str: string;
begin
   S := GetState(aQSO, StateList);
   if S = nil then
      str := 'Invalid state'
   else begin
      str := S.StateAbbrev + ' ' + S.StateName + ' Worked in : ';
      if S.Worked[b19] then
         str := str + 'Ph ';
      if S.Worked[b35] then
         str := str + 'CW ';
   end;

   MainForm.WriteStatusLine(str, False);
end;

function TARRL10Multi.ValidMulti(aQSO: TQSO): Boolean;
var
   j: Integer;
   C: TCountry;
begin
   Result := False;

   if aQSO.NrRcvd = '' then
      exit;

   if IsMM(aQSO.Callsign) then begin
      if (aQSO.NrRcvd = '1') or (aQSO.NrRcvd = '2') or (aQSO.NrRcvd = '3') then
         Result := True
      else
         Result := False;
      exit;
   end;

   C := dmZLogGlobal.GetPrefix(aQSO.Callsign).Country;
   if IsWVE(C.Country) then begin
      if GetState(aQSO, StateList) <> nil then
         Result := True;
   end
   else // not W/VE serial number
   begin
      j := StrToIntDef(aQSO.NrRcvd, 0);
      if j > 0 then
         Result := True;
   end;
end;

procedure TARRL10Multi.AddNoUpdate(var aQSO: TQSO);
var
   B: TBand;
   C: TCountry;
   S: TState;
begin
   aQSO.NewMulti1 := False;
   aQSO.NewMulti2 := False;

   C := dmZLogGlobal.GetPrefix(aQSO.Callsign).Country;

   if aQSO.Mode = mCW then
      B := b35
   else
      B := b19;

   if aQSO.Dupe then
      exit;

   if IsWVE(C.Country) or IsMM(aQSO.Callsign) then begin
      S := GetState(aQSO, StateList);
      if S = nil then begin
         aQSO.Multi1 := '';
         aQSO.Memo := 'INVALID EXCHANGE ' + aQSO.Memo;
      end
      else begin
         aQSO.Multi1 := S.StateAbbrev;
         if S.Worked[B] = False then begin
            S.Worked[B] := True;
            aQSO.NewMulti1 := True;
         end;
         LatestMultiAddition := S.Index;
      end;
   end
   else begin
      aQSO.Multi1 := C.Country;
      if C.Worked[B] = False then begin
         C.Worked[B] := True;
         aQSO.NewMulti1 := True;
      end;
      LatestMultiAddition := C.GridIndex;
   end;
end;

procedure TARRL10Multi.FormCreate(Sender: TObject);
var
   S: TState;
begin
   { inherited; }
   LatestMultiAddition := 0;
   StateList := TStateList.Create;
   StateList.LoadFromFile('ARRL10.DAT');

   S := TState.Create;
   S.StateAbbrev := '1';
   S.AltAbbrev := '1';
   S.StateName := 'ITU Reg. 1';
   S.Index := StateList.List.Count;
   StateList.List.Add(S);

   S := TState.Create;
   S.StateAbbrev := '2';
   S.AltAbbrev := '2';
   S.StateName := 'ITU Reg. 2';
   S.Index := StateList.List.Count;
   StateList.List.Add(S);

   S := TState.Create;
   S.StateAbbrev := '3';
   S.AltAbbrev := '3';
   S.StateName := 'ITU Reg. 3';
   S.Index := StateList.List.Count;
   StateList.List.Add(S);

   Reset;
end;

procedure TARRL10Multi.FormDestroy(Sender: TObject);
begin
   inherited;
   StateList.Free();
end;

procedure TARRL10Multi.SortZone;
begin
end;

procedure TARRL10Multi.SortDefault;
var
   i, j, offset: Integer;
   S: string;
begin
   if StateList.List.Count = 0 then
      exit;

   j := Grid.TopRow;
   Grid.RowCount := 0;
   Grid.RowCount := StateList.List.Count + dmZLogGlobal.CountryList.Count;

   for i := 0 to StateList.List.Count - 1 do begin
      S := TState(StateList.List[i]).SummaryARRL10;
      // Grid.Cells[0,i] := S;
      TState(StateList.List[i]).Index := i;
      FGridReverse[i] := i;
   end;

   offset := StateList.List.Count;

   if dmZLogGlobal.CountryList.Count = 0 then
      exit;

   for i := 0 to dmZLogGlobal.CountryList.Count - 1 do begin
      // Grid.Cells[0,i + offset] := TCountry(CountryList.List[i]).SummaryARRL10;
      TCountry(dmZLogGlobal.CountryList.List[i]).GridIndex := i + offset;
      FGridReverse[i + offset] := i;
   end;

   Grid.TopRow := j;
end;

procedure TARRL10Multi.UpdateData;
begin
   SortDefault;
   RefreshGrid;

   Grid.TopRow := LatestMultiAddition;

   RenewCluster;
   RenewBandScope;
end;

procedure TARRL10Multi.Add(var aQSO: TQSO);
begin
   AddNoUpdate(aQSO);
   Grid.TopRow := LatestMultiAddition;
   {
     if (aQSO.Reserve2 <> $AA) and (MostRecentCty <> nil) then
     Grid.TopRow := MostRecentCty.GridIndex;
   }
   RefreshGrid;
   // RefreshZone;
   AddSpot(aQSO);
end;

procedure TARRL10Multi.Reset;
var
   B: TBand;
   i: Integer;
begin
   for i := 0 to StateList.List.Count - 1 do
      for B := b19 to HiBand do
         TState(StateList.List[i]).Worked[B] := False;

   for i := 0 to dmZLogGlobal.CountryList.Count - 1 do
      for B := b19 to HiBand do
         TCountry(dmZLogGlobal.CountryList.List[i]).Worked[B] := False;

   SortDefault;
end;

procedure TARRL10Multi.FormShow(Sender: TObject);
begin
   AdjustGridSize(Grid);
   LatestMultiAddition := 0;
   UpdateData();
   PostMessage(Handle, WM_ZLOG_UPDATELABEL, 0, 0);
   RefreshGrid;
end;

procedure TARRL10Multi.RefreshGrid;
var
   i, k: Integer;
   B: TBand;
   S: string;
begin
   if Main.CurrentQSO.Mode = mCW then begin
      B := b35;
   end
   else begin
      B := b19;
   end;

   for i := Grid.TopRow to Grid.TopRow + Grid.VisibleRowCount - 1 do begin
      if (i > Grid.RowCount - 1) then begin
         exit;
      end
      else begin
         k := FGridReverse[i];
         if (i >= 0) and (i < StateList.List.Count) then begin
            S := TState(StateList.List[k]).SummaryARRL10;
            if TState(StateList.List[k]).Worked[B] = True then begin
               Grid.Cells[0, i] := '~' + S;
            end
            else begin
               Grid.Cells[0, i] := S;
            end;
         end
         else if (i >= StateList.List.Count) and (i < dmZLogGlobal.CountryList.Count + StateList.List.Count) then begin
            S := TCountry(dmZLogGlobal.CountryList.List[k]).Summary;
            if pos('N/A', S) > 2 then begin
               Grid.Cells[0, i] := '!' + S;
            end
            else if TCountry(dmZLogGlobal.CountryList.List[k]).Worked[B] = True then begin
               Grid.Cells[0, i] := '~' + S;
            end
            else begin
               Grid.Cells[0, i] := S;
            end;
         end
         else begin
            Grid.Cells[0, i] := '';
         end;
      end;
   end;

   Grid.Refresh();
end;

function TARRL10Multi.ExtractMulti(aQSO: TQSO): string;
var
   C: TCountry;
   S: TState;
begin
   Result := '';

   C := dmZLogGlobal.GetPrefix(aQSO.Callsign).Country;
   if IsWVE(C.Country) or IsMM(aQSO.Callsign) then begin
      S := GetState(aQSO, StateList);
      if S <> nil then
         Result := S.StateAbbrev;
   end
   else begin
      Result := C.Country;
   end;
end;

procedure TARRL10Multi.UpdateLabelPos();
var
   w, l: Integer;
begin
   w := Grid.Canvas.TextWidth('X');
   l := (w * 40) - 2;
   Label1.Left := l;
   Label2.Left := Label1.Left + (w * 3);
end;

procedure TARRL10Multi.ProcessCluster(var Sp : TBaseSpot);
var
   C: TCountry;
   temp : string;
   aQSO : TQSO;
   S: TState;
   B: TBand;
begin
   aQSO := TQSO.Create;
   try
      aQSO.Callsign := Sp.Call;
      aQSO.Band := Sp.Band;
      aQSO.NrRcvd := Sp.Number;

      if aQSO.Mode = mCW then
         B := b35
      else
         B := b19;

      Sp.NewCty := False;
      Sp.NewZone := False;

      // Countryを求める
      C := dmZLogGlobal.GetPrefix(aQSO.Callsign).Country;

      // NEWマルチチェック
      // W/VE局の場合はSTATEのマルチチェック
      temp := aQSO.CallSign;
      if IsWVE(C.Country) or IsMM(aQSO.Callsign) then begin
         S := GetState(aQSO, StateList);
         if (S <> nil) and (S.Worked[B] = True) then begin
            temp := temp + '  new state : ' + (S.StateName);
            Sp.NewCty := True;
         end;
      end
      else begin
         if (C.Worked[B] = false) then begin
            temp := temp + '  new country : ' + (C.Country);
            Sp.NewCty := True;
         end;
      end;

      if Sp.IsNewMulti = True then begin
         temp := temp + ' at ' + MHzString[aQSO.band]+ 'MHz';
         MainForm.WriteStatusText(temp, True, True);
      end;
   finally
      aQSO.Free;
   end;
end;

procedure TARRL10Multi.ProcessSpotData(var S : TBaseSpot);
begin
   ProcessCluster(S);
end;

end.
