object formEntityInfo: TformEntityInfo
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Entity information'
  ClientHeight = 216
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 216
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = -8
    ExplicitTop = -1
    ExplicitWidth = 339
    ExplicitHeight = 160
    object Image1: TImage
      Left = 8
      Top = 8
      Width = 200
      Height = 200
    end
    object labelAzimuth: TLabel
      Left = 214
      Top = 181
      Width = 99
      Height = 29
      Alignment = taCenter
      AutoSize = False
      Caption = '360'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object labelLongitude: TLabel
      Left = 214
      Top = 150
      Width = 99
      Height = 29
      Alignment = taCenter
      AutoSize = False
      Caption = '360'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object labelLatitude: TLabel
      Left = 214
      Top = 119
      Width = 99
      Height = 29
      Alignment = taCenter
      AutoSize = False
      Caption = '360'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 214
      Top = 8
      Width = 65
      Height = 13
      Caption = 'Country name'
    end
    object Label2: TLabel
      Left = 214
      Top = 52
      Width = 43
      Height = 13
      Caption = 'CQ Zone'
    end
    object Label3: TLabel
      Left = 214
      Top = 76
      Width = 46
      Height = 13
      Caption = 'ITU Zone'
    end
    object Label4: TLabel
      Left = 214
      Top = 100
      Width = 45
      Height = 13
      Caption = 'Continent'
    end
    object editCqZone: TEdit
      Left = 283
      Top = 49
      Width = 30
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
      Text = '99'
    end
    object editItuZone: TEdit
      Left = 283
      Top = 73
      Width = 30
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
      Text = '99'
    end
    object editContinent: TEdit
      Left = 283
      Top = 97
      Width = 30
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
      Text = 'AS'
    end
    object editCountryName: TEdit
      Left = 214
      Top = 22
      Width = 99
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
  end
end
