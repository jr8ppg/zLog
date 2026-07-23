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
  end
  object Panel1: TPanel
    Left = 0
    Top = 132
    Width = 334
    Height = 57
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
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
  object Console: TListBox
    Left = 0
    Top = 0
    Width = 334
    Height = 132
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    ItemHeight = 12
    ParentFont = False
    TabOrder = 0
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 36
    Top = 36
  end
  object timerLoginCheck: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = timerLoginCheckTimer
    Left = 80
    Top = 36
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer2Timer
    Left = 128
    Top = 44
  end
end
