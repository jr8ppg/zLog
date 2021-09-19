object formExportHamlog: TformExportHamlog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Export'
  ClientHeight = 169
  ClientWidth = 389
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
    389
    169)
  PixelsPerInch = 96
  TextHeight = 12
  object buttonOK: TButton
    Left = 106
    Top = 139
    Width = 90
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object buttonCancel: TButton
    Left = 202
    Top = 139
    Width = 90
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 373
    Height = 125
    Caption = 'HAMLOG'#20986#21147#35373#23450
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 27
      Width = 90
      Height = 12
      Caption = 'Memo'#27396#12398#20986#21147#20808
    end
    object Label2: TLabel
      Left = 16
      Top = 61
      Width = 99
      Height = 12
      Caption = 'Remarks1'#20986#21147#20869#23481
    end
    object Label3: TLabel
      Left = 16
      Top = 88
      Width = 99
      Height = 12
      Caption = 'Remarks2'#20986#21147#20869#23481
    end
    object memoRemarks1: TMemo
      Left = 128
      Top = 58
      Width = 229
      Height = 21
      TabOrder = 3
    end
    object memoRemarks2: TMemo
      Left = 128
      Top = 85
      Width = 229
      Height = 21
      TabOrder = 4
    end
    object radioMemo1: TRadioButton
      Left = 200
      Top = 26
      Width = 69
      Height = 13
      Caption = 'Remarks1'
      TabOrder = 1
      OnClick = radioMemo1Click
    end
    object radioMemo2: TRadioButton
      Left = 275
      Top = 26
      Width = 69
      Height = 13
      Caption = 'Remarks2'
      TabOrder = 2
      OnClick = radioMemo2Click
    end
    object radioMemo0: TRadioButton
      Left = 128
      Top = 26
      Width = 69
      Height = 13
      Caption = #20986#21147#28961#12375
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = radioMemo0Click
    end
  end
end
