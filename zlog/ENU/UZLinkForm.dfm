object ZLinkForm: TZLinkForm
  Left = 200
  Top = 139
  Caption = 'Z-Link'
  ClientHeight = 212
  ClientWidth = 334
  Color = clBtnFace
  Constraints.MinHeight = 250
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 12
  object StatusLine: TStatusBar
    Left = 0
    Top = 189
    Width = 334
    Height = 23
    Panels = <>
    SimplePanel = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 132
    Width = 334
    Height = 57
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Edit: TEdit
      Left = 8
      Top = 6
      Width = 161
      Height = 20
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyPress = EditKeyPress
    end
    object ConnectButton: TButton
      Left = 8
      Top = 32
      Width = 90
      Height = 20
      Caption = 'Connect'
      TabOrder = 1
      OnClick = ConnectButtonClick
    end
  end
  object Console: TListBox
    Left = 0
    Top = 0
    Width = 334
    Height = 132
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    ItemHeight = 12
    ParentFont = False
    TabOrder = 0
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 36
    Top = 36
  end
  object ZSocket: TSslWSocket
    LineEnd = #13#10
    Proto = 'tcp'
    LocalAddr = '0.0.0.0'
    LocalAddr6 = '::'
    LocalPort = '0'
    SocksLevel = '5'
    ExclusiveAddr = False
    ComponentOptions = []
    ListenBacklog = 15
    OnDataAvailable = ZSocketDataAvailable
    OnSessionClosed = ZSocketSessionClosed
    OnSessionConnected = ZSocketSessionConnected
    SocketErrs = wsErrTech
    SslContext = ZSslContext
    SslEnable = False
    SslMode = sslModeClient
    OnSslHandshakeDone = ZSocketSslHandshakeDone
    Left = 80
    Top = 32
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
    Left = 112
    Top = 32
  end
  object timerLoginCheck: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = timerLoginCheckTimer
    Left = 148
    Top = 32
  end
end
