object MenuForm: TMenuForm
  Left = 267
  Top = 64
  BorderStyle = bsDialog
  Caption = 'zLog Menu'
  ClientHeight = 312
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS '#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    525
    312)
  TextHeight = 13
  object Label1: TLabel
    Left = 358
    Top = 287
    Width = 80
    Height = 13
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = #12467#12540#12523#12469#12452#12531
  end
  object Label3: TLabel
    Left = 177
    Top = 258
    Width = 58
    Height = 13
    Caption = #12473#12467#12450#20418#25968
  end
  object OKButton: TButton
    Left = 12
    Top = 281
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = OKButtonClick
    ExplicitTop = 280
  end
  object CancelButton: TButton
    Left = 92
    Top = 281
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 1
    ExplicitTop = 280
  end
  object Button3: TButton
    Left = 172
    Top = 281
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #12504#12523#12503
    TabOrder = 2
    Visible = False
    ExplicitTop = 280
  end
  object ContestGroup: TGroupBox
    Left = 8
    Top = 8
    Width = 257
    Height = 241
    Caption = #12467#12531#12486#12473#12488
    TabOrder = 3
    object SelectButton: TSpeedButton
      Tag = 9999
      Left = 183
      Top = 208
      Width = 66
      Height = 23
      Caption = #36984#25246'...'
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
      Top = 192
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
      Top = 208
      Width = 169
      Height = 17
      Caption = #12518#12540#12470#12540#23450#32681
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
      Caption = 'ALL JA0 ('#20182')'
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
      OnExit = rbARRL10Exit
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
  object BandGroup: TRadioGroup
    Left = 272
    Top = 8
    Width = 246
    Height = 129
    Caption = #12496#12531#12489
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #12458#12540#12523#12496#12531#12489
      '1.9 MHz'
      '3.5 MHz'
      '7 MHz'
      '14 MHz'
      '21 MHz'
      '28 MHz'
      '50 MHz'
      '144 MHz'
      '430 MHz'
      '1200 MHz'
      '2400 MHz'
      '5600 MHz'
      '10GHz && up')
    TabOrder = 4
  end
  object ModeGroup: TRadioGroup
    Left = 424
    Top = 144
    Width = 94
    Height = 128
    Caption = #12514#12540#12489
    ItemIndex = 0
    Items.Strings = (
      'Ph/CW'
      'CW'
      'Ph'
      'Other'
      'ALL')
    TabOrder = 5
  end
  object editCallsign: TEdit
    Left = 444
    Top = 284
    Width = 65
    Height = 18
    Anchors = [akRight, akBottom]
    AutoSize = False
    CharCase = ecUpperCase
    TabOrder = 6
    ExplicitLeft = 440
    ExplicitTop = 283
  end
  object CheckBox1: TCheckBox
    Left = 265
    Top = 286
    Width = 87
    Height = 17
    Anchors = [akRight, akBottom]
    Caption = #24460#20837#21147#12514#12540#12489
    TabOrder = 7
    ExplicitLeft = 261
    ExplicitTop = 285
  end
  object ScoreCoeffEdit: TEdit
    Left = 240
    Top = 255
    Width = 25
    Height = 18
    AutoSize = False
    MaxLength = 3
    TabOrder = 8
    Text = '1'
  end
  object GroupBox1: TGroupBox
    Left = 272
    Top = 144
    Width = 146
    Height = 128
    Caption = #12459#12486#12468#12522#12540
    TabOrder = 9
    object Label2: TLabel
      Left = 66
      Top = 100
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
      Top = 38
      Width = 130
      Height = 13
      Caption = 'Multi-Op/Multi-TX'
      TabOrder = 1
      OnClick = OpGroupClick
    end
    object radioMultiOpSingleTx: TRadioButton
      Tag = 2
      Left = 7
      Top = 58
      Width = 130
      Height = 13
      Caption = 'Multi-Op/Single-TX'
      TabOrder = 2
      OnClick = OpGroupClick
    end
    object radioMultiOpTwoTx: TRadioButton
      Tag = 3
      Left = 7
      Top = 78
      Width = 130
      Height = 13
      Caption = 'Multi-Op/Two-TX'
      TabOrder = 3
      OnClick = OpGroupClick
    end
    object comboTxNo: TComboBox
      Left = 92
      Top = 97
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
