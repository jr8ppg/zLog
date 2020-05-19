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
    Timer1: TTimer;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure GridSetting(ARow, ACol: Integer; var Fcolor: Integer;
      var Bold, Italic, underline: Boolean);
    procedure mnDeleteClick(Sender: TObject);
    procedure Deleteallworkedstations1Click(Sender: TObject);
    procedure ModeClick(Sender: TObject);
    procedure FixedBandClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private êÈåæ }
    FProcessing: Boolean;
    FMinFreq: Integer;
    FMaxFreq: Integer; // in Hz

    FCurrBand : TBand;
    FCurrMode : TMode;

    FFixedBand : TBand;

    procedure AddBSList(D : TBSData);
    procedure DeleteFromBSList(i : integer);
    function GetFontSize(): Integer;
    procedure SetFontSize(v: Integer);
    function EstimateNumRows(): Integer;
  public
    { Public êÈåæ }
    ArrayNumber : integer;
    DisplayMode : integer; // 0 : current rig; 1 : rig 1; 2 : rig 2; 9 : fixed band
    procedure CreateBSData(aQSO : TQSO; Hz : LongInt);
    procedure AddAndDisplay(D : TBSData);
    procedure SetBandMode(B : TBand; M : TMode);
    procedure SetMinMaxFreq(min, max : LongInt);      // unused
    procedure RewriteBandScope;
    procedure MarkCurrentFreq(Hz : integer);
    procedure ProcessBSDataFromNetwork(BSText : string);

    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

procedure BSRefresh(Sender : TObject);

const BSMax = 15;
var
  CurrentRigFrequency : Integer; // in Hertz
  BandScopeArray : array[1..BSMax] of TBandscope2;

implementation

uses UOptions, Main, UZLinkForm, URigControl;

{$R *.dfm}

procedure BSRefresh(Sender: TObject);
var
   i: Integer;
   DispMode: Integer;
   RR: TRig;
begin
   MainForm.BandScope2.RewriteBandScope;
   for i := 1 to BSMax do begin
      if BandScopeArray[i] <> nil then begin
         DispMode := BandScopeArray[i].DisplayMode;
         RR := nil;
         case DispMode of
            1:
               RR := MainForm.RigControl.Rig1;
            2:
               RR := MainForm.RigControl.Rig2;
         end;
         if RR <> nil then
            BandScopeArray[i].SetBandMode(RR.CurrentBand, RR.CurrentMode)
         else
            BandScopeArray[i].RewriteBandScope;
      end;
   end;
end;

procedure TBandScope2.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TBandScope2.AddBSList(D: TBSData);
var
   i: Integer;
   boo: Boolean;
begin
   if BSList2.Count = 0 then begin
      BSList2.Add(D);
      exit;
   end;

   boo := false;
   for i := 0 to BSList2.Count - 1 do begin
      if TBSData(BSList2[i]).FreqHz > D.FreqHz then begin
         boo := true;
         break;
      end;
   end;

   if boo then
      BSList2.Insert(i, D)
   else
      BSList2.Add(D);
end;

procedure TBandScope2.AddAndDisplay(D: TBSData);
var
   i: Integer;
   BS: TBSData;
   Diff: TDateTime;
begin
   for i := 0 to BSList2.Count - 1 do begin
      BS := TBSData(BSList2[i]);

      if (BS.Call = D.Call) and (BS.Band = D.Band) then begin
         BS.Free;
         BSList2[i] := nil;
         Continue;
      end;

      if round(BS.FreqHz / 100) = round(D.FreqHz / 100) then begin
         BS.Free;
         BSList2[i] := nil;
         Continue;
      end;

      Diff := Now - BS.Time;
      if Diff * 24 * 60 > 1.00 * dmZlogGlobal.Settings._bsexpire then begin
         BS.Free;
         BSList2[i] := nil;
      end;
   end;

   BSList2.Pack;
   AddBSList(D);
   // FormPaint(Self);
//   BSRefresh(Self);
end;

procedure TBandScope2.CreateBSData(aQSO: TQSO; Hz: LongInt);
var
   D: TBSData;
begin
   D := TBSData.Create;
   D.FreqHz := Hz;
   D.Band := aQSO.Band;
   D.Mode := aQSO.Mode;
   D.Call := aQSO.Callsign;
   D.Number := aQSO.NrRcvd;
   // D.Time := Now;
   Main.MyContest.MultiForm.ProcessSpotData(TBaseSpot(D));
   AddAndDisplay(D);
   MainForm.ZLinkForm.SendBandScopeData(D.InText);
   // Send spot data to other radios!
end;

procedure TBandScope2.SetBandMode(B: TBand; M: TMode);
// var min, max : integer;
begin
   FCurrBand := B;
   FCurrMode := M;
   Caption := 'Band scope ' + BandString[B];
   RewriteBandScope;
end;

procedure TBandScope2.SetMinMaxFreq(min, max: LongInt);
begin
   FMinFreq := min;
   FMaxFreq := max;
   dmZlogGlobal.Settings._bsMinFreqArray[FCurrBand, FCurrMode] := min div 1000;
   dmZlogGlobal.Settings._bsMaxFreqArray[FCurrBand, FCurrMode] := max div 1000;
end;

procedure TBandScope2.Timer1Timer(Sender: TObject);
begin
   Timer1.Enabled := False;
   try
      if FProcessing = False then begin
         BSRefresh(Self);
      end;
   finally
      Timer1.Enabled := True;
   end;
end;

procedure TBandScope2.RewriteBandScope;
var
   D: TBSData;
   i, j: Integer;
   toprow: Integer;
   currow: Integer;
   str: string;
   MarkCurrent: Boolean;
   Marked: Boolean;
begin
   toprow := Grid.TopRow;
   currow := Grid.Row;

   Grid.RowCount := EstimateNumRows();
   for j := 0 to Grid.RowCount - 1 do begin
      Grid.Cells[0, j] := '';
      Grid.Objects[0, j] := nil;
   end;

   if GetBandIndex(CurrentRigFrequency) = Ord(FCurrBand) then
      MarkCurrent := true
   else
      MarkCurrent := false;

   Marked := false;

   j := 0;
   for i := 0 to BSList2.Count - 1 do begin
      D := TBSData(BSList2[i]);
      if D.Band <> FCurrBand then begin
         Continue;
      end;

      if MarkCurrent and Not(Marked) then begin
         if D.FreqHz >= CurrentRigFrequency then begin
            Grid.RowCount := Grid.RowCount + 1;
            Grid.Cells[0, j] := '>>' + kHzStr(CurrentRigFrequency);
            Marked := true;
            inc(j);
         end;
      end;

      str := D.LabelStr;

      if D.ClusterData then
         str := FillRight(str, 20) + '+';

      Grid.Cells[0, j] := str;
      Grid.Objects[0, j] := D;

      if (Main.CurrentQSO.CQ = false) and ((D.FreqHz - CurrentRigFrequency) <= 100) then begin
         MainForm.AutoInput(D);
      end;

      inc(j);
   end;

   if MarkCurrent and Not(Marked) then begin
      Grid.RowCount := Grid.RowCount + 1;
      Grid.Cells[0, j] := '>>' + kHzStr(CurrentRigFrequency);
   end;

   if toprow <= Grid.RowCount - 1 then begin
      Grid.TopRow := toprow;
   end
   else begin
      Grid.TopRow := 0;
   end;
   if currow <= Grid.RowCount - 1 then begin
      Grid.Row := currow;
   end
   else begin
      Grid.Row := 0;
   end;
end;

function TBandScope2.EstimateNumRows(): Integer;
var
   i: Integer;
   j: Integer;
   D: TBSData;
begin
   j := 0;
   for i := 0 to BSList2.Count - 1 do begin
      D := TBSData(BSList2[i]);
      if D.Band <> FCurrBand then begin
         Continue;
      end;

      inc(j);
   end;

   Result := j;
end;

procedure TBandScope2.GridSetting(ARow, ACol: Integer; var Fcolor: Integer; var Bold, Italic, underline: Boolean);
var
   D: TBSData;
begin
   D := TBSData(Grid.Objects[ACol, ARow]);
   if D = nil then begin
      Bold := True;
      FColor := clBlack;
   end
   else begin
      if D.NewMulti then begin
         FColor := clRed;
      end
      else if D.Worked then begin
         FColor := clBlack;
      end
      else begin
         FColor := clGreen;
      end;

      if D.Bold then begin
         Bold := True;
      end
      else begin
         Bold := False;
      end;
   end;
end;

procedure TBandScope2.DeleteFromBSList(i: Integer);
begin
   if (i >= 0) and (i < BSList2.Count) then begin
      TBSData(BSList2[i]).Free;
      BSList2[i] := nil;
      BSList2.Pack;
   end;
end;

procedure TBandScope2.mnDeleteClick(Sender: TObject);
var
   i, j: Integer;
   s: string;
begin
   if Grid.Selection.Top < 0 then
      exit;

   for i := Grid.Selection.Top to Grid.Selection.Bottom do begin
      s := Grid.Cells[0, i];
      for j := 0 to BSList2.Count - 1 do begin
         if pos(TBSData(BSList2[j]).LabelStr, s) = 1 then begin
            DeleteFromBSList(j);
            break;
         end;
      end;
   end;

   RewriteBandScope;
end;

procedure TBandScope2.MarkCurrentFreq(Hz: Integer);
var
   i: Integer;
   B: TBSData;
begin
   if (CurrentRigFrequency div 100) = (Hz div 100) then
      exit;

   CurrentRigFrequency := Hz;
   for i := 0 to BSList2.Count - 1 do begin
      B := TBSData(BSList2[i]);
      if abs((B.FreqHz div 100) - (Hz div 100)) <= 1 then
         B.Bold := true
      else
         B.Bold := false;
   end;

   RewriteBandScope;
end;

procedure TBandScope2.ProcessBSDataFromNetwork(BSText: string);
var
   D: TBSData;
begin
   D := TBSData.Create;
   D.FromText(BSText);
   Main.MyContest.MultiForm.ProcessSpotData(TBaseSpot(D));
   AddAndDisplay(D);
end;

procedure TBandScope2.Deleteallworkedstations1Click(Sender: TObject);
var
   D: TBSData;
   i: Integer;
begin
   for i := 0 to BSList2.Count - 1 do begin
      D := TBSData(BSList2[i]);
      if D.Band = FCurrBand then begin
         if D.Worked then begin
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
   FFixedBand := TBand(TMenuItem(Sender).Tag);
   SetBandMode(FFixedBand, Main.CurrentQSO.Mode);
   BSRefresh(Self);
end;

procedure TBandScope2.FormCreate(Sender: TObject);
begin
   FFixedBand := b19;
   ArrayNumber := 0;
   DisplayMode := 0; // current rig
   FProcessing := False;
end;

procedure TBandScope2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if ArrayNumber > 0 then begin
      BandScopeArray[ArrayNumber] := nil;
      Free;
   end;
end;

procedure TBandScope2.GridDblClick(Sender: TObject);
var
   i, j: Integer;
   F: Extended;
   str, fstr, cstr, nstr: string;
begin
   FProcessing := True;
   try
      str := Grid.Cells[0, Grid.Selection.Top];
      if pos('+', str) > 0 then
         str := TrimRight(copy(str, 1, length(str) - 1));

      { ver 2.2d stop scanning BSList2. just read freq from the string }

      fstr := '';
      cstr := '';
      nstr := '';

      i := pos('[', str); // extract number if any
      if i > 0 then begin
         j := pos(']', str);
         if j > i then
            nstr := copy(str, i + 1, j - i - 1);
      end;

      i := pos(' ', str); // extract frequency in kHz
      if i > 0 then
         fstr := copy(str, 1, i)
      else
         exit;

      Delete(str, 1, i); // extract callsign
      i := pos(' ', str);
      if i > 0 then
         cstr := copy(str, 1, i - 1)
      else
         cstr := str;

      try
         F := StrToFloat(fstr);
      except
         on EConvertError do begin
            exit;
         end;
      end;

      MainForm.CallsignEdit.Text := cstr;
      MainForm.NumberEdit.Text := nstr;
      if MainForm.RigControl.Rig <> nil then
         MainForm.RigControl.Rig.SetFreq(round(F * 1000));

      Main.MyContest.MultiForm.SetNumberEditFocus;
      MainForm.UpdateBand(TBand(GetBandIndex(round(F * 1000))));
   finally
      FProcessing := False;
   end;
end;

function TBandScope2.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TBandScope2.SetFontSize(v: Integer);
var
   i: Integer;
   h: Integer;
begin
   Grid.Font.Size := v;
   Grid.Canvas.Font.size := v;

   h := Abs(Grid.Font.Height) + 2;

   Grid.DefaultRowHeight := h;

   for i := 0 to Grid.RowCount - 1 do begin
      Grid.RowHeights[i] := h;
   end;
end;

initialization
   CurrentRigFrequency := 0;

end.
