object NewIOTARef: TNewIOTARef
  Left = 217
  Top = 265
  BorderStyle = bsDialog
  Caption = 'New IOTA Ref #'
  ClientHeight = 99
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 7
    Top = 7
    Width = 251
    Height = 58
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 16
    Top = 18
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Name: TLabel
    Left = 16
    Top = 40
    Width = 28
    Height = 13
    Caption = 'Name'
  end
  object OKBtn: TButton
    Left = 67
    Top = 72
    Width = 63
    Height = 21
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 135
    Top = 72
    Width = 63
    Height = 21
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 48
    Top = 36
    Width = 201
    Height = 21
    ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
    TabOrder = 2
  end
end
