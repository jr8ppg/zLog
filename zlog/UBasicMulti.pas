unit UBasicMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UzLogGlobal, UzLogQSO, Menus, UComm, USpotClass;

type
  TBasicMulti = class(TForm)
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure FormCreate(Sender: TObject);
 private
    { Private declarations }
  public
    { Public declarations }
    procedure Renew; virtual;
    procedure UpdateData; virtual;
    function ExtractMulti(aQSO : TQSO) : string; virtual;
    procedure AddNoUpdate(var aQSO : TQSO); virtual;
    procedure Add(var aQSO : TQSO); virtual; {NewMulti}
    function ValidMulti(aQSO : TQSO) : boolean; virtual;
    procedure Reset; virtual;
    procedure CheckMulti(aQSO : TQSO); virtual;
    procedure ProcessCluster(var Sp : TBaseSpot); virtual;
    function GuessZone(aQSO : TQSO) : string; virtual;
    function GetInfo(aQSO : TQSO): string; virtual;
    procedure RenewCluster; virtual;
    procedure RenewBandScope; virtual;
    procedure ProcessSpotData(var S : TBaseSpot); virtual;
    procedure AddSpot(aQSO : TQSO); virtual;
    procedure AddNewPrefix(PX : string; CtyIndex : integer); virtual;
    procedure SelectAndAddNewPrefix(Call : string); virtual; // for WWMulti and descendants
    function  IsNewMulti(aQSO : TQSO) : boolean; virtual;
    procedure SetNumberEditFocusJARL;
    procedure SetNumberEditFocus; virtual;
    // function CheckMultiInfo(aQSO : TQSO) : string; virtual; abstract;
    // called from CheckMultiWindow for each band without QSO to the current stn
    // returns nothing when the multi is worked in that band.
  end;

implementation

uses Main, uBandScope2;

{$R *.DFM}

procedure TBasicMulti.SelectAndAddNewPrefix(Call: string);
begin
end;

procedure TBasicMulti.AddNewPrefix(PX: string; CtyIndex: integer);
begin
end;

procedure TBasicMulti.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TBasicMulti.Renew;
begin
end;

procedure TBasicMulti.UpdateData;
begin
end;

procedure TBasicMulti.AddNoUpdate(var aQSO: TQSO);
begin
end;

function TBasicMulti.ExtractMulti(aQSO: TQSO): string;
begin
   Result := aQSO.NrRcvd;
end;

procedure TBasicMulti.Add(var aQSO: TQSO);
begin
   AddNoUpdate(aQSO);
   UpdateData;
   AddSpot(aQSO);
end;

function TBasicMulti.ValidMulti(aQSO: TQSO): boolean;
begin
   Result := true;
end;

procedure TBasicMulti.CheckMulti(aQSO: TQSO);
begin
end;

function TBasicMulti.IsNewMulti(aQSO: TQSO): boolean;
begin
   Result := False;
end;

procedure TBasicMulti.Reset;
begin
end;

procedure TBasicMulti.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.LastFocus.SetFocus;
   end;
end;

procedure TBasicMulti.ProcessCluster(var Sp: TBaseSpot);
begin
end;

function TBasicMulti.GuessZone(aQSO: TQSO): string;
begin
   Result := '';
end;

function TBasicMulti.GetInfo(aQSO: TQSO): string;
begin
   Result := '';
end;

procedure TBasicMulti.ProcessSpotData(var S: TBaseSpot);
var
   aQSO: TQSO;
begin
   aQSO := TQSO.Create;
   aQSO.Callsign := S.Call;
   aQSO.NrRcvd := S.Number;
   aQSO.Band := S.Band;
   aQSO.Mode := S.Mode;

   S.NewCty := False;
   S.NewZone := False;
   S.Worked := False;

   if Log.QuickDupe(aQSO) <> nil then
      // if Log.IsDupe(aQSO) > 0 then
      S.Worked := true;
   S.NewCty := IsNewMulti(aQSO);

   aQSO.Free;
end;

procedure TBasicMulti.RenewCluster;
var
   S: TSpot;
   i: integer;
begin
   for i := 0 to CommForm.SpotList.Count - 1 do begin
      S := TSpot(CommForm.SpotList[i]);
      ProcessSpotData(TBaseSpot(S));
   end;

   if CommForm.Visible then
      CommForm.Renew;
end;

procedure TBasicMulti.RenewBandScope;
var
   S: TBSData;
   i: integer;
begin
   { for i := 0 to USpotClass.BSList.Count - 1 do
     begin
     S := TBSData(USpotClass.BSList[i]);
     ProcessSpotData(TBaseSpot(S));
     end; }

   for i := 0 to USpotClass.BSList2.Count - 1 do begin
      S := TBSData(USpotClass.BSList2[i]);
      ProcessSpotData(TBaseSpot(S));
   end;

   uBandScope2.BSRefresh(Self);
end;

procedure TBasicMulti.AddSpot(aQSO: TQSO); // renews cluster & bs when adding a qso w/o renewing
var
   i: integer;
   S: TBaseSpot;
   boo: boolean;
begin
   boo := False;
   if aQSO.NewMulti1 or aQSO.NewMulti2 then begin
      RenewBandScope;
      RenewCluster;
      // exit;
   end;

   for i := 0 to USpotClass.BSList2.Count - 1 do begin
      S := TBaseSpot(USpotClass.BSList2[i]);
      if (S.Call = aQSO.Callsign) and (S.Band = aQSO.Band) then begin
         S.NewCty := False;
         S.NewZone := False;
         S.Worked := true;
         boo := true;
      end;
   end;

   { for i := 0 to USpotClass.BSList.Count - 1 do
     begin
     S := TBaseSpot(USpotClass.BSList[i]);
     if (S.Call = aQSO.QSO.callsign) and (S.band = aQSO.QSO.band) then
     begin
     S.NewCty := False;
     S.NewZone := False;
     S.Worked := True;
     boo := true;
     end;
     end; }

   if boo then begin
      uBandScope2.BSRefresh(Self);
   end;

   boo := False;
   for i := 0 to CommForm.SpotList.Count - 1 do begin
      S := TBaseSpot(CommForm.SpotList[i]);
      if (S.Call = aQSO.Callsign) and (S.Band = aQSO.Band) then begin
         S.NewCty := False;
         S.NewZone := False;
         S.Worked := true;
         boo := true;
      end;
   end;

   if boo then
      CommForm.Renew;
end;

procedure TBasicMulti.FormCreate(Sender: TObject);
begin
   MainForm.mnGridAddNewPX.Visible := False;
end;

procedure TBasicMulti.SetNumberEditFocusJARL;
var
   S: string;
begin
   MainForm.NumberEdit.SetFocus;
   S := MainForm.NumberEdit.Text;
   if S = '' then
      exit;

   if CharInSet(S[length(S)], ['A' .. 'Z']) then begin
      MainForm.NumberEdit.SelStart := length(S) - 1;
      MainForm.NumberEdit.SelLength := 1;
   end
   else begin
      MainForm.NumberEdit.SelStart := length(S);
      MainForm.NumberEdit.SelLength := 0;
   end;
end;

procedure TBasicMulti.SetNumberEditFocus;
begin
   MainForm.NumberEdit.SetFocus;
   MainForm.NumberEdit.SelectAll;
end;

end.
