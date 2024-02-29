object formJarlMemberInfo: TformJarlMemberInfo
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Progress'
  ClientHeight = 47
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object labelTitle: TLabel
    Left = 55
    Top = 8
    Width = 273
    Height = 12
    AutoSize = False
    Caption = 'xxx'#12434#12375#12390#12356#12414#12377
  end
  object labelProgress: TLabel
    Left = 55
    Top = 26
    Width = 273
    Height = 12
    AutoSize = False
    Caption = 'd:\data\allja.zlo'
  end
  object WebBrowser1: TWebBrowser
    Left = 8
    Top = 144
    Width = 73
    Height = 49
    TabOrder = 0
    SelectedEngine = EdgeIfAvailable
    OnDocumentComplete = WebBrowser1DocumentComplete
    ControlData = {
      4C0000008B070000100500000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126202000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object ActivityIndicator1: TActivityIndicator
    Left = 8
    Top = 7
  end
end
