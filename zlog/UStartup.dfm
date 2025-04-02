object formStartup: TformStartup
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Welcome to zLog'
  ClientHeight = 156
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 13
  object buttonNewContest: TButton
    Left = 8
    Top = 16
    Width = 273
    Height = 57
    Caption = 'New contest'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = buttonNewContestClick
  end
  object buttonLastContest: TButton
    Left = 8
    Top = 88
    Width = 273
    Height = 57
    Caption = 'Last contest'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = buttonLastContestClick
  end
end
