{*******************************************************************************
 * Amateur Radio Operational Logging Software 'ZyLO' since 2020 June 22
 * License: The MIT License since 2021 October 28 (see LICENSE)
 * Author: Journal of Hamradio Informatics (http://pafelog.net)
*******************************************************************************}
unit UzLogExtension;

interface

uses
	Classes,
	Dialogs,
	Windows,
	Math,
	Forms,
	Menus,
	IOUtils,
	UITypes,
	Controls,
	IniFiles,
	StdCtrls,
	StrUtils,
	SysUtils,
	UzLogCW,
	UzLogQSO,
	UzLogConst,
	UzLogGlobal,
	UMultipliers,
	AnsiStrings,
	JclFileUtils,
	RegularExpressions,
	System.Notification,
	Generics.Collections;

type
	TzLogEvent = (evInsertQSO = 0, evUpdateQSO, evDeleteQSO);
	TImportDialog = class(TOpenDialog)
		procedure ImportMenuClicked(Sender: TObject);
	end;
	TExportDialog = class(TSaveDialog)
		procedure ExportMenuClicked(Sender: TObject);
		procedure FilterTypeChanged(Sender: TObject);
	end;
	TDLL = class
		AllowInsert: procedure(fun: pointer); stdcall;
		AllowDelete: procedure(fun: pointer); stdcall;
		AllowUpdate: procedure(fun: pointer); stdcall;
		AllowDialog: procedure(fun: pointer); stdcall;
		AllowNotify: procedure(fun: pointer); stdcall;
		AllowAccess: procedure(fun: pointer); stdcall;
		AllowHandle: procedure(fun: pointer); stdcall;
		AllowButton: procedure(fun: pointer); stdcall;
		AllowEditor: procedure(fun: pointer); stdcall;
		QueryFormat: procedure(fun: pointer); stdcall;
		QueryCities: procedure(fun: pointer); stdcall;
		LaunchEvent: function: boolean; stdcall;
		FinishEvent: function: boolean; stdcall;
		WindowEvent: procedure(msg: pointer); stdcall;
		ImportEvent: procedure(path, target: PAnsiChar); stdcall;
		ExportEvent: procedure(path, format: PAnsiChar); stdcall;
		AttachEvent: procedure(rule, config: PAnsiChar); stdcall;
		AssignEvent: procedure(rule, config: PAnsiChar); stdcall;
		DetachEvent: procedure(rule, config: PAnsiChar); stdcall;
		OffsetEvent: procedure(off: integer); stdcall;
		InsertEvent: procedure(ptr: pointer); stdcall;
		DeleteEvent: procedure(ptr: pointer); stdcall;
		VerifyEvent: procedure(ptr: pointer); stdcall;
		PointsEvent: function (pts, mul: integer): integer; stdcall;
		ButtonEvent: procedure(idx, btn: integer); stdcall;
		EditorEvent: procedure(idx, key: integer); stdcall;
		constructor Create(path: string);
	private
		bad: boolean;
		hnd: THandle;
	end;
	TButtonBridge = class
		Source: TButton;
		Target: TDLL;
		Number: integer;
		Parent: TNotifyEvent;
		procedure Handle(Sender: TObject);
	end;
	TEditorBridge = class
		Source: TEdit;
		Target: TDLL;
		Number: integer;
		Parent: TKeyPressEvent;
		procedure Handle(Sender: TObject; var Key: Char);
	end;

var
	Fmt: string;
	LastDLL: TDLL;
	FileDLL: TDLL;
	RuleDLL: TDLL;
	RuleName: string;
	RulePath: string;
	Enabled: boolean;
	CityList: TCityList;
	handlerNum: integer;
	ImportMenu: TMenuItem;
	ExportMenu: TMenuItem;
	ImportDialog: TImportDialog;
	ExportDialog: TExportDialog;
	Toasts: TNotificationCenter;
	Rules: TDictionary<string, TDLL>;
	Props: TDictionary<string, string>;

const
	ResponseCapacity = 256;
	KEY_LIST = 'items';
	KEY_DLLS = 'DLLs';
	KEY_PATH = 'path';
	KEY_ZYLO = 'zylo';

(*enable/remove DLLs*)
function LoadIniFile: TIniFile;
procedure InstallDLL(path: string);
procedure DisableDLL(path: string);
function CanInstallDLL(path: string): boolean;
function CanDisableDLL(path: string): boolean;

(*zLog event handlers*)
procedure zyloRuntimeLaunch;
procedure zyloRuntimeFinish;
procedure zyloWindowMessage(var msg: TMsg);
procedure zyloContestSwitch(test, path: string);
procedure zyloContestOpened(test, path: string);
procedure zyloContestClosed;
procedure zyloLogUpdated(event: TzLogEvent; bQSO, aQSO: TQSO);

(*zLog contest rules*)
function zyloRequestTotal(Points, Multi: integer): integer;
function zyloRequestScore(aQSO: TQSO): boolean;
function zyloRequestMulti(aQSO: TQSO; var mul: string): boolean;
function zyloRequestValid(aQSO: TQSO; var val: boolean): boolean;
function zyloRequestTable(Path: string; List: TCityList): boolean;

(*callback functions*)
procedure InsertCallBack(ptr: pointer); stdcall;
procedure DeleteCallBack(ptr: pointer); stdcall;
procedure UpdateCallBack(ptr: pointer); stdcall;
procedure FormatCallBack(f: PAnsiChar); stdcall;
procedure CitiesCallBack(f: PAnsiChar); stdcall;
procedure DialogCallBack(f: PAnsiChar); stdcall;
procedure NotifyCallBack(f: PAnsiChar); stdcall;
procedure AccessCallBack(f: PAnsiChar); stdcall;
function HandleCallBack(f: PAnsiChar): THandle; stdcall;
function ButtonCallBack(f: PAnsiChar): integer; stdcall;
function EditorCallBack(f: PAnsiChar): integer; stdcall;

(*C<->Delphi string converters*)
function DtoC(str: string): PAnsiChar;
function CtoD(str: PAnsiChar): string;

function FindUI(name: string): TComponent;

(*zylo query handlers*)
function Version: string;
function Request(v: string; qso: TQSO): string;

implementation

uses
	main;

function DtoC(str: string): PAnsiChar;
begin
	Result := PAnsiChar(AnsiString(str));
end;

function CtoD(str: PAnsiChar): string;
begin
	Result := string(UTF8String(str));
end;

function FindUI(name: string): TComponent;
begin
	Result := Application;
	for name in SplitString(name, '.') do
		Result := Result.FindComponent(name);
end;

function Version: string;
var
	info: TJclFileVersionInfo;
begin
	info := TJclFileVersionInfo.Create(MainForm.Handle);
	Result := info.FileVersion;
	info.Free;
end;

function Request(v: string; qso: TQSO): string;
var
	key: string;
begin
	Props.AddOrSetValue('{V}', Version);
	Props.AddOrSetValue('{F}', CurrentFileName);
	Props.AddOrSetValue('{C}', UpperCase(dmZLogGlobal.MyCall));
	Props.AddOrSetValue('{B}', qso.BandStr);
	Props.AddOrSetValue('{M}', qso.ModeStr);
	if MyContest <> nil then v := UzLogCW.SetStrNoAbbrev(v, qso);
	for key in Props.Keys do v := ReplaceStr(v, key, Props[key]);
	Result := v;
end;

(*callback function that will be invoked by DLL*)
procedure InsertCallBack(ptr: pointer); stdcall;
var
	qso: TQSO;
begin
	qso := TQSO.Create;
	qso.FileRecord := TQSOData(ptr^);
	MyContest.LogQSO(qso, True);
end;

(*callback function that will be invoked by DLL*)
procedure DeleteCallBack(ptr: pointer); stdcall;
var
	qso: TQSO;
begin
	qso := TQSO.Create;
	qso.FileRecord := TQSOData(ptr^);
	Log.DeleteQSO(qso);
	MyContest.Renew;
	qso.Free;
end;

(*callback function that will be invoked by DLL*)
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
	qso.Free;
end;

(*callback function that will be invoked by DLL*)
procedure FormatCallBack(f: PAnsiChar); stdcall;
begin
	if CtoD(f) = '' then Exit;
	ImportDialog.Filter := CtoD(f);
	ExportDialog.Filter := CtoD(f);
	ImportMenu.OnClick := ImportDialog.ImportMenuClicked;
	ExportMenu.OnClick := ExportDialog.ExportMenuClicked;
	ExportDialog.OnTypeChange := ExportDialog.FilterTypeChanged;
	FileDLL := LastDLL;
end;

(*callback function that will be invoked by DLL*)
procedure CitiesCallBack(f: PAnsiChar); stdcall;
var
	city: TCity;
	line: string;
	list: TStringList;
	vals: TArray<string>;
begin
	list := TStringList.Create;
	list.Text := AdjustLineBreaks(CtoD(f), tlbsLF);
	for line in list do begin
		city := TCity.Create;
		vals := TRegEx.Split(line, '\s+');
		city.CityNumber := vals[0];
		city.CityName := vals[1];
		city.Index := CityList.List.Count;
		CityList.List.Add(city);
		CityList.SortedMultiList.AddObject(city.CityNumber, city);
	end;
	list.Free;
end;

(*callback function that will be invoked by DLL*)
procedure DialogCallBack(f: PAnsiChar); stdcall;
begin
	MessageDlg(CtoD(f), mtInformation, [mbOK], 0);
end;

(*callback function that will be invoked by DLL*)
procedure NotifyCallBack(f: PAnsiChar); stdcall;
begin
	TThread.Queue(nil, procedure
	var
		Toast: TNotification;
	begin
		Toast := Toasts.CreateNotification;
		Toast.name := 'zLog';
		Toast.Title := 'ZyLO';
		Toast.AlertBody := CtoD(f);
		try
			Toasts.PresentNotification(Toast);
		finally
			Toast.Free;
		end;
	end);
end;

(*callback function that will be invoked by DLL*)
procedure AccessCallBack(f: PAnsiChar); stdcall;
var
	v: string;
begin
	v := Request(CtoD(f), main.CurrentQSO);
	SetLength(v, Min(Length(v), ResponseCapacity));
	AnsiStrings.StrCopy(f, DtoC(v));
end;

(*callback function that will be invoked by DLL*)
function HandleCallBack(f: PAnsiChar): THandle; stdcall;
var
	comp: TComponent;
begin
	comp := FindUI(CtoD(f));
	if comp is TMenu then
		Result := TMenu(comp).Handle
	else if comp is TMenuItem then
		Result := TMenuItem(comp).Handle
	else if comp is TWinControl then
		Result := TWinControl(comp).Handle
	else
		Result := 0;
end;

(*callback function that will be invoked by DLL*)
function ButtonCallBack(f: PAnsiChar): integer; stdcall;
var
	Source: TButton;
	Bridge: TButtonBridge;
begin
	Inc(handlerNum);
	Result := handlerNum;
	Source := TButton(FindUI(CtoD(f)));
	if (Source <> nil) and (LastDLL <> nil) then begin
		Bridge := TButtonBridge.Create;
		Bridge.Source := Source;
		Bridge.Target := LastDLL;
		Bridge.Number := Result;
		Bridge.Parent := Source.OnClick;
		Source.OnClick := Bridge.Handle;
	end;
end;

(*callback function that will be invoked by DLL*)
function EditorCallBack(f: PAnsiChar): integer; stdcall;
var
	Source: TEdit;
	Bridge: TEditorBridge;
begin
	Inc(handlerNum);
	Result := handlerNum;
	Source := TEdit(FindUI(CtoD(f)));
	if (Source <> nil) and (LastDLL <> nil) then begin
		Bridge := TEditorBridge.Create;
		Bridge.Source := Source;
		Bridge.Target := LastDLL;
		Bridge.Number := Result;
		Bridge.Parent := Source.OnKeyPress;
		Source.OnKeyPress := Bridge.Handle;
	end;
end;

function LoadIniFile: TIniFile;
begin
	Result := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
end;

function GetDLLsINI: TList<String>;
var
	init: TIniFile;
	text: string;
begin
	init := LoadIniFile;
	text := init.ReadString(KEY_ZYLO, KEY_DLLS, '');
	Result := TList<String>.Create;
	Result.AddRange(text.Split([',']));
	init.Free;
end;

procedure SetDLLsINI(list: TList<String>);
var
	init: TIniFile;
	text: TStringList;
	item: string;
begin
	init := LoadIniFile;
	text := TStringList.Create;
	for item in list do text.Append(item);
	init.WriteString(KEY_ZYLO, KEY_DLLS, text.DelimitedText);
	init.Free;
end;

procedure InstallDLL(path: string);
var
	list: TList<String>;
begin
	MainForm.actionBackupExecute(MainForm);
	list := GetDLLsINI;
	if not list.Contains(path) then begin
		list.Add(path);
		SetDLLsINI(list);
	end;
	if not Rules.ContainsKey(path) then TDLL.Create(path);
	list.Free;
end;

procedure DisableDLL(path: string);
var
	list: TList<String>;
begin
	list := GetDLLsINI;
	list.Remove(path);
	SetDLLsINI(list);
	list.Free;
end;

procedure DisableAll;
var
	list: TList<String>;
begin
	list := TList<String>.Create;
	SetDLLsINI(list);
	list.Free;
end;

function CanInstallDLL(path: string): boolean;
begin
	Result := not CanDisableDLL(path);
end;

function CanDisableDLL(path: string): boolean;
var
	list: TList<string>;
begin
	list := GetDLLsINI;
	Result := list.Contains(path);
	list.Free;
end;

procedure zyloRuntimeLaunch;
var
	list: TList<String>;
	path: string;
begin
	ImportMenu := MainForm.MergeFile1;
	ExportMenu := MainForm.Export1;
	ImportDialog := TImportDialog.Create(MainForm);
	ExportDialog := TExportDialog.Create(MainForm);
	Toasts := TNotificationCenter.Create(MainForm);
	list := GetDLLsINI;
	for path in list do TDLL.Create(path);
	list.Free;
end;

procedure zyloRuntimeFinish;
var
	dll: TDLL;
begin
	(*do not close Go DLL*)
	for dll in Rules.Values do
		if dll.FinishEvent then
			FreeLibrary(dll.hnd);
	FreeAndNil(ImportDialog);
	FreeAndNil(ExportDialog);
end;

procedure zyloWindowMessage(var msg: TMsg);
var
	dll: TDLL;
begin
	for dll in Rules.Values do dll.WindowEvent(@msg);
end;

procedure zyloContestSwitch(test, path: string);
var
	line: string;
	link: string;
	list: TStringList;
begin
	if not FileExists(path) then Exit;
	list := TStringList.Create;
	list.Text := TFile.ReadAllText(path);
	for line in list do
		if TRegEx.IsMatch(line, '(?i)\s*dll\s*') then
			link := Trim(Trim(line).Substring(3));
	if Rules.ContainsKey(link) then begin
		RuleDLL := Rules[link];
		RuleName := test;
		RulePath := path;
	end else if link <> '' then
		MessageDlg(link + ' not installed', mtWarning, [mbOK], 0);
	list.Free;
end;

procedure zyloContestOpened(test, path: string);
var
	dll: TDLL;
	tag: PAnsiChar;
	cfg: PAnsiChar;
begin
	Enabled := True;
	tag := DtoC(RuleName);
	cfg := DtoC(RulePath);
	for dll in Rules.Values do dll.OffsetEvent(UTCOffset);
	for dll in Rules.Values do dll.AttachEvent(tag, cfg);
	if RuleDLL <> nil then RuleDLL.AssignEvent(tag, cfg);
	MyContest.ScoreForm.UpdateData;
	MyContest.MultiForm.UpdateData;
end;

procedure zyloContestClosed;
var
	dll: TDLL;
	tag: PAnsiChar;
	cfg: PAnsiChar;
begin
	Enabled := False;
	tag := DtoC(RuleName);
	cfg := DtoC(RulePath);
	for dll in Rules.Values do dll.DetachEvent(tag, cfg);
	RuleDLL := nil;
end;

procedure zyloLogUpdated(event: TzLogEvent; bQSO, aQSO: TQSO);
var
	dll: TDLL;
	qso: TQSOData;
begin
	if not Enabled then Exit;
	if event <> evInsertQSO then begin
		qso := bQSO.FileRecord;
		for dll in Rules.Values do dll.DeleteEvent(@qso);
	end;
	if event <> evDeleteQSO then begin
		qso := aQSO.FileRecord;
		for dll in Rules.Values do dll.InsertEvent(@qso);
	end;
end;

function zyloRequestTotal(Points, Multi: integer): Integer;
begin
	if RuleDLL <> nil then
		Result := RuleDLL.PointsEvent(Points, Multi)
	else
		Result := -1;
end;

(*returns whether the QSO score is calculated by this handler*)
function zyloRequestScore(aQSO: TQSO): boolean;
var
	qso: TQSOData;
begin
	Result := RuleDLL <> nil;
	if Result then begin
		qso := aQSO.FileRecord;
		RuleDLL.VerifyEvent(@qso);
		aQSO.FileRecord := qso;
	end;
end;

(*returns whether the multiplier is extracted by this handler*)
function zyloRequestMulti(aQSO: TQSO; var mul: string): boolean;
var
	qso: TQSOData;
begin
	Result := RuleDLL <> nil;
	if Result then begin
		qso := aQSO.FileRecord;
		RuleDLL.VerifyEvent(@qso);
		aQSO.FileRecord := qso;
		mul := string(qso.Multi1);
	end;
end;

(*returns whether the multiplier is validated by this handler*)
function zyloRequestValid(aQSO: TQSO; var val: boolean): boolean;
var
	qso: TQSOData;
begin
	Result := RuleDLL <> nil;
	if Result then begin
		qso := aQSO.FileRecord;
		RuleDLL.VerifyEvent(@qso);
		aQSO.FileRecord := qso;
		val := qso.Multi1 <> '';
	end;
end;

(*returns whether the cities list is provided by this handler*)
function zyloRequestTable(Path: string; List: TCityList): boolean;
begin
	CityList := List;
	if RuleDLL <> nil then begin
		RuleDLL.QueryCities(@CitiesCallBack);
		Result := True;
	end else
		Result := False;
	CityList := nil;
end;

procedure TImportDialog.ImportMenuClicked(Sender: TObject);
var
	tmp: string;
begin
	if Execute then
	try
		tmp := TPath.GetTempFileName;
		FileDLL.ImportEvent(DtoC(FileName), DtoC(tmp));
		Log.QsoList.MergeFile(tmp, True);
		Log.SortByTime;
		MyContest.Renew;
		MainForm.EditScreen.RefreshScreen;
	finally
		TFile.Delete(tmp);
	end;
end;

procedure TExportDialog.ExportMenuClicked(Sender: TObject);
begin
	FilterTypeChanged(Sender);
	FileName := ChangeFileExt(CurrentFileName, DefaultExt);
	if Execute then begin
		Log.SaveToFile(FileName);
		FileDLL.ExportEvent(DtoC(FileName), DtoC(Fmt));
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

procedure TButtonBridge.Handle(Sender: TObject);
begin
	Target.ButtonEvent(Number, Number);
	Parent(Sender);
end;

procedure TEditorBridge.Handle(Sender: TObject; var Key: Char);
begin
	Target.EditorEvent(Number, integer(key));
	Parent(Sender, key);
end;

constructor TDLL.Create(path: string);
procedure NotifyMismatch;
var
	msg: string;
begin
	if bad then Exit;
	bad := True;
	msg := 'ZyLO API-version mismatch was detected in %s';
	MessageDlg(Format(msg, [path]), mtWarning, [mbOK], 0);
end;
function MustGetProc(name: PWideChar): pointer;
begin
	Result := GetProcAddress(hnd, name);
	if Result = nil then NotifyMismatch;
end;
begin
	hnd := LoadLibrary(PChar(path));
	if hnd = 0 then begin
		DisableDLL(path);
		Exit;
	end;
	AllowInsert := MustGetProc('zylo_allow_insert');
	AllowDelete := MustGetProc('zylo_allow_delete');
	AllowUpdate := MustGetProc('zylo_allow_update');
	AllowDialog := MustGetProc('zylo_allow_dialog');
	AllowNotify := MustGetProc('zylo_allow_notify');
	AllowAccess := MustGetProc('zylo_allow_access');
	AllowHandle := MustGetProc('zylo_allow_handle');
	AllowButton := MustGetProc('zylo_allow_button');
	AllowEditor := MustGetProc('zylo_allow_editor');
	QueryFormat := MustGetProc('zylo_query_format');
	QueryCities := MustGetProc('zylo_query_cities');
	LaunchEvent := MustGetProc('zylo_launch_event');
	FinishEvent := MustGetProc('zylo_finish_event');
	WindowEvent := MustGetProc('zylo_window_event');
	ImportEvent := MustGetProc('zylo_import_event');
	ExportEvent := MustGetProc('zylo_export_event');
	AttachEvent := MustGetProc('zylo_attach_event');
	AssignEvent := MustGetProc('zylo_assign_event');
	DetachEvent := MustGetProc('zylo_detach_event');
	OffsetEvent := MustGetProc('zylo_offset_event');
	InsertEvent := MustGetProc('zylo_insert_event');
	DeleteEvent := MustGetProc('zylo_delete_event');
	VerifyEvent := MustGetProc('zylo_verify_event');
	PointsEvent := MustGetProc('zylo_points_event');
	ButtonEvent := MustGetProc('zylo_button_event');
	EditorEvent := MustGetProc('zylo_editor_event');
	if bad then Exit;
	LastDLL := Self;
	(*LastDLL must be set here*)
	AllowInsert(@InsertCallBack);
	AllowDelete(@DeleteCallBack);
	AllowUpdate(@UpdateCallBack);
	AllowDialog(@DialogCallBack);
	AllowNotify(@NotifyCallBack);
	AllowAccess(@AccessCallBack);
	AllowHandle(@HandleCallBack);
	AllowButton(@ButtonCallBack);
	AllowEditor(@EditorCallBack);
	QueryFormat(@FormatCallBack);
	if not LaunchEvent then NotifyMismatch;
	Rules.Add(ExtractFileName(path), Self);
	LastDLL := nil;
	(*LastDLL must be nil here*)
end;

initialization
	Rules := TDictionary<string, TDLL>.Create;
	Props := TDictionary<string, string>.Create;

finalization
	Rules.Free;
	Props.Free;

end.
