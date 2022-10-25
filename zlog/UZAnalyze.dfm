object ZAnalyze: TZAnalyze
  Left = 0
  Top = 0
  Caption = 'Analyze'
  ClientHeight = 262
  ClientWidth = 684
  Color = clBtnFace
  Constraints.MinHeight = 150
  Constraints.MinWidth = 500
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
    Top = 234
    Width = 684
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      684
      28)
    object buttonUpdate: TButton
      Left = 3
      Top = 1
      Width = 65
      Height = 25
      Caption = 'Refresh'
      TabOrder = 0
      OnClick = buttonUpdateClick
    end
    object buttonCopy: TButton
      Left = 596
      Top = 1
      Width = 84
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Copy'
      TabOrder = 5
      OnClick = buttonCopyClick
    end
    object checkExcludeZeroPoint: TCheckBox
      Left = 92
      Top = 5
      Width = 81
      Height = 17
      Caption = 'Exclude 0pts'
      TabOrder = 1
      OnClick = buttonUpdateClick
    end
    object checkExcludeZeroHour: TCheckBox
      Left = 189
      Top = 5
      Width = 111
      Height = 17
      Caption = 'Exclude 0qso/h'
      TabOrder = 2
      OnClick = buttonUpdateClick
    end
    object buttonSave: TButton
      Left = 511
      Top = 1
      Width = 84
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Save'
      TabOrder = 4
      OnClick = buttonSaveClick
    end
    object checkShowCW: TCheckBox
      Left = 306
      Top = 5
      Width = 117
      Height = 17
      Caption = 'Show CW'
      TabOrder = 3
      OnClick = buttonUpdateClick
    end
  end
  object TabControl1: TTabControl
    Left = 0
    Top = 0
    Width = 684
    Height = 234
    Align = alClient
    TabOrder = 1
    Tabs.Strings = (
      'ZAF'
      'ZAQ'
      'ZAA'
      'ZAA(ALL)'
      'ZAD'
      'ZOP')
    TabIndex = 0
    OnChange = TabControl1Change
    object Memo1: TMemo
      Left = 4
      Top = 24
      Width = 676
      Height = 206
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
