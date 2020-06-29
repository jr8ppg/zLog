object RigControl: TRigControl
  Left = 666
  Top = 35
  Caption = 'Rig Control'
  ClientHeight = 121
  ClientWidth = 284
  Color = clBtnFace
  Constraints.MinHeight = 160
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  DesignSize = (
    284
    121)
  PixelsPerInch = 96
  TextHeight = 12
  object dispMode: TLabel
    Left = 8
    Top = 80
    Width = 30
    Height = 15
    Caption = 'Mode'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object RigLabel: TLabel
    Left = 8
    Top = 8
    Width = 50
    Height = 15
    Caption = 'RigLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 33
    Width = 39
    Height = 16
    Caption = 'VFO A'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 57
    Width = 40
    Height = 16
    Caption = 'VFO B'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 203
    Top = 88
    Width = 73
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Reset rig'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
    ExplicitLeft = 290
    ExplicitTop = 93
  end
  object dispFreqA: TStaticText
    Left = 64
    Top = 32
    Width = 83
    Height = 23
    Caption = 'dispFreqA'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object dispFreqB: TStaticText
    Left = 64
    Top = 56
    Width = 84
    Height = 23
    Caption = 'dispFreqB'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object dispVFO: TStaticText
    Left = 8
    Top = 100
    Width = 27
    Height = 16
    Caption = 'VFO'
    TabOrder = 3
  end
  object btnOmniRig: TButton
    Left = 124
    Top = 88
    Width = 73
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Omni-Rig'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnOmniRigClick
    ExplicitLeft = 211
    ExplicitTop = 93
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 108
    Top = 65528
  end
  object PollingTimer1: TTimer
    Tag = 1
    Enabled = False
    Interval = 100
    OnTimer = PollingTimerTimer
    Left = 236
    Top = 65528
  end
  object ZCom1: TCommPortDriver
    Tag = 1
    Port = pnCustom
    PortName = '\\.\COM2'
    InBufSize = 4096
    OnReceiveData = ZCom1ReceiveData
    Left = 140
    Top = 65528
  end
  object ZCom2: TCommPortDriver
    Tag = 2
    Port = pnCustom
    PortName = '\\.\COM2'
    InBufSize = 4096
    OnReceiveData = ZCom1ReceiveData
    Left = 168
    Top = 65528
  end
  object ZCom3: TCommPortDriver
    Tag = 3
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfNONE
    InBufSize = 4096
    EnableDTROnOpen = False
    Left = 196
    Top = 65528
  end
  object PollingTimer2: TTimer
    Tag = 2
    Enabled = False
    Interval = 100
    OnTimer = PollingTimerTimer
    Left = 264
    Top = 65528
  end
end
