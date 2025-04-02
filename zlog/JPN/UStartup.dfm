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
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 13
  object buttonNewContest: TButton
    Left = 8
    Top = 16
    Width = 273
    Height = 57
    Caption = #26032#12375#12367#12467#12531#12486#12473#12488#12434#22987#12417#12427
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
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
    Caption = #21069#22238#12398#12467#12531#12486#12473#12488#12434#20877#38283#12377#12427
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = buttonLastContestClick
  end
end
