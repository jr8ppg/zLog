object Options: TOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #35373#23450
  ClientHeight = 584
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    538
    584)
  TextHeight = 12
  object GroupBox2: TGroupBox
    Left = 8
    Top = 119
    Width = 518
    Height = 141
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Z-Server'
    TabOrder = 1
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
      Width = 183
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
    object GroupBox1: TGroupBox
      Left = 277
      Top = 17
      Width = 227
      Height = 114
      Caption = #12475#12461#12517#12450#12514#12540#12489
      TabOrder = 3
      object Label2: TLabel
        Left = 8
        Top = 52
        Width = 59
        Height = 12
        Caption = #12518#12540#12470#12540'ID'
      end
      object Label3: TLabel
        Left = 8
        Top = 79
        Width = 54
        Height = 12
        Caption = #12497#12473#12527#12540#12489
      end
      object checkUseSecure: TCheckBox
        Left = 8
        Top = 24
        Width = 161
        Height = 16
        Caption = #12475#12461#12517#12450#12514#12540#12489#12434#20351#29992#12377#12427
        TabOrder = 0
      end
      object editUserPassword: TEdit
        Left = 79
        Top = 76
        Width = 137
        Height = 20
        TabOrder = 2
      end
      object editUserId: TEdit
        Left = 79
        Top = 49
        Width = 137
        Height = 20
        TabOrder = 1
      end
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 8
    Width = 518
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
    Top = 554
    Width = 538
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 525
    DesignSize = (
      538
      30)
    object buttonCancel: TButton
      Left = 277
      Top = 1
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
    end
    object buttonOK: TButton
      Left = 190
      Top = 1
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = buttonOKClick
    end
  end
  object groupPacketCluster: TGroupBox
    Left = 8
    Top = 266
    Width = 518
    Height = 282
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Packet Cluster'
    TabOrder = 2
    DesignSize = (
      518
      282)
    object Label10: TLabel
      Left = 16
      Top = 79
      Width = 60
      Height = 12
      Caption = #24375#21046#20877#25509#32154
    end
    object Label11: TLabel
      Left = 246
      Top = 79
      Width = 36
      Height = 12
      Caption = #26178#38291#27598
    end
    object Label12: TLabel
      Left = 16
      Top = 23
      Width = 120
      Height = 12
      Caption = #33258#21205#20877#25509#32154#12398#26368#22823#22238#25968
    end
    object Label13: TLabel
      Left = 16
      Top = 51
      Width = 132
      Height = 12
      Caption = #33258#21205#20877#25509#32154#12398#20877#35430#34892#38291#38548
    end
    object Label14: TLabel
      Left = 246
      Top = 23
      Width = 12
      Height = 12
      Caption = #22238
    end
    object Label15: TLabel
      Left = 246
      Top = 51
      Width = 12
      Height = 12
      Caption = #31186
    end
    object buttonSpotterList: TButton
      Left = 402
      Top = 247
      Width = 102
      Height = 21
      Anchors = [akTop, akRight]
      Caption = #12473#12509#12483#12479#12540#12522#12473#12488
      TabOrder = 12
      OnClick = buttonSpotterListClick
    end
    object listviewPacketCluster: TListView
      Left = 14
      Top = 112
      Width = 490
      Height = 129
      Anchors = [akLeft, akTop, akRight]
      Columns = <
        item
          Caption = '#'
          Width = 30
        end
        item
          Caption = #35373#23450#21517
          Width = 80
        end
        item
          Caption = #25509#32154#20808
          Width = 200
        end
        item
          Caption = #12525#12464#12452#12531'ID'
          Width = 100
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 8
      ViewStyle = vsReport
      OnDblClick = listviewPacketClusterDblClick
      OnSelectItem = listviewPacketClusterSelectItem
    end
    object buttonClusterAdd: TButton
      Left = 14
      Top = 247
      Width = 83
      Height = 21
      Caption = #36861#21152
      TabOrder = 9
      OnClick = buttonClusterAddClick
    end
    object buttonClusterEdit: TButton
      Left = 103
      Top = 247
      Width = 83
      Height = 21
      Caption = #32232#38598
      Enabled = False
      TabOrder = 10
      OnClick = buttonClusterEditClick
    end
    object buttonClusterDelete: TButton
      Left = 192
      Top = 247
      Width = 83
      Height = 21
      Caption = #21066#38500
      Enabled = False
      TabOrder = 11
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
    object checkAutoLogin: TCheckBox
      Left = 366
      Top = 14
      Width = 121
      Height = 17
      Anchors = [akTop, akRight]
      Caption = #33258#21205#12525#12464#12452#12531
      TabOrder = 3
    end
    object checkAutoReconnect: TCheckBox
      Left = 366
      Top = 33
      Width = 121
      Height = 17
      Anchors = [akTop, akRight]
      Caption = #33258#21205#20877#25509#32154
      TabOrder = 4
    end
    object checkRecordLogs: TCheckBox
      Left = 366
      Top = 52
      Width = 121
      Height = 17
      Anchors = [akTop, akRight]
      Caption = #21463#20449#12525#12464#12434#20445#23384
      TabOrder = 5
    end
    object checkUseAllowDenyLists: TCheckBox
      Left = 366
      Top = 71
      Width = 135
      Height = 17
      Anchors = [akTop, akRight]
      Caption = #35377#21487'/'#25298#21542#12522#12473#12488#12434#20351#29992
      TabOrder = 6
    end
    object checkForceReconnect: TCheckBox
      Left = 366
      Top = 90
      Width = 167
      Height = 17
      Caption = #24375#21046#20877#25509#32154#12434#20351#29992
      TabOrder = 7
    end
  end
end
