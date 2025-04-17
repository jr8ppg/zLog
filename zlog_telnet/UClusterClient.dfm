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
    ExplicitTop = 124
    ExplicitWidth = 284
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
    ExplicitWidth = 284
    ExplicitHeight = 96
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
    ExplicitWidth = 284
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
    Left = 16
    Top = 24
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
end
