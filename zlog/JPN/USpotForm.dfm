object SpotForm: TSpotForm
  Left = 109
  Top = 202
  Caption = 'Send DX Spot'
  ClientHeight = 56
  ClientWidth = 305
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 0
    Width = 53
    Height = 12
    Caption = 'Frequency'
  end
  object Label2: TLabel
    Left = 88
    Top = 0
    Width = 45
    Height = 12
    Caption = 'Call sign'
  end
  object Label3: TLabel
    Left = 160
    Top = 0
    Width = 48
    Height = 12
    Caption = 'Comment'
  end
  object FreqEdit: TEdit
    Left = 8
    Top = 16
    Width = 73
    Height = 20
    ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
    TabOrder = 0
    Text = 'Freq'
  end
  object CallsignEdit: TEdit
    Left = 88
    Top = 16
    Width = 65
    Height = 20
    ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
    TabOrder = 1
    Text = 'Callsign'
  end
  object CommentEdit: TEdit
    Left = 160
    Top = 16
    Width = 145
    Height = 20
    ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
    TabOrder = 2
    Text = 'Comment'
  end
  object Panel1: TPanel
    Left = 0
    Top = 27
    Width = 305
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object SendButton: TButton
      Left = 8
      Top = 5
      Width = 65
      Height = 19
      Caption = 'Send'
      TabOrder = 0
      OnClick = SendButtonClick
    end
    object Button2: TButton
      Left = 80
      Top = 5
      Width = 65
      Height = 19
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
end
