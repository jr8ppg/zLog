unit UELogJarl1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IniFiles, UITypes,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TformELogJarl1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
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
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    mOath: TMemo;
    edContestName: TEdit;
    edCategoryName: TEdit;
    edCallsign: TEdit;
    edOpCallsign: TEdit;
    edCategoryCode: TEdit;
    edFDCoefficient: TEdit;
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
    buttonCreateLog: TButton;
    buttonSave: TButton;
    buttonCancel: TButton;
    mAddress: TMemo;
    mEquipment: TMemo;
    Label12: TLabel;
    SaveDialog1: TSaveDialog;
    procedure buttonCreateLogClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonSaveClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
  private
    { Private 宣言 }
    procedure RemoveBlankLines(M : TMemo);
    procedure InitializeFields;
    procedure WriteSummarySheet(var f: TextFile);
    procedure WriteLogSheet(var f: TextFile);
    function FormatQSO(q: TQSO): string;
  public
    { Public 宣言 }
  end;

implementation

uses
  Main;

{$R *.dfm}

procedure TformELogJarl1.FormCreate(Sender: TObject);
begin
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
   ini: TIniFile;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      edContestName.Text   := MyContest.Name;
      edCategoryCode.Text  := ini.ReadString('SummaryInfo', 'CategoryCode', '');
      edCategoryName.Text  := ini.ReadString('SummaryInfo', 'CategoryName', '');
      edCallsign.Text      := ini.ReadString('Categories', 'MyCall', 'Your call sign');
      edOpCallsign.Text    := ini.ReadString('SummaryInfo', 'OperatorCallsign', '');
      edFDCoefficient.Text := ini.ReadString('SummaryInfo', 'FDCoefficient', '1');

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
   finally
      ini.Free();
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
   ini: TIniFile;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      ini.WriteString('SummaryInfo', 'CategoryCode', edCategoryCode.Text);
      ini.WriteString('SummaryInfo', 'CategoryName', edCategoryName.Text);
      ini.WriteString('SummaryInfo', 'OperatorCallsign', edOpCallsign.Text);
      ini.WriteString('SummaryInfo', 'FDCoefficient', edFDCoefficient.Text);

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
   nFdCoeff: Integer;
   b: TBand;
   fFieldDay: Boolean;
begin
   if Pos('フィールドデー', MyContest.Name) > 0 then begin
      fFieldDay := True;
   end
   else begin
      fFieldDay := False;
   end;
   nFdCoeff := StrToIntDef(edFDCoefficient.Text, 1);

   WriteLn(f, '<SUMMARYSHEET VERSION=R1.0>');
   WriteLn(f, '<CONTESTNAME>' + edContestName.Text + '</CONTESTNAME>');
   WriteLn(f, '<CATEGORYCODE>' + edCategoryCode.Text + '</CATEGORYCODE>');
   WriteLn(f, '<CATEGORYNAME>' + edCategoryName.Text + '</CATEGORYNAME>');
   WriteLn(f, '<CALLSIGN>' + edCallsign.Text + '</CALLSIGN>');
   WriteLn(f, '<OPCALLSIGN>' + edOpCallsign.Text + '</OPCALLSIGN>');

   for b := b19 to HiBand do begin
      if MyContest.ScoreForm.QSO[b] > 0 then begin
         if b = b10G then begin
            WriteLn(f, '<SCORE BAND=10.1GHz>' + MyContest.ScoreForm.QPMStr(b) + '</SCORE>')
         end
         else begin
            WriteLn(f, '<SCORE BAND=' + MHzString[B] + 'MHz>' + MyContest.ScoreForm.QPMStr(b) + '</SCORE>');
         end;
      end;
   end;

   WriteLn(f, '<SCORE BAND=TOTAL>' + MyContest.ScoreForm.TotalQPMStr + '</SCORE>');

   if (fFieldDay = True) then begin
      WriteLn(f, '<FDCOEFF>' + IntToStr(nFdCoeff) + '</FDCOEFF>');
   end;

   WriteLn(f, '<TOTALSCORE>' + IntToStr(MyContest.ScoreForm._TotalMulti * MyContest.ScoreForm._TotalPoints * nFdCoeff) + '</TOTALSCORE>');

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
begin
   WriteLn(f, '<LOGSHEET TYPE=ZLOG.ALL>');

   WriteLn(f, 'Date       Time  Callsign    RSTs ExSent RSTr ExRcvd  Mult  Mult2 MHz  Mode Pt Memo');
   for i := 1 to Log.TotalQSO do begin
      s := FormatQSO(Log.QsoList[i]);
      WriteLn(f, s);
   end;

   WriteLn(f, '</LOGSHEET>');
end;

function TformELogJarl1.FormatQSO(q: TQSO): string;
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
   S := S + FillRight(IntToStr(q.Points), 3);

   if q.Operator <> '' then begin
      S := S + FillRight('%%' + q.Operator + '%%', 19);
   end;

   if dmZlogGlobal.MultiOp > 0 then begin
      S := S + FillRight('TX#' + IntToStr(q.TX), 6);
   end;

//   S := S + q.Memo;

   Result := S;
end;

end.
