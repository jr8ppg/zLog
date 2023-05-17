unit UEditDialog;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Menus, System.Actions, Vcl.ActnList,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogCW, UzLogKeyer, Vcl.ComCtrls;

const _ActInsert = 0;
      _ActChange = 1;

type
  TEditDialog = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    BandMenu: TPopupMenu;
    ModeMenu: TPopupMenu;
    OpMenu: TPopupMenu;
    NewPowerMenu: TPopupMenu;
    ActionList1: TActionList;
    actionPlayMessageA01: TAction;
    actionPlayMessageA02: TAction;
    actionPlayMessageA03: TAction;
    actionPlayMessageA04: TAction;
    actionPlayMessageA05: TAction;
    actionPlayMessageA06: TAction;
    actionPlayMessageA07: TAction;
    actionPlayMessageA08: TAction;
    actionShowCheckPartial: TAction;
    actionPlayMessageA11: TAction;
    actionPlayMessageA12: TAction;
    actionClearCallAndRpt: TAction;
    actionDecreaseTime: TAction;
    actionIncreaseTime: TAction;
    actionReversePaddle: TAction;
    actionFieldClear: TAction;
    actionCQRepeat: TAction;
    actionFocusCallsign: TAction;
    actionFocusMemo: TAction;
    actionFocusNumber: TAction;
    actionFocusOp: TAction;
    actionFocusRst: TAction;
    actionToggleRig: TAction;
    actionControlPTT: TAction;
    actionChangeBand: TAction;
    actionChangeMode: TAction;
    actionChangePower: TAction;
    actionChangeR: TAction;
    actionChangeS: TAction;
    actionSetCurTime: TAction;
    actionDecreaseCwSpeed: TAction;
    actionIncreaseCwSpeed: TAction;
    actionCQRepeat2: TAction;
    actionToggleVFO: TAction;
    actionQuickMemo1: TAction;
    actionQuickMemo2: TAction;
    actionQuickMemo3: TAction;
    actionQuickMemo4: TAction;
    actionQuickMemo5: TAction;
    actionPlayMessageA09: TAction;
    actionPlayMessageA10: TAction;
    actionPlayCQA2: TAction;
    actionPlayCQA3: TAction;
    actionToggleRX: TAction;
    actionToggleTX: TAction;
    actionSo2rToggleRigPair: TAction;
    GroupBox1: TGroupBox;
    radioQslNone: TRadioButton;
    radioPseQsl: TRadioButton;
    radioNoQsl: TRadioButton;
    GroupBox2: TGroupBox;
    checkCQ: TCheckBox;
    checkDupe: TCheckBox;
    checkQsyViolation: TCheckBox;
    checkForced: TCheckBox;
    GroupBox3: TGroupBox;
    editFrequency: TEdit;
    GroupBox4: TGroupBox;
    comboTxNo: TComboBox;
    TxLabel: TLabel;
    editPCName: TEdit;
    Label1: TLabel;
    Panel2: TPanel;
    groupQsoData: TGroupBox;
    SerialLabel: TLabel;
    TimeLabel: TLabel;
    rcvdRSTLabel: TLabel;
    CallsignLabel: TLabel;
    PointLabel: TLabel;
    BandLabel: TLabel;
    NumberLabel: TLabel;
    ModeLabel: TLabel;
    PowerLabel: TLabel;
    OpLabel: TLabel;
    MemoLabel: TLabel;
    Label2: TLabel;
    CallsignEdit: TEdit;
    RcvdRSTEdit: TEdit;
    NumberEdit: TEdit;
    BandEdit: TEdit;
    ModeEdit: TEdit;
    MemoEdit: TEdit;
    PointEdit: TEdit;
    OpEdit: TEdit;
    SerialEdit: TEdit;
    NewPowerEdit: TEdit;
    checkInvalid: TCheckBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    actionChangeBand2: TAction;
    actionChangeMode2: TAction;
    actionChangePower2: TAction;
    actionPlayCQA1: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure NumberEditKeyPress(Sender: TObject; var Key: Char);
    procedure BandEditClick(Sender: TObject);
    procedure OpMenuClick(Sender: TObject);
    procedure BandMenuClick(Sender: TObject);
    procedure ModeMenuClick(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NewPowerMenuClick(Sender: TObject);
    procedure NewPowerEditClick(Sender: TObject);
    procedure ModeEditClick(Sender: TObject);
    procedure OpEditClick(Sender: TObject);
    procedure actionPlayMessageAExecute(Sender: TObject);
    procedure actionShowCheckPartialExecute(Sender: TObject);
    procedure actionClearCallAndRptExecute(Sender: TObject);
    procedure actionDecreaseTimeExecute(Sender: TObject);
    procedure actionIncreaseTimeExecute(Sender: TObject);
    procedure actionReversePaddleExecute(Sender: TObject);
    procedure actionFieldClearExecute(Sender: TObject);
    procedure actionCQRepeatExecute(Sender: TObject);
    procedure actionFocusCallsignExecute(Sender: TObject);
    procedure actionFocusMemoExecute(Sender: TObject);
    procedure actionFocusNumberExecute(Sender: TObject);
    procedure actionFocusOpExecute(Sender: TObject);
    procedure actionFocusRstExecute(Sender: TObject);
    procedure actionToggleRigExecute(Sender: TObject);
    procedure actionControlPTTExecute(Sender: TObject);
    procedure actionChangeBandExecute(Sender: TObject);
    procedure actionChangeModeExecute(Sender: TObject);
    procedure actionChangePowerExecute(Sender: TObject);
    procedure actionChangeRExecute(Sender: TObject);
    procedure actionChangeSExecute(Sender: TObject);
    procedure actionSetCurTimeExecute(Sender: TObject);
    procedure actionDecreaseCwSpeedExecute(Sender: TObject);
    procedure actionIncreaseCwSpeedExecute(Sender: TObject);
    procedure actionCQRepeat2Execute(Sender: TObject);
    procedure actionToggleVFOExecute(Sender: TObject);
    procedure actionQuickMemo3Execute(Sender: TObject);
    procedure actionToggleRXExecute(Sender: TObject);
    procedure actionToggleTXExecute(Sender: TObject);
    procedure actionSo2rToggleRigPairExecute(Sender: TObject);
    procedure checkInvalidClick(Sender: TObject);
  private
    { Private declarations }
    workQSO : TQSO;
    origQSO : TQSO;
    Action : integer;
    procedure ChangePower(fUp: Boolean);
    procedure ApplyShortcut();
  public
    { Public declarations }
    procedure Init(aQSO : TQSO; Action_ : integer);
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TEditDialog.FormCreate(Sender: TObject);
var
   i: integer;
   M: TMenuItem;
begin
   workQSO := TQSO.Create;
   origQSO := TQSO.Create;

   if MainForm.OpMenu.Items.Count > 0 then begin
      for i := 0 to MainForm.OpMenu.Items.Count - 1 do begin
         M := TMenuItem.Create(Self);
         M.Caption := MainForm.OpMenu.Items[i].Caption;
         M.OnClick := OpMenuClick;
         M.Enabled := MainForm.OpMenu.Items[i].Enabled;
         M.Visible := MainForm.OpMenu.Items[i].Visible;
         M.Tag := MainForm.OpMenu.Items[i].Tag;
         OpMenu.Items.Add(M);
      end;
   end;

   for i := 0 to MainForm.BandMenu.Items.Count - 1 do begin
      M := TMenuItem.Create(Self);
      M.Caption := MainForm.BandMenu.Items[i].Caption;
      M.OnClick := BandMenuClick;
      M.Enabled := MainForm.BandMenu.Items[i].Enabled;
      M.Visible := MainForm.BandMenu.Items[i].Visible;
      M.Tag := MainForm.BandMenu.Items[i].Tag;
      BandMenu.Items.Add(M);
   end;

   for i := 0 to MainForm.ModeMenu.Items.Count - 1 do begin
      M := TMenuItem.Create(Self);
      M.Caption := MainForm.ModeMenu.Items[i].Caption;
      M.OnClick := ModeMenuClick;
      M.Enabled := MainForm.ModeMenu.Items[i].Enabled;
      M.Visible := MainForm.ModeMenu.Items[i].Visible;
      M.Tag := MainForm.ModeMenu.Items[i].Tag;
      ModeMenu.Items.Add(M);
   end;

   for i := 0 to MainForm.NewPowerMenu.Items.Count - 1 do begin
      M := TMenuItem.Create(Self);
      M.Caption := MainForm.NewPowerMenu.Items[i].Caption;
      M.OnClick := NewPowerMenuClick;
      M.Enabled := MainForm.NewPowerMenu.Items[i].Enabled;
      M.Visible := MainForm.NewPowerMenu.Items[i].Visible;
      M.Tag := MainForm.NewPowerMenu.Items[i].Tag;
      NewPowerMenu.Items.Add(M);
   end;

   ApplyShortcut();
end;

procedure TEditDialog.FormShow(Sender: TObject);
var
   i: integer;
   M: TMenuItem;
const
   offset = 3;
begin
   CallsignEdit.SetFocus;
   for i := 0 to MainForm.BandMenu.Items.Count - 1 do begin
      BandMenu.Items[i].Enabled := MainForm.BandMenu.Items[i].Enabled;
      BandMenu.Items[i].Visible := MainForm.BandMenu.Items[i].Visible;
   end;
   for i := 0 to MainForm.ModeMenu.Items.Count - 1 do begin
      ModeMenu.Items[i].Enabled := MainForm.ModeMenu.Items[i].Enabled;
      ModeMenu.Items[i].Visible := MainForm.ModeMenu.Items[i].Visible;
   end;
   for i := 0 to MainForm.NewPowerMenu.Items.Count - 1 do begin
      NewPowerMenu.Items[i].Enabled := MainForm.ModeMenu.Items[i].Enabled;
      NewPowerMenu.Items[i].Visible := MainForm.ModeMenu.Items[i].Visible;
   end;

   OpEdit.Visible := (dmZlogGlobal.ContestCategory <> ccSingleOp);
   OpLabel.Visible := OpEdit.Visible;

   if MainForm.OpMenu.Items.Count > 0 then // update op menu 1.31
   begin
      if OpMenu.Items.Count > 0 then begin
         for i := 0 to OpMenu.Items.Count - 1 do
            OpMenu.Items.Delete(0);
      end;

      for i := 0 to MainForm.OpMenu.Items.Count - 1 do begin
         M := TMenuItem.Create(Self);
         M.Caption := MainForm.OpMenu.Items[i].Caption;
         M.OnClick := OpMenuClick;
         M.Enabled := MainForm.OpMenu.Items[i].Enabled;
         M.Visible := MainForm.OpMenu.Items[i].Visible;
         M.Tag := MainForm.OpMenu.Items[i].Tag;
         OpMenu.Items.Add(M);
      end;
   end;

   SerialEdit.Visible := MainForm.SerialEdit1.Visible;
   SerialLabel.Visible := SerialEdit.Visible;

//   ModeEdit.Visible := MainForm.ModeEdit1.Visible;
//   ModeLabel.Visible := ModeEdit.Visible;

//   NewPowerEdit.Visible := MainForm.PowerEdit1.Visible;
//   PowerLabel.Visible := NewPowerEdit.Visible;

   case dmZLogGlobal.ContestCategory of
      ccSingleOp: begin
         comboTxNo.Enabled := False;
      end;

      ccMultiOpMultiTx: begin
         comboTxNo.Enabled := True;
      end;

      ccMultiOpSingleTx, ccMultiOpTwoTx: begin
         comboTxNo.Enabled := True;
      end;
   end;
end;

procedure TEditDialog.FormActivate(Sender: TObject);
begin
   ActionList1.State := asNormal;
end;

procedure TEditDialog.FormDeactivate(Sender: TObject);
begin
   ActionList1.State := asSuspended;
end;

procedure TEditDialog.FormDestroy(Sender: TObject);
begin
   workQSO.Free;
   origQSO.Free;
end;

procedure TEditDialog.OKBtnClick(Sender: TObject);
var
   i, j: integer;
   sthh: Integer;
begin
   // QSO Data

   // Serial Number
   i := StrToIntDef(SerialEdit.Text, 0);
   if i > 0 then begin
      workQSO.Serial := i;
      if SerialContestType <> 0 then begin
         workQSO.NrSent := Format('%3.3d', [i]);
      end;
   end;

   // Date & Time
   workQSO.Time := Trunc(DateTimePicker1.Date) + Frac(DateTimePicker2.Time);

   // コンテスト開始前かチェック
   sthh := MyContest.StartTime;
   if sthh > -1 then begin
      // 基準日時前ならInvalid
      if workQSO.Time < Log.StartTime then begin
         checkInvalid.Checked := True;
         workQSO.Memo := 'BEFORE CONTEST';
      end;
   end;

   // Call
   workQSO.Callsign := CallsignEdit.Text;

   // RST
   try
      i := StrToInt(RcvdRSTEdit.Text);
   except
      on EConvertError do begin
         if workQSO.mode in [mCW, mRTTY] then
            i := 599
         else
            i := 59;
      end;
   end;
   workQSO.RSTrcvd := i;

   // Rcvd
   workQSO.NRRcvd := NumberEdit.Text;

   // memo
   workQSO.memo := MemoEdit.Text;

   // Station
   workQSO.PCName := editPCName.Text;
   workQSO.TX := StrToIntDef(comboTxNo.Items[comboTxNo.ItemIndex], 0);

   // Frequency
   workQSO.Freq := editFrequency.Text;

   // QSO Flags
   workQSO.CQ := checkCQ.Checked;
   workQSO.Dupe := checkDupe.Checked;
   workQSO.QsyViolation := checkQsyViolation.Checked;
   workQSO.Forced := checkForced.Checked;
   workQSO.Invalid := checkInvalid.Checked;

   // QSL Status
   if radioQslNone.Checked then workQSO.QslState := qsNone;
   if radioPseQsl.Checked then workQSO.QslState := qsPseQsl;
   if radioNoQsl.Checked then workQSO.QslState := qsNoQsl;

   // Sent
   MyContest.SetNrSent(workQSO);


   if Action = _ActChange then begin
      IncEditCounter(workQSO);
      MainForm.ZLinkForm.EditQSObyID(workQSO);
      origQSO.Reserve := actEdit;
      workQSO.Reserve := actEdit;
      Log.AddQue(workQSO);
      Log.ProcessQue;
   end;

   if Action = _ActInsert then begin
      origQSO.Reserve := actInsert;
      workQSO.Reserve := actInsert;

      repeat
         j := dmZlogGlobal.NewQSOID();
      until Log.CheckQSOID(j) = False;

      workQSO.Reserve2 := origQSO.Reserve3;
      workQSO.Reserve3 := j;

      MainForm.ZLinkForm.InsertQSO(workQSO);
      Log.AddQue(workQSO);
      Log.ProcessQue;
   end;

   MainForm.ZLinkForm.UnlockQSO(origQSO);

   MyContest.Renew;
   MainForm.Grid.SetFocus;
   ModalResult := mrOK;
end;

procedure TEditDialog.CancelBtnClick(Sender: TObject);
begin
   MainForm.SetLastFocus();
   MainForm.ZLinkForm.UnlockQSO(origQSO);
   ModalResult := mrCancel;
end;

procedure TEditDialog.EditKeyPress(Sender: TObject; var Key: Char);
var
   dupeindex: integer;
begin
   case Key of
      ' ': begin
         if TEdit(Sender).Name = 'MemoEdit' then begin
            if dmZlogGlobal.Settings._movetomemo then begin
               Key := #0;
               CallsignEdit.SetFocus;
            end;
            exit;
         end;
         if (TEdit(Sender).Name = 'NumberEdit') or (TEdit(Sender).Name = 'TimeEdit') then begin
            Key := #0;
            if dmZlogGlobal.Settings._movetomemo then
               MemoEdit.SetFocus
            else
               CallsignEdit.SetFocus;
         end
         else { if space is pressed when Callsign edit is in focus }
         begin
            Key := #0;
            workQSO.Callsign := CallsignEdit.Text;
            if Log.IsDupe2(workQSO, 1, dupeindex) then begin
               CallsignEdit.SelectAll;
               exit;
            end;
            NumberEdit.SetFocus;
         end;
      end;
   end;
end;

procedure TEditDialog.NumberEditKeyPress(Sender: TObject; var Key: Char);
begin
   case Key of
      ' ': begin
         Key := #0;
         CallsignEdit.SetFocus;
      end;
   end;
end;

procedure TEditDialog.BandEditClick(Sender: TObject);
begin
   BandMenu.Popup(Self.Left + groupQsoData.Left + BandEdit.Left + 10, Self.Top + groupQsoData.Top + BandEdit.Top + 40);
end;

procedure TEditDialog.OpMenuClick(Sender: TObject);
var
   O: string;
begin
   O := TMenuItem(Sender).Caption;
   if O = 'Clear' then
      O := '';
   OpEdit.Text := O;
   workQSO.Operator := O;
end;

procedure TEditDialog.BandMenuClick(Sender: TObject);
var
   T: byte;
   B: TBand;
begin
   T := TMenuItem(Sender).Tag;
   B := TBand(T);
   BandEdit.Text := MHzString[B];
   workQSO.Band := B;
end;

procedure TEditDialog.ModeMenuClick(Sender: TObject);
begin
   ModeEdit.Text := ModeString[TMode(TMenuItem(Sender).Tag)];
   workQSO.mode := TMode(TMenuItem(Sender).Tag);
   If TMenuItem(Sender).Tag in [1 .. 3] then begin
      workQSO.RSTrcvd := 59;
      workQSO.RSTsent := 59;
      RcvdRSTEdit.Text := '59';
   end
   else begin
      workQSO.RSTrcvd := 599;
      workQSO.RSTsent := 599;
      RcvdRSTEdit.Text := '599';
   end;
end;

procedure TEditDialog.EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      { MUHENKAN KEY }
      VK_NONCONVERT: begin
         {$IFDEF DEBUG}
         OutputDebugString(PChar('(無変換)'));
         {$ENDIF}
         actionControlPTT.Execute();
      end;
   end;
end;

procedure TEditDialog.NewPowerMenuClick(Sender: TObject);
begin
   NewPowerEdit.Text := NewPowerString[TPower(TMenuItem(Sender).Tag)];
   workQSO.Power := TPower(TMenuItem(Sender).Tag);
end;

procedure TEditDialog.NewPowerEditClick(Sender: TObject);
begin
   NewPowerMenu.Popup(Self.Left + groupQsoData.Left + NewPowerEdit.Left + 10, Self.Top + groupQsoData.Top + NewPowerEdit.Top + 40);
end;

procedure TEditDialog.ModeEditClick(Sender: TObject);
begin
   ModeMenu.Popup(Self.Left + groupQsoData.Left + ModeEdit.Left + 10, Self.Top + groupQsoData.Top + ModeEdit.Top + 40);
end;

procedure TEditDialog.OpEditClick(Sender: TObject);
begin
   OpMenu.Popup(Left + OpEdit.Left + 20, Top + OpEdit.Top);
end;

procedure TEditDialog.Init(aQSO: TQSO; Action_: integer);
begin
   Action := Action_;
   MainForm.ZLinkForm.LockQSO(aQSO); // lock it anyway

   case Action of
      _ActChange:
         Caption := 'Edit QSO';
      _ActInsert:
         Caption := 'Insert QSO';
   end;

   workQSO.Assign(aQSO);
   origQSO.Assign(aQSO);

   if Action = _ActInsert then begin
      workQSO.Callsign := '';
      workQSO.NRRcvd := '';
      workQSO.memo := '';
   end;

   // QSO Data
   SerialEdit.Text := workQSO.SerialStr;
   DateTimePicker1.Date := workQSO.Time;
   DateTimePicker2.Time := workQSO.Time;
   CallsignEdit.Text := workQSO.Callsign;
   RcvdRSTEdit.Text := workQSO.RSTStr;
   NumberEdit.Text := workQSO.NRRcvd;
   ModeEdit.Text := workQSO.ModeStr;
   BandEdit.Text := workQSO.BandStr;
   NewPowerEdit.Text := workQSO.NewPowerStr;
   PointEdit.Text := workQSO.PointStr;
   MemoEdit.Text := workQSO.memo;
   OpEdit.Text := workQSO.Operator;

   // Station
   editPCName.Text := workQSO.PCName;

   case dmZLogGlobal.ContestCategory of
      ccSingleOp: begin
      end;

      ccMultiOpMultiTx: begin
         comboTxNo.Items.CommaText := TXLIST_MM;
         comboTxNo.ItemIndex := comboTxNo.Items.IndexOf(IntToStr(workQSO.TX));
      end;

      ccMultiOpSingleTx, ccMultiOpTwoTx: begin
         comboTxNo.Items.CommaText := TXLIST_MS;
         comboTxNo.ItemIndex := comboTxNo.Items.IndexOf(IntToStr(workQSO.TX));
      end;
   end;

   // Frequency
   editFrequency.Text := workQSO.Freq;

   // QSO Flags
   checkCQ.Checked := workQSO.CQ;
   checkDupe.Checked := workQSO.Dupe;
   checkQsyViolation.Checked := workQSO.QsyViolation;
   checkForced.Checked := workQSO.Forced;
   checkInvalid.Checked := workQSO.Invalid;
   checkInvalidClick(checkInvalid);

   // QSL Status
   radioQslNone.Checked := (workQSO.QslState = qsNone);
   radioPseQsl.Checked := (workQSO.QslState = qsPseQsl);
   radioNoQsl.Checked := (workQSO.QslState = qsNoQsl);
end;

procedure TEditDialog.ChangePower(fUp: Boolean);
begin
   if (fUp = True) then begin
      if workQSO.Power = pwrH then begin
         workQSO.Power := pwrP;
      end
      else begin
         workQSO.Power := TPower(integer(workQSO.Power) + 1);
      end;
   end
   else begin
      if workQSO.Power = pwrP then begin
         workQSO.Power := pwrH;
      end
      else begin
         workQSO.Power := TPower(integer(workQSO.Power) - 1);
      end;
   end;

   NewPowerEdit.Text := workQSO.NewPowerStr;
end;

procedure TEditDialog.checkInvalidClick(Sender: TObject);
begin
   if TCheckBox(Sender).Checked = True then begin
      PointEdit.Text := '0';
   end
   else begin
      PointEdit.Text := workQSO.PointStr;
   end;
end;

procedure TEditDialog.actionPlayMessageAExecute(Sender: TObject);
var
   no: Integer;
begin
   no := TAction(Sender).Tag;
   SendMessage(MainForm.Handle, WM_ZLOG_PLAYMESSAGEA, no, 0);
end;

procedure TEditDialog.actionShowCheckPartialExecute(Sender: TObject);
begin
   MainForm.PartialCheck.Show;
   if TEdit(ActiveControl).Name = 'NumberEdit' then begin
      MainForm.PartialCheck.CheckPartialNumber(workQSO);
   end
   else begin
      MainForm.PartialCheck.CheckPartial(workQSO);
   end;

   TEdit(ActiveControl).SetFocus;
end;

procedure TEditDialog.actionSo2rToggleRigPairExecute(Sender: TObject);
begin
   MainForm.actionSo2rToggleRigPairExecute(Sender);
end;

procedure TEditDialog.actionClearCallAndRptExecute(Sender: TObject);
begin
   CallsignEdit.Clear;
   NumberEdit.Clear;
   MemoEdit.Clear;
   CallsignEdit.SetFocus;
end;

procedure TEditDialog.actionDecreaseTimeExecute(Sender: TObject);
begin
   workQSO.DecTime;
   DateTimePicker1.Date := workQSO.Time;
   DateTimePicker2.Time := workQSO.Time;
end;

procedure TEditDialog.actionIncreaseTimeExecute(Sender: TObject);
begin
   workQSO.IncTime;
   DateTimePicker1.Date := workQSO.Time;
   DateTimePicker2.Time := workQSO.Time;
end;

procedure TEditDialog.actionReversePaddleExecute(Sender: TObject);
begin
//   dmZlogGlobal.ReversePaddle;
end;

procedure TEditDialog.actionFieldClearExecute(Sender: TObject);
begin
   TEdit(ActiveControl).Clear;
end;

procedure TEditDialog.actionCQRepeatExecute(Sender: TObject);
begin
   if Main.CurrentQSO.mode = mCW then begin
      MainForm.CQRepeatClick2(Sender);
   end;
end;

procedure TEditDialog.actionFocusCallsignExecute(Sender: TObject);
begin
   CallsignEdit.SetFocus;
end;

procedure TEditDialog.actionFocusMemoExecute(Sender: TObject);
begin
   MemoEdit.SetFocus;
end;

procedure TEditDialog.actionFocusNumberExecute(Sender: TObject);
begin
   NumberEdit.SetFocus;
end;

procedure TEditDialog.actionFocusOpExecute(Sender: TObject);
begin
   OpEditClick(Self);
end;

procedure TEditDialog.actionFocusRstExecute(Sender: TObject);
begin
   RcvdRSTEdit.SetFocus;
end;

procedure TEditDialog.actionToggleRigExecute(Sender: TObject);
begin
   MainForm.actionToggleRigExecute(Sender);
end;

procedure TEditDialog.actionToggleRXExecute(Sender: TObject);
begin
   MainForm.actionToggleRxExecute(Sender);
end;

procedure TEditDialog.actionToggleTXExecute(Sender: TObject);
begin
   MainForm.actionToggleTxExecute(Sender);
end;

procedure TEditDialog.actionControlPTTExecute(Sender: TObject);
var
   nID: Integer;
begin
   nID := MainForm.CurrentRigID;
   dmZLogKeyer.ControlPTT(nID, not(dmZLogKeyer.PTTIsOn)); // toggle PTT;
end;

procedure TEditDialog.actionChangeBandExecute(Sender: TObject);
begin
   if TAction(Sender).Tag = 0 then begin
      workQSO.Band := MainForm.GetNextBand(workQSO.Band, True);
   end
   else begin
      workQSO.Band := MainForm.GetNextBand(workQSO.Band, False);
   end;
   BandEdit.Text := MHzString[workQSO.Band];
end;

procedure TEditDialog.actionChangeModeExecute(Sender: TObject);
begin
   if TAction(Sender).Tag = 0 then begin
      MainForm.SetQSOMode(workQSO, True);
   end
   else begin
      MainForm.SetQSOMode(workQSO, False);
   end;

   ModeEdit.Text := ModeString[workQSO.mode];

   if workQSO.mode in [mSSB, mFM, mAM] then begin
      workQSO.RSTrcvd := 59;
      workQSO.RSTsent := 59;
      RcvdRSTEdit.Text := '59';
   end
   else begin
      workQSO.RSTrcvd := 599;
      workQSO.RSTsent := 599;
      RcvdRSTEdit.Text := '599';
   end;
end;

procedure TEditDialog.actionChangePowerExecute(Sender: TObject);
begin
   if TAction(Sender).Tag = 0 then begin
      ChangePower(True);
   end
   else begin
      ChangePower(False);
   end;
end;

procedure TEditDialog.actionChangeRExecute(Sender: TObject);
begin
   MainForm.SetR(workQSO);
   RcvdRSTEdit.Text := workQSO.RSTStr;
end;

procedure TEditDialog.actionChangeSExecute(Sender: TObject);
begin
   MainForm.SetS(workQSO);
   RcvdRSTEdit.Text := workQSO.RSTStr;
end;

procedure TEditDialog.actionSetCurTimeExecute(Sender: TObject);
begin
   workQSO.UpdateTime;
   DateTimePicker1.Date := workQSO.Time;
   DateTimePicker2.Time := workQSO.Time;
end;

procedure TEditDialog.actionDecreaseCwSpeedExecute(Sender: TObject);
begin
   dmZLogKeyer.DecCWSpeed();
end;

procedure TEditDialog.actionIncreaseCwSpeedExecute(Sender: TObject);
begin
   dmZLogKeyer.IncCWSpeed();
end;

procedure TEditDialog.actionCQRepeat2Execute(Sender: TObject);
begin
   if Main.CurrentQSO.mode = mCW then begin
      MainForm.CQRepeatClick1(Sender);
   end;
end;

procedure TEditDialog.actionToggleVFOExecute(Sender: TObject);
begin
//   if MainForm.RigControl.Rig <> nil then begin
//      MainForm.RigControl.Rig.ToggleVFO;
//   end;
end;

procedure TEditDialog.actionQuickMemo3Execute(Sender: TObject);
var
   strQuickMemoText: string;
   strTemp: string;
   n: Integer;
begin
   // 設定された文字列を取得
   n := TAction(Sender).Tag;
   strQuickMemoText := dmZlogGlobal.Settings.FQuickMemoText[n];
   if strQuickMemoText = '' then begin
      Exit;
   end;

   // 現在の内容を取得
   strTemp := MemoEdit.Text;

   // 未設定ならmemo欄に挿入、設定済みなら削除
   if Pos(strQuickMemoText, strTemp) = 0 then begin
      strTemp := strQuickMemoText + ' ' + strTemp;
   end
   else begin
      strTemp := Trim(StringReplace(strTemp, strQuickMemoText + ' ', '', [rfReplaceAll]));
      strTemp := Trim(StringReplace(strTemp, strQuickMemoText, '', [rfReplaceAll]));
   end;

   MemoEdit.Text := strTemp;
end;

procedure TEditDialog.ApplyShortcut();
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
   actionShowCheckPartial.ShortCut := MainForm.actionShowCheckPartial.ShortCut;
   actionPlayMessageA11.ShortCut := MainForm.actionPlayMessageA11.ShortCut;
   actionPlayMessageA12.ShortCut := MainForm.actionPlayMessageA12.ShortCut;
   actionClearCallAndRpt.ShortCut := MainForm.actionClearCallAndRpt.ShortCut;
   actionDecreaseTime.ShortCut := MainForm.actionDecreaseTime.ShortCut;
   actionIncreaseTime.ShortCut := MainForm.actionIncreaseTime.ShortCut;
   actionReversePaddle.ShortCut := MainForm.actionReversePaddle.ShortCut;
   actionFieldClear.ShortCut := MainForm.actionFieldClear.ShortCut;
   actionCQRepeat.ShortCut := MainForm.actionCQRepeat.ShortCut;
   actionFocusCallsign.ShortCut := MainForm.actionFocusCallsign.ShortCut;
   actionFocusMemo.ShortCut := MainForm.actionFocusMemo.ShortCut;
   actionFocusNumber.ShortCut := MainForm.actionFocusNumber.ShortCut;
   actionFocusOp.ShortCut := MainForm.actionFocusOp.ShortCut;
   actionFocusRst.ShortCut := MainForm.actionFocusRst.ShortCut;
   actionToggleRig.ShortCut := MainForm.actionToggleRig.ShortCut;
   actionControlPTT.ShortCut := MainForm.actionControlPTT.ShortCut;
   actionChangeBand.ShortCut := MainForm.actionChangeBand.ShortCut;
   actionChangeMode.ShortCut := MainForm.actionChangeMode.ShortCut;
   actionChangePower.ShortCut := MainForm.actionChangePower.ShortCut;
   actionChangeR.ShortCut := MainForm.actionChangeR.ShortCut;
   actionChangeS.ShortCut := MainForm.actionChangeS.ShortCut;
   actionSetCurTime.ShortCut := MainForm.actionSetCurTime.ShortCut;
   actionDecreaseCwSpeed.ShortCut := MainForm.actionDecreaseCwSpeed.ShortCut;
   actionIncreaseCwSpeed.ShortCut := MainForm.actionIncreaseCwSpeed.ShortCut;
   actionCQRepeat2.ShortCut := MainForm.actionCQRepeat2.ShortCut;
   actionToggleVFO.ShortCut := MainForm.actionToggleVFO.ShortCut;
   actionQuickMemo1.ShortCut := MainForm.actionQuickMemo1.ShortCut;
   actionQuickMemo2.ShortCut := MainForm.actionQuickMemo2.ShortCut;
   actionQuickMemo3.ShortCut := MainForm.actionQuickMemo3.ShortCut;
   actionQuickMemo4.ShortCut := MainForm.actionQuickMemo4.ShortCut;
   actionQuickMemo5.ShortCut := MainForm.actionQuickMemo5.ShortCut;
   actionPlayCQA1.ShortCut := MainForm.actionPlayCQA1.ShortCut;
   actionPlayCQA2.ShortCut := MainForm.actionPlayCQA2.ShortCut;
   actionPlayCQA3.ShortCut := MainForm.actionPlayCQA3.ShortCut;
   actionToggleRx.ShortCut := MainForm.actionToggleRx.ShortCut;
   actionToggleTx.ShortCut := MainForm.actionToggleTx.ShortCut;
   actionSo2rToggleRigPair.ShortCut := MainForm.actionSo2rToggleRigPair.ShortCut;
   actionChangeBand2.ShortCut := MainForm.actionChangeBand2.ShortCut;
   actionChangeMode2.ShortCut := MainForm.actionChangeMode2.ShortCut;
   actionChangePower2.ShortCut := MainForm.actionChangePower2.ShortCut;

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
   actionShowCheckPartial.SecondaryShortCuts.Assign(MainForm.actionShowCheckPartial.SecondaryShortCuts);
   actionPlayMessageA11.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA11.SecondaryShortCuts);
   actionPlayMessageA12.SecondaryShortCuts.Assign(MainForm.actionPlayMessageA12.SecondaryShortCuts);
   actionClearCallAndRpt.SecondaryShortCuts.Assign(MainForm.actionClearCallAndRpt.SecondaryShortCuts);
   actionDecreaseTime.SecondaryShortCuts.Assign(MainForm.actionDecreaseTime.SecondaryShortCuts);
   actionIncreaseTime.SecondaryShortCuts.Assign(MainForm.actionIncreaseTime.SecondaryShortCuts);
   actionReversePaddle.SecondaryShortCuts.Assign(MainForm.actionReversePaddle.SecondaryShortCuts);
   actionFieldClear.SecondaryShortCuts.Assign(MainForm.actionFieldClear.SecondaryShortCuts);
   actionCQRepeat.SecondaryShortCuts.Assign(MainForm.actionCQRepeat.SecondaryShortCuts);
   actionFocusCallsign.SecondaryShortCuts.Assign(MainForm.actionFocusCallsign.SecondaryShortCuts);
   actionFocusMemo.SecondaryShortCuts.Assign(MainForm.actionFocusMemo.SecondaryShortCuts);
   actionFocusNumber.SecondaryShortCuts.Assign(MainForm.actionFocusNumber.SecondaryShortCuts);
   actionFocusOp.SecondaryShortCuts.Assign(MainForm.actionFocusOp.SecondaryShortCuts);
   actionFocusRst.SecondaryShortCuts.Assign(MainForm.actionFocusRst.SecondaryShortCuts);
   actionToggleRig.SecondaryShortCuts.Assign(MainForm.actionToggleRig.SecondaryShortCuts);
   actionControlPTT.SecondaryShortCuts.Assign(MainForm.actionControlPTT.SecondaryShortCuts);
   actionChangeBand.SecondaryShortCuts.Assign(MainForm.actionChangeBand.SecondaryShortCuts);
   actionChangeMode.SecondaryShortCuts.Assign(MainForm.actionChangeMode.SecondaryShortCuts);
   actionChangePower.SecondaryShortCuts.Assign(MainForm.actionChangePower.SecondaryShortCuts);
   actionChangeR.SecondaryShortCuts.Assign(MainForm.actionChangeR.SecondaryShortCuts);
   actionChangeS.SecondaryShortCuts.Assign(MainForm.actionChangeS.SecondaryShortCuts);
   actionSetCurTime.SecondaryShortCuts.Assign(MainForm.actionSetCurTime.SecondaryShortCuts);
   actionDecreaseCwSpeed.SecondaryShortCuts.Assign(MainForm.actionDecreaseCwSpeed.SecondaryShortCuts);
   actionIncreaseCwSpeed.SecondaryShortCuts.Assign(MainForm.actionIncreaseCwSpeed.SecondaryShortCuts);
   actionCQRepeat2.SecondaryShortCuts.Assign(MainForm.actionCQRepeat2.SecondaryShortCuts);
   actionToggleVFO.SecondaryShortCuts.Assign(MainForm.actionToggleVFO.SecondaryShortCuts);
   actionQuickMemo1.SecondaryShortCuts.Assign(MainForm.actionQuickMemo1.SecondaryShortCuts);
   actionQuickMemo2.SecondaryShortCuts.Assign(MainForm.actionQuickMemo2.SecondaryShortCuts);
   actionQuickMemo3.SecondaryShortCuts.Assign(MainForm.actionQuickMemo3.SecondaryShortCuts);
   actionQuickMemo4.SecondaryShortCuts.Assign(MainForm.actionQuickMemo4.SecondaryShortCuts);
   actionQuickMemo5.SecondaryShortCuts.Assign(MainForm.actionQuickMemo5.SecondaryShortCuts);
   actionPlayCQA1.SecondaryShortCuts.Assign(MainForm.actionPlayCQA1.SecondaryShortCuts);
   actionPlayCQA2.SecondaryShortCuts.Assign(MainForm.actionPlayCQA2.SecondaryShortCuts);
   actionPlayCQA3.SecondaryShortCuts.Assign(MainForm.actionPlayCQA3.SecondaryShortCuts);
   actionToggleRx.SecondaryShortCuts.Assign(MainForm.actionToggleRx.SecondaryShortCuts);
   actionToggleTx.SecondaryShortCuts.Assign(MainForm.actionToggleTx.SecondaryShortCuts);
   actionSo2rToggleRigPair.SecondaryShortCuts.Assign(MainForm.actionSo2rToggleRigPair.SecondaryShortCuts);
   actionChangeBand2.SecondaryShortCuts.Assign(MainForm.actionChangeBand2.SecondaryShortCuts);
   actionChangeMode2.SecondaryShortCuts.Assign(MainForm.actionChangeMode2.SecondaryShortCuts);
   actionChangePower2.SecondaryShortCuts.Assign(MainForm.actionChangePower2.SecondaryShortCuts);
end;

end.
