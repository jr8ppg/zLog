unit UBandScope2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, Menus, DateUtils,
  USpotClass, UzLogConst, UzLogGlobal, UzLogQSO, System.ImageList, Vcl.ImgList,
  System.UITypes;

type
  TBandScope2 = class(TForm)
    BSMenu: TPopupMenu;
    mnDelete: TMenuItem;
    Deleteallworkedstations1: TMenuItem;
    Timer1: TTimer;
    Panel1: TPanel;
    Grid: TStringGrid;
    ImageList1: TImageList;
    Panel2: TPanel;
    checkSyncVfo: TCheckBox;
    timerCleanup: TTimer;
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
    procedure FormShow(Sender: TObject);
    procedure GridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure checkSyncVfoClick(Sender: TObject);
    procedure timerCleanupTimer(Sender: TObject);
  private
    { Private �錾 }
    FProcessing: Boolean;

    FCurrentBandOnly: Boolean;
    FNewMultiOnly: Boolean;
    FCurrBand : TBand;
    FSelectFlag: Boolean;

    FBSList: TBSList;
    FBSLock: TRTLCriticalSection;

    FFreshnessThreshold: array[0..4] of Integer;
    FFreshnessType: Integer;
    FIconType: Integer;

    procedure AddBSList(D : TBSData);
    procedure AddAndDisplay(D : TBSData);
    procedure DeleteFromBSList(i : integer);
    function GetFontSize(): Integer;
    procedure SetFontSize(v: Integer);
    function EstimateNumRows(): Integer;
    procedure SetSelect(fSelect: Boolean);
    procedure Cleanup(D: TBSData);
    procedure SetFreshnessType(v: Integer);
    procedure SetIconType(v: Integer);
    function CalcRemainTime(T1, T2: TDateTime): Integer;
    function CalcElapsedTime(T1, T2: TDateTime): Integer;
    procedure SetCurrentBand(b: TBand);
    procedure SetCurrentBandOnly(v: Boolean);
    procedure SetNewMultiOnly(v: Boolean);
    procedure SetCaption();
    procedure SetColor();
    procedure Lock();
    procedure Unlock();
  public
    { Public �錾 }
    constructor Create(AOwner: TComponent; b: TBand); reintroduce;
    procedure AddSelfSpot(strCallsign: string; strNrRcvd: string; b: TBand; m: TMode; Hz: Int64);
    procedure AddSelfSpotFromNetwork(BSText : string);
    procedure AddClusterSpot(Sp: TSpot);
    procedure RewriteBandScope();
    procedure MarkCurrentFreq(Hz : integer);
    procedure NotifyWorked(aQSO: TQSO);
    procedure CopyList(F: TBandScope2);
    procedure SetSpotWorked(aQSO: TQSO);

    property FontSize: Integer read GetFontSize write SetFontSize;
    property Select: Boolean write SetSelect;
    property FreshnessType: Integer read FFreshnessType write SetFreshnessType;
    property IconType: Integer read FIconType write SetIconType;
    property CurrentBand: TBand read FCurrBand write SetCurrentBand;
    property CurrentBandOnly: Boolean read FCurrentBandOnly write SetCurrentBandOnly;
    property NewMultiOnly: Boolean read FNewMultiOnly write SetNewMultiOnly;
  end;

  TBandScopeArray = array[b19..b10g] of TBandScope2;

var
  CurrentRigFrequency : Int64; // in Hertz

implementation

uses
  UOptions, Main, UZLinkForm, URigControl;

{$R *.dfm}

constructor TBandScope2.Create(AOwner: TComponent; b: TBand);
begin
   Inherited Create(AOwner);
   Grid.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
   FCurrentBandOnly := False;
   FNewMultiOnly := False;
   FSelectFlag := False;
   FCurrBand := b;
   SetCaption();
   FreshnessType := dmZLogGlobal.Settings._bandscope_freshness_mode;
   IconType := dmZLogGlobal.Settings._bandscope_freshness_icon;
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
   Lock();
   try
      if FBSList.Count = 0 then begin
         FBSList.Add(D);
         Exit;
      end;

      boo := false;
      for i := 0 to FBSList.Count - 1 do begin
         if FBSList[i].FreqHz > D.FreqHz then begin
            boo := true;
            Break;
         end;
      end;

      if boo then begin
         FBSList.Insert(i, D);
      end
      else begin
         FBSList.Add(D);
      end;
   finally
      Unlock();
   end;
end;

procedure TBandScope2.AddAndDisplay(D: TBSData);
begin
   Cleanup(D);
   AddBSList(D);
end;

// Self Spot
procedure TBandScope2.AddSelfSpot(strCallsign: string; strNrRcvd: string; b: TBand; m: TMode; Hz: Int64);
var
   D: TBSData;
begin
   if FCurrBand <> b then begin
      Exit;
   end;

   D := TBSData.Create;
   D.FreqHz := Hz;
   D.Band := b;
   D.Mode := m;
   D.Call := strCallsign;
   D.Number := strNrRcvd;
   D.Time := Now;
   D.SpotSource := ssSelf;

   // ��M�ς݃`�F�b�N
   SpotCheckWorked(D);

   AddAndDisplay(D);

   // Send spot data to other radios!
   MainForm.ZLinkForm.SendBandScopeData(D.InText);
end;

// ����PC�œo�^������Spot via Z-Server
procedure TBandScope2.AddSelfSpotFromNetwork(BSText: string);
var
   D: TBSData;
begin
   D := TBSData.Create;
   D.FromText(BSText);
   D.SpotSource := ssSelfFromZServer;

   if D.Band <> FCurrBand then begin
      D.Free();
      Exit;
   end;

   // ��M�ς݃`�F�b�N
   SpotCheckWorked(D);

   AddAndDisplay(D);
end;

// SpotSource��ssCluster ���� ssClusterFromZServer
procedure TBandScope2.AddClusterSpot(Sp: TSpot);
var
   D: TBSData;
begin
   if (FNewMultiOnly = False) and (FCurrBand <> Sp.Band) then begin
      Exit;
   end;

   D := TBSData.Create;
   D.Call := Sp.Call;
   D.FreqHz := Sp.FreqHz;
   D.CtyIndex := Sp.CtyIndex;
   D.Zone := Sp.Zone;
   D.Band := Sp.Band;
   D.Mode := Sp.Mode;
   D.NewCty := Sp.NewCty;
   D.NewZone := Sp.NewZone;
   D.Worked := Sp.Worked;
   D.SpotSource := Sp.SpotSource;
   D.SpotGroup := Sp.SpotGroup;
   D.CQ := Sp.CQ;
   D.Number := Sp.Number;
   D.NewJaMulti := Sp.NewJaMulti;
   D.ReportedBy := Sp.ReportedBy;
   AddAndDisplay(D);
end;

procedure TBandScope2.Timer1Timer(Sender: TObject);
begin
   Timer1.Enabled := False;
   try
      if FProcessing = False then begin
         RewriteBandScope();
      end;
   finally
      Timer1.Enabled := True;
   end;
end;

procedure TBandScope2.timerCleanupTimer(Sender: TObject);
begin
   Cleanup(nil);
end;

procedure TBandScope2.Cleanup(D: TBSData);
var
   i: Integer;
   BS: TBSData;
   Diff: TDateTime;
begin
   Lock();
   try
      for i := 0 to FBSList.Count - 1 do begin
         BS := FBSList[i];

         if Assigned(D) then begin
            if (BS.Call = D.Call) and (BS.Band = D.Band) then begin
               FBSList[i] := nil;
               Continue;
            end;

            if round(BS.FreqHz / 100) = round(D.FreqHz / 100) then begin
               FBSList[i] := nil;
               Continue;
            end;

            if (FNewMultiOnly = True) and (BS.IsNewMulti() = False) then begin
               FBSList[i] := nil;
               Continue;
            end;
         end;

         Diff := Now - BS.Time;
         if Diff * 24 * 60 > 1.00 * dmZlogGlobal.Settings._bsexpire then begin
            FBSList[i] := nil;
         end;
      end;

      FBSList.Pack;
   finally
      Unlock();
   end;
end;

procedure TBandScope2.RewriteBandScope();
var
   D: TBSData;
   i: Integer;
   R: Integer;
   toprow: Integer;
   currow: Integer;
   markrow: Integer;
   str: string;
   MarkCurrent: Boolean;
   Marked: Boolean;
begin
   FProcessing := True;
   try
   try
      toprow := Grid.TopRow;
      currow := Grid.Row;
      markrow := -1;

      if (FNewMultiOnly = False) and (dmZLogGlobal.BandPlan.FreqToBand(CurrentRigFrequency) = FCurrBand) then begin
         MarkCurrent := True;
      end
      else begin
         MarkCurrent := False;
      end;

      R := EstimateNumRows();
      if R = 0 then begin
         R := 1;    // Grid��0�s�ɂł��Ȃ�
      end
      else begin
         // ���g���}�[�J�[���ǉ�
         if MarkCurrent = True then begin
            Inc(R);
         end;
      end;

      // �s���Đݒ�
      Grid.RowCount := R;

      // �擪�s�͕K���N���A����
      Grid.Cells[0, 0] := '';
      Grid.Objects[0, 0] := nil;

      Marked := False;

      Lock();
      try
         R := 0;
         for i := 0 to FBSList.Count - 1 do begin
            D := FBSList[i];
            if (FNewMultiOnly = False) and (FCurrBand <> D.Band) then begin
               Continue;
            end;

            if MarkCurrent and Not(Marked) then begin
               if D.FreqHz >= CurrentRigFrequency then begin
                  Grid.Cells[0, R] := '>>' + kHzStr(CurrentRigFrequency);
                  Grid.Objects[0, R] := nil;
                  Marked := true;
                  markrow := R;
                  Inc(R);
               end;
            end;

            str := FillRight(D.LabelStr, 24);

            if D.SpotSource <> ssSelf then begin
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

   //         if (Main.CurrentQSO.CQ = false) and ((D.FreqHz - CurrentRigFrequency) <= 100) then begin
   //            MainForm.AutoInput(D);
   //         end;

            Inc(R);
         end;
      finally
         Unlock();
      end;

      if MarkCurrent and Not(Marked) then begin
         Grid.Cells[0, R] := '>>' + kHzStr(CurrentRigFrequency);
         Grid.Objects[0, R] := nil;
         markrow := R;
      end;

      if checkSyncVfo.Checked = True then begin
         if markrow = -1 then begin
            if toprow <= Grid.RowCount - 1 then begin
               Grid.TopRow := toprow;
            end
            else begin
               Grid.TopRow := 0;
            end;
         end
         else begin
            if Grid.TopRow > markrow then begin
               Grid.TopRow := markrow;
            end;
            if (Grid.TopRow + Grid.VisibleRowCount - 1) < markrow then begin
               i := markrow - Grid.VisibleRowCount + 1;
               if i >= 0 then begin
                  Grid.TopRow := i;
               end;
            end;
         end;

         if currow <= Grid.RowCount - 1 then begin
            Grid.Row := currow;
         end
         else begin
            Grid.Row := 0;
         end;
      end;
   except
      on E: Exception do begin
         dmZLogGlobal.WriteErrorLog(E.Message);
         dmZLogGlobal.WriteErrorLog(E.StackTrace);
      end;
   end;
   finally
      FProcessing := False;
   end;
end;

function TBandScope2.EstimateNumRows(): Integer;
var
   i: Integer;
   j: Integer;
   D: TBSData;
begin
   Lock();
   try
      j := 0;
      for i := 0 to FBSList.Count - 1 do begin
         D := FBSList[i];
         if (FNewMultiOnly = False) and (FCurrBand <> D.Band) then begin
            Continue;
         end;

         inc(j);
      end;

      Result := j;
   finally
      Unlock();
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
   if Grid.Selection.Top < 0 then begin
      Exit;
   end;

   Lock();
   try
      for i := Grid.Selection.Top to Grid.Selection.Bottom do begin
         s := Grid.Cells[0, i];
         for j := 0 to FBSList.Count - 1 do begin
            if pos(FBSList[j].LabelStr, s) = 1 then begin
               DeleteFromBSList(j);
               Break;
            end;
         end;
      end;
   finally
      Unlock();
   end;

   RewriteBandScope;
end;

procedure TBandScope2.MarkCurrentFreq(Hz: Integer);
var
   i: Integer;
   B: TBSData;
begin
   if dmZLogGlobal.BandPlan.FreqToBand(Hz) = bUnknown then begin
      Exit;
   end;

   if (CurrentRigFrequency div 100) = (Hz div 100) then begin
      Exit;
   end;

   CurrentRigFrequency := Hz;

   Lock();
   try
      for i := 0 to FBSList.Count - 1 do begin
         B := FBSList[i];
         if abs((B.FreqHz div 100) - (Hz div 100)) <= 1 then begin
            B.Bold := true;
         end
         else begin
            B.Bold := false;
         end;
      end;
   finally
      Unlock();
   end;

   RewriteBandScope;
end;

procedure TBandScope2.Deleteallworkedstations1Click(Sender: TObject);
var
   D: TBSData;
   i: Integer;
begin
   Lock();
   try
      for i := 0 to FBSList.Count - 1 do begin
         D := FBSList[i];
         if D.Band = FCurrBand then begin
            if D.Worked then begin
               FBSList[i] := nil;
            end;
         end;
      end;
      FBSList.Pack;
   finally
      Unlock();
   end;

   RewriteBandScope();
end;

procedure TBandScope2.FormCreate(Sender: TObject);
begin
   InitializeCriticalSection(FBSLock);
   FBSList := TBSList.Create();
   FProcessing := False;
   timerCleanup.Interval := 1 * 60 * 1000; // 1min.
   timerCleanup.Enabled := True;
end;

procedure TBandScope2.FormDestroy(Sender: TObject);
begin
   timerCleanup.Enabled := False;
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
         MainForm.SetLastFocus();
   end;
end;

procedure TBandScope2.FormResize(Sender: TObject);
begin
   Grid.ColWidths[0] := Grid.Width - 4;
end;

procedure TBandScope2.FormShow(Sender: TObject);
begin
   Timer1.Enabled := True;
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

      // ��M�ς݂͏��O
      if D.Worked = True then begin
         MainForm.SetYourCallsign('', '');
         Exit;
      end;

      // ����ǂ��Z�b�g
      MainForm.SetYourCallsign(D.Call, D.Number);

      // ���g�����Z�b�g
      MainForm.SetFrequency(D.FreqHz);

      // ���C���E�C���h�E�Ƀt�H�[�J�X
      MainForm.LastFocus.SetFocus();
   finally
      FProcessing := False;
   end;
end;

procedure TBandScope2.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   D: TBSData;
   strText: string;
   n: Integer;
   x, y: Integer;
   rc: TRect;
   sec: Integer;
   fNewMulti: Boolean;

   function AdjustDark(c: TColor): TColor;
   var
      R, G, B: Byte;
   begin
      B := GetBValue(c);
      G := GetGValue(c);
      R := GetRValue(c);

      B := Trunc(B * 0.75);
      G := Trunc(G * 0.75);
      R := Trunc(R * 0.75);

      Result := RGB(R, G, B);
   end;
begin
   with Grid.Canvas do begin
      Font.Name := dmZLogGlobal.Settings.FBaseFontName;
      Brush.Color := Grid.Color;
      Brush.Style := bsSolid;
      FillRect(Rect);

      strText := Grid.Cells[ACol, ARow];

      D := TBSData(Grid.Objects[ACol, ARow]);
      if D = nil then begin
         Font.Style := [fsBold];
         Font.Color := clBlack;
         n := -1;
      end
      else begin
         // 0,1,2�͎c�莞�ԁA3�͌o�ߎ���
         if FFreshnessType = 3 then begin
            sec := CalcElapsedTime(D.Time, Now);
         end
         else begin
            sec := CalcRemainTime(D.Time, Now);
         end;

         if sec < FFreshnessThreshold[0] then begin
            n := 0;
         end
         else if sec < FFreshnessThreshold[1] then begin
            n := 1;
         end
         else if sec < FFreshnessThreshold[2] then begin
            n := 2;
         end
         else if sec < FFreshnessThreshold[3] then begin
            n := 3;
         end
         else begin
            n := 4;
         end;

         if D.Worked then begin   // ��M�ς�(���}���`�Q�b�g�ς݁j
            Font.Color  := dmZLogGlobal.Settings._bandscopecolor[1].FForeColor;
            D.Bold      := dmZLogGlobal.Settings._bandscopecolor[1].FBold;
         end
         else begin  // ����M
            fNewMulti := D.IsNewMulti();
            if fNewMulti = True then begin         // �}���`���Q�b�g
               Font.Color  := dmZLogGlobal.Settings._bandscopecolor[2].FForeColor;
               D.Bold      := dmZLogGlobal.Settings._bandscopecolor[2].FBold;
            end
            else if (fNewMulti = False) and (D.Number <> '') then begin // �}���`�Q�b�g�ς݂Ńi���o�[����
               Font.Color  := dmZLogGlobal.Settings._bandscopecolor[3].FForeColor;
               D.Bold      := dmZLogGlobal.Settings._bandscopecolor[3].FBold;
            end
            else if (fNewMulti = False) and (D.Number = '') then begin // �}���`�Q�b�g�ς݂Ńi���o�[�s��
               Font.Color  := dmZLogGlobal.Settings._bandscopecolor[3].FForeColor;
               D.Bold      := dmZLogGlobal.Settings._bandscopecolor[3].FBold;
            end
            else begin     // �}���`�s��
               Font.Color  := dmZLogGlobal.Settings._bandscopecolor[4].FForeColor;
               D.Bold      := dmZLogGlobal.Settings._bandscopecolor[4].FBold;
            end;
         end;

         // �w�i�F��SpotSource�ʂɂ���
         case D.SpotSource of
            ssSelf, ssSelfFromZserver: begin
               case D.SpotGroup of
                  1: Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[5].FBackColor;
                  2: Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[5].FBackColor2;
                  3: Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[5].FBackColor3;
                  else Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[5].FBackColor;
               end;
            end;

            ssCluster: begin
               case D.SpotGroup of
                  1: Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[6].FBackColor;
                  2: Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[6].FBackColor2;
                  3: Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[6].FBackColor3;
                  else Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[6].FBackColor;
               end;
            end;

            ssClusterFromZServer: begin
               case D.SpotGroup of
                  1: Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[7].FBackColor;
                  2: Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[7].FBackColor2;
                  3: Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[7].FBackColor3;
                  else Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[7].FBackColor;
               end;
            end;

            else begin
               Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[5].FBackColor;
            end;
         end;

         if D.Bold then begin
            Font.Style := [fsBold];
         end
         else begin
            Font.Style := [];
         end;

         if D.Mode = mOther then begin
            Font.Color := AdjustDark(Font.Color);
            Brush.Color := AdjustDark(Brush.Color);
         end;

         {$IFDEF DEBUG}
//         strText := strText + ' (' + IntToStr(sec) + ')';
         strText := strText + ' (' + ModeString[D.Mode][1] + ')';
         {$ENDIF}
      end;

      if n > -1 then begin
         x := Rect.Left + 2;
         y := Rect.Top + (((Rect.Bottom - Rect.Top) - 16) div 2);
         ImageList1.Draw(Grid.Canvas, x, y, n, True);
      end;

      rc := Rect;
      rc.Left := rc.Left + 16 + 4;
      TextRect(rc, strText, [tfLeft,tfVerticalCenter,tfSingleLine]);

      if gdSelected in State then begin
         DrawFocusRect(Rect);
      end;
   end;
end;

procedure TBandScope2.GridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
   pt: TPoint;
   C, R: Integer;
   D: TBSData;
   strText: string;
   remain: Integer;
   elapsed: Integer;
   T2: TDateTime;
begin
   pt.X := X;
   pt.Y := Y;
   pt := Grid.ClientToScreen(pt);

   Grid.MouseToCell(X, Y, C, R);
   if (C = -1) or (R = -1) then begin
      Application.CancelHint();
      Grid.Hint := '';
      Exit;
   end;

   D := TBSData(Grid.Objects[C, R]);
   if D = nil then begin
      Application.CancelHint();
      Grid.Hint := '';
      Exit;
   end;

   T2 := Now;
   remain := CalcRemainTime(D.Time, T2);
   elapsed := CalcElapsedTime(D.Time, T2);

   strText := D.Call + #13#10 +
              'Spoted at ' + FormatDateTime('hh:mm:ss', D.Time) + #13#10;
   if remain > 60 then begin
      strText := strText + IntToStr(Trunc(remain / 60)) + ' minutes to left' + #13#10;
   end
   else begin
      strText := strText + IntToStr(remain) + ' seconds to left' + #13#10;
   end;

   if elapsed > 60 then begin
      strText := strText + IntToStr(Trunc(elapsed / 60)) + ' minutes elapsed';
   end
   else begin
      strText := strText + IntToStr(elapsed) + ' seconds elapsed';
   end;

   // Spotter
   if D.ReportedBy <> '' then begin
      strText := strText + #13#10 + 'Reported by ' + D.ReportedBy;
   end;

   Grid.Hint := strText;
   Application.ActivateHint(pt);
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
   FSelectFlag := fSelect;
   SetColor();
end;

procedure TBandScope2.NotifyWorked(aQSO: TQSO);
var
   i: Integer;
   D: TBSData;
begin
   Lock();
   try
      for i := 0 to FBSList.Count - 1 do begin
         D := FBSList[i];
         SpotCheckWorked(D);

         if (FNewMultiOnly = True) then begin
            if (D.IsNewMulti() = False) then begin
               FBSList[i] := nil;
            end;
            if (D.Call = aQSO.Callsign) and (D.Band = aQSO.Band) then begin
               FBSList[i] := nil;
            end;
         end;
      end;
      FBSList.Pack();
   finally
      Unlock();
   end;
end;

procedure TBandScope2.SetFreshnessType(v: Integer);
begin
   FFreshnessType := v;
   case FFreshnessType of
      1: begin
         FFreshnessThreshold[0] := 30;
         FFreshnessThreshold[1] := 5 * 60;
         FFreshnessThreshold[2] := 10 * 60;
         FFreshnessThreshold[3] := 30 * 60;
         FFreshnessThreshold[4] := 0;  // unused
      end;

      2: begin
         FFreshnessThreshold[0] := (dmZlogGlobal.Settings._bsexpire * 60) div 5;
         FFreshnessThreshold[1] := FFreshnessThreshold[0] + FFreshnessThreshold[0];
         FFreshnessThreshold[2] := FFreshnessThreshold[1] + FFreshnessThreshold[0];
         FFreshnessThreshold[3] := FFreshnessThreshold[2] + FFreshnessThreshold[0];
         FFreshnessThreshold[4] := 0;  // unused
      end;

      3: begin
         FFreshnessThreshold[0] := 299;            // [0]
         FFreshnessThreshold[1] := 10 * 60;        // [5]
         FFreshnessThreshold[2] := 20 * 60;        // [10]
         FFreshnessThreshold[3] := 30 * 60;        // [20]
         FFreshnessThreshold[4] := 0;              // unused
      end;

      else begin
         FFreshnessThreshold[0] := (dmZlogGlobal.Settings._bsexpire * 60) div 16;
         FFreshnessThreshold[1] := (dmZlogGlobal.Settings._bsexpire * 60) div 8;
         FFreshnessThreshold[2] := (dmZlogGlobal.Settings._bsexpire * 60) div 4;
         FFreshnessThreshold[3] := (dmZlogGlobal.Settings._bsexpire * 60) div 2;
         FFreshnessThreshold[4] := 0;  // unused
      end;
   end;
end;

procedure TBandScope2.SetIconType(v: Integer);
var
   bmp: TBitmap;
   i: Integer;
   strPrefix: string;
begin
   FIconType := v;

   case FIconType of
      1: strPrefix := 'IDB_ANT_';
      2: strPrefix := 'IDB_TIM_';
      3: strPrefix := 'IDB_NUM_';
      4: strPrefix := 'IDB_BAR_';
      5: strPrefix := 'IDB_NUM2_';
      else strPrefix := 'IDB_BAR2_';
   end;

   bmp := TBitmap.Create();
   ImageList1.Clear();
   for i := 0 to 4 do begin
      bmp.LoadFromResourceName(SysInit.HInstance, strPrefix + IntToStr(i));
      ImageList1.Add(bmp, nil);
   end;
   bmp.Free();
end;

function TBandScope2.CalcRemainTime(T1, T2: TDateTime): Integer;
var
   ExpireTime: TDateTime;
begin
   ExpireTime := IncMinute(T1, dmZlogGlobal.Settings._bsexpire);
   if ExpireTime > Now then begin
      Result := Trunc(SecondSpan(ExpireTime, T2));
   end
   else begin
      Result := 0;
   end;
end;

procedure TBandScope2.checkSyncVfoClick(Sender: TObject);
begin
   RewriteBandScope();
end;

function TBandScope2.CalcElapsedTime(T1, T2: TDateTime): Integer;
begin
   Result := Trunc(SecondSpan(T2, T1));
end;

procedure TBandScope2.SetCurrentBand(b: TBand);
begin
   if FCurrBand = b then begin
      Exit;
   end;

   Lock();
   try
      FBSList.Clear();
   finally
      Unlock();
   end;

   FCurrBand := b;
   SetCaption();
   RewriteBandScope();
end;

procedure TBandScope2.SetCurrentBandOnly(v: Boolean);
begin
   FCurrentBandOnly := v;
   SetCaption();
end;

procedure TBandScope2.SetNewMultiOnly(v: Boolean);
begin
   FNewMultiOnly := v;
   SetCaption();
   SetColor();
end;

procedure TBandScope2.SetCaption();
begin
   if FCurrentBandOnly = True then begin
      Caption := '[Current] ' + BandString[FCurrBand];
   end
   else begin
      if FNewMultiOnly = True then begin
         Caption := '[New Multi]';
      end
      else begin
         Caption := BandString[FCurrBand];
      end;
   end;
end;

procedure TBandScope2.SetColor();
begin
   if FNewMultiOnly = True then begin
      Panel1.Color := dmZLogGlobal.Settings._bandscopecolor[2].FForeColor;
   end
   else begin
      if FSelectFlag = True then begin
         Panel1.Color := clBlue;
      end
      else begin
         Panel1.Color := clGray;
      end;
   end;
end;

procedure TBandScope2.CopyList(F: TBandScope2);
var
   i: Integer;
   D: TBSData;
begin
   Lock();
   F.Lock();
   try
      for i := 0 to F.FBSList.Count - 1 do begin
         D := TBSData.Create();
         D.Assign(F.FBSList[i]);
         FBSList.Add(D);
      end;
   finally
      Unlock();
      F.Unlock();
   end;
end;

procedure TBandScope2.SetSpotWorked(aQSO: TQSO);
var
   i: Integer;
   S: TBaseSpot;
begin
   Lock();
   try
      for i := 0 to FBSList.Count - 1 do begin
         S := TBaseSpot(FBSList[i]);
         if (S.Call = aQSO.Callsign) and (S.Band = aQSO.Band) then begin
            S.NewCty := False;
            S.NewZone := False;
            S.NewJaMulti := False;
            S.Worked := True;

            if FNewMultiOnly = True then begin
               FBSList[i] := nil;
            end;
         end;
      end;
      FBSList.Pack;
   finally
      Unlock();
   end;

   RewriteBandScope();
end;

procedure TBandScope2.Lock();
begin
   EnterCriticalSection(FBSLock);
end;

procedure TBandScope2.Unlock();
begin
   LeaveCriticalSection(FBSLock);
end;

initialization
   CurrentRigFrequency := 0;

end.
