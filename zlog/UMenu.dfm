object MenuForm: TMenuForm
  Left = 267
  Top = 64
  BorderStyle = bsDialog
  Caption = 'zLog Menu'
  ClientHeight = 258
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    530
    258)
  TextHeight = 13
  object Label3: TLabel
    Left = 274
    Top = 162
    Width = 58
    Height = 13
    Caption = 'Score coeff.'
  end
  object OKButton: TButton
    Left = 362
    Top = 225
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = OKButtonClick
    ExplicitTop = 251
  end
  object CancelButton: TButton
    Left = 442
    Top = 225
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    ExplicitTop = 251
  end
  object ContestGroup: TGroupBox
    Left = 8
    Top = 8
    Width = 257
    Height = 241
    Caption = 'Contest'
    TabOrder = 2
    object SelectButton: TSpeedButton
      Tag = 9999
      Left = 183
      Top = 208
      Width = 66
      Height = 23
      Caption = 'Select...'
      Enabled = False
      OnClick = SelectButtonClick
    end
    object rbALLJA: TRadioButton
      Left = 8
      Top = 16
      Width = 105
      Height = 17
      Caption = 'ALL JA'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbALLJAClick
    end
    object rb6D: TRadioButton
      Tag = 1
      Left = 8
      Top = 32
      Width = 81
      Height = 17
      Caption = '6m && Down '
      TabOrder = 1
      OnClick = rb6DClick
    end
    object rbFD: TRadioButton
      Tag = 2
      Left = 8
      Top = 48
      Width = 113
      Height = 17
      Caption = 'Field Day'
      TabOrder = 2
      OnClick = rbFDClick
    end
    object rbACAG: TRadioButton
      Tag = 3
      Left = 8
      Top = 64
      Width = 89
      Height = 17
      Caption = #20840#24066#20840#37089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = rbACAGClick
    end
    object rbCQWW: TRadioButton
      Tag = 101
      Left = 136
      Top = 16
      Width = 105
      Height = 17
      Caption = 'CQ WW'
      TabOrder = 6
      OnClick = rbARRLWClick
    end
    object rbJIDXJA: TRadioButton
      Tag = 103
      Left = 136
      Top = 48
      Width = 57
      Height = 17
      Caption = 'JIDX'
      TabOrder = 8
      OnClick = rbARRLWClick
    end
    object rbCQWPX: TRadioButton
      Tag = 102
      Left = 136
      Top = 32
      Width = 65
      Height = 17
      Caption = 'CQ WPX'
      TabOrder = 7
      OnClick = rbARRLWClick
    end
    object rbPedi: TRadioButton
      Tag = 200
      Left = 8
      Top = 188
      Width = 73
      Height = 17
      Caption = 'DXpedition'
      TabOrder = 13
      OnClick = rbPediClick
    end
    object rbJIDXDX: TRadioButton
      Tag = 112
      Left = 8
      Top = 160
      Width = 81
      Height = 17
      Caption = 'JIDX (DX)'
      TabOrder = 9
      Visible = False
      OnClick = rbARRLWClick
    end
    object rbGeneral: TRadioButton
      Tag = 959
      Left = 8
      Top = 211
      Width = 169
      Height = 17
      Caption = 'User Defined Contest'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      OnClick = UserDefClick
      OnEnter = rbGeneralEnter
      OnExit = rbGeneralExit
    end
    object rbARRLDX: TRadioButton
      Tag = 107
      Left = 136
      Top = 96
      Width = 113
      Height = 17
      Caption = 'ARRL DX (DX)'
      TabOrder = 12
      OnClick = rbARRLWClick
    end
    object rbARRLW: TRadioButton
      Tag = 106
      Left = 136
      Top = 80
      Width = 113
      Height = 17
      Caption = 'ARRL DX (W/VE)'
      TabOrder = 11
      OnClick = rbARRLWClick
    end
    object rbAPSprint: TRadioButton
      Tag = 105
      Left = 136
      Top = 64
      Width = 89
      Height = 17
      Caption = 'AP Sprint'
      TabOrder = 10
      OnClick = rbAPSprintClick
    end
    object rbJA0in: TRadioButton
      Tag = 4
      Left = 8
      Top = 80
      Width = 105
      Height = 17
      Caption = 'ALL JA0 (JA0)'
      TabOrder = 4
      OnClick = rbJA0inClick
    end
    object rbJA0out: TRadioButton
      Tag = 5
      Left = 8
      Top = 96
      Width = 105
      Height = 17
      Caption = 'ALL JA0 (others)'
      TabOrder = 5
      OnClick = rbJA0inClick
    end
    object rbIARU: TRadioButton
      Tag = 109
      Left = 136
      Top = 128
      Width = 73
      Height = 17
      Caption = 'IARU HF'
      TabOrder = 15
      OnClick = rbIARUClick
    end
    object rbAllAsian: TRadioButton
      Tag = 110
      Left = 136
      Top = 144
      Width = 113
      Height = 17
      Caption = 'All Asian DX (Asia)'
      TabOrder = 16
      OnClick = rbARRLWClick
    end
    object rbIOTA: TRadioButton
      Tag = 111
      Left = 136
      Top = 160
      Width = 57
      Height = 17
      Caption = 'IOTA'
      TabOrder = 17
      OnClick = rbIOTAClick
    end
    object rbARRL10: TRadioButton
      Tag = 108
      Left = 136
      Top = 112
      Width = 89
      Height = 17
      Caption = 'ARRL 10 m'
      TabOrder = 18
      OnClick = rbARRL10Click
    end
    object rbWAE: TRadioButton
      Tag = 112
      Left = 136
      Top = 176
      Width = 113
      Height = 17
      Caption = 'WAEDC (DX)'
      TabOrder = 19
      OnClick = rbWAEClick
    end
  end
  object ModeGroup: TRadioGroup
    Left = 423
    Top = 8
    Width = 99
    Height = 145
    Caption = 'Mode'
    ItemIndex = 0
    Items.Strings = (
      'PH/CW(MIX)'
      'CW'
      'PH'
      'RTTY'
      'ALL')
    TabOrder = 3
  end
  object ScoreCoeffEdit: TEdit
    Left = 337
    Top = 159
    Width = 25
    Height = 18
    AutoSize = False
    MaxLength = 3
    TabOrder = 4
    Text = '1'
  end
  object GroupBox1: TGroupBox
    Left = 271
    Top = 8
    Width = 146
    Height = 145
    Caption = 'Category'
    TabOrder = 5
    object Label2: TLabel
      Left = 66
      Top = 112
      Width = 21
      Height = 13
      Caption = 'TX#'
    end
    object radioSingleOp: TRadioButton
      Left = 7
      Top = 19
      Width = 130
      Height = 13
      Caption = 'Single-Op'
      TabOrder = 0
      OnClick = OpGroupClick
    end
    object radioMultiOpMultiTx: TRadioButton
      Tag = 1
      Left = 7
      Top = 42
      Width = 130
      Height = 13
      Caption = 'Multi-Op/Multi-TX'
      TabOrder = 1
      OnClick = OpGroupClick
    end
    object radioMultiOpSingleTx: TRadioButton
      Tag = 2
      Left = 7
      Top = 66
      Width = 130
      Height = 13
      Caption = 'Multi-Op/Single-TX'
      TabOrder = 2
      OnClick = OpGroupClick
    end
    object radioMultiOpTwoTx: TRadioButton
      Tag = 3
      Left = 7
      Top = 90
      Width = 130
      Height = 13
      Caption = 'Multi-Op/Two-TX'
      TabOrder = 3
      OnClick = OpGroupClick
    end
    object comboTxNo: TComboBox
      Left = 92
      Top = 109
      Width = 45
      Height = 21
      Style = csDropDownList
      TabOrder = 4
    end
  end
  object CFGOpenDialog: TOpenDialog
    DefaultExt = 'CFG'
    Filter = 'zLog CFG file|*.cfg'
    Title = 'Open a CFG file'
    Left = 104
  end
end
