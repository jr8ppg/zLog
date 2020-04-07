unit UJIDX_DX_Multi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicMulti, StdCtrls, checklst, ComCtrls, ExtCtrls,
  UzLogConst, UzLogGlobal, UzLogQSO, JLLabel;

type
  TJIDX_DX_Multi = class(TBasicMulti)
    TabControl: TTabControl;
    CheckListBox: TCheckListBox;
    Panel1: TPanel;
    ListBox: TListBox;
    RotateLabel1: TRotateLabel;
    RotateLabel2: TRotateLabel;
    RotateLabel3: TRotateLabel;
    RotateLabel4: TRotateLabel;
    RotateLabel5: TRotateLabel;
    RotateLabel6: TRotateLabel;
    procedure TabControlChange(Sender: TObject);
    procedure CheckListBoxClickCheck(Sender: TObject);
  private
    MultiTable : array[b19..b28, 1..50] of boolean;
    procedure HideLabels; {Hides band labels on the panel}
    procedure ShowLabels;
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateData; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    procedure Add(var aQSO : TQSO); override;
    procedure Reset; override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
    procedure CheckMulti(aQSO : TQSO); override;

    procedure UpdateListBox;
    procedure UpdateCheckListBox;
  end;

const KenNames : array[1..50] of string =
('01 Hokkaido','02 Aomori','03 Iwate','04 Akita','05 Yamagata','06 Miyagi',
 '07 Fukushima','08 Niigata','09 Nagano','10 Tokyo','11 Kanagawa',
 '12 Chiba','13 Saitama','14 Ibaraki','15 Tochigi','16 Gumma','17 Yamanashi',
 '18 Shizuoka','19 Gifu','20 Aichi','21 Mie','22 Kyoto','23 Shiga','24 Nara',
 '25 Osaka','26 Wakayama','27 Hyogo','28 Toyama','29 Fukui','30 Ishikawa',
 '31 Okayama','32 Shimane','33 Yamaguchi','34 Tottori','35 Hiroshima',
 '36 Kagawa','37 Tokushima','38 Ehime','39 Kochi','40 Fukuoka','41 Saga',
 '42 Nagasaki','43 Kumamoto','44 Oita','45 Miyazaki','46 Kagoshima',
 '47 Okinawa','48 Ogasawara','49 Okinotorishima','50 Minamitorishima');


var
  JIDX_DX_Multi: TJIDX_DX_Multi;

implementation

uses Main;

{$R *.DFM}



procedure TJIDX_DX_Multi.HideLabels;
begin
  RotateLabel1.Visible := False;
  RotateLabel2.Visible := False;
  RotateLabel3.Visible := False;
  RotateLabel4.Visible := False;
  RotateLabel5.Visible := False;
  RotateLabel6.Visible := False;
end;

procedure TJIDX_DX_Multi.ShowLabels;
begin
  RotateLabel1.Visible := True;
  RotateLabel2.Visible := True;
  RotateLabel3.Visible := True;
  RotateLabel4.Visible := True;
  RotateLabel5.Visible := True;
  RotateLabel6.Visible := True;
end;

procedure TJIDX_DX_Multi.UpdateCheckListBox;
var
  i : integer;
  B : TBand;
begin
  i := TabControl.TabIndex;
  if i > 5 then exit;

  case i of
    0..2 : B := TBand(i);
    3 : B := b14;
    4 : B := b21;
    5 : B := b28;
    else begin
       Exit;
    end;
  end;

  for i := 1 to 50 do begin
    CheckListBox.Checked[i-1] := MultiTable[B, i];
  end;
end;

procedure TJIDX_DX_Multi.UpdateListBox;
var i : integer;
    B : TBand;
    temp, str : string;
begin
  for i := 1 to 50 do
    begin
      temp := '';
      for B := b19 to b28 do
        begin
          if NotWARC(B) then
            if MultiTable[B, i] then
              temp := temp + '* '
            else
              temp := temp + '. ';
          str := copy(ListBox.Items[i-1], 1, 19);
          FillRight(str, 19);
          ListBox.Items.Delete(i-1);
          ListBox.Items.Insert(i-1, str + ' ' + temp);
       end;
    end;
end;

procedure TJIDX_DX_Multi.UpdateData;
begin
  inherited;
  if TabControl.TabIndex <> 6 then
    begin
      TabControl.TabIndex := OldBandOrd(Main.CurrentQSO.Band);
      UpdateCheckListBox;
    end;
end;

procedure TJIDX_DX_Multi.AddNoUpdate(var aQSO : TQSO);
var str, temp : string;
    M : Integer;
    B : TBand;
begin
  aQSO.NewMulti1 := False;
  str := aQSO.NrRcvd;
  aQSO.Multi1 := str;

  if aQSO.Dupe then
    exit;
  
  if not(NotWARC(aQSO.Band)) then
    exit;

  M := StrToIntDef(str, 0);

  if not (M in [1..50]) then
    exit;

  if MultiTable[aQSO.band, M] = False then
    begin
      MultiTable[aQSO.band, M] := True;
      aQSO.NewMulti1 := True;
      temp := '';
      for B := b19 to b28 do
        begin
          if NotWARC(B) then
            if MultiTable[B, M] then
              temp := temp + '* '
            else
              temp := temp + '. ';
          str := copy(ListBox.Items[M-1], 1, 19);
          FillRight(str, 19);
          ListBox.Items.Delete(M-1);
          ListBox.Items.Insert(M-1, str + ' ' + temp);
       end;
       if OldBandOrd(aQSO.Band) = TabControl.TabIndex then
         CheckListBox.Checked[M-1] := True;
      //Update;
    end;
end;

procedure TJIDX_DX_Multi.Add(var aQSO : TQSO);
begin
  inherited;
end;

procedure TJIDX_DX_Multi.Reset;
var B : TBand;
    i : integer;
begin
  for B := b19 to b28 do
    for i := 1 to 50 do
      MultiTable[B, i] := False;
  UpdateListBox;
  UpdateCheckListBox;
end;

function TJIDX_DX_Multi.ValidMulti(aQSO : TQSO) : boolean;
var str : string;
    M : integer;
begin
  Result := False;
  str := aQSO.NrRcvd;
  if not(NotWARC(aQSO.Band)) then
    exit;

  M := StrToIntDef(str, 0);

  if (M in [1..50]) then
    Result := True;
end;


procedure TJIDX_DX_Multi.TabControlChange(Sender: TObject);
begin
  inherited;
  //TabControl.TabIndex := OldBandOrd(Main.CurrentQSO.QSO.Band);
  if TabControl.TabIndex = 6 then
    begin
      if ListBox.Visible = False then
        begin
          ShowLabels;
          CheckListBox.Align := alNone;
          CheckListBox.Visible := False;
          ListBox.Align := alClient;
          ListBox.Visible := True;
        end;
    end
  else
    begin
      if CheckListBox.Visible = False then
        begin
          HideLabels;
          ListBox.Align := alNone;
          ListBox.Visible := False;
          CheckListBox.Align := alClient;
          CheckListBox.Visible := True;
          UpdateCheckListBox;
        end
      else
        begin
          UpdateCheckListBox;
        end;
    end;
end;

procedure TJIDX_DX_Multi.CheckListBoxClickCheck(Sender: TObject);
begin
  inherited;
  UpdateCheckListBox;
end;


procedure TJIDX_DX_Multi.CheckMulti(aQSO : TQSO);
var str : string;
    M : integer;
    B : TBand;
begin
  str := aQSO.NrRcvd;

  M := StrToIntDef(str, 0);

  if not(M in [1..50]) then
    begin
      MainForm.WriteStatusLine('Invalid number', false);
      exit;
    end;

  str := KenNames[M];
  if MultiTable[aQSO.band,M] = True then
    str := str + '   Worked on this band. Worked on : '
  else
    str := str + '   Needed on this band. Worked on : ';

  for B := b19 to b28 do
    if MultiTable[B, M] then
      str := str + MHzString[B]+' '
    else
      str := str + '';
  MainForm.WriteStatusLine(str, false);

end;


end.
