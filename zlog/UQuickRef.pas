unit UQuickRef;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UzLogGlobal;

type
  TQuickRef = class(TForm)
    Memo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure MemoKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

implementation

uses Main;

{$R *.dfm}

procedure TQuickRef.FormCreate(Sender: TObject);
begin
   dmZlogGlobal.ReadWindowState(Self);

   if FileExists('ZLOGHELP.TXT') then begin
      Memo.Lines.LoadFromFile('ZLOGHELP.TXT');
   end
   else
      Memo.Lines.Clear;
end;

procedure TQuickRef.FormDestroy(Sender: TObject);
begin
   dmZlogGlobal.WriteWindowState(Self);
end;

procedure TQuickRef.MemoKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = Chr($1B) then
      MainForm.LastFocus.SetFocus;
end;

end.
