object ClusterClient: TClusterClient
  Left = 117
  Top = 174
  Caption = 'Cluster'
  ClientHeight = 241
  ClientWidth = 284
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = True
  Scaled = False
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 208
    Width = 284
    Height = 33
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      284
      33)
    object Edit: TEdit
      Left = 6
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
    object buttonConnect: TButton
      Left = 200
      Top = 5
      Width = 80
      Height = 20
      Anchors = [akRight, akBottom]
      Caption = 'Connect'
      TabOrder = 1
      OnClick = buttonConnectClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 28
    Width = 284
    Height = 180
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    ExplicitTop = 0
    ExplicitHeight = 208
    object Splitter1: TSplitter
      Left = 1
      Top = 87
      Width = 282
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
      Width = 282
      Height = 86
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
      ExplicitHeight = 114
    end
    object Console: TColorConsole2
      Left = 1
      Top = 91
      Width = 282
      Height = 88
      Align = alBottom
      ParentColor = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      Rows = 500
      LineBreak = CR
      ExplicitTop = 119
    end
  end
  object panelShowInfo: TPanel
    Left = 0
    Top = 0
    Width = 284
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
    ExplicitLeft = -240
    ExplicitTop = 66
    ExplicitWidth = 524
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
    OnDisplay = TelnetDisplay
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
    Left = 144
    Top = 76
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
  object ZServer: TWSocket
    LineEnd = #13#10
    Proto = 'tcp'
    LocalAddr = '0.0.0.0'
    LocalAddr6 = '::'
    LocalPort = '0'
    SocksLevel = '5'
    ExclusiveAddr = False
    ComponentOptions = []
    ListenBacklog = 15
    OnSessionClosed = ZServerSessionClosed
    OnSessionConnected = ZServerSessionConnected
    SocketErrs = wsErrTech
    Left = 88
    Top = 112
  end
  object timerShowInfo: TTimer
    Enabled = False
    Interval = 20
    OnTimer = timerShowInfoTimer
    Left = 152
    Top = 147
  end
end
