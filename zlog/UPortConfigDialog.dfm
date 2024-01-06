object formPortConfig: TformPortConfig
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Port config'
  ClientHeight = 110
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    274
    110)
  PixelsPerInch = 96
  TextHeight = 13
  object groupPortConfig: TGroupBox
    Left = 4
    Top = 4
    Width = 181
    Height = 97
    Caption = 'COM99'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 22
      Height = 13
      Caption = 'RTS'
    end
    object Label2: TLabel
      Left = 16
      Top = 61
      Width = 23
      Height = 13
      Caption = 'DTR'
    end
    object comboRts: TComboBox
      Left = 64
      Top = 29
      Width = 97
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object comboDtr: TComboBox
      Left = 64
      Top = 58
      Width = 97
      Height = 21
      Style = csDropDownList
      TabOrder = 1
    end
  end
  object buttonOK: TButton
    Left = 194
    Top = 8
    Width = 72
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object buttonCancel: TButton
    Left = 194
    Top = 39
    Width = 72
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
