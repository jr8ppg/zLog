unit Progress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TformProgress = class(TForm)
    Label1: TLabel;
    buttonAbort: TButton;
    procedure buttonAbortClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private êÈåæ }
    FAbort: Boolean;
    procedure SetMessageText(v: string);
  public
    { Public êÈåæ }
    function IsAbort(): Boolean;
    property MessageText: string write SetMessageText;
  end;

implementation

{$R *.dfm}

procedure TformProgress.FormCreate(Sender: TObject);
begin
   FAbort := False;
   MessageText := '';
end;

procedure TformProgress.buttonAbortClick(Sender: TObject);
begin
   FAbort := True;
end;

function TformProgress.IsAbort(): Boolean;
begin
   Result := FAbort;
end;

procedure TformProgress.SetMessageText(v: string);
begin
   Label1.Caption := v;
end;

end.
