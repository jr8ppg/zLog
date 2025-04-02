unit UStartup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TformStartup = class(TForm)
    buttonNewContest: TButton;
    buttonLastContest: TButton;
    procedure buttonNewContestClick(Sender: TObject);
    procedure buttonLastContestClick(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
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

end.
