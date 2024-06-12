object formZLinkTelnetSet: TformZLinkTelnetSet
  Left = 28
  Top = 271
  BorderStyle = bsDialog
  Caption = 'Z-Link TELNET settings'
  ClientHeight = 159
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
    159)
  TextHeight = 13
  object Bevel1: TBevel
    Left = 7
    Top = 7
    Width = 251
    Height = 114
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 51
    Height = 13
    Caption = #12507#12473#12488#21517
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 50
    Height = 13
    Caption = #25913#34892#12467#12540#12489
  end
  object buttonOK: TButton
    Left = 59
    Top = 128
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = buttonOKClick
  end
  object buttonCancel: TButton
    Left = 141
    Top = 128
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 1
  end
  object comboHostName: TComboBox
    Left = 80
    Top = 20
    Width = 169
    Height = 21
    TabOrder = 2
    Text = 'Host name'
  end
  object comboLineBreak: TComboBox
    Left = 80
    Top = 52
    Width = 65
    Height = 21
    TabOrder = 3
    Text = 'Line break'
    Items.Strings = (
      'CR + LF'
      'CR'
      'LF')
  end
  object checkLocalEcho: TCheckBox
    Left = 16
    Top = 88
    Width = 97
    Height = 17
    Caption = 'Local echo'
    TabOrder = 4
  end
end
