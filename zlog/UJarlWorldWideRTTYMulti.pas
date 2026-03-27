unit UJarlWorldWideRTTYMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicMulti, StdCtrls, JLLabel, ExtCtrls, Grids, StrUtils,
  UzLogConst, UzLogGlobal, UzLogQSO, USpotClass, UComm, UMultipliers;

const
  WM_ZLOG_UPDATELABEL = (WM_USER + 100);

type
  TJarlWorldWideRTTYMulti = class(TBasicMulti)
    Panel: TPanel;
    Panel1: TPanel;
    buttonGo: TButton;
    Edit1: TEdit;
    RotateLabel2: TRotateLabel;
    RotateLabel3: TRotateLabel;
    RotateLabel4: TRotateLabel;
    RotateLabel5: TRotateLabel;
    RotateLabel6: TRotateLabel;
    StayOnTop: TCheckBox;
    Grid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GridTopLeftChanged(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure GoButtonClick(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FCountryList: TCountryList;
    procedure GoForwardMatch(strCode: string);
  protected
    FMostRecentCty: TCountry;
    FLastCountry: TCountry;
    FGridReverse: array[0..500] of integer; {pointer from grid row to countrylist index}
    procedure SetFontSize(v: Integer); override;
    procedure OnZLogUpdateLabel( var Message: TMessage ); message WM_ZLOG_UPDATELABEL;
    procedure UpdateLabelPos(); virtual;
  public
    { Public declarations }
    procedure Reset; override;
    procedure AddNoUpdate(aQSO: TQSO); override;
    procedure Add(aQSO: TQSO); override; // only calls addnoupdate but no update
    procedure UpdateData; override;
    function ValidMulti(aQSO: TQSO): boolean; override;
    function GuessZone(strCallsign: string): string; override;
    function GetInfo(aQSO: TQSO): string; override;
    procedure ProcessCluster(Sp: TBaseSpot); override;
    procedure SortDefault(); virtual;
    procedure CheckMulti(aQSO: TQSO); override;
    procedure RefreshGrid; virtual;
    procedure ProcessSpotData(S: TBaseSpot); override;
    procedure BeginUpdate(); override;
    procedure EndUpdate(); override;

    property LastCountry: TCountry read FLastCountry;
  end;

function IsJAWVEVK(cty: string): Boolean;
function GetCallArea(aQSO: TQSO; cty: string): string;

implementation

uses
  Main;

{$R *.DFM}

procedure TJarlWorldWideRTTYMulti.FormCreate(Sender: TObject);
var
   i: Integer;
   cty: TCountry;
begin
   Inherited;
   FMostRecentCty := nil;
   FLastCountry := nil;
   FCountryList := TCountryList.Create();

   for i := 0 to dmZLogGlobal.CountryList.Count - 1 do begin
      cty := TCountry.Create();
      cty.Assign(dmZLogGlobal.CountryList[i]);

      if cty.Country = 'K' then begin
         FCountryList.Add(TCountry.Create('United States(Area 0):04:07:NA:::0:K0:K0'));
         FCountryList.Add(TCountry.Create('United States(Area 1):05:08:NA:::0:K1:K1'));
         FCountryList.Add(TCountry.Create('United States(Area 2):05:08:NA:::0:K2:K2'));
         FCountryList.Add(TCountry.Create('United States(Area 3):05:08:NA:::0:K3:K3'));
         FCountryList.Add(TCountry.Create('United States(Area 4):05:08:NA:::0:K4:K4'));
         FCountryList.Add(TCountry.Create('United States(Area 5):04:07:NA:::0:K5:K5'));
         FCountryList.Add(TCountry.Create('United States(Area 6):03:06:NA:::0:K6:K6'));
         FCountryList.Add(TCountry.Create('United States(Area 7):03:06:NA:::0:K7:K7'));
         FCountryList.Add(TCountry.Create('United States(Area 8):04:06:NA:::0:K8:K8'));
         FCountryList.Add(TCountry.Create('United States(Area 9):04:06:NA:::0:K9:K9'));
         cty.Free();
      end
      else if cty.Country = 'JA' then begin
         FCountryList.Add(TCountry.Create('Japan(Area 0):25:45:AS:::9:JA0:JA0'));
         FCountryList.Add(TCountry.Create('Japan(Area 1):25:45:AS:::9:JA1:JA1'));
         FCountryList.Add(TCountry.Create('Japan(Area 2):25:45:AS:::9:JA2:JA2'));
         FCountryList.Add(TCountry.Create('Japan(Area 3):25:45:AS:::9:JA3:JA3'));
         FCountryList.Add(TCountry.Create('Japan(Area 4):25:45:AS:::9:JA4:JA4'));
         FCountryList.Add(TCountry.Create('Japan(Area 5):25:45:AS:::9:JA5:JA5'));
         FCountryList.Add(TCountry.Create('Japan(Area 6):25:45:AS:::9:JA6:JA6'));
         FCountryList.Add(TCountry.Create('Japan(Area 7):25:45:AS:::9:JA7:JA7'));
         FCountryList.Add(TCountry.Create('Japan(Area 8):25:45:AS:::9:JA8:JA8'));
         FCountryList.Add(TCountry.Create('Japan(Area 9):25:45:AS:::9:JA9:JA9'));
         cty.Free();
      end
      else if cty.Country = 'VE' then begin
         FCountryList.Add(TCountry.Create('Canada (Area 0):05:09:NA:::0:VE0:VE0'));
         FCountryList.Add(TCountry.Create('Canada (Area 1):05:09:NA:::0:VE1:VE1'));
         FCountryList.Add(TCountry.Create('Canada (Area 2):05:04:NA:::0:VE2:VE2'));
         FCountryList.Add(TCountry.Create('Canada (Area 3):04:04:NA:::0:VE3:VE3'));
         FCountryList.Add(TCountry.Create('Canada (Area 4):04:03:NA:::0:VE4:VE4'));
         FCountryList.Add(TCountry.Create('Canada (Area 5):04:03:NA:::0:VE5:VE5'));
         FCountryList.Add(TCountry.Create('Canada (Area 6):04:02:NA:::0:VE6:VE6'));
         FCountryList.Add(TCountry.Create('Canada (Area 7):03:02:NA:::0:VE7:VE7'));
         FCountryList.Add(TCountry.Create('Canada (Area 8):01:03:NA:::0:VE8:VE8'));
         FCountryList.Add(TCountry.Create('Canada (Area 9):05:09:NA:::0:VE9:VE9'));
         cty.Free();
      end
      else if cty.Country = 'VK' then begin
         FCountryList.Add(TCountry.Create('Australia (Area 1):30:59:OC:::0:VK1:VK1'));
         FCountryList.Add(TCountry.Create('Australia (Area 2):30:59:OC:::0:VK2:VK2'));
         FCountryList.Add(TCountry.Create('Australia (Area 3):30:59:OC:::0:VK3:VK3'));
         FCountryList.Add(TCountry.Create('Australia (Area 4):30:55:OC:::0:VK4:VK4'));
         FCountryList.Add(TCountry.Create('Australia (Area 5):30:59:OC:::0:VK5:VK5'));
         FCountryList.Add(TCountry.Create('Australia (Area 6):29:58:OC:::0:VK6:VK6'));
         FCountryList.Add(TCountry.Create('Australia (Area 7):30:59:OC:::0:VK7:VK7'));
         FCountryList.Add(TCountry.Create('Australia (Area 8):29:55:OC:::0:VK8:VK8'));
         cty.Free();
      end
      else begin
         FCountryList.Add(cty);
      end;
   end;

   Reset();
end;

procedure TJarlWorldWideRTTYMulti.FormShow(Sender: TObject);
begin
   Inherited;
   AdjustGridSize(Grid);
   UpdateData();
   PostMessage(Handle, WM_ZLOG_UPDATELABEL, 0, 0);
end;

procedure TJarlWorldWideRTTYMulti.FormResize(Sender: TObject);
begin
   Inherited;
   AdjustGridSize(Grid);
   RefreshGrid;
end;

procedure TJarlWorldWideRTTYMulti.FormDestroy(Sender: TObject);
begin
   inherited;
   FCountryList.Free();
end;

procedure TJarlWorldWideRTTYMulti.GridTopLeftChanged(Sender: TObject);
begin
   RefreshGrid;
end;

procedure TJarlWorldWideRTTYMulti.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(Grid, ACol, ARow, Rect);
end;

procedure TJarlWorldWideRTTYMulti.Add(aQSO: TQSO);
begin
   AddNoUpdate(aQSO);

   if (aQSO.Reserve2 <> $AA) and (FMostRecentCty <> nil) then begin
      Grid.TopRow := FMostRecentCty.GridIndex;
   end;

   RefreshGrid;

   AddSpot(aQSO);
end;

procedure TJarlWorldWideRTTYMulti.UpdateData;
begin
   RefreshGrid;
   RenewCluster;
   RenewBandScope;
end;

procedure TJarlWorldWideRTTYMulti.SortDefault();
var
   i: integer;
begin
   if FCountryList.Count = 0 then begin
      Exit;
   end;

   for i := 0 to FCountryList.Count - 1 do begin
      TCountry(FCountryList.List[i]).GridIndex := i;
      FGridReverse[i] := i;
   end;
end;

procedure TJarlWorldWideRTTYMulti.Reset;
begin
   FCountryList.Reset();

   SortDefault();

   Grid.RowCount := FCountryList.Count;
end;

procedure TJarlWorldWideRTTYMulti.RefreshGrid;
var
   i , k: integer;
   C: TCountry;
   B: TBand;
begin
   B := Main.CurrentQSO.Band;
   if B = bUnknown then begin
      Exit;
   end;

   BeginUpdate();

   for i := Grid.TopRow to Grid.TopRow + Grid.VisibleRowCount - 1 do begin
      if (i > Grid.RowCount - 1) then begin
         exit;
      end
      else begin
         k := FGridReverse[i];
         C := FCountryList[k];
         if (k >= 0) and (k < FCountryList.Count) then begin
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

   EndUpdate();

   Grid.Refresh();
end;

procedure TJarlWorldWideRTTYMulti.AddNoUpdate(aQSO: TQSO);
var
   strCallArea: string;
   C: TCountry;
   C2: TCountry;
   P: TPrefix;
   B: TBand;
   i: Integer;
begin
   aQSO.NewMulti1 := False;
   aQSO.NewMulti2 := False;
   aQSO.Multi1 := '';
   aQSO.Multi2 := '';
   aQSO.Points := 0;

   if aQSO.Dupe then begin
      Exit;
   end;

   // RTTY以外は除く
   if aQSO.Mode <> mRTTY then begin
      Exit;
   end;

   //・JA/W/VE/VK の本土を除く各バンドで交信した局のエンティティ数
   P := dmZLogGlobal.GetPrefix(aQSO.Callsign);
   if P = nil then begin
      aQSO.Points := 0;
      Exit;
   end;

   C := P.Country;
   C2 := nil;

   // JA/W/VE/VKはエンティティマルチなし
   if IsJAWVEVK(C.Country) = True then begin
      //・各バンドで交信したJA/W/VE/VK の本土内局のコールエリア数
      strCallArea := GetCallArea(aQSO, C.Country);

      for i := 0 to FCountryList.Count - 1 do begin
         if FCountryList[i].Country = strCallArea then begin
            C2 := FCountryList[i];
            aQSO.Multi1 := strCallArea;
            Break;
         end;
      end;
   end
   else begin  // JA/W/VE/VK以外
      for i := 0 to FCountryList.Count - 1 do begin
         if FCountryList[i].Country = P.Country.Country then begin
            C2 := FCountryList[i];
            aQSO.Multi1 := C.Country;
            Break;
         end;
      end;
   end;

   if C2 <> nil then begin
      B := aQSO.Band;
      if C2.Worked[B] = False then begin
         C2.Worked[B] := True;
         aQSO.NewMulti1 := True;
      end;
   end;

   // Continentチェック
   if P.OvrContinent = '' then begin
      aQSO.Continent := C.Continent;
   end
   else begin
      aQSO.Continent := P.OvrContinent;
   end;

   aQSO.Entity := C.Country;

   if dmZLogGlobal.MyContinent <> aQSO.Continent then begin // 異なる大陸
      aQSO.Points := 3;
   end
   else begin  // 同一大陸
      aQSO.Points := 2;
   end;

   // (3)公海上のMM(Maritime Mobile）局
   // MM 局との交信は、運用場所によらず得点を2 点とし、マルチにはカウントしない。
   if Pos('/MM', aQSO.Callsign) > 0 then begin
      aQSO.Points := 2;
      aQSO.NewMulti1 := False;
      aQSO.NewMulti2 := False;
   end;
end;

// NRは年齢なので特にチェックしない
function TJarlWorldWideRTTYMulti.ValidMulti(aQSO: TQSO): boolean;
begin
   Result := True;
end;

function TJarlWorldWideRTTYMulti.GuessZone(strCallsign: string): string;
begin
   Result := dmZLogGlobal.GuessCQZone(strCallsign);
end;

function TJarlWorldWideRTTYMulti.GetInfo(aQSO: TQSO): string;
var
   temp, temp2: string;
   B: TBand;
   C: TCountry;
begin
   C := dmZLogGlobal.GetPrefix(aQSO.Callsign).Country;
   if C.CountryName = 'Unknown' then begin
      Result := 'Unknown CTY';
      FLastCountry := nil;
      Exit;
   end;

   GoForwardMatch(C.Country);

   temp := '';
   temp := C.Country + ' ' + C.Continent + ' ';

   temp2 := '';
   if C.Worked[aQSO.Band] = False then
      temp2 := 'CTY';

   if temp2 <> '' then
      temp2 := 'NEW ' + temp2;

   temp := temp + temp2 + ' ';

   temp := temp + 'needed on: ';
   for B := b19 to b28 do
      if NotWARC(B) then
         if C.Worked[B] = False then
            temp := temp + MHzString[B] + ' ';

   FLastCountry := C;
   Result := temp;
end;


procedure TJarlWorldWideRTTYMulti.GoButtonClick(Sender: TObject);
begin
   GoForwardMatch(Edit1.Text);
end;

procedure TJarlWorldWideRTTYMulti.GoForwardMatch(strCode: string);
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
   for i := 0 to FCountryList.Count - 1 do begin
      if (strCode = Copy(TCountry(FCountryList.List[i]).Country, 1, l)) then begin
         Grid.TopRow := GetRowIndex(i);
         Break;
      end;
   end;
end;

procedure TJarlWorldWideRTTYMulti.Edit1Change(Sender: TObject);
begin
   GoForwardMatch(Edit1.Text);
end;

procedure TJarlWorldWideRTTYMulti.Edit1Enter(Sender: TObject);
begin
   buttonGo.Default := True;
end;

procedure TJarlWorldWideRTTYMulti.Edit1Exit(Sender: TObject);
begin
   buttonGo.Default := False;
end;

procedure TJarlWorldWideRTTYMulti.ProcessCluster(Sp: TBaseSpot);
var
   Z: integer;
   C: TCountry;
   temp: string;
   aQSO: TQSO;
   i: Integer;
   callarea: string;
   fFound: Boolean;
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

      if IsJAWVEVK(C.Country) = True then begin
         callarea := GetCallArea(aQSO, C.Country);

         fFound := False;
         for i := 0 to FCountryList.Count - 1 do begin
            if callarea = FCountryList[i].Country then begin
               fFound := True;
               C := FCountryList[i];
               Break;
            end;
         end;

         if (fFound = True) and (C.Worked[aQSO.Band] = False) then begin
            temp := temp + '  new callarea: ' + callarea;
            Sp.NewCty := True;
         end;
      end
      else begin
         fFound := False;
         for i := 0 to FCountryList.Count - 1 do begin
            if FCountryList[i].Country = C.Country then begin
               fFound := True;
               C := FCountryList[i];
               Break;
            end;
         end;

         if (fFound = True) and (C.Worked[aQSO.Band] = False) then begin
            temp := temp + '  new country: ' + (C.Country);
            Sp.NewCty := True;
         end;
      end;

      if Sp.IsNewMulti = True then begin
         temp := temp + ' at ' + MHzString[aQSO.Band] + 'MHz';
         MainForm.WriteStatusLineRed(temp, True);
      end;
   finally
      aQSO.Free;
   end;
end;

procedure TJarlWorldWideRTTYMulti.CheckMulti(aQSO: TQSO);
var
   str: string;
   i: integer;
   B: TBand;
begin
   str := aQSO.NrRcvd;
   i := StrToIntDef(str, 0);

end;

procedure TJarlWorldWideRTTYMulti.StayOnTopClick(Sender: TObject);
begin
   if StayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
end;

procedure TJarlWorldWideRTTYMulti.ProcessSpotData(S: TBaseSpot);
begin
   ProcessCluster(S);
end;

procedure TJarlWorldWideRTTYMulti.BeginUpdate();
begin
   Grid.BeginUpdate();
end;

procedure TJarlWorldWideRTTYMulti.EndUpdate();
begin
   Grid.EndUpdate();
end;

procedure TJarlWorldWideRTTYMulti.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateLabelPos();
   UpdateData();
end;

procedure TJarlWorldWideRTTYMulti.UpdateLabelPos();
var
   w, l: Integer;
begin
   w := Grid.Canvas.TextWidth('X');
   l := (w * 42) - 2;
   RotateLabel2.Left := l;
   RotateLabel3.Left := RotateLabel2.Left + (w * 2);
   RotateLabel4.Left := RotateLabel3.Left + (w * 2);
   RotateLabel5.Left := RotateLabel4.Left + (w * 2);
   RotateLabel6.Left := RotateLabel5.Left + (w * 2);
end;

procedure TJarlWorldWideRTTYMulti.OnZLogUpdateLabel( var Message: TMessage );
begin
   Application.ProcessMessages();
   UpdateLabelPos();
end;

{
(2)各バンドで交信したJA/W/VE/VK の本土内局のコールエリア
JA/W/VE/VK の本土内局のコールエリアはプリフィックスの最後の数字とする。ただし、
ポータブル表示がある場合は、ポータブル表示のエリア（ポータブル表示に数字を含ま
ない場合は0 エリア）とする。
（例） JA1、7K1 はJA1 としてカウント
JR4、7K4 はJA4 としてカウント
8J20 はJA0 としてカウント
JA1RL/3 はJA3 としてカウント
VK/JA1YRL はVK0 としてカウント
}
function GetCallArea(aQSO: TQSO; cty: string): string;
var
   str, temp: string;
   i: Integer;
   strCallArea: string;
   area: string;

   function GetCallAreaSub(str: string): string;
   var
      fNumber: Boolean;
      area: string;
      ch: Char;
      i: Integer;
   begin
      fNumber := False;
      area := '';
      for i := 1 to Length(str) do begin
         ch := str[i];
         if (fNumber = False) and (CharInSet(ch, ['0'..'9']) = True) then begin
            area := str[i];
            fNumber := True;
         end;
         if (fNumber = True) and (CharInSet(ch, ['0'..'9']) = False) then begin
            // この時点のi-1までがコールエリア
            area := str[i - 1];
            fNumber := False;
            Break;
         end;
      end;

      // 無いときは0とする
      if area = '' then begin
         area := '0';
      end;

      Result := area;
   end;
begin
   str := aQSO.CallSign;

   // JA/W/VE/VK以外はコールエリア無し
   if IsJAWVEVK(cty) = False then begin
      Result := '';
      Exit;
   end;

   // コール先頭から数字が現れて、英字に変わる直前の数字をコールエリアとする
   area := GetCallAreaSub(str);

   // コールエリアは代表プリフィックス＋上記で発見したエリア番号とする
   strCallArea := cty + area;

   // ポータブルチェック
   i := pos('/', str);

   // ポータブルでは無い
   if i = 0 then begin
      Result := strCallArea;
      Exit;
   end;

   // ポータブルだった
   temp := Copy(str, i + 1);

   // 特殊ポータブル
   if (temp = 'AA') or (temp = 'AT') or (temp = 'AG') or (temp = 'AE') or (temp = 'M') or (temp = 'P') or (temp = 'AM') or
      (temp = 'QRP') or (temp = 'A') or (temp = 'KT') or (temp = 'MM') then begin
      Result := '';
      Exit;
   end;

   // 数字一文字の場合
   if (Length(temp) = 1) and CharInSet(temp[1], ['0'..'9']) then begin
      strCallArea := cty + temp;
   end
   else begin
      if i > 4 then begin { JA1ZLO/JD1, KH0AM/W6 etc NOT KH0/AD6AJ }
         area := GetCallAreaSub(temp);
         strCallArea := cty + area;
      end
      else begin { KH0/AD6AJ }
         temp := copy(str, 1, i - 1);
         area := GetCallAreaSub(temp);
         strCallArea := cty + area;
      end;
   end;

   Result := strCallArea;
end;

function IsJAWVEVK(cty: string): Boolean;
begin
   if (cty = 'JA') or (cty = 'K') or (cty = 'VE') or (cty = 'VK') then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

end.
