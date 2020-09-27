object NRDialog: TNRDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Correct NR'
  ClientHeight = 99
  ClientWidth = 278
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    278
    99)
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 69
    Height = 12
    Caption = 'New Sent NR'
  end
  object OKBtn: TButton
    Left = 124
    Top = 71
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitLeft = 135
    ExplicitTop = 64
  end
  object CancelBtn: TButton
    Left = 200
    Top = 71
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    ExplicitLeft = 211
    ExplicitTop = 64
  end
  object editSentNR: TEdit
    Left = 102
    Top = 13
    Width = 87
    Height = 20
    TabOrder = 0
  end
  object checkAutoAddPowerCode: TCheckBox
    Left = 16
    Top = 44
    Width = 173
    Height = 13
    Caption = 'Add power code automatically'
    TabOrder = 1
  end
end
