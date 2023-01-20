object CWKeyBoard: TCWKeyBoard
  Left = 503
  Top = 417
  Caption = 'CW Keyboard'
  ClientHeight = 105
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Console: TMemo
    Left = 0
    Top = 0
    Width = 379
    Height = 71
    Align = alClient
    ImeMode = imDisable
    TabOrder = 0
    OnKeyPress = ConsoleKeyPress
  end
  object Panel1: TPanel
    Left = 0
    Top = 71
    Width = 379
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object buttonOK: TButton
      Left = 6
      Top = 8
      Width = 65
      Height = 21
      Caption = 'OK'
      TabOrder = 0
      OnClick = buttonOKClick
    end
    object buttonClear: TButton
      Left = 80
      Top = 8
      Width = 65
      Height = 21
      Caption = 'Clear'
      TabOrder = 1
      OnClick = buttonClearClick
    end
  end
  object ActionList1: TActionList
    State = asSuspended
    Left = 240
    Top = 40
    object actionPlayMessageA01: TAction
      Tag = 1
      Caption = 'actionPlayMessageA01'
      ShortCut = 112
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA02: TAction
      Tag = 2
      Caption = 'actionPlayMessageA02'
      ShortCut = 113
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA03: TAction
      Tag = 3
      Caption = 'actionPlayMessageA03'
      ShortCut = 114
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA04: TAction
      Tag = 4
      Caption = 'actionPlayMessageA04'
      ShortCut = 115
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA05: TAction
      Tag = 5
      Caption = 'actionPlayMessageA05'
      ShortCut = 116
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA06: TAction
      Tag = 6
      Caption = 'actionPlayMessageA06'
      ShortCut = 117
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA07: TAction
      Tag = 7
      Caption = 'actionPlayMessageA07'
      ShortCut = 118
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA08: TAction
      Tag = 8
      Caption = 'actionPlayMessageA08'
      ShortCut = 119
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA09: TAction
      Tag = 9
      Caption = 'actionPlayMessageA09'
      ShortCut = 120
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA10: TAction
      Tag = 10
      Caption = 'actionPlayMessageA10'
      ShortCut = 121
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA11: TAction
      Tag = 11
      Caption = 'actionPlayMessageA11'
      ShortCut = 122
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA12: TAction
      Tag = 12
      Caption = 'actionPlayMessageA12'
      ShortCut = 123
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageB01: TAction
      Tag = 1
      Caption = 'actionPlayMessageB01'
      ShortCut = 8304
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB02: TAction
      Tag = 2
      Caption = 'actionPlayMessageB02'
      ShortCut = 8305
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB03: TAction
      Tag = 3
      Caption = 'actionPlayMessageB03'
      ShortCut = 8306
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB04: TAction
      Tag = 4
      Caption = 'actionPlayMessageB04'
      ShortCut = 8307
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB05: TAction
      Tag = 5
      Caption = 'actionPlayMessageB05'
      ShortCut = 8308
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB06: TAction
      Tag = 6
      Caption = 'actionPlayMessageB06'
      ShortCut = 8309
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB07: TAction
      Tag = 7
      Caption = 'actionPlayMessageB07'
      ShortCut = 8310
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB08: TAction
      Tag = 8
      Caption = 'actionPlayMessageB08'
      ShortCut = 8311
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB09: TAction
      Tag = 9
      Caption = 'actionPlayMessageB09'
      ShortCut = 8312
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB10: TAction
      Tag = 10
      Caption = 'actionPlayMessageB10'
      ShortCut = 8313
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB11: TAction
      Tag = 11
      Caption = 'actionPlayMessageB11'
      ShortCut = 8314
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB12: TAction
      Tag = 12
      Caption = 'actionPlayMessageB12'
      ShortCut = 8315
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageAR: TAction
      Caption = 'actionPlayMessageAR'
      ShortCut = 8257
      OnExecute = actionPlayMessageARExecute
    end
    object actionPlayMessageBK: TAction
      Caption = 'actionPlayMessageBK'
      ShortCut = 8258
      OnExecute = actionPlayMessageBKExecute
    end
    object actionPlayMessageKN: TAction
      Caption = 'actionPlayMessageKN'
      ShortCut = 8267
      OnExecute = actionPlayMessageKNExecute
    end
    object actionPlayMessageSK: TAction
      Caption = 'actionPlayMessageSK'
      ShortCut = 8275
      OnExecute = actionPlayMessageSKExecute
    end
    object actionESC: TAction
      Caption = 'actionESC'
      ShortCut = 27
      OnExecute = actionESCExecute
    end
    object actionPlayCQA1: TAction
      Tag = 101
      Caption = 'actionPlayCQA1'
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayCQA2: TAction
      Tag = 102
      Caption = 'actionPlayCQA2'
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayCQA3: TAction
      Tag = 103
      Caption = 'actionPlayCQA3'
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayCQB1: TAction
      Tag = 101
      Caption = 'actionPlayCQB1'
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayCQB2: TAction
      Tag = 102
      Caption = 'actionPlayCQB2'
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayCQB3: TAction
      Tag = 103
      Caption = 'actionPlayCQB3'
      OnExecute = actionPlayMessageBExecute
    end
    object actionDecreaseCwSpeed: TAction
      Caption = 'actionDecreaseCwSpeed'
      ShortCut = 8277
      OnExecute = actionDecreaseCwSpeedExecute
    end
    object actionIncreaseCwSpeed: TAction
      Caption = 'actionIncreaseCwSpeed'
      ShortCut = 8281
      OnExecute = actionIncreaseCwSpeedExecute
    end
    object actionPlayMessageBT: TAction
      Caption = 'actionPlayMessageBT'
      ShortCut = 8276
      OnExecute = actionPlayMessageBTExecute
    end
    object actionPlayMessageVA: TAction
      Caption = 'actionPlayMessageVA'
      ShortCut = 8278
      OnExecute = actionPlayMessageVAExecute
    end
  end
end
