object formStartup: TformStartup
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Welcome to zLog'
  ClientHeight = 263
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    362
    263)
  TextHeight = 13
  object buttonNewContest: TButton
    Left = 8
    Top = 8
    Width = 345
    Height = 57
    Caption = #26032#35215#21448#12399#26082#23384#12398#12467#12531#12486#12473#12488#12434#38283#12367
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = buttonNewContestClick
  end
  object buttonLastContest: TButton
    Left = 8
    Top = 80
    Width = 345
    Height = 57
    Caption = #21069#22238#12398#12467#12531#12486#12473#12488#12434#20877#38283#12377#12427
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = buttonLastContestClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 143
    Width = 345
    Height = 90
    Caption = #21069#22238#12398#12467#12531#12486#12473#12488
    TabOrder = 2
    object panelLastContestName: TPanel
      Left = 10
      Top = 26
      Width = 325
      Height = 25
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object panelLastFileName: TPanel
      Left = 10
      Top = 57
      Width = 325
      Height = 25
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object checkDontShowThisWindow: TCheckBox
    Left = 150
    Top = 240
    Width = 200
    Height = 19
    Anchors = [akTop, akRight]
    Caption = #27425#22238#12424#12426#12371#12398#12454#12452#12531#12489#12454#12434#34920#31034#12375#12394#12356
    TabOrder = 3
  end
end
