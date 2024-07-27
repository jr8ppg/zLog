object formELogJarlEx: TformELogJarlEx
  Left = 103
  Top = 10
  BorderStyle = bsDialog
  Caption = 'JARL E-Log'
  ClientHeight = 690
  ClientWidth = 846
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poScreenCenter
  OnClick = checkBandClick
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 659
    Width = 846
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 619
    ExplicitWidth = 790
    object buttonCreateLog: TButton
      Left = 377
      Top = 6
      Width = 89
      Height = 23
      Caption = 'E-log'#20316#25104
      TabOrder = 2
      OnClick = buttonCreateLogClick
    end
    object buttonSave: TButton
      Left = 273
      Top = 6
      Width = 89
      Height = 23
      Caption = #20445#23384
      TabOrder = 1
      OnClick = buttonSaveClick
    end
    object buttonCancel: TButton
      Left = 481
      Top = 6
      Width = 89
      Height = 23
      Caption = #38281#12376#12427
      ModalResult = 2
      TabOrder = 3
      OnClick = buttonCancelClick
    end
    object checkFieldExtend: TCheckBox
      Left = 8
      Top = 6
      Width = 185
      Height = 17
      Caption = #25313#24373#65288#12510#12523#12481#65292#24471#28857#65292'TX#'#12434#36861#21152#65289
      TabOrder = 0
    end
  end
  object TabControl1: TTabControl
    Left = 0
    Top = 0
    Width = 846
    Height = 659
    Align = alClient
    TabOrder = 0
    Tabs.Strings = (
      'R1.0'
      'R2.1')
    TabIndex = 0
    OnChange = TabControl1Change
    ExplicitLeft = 1
    ExplicitTop = 3
    ExplicitWidth = 830
    ExplicitHeight = 606
    object Label2: TLabel
      Left = 24
      Top = 60
      Width = 78
      Height = 12
      Caption = #21442#21152#31278#30446#12467#12540#12489
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 367
      Top = 636
      Width = 24
      Height = 12
      Caption = #26085#20184
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Label23: TLabel
      Left = 624
      Top = 636
      Width = 24
      Height = 12
      Caption = #32626#21517
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object labelMultiOpList: TLabel
      Left = 24
      Top = 421
      Width = 187
      Height = 12
      Caption = #12510#12523#12481#12458#12506#31278#30446#36939#29992#32773#65288#19968#20154#19968#34892#12391#65289
    end
    object Label4: TLabel
      Left = 24
      Top = 84
      Width = 66
      Height = 12
      Caption = #12467#12540#12523#12469#12452#12531
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 249
      Top = 84
      Width = 114
      Height = 12
      Hint = #36939#29992#32773#12398#12467#12540#12523#12469#12452#12531#65288#12471#12531#12464#12523#12458#12506#12391#19978#35352#12392#30064#12394#12427#22580#21512#65289
      Caption = #36939#29992#32773#12398#12467#12540#12523#12469#12452#12531
    end
    object Label6: TLabel
      Left = 24
      Top = 112
      Width = 95
      Height = 12
      Caption = #23616#31278#20418#25968'(FD'#24517#38920')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 24
      Top = 136
      Width = 120
      Height = 12
      Caption = #36899#32097#20808#20303#25152#12288#65288'5'#34892#12414#12391#65289
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 24
      Top = 208
      Width = 48
      Height = 12
      Caption = #38651#35441#30058#21495
    end
    object Label9: TLabel
      Left = 24
      Top = 235
      Width = 152
      Height = 12
      Caption = #23616#20813#35377#32773#12398#27663#21517'('#31038#22243#12398#21517#31216')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 24
      Top = 533
      Width = 79
      Height = 12
      Caption = #30331#37682#12463#12521#12502#30058#21495
    end
    object Label17: TLabel
      Left = 24
      Top = 395
      Width = 448
      Height = 12
      Caption = #12510#12523#12481#12458#12506#12289#12466#12473#12488#12458#12506#12398#22580#21512#12398#36939#29992#32773#12398#12467#12540#12523#12469#12452#12531#65288#27663#21517#65289#12362#12424#12403#28961#32218#24467#20107#32773#12398#36039#26684' '
    end
    object labelLicenseDate: TLabel
      Left = 248
      Top = 442
      Width = 119
      Height = 12
      Caption = #23616#20813#35377#24180#26376#26085'(PN'#24517#38920')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object labelAge: TLabel
      Left = 248
      Top = 466
      Width = 151
      Height = 12
      Caption = #24180#40802'(XS,CS,SOSV,SOJR'#24517#38920')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 24
      Top = 323
      Width = 83
      Height = 12
      Caption = #36939#29992#22320'(FD'#24517#38920')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 24
      Top = 289
      Width = 207
      Height = 12
      Caption = #12467#12531#12486#12473#12488#20013#20351#29992#12375#12383#26368#22823#31354#20013#32218#38651#21147'(W)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 251
      Top = 323
      Width = 115
      Height = 12
      Caption = #20351#29992#12375#12383#38651#28304'(FD'#24517#38920')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 24
      Top = 353
      Width = 82
      Height = 12
      Caption = #24847#35211#65288'10'#34892#12414#12391#65289
    end
    object Label1: TLabel
      Left = 24
      Top = 36
      Width = 86
      Height = 12
      Caption = #12467#12531#12486#12473#12488#12398#21517#31216
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label10: TLabel
      Left = 24
      Top = 262
      Width = 74
      Height = 12
      Caption = 'E-mail'#12450#12489#12524#12473
    end
    object labelCategoryName: TLabel
      Left = 282
      Top = 61
      Width = 72
      Height = 12
      Caption = #21442#21152#31278#30446#21517#31216
    end
    object labelClubName: TLabel
      Left = 248
      Top = 533
      Width = 79
      Height = 12
      Caption = #30331#37682#12463#12521#12502#21517#31216
    end
    object labelEquipment: TLabel
      Left = 24
      Top = 421
      Width = 398
      Height = 12
      Caption = #20351#29992#12375#12383#35373#20633#65288#12522#12464#21517#31216#65288#33258#20316#12398#22580#21512#12399#32066#27573#31649#21517#31216#12539#20491#25968#65289#12289#31354#20013#32218#65289' '#65288'5'#34892#12414#12391#65289
    end
    object labelLicense: TLabel
      Left = 24
      Top = 494
      Width = 144
      Height = 12
      Caption = #23616#20813#35377#32773#12398#28961#32218#24467#20107#32773#36039#26684
    end
    object memoMultiOpList: TMemo
      Left = 24
      Top = 437
      Width = 213
      Height = 86
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 16
    end
    object mAddress: TMemo
      Left = 24
      Top = 152
      Width = 465
      Height = 47
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      MaxLength = 400
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 6
    end
    object mComments: TMemo
      Left = 24
      Top = 369
      Width = 465
      Height = 47
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 14
    end
    object groupScoreAdjust: TGroupBox
      Left = 503
      Top = 32
      Width = 330
      Height = 454
      Caption = #12473#12467#12450#35519#25972
      TabOrder = 23
      object Label22: TLabel
        Left = 16
        Top = 398
        Width = 48
        Height = 12
        Caption = #23616#31278#20418#25968
      end
      object labelTotalScore: TLabel
        Left = 16
        Top = 424
        Width = 58
        Height = 12
        Caption = 'Total score'
      end
      object Label19: TLabel
        Left = 16
        Top = 370
        Width = 49
        Height = 12
        Caption = 'Sub Total'
      end
      object Label20: TLabel
        Left = 118
        Top = 15
        Width = 29
        Height = 12
        Caption = 'QSOs'
      end
      object Label25: TLabel
        Left = 164
        Top = 15
        Width = 31
        Height = 12
        Caption = 'Multis'
      end
      object Label26: TLabel
        Left = 266
        Top = 15
        Width = 32
        Height = 12
        Caption = 'Points'
      end
      object Label24: TLabel
        Left = 211
        Top = 15
        Width = 31
        Height = 12
        Caption = 'Multi2'
      end
      object checkBand00: TCheckBox
        Left = 16
        Top = 31
        Width = 81
        Height = 17
        Caption = '1.9MHz'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = checkBandClick
      end
      object editQso00: TEdit
        Left = 112
        Top = 29
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 1
      end
      object editMulti00: TEdit
        Left = 159
        Top = 29
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 2
      end
      object editPoints00: TEdit
        Left = 253
        Top = 29
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 3
      end
      object checkBand01: TCheckBox
        Tag = 1
        Left = 16
        Top = 57
        Width = 81
        Height = 17
        Caption = '3.5MHz'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnClick = checkBandClick
      end
      object editQso01: TEdit
        Tag = 1
        Left = 112
        Top = 55
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 5
      end
      object editMulti01: TEdit
        Tag = 1
        Left = 159
        Top = 55
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 6
      end
      object editPoints01: TEdit
        Tag = 1
        Left = 253
        Top = 55
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 7
      end
      object checkBand02: TCheckBox
        Tag = 2
        Left = 16
        Top = 83
        Width = 81
        Height = 17
        Caption = '7MHz'
        Checked = True
        State = cbChecked
        TabOrder = 8
        OnClick = checkBandClick
      end
      object editQso02: TEdit
        Tag = 2
        Left = 112
        Top = 81
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 9
      end
      object editMulti02: TEdit
        Tag = 2
        Left = 159
        Top = 81
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 10
      end
      object editPoints02: TEdit
        Tag = 2
        Left = 253
        Top = 81
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 11
      end
      object checkBand04: TCheckBox
        Tag = 4
        Left = 16
        Top = 109
        Width = 81
        Height = 17
        Caption = '14MHz'
        Checked = True
        State = cbChecked
        TabOrder = 12
        OnClick = checkBandClick
      end
      object editQso04: TEdit
        Tag = 4
        Left = 112
        Top = 107
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 13
      end
      object editMulti04: TEdit
        Tag = 4
        Left = 159
        Top = 107
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 14
      end
      object editPoints04: TEdit
        Tag = 4
        Left = 253
        Top = 107
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 15
      end
      object checkBand06: TCheckBox
        Tag = 6
        Left = 16
        Top = 135
        Width = 81
        Height = 17
        Caption = '21MHz'
        Checked = True
        State = cbChecked
        TabOrder = 16
        OnClick = checkBandClick
      end
      object editQso06: TEdit
        Tag = 6
        Left = 112
        Top = 133
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 17
      end
      object editMulti06: TEdit
        Tag = 6
        Left = 159
        Top = 133
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 18
      end
      object editPoints06: TEdit
        Tag = 6
        Left = 253
        Top = 133
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 19
      end
      object checkBand08: TCheckBox
        Tag = 8
        Left = 16
        Top = 161
        Width = 81
        Height = 17
        Caption = '28MHz'
        Checked = True
        State = cbChecked
        TabOrder = 20
        OnClick = checkBandClick
      end
      object editQso08: TEdit
        Tag = 8
        Left = 112
        Top = 159
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 21
      end
      object editMulti08: TEdit
        Tag = 8
        Left = 159
        Top = 159
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 22
      end
      object editPoints08: TEdit
        Tag = 8
        Left = 253
        Top = 159
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 23
      end
      object checkBand09: TCheckBox
        Tag = 9
        Left = 16
        Top = 187
        Width = 81
        Height = 17
        Caption = '50MHz'
        Checked = True
        State = cbChecked
        TabOrder = 24
        OnClick = checkBandClick
      end
      object editQso09: TEdit
        Tag = 9
        Left = 112
        Top = 185
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 25
      end
      object editMulti09: TEdit
        Tag = 9
        Left = 159
        Top = 185
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 26
      end
      object editPoints09: TEdit
        Tag = 9
        Left = 253
        Top = 185
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 27
      end
      object checkBand10: TCheckBox
        Tag = 10
        Left = 16
        Top = 213
        Width = 81
        Height = 17
        Caption = '144MHz'
        Checked = True
        State = cbChecked
        TabOrder = 28
        OnClick = checkBandClick
      end
      object editQso10: TEdit
        Tag = 10
        Left = 112
        Top = 211
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 29
      end
      object editMulti10: TEdit
        Tag = 10
        Left = 159
        Top = 211
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 30
      end
      object editPoints10: TEdit
        Tag = 10
        Left = 253
        Top = 211
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 31
      end
      object checkBand11: TCheckBox
        Tag = 11
        Left = 16
        Top = 239
        Width = 81
        Height = 17
        Caption = '430MHz'
        Checked = True
        State = cbChecked
        TabOrder = 32
        OnClick = checkBandClick
      end
      object editQso11: TEdit
        Tag = 11
        Left = 112
        Top = 237
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 33
      end
      object editMulti11: TEdit
        Tag = 11
        Left = 159
        Top = 237
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 34
      end
      object editPoints11: TEdit
        Tag = 11
        Left = 253
        Top = 237
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 35
      end
      object checkBand12: TCheckBox
        Tag = 12
        Left = 16
        Top = 265
        Width = 81
        Height = 17
        Caption = '1200MHz'
        Checked = True
        State = cbChecked
        TabOrder = 36
        OnClick = checkBandClick
      end
      object editQso12: TEdit
        Tag = 12
        Left = 112
        Top = 263
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 37
      end
      object editMulti12: TEdit
        Tag = 12
        Left = 159
        Top = 263
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 38
      end
      object editPoints12: TEdit
        Tag = 12
        Left = 253
        Top = 263
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 39
      end
      object checkBand13: TCheckBox
        Tag = 13
        Left = 16
        Top = 291
        Width = 81
        Height = 17
        Caption = '2400MHz'
        Checked = True
        State = cbChecked
        TabOrder = 40
        OnClick = checkBandClick
      end
      object editQso13: TEdit
        Tag = 13
        Left = 112
        Top = 289
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 41
      end
      object editMulti13: TEdit
        Tag = 13
        Left = 159
        Top = 289
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 42
      end
      object editPoints13: TEdit
        Tag = 13
        Left = 253
        Top = 289
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 43
      end
      object checkBand14: TCheckBox
        Tag = 14
        Left = 16
        Top = 317
        Width = 81
        Height = 17
        Caption = '5600MHz'
        Checked = True
        State = cbChecked
        TabOrder = 44
        OnClick = checkBandClick
      end
      object editQso14: TEdit
        Tag = 14
        Left = 112
        Top = 315
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 45
      end
      object editMulti14: TEdit
        Tag = 14
        Left = 159
        Top = 315
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 46
      end
      object editPoints14: TEdit
        Tag = 14
        Left = 253
        Top = 315
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 47
      end
      object checkBand15: TCheckBox
        Tag = 15
        Left = 16
        Top = 343
        Width = 81
        Height = 17
        Caption = '10G && Up'
        Checked = True
        State = cbChecked
        TabOrder = 48
        OnClick = checkBandClick
      end
      object editQso15: TEdit
        Tag = 15
        Left = 112
        Top = 341
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 49
      end
      object editMulti15: TEdit
        Tag = 15
        Left = 159
        Top = 341
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 50
      end
      object editPoints15: TEdit
        Tag = 15
        Left = 253
        Top = 341
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 51
      end
      object editFDCOEFF: TEdit
        Left = 253
        Top = 395
        Width = 59
        Height = 20
        ReadOnly = True
        TabOrder = 55
      end
      object editTotalScore: TEdit
        Left = 253
        Top = 421
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 56
      end
      object editQsoTotal: TEdit
        Tag = 15
        Left = 112
        Top = 367
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 52
      end
      object editMulti1Total: TEdit
        Tag = 15
        Left = 159
        Top = 367
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 53
      end
      object editPointsTotal: TEdit
        Tag = 15
        Left = 253
        Top = 367
        Width = 59
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 54
      end
      object editMulti2_00: TEdit
        Left = 206
        Top = 29
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 57
      end
      object editMulti2_01: TEdit
        Tag = 1
        Left = 206
        Top = 55
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 58
      end
      object editMulti2_02: TEdit
        Tag = 2
        Left = 206
        Top = 81
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 59
      end
      object editMulti2_04: TEdit
        Tag = 4
        Left = 206
        Top = 107
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 60
      end
      object editMulti2_06: TEdit
        Tag = 6
        Left = 206
        Top = 133
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 61
      end
      object editMulti2_08: TEdit
        Tag = 8
        Left = 206
        Top = 159
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 62
      end
      object editMulti2_09: TEdit
        Tag = 9
        Left = 206
        Top = 185
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 63
      end
      object editMulti2_10: TEdit
        Tag = 10
        Left = 206
        Top = 211
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 64
      end
      object editMulti2_11: TEdit
        Tag = 11
        Left = 206
        Top = 237
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 65
      end
      object editMulti2_12: TEdit
        Tag = 12
        Left = 206
        Top = 263
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 66
      end
      object editMulti2_13: TEdit
        Tag = 13
        Left = 206
        Top = 289
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 67
      end
      object editMulti2_14: TEdit
        Tag = 14
        Left = 206
        Top = 315
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 68
      end
      object editMulti2_15: TEdit
        Tag = 15
        Left = 206
        Top = 341
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 69
      end
      object editMulti2Total: TEdit
        Tag = 15
        Left = 206
        Top = 367
        Width = 41
        Height = 20
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 70
      end
    end
    object edSignature: TEdit
      Left = 712
      Top = 632
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 22
    end
    object edTEL: TEdit
      Left = 116
      Top = 204
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object GroupBox1: TGroupBox
      Left = 24
      Top = 554
      Width = 762
      Height = 72
      Caption = #23459#35475#25991
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 20
      object mOath: TMemo
        Left = 72
        Top = 14
        Width = 681
        Height = 49
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
        Font.Style = []
        Lines.Strings = (
          #31169#12399#12289'JARL'#21046#23450#12398#12467#12531#12486#12473#12488#35215#32004#12362#12424#12403#38651#27874#27861#20196#12395#12375#12383#12364#12356#36939#29992#12375#12383#32080#26524#12289#12371#12371#12395#25552#20986#12377#12427#12469#12510#12522#12540#12471#12540#12488#12362#12424#12403#12525#12464#12471#12540
          #12488#12394#12393#12364#20107#23455#12392#30456#36949#12394#12356#12418#12398#12391#12354#12427#12371#12392#12434#12289#31169#12398#21517#35465#12395#12362#12356#12390#35475#12356#12414#12377#12290)
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object radioOrganizerJarl: TRadioButton
        Left = 10
        Top = 17
        Width = 56
        Height = 17
        Caption = 'JARL'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = radioOrganizerJarlClick
      end
      object radioOrganizerOther: TRadioButton
        Left = 10
        Top = 37
        Width = 56
        Height = 17
        Caption = #20027#20652#32773
        TabOrder = 2
        OnClick = radioOrganizerOtherClick
      end
    end
    object comboAge: TComboBox
      Left = 413
      Top = 463
      Width = 61
      Height = 20
      DropDownCount = 10
      TabOrder = 24
      Items.Strings = (
        '70'
        '71'
        '72'
        '73'
        '74'
        '75'
        '76'
        '77'
        '78'
        '79'
        '80'
        '81'
        '82'
        '83'
        '84'
        '85'
        '86'
        '87'
        '88'
        '89'
        '90'
        '91'
        '92'
        '93'
        '94'
        '95'
        '96'
        '97'
        '98'
        '99'
        '100')
    end
    object datetimeLicenseDate: TDateTimePicker
      Left = 373
      Top = 437
      Width = 101
      Height = 20
      Date = 36526.000000000000000000
      Time = 0.963688356481725400
      TabOrder = 25
    end
    object edCallsign: TEdit
      Left = 116
      Top = 80
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edCategoryCode: TEdit
      Left = 116
      Top = 56
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnExit = edCategoryCodeExit
    end
    object edClubID: TEdit
      Left = 109
      Top = 529
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 18
    end
    object edContestName: TEdit
      Left = 116
      Top = 32
      Width = 374
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edDate: TEdit
      Left = 451
      Top = 632
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 21
    end
    object edEMail: TEdit
      Left = 116
      Top = 258
      Width = 253
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object edFDCoefficient: TEdit
      Left = 164
      Top = 108
      Width = 45
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnChange = edFDCoefficientChange
    end
    object edOpCallsign: TEdit
      Left = 369
      Top = 80
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object edOPName: TEdit
      Left = 180
      Top = 231
      Width = 309
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object edPower: TEdit
      Left = 244
      Top = 285
      Width = 125
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object edPowerSupply: TEdit
      Left = 373
      Top = 319
      Width = 116
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
    object edQTH: TEdit
      Left = 116
      Top = 319
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 12
    end
    object edCategoryName: TEdit
      Left = 369
      Top = 56
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edClubName: TEdit
      Left = 340
      Top = 529
      Width = 373
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 19
    end
    object memoEquipment: TMemo
      Left = 24
      Top = 437
      Width = 465
      Height = 47
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      MaxLength = 800
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 15
    end
    object rPowerType: TRadioGroup
      Left = 377
      Top = 278
      Width = 105
      Height = 34
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        #23450#26684
        #23455#28204)
      TabOrder = 11
    end
    object edLicense: TEdit
      Left = 180
      Top = 490
      Width = 189
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 17
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'em'
    Filter = 'JARL E-log files (*.em)|*.em|'#20840#12390#12398#12501#12449#12452#12523'|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save E-Log file'
    Left = 105
    Top = 636
  end
end
