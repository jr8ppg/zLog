object HamlogConverter: THamlogConverter
  Left = 117
  Top = 174
  Caption = 'HAMLOG Converter'
  ClientHeight = 335
  ClientWidth = 528
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  Scaled = False
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 80
    Width = 513
    Height = 113
    Caption = #25277#20986#26465#20214
    TabOrder = 1
    object Label1: TLabel
      Left = 315
      Top = 29
      Width = 12
      Height = 12
      Caption = #65374
    end
    object Label2: TLabel
      Left = 315
      Top = 69
      Width = 12
      Height = 12
      Caption = #65374
    end
    object dateRangeFrom: TDateTimePicker
      Left = 152
      Top = 24
      Width = 90
      Height = 20
      Date = 46014.000000000000000000
      Format = 'yyyy/MM/dd'
      Time = 0.374171759256569200
      TabOrder = 0
    end
    object dateRangeTo: TDateTimePicker
      Left = 344
      Top = 24
      Width = 90
      Height = 20
      Date = 46014.000000000000000000
      Format = 'yyyy/MM/dd'
      Time = 0.374171759256569200
      TabOrder = 2
    end
    object radioDateRange: TRadioButton
      Left = 16
      Top = 24
      Width = 112
      Height = 25
      Caption = #26085#20184#31684#22258'(JST)'
      Checked = True
      TabOrder = 4
      TabStop = True
      OnClick = radioDateRangeClick
    end
    object radioRecordNumRange: TRadioButton
      Left = 16
      Top = 64
      Width = 112
      Height = 25
      Caption = #12524#12467#12540#12489#30058#21495#31684#22258
      TabOrder = 5
      OnClick = radioRecordNumRangeClick
    end
    object editRecordNumFrom: TEdit
      Left = 152
      Top = 66
      Width = 90
      Height = 20
      TabOrder = 6
      Text = '1'
    end
    object editRecordNumTo: TEdit
      Left = 344
      Top = 66
      Width = 90
      Height = 20
      TabOrder = 7
      Text = '999999'
    end
    object timeRangeFrom: TDateTimePicker
      Left = 247
      Top = 24
      Width = 56
      Height = 20
      Date = 46014.000000000000000000
      Format = 'HH:mm'
      Time = 46014.000000000000000000
      DateMode = dmUpDown
      Kind = dtkTime
      TabOrder = 1
    end
    object timeRangeTo: TDateTimePicker
      Left = 440
      Top = 24
      Width = 56
      Height = 20
      Date = 46014.000000000000000000
      Format = 'HH:mm'
      Time = 0.999988425923220300
      Kind = dtkTime
      TabOrder = 3
    end
  end
  object buttonStart: TButton
    Left = 431
    Top = 294
    Width = 89
    Height = 33
    Caption = #38283#22987
    TabOrder = 2
    OnClick = buttonStartClick
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 513
    Height = 57
    Caption = 'HAMLOG'#12487#12540#12479#12505#12540#12473
    TabOrder = 0
    object editHamlogDatabase: TEdit
      Left = 16
      Top = 24
      Width = 433
      Height = 20
      TabOrder = 0
    end
    object buttonHamlogRef: TButton
      Left = 455
      Top = 22
      Width = 41
      Height = 25
      Caption = #21442#29031
      TabOrder = 1
      OnClick = buttonHamlogRefClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 208
    Width = 401
    Height = 57
    Caption = #21463#20449'NR'
    TabOrder = 3
    object radioRcvdNr1: TRadioButton
      Left = 16
      Top = 24
      Width = 65
      Height = 22
      Caption = 'CODE'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object radioRcvdNr2: TRadioButton
      Left = 87
      Top = 24
      Width = 65
      Height = 22
      Caption = 'RMK1'
      TabOrder = 1
    end
    object radioRcvdNr3: TRadioButton
      Left = 158
      Top = 24
      Width = 65
      Height = 22
      Caption = 'RMK2'
      TabOrder = 2
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 280
    Width = 401
    Height = 46
    Caption = #38651#21147
    TabOrder = 4
    object CheckBox1: TCheckBox
      Left = 16
      Top = 19
      Width = 177
      Height = 17
      Caption = 'NR'#26411#23614#12398'HMLP'#12434#38651#21147#12392#12377#12427
      TabOrder = 0
    end
    object buttonPowerSetting: TButton
      Left = 216
      Top = 14
      Width = 65
      Height = 25
      Caption = #35373#23450
      TabOrder = 1
      OnClick = buttonPowerSettingClick
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'HAMLOG'#12487#12540#12479#12505#12540#12473'|*.hdb|'#20840#12390#12398#12501#12449#12452#12523'|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 280
    Top = 65528
  end
end
