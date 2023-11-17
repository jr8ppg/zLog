unit UJarlMemberInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, MSHTML,
  System.Generics.Collections, Vcl.StdCtrls, Vcl.WinXCtrls;

type
  TJarlMemberInfo = class
  private
    FCallsign: string;
    FTransfer: Boolean;
    FJarlMember: Boolean;
    FSource: string;
  public
    constructor Create();
    property Callsign: string read FCallsign write FCallsign;
    property Transfer: Boolean read FTransfer write FTransfer;
    property JarlMember: Boolean read FJarlMember write FJarlMember;
    property Source: string read FSource write FSource;
  end;

  TJarlMemberInfoList = class(TList<TJarlMemberInfo>)
  public
    function ObjectOf(strCallsign: string): TJarlMemberInfo;
  end;

  TformJarlMemberInfo = class(TForm)
    WebBrowser1: TWebBrowser;
    labelTitle: TLabel;
    labelProgress: TLabel;
    ActivityIndicator1: TActivityIndicator;
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
  private
    { Private êÈåæ }
    m_fDocumentComplete: Boolean;
    procedure SetTitle(v: string);
    function GetTitle(): string;
    procedure SetText(v: string);
    function GetText(): string;
    procedure SetIndicatorAnimate(v: Boolean);
    function GetIndicatorAnimate(): Boolean;
  public
    { Public êÈåæ }
    function QueryMemberInfo(list: TJarlMemberInfoList): Integer;
    property Title: string read GetTitle write SetTitle;
    property Text: string read GetText write SetText;
    property IndicatorAnimate: Boolean read GetIndicatorAnimate write SetIndicatorAnimate;
  end;

implementation

{$R *.dfm}

procedure TformJarlMemberInfo.WebBrowser1DocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
begin
   m_fDocumentComplete := True;
end;

function TformJarlMemberInfo.QueryMemberInfo(list: TJarlMemberInfoList): Integer;
var
   Doc3: IHTMLDocument3;
   element: IHTMLElement;
   ele1: IHTMLElement;
   ele2: IHTMLElement;
   i: Integer;
   strCallsign: string;
   O: TJarlMemberInfo;
   strResult: string;
   c: Integer;
begin
   strCallsign := '';

   for i := 0 to list.Count - 1 do begin
       strCallsign := strCallsign + list[i].Callsign + ' ';
   end;
   strCallsign := Trim(strCallsign);

   m_fDocumentComplete := false;
   WebBrowser1.Navigate('https://www.jarl.com/Page/Search/MemberSearch.aspx?Language=Jp');

   while ((WebBrowser1.ReadyState < READYSTATE_COMPLETE) or (WebBrowser1.Busy) or (m_fDocumentComplete = false)) do begin
       Application.ProcessMessages();
   end;

   Doc3 := WebBrowser1.Document as IHTMLDocument3;

   element := Doc3.getElementById('txtCallSign');
   if element = nil then begin
      Result := 0;
      Exit;
   end;
   element.innerText := strCallsign;

   m_fDocumentComplete := false;
   element := Doc3.getElementById('btnSearch');
   (DispHTMLButtonElement(element)).click();

   while ((WebBrowser1.ReadyState < READYSTATE_COMPLETE) or (WebBrowser1.Busy) or (m_fDocumentComplete = false)) do begin
       Application.ProcessMessages();
   end;

   Doc3 := WebBrowser1.Document as IHTMLDocument3;

   c := 0;
   for i := 0 to 19 do begin
       ele1 := Doc3.getElementById('ListView1_lblCallSign_' + IntToStr(i));
       if (ele1 = nil) then begin
         Break;
       end;

       ele2 := Doc3.getElementById('ListView1_lblResult_' + IntToStr(i));

       O := list.ObjectOf(ele1.innerText);
       if (O = nil) then begin
         continue;
       end;

       Inc(c);
       strResult := ele2.innerText;

       if (Pos('Åõ', strResult) > 0) then begin
           O.JarlMember := True;
       end;

       if (Pos('Yes', strResult) > 0) then begin
           O.Transfer := True;
       end;
   end;

   Result := c;
end;

procedure TformJarlMemberInfo.SetTitle(v: string);
begin
   labelTitle.Caption := v;
end;

function TformJarlMemberInfo.GetTitle(): string;
begin
   Result := labelTitle.Caption;
end;

procedure TformJarlMemberInfo.SetText(v: string);
begin
   labelProgress.Caption := v;
end;

function TformJarlMemberInfo.GetText(): string;
begin
   Result := labelProgress.Caption;
end;

procedure TformJarlMemberInfo.SetIndicatorAnimate(v: Boolean);
begin
   ActivityIndicator1.Animate := v;
end;

function TformJarlMemberInfo.GetIndicatorAnimate(): Boolean;
begin
   Result := ActivityIndicator1.Animate;
end;

{ TJarlMemberInfo }

constructor TJarlMemberInfo.Create();
begin
   Inherited;
   FCallsign := '';
   FTransfer := False;
   FJarlMember := False;
   FSource := '';
end;

{ TJarlMemberInfoList }

function TJarlMemberInfoList.ObjectOf(strCallsign: string): TJarlMemberInfo;
var
   i: Integer;
begin
   for i := 0 to Self.Count - 1 do begin
      if Items[i].Callsign = strCallsign then begin
         Result := Items[i];
         Exit;
      end;
   end;

   Result := nil;
end;

end.
