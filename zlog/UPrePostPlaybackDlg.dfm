object formPrePostPlaybackDlg: TformPrePostPlaybackDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pre/Post playback command'
  ClientHeight = 125
  ClientWidth = 201
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
  object groupCommand: TGroupBox
    Left = 8
    Top = 8
    Width = 185
    Height = 77
    Caption = 'Command'
    TabOrder = 0
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
      Tag = 163
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
    Top = 91
    Width = 201
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 182
    ExplicitWidth = 268
    DesignSize = (
      201
      34)
    object buttonOK: TButton
      Left = 52
      Top = 4
      Width = 69
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 118
    end
    object buttonCancel: TButton
      Left = 127
      Top = 4
      Width = 69
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 193
    end
  end
end
