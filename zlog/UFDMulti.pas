unit UFDMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UACAGMulti, StdCtrls, checklst, JLLabel, ExtCtrls, Grids,
  Cologrid, UzLogConst, UzLogGlobal, UzLogQSO, UMultipliers;

type
  TFDMulti = class(TACAGMulti)
    procedure FormCreate(Sender: TObject);
    procedure GridSetting(ARow, Acol: Integer; var Fcolor: Integer;
      var Bold, Italic, underline: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    sband : TBand; // b35 by default. b50 @ 6m&D
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
    procedure CheckMulti(aQSO : TQSO); override;
    procedure Update; override;
  end;

implementation

uses Main;

{$R *.DFM}

procedure TFDMulti.CheckMulti(aQSO : TQSO);
var str : string;
    i : integer;
    C : TCity;
begin
  //inherited;
  str := aQSO.NrRcvd;

  if str = '' then
    exit;

  if str[length(str)] in ['H', 'P', 'L', 'M'] then
    System.Delete(str, length(str), 1);

  if aQSO.Band in [b19..b1200] then
    if not(length(str) in [2..3]) then
      begin
        MainForm.WriteStatusLine('Invalid number', false);
        exit;
      end;

  if aQSO.Band in [b2400..HiBand] then
    if not(length(str) in [4..6]) then
      begin
        MainForm.WriteStatusLine('Invalid number', false);
        exit;
      end;

  for i := 0 to CityList.List.Count-1 do
    begin
      C := TCity(CityList.List[i]);
      if str = C.CityNumber then
        begin
          //ListBox.TopIndex := i;
          Grid.TopRow := i;
          str := C.Summary2;
          if C.Worked[aQSO.Band] then
            Insert('Worked on this band. ',str, 27)
          else
            Insert('Needed on this band. ',str, 27);
          MainForm.WriteStatusLine(str, false);
          exit;
        end;
    end;
  MainForm.WriteStatusLine('Invalid number', false);
end;


function TFDMulti.ValidMulti(aQSO : TQSO) : boolean;
var str : string;
    B : TBand;
    i, j : integer;
    C : TCity;
    boo : boolean;
begin
  Result := False;
  str := aQSO.NrRcvd;
  if aQSO.Band in [b19..b1200] then
    begin
      if not(length(str) in [3..4]) then
        exit;
    end
  else
    begin
      if not(length(str) in [5..7]) then
        exit;
    end;
  if not(str[length(str)] in ['P','L','M','H']) then
    exit;
  Delete(str, length(str), 1);

  boo := false;
  for i := 0 to CityList.List.Count-1 do
    begin
      C := TCity(CityList.List[i]);
      if str = C.CityNumber then
        begin
           boo := true;
           break;
        end;
    end;
  Result := boo;
end;


procedure TFDMulti.AddNoUpdate(var aQSO : TQSO);
var str, str2 : string;
    B : TBand;
    i, j : integer;
    C : TCity;
begin
  aQSO.NewMulti1 := False;
  str := aQSO.NrRcvd;
  Delete(str,length(str),1);
  aQSO.Multi1 := str;

  if aQSO.Dupe then
    exit;

  C := CityList.GetCity(str);
  if C <> nil then
    begin
      if C.Worked[aQSO.band] = False then
        begin
          C.Worked[aQSO.band] := True;
          aQSO.NewMulti1 := True;
        end;
      LatestMultiAddition := C.Index;
    end;
{
  for i := 0 to CityList.List.Count-1 do
    begin
      C := TCity(CityList.List[i]);
      if str = C.CityNumber then
        begin
          if C.Worked[aQSO.QSO.band] = False then
            begin
              C.Worked[aQSO.QSO.band] := True;
              aQSO.QSO.NewMulti1 := True;
            end;
          LatestMultiAddition := i;
          break;
        end;
    end;}
end;

procedure TFDMulti.Reset;
var i, j : integer;
    B : TBand;
    str : string;
begin
  if CityList.List.Count = 0 then exit;
  //j := ListBox.TopIndex;
  j := Grid.TopRow;
  //ListBox.Items.Clear;
  Grid.RowCount := 0;
  Grid.RowCount := CityList.List.Count;
  for i := 0 to CityList.List.Count-1 do
    begin
      for B := b19 to HiBand do
        TCity(CityList.List[i]).Worked[B] := false;
      str := TCity(CityList.List[i]).FDSummary(sband);
      Grid.Cells[0,i] := str;
      //ListBox.Items.Add(str);
      //ListBox.Checked[i] := False;
    end;
  Grid.TopRow := j;
  //ListBox.TopIndex := j;
end;


procedure TFDMulti.FormCreate(Sender: TObject);
var i : integer;
begin
  // inherited;
  sband := b35;
  CityList := TCityList.Create;
  CityList.LoadFromFile('XPO.DAT');
  CityList.LoadFromFile('ACAG.DAT');
  if CityList.List.Count = 0 then exit;
  Reset;
  {
  for i := 0 to CityList.List.Count-1 do
    begin
      ListBox.Items.Add(TCity(CityList.List[i]).FDSummary(sband));
    end;
  }
end;

procedure TFDMulti.Update;
var B : TBand;
    i : integer;
    C : TCity;
    str : string;
    _top : integer;
const kenmax = 62;
begin
  B := Main.CurrentQSO.Band;

  for i := 0 to CityList.List.Count-1 do
    begin
      C := TCity(CityList.List[i]);
      str := C.FDSummary(sband);
      Grid.Cells[0,i] := str;
    end;

  _top := LatestMultiAddition;
  if (B in [b19..b1200]) and (_top > kenmax) then
    _top := 0;
  if (B in [b2400..b10G]) and (_top <= kenmax) then
    _top := kenmax + 1;
  Grid.TopRow := _top;
end;



procedure TFDMulti.GridSetting(ARow, Acol: Integer; var Fcolor: Integer;
  var Bold, Italic, underline: Boolean);
//var B : TBand;
begin
  inherited;
  {B := Main.CurrentQSO.QSO.Band;
  if TCity(CityList.List[ARow]).Worked[B] then
    FColor := clRed
  else
    FColor := clBlack;}
end;

end.
