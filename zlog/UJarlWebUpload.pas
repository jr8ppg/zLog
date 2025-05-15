unit UJarlWebUpload;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.OleCtrls, SHDocVw, MSHTML;

type
  TWebUploadContest = ( wuAllja = 0, wu6d, wuFd, wuAcag, wuAacw, wuAaph );

type
  TformJarlWebUpload = class(TForm)
    WebBrowser1: TWebBrowser;
    Panel1: TPanel;
    Edit1: TEdit;
    panelBody: TPanel;
    procedure FormShow(Sender: TObject);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
    procedure FormCreate(Sender: TObject);
  private
    { Private 宣言 }
    FWebUploadContest: TWebUploadContest;
    FUploadURL: string;
    FUploadURLaa: string;
    FLogText: string;
    procedure PasteLogText();
    procedure SetLogText(v: string);
    procedure CheckOn(radio_name: string; value: string);
  public
    { Public 宣言 }
    procedure Navigate(url: string);
    property Contest: TWebUploadContest read FWebUploadContest write FWebUploadContest;
    property LogText: string read FLogText write SetLogText;
  end;

implementation

{$R *.dfm}

procedure TformJarlWebUpload.FormCreate(Sender: TObject);
begin
   FWebUploadContest := wuAllja;
   FLogText := '';
   FUploadURL := 'https://contest.jarl.org/upload/';
   FUploadURLaa := 'https://contest.jarl.org/upload-aa/';
end;

procedure TformJarlWebUpload.FormShow(Sender: TObject);
begin
   case FWebUploadContest of
      wuAllja, wu6d, wuFd, wuAcag: Navigate(FUploadURL);
      wuAacw, wuAaph: Navigate(FUploadURLaa);
   end;
end;

procedure TformJarlWebUpload.WebBrowser1DocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
begin
   if (URL = FUploadURL) or (URL = FUploadURLaa) then begin
      PasteLogText();

      case FWebUploadContest of
         wuAllja: CheckOn('contest', 'allja');
         wu6d:    CheckOn('contest', '6d');
         wuFd:    CheckOn('contest', 'fd');
         wuAcag:  CheckOn('contest', 'acag');
         wuAacw:  CheckOn('contest', 'aacw');
         wuAaph:  CheckOn('contest', 'aaph');
      end;
   end;

   Edit1.Text := URL;
end;

procedure TformJarlWebUpload.PasteLogText();
var
   doc: IHTMLDocument2;
   ElementDisp: IDispatch;
   Element: IHTMLElement;
   NameVariant, IndexVariant: OleVariant;
begin
   doc := WebBrowser1.Document as IHTMLDocument2;

   // name 属性で要素を取得
   NameVariant := 'elogtext';  // name属性
   IndexVariant := 0;               // 同じnameが複数ある場合のインデックス

   ElementDisp := doc.all.item(NameVariant, IndexVariant);

   if not Assigned(ElementDisp) then begin
      Exit;
   end;

   Element := ElementDisp as IHTMLElement;

   Element.innerText := FLogText;
end;

procedure TformJarlWebUpload.Navigate(url: string);
begin
   Edit1.Text := url;
   WebBrowser1.Navigate(url);
end;

procedure TformJarlWebUpload.SetLogText(v: string);
begin
   FLogText := v;
end;

// ALL JA CheckOn('contest', 'allja');
// 6D     CheckOn('contest', '6d');
// FD     CheckOn('contest', 'fd');
// ACAG   CheckOn('contest', 'acag');
// AACW   CheckOn('contest', 'aacw');
// AAPH   CheckOn('contest', 'aaph');
procedure TformJarlWebUpload.CheckOn(radio_name: string; value: string);
var
   doc: IHTMLDocument2;
   Element: IHTMLElement;
   Inputs: IHTMLElementCollection;
   i: Integer;
begin
   doc := WebBrowser1.Document as IHTMLDocument2;

   Inputs := Doc.all.tags('input') as IHTMLElementCollection;

   for i := 0 to Inputs.length - 1 do begin
      Element := Inputs.item(i, 0) as IHTMLElement;
      if (Element.getAttribute('type', 0) = 'radio') and
         (Element.getAttribute('name', 0) = radio_name) and
         (Element.getAttribute('value', 0) = Value) then begin
         Element.setAttribute('checked', True, 0);
         Break;
      end;
   end;
end;

end.
