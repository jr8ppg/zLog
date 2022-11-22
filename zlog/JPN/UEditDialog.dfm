object EditDialog: TEditDialog
  Left = 118
  Top = 386
  BorderStyle = bsDialog
  Caption = 'Dialog'
  ClientHeight = 194
  ClientWidth = 692
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 2
    Top = 114
    Width = 205
    Height = 42
    Caption = 'QSL'#12459#12540#12489
    TabOrder = 4
    object radioQslNone: TRadioButton
      Left = 16
      Top = 16
      Width = 45
      Height = 17
      Caption = 'None'
      TabOrder = 0
    end
    object radioPseQsl: TRadioButton
      Left = 67
      Top = 16
      Width = 61
      Height = 17
      Caption = 'PSE QSL'
      TabOrder = 1
    end
    object radioNoQsl: TRadioButton
      Left = 137
      Top = 16
      Width = 61
      Height = 17
      Caption = 'NO QSL'
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 336
    Top = 66
    Width = 351
    Height = 42
    Caption = 'QSO'#12501#12521#12464
    TabOrder = 3
    object checkCQ: TCheckBox
      Left = 16
      Top = 16
      Width = 33
      Height = 17
      Caption = 'CQ'
      TabOrder = 0
    end
    object checkDupe: TCheckBox
      Left = 59
      Top = 16
      Width = 46
      Height = 17
      Caption = 'DUPE'
      Enabled = False
      TabOrder = 1
    end
    object checkQsyViolation: TCheckBox
      Left = 115
      Top = 16
      Width = 85
      Height = 17
      Caption = 'QSY'#36949#21453
      Enabled = False
      TabOrder = 2
    end
    object checkForced: TCheckBox
      Left = 190
      Top = 16
      Width = 64
      Height = 17
      Caption = #24375#21046#20837#21147
      Enabled = False
      TabOrder = 3
    end
    object checkInvalid: TCheckBox
      Left = 270
      Top = 16
      Width = 51
      Height = 17
      Caption = #28961#21177
      TabOrder = 4
      OnClick = checkInvalidClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 229
    Top = 66
    Width = 101
    Height = 42
    Caption = #21608#27874#25968
    TabOrder = 2
    object editFrequency: TEdit
      Left = 16
      Top = 14
      Width = 73
      Height = 21
      AutoSize = False
      MaxLength = 10
      TabOrder = 0
    end
  end
  object GroupBox4: TGroupBox
    Left = 2
    Top = 66
    Width = 221
    Height = 42
    Caption = #12473#12486#12540#12471#12519#12531
    TabOrder = 1
    DesignSize = (
      221
      42)
    object TxLabel: TLabel
      Left = 144
      Top = 17
      Width = 21
      Height = 13
      Caption = 'TX#'
    end
    object Label1: TLabel
      Left = 11
      Top = 17
      Width = 42
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'PC'#21517
    end
    object comboTxNo: TComboBox
      Left = 171
      Top = 14
      Width = 41
      Height = 21
      Style = csDropDownList
      TabOrder = 1
    end
    object editPCName: TEdit
      Left = 58
      Top = 14
      Width = 73
      Height = 21
      AutoSize = False
      MaxLength = 10
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 161
    Width = 692
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    DesignSize = (
      692
      33)
    object OKBtn: TButton
      Left = 531
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = OKBtnClick
    end
    object CancelBtn: TButton
      Left = 612
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      TabOrder = 1
      OnClick = CancelBtnClick
    end
  end
  object groupQsoData: TGroupBox
    Left = 2
    Top = 2
    Width = 685
    Height = 57
    Caption = 'QSO'#12487#12540#12479
    TabOrder = 0
    object SerialLabel: TLabel
      Left = 8
      Top = 14
      Width = 21
      Height = 13
      Caption = 'ser#'
    end
    object TimeLabel: TLabel
      Left = 120
      Top = 14
      Width = 19
      Height = 13
      Caption = 'time'
    end
    object rcvdRSTLabel: TLabel
      Left = 271
      Top = 14
      Width = 22
      Height = 13
      Caption = 'RST'
    end
    object CallsignLabel: TLabel
      Left = 188
      Top = 14
      Width = 16
      Height = 13
      Caption = 'call'
    end
    object PointLabel: TLabel
      Left = 474
      Top = 14
      Width = 14
      Height = 13
      Caption = 'pts'
    end
    object BandLabel: TLabel
      Left = 372
      Top = 14
      Width = 24
      Height = 13
      Caption = 'band'
    end
    object NumberLabel: TLabel
      Left = 303
      Top = 14
      Width = 21
      Height = 13
      Caption = 'rcvd'
    end
    object ModeLabel: TLabel
      Left = 414
      Top = 14
      Width = 26
      Height = 13
      Caption = 'mode'
    end
    object PowerLabel: TLabel
      Left = 448
      Top = 14
      Width = 17
      Height = 13
      Caption = 'pwr'
    end
    object OpLabel: TLabel
      Left = 495
      Top = 14
      Width = 12
      Height = 13
      Caption = 'op'
    end
    object MemoLabel: TLabel
      Left = 561
      Top = 14
      Width = 28
      Height = 13
      Caption = 'memo'
    end
    object Label2: TLabel
      Left = 41
      Top = 14
      Width = 21
      Height = 13
      Caption = 'date'
    end
    object CallsignEdit: TEdit
      Left = 188
      Top = 28
      Width = 80
      Height = 21
      AutoSize = False
      CharCase = ecUpperCase
      ImeMode = imDisable
      MaxLength = 12
      TabOrder = 0
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
    object RcvdRSTEdit: TEdit
      Left = 269
      Top = 28
      Width = 34
      Height = 21
      AutoSize = False
      ImeMode = imDisable
      TabOrder = 1
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
    object NumberEdit: TEdit
      Left = 303
      Top = 28
      Width = 65
      Height = 21
      AutoSize = False
      CharCase = ecUpperCase
      ImeMode = imDisable
      TabOrder = 2
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
    object BandEdit: TEdit
      Left = 372
      Top = 28
      Width = 41
      Height = 21
      TabStop = False
      AutoSize = False
      ImeMode = imDisable
      PopupMenu = BandMenu
      ReadOnly = True
      TabOrder = 3
      OnClick = BandEditClick
    end
    object ModeEdit: TEdit
      Left = 414
      Top = 28
      Width = 33
      Height = 21
      TabStop = False
      AutoSize = False
      ImeMode = imDisable
      PopupMenu = ModeMenu
      ReadOnly = True
      TabOrder = 4
      OnClick = ModeEditClick
    end
    object MemoEdit: TEdit
      Left = 560
      Top = 28
      Width = 121
      Height = 21
      AutoSize = False
      TabOrder = 8
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
    object PointEdit: TEdit
      Left = 474
      Top = 28
      Width = 19
      Height = 21
      AutoSize = False
      ImeMode = imDisable
      ReadOnly = True
      TabOrder = 6
    end
    object OpEdit: TEdit
      Left = 495
      Top = 28
      Width = 65
      Height = 21
      AutoSize = False
      ImeMode = imDisable
      PopupMenu = OpMenu
      ReadOnly = True
      TabOrder = 7
      OnClick = OpEditClick
    end
    object SerialEdit: TEdit
      Left = 8
      Top = 28
      Width = 33
      Height = 21
      TabStop = False
      AutoSize = False
      ImeMode = imDisable
      TabOrder = 9
      Visible = False
    end
    object NewPowerEdit: TEdit
      Left = 448
      Top = 28
      Width = 24
      Height = 21
      AutoSize = False
      ImeMode = imDisable
      PopupMenu = NewPowerMenu
      ReadOnly = True
      TabOrder = 5
      OnClick = NewPowerEditClick
    end
    object DateTimePicker1: TDateTimePicker
      Left = 41
      Top = 28
      Width = 80
      Height = 21
      Date = 44714
      Format = 'yyyy/MM/dd'
      Time = 0.882441875000950000
      TabOrder = 10
    end
    object DateTimePicker2: TDateTimePicker
      Left = 120
      Top = 28
      Width = 67
      Height = 21
      Date = 44714
      Format = 'HH:mm:ss'
      Time = 0.882441875000950000
      Kind = dtkTime
      TabOrder = 11
    end
  end
  object BandMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 312
    Top = 120
  end
  object ModeMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 344
    Top = 120
  end
  object OpMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 376
    Top = 120
  end
  object NewPowerMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 240
    Top = 120
  end
  object ActionList1: TActionList
    State = asSuspended
    Left = 432
    Top = 120
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
      OnExecute = actionQuickMemo3Execute
    end
    object actionQuickMemo2: TAction
      Tag = 2
      Caption = 'NO QSL'
      OnExecute = actionQuickMemo3Execute
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
