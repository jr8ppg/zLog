object Options: TOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #35373#23450
  ClientHeight = 416
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    431
    416)
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 126
    Width = 415
    Height = 131
    Anchors = [akLeft, akTop, akRight]
    Caption = 'PacketCluster'
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 30
      Height = 12
      Caption = #12507#12473#12488
    end
    object Label2: TLabel
      Left = 16
      Top = 50
      Width = 31
      Height = 12
      Caption = #12509#12540#12488
    end
    object Label3: TLabel
      Left = 16
      Top = 76
      Width = 24
      Height = 12
      Caption = #25913#34892
    end
    object Label9: TLabel
      Left = 16
      Top = 106
      Width = 52
      Height = 12
      Caption = #12525#12464#12452#12531'ID'
    end
    object comboClusterHost: TComboBox
      Left = 80
      Top = 21
      Width = 246
      Height = 20
      TabOrder = 0
    end
    object editClusterPort: TEdit
      Left = 80
      Top = 47
      Width = 57
      Height = 20
      ImeMode = imClose
      NumbersOnly = True
      TabOrder = 1
    end
    object comboClusterLineBreak: TComboBox
      Left = 80
      Top = 73
      Width = 57
      Height = 20
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 2
      Text = 'CRLF'
      Items.Strings = (
        'CRLF'
        'CR'
        'LF')
    end
    object checkAutoLogin: TCheckBox
      Left = 277
      Top = 49
      Width = 121
      Height = 17
      Caption = 'Auto Login'
      TabOrder = 4
    end
    object checkAutoReconnect: TCheckBox
      Left = 277
      Top = 68
      Width = 121
      Height = 17
      Caption = 'Auto Reconnect'
      TabOrder = 5
    end
    object checkRecordLogs: TCheckBox
      Left = 277
      Top = 87
      Width = 121
      Height = 17
      Caption = 'Record logs'
      TabOrder = 6
    end
    object editLoginID: TEdit
      Left = 80
      Top = 103
      Width = 138
      Height = 20
      AutoSize = False
      BiDiMode = bdLeftToRight
      ImeMode = imClose
      ParentBiDiMode = False
      TabOrder = 3
    end
    object checkUseAllowDenyLists: TCheckBox
      Left = 277
      Top = 106
      Width = 135
      Height = 17
      Caption = 'Use Allow/Deny Lists'
      TabOrder = 7
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 269
    Width = 415
    Height = 108
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Z-Server'
    TabOrder = 2
    object Label4: TLabel
      Left = 16
      Top = 50
      Width = 30
      Height = 12
      Caption = #12507#12473#12488
    end
    object Label5: TLabel
      Left = 16
      Top = 76
      Width = 31
      Height = 12
      Caption = #12509#12540#12488
    end
    object Label8: TLabel
      Left = 16
      Top = 24
      Width = 58
      Height = 12
      Caption = #12371#12398#31471#26411#21517
    end
    object comboZServerHost: TComboBox
      Left = 80
      Top = 47
      Width = 246
      Height = 20
      TabOrder = 1
      Items.Strings = (
        '127.0.0.1')
    end
    object editZServerPort: TEdit
      Left = 80
      Top = 73
      Width = 57
      Height = 20
      ImeMode = imClose
      NumbersOnly = True
      TabOrder = 2
    end
    object editZServerClientName: TEdit
      Left = 80
      Top = 21
      Width = 120
      Height = 20
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 8
    Width = 415
    Height = 105
    Anchors = [akLeft, akTop, akRight]
    Caption = #20840#33324
    TabOrder = 0
    object Label6: TLabel
      Left = 16
      Top = 24
      Width = 123
      Height = 12
      Caption = #12473#12509#12483#12488#24773#22577#12398#29983#23384#26178#38291
    end
    object Label7: TLabel
      Left = 206
      Top = 24
      Width = 12
      Height = 12
      Caption = #20998
    end
    object editSpotExpire: TEdit
      Left = 145
      Top = 21
      Width = 40
      Height = 20
      ImeMode = imClose
      NumbersOnly = True
      TabOrder = 0
      Text = '10'
    end
    object updownSpotExpire: TUpDown
      Left = 185
      Top = 21
      Width = 16
      Height = 20
      Associate = editSpotExpire
      Min = 1
      Max = 300
      Position = 10
      TabOrder = 1
    end
    object GroupBox4: TGroupBox
      Left = 16
      Top = 47
      Width = 305
      Height = 48
      Caption = #24773#22577#12464#12523#12540#12503
      TabOrder = 2
      object radioCmdSpot: TRadioButton
        Left = 24
        Top = 18
        Width = 57
        Height = 17
        Caption = 'G1'
        TabOrder = 0
      end
      object radioCmdSpot2: TRadioButton
        Left = 96
        Top = 18
        Width = 57
        Height = 17
        Caption = 'G2'
        TabOrder = 1
      end
      object radioCmdSpot3: TRadioButton
        Left = 169
        Top = 18
        Width = 57
        Height = 17
        Caption = 'G3'
        TabOrder = 2
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 386
    Width = 431
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      431
      30)
    object buttonCancel: TButton
      Left = 346
      Top = 2
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 0
    end
    object buttonOK: TButton
      Left = 259
      Top = 2
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      TabOrder = 1
      OnClick = buttonOKClick
    end
  end
end
