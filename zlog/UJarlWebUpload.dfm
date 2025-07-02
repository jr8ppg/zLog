object formJarlWebUpload: TformJarlWebUpload
  Left = 0
  Top = 0
  Caption = 'JARL Web upload'
  ClientHeight = 746
  ClientWidth = 777
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 777
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      777
      29)
    object Edit1: TEdit
      Left = 4
      Top = 4
      Width = 769
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 0
    end
  end
  object panelBody: TPanel
    Left = 0
    Top = 29
    Width = 777
    Height = 717
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object WebBrowser1: TWebBrowser
      Left = 0
      Top = 0
      Width = 777
      Height = 717
      Align = alClient
      TabOrder = 0
      SelectedEngine = EdgeIfAvailable
      OnDocumentComplete = WebBrowser1DocumentComplete
      ControlData = {
        4C0000004E5000001B4A00000100000001020000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E12620C000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object WebDispatcher1: TWebDispatcher
    Actions = <>
    Left = 352
    Top = 325
    Height = 0
    Width = 0
    PixelsPerInch = 0
  end
end
