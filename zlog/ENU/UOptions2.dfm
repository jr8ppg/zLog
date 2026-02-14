object formOptions2: TformOptions2
  Left = 532
  Top = 236
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 471
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
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
    ActivePage = tabsheetMyStation
    Align = alClient
    TabOrder = 0
    object tabsheetMyStation: TTabSheet
      Caption = 'My station'
      ImageIndex = 8
      object groupMyActiveBands: TGroupBox
        Left = 253
        Top = 3
        Width = 270
        Height = 278
        Caption = 'Active bands and powers'
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
        Caption = 'Station'
        TabOrder = 0
        object Label55: TLabel
          Left = 8
          Top = 23
          Width = 57
          Height = 13
          Caption = 'Callsign($M)'
        end
        object Label39: TLabel
          Left = 8
          Top = 75
          Width = 38
          Height = 13
          Caption = 'Latitude'
        end
        object Label42: TLabel
          Left = 8
          Top = 101
          Width = 47
          Height = 13
          Caption = 'Longitude'
        end
        object Label56: TLabel
          Left = 8
          Top = 49
          Width = 51
          Height = 13
          Caption = 'GRID Loc.'
        end
        object editMyCallsign: TEdit
          Left = 88
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
          Caption = 'Calc.'
          TabOrder = 2
          OnClick = buttonMyGridCalcClick
        end
        object buttonMyPositionCalc: TButton
          Left = 175
          Top = 72
          Width = 53
          Height = 47
          Caption = 'Calc.'
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
        Caption = 'QSL Default'
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
        Caption = 'Parameters'
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
          Caption = 'Age($A)'
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
          Caption = 'Handle(CW)($H)'
        end
        object Label62: TLabel
          Left = 9
          Top = 153
          Width = 75
          Height = 13
          Caption = 'Handle(PH)($H)'
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
        Caption = 'Operators'
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
          Caption = 'Add'
          TabOrder = 1
          OnClick = buttonOpAddClick
        end
        object buttonOpDelete: TButton
          Left = 175
          Top = 128
          Width = 50
          Height = 25
          Caption = 'Delete'
          TabOrder = 3
          OnClick = buttonOpDeleteClick
        end
        object checkSelectLastOperator: TCheckBox
          Left = 231
          Top = 23
          Width = 186
          Height = 17
          Caption = 'Select last operator on startup'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
        end
        object checkApplyPowerCodeOnBandChange: TCheckBox
          Left = 231
          Top = 46
          Width = 186
          Height = 17
          Hint = 'Apply per-operator power code on band change.'
          Caption = 'Apply power code on band change'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
        end
        object buttonOpEdit: TButton
          Left = 175
          Top = 50
          Width = 50
          Height = 25
          Caption = 'Edit'
          TabOrder = 2
          OnClick = buttonOpEditClick
        end
      end
      object groupPowerDefs: TGroupBox
        Left = 429
        Top = 342
        Width = 94
        Height = 161
        Caption = 'Power($N)'
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
      object Label40: TEdit
        Left = 208
        Top = 212
        Width = 54
        Height = 13
        Caption = 'Save every'
      end
      object Label41: TEdit
        Left = 316
        Top = 212
        Width = 28
        Height = 13
        Caption = 'QSOs'
      end
      object GroupBox3: TEdit
        Left = 6
        Top = 4
        Width = 256
        Height = 202
        Caption = 'Active bands and powers'
        TabOrder = 0
        object act19: TEdit
          Left = 11
          Top = 20
          Width = 60
          Height = 17
          Caption = '1.9 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object act35: TEdit
          Left = 11
          Top = 41
          Width = 60
          Height = 17
          Caption = '3.5 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object act7: TEdit
          Left = 11
          Top = 62
          Width = 60
          Height = 17
          Caption = '7 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object act14: TEdit
          Left = 11
          Top = 104
          Width = 60
          Height = 17
          Caption = '14 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 8
        end
        object act21: TEdit
          Left = 11
          Top = 146
          Width = 60
          Height = 17
          Caption = '21 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 12
        end
        object act28: TEdit
          Left = 138
          Top = 20
          Width = 67
          Height = 17
          Caption = '28 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 16
        end
        object act50: TEdit
          Left = 138
          Top = 41
          Width = 67
          Height = 17
          Caption = '50 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 18
        end
        object act144: TEdit
          Left = 138
          Top = 62
          Width = 67
          Height = 17
          Caption = '144 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 20
        end
        object act430: TEdit
          Left = 138
          Top = 83
          Width = 67
          Height = 17
          Caption = '430 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 22
        end
        object act1200: TEdit
          Left = 138
          Top = 104
          Width = 67
          Height = 17
          Caption = '1200 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 24
        end
        object act2400: TEdit
          Left = 138
          Top = 125
          Width = 67
          Height = 17
          Caption = '2400 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 26
        end
        object act5600: TEdit
          Left = 138
          Top = 146
          Width = 67
          Height = 17
          Caption = '5600 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 28
        end
        object act10g: TEdit
          Left = 138
          Top = 167
          Width = 67
          Height = 17
          Caption = '10 G && up'
          Checked = True
          State = cbChecked
          TabOrder = 30
        end
        object act24: TEdit
          Left = 11
          Top = 167
          Width = 60
          Height = 17
          Caption = '24 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 14
        end
        object act18: TEdit
          Left = 11
          Top = 125
          Width = 60
          Height = 17
          Caption = '18 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 10
        end
        object act10: TEdit
          Left = 11
          Top = 83
          Width = 60
          Height = 17
          Caption = '10 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
        object comboPower19: TEdit
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
        object comboPower35: TEdit
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
        object comboPower7: TEdit
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
        object comboPower10: TEdit
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
        object comboPower14: TEdit
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
        object comboPower18: TEdit
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
        object comboPower21: TEdit
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
        object comboPower24: TEdit
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
        object comboPower28: TEdit
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
        object comboPower50: TEdit
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
        object comboPower144: TEdit
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
        object comboPower430: TEdit
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
        object comboPower1200: TEdit
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
        object comboPower2400: TEdit
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
        object comboPower5600: TEdit
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
        object comboPower10g: TEdit
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
      object AllowDupeCheckBox: TEdit
        Left = 276
        Top = 108
        Width = 113
        Height = 17
        Caption = 'Allow to log dupes'
        TabOrder = 3
        Visible = False
      end
      object SaveEvery: TEdit
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
      object cbDispExchange: TEdit
        Left = 17
        Top = 257
        Width = 193
        Height = 17
        Caption = 'Display exchange on other bands'
        TabOrder = 10
      end
      object cbJMode: TEdit
        Left = 276
        Top = 87
        Width = 97
        Height = 17
        Caption = 'J-mode'
        TabOrder = 2
      end
      object cbSaveWhenNoCW: TEdit
        Left = 17
        Top = 211
        Width = 161
        Height = 17
        Caption = 'Save when not sending CW'
        TabOrder = 7
      end
      object cbAutoEnterSuper: TEdit
        Left = 17
        Top = 237
        Width = 260
        Height = 17
        Caption = 'Automatically enter exchange from SuperCheck'
        TabOrder = 9
      end
      object groupQsyAssist: TEdit
        Left = 222
        Top = 304
        Width = 204
        Height = 89
        Caption = 'QSY Assist'
        TabOrder = 13
        object Label86: TEdit
          Left = 148
          Top = 40
          Width = 16
          Height = 13
          Caption = 'min'
        end
        object Label87: TEdit
          Left = 142
          Top = 64
          Width = 47
          Height = 13
          Caption = 'count / hr'
        end
        object radioQsyNone: TEdit
          Left = 11
          Top = 16
          Width = 65
          Height = 17
          Caption = 'None'
          TabOrder = 0
          OnClick = radioQsyAssistClick
        end
        object radioQsyCountDown: TEdit
          Tag = 1
          Left = 11
          Top = 39
          Width = 78
          Height = 17
          Caption = 'Count down'
          TabOrder = 1
          OnClick = radioQsyAssistClick
        end
        object radioQsyCount: TEdit
          Tag = 2
          Left = 11
          Top = 62
          Width = 78
          Height = 17
          Caption = 'QSY count'
          TabOrder = 2
          OnClick = radioQsyAssistClick
        end
        object editQsyCountDownMinute: TEdit
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
        object editQsyCountPerHour: TEdit
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
      object GroupBox13: TEdit
        Left = 17
        Top = 303
        Width = 101
        Height = 89
        Caption = 'QSL Default'
        TabOrder = 12
        object radioQslNone: TEdit
          Left = 15
          Top = 16
          Width = 65
          Height = 17
          Caption = 'None'
          TabOrder = 0
        end
        object radioPseQsl: TEdit
          Tag = 1
          Left = 15
          Top = 39
          Width = 65
          Height = 17
          Caption = 'PSE QSL'
          TabOrder = 1
        end
        object radioNoQsl: TEdit
          Tag = 2
          Left = 15
          Top = 62
          Width = 65
          Height = 17
          Caption = 'NO QSL'
          TabOrder = 2
        end
      end
      object checkDispLongDateTime: TEdit
        Left = 17
        Top = 277
        Width = 193
        Height = 17
        Caption = 'Display long date time'
        TabOrder = 11
      end
      object checkOutputOutofPeriod: TEdit
        Left = 276
        Top = 150
        Width = 160
        Height = 17
        Caption = 'Output logs out of period'
        TabOrder = 5
      end
      object checkUseContestPeriod: TEdit
        Left = 276
        Top = 129
        Width = 160
        Height = 17
        Caption = 'Use contest period'
        TabOrder = 4
      end
      object GroupBox6: TEdit
        Left = 268
        Top = 3
        Width = 153
        Height = 74
        Caption = 'My position'
        TabOrder = 1
        object Label39: TEdit
          Left = 8
          Top = 21
          Width = 38
          Height = 13
          Caption = 'Latitude'
        end
        object Label42: TEdit
          Left = 8
          Top = 48
          Width = 47
          Height = 13
          Caption = 'Longitude'
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
      object checkShowStartupWindow: TEdit
        Left = 276
        Top = 182
        Width = 160
        Height = 17
        Caption = 'Show startup window'
        TabOrder = 6
      end
    end
    object tabsheetCategories: TTabSheet
      Caption = 'Categories'
      object groupCategory: TGroupBox
        Left = 6
        Top = 147
        Width = 243
        Height = 121
        Caption = 'Category'
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
        Caption = 'Mode'
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
        Caption = 'QSY Assist'
        TabOrder = 4
        object Label86: TLabel
          Left = 164
          Top = 40
          Width = 16
          Height = 13
          Caption = 'min'
        end
        object Label87: TLabel
          Left = 164
          Top = 65
          Width = 47
          Height = 13
          Caption = 'count / hr'
        end
        object radioQsyNone: TRadioButton
          Left = 11
          Top = 16
          Width = 65
          Height = 17
          Caption = 'None'
          TabOrder = 0
          OnClick = radioQsyAssistClick
        end
        object radioQsyCountDown: TRadioButton
          Tag = 1
          Left = 11
          Top = 39
          Width = 78
          Height = 17
          Caption = 'Count down'
          TabOrder = 1
          OnClick = radioQsyAssistClick
        end
        object radioQsyCount: TRadioButton
          Tag = 2
          Left = 11
          Top = 62
          Width = 78
          Height = 17
          Caption = 'QSY count'
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
        Caption = 'Exchange'
        TabOrder = 0
        object Label19: TLabel
          Left = 10
          Top = 24
          Width = 41
          Height = 13
          Caption = 'Sent($X)'
        end
        object Label74: TLabel
          Left = 10
          Top = 51
          Width = 41
          Height = 13
          Caption = 'Prov($V)'
        end
        object Label83: TLabel
          Left = 10
          Top = 77
          Width = 37
          Height = 13
          Caption = 'City($Q)'
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
        Caption = 'Other rules'
        TabOrder = 3
        object Label46: TLabel
          Left = 11
          Top = 24
          Width = 58
          Height = 13
          Caption = 'Score coeff.'
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
      object Label14: TEdit
        Left = 299
        Top = 128
        Width = 71
        Height = 13
        Caption = 'Prov/State($V)'
      end
      object Label18: TEdit
        Left = 299
        Top = 152
        Width = 37
        Height = 13
        Caption = 'City($Q)'
      end
      object Label19: TEdit
        Left = 299
        Top = 248
        Width = 41
        Height = 13
        Caption = 'Sent($X)'
      end
      object Label34: TEdit
        Left = 299
        Top = 176
        Width = 62
        Height = 13
        Caption = 'CQ Zone($Z)'
      end
      object Label35: TEdit
        Left = 299
        Top = 200
        Width = 61
        Height = 13
        Caption = 'ITU Zone($I)'
      end
      object Label31: TEdit
        Left = 299
        Top = 223
        Width = 38
        Height = 13
        Caption = 'Age($A)'
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
        Caption = 'CW Messages'
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
        object buttonResetMessage: TSpeedButton
          Left = 209
          Top = 18
          Width = 45
          Height = 17
          Caption = 'Reset'
          OnClick = buttonResetMessageClick
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
        object Label91: TEdit
          Left = 62
          Top = 100
          Width = 21
          Height = 13
          Caption = 'TX#'
        end
        object radioSingleOp: TEdit
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
        object comboTxNo: TEdit
          Left = 91
          Top = 97
          Width = 41
          Height = 21
          Style = csDropDownList
          TabOrder = 4
        end
        object radioMultiOpMultiTx: TEdit
          Tag = 1
          Left = 11
          Top = 34
          Width = 130
          Height = 17
          Caption = 'Multi-Op/Multi-TX'
          TabOrder = 1
          OnClick = radioCategoryClick
        end
        object radioMultiOpSingleTx: TEdit
          Tag = 2
          Left = 11
          Top = 52
          Width = 130
          Height = 17
          Caption = 'Multi-Op/Single-TX'
          TabOrder = 2
          OnClick = radioCategoryClick
        end
        object radioMultiOpTwoTx: TEdit
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
      object ModeGroup: TEdit
        Left = 296
        Top = 3
        Width = 129
        Height = 114
        Caption = 'Mode'
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
        Left = 392
        Top = 124
        Width = 33
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
      end
      object GroupBox24: TEdit
        Left = 6
        Top = 139
        Width = 203
        Height = 264
        Caption = 'Operators'
        TabOrder = 9
        object OpListBox: TEdit
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
        object buttonOpAdd: TEdit
          Left = 11
          Top = 187
          Width = 57
          Height = 25
          Caption = 'Add'
          TabOrder = 1
          OnClick = buttonOpAddClick
        end
        object buttonOpDelete: TEdit
          Left = 136
          Top = 187
          Width = 57
          Height = 25
          Caption = 'Delete'
          TabOrder = 3
          OnClick = buttonOpDeleteClick
        end
        object checkSelectLastOperator: TEdit
          Left = 11
          Top = 218
          Width = 182
          Height = 17
          Caption = 'Select last operator on startup'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
        end
        object checkApplyPowerCodeOnBandChange: TEdit
          Left = 11
          Top = 239
          Width = 190
          Height = 17
          Hint = 'Apply per-operator power code on band change.'
          Caption = 'Apply power code on band change'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
        end
        object buttonOpEdit: TEdit
          Left = 73
          Top = 187
          Width = 57
          Height = 25
          Caption = 'Edit'
          TabOrder = 2
          OnClick = buttonOpEditClick
        end
      end
      object groupPower: TEdit
        Left = 296
        Top = 276
        Width = 129
        Height = 127
        Caption = 'Power($N)'
        TabOrder = 8
        object Label111: TEdit
          Left = 16
          Top = 23
          Width = 34
          Height = 13
          AutoSize = False
          Caption = 'H'
        end
        object Label112: TEdit
          Left = 16
          Top = 48
          Width = 34
          Height = 13
          AutoSize = False
          Caption = 'M'
        end
        object Label113: TEdit
          Left = 16
          Top = 73
          Width = 34
          Height = 13
          AutoSize = False
          Caption = 'L'
        end
        object Label114: TEdit
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
      end
    end
    object tabsheetVoice: TTabSheet
      Caption = 'Voice'
      object GroupBox4: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 310
        Caption = 'Messages'
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
          Left = 48
          Top = 16
          Width = 28
          Height = 13
          Caption = 'memo'
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
          Caption = 'Pre/Post'
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd2: TSpeedButton
          Tag = 2
          Left = 429
          Top = 54
          Width = 75
          Height = 21
          Caption = 'Pre/Post'
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd3: TSpeedButton
          Tag = 3
          Left = 429
          Top = 76
          Width = 75
          Height = 21
          Caption = 'Pre/Post'
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd4: TSpeedButton
          Tag = 4
          Left = 429
          Top = 98
          Width = 75
          Height = 21
          Caption = 'Pre/Post'
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd5: TSpeedButton
          Tag = 5
          Left = 429
          Top = 120
          Width = 75
          Height = 21
          Caption = 'Pre/Post'
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd6: TSpeedButton
          Tag = 6
          Left = 429
          Top = 142
          Width = 75
          Height = 21
          Caption = 'Pre/Post'
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd7: TSpeedButton
          Tag = 7
          Left = 429
          Top = 164
          Width = 75
          Height = 21
          Caption = 'Pre/Post'
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd8: TSpeedButton
          Tag = 8
          Left = 429
          Top = 186
          Width = 75
          Height = 21
          Caption = 'Pre/Post'
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd9: TSpeedButton
          Tag = 9
          Left = 429
          Top = 208
          Width = 75
          Height = 21
          Caption = 'Pre/Post'
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd10: TSpeedButton
          Tag = 10
          Left = 429
          Top = 230
          Width = 75
          Height = 21
          Caption = 'Pre/Post'
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd11: TSpeedButton
          Tag = 11
          Left = 429
          Top = 252
          Width = 75
          Height = 21
          Caption = 'Pre/Post'
          OnClick = buttonVoiceAfterCmdClick
        end
        object buttonVoiceAfterCmd12: TSpeedButton
          Tag = 12
          Left = 429
          Top = 274
          Width = 75
          Height = 21
          Caption = 'Pre/Post'
          OnClick = buttonVoiceAfterCmdClick
        end
        object vEdit2: TEdit
          Tag = 2
          Left = 32
          Top = 54
          Width = 245
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
          Width = 245
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
          Width = 245
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
          Width = 245
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
          Width = 245
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
          Width = 245
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
          Width = 245
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
          Width = 245
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
          Left = 287
          Top = 32
          Width = 125
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
          Left = 287
          Top = 54
          Width = 125
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
          Left = 287
          Top = 76
          Width = 125
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
          Left = 287
          Top = 98
          Width = 125
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
          Left = 287
          Top = 120
          Width = 125
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
          Left = 287
          Top = 142
          Width = 125
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
          Left = 287
          Top = 164
          Width = 125
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
          Left = 287
          Top = 186
          Width = 125
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
          Width = 245
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
          Width = 245
          Height = 21
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 18
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vButton9: TButton
          Tag = 9
          Left = 287
          Top = 208
          Width = 125
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
          Left = 287
          Top = 230
          Width = 125
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
          Width = 245
          Height = 21
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 20
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vButton11: TButton
          Tag = 11
          Left = 287
          Top = 252
          Width = 125
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
          Width = 245
          Height = 21
          AutoSize = False
          PopupMenu = popupVoiceMenu
          TabOrder = 22
          OnEnter = vEditEnter
          OnExit = vEditExit
        end
        object vButton12: TButton
          Tag = 12
          Left = 287
          Top = 274
          Width = 125
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
        Left = 6
        Top = 412
        Width = 423
        Height = 50
        Caption = 'Playback test'
        TabOrder = 2
        object buttonPlayVoice: TSpeedButton
          Left = 310
          Top = 16
          Width = 50
          Height = 26
          Caption = 'Play'
          OnClick = buttonPlayVoiceClick
        end
        object buttonStopVoice: TSpeedButton
          Left = 362
          Top = 16
          Width = 50
          Height = 26
          Caption = 'Stop'
          OnClick = buttonStopVoiceClick
        end
        object Label38: TLabel
          Left = 8
          Top = 22
          Width = 34
          Height = 13
          Caption = 'Device'
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
        Top = 319
        Width = 423
        Height = 87
        Caption = 'Additional CQ Messages'
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
          Left = 48
          Top = 16
          Width = 28
          Height = 13
          Caption = 'memo'
        end
        object buttonAddVoiceAfterCmd2: TSpeedButton
          Tag = 2
          Left = 429
          Top = 32
          Width = 75
          Height = 21
          Caption = 'Pre/Post'
        end
        object buttonAddVoiceAfterCmd3: TSpeedButton
          Tag = 3
          Left = 429
          Top = 54
          Width = 75
          Height = 21
          Caption = 'Pre/Post'
          OnClick = buttonAddVoiceAfterCmdClick
        end
        object vEdit14: TEdit
          Tag = 3
          Left = 32
          Top = 54
          Width = 245
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
          Width = 245
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
          Left = 287
          Top = 32
          Width = 125
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
          Left = 287
          Top = 54
          Width = 125
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
      Caption = 'Keyer/Auto CQ'
      object groupKeyerSettings: TGroupBox
        Left = 6
        Top = 4
        Width = 512
        Height = 369
        Caption = 'Keyer settings'
        TabOrder = 0
        object Label11: TLabel
          Left = 77
          Top = 19
          Width = 31
          Height = 13
          Caption = 'Speed'
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
          Caption = 'Weight'
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
          Caption = 'Tone Pitch (Hz)'
        end
        object Label12: TLabel
          Left = 26
          Top = 213
          Width = 117
          Height = 13
          AutoSize = False
          Caption = 'Abbreviation (019)'
        end
        object Label85: TLabel
          Left = 53
          Top = 185
          Width = 90
          Height = 13
          AutoSize = False
          Caption = 'Volume (1-100)'
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
          Caption = 'Que messages'
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
          Caption = 'Use Side Tone'
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
          Caption = 'Paddle Reverse'
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
          Caption = 'Switch CW bank with CQ/SP mode'
          TabOrder = 7
          WordWrap = True
        end
        object checkNotSendLeadingZeros: TCheckBox
          Left = 26
          Top = 290
          Width = 230
          Height = 17
          Caption = 'Not send leading zeros in serial numbers'
          TabOrder = 9
        end
        object checkSendNrAuto: TCheckBox
          Left = 26
          Top = 267
          Width = 230
          Height = 17
          Caption = 'Send NR? automatically'
          TabOrder = 8
        end
      end
      object groupCwSettings: TGroupBox
        Left = 6
        Top = 384
        Width = 512
        Height = 113
        Caption = 'Auto CQ settings'
        TabOrder = 1
        object Label15: TLabel
          Left = 20
          Top = 53
          Width = 140
          Height = 13
          AutoSize = False
          Caption = 'CQ max'
        end
        object Label17: TLabel
          Left = 20
          Top = 26
          Width = 140
          Height = 13
          AutoSize = False
          Caption = 'CQ repeat interval (sec)'
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
          Caption = 'Use CQ Random Repeat'
          TabOrder = 2
          WordWrap = True
        end
      end
    end
    object tabsheetPreferences: TTabSheet
      Caption = 'Preferences'
      object groupPreferences: TGroupBox
        Left = 6
        Top = 4
        Width = 512
        Height = 198
        Caption = 'General'
        TabOrder = 0
        object Label40: TLabel
          Left = 11
          Top = 136
          Width = 54
          Height = 13
          Caption = 'Save every'
        end
        object Label41: TLabel
          Left = 120
          Top = 136
          Width = 28
          Height = 13
          Caption = 'QSOs'
        end
        object checkUseContestPeriod: TCheckBox
          Left = 11
          Top = 18
          Width = 160
          Height = 17
          Caption = 'Use contest period'
          TabOrder = 0
        end
        object checkOutputOutofPeriod: TCheckBox
          Left = 11
          Top = 41
          Width = 160
          Height = 17
          Caption = 'Output logs out of period'
          TabOrder = 1
        end
        object checkDispLongDateTime: TCheckBox
          Left = 11
          Top = 64
          Width = 193
          Height = 17
          Caption = 'Display long date time'
          TabOrder = 2
        end
        object cbSaveWhenNoCW: TCheckBox
          Left = 11
          Top = 87
          Width = 161
          Height = 17
          Caption = 'Save when not sending CW'
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
          Caption = 'J-mode'
          TabOrder = 4
        end
        object checkUseMultiLineTabs: TCheckBox
          Left = 268
          Top = 18
          Width = 217
          Height = 17
          Caption = 'Use multiline tabs'
          TabOrder = 6
        end
        object checkUseDarkMode: TCheckBox
          Left = 268
          Top = 41
          Width = 217
          Height = 17
          Caption = 'Use dark mode'
          TabOrder = 7
        end
        object checkDisableShortCutsQSOEdit: TCheckBox
          Left = 268
          Top = 64
          Width = 217
          Height = 17
          Caption = 'Disable shortcuts during QSO editing'
          TabOrder = 8
        end
        object checkExportMemoToAdif: TCheckBox
          Left = 268
          Top = 87
          Width = 217
          Height = 17
          Caption = 'Export the Memo field to ADIF'
          TabOrder = 9
        end
      end
      object groupAccessibility: TGroupBox
        Left = 6
        Top = 308
        Width = 512
        Height = 52
        Caption = 'Accessibility'
        TabOrder = 3
        object Label89: TLabel
          Left = 15
          Top = 23
          Width = 68
          Height = 13
          Caption = 'Focused Color'
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
          Caption = 'Back...'
          TabOrder = 2
          OnClick = buttonFocusedBackColorClick
        end
        object buttonFocusedInitColor: TButton
          Left = 448
          Top = 21
          Width = 53
          Height = 20
          Caption = 'Reset'
          TabOrder = 4
          OnClick = buttonFocusedInitColorClick
        end
        object checkFocusedBold: TCheckBox
          Left = 386
          Top = 20
          Width = 45
          Height = 22
          Caption = 'Bold'
          TabOrder = 3
          OnClick = checkFocusedBoldClick
        end
        object buttonFocusedForeColor: TButton
          Left = 268
          Top = 21
          Width = 53
          Height = 20
          Caption = 'Fore...'
          TabOrder = 1
          OnClick = buttonFocusedForeColorClick
        end
      end
      object groupQsoListColors: TGroupBox
        Left = 6
        Top = 366
        Width = 512
        Height = 134
        Caption = 'QSO list'
        TabOrder = 4
        object Label32: TLabel
          Left = 8
          Top = 23
          Width = 33
          Height = 13
          Caption = 'Normal'
        end
        object Label33: TLabel
          Left = 8
          Top = 77
          Width = 94
          Height = 13
          Caption = 'Selection (Focused)'
        end
        object Label43: TLabel
          Left = 8
          Top = 104
          Width = 91
          Height = 13
          Caption = 'Selection (Inactive)'
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
          Caption = 'Back...'
          TabOrder = 2
          OnClick = buttonListBackClick
        end
        object buttonListReset1: TButton
          Tag = 1
          Left = 448
          Top = 21
          Width = 53
          Height = 20
          Caption = 'Reset'
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
          Caption = 'Back...'
          TabOrder = 8
          OnClick = buttonListBackClick
        end
        object buttonListReset2: TButton
          Tag = 2
          Left = 448
          Top = 48
          Width = 53
          Height = 20
          Caption = 'Reset'
          TabOrder = 10
          OnClick = buttonListResetClick
        end
        object buttonListFore1: TButton
          Tag = 1
          Left = 268
          Top = 21
          Width = 53
          Height = 20
          Caption = 'Fore...'
          TabOrder = 1
          OnClick = buttonListForeClick
        end
        object checkListBold1: TCheckBox
          Tag = 1
          Left = 386
          Top = 22
          Width = 41
          Height = 17
          Caption = 'Bold'
          TabOrder = 3
          OnClick = checkListBoldClick
        end
        object buttonListFore2: TButton
          Tag = 2
          Left = 268
          Top = 48
          Width = 53
          Height = 20
          Caption = 'Fore...'
          TabOrder = 7
          OnClick = buttonListForeClick
        end
        object checkListBold2: TCheckBox
          Tag = 2
          Left = 386
          Top = 49
          Width = 41
          Height = 17
          Caption = 'Bold'
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
          Caption = 'Back...'
          TabOrder = 12
          OnClick = buttonListBackClick
        end
        object buttonListReset3: TButton
          Tag = 3
          Left = 448
          Top = 75
          Width = 53
          Height = 20
          Caption = 'Reset'
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
          Caption = 'Back...'
          TabOrder = 15
          OnClick = buttonListBackClick
        end
        object buttonListReset4: TButton
          Tag = 4
          Left = 448
          Top = 102
          Width = 53
          Height = 20
          Caption = 'Reset'
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
          Text = 'Zebra color'
          Items.Strings = (
            'Zebra color'
            'RBN Verified')
        end
      end
      object groupUsabilityAfterQsoEdit: TGroupBox
        Left = 6
        Top = 208
        Width = 334
        Height = 94
        Caption = 'Focus Position After QSO Edit'
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
            Caption = 'On OK Click'
          end
          object radioOnOkFocusToQsoList: TRadioButton
            Left = 117
            Top = 5
            Width = 73
            Height = 17
            Caption = 'QSO List'
            TabOrder = 0
          end
          object radioOnOkFocusToNewQso: TRadioButton
            Left = 205
            Top = 5
            Width = 73
            Height = 17
            Caption = 'New QSO'
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
            Caption = 'On Cancel Click'
          end
          object radioOnCancelFocusToQsoList: TRadioButton
            Left = 117
            Top = 5
            Width = 73
            Height = 17
            Caption = 'QSO List'
            TabOrder = 0
          end
          object radioOnCancelFocusToNewQso: TRadioButton
            Left = 205
            Top = 5
            Width = 73
            Height = 17
            Caption = 'New QSO'
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
          Caption = 'Browser used for WebUpload'
        end
        object radioWebUpload0: TRadioButton
          Left = 10
          Top = 60
          Width = 54
          Height = 17
          Caption = 'Auto'
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
      Caption = 'Checker'
      object groupSuperCheck: TGroupBox
        Left = 6
        Top = 205
        Width = 512
        Height = 52
        Caption = 'Super Check'
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
          Caption = 'Both'
          TabOrder = 2
          OnClick = OnNeedSuperCheckLoad
        end
        object checkAcceptDuplicates: TCheckBox
          Left = 372
          Top = 24
          Width = 129
          Height = 17
          Caption = 'Accept duplicates'
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
          Caption = 'Highlight FullMatch'
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
          Caption = 'Color...'
          TabOrder = 2
          OnClick = buttonFullmatchSelectColorClick
        end
        object buttonFullmatchInitColor: TButton
          Left = 448
          Top = 21
          Width = 53
          Height = 20
          Caption = 'Reset'
          TabOrder = 3
          OnClick = buttonFullmatchInitColorClick
        end
      end
      object groupPartialCheck: TGroupBox
        Left = 6
        Top = 323
        Width = 512
        Height = 50
        Caption = 'Partial Check'
        TabOrder = 3
        object Label88: TLabel
          Left = 15
          Top = 24
          Width = 61
          Height = 13
          Caption = 'Current band'
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
          Caption = 'Fore...'
          TabOrder = 1
          OnClick = buttonPartialCheckForeColorClick
        end
        object buttonPartialCheckInitColor: TButton
          Left = 448
          Top = 20
          Width = 53
          Height = 20
          Caption = 'Reset'
          TabOrder = 3
          OnClick = buttonPartialCheckInitColorClick
        end
        object buttonPartialCheckBackColor: TButton
          Tag = 1
          Left = 327
          Top = 20
          Width = 53
          Height = 20
          Caption = 'Back...'
          TabOrder = 2
          OnClick = buttonPartialCheckBackColorClick
        end
      end
      object groupBasicSettings: TGroupBox
        Left = 6
        Top = 6
        Width = 512
        Height = 193
        Caption = 'Basic settings'
        TabOrder = 0
        object Label14: TLabel
          Left = 55
          Top = 64
          Width = 92
          Height = 13
          Caption = 'Time before closing'
        end
        object Label18: TLabel
          Left = 223
          Top = 64
          Width = 34
          Height = 13
          Caption = 'milisec.'
        end
        object cbDisplayDatePartialCheck: TCheckBox
          Left = 11
          Top = 18
          Width = 175
          Height = 17
          Caption = 'Display date in partial check'
          TabOrder = 0
        end
        object checkUseIncrementalDupeCheck: TCheckBox
          Left = 11
          Top = 41
          Width = 217
          Height = 17
          Caption = 'Use incremental dupe check'
          TabOrder = 1
        end
        object cbAutoEnterSuper: TCheckBox
          Left = 11
          Top = 87
          Width = 260
          Height = 17
          Caption = 'Automatically enter exchange from SuperCheck'
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
        Caption = 'Detail settings'
        TabOrder = 4
        object Label47: TLabel
          Left = 11
          Top = 18
          Width = 175
          Height = 13
          AutoSize = False
          Caption = 'Max super check search'
        end
        object Label48: TLabel
          Left = 11
          Top = 43
          Width = 175
          Height = 13
          AutoSize = False
          Caption = 'Delete band scope data after'
        end
        object Label49: TLabel
          Left = 244
          Top = 43
          Width = 16
          Height = 13
          Caption = 'min'
        end
        object Label52: TLabel
          Left = 11
          Top = 67
          Width = 175
          Height = 13
          AutoSize = False
          Caption = 'Delete spot data after'
        end
        object Label53: TLabel
          Left = 244
          Top = 67
          Width = 16
          Height = 13
          Caption = 'min'
        end
        object cbUpdateThread: TCheckBox
          Left = 11
          Top = 92
          Width = 175
          Height = 17
          Caption = 'Update using a thread'
          TabOrder = 3
        end
        object rgSearchAfter: TRadioGroup
          Left = 396
          Top = 16
          Width = 105
          Height = 89
          Caption = 'Start search after'
          ItemIndex = 0
          Items.Strings = (
            'one char'
            'two char'
            'three char')
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
      object GroupBox23: TSpinEdit
        Left = 6
        Top = 325
        Width = 423
        Height = 72
        Caption = 'Accessibility'
        TabOrder = 9
        object Label89: TSpinEdit
          Left = 15
          Top = 23
          Width = 68
          Height = 13
          Caption = 'Focused Color'
        end
        object editFocusedColor: TSpinEdit
          Left = 145
          Top = 20
          Width = 112
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'CALLSIGN'
        end
        object buttonFocusedBackColor: TSpinEdit
          Tag = 1
          Left = 318
          Top = 21
          Width = 45
          Height = 20
          Caption = 'Back...'
          TabOrder = 2
          OnClick = buttonFocusedBackColorClick
        end
        object buttonFocusedInitColor: TSpinEdit
          Left = 368
          Top = 21
          Width = 45
          Height = 20
          Caption = 'Reset'
          TabOrder = 3
          OnClick = buttonFocusedInitColorClick
        end
        object checkFocusedBold: TSpinEdit
          Left = 145
          Top = 46
          Width = 45
          Height = 22
          Caption = 'Bold'
          TabOrder = 4
          OnClick = checkFocusedBoldClick
        end
        object buttonFocusedForeColor: TSpinEdit
          Left = 268
          Top = 21
          Width = 45
          Height = 20
          Caption = 'Fore...'
          TabOrder = 1
          OnClick = buttonFocusedForeColorClick
        end
      end
    end
    object tabsheetQuickFunctions: TTabSheet
      Caption = 'Quick functions'
      ImageIndex = 8
      object groupQuickMemo: TGroupBox
        Left = 6
        Top = 284
        Width = 423
        Height = 109
        Caption = 'Quick memo'
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
        Caption = 'Quick QSY'
        TabOrder = 0
        object checkUseKhzQsyCommand: TCheckBox
          Left = 223
          Top = 247
          Width = 242
          Height = 17
          Caption = 'Use kHz QSY command (F/KC)'
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
          Items.ItemData = {050000000000000000}
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
          Caption = 'Add'
          TabOrder = 2
          OnClick = buttonFreqMemAddClick
        end
        object buttonFreqMemEdit: TButton
          Left = 71
          Top = 243
          Width = 59
          Height = 25
          Caption = 'Edit'
          TabOrder = 3
          OnClick = buttonFreqMemEditClick
        end
        object buttonFreqMemDelete: TButton
          Left = 136
          Top = 243
          Width = 59
          Height = 25
          Caption = 'Delete'
          TabOrder = 4
          OnClick = buttonFreqMemDeleteClick
        end
      end
    end
    object tabsheetBandScope1: TTabSheet
      Caption = 'BandScope'
      ImageIndex = 9
      object groupBandscopeBands: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 128
        Caption = 'Bands'
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
          Left = 12
          Top = 103
          Width = 60
          Height = 17
          Caption = '14 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object checkBs07: TCheckBox
          Left = 108
          Top = 18
          Width = 60
          Height = 17
          Caption = '21 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
        object checkBs09: TCheckBox
          Left = 109
          Top = 60
          Width = 67
          Height = 17
          Caption = '28 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 8
        end
        object checkBs10: TCheckBox
          Left = 109
          Top = 81
          Width = 67
          Height = 17
          Caption = '50 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 9
        end
        object checkBs11: TCheckBox
          Left = 109
          Top = 103
          Width = 67
          Height = 17
          Caption = '144 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 10
        end
        object checkBs12: TCheckBox
          Left = 205
          Top = 125
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
          Left = 206
          Top = 39
          Width = 67
          Height = 17
          Caption = '2400 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 13
        end
        object checkBs15: TCheckBox
          Left = 206
          Top = 60
          Width = 67
          Height = 17
          Caption = '5600 MHz'
          Checked = True
          State = cbChecked
          TabOrder = 14
        end
        object checkBs16: TCheckBox
          Left = 206
          Top = 81
          Width = 67
          Height = 17
          Caption = '10 G && up'
          Checked = True
          State = cbChecked
          TabOrder = 15
        end
        object checkBs08: TCheckBox
          Left = 109
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
          Top = 125
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
          Left = 399
          Top = 39
          Width = 90
          Height = 17
          Caption = 'Current'
          Checked = True
          State = cbChecked
          TabOrder = 17
        end
        object checkBsNewMulti: TCheckBox
          Left = 399
          Top = 60
          Width = 112
          Height = 17
          Caption = 'New Multi'
          Checked = True
          State = cbChecked
          TabOrder = 18
        end
        object checkBsAllBands: TCheckBox
          Left = 399
          Top = 18
          Width = 141
          Height = 17
          Caption = 'All bands'
          Checked = True
          State = cbChecked
          TabOrder = 16
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
        Top = 145
        Width = 423
        Height = 130
        Caption = 'Info. Colors'
        TabOrder = 1
        object Label57: TLabel
          Left = 12
          Top = 23
          Width = 38
          Height = 13
          Caption = 'Worked'
        end
        object Label58: TLabel
          Left = 12
          Top = 48
          Width = 63
          Height = 13
          Caption = 'Wanted Multi'
        end
        object Label59: TLabel
          Left = 12
          Top = 73
          Width = 63
          Height = 13
          Caption = 'Worked Multi'
        end
        object Label60: TLabel
          Left = 12
          Top = 98
          Width = 46
          Height = 13
          Caption = 'Unknown'
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
          Width = 45
          Height = 20
          Caption = 'Fore...'
          TabOrder = 1
          OnClick = buttonBSForeClick
        end
        object buttonBSReset1: TButton
          Tag = 1
          Left = 368
          Top = 20
          Width = 45
          Height = 20
          Caption = 'Reset'
          TabOrder = 4
          OnClick = buttonBSResetClick
        end
        object buttonBSBack1: TButton
          Tag = 1
          Left = 270
          Top = 21
          Width = 45
          Height = 20
          Caption = 'Back...'
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
          Width = 45
          Height = 20
          Caption = 'Fore...'
          TabOrder = 6
          OnClick = buttonBSForeClick
        end
        object buttonBSReset2: TButton
          Tag = 2
          Left = 368
          Top = 46
          Width = 45
          Height = 20
          Caption = 'Reset'
          TabOrder = 9
          OnClick = buttonBSResetClick
        end
        object buttonBSBack2: TButton
          Tag = 2
          Left = 270
          Top = 46
          Width = 45
          Height = 20
          Caption = 'Back...'
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
          Width = 45
          Height = 20
          Caption = 'Fore...'
          TabOrder = 11
          OnClick = buttonBSForeClick
        end
        object buttonBSReset3: TButton
          Tag = 3
          Left = 368
          Top = 71
          Width = 45
          Height = 20
          Caption = 'Reset'
          TabOrder = 14
          OnClick = buttonBSResetClick
        end
        object buttonBSBack3: TButton
          Tag = 3
          Left = 270
          Top = 71
          Width = 45
          Height = 20
          Caption = 'Back...'
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
          Width = 45
          Height = 20
          Caption = 'Fore...'
          TabOrder = 16
          OnClick = buttonBSForeClick
        end
        object buttonBSReset4: TButton
          Tag = 4
          Left = 368
          Top = 96
          Width = 45
          Height = 20
          Caption = 'Reset'
          TabOrder = 19
          OnClick = buttonBSResetClick
        end
        object buttonBSBack4: TButton
          Tag = 4
          Left = 270
          Top = 96
          Width = 45
          Height = 20
          Caption = 'Back...'
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
          Caption = 'Bold'
          TabOrder = 3
          OnClick = checkBSBoldClick
        end
        object checkBSBold2: TCheckBox
          Tag = 2
          Left = 321
          Top = 47
          Width = 41
          Height = 17
          Caption = 'Bold'
          TabOrder = 8
          OnClick = checkBSBoldClick
        end
        object checkBSBold3: TCheckBox
          Tag = 3
          Left = 321
          Top = 72
          Width = 41
          Height = 17
          Caption = 'Bold'
          TabOrder = 13
          OnClick = checkBSBoldClick
        end
        object checkBSBold4: TCheckBox
          Tag = 4
          Left = 321
          Top = 97
          Width = 41
          Height = 17
          Caption = 'Bold'
          TabOrder = 18
          OnClick = checkBSBoldClick
        end
      end
      object groupBandscopeOptions1: TGroupBox
        Left = 6
        Top = 281
        Width = 423
        Height = 112
        Caption = 'BandScope Options'
        TabOrder = 2
        object checkUseEstimatedMode: TCheckBox
          Left = 215
          Top = 17
          Width = 190
          Height = 17
          Caption = 'Use estimated mode by freq.'
          TabOrder = 5
          OnClick = checkUseEstimatedModeClick
        end
        object checkShowOnlyInBandplan: TCheckBox
          Left = 12
          Top = 17
          Width = 190
          Height = 17
          Caption = 'Show only spots in the band plan'
          TabOrder = 0
        end
        object checkShowJAspots: TCheckBox
          Left = 12
          Top = 40
          Width = 93
          Height = 17
          Caption = 'Show JA spots'
          TabOrder = 1
        end
        object checkUseLookupServer: TCheckBox
          Left = 12
          Top = 86
          Width = 165
          Height = 17
          Caption = 'Use lookup server'
          TabOrder = 4
        end
        object checkSetFreqAfterModeChange: TCheckBox
          Left = 226
          Top = 63
          Width = 157
          Height = 17
          Caption = 'Suppress freq. deviation'
          TabOrder = 7
        end
        object checkAlwaysChangeMode: TCheckBox
          Left = 226
          Top = 40
          Width = 176
          Height = 17
          Caption = 'Suppress LSB/USB mode error'
          TabOrder = 6
        end
        object checkSaveCurrentFreq: TCheckBox
          Left = 215
          Top = 86
          Width = 204
          Height = 17
          Caption = 'Save the freq. before QSY to Spot'
          TabOrder = 8
          OnClick = checkUseEstimatedModeClick
        end
        object checkShowDXspots: TCheckBox
          Left = 112
          Top = 40
          Width = 93
          Height = 17
          Caption = 'Show DX spots'
          TabOrder = 2
        end
        object checkUseNumberLookup: TCheckBox
          Left = 12
          Top = 63
          Width = 165
          Height = 17
          Caption = 'Use multi lookup'
          TabOrder = 3
          OnClick = checkUseNumberLookupClick
        end
        object checkUseResume: TCheckBox
          Left = 12
          Top = 109
          Width = 145
          Height = 17
          Caption = 'Use resume'
          TabOrder = 9
        end
      end
      object groupReliability: TGroupBox
        Left = 6
        Top = 445
        Width = 165
        Height = 58
        Caption = 'Initial reliability'
        TabOrder = 3
        object radioReliabilityHigh: TRadioButton
          Left = 12
          Top = 26
          Width = 74
          Height = 17
          Caption = 'High'
          TabOrder = 0
        end
        object radioReliabilityMiddle: TRadioButton
          Left = 84
          Top = 26
          Width = 74
          Height = 17
          Caption = 'Middle'
          TabOrder = 1
        end
      end
    end
    object tabsheetBandScope2: TTabSheet
      Caption = 'BandScope2'
      ImageIndex = 11
      object groupBandscopeSpotSource: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 141
        Caption = 'SpotSource Colors'
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
          Left = 317
          Top = 25
          Width = 45
          Height = 20
          Caption = 'Back...'
          TabOrder = 2
          OnClick = buttonBSBackClick
        end
        object buttonBSReset5: TButton
          Tag = 5
          Left = 368
          Top = 25
          Width = 45
          Height = 20
          Caption = 'Reset'
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
          Left = 317
          Top = 51
          Width = 45
          Height = 20
          Caption = 'Back...'
          TabOrder = 6
          OnClick = buttonBSBackClick
        end
        object buttonBSReset7: TButton
          Tag = 7
          Left = 368
          Top = 51
          Width = 45
          Height = 20
          Caption = 'Reset'
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
          TabOrder = 8
          Text = 'TEXT'
          StyleElements = [seFont, seBorder]
        end
        object buttonBSBack8: TButton
          Tag = 8
          Left = 317
          Top = 77
          Width = 45
          Height = 20
          Caption = 'Back...'
          TabOrder = 10
          OnClick = buttonBSBackClick
        end
        object buttonBSBack9: TButton
          Tag = 9
          Left = 317
          Top = 103
          Width = 45
          Height = 20
          Caption = 'Back...'
          TabOrder = 14
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
          TabOrder = 12
          Text = 'TEXT'
          StyleElements = [seFont, seBorder]
        end
        object buttonBSReset8: TButton
          Tag = 8
          Left = 368
          Top = 77
          Width = 45
          Height = 20
          Caption = 'Reset'
          TabOrder = 11
          OnClick = buttonBSResetClick
        end
        object buttonBSReset9: TButton
          Tag = 9
          Left = 368
          Top = 103
          Width = 45
          Height = 20
          Caption = 'Reset'
          TabOrder = 15
          OnClick = buttonBSResetClick
        end
        object checkUseReliability7: TCheckBox
          Left = 224
          Top = 52
          Width = 87
          Height = 17
          Caption = 'Use reliability'
          TabOrder = 5
        end
        object checkUseReliability8: TCheckBox
          Left = 224
          Top = 78
          Width = 87
          Height = 17
          Caption = 'Use reliability'
          TabOrder = 9
        end
        object checkUseReliability9: TCheckBox
          Left = 224
          Top = 104
          Width = 87
          Height = 17
          Caption = 'Use reliability'
          TabOrder = 13
        end
        object checkUseReliability5: TCheckBox
          Left = 224
          Top = 26
          Width = 87
          Height = 17
          Caption = 'Use reliability'
          TabOrder = 1
        end
      end
      object groupSpotFreshness: TGroupBox
        Left = 6
        Top = 271
        Width = 252
        Height = 121
        Caption = 'Spot Freshness'
        TabOrder = 2
        object radioFreshness1: TRadioButton
          Left = 16
          Top = 24
          Width = 197
          Height = 17
          Caption = 'Remain time1 (1/2,1/4,1/8,1/16 min.)'
          TabOrder = 0
        end
        object radioFreshness2: TRadioButton
          Left = 16
          Top = 47
          Width = 169
          Height = 17
          Caption = 'Remain time2 (5,10,20,30 min.)'
          TabOrder = 1
        end
        object radioFreshness3: TRadioButton
          Left = 16
          Top = 70
          Width = 121
          Height = 17
          Caption = 'Remain time3 (5 divs.)'
          TabOrder = 2
        end
        object radioFreshness4: TRadioButton
          Left = 16
          Top = 93
          Width = 169
          Height = 17
          Caption = 'Elapsed time (5,10,20,30 min.)'
          TabOrder = 3
        end
      end
      object groupBandscopeOptions2: TRadioButton
        Left = 264
        Top = 271
        Width = 165
        Height = 58
        Caption = 'Options2'
        TabOrder = 3
        object checkUseResume: TRadioButton
          Left = 12
          Top = 26
          Width = 145
          Height = 17
          Caption = 'Use resume'
          TabOrder = 0
        end
      end
      object groupBandscopeSpotReliability: TGroupBox
        Left = 6
        Top = 151
        Width = 423
        Height = 114
        Caption = 'Spot Reliability'
        TabOrder = 1
        object Label28: TLabel
          Left = 8
          Top = 27
          Width = 22
          Height = 13
          Caption = 'High'
        end
        object Label29: TLabel
          Left = 8
          Top = 54
          Width = 31
          Height = 13
          Caption = 'Middle'
        end
        object Label30: TLabel
          Left = 8
          Top = 81
          Width = 20
          Height = 13
          Caption = 'Low'
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
          Left = 317
          Top = 25
          Width = 45
          Height = 20
          Caption = 'Back...'
          TabOrder = 2
          OnClick = buttonBSBackClick
        end
        object buttonBSBackSrMiddle: TButton
          Tag = 14
          Left = 317
          Top = 52
          Width = 45
          Height = 20
          Caption = 'Back...'
          TabOrder = 6
          OnClick = buttonBSBackClick
        end
        object buttonBSBackSrLow: TButton
          Tag = 15
          Left = 317
          Top = 79
          Width = 45
          Height = 20
          Caption = 'Back...'
          TabOrder = 10
          OnClick = buttonBSBackClick
        end
        object buttonBSResetSrHigh: TButton
          Tag = 13
          Left = 368
          Top = 25
          Width = 45
          Height = 20
          Caption = 'Reset'
          TabOrder = 3
          OnClick = buttonBSResetClick
        end
        object buttonBSResetSrMiddle: TButton
          Tag = 14
          Left = 368
          Top = 52
          Width = 45
          Height = 20
          Caption = 'Reset'
          TabOrder = 7
          OnClick = buttonBSResetClick
        end
        object buttonBSResetSrLow: TButton
          Tag = 15
          Left = 368
          Top = 79
          Width = 45
          Height = 20
          Caption = 'Reset'
          TabOrder = 11
          OnClick = buttonBSResetClick
        end
        object checkTransparentSrHigh: TCheckBox
          Left = 224
          Top = 26
          Width = 87
          Height = 17
          Caption = 'Transparent'
          TabOrder = 1
        end
        object checkTransparentSrMiddle: TCheckBox
          Left = 224
          Top = 53
          Width = 87
          Height = 17
          Caption = 'Transparent'
          TabOrder = 5
        end
        object checkTransparentSrLow: TCheckBox
          Left = 224
          Top = 80
          Width = 87
          Height = 17
          Caption = 'Transparent'
          TabOrder = 9
        end
      end
      object groupReliability: TCheckBox
        Left = 264
        Top = 334
        Width = 165
        Height = 58
        Caption = 'Initial reliability'
        TabOrder = 4
        object radioReliabilityHigh: TCheckBox
          Left = 12
          Top = 26
          Width = 74
          Height = 17
          Caption = 'High'
          TabOrder = 0
        end
        object radioReliabilityMiddle: TCheckBox
          Left = 84
          Top = 26
          Width = 74
          Height = 17
          Caption = 'Middle'
          TabOrder = 1
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
      Caption = 'Cancel'
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
      Caption = 'Play'
      OnClick = menuVoicePlayClick
    end
    object menuVoiceStop: TMenuItem
      Caption = 'Stop'
      OnClick = menuVoiceStopClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object menuVoiceClear: TMenuItem
      Caption = 'Clear'
      OnClick = menuVoiceClearClick
    end
  end
end
