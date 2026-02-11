program HamlogLookup;



uses
  Forms,
  Main in 'Main.pas' {formHamlogLookup},
  Progress in 'Progress.pas' {formProgress},
  SelectZlog in 'SelectZlog.pas' {formSelectZLog},
  DialogHook in 'DialogHook.pas',
  UOptions in 'UOptions.pas' {formOptions},
  Hamlog50 in 'Hamlog50.pas',
  HamlogIf in 'HamlogIf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'HAMLOGLookup';
  Application.CreateForm(TformHamlogLookup, formHamlogLookup);
  Application.Run;
end.
