object formELogCabrillo: TformELogCabrillo
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Create Cabrillo'
  ClientHeight = 661
  ClientWidth = 714
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 623
    Width = 714
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 632
    ExplicitWidth = 711
    object buttonCreateLog: TButton
      Left = 304
      Top = 8
      Width = 89
      Height = 23
      Caption = 'Create Cabrillo'
      TabOrder = 0
      OnClick = buttonCreateLogClick
    end
    object buttonSave: TButton
      Left = 201
      Top = 8
      Width = 89
      Height = 23
      Caption = 'Save'
      TabOrder = 1
      OnClick = buttonSaveClick
    end
    object buttonCancel: TButton
      Left = 409
      Top = 8
      Width = 89
      Height = 23
      Caption = 'Close'
      TabOrder = 2
      OnClick = buttonCancelClick
    end
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 714
    Height = 623
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 687
    ExplicitHeight = 624
    object Label3: TLabel
      Left = 16
      Top = 11
      Width = 62
      Height = 15
      Caption = 'CALLSIGN:'
    end
    object Label4: TLabel
      Left = 16
      Top = 40
      Width = 59
      Height = 15
      Caption = 'CONTEST:'
    end
    object Label5: TLabel
      Left = 16
      Top = 69
      Width = 128
      Height = 15
      Caption = 'CATEGORY-ASSISTED:'
    end
    object Label6: TLabel
      Left = 350
      Top = 69
      Width = 103
      Height = 15
      Caption = 'CATEGORY-BAND:'
    end
    object Label7: TLabel
      Left = 16
      Top = 98
      Width = 105
      Height = 15
      Caption = 'CATEGORY-MODE:'
    end
    object Label8: TLabel
      Left = 350
      Top = 98
      Width = 135
      Height = 15
      Caption = 'CATEGORY-OPERATOR:'
    end
    object Label9: TLabel
      Left = 16
      Top = 127
      Width = 115
      Height = 15
      Caption = 'CATEGORY-POWER:'
    end
    object Label1: TLabel
      Left = 350
      Top = 185
      Width = 79
      Height = 15
      Caption = 'CERTIFICATE:'
    end
    object Label10: TLabel
      Left = 350
      Top = 127
      Width = 118
      Height = 15
      Caption = 'CATEGORY-STATION:'
    end
    object Label11: TLabel
      Left = 16
      Top = 156
      Width = 97
      Height = 15
      Caption = 'CATEGORY-TIME:'
    end
    object Label12: TLabel
      Left = 350
      Top = 156
      Width = 153
      Height = 15
      Caption = 'CATEGORY-TRANSMITTER:'
    end
    object Label13: TLabel
      Left = 16
      Top = 185
      Width = 122
      Height = 15
      Caption = 'CATEGORY-OVERLAY:'
    end
    object Label15: TLabel
      Left = 16
      Top = 243
      Width = 36
      Height = 15
      Caption = 'CLUB:'
    end
    object Label17: TLabel
      Left = 16
      Top = 272
      Width = 37
      Height = 15
      Caption = 'EMAIL:'
    end
    object Label18: TLabel
      Left = 16
      Top = 301
      Width = 93
      Height = 15
      Caption = 'GRID-LOCATOR:'
    end
    object Label19: TLabel
      Left = 16
      Top = 330
      Width = 62
      Height = 15
      Caption = 'LOCATION:'
    end
    object Label2: TLabel
      Left = 16
      Top = 214
      Width = 102
      Height = 15
      Caption = 'CLAIMED-SCORE:'
    end
    object Label20: TLabel
      Left = 16
      Top = 359
      Width = 36
      Height = 15
      Caption = 'NAME:'
    end
    object Label21: TLabel
      Left = 16
      Top = 388
      Width = 61
      Height = 15
      Caption = 'ADDRESS:'
    end
    object Label22: TLabel
      Left = 16
      Top = 417
      Width = 90
      Height = 15
      Caption = 'ADDRESS-CITY:'
    end
    object Label23: TLabel
      Left = 16
      Top = 446
      Width = 166
      Height = 15
      Caption = 'ADDRESS-STATE-PROVINCE:'
    end
    object Label24: TLabel
      Left = 16
      Top = 475
      Width = 145
      Height = 15
      Caption = 'ADDRESS-POSTALCODE:'
    end
    object Label25: TLabel
      Left = 16
      Top = 504
      Width = 123
      Height = 15
      Caption = 'ADDRESS-COUNTRY:'
    end
    object Label26: TLabel
      Left = 16
      Top = 533
      Width = 76
      Height = 15
      Caption = 'OPERATORS:'
    end
    object Label27: TLabel
      Left = 16
      Top = 562
      Width = 53
      Height = 15
      Caption = 'OFFTIME:'
    end
    object Label28: TLabel
      Left = 16
      Top = 591
      Width = 59
      Height = 15
      Caption = 'SOAPBOX:'
    end
    object Label29: TLabel
      Left = 356
      Top = 330
      Width = 287
      Height = 15
      Caption = 'ARRL/RAC Sections,IOTA Island Name,RDA Number'
    end
    object comboAssisted: TComboBox
      Left = 189
      Top = 66
      Width = 150
      Height = 23
      Style = csDropDownList
      ImeMode = imClose
      ItemIndex = 0
      TabOrder = 2
      Text = 'ASSISTED'
      Items.Strings = (
        'ASSISTED'
        'NON-ASSISTED')
    end
    object comboBand: TComboBox
      Left = 523
      Top = 66
      Width = 150
      Height = 23
      Style = csDropDownList
      ImeMode = imClose
      ItemIndex = 0
      TabOrder = 3
      Text = 'ALL'
      Items.Strings = (
        'ALL'
        '160M'
        '80M'
        '40M'
        '20M'
        '15M'
        '10M'
        '6M'
        '4M'
        '2M'
        '222'
        '432'
        '902'
        '1.2G'
        '2.3G'
        '3.4G'
        '5.7G'
        '10G'
        '24G'
        '47G'
        '75G'
        '122G'
        '134G'
        '241G'
        'Light'
        'VHF-3-BAND and VHF-FM-ONLY')
    end
    object comboCertificate: TComboBox
      Left = 523
      Top = 182
      Width = 150
      Height = 23
      ImeMode = imClose
      ItemIndex = 0
      TabOrder = 11
      Text = 'YES'
      Items.Strings = (
        'YES'
        'NO')
    end
    object comboContest: TComboBox
      Left = 189
      Top = 37
      Width = 150
      Height = 23
      ImeMode = imClose
      MaxLength = 32
      TabOrder = 1
      Items.Strings = (
        'ARRL-10'
        'ARRL-10-GHZ'
        'ARRL-160'
        'ARRL-DIGI'
        'ARRL-DX-CW'
        'ARRL-DX-SSB'
        'ARRL-EME'
        'ARRL-SS-CW'
        'ARRL-SS-SSB'
        'BARTG-RTTY'
        'CQ-160-CW'
        'CQ-160-SSB'
        'CQ-WPX-CW'
        'CQ-WPX-RTTY'
        'CQ-WPX-SSB'
        'CQ-VHF'
        'CQ-WW-CW'
        'CQ-WW-RTTY'
        'CQ-WW-SSB'
        'IARU-HF'
        'NAQP-CW'
        'NAQP-SSB'
        'NAQP-RTTY'
        'RDXC'
        'RSGB-IOTA'
        'SPDXC'
        'SPDXC-RTTY'
        'TARA-RTTY'
        'WAG'
        'WW-DIGI')
    end
    object comboLocation: TComboBox
      Left = 189
      Top = 327
      Width = 145
      Height = 23
      ImeMode = imClose
      TabOrder = 16
      TextHint = 
        'Used to indicate the location where the station was operating fr' +
        'om.'
    end
    object comboMode: TComboBox
      Left = 189
      Top = 95
      Width = 150
      Height = 23
      Style = csDropDownList
      ImeMode = imClose
      ItemIndex = 0
      TabOrder = 4
      Text = 'CW'
      Items.Strings = (
        'CW'
        'DIGI'
        'FM'
        'RTTY'
        'SSB'
        'MIXED')
    end
    object comboOperator: TComboBox
      Left = 523
      Top = 95
      Width = 150
      Height = 23
      Style = csDropDownList
      ImeMode = imClose
      ItemIndex = 0
      TabOrder = 5
      Text = 'SINGLE-OP'
      Items.Strings = (
        'SINGLE-OP'
        'MULTI-OP'
        'CHECKLOG')
    end
    object comboOverlay: TComboBox
      Left = 189
      Top = 182
      Width = 150
      Height = 23
      ImeMode = imClose
      TabOrder = 10
      Items.Strings = (
        'CLASSIC'
        'ROOKIE'
        'TB-WIRES'
        'YOUTH'
        'NOVICE-TECH'
        'YL')
    end
    object comboPower: TComboBox
      Left = 189
      Top = 124
      Width = 150
      Height = 23
      Style = csDropDownList
      ImeMode = imClose
      ItemIndex = 0
      TabOrder = 6
      Text = 'HIGH'
      Items.Strings = (
        'HIGH'
        'LOW'
        'QRP')
    end
    object comboStation: TComboBox
      Left = 523
      Top = 124
      Width = 150
      Height = 23
      Style = csDropDownList
      ImeMode = imClose
      ItemIndex = 0
      TabOrder = 7
      Text = 'DISTRIBUTED'
      Items.Strings = (
        'DISTRIBUTED'
        'FIXED'
        'MOBILE'
        'PORTABLE'
        'ROVER'
        'ROVER-LIMITED'
        'ROVER-UNLIMITED'
        'EXPEDITION'
        'HQ'
        'SCHOOL'
        'EXPLORER')
    end
    object comboTime: TComboBox
      Left = 189
      Top = 153
      Width = 150
      Height = 23
      ImeMode = imClose
      TabOrder = 8
      Items.Strings = (
        '6-HOURS'
        '8-HOURS'
        '12-HOURS'
        '24-HOURS')
    end
    object comboTransmitter: TComboBox
      Left = 523
      Top = 153
      Width = 150
      Height = 23
      Style = csDropDownList
      ImeMode = imClose
      ItemIndex = 0
      TabOrder = 9
      Text = 'ONE'
      Items.Strings = (
        'ONE'
        'TWO'
        'LIMITED'
        'UNLIMITED'
        'SWL')
    end
    object editAddress: TEdit
      Left = 189
      Top = 385
      Width = 484
      Height = 23
      ImeMode = imClose
      MaxLength = 45
      TabOrder = 18
      TextHint = 
        'Mailing address. Each line should be a maximum of 45 characters ' +
        'long. Up to 6 address lines are permitted.'
    end
    object editAddressCity: TEdit
      Left = 189
      Top = 414
      Width = 242
      Height = 23
      ImeMode = imClose
      TabOrder = 19
      TextHint = 'Optional fields for providing mailing address details.'
    end
    object editAddressCountry: TEdit
      Left = 189
      Top = 501
      Width = 242
      Height = 23
      ImeMode = imClose
      TabOrder = 22
      TextHint = 'Optional fields for providing mailing address details.'
    end
    object editAddressPostalcode: TEdit
      Left = 189
      Top = 472
      Width = 242
      Height = 23
      ImeMode = imClose
      TabOrder = 21
      TextHint = 'Optional fields for providing mailing address details.'
    end
    object editAddressStateProvince: TEdit
      Left = 189
      Top = 443
      Width = 242
      Height = 23
      ImeMode = imClose
      TabOrder = 20
      TextHint = 'Optional fields for providing mailing address details.'
    end
    object editCallsign: TEdit
      Left = 189
      Top = 8
      Width = 150
      Height = 23
      ImeMode = imClose
      TabOrder = 0
      TextHint = 'The callsign used during the contest.'
    end
    object editClaimedScore: TEdit
      Left = 189
      Top = 211
      Width = 150
      Height = 23
      ImeMode = imClose
      TabOrder = 12
    end
    object editClub: TEdit
      Left = 189
      Top = 240
      Width = 484
      Height = 23
      ImeMode = imClose
      TabOrder = 13
      TextHint = 'Name of the radio club to which the score should be applied.'
    end
    object editEmail: TEdit
      Left = 189
      Top = 269
      Width = 484
      Height = 23
      ImeMode = imClose
      TabOrder = 14
      TextHint = 
        'Contact email address for the entrant. Must be valid email or bl' +
        'ank.'
    end
    object editGridLocator: TEdit
      Left = 189
      Top = 298
      Width = 76
      Height = 23
      ImeMode = imClose
      MaxLength = 6
      TabOrder = 15
    end
    object editName: TEdit
      Left = 189
      Top = 356
      Width = 484
      Height = 23
      ImeMode = imClose
      MaxLength = 75
      TabOrder = 17
      TextHint = 'Name. Maximum of 75 characters long.'
    end
    object editOfftime: TEdit
      Left = 189
      Top = 559
      Width = 242
      Height = 23
      ImeMode = imClose
      TabOrder = 24
      TextHint = 'yyyy-mm-dd nnnn yyyy-mm-dd nnnn'
    end
    object editOperators: TEdit
      Left = 189
      Top = 530
      Width = 484
      Height = 23
      ImeMode = imClose
      MaxLength = 75
      TabOrder = 23
      TextHint = 
        'The OPERATOR line is a maximum of 75 characters long and must be' +
        'gin with OPERATORS: followed by a space. Use multiple OPERATOR l' +
        'ines if needed.'
    end
    object editSoapbox: TEdit
      Left = 189
      Top = 588
      Width = 484
      Height = 23
      ImeMode = imClose
      MaxLength = 75
      TabOrder = 25
      TextHint = 
        'Soapbox comments. Enter as many lines of soapbox text as you wis' +
        'h. Each line is a maximum of 75 characters long and must begin w' +
        'ith SOAPBOX: followed by a space.'
    end
    object GroupBox1: TGroupBox
      Left = 518
      Top = 8
      Width = 155
      Height = 47
      Caption = 'Time zone'
      TabOrder = 26
      object radioUTC: TRadioButton
        Left = 20
        Top = 20
        Width = 57
        Height = 17
        Caption = 'UTC'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object radioJST: TRadioButton
        Left = 92
        Top = 20
        Width = 57
        Height = 17
        Caption = 'JST'
        TabOrder = 1
      end
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'CBR'
    Filter = 'Cabrillo file (*.CBR)|*.CBR|'#20840#12390#12398#12501#12449#12452#12523'|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save Cabrillo file'
    Left = 400
    Top = 4
  end
end
