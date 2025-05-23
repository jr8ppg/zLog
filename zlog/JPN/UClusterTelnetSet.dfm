object formClusterTelnetSet: TformClusterTelnetSet
  Left = 180
  Top = 157
  BorderStyle = bsDialog
  Caption = 'TELNET settings'
  ClientHeight = 304
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
    304)
  TextHeight = 13
  object buttonOK: TButton
    Left = 75
    Top = 272
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = buttonOKClick
    ExplicitTop = 152
  end
  object buttonCancel: TButton
    Left = 157
    Top = 272
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 2
    ExplicitTop = 152
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 282
    Height = 257
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 46
      Width = 51
      Height = 13
      Caption = #12507#12473#12488#21517
    end
    object Label2: TLabel
      Left = 8
      Top = 107
      Width = 50
      Height = 13
      Caption = #25913#34892#12467#12540#12489
    end
    object Label3: TLabel
      Left = 177
      Top = 77
      Width = 29
      Height = 13
      Caption = 'Port #'
    end
    object Label4: TLabel
      Left = 8
      Top = 15
      Width = 62
      Height = 13
      Caption = #35373#23450#21517
    end
    object Label5: TLabel
      Left = 8
      Top = 77
      Width = 40
      Height = 13
      Caption = #12525#12464#12452#12531'ID'
    end
    object Label6: TLabel
      Left = 9
      Top = 138
      Width = 52
      Height = 13
      Caption = #12467#12510#12531#12489
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
      Height = 21
      TabOrder = 1
    end
    object comboLineBreak: TComboBox
      Left = 80
      Top = 105
      Width = 65
      Height = 21
      ItemIndex = 0
      TabOrder = 4
      Text = 'CR + LF'
      Items.Strings = (
        'CR + LF'
        'CR'
        'LF')
    end
    object spPortNumber: TSpinEdit
      Left = 212
      Top = 74
      Width = 61
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
      Height = 21
      TabOrder = 0
      OnExit = editSettingNameExit
    end
    object editLoginId: TEdit
      Left = 80
      Top = 74
      Width = 81
      Height = 21
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
  end
end
