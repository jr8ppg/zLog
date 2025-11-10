unit UELogJarlEx;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IniFiles, UITypes, Math, DateUtils,
  Vcl.ComCtrls,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogExtension, UJarlWebUpload,
  UzLogContest;

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
    buttonWebUpload: TButton;
    ScrollBox1: TScrollBox;
    checkFieldExtend: TCheckBox;
    Label3: TLabel;
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
    procedure buttonWebUploadClick(Sender: TObject);
    procedure ControlEnter(Sender: TObject);
    procedure ControlExit(Sender: TObject);
  private
    { Private 宣言 }
    FScoreBand: array[b19..HiBand] of TCheckBox;
    FScoreQso: array[b19..HiBand] of TEdit;
    FScoreMulti1: array[b19..HiBand] of TEdit;
    FScoreMulti2: array[b19..HiBand] of TEdit;
    FScorePoints: array[b19..HiBand] of TEdit;

    function CreateELogR1(SL: TStringList): Boolean;
    function CreateELogR2(SL: TStringList): Boolean;
    procedure RemoveBlankLines(M : TMemo);
    procedure InitializeFields;
    procedure RequiredInputCheck(ctrl: TObject);
    procedure WriteSummarySheetR1(SL: TStringList);
    procedure WriteLogSheetR1(SL: TStringList);
    procedure WriteSummarySheetR2(SL: TStringList);
    procedure WriteLogSheetR2(SL: TStringList; fExtend: Boolean);
    function FormatQSO_v1(q: TQSO; fValid: Boolean): string;
    function FormatQSO_v2(q: TQSO; fExtend: Boolean): string;
    function IsNewcomer(cate: string): Boolean;
    function IsSeniorJunior(cate: string): Boolean;
    procedure CalcAll();
    procedure SetBandUsed(b: TBand);
  public
    { Public 宣言 }
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
var
   scale: double;
   i: Integer;
   ctrl: TComponent;
begin
   if (MyContest is TALLJAContest) or
      (MyContest is TSixDownContest) or
      (MyContest is TFDContest) or
      (MyContest is TACAGContest) or
      (MyContest is TAllAsianContest) then begin
      buttonWebUpload.Visible := True;
      TabControl1.TabIndex := 1; // R2.1
   end
   else begin
      buttonWebUpload.Visible := False;
      TabControl1.TabIndex := 0; // R1.0
   end;

   TabControl1Change(TabControl1);

   scale := GetDisplayScalingFactor(Left, Top);
   if scale >= 1.75 then begin
      Height := 550;
   end
   else if scale >= 1.5 then begin
      Height := 650;
   end;

   for i := 0 to ComponentCount - 1 do begin
      ctrl := Components[i];
      if ctrl is TLabel then begin
         if (TEdit(ctrl).Tag = 1) then begin
            if (MyContest is TFDContest) then begin
               TLabel(ctrl).Font.Color := clBlue;
            end
            else begin
               TLabel(ctrl).Font.Color := clWindowText;
            end;
         end;
      end;

      if ctrl is TEdit then begin
         if Assigned(TEdit(ctrl).OnEnter) then begin
            TEdit(ctrl).OnEnter(ctrl);
         end;
      end;
      if ctrl is TMemo then begin
         if Assigned(TMemo(ctrl).OnEnter) then begin
            TMemo(ctrl).OnEnter(ctrl);
         end;
      end;
   end;
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
      mAddress.Lines.Add(ini.ReadString('SummaryInfo', 'Address1', '〒'));
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
         '私は、JARL制定' + 'のコンテスト規約および電波法令にしたがい運用した結果、ここ' +
         'に提出するサマリーシートおよびログシートなどが事実と相違な' +
         'いものであることを、私の名誉において誓います。'));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath2', ''));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath3', ''));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath4', ''));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath5', ''));
      RemoveBlankLines(mOath);

      edDate.Text := FormatDateTime('yyyy"年"m"月"d"日"', Now);

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
var
   SL: TStringList;
   fname: string;
begin
   SL := TStringList.Create();
   try
      if TabControl1.TabIndex = 0 then begin
         if CreateELogR1(SL) = False then begin
            Exit;
         end;
      end;
      if TabControl1.TabIndex = 1 then begin
         if CreateELogR2(SL) = False then begin
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

      // 既にファイルがある場合は上書き確認
      if FileExists(fname) = True then begin
         if MessageDlg('[' + fname + '] file already exists. overwrite?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
            Exit;
         end;
      end;

      SL.SaveToFile(fname);

   finally
      SL.Free();
   end;
end;

function TformELogJarlEx.CreateELogR2(SL: TStringList): Boolean;
begin
   // 入力チェック
   if IsNewcomer(edCategoryCode.Text) = True then begin
      if datetimeLicenseDate.Date = EncodeDate(2000, 1, 1) then begin
         MessageDlg('参加部門が ' + dmZLogGlobal.Settings.FELogNewcomerCategory + ' の場合は、局免許年月日を入力して下さい', mtWarning, [mbOK], 0);
         datetimeLicenseDate.SetFocus();
         Result := False;
         Exit;
      end;
   end;

   if IsSeniorJunior(edCategoryCode.Text) = True then begin
      if comboAge.Text = '' then begin
         MessageDlg('参加部門が ' + dmZLogGlobal.Settings.FELogSeniorJuniorCategory + ' の場合は、年齢を入力して下さい', mtWarning, [mbOK], 0);
         comboAge.SetFocus();
         Result := False;
         Exit;
      end;
   end;

   // サマリーシート
   WriteSummarySheetR2(SL);

   // ログシート
   WriteLogSheetR2(SL, checkFieldExtend.Checked);

   Result := True;
end;

function TformELogJarlEx.CreateELogR1(SL: TStringList): Boolean;
begin
   // サマリーシート
   WriteSummarySheetR1(SL);

   // ログシート
   WriteLogSheetR1(SL);

   Result := True;
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

procedure TformELogJarlEx.buttonWebUploadClick(Sender: TObject);
var
   f: TformJarlWebUpload;
   SL: TStringList;
begin
   f := TformJarlWebUpload.Create(Self);
   SL := TStringList.Create();
   try
      if TabControl1.TabIndex = 0 then begin
         if CreateELogR1(SL) = False then begin
            Exit;
         end;
      end;
      if TabControl1.TabIndex = 1 then begin
         if CreateELogR2(SL) = False then begin
            Exit;
         end;
      end;

      f.LogText := SL.Text;

      if MyContest is TALLJAContest then begin
         f.Contest := wuAllJa;
      end;

      if MyContest is TSixDownContest then begin
         f.Contest := wu6d;
      end;

      if MyContest is TFDContest then begin
         f.Contest := wuFd;
      end;

      if MyContest is TACAGContest then begin
         f.Contest := wuAcag;
      end;

      if MyContest is TAllAsianContest then begin
         if Log.QSOList[1].Mode = mCW then begin
            f.Contest := wuAacw;
         end
         else begin
            f.Contest := wuAaph;
         end;
      end;

      f.ShowModal();
   finally
      f.Release();
      SL.Free();
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

procedure TformELogJarlEx.ControlEnter(Sender: TObject);
begin
   RequiredInputCheck(Sender);
end;

procedure TformELogJarlEx.ControlExit(Sender: TObject);
begin
   RequiredInputCheck(Sender);
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

procedure TformELogJarlEx.RequiredInputCheck(ctrl: TObject);
var
   fFieldDay: Boolean;
begin
   fFieldDay := (MyContest is TFDContest);

   if ctrl is TEdit then begin
      if TEdit(ctrl).Tag = 1 then begin
         if fFieldDay = False then begin
            Exit;
         end;
      end;

      if TEdit(ctrl).Text = '' then begin
         TEdit(ctrl).Color := $00EADEFF;   // light pink
      end
      else begin
         TEdit(ctrl).Color := clWindow;
      end;
   end;

   if ctrl is TMemo then begin
      if TMemo(ctrl).Text = '' then begin
         TMemo(ctrl).Color := $00EADEFF;   // light pink
      end
      else begin
         TMemo(ctrl).Color := clWindow;
      end;
   end;
end;

procedure TformELogJarlEx.WriteSummarySheetR1(SL: TStringList);
var
   fFdCoeff: Extended;
   b: TBand;
   S: string;
   multi1, multi2: Integer;
begin
   SL.Add('<SUMMARYSHEET VERSION=R1.0>');
   SL.Add('<CONTESTNAME>' + edContestName.Text + '</CONTESTNAME>');
   SL.Add('<CATEGORYCODE>' + edCategoryCode.Text + '</CATEGORYCODE>');
   SL.Add('<CATEGORYNAME>' + edCategoryName.Text + '</CATEGORYNAME>');
   SL.Add('<CALLSIGN>' + edCallsign.Text + '</CALLSIGN>');
   SL.Add('<OPCALLSIGN>' + edOpCallsign.Text + '</OPCALLSIGN>');

   for b := b19 to HiBand do begin
      if Assigned(FScoreBand[b]) and
         (FScoreBand[b].Checked = True) then begin
         multi1 := StrToIntDef(FScoreMulti1[b].Text, 0);
         multi2 := StrToIntDef(FScoreMulti2[b].Text, 0);
         S := FScoreQso[b].Text + ',' + FScorePoints[b].Text + ',' + IntToStr(multi1 + multi2);
         if b = b10G then begin
            SL.Add('<SCORE BAND=10.1GHz>' + S + '</SCORE>')
         end
         else begin
            SL.Add('<SCORE BAND=' + MHzString[B] + 'MHz>' + S + '</SCORE>');
         end;
      end;
   end;

   multi1 := StrToIntDef(editMulti1Total.Text, 0);
   multi2 := StrToIntDef(editMulti2Total.Text, 0);
   S := editQsoTotal.Text + ',' + editPointsTotal.Text + ',' + IntToStr(multi1 + multi2);
   SL.Add('<SCORE BAND=TOTAL>' + S + '</SCORE>');

   fFdCoeff := StrToFloatDef(editFdcoeff.Text, 1);
   if (fFdCoeff > 1) or (MyContest.UseCoeff = True) then begin
      SL.Add('<FDCOEFF>' + FloatToStr(fFdCoeff) + '</FDCOEFF>');
   end;

   SL.Add('<TOTALSCORE>' + editTotalScore.Text + '</TOTALSCORE>');

   SL.Add('<ADDRESS>' + mAddress.Text + '</ADDRESS>');

   SL.Add('<TEL>' + edTEL.Text + '</TEL>');
   SL.Add('<NAME>' + edOPName.Text + '</NAME>');
   SL.Add('<EMAIL>' + edEMAIL.Text + '</EMAIL>');
   SL.Add('<LICENSECLASS>' + edLicense.Text + '</LICENSECLASS>');
   SL.Add('<POWER>' + edPOWER.Text + '</POWER>');

   if rPowerType.ItemIndex = 0 then begin
      SL.Add('<POWERTYPE>定格出力</POWERTYPE>');
   end
   else begin
      SL.Add('<POWERTYPE>実測出力</POWERTYPE>');
   end;

   SL.Add('<OPPLACE>' + edQTH.Text + '</OPPLACE>');
   SL.Add('<POWERSUPPLY>' + edPowerSupply.Text + '</POWERSUPPLY>');

   SL.Add('<EQUIPMENT>');
   SL.Add(memoEquipment.Text);
   SL.Add('</EQUIPMENT>');

   SL.Add('<COMMENTS>' + mComments.Text + '</COMMENTS>');

   SL.Add('<REGCLUBNUMBER>' + edClubID.Text + '</REGCLUBNUMBER>');
   SL.Add('<REGCLUBNAME>' + edClubName.Text + '</REGCLUBNAME>');

   SL.Add('<OATH>' + mOath.Text + '</OATH>');

   SL.Add('<DATE>' + edDate.Text + '</DATE>');
   SL.Add('<SIGNATURE>' + edSignature.Text + '</SIGNATURE>');

   SL.Add('</SUMMARYSHEET>');
end;

procedure TformELogJarlEx.WriteLogSheetR1(SL: TStringList);
var
   i: Integer;
   s: string;
   Q: TQSO;
begin
   SL.Add('<LOGSHEET TYPE="ZLOG.ALL">');

   SL.Add('Date       Time  Callsign    RSTs ExSent RSTr ExRcvd  Mult  Mult2 MHz  Mode Pt Memo');
   for i := 1 to Log.TotalQSO do begin
      Q := Log.QsoList[i];
      if Assigned(FScoreBand[Q.Band]) = False then begin
         Continue;
      end;

      if (dmZLogGlobal.Settings._output_outofperiod = False) and
         (Log.IsOutOfPeriod(Q) = True) then begin
         Continue;
      end;

//      if Q.Invalid = True then begin
//         Continue;
//      end;

      s := FormatQSO_v1(Q, FScoreBand[Q.Band].Checked);

      SL.Add(s);
   end;

   SL.Add('</LOGSHEET>');
end;

{
<SUMMARYSHEET VERSION=R2.0>
<CONTESTNAME>コンテストの名称</CONTESTNAME>
<CATEGORYCODE>参加部門種目コードナンバー</CATEGORYCODE>
<CALLSIGN>コールサイン</CALLSIGN>
<OPCALLSIGN>ゲストオペ運用者のコールサイン</OPCALLSIGN>
<TOTALSCORE>総得点</TOTALSCORE>
<ADDRESS>連絡先住所</ADDRESS>
<NAME>氏名(クラブ局の名称)</NAME>
<TEL>電話番号</TEL>
<EMAIL>E-mailアドレス</EMAIL>
<POWER>コンテスト中使用した最大空中線電力(W)</POWER>
<FDCOEFF>フィールドデーコンテストの場合の局種係数</FDCOEFF>
<OPPLACE>運用地</OPPLACE>
<POWERSUPPLY>使用電源</POWERSUPPLY>
<COMMENTS>意見</COMMENTS>
<MULTIOPLIST>マルチオペ種目運用者のコールサインまたは氏名</MULTIOPLIST>
<REGCLUBNUMBER>登録クラブ番号</REGCLUBNUMBER>
<OATH>宣誓文</OATH>
<DATE>日付</DATE>
<SIGNATURE>署名</SIGNATURE>
</SUMMARYSHEET>
}
procedure TformELogJarlEx.WriteSummarySheetR2(SL: TStringList);
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

   SL.Add('<SUMMARYSHEET VERSION=R2.1>');

   SL.Add('<CONTESTNAME>' + edContestName.Text + '</CONTESTNAME>');
   SL.Add('<CATEGORYCODE>' + edCategoryCode.Text + '</CATEGORYCODE>');
   SL.Add('<CALLSIGN>' + edCallsign.Text + '</CALLSIGN>');
   SL.Add('<OPCALLSIGN>' + edOpCallsign.Text + '</OPCALLSIGN>');

   fScore := zyloRequestTotal(nTotalPoints, (nTotalMulti1 + nTotalMulti2));
   if fScore = -1 then begin
      fScore := (nTotalMulti1 + nTotalMulti2) * nTotalPoints * fFdCoeff;
   end;
   SL.Add('<TOTALSCORE>' + FloatToStr(fScore) + '</TOTALSCORE>');

   SL.Add('<ADDRESS>' + mAddress.Text + '</ADDRESS>');

   SL.Add('<NAME>' + edOPName.Text + '</NAME>');
   SL.Add('<TEL>' + edTEL.Text + '</TEL>');
   SL.Add('<EMAIL>' + edEMail.Text + '</EMAIL>');
   SL.Add('<POWER>' + edPower.Text + '</POWER>');

   if (fFdCoeff > 1) or (MyContest.UseCoeff = True) then begin
      SL.Add('<FDCOEFF>' + FloatToStr(fFdCoeff) + '</FDCOEFF>');
   end;

   SL.Add('<OPPLACE>' + edQTH.Text + '</OPPLACE>');
   SL.Add('<POWERSUPPLY>' + edPowerSupply.Text + '</POWERSUPPLY>');

   if IsNewcomer(edCategoryCode.Text) = True then begin
      SL.Add('<LICENSEDATE>' + FormatDateTime('yyyy年mm月dd日', datetimeLicenseDate.Date) + '</LICENSEDATE>');
   end;

   if IsSeniorJunior(edCategoryCode.Text) = True then begin
      SL.Add('<AGE>' + comboAge.Text + '</AGE>');
   end;

   SL.Add('<COMMENTS>' + mComments.Text + '</COMMENTS>');

   if memoMultiOpList.Text <> '' then begin
      SL.Add('<MULTIOPLIST>' + memoMultiOpList.Lines.CommaText + '</MULTIOPLIST>');
   end;

   SL.Add('<REGCLUBNUMBER>' + edClubID.Text + '</REGCLUBNUMBER>');

   SL.Add('<OATH>' + mOath.Text + '</OATH>');

   SL.Add('<DATE>' + edDate.Text + '</DATE>');
   SL.Add('<SIGNATURE>' + edSignature.Text + '</SIGNATURE>');

   SL.Add('</SUMMARYSHEET>');
end;

{
・１交信１行、英数字半角を使います。全角(2バイト)文字は絶対に使用しない。
・連続する１個以上の空白およびタブを各項目間に区切り文字（デリミタ）とします。

DATE(JST)	TIME	BAND	MODE	CALLSIGN	SENTNo	RCVDNo	Multi	PTS
2016-04-23	21:53	50	SSB	JA2Y**	59	20L	59	20L	20	1
2016-04-23	22:02	144	SSB	JA2***	59	20L	59	20L	-	1
2016-04-23	22:15	7	CW	JE3***	599	20M	599	25M	25	1
}
procedure TformELogJarlEx.WriteLogSheetR2(SL: TStringList; fExtend: Boolean);
var
   i: Integer;
   s: string;
   s2: string;
   Q: TQSO;
begin
   SL.Add('<LOGSHEET TYPE="ZLOG">');

   if Log.QsoList[0].RSTsent = _USEUTC then begin
      s := 'DATE(UTC)';
   end
   else begin
      s := 'DATE(JST)';
   end;

   if fExtend = True then begin
      s2 := TAB + 'TX#';
   end
   else begin
      s2 := '';
   end;

   SL.Add(s + TAB + 'TIME' + TAB + 'BAND' + TAB + 'MODE' + TAB + 'CALLSIGN' + TAB + 'SENTNo' + TAB + 'RCVDNo' + TAB + 'Multi' + TAB + 'Points' + s2);

   for i := 1 to Log.TotalQSO do begin
      Q := Log.QsoList[i];

      if (dmZLogGlobal.Settings._output_outofperiod = False) and
         (Log.IsOutOfPeriod(Q) = True) then begin
         Continue;
      end;

//      if Q.Invalid = True then begin
//         Continue;
//      end;

      s := FormatQSO_v2(Q, fExtend);
      SL.Add(s);
   end;

   SL.Add('</LOGSHEET>');
end;

function TformELogJarlEx.FormatQSO_v1(q: TQSO; fValid: Boolean): string;
var
   S: string;
begin
   S := '';
   if q.Invalid = True then begin
      S := S + 'X ' + FormatDateTime('yyyy/mm/dd hh":"nn ', q.Time);
   end
   else begin
      S := S + FormatDateTime('yyyy/mm/dd hh":"nn ', q.Time);
   end;
   S := S + FillRight2(q.CallSign, 13);
   S := S + FillRight2(IntToStr(q.RSTSent), 4);
   S := S + FillRight2(q.NrSent, 8);
   S := S + FillRight2(IntToStr(q.RSTRcvd), 4);
   S := S + FillRight2(q.NrRcvd, 8);

   if q.NewMulti1 then begin
      S := S + FillRight2(q.Multi1, 6);
   end
   else begin
      S := S + '-     ';
   end;

   if q.NewMulti2 then begin
      S := S + FillRight2(q.Multi2, 6);
   end
   else begin
      S := S + '-     ';
   end;

   S := S + FillRight2(MHzString[q.Band], 5);
   S := S + FillRight2(ModeString[q.Mode], 5);
   if fValid = True then begin
      S := S + FillRight2(IntToStr(q.Points), 3);
   end
   else begin
      S := S + FillRight2(IntToStr(0), 3);
   end;

   if q.Operator <> '' then begin
      S := S + FillRight2('%%' + q.Operator + '%%', 19);
   end;

   if dmZlogGlobal.ContestCategory in [ccMultiOpMultiTx, ccMultiOpSingleTx, ccMultiOpTwoTx] then begin
      S := S + FillRight2('TX#' + IntToStr(q.TX), 6);
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
      if q.Invalid = True then begin
         slLine.Add('X ' + FormatDateTime('yyyy-mm-dd', q.Time));
      end
      else begin
         slLine.Add(FormatDateTime('yyyy-mm-dd', q.Time));
      end;
      slLine.Add(FormatDateTime('hh:nn', q.Time));

      slLine.Add(MHzString[q.Band]);
      slLine.Add(ModeString[q.Mode]);
      slLine.Add(q.Callsign);

      slLine.Add(IntToStr(q.RSTsent) + ' ' + q.NrSent);
      slLine.Add(IntToStr(q.RSTrcvd) + ' ' + q.NrRcvd);

      if q.NewMulti1 = True then begin
         slLine.Add(q.Multi1);
      end
      else begin
         slLine.Add('-');
      end;

      slLine.Add(IntToStr(q.Points));

      if fExtend = True then begin
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
   mOath.Text := '私は、JARL制定のコンテスト規約および電波法令にしたがい運用した結果、ここに提出するサマリーシートおよびログシートなどが事実と相違ないものであることを、私の名誉において誓います。';
end;

procedure TformELogJarlEx.radioOrganizerOtherClick(Sender: TObject);
begin
   mOath.Text := '私は、主催者制定のコンテスト規約および電波法令にしたがい運用した結果、ここに提出するサマリーシートおよびログシートなどが事実と相違ないものであることを、私の名誉において誓います。';
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
         buttonWebUpload.Enabled := False;
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
         buttonWebUpload.Enabled := True;
      end;
   end;
end;

end.
