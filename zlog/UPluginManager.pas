{*******************************************************************************
 * Amateur Radio Operational Logging Software 'ZyLO' since 2020 June 22
 * License: The MIT License since 2021 October 28 (see LICENSE)
 * Author: Journal of Hamradio Informatics (http://pafelog.net)
*******************************************************************************}
unit UPluginManager;

interface

uses
	Classes,
	ComCtrls,
	Controls,
	Dialogs,
	ExtActns,
	ExtCtrls,
	Forms,
	Generics.Collections,
	IOUtils,
	IniFiles,
	IdGlobal,
	IdHash,
	IdHashMessageDigest,
	JSON,
	Messages,
	ShellApi,
	StdCtrls,
	StrUtils,
	SysUtils,
	System.Net.HttpClient,
	System.Net.HttpClientComponent,
	System.Net.URLClient,
	UzLogGlobal,
	UzLogExtension,
	UPackageLoader,
	WinXCtrls,
	Windows;

type
	TMarketItem = class(TObject)
		cls: string;
		key: string;
		tag: string;
		msg: string;
		url: string;
		web: string;
		sum: string;
		use: TList<string>;
		function ref: string;
		function name: string;
		function Exist: boolean;
		function IsCFG: boolean;
		function IsDAT: boolean;
		function IsDLL: boolean;
		function IsPKG: boolean;
		procedure Install;
		procedure Disable;
		procedure Upgrade;
		function IsUpToDate: boolean;
		function CanInstall: boolean;
		function CanDisable: boolean;
		function CanUpgrade: boolean;
		function Dependency: TArray<TMarketItem>;
	end;
	TMarketDict = TDictionary<string, TMarketItem>;
	TMarketTest = reference to function(Item: TMarketItem): boolean;
	TMarketForm = class(TForm)
		NetHTTPClient: TNetHTTPClient;
		NetHTTPRequest: TNetHTTPRequest;
		ListBox: TListBox;
		TagLabel: TLabel;
		MsgLabel: TLinkLabel;
		WebLabel: TLinkLabel;
		Splitter: TSplitter;
		ListPanel: TPanel;
		ShowPanel: TPanel;
		GridPanel: TGridPanel;
		SearchBox: TSearchBox;
		InstallButton: TButton;
		DisableButton: TButton;
		UpgradeButton: TButton;
		procedure FormCreate(Sender: TObject);
		procedure FormShow(Sender: TObject);
		procedure LoadJSON(url: string);
		procedure AddItem(cls, obj: TJsonPair);
		procedure ListBoxClick(Sender: TObject);
		procedure SearchBoxChange(Sender: TObject);
		procedure InstallButtonClick(Sender: TObject);
		procedure DisableButtonClick(Sender: TObject);
		procedure UpgradeButtonClick(Sender: TObject);
		procedure WebLabelLinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
	private
		Progress: TPackageLoader;
	end;

var
	MarketForm: TMarketForm;
	MarketItem: TMarketItem;
	MarketDict: TMarketDict;

const
	URL_MARKET = 'https://zylo.pafelog.net/market.json';
	URL_MANUAL = 'https://zylo.pafelog.net';

procedure BrowseURL(url: string);

function GetItemPathINI: string;
function GetItemListINI: TList<String>;
procedure SetItemPathINI(path: String);
procedure SetItemListINI(list: TList<String>);

implementation

uses main;

{$R *.dfm}

function GetItemPathINI: string;
var
	init: TIniFile;
begin
	init := LoadIniFile;
	Result := init.ReadString(KEY_ZYLO, KEY_PATH, GetCurrentDir);
	init.Free;
end;

function GetItemListINI: TList<String>;
var
	init: TIniFile;
	text: string;
begin
	init := LoadIniFile;
	text := init.ReadString(KEY_ZYLO, KEY_LIST, '');
	Result := TList<String>.Create;
	Result.AddRange(text.Split([',']));
	init.Free;
end;

procedure SetItemPathINI(path: String);
function Confirm: boolean;
var
	text: string;
	icon: TMsgDlgType;
	btns: TMsgDlgButtons;
begin
	icon := mtConfirmation;
	btns := [mbYes, mbCancel];
	text := 'Installed plugins will be disabled. Are you sure?';
	Result := MessageDlg(text, icon, btns, 0, mbCancel) = mrYes;
end;
var
	init: TIniFile;
begin
	if (path <> GetItemPathINI) and Confirm then begin
		init := LoadIniFile;
		init.WriteString(KEY_ZYLO, KEY_PATH, path);
		init.WriteString(KEY_ZYLO, KEY_LIST, '');
		init.Free;
	end;
end;

procedure SetItemListINI(list: TList<String>);
var
	init: TIniFile;
	text: TStringList;
	item: string;
begin
	init := LoadIniFile;
	text := TStringList.Create;
	for item in list do text.Append(item);
	init.WriteString(KEY_ZYLO, KEY_LIST, text.DelimitedText);
	init.Free;
end;

function TMarketItem.ref: string;
function dir: string;
begin
	Result := GetItemPathINI;
	if isCFG then Result := dmZLogGlobal.Settings._cfgdatpath;
	if isDAT then Result := dmZLogGlobal.Settings._cfgdatpath;
end;
begin
	Result := TPath.GetFileName(url);
	if isCFG then Result := TPath.Combine(dir, Result);
	if isDAT then Result := TPath.Combine(dir, Result);
end;

function TMarketItem.name: string;
begin
	Result := Format('%s.%s', [cls, key]);
end;

function TMarketItem.Exist: boolean;
begin
	Result := FileExists(ref);
end;

function TMarketItem.IsCFG: boolean;
begin
	Result := cls = 'cfg';
end;

function TMarketItem.IsDAT: boolean;
begin
	Result := cls = 'dat';
end;

function TMarketItem.IsDLL: boolean;
begin
	Result := cls = 'dll';
end;

function TMarketItem.IsPKG: boolean;
begin
	Result := cls = 'pkg';
end;

procedure TMarketItem.Install;
var
	id: string;
	list: TList<string>;
begin
	list := GetItemListINI;
	list.Add(Self.name);
	SetItemListINI(list);
	for id in Self.use do MarketDict[id].Install;
	if isDLL then UzLogExtension.InstallDLL(ref);
	list.Free;
end;

procedure TMarketItem.Disable;
var
	id: string;
	list: TList<string>;
begin
	list := GetItemListINI;
	list.Remove(Self.name);
	SetItemListINI(list);
	for id in Self.use do MarketDict[id].Disable;
	if isDLL then UzLogExtension.DisableDLL(ref);
	list.Free;
end;

procedure TMarketItem.Upgrade;
procedure Backup(Item: TMarketItem);
var
	suf: string;
begin
	suf := FormatDateTime('"."yymmdd', Now);
	RenameFile(Item.ref, Item.ref + suf);
end;
procedure Update(Item: TMarketItem);
begin
	MarketForm.Progress.Download(Item.name, Item.url, Item.ref);
end;
procedure Verify(Item: TMarketItem);
begin
	if Item.IsUpToDate then Exit;
	raise Exception.Create('checksum');
end;
var
	msg: string;
	Item: TMarketItem;
begin
	for Item in Dependency do begin
		if not Item.IsUpToDate then try
			Backup(Item);
			Update(Item);
			Verify(Item);
		except
			msg := 'download failed: ' + Item.ref;
			MessageDlg(msg, mtWarning, [mbOK], 0);
		end;
	end;
end;

function TMarketItem.IsUpToDate: boolean;
var
	sum: string;
	bin: TBytes;
	md5: TIdHashMessageDigest5;
begin
	if Self.isPKG then Exit(true);
	if not Exist then Exit(false);
	md5 := TIdHashMessageDigest5.Create;
	bin := TFile.ReadAllBytes(Self.ref);
	sum := md5.HashBytesAsHex(TIdBytes(bin));
	Result := AnsiCompareText(Self.sum, sum) = 0;
	md5.Free;
end;

function TMarketItem.CanInstall: boolean;
var
	list: TList<string>;
begin
	list := GetItemListINI;
	Result := not list.Contains(name);
	list.Free;
end;

function TMarketItem.CanDisable: boolean;
begin
	Result := not CanInstall;
end;

function TMarketItem.CanUpgrade: boolean;
function Test(Item: TMarketItem): boolean;
begin
	Result := not Item.IsUpToDate;
end;
var
	Item: TMarketItem;
begin
	if CanInstall then Exit(false);
	for Item in Dependency do if Test(Item) then Exit(true);
end;

function TMarketItem.Dependency: TArray<TMarketItem>;
var
	Item: string;
	list: TList<TMarketItem>;
begin
	list := TList<TMarketItem>.Create;
	for Item in Self.use do list.Add(MarketDict[Item]);
	Result := list.ToArray;
	list.Free;
end;

procedure TMarketForm.FormCreate(Sender: TObject);
begin
	NetHttpRequest.Client := NetHttpClient;
	Progress := TPackageLoader.Create(Self);
end;

procedure TMarketForm.FormShow(Sender: TObject);
begin
	ListBox.Clear;
	LoadJSON(URL_MARKET);
	ListBoxClick(Self);
end;

procedure TMarketForm.LoadJSON(url: string);
var
	txt: string;
	buf: TMemoryStream;
	res: IHTTPResponse;
	all: TJsonValue;
	map: TJsonObject;
	cls, obj: TJsonPair;
begin
	try
		buf := TMemoryStream.Create;
		res := NetHttpRequest.Get(url, buf);
		txt := res.ContentAsString(TEncoding.UTF8);
		all := TJsonObject.ParseJSONValue(txt);
		for cls in (all as TJsonObject) do begin
			map := cls.JsonValue as TJsonObject;
			for obj in map do AddItem(cls, obj);
		end;
	finally
		FreeAndNil(buf);
		FreeAndNil(all);
	end;
end;

procedure TMarketForm.AddItem(cls, obj: TJsonPair);
function Value(obj: TJsonValue; key: string): string;
var
	val: TJsonString;
begin
	val := obj.GetValue<TJsonString>(key, nil);
	if val <> nil then Result := val.Value;
end;
var
	Item: TMarketItem;
	use: TJsonValue;
	arr: TJsonArray;
	def: TJsonArray;
begin
	Item := TMarketItem.Create;
	Item.cls := cls.JsonString.Value;
	Item.key := obj.JsonString.Value;
	Item.use := TList<string>.create;
	Item.tag := Value(obj.JsonValue, 'tag');
	Item.msg := Value(obj.JsonValue, 'msg');
	Item.url := Value(obj.JsonValue, 'url');
	Item.web := Value(obj.JsonValue, 'web');
	Item.sum := Value(obj.JsonValue, 'sum');
	def := TJsonArray.Create;
	arr := obj.JsonValue.GetValue('use', def);
	for use in arr do Item.use.Add(use.Value);
	MarketDict.AddOrSetvalue(Item.name, Item);
	if Item.IsPKG then ListBox.AddItem(Item.tag, Item);
	def.Free;
end;

procedure TMarketForm.ListBoxClick(Sender: TObject);
begin
	InstallButton.Caption := 'Install';
	if ListBox.ItemIndex > -1 then begin
		MarketItem := ListBox.Items.Objects[ListBox.ItemIndex] as TMarketItem;
		TagLabel.Caption := MarketItem.tag;
		MsgLabel.Caption := MarketItem.msg;
		WebLabel.Caption := Format('<a href="%0:s">%0:s</a>', [MarketItem.web]);
		InstallButton.Enabled := MarketItem.CanInstall;
		DisableButton.Enabled := MarketItem.CanDisable;
		UpgradeButton.Enabled := MarketItem.CanUpgrade;
	end else begin
		InstallButton.Enabled := false;
		DisableButton.Enabled := false;
		UpgradeButton.Enabled := false;
	end;
end;

procedure TMarketForm.SearchBoxChange(Sender: TObject);
function Match(Item: TMarketItem): boolean;
begin
	if Item.IsPKG then begin
		Result := SearchBox.Text = '';
		Result := Result or ContainsText(Item.key, SearchBox.Text);
		Result := Result or ContainsText(Item.tag, SearchBox.Text);
		Result := Result or ContainsText(Item.msg, SearchBox.Text);
		Result := Result or ContainsText(Item.web, SearchBox.Text);
		Result := Result or ContainsText(Item.ref, SearchBox.Text);
	end else
		Result := False;
end;
var
	Item: TMarketItem;
begin
	ListBox.Clear;
	for Item in MarketDict.Values do
		if Match(Item) then ListBox.AddItem(Item.tag, Item);
end;

procedure TMarketForm.InstallButtonClick(Sender: TObject);
begin
	InstallButton.Enabled := false;
	DisableButton.Enabled := false;
	UpgradeButton.Enabled := false;
	MarketItem.Upgrade;
	MarketItem.Install;
	ListBoxClick(Self);
end;

procedure TMarketForm.DisableButtonClick(Sender: TObject);
begin
	InstallButton.Enabled := false;
	DisableButton.Enabled := false;
	UpgradeButton.Enabled := false;
	MarketItem.Disable;
	ListBoxClick(self);
end;

procedure TMarketForm.UpgradeButtonClick(Sender: TObject);
begin
	InstallButton.Enabled := false;
	DisableButton.Enabled := false;
	UpgradeButton.Enabled := false;
	MarketItem.Upgrade;
	ListBoxClick(Self);
end;

procedure TMarketForm.WebLabelLinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
begin
	BrowseURL(Link);
end;

procedure BrowseURL(url: string);
var
	action: TBrowseURL;
begin
	action := TBrowseURL.Create(MarketForm);
	action.URL := url;
	action.Execute;
end;

initialization
	MarketDict := TMarketDict.Create;

finalization
	MarketDict.Free;

end.
