object formJarlMemberInfo: TformJarlMemberInfo
  Left = 0
  Top = 0
  Caption = 'Browser'
  ClientHeight = 220
  ClientWidth = 318
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 0
    Width = 318
    Height = 220
    Align = alClient
    TabOrder = 0
    SelectedEngine = EdgeIfAvailable
    OnDocumentComplete = WebBrowser1DocumentComplete
    ExplicitWidth = 281
    ExplicitHeight = 169
    ControlData = {
      4C000000DE200000BD1600000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126202000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
