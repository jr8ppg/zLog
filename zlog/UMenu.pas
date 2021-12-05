unit UMenu;

interface

uses
   SysUtils, Windows, Messages, Classes, Graphics, Controls, StdCtrls, ExtCtrls,
   Forms, UITypes, Dialogs, Buttons, UzLogConst, UzLogGlobal,
   USelectUserDefinedContest, UserDefinedContest;

type
   TMenuForm = class(TForm)
      OKButton: TButton;
      CancelButton: TButton;
      Button3: TButton;
      ContestGroup: TGroupBox;
      BandGroup: TRadioGroup;
      rbALLJA: TRadioButton;
      rb6D: TRadioButton;
      rbFD: TRadioButton;
      rbACAG: TRadioButton;
      ModeGroup: TRadioGroup;
      editCallsign: TEdit;
      Label1: TLabel;
      rbCQWW: TRadioButton;
      rbJIDXJA: TRadioButton;
      rbCQWPX: TRadioButton;
      rbPedi: TRadioButton;
      rbJIDXDX: TRadioButton;
      rbGeneral: TRadioButton;
      CFGOpenDialog: TOpenDialog;
      SelectButton: TSpeedButton;
      CheckBox1: TCheckBox;
      rbARRLDX: TRadioButton;
      rbARRLW: TRadioButton;
      rbAPSprint: TRadioButton;
      rbJA0in: TRadioButton;
      rbJA0out: TRadioButton;
      ScoreCoeffEdit: TEdit;
      Label3: TLabel;
      rbIARU: TRadioButton;
      rbAllAsian: TRadioButton;
      rbIOTA: TRadioButton;
      rbARRL10: TRadioButton;
      rbKCJ: TRadioButton;
      rbWAE: TRadioButton;
    OldSelectButton: TSpeedButton;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    radioSingleOp: TRadioButton;
    radioMultiOpMultiTx: TRadioButton;
    radioMultiOpSingleTx: TRadioButton;
    radioMultiOpTwoTx: TRadioButton;
    comboTxNo: TComboBox;
    Label2: TLabel;
      procedure FormCreate(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure rbCQWWClick(Sender: TObject);
      procedure rbGeneralEnter(Sender: TObject);
      procedure rbGeneralExit(Sender: TObject);
      procedure SelectButtonClick(Sender: TObject);
      procedure rbALLJAClick(Sender: TObject);
      procedure rbPediClick(Sender: TObject);
      procedure rbACAGClick(Sender: TObject);
      procedure rb6DClick(Sender: TObject);
      procedure rbFDClick(Sender: TObject);
      procedure rbJA0inClick(Sender: TObject);
      procedure rbARRLWClick(Sender: TObject);
      procedure rbAPSprintClick(Sender: TObject);
      procedure OpGroupClick(Sender: TObject);
      procedure UserDefClick(Sender: TObject);
      procedure rbIARUClick(Sender: TObject);
      procedure rbIOTAClick(Sender: TObject);
      procedure rbARRL10Click(Sender: TObject);
      procedure rbARRL10Exit(Sender: TObject);
      procedure FnugrySingleInstance1AlreadyRunning(Sender: TObject; hPrevInst, hPrevWnd: Integer);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure rbKCJClick(Sender: TObject);
      procedure rbWAEClick(Sender: TObject);
      procedure OKButtonClick(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure OldSelectButtonClick(Sender: TObject);
   private
      FSelectContest: array[0..20] of TRadioButton;
      FBandTemp: Integer; // temporary storage for bandgroup.itemindex
      FCFGFileName: string;
      FSelectDlg: TSelectUserDefinedContest;
      FModernStyle: Boolean;

      procedure EnableEveryThing;

      function GetContestCategory(): TContestCategory;
      function GetBandGroupIndex(): Integer;
      function GetContestMode(): TContestMode;
      function GetCallsign(): string;
      function GetContestNumber(): Integer;
      procedure SetContestNumber(v: Integer);
      function GetTxNumber(): Integer;
      function GetScoreCoeff(): Extended;
      function GetGeneralName(): string;
      function GetPostContest(): Boolean;
      procedure SelectFirstBand();
   public
      property CFGFileName: string read FCFGFileName;
      property ContestCategory: TContestCategory read GetContestCategory;
      property BandGroupIndex: Integer read GetBandGroupIndex;
      property ContestMode: TContestMode read GetContestMode;
      property Callsign: string read GetCallsign;
      property ContestNumber: Integer read GetContestNumber write SetContestNumber;
      property TxNumber: Integer read GetTxNumber;
      property ScoreCoeff: Extended read GetScoreCoeff;
      property GeneralName: string read GetGeneralName;
      property PostContest: Boolean read GetPostContest;
   end;

implementation

{$R *.DFM}

procedure TMenuForm.FormCreate(Sender: TObject);
begin
   FCFGFileName := '';
   FSelectContest[0] := rbALLJA;
   FSelectContest[1] := rb6D;
   FSelectContest[2] := rbFD;
   FSelectContest[3] := rbACAG;
   FSelectContest[4] := rbJA0in;
   FSelectContest[5] := rbJA0out;
   FSelectContest[6] := rbKCJ;
   FSelectContest[7] := rbJIDXDX;
   FSelectContest[8] := rbPedi;
   FSelectContest[9] := rbGeneral;
   FSelectContest[10] := rbCQWW;
   FSelectContest[11] := rbCQWPX;
   FSelectContest[12] := rbJIDXJA;
   FSelectContest[13] := rbAPSprint;
   FSelectContest[14] := rbARRLW;
   FSelectContest[15] := rbARRLDX;
   FSelectContest[16] := rbARRL10;
   FSelectContest[17] := rbIARU;
   FSelectContest[18] := rbAllAsian;
   FSelectContest[19] := rbIOTA;
   FSelectContest[20] := rbWAE;

   FSelectDlg := TSelectUserDefinedContest.Create(Self);
   FModernStyle := True;
end;

procedure TMenuForm.FormDestroy(Sender: TObject);
begin
   FSelectDlg.Release();
end;

procedure TMenuForm.FormShow(Sender: TObject);
begin
   if dmZlogGlobal.Band = 0 then begin
      BandGroup.ItemIndex := 0;
   end
   else begin
      BandGroup.ItemIndex := OldBandOrd(TBand(dmZlogGlobal.Band - 1)) + 1;
   end;

   ModeGroup.ItemIndex := Integer(dmZlogGlobal.ContestMode);

   case dmZlogGlobal.ContestCategory of
      ccSingleOp: begin
         radioSingleOp.Checked := True;
      end;

      ccMultiOpMultiTx: begin
         radioMultiOpMultiTx.Checked := True;
      end;

      ccMultiOpSingleTx: begin
         radioMultiOpSingleTx.Checked := True;
      end;

      ccMultiOpTwoTx: begin
         radioMultiOpTwoTx.Checked := True;
      end;
   end;

   editCallsign.Text := dmZlogGlobal.MyCall;

   EnableEveryThing;

   ContestNumber := dmZlogGlobal.ContestMenuNo;

   if rbGeneral.Checked then begin
      SelectButton.Enabled := True;
      OldSelectButton.Enabled := True;
   end;
end;

procedure TMenuForm.rbCQWWClick(Sender: TObject);
begin
   if ModeGroup.ItemIndex in [0, 3] then begin
      ModeGroup.ItemIndex := 1;
   end;
end;

procedure TMenuForm.rbGeneralEnter(Sender: TObject);
begin
// SelectButton.Enabled := True;
end;

procedure TMenuForm.rbGeneralExit(Sender: TObject);
begin
   if FSelectDlg.SelectedContest <> nil then begin
      OKButton.Enabled := True;
   end;
end;

procedure TMenuForm.SelectButtonClick(Sender: TObject);
begin
   FSelectDlg.CfgFolder := dmZlogGlobal.Settings._cfgdatpath;

   FSelectDlg.InitialContestName := rbGeneral.Caption;

   if FSelectDlg.ShowModal() = mrCancel then begin
      Exit;
   end;

   dmZlogGlobal.Settings._cfgdatpath := FSelectDlg.CfgFolder;

   FCFGFileName := FSelectDlg.SelectedContest.Fullpath;
   rbGeneral.Caption := FSelectDlg.SelectedContest.ContestName;
   ScoreCoeffEdit.Enabled := FSelectDlg.SelectedContest.Coeff;

   FModernStyle := True;
   OKButton.Enabled := True;
end;

procedure TMenuForm.OldSelectButtonClick(Sender: TObject);
var
   D: TUserDefinedContest;
begin
   CFGOpenDialog.InitialDir := dmZlogGlobal.Settings._cfgdatpath;
   if CFGOpenDialog.Execute = False then begin
      Exit;
   end;

   FCFGFileName := CFGOpenDialog.FileName;

   D := TUserDefinedContest.Parse(FCFGFileName);
   rbGeneral.Caption := D.ContestName;
   ScoreCoeffEdit.Enabled := D.Coeff;
   D.Free();

   FModernStyle := False;
   OKButton.Enabled := True;
end;

procedure TMenuForm.OKButtonClick(Sender: TObject);
var
   i: Integer;
begin
   if editCallsign.Text = '' then begin
      Application.MessageBox(PChar('Please enter your callsign'), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      editCallsign.SetFocus();
      Exit;
   end;

   dmZLogGlobal.ClearParamImportedFlag();

   if (rbGeneral.Checked = True) and (FModernStyle = True) then begin
      // prov,cityéÊçû
      if FSelectDlg.ImportProvCity = True then begin
         dmZLogGlobal.Settings._prov := FSelectDlg.SelectedContest.Prov;
         dmZLogGlobal.Settings._city := FSelectDlg.SelectedContest.City;
         dmZLogGlobal.Settings.ProvCityImported := True;
      end;

      // f1Å`f4éÊçû
      for i := 1 to 4 do begin
         if FSelectDlg.ImportCwMessage[i] = True then begin
            dmZLogGlobal.Settings.CW.CWStrBank[1, i] := FSelectDlg.SelectedContest.CwMessageA[i];
            dmZLogGlobal.Settings.CW.CWStrImported[1, i] := True;
         end;
      end;
   end;

   ModalResult := mrOK;
end;

procedure TMenuForm.EnableEveryThing;
var
   i: Integer;
begin
   for i := 0 to BandGroup.Items.Count - 1 do begin
      BandGroup.Controls[i].Enabled := True;
   end;

   radioSingleOp.Enabled := True;
   radioMultiOpMultiTx.Enabled := True;
   radioMultiOpSingleTx.Enabled := True;
   radioMultiOpTwoTx.Enabled := True;

   if radioSingleOp.Checked = True then OpGroupClick(radioSingleOp);
   if radioMultiOpMultiTx.Checked = True then OpGroupClick(radioMultiOpMultiTx);
   if radioMultiOpSingleTx.Checked = True then OpGroupClick(radioMultiOpSingleTx);
   if radioMultiOpTwoTx.Checked = True then OpGroupClick(radioMultiOpTwoTx);

   for i := 0 to ModeGroup.Items.Count - 1 do begin
      ModeGroup.Controls[i].Enabled := True;
   end;

   SelectButton.Enabled := False;
   OldSelectButton.Enabled := False;
   ScoreCoeffEdit.Enabled := False;
   OKButton.Enabled := True;
end;

procedure TMenuForm.rbALLJAClick(Sender: TObject);
var
   i: Integer;
begin
   EnableEveryThing;
//   BandGroup.Controls[1].Enabled := False;
   for i := 8 to 13 do begin
      BandGroup.Controls[i].Enabled := False;
   end;

// ModeGroup.Controls[2].Enabled := False;
   ModeGroup.Controls[3].Enabled := False;

   SelectFirstBand();
end;

procedure TMenuForm.rbPediClick(Sender: TObject);
begin
   EnableEveryThing;
end;

procedure TMenuForm.rbACAGClick(Sender: TObject);
begin
   EnableEveryThing;
//   BandGroup.Controls[1].Enabled := False;
// ModeGroup.Controls[2].Enabled := False;
   ModeGroup.Controls[3].Enabled := False;

   SelectFirstBand();
end;

procedure TMenuForm.rb6DClick(Sender: TObject);
var
   i: Integer;
begin
   EnableEveryThing;
   for i := 1 to 6 do begin
      BandGroup.Controls[i].Enabled := False;
   end;

// ModeGroup.Controls[2].Enabled := False;
   ModeGroup.Controls[3].Enabled := False;

   SelectFirstBand();
end;

procedure TMenuForm.rbFDClick(Sender: TObject);
begin
   EnableEveryThing;
   ScoreCoeffEdit.Enabled := True;
//   BandGroup.Controls[1].Enabled := False;
// ModeGroup.Controls[2].Enabled := False;
   ModeGroup.Controls[3].Enabled := False;

   SelectFirstBand();
end;

procedure TMenuForm.rbJA0inClick(Sender: TObject);
var
   i: Integer;
begin
   EnableEveryThing;

   // ALL, 1.9M
   for i := 0 to 1 do begin
      BandGroup.Controls[i].Enabled := False;
   end;

   // 14M
   BandGroup.Controls[4].Enabled := False;

   // 50M and upper
   for i := 7 to 13 do begin
      BandGroup.Controls[i].Enabled := False;
   end;

   SelectFirstBand();

   ModeGroup.Controls[2].Enabled := False;
   ModeGroup.Controls[3].Enabled := False;

   radioSingleOp.Checked := True;
   radioMultiOpMultiTx.Enabled := False;
   comboTxNo.Enabled := False;
end;

procedure TMenuForm.rbARRLWClick(Sender: TObject);
var
   i: Integer;
begin
   EnableEveryThing;

   for i := 7 to 13 do begin
      BandGroup.Controls[i].Enabled := False;
   end;

   SelectFirstBand();

   ModeGroup.Controls[0].Enabled := False;
   ModeGroup.Controls[3].Enabled := False;
end;

procedure TMenuForm.rbAPSprintClick(Sender: TObject);
var
   i: Integer;
begin
   EnableEveryThing;

   for i := 1 to 13 do begin
      BandGroup.Controls[i].Enabled := False;
   end;

   SelectFirstBand();

   ModeGroup.Controls[0].Enabled := False;
   ModeGroup.Controls[3].Enabled := False;

   radioSingleOp.Checked := True;
   radioMultiOpMultiTx.Enabled := False;
   comboTxNo.Enabled := False;
end;

procedure TMenuForm.OpGroupClick(Sender: TObject);
var
   n: Integer;
begin
   n := TRadioButton(Sender).Tag;
   case n of
      // Single-Op
      0: begin
         comboTxNo.Enabled := False;
         comboTxNo.Items.CommaText := '0,1';
      end;

      // Multi-Op/Multi-Tx
      1: begin
         comboTxNo.Enabled := True;
         comboTxNo.Items.CommaText := TXLIST_MM;
      end;

      // Multi-Op/Single-Tx, Multi-Op/Two-Tx
      2, 3: begin
         comboTxNo.Enabled := True;
         comboTxNo.Items.CommaText := TXLIST_MS;
      end;
   end;

   comboTxNo.ItemIndex := comboTxNo.Items.IndexOf(IntToStr(dmZlogGlobal.TXNr));
end;

procedure TMenuForm.UserDefClick(Sender: TObject);
begin
   EnableEveryThing;
   if CFGFileName <> '' then begin
      if UsesCoeff(CFGFileName) then begin
         ScoreCoeffEdit.Enabled := True;
      end;
   end;

   if CFGFileName = '' then begin
      OKButton.Enabled := False;
   end;

   SelectButton.Enabled := True;
   OldSelectButton.Enabled := True;
end;

procedure TMenuForm.rbIARUClick(Sender: TObject);
var
   i: Integer;
begin
   EnableEveryThing;

   for i := 7 to 13 do
      BandGroup.Controls[i].Enabled := False;

   ModeGroup.Controls[3].Enabled := False;
end;

procedure TMenuForm.rbIOTAClick(Sender: TObject);
var
   i: Integer;
begin
   EnableEveryThing;
   BandGroup.Controls[1].Enabled := False;

   for i := 7 to 13 do begin
      BandGroup.Controls[i].Enabled := False;
   end;

   ModeGroup.Controls[3].Enabled := False;
end;

procedure TMenuForm.rbARRL10Click(Sender: TObject);
var
   i: Integer;
begin
   EnableEveryThing;
   for i := 0 to 5 do begin
      BandGroup.Controls[i].Enabled := False;
   end;

   for i := 7 to 13 do begin
      BandGroup.Controls[i].Enabled := False;
   end;

   FBandTemp := BandGroup.ItemIndex;

   BandGroup.ItemIndex := 6;
   ModeGroup.Controls[3].Enabled := False;
end;

procedure TMenuForm.rbARRL10Exit(Sender: TObject);
begin
   BandGroup.ItemIndex := FBandTemp;
end;

procedure TMenuForm.FnugrySingleInstance1AlreadyRunning(Sender: TObject; hPrevInst, hPrevWnd: Integer);
begin
   Close;
end;

procedure TMenuForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = ^X then rbKCJ.Visible := True;
   if Key = ^T then rbKCJ.Visible := True;
end;

procedure TMenuForm.rbKCJClick(Sender: TObject);
var i: Integer;
begin
   EnableEveryThing;
   for i := 8 to 13 do
      BandGroup.Controls[i].Enabled := False;

   ModeGroup.Controls[0].Enabled := False;
   ModeGroup.Controls[2].Enabled := False;
   ModeGroup.Controls[3].Enabled := False;

   radioSingleOp.Checked := True;
   radioMultiOpMultiTx.Enabled := False;
   radioMultiOpSingleTx.Enabled := False;
   radioMultiOpTwoTx.Enabled := False;
   comboTxNo.Enabled := False;
end;

procedure TMenuForm.rbWAEClick(Sender: TObject);
var i: Integer;
begin
   EnableEveryThing;
   BandGroup.Controls[1].Enabled := False;

   for i := 7 to 13 do
      BandGroup.Controls[i].Enabled := False;

   ModeGroup.Controls[0].Enabled := False;
   ModeGroup.Controls[3].Enabled := False;
end;

function TMenuForm.GetContestCategory(): TContestCategory;
begin
   if radioSingleOp.Checked = True then begin
      Result := ccSingleOp;
   end
   else if radioMultiOpMultiTx.Checked = True then begin
      Result := ccMultiOpMultiTx;
   end
   else if radioMultiOpSingleTx.Checked = True then begin
      Result := ccMultiOpSingleTx;
   end
   else if radioMultiOpTwoTx.Checked = True then begin
      Result := ccMultiOpTwoTx;
   end
   else begin
      Result := ccSingleOp;
   end;
end;

// WARCÉoÉìÉhÇçló∂ÇµÇΩî‘çÜÇï‘Ç∑
// ALL:0  Å® 0
// 1.9:1     1
// 3.5:2     2
// 7  :3     3
// 10M:      4
// 14 :4     5  +1
// 18 :      6
// 21 :5     7  +2
// 24 :      8
// 28 :6     9  +3
// 50 :7     10
function TMenuForm.GetBandGroupIndex(): Integer;
begin
   case BandGroup.ItemIndex of
      0 .. 3:  Result := BandGroup.ItemIndex;
      4:       Result := BandGroup.ItemIndex + 1;
      5:       Result := BandGroup.ItemIndex + 2;
      6 .. 13: Result := BandGroup.ItemIndex + 3;
      else     Result := BandGroup.ItemIndex;
   end;
end;

function TMenuForm.GetContestMode(): TContestMode;
begin
   Result := TContestMode(ModeGroup.ItemIndex);
end;

function TMenuForm.GetCallsign(): string;
begin
   Result := editCallsign.Text;
end;

function TMenuForm.GetContestNumber(): Integer;
var
   i: Integer;
begin
   for i := Low(FSelectContest) to High(FSelectContest) do begin
      if TRadioButton(FSelectContest[i]).Checked then begin
         Result := i;
         Exit;
      end;
   end;
   Result := -1;
end;

procedure TMenuForm.SetContestNumber(v: Integer);
begin
   TRadioButton(FSelectContest[v]).Checked := True;
   TRadioButton(FSelectContest[v]).OnClick(FSelectContest[v]);
end;

function TMenuForm.GetTxNumber(): Integer;
begin
   Result := StrToIntDef(comboTxNo.Text, 0);
end;

function TMenuForm.GetScoreCoeff(): Extended;
var
   E: Extended;
begin
   if ScoreCoeffEdit.Enabled then begin
      E := StrToFloatDef(ScoreCoeffEdit.Text, 1);
   end
   else begin
      E := 0;
   end;

   Result := E;
end;

function TMenuForm.GetGeneralName(): string;
begin
   Result := rbGeneral.Caption;
end;

function TMenuForm.GetPostContest(): Boolean;
begin
   Result := CheckBox1.Checked;
end;

procedure TMenuForm.SelectFirstBand();
var
   i: Integer;
begin
   for i := 0 to BandGroup.Items.Count - 1 do begin
      if BandGroup.Controls[i].Enabled = True then begin
         BandGroup.ItemIndex := i;
         Exit;
      end;
   end;
end;

end.
