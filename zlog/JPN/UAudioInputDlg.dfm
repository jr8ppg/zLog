object formAudioInputDlg: TformAudioInputDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'RIG'#12398#38899#22768#20837#21147#35373#23450
  ClientHeight = 219
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 13
  object groupAudioInput: TGroupBox
    Left = 152
    Top = 8
    Width = 140
    Height = 173
    Caption = #20877#29983#20013#12398#20837#21147#31471#23376
    TabOrder = 0
    object radioPreInputDontCare: TRadioButton
      Left = 12
      Top = 24
      Width = 120
      Height = 17
      Caption = #20999#12426#26367#12360#28961#12375
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object radioPreInputMic: TRadioButton
      Tag = 1
      Left = 12
      Top = 47
      Width = 120
      Height = 17
      Caption = 'MIC'
      TabOrder = 1
    end
    object radioPreInputUsb: TRadioButton
      Tag = 2
      Left = 12
      Top = 70
      Width = 120
      Height = 17
      Caption = 'USB'
      TabOrder = 2
    end
    object radioPreInputAcc: TRadioButton
      Tag = 3
      Left = 12
      Top = 93
      Width = 120
      Height = 17
      Caption = 'ACC'
      TabOrder = 3
    end
    object radioPreInputMicUsb: TRadioButton
      Tag = 4
      Left = 12
      Top = 116
      Width = 120
      Height = 17
      Caption = 'MIC,USB'
      TabOrder = 4
    end
    object radioPreInputMicAcc: TRadioButton
      Tag = 5
      Left = 12
      Top = 139
      Width = 120
      Height = 17
      Caption = 'MIC,ACC'
      TabOrder = 5
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 185
    Width = 297
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      297
      34)
    object buttonOK: TButton
      Left = 147
      Top = 4
      Width = 69
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object buttonCancel: TButton
      Left = 222
      Top = 4
      Width = 69
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 6
    Top = 8
    Width = 140
    Height = 173
    Caption = #36890#24120#26178#12398#20837#21147#31471#23376
    TabOrder = 2
    object radioPostInputDontCare: TRadioButton
      Left = 12
      Top = 24
      Width = 120
      Height = 17
      Caption = #20999#12426#26367#12360#28961#12375
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object radioPostInputMic: TRadioButton
      Tag = 1
      Left = 12
      Top = 47
      Width = 120
      Height = 17
      Caption = 'MIC'
      TabOrder = 1
    end
    object radioPostInputUsb: TRadioButton
      Tag = 2
      Left = 12
      Top = 70
      Width = 120
      Height = 17
      Caption = 'USB'
      TabOrder = 2
    end
    object radioPostInputAcc: TRadioButton
      Tag = 3
      Left = 12
      Top = 93
      Width = 120
      Height = 17
      Caption = 'ACC'
      TabOrder = 3
    end
    object radioPostInputMicUsb: TRadioButton
      Tag = 4
      Left = 12
      Top = 116
      Width = 120
      Height = 17
      Caption = 'MIC,USB'
      TabOrder = 4
    end
    object radioPostInputMicAcc: TRadioButton
      Tag = 5
      Left = 12
      Top = 139
      Width = 120
      Height = 17
      Caption = 'MIC,ACC'
      TabOrder = 5
    end
  end
end
