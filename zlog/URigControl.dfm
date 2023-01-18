object RigControl: TRigControl
  Left = 666
  Top = 35
  Caption = 'Rig Control'
  ClientHeight = 137
  ClientWidth = 314
  Color = clBtnFace
  Constraints.MinHeight = 175
  Constraints.MinWidth = 330
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poDesigned
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    314
    137)
  PixelsPerInch = 96
  TextHeight = 15
  object dispMode: TLabel
    Left = 8
    Top = 97
    Width = 30
    Height = 15
    Caption = 'Mode'
  end
  object RigLabel: TLabel
    Left = 8
    Top = 4
    Width = 50
    Height = 15
    Caption = 'RigLabel'
  end
  object Label2: TLabel
    Left = 8
    Top = 45
    Width = 32
    Height = 15
    Caption = 'VFO A'
  end
  object Label3: TLabel
    Left = 8
    Top = 72
    Width = 34
    Height = 15
    Caption = 'VFO B'
  end
  object Label1: TLabel
    Left = 201
    Top = 24
    Width = 55
    Height = 15
    Caption = 'Last Freq.'
  end
  object Label4: TLabel
    Left = 51
    Top = 24
    Width = 72
    Height = 15
    Caption = 'Current Freq.'
  end
  object buttonJumpLastFreq: TSpeedButton
    Left = 262
    Top = 19
    Width = 44
    Height = 20
    Caption = 'Jump'
    OnClick = buttonJumpLastFreqClick
  end
  object Button1: TButton
    Left = 233
    Top = 107
    Width = 73
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Reset Rig'
    TabOrder = 0
    OnClick = Button1Click
  end
  object dispVFO: TStaticText
    Left = 8
    Top = 117
    Width = 27
    Height = 19
    Caption = 'VFO'
    TabOrder = 1
  end
  object btnOmniRig: TButton
    Left = 155
    Top = 107
    Width = 73
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Omni-Rig'
    TabOrder = 2
    OnClick = btnOmniRigClick
  end
  object Panel1: TPanel
    Left = 50
    Top = 40
    Width = 143
    Height = 25
    BevelOuter = bvLowered
    TabOrder = 3
    object dispFreqA: TLabel
      Left = 4
      Top = 4
      Width = 136
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = '00000.000 kHz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 50
    Top = 69
    Width = 143
    Height = 25
    BevelOuter = bvLowered
    TabOrder = 4
    object dispFreqB: TLabel
      Left = 4
      Top = 4
      Width = 136
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = '00000.000 kHz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel3: TPanel
    Left = 201
    Top = 40
    Width = 108
    Height = 25
    BevelOuter = bvLowered
    TabOrder = 5
    object dispLastFreq: TStaticText
      Left = 5
      Top = 4
      Width = 99
      Height = 20
      Alignment = taCenter
      AutoSize = False
      Caption = '00000.000 kHz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 104
    Top = 144
  end
  object PollingTimer1: TTimer
    Tag = 1
    Enabled = False
    Interval = 100
    OnTimer = PollingTimerTimer
    Left = 132
    Top = 144
  end
  object ZCom1: TCommPortDriver
    Tag = 1
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfRTSCTS
    InBufSize = 4096
    OnReceiveData = ZCom1ReceiveData
    Left = 212
    Top = 144
  end
  object ZCom2: TCommPortDriver
    Tag = 2
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfRTSCTS
    InBufSize = 4096
    OnReceiveData = ZCom1ReceiveData
    Left = 240
    Top = 144
  end
  object PollingTimer2: TTimer
    Tag = 2
    Enabled = False
    Interval = 100
    OnTimer = PollingTimerTimer
    Left = 160
    Top = 144
  end
end
