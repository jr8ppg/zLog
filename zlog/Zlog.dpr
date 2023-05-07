// JCL_DEBUG_EXPERT_GENERATEJDBG ON
// JCL_DEBUG_EXPERT_INSERTJDBG ON
program zLog;

{$R *.dres}

uses
  Forms,
  ActiveX,
  main in 'main.pas' {MainForm},
  UBasicScore in 'UBasicScore.pas' {BasicScore},
  UBasicMulti in 'UBasicMulti.pas' {BasicMulti},
  UALLJAMulti in 'UALLJAMulti.pas' {ALLJAMulti},
  UPartials in 'UPartials.pas' {PartialCheck},
  UEditDialog in 'UEditDialog.pas' {EditDialog},
  UAbout in 'UAbout.pas' {AboutBox},
  URateDialog in 'URateDialog.pas' {RateDialog},
  UOptions in 'UOptions.pas' {formOptions},
  UMenu in 'UMenu.pas' {MenuForm},
  UACAGMulti in 'UACAGMulti.pas' {ACAGMulti},
  USuperCheck2 in 'USuperCheck2.pas' {SuperCheck2},
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
  DialogHook in 'DialogHook.pas',
  UZAnalyze in 'UZAnalyze.pas' {ZAnalyze},
  UzlogConst in 'UzlogConst.pas',
  UzLogQSO in 'UzLogQSO.pas',
  USuperCheck in 'USuperCheck.pas' {SuperCheck},
  UzLogSpc in 'UzLogSpc.pas',
  Progress in 'Progress.pas' {formProgress},
  HelperLib in 'HelperLib.pas',
  UCwMessageEditor in 'UCwMessageEditor.pas',
  UCwMessagePad in 'UCwMessagePad.pas' {CwMessagePad},
  UTextEditor in 'UTextEditor.pas' {TextEditor},
  USelectUserDefinedContest in 'USelectUserDefinedContest.pas' {SelectUserDefinedContest},
  UserDefinedContest in 'UserDefinedContest.pas',
  UVoiceForm in 'UVoiceForm.pas' {VoiceForm},
  UCFGEdit in 'UCFGEdit.pas' {CFGEdit},
  UExceptionDialog in 'UExceptionDialog.pas' {ExceptionDialog},
  UzLogSound in 'UzLogSound.pas',
  MMReg in 'MMReg.pas',
  UzLogExtension in 'UzLogExtension.pas',
  UOperatorEdit in 'UOperatorEdit.pas' {formOperatorEdit},
  UzLogOperatorInfo in 'UzLogOperatorInfo.pas',
  WinKeyer in 'WinKeyer.pas',
  UFunctionKeyPanel in 'UFunctionKeyPanel.pas' {formFunctionKeyPanel},
  UBandPlan in 'UBandPlan.pas',
  UBandPlanEditDialog in 'UBandPlanEditDialog.pas' {BandPlanEditDialog},
  UGraphColorDialog in 'UGraphColorDialog.pas' {GraphColorDialog},
  UTargetEditor in 'UTargetEditor.pas' {TargetEditor},
  URateDialogEx in 'URateDialogEx.pas' {RateDialogEx},
  UQsoTarget in 'UQsoTarget.pas',
  ToneGen in 'ToneGen.pas',
  MSACM in 'MSACM.pas',
  UNRDialog in 'UNRDialog.pas' {NRDialog},
  UQsyInfo in 'UQsyInfo.pas' {formQsyInfo},
  UExportHamlog in 'UExportHamlog.pas' {formExportHamlog},
  UPackageLoader in 'UPackageLoader.pas' {PackageLoader},
  UPluginManager in 'UPluginManager.pas' {MarketForm},
  UQsoEdit in 'UQsoEdit.pas',
  USo2rNeoCp in 'USo2rNeoCp.pas' {formSo2rNeoCp},
  UInformation in 'UInformation.pas' {formInformation},
  UWinKeyerTester in 'UWinKeyerTester.pas' {formWinkeyerTester},
  UStatusEdit in 'UStatusEdit.pas' {formStatusEdit},
  UzLogContest in 'UzLogContest.pas',
  UExportCabrillo in 'UExportCabrillo.pas' {formExportCabrillo},
  USpotterListDlg in 'USpotterListDlg.pas' {formSpotterListDlg},
  UFreqTest in 'UFreqTest.pas' {formFreqTest},
  URigCtrlLib in 'URigCtrlLib.pas',
  URigCtrlIcom in 'URigCtrlIcom.pas',
  URigCtrlKenwood in 'URigCtrlKenwood.pas',
  URigCtrlYaesu in 'URigCtrlYaesu.pas',
  UStartTimeDialog in 'UStartTimeDialog.pas' {StartTimeDialog};

{$R *.RES}

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  CoInitialize(nil); // <-- manually call CoInitialize()
  Application.Initialize;
  Application.Title := 'zLog for Windows';
  Application.CreateForm(TdmZLogGlobal, dmZLogGlobal);
  Application.CreateForm(TdmZLogKeyer, dmZLogKeyer);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TMarketForm, MarketForm);
  Application.ShowMainForm := False;
//  Application.MainFormOnTaskBar := True;

   MainForm.Show();
   Application.Run;
   MainForm.Release();

   CoUnInitialize; // <-- free memory
   dmZlogKeyer.Free();
   dmZlogGlobal.Free();
end.
