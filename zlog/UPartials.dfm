object PartialCheck: TPartialCheck
  Left = 213
  Top = 188
  Caption = 'Partial Check'
  ClientHeight = 254
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox: TListBox
    Left = 0
    Top = 0
    Width = 303
    Height = 190
    Style = lbOwnerDrawVariable
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Pitch = fpFixed
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 0
    OnDblClick = ListBoxDblClick
    OnDrawItem = ListBoxDrawItem
    OnMeasureItem = ListBoxMeasureItem
  end
  object Panel: TPanel
    Left = 0
    Top = 190
    Width = 303
    Height = 64
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 200
      Top = 42
      Width = 49
      Height = 13
      Caption = 'Show max'
    end
    object MoreButton: TSpeedButton
      Left = 264
      Top = 7
      Width = 37
      Height = 21
      Caption = 'Hide'
      OnClick = MoreButtonClick
    end
    object Button3: TButton
      Left = 6
      Top = 7
      Width = 63
      Height = 21
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = Button3Click
    end
    object CheckBox1: TCheckBox
      Left = 165
      Top = 9
      Width = 97
      Height = 17
      Caption = 'Check all bands'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = CheckBox1Click
    end
    object ShowMaxEdit: TSpinEdit
      Left = 256
      Top = 38
      Width = 49
      Height = 22
      MaxValue = 9999
      MinValue = 1
      TabOrder = 2
      Value = 1
      OnChange = ShowMaxEditChange
    end
    object SortByGroup: TGroupBox
      Left = 8
      Top = 31
      Width = 190
      Height = 31
      Caption = 'Sort by'
      TabOrder = 3
      object rbTime: TRadioButton
        Left = 8
        Top = 13
        Width = 57
        Height = 15
        Caption = 'Time'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rbSortClick
      end
      object rbBand: TRadioButton
        Left = 69
        Top = 13
        Width = 50
        Height = 15
        Caption = 'Band'
        TabOrder = 1
        OnClick = rbSortClick
      end
      object rbCall: TRadioButton
        Left = 127
        Top = 13
        Width = 60
        Height = 15
        Caption = 'Callsign'
        TabOrder = 2
        OnClick = rbSortClick
      end
    end
    object StayOnTop: TCheckBox
      Left = 80
      Top = 8
      Width = 81
      Height = 17
      Caption = 'Stay on top'
      TabOrder = 4
      OnClick = StayOnTopClick
    end
  end
end
