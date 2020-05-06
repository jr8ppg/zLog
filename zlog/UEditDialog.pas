unit UEditDialog;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Menus,
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
    MainMenu1: TMainMenu;
    edit1: TMenuItem;
    op1: TMenuItem;
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
    procedure op1Click(Sender: TObject);
    procedure OpEditClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
   MainForm.CommonEditKeyProcess(Sender, Key);
   case Key of
      '\': begin
         dmZLogKeyer.ControlPTT(not(dmZLogKeyer.PTTIsOn)); // toggle PTT;
         Key := #0;
      end;

      'X', 'x': begin
         if HiWord(GetKeyState(VK_SHIFT)) <> 0 then begin
            MainForm.RigControl.ToggleCurrentRig;
            Key := #0;
         end;
      end;

      'V', 'v': begin
         if HiWord(GetKeyState(VK_SHIFT)) <> 0 then begin
            if MainForm.RigControl.Rig <> nil then
               MainForm.RigControl.Rig.ToggleVFO;
            Key := #0;
         end;
      end;

      ^O: begin
         workQSO.DecTime;
         // TimeEdit.Text := CurrentQSO.TimeStr;
         // DateEdit.Text := CurrentQSO.DateStr;
         TimeEdit.Text := workQSO.TimeStr;
         DateEdit.Text := workQSO.DateStr;
         Key := #0;
      end;

      ^P: begin
         workQSO.IncTime;
         TimeEdit.Text := workQSO.TimeStr;
         DateEdit.Text := workQSO.DateStr;
         Key := #0;
      end;

      ^W: begin
         TEdit(Sender).Clear;
         Key := #0;
      end;

      ^R: begin
         dmZlogGlobal.ReversePaddle;
         Key := #0;
      end;

      ^K: begin
         CallsignEdit.Clear;
         NumberEdit.Clear;
         MemoEdit.Clear;
         CallsignEdit.SetFocus;
         Key := #0;
      end;

      'Z': begin
         if HiWord(GetKeyState(VK_SHIFT)) <> 0 then begin
            if Main.CurrentQSO.mode = mCW then begin
               MainForm.CQRepeatClick1(Sender);
            end
            else begin
            end;
            Key := #0;
         end;
      end;

      ^Z: begin
         if Main.CurrentQSO.mode = mCW then
            MainForm.CQRepeatClick2(Sender);
         Key := #0;
      end;

      (* Chr($1B) :  {ESC}
        begin
        MainForm.CWStopButtonClick(Self);
        MainForm.VoiceStopButtonClick(Self);
        Key := #0;
        end; *)

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

      'Y', 'y': begin
         if HiWord(GetKeyState(VK_SHIFT)) <> 0 then begin
            IncCWSpeed;
            Key := #0;
         end;
      end;

      'T', 't': begin
         if HiWord(GetKeyState(VK_SHIFT)) <> 0 then begin
            workQSO.UpdateTime;
            TimeEdit.Text := workQSO.TimeStr;
            DateEdit.Text := workQSO.DateStr;
            Key := #0;
         end;
      end;

      'U', 'u': begin
         if HiWord(GetKeyState(VK_SHIFT)) <> 0 then begin
            DecCWSpeed;
            Key := #0;
         end;
      end;

      'B', 'b': begin
         if HiWord(GetKeyState(VK_SHIFT)) <> 0 then begin
            // ChangeBand(True);
            // MainForm.SetQSOBand(workQSO, True);
            workQSO.Band := MainForm.GetNextBand(workQSO.Band, True);
            BandEdit.Text := MHzString[workQSO.Band];
            Key := #0;
         end;
      end;

      'R', 'r': begin
         if HiWord(GetKeyState(VK_SHIFT)) <> 0 then begin
            MainForm.SetR(workQSO);
            RcvdRSTEdit.Text := workQSO.RSTStr;
            Key := #0;
         end;
      end;

      'S', 's': begin
         if HiWord(GetKeyState(VK_SHIFT)) <> 0 then begin
            MainForm.SetS(workQSO);
            RcvdRSTEdit.Text := workQSO.RSTStr;
            Key := #0;
         end;
      end;

      'M', 'm': begin
         if HiWord(GetKeyState(VK_SHIFT)) <> 0 then begin
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
            Key := #0;
         end;
      end;

      'P', 'p': begin
         if HiWord(GetKeyState(VK_SHIFT)) <> 0 then begin
            ChangePower;
            Key := #0;
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
var
   i, cb: integer;
   S: string;
begin
   case Key of
      { MUHENKAN KEY }
      29: begin
         dmZLogKeyer.ControlPTT(not(dmZLogKeyer.PTTIsOn)); // toggle PTT;
      end;

      VK_F1 .. VK_F8, VK_F11, VK_F12: begin
         i := Key - VK_F1 + 1;
         if workQSO.mode = mCW then begin

            cb := dmZlogGlobal.Settings.CW.CurrentBank;

            if GetAsyncKeyState(VK_SHIFT) < 0 then begin
               if cb = 1 then
                  cb := 2
               else
                  cb := 1;
            end;

            S := dmZlogGlobal.CWMessage(cb, i);
            S := SetStr(S, CurrentQSO);
            zLogSendStr(S);
         end
         else begin
            // SendVoice(i);
         end;
      end;

      VK_F10: begin
         MainForm.PartialCheck.Show;
         if TEdit(Sender).Name = 'NumberEdit' then begin
            MainForm.PartialCheck.CheckPartialNumber(workQSO);
         end
         else begin
            MainForm.PartialCheck.CheckPartial(workQSO);
         end;

         TEdit(Sender).SetFocus;
         Key := 0;
      end;

      Ord('O'): begin
         if Shift = [ssAlt] then begin
            OpEditClick(Self);
         end;

         // Key := 0;
      end;

      Ord('M'): begin
         if Shift = [ssAlt] then begin
            MemoEdit.SetFocus;
            Key := 0;
         end;
      end;

      Ord('N'): begin
         if Shift = [ssAlt] then begin
            NumberEdit.SetFocus;
         end;
      end;

      Ord('R'): begin
         if Shift = [ssAlt] then begin
            RcvdRSTEdit.SetFocus;
         end;
      end;

      Ord('C'): begin
         if Shift = [ssAlt] then begin
            CallsignEdit.SetFocus;
         end;
      end;

      VK_ESCAPE: begin
         Key := 0;
         CancelBtnClick(Self);
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

procedure TEditDialog.op1Click(Sender: TObject);
begin
   OpEditClick(Self);
end;

procedure TEditDialog.OpEditClick(Sender: TObject);
begin
   OpMenu.Popup(Left + OpEdit.Left + 20, Top + OpEdit.Top);
end;

end.
