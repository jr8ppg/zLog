object formPortConfig2: TformPortConfig2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #12509#12540#12488#35373#23450
  ClientHeight = 110
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    274
    110)
  TextHeight = 13
  object groupPortConfig: TGroupBox
    Left = 4
    Top = 4
    Width = 181
    Height = 97
    Caption = 'COM99'
    TabOrder = 0
    object radioRtsKeyDtrPtt: TRadioButton
      Left = 16
      Top = 29
      Width = 133
      Height = 17
      Caption = 'RTS=KEY, DTR=PTT'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object radioRtsPttDtrKey: TRadioButton
      Left = 16
      Top = 58
      Width = 133
      Height = 17
      Caption = 'RTS=PTT, DTR=KEY'
      TabOrder = 1
    end
  end
  object buttonOK: TButton
    Left = 194
    Top = 8
    Width = 72
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object buttonCancel: TButton
    Left = 194
    Top = 39
    Width = 72
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 2
  end
end
