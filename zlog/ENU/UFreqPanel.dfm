object formFreqPanel: TformFreqPanel
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Freq.'
  ClientHeight = 110
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 86
    Width = 329
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitWidth = 240
    DesignSize = (
      329
      24)
    object buttonCancel: TButton
      Left = 252
      Top = 2
      Width = 65
      Height = 20
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      ExplicitLeft = 163
    end
    object buttonOK: TButton
      Left = 183
      Top = 2
      Width = 65
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 1
      ExplicitLeft = 94
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 329
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 4
    ExplicitWidth = 240
    object buttonBand01: TSpeedButton
      Tag = 1800
      Left = 0
      Top = 0
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '1.9'
      OnClick = buttonBandClick
    end
    object buttonBand02: TSpeedButton
      Tag = 3500
      Left = 30
      Top = 0
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '3.5'
      OnClick = buttonBandClick
    end
    object buttonBand03: TSpeedButton
      Tag = 7000
      Left = 60
      Top = 0
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '7'
      OnClick = buttonBandClick
    end
    object buttonBand04: TSpeedButton
      Tag = 10100
      Left = 90
      Top = 0
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '10'
      OnClick = buttonBandClick
    end
    object buttonBand05: TSpeedButton
      Tag = 14000
      Left = 120
      Top = 0
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '14'
      OnClick = buttonBandClick
    end
    object buttonBand06: TSpeedButton
      Tag = 18000
      Left = 150
      Top = 0
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '18'
      OnClick = buttonBandClick
    end
    object buttonBand07: TSpeedButton
      Tag = 21000
      Left = 180
      Top = 0
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '21'
      OnClick = buttonBandClick
    end
    object buttonBand08: TSpeedButton
      Tag = 24000
      Left = 210
      Top = 0
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '24'
      OnClick = buttonBandClick
    end
    object buttonBand09: TSpeedButton
      Tag = 28000
      Left = 237
      Top = 0
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '28'
      OnClick = buttonBandClick
    end
    object buttonBand10: TSpeedButton
      Tag = 50000
      Left = 267
      Top = 0
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '50'
      OnClick = buttonBandClick
    end
    object buttonBand11: TSpeedButton
      Tag = 144000
      Left = 297
      Top = 0
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '144'
      OnClick = buttonBandClick
    end
    object buttonBand12: TSpeedButton
      Tag = 430000
      Left = 0
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '430'
      OnClick = buttonBandClick
    end
    object buttonBand13: TSpeedButton
      Tag = 1294000
      Left = 30
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '1200'
      OnClick = buttonBandClick
    end
    object buttonBand14: TSpeedButton
      Tag = 2424000
      Left = 60
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '2400'
      OnClick = buttonBandClick
    end
    object buttonBand15: TSpeedButton
      Tag = 5760000
      Left = 90
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '5600'
      OnClick = buttonBandClick
    end
    object buttonBand16: TSpeedButton
      Tag = 10240000
      Left = 120
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '10.1G'
      OnClick = buttonBandClick
    end
    object buttonBand17: TSpeedButton
      Tag = 10450000
      Left = 150
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '10.4G'
      OnClick = buttonBandClick
    end
    object buttonBand18: TSpeedButton
      Tag = 24000000
      Left = 180
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '24G'
      OnClick = buttonBandClick
    end
    object buttonBand19: TSpeedButton
      Tag = 47000000
      Left = 210
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '47G'
      OnClick = buttonBandClick
    end
    object buttonBand20: TSpeedButton
      Tag = 77500000
      Left = 237
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '77G'
      OnClick = buttonBandClick
    end
    object buttonBand21: TSpeedButton
      Tag = 134000000
      Left = 267
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '135G'
      OnClick = buttonBandClick
    end
    object buttonBand22: TSpeedButton
      Tag = 248000000
      Left = 297
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '248G'
      OnClick = buttonBandClick
    end
  end
  object editMHz: TEdit
    Left = 95
    Top = 47
    Width = 70
    Height = 30
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Consolas'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    TabOrder = 0
    Text = '2400'
  end
  object editKHz: TEdit
    Left = 164
    Top = 47
    Width = 36
    Height = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Consolas'
    Font.Style = []
    MaxLength = 3
    NumbersOnly = True
    ParentFont = False
    TabOrder = 1
    Text = '000'
    OnChange = editKHzChange
    OnExit = editKHzExit
  end
  object editHz: TEdit
    Left = 199
    Top = 47
    Width = 39
    Height = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Consolas'
    Font.Style = []
    MaxLength = 3
    NumbersOnly = True
    ParentFont = False
    TabOrder = 2
    Text = '000'
    OnExit = editKHzExit
  end
end
