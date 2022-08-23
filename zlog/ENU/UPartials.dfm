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
  object panelExtend: TPanel
    Left = 0
    Top = 190
    Width = 303
    Height = 64
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 193
    object Label1: TLabel
      Left = 199
      Top = 18
      Width = 49
      Height = 13
      Caption = 'Show max'
    end
    object ShowMaxEdit: TSpinEdit
      Left = 252
      Top = 15
      Width = 49
      Height = 22
      MaxValue = 9999
      MinValue = 1
      TabOrder = 0
      Value = 1
      OnChange = ShowMaxEditChange
    end
    object SortByGroup: TGroupBox
      Left = 4
      Top = 5
      Width = 190
      Height = 36
      Caption = 'Sort by'
      TabOrder = 1
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
    object checkShowCurrentBandFirst: TCheckBox
      Left = 12
      Top = 44
      Width = 133
      Height = 17
      Caption = 'Show current band first'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = CheckBox1Click
    end
  end
  object panelBody: TPanel
    Left = 0
    Top = 0
    Width = 303
    Height = 190
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 287
    ExplicitHeight = 153
    object Panel: TPanel
      Left = 0
      Top = 164
      Width = 303
      Height = 26
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitTop = 187
      object MoreButton: TSpeedButton
        Left = 264
        Top = 2
        Width = 37
        Height = 21
        Caption = 'Hide'
        OnClick = MoreButtonClick
      end
      object CheckBox1: TCheckBox
        Left = 95
        Top = 4
        Width = 97
        Height = 17
        Caption = 'Check all bands'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = CheckBox1Click
      end
      object StayOnTop: TCheckBox
        Left = 8
        Top = 4
        Width = 81
        Height = 17
        Caption = 'Stay on top'
        TabOrder = 1
        OnClick = StayOnTopClick
      end
    end
    object ListBox: TListBox
      Left = 0
      Top = 0
      Width = 303
      Height = 164
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
      TabOrder = 1
      OnDblClick = ListBoxDblClick
      OnDrawItem = ListBoxDrawItem
      OnMeasureItem = ListBoxMeasureItem
      ExplicitHeight = 213
    end
  end
end
