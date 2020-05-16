object formKeyEditDlg: TformKeyEditDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #12461#12540#32232#38598
  ClientHeight = 209
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 3
    Width = 353
    Height = 57
    Caption = #12501#12449#12531#12463#12471#12519#12531#12461#12540
    TabOrder = 0
    object checkFuncAndCtrl: TCheckBox
      Left = 96
      Top = 24
      Width = 73
      Height = 17
      Caption = 'Ctrl'#12461#12540
      TabOrder = 0
    end
    object checkFuncAndShift: TCheckBox
      Left = 184
      Top = 24
      Width = 73
      Height = 17
      Caption = 'Shift'#12461#12540
      TabOrder = 1
    end
    object checkFuncAndAlt: TCheckBox
      Left = 272
      Top = 24
      Width = 73
      Height = 17
      Caption = 'Alt'#12461#12540
      TabOrder = 2
    end
    object comboFunctionKey: TComboBox
      Left = 16
      Top = 22
      Width = 57
      Height = 20
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 3
      Text = #12394#12375
      Items.Strings = (
        #12394#12375
        'F1'
        'F2'
        'F3'
        'F4'
        'F5'
        'F6'
        'F7'
        'F8'
        'F9'
        'F10'
        'F11'
        'F12')
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 67
    Width = 353
    Height = 57
    Caption = 'A'#65374'Z'
    TabOrder = 1
    object comboAlphabetKey: TComboBox
      Left = 16
      Top = 22
      Width = 57
      Height = 20
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = #12394#12375
      Items.Strings = (
        #12394#12375
        'A'
        'B'
        'C'
        'D'
        'E'
        'F'
        'G'
        'H'
        'I'
        'J'
        'K'
        'L'
        'M'
        'N'
        'O'
        'P'
        'Q'
        'R'
        'S'
        'T'
        'U'
        'V'
        'W'
        'X'
        'Y'
        'Z'
        '.')
    end
    object checkAlphabetAndCtrl: TCheckBox
      Left = 96
      Top = 25
      Width = 73
      Height = 17
      Caption = 'Ctrl'#12461#12540
      TabOrder = 1
    end
    object checkAlphabetAndAlt: TCheckBox
      Left = 184
      Top = 25
      Width = 73
      Height = 17
      Caption = 'Alt'#12461#12540
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 136
    Width = 353
    Height = 57
    Caption = #12381#12398#20182
    TabOrder = 2
    object comboOtherKey: TComboBox
      Left = 16
      Top = 22
      Width = 57
      Height = 20
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = #12394#12375
      Items.Strings = (
        #12394#12375
        'PgUp'
        'PgDn'
        'TAB'
        #8595)
    end
  end
  object buttonOK: TButton
    Left = 367
    Top = 8
    Width = 81
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = buttonOKClick
  end
  object buttonCancel: TButton
    Left = 367
    Top = 39
    Width = 81
    Height = 25
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 4
  end
end
