object GraphColorDialog: TGraphColorDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Color Settings'
  ClientHeight = 584
  ClientWidth = 412
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 546
    Width = 412
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      412
      38)
    object buttonOK: TButton
      Left = 238
      Top = 6
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object buttonCancel: TButton
      Left = 325
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
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 412
    Height = 546
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 393
      Height = 129
      Caption = 'HF(Low)'
      TabOrder = 0
      object Label57: TLabel
        Left = 3
        Top = 21
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '1.9M'
      end
      object Label1: TLabel
        Left = 3
        Top = 47
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '3.5M'
      end
      object Label2: TLabel
        Left = 3
        Top = 73
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '7M'
      end
      object Label3: TLabel
        Left = 3
        Top = 99
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '10M'
      end
      object editColor01: TEdit
        Left = 86
        Top = 18
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 0
        Text = 'TEXT'
      end
      object buttonFG01: TButton
        Left = 164
        Top = 19
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = buttonFGClick
      end
      object buttonBSReset1: TButton
        Tag = 1
        Left = 311
        Top = 18
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object buttonBG01: TButton
        Left = 213
        Top = 19
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = buttonBGClick
      end
      object editColor02: TEdit
        Left = 86
        Top = 44
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 4
        Text = 'TEXT'
      end
      object buttonFG02: TButton
        Tag = 1
        Left = 164
        Top = 45
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = buttonFGClick
      end
      object Button2: TButton
        Tag = 1
        Left = 311
        Top = 44
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object buttonBG02: TButton
        Tag = 1
        Left = 213
        Top = 45
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = buttonBGClick
      end
      object editColor03: TEdit
        Left = 86
        Top = 70
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 8
        Text = 'TEXT'
      end
      object buttonFG03: TButton
        Tag = 2
        Left = 164
        Top = 71
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = buttonFGClick
      end
      object Button5: TButton
        Tag = 1
        Left = 311
        Top = 70
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object buttonBG03: TButton
        Tag = 2
        Left = 213
        Top = 71
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnClick = buttonBGClick
      end
      object editColor04: TEdit
        Left = 86
        Top = 96
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 12
        Text = 'TEXT'
      end
      object buttonFG04: TButton
        Tag = 3
        Left = 164
        Top = 97
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        OnClick = buttonFGClick
      end
      object Button8: TButton
        Tag = 1
        Left = 311
        Top = 96
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object buttonBG04: TButton
        Tag = 3
        Left = 213
        Top = 97
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        OnClick = buttonBGClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 143
      Width = 393
      Height = 154
      Caption = 'HF(High)'
      TabOrder = 1
      object Label4: TLabel
        Left = 3
        Top = 21
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '14M'
      end
      object Label5: TLabel
        Left = 3
        Top = 47
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '18M'
      end
      object Label6: TLabel
        Left = 4
        Top = 74
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '21M'
      end
      object Label7: TLabel
        Left = 3
        Top = 99
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '24M'
      end
      object Label8: TLabel
        Left = 4
        Top = 125
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '28M'
      end
      object editColor05: TEdit
        Left = 86
        Top = 18
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 0
        Text = 'TEXT'
      end
      object buttonFG05: TButton
        Tag = 4
        Left = 164
        Top = 19
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = buttonFGClick
      end
      object Button11: TButton
        Tag = 1
        Left = 311
        Top = 18
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object buttonBG05: TButton
        Tag = 4
        Left = 213
        Top = 19
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = buttonBGClick
      end
      object editColor06: TEdit
        Left = 86
        Top = 44
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 4
        Text = 'TEXT'
      end
      object buttonFG06: TButton
        Tag = 5
        Left = 164
        Top = 45
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = buttonFGClick
      end
      object Button14: TButton
        Tag = 1
        Left = 311
        Top = 44
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object buttonBG06: TButton
        Tag = 5
        Left = 213
        Top = 45
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = buttonBGClick
      end
      object editColor07: TEdit
        Left = 86
        Top = 70
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 8
        Text = 'TEXT'
      end
      object buttonFG07: TButton
        Tag = 6
        Left = 164
        Top = 71
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = buttonFGClick
      end
      object Button17: TButton
        Tag = 1
        Left = 311
        Top = 70
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object buttonBG07: TButton
        Tag = 6
        Left = 213
        Top = 71
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnClick = buttonBGClick
      end
      object editColor08: TEdit
        Left = 86
        Top = 96
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 12
        Text = 'TEXT'
      end
      object buttonFG08: TButton
        Tag = 7
        Left = 164
        Top = 97
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        OnClick = buttonFGClick
      end
      object Button20: TButton
        Tag = 1
        Left = 311
        Top = 96
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object buttonBG08: TButton
        Tag = 7
        Left = 213
        Top = 97
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        OnClick = buttonBGClick
      end
      object editColor09: TEdit
        Left = 86
        Top = 122
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 16
        Text = 'TEXT'
      end
      object buttonFG09: TButton
        Tag = 8
        Left = 164
        Top = 123
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        OnClick = buttonFGClick
      end
      object Button23: TButton
        Tag = 1
        Left = 311
        Top = 122
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
      end
      object buttonBG09: TButton
        Tag = 8
        Left = 213
        Top = 123
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 19
        OnClick = buttonBGClick
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 303
      Width = 393
      Height = 78
      Caption = 'VHF'
      TabOrder = 2
      object Label9: TLabel
        Left = 4
        Top = 21
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '50M'
      end
      object Label10: TLabel
        Left = 4
        Top = 47
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '144M'
      end
      object editColor10: TEdit
        Left = 86
        Top = 18
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 0
        Text = 'TEXT'
      end
      object buttonFG10: TButton
        Tag = 9
        Left = 164
        Top = 19
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = buttonFGClick
      end
      object Button26: TButton
        Tag = 1
        Left = 311
        Top = 18
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object buttonBG10: TButton
        Tag = 9
        Left = 213
        Top = 19
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = buttonBGClick
      end
      object editColor11: TEdit
        Left = 86
        Top = 44
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 4
        Text = 'TEXT'
      end
      object buttonFG11: TButton
        Tag = 10
        Left = 164
        Top = 45
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = buttonFGClick
      end
      object Button29: TButton
        Tag = 1
        Left = 311
        Top = 44
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object buttonBG11: TButton
        Tag = 10
        Left = 213
        Top = 45
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = buttonBGClick
      end
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = 387
      Width = 393
      Height = 155
      Caption = 'UHF'
      TabOrder = 3
      object Label11: TLabel
        Left = 3
        Top = 22
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '430M'
      end
      object Label12: TLabel
        Left = 3
        Top = 48
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '1200M'
      end
      object Label13: TLabel
        Left = 3
        Top = 74
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '2400M'
      end
      object Label14: TLabel
        Left = 3
        Top = 100
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '5600M'
      end
      object Label15: TLabel
        Left = 4
        Top = 126
        Width = 64
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = '10 GHz && up'
      end
      object editColor12: TEdit
        Left = 86
        Top = 18
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 0
        Text = 'TEXT'
      end
      object buttonFG12: TButton
        Tag = 11
        Left = 164
        Top = 19
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = buttonFGClick
      end
      object Button32: TButton
        Tag = 1
        Left = 311
        Top = 18
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object buttonBG12: TButton
        Tag = 11
        Left = 213
        Top = 19
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = buttonBGClick
      end
      object editColor13: TEdit
        Left = 86
        Top = 44
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 4
        Text = 'TEXT'
      end
      object buttonFG13: TButton
        Tag = 12
        Left = 164
        Top = 45
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = buttonFGClick
      end
      object Button35: TButton
        Tag = 1
        Left = 311
        Top = 44
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object buttonBG13: TButton
        Tag = 12
        Left = 213
        Top = 45
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = buttonBGClick
      end
      object editColor14: TEdit
        Left = 86
        Top = 70
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 8
        Text = 'TEXT'
      end
      object buttonFG14: TButton
        Tag = 13
        Left = 164
        Top = 71
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = buttonFGClick
      end
      object Button38: TButton
        Tag = 1
        Left = 311
        Top = 70
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object buttonBG14: TButton
        Tag = 13
        Left = 213
        Top = 71
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnClick = buttonBGClick
      end
      object editColor15: TEdit
        Left = 86
        Top = 96
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 12
        Text = 'TEXT'
      end
      object buttonFG15: TButton
        Tag = 14
        Left = 164
        Top = 97
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        OnClick = buttonFGClick
      end
      object Button41: TButton
        Tag = 1
        Left = 311
        Top = 96
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object buttonBG15: TButton
        Tag = 14
        Left = 213
        Top = 97
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        OnClick = buttonBGClick
      end
      object editColor16: TEdit
        Left = 86
        Top = 122
        Width = 70
        Height = 20
        TabStop = False
        ReadOnly = True
        TabOrder = 16
        Text = 'TEXT'
      end
      object buttonFG16: TButton
        Tag = 15
        Left = 164
        Top = 123
        Width = 45
        Height = 20
        Caption = 'Fore...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        OnClick = buttonFGClick
      end
      object Button44: TButton
        Tag = 1
        Left = 311
        Top = 122
        Width = 41
        Height = 20
        Caption = 'Reset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
      end
      object buttonBG16: TButton
        Tag = 15
        Left = 213
        Top = 123
        Width = 45
        Height = 20
        Caption = 'Back...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        ParentFont = False
        TabOrder = 19
        OnClick = buttonBGClick
      end
    end
  end
  object ColorDialog1: TColorDialog
    Left = 16
    Top = 552
  end
end
