object formCountryChecker: TformCountryChecker
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Country checker'
  ClientHeight = 324
  ClientWidth = 552
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 81
    Height = 15
    Caption = #12467#12540#12523#12469#12452#12531
  end
  object Label2: TLabel
    Left = 16
    Top = 75
    Width = 127
    Height = 15
    Caption = 'Country information'
  end
  object Label3: TLabel
    Left = 288
    Top = 75
    Width = 113
    Height = 15
    Caption = 'Prefix information'
  end
  object SearchBox1: TSearchBox
    Left = 112
    Top = 13
    Width = 213
    Height = 23
    AutoSize = False
    CharCase = ecUpperCase
    TabOrder = 0
    OnChange = SearchBox1Change
    OnInvokeSearch = SearchBox1InvokeSearch
  end
  object vleCountryInfo: TValueListEditor
    Left = 8
    Top = 96
    Width = 265
    Height = 221
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
    Strings.Strings = (
      '')
    TabOrder = 1
    TitleCaptions.Strings = (
      #38917#30446
      #20516)
    ColWidths = (
      121
      138)
  end
  object vlePrefixInfo: TValueListEditor
    Left = 279
    Top = 96
    Width = 265
    Height = 221
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
    Strings.Strings = (
      '')
    TabOrder = 2
    TitleCaptions.Strings = (
      #38917#30446
      #20516)
    ColWidths = (
      121
      138)
  end
end
