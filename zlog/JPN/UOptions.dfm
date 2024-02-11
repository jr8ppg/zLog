object formOptions: TformOptions
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
    ActivePage = tabsheetOperateStyle
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 440
    ExplicitHeight = 433
    object tabsheetOperateStyle: TTabSheet
      Caption = #36939#29992#12473#12479#12452#12523
      ImageIndex = 7
      object groupSo2rSupport: TGroupBox
        Left = 6
        Top = 139
        Width = 423
        Height = 258
        Caption = 'SO2R options'
        TabOrder = 1
        object Label115: TLabel
          Left = 20
          Top = 229
          Width = 210
          Height = 13
          Caption = 'TAB'#12461#12540#25276#19979#24460#12289'CW'#36895#24230#12434#21152#36895#12377#12427
        end
        object Label116: TLabel
          Left = 314
          Top = 229
          Width = 27
          Height = 13
          Caption = 'WPM'
        end
        object GroupBox7: TGroupBox
          Left = 8
          Top = 20
          Width = 405
          Height = 109
          Caption = #12522#12464#36984#25246
          TabOrder = 0
          object GroupBox6: TGroupBox
            Left = 187
            Top = 13
            Width = 206
            Height = 84
            Caption = #20986#21147#12509#12540#12488
            TabOrder = 3
            object Label31: TLabel
              Left = 12
              Top = 23
              Width = 14
              Height = 13
              Caption = 'TX'
            end
            object Label42: TLabel
              Left = 107
              Top = 23
              Width = 15
              Height = 13
              Caption = 'RX'
            end
            object Label3: TLabel
              Left = 12
              Top = 55
              Width = 49
              Height = 13
              Caption = 'TX=RIG-C'
            end
            object comboSo2rRxSelectPort: TComboBox
              Left = 127
              Top = 20
              Width = 64
              Height = 21
              Style = csDropDownList
              TabOrder = 1
            end
            object comboSo2rTxSelectPort: TComboBox
              Left = 32
              Top = 20
              Width = 64
              Height = 21
              Style = csDropDownList
              TabOrder = 0
            end
            object comboSo2rTxRigC: TComboBox
              Left = 78
              Top = 52
              Width = 81
              Height = 21
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 2
              Text = 'Normal'
              Items.Strings = (
                'Normal'
                'RIG-A'
                'RIG-B')
            end
          end
          object radioSo2rNeo: TRadioButton
            Tag = 2
            Left = 12
            Top = 73
            Width = 85
            Height = 17
            Caption = 'SO2R Neo'
            TabOrder = 2
            OnClick = radioSo2rClick
          end
          object radioSo2rNone: TRadioButton
            Left = 12
            Top = 23
            Width = 46
            Height = 17
            Caption = 'None'
            Checked = True
            TabOrder = 0
            TabStop = True
            OnClick = radioSo2rClick
          end
          object radioSo2rCom: TRadioButton
            Tag = 1
            Left = 12
            Top = 48
            Width = 69
            Height = 17
            Caption = 'COM Port'
            TabOrder = 1
            OnClick = radioSo2rClick
          end
        end
        object groupSo2rCqOption: TGroupBox
          Left = 8
          Top = 135
          Width = 405
          Height = 82
          Caption = #33258#21205#12522#12464#20999#26367#12458#12503#12471#12519#12531
          TabOrder = 1
          object Label44: TLabel
            Left = 12
            Top = 23
            Width = 96
            Height = 13
            Caption = 'CQ'#32368#12426#36820#12375#38291#38548'('#31186')'
          end
          object Label100: TLabel
            Left = 12
            Top = 51
            Width = 83
            Height = 13
            Caption = #12513#12483#12475#12540#12472#30058#21495
          end
          object Label101: TLabel
            Left = 187
            Top = 23
            Width = 71
            Height = 13
            Caption = #20999#26367#24460#12487#12451#12524#12452'('#31186')'
          end
          object editSo2rCqRptIntervalSec: TEdit
            Left = 127
            Top = 20
            Width = 41
            Height = 21
            ImeMode = imDisable
            MaxLength = 5
            TabOrder = 0
            Text = '2.0'
            OnKeyPress = NumberEditKeyPress
          end
          object panelSo2rMessageNumber: TPanel
            Left = 116
            Top = 46
            Width = 253
            Height = 23
            BevelOuter = bvNone
            TabOrder = 2
            object radioSo2rCqMsgBankA: TRadioButton
              Left = 12
              Top = 4
              Width = 66
              Height = 17
              Caption = 'Bank-A'
              Checked = True
              TabOrder = 0
              TabStop = True
            end
            object radioSo2rCqMsgBankB: TRadioButton
              Left = 84
              Top = 4
              Width = 66
              Height = 17
              Caption = 'Bank-B'
              TabOrder = 1
            end
            object comboSo2rCqMsgNumber: TComboBox
              Left = 168
              Top = 2
              Width = 37
              Height = 21
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 2
              Text = '1'
              Items.Strings = (
                '1'
                '2'
                '3'
                '4'
                '5'
                '6'
                '7'
                '8'
                '9'
                '10'
                '11'
                '12')
            end
          end
          object editSo2rRigSwAfterDelay: TEdit
            Left = 284
            Top = 20
            Width = 41
            Height = 21
            ImeMode = imDisable
            MaxLength = 4
            TabOrder = 1
            Text = '200'
            OnKeyPress = NumberEditKeyPress
          end
        end
        object spinSo2rAccelerateCW: TSpinEdit
          Left = 272
          Top = 226
          Width = 34
          Height = 22
          MaxValue = 9
          MinValue = 0
          TabOrder = 2
          Value = 3
        end
      end
      object GroupBox1: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 129
        Caption = #36939#29992#12473#12479#12452#12523
        TabOrder = 0
        object Label1: TLabel
          Left = 92
          Top = 28
          Width = 222
          Height = 30
          AutoSize = False
          Caption = #12463#12521#12471#12483#12463#12473#12479#12452#12523#65288'Single OP one radio, 2TX, Multi-TX'#12398#22580#21512#12395#36984#25246#65289
          WordWrap = True
        end
        object Label2: TLabel
          Left = 92
          Top = 75
          Width = 313
          Height = 30
          AutoSize = False
          Caption = '2Radio'#29992#20837#21147#27396#24038#21491#37197#32622
          WordWrap = True
        end
        object radio1Radio: TRadioButton
          Left = 13
          Top = 32
          Width = 58
          Height = 17
          Caption = '1Radio'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object radio2Radio: TRadioButton
          Left = 13
          Top = 79
          Width = 58
          Height = 17
          Caption = '2Radio'
          TabOrder = 1
        end
      end
    end
    object tabsheetHardware1: TTabSheet
      Caption = #12495#12540#12489#12454#12455#12450'1'
      object groupRig5: TGroupBox
        Left = 6
        Top = 324
        Width = 423
        Height = 78
        Caption = 'RIG-5'
        TabOrder = 4
        object Label99: TLabel
          Left = 282
          Top = 13
          Width = 39
          Height = 13
          Caption = #12461#12540#12452#12531#12464
        end
        object comboRig5Keying: TComboBox
          Tag = 5
          Left = 278
          Top = 27
          Width = 64
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnChange = comboCwPttPortChange
        end
        object buttonPortConfigCW5: TButton
          Tag = 5
          Left = 278
          Top = 50
          Width = 64
          Height = 22
          Caption = #35373#23450
          TabOrder = 1
          OnClick = buttonPortConfigCWClick
        end
      end
      object groupRig2: TGroupBox
        Left = 6
        Top = 84
        Width = 423
        Height = 78
        Caption = 'RIG-2'
        TabOrder = 1
        object Label120: TLabel
          Left = 156
          Top = 13
          Width = 16
          Height = 13
          Caption = #12522#12464
        end
        object Label121: TLabel
          Left = 15
          Top = 13
          Width = 54
          Height = 13
          Caption = #12522#12464#21046#24481
        end
        object Label122: TLabel
          Left = 88
          Top = 13
          Width = 31
          Height = 13
          Caption = #36890#20449#36895#24230
        end
        object Label123: TLabel
          Left = 282
          Top = 13
          Width = 39
          Height = 13
          Caption = #12461#12540#12452#12531#12464
        end
        object checkRig2Xvt: TCheckBox
          Tag = 2
          Left = 351
          Top = 29
          Width = 41
          Height = 17
          Hint = 'Check here if you are using a transverter'
          Caption = 'XVT'
          TabOrder = 7
          OnClick = checkRigXvtClick
        end
        object comboRig2Name: TComboBox
          Left = 152
          Top = 27
          Width = 120
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          TabOrder = 3
          OnChange = comboRig3NameChange
        end
        object comboRig2Control: TComboBox
          Tag = 2
          Left = 11
          Top = 27
          Width = 64
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnChange = comboRigControlChange
        end
        object comboRig2Speed: TComboBox
          Left = 81
          Top = 27
          Width = 65
          Height = 21
          Style = csDropDownList
          TabOrder = 2
          Items.Strings = (
            '300'
            '1200'
            '2400'
            '4800'
            '9600'
            '19200'
            '38400'
            '56000'
            '57600'
            '115200'
            '128000'
            '256000')
        end
        object comboRig2Keying: TComboBox
          Tag = 2
          Left = 278
          Top = 27
          Width = 64
          Height = 21
          Style = csDropDownList
          TabOrder = 5
          OnChange = comboCwPttPortChange
        end
        object buttonPortConfigCW2: TButton
          Tag = 2
          Left = 278
          Top = 50
          Width = 64
          Height = 22
          Caption = #35373#23450
          TabOrder = 6
          OnClick = buttonPortConfigCWClick
        end
        object buttonRig2PortConfig: TButton
          Tag = 2
          Left = 11
          Top = 50
          Width = 64
          Height = 22
          Caption = #35373#23450
          TabOrder = 1
          OnClick = buttonPortConfigRigClick
        end
        object buttonXvtConfig2: TButton
          Tag = 2
          Left = 351
          Top = 50
          Width = 64
          Height = 22
          Caption = #35373#23450
          TabOrder = 8
          OnClick = buttonXvtConfigClick
        end
        object checkRig2ChangePTT: TCheckBox
          Tag = 2
          Left = 119
          Top = 52
          Width = 153
          Height = 17
          Caption = 'PH'#26178#12289'KEY'#12434'PTT'#12392#12377#12427
          TabOrder = 4
        end
      end
      object groupRig1: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 78
        Caption = 'RIG-1'
        TabOrder = 0
        object Label43: TLabel
          Left = 156
          Top = 13
          Width = 16
          Height = 13
          Caption = #12522#12464
        end
        object Label92: TLabel
          Left = 15
          Top = 13
          Width = 54
          Height = 13
          Caption = #12522#12464#21046#24481
        end
        object Label93: TLabel
          Left = 88
          Top = 13
          Width = 31
          Height = 13
          Caption = #36890#20449#36895#24230
        end
        object Label94: TLabel
          Left = 282
          Top = 13
          Width = 39
          Height = 13
          Caption = #12461#12540#12452#12531#12464
        end
        object comboRig1Name: TComboBox
          Left = 152
          Top = 27
          Width = 120
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          TabOrder = 3
          OnChange = comboRig1NameChange
        end
        object comboRig1Control: TComboBox
          Tag = 1
          Left = 11
          Top = 27
          Width = 64
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnChange = comboRigControlChange
        end
        object comboRig1Speed: TComboBox
          Left = 81
          Top = 27
          Width = 65
          Height = 21
          Style = csDropDownList
          TabOrder = 2
          Items.Strings = (
            '300'
            '1200'
            '2400'
            '4800'
            '9600'
            '19200'
            '38400'
            '56000'
            '57600'
            '115200'
            '128000'
            '256000')
        end
        object comboRig1Keying: TComboBox
          Tag = 1
          Left = 278
          Top = 27
          Width = 64
          Height = 21
          Style = csDropDownList
          TabOrder = 5
          OnChange = comboCwPttPortChange
        end
        object checkRig1Xvt: TCheckBox
          Tag = 1
          Left = 351
          Top = 29
          Width = 41
          Height = 17
          Hint = 'Check here if you are using a transverter'
          Caption = 'XVT'
          TabOrder = 7
          OnClick = checkRigXvtClick
        end
        object buttonRig1PortConfig: TButton
          Tag = 1
          Left = 11
          Top = 50
          Width = 64
          Height = 22
          Caption = #35373#23450
          TabOrder = 1
          OnClick = buttonPortConfigRigClick
        end
        object buttonPortConfigCW1: TButton
          Tag = 1
          Left = 278
          Top = 50
          Width = 64
          Height = 22
          Caption = #35373#23450
          TabOrder = 6
          OnClick = buttonPortConfigCWClick
        end
        object buttonXvtConfig1: TButton
          Tag = 1
          Left = 351
          Top = 50
          Width = 64
          Height = 22
          Caption = #35373#23450
          TabOrder = 8
          OnClick = buttonXvtConfigClick
        end
        object checkRig1ChangePTT: TCheckBox
          Tag = 1
          Left = 119
          Top = 52
          Width = 153
          Height = 17
          Caption = 'PH'#26178#12289'KEY'#12434'PTT'#12392#12377#12427
          TabOrder = 4
        end
      end
      object groupRig4: TGroupBox
        Left = 6
        Top = 244
        Width = 423
        Height = 78
        Caption = 'RIG-4'
        TabOrder = 3
        object Label124: TLabel
          Left = 156
          Top = 13
          Width = 16
          Height = 13
          Caption = #12522#12464
        end
        object Label125: TLabel
          Left = 15
          Top = 13
          Width = 54
          Height = 13
          Caption = #12522#12464#21046#24481
        end
        object Label126: TLabel
          Left = 88
          Top = 13
          Width = 31
          Height = 13
          Caption = #36890#20449#36895#24230
        end
        object Label127: TLabel
          Left = 282
          Top = 13
          Width = 39
          Height = 13
          Caption = #12461#12540#12452#12531#12464
        end
        object checkRig4Xvt: TCheckBox
          Tag = 4
          Left = 351
          Top = 29
          Width = 41
          Height = 17
          Hint = 'Check here if you are using a transverter'
          Caption = 'XVT'
          TabOrder = 7
          OnClick = checkRigXvtClick
        end
        object comboRig4Name: TComboBox
          Left = 152
          Top = 27
          Width = 120
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          TabOrder = 3
          OnChange = comboRig3NameChange
        end
        object comboRig4Control: TComboBox
          Tag = 4
          Left = 11
          Top = 27
          Width = 64
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnChange = comboRigControlChange
        end
        object comboRig4Speed: TComboBox
          Left = 81
          Top = 27
          Width = 65
          Height = 21
          Style = csDropDownList
          TabOrder = 2
          Items.Strings = (
            '300'
            '1200'
            '2400'
            '4800'
            '9600'
            '19200'
            '38400'
            '56000'
            '57600'
            '115200'
            '128000'
            '256000')
        end
        object comboRig4Keying: TComboBox
          Tag = 4
          Left = 278
          Top = 27
          Width = 64
          Height = 21
          Style = csDropDownList
          TabOrder = 5
          OnChange = comboCwPttPortChange
        end
        object buttonPortConfigCW4: TButton
          Tag = 4
          Left = 278
          Top = 50
          Width = 64
          Height = 22
          Caption = #35373#23450
          TabOrder = 6
          OnClick = buttonPortConfigCWClick
        end
        object buttonRig4PortConfig: TButton
          Tag = 4
          Left = 11
          Top = 50
          Width = 64
          Height = 22
          Caption = #35373#23450
          TabOrder = 1
          OnClick = buttonPortConfigRigClick
        end
        object buttonXvtConfig4: TButton
          Tag = 4
          Left = 351
          Top = 50
          Width = 64
          Height = 22
          Caption = #35373#23450
          TabOrder = 8
          OnClick = buttonXvtConfigClick
        end
        object checkRig4ChangePTT: TCheckBox
          Tag = 4
          Left = 119
          Top = 52
          Width = 153
          Height = 17
          Caption = 'PH'#26178#12289'KEY'#12434'PTT'#12392#12377#12427
          TabOrder = 4
        end
      end
      object groupRig3: TGroupBox
        Left = 6
        Top = 164
        Width = 423
        Height = 78
        Caption = 'RIG-3'
        TabOrder = 2
        object Label95: TLabel
          Left = 156
          Top = 13
          Width = 16
          Height = 13
          Caption = #12522#12464
        end
        object Label96: TLabel
          Left = 15
          Top = 13
          Width = 54
          Height = 13
          Caption = #12522#12464#21046#24481
        end
        object Label97: TLabel
          Left = 88
          Top = 13
          Width = 31
          Height = 13
          Caption = #36890#20449#36895#24230
        end
        object Label98: TLabel
          Left = 282
          Top = 13
          Width = 39
          Height = 13
          Caption = #12461#12540#12452#12531#12464
        end
        object checkRig3Xvt: TCheckBox
          Tag = 3
          Left = 351
          Top = 29
          Width = 41
          Height = 17
          Hint = 'Check here if you are using a transverter'
          Caption = 'XVT'
          TabOrder = 7
          OnClick = checkRigXvtClick
        end
        object comboRig3Name: TComboBox
          Left = 152
          Top = 27
          Width = 120
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          TabOrder = 3
          OnChange = comboRig3NameChange
        end
        object comboRig3Control: TComboBox
          Tag = 3
          Left = 11
          Top = 27
          Width = 64
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnChange = comboRigControlChange
        end
        object comboRig3Speed: TComboBox
          Left = 81
          Top = 27
          Width = 65
          Height = 21
          Style = csDropDownList
          TabOrder = 2
          Items.Strings = (
            '300'
            '1200'
            '2400'
            '4800'
            '9600'
            '19200'
            '38400'
            '56000'
            '57600'
            '115200'
            '128000'
            '256000')
        end
        object comboRig3Keying: TComboBox
          Tag = 3
          Left = 278
          Top = 27
          Width = 64
          Height = 21
          Style = csDropDownList
          TabOrder = 5
          OnChange = comboCwPttPortChange
        end
        object buttonPortConfigCW3: TButton
          Tag = 3
          Left = 278
          Top = 50
          Width = 64
          Height = 22
          Caption = #35373#23450
          TabOrder = 6
          OnClick = buttonPortConfigCWClick
        end
        object buttonRig3PortConfig: TButton
          Tag = 3
          Left = 11
          Top = 50
          Width = 64
          Height = 22
          Caption = #35373#23450
          TabOrder = 1
          OnClick = buttonPortConfigRigClick
        end
        object buttonXvtConfig3: TButton
          Tag = 3
          Left = 351
          Top = 50
          Width = 64
          Height = 22
          Caption = #35373#23450
          TabOrder = 8
          OnClick = buttonXvtConfigClick
        end
        object checkRig3ChangePTT: TCheckBox
          Tag = 3
          Left = 119
          Top = 52
          Width = 153
          Height = 17
          Caption = 'PH'#26178#12289'KEY'#12434'PTT'#12392#12377#12427
          TabOrder = 4
        end
      end
    end
    object tabsheetHardware2: TTabSheet
      Caption = #12495#12540#12489#12454#12455#12450'2'
      ImageIndex = 15
      object groupRigSetA: TGroupBox
        Left = 6
        Top = 4
        Width = 200
        Height = 393
        Caption = 'RIG-A'#12408#12398#12522#12464#21106#24403
        TabOrder = 0
        object Label128: TLabel
          Left = 16
          Top = 42
          Width = 40
          Height = 13
          Caption = '1.9 MHz'
        end
        object Label129: TLabel
          Left = 16
          Top = 63
          Width = 40
          Height = 13
          Caption = '3.5 MHz'
        end
        object Label130: TLabel
          Left = 25
          Top = 84
          Width = 31
          Height = 13
          Caption = '7 MHz'
        end
        object Label131: TLabel
          Left = 19
          Top = 105
          Width = 37
          Height = 13
          Caption = '10 MHz'
        end
        object Label132: TLabel
          Left = 19
          Top = 126
          Width = 37
          Height = 13
          Caption = '14 MHz'
        end
        object Label133: TLabel
          Left = 19
          Top = 147
          Width = 37
          Height = 13
          Caption = '18 MHz'
        end
        object Label134: TLabel
          Left = 19
          Top = 168
          Width = 37
          Height = 13
          Caption = '21 MHz'
        end
        object Label135: TLabel
          Left = 19
          Top = 189
          Width = 37
          Height = 13
          Caption = '24 MHz'
        end
        object Label136: TLabel
          Left = 19
          Top = 210
          Width = 37
          Height = 13
          Caption = '28 MHz'
        end
        object Label137: TLabel
          Left = 19
          Top = 231
          Width = 37
          Height = 13
          Caption = '50 MHz'
        end
        object Label138: TLabel
          Left = 13
          Top = 252
          Width = 43
          Height = 13
          Caption = '144 MHz'
        end
        object Label139: TLabel
          Left = 13
          Top = 273
          Width = 43
          Height = 13
          Caption = '430 MHz'
        end
        object Label140: TLabel
          Left = 7
          Top = 294
          Width = 49
          Height = 13
          Caption = '1200 MHz'
        end
        object Label141: TLabel
          Left = 7
          Top = 315
          Width = 49
          Height = 13
          Caption = '2400 MHz'
        end
        object Label142: TLabel
          Left = 7
          Top = 336
          Width = 49
          Height = 13
          Caption = '5600 MHz'
        end
        object Label143: TLabel
          Left = 9
          Top = 357
          Width = 47
          Height = 13
          Caption = '10 G && up'
        end
        object Label104: TLabel
          Left = 80
          Top = 20
          Width = 19
          Height = 13
          Caption = #12522#12464
        end
        object Label105: TLabel
          Left = 141
          Top = 20
          Width = 40
          Height = 13
          Caption = #12450#12531#12486#12490
        end
        object comboRigA_b19: TComboBox
          Left = 66
          Top = 39
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 0
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b35: TComboBox
          Tag = 1
          Left = 66
          Top = 60
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 1
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b7: TComboBox
          Tag = 2
          Left = 66
          Top = 81
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 2
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b10: TComboBox
          Tag = 3
          Left = 66
          Top = 102
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 3
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b14: TComboBox
          Tag = 4
          Left = 66
          Top = 123
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 4
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b18: TComboBox
          Tag = 5
          Left = 66
          Top = 144
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 5
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b21: TComboBox
          Tag = 6
          Left = 66
          Top = 165
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 6
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b24: TComboBox
          Tag = 7
          Left = 66
          Top = 186
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 7
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b28: TComboBox
          Tag = 8
          Left = 66
          Top = 207
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 8
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b50: TComboBox
          Tag = 9
          Left = 66
          Top = 228
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 9
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b144: TComboBox
          Tag = 10
          Left = 66
          Top = 249
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 10
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b430: TComboBox
          Tag = 11
          Left = 66
          Top = 270
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 11
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b1200: TComboBox
          Tag = 12
          Left = 66
          Top = 291
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 12
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b2400: TComboBox
          Tag = 13
          Left = 66
          Top = 312
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 13
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b5600: TComboBox
          Tag = 14
          Left = 66
          Top = 333
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 14
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_b10g: TComboBox
          Tag = 15
          Left = 66
          Top = 354
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 15
          Text = 'None'
          OnChange = comboRigA_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigA_Antb19: TComboBox
          Left = 135
          Top = 39
          Width = 54
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 16
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb35: TComboBox
          Tag = 1
          Left = 135
          Top = 60
          Width = 54
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 17
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb7: TComboBox
          Tag = 2
          Left = 135
          Top = 81
          Width = 54
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 18
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb10: TComboBox
          Tag = 3
          Left = 135
          Top = 102
          Width = 54
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 19
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb14: TComboBox
          Tag = 4
          Left = 135
          Top = 123
          Width = 54
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 20
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb18: TComboBox
          Tag = 5
          Left = 135
          Top = 144
          Width = 54
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 21
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb21: TComboBox
          Tag = 6
          Left = 135
          Top = 165
          Width = 54
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 22
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb24: TComboBox
          Tag = 7
          Left = 135
          Top = 186
          Width = 54
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 23
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb28: TComboBox
          Tag = 8
          Left = 135
          Top = 207
          Width = 54
          Height = 21
          ItemIndex = 0
          TabOrder = 24
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb50: TComboBox
          Tag = 9
          Left = 135
          Top = 228
          Width = 54
          Height = 21
          ItemIndex = 0
          TabOrder = 25
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb144: TComboBox
          Tag = 10
          Left = 135
          Top = 249
          Width = 54
          Height = 21
          ItemIndex = 0
          TabOrder = 26
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb430: TComboBox
          Tag = 11
          Left = 135
          Top = 270
          Width = 54
          Height = 21
          ItemIndex = 0
          TabOrder = 27
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb1200: TComboBox
          Tag = 12
          Left = 135
          Top = 291
          Width = 54
          Height = 21
          ItemIndex = 0
          TabOrder = 28
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb2400: TComboBox
          Tag = 13
          Left = 135
          Top = 312
          Width = 54
          Height = 21
          ItemIndex = 0
          TabOrder = 29
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb5600: TComboBox
          Tag = 14
          Left = 135
          Top = 333
          Width = 54
          Height = 21
          ItemIndex = 0
          TabOrder = 30
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigA_Antb10g: TComboBox
          Tag = 15
          Left = 135
          Top = 354
          Width = 54
          Height = 21
          ItemIndex = 0
          TabOrder = 31
          Text = 'None'
          OnChange = comboRigA_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
      end
      object groupRigSetB: TGroupBox
        Left = 225
        Top = 4
        Width = 200
        Height = 393
        Caption = 'RIG-B'#12408#12398#12522#12464#21106#24403
        TabOrder = 1
        object Label144: TLabel
          Left = 16
          Top = 42
          Width = 40
          Height = 13
          Caption = '1.9 MHz'
        end
        object Label145: TLabel
          Left = 16
          Top = 63
          Width = 40
          Height = 13
          Caption = '3.5 MHz'
        end
        object Label146: TLabel
          Left = 25
          Top = 84
          Width = 31
          Height = 13
          Caption = '7 MHz'
        end
        object Label147: TLabel
          Left = 19
          Top = 105
          Width = 37
          Height = 13
          Caption = '10 MHz'
        end
        object Label148: TLabel
          Left = 19
          Top = 126
          Width = 37
          Height = 13
          Caption = '14 MHz'
        end
        object Label149: TLabel
          Left = 19
          Top = 147
          Width = 37
          Height = 13
          Caption = '18 MHz'
        end
        object Label150: TLabel
          Left = 19
          Top = 168
          Width = 37
          Height = 13
          Caption = '21 MHz'
        end
        object Label151: TLabel
          Left = 19
          Top = 189
          Width = 37
          Height = 13
          Caption = '24 MHz'
        end
        object Label152: TLabel
          Left = 19
          Top = 210
          Width = 37
          Height = 13
          Caption = '28 MHz'
        end
        object Label153: TLabel
          Left = 19
          Top = 231
          Width = 37
          Height = 13
          Caption = '50 MHz'
        end
        object Label154: TLabel
          Left = 13
          Top = 252
          Width = 43
          Height = 13
          Caption = '144 MHz'
        end
        object Label155: TLabel
          Left = 13
          Top = 273
          Width = 43
          Height = 13
          Caption = '430 MHz'
        end
        object Label156: TLabel
          Left = 7
          Top = 294
          Width = 49
          Height = 13
          Caption = '1200 MHz'
        end
        object Label157: TLabel
          Left = 7
          Top = 315
          Width = 49
          Height = 13
          Caption = '2400 MHz'
        end
        object Label158: TLabel
          Left = 7
          Top = 336
          Width = 49
          Height = 13
          Caption = '5600 MHz'
        end
        object Label159: TLabel
          Left = 9
          Top = 357
          Width = 47
          Height = 13
          Caption = '10 G && up'
        end
        object Label106: TLabel
          Left = 142
          Top = 20
          Width = 40
          Height = 13
          Caption = #12450#12531#12486#12490
        end
        object Label107: TLabel
          Left = 81
          Top = 20
          Width = 19
          Height = 13
          Caption = #12522#12464
        end
        object comboRigB_b19: TComboBox
          Left = 66
          Top = 39
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 0
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b35: TComboBox
          Tag = 1
          Left = 66
          Top = 60
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 1
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b7: TComboBox
          Tag = 2
          Left = 66
          Top = 81
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 2
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b10: TComboBox
          Tag = 3
          Left = 66
          Top = 102
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 3
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b14: TComboBox
          Tag = 4
          Left = 66
          Top = 123
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 4
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b18: TComboBox
          Tag = 5
          Left = 66
          Top = 144
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 5
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b21: TComboBox
          Tag = 6
          Left = 66
          Top = 165
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 6
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b24: TComboBox
          Tag = 7
          Left = 66
          Top = 186
          Width = 58
          Height = 21
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 7
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b28: TComboBox
          Tag = 8
          Left = 66
          Top = 207
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 8
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b50: TComboBox
          Tag = 9
          Left = 66
          Top = 228
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 9
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b144: TComboBox
          Tag = 10
          Left = 66
          Top = 249
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 10
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b430: TComboBox
          Tag = 11
          Left = 66
          Top = 270
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 11
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b1200: TComboBox
          Tag = 12
          Left = 66
          Top = 291
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 12
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b2400: TComboBox
          Tag = 13
          Left = 66
          Top = 312
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 13
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b5600: TComboBox
          Tag = 14
          Left = 66
          Top = 333
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 14
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_b10g: TComboBox
          Tag = 15
          Left = 66
          Top = 354
          Width = 58
          Height = 21
          ItemIndex = 0
          TabOrder = 15
          Text = 'None'
          OnChange = comboRigB_b19Change
          Items.Strings = (
            'None'
            'RIG-1'
            'RIG-2'
            'RIG-3'
            'RIG-4')
        end
        object comboRigB_Antb19: TComboBox
          Left = 135
          Top = 39
          Width = 54
          Height = 21
          ImeMode = imDisable
          TabOrder = 16
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb35: TComboBox
          Tag = 1
          Left = 135
          Top = 60
          Width = 54
          Height = 21
          ImeMode = imDisable
          TabOrder = 17
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb7: TComboBox
          Tag = 2
          Left = 135
          Top = 81
          Width = 54
          Height = 21
          ImeMode = imDisable
          TabOrder = 18
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb10: TComboBox
          Tag = 3
          Left = 135
          Top = 102
          Width = 54
          Height = 21
          ImeMode = imDisable
          TabOrder = 19
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb14: TComboBox
          Tag = 4
          Left = 135
          Top = 123
          Width = 54
          Height = 21
          ImeMode = imDisable
          TabOrder = 20
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb18: TComboBox
          Tag = 5
          Left = 135
          Top = 144
          Width = 54
          Height = 21
          ImeMode = imDisable
          TabOrder = 21
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb21: TComboBox
          Tag = 6
          Left = 135
          Top = 165
          Width = 54
          Height = 21
          ImeMode = imDisable
          TabOrder = 22
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb24: TComboBox
          Tag = 7
          Left = 135
          Top = 186
          Width = 54
          Height = 21
          ImeMode = imDisable
          TabOrder = 23
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb28: TComboBox
          Tag = 8
          Left = 135
          Top = 207
          Width = 54
          Height = 21
          TabOrder = 24
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb50: TComboBox
          Tag = 9
          Left = 135
          Top = 228
          Width = 54
          Height = 21
          TabOrder = 25
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb144: TComboBox
          Tag = 10
          Left = 135
          Top = 249
          Width = 54
          Height = 21
          TabOrder = 26
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb430: TComboBox
          Tag = 11
          Left = 135
          Top = 270
          Width = 54
          Height = 21
          TabOrder = 27
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb1200: TComboBox
          Tag = 12
          Left = 135
          Top = 291
          Width = 54
          Height = 21
          TabOrder = 28
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb2400: TComboBox
          Tag = 13
          Left = 135
          Top = 312
          Width = 54
          Height = 21
          TabOrder = 29
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb5600: TComboBox
          Tag = 14
          Left = 135
          Top = 333
          Width = 54
          Height = 21
          TabOrder = 30
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
        object comboRigB_Antb10g: TComboBox
          Tag = 15
          Left = 135
          Top = 354
          Width = 54
          Height = 21
          TabOrder = 31
          Text = 'None'
          OnChange = comboRigB_Antb19Change
          Items.Strings = (
            'None'
            'ANT1'
            'ANT2'
            'ANT3'
            'ANT4')
        end
      end
    end
    object tabsheetHardware3: TTabSheet
      Caption = #12495#12540#12489#12454#12455#12450'3'
      ImageIndex = 14
      object groupOptCI_V: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 74
        Caption = 'ICOM CI-V'#12458#12503#12471#12519#12531
        TabOrder = 0
        object Label83: TLabel
          Left = 9
          Top = 23
          Width = 27
          Height = 13
          Caption = #12514#12540#12489
        end
        object Label84: TLabel
          Left = 209
          Top = 23
          Width = 36
          Height = 13
          Caption = #26041#27861
        end
        object Label110: TLabel
          Left = 262
          Top = 49
          Width = 104
          Height = 13
          Caption = #24540#31572#12479#12452#12512#12450#12454#12488'(ms)'
        end
        object comboIcomMode: TComboBox
          Left = 42
          Top = 20
          Width = 160
          Height = 21
          Style = csDropDownList
          ImeMode = imDisable
          ItemIndex = 0
          TabOrder = 0
          Text = 'CI-V Transceive On'
          OnChange = comboIcomModeChange
          Items.Strings = (
            'CI-V Transceive On'
            'CI-V Transceive Off (Polling)')
        end
        object comboIcomMethod: TComboBox
          Left = 253
          Top = 20
          Width = 160
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 1
          Text = #21608#27874#25968#12392#12514#12540#12489#12434#21462#24471
          Items.Strings = (
            #21608#27874#25968#12392#12514#12540#12489#12434#21462#24471
            #21608#27874#25968#12398#12415#21462#24471)
        end
        object editIcomResponseTimout: TEdit
          Left = 376
          Top = 46
          Width = 37
          Height = 21
          MaxLength = 4
          NumbersOnly = True
          TabOrder = 2
          Text = '1000'
          OnKeyPress = NumberEditKeyPress
        end
      end
      object groupOptCwPtt: TGroupBox
        Left = 6
        Top = 84
        Width = 423
        Height = 62
        Caption = 'CW/PTT'#21046#24481
        TabOrder = 1
        object Label38: TLabel
          Left = 8
          Top = 38
          Width = 90
          Height = 13
          Caption = #36865#20449#21069#12487#12451#12524#12452'(ms)'
        end
        object Label39: TLabel
          Left = 180
          Top = 38
          Width = 130
          Height = 13
          Caption = #36865#20449#24460#12487#12451#12524#12452'(ms)'
        end
        object PTTEnabledCheckBox: TCheckBox
          Left = 8
          Top = 14
          Width = 129
          Height = 17
          Caption = 'PTT'#21046#24481#26377#21177
          TabOrder = 0
          OnClick = PTTEnabledCheckBoxClick
        end
        object BeforeEdit: TEdit
          Left = 120
          Top = 35
          Width = 40
          Height = 21
          TabOrder = 1
          Text = 'CWPortEdit'
          OnKeyPress = NumberEditKeyPress
        end
        object AfterEdit: TEdit
          Left = 290
          Top = 35
          Width = 40
          Height = 21
          TabOrder = 2
          Text = 'CWPortEdit'
          OnKeyPress = NumberEditKeyPress
        end
      end
      object groupUsif4cw: TGroupBox
        Left = 6
        Top = 152
        Width = 423
        Height = 73
        Caption = 'USBIF4CW'#12458#12503#12471#12519#12531
        TabOrder = 2
        object checkUsbif4cwSyncWpm: TCheckBox
          Left = 8
          Top = 18
          Width = 126
          Height = 17
          Caption = 'WPM'#21516#26399
          TabOrder = 0
        end
        object checkGen3MicSelect: TCheckBox
          Left = 140
          Top = 18
          Width = 245
          Height = 17
          Caption = 'Gen.3'#12398#12510#12452#12463#20837#21147#20999#26367#12434#12377#12427
          TabOrder = 1
        end
        object checkUsbif4cwUsePaddle: TCheckBox
          Left = 8
          Top = 42
          Width = 296
          Height = 17
          Caption = #12497#12489#12523#12434#20351#29992'(V1, AMD-USB-KEY)'
          TabOrder = 2
        end
      end
      object groupWinKeyer: TGroupBox
        Left = 6
        Top = 231
        Width = 423
        Height = 73
        Caption = 'WinKeyer'#12458#12503#12471#12519#12531
        TabOrder = 3
        object checkUseWinKeyer: TCheckBox
          Left = 8
          Top = 18
          Width = 126
          Height = 17
          Caption = 'WinKeyer'#12434#20351#12358
          TabOrder = 0
          OnClick = checkUseWinKeyerClick
        end
        object checkWk9600: TCheckBox
          Left = 140
          Top = 18
          Width = 118
          Height = 17
          Caption = 'WK 9600bps'
          TabOrder = 1
        end
        object checkWkOutportSelect: TCheckBox
          Left = 8
          Top = 42
          Width = 126
          Height = 17
          Caption = #20986#21147#20808#36984#25246#12377#12427
          TabOrder = 2
        end
        object checkWkIgnoreSpeedPot: TCheckBox
          Left = 140
          Top = 42
          Width = 118
          Height = 17
          Caption = 'Speed Pot'#28961#35222
          TabOrder = 3
        end
        object checkWkAlways9600: TCheckBox
          Left = 264
          Top = 18
          Width = 129
          Height = 17
          Caption = #24120#12395'9600bps'#12391#20351#29992
          TabOrder = 4
        end
      end
    end
    object tabsheetRigControl: TTabSheet
      Caption = #12522#12464#21046#24481
      object groupRcMagicalCalling: TGroupBox
        Left = 6
        Top = 234
        Width = 423
        Height = 167
        Caption = 'Magical Calling'
        TabOrder = 3
        object Label28: TLabel
          Left = 185
          Top = 19
          Width = 92
          Height = 13
          Caption = #26368#22823#12471#12501#12488#24133' +/-'
        end
        object Label29: TLabel
          Left = 328
          Top = 19
          Width = 13
          Height = 13
          Caption = 'Hz'
        end
        object checkUseAntiZeroin: TCheckBox
          Left = 8
          Top = 18
          Width = 105
          Height = 17
          Caption = #20351#29992#12377#12427
          TabOrder = 0
        end
        object editMaxShift: TEdit
          Left = 281
          Top = 16
          Width = 29
          Height = 21
          TabOrder = 1
          Text = '0'
          OnKeyPress = NumberEditKeyPress
        end
        object updownAntiZeroinShiftMax: TUpDown
          Left = 310
          Top = 16
          Width = 16
          Height = 21
          Associate = editMaxShift
          Max = 200
          Increment = 10
          TabOrder = 2
        end
        object GroupBox17: TGroupBox
          Left = 16
          Top = 43
          Width = 163
          Height = 110
          Caption = 'CQ Mode'
          TabOrder = 3
          object checkAntiZeroinRitOff: TCheckBox
            Left = 10
            Top = 18
            Width = 76
            Height = 17
            Caption = 'RIT OFF'
            TabOrder = 0
          end
          object checkAntiZeroinXitOff: TCheckBox
            Left = 10
            Top = 41
            Width = 76
            Height = 17
            Caption = 'XIT OFF'
            TabOrder = 1
          end
          object checkAntiZeroinRitClear: TCheckBox
            Left = 10
            Top = 64
            Width = 126
            Height = 17
            Caption = 'RIT/XIT Clear'
            TabOrder = 2
          end
        end
        object GroupBox18: TGroupBox
          Left = 185
          Top = 43
          Width = 168
          Height = 110
          Caption = 'S&&P Mode'
          TabOrder = 4
          object checkAntiZeroinXitOn1: TCheckBox
            Left = 10
            Top = 18
            Width = 143
            Height = 17
            Caption = 'XIT ON (bandscope)'
            TabOrder = 0
          end
          object checkAntiZeroinXitOn2: TCheckBox
            Left = 10
            Top = 41
            Width = 143
            Height = 17
            Caption = 'XIT ON (VFO)'
            TabOrder = 1
          end
          object checkAntiZeroinStopCq: TCheckBox
            Left = 10
            Top = 64
            Width = 143
            Height = 17
            Caption = 'CQ'#12434#20013#27490
            TabOrder = 2
          end
          object checkAntiZeroinAutoCancel: TCheckBox
            Left = 10
            Top = 85
            Width = 143
            Height = 17
            Caption = #33258#21205#12461#12515#12531#12475#12523
            TabOrder = 3
          end
        end
      end
      object groupRcSleepMode: TGroupBox
        Left = 256
        Top = 4
        Width = 173
        Height = 81
        Caption = #12473#12522#12540#12503#12514#12540#12489
        TabOrder = 1
        object checkTurnoffSleep: TCheckBox
          Left = 8
          Top = 23
          Width = 164
          Height = 18
          Caption = #12473#12522#12540#12503#26178#12399'OFF'#12395#12377#12427
          TabOrder = 0
        end
        object checkTurnonResume: TCheckBox
          Left = 8
          Top = 47
          Width = 164
          Height = 18
          Caption = #20877#38283#26178#12399'ON'#12395#12377#12427
          TabOrder = 1
        end
      end
      object groupRcGeneral: TGroupBox
        Left = 6
        Top = 4
        Width = 244
        Height = 224
        Caption = #20840#33324
        TabOrder = 0
        object Label45: TLabel
          Left = 8
          Top = 114
          Width = 114
          Height = 13
          Caption = #29694#22312#21608#27874#25968#12434'Z-Server'#12395#36865#20449
        end
        object Label46: TLabel
          Left = 203
          Top = 133
          Width = 20
          Height = 13
          Caption = #31186#27598
        end
        object cbAutoBandMap: TCheckBox
          Left = 8
          Top = 90
          Width = 206
          Height = 17
          Caption = #12496#12531#12489#12473#12467#12540#12503#33258#21205#20316#25104
          TabOrder = 0
          WordWrap = True
        end
        object cbDontAllowSameBand: TCheckBox
          Left = 8
          Top = 42
          Width = 233
          Height = 17
          Caption = #65298#21488#12398#12522#12464#12434#21516#12376#12496#12531#12489#12395#12375#12394#12356
          TabOrder = 1
          WordWrap = True
        end
        object cbRecordRigFreq: TCheckBox
          Left = 8
          Top = 66
          Width = 220
          Height = 19
          Caption = #36939#29992#21608#27874#25968#12434#35352#37682#12377#12427
          TabOrder = 2
          WordWrap = True
        end
        object cbRITClear: TCheckBox
          Left = 8
          Top = 18
          Width = 161
          Height = 17
          Caption = 'QSO'#30906#23450#24460'RIT'#12463#12522#12450
          TabOrder = 3
        end
        object checkIgnoreRigMode: TCheckBox
          Left = 8
          Top = 156
          Width = 141
          Height = 18
          Caption = #12522#12464#12398#12514#12540#12489#12434#28961#35222#12377#12427
          TabOrder = 4
        end
        object SendFreqEdit: TEdit
          Left = 146
          Top = 130
          Width = 35
          Height = 21
          Hint = 'Only when using Z-Server network'
          MaxLength = 3
          NumbersOnly = True
          TabOrder = 5
          Text = '60'
          OnKeyPress = NumberEditKeyPress
        end
        object updownSendFreqInterval: TUpDown
          Left = 181
          Top = 130
          Width = 16
          Height = 21
          Associate = SendFreqEdit
          Max = 300
          Position = 60
          TabOrder = 6
        end
      end
      object groupRcMemoryScan: TGroupBox
        Left = 256
        Top = 91
        Width = 172
        Height = 52
        Caption = #12513#12514#12522#12540#12473#12461#12515#12531
        TabOrder = 2
        object Label4: TLabel
          Left = 146
          Top = 22
          Width = 20
          Height = 13
          Caption = #31186
        end
        object Label5: TLabel
          Left = 8
          Top = 22
          Width = 54
          Height = 13
          Caption = #12473#12461#12515#12531#38291#38548
        end
        object editMemScanInterval: TEdit
          Left = 89
          Top = 19
          Width = 35
          Height = 21
          MaxLength = 3
          NumbersOnly = True
          TabOrder = 0
          Text = '10'
          OnKeyPress = NumberEditKeyPress
        end
        object updownMemScanInterval: TUpDown
          Left = 124
          Top = 19
          Width = 16
          Height = 21
          Associate = editMemScanInterval
          Min = 1
          Max = 999
          Position = 10
          TabOrder = 1
        end
      end
    end
    object tabsheetNetwork: TTabSheet
      Caption = #12493#12483#12488#12527#12540#12463
      ImageIndex = 12
      object groupNetwork: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 137
        Caption = #22806#37096#36899#25658
        TabOrder = 0
        object Label30: TLabel
          Left = 8
          Top = 31
          Width = 66
          Height = 13
          Caption = 'PacketCluster'
        end
        object Port: TLabel
          Left = 134
          Top = 14
          Width = 19
          Height = 13
          Caption = #12509#12540#12488
        end
        object Label32: TLabel
          Left = 8
          Top = 58
          Width = 80
          Height = 13
          Caption = 'Z-Link (Z-Server)'
        end
        object Label55: TLabel
          Left = 8
          Top = 87
          Width = 78
          Height = 13
          Caption = 'Z-Link PC'#21517
        end
        object ClusterCombo: TComboBox
          Left = 118
          Top = 28
          Width = 73
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnChange = ClusterComboChange
          Items.Strings = (
            'None'
            'COM1'
            'COM2'
            'COM3'
            'COM4'
            'COM5'
            'COM6'
            'TELNET')
        end
        object buttonClusterSettings: TButton
          Left = 201
          Top = 28
          Width = 102
          Height = 21
          Caption = 'COM'#12509#12540#12488#35373#23450
          TabOrder = 1
          OnClick = buttonClusterSettingsClick
        end
        object ZLinkCombo: TComboBox
          Left = 118
          Top = 55
          Width = 73
          Height = 21
          Style = csDropDownList
          TabOrder = 3
          OnChange = ZLinkComboChange
          Items.Strings = (
            'None'
            'TELNET')
        end
        object buttonZLinkSettings: TButton
          Left = 201
          Top = 55
          Width = 102
          Height = 21
          Caption = 'TELNET'#35373#23450
          TabOrder = 6
          OnClick = buttonZLinkSettingsClick
        end
        object editZLinkPcName: TEdit
          Left = 118
          Top = 84
          Width = 101
          Height = 21
          TabOrder = 4
        end
        object checkZLinkSyncSerial: TCheckBox
          Left = 232
          Top = 86
          Width = 150
          Height = 17
          Caption = #12471#12522#12450#12523#12490#12531#12496#12540#21516#26399
          TabOrder = 5
          OnClick = PTTEnabledCheckBoxClick
        end
        object buttonSpotterList: TButton
          Left = 312
          Top = 28
          Width = 102
          Height = 21
          Caption = #35377#21487'/'#25298#21542#12522#12473#12488
          TabOrder = 2
          OnClick = buttonSpotterListClick
        end
      end
    end
    object tabsheetPath: TTabSheet
      Caption = #21508#31278#12501#12457#12523#12480
      object Label50: TLabel
        Left = 8
        Top = 44
        Width = 48
        Height = 13
        Caption = 'CFG/DAT'
      end
      object Label51: TLabel
        Left = 8
        Top = 69
        Width = 23
        Height = 13
        Caption = #12525#12464#12501#12449#12452#12523
      end
      object Label56: TLabel
        Left = 8
        Top = 94
        Width = 40
        Height = 13
        Caption = #12496#12483#12463#12450#12483#12503
      end
      object Label74: TLabel
        Left = 8
        Top = 119
        Width = 31
        Height = 13
        Caption = #38899#22768#12501#12449#12452#12523
      end
      object Label90: TLabel
        Left = 8
        Top = 144
        Width = 34
        Height = 13
        Caption = #12503#12521#12464#12452#12531
      end
      object Label108: TLabel
        Left = 8
        Top = 19
        Width = 44
        Height = 13
        Caption = 'zLog'#12523#12540#12488
      end
      object Label109: TLabel
        Left = 8
        Top = 169
        Width = 62
        Height = 13
        Caption = 'Super Check'
      end
      object editCfgDatFolder: TEdit
        Left = 88
        Top = 41
        Width = 266
        Height = 21
        TabOrder = 2
      end
      object buttonBrowseCFGDATPath: TButton
        Tag = 10
        Left = 360
        Top = 42
        Width = 65
        Height = 20
        Caption = #21442#29031'...'
        TabOrder = 3
        OnClick = BrowsePathClick
      end
      object editLogsFolder: TEdit
        Tag = 20
        Left = 88
        Top = 66
        Width = 266
        Height = 21
        TabOrder = 4
      end
      object buttonBrowseLogsPath: TButton
        Tag = 20
        Left = 360
        Top = 67
        Width = 65
        Height = 20
        Caption = #21442#29031'...'
        TabOrder = 5
        OnClick = BrowsePathClick
      end
      object buttonBrowseBackupPath: TButton
        Tag = 30
        Left = 360
        Top = 92
        Width = 65
        Height = 20
        Caption = #21442#29031'...'
        TabOrder = 7
        OnClick = BrowsePathClick
      end
      object editBackupFolder: TEdit
        Left = 88
        Top = 91
        Width = 266
        Height = 21
        TabOrder = 6
      end
      object buttonBrowseSoundPath: TButton
        Tag = 40
        Left = 360
        Top = 117
        Width = 65
        Height = 20
        Caption = #21442#29031'...'
        TabOrder = 9
        OnClick = BrowsePathClick
      end
      object editSoundFolder: TEdit
        Left = 88
        Top = 116
        Width = 266
        Height = 21
        TabOrder = 8
      end
      object buttonBrowsePluginPath: TButton
        Tag = 50
        Left = 360
        Top = 142
        Width = 65
        Height = 20
        Caption = #21442#29031'...'
        TabOrder = 11
        OnClick = BrowsePathClick
      end
      object editPluginsFolder: TEdit
        Left = 88
        Top = 141
        Width = 266
        Height = 21
        TabOrder = 10
      end
      object editRootFolder: TEdit
        Left = 88
        Top = 16
        Width = 266
        Height = 21
        TabOrder = 0
      end
      object buttonBrowseRootFolder: TButton
        Left = 360
        Top = 17
        Width = 65
        Height = 20
        Caption = #21442#29031'...'
        TabOrder = 1
        OnClick = BrowsePathClick
      end
      object buttonBrowseSpcPath: TButton
        Tag = 60
        Left = 360
        Top = 167
        Width = 65
        Height = 20
        Caption = #21442#29031'...'
        TabOrder = 13
        OnClick = BrowsePathClick
      end
      object editSpcFolder: TEdit
        Left = 88
        Top = 166
        Width = 266
        Height = 21
        TabOrder = 12
      end
    end
    object tabsheetFont: TTabSheet
      Caption = #21508#31278#12501#12457#12531#12488
      ImageIndex = 13
      object GroupBox21: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 105
        Caption = #12501#12457#12531#12488
        TabOrder = 0
        object Label102: TLabel
          Left = 12
          Top = 23
          Width = 60
          Height = 13
          Caption = #12467#12540#12523#12469#12452#12531
        end
        object Label103: TLabel
          Left = 92
          Top = 76
          Width = 228
          Height = 12
          Caption = #8251#22793#26356#12434#26377#21177#12395#12377#12427#12395#12399#12289#20877#36215#21205#12375#12390#12367#12384#12373#12356
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
          Font.Style = []
          ParentFont = False
        end
        object comboFontBase: TJvFontComboBox
          Left = 84
          Top = 21
          Width = 321
          Height = 22
          DroppedDownWidth = 321
          MaxMRUCount = 0
          FontName = '@HG'#21109#33521#35282#65422#65439#65391#65420#65439#20307
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #65325#65331' '#12468#12471#12483#12463
          Font.Style = []
          ItemIndex = 9
          Options = [foFixedPitchOnly, foWysiWyg]
          ParentFont = False
          Sorted = True
          TabOrder = 0
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 432
    Width = 444
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 433
    ExplicitWidth = 440
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
    Filter = #38899#22768#12501#12449#12452#12523'|*.wav;*.mp3|WAV'#12501#12449#12452#12523'|*.wav|MP3'#12501#12449#12452#12523'|*.mp3|'#20840#12390#12398#12501#12449#12452#12523'|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 324
    Top = 428
  end
  object ColorDialog1: TColorDialog
    Left = 292
    Top = 428
  end
end
