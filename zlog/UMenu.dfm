object MenuForm: TMenuForm
  Left = 267
  Top = 64
  BorderStyle = bsDialog
  Caption = 'zLog Menu'
  ClientHeight = 258
  ClientWidth = 547
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
    547
    258)
  TextHeight = 13
  object Label3: TLabel
    Left = 294
    Top = 162
    Width = 58
    Height = 13
    Caption = 'Score coeff.'
  end
  object OKButton: TButton
    Left = 382
    Top = 225
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 462
    Top = 225
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object ContestGroup: TGroupBox
    Left = 8
    Top = 8
    Width = 277
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
      OnClick = SelectContestClick
    end
    object rb6D: TRadioButton
      Tag = 1
      Left = 8
      Top = 32
      Width = 81
      Height = 17
      Caption = '6m && Down '
      TabOrder = 1
      OnClick = SelectContestClick
    end
    object rbFD: TRadioButton
      Tag = 2
      Left = 8
      Top = 48
      Width = 113
      Height = 17
      Caption = 'Field Day'
      TabOrder = 2
      OnClick = SelectContestClick
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
      OnClick = SelectContestClick
    end
    object rbCQWW: TRadioButton
      Tag = 101
      Left = 136
      Top = 16
      Width = 105
      Height = 17
      Caption = 'CQ WW'
      TabOrder = 7
      OnClick = SelectContestClick
    end
    object rbJIDXJA: TRadioButton
      Tag = 103
      Left = 136
      Top = 48
      Width = 57
      Height = 17
      Caption = 'JIDX'
      TabOrder = 9
      OnClick = SelectContestClick
    end
    object rbCQWPX: TRadioButton
      Tag = 102
      Left = 136
      Top = 32
      Width = 65
      Height = 17
      Caption = 'CQ WPX'
      TabOrder = 8
      OnClick = SelectContestClick
    end
    object rbPedi: TRadioButton
      Tag = 200
      Left = 8
      Top = 188
      Width = 73
      Height = 17
      Caption = 'DXpedition'
      TabOrder = 14
      OnClick = SelectContestClick
    end
    object rbJIDXDX: TRadioButton
      Tag = 112
      Left = 8
      Top = 160
      Width = 81
      Height = 17
      Caption = 'JIDX (DX)'
      TabOrder = 10
      Visible = False
      OnClick = SelectContestClick
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
      TabOrder = 15
      OnClick = SelectContestClick
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
      TabOrder = 13
      OnClick = SelectContestClick
    end
    object rbARRLW: TRadioButton
      Tag = 106
      Left = 136
      Top = 80
      Width = 113
      Height = 17
      Caption = 'ARRL DX (W/VE)'
      TabOrder = 12
      OnClick = SelectContestClick
    end
    object rbAPSprint: TRadioButton
      Tag = 105
      Left = 136
      Top = 64
      Width = 89
      Height = 17
      Caption = 'AP Sprint'
      TabOrder = 11
      OnClick = SelectContestClick
    end
    object rbJA0in: TRadioButton
      Tag = 4
      Left = 8
      Top = 80
      Width = 105
      Height = 17
      Caption = 'ALL JA0 (JA0)'
      TabOrder = 4
      OnClick = SelectContestClick
    end
    object rbJA0out: TRadioButton
      Tag = 5
      Left = 8
      Top = 96
      Width = 105
      Height = 17
      Caption = 'ALL JA0 (others)'
      TabOrder = 5
      OnClick = SelectContestClick
    end
    object rbIARU: TRadioButton
      Tag = 109
      Left = 136
      Top = 128
      Width = 73
      Height = 17
      Caption = 'IARU HF'
      TabOrder = 16
      OnClick = SelectContestClick
    end
    object rbAllAsian: TRadioButton
      Tag = 110
      Left = 136
      Top = 144
      Width = 133
      Height = 17
      Caption = 'All Asian DX (Asia)'
      TabOrder = 17
      OnClick = SelectContestClick
    end
    object rbIOTA: TRadioButton
      Tag = 111
      Left = 136
      Top = 160
      Width = 57
      Height = 17
      Caption = 'IOTA'
      TabOrder = 18
      OnClick = SelectContestClick
    end
    object rbARRL10: TRadioButton
      Tag = 108
      Left = 136
      Top = 112
      Width = 89
      Height = 17
      Caption = 'ARRL 10 m'
      TabOrder = 19
      OnClick = SelectContestClick
    end
    object rbWAE: TRadioButton
      Tag = 113
      Left = 136
      Top = 176
      Width = 113
      Height = 17
      Caption = 'WAEDC (DX)'
      TabOrder = 20
      OnClick = SelectContestClick
    end
    object rbNYP: TRadioButton
      Tag = 6
      Left = 8
      Top = 112
      Width = 122
      Height = 17
      Caption = 'NEW YEAR PARTY'
      TabOrder = 6
      OnClick = SelectContestClick
    end
  end
  object ModeGroup: TRadioGroup
    Left = 443
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
    Left = 357
    Top = 159
    Width = 25
    Height = 18
    AutoSize = False
    MaxLength = 3
    TabOrder = 4
    Text = '1'
  end
  object GroupBox1: TGroupBox
    Left = 291
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
