object BandPlanEditDialog: TBandPlanEditDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Band Plan'
  ClientHeight = 432
  ClientWidth = 544
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 394
    Width = 544
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 334
    DesignSize = (
      544
      38)
    object buttonOK: TButton
      Left = 370
      Top = 6
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      OnClick = buttonOKClick
    end
    object buttonCancel: TButton
      Left = 457
      Top = 6
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object tabctrlPreset: TTabControl
    Left = 0
    Top = 0
    Width = 544
    Height = 394
    Align = alClient
    PopupMenu = popupPreset
    TabOrder = 0
    Tabs.Strings = (
      'JA'
      'DX')
    TabIndex = 0
    OnChange = tabctrlModeChange
    OnChanging = tabctrlModeChanging
    ExplicitHeight = 334
    object tabctrlMode: TTabControl
      Left = 4
      Top = 24
      Width = 536
      Height = 366
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      Tabs.Strings = (
        'CW'
        'SSB'
        'FM'
        'AM'
        'RTTY'
        'OTHER')
      TabIndex = 0
      OnChange = tabctrlModeChange
      OnChanging = tabctrlModeChanging
      ExplicitHeight = 306
      DesignSize = (
        536
        366)
      object labelBand01: TLabel
        Left = 6
        Top = 40
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '1.9M'
      end
      object labelBand02: TLabel
        Left = 6
        Top = 66
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '3.5M'
      end
      object labelBand03: TLabel
        Left = 6
        Top = 92
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '7M'
      end
      object labelBand04: TLabel
        Left = 6
        Top = 118
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '10M'
      end
      object labelBand05: TLabel
        Left = 6
        Top = 144
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '14M'
      end
      object labelBand06: TLabel
        Left = 6
        Top = 170
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '18M'
      end
      object labelBand07: TLabel
        Left = 6
        Top = 196
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '21M'
      end
      object labelBand08: TLabel
        Left = 6
        Top = 222
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '24.5M'
      end
      object labelBand09: TLabel
        Left = 7
        Top = 248
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '28M'
      end
      object labelBand10: TLabel
        Left = 7
        Top = 274
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '50M'
      end
      object labelBand11: TLabel
        Left = 7
        Top = 300
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '144M'
      end
      object labelBand12: TLabel
        Left = 251
        Top = 40
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '430M'
      end
      object labelBand13: TLabel
        Left = 251
        Top = 66
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '1200M'
      end
      object labelBand14: TLabel
        Left = 251
        Top = 92
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '2400M'
      end
      object labelBand15: TLabel
        Left = 251
        Top = 118
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '5600M'
      end
      object labelBand16: TLabel
        Left = 251
        Top = 144
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '10.1 GHz'
      end
      object Label17: TLabel
        Left = 134
        Top = 40
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label18: TLabel
        Left = 215
        Top = 40
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label19: TLabel
        Left = 134
        Top = 248
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label20: TLabel
        Left = 215
        Top = 248
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label21: TLabel
        Left = 134
        Top = 66
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label22: TLabel
        Left = 215
        Top = 66
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label23: TLabel
        Left = 134
        Top = 274
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label24: TLabel
        Left = 215
        Top = 274
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label25: TLabel
        Left = 134
        Top = 92
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label26: TLabel
        Left = 215
        Top = 92
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label27: TLabel
        Left = 134
        Top = 300
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label28: TLabel
        Left = 215
        Top = 300
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label29: TLabel
        Left = 134
        Top = 118
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label30: TLabel
        Left = 215
        Top = 118
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label31: TLabel
        Left = 390
        Top = 40
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label32: TLabel
        Left = 480
        Top = 40
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label33: TLabel
        Left = 134
        Top = 144
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label34: TLabel
        Left = 215
        Top = 144
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label35: TLabel
        Left = 390
        Top = 66
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label36: TLabel
        Left = 480
        Top = 66
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label37: TLabel
        Left = 134
        Top = 170
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label38: TLabel
        Left = 215
        Top = 170
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label39: TLabel
        Left = 390
        Top = 92
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label40: TLabel
        Left = 480
        Top = 92
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label41: TLabel
        Left = 134
        Top = 196
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label42: TLabel
        Left = 215
        Top = 196
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label43: TLabel
        Left = 390
        Top = 118
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label44: TLabel
        Left = 480
        Top = 118
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label45: TLabel
        Left = 134
        Top = 222
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label46: TLabel
        Left = 215
        Top = 222
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object Label47: TLabel
        Left = 390
        Top = 144
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label48: TLabel
        Left = 480
        Top = 144
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object labelBand17: TLabel
        Left = 251
        Top = 170
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '10.4 GHz'
      end
      object Label2: TLabel
        Left = 390
        Top = 170
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label3: TLabel
        Left = 480
        Top = 170
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object labelBand18: TLabel
        Left = 251
        Top = 196
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '24 GHz'
      end
      object Label5: TLabel
        Left = 390
        Top = 196
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label6: TLabel
        Left = 480
        Top = 196
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object labelBand19: TLabel
        Left = 251
        Top = 222
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '47 GHz'
      end
      object Label8: TLabel
        Left = 390
        Top = 222
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label9: TLabel
        Left = 480
        Top = 222
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object labelBand20: TLabel
        Left = 251
        Top = 248
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '77 GHz'
      end
      object Label11: TLabel
        Left = 390
        Top = 248
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label12: TLabel
        Left = 480
        Top = 248
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object labelBand21: TLabel
        Left = 251
        Top = 274
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '135 GHz'
      end
      object Label14: TLabel
        Left = 390
        Top = 274
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label15: TLabel
        Left = 480
        Top = 274
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object labelBand22: TLabel
        Left = 251
        Top = 300
        Width = 58
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '248 GHz'
      end
      object Label49: TLabel
        Left = 390
        Top = 300
        Width = 10
        Height = 13
        Caption = #65374
      end
      object Label50: TLabel
        Left = 480
        Top = 300
        Width = 19
        Height = 13
        Caption = 'kHz'
      end
      object editLower01: TEdit
        Left = 71
        Top = 37
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 0
      end
      object editLower02: TEdit
        Left = 71
        Top = 63
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 2
      end
      object editLower03: TEdit
        Left = 71
        Top = 89
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 4
      end
      object editLower04: TEdit
        Left = 71
        Top = 115
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 6
      end
      object editLower05: TEdit
        Left = 71
        Top = 141
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 8
      end
      object editLower06: TEdit
        Left = 71
        Top = 167
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 10
      end
      object editLower07: TEdit
        Left = 71
        Top = 193
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 12
      end
      object editLower08: TEdit
        Left = 71
        Top = 219
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 14
      end
      object editUpper01: TEdit
        Left = 152
        Top = 37
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 1
      end
      object editUpper02: TEdit
        Left = 152
        Top = 63
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 3
      end
      object editUpper03: TEdit
        Left = 152
        Top = 89
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 5
      end
      object editUpper04: TEdit
        Left = 152
        Top = 115
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 7
      end
      object editUpper05: TEdit
        Left = 152
        Top = 141
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 9
      end
      object editUpper06: TEdit
        Left = 152
        Top = 167
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 11
      end
      object editUpper07: TEdit
        Left = 152
        Top = 193
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 13
      end
      object editUpper08: TEdit
        Left = 152
        Top = 219
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 15
      end
      object editLower10: TEdit
        Left = 71
        Top = 271
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 18
      end
      object editLower11: TEdit
        Left = 71
        Top = 297
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 20
      end
      object editLower12: TEdit
        Left = 315
        Top = 37
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 22
      end
      object editLower13: TEdit
        Left = 315
        Top = 63
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 24
      end
      object editLower14: TEdit
        Left = 315
        Top = 89
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 26
      end
      object editLower15: TEdit
        Left = 315
        Top = 115
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 28
      end
      object editLower16: TEdit
        Left = 315
        Top = 141
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 30
      end
      object editUpper09: TEdit
        Left = 152
        Top = 245
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 17
      end
      object editLower09: TEdit
        Left = 71
        Top = 245
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 16
      end
      object editUpper10: TEdit
        Left = 152
        Top = 271
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 19
      end
      object editUpper11: TEdit
        Left = 152
        Top = 297
        Width = 57
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 21
      end
      object editUpper12: TEdit
        Left = 408
        Top = 37
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 23
      end
      object editUpper13: TEdit
        Left = 408
        Top = 63
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 25
      end
      object editUpper14: TEdit
        Left = 408
        Top = 89
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 27
      end
      object editUpper15: TEdit
        Left = 408
        Top = 115
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 29
      end
      object editUpper16: TEdit
        Left = 408
        Top = 141
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 31
      end
      object buttonLoadJaDefaults: TButton
        Left = 16
        Top = 327
        Width = 112
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Load JA defaults'
        TabOrder = 32
        OnClick = buttonLoadDefaultsClick
        ExplicitTop = 267
      end
      object buttonLoadDxDefaults: TButton
        Tag = 1
        Left = 134
        Top = 327
        Width = 112
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Load DX defaults'
        TabOrder = 33
        OnClick = buttonLoadDefaultsClick
        ExplicitTop = 267
      end
      object editLower17: TEdit
        Left = 315
        Top = 167
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 34
      end
      object editUpper17: TEdit
        Left = 408
        Top = 167
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 35
      end
      object editLower18: TEdit
        Left = 315
        Top = 193
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 36
      end
      object editUpper18: TEdit
        Left = 408
        Top = 193
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 37
      end
      object editLower19: TEdit
        Left = 315
        Top = 219
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 38
      end
      object editUpper19: TEdit
        Left = 408
        Top = 219
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 39
      end
      object editLower20: TEdit
        Left = 315
        Top = 245
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 40
      end
      object editUpper20: TEdit
        Left = 408
        Top = 245
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 41
      end
      object editLower21: TEdit
        Left = 315
        Top = 271
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 42
      end
      object editUpper21: TEdit
        Left = 408
        Top = 271
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 43
      end
      object editLower22: TEdit
        Left = 315
        Top = 297
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 44
      end
      object editUpper22: TEdit
        Left = 408
        Top = 297
        Width = 66
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        ImeMode = imDisable
        NumbersOnly = True
        TabOrder = 45
      end
    end
  end
  object popupPreset: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    OnPopup = popupPresetPopup
    Left = 388
    Top = 16
    object menuAddPreset: TMenuItem
      Caption = 'Add preset'
      OnClick = menuAddPresetClick
    end
    object menuDeletePreset: TMenuItem
      Caption = 'Delete preset'
      OnClick = menuDeletePresetClick
    end
  end
end
