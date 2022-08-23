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
  OldCreateOrder = True
  Position = poOwnerFormCenter
  DesignSize = (
    266
    159)
  PixelsPerInch = 96
  TextHeight = 12
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
    Width = 54
    Height = 12
    Caption = 'Host name'
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 60
    Height = 12
    Caption = 'Line break'
  end
  object buttonOK: TButton
    Left = 67
    Top = 129
    Width = 63
    Height = 21
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object buttonCancel: TButton
    Left = 135
    Top = 129
    Width = 63
    Height = 21
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object comboHostName: TComboBox
    Left = 80
    Top = 20
    Width = 169
    Height = 20
    ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
    TabOrder = 2
    Text = 'Host name'
    Items.Strings = (
      'ac4et.ampr.org')
  end
  object comboLineBreak: TComboBox
    Left = 80
    Top = 52
    Width = 65
    Height = 20
    ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
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
