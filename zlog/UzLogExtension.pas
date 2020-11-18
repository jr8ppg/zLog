unit UzLogExtension;

{ zLogから外部のプログラムを呼び出すための切り口＜案＞ }
{ このファイル丸ごとカスタマイズすれば良い }
{ exampleは一般的なDLL呼び出しのサンプル }

{
  別件でUExceptionDialog.pasでの設定
  「プロジェクト」－「JCL Debug expert」－「Generate .jdbg files」－「Enabled for this project」を選択
  「プロジェクト」－「JCL Debug expert」－「Insert JDBG data into the binary」－「Enabled for this project」を選択
}

//{$DEFINE USE_ZLOGEXT_EXAMPLE}

interface

uses
  Windows, SysUtils, Classes, Forms, UzLogQSO;

type
  TzLogEvent = ( evAddQSO = 0, evModifyQSO, evDeleteQSO );

// zLog本体から呼び出される処理
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
  zLogContestInitialized: Boolean;  // コンテスト初期化完了フラグ

// example
// extension.dll内の↓の関数を呼び出す例 文字列はSHIFT-JIS
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

// zLogの起動
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

// コンテストの初期化完了
// strContestName ・・・ コンテスト名、UserDefinedの場合はCFGファイル内のコンテスト名
// strCfgFileName ・・・ CFGファイル名 =''の時は必ずbuiltinコンテスト !=''の時は必ずUserDefined
procedure zLogContestInit(strContestName, strCfgFileName: string);
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('zLogContestInit(''' + strContestName + ''',''' + strCfgFileName + ''')'));
   {$ENDIF}

   {$IFDEF USE_ZLOGEXT_EXAMPLE}
   zLogContestInitialized := True;
   {$ENDIF}
end;

// 交信データの追加、変更、削除
//                         追加  変更  削除
// bQSO ・・・ before QSO  nil   ○    ○
// aQSO ・・・ after QSO   ○    ○    nil
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

// コンテストの終了
procedure zLogContestTerm();
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('zLogContestTerm()'));
   {$ENDIF}
   zLogContestInitialized := False;
end;

// zLogの終了
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

// 得点の計算 handleした場合：True、しなかった場合：Falseを返す
// handleしたらaQSO.Pointsに点数を入れる
// DLLの関数で直接入れても良い
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

   // 得点を計算する
   qsorec := aQSO.FileRecord;
   pts := pfnExtensionCalsPountsProc(@qsorec);

   aQSO.Points := pts;

   // handled
   Result := True;
   {$ELSE}
   Result := False;
   {$ENDIF}
end;

// マルチ文字列の抽出を行う handleした場合：True、しなかった場合：Falseを返す
// aQSO.NrRcvdだけを渡しても良いと思うが、とりあえずは全部渡せば不足はなさそう
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

   // マルチを抽出
   qsorec := aQSO.FileRecord;

   // 例：qsorec.NrRcvdからマルチを抽出しszBufferへC文字列を格納する関数とする
   ZeroMemory(@szBuffer, SizeOf(szBuffer));
   pfnExtensionExtractMultiProc(@qsorec, @szBuffer, SizeOf(szBuffer));

   // C文字列をDelphi文字列に変換
   strMulti := string(PAnsiChar(@szBuffer));

   // handled
   Result := True;
   {$ELSE}
   Result := False;
   {$ENDIF}
end;

// 有効マルチかどうかの判定を行う handleした場合：True、しなかった場合：Falseを返す
// 判定結果はfValidMultiに格納する 有効：True、無効：False
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

   // SHIFT-JISのC文字列を渡して有効か判定する
   // Unicode文字列が処理できるならPCharで渡せば良い
   strAnsiMulti := AnsiString(strMulti);
   fValidMulti := pfnExtensionValidMultiProc(PAnsiChar(strAnsiMulti));

   // handled
   Result := True;
   {$ELSE}
   Result := False;
   {$ENDIF}
end;

// 総得点を返す
// -1は未実装や計算しないとき（元の処理を行う）
// >=0 は総得点
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
