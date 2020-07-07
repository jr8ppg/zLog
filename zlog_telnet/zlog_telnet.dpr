program zlog_telnet;

uses
  Vcl.Forms,
  UClusterClient in 'UClusterClient.pas' {ClusterClient},
  UzlogConst in 'UzlogConst.pas',
  USpotClass in 'USpotClass.pas',
  UzLogGlobal in 'UzLogGlobal.pas' {dmZLogGlobal: TDataModule},
  UOptions in 'UOptions.pas' {Options},
  HelperLib in 'HelperLib.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'zLog TELNET';
  Application.CreateForm(TdmZLogGlobal, dmZLogGlobal);
  Application.CreateForm(TClusterClient, ClusterClient);
  Application.Run;
end.
