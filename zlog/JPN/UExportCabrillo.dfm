object formExportCabrillo: TformExportCabrillo
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Export'
  ClientHeight = 97
  ClientWidth = 271
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    271
    97)
  PixelsPerInch = 96
  TextHeight = 13
  object buttonOK: TButton
    Left = 176
    Top = 8
    Width = 90
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object buttonCancel: TButton
    Left = 176
    Top = 39
    Width = 90
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 157
    Height = 77
    Caption = #26178#38291#24111#12434#36984#25246
    TabOrder = 0
    object radioUTC: TRadioButton
      Left = 20
      Top = 20
      Width = 57
      Height = 17
      Caption = 'UTC'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object radioJST: TRadioButton
      Left = 20
      Top = 48
      Width = 57
      Height = 17
      Caption = 'JST'
      TabOrder = 1
    end
  end
end
