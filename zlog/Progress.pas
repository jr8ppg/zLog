unit Progress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TformProgress = class(TForm)
    labelProgress: TLabel;
    labelTitle: TLabel;
  private
    { Private êÈåæ }
    procedure SetTitle(v: string);
    function GetTitle(): string;
    procedure SetText(v: string);
    function GetText(): string;
  public
    { Public êÈåæ }
    property Title: string read GetTitle write SetTitle;
    property Text: string read GetText write SetText;
  end;

implementation

{$R *.dfm}

procedure TformProgress.SetTitle(v: string);
begin
   labelTitle.Caption := v;
end;

function TformProgress.GetTitle(): string;
begin
   Result := labelTitle.Caption;
end;

procedure TformProgress.SetText(v: string);
begin
   labelProgress.Caption := v;
end;

function TformProgress.GetText(): string;
begin
   Result := labelProgress.Caption;
end;

end.
