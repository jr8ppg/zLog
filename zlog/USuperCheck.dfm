object SuperCheck: TSuperCheck
  Left = 472
  Top = 79
  ActiveControl = SpinEdit
  Caption = 'Super Check'
  ClientHeight = 312
  ClientWidth = 234
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 250
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 184
    Width = 234
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    MinSize = 90
    ExplicitTop = 0
    ExplicitWidth = 208
  end
  object Panel1: TPanel
    Left = 0
    Top = 277
    Width = 234
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 297
    ExplicitWidth = 243
    DesignSize = (
      234
      35)
    object Label1: TLabel
      Left = 153
      Top = 11
      Width = 40
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Columns'
    end
    object Button3: TButton
      Left = 4
      Top = 7
      Width = 63
      Height = 21
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button3Click
    end
    object StayOnTop: TCheckBox
      Left = 71
      Top = 9
      Width = 81
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Stay on top'
      TabOrder = 1
      OnClick = StayOnTopClick
      ExplicitLeft = 80
    end
    object SpinEdit: TSpinEdit
      Left = 197
      Top = 7
      Width = 33
      Height = 22
      Anchors = [akTop, akRight]
      MaxValue = 5
      MinValue = 1
      TabOrder = 2
      Value = 1
      OnChange = SpinEditChange
    end
  end
  object ListBox: TListBox
    Left = 0
    Top = 0
    Width = 234
    Height = 184
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    ItemHeight = 12
    ParentFont = False
    TabOrder = 1
    OnDblClick = ListBoxDblClick
    ExplicitWidth = 243
    ExplicitHeight = 204
  end
  object ListBox1: TListBox
    Left = 0
    Top = 187
    Width = 234
    Height = 90
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    ItemHeight = 12
    ParentFont = False
    TabOrder = 2
    OnDblClick = ListBoxDblClick
    ExplicitTop = 207
    ExplicitWidth = 243
  end
end
