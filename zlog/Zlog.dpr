program zLog;

uses
  Forms,
  ActiveX,
  main in 'main.pas' {MainForm},
  UBasicScore in 'UBasicScore.pas' {BasicScore},
  UBasicMulti in 'UBasicMulti.pas' {BasicMulti},
  UALLJAMulti in 'UALLJAMulti.pas' {ALLJAMulti},
  UPartials in 'UPartials.pas' {PartialCheck},
  UEditDialog in 'UEditDialog.pas' {EditDialog},
  UALLJAEditDialog in 'UALLJAEditDialog.pas' {ALLJAEditDialog},
  UAbout in 'UAbout.pas' {AboutBox},
  URateDialog in 'URateDialog.pas' {RateDialog},
  UOptions in 'UOptions.pas' {formOptions},
  UMenu in 'UMenu.pas' {MenuForm},
  UACAGMulti in 'UACAGMulti.pas' {ACAGMulti},
  USuperCheck in 'USuperCheck.pas' {SuperCheck},
  UACAGScore in 'UACAGScore.pas' {ACAGScore},
  UzLogCW in 'UzLogCW.pas',
  UALLJAScore in 'UALLJAScore.pas' {ALLJAScore},
  UWWScore in 'UWWScore.pas' {WWScore},
  UWWMulti in 'UWWMulti.pas' {WWMulti},
  UWWZone in 'UWWZone.pas' {WWZone},
  UComm in 'UComm.pas' {CommForm},
  UClusterTelnetSet in 'UClusterTelnetSet.pas' {formClusterTelnetSet},
  UClusterCOMSet in 'UClusterCOMSet.pas' {formClusterCOMSet},
  UJIDXMulti in 'UJIDXMulti.pas' {JIDXMulti},
  UJIDXScore in 'UJIDXScore.pas' {JIDXScore},
  UJIDXScore2 in 'UJIDXScore2.pas' {JIDXScore2},
  UZlinkTelnetSet in 'UZlinkTelnetSet.pas' {formZLinkTelnetSet},
  UWPXMulti in 'UWPXMulti.pas' {WPXMulti},
  UWPXScore in 'UWPXScore.pas' {WPXScore},
  UPediScore in 'UPediScore.pas' {PediScore},
  UCWKeyBoard in 'UCWKeyBoard.pas' {CWKeyBoard},
  UJIDX_DX_Score in 'UJIDX_DX_Score.pas' {JIDX_DX_Score},
  UJIDX_DX_Multi in 'UJIDX_DX_Multi.pas' {JIDX_DX_Multi},
  UChat in 'UChat.pas' {ChatForm},
  UZServerInquiry in 'UZServerInquiry.pas' {ZServerInquiry},
  UZLinkForm in 'UZLinkForm.pas' {ZLinkForm},
  UGeneralScore in 'UGeneralScore.pas' {GeneralScore},
  UGeneralMulti2 in 'UGeneralMulti2.pas' {GeneralMulti2},
  USpotForm in 'USpotForm.pas' {SpotForm},
  UFDMulti in 'UFDMulti.pas' {FDMulti},
  UARRLDXMulti in 'UARRLDXMulti.pas' {ARRLDXMulti},
  UARRLDXScore in 'UARRLDXScore.pas' {ARRLDXScore},
  UARRLWMulti in 'UARRLWMulti.pas' {ARRLWMulti},
  UAPSprintScore in 'UAPSprintScore.pas' {APSprintScore},
  UJA0Score in 'UJA0Score.pas' {JA0Score},
  UJA0Multi in 'UJA0Multi.pas' {JA0Multi},
  UKCJMulti in 'UKCJMulti.pas' {KCJMulti},
  USixDownMulti in 'USixDownMulti.pas' {SixDownMulti},
  USixDownScore in 'USixDownScore.pas' {SixDownScore},
  UIARUMulti in 'UIARUMulti.pas' {IARUMulti},
  UIARUScore in 'UIARUScore.pas' {IARUScore},
  UAllAsianScore in 'UAllAsianScore.pas' {AllAsianScore},
  UAgeDialog in 'UAgeDialog.pas' {AgeDialog},
  UIOTAMulti in 'UIOTAMulti.pas' {IOTAMulti},
  UNewIOTARef in 'UNewIOTARef.pas' {NewIOTARef},
  UIOTACategory in 'UIOTACategory.pas' {IOTACategory},
  UUTCDialog in 'UUTCDialog.pas' {UTCDialog},
  UARRL10Multi in 'UARRL10Multi.pas' {ARRL10Multi},
  UARRL10Score in 'UARRL10Score.pas' {ARRL10Score},
  USummaryInfo in 'USummaryInfo.pas' {SummaryInfo},
  URigControl in 'URigControl.pas' {RigControl},
  UConsolePad in 'UConsolePad.pas' {ConsolePad},
  UFreqList in 'UFreqList.pas' {FreqList},
  UCheckWin in 'UCheckWin.pas' {CheckWin},
  UCheckCall2 in 'UCheckCall2.pas' {CheckCall2},
  UCheckMulti in 'UCheckMulti.pas' {CheckMulti},
  UCheckCountry in 'UCheckCountry.pas' {CheckCountry},
  USpotClass in 'USpotClass.pas',
  UIntegerDialog in 'UIntegerDialog.pas' {IntegerDialog},
  URenewThread in 'URenewThread.pas',
  UNewPrefix in 'UNewPrefix.pas' {NewPrefix},
  UKCJZone in 'UKCJZone.pas' {KCJZone},
  UMultipliers in 'UMultipliers.pas',
  UScratchSheet in 'UScratchSheet.pas' {ScratchSheet},
  UKCJScore in 'UKCJScore.pas' {KCJScore},
  UMMTTY in 'UMMTTY.pas',
  UTTYConsole in 'UTTYConsole.pas' {TTYConsole},
  UQTCForm in 'UQTCForm.pas' {QTCForm},
  UWAEScore in 'UWAEScore.pas' {WAEScore},
  UWAEMulti in 'UWAEMulti.pas' {WAEMulti},
  UQuickRef in 'UQuickRef.pas' {QuickRef},
  UBandScope2 in 'UBandScope2.pas' {BandScope2},
  OmniRig_TLB in 'OmniRig\OmniRig_TLB.pas',
  UzLogGlobal in 'UzLogGlobal.pas' {dmZLogGlobal: TDataModule},
  UELogJarl1 in 'UELogJarl1.pas' {formELogJarl1},
  UELogJarl2 in 'UELogJarl2.pas' {formELogJarl2},
  UzLogKeyer in 'UzLogKeyer.pas' {dmZLogKeyer: TDataModule},
  DialogHook in 'DialogHook.pas';

{$R *.RES}

begin
  CoInitialize(nil); // <-- manually call CoInitialize()
  Application.Initialize;
  Application.Title := 'zLog for Windows';
  Application.CreateForm(TdmZLogGlobal, dmZLogGlobal);
  Application.CreateForm(TdmZLogKeyer, dmZLogKeyer);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TRigControl, RigControl);
  Application.CreateForm(TPartialCheck, PartialCheck);
  Application.CreateForm(TRateDialog, RateDialog);
  Application.CreateForm(TSuperCheck, SuperCheck);
  Application.CreateForm(TCommForm, CommForm);
  Application.CreateForm(TCWKeyBoard, CWKeyBoard);
  Application.CreateForm(TChatForm, ChatForm);
  Application.CreateForm(TZServerInquiry, ZServerInquiry);
  Application.CreateForm(TZLinkForm, ZLinkForm);
  Application.CreateForm(TSpotForm, SpotForm);
  Application.CreateForm(TConsolePad, ConsolePad);
  Application.CreateForm(TFreqList, FreqList);
  Application.CreateForm(TCheckCall2, CheckCall2);
  Application.CreateForm(TCheckMulti, CheckMulti);
  Application.CreateForm(TCheckCountry, CheckCountry);
  Application.CreateForm(TScratchSheet, ScratchSheet);
  Application.CreateForm(TBandScope2, BandScope2);
  Application.ShowMainForm := False;
//  Application.MainFormOnTaskBar := True;

   MainForm.Show();
   Application.Run;

   CoUnInitialize; // <-- free memory
   dmZlogKeyer.Free();
   dmZlogGlobal.Free();
end.
