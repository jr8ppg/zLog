object formPowerDialog: TformPowerDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #38651#21147#35373#23450
  ClientHeight = 168
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 138
    Width = 475
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 89
    ExplicitWidth = 547
    DesignSize = (
      475
      30)
    object buttonOK: TButton
      Left = 301
      Top = 1
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 373
    end
    object buttonCancel: TButton
      Left = 388
      Top = 1
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 460
    end
  end
  object GroupBox1: TGroupBox
    Left = 10
    Top = 8
    Width = 455
    Height = 121
    Caption = #12496#12531#12489#27598#12398#38651#21147#31526#21495
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 23
      Height = 12
      Caption = '1.9M'
    end
    object Label10: TLabel
      Left = 55
      Top = 64
      Width = 33
      Height = 12
      Caption = '1200M'
    end
    object Label11: TLabel
      Left = 94
      Top = 64
      Width = 33
      Height = 12
      Caption = '2400M'
    end
    object Label12: TLabel
      Left = 133
      Top = 64
      Width = 33
      Height = 12
      Caption = '5600M'
    end
    object Label13: TLabel
      Left = 172
      Top = 66
      Width = 28
      Height = 12
      Caption = '10.1G'
    end
    object Label2: TLabel
      Left = 55
      Top = 24
      Width = 23
      Height = 12
      Caption = '3.5M'
    end
    object Label3: TLabel
      Left = 94
      Top = 24
      Width = 15
      Height = 12
      Caption = '7M'
    end
    object Label4: TLabel
      Left = 172
      Top = 24
      Width = 21
      Height = 12
      Caption = '14M'
    end
    object Label5: TLabel
      Left = 250
      Top = 24
      Width = 21
      Height = 12
      Caption = '21M'
    end
    object Label6: TLabel
      Left = 328
      Top = 24
      Width = 21
      Height = 12
      Caption = '28M'
    end
    object Label7: TLabel
      Left = 367
      Top = 24
      Width = 21
      Height = 12
      Caption = '50M'
    end
    object Label8: TLabel
      Left = 406
      Top = 24
      Width = 27
      Height = 12
      Caption = '144M'
    end
    object Label9: TLabel
      Left = 16
      Top = 64
      Width = 27
      Height = 12
      Caption = '430M'
    end
    object Label14: TLabel
      Left = 211
      Top = 66
      Width = 28
      Height = 12
      Caption = '10.4G'
    end
    object Label15: TLabel
      Left = 250
      Top = 66
      Width = 20
      Height = 12
      Caption = '24G'
    end
    object Label16: TLabel
      Left = 289
      Top = 66
      Width = 20
      Height = 12
      Caption = '47G'
    end
    object Label17: TLabel
      Left = 328
      Top = 66
      Width = 20
      Height = 12
      Caption = '77G'
    end
    object Label18: TLabel
      Left = 367
      Top = 66
      Width = 26
      Height = 12
      Caption = '135G'
    end
    object Label19: TLabel
      Left = 406
      Top = 66
      Width = 26
      Height = 12
      Caption = '248G'
    end
    object Label20: TLabel
      Left = 133
      Top = 24
      Width = 21
      Height = 12
      Caption = '10M'
    end
    object Label21: TLabel
      Left = 211
      Top = 24
      Width = 21
      Height = 12
      Caption = '18M'
    end
    object Label22: TLabel
      Left = 289
      Top = 24
      Width = 21
      Height = 12
      Caption = '24M'
    end
    object comboPower10g: TComboBox
      Tag = 16
      Left = 172
      Top = 80
      Width = 33
      Height = 20
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 15
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
      Tag = 13
      Left = 55
      Top = 80
      Width = 33
      Height = 20
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
    object comboPower14: TComboBox
      Tag = 5
      Left = 172
      Top = 40
      Width = 33
      Height = 20
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
    object comboPower144: TComboBox
      Tag = 11
      Left = 406
      Top = 40
      Width = 33
      Height = 20
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
    object comboPower19: TComboBox
      Tag = 1
      Left = 16
      Top = 40
      Width = 33
      Height = 20
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
    object comboPower21: TComboBox
      Tag = 7
      Left = 250
      Top = 40
      Width = 33
      Height = 20
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
    object comboPower2400: TComboBox
      Tag = 14
      Left = 94
      Top = 80
      Width = 33
      Height = 20
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 13
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
      Tag = 9
      Left = 328
      Top = 40
      Width = 33
      Height = 20
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
    object comboPower35: TComboBox
      Tag = 2
      Left = 55
      Top = 40
      Width = 33
      Height = 20
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
    object comboPower430: TComboBox
      Tag = 12
      Left = 16
      Top = 80
      Width = 33
      Height = 20
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
    object comboPower50: TComboBox
      Tag = 10
      Left = 367
      Top = 40
      Width = 33
      Height = 20
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
    object comboPower5600: TComboBox
      Tag = 15
      Left = 133
      Top = 80
      Width = 33
      Height = 20
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 14
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
      Height = 20
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
    object comboPower104g: TComboBox
      Tag = 17
      Left = 211
      Top = 80
      Width = 33
      Height = 20
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 16
      Text = '-'
      OnChange = comboPowerChange
      Items.Strings = (
        '-'
        'L'
        'M'
        'H'
        'P')
    end
    object comboPower24g: TComboBox
      Tag = 18
      Left = 250
      Top = 80
      Width = 33
      Height = 20
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 17
      Text = '-'
      OnChange = comboPowerChange
      Items.Strings = (
        '-'
        'L'
        'M'
        'H'
        'P')
    end
    object comboPower47g: TComboBox
      Tag = 19
      Left = 289
      Top = 80
      Width = 33
      Height = 20
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 18
      Text = '-'
      OnChange = comboPowerChange
      Items.Strings = (
        '-'
        'L'
        'M'
        'H'
        'P')
    end
    object comboPower77g: TComboBox
      Tag = 20
      Left = 328
      Top = 80
      Width = 33
      Height = 20
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 19
      Text = '-'
      OnChange = comboPowerChange
      Items.Strings = (
        '-'
        'L'
        'M'
        'H'
        'P')
    end
    object comboPower135g: TComboBox
      Tag = 21
      Left = 367
      Top = 80
      Width = 33
      Height = 20
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 20
      Text = '-'
      OnChange = comboPowerChange
      Items.Strings = (
        '-'
        'L'
        'M'
        'H'
        'P')
    end
    object comboPower248g: TComboBox
      Tag = 22
      Left = 406
      Top = 80
      Width = 33
      Height = 20
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 21
      Text = '-'
      OnChange = comboPowerChange
      Items.Strings = (
        '-'
        'L'
        'M'
        'H'
        'P')
    end
    object comboPower10: TComboBox
      Tag = 4
      Left = 133
      Top = 40
      Width = 33
      Height = 20
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
    object comboPower18: TComboBox
      Tag = 6
      Left = 211
      Top = 40
      Width = 33
      Height = 20
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
    object comboPower24: TComboBox
      Tag = 8
      Left = 289
      Top = 40
      Width = 33
      Height = 20
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
  end
end
