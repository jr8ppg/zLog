object GraphColorDialog: TGraphColorDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'QSO Rate Settings'
  ClientHeight = 377
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
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 339
    Width = 412
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
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
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 412
    Height = 339
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 412
    Height = 339
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = #12464#12521#12501
      object groupDrawStyle: TGroupBox
        Left = 4
        Top = 4
        Width = 389
        Height = 108
        Caption = #12473#12479#12452#12523
        TabOrder = 0
        object radioDrawStyle1: TRadioButton
          Left = 16
          Top = 16
          Width = 150
          Height = 25
          Caption = #12458#12522#12472#12490#12523'('#33394#20998#12369#28961#12375')'
          TabOrder = 0
        end
        object radioDrawStyle2: TRadioButton
          Left = 16
          Top = 43
          Width = 250
          Height = 25
          Caption = #12496#12531#12489#21029#33394#20998#12369'(1.9M, 3.5M, 7M ... 10G)'
          TabOrder = 1
        end
        object radioDrawStyle3: TRadioButton
          Left = 16
          Top = 70
          Width = 200
          Height = 25
          Caption = #21608#27874#25968#24111#21029#33394#20998#12369'(HF,VHF,UHF)'
          TabOrder = 2
        end
      end
      object groupDrawStartPos: TGroupBox
        Left = 4
        Top = 118
        Width = 389
        Height = 108
        Caption = #38283#22987#20301#32622
        TabOrder = 1
        object radioDrawStartPos1: TRadioButton
          Left = 16
          Top = 16
          Width = 150
          Height = 25
          Caption = #26368#21021#12398'QSO'
          TabOrder = 0
        end
        object radioDrawStartPos2: TRadioButton
          Left = 16
          Top = 43
          Width = 150
          Height = 25
          Caption = #29694#22312#26178#21051#12363#12425#25351#23450#26178#38291#21069
          TabOrder = 1
        end
        object radioDrawStartPos3: TRadioButton
          Left = 16
          Top = 70
          Width = 180
          Height = 25
          Caption = #26368#24460#12398'QSO'#12363#12425#25351#23450#26178#38291#21069
          TabOrder = 2
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #33394#35373#23450#65297
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 4
        Top = 4
        Width = 393
        Height = 129
        Caption = 'HF(Low)'
        TabOrder = 0
        object Label57: TLabel
          Left = 6
          Top = 21
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '1.9M'
        end
        object Label1: TLabel
          Left = 6
          Top = 47
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '3.5M'
        end
        object Label2: TLabel
          Left = 6
          Top = 73
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '7M'
        end
        object Label3: TLabel
          Left = 6
          Top = 99
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '10M'
        end
        object editColor01: TEdit
          Left = 89
          Top = 18
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'TEXT'
        end
        object buttonFG01: TButton
          Left = 167
          Top = 18
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 1
          OnClick = buttonFGClick
        end
        object buttonReset01: TButton
          Left = 314
          Top = 18
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 3
          OnClick = buttonResetClick
        end
        object buttonBG01: TButton
          Left = 216
          Top = 18
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonBGClick
        end
        object editColor02: TEdit
          Left = 89
          Top = 44
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 4
          Text = 'TEXT'
        end
        object buttonFG02: TButton
          Tag = 1
          Left = 167
          Top = 44
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 5
          OnClick = buttonFGClick
        end
        object buttonReset02: TButton
          Tag = 1
          Left = 314
          Top = 44
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 7
          OnClick = buttonResetClick
        end
        object buttonBG02: TButton
          Tag = 1
          Left = 216
          Top = 44
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 6
          OnClick = buttonBGClick
        end
        object editColor03: TEdit
          Left = 89
          Top = 70
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 8
          Text = 'TEXT'
        end
        object buttonFG03: TButton
          Tag = 2
          Left = 167
          Top = 70
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 9
          OnClick = buttonFGClick
        end
        object buttonReset03: TButton
          Tag = 2
          Left = 314
          Top = 70
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 11
          OnClick = buttonResetClick
        end
        object buttonBG03: TButton
          Tag = 2
          Left = 216
          Top = 70
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 10
          OnClick = buttonBGClick
        end
        object editColor04: TEdit
          Left = 89
          Top = 96
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 12
          Text = 'TEXT'
        end
        object buttonFG04: TButton
          Tag = 3
          Left = 167
          Top = 96
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 13
          OnClick = buttonFGClick
        end
        object buttonReset04: TButton
          Tag = 3
          Left = 314
          Top = 96
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 15
          OnClick = buttonResetClick
        end
        object buttonBG04: TButton
          Tag = 3
          Left = 216
          Top = 96
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 14
          OnClick = buttonBGClick
        end
      end
      object GroupBox2: TGroupBox
        Left = 4
        Top = 140
        Width = 393
        Height = 154
        Caption = 'HF(High)'
        TabOrder = 1
        object Label4: TLabel
          Left = 6
          Top = 21
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '14M'
        end
        object Label5: TLabel
          Left = 6
          Top = 47
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '18M'
        end
        object Label6: TLabel
          Left = 6
          Top = 73
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '21M'
        end
        object Label7: TLabel
          Left = 6
          Top = 99
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '24M'
        end
        object Label8: TLabel
          Left = 6
          Top = 125
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '28M'
        end
        object editColor05: TEdit
          Left = 89
          Top = 18
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'TEXT'
        end
        object buttonFG05: TButton
          Tag = 4
          Left = 167
          Top = 18
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 1
          OnClick = buttonFGClick
        end
        object buttonReset05: TButton
          Tag = 4
          Left = 314
          Top = 18
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 3
          OnClick = buttonResetClick
        end
        object buttonBG05: TButton
          Tag = 4
          Left = 216
          Top = 18
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonBGClick
        end
        object editColor06: TEdit
          Left = 89
          Top = 44
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 4
          Text = 'TEXT'
        end
        object buttonFG06: TButton
          Tag = 5
          Left = 167
          Top = 44
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 5
          OnClick = buttonFGClick
        end
        object buttonReset06: TButton
          Tag = 5
          Left = 314
          Top = 44
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 7
          OnClick = buttonResetClick
        end
        object buttonBG06: TButton
          Tag = 5
          Left = 216
          Top = 44
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 6
          OnClick = buttonBGClick
        end
        object editColor07: TEdit
          Left = 89
          Top = 70
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 8
          Text = 'TEXT'
        end
        object buttonFG07: TButton
          Tag = 6
          Left = 167
          Top = 70
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 9
          OnClick = buttonFGClick
        end
        object buttonReset07: TButton
          Tag = 6
          Left = 314
          Top = 70
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 11
          OnClick = buttonResetClick
        end
        object buttonBG07: TButton
          Tag = 6
          Left = 216
          Top = 70
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 10
          OnClick = buttonBGClick
        end
        object editColor08: TEdit
          Left = 89
          Top = 96
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 12
          Text = 'TEXT'
        end
        object buttonFG08: TButton
          Tag = 7
          Left = 167
          Top = 96
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 13
          OnClick = buttonFGClick
        end
        object buttonReset08: TButton
          Tag = 7
          Left = 314
          Top = 96
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 15
          OnClick = buttonResetClick
        end
        object buttonBG08: TButton
          Tag = 7
          Left = 216
          Top = 96
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 14
          OnClick = buttonBGClick
        end
        object editColor09: TEdit
          Left = 89
          Top = 122
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 16
          Text = 'TEXT'
        end
        object buttonFG09: TButton
          Tag = 8
          Left = 167
          Top = 122
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 17
          OnClick = buttonFGClick
        end
        object buttonReset09: TButton
          Tag = 8
          Left = 314
          Top = 122
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 19
          OnClick = buttonResetClick
        end
        object buttonBG09: TButton
          Tag = 8
          Left = 216
          Top = 122
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 18
          OnClick = buttonBGClick
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #33394#35373#23450#65298
      ImageIndex = 2
      object GroupBox3: TGroupBox
        Left = 4
        Top = 4
        Width = 393
        Height = 78
        Caption = 'VHF'
        TabOrder = 0
        object Label9: TLabel
          Left = 6
          Top = 21
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '50M'
        end
        object Label10: TLabel
          Left = 6
          Top = 47
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '144M'
        end
        object editColor10: TEdit
          Left = 89
          Top = 18
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'TEXT'
        end
        object buttonFG10: TButton
          Tag = 9
          Left = 167
          Top = 18
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 1
          OnClick = buttonFGClick
        end
        object buttonReset10: TButton
          Tag = 9
          Left = 314
          Top = 18
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 3
          OnClick = buttonResetClick
        end
        object buttonBG10: TButton
          Tag = 9
          Left = 216
          Top = 18
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonBGClick
        end
        object editColor11: TEdit
          Left = 89
          Top = 44
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 4
          Text = 'TEXT'
        end
        object buttonFG11: TButton
          Tag = 10
          Left = 167
          Top = 44
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 5
          OnClick = buttonFGClick
        end
        object buttonReset11: TButton
          Tag = 10
          Left = 314
          Top = 44
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 7
          OnClick = buttonResetClick
        end
        object buttonBG11: TButton
          Tag = 10
          Left = 216
          Top = 44
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 6
          OnClick = buttonBGClick
        end
      end
      object GroupBox4: TGroupBox
        Left = 4
        Top = 88
        Width = 393
        Height = 105
        Caption = 'UHF'
        TabOrder = 1
        object Label11: TLabel
          Left = 6
          Top = 21
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '430M'
        end
        object Label12: TLabel
          Left = 6
          Top = 47
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '1200M'
        end
        object Label13: TLabel
          Left = 6
          Top = 73
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '2400M'
        end
        object editColor12: TEdit
          Left = 89
          Top = 18
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'TEXT'
        end
        object buttonFG12: TButton
          Tag = 11
          Left = 167
          Top = 18
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 1
          OnClick = buttonFGClick
        end
        object buttonReset12: TButton
          Tag = 11
          Left = 314
          Top = 18
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 3
          OnClick = buttonResetClick
        end
        object buttonBG12: TButton
          Tag = 11
          Left = 216
          Top = 18
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonBGClick
        end
        object editColor13: TEdit
          Left = 89
          Top = 44
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 4
          Text = 'TEXT'
        end
        object buttonFG13: TButton
          Tag = 12
          Left = 167
          Top = 44
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 5
          OnClick = buttonFGClick
        end
        object buttonReset13: TButton
          Tag = 12
          Left = 314
          Top = 44
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 7
          OnClick = buttonResetClick
        end
        object buttonBG13: TButton
          Tag = 12
          Left = 216
          Top = 44
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 6
          OnClick = buttonBGClick
        end
        object editColor14: TEdit
          Left = 89
          Top = 70
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 8
          Text = 'TEXT'
        end
        object buttonFG14: TButton
          Tag = 13
          Left = 167
          Top = 70
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 9
          OnClick = buttonFGClick
        end
        object buttonReset14: TButton
          Tag = 13
          Left = 314
          Top = 70
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 11
          OnClick = buttonResetClick
        end
        object buttonBG14: TButton
          Tag = 13
          Left = 216
          Top = 70
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 10
          OnClick = buttonBGClick
        end
      end
      object GroupBox5: TGroupBox
        Left = 4
        Top = 199
        Width = 393
        Height = 82
        Caption = 'SHF'
        TabOrder = 2
        object Label14: TLabel
          Left = 6
          Top = 21
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '5600M'
        end
        object Label15: TLabel
          Left = 6
          Top = 47
          Width = 64
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = '10 GHz && up'
        end
        object editColor15: TEdit
          Left = 89
          Top = 18
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'TEXT'
        end
        object buttonFG15: TButton
          Tag = 14
          Left = 167
          Top = 18
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 1
          OnClick = buttonFGClick
        end
        object buttonReset15: TButton
          Tag = 14
          Left = 314
          Top = 18
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 3
          OnClick = buttonResetClick
        end
        object buttonBG15: TButton
          Tag = 14
          Left = 216
          Top = 18
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonBGClick
        end
        object editColor16: TEdit
          Left = 89
          Top = 44
          Width = 70
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 4
          Text = 'TEXT'
        end
        object buttonFG16: TButton
          Tag = 15
          Left = 167
          Top = 44
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 5
          OnClick = buttonFGClick
        end
        object buttonReset16: TButton
          Tag = 15
          Left = 314
          Top = 44
          Width = 45
          Height = 20
          Caption = #21021#26399#20516
          TabOrder = 7
          OnClick = buttonResetClick
        end
        object buttonBG16: TButton
          Tag = 15
          Left = 216
          Top = 44
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 6
          OnClick = buttonBGClick
        end
      end
    end
  end
  object ColorDialog1: TColorDialog
    Left = 16
    Top = 344
  end
end
