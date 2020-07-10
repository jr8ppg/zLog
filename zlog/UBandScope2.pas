unit UBandScope2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, Menus,
  USpotClass, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TBandScope2 = class(TForm)
    BSMenu: TPopupMenu;
    mnDelete: TMenuItem;
    Deleteallworkedstations1: TMenuItem;
    Timer1: TTimer;
    Panel1: TPanel;
    Grid: TStringGrid;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure mnDeleteClick(Sender: TObject);
    procedure Deleteallworkedstations1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
    procedure SetSelect(fSelect: Boolean);
  public
    { Public 宣言 }
    constructor Create(AOwner: TComponent; b: TBand); reintroduce;
    procedure CreateBSData(aQSO : TQSO; Hz : LongInt);
    procedure AddAndDisplay(D : TBSData);
    procedure SetMode(M: TMode);
    procedure RewriteBandScope;
    procedure MarkCurrentFreq(Hz : integer);
    procedure ProcessBSDataFromNetwork(BSText : string);
    procedure NotifyWorked(aQSO: TQSO);

    property FontSize: Integer read GetFontSize write SetFontSize;
    property Select: Boolean write SetSelect;

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
   RR: TRig;
begin
   for b := Low(MainForm.BandScopeEx) to High(MainForm.BandScopeEx) do begin
      if dmZLogGlobal.Settings._usebandscope[b] = False then begin
         Continue;
      end;

      MainForm.BandScopeEx[b].RewriteBandScope;
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
      Grid.Objects[0, R] := nil;
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

   RewriteBandScope();
end;

procedure TBandScope2.FormCreate(Sender: TObject);
begin
   FBSList := TBSList.Create();
   FProcessing := False;
end;

procedure TBandScope2.FormDestroy(Sender: TObject);
begin
   FBSList.Free();
end;

procedure TBandScope2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//
end;

procedure TBandScope2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.LastFocus.SetFocus;
   end;
end;

procedure TBandScope2.GridDblClick(Sender: TObject);
var
   D: TBSData;
begin
   FProcessing := True;
   try
      D := TBSData(Grid.Objects[0, Grid.Selection.Top]);
      if D = nil then begin
         Exit;
      end;

      // 交信済みは除外
      if D.Worked = True then begin
         MainForm.SetYourCallsign('', '');
         Exit;
      end;

      // 相手局をセット
      MainForm.SetYourCallsign(D.Call, D.Number);

      // 周波数をセット
      MainForm.SetFrequency(D.FreqHz);
   finally
      FProcessing := False;
   end;
end;

procedure TBandScope2.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   D: TBSData;
   strText: string;
begin
   with Grid.Canvas do begin
      Font.Name := 'ＭＳ ゴシック';
      Brush.Color := Grid.Color;
      Brush.Style := bsSolid;
      FillRect(Rect);

      strText := Grid.Cells[ACol, ARow];

      D := TBSData(Grid.Objects[ACol, ARow]);
      if D = nil then begin
         Font.Style := [fsBold];
         Font.Color := clBlack;
      end
      else begin
         if (D.SelfSpot = True) then begin
            Font.Color  := dmZLogGlobal.Settings._bandscopecolor[5].FForeColor;
            Brush.Color := dmZLogGlobal.Settings._bandscopecolor[5].FBackColor;
            D.Bold      := dmZLogGlobal.Settings._bandscopecolor[5].FBold;
         end
         else if D.Worked then begin   // 交信済み(＝マルチゲット済み）
            Font.Color  := dmZLogGlobal.Settings._bandscopecolor[1].FForeColor;
            Brush.Color := dmZLogGlobal.Settings._bandscopecolor[1].FBackColor;
            D.Bold      := dmZLogGlobal.Settings._bandscopecolor[1].FBold;
         end
         else begin  // 未交信
            if D.NewMulti = True then begin         // マルチ未ゲット
               Font.Color  := dmZLogGlobal.Settings._bandscopecolor[2].FForeColor;
               Brush.Color := dmZLogGlobal.Settings._bandscopecolor[2].FBackColor;
               D.Bold      := dmZLogGlobal.Settings._bandscopecolor[2].FBold;
            end
            else if (D.NewMulti = False) and (D.Number <> '') then begin // マルチゲット済み
               Font.Color  := dmZLogGlobal.Settings._bandscopecolor[3].FForeColor;
               Brush.Color := dmZLogGlobal.Settings._bandscopecolor[3].FBackColor;
               D.Bold      := dmZLogGlobal.Settings._bandscopecolor[3].FBold;
            end
            else begin     // マルチ不明
               Font.Color  := dmZLogGlobal.Settings._bandscopecolor[4].FForeColor;
               Brush.Color := dmZLogGlobal.Settings._bandscopecolor[4].FBackColor;
               D.Bold      := dmZLogGlobal.Settings._bandscopecolor[4].FBold;
            end;
         end;

         if D.Bold then begin
            Font.Style := [fsBold];
         end
         else begin
            Font.Style := [];
         end;
      end;

      TextRect(Rect, strText, [tfLeft,tfVerticalCenter,tfSingleLine]);

      if gdSelected in State then begin
         DrawFocusRect(Rect);
      end;
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

procedure TBandScope2.SetSelect(fSelect: Boolean);
begin
   if fSelect = True then begin
      Panel1.Color := clBlue;
   end
   else begin
      Panel1.Color := clGray;
   end;
end;

procedure TBandScope2.NotifyWorked(aQSO: TQSO);
var
   i: Integer;
   D: TBSData;
begin
   for i := 0 to FBSList.Count - 1 do begin
      D := FBSList[i];
      SpotCheckWorked(D);
   end;
end;

initialization
   CurrentRigFrequency := 0;

end.
