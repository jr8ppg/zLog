object formZLinkTelnetSet: TformZLinkTelnetSet
  Left = 28
  Top = 271
  BorderStyle = bsDialog
  Caption = 'Z-Link'#35373#23450
  ClientHeight = 269
  ClientWidth = 266
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    266
    269)
  TextHeight = 13
  object buttonOK: TButton
    Left = 59
    Top = 238
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = buttonOKClick
    ExplicitTop = 128
  end
  object buttonCancel: TButton
    Left = 141
    Top = 238
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 3
    ExplicitTop = 128
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 250
    Height = 89
    Caption = #12493#12483#12488#12527#12540#12463#35373#23450
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 23
      Width = 51
      Height = 13
      Caption = #12507#12473#12488#21517
    end
    object Label4: TLabel
      Left = 8
      Top = 55
      Width = 19
      Height = 13
      Caption = #12509#12540#12488
    end
    object comboHostName: TComboBox
      Left = 70
      Top = 20
      Width = 169
      Height = 21
      TabOrder = 0
      Text = 'Host name'
    end
    object comboPort: TComboBox
      Left = 70
      Top = 52
      Width = 97
      Height = 21
      TabOrder = 1
      Items.Strings = (
        'telnet')
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 111
    Width = 250
    Height = 114
    Caption = #12475#12461#12517#12450#12458#12503#12471#12519#12531
    TabOrder = 2
    object Label2: TLabel
      Left = 8
      Top = 52
      Width = 51
      Height = 13
      Caption = #12518#12540#12470#12540'ID'
    end
    object Label3: TLabel
      Left = 8
      Top = 79
      Width = 46
      Height = 13
      Caption = #12497#12473#12527#12540#12489
    end
    object checkUseSecure: TCheckBox
      Left = 8
      Top = 24
      Width = 170
      Height = 16
      Caption = #12475#12461#12517#12450#12514#12540#12489#12434#20351#12358
      TabOrder = 0
    end
    object editUserPassword: TEdit
      Left = 71
      Top = 76
      Width = 137
      Height = 21
      TabOrder = 2
    end
    object editUserId: TEdit
      Left = 71
      Top = 49
      Width = 137
      Height = 21
      TabOrder = 1
    end
  end
end
