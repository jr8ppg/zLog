object IOTACategory: TIOTACategory
  Left = 195
  Top = 269
  BorderStyle = bsDialog
  Caption = 'IOTA Category'
  ClientHeight = 117
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 115
    Top = 88
    Width = 63
    Height = 21
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 281
    Height = 73
    TabOrder = 1
    object Label1: TLabel
      Left = 208
      Top = 42
      Width = 32
      Height = 13
      Caption = 'Label1'
    end
    object rbIOTA: TRadioButton
      Left = 8
      Top = 18
      Width = 201
      Height = 17
      Caption = 'IOTA Island Stations. IOTA ref # :'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbIOTAClick
    end
    object rbDXCC: TRadioButton
      Left = 8
      Top = 40
      Width = 185
      Height = 17
      Caption = 'Other Stations. DXCC Country :'
      TabOrder = 1
      OnClick = rbDXCCClick
    end
    object Edit1: TEdit
      Left = 208
      Top = 16
      Width = 57
      Height = 20
      AutoSize = False
      MaxLength = 5
      TabOrder = 2
      Text = 'AS007'
    end
  end
end
