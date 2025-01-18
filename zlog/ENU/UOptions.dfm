object formOptions: TformOptions
  Left = 532
  Top = 236
  ActiveControl = radio1Radio
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
    ActivePage = tabsheetOperateStyle
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 440
    ExplicitHeight = 433
    object tabsheetOperateStyle: TTabSheet
      Caption = 'Operate Style'
      ImageIndex = 7
      object groupSo2rSupport: TGroupBox
        Left = 6
        Top = 103
        Width = 423
        Height = 294
        Caption = 'SO2R options'
        TabOrder = 2
        object Label115: TLabel
          Left = 13
          Top = 245
          Width = 210
          Height = 13
          Caption = 'Accelerate keying speed  after pressing TAB'
        end
        object Label116: TLabel
          Left = 305
          Top = 245
          Width = 27
          Height = 13
          Caption = 'WPM'
        end
        object GroupBox7: TGroupBox
          Left = 8
          Top = 20
          Width = 405
          Height = 128
          Caption = 'RIG Select'
          TabOrder = 0
          object groupSo2rCom: TGroupBox
            Left = 128
            Top = 13
            Width = 265
            Height = 84
            Caption = 'Output Port'
            TabOrder = 5
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
            object checkRigSelectV28: TCheckBox
              Left = 184
              Top = 51
              Width = 75
              Height = 24
              Caption = 'V2.8 compatible'
              TabOrder = 3
              WordWrap = True
            end
          end
          object radioSo2rNeo: TRadioButton
            Tag = 2
            Left = 12
            Top = 60
            Width = 100
            Height = 17
            Caption = 'SO2R Neo'
            TabOrder = 2
            OnClick = radioSo2rClick
          end
          object radioSo2rNone: TRadioButton
            Left = 12
            Top = 20
            Width = 100
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
            Top = 40
            Width = 100
            Height = 17
            Caption = 'COM Port'
            TabOrder = 1
            OnClick = radioSo2rClick
          end
          object radioSo2rOtrsp: TRadioButton
            Tag = 3
            Left = 12
            Top = 80
            Width = 100
            Height = 17
            Caption = 'OTRSP'
            TabOrder = 3
            OnClick = radioSo2rClick
          end
          object groupSo2rOtrsp: TGroupBox
            Left = 128
            Top = 13
            Width = 265
            Height = 53
            Caption = 'OTRSP Option'
            TabOrder = 6
            object Label17: TLabel
              Left = 12
              Top = 23
              Width = 68
              Height = 13
              Caption = 'Command port'
            end
            object comboSo2rOtrspPort: TComboBox
              Left = 94
              Top = 20
              Width = 64
              Height = 21
              Style = csDropDownList
              TabOrder = 0
            end
          end
          object radioSo2rParallel: TRadioButton
            Tag = 4
            Left = 12
            Top = 100
            Width = 100
            Height = 17
            Caption = 'Parallel Port'
            TabOrder = 4
            OnClick = radioSo2rClick
          end
        end
        object groupSo2rCqOption: TGroupBox
          Left = 8
          Top = 154
          Width = 405
          Height = 82
          Caption = 'Auto RIG switch Options'
          TabOrder = 1
          object Label44: TLabel
            Left = 12
            Top = 23
            Width = 96
            Height = 13
            Caption = 'CQ rpt. interval (sec)'
          end
          object Label100: TLabel
            Left = 12
            Top = 51
            Width = 83
            Height = 13
            Caption = 'Message Number'
          end
          object Label101: TLabel
            Left = 187
            Top = 23
            Width = 71
            Height = 13
            Caption = 'After Delay(ms)'
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
          Left = 263
          Top = 242
          Width = 34
          Height = 22
          MaxValue = 9
          MinValue = 0
          TabOrder = 2
          Value = 3
        end
        object checkSo2rIgnoreModeChange: TCheckBox
          Left = 13
          Top = 268
          Width = 246
          Height = 17
          Caption = 'Ignore mode changes from popup menu'
          TabOrder = 3
        end
        object checkSo2rCqRestartAfterSetLast: TCheckBox
          Left = 263
          Top = 268
          Width = 161
          Height = 17
          Caption = 'CQ restart after set last freq.'
          TabOrder = 4
        end
      end
      object GroupBox1: TGroupBox
        Left = 6
        Top = 4
        Width = 329
        Height = 93
        Caption = 'Operate style'
        TabOrder = 0
        object Label1: TLabel
          Left = 92
          Top = 18
          Width = 222
          Height = 30
          AutoSize = False
          Caption = 
            'Select for Single OP one radio, 2TX, Multi-TX. This is the class' +
            'ic style.'
          WordWrap = True
        end
        object Label2: TLabel
          Left = 92
          Top = 54
          Width = 222
          Height = 30
          AutoSize = False
          Caption = 
            'Select for Single OP two radio. In this style, the input fields ' +
            'are arranged on the left and right.'
          WordWrap = True
        end
        object radio1Radio: TRadioButton
          Left = 13
          Top = 24
          Width = 58
          Height = 17
          Caption = '1Radio'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = radio1RadioClick
        end
        object radio2Radio: TRadioButton
          Left = 13
          Top = 58
          Width = 58
          Height = 17
          Caption = '2Radio'
          TabOrder = 1
          OnClick = radio2RadioClick
        end
      end
      object groupOperateMode: TGroupBox
        Left = 344
        Top = 4
        Width = 85
        Height = 93
        Caption = 'Operate mode'
        TabOrder = 1
        object radioOriginalMode: TRadioButton
          Left = 10
          Top = 24
          Width = 66
          Height = 17
          Caption = 'Original'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object radioEnterMode: TRadioButton
          Left = 10
          Top = 58
          Width = 66
          Height = 17
          Caption = 'Enter key'
          TabOrder = 1
        end
      end
    end
    object tabsheetHardware1: TTabSheet
      Caption = 'Hardware1'
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
          Caption = 'CW port'
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
          Caption = 'Config'
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
          Caption = 'Rig'
        end
        object Label121: TLabel
          Left = 15
          Top = 13
          Width = 54
          Height = 13
          Caption = 'Control port'
        end
        object Label122: TLabel
          Left = 88
          Top = 13
          Width = 31
          Height = 13
          Caption = 'Speed'
        end
        object Label123: TLabel
          Left = 282
          Top = 13
          Width = 39
          Height = 13
          Caption = 'CW port'
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
          Caption = 'Config'
          TabOrder = 6
          OnClick = buttonPortConfigCWClick
        end
        object buttonRig2PortConfig: TButton
          Tag = 2
          Left = 11
          Top = 50
          Width = 64
          Height = 22
          Caption = 'Config'
          TabOrder = 1
          OnClick = buttonPortConfigRigClick
        end
        object buttonXvtConfig2: TButton
          Tag = 2
          Left = 351
          Top = 50
          Width = 64
          Height = 22
          Caption = 'Config'
          TabOrder = 8
          OnClick = buttonXvtConfigClick
        end
        object checkRig2ChangePTT: TCheckBox
          Tag = 2
          Left = 119
          Top = 52
          Width = 153
          Height = 17
          Caption = 'For Phone, use KEY for PTT'
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
          Caption = 'Rig'
        end
        object Label92: TLabel
          Left = 15
          Top = 13
          Width = 54
          Height = 13
          Caption = 'Control port'
        end
        object Label93: TLabel
          Left = 88
          Top = 13
          Width = 31
          Height = 13
          Caption = 'Speed'
        end
        object Label94: TLabel
          Left = 282
          Top = 13
          Width = 39
          Height = 13
          Caption = 'CW port'
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
          Caption = 'Config'
          TabOrder = 1
          OnClick = buttonPortConfigRigClick
        end
        object buttonPortConfigCW1: TButton
          Tag = 1
          Left = 278
          Top = 50
          Width = 64
          Height = 22
          Caption = 'Config'
          TabOrder = 6
          OnClick = buttonPortConfigCWClick
        end
        object buttonXvtConfig1: TButton
          Tag = 1
          Left = 351
          Top = 50
          Width = 64
          Height = 22
          Caption = 'Config'
          TabOrder = 8
          OnClick = buttonXvtConfigClick
        end
        object checkRig1ChangePTT: TCheckBox
          Tag = 1
          Left = 119
          Top = 52
          Width = 153
          Height = 17
          Caption = 'For Phone, use KEY for PTT'
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
          Caption = 'Rig'
        end
        object Label125: TLabel
          Left = 15
          Top = 13
          Width = 54
          Height = 13
          Caption = 'Control port'
        end
        object Label126: TLabel
          Left = 88
          Top = 13
          Width = 31
          Height = 13
          Caption = 'Speed'
        end
        object Label127: TLabel
          Left = 282
          Top = 13
          Width = 39
          Height = 13
          Caption = 'CW port'
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
          Caption = 'Config'
          TabOrder = 6
          OnClick = buttonPortConfigCWClick
        end
        object buttonRig4PortConfig: TButton
          Tag = 4
          Left = 11
          Top = 50
          Width = 64
          Height = 22
          Caption = 'Config'
          TabOrder = 1
          OnClick = buttonPortConfigRigClick
        end
        object buttonXvtConfig4: TButton
          Tag = 4
          Left = 351
          Top = 50
          Width = 64
          Height = 22
          Caption = 'Config'
          TabOrder = 8
          OnClick = buttonXvtConfigClick
        end
        object checkRig4ChangePTT: TCheckBox
          Tag = 4
          Left = 119
          Top = 52
          Width = 153
          Height = 17
          Caption = 'For Phone, use KEY for PTT'
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
          Caption = 'Rig'
        end
        object Label96: TLabel
          Left = 15
          Top = 13
          Width = 54
          Height = 13
          Caption = 'Control port'
        end
        object Label97: TLabel
          Left = 88
          Top = 13
          Width = 31
          Height = 13
          Caption = 'Speed'
        end
        object Label98: TLabel
          Left = 282
          Top = 13
          Width = 39
          Height = 13
          Caption = 'CW port'
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
          Caption = 'Config'
          TabOrder = 6
          OnClick = buttonPortConfigCWClick
        end
        object buttonRig3PortConfig: TButton
          Tag = 3
          Left = 11
          Top = 50
          Width = 64
          Height = 22
          Caption = 'Config'
          TabOrder = 1
          OnClick = buttonPortConfigRigClick
        end
        object buttonXvtConfig3: TButton
          Tag = 3
          Left = 351
          Top = 50
          Width = 64
          Height = 22
          Caption = 'Config'
          TabOrder = 8
          OnClick = buttonXvtConfigClick
        end
        object checkRig3ChangePTT: TCheckBox
          Tag = 3
          Left = 119
          Top = 52
          Width = 153
          Height = 17
          Caption = 'For Phone, use KEY for PTT'
          TabOrder = 4
        end
      end
    end
    object tabsheetHardware2: TTabSheet
      Caption = 'Hardware2'
      ImageIndex = 15
      object groupRigSetA: TGroupBox
        Left = 6
        Top = 4
        Width = 200
        Height = 393
        Caption = 'Assign to the set of RIG-A'
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
          Caption = 'RIG'
        end
        object Label105: TLabel
          Left = 141
          Top = 20
          Width = 40
          Height = 13
          Caption = 'Antenna'
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
        Caption = 'Assign to the set of RIG-B'
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
          Caption = 'Antenna'
        end
        object Label107: TLabel
          Left = 81
          Top = 20
          Width = 19
          Height = 13
          Caption = 'RIG'
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
      Caption = 'Hardware3'
      ImageIndex = 14
      object groupOptCI_V: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 74
        Caption = 'ICOM CI-V Options'
        TabOrder = 0
        object Label83: TLabel
          Left = 9
          Top = 23
          Width = 27
          Height = 13
          Caption = 'Mode'
        end
        object Label84: TLabel
          Left = 209
          Top = 23
          Width = 36
          Height = 13
          Caption = 'Method'
        end
        object Label110: TLabel
          Left = 262
          Top = 49
          Width = 104
          Height = 13
          Caption = 'Response timeout(ms)'
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
          Text = 'Get freq. and mode (slow)'
          Items.Strings = (
            'Get freq. and mode (slow)'
            'Get freq. only (fast)')
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
        Height = 68
        Caption = 'PTT control'
        TabOrder = 1
        object Label38: TLabel
          Left = 151
          Top = 19
          Width = 70
          Height = 13
          Caption = 'Before TX (ms)'
        end
        object Label39: TLabel
          Left = 307
          Top = 19
          Width = 61
          Height = 13
          Caption = 'After TX (ms)'
        end
        object Label18: TLabel
          Left = 307
          Top = 43
          Width = 61
          Height = 13
          Caption = 'After TX (ms)'
        end
        object Label19: TLabel
          Left = 151
          Top = 43
          Width = 70
          Height = 13
          Caption = 'Before TX (ms)'
        end
        object checkEnablePttCw: TCheckBox
          Left = 8
          Top = 18
          Width = 113
          Height = 17
          Caption = 'Enable PTT (CW)'
          TabOrder = 0
          OnClick = checkEnablePttCwClick
        end
        object editBeforeTxCw: TEdit
          Left = 225
          Top = 16
          Width = 40
          Height = 21
          TabOrder = 1
          OnKeyPress = NumberEditKeyPress
        end
        object editAfterTxCw: TEdit
          Left = 373
          Top = 16
          Width = 40
          Height = 21
          TabOrder = 2
          OnKeyPress = NumberEditKeyPress
        end
        object checkEnablePttPh: TCheckBox
          Left = 8
          Top = 42
          Width = 113
          Height = 17
          Caption = 'Enable PTT (PH)'
          TabOrder = 3
          OnClick = checkEnablePttPhClick
        end
        object editBeforeTxPh: TEdit
          Left = 225
          Top = 40
          Width = 40
          Height = 21
          TabOrder = 4
          OnKeyPress = NumberEditKeyPress
        end
        object editAfterTxPh: TEdit
          Left = 373
          Top = 40
          Width = 40
          Height = 21
          TabOrder = 5
          OnKeyPress = NumberEditKeyPress
        end
      end
      object groupUsif4cw: TGroupBox
        Left = 6
        Top = 159
        Width = 423
        Height = 68
        Caption = 'USBIF4CW options'
        TabOrder = 2
        object checkUsbif4cwSyncWpm: TCheckBox
          Left = 8
          Top = 18
          Width = 126
          Height = 17
          Caption = 'Sync WPM'
          TabOrder = 0
        end
        object checkGen3MicSelect: TCheckBox
          Left = 140
          Top = 18
          Width = 245
          Height = 17
          Caption = 'Select mic input for Gen.3'
          TabOrder = 1
        end
        object checkUsbif4cwUsePaddle: TCheckBox
          Left = 8
          Top = 42
          Width = 296
          Height = 17
          Caption = 'Use paddle (V1 only)'
          TabOrder = 2
        end
      end
      object groupWinKeyer: TGroupBox
        Left = 6
        Top = 234
        Width = 423
        Height = 68
        Caption = 'WinKeyer Option'
        TabOrder = 3
        object checkUseWinKeyer: TCheckBox
          Left = 8
          Top = 18
          Width = 126
          Height = 17
          Caption = 'Use WinKeyer'
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
          Caption = 'Use Out port Select'
          TabOrder = 2
        end
        object checkWkIgnoreSpeedPot: TCheckBox
          Left = 140
          Top = 42
          Width = 118
          Height = 17
          Caption = 'Ignore Speed Pot'
          TabOrder = 3
        end
        object checkWkAlways9600: TCheckBox
          Left = 264
          Top = 18
          Width = 129
          Height = 17
          Caption = 'Always 9600bps'
          TabOrder = 4
        end
      end
      object groupSoundDevice: TGroupBox
        Left = 6
        Top = 309
        Width = 423
        Height = 52
        Caption = 'Voice playback device'
        TabOrder = 4
        object comboVoiceDevice: TComboBox
          Left = 140
          Top = 20
          Width = 273
          Height = 21
          Style = csDropDownList
          TabOrder = 1
        end
        object checkUseRigDevice: TCheckBox
          Left = 8
          Top = 22
          Width = 91
          Height = 17
          Caption = 'Use rig device'
          TabOrder = 0
          OnClick = checkUseRigDeviceClick
        end
      end
    end
    object tabsheetHardware4: TTabSheet
      Caption = 'Hardware4'
      ImageIndex = 8
      object gtoupRig1F2A: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 96
        Caption = 'RIG-1'
        TabOrder = 0
        object Label13: TLabel
          Left = 151
          Top = 72
          Width = 70
          Height = 13
          Caption = 'Before TX (ms)'
        end
        object Label14: TLabel
          Left = 307
          Top = 72
          Width = 61
          Height = 13
          Caption = 'After TX (ms)'
        end
        object Label15: TLabel
          Left = 9
          Top = 19
          Width = 66
          Height = 13
          Caption = 'Sound device'
        end
        object Label85: TLabel
          Left = 323
          Top = 19
          Width = 39
          Height = 13
          AutoSize = False
          Caption = 'Volume'
        end
        object Label16: TLabel
          Left = 339
          Top = 46
          Width = 19
          Height = 13
          Alignment = taRightJustify
          Caption = 'filter'
        end
        object comboRig1SoundDevice: TComboBox
          Left = 83
          Top = 16
          Width = 227
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
        object checkUseRig1F2A: TCheckBox
          Tag = 1
          Left = 8
          Top = 45
          Width = 70
          Height = 17
          Caption = 'Use F2A'
          TabOrder = 2
          OnClick = checkUseF2AClick
        end
        object checkUseRig1F2APtt: TCheckBox
          Tag = 1
          Left = 8
          Top = 71
          Width = 89
          Height = 17
          Caption = 'Enable PTT'
          TabOrder = 6
          OnClick = checkUseF2APttClick
        end
        object editRig1F2ABefore: TEdit
          Left = 225
          Top = 69
          Width = 40
          Height = 21
          TabOrder = 7
          OnKeyPress = NumberEditKeyPress
        end
        object editRig1F2AAfter: TEdit
          Left = 373
          Top = 69
          Width = 40
          Height = 21
          TabOrder = 8
          OnKeyPress = NumberEditKeyPress
        end
        object spinRig1F2AVolume: TSpinEdit
          Left = 367
          Top = 16
          Width = 46
          Height = 22
          MaxValue = 100
          MinValue = 1
          TabOrder = 1
          Value = 100
        end
        object comboRig1F2aDataMode: TComboBox
          Left = 249
          Top = 43
          Width = 45
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 4
          Text = 'D1'
          Items.Strings = (
            'D1'
            'D2'
            'D3')
        end
        object comboRig1F2aFilter: TComboBox
          Left = 363
          Top = 43
          Width = 50
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 5
          Text = 'FIL1'
          Items.Strings = (
            'FIL1'
            'FIL2'
            'FIL3')
        end
        object checkUseRig1F2ADataMode: TCheckBox
          Tag = 1
          Left = 136
          Top = 45
          Width = 107
          Height = 17
          Caption = 'Use DATAMODE'
          TabOrder = 3
          OnClick = checkUseF2ADataModeClick
        end
      end
      object gtoupRig2F2A: TGroupBox
        Left = 6
        Top = 103
        Width = 423
        Height = 96
        Caption = 'RIG-2'
        TabOrder = 1
        object Label20: TLabel
          Left = 151
          Top = 72
          Width = 70
          Height = 13
          Caption = 'Before TX (ms)'
        end
        object Label21: TLabel
          Left = 307
          Top = 72
          Width = 61
          Height = 13
          Caption = 'After TX (ms)'
        end
        object Label22: TLabel
          Left = 9
          Top = 19
          Width = 66
          Height = 13
          Caption = 'Sound device'
        end
        object Label23: TLabel
          Left = 323
          Top = 19
          Width = 39
          Height = 13
          AutoSize = False
          Caption = 'Volume'
        end
        object Label24: TLabel
          Left = 339
          Top = 46
          Width = 19
          Height = 13
          Alignment = taRightJustify
          Caption = 'filter'
        end
        object comboRig2SoundDevice: TComboBox
          Left = 83
          Top = 16
          Width = 227
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
        object checkUseRig2F2A: TCheckBox
          Tag = 2
          Left = 8
          Top = 45
          Width = 70
          Height = 17
          Caption = 'Use F2A'
          TabOrder = 2
          OnClick = checkUseF2AClick
        end
        object checkUseRig2F2APtt: TCheckBox
          Tag = 2
          Left = 8
          Top = 71
          Width = 89
          Height = 17
          Caption = 'Enable PTT'
          TabOrder = 6
          OnClick = checkUseF2APttClick
        end
        object editRig2F2ABefore: TEdit
          Left = 225
          Top = 69
          Width = 40
          Height = 21
          TabOrder = 7
          OnKeyPress = NumberEditKeyPress
        end
        object editRig2F2AAfter: TEdit
          Left = 373
          Top = 69
          Width = 40
          Height = 21
          TabOrder = 8
          OnKeyPress = NumberEditKeyPress
        end
        object spinRig2F2AVolume: TSpinEdit
          Left = 367
          Top = 16
          Width = 46
          Height = 22
          MaxValue = 100
          MinValue = 1
          TabOrder = 1
          Value = 100
        end
        object comboRig2F2aDataMode: TComboBox
          Left = 249
          Top = 43
          Width = 45
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 4
          Text = 'D1'
          Items.Strings = (
            'D1'
            'D2'
            'D3')
        end
        object comboRig2F2aFilter: TComboBox
          Left = 363
          Top = 43
          Width = 50
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 5
          Text = 'FIL1'
          Items.Strings = (
            'FIL1'
            'FIL2'
            'FIL3')
        end
        object checkUseRig2F2ADataMode: TCheckBox
          Tag = 2
          Left = 136
          Top = 45
          Width = 107
          Height = 17
          Caption = 'Use DATAMODE'
          TabOrder = 3
          OnClick = checkUseF2ADataModeClick
        end
      end
      object gtoupRig3F2A: TGroupBox
        Left = 6
        Top = 202
        Width = 423
        Height = 96
        Caption = 'RIG-3'
        TabOrder = 2
        object Label25: TLabel
          Left = 151
          Top = 72
          Width = 70
          Height = 13
          Caption = 'Before TX (ms)'
        end
        object Label26: TLabel
          Left = 307
          Top = 72
          Width = 61
          Height = 13
          Caption = 'After TX (ms)'
        end
        object Label27: TLabel
          Left = 9
          Top = 19
          Width = 66
          Height = 13
          Caption = 'Sound device'
        end
        object Label30: TLabel
          Left = 323
          Top = 19
          Width = 39
          Height = 13
          AutoSize = False
          Caption = 'Volume'
        end
        object Label33: TLabel
          Left = 339
          Top = 46
          Width = 19
          Height = 13
          Alignment = taRightJustify
          Caption = 'filter'
        end
        object comboRig3SoundDevice: TComboBox
          Left = 83
          Top = 16
          Width = 227
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
        object checkUseRig3F2A: TCheckBox
          Tag = 3
          Left = 8
          Top = 45
          Width = 70
          Height = 17
          Caption = 'Use F2A'
          TabOrder = 2
          OnClick = checkUseF2AClick
        end
        object checkUseRig3F2APtt: TCheckBox
          Tag = 3
          Left = 8
          Top = 71
          Width = 89
          Height = 17
          Caption = 'Enable PTT'
          TabOrder = 6
          OnClick = checkUseF2APttClick
        end
        object editRig3F2ABefore: TEdit
          Left = 225
          Top = 69
          Width = 40
          Height = 21
          TabOrder = 7
          OnKeyPress = NumberEditKeyPress
        end
        object editRig3F2AAfter: TEdit
          Left = 373
          Top = 69
          Width = 40
          Height = 21
          TabOrder = 8
          OnKeyPress = NumberEditKeyPress
        end
        object spinRig3F2AVolume: TSpinEdit
          Left = 367
          Top = 16
          Width = 46
          Height = 22
          MaxValue = 100
          MinValue = 1
          TabOrder = 1
          Value = 100
        end
        object comboRig3F2aDataMode: TComboBox
          Left = 249
          Top = 43
          Width = 45
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 4
          Text = 'D1'
          Items.Strings = (
            'D1'
            'D2'
            'D3')
        end
        object comboRig3F2aFilter: TComboBox
          Left = 363
          Top = 43
          Width = 50
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 5
          Text = 'FIL1'
          Items.Strings = (
            'FIL1'
            'FIL2'
            'FIL3')
        end
        object checkUseRig3F2ADataMode: TCheckBox
          Tag = 3
          Left = 136
          Top = 45
          Width = 107
          Height = 17
          Caption = 'Use DATAMODE'
          TabOrder = 3
          OnClick = checkUseF2ADataModeClick
        end
      end
      object gtoupRig4F2A: TGroupBox
        Left = 6
        Top = 301
        Width = 423
        Height = 96
        Caption = 'RIG-4'
        TabOrder = 3
        object Label34: TLabel
          Left = 151
          Top = 72
          Width = 70
          Height = 13
          Caption = 'Before TX (ms)'
        end
        object Label35: TLabel
          Left = 307
          Top = 72
          Width = 61
          Height = 13
          Caption = 'After TX (ms)'
        end
        object Label36: TLabel
          Left = 9
          Top = 19
          Width = 66
          Height = 13
          Caption = 'Sound device'
        end
        object Label37: TLabel
          Left = 323
          Top = 19
          Width = 39
          Height = 13
          AutoSize = False
          Caption = 'Volume'
        end
        object Label40: TLabel
          Left = 339
          Top = 46
          Width = 19
          Height = 13
          Alignment = taRightJustify
          Caption = 'filter'
        end
        object comboRig4SoundDevice: TComboBox
          Left = 83
          Top = 16
          Width = 227
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
        object checkUseRig4F2A: TCheckBox
          Tag = 4
          Left = 8
          Top = 45
          Width = 70
          Height = 17
          Caption = 'Use F2A'
          TabOrder = 2
          OnClick = checkUseF2AClick
        end
        object checkUseRig4F2APtt: TCheckBox
          Tag = 4
          Left = 8
          Top = 71
          Width = 89
          Height = 17
          Caption = 'Enable PTT'
          TabOrder = 6
          OnClick = checkUseF2APttClick
        end
        object editRig4F2ABefore: TEdit
          Left = 225
          Top = 69
          Width = 40
          Height = 21
          TabOrder = 7
          OnKeyPress = NumberEditKeyPress
        end
        object editRig4F2AAfter: TEdit
          Left = 373
          Top = 69
          Width = 40
          Height = 21
          TabOrder = 8
          OnKeyPress = NumberEditKeyPress
        end
        object spinRig4F2AVolume: TSpinEdit
          Left = 367
          Top = 16
          Width = 46
          Height = 22
          MaxValue = 100
          MinValue = 1
          TabOrder = 1
          Value = 100
        end
        object comboRig4F2aDataMode: TComboBox
          Left = 249
          Top = 43
          Width = 45
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 4
          Text = 'D1'
          Items.Strings = (
            'D1'
            'D2'
            'D3')
        end
        object comboRig4F2aFilter: TComboBox
          Left = 363
          Top = 43
          Width = 50
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 5
          Text = 'FIL1'
          Items.Strings = (
            'FIL1'
            'FIL2'
            'FIL3')
        end
        object checkUseRig4F2ADataMode: TCheckBox
          Tag = 4
          Left = 136
          Top = 45
          Width = 107
          Height = 17
          Caption = 'Use DATAMODE'
          TabOrder = 3
          OnClick = checkUseF2ADataModeClick
        end
      end
    end
    object tabsheetRigControl: TTabSheet
      Caption = 'Rig control'
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
          Caption = 'Max Shift Width +/-'
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
          Caption = 'Use'
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
            Caption = 'Stop CQ'
            TabOrder = 2
          end
          object checkAntiZeroinAutoCancel: TCheckBox
            Left = 10
            Top = 85
            Width = 143
            Height = 17
            Caption = 'Auto Cancel'
            TabOrder = 3
          end
        end
      end
      object groupRcSleepMode: TGroupBox
        Left = 256
        Top = 4
        Width = 173
        Height = 81
        Caption = 'Supports sleep mode'
        TabOrder = 1
        object checkTurnoffSleep: TCheckBox
          Left = 8
          Top = 23
          Width = 164
          Height = 18
          Caption = 'Turn off when in sleep mode'
          TabOrder = 0
        end
        object checkTurnonResume: TCheckBox
          Left = 8
          Top = 47
          Width = 164
          Height = 18
          Caption = 'Turn on when resume'
          TabOrder = 1
        end
      end
      object groupRcGeneral: TGroupBox
        Left = 6
        Top = 4
        Width = 244
        Height = 224
        Caption = 'General settings'
        TabOrder = 0
        object Label45: TLabel
          Left = 8
          Top = 115
          Width = 114
          Height = 13
          Caption = 'Send current freq. every'
        end
        object Label46: TLabel
          Left = 215
          Top = 115
          Width = 20
          Height = 13
          Caption = 'sec.'
        end
        object cbAutoBandMap: TCheckBox
          Left = 8
          Top = 90
          Width = 206
          Height = 17
          Caption = 'Automatically create band scope'
          TabOrder = 0
          WordWrap = True
        end
        object cbDontAllowSameBand: TCheckBox
          Left = 8
          Top = 42
          Width = 233
          Height = 17
          Caption = 'Do not allow two rigs to be on same band'
          TabOrder = 1
          WordWrap = True
        end
        object cbRecordRigFreq: TCheckBox
          Left = 8
          Top = 66
          Width = 220
          Height = 19
          Caption = 'Record rig frequency in memo'
          TabOrder = 2
          WordWrap = True
        end
        object cbRITClear: TCheckBox
          Left = 8
          Top = 18
          Width = 161
          Height = 17
          Caption = 'Clear RIT after each QSO'
          TabOrder = 3
        end
        object checkIgnoreRigMode: TCheckBox
          Left = 8
          Top = 138
          Width = 141
          Height = 18
          Caption = 'Ignore rig mode'
          TabOrder = 4
        end
        object SendFreqEdit: TEdit
          Left = 163
          Top = 112
          Width = 30
          Height = 21
          Hint = 'Only when using Z-Server network'
          MaxLength = 3
          NumbersOnly = True
          TabOrder = 5
          Text = '60'
          OnKeyPress = NumberEditKeyPress
        end
        object updownSendFreqInterval: TUpDown
          Left = 193
          Top = 112
          Width = 16
          Height = 21
          Associate = SendFreqEdit
          Max = 300
          Position = 60
          TabOrder = 6
        end
        object checkUsePttCommand: TCheckBox
          Left = 8
          Top = 162
          Width = 141
          Height = 18
          Caption = 'Use PTT command'
          TabOrder = 7
        end
        object checkSyncRigWPM: TCheckBox
          Left = 8
          Top = 186
          Width = 141
          Height = 18
          Caption = 'Sync. rig WPM'
          TabOrder = 8
        end
      end
      object groupRcMemoryScan: TGroupBox
        Left = 256
        Top = 91
        Width = 172
        Height = 52
        Caption = 'Memory scan'
        TabOrder = 2
        object Label4: TLabel
          Left = 146
          Top = 22
          Width = 20
          Height = 13
          Caption = 'sec.'
        end
        object Label5: TLabel
          Left = 8
          Top = 22
          Width = 54
          Height = 13
          Caption = 'Scan every'
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
      Caption = 'Network'
      ImageIndex = 12
      object groupNetwork: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 101
        Caption = 'Z-Link'
        TabOrder = 0
        object Port: TLabel
          Left = 134
          Top = 14
          Width = 19
          Height = 13
          Caption = 'Port'
        end
        object Label32: TLabel
          Left = 8
          Top = 34
          Width = 41
          Height = 13
          Caption = 'Z-Server'
        end
        object Label55: TLabel
          Left = 8
          Top = 63
          Width = 45
          Height = 13
          Caption = 'PC Name'
        end
        object ZLinkCombo: TComboBox
          Left = 118
          Top = 31
          Width = 73
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnChange = ZLinkComboChange
          Items.Strings = (
            'None'
            'TELNET')
        end
        object buttonZLinkSettings: TButton
          Left = 201
          Top = 31
          Width = 102
          Height = 21
          Caption = 'TELNET settings'
          TabOrder = 2
          OnClick = buttonZLinkSettingsClick
        end
        object editZLinkPcName: TEdit
          Left = 118
          Top = 60
          Width = 101
          Height = 21
          TabOrder = 1
        end
      end
      object groupPacketCluster: TGroupBox
        Left = 6
        Top = 111
        Width = 423
        Height = 282
        Caption = 'Packet Cluster'
        TabOrder = 1
        object Label6: TLabel
          Left = 16
          Top = 79
          Width = 78
          Height = 13
          Caption = 'Force reconnect'
        end
        object Label7: TLabel
          Left = 246
          Top = 79
          Width = 26
          Height = 13
          Caption = 'hours'
        end
        object Label8: TLabel
          Left = 16
          Top = 23
          Width = 158
          Height = 13
          Caption = 'Maximum times to auto reconnect'
        end
        object Label9: TLabel
          Left = 16
          Top = 51
          Width = 110
          Height = 13
          Caption = 'Auto reconnect interval'
        end
        object Label10: TLabel
          Left = 246
          Top = 23
          Width = 24
          Height = 13
          Caption = 'times'
        end
        object Label11: TLabel
          Left = 246
          Top = 51
          Width = 40
          Height = 13
          Caption = 'seconds'
        end
        object Label12: TLabel
          Left = 160
          Top = 79
          Width = 26
          Height = 13
          Caption = 'every'
        end
        object buttonSpotterList: TButton
          Left = 312
          Top = 247
          Width = 102
          Height = 21
          Caption = 'Spotter list'
          TabOrder = 7
          OnClick = buttonSpotterListClick
        end
        object listviewPacketCluster: TListView
          Left = 14
          Top = 112
          Width = 400
          Height = 129
          Columns = <
            item
              Caption = '#'
              Width = 30
            end
            item
              Caption = 'Name'
              Width = 80
            end
            item
              Caption = 'Site'
              Width = 200
            end
            item
              Caption = 'Login'
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 3
          ViewStyle = vsReport
          OnDblClick = listviewPacketClusterDblClick
          OnSelectItem = listviewPacketClusterSelectItem
        end
        object buttonClusterAdd: TButton
          Left = 14
          Top = 247
          Width = 83
          Height = 21
          Caption = 'Add'
          TabOrder = 4
          OnClick = buttonClusterAddClick
        end
        object buttonClusterEdit: TButton
          Left = 103
          Top = 247
          Width = 83
          Height = 21
          Caption = 'Edit'
          Enabled = False
          TabOrder = 5
          OnClick = buttonClusterEditClick
        end
        object buttonClusterDelete: TButton
          Left = 192
          Top = 247
          Width = 83
          Height = 21
          Caption = 'Delete'
          Enabled = False
          TabOrder = 6
          OnClick = buttonClusterDeleteClick
        end
        object spForceReconnectIntervalHour: TSpinEdit
          Left = 192
          Top = 76
          Width = 48
          Height = 22
          AutoSize = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 6
        end
        object spMaxAutoReconnect: TSpinEdit
          Left = 192
          Top = 20
          Width = 48
          Height = 22
          AutoSize = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 10
        end
        object spAutoReconnectIntervalSec: TSpinEdit
          Left = 192
          Top = 48
          Width = 48
          Height = 22
          AutoSize = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 180
        end
      end
    end
    object tabsheetPath: TTabSheet
      Caption = 'Folders'
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
        Caption = 'Logs'
      end
      object Label56: TLabel
        Left = 8
        Top = 94
        Width = 40
        Height = 13
        Caption = 'Back up'
      end
      object Label74: TLabel
        Left = 8
        Top = 119
        Width = 31
        Height = 13
        Caption = 'Sound'
      end
      object Label90: TLabel
        Left = 8
        Top = 144
        Width = 34
        Height = 13
        Caption = 'Plugins'
      end
      object Label108: TLabel
        Left = 8
        Top = 19
        Width = 44
        Height = 13
        Caption = 'zLog root'
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
        Caption = 'Browse...'
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
        Caption = 'Browse...'
        TabOrder = 5
        OnClick = BrowsePathClick
      end
      object buttonBrowseBackupPath: TButton
        Tag = 30
        Left = 360
        Top = 92
        Width = 65
        Height = 20
        Caption = 'Browse...'
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
        Caption = 'Browse...'
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
        Caption = 'Browse...'
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
        Caption = 'Browse...'
        TabOrder = 1
        OnClick = BrowsePathClick
      end
      object buttonBrowseSpcPath: TButton
        Tag = 60
        Left = 360
        Top = 167
        Width = 65
        Height = 20
        Caption = 'Browse...'
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
      Caption = 'Font'
      ImageIndex = 13
      object GroupBox21: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 105
        Caption = 'Font'
        TabOrder = 0
        object Label102: TLabel
          Left = 12
          Top = 23
          Width = 60
          Height = 13
          Caption = 'Callsign Font'
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
          FontName = '@HG'#34892#26360#20307
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #65325#65331' '#12468#12471#12483#12463
          Font.Style = []
          ItemIndex = 6
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
    Top = 434
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
end
