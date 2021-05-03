{*******************************************************************************
 * Amateur Radio Operational Logging Software 'ZyLO' since 2020 June 22
 * License : GNU General Public License v3 (see LICENSE)
 * Author: Journal of Hamradio Informatics (http://pafelog.net)
*******************************************************************************}
unit UzLogExtension;

interface

uses
	Classes,
	Windows,
	Dialogs,
	IOUtils,
	StdCtrls,
	StrUtils,
	SysUtils,
	UITypes,
	UzLogQSO,
	UzLogGlobal,
	RegularExpressions;

type
	TzLogEvent = (evAddQSO = 0, evModifyQSO, evDeleteQSO);
	TImportDialog = class(TOpenDialog)
		procedure ImportMenuClicked(Sender: TObject);
	end;
	TExportDialog = class(TSaveDialog)
		procedure ExportMenuClicked(Sender: TObject);
		procedure FilterTypeChanged(Sender: TObject);
	end;
var
	Fmt: string;
	zHandle: THandle;
	ImportDialog: TImportDialog;
	ExportDialog: TExportDialog;
	zlaunch: procedure(str: PAnsiChar); stdcall;
	zfilter: function (): PAnsiChar; stdcall;
	zformat: procedure(src: PAnsiChar; dst: PAnsiChar; fmt: PAnsiChar); stdcall;
	zrevise: procedure(ptr: pointer; len: integer); stdcall;
	zverify: function (ptr: pointer; len: integer): integer; stdcall;
	zupdate: function (ptr: pointer; len: integer): integer; stdcall;
	zinsert: procedure(ptr: pointer; len: integer); stdcall;
	zdelete: procedure(ptr: pointer; len: integer); stdcall;
	zkpress: function (key: integer; source: PAnsiChar): boolean; stdcall;
	zfclick: function (btn: integer; source: PAnsiChar): boolean; stdcall;
	zfinish: procedure(); stdcall;

const
	BIN = 'zbin';
	LEN = sizeof(TQSOData);

(*zLog event handlers*)
procedure zLogInitialize();
procedure zLogContestInit(contest, cfg: string);
procedure zLogContestEvent(event: TzLogEvent; bQSO, aQSO: TQSO);
procedure zLogContestTerm();
procedure zLogTerminate();
function zLogCalcPointsHookHandler(aQSO: TQSO): boolean;
function zLogExtractMultiHookHandler(aQSO: TQSO; var mul: string): boolean;
function zLogValidMultiHookHandler(mul: string; var val: boolean): boolean;
function zLogGetTotalScore(): integer;
function zLogKeyBoardPressed(Sender: TObject; key: Char): boolean;
function zLogFunctionClicked(Sender: TObject): boolean;
function ToC(str: string): PAnsiChar;

implementation

uses
	main;

function ToC(str: string): PAnsiChar;
begin
	Result := PAnsiChar(AnsiString(str));
end;

procedure zLogInitialize();
begin
	ImportDialog := TImportDialog.Create(MainForm);
	ExportDialog := TExportDialog.Create(MainForm);
	ExportDialog.OnTypeChange := ExportDialog.FilterTypeChanged;
	ExportDialog.Options := [ofOverwritePrompt];
	MainForm.MergeFile1.Caption := '&Import...';
end;

procedure zLogContestInit(contest: string; cfg: string);
var
	dll: string;
	txt: string;
	fil: string;
begin
	txt := TFile.ReadAllText(cfg);
	txt := TRegEx.Replace(txt, '(?m);.*?$', '');
	txt := TRegEx.Replace(txt, '(?m)#.*?$', '');
	dll := TRegEx.Replace(cfg, '(?i)\.CFG', '.DLL');
	if TRegEx.Match(txt, '(?im)^ *DLL +ON *$').Success then
	try
		zHandle := LoadLibrary(PChar(dll));
		zlaunch := GetProcAddress(zHandle, '_zlaunch');
		zfilter := GetProcAddress(zHandle, '_zfilter');
		zformat := GetProcAddress(zHandle, '_zformat');
		zrevise := GetProcAddress(zHandle, '_zrevise');
		zverify := GetProcAddress(zHandle, '_zverify');
		zupdate := GetProcAddress(zHandle, '_zupdate');
		zinsert := GetProcAddress(zHandle, '_zinsert');
		zdelete := GetProcAddress(zHandle, '_zdelete');
		zkpress := GetProcAddress(zHandle, '_zkpress');
		zfclick := GetProcAddress(zHandle, '_zfclick');
		zfinish := GetProcAddress(zHandle, '_zfinish');
		zlaunch(ToC(cfg));
		fil := string(AnsiString(zfilter()));
		ImportDialog.Filter := fil;
		ExportDialog.Filter := fil;
		MainForm.MergeFile1.OnClick := ImportDialog.ImportMenuClicked;
		MainForm.Export1.OnClick    := ExportDialog.ExportMenuClicked;
	except
		zHandle := 0;
		MessageDlg('failed to load ' + dll, mtWarning, [mbOK], 0);
		MainForm.MergeFile1.OnClick := MainForm.MergeFile1Click;
		MainForm.Export1.OnClick    := MainForm.Export1Click;
	end;
end;

procedure zLogContestEvent(event: TzLogEvent; bQSO, aQSO: TQSO);
var
	qso: TQSOData;
begin
	if @zinsert <> nil then begin
		if event <> evDeleteQSO then begin
			qso := aQSO.FileRecord;
			zinsert(@qso, LEN);
		end;
	end;
	if @zdelete <> nil then begin
		if event <> evAddQSO then begin
			qso := bQSO.FileRecord;
			zdelete(@qso, LEN);
		end;
	end;
end;

procedure zLogContestTerm();
begin
	if @zfinish <> nil then begin
		zfinish();
		zlaunch := nil;
		zfilter := nil;
		zformat := nil;
		zrevise := nil;
		zverify := nil;
		zupdate := nil;
		zinsert := nil;
		zdelete := nil;
		zkpress := nil;
		zfclick := nil;
		zfinish := nil;
		FreeLibrary(zHandle);
		zHandle := 0;
	end;
end;

procedure zLogTerminate();
begin
end;

(*returns whether the QSO score is calculated by this handler*)
function zLogCalcPointsHookHandler(aQSO: TQSO): boolean;
var
	qso: TQSOData;
begin
	Result := @zverify <> nil;
	if Result then begin
		qso := aQSO.FileRecord;
		aQSO.Points := zverify(@qso, LEN);
	end;
end;

(*returns whether the multiplier is extracted by this handler*)
function zLogExtractMultiHookHandler(aQSO: TQSO; var mul: string): boolean;
var
	qso: TQSOData;
begin
	Result := @zrevise <> nil;
	if Result then begin
		qso := aQSO.FileRecord;
		zrevise(@qso, LEN);
		mul := string(qso.Multi1);
	end;
end;

(*returns whether the multiplier is validated by this handler*)
function zLogValidMultiHookHandler(mul: string; var val: boolean): boolean;
begin
	Result := @zHandle <> nil;
	if Result then
		val := mul <> '';
end;

function zLogGetTotalScore(): Integer;
var
	buf: TBytesStream;
	qso: TQSOData;
	idx: integer;
begin
	Result := -1;
	if @zupdate <> nil then begin
		buf := TBytesStream.Create;
		try
			for idx := 1 to Log.TotalQSO do begin
				qso := Log.QsoList[idx].FileRecord;
				buf.Write(qso, LEN);
			end;
			Result := zupdate(buf.bytes, Log.TotalQSO);
		finally
			buf.Free;
		end;
	end;
end;

procedure TImportDialog.ImportMenuClicked(Sender: TObject);
var
	tmp: string;
begin
	if Execute then
	try
		tmp := TPath.GetTempFileName;
		zformat(ToC(FileName), ToC(tmp), ToC(BIN));
		Log.QsoList.MergeFile(tmp, True);
		Log.SortByTime;
		MyContest.Renew;
		MainForm.EditScreen.RefreshScreen;
	finally
		TFile.Delete(tmp);
	end;
end;

procedure TExportDialog.ExportMenuClicked(Sender: TObject);
var
	tmp: string;
begin
	FilterTypeChanged(Sender);
	FileName := ChangeFileExt(CurrentFileName, DefaultExt);
	if Execute then begin
		tmp := TPath.GetTempFileName;
		Log.SaveToFile(tmp);
		zformat(ToC(tmp), ToC(FileName), ToC(Fmt));
	end;
end;

procedure TExportDialog.FilterTypeChanged(Sender: TObject);
var
	ext: string;
begin
	ext := SplitString(Filter, '|')[2 * FilterIndex - 1];
	Fmt := SplitString(Filter, '|')[2 * FilterIndex - 2];
	ext := TRegEx.Split(ext, ';')[0];
	ext := copy(ext, 2, Length(ext));
	DefaultExt := ext;
end;

(*returns whether the event is blocked by this handler*)
function zLogKeyBoardPressed(Sender: TObject; key: Char): boolean;
begin
	if @zkpress <> nil then
		Result := zkpress(integer(key), ToC(TEdit(Sender).Name))
	else
		Result := True;
end;

(*returns whether the event is blocked by this handler*)
function zLogFunctionClicked(Sender: TObject): boolean;
begin
	if @zfclick <> nil then
		Result := zfclick(TButton(Sender).Tag, ToC(TButton(Sender).Name))
	else
		Result := True;
end;

initialization

finalization

end.
