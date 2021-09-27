object CommForm: TCommForm
  Left = 117
  Top = 174
  Caption = 'Cluster'
  ClientHeight = 212
  ClientWidth = 354
  Color = clBtnFace
  Constraints.MinHeight = 250
  Constraints.MinWidth = 350
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 109
    Width = 354
    Height = 80
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 248
    ExplicitWidth = 367
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
      Width = 89
      Height = 20
      Caption = 'Connect'
      TabOrder = 1
      OnClick = ConnectButtonClick
    end
    object checkAutoLogin: TCheckBox
      Left = 176
      Top = 5
      Width = 73
      Height = 17
      Caption = 'Auto Login'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object checkRelaySpot: TCheckBox
      Left = 176
      Top = 23
      Width = 145
      Height = 17
      Caption = 'Relay spot to other bands'
      TabOrder = 4
    end
    object checkNotifyCurrentBand: TCheckBox
      Left = 176
      Top = 40
      Width = 153
      Height = 17
      Caption = 'Notify current band only'
      TabOrder = 5
    end
    object checkAutoReconnect: TCheckBox
      Left = 255
      Top = 5
      Width = 98
      Height = 17
      Caption = 'Auto Reconnect'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object checkRecordLogs: TCheckBox
      Left = 176
      Top = 57
      Width = 153
      Height = 17
      Caption = 'Record logs'
      TabOrder = 6
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 354
    Height = 109
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    ExplicitWidth = 367
    ExplicitHeight = 248
    object Splitter1: TSplitter
      Left = 1
      Top = 16
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
      Height = 15
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
      ExplicitWidth = 365
      ExplicitHeight = 154
    end
    object Console: TColorConsole2
      Left = 1
      Top = 20
      Width = 352
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
      ExplicitTop = 159
      ExplicitWidth = 365
    end
  end
  object StatusLine: TStatusBar
    Left = 0
    Top = 189
    Width = 354
    Height = 23
    Panels = <>
    SimplePanel = True
    ExplicitTop = 328
    ExplicitWidth = 367
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
end
