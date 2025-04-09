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
    object Label5: TLabel
      Left = 8
      Top = 8
      Width = 54
      Height = 20
      Caption = 'Sunrise'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 8
      Top = 35
      Width = 51
      Height = 20
      Caption = 'Sunset'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object panelSunrise: TPanel
      Left = 68
      Top = 6
      Width = 121
      Height = 25
      BevelOuter = bvLowered
      Caption = '00:00:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object panelSunset: TPanel
      Left = 68
      Top = 33
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
    object checkStayOnTop: TCheckBox
      Left = 230
      Top = 40
      Width = 83
      Height = 17
      Caption = 'Stay on top'
      TabOrder = 2
      OnClick = checkStayOnTopClick
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
  object SunTime1: TSunTime
    UseSysTimeZone = False
    TimeZone = 9
    Latitude.Degrees = 0
    Latitude.Minutes = 0
    Latitude.Seconds = 0
    Longitude.Degrees = 0
    Longitude.Minutes = 0
    Longitude.Seconds = 0
    ZenithDistance.Degrees = 90
    ZenithDistance.Minutes = 50
    ZenithDistance.Seconds = 0
    Left = 136
    Top = 157
  end
end
