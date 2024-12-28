unit UBandScope2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, Menus, DateUtils,
  USpotClass, UzLogConst, UzLogGlobal, UzLogQSO, UBandPlan,
  System.ImageList, Vcl.ImgList, System.IniFiles,
  System.UITypes, Vcl.Buttons, System.Actions, Vcl.ActnList, Vcl.ComCtrls;

type
  TBSDisplayMode = (bsNormal = 0, bsSyncVFO, bsFreqCenter );
  TBandScopeStyle = (bssCurrentBand = 0, bssAllBands, bssNewMulti, bssByBand );

type
  TBandScope2 = class(TForm)
    BSMenu: TPopupMenu;
    menuDeleteSpot: TMenuItem;
    menuDeleteAllWorkedStations: TMenuItem;
    Timer1: TTimer;
    Panel1: TPanel;
    Grid: TStringGrid;
    ImageList1: TImageList;
    panelStandardOption: TPanel;
    timerCleanup: TTimer;
    buttonShowWorked: TSpeedButton;
    ActionList1: TActionList;
    actionPlayMessageA01: TAction;
    actionPlayMessageA02: TAction;
    actionPlayMessageA03: TAction;
    actionPlayMessageA04: TAction;
    actionPlayMessageA05: TAction;
    actionPlayMessageA06: TAction;
    actionPlayMessageA07: TAction;
    actionPlayMessageA08: TAction;
    actionPlayMessageA09: TAction;
    actionPlayMessageA10: TAction;
    actionPlayMessageA11: TAction;
    actionPlayMessageA12: TAction;
    actionPlayMessageB01: TAction;
    actionPlayMessageB02: TAction;
    actionPlayMessageB03: TAction;
    actionPlayMessageB04: TAction;
    actionPlayMessageB05: TAction;
    actionPlayMessageB06: TAction;
    actionPlayMessageB07: TAction;
    actionPlayMessageB08: TAction;
    actionPlayMessageB09: TAction;
    actionPlayMessageB10: TAction;
    actionPlayMessageB11: TAction;
    actionPlayMessageB12: TAction;
    actionPlayCQA1: TAction;
    actionPlayCQA2: TAction;
    actionPlayCQA3: TAction;
    actionPlayCQB1: TAction;
    actionPlayCQB2: TAction;
    actionPlayCQB3: TAction;
    actionDecreaseCwSpeed: TAction;
    actionIncreaseCwSpeed: TAction;
    N1: TMenuItem;
    menuAddToDenyList: TMenuItem;
    panelAllBandsOption: TPanel;
    buttonSortByFreq: TSpeedButton;
    buttonSortByTime: TSpeedButton;
    ImageList2: TImageList;
    buttonSyncVfo: TSpeedButton;
    buttonFreqCenter: TSpeedButton;
    buttonNormalMode: TSpeedButton;
    tabctrlBandSelector: TTabControl;
    procedure menuDeleteSpotClick(Sender: TObject);
    procedure menuDeleteAllWorkedStationsClick(Sender: TObject);
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
    procedure buttonShowWorkedClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure actionPlayMessageAExecute(Sender: TObject);
    procedure actionPlayMessageBExecute(Sender: TObject);
    procedure actionDecreaseCwSpeedExecute(Sender: TObject);
    procedure actionIncreaseCwSpeedExecute(Sender: TObject);
    procedure menuAddToDenyListClick(Sender: TObject);
    procedure buttonSortByFreqClick(Sender: TObject);
    procedure buttonSortByTimeClick(Sender: TObject);
    procedure GridMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure GridMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure GridContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure tabctrlBandSelectorChange(Sender: TObject);
    procedure tabctrlBandSelectorChanging(Sender: TObject;
      var AllowChange: Boolean);
  private
    { Private �錾 }
    FProcessing: Boolean;

    FBandScopeStyle: TBandScopeStyle;
    FDisplayMode: TBSDisplayMode;

    FCurrBand : TBand;
    FSelectFlag: Boolean;
    FShowAllBands: Boolean;

    FSortOrder: Integer;
    FBSList: TBSList;
    FBSLock: TRTLCriticalSection;

    FFreshnessThreshold: array[0..4] of Integer;
    FFreshnessType: Integer;
    FIconType: Integer;

    FUseResume: Boolean;
    FResumeFile: string;
    procedure AddBSList(D : TBSData);
    procedure AddAndDisplay(D : TBSData);
    procedure DeleteFromBSList(i : integer);
    function GetFontSize(): Integer;
    procedure SetFontSize(v: Integer);
    function GetDisplayMode(): TBSDisplayMode;
    procedure SetDisplayMode(v: TBSDisplayMode);
    function IsShowData(D: TBSData): Boolean;
    function FormatSpotInfo(D: TBSData): string;
    function EstimateNumRows(): Integer;
    procedure SetSelect(fSelect: Boolean);
    procedure Cleanup(D: TBSData);
    procedure SetFreshnessType(v: Integer);
    procedure SetIconType(v: Integer);
    function CalcRemainTime(T1, T2: TDateTime): Integer;
    function CalcElapsedTime(T1, T2: TDateTime): Integer;
    procedure SetCurrentBand(b: TBand);
    procedure SetBandScopeStyle(style: TBandScopeStyle);
    procedure SetCaption();
    procedure SetColor();
    procedure Lock();
    procedure Unlock();
    procedure ApplyShortcut();
    procedure ApplyFontSize(font_size: Integer);
    function BandToTabIndex(b: TBand): Integer;
    function TabIndexToBand(TabIndex: Integer): TBand;
    procedure SetDisplayModeState(fEnable: Boolean);
  public
    { Public �錾 }
    constructor Create(AOwner: TComponent; b: TBand); reintroduce;
    procedure AddSelfSpot(strCallsign: string; strNrRcvd: string; b: TBand; m: TMode; Hz: TFrequency);
    procedure AddSelfSpotFromNetwork(BSText : string);
    procedure AddClusterSpot(Sp: TSpot);
    procedure RewriteBandScope();
    procedure RewriteBandScope1();
    procedure RewriteBandScope2();
    procedure MarkCurrentFreq(Hz: TFrequency);
    procedure NotifyWorked(aQSO: TQSO);
    procedure CopyList(F: TBandScope2);
    procedure SetSpotWorked(aQSO: TQSO);
    procedure JudgeEstimatedMode();
    procedure SaveSettings(ini: TMemIniFile; section: string);
    procedure LoadSettings(ini: TMemIniFile; section: string);
    procedure Suspend();
    procedure Resume();
    procedure RenewTab();

    property FontSize: Integer read GetFontSize write SetFontSize;
    property DisplayMode: TBSDisplayMode read GetDisplayMode write SetDisplayMode;
    property Select: Boolean write SetSelect;
    property FreshnessType: Integer read FFreshnessType write SetFreshnessType;
    property IconType: Integer read FIconType write SetIconType;
    property CurrentBand: TBand read FCurrBand write SetCurrentBand;
    property UseResume: Boolean read FUseResume write FUseResume;
    property Style: TBandScopeStyle read FBandScopeStyle write SetBandScopeStyle;
  end;

  TBandScopeArray = array[b19..b10g] of TBandScope2;

var
  CurrentRigFrequency : TFrequency; // in Hertz

implementation

uses
  UOptions, Main, UZLinkForm, URigControl, UzLogKeyer;

{$R *.dfm}

constructor TBandScope2.Create(AOwner: TComponent; b: TBand);
begin
   Inherited Create(AOwner);
   Grid.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
   FBandScopeStyle := bssByBand;
   FSelectFlag := False;
   FCurrBand := b;
   FSortOrder := 0;
   SetCaption();
   FreshnessType := dmZLogGlobal.Settings._bandscope_freshness_mode;
   IconType := dmZLogGlobal.Settings._bandscope_freshness_icon;
   buttonShowWorked.Down := True;
   FUseResume := False;
   FResumeFile := '';

   RenewTab();
end;

procedure TBandScope2.AddBSList(D: TBSData);
var
   i: Integer;
   fFound: Boolean;
begin
   Lock();
   try
      if FBSList.Count = 0 then begin
         FBSList.Add(D);
         Exit;
      end;

      i := FBSList.BinarySearch(TBSSortMethod(FSortOrder), D, fFound);
      if fFound = False then begin
         FBSList.Insert(i, D);
      end
      else begin
         FBSList[i].ReportedBy := D.ReportedBy;
         FBSList[i].ReliableSpotter := D.ReliableSpotter;
         FBSList[i].Time := D.Time;
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
procedure TBandScope2.AddSelfSpot(strCallsign: string; strNrRcvd: string; b: TBand; m: TMode; Hz: TFrequency);
var
   D: TBSData;
begin
   // ���̃E�C���h�E�̃o���h�ł͖����ꍇ
   if (FBandScopeStyle = bssByBand) and (FCurrBand <> b) then begin
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

   // ���̃E�C���h�E�̃o���h�ł͖����ꍇ
   if (FBandScopeStyle = bssByBand) and (D.Band <> FCurrBand) then begin
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
   if (FBandScopeStyle = bssByBand) and (FCurrBand <> Sp.Band) then begin
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
   D.LookupFailed := Sp.LookupFailed;
   D.ReliableSpotter := Sp.ReliableSpotter;
   AddAndDisplay(D);
end;

procedure TBandScope2.Timer1Timer(Sender: TObject);
begin
   Timer1.Enabled := False;
   try
      RewriteBandScope();
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

            if (FBandScopeStyle = bssNewMulti) and (BS.IsNewMulti = False) then begin
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
begin
   if (FBandScopeStyle in [bssCurrentBand, bssAllBands, bssByBand]) and
      (FSortOrder <= 1) and
      (dmZLogGlobal.BandPlan.FreqToBand(CurrentRigFrequency) = FCurrBand) and
      (FDisplayMode = bsFreqCenter) then begin
      RewriteBandScope2();
   end
   else begin
      RewriteBandScope1();
   end;
end;

procedure TBandScope2.RewriteBandScope1();
var
   D: TBSData;
   i: Integer;
   R: Integer;
   estimated_R: Integer;
   toprow: Integer;
   currow: Integer;
   markrow: Integer;
   str: string;
   MarkCurrent: Boolean;
   Marked: Boolean;
   fOnFreq: Boolean;
begin
   if FProcessing = True then begin
      Exit;
   end;

   FProcessing := True;
   Grid.BeginUpdate();
   try
   try
      toprow := Grid.TopRow;
      currow := Grid.Row;
      markrow := -1;

      // ���g���}�[�J�[�̗L������
      if (FBandScopeStyle in [bssCurrentBand, bssAllBands, bssByBand]) and
         (FSortOrder <= 1) and
         (dmZLogGlobal.BandPlan.FreqToBand(CurrentRigFrequency) = FCurrBand) then begin
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

      // �S���N���A
      for i := 0 to Grid.RowCount - 1 do begin
         Grid.Objects[0, i] := nil;
      end;

      // �s���Đݒ�
      Grid.RowCount := R;
      estimated_R := R;

      // �擪�s�͕K���N���A����
      Grid.Cells[0, 0] := '';

      Marked := False;

      Lock();
      try
         R := 0;
         for i := 0 to FBSList.Count - 1 do begin
            D := FBSList[i];

            if IsShowData(D) = False then begin
               Continue;
            end;

            fOnFreq := False;

            if MarkCurrent and Not(Marked) then begin
               if D.FreqHz = CurrentRigFrequency then begin
                  Marked := True;
                  markrow := R;
                  fOnFreq :=True;
               end
               else if D.FreqHz > CurrentRigFrequency then begin
                  Grid.Cells[0, R] := '>>' + kHzStr(CurrentRigFrequency);
                  Grid.Objects[0, R] := nil;
                  Marked := True;
                  markrow := R;
                  Inc(R);
               end;
            end;

            str := FormatSpotInfo(D);

            if (fOnFreq = True) or
               ((FShowAllBands = True) and (D.Band = CurrentQSO.Band)) then begin
               str := '>>' + str + '<<';
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
         Inc(R);
      end;

      // �\��s���Ǝ��ۂ̍s�����Ⴆ�΍Đݒ�
      if estimated_R <> R then begin
         Grid.RowCount := R;
      end;

      if FDisplayMode = bsSyncVFO then begin
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
         dmZLogGlobal.WriteErrorLog('TBandScope2.RewriteBandScope1()');
         dmZLogGlobal.WriteErrorLog(E.Message);
         dmZLogGlobal.WriteErrorLog(E.StackTrace);
      end;
   end;
   finally
      Grid.EndUpdate();
      FProcessing := False;
   end;
end;

procedure TBandScope2.RewriteBandScope2();
var
   D: TBSData;
   i: Integer;
   R: Integer;
   str: string;
   Index: Integer;
   FreqDispIndex: Integer;
   fFound: Boolean;
   DataIndex: Integer;
   up_offset: Integer;
   down_offset: Integer;
begin
   if FProcessing = True then begin
      Exit;
   end;

   FProcessing := True;
   Grid.BeginUpdate();
   try
   try
      if FBSList.Count = 0 then begin
         Exit;
      end;

      // ����100�s�Ƃ���
      Grid.RowCount := 100;

      // �S���N���A
      for i := 0 to Grid.RowCount - 1 do begin
         Grid.Objects[0, i] := nil;
      end;

      // �\���\�ȍs���ɕύX
      Grid.RowCount := Grid.VisibleRowCount;

      Lock();
      try
         // ���g���̕`��ʒu  VisibleRowCount�̐^��
         FreqDispIndex := (Grid.VisibleRowCount div 2);

         // ���g�����ɕ��ёւ�
         FBSList.Sort(soBsFreqAsc);

         // ���ݎ��g���̈ʒu�ɂ���X�|�b�g�����߂�
         D := TBSData.Create();
         D.FreqHz := CurrentRigFrequency;
         Index := FBSList.BinarySearch(soBsFreqAsc, D, fFound);
         D.Free();

         if fFound = True then begin   // ������
            R := FreqDispIndex;
            D := FBSList[Index];
            str := FormatSpotInfo(D);
            str := '>>' + str + '<<';
            Grid.Cells[0, R] := str;
            Grid.Objects[0, R] := D;
            up_offset := 1;
            down_offset := 1;
         end
         else begin  // �Ȃ�����
            R := FreqDispIndex;
            Grid.Cells[0, R] := '>>' + kHzStr(CurrentRigFrequency);
            Grid.Objects[0, R] := nil;
            up_offset := 1;
            down_offset := 0;
         end;

         // ���g������
         DataIndex := Index - up_offset;
         for R := FreqDispIndex - 1 downto 0 do begin
            if (DataIndex >= 0) and (FBSList.Count > DataIndex) then begin
               D := FBSList[DataIndex];

               if IsShowData(D) = True then begin
                  str := FormatSpotInfo(D);
                  Grid.Cells[0, R] := str;
                  Grid.Objects[0, R] := D;
               end
               else begin
                  Grid.Cells[0, R] := '';
                  Grid.Objects[0, R] := nil;
               end;
            end
            else begin
               Grid.Cells[0, R] := '';
               Grid.Objects[0, R] := nil;
            end;

            Dec(DataIndex);
         end;

         // ���g����艺
         DataIndex := Index + down_offset;
         for R := FreqDispIndex + 1 to (Grid.VisibleRowCount - 1) do begin
            if (DataIndex >= 0) and (FBSList.Count > DataIndex) then begin
               D := FBSList[DataIndex];

               if IsShowData(D) = True then begin
                  str := FormatSpotInfo(D);
                  Grid.Cells[0, R] := str;
                  Grid.Objects[0, R] := D;
               end
               else begin
                  Grid.Cells[0, R] := '';
                  Grid.Objects[0, R] := nil;
               end;
            end
            else begin
               Grid.Cells[0, R] := '';
               Grid.Objects[0, R] := nil;
            end;

            Inc(DataIndex);
         end;
      finally
         Unlock();
      end;

   except
      on E: Exception do begin
         dmZLogGlobal.WriteErrorLog('TBandScope2.RewriteBandScope2()');
         dmZLogGlobal.WriteErrorLog(E.Message);
         dmZLogGlobal.WriteErrorLog(E.StackTrace);
      end;
   end;
   finally
      Grid.EndUpdate();
      FProcessing := False;
   end;
end;

function TBandScope2.IsShowData(D: TBSData): Boolean;
begin
   // Worked�̗L���Ŕ���
   if (FBandScopeStyle in [bssCurrentBand, bssAllBands, bssByBand]) and
      (buttonShowWorked.Down = False) and (D.Worked = True) then begin
      Result := False;
      Exit;
   end;

   // �S�o���h�\������
   if {(FNewMultiOnly = False) and} (FCurrBand <> D.Band) and (FShowAllBands = False) then begin
      Result := False;
      Exit;
   end;

   Result := True;
end;

function TBandScope2.FormatSpotInfo(D: TBSData): string;
var
   str: string;
begin
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

   Result := str;
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
         if (FCurrBand <> D.Band) and (FShowAllBands = False) then begin
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

procedure TBandScope2.menuAddToDenyListClick(Sender: TObject);
var
   i: Integer;
   D: TBSData;
begin
   if Grid.Selection.Top < 0 then begin
      Exit;
   end;

   for i := Grid.Selection.Top to Grid.Selection.Bottom do begin
      D := TBSData(Grid.Objects[0, i]);
      MainForm.CommForm.DenyList.Add(D.ReportedBy);
   end;
end;

procedure TBandScope2.menuDeleteSpotClick(Sender: TObject);
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
            if pos(FBSList[j].LabelStr, s) > 0 then begin
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

procedure TBandScope2.MarkCurrentFreq(Hz: TFrequency);
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

procedure TBandScope2.menuDeleteAllWorkedStationsClick(Sender: TObject);
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
   MainForm.DelTaskbar(Handle);
end;

procedure TBandScope2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE: begin
         MainForm.SetLastFocus();
      end;
   end;
end;

procedure TBandScope2.FormResize(Sender: TObject);
begin
   Grid.ColWidths[0] := Grid.Width - 4;
end;

procedure TBandScope2.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);
   ApplyShortcut();
   Timer1.Enabled := True;
end;

procedure TBandScope2.FormActivate(Sender: TObject);
begin
   ActionList1.State := asNormal;
end;

procedure TBandScope2.FormDeactivate(Sender: TObject);
begin
   ActionList1.State := asSuspended;
end;

procedure TBandScope2.GridContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
   C, R: Integer;
begin
   // �E�N���b�N���ꂽ�ꏊ�̃X�|�b�g��I��
   Grid.MouseToCell(MousePos.X, MousePos.Y, C, R);
   if (R = -1) or (C = -1) then begin
      Exit;
   end;

   Grid.Row := R;
   Grid.Col := C;

   // �E�N���b�N���ꂽ�ꏊ�Ƀ��j���[��\��
   MousePos := Grid.ClientToScreen(MousePos);
   BSMenu.Popup(MousePos.X, MousePos.Y);

   Handled := True;
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

      D := TBSData(Grid.Objects[0, ARow]);
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
            fNewMulti := D.IsNewMulti;
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
               Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[5].FBackColor;
            end;

            ssCluster: begin
               if FBandScopeStyle = bssAllBands then begin
                  if D.Band = CurrentQSO.Band then begin
                     Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[11].FBackColor;
                  end
                  else begin
                     Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[6].FBackColor;
                  end;
               end
               else begin
                  Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[6].FBackColor;
               end;
            end;

            ssClusterFromZServer: begin
               case D.SpotGroup of
                  1: Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[7].FBackColor;
                  2: Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[8].FBackColor;
                  3: Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[9].FBackColor;
                  else Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[7].FBackColor;
               end;
            end;

            else begin
               Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[5].FBackColor;
            end;
         end;

         if D.LookupFailed = True then begin
            Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[10].FBackColor;
         end;

         if D.ReliableSpotter = False then begin
            Brush.Color  := dmZLogGlobal.Settings._bandscopecolor[12].FBackColor;
         end;

         if D.Bold then begin
            Font.Style := Font.Style + [fsBold];
         end
         else begin
            Font.Style := Font.Style - [fsBold];
         end;

         if D.Mode = mOther then begin
            Font.Color := AdjustDark(Font.Color);
            Brush.Color := AdjustDark(Brush.Color);
         end;

         {$IFDEF DEBUG}
//         strText := strText + ' (' + IntToStr(sec) + ')';
         if D.Mode <= mOther then begin
            strText := strText + ' (' + ModeString[D.Mode][1] + ')';
         end;
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
   strText := '';
   try
      pt.X := X;
      pt.Y := Y;
      pt := Grid.ClientToScreen(pt);

      Grid.MouseToCell(X, Y, C, R);
      if (C = -1) or (R = -1) then begin
         Application.CancelHint();
         Grid.Hint := '';
         Exit;
      end;

      D := TBSData(Grid.Objects[0, R]);
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
   except
      on E: Exception do begin
         dmZLogGlobal.WriteErrorLog('TBandScope2.GridMouseMove()');
         dmZLogGlobal.WriteErrorLog(strText);
         dmZLogGlobal.WriteErrorLog(E.Message);
         dmZLogGlobal.WriteErrorLog(E.StackTrace);
      end;
   end;
end;

procedure TBandScope2.GridMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
   font_size: Integer;
begin
   // CTRL+UP�Ńt�H���g�T�C�YDOWN
   if GetAsyncKeyState(VK_CONTROL) < 0 then begin
      font_size := FontSize;
      Dec(font_size);
      if font_size < 6 then begin
         font_size := 6;
      end;
      FontSize := font_size;

      // �����SHIFT�L�[�������Ă���Ƒ���BandScope���ύX����
      if GetAsyncKeyState(VK_SHIFT) < 0 then begin
         ApplyFontSize(font_size);
      end;

      Grid.Refresh();
      Handled := True;
   end;
end;

procedure TBandScope2.GridMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
   font_size: Integer;
begin
   // CTRL+UP�Ńt�H���g�T�C�YUP
   if GetAsyncKeyState(VK_CONTROL) < 0 then begin
      font_size := FontSize;
      Inc(font_size);
      if font_size > 28 then begin
         font_size := 28;
      end;
      FontSize := font_size;
      Grid.Refresh();

      // �����SHIFT�L�[�������Ă���Ƒ���BandScope���ύX����
      if GetAsyncKeyState(VK_SHIFT) < 0 then begin
         ApplyFontSize(font_size);
      end;

      Handled := True;
   end;
end;

procedure TBandScope2.tabctrlBandSelectorChange(Sender: TObject);
var
   b: TBand;
   i: Integer;
   D: TBSData;
begin
   b := TabIndexToBand(tabctrlBandSelector.TabIndex);

   if tabctrlBandSelector.TabIndex = 0 then begin
      FShowAllBands := True;
      RewriteBandScope();
   end
   else begin
      FShowAllBands := False;
      CurrentBand := b;
   end;
end;

procedure TBandScope2.tabctrlBandSelectorChanging(Sender: TObject; var AllowChange: Boolean);
begin
   if FSortOrder <= 1 then begin
      SetDisplayModeState(True);
   end
   else begin
      SetDisplayModeState(False);
   end;

   AllowChange := True;
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

function TBandScope2.GetDisplayMode(): TBSDisplayMode;
begin
   if (buttonNormalMode.Down = True) then begin
      Result := bsNormal;
   end
   else if (buttonSyncVfo.Down = True) then begin
      Result := bsSyncVFO;
   end
   else begin
      Result := bsFreqCenter;
   end;
end;

procedure TBandScope2.SetDisplayMode(v: TBSDisplayMode);
begin
   FDisplayMode := v;
   case v of
      bsNormal: buttonNormalMode.Down := True;
      bsSyncVFO: buttonSyncVfo.Down := True;
      bsFreqCenter: buttonFreqCenter.Down := True;
      else buttonNormalMode.Down := True;
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
         SpotCheckWorked(D, True);

         if (FBandScopeStyle = bssNewMulti) then begin
            if (D.IsNewMulti = False) then begin
               FBSList[i] := nil;
            end;
            if (aQSO <> nil) and (D.Call = aQSO.Callsign) and (D.Band = aQSO.Band) then begin
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

   FCurrBand := b;
   SetCaption();

   tabctrlBandSelector.TabIndex := BandToTabIndex(b);
   FShowAllBands := False;

   RewriteBandScope();
end;

procedure TBandScope2.SetBandScopeStyle(style: TBandScopeStyle);
begin
   FBandScopeStyle := style;
   SetCaption();
   SetColor();

   // �W���I�v�V����
   if style in [bssCurrentBand, bssAllBands, bssByBand] then begin
      panelStandardOption.Visible := True;
   end
   else begin
      panelStandardOption.Visible := False;
   end;

   // �^�u��L����
   if style in [bssCurrentBand, bssAllBands, bssNewMulti] then begin
      Panel1.Parent := tabctrlBandSelector;
      tabctrlBandSelector.Visible := True;
      tabctrlBandSelector.TabIndex := 0;
      FShowAllBands := True;
   end
   else begin
      Panel1.Parent := Self;
      tabctrlBandSelector.Visible := False;
      tabctrlBandSelector.TabIndex := 0;
      FShowAllBands := False;
   end;

   // �S�o���h�p�I�v�V����
   panelAllBandsOption.Visible := True;
   buttonSortByFreq.ImageIndex := 0;
   FSortOrder := 0;
end;

procedure TBandScope2.SetCaption();
begin
   case FBandScopeStyle of
      bssCurrentBand: begin
         Caption := '[Current] ' + BandString[FCurrBand];
      end;

      bssAllBands: begin
         Caption := '[All bands]';
      end;

      bssNewMulti: begin
         Caption := '[New multi]';
      end;

      else begin
         if FCurrBand <> bUnknown then begin
            Caption := BandString[FCurrBand];
         end;
      end;
   end
end;

procedure TBandScope2.SetColor();
begin
   case FBandScopeStyle of
      bssAllBands: begin
         Panel1.Color := clAqua;
      end;

      bssNewMulti: begin
         Panel1.Color := dmZLogGlobal.Settings._bandscopecolor[2].FForeColor;
      end;

      else begin
         if FSelectFlag = True then begin
            Panel1.Color := clBlue;
         end
         else begin
            Panel1.Color := clGray;
         end;
      end;
   end
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

            if FBandScopeStyle = bssNewMulti then begin
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

procedure TBandScope2.JudgeEstimatedMode();
var
   i: Integer;
   S: TBaseSpot;
   bandplan: TBandPlan;
begin
   Lock();
   try
      bandplan := dmZLogGlobal.BandPlan;
      for i := 0 to FBSList.Count - 1 do begin
         S := TBaseSpot(FBSList[i]);
         S.Mode := bandplan.GetEstimatedMode(S.Band, S.FreqHz);
      end;
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

procedure TBandScope2.buttonShowWorkedClick(Sender: TObject);
begin
   FDisplayMode := GetDisplayMode();
   RewriteBandScope();
end;

procedure TBandScope2.buttonSortByFreqClick(Sender: TObject);
var
   Index: Integer;
begin
   Index := buttonSortByFreq.ImageIndex;
   if Index = -1 then begin
      Index := 0;
      buttonSortByTime.ImageIndex := -1;
      FSortOrder := 0;
   end
   else begin
      Inc(Index);
      Index := Index and 1;
      FSortOrder := Index;
   end;
   buttonSortByFreq.ImageIndex := Index;
   Lock();
   FBSList.Sort(TBSSortMethod(FSortOrder));
   Unlock();

   SetDisplayModeState(True);
   RewriteBandScope();
end;

procedure TBandScope2.buttonSortByTimeClick(Sender: TObject);
var
   Index: Integer;
begin
   Index := buttonSortByTime.ImageIndex;
   if Index = -1 then begin
      Index := 0;
      buttonSortByFreq.ImageIndex := -1;
      FSortOrder := 2;
   end
   else begin
      Inc(Index);
      Index := Index and 1;
      FSortOrder := Index + 2;
   end;
   buttonSortByTime.ImageIndex := Index;
   Lock();
   FBSList.Sort(TBSSortMethod(FSortOrder));
   Unlock();

   SetDisplayModeState(False);
   RewriteBandScope();
end;

procedure TBandScope2.actionPlayMessageAExecute(Sender: TObject);
var
   no: Integer;
begin
   no := TAction(Sender).Tag;
   SendMessage(MainForm.Handle, WM_ZLOG_PLAYMESSAGEA, no, 0);
end;

procedure TBandScope2.actionPlayMessageBExecute(Sender: TObject);
var
   no: Integer;
begin
   no := TAction(Sender).Tag;
   SendMessage(MainForm.Handle, WM_ZLOG_PLAYMESSAGEB, no, 0);
end;

procedure TBandScope2.actionIncreaseCwSpeedExecute(Sender: TObject);
begin
   dmZLogKeyer.IncCWSpeed();
end;

procedure TBandScope2.actionDecreaseCwSpeedExecute(Sender: TObject);
begin
   dmZLogKeyer.DecCWSpeed();
end;

procedure TBandScope2.ApplyShortcut();
begin
   actionPlayMessageA01.ShortCut := MainForm.actionPlayMessageA01.ShortCut;
   actionPlayMessageA02.ShortCut := MainForm.actionPlayMessageA02.ShortCut;
   actionPlayMessageA03.ShortCut := MainForm.actionPlayMessageA03.ShortCut;
   actionPlayMessageA04.ShortCut := MainForm.actionPlayMessageA04.ShortCut;
   actionPlayMessageA05.ShortCut := MainForm.actionPlayMessageA05.ShortCut;
   actionPlayMessageA06.ShortCut := MainForm.actionPlayMessageA06.ShortCut;
   actionPlayMessageA07.ShortCut := MainForm.actionPlayMessageA07.ShortCut;
   actionPlayMessageA08.ShortCut := MainForm.actionPlayMessageA08.ShortCut;
   actionPlayMessageA09.ShortCut := MainForm.actionPlayMessageA09.ShortCut;
   actionPlayMessageA10.ShortCut := MainForm.actionPlayMessageA10.ShortCut;
   actionPlayMessageA11.ShortCut := MainForm.actionPlayMessageA11.ShortCut;
   actionPlayMessageA12.ShortCut := MainForm.actionPlayMessageA12.ShortCut;

   actionPlayMessageB01.ShortCut := MainForm.actionPlayMessageB01.ShortCut;
   actionPlayMessageB02.ShortCut := MainForm.actionPlayMessageB02.ShortCut;
   actionPlayMessageB03.ShortCut := MainForm.actionPlayMessageB03.ShortCut;
   actionPlayMessageB04.ShortCut := MainForm.actionPlayMessageB04.ShortCut;
   actionPlayMessageB05.ShortCut := MainForm.actionPlayMessageB05.ShortCut;
   actionPlayMessageB06.ShortCut := MainForm.actionPlayMessageB06.ShortCut;
   actionPlayMessageB07.ShortCut := MainForm.actionPlayMessageB07.ShortCut;
   actionPlayMessageB08.ShortCut := MainForm.actionPlayMessageB08.ShortCut;
   actionPlayMessageB09.ShortCut := MainForm.actionPlayMessageB09.ShortCut;
   actionPlayMessageB10.ShortCut := MainForm.actionPlayMessageB10.ShortCut;
   actionPlayMessageB11.ShortCut := MainForm.actionPlayMessageB11.ShortCut;
   actionPlayMessageB12.ShortCut := MainForm.actionPlayMessageB12.ShortCut;

   actionPlayCQA1.ShortCut := MainForm.actionPlayCQA1.ShortCut;
   actionPlayCQA2.ShortCut := MainForm.actionPlayCQA2.ShortCut;
   actionPlayCQA3.ShortCut := MainForm.actionPlayCQA3.ShortCut;
   actionPlayCQB1.ShortCut := MainForm.actionPlayCQB1.ShortCut;
   actionPlayCQB2.ShortCut := MainForm.actionPlayCQB2.ShortCut;
   actionPlayCQB3.ShortCut := MainForm.actionPlayCQB3.ShortCut;

   actionDecreaseCwSpeed.ShortCut := MainForm.actionDecreaseCwSpeed.ShortCut;
   actionIncreaseCwSpeed.ShortCut := MainForm.actionIncreaseCwSpeed.ShortCut;

   actionPlayMessageA01.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA01.SecondaryShortCuts);
   actionPlayMessageA02.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA02.SecondaryShortCuts);
   actionPlayMessageA03.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA03.SecondaryShortCuts);
   actionPlayMessageA04.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA04.SecondaryShortCuts);
   actionPlayMessageA05.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA05.SecondaryShortCuts);
   actionPlayMessageA06.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA06.SecondaryShortCuts);
   actionPlayMessageA07.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA07.SecondaryShortCuts);
   actionPlayMessageA08.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA08.SecondaryShortCuts);
   actionPlayMessageA09.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA09.SecondaryShortCuts);
   actionPlayMessageA10.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA10.SecondaryShortCuts);
   actionPlayMessageA11.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA11.SecondaryShortCuts);
   actionPlayMessageA12.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA12.SecondaryShortCuts);

   actionPlayMessageB01.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB01.SecondaryShortCuts);
   actionPlayMessageB02.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB02.SecondaryShortCuts);
   actionPlayMessageB03.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB03.SecondaryShortCuts);
   actionPlayMessageB04.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB04.SecondaryShortCuts);
   actionPlayMessageB05.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB05.SecondaryShortCuts);
   actionPlayMessageB06.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB06.SecondaryShortCuts);
   actionPlayMessageB07.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB07.SecondaryShortCuts);
   actionPlayMessageB08.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB08.SecondaryShortCuts);
   actionPlayMessageB09.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB09.SecondaryShortCuts);
   actionPlayMessageB10.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB10.SecondaryShortCuts);
   actionPlayMessageB11.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB11.SecondaryShortCuts);
   actionPlayMessageB12.SecondaryShortCuts.Assign(MainForm.actionPlayMessageB12.SecondaryShortCuts);

   actionPlayCQA2.SecondaryShortCuts.Assign(MainForm.actionPlayCQA2.SecondaryShortCuts);
   actionPlayCQA3.SecondaryShortCuts.Assign(MainForm.actionPlayCQA3.SecondaryShortCuts);
   actionPlayCQB2.SecondaryShortCuts.Assign(MainForm.actionPlayCQB2.SecondaryShortCuts);
   actionPlayCQB3.SecondaryShortCuts.Assign(MainForm.actionPlayCQB3.SecondaryShortCuts);

   actionDecreaseCwSpeed.SecondaryShortCuts.Assign(MainForm.actionDecreaseCwSpeed.SecondaryShortCuts);
   actionIncreaseCwSpeed.SecondaryShortCuts.Assign(MainForm.actionIncreaseCwSpeed.SecondaryShortCuts);
end;

procedure TBandScope2.SaveSettings(ini: TMemIniFile; section: string);
begin
   dmZLogGlobal.WriteWindowState(ini, Self, section);
   ini.WriteInteger(section, 'FontSize', FontSize);

   case FDisplayMode of
      bsNormal: begin
         ini.WriteBool(section, 'SyncVFO', False);
         ini.WriteBool(section, 'FreqCenter', False);
      end;

      bsSyncVFO: begin
         ini.WriteBool(section, 'SyncVFO', True);
         ini.WriteBool(section, 'FreqCenter', False);
      end;

      bsFreqCenter: begin
         ini.WriteBool(section, 'SyncVFO', False);
         ini.WriteBool(section, 'FreqCenter', True);
      end;
   end;

   ini.WriteBool(section, 'ShowWorked', buttonShowWorked.Down);
   ini.WriteInteger(section, 'FreqSortOrder', buttonSortByFreq.ImageIndex);
   ini.WriteInteger(section, 'TimeSortOrder', buttonSortByTime.ImageIndex);
end;

procedure TBandScope2.LoadSettings(ini: TMemIniFile; section: string);
var
   fSyncVfo: Boolean;
   fFreqCenter: Boolean;
begin
   dmZLogGlobal.ReadWindowState(ini, Self, section);
   FontSize := ini.ReadInteger(section, 'FontSize', 9);

   fSyncVfo := ini.ReadBool(section, 'SyncVFO', True);
   fFreqCenter := ini.ReadBool(section, 'FreqCenter', False);

   if (fSyncVfo = False) and (fFreqCenter = False) then begin
      DisplayMode := bsNormal;
   end
   else if (fSyncVfo = True) and (fFreqCenter = False) then begin
      DisplayMode := bsSyncVFO;
   end
   else begin
      DisplayMode := bsFreqCenter;
   end;

   buttonShowWorked.Down := ini.ReadBool(section, 'ShowWorked', True);
   buttonSortByFreq.ImageIndex := ini.ReadInteger(section, 'FreqSortOrder', 0);
   buttonSortByTime.ImageIndex := ini.ReadInteger(section, 'TimeSortOrder', -1);
end;

procedure TBandScope2.ApplyFontSize(font_size: Integer);
var
   i: Integer;
begin
   for i := 0 to (Screen.FormCount - 1) do begin
      if Screen.Forms[i] is TBandScope2 then begin
         if Screen.Forms[i] <> Self then begin
            TBandScope2(Screen.Forms[i]).FontSize := font_size;
         end;
      end;
   end;
end;

procedure TBandScope2.Suspend();
begin
   if (FUseResume = True) and (FResumeFile <> '') then begin
      FBSList.SaveToFile(FResumeFile);
   end;
end;

procedure TBandScope2.Resume();
begin
   if FUseResume = True then begin
      case FBandScopeStyle of
         bssAllBands:      FResumeFile := ExtractFilePath(Application.ExeName) + 'zlog_bandscope_allbands.txt';
         bssNewMulti:      FResumeFile := ExtractFilePath(Application.ExeName) + 'zlog_bandscope_newmulti.txt';
         bssCurrentBand:   FResumeFile := ExtractFilePath(Application.ExeName) + 'zlog_bandscope_currentband.txt';
         else              FResumeFile := ExtractFilePath(Application.ExeName) + 'zlog_bandscope_' + ADIFBandString[FCurrBand] + '.txt';
      end;

      if FileExists(FResumeFile) then begin
         FBSList.LoadFromFile(FResumeFile);
      end;
   end;
end;

procedure TBandScope2.RenewTab();
var
   b: TBand;
begin
   tabctrlBandSelector.Tabs.Clear();
   tabctrlBandSelector.Tabs.Add('ALL');
   for b := b19 to b10g do begin
      if dmZLogGlobal.Settings._usebandscope[b] = True then begin
         tabctrlBandSelector.Tabs.Add(MHzString[b]);
      end;
   end;
end;

function TBandScope2.BandToTabIndex(b: TBand): Integer;
var
   S: string;
begin
   S := MHzString[b];
   Result := tabctrlBandSelector.Tabs.IndexOf(S);
end;

function TBandScope2.TabIndexToBand(TabIndex: Integer): TBand;
var
   S: string;
   b: TBand;
begin
   S := tabctrlBandSelector.Tabs[TabIndex];

   for b := b19 to b10g do begin
      if MHzString[b] = S then begin
         Result := b;
         Exit;
      end;
   end;

   Result := bUnknown;
end;

procedure TBandScope2.SetDisplayModeState(fEnable: Boolean);
begin
   buttonNormalMode.Enabled := fEnable;
   buttonSyncVfo.Enabled := fEnable;
   buttonFreqCenter.Enabled := fEnable;
end;

initialization
   CurrentRigFrequency := 0;

end.
