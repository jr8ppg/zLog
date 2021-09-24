object formExportHamlog: TformExportHamlog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Export'
  ClientHeight = 312
  ClientWidth = 390
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    390
    312)
  PixelsPerInch = 96
  TextHeight = 12
  object buttonOK: TButton
    Left = 107
    Top = 282
    Width = 90
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object buttonCancel: TButton
    Left = 203
    Top = 282
    Width = 90
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 373
    Height = 265
    Caption = 'HAMLOG'#20986#21147#35373#23450
    TabOrder = 2
    object groupRemarks1: TGroupBox
      Left = 12
      Top = 24
      Width = 349
      Height = 114
      Caption = 'Remarks1'#12398#20986#21147#20869#23481
      TabOrder = 0
      object radioRemarks1Opt1: TRadioButton
        Left = 21
        Top = 26
        Width = 60
        Height = 13
        Caption = #20837#21147
        TabOrder = 0
        OnClick = radioRemarks1Opt1Click
      end
      object radioRemarks1Opt2: TRadioButton
        Left = 21
        Top = 53
        Width = 69
        Height = 13
        Caption = 'Operator'
        Checked = True
        TabOrder = 2
        TabStop = True
        OnClick = radioRemarks1Opt2Click
      end
      object radioRemarks1Opt3: TRadioButton
        Left = 21
        Top = 82
        Width = 69
        Height = 13
        Caption = 'Memo'
        TabOrder = 3
        OnClick = radioRemarks1Opt3Click
      end
      object editRemarks1Opt1: TMemo
        Left = 96
        Top = 22
        Width = 241
        Height = 21
        TabOrder = 1
      end
    end
    object groupRemarks2: TGroupBox
      Left = 12
      Top = 143
      Width = 349
      Height = 114
      Caption = 'Remarks2'#12398#20986#21147#20869#23481
      TabOrder = 1
      object editRemarks2Opt1: TMemo
        Left = 96
        Top = 26
        Width = 241
        Height = 21
        TabOrder = 1
      end
      object radioRemarks2Opt1: TRadioButton
        Left = 25
        Top = 30
        Width = 56
        Height = 13
        Caption = #20837#21147
        TabOrder = 0
        OnClick = radioRemarks2Opt1Click
      end
      object radioRemarks2Opt2: TRadioButton
        Left = 25
        Top = 57
        Width = 69
        Height = 13
        Caption = 'Operator'
        TabOrder = 2
        OnClick = radioRemarks2Opt2Click
      end
      object radioRemarks2Opt3: TRadioButton
        Left = 25
        Top = 84
        Width = 69
        Height = 13
        Caption = 'Memo'
        Checked = True
        TabOrder = 3
        TabStop = True
        OnClick = radioRemarks2Opt3Click
      end
    end
  end
end
