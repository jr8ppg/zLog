{*******************************************************************************
 * Amateur Radio Operational Logging Software 'ZyLO' since 2020 June 22
 * License: The MIT License since 2021 October 28 (see LICENSE)
 * Author: Journal of Hamradio Informatics (http://pafelog.net)
*******************************************************************************}
unit UPackageLoader;

interface

uses
	Classes,
	Windows,
	Messages,
	SysUtils,
	Controls,
	Forms,
	Dialogs,
	ComCtrls,
	ExtActns,
	ExtCtrls,
	StdCtrls;

type
	TPackageLoader = class(TForm)
		MsgLabel: TLabel;
		ProgressBar: TProgressBar;
		procedure Progress(Sender: TDownloadURL; Pos, Max: Cardinal; Code: TURLDownloadStatus; Text: String; var Cancel: Boolean);
		procedure Download(caption, url, path: string);
	end;

implementation

{$R *.dfm}

procedure TPackageLoader.Progress(Sender: TDownloadURL; Pos, Max: Cardinal; Code: TURLDownloadStatus; Text: String; var Cancel: Boolean);
begin
	ProgressBar.Position := Pos;
	ProgressBar.Max := Max;
end;

procedure TPackageLoader.Download(caption, url, path: string);
var
	dl: TDownloadURL;
begin
	dl := TDownloadURL.Create(Self);
	dl.OnDownloadProgress := Self.Progress;
	dl.Filename := path;
	dl.URL := url;
	Self.Show;
	Self.MsgLabel.Caption := caption;
	Self.Refresh;
	dl.Execute;
	dl.Destroy;
	Self.Close;
end;

end.
