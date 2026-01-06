unit UJarlWebUpload2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.Win.Registry,
  Winapi.WebView2, Winapi.ActiveX, Vcl.Edge, System.JSON, UzLogConst;

type
  TformJarlWebUpload2 = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    panelBody: TPanel;
    EdgeBrowser1: TEdgeBrowser;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdgeBrowser1NavigationCompleted(Sender: TCustomEdgeBrowser;
      IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
  private
    { Private êÈåæ }
    FWebUploadContest: TWebUploadContest;
    FUploadURL: string;
    FUploadURLaa: string;
    FLogText: string;
    procedure PasteLogText();
    procedure SetLogText(v: string);
    procedure CheckOn(radio_id: string);
  public
    { Public êÈåæ }
    procedure Navigate(url: string);
    property Contest: TWebUploadContest read FWebUploadContest write FWebUploadContest;
    property LogText: string read FLogText write SetLogText;
  end;

implementation

{$R *.dfm}

procedure TformJarlWebUpload2.FormCreate(Sender: TObject);
begin
   FWebUploadContest := wuAllja;
   FLogText := '';
   FUploadURL := 'https://contest.jarl.org/upload/';
   FUploadURLaa := 'https://contest.jarl.org/upload-aa/';
end;

procedure TformJarlWebUpload2.FormShow(Sender: TObject);
begin
   case FWebUploadContest of
      wuAllja, wu6d, wuFd, wuAcag, wuNyp: Navigate(FUploadURL);
      wuAacw, wuAaph: Navigate(FUploadURLaa);
   end;
end;

procedure TformJarlWebUpload2.EdgeBrowser1NavigationCompleted(
  Sender: TCustomEdgeBrowser; IsSuccess: Boolean;
  WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
begin
   if IsSuccess = False then begin
      Exit;
   end;

   PasteLogText();

   case FWebUploadContest of
      wuAllja: CheckOn('rb_allja');
      wu6d:    CheckOn('rb_6d');
      wuFd:    CheckOn('rb_fd');
      wuAcag:  CheckOn('rb_acag');
      wuAacw:  CheckOn('rb_aacw');
      wuAaph:  CheckOn('rb_aaph');
      wuNyp:   CheckOn('rb_nyp');
   end;
end;

procedure TformJarlWebUpload2.PasteLogText();
var
   js: string;
   json: string;
   o: TJSONString;
begin
   o := TJSONString.Create(FLogText);
   json := o.ToString;
   js := 'document.forms["form"].elements["elogtext"].value = ' + json +';';
   EdgeBrowser1.ExecuteScript(js);
   o.Free();
end;

procedure TformJarlWebUpload2.Navigate(url: string);
begin
   Edit1.Text := url;
   EdgeBrowser1.Navigate(url);
end;

procedure TformJarlWebUpload2.SetLogText(v: string);
begin
   FLogText := v;
end;

procedure TformJarlWebUpload2.CheckOn(radio_id: string);
var
   js: string;
begin
   js := 'var e = document.forms["form"].elements["' + radio_id + '"];' +
         'if (e) { if (e.disabled == false) { e.checked = true; }}';
   EdgeBrowser1.ExecuteScript(js);
end;

end.
