program HamlogLookup;



uses
  Vcl.Forms,
  WinApi.Windows,
  Main in 'Main.pas' {formHamlogLookup},
  Progress in 'Progress.pas' {formProgress},
  SelectZlog in 'SelectZlog.pas' {formSelectZLog},
  DialogHook in 'DialogHook.pas',
  UOptions in 'UOptions.pas' {formOptions},
  Hamlog50 in 'Hamlog50.pas',
  HamlogIf in 'HamlogIf.pas';

{$R *.res}

const
  MutexName = 'zLog_HamlogLookup';

var
  hMutex: THANDLE;

begin
  hMutex := OpenMutex(MUTEX_ALL_ACCESS, False, MutexName);
  if hMutex <> 0 then begin
    CloseHandle(hMutex);
    Exit;
  end;
  hMutex := CreateMutex(nil, False, MutexName);

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'HAMLOGLookup';
  Application.CreateForm(TformHamlogLookup, formHamlogLookup);
  Application.Run;
  ReleaseMutex(hMutex);
end.
