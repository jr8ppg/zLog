{*******************************************************************************
 * Amateur Radio Operational Logging Software 'ZyLO' since 2020 June 22
 * License : GNU General Public License v3 (see LICENSE)
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
		AllowAccess: procedure(fun: pointer); stdcall;
		AllowButton: procedure(fun: pointer); stdcall;
		AllowEditor: procedure(fun: pointer); stdcall;
		QueryFormat: procedure(fun: pointer); stdcall;
		QueryCities: procedure(fun: pointer); stdcall;
		LaunchEvent: procedure; stdcall;
		FinishEvent: procedure; stdcall;
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
	Rules: TDictionary<string, TDLL>;
	Props: TDictionary<string, string>;

const
	ResponseCapacity = 256;

(*zLog event handlers*)
procedure zyloRuntimeLaunch;
procedure zyloRuntimeFinish;
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
procedure AccessCallBack(f: PAnsiChar); stdcall;
function ButtonCallBack(f: PAnsiChar): integer; stdcall;
function EditorCallBack(f: PAnsiChar): integer; stdcall;

(*C<->Delphi string converters*)
function DtoC(str: string): PAnsiChar;
function CtoD(str: PAnsiChar): string;

function FindUI(Name: string): TComponent;

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

function FindUI(Name: string): TComponent;
begin
	Result := MainForm.FindComponent(Name);
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
procedure AccessCallBack(f: PAnsiChar); stdcall;
var
	v: string;
begin
	v := Request(CtoD(f), main.CurrentQSO);
	SetLength(v, Min(Length(v), ResponseCapacity));
	AnsiStrings.StrCopy(f, DtoC(v));
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

procedure zyloRuntimeLaunch;
var
	path: string;
	init: TIniFile;
begin
	ImportMenu := MainForm.MergeFile1;
	ExportMenu := MainForm.Export1;
	ImportDialog := TImportDialog.Create(MainForm);
	ExportDialog := TExportDialog.Create(MainForm);
	path := ChangeFileExt(Application.ExeName, '.ini');
	init := TIniFile.Create(path);
	path := init.ReadString('zylo', 'DLLs', '');
	for path in path.Split([',']) do TDLL.Create(path);
	init.Free;
end;

procedure zyloRuntimeFinish;
var
	dll: TDLL;
begin
	(*do not close Go DLL*)
	for dll in Rules.Values do dll.FinishEvent;
	FreeAndNil(ImportDialog);
	FreeAndNil(ExportDialog);
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
	end else
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

function MustGetProc(hnd: THandle; name: PWideChar): pointer;
begin
	Result := GetProcAddress(hnd, name);
	if Result = nil then
		raise Exception.Create(name + ' not provided');
end;

constructor TDLL.Create(path: string);
var
	hnd: THandle;
begin
	hnd := LoadLibrary(PChar(path));
	if hnd = 0 then Exit;
	AllowInsert := MustGetProc(hnd, 'zylo_allow_insert');
	AllowDelete := MustGetProc(hnd, 'zylo_allow_delete');
	AllowUpdate := MustGetProc(hnd, 'zylo_allow_update');
	AllowDialog := MustGetProc(hnd, 'zylo_allow_dialog');
	AllowAccess := MustGetProc(hnd, 'zylo_allow_access');
	AllowButton := MustGetProc(hnd, 'zylo_allow_button');
	AllowEditor := MustGetProc(hnd, 'zylo_allow_editor');
	QueryFormat := MustGetProc(hnd, 'zylo_query_format');
	QueryCities := MustGetProc(hnd, 'zylo_query_cities');
	LaunchEvent := MustGetProc(hnd, 'zylo_launch_event');
	FinishEvent := MustGetProc(hnd, 'zylo_finish_event');
	ImportEvent := MustGetProc(hnd, 'zylo_import_event');
	ExportEvent := MustGetProc(hnd, 'zylo_export_event');
	AttachEvent := MustGetProc(hnd, 'zylo_attach_event');
	AssignEvent := MustGetProc(hnd, 'zylo_assign_event');
	DetachEvent := MustGetProc(hnd, 'zylo_detach_event');
	OffsetEvent := MustGetProc(hnd, 'zylo_offset_event');
	InsertEvent := MustGetProc(hnd, 'zylo_insert_event');
	DeleteEvent := MustGetProc(hnd, 'zylo_delete_event');
	VerifyEvent := MustGetProc(hnd, 'zylo_verify_event');
	PointsEvent := MustGetProc(hnd, 'zylo_points_event');
	ButtonEvent := MustGetProc(hnd, 'zylo_button_event');
	EditorEvent := MustGetProc(hnd, 'zylo_editor_event');
	LastDLL := Self;
	(*LastDLL must be set here*)
	AllowInsert(@InsertCallBack);
	AllowDelete(@DeleteCallBack);
	AllowUpdate(@UpdateCallBack);
	AllowDialog(@DialogCallBack);
	AllowAccess(@AccessCallBack);
	AllowButton(@ButtonCallBack);
	AllowEditor(@EditorCallBack);
	QueryFormat(@FormatCallBack);
	LaunchEvent;
	LastDLL := nil;
	(*LastDLL must be nil here*)
	Rules.Add(ExtractFileName(path), Self);
end;

initialization
	Rules := TDictionary<string, TDLL>.Create;
	Props := TDictionary<string, string>.Create;

finalization
	Rules.Free;
	Props.Free;

end.
