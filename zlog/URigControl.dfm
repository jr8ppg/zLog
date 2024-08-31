object RigControl: TRigControl
  Left = 666
  Top = 35
  Caption = 'Rig Control'
  ClientHeight = 157
  ClientWidth = 318
  Color = clBtnFace
  Constraints.MinHeight = 195
  Constraints.MinWidth = 330
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  Position = poDesigned
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object panelBody: TPanel
    Left = 0
    Top = 30
    Width = 318
    Height = 103
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 314
    ExplicitHeight = 102
    DesignSize = (
      318
      103)
    object buttonJumpLastFreq: TSpeedButton
      Left = 265
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
      Top = 75
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
      Left = 6
      Top = 5
      Width = 171
      Height = 15
      AutoSize = False
      Caption = 'RigLabel'
    end
    object buttonMemoryClear: TSpeedButton
      Tag = 2
      Left = 215
      Top = 2
      Width = 36
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'MC'
      OnClick = buttonMemoryWriteClick
    end
    object buttonMemoryWrite: TSpeedButton
      Tag = 1
      Left = 180
      Top = 2
      Width = 36
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'MW'
      OnClick = buttonMemoryWriteClick
    end
    object buttonMemScan: TSpeedButton
      Tag = 2
      Left = 254
      Top = 2
      Width = 55
      Height = 20
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 1
      Caption = 'M-Scan'
      OnClick = buttonMemScanClick
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
  object panelHeader: TPanel
    Left = 0
    Top = 0
    Width = 318
    Height = 30
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 314
    DesignSize = (
      318
      30)
    object ToggleSwitch1: TToggleSwitch
      Left = 4
      Top = 4
      Width = 79
      Height = 20
      StateCaptions.CaptionOn = 'ON'
      StateCaptions.CaptionOff = 'OFF'
      TabOrder = 0
      OnClick = ToggleSwitch1Click
    end
    object buttonOmniRig: TButton
      Left = 178
      Top = 3
      Width = 65
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Omni-Rig'
      TabOrder = 1
      OnClick = buttonOmniRigClick
      ExplicitLeft = 174
    end
    object buttonReconnectRigs: TButton
      Left = 244
      Top = 3
      Width = 65
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Reset'
      TabOrder = 2
      OnClick = buttonReconnectRigsClick
      ExplicitLeft = 240
    end
    object panelMScan: TPanel
      Left = 93
      Top = 3
      Width = 85
      Height = 25
      BevelOuter = bvNone
      BorderWidth = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2588671
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object labelMScan: TLabel
        Left = 5
        Top = 3
        Width = 75
        Height = 16
        Alignment = taCenter
        Caption = 'M-Scan'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
    end
  end
  object buttongrpFreqMemory: TButtonGroup
    Left = 0
    Top = 133
    Width = 318
    Height = 24
    Align = alBottom
    BorderStyle = bsNone
    ButtonWidth = 62
    Items = <
      item
        Caption = 'M1'
        OnClick = buttongrpFreqMemoryItems0Click
      end
      item
        Caption = 'M2'
        OnClick = buttongrpFreqMemoryItems1Click
      end
      item
        Caption = 'M3'
        OnClick = buttongrpFreqMemoryItems2Click
      end
      item
        Caption = 'M4'
        OnClick = buttongrpFreqMemoryItems3Click
      end
      item
        Caption = 'M5'
        OnClick = buttongrpFreqMemoryItems4Click
      end>
    ShowHint = True
    TabOrder = 2
    ExplicitTop = 132
    ExplicitWidth = 314
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 32
    Top = 212
  end
  object PollingTimer1: TTimer
    Tag = 1
    Enabled = False
    Interval = 100
    OnTimer = PollingTimerTimer
    Left = 60
    Top = 212
  end
  object ZCom1: TCommPortDriver
    Tag = 1
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfRTSCTS
    InBufSize = 4096
    OnReceiveData = ZCom1ReceiveData
    Left = 44
    Top = 160
  end
  object ZCom2: TCommPortDriver
    Tag = 2
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfRTSCTS
    InBufSize = 4096
    OnReceiveData = ZCom1ReceiveData
    Left = 72
    Top = 160
  end
  object PollingTimer2: TTimer
    Tag = 2
    Enabled = False
    Interval = 100
    OnTimer = PollingTimerTimer
    Left = 88
    Top = 212
  end
  object ZCom3: TCommPortDriver
    Tag = 3
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfRTSCTS
    InBufSize = 4096
    OnReceiveData = ZCom1ReceiveData
    Left = 100
    Top = 160
  end
  object ZCom4: TCommPortDriver
    Tag = 4
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfRTSCTS
    InBufSize = 4096
    OnReceiveData = ZCom1ReceiveData
    Left = 128
    Top = 160
  end
  object PollingTimer3: TTimer
    Tag = 3
    Enabled = False
    Interval = 100
    OnTimer = PollingTimerTimer
    Left = 116
    Top = 212
  end
  object PollingTimer4: TTimer
    Tag = 4
    Enabled = False
    Interval = 100
    OnTimer = PollingTimerTimer
    Left = 144
    Top = 212
  end
  object popupMemoryCh: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    OnPopup = popupMemoryChPopup
    Left = 8
    Top = 54
    object menuM1: TMenuItem
      Tag = 1
      Caption = 'M1'
      OnClick = menuMnClick
    end
    object menuM2: TMenuItem
      Tag = 2
      Caption = 'M2'
      OnClick = menuMnClick
    end
    object menuM3: TMenuItem
      Tag = 3
      Caption = 'M3'
      OnClick = menuMnClick
    end
    object menuM4: TMenuItem
      Tag = 4
      Caption = 'M4'
      OnClick = menuMnClick
    end
    object menuM5: TMenuItem
      Tag = 5
      Caption = 'M5'
      OnClick = menuMnClick
    end
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 350
    OnTimer = Timer2Timer
    Left = 274
    Top = 120
  end
end
