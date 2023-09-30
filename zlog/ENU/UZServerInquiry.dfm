object ZServerInquiry: TZServerInquiry
  Left = 239
  Top = 182
  BorderStyle = bsDialog
  Caption = 'Connected...'
  ClientHeight = 166
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    324
    166)
  PixelsPerInch = 96
  TextHeight = 12
  object Button1: TButton
    Left = 85
    Top = 134
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 174
    Top = 134
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = Button2Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 305
    Height = 118
    Caption = 'Connected to Z-Server'
    TabOrder = 2
    object rbDownload: TRadioButton
      Left = 16
      Top = 75
      Width = 270
      Height = 34
      Caption = 'Download log from Z-Server (Delete local log)'
      TabOrder = 0
      WordWrap = True
    end
    object rbMerge: TRadioButton
      Left = 16
      Top = 44
      Width = 270
      Height = 34
      Caption = 'Merge local log with Z-Server'
      TabOrder = 1
      WordWrap = True
    end
    object rbConnectOnly: TRadioButton
      Left = 16
      Top = 14
      Width = 270
      Height = 34
      Caption = 'Connect only'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
  end
end
