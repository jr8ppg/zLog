unit UIARUMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UWWMulti, UMultipliers, StdCtrls, ExtCtrls, JLLabel, Grids,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TIARUZone = class
    Multi : string;
    Worked : array[b19..b28] of boolean;
    function Summary : string;
    constructor Create;
  end;

  TIARUZoneList = class
    List : TList;
    constructor Create;
    destructor Destroy(); override;
    procedure Add(M : TIARUZone);
  end;

  TIARUMulti = class(TWWMulti)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GoButtonClick(Sender: TObject);
    procedure GridTopLeftChanged(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    procedure UpdateLabelPos(); override;
  private
    { Private declarations }
    ZoneList : TIARUZoneList;
  public
    { Public declarations }
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    procedure Add(var aQSO : TQSO); override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
    function GuessZone(aQSO : TQSO) : string; override;
    procedure UpdateData; override;
    procedure RefreshGrid; override;
    function GetInfo(aQSO : TQSO) : string; override;
    procedure CheckMulti(aQSO : TQSO); override;
  end;

implementation

uses Main, UOptions;

{$R *.DFM}

constructor TIARUZone.Create;
var
   B: TBand;
begin
   for B := b19 to b28 do
      Worked[B] := False;

   Multi := '';
end;

function TIARUZone.Summary: string;
var
   i: Integer;
   str: string;
   B: TBand;
begin
   str := '';

   i := StrToIntDef(Multi, 0);

   if (i in [1 .. 90]) then
      str := 'ITU Zone ' + FillLeft(Multi, 2)
   else if (Multi = 'AC') then
      str := 'Admin. Council AC'
   else if (Multi = 'R1') or (Multi = 'R2') or (Multi = 'R3') then
      str := 'Reg. Exec. Committee ' + Multi
   else
      str := 'IARU HQ Station ' + Multi;

   str := FillRight(str, 24);

   for B := b19 to b28 do begin
      if NotWARC(B) then
         if Worked[B] then
            str := str + '* '
         else
            str := str + '. ';
   end;

   Result := str;
end;

constructor TIARUZoneList.Create;
var
   M: TIARUZone;
   i: Integer;
begin
   List := TList.Create;
   for i := 1 to 90 do begin
      M := TIARUZone.Create;
      M.Multi := IntToStr(i);
      List.Add(M);
   end;
   M := TIARUZone.Create;
   M.Multi := 'AC';
   List.Add(M);
   M := TIARUZone.Create;
   M.Multi := 'R1';
   List.Add(M);
   M := TIARUZone.Create;
   M.Multi := 'R2';
   List.Add(M);
   M := TIARUZone.Create;
   M.Multi := 'R3';
   List.Add(M);
end;

destructor TIARUZoneList.Destroy();
var
   i: Integer;
begin
   for i := 0 to List.Count - 1 do begin
      TIARUZone(List[i]).Free();
   end;
   List.Free();
end;

procedure TIARUZoneList.Add(M: TIARUZone);
var
   i, j: Integer;
begin
   // List.Add(M);
   j := List.Count;
   if j > 94 then begin
      for i := 94 to j - 1 do
         if StrMore(M.Multi, TIARUZone(List[i]).Multi) = False then begin
            List.Insert(i, M);
            exit;
         end;
      List.Add(M);
      exit;
   end
   else begin
      List.Add(M);
   end;
end;

procedure TIARUMulti.CheckMulti(aQSO: TQSO);
var
   str, str2: string;
   j, z: Integer;
   B: TBand;
   boo: boolean;
begin
   str := aQSO.NrRcvd;
   boo := False;
   for j := 0 to ZoneList.List.Count - 1 do begin
      if TIARUZone(ZoneList.List[j]).Multi = str then begin
         boo := true;
         break;
      end;
   end;

   if boo = False then begin
      MainForm.WriteStatusLine('HQ ' + str + ' is not worked on any band', False);
      exit;
   end;

   z := StrToIntDef(str, 0);
   if z = 0 then begin
      if str = 'AC' then
         str2 := 'Admin. Council '
      else if (str = 'R1') or (str = 'R2') or (str = 'R3') then
         str2 := 'Reg. Exec. Committee '
      else
         str2 := 'HQ ';
   end
   else
      str2 := 'Zone ';

   str2 := str2 + str + ' : ';
   if TIARUZone(ZoneList.List[j]).Worked[aQSO.Band] then
      str2 := str2 + 'Worked on this band. '
   else
      str2 := str2 + 'Needed on this band. ';

   str2 := str2 + 'Worked on : ';
   for B := b19 to b28 do
      if TIARUZone(ZoneList.List[j]).Worked[B] then
         str2 := str2 + MHzString[B] + ' ';

   MainForm.WriteStatusLine(str2, False);
end;

function TIARUMulti.GuessZone(aQSO: TQSO): string;
var
   i, k: Integer;
   C: TCountry;
   P: TPrefix;
   str: string;
begin
   P := dmZLogGlobal.GetPrefix(aQSO);
   if P = nil then begin
      Result := '';
      exit;
   end;

   C := P.Country;
   str := aQSO.CallSign;
   i := StrToIntDef(C.ITUZone, 0);

   if (C.Country = 'W') or (C.Country = 'K') then begin
      k := dmZLogGlobal.GetArea(str);
      case k of
         1 .. 4:
            i := 8;
         5, 8, 9, 0:
            i := 7;
         6, 7:
            i := 6;
      end;
   end;

   if C.Country = 'VE' then begin
      k := dmZLogGlobal.GetArea(str);
      case k of
         1, 2:
            i := 8;
         3 .. 6:
            i := 3;
         7:
            i := 2;
         8:
            i := 2;
         9:
            i := 9;
         0:
            i := 4;
      end;
   end;

   if C.Country = 'VK' then begin
      k := dmZLogGlobal.GetArea(str);
      case k of
         1 .. 5, 7:
            i := 55;
         6, 8:
            i := 58;
         9, 0:
            i := 30; { Should not happen }
      end;
   end;

   {
     if C.Country = 'BY' then
     begin
     k := GetArea(str);
     case k of
     1..8    : i := 33;
     9,0     : i := 33;
     end;
     end;
   }

   if P.OvrITUZone <> '' then begin
      i := StrToIntDef(P.OvrITUZone, 0);
   end;

   if i = 0 then
      Result := ''
   else
      Result := IntToStr(i);
end;

function TIARUMulti.ValidMulti(aQSO: TQSO): boolean;
begin
   if aQSO.NrRcvd <> '' then
      Result := true
   else
      Result := False;
end;

procedure TIARUMulti.Reset;
var
   i: Integer;
   B: TBand;
begin
   for i := 0 to ZoneList.List.Count - 1 do
      for B := b19 to b28 do
         TIARUZone(ZoneList.List[i]).Worked[B] := False;
   Grid.RowCount := ZoneList.List.Count;
   for i := 0 to ZoneList.List.Count - 1 do
      Grid.Cells[0, i] := (TIARUZone(ZoneList.List[i]).Summary);
   // ListBox.Items[i] := (TIARUZone(ZoneList.List[i]).Summary);
end;

procedure TIARUMulti.FormCreate(Sender: TObject);
begin
   // inherited;
   ZoneList := TIARUZoneList.Create;

   Reset;
end;

procedure TIARUMulti.FormDestroy(Sender: TObject);
begin
   inherited;
   ZoneList.Free();
end;

function TIARUMulti.GetInfo(aQSO: TQSO): string;
var
   i, k: Integer;
   C: TCountry;
   P: TPrefix;
   str: string;
   zone: string;
   B: TBand;
begin
   P := dmZLogGlobal.GetPrefix(aQSO);
   if P = nil then begin
      Result := 'Unknown prefix';
      exit;
   end;

   C := P.Country;
   str := 'Continent: ';

   if P.OvrContinent <> '' then
      str := str + P.OvrContinent
   else
      str := str + C.Continent;

   zone := C.ITUZone;
   if P.OvrITUZone <> '' then begin
      zone := P.OvrITUZone;
   end;

   str := str + '   ITU Zone/Multi: ' + zone + '  Worked on: ';
   for i := 0 to ZoneList.List.Count - 1 do begin
      if TIARUZone(ZoneList.List[i]).Multi = zone then begin
         for B := b19 to b28 do
            if NotWARC(B) then
               if TIARUZone(ZoneList.List[i]).Worked[B] then
                  str := str + MHzString[B] + ' '
               else
                  for k := 1 to length(MHzString[B]) do
                     str := str + ' ';
      end;
   end;

   Result := str;
end;

procedure TIARUMulti.UpdateData;
var
   j: Integer;
   B: TBand;
begin
   B := Main.CurrentQSO.Band;
   if B = bUnknown then begin
      Exit;
   end;

   Grid.RowCount := ZoneList.List.Count;
   for j := 0 to ZoneList.List.Count - 1 do begin
      if TIARUZone(ZoneList.List[j]).Worked[B] = True then begin
         Grid.Cells[0, j] := '~' + TIARUZone(ZoneList.List[j]).Summary;
      end
      else begin
         Grid.Cells[0, j] := TIARUZone(ZoneList.List[j]).Summary;
      end;
   end;
   RenewCluster;
   RenewBandScope;
end;

procedure TIARUMulti.AddNoUpdate(var aQSO: TQSO);
var
   str: string;
   i, j: Integer;
   C: TCountry;
   P: TPrefix;
   _cont: string;
   boo, HQ: boolean;
   M: TIARUZone;
begin
   aQSO.NewMulti1 := False;
   str := aQSO.NrRcvd;
   aQSO.Multi1 := str;

   if aQSO.Dupe then
      exit;

   i := StrToIntDef(str, 0);

   HQ := true;
   if i in [1 .. 90] then begin
      str := IntToStr(i);
      HQ := False;
   end;

   boo := False;
   for j := 0 to ZoneList.List.Count - 1 do begin
      if TIARUZone(ZoneList.List[j]).Multi = str then begin
         boo := true;
         if TIARUZone(ZoneList.List[j]).Worked[aQSO.Band] = False then begin
            TIARUZone(ZoneList.List[j]).Worked[aQSO.Band] := true;
            aQSO.NewMulti1 := true;
            break;
         end;
      end;
   end;

   if boo = False then begin
      M := TIARUZone.Create;
      M.Multi := str;
      M.Worked[aQSO.Band] := true;
      aQSO.NewMulti1 := true;
      ZoneList.Add(M);
      UpdateData;
      // Grid.Cells[0,ZoneList.List.Count-1] := M.Summary;
   end;

   P := dmZLogGlobal.GetPrefix(aQSO);
   C := P.Country;

   if P = nil then
      _cont := C.Continent
   else if P.OvrContinent = '' then
      _cont := C.Continent
   else
      _cont := P.OvrContinent;

   if (dmZLogGlobal.MyITUZone = str) or (HQ = true) then
      aQSO.Points := 1
   else if dmZLogGlobal.MyContinent = _cont then
      aQSO.Points := 3
   else
      aQSO.Points := 5;
end;

procedure TIARUMulti.FormShow(Sender: TObject);
begin
   AdjustGridSize(Grid);
   UpdateData();
   PostMessage(Handle, WM_ZLOG_UPDATELABEL, 0, 0);
end;

procedure TIARUMulti.GoButtonClick(Sender: TObject);
var
   i: Integer;
   temp: string;
begin
   temp := Edit1.Text;
   for i := 0 to ZoneList.List.Count - 1 do begin
      if pos(temp, TIARUZone(ZoneList.List[i]).Multi) = 1 then begin
         // ListBox.TopIndex := i;
         Grid.TopRow := i;
         break;
      end;
   end;
end;

procedure TIARUMulti.RefreshGrid;
begin
   // inherit
   UpdateData;
end;

procedure TIARUMulti.GridTopLeftChanged(Sender: TObject);
begin
   // inherited;
   // Update;
end;

procedure TIARUMulti.Add(var aQSO: TQSO);
begin
   AddNoUpdate(aQSO);
   {
     if (aQSO.Reserve2 <> $AA) and (MostRecentCty <> nil) then
     Grid.TopRow := MostRecentCty.GridIndex;
   }
   RefreshGrid;
   // RefreshZone;
   AddSpot(aQSO);
end;

procedure TIARUMulti.UpdateLabelPos();
var
   w, l: Integer;
begin
   w := Grid.Canvas.TextWidth('X');
   l := (w * 24) - 2;
   RotateLabel1.Left := l;
   RotateLabel2.Left := RotateLabel1.Left + (w * 2);
   RotateLabel3.Left := RotateLabel2.Left + (w * 2);
   RotateLabel4.Left := RotateLabel3.Left + (w * 2);
   RotateLabel5.Left := RotateLabel4.Left + (w * 2);
   RotateLabel6.Left := RotateLabel5.Left + (w * 2);
end;

end.
