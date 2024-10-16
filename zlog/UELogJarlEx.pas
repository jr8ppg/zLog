unit UELogJarlEx;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IniFiles, UITypes, Math, DateUtils,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogExtension, Vcl.ComCtrls;

type
  TformELogJarlEx = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    edContestName: TEdit;
    edCallsign: TEdit;
    edOpCallsign: TEdit;
    edCategoryCode: TEdit;
    edFDCoefficient: TEdit;
    edTEL: TEdit;
    edOPName: TEdit;
    edEMail: TEdit;
    edPower: TEdit;
    edQTH: TEdit;
    edClubID: TEdit;
    edPowerSupply: TEdit;
    mComments: TMemo;
    edDate: TEdit;
    edSignature: TEdit;
    mAddress: TMemo;
    SaveDialog1: TSaveDialog;
    labelMultiOpList: TLabel;
    memoMultiOpList: TMemo;
    Panel1: TPanel;
    buttonCreateLog: TButton;
    buttonSave: TButton;
    buttonCancel: TButton;
    labelLicenseDate: TLabel;
    datetimeLicenseDate: TDateTimePicker;
    labelAge: TLabel;
    comboAge: TComboBox;
    checkFieldExtend: TCheckBox;
    GroupBox1: TGroupBox;
    mOath: TMemo;
    radioOrganizerJarl: TRadioButton;
    radioOrganizerOther: TRadioButton;
    groupScoreAdjust: TGroupBox;
    Label22: TLabel;
    labelTotalScore: TLabel;
    Label19: TLabel;
    checkBand00: TCheckBox;
    editQso00: TEdit;
    editMulti00: TEdit;
    editPoints00: TEdit;
    checkBand01: TCheckBox;
    editQso01: TEdit;
    editMulti01: TEdit;
    editPoints01: TEdit;
    checkBand02: TCheckBox;
    editQso02: TEdit;
    editMulti02: TEdit;
    editPoints02: TEdit;
    checkBand04: TCheckBox;
    editQso04: TEdit;
    editMulti04: TEdit;
    editPoints04: TEdit;
    checkBand06: TCheckBox;
    editQso06: TEdit;
    editMulti06: TEdit;
    editPoints06: TEdit;
    checkBand08: TCheckBox;
    editQso08: TEdit;
    editMulti08: TEdit;
    editPoints08: TEdit;
    checkBand09: TCheckBox;
    editQso09: TEdit;
    editMulti09: TEdit;
    editPoints09: TEdit;
    checkBand10: TCheckBox;
    editQso10: TEdit;
    editMulti10: TEdit;
    editPoints10: TEdit;
    checkBand11: TCheckBox;
    editQso11: TEdit;
    editMulti11: TEdit;
    editPoints11: TEdit;
    checkBand12: TCheckBox;
    editQso12: TEdit;
    editMulti12: TEdit;
    editPoints12: TEdit;
    checkBand13: TCheckBox;
    editQso13: TEdit;
    editMulti13: TEdit;
    editPoints13: TEdit;
    checkBand14: TCheckBox;
    editQso14: TEdit;
    editMulti14: TEdit;
    editPoints14: TEdit;
    checkBand15: TCheckBox;
    editQso15: TEdit;
    editMulti15: TEdit;
    editPoints15: TEdit;
    editFDCOEFF: TEdit;
    editTotalScore: TEdit;
    editQsoTotal: TEdit;
    editMulti1Total: TEdit;
    editPointsTotal: TEdit;
    Label20: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label24: TLabel;
    editMulti2_00: TEdit;
    editMulti2_01: TEdit;
    editMulti2_02: TEdit;
    editMulti2_04: TEdit;
    editMulti2_06: TEdit;
    editMulti2_08: TEdit;
    editMulti2_09: TEdit;
    editMulti2_10: TEdit;
    editMulti2_11: TEdit;
    editMulti2_12: TEdit;
    editMulti2_13: TEdit;
    editMulti2_14: TEdit;
    editMulti2_15: TEdit;
    editMulti2Total: TEdit;
    TabControl1: TTabControl;
    labelCategoryName: TLabel;
    edCategoryName: TEdit;
    labelClubName: TLabel;
    edClubName: TEdit;
    labelEquipment: TLabel;
    memoEquipment: TMemo;
    edLicense: TEdit;
    rPowerType: TRadioGroup;
    labelLicense: TLabel;
    procedure buttonCreateLogClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonSaveClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure edFDCoefficientChange(Sender: TObject);
    procedure radioOrganizerJarlClick(Sender: TObject);
    procedure radioOrganizerOtherClick(Sender: TObject);
    procedure checkBandClick(Sender: TObject);
    procedure edCategoryCodeExit(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private �錾 }
    FScoreBand: array[b19..HiBand] of TCheckBox;
    FScoreQso: array[b19..HiBand] of TEdit;
    FScoreMulti1: array[b19..HiBand] of TEdit;
    FScoreMulti2: array[b19..HiBand] of TEdit;
    FScorePoints: array[b19..HiBand] of TEdit;

    procedure CreateELogR1();
    procedure CreateELogR2();
    procedure RemoveBlankLines(M : TMemo);
    procedure InitializeFields;
    procedure WriteSummarySheetR1(var f: TextFile);
    procedure WriteLogSheetR1(var f: TextFile);
    procedure WriteSummarySheetR2(var f: TextFile);
    procedure WriteLogSheetR2(var f: TextFile; fExtend: Boolean);
    function FormatQSO_v1(q: TQSO; fValid: Boolean): string;
    function FormatQSO_v2(q: TQSO; fExtend: Boolean): string;
    function IsNewcomer(cate: string): Boolean;
    function IsSeniorJunior(cate: string): Boolean;
    procedure CalcAll();
    procedure SetBandUsed(b: TBand);
  public
    { Public �錾 }
  end;

const
  TAB = #09;

implementation

uses
  Main;

{$R *.dfm}

procedure TformELogJarlEx.FormCreate(Sender: TObject);
begin
   FScoreBand[b19]   := checkBand00;
   FScoreBand[b35]   := checkBand01;
   FScoreBand[b7]    := checkBand02;
   FScoreBand[b10]   := nil;
   FScoreBand[b14]   := checkBand04;
   FScoreBand[b18]   := nil;
   FScoreBand[b21]   := checkBand06;
   FScoreBand[b24]   := nil;
   FScoreBand[b28]   := checkBand08;
   FScoreBand[b50]   := checkBand09;
   FScoreBand[b144]  := checkBand10;
   FScoreBand[b430]  := checkBand11;
   FScoreBand[b1200] := checkBand12;
   FScoreBand[b2400] := checkBand13;
   FScoreBand[b5600] := checkBand14;
   FScoreBand[b10g]  := checkBand15;
   FScoreQso[b19]    := editQso00;
   FScoreQso[b35]    := editQso01;
   FScoreQso[b7]     := editQso02;
   FScoreQso[b10]    := nil;
   FScoreQso[b14]    := editQso04;
   FScoreQso[b18]    := nil;
   FScoreQso[b21]    := editQso06;
   FScoreQso[b24]    := nil;
   FScoreQso[b28]    := editQso08;
   FScoreQso[b50]    := editQso09;
   FScoreQso[b144]   := editQso10;
   FScoreQso[b430]   := editQso11;
   FScoreQso[b1200]  := editQso12;
   FScoreQso[b2400]  := editQso13;
   FScoreQso[b5600]  := editQso14;
   FScoreQso[b10g]   := editQso15;
   FScoreMulti1[b19]  := editMulti00;
   FScoreMulti1[b35]  := editMulti01;
   FScoreMulti1[b7]   := editMulti02;
   FScoreMulti1[b10]  := nil;
   FScoreMulti1[b14]  := editMulti04;
   FScoreMulti1[b18]  := nil;
   FScoreMulti1[b21]  := editMulti06;
   FScoreMulti1[b24]  := nil;
   FScoreMulti1[b28]  := editMulti08;
   FScoreMulti1[b50]  := editMulti09;
   FScoreMulti1[b144] := editMulti10;
   FScoreMulti1[b430] := editMulti11;
   FScoreMulti1[b1200] := editMulti12;
   FScoreMulti1[b2400] := editMulti13;
   FScoreMulti1[b5600] := editMulti14;
   FScoreMulti1[b10g] := editMulti15;
   FScoreMulti2[b19]  := editMulti2_00;
   FScoreMulti2[b35]  := editMulti2_01;
   FScoreMulti2[b7]   := editMulti2_02;
   FScoreMulti2[b10]  := nil;
   FScoreMulti2[b14]  := editMulti2_04;
   FScoreMulti2[b18]  := nil;
   FScoreMulti2[b21]  := editMulti2_06;
   FScoreMulti2[b24]  := nil;
   FScoreMulti2[b28]  := editMulti2_08;
   FScoreMulti2[b50]  := editMulti2_09;
   FScoreMulti2[b144] := editMulti2_10;
   FScoreMulti2[b430] := editMulti2_11;
   FScoreMulti2[b1200] := editMulti2_12;
   FScoreMulti2[b2400] := editMulti2_13;
   FScoreMulti2[b5600] := editMulti2_14;
   FScoreMulti2[b10g] := editMulti2_15;
   FScorePoints[b19] := editPoints00;
   FScorePoints[b35] := editPoints01;
   FScorePoints[b7]  := editPoints02;
   FScorePoints[b10] := nil;
   FScorePoints[b14] := editPoints04;
   FScorePoints[b18] := nil;
   FScorePoints[b21] := editPoints06;
   FScorePoints[b24] := nil;
   FScorePoints[b28] := editPoints08;
   FScorePoints[b50] := editPoints09;
   FScorePoints[b144] := editPoints10;
   FScorePoints[b430] := editPoints11;
   FScorePoints[b1200] := editPoints12;
   FScorePoints[b2400] := editPoints13;
   FScorePoints[b5600] := editPoints14;
   FScorePoints[b10g] := editPoints15;

   editFdcoeff.Enabled := MyContest.UseCoeff;

   edFDCoefficient.Enabled := MyContest.UseCoeff;

   InitializeFields;
end;

procedure TformELogJarlEx.FormShow(Sender: TObject);
begin
   TabControl1Change(TabControl1);
end;

procedure TformELogJarlEx.RemoveBlankLines(M: TMemo);
var
   i: integer;
begin
   i := M.Lines.Count - 1;
   while i >= 0 do begin
      if M.Lines[i] = '' then
         M.Lines.Delete(i)
      else
         break;
      dec(i);
   end;
end;

procedure TformELogJarlEx.InitializeFields;
var
   ini: TMemIniFile;
   i: Integer;
   str: string;
   fSavedBack: Boolean;
   b: TBand;
begin
   fSavedBack := Log.Saved;
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      TabControl1.TabIndex := ini.ReadInteger('SummaryInfo', 'Version', 0);

      edContestName.Text   := MyContest.Name;
      edCategoryCode.Text  := ini.ReadString('SummaryInfo', 'CategoryCode', '');
      edCategoryName.Text  := ini.ReadString('SummaryInfo', 'CategoryName', '');
      edCallsign.Text      := ini.ReadString('Categories', 'MyCall', 'Your call sign');
      edOpCallsign.Text    := ini.ReadString('SummaryInfo', 'OperatorCallsign', '');

      if Log.ScoreCoeff > 0 then begin
         edFDCoefficient.Text := FloatToStr(Log.ScoreCoeff);
      end
      else begin
         edFDCoefficient.Text := '';
      end;

      mAddress.Clear;
      mAddress.Lines.Add(ini.ReadString('SummaryInfo', 'Address1', '��'));
      mAddress.Lines.Add(ini.ReadString('SummaryInfo', 'Address2', ''));
      mAddress.Lines.Add(ini.ReadString('SummaryInfo', 'Address3', ''));
      mAddress.Lines.Add(ini.ReadString('SummaryInfo', 'Address4', ''));
      mAddress.Lines.Add(ini.ReadString('SummaryInfo', 'Address5', ''));
      RemoveBlankLines(mAddress);

      edTEL.Text           := ini.ReadString('SummaryInfo', 'Telephone', '');
      edOPName.Text        := ini.ReadString('SummaryInfo', 'OperatorName', '');
      edEMail.Text         := ini.ReadString('SummaryInfo', 'EMail', '');
      edLicense.Text       := ini.ReadString('SummaryInfo', 'License', '');
      edPower.Text         := ini.ReadString('SummaryInfo', 'Power', '');
      rPowerType.ItemIndex := ini.ReadInteger('SummaryInfo','PowerType',0);
      edQTH.Text           := ini.ReadString('SummaryInfo', 'QTH', '');
      edPowerSupply.Text   := ini.ReadString('SummaryInfo', 'PowerSupply', '');

      memoEquipment.Clear;
      memoEquipment.Lines.Add(ini.ReadString('SummaryInfo', 'Equipment1', ''));
      memoEquipment.Lines.Add(ini.ReadString('SummaryInfo', 'Equipment2', ''));
      memoEquipment.Lines.Add(ini.ReadString('SummaryInfo', 'Equipment3', ''));
      memoEquipment.Lines.Add(ini.ReadString('SummaryInfo', 'Equipment4', ''));
      memoEquipment.Lines.Add(ini.ReadString('SummaryInfo', 'Equipment5', ''));
      RemoveBlankLines(memoEquipment);

      datetimeLicenseDate.Date := ini.ReadDate('SummaryInfo', 'LicenseDate', EncodeDate(2000, 1, 1));
      comboAge.Text        := ini.ReadString('SummaryInfo', 'Age', '');

      mComments.Clear;
      mComments.Lines.Add(ini.ReadString('SummaryInfo', 'Comment1', ''));
      mComments.Lines.Add(ini.ReadString('SummaryInfo', 'Comment2', ''));
      mComments.Lines.Add(ini.ReadString('SummaryInfo', 'Comment3', ''));
      mComments.Lines.Add(ini.ReadString('SummaryInfo', 'Comment4', ''));
      mComments.Lines.Add(ini.ReadString('SummaryInfo', 'Comment5', ''));
      mComments.Lines.Add(ini.ReadString('SummaryInfo', 'Comment6', ''));
      mComments.Lines.Add(ini.ReadString('SummaryInfo', 'Comment7', ''));
      mComments.Lines.Add(ini.ReadString('SummaryInfo', 'Comment8', ''));
      mComments.Lines.Add(ini.ReadString('SummaryInfo', 'Comment9', ''));
      mComments.Lines.Add(ini.ReadString('SummaryInfo', 'Comment10', ''));
      RemoveBlankLines(mComments);

      for i := 0 to dmZlogGlobal.OpList.Count - 1 do begin
         str := dmZlogGlobal.OpList[i].Callsign;
         memoMultiOpList.Lines.Add(str);
      end;

      edClubID.Text        := ini.ReadString('SummaryInfo', 'ClubID', '');
      edClubName.Text      := ini.ReadString('SummaryInfo', 'ClubName', '');

      mOath.Clear;
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath1',
         '���́AJARL����' + '�̃R���e�X�g�K�񂨂�ѓd�g�@�߂ɂ��������^�p�������ʁA����' +
         '�ɒ�o����T�}���[�V�[�g����у��O�V�[�g�Ȃǂ������Ƒ����' +
         '�����̂ł��邱�Ƃ��A���̖��_�ɂ����Đ����܂��B'));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath2', ''));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath3', ''));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath4', ''));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath5', ''));
      RemoveBlankLines(mOath);

      edDate.Text := FormatDateTime('yyyy"�N"m"��"d"��"', Now);

      case ini.ReadInteger('SummaryInfo', 'Organizer', 0) of
         0: radioOrganizerJarl.Checked := True;
         1: radioOrganizerOther.Checked := True;
         else radioOrganizerJarl.Checked := True;
      end;

      checkFieldExtend.Checked := ini.ReadBool('LogSheet', 'FieldExtend', False);

      if Log.ScoreCoeff > 0 then begin
         edFDCoefficient.Text := FloatToStr(Log.ScoreCoeff);
      end
      else begin
         edFDCoefficient.Text := '';
      end;
      editFdcoeff.Text := edFDCoefficient.Text;

      for b := Low(FScoreQso) to High(FScoreQso) do begin
         FScoreQso[b].Text := IntToStr(MyContest.ScoreForm.QSO[b]);
         FScoreMulti1[b].Text := IntToStr(MyContest.ScoreForm.Multi[b]);
         FScoreMulti2[b].Text := IntToStr(MyContest.ScoreForm.Multi2[b]);
         FScorePoints[b].Text := IntToStr(MyContest.ScoreForm.Points[b]);
         SetBandUsed(b);
      end;

      CalcAll();
   finally
      ini.Free();
      Log.Saved := fSavedBack;
   end;
end;

procedure TformELogJarlEx.buttonCreateLogClick(Sender: TObject);
begin
   if TabControl1.TabIndex = 0 then begin
      CreateELogR1();
   end;
   if TabControl1.TabIndex = 1 then begin
      CreateELogR2();
   end;
end;

procedure TformELogJarlEx.CreateELogR2();
var
   f: TextFile;
   fname: string;
begin
   // ���̓`�F�b�N
   if IsNewcomer(edCategoryCode.Text) = True then begin
      if datetimeLicenseDate.Date = EncodeDate(2000, 1, 1) then begin
         MessageDlg('�Q�����傪 ' + dmZLogGlobal.Settings.FELogNewcomerCategory + ' �̏ꍇ�́A�ǖƋ��N��������͂��ĉ�����', mtWarning, [mbOK], 0);
         datetimeLicenseDate.SetFocus();
         Exit;
      end;
   end;

   if IsSeniorJunior(edCategoryCode.Text) = True then begin
      if comboAge.Text = '' then begin
         MessageDlg('�Q�����傪 ' + dmZLogGlobal.Settings.FELogSeniorJuniorCategory + ' �̏ꍇ�́A�N�����͂��ĉ�����', mtWarning, [mbOK], 0);
         comboAge.SetFocus();
         Exit;
      end;
   end;

   if CurrentFileName <> '' then begin
      SaveDialog1.InitialDir := ExtractFilePath(CurrentFileName);
      SaveDialog1.FileName := ChangeFileExt(ExtractFileName(CurrentFileName), '.em');
   end;

   if SaveDialog1.Execute() = False then begin
      Exit;
   end;

   fname := SaveDialog1.FileName;

   // ���Ƀt�@�C��������ꍇ�͏㏑���m�F
   if FileExists(fname) = True then begin
      if MessageDlg('[' + fname + '] file already exists. overwrite?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
         Exit;
      end;
   end;

   AssignFile(f, fname);
   Rewrite(f);

   // �T�}���[�V�[�g
   WriteSummarySheetR2(f);

   // ���O�V�[�g
   WriteLogSheetR2(f, checkFieldExtend.Checked);

   CloseFile(f);
end;

procedure TformELogJarlEx.CreateELogR1();
var
   f: TextFile;
   fname: string;
begin
   if CurrentFileName <> '' then begin
      SaveDialog1.InitialDir := ExtractFilePath(CurrentFileName);
      SaveDialog1.FileName := ChangeFileExt(ExtractFileName(CurrentFileName), '.em');
   end;

   if SaveDialog1.Execute() = False then begin
      Exit;
   end;

   fname := SaveDialog1.FileName;

   // ���Ƀt�@�C��������ꍇ�͏㏑���m�F
   if FileExists(fname) = True then begin
      if MessageDlg('[' + fname + '] file already exists. overwrite?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
         Exit;
      end;
   end;

   AssignFile(f, fname);
   Rewrite(f);

   // �T�}���[�V�[�g
   WriteSummarySheetR1(f);

   // ���O�V�[�g
   WriteLogSheetR1(f);

   CloseFile(f);
end;

procedure TformELogJarlEx.buttonSaveClick(Sender: TObject);
var
   ini: TMemIniFile;
begin
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      ini.WriteInteger('SummaryInfo', 'Version', TabControl1.TabIndex);

      ini.WriteString('SummaryInfo', 'CategoryCode', edCategoryCode.Text);
      ini.WriteString('SummaryInfo', 'CategoryName', edCategoryName.Text);
      ini.WriteString('SummaryInfo', 'OperatorCallsign', edOpCallsign.Text);

      ini.WriteString('SummaryInfo', 'Address1', mAddress.Lines[0]);
      ini.WriteString('SummaryInfo', 'Address2', mAddress.Lines[1]);
      ini.WriteString('SummaryInfo', 'Address3', mAddress.Lines[2]);
      ini.WriteString('SummaryInfo', 'Address4', mAddress.Lines[3]);
      ini.WriteString('SummaryInfo', 'Address5', mAddress.Lines[4]);

      ini.WriteString('SummaryInfo', 'Telephone', edTEL.Text);
      ini.WriteString('SummaryInfo', 'OperatorName', edOPName.Text);
      ini.WriteString('SummaryInfo', 'EMail', edEMail.Text);
      ini.WriteString('SummaryInfo', 'License', edLicense.Text);

      ini.WriteString('SummaryInfo', 'Power', edPower.Text);
      ini.WriteInteger('SummaryInfo','PowerType',rPowerType.ItemIndex);
      ini.WriteString('SummaryInfo', 'QTH', edQTH.Text);
      ini.WriteString('SummaryInfo', 'PowerSupply', edPowerSupply.Text);

      ini.WriteString('SummaryInfo', 'License', edLicense.Text);

      ini.WriteString('SummaryInfo', 'Equipment1', memoEquipment.Lines[0]);
      ini.WriteString('SummaryInfo', 'Equipment2', memoEquipment.Lines[1]);
      ini.WriteString('SummaryInfo', 'Equipment3', memoEquipment.Lines[2]);
      ini.WriteString('SummaryInfo', 'Equipment4', memoEquipment.Lines[3]);
      ini.WriteString('SummaryInfo', 'Equipment5', memoEquipment.Lines[4]);

      ini.WriteDate('SummaryInfo', 'LicenseDate', datetimeLicenseDate.Date);
      ini.WriteString('SummaryInfo', 'Age', comboAge.Text);

      ini.WriteString('SummaryInfo', 'Comment1', mComments.Lines[0]);
      ini.WriteString('SummaryInfo', 'Comment2', mComments.Lines[1]);
      ini.WriteString('SummaryInfo', 'Comment3', mComments.Lines[2]);
      ini.WriteString('SummaryInfo', 'Comment4', mComments.Lines[3]);
      ini.WriteString('SummaryInfo', 'Comment5', mComments.Lines[4]);
      ini.WriteString('SummaryInfo', 'Comment6', mComments.Lines[5]);
      ini.WriteString('SummaryInfo', 'Comment7', mComments.Lines[6]);
      ini.WriteString('SummaryInfo', 'Comment8', mComments.Lines[7]);
      ini.WriteString('SummaryInfo', 'Comment9', mComments.Lines[8]);
      ini.WriteString('SummaryInfo', 'Comment10', mComments.Lines[9]);

      ini.WriteString('SummaryInfo', 'ClubID', edClubID.Text);
      ini.WriteString('SummaryInfo', 'ClubName', edClubName.Text);

      ini.WriteString('SummaryInfo', 'Oath1', mOath.Lines[0]);
      ini.WriteString('SummaryInfo', 'Oath2', mOath.Lines[1]);
      ini.WriteString('SummaryInfo', 'Oath3', mOath.Lines[2]);
      ini.WriteString('SummaryInfo', 'Oath4', mOath.Lines[3]);
      ini.WriteString('SummaryInfo', 'Oath5', mOath.Lines[4]);

      if radioOrganizerJarl.Checked = True then begin
         ini.WriteInteger('SummaryInfo', 'Organizer', 0);
      end
      else begin
         ini.WriteInteger('SummaryInfo', 'Organizer', 1);
      end;

      ini.WriteBool('LogSheet', 'FieldExtend', checkFieldExtend.Checked);

      ini.UpdateFile();
   finally
      ini.Free();
   end;
end;

procedure TformELogJarlEx.edCategoryCodeExit(Sender: TObject);
var
   S: string;
   b: TBand;
   i: TBand;
begin
   S := edCategoryCode.Text;

   if Pos('19', S) > 0 then begin
      b := b19;
   end
   else if Pos('35', S) > 0 then begin
      b := b35;
   end
   else if Pos('7', S) > 0 then begin
      b := b7;
   end
   else if Pos('14', S) > 0 then begin
      b := b14;
   end
   else if Pos('21', S) > 0 then begin
      b := b21;
   end
   else if Pos('28', S) > 0 then begin
      b := b28;
   end
   else if Pos('50', S) > 0 then begin
      b := b50;
   end
   else if Pos('144', S) > 0 then begin
      b := b144;
   end
   else if Pos('430', S) > 0 then begin
      b := b430;
   end
   else if Pos('1200', S) > 0 then begin
      b := b1200;
   end
   else if Pos('2400', S) > 0 then begin
      b := b2400;
   end
   else if Pos('5600', S) > 0 then begin
      b := b5600;
   end
   else if Pos('10G', S) > 0 then begin
      b := b10g;
   end
   else begin
      b := bUnknown;
   end;

   if b = bUnknown then begin
      for i := Low(FScoreBand) to High(FScoreBand) do begin
         SetBandUsed(i);
      end;
   end
   else begin
      for i := Low(FScoreBand) to High(FScoreBand) do begin
         if Assigned(FScoreBand[i]) then begin
            FScoreBand[i].Checked := False;
         end;
      end;
      SetBandUsed(b);
   end;
end;

procedure TformELogJarlEx.edFDCoefficientChange(Sender: TObject);
var
   E: Extended;
begin
   editFdcoeff.Text := edFDCoefficient.Text;
   E := StrToFloatDef(edFDCoefficient.Text, 1);
   Log.ScoreCoeff := E;
   CalcAll();
end;

procedure TformELogJarlEx.buttonCancelClick(Sender: TObject);
begin
   Close;
end;

procedure TformELogJarlEx.WriteSummarySheetR1(var f: TextFile);
var
   fFdCoeff: Extended;
   b: TBand;
   S: string;
   multi1, multi2: Integer;
begin
   WriteLn(f, '<SUMMARYSHEET VERSION=R1.0>');
   WriteLn(f, '<CONTESTNAME>' + edContestName.Text + '</CONTESTNAME>');
   WriteLn(f, '<CATEGORYCODE>' + edCategoryCode.Text + '</CATEGORYCODE>');
   WriteLn(f, '<CATEGORYNAME>' + edCategoryName.Text + '</CATEGORYNAME>');
   WriteLn(f, '<CALLSIGN>' + edCallsign.Text + '</CALLSIGN>');
   WriteLn(f, '<OPCALLSIGN>' + edOpCallsign.Text + '</OPCALLSIGN>');

   for b := b19 to HiBand do begin
      if Assigned(FScoreBand[b]) and
         (FScoreBand[b].Checked = True) then begin
         multi1 := StrToIntDef(FScoreMulti1[b].Text, 0);
         multi2 := StrToIntDef(FScoreMulti2[b].Text, 0);
         S := FScoreQso[b].Text + ',' + FScorePoints[b].Text + ',' + IntToStr(multi1 + multi2);
         if b = b10G then begin
            WriteLn(f, '<SCORE BAND=10.1GHz>' + S + '</SCORE>')
         end
         else begin
            WriteLn(f, '<SCORE BAND=' + MHzString[B] + 'MHz>' + S + '</SCORE>');
         end;
      end;
   end;

   multi1 := StrToIntDef(editMulti1Total.Text, 0);
   multi2 := StrToIntDef(editMulti2Total.Text, 0);
   S := editQsoTotal.Text + ',' + editPointsTotal.Text + ',' + IntToStr(multi1 + multi2);
   WriteLn(f, '<SCORE BAND=TOTAL>' + S + '</SCORE>');

   fFdCoeff := StrToFloatDef(editFdcoeff.Text, 1);
   if (fFdCoeff > 1) or (MyContest.UseCoeff = True) then begin
      WriteLn(f, '<FDCOEFF>' + FloatToStr(fFdCoeff) + '</FDCOEFF>');
   end;

   WriteLn(f, '<TOTALSCORE>' + editTotalScore.Text + '</TOTALSCORE>');

   Write(f, '<ADDRESS>');
   Write(f, mAddress.Text);
   WriteLn(f, '</ADDRESS>');

   WriteLn(f, '<TEL>' + edTEL.Text + '</TEL>');
   WriteLn(f, '<NAME>' + edOPName.Text + '</NAME>');
   WriteLn(f, '<EMAIL>' + edEMAIL.Text + '</EMAIL>');
   WriteLn(f, '<LICENSECLASS>' + edLicense.Text + '</LICENSECLASS>');
   WriteLn(f, '<POWER>' + edPOWER.Text + '</POWER>');

   if rPowerType.ItemIndex = 0 then begin
      WriteLn(f,'<POWERTYPE>��i�o��</POWERTYPE>');
   end
   else begin
      WriteLn(f,'<POWERTYPE>�����o��</POWERTYPE>');
   end;

   WriteLn(f, '<OPPLACE>' + edQTH.Text + '</OPPLACE>');
   WriteLn(f, '<POWERSUPPLY>' + edPowerSupply.Text + '</POWERSUPPLY>');

   WriteLn(f, '<EQUIPMENT>');
   WriteLn(f, memoEquipment.Text);
   WriteLn(f, '</EQUIPMENT>');

   Write(f, '<COMMENTS>');
   Write(f, mComments.Text);
   WriteLn(f, '</COMMENTS>');

   WriteLn(f, '<REGCLUBNUMBER>' + edClubID.Text + '</REGCLUBNUMBER>');
   WriteLn(f, '<REGCLUBNAME>' + edClubName.Text + '</REGCLUBNAME>');

   Write(f, '<OATH>');
   Write(f, mOath.Text);
   WriteLn(f, '</OATH>');

   WriteLn(f, '<DATE>' + edDate.Text + '</DATE>');
   WriteLn(f, '<SIGNATURE>' + edSignature.Text + '</SIGNATURE>');

   WriteLn(f, '</SUMMARYSHEET>');
end;

procedure TformELogJarlEx.WriteLogSheetR1(var f: TextFile);
var
   i: Integer;
   s: string;
   Q: TQSO;
begin
   WriteLn(f, '<LOGSHEET TYPE=ZLOG.ALL>');

   WriteLn(f, 'Date       Time  Callsign    RSTs ExSent RSTr ExRcvd  Mult  Mult2 MHz  Mode Pt Memo');
   for i := 1 to Log.TotalQSO do begin
      Q := Log.QsoList[i];
      if Assigned(FScoreBand[Q.Band]) = False then begin
         Continue;
      end;

      if (dmZLogGlobal.Settings._output_outofperiod = False) and
         (Log.IsOutOfPeriod(Q) = True) then begin
         Continue;
      end;

      s := FormatQSO_v1(Q, FScoreBand[Q.Band].Checked);

      WriteLn(f, s);
   end;

   WriteLn(f, '</LOGSHEET>');
end;

{
<SUMMARYSHEET VERSION=R2.0>
<CONTESTNAME>�R���e�X�g�̖���</CONTESTNAME>
<CATEGORYCODE>�Q�������ڃR�[�h�i���o�[</CATEGORYCODE>
<CALLSIGN>�R�[���T�C��</CALLSIGN>
<OPCALLSIGN>�Q�X�g�I�y�^�p�҂̃R�[���T�C��</OPCALLSIGN>
<TOTALSCORE>�����_</TOTALSCORE>
<ADDRESS>�A����Z��</ADDRESS>
<NAME>����(�N���u�ǂ̖���)</NAME>
<TEL>�d�b�ԍ�</TEL>
<EMAIL>E-mail�A�h���X</EMAIL>
<POWER>�R���e�X�g���g�p�����ő�󒆐��d��(W)</POWER>
<FDCOEFF>�t�B�[���h�f�[�R���e�X�g�̏ꍇ�̋ǎ�W��</FDCOEFF>
<OPPLACE>�^�p�n</OPPLACE>
<POWERSUPPLY>�g�p�d��</POWERSUPPLY>
<COMMENTS>�ӌ�</COMMENTS>
<MULTIOPLIST>�}���`�I�y��ډ^�p�҂̃R�[���T�C���܂��͎���</MULTIOPLIST>
<REGCLUBNUMBER>�o�^�N���u�ԍ�</REGCLUBNUMBER>
<OATH>�鐾��</OATH>
<DATE>���t</DATE>
<SIGNATURE>����</SIGNATURE>
</SUMMARYSHEET>
}
procedure TformELogJarlEx.WriteSummarySheetR2(var f: TextFile);
var
   fFdCoeff: Extended;
   fScore: Extended;
   nTotalMulti1: Integer;
   nTotalMulti2: Integer;
   nTotalPoints: Integer;
begin
   fFdCoeff := StrToFloatDef(edFDCoefficient.Text, 1);
   nTotalMulti1 := StrToIntDef(editMulti1Total.Text, 0);
   nTotalMulti2 := StrToIntDef(editMulti2Total.Text, 0);
   nTotalPoints := StrToIntDef(editPointsTotal.Text, 0);

   WriteLn(f, '<SUMMARYSHEET VERSION=R2.1>');

   WriteLn(f, '<CONTESTNAME>' + edContestName.Text + '</CONTESTNAME>');
   WriteLn(f, '<CATEGORYCODE>' + edCategoryCode.Text + '</CATEGORYCODE>');
   WriteLn(f, '<CALLSIGN>' + edCallsign.Text + '</CALLSIGN>');
   WriteLn(f, '<OPCALLSIGN>' + edOpCallsign.Text + '</OPCALLSIGN>');

   fScore := zyloRequestTotal(nTotalPoints, (nTotalMulti1 + nTotalMulti2));
   if fScore = -1 then begin
      fScore := (nTotalMulti1 + nTotalMulti2) * nTotalPoints * fFdCoeff;
   end;
   WriteLn(f, '<TOTALSCORE>' + FloatToStr(fScore) + '</TOTALSCORE>');

   Write(f, '<ADDRESS>');
   Write(f, mAddress.Text);
   WriteLn(f, '</ADDRESS>');

   WriteLn(f, '<NAME>' + edOPName.Text + '</NAME>');
   WriteLn(f, '<TEL>' + edTEL.Text + '</TEL>');
   WriteLn(f, '<EMAIL>' + edEMail.Text + '</EMAIL>');
   WriteLn(f, '<POWER>' + edPower.Text + '</POWER>');

   if (fFdCoeff > 1) or (MyContest.UseCoeff = True) then begin
      WriteLn(f, '<FDCOEFF>' + FloatToStr(fFdCoeff) + '</FDCOEFF>');
   end;

   WriteLn(f, '<OPPLACE>' + edQTH.Text + '</OPPLACE>');
   WriteLn(f, '<POWERSUPPLY>' + edPowerSupply.Text + '</POWERSUPPLY>');

   if IsNewcomer(edCategoryCode.Text) = True then begin
      WriteLn(f, '<LICENSEDATE>' + FormatDateTime('yyyy�Nmm��dd��', datetimeLicenseDate.Date) + '</LICENSEDATE>');
   end;

   if IsSeniorJunior(edCategoryCode.Text) = True then begin
      WriteLn(f, '<AGE>' + comboAge.Text + '</AGE>');
   end;

   Write(f, '<COMMENTS>');
   Write(f, mComments.Text);
   WriteLn(f, '</COMMENTS>');

   if memoMultiOpList.Text <> '' then begin
      Write(f, '<MULTIOPLIST>');
      Write(f, memoMultiOpList.Lines.CommaText);
      WriteLn(f, '</MULTIOPLIST>');
   end;

   WriteLn(f, '<REGCLUBNUMBER>' + edClubID.Text + '</REGCLUBNUMBER>');

   Write(f, '<OATH>');
   Write(f, mOath.Text);
   WriteLn(f, '</OATH>');

   WriteLn(f, '<DATE>' + edDate.Text + '</DATE>');
   WriteLn(f, '<SIGNATURE>' + edSignature.Text + '</SIGNATURE>');

   WriteLn(f, '</SUMMARYSHEET>');
end;

{
�E�P��M�P�s�A�p�������p���g���܂��B�S�p(2�o�C�g)�����͐�΂Ɏg�p���Ȃ��B
�E�A������P�ȏ�̋󔒂���у^�u���e���ڊԂɋ�؂蕶���i�f���~�^�j�Ƃ��܂��B

DATE(JST)	TIME	BAND	MODE	CALLSIGN	SENTNo	RCVNo	Multi	PTS
2016-04-23	21:53	50	SSB	JA2Y**	59	20L	59	20L	20	1
2016-04-23	22:02	144	SSB	JA2***	59	20L	59	20L	-	1
2016-04-23	22:15	7	CW	JE3***	599	20M	599	25M	25	1
}
procedure TformELogJarlEx.WriteLogSheetR2(var f: TextFile; fExtend: Boolean);
var
   i: Integer;
   s: string;
   Q: TQSO;
begin
   WriteLn(f, '<LOGSHEET TYPE=ZLOG>');

   if Log.QsoList[0].RSTsent = _USEUTC then begin
      Write(f, 'DATE(UTC)');
   end
   else begin
      Write(f, 'DATE(JST)');
   end;
   Write(f, TAB + 'TIME' + TAB + 'BAND' + TAB + 'MODE' + TAB + 'CALLSIGN' + TAB + 'SENTNo' + TAB + 'RCVNo');

   if fExtend = True then begin
      Write(f, TAB + 'Multi1' + TAB + 'Multi2' + TAB + 'Points' + TAB + 'TX#');
   end;
   WriteLn(f, '');

   for i := 1 to Log.TotalQSO do begin
      Q := Log.QsoList[i];

      if (dmZLogGlobal.Settings._output_outofperiod = False) and
         (Log.IsOutOfPeriod(Q) = True) then begin
         Continue;
      end;

      s := FormatQSO_v2(Q, fExtend);
      WriteLn(f, s);
   end;

   WriteLn(f, '</LOGSHEET>');
end;

function TformELogJarlEx.FormatQSO_v1(q: TQSO; fValid: Boolean): string;
var
   S: string;
begin
   S := '';
   S := S + FormatDateTime('yyyy/mm/dd hh":"nn ', q.Time);
   S := S + FillRight(q.CallSign, 13);
   S := S + FillRight(IntToStr(q.RSTSent), 4);
   S := S + FillRight(q.NrSent, 8);
   S := S + FillRight(IntToStr(q.RSTRcvd), 4);
   S := S + FillRight(q.NrRcvd, 8);

   if q.NewMulti1 then begin
      S := S + FillRight(q.Multi1, 6);
   end
   else begin
      S := S + '-     ';
   end;

   if q.NewMulti2 then begin
      S := S + FillRight(q.Multi2, 6);
   end
   else begin
      S := S + '-     ';
   end;

   S := S + FillRight(MHzString[q.Band], 5);
   S := S + FillRight(ModeString[q.Mode], 5);
   if fValid = True then begin
      S := S + FillRight(IntToStr(q.Points), 3);
   end
   else begin
      S := S + FillRight(IntToStr(0), 3);
   end;

   if q.Operator <> '' then begin
      S := S + FillRight('%%' + q.Operator + '%%', 19);
   end;

   if dmZlogGlobal.ContestCategory in [ccMultiOpMultiTx, ccMultiOpSingleTx, ccMultiOpTwoTx] then begin
      S := S + FillRight('TX#' + IntToStr(q.TX), 6);
   end;

//   S := S + q.Memo;

   Result := S;
end;

function TformELogJarlEx.FormatQSO_v2(q: TQSO; fExtend: Boolean): string;
var
   slLine: TStringList;
begin
   slLine := TStringList.Create();
   slLine.StrictDelimiter := True;
   slLine.Delimiter := TAB;
   try
      slLine.Add(FormatDateTime('yyyy-mm-dd', q.Time));
      slLine.Add(FormatDateTime('hh:nn', q.Time));

      slLine.Add(MHzString[q.Band]);
      slLine.Add(ModeString[q.Mode]);
      slLine.Add(q.Callsign);

      slLine.Add(IntToStr(q.RSTsent) + ' ' + q.NrSent);
      slLine.Add(IntToStr(q.RSTrcvd) + ' ' + q.NrRcvd);

      if fExtend = True then begin
         if q.NewMulti1 = True then begin
            slLine.Add(q.Multi1);
         end
         else begin
            slLine.Add('');
         end;

         if q.NewMulti2 = True then begin
            slLine.Add(q.Multi2);
         end
         else begin
            slLine.Add('');
         end;

         slLine.Add(IntToStr(q.Points));
         slLine.Add('TX#' + IntToStr(q.TX));
      end;

      Result := slLine.DelimitedText;
   finally
      slLine.Free();
   end;
end;

procedure TformELogJarlEx.checkBandClick(Sender: TObject);
var
   n: Integer;
   fChecked: Boolean;
begin
   n := TCheckBox(Sender).Tag;
   fChecked := TCheckBox(Sender).Checked;

   if fChecked = True then begin
      FScoreQso[TBand(n)].Color := clWindow;
      FScoreMulti1[TBand(n)].Color := clWindow;
      FScoreMulti2[TBand(n)].Color := clWindow;
      FScorePoints[TBand(n)].Color := clWindow;
   end
   else begin
      FScoreQso[TBand(n)].Color := clBtnFace;
      FScoreMulti1[TBand(n)].Color := clBtnFace;
      FScoreMulti2[TBand(n)].Color := clBtnFace;
      FScorePoints[TBand(n)].Color := clBtnFace;
   end;

   CalcAll();
end;

function TformELogJarlEx.IsNewcomer(cate: string): Boolean;
var
   list: TStringList;
   i: Integer;
begin
   list := TStringList.Create();
   list.StrictDelimiter := True;
   list.CommaText := dmZLogGlobal.Settings.FELogNewComerCategory;
   try
      for i := 0 to list.Count - 1 do begin
         if cate = list[i] then begin
            Result := True;
            Exit;
         end;
      end;
      Result := False;
   finally
      list.Free();
   end;
end;

function TformELogJarlEx.IsSeniorJunior(cate: string): Boolean;
var
   list: TStringList;
   i: Integer;
begin
   list := TStringList.Create();
   list.StrictDelimiter := True;
   list.CommaText := dmZLogGlobal.Settings.FELogSeniorJuniorCategory;
   try
      for i := 0 to list.Count - 1 do begin
         if cate = list[i] then begin
            Result := True;
            Exit;
         end;
      end;
      Result := False;
   finally
      list.Free();
   end;
end;

procedure TformELogJarlEx.CalcAll();
var
   b: TBand;
   qso, multi1, multi2, points: Integer;
   fdcoeff: Extended;
   fScore: Extended;
begin
   qso := 0;
   multi1 := 0;
   multi2 := 0;
   points := 0;

   for b := b19 to HiBand do begin
      if FScoreBand[b] = nil then begin
         Continue;
      end;

      if FScoreBand[b].Checked = False then begin
         Continue;
      end;

      qso := qso + StrToIntDef(FScoreQso[b].Text, 0);
      multi1 := multi1 + StrToIntDef(FScoreMulti1[b].Text, 0);
      multi2 := multi2 + StrToIntDef(FScoreMulti2[b].Text, 0);
      points := points + StrToIntDef(FScorePoints[b].Text, 0);
   end;

   editQsoTotal.Text := IntToStr(qso);
   editMulti1Total.Text := IntToStr(multi1);
   editMulti2Total.Text := IntToStr(multi2);
   editPointsTotal.Text := IntToStr(points);

   fdcoeff := StrToFloatDef(editFdcoeff.Text, 1);
   fScore := (multi1 + multi2) * points * fdcoeff;

   editTotalScore.Text := FloatToStr(fScore);
end;

procedure TformELogJarlEx.radioOrganizerJarlClick(Sender: TObject);
begin
   mOath.Text := '���́AJARL����̃R���e�X�g�K�񂨂�ѓd�g�@�߂ɂ��������^�p�������ʁA�����ɒ�o����T�}���[�V�[�g����у��O�V�[�g�Ȃǂ������Ƒ���Ȃ����̂ł��邱�Ƃ��A���̖��_�ɂ����Đ����܂��B';
end;

procedure TformELogJarlEx.radioOrganizerOtherClick(Sender: TObject);
begin
   mOath.Text := '���́A��ÎҐ���̃R���e�X�g�K�񂨂�ѓd�g�@�߂ɂ��������^�p�������ʁA�����ɒ�o����T�}���[�V�[�g����у��O�V�[�g�Ȃǂ������Ƒ���Ȃ����̂ł��邱�Ƃ��A���̖��_�ɂ����Đ����܂��B';
end;

procedure TformELogJarlEx.SetBandUsed(b: TBand);
begin
   if (MyContest.ScoreForm.Points[b] = 0) or
      (MainForm.BandMenu.Items[Ord(b)].Visible = False) then begin
      if Assigned(FScoreBand[b]) then begin
         FScoreBand[b].Checked := False;
      end;
   end
   else begin
      if Assigned(FScoreBand[b]) then begin
         FScoreBand[b].Checked := True;
      end;
   end;
end;

procedure TformELogJarlEx.TabControl1Change(Sender: TObject);
begin
   case TabControl1.TabIndex of
      // R1.0
      0: begin
         labelCategoryName.Visible := True;
         edCategoryName.Visible := True;
         labelEquipment.Visible := True;
         memoEquipment.Visible := True;
         rPowerType.Visible := True;
         labelMultiOpList.Visible := False;
         memoMultiOpList.Visible := False;
         labelLicenseDate.Visible := False;
         datetimeLicenseDate.Visible := False;
         labelAge.Visible := False;
         comboAge.Visible := False;
         labelClubName.Visible := True;
         edClubName.Visible := True;
         labelLicense.Visible := True;
         edLicense.Visible := True;
         checkFieldExtend.Visible := False;
      end;

      // R2.1
      1: begin
         labelCategoryName.Visible := False;
         edCategoryName.Visible := False;
         labelEquipment.Visible := False;
         memoEquipment.Visible := False;
         rPowerType.Visible := False;
         labelMultiOpList.Visible := True;
         memoMultiOpList.Visible := True;
         labelLicenseDate.Visible := True;
         datetimeLicenseDate.Visible := True;
         labelAge.Visible := True;
         comboAge.Visible := True;
         labelClubName.Visible := False;
         edClubName.Visible := False;
         labelLicense.Visible := False;
         edLicense.Visible := False;
         checkFieldExtend.Visible := True;
      end;
   end;
end;

end.
