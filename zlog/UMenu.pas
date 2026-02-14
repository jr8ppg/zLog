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
      ContestGroup: TGroupBox;
      rbALLJA: TRadioButton;
      rb6D: TRadioButton;
      rbFD: TRadioButton;
      rbACAG: TRadioButton;
      ModeGroup: TRadioGroup;
      rbCQWW: TRadioButton;
      rbJIDXJA: TRadioButton;
      rbCQWPX: TRadioButton;
      rbPedi: TRadioButton;
      rbJIDXDX: TRadioButton;
      rbGeneral: TRadioButton;
      CFGOpenDialog: TOpenDialog;
      SelectButton: TSpeedButton;
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
      rbWAE: TRadioButton;
      GroupBox1: TGroupBox;
      radioSingleOp: TRadioButton;
      radioMultiOpMultiTx: TRadioButton;
      radioMultiOpSingleTx: TRadioButton;
      radioMultiOpTwoTx: TRadioButton;
      comboTxNo: TComboBox;
      Label2: TLabel;
    rbNYP: TRadioButton;
      procedure FormCreate(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure rbGeneralEnter(Sender: TObject);
      procedure rbGeneralExit(Sender: TObject);
      procedure SelectButtonClick(Sender: TObject);
      procedure SelectContestClick(Sender: TObject);
      procedure OpGroupClick(Sender: TObject);
      procedure OKButtonClick(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
   private
      FSelectContest: array[0..20] of TRadioButton;
      FCFGFileName: string;
      FSelectDlg: TSelectUserDefinedContest;
      FModernStyle: Boolean;
      FSelectedContest: TUserDefinedContest;
      FNeedFree: Boolean;

      procedure EnableEveryThing(contestno: Integer);

      function GetContestCategory(): TContestCategory;
      function GetContestMode(): TContestMode;
      function GetContestNumber(): Integer;
      procedure SetContestNumber(v: Integer);
      function GetTxNumber(): Integer;
      function GetScoreCoeff(): Extended;
      function GetGeneralName(): string;
      procedure FreeSelectedContest();
   public
      property CFGFileName: string read FCFGFileName;
      property ContestCategory: TContestCategory read GetContestCategory;
      property ContestMode: TContestMode read GetContestMode;
      property ContestNumber: Integer read GetContestNumber write SetContestNumber;
      property TxNumber: Integer read GetTxNumber;
      property ScoreCoeff: Extended read GetScoreCoeff;
      property GeneralName: string read GetGeneralName;
   end;

resourcestring
   UMenu_PleaseEnterYourCallsign = 'Please enter your callsign';

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
   FSelectContest[6] := rbNYP;
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

   FSelectedContest := nil;
   FNeedFree := False;
end;

procedure TMenuForm.FormDestroy(Sender: TObject);
begin
   FreeSelectedContest();
   FSelectDlg.Release();
end;

procedure TMenuForm.FormShow(Sender: TObject);
var
   parser: TUserDefinedContest;
begin
   ModeGroup.ItemIndex := Integer(dmZLogGlobal.ContestMode);

   case dmZLogGlobal.ContestCategory of
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

   ContestNumber := dmZLogGlobal.ContestMenuNo;

   EnableEveryThing(ContestNumber);

   if rbGeneral.Checked then begin
      // 前回使用のCFGファイル
      FCFGFileName := dmZLogGlobal.Settings.FLastCFGFileName;

      // 無ければCFGDATパスの同名ファイル
      if (FCFGFileName <> '') and (FileExists(FCFGFileName) = False) then begin
         FCFGFileName := dmZLogGlobal.CfgDatPath + ExtractFileName(FCFGFileName);

         // さらに無ければ前回選択コンテストはなし
         if FileExists(FCFGFileName) = False then begin
            FCFGFileName := '';
         end;
      end;

      if FCFGFileName <> '' then begin
         parser := TUserDefinedContest.Parse(FCFGFileName);

         FCFGFileName := parser.Fullpath;
         rbGeneral.Caption := parser.ContestName;
         ScoreCoeffEdit.Enabled := parser.Coeff;

         FreeSelectedContest();
         FSelectedContest := parser;
         FNeedFree := True;

         OKButton.Enabled := True;
      end;

      SelectButton.Enabled := True;
   end;
end;

procedure TMenuForm.rbGeneralEnter(Sender: TObject);
begin
// SelectButton.Enabled := True;
end;

procedure TMenuForm.rbGeneralExit(Sender: TObject);
begin
   if FSelectedContest <> nil then begin
      OKButton.Enabled := True;
   end;
end;

procedure TMenuForm.SelectButtonClick(Sender: TObject);
begin
   FSelectDlg.CfgFolder := dmZLogGlobal.CfgDatPath;

   FSelectDlg.InitialContestName := rbGeneral.Caption;

   if FSelectDlg.ShowModal() = mrCancel then begin
      Exit;
   end;

   // フォルダ未設定時は記録する
   if dmZLogGlobal.CfgDatPath = '' then begin
      dmZLogGlobal.CfgDatPath := FSelectDlg.CfgFolder;
   end;

   FCFGFileName := FSelectDlg.SelectedContest.Fullpath;
   rbGeneral.Caption := FSelectDlg.SelectedContest.ContestName;
   ScoreCoeffEdit.Enabled := FSelectDlg.SelectedContest.Coeff;

   FreeSelectedContest();
   FSelectedContest := FSelectDlg.SelectedContest;

   FModernStyle := True;
   OKButton.Enabled := True;
end;

procedure TMenuForm.OKButtonClick(Sender: TObject);
var
   i: Integer;
begin
   dmZLogGlobal.Settings.FLastCFGFileName := FCFGFileName;

   ModalResult := mrOK;
end;

procedure TMenuForm.EnableEveryThing(contestno: Integer);
var
   i: Integer;
begin
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
   ScoreCoeffEdit.Enabled := False;
   OKButton.Enabled := True;

   case contestno of
      // ALLJA,6D,ACAG,ARRL10,IARU,IOTA
      0, 1, 3, 108, 109, 111: begin
         ScoreCoeffEdit.Enabled := False;
         ModeGroup.Controls[3].Enabled := False;
         ModeGroup.ItemIndex := 0;
      end;

      // FD
      2: begin
         ScoreCoeffEdit.Enabled := True;
         ModeGroup.Controls[3].Enabled := False;
         ModeGroup.ItemIndex := 0;
      end;

      // ALL JA0
      4, 5: begin
         ScoreCoeffEdit.Enabled := False;
         ModeGroup.Controls[2].Enabled := False;
         ModeGroup.Controls[3].Enabled := False;
         ModeGroup.ItemIndex := 0;

         radioSingleOp.Checked := True;
         radioMultiOpMultiTx.Enabled := False;
         comboTxNo.Enabled := False;
      end;

      // NYP
      6: begin
         ScoreCoeffEdit.Enabled := False;
         radioSingleOp.Checked := True;
         ModeGroup.ItemIndex := 0;
      end;

      // CQWW,CQWPX,JIDX,ARRLDX(W/VE),ARRLDX(DX),ALLASIA,JIDX(DX)
      101, 102, 103, 106, 107, 110, 112, 113: begin
         ScoreCoeffEdit.Enabled := False;
         ModeGroup.Controls[0].Enabled := False;
         ModeGroup.ItemIndex := 1;
      end;

      // APSprint
      105: begin
         ModeGroup.Controls[0].Enabled := False;
         ModeGroup.Controls[3].Enabled := False;
         ModeGroup.ItemIndex := 1;
         radioSingleOp.Checked := True;
         radioMultiOpMultiTx.Enabled := False;
         comboTxNo.Enabled := False;
      end;

      // PEDI
      200: begin
         ScoreCoeffEdit.Enabled := False;
         ModeGroup.ItemIndex := 0;
      end;

      // User Defined Contest
      959: begin
         if CFGFileName <> '' then begin
            if UsesCoeff(CFGFileName) then begin
               ScoreCoeffEdit.Enabled := True;
            end;
         end;

         if CFGFileName = '' then begin
            OKButton.Enabled := False;
         end;

         SelectButton.Enabled := True;
         ModeGroup.ItemIndex := 0;
      end;
   end;
end;

procedure TMenuForm.SelectContestClick(Sender: TObject);
begin
   EnableEveryThing(TRadioButton(Sender).Tag);
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

   comboTxNo.ItemIndex := comboTxNo.Items.IndexOf(IntToStr(dmZLogGlobal.TXNr));
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

function TMenuForm.GetContestMode(): TContestMode;
begin
   Result := TContestMode(ModeGroup.ItemIndex);
end;

function TMenuForm.GetContestNumber(): Integer;
var
   i: Integer;
begin
   for i := Low(FSelectContest) to High(FSelectContest) do begin
      if Assigned(FSelectContest[i]) and TRadioButton(FSelectContest[i]).Checked then begin
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

procedure TMenuForm.FreeSelectedContest();
begin
   if Assigned(FSelectedContest) and FNeedFree then begin
      FSelectedContest.Free();
   end;
   FSelectedContest := nil;
   FNeedFree := False;
end;

end.
