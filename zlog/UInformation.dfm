object formInformation: TformInformation
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Information'
  ClientHeight = 32
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
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
    ExplicitLeft = 171
  end
  object panelTime: TPanel
    Left = 390
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
    ExplicitLeft = 340
  end
  object panelRigInfo: TPanel
    Left = 329
    Top = 0
    Width = 61
    Height = 32
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    ExplicitLeft = 279
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
    ExplicitWidth = 129
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
      Width = 109
      Height = 25
      AllowAllUp = True
      GroupIndex = 1
      Down = True
      Caption = 'Auto RIG switch'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      OnClick = buttonAutoRigSwitchClick
    end
  end
end
