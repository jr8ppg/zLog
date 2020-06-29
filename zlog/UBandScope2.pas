unit UBandScope2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, Menus, Cologrid,
  USpotClass, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TBandScope2 = class(TForm)
    Grid: TMgrid;
    BSMenu: TPopupMenu;
    mnDelete: TMenuItem;
    Deleteallworkedstations1: TMenuItem;
    Mode1: TMenuItem;
    mnCurrentRig: TMenuItem;
    Rig11: TMenuItem;
    Rig21: TMenuItem;
    Timer1: TTimer;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure GridSetting(ARow, ACol: Integer; var Fcolor: Integer;
      var Bold, Italic, underline: Boolean);
    procedure mnDeleteClick(Sender: TObject);
    procedure Deleteallworkedstations1Click(Sender: TObject);
    procedure ModeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private 宣言 }
    FProcessing: Boolean;
    FMinFreq: Integer;
    FMaxFreq: Integer; // in Hz

    FCurrBand : TBand;
    FCurrMode : TMode;

    FBSList: TBSList;

    procedure AddBSList(D : TBSData);
    procedure DeleteFromBSList(i : integer);
    function GetFontSize(): Integer;
    procedure SetFontSize(v: Integer);
    function EstimateNumRows(): Integer;
  public
    { Public 宣言 }
    DisplayMode : integer; // 0 : current rig; 1 : rig 1; 2 : rig 2; 9 : fixed band
    constructor Create(AOwner: TComponent; b: TBand); reintroduce;
    procedure CreateBSData(aQSO : TQSO; Hz : LongInt);
    procedure AddAndDisplay(D : TBSData);
    procedure SetBandMode(B : TBand; M : TMode);
    procedure SetMode(M: TMode);
    procedure SetMinMaxFreq(min, max : LongInt);      // unused
    procedure RewriteBandScope;
    procedure MarkCurrentFreq(Hz : integer);
    procedure ProcessBSDataFromNetwork(BSText : string);

    property FontSize: Integer read GetFontSize write SetFontSize;

    property BSList: TBSList read FBSList;
  end;

  TBandScopeArray = array[b19..b10g] of TBandScope2;

procedure BSRefresh(Sender : TObject);

var
  CurrentRigFrequency : Integer; // in Hertz

implementation

uses
  UOptions, Main, UZLinkForm, URigControl;

{$R *.dfm}

procedure BSRefresh(Sender: TObject);
var
   b: TBand;
   DispMode: Integer;
   RR: TRig;
begin
   for b := Low(MainForm.BandScopeEx) to High(MainForm.BandScopeEx) do begin
      if dmZLogGlobal.Settings._usebandscope[b] = False then begin
         Continue;
      end;

      DispMode := MainForm.BandScopeEx[b].DisplayMode;

      case DispMode of
         1:
            RR := MainForm.RigControl.Rig1;
         2:
            RR := MainForm.RigControl.Rig2;
         else
            RR := nil;
      end;

      if RR <> nil then begin
         MainForm.BandScopeEx[b].SetMode(RR.CurrentMode);
      end
      else begin
         MainForm.BandScopeEx[b].RewriteBandScope;
      end;
   end;
end;

constructor TBandScope2.Create(AOwner: TComponent; b: TBand);
begin
   Inherited Create(AOwner);
   FCurrBand := b;
   Caption := BandString[b];
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
   if FBSList.Count = 0 then begin
      FBSList.Add(D);
      exit;
   end;

   boo := false;
   for i := 0 to FBSList.Count - 1 do begin
      if FBSList[i].FreqHz > D.FreqHz then begin
         boo := true;
         break;
      end;
   end;

   if boo then
      FBSList.Insert(i, D)
   else
      FBSList.Add(D);
end;

procedure TBandScope2.AddAndDisplay(D: TBSData);
var
   i: Integer;
   BS: TBSData;
   Diff: TDateTime;
begin
   for i := 0 to FBSList.Count - 1 do begin
      BS := FBSList[i];

      if (BS.Call = D.Call) and (BS.Band = D.Band) then begin
         FBSList[i] := nil;
         Continue;
      end;

      if round(BS.FreqHz / 100) = round(D.FreqHz / 100) then begin
         FBSList[i] := nil;
         Continue;
      end;

      Diff := Now - BS.Time;
      if Diff * 24 * 60 > 1.00 * dmZlogGlobal.Settings._bsexpire then begin
         FBSList[i] := nil;
      end;
   end;

   FBSList.Pack;
   AddBSList(D);
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
var
   R: Integer;
begin
   FCurrBand := B;
   FCurrMode := M;
//   Caption := 'Band scope ' + BandString[B];
   Caption := BandString[B];

   for R := 0 to Grid.RowCount - 1 do begin
      Grid.Cells[0, R] := '';
      Grid.Objects[0, R] := nil;
   end;

   RewriteBandScope;
end;

procedure TBandScope2.SetMode(M: TMode);
var
   R: Integer;
begin
   FCurrMode := M;

   for R := 0 to Grid.RowCount - 1 do begin
      Grid.Cells[0, R] := '';
      Grid.Objects[0, R] := nil;
   end;

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
   i: Integer;
   R: Integer;
   toprow: Integer;
   currow: Integer;
   str: string;
   MarkCurrent: Boolean;
   Marked: Boolean;
begin
   toprow := Grid.TopRow;
   currow := Grid.Row;

   if GetBandIndex(CurrentRigFrequency) = Ord(FCurrBand) then begin
      MarkCurrent := True;
   end
   else begin
      MarkCurrent := False;
   end;

   R := EstimateNumRows();
   if R = 0 then begin
      R := 1;    // Gridは0行にできない
   end
   else begin
      // 周波数マーカー分追加
      if MarkCurrent = True then begin
         Inc(R);
      end;
   end;

   // 行数再設定
   Grid.RowCount := R;

   // 先頭行は必ずクリアする
   Grid.Cells[0, 0] := '';
   Grid.Objects[0, 0] := nil;

   Marked := False;

   R := 0;
   for i := 0 to FBSList.Count - 1 do begin
      D := FBSList[i];
      if D.Band <> FCurrBand then begin
         Continue;
      end;

      if MarkCurrent and Not(Marked) then begin
         if D.FreqHz >= CurrentRigFrequency then begin
            Grid.Cells[0, R] := '>>' + kHzStr(CurrentRigFrequency);
            Grid.Objects[0, R] := nil;;
            Marked := true;
            inc(R);
         end;
      end;

      str := FillRight(D.LabelStr, 20);

      if D.ClusterData then begin
         str := str + '+ ';
      end
      else begin
         str := str + '  ';
      end;

      if D.CQ = True then begin
         str := str + 'CQ';
      end
      else begin
         str := str + '  ';
      end;

      Grid.Cells[0, R] := str;
      Grid.Objects[0, R] := D;

      if (Main.CurrentQSO.CQ = false) and ((D.FreqHz - CurrentRigFrequency) <= 100) then begin
         MainForm.AutoInput(D);
      end;

      Inc(R);
   end;

   if MarkCurrent and Not(Marked) then begin
      Grid.Cells[0, R] := '>>' + kHzStr(CurrentRigFrequency);
      Grid.Objects[0, R] := nil;;
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
   for i := 0 to FBSList.Count - 1 do begin
      D := FBSList[i];
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
   if (i >= 0) and (i < FBSList.Count) then begin
      FBSList[i] := nil;
      FBSList.Pack;
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
      for j := 0 to FBSList.Count - 1 do begin
         if pos(FBSList[j].LabelStr, s) = 1 then begin
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
   for i := 0 to FBSList.Count - 1 do begin
      B := FBSList[i];
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

   if D.Band <> FCurrBand then begin
      Exit;
   end;

   Main.MyContest.MultiForm.ProcessSpotData(TBaseSpot(D));
   AddAndDisplay(D);
end;

procedure TBandScope2.Deleteallworkedstations1Click(Sender: TObject);
var
   D: TBSData;
   i: Integer;
begin
   for i := 0 to FBSList.Count - 1 do begin
      D := FBSList[i];
      if D.Band = FCurrBand then begin
         if D.Worked then begin
            FBSList[i] := nil;
         end;
      end;
   end;
   FBSList.Pack;
   BSRefresh(Self);
end;

procedure TBandScope2.ModeClick(Sender: TObject);
begin
   DisplayMode := TMenuItem(Sender).Tag;
end;

procedure TBandScope2.FormCreate(Sender: TObject);
begin
   FBSList := TBSList.Create();

   DisplayMode := 0; // current rig
   FProcessing := False;
end;

procedure TBandScope2.FormDestroy(Sender: TObject);
begin
   FBSList.Free();
end;

procedure TBandScope2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//   if ArrayNumber > 0 then begin
//      BandScopeArray[ArrayNumber] := nil;
//   end;
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
