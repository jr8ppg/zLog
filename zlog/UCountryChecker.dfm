object formCountryChecker: TformCountryChecker
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Country checker'
  ClientHeight = 352
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
    Top = 44
    Width = 81
    Height = 15
    Caption = #12467#12540#12523#12469#12452#12531
  end
  object Label2: TLabel
    Left = 16
    Top = 83
    Width = 127
    Height = 15
    Caption = 'Country information'
  end
  object Label3: TLabel
    Left = 288
    Top = 83
    Width = 113
    Height = 15
    Caption = 'Prefix information'
  end
  object Label4: TLabel
    Left = 16
    Top = 329
    Width = 316
    Height = 15
    Caption = #32076#24230'(Longitude)'#12399#26481#32076#12364#12510#12452#12490#12473#12391#34920#31034#12373#12428#12414#12377'.'
  end
  object Label5: TLabel
    Left = 16
    Top = 13
    Width = 323
    Height = 15
    Caption = 'CTY.DAT'#12424#12426#12456#12531#12486#12451#12486#12451#24773#22577#12434#21462#24471#12375#12390#34920#31034#12375#12414#12377'.'
  end
  object SearchBox1: TSearchBox
    Left = 112
    Top = 41
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
    Top = 104
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
    Top = 104
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
