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
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 161
    Top = 0
    Width = 358
    Height = 355
    Align = alClient
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 203
      Width = 356
      Height = 4
      Cursor = crVSplit
      Align = alBottom
      MinSize = 1
      ExplicitTop = 196
      ExplicitWidth = 364
    end
    object RXLog: TColorConsole2
      Left = 1
      Top = 1
      Width = 356
      Height = 202
      Align = alClient
      ParentColor = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      Options = [coAutoTracking, coCheckBreak, coLazyWrite, coFixedPitchOnly]
      Rows = 500
      LineBreak = CRLF
    end
    object TXLog: TMemo
      Left = 1
      Top = 207
      Width = 356
      Height = 147
      Align = alBottom
      ImeName = #26085#26412#35486' (MS-IME2002)'
      Lines.Strings = (
        'TXLog')
      TabOrder = 1
      OnKeyDown = TXLogKeyDown
      OnKeyPress = TXLogKeyPress
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 161
    Height = 355
    Align = alLeft
    TabOrder = 1
    object CallsignList: TListBox
      Left = 1
      Top = 1
      Width = 159
      Height = 240
      Align = alTop
      ImeName = 'Microsoft IME 2000'
      ItemHeight = 12
      TabOrder = 0
      OnClick = CallsignListClick
      OnDblClick = CallsignListDblClick
    end
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 96
    Top = 256
  end
  object MainMenu1: TMainMenu
    Left = 48
    Top = 264
    object mnConsole: TMenuItem
      Caption = '&Console'
      object ClearRXlog1: TMenuItem
        Caption = 'Clear &RX Log'
        OnClick = ClearRXlog1Click
      end
      object ClearTXlog1: TMenuItem
        Caption = 'Clear &TX Log'
        OnClick = ClearTXlog1Click
      end
      object ClearCallsignlist1: TMenuItem
        Caption = 'Clear &Callsign List'
        OnClick = ClearCallsignlist1Click
      end
      object Cleareverything1: TMenuItem
        Caption = 'Clear &Everything'
        OnClick = Cleareverything1Click
      end
      object mnStayOnTop: TMenuItem
        Caption = '&Stay on Top'
        OnClick = StayOnTopClick
      end
    end
  end
end
