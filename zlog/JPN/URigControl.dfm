object RigControl: TRigControl
  Left = 666
  Top = 35
  Caption = 'Rig Control'
  ClientHeight = 136
  ClientWidth = 318
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
  PixelsPerInch = 96
  TextHeight = 15
  object Panel6: TPanel
    Left = 0
    Top = 30
    Width = 318
    Height = 106
    Align = alClient
    TabOrder = 0
    object buttonJumpLastFreq: TSpeedButton
      Left = 264
      Top = 21
      Width = 44
      Height = 20
      Caption = 'Jump'
      OnClick = buttonJumpLastFreqClick
    end
    object Label1: TLabel
      Left = 201
      Top = 26
      Width = 55
      Height = 15
      Caption = 'Last Freq.'
    end
    object Label2: TLabel
      Left = 8
      Top = 47
      Width = 32
      Height = 15
      Caption = 'VFO A'
    end
    object Label3: TLabel
      Left = 8
      Top = 74
      Width = 34
      Height = 15
      Caption = 'VFO B'
    end
    object Label4: TLabel
      Left = 51
      Top = 26
      Width = 72
      Height = 15
      Caption = 'Current Freq.'
    end
    object RigLabel: TLabel
      Left = 8
      Top = 5
      Width = 50
      Height = 15
      Caption = 'RigLabel'
    end
    object Panel1: TPanel
      Left = 50
      Top = 42
      Width = 143
      Height = 25
      BevelOuter = bvLowered
      TabOrder = 0
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
      Top = 71
      Width = 143
      Height = 25
      BevelOuter = bvLowered
      TabOrder = 1
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
      Top = 42
      Width = 108
      Height = 25
      BevelOuter = bvLowered
      TabOrder = 2
      object dispLastFreq: TLabel
        Left = 5
        Top = 5
        Width = 97
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '000.000.000 kHz'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object Panel4: TPanel
      Left = 200
      Top = 71
      Width = 54
      Height = 25
      BevelOuter = bvLowered
      TabOrder = 3
      object dispMode: TLabel
        Left = 6
        Top = 4
        Width = 44
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Mode'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object Panel5: TPanel
      Left = 255
      Top = 71
      Width = 54
      Height = 25
      BevelOuter = bvLowered
      TabOrder = 4
      object dispVFO: TLabel
        Left = 6
        Top = 4
        Width = 42
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'VFO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object Panel7: TPanel
    Left = 0
    Top = 0
    Width = 318
    Height = 30
    Align = alTop
    TabOrder = 1
    DesignSize = (
      318
      30)
    object ToggleSwitch1: TToggleSwitch
      Left = 4
      Top = 4
      Width = 79
      Height = 20
      State = tssOn
      StateCaptions.CaptionOn = 'ON'
      StateCaptions.CaptionOff = 'OFF'
      TabOrder = 0
      OnClick = ToggleSwitch1Click
    end
    object buttonOmniRig: TButton
      Left = 168
      Top = 2
      Width = 73
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Omni-Rig'
      TabOrder = 1
      OnClick = buttonOmniRigClick
    end
    object buttonReconnectRigs: TButton
      Left = 242
      Top = 2
      Width = 73
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Reset Rig'
      TabOrder = 2
      OnClick = buttonReconnectRigsClick
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 136
  end
  object PollingTimer1: TTimer
    Tag = 1
    Enabled = False
    Interval = 100
    OnTimer = PollingTimerTimer
    Left = 164
  end
  object ZCom1: TCommPortDriver
    Tag = 1
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfRTSCTS
    InBufSize = 4096
    OnReceiveData = ZCom1ReceiveData
    Left = 244
  end
  object ZCom2: TCommPortDriver
    Tag = 2
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfRTSCTS
    InBufSize = 4096
    OnReceiveData = ZCom1ReceiveData
    Left = 272
  end
  object PollingTimer2: TTimer
    Tag = 2
    Enabled = False
    Interval = 100
    OnTimer = PollingTimerTimer
    Left = 192
  end
end
