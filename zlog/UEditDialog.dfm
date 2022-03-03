object EditDialog: TEditDialog
  Left = 118
  Top = 386
  BorderStyle = bsDialog
  Caption = 'Dialog'
  ClientHeight = 82
  ClientWidth = 618
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 7
    Top = 52
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 95
    Top = 52
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = CancelBtnClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 618
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object SerialLabel: TLabel
      Left = 8
      Top = 0
      Width = 24
      Height = 12
      Caption = 'ser#'
    end
    object TimeLabel: TLabel
      Left = 48
      Top = 0
      Width = 24
      Height = 12
      Caption = 'time'
    end
    object rcvdRSTLabel: TLabel
      Left = 104
      Top = 0
      Width = 18
      Height = 12
      Caption = 'RST'
    end
    object CallsignLabel: TLabel
      Left = 72
      Top = 0
      Width = 24
      Height = 12
      Caption = 'call'
    end
    object PointLabel: TLabel
      Left = 336
      Top = 0
      Width = 18
      Height = 12
      Caption = 'pts'
    end
    object BandLabel: TLabel
      Left = 224
      Top = 0
      Width = 24
      Height = 12
      Caption = 'band'
    end
    object NumberLabel: TLabel
      Left = 176
      Top = 0
      Width = 24
      Height = 12
      Caption = 'rcvd'
    end
    object ModeLabel: TLabel
      Left = 256
      Top = 0
      Width = 24
      Height = 12
      Caption = 'mode'
    end
    object PowerLabel: TLabel
      Left = 480
      Top = 0
      Width = 18
      Height = 12
      Caption = 'pwr'
      Visible = False
    end
    object OpLabel: TLabel
      Left = 416
      Top = 0
      Width = 12
      Height = 12
      Caption = 'op'
    end
    object MemoLabel: TLabel
      Left = 368
      Top = 0
      Width = 24
      Height = 12
      Caption = 'memo'
    end
    object TxLabel: TLabel
      Left = 543
      Top = 0
      Width = 18
      Height = 12
      Caption = 'TX#'
    end
    object TimeEdit: TEdit
      Left = 8
      Top = 15
      Width = 49
      Height = 18
      AutoSize = False
      ImeMode = imDisable
      TabOrder = 10
      OnChange = TimeEditChange
      OnDblClick = DateEditDblClick
    end
    object CallsignEdit: TEdit
      Left = 117
      Top = 15
      Width = 76
      Height = 18
      AutoSelect = False
      AutoSize = False
      CharCase = ecUpperCase
      ImeMode = imDisable
      MaxLength = 12
      TabOrder = 0
      OnChange = CallsignEditChange
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
    object RcvdRSTEdit: TEdit
      Left = 181
      Top = 15
      Width = 52
      Height = 18
      AutoSize = False
      ImeMode = imDisable
      TabOrder = 1
      OnChange = RcvdRSTEditChange
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
    object NumberEdit: TEdit
      Left = 197
      Top = 15
      Width = 100
      Height = 18
      AutoSelect = False
      AutoSize = False
      CharCase = ecUpperCase
      ImeMode = imDisable
      TabOrder = 2
      OnChange = NumberEditChange
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
    object BandEdit: TEdit
      Left = 176
      Top = 15
      Width = 73
      Height = 18
      TabStop = False
      AutoSize = False
      ImeMode = imDisable
      PopupMenu = BandMenu
      ReadOnly = True
      TabOrder = 3
      OnClick = BandEditClick
    end
    object ModeEdit: TEdit
      Left = 328
      Top = 15
      Width = 33
      Height = 18
      TabStop = False
      AutoSize = False
      ImeMode = imDisable
      PopupMenu = ModeMenu
      ReadOnly = True
      TabOrder = 4
      OnClick = ModeEditClick
    end
    object MemoEdit: TEdit
      Left = 344
      Top = 15
      Width = 121
      Height = 18
      AutoSize = False
      TabOrder = 8
      OnChange = MemoEditChange
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
    object PointEdit: TEdit
      Left = 256
      Top = 15
      Width = 81
      Height = 18
      AutoSize = False
      ImeMode = imDisable
      TabOrder = 5
    end
    object PowerEdit: TEdit
      Left = 397
      Top = 15
      Width = 44
      Height = 18
      AutoSize = False
      CharCase = ecUpperCase
      ImeMode = imDisable
      MaxLength = 4
      TabOrder = 6
      OnChange = PowerEditChange
    end
    object OpEdit: TEdit
      Left = 472
      Top = 15
      Width = 65
      Height = 18
      AutoSize = False
      ImeMode = imDisable
      PopupMenu = OpMenu
      ReadOnly = True
      TabOrder = 7
      OnClick = OpEditClick
    end
    object SerialEdit: TEdit
      Left = 32
      Top = 15
      Width = 49
      Height = 18
      AutoSize = False
      ImeMode = imDisable
      TabOrder = 9
      Visible = False
    end
    object DateEdit: TEdit
      Left = 48
      Top = 15
      Width = 81
      Height = 18
      AutoSize = False
      CharCase = ecUpperCase
      ImeMode = imDisable
      TabOrder = 11
      Visible = False
      OnChange = DateEditChange
      OnDblClick = DateEditDblClick
    end
    object NewPowerEdit: TEdit
      Left = 437
      Top = 15
      Width = 44
      Height = 18
      AutoSize = False
      ImeMode = imDisable
      PopupMenu = NewPowerMenu
      ReadOnly = True
      TabOrder = 12
      Visible = False
      OnClick = NewPowerEditClick
    end
    object comboTxNo: TComboBox
      Left = 543
      Top = 13
      Width = 41
      Height = 20
      Style = csDropDownList
      TabOrder = 13
      OnChange = comboTxNoChange
    end
  end
  object BandMenu: TPopupMenu
    Left = 368
    Top = 40
  end
  object ModeMenu: TPopupMenu
    Left = 400
    Top = 40
  end
  object OpMenu: TPopupMenu
    Left = 432
    Top = 40
  end
  object NewPowerMenu: TPopupMenu
    Left = 296
    Top = 40
  end
  object ActionList1: TActionList
    State = asSuspended
    Left = 488
    Top = 40
    object actionPlayMessageA01: TAction
      Tag = 1
      Caption = 'actionPlayMessageA01'
      ShortCut = 112
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA02: TAction
      Tag = 2
      Caption = 'actionPlayMessageA02'
      ShortCut = 113
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA03: TAction
      Tag = 3
      Caption = 'actionPlayMessageA03'
      ShortCut = 114
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA04: TAction
      Tag = 4
      Caption = 'actionPlayMessageA04'
      ShortCut = 115
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA05: TAction
      Tag = 5
      Caption = 'actionPlayMessageA05'
      ShortCut = 116
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA06: TAction
      Tag = 6
      Caption = 'actionPlayMessageA06'
      ShortCut = 117
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA07: TAction
      Tag = 7
      Caption = 'actionPlayMessageA07'
      ShortCut = 118
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA08: TAction
      Tag = 8
      Caption = 'actionPlayMessageA08'
      ShortCut = 119
      OnExecute = actionPlayMessageAExecute
    end
    object actionShowCheckPartial: TAction
      Caption = 'actionShowCheckPartial'
      ShortCut = 121
      OnExecute = actionShowCheckPartialExecute
    end
    object actionPlayMessageA11: TAction
      Tag = 11
      Caption = 'actionPlayMessageA11'
      ShortCut = 122
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA12: TAction
      Tag = 12
      Caption = 'actionPlayMessageA12'
      ShortCut = 123
      OnExecute = actionPlayMessageAExecute
    end
    object actionClearCallAndRpt: TAction
      Caption = 'actionClearCallAndRpt'
      ShortCut = 16459
      OnExecute = actionClearCallAndRptExecute
    end
    object actionDecreaseTime: TAction
      Caption = 'actionDecreaseTime'
      ShortCut = 16463
      OnExecute = actionDecreaseTimeExecute
    end
    object actionIncreaseTime: TAction
      Caption = 'actionIncreaseTime'
      ShortCut = 16464
      OnExecute = actionIncreaseTimeExecute
    end
    object actionReversePaddle: TAction
      Caption = 'actionReversePaddle'
      ShortCut = 16466
      OnExecute = actionReversePaddleExecute
    end
    object actionFieldClear: TAction
      Caption = 'actionFieldClear'
      ShortCut = 16471
      OnExecute = actionFieldClearExecute
    end
    object actionCQRepeat: TAction
      Caption = 'actionCQRepeat'
      ShortCut = 16474
      OnExecute = actionCQRepeatExecute
    end
    object actionFocusCallsign: TAction
      Caption = 'actionFocusCallsign'
      ShortCut = 32835
      OnExecute = actionFocusCallsignExecute
    end
    object actionFocusMemo: TAction
      Caption = 'actionFocusMemo'
      ShortCut = 32845
      OnExecute = actionFocusMemoExecute
    end
    object actionFocusNumber: TAction
      Caption = 'actionFocusNumber'
      ShortCut = 32846
      OnExecute = actionFocusNumberExecute
    end
    object actionFocusOp: TAction
      Caption = 'actionFocusOp'
      ShortCut = 32847
      OnExecute = actionFocusOpExecute
    end
    object actionFocusRst: TAction
      Caption = 'actionFocusRst'
      ShortCut = 32850
      OnExecute = actionFocusRstExecute
    end
    object actionToggleRig: TAction
      Caption = 'actionToggleRig'
      ShortCut = 8280
      OnExecute = actionToggleRigExecute
    end
    object actionControlPTT: TAction
      Caption = 'actionControlPTT'
      SecondaryShortCuts.Strings = (
        '\')
      OnExecute = actionControlPTTExecute
    end
    object actionChangeBand: TAction
      Caption = 'actionChangeBand'
      ShortCut = 8258
      OnExecute = actionChangeBandExecute
    end
    object actionChangeMode: TAction
      Caption = 'actionChangeMode'
      ShortCut = 8269
      OnExecute = actionChangeModeExecute
    end
    object actionChangePower: TAction
      Caption = 'actionChangePower'
      ShortCut = 8272
      OnExecute = actionChangePowerExecute
    end
    object actionChangeR: TAction
      Caption = 'actionChangeR'
      ShortCut = 8274
      OnExecute = actionChangeRExecute
    end
    object actionChangeS: TAction
      Caption = 'actionChangeS'
      ShortCut = 8275
      OnExecute = actionChangeSExecute
    end
    object actionSetCurTime: TAction
      Caption = 'actionSetCurTime'
      ShortCut = 8276
      OnExecute = actionSetCurTimeExecute
    end
    object actionDecreaseCwSpeed: TAction
      Caption = 'actionDecreaseCwSpeed'
      ShortCut = 8277
      OnExecute = actionDecreaseCwSpeedExecute
    end
    object actionIncreaseCwSpeed: TAction
      Caption = 'actionIncreaseCwSpeed'
      ShortCut = 8281
      OnExecute = actionIncreaseCwSpeedExecute
    end
    object actionCQRepeat2: TAction
      Caption = 'actionCQRepeat2'
      ShortCut = 8282
      OnExecute = actionCQRepeat2Execute
    end
    object actionToggleVFO: TAction
      Caption = 'actionToggleVFO'
      ShortCut = 8278
      OnExecute = actionToggleVFOExecute
    end
    object actionQuickMemo1: TAction
      Tag = 1
      Caption = 'PSE QSL'
      OnExecute = actionQuickMemo1Execute
    end
    object actionQuickMemo2: TAction
      Tag = 2
      Caption = 'NO QSL'
      OnExecute = actionQuickMemo2Execute
    end
    object actionQuickMemo3: TAction
      Tag = 3
      Caption = 'actionQuickMemo3'
      OnExecute = actionQuickMemo3Execute
    end
    object actionQuickMemo4: TAction
      Tag = 4
      Caption = 'actionQuickMemo4'
      OnExecute = actionQuickMemo3Execute
    end
    object actionQuickMemo5: TAction
      Tag = 5
      Caption = 'actionQuickMemo5'
      OnExecute = actionQuickMemo3Execute
    end
    object actionPlayMessageA09: TAction
      Tag = 9
      Caption = 'actionPlayMessageA09'
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA10: TAction
      Tag = 10
      Caption = 'actionPlayMessageA10'
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayCQA2: TAction
      Tag = 102
      Caption = 'actionPlayCQA2'
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayCQA3: TAction
      Tag = 103
      Caption = 'actionPlayCQA3'
      OnExecute = actionPlayMessageAExecute
    end
    object actionToggleRX: TAction
      Caption = 'actionToggleRX'
      OnExecute = actionToggleRXExecute
    end
    object actionToggleTX: TAction
      Caption = 'actionToggleTX'
      OnExecute = actionToggleTXExecute
    end
    object actionSo2rToggleRigPair: TAction
      Caption = 'actionSo2rToggleRigPair'
      OnExecute = actionSo2rToggleRigPairExecute
    end
  end
end
