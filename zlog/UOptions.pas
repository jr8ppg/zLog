unit UOptions;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls, Spin,
  Dialogs, Menus, FileCtrl,
  UIntegerDialog, UzLogConst, UzLogGlobal, Vcl.Buttons;

type
  TformOptions = class(TForm)
    PageControl: TPageControl;
    PrefTabSheet: TTabSheet;
    TabSheet2: TTabSheet;
    CWTabSheet: TTabSheet;
    VoiceTabSheet: TTabSheet;
    TabSheet5: TTabSheet;
    tbRigControl: TTabSheet;
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
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit9: TEdit;
    Edit8: TEdit;
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
    Edit10: TEdit;
    Edit1: TEdit;
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
    GroupBox5: TGroupBox;
    Button4: TButton;
    BackUpPathEdit: TEdit;
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
    tbMisc: TTabSheet;
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
    TabSheet1: TTabSheet;
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
    procedure Edit1Change(Sender: TObject);
    procedure CWBankClick(Sender: TObject);
    procedure cbCountDownClick(Sender: TObject);
    procedure cbQSYCountClick(Sender: TObject);
    procedure cbTransverter1Click(Sender: TObject);
    procedure comboRig1NameChange(Sender: TObject);
    procedure comboRig2NameChange(Sender: TObject);
    procedure checkUseQuickQSYClick(Sender: TObject);
    procedure buttonSuperCheckFolderRefClick(Sender: TObject);
  private
    TempVoiceFiles : array[1..10] of string;
    TempCurrentBank : integer;
    TempCWStrBank : array[1..maxbank,1..maxmaxstr] of string; // used temporarily while options window is open

    FTempClusterTelnet: TCommParam;
    FTempClusterCom: TCommParam;
    FTempZLinkTelnet: TCommParam;

    FQuickQSYCheck: array[1..8] of TCheckBox;
    FQuickQSYBand: array[1..8] of TComboBox;
    FQuickQSYMode: array[1..8] of TComboBox;
    procedure RenewCWStrBankDisp();
    procedure InitRigNames();
  public
    procedure RenewSettings; {Reads controls and updates Settings}
  end;

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

      Settings.CW.CQStrBank[1] := Edit9.Text;
      Settings.CW.CQStrBank[2] := Edit10.Text;

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

      Settings._clusterport := ClusterCombo.ItemIndex;
   //   Settings._clusterbaud := ClusterCOMSet.BaudCombo.ItemIndex;

      // RIG1
      Settings._rigport[1] := comboRig1Port.ItemIndex;
      Settings._rigname[1] := comboRig1Name.ItemIndex;
      Settings._rigspeed[1] := comboRig1Speed.ItemIndex;

      // RIG2
      Settings._rigport[2] := comboRig2Port.ItemIndex;
      Settings._rigname[2] := comboRig2Name.ItemIndex;
      Settings._rigspeed[2] := comboRig2Speed.ItemIndex;

      Settings._use_transceive_mode := checkUseTransceiveMode.Checked;

      Settings._ritclear := cbRITClear.Checked;

      Settings._zlinkport := ZLinkCombo.ItemIndex;
      Settings._pcname := editZLinkPcName.Text;
      Settings._syncserial := checkZLinkSyncSerial.Checked;

      Settings._pttenabled := PTTEnabledCheckBox.Checked;
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
   Edit1.Text := TempCWStrBank[TempCurrentBank, 1];
   Edit2.Text := TempCWStrBank[TempCurrentBank, 2];
   Edit3.Text := TempCWStrBank[TempCurrentBank, 3];
   Edit4.Text := TempCWStrBank[TempCurrentBank, 4];
   Edit5.Text := TempCWStrBank[TempCurrentBank, 5];
   Edit6.Text := TempCWStrBank[TempCurrentBank, 6];
   Edit7.Text := TempCWStrBank[TempCurrentBank, 7];
   Edit8.Text := TempCWStrBank[TempCurrentBank, 8];
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
      Edit9.Text := Settings.CW.CQStrBank[1];
      Edit10.Text := Settings.CW.CQStrBank[2];

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
      comboRig1Name.ItemIndex := Settings._rigname[1];
      comboRig1Speed.ItemIndex := Settings._rigspeed[1];

      // RIG2
      comboRig2Port.ItemIndex := Settings._rigport[2];
      comboRig2Name.ItemIndex := Settings._rigname[2];
      comboRig2Speed.ItemIndex := Settings._rigspeed[2];

      checkUseTransceiveMode.Checked := Settings._use_transceive_mode;

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
         FQuickQSYBand[i].Enabled := FQuickQSYCheck[i].Checked;
         FQuickQSYMode[i].Enabled := FQuickQSYCheck[i].Checked;
      end;

      // SuperCheck
      case Settings.FSuperCheck.FSuperCheckMethod of
         0: radioSuperCheck0.Checked := True;
         1: radioSuperCheck1.Checked := True;
         else radioSuperCheck2.Checked := True;
      end;
      editSuperCheckFolder.Text := Settings.FSuperCheck.FSuperCheckFolder;
   end;
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
   FQuickQSYCheck[2]    := checkUseQuickQSY02;
   FQuickQSYBand[2]     := comboQuickQsyBand02;
   FQuickQSYMode[2]     := comboQuickQsyMode02;
   FQuickQSYCheck[3]    := checkUseQuickQSY03;
   FQuickQSYBand[3]     := comboQuickQsyBand03;
   FQuickQSYMode[3]     := comboQuickQsyMode03;
   FQuickQSYCheck[4]    := checkUseQuickQSY04;
   FQuickQSYBand[4]     := comboQuickQsyBand04;
   FQuickQSYMode[4]     := comboQuickQsyMode04;
   FQuickQSYCheck[5]    := checkUseQuickQSY05;
   FQuickQSYBand[5]     := comboQuickQsyBand05;
   FQuickQSYMode[5]     := comboQuickQsyMode05;
   FQuickQSYCheck[6]    := checkUseQuickQSY06;
   FQuickQSYBand[6]     := comboQuickQsyBand06;
   FQuickQSYMode[6]     := comboQuickQsyMode06;
   FQuickQSYCheck[7]    := checkUseQuickQSY07;
   FQuickQSYBand[7]     := comboQuickQsyBand07;
   FQuickQSYMode[7]     := comboQuickQsyMode07;
   FQuickQSYCheck[8]    := checkUseQuickQSY08;
   FQuickQSYBand[8]     := comboQuickQsyBand08;
   FQuickQSYMode[8]     := comboQuickQsyMode08;
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

   TempCurrentBank := 1;

   OpListBox.Items.Assign(dmZlogGlobal.OpList);

   PageControl.ActivePage := PrefTabSheet;

   InitRigNames();
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

procedure TformOptions.CQRepEditKeyPress(Sender: TObject; var Key: char);
begin
   if not(SysUtils.CharInSet(Key, ['0' .. '9', '.'])) then begin
      Key := #0;
   end;
end;

procedure TformOptions.Edit1Change(Sender: TObject);
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
end;

procedure TformOptions.InitRigNames();
var
   i: Integer;
begin
   comboRig1Name.Items.Clear;
   comboRig2Name.Items.Clear;

   for i := Low(RIGNAMES) to High(RIGNAMES) do begin
      comboRig1Name.Items.Add(RIGNAMES[i]);
   end;

   for i := Low(ICOMLIST) to High(ICOMLIST) do begin
      comboRig1Name.Items.Add(ICOMLIST[i].name);
   end;

   comboRig1Name.Items.Add('JST-145');
   comboRig1Name.Items.Add('JST-245');
   comboRig1Name.Items.Add('Omni-Rig');

   comboRig2Name.Items.Assign(comboRig1Name.Items);
end;

end.
