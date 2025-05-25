object RigControl: TRigControl
  Left = 666
  Top = 35
  Caption = 'Rig Control'
  ClientHeight = 171
  ClientWidth = 384
  Color = clBtnFace
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
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
    Top = 24
    Width = 384
    Height = 75
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 105
    DesignSize = (
      384
      75)
    object buttonJumpLastFreq: TSpeedButton
      Left = 315
      Top = 18
      Width = 62
      Height = 54
      Anchors = [akTop, akRight]
      Caption = 'Last Freq.'#13#10#12408#13#10#12472#12515#12531#12503
      OnClick = buttonJumpLastFreqClick
    end
    object Label1: TLabel
      Left = 201
      Top = 4
      Width = 55
      Height = 15
      Anchors = [akTop, akRight]
      Caption = 'Last Freq.'
    end
    object Label2: TLabel
      Left = 8
      Top = 23
      Width = 32
      Height = 15
      Caption = 'VFO A'
    end
    object Label3: TLabel
      Left = 8
      Top = 51
      Width = 34
      Height = 15
      Caption = 'VFO B'
    end
    object Label4: TLabel
      Left = 51
      Top = 4
      Width = 72
      Height = 15
      Caption = 'Current Freq.'
    end
    object Panel1: TPanel
      Left = 50
      Top = 18
      Width = 143
      Height = 25
      Anchors = [akLeft, akTop, akRight]
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
      Top = 47
      Width = 143
      Height = 25
      Anchors = [akLeft, akTop, akRight]
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
      Top = 18
      Width = 108
      Height = 25
      Anchors = [akTop, akRight]
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
      Top = 47
      Width = 54
      Height = 25
      Anchors = [akTop, akRight]
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
      Top = 47
      Width = 54
      Height = 25
      Anchors = [akTop, akRight]
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
    Width = 384
    Height = 24
    Align = alTop
    TabOrder = 1
    DesignSize = (
      384
      24)
    object buttonOmniRig: TSpeedButton
      Tag = 2
      Left = 265
      Top = 2
      Width = 58
      Height = 19
      Anchors = [akTop, akRight]
      Caption = 'Omni-Rig'
      OnClick = buttonOmniRigClick
    end
    object buttonReconnectRigs: TSpeedButton
      Tag = 2
      Left = 322
      Top = 2
      Width = 58
      Height = 19
      Anchors = [akTop, akRight]
      Caption = 'RESET'
      OnClick = buttonReconnectRigsClick
    end
    object RigLabel: TLabel
      Left = 89
      Top = 4
      Width = 171
      Height = 16
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'RigLabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ToggleSwitch1: TToggleSwitch
      Left = 4
      Top = 2
      Width = 79
      Height = 20
      StateCaptions.CaptionOn = 'ON'
      StateCaptions.CaptionOff = 'OFF'
      TabOrder = 0
      OnClick = ToggleSwitch1Click
    end
  end
  object buttongrpFreqMemory: TButtonGroup
    Left = 0
    Top = 147
    Width = 384
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
      end
      item
        Caption = 'M6'
        OnClick = buttongrpFreqMemoryItems5Click
      end>
    ShowHint = True
    TabOrder = 2
    ExplicitTop = 177
  end
  object panelMemScan: TPanel
    Left = 0
    Top = 99
    Width = 384
    Height = 24
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 129
    DesignSize = (
      384
      24)
    object buttonMemoryClear: TSpeedButton
      Tag = 2
      Left = 159
      Top = 2
      Width = 30
      Height = 19
      Anchors = [akTop, akRight]
      Caption = 'MC'
      OnClick = buttonMemoryWriteClick
      ExplicitLeft = 93
    end
    object buttonMemoryWrite: TSpeedButton
      Tag = 1
      Left = 129
      Top = 2
      Width = 30
      Height = 19
      Anchors = [akTop, akRight]
      Caption = 'MW'
      OnClick = buttonMemoryWriteClick
      ExplicitLeft = 63
    end
    object buttonMemScan: TSpeedButton
      Tag = 2
      Left = 192
      Top = 2
      Width = 55
      Height = 19
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 1
      Caption = 'M-Scan'
      OnClick = buttonMemScanClick
      ExplicitLeft = 126
    end
    object buttonMemScanAuto: TSpeedButton
      Left = 250
      Top = 2
      Width = 43
      Height = 19
      Anchors = [akTop, akRight]
      GroupIndex = 7
      Down = True
      Caption = 'AUTO'
      ExplicitLeft = 184
    end
    object buttonMemScanRigA: TSpeedButton
      Tag = 1
      Left = 292
      Top = 2
      Width = 43
      Height = 19
      Anchors = [akTop, akRight]
      GroupIndex = 7
      Caption = 'RIG-A'
      ExplicitLeft = 226
    end
    object buttonMemScanRigB: TSpeedButton
      Tag = 2
      Left = 334
      Top = 2
      Width = 43
      Height = 19
      Anchors = [akTop, akRight]
      GroupIndex = 7
      Caption = 'RIG-B'
      ExplicitLeft = 268
    end
    object ledMemScan: TJvLED
      Left = 4
      Top = 4
      ColorOn = clRed
      ColorOff = clSilver
      Interval = 350
      Status = False
    end
    object labelMemScan: TLabel
      Left = 25
      Top = 5
      Width = 30
      Height = 15
      Caption = 'RIG-9'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object labelScanMemChNo: TLabel
      Left = 81
      Top = 5
      Width = 17
      Height = 15
      Caption = 'M1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object panelSpotImport: TPanel
    Left = 0
    Top = 123
    Width = 384
    Height = 24
    Align = alBottom
    TabOrder = 4
    ExplicitTop = 153
    DesignSize = (
      384
      24)
    object buttonImportAuto: TSpeedButton
      Left = 250
      Top = 2
      Width = 43
      Height = 19
      Anchors = [akTop, akRight]
      GroupIndex = 6
      Down = True
      Caption = 'AUTO'
      ExplicitLeft = 184
    end
    object buttonImportRigA: TSpeedButton
      Tag = 1
      Left = 292
      Top = 2
      Width = 43
      Height = 19
      Anchors = [akTop, akRight]
      GroupIndex = 6
      Caption = 'RIG-A'
      ExplicitLeft = 226
    end
    object buttonImportRigB: TSpeedButton
      Tag = 2
      Left = 334
      Top = 2
      Width = 43
      Height = 19
      Anchors = [akTop, akRight]
      GroupIndex = 6
      Caption = 'RIG-B'
      ExplicitLeft = 268
    end
    object Label5: TLabel
      Left = 150
      Top = 6
      Width = 83
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #12473#12509#12483#12488#21462#12426#36796#12415#20808
      ExplicitLeft = 97
    end
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
    Left = 280
    Top = 174
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
    object menuM6: TMenuItem
      Tag = 6
      Caption = 'M6'
      OnClick = menuMnClick
    end
  end
end
