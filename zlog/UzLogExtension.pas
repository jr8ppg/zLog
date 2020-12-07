unit UzLogExtension;

{ zLog����O���̃v���O�������Ăяo�����߂̐؂�����ā� }
{ ���̃t�@�C���ۂ��ƃJ�X�^�}�C�Y����Ηǂ� }
{ example�͈�ʓI��DLL�Ăяo���̃T���v�� }

{
  �ʌ���UExceptionDialog.pas�ł̐ݒ�
  �u�v���W�F�N�g�v�|�uJCL Debug expert�v�|�uGenerate .jdbg files�v�|�uEnabled for this project�v��I��
  �u�v���W�F�N�g�v�|�uJCL Debug expert�v�|�uInsert JDBG data into the binary�v�|�uEnabled for this project�v��I��
}

//{$DEFINE USE_ZLOGEXT_EXAMPLE}

interface

uses
  Windows, SysUtils, Classes, Forms, UzLogQSO;

type
  TzLogEvent = ( evAddQSO = 0, evModifyQSO, evDeleteQSO );

// zLog�{�̂���Ăяo����鏈��
procedure zLogInitialize();
procedure zLogContestInit(strContestName, strCfgFileName: string);
procedure zLogContestEvent(event: TzLogEvent; bQSO, aQSO: TQSO);
procedure zLogContestTerm();
procedure zLogTerminate();
function zLogCalcPointsHookHandler(aQSO: TQSO): Boolean;
function zLogExtractMultiHookHandler(aQSO: TQSO; var strMulti: string): Boolean;
function zLogValidMultiHookHandler(strMulti: string; var fValidMulti: Boolean): Boolean;
function zLogGetTotalScore(): Integer;

implementation

var
  zLogContestInitialized: Boolean;  // �R���e�X�g�����������t���O

// example
// extension.dll���́��̊֐����Ăяo���� �������SHIFT-JIS
// void _stdcall zLogExtensionProcName(int event, LPCSTR pszCallsign, QSODATA *pqsorec);

(*
typedf struct _QSODATA {
  double Time;
  char CallSign[13];
  char NrSent[31];
  char NrRcvd[31];
  WORD RSTSent;
  WORD RSTRcvd;
  int  Serial;
  BYTE Mode;
  BYTE Band;
  BYTE Power;
  char Multi1[31];
  char Multi2[31];
  BOOL NewMulti1;
  BOOL NewMulti2;
  BYTE Points:
  char Operator[15];
  char Memo[65];
  BOOL CQ;
  BOOL Dupe
  BYTE Reserve;
  BYTE TX;
  int  Power2;
  int  Reserve2;
  int  Reserve3;
} QSODATA;
*)

type
  PTQSOData = ^TQSOData;
  TExtensionQsoEventProc = procedure(event: Integer; pszCallsign: PAnsiChar; pqsorec: PTQSOData); stdcall;
  TExtensionPointsCalcProc = function(pqsorec: PTQSOData): Integer; stdcall;
  TExtensionExtractMultiProc = function(pqsorec: PTQSOData; pszMultiStr: PAnsiChar; nBufferSize: Integer): Integer; stdcall;
  TExtensionValidMultiProc = function(pszMultiStr: PAnsiChar): Boolean; stdcall;
  TExtensionGetTotalScoreProc = function(): Integer; stdcall;

{$IFDEF USE_ZLOGEXT_EXAMPLE}
var
  hExtensionDLL: THandle;
  pfnExtensionQsoEventProc: TExtensionQsoEventProc;
  pfnExtensionCalsPountsProc: TExtensionPointsCalcProc;
  pfnExtensionExtractMultiProc: TExtensionExtractMultiProc;
  pfnExtensionValidMultiProc: TExtensionValidMultiProc;
  pfnExtensionGetTotalScoreProc: TExtensionGetTotalScoreProc;
{$ENDIF}

// zLog�̋N��
procedure zLogInitialize();
var
   strExtensionDLL: string;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('zLogInitialize()'));
   {$ENDIF}

   {$IFDEF USE_ZLOGEXT_EXAMPLE}
   // example
   strExtensionDLL := ExtractFilePath(Application.ExeName) + 'zlog_extension.dll';
   if FileExists(strExtensionDLL) = False then begin
      Exit;
   end;

   hExtensionDLL := LoadLibrary(PChar(strExtensionDLL));
   if hExtensionDLL = 0 then begin
      Exit;
   end;

   @pfnExtensionQsoEventProc := GetProcAddress(hExtensionDLL, LPCSTR('zLogExtensionProcName'));
   @pfnExtensionCalsPountsProc := GetProcAddress(hExtensionDLL, LPCSTR('zLogExtensionPointsCalcProcName'));
   @pfnExtensionExtractMultiProc := GetProcAddress(hExtensionDLL, LPCSTR('zLogExtensionExtractMultiProcName'));
   @pfnExtensionValidMultiProc := GetProcAddress(hExtensionDLL, LPCSTR('zLogExtensionValidMultiProcName'));
   @pfnExtensionGetTotalScoreProc := GetProcAddress(hExtensionDLL, LPCSTR('zLogExtensionGetTotalScoreProcName'));
   {$ENDIF}
end;

// �R���e�X�g�̏���������
// strContestName �E�E�E �R���e�X�g���AUserDefined�̏ꍇ��CFG�t�@�C�����̃R���e�X�g��
// strCfgFileName �E�E�E CFG�t�@�C���� =''�̎��͕K��builtin�R���e�X�g !=''�̎��͕K��UserDefined
procedure zLogContestInit(strContestName, strCfgFileName: string);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('zLogContestInit(''' + strContestName + ''',''' + strCfgFileName + ''')'));
   {$ENDIF}

   {$IFDEF USE_ZLOGEXT_EXAMPLE}
   zLogContestInitialized := True;
   {$ENDIF}
end;

// ��M�f�[�^�̒ǉ��A�ύX�A�폜
//                         �ǉ�  �ύX  �폜
// bQSO �E�E�E before QSO  nil   ��    ��
// aQSO �E�E�E after QSO   ��    ��    nil
procedure zLogContestEvent(event: TzLogEvent; bQSO, aQSO: TQSO);
var
   qsorec: TQSOData;
   {$IFDEF DEBUG}
   astr, bstr: string;
   {$ENDIF}
begin
   if zLogContestInitialized = False then begin
      Exit;
   end;

   {$IFDEF DEBUG}
   if Assigned(bQSO) then bstr := bQSO.Callsign else bstr := 'nil';
   if Assigned(aQSO) then astr := aQSO.Callsign else astr := 'nil';
   OutputDebugString(PChar('zLogEventProc(' + IntToStr(Integer(event)) + ',' + '''' + bstr + ''',' + '''' + astr + ''')'));
   {$ENDIF}

   {$IFDEF USE_ZLOGEXT_EXAMPLE}
   // example
   if Assigned(pfnExtensionQsoEventProc) then begin
      qsorec := aQSO.FileRecord;
      pfnExtensionQsoEventProc(Integer(event), PAnsiChar(AnsiString(aQSO.Callsign)), @qsorec);
   end;
   {$ENDIF}
end;

// �R���e�X�g�̏I��
procedure zLogContestTerm();
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('zLogContestTerm()'));
   {$ENDIF}
   zLogContestInitialized := False;
end;

// zLog�̏I��
procedure zLogTerminate();
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('zLogTerminate()'));
   {$ENDIF}

   {$IFDEF USE_ZLOGEXT_EXAMPLE}
   // example
   if hExtensionDLL <> 0 then begin
      FreeLibrary(hExtensionDLL);
   end;
   {$ENDIF}
end;

// ���_�̌v�Z handle�����ꍇ�FTrue�A���Ȃ������ꍇ�FFalse��Ԃ�
// handle������aQSO.Points�ɓ_��������
// DLL�̊֐��Œ��ړ���Ă��ǂ�
function zLogCalcPointsHookHandler(aQSO: TQSO): Boolean;
var
   pts: Integer;
   qsorec: TQSOData;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('zLogCalcPointsHandler()'));
   {$ENDIF}

   {$IFDEF USE_ZLOGEXT_EXAMPLE}
   if hExtensionDLL = 0 then begin
      Result := False;  // not handled
      Exit;
   end;

   if Not Assigned(pfnExtensionCalsPountsProc) then begin
      Result := False;  // not handled
      Exit;
   end;

   // ���_���v�Z����
   qsorec := aQSO.FileRecord;
   pts := pfnExtensionCalsPountsProc(@qsorec);

   aQSO.Points := pts;

   // handled
   Result := True;
   {$ELSE}
   Result := False;
   {$ENDIF}
end;

// �}���`������̒��o���s�� handle�����ꍇ�FTrue�A���Ȃ������ꍇ�FFalse��Ԃ�
// aQSO.NrRcvd������n���Ă��ǂ��Ǝv�����A�Ƃ肠�����͑S���n���Εs���͂Ȃ�����
function zLogExtractMultiHookHandler(aQSO: TQSO; var strMulti: string): Boolean;
var
   qsorec: TQSOData;
   szBuffer: array[0..255] of AnsiChar;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('zLogExtractMultiHandler()'));
   {$ENDIF}

   {$IFDEF USE_ZLOGEXT_EXAMPLE}
   if hExtensionDLL = 0 then begin
      Result := False;  // not handled
      Exit;
   end;

   if Not Assigned(pfnExtensionExtractMultiProc) then begin
      Result := False;  // not handled
      Exit;
   end;

   // �}���`�𒊏o
   qsorec := aQSO.FileRecord;

   // ��Fqsorec.NrRcvd����}���`�𒊏o��szBuffer��C��������i�[����֐��Ƃ���
   ZeroMemory(@szBuffer, SizeOf(szBuffer));
   pfnExtensionExtractMultiProc(@qsorec, @szBuffer, SizeOf(szBuffer));

   // C�������Delphi������ɕϊ�
   strMulti := string(PAnsiChar(@szBuffer));

   // handled
   Result := True;
   {$ELSE}
   Result := False;
   {$ENDIF}
end;

// �L���}���`���ǂ����̔�����s�� handle�����ꍇ�FTrue�A���Ȃ������ꍇ�FFalse��Ԃ�
// ���茋�ʂ�fValidMulti�Ɋi�[���� �L���FTrue�A�����FFalse
function zLogValidMultiHookHandler(strMulti: string; var fValidMulti: Boolean): Boolean;
var
   strAnsiMulti: AnsiString;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('zLogValidMultiHandler()'));
   {$ENDIF}

   {$IFDEF USE_ZLOGEXT_EXAMPLE}
   if hExtensionDLL = 0 then begin
      Result := False;  // not handled
      Exit;
   end;

   if Not Assigned(pfnExtensionValidMultiProc) then begin
      Result := False;  // not handled
      Exit;
   end;

   // SHIFT-JIS��C�������n���ėL�������肷��
   // Unicode�����񂪏����ł���Ȃ�PChar�œn���Ηǂ�
   strAnsiMulti := AnsiString(strMulti);
   fValidMulti := pfnExtensionValidMultiProc(PAnsiChar(strAnsiMulti));

   // handled
   Result := True;
   {$ELSE}
   Result := False;
   {$ENDIF}
end;

// �����_��Ԃ�
// -1�͖�������v�Z���Ȃ��Ƃ��i���̏������s���j
// >=0 �͑����_
function zLogGetTotalScore(): Integer;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('zLogGetTotalScore()'));
   {$ENDIF}

   {$IFDEF USE_ZLOGEXT_EXAMPLE}
   if hExtensionDLL = 0 then begin
      Result := -1;  // not handled
      Exit;
   end;

   if Not Assigned(pfnExtensionGetTotalScoreProc) then begin
      Result := -1;  // not handled
      Exit;
   end;

   Result := pfnExtensionGetTotalScoreProc();
   {$ELSE}
   Result := -1;
   {$ENDIF}
end;

initialization
  zLogContestInitialized := False;

  {$IFDEF USE_ZLOGEXT_EXAMPLE}
  // example
  hExtensionDLL := 0;
  pfnExtensionQsoEventProc := nil;
  pfnExtensionCalsPountsProc := nil;
  pfnExtensionExtractMultiProc := nil;
  pfnExtensionValidMultiProc := nil;
  pfnExtensionGetTotalScoreProc := nil;
  {$ENDIF}

finalization

end.