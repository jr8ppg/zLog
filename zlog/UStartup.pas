unit UStartup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TformStartup = class(TForm)
    buttonNewContest: TButton;
    buttonLastContest: TButton;
    panelLastContestName: TPanel;
    panelLastFileName: TPanel;
    GroupBox1: TGroupBox;
    procedure buttonNewContestClick(Sender: TObject);
    procedure buttonLastContestClick(Sender: TObject);
  private
    { Private êÈåæ }
    function GetLastContestName(): string;
    procedure SetLastContestName(v: string);
    function GetLastFileName(): string;
    procedure SetLastFileName(v: string);
  public
    { Public êÈåæ }
    property LastContestName: string read GetLastContestName write SetLastContestName;
    property LastFileName: string read GetLastFileName write SetLastFileName;
  end;

implementation

{$R *.dfm}

procedure TformStartup.buttonLastContestClick(Sender: TObject);
begin
   ModalResult := mrNo;
end;

procedure TformStartup.buttonNewContestClick(Sender: TObject);
begin
   ModalResult := mrYes;
end;

function TformStartup.GetLastContestName(): string;
begin
   Result := panelLastContestName.Caption;
end;

procedure TformStartup.SetLastContestName(v: string);
begin
   panelLastContestName.Caption := v;
end;

function TformStartup.GetLastFileName(): string;
begin
   Result := panelLastFileName.Caption;
end;

procedure TformStartup.SetLastFileName(v: string);
begin
   panelLastFileName.Caption := v;
end;

end.
