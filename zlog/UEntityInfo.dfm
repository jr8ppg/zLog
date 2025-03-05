object formEntityInfo: TformEntityInfo
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Entity information'
  ClientHeight = 324
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
    Top = 37
    Width = 320
    Height = 221
    Align = alClient
    TabOrder = 0
    ExplicitTop = 0
    ExplicitHeight = 216
    object Image1: TImage
      Left = 8
      Top = 8
      Width = 200
      Height = 200
    end
    object Label2: TLabel
      Left = 214
      Top = 64
      Width = 43
      Height = 13
      Caption = 'CQ Zone'
    end
    object Label3: TLabel
      Left = 214
      Top = 114
      Width = 46
      Height = 13
      Caption = 'ITU Zone'
    end
    object Label4: TLabel
      Left = 214
      Top = 164
      Width = 45
      Height = 13
      Caption = 'Continent'
    end
    object Label1: TLabel
      Left = 214
      Top = 14
      Width = 26
      Height = 13
      Caption = 'Entity'
    end
    object panelCQZone: TPanel
      Left = 239
      Top = 79
      Width = 58
      Height = 29
      BevelOuter = bvLowered
      Caption = '25'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object panelITUZone: TPanel
      Left = 239
      Top = 129
      Width = 58
      Height = 29
      BevelOuter = bvLowered
      Caption = '25'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object panelContinent: TPanel
      Left = 239
      Top = 179
      Width = 58
      Height = 29
      BevelOuter = bvLowered
      Caption = '25'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object panelCountry: TPanel
      Left = 214
      Top = 29
      Width = 99
      Height = 29
      BevelOuter = bvLowered
      Caption = 'JA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 258
    Width = 320
    Height = 66
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 222
    object panelLatitude: TPanel
      Left = 8
      Top = 8
      Width = 121
      Height = 25
      BevelOuter = bvLowered
      Caption = 'N45:00:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object panelLongitude: TPanel
      Left = 8
      Top = 35
      Width = 121
      Height = 25
      BevelOuter = bvLowered
      Caption = 'E135:00:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object panelDistance: TPanel
      Left = 135
      Top = 8
      Width = 113
      Height = 25
      BevelOuter = bvLowered
      Caption = '12,000Km'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object panelAzimuth: TPanel
      Left = 255
      Top = 8
      Width = 58
      Height = 52
      BevelOuter = bvLowered
      Caption = '360'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 37
    Align = alTop
    TabOrder = 2
    object panelCountryName: TPanel
      Left = 8
      Top = 6
      Width = 305
      Height = 25
      BevelOuter = bvLowered
      Caption = 'Japan'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
end
