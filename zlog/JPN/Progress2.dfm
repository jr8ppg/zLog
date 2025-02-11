object formProgress2: TformProgress2
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Progress'
  ClientHeight = 103
  ClientWidth = 336
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 12
  object labelProgress: TLabel
    Left = 8
    Top = 26
    Width = 320
    Height = 12
    AutoSize = False
    Caption = 'd:\data\allja.zlo'
  end
  object labelTitle: TLabel
    Left = 8
    Top = 8
    Width = 320
    Height = 12
    AutoSize = False
    Caption = 'xxx'#12434#12375#12390#12356#12414#12377
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 44
    Width = 320
    Height = 21
    Step = 1
    TabOrder = 0
  end
  object buttonAbort: TButton
    Left = 136
    Top = 72
    Width = 73
    Height = 25
    Caption = #20013#27490
    TabOrder = 1
    OnClick = buttonAbortClick
  end
end
