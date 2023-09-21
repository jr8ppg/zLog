object NRDialog: TNRDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Correct NR'
  ClientHeight = 152
  ClientWidth = 260
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
    260
    152)
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 106
    Top = 124
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object CancelBtn: TButton
    Left = 182
    Top = 124
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object checkAutoAddPowerCode: TCheckBox
    Left = 8
    Top = 99
    Width = 173
    Height = 13
    Caption = 'Add power code automatically'
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 241
    Height = 81
    Caption = 'New Sent NR'
    TabOrder = 0
    object Label2: TLabel
      Left = 17
      Top = 50
      Width = 90
      Height = 13
      Caption = '2400MHz or higher'
    end
    object Label1: TLabel
      Left = 17
      Top = 24
      Width = 79
      Height = 13
      Caption = '1200MHz or less'
    end
    object editSentNR: TEdit
      Left = 126
      Top = 21
      Width = 87
      Height = 21
      TabOrder = 0
    end
    object editSentNR2: TEdit
      Left = 126
      Top = 47
      Width = 87
      Height = 21
      TabOrder = 1
    end
  end
end
