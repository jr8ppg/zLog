object ConsolePad: TConsolePad
  Left = 35
  Top = 179
  Caption = 'Console'
  ClientHeight = 155
  ClientWidth = 263
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object ListBox: TListBox
    Left = 0
    Top = 0
    Width = 263
    Height = 122
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
    ItemHeight = 12
    ParentFont = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 122
    Width = 263
    Height = 33
    Align = alBottom
    TabOrder = 1
    object Edit: TEdit
      Left = 8
      Top = 6
      Width = 252
      Height = 20
      CharCase = ecUpperCase
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      TabOrder = 0
      OnKeyPress = EditKeyPress
    end
  end
end
