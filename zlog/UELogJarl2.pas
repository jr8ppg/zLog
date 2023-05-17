unit UELogJarl2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IniFiles, UITypes, Math, DateUtils,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogExtension, Vcl.ComCtrls;

type
  TformELogJarl2 = class(TForm)
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
    Label3: TLabel;
    memoMultiOpList: TMemo;
    Panel1: TPanel;
    buttonCreateLog: TButton;
    buttonSave: TButton;
    buttonCancel: TButton;
    Label11: TLabel;
    datetimeLicenseDate: TDateTimePicker;
    Label12: TLabel;
    comboAge: TComboBox;
    checkFieldExtend: TCheckBox;
    GroupBox1: TGroupBox;
    mOath: TMemo;
    radioOrganizerJarl: TRadioButton;
    radioOrganizerOther: TRadioButton;
    procedure buttonCreateLogClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonSaveClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure edFDCoefficientChange(Sender: TObject);
    procedure radioOrganizerJarlClick(Sender: TObject);
    procedure radioOrganizerOtherClick(Sender: TObject);
  private
    { Private �錾 }
    procedure RemoveBlankLines(M : TMemo);
    procedure InitializeFields;
    procedure WriteSummarySheet(var f: TextFile);
    procedure WriteLogSheet(var f: TextFile; fExtend: Boolean);
    function FormatQSO(q: TQSO; fExtend: Boolean): string;
    function IsNewcomer(cate: string): Boolean;
    function IsSeniorJunior(cate: string): Boolean;
  public
    { Public �錾 }
  end;

const
  TAB = #09;

implementation

uses
  Main;

{$R *.dfm}

procedure TformELogJarl2.FormCreate(Sender: TObject);
begin
   edFDCoefficient.Enabled := MyContest.UseCoeff;
   InitializeFields;
end;

procedure TformELogJarl2.RemoveBlankLines(M: TMemo);
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

procedure TformELogJarl2.InitializeFields;
var
   ini: TMemIniFile;
   i: Integer;
   str: string;
   fSavedBack: Boolean;
begin
   fSavedBack := Log.Saved;
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      edContestName.Text   := MyContest.Name;
      edCategoryCode.Text  := ini.ReadString('SummaryInfo', 'CategoryCode', '');
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
      edPower.Text         := ini.ReadString('SummaryInfo', 'Power', '');
      edQTH.Text           := ini.ReadString('SummaryInfo', 'QTH', '');
      edPowerSupply.Text   := ini.ReadString('SummaryInfo', 'PowerSupply', '');

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

      checkFieldExtend.Checked := ini.ReadBool('LogSheet', 'FieldExtend', False);
   finally
      ini.Free();
      Log.Saved := fSavedBack;
   end;
end;

procedure TformELogJarl2.buttonCreateLogClick(Sender: TObject);
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
   WriteSummarySheet(f);

   // ���O�V�[�g
   WriteLogSheet(f, checkFieldExtend.Checked);

   CloseFile(f);
end;

procedure TformELogJarl2.buttonSaveClick(Sender: TObject);
var
   ini: TMemIniFile;
begin
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      ini.WriteString('SummaryInfo', 'CategoryCode', edCategoryCode.Text);
      ini.WriteString('SummaryInfo', 'OperatorCallsign', edOpCallsign.Text);

      ini.WriteString('SummaryInfo', 'Address1', mAddress.Lines[0]);
      ini.WriteString('SummaryInfo', 'Address2', mAddress.Lines[1]);
      ini.WriteString('SummaryInfo', 'Address3', mAddress.Lines[2]);
      ini.WriteString('SummaryInfo', 'Address4', mAddress.Lines[3]);
      ini.WriteString('SummaryInfo', 'Address5', mAddress.Lines[4]);

      ini.WriteString('SummaryInfo', 'Telephone', edTEL.Text);
      ini.WriteString('SummaryInfo', 'OperatorName', edOPName.Text);
      ini.WriteString('SummaryInfo', 'EMail', edEMail.Text);

      ini.WriteString('SummaryInfo', 'Power', edPower.Text);
      ini.WriteString('SummaryInfo', 'QTH', edQTH.Text);
      ini.WriteString('SummaryInfo', 'PowerSupply', edPowerSupply.Text);

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

      ini.WriteString('SummaryInfo', 'Oath1', mOath.Lines[0]);
      ini.WriteString('SummaryInfo', 'Oath2', mOath.Lines[1]);
      ini.WriteString('SummaryInfo', 'Oath3', mOath.Lines[2]);
      ini.WriteString('SummaryInfo', 'Oath4', mOath.Lines[3]);
      ini.WriteString('SummaryInfo', 'Oath5', mOath.Lines[4]);

      ini.WriteBool('LogSheet', 'FieldExtend', checkFieldExtend.Checked);

      ini.UpdateFile();
   finally
      ini.Free();
   end;
end;

procedure TformELogJarl2.edFDCoefficientChange(Sender: TObject);
var
   E: Extended;
begin
   E := StrToFloatDef(edFDCoefficient.Text, 1);
   Log.ScoreCoeff := E;
end;

procedure TformELogJarl2.buttonCancelClick(Sender: TObject);
begin
   Close;
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
procedure TformELogJarl2.WriteSummarySheet(var f: TextFile);
var
   fFdCoeff: Extended;
   fScore: Extended;
begin
   fFdCoeff := StrToFloatDef(edFDCoefficient.Text, 1);

   WriteLn(f, '<SUMMARYSHEET VERSION=R2.1>');

   WriteLn(f, '<CONTESTNAME>' + edContestName.Text + '</CONTESTNAME>');
   WriteLn(f, '<CATEGORYCODE>' + edCategoryCode.Text + '</CATEGORYCODE>');
   WriteLn(f, '<CALLSIGN>' + edCallsign.Text + '</CALLSIGN>');
   WriteLn(f, '<OPCALLSIGN>' + edOpCallsign.Text + '</OPCALLSIGN>');

   fScore := zyloRequestTotal(MyContest.ScoreForm._TotalPoints, MyContest.ScoreForm._TotalMulti);
   if fScore = -1 then begin
      fScore := MyContest.ScoreForm._TotalMulti * MyContest.ScoreForm._TotalPoints * fFdCoeff;
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
procedure TformELogJarl2.WriteLogSheet(var f: TextFile; fExtend: Boolean);
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

      s := FormatQSO(Q, fExtend);
      WriteLn(f, s);
   end;

   WriteLn(f, '</LOGSHEET>');
end;

function TformELogJarl2.FormatQSO(q: TQSO; fExtend: Boolean): string;
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

function TformELogJarl2.IsNewcomer(cate: string): Boolean;
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

function TformELogJarl2.IsSeniorJunior(cate: string): Boolean;
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

procedure TformELogJarl2.radioOrganizerJarlClick(Sender: TObject);
begin
   mOath.Text := '���́AJARL����̃R���e�X�g�K�񂨂�ѓd�g�@�߂ɂ��������^�p�������ʁA�����ɒ�o����T�}���[�V�[�g����у��O�V�[�g�Ȃǂ������Ƒ���Ȃ����̂ł��邱�Ƃ��A���̖��_�ɂ����Đ����܂��B';
end;

procedure TformELogJarl2.radioOrganizerOtherClick(Sender: TObject);
begin
   mOath.Text := '���́A��ÎҐ���̃R���e�X�g�K�񂨂�ѓd�g�@�߂ɂ��������^�p�������ʁA�����ɒ�o����T�}���[�V�[�g����у��O�V�[�g�Ȃǂ������Ƒ���Ȃ����̂ł��邱�Ƃ��A���̖��_�ɂ����Đ����܂��B';
end;

end.
