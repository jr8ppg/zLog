object formInformation: TformInformation
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Information'
  ClientHeight = 32
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlue
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object panelCQMode: TPanel
    Left = 0
    Top = 0
    Width = 42
    Height = 32
    Align = alLeft
    Caption = 'CQ'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = panelCQModeClick
  end
  object panelWpmInfo: TPanel
    Left = 222
    Top = 0
    Width = 108
    Height = 32
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = 221
  end
  object panelTime: TPanel
    Left = 452
    Top = 0
    Width = 86
    Height = 32
    Align = alRight
    Caption = '21:00:00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitLeft = 390
  end
  object panelRxInfo: TPanel
    Left = 391
    Top = 0
    Width = 61
    Height = 32
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    ExplicitLeft = 329
  end
  object Panel1: TPanel
    Left = 42
    Top = 0
    Width = 180
    Height = 32
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    ExplicitWidth = 179
    object ledPtt: TJvLED
      Left = 33
      Top = 8
      Status = False
    end
    object Label1: TLabel
      Left = 6
      Top = 11
      Width = 21
      Height = 12
      Caption = 'PTT'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object buttonAutoRigSwitch: TSpeedButton
      Left = 60
      Top = 3
      Width = 57
      Height = 25
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'RIG sw.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      OnClick = buttonAutoRigSwitchClick
    end
    object buttonCqInvert: TSpeedButton
      Left = 116
      Top = 3
      Width = 57
      Height = 25
      AllowAllUp = True
      GroupIndex = 2
      Caption = 'CQ Inv.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      OnClick = buttonAutoRigSwitchClick
    end
  end
  object panelTxInfo: TPanel
    Left = 330
    Top = 0
    Width = 61
    Height = 32
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    ExplicitLeft = 263
    ExplicitTop = -2
  end
end
