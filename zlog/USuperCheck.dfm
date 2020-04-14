object SuperCheck: TSuperCheck
  Left = 472
  Top = 79
  Caption = 'Super Check'
  ClientHeight = 332
  ClientWidth = 243
  Color = clBtnFace
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 297
    Width = 243
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 163
      Top = 10
      Width = 40
      Height = 13
      Caption = 'Columns'
    end
    object Button3: TButton
      Left = 8
      Top = 7
      Width = 63
      Height = 21
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button3Click
    end
    object StayOnTop: TCheckBox
      Left = 80
      Top = 9
      Width = 81
      Height = 17
      Caption = 'Stay on top'
      TabOrder = 1
      OnClick = StayOnTopClick
    end
    object SpinEdit: TSpinEdit
      Left = 208
      Top = 6
      Width = 33
      Height = 22
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
    Width = 243
    Height = 297
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
  end
end
