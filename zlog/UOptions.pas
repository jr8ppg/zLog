unit UOptions;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls, Spin, Vcl.Buttons, System.UITypes,
  Dialogs, Menus, FileCtrl,
  UIntegerDialog, UzLogConst, UzLogGlobal;

type
  TformOptions = class(TForm)
    PageControl: TPageControl;
    tabsheetPreferences: TTabSheet;
    tabsheetCategories: TTabSheet;
    tabsheetCW: TTabSheet;
    tabsheetVoice: TTabSheet;
    tabsheetHardware: TTabSheet;
    tabsheetRigControl: TTabSheet;
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    GroupBox1: TGroupBox;
    SingleOpRadioBtn: TRadioButton;
    MultiOpRadioBtn: TRadioButton;
    BandGroup: TRadioGroup;
    OpListBox: TListBox;
    ModeGroup: TRadioGroup;
    OpEdit: TEdit;
    Add: TButton;
    Delete: TButton;
    GroupBox2: TGroupBox;
    editMessage2: TEdit;
    editMessage3: TEdit;
    editMessage4: TEdit;
    editMessage5: TEdit;
    editMessage6: TEdit;
    editMessage7: TEdit;
    editMessage11: TEdit;
    editMessage8: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    editMessage12: TEdit;
    editMessage1: TEdit;
    SpeedBar: TTrackBar;
    Label11: TLabel;
    SpeedLabel: TLabel;
    Label13: TLabel;
    WeightBar: TTrackBar;
    WeightLabel: TLabel;
    CQmaxSpinEdit: TSpinEdit;
    ToneSpinEdit: TSpinEdit;
    Label15: TLabel;
    Label16: TLabel;
    PaddleCheck: TCheckBox;
    CQRepEdit: TEdit;
    Label17: TLabel;
    FIFOCheck: TCheckBox;
    PaddleEnabledCheck: TCheckBox;
    AbbrevEdit: TEdit;
    Label12: TLabel;
    ProvEdit: TEdit;
    CItyEdit: TEdit;
    Label14: TLabel;
    Label18: TLabel;
    SentEdit: TEdit;
    Label19: TLabel;
    GroupBox3: TGroupBox;
    act19: TCheckBox;
    act35: TCheckBox;
    act7: TCheckBox;
    act14: TCheckBox;
    act21: TCheckBox;
    act28: TCheckBox;
    act50: TCheckBox;
    act144: TCheckBox;
    act430: TCheckBox;
    act1200: TCheckBox;
    act2400: TCheckBox;
    act5600: TCheckBox;
    act10g: TCheckBox;
    GroupBox4: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    vEdit2: TEdit;
    vEdit3: TEdit;
    vEdit4: TEdit;
    vEdit5: TEdit;
    vEdit6: TEdit;
    vEdit7: TEdit;
    vEdit9: TEdit;
    vEdit8: TEdit;
    vEdit10: TEdit;
    vEdit1: TEdit;
    memo: TLabel;
    OpenDialog: TOpenDialog;
    GroupBox6: TGroupBox;
    Label30: TLabel;
    ClusterCombo: TComboBox;
    Port: TLabel;
    buttonClusterSettings: TButton;
    OpenDialog1: TOpenDialog;
    Label32: TLabel;
    ZLinkCombo: TComboBox;
    buttonZLinkSettings: TButton;
    vButton1: TButton;
    vButton2: TButton;
    vButton3: TButton;
    vButton4: TButton;
    vButton5: TButton;
    vButton6: TButton;
    vButton7: TButton;
    vButton8: TButton;
    vButton9: TButton;
    vButton10: TButton;
    act24: TCheckBox;
    act18: TCheckBox;
    act10: TCheckBox;
    CQZoneEdit: TEdit;
    IARUZoneEdit: TEdit;
    Label34: TLabel;
    Label35: TLabel;
    OpPowerEdit: TEdit;
    Label36: TLabel;
    Label37: TLabel;
    GroupBox7: TGroupBox;
    Label38: TLabel;
    PTTEnabledCheckBox: TCheckBox;
    Label39: TLabel;
    BeforeEdit: TEdit;
    AfterEdit: TEdit;
    AllowDupeCheckBox: TCheckBox;
    SaveEvery: TSpinEdit;
    Label40: TLabel;
    Label41: TLabel;
    cbCountDown: TCheckBox;
    rbBankA: TRadioButton;
    rbBankB: TRadioButton;
    cbDispExchange: TCheckBox;
    gbCWPort: TGroupBox;
    cbJMode: TCheckBox;
    comboRig1Port: TComboBox;
    Label42: TLabel;
    comboRig1Name: TComboBox;
    Label43: TLabel;
    Label31: TLabel;
    comboRig2Port: TComboBox;
    comboRig2Name: TComboBox;
    Label44: TLabel;
    tabsheetMisc: TTabSheet;
    cbRITClear: TCheckBox;
    rgBandData: TRadioGroup;
    cbDontAllowSameBand: TCheckBox;
    SendFreqEdit: TEdit;
    Label45: TLabel;
    Label46: TLabel;
    cbSaveWhenNoCW: TCheckBox;
    cbMultiStn: TCheckBox;
    rgSearchAfter: TRadioGroup;
    spMaxSuperHit: TSpinEdit;
    Label47: TLabel;
    spBSExpire: TSpinEdit;
    Label48: TLabel;
    Label49: TLabel;
    cbUpdateThread: TCheckBox;
    cbQSYCount: TCheckBox;
    cbRecordRigFreq: TCheckBox;
    cbTransverter1: TCheckBox;
    cbTransverter2: TCheckBox;
    tabsheetPath: TTabSheet;
    Label50: TLabel;
    edCFGDATPath: TEdit;
    btnBrowseCFGDATPath: TButton;
    Label51: TLabel;
    edLogsPath: TEdit;
    btnBrowseLogsPath: TButton;
    rbRTTY: TRadioButton;
    cbCQSP: TCheckBox;
    cbAFSK: TCheckBox;
    cbAutoEnterSuper: TCheckBox;
    Label52: TLabel;
    Label53: TLabel;
    spSpotExpire: TSpinEdit;
    cbDisplayDatePartialCheck: TCheckBox;
    cbAutoBandMap: TCheckBox;
    checkUseMultiStationWarning: TCheckBox;
    Label55: TLabel;
    editZLinkPcName: TEdit;
    checkZLinkSyncSerial: TCheckBox;
    comboRig1Speed: TComboBox;
    comboRig2Speed: TComboBox;
    comboCwPttPort: TComboBox;
    checkUseTransceiveMode: TCheckBox;
    tabsheetQuickQSY: TTabSheet;
    checkUseQuickQSY01: TCheckBox;
    comboQuickQsyBand01: TComboBox;
    comboQuickQsyMode01: TComboBox;
    checkUseQuickQSY02: TCheckBox;
    comboQuickQsyBand02: TComboBox;
    comboQuickQsyMode02: TComboBox;
    checkUseQuickQSY03: TCheckBox;
    comboQuickQsyBand03: TComboBox;
    comboQuickQsyMode03: TComboBox;
    checkUseQuickQSY04: TCheckBox;
    comboQuickQsyBand04: TComboBox;
    comboQuickQsyMode04: TComboBox;
    checkUseQuickQSY05: TCheckBox;
    comboQuickQsyBand05: TComboBox;
    comboQuickQsyMode05: TComboBox;
    checkUseQuickQSY06: TCheckBox;
    comboQuickQsyBand06: TComboBox;
    comboQuickQsyMode06: TComboBox;
    checkUseQuickQSY07: TCheckBox;
    comboQuickQsyBand07: TComboBox;
    comboQuickQsyMode07: TComboBox;
    checkUseQuickQSY08: TCheckBox;
    comboQuickQsyBand08: TComboBox;
    comboQuickQsyMode08: TComboBox;
    Label54: TLabel;
    Label33: TLabel;
    GroupBox8: TGroupBox;
    radioSuperCheck0: TRadioButton;
    radioSuperCheck1: TRadioButton;
    editSuperCheckFolder: TEdit;
    radioSuperCheck2: TRadioButton;
    buttonSuperCheckFolderRef: TSpeedButton;
    Button4: TButton;
    BackUpPathEdit: TEdit;
    Label56: TLabel;
    comboPower19: TComboBox;
    comboPower35: TComboBox;
    comboPower7: TComboBox;
    comboPower10: TComboBox;
    comboPower14: TComboBox;
    comboPower18: TComboBox;
    comboPower21: TComboBox;
    comboPower24: TComboBox;
    comboPower28: TComboBox;
    comboPower50: TComboBox;
    comboPower144: TComboBox;
    comboPower430: TComboBox;
    comboPower1200: TComboBox;
    comboPower2400: TComboBox;
    comboPower5600: TComboBox;
    comboPower10g: TComboBox;
    GroupBox5: TGroupBox;
    checkHighlightFullmatch: TCheckBox;
    editFullmatchColor: TEdit;
    buttonFullmatchSelectColor: TButton;
    buttonFullmatchInitColor: TButton;
    tabsheetBandScope1: TTabSheet;
    GroupBox9: TGroupBox;
    checkBs01: TCheckBox;
    checkBs02: TCheckBox;
    checkBs03: TCheckBox;
    checkBs05: TCheckBox;
    checkBs07: TCheckBox;
    checkBs09: TCheckBox;
    checkBs10: TCheckBox;
    checkBs11: TCheckBox;
    checkBs12: TCheckBox;
    checkBs13: TCheckBox;
    checkBs14: TCheckBox;
    checkBs15: TCheckBox;
    checkBs16: TCheckBox;
    checkBs08: TCheckBox;
    checkBs06: TCheckBox;
    checkBs04: TCheckBox;
    GroupBox10: TGroupBox;
    editBSColor1: TEdit;
    buttonBSFore1: TButton;
    buttonBSReset1: TButton;
    Label57: TLabel;
    buttonBSBack1: TButton;
    Label58: TLabel;
    Label59: TLabel;
    editBSColor2: TEdit;
    buttonBSFore2: TButton;
    buttonBSReset2: TButton;
    buttonBSBack2: TButton;
    editBSColor3: TEdit;
    buttonBSFore3: TButton;
    buttonBSReset3: TButton;
    buttonBSBack3: TButton;
    Label60: TLabel;
    editBSColor4: TEdit;
    buttonBSFore4: TButton;
    buttonBSReset4: TButton;
    buttonBSBack4: TButton;
    checkBSBold1: TCheckBox;
    checkBSBold2: TCheckBox;
    checkBSBold3: TCheckBox;
    checkBSBold4: TCheckBox;
    ColorDialog1: TColorDialog;
    checkSendNrAuto: TCheckBox;
    comboQuickQsyRig01: TComboBox;
    Label62: TLabel;
    comboQuickQsyRig02: TComboBox;
    comboQuickQsyRig03: TComboBox;
    comboQuickQsyRig04: TComboBox;
    comboQuickQsyRig05: TComboBox;
    comboQuickQsyRig06: TComboBox;
    comboQuickQsyRig07: TComboBox;
    comboQuickQsyRig08: TComboBox;
    checkGetBandAndMode: TCheckBox;
    checkCwReverseSignal: TCheckBox;
    tabsheetQuickMemo: TTabSheet;
    GroupBox11: TGroupBox;
    Label63: TLabel;
    editQuickMemo1: TEdit;
    Label64: TLabel;
    editQuickMemo2: TEdit;
    Label65: TLabel;
    editQuickMemo3: TEdit;
    Label66: TLabel;
    editQuickMemo4: TEdit;
    Label67: TLabel;
    editQuickMemo5: TEdit;
    tabsheetBandScope2: TTabSheet;
    GroupBox12: TGroupBox;
    Label61: TLabel;
    editBSColor5: TEdit;
    buttonBSFore5: TButton;
    buttonBSBack5: TButton;
    checkBSBold5: TCheckBox;
    buttonBSReset5: TButton;
    Label68: TLabel;
    editBSColor6: TEdit;
    buttonBSFore6: TButton;
    buttonBSBack6: TButton;
    checkBSBold6: TCheckBox;
    buttonBSReset6: TButton;
    Label69: TLabel;
    editBSColor7: TEdit;
    buttonBSFore7: TButton;
    buttonBSBack7: TButton;
    checkBSBold7: TCheckBox;
    buttonBSReset7: TButton;
    groupSpotFreshness: TGroupBox;
    radioFreshness1: TRadioButton;
    radioFreshness2: TRadioButton;
    radioFreshness3: TRadioButton;
    radioFreshness4: TRadioButton;
    editMessage9: TEdit;
    editMessage10: TEdit;
    Label70: TLabel;
    Label71: TLabel;
    procedure MultiOpRadioBtnClick(Sender: TObject);
    procedure SingleOpRadioBtnClick(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AddClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure OpEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OpEditEnter(Sender: TObject);
    procedure OpEditExit(Sender: TObject);
    procedure SpeedBarChange(Sender: TObject);
    procedure WeightBarChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vButtonClick(Sender: TObject);
    procedure ClusterComboChange(Sender: TObject);
    procedure buttonClusterSettingsClick(Sender: TObject);
    procedure ZLinkComboChange(Sender: TObject);
    procedure buttonZLinkSettingsClick(Sender: TObject);
    procedure BrowsePathClick(Sender: TObject);
    procedure PTTEnabledCheckBoxClick(Sender: TObject);
    procedure CQRepEditKeyPress(Sender: TObject; var Key: Char);
    procedure editMessage1Change(Sender: TObject);
    procedure CWBankClick(Sender: TObject);
    procedure cbCountDownClick(Sender: TObject);
    procedure cbQSYCountClick(Sender: TObject);
    procedure cbTransverter1Click(Sender: TObject);
    procedure comboRig1NameChange(Sender: TObject);
    procedure comboRig2NameChange(Sender: TObject);
    procedure checkUseQuickQSYClick(Sender: TObject);
    procedure buttonSuperCheckFolderRefClick(Sender: TObject);
    procedure OnNeedSuperCheckLoad(Sender: TObject);
    procedure buttonFullmatchSelectColorClick(Sender: TObject);
    procedure buttonFullmatchInitColorClick(Sender: TObject);
    procedure buttonBSForeClick(Sender: TObject);
    procedure buttonBSBackClick(Sender: TObject);
    procedure checkBSBoldClick(Sender: TObject);
    procedure buttonBSResetClick(Sender: TObject);
  private
    FCWEditMode: Integer;
    TempVoiceFiles : array[1..10] of string;
    TempCurrentBank : integer;
    TempCWStrBank : array[1..maxbank,1..maxmaxstr] of string; // used temporarily while options window is open

    FTempClusterTelnet: TCommParam;
    FTempClusterCom: TCommParam;
    FTempZLinkTelnet: TCommParam;

    FQuickQSYCheck: array[1..8] of TCheckBox;
    FQuickQSYBand: array[1..8] of TComboBox;
    FQuickQSYMode: array[1..8] of TComboBox;
    FQuickQSYRig: array[1..8] of TComboBox;

    FBSColor: array[1..7] of TEdit;
    FBSBold: array[1..7] of TCheckBox;

    FNeedSuperCheckLoad: Boolean;

    FQuickMemoText: array[1..5] of TEdit;

    procedure RenewCWStrBankDisp();
    procedure InitRigNames();
  public
    procedure RenewSettings; {Reads controls and updates Settings}
    property CWEditMode: Integer read FCWEditMode write FCWEditMode;
    property NeedSuperCheckLoad: Boolean read FNeedSuperCheckLoad;
  end;

const
  BandScopeDefaultColor: array[1..5] of TColorSetting = (
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: False ),
    ( FForeColor: clWhite; FBackColor: clRed;   FBold: True ),
    ( FForeColor: clGreen; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clGreen; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clRed;   FBackColor: clYellow; FBold: True )
  );

implementation

uses Main, UzLogCW, UComm, UClusterTelnetSet, UClusterCOMSet,
  UZlinkTelnetSet, UZLinkForm, URigControl;

{$R *.DFM}

procedure TformOptions.MultiOpRadioBtnClick(Sender: TObject);
begin
   OpListBox.Enabled := True;
end;

procedure TformOptions.SingleOpRadioBtnClick(Sender: TObject);
begin
   OpListBox.Enabled := False;
end;

procedure TformOptions.RenewSettings;
var
   r: double;
   i, j: integer;
begin
   with dmZlogGlobal do begin
      Settings._recrigfreq := cbRecordRigFreq.Checked;
      Settings._multistation := cbMultiStn.Checked;
      Settings._savewhennocw := cbSaveWhenNoCW.Checked;
      Settings._jmode := cbJMode.Checked;
      Settings._searchafter := rgSearchAfter.ItemIndex;
      Settings._renewbythread := cbUpdateThread.Checked;
      Settings._displaydatepartialcheck := cbDisplayDatePartialCheck.Checked;

      Settings._banddatamode := rgBandData.ItemIndex;
      Settings._AFSK := cbAFSK.Checked;
      Settings._maxsuperhit := spMaxSuperHit.Value;

      Settings._activebands[b19] := act19.Checked;
      Settings._activebands[b35] := act35.Checked;
      Settings._activebands[b7] := act7.Checked;
      Settings._activebands[b10] := act10.Checked;
      Settings._activebands[b14] := act14.Checked;
      Settings._activebands[b18] := act18.Checked;
      Settings._activebands[b21] := act21.Checked;
      Settings._activebands[b24] := act24.Checked;
      Settings._activebands[b28] := act28.Checked;
      Settings._activebands[b50] := act50.Checked;
      Settings._activebands[b144] := act144.Checked;
      Settings._activebands[b430] := act430.Checked;
      Settings._activebands[b1200] := act1200.Checked;
      Settings._activebands[b2400] := act2400.Checked;
      Settings._activebands[b5600] := act5600.Checked;
      Settings._activebands[b10g] := act10g.Checked;

      Settings._power[b19] := comboPower19.Text;
      Settings._power[b35] := comboPower35.Text;
      Settings._power[b7] := comboPower7.Text;
      Settings._power[b10] := comboPower10.Text;
      Settings._power[b14] := comboPower14.Text;
      Settings._power[b18] := comboPower18.Text;
      Settings._power[b21] := comboPower21.Text;
      Settings._power[b24] := comboPower24.Text;
      Settings._power[b28] := comboPower28.Text;
      Settings._power[b50] := comboPower50.Text;
      Settings._power[b144] := comboPower144.Text;
      Settings._power[b430] := comboPower430.Text;
      Settings._power[b1200] := comboPower1200.Text;
      Settings._power[b2400] := comboPower2400.Text;
      Settings._power[b5600] := comboPower5600.Text;
      Settings._power[b10g] := comboPower10g.Text;

      OpList.Free;
      OpList := TStringList.Create;
      OpList.Assign(OpListBox.Items);

      // Settings._band := BandGroup.ItemIndex;
      case BandGroup.ItemIndex of
         0 .. 3:
            Settings._band := BandGroup.ItemIndex;
         4:
            Settings._band := BandGroup.ItemIndex + 1;
         5:
            Settings._band := BandGroup.ItemIndex + 2;
         6 .. 13:
            Settings._band := BandGroup.ItemIndex + 3;
      end;

      Settings._mode := ModeGroup.ItemIndex;
      // Settings._multiop := MultiOpRadioBtn.Checked;

      Settings._prov := ProvEdit.Text;
      Settings._city := CItyEdit.Text;
      Settings._cqzone := CQZoneEdit.Text;
      Settings._iaruzone := IARUZoneEdit.Text;

      {
        Settings.CW.CWStrBank[1,1] := Edit1.Text;
        Settings.CW.CWStrBank[1,2] := Edit2.Text;
        Settings.CW.CWStrBank[1,3] := Edit3.Text;
        Settings.CW.CWStrBank[1,4] := Edit4.Text;
        Settings.CW.CWStrBank[1,5] := Edit5.Text;
        Settings.CW.CWStrBank[1,6] := Edit6.Text;
        Settings.CW.CWStrBank[1,7] := Edit7.Text;
        Settings.CW.CWStrBank[1,8] := Edit8.Text;

        Settings.CW.CQStrBank[0] := Edit1.Text;
      }

      for i := 1 to maxbank do
         for j := 1 to maxstr do
            Settings.CW.CWStrBank[i, j] := TempCWStrBank[i, j];

      Settings.CW.CQStrBank[0] := TempCWStrBank[1, 1];

      Settings.CW.CQStrBank[1] := editMessage11.Text;
      Settings.CW.CQStrBank[2] := editMessage12.Text;

      Settings._bsexpire := spBSExpire.Value;
      Settings._spotexpire := spSpotExpire.Value;

      r := Settings.CW._cqrepeat;
      Settings.CW._cqrepeat := StrToFloatDef(CQRepEdit.Text, r);

      r := Settings._sendfreq;
      Settings._sendfreq := StrToFloatDef(SendFreqEdit.Text, r);

      Settings.CW._speed := SpeedBar.Position;
      Settings.CW._weight := WeightBar.Position;
      Settings.CW._paddlereverse := PaddleCheck.Checked;
      Settings.CW._FIFO := FIFOCheck.Checked;
      Settings.CW._tonepitch := ToneSpinEdit.Value;
      Settings.CW._cqmax := CQmaxSpinEdit.Value;
      Settings.CW._paddle := PaddleEnabledCheck.Checked;

      Settings._switchcqsp := cbCQSP.Checked;

      if length(AbbrevEdit.Text) >= 3 then begin
         Settings.CW._zero := AbbrevEdit.Text[1];
         Settings.CW._one := AbbrevEdit.Text[2];
         Settings.CW._nine := AbbrevEdit.Text[3];
      end;

      // Send NR? automatically
      Settings.CW._send_nr_auto := checkSendNrAuto.Checked;

      Settings._clusterport := ClusterCombo.ItemIndex;
   //   Settings._clusterbaud := ClusterCOMSet.BaudCombo.ItemIndex;

      // RIG1
      Settings._rigport[1] := comboRig1Port.ItemIndex;

      if comboRig1Name.ItemIndex <= 0 then begin
         Settings._rigname[1] := '';
      end
      else begin
         Settings._rigname[1] := comboRig1Name.Text;
      end;

      Settings._rigspeed[1] := comboRig1Speed.ItemIndex;

      // RIG2
      Settings._rigport[2] := comboRig2Port.ItemIndex;

      if comboRig2Name.ItemIndex <= 0 then begin
         Settings._rigname[2] := '';
      end
      else begin
         Settings._rigname[2] := comboRig2Name.Text;
      end;

      Settings._rigspeed[2] := comboRig2Speed.ItemIndex;

      Settings._use_transceive_mode := checkUseTransceiveMode.Checked;
      Settings._icom_polling_freq_and_mode := checkGetBandAndMode.Checked;

      Settings._ritclear := cbRITClear.Checked;

      Settings._zlinkport := ZLinkCombo.ItemIndex;
      Settings._pcname := editZLinkPcName.Text;
      Settings._syncserial := checkZLinkSyncSerial.Checked;

      Settings._pttenabled := PTTEnabledCheckBox.Checked;
      Settings.CW._keying_signal_reverse := checkCwReverseSignal.Checked;

      Settings._saveevery := SaveEvery.Value;
      Settings._countdown := cbCountDown.Checked;
      Settings._qsycount := cbQSYCount.Checked;

      i := Settings._pttbefore;
      Settings._pttbefore := StrToIntDef(BeforeEdit.Text, i);

      i := Settings._pttafter;
      Settings._pttafter := StrToIntDef(AfterEdit.Text, i);

      // CW/PTT port
      if (comboCwPttPort.ItemIndex >= 1) and (comboCwPttPort.ItemIndex <= 20) then begin
         Settings._lptnr := comboCwPttPort.ItemIndex;
      end
      else if comboCwPttPort.ItemIndex = 21 then begin    // USB
         Settings._lptnr := 21;
      end
      else begin
         Settings._lptnr := 0;
      end;

      Settings._sentstr := SentEdit.Text;

      Settings._backuppath := IncludeTrailingPathDelimiter(BackUpPathEdit.Text);
      Settings._cfgdatpath := IncludeTrailingPathDelimiter(edCFGDATPath.Text);
      Settings._logspath := IncludeTrailingPathDelimiter(edLogsPath.Text);

      Settings._allowdupe := AllowDupeCheckBox.Checked;
      Settings._sameexchange := cbDispExchange.Checked;
      Settings._entersuperexchange := cbAutoEnterSuper.Checked;

      Settings._transverter1 := cbTransverter1.Checked;
      Settings._transverter2 := cbTransverter2.Checked;
      Settings._autobandmap := cbAutoBandMap.Checked;

      Settings._cluster_telnet := FTempClusterTelnet;
      Settings._cluster_com := FTempClusterCom;
      Settings._zlink_telnet := FTempZLinkTelnet;

      // Quick QSY
      for i := Low(FQuickQSYCheck) to High(FQuickQSYCheck) do begin
         Settings.FQuickQSY[i].FUse := FQuickQSYCheck[i].Checked;
         if FQuickQSYBand[i].ItemIndex = -1 then begin
            Settings.FQuickQSY[i].FBand := b35;
         end
         else begin
            Settings.FQuickQSY[i].FBand := TBand(FQuickQSYBand[i].ItemIndex);
         end;

         if FQuickQSYMode[i].ItemIndex = -1 then begin
            Settings.FQuickQSY[i].FMode := mCW;
         end
         else begin
            Settings.FQuickQSY[i].FMode := TMode(FQuickQSYMode[i].ItemIndex);
         end;

         Settings.FQuickQSY[i].FRig := FQuickQSYRig[i].ItemIndex;
      end;

      // SuperCheck
      if radioSuperCheck0.Checked = True then begin
         Settings.FSuperCheck.FSuperCheckMethod := 0;
      end
      else if radioSuperCheck1.Checked = True then begin
         Settings.FSuperCheck.FSuperCheckMethod := 1;
      end
      else begin
         Settings.FSuperCheck.FSuperCheckMethod := 2;
      end;
      Settings.FSuperCheck.FSuperCheckFolder := editSuperCheckFolder.Text;
      Settings.FSuperCheck.FFullMatchHighlight := checkHighlightFullmatch.Checked;
      Settings.FSuperCheck.FFullMatchColor := editFullmatchColor.Color;

      // Band Scope
      Settings._usebandscope[b19]   := checkBS01.Checked;
      Settings._usebandscope[b35]   := checkBS02.Checked;
      Settings._usebandscope[b7]    := checkBS03.Checked;
      Settings._usebandscope[b10]   := checkBS04.Checked;
      Settings._usebandscope[b14]   := checkBS05.Checked;
      Settings._usebandscope[b18]   := checkBS06.Checked;
      Settings._usebandscope[b21]   := checkBS07.Checked;
      Settings._usebandscope[b24]   := checkBS08.Checked;
      Settings._usebandscope[b28]   := checkBS09.Checked;
      Settings._usebandscope[b50]   := checkBS10.Checked;
      Settings._usebandscope[b144]  := checkBS11.Checked;
      Settings._usebandscope[b430]  := checkBS12.Checked;
      Settings._usebandscope[b1200] := checkBS13.Checked;
      Settings._usebandscope[b2400] := checkBS14.Checked;
      Settings._usebandscope[b5600] := checkBS15.Checked;
      Settings._usebandscope[b10g]  := checkBS16.Checked;

      for i := 1 to 7 do begin
         Settings._bandscopecolor[i].FForeColor := FBSColor[i].Font.Color;
         Settings._bandscopecolor[i].FBackColor := FBSColor[i].Color;
         Settings._bandscopecolor[i].FBold      := FBSBold[i].Checked;
      end;

      // Spot鮮度表示
      if radioFreshness1.Checked = True then begin
         Settings._bandscope_freshness_mode := 0;           // Remain time1
         Settings._bandscope_freshness_icon := 2;
      end
      else if radioFreshness2.Checked = True then begin
         Settings._bandscope_freshness_mode := 1;           // Remain time2
         Settings._bandscope_freshness_icon := 3;
      end
      else if radioFreshness3.Checked = True then begin
         Settings._bandscope_freshness_mode := 2;           // Remain time3
         Settings._bandscope_freshness_icon := 2;
      end
      else if radioFreshness4.Checked = True then begin
         Settings._bandscope_freshness_mode := 3;           // Elapsed time
         Settings._bandscope_freshness_icon := 5;
      end
      else begin
         Settings._bandscope_freshness_mode := 0;
         Settings._bandscope_freshness_icon := 2;
      end;

      // Quick Memo
      for i := 1 to 5 do begin
         Settings.FQuickMemoText[i] := Trim(FQuickMemoText[i].Text);
      end;
   end;
end;

procedure TformOptions.buttonOKClick(Sender: TObject);
begin
   RenewSettings;
   dmZlogGlobal.ImplementSettings(False);

   dmZlogGlobal.SaveCurrentSettings();
end;

procedure TformOptions.RenewCWStrBankDisp;
begin
   editMessage1.Text  := TempCWStrBank[TempCurrentBank, 1];
   editMessage2.Text  := TempCWStrBank[TempCurrentBank, 2];
   editMessage3.Text  := TempCWStrBank[TempCurrentBank, 3];
   editMessage4.Text  := TempCWStrBank[TempCurrentBank, 4];
   editMessage5.Text  := TempCWStrBank[TempCurrentBank, 5];
   editMessage6.Text  := TempCWStrBank[TempCurrentBank, 6];
   editMessage7.Text  := TempCWStrBank[TempCurrentBank, 7];
   editMessage8.Text  := TempCWStrBank[TempCurrentBank, 8];
   editMessage9.Text  := TempCWStrBank[TempCurrentBank, 9];
   editMessage10.Text := TempCWStrBank[TempCurrentBank, 10];
end;

procedure TformOptions.FormShow(Sender: TObject);
var
   i, j: integer;
begin
   with dmZlogGlobal do begin
      FTempClusterTelnet := Settings._cluster_telnet;
      FTempClusterCom := Settings._cluster_com;
      FTempZLinkTelnet := Settings._zlink_telnet;

      cbSaveWhenNoCW.Checked := Settings._savewhennocw;
      cbJMode.Checked := Settings._jmode;

      rgSearchAfter.ItemIndex := Settings._searchafter;
      spMaxSuperHit.Value := Settings._maxsuperhit;
      spBSExpire.Value := Settings._bsexpire;
      spSpotExpire.Value := Settings._spotexpire;
      cbUpdateThread.Checked := Settings._renewbythread;
      cbDisplayDatePartialCheck.Checked := Settings._displaydatepartialcheck;

      rgBandData.ItemIndex := Settings._banddatamode;
      cbDontAllowSameBand.Checked := Settings._dontallowsameband;
      cbAutoBandMap.Checked := Settings._autobandmap;
      cbAFSK.Checked := Settings._AFSK;

      cbRecordRigFreq.Checked := Settings._recrigfreq;
      cbMultiStn.Checked := Settings._multistation;

      act19.Checked := Settings._activebands[b19];
      act35.Checked := Settings._activebands[b35];
      act7.Checked := Settings._activebands[b7];
      act10.Checked := Settings._activebands[b10];
      act14.Checked := Settings._activebands[b14];
      act18.Checked := Settings._activebands[b18];
      act21.Checked := Settings._activebands[b21];
      act24.Checked := Settings._activebands[b24];
      act28.Checked := Settings._activebands[b28];
      act50.Checked := Settings._activebands[b50];
      act144.Checked := Settings._activebands[b144];
      act430.Checked := Settings._activebands[b430];
      act1200.Checked := Settings._activebands[b1200];
      act2400.Checked := Settings._activebands[b2400];
      act5600.Checked := Settings._activebands[b5600];
      act10g.Checked := Settings._activebands[b10g];

      comboPower19.Text := Settings._power[b19];
      comboPower35.Text := Settings._power[b35];
      comboPower7.Text := Settings._power[b7];
      comboPower10.Text := Settings._power[b10];
      comboPower14.Text := Settings._power[b14];
      comboPower18.Text := Settings._power[b18];
      comboPower21.Text := Settings._power[b21];
      comboPower24.Text := Settings._power[b24];
      comboPower28.Text := Settings._power[b28];
      comboPower50.Text := Settings._power[b50];
      comboPower144.Text := Settings._power[b144];
      comboPower430.Text := Settings._power[b430];
      comboPower1200.Text := Settings._power[b1200];
      comboPower2400.Text := Settings._power[b2400];
      comboPower5600.Text := Settings._power[b5600];
      comboPower10g.Text := Settings._power[b10g];

      if Settings._multiop <> 0 then
         MultiOpRadioBtn.Checked := True
      else
         SingleOpRadioBtn.Checked := True;

      if Settings._band = 0 then
         BandGroup.ItemIndex := 0
      else
         BandGroup.ItemIndex := OldBandOrd(TBand(Settings._band - 1)) + 1;

      ModeGroup.ItemIndex := Settings._mode;
      { OpListBox.Items := OpList; }

      for i := 1 to maxbank do
         for j := 1 to maxstr do
            TempCWStrBank[i, j] := Settings.CW.CWStrBank[i, j];

      TempCurrentBank := Settings.CW.CurrentBank;
      case TempCurrentBank of
         1:
            rbBankA.Checked := True;
         2:
            rbBankB.Checked := True;
         3:
            rbRTTY.Checked := True;
      end;

      RenewCWStrBankDisp;
      {
        Edit1.Text := Settings.CW.CWStrBank[1,1];
        Edit2.Text := Settings.CW.CWStrBank[1,2];
        Edit3.Text := Settings.CW.CWStrBank[1,3];
        Edit4.Text := Settings.CW.CWStrBank[1,4];
        Edit5.Text := Settings.CW.CWStrBank[1,5];
        Edit6.Text := Settings.CW.CWStrBank[1,6];
        Edit7.Text := Settings.CW.CWStrBank[1,7];
        Edit8.Text := Settings.CW.CWStrBank[1,8];
      }
      editMessage11.Text := Settings.CW.CQStrBank[1];
      editMessage12.Text := Settings.CW.CQStrBank[2];

      CQRepEdit.Text := FloatToStrF(Settings.CW._cqrepeat, ffFixed, 3, 1);
      SendFreqEdit.Text := FloatToStrF(Settings._sendfreq, ffFixed, 3, 1);
      SpeedBar.Position := Settings.CW._speed;
      SpeedLabel.Caption := IntToStr(Settings.CW._speed) + ' wpm';
      WeightBar.Position := Settings.CW._weight;
      WeightLabel.Caption := IntToStr(Settings.CW._weight) + ' %';
      PaddleCheck.Checked := Settings.CW._paddlereverse;
      PaddleEnabledCheck.Checked := Settings.CW._paddle;
      FIFOCheck.Checked := Settings.CW._FIFO;
      ToneSpinEdit.Value := Settings.CW._tonepitch;
      CQmaxSpinEdit.Value := Settings.CW._cqmax;
      AbbrevEdit.Text := Settings.CW._zero + Settings.CW._one + Settings.CW._nine;

      ProvEdit.Text := Settings._prov;
      CItyEdit.Text := Settings._city;
      CQZoneEdit.Text := Settings._cqzone;
      IARUZoneEdit.Text := Settings._iaruzone;

      AllowDupeCheckBox.Checked := Settings._allowdupe;

      ClusterCombo.ItemIndex := Settings._clusterport;
      ZLinkCombo.ItemIndex := Settings._zlinkport;
      editZLinkPcName.Text := Settings._pcname;
      checkZLinkSyncSerial.Checked := Settings._syncserial;

      // RIG1
      comboRig1Port.ItemIndex := Settings._rigport[1];

      i := comboRig1Name.Items.IndexOf(Settings._rigname[1]);
      if i = -1 then begin
         i := 0;
      end;
      comboRig1Name.ItemIndex := i;

      comboRig1Speed.ItemIndex := Settings._rigspeed[1];

      // RIG2
      comboRig2Port.ItemIndex := Settings._rigport[2];

      i := comboRig2Name.Items.IndexOf(Settings._rigname[2]);
      if i = -1 then begin
         i := 0;
      end;
      comboRig2Name.ItemIndex := i;

      comboRig2Speed.ItemIndex := Settings._rigspeed[2];

      checkUseTransceiveMode.Checked := Settings._use_transceive_mode;
      checkGetBandAndMode.Checked := Settings._icom_polling_freq_and_mode;

      cbRITClear.Checked := Settings._ritclear;

      // Packet Cluster通信設定ボタン
      buttonClusterSettings.Enabled := True;
      ClusterComboChange(nil);

      // ZLink通信設定ボタン
      buttonZLinkSettings.Enabled := True;
      ZLinkComboChange(nil);

      SaveEvery.Value := Settings._saveevery;

      // CW/PTT port
      if (Settings._lptnr >= 1) and (Settings._lptnr <= 20) then begin
         comboCwPttPort.ItemIndex := Settings._lptnr;
      end
      else if (Settings._lptnr >= 21) then begin
         comboCwPttPort.ItemIndex := 21;
      end
      else begin
         comboCwPttPort.ItemIndex := 0;
      end;

      SentEdit.Text := Settings._sentstr;

      BackUpPathEdit.Text := Settings._backuppath;
      edCFGDATPath.Text := Settings._cfgdatpath;
      edLogsPath.Text := Settings._logspath;

      PTTEnabledCheckBox.Checked := Settings._pttenabled;
      checkCwReverseSignal.Checked := Settings.CW._keying_signal_reverse;

      BeforeEdit.Text := IntToStr(Settings._pttbefore);
      AfterEdit.Text := IntToStr(Settings._pttafter);
      if PTTEnabledCheckBox.Checked then begin
         BeforeEdit.Enabled := True;
         AfterEdit.Enabled := True;
      end
      else begin
         BeforeEdit.Enabled := False;
         AfterEdit.Enabled := False;
      end;
      cbCQSP.Checked := Settings._switchcqsp;

      // Send NR? automatically
      checkSendNrAuto.Checked := Settings.CW._send_nr_auto;

      cbCountDown.Checked := Settings._countdown;
      cbQSYCount.Checked := Settings._qsycount;

      cbDispExchange.Checked := Settings._sameexchange;
      cbAutoEnterSuper.Checked := Settings._entersuperexchange;

      cbTransverter1.Checked := Settings._transverter1;
      cbTransverter2.Checked := Settings._transverter2;

      // Quick QSY
      for i := Low(FQuickQSYCheck) to High(FQuickQSYCheck) do begin
         FQuickQSYCheck[i].Checked := dmZLogGlobal.Settings.FQuickQSY[i].FUse;
         if FQuickQSYCheck[i].Checked = True then begin
            FQuickQSYBand[i].ItemIndex := Integer(Settings.FQuickQSY[i].FBand);
            FQuickQSYMode[i].ItemIndex := Integer(Settings.FQuickQSY[i].FMode);
         end
         else begin
            FQuickQSYBand[i].ItemIndex := -1;
            FQuickQSYMode[i].ItemIndex := -1;
         end;
         FQuickQSYRig[i].ItemIndex := Settings.FQuickQSY[i].FRig;

         FQuickQSYBand[i].Enabled := FQuickQSYCheck[i].Checked;
         FQuickQSYMode[i].Enabled := FQuickQSYCheck[i].Checked;
         FQuickQSYRig[i].Enabled  := FQuickQSYCheck[i].Checked;
      end;

      // SuperCheck
      case Settings.FSuperCheck.FSuperCheckMethod of
         0: radioSuperCheck0.Checked := True;
         1: radioSuperCheck1.Checked := True;
         else radioSuperCheck2.Checked := True;
      end;
      editSuperCheckFolder.Text := Settings.FSuperCheck.FSuperCheckFolder;
      checkHighlightFullmatch.Checked := Settings.FSuperCheck.FFullMatchHighlight;
      editFullmatchColor.Color := Settings.FSuperCheck.FFullMatchColor;

      // Band Scope
      checkBS01.Checked := Settings._usebandscope[b19];
      checkBS02.Checked := Settings._usebandscope[b35];
      checkBS03.Checked := Settings._usebandscope[b7];
      checkBS04.Checked := Settings._usebandscope[b10];
      checkBS05.Checked := Settings._usebandscope[b14];
      checkBS06.Checked := Settings._usebandscope[b18];
      checkBS07.Checked := Settings._usebandscope[b21];
      checkBS08.Checked := Settings._usebandscope[b24];
      checkBS09.Checked := Settings._usebandscope[b28];
      checkBS10.Checked := Settings._usebandscope[b50];
      checkBS11.Checked := Settings._usebandscope[b144];
      checkBS12.Checked := Settings._usebandscope[b430];
      checkBS13.Checked := Settings._usebandscope[b1200];
      checkBS14.Checked := Settings._usebandscope[b2400];
      checkBS15.Checked := Settings._usebandscope[b5600];
      checkBS16.Checked := Settings._usebandscope[b10g];

      for i := 1 to 7 do begin
         FBSColor[i].Font.Color := Settings._bandscopecolor[i].FForeColor;
         FBSColor[i].Color      := Settings._bandscopecolor[i].FBackColor;
         FBSBold[i].Checked     := Settings._bandscopecolor[i].FBold;
      end;

      // Spot鮮度表示
      case Settings._bandscope_freshness_mode of
         0: radioFreshness1.Checked := True;
         1: radioFreshness2.Checked := True;
         2: radioFreshness3.Checked := True;
         3: radioFreshness4.Checked := True;
         else radioFreshness1.Checked := True;
      end;

      // Quick Memo
      for i := 1 to 5 do begin
         FQuickMemoText[i].Text := Settings.FQuickMemoText[i];
      end;
   end;

   if FCWEditMode = 0 then begin
      tabsheetPreferences.TabVisible := True;
      tabsheetCategories.TabVisible := True;
      tabsheetCW.TabVisible := True;
      tabsheetVoice.TabVisible := False;
      tabsheetHardware.TabVisible := True;
      tabsheetRigControl.TabVisible := True;
      tabsheetPath.TabVisible := True;
      tabsheetMisc.TabVisible := True;
      tabsheetQuickQSY.TabVisible := True;
   end
   else begin
      PageControl.ActivePage := tabsheetCW;

      tabsheetPreferences.TabVisible := False;
      tabsheetCategories.TabVisible := False;
      tabsheetCW.TabVisible := True;
      tabsheetVoice.TabVisible := False;
      tabsheetHardware.TabVisible := False;
      tabsheetRigControl.TabVisible := False;
      tabsheetPath.TabVisible := False;
      tabsheetMisc.TabVisible := False;
      tabsheetQuickQSY.TabVisible := False;

      case FCWEditMode of
         1: editMessage1.SetFocus;
         2: editMessage2.SetFocus;
         3: editMessage3.SetFocus;
         4: editMessage4.SetFocus;
         5: editMessage5.SetFocus;
         6: editMessage6.SetFocus;
         7: editMessage7.SetFocus;
         8: editMessage8.SetFocus;
         9: editMessage9.SetFocus;
         10: editMessage10.SetFocus;
      end;
   end;

   FNeedSuperCheckLoad := False;
end;

procedure TformOptions.AddClick(Sender: TObject);
var
   str: string;
begin
   if OpEdit.Text <> '' then begin
      str := OpEdit.Text;
      if OpPowerEdit.Text <> '' then begin
         str := FillRight(str, 20) + OpPowerEdit.Text;
      end;

      OpListBox.Items.Add(str);
   end;

   OpEdit.Text := '';
   OpPowerEdit.Text := '';
   OpEdit.SetFocus;
end;

procedure TformOptions.DeleteClick(Sender: TObject);
begin
   OpListBox.Items.Delete(OpListBox.ItemIndex);
end;

procedure TformOptions.FormCreate(Sender: TObject);
var
   i: integer;
   b: TBand;
   m: TMode;
begin
   FQuickQSYCheck[1]    := checkUseQuickQSY01;
   FQuickQSYBand[1]     := comboQuickQsyBand01;
   FQuickQSYMode[1]     := comboQuickQsyMode01;
   FQuickQSYRig[1]      := comboQuickQsyRig01;
   FQuickQSYCheck[2]    := checkUseQuickQSY02;
   FQuickQSYBand[2]     := comboQuickQsyBand02;
   FQuickQSYMode[2]     := comboQuickQsyMode02;
   FQuickQSYRig[2]      := comboQuickQsyRig02;
   FQuickQSYCheck[3]    := checkUseQuickQSY03;
   FQuickQSYBand[3]     := comboQuickQsyBand03;
   FQuickQSYMode[3]     := comboQuickQsyMode03;
   FQuickQSYRig[3]      := comboQuickQsyRig03;
   FQuickQSYCheck[4]    := checkUseQuickQSY04;
   FQuickQSYBand[4]     := comboQuickQsyBand04;
   FQuickQSYMode[4]     := comboQuickQsyMode04;
   FQuickQSYRig[4]      := comboQuickQsyRig04;
   FQuickQSYCheck[5]    := checkUseQuickQSY05;
   FQuickQSYBand[5]     := comboQuickQsyBand05;
   FQuickQSYMode[5]     := comboQuickQsyMode05;
   FQuickQSYRig[5]      := comboQuickQsyRig05;
   FQuickQSYCheck[6]    := checkUseQuickQSY06;
   FQuickQSYBand[6]     := comboQuickQsyBand06;
   FQuickQSYMode[6]     := comboQuickQsyMode06;
   FQuickQSYRig[6]      := comboQuickQsyRig06;
   FQuickQSYCheck[7]    := checkUseQuickQSY07;
   FQuickQSYBand[7]     := comboQuickQsyBand07;
   FQuickQSYMode[7]     := comboQuickQsyMode07;
   FQuickQSYRig[7]      := comboQuickQsyRig07;
   FQuickQSYCheck[8]    := checkUseQuickQSY08;
   FQuickQSYBand[8]     := comboQuickQsyBand08;
   FQuickQSYMode[8]     := comboQuickQsyMode08;
   FQuickQSYRig[8]      := comboQuickQsyRig08;
   for b := Low(MHzString) to High(MHzString) do begin
      FQuickQsyBand[1].Items.Add(MHZString[b]);
   end;
   for m := Low(ModeString) to High(ModeString) do begin
      FQuickQsyMode[1].Items.Add(MODEString[m]);
   end;
   for i := 2 to High(FQuickQsyBand) do begin
      FQuickQsyBand[i].Items.Assign(FQuickQsyBand[1].Items);
      FQuickQsyMode[i].Items.Assign(FQuickQsyMode[1].Items);
   end;

   // BandScope
   FBSColor[1] := editBSColor1;
   FBSColor[2] := editBSColor2;
   FBSColor[3] := editBSColor3;
   FBSColor[4] := editBSColor4;
   FBSColor[5] := editBSColor5;
   FBSColor[6] := editBSColor6;
   FBSColor[7] := editBSColor7;
   FBSBold[1] := checkBSBold1;
   FBSBold[2] := checkBSBold2;
   FBSBold[3] := checkBSBold3;
   FBSBold[4] := checkBSBold4;
   FBSBold[5] := checkBSBold5;
   FBSBold[6] := checkBSBold6;
   FBSBold[7] := checkBSBold7;

   // Quick Memo
   FQuickMemoText[1] := editQuickMemo1;
   FQuickMemoText[2] := editQuickMemo2;
   FQuickMemoText[3] := editQuickMemo3;
   FQuickMemoText[4] := editQuickMemo4;
   FQuickMemoText[5] := editQuickMemo5;

   TempCurrentBank := 1;

   OpListBox.Items.Assign(dmZlogGlobal.OpList);

   PageControl.ActivePage := tabsheetPreferences;

   InitRigNames();

   FCWEditMode := 0;

   FNeedSuperCheckLoad := False;
end;

procedure TformOptions.buttonCancelClick(Sender: TObject);
begin
//   Close;
end;

procedure TformOptions.OpEditKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
   case Key of
      VK_RETURN:
         AddClick(Self);
   end;
end;

procedure TformOptions.OpEditEnter(Sender: TObject);
begin
   Add.Default := True;
end;

procedure TformOptions.OpEditExit(Sender: TObject);
begin
   buttonOK.Default := True;
end;

procedure TformOptions.SpeedBarChange(Sender: TObject);
begin
   SpeedLabel.Caption := IntToStr(SpeedBar.Position) + ' wpm';
end;

procedure TformOptions.WeightBarChange(Sender: TObject);
begin
   WeightLabel.Caption := IntToStr(WeightBar.Position) + ' %';
end;

procedure TformOptions.FormDestroy(Sender: TObject);
begin
//
end;

procedure TformOptions.vButtonClick(Sender: TObject);
begin
   if OpenDialog.Execute then begin
      TempVoiceFiles[TButton(Sender).Tag] := OpenDialog.filename;
      TLabel(Sender).Caption := ExtractFileName(OpenDialog.filename);
   end;
end;

procedure TformOptions.ClusterComboChange(Sender: TObject);
begin
   buttonClusterSettings.Enabled := True;
   case ClusterCombo.ItemIndex of
      0:
         buttonClusterSettings.Enabled := False;
      1 .. 6:
         buttonClusterSettings.Caption := 'COM port settings';
      7:
         buttonClusterSettings.Caption := 'TELNET settings';
   end;
end;

procedure TformOptions.buttonClusterSettingsClick(Sender: TObject);
var
   f: TForm;
begin
   if (ClusterCombo.ItemIndex >= 1) and (ClusterCombo.ItemIndex <= 6) then begin
      f := TformClusterCOMSet.Create(Self);
      try
         TformClusterCOMSet(f).BaudRate  := FTempClusterCom.FBaudRate;
         TformClusterCOMSet(f).LineBreak := FTempClusterCom.FLineBreak;
         TformClusterCOMSet(f).LocalEcho := FTempClusterCom.FLocalEcho;

         if f.ShowModal() <> mrOK then begin
            Exit;
         end;

         FTempClusterCom.FBaudRate  := TformClusterCOMSet(f).BaudRate;
         FTempClusterCom.FLineBreak := TformClusterCOMSet(f).LineBreak;
         FTempClusterCom.FLocalEcho := TformClusterCOMSet(f).LocalEcho;
      finally
         f.Release();
      end;
   end
   else if ClusterCombo.ItemIndex = 7 then begin
      f := TformClusterTelnetSet.Create(Self);
      try
         TformClusterTelnetSet(f).HostName   := FTempClusterTelnet.FHostName;
         TformClusterTelnetSet(f).LineBreak  := FTempClusterTelnet.FLineBreak;
         TformClusterTelnetSet(f).LocalEcho  := FTempClusterTelnet.FLocalEcho;
         TformClusterTelnetSet(f).PortNumber := FTempClusterTelnet.FPortNumber;

         if f.ShowModal() <> mrOK then begin
            Exit;
         end;

         FTempClusterTelnet.FHostName   := TformClusterTelnetSet(f).HostName;
         FTempClusterTelnet.FLineBreak  := TformClusterTelnetSet(f).LineBreak;
         FTempClusterTelnet.FLocalEcho  := TformClusterTelnetSet(f).LocalEcho;
         FTempClusterTelnet.FPortNumber := TformClusterTelnetSet(f).PortNumber;
      finally
         f.Release();
      end;
   end;
end;

procedure TformOptions.buttonSuperCheckFolderRefClick(Sender: TObject);
var
   fResult: Boolean;
   strSelected: string;
begin
   strSelected := editSuperCheckFolder.Text;

   fResult := SelectDirectory('SuperCheck用のファイルが保存されているフォルダを選択して下さい', '', strSelected, [sdNewUI, sdNewFolder, sdValidateDir], Self);
   if fResult = False then begin
      Exit;
   end;

   editSuperCheckFolder.Text := strSelected;
end;

procedure TformOptions.ZLinkComboChange(Sender: TObject);
begin
   if ZLinkCombo.ItemIndex = 0 then begin
      buttonZLinkSettings.Enabled := False;
   end
   else begin
      buttonZLinkSettings.Enabled := True;
   end;
end;

procedure TformOptions.buttonZLinkSettingsClick(Sender: TObject);
var
   F: TformZLinkTelnetSet;
begin
   F := TformZLinkTelnetSet.Create(Self);
   try
      F.HostName  := FTempZLinkTelnet.FHostName;
      F.LineBreak := FTempZLinkTelnet.FLineBreak;
      F.LocalEcho := FTempZLinkTelnet.FLocalEcho;

      if F.ShowModal() <> mrOK then begin
         exit;
      end;

      FTempZLinkTelnet.FHostName  := F.HostName;
      FTempZLinkTelnet.FLineBreak := F.LineBreak;
      FTempZLinkTelnet.FLocalEcho := F.LocalEcho;
   finally
      F.Release();
   end;
end;

procedure TformOptions.BrowsePathClick(Sender: TObject);
var
   strDir: string;
begin
   case TButton(Sender).Tag of
      0:
         strDir := BackUpPathEdit.Text;
      10:
         strDir := edCFGDATPath.Text;
      20:
         strDir := edLogsPath.Text;
   end;

   if SelectDirectory('フォルダの参照', '', strDir, [sdNewFolder, sdNewUI, sdValidateDir], Self) = False then begin
      exit;
   end;

   case TButton(Sender).Tag of
      0:
         BackUpPathEdit.Text := strDir;
      10:
         edCFGDATPath.Text := strDir;
      20:
         edLogsPath.Text := strDir;
   end;
end;

procedure TformOptions.PTTEnabledCheckBoxClick(Sender: TObject);
begin
   if PTTEnabledCheckBox.Checked then begin
      BeforeEdit.Enabled := True;
      AfterEdit.Enabled := True;
   end
   else begin
      BeforeEdit.Enabled := False;
      AfterEdit.Enabled := False;
   end;
end;

procedure TformOptions.OnNeedSuperCheckLoad(Sender: TObject);
begin
   FNeedSuperCheckLoad := True;
end;

procedure TformOptions.CQRepEditKeyPress(Sender: TObject; var Key: char);
begin
   if not(SysUtils.CharInSet(Key, ['0' .. '9', '.'])) then begin
      Key := #0;
   end;
end;

procedure TformOptions.editMessage1Change(Sender: TObject);
var
   i: integer;
begin
   i := TEdit(Sender).Tag;
   TempCWStrBank[TempCurrentBank, i] := TEdit(Sender).Text;
end;

procedure TformOptions.CWBankClick(Sender: TObject);
begin
   TempCurrentBank := TRadioButton(Sender).Tag;
   RenewCWStrBankDisp;
end;

procedure TformOptions.cbCountDownClick(Sender: TObject);
begin
   if cbCountDown.Checked then
      cbQSYCount.Checked := False;
end;

procedure TformOptions.cbQSYCountClick(Sender: TObject);
begin
   if cbQSYCount.Checked then
      cbCountDown.Checked := False;
end;

procedure TformOptions.cbTransverter1Click(Sender: TObject);
var
   i, r: integer;
   F: TIntegerDialog;
begin
   F := TIntegerDialog.Create(Self);
   try
      r := TCheckBox(Sender).Tag;
      r := r - 100;

      if TCheckBox(Sender).Checked then begin
         i := 0;
         if r = 1 then
            i := dmZlogGlobal.Settings._transverteroffset1;

         if r = 2 then
            i := dmZlogGlobal.Settings._transverteroffset2;

         F.Init(i, 'Please input the offset frequency in kHz');
         if F.ShowModal() <> mrOK then begin
            Exit;
         end;

         i := F.GetValue;
         if i = -1 then begin
            Exit;
         end;

         if r = 1 then
            dmZlogGlobal.Settings._transverteroffset1 := i;

         if r = 2 then
            dmZlogGlobal.Settings._transverteroffset2 := i;
      end;
   finally
      F.Release();
   end;
end;

procedure TformOptions.comboRig1NameChange(Sender: TObject);
begin
   if comboRig1Name.ItemIndex = comboRig1Name.Items.Count - 1 then begin
      comboRig2Name.ItemIndex := comboRig2Name.Items.Count - 1;
      comboRig1Port.ItemIndex := 0;
      comboRig1Port.Enabled := False;
      comboRig2Port.Enabled := False;
   end
   else begin
      comboRig1Port.Enabled := True;
      if comboRig2Name.ItemIndex = comboRig2Name.Items.Count - 1 then begin
         comboRig2Name.ItemIndex := 0;
         comboRig2Port.ItemIndex := 0;
         comboRig2Port.Enabled := True;
      end;
   end;
end;

procedure TformOptions.comboRig2NameChange(Sender: TObject);
begin
   if comboRig2Name.ItemIndex = comboRig2Name.Items.Count - 1 then begin
      comboRig1Name.ItemIndex := comboRig1Name.Items.Count - 1;
      comboRig2Port.ItemIndex := 0;
      comboRig2Port.Enabled := False;
      comboRig1Port.Enabled := False;
   end
   else begin
      comboRig2Port.Enabled := True;
      if comboRig1Name.ItemIndex = comboRig1Name.Items.Count - 1 then begin
         comboRig1Name.ItemIndex := 0;
         comboRig1Port.ItemIndex := 0;
         comboRig1Port.Enabled := True;
      end;
   end;
end;

procedure TformOptions.checkUseQuickQSYClick(Sender: TObject);
var
   no: Integer;
begin
   no := TCheckBox(Sender).Tag;
   FQuickQSYBand[no].Enabled := FQuickQSYCheck[no].Checked;
   FQuickQSYMode[no].Enabled := FQuickQSYCheck[no].Checked;
   FQuickQSYRig[no].Enabled  := FQuickQSYCheck[no].Checked;
end;

procedure TformOptions.InitRigNames();
begin
   comboRig1Name.Items.Clear;
   comboRig2Name.Items.Clear;

   dmZlogGlobal.MakeRigList(comboRig1Name.Items);

   comboRig2Name.Items.Assign(comboRig1Name.Items);
end;

procedure TformOptions.buttonFullmatchSelectColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editFullmatchColor.Color;
   if ColorDialog1.Execute = True then begin
      editFullmatchColor.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions.buttonFullmatchInitColorClick(Sender: TObject);
begin
   editFullmatchColor.Color := clYellow;
end;

procedure TformOptions.buttonBSForeClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FBSColor[n].Font.Color;
   if ColorDialog1.Execute = True then begin
      FBSColor[n].Font.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions.buttonBSBackClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FBSColor[n].Color;
   if ColorDialog1.Execute = True then begin
      FBSColor[n].Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions.checkBSBoldClick(Sender: TObject);
var
   n: Integer;
begin
   n := TCheckBox(Sender).Tag;

   if TCheckBox(Sender).Checked = True then begin
      FBSColor[n].Font.Style := FBSColor[n].Font.Style + [fsBold];
   end
   else begin
      FBSColor[n].Font.Style := FBSColor[n].Font.Style - [fsBold];
   end;
end;

procedure TformOptions.buttonBSResetClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   FBSColor[n].Font.Color  := BandScopeDefaultColor[n].FForeColor;
   FBSColor[n].Color       := BandScopeDefaultColor[n].FBackColor;
   FBSBold[n].Checked      := BandScopeDefaultColor[n].FBold;
end;

end.
