object formOptions2: TformOptions2
  Left = 532
  Top = 236
  BorderStyle = bsDialog
  Caption = #36939#29992#35373#23450
  ClientHeight = 471
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 444
    Height = 434
    ActivePage = tabsheetPreferences
    Align = alClient
    TabOrder = 0
    object tabsheetPreferences: TTabSheet
      Caption = #21508#31278#35373#23450
      object Label40: TLabel
        Left = 208
        Top = 212
        Width = 54
        Height = 13
        Caption = #33258#21205#20445#23384
      end
      object Label41: TLabel
        Left = 316
        Top = 212
        Width = 28
        Height = 13
        Caption = 'QSO'#27598
      end
      object GroupBox3: TGroupBox
        Left = 6
        Top = 4
        Width = 256
        Height = 202
        Caption = #36939#29992#21487#33021#12394#12496#12531#12489#12392#38651#21147
        TabOrder = 0
        object act19: TCheckBox
          Left = 11
          Top = 20
          Width = 60
          Height = 17
          Caption = '1.9 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object act35: TCheckBox
          Left = 11
          Top = 41
          Width = 60
          Height = 17
          Caption = '3.5 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object act7: TCheckBox
          Left = 11
          Top = 62
          Width = 60
          Height = 17
          Caption = '7 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object act14: TCheckBox
          Left = 11
          Top = 104
          Width = 60
          Height = 17
          Caption = '14 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 8
        end
        object act21: TCheckBox
          Left = 11
          Top = 146
          Width = 60
          Height = 17
          Caption = '21 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 12
        end
        object act28: TCheckBox
          Left = 138
          Top = 20
          Width = 67
          Height = 17
          Caption = '28 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 16
        end
        object act50: TCheckBox
          Left = 138
          Top = 41
          Width = 67
          Height = 17
          Caption = '50 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 18
        end
        object act144: TCheckBox
          Left = 138
          Top = 62
          Width = 67
          Height = 17
          Caption = '144 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 20
        end
        object act430: TCheckBox
          Left = 138
          Top = 83
          Width = 67
          Height = 17
          Caption = '430 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 22
        end
        object act1200: TCheckBox
          Left = 138
          Top = 104
          Width = 67
          Height = 17
          Caption = '1200 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 24
        end
        object act2400: TCheckBox
          Left = 138
          Top = 125
          Width = 67
          Height = 17
          Caption = '2400 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 26
        end
        object act5600: TCheckBox
          Left = 138
          Top = 146
          Width = 67
          Height = 17
          Caption = '5600 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 28
        end
        object act10g: TCheckBox
          Left = 138
          Top = 167
          Width = 67
          Height = 17
          Caption = '10 G && up'
          Checked = True
          State = cbChecked
          TabOrder = 30
        end
        object act24: TCheckBox
          Left = 11
          Top = 167
          Width = 60
          Height = 17
          Caption = '24 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 14
        end
        object act18: TCheckBox
          Left = 11
          Top = 125
          Width = 60
          Height = 17
          Caption = '18 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 10
        end
        object act10: TCheckBox
          Left = 11
          Top = 83
          Width = 60
          Height = 17
          Caption = '10 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
        object comboPower19: TComboBox
          Left = 73
          Top = 18
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 1
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower35: TComboBox
          Left = 73
          Top = 39
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 3
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower7: TComboBox
          Left = 73
          Top = 60
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 5
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower10: TComboBox
          Left = 73
          Top = 81
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 7
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower14: TComboBox
          Left = 73
          Top = 102
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 9
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower18: TComboBox
          Left = 73
          Top = 123
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 11
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower21: TComboBox
          Left = 73
          Top = 144
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 13
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower24: TComboBox
          Left = 73
          Top = 165
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 15
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower28: TComboBox
          Left = 208
          Top = 18
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 17
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower50: TComboBox
          Left = 208
          Top = 39
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 19
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower144: TComboBox
          Left = 208
          Top = 60
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 21
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower430: TComboBox
          Left = 208
          Top = 81
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 23
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower1200: TComboBox
          Left = 208
          Top = 102
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 25
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower2400: TComboBox
          Left = 208
          Top = 123
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 27
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower5600: TComboBox
          Left = 208
          Top = 144
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 29
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object comboPower10g: TComboBox
          Left = 208
          Top = 165
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 31
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
      end
      object AllowDupeCheckBox: TCheckBox
        Left = 276
        Top = 108
        Width = 113
        Height = 17
        Caption = #12487#12517#12540#12503#12434#35377#21487
        TabOrder = 3
        Visible = False
      end
      object SaveEvery: TSpinEdit
        Left = 271
        Top = 209
        Width = 38
        Height = 22
        AutoSize = False
        MaxValue = 99
        MinValue = 1
        TabOrder = 8
        Value = 3
      end
      object cbDispExchange: TCheckBox
        Left = 17
        Top = 257
        Width = 240
        Height = 17
        Caption = #20182#12398#12496#12531#12489#12391#20132#25563#12375#12383#12490#12531#12496#12540#12434#33258#21205#20837#21147
        TabOrder = 10
      end
      object cbJMode: TCheckBox
        Left = 276
        Top = 87
        Width = 97
        Height = 17
        Caption = 'J'#12514#12540#12489
        TabOrder = 2
      end
      object cbSaveWhenNoCW: TCheckBox
        Left = 17
        Top = 211
        Width = 161
        Height = 17
        Caption = #20445#23384#12399'CW'#38750#36865#20449#26178
        TabOrder = 7
      end
      object cbAutoEnterSuper: TCheckBox
        Left = 17
        Top = 237
        Width = 260
        Height = 17
        Caption = #12473#12540#12497#12540#12481#12455#12483#12463#12424#12426#12490#12531#12496#12540#33258#21205#20837#21147
        TabOrder = 9
      end
      object groupQsyAssist: TGroupBox
        Left = 222
        Top = 304
        Width = 204
        Height = 89
        Caption = 'QSY'#12450#12471#12473#12488
        TabOrder = 13
        object Label86: TLabel
          Left = 148
          Top = 40
          Width = 16
          Height = 13
          Caption = #20998
        end
        object Label87: TLabel
          Left = 142
          Top = 64
          Width = 47
          Height = 13
          Caption = #22238'/'#26178#38291
        end
        object radioQsyNone: TRadioButton
          Left = 11
          Top = 16
          Width = 65
          Height = 17
          Caption = #12394#12375
          TabOrder = 0
          OnClick = radioQsyAssistClick
        end
        object radioQsyCountDown: TRadioButton
          Tag = 1
          Left = 11
          Top = 39
          Width = 78
          Height = 17
          Caption = #26178#38291#21046#38480
          TabOrder = 1
          OnClick = radioQsyAssistClick
        end
        object radioQsyCount: TRadioButton
          Tag = 2
          Left = 11
          Top = 62
          Width = 78
          Height = 17
          Caption = 'QSY'#22238#25968
          TabOrder = 2
          OnClick = radioQsyAssistClick
        end
        object editQsyCountDownMinute: TSpinEdit
          Left = 104
          Top = 37
          Width = 38
          Height = 22
          AutoSize = False
          MaxValue = 99
          MinValue = 1
          TabOrder = 3
          Value = 10
        end
        object editQsyCountPerHour: TSpinEdit
          Left = 104
          Top = 60
          Width = 38
          Height = 22
          AutoSize = False
          MaxValue = 99
          MinValue = 1
          TabOrder = 4
          Value = 10
        end
      end
      object GroupBox13: TGroupBox
        Left = 17
        Top = 303
        Width = 101
        Height = 89
        Caption = 'QSL'#21021#26399#20516
        TabOrder = 12
        object radioQslNone: TRadioButton
          Left = 15
          Top = 16
          Width = 65
          Height = 17
          Caption = #12394#12375
          TabOrder = 0
        end
        object radioPseQsl: TRadioButton
          Tag = 1
          Left = 15
          Top = 39
          Width = 65
          Height = 17
          Caption = 'PSE QSL'
          TabOrder = 1
        end
        object radioNoQsl: TRadioButton
          Tag = 2
          Left = 15
          Top = 62
          Width = 65
          Height = 17
          Caption = 'NO QSL'
          TabOrder = 2
        end
      end
      object checkDispLongDateTime: TCheckBox
        Left = 17
        Top = 277
        Width = 193
        Height = 17
        Caption = #38263#12356#26085#20184#12391#34920#31034#12377#12427
        TabOrder = 11
      end
      object checkOutputOutofPeriod: TCheckBox
        Left = 276
        Top = 150
        Width = 160
        Height = 17
        Caption = #26399#38291#22806#12398#20132#20449#12418#12525#12464#20986#21147
        TabOrder = 5
      end
      object checkUseContestPeriod: TCheckBox
        Left = 276
        Top = 129
        Width = 160
        Height = 17
        Caption = #12467#12531#12486#12473#12488#26399#38291#12434#20351#12358
        TabOrder = 4
      end
      object GroupBox6: TGroupBox
        Left = 268
        Top = 3
        Width = 153
        Height = 74
        Caption = #33258#23616#12398#20301#32622
        TabOrder = 1
        object Label39: TLabel
          Left = 8
          Top = 21
          Width = 38
          Height = 13
          Caption = #32239#24230
        end
        object Label42: TLabel
          Left = 8
          Top = 48
          Width = 47
          Height = 13
          Caption = #32076#24230
        end
        object editMyLatitude: TEdit
          Left = 64
          Top = 18
          Width = 81
          Height = 21
          TabOrder = 0
        end
        object editMyLongitude: TEdit
          Left = 64
          Top = 45
          Width = 81
          Height = 21
          TabOrder = 1
        end
      end
      object checkShowStartupWindow: TCheckBox
        Left = 276
        Top = 182
        Width = 160
        Height = 17
        Caption = #38283#22987#12454#12452#12531#12489#12454#12434#20351#29992#12377#12427
        TabOrder = 6
      end
    end
    object tabsheetCategories: TTabSheet
      Caption = #12459#12486#12468#12522#12540
      object Label14: TLabel
        Left = 299
        Top = 128
        Width = 71
        Height = 13
        Caption = #37117#36947#24220#30476'($V)'
      end
      object Label18: TLabel
        Left = 299
        Top = 152
        Width = 37
        Height = 13
        Caption = #24066#37089'($Q)'
      end
      object Label19: TLabel
        Left = 299
        Top = 248
        Width = 41
        Height = 13
        Caption = 'Sent($X)'
      end
      object Label34: TLabel
        Left = 299
        Top = 176
        Width = 62
        Height = 13
        Caption = 'CQ Zone($Z)'
      end
      object Label35: TLabel
        Left = 299
        Top = 200
        Width = 61
        Height = 13
        Caption = 'ITU Zone($I)'
      end
      object Label31: TLabel
        Left = 299
        Top = 223
        Width = 38
        Height = 13
        Caption = #24180#40802'($A)'
      end
      object GroupBox1: TGroupBox
        Left = 6
        Top = 3
        Width = 150
        Height = 129
        Caption = #12459#12486#12468#12522#12540
        TabOrder = 0
        object Label91: TLabel
          Left = 62
          Top = 100
          Width = 21
          Height = 13
          Caption = 'TX#'
        end
        object radioSingleOp: TRadioButton
          Left = 11
          Top = 16
          Width = 130
          Height = 17
          Caption = 'Single-Op'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = radioCategoryClick
        end
        object comboTxNo: TComboBox
          Left = 91
          Top = 97
          Width = 41
          Height = 21
          Style = csDropDownList
          TabOrder = 4
        end
        object radioMultiOpMultiTx: TRadioButton
          Tag = 1
          Left = 11
          Top = 34
          Width = 130
          Height = 17
          Caption = 'Multi-Op/Multi-TX'
          TabOrder = 1
          OnClick = radioCategoryClick
        end
        object radioMultiOpSingleTx: TRadioButton
          Tag = 2
          Left = 11
          Top = 52
          Width = 130
          Height = 17
          Caption = 'Multi-Op/Single-TX'
          TabOrder = 2
          OnClick = radioCategoryClick
        end
        object radioMultiOpTwoTx: TRadioButton
          Tag = 3
          Left = 11
          Top = 70
          Width = 130
          Height = 17
          Caption = 'Multi-Op/Two-TX'
          TabOrder = 3
          OnClick = radioCategoryClick
        end
      end
      object ModeGroup: TRadioGroup
        Left = 296
        Top = 3
        Width = 129
        Height = 114
        Caption = #12514#12540#12489
        ItemIndex = 0
        Items.Strings = (
          'Phone/CW'
          'CW'
          'Phone'
          'Other'
          'ALL')
        TabOrder = 1
        TabStop = True
        Visible = False
      end
      object ProvEdit: TEdit
        Left = 400
        Top = 124
        Width = 25
        Height = 20
        AutoSize = False
        CharCase = ecUpperCase
        TabOrder = 2
      end
      object CItyEdit: TEdit
        Left = 376
        Top = 148
        Width = 49
        Height = 20
        AutoSize = False
        CharCase = ecUpperCase
        TabOrder = 3
      end
      object SentEdit: TEdit
        Left = 368
        Top = 244
        Width = 57
        Height = 20
        AutoSize = False
        CharCase = ecUpperCase
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 7
      end
      object CQZoneEdit: TEdit
        Left = 392
        Top = 172
        Width = 33
        Height = 20
        AutoSize = False
        CharCase = ecUpperCase
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 4
        Text = '25'
      end
      object IARUZoneEdit: TEdit
        Left = 376
        Top = 196
        Width = 49
        Height = 20
        AutoSize = False
        CharCase = ecUpperCase
        MaxLength = 6
        NumbersOnly = True
        TabOrder = 5
        Text = '45'
      end
      object GroupBox24: TGroupBox
        Left = 6
        Top = 139
        Width = 203
        Height = 264
        Caption = #12458#12506#12524#12540#12479#12540
        TabOrder = 9
        object OpListBox: TListBox
          Left = 11
          Top = 19
          Width = 182
          Height = 162
          TabStop = False
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #65325#65331' '#12468#12471#12483#12463
          Font.Style = []
          ItemHeight = 12
          ParentFont = False
          TabOrder = 0
          OnDblClick = buttonOpEditClick
        end
        object buttonOpAdd: TButton
          Left = 11
          Top = 187
          Width = 57
          Height = 25
          Caption = #36861#21152
          TabOrder = 1
          OnClick = buttonOpAddClick
        end
        object buttonOpDelete: TButton
          Left = 136
          Top = 187
          Width = 57
          Height = 25
          Caption = #21066#38500
          TabOrder = 3
          OnClick = buttonOpDeleteClick
        end
        object checkSelectLastOperator: TCheckBox
          Left = 11
          Top = 218
          Width = 190
          Height = 17
          Caption = #36215#21205#26178#12289#26368#24460#12398'OP'#12434#36984#25246
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
        end
        object checkApplyPowerCodeOnBandChange: TCheckBox
          Left = 11
          Top = 239
          Width = 190
          Height = 17
          Hint = 'Apply per-operator power code on band change.'
          Caption = #12496#12531#12489#22793#26356#26178#12289#38651#21147#31526#21495#12434#36969#29992
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
        end
        object buttonOpEdit: TButton
          Left = 73
          Top = 187
          Width = 57
          Height = 25
          Caption = #20462#27491
          TabOrder = 2
          OnClick = buttonOpEditClick
        end
      end
      object groupPower: TGroupBox
        Left = 296
        Top = 276
        Width = 129
        Height = 127
        Caption = #36865#20449#38651#21147'($N)'
        TabOrder = 8
        object Label111: TLabel
          Left = 16
          Top = 23
          Width = 34
          Height = 13
          AutoSize = False
          Caption = 'H'
        end
        object Label112: TLabel
          Left = 16
          Top = 48
          Width = 34
          Height = 13
          AutoSize = False
          Caption = 'M'
        end
        object Label113: TLabel
          Left = 16
          Top = 73
          Width = 34
          Height = 13
          AutoSize = False
          Caption = 'L'
        end
        object Label114: TLabel
          Left = 16
          Top = 98
          Width = 34
          Height = 13
          AutoSize = False
          Caption = 'P'
        end
        object editPowerH: TEdit
          Left = 72
          Top = 20
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 4
          TabOrder = 0
          Text = '1KW'
        end
        object editPowerM: TEdit
          Left = 72
          Top = 45
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 4
          TabOrder = 1
          Text = '100'
        end
        object editPowerL: TEdit
          Left = 72
          Top = 70
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 4
          TabOrder = 2
          Text = '10'
        end
        object editPowerP: TEdit
          Left = 72
          Top = 95
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 4
          TabOrder = 3
          Text = '5'
        end
      end
      object AgeEdit: TEdit
        Left = 392
        Top = 220
        Width = 33
        Height = 20
        AutoSize = False
        CharCase = ecUpperCase
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 6
        Text = '50'
      end
    end
    object tabsheetCW: TTabSheet
      Caption = 'CW/RTTY'
      object Label11: TLabel
        Left = 285
        Top = 2
        Width = 31
        Height = 13
        Caption = #36895#24230
      end
      object SpeedLabel: TLabel
        Left = 384
        Top = 19
        Width = 48
        Height = 13
        AutoSize = False
        Caption = '25 wpm'
      end
      object Label13: TLabel
        Left = 285
        Top = 42
        Width = 34
        Height = 13
        Caption = #12454#12455#12452#12488
      end
      object WeightLabel: TLabel
        Left = 384
        Top = 59
        Width = 48
        Height = 13
        AutoSize = False
        Caption = '50 %'
      end
      object Label15: TLabel
        Left = 277
        Top = 233
        Width = 68
        Height = 13
        AutoSize = False
        Caption = 'CQ'#26368#22823#25968
      end
      object Label16: TLabel
        Left = 255
        Top = 124
        Width = 90
        Height = 13
        AutoSize = False
        Caption = #12488#12540#12531#12500#12483#12481'(Hz)'
      end
      object Label17: TLabel
        Left = 228
        Top = 206
        Width = 117
        Height = 13
        AutoSize = False
        Caption = 'CQ'#32368#12426#36820#12375#38291#38548'('#31186')'
      end
      object Label12: TLabel
        Left = 228
        Top = 178
        Width = 117
        Height = 13
        AutoSize = False
        Caption = '019'#12398#30465#30053#24418
      end
      object Label85: TLabel
        Left = 255
        Top = 150
        Width = 90
        Height = 13
        AutoSize = False
        Caption = #38899#37327'(1-100)'
      end
      object GroupBox2: TGroupBox
        Left = 6
        Top = 4
        Width = 211
        Height = 256
        Caption = #12513#12483#12475#12540#12472
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 35
          Width = 13
          Height = 13
          Caption = '#1'
        end
        object Label2: TLabel
          Left = 8
          Top = 53
          Width = 13
          Height = 13
          Caption = '#2'
        end
        object Label3: TLabel
          Left = 8
          Top = 71
          Width = 13
          Height = 13
          Caption = '#3'
        end
        object Label4: TLabel
          Left = 8
          Top = 89
          Width = 13
          Height = 13
          Caption = '#4'
        end
        object Label5: TLabel
          Left = 8
          Top = 107
          Width = 13
          Height = 13
          Caption = '#5'
        end
        object Label6: TLabel
          Left = 8
          Top = 125
          Width = 13
          Height = 13
          Caption = '#6'
        end
        object Label7: TLabel
          Left = 8
          Top = 143
          Width = 13
          Height = 13
          Caption = '#7'
        end
        object Label8: TLabel
          Left = 8
          Top = 161
          Width = 13
          Height = 13
          Caption = '#8'
        end
        object Label70: TLabel
          Left = 8
          Top = 179
          Width = 13
          Height = 13
          Caption = '#9'
        end
        object Label71: TLabel
          Left = 8
          Top = 197
          Width = 19
          Height = 13
          Caption = '#10'
        end
        object Label75: TLabel
          Left = 8
          Top = 215
          Width = 19
          Height = 13
          Caption = '#11'
        end
        object Label76: TLabel
          Left = 8
          Top = 233
          Width = 19
          Height = 13
          Caption = '#12'
        end
        object editMessage2: TEdit
          Tag = 2
          Left = 32
          Top = 50
          Width = 170
          Height = 17
          AutoSize = False
          TabOrder = 1
          OnChange = editMessage1Change
        end
        object editMessage3: TEdit
          Tag = 3
          Left = 32
          Top = 68
          Width = 170
          Height = 17
          AutoSize = False
          TabOrder = 2
          OnChange = editMessage1Change
        end
        object editMessage4: TEdit
          Tag = 4
          Left = 32
          Top = 86
          Width = 170
          Height = 17
          AutoSize = False
          TabOrder = 3
          OnChange = editMessage1Change
        end
        object editMessage5: TEdit
          Tag = 5
          Left = 32
          Top = 104
          Width = 170
          Height = 17
          AutoSize = False
          TabOrder = 4
          OnChange = editMessage1Change
        end
        object editMessage6: TEdit
          Tag = 6
          Left = 32
          Top = 122
          Width = 170
          Height = 17
          AutoSize = False
          TabOrder = 5
          OnChange = editMessage1Change
        end
        object editMessage7: TEdit
          Tag = 7
          Left = 32
          Top = 140
          Width = 170
          Height = 17
          AutoSize = False
          TabOrder = 6
          OnChange = editMessage1Change
        end
        object editMessage8: TEdit
          Tag = 8
          Left = 32
          Top = 158
          Width = 170
          Height = 17
          AutoSize = False
          TabOrder = 7
          OnChange = editMessage1Change
        end
        object editMessage1: TEdit
          Tag = 1
          Left = 32
          Top = 32
          Width = 170
          Height = 17
          AutoSize = False
          MaxLength = 255
          TabOrder = 0
          OnChange = editMessage1Change
        end
        object editMessage9: TEdit
          Tag = 9
          Left = 32
          Top = 176
          Width = 170
          Height = 17
          AutoSize = False
          TabOrder = 8
          OnChange = editMessage1Change
        end
        object editMessage10: TEdit
          Tag = 10
          Left = 32
          Top = 194
          Width = 170
          Height = 17
          AutoSize = False
          TabOrder = 9
          OnChange = editMessage1Change
        end
        object editMessage11: TEdit
          Tag = 11
          Left = 32
          Top = 212
          Width = 170
          Height = 17
          AutoSize = False
          TabOrder = 10
          OnChange = editMessage1Change
        end
        object editMessage12: TEdit
          Tag = 12
          Left = 32
          Top = 230
          Width = 170
          Height = 17
          AutoSize = False
          TabOrder = 11
          OnChange = editMessage1Change
        end
      end
      object SpeedBar: TTrackBar
        Left = 218
        Top = 16
        Width = 166
        Height = 17
        Max = 50
        Min = 5
        PageSize = 1
        Frequency = 10
        Position = 5
        TabOrder = 2
        OnChange = SpeedBarChange
      end
      object WeightBar: TTrackBar
        Left = 218
        Top = 56
        Width = 166
        Height = 17
        Max = 100
        Frequency = 10
        TabOrder = 3
        OnChange = WeightBarChange
      end
      object CQmaxSpinEdit: TSpinEdit
        Left = 351
        Top = 230
        Width = 46
        Height = 22
        MaxValue = 999
        MinValue = 0
        TabOrder = 10
        Value = 15
      end
      object ToneSpinEdit: TSpinEdit
        Left = 351
        Top = 121
        Width = 46
        Height = 22
        Increment = 10
        MaxValue = 2500
        MinValue = 100
        TabOrder = 6
        Value = 100
      end
      object CQRepEdit: TEdit
        Left = 351
        Top = 203
        Width = 41
        Height = 21
        TabOrder = 9
        Text = '2.0'
        OnKeyPress = CQRepEditKeyPress
      end
      object FIFOCheck: TCheckBox
        Left = 228
        Top = 80
        Width = 204
        Height = 17
        Caption = #12513#12483#12475#12540#12472#12434#12461#12517#12540#12452#12531#12464#12377#12427
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object AbbrevEdit: TEdit
        Left = 351
        Top = 175
        Width = 41
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 8
        Text = 'OAN'
      end
      object rbBankA: TRadioButton
        Tag = 1
        Left = 40
        Top = 18
        Width = 57
        Height = 17
        Caption = 'CW A'
        Checked = True
        TabOrder = 18
        TabStop = True
        OnClick = CWBankClick
      end
      object rbBankB: TRadioButton
        Tag = 2
        Left = 88
        Top = 18
        Width = 49
        Height = 17
        Caption = 'CW B'
        TabOrder = 16
        TabStop = True
        OnClick = CWBankClick
      end
      object rbRTTY: TRadioButton
        Tag = 3
        Left = 140
        Top = 18
        Width = 49
        Height = 17
        Caption = 'RTTY'
        TabOrder = 17
        TabStop = True
        OnClick = CWBankClick
      end
      object cbCQSP: TCheckBox
        Left = 228
        Top = 280
        Width = 204
        Height = 17
        Hint = 
          'This option will switch the CW message sent when TAB or ; key is' +
          ' pressed to that in the current message bank. '
        Caption = 'CQ/SP'#12514#12540#12489#12395#24540#12376#12390'CW'#12496#12531#12463#20999#26367
        TabOrder = 12
        WordWrap = True
      end
      object checkSendNrAuto: TCheckBox
        Left = 228
        Top = 303
        Width = 204
        Height = 17
        Caption = 'NR?'#12434#33258#21205#36865#20449
        TabOrder = 13
      end
      object GroupBox14: TGroupBox
        Left = 6
        Top = 264
        Width = 211
        Height = 61
        Caption = #36861#21152#12398'CQ'#12513#12483#12475#12540#12472
        TabOrder = 1
        object Label9: TLabel
          Left = 8
          Top = 19
          Width = 21
          Height = 13
          Caption = 'CQ2'
        end
        object Label10: TLabel
          Left = 8
          Top = 38
          Width = 21
          Height = 13
          Caption = 'CQ3'
        end
        object editCQMessage2: TEdit
          Tag = 13
          Left = 32
          Top = 17
          Width = 170
          Height = 17
          AutoSize = False
          TabOrder = 0
        end
        object editCQMessage3: TEdit
          Tag = 14
          Left = 32
          Top = 35
          Width = 170
          Height = 17
          AutoSize = False
          TabOrder = 1
        end
      end
      object SideToneCheck: TCheckBox
        Left = 228
        Top = 103
        Width = 204
        Height = 17
        Caption = #12469#12452#12489#12488#12540#12531#12434#20351#29992#12377#12427
        TabOrder = 5
      end
      object checkUseCQRamdomRepeat: TCheckBox
        Left = 228
        Top = 258
        Width = 204
        Height = 17
        Caption = 'CQ'#12521#12531#12480#12512#20877#29983#12434#20351#29992#12377#12427
        TabOrder = 11
        WordWrap = True
      end
      object VolumeSpinEdit: TSpinEdit
        Left = 351
        Top = 147
        Width = 46
        Height = 22
        MaxValue = 100
        MinValue = 1
        TabOrder = 7
        Value = 100
      end
      object checkNotSendLeadingZeros: TCheckBox
        Left = 228
        Top = 326
        Width = 204
        Height = 17
        Caption = #12471#12522#12450#12523#12490#12531#12496#12540#12398#21069'0'#12434#36865#20449#12375#12394#12356
        TabOrder = 14
      end
      object checkPaddleReverse: TCheckBox
        Left = 228
        Top = 349
        Width = 204
        Height = 17
        Caption = #12497#12489#12523#24038#21491#21453#36578
        TabOrder = 15
      end
    end
    object tabsheetVoice: TTabSheet
      Caption = #12508#12452#12473#12513#12514#12522
      object GroupBox4: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 261
        Caption = #12513#12483#12475#12540#12472
        TabOrder = 0
        object Label20: TLabel
          Left = 8
          Top = 34
          Width = 13
          Height = 13
          Caption = '#1'
        end
        object Label21: TLabel
          Left = 8
          Top = 53
          Width = 13
          Height = 13
          Caption = '#2'
        end
        object Label22: TLabel
          Left = 8
          Top = 71
          Width = 13
          Height = 13
          Caption = '#3'
        end
        object Label23: TLabel
          Left = 8
          Top = 89
          Width = 13
          Height = 13
          Caption = '#4'
        end
        object Label24: TLabel
          Left = 8
          Top = 107
          Width = 13
          Height = 13
          Caption = '#5'
        end
        object Label25: TLabel
          Left = 8
          Top = 125
          Width = 13
          Height = 13
          Caption = '#6'
        end
        object Label26: TLabel
          Left = 8
          Top = 143
          Width = 13
          Height = 13
          Caption = '#7'
        end
        object Label27: TLabel
          Left = 8
          Top = 161
          Width = 13
          Height = 13
          Caption = '#8'
        end
        object memo: TLabel
          Left = 48
          Top = 16
          Width = 28
          Height = 13
          Caption = #12513#12514
        end
        object Label72: TLabel
          Left = 8
          Top = 179
          Width = 13
          Height = 13
          Caption = '#9'
        end
        object Label73: TLabel
          Left = 8
          Top = 197
          Width = 19
          Height = 13
          Caption = '#10'
        end
        object Label77: TLabel
          Left = 8
          Top = 215
          Width = 19
          Height = 13
          Caption = '#11'
        end
        object Label78: TLabel
          Left = 8
          Top = 233
          Width = 19
          Height = 13
          Caption = '#12'
        end
        object vEdit2: TEdit
          Tag = 2
          Left = 32
          Top = 50
          Width = 245
          Height = 17
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 2
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit3: TEdit
          Tag = 3
          Left = 32
          Top = 68
          Width = 245
          Height = 17
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 4
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit4: TEdit
          Tag = 4
          Left = 32
          Top = 86
          Width = 245
          Height = 17
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 6
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit5: TEdit
          Tag = 5
          Left = 32
          Top = 104
          Width = 245
          Height = 17
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 8
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit6: TEdit
          Tag = 6
          Left = 32
          Top = 122
          Width = 245
          Height = 17
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 10
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit7: TEdit
          Tag = 7
          Left = 32
          Top = 140
          Width = 245
          Height = 17
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 12
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit8: TEdit
          Tag = 8
          Left = 32
          Top = 158
          Width = 245
          Height = 17
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 14
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit1: TEdit
          Tag = 1
          Left = 32
          Top = 32
          Width = 245
          Height = 17
          AutoSize = False
          MaxLength = 255
          PopupMenu = popupVoiceMenu
          TabOrder = 0
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vButton1: TButton
          Tag = 1
          Left = 287
          Top = 32
          Width = 125
          Height = 19
          Caption = 'vButton1'
          PopupMenu = popupVoiceMenu
          TabOrder = 1
          OnClick = vButtonClick
          OnContextPopup = vButtonContextPopup
          OnEnter = vButtonEnter
          OnExit = vButtonExit
        end
        object vButton2: TButton
          Tag = 2
          Left = 287
          Top = 50
          Width = 125
          Height = 19
          Caption = 'Button4'
          PopupMenu = popupVoiceMenu
          TabOrder = 3
          OnClick = vButtonClick
          OnContextPopup = vButtonContextPopup
          OnEnter = vButtonEnter
          OnExit = vButtonExit
        end
        object vButton3: TButton
          Tag = 3
          Left = 287
          Top = 68
          Width = 125
          Height = 19
          Caption = 'Button4'
          PopupMenu = popupVoiceMenu
          TabOrder = 5
          OnClick = vButtonClick
          OnContextPopup = vButtonContextPopup
          OnEnter = vButtonEnter
          OnExit = vButtonExit
        end
        object vButton4: TButton
          Tag = 4
          Left = 287
          Top = 86
          Width = 125
          Height = 19
          Caption = 'Button4'
          PopupMenu = popupVoiceMenu
          TabOrder = 7
          OnClick = vButtonClick
          OnContextPopup = vButtonContextPopup
          OnEnter = vButtonEnter
          OnExit = vButtonExit
        end
        object vButton5: TButton
          Tag = 5
          Left = 287
          Top = 104
          Width = 125
          Height = 19
          Caption = 'Button4'
          PopupMenu = popupVoiceMenu
          TabOrder = 9
          OnClick = vButtonClick
          OnContextPopup = vButtonContextPopup
          OnEnter = vButtonEnter
          OnExit = vButtonExit
        end
        object vButton6: TButton
          Tag = 6
          Left = 287
          Top = 122
          Width = 125
          Height = 19
          Caption = 'Button4'
          PopupMenu = popupVoiceMenu
          TabOrder = 11
          OnClick = vButtonClick
          OnContextPopup = vButtonContextPopup
          OnEnter = vButtonEnter
          OnExit = vButtonExit
        end
        object vButton7: TButton
          Tag = 7
          Left = 287
          Top = 140
          Width = 125
          Height = 19
          Caption = 'Button4'
          PopupMenu = popupVoiceMenu
          TabOrder = 13
          OnClick = vButtonClick
          OnContextPopup = vButtonContextPopup
          OnEnter = vButtonEnter
          OnExit = vButtonExit
        end
        object vButton8: TButton
          Tag = 8
          Left = 287
          Top = 158
          Width = 125
          Height = 19
          Caption = 'Button4'
          PopupMenu = popupVoiceMenu
          TabOrder = 15
          OnClick = vButtonClick
          OnContextPopup = vButtonContextPopup
          OnEnter = vButtonEnter
          OnExit = vButtonExit
        end
        object vEdit9: TEdit
          Tag = 7
          Left = 32
          Top = 176
          Width = 245
          Height = 17
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 16
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit10: TEdit
          Tag = 8
          Left = 32
          Top = 194
          Width = 245
          Height = 17
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 18
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vButton9: TButton
          Tag = 9
          Left = 287
          Top = 176
          Width = 125
          Height = 19
          Caption = 'Button4'
          PopupMenu = popupVoiceMenu
          TabOrder = 17
          OnClick = vButtonClick
          OnContextPopup = vButtonContextPopup
          OnEnter = vButtonEnter
          OnExit = vButtonExit
        end
        object vButton10: TButton
          Tag = 10
          Left = 287
          Top = 194
          Width = 125
          Height = 19
          Caption = 'Button4'
          PopupMenu = popupVoiceMenu
          TabOrder = 19
          OnClick = vButtonClick
          OnContextPopup = vButtonContextPopup
          OnEnter = vButtonEnter
          OnExit = vButtonExit
        end
        object vEdit11: TEdit
          Tag = 8
          Left = 32
          Top = 212
          Width = 245
          Height = 17
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 20
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vButton11: TButton
          Tag = 11
          Left = 287
          Top = 212
          Width = 125
          Height = 19
          Caption = 'Button4'
          PopupMenu = popupVoiceMenu
          TabOrder = 21
          OnClick = vButtonClick
          OnContextPopup = vButtonContextPopup
          OnEnter = vButtonEnter
          OnExit = vButtonExit
        end
        object vEdit12: TEdit
          Tag = 8
          Left = 32
          Top = 230
          Width = 245
          Height = 17
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 22
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vButton12: TButton
          Tag = 12
          Left = 287
          Top = 230
          Width = 125
          Height = 19
          Caption = 'Button4'
          PopupMenu = popupVoiceMenu
          TabOrder = 23
          OnClick = vButtonClick
          OnContextPopup = vButtonContextPopup
          OnEnter = vButtonEnter
          OnExit = vButtonExit
        end
      end
      object GroupBox16: TGroupBox
        Left = 6
        Top = 352
        Width = 423
        Height = 50
        Caption = #20877#29983#12486#12473#12488
        TabOrder = 2
        object buttonPlayVoice: TSpeedButton
          Left = 310
          Top = 16
          Width = 50
          Height = 26
          Caption = #20877#29983
          OnClick = buttonPlayVoiceClick
        end
        object buttonStopVoice: TSpeedButton
          Left = 362
          Top = 16
          Width = 50
          Height = 26
          Caption = #20572#27490
          OnClick = buttonStopVoiceClick
        end
        object Label38: TLabel
          Left = 8
          Top = 22
          Width = 34
          Height = 13
          Caption = #20986#21147#20808
        end
        object comboVoiceDevice: TComboBox
          Left = 48
          Top = 19
          Width = 256
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
      end
      object GroupBox19: TGroupBox
        Left = 6
        Top = 270
        Width = 423
        Height = 77
        Caption = #36861#21152#12398'CQ'#12513#12483#12475#12540#12472
        TabOrder = 1
        object Label36: TLabel
          Left = 8
          Top = 34
          Width = 21
          Height = 13
          Caption = 'CQ2'
        end
        object Label37: TLabel
          Left = 8
          Top = 53
          Width = 21
          Height = 13
          Caption = 'CQ3'
        end
        object Label82: TLabel
          Left = 48
          Top = 16
          Width = 28
          Height = 13
          Caption = #12513#12514
        end
        object vEdit14: TEdit
          Tag = 3
          Left = 32
          Top = 50
          Width = 245
          Height = 17
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 2
          OnEnter = vAdditionalEditEnter
          OnExit = vAdditionalEditExit
        end
        object vEdit13: TEdit
          Tag = 2
          Left = 32
          Top = 32
          Width = 245
          Height = 17
          AutoSize = False
          MaxLength = 255
          PopupMenu = popupVoiceMenu
          TabOrder = 0
          OnEnter = vAdditionalEditEnter
          OnExit = vAdditionalEditExit
        end
        object vButton13: TButton
          Tag = 2
          Left = 287
          Top = 32
          Width = 125
          Height = 19
          Caption = 'vButton1'
          PopupMenu = popupVoiceMenu
          TabOrder = 1
          OnClick = vAdditionalButtonClick
          OnContextPopup = vAdditionalButtonContextPopup
          OnEnter = vAdditionalButtonEnter
          OnExit = vAdditionalButtonExit
        end
        object vButton14: TButton
          Tag = 3
          Left = 287
          Top = 50
          Width = 125
          Height = 19
          Caption = 'Button4'
          PopupMenu = popupVoiceMenu
          TabOrder = 3
          OnClick = vAdditionalButtonClick
          OnContextPopup = vAdditionalButtonContextPopup
          OnEnter = vAdditionalButtonEnter
          OnExit = vAdditionalButtonExit
        end
      end
    end
    object tabsheetMisc: TTabSheet
      Caption = #12381#12398#20182
      object Label47: TLabel
        Left = 168
        Top = 14
        Width = 175
        Height = 13
        AutoSize = False
        Caption = #12473#12540#12497#12540#12481#12455#12483#12463#12398#26908#32034#28145#12373
      end
      object Label48: TLabel
        Left = 168
        Top = 39
        Width = 175
        Height = 13
        AutoSize = False
        Caption = #12496#12531#12489#12473#12467#12540#12503#12398#12487#12540#12479#20445#25345#26178#38291
      end
      object Label49: TLabel
        Left = 401
        Top = 39
        Width = 16
        Height = 13
        Caption = #20998
      end
      object Label52: TLabel
        Left = 168
        Top = 66
        Width = 175
        Height = 13
        AutoSize = False
        Caption = #12473#12509#12483#12488#12487#12540#12479#12398#20445#25345#26178#38291
      end
      object Label53: TLabel
        Left = 401
        Top = 63
        Width = 16
        Height = 13
        Caption = #20998
      end
      object rgSearchAfter: TRadioGroup
        Left = 6
        Top = 4
        Width = 105
        Height = 73
        Caption = #26908#32034#38283#22987
        ItemIndex = 0
        Items.Strings = (
          '1'#25991#23383#20837#21147#24460
          '2'#25991#23383#20837#21147#24460
          '3'#25991#23383#20837#21147#24460)
        TabOrder = 0
        TabStop = True
      end
      object spMaxSuperHit: TSpinEdit
        Left = 345
        Top = 12
        Width = 49
        Height = 22
        MaxValue = 99999
        MinValue = 0
        TabOrder = 1
        Value = 1
      end
      object spBSExpire: TSpinEdit
        Left = 345
        Top = 36
        Width = 49
        Height = 22
        AutoSize = False
        MaxValue = 99999
        MinValue = 1
        TabOrder = 2
        Value = 60
      end
      object cbUpdateThread: TCheckBox
        Left = 168
        Top = 112
        Width = 175
        Height = 17
        Caption = #21029#12473#12524#12483#12489#12391#12473#12467#12450#26356#26032
        TabOrder = 5
      end
      object spSpotExpire: TSpinEdit
        Left = 345
        Top = 60
        Width = 49
        Height = 22
        AutoSize = False
        MaxValue = 99999
        MinValue = 1
        TabOrder = 3
        Value = 60
      end
      object cbDisplayDatePartialCheck: TCheckBox
        Left = 168
        Top = 89
        Width = 200
        Height = 17
        Caption = #12497#12540#12471#12515#12523#12481#12455#12483#12463#20869#12395#26085#20184#12434#34920#31034
        TabOrder = 4
      end
      object GroupBox8: TGroupBox
        Left = 6
        Top = 155
        Width = 423
        Height = 52
        Caption = #12473#12540#12497#12540#12481#12455#12483#12463
        TabOrder = 6
        object radioSuperCheck0: TRadioButton
          Left = 12
          Top = 20
          Width = 41
          Height = 17
          Caption = 'SPC'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = OnNeedSuperCheckLoad
        end
        object radioSuperCheck1: TRadioButton
          Left = 64
          Top = 20
          Width = 83
          Height = 17
          Caption = 'ZLO/ZLOX'
          TabOrder = 1
          OnClick = OnNeedSuperCheckLoad
        end
        object radioSuperCheck2: TRadioButton
          Left = 153
          Top = 20
          Width = 96
          Height = 17
          Caption = #20001#26041
          TabOrder = 2
          OnClick = OnNeedSuperCheckLoad
        end
        object checkAcceptDuplicates: TCheckBox
          Left = 296
          Top = 20
          Width = 117
          Height = 17
          Caption = #37325#35079#12434#21463#12369#20837#12428#12427
          TabOrder = 3
          OnClick = OnNeedSuperCheckLoad
        end
      end
      object GroupBox5: TGroupBox
        Left = 6
        Top = 213
        Width = 423
        Height = 50
        Caption = 'N+1'
        TabOrder = 7
        object checkHighlightFullmatch: TCheckBox
          Left = 12
          Top = 22
          Width = 127
          Height = 17
          Caption = #23436#20840#19968#33268#12391#12495#12452#12521#12452#12488
          TabOrder = 0
        end
        object editFullmatchColor: TEdit
          Left = 145
          Top = 20
          Width = 112
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 1
          Text = 'CALLSIGN'
        end
        object buttonFullmatchSelectColor: TButton
          Left = 318
          Top = 21
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonFullmatchSelectColorClick
        end
        object buttonFullmatchInitColor: TButton
          Left = 368
          Top = 21
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 3
          OnClick = buttonFullmatchInitColorClick
        end
      end
      object GroupBox22: TGroupBox
        Left = 6
        Top = 269
        Width = 423
        Height = 50
        Caption = #12497#12540#12471#12515#12523#12481#12455#12483#12463
        TabOrder = 8
        object Label88: TLabel
          Left = 15
          Top = 24
          Width = 61
          Height = 13
          Caption = #29694#22312#12496#12531#12489
        end
        object editPartialCheckColor: TEdit
          Left = 145
          Top = 19
          Width = 112
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'CALLSIGN'
        end
        object buttonPartialCheckForeColor: TButton
          Left = 268
          Top = 20
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 1
          OnClick = buttonPartialCheckForeColorClick
        end
        object buttonPartialCheckInitColor: TButton
          Left = 368
          Top = 20
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 3
          OnClick = buttonPartialCheckInitColorClick
        end
        object buttonPartialCheckBackColor: TButton
          Tag = 1
          Left = 318
          Top = 20
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonPartialCheckBackColorClick
        end
      end
      object GroupBox23: TGroupBox
        Left = 6
        Top = 325
        Width = 423
        Height = 72
        Caption = #12518#12540#12470#12540#35036#21161
        TabOrder = 9
        object Label89: TLabel
          Left = 15
          Top = 23
          Width = 68
          Height = 13
          Caption = #12501#12457#12540#12459#12473#26178
        end
        object editFocusedColor: TEdit
          Left = 145
          Top = 20
          Width = 112
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'CALLSIGN'
        end
        object buttonFocusedBackColor: TButton
          Tag = 1
          Left = 318
          Top = 21
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonFocusedBackColorClick
        end
        object buttonFocusedInitColor: TButton
          Left = 368
          Top = 21
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 3
          OnClick = buttonFocusedInitColorClick
        end
        object checkFocusedBold: TCheckBox
          Left = 145
          Top = 46
          Width = 45
          Height = 22
          Caption = #22826#23383
          TabOrder = 4
          OnClick = checkFocusedBoldClick
        end
        object buttonFocusedForeColor: TButton
          Left = 268
          Top = 21
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 1
          OnClick = buttonFocusedForeColorClick
        end
      end
    end
    object tabsheetQuickFunctions: TTabSheet
      Caption = #12463#12452#12483#12463#27231#33021
      ImageIndex = 8
      object groupQuickMemo: TGroupBox
        Left = 6
        Top = 284
        Width = 423
        Height = 109
        Caption = #12463#12452#12483#12463'Memo'
        TabOrder = 1
        object Label63: TLabel
          Left = 16
          Top = 24
          Width = 25
          Height = 13
          Caption = '#101'
        end
        object Label64: TLabel
          Left = 16
          Top = 51
          Width = 25
          Height = 13
          Caption = '#102'
        end
        object Label65: TLabel
          Left = 16
          Top = 78
          Width = 25
          Height = 13
          Caption = '#106'
        end
        object Label66: TLabel
          Left = 210
          Top = 24
          Width = 25
          Height = 13
          Caption = '#107'
        end
        object Label67: TLabel
          Left = 210
          Top = 51
          Width = 25
          Height = 13
          Caption = '#108'
        end
        object editQuickMemo1: TEdit
          Left = 63
          Top = 21
          Width = 113
          Height = 21
          TabOrder = 0
        end
        object editQuickMemo2: TEdit
          Left = 63
          Top = 48
          Width = 113
          Height = 21
          TabOrder = 1
        end
        object editQuickMemo3: TEdit
          Left = 63
          Top = 75
          Width = 113
          Height = 21
          TabOrder = 2
        end
        object editQuickMemo4: TEdit
          Left = 257
          Top = 21
          Width = 113
          Height = 21
          TabOrder = 3
        end
        object editQuickMemo5: TEdit
          Left = 257
          Top = 48
          Width = 113
          Height = 21
          TabOrder = 4
        end
      end
      object groupQuickQSY: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 274
        Caption = #12463#12452#12483#12463'QSY'
        TabOrder = 0
        object checkUseKhzQsyCommand: TCheckBox
          Left = 200
          Top = 247
          Width = 220
          Height = 17
          Caption = 'kHz QSY '#12467#12510#12531#12489#12434#20351#29992#12377#12427' (F/KC)'
          TabOrder = 1
        end
        object listviewFreqMemory: TListView
          Left = 6
          Top = 24
          Width = 410
          Height = 213
          Columns = <
            item
              Caption = 'No'
              Width = 30
            end
            item
              Caption = 'Band/Freq'
              Width = 120
            end
            item
              Caption = 'Mode'
            end
            item
              Caption = 'RIG'
            end
            item
              Caption = 'Command'
              Width = 80
            end
            item
              Caption = 'FixEdge'
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnDblClick = listviewFreqMemoryDblClick
          OnSelectItem = listviewFreqMemorySelectItem
        end
        object buttonFreqMemAdd: TButton
          Left = 6
          Top = 243
          Width = 59
          Height = 25
          Caption = #36861#21152
          TabOrder = 2
          OnClick = buttonFreqMemAddClick
        end
        object buttonFreqMemEdit: TButton
          Left = 71
          Top = 243
          Width = 59
          Height = 25
          Caption = #32232#38598
          TabOrder = 3
          OnClick = buttonFreqMemEditClick
        end
        object buttonFreqMemDelete: TButton
          Left = 136
          Top = 243
          Width = 59
          Height = 25
          Caption = #21066#38500
          TabOrder = 4
          OnClick = buttonFreqMemDeleteClick
        end
      end
    end
    object tabsheetBandScope1: TTabSheet
      Caption = #12496#12531#12489#12473#12467#12540#12503
      ImageIndex = 9
      object groupBandscopeBands: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 128
        Caption = #20351#29992#12377#12427#12496#12531#12489
        TabOrder = 0
        object checkBs01: TCheckBox
          Left = 12
          Top = 18
          Width = 60
          Height = 17
          Caption = '1.9 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object checkBs02: TCheckBox
          Left = 12
          Top = 39
          Width = 60
          Height = 17
          Caption = '3.5 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object checkBs03: TCheckBox
          Left = 12
          Top = 60
          Width = 60
          Height = 17
          Caption = '7 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object checkBs05: TCheckBox
          Left = 108
          Top = 18
          Width = 60
          Height = 17
          Caption = '14 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object checkBs07: TCheckBox
          Left = 108
          Top = 60
          Width = 60
          Height = 17
          Caption = '21 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
        object checkBs09: TCheckBox
          Left = 205
          Top = 18
          Width = 67
          Height = 17
          Caption = '28 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 8
        end
        object checkBs10: TCheckBox
          Left = 205
          Top = 39
          Width = 67
          Height = 17
          Caption = '50 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 9
        end
        object checkBs11: TCheckBox
          Left = 205
          Top = 60
          Width = 67
          Height = 17
          Caption = '144 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 10
        end
        object checkBs12: TCheckBox
          Left = 205
          Top = 81
          Width = 67
          Height = 17
          Caption = '430 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 11
        end
        object checkBs13: TCheckBox
          Left = 301
          Top = 18
          Width = 67
          Height = 17
          Caption = '1200 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 12
        end
        object checkBs14: TCheckBox
          Left = 301
          Top = 39
          Width = 67
          Height = 17
          Caption = '2400 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 13
        end
        object checkBs15: TCheckBox
          Left = 301
          Top = 60
          Width = 67
          Height = 17
          Caption = '5600 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 14
        end
        object checkBs16: TCheckBox
          Left = 301
          Top = 81
          Width = 67
          Height = 17
          Caption = '10 G && up'
          Checked = True
          State = cbChecked
          TabOrder = 15
        end
        object checkBs08: TCheckBox
          Left = 108
          Top = 81
          Width = 60
          Height = 17
          Caption = '24 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 7
        end
        object checkBs06: TCheckBox
          Left = 108
          Top = 39
          Width = 60
          Height = 17
          Caption = '18 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
        object checkBs04: TCheckBox
          Left = 12
          Top = 81
          Width = 60
          Height = 17
          Caption = '10 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object checkBsCurrent: TCheckBox
          Left = 205
          Top = 104
          Width = 90
          Height = 17
          Caption = #29694#22312#12496#12531#12489
          Checked = True
          State = cbChecked
          TabOrder = 17
        end
        object checkBsNewMulti: TCheckBox
          Left = 301
          Top = 104
          Width = 112
          Height = 17
          Caption = #12491#12517#12540#12510#12523#12481
          Checked = True
          State = cbChecked
          TabOrder = 18
        end
        object checkBsAllBands: TCheckBox
          Left = 12
          Top = 104
          Width = 141
          Height = 17
          Caption = #20840#12496#12531#12489
          Checked = True
          State = cbChecked
          TabOrder = 16
        end
      end
      object groupBandscopeInfoColors: TGroupBox
        Left = 6
        Top = 145
        Width = 423
        Height = 130
        Caption = #24773#22577#34920#31034#33394
        TabOrder = 1
        object Label57: TLabel
          Left = 12
          Top = 23
          Width = 38
          Height = 13
          Caption = #20132#20449#28168#12415
        end
        object Label58: TLabel
          Left = 12
          Top = 48
          Width = 63
          Height = 13
          Caption = #26410#20132#20449#12510#12523#12481
        end
        object Label59: TLabel
          Left = 12
          Top = 73
          Width = 63
          Height = 13
          Caption = #20132#20449#28168#12415#12510#12523#12481
        end
        object Label60: TLabel
          Left = 12
          Top = 98
          Width = 46
          Height = 13
          Caption = #12381#12398#20182
        end
        object editBSColor1: TEdit
          Left = 108
          Top = 20
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'TEXT'
        end
        object buttonBSFore1: TButton
          Tag = 1
          Left = 221
          Top = 21
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 1
          OnClick = buttonBSForeClick
        end
        object buttonBSReset1: TButton
          Tag = 1
          Left = 368
          Top = 20
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 4
          OnClick = buttonBSResetClick
        end
        object buttonBSBack1: TButton
          Tag = 1
          Left = 270
          Top = 21
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          Visible = False
          OnClick = buttonBSBackClick
        end
        object editBSColor2: TEdit
          Left = 108
          Top = 45
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 5
          Text = 'TEXT'
        end
        object buttonBSFore2: TButton
          Tag = 2
          Left = 221
          Top = 46
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 6
          OnClick = buttonBSForeClick
        end
        object buttonBSReset2: TButton
          Tag = 2
          Left = 368
          Top = 46
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 9
          OnClick = buttonBSResetClick
        end
        object buttonBSBack2: TButton
          Tag = 2
          Left = 270
          Top = 46
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 7
          Visible = False
          OnClick = buttonBSBackClick
        end
        object editBSColor3: TEdit
          Left = 108
          Top = 70
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 10
          Text = 'TEXT'
        end
        object buttonBSFore3: TButton
          Tag = 3
          Left = 221
          Top = 71
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 11
          OnClick = buttonBSForeClick
        end
        object buttonBSReset3: TButton
          Tag = 3
          Left = 368
          Top = 71
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 14
          OnClick = buttonBSResetClick
        end
        object buttonBSBack3: TButton
          Tag = 3
          Left = 270
          Top = 71
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 12
          Visible = False
          OnClick = buttonBSBackClick
        end
        object editBSColor4: TEdit
          Left = 108
          Top = 95
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 15
          Text = 'TEXT'
        end
        object buttonBSFore4: TButton
          Tag = 4
          Left = 221
          Top = 96
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 16
          OnClick = buttonBSForeClick
        end
        object buttonBSReset4: TButton
          Tag = 4
          Left = 368
          Top = 96
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 19
          OnClick = buttonBSResetClick
        end
        object buttonBSBack4: TButton
          Tag = 4
          Left = 270
          Top = 96
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 17
          Visible = False
          OnClick = buttonBSBackClick
        end
        object checkBSBold1: TCheckBox
          Tag = 1
          Left = 321
          Top = 22
          Width = 41
          Height = 17
          Caption = #22826#23383
          TabOrder = 3
          OnClick = checkBSBoldClick
        end
        object checkBSBold2: TCheckBox
          Tag = 2
          Left = 321
          Top = 47
          Width = 41
          Height = 17
          Caption = #22826#23383
          TabOrder = 8
          OnClick = checkBSBoldClick
        end
        object checkBSBold3: TCheckBox
          Tag = 3
          Left = 321
          Top = 72
          Width = 41
          Height = 17
          Caption = #22826#23383
          TabOrder = 13
          OnClick = checkBSBoldClick
        end
        object checkBSBold4: TCheckBox
          Tag = 4
          Left = 321
          Top = 97
          Width = 41
          Height = 17
          Caption = #22826#23383
          TabOrder = 18
          OnClick = checkBSBoldClick
        end
      end
      object groupBandscopeOptions1: TGroupBox
        Left = 6
        Top = 281
        Width = 423
        Height = 112
        Caption = #12496#12531#12489#12473#12467#12540#12503#12458#12503#12471#12519#12531
        TabOrder = 2
        object checkUseEstimatedMode: TCheckBox
          Left = 215
          Top = 17
          Width = 190
          Height = 17
          Caption = #21608#27874#25968#12424#12426#25512#23450#12375#12383#12514#12540#12489#12434#20351#12358
          TabOrder = 5
          OnClick = checkUseEstimatedModeClick
        end
        object checkShowOnlyInBandplan: TCheckBox
          Left = 12
          Top = 17
          Width = 190
          Height = 17
          Caption = #12496#12531#12489#12503#12521#12531#20869#12398#12473#12509#12483#12488#12398#12415#34920#31034
          TabOrder = 0
        end
        object checkShowJAspots: TCheckBox
          Left = 12
          Top = 40
          Width = 93
          Height = 17
          Caption = 'JA'#12434#34920#31034
          TabOrder = 1
        end
        object checkUseLookupServer: TCheckBox
          Left = 12
          Top = 86
          Width = 165
          Height = 17
          Caption = 'Lookup Server'#12434#20351#12358
          TabOrder = 4
        end
        object checkSetFreqAfterModeChange: TCheckBox
          Left = 226
          Top = 63
          Width = 157
          Height = 17
          Caption = #21608#27874#25968#12378#12428#12434#25233#21046
          TabOrder = 7
        end
        object checkAlwaysChangeMode: TCheckBox
          Left = 226
          Top = 40
          Width = 176
          Height = 17
          Caption = 'LSB/USB'#12514#12540#12489#35492#12426#12434#25233#21046
          TabOrder = 6
        end
        object checkSaveCurrentFreq: TCheckBox
          Left = 215
          Top = 86
          Width = 204
          Height = 17
          Caption = 'SPOT'#12395'QSY'#12377#12427#30452#21069#12398#21608#27874#25968#12434#35352#25014
          TabOrder = 8
          OnClick = checkUseEstimatedModeClick
        end
        object checkShowDXspots: TCheckBox
          Left = 112
          Top = 40
          Width = 93
          Height = 17
          Caption = 'DX'#12434#34920#31034
          TabOrder = 2
        end
        object checkUseNumberLookup: TCheckBox
          Left = 12
          Top = 63
          Width = 165
          Height = 17
          Caption = #12510#12523#12481#29031#20250#12434#34892#12358
          TabOrder = 3
          OnClick = checkUseNumberLookupClick
        end
      end
    end
    object tabsheetBandScope2: TTabSheet
      Caption = #12496#12531#12489#12473#12467#12540#12503'2'
      ImageIndex = 11
      object groupBandscopeSpotSource: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 157
        Caption = #12473#12509#12483#12488#12477#12540#12473#21029#12398#33394#35373#23450
        TabOrder = 0
        object Label61: TLabel
          Left = 8
          Top = 23
          Width = 43
          Height = 13
          Caption = 'Self Spot'
        end
        object Label68: TLabel
          Left = 8
          Top = 50
          Width = 32
          Height = 13
          Caption = 'Cluster'
        end
        object Label69: TLabel
          Left = 8
          Top = 77
          Width = 41
          Height = 13
          Caption = 'Z-Server'
        end
        object Label79: TLabel
          Left = 58
          Top = 77
          Width = 14
          Height = 13
          Caption = 'G1'
        end
        object Label80: TLabel
          Left = 58
          Top = 103
          Width = 14
          Height = 13
          Caption = 'G2'
        end
        object Label81: TLabel
          Left = 58
          Top = 129
          Width = 14
          Height = 13
          Caption = 'G3'
        end
        object editBSColor5: TEdit
          Left = 118
          Top = 20
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'TEXT'
        end
        object buttonBSBack5: TButton
          Tag = 5
          Left = 270
          Top = 21
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 1
          OnClick = buttonBSBackClick
        end
        object buttonBSReset5: TButton
          Tag = 5
          Left = 368
          Top = 21
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 2
          OnClick = buttonBSResetClick
        end
        object editBSColor6: TEdit
          Left = 118
          Top = 47
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 3
          Text = 'TEXT'
        end
        object buttonBSBack6: TButton
          Tag = 6
          Left = 270
          Top = 48
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 4
          OnClick = buttonBSBackClick
        end
        object buttonBSReset6: TButton
          Tag = 6
          Left = 368
          Top = 48
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 5
          OnClick = buttonBSResetClick
        end
        object editBSColor7: TEdit
          Tag = 7
          Left = 118
          Top = 74
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 6
          Text = 'TEXT'
        end
        object buttonBSBack7: TButton
          Tag = 7
          Left = 270
          Top = 75
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 7
          OnClick = buttonBSBackClick
        end
        object buttonBSReset7: TButton
          Tag = 7
          Left = 368
          Top = 75
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 8
          OnClick = buttonBSResetClick
        end
        object editBSColor8: TEdit
          Tag = 8
          Left = 118
          Top = 100
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 9
          Text = 'TEXT'
        end
        object buttonBSBack8: TButton
          Tag = 8
          Left = 270
          Top = 101
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 10
          OnClick = buttonBSBackClick
        end
        object buttonBSBack9: TButton
          Tag = 9
          Left = 270
          Top = 127
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 13
          OnClick = buttonBSBackClick
        end
        object editBSColor9: TEdit
          Tag = 9
          Left = 118
          Top = 126
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 12
          Text = 'TEXT'
        end
        object buttonBSReset8: TButton
          Tag = 8
          Left = 368
          Top = 101
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 11
          OnClick = buttonBSResetClick
        end
        object buttonBSReset9: TButton
          Tag = 9
          Left = 368
          Top = 127
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 14
          OnClick = buttonBSResetClick
        end
      end
      object groupSpotFreshness: TGroupBox
        Left = 6
        Top = 281
        Width = 252
        Height = 121
        Caption = #12473#12509#12483#12488#12398#26032#39854#24230
        TabOrder = 2
        object radioFreshness1: TRadioButton
          Left = 16
          Top = 24
          Width = 197
          Height = 17
          Caption = #27531#12426#26178#38291#65297' (1/2,1/4,1/8,1/16 '#20998')'
          TabOrder = 0
        end
        object radioFreshness2: TRadioButton
          Left = 16
          Top = 47
          Width = 169
          Height = 17
          Caption = #27531#12426#26178#38291#65298' (5,10,20,30 '#20998')'
          TabOrder = 1
        end
        object radioFreshness3: TRadioButton
          Left = 16
          Top = 70
          Width = 121
          Height = 17
          Caption = #27531#12426#26178#38291#65299' (5'#27573#38542')'
          TabOrder = 2
        end
        object radioFreshness4: TRadioButton
          Left = 16
          Top = 93
          Width = 169
          Height = 17
          Caption = #32076#36942#26178#38291' (5,10,20,30 '#20998')'
          TabOrder = 3
        end
      end
      object groupBandscopeOtherColors: TGroupBox
        Left = 6
        Top = 167
        Width = 423
        Height = 108
        Caption = #12381#12398#20182#12398#33394#35373#23450
        TabOrder = 1
        object Label28: TLabel
          Left = 8
          Top = 23
          Width = 64
          Height = 13
          Caption = 'Lookup'#22833#25943
        end
        object Label29: TLabel
          Left = 8
          Top = 50
          Width = 61
          Height = 13
          Caption = #29694#22312#12496#12531#12489
        end
        object Label30: TLabel
          Left = 8
          Top = 77
          Width = 82
          Height = 13
          Caption = #20302#20449#38972#12398#12473#12509#12483#12479#12540
        end
        object editBSColor10: TEdit
          Tag = 10
          Left = 118
          Top = 20
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'TEXT'
        end
        object editBSColor11: TEdit
          Tag = 11
          Left = 118
          Top = 47
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 3
          Text = 'TEXT'
        end
        object editBSColor12: TEdit
          Tag = 12
          Left = 118
          Top = 74
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 6
          Text = 'TEXT'
        end
        object buttonBSOtherBack1: TButton
          Tag = 10
          Left = 270
          Top = 21
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 1
          OnClick = buttonBSBackClick
        end
        object buttonBSOtherBack2: TButton
          Tag = 11
          Left = 270
          Top = 48
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 4
          OnClick = buttonBSBackClick
        end
        object buttonBSOtherBack3: TButton
          Tag = 12
          Left = 270
          Top = 75
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 7
          OnClick = buttonBSBackClick
        end
        object buttonBSOtherReset1: TButton
          Tag = 10
          Left = 368
          Top = 21
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 2
          OnClick = buttonBSResetClick
        end
        object buttonBSOtherReset2: TButton
          Tag = 11
          Left = 368
          Top = 48
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 5
          OnClick = buttonBSResetClick
        end
        object buttonBSOtherReset3: TButton
          Tag = 12
          Left = 368
          Top = 75
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 8
          OnClick = buttonBSResetClick
        end
      end
      object groupBandscopeOptions2: TGroupBox
        Left = 264
        Top = 281
        Width = 165
        Height = 121
        Caption = #12458#12503#12471#12519#12531#65298
        TabOrder = 3
        object checkUseResume: TCheckBox
          Left = 12
          Top = 24
          Width = 145
          Height = 17
          Caption = #12524#12472#12517#12540#12512#27231#33021#12434#20351#12358
          TabOrder = 0
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 434
    Width = 444
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      444
      37)
    object buttonOK: TButton
      Left = 149
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = buttonOKClick
    end
    object buttonCancel: TButton
      Left = 229
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
      OnClick = buttonCancelClick
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 
      'sound files|*.wav;*.mp3|wav files|*.wav|mp3 files|*.mp3|all file' +
      's|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 324
    Top = 428
  end
  object ColorDialog1: TColorDialog
    Left = 292
    Top = 428
  end
  object popupVoiceMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 80
    Top = 434
    object menuVoicePlay: TMenuItem
      AutoHotkeys = maManual
      AutoLineReduction = maManual
      Caption = #20877#29983
      OnClick = menuVoicePlayClick
    end
    object menuVoiceStop: TMenuItem
      Caption = #20572#27490
      OnClick = menuVoiceStopClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object menuVoiceClear: TMenuItem
      Caption = #12463#12522#12450
      OnClick = menuVoiceClearClick
    end
  end
end
