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
	Menus,
	StdCtrls,
	StrUtils,
	SysUtils,
	UITypes,
	UzLogQSO,
	UzLogConst,
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
	Enabled: boolean;
	zHandle: THandle;
	ImportMenu: TMenuItem;
	ExportMenu: TMenuItem;
	ImportDialog: TImportDialog;
	ExportDialog: TExportDialog;
	zlaunch: procedure(); stdcall;
	zfinish: procedure(); stdcall;
	yinsert: procedure(fun: pointer); stdcall;
	ydelete: procedure(fun: pointer); stdcall;
	yupdate: procedure(fun: pointer); stdcall;
	yfilter: procedure(fun: pointer); stdcall;
	zimport: procedure(src: PAnsiChar; dst: PAnsiChar); stdcall;
	zexport: procedure(src: PAnsiChar; fmt: PAnsiChar); stdcall;
	zattach: procedure(str: PAnsiChar; cfg: PAnsiChar); stdcall;
	zdetach: procedure(); stdcall;
	zinsert: procedure(ptr: pointer); stdcall;
	zdelete: procedure(ptr: pointer); stdcall;
	zverify: procedure(ptr: pointer); stdcall;
	zpoints: function (): integer; stdcall;
	ztyping: function (key: integer; name: PAnsiChar): boolean; stdcall;
	zbutton: function (btn: integer; name: PAnsiChar): boolean; stdcall;

(*zLog event handlers*)
procedure zLogInitialize();
procedure zLogContestInit(contest, cfg: string);
procedure zLogContestEvent(event: TzLogEvent; bQSO, aQSO: TQSO);
procedure zLogContestTerm();
procedure zLogTerminate();
function zLogCalcPointsHookHandler(aQSO: TQSO): boolean;
function zLogExtractMultiHookHandler(aQSO: TQSO; var mul: string): boolean;
function zLogValidMultiHookHandler(aQSO: TQSO; var val: boolean): boolean;
function zLogGetTotalScore(): integer;
function zLogKeyBoardPressed(Sender: TObject; key: Char): boolean;
function zLogFunctionClicked(Sender: TObject): boolean;
function DtoC(str: string): PAnsiChar;
function CtoD(str: PAnsiChar): string;
procedure InsertCallBack(ptr: pointer); stdcall;
procedure DeleteCallBack(ptr: pointer); stdcall;
procedure UpdateCallBack(ptr: pointer); stdcall;
procedure FilterCallBack(f: PAnsiChar); stdcall;

implementation

uses
	main;

function DtoC(str: string): PAnsiChar;
begin
	Result := PAnsiChar(AnsiString(str));
end;

function CtoD(str: PAnsiChar): string;
begin
	Result := string(AnsiString(str));
end;

(*callback function that will be invoked from DLL*)
procedure InsertCallBack(ptr: pointer); stdcall;
var
	qso: TQSO;
begin
	qso := TQSO.Create;
	qso.FileRecord := TQSOData(ptr^);
	MyContest.LogQSO(qso, True);
end;

(*callback function that will be invoked from DLL*)
procedure DeleteCallBack(ptr: pointer); stdcall;
var
	qso: TQSO;
begin
	qso := TQSO.Create;
	qso.FileRecord := TQSOData(ptr^);
	qso.Reserve := actDelete;
	Log.AddQue(qso);
	Log.ProcessQue;
	MyContest.Renew;
end;

(*callback function that will be invoked from DLL*)
procedure UpdateCallBack(ptr: pointer); stdcall;
var
	qso: TQSO;
begin
	qso := TQSO.Create;
	qso.FileRecord := TQSOData(ptr^);
	qso.Reserve := actEdit;
	Log.AddQue(qso);
	Log.ProcessQue;
	MyContest.Renew;
end;

(*callback function that will be invoked from DLL*)
procedure FilterCallBack(f: PAnsiChar); stdcall;
begin
	ImportDialog.Filter := CtoD(f);
	ExportDialog.Filter := CtoD(f);
	ExportDialog.OnTypeChange := ExportDialog.FilterTypeChanged;
end;

procedure zLogInitialize();
var
	fil: AnsiString;
begin
	ImportMenu := MainForm.MergeFile1;
	ExportMenu := MainForm.Export1;
	ImportDialog := TImportDialog.Create(MainForm);
	ExportDialog := TExportDialog.Create(MainForm);
	ExportDialog.Options := [ofOverwritePrompt];
	try
		zHandle := LoadLibrary(PChar('zylo.dll'));
		zlaunch := GetProcAddress(zHandle, 'zylo_handle_launch');
		zfinish := GetProcAddress(zHandle, 'zylo_handle_finish');
		yinsert := GetProcAddress(zHandle, 'zylo_permit_insert');
		ydelete := GetProcAddress(zHandle, 'zylo_permit_delete');
		yupdate := GetProcAddress(zHandle, 'zylo_permit_update');
		yfilter := GetProcAddress(zHandle, 'zylo_permit_filter');
		zimport := GetProcAddress(zHandle, 'zylo_handle_import');
		zexport := GetProcAddress(zHandle, 'zylo_handle_export');
		zattach := GetProcAddress(zHandle, 'zylo_handle_attach');
		zdetach := GetProcAddress(zHandle, 'zylo_handle_detach');
		zinsert := GetProcAddress(zHandle, 'zylo_handle_insert');
		zdelete := GetProcAddress(zHandle, 'zylo_handle_delete');
		zverify := GetProcAddress(zHandle, 'zylo_handle_verify');
		zpoints := GetProcAddress(zHandle, 'zylo_handle_points');
		ztyping := GetProcAddress(zHandle, 'zylo_handle_kpress');
		zbutton := GetProcAddress(zHandle, 'zylo_handle_fclick');
	except
		zHandle := 0;
	end;
	if @zlaunch <> nil then zlaunch();
	if @yinsert <> nil then yinsert(@InsertCallBack);
	if @ydelete <> nil then ydelete(@DeleteCallBack);
	if @yupdate <> nil then yupdate(@UpdateCallBack);
	if @yfilter <> nil then yfilter(@FilterCallBack);
	if (@zimport <> nil) and (@zexport <> nil) then begin
		ImportMenu.OnClick := ImportDialog.ImportMenuClicked;
		ExportMenu.OnClick := ExportDialog.ExportMenuClicked;
	end;
end;

procedure zLogContestInit(contest: string; cfg: string);
var
	idx: integer
begin
	Enabled := True;
	if @zattach <> nil then
		zattach(DtoC(contest), DtoC(cfg));
	for idx := 1  to Log.TotalQSO do begin
		zLogContestEvent(evAddQSO, Log.QsoList[idx]);
		zLogCalcPointsHookHandler(Log.QsoList[idx]);
	end;
end;

procedure zLogContestEvent(event: TzLogEvent; bQSO, aQSO: TQSO);
var
	qso: TQSOData;
begin
	if not Enabled then Exit;
	if (@zinsert <> nil) and (event <> evDeleteQSO) then begin
		qso := aQSO.FileRecord;
		zinsert(@qso);
	end;
	if (@zdelete <> nil) and (event <> evAddQSO) then begin
		qso := bQSO.FileRecord;
		zdelete(@qso);
	end;
end;

procedure zLogContestTerm();
begin
	if @zdetach <> nil then
		zdetach();
	Enabled := False;
end;

procedure zLogTerminate();
begin
	(*do not close Go DLL*)
	if @zfinish <> nil then
		zfinish();
end;

(*returns whether the QSO score is calculated by this handler*)
function zLogCalcPointsHookHandler(aQSO: TQSO): boolean;
var
	qso: TQSOData;
begin
	Result := @zverify <> nil;
	if Result then begin
		qso := aQSO.FileRecord;
		zverify(@qso);
		aQSO.FileRecord := qso;
	end;
end;

(*returns whether the multiplier is extracted by this handler*)
function zLogExtractMultiHookHandler(aQSO: TQSO; var mul: string): boolean;
var
	qso: TQSOData;
begin
	Result := @zverify <> nil;
	if Result then begin
		qso := aQSO.FileRecord;
		zverify(@qso);
		aQSO.FileRecord := qso;
		mul := qso.Multi1;
	end;
end;

(*returns whether the multiplier is validated by this handler*)
function zLogValidMultiHookHandler(aQSO: TQSO; var val: boolean): boolean;
var
	qso: TQSOData;
begin
	Result := @zverify <> nil;
	if Result then begin
		qso := aQSO.FileRecord;
		zverify(@qso);
		aQSO.FileRecord := qso;
		val := qso.Multi1 <> '';
	end;
end;

function zLogGetTotalScore(): Integer;
begin
	if @zpoints <> nil then
		Result := zpoints()
	else
		Result := -1;
end;

procedure TImportDialog.ImportMenuClicked(Sender: TObject);
var
	tmp: string;
begin
	if Execute then
	try
		tmp := TPath.GetTempFileName;
		zimport(DtoC(FileName), DtoC(tmp));
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
		Log.SaveToFile(FileName);
		zexport(DtoC(FileName), DtoC(Fmt));
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
	if @ztyping <> nil then
		Result := ztyping(integer(key), DtoC(TEdit(Sender).Name))
	else
		Result := False;
end;

(*returns whether the event is blocked by this handler*)
function zLogFunctionClicked(Sender: TObject): boolean;
begin
	if @zbutton <> nil then
		Result := zbutton(TButton(Sender).Tag, DtoC(TButton(Sender).Name))
	else
		Result := False;
end;

initialization

finalization

end.
