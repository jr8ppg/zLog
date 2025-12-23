program zlog_hamlogconv;

uses
  Vcl.Forms,
  UHamlogConv in 'UHamlogConv.pas' {HamlogConverter},
  UzlogConst in 'UzlogConst.pas',
  UzLogGlobal in 'UzLogGlobal.pas' {dmZLogGlobal: TDataModule},
  UOptions in 'UOptions.pas' {Options},
  HelperLib in 'HelperLib.pas',
  UExceptionDialog in 'UExceptionDialog.pas' {ExceptionDialog},
  Hamlog50 in 'Hamlog50.pas',
  UzLogQSO in 'UzLogQSO.pas',
  UzLogAdif in 'UzLogAdif.pas',
  HamlogIf in 'HamlogIf.pas',
  UPowerDialog in 'UPowerDialog.pas' {formPowerDialog};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'zLog TELNET';
  Application.CreateForm(TdmZLogGlobal, dmZLogGlobal);
  Application.CreateForm(THamlogConverter, HamlogConverter);
  Application.Run;
end.
