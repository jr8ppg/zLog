object formStartup: TformStartup
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Welcome to zLog'
  ClientHeight = 242
  ClientWidth = 362
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
    Top = 8
    Width = 345
    Height = 57
    Caption = 'New or open contest'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
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
    Caption = 'Restart the last contest'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
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
    Caption = 'Last contest'
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
      Font.Name = 'MS Sans Serif'
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
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
end
