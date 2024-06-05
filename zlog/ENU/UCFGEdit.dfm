object CFGEdit: TCFGEdit
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'CFG Edit'
  ClientHeight = 257
  ClientWidth = 609
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    609
    257)
  TextHeight = 12
  object buttonOK: TButton
    Left = 516
    Top = 8
    Width = 81
    Height = 29
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    TabOrder = 4
    OnClick = buttonOKClick
    ExplicitLeft = 512
  end
  object buttonCancel: TButton
    Left = 516
    Top = 43
    Width = 81
    Height = 29
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 5
    ExplicitLeft = 512
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 115
    Width = 309
    Height = 134
    Caption = 'CW Message'
    TabOrder = 2
    object Label5: TLabel
      Left = 8
      Top = 24
      Width = 20
      Height = 12
      Caption = 'f1_a'
    end
    object Label6: TLabel
      Left = 8
      Top = 50
      Width = 20
      Height = 12
      Caption = 'f2_a'
    end
    object Label7: TLabel
      Left = 8
      Top = 76
      Width = 20
      Height = 12
      Caption = 'f3_a'
    end
    object Label8: TLabel
      Left = 8
      Top = 102
      Width = 20
      Height = 12
      Caption = 'f4_a'
    end
    object editCWF1A: TEdit
      Left = 44
      Top = 21
      Width = 250
      Height = 20
      TabOrder = 0
    end
    object editCWF2A: TEdit
      Left = 44
      Top = 47
      Width = 250
      Height = 20
      TabOrder = 1
    end
    object editCWF3A: TEdit
      Left = 44
      Top = 73
      Width = 250
      Height = 20
      TabOrder = 2
    end
    object editCWF4A: TEdit
      Left = 44
      Top = 99
      Width = 250
      Height = 20
      TabOrder = 3
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 201
    Height = 101
    Caption = 'NR'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 44
      Height = 12
      Caption = 'Sent($X)'
    end
    object Label2: TLabel
      Left = 8
      Top = 46
      Width = 45
      Height = 12
      Caption = 'Prov($V)'
    end
    object Label3: TLabel
      Left = 8
      Top = 72
      Width = 43
      Height = 12
      Caption = 'City($Q)'
    end
    object editCity: TEdit
      Left = 84
      Top = 69
      Width = 109
      Height = 20
      TabOrder = 2
    end
    object editProv: TEdit
      Left = 84
      Top = 43
      Width = 109
      Height = 20
      TabOrder = 1
    end
    object editSent: TEdit
      Left = 84
      Top = 17
      Width = 109
      Height = 20
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 220
    Top = 8
    Width = 289
    Height = 101
    Caption = 'Band to use'
    TabOrder = 1
    object checkBand01: TCheckBox
      Left = 12
      Top = 16
      Width = 50
      Height = 17
      Caption = '1.9M'
      TabOrder = 0
    end
    object checkBand02: TCheckBox
      Left = 12
      Top = 36
      Width = 50
      Height = 17
      Caption = '3.5M'
      TabOrder = 1
    end
    object checkBand03: TCheckBox
      Left = 12
      Top = 57
      Width = 50
      Height = 17
      Caption = '7M'
      TabOrder = 2
    end
    object checkBand04: TCheckBox
      Left = 12
      Top = 77
      Width = 50
      Height = 17
      Caption = '10M'
      Enabled = False
      TabOrder = 3
    end
    object checkBand05: TCheckBox
      Left = 76
      Top = 16
      Width = 50
      Height = 17
      Caption = '14M'
      TabOrder = 4
    end
    object checkBand06: TCheckBox
      Left = 76
      Top = 36
      Width = 50
      Height = 17
      Caption = '18M'
      Enabled = False
      TabOrder = 5
    end
    object checkBand07: TCheckBox
      Left = 76
      Top = 57
      Width = 50
      Height = 17
      Caption = '21M'
      TabOrder = 6
    end
    object checkBand08: TCheckBox
      Left = 76
      Top = 77
      Width = 50
      Height = 17
      Caption = '24M'
      Enabled = False
      TabOrder = 7
    end
    object checkBand09: TCheckBox
      Left = 140
      Top = 16
      Width = 50
      Height = 17
      Caption = '28M'
      TabOrder = 8
    end
    object checkBand10: TCheckBox
      Left = 140
      Top = 36
      Width = 50
      Height = 17
      Caption = '50M'
      TabOrder = 9
    end
    object checkBand11: TCheckBox
      Left = 140
      Top = 57
      Width = 50
      Height = 17
      Caption = '144M'
      TabOrder = 10
    end
    object checkBand12: TCheckBox
      Left = 140
      Top = 77
      Width = 50
      Height = 17
      Caption = '430M'
      TabOrder = 11
    end
    object checkBand13: TCheckBox
      Left = 204
      Top = 16
      Width = 50
      Height = 17
      Caption = '1.2G'
      TabOrder = 12
    end
    object checkBand14: TCheckBox
      Left = 204
      Top = 36
      Width = 50
      Height = 17
      Caption = '2.4G'
      TabOrder = 13
    end
    object checkBand15: TCheckBox
      Left = 204
      Top = 57
      Width = 50
      Height = 17
      Caption = '5.6G'
      TabOrder = 14
    end
    object checkBand16: TCheckBox
      Left = 204
      Top = 77
      Width = 69
      Height = 17
      Caption = '10G&&up'
      TabOrder = 15
    end
  end
  object GroupBox4: TGroupBox
    Left = 323
    Top = 115
    Width = 186
    Height = 134
    Caption = 'Time'
    TabOrder = 3
    object Label4: TLabel
      Left = 16
      Top = 76
      Width = 51
      Height = 12
      Caption = 'Start hour'
    end
    object Label9: TLabel
      Left = 16
      Top = 102
      Width = 32
      Height = 12
      Caption = 'Period'
    end
    object Label10: TLabel
      Left = 128
      Top = 102
      Width = 28
      Height = 12
      Caption = 'hours'
    end
    object comboStartTime: TComboBox
      Left = 81
      Top = 73
      Width = 41
      Height = 20
      MaxLength = 2
      TabOrder = 2
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16'
        '17'
        '18'
        '19'
        '20'
        '21'
        '22'
        '23')
    end
    object comboPeriod: TComboBox
      Left = 81
      Top = 99
      Width = 41
      Height = 20
      MaxLength = 2
      TabOrder = 3
      Items.Strings = (
        '4'
        '6'
        '12'
        '18'
        '24'
        '48')
    end
    object checkUseUTC: TCheckBox
      Left = 16
      Top = 23
      Width = 129
      Height = 17
      Caption = 'Use UTC'
      TabOrder = 0
    end
    object checkUseContestPeriod: TCheckBox
      Left = 16
      Top = 49
      Width = 129
      Height = 17
      Caption = 'Use contest period'
      TabOrder = 1
      OnClick = checkUseContestPeriodClick
    end
  end
end
