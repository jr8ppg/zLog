object formInformation: TformInformation
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Information'
  ClientHeight = 32
  ClientWidth = 537
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
    Left = 221
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
  end
  object panelTime: TPanel
    Left = 451
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
  end
  object panelRxInfo: TPanel
    Left = 390
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
  end
  object Panel1: TPanel
    Left = 42
    Top = 0
    Width = 179
    Height = 32
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object ledPtt: TJvLED
      Left = 7
      Top = 12
      ColorOff = clSilver
      Status = False
    end
    object Label1: TLabel
      Left = 6
      Top = 2
      Width = 19
      Height = 11
      Caption = 'PTT'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object button2bsiq: TSpeedButton
      Left = 60
      Top = 3
      Width = 57
      Height = 25
      AllowAllUp = True
      GroupIndex = 1
      Caption = '2BSIQ'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      OnClick = button2bsiqClick
    end
    object buttonWait: TSpeedButton
      Left = 116
      Top = 3
      Width = 57
      Height = 25
      AllowAllUp = True
      GroupIndex = 2
      Down = True
      Caption = 'Wait'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      OnClick = buttonWaitClick
    end
    object ledWait: TJvLED
      Left = 30
      Top = 12
      ColorOn = clRed
      ColorOff = clLime
      Status = False
    end
    object Label2: TLabel
      Left = 30
      Top = 2
      Width = 19
      Height = 11
      Caption = 'Wait'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
  end
  object panelTxInfo: TPanel
    Left = 329
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
  end
end
