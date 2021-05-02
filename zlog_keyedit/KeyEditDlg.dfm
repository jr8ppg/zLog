object formKeyEditDlg: TformKeyEditDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #12461#12540#32232#38598
  ClientHeight = 374
  ClientWidth = 495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    495
    374)
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 385
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
      OnClick = comboFunctionKeyClick
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
    Top = 72
    Width = 385
    Height = 57
    Caption = 'A'#65374'Z,0'#65374'9'#12461#12540
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
      OnClick = comboAlphabetKeyClick
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
        '.'
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9')
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
      Left = 272
      Top = 25
      Width = 73
      Height = 17
      Caption = 'Alt'#12461#12540
      TabOrder = 3
    end
    object checkAlphabetAndShift: TCheckBox
      Left = 184
      Top = 25
      Width = 73
      Height = 17
      Caption = 'Shift'#12461#12540
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 141
    Width = 385
    Height = 57
    Caption = #29305#27530#12461#12540
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
      OnClick = comboOtherKeyClick
      Items.Strings = (
        #12394#12375
        'PgUp'
        'PgDn'
        'TAB'
        'Down'
        'Esc')
    end
  end
  object buttonOK: TButton
    Left = 407
    Top = 8
    Width = 81
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = buttonOKClick
  end
  object buttonCancel: TButton
    Left = 407
    Top = 39
    Width = 81
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 4
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 204
    Width = 385
    Height = 82
    Caption = #12381#12398#20182#12398#12461#12540#65288#19978#35352#12392#20341#29992#21487#65289
    TabOrder = 5
    object radioSecondary0: TRadioButton
      Left = 16
      Top = 24
      Width = 49
      Height = 17
      Caption = #12394#12375
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object radioSecondary1: TRadioButton
      Left = 71
      Top = 24
      Width = 82
      Height = 17
      Caption = '; ('#12475#12511#12467#12525#12531')'
      TabOrder = 1
    end
    object radioSecondary2: TRadioButton
      Left = 167
      Top = 24
      Width = 66
      Height = 17
      Caption = ': ('#12467#12525#12531')'
      TabOrder = 2
    end
    object radioSecondary3: TRadioButton
      Left = 259
      Top = 24
      Width = 106
      Height = 17
      Caption = '@ ('#12450#12483#12488#12510#12540#12463')'
      TabOrder = 3
    end
    object radioSecondary4: TRadioButton
      Left = 71
      Top = 47
      Width = 82
      Height = 17
      Caption = '[ ('#24038#22823#25324#24359')'
      TabOrder = 4
    end
    object radioSecondary5: TRadioButton
      Left = 167
      Top = 47
      Width = 82
      Height = 17
      Caption = '] ('#21491#22823#25324#24359')'
      TabOrder = 5
    end
    object radioSecondary6: TRadioButton
      Left = 259
      Top = 47
      Width = 90
      Height = 17
      Caption = '\ (YEN)'
      TabOrder = 6
    end
  end
  object GroupBox5: TGroupBox
    Left = 8
    Top = 292
    Width = 385
    Height = 74
    Caption = #12497#12493#12523#34920#31034#21517
    TabOrder = 6
    object Label1: TLabel
      Left = 16
      Top = 50
      Width = 227
      Height = 12
      Caption = #8251'Function Key Panel'#12395#34920#31034#12377#12427#34920#31034#21517#12391#12377
    end
    object editDispText: TEdit
      Left = 16
      Top = 24
      Width = 349
      Height = 20
      TabOrder = 0
    end
  end
end
