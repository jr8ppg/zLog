object formQSOListColumnSettings: TformQSOListColumnSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #20132#20449#12522#12473#12488#12398#12459#12521#12512#35373#23450
  ClientHeight = 481
  ClientWidth = 249
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 233
    Height = 437
    Caption = #12459#12521#12512#35373#23450
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 64
      Height = 13
      Caption = #12459#12521#12512#21517
    end
    object Label2: TLabel
      Left = 150
      Top = 19
      Width = 63
      Height = 13
      Caption = #12459#12521#12512#25991#23383#25968
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 40
      Width = 110
      Height = 17
      Caption = 'status'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 63
      Width = 110
      Height = 17
      Caption = 'date'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 86
      Width = 110
      Height = 17
      Caption = 'time'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 6
    end
    object CheckBox4: TCheckBox
      Left = 16
      Top = 109
      Width = 110
      Height = 17
      Caption = 'callsign'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 9
    end
    object CheckBox5: TCheckBox
      Left = 16
      Top = 132
      Width = 110
      Height = 17
      Caption = 'Sent RST'
      Checked = True
      State = cbChecked
      TabOrder = 12
    end
    object CheckBox6: TCheckBox
      Left = 16
      Top = 155
      Width = 110
      Height = 17
      Caption = 'Sent Number'
      Checked = True
      State = cbChecked
      TabOrder = 14
    end
    object CheckBox7: TCheckBox
      Left = 16
      Top = 178
      Width = 110
      Height = 17
      Caption = 'Rcvd RST'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 17
    end
    object CheckBox8: TCheckBox
      Left = 16
      Top = 201
      Width = 110
      Height = 17
      Caption = 'Rcvd Number'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 20
    end
    object CheckBox11: TCheckBox
      Left = 16
      Top = 270
      Width = 110
      Height = 17
      Caption = 'Band'
      Checked = True
      State = cbChecked
      TabOrder = 29
    end
    object CheckBox12: TCheckBox
      Left = 16
      Top = 293
      Width = 110
      Height = 17
      Caption = 'Mode'
      Checked = True
      State = cbChecked
      TabOrder = 32
    end
    object CheckBox13: TCheckBox
      Left = 16
      Top = 316
      Width = 110
      Height = 17
      Caption = 'Operator'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 35
    end
    object CheckBox14: TCheckBox
      Left = 16
      Top = 339
      Width = 110
      Height = 17
      Caption = 'Memo'
      Checked = True
      State = cbChecked
      TabOrder = 38
    end
    object CheckBox15: TCheckBox
      Left = 16
      Top = 362
      Width = 110
      Height = 17
      Caption = 'Point'
      Checked = True
      State = cbChecked
      TabOrder = 41
    end
    object CheckBox9: TCheckBox
      Left = 16
      Top = 224
      Width = 110
      Height = 17
      Caption = 'New multi1'
      Checked = True
      State = cbChecked
      TabOrder = 23
    end
    object CheckBox10: TCheckBox
      Left = 16
      Top = 247
      Width = 110
      Height = 17
      Caption = 'New multi2'
      TabOrder = 26
    end
    object CheckBox16: TCheckBox
      Left = 16
      Top = 385
      Width = 110
      Height = 17
      Caption = 'Freq.'
      Checked = True
      State = cbChecked
      TabOrder = 44
    end
    object CheckBox17: TCheckBox
      Left = 16
      Top = 408
      Width = 110
      Height = 17
      Caption = 'QSOID'
      TabOrder = 47
    end
    object Edit1: TEdit
      Left = 163
      Top = 38
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 1
      Text = '3'
    end
    object UpDown1: TUpDown
      Left = 193
      Top = 38
      Width = 16
      Height = 21
      Associate = Edit1
      Min = 1
      Max = 99
      Position = 3
      TabOrder = 2
    end
    object Edit2: TEdit
      Left = 163
      Top = 61
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 4
      Text = '6'
    end
    object UpDown2: TUpDown
      Left = 193
      Top = 61
      Width = 16
      Height = 21
      Associate = Edit2
      Min = 1
      Max = 99
      Position = 6
      TabOrder = 5
    end
    object Edit3: TEdit
      Left = 163
      Top = 84
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 7
      Text = '6'
    end
    object UpDown3: TUpDown
      Left = 193
      Top = 84
      Width = 16
      Height = 21
      Associate = Edit3
      Min = 1
      Max = 99
      Position = 6
      TabOrder = 8
    end
    object Edit5: TEdit
      Left = 163
      Top = 130
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 13
      Text = '4'
    end
    object UpDown5: TUpDown
      Left = 193
      Top = 130
      Width = 16
      Height = 21
      Associate = Edit5
      Min = 1
      Max = 99
      Position = 4
      TabOrder = 50
    end
    object Edit6: TEdit
      Left = 163
      Top = 153
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 15
      Text = '6'
    end
    object UpDown6: TUpDown
      Left = 193
      Top = 153
      Width = 16
      Height = 21
      Associate = Edit6
      Min = 1
      Max = 99
      Position = 6
      TabOrder = 16
    end
    object Edit7: TEdit
      Left = 163
      Top = 176
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 18
      Text = '4'
    end
    object UpDown7: TUpDown
      Left = 193
      Top = 176
      Width = 16
      Height = 21
      Associate = Edit7
      Min = 1
      Max = 99
      Position = 4
      TabOrder = 19
    end
    object Edit8: TEdit
      Left = 163
      Top = 199
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 21
      Text = '10'
    end
    object UpDown8: TUpDown
      Left = 193
      Top = 199
      Width = 16
      Height = 21
      Associate = Edit8
      Min = 1
      Max = 99
      Position = 10
      TabOrder = 22
    end
    object Edit11: TEdit
      Left = 163
      Top = 268
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 30
      Text = '4'
    end
    object UpDown11: TUpDown
      Left = 193
      Top = 268
      Width = 16
      Height = 21
      Associate = Edit11
      Min = 1
      Max = 99
      Position = 4
      TabOrder = 31
    end
    object Edit12: TEdit
      Left = 163
      Top = 291
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 33
      Text = '4'
    end
    object UpDown12: TUpDown
      Left = 193
      Top = 291
      Width = 16
      Height = 21
      Associate = Edit12
      Min = 1
      Max = 99
      Position = 4
      TabOrder = 34
    end
    object Edit13: TEdit
      Left = 163
      Top = 314
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 36
      Text = '6'
    end
    object UpDown13: TUpDown
      Left = 193
      Top = 314
      Width = 16
      Height = 21
      Associate = Edit13
      Min = 1
      Max = 99
      Position = 6
      TabOrder = 37
    end
    object Edit14: TEdit
      Left = 163
      Top = 337
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 39
      Text = '7'
    end
    object UpDown14: TUpDown
      Left = 193
      Top = 337
      Width = 16
      Height = 21
      Associate = Edit14
      Min = 1
      Max = 99
      Position = 7
      TabOrder = 40
    end
    object Edit15: TEdit
      Left = 163
      Top = 360
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 42
      Text = '4'
    end
    object UpDown15: TUpDown
      Left = 193
      Top = 360
      Width = 16
      Height = 21
      Associate = Edit15
      Min = 1
      Max = 99
      Position = 4
      TabOrder = 43
    end
    object Edit9: TEdit
      Left = 163
      Top = 222
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 24
      Text = '3'
    end
    object UpDown9: TUpDown
      Left = 193
      Top = 222
      Width = 16
      Height = 21
      Associate = Edit9
      Min = 1
      Max = 99
      Position = 3
      TabOrder = 25
    end
    object Edit10: TEdit
      Left = 163
      Top = 245
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 27
      Text = '3'
    end
    object UpDown10: TUpDown
      Left = 193
      Top = 245
      Width = 16
      Height = 21
      Associate = Edit10
      Min = 1
      Max = 99
      Position = 3
      TabOrder = 28
    end
    object Edit16: TEdit
      Left = 163
      Top = 383
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 45
      Text = '10'
    end
    object UpDown16: TUpDown
      Left = 193
      Top = 383
      Width = 16
      Height = 21
      Associate = Edit16
      Min = 1
      Max = 99
      Position = 10
      TabOrder = 46
    end
    object Edit17: TEdit
      Left = 163
      Top = 406
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 48
      Text = '10'
    end
    object UpDown17: TUpDown
      Left = 193
      Top = 406
      Width = 16
      Height = 21
      Associate = Edit17
      Min = 1
      Max = 99
      Position = 10
      TabOrder = 49
    end
    object Edit4: TEdit
      Left = 163
      Top = 107
      Width = 30
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 10
      Text = '12'
    end
    object UpDown4: TUpDown
      Left = 193
      Top = 107
      Width = 16
      Height = 21
      Associate = Edit4
      Min = 1
      Max = 99
      Position = 12
      TabOrder = 11
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 449
    Width = 249
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      249
      32)
    object buttonOK: TButton
      Left = 55
      Top = 2
      Width = 70
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object buttonCancel: TButton
      Left = 133
      Top = 2
      Width = 70
      Height = 25
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
    end
  end
end
