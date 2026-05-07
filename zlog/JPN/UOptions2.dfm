object formOptions2: TformOptions2
  Left = 532
  Top = 236
  BorderStyle = bsDialog
  Caption = #36939#29992#35373#23450
  ClientHeight = 571
  ClientWidth = 534
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
    Width = 534
    Height = 534
    ActivePage = tabsheetBandScope2
    Align = alClient
    TabOrder = 0
    object tabsheetMyStation: TTabSheet
      Caption = #12510#12452#12473#12486#12540#12471#12519#12531
      ImageIndex = 8
      object groupMyActiveBands: TGroupBox
        Left = 253
        Top = 3
        Width = 270
        Height = 278
        Caption = #36939#29992#21487#33021#12394#12496#12531#12489#12392#38651#21147
        TabOrder = 2
        object act19: TCheckBox
          Left = 10
          Top = 20
          Width = 70
          Height = 17
          Caption = '1.9 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object act35: TCheckBox
          Left = 10
          Top = 43
          Width = 70
          Height = 17
          Caption = '3.5 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object act7: TCheckBox
          Left = 10
          Top = 66
          Width = 70
          Height = 17
          Caption = '7 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object act14: TCheckBox
          Left = 10
          Top = 112
          Width = 70
          Height = 17
          Caption = '14 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 8
        end
        object act21: TCheckBox
          Left = 10
          Top = 158
          Width = 70
          Height = 17
          Caption = '21 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 12
        end
        object act28: TCheckBox
          Left = 10
          Top = 204
          Width = 70
          Height = 17
          Caption = '28 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 16
        end
        object act50: TCheckBox
          Left = 10
          Top = 227
          Width = 70
          Height = 17
          Caption = '50 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 18
        end
        object act144: TCheckBox
          Left = 10
          Top = 250
          Width = 70
          Height = 17
          Caption = '144 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 20
        end
        object act430: TCheckBox
          Left = 146
          Top = 18
          Width = 70
          Height = 17
          Caption = '430 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 22
        end
        object act1200: TCheckBox
          Left = 146
          Top = 41
          Width = 70
          Height = 17
          Caption = '1200 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 24
        end
        object act2400: TCheckBox
          Left = 146
          Top = 64
          Width = 70
          Height = 17
          Caption = '2400 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 26
        end
        object act5600: TCheckBox
          Left = 146
          Top = 87
          Width = 70
          Height = 17
          Caption = '5600 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 28
        end
        object act101g: TCheckBox
          Left = 146
          Top = 110
          Width = 70
          Height = 17
          Caption = '10.1 GHz'
          Checked = True
          State = cbChecked
          TabOrder = 30
        end
        object act24: TCheckBox
          Left = 10
          Top = 181
          Width = 70
          Height = 17
          Caption = '24 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 14
        end
        object act18: TCheckBox
          Left = 10
          Top = 135
          Width = 70
          Height = 17
          Caption = '18 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 10
        end
        object act10: TCheckBox
          Left = 10
          Top = 89
          Width = 70
          Height = 17
          Caption = '10 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
        object comboPower19: TComboBox
          Left = 86
          Top = 16
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
          Left = 86
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
          Left = 86
          Top = 62
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
          Left = 86
          Top = 85
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
          Left = 86
          Top = 108
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
          Left = 86
          Top = 131
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
          Left = 86
          Top = 154
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
          Left = 86
          Top = 177
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
          Left = 86
          Top = 200
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
          Left = 86
          Top = 223
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
          Left = 86
          Top = 246
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
          Left = 222
          Top = 16
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
          Left = 222
          Top = 39
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
          Left = 222
          Top = 62
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
          Left = 222
          Top = 85
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
        object comboPower101g: TComboBox
          Left = 222
          Top = 108
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
        object act104g: TCheckBox
          Left = 146
          Top = 133
          Width = 70
          Height = 17
          Caption = '10.4 GHz'
          Checked = True
          State = cbChecked
          TabOrder = 32
        end
        object comboPower104g: TComboBox
          Left = 222
          Top = 131
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 33
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object act24g: TCheckBox
          Left = 146
          Top = 156
          Width = 70
          Height = 17
          Caption = '24 GHz'
          TabOrder = 34
        end
        object comboPower24g: TComboBox
          Left = 222
          Top = 154
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 35
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object act47g: TCheckBox
          Left = 146
          Top = 179
          Width = 70
          Height = 17
          Caption = '47 GHz'
          TabOrder = 36
        end
        object comboPower47g: TComboBox
          Left = 222
          Top = 177
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 37
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object act77g: TCheckBox
          Left = 146
          Top = 202
          Width = 70
          Height = 17
          Caption = '77 GHz'
          TabOrder = 38
        end
        object comboPower77g: TComboBox
          Left = 222
          Top = 200
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 39
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object act135g: TCheckBox
          Left = 146
          Top = 225
          Width = 70
          Height = 17
          Caption = '135 GHz'
          TabOrder = 40
        end
        object comboPower135g: TComboBox
          Left = 222
          Top = 223
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 41
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
        object act248g: TCheckBox
          Left = 146
          Top = 248
          Width = 70
          Height = 17
          Caption = '248 GHz'
          TabOrder = 42
        end
        object comboPower248g: TComboBox
          Left = 222
          Top = 246
          Width = 38
          Height = 21
          ItemIndex = 0
          TabOrder = 43
          Text = 'H'
          Items.Strings = (
            'H'
            'M'
            'L'
            'P')
        end
      end
      object groupMyStation: TGroupBox
        Left = 3
        Top = 3
        Width = 236
        Height = 137
        Caption = #33258#23616#24773#22577
        TabOrder = 0
        object Label55: TLabel
          Left = 8
          Top = 23
          Width = 57
          Height = 13
          Caption = #12467#12540#12523#12469#12452#12531'($M)'
        end
        object Label39: TLabel
          Left = 8
          Top = 75
          Width = 38
          Height = 13
          Caption = #32239#24230#65288#24230#65289
        end
        object Label42: TLabel
          Left = 8
          Top = 101
          Width = 47
          Height = 13
          Caption = #32076#24230#65288#24230#65289
        end
        object Label56: TLabel
          Left = 8
          Top = 49
          Width = 51
          Height = 13
          Caption = 'GRID Loc.'
        end
        object editMyCallsign: TEdit
          Left = 105
          Top = 20
          Width = 81
          Height = 21
          AutoSize = False
          CharCase = ecUpperCase
          ImeMode = imClose
          TabOrder = 0
        end
        object editMyLatitude: TEdit
          Left = 88
          Top = 72
          Width = 81
          Height = 21
          TabOrder = 3
        end
        object editMyLongitude: TEdit
          Left = 88
          Top = 98
          Width = 81
          Height = 21
          TabOrder = 4
        end
        object editMyGridLoc: TEdit
          Left = 88
          Top = 46
          Width = 81
          Height = 21
          MaxLength = 6
          TabOrder = 1
        end
        object buttonMyGridCalc: TButton
          Left = 175
          Top = 46
          Width = 53
          Height = 21
          Caption = #35336#31639
          TabOrder = 2
          OnClick = buttonMyGridCalcClick
        end
        object buttonMyPositionCalc: TButton
          Left = 175
          Top = 72
          Width = 53
          Height = 47
          Caption = 'GRID'#12363#12425#35336#31639
          TabOrder = 5
          WordWrap = True
          OnClick = buttonMyPositionCalcClick
        end
      end
      object groupMyQslDefault: TGroupBox
        Left = 253
        Top = 287
        Width = 270
        Height = 50
        Caption = 'QSL'#21021#26399#20516
        TabOrder = 3
        object radioQslNone: TRadioButton
          Left = 10
          Top = 22
          Width = 65
          Height = 17
          Caption = 'None'
          TabOrder = 0
        end
        object radioPseQsl: TRadioButton
          Tag = 1
          Left = 97
          Top = 22
          Width = 65
          Height = 17
          Caption = 'PSE QSL'
          TabOrder = 1
        end
        object radioNoQsl: TRadioButton
          Tag = 2
          Left = 194
          Top = 22
          Width = 65
          Height = 17
          Caption = 'NO QSL'
          TabOrder = 2
        end
      end
      object groupMyParameter: TGroupBox
        Left = 3
        Top = 146
        Width = 236
        Height = 191
        Caption = #12497#12521#12513#12540#12479#12540
        TabOrder = 1
        object Label34: TLabel
          Left = 8
          Top = 23
          Width = 62
          Height = 13
          Caption = 'CQ Zone($Z)'
        end
        object Label35: TLabel
          Left = 8
          Top = 49
          Width = 61
          Height = 13
          Caption = 'ITU Zone($I)'
        end
        object Label31: TLabel
          Left = 8
          Top = 75
          Width = 38
          Height = 13
          Caption = #24180#40802'($A)'
        end
        object Label50: TLabel
          Left = 8
          Top = 101
          Width = 44
          Height = 13
          Caption = 'IOTA($T)'
        end
        object Label54: TLabel
          Left = 9
          Top = 127
          Width = 78
          Height = 13
          Caption = #12495#12531#12489#12523'(CW)($H)'
        end
        object Label62: TLabel
          Left = 9
          Top = 153
          Width = 75
          Height = 13
          Caption = #12495#12531#12489#12523'(PH)($H)'
        end
        object CQZoneEdit: TEdit
          Left = 110
          Top = 20
          Width = 33
          Height = 21
          AutoSize = False
          CharCase = ecUpperCase
          ImeMode = imDisable
          MaxLength = 20
          NumbersOnly = True
          TabOrder = 0
        end
        object IARUZoneEdit: TEdit
          Left = 110
          Top = 46
          Width = 49
          Height = 21
          AutoSize = False
          CharCase = ecUpperCase
          ImeMode = imDisable
          MaxLength = 20
          NumbersOnly = True
          TabOrder = 1
        end
        object AgeEdit: TEdit
          Left = 110
          Top = 72
          Width = 33
          Height = 21
          AutoSize = False
          CharCase = ecUpperCase
          ImeMode = imDisable
          MaxLength = 20
          NumbersOnly = True
          TabOrder = 2
        end
        object IotaEdit: TEdit
          Left = 110
          Top = 98
          Width = 49
          Height = 21
          AutoSize = False
          CharCase = ecUpperCase
          ImeMode = imDisable
          MaxLength = 20
          TabOrder = 3
        end
        object HandleCwEdit: TEdit
          Left = 110
          Top = 124
          Width = 116
          Height = 21
          AutoSize = False
          CharCase = ecUpperCase
          ImeMode = imDisable
          MaxLength = 20
          TabOrder = 4
        end
        object HandlePhEdit: TEdit
          Left = 110
          Top = 150
          Width = 116
          Height = 21
          AutoSize = False
          CharCase = ecUpperCase
          MaxLength = 20
          TabOrder = 5
        end
      end
      object groupOperators: TGroupBox
        Left = 3
        Top = 342
        Width = 420
        Height = 161
        Caption = #12458#12506#12524#12540#12479#12540
        TabOrder = 4
        object OpListBox: TListBox
          Left = 11
          Top = 19
          Width = 158
          Height = 134
          TabStop = False
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
          Left = 175
          Top = 19
          Width = 50
          Height = 25
          Caption = #36861#21152
          TabOrder = 1
          OnClick = buttonOpAddClick
        end
        object buttonOpDelete: TButton
          Left = 175
          Top = 128
          Width = 50
          Height = 25
          Caption = #21066#38500
          TabOrder = 3
          OnClick = buttonOpDeleteClick
        end
        object checkSelectLastOperator: TCheckBox
          Left = 231
          Top = 23
          Width = 186
          Height = 17
          Caption = #36215#21205#26178#12289#26368#24460#12398'OP'#12434#36984#25246
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
        end
        object checkApplyPowerCodeOnBandChange: TCheckBox
          Left = 231
          Top = 46
          Width = 186
          Height = 17
          Hint = #12496#12531#12489#22793#26356#26178#12289#12458#12506#12524#12540#12479#12540#27598#12398#38651#21147#31526#21495#12434#36969#29992#12375#12414#12377
          Caption = #12496#12531#12489#22793#26356#26178#12289#38651#21147#31526#21495#12434#36969#29992
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
        end
        object buttonOpEdit: TButton
          Left = 175
          Top = 50
          Width = 50
          Height = 25
          Caption = #32232#38598
          TabOrder = 2
          OnClick = buttonOpEditClick
        end
      end
      object groupPowerDefs: TGroupBox
        Left = 429
        Top = 342
        Width = 94
        Height = 161
        Caption = #36865#20449#38651#21147'($N)'
        TabOrder = 5
        object Label111: TLabel
          Left = 16
          Top = 23
          Width = 25
          Height = 13
          AutoSize = False
          Caption = 'H'
        end
        object Label112: TLabel
          Left = 16
          Top = 50
          Width = 25
          Height = 13
          AutoSize = False
          Caption = 'M'
        end
        object Label113: TLabel
          Left = 16
          Top = 77
          Width = 25
          Height = 13
          AutoSize = False
          Caption = 'L'
        end
        object Label114: TLabel
          Left = 16
          Top = 104
          Width = 25
          Height = 13
          AutoSize = False
          Caption = 'P'
        end
        object editPowerH: TEdit
          Left = 36
          Top = 20
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 4
          TabOrder = 0
          Text = '1KW'
        end
        object editPowerM: TEdit
          Left = 36
          Top = 47
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 4
          TabOrder = 1
          Text = '100'
        end
        object editPowerL: TEdit
          Left = 36
          Top = 74
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 4
          TabOrder = 2
          Text = '10'
        end
        object editPowerP: TEdit
          Left = 36
          Top = 101
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 4
          TabOrder = 3
          Text = '5'
        end
      end
    end
    object tabsheetCategories: TTabSheet
      Caption = #12467#12531#12486#12473#12488#12398#35373#23450
      object groupCategory: TGroupBox
        Left = 6
        Top = 147
        Width = 243
        Height = 121
        Caption = #12459#12486#12468#12522#12540
        TabOrder = 1
        object Label91: TLabel
          Left = 145
          Top = 94
          Width = 21
          Height = 13
          Caption = 'TX#'
        end
        object radioSingleOp: TRadioButton
          Left = 10
          Top = 24
          Width = 130
          Height = 17
          Caption = 'Single-Op'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = radioCategoryClick
        end
        object comboTxNo: TComboBox
          Left = 174
          Top = 91
          Width = 41
          Height = 21
          Style = csDropDownList
          TabOrder = 4
        end
        object radioMultiOpMultiTx: TRadioButton
          Tag = 1
          Left = 10
          Top = 47
          Width = 130
          Height = 17
          Caption = 'Multi-Op/Multi-TX'
          TabOrder = 1
          OnClick = radioCategoryClick
        end
        object radioMultiOpSingleTx: TRadioButton
          Tag = 2
          Left = 10
          Top = 70
          Width = 130
          Height = 17
          Caption = 'Multi-Op/Single-TX'
          TabOrder = 2
          OnClick = radioCategoryClick
        end
        object radioMultiOpTwoTx: TRadioButton
          Tag = 3
          Left = 10
          Top = 93
          Width = 130
          Height = 17
          Caption = 'Multi-Op/Two-TX'
          TabOrder = 3
          OnClick = radioCategoryClick
        end
      end
      object groupMode: TRadioGroup
        Left = 6
        Top = 274
        Width = 243
        Height = 123
        Caption = #12514#12540#12489
        ItemIndex = 0
        Items.Strings = (
          'PHONE/CW(MIX)'
          'CW'
          'PHONE'
          'RTTY'
          'ALL')
        TabOrder = 2
        TabStop = True
      end
      object groupQsyAssist: TGroupBox
        Left = 6
        Top = 403
        Width = 243
        Height = 89
        Caption = 'QSY'#12450#12471#12473#12488
        TabOrder = 4
        object Label86: TLabel
          Left = 164
          Top = 40
          Width = 16
          Height = 13
          Caption = #20998
        end
        object Label87: TLabel
          Left = 164
          Top = 65
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
          Left = 120
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
          Left = 120
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
      object groupExchange: TGroupBox
        Left = 6
        Top = 35
        Width = 243
        Height = 106
        Caption = #12490#12531#12496#12540#20132#25563
        TabOrder = 0
        object Label19: TLabel
          Left = 10
          Top = 24
          Width = 41
          Height = 13
          Caption = #36865#20449'NR($X)'
        end
        object Label74: TLabel
          Left = 10
          Top = 51
          Width = 41
          Height = 13
          Caption = #37117#36947#24220#30476'($V)'
        end
        object Label83: TLabel
          Left = 10
          Top = 77
          Width = 37
          Height = 13
          Caption = #24066#21306#37089'($Q)'
        end
        object SentEdit: TEdit
          Left = 120
          Top = 21
          Width = 60
          Height = 21
          AutoSize = False
          CharCase = ecUpperCase
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 0
        end
        object editCity: TEdit
          Left = 120
          Top = 74
          Width = 60
          Height = 21
          MaxLength = 20
          TabOrder = 2
        end
        object editProv: TEdit
          Left = 120
          Top = 48
          Width = 60
          Height = 21
          MaxLength = 20
          TabOrder = 1
        end
      end
      object groupOtherRules: TGroupBox
        Left = 259
        Top = 440
        Width = 262
        Height = 51
        Caption = #12381#12398#20182#12398#12523#12540#12523
        TabOrder = 3
        object Label46: TLabel
          Left = 11
          Top = 24
          Width = 58
          Height = 13
          Caption = #23616#31278#20418#25968
        end
        object ScoreCoeffEdit: TEdit
          Left = 121
          Top = 21
          Width = 25
          Height = 21
          AutoSize = False
          MaxLength = 3
          TabOrder = 0
          Text = '1'
        end
      end
      object panelContestName: TPanel
        Left = 6
        Top = 4
        Width = 243
        Height = 25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
      end
      object groupCwMessages: TGroupBox
        Left = 259
        Top = 3
        Width = 262
        Height = 346
        Caption = 'CW'#36865#20449#12513#12483#12475#12540#12472
        TabOrder = 6
        object Label1: TLabel
          Left = 8
          Top = 41
          Width = 13
          Height = 13
          Caption = '#1'
        end
        object Label2: TLabel
          Left = 8
          Top = 66
          Width = 13
          Height = 13
          Caption = '#2'
        end
        object Label3: TLabel
          Left = 8
          Top = 91
          Width = 13
          Height = 13
          Caption = '#3'
        end
        object Label4: TLabel
          Left = 8
          Top = 116
          Width = 13
          Height = 13
          Caption = '#4'
        end
        object Label5: TLabel
          Left = 8
          Top = 141
          Width = 13
          Height = 13
          Caption = '#5'
        end
        object Label6: TLabel
          Left = 8
          Top = 166
          Width = 13
          Height = 13
          Caption = '#6'
        end
        object Label7: TLabel
          Left = 8
          Top = 191
          Width = 13
          Height = 13
          Caption = '#7'
        end
        object Label8: TLabel
          Left = 8
          Top = 216
          Width = 13
          Height = 13
          Caption = '#8'
        end
        object Label70: TLabel
          Left = 8
          Top = 241
          Width = 13
          Height = 13
          Caption = '#9'
        end
        object Label71: TLabel
          Left = 8
          Top = 266
          Width = 19
          Height = 13
          Caption = '#10'
        end
        object Label75: TLabel
          Left = 8
          Top = 291
          Width = 19
          Height = 13
          Caption = '#11'
        end
        object Label76: TLabel
          Left = 8
          Top = 316
          Width = 19
          Height = 13
          Caption = '#12'
        end
        object buttonShowCwMessagesMenu: TSpeedButton
          Left = 200
          Top = 18
          Width = 54
          Height = 17
          Caption = #12513#12491#12517#12540
          OnClick = buttonShowCwMessagesMenuClick
        end
        object editMessage2: TEdit
          Tag = 2
          Left = 32
          Top = 63
          Width = 222
          Height = 21
          AutoSize = False
          TabOrder = 1
          OnChange = editMessage1Change
        end
        object editMessage3: TEdit
          Tag = 3
          Left = 32
          Top = 88
          Width = 222
          Height = 21
          AutoSize = False
          TabOrder = 2
          OnChange = editMessage1Change
        end
        object editMessage4: TEdit
          Tag = 4
          Left = 32
          Top = 113
          Width = 222
          Height = 21
          AutoSize = False
          TabOrder = 3
          OnChange = editMessage1Change
        end
        object editMessage5: TEdit
          Tag = 5
          Left = 32
          Top = 138
          Width = 222
          Height = 21
          AutoSize = False
          TabOrder = 4
          OnChange = editMessage1Change
        end
        object editMessage6: TEdit
          Tag = 6
          Left = 32
          Top = 163
          Width = 222
          Height = 21
          AutoSize = False
          TabOrder = 5
          OnChange = editMessage1Change
        end
        object editMessage7: TEdit
          Tag = 7
          Left = 32
          Top = 188
          Width = 222
          Height = 21
          AutoSize = False
          TabOrder = 6
          OnChange = editMessage1Change
        end
        object editMessage8: TEdit
          Tag = 8
          Left = 32
          Top = 213
          Width = 222
          Height = 21
          AutoSize = False
          TabOrder = 7
          OnChange = editMessage1Change
        end
        object editMessage1: TEdit
          Tag = 1
          Left = 32
          Top = 38
          Width = 222
          Height = 21
          AutoSize = False
          MaxLength = 255
          TabOrder = 0
          OnChange = editMessage1Change
        end
        object editMessage9: TEdit
          Tag = 9
          Left = 32
          Top = 238
          Width = 222
          Height = 21
          AutoSize = False
          TabOrder = 8
          OnChange = editMessage1Change
        end
        object editMessage10: TEdit
          Tag = 10
          Left = 32
          Top = 263
          Width = 222
          Height = 21
          AutoSize = False
          TabOrder = 9
          OnChange = editMessage1Change
        end
        object editMessage11: TEdit
          Tag = 11
          Left = 32
          Top = 288
          Width = 222
          Height = 21
          AutoSize = False
          TabOrder = 10
          OnChange = editMessage1Change
        end
        object editMessage12: TEdit
          Tag = 12
          Left = 32
          Top = 313
          Width = 222
          Height = 21
          AutoSize = False
          TabOrder = 11
          OnChange = editMessage1Change
        end
        object rbBankA: TRadioButton
          Tag = 1
          Left = 8
          Top = 18
          Width = 57
          Height = 17
          Caption = 'CW A'
          Checked = True
          TabOrder = 12
          TabStop = True
          OnClick = CWBankClick
        end
        object rbBankB: TRadioButton
          Tag = 2
          Left = 71
          Top = 18
          Width = 49
          Height = 17
          Caption = 'CW B'
          TabOrder = 13
          TabStop = True
          OnClick = CWBankClick
        end
        object rbRTTY: TRadioButton
          Tag = 3
          Left = 135
          Top = 18
          Width = 49
          Height = 17
          Caption = 'RTTY'
          TabOrder = 14
          TabStop = True
          OnClick = CWBankClick
        end
      end
      object groupCwAddMessages: TGroupBox
        Left = 259
        Top = 355
        Width = 262
        Height = 79
        Caption = 'Additional CQ Messages'
        TabOrder = 7
        object Label9: TLabel
          Left = 8
          Top = 24
          Width = 21
          Height = 13
          Caption = 'CQ2'
        end
        object Label10: TLabel
          Left = 8
          Top = 50
          Width = 21
          Height = 13
          Caption = 'CQ3'
        end
        object editCQMessage2: TEdit
          Tag = 13
          Left = 32
          Top = 21
          Width = 222
          Height = 21
          AutoSize = False
          TabOrder = 0
        end
        object editCQMessage3: TEdit
          Tag = 14
          Left = 32
          Top = 47
          Width = 222
          Height = 21
          AutoSize = False
          TabOrder = 1
        end
      end
    end
    object tabsheetVoice: TTabSheet
      Caption = #12508#12452#12473#12513#12514#12522
      object GroupBox4: TGroupBox
        Left = 3
        Top = 3
        Width = 511
        Height = 310
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
          Top = 57
          Width = 13
          Height = 13
          Caption = '#2'
        end
        object Label22: TLabel
          Left = 8
          Top = 79
          Width = 13
          Height = 13
          Caption = '#3'
        end
        object Label23: TLabel
          Left = 8
          Top = 101
          Width = 13
          Height = 13
          Caption = '#4'
        end
        object Label24: TLabel
          Left = 8
          Top = 123
          Width = 13
          Height = 13
          Caption = '#5'
        end
        object Label25: TLabel
          Left = 8
          Top = 145
          Width = 13
          Height = 13
          Caption = '#6'
        end
        object Label26: TLabel
          Left = 8
          Top = 167
          Width = 13
          Height = 13
          Caption = '#7'
        end
        object Label27: TLabel
          Left = 8
          Top = 189
          Width = 13
          Height = 13
          Caption = '#8'
        end
        object memo: TLabel
          Left = 32
          Top = 15
          Width = 28
          Height = 13
          Caption = #12513#12514
        end
        object Label72: TLabel
          Left = 8
          Top = 211
          Width = 13
          Height = 13
          Caption = '#9'
        end
        object Label73: TLabel
          Left = 8
          Top = 233
          Width = 19
          Height = 13
          Caption = '#10'
        end
        object Label77: TLabel
          Left = 8
          Top = 255
          Width = 19
          Height = 13
          Caption = '#11'
        end
        object Label78: TLabel
          Left = 8
          Top = 277
          Width = 19
          Height = 13
          Caption = '#12'
        end
        object buttonVoiceAfterCmd1: TSpeedButton
          Tag = 1
          Left = 429
          Top = 32
          Width = 75
          Height = 21
          Caption = #21069#24460#20966#29702
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd2: TSpeedButton
          Tag = 2
          Left = 429
          Top = 54
          Width = 75
          Height = 21
          Caption = #21069#24460#20966#29702
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd3: TSpeedButton
          Tag = 3
          Left = 429
          Top = 76
          Width = 75
          Height = 21
          Caption = #21069#24460#20966#29702
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd4: TSpeedButton
          Tag = 4
          Left = 429
          Top = 98
          Width = 75
          Height = 21
          Caption = #21069#24460#20966#29702
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd5: TSpeedButton
          Tag = 5
          Left = 429
          Top = 120
          Width = 75
          Height = 21
          Caption = #21069#24460#20966#29702
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd6: TSpeedButton
          Tag = 6
          Left = 429
          Top = 142
          Width = 75
          Height = 21
          Caption = #21069#24460#20966#29702
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd7: TSpeedButton
          Tag = 7
          Left = 429
          Top = 164
          Width = 75
          Height = 21
          Caption = #21069#24460#20966#29702
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd8: TSpeedButton
          Tag = 8
          Left = 429
          Top = 186
          Width = 75
          Height = 21
          Caption = #21069#24460#20966#29702
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd9: TSpeedButton
          Tag = 9
          Left = 429
          Top = 208
          Width = 75
          Height = 21
          Caption = #21069#24460#20966#29702
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd10: TSpeedButton
          Tag = 10
          Left = 429
          Top = 230
          Width = 75
          Height = 21
          Caption = #21069#24460#20966#29702
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd11: TSpeedButton
          Tag = 11
          Left = 429
          Top = 252
          Width = 75
          Height = 21
          Caption = #21069#24460#20966#29702
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd12: TSpeedButton
          Tag = 12
          Left = 429
          Top = 274
          Width = 75
          Height = 21
          Caption = #21069#24460#20966#29702
          OnClick = buttonVoiceAfterCmdClick
        end
        object vEdit2: TEdit
          Tag = 2
          Left = 32
          Top = 54
          Width = 200
          Height = 21
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 2
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit3: TEdit
          Tag = 3
          Left = 32
          Top = 76
          Width = 200
          Height = 21
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 4
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit4: TEdit
          Tag = 4
          Left = 32
          Top = 98
          Width = 200
          Height = 21
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 6
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit5: TEdit
          Tag = 5
          Left = 32
          Top = 120
          Width = 200
          Height = 21
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 8
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit6: TEdit
          Tag = 6
          Left = 32
          Top = 142
          Width = 200
          Height = 21
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 10
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit7: TEdit
          Tag = 7
          Left = 32
          Top = 164
          Width = 200
          Height = 21
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 12
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit8: TEdit
          Tag = 8
          Left = 32
          Top = 186
          Width = 200
          Height = 21
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
          Width = 200
          Height = 21
          AutoSize = False
          MaxLength = 255
          PopupMenu = popupVoiceMenu
          TabOrder = 0
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vButton1: TButton
          Tag = 1
          Left = 238
          Top = 32
          Width = 185
          Height = 21
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
          Left = 238
          Top = 54
          Width = 185
          Height = 21
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
          Left = 238
          Top = 76
          Width = 185
          Height = 21
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
          Left = 238
          Top = 98
          Width = 185
          Height = 21
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
          Left = 238
          Top = 120
          Width = 185
          Height = 21
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
          Left = 238
          Top = 142
          Width = 185
          Height = 21
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
          Left = 238
          Top = 164
          Width = 185
          Height = 21
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
          Left = 238
          Top = 186
          Width = 185
          Height = 21
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
          Top = 208
          Width = 200
          Height = 21
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 16
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vEdit10: TEdit
          Tag = 8
          Left = 32
          Top = 230
          Width = 200
          Height = 21
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 18
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vButton9: TButton
          Tag = 9
          Left = 238
          Top = 208
          Width = 185
          Height = 21
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
          Left = 238
          Top = 230
          Width = 185
          Height = 21
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
          Top = 252
          Width = 200
          Height = 21
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 20
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vButton11: TButton
          Tag = 11
          Left = 238
          Top = 252
          Width = 185
          Height = 21
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
          Top = 274
          Width = 200
          Height = 21
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 22
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vButton12: TButton
          Tag = 12
          Left = 238
          Top = 274
          Width = 185
          Height = 21
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
        Left = 3
        Top = 412
        Width = 511
        Height = 50
        Caption = #20877#29983#12486#12473#12488
        TabOrder = 2
        object buttonPlayVoice: TSpeedButton
          Left = 374
          Top = 16
          Width = 60
          Height = 26
          Caption = #20877#29983
          OnClick = buttonPlayVoiceClick
        end
        object buttonStopVoice: TSpeedButton
          Left = 440
          Top = 16
          Width = 60
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
          Width = 320
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
      end
      object GroupBox19: TGroupBox
        Left = 3
        Top = 319
        Width = 511
        Height = 87
        Caption = #36861#21152#12398'CQ'#12513#12483#12475#12540#12472
        TabOrder = 1
        object Label36: TLabel
          Left = 8
          Top = 35
          Width = 21
          Height = 13
          Caption = 'CQ2'
        end
        object Label37: TLabel
          Left = 8
          Top = 57
          Width = 21
          Height = 13
          Caption = 'CQ3'
        end
        object Label82: TLabel
          Left = 32
          Top = 16
          Width = 28
          Height = 13
          Caption = #12513#12514
        end
        object buttonAddVoiceAfterCmd2: TSpeedButton
          Tag = 2
          Left = 429
          Top = 32
          Width = 75
          Height = 21
          Caption = #21069#24460#20966#29702
        end
        object buttonAddVoiceAfterCmd3: TSpeedButton
          Tag = 3
          Left = 429
          Top = 54
          Width = 75
          Height = 21
          Caption = #21069#24460#20966#29702
          OnClick = buttonAddVoiceAfterCmdClick
        end
        object vEdit14: TEdit
          Tag = 3
          Left = 32
          Top = 54
          Width = 200
          Height = 21
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
          Width = 200
          Height = 21
          AutoSize = False
          MaxLength = 255
          PopupMenu = popupVoiceMenu
          TabOrder = 0
          OnEnter = vAdditionalEditEnter
          OnExit = vAdditionalEditExit
        end
        object vButton13: TButton
          Tag = 2
          Left = 238
          Top = 32
          Width = 185
          Height = 21
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
          Left = 238
          Top = 54
          Width = 185
          Height = 21
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
    object tabsheetCW: TTabSheet
      Caption = #12461#12540#12516#12540'/'#33258#21205'CQ'
      object groupKeyerSettings: TGroupBox
        Left = 6
        Top = 4
        Width = 512
        Height = 369
        Caption = #12461#12540#12516#12540#35373#23450
        TabOrder = 0
        object Label11: TLabel
          Left = 77
          Top = 19
          Width = 31
          Height = 13
          Caption = #36895#24230
        end
        object SpeedLabel: TLabel
          Left = 190
          Top = 35
          Width = 48
          Height = 13
          AutoSize = False
          Caption = '25 wpm'
        end
        object Label13: TLabel
          Left = 77
          Top = 61
          Width = 34
          Height = 13
          Caption = #12454#12455#12452#12488
        end
        object WeightLabel: TLabel
          Left = 190
          Top = 76
          Width = 48
          Height = 13
          AutoSize = False
          Caption = '50 %'
        end
        object Label16: TLabel
          Left = 53
          Top = 158
          Width = 90
          Height = 13
          AutoSize = False
          Caption = #12488#12540#12531#12500#12483#12481'(Hz)'
        end
        object Label12: TLabel
          Left = 26
          Top = 213
          Width = 117
          Height = 13
          AutoSize = False
          Caption = '019'#12398#30465#30053#24418
        end
        object Label85: TLabel
          Left = 53
          Top = 185
          Width = 90
          Height = 13
          AutoSize = False
          Caption = #38899#37327'(1-100)'
        end
        object SpeedBar: TTrackBar
          Left = 18
          Top = 31
          Width = 166
          Height = 28
          Max = 50
          Min = 5
          PageSize = 1
          Frequency = 10
          Position = 5
          TabOrder = 0
          OnChange = SpeedBarChange
        end
        object WeightBar: TTrackBar
          Left = 18
          Top = 72
          Width = 166
          Height = 28
          Max = 100
          Frequency = 10
          TabOrder = 1
          OnChange = WeightBarChange
        end
        object ToneSpinEdit: TSpinEdit
          Left = 162
          Top = 155
          Width = 46
          Height = 22
          Increment = 10
          MaxValue = 2500
          MinValue = 100
          TabOrder = 4
          Value = 100
        end
        object FIFOCheck: TCheckBox
          Left = 26
          Top = 111
          Width = 204
          Height = 17
          Caption = #12513#12483#12475#12540#12472#12434#12461#12517#12540#12452#12531#12464#12377#12427
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object AbbrevEdit: TEdit
          Left = 162
          Top = 210
          Width = 41
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 6
          Text = 'OAN'
        end
        object SideToneCheck: TCheckBox
          Left = 26
          Top = 134
          Width = 204
          Height = 17
          Caption = #12469#12452#12489#12488#12540#12531#12434#20351#29992#12377#12427
          TabOrder = 3
        end
        object VolumeSpinEdit: TSpinEdit
          Left = 162
          Top = 182
          Width = 46
          Height = 22
          MaxValue = 100
          MinValue = 1
          TabOrder = 5
          Value = 100
        end
        object checkPaddleReverse: TCheckBox
          Left = 26
          Top = 313
          Width = 230
          Height = 17
          Caption = #12497#12489#12523#24038#21491#21453#36578
          TabOrder = 10
        end
        object cbCQSP: TCheckBox
          Left = 26
          Top = 244
          Width = 230
          Height = 17
          Hint = 
            'This option will switch the CW message sent when TAB or ; key is' +
            ' pressed to that in the current message bank. '
          Caption = 'CQ/SP'#12514#12540#12489#12395#24540#12376#12390'CW'#12496#12531#12463#20999#26367
          TabOrder = 7
          WordWrap = True
        end
        object checkNotSendLeadingZeros: TCheckBox
          Left = 26
          Top = 290
          Width = 230
          Height = 17
          Caption = #12471#12522#12450#12523#12490#12531#12496#12540#12398#21069'0'#12434#36865#20449#12375#12394#12356
          TabOrder = 9
        end
        object checkSendNrAuto: TCheckBox
          Left = 26
          Top = 267
          Width = 230
          Height = 17
          Caption = 'NR?'#12434#33258#21205#36865#20449
          TabOrder = 8
        end
      end
      object groupCwSettings: TGroupBox
        Left = 6
        Top = 384
        Width = 512
        Height = 113
        Caption = #33258#21205'CQ'#12398#35373#23450
        TabOrder = 1
        object Label15: TLabel
          Left = 20
          Top = 53
          Width = 140
          Height = 13
          AutoSize = False
          Caption = 'CQ'#26368#22823#25968
        end
        object Label17: TLabel
          Left = 20
          Top = 26
          Width = 140
          Height = 13
          AutoSize = False
          Caption = 'CQ'#32368#12426#36820#12375#38291#38548' ('#31186')'
        end
        object CQmaxSpinEdit: TSpinEdit
          Left = 162
          Top = 50
          Width = 46
          Height = 22
          MaxValue = 999
          MinValue = 0
          TabOrder = 1
          Value = 15
        end
        object CQRepEdit: TEdit
          Left = 162
          Top = 23
          Width = 41
          Height = 21
          TabOrder = 0
          Text = '2.0'
          OnKeyPress = CQRepEditKeyPress
        end
        object checkUseCQRamdomRepeat: TCheckBox
          Left = 20
          Top = 78
          Width = 230
          Height = 17
          Caption = 'CQ'#12521#12531#12480#12512#20877#29983#12434#20351#29992#12377#12427
          TabOrder = 2
          WordWrap = True
        end
      end
    end
    object tabsheetPreferences: TTabSheet
      Caption = 'zLog'#12398#35373#23450
      object groupPreferences: TGroupBox
        Left = 6
        Top = 4
        Width = 512
        Height = 198
        Caption = #20840#33324
        TabOrder = 0
        object Label40: TLabel
          Left = 11
          Top = 136
          Width = 54
          Height = 13
          Caption = #33258#21205#20445#23384
        end
        object Label41: TLabel
          Left = 120
          Top = 136
          Width = 28
          Height = 13
          Caption = 'QSO'#27598
        end
        object checkUseContestPeriod: TCheckBox
          Left = 11
          Top = 18
          Width = 160
          Height = 17
          Caption = #12467#12531#12486#12473#12488#26399#38291#12434#20351#12358
          TabOrder = 0
        end
        object checkOutputOutofPeriod: TCheckBox
          Left = 11
          Top = 41
          Width = 160
          Height = 17
          Caption = #26178#38291#22806#12398#20132#20449#12418#12525#12464#20986#21147
          TabOrder = 1
        end
        object checkDispLongDateTime: TCheckBox
          Left = 11
          Top = 64
          Width = 193
          Height = 17
          Caption = #38263#12356#26085#20184#12391#34920#31034#12377#12427
          TabOrder = 2
        end
        object cbSaveWhenNoCW: TCheckBox
          Left = 11
          Top = 87
          Width = 161
          Height = 17
          Caption = #20445#23384#12399'CW'#38750#36865#20449#26178
          TabOrder = 3
        end
        object SaveEvery: TSpinEdit
          Left = 76
          Top = 133
          Width = 38
          Height = 22
          AutoSize = False
          MaxValue = 99
          MinValue = 1
          TabOrder = 5
          Value = 3
        end
        object cbJMode: TCheckBox
          Left = 11
          Top = 110
          Width = 97
          Height = 17
          Caption = 'J'#12514#12540#12489
          TabOrder = 4
        end
        object checkUseMultiLineTabs: TCheckBox
          Left = 268
          Top = 18
          Width = 217
          Height = 17
          Caption = #12479#12502#12434#35079#25968#34892#34920#31034#12377#12427
          TabOrder = 6
        end
        object checkUseDarkMode: TCheckBox
          Left = 268
          Top = 41
          Width = 217
          Height = 17
          Caption = #12480#12540#12463#12514#12540#12489#12434#20351#12358
          TabOrder = 7
        end
        object checkDisableShortCutsQSOEdit: TCheckBox
          Left = 268
          Top = 64
          Width = 225
          Height = 17
          Caption = 'QSO'#32232#38598#26178#12395#12471#12519#12540#12488#12459#12483#12488#12434#20351#29992#12375#12394#12356
          TabOrder = 8
        end
        object checkExportMemoToAdif: TCheckBox
          Left = 268
          Top = 87
          Width = 217
          Height = 17
          Caption = 'ADIF'#12395'Memo'#27396#12434#20986#21147#12377#12427
          TabOrder = 9
        end
        object checkShowStartupWindow: TCheckBox
          Left = 268
          Top = 110
          Width = 217
          Height = 17
          Caption = #38283#22987#12454#12452#12531#12489#12454#12434#20351#29992#12377#12427
          TabOrder = 10
        end
      end
      object groupAccessibility: TGroupBox
        Left = 6
        Top = 308
        Width = 512
        Height = 52
        Caption = #12518#12540#12470#12540#35036#21161
        TabOrder = 3
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
          StyleElements = [seFont, seBorder]
        end
        object buttonFocusedBackColor: TButton
          Tag = 1
          Left = 327
          Top = 21
          Width = 53
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonFocusedBackColorClick
        end
        object buttonFocusedInitColor: TButton
          Left = 448
          Top = 21
          Width = 53
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 4
          OnClick = buttonFocusedInitColorClick
        end
        object checkFocusedBold: TCheckBox
          Left = 386
          Top = 20
          Width = 45
          Height = 22
          Caption = #22826#23383
          TabOrder = 3
          OnClick = checkFocusedBoldClick
        end
        object buttonFocusedForeColor: TButton
          Left = 268
          Top = 21
          Width = 53
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 1
          OnClick = buttonFocusedForeColorClick
        end
      end
      object groupQsoListColors: TGroupBox
        Left = 6
        Top = 366
        Width = 512
        Height = 134
        Caption = #20132#20449#12522#12473#12488
        TabOrder = 4
        object Label32: TLabel
          Left = 8
          Top = 23
          Width = 33
          Height = 13
          Caption = #36890#24120#34920#31034'('#22855#25968#34892')'
        end
        object Label33: TLabel
          Left = 8
          Top = 77
          Width = 94
          Height = 13
          Caption = #36984#25246#33394'('#12501#12457#12540#12459#12473#26377')'
        end
        object Label43: TLabel
          Left = 8
          Top = 104
          Width = 91
          Height = 13
          Caption = #36984#25246#33394'('#12501#12457#12540#12459#12473#28961')'
        end
        object editListColor1: TEdit
          Left = 145
          Top = 20
          Width = 112
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'TEXT'
          StyleElements = [seFont, seBorder]
        end
        object buttonListBack1: TButton
          Tag = 1
          Left = 327
          Top = 21
          Width = 53
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonListBackClick
        end
        object buttonListReset1: TButton
          Tag = 1
          Left = 448
          Top = 21
          Width = 53
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 4
          OnClick = buttonListResetClick
        end
        object editListColor2: TEdit
          Left = 145
          Top = 47
          Width = 112
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 6
          Text = 'TEXT'
          StyleElements = [seFont, seBorder]
        end
        object buttonListBack2: TButton
          Tag = 2
          Left = 327
          Top = 48
          Width = 53
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 8
          OnClick = buttonListBackClick
        end
        object buttonListReset2: TButton
          Tag = 2
          Left = 448
          Top = 48
          Width = 53
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 10
          OnClick = buttonListResetClick
        end
        object buttonListFore1: TButton
          Tag = 1
          Left = 268
          Top = 21
          Width = 53
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 1
          OnClick = buttonListForeClick
        end
        object checkListBold1: TCheckBox
          Tag = 1
          Left = 386
          Top = 22
          Width = 41
          Height = 17
          Caption = #22826#23383
          TabOrder = 3
          OnClick = checkListBoldClick
        end
        object buttonListFore2: TButton
          Tag = 2
          Left = 268
          Top = 48
          Width = 53
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 7
          OnClick = buttonListForeClick
        end
        object checkListBold2: TCheckBox
          Tag = 2
          Left = 386
          Top = 49
          Width = 41
          Height = 17
          Caption = #22826#23383
          TabOrder = 9
          OnClick = checkListBoldClick
        end
        object editListColor3: TEdit
          Left = 145
          Top = 74
          Width = 112
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 11
          Text = 'TEXT'
          StyleElements = [seFont, seBorder]
        end
        object buttonListBack3: TButton
          Tag = 3
          Left = 327
          Top = 75
          Width = 53
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 12
          OnClick = buttonListBackClick
        end
        object buttonListReset3: TButton
          Tag = 3
          Left = 448
          Top = 75
          Width = 53
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 13
          OnClick = buttonListResetClick
        end
        object editListColor4: TEdit
          Left = 145
          Top = 101
          Width = 112
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 14
          Text = 'TEXT'
          StyleElements = [seFont, seBorder]
        end
        object buttonListBack4: TButton
          Tag = 4
          Left = 327
          Top = 102
          Width = 53
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 15
          OnClick = buttonListBackClick
        end
        object buttonListReset4: TButton
          Tag = 4
          Left = 448
          Top = 102
          Width = 53
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 16
          OnClick = buttonListResetClick
        end
        object comboListColorType2: TComboBox
          Left = 8
          Top = 47
          Width = 113
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 5
          Text = #20598#25968#34892
          Items.Strings = (
            #20598#25968#34892
            'RBN Verified')
        end
      end
      object groupUsabilityAfterQsoEdit: TGroupBox
        Left = 6
        Top = 208
        Width = 334
        Height = 94
        Caption = 'QSO'#32232#38598#24460#12398#12501#12457#12540#12459#12473#20301#32622
        TabOrder = 1
        object Panel2: TPanel
          Left = 11
          Top = 24
          Width = 302
          Height = 25
          BevelOuter = bvNone
          TabOrder = 0
          object Label44: TLabel
            Left = 3
            Top = 6
            Width = 58
            Height = 13
            Caption = 'OK'#12463#12522#12483#12463#24460
          end
          object radioOnOkFocusToQsoList: TRadioButton
            Left = 117
            Top = 5
            Width = 73
            Height = 17
            Caption = #20132#20449#12522#12473#12488
            TabOrder = 0
          end
          object radioOnOkFocusToNewQso: TRadioButton
            Left = 205
            Top = 5
            Width = 73
            Height = 17
            Caption = #27425#12398'QSO'
            TabOrder = 1
          end
        end
        object Panel3: TPanel
          Left = 11
          Top = 55
          Width = 302
          Height = 25
          BevelOuter = bvNone
          TabOrder = 1
          object Label45: TLabel
            Left = 3
            Top = 6
            Width = 76
            Height = 13
            Caption = #12461#12515#12531#12475#12523#12463#12522#12483#12463#24460
          end
          object radioOnCancelFocusToQsoList: TRadioButton
            Left = 117
            Top = 5
            Width = 73
            Height = 17
            Caption = #20132#20449#12522#12473#12488
            TabOrder = 0
          end
          object radioOnCancelFocusToNewQso: TRadioButton
            Left = 205
            Top = 5
            Width = 73
            Height = 17
            Caption = #27425#12398'QSO'
            TabOrder = 1
          end
        end
      end
      object groupWebUpload: TGroupBox
        Left = 346
        Top = 208
        Width = 172
        Height = 94
        Caption = 'JARL E-LOG'
        TabOrder = 2
        object Label51: TLabel
          Left = 11
          Top = 30
          Width = 139
          Height = 13
          Caption = 'WebUpload'#12395#20351#29992#12377#12427#12502#12521#12454#12470
        end
        object radioWebUpload0: TRadioButton
          Left = 10
          Top = 60
          Width = 54
          Height = 17
          Caption = #33258#21205
          TabOrder = 0
        end
        object radioWebUpload1: TRadioButton
          Left = 63
          Top = 60
          Width = 48
          Height = 17
          Caption = 'IE'
          TabOrder = 1
        end
        object radioWebUpload2: TRadioButton
          Left = 112
          Top = 60
          Width = 48
          Height = 17
          Caption = 'Edge'
          TabOrder = 2
        end
      end
    end
    object tabsheetMisc: TTabSheet
      Caption = #12481#12455#12483#12459#12540
      object groupSuperCheck: TGroupBox
        Left = 6
        Top = 205
        Width = 512
        Height = 52
        Caption = #12473#12540#12497#12540#12481#12455#12483#12463
        TabOrder = 1
        object radioSuperCheck0: TRadioButton
          Left = 12
          Top = 24
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
          Top = 24
          Width = 83
          Height = 17
          Caption = 'ZLO/ZLOX'
          TabOrder = 1
          OnClick = OnNeedSuperCheckLoad
        end
        object radioSuperCheck2: TRadioButton
          Left = 153
          Top = 24
          Width = 96
          Height = 17
          Caption = #20001#26041
          TabOrder = 2
          OnClick = OnNeedSuperCheckLoad
        end
        object checkAcceptDuplicates: TCheckBox
          Left = 372
          Top = 24
          Width = 129
          Height = 17
          Caption = #37325#35079#12434#21463#12369#20837#12428#12427
          TabOrder = 3
          OnClick = OnNeedSuperCheckLoad
        end
      end
      object groupNplus1: TGroupBox
        Left = 6
        Top = 265
        Width = 512
        Height = 50
        Caption = 'N+1'
        TabOrder = 2
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
          StyleElements = [seFont, seBorder]
        end
        object buttonFullmatchSelectColor: TButton
          Left = 327
          Top = 21
          Width = 53
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonFullmatchSelectColorClick
        end
        object buttonFullmatchInitColor: TButton
          Left = 448
          Top = 21
          Width = 53
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 3
          OnClick = buttonFullmatchInitColorClick
        end
      end
      object groupPartialCheck: TGroupBox
        Left = 6
        Top = 323
        Width = 512
        Height = 50
        Caption = #12497#12540#12471#12515#12523#12481#12455#12483#12463
        TabOrder = 3
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
          StyleElements = [seFont, seBorder]
        end
        object buttonPartialCheckForeColor: TButton
          Left = 268
          Top = 20
          Width = 53
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 1
          OnClick = buttonPartialCheckForeColorClick
        end
        object buttonPartialCheckInitColor: TButton
          Left = 448
          Top = 20
          Width = 53
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 3
          OnClick = buttonPartialCheckInitColorClick
        end
        object buttonPartialCheckBackColor: TButton
          Tag = 1
          Left = 327
          Top = 20
          Width = 53
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonPartialCheckBackColorClick
        end
      end
      object groupBasicSettings: TGroupBox
        Left = 6
        Top = 6
        Width = 512
        Height = 193
        Caption = #22522#26412#35373#23450
        TabOrder = 0
        object Label14: TLabel
          Left = 55
          Top = 64
          Width = 92
          Height = 13
          Caption = #38281#12376#12427#12414#12391#12398#26178#38291
        end
        object Label18: TLabel
          Left = 223
          Top = 64
          Width = 34
          Height = 13
          Caption = #12511#12522#31186
        end
        object cbDisplayDatePartialCheck: TCheckBox
          Left = 11
          Top = 18
          Width = 200
          Height = 17
          Caption = #12497#12540#12471#12515#12523#12481#12455#12483#12463#20869#12395#26085#20184#12434#34920#31034
          TabOrder = 0
        end
        object checkUseIncrementalDupeCheck: TCheckBox
          Left = 11
          Top = 41
          Width = 217
          Height = 17
          Caption = #12452#12531#12463#12522#12513#12531#12479#12523#12487#12517#12540#12503#12481#12455#12483#12463#12434#20351#12358
          TabOrder = 1
        end
        object cbAutoEnterSuper: TCheckBox
          Left = 11
          Top = 87
          Width = 260
          Height = 17
          Caption = #12473#12540#12497#12540#12481#12455#12483#12463#12424#12426#12490#12531#12496#12540#33258#21205#20837#21147
          TabOrder = 3
        end
        object spPartialCloseTime: TSpinEdit
          Left = 161
          Top = 61
          Width = 56
          Height = 22
          AutoSize = False
          MaxValue = 9999
          MinValue = 1
          TabOrder = 2
          Value = 5000
        end
      end
      object groupDetailSettings: TGroupBox
        Left = 6
        Top = 381
        Width = 512
        Height = 119
        Caption = #35443#32048#35373#23450
        TabOrder = 4
        object Label47: TLabel
          Left = 11
          Top = 18
          Width = 175
          Height = 13
          AutoSize = False
          Caption = #12473#12540#12497#12540#12481#12455#12483#12463#12398#26908#32034#28145#12373
        end
        object Label48: TLabel
          Left = 11
          Top = 43
          Width = 175
          Height = 13
          AutoSize = False
          Caption = #12496#12531#12489#12473#12467#12540#12503#12398#12487#12540#12479#20445#25345#26178#38291
        end
        object Label49: TLabel
          Left = 244
          Top = 43
          Width = 16
          Height = 13
          Caption = #20998
        end
        object Label52: TLabel
          Left = 11
          Top = 67
          Width = 175
          Height = 13
          AutoSize = False
          Caption = #12473#12509#12483#12488#12487#12540#12479#12398#20445#25345#26178#38291
        end
        object Label53: TLabel
          Left = 244
          Top = 67
          Width = 16
          Height = 13
          Caption = #20998
        end
        object cbUpdateThread: TCheckBox
          Left = 11
          Top = 92
          Width = 175
          Height = 17
          Caption = #21029#12473#12524#12483#12489#12391#12473#12467#12450#26356#26032
          TabOrder = 3
        end
        object rgSearchAfter: TRadioGroup
          Left = 396
          Top = 16
          Width = 105
          Height = 89
          Caption = #26908#32034#38283#22987
          ItemIndex = 0
          Items.Strings = (
            '1'#25991#23383#20837#21147#24460
            '2'#25991#23383#20837#21147#24460
            '3'#25991#23383#20837#21147#24460)
          TabOrder = 4
          TabStop = True
        end
        object spBSExpire: TSpinEdit
          Left = 188
          Top = 40
          Width = 49
          Height = 22
          AutoSize = False
          MaxValue = 99999
          MinValue = 1
          TabOrder = 1
          Value = 60
        end
        object spMaxSuperHit: TSpinEdit
          Left = 188
          Top = 16
          Width = 49
          Height = 22
          MaxValue = 99999
          MinValue = 0
          TabOrder = 0
          Value = 1
        end
        object spSpotExpire: TSpinEdit
          Left = 188
          Top = 64
          Width = 49
          Height = 22
          AutoSize = False
          MaxValue = 99999
          MinValue = 1
          TabOrder = 2
          Value = 60
        end
      end
    end
    object tabsheetQuickFunctions: TTabSheet
      Caption = #12463#12452#12483#12463#27231#33021
      ImageIndex = 8
      object groupQuickMemo: TGroupBox
        Left = 6
        Top = 284
        Width = 512
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
        Width = 512
        Height = 274
        Caption = #12463#12452#12483#12463'QSY'
        TabOrder = 0
        object checkUseKhzQsyCommand: TCheckBox
          Left = 227
          Top = 247
          Width = 242
          Height = 17
          Caption = 'kHz QSY '#12467#12510#12531#12489#12434#20351#29992#12377#12427' (F/KC)'
          TabOrder = 1
        end
        object listviewFreqMemory: TListView
          Left = 10
          Top = 24
          Width = 491
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
          Left = 10
          Top = 243
          Width = 59
          Height = 25
          Caption = #36861#21152
          TabOrder = 2
          OnClick = buttonFreqMemAddClick
        end
        object buttonFreqMemEdit: TButton
          Left = 75
          Top = 243
          Width = 59
          Height = 25
          Caption = #32232#38598
          TabOrder = 3
          OnClick = buttonFreqMemEditClick
        end
        object buttonFreqMemDelete: TButton
          Left = 140
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
        Width = 512
        Height = 149
        Caption = #20351#29992#12377#12427#12496#12531#12489
        TabOrder = 0
        object checkBs01: TCheckBox
          Left = 12
          Top = 18
          Width = 90
          Height = 17
          Caption = '1.9 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object checkBs02: TCheckBox
          Left = 12
          Top = 39
          Width = 90
          Height = 17
          Caption = '3.5 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object checkBs03: TCheckBox
          Left = 12
          Top = 60
          Width = 90
          Height = 17
          Caption = '7 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object checkBs05: TCheckBox
          Left = 12
          Top = 103
          Width = 90
          Height = 17
          Caption = '14 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object checkBs07: TCheckBox
          Left = 109
          Top = 18
          Width = 90
          Height = 17
          Caption = '21 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
        object checkBs09: TCheckBox
          Left = 109
          Top = 60
          Width = 90
          Height = 17
          Caption = '28 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 8
        end
        object checkBs10: TCheckBox
          Left = 109
          Top = 81
          Width = 90
          Height = 17
          Caption = '50 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 9
        end
        object checkBs11: TCheckBox
          Left = 109
          Top = 103
          Width = 90
          Height = 17
          Caption = '144 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 10
        end
        object checkBs12: TCheckBox
          Left = 109
          Top = 125
          Width = 90
          Height = 17
          Caption = '430 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 11
        end
        object checkBs13: TCheckBox
          Left = 206
          Top = 18
          Width = 90
          Height = 17
          Caption = '1200 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 12
        end
        object checkBs14: TCheckBox
          Left = 206
          Top = 39
          Width = 90
          Height = 17
          Caption = '2400 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 13
        end
        object checkBs15: TCheckBox
          Left = 206
          Top = 60
          Width = 90
          Height = 17
          Caption = '5600 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 14
        end
        object checkBs16: TCheckBox
          Left = 206
          Top = 81
          Width = 90
          Height = 17
          Caption = '10.1 GHz'
          Checked = True
          State = cbChecked
          TabOrder = 15
        end
        object checkBs08: TCheckBox
          Left = 109
          Top = 39
          Width = 90
          Height = 17
          Caption = '24 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 7
        end
        object checkBs06: TCheckBox
          Left = 12
          Top = 125
          Width = 90
          Height = 17
          Caption = '18 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
        object checkBs04: TCheckBox
          Left = 12
          Top = 81
          Width = 90
          Height = 17
          Caption = '10 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object checkBsCurrent: TCheckBox
          Left = 399
          Top = 39
          Width = 90
          Height = 17
          Caption = #29694#22312#12496#12531#12489
          Checked = True
          State = cbChecked
          TabOrder = 23
        end
        object checkBsNewMulti: TCheckBox
          Left = 399
          Top = 60
          Width = 130
          Height = 17
          Caption = #12491#12517#12540#12510#12523#12481
          Checked = True
          State = cbChecked
          TabOrder = 24
        end
        object checkBsAllBands: TCheckBox
          Left = 399
          Top = 18
          Width = 90
          Height = 17
          Caption = 'All bands'
          Checked = True
          State = cbChecked
          TabOrder = 22
        end
        object checkBs19: TCheckBox
          Left = 303
          Top = 18
          Width = 90
          Height = 17
          Caption = '47 GHz'
          Checked = True
          State = cbChecked
          TabOrder = 18
        end
        object checkBs20: TCheckBox
          Left = 303
          Top = 39
          Width = 90
          Height = 17
          Caption = '77 GHz'
          Checked = True
          State = cbChecked
          TabOrder = 19
        end
        object checkBs18: TCheckBox
          Left = 206
          Top = 125
          Width = 90
          Height = 17
          Caption = '24 GHz'
          Checked = True
          State = cbChecked
          TabOrder = 17
        end
        object checkBs17: TCheckBox
          Left = 206
          Top = 103
          Width = 90
          Height = 17
          Caption = '10.4 GHz'
          Checked = True
          State = cbChecked
          TabOrder = 16
        end
        object checkBs22: TCheckBox
          Left = 303
          Top = 81
          Width = 90
          Height = 17
          Caption = '248 GHz'
          Checked = True
          State = cbChecked
          TabOrder = 21
        end
        object checkBs21: TCheckBox
          Left = 303
          Top = 60
          Width = 90
          Height = 17
          Caption = '135 GHz'
          Checked = True
          State = cbChecked
          TabOrder = 20
        end
      end
      object groupBandscopeInfoColors: TGroupBox
        Left = 6
        Top = 159
        Width = 512
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
          StyleElements = [seFont, seBorder]
        end
        object buttonBSFore1: TButton
          Tag = 1
          Left = 221
          Top = 21
          Width = 53
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 1
          OnClick = buttonBSForeClick
        end
        object buttonBSReset1: TButton
          Tag = 1
          Left = 400
          Top = 20
          Width = 53
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 4
          OnClick = buttonBSResetClick
        end
        object buttonBSBack1: TButton
          Tag = 1
          Left = 280
          Top = 21
          Width = 53
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
          StyleElements = [seFont, seBorder]
        end
        object buttonBSFore2: TButton
          Tag = 2
          Left = 221
          Top = 46
          Width = 53
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 6
          OnClick = buttonBSForeClick
        end
        object buttonBSReset2: TButton
          Tag = 2
          Left = 400
          Top = 46
          Width = 53
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 9
          OnClick = buttonBSResetClick
        end
        object buttonBSBack2: TButton
          Tag = 2
          Left = 280
          Top = 46
          Width = 53
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
          StyleElements = [seFont, seBorder]
        end
        object buttonBSFore3: TButton
          Tag = 3
          Left = 221
          Top = 71
          Width = 53
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 11
          OnClick = buttonBSForeClick
        end
        object buttonBSReset3: TButton
          Tag = 3
          Left = 400
          Top = 71
          Width = 53
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 14
          OnClick = buttonBSResetClick
        end
        object buttonBSBack3: TButton
          Tag = 3
          Left = 280
          Top = 71
          Width = 53
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
          StyleElements = [seFont, seBorder]
        end
        object buttonBSFore4: TButton
          Tag = 4
          Left = 221
          Top = 96
          Width = 53
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 16
          OnClick = buttonBSForeClick
        end
        object buttonBSReset4: TButton
          Tag = 4
          Left = 400
          Top = 96
          Width = 53
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 19
          OnClick = buttonBSResetClick
        end
        object buttonBSBack4: TButton
          Tag = 4
          Left = 280
          Top = 96
          Width = 53
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 17
          Visible = False
          OnClick = buttonBSBackClick
        end
        object checkBSBold1: TCheckBox
          Tag = 1
          Left = 339
          Top = 22
          Width = 41
          Height = 17
          Caption = #22826#23383
          TabOrder = 3
          OnClick = checkBSBoldClick
        end
        object checkBSBold2: TCheckBox
          Tag = 2
          Left = 339
          Top = 47
          Width = 41
          Height = 17
          Caption = #22826#23383
          TabOrder = 8
          OnClick = checkBSBoldClick
        end
        object checkBSBold3: TCheckBox
          Tag = 3
          Left = 339
          Top = 72
          Width = 41
          Height = 17
          Caption = #22826#23383
          TabOrder = 13
          OnClick = checkBSBoldClick
        end
        object checkBSBold4: TCheckBox
          Tag = 4
          Left = 339
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
        Top = 295
        Width = 512
        Height = 158
        Caption = #12496#12531#12489#12473#12467#12540#12503#12458#12503#12471#12519#12531
        TabOrder = 2
        object checkUseEstimatedMode: TCheckBox
          Left = 255
          Top = 17
          Width = 190
          Height = 17
          Caption = #21608#27874#25968#12424#12426#25512#23450#12375#12383#12514#12540#12489#12434#20351#12358
          TabOrder = 6
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
          Left = 23
          Top = 86
          Width = 165
          Height = 17
          Caption = 'Lookup Server'#12434#20351#12358
          TabOrder = 4
          OnClick = checkUseLookupServerClick
        end
        object checkSetFreqAfterModeChange: TCheckBox
          Left = 266
          Top = 63
          Width = 157
          Height = 17
          Caption = #21608#27874#25968#12378#12428#12434#25233#21046
          TabOrder = 8
        end
        object checkAlwaysChangeMode: TCheckBox
          Left = 266
          Top = 40
          Width = 176
          Height = 17
          Caption = 'LSB/USB'#12514#12540#12489#35492#12426#12434#25233#21046
          TabOrder = 7
        end
        object checkSaveCurrentFreq: TCheckBox
          Left = 255
          Top = 86
          Width = 204
          Height = 17
          Caption = 'SPOT'#12395'QSY'#12377#12427#30452#21069#12398#21608#27874#25968#12434#35352#25014
          TabOrder = 9
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
        object checkUseResume: TCheckBox
          Left = 12
          Top = 132
          Width = 145
          Height = 17
          Caption = #12524#12472#12517#12540#12512#27231#33021#12434#20351#12358
          TabOrder = 10
        end
        object panelLookupServerOption: TPanel
          Left = 25
          Top = 104
          Width = 221
          Height = 25
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 5
          object radioLookupServerAuto: TRadioButton
            Left = 8
            Top = 4
            Width = 51
            Height = 17
            Caption = #33258#21205
            Checked = True
            TabOrder = 0
            TabStop = True
          end
          object radioLookupServerProv: TRadioButton
            Left = 60
            Top = 4
            Width = 51
            Height = 17
            Caption = #30476
            TabOrder = 1
          end
          object radioLookupServerCity: TRadioButton
            Left = 100
            Top = 4
            Width = 60
            Height = 17
            Caption = #24066#21306#37089
            TabOrder = 2
          end
          object radioLookupServerNone: TRadioButton
            Left = 163
            Top = 4
            Width = 51
            Height = 17
            Caption = #12394#12375
            TabOrder = 3
          end
        end
      end
      object groupReliability: TGroupBox
        Left = 6
        Top = 458
        Width = 165
        Height = 42
        Caption = #20449#38972#24230#21021#26399#20516
        TabOrder = 3
        object radioReliabilityHigh: TRadioButton
          Left = 12
          Top = 18
          Width = 74
          Height = 17
          Caption = #39640#65288'High'#65289
          TabOrder = 0
        end
        object radioReliabilityMiddle: TRadioButton
          Left = 84
          Top = 18
          Width = 74
          Height = 17
          Caption = #20013#65288'Middle'#65289
          TabOrder = 1
        end
      end
    end
    object tabsheetBandScope2: TTabSheet
      Caption = #12496#12531#12489#12473#12467#12540#12503'2'
      ImageIndex = 11
      object groupBandscopeSpotSource: TGroupBox
        Left = 6
        Top = 4
        Width = 512
        Height = 141
        Caption = #12473#12509#12483#12488#12477#12540#12473#21029#12398#33394#35373#23450
        TabOrder = 0
        object Label61: TLabel
          Left = 8
          Top = 27
          Width = 43
          Height = 13
          Caption = 'Self Spot'
        end
        object Label69: TLabel
          Left = 8
          Top = 53
          Width = 41
          Height = 13
          Caption = 'Z-Server'
        end
        object Label79: TLabel
          Left = 58
          Top = 53
          Width = 14
          Height = 13
          Caption = 'G1'
        end
        object Label80: TLabel
          Left = 58
          Top = 79
          Width = 14
          Height = 13
          Caption = 'G2'
        end
        object Label81: TLabel
          Left = 58
          Top = 105
          Width = 14
          Height = 13
          Caption = 'G3'
        end
        object editBSColor5: TEdit
          Left = 118
          Top = 24
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'TEXT'
          StyleElements = [seFont, seBorder]
        end
        object buttonBSBack5: TButton
          Tag = 5
          Left = 316
          Top = 25
          Width = 48
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonBSBackClick
        end
        object buttonBSReset5: TButton
          Tag = 5
          Left = 369
          Top = 25
          Width = 48
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 3
          OnClick = buttonBSResetClick
        end
        object editBSColor7: TEdit
          Tag = 7
          Left = 118
          Top = 50
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 4
          Text = 'TEXT'
          StyleElements = [seFont, seBorder]
        end
        object buttonBSBack7: TButton
          Tag = 7
          Left = 316
          Top = 51
          Width = 48
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 6
          OnClick = buttonBSBackClick
        end
        object buttonBSReset7: TButton
          Tag = 7
          Left = 369
          Top = 51
          Width = 48
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 7
          OnClick = buttonBSResetClick
        end
        object editBSColor8: TEdit
          Tag = 8
          Left = 118
          Top = 76
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 9
          Text = 'TEXT'
          StyleElements = [seFont, seBorder]
        end
        object buttonBSBack8: TButton
          Tag = 8
          Left = 316
          Top = 77
          Width = 48
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 11
          OnClick = buttonBSBackClick
        end
        object buttonBSBack9: TButton
          Tag = 9
          Left = 316
          Top = 103
          Width = 48
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 16
          OnClick = buttonBSBackClick
        end
        object editBSColor9: TEdit
          Tag = 9
          Left = 118
          Top = 102
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 14
          Text = 'TEXT'
          StyleElements = [seFont, seBorder]
        end
        object buttonBSReset8: TButton
          Tag = 8
          Left = 369
          Top = 77
          Width = 48
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 12
          OnClick = buttonBSResetClick
        end
        object buttonBSReset9: TButton
          Tag = 9
          Left = 369
          Top = 103
          Width = 48
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 17
          OnClick = buttonBSResetClick
        end
        object checkUseReliability7: TCheckBox
          Left = 223
          Top = 52
          Width = 87
          Height = 17
          Caption = #20449#38972#24230#21029
          TabOrder = 5
        end
        object checkUseReliability8: TCheckBox
          Left = 223
          Top = 78
          Width = 87
          Height = 17
          Caption = #20449#38972#24230#21029
          TabOrder = 10
        end
        object checkUseReliability9: TCheckBox
          Left = 223
          Top = 104
          Width = 87
          Height = 17
          Caption = #20449#38972#24230#21029
          TabOrder = 15
        end
        object checkUseReliability5: TCheckBox
          Left = 223
          Top = 26
          Width = 87
          Height = 17
          Caption = #20449#38972#24230#21029
          TabOrder = 1
        end
        object checkNotOverwrite7: TCheckBox
          Left = 421
          Top = 52
          Width = 87
          Height = 17
          Caption = #19978#26360#12365#12375#12394#12356
          TabOrder = 8
        end
        object checkNotOverwrite8: TCheckBox
          Left = 421
          Top = 78
          Width = 87
          Height = 17
          Caption = #19978#26360#12365#12375#12394#12356
          TabOrder = 13
        end
        object checkNotOverwrite9: TCheckBox
          Left = 421
          Top = 104
          Width = 87
          Height = 17
          Caption = #19978#26360#12365#12375#12394#12356
          TabOrder = 18
        end
      end
      object groupSpotFreshness: TGroupBox
        Left = 6
        Top = 271
        Width = 512
        Height = 121
        Caption = #12473#12509#12483#12488#12398#26032#39854#24230
        TabOrder = 2
        object radioFreshness1: TRadioButton
          Left = 16
          Top = 24
          Width = 240
          Height = 17
          Caption = #27531#12426#26178#38291#65297' (1/2,1/4,1/8,1/16 '#20998')'
          TabOrder = 0
        end
        object radioFreshness2: TRadioButton
          Left = 16
          Top = 47
          Width = 240
          Height = 17
          Caption = #27531#12426#26178#38291#65298' (5,10,20,30 '#20998')'
          TabOrder = 1
        end
        object radioFreshness3: TRadioButton
          Left = 16
          Top = 70
          Width = 240
          Height = 17
          Caption = #27531#12426#26178#38291#65299' (5'#27573#38542')'
          TabOrder = 2
        end
        object radioFreshness4: TRadioButton
          Left = 16
          Top = 93
          Width = 240
          Height = 17
          Caption = #32076#36942#26178#38291' (5,10,20,30 '#20998')'
          TabOrder = 3
        end
      end
      object groupBandscopeSpotReliability: TGroupBox
        Left = 6
        Top = 151
        Width = 512
        Height = 114
        Caption = #12473#12509#12483#12488#20449#38972#24230#21029#12398#33394#35373#23450
        TabOrder = 1
        object Label28: TLabel
          Left = 8
          Top = 27
          Width = 22
          Height = 13
          Caption = #39640#65288'High'#65289
        end
        object Label29: TLabel
          Left = 8
          Top = 54
          Width = 31
          Height = 13
          Caption = #20013#65288'Middle'#65289
        end
        object Label30: TLabel
          Left = 8
          Top = 81
          Width = 20
          Height = 13
          Caption = #20302#65288'Low'#65289
        end
        object editBSColorSrHigh: TEdit
          Tag = 13
          Left = 118
          Top = 24
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'TEXT'
          StyleElements = [seFont, seBorder]
        end
        object editBSColorSrMiddle: TEdit
          Tag = 14
          Left = 118
          Top = 51
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 4
          Text = 'TEXT'
          StyleElements = [seFont, seBorder]
        end
        object editBSColorSrLow: TEdit
          Tag = 15
          Left = 118
          Top = 78
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 8
          Text = 'TEXT'
          StyleElements = [seFont, seBorder]
        end
        object buttonBSBackSrHigh: TButton
          Tag = 13
          Left = 316
          Top = 25
          Width = 48
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonBSBackClick
        end
        object buttonBSBackSrMiddle: TButton
          Tag = 14
          Left = 316
          Top = 52
          Width = 48
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 6
          OnClick = buttonBSBackClick
        end
        object buttonBSBackSrLow: TButton
          Tag = 15
          Left = 316
          Top = 79
          Width = 48
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 10
          OnClick = buttonBSBackClick
        end
        object buttonBSResetSrHigh: TButton
          Tag = 13
          Left = 369
          Top = 25
          Width = 48
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 3
          OnClick = buttonBSResetClick
        end
        object buttonBSResetSrMiddle: TButton
          Tag = 14
          Left = 369
          Top = 52
          Width = 48
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 7
          OnClick = buttonBSResetClick
        end
        object buttonBSResetSrLow: TButton
          Tag = 15
          Left = 369
          Top = 79
          Width = 48
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 11
          OnClick = buttonBSResetClick
        end
        object checkTransparentSrHigh: TCheckBox
          Left = 223
          Top = 26
          Width = 87
          Height = 17
          Caption = #36879#26126
          TabOrder = 1
        end
        object checkTransparentSrMiddle: TCheckBox
          Left = 223
          Top = 53
          Width = 87
          Height = 17
          Caption = #36879#26126
          TabOrder = 5
        end
        object checkTransparentSrLow: TCheckBox
          Left = 223
          Top = 80
          Width = 87
          Height = 17
          Caption = #36879#26126
          TabOrder = 9
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 534
    Width = 534
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      534
      37)
    object buttonOK: TButton
      Left = 189
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
      Left = 269
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
    Left = 388
    Top = 516
  end
  object ColorDialog1: TColorDialog
    Left = 356
    Top = 516
  end
  object popupVoiceMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 424
    Top = 514
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
  object popupCWMessages: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 464
    Top = 512
    object menuLoadFromMyMessages: TMenuItem
      Caption = #12510#12452#12513#12483#12475#12540#12472#12434#35501#36796'(zlog.ini)'
      OnClick = menuLoadFromMyMessagesClick
    end
    object menuSaveToMyMessages: TMenuItem
      Caption = #12510#12452#12513#12483#12475#12540#12472#12395#20445#23384'(zlog.ini)'
      OnClick = menuSaveToMyMessagesClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object menuResetMessages: TMenuItem
      Caption = #21021#26399#20516#12395#25147#12377
      OnClick = menuResetMessagesClick
    end
  end
end
