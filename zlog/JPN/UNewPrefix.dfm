object NewPrefix: TNewPrefix
  Left = 130
  Top = 113
  BorderStyle = bsDialog
  Caption = 'Enter new prefix'
  ClientHeight = 106
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 16
    Top = 20
    Width = 30
    Height = 12
    Caption = 'Prefix'
  end
  object Label2: TLabel
    Left = 16
    Top = 44
    Width = 76
    Height = 12
    Caption = 'Country/Entity'
  end
  object cbCountry: TComboBox
    Left = 104
    Top = 40
    Width = 177
    Height = 20
    DropDownCount = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Pitch = fpFixed
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'Select a country'
  end
  object PXEdit: TEdit
    Left = 104
    Top = 16
    Width = 177
    Height = 20
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object OKButton: TButton
    Left = 80
    Top = 72
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 176
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    OnClick = CancelButtonClick
  end
end
