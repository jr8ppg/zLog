object ZAnalyze: TZAnalyze
  Left = 0
  Top = 0
  Caption = #12479#12452#12512#12481#12515#12540#12488
  ClientHeight = 261
  ClientWidth = 684
  Color = clBtnFace
  Constraints.MinHeight = 100
  Constraints.MinWidth = 100
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
    Top = 233
    Width = 684
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 236
    ExplicitWidth = 700
    DesignSize = (
      684
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
      Left = 616
      Top = 1
      Width = 65
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #12467#12500#12540
      TabOrder = 1
      OnClick = buttonCopyClick
      ExplicitLeft = 632
    end
    object checkExcludeZeroPoint: TCheckBox
      Left = 104
      Top = 5
      Width = 81
      Height = 17
      Caption = #24471#28857#65296#12434#38500#12367
      TabOrder = 2
    end
    object checkExcludeZeroHour: TCheckBox
      Left = 204
      Top = 5
      Width = 117
      Height = 17
      Caption = #65296#23616#12398#26178#38291#24111#12434#38500#12367
      TabOrder = 3
    end
  end
  object TabControl1: TTabControl
    Left = 0
    Top = 0
    Width = 684
    Height = 233
    Align = alClient
    TabOrder = 1
    Tabs.Strings = (
      'ZAF'
      'ZAQ'
      'ZAA')
    TabIndex = 0
    OnChange = TabControl1Change
    ExplicitWidth = 700
    ExplicitHeight = 236
    object Memo1: TMemo
      Left = 4
      Top = 24
      Width = 676
      Height = 205
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
      ExplicitWidth = 692
      ExplicitHeight = 208
    end
  end
end
