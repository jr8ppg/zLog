object IntegerDialog: TIntegerDialog
  Left = 315
  Top = 162
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  ClientHeight = 99
  ClientWidth = 251
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 32
    Top = 12
    Width = 27
    Height = 12
    Caption = 'Label'
  end
  object Edit: TEdit
    Left = 56
    Top = 32
    Width = 129
    Height = 20
    TabOrder = 0
  end
  object Button1: TButton
    Left = 40
    Top = 64
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 136
    Top = 64
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = Button2Click
  end
end
