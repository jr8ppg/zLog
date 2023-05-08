object OperatorPowerDialog: TOperatorPowerDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Operator'#39's power'
  ClientHeight = 87
  ClientWidth = 533
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 26
    Height = 15
    Caption = '1.9M'
  end
  object Label2: TLabel
    Left = 55
    Top = 8
    Width = 26
    Height = 15
    Caption = '3.5M'
  end
  object Label3: TLabel
    Left = 94
    Top = 8
    Width = 16
    Height = 15
    Caption = '7M'
  end
  object Label4: TLabel
    Left = 133
    Top = 8
    Width = 23
    Height = 15
    Caption = '14M'
  end
  object Label5: TLabel
    Left = 172
    Top = 8
    Width = 23
    Height = 15
    Caption = '21M'
  end
  object Label6: TLabel
    Left = 211
    Top = 8
    Width = 23
    Height = 15
    Caption = '28M'
  end
  object Label7: TLabel
    Left = 250
    Top = 8
    Width = 23
    Height = 15
    Caption = '50M'
  end
  object Label8: TLabel
    Left = 289
    Top = 8
    Width = 30
    Height = 15
    Caption = '144M'
  end
  object Label9: TLabel
    Left = 328
    Top = 8
    Width = 30
    Height = 15
    Caption = '430M'
  end
  object Label10: TLabel
    Left = 367
    Top = 8
    Width = 37
    Height = 15
    Caption = '1200M'
  end
  object Label11: TLabel
    Left = 406
    Top = 8
    Width = 37
    Height = 15
    Caption = '2400M'
  end
  object Label12: TLabel
    Left = 445
    Top = 8
    Width = 37
    Height = 15
    Caption = '5600M'
  end
  object Label13: TLabel
    Left = 484
    Top = 8
    Width = 23
    Height = 15
    Caption = '10G'
  end
  object Panel1: TPanel
    Left = 0
    Top = 57
    Width = 533
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 72
    ExplicitWidth = 558
    DesignSize = (
      533
      30)
    object buttonOK: TButton
      Left = 359
      Top = 1
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 384
    end
    object buttonCancel: TButton
      Left = 446
      Top = 1
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 471
    end
  end
  object comboPower19: TComboBox
    Tag = 1
    Left = 16
    Top = 24
    Width = 33
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 1
    Text = '-'
    OnChange = comboPowerChange
    Items.Strings = (
      '-'
      'L'
      'M'
      'H'
      'P')
  end
  object comboPower35: TComboBox
    Tag = 2
    Left = 55
    Top = 24
    Width = 33
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 2
    Text = '-'
    Items.Strings = (
      '-'
      'L'
      'M'
      'H'
      'P')
  end
  object comboPower7: TComboBox
    Tag = 3
    Left = 94
    Top = 24
    Width = 33
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 3
    Text = '-'
    Items.Strings = (
      '-'
      'L'
      'M'
      'H'
      'P')
  end
  object comboPower14: TComboBox
    Tag = 4
    Left = 133
    Top = 24
    Width = 33
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 4
    Text = '-'
    Items.Strings = (
      '-'
      'L'
      'M'
      'H'
      'P')
  end
  object comboPower21: TComboBox
    Tag = 5
    Left = 172
    Top = 24
    Width = 33
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 5
    Text = '-'
    Items.Strings = (
      '-'
      'L'
      'M'
      'H'
      'P')
  end
  object comboPower28: TComboBox
    Tag = 6
    Left = 211
    Top = 24
    Width = 33
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 6
    Text = '-'
    Items.Strings = (
      '-'
      'L'
      'M'
      'H'
      'P')
  end
  object comboPower50: TComboBox
    Tag = 7
    Left = 250
    Top = 24
    Width = 33
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 7
    Text = '-'
    Items.Strings = (
      '-'
      'L'
      'M'
      'H'
      'P')
  end
  object comboPower144: TComboBox
    Tag = 8
    Left = 289
    Top = 24
    Width = 33
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 8
    Text = '-'
    Items.Strings = (
      '-'
      'L'
      'M'
      'H'
      'P')
  end
  object comboPower430: TComboBox
    Tag = 9
    Left = 328
    Top = 24
    Width = 33
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 9
    Text = '-'
    Items.Strings = (
      '-'
      'L'
      'M'
      'H'
      'P')
  end
  object comboPower1200: TComboBox
    Tag = 10
    Left = 367
    Top = 24
    Width = 33
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 10
    Text = '-'
    Items.Strings = (
      '-'
      'L'
      'M'
      'H'
      'P')
  end
  object comboPower2400: TComboBox
    Tag = 11
    Left = 406
    Top = 24
    Width = 33
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 11
    Text = '-'
    Items.Strings = (
      '-'
      'L'
      'M'
      'H'
      'P')
  end
  object comboPower5600: TComboBox
    Tag = 12
    Left = 445
    Top = 24
    Width = 33
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 12
    Text = '-'
    Items.Strings = (
      '-'
      'L'
      'M'
      'H'
      'P')
  end
  object comboPower10g: TComboBox
    Tag = 13
    Left = 484
    Top = 24
    Width = 33
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 13
    Text = '-'
    Items.Strings = (
      '-'
      'L'
      'M'
      'H'
      'P')
  end
end
