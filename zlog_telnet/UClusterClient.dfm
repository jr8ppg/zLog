object ClusterClient: TClusterClient
  Left = 117
  Top = 174
  Caption = 'Cluster'
  ClientHeight = 242
  ClientWidth = 288
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  Scaled = False
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 125
    Width = 288
    Height = 117
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      288
      117)
    object TabControl1: TTabControl
      Left = 4
      Top = 4
      Width = 279
      Height = 108
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Tabs.Strings = (
        'Site1'
        'Site2')
      TabIndex = 0
      OnChange = TabControl1Change
      OnChanging = TabControl1Changing
      DesignSize = (
        279
        108)
      object Label1: TLabel
        Left = 7
        Top = 24
        Width = 38
        Height = 12
        Caption = #25509#32154#20808':'
        Layout = tlCenter
      end
      object labelHostName: TLabel
        Left = 7
        Top = 43
        Width = 260
        Height = 13
        AutoSize = False
        Layout = tlCenter
      end
      object Label2: TLabel
        Left = 7
        Top = 59
        Width = 54
        Height = 12
        Caption = #12525#12464#12452#12531'ID:'
        Layout = tlCenter
      end
      object labelLoginID: TLabel
        Left = 67
        Top = 59
        Width = 200
        Height = 13
        AutoSize = False
        Layout = tlCenter
      end
      object buttonConnect: TButton
        Left = 197
        Top = 78
        Width = 75
        Height = 20
        Anchors = [akTop, akRight]
        Caption = #25509#32154
        TabOrder = 1
        OnClick = buttonConnectClick
      end
      object Edit: TComboBox
        Left = 7
        Top = 78
        Width = 183
        Height = 20
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnKeyPress = EditKeyPress
        OnSelect = EditSelect
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 28
    Width = 288
    Height = 97
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 44
      Width = 286
      Height = 4
      Cursor = crVSplit
      Align = alBottom
      MinSize = 1
      ExplicitTop = 176
      ExplicitWidth = 373
    end
    object ListBox: TListBox
      Left = 1
      Top = 1
      Width = 286
      Height = 43
      Style = lbOwnerDrawVariable
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ItemHeight = 12
      ParentFont = False
      TabOrder = 0
      OnDrawItem = ListBoxDrawItem
      OnMeasureItem = ListBoxMeasureItem
    end
    object Console: TListBox
      Left = 1
      Top = 48
      Width = 286
      Height = 48
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ItemHeight = 12
      ParentFont = False
      TabOrder = 1
    end
  end
  object panelShowInfo: TPanel
    Left = 0
    Top = 0
    Width = 288
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Z-LINK'#12363#12425#20999#26029#12375#12414#12375#12383
    Color = clRed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -15
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    Visible = False
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerProcess
    Left = 40
    Top = 56
  end
  object Telnet: TTnCnx
    Port = '23'
    Host = 'ac4et.ampr.org'
    Location = 'TNCNX'
    TermType = 'VT100'
    LocalEcho = False
    SocketFamily = sfIPv4
    OnSessionConnected = TelnetSessionConnected
    OnSessionClosed = TelnetSessionClosed
    OnDataAvailable = TelnetDataAvailable
    Left = 88
    Top = 53
  end
  object PopupMenu: TPopupMenu
    Left = 208
    Top = 48
    object Deleteselectedspots1: TMenuItem
      Caption = 'Delete selected spots'
    end
  end
  object MainMenu1: TMainMenu
    Left = 152
    Top = 44
    object menuFunc: TMenuItem
      Caption = #27231#33021'(&F)'
      object menuSettings: TMenuItem
        Caption = #35373#23450'(&S)'
        OnClick = menuSettingsClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object menuExit: TMenuItem
        Caption = #32066#20102'(&X)'
        OnClick = menuExitClick
      end
    end
  end
  object timerShowInfo: TTimer
    Enabled = False
    Interval = 20
    OnTimer = timerShowInfoTimer
    Left = 88
    Top = 107
  end
  object timerForceReconnect: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = timerForceReconnectTimer
    Left = 220
    Top = 112
  end
  object timerReConnect: TTimer
    Enabled = False
    OnTimer = timerReConnectTimer
    Left = 148
    Top = 104
  end
  object ZServer: TSslWSocket
    LineEnd = #13#10
    Proto = 'tcp'
    LocalAddr = '0.0.0.0'
    LocalAddr6 = '::'
    LocalPort = '0'
    SocksLevel = '5'
    ExclusiveAddr = False
    ComponentOptions = []
    ListenBacklog = 15
    OnDataAvailable = ZServerDataAvailable
    OnSessionClosed = ZServerSessionClosed
    OnSessionConnected = ZServerSessionConnected
    SocketErrs = wsErrTech
    SslContext = ZSslContext
    SslEnable = False
    SslMode = sslModeClient
    OnSslHandshakeDone = ZServerSslHandshakeDone
    Left = 16
    Top = 16
  end
  object ZSslContext: TSslContext
    SslDHParamLines.Strings = (
      '-----BEGIN DH PARAMETERS-----'
      'MIICCAKCAgEA45KZVdTCptcakXZb7jJvSuuOdMlUbl1tpncHbQcYbFhRbcFmmefp'
      'bOmZsTowlWHQpoYRRTe6NEvYox8J+44i/X5cJkMTlIgMb0ZBty7t76U9f6qAId/O'
      '6elE0gnk2ThER9nmBcUA0ZKgSXn0XCBu6j5lzZ0FS+bx9OVNhlzvIFBclRPXbI58'
      '71dRoTjOjfO1SIzV69T3FoKJcqur58l8b+no/TOQzekMzz4XJTRDefqvePhj7ULP'
      'Z/Zg7vtEh11h8gHR0/rlF378S05nRMq5hbbJeLxIbj9kxQunETSbwwy9qx0SyQgH'
      'g+90+iUCrKCJ9Fb7WKqtQLkQuzJIkkXkXUyuxUuyBOeeP9XBUAOQu+eYnRPYSmTH'
      'GkhyRbIRTPCDiBWDFOskdyGYYDrxiK7LYJQanqHlEFtjDv9t1XmyzDm0k7W9oP/J'
      'p0ox1+WIpFgkfv6nvihqCPHtAP5wevqXNIQADhDk5EyrR3XWRFaySeKcmREM9tbc'
      'bOvmsEp5MWCC81ZsnaPAcVpO66aOPojNiYQZUbmm70fJsr8BDzXGpcQ44+wmL4Ds'
      'k3+ldVWAXEXs9s1vfl4nLNXefYl74cV8E5Mtki9hCjUrUQ4dzbmNA5fg1CyQM/v7'
      'JuP6PBYFK7baFDjG1F5YJiO0uHo8sQx+SWdJnGsq8piI3w0ON9JhUvMCAQI='
      '-----END DH PARAMETERS-----')
    SslVerifyPeer = False
    SslVerifyDepth = 9
    SslVerifyFlags = []
    SslVerifyFlagsValue = 0
    SslCheckHostFlags = []
    SslCheckHostFlagsValue = 0
    SslSecLevel = sslSecLevel80bits
    SslOptions = [sslOpt_NO_SSLv2, sslOpt_NO_SSLv3]
    SslOptions2 = [sslOpt2_ALLOW_UNSAFE_LEGACY_RENEGOTIATION, SslOpt2_LEGACY_SERVER_CONNECT]
    SslVerifyPeerModes = [SslVerifyMode_PEER]
    SslVerifyPeerModesValue = 1
    SslSessionCacheModes = []
    SslCipherList = 'ALL'
    SslCipherList13 = 
      'TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_' +
      'GCM_SHA256'
    SslVersionMethod = sslBestVer
    SslMinVersion = sslVerTLS1
    SslMaxVersion = sslVerMax
    SslECDHMethod = sslECDHNone
    SslCryptoGroups = 'P-256:X25519:P-384:P-521'
    SslCliSecurity = sslCliSecTls1
    SslOcspStatus = False
    UseSharedCAStore = False
    SslSessionTimeout = 0
    SslSessionCacheSize = 20480
    AutoEnableBuiltinEngines = False
    Left = 48
    Top = 16
  end
  object timerLoginCheck: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = timerLoginCheckTimer
    Left = 80
    Top = 16
  end
end
