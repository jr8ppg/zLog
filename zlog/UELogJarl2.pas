unit UELogJarl2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IniFiles, UITypes,
  UzLogConst, UzLogGlobal, UzLogQSO;

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
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    mOath: TMemo;
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
    buttonCreateLog: TButton;
    buttonSave: TButton;
    buttonCancel: TButton;
    mAddress: TMemo;
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

const
  TAB = #09;

implementation

uses
  Main;

{$R *.dfm}

procedure TformELogJarl2.FormCreate(Sender: TObject);
begin
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
   ini: TIniFile;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      edContestName.Text   := MyContest.Name;
      edCategoryCode.Text  := ini.ReadString('SummaryInfo', 'CategoryCode', '');
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
      edPower.Text         := ini.ReadString('SummaryInfo', 'Power', '');
      edQTH.Text           := ini.ReadString('SummaryInfo', 'QTH', '');
      edPowerSupply.Text   := ini.ReadString('SummaryInfo', 'PowerSupply', '');

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
   finally
      ini.Free();
   end;
end;

procedure TformELogJarl2.buttonCreateLogClick(Sender: TObject);
var
   f: TextFile;
   fname: string;
begin
   if CurrentFileName <> '' then begin
      SaveDialog1.FileName := ChangeFileExt(CurrentFileName, '.em');
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

procedure TformELogJarl2.buttonSaveClick(Sender: TObject);
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      ini.WriteString('SummaryInfo', 'CategoryCode', edCategoryCode.Text);
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

      ini.WriteString('SummaryInfo', 'Power', edPower.Text);
      ini.WriteString('SummaryInfo', 'QTH', edQTH.Text);
      ini.WriteString('SummaryInfo', 'PowerSupply', edPowerSupply.Text);

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
   finally
      ini.Free();
   end;
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
   nFdCoeff: Integer;
   fFieldDay: Boolean;
begin
   if Pos('フィールドデー', MyContest.Name) > 0 then begin
      fFieldDay := True;
   end
   else begin
      fFieldDay := False;
   end;
   nFdCoeff := StrToIntDef(edFDCoefficient.Text, 1);

   WriteLn(f, '<SUMMARYSHEET VERSION=R2.0>');

   WriteLn(f, '<CONTESTNAME>' + edContestName.Text + '</CONTESTNAME>');
   WriteLn(f, '<CATEGORYCODE>' + edCategoryCode.Text + '</CATEGORYCODE>');
   WriteLn(f, '<CALLSIGN>' + edCallsign.Text + '</CALLSIGN>');
   WriteLn(f, '<OPCALLSIGN>' + edOpCallsign.Text + '</OPCALLSIGN>');
   WriteLn(f, '<TOTALSCORE>' + IntToStr(MyContest.ScoreForm._TotalMulti * MyContest.ScoreForm._TotalPoints * nFdCoeff) + '</TOTALSCORE>');

   Write(f, '<ADDRESS>');
   Write(f, mAddress.Text);
   WriteLn(f, '</ADDRESS>');

   WriteLn(f, '<NAME>' + edOPName.Text + '</NAME>');
   WriteLn(f, '<TEL>' + edTEL.Text + '</TEL>');
   WriteLn(f, '<EMAIL>' + edEMail.Text + '</EMAIL>');
   WriteLn(f, '<POWER>' + edPower.Text + '</POWER>');
   if (fFieldDay = True) then begin
      WriteLn(f, '<FDCOEFF>' + IntToStr(nFdCoeff) + '</FDCOEFF>');
   end;
   WriteLn(f, '<OPPLACE>' + edQTH.Text + '</OPPLACE>');
   WriteLn(f, '<POWERSUPPLY>' + edPowerSupply.Text + '</POWERSUPPLY>');

   Write(f, '<COMMENTS>');
   Write(f, mComments.Text);
   WriteLn(f, '</COMMENTS>');

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
procedure TformELogJarl2.WriteLogSheet(var f: TextFile);
var
   i: Integer;
   s: string;
begin
   WriteLn(f, '<LOGSHEET TYPE=ZLOG>');

   WriteLn(f, 'DATE(JST)' + TAB + 'TIME' + TAB + 'BAND' + TAB + 'MODE' + TAB + 'CALLSIGN' + TAB + 'SENTNo' + TAB + 'RCVNo');
   for i := 1 to Log.TotalQSO do begin
      s := FormatQSO(Log.QsoList[i]);
      WriteLn(f, s);
   end;

   WriteLn(f, '</LOGSHEET>');
end;

function TformELogJarl2.FormatQSO(q: TQSO): string;
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

      Result := slLine.DelimitedText;
   finally
      slLine.Free();
   end;
end;

end.
