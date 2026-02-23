object formAudioInputDlg: TformAudioInputDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Audio input'
  ClientHeight = 219
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
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
    Caption = 'Input device (Playback)'
    TabOrder = 0
    object radioPreInputDontCare: TRadioButton
      Left = 12
      Top = 24
      Width = 120
      Height = 17
      Caption = 'D'#39'ont care'
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
    ExplicitWidth = 271
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
      ExplicitLeft = 121
    end
    object buttonCancel: TButton
      Left = 222
      Top = 4
      Width = 69
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 196
    end
  end
  object GroupBox1: TGroupBox
    Left = 6
    Top = 8
    Width = 140
    Height = 173
    Caption = 'Input device (Normal)'
    TabOrder = 2
    object radioPostInputDontCare: TRadioButton
      Left = 12
      Top = 24
      Width = 120
      Height = 17
      Caption = 'D'#39'ont care'
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
