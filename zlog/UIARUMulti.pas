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
    FList: TList;
    constructor Create;
    destructor Destroy(); override;
    procedure Add(M: TIARUZone);
    function IndexOf(strMulti: string): Integer;
  end;

  TIARUMulti = class(TWWMulti)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GoButtonClick(Sender: TObject);
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
    function GuessZone(strCallsign: string) : string; override;
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
   FList := TList.Create;
   for i := 1 to 90 do begin
      M := TIARUZone.Create;
      M.Multi := IntToStr(i);
      FList.Add(M);
   end;
   M := TIARUZone.Create;
   M.Multi := 'AC';
   FList.Add(M);
   M := TIARUZone.Create;
   M.Multi := 'R1';
   FList.Add(M);
   M := TIARUZone.Create;
   M.Multi := 'R2';
   FList.Add(M);
   M := TIARUZone.Create;
   M.Multi := 'R3';
   FList.Add(M);
end;

destructor TIARUZoneList.Destroy();
var
   i: Integer;
begin
   for i := 0 to FList.Count - 1 do begin
      TIARUZone(FList[i]).Free();
   end;
   FList.Free();
end;

procedure TIARUZoneList.Add(M: TIARUZone);
var
   i, j: Integer;
begin
   j := FList.Count;
   if j > 94 then begin
      for i := 94 to j - 1 do begin
         if StrMore(M.Multi, TIARUZone(FList[i]).Multi) = False then begin
            FList.Insert(i, M);
            exit;
         end;
      end;

      FList.Add(M);
      Exit;
   end
   else begin
      FList.Add(M);
   end;
end;

function TIARUZoneList.IndexOf(strMulti: string): Integer;
var
   i: Integer;
begin
   for i := 0 to FList.Count - 1 do begin
      if TIARUZone(FList[i]).Multi = strMulti then begin
         Result := i;
         Exit;
      end;
   end;

   Result := -1;
end;

procedure TIARUMulti.CheckMulti(aQSO: TQSO);
var
   str, str2: string;
   z: Integer;
   B: TBand;
   Index: Integer;
   ZoneObj: TIARUZone;
begin
   str := aQSO.NrRcvd;

   Index := ZoneList.IndexOf(str);
   if Index = -1 then begin
      MainForm.WriteStatusLine('HQ ' + str + ' is not worked on any band', False);
      Exit;
   end;

   Grid.TopRow := Index;
   ZoneObj := TIARUZone(ZoneList.FList[Index]);

   z := StrToIntDef(str, 0);
   if z = 0 then begin
      if str = 'AC' then
         str2 := 'Admin. Council '
      else if (str = 'R1') or (str = 'R2') or (str = 'R3') then
         str2 := 'Reg. Exec. Committee '
      else
         str2 := 'HQ ';
   end
   else begin
      str2 := 'Zone ';
   end;

   str2 := str2 + str + ' : ';
   if ZoneObj.Worked[aQSO.Band] then
      str2 := str2 + 'Worked on this band. '
   else
      str2 := str2 + 'Needed on this band. ';

   str2 := str2 + 'Worked on : ';
   for B := b19 to b28 do begin
      if ZoneObj.Worked[B] then begin
         str2 := str2 + MHzString[B] + ' ';
      end;
   end;

   MainForm.WriteStatusLine(str2, False);
end;

function TIARUMulti.GuessZone(strCallsign: string): string;
var
   i, k: Integer;
   C: TCountry;
   P: TPrefix;
   str: string;
begin
   P := dmZLogGlobal.GetPrefix(strCallsign);
   if P = nil then begin
      Result := '';
      exit;
   end;

   C := P.Country;
   str := strCallSign;
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
      Result := True
   else
      Result := False;
end;

procedure TIARUMulti.Reset;
var
   i: Integer;
   B: TBand;
begin
   for i := 0 to ZoneList.FList.Count - 1 do begin
      for B := b19 to b28 do begin
         TIARUZone(ZoneList.FList[i]).Worked[B] := False;
      end;
   end;

   Grid.RowCount := ZoneList.FList.Count;
   for i := 0 to ZoneList.FList.Count - 1 do begin
      Grid.Cells[0, i] := (TIARUZone(ZoneList.FList[i]).Summary);
   end;
end;

procedure TIARUMulti.FormCreate(Sender: TObject);
begin
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
   k: Integer;
   C: TCountry;
   P: TPrefix;
   str: string;
   zone: string;
   B: TBand;
   Index: Integer;
begin
   P := dmZLogGlobal.GetPrefix(aQSO.Callsign);
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

   Index := ZoneList.IndexOf(zone);
   if Index <> -1 then begin
      for B := b19 to b28 do begin
         if NotWARC(B) then begin
            if TIARUZone(ZoneList.FList[Index]).Worked[B] then begin
               str := str + MHzString[B] + ' ';
            end
            else begin
               for k := 1 to length(MHzString[B]) do begin
                  str := str + ' ';
               end;
            end;
         end;
      end;
   end;

   Result := str;
end;

procedure TIARUMulti.UpdateData;
var
   j: Integer;
   B: TBand;
   ZoneObj: TIARUZone;
begin
   B := Main.CurrentQSO.Band;
   if B = bUnknown then begin
      Exit;
   end;

   Grid.RowCount := ZoneList.FList.Count;

   for j := 0 to ZoneList.FList.Count - 1 do begin
      ZoneObj := TIARUZone(ZoneList.FList[j]);
      if ZoneObj.Worked[B] = True then begin
         Grid.Cells[0, j] := '~' + ZoneObj.Summary;
      end
      else begin
         Grid.Cells[0, j] := ZoneObj.Summary;
      end;
   end;

   Grid.Refresh();

   RenewCluster;
   RenewBandScope;
end;

procedure TIARUMulti.AddNoUpdate(var aQSO: TQSO);
var
   str: string;
   i: Integer;
   C: TCountry;
   P: TPrefix;
   _cont: string;
   HQ: boolean;
   M: TIARUZone;
   Index: Integer;
   ZoneObj: TIARUZone;
begin
   aQSO.NewMulti1 := False;
   str := aQSO.NrRcvd;
   aQSO.Multi1 := str;

   if aQSO.Dupe then
      exit;

   i := StrToIntDef(str, 0);

   HQ := True;
   if i in [1 .. 90] then begin
      str := IntToStr(i);
      HQ := False;
   end;

   Index := ZoneList.IndexOf(str);
   if Index = -1 then begin
      M := TIARUZone.Create();
      M.Multi := str;
      M.Worked[aQSO.Band] := True;
      aQSO.NewMulti1 := True;
      ZoneList.Add(M);
      UpdateData;
   end
   else begin
      Grid.TopRow := Index;
      ZoneObj := TIARUZone(ZoneList.FList[Index]);

      if ZoneObj.Worked[aQSO.Band] = False then begin
         ZoneObj.Worked[aQSO.Band] := True;
         aQSO.NewMulti1 := True;
      end;
   end;

   P := dmZLogGlobal.GetPrefix(aQSO.Callsign);
   C := P.Country;

   if P = nil then
      _cont := C.Continent
   else if P.OvrContinent = '' then
      _cont := C.Continent
   else
      _cont := P.OvrContinent;

   if (dmZLogGlobal.MyITUZone = str) or (HQ = True) then
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
   Grid.TopRow := 0;
   PostMessage(Handle, WM_ZLOG_UPDATELABEL, 0, 0);
end;

procedure TIARUMulti.GoButtonClick(Sender: TObject);
var
   i: Integer;
   temp: string;
begin
   temp := Edit1.Text;
   for i := 0 to ZoneList.FList.Count - 1 do begin
      if pos(temp, TIARUZone(ZoneList.FList[i]).Multi) = 1 then begin
         Grid.TopRow := i;
         break;
      end;
   end;
end;

procedure TIARUMulti.RefreshGrid;
begin
   UpdateData;
end;

procedure TIARUMulti.Add(var aQSO: TQSO);
begin
   AddNoUpdate(aQSO);

   RefreshGrid;

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
