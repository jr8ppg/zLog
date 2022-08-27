object CheckWin: TCheckWin
  Left = 182
  Top = 146
  Caption = 'CheckWin'
  ClientHeight = 162
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 130
    Width = 298
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Button3: TButton
      Left = 6
      Top = 7
      Width = 63
      Height = 21
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = Button3Click
    end
    object StayOnTop: TCheckBox
      Left = 80
      Top = 8
      Width = 81
      Height = 17
      Caption = 'Stay on top'
      TabOrder = 1
      OnClick = StayOnTopClick
    end
  end
  object ListBox: TListBox
    Left = 0
    Top = 0
    Width = 298
    Height = 130
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Pitch = fpFixed
    Font.Style = []
    ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
    ItemHeight = 13
    ParentFont = False
    TabOrder = 1
  end
end
