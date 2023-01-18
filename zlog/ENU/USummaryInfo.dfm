object SummaryInfo: TSummaryInfo
  Left = 202
  Top = 30
  BorderStyle = bsDialog
  Caption = 'Summary Info'
  ClientHeight = 504
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 49
    Top = 75
    Width = 46
    Height = 12
    Caption = 'Category'
  end
  object Label2: TLabel
    Left = 54
    Top = 49
    Width = 41
    Height = 12
    Caption = 'Callsign'
  end
  object Label3: TLabel
    Left = 66
    Top = 396
    Width = 29
    Height = 12
    Caption = 'Name'
  end
  object Label4: TLabel
    Left = 24
    Top = 24
    Width = 71
    Height = 12
    Caption = 'Contest name'
  end
  object Label6: TLabel
    Left = 53
    Top = 432
    Width = 42
    Height = 12
    Caption = 'Address'
  end
  object Label8: TLabel
    Left = 50
    Top = 248
    Width = 45
    Height = 12
    Caption = 'Remarks'
  end
  object Label5: TLabel
    Left = 55
    Top = 100
    Width = 40
    Height = 12
    Caption = 'Country'
  end
  object Label9: TLabel
    Left = 37
    Top = 336
    Width = 58
    Height = 12
    Caption = 'Declaration'
  end
  object Label10: TLabel
    Left = 14
    Top = 144
    Width = 72
    Height = 36
    Caption = 'Misc. (anntenas, operators etc)'
    WordWrap = True
  end
  object CategoryEdit: TEdit
    Left = 112
    Top = 71
    Width = 249
    Height = 20
    TabOrder = 0
  end
  object NameEdit: TEdit
    Left = 112
    Top = 392
    Width = 337
    Height = 20
    TabOrder = 1
  end
  object ContestNameEdit: TEdit
    Left = 112
    Top = 20
    Width = 337
    Height = 20
    TabOrder = 2
  end
  object Button1: TButton
    Left = 152
    Top = 472
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
  end
  object Button2: TButton
    Left = 264
    Top = 472
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object RemMemo: TMemo
    Left = 112
    Top = 214
    Width = 337
    Height = 81
    TabOrder = 5
  end
  object CountryEdit: TEdit
    Left = 112
    Top = 96
    Width = 249
    Height = 20
    TabOrder = 6
  end
  object DecMemo: TMemo
    Left = 112
    Top = 301
    Width = 337
    Height = 83
    Lines.Strings = (
      
        'This is to certify that in this contest I have operated my trans' +
        'mitter'
      'within the limitations of my license and have fully observed the'
      'rules and regulations of the contest.')
    TabOrder = 7
    WordWrap = False
  end
  object MiscMemo: TMemo
    Left = 112
    Top = 128
    Width = 337
    Height = 81
    TabOrder = 8
  end
  object AddrMemo: TMemo
    Left = 112
    Top = 421
    Width = 337
    Height = 44
    TabOrder = 9
  end
  object CallEdit: TEdit
    Left = 112
    Top = 45
    Width = 249
    Height = 20
    TabOrder = 10
  end
end
