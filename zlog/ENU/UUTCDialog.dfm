object UTCDialog: TUTCDialog
  Left = 287
  Top = 167
  BorderStyle = bsDialog
  Caption = 'Dialog'
  ClientHeight = 75
  ClientWidth = 200
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 7
    Top = 7
    Width = 186
    Height = 34
    Shape = bsFrame
  end
  object OKBtn: TButton
    Left = 67
    Top = 48
    Width = 63
    Height = 21
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CheckBox: TCheckBox
    Left = 24
    Top = 16
    Width = 153
    Height = 17
    Caption = 'Check here to use UTC'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
end
