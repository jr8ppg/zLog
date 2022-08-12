object formStatusEdit: TformStatusEdit
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Status Edit'
  ClientHeight = 88
  ClientWidth = 364
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 137
    Height = 42
    Caption = 'QSO Flags'
    TabOrder = 0
    object checkCQ: TCheckBox
      Left = 16
      Top = 16
      Width = 33
      Height = 17
      Caption = 'CQ'
      TabOrder = 0
    end
    object checkInvalid: TCheckBox
      Left = 71
      Top = 16
      Width = 51
      Height = 17
      Caption = 'Invalid'
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 151
    Top = 8
    Width = 205
    Height = 42
    Caption = 'QSL Status'
    TabOrder = 1
    object radioQslNone: TRadioButton
      Left = 16
      Top = 16
      Width = 45
      Height = 17
      Caption = 'None'
      TabOrder = 0
    end
    object radioPseQsl: TRadioButton
      Left = 67
      Top = 16
      Width = 61
      Height = 17
      Caption = 'PSE QSL'
      TabOrder = 1
    end
    object radioNoQsl: TRadioButton
      Left = 137
      Top = 16
      Width = 61
      Height = 17
      Caption = 'NO QSL'
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 55
    Width = 364
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      364
      33)
    object OKBtn: TButton
      Left = 203
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object CancelBtn: TButton
      Left = 284
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
