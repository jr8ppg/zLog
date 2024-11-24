object formFreqPanel: TformFreqPanel
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Freq.'
  ClientHeight = 110
  ClientWidth = 240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 86
    Width = 240
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 80
    ExplicitWidth = 260
    DesignSize = (
      240
      24)
    object buttonCancel: TButton
      Left = 171
      Top = 2
      Width = 65
      Height = 20
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      ExplicitLeft = 191
    end
    object buttonOK: TButton
      Left = 102
      Top = 2
      Width = 65
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 240
    Height = 40
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 4
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
      Tag = 10000
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
      Left = 0
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '28'
      OnClick = buttonBandClick
    end
    object buttonBand10: TSpeedButton
      Tag = 50000
      Left = 30
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '50'
      OnClick = buttonBandClick
    end
    object buttonBand11: TSpeedButton
      Tag = 144000
      Left = 60
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '144'
      OnClick = buttonBandClick
    end
    object buttonBand12: TSpeedButton
      Tag = 430000
      Left = 90
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '430'
      OnClick = buttonBandClick
    end
    object buttonBand13: TSpeedButton
      Tag = 1200000
      Left = 120
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '1200'
      OnClick = buttonBandClick
    end
    object buttonBand14: TSpeedButton
      Tag = 2400000
      Left = 150
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '2400'
      OnClick = buttonBandClick
    end
    object buttonBand15: TSpeedButton
      Tag = 5600000
      Left = 180
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '5600'
      OnClick = buttonBandClick
    end
    object buttonBand16: TSpeedButton
      Tag = 10000000
      Left = 210
      Top = 20
      Width = 30
      Height = 20
      GroupIndex = 1
      Caption = '10G'
      OnClick = buttonBandClick
    end
  end
  object editMHz: TEdit
    Left = 55
    Top = 46
    Width = 59
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
    Left = 113
    Top = 46
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
    Left = 148
    Top = 46
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
