object CommForm: TCommForm
  Left = 117
  Top = 174
  Caption = 'Cluster'
  ClientHeight = 240
  ClientWidth = 354
  Color = clBtnFace
  Constraints.MinHeight = 250
  Constraints.MinWidth = 350
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 125
    Width = 354
    Height = 92
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 124
    ExplicitWidth = 350
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
      PopupMenu = popupCommand
      TabOrder = 0
      OnKeyPress = EditKeyPress
    end
    object ConnectButton: TButton
      Left = 8
      Top = 32
      Width = 89
      Height = 20
      Caption = #25509#32154
      TabOrder = 1
      OnClick = ConnectButtonClick
    end
    object checkAutoLogin: TCheckBox
      Left = 176
      Top = 5
      Width = 80
      Height = 17
      Caption = #33258#21205#12525#12464#12452#12531
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object checkRelaySpot: TCheckBox
      Left = 176
      Top = 23
      Width = 160
      Height = 17
      Caption = #12473#12509#12483#12488#12434#20182#12398#12496#12531#12489#12408#12522#12524#12540
      TabOrder = 4
    end
    object checkAutoReconnect: TCheckBox
      Left = 270
      Top = 5
      Width = 98
      Height = 17
      Caption = #33258#21205#20877#25509#32154
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object checkRecordLogs: TCheckBox
      Left = 176
      Top = 41
      Width = 100
      Height = 17
      Caption = #21463#20449#12525#12464#12434#20445#23384
      TabOrder = 5
    end
    object checkUseAllowDenyLists: TCheckBox
      Left = 176
      Top = 59
      Width = 153
      Height = 17
      Caption = #35377#21487'/'#25298#21542#12522#12473#12488#12434#20351#29992
      TabOrder = 7
    end
    object checkIgnoreBEL: TCheckBox
      Left = 278
      Top = 41
      Width = 74
      Height = 17
      Caption = 'BEL'#12434#28961#35222
      TabOrder = 6
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 354
    Height = 125
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    ExplicitWidth = 350
    ExplicitHeight = 124
    object Splitter1: TSplitter
      Left = 1
      Top = 60
      Width = 352
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
      Width = 352
      Height = 59
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
      ExplicitWidth = 348
      ExplicitHeight = 58
    end
    object Console: TListBox
      Left = 1
      Top = 64
      Width = 352
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
      ExplicitTop = 63
      ExplicitWidth = 348
    end
  end
  object StatusLine: TStatusBar
    Left = 0
    Top = 217
    Width = 354
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
  object ClusterComm: TCommPortDriver
    Port = pnCustom
    PortName = '\\.\COM2'
    OnReceiveData = ClusterCommReceiveData
    Left = 96
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
    Left = 28
    Top = 88
  end
end
