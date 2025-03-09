unit Progress2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TformProgress2 = class(TForm)
    labelProgress: TLabel;
    labelTitle: TLabel;
    ProgressBar1: TProgressBar;
    buttonAbort: TButton;
    procedure FormCreate(Sender: TObject);
    procedure buttonAbortClick(Sender: TObject);
  private
    { Private êÈåæ }
    FAbort: Boolean;
    procedure SetTitle(v: string);
    function GetTitle(): string;
    procedure SetText(v: string);
    function GetText(): string;
    function GetIsAbort(): Boolean;
  public
    { Public êÈåæ }
    procedure SetRange(min_val, max_val: Integer);
    procedure StepIt();
    property Title: string read GetTitle write SetTitle;
    property Text: string read GetText write SetText;
    property IsAbort: Boolean read GetIsAbort;
  end;

implementation

{$R *.dfm}

procedure TformProgress2.buttonAbortClick(Sender: TObject);
begin
   FAbort := True;
end;

procedure TformProgress2.FormCreate(Sender: TObject);
begin
   FAbort := False;
end;

procedure TformProgress2.SetRange(min_val, max_val: Integer);
begin
   ProgressBar1.Min := min_val;
   ProgressBar1.Max := max_val;
   ProgressBar1.Position := 0;
   FAbort := False;
end;

procedure TformProgress2.StepIt();
begin
   ProgressBar1.StepIt();
end;

procedure TformProgress2.SetTitle(v: string);
begin
   labelTitle.Caption := v;
end;

function TformProgress2.GetTitle(): string;
begin
   Result := labelTitle.Caption;
end;

procedure TformProgress2.SetText(v: string);
begin
   labelProgress.Caption := v;
end;

function TformProgress2.GetText(): string;
begin
   Result := labelProgress.Caption;
end;

function TformProgress2.GetIsAbort(): Boolean;
begin
   Result := FAbort;
end;

end.
