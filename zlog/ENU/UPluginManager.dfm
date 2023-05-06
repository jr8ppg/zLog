object MarketForm: TMarketForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'ZyLO Plugin Manager'
  ClientHeight = 611
  ClientWidth = 634
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter: TSplitter
    Left = 0
    Top = 400
    Width = 634
    Height = 5
    Cursor = crVSplit
    Align = alTop
    AutoSnap = False
    Beveled = True
  end
  object ShowPanel: TPanel
    Left = 0
    Top = 405
    Width = 634
    Height = 156
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    BevelEdges = []
    BevelOuter = bvNone
    BorderWidth = 10
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object TagLabel: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 13
      Width = 333
      Height = 29
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alTop
      Caption = 'Welcome to ZyLO Marketplace!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object MsgLabel: TLinkLabel
      Left = 10
      Top = 52
      Width = 614
      Height = 76
      Align = alClient
      Caption = 'Empower zLog with great features developed by third parties.'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      OnLinkClick = WebLabelLinkClick
      ExplicitWidth = 440
      ExplicitHeight = 23
    end
    object WebLabel: TLinkLabel
      Left = 10
      Top = 128
      Width = 614
      Height = 18
      Align = alBottom
      Caption = '<a href="https://nextzlog.github.io/zylo">How to make plugin</a>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnLinkClick = WebLabelLinkClick
      ExplicitWidth = 114
    end
  end
  object ListPanel: TPanel
    Left = 0
    Top = 0
    Width = 634
    Height = 400
    Align = alTop
    BevelEdges = []
    BevelOuter = bvNone
    ParentColor = True
    ShowCaption = False
    TabOrder = 1
    object ListBox: TListBox
      AlignWithMargins = True
      Left = 10
      Top = 47
      Width = 614
      Height = 313
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 19
      ParentFont = False
      TabOrder = 0
      OnClick = ListBoxClick
    end
    object SearchBox: TSearchBox
      AlignWithMargins = True
      Left = 10
      Top = 10
      Width = 614
      Height = 27
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TextHint = 'Search'
      OnChange = SearchBoxChange
    end
    object CheckBox: TCheckBox
      AlignWithMargins = True
      Left = 10
      Top = 373
      Width = 614
      Height = 17
      Margins.Left = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alBottom
      Caption = 'Show unstable (experimental) plugins'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = SearchBoxChange
    end
  end
  object GridPanel: TGridPanel
    Left = 0
    Top = 561
    Width = 634
    Height = 50
    Align = alBottom
    BevelEdges = []
    BevelOuter = bvNone
    BorderWidth = 5
    ColumnCollection = <
      item
        Value = 33.333333333333300000
      end
      item
        Value = 33.333333333333300000
      end
      item
        Value = 33.333333333333300000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = InstallButton
        Row = 0
      end
      item
        Column = 1
        Control = DisableButton
        Row = 0
      end
      item
        Column = 2
        Control = UpgradeButton
        Row = 0
      end>
    ParentBackground = False
    ParentColor = True
    RowCollection = <
      item
        Value = 100
      end>
    TabOrder = 2
    object InstallButton: TButton
      AlignWithMargins = True
      Left = 8
      Top = 8
      Width = 202
      Height = 34
      Align = alClient
      Caption = 'Install'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = InstallButtonClick
    end
    object DisableButton: TButton
      AlignWithMargins = True
      Left = 216
      Top = 8
      Width = 202
      Height = 34
      Align = alClient
      Caption = 'Disable'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = DisableButtonClick
    end
    object UpgradeButton: TButton
      AlignWithMargins = True
      Left = 424
      Top = 8
      Width = 202
      Height = 34
      Align = alClient
      Caption = 'Upgrade'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = UpgradeButtonClick
    end
  end
  object NetHTTPClient: TNetHTTPClient
    UserAgent = 'zLog'
  end
  object NetHTTPRequest: TNetHTTPRequest
    ConnectionTimeout = 0
    SendTimeout = 0
    ResponseTimeout = 0
    Left = 120
  end
end
