unit UJA0Multi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicMulti, StdCtrls, ExtCtrls, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TJA0Multi = class(TBasicMulti)
    Panel1: TPanel;
    Button1: TButton;
    ListBox: TListBox;
    StayOnTop: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    JA0 : boolean;
    //PXList : TStringList;
    PXListX : array[b35..b28] of TStringList;
    // function TotalPrefix : integer;
    function ValidMulti(aQSO : TQSO) : boolean;
    function GetPrefix(aQSO : TQSO) : string;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    procedure Reset; override;
    procedure Update; override;
  end;

implementation

uses Main;

{$R *.DFM}

function TJA0Multi.ValidMulti(aQSO : TQSO) : boolean;
var str : string;
    B : TBand;
    i : integer;
begin
  str := aQSO.NrRcvd;
  try
    i := StrToInt(str);
  except
    on EConvertError do
      i := 0;
  end;
  if i > 0 then
    Result := True
  else
    Result := False;
end;

procedure TJA0Multi.AddNoUpdate(var aQSO : TQSO);
var str : string;
begin
  str := GetPrefix(aQSO);
  aQSO.NewMulti1 := False;
  aQSO.Multi1 := str;

  if aQSO.Dupe then
    exit;

  {if (str = '') or (PXList.IndexOf(str) >= 0) then
    exit;}
  if (str = '') or (PXListX[aQSO.Band].IndexOf(str) >= 0) then
    exit;


  //PXList.Add(str);
  PXListX[aQSO.Band].Add(str);

  aQSO.NewMulti1 := True;
end;


procedure TJA0Multi.Update;
var i, j : integer;
    band : TBand;
begin
  band := Main.CurrentQSO.Band;
  ListBox.Items.Clear;
  {if PXList.Count = 0 then
    exit;}
  if PXListX[band].Count = 0 then
    exit;

  {for i := 0 to PXList.Count - 1 do
    ListBox.Items.Add(PXList.Strings[i]);}
  for i := 0 to PXListX[band].Count - 1 do
    ListBox.Items.Add(PXListX[band].Strings[i]);
end;

procedure TJA0Multi.Reset;
var b : TBand;
begin
  ListBox.Items.Clear;
  for b := b35 to b28 do
    PXListX[b].Clear;
  //PXList.Clear;
end;


function TJA0Multi.GetPrefix(aQSO : TQSO) : string;
var c : string;
begin
  c := aQSO.Callsign;
  Result := '';
  if JA0 then
    begin
      Result := copy(c, 1, 3);
    end
  else
    begin
      if Pos('0', c) = 0 then
        exit;
      if length(c) >= 6 then
        begin
          if c[6] in ['A'..'Z'] then
            Result := c[2]+'*'+c[6]
          else
            Result := c[2]+'*'+c[5];
        end
      else
        begin
          if length(c) < 5 then
            exit;
          if c[5] in ['A'..'Z'] then
            Result := c[2]+'*'+c[5]
        end;
    end;
end;

procedure TJA0Multi.Button1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TJA0Multi.FormCreate(Sender: TObject);
var b : TBand;
begin
  inherited;
  //PXList := TStringList.Create;
  //PXList.Sorted := True;
  for b := b35 to b28 do
    begin
      PXListX[b] := TStringList.Create;
      PXListX[b].Sorted := True;
    end;
end;


procedure TJA0Multi.StayOnTopClick(Sender: TObject);
begin
  if StayOnTop.Checked then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
end;

end.
