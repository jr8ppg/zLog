unit UBandScope2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, Menus, Cologrid,
  USpotClass, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TBandScope2 = class(TForm)
    Panel1: TPanel;
    Grid: TMgrid;
    BSMenu: TPopupMenu;
    mnDelete: TMenuItem;
    Deleteallworkedstations1: TMenuItem;
    Mode1: TMenuItem;
    mnCurrentRig: TMenuItem;
    Rig11: TMenuItem;
    Rig21: TMenuItem;
    Fixedband1: TMenuItem;
    N19MHz1: TMenuItem;
    N35MHz1: TMenuItem;
    N7MHz1: TMenuItem;
    N14MHz1: TMenuItem;
    N21MHz1: TMenuItem;
    N28MHz1: TMenuItem;
    N50MHz1: TMenuItem;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure GridSetting(ARow, Acol: Integer; var Fcolor: Integer;
      var Bold, Italic, underline: Boolean);
    procedure mnDeleteClick(Sender: TObject);
    procedure Deleteallworkedstations1Click(Sender: TObject);
    procedure ModeClick(Sender: TObject);
    procedure FixedBandClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridDblClick(Sender: TObject);
  private
    { Private êÈåæ }
    MinFreq, MaxFreq : Integer; // in Hz

//    curr : integer; // test variable
//    ClickedIndex : integer; // points to the bsdata clicked by mouse

//    currFreq : Integer;
    currBand : TBand;
    currMode : TMode;

    GridColorArray : array[0..999] of TColor;
    GridBoldArray : array[0..999] of Boolean;
    procedure AddBSList(D : TBSData);
  public
    { Public êÈåæ }
    ArrayNumber : integer;
    DisplayMode : integer; // 0 : current rig; 1 : rig 1; 2 : rig 2; 9 : fixed band
    FixedBand : TBand;
    procedure DeleteFromBSList(i : integer);
    procedure CreateBSData(aQSO : TQSO; Hz : LongInt);
    procedure AddAndDisplay(D : TBSData);
    procedure SetBandMode(B : TBand; M : TMode);
    procedure SetMinMaxFreq(min, max : LongInt);
    procedure RewriteBandScope;
    procedure MarkCurrentFreq(Hz : integer);
    procedure ProcessBSDataFromNetwork(BSText : string);
  end;

procedure BSRefresh(Sender : TObject);

const BSMax = 15;
var
  CurrentRigFrequency : Integer; // in Hertz
  BandScope2 : TBandScope2;
  BandScopeArray : array[1..BSMax] of TBandscope2;

implementation

uses UOptions, Main, UZLinkForm, URigControl;



{$R *.dfm}

procedure BSRefresh(Sender : TObject);
var i : integer;
    DispMode : integer;
    RR : TRig;
begin
  BandScope2.RewriteBandScope;
  for i := 1 to BSMax do
    if BandScopeArray[i] <> nil then
      begin
        DispMode := BandScopeArray[i].DisplayMode;
        RR := nil;
        case DispMode of
          1 : RR := RigControl.Rig1;
          2 : RR := RigControl.Rig2;
        end;
        if RR <> nil then
          BandScopeArray[i].SetBandMode(RR.CurrentBand, RR.CurrentMode)
        else
          BandScopeArray[i].RewriteBandScope;
      end;
end;

procedure TBandScope2.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TBandScope2.AddBSList(D : TBSData);
var i : integer;
    boo : boolean;
begin
  if BSList2.Count = 0 then
    begin
      BSList2.Add(D);
      exit;
    end;
  boo := false;
  for i := 0 to BSList2.Count - 1 do
    if TBSData(BSList2[i]).FreqHz > D.FreqHz then
      begin
        boo := true;
        break;
      end;
  if boo then
    BSList2.Insert(i, D)
  else
    BSList2.Add(D);
end;


procedure TBandScope2.AddAndDisplay(D : TBSData);
var i : integer;
    BS : TBSData;
    Diff : TDateTime;
label endofloop;
begin
  for i := 0 to BSList2.Count - 1 do
    begin
      BS := TBSData(BSList2[i]);
      if (BS.Call = D.Call) and (BS.Band = D.Band) then
        begin
          BS.Free;
          BSList2[i] := nil;
          goto endofloop;
        end;
      if round(BS.FreqHz / 100) = round(D.FreqHz / 100) then
        begin
          BS.Free;
          BSList2[i] := nil;
          goto endofloop;
        end;
      Diff := Now - BS.Time;
      if Diff*24*60 > 1.00 * dmZlogGlobal.Settings._bsexpire then
        begin
          BS.Free;
          BSList2[i] := nil;
        end;
      endofloop:
    end;
  BSList2.Pack;
  AddBSList(D);
  //FormPaint(Self);
  BSRefresh(Self);
end;


procedure TBandScope2.CreateBSData(aQSO : TQSO; Hz : LongInt);
var D : TBSData;
begin
  D := TBSData.Create;
  D.FreqHz := Hz;
  D.Band := aQSO.Band;
  D.Mode := aQSO.Mode;
  D.Call := aQSO.Callsign;
  D.Number := aQSO.NrRcvd;
  //D.Time := Now;
  Main.MyContest.MultiForm.ProcessSpotData(TBaseSpot(D));
  AddAndDisplay(D);
  ZLinkForm.SendBandScopeData(D.InText);
  //Send spot data to other radios!
end;

procedure TBandScope2.SetBandMode(B : TBand; M : TMode);
//var min, max : integer;
begin
  currBand := B;
  currMode := M;
  Caption := 'Band scope '+BandString[B];
  RewriteBandScope;
end;

procedure TBandScope2.SetMinMaxFreq(min, max : LongInt);
begin
  MinFreq := min;
  MaxFreq := max;
  dmZlogGlobal.Settings._bsMinFreqArray[currBand, currMode] := min div 1000;
  dmZlogGlobal.Settings._bsMaxFreqArray[currBand, currMode] := max div 1000;
end;

function GetBand(Hz : LongInt) : integer;  //Returns -1 if Hz is outside ham bands
var i : LongInt;
begin
  i := -1;
  case Hz of
    1800000..1999999 : i := 0;
    3000000..3999999 : i := 1;
    6900000..7999999 : i := 2;
    9900000..11000000 : i := 3;
   13900000..14999999 : i := 4;
   17500000..18999999 : i := 5;
   20900000..21999999 : i := 6;
   23500000..24999999 : i := 7;
   27800000..29999999 : i := 8;
   49000000..59000000 : i := 9;
  140000000..149999999 : i := 10;
  400000000..450000000 : i := 11;
 1200000000..1299999999 : i := 12;
{
 2400000000..2499999999 : i := 13;
 5600000000..5699999999 : i := 14;
10000000000..90000000000 : i := 15; }
  end;
  Result := i;
end;

procedure TBandScope2.RewriteBandScope;
var D : TBSData;
    i, j : integer;
    toprow : integer;
    str : string;
    MarkCurrent : Boolean;
    Marked : Boolean;
begin
  toprow := Grid.TopRow;
  for j := 0 to Grid.RowCount - 1 do
    Grid.Cells[0,j] := '';
  j := 0;

  if GetBand(CurrentRigFrequency) = ord(currBand) then
    MarkCurrent := True
  else
    MarkCurrent := False;
  Marked := False;

  for i := 0 to BSList2.Count - 1 do
    begin
      D := TBSData(BSList2[i]);
      if D.Band = currBand then
        begin
          if MarkCurrent and Not(Marked) then
            begin
              if D.FreqHz >= CurrentRigFrequency then
                begin
                  Grid.RowCount := j + 1;
                  Grid.Cells[0, j] := '>>'+ kHzStr(CurrentRigFrequency);
                  GridBoldArray[j] := True;
                  GridColorArray[j] := clBlack;
                  Marked := True;
                  inc(j);
                end;
            end;
          Grid.RowCount := j + 1;
          str := D.LabelStr;
          if D.NewMulti then
            GridColorArray[j] := clRed
          else
            if D.Worked then
              GridColorArray[j] := clBlack
            else
              GridColorArray[j] := clGreen;
          if D.Bold then
            GridBoldArray[j] := True
          else
            GridBoldArray[j] := False;
          if D.ClusterData then
            str := FillRight(str, 20) + '+';
          Grid.Cells[0,j] := str;

          if (Main.CurrentQSO.CQ = False) and ((D.FreqHz - CurrentRigFrequency) <= 100) then
            begin
              MainForm.AutoInput(D);
            end;

          inc(j);
        end
      else
        begin
        end;
   end;

      if MarkCurrent and Not(Marked) then
        begin
          Grid.RowCount := j + 1;
          Grid.Cells[0, j] := '>>'+ kHzStr(CurrentRigFrequency);
          GridBoldArray[j] := True;
          GridColorArray[j] := clBlack;
        end;

  if toprow <= Grid.RowCount - 1 then
    Grid.TopRow := toprow;
end;

procedure TBandScope2.GridSetting(ARow, Acol: Integer; var Fcolor: Integer;
  var Bold, Italic, underline: Boolean);
begin
  FColor := GridColorArray[ARow];
  Bold := GridBoldArray[ARow];
end;

procedure TBandScope2.DeleteFromBSList(i : integer);
begin
  if (i >= 0) and (i < BSList2.Count) then
    begin
      TBSData(BSList2[i]).Free;
      BSList2[i] := nil;
      BSList2.Pack;
    end;
end;


procedure TBandScope2.mnDeleteClick(Sender: TObject);
var i, j : integer;
    s : string;
begin
  if Grid.Selection.Top < 0 then
    exit;
  for i := Grid.Selection.Top to Grid.Selection.Bottom do
    begin
      s := Grid.Cells[0, i];
      for j := 0 to BSList2.Count - 1 do
        begin
          if pos(TBSData(BSList2[j]).LabelStr, s) = 1 then
            begin
              DeleteFromBSList(j);
              break;
            end;
        end;
    end;
  RewriteBandScope;
end;

procedure TBandScope2.MarkCurrentFreq(Hz : integer);
var i : integer;
    B : TBSData;
begin
  if (CurrentRigFrequency div 100) = (Hz div 100) then
    exit;
  CurrentRigFrequency := Hz;
  for i := 0 to BSList2.Count - 1 do
    begin
      B := TBSData(BSList2[i]);
      if abs((B.FreqHz div 100) - (Hz div 100)) <= 1 then
        B.Bold := True
      else
        B.Bold := False;
    end;
  RewriteBandScope;
end;

procedure TBandScope2.ProcessBSDataFromNetwork(BSText : string);
var D : TBSData;
begin
  D := TBSData.Create;
  D.FromText(BSText);
  Main.MyContest.MultiForm.ProcessSpotData(TBaseSpot(D));
  AddAndDisplay(D);
end;


procedure TBandScope2.Deleteallworkedstations1Click(Sender: TObject);
var D : TBSData;
    i : integer;
begin
  for i := 0 to BSList2.Count - 1 do
    begin
      D := TBSData(BSList2[i]);
      if D.Band = currBand then
        begin
          if D.Worked then
            begin
              BSList2[i] := nil;
              D.Free;
            end;
        end;
     end;
  BSList2.Pack;
  BSRefresh(Self);
end;

procedure TBandScope2.ModeClick(Sender: TObject);
begin
  DisplayMode := TMenuItem(Sender).Tag;
end;

procedure TBandScope2.FixedBandClick(Sender: TObject);
begin
  DisplayMode := 3;
  FixedBand := TBand(TMenuItem(Sender).Tag);
  SetBandMode(FixedBand, Main.CurrentQSO.Mode);
  BSRefresh(Self);
end;

procedure TBandScope2.FormCreate(Sender: TObject);
begin
  FixedBand := b19;
  ArrayNumber := 0;
  DisplayMode := 0; // current rig
end;

procedure TBandScope2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ArrayNumber > 0 then
    begin
      BandScopeArray[ArrayNumber] := nil;
      Free;
    end;
end;

procedure TBandScope2.GridDblClick(Sender: TObject);
var i, j : integer;
    F : Extended;
    str, fstr, cstr, nstr : string;
begin
  str := Grid.Cells[0, Grid.Selection.Top];
  if pos('+', str) > 0 then
    str := TrimRight(copy(str, 1, length(str)-1));

  {ver 2.2d stop scanning BSList2. just read freq from the string}

  fstr := ''; cstr := ''; nstr := '';


  i := pos('[', str);  // extract number if any
  if i > 0 then
    begin
      j := pos(']', str);
      if j > i then
        nstr := copy(str, i+1, j-i-1);
    end;

  i := pos(' ', str);  // extract frequency in kHz
  if i > 0 then
    fstr := copy(str, 1, i)
  else
    exit;

  Delete(str, 1, i);  // extract callsign
  i := pos(' ', str);
  if i > 0 then
    cstr := copy(str, 1, i - 1)
  else
    cstr := str;

  try
    F := StrToFloat(fstr);
  except
  on EConvertError do
    begin
      exit;
    end;
  end;

  MainForm.CallsignEdit.Text := cstr;
  MainForm.NumberEdit.Text := nstr;
  if RigControl.Rig<>nil then
    RigControl.Rig.SetFreq(Round(F*1000));

  Main.MyContest.MultiForm.SetNumberEditFocus;
  MainForm.UpdateBand(TBand(GetBand(Round(F*1000))));

  {  for i := 0 to BSList2.Count - 1 do
    begin
      D := TBSData(BSList2[i]);
      if D.LabelStr = str then
        begin
          MainForm.CallsignEdit.Text := D.Call;
          MainForm.NumberEdit.Text := D.Number;
          MainForm.UpdateMode(D.Mode);
          MainForm.UpdateBand(D.Band);
          if RigControl.Rig <> nil then
            RigControl.Rig.SetFreq(D.FreqHz);
          Main.MyContest.MultiForm.SetNumberEditFocus;
          break;
        end;
    end;}

end;

initialization
  CurrentRigFrequency := 0;
end.
