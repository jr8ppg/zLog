object ZServerInquiry: TZServerInquiry
  Left = 239
  Top = 182
  BorderStyle = bsDialog
  Caption = 'Connected...'
  ClientHeight = 104
  ClientWidth = 295
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 24
    Top = 10
    Width = 118
    Height = 12
    Caption = 'Connected to Z-Server'
  end
  object Button1: TButton
    Left = 64
    Top = 72
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 153
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = Button2Click
  end
  object rbDownload: TRadioButton
    Left = 16
    Top = 48
    Width = 265
    Height = 17
    Caption = 'Download log from Z-Server (Delete local log)'
    TabOrder = 2
  end
  object rbMerge: TRadioButton
    Left = 16
    Top = 32
    Width = 273
    Height = 17
    Caption = 'Merge local log with Z-Server'
    Checked = True
    TabOrder = 3
    TabStop = True
  end
end
