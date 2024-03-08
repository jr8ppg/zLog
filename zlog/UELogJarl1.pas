unit UELogJarl1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IniFiles, UITypes, Math,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TformELogJarl1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    mOath: TMemo;
    edContestName: TEdit;
    edCategoryName: TEdit;
    edCallsign: TEdit;
    edOpCallsign: TEdit;
    edCategoryCode: TEdit;
    edTEL: TEdit;
    edOPName: TEdit;
    edEMail: TEdit;
    edLicense: TEdit;
    edPower: TEdit;
    rPowerType: TRadioGroup;
    edQTH: TEdit;
    edClubID: TEdit;
    edPowerSupply: TEdit;
    mComments: TMemo;
    edClubName: TEdit;
    edDate: TEdit;
    edSignature: TEdit;
    mAddress: TMemo;
    mEquipment: TMemo;
    Label12: TLabel;
    SaveDialog1: TSaveDialog;
    GroupBox1: TGroupBox;
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
    Label22: TLabel;
    Label24: TLabel;
    editQsoTotal: TEdit;
    editMultiTotal: TEdit;
    editPointsTotal: TEdit;
    Label6: TLabel;
    Panel1: TPanel;
    buttonCreateLog: TButton;
    buttonSave: TButton;
    buttonCancel: TButton;
    radioOrganizerJarl: TRadioButton;
    radioOrganizerOther: TRadioButton;
    GroupBox2: TGroupBox;
    procedure buttonCreateLogClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonSaveClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure checkBandClick(Sender: TObject);
    procedure editFDCOEFFChange(Sender: TObject);
    procedure radioOrganizerJarlClick(Sender: TObject);
    procedure radioOrganizerOtherClick(Sender: TObject);
  private
    { Private 宣言 }
    FScoreBand: array[b19..HiBand] of TCheckBox;
    FScoreQso: array[b19..HiBand] of TEdit;
    FScoreMulti: array[b19..HiBand] of TEdit;
    FScorePoints: array[b19..HiBand] of TEdit;

    procedure RemoveBlankLines(M : TMemo);
    procedure InitializeFields;
    procedure WriteSummarySheet(var f: TextFile);
    procedure WriteLogSheet(var f: TextFile);
    function FormatQSO(q: TQSO; fValid: Boolean): string;
    procedure CalcAll();
  public
    { Public 宣言 }
  end;

implementation

uses
  Main;

{$R *.dfm}

procedure TformELogJarl1.FormCreate(Sender: TObject);
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

   InitializeFields;
end;

procedure TformELogJarl1.RemoveBlankLines(M : TMemo);
var
   i : integer;
begin
   i := M.Lines.Count-1;
   while i >= 0 do begin
      if M.Lines[i] = '' then
         M.Lines.Delete(i)
      else
         break;

      dec(i);
   end;
end;

procedure TformELogJarl1.InitializeFields;
var
   ini: TMemIniFile;
   b: TBand;
   fSavedBack: Boolean;
begin
   fSavedBack := Log.Saved;
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      edContestName.Text   := MyContest.Name;
      edCategoryCode.Text  := ini.ReadString('SummaryInfo', 'CategoryCode', '');
      edCategoryName.Text  := ini.ReadString('SummaryInfo', 'CategoryName', '');
      edCallsign.Text      := ini.ReadString('Categories', 'MyCall', 'Your call sign');
      edOpCallsign.Text    := ini.ReadString('SummaryInfo', 'OperatorCallsign', '');

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

      mEquipment.Clear;
      mEquipment.Lines.Add(ini.ReadString('SummaryInfo', 'Equipment1', ''));
      mEquipment.Lines.Add(ini.ReadString('SummaryInfo', 'Equipment2', ''));
      mEquipment.Lines.Add(ini.ReadString('SummaryInfo', 'Equipment3', ''));
      mEquipment.Lines.Add(ini.ReadString('SummaryInfo', 'Equipment4', ''));
      mEquipment.Lines.Add(ini.ReadString('SummaryInfo', 'Equipment5', ''));
      RemoveBlankLines(mEquipment);

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

      edClubID.Text        := ini.ReadString('SummaryInfo', 'ClubID', '');
      edClubName.Text      := ini.ReadString('SummaryInfo', 'ClubName', '');

      mOath.Clear;
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath1',
         '私は、JARL制定のコンテスト規約および電波法令にしたがい運用した結果、ここ'+
         'に提出するサマリーシートおよびログシートなどが事実と相違な'+
         'いものであることを、私の名誉において誓います。'));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath2', ''));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath3', ''));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath4', ''));
      mOath.Lines.Add(ini.ReadString('SummaryInfo', 'Oath5', ''));
      RemoveBlankLines(mOath);

      edDate.Text := FormatDateTime('yyyy"年"m"月"d"日"',Now);

      case ini.ReadInteger('SummaryInfo', 'Organizer', 0) of
         0: radioOrganizerJarl.Checked := True;
         1: radioOrganizerOther.Checked := True;
         else radioOrganizerJarl.Checked := True;
      end;

      if Log.ScoreCoeff > 0 then begin
         editFdcoeff.Text := FloatToStr(Log.ScoreCoeff);
      end
      else begin
         editFdcoeff.Text := '';
      end;

      for b := Low(FScoreQso) to High(FScoreQso) do begin
         FScoreQso[b].Text := IntToStr(MyContest.ScoreForm.QSO[b]);
         FScoreMulti[b].Text := IntToStr(MyContest.ScoreForm.Multi[b]);
         FScorePoints[b].Text := IntToStr(MyContest.ScoreForm.Points[b]);

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

      CalcAll();
   finally
      ini.Free();
      Log.Saved := fSavedBack;
   end;
end;

procedure TformELogJarl1.buttonCreateLogClick(Sender: TObject);
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
   WriteLogSheet(f);

   CloseFile(f);
end;

procedure TformELogJarl1.buttonSaveClick(Sender: TObject);
var
   ini: TMemIniFile;
begin
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
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

      ini.WriteString('SummaryInfo', 'Equipment1', mEquipment.Lines[0]);
      ini.WriteString('SummaryInfo', 'Equipment2', mEquipment.Lines[1]);
      ini.WriteString('SummaryInfo', 'Equipment3', mEquipment.Lines[2]);
      ini.WriteString('SummaryInfo', 'Equipment4', mEquipment.Lines[3]);
      ini.WriteString('SummaryInfo', 'Equipment5', mEquipment.Lines[4]);

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

      ini.UpdateFile();
   finally
      ini.Free();
   end;
end;

procedure TformELogJarl1.buttonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TformELogJarl1.WriteSummarySheet(var f: TextFile);
var
   fFdCoeff: Extended;
   b: TBand;
   S: string;
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
         S := FScoreQso[b].Text + ',' + FScorePoints[b].Text + ',' + FScoreMulti[b].Text;
         if b = b10G then begin
            WriteLn(f, '<SCORE BAND=10.1GHz>' + S + '</SCORE>')
         end
         else begin
            WriteLn(f, '<SCORE BAND=' + MHzString[B] + 'MHz>' + S + '</SCORE>');
         end;
      end;
   end;

   S := editQsoTotal.Text + ',' + editPointsTotal.Text + ',' + editMultiTotal.Text;
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
      WriteLn(f,'<POWERTYPE>定格出力</POWERTYPE>');
   end
   else begin
      WriteLn(f,'<POWERTYPE>実測出力</POWERTYPE>');
   end;

   WriteLn(f, '<OPPLACE>' + edQTH.Text + '</OPPLACE>');
   WriteLn(f, '<POWERSUPPLY>' + edPowerSupply.Text + '</POWERSUPPLY>');

   WriteLn(f, '<EQUIPMENT>');
   WriteLn(f, mEquipment.Text);
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

procedure TformELogJarl1.WriteLogSheet(var f: TextFile);
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

      s := FormatQSO(Q, FScoreBand[Q.Band].Checked);

      WriteLn(f, s);
   end;

   WriteLn(f, '</LOGSHEET>');
end;

function TformELogJarl1.FormatQSO(q: TQSO; fValid: Boolean): string;
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

procedure TformELogJarl1.checkBandClick(Sender: TObject);
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

procedure TformELogJarl1.editFDCOEFFChange(Sender: TObject);
var
   E: Extended;
begin
   CalcAll();
   E := StrToFloatDef(editFDCOEFF.Text, 1);
   Log.ScoreCoeff := E;
end;

procedure TformELogJarl1.CalcAll();
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

procedure TformELogJarl1.radioOrganizerJarlClick(Sender: TObject);
begin
   mOath.Text := '私は、JARL制定のコンテスト規約および電波法令にしたがい運用した結果、ここに提出するサマリーシートおよびログシートなどが事実と相違ないものであることを、私の名誉において誓います。';
end;

procedure TformELogJarl1.radioOrganizerOtherClick(Sender: TObject);
begin
   mOath.Text := '私は、主催者制定のコンテスト規約および電波法令にしたがい運用した結果、ここに提出するサマリーシートおよびログシートなどが事実と相違ないものであることを、私の名誉において誓います。';
end;

end.
