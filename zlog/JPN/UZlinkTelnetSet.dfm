object formZLinkTelnetSet: TformZLinkTelnetSet
  Left = 28
  Top = 271
  BorderStyle = bsDialog
  Caption = 'Z-Link TELNET settings'
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
    Caption = 'Network'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 23
      Width = 51
      Height = 13
      Caption = 'Host name'
    end
    object Label4: TLabel
      Left = 8
      Top = 55
      Width = 19
      Height = 13
      Caption = 'Port'
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
    Caption = 'Security'
    TabOrder = 2
    object Label2: TLabel
      Left = 8
      Top = 52
      Width = 51
      Height = 13
      Caption = 'User name'
    end
    object Label3: TLabel
      Left = 8
      Top = 79
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object checkUseSecure: TCheckBox
      Left = 8
      Top = 24
      Width = 129
      Height = 16
      Caption = 'Use secure mode'
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
