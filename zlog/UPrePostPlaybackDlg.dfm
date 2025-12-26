object formPrePostPlaybackDlg: TformPrePostPlaybackDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pre/Post Playback Processing'
  ClientHeight = 216
  ClientWidth = 268
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 13
  object groupAudioInput: TGroupBox
    Left = 4
    Top = 4
    Width = 126
    Height = 173
    Caption = 'Audio input'
    TabOrder = 0
    object radioInputDontCare: TRadioButton
      Left = 12
      Top = 24
      Width = 74
      Height = 17
      Caption = 'D'#39'ont care'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object radioInputMic: TRadioButton
      Left = 12
      Top = 47
      Width = 75
      Height = 17
      Caption = 'MIC'
      TabOrder = 1
    end
    object radioInputUsb: TRadioButton
      Left = 12
      Top = 70
      Width = 75
      Height = 17
      Caption = 'USB'
      TabOrder = 2
    end
    object radioInputAcc: TRadioButton
      Left = 12
      Top = 93
      Width = 75
      Height = 17
      Caption = 'ACC'
      TabOrder = 3
    end
    object radioInputMicUsb: TRadioButton
      Left = 12
      Top = 116
      Width = 75
      Height = 17
      Caption = 'MIC,USB'
      TabOrder = 4
    end
    object radioInputMicAcc: TRadioButton
      Left = 12
      Top = 139
      Width = 75
      Height = 17
      Caption = 'MIC,ACC'
      TabOrder = 5
    end
  end
  object groupCommand: TGroupBox
    Left = 136
    Top = 4
    Width = 126
    Height = 77
    Caption = 'Command'
    TabOrder = 1
    object radioCommandNone: TRadioButton
      Left = 12
      Top = 24
      Width = 85
      Height = 17
      Caption = 'None'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object radioCommand163: TRadioButton
      Left = 12
      Top = 47
      Width = 101
      Height = 17
      Caption = '#163 Logging'
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 182
    Width = 268
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 220
    object Button1: TButton
      Left = 118
      Top = 4
      Width = 69
      Height = 25
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 193
      Top = 4
      Width = 69
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
