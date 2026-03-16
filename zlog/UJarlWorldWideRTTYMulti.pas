unit UJarlWorldWideRTTYMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UWWMulti, UMultipliers, StdCtrls, JLLabel, ExtCtrls, Grids,
  UComm, USpotClass, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TJarlWorldWideRTTYMulti = class(TWWMulti)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GoButtonClick(Sender: TObject);
  private
    { Private declarations }
    FMulti2List: TStringList;
  public
    { Public declarations }
    procedure RefreshGrid; override;
    function TotalPrefix: integer;
    procedure Reset; override;
    procedure AddNoUpdate(aQSO: TQSO); override;
    function ValidMulti(aQSO: TQSO): boolean; override;
    procedure ProcessCluster(Sp: TBaseSpot); override;
    procedure UpdateData; override;
  end;

function IsJAWVEVK(cty: string): Boolean;
function GetCallArea(aQSO: TQSO; cty: string): string;

implementation

uses UOptions, Main;

{$R *.DFM}

procedure TJarlWorldWideRTTYMulti.FormCreate(Sender: TObject);
begin
   { inherited; }
   FMulti2List := TStringList.Create();
   FMulti2List.Sorted := True;
   Reset;
end;

procedure TJarlWorldWideRTTYMulti.FormDestroy(Sender: TObject);
begin
   inherited;
   FMulti2List.Free();
end;

procedure TJarlWorldWideRTTYMulti.GoButtonClick(Sender: TObject);
var
   temp: string;
   i: Integer;
begin
   temp := Edit1.Text;
   for i := 0 to FMulti2List.Count - 1 do begin
      if pos(temp, FMulti2List[i]) = 1 then begin
         Grid.TopRow := i;
         break;
      end;
   end;
end;

procedure TJarlWorldWideRTTYMulti.RefreshGrid;
var
   i: Integer;
begin
   Grid.RowCount := FMulti2List.Count;
   for i := Grid.TopRow to Grid.TopRow + Grid.VisibleRowCount - 1 do begin
      if (i > Grid.RowCount - 1) then begin
         exit;
      end
      else begin
         if (i >= 0) and (i < FMulti2List.Count) then begin
            Grid.Cells[0, i] := FMulti2List[i];
         end
         else
            Grid.Cells[0, i] := '';
      end;
   end;

   Grid.Refresh();
end;

function TJarlWorldWideRTTYMulti.TotalPrefix: Integer;
begin
   Result := FMulti2List.Count;
end;

procedure TJarlWorldWideRTTYMulti.Reset;
var
   i: Integer;
   B: TBand;
begin
   FMulti2List.Clear;

   for i := 0 to dmZLogGlobal.CountryList.Count - 1 do begin
      for B := b19 to HiBand do begin
         TCountry(dmZLogGlobal.CountryList.List[i]).Worked[B] := False;
      end;
   end;
end;

procedure TJarlWorldWideRTTYMulti.UpdateData;
begin
   RefreshGrid;
end;

procedure TJarlWorldWideRTTYMulti.AddNoUpdate(aQSO: TQSO);
var
   strCallArea: string;
   C: TCountry;
   P: TPrefix;
   B: TBand;
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

   // JA/W/VE/VKはエンティティマルチなし
   if IsJAWVEVK(C.Country) = True then begin
      aQSO.Multi1 := '';
      aQSO.NewMulti1 := False;
   end
   else begin
      aQSO.Multi1 := C.Country;
      B := aQSO.Band;
      if C.Worked[B] = False then begin
         C.Worked[B] := True;
         aQSO.NewMulti1 := True;
      end;
   end;

   //・各バンドで交信したJA/W/VE/VK の本土内局のコールエリア数
   strCallArea := GetCallArea(aQSO, C.Country);
   aQSO.Multi2 := strCallArea;

   // コールエリアリストに無ければ追加してNewMultiとする
   if strCallArea <> '' then begin
      if FMulti2List.IndexOf(strCallArea) = -1 then begin
         FMulti2List.Add(strCallArea);
         aQSO.NewMulti2 := True;
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

function TJarlWorldWideRTTYMulti.ValidMulti(aQSO: TQSO): Boolean;
var
   str: string;
   i: Integer;
begin
   str := aQSO.NrRcvd;
   i := StrToIntDef(str, -1);
   if i >= 0 then
      Result := True
   else
      Result := False;
end;

procedure TJarlWorldWideRTTYMulti.ProcessCluster(Sp: TBaseSpot);
var
   i: Integer;
   temp, px: string;
   boo: Boolean;
   aQSO: TQSO;
   C: TCountry;
begin
   aQSO := TQSO.Create;
   aQSO.CallSign := Sp.Call;
   aQSO.Band := Sp.Band;

   Sp.NewCty := False;
   Sp.NewZone := False;

   temp := aQSO.CallSign;

   // Countryを求める
   C := dmZLogGlobal.GetPrefix(aQSO.Callsign).Country;
   Sp.CtyIndex := C.Index;

   px := GetCallArea(aQSO, C.Country);

   boo := False;
   for i := 0 to FMulti2List.Count - 1 do
      if px = FMulti2List[i] then
         boo := True;

   if boo = False then begin
      temp := temp + '  new callarea: ' + px;
      Sp.NewCty := True;
   end;

   if Sp.IsNewMulti = True then begin
      temp := temp + ' at ' + MHzString[aQSO.Band] + 'MHz';
      MainForm.WriteStatusLineRed(temp, True);
      // CommForm.Show;
   end;

   aQSO.Free;
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
