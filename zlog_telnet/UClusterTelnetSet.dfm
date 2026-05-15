object formClusterTelnetSet: TformClusterTelnetSet
  Left = 180
  Top = 157
  BorderStyle = bsDialog
  Caption = 'TELNET settings'
  ClientHeight = 376
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  DesignSize = (
    297
    376)
  TextHeight = 12
  object buttonOK: TButton
    Left = 75
    Top = 344
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = buttonOKClick
    ExplicitTop = 272
  end
  object buttonCancel: TButton
    Left = 157
    Top = 344
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    ExplicitTop = 272
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 282
    Height = 329
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 46
      Width = 42
      Height = 12
      Caption = #12507#12473#12488#21517
    end
    object Label2: TLabel
      Left = 8
      Top = 107
      Width = 54
      Height = 12
      Caption = #25913#34892#12467#12540#12489
    end
    object Label3: TLabel
      Left = 177
      Top = 77
      Width = 37
      Height = 12
      Caption = #12509#12540#12488'#'
    end
    object Label4: TLabel
      Left = 8
      Top = 15
      Width = 36
      Height = 12
      Caption = #35373#23450#21517
    end
    object Label5: TLabel
      Left = 8
      Top = 77
      Width = 52
      Height = 12
      Caption = #12525#12464#12452#12531'ID'
    end
    object Label6: TLabel
      Left = 8
      Top = 138
      Width = 39
      Height = 12
      Caption = #12467#12510#12531#12489
    end
    object Label13: TLabel
      Left = 28
      Top = 295
      Width = 87
      Height = 12
      Caption = #12467#12510#12531#12489#23455#34892#38291#38548
    end
    object Label15: TLabel
      Left = 238
      Top = 295
      Width = 12
      Height = 12
      Caption = #31186
    end
    object checkLocalEcho: TCheckBox
      Left = 176
      Top = 106
      Width = 97
      Height = 17
      Caption = #12525#12540#12459#12523#12456#12467#12540
      TabOrder = 5
    end
    object comboHostName: TComboBox
      Left = 80
      Top = 43
      Width = 193
      Height = 20
      TabOrder = 1
    end
    object comboLineBreak: TComboBox
      Left = 80
      Top = 105
      Width = 65
      Height = 20
      ItemIndex = 0
      TabOrder = 4
      Text = 'CR + LF'
      Items.Strings = (
        'CR + LF'
        'CR'
        'LF')
    end
    object spPortNumber: TSpinEdit
      Left = 220
      Top = 74
      Width = 53
      Height = 22
      AutoSize = False
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 23
    end
    object editSettingName: TEdit
      Left = 80
      Top = 12
      Width = 137
      Height = 20
      TabOrder = 0
      OnExit = editSettingNameExit
    end
    object editLoginId: TEdit
      Left = 80
      Top = 74
      Width = 81
      Height = 20
      TabOrder = 2
    end
    object memoCommands: TMemo
      Left = 80
      Top = 138
      Width = 193
      Height = 108
      ScrollBars = ssVertical
      TabOrder = 6
      WordWrap = False
    end
    object spExecInterval: TSpinEdit
      Left = 184
      Top = 292
      Width = 48
      Height = 22
      AutoSize = False
      MaxValue = 0
      MinValue = 0
      TabOrder = 7
      Value = 180
    end
    object checkUsePeriodicCmdExec: TCheckBox
      Left = 8
      Top = 264
      Width = 153
      Height = 17
      Caption = #12467#12510#12531#12489#23450#26399#23455#34892#12434#34892#12358
      TabOrder = 8
    end
  end
end
