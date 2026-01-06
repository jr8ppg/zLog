object formJarlWebUpload2: TformJarlWebUpload2
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
    object EdgeBrowser1: TEdgeBrowser
      Left = 0
      Top = 0
      Width = 777
      Height = 717
      Align = alClient
      TabOrder = 0
      AllowSingleSignOnUsingOSPrimaryAccount = False
      TargetCompatibleBrowserVersion = '117.0.2045.28'
      UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
      OnNavigationCompleted = EdgeBrowser1NavigationCompleted
    end
  end
end
