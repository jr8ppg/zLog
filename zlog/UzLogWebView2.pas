unit UzLogWebView2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Winapi.WebView2, Winapi.ActiveX, Vcl.Edge;

type
  TWebView2Checker = class
  private
    FBrowser: TEdgeBrowser;
    FResult: Boolean;
    FError: HRESULT;
    FCompleted: Boolean;
    procedure CreateCompleted(Sender: TCustomEdgeBrowser; AResult: HRESULT);
  public
    constructor Create(AOwner: TComponent);
    function Check(): Boolean;
    property Error: HRESULT read FError;
  end;


implementation

{ TWebView2Checker }

constructor TWebView2Checker.Create(AOwner: TComponent);
begin
   FBrowser := TEdgeBrowser.Create(AOwner);
   FBrowser.Visible := False;
   FBrowser.Parent := TForm(AOwner);
   FBrowser.OnCreateWebViewCompleted := CreateCompleted;
   FCompleted := False;
end;

procedure TWebView2Checker.CreateCompleted(Sender: TCustomEdgeBrowser; AResult: HRESULT);
begin
   FCompleted := True;
   FError := AResult;
   FResult := Succeeded(AResult);
end;

function TWebView2Checker.Check(): Boolean;
begin
  FResult := False;
  FError := E_FAIL;

  FBrowser.CreateWebView();

  // CreateWebViewCompleted Ç™óàÇÈÇ‹Ç≈ë“Ç¬Åiä»à’Åj
  while (FCompleted = False) do
    Application.ProcessMessages;

  Result := FResult;
end;

end.
