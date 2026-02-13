object formPrePostPlaybackDlg: TformPrePostPlaybackDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #20877#29983#21069'/'#24460#12398#20966#29702
  ClientHeight = 206
  ClientWidth = 201
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
  object groupCommand: TGroupBox
    Left = 8
    Top = 8
    Width = 185
    Height = 77
    Caption = #12467#12510#12531#12489
    TabOrder = 0
    object radioCommandNone: TRadioButton
      Left = 12
      Top = 24
      Width = 85
      Height = 17
      Caption = #12394#12375
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
      Caption = '#163 QSO'#30906#23450
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 172
    Width = 201
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
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
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 193
    end
  end
  object groupExecuteAt: TGroupBox
    Left = 8
    Top = 91
    Width = 185
    Height = 77
    Caption = #23455#34892#12377#12427#12392#12365
    TabOrder = 1
    object radioBeforePlayback: TRadioButton
      Left = 12
      Top = 24
      Width = 113
      Height = 17
      Caption = #20877#29983#21069
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object radioAfterPlayback: TRadioButton
      Tag = 163
      Left = 12
      Top = 47
      Width = 113
      Height = 17
      Caption = #20877#29983#24460
      TabOrder = 1
    end
  end
end
