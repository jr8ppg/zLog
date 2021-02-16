unit UEditDialog;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Menus, System.Actions, Vcl.ActnList,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogCW, UzLogKeyer;

const _ActInsert = 0;
      _ActChange = 1;

type
  TEditDialog = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Panel1: TPanel;
    TimeEdit: TEdit;
    CallsignEdit: TEdit;
    RcvdRSTEdit: TEdit;
    NumberEdit: TEdit;
    BandEdit: TEdit;
    ModeEdit: TEdit;
    MemoEdit: TEdit;
    PointEdit: TEdit;
    PowerEdit: TEdit;
    BandMenu: TPopupMenu;
    OpEdit: TEdit;
    ModeMenu: TPopupMenu;
    OpMenu: TPopupMenu;
    SerialEdit: TEdit;
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
    DateEdit: TEdit;
    NewPowerMenu: TPopupMenu;
    NewPowerEdit: TEdit;
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
    procedure CancelBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CallsignEditChange(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure NumberEditChange(Sender: TObject);
    procedure NumberEditKeyPress(Sender: TObject; var Key: Char);
    procedure BandEditClick(Sender: TObject);
    procedure OpMenuClick(Sender: TObject);
    procedure BandMenuClick(Sender: TObject);
    procedure ModeMenuClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RcvdRSTEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MemoEditChange(Sender: TObject);
    procedure TimeEditChange(Sender: TObject);
    procedure DateEditChange(Sender: TObject);
    procedure DateEditDblClick(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NewPowerMenuClick(Sender: TObject);
    procedure NewPowerEditClick(Sender: TObject);
    procedure ModeEditClick(Sender: TObject);
    procedure PowerEditChange(Sender: TObject);
    procedure OpEditClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
    procedure actionQuickMemo1Execute(Sender: TObject);
    procedure actionQuickMemo2Execute(Sender: TObject);
    procedure actionQuickMemo3Execute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
    workQSO : TQSO;
    origQSO : TQSO;
    Action : integer;
  public
    { Public declarations }
    procedure Init(aQSO : TQSO; Action_ : integer); virtual;
    procedure ChangePower; virtual;
  end;

implementation

uses Main, UOptions, UZLinkForm, UPartials, URigControl;

{$R *.DFM}

procedure TEditDialog.ChangePower;
begin
   if workQSO.Power = pwrH then begin
      workQSO.Power := pwrP;
   end
   else begin
      workQSO.Power := TPower(integer(workQSO.Power) + 1);
   end;

   NewPowerEdit.Text := workQSO.NewPowerStr;
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

   TimeEdit.Visible := True;
   DateEdit.Visible := False;
   TimeLabel.Caption := 'time';

   SerialEdit.Text := workQSO.SerialStr;
   TimeEdit.Text := workQSO.TimeStr;
   DateEdit.Text := workQSO.DateStr;
   CallsignEdit.Text := workQSO.Callsign;
   RcvdRSTEdit.Text := workQSO.RSTStr;
   NumberEdit.Text := workQSO.NRRcvd;
   ModeEdit.Text := workQSO.ModeStr;
   BandEdit.Text := workQSO.BandStr;
   PowerEdit.Text := workQSO.PowerStr;
   NewPowerEdit.Text := workQSO.NewPowerStr;
   PointEdit.Text := workQSO.PointStr;
   MemoEdit.Text := workQSO.memo;
   OpEdit.Text := workQSO.Operator;
end;

procedure TEditDialog.CancelBtnClick(Sender: TObject);
begin
   MainForm.LastFocus.SetFocus;
   MainForm.ZLinkForm.UnlockQSO(origQSO);
   ModalResult := mrCancel;
   Close;
end;

procedure TEditDialog.OKBtnClick(Sender: TObject);
var
   i, j: integer;
   // aQSO : TQSO;
begin
   MyContest.SetNrSent(workQSO);

   i := StrToIntDef(SerialEdit.Text, 0);
   if i > 0 then begin
      workQSO.Serial := i;
   end;

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

   Close;
end;

procedure TEditDialog.CallsignEditChange(Sender: TObject);
begin
   workQSO.Callsign := CallsignEdit.Text;
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
            if NumberEdit.Text = '' then begin
            end;
            Key := Chr(0);
            if Log.IsDupe2(workQSO, 1, dupeindex) then begin
               CallsignEdit.SelectAll;
               exit;
            end;
            NumberEdit.SetFocus;
         end;
      end;

      Chr($0D): begin
         if HiWord(GetKeyState(VK_SHIFT)) <> 0 then begin
         end;
         OKBtnClick(Self);
         Key := #0;
      end;
   end;
   { of case }
end;

procedure TEditDialog.NumberEditChange(Sender: TObject);
begin
   workQSO.NRRcvd := NumberEdit.Text;
end;

procedure TEditDialog.NumberEditKeyPress(Sender: TObject; var Key: Char);
begin
   case Key of
      ' ': begin
         Key := Chr(0);
         CallsignEdit.SetFocus;
      end;

      Chr($0D): begin
         OKBtnClick(Self);
         Key := #0;
      end;
   end; { of case }
end;

procedure TEditDialog.BandEditClick(Sender: TObject);
begin
   BandMenu.Popup(Self.Left + Panel1.Left + BandEdit.Left + 10, Self.Top + Panel1.Top + BandEdit.Top + 40);
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

   OpEdit.Visible := (dmZlogGlobal.MultiOp > 0);
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

   SerialEdit.Visible := MainForm.SerialEdit.Visible;
   SerialEdit.Left := MainForm.SerialEdit.Left + offset;
   SerialEdit.Width := MainForm.SerialEdit.Width;
   SerialLabel.Visible := SerialEdit.Visible;
   SerialLabel.Left := SerialEdit.Left + 1;

   TimeEdit.Left := MainForm.TimeEdit.Left + offset;
   TimeEdit.Width := MainForm.TimeEdit.Width;
   TimeLabel.Left := TimeEdit.Left + 1;

   DateEdit.Left := TimeEdit.Left;
   DateEdit.Width := TimeEdit.Width;

   CallsignEdit.Left := MainForm.CallsignEdit.Left + offset;
   CallsignEdit.Width := MainForm.CallsignEdit.Width;
   CallsignLabel.Left := CallsignEdit.Left + 1;

   RcvdRSTEdit.Left := MainForm.RcvdRSTEdit.Left + offset;
   RcvdRSTEdit.Width := MainForm.RcvdRSTEdit.Width;
   rcvdRSTLabel.Left := RcvdRSTEdit.Left + 1;

   NumberEdit.Left := MainForm.NumberEdit.Left + offset;
   NumberEdit.Width := MainForm.NumberEdit.Width;
   NumberLabel.Left := NumberEdit.Left + 1;

   BandEdit.Left := MainForm.BandEdit.Left + offset;
   BandEdit.Width := MainForm.BandEdit.Width;
   BandLabel.Left := BandEdit.Left + 1;

   ModeEdit.Left := MainForm.ModeEdit.Left + offset;
   ModeEdit.Width := MainForm.ModeEdit.Width;
   ModeEdit.Visible := MainForm.ModeEdit.Visible;
   ModeLabel.Visible := ModeEdit.Visible;
   ModeLabel.Left := ModeEdit.Left + 1;

   PowerLabel.Visible := PowerEdit.Visible;
   PowerLabel.Left := PowerEdit.Left + 1;

   NewPowerEdit.Left := MainForm.NewPowerEdit.Left + offset;
   NewPowerEdit.Width := MainForm.NewPowerEdit.Width;
   NewPowerEdit.Visible := MainForm.NewPowerEdit.Visible;
   PowerLabel.Visible := NewPowerEdit.Visible;
   PowerLabel.Left := NewPowerEdit.Left + 1;

   PointEdit.Left := MainForm.PointEdit.Left + offset;
   PointEdit.Width := MainForm.PointEdit.Width;
   PointLabel.Left := PointEdit.Left + 1;

   OpEdit.Left := MainForm.OpEdit.Left + offset;
   OpEdit.Width := MainForm.OpEdit.Width;
   OpLabel.Left := OpEdit.Left + 1;

   MemoEdit.Left := MainForm.MemoEdit.Left + offset;
   MemoEdit.Width := MainForm.MemoEdit.Width;
   MemoLabel.Left := MemoEdit.Left + 1;

   Width := MainForm.Width;
end;

procedure TEditDialog.RcvdRSTEditChange(Sender: TObject);
var
   i: Word;
begin
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
end;

procedure TEditDialog.FormActivate(Sender: TObject);
begin
   ActionList1.State := asNormal;
end;

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
   actionPlayCQA2.ShortCut := MainForm.actionPlayCQA2.ShortCut;
   actionPlayCQA3.ShortCut := MainForm.actionPlayCQA3.ShortCut;

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
   actionPlayCQA2.SecondaryShortCuts.Assign(MainForm.actionPlayCQA2.SecondaryShortCuts);
   actionPlayCQA3.SecondaryShortCuts.Assign(MainForm.actionPlayCQA3.SecondaryShortCuts);
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

procedure TEditDialog.MemoEditChange(Sender: TObject);
begin
   workQSO.memo := MemoEdit.Text;
end;

procedure TEditDialog.TimeEditChange(Sender: TObject);
var
   T: TDateTime;
begin
   T := StrToTimeDef(TimeEdit.Text, workQSO.Time);

   if workQSO.TimeStr = FormatDateTime('hh:nn', T) then begin
      exit;
   end;

   workQSO.Time := Trunc(workQSO.Time) + Frac(T); // (T-Trunc(T));
end;

procedure TEditDialog.DateEditChange(Sender: TObject);
var
   T: TDateTime;
begin
   FormatSettings.ShortDateFormat := 'y/m/d';

   T := StrToDateDef(DateEdit.Text, workQSO.Time);

   if workQSO.DateStr = FormatDateTime('yy/mm/dd', T) then begin
      exit;
   end;

   workQSO.Time := Int(T) + Frac(workQSO.Time);
end;

procedure TEditDialog.DateEditDblClick(Sender: TObject);
begin
   if TEdit(Sender).Name = 'TimeEdit' then begin
      TimeEdit.Visible := False;
      DateEdit.Visible := True;
      TimeLabel.Caption := 'date';
   end
   else begin
      TimeEdit.Visible := True;
      DateEdit.Visible := False;
      TimeLabel.Caption := 'time';
   end;
end;

procedure TEditDialog.EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      { MUHENKAN KEY }
      VK_NONCONVERT: begin
         {$IFDEF DEBUG}
         OutputDebugString(PChar('(ñ≥ïœä∑)'));
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
   NewPowerMenu.Popup(Self.Left + Panel1.Left + NewPowerEdit.Left + 10, Self.Top + Panel1.Top + NewPowerEdit.Top + 40);
end;

procedure TEditDialog.ModeEditClick(Sender: TObject);
begin
   ModeMenu.Popup(Self.Left + Panel1.Left + ModeEdit.Left + 10, Self.Top + Panel1.Top + ModeEdit.Top + 40);
end;

procedure TEditDialog.PowerEditChange(Sender: TObject);
var
   i: integer;
begin
   i := 0;
   if (PowerEdit.Text = 'KW') then
      i := 9999;

   if (PowerEdit.Text = '1KW') then
      i := 10000;

   if (PowerEdit.Text = 'K') then
      i := 10001;

   if i > 0 then begin
      workQSO.Power2 := i;
      exit;
   end;

   i := StrToIntDef(PowerEdit.Text, 0);
   workQSO.Power2 := i;
end;

procedure TEditDialog.OpEditClick(Sender: TObject);
begin
   OpMenu.Popup(Left + OpEdit.Left + 20, Top + OpEdit.Top);
end;

procedure TEditDialog.actionPlayMessageAExecute(Sender: TObject);
var
   no: Integer;
   cb: Integer;
   S: string;
begin
   no := TAction(Sender).Tag;

   if workQSO.mode = mCW then begin
      cb := dmZlogGlobal.Settings.CW.CurrentBank;

      {$IFDEF DEBUG}
      OutputDebugString(PChar('PlayMessageA(' + IntToStr(cb) + ',' + IntToStr(no) + ')'));
      {$ENDIF}

      if GetAsyncKeyState(VK_SHIFT) < 0 then begin
         if cb = 1 then
            cb := 2
         else
            cb := 1;
      end;

      S := dmZlogGlobal.CWMessage(cb, no);
      zLogSendStr2(S, CurrentQSO);
   end
   else begin
      // SendVoice(i);
   end;
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
   TimeEdit.Text := workQSO.TimeStr;
   DateEdit.Text := workQSO.DateStr;
end;

procedure TEditDialog.actionIncreaseTimeExecute(Sender: TObject);
begin
   workQSO.IncTime;
   TimeEdit.Text := workQSO.TimeStr;
   DateEdit.Text := workQSO.DateStr;
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
   MainForm.RigControl.ToggleCurrentRig;
end;

procedure TEditDialog.actionControlPTTExecute(Sender: TObject);
begin
   dmZLogKeyer.ControlPTT(not(dmZLogKeyer.PTTIsOn)); // toggle PTT;
end;

procedure TEditDialog.actionChangeBandExecute(Sender: TObject);
begin
   workQSO.Band := MainForm.GetNextBand(workQSO.Band, True);
   BandEdit.Text := MHzString[workQSO.Band];
end;

procedure TEditDialog.actionChangeModeExecute(Sender: TObject);
begin
   // ChangeMode;
   MainForm.SetQSOMode(workQSO);
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
   ChangePower;
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
   TimeEdit.Text := workQSO.TimeStr;
   DateEdit.Text := workQSO.DateStr;
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
   if MainForm.RigControl.Rig <> nil then begin
      MainForm.RigControl.Rig.ToggleVFO;
   end;
end;

procedure TEditDialog.actionQuickMemo1Execute(Sender: TObject);
var
   strTemp: string;
   strPseQsl: string;
   strNoQsl: string;
begin
   strPseQsl := dmZlogGlobal.Settings.FQuickMemoText[1];
   strNoQsl  := dmZlogGlobal.Settings.FQuickMemoText[2];

   strTemp := MemoEdit.Text;
   if Pos(strNoQsl, strTemp) > 0 then begin
      strTemp := Trim(StringReplace(strTemp, strNoQsl, '', [rfReplaceAll]));
   end;

   if Pos(strPseQsl, strTemp) = 0 then begin
      strTemp := strPseQsl + ' ' + strTemp;
   end
   else begin
      strTemp := Trim(StringReplace(strTemp, strPseQsl, '', [rfReplaceAll]));
   end;

   MemoEdit.Text := strTemp;
end;

procedure TEditDialog.actionQuickMemo2Execute(Sender: TObject);
var
   strTemp: string;
   strPseQsl: string;
   strNoQsl: string;
begin
   strPseQsl := dmZlogGlobal.Settings.FQuickMemoText[1];
   strNoQsl  := dmZlogGlobal.Settings.FQuickMemoText[2];

   strTemp := MemoEdit.Text;
   if Pos(strPseQsl, strTemp) > 0 then begin
      strTemp := Trim(StringReplace(strTemp, strPseQsl, '', [rfReplaceAll]));
   end;

   if Pos(strNoQsl, strTemp) = 0 then begin
      strTemp := strNoQsl + ' ' + strTemp;
   end
   else begin
      strTemp := Trim(StringReplace(strTemp, strNoQsl, '', [rfReplaceAll]));
   end;

   MemoEdit.Text := strTemp;
end;

procedure TEditDialog.actionQuickMemo3Execute(Sender: TObject);
var
   strQuickMemoText: string;
   strTemp: string;
   n: Integer;
begin
   // ê›íËÇ≥ÇÍÇΩï∂éöóÒÇéÊìæ
   n := TAction(Sender).Tag;
   strQuickMemoText := dmZlogGlobal.Settings.FQuickMemoText[n];
   if strQuickMemoText = '' then begin
      Exit;
   end;

   // åªç›ÇÃì‡óeÇéÊìæ
   strTemp := MemoEdit.Text;

   // ñ¢ê›íËÇ»ÇÁmemoóìÇ…ë}ì¸ÅAê›íËçœÇ›Ç»ÇÁçÌèú
   if Pos(strQuickMemoText, strTemp) = 0 then begin
      strTemp := strQuickMemoText + ' ' + strTemp;
   end
   else begin
      strTemp := Trim(StringReplace(strTemp, strQuickMemoText + ' ', '', [rfReplaceAll]));
      strTemp := Trim(StringReplace(strTemp, strQuickMemoText, '', [rfReplaceAll]));
   end;

   MemoEdit.Text := strTemp;
end;

end.
