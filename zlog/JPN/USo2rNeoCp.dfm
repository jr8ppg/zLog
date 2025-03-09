object formSo2rNeoCp: TformSo2rNeoCp
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'SO2R Neo Control Panel'
  ClientHeight = 116
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 12
  object ledPtt: TJvLED
    Left = 176
    Top = 88
    ColorOff = clSilver
    Status = False
  end
  object Label1: TLabel
    Left = 172
    Top = 75
    Width = 21
    Height = 12
    Caption = 'PTT'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
  end
  object ledCancelRxSel: TJvLED
    Left = 248
    Top = 88
    ColorOff = clSilver
    Status = False
  end
  object Label2: TLabel
    Left = 213
    Top = 75
    Width = 90
    Height = 12
    Caption = 'Cancel RX Select'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
  end
  object groupAfControl: TGroupBox
    Left = 163
    Top = 4
    Width = 315
    Height = 69
    Caption = 'AF'#12502#12524#12531#12489
    TabOrder = 0
    object buttonAfBlend: TSpeedButton
      Left = 12
      Top = 15
      Width = 65
      Height = 45
      AllowAllUp = True
      GroupIndex = 3
      Caption = 'AF Blend'
      OnClick = buttonAfBlendClick
    end
    object buttonPer100: TSpeedButton
      Tag = 100
      Left = 263
      Top = 10
      Width = 45
      Height = 18
      Caption = '100%'
      OnClick = buttonPerNClick
    end
    object buttonPer0: TSpeedButton
      Left = 263
      Top = 47
      Width = 45
      Height = 17
      Caption = '0%'
      OnClick = buttonPerNClick
    end
    object buttonPer50: TSpeedButton
      Tag = 50
      Left = 263
      Top = 29
      Width = 45
      Height = 17
      Caption = '50%'
      OnClick = buttonPerNClick
    end
    object trackBlendRatio: TTrackBar
      Left = 83
      Top = 24
      Width = 174
      Height = 25
      Max = 100
      PageSize = 5
      Frequency = 5
      Position = 50
      TabOrder = 0
      OnChange = trackBlendRatioChange
    end
  end
  object groupRxSelect: TGroupBox
    Left = 4
    Top = 4
    Width = 153
    Height = 107
    Caption = 'RX Auto Select'
    TabOrder = 1
    object buttonRig1: TSpeedButton
      Left = 8
      Top = 43
      Width = 45
      Height = 39
      GroupIndex = 1
      Down = True
      Caption = 'RIG1'
      OnClick = buttonRigClick
    end
    object buttonRig2: TSpeedButton
      Left = 52
      Top = 43
      Width = 45
      Height = 39
      GroupIndex = 1
      Caption = 'RIG2'
      OnClick = buttonRigClick
    end
    object buttonRigBoth: TSpeedButton
      Left = 96
      Top = 43
      Width = 45
      Height = 39
      GroupIndex = 1
      Caption = 'Both'
      OnClick = buttonRigClick
    end
    object ledRig1: TJvLED
      Left = 24
      Top = 84
      ColorOff = clSilver
      Status = False
    end
    object ledRig2: TJvLED
      Left = 68
      Top = 84
      ColorOff = clSilver
      Status = False
    end
    object ledRig3: TJvLED
      Left = 112
      Top = 84
      ColorOff = clSilver
      Status = False
    end
    object ToggleSwitch1: TToggleSwitch
      Left = 8
      Top = 18
      Width = 78
      Height = 20
      StateCaptions.CaptionOn = 'ON'
      StateCaptions.CaptionOff = 'OFF'
      TabOrder = 0
      OnClick = ToggleSwitch1Click
    end
  end
  object ActionList1: TActionList
    Left = 364
    Top = 76
    object actionSo2rNeoSelRx1: TAction
      Caption = 'actionSo2rNeoSelRx1'
      OnExecute = actionSo2rNeoSelRx1Execute
    end
    object actionSo2rNeoSelRx2: TAction
      Caption = 'actionSo2rNeoSelRx2'
      OnExecute = actionSo2rNeoSelRx2Execute
    end
    object actionSo2rNeoSelRxBoth: TAction
      Caption = 'actionSo2rNeoSelRxBoth'
      OnExecute = actionSo2rNeoSelRxBothExecute
    end
    object actionSo2rNeoToggleAutoRxSelect: TAction
      Caption = 'actionSo2rNeoToggleAutoRxSelect'
      OnExecute = actionSo2rNeoToggleAutoRxSelectExecute
    end
    object actionSo2rToggleAfBlend: TAction
      Caption = 'actionSo2rToggleAfBlend'
    end
  end
end
