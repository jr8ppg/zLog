unit UzLogExtension;

interface

uses
	Classes,
	Dialogs,
	Windows,
	Math,
	Rtti,
	Forms,
	Menus,
	TypInfo,
	IOUtils,
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
	Generics.Collections,
	Bindings.Expression,
	Bindings.ExpressionDefaults,
   System.UITypes;

type
	/// <summary>
	/// QSO event type
	/// </summary>
	TzLogEvent = (evInsertQSO = 0, evUpdateQSO, evDeleteQSO);

	/// <summary>
	/// DLL function that accepts callback function
	/// </summary>
	TAllowProc = procedure(fun: pointer); stdcall;

	/// <summary>
	/// TDLL is an instance of a plugin DLL implementing ZyLO.
	/// will be installed dynamically by invoking constructor.
	/// </summary>
	TDLL = class
		QueryFormat: procedure(fun: pointer); stdcall;
		QueryCities: procedure(fun: pointer); stdcall;
		LaunchEvent: function: boolean; stdcall;
		FinishEvent: function: boolean; stdcall;
		WindowEvent: procedure(msg: pointer); stdcall;
		ImportEvent: function (path, target: PAnsiChar): boolean; stdcall;
		ExportEvent: function (path, format: PAnsiChar): boolean; stdcall;
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
		procedure ContestOpened;
	private
		hnd: THandle;
	end;

	/// <summary>
	/// event handler of button components.
	/// </summary>
	TButtonBridge = class
		Source: TComponent;
		Target: TDLL;
		Number: integer;
		Parent: TNotifyEvent;
		procedure Handle(Sender: TObject);
	end;

	/// <summary>
	/// event handler of editor components.
	/// </summary>
	TEditorBridge = class
		Source: TEdit;
		Target: TDLL;
		Number: integer;
		Parent: TKeyPressEvent;
		procedure Handle(Sender: TObject; var Key: char);
	end;

	/// <summary>
	/// predefined functions for scripting.
	/// </summary>
	TScriptOp = class
		function Int(num: extended): integer;
		function Put(obj: TObject; key: string; val: variant): TObject;
	end;

var
	LastDLL: TDLL;
	FileDLL: TDLL;
	RuleDLL: TDLL;
	RuleName: string;
	RulePath: string;
	Enabled: boolean;
	CityList: TCityList;
	handlerNum: integer;
	NumExports: integer;
	ImportDialog: TOpenDialog;
	ExportDialog: TSaveDialog;
	Toasts: TNotificationCenter;
	Rules: TDictionary<string, TDLL>;
	ScriptOp: TScriptOp;

const
	ResponseCapacity = 256;
	KEY_LIST = 'items';
	KEY_DLLS = 'DLLs';
	KEY_PATH = 'path';
	KEY_ZYLO = 'zylo';

function LoadIniFile: TIniFile;
procedure InstallDLL(path: string);
procedure DisableDLL(path: string);
function CanInstallDLL(path: string): boolean;
function CanDisableDLL(path: string): boolean;

procedure zyloRuntimeLaunch;
procedure zyloRuntimeFinish;
procedure zyloWindowMessage(var msg: TMsg);
procedure zyloContestSwitch(test, path: string);
procedure zyloContestOpened(test, path: string);
procedure zyloContestClosed;
function  zyloImportFile(FileName: string): integer;
function  zyloExportFile(FileName: string): boolean;
procedure zyloLogUpdated(event: TzLogEvent; bQSO, aQSO: TQSO);

function zyloRequestTotal(Points, Multi: integer): integer;
function zyloRequestScore(aQSO: TQSO): boolean;
function zyloRequestMulti(aQSO: TQSO; var mul: string): boolean;
function zyloRequestValid(aQSO: TQSO; var val: boolean): boolean;
function zyloRequestTable(Path: string; List: TCityList): boolean;

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
function ScriptCallBack(f: PAnsiChar): integer; stdcall;

function DtoC(str: string): PAnsiChar;
function CtoD(str: PAnsiChar): string;

function RunScript(exp: string): TValue;
function GetUI(name: string): TComponent;

function Version: string;
function Request(v: string; qso: TQSO): string;

implementation

uses
	main,
	UPluginManager;

/// <summary>
/// convert short string to ANSI string
/// </summary>
///
/// <param name="str">
/// short string
/// </param>
///
/// <returns>
/// ANSI string
/// </returns>
function DtoC(str: string): PAnsiChar;
begin
	Result := PAnsiChar(AnsiString(str));
end;

/// <summary>
/// convert ANSI string to short string
/// </summary>
///
/// <param name="str">
/// ANSI string
/// </param>
///
/// <returns>
/// short string
/// </returns>
function CtoD(str: PAnsiChar): string;
begin
	Result := string(UTF8String(str));
end;

/// <summary>
/// evaluate expression
/// </summary>
///
/// <param name="src">
/// expression
/// </param>
///
/// <returns>
/// value of expression
/// </returns>
function RunScript(exp: string): TValue;
var
	binds: TList<TBindingAssociation>;
	engine: TBindingExpressionDefault;
procedure Bind(key: string; val: TObject);
begin
	if key <> '' then
		binds.Add(TBindingAssociation.Create(val, key));
end;
procedure BindComponents(comp: TComponent);
begin
	Bind(comp.Name, comp);
	for var child in comp do
		Bind(child.Name, child);
end;
begin
	binds := TList<TBindingAssociation>.Create;
	engine := TBindingExpressionDefault.Create;
	try
		engine.Source := exp;
		Bind('op', ScriptOp);
		BindComponents(MainForm);
		engine.Compile(binds.toArray);
		Result := engine.Evaluate.GetValue;
	finally
		engine.Free;
	end;
end;

/// <summary>
/// find UI component under Application
/// </summary>
///
/// <param name="name">
/// component name
/// </param>
///
/// <returns>
/// component found
/// </returns>
function GetUI(name: string): TComponent;
begin
	Result := Application;
	for name in SplitString(name, '.') do
		Result := Result.FindComponent(name);
end;

/// <summary>
/// return zLog version
/// </summary>
///
/// <returns>
/// version
/// </returns>
function Version: string;
begin
	var info := TJclFileVersionInfo.Create(MainForm.Handle);
	Result := info.FileVersion;
	info.Free;
end;

/// <summary>
/// format string with placeholders
/// </summary>
///
/// <param name="v">
/// string with placeholders such as '$M'
/// </param>
///
/// <param name="qso">
/// current QSO
/// </param>
///
/// <returns>
/// generated string
/// </returns>
function Request(v: string; qso: TQSO): string;
var
	key: string;
	Props: TDictionary<string, string>;
begin
	Props := TDictionary<string, string>.Create;
	Props.AddOrSetValue('{V}', Version);
	Props.AddOrSetValue('{F}', CurrentFileName);
	Props.AddOrSetValue('{C}', UpperCase(dmZLogGlobal.MyCall));
	Props.AddOrSetValue('{B}', qso.BandStr);
	Props.AddOrSetValue('{M}', qso.ModeStr);
	if MyContest <> nil then v := UzLogCW.SetStrNoAbbrev(v, qso);
	for key in Props.Keys do v := ReplaceStr(v, key, Props[key]);
	Result := v;
	Props.Free;
end;

/// <summary>
/// callback function that allows DLLs to insert a QSO.
/// </summary>
///
/// <param name="ptr">
/// pointer to QSO record
/// </param>
procedure InsertCallBack(ptr: pointer); stdcall;
begin
	var qso := TQSO.Create;
	qso.FileRecord := TQSOData(ptr^);
	MyContest.LogQSO(qso, True);
end;

/// <summary>
/// callback function that allows DLLs to delete a QSO.
/// </summary>
///
/// <param name="ptr">
/// pointer to QSO record
/// </param>
procedure DeleteCallBack(ptr: pointer); stdcall;
begin
	var qso := TQSO.Create;
	qso.FileRecord := TQSOData(ptr^);
	Log.DeleteQSO(qso);
	MyContest.Renew;
	qso.Free;
end;

/// <summary>
/// callback function that allows DLLs to update a QSO.
/// </summary>
///
/// <param name="ptr">
/// pointer to QSO record
/// </param>
procedure UpdateCallBack(ptr: pointer); stdcall;
begin
	var qso := TQSO.Create;
	qso.FileRecord := TQSOData(ptr^);
	qso.Reserve := actEdit;
	Log.AddQue(qso);
	Log.ProcessQue;
	MyContest.Renew;
	qso.Free;
end;

/// callback function that allows DLLs to add file-format filters
procedure FormatCallBack(f: PAnsiChar); stdcall;
begin
	if CtoD(f) = '' then Exit;
	NumExports := Length(SplitString(ExportDialog.Filter, '|')) div 2;
	ImportDialog.Filter := ImportDialog.Filter + '|' + CtoD(f);
	ExportDialog.Filter := ExportDialog.Filter + '|' + CtoD(f);
	FileDLL := LastDLL;
end;

/// <summary>
/// callback function that allows DLLs to provide DAT dynamically
/// </summary>
///
/// <param name="f">
/// ANSI string that contains DAT-file contents
/// </param>
procedure CitiesCallBack(f: PAnsiChar); stdcall;
var
	city: TCity;
	line: string;
	list: TStringList;
	vals: TArray<string>;
begin
	list := TStringList.Create;
   try
      list.Text := AdjustLineBreaks(CtoD(f), tlbsLF);
      for line in list do begin
         vals := TRegEx.Split(line, '\s+');
         if Length(vals) <> 2 then begin
            Continue;
         end;
         city := TCity.Create;
         city.CityNumber := vals[0];
         city.CityName := vals[1];
         city.Index := CityList.List.Count;
         CityList.List.Add(city);
         CityList.SortedMultiList.AddObject(city.CityNumber, city);
      end;
   finally
   	list.Free;
   end;
end;

/// <summary>
/// callback function that allows DLLs to display modal message
/// </summary>
///
/// <param name="f">
/// message to be displayed
/// </param>
procedure DialogCallBack(f: PAnsiChar); stdcall;
begin
	MessageDlg(CtoD(f), mtInformation, [mbOK], 0);
end;

/// <summary>
/// callback function that allows DLLs to display toast message
/// </summary>
///
/// <param name="f">
/// message to be displayed
/// </param>
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

/// <summary>
/// callback function that allows DLLs to obtain formatted string
/// </summary>
///
/// <param name="f">
/// string with placeholders
/// </param>
procedure AccessCallBack(f: PAnsiChar); stdcall;
begin
	var v := Request(CtoD(f), main.CurrentQSO);
	SetLength(v, Min(Length(v), ResponseCapacity));
	AnsiStrings.StrCopy(f, DtoC(v));
end;

/// <summary>
/// callback function that allows DLLs to obtain component handle
/// </summary>
///
/// <param name="f">
/// component name
/// </param>
///
/// <returns>
/// handle
/// </returns>
function HandleCallBack(f: PAnsiChar): THandle; stdcall;
begin
	var comp := GetUI(CtoD(f));
	if comp is TMenu then
		Result := TMenu(comp).Handle
	else if comp is TMenuItem then
		Result := TMenuItem(comp).Handle
	else if comp is TWinControl then
		Result := TWinControl(comp).Handle
	else
		Result := 0;
end;

/// <summary>
/// callback function that allows DLLs to handle button events
/// </summary>
///
/// <param name="f">
/// component name
/// </param>
///
/// <returns>
/// event-handler ID
/// </returns>
function ButtonCallBack(f: PAnsiChar): integer; stdcall;
var
	Source: TComponent;
	Bridge: TButtonBridge;
begin
	Inc(handlerNum);
	Result := handlerNum;
	Source := TComponent(GetUI(CtoD(f)));
	if (Source <> nil) and (LastDLL <> nil) then begin
		Bridge := TButtonBridge.Create;
		Bridge.Source := Source;
		Bridge.Target := LastDLL;
		Bridge.Number := Result;
		if Source is TButton then begin
			var comp := TButton(Source);
			Bridge.Parent := comp.OnClick;
			comp.OnClick := Bridge.Handle;
		end else if Source is TMenuItem then begin
			var comp := TMenuItem(Source);
			Bridge.Parent := comp.OnClick;
			comp.OnClick := Bridge.Handle;
		end;
	end;
end;

/// <summary>
/// callback function that allows DLLs to handle typing events
/// </summary>
///
/// <param name="f">
/// component name
/// </param>
///
/// <returns>
/// event-handler ID
/// </returns>
function EditorCallBack(f: PAnsiChar): integer; stdcall;
var
	Source: TEdit;
	Bridge: TEditorBridge;
begin
	Inc(handlerNum);
	Result := handlerNum;
	Source := TEdit(GetUI(CtoD(f)));
	if (Source <> nil) and (LastDLL <> nil) then begin
		Bridge := TEditorBridge.Create;
		Bridge.Source := Source;
		Bridge.Target := LastDLL;
		Bridge.Number := Result;
		Bridge.Parent := Source.OnKeyPress;
		Source.OnKeyPress := Bridge.Handle;
	end;
end;

/// <summary>
/// callback function that allows DLLs to evaluate expressions
/// </summary>
///
/// <param name="f">
/// expressions separated by line breaks
/// </param>
///
/// <returns>
/// 1 for success,
/// 0 for failure,
/// or the value of an integer expression
/// <returns>
function ScriptCallBack(f: PAnsiChar): integer; stdcall;
begin
	try
		var value := RunScript(CtoD(f));
		if value.IsOrdinal then
			Result := value.AsInteger
		else
			Result := 1;
	except
		on e: Exception do begin
			TaskMessageDlg(e.Message, CtoD(f), mtError, [mbOk], 0);
			Result := 0;
		end;
	end;
end;

/// <summary>
/// load zLog.ini
/// </summary>
///
/// <returns>
/// reference to zLog.ini
/// </returns>
function LoadIniFile: TIniFile;
begin
	Result := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
end;

/// <summary>
/// return list of installed DLLs
/// </summary>
///
/// <returns>
/// list of DLL paths
/// </returns>
function GetDLLsINI: TList<string>;
begin
	var text := dmZLogGlobal.Settings._pluginDLLs;
	Result := TList<string>.Create;
	Result.AddRange(text.Split([',']));

   for var i := 0 to Result.Count - 1 do begin
      Result[i] := ExtractFileName(Result[i]);
   end;
end;

/// <summary>
/// set list of installed DLLs
/// </summary>
///
/// <param name="list">
/// list of DLL paths
/// </param>
procedure SetDLLsINI(list: TList<string>);
begin
	var text := TStringList.Create;
	for var item in list do text.Append(item);

   dmZLogGlobal.Settings._pluginDLLs := text.DelimitedText;

	text.Free;
end;

/// <summary>
/// install a DLL from the specified path
/// </summary>
///
/// <param name="path">
/// path to DLL
/// </param>
procedure InstallDLL(path: string);
begin
	MainForm.actionBackupExecute(MainForm);
   var filename := ExtractFileName(path);
	var list := GetDLLsINI;
	if not list.Contains(filename) then begin
		list.Add(filename);
		SetDLLsINI(list);
	end;
	if not Rules.ContainsKey(path) then TDLL.Create(path).ContestOpened;
	list.Free;
end;

/// <summary>
/// disable a DLL in the specified path
/// </summary>
///
/// <param name="path">
/// path to DLL
/// </param>
procedure DisableDLL(path: string);
begin
	var list := GetDLLsINI;
   var filename := ExtractFileName(path);
	list.Remove(filename);
	SetDLLsINI(list);
	list.Free;
end;

/// <summary>
/// test if the specified DLL can be installed
/// </summary>
///
/// <param name="path">
/// path to DLL
/// </param>
function CanInstallDLL(path: string): boolean;
begin
	Result := not CanDisableDLL(path);
end;

/// <summary>
/// test if the specified DLL can be disabled
/// </summary>
///
/// <param name="path">
/// path to DLL
/// </param>
function CanDisableDLL(path: string): boolean;
begin
	var list := GetDLLsINI;
   var filename := ExtractFileName(path);
	Result := list.Contains(filename);
	list.Free;
end;

/// <summary>
/// must be called after zLog is launched
/// </summary>
procedure zyloRuntimeLaunch;
var
	list: TList<string>;
	path: string;
   filename: string;
begin
	ImportDialog := MainForm.FileImportDialog;
	ExportDialog := MainForm.FileExportDialog;
	Toasts := TNotificationCenter.Create(MainForm);
	list := GetDLLsINI;
 	for filename in list do begin
      path := TPath.Combine(dmZLogGlobal.PluginPath, filename);
      TDLL.Create(path);
   end;
	list.Free;
end;

/// <summary>
/// must be called before zLog is terminated
/// </summary>
procedure zyloRuntimeFinish;
begin
	/// do not close Go DLL
	for var dll in Rules.Values do
		if dll.FinishEvent then
			FreeLibrary(dll.hnd);
end;

/// <summary>
/// forward window message to DLLs
/// </summary>
///
/// <param name="msg">
/// window message
/// </param>
procedure zyloWindowMessage(var msg: TMsg);
begin
	for var dll in Rules.Values do dll.WindowEvent(@msg);
end;

/// <summary>
/// must be called before contest opened
/// </summary>
///
/// <param name="test">
/// contest name
/// </param>
///
/// <param name="path">
/// path to CFG file
/// </param>
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
	end else if link <> '' then begin
		UPluginManager.MarketForm.Browse(link);
		TaskMessageDlg('not installed', link, mtWarning, [mbOK], 0);
	end;
	list.Free;
end;

/// <summary>
/// must be called after contest opened
/// </summary>
///
/// <param name="test">
/// contest name
/// </param>
///
/// <param name="path">
/// path to CFG file
/// </param>
procedure zyloContestOpened(test, path: string);
begin
	Enabled := True;
	var tag := DtoC(RuleName);
	var cfg := DtoC(RulePath);
	for var dll in Rules.Values do dll.ContestOpened;
	if RuleDLL <> nil then RuleDLL.AssignEvent(tag, cfg);
	MyContest.ScoreForm.UpdateData;
	MyContest.MultiForm.UpdateData;
end;

/// <summary>
/// must be called when contest closed
/// </summary>
procedure zyloContestClosed;
begin
	Enabled := False;
	var tag := DtoC(RuleName);
	var cfg := DtoC(RulePath);
	for var dll in Rules.Values do dll.DetachEvent(tag, cfg);
	RuleDLL := nil;
end;

/// <summary>
/// try to import QSOs from the specified file
/// </summary>
///
/// <param name="FileName">
/// path to the file
/// </param>
///
/// <returns>
/// number of imported QSOs
/// <returns>
function zyloImportFile(FileName: string): integer;
var
	tmp: string;
begin
   Result := 0;
	if FileDLL <> nil then try
		tmp := TPath.GetTempFileName;
		if FileDLL.ImportEvent(DtoC(FileName), DtoC(tmp)) then
			Result := Log.QsoList.MergeFile(tmp, True)
		else begin
			TaskMessageDlg('not supported', FileName, mtWarning, [mbOK], 0);
		end;
	finally
		TFile.Delete(tmp);
	end;
end;

/// <summary>
/// try to export QSOs into the specified file
/// </summary>
///
/// <param name="FileName">
/// path to the file
/// </param>
///
/// <returns>
/// true if QSOs are exported successfully
/// <returns>
function zyloExportFile(FileName: string): boolean;
var
	fmt: string;
	fil: string;
	idx: integer;
begin
	fil := ExportDialog.Filter;
	idx := ExportDialog.FilterIndex;
	if (FileDLL <> nil) and (idx > NumExports) then begin
		fmt := SplitString(fil, '|')[2 * idx - 2];
		Log.SaveToFile(FileName);
		FileDLL.ExportEvent(DtoC(FileName), DtoC(fmt));
		Result := True;
	end else Result := False;
end;

/// <summary>
/// must be called when the QSO list is modified
/// </summary>
///
/// <param name="event">
/// event type
/// </param>
///
/// <param name="bQSO">
/// deleted QSO
/// <param>
///
/// <param name="aQSO">
/// inserted QSO
/// <param>
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

/// <summary>
/// calculate total score
/// </summary>
///
/// <param name="Points">
/// QSO points
/// </param>
///
/// <param name="Multi">
/// number of multipliers
/// </param>
function zyloRequestTotal(Points, Multi: integer): integer;
begin
	if RuleDLL <> nil then
		Result := RuleDLL.PointsEvent(Points, Multi)
	else
		Result := -1;
end;

/// <summary>
/// calculate QSO score by DLL
/// </summary>
///
/// <param name="aQSO">
/// QSO
/// </param>
///
/// <returns>
/// true if handled by DLL
/// </returns>
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

/// <summary>
/// extract multiplier from the QSO
/// </summary>
///
/// <param name="aQSO">
/// QSO
/// </param>
///
/// <returns>
/// true if handled by DLL
/// </returns>
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

/// <summary>
/// test if the QSO is valid or not
/// </summary>
///
/// <param name="aQSO">
/// QSO
/// </param>
///
/// <param name="val">
/// true if valid
/// </param>
///
/// <returns>
/// true if handled by DLL
/// </returns>
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

/// <summary>
/// request DAT-file contents
/// </summary>
///
/// <param name="Path">
/// path to DAT file (not used)
/// </param>
///
/// <param name="List">
/// target list
/// </param>
///
/// <returns>
/// true if handled by DLL
/// </returns>
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

procedure TButtonBridge.Handle(Sender: TObject);
begin
	Target.ButtonEvent(Number, Number);
	if @Parent <> nil then Parent(Sender);
end;

procedure TEditorBridge.Handle(Sender: TObject; var Key: char);
begin
	Target.EditorEvent(Number, integer(key));
	if @Parent <> nil then Parent(Sender, key);
end;

function TScriptOp.Int(num: extended): integer;
begin
	Result := Trunc(num);
end;

function TScriptOp.Put(obj: TObject; key: string; val: variant): TObject;
begin
	TypInfo.SetPropValue(obj, key, val);
	Result := obj;
end;

constructor TDLL.Create(path: string);
procedure NotifyMismatch;
begin
	TaskMessageDlg('zLog is too old', path, mtWarning, [mbOK], 0);
	raise Exception.Create(Format('zLog is too old: %s', [path]));
end;
procedure Allow(name: PWideChar; cb: pointer);
begin
	var p := GetProcAddress(hnd, name);
	if p <> nil then TAllowProc(p)(cb);
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
	try
		// provided regardless of how old the DLL is.
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
		LastDLL := Self;
		// LastDLL must be set here
		// DLL may accept the following callbacks
		Allow('zylo_allow_insert', @InsertCallBack);
		Allow('zylo_allow_delete', @DeleteCallBack);
		Allow('zylo_allow_update', @UpdateCallBack);
		Allow('zylo_allow_dialog', @DialogCallBack);
		Allow('zylo_allow_notify', @NotifyCallBack);
		Allow('zylo_allow_access', @AccessCallBack);
		Allow('zylo_allow_handle', @HandleCallBack);
		Allow('zylo_allow_button', @ButtonCallBack);
		Allow('zylo_allow_editor', @EditorCallBack);
		Allow('zylo_allow_script', @ScriptCallBack);
		Allow('zylo_query_format', @FormatCallBack);
		if not LaunchEvent then NotifyMismatch;
		Rules.Add(ExtractFileName(path), Self);
		MainForm.PluginMenu.Visible := True;
	except
		LastDLL := nil;
	end;
end;

procedure TDLL.ContestOpened;
begin
	var tag := DtoC(RuleName);
	var cfg := DtoC(RulePath);
	Self.OffsetEvent(UTCOffset);
	Self.AttachEvent(tag, cfg);
end;

procedure FreeRules;
var
	Rule: TDLL;
begin
	for Rule in Rules.Values do Rule.Free;
end;

initialization
	Rules := TDictionary<string, TDLL>.Create;
	ScriptOp := TScriptOp.Create;

finalization
	FreeRules;
	Rules.Free;
	ScriptOp.Free;

end.
