object formWinkeyerTester: TformWinkeyerTester
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'KeyerTester'
  ClientHeight = 185
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object groupPinCfg: TGroupBox
    Left = 99
    Top = 63
    Width = 325
    Height = 49
    Caption = 'PinCfg'
    TabOrder = 0
    object buttonPinCfgB7: TSpeedButton
      Tag = 7
      Left = 12
      Top = 16
      Width = 24
      Height = 24
      Hint = 'Ult Priority 1'
      AllowAllUp = True
      GroupIndex = 8
      Caption = 'b7'
      ParentShowHint = False
      ShowHint = True
      OnClick = buttonPinCfgBitClick
    end
    object buttonPinCfgB6: TSpeedButton
      Tag = 6
      Left = 36
      Top = 16
      Width = 24
      Height = 24
      Hint = 'Ult Priority 0'
      AllowAllUp = True
      GroupIndex = 7
      Caption = 'b6'
      ParentShowHint = False
      ShowHint = True
      OnClick = buttonPinCfgBitClick
    end
    object buttonPinCfgB5: TSpeedButton
      Tag = 5
      Left = 60
      Top = 16
      Width = 24
      Height = 24
      Hint = 'Hang Time 1'
      AllowAllUp = True
      GroupIndex = 6
      Caption = 'b5'
      ParentShowHint = False
      ShowHint = True
      OnClick = buttonPinCfgBitClick
    end
    object buttonPinCfgB4: TSpeedButton
      Tag = 4
      Left = 84
      Top = 16
      Width = 24
      Height = 24
      Hint = 'Hang Time 0'
      AllowAllUp = True
      GroupIndex = 5
      Caption = 'b4'
      ParentShowHint = False
      ShowHint = True
      OnClick = buttonPinCfgBitClick
    end
    object buttonPinCfgB3: TSpeedButton
      Tag = 3
      Left = 108
      Top = 16
      Width = 24
      Height = 24
      Hint = 'KeyOut1 Enable'
      AllowAllUp = True
      GroupIndex = 4
      Caption = 'b3'
      ParentShowHint = False
      ShowHint = True
      OnClick = buttonPinCfgBitClick
    end
    object buttonPinCfgB2: TSpeedButton
      Tag = 2
      Left = 132
      Top = 16
      Width = 24
      Height = 24
      Hint = 'KeyOut2 Enable'
      AllowAllUp = True
      GroupIndex = 3
      Caption = 'b2'
      ParentShowHint = False
      ShowHint = True
      OnClick = buttonPinCfgBitClick
    end
    object buttonPinCfgB1: TSpeedButton
      Tag = 1
      Left = 156
      Top = 16
      Width = 24
      Height = 24
      Hint = 'Sidetone Enable'
      AllowAllUp = True
      GroupIndex = 2
      Caption = 'b1'
      ParentShowHint = False
      ShowHint = True
      OnClick = buttonPinCfgBitClick
    end
    object buttonPinCfgB0: TSpeedButton
      Left = 180
      Top = 16
      Width = 24
      Height = 24
      Hint = 'PTT Enable'
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'b0'
      ParentShowHint = False
      ShowHint = True
      OnClick = buttonPinCfgBitClick
    end
    object Label1: TLabel
      Left = 210
      Top = 24
      Width = 12
      Height = 12
      Caption = #8594
    end
    object buttonSetPinCfg: TButton
      Left = 275
      Top = 17
      Width = 33
      Height = 25
      Caption = 'Set'
      TabOrder = 0
      OnClick = buttonSetPinCfgClick
    end
    object panelPinCfgParam: TPanel
      Left = 228
      Top = 16
      Width = 41
      Height = 24
      BevelOuter = bvLowered
      Caption = 'FF'
      TabOrder = 1
    end
  end
  object groupPtt: TGroupBox
    Left = 8
    Top = 63
    Width = 85
    Height = 49
    Caption = 'PTT'
    TabOrder = 1
    object buttonPttCmd: TSpeedButton
      Left = 8
      Top = 16
      Width = 69
      Height = 24
      AllowAllUp = True
      GroupIndex = 10
      Caption = 'PTT'
      OnClick = buttonPttCmdClick
    end
  end
  object groupMessage: TGroupBox
    Left = 8
    Top = 8
    Width = 370
    Height = 49
    Caption = 'Message'
    TabOrder = 2
    object editMessage: TEdit
      Left = 8
      Top = 20
      Width = 314
      Height = 20
      TabOrder = 0
      Text = 'CQ TEST CQ TEST DE JR8PPG PSE K'
    end
    object buttonSendMessage: TButton
      Left = 328
      Top = 17
      Width = 33
      Height = 25
      Caption = 'Set'
      TabOrder = 1
      OnClick = buttonSendMessageClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 120
    Width = 417
    Height = 57
    Caption = 'USBIF4CW'
    TabOrder = 3
    object buttonUsbif4cwP02: TSpeedButton
      Tag = 1
      Left = 87
      Top = 16
      Width = 73
      Height = 33
      AllowAllUp = True
      GroupIndex = 21
      Caption = 'P01(PTT)'
      OnClick = buttonUsbif4cwP00Click
    end
    object buttonUsbif4cwP03: TSpeedButton
      Tag = 2
      Left = 166
      Top = 16
      Width = 73
      Height = 33
      AllowAllUp = True
      GroupIndex = 22
      Caption = 'P02(RIG)'
      OnClick = buttonUsbif4cwP00Click
    end
    object buttonUsbif4cwP04: TSpeedButton
      Tag = 3
      Left = 245
      Top = 16
      Width = 73
      Height = 33
      AllowAllUp = True
      GroupIndex = 23
      Caption = 'P03(MIC)'
      OnClick = buttonUsbif4cwP00Click
    end
    object SpeedButton1: TSpeedButton
      Left = 8
      Top = 16
      Width = 73
      Height = 33
      AllowAllUp = True
      GroupIndex = 20
      Caption = 'P00(Key)'
      OnClick = buttonUsbif4cwP00Click
    end
  end
end
