inherited JIDX_DX_Multi: TJIDX_DX_Multi
  Left = -31
  Top = 248
  Caption = 'Multipliers'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TabControl: TTabControl
    Left = 0
    Top = 0
    Width = 314
    Height = 262
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Tabs.Strings = (
      '1.9MHz'
      '3.5 MHz'
      '7 MHz'
      '14 MHz'
      '21 MHz'
      '28 MHz'
      'ALL')
    TabIndex = 0
    OnChange = TabControlChange
    object CheckListBox: TCheckListBox
      Left = 253
      Top = 57
      Width = 57
      Height = 201
      OnClickCheck = CheckListBoxClickCheck
      Align = alClient
      BorderStyle = bsNone
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Pitch = fpFixed
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        '01 Hokkaido'
        '02 Aomori'
        '03 Iwate'
        '04 Akita'
        '05 Yamagata'
        '06 Miyagi'
        '07 Fukushima'
        '08 Niigata'
        '09 Nagano'
        '10 Tokyo'
        '11 Kanagawa'
        '12 Chiba'
        '13 Saitama'
        '14 Ibaraki'
        '15 Tochigi'
        '16 Gumma'
        '17 Yamanashi'
        '18 Shizuoka'
        '19 Gifu'
        '20 Aichi'
        '21 Mie'
        '22 Kyoto'
        '23 Shiga'
        '24 Nara'
        '25 Osaka'
        '26 Wakayama'
        '27 Hyogo'
        '28 Toyama'
        '29 Fukui'
        '30 Ishikawa'
        '31 Okayama'
        '32 Shimane'
        '33 Yamaguchi'
        '34 Tottori'
        '35 Hiroshima'
        '36 Kagawa'
        '37 Tokushima'
        '38 Ehime'
        '39 Kochi'
        '40 Fukuoka'
        '41 Saga'
        '42 Nagasaki'
        '43 Kumamoto'
        '44 Oita'
        '45 Miyazaki'
        '46 Kagoshima'
        '47 Okinawa'
        '48 Ogasawara'
        '49 Okinotorishima'
        '50 Minami-torishima')
      ParentFont = False
      TabOrder = 0
    end
    object Panel1: TPanel
      Left = 4
      Top = 25
      Width = 306
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object RotateLabel2: TRotateLabel
        Left = 152
        Top = 9
        Width = 14
        Height = 15
        Escapement = 90
        TextStyle = tsNone
        Caption = '3.5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object RotateLabel1: TRotateLabel
        Left = 138
        Top = 9
        Width = 14
        Height = 15
        Escapement = 90
        TextStyle = tsNone
        Caption = '1.9'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object RotateLabel3: TRotateLabel
        Left = 166
        Top = 9
        Width = 14
        Height = 15
        Escapement = 90
        TextStyle = tsNone
        Caption = '7   '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object RotateLabel4: TRotateLabel
        Left = 181
        Top = 12
        Width = 14
        Height = 12
        Escapement = 90
        TextStyle = tsNone
        Caption = '14'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object RotateLabel5: TRotateLabel
        Left = 195
        Top = 12
        Width = 14
        Height = 12
        Escapement = 90
        TextStyle = tsNone
        Caption = '21'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object RotateLabel6: TRotateLabel
        Left = 209
        Top = 12
        Width = 14
        Height = 12
        Escapement = 90
        TextStyle = tsNone
        Caption = '28'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
    end
    object ListBox: TListBox
      Left = 4
      Top = 57
      Width = 249
      Height = 201
      Align = alLeft
      BorderStyle = bsNone
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Pitch = fpFixed
      Font.Style = []
      ItemHeight = 12
      Items.Strings = (
        '01 Hokkaido         . . . . . .                      '
        '02 Aomori                '
        '03 Iwate                 '
        '04 Akita                '
        '05 Yamagata                  '
        '06 Miyagi                  '
        '07 Fukushima              '
        '08 Niigata                    '
        '09 Nagano                  '
        '10 Tokyo                  '
        '11 Kanagawa                    '
        '12 Chiba                   '
        '13 Saitama                  '
        '14 Ibaraki                     '
        '15 Tochigi                 '
        '16 Gumma                   '
        '17 Yamanashi               '
        '18 Shizuoka              '
        '19 Gifu                  '
        '20 Aichi               '
        '21 Mie                '
        '22 Kyoto                 '
        '23 Shiga               '
        '24 Nara               '
        '25 Osaka               '
        '26 Wakayama               '
        '27 Hyogo               '
        '28 Toyama                '
        '29 Fukui               '
        '30 Ishikawa               '
        '31 Okayama               '
        '32 Shimane               '
        '33 Yamaguchi                '
        '34 Tottori                '
        '35 Hiroshima               '
        '36 Kagawa               '
        '37 Tokushima               '
        '38 Ehime               '
        '39 Kochi               '
        '40 Fukuoka                 '
        '41 Saga                        '
        '42 Nagasaki                   '
        '43 Kumamoto                     '
        '44 Oita                     '
        '45 Miyazaki                    '
        '46 Kagoshima                   '
        '47 Okinawa                    '
        '48 Ogasawara                   '
        '49 Okinotorishima                     '
        '50 Minami-torishima         ')
      ParentFont = False
      TabOrder = 2
      Visible = False
    end
  end
end
