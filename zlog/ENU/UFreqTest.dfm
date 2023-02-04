object formFreqTest: TformFreqTest
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'FreqTest'
  ClientHeight = 152
  ClientWidth = 404
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object editFreq: TEdit
    Left = 64
    Top = 24
    Width = 225
    Height = 40
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = '71400'
  end
  object updownFreq: TUpDown
    Left = 289
    Top = 24
    Width = 53
    Height = 40
    Associate = editFreq
    Min = 15000
    Max = 99999999
    Position = 71400
    TabOrder = 1
    Thousands = False
    OnClick = updownFreqClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 92
    Width = 385
    Height = 53
    Caption = 'step'
    TabOrder = 2
    object radioStep100: TRadioButton
      Tag = 1
      Left = 11
      Top = 24
      Width = 62
      Height = 17
      Caption = '100Hz'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = radioStepClick
    end
    object radioStep1000: TRadioButton
      Tag = 10
      Left = 88
      Top = 24
      Width = 57
      Height = 17
      Caption = '1KHz'
      TabOrder = 1
      OnClick = radioStepClick
    end
    object radioStep10000: TRadioButton
      Tag = 100
      Left = 158
      Top = 24
      Width = 63
      Height = 17
      Caption = '10KHz'
      TabOrder = 2
      OnClick = radioStepClick
    end
    object radioStep100000: TRadioButton
      Tag = 1000
      Left = 233
      Top = 24
      Width = 69
      Height = 17
      Caption = '100KHz'
      TabOrder = 3
      OnClick = radioStepClick
    end
    object radioStep1000000: TRadioButton
      Tag = 10000
      Left = 316
      Top = 24
      Width = 59
      Height = 17
      Caption = '1MHz'
      TabOrder = 4
      OnClick = radioStepClick
    end
  end
end
