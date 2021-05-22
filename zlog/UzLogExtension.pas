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
	Menus,
	IOUtils,
	Controls,
	StdCtrls,
	StrUtils,
	SysUtils,
	UzLogQSO,
	UzLogConst,
	UzLogGlobal,
	UMultipliers,
	RegularExpressions;

type
	TzLogEvent = (evInsertQSO = 0, evUpdateQSO, evDeleteQSO);
	TImportDialog = class(TOpenDialog)
		procedure ImportMenuClicked(Sender: TObject);
	end;
	TExportDialog = class(TSaveDialog)
		procedure ExportMenuClicked(Sender: TObject);
		procedure FilterTypeChanged(Sender: TObject);
	end;
	TEditorBundle = class
		Source: TEdit;
		Origin: TKeyPressEvent;
		procedure Handle(Sender: TObject; var Key: Char);
	end;
	TButtonBundle = class
		Source: TButton;
		Origin: TNotifyEvent;
		procedure Handle(Sender: TObject);
	end;

var
	Fmt: string;
	Enabled: boolean;
	CityList: TCityList;
	ImportMenu: TMenuItem;
	ExportMenu: TMenuItem;
	ImportDialog: TImportDialog;
	ExportDialog: TExportDialog;
	zlaunch: procedure; stdcall;
	zfinish: procedure; stdcall;
	yinsert: procedure(fun: pointer); stdcall;
	ydelete: procedure(fun: pointer); stdcall;
	yupdate: procedure(fun: pointer); stdcall;
	yfilter: procedure(fun: pointer); stdcall;
	ycities: procedure(fun: pointer); stdcall;
	yeditor: procedure(fun: pointer); stdcall;
	ybutton: procedure(fun: pointer); stdcall;
	zimport: procedure(src: PAnsiChar; dst: PAnsiChar); stdcall;
	zexport: procedure(src: PAnsiChar; fmt: PAnsiChar); stdcall;
	zattach: procedure(str: PAnsiChar; cfg: PAnsiChar); stdcall;
	zdetach: procedure; stdcall;
	zinsert: procedure(ptr: pointer); stdcall;
	zdelete: procedure(ptr: pointer); stdcall;
	zverify: procedure(ptr: pointer); stdcall;
	zpoints: function (pts, mul: integer): integer; stdcall;
	zeditor: function (key: integer; name: PAnsiChar): boolean; stdcall;
	zbutton: function (btn: integer; name: PAnsiChar): boolean; stdcall;

(*zLog event handlers*)
procedure zyloRuntimeLaunch;
procedure zyloRuntimeFinish;
procedure zyloContestOpened(contest, cfg: string);
procedure zyloContestClosed;
procedure zyloLogUpdated(event: TzLogEvent; bQSO, aQSO: TQSO);

(*zLog contest rules*)
function zyloRequestTotal(Points, Multi: integer): integer;
function zyloRequestScore(aQSO: TQSO): boolean;
function zyloRequestMulti(aQSO: TQSO; var mul: string): boolean;
function zyloRequestValid(aQSO: TQSO; var val: boolean): boolean;
function zyloRequestTable(Path: String; List: TCityList): boolean;

(*callback functions*)
procedure InsertCallBack(ptr: pointer); stdcall;
procedure DeleteCallBack(ptr: pointer); stdcall;
procedure UpdateCallBack(ptr: pointer); stdcall;
procedure FilterCallBack(f: PAnsiChar); stdcall;
procedure CitiesCallBack(f: PAnsiChar); stdcall;
procedure EditorCallBack(f: PAnsiChar); stdcall;
procedure ButtonCallBack(f: PAnsiChar); stdcall;

function DtoC(str: string): PAnsiChar;
function CtoD(str: PAnsiChar): string;

function FindUI(Name: string): TComponent;

implementation

uses
	main;

function DtoC(str: string): PAnsiChar;
begin
	Result := PAnsiChar(AnsiString(str));
end;

function CtoD(str: PAnsiChar): string;
begin
	Result := UTF8String(str);
end;

function FindUI(Name: string): TComponent;
begin
	Result := MainForm.FindComponent(Name);
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
procedure FilterCallBack(f: PAnsiChar); stdcall;
begin
	ImportDialog.Filter := CtoD(f);
	ExportDialog.Filter := CtoD(f);
	ExportDialog.OnTypeChange := ExportDialog.FilterTypeChanged;
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
procedure EditorCallBack(f: PAnsiChar); stdcall;
var
	Source: TEdit;
	Bundle: TEditorBundle;
begin
	Source := TEdit(FindUI(CtoD(f)));
	if (@zeditor <> nil) and (Source <> nil) then begin
		Bundle := TEditorBundle.Create;
		Bundle.Source := Source;
		Bundle.Origin := Source.OnKeyPress;
		Source.OnKeyPress := Bundle.Handle;
	end;
end;

(*callback function that will be invoked by DLL*)
procedure ButtonCallBack(f: PAnsiChar); stdcall;
var
	Source: TButton;
	Bundle: TButtonBundle;
begin
	Source := TButton(FindUI(CtoD(f)));
	if (@zbutton <> nil) and (Source <> nil) then begin
		Bundle := TButtonBundle.Create;
		Bundle.Source := Source;
		Bundle.Origin := Source.OnClick;
		Source.OnClick := Bundle.Handle;
	end;
end;

procedure zyloRuntimeLaunch;
var
	fil: AnsiString;
	zHandle: THandle;
begin
	ImportMenu := MainForm.MergeFile1;
	ExportMenu := MainForm.Export1;
	ImportDialog := TImportDialog.Create(MainForm);
	ExportDialog := TExportDialog.Create(MainForm);
	ExportDialog.Options := [ofOverwritePrompt];
	zHandle := LoadLibrary(PChar('zylo.dll'));
	zlaunch := GetProcAddress(zHandle, 'zylo_handle_launch');
	zfinish := GetProcAddress(zHandle, 'zylo_handle_finish');
	yinsert := GetProcAddress(zHandle, 'zylo_permit_insert');
	ydelete := GetProcAddress(zHandle, 'zylo_permit_delete');
	yupdate := GetProcAddress(zHandle, 'zylo_permit_update');
	yfilter := GetProcAddress(zHandle, 'zylo_permit_filter');
	ycities := GetProcAddress(zHandle, 'zylo_permit_cities');
	yeditor := GetProcAddress(zHandle, 'zylo_permit_editor');
	ybutton := GetProcAddress(zHandle, 'zylo_permit_button');
	zimport := GetProcAddress(zHandle, 'zylo_handle_import');
	zexport := GetProcAddress(zHandle, 'zylo_handle_export');
	zattach := GetProcAddress(zHandle, 'zylo_handle_attach');
	zdetach := GetProcAddress(zHandle, 'zylo_handle_detach');
	zinsert := GetProcAddress(zHandle, 'zylo_handle_insert');
	zdelete := GetProcAddress(zHandle, 'zylo_handle_delete');
	zverify := GetProcAddress(zHandle, 'zylo_handle_verify');
	zpoints := GetProcAddress(zHandle, 'zylo_handle_points');
	zeditor := GetProcAddress(zHandle, 'zylo_handle_editor');
	zbutton := GetProcAddress(zHandle, 'zylo_handle_button');
	if (@zlaunch <> nil) then zlaunch;
	if (@yinsert <> nil) then yinsert(@InsertCallBack);
	if (@ydelete <> nil) then ydelete(@DeleteCallBack);
	if (@yupdate <> nil) then yupdate(@UpdateCallBack);
	if (@yfilter <> nil) then yfilter(@FilterCallBack);
	if (@yeditor <> nil) then yeditor(@EditorCallBack);
	if (@ybutton <> nil) then ybutton(@ButtonCallBack);
	if (@zimport <> nil) and (@zexport <> nil) then begin
		ImportMenu.OnClick := ImportDialog.ImportMenuClicked;
		ExportMenu.OnClick := ExportDialog.ExportMenuClicked;
	end;
end;

procedure zyloRuntimeFinish;
begin
	(*do not close Go DLL*)
	if @zfinish <> nil then
		zfinish;
end;

procedure zyloContestOpened(contest: string; cfg: string);
var
	idx: integer;
begin
	Enabled := True;
	if @zattach <> nil then
		zattach(DtoC(contest), DtoC(cfg));
	for idx := 1 to Log.TotalQSO do
		zyloLogUpdated(evInsertQSO, nil, Log.QsoList[idx]);
end;

procedure zyloContestClosed;
begin
	Enabled := False;
	if @zdetach <> nil then
		zdetach;
end;

procedure zyloLogUpdated(event: TzLogEvent; bQSO, aQSO: TQSO);
var
	qso: TQSOData;
begin
	if (@zdelete <> nil) and (event <> evInsertQSO) then begin
		qso := bQSO.FileRecord;
		if Enabled then zdelete(@qso);
	end;
	if (@zinsert <> nil) and (event <> evDeleteQSO) then begin
		qso := aQSO.FileRecord;
		if Enabled then zinsert(@qso);
	end;
end;

function zyloRequestTotal(Points, Multi: integer): Integer;
begin
	if @zpoints <> nil then
		Result := zpoints(Points, Multi)
	else
		Result := -1;
end;

(*returns whether the QSO score is calculated by this handler*)
function zyloRequestScore(aQSO: TQSO): boolean;
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
function zyloRequestMulti(aQSO: TQSO; var mul: string): boolean;
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
function zyloRequestValid(aQSO: TQSO; var val: boolean): boolean;
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

(*returns whether the cities list is provided by this handler*)
function zyloRequestTable(Path: string; List: TCityList): boolean;
begin
	UzLogExtension.CityList := List;
	if @ycities <> nil then begin
		ycities(@CitiesCallBack);
		Result := True;
	end else
		Result := False;
	UzLogExtension.CityList := nil;
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

procedure TEditorBundle.Handle(Sender: TObject; var Key: Char);
begin
	if not zeditor(integer(Key), DtoC(Source.Name)) then
		Self.Origin(Sender, Key);
end;

procedure TButtonBundle.Handle(Sender: TObject);
begin
	if not zbutton(Source.Tag, DtoC(Source.Name)) then
		Self.Origin(Sender);
end;

initialization

finalization

end.
