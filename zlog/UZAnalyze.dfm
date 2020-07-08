object ZAnalyze: TZAnalyze
  Left = 0
  Top = 0
  Caption = #12479#12452#12512#12481#12515#12540#12488
  ClientHeight = 264
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 236
    Width = 700
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      700
      28)
    object buttonUpdate: TButton
      Left = 3
      Top = 1
      Width = 65
      Height = 25
      Caption = #26356#26032
      TabOrder = 0
      OnClick = buttonUpdateClick
    end
    object buttonCopy: TButton
      Left = 632
      Top = 1
      Width = 65
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #12467#12500#12540
      TabOrder = 1
      OnClick = buttonCopyClick
    end
  end
  object TabControl1: TTabControl
    Left = 0
    Top = 0
    Width = 700
    Height = 236
    Align = alClient
    TabOrder = 1
    Tabs.Strings = (
      'ZAF'
      'ZAQ')
    TabIndex = 0
    OnChange = TabControl1Change
    object Memo1: TMemo
      Left = 4
      Top = 24
      Width = 692
      Height = 208
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WordWrap = False
    end
  end
end
