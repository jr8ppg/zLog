object formClusterCOMSet: TformClusterCOMSet
  Left = 397
  Top = 294
  BorderStyle = bsDialog
  Caption = 'PacketCluster COM port settings'
  ClientHeight = 158
  ClientWidth = 269
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  Scaled = False
  DesignSize = (
    269
    158)
  PixelsPerInch = 96
  TextHeight = 12
  object Bevel1: TBevel
    Left = 6
    Top = 6
    Width = 251
    Height = 119
    Shape = bsFrame
  end
  object Label35: TLabel
    Left = 16
    Top = 22
    Width = 50
    Height = 12
    Caption = 'Baud rate'
  end
  object Label1: TLabel
    Left = 16
    Top = 56
    Width = 53
    Height = 12
    Caption = 'Line break'
  end
  object comboLineBreak: TComboBox
    Left = 80
    Top = 52
    Width = 65
    Height = 20
    ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
    TabOrder = 0
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
    TabOrder = 1
  end
  object buttonOK: TButton
    Left = 55
    Top = 134
    Width = 73
    Height = 21
    Anchors = [akLeft, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitTop = 153
  end
  object buttonCancel: TButton
    Left = 134
    Top = 134
    Width = 73
    Height = 21
    Anchors = [akLeft, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    ExplicitTop = 153
  end
  object comboBaudRate: TComboBox
    Left = 80
    Top = 18
    Width = 65
    Height = 20
    ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
    TabOrder = 4
    Text = 'comboBaudRate'
    Items.Strings = (
      '110'
      '300'
      '600'
      '1200'
      '2400'
      '4800'
      '9600'
      '14400'
      '19200'
      '38400'
      '56000'
      '57600'
      '115200'
      '128000'
      '256000')
  end
end
