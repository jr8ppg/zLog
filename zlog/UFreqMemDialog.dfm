object formFreqMemDialog: TformFreqMemDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Freq. memory'
  ClientHeight = 218
  ClientWidth = 223
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    223
    218)
  TextHeight = 13
  object groupQuickQSY: TGroupBox
    Left = 8
    Top = 8
    Width = 209
    Height = 169
    TabOrder = 0
    object Label31: TLabel
      Left = 8
      Top = 96
      Width = 47
      Height = 13
      Caption = 'Command'
    end
    object Label32: TLabel
      Left = 8
      Top = 123
      Width = 38
      Height = 13
      Caption = 'FixEdge'
    end
    object Label33: TLabel
      Left = 8
      Top = 42
      Width = 27
      Height = 13
      Caption = 'Mode'
    end
    object Label54: TLabel
      Left = 8
      Top = 15
      Width = 54
      Height = 13
      Caption = 'Band/Freq.'
    end
    object Label62: TLabel
      Left = 8
      Top = 69
      Width = 19
      Height = 13
      Caption = 'RIG'
    end
    object comboQuickQsyBand01: TComboBox
      Tag = 1
      Left = 76
      Top = 12
      Width = 117
      Height = 21
      TabOrder = 0
      OnDropDown = comboQuickQsyBandDropDown
    end
    object comboQuickQsyMode01: TComboBox
      Left = 76
      Top = 39
      Width = 55
      Height = 21
      Style = csDropDownList
      TabOrder = 1
    end
    object comboQuickQsyRig01: TComboBox
      Left = 76
      Top = 66
      Width = 55
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 2
      Text = 'None'
      Items.Strings = (
        'None'
        'RIG-A'
        'RIG-B'
        'RIG-C')
    end
    object editQuickQsyCommand01: TEdit
      Left = 76
      Top = 93
      Width = 117
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 3
    end
    object editQuickQsyFixEdge01: TEdit
      Left = 76
      Top = 120
      Width = 23
      Height = 21
      MaxLength = 1
      NumbersOnly = True
      TabOrder = 4
    end
  end
  object buttonOK: TButton
    Left = 37
    Top = 185
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = buttonOKClick
  end
  object buttonCancel: TButton
    Left = 119
    Top = 185
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
