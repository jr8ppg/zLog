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
    Caption = #25509#32154#12458#12503#12471#12519#12531
    TabOrder = 2
    object rbDownload: TRadioButton
      Left = 16
      Top = 44
      Width = 270
      Height = 34
      Caption = #12480#12454#12531#12525#12540#12489#65306'Z-Server'#20596#12398#12525#12464#12434#12480#12454#12531#12525#12540#12489#12375#12414#12377#12290#12525#12540#12459#12523#20596#12398#12525#12464#12399#21066#38500#12373#12428#12414#12377#12290
      TabOrder = 1
      WordWrap = True
    end
    object rbMerge: TRadioButton
      Left = 16
      Top = 14
      Width = 270
      Height = 34
      Caption = #12510#12540#12472#65306#12525#12540#12459#12523#20596#12392'Z-Server'#20596#12398#12525#12464#12434#12510#12540#12472#12375#12414#12377#12290
      Checked = True
      TabOrder = 0
      TabStop = True
      WordWrap = True
    end
    object rbConnectOnly: TRadioButton
      Left = 16
      Top = 75
      Width = 270
      Height = 34
      Caption = #25509#32154#12398#12415#65306#24460#12391#12510#12540#12472#12434#34892#12358#22580#21512#12395#36984#25246#12375#12390#19979#12373#12356#12290
      TabOrder = 2
    end
  end
end
