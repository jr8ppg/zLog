unit UQTCForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogCW, UZLinkForm, UzLogKeyer;

type
  TQTCForm = class(TForm)
    btnSend: TButton;
    btnBack: TButton;
    Label1: TLabel;
    SpinEdit: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    ListBox: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSendClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure SpinEditChange(Sender: TObject);
  private
    { Private declarations }
    FQTCToBeSent: Integer;
    FPastQTC: Integer;
    FQTCList: TList;
    FQTCReqStn: TQSO;
    FQTCSeries: Integer;
    procedure WaitForSent();
    function BuildQTCInitString(): string;
  public
    { Public declarations }
    procedure OpenQTC(Q: TQSO);
  end;

resourcestring
  QTC_DONE = 'Done';
  QTC_SEND = 'Send';
  QTC_SENT = ' Sent';

implementation

{$R *.DFM}

uses
  Main;

procedure TQTCForm.FormCreate(Sender: TObject);
begin
   Label1.Caption := '';
   Label2.Caption := '';
   FQTCList := TList.Create;
end;

procedure TQTCForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
   i, j, xpos: Integer;
   Q: TQSO;
   S: string;
begin
   btnSend.Caption := QTC_SEND;

   // ���镨���c���Ă���ꍇ
   if FQTCToBeSent - 1 < SpinEdit.Value then // didn't send all QTC. [QTC??/?? CALLSIGN date time band]
   begin
      for i := 0 to FQTCToBeSent - 2 do begin
         Q := TQSO(FQTCList[i]);
         S := Q.memo;
         j := pos('[QTC', S);
         if j > 0 then begin
            xpos := j + length(IntToStr(FQTCSeries)) + 5;
            if SpinEdit.Value = 10 then begin
               Delete(S, xpos, 1);
            end;

            S[xpos] := IntToStr(FQTCToBeSent - 1)[1];
            Q.memo := S;
         end;
      end;
   end;

   // ��ʂ��ĕ\��
   MainForm.GridRefreshScreen();

   SpinEdit.Enabled := True;
end;

procedure TQTCForm.FormDestroy(Sender: TObject);
begin
   FQTCList.Free;
end;

procedure TQTCForm.FormKeyPress(Sender: TObject; var Key: Char);
var
   nID: Integer;
begin
   case Key of
      Chr($08), 'B', 'b': begin
         btnBackClick(Self);
      end;

      'F', 'f': begin
         btnSendClick(Self);
      end;

      '\': begin
         nID := MainForm.CurrentRigID;
         dmZlogKeyer.ControlPTT(nID, not(dmZlogKeyer.PTTIsOn)); // toggle PTT;
      end;
   end;
end;

procedure TQTCForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   nID: Integer;
begin
   case Key of
      VK_NONCONVERT: { MUHENKAN KEY } begin
         nID := MainForm.CurrentRigID;
         dmZlogKeyer.ControlPTT(nID, not(dmZlogKeyer.PTTIsOn)); // toggle PTT;
      end;
   end;
end;

procedure TQTCForm.OpenQTC(Q: TQSO);
var
   i, j, k: Integer;
   QQ: TQSO;
   SS, SSS: String;
   NewSeries: Integer;
begin
   if Q = nil  then begin
      Exit;
   end;

   FQTCList.Clear();

   FQTCReqStn := Q;
   FQTCSeries := 0;
   FPastQTC := 0;
   FQTCToBeSent := 0;

   // QTC�����M���X�g�����
   for i := 1 to Log.TotalQSO do begin
      QQ := Log.QsoList[i];

      // ���_�����̓X�L�b�v
      if (QQ.Dupe = True) or (QQ.Points = 0) or (QQ.Invalid = True) then begin
         Continue;
      end;

      // QTC����QSO���H
      j := pos('[QTC', QQ.memo);
      if j = 0 then begin  // QTC�܂�
         if CoreCall(QQ.CallSign) <> CoreCall(Q.CallSign) then begin
            if FQTCList.Count < 10 then begin
               FQTCList.Add(QQ);
            end;
         end;
      end
      else begin // get QTC Series and check for QTCs sent in the past
         SS := QQ.memo;

         // "[QTC�`"�ȑO��Trim����
         Delete(SS, 1, j - 1); // SS = [QTC??/?? CALLSIGN date time band]

         // ??/?? �̎��o��
         j := pos('/', SS);
         if j > 0 then begin   // "/"������
            // "/"�̍����FQTC��
            SSS := copy(SS, 5, j - 5);
            NewSeries := StrToIntDef(SSS, 0);
            if NewSeries > FQTCSeries then begin
               FQTCSeries := NewSeries;
            end;

            // " "�܂ŁiCALLSIGN�̑O�܂Łj�؂肾��
            k := pos(' ', SS);
            if k > 0 then begin
               Delete(SS, 1, k);

               // ����" "�܂Ő؂肾��
               j := pos(' ', SS);
               if j > 0 then begin
                  // SSS��CALLSIGN
                  SSS := copy(SS, 1, j - 1);

                  // �ߋ��ɑ��M�ς�
                  if CoreCall(Q.CallSign) = CoreCall(SSS) then begin
                     Inc(FPastQTC);
                  end;
               end;
            end;
         end;
      end;
   end;

   // ���M��
   SpinEdit.Value := FQTCList.Count;

   // ���M���X�g���Z�b�g
   ListBox.Clear;
   for i := 0 to FQTCList.Count - 1 do begin
      ListBox.Items.Add(TQSO(FQTCList[i]).QTCStr);
   end;

   // �ߋ��ɑ���������\��
   if FPastQTC > 0 then begin
      Label2.Caption := IntToStr(FPastQTC) + ' QTCs have been sent to ' + Q.CallSign + ' already';
   end
   else begin
      Label2.Caption := '';
   end;

   // ���ɂ��������M���Ă���ꍇ�͌��炷
   SpinEdit.Value := FQTCList.Count - FPastQTC;
   for i := SpinEdit.Value to FQTCList.Count - 1 do begin
      ListBox.Items[i] := '';
   end;

   // ���M������̂�����ꍇ
   if FQTCList.Count > 0 then begin
      inc(FQTCSeries);
      Label1.Caption := Q.CallSign + ' QTC ' + IntToStr(FQTCSeries) + '/' + IntToStr(SpinEdit.Value);
   end;
end;

procedure TQTCForm.btnSendClick(Sender: TObject);
var
   cQ: TQSO;
   S: string;
begin
   SpinEdit.Enabled := False;

   // ���M�����ς݂Ȃ�
   if btnSend.Caption = QTC_DONE then begin
      Close;
      Exit;
   end;

   // ���M���镨�����邩
   if FQTCToBeSent = 0 then begin   // �Ȃ�
      if FQTCReqStn.Mode = mCW then begin
         S := '   ' + FQTCReqStn.CallSign + ' ' + BuildQTCInitString();
         zLogSendStr(MainForm.CurrentRigID, S + '"');

         WaitForSent();
      end;
   end
   else begin
      ListBox.Selected[FQTCToBeSent - 1] := True;
      cQ := TQSO(FQTCList[FQTCToBeSent - 1]);

      // QTC�����M�Ȃ�Memo����QTC�d��������
      if pos('[QTC', cQ.memo) = 0 then begin
         cQ.memo := '[QTC' + IntToStr(FQTCSeries) + '/' + IntToStr(SpinEdit.Value) + ' ' + FQTCReqStn.CallSign +
                    FormatDateTime(' yyyy-mm-dd hhnn ', CurrentTime) + ADIFBandString[FQTCReqStn.Band] + ']' + cQ.memo;
      end;

      // ���O�ɕۑ�
      MainForm.ZLinkForm.EditQSObyID(cQ);

      if FQTCReqStn.Mode = mCW then begin
         S := cQ.QTCStr;
         zLogSendStr(MainForm.CurrentRigID, S + '"');

         WaitForSent();
      end;
   end;

   // ���M�����J�E���g
   Inc(FQTCToBeSent);

   // ���M�����f�[�^��or���M���𒴂�����I���
   if (FQTCToBeSent = FQTCList.Count + 1) or (FQTCToBeSent = SpinEdit.Value + 1) then begin
      btnSend.Caption := QTC_DONE;
      Label1.Caption := BuildQTCInitString() + QTC_SENT;
      Exit;
   end;

   Label1.Caption := '[QTC ' + IntToStr(FQTCSeries) + '/' + IntToStr(SpinEdit.Value) + '-' + IntToStr(FQTCToBeSent) + '] ' +
                     TQSO(FQTCList[FQTCToBeSent - 1]).QTCStr;
end;

procedure TQTCForm.btnBackClick(Sender: TObject);
begin
   if FQTCToBeSent >= 1 then
      Dec(FQTCToBeSent);

   if btnSend.Caption = QTC_DONE then begin
      btnSend.Caption := QTC_SEND;
   end;

   if FQTCToBeSent = 0 then begin
      Label1.Caption := FQTCReqStn.CallSign + ' ' + BuildQTCInitString();
   end
   else begin
      Label1.Caption := '[QTC ' + IntToStr(FQTCSeries) + '/' + IntToStr(FQTCToBeSent) + '] ' +
                        TQSO(FQTCList[FQTCToBeSent - 1]).QTCStr;
   end;
end;

procedure TQTCForm.SpinEditChange(Sender: TObject);
var
   i, maxQTC: Integer;
begin
   maxQTC := 10 - FPastQTC;
   if FQTCList.Count < maxQTC then begin
      maxQTC := FQTCList.Count;
   end;

   if SpinEdit.Value > maxQTC then begin
      SpinEdit.Value := maxQTC;
   end;

   for i := 0 to SpinEdit.Value - 1 do begin
      ListBox.Items[i] := TQSO(FQTCList[i]).QTCStr;
   end;

   for i := SpinEdit.Value to FQTCList.Count - 1 do begin
      ListBox.Items[i] := '';
   end;

   Label1.Caption := FQTCReqStn.CallSign + ' ' + BuildQTCInitString();
end;

procedure TQTCForm.WaitForSent();
begin
   // �{�^���֎~
   btnSend.Enabled := False;
   btnBack.Enabled := False;

   // ���M���I���܂ő҂����킹
   dmZlogKeyer.UserFlag := True;
   repeat
      Application.ProcessMessages;
   until dmZlogKeyer.UserFlag = False;

   // �{�^����Ԗ߂�
   btnSend.Enabled := True;
   btnBack.Enabled := True;
end;

function TQTCForm.BuildQTCInitString(): string;
begin
   Result := 'QTC ' + IntToStr(FQTCSeries) + '/' + IntToStr(SpinEdit.Value);
end;

end.
