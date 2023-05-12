object OperatorPowerDialog: TOperatorPowerDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Operator'#39's power'
  ClientHeight = 119
  ClientWidth = 547
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 89
    Width = 547
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 57
    ExplicitWidth = 533
    DesignSize = (
      547
      30)
    object buttonOK: TButton
      Left = 373
      Top = 1
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 359
    end
    object buttonCancel: TButton
      Left = 460
      Top = 1
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 446
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 529
    Height = 73
    Caption = 'Power code by band'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 26
      Height = 15
      Caption = '1.9M'
    end
    object Label10: TLabel
      Left = 367
      Top = 24
      Width = 37
      Height = 15
      Caption = '1200M'
    end
    object Label11: TLabel
      Left = 406
      Top = 24
      Width = 37
      Height = 15
      Caption = '2400M'
    end
    object Label12: TLabel
      Left = 445
      Top = 24
      Width = 37
      Height = 15
      Caption = '5600M'
    end
    object Label13: TLabel
      Left = 484
      Top = 24
      Width = 23
      Height = 15
      Caption = '10G'
    end
    object Label2: TLabel
      Left = 55
      Top = 24
      Width = 26
      Height = 15
      Caption = '3.5M'
    end
    object Label3: TLabel
      Left = 94
      Top = 24
      Width = 16
      Height = 15
      Caption = '7M'
    end
    object Label4: TLabel
      Left = 133
      Top = 24
      Width = 23
      Height = 15
      Caption = '14M'
    end
    object Label5: TLabel
      Left = 172
      Top = 24
      Width = 23
      Height = 15
      Caption = '21M'
    end
    object Label6: TLabel
      Left = 211
      Top = 24
      Width = 23
      Height = 15
      Caption = '28M'
    end
    object Label7: TLabel
      Left = 250
      Top = 24
      Width = 23
      Height = 15
      Caption = '50M'
    end
    object Label8: TLabel
      Left = 289
      Top = 24
      Width = 30
      Height = 15
      Caption = '144M'
    end
    object Label9: TLabel
      Left = 328
      Top = 24
      Width = 30
      Height = 15
      Caption = '430M'
    end
    object comboPower10g: TComboBox
      Tag = 13
      Left = 484
      Top = 40
      Width = 33
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = '-'
      OnChange = comboPowerChange
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
      Top = 40
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
    object comboPower14: TComboBox
      Tag = 4
      Left = 133
      Top = 40
      Width = 33
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 2
      Text = '-'
      OnChange = comboPowerChange
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
      Top = 40
      Width = 33
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 3
      Text = '-'
      OnChange = comboPowerChange
      Items.Strings = (
        '-'
        'L'
        'M'
        'H'
        'P')
    end
    object comboPower19: TComboBox
      Tag = 1
      Left = 16
      Top = 40
      Width = 33
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 4
      Text = '-'
      OnChange = comboPowerChange
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
      Top = 40
      Width = 33
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 5
      Text = '-'
      OnChange = comboPowerChange
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
      Top = 40
      Width = 33
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 6
      Text = '-'
      OnChange = comboPowerChange
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
      Top = 40
      Width = 33
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 7
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
      Top = 40
      Width = 33
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 8
      Text = '-'
      OnChange = comboPowerChange
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
      Top = 40
      Width = 33
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 9
      Text = '-'
      OnChange = comboPowerChange
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
      Top = 40
      Width = 33
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 10
      Text = '-'
      OnChange = comboPowerChange
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
      Top = 40
      Width = 33
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 11
      Text = '-'
      OnChange = comboPowerChange
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
      Top = 40
      Width = 33
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 12
      Text = '-'
      OnChange = comboPowerChange
      Items.Strings = (
        '-'
        'L'
        'M'
        'H'
        'P')
    end
  end
end
