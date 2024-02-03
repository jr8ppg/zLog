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
    ExplicitTop = 188
    ExplicitWidth = 330
  end
  object Panel1: TPanel
    Left = 0
    Top = 132
    Width = 334
    Height = 57
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 131
    ExplicitWidth = 330
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
  object Console: TColorConsole2
    Left = 0
    Top = 0
    Width = 334
    Height = 132
    Align = alClient
    ParentColor = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    Rows = 500
    LineBreak = CR
    ExplicitWidth = 330
    ExplicitHeight = 131
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 36
    Top = 36
  end
  object ZSocket: TWSocket
    LineMode = True
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
    Left = 68
    Top = 36
  end
end
