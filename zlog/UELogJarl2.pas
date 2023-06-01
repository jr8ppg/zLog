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
    editMultiTotal: TEdit;
    editPointsTotal: TEdit;
    Label20: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    procedure buttonCreateLogClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonSaveClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure edFDCoefficientChange(Sender: TObject);
    procedure radioOrganizerJarlClick(Sender: TObject);
    procedure radioOrganizerOtherClick(Sender: TObject);
    procedure checkBandClick(Sender: TObject);
    procedure edCategoryCodeExit(Sender: TObject);
  private
    { Private 宣言 }
    FScoreBand: array[b19..HiBand] of TCheckBox;
    FScoreQso: array[b19..HiBand] of TEdit;
    FScoreMulti: array[b19..HiBand] of TEdit;
    FScorePoints: array[b19..HiBand] of TEdit;

    procedure RemoveBlankLines(M : TMemo);
    procedure InitializeFields;
    procedure WriteSummarySheet(var f: TextFile);
    procedure WriteLogSheet(var f: TextFile; fExtend: Boolean);
    function FormatQSO(q: TQSO; fExtend: Boolean): string;
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

procedure TformELogJarl2.FormCreate(Sender: TObject);
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
   FScoreMulti[b19]  := editMulti00;
   FScoreMulti[b35]  := editMulti01;
   FScoreMulti[b7]   := editMulti02;
   FScoreMulti[b10]  := nil;
   FScoreMulti[b14]  := editMulti04;
   FScoreMulti[b18]  := nil;
   FScoreMulti[b21]  := editMulti06;
   FScoreMulti[b24]  := nil;
   FScoreMulti[b28]  := editMulti08;
   FScoreMulti[b50]  := editMulti09;
   FScoreMulti[b144] := editMulti10;
   FScoreMulti[b430] := editMulti11;
   FScoreMulti[b1200] := editMulti12;
   FScoreMulti[b2400] := editMulti13;
   FScoreMulti[b5600] := editMulti14;
   FScoreMulti[b10g] := editMulti15;
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
   b: TBand;
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
      mAddress.Lines.Add(ini.ReadString('SummaryInfo', 'Address1', '〒'));
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
         '私は、JARL制定' + 'のコンテスト規約および電波法令にしたがい運用した結果、ここ' +
         'に提出するサマリーシートおよびログシートなどが事実と相違な' +
         'いものであることを、私の名誉において誓います。'));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath2', ''));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath3', ''));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath4', ''));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath5', ''));
      RemoveBlankLines(mOath);

      edDate.Text := FormatDateTime('yyyy"年"m"月"d"日"', Now);

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
         FScoreMulti[b].Text := IntToStr(MyContest.ScoreForm.Multi[b]);
         FScorePoints[b].Text := IntToStr(MyContest.ScoreForm.Points[b]);
         SetBandUsed(b);
      end;

      CalcAll();
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
   // 入力チェック
   if IsNewcomer(edCategoryCode.Text) = True then begin
      if datetimeLicenseDate.Date = EncodeDate(2000, 1, 1) then begin
         MessageDlg('参加部門が ' + dmZLogGlobal.Settings.FELogNewcomerCategory + ' の場合は、局免許年月日を入力して下さい', mtWarning, [mbOK], 0);
         datetimeLicenseDate.SetFocus();
         Exit;
      end;
   end;

   if IsSeniorJunior(edCategoryCode.Text) = True then begin
      if comboAge.Text = '' then begin
         MessageDlg('参加部門が ' + dmZLogGlobal.Settings.FELogSeniorJuniorCategory + ' の場合は、年齢を入力して下さい', mtWarning, [mbOK], 0);
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

   // 既にファイルがある場合は上書き確認
   if FileExists(fname) = True then begin
      if MessageDlg('[' + fname + '] file already exists. overwrite?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
         Exit;
      end;
   end;

   AssignFile(f, fname);
   Rewrite(f);

   // サマリーシート
   WriteSummarySheet(f);

   // ログシート
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

procedure TformELogJarl2.edCategoryCodeExit(Sender: TObject);
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

procedure TformELogJarl2.edFDCoefficientChange(Sender: TObject);
var
   E: Extended;
begin
   editFdcoeff.Text := edFDCoefficient.Text;
   E := StrToFloatDef(edFDCoefficient.Text, 1);
   Log.ScoreCoeff := E;
   CalcAll();
end;

procedure TformELogJarl2.buttonCancelClick(Sender: TObject);
begin
   Close;
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
procedure TformELogJarl2.WriteSummarySheet(var f: TextFile);
var
   fFdCoeff: Extended;
   fScore: Extended;
   nTotalMulti: Integer;
   nTotalPoints: Integer;
begin
   fFdCoeff := StrToFloatDef(edFDCoefficient.Text, 1);
   nTotalMulti := StrToIntDef(editMultiTotal.Text, 0);
   nTotalPoints := StrToIntDef(editPointsTotal.Text, 0);

   WriteLn(f, '<SUMMARYSHEET VERSION=R2.1>');

   WriteLn(f, '<CONTESTNAME>' + edContestName.Text + '</CONTESTNAME>');
   WriteLn(f, '<CATEGORYCODE>' + edCategoryCode.Text + '</CATEGORYCODE>');
   WriteLn(f, '<CALLSIGN>' + edCallsign.Text + '</CALLSIGN>');
   WriteLn(f, '<OPCALLSIGN>' + edOpCallsign.Text + '</OPCALLSIGN>');

   fScore := zyloRequestTotal(nTotalPoints, nTotalMulti);
   if fScore = -1 then begin
      fScore := nTotalMulti * nTotalPoints * fFdCoeff;
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
      WriteLn(f, '<LICENSEDATE>' + FormatDateTime('yyyy年mm月dd日', datetimeLicenseDate.Date) + '</LICENSEDATE>');
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
・１交信１行、英数字半角を使います。全角(2バイト)文字は絶対に使用しない。
・連続する１個以上の空白およびタブを各項目間に区切り文字（デリミタ）とします。

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

procedure TformELogJarl2.checkBandClick(Sender: TObject);
var
   n: Integer;
   fChecked: Boolean;
begin
   n := TCheckBox(Sender).Tag;
   fChecked := TCheckBox(Sender).Checked;

   if fChecked = True then begin
      FScoreQso[TBand(n)].Color := clWindow;
      FScoreMulti[TBand(n)].Color := clWindow;
      FScorePoints[TBand(n)].Color := clWindow;
   end
   else begin
      FScoreQso[TBand(n)].Color := clBtnFace;
      FScoreMulti[TBand(n)].Color := clBtnFace;
      FScorePoints[TBand(n)].Color := clBtnFace;
   end;

   CalcAll();
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

procedure TformELogJarl2.CalcAll();
var
   b: TBand;
   qso, multi, points: Integer;
   fdcoeff: Extended;
   fScore: Extended;
begin
   qso := 0;
   multi := 0;
   points := 0;

   for b := b19 to HiBand do begin
      if FScoreBand[b] = nil then begin
         Continue;
      end;

      if FScoreBand[b].Checked = False then begin
         Continue;
      end;

      qso := qso + StrToIntDef(FScoreQso[b].Text, 0);
      multi := multi + StrToIntDef(FScoreMulti[b].Text, 0);
      points := points + StrToIntDef(FScorePoints[b].Text, 0);
   end;

   editQsoTotal.Text := IntToStr(qso);
   editMultiTotal.Text := IntToStr(multi);
   editPointsTotal.Text := IntToStr(points);

   fdcoeff := StrToFloatDef(editFdcoeff.Text, 1);
   fScore := multi * points * fdcoeff;

   editTotalScore.Text := FloatToStr(fScore);
end;

procedure TformELogJarl2.radioOrganizerJarlClick(Sender: TObject);
begin
   mOath.Text := '私は、JARL制定のコンテスト規約および電波法令にしたがい運用した結果、ここに提出するサマリーシートおよびログシートなどが事実と相違ないものであることを、私の名誉において誓います。';
end;

procedure TformELogJarl2.radioOrganizerOtherClick(Sender: TObject);
begin
   mOath.Text := '私は、主催者制定のコンテスト規約および電波法令にしたがい運用した結果、ここに提出するサマリーシートおよびログシートなどが事実と相違ないものであることを、私の名誉において誓います。';
end;

procedure TformELogJarl2.SetBandUsed(b: TBand);
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

end.
