object MenuForm: TMenuForm
  Left = 267
  Top = 64
  BorderStyle = bsDialog
  Caption = 'zLog Menu'
  ClientHeight = 288
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 367
    Top = 266
    Width = 36
    Height = 13
    Caption = 'Callsign'
  end
  object Label2: TLabel
    Left = 272
    Top = 234
    Width = 67
    Height = 13
    Caption = 'TX# (optional)'
  end
  object Label3: TLabel
    Left = 385
    Top = 234
    Width = 58
    Height = 13
    Caption = 'Score coeff.'
  end
  object OKButton: TButton
    Left = 12
    Top = 257
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelButton: TButton
    Left = 92
    Top = 257
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object Button3: TButton
    Left = 172
    Top = 257
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 2
    Visible = False
  end
  object ContestGroup: TGroupBox
    Left = 8
    Top = 8
    Width = 257
    Height = 233
    Caption = 'Contest'
    TabOrder = 3
    object SelectButton: TSpeedButton
      Tag = 9999
      Left = 184
      Top = 208
      Width = 65
      Height = 18
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
      OnExit = rbARRL10Exit
    end
    object rbKCJ: TRadioButton
      Tag = 6
      Left = 8
      Top = 112
      Width = 89
      Height = 17
      Caption = 'KCJ'
      TabOrder = 19
      OnClick = rbKCJClick
    end
    object rbWAE: TRadioButton
      Tag = 112
      Left = 136
      Top = 176
      Width = 113
      Height = 17
      Caption = 'WAEDC (DX)'
      TabOrder = 20
      OnClick = rbWAEClick
    end
  end
  object OpGroup: TRadioGroup
    Left = 272
    Top = 144
    Width = 113
    Height = 81
    Caption = 'Operator'
    ItemIndex = 0
    Items.Strings = (
      'Single-Op'
      'Multi-Op'
      'Multi-Op/S-TX')
    TabOrder = 4
    OnClick = OpGroupClick
  end
  object BandGroup: TRadioGroup
    Left = 272
    Top = 8
    Width = 201
    Height = 129
    Caption = 'Band'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'All band'
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
    TabOrder = 5
  end
  object ModeGroup: TRadioGroup
    Left = 392
    Top = 144
    Width = 81
    Height = 81
    Caption = 'Mode'
    ItemIndex = 0
    Items.Strings = (
      'Ph/CW'
      'CW'
      'Ph'
      'Other')
    TabOrder = 6
  end
  object editCallsign: TEdit
    Left = 408
    Top = 263
    Width = 65
    Height = 18
    AutoSize = False
    TabOrder = 7
  end
  object CheckBox1: TCheckBox
    Left = 274
    Top = 264
    Width = 87
    Height = 17
    Caption = 'Post-contest'
    TabOrder = 8
  end
  object TXNrEdit: TEdit
    Left = 344
    Top = 231
    Width = 25
    Height = 18
    AutoSize = False
    MaxLength = 3
    TabOrder = 9
    OnKeyPress = TXNrEditKeyPress
  end
  object ScoreCoeffEdit: TEdit
    Left = 448
    Top = 231
    Width = 25
    Height = 18
    AutoSize = False
    MaxLength = 3
    TabOrder = 10
    Text = '1'
    OnKeyPress = TXNrEditKeyPress
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'zlo'
    Filter = 'zLog binary file|*.ZLO'
    Left = 440
    Top = 112
  end
  object CFGOpenDialog: TOpenDialog
    DefaultExt = 'CFG'
    Filter = 'zLog CFG file|*.cfg'
    Title = 'Open a CFG file'
    Left = 96
    Top = 176
  end
end
