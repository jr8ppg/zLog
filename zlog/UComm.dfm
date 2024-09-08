object CommForm: TCommForm
  Left = 117
  Top = 174
  Caption = 'Cluster'
  ClientHeight = 262
  ClientWidth = 471
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 119
    Width = 471
    Height = 120
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 96
    ExplicitWidth = 350
    object checkAutoLogin: TCheckBox
      Left = 291
      Top = 6
      Width = 167
      Height = 17
      Caption = 'Auto Login'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object checkRelaySpot: TCheckBox
      Left = 291
      Top = 44
      Width = 167
      Height = 17
      Caption = 'Relay spot to other bands'
      TabOrder = 3
    end
    object checkAutoReconnect: TCheckBox
      Left = 291
      Top = 25
      Width = 167
      Height = 17
      Caption = 'Auto Reconnect'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object checkRecordLogs: TCheckBox
      Left = 291
      Top = 62
      Width = 81
      Height = 17
      Caption = 'Record logs'
      TabOrder = 4
    end
    object checkUseAllowDenyLists: TCheckBox
      Left = 291
      Top = 80
      Width = 167
      Height = 17
      Caption = 'Use Allow/Deny Lists'
      TabOrder = 6
    end
    object checkIgnoreBEL: TCheckBox
      Left = 384
      Top = 62
      Width = 74
      Height = 17
      Caption = 'Ignore BEL'
      TabOrder = 5
    end
    object TabControl1: TTabControl
      Left = 6
      Top = 6
      Width = 275
      Height = 108
      TabOrder = 0
      Tabs.Strings = (
        'Site1'
        'Site2')
      TabIndex = 0
      OnChange = TabControl1Change
      object Label1: TLabel
        Left = 7
        Top = 24
        Width = 55
        Height = 13
        Caption = 'Connect to:'
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
        Width = 43
        Height = 13
        Caption = 'Login ID:'
        Layout = tlCenter
      end
      object labelLoginID: TLabel
        Left = 56
        Top = 59
        Width = 211
        Height = 13
        AutoSize = False
        Layout = tlCenter
      end
      object Edit: TEdit
        Left = 7
        Top = 78
        Width = 161
        Height = 20
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #65325#65331' '#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        PopupMenu = popupCommand
        TabOrder = 1
        OnKeyPress = EditKeyPress
      end
      object ConnectButton: TButton
        Left = 178
        Top = 78
        Width = 89
        Height = 20
        Caption = 'Connect'
        TabOrder = 0
        OnClick = ConnectButtonClick
      end
    end
    object checkForceReconnect: TCheckBox
      Left = 291
      Top = 99
      Width = 167
      Height = 17
      Caption = 'Force reconnect'
      TabOrder = 7
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 471
    Height = 119
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 54
      Width = 469
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
      Width = 469
      Height = 53
      Style = lbOwnerDrawVariable
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ItemHeight = 12
      ParentFont = False
      PopupMenu = PopupMenu
      TabOrder = 0
      OnDblClick = ListBoxDblClick
      OnDrawItem = ListBoxDrawItem
      OnKeyDown = ListBoxKeyDown
      OnMeasureItem = ListBoxMeasureItem
    end
    object Console: TListBox
      Left = 1
      Top = 58
      Width = 469
      Height = 60
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
  object StatusLine: TStatusBar
    Left = 0
    Top = 239
    Width = 471
    Height = 23
    Panels = <
      item
        Width = 500
      end>
    SimplePanel = True
    ExplicitTop = 216
    ExplicitWidth = 350
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerProcess
    Left = 24
    Top = 32
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
    Left = 56
    Top = 32
  end
  object PopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 184
    Top = 40
    object menuSaveToFile: TMenuItem
      Caption = #12501#12449#12452#12523#12395#20445#23384
      OnClick = menuSaveToFileClick
    end
  end
  object SaveTextFileDialog1: TSaveTextFileDialog
    DefaultExt = '.txt'
    Filter = #12486#12461#12473#12488#12501#12449#12452#12523'(*.txt)|*.txt|'#20840#12390#12398#12501#12449#12452#12523'(*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Encodings.Strings = (
      'ANSI'
      'ASCII'
      'Unicode'
      'UTF-8')
    Left = 216
    Top = 40
  end
  object popupCommand: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 276
    Top = 48
    object menuPasteCommand: TMenuItem
      Caption = #36028#12426#20184#12369
      ShortCut = 16470
      OnClick = menuPasteCommandClick
    end
  end
  object timerReConnect: TTimer
    Enabled = False
    OnTimer = timerReConnectTimer
    Left = 116
    Top = 24
  end
  object timerForceReconnect: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = timerForceReconnectTimer
    Left = 376
    Top = 16
  end
end
