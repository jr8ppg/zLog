object ZLinkForm: TZLinkForm
  Left = 200
  Top = 139
  Caption = 'Z-Link'
  ClientHeight = 333
  ClientWidth = 364
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object StatusLine: TStatusBar
    Left = 0
    Top = 310
    Width = 364
    Height = 23
    Panels = <>
    SimplePanel = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 247
    Width = 364
    Height = 63
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 8
      Top = 32
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 96
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Stay on top'
      TabOrder = 1
      OnClick = Button2Click
    end
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
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      ParentFont = False
      TabOrder = 2
      OnKeyPress = EditKeyPress
    end
    object Button: TButton
      Left = 176
      Top = 6
      Width = 105
      Height = 20
      Caption = 'Connect'
      TabOrder = 3
      OnClick = ButtonClick
    end
    object Button3: TButton
      Left = 232
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Button3'
      TabOrder = 4
      Visible = False
      OnClick = Button3Click
    end
  end
  object Console: TColorConsole2
    Left = 0
    Top = 0
    Width = 364
    Height = 247
    Align = alClient
    ParentColor = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    Rows = 500
    LineBreak = CR
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 8
    Top = 88
  end
  object ZSocket: TWSocket
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
    Left = 264
    Top = 184
  end
end
