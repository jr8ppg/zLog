object TTYConsole: TTTYConsole
  Left = 175
  Top = 167
  Caption = 'RTTY Console'
  ClientHeight = 355
  ClientWidth = 519
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 13
  object TPanel
    Left = 161
    Top = 0
    Width = 358
    Height = 355
    Align = alClient
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 220
      Width = 356
      Height = 4
      Cursor = crVSplit
      Align = alBottom
      MinSize = 1
      ExplicitTop = 196
      ExplicitWidth = 364
    end
    object panelTx: TPanel
      Left = 1
      Top = 224
      Width = 356
      Height = 130
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object TXLog: TMemo
        Left = 0
        Top = 20
        Width = 356
        Height = 110
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Consolas'
        Font.Style = []
        Lines.Strings = (
          'TXLog')
        ParentFont = False
        TabOrder = 0
        OnKeyDown = TXLogKeyDown
        OnKeyPress = TXLogKeyPress
      end
      object panelTxHeader: TPanel
        Left = 0
        Top = 0
        Width = 356
        Height = 20
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label1: TLabel
          Left = 4
          Top = 4
          Width = 35
          Height = 13
          Caption = 'TX Log'
        end
      end
    end
    object panelRx: TPanel
      Left = 1
      Top = 1
      Width = 356
      Height = 219
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object RXLog: TConsole2
        Left = 0
        Top = 20
        Width = 356
        Height = 199
        Align = alClient
        ParentColor = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Consolas'
        Font.Style = []
        Options = [coAutoTracking, coCheckBreak, coLazyWrite, coFixedPitchOnly]
        Rows = 500
        LineBreak = CRLF
      end
      object panelRxHeader: TPanel
        Left = 0
        Top = 0
        Width = 356
        Height = 20
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label2: TLabel
          Left = 4
          Top = 4
          Width = 36
          Height = 13
          Caption = 'RX Log'
        end
      end
    end
  end
  object panelLeft: TPanel
    Left = 0
    Top = 0
    Width = 161
    Height = 355
    Align = alLeft
    TabOrder = 1
    object CallsignList: TListBox
      Left = 1
      Top = 21
      Width = 159
      Height = 333
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Consolas'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 0
      OnClick = CallsignListClick
      OnDblClick = CallsignListDblClick
    end
    object panelLeftHeader: TPanel
      Left = 1
      Top = 1
      Width = 159
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label3: TLabel
        Left = 4
        Top = 4
        Width = 51
        Height = 13
        Caption = 'Callsign list'
      end
    end
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 96
    Top = 256
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 48
    Top = 264
    object menuConsole: TMenuItem
      Caption = '&Console'
      object menuClearRxLog: TMenuItem
        Caption = 'Clear &RX Log'
        OnClick = menuClearRxLogClick
      end
      object menuClearTxLog: TMenuItem
        Caption = 'Clear &TX Log'
        OnClick = menuClearTxLogClick
      end
      object menuClearCallsignlist: TMenuItem
        Caption = 'Clear &Callsign List'
        OnClick = menuClearCallsignlistClick
      end
      object menuClearEverything: TMenuItem
        Caption = 'Clear &Everything'
        OnClick = menuClearEverythingClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object menuStayOnTop: TMenuItem
        Caption = '&Stay on Top'
        OnClick = menuStayOnTopClick
      end
    end
  end
end
