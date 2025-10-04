unit UOptions2;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls, Spin, Vcl.Buttons, System.UITypes,
  Dialogs, Menus, FileCtrl, JvExStdCtrls, JvCombobox, JvColorCombo,
  Generics.Collections, Generics.Defaults, WinApi.CommCtrl, System.Math,
  UIntegerDialog, UzLogConst, UzLogSound, UOperatorEdit,
  UzLogOperatorInfo, UFreqPanel, UFreqMemDialog, UzFreqMemory;

type
  TformOptions2 = class(TForm)
    PageControl: TPageControl;
    tabsheetPreferences: TTabSheet;
    tabsheetCategories: TTabSheet;
    tabsheetCW: TTabSheet;
    tabsheetVoice: TTabSheet;
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    GroupBox1: TGroupBox;
    radioSingleOp: TRadioButton;
    ModeGroup: TRadioGroup;
    GroupBox2: TGroupBox;
    editMessage2: TEdit;
    editMessage3: TEdit;
    editMessage4: TEdit;
    editMessage5: TEdit;
    editMessage6: TEdit;
    editMessage7: TEdit;
    editMessage8: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
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
    CQRepEdit: TEdit;
    Label17: TLabel;
    FIFOCheck: TCheckBox;
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
    vEdit2: TEdit;
    vEdit3: TEdit;
    vEdit4: TEdit;
    vEdit5: TEdit;
    vEdit6: TEdit;
    vEdit7: TEdit;
    vEdit8: TEdit;
    vEdit1: TEdit;
    memo: TLabel;
    OpenDialog: TOpenDialog;
    vButton1: TButton;
    vButton2: TButton;
    vButton3: TButton;
    vButton4: TButton;
    vButton5: TButton;
    vButton6: TButton;
    vButton7: TButton;
    vButton8: TButton;
    act24: TCheckBox;
    act18: TCheckBox;
    act10: TCheckBox;
    CQZoneEdit: TEdit;
    IARUZoneEdit: TEdit;
    Label34: TLabel;
    Label35: TLabel;
    AllowDupeCheckBox: TCheckBox;
    SaveEvery: TSpinEdit;
    Label40: TLabel;
    Label41: TLabel;
    rbBankA: TRadioButton;
    rbBankB: TRadioButton;
    cbDispExchange: TCheckBox;
    cbJMode: TCheckBox;
    tabsheetMisc: TTabSheet;
    cbSaveWhenNoCW: TCheckBox;
    rgSearchAfter: TRadioGroup;
    spMaxSuperHit: TSpinEdit;
    Label47: TLabel;
    spBSExpire: TSpinEdit;
    Label48: TLabel;
    Label49: TLabel;
    cbUpdateThread: TCheckBox;
    rbRTTY: TRadioButton;
    cbCQSP: TCheckBox;
    cbAutoEnterSuper: TCheckBox;
    Label52: TLabel;
    Label53: TLabel;
    spSpotExpire: TSpinEdit;
    cbDisplayDatePartialCheck: TCheckBox;
    tabsheetQuickFunctions: TTabSheet;
    GroupBox8: TGroupBox;
    radioSuperCheck0: TRadioButton;
    radioSuperCheck1: TRadioButton;
    radioSuperCheck2: TRadioButton;
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
    groupBandscopeBands: TGroupBox;
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
    groupBandscopeInfoColors: TGroupBox;
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
    tabsheetBandScope2: TTabSheet;
    groupBandscopeSpotSource: TGroupBox;
    Label61: TLabel;
    editBSColor5: TEdit;
    buttonBSBack5: TButton;
    buttonBSReset5: TButton;
    editBSColor7: TEdit;
    buttonBSBack7: TButton;
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
    Label72: TLabel;
    Label73: TLabel;
    vEdit9: TEdit;
    vEdit10: TEdit;
    vButton9: TButton;
    vButton10: TButton;
    checkBsCurrent: TCheckBox;
    Label75: TLabel;
    editMessage11: TEdit;
    Label76: TLabel;
    editMessage12: TEdit;
    Label77: TLabel;
    vEdit11: TEdit;
    vButton11: TButton;
    Label78: TLabel;
    vEdit12: TEdit;
    vButton12: TButton;
    editBSColor8: TEdit;
    buttonBSBack8: TButton;
    buttonBSBack9: TButton;
    editBSColor9: TEdit;
    Label69: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    checkPaddleReverse: TCheckBox;
    GroupBox14: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    editCQMessage2: TEdit;
    editCQMessage3: TEdit;
    SideToneCheck: TCheckBox;
    GroupBox16: TGroupBox;
    buttonPlayVoice: TSpeedButton;
    buttonStopVoice: TSpeedButton;
    checkUseCQRamdomRepeat: TCheckBox;
    GroupBox19: TGroupBox;
    Label36: TLabel;
    Label37: TLabel;
    Label82: TLabel;
    vEdit14: TEdit;
    vEdit13: TEdit;
    vButton13: TButton;
    vButton14: TButton;
    groupBandscopeOptions1: TGroupBox;
    checkUseEstimatedMode: TCheckBox;
    checkShowOnlyInBandplan: TCheckBox;
    checkShowJAspots: TCheckBox;
    Label85: TLabel;
    VolumeSpinEdit: TSpinEdit;
    groupQsyAssist: TGroupBox;
    radioQsyNone: TRadioButton;
    radioQsyCountDown: TRadioButton;
    radioQsyCount: TRadioButton;
    Label86: TLabel;
    editQsyCountDownMinute: TSpinEdit;
    editQsyCountPerHour: TSpinEdit;
    Label87: TLabel;
    GroupBox22: TGroupBox;
    Label88: TLabel;
    editPartialCheckColor: TEdit;
    buttonPartialCheckForeColor: TButton;
    buttonPartialCheckInitColor: TButton;
    buttonPartialCheckBackColor: TButton;
    GroupBox23: TGroupBox;
    Label89: TLabel;
    editFocusedColor: TEdit;
    buttonFocusedBackColor: TButton;
    buttonFocusedInitColor: TButton;
    checkFocusedBold: TCheckBox;
    buttonFocusedForeColor: TButton;
    checkNotSendLeadingZeros: TCheckBox;
    Label91: TLabel;
    comboTxNo: TComboBox;
    GroupBox24: TGroupBox;
    OpListBox: TListBox;
    buttonOpAdd: TButton;
    buttonOpDelete: TButton;
    radioMultiOpMultiTx: TRadioButton;
    radioMultiOpSingleTx: TRadioButton;
    radioMultiOpTwoTx: TRadioButton;
    GroupBox13: TGroupBox;
    radioQslNone: TRadioButton;
    radioPseQsl: TRadioButton;
    radioNoQsl: TRadioButton;
    checkBsNewMulti: TCheckBox;
    checkUseLookupServer: TCheckBox;
    checkSetFreqAfterModeChange: TCheckBox;
    checkAlwaysChangeMode: TCheckBox;
    checkAcceptDuplicates: TCheckBox;
    checkDispLongDateTime: TCheckBox;
    checkBsAllBands: TCheckBox;
    groupPower: TGroupBox;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    editPowerH: TEdit;
    editPowerM: TEdit;
    editPowerL: TEdit;
    editPowerP: TEdit;
    checkSelectLastOperator: TCheckBox;
    checkApplyPowerCodeOnBandChange: TCheckBox;
    buttonOpEdit: TButton;
    checkOutputOutofPeriod: TCheckBox;
    checkUseContestPeriod: TCheckBox;
    groupQuickMemo: TGroupBox;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    editQuickMemo1: TEdit;
    editQuickMemo2: TEdit;
    editQuickMemo3: TEdit;
    editQuickMemo4: TEdit;
    editQuickMemo5: TEdit;
    groupQuickQSY: TGroupBox;
    checkSaveCurrentFreq: TCheckBox;
    buttonBSReset8: TButton;
    buttonBSReset9: TButton;
    checkShowDXspots: TCheckBox;
    groupBandscopeOptions2: TGroupBox;
    checkUseResume: TCheckBox;
    checkUseNumberLookup: TCheckBox;
    comboVoiceDevice: TComboBox;
    Label38: TLabel;
    checkUseKhzQsyCommand: TCheckBox;
    GroupBox6: TGroupBox;
    editMyLatitude: TEdit;
    editMyLongitude: TEdit;
    Label39: TLabel;
    Label42: TLabel;
    listviewFreqMemory: TListView;
    buttonFreqMemAdd: TButton;
    buttonFreqMemEdit: TButton;
    buttonFreqMemDelete: TButton;
    checkShowStartupWindow: TCheckBox;
    popupVoiceMenu: TPopupMenu;
    menuVoicePlay: TMenuItem;
    N1: TMenuItem;
    menuVoiceClear: TMenuItem;
    menuVoiceStop: TMenuItem;
    AgeEdit: TEdit;
    Label31: TLabel;
    groupBandscopeSpotReliability: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    editBSColorSrHigh: TEdit;
    editBSColorSrMiddle: TEdit;
    editBSColorSrLow: TEdit;
    buttonBSBackSrHigh: TButton;
    buttonBSBackSrMiddle: TButton;
    buttonBSBackSrLow: TButton;
    buttonBSResetSrHigh: TButton;
    buttonBSResetSrMiddle: TButton;
    buttonBSResetSrLow: TButton;
    checkUseReliability7: TCheckBox;
    checkUseReliability8: TCheckBox;
    checkUseReliability9: TCheckBox;
    groupReliability: TGroupBox;
    radioReliabilityHigh: TRadioButton;
    radioReliabilityMiddle: TRadioButton;
    procedure buttonOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buttonOpAddClick(Sender: TObject);
    procedure buttonOpDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure SpeedBarChange(Sender: TObject);
    procedure WeightBarChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vButtonClick(Sender: TObject);
    procedure CQRepEditKeyPress(Sender: TObject; var Key: Char);
    procedure editMessage1Change(Sender: TObject);
    procedure CWBankClick(Sender: TObject);
    procedure OnNeedSuperCheckLoad(Sender: TObject);
    procedure buttonFullmatchSelectColorClick(Sender: TObject);
    procedure buttonFullmatchInitColorClick(Sender: TObject);
    procedure buttonBSForeClick(Sender: TObject);
    procedure buttonBSBackClick(Sender: TObject);
    procedure checkBSBoldClick(Sender: TObject);
    procedure buttonBSResetClick(Sender: TObject);
    procedure buttonPlayVoiceClick(Sender: TObject);
    procedure buttonStopVoiceClick(Sender: TObject);
    procedure vAdditionalButtonClick(Sender: TObject);
    procedure radioQsyAssistClick(Sender: TObject);
    procedure buttonPartialCheckForeColorClick(Sender: TObject);
    procedure buttonPartialCheckBackColorClick(Sender: TObject);
    procedure buttonPartialCheckInitColorClick(Sender: TObject);
    procedure buttonFocusedBackColorClick(Sender: TObject);
    procedure buttonFocusedInitColorClick(Sender: TObject);
    procedure checkFocusedBoldClick(Sender: TObject);
    procedure buttonFocusedForeColorClick(Sender: TObject);
    procedure radioCategoryClick(Sender: TObject);
    procedure checkUseEstimatedModeClick(Sender: TObject);
    procedure buttonSpotterListClick(Sender: TObject);
    procedure buttonOpEditClick(Sender: TObject);
    procedure checkUseNumberLookupClick(Sender: TObject);
    procedure buttonFreqMemAddClick(Sender: TObject);
    procedure buttonFreqMemEditClick(Sender: TObject);
    procedure buttonFreqMemDeleteClick(Sender: TObject);
    procedure listviewFreqMemoryDblClick(Sender: TObject);
    procedure listviewFreqMemorySelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure vEditEnter(Sender: TObject);
    procedure vEditExit(Sender: TObject);
    procedure menuVoiceClearClick(Sender: TObject);
    procedure menuVoicePlayClick(Sender: TObject);
    procedure menuVoiceStopClick(Sender: TObject);
    procedure vAdditionalEditEnter(Sender: TObject);
    procedure vAdditionalEditExit(Sender: TObject);
    procedure vButtonEnter(Sender: TObject);
    procedure vButtonExit(Sender: TObject);
    procedure vAdditionalButtonEnter(Sender: TObject);
    procedure vAdditionalButtonExit(Sender: TObject);
    procedure vButtonContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure vAdditionalButtonContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    FOriginalHeight: Integer;
    FEditMode: Integer;
    FEditNumber: Integer;
    FActiveTab: Integer;
    FTempVoiceFiles : array[1..maxmessage] of string;
    FTempAdditionalVoiceFiles : array[2..3] of string;
    TempCurrentBank : integer;
    TempCWStrBank : array[1..maxbank,1..maxmessage] of string; // used temporarily while options window is open

    FTempFreqMemList: TFreqMemoryList;

    FBSColor: array[1..15] of TEdit;
    FBSBold: array[1..15] of TCheckBox;
    FBSUseReliability: array[1..15] of TCheckBox;

    FNeedSuperCheckLoad: Boolean;

    FQuickMemoText: array[1..5] of TEdit;

    FEditMessage: array[1..maxmessage] of TEdit;
    FEditAdditionalCQMessage: array[2..3] of TEdit;

    FVoiceEdit: array[1..maxmessage] of TEdit;
    FVoiceButton: array[1..maxmessage] of TButton;
    FVoiceSound: TWaveSound;
    FAdditionalVoiceEdit: array[2..3] of TEdit;
    FAdditionalVoiceButton: array[2..3] of TButton;

    procedure RenewCWStrBankDisp();
    procedure SetEditNumber(no: Integer);
    procedure InitVoice();
    procedure AddFreqMemList(D: TFreqMemory);
    procedure UpdateFreqMemList(listitem: TListItem);
  public
    procedure RenewSettings; {Reads controls and updates Settings}
    property EditMode: Integer read FEditMode write FEditMode;
    property EditNumber: Integer read FEditNumber write SetEditNumber;
    property NeedSuperCheckLoad: Boolean read FNeedSuperCheckLoad;
    property EditBank: Integer read TempCurrentBank write TempCurrentBank;
    property ActiveTab: Integer read FActiveTab write FActiveTab;
  end;

implementation

uses
  Main, UzLogCW, UComm, UClusterTelnetSet, UClusterCOMSet, UPortConfigDialog,
  UZlinkTelnetSet, UZLinkForm, URigControl, UPluginManager, USpotterListDlg,
  UzLogGlobal;

const
  BandScopeDefaultColor: array[1..15] of TColorSetting = (
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clRed;   FBackColor: clWhite; FBold: True ),
    ( FForeColor: clGreen; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clGreen; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: clWhite; FBold: True ),
    ( FForeColor: clBlack; FBackColor: $FFFFC0;  FBold: True ),
    ( FForeColor: clBlack; FBackColor: $C0FFFF; FBold: True ),
    ( FForeColor: clBlack; FBackColor: $FFD2FF;  FBold: True )
  );

{$R *.DFM}

procedure TformOptions2.radioCategoryClick(Sender: TObject);
var
   n: Integer;

   procedure OperatorsEnable(f: Boolean);
   begin
      OpListBox.Enabled := f;
      buttonOpAdd.Enabled := f;
      buttonOpEdit.Enabled := f;
      buttonOpDelete.Enabled := f;
      checkSelectLastOperator.Enabled := f;
      checkApplyPowerCodeOnBandChange.Enabled := f;
   end;

   function SelectTxNo(): Integer;
   begin
      Result := comboTxNo.Items.IndexOf(IntToStr(dmZLogGlobal.Settings._txnr));
      if Result = -1 then begin
         Result := 0;
      end;
   end;
begin
   n := TRadioButton(Sender).Tag;
   case n of
      // Single-Op
      0: begin
         comboTxNo.Enabled := False;
         comboTxNo.Items.CommaText := '0,1';
         comboTxNo.ItemIndex := SelectTxNo();
         OperatorsEnable(False);
      end;

      // Multi-Op/Multi-Tx
      1: begin
         comboTxNo.Enabled := True;
         comboTxNo.Items.CommaText := TXLIST_MM;
         comboTxNo.ItemIndex := SelectTxNo();
         OperatorsEnable(True);
      end;

      // Multi-Op/Single-Tx, Multi-Op/Two-Tx
      2, 3: begin
         comboTxNo.Enabled := True;
         comboTxNo.Items.CommaText := TXLIST_MS;
         comboTxNo.ItemIndex := SelectTxNo();
         OperatorsEnable(True);
      end;
   end;
end;

procedure TformOptions2.RenewSettings;
var
   r: double;
   i, j: integer;
begin
   with dmZLogGlobal do begin
      Settings._savewhennocw := cbSaveWhenNoCW.Checked;
      Settings._jmode := cbJMode.Checked;
      Settings._searchafter := rgSearchAfter.ItemIndex;
      Settings._renewbythread := cbUpdateThread.Checked;
      Settings._displaydatepartialcheck := cbDisplayDatePartialCheck.Checked;

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

      // My position
      Settings._mylatitude := editMyLatitude.Text;
      Settings._mylongitude := editMyLongitude.Text;

      Settings._mode := TContestMode(ModeGroup.ItemIndex);

      // Category
      if radioSingleOp.Checked = True then begin
         Settings._multiop := ccSingleOp;
      end
      else if radioMultiOpMultiTx.Checked = True then begin
         Settings._multiop := ccMultiOpMultiTx;
      end
      else if radioMultiOpSingleTx.Checked = True then begin
         Settings._multiop := ccMultiOpSingleTx;
      end
      else if radioMultiOpTwoTx.Checked = True then begin
         Settings._multiop := ccMultiOpTwoTx;
      end;

      // #TXNR
      Settings._txnr := StrToIntDef(comboTxNo.Text, 0);

      Settings._selectlastoperator := checkSelectLastOperator.Checked;
      Settings._applypoweronbandchg :=  checkApplyPowerCodeOnBandChange.Checked;

      Settings._prov := ProvEdit.Text;
      Settings._city := CityEdit.Text;
      Settings._cqzone := CQZoneEdit.Text;
      Settings._iaruzone := IARUZoneEdit.Text;
      Settings._age := AgeEdit.Text;
      Settings._PowerH := editPowerH.Text;
      Settings._PowerM := editPowerM.Text;
      Settings._PowerL := editPowerL.Text;
      Settings._PowerP := editPowerP.Text;

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

      for i := 1 to maxbank do begin
         for j := 1 to maxmessage do begin
            Settings.CW.CWStrBank[i, j] := TempCWStrBank[i, j];
         end;
      end;

      Settings.CW.AdditionalCQMessages[2] := editCQMessage2.Text;
      Settings.CW.AdditionalCQMessages[3] := editCQMessage3.Text;

      Settings._bsexpire := spBSExpire.Value;
      Settings._spotexpire := spSpotExpire.Value;

      r := Settings.CW._cqrepeat;
      Settings.CW._cqrepeat := StrToFloatDef(CQRepEdit.Text, r);

      Settings.CW._speed := SpeedBar.Position;
      Settings.CW._weight := WeightBar.Position;
      Settings.CW._FIFO := FIFOCheck.Checked;
      Settings.CW._sidetone := SideToneCheck.Checked;
      Settings.CW._sidetone_volume := VolumeSpinEdit.Value;
      Settings.CW._tonepitch := ToneSpinEdit.Value;
      Settings.CW._cqmax := CQmaxSpinEdit.Value;

      Settings.CW._cq_random_repeat := checkUseCQRamdomRepeat.Checked;
      Settings._switchcqsp := cbCQSP.Checked;

      if length(AbbrevEdit.Text) >= 3 then begin
         Settings.CW._zero := AbbrevEdit.Text[1];
         Settings.CW._one := AbbrevEdit.Text[2];
         Settings.CW._nine := AbbrevEdit.Text[3];
      end;

      // Send NR? automatically
      Settings.CW._send_nr_auto := checkSendNrAuto.Checked;

      // Not send leading zeros in serial number
      Settings.CW._not_send_leading_zeros := checkNotSendLeadingZeros.Checked;

      // Paddle reverse
      Settings.CW._paddlereverse := checkPaddleReverse.Checked;

      Settings._saveevery        := SaveEvery.Value;

      // QSL Default
      if radioQslNone.Checked = True then begin
         Settings._qsl_default   := qsNone;
      end
      else if radioPseQsl.Checked = True then begin
         Settings._qsl_default   := qsPseQsl;
      end
      else begin
         Settings._qsl_default   := qsNoQsl;
      end;

      // QSY Assist
      Settings._countdown        := radioQsyCountDown.Checked;
      Settings._qsycount         := radioQsyCount.Checked;
      Settings._countdownminute  := editQsyCountDownMinute.Value;
      Settings._countperhour     := editQsyCountPerHour.Value;

      Settings._allowdupe := AllowDupeCheckBox.Checked;
      Settings._output_outofperiod := checkOutputOutofPeriod.Checked;
      Settings._use_contest_period := checkUseContestPeriod.Checked;
      Settings.FDontShowStartupWindow := not checkShowStartupWindow.Checked;

      Settings._sameexchange := cbDispExchange.Checked;
      Settings._entersuperexchange := cbAutoEnterSuper.Checked;
      Settings._displongdatetime := checkDispLongDateTime.Checked;

      // Quick QSY
      FreqMemList.Assign(FTempFreqMemList);

      Settings.FUseKhzQsyCommand := checkUseKhzQsyCommand.Checked;

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
      Settings.FSuperCheck.FAcceptDuplicates := checkAcceptDuplicates.Checked;
      Settings.FSuperCheck.FFullMatchHighlight := checkHighlightFullmatch.Checked;
      Settings.FSuperCheck.FFullMatchColor := editFullmatchColor.Color;

      // Partial Check
      Settings.FPartialCheck.FCurrentBandForeColor := editPartialCheckColor.Font.Color;
      Settings.FPartialCheck.FCurrentBandBackColor := editPartialCheckColor.Color;

      // Accessibility
      Settings.FAccessibility.FFocusedForeColor := editFocusedColor.Font.Color;
      Settings.FAccessibility.FFocusedBackColor := editFocusedColor.Color;
      Settings.FAccessibility.FFocusedBold := checkFocusedBold.Checked;

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
      Settings._usebandscope_current := checkBsCurrent.Checked;
      Settings._usebandscope_newmulti := checkBsNewMulti.Checked;
      Settings._usebandscope_allbands := checkBsAllBands.Checked;

      for i := 1 to 15 do begin
         if FBSColor[i] <> nil then begin
            Settings._bandscopecolor[i].FForeColor := FBSColor[i].Font.Color;
            Settings._bandscopecolor[i].FBackColor := FBSColor[i].Color;
         end;
         if FBSBold[i] = nil then begin
            Settings._bandscopecolor[i].FBold      := False;
         end
         else begin
            Settings._bandscopecolor[i].FBold      := FBSBold[i].Checked;
         end;
         if FBSUseReliability[i] = nil then begin
            Settings._bandscopecolor[i].FUseReliability := False;
         end
         else begin
            Settings._bandscopecolor[i].FUseReliability := FBSUseReliability[i].Checked;
         end;
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

      // BandScope Options
      Settings._bandscope_use_estimated_mode := checkUseEstimatedMode.Checked;      // 周波数からのモードの推定
      Settings._bandscope_show_only_in_bandplan := checkShowOnlyInBandplan.Checked; // バンド内のみ
      Settings._bandscope_show_ja_spots := checkShowJAspots.Checked;                // JAを表示
      Settings._bandscope_show_dx_spots := checkShowDXspots.Checked;                // DXを表示
      Settings._bandscope_use_number_lookup := checkUseNumberLookup.Checked;        // Number Lookup
      Settings._bandscope_use_lookup_server := checkUseLookupServer.Checked;        // Lookup Server
      Settings._bandscope_setfreq_after_mode_change := checkSetFreqAfterModeChange.Checked;  // モード変更後周波数セット
      Settings._bandscope_always_change_mode := checkAlwaysChangeMode.Checked;      // 常にモード変更
      Settings._bandscope_save_current_freq := checkSaveCurrentFreq.Checked;        // S&P時、現在周波数を保存する

      // BandScope Options2
      Settings._bandscope_use_resume := checkUseResume.Checked;                     // レジューム使う

      // Reliability
      Settings._bandscope_initial_reliability_high := radioReliabilityHigh.Checked;

      // Quick Memo
      for i := 1 to 5 do begin
         Settings.FQuickMemoText[i] := Trim(FQuickMemoText[i].Text);
      end;

      // Voice Memory
      for i := 1 to maxmessage do begin
         Settings.FSoundFiles[i] := FTempVoiceFiles[i];
         Settings.FSoundComments[i] := FVoiceEdit[i].Text;
      end;
      for i := 2 to 3 do begin
         Settings.FAdditionalSoundFiles[i] := FTempAdditionalVoiceFiles[i];
         Settings.FAdditionalSoundComments[i] := FAdditionalVoiceEdit[i].Text;
      end;
   end;
end;

procedure TformOptions2.buttonOKClick(Sender: TObject);
begin
   // 入力された設定を保存
   RenewSettings;

   // 各種フォルダ作成
   dmZLogGlobal.CreateFolders();

   ModalResult := mrOK;
end;

procedure TformOptions2.RenewCWStrBankDisp;
var
   i: Integer;
begin
   for i := 1 to maxmessage do begin
      FEditMessage[i].Text := TempCWStrBank[TempCurrentBank, i];
      if dmZLogGlobal.Settings.CW.CWStrImported[TempCurrentBank, i] = True then begin
         FEditMessage[i].ReadOnly := dmZLogGlobal.Settings.ReadOnlyParamImported;
         if FEditMessage[i].ReadOnly = True then begin
            FEditMessage[i].Color := clBtnFace; // gray
         end
         else begin
            FEditMessage[i].Color := $00EADEFF; // light pink
         end;
      end
      else begin
         FEditMessage[i].Color := clWindow;
         FEditMessage[i].ReadOnly := False;
      end;
   end;

   for i := 2 to 3 do begin
      if dmZLogGlobal.Settings.CW.AdditionalCQMessagesImported[i] = True then begin
         FEditAdditionalCQMessage[i].ReadOnly := dmZLogGlobal.Settings.ReadOnlyParamImported;
         if FEditAdditionalCQMessage[i].ReadOnly = True then begin
            FEditAdditionalCQMessage[i].Color := clBtnFace; // gray
         end
         else begin
            FEditAdditionalCQMessage[i].Color := $00EADEFF; // light pink
         end;
      end
      else begin
         FEditAdditionalCQMessage[i].Color := clWindow;
         FEditAdditionalCQMessage[i].ReadOnly := False;
      end;
   end;
end;

procedure TformOptions2.FormShow(Sender: TObject);
var
   i, j: integer;
begin
   with dmZlogGlobal do begin
      cbSaveWhenNoCW.Checked := Settings._savewhennocw;
      cbJMode.Checked := Settings._jmode;

      rgSearchAfter.ItemIndex := Settings._searchafter;
      spMaxSuperHit.Value := Settings._maxsuperhit;
      spBSExpire.Value := Settings._bsexpire;
      spSpotExpire.Value := Settings._spotexpire;
      cbUpdateThread.Checked := Settings._renewbythread;
      cbDisplayDatePartialCheck.Checked := Settings._displaydatepartialcheck;

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

      // My position
      editMyLatitude.Text := Settings._mylatitude;
      editMyLongitude.Text := Settings._mylongitude;

      // Category
      if ContestCategory = ccSingleOp then begin
         radioSingleOp.Checked := True;
      end
      else if ContestCategory = ccMultiOpMultiTx then begin
         radioMultiOpMultiTx.Checked := True;
      end
      else if ContestCategory = ccMultiOpSingleTx then begin
         radioMultiOpSingleTx.Checked := True;
      end
      else if ContestCategory = ccMultiOpTwoTx then begin
         radioMultiOpTwoTx.Checked := True;
      end;

      ModeGroup.ItemIndex := Integer(Settings._mode);
      { OpListBox.Items := OpList; }

      for i := 1 to maxbank do begin
         for j := 1 to maxmessage do begin
            TempCWStrBank[i, j] := Settings.CW.CWStrBank[i, j];
         end;
      end;

      case TempCurrentBank of
         1:
            rbBankA.Checked := True;
         2:
            rbBankB.Checked := True;
         3:
            rbRTTY.Checked := True;
      end;

      RenewCWStrBankDisp;

      editCQMessage2.Text := Settings.CW.AdditionalCQMessages[2];
      editCQMessage3.Text := Settings.CW.AdditionalCQMessages[3];

      CQRepEdit.Text := FloatToStrF(Settings.CW._cqrepeat, ffFixed, 3, 1);
      SpeedBar.Position := Settings.CW._speed;
      SpeedLabel.Caption := IntToStr(Settings.CW._speed) + ' wpm';
      WeightBar.Position := Settings.CW._weight;
      WeightLabel.Caption := IntToStr(Settings.CW._weight) + ' %';
      FIFOCheck.Checked := Settings.CW._FIFO;
      SideToneCheck.Checked := Settings.CW._sidetone;
      VolumeSpinEdit.Value := Settings.CW._sidetone_volume;
      ToneSpinEdit.Value := Settings.CW._tonepitch;
      CQmaxSpinEdit.Value := Settings.CW._cqmax;
      AbbrevEdit.Text := Settings.CW._zero + Settings.CW._one + Settings.CW._nine;

      checkSelectLastOperator.Checked := Settings._selectlastoperator;
      checkApplyPowerCodeOnBandChange.Checked := Settings._applypoweronbandchg;

      ProvEdit.Text := Settings._prov;
      CityEdit.Text := Settings._city;
      CQZoneEdit.Text := Settings._cqzone;
      IARUZoneEdit.Text := Settings._iaruzone;
      AgeEdit.Text := Settings._age;

      if Settings.ProvCityImported = True then begin
         ProvEdit.ReadOnly := Settings.ReadOnlyParamImported;
         CityEdit.ReadOnly := Settings.ReadOnlyParamImported;
         CQZoneEdit.ReadOnly := Settings.ReadOnlyParamImported;
         IARUZoneEdit.ReadOnly := Settings.ReadOnlyParamImported;
         AgeEdit.ReadOnly := Settings.ReadOnlyParamImported;

         if ProvEdit.ReadOnly = True then begin
            ProvEdit.Color := clBtnFace;
            CityEdit.Color := clBtnFace;
            CQZoneEdit.Color := clBtnFace;
            IARUZoneEdit.Color := clBtnFace;
            AgeEdit.Color := clBtnFace;
         end
         else begin
            ProvEdit.Color := ifthen(ProvEdit.Text = '', $00EADEFF, clWindow);
            CityEdit.Color := ifthen(CityEdit.Text = '', $00EADEFF, clWindow);
            CQZoneEdit.Color := ifthen(CQZoneEdit.Text = '', $00EADEFF, clWindow);
            IARUZoneEdit.Color := ifthen(IARUZoneEdit.Text = '', $00EADEFF, clWindow);
            AgeEdit.Color := ifthen(AgeEdit.Text = '', $00EADEFF, clWindow);
         end;
      end
      else begin
         ProvEdit.Color := ifthen(ProvEdit.Text = '', $00EADEFF, clWindow);
         CityEdit.Color := ifthen(CityEdit.Text = '', $00EADEFF, clWindow);
         CQZoneEdit.Color := ifthen(CQZoneEdit.Text = '', $00EADEFF, clWindow);
         IARUZoneEdit.Color := ifthen(IARUZoneEdit.Text = '', $00EADEFF, clWindow);
         AgeEdit.Color := ifthen(AgeEdit.Text = '', $00EADEFF, clWindow);
         ProvEdit.ReadOnly := False;
         CityEdit.ReadOnly := False;
         CQZoneEdit.ReadOnly := False;
         IARUZoneEdit.ReadOnly := False;
         AgeEdit.ReadOnly := False;
      end;

      editPowerH.Text := Settings._PowerH;
      editPowerM.Text := Settings._PowerM;
      editPowerL.Text := Settings._PowerL;
      editPowerP.Text := Settings._PowerP;

      AllowDupeCheckBox.Checked := Settings._allowdupe;
      checkOutputOutofPeriod.Checked := Settings._output_outofperiod;
      checkUseContestPeriod.Checked := Settings._use_contest_period;

      checkShowStartupWindow.Checked := not Settings.FDontShowStartupWindow;

      SaveEvery.Value := Settings._saveevery;

      // Sent欄は表示専用
      SentEdit.Text := Settings._sentstr;

      checkUseCQRamdomRepeat.Checked := Settings.CW._cq_random_repeat;
      cbCQSP.Checked := Settings._switchcqsp;

      // Send NR? automatically
      checkSendNrAuto.Checked := Settings.CW._send_nr_auto;

      // Not send leading zeros in serial number
      checkNotSendLeadingZeros.Checked := Settings.CW._not_send_leading_zeros;

      // Paddle reverse
      checkPaddleReverse.Checked := Settings.CW._paddlereverse;

      // QSL Default
      if Settings._qsl_default = qsNone then begin
         radioQslNone.Checked := True;
      end
      else if Settings._qsl_default = qsPseQsl then begin
         radioPseQsl.Checked := True;
      end
      else begin
         radioNoQsl.Checked := True;
      end;

      // QSY Assist
      radioQsyNone.Checked          := True;
      radioQsyCountDown.Checked     := Settings._countdown;
      radioQsyCount.Checked         := Settings._qsycount;
      editQsyCountDownMinute.Value  := Settings._countdownminute;
      editQsyCountPerHour.Value     := Settings._countperhour;

      cbDispExchange.Checked := Settings._sameexchange;
      cbAutoEnterSuper.Checked := Settings._entersuperexchange;
      checkDispLongDateTime.Checked := Settings._displongdatetime;

      // Quick QSY
      FTempFreqMemList.Assign(FreqMemList);

      checkUseKhzQsyCommand.Checked := Settings.FUseKhzQsyCommand;

      // SuperCheck
      case Settings.FSuperCheck.FSuperCheckMethod of
         0: radioSuperCheck0.Checked := True;
         1: radioSuperCheck1.Checked := True;
         else radioSuperCheck2.Checked := True;
      end;
      checkAcceptDuplicates.Checked := Settings.FSuperCheck.FAcceptDuplicates;
      checkHighlightFullmatch.Checked := Settings.FSuperCheck.FFullMatchHighlight;
      editFullmatchColor.Color := Settings.FSuperCheck.FFullMatchColor;

      // Partial Check
      editPartialCheckColor.Font.Color := Settings.FPartialCheck.FCurrentBandForeColor;
      editPartialCheckColor.Color := Settings.FPartialCheck.FCurrentBandBackColor;

      // Accessibility
      editFocusedColor.Font.Color := Settings.FAccessibility.FFocusedForeColor;
      editFocusedColor.Color := Settings.FAccessibility.FFocusedBackColor;
      checkFocusedBold.Checked := Settings.FAccessibility.FFocusedBold;

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
      checkBsCurrent.Checked := Settings._usebandscope_current;
      checkBsNewMulti.Checked := Settings._usebandscope_newmulti;
      checkBsAllBands.Checked := Settings._usebandscope_allbands;

      for i := 1 to 15 do begin
         if FBSColor[i] <> nil then begin
            FBSColor[i].Font.Color := Settings._bandscopecolor[i].FForeColor;
            FBSColor[i].Color      := Settings._bandscopecolor[i].FBackColor;
         end;
         if FBSBold[i] <> nil then begin
            FBSBold[i].Checked     := Settings._bandscopecolor[i].FBold;
         end;
         if FBSUseReliability[i] <> nil then begin
            FBSUseReliability[i].Checked := Settings._bandscopecolor[i].FUseReliability;
         end;
      end;

      // Spot鮮度表示
      case Settings._bandscope_freshness_mode of
         0: radioFreshness1.Checked := True;
         1: radioFreshness2.Checked := True;
         2: radioFreshness3.Checked := True;
         3: radioFreshness4.Checked := True;
         else radioFreshness1.Checked := True;
      end;

      // BandScope Options
      checkUseEstimatedMode.Checked := Settings._bandscope_use_estimated_mode;      // 周波数からのモードの推定
      checkShowOnlyInBandplan.Checked := Settings._bandscope_show_only_in_bandplan; // バンド内のみ
      checkShowJAspots.Checked := Settings._bandscope_show_ja_spots;                // JAを表示
      checkShowDXspots.Checked := Settings._bandscope_show_dx_spots;                // DXを表示
      checkUseNumberLookup.Checked := Settings._bandscope_use_number_lookup;        // Number Lookup
      checkUseLookupServer.Checked := Settings._bandscope_use_lookup_server;        // Lookup Server
      checkSetFreqAfterModeChange.Checked := Settings._bandscope_setfreq_after_mode_change;  // モード変更後周波数セット
      checkAlwaysChangeMode.Checked := Settings._bandscope_always_change_mode;      // 常にモード変更
      checkSaveCurrentFreq.Checked := Settings._bandscope_save_current_freq;        // S&P時、現在周波数を保存する

      // BandScope Options2
      checkUseResume.Checked := Settings._bandscope_use_resume;                     // レジューム使う

      // Reliability
      radioReliabilityHigh.Checked := Settings._bandscope_initial_reliability_high;
      radioReliabilityMiddle.Checked := not Settings._bandscope_initial_reliability_high;

      // 1Radio時のみ設定可能とする
      if Settings._operate_style = os1Radio then begin
         checkSaveCurrentFreq.Enabled := True;
      end
      else begin
         checkSaveCurrentFreq.Enabled := False;
      end;

      checkUseEstimatedModeClick(nil);
      checkUseNumberLookupClick(nil);

      // Quick Memo
      for i := 1 to 5 do begin
         FQuickMemoText[i].Text := Settings.FQuickMemoText[i];
      end;

      // Voice Memory
      for i := 1 to maxmessage do begin
         FTempVoiceFiles[i] := Settings.FSoundFiles[i];
         if FTempVoiceFiles[i] = '' then begin
            FVoiceButton[i].Caption := 'select';
         end
         else begin
            FVoiceButton[i].Caption := ExtractFileName(FTempVoiceFiles[i]);
         end;
         FVoiceEdit[i].Text := Settings.FSoundComments[i];
      end;
      for i := 2 to 3 do begin
         FTempAdditionalVoiceFiles[i] := Settings.FAdditionalSoundFiles[i];
         if FTempAdditionalVoiceFiles[i] = '' then begin
            FAdditionalVoiceButton[i].Caption := 'select';
         end
         else begin
            FAdditionalVoiceButton[i].Caption := ExtractFileName(FTempAdditionalVoiceFiles[i]);
         end;
         FAdditionalVoiceEdit[i].Text := Settings.FAdditionalSoundComments[i];
      end;
   end;

   if comboVoiceDevice.Items.Count > 0 then begin
      comboVoiceDevice.ItemIndex := 0;
   end;

   if FEditMode = 0 then begin   // 通常モード
      tabsheetPreferences.TabVisible := True;
      tabsheetCategories.TabVisible := True;
      tabsheetCW.TabVisible := True;
      tabsheetVoice.TabVisible := True;
      tabsheetMisc.TabVisible := True;
      tabsheetQuickFunctions.TabVisible := True;
      tabsheetBandScope1.TabVisible := True;
      tabsheetBandScope2.TabVisible := True;
   end
   else if FEditMode = 1 then begin // CW
      PageControl.ActivePage := tabsheetCW;

      tabsheetPreferences.TabVisible := False;
      tabsheetCategories.TabVisible := False;
      tabsheetCW.TabVisible := True;
      tabsheetVoice.TabVisible := False;
      tabsheetMisc.TabVisible := False;
      tabsheetQuickFunctions.TabVisible := False;
      tabsheetBandScope1.TabVisible := False;
      tabsheetBandScope2.TabVisible := False;

      if FEditNumber > 0 then begin
         FEditMessage[FEditNumber].SetFocus;
      end;
   end
   else if FEditMode = 2 then begin // Voice
      PageControl.ActivePage := tabsheetVoice;

      tabsheetPreferences.TabVisible := False;
      tabsheetCategories.TabVisible := False;
      tabsheetCW.TabVisible := False;
      tabsheetVoice.TabVisible := True;
      tabsheetMisc.TabVisible := False;
      tabsheetQuickFunctions.TabVisible := False;
      tabsheetBandScope1.TabVisible := False;
      tabsheetBandScope2.TabVisible := False;

      if FEditNumber > 0 then begin
         FVoiceButton[FEditNumber].SetFocus();
      end;
   end
   else if FEditMode = 3 then begin
      PageControl.ActivePageIndex := FActiveTab;
   end;

   FNeedSuperCheckLoad := False;

   if radioSingleOp.Checked = True then begin
      radioCategoryClick(radioSingleOp);
   end
   else if radioMultiOpMultiTx.Checked = True then begin
      radioCategoryClick(radioMultiOpMultiTx);
   end
   else if radioMultiOpSingleTx.Checked = True then begin
      radioCategoryClick(radioMultiOpSingleTx);
   end
   else if radioMultiOpTwoTx.Checked = True then begin
      radioCategoryClick(radioMultiOpTwoTx);
   end;

   // Quick QSY
   for i := 0 to FTempFreqMemList.Count - 1 do begin
      AddFreqMemList(FTempFreqMemList[i]);
   end;
   listviewFreqMemory.Selected := nil;
   buttonFreqMemAdd.Enabled := True;
   buttonFreqMemEdit.Enabled := False;
   buttonFreqMemDelete.Enabled := False;
end;

procedure TformOptions2.buttonOpAddClick(Sender: TObject);
var
   F: TformOperatorEdit;
   obj: TOperatorInfo;
   op: TOperatorInfo;
begin
   F := TformOperatorEdit.Create(Self);
   try
      if F.ShowModal() <> mrOK then begin
         Exit;
      end;

      obj := TOperatorInfo.Create();
      F.GetObject(obj);

      op := dmZLogGlobal.OpList.ObjectOf(obj.Callsign);
      if op = nil then begin
         OpListBox.Items.AddObject(obj.Callsign, obj);
         dmZLogGlobal.OpList.Add(obj);
      end
      else begin
         op.Assign(obj);
         obj.Free();
      end;
   finally
      F.Release();
   end;
end;

procedure TformOptions2.buttonOpEditClick(Sender: TObject);
var
   F: TformOperatorEdit;
   obj: TOperatorInfo;
begin
   if OpListBox.ItemIndex = -1 then begin
      Exit;
   end;

   F := TformOperatorEdit.Create(Self);
   try
      obj := TOperatorInfo(OpListBox.Items.Objects[OpListBox.ItemIndex]);

      F.SetObject(obj);

      if F.ShowModal() <> mrOK then begin
         Exit;
      end;

      F.GetObject(obj);

   finally
      F.Free();
   end;
end;

procedure TformOptions2.buttonOpDeleteClick(Sender: TObject);
var
   obj: TOperatorInfo;
   i: Integer;
begin
   if OpListBox.ItemIndex = -1 then begin
      Exit;
   end;
   obj := TOperatorInfo(OpListBox.Items.Objects[OpListBox.ItemIndex]);
   OpListBox.Items.Delete(OpListBox.ItemIndex);
   i := dmZLogGlobal.OpList.IndexOf(obj);
   if i >= 0 then begin
      dmZLogGlobal.OpList.Delete(i);
   end;
end;

procedure TformOptions2.FormCreate(Sender: TObject);
var
   i: integer;
   rc: TRect;
begin
   FOriginalHeight := ClientHeight;
   PageControl.MultiLine := dmZLogGlobal.Settings.FUseMultiLineTabs;
   SendMessage(PageControl.Handle, TCM_GETITEMRECT, 0, LPARAM(@rc));

   if (PageControl.MultiLine = True) then begin
      ClientHeight := FOriginalHeight + (rc.Bottom - rc.Top);
   end
   else begin
      ClientHeight := FOriginalHeight;
   end;

   // BandScope
   FBSColor[1] := editBSColor1;
   FBSColor[2] := editBSColor2;
   FBSColor[3] := editBSColor3;
   FBSColor[4] := editBSColor4;
   FBSColor[5] := editBSColor5;
   FBSColor[6] := nil;
   FBSColor[7] := editBSColor7;
   FBSColor[8] := editBSColor8;
   FBSColor[9] := editBSColor9;
   FBSColor[10] := editBSColorSrHigh;
   FBSColor[11] := nil;
   FBSColor[12] := nil;
   FBSColor[13] := editBSColorSrHigh;
   FBSColor[14] := editBSColorSrMiddle;
   FBSColor[15] := editBSColorSrLow;
   FBSBold[1] := checkBSBold1;
   FBSBold[2] := checkBSBold2;
   FBSBold[3] := checkBSBold3;
   FBSBold[4] := checkBSBold4;
   FBSBold[5] := nil;
   FBSBold[6] := nil;
   FBSBold[7] := nil;
   FBSBold[8] := nil;
   FBSBold[9] := nil;
   FBSBold[10] := nil;
   FBSBold[11] := nil;
   FBSBold[12] := nil;
   FBSBold[13] := nil;
   FBSBold[14] := nil;
   FBSBold[15] := nil;
   FBSUseReliability[1] := nil;
   FBSUseReliability[2] := nil;
   FBSUseReliability[3] := nil;
   FBSUseReliability[4] := nil;
   FBSUseReliability[5] := nil;
   FBSUseReliability[6] := nil;
   FBSUseReliability[7] := checkUseReliability7;
   FBSUseReliability[8] := checkUseReliability8;
   FBSUseReliability[9] := checkUseReliability9;
   FBSUseReliability[10] := nil;
   FBSUseReliability[11] := nil;
   FBSUseReliability[12] := nil;
   FBSUseReliability[13] := nil;
   FBSUseReliability[14] := nil;
   FBSUseReliability[15] := nil;

   // Quick QSY
   FTempFreqMemList := TFreqMemoryList.Create();

   // Quick Memo
   FQuickMemoText[1] := editQuickMemo1;
   FQuickMemoText[2] := editQuickMemo2;
   FQuickMemoText[3] := editQuickMemo3;
   FQuickMemoText[4] := editQuickMemo4;
   FQuickMemoText[5] := editQuickMemo5;

   // CW/RTTY
   FEditMessage[1] := editMessage1;
   FEditMessage[2] := editMessage2;
   FEditMessage[3] := editMessage3;
   FEditMessage[4] := editMessage4;
   FEditMessage[5] := editMessage5;
   FEditMessage[6] := editMessage6;
   FEditMessage[7] := editMessage7;
   FEditMessage[8] := editMessage8;
   FEditMessage[9] := editMessage9;
   FEditMessage[10] := editMessage10;
   FEditMessage[11] := editMessage11;
   FEditMessage[12] := editMessage12;

   FEditAdditionalCQMessage[2] := editCQMessage2;
   FEditAdditionalCQMessage[3] := editCQMessage3;

   // Voice Memory
   InitVoice();

   TempCurrentBank := 1;

   // OpList
   for i := 0 to dmZlogGlobal.OpList.Count - 1 do begin
      OpListBox.Items.AddObject(dmZlogGlobal.OpList[i].Callsign, dmZlogGlobal.OpList[i]);
   end;

   PageControl.ActivePage := tabsheetPreferences;

   FEditMode := 0;
   FEditNumber := 0;

   FNeedSuperCheckLoad := False;
end;

procedure TformOptions2.buttonCancelClick(Sender: TObject);
begin
//   Close;
end;

procedure TformOptions2.SpeedBarChange(Sender: TObject);
begin
   SpeedLabel.Caption := IntToStr(SpeedBar.Position) + ' wpm';
end;

procedure TformOptions2.WeightBarChange(Sender: TObject);
begin
   WeightLabel.Caption := IntToStr(WeightBar.Position) + ' %';
end;

procedure TformOptions2.FormDestroy(Sender: TObject);
begin
   FTempFreqMemList.Free();
   FVoiceSound.Free();
end;

procedure TformOptions2.vButtonEnter(Sender: TObject);
begin
   popupVoiceMenu.Tag := TButton(Sender).Tag;
end;

procedure TformOptions2.vButtonExit(Sender: TObject);
begin
   popupVoiceMenu.Tag := 0;
end;

procedure TformOptions2.vAdditionalButtonEnter(Sender: TObject);
begin
   popupVoiceMenu.Tag := TButton(Sender).Tag + 100;
end;

procedure TformOptions2.vAdditionalButtonExit(Sender: TObject);
begin
   popupVoiceMenu.Tag := 0;
end;

procedure TformOptions2.vButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
   popupVoiceMenu.Tag := TButton(Sender).Tag;
end;

procedure TformOptions2.vAdditionalButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
   popupVoiceMenu.Tag := TButton(Sender).Tag + 100;
end;

procedure TformOptions2.vButtonClick(Sender: TObject);
begin
   OpenDialog.InitialDir := dmZLogGlobal.SoundPath;
   if OpenDialog.Execute then begin
      FTempVoiceFiles[TButton(Sender).Tag] := OpenDialog.filename;
      TLabel(Sender).Caption := ExtractFileName(OpenDialog.filename);
   end;
end;

procedure TformOptions2.vEditExit(Sender: TObject);
begin
   popupVoiceMenu.Tag := 0;
end;

procedure TformOptions2.vAdditionalEditEnter(Sender: TObject);
begin
   popupVoiceMenu.Tag := TEdit(Sender).Tag + 100;
end;

procedure TformOptions2.vAdditionalEditExit(Sender: TObject);
begin
   popupVoiceMenu.Tag := 0;
end;

procedure TformOptions2.vEditEnter(Sender: TObject);
begin
   popupVoiceMenu.Tag := TEdit(Sender).Tag;
end;

procedure TformOptions2.vAdditionalButtonClick(Sender: TObject);
begin
   OpenDialog.InitialDir := dmZLogGlobal.SoundPath;
   if OpenDialog.Execute then begin
      FTempAdditionalVoiceFiles[TButton(Sender).Tag] := OpenDialog.filename;
      TLabel(Sender).Caption := ExtractFileName(OpenDialog.filename);
   end;
end;

procedure TformOptions2.radioQsyAssistClick(Sender: TObject);
var
   n: Integer;
begin
   n := TRadioButton(Sender).Tag;
   case n of
      // None
      0: begin
         editQsyCountDownMinute.Enabled := False;
         editQsyCountPerHour.Enabled := False;
      end;

      // Count down
      1: begin
         editQsyCountDownMinute.Enabled := True;
         editQsyCountPerHour.Enabled := False;
         editQsyCountDownMinute.SetFocus();
      end;

      // QSY Count / hr
      2: begin
         editQsyCountDownMinute.Enabled := False;
         editQsyCountPerHour.Enabled := True;
         editQsyCountPerHour.SetFocus();
      end;
   end;
end;

procedure TformOptions2.OnNeedSuperCheckLoad(Sender: TObject);
begin
   FNeedSuperCheckLoad := True;
end;

procedure TformOptions2.CQRepEditKeyPress(Sender: TObject; var Key: char);
begin
   if (Key < Char(Ord('0'))) then begin
      Exit;
   end;

   if not(SysUtils.CharInSet(Key, ['0' .. '9', '.'])) then begin
      Key := #0;
   end;
end;

procedure TformOptions2.editMessage1Change(Sender: TObject);
var
   i: integer;
begin
   i := TEdit(Sender).Tag;
   TempCWStrBank[TempCurrentBank, i] := TEdit(Sender).Text;
end;

procedure TformOptions2.CWBankClick(Sender: TObject);
begin
   TempCurrentBank := TRadioButton(Sender).Tag;
   RenewCWStrBankDisp;
end;

procedure TformOptions2.checkUseEstimatedModeClick(Sender: TObject);
var
   f: Boolean;
begin
   f := checkUseEstimatedMode.Checked;
   checkAlwaysChangeMode.Enabled := f;
   checkSetFreqAfterModeChange.Enabled := f;
end;

procedure TformOptions2.checkUseNumberLookupClick(Sender: TObject);
var
   f: Boolean;
begin
   f := checkUseNumberLookup.Checked;
   checkUseLookupServer.Enabled := f;
end;

procedure TformOptions2.SetEditNumber(no: Integer);
begin
   if (no >= 1) and (no <= 12) then begin
      FEditNumber := no;
   end;
   if (no = 101) then begin
      FEditNumber := 1;
   end;
   if (no = 102) then begin
      FEditNumber := 1;
   end;
   if (no = 103) then begin
      FEditNumber := 1;
   end;
end;

procedure TformOptions2.buttonFullmatchSelectColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editFullmatchColor.Color;
   if ColorDialog1.Execute = True then begin
      editFullmatchColor.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.buttonFullmatchInitColorClick(Sender: TObject);
begin
   editFullmatchColor.Color := clYellow;
end;

procedure TformOptions2.buttonBSForeClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FBSColor[n].Font.Color;
   if ColorDialog1.Execute = True then begin
      FBSColor[n].Font.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.buttonBSBackClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   ColorDialog1.Color := FBSColor[n].Color;
   if ColorDialog1.Execute = True then begin
      FBSColor[n].Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.checkBSBoldClick(Sender: TObject);
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

procedure TformOptions2.buttonBSResetClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;

   FBSColor[n].Font.Color  := BandScopeDefaultColor[n].FForeColor;
   FBSColor[n].Color       := BandScopeDefaultColor[n].FBackColor;
   if FBSBold[n] <> nil then begin
      FBSBold[n].Checked      := BandScopeDefaultColor[n].FBold;
   end;
   if FBSUseReliability[n] <> nil then begin
      FBSUseReliability[n].Checked := False;
   end;
end;

procedure TformOptions2.InitVoice();
var
   L: TStringList;
begin
   FVoiceEdit[1] := vEdit1;
   FVoiceEdit[2] := vEdit2;
   FVoiceEdit[3] := vEdit3;
   FVoiceEdit[4] := vEdit4;
   FVoiceEdit[5] := vEdit5;
   FVoiceEdit[6] := vEdit6;
   FVoiceEdit[7] := vEdit7;
   FVoiceEdit[8] := vEdit8;
   FVoiceEdit[9] := vEdit9;
   FVoiceEdit[10] := vEdit10;
   FVoiceEdit[11] := vEdit11;
   FVoiceEdit[12] := vEdit12;
   FVoiceButton[1] := vButton1;
   FVoiceButton[2] := vButton2;
   FVoiceButton[3] := vButton3;
   FVoiceButton[4] := vButton4;
   FVoiceButton[5] := vButton5;
   FVoiceButton[6] := vButton6;
   FVoiceButton[7] := vButton7;
   FVoiceButton[8] := vButton8;
   FVoiceButton[9] := vButton9;
   FVoiceButton[10] := vButton10;
   FVoiceButton[11] := vButton11;
   FVoiceButton[12] := vButton12;
   FAdditionalVoiceEdit[2] := vEdit13;
   FAdditionalVoiceEdit[3] := vEdit14;
   FAdditionalVoiceButton[2] := vButton13;
   FAdditionalVoiceButton[3] := vButton14;

   FVoiceSound := TWaveSound.Create();

   L := TWaveSound.DeviceList();
   try
      comboVoiceDevice.Items.Assign(L);
   finally
      L.Free();
   end;
end;

procedure TformOptions2.listviewFreqMemoryDblClick(Sender: TObject);
begin
   buttonFreqMemEdit.Click();
end;

procedure TformOptions2.listviewFreqMemorySelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
   buttonFreqMemEdit.Enabled := Selected;
   buttonFreqMemDelete.Enabled := Selected;
end;

procedure TformOptions2.menuVoiceClearClick(Sender: TObject);
var
   n: Integer;
begin
   n := popupVoiceMenu.Tag;
   if n = 0 then begin
      Exit;
   end;

   if (n <= 12) then begin
      FTempVoiceFiles[n] := '';
      FVoiceEdit[n].Text := '';
      FVoiceButton[n].Caption := 'select';
   end
   else begin
      n := n - 100;
      FTempAdditionalVoiceFiles[n] := '';
      FAdditionalVoiceEdit[n].Text := '';
      FAdditionalVoiceButton[n].Caption := 'select';
   end;
end;

procedure TformOptions2.menuVoicePlayClick(Sender: TObject);
var
   n: Integer;
begin
   n := popupVoiceMenu.Tag;
   if n = 0 then begin
      Exit;
   end;

   if (n <= 12) then begin
      if (FTempVoiceFiles[n] <> '') and
         (FileExists(FTempVoiceFiles[n]) = True) then begin
         FVoiceSound.Open(FTempVoiceFiles[n], comboVoiceDevice.ItemIndex);
         FVoiceSound.Play();
      end;
   end
   else begin
      n := n - 100;
      if (FTempAdditionalVoiceFiles[n] <> '') and
         (FileExists(FTempAdditionalVoiceFiles[n]) = True) then begin
         FVoiceSound.Open(FTempAdditionalVoiceFiles[n], comboVoiceDevice.ItemIndex);
         FVoiceSound.Play();
      end;
   end;
end;

procedure TformOptions2.menuVoiceStopClick(Sender: TObject);
begin
   FVoiceSound.Stop();
   FVoiceSound.Close();
end;

procedure TformOptions2.buttonPartialCheckForeColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editPartialCheckColor.Font.Color;
   if ColorDialog1.Execute = True then begin
      editPartialCheckColor.Font.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.buttonPartialCheckBackColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editPartialCheckColor.Color;
   if ColorDialog1.Execute = True then begin
      editPartialCheckColor.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.buttonPartialCheckInitColorClick(Sender: TObject);
begin
   editPartialCheckColor.Font.Color := clFuchsia;
   editPartialCheckColor.Color := clWhite;
end;

procedure TformOptions2.buttonFocusedForeColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editFocusedColor.Font.Color;
   if ColorDialog1.Execute = True then begin
      editFocusedColor.Font.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.buttonFocusedBackColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editFocusedColor.Color;
   if ColorDialog1.Execute = True then begin
      editFocusedColor.Color := ColorDialog1.Color;
   end;
end;

procedure TformOptions2.buttonFocusedInitColorClick(Sender: TObject);
begin
   editFocusedColor.Font.Color := clBlack;
   editFocusedColor.Color := clWhite;
   checkFocusedBold.Checked := False;
end;

procedure TformOptions2.buttonFreqMemAddClick(Sender: TObject);
var
   dlg: TformFreqMemDialog;
   D: TFreqMemory;
begin
   dlg := TformFreqMemDialog.Create(Self);
   try
      dlg.TempFreqMemList := FTempFreqMemList;

      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

      D := TFreqMemory.Create();
      D.Frequency := dlg.Frequency;
      D.Mode := dlg.Mode;
      D.RigNo := dlg.RigNo;
      D.Command := dlg.Command;
      D.FixEdgeNo := dlg.FixEdgeNo;
      FTempFreqMemList.Add(D);
      AddFreqMemList(D);
   finally
      dlg.Release();
   end;
end;

procedure TformOptions2.buttonFreqMemEditClick(Sender: TObject);
var
   dlg: TformFreqMemDialog;
   D: TFreqMemory;
begin
   dlg := TformFreqMemDialog.Create(Self);
   try
      dlg.TempFreqMemList := FTempFreqMemList;

      D := listviewFreqMemory.Selected.Data;

      dlg.Frequency := D.Frequency;
      dlg.Mode := D.Mode;
      dlg.RigNo := D.RigNo;
      dlg.Command := D.Command;
      dlg.FixEdgeNo := D.FixEdgeNo;

      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

      D.Frequency := dlg.Frequency;
      D.Mode := dlg.Mode;
      D.RigNo := dlg.RigNo;
      D.Command := dlg.Command;
      D.FixEdgeNo := dlg.FixEdgeNo;

      UpdateFreqMemList(listviewFreqMemory.Selected);
   finally
      dlg.Release();
   end;
end;

procedure TformOptions2.buttonFreqMemDeleteClick(Sender: TObject);
var
   D: TFreqMemory;
begin
   D := listviewFreqMemory.Selected.Data;
   listviewFreqMemory.Selected.Delete();
   FTempFreqMemList.Delete(D);
end;

procedure TformOptions2.checkFocusedBoldClick(Sender: TObject);
begin
   if checkFocusedBold.Checked = True then begin
      editFocusedColor.Font.Style := editFocusedColor.Font.Style + [fsBold];
   end
   else begin
      editFocusedColor.Font.Style := editFocusedColor.Font.Style - [fsBold];
   end;
end;

procedure TformOptions2.buttonPlayVoiceClick(Sender: TObject);
var
   i: Integer;
   n: Integer;
begin
   n := 0;
   try
      for i := 1 to High(FVoiceEdit) do begin
         if (FVoiceEdit[i].Focused = True) or (FVoiceButton[i].Focused = True) then begin
            if FileExists(FTempVoiceFiles[i]) = True then begin
               FVoiceSound.Open(FTempVoiceFiles[i], comboVoiceDevice.ItemIndex);
               FVoiceSound.Play();
               Exit;
            end;
         end;
      end;
      for i := 2 to 3 do begin
         if (FAdditionalVoiceEdit[i].Focused = True) or (FAdditionalVoiceButton[i].Focused = True) then begin
            if FileExists(FTempAdditionalVoiceFiles[i]) = True then begin
               FVoiceSound.Open(FTempAdditionalVoiceFiles[i], comboVoiceDevice.ItemIndex);
               FVoiceSound.Play();
               Exit;
            end;
         end;
      end;
   except
      on E: Exception do begin
         Application.MessageBox(PChar(E.Message), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
         if n > 0 then begin
            FVoiceButton[n].Caption := 'select';
            FTempVoiceFiles[n] := '';
         end;
      end;
   end;
end;

procedure TformOptions2.buttonStopVoiceClick(Sender: TObject);
begin
   FVoiceSound.Stop();
   FVoiceSound.Close();
end;

procedure TformOptions2.buttonSpotterListClick(Sender: TObject);
var
   dlg: TformSpotterListDlg;
begin
   dlg := TformSpotterListDlg.Create(Self);
   try

      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

   finally
      dlg.Release();
   end;
end;

procedure TformOptions2.AddFreqMemList(D: TFreqMemory);
var
   listitem: TListItem;
   S: string;
begin
   listitem := listviewFreqMemory.Items.Add();
   listitem.Caption := IntToStr(listviewFreqMemory.Items.Count);
   listitem.SubItems.Add(IntToStr(D.Frequency));
   listitem.SubItems.Add(ModeString[D.Mode]);

   case D.RigNo of
      0: S := 'None';
      1: S := 'RIG-A';
      2: S := 'RIG-B';
      3: S := 'RIG-C';
      else S := '';
   end;
   listitem.SubItems.Add(S);
   listitem.SubItems.Add(D.Command);
   listitem.SubItems.Add(IntToStr(D.FixEdgeNo));
   listitem.Data := D;
end;

procedure TformOptions2.UpdateFreqMemList(listitem: TListItem);
var
   D: TFreqMemory;
   S: string;
begin
   D := listitem.Data;
   listitem.SubItems[0] := IntToStr(D.Frequency);
   listitem.SubItems[1] := ModeString[D.Mode];

   case D.RigNo of
      0: S := 'None';
      1: S := 'RIG-A';
      2: S := 'RIG-B';
      3: S := 'RIG-C';
      else S := '';
   end;
   listitem.SubItems[2] := S;

   listitem.SubItems[3] := D.Command;
   listitem.SubItems[4] := IntToStr(D.FixEdgeNo);
end;
end.
