program zlog_keyedit;

uses
  Vcl.Forms,
  Main in 'Main.pas' {formMain},
  KeyEditDlg in 'KeyEditDlg.pas' {formKeyEditDlg};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
