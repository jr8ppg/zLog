object formOperatorEdit: TformOperatorEdit
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Operator'
  ClientHeight = 572
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 538
    Width = 373
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 517
    ExplicitWidth = 391
    DesignSize = (
      373
      34)
    object buttonOK: TButton
      Left = 113
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = buttonOKClick
    end
    object buttonCancel: TButton
      Left = 193
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 85
    Width = 373
    Height = 453
    ActivePage = tabsheetCwMessages
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 84
    ExplicitWidth = 377
    ExplicitHeight = 405
    object tabsheetCwMessages: TTabSheet
      Caption = 'CW'
      object groupCwMessages1: TGroupBox
        Left = 3
        Top = 3
        Width = 357
        Height = 309
        Caption = 'Override messages'
        TabOrder = 0
        object Label7: TLabel
          Left = 8
          Top = 38
          Width = 13
          Height = 13
          Caption = '#1'
        end
        object Label8: TLabel
          Left = 8
          Top = 60
          Width = 13
          Height = 13
          Caption = '#2'
        end
        object Label9: TLabel
          Left = 8
          Top = 82
          Width = 13
          Height = 13
          Caption = '#3'
        end
        object Label10: TLabel
          Left = 8
          Top = 104
          Width = 13
          Height = 13
          Caption = '#4'
        end
        object Label11: TLabel
          Left = 8
          Top = 126
          Width = 13
          Height = 13
          Caption = '#5'
        end
        object Label12: TLabel
          Left = 8
          Top = 148
          Width = 13
          Height = 13
          Caption = '#6'
        end
        object Label13: TLabel
          Left = 8
          Top = 170
          Width = 13
          Height = 13
          Caption = '#7'
        end
        object Label14: TLabel
          Left = 8
          Top = 192
          Width = 13
          Height = 13
          Caption = '#8'
        end
        object Label15: TLabel
          Left = 8
          Top = 214
          Width = 13
          Height = 13
          Caption = '#9'
        end
        object Label16: TLabel
          Left = 8
          Top = 236
          Width = 19
          Height = 13
          Caption = '#10'
        end
        object Label17: TLabel
          Left = 8
          Top = 258
          Width = 19
          Height = 13
          Caption = '#11'
        end
        object Label18: TLabel
          Left = 8
          Top = 280
          Width = 19
          Height = 13
          Caption = '#12'
        end
        object Label29: TLabel
          Left = 42
          Top = 20
          Width = 28
          Height = 13
          Caption = 'CW A'
        end
        object Label30: TLabel
          Left = 200
          Top = 20
          Width = 28
          Height = 13
          Caption = 'CW B'
        end
        object editCwMessageA01: TEdit
          Left = 40
          Top = 35
          Width = 150
          Height = 21
          TabOrder = 0
        end
        object editCwMessageA02: TEdit
          Left = 40
          Top = 57
          Width = 150
          Height = 21
          TabOrder = 1
        end
        object editCwMessageA03: TEdit
          Left = 40
          Top = 79
          Width = 150
          Height = 21
          TabOrder = 2
        end
        object editCwMessageA04: TEdit
          Left = 40
          Top = 101
          Width = 150
          Height = 21
          TabOrder = 3
        end
        object editCwMessageA05: TEdit
          Left = 40
          Top = 123
          Width = 150
          Height = 21
          TabOrder = 4
        end
        object editCwMessageA06: TEdit
          Left = 40
          Top = 145
          Width = 150
          Height = 21
          TabOrder = 5
        end
        object editCwMessageA07: TEdit
          Left = 40
          Top = 167
          Width = 150
          Height = 21
          TabOrder = 6
        end
        object editCwMessageA08: TEdit
          Left = 40
          Top = 189
          Width = 150
          Height = 21
          TabOrder = 7
        end
        object editCwMessageA09: TEdit
          Left = 40
          Top = 211
          Width = 150
          Height = 21
          TabOrder = 8
        end
        object editCwMessageA10: TEdit
          Left = 40
          Top = 233
          Width = 150
          Height = 21
          TabOrder = 9
        end
        object editCwMessageA11: TEdit
          Left = 40
          Top = 255
          Width = 150
          Height = 21
          TabOrder = 10
        end
        object editCwMessageA12: TEdit
          Left = 40
          Top = 277
          Width = 150
          Height = 21
          TabOrder = 11
        end
        object editCwMessageB01: TEdit
          Left = 198
          Top = 35
          Width = 150
          Height = 21
          TabOrder = 12
        end
        object editCwMessageB02: TEdit
          Left = 198
          Top = 57
          Width = 150
          Height = 21
          TabOrder = 13
        end
        object editCwMessageB03: TEdit
          Left = 198
          Top = 79
          Width = 150
          Height = 21
          TabOrder = 14
        end
        object editCwMessageB04: TEdit
          Left = 198
          Top = 101
          Width = 150
          Height = 21
          TabOrder = 15
        end
        object editCwMessageB05: TEdit
          Left = 198
          Top = 123
          Width = 150
          Height = 21
          TabOrder = 16
        end
        object editCwMessageB06: TEdit
          Left = 198
          Top = 145
          Width = 150
          Height = 21
          TabOrder = 17
        end
        object editCwMessageB07: TEdit
          Left = 198
          Top = 167
          Width = 150
          Height = 21
          TabOrder = 18
        end
        object editCwMessageB08: TEdit
          Left = 198
          Top = 189
          Width = 150
          Height = 21
          TabOrder = 19
        end
        object editCwMessageB09: TEdit
          Left = 198
          Top = 211
          Width = 150
          Height = 21
          TabOrder = 20
        end
        object editCwMessageB10: TEdit
          Left = 198
          Top = 233
          Width = 150
          Height = 21
          TabOrder = 21
        end
        object editCwMessageB11: TEdit
          Left = 198
          Top = 255
          Width = 150
          Height = 21
          TabOrder = 22
        end
        object editCwMessageB12: TEdit
          Left = 198
          Top = 277
          Width = 150
          Height = 21
          TabOrder = 23
        end
      end
      object groupCwMessages2: TGroupBox
        Left = 3
        Top = 318
        Width = 357
        Height = 71
        Caption = 'Override additional CQ messages'
        TabOrder = 1
        object Label19: TLabel
          Left = 8
          Top = 22
          Width = 21
          Height = 13
          Caption = 'CQ2'
        end
        object Label28: TLabel
          Left = 8
          Top = 44
          Width = 21
          Height = 13
          Caption = 'CQ3'
        end
        object editAdditionalCwMessage2: TEdit
          Left = 40
          Top = 19
          Width = 308
          Height = 21
          TabOrder = 0
        end
        object editAdditionalCwMessage3: TEdit
          Left = 40
          Top = 41
          Width = 308
          Height = 21
          TabOrder = 1
        end
      end
      object buttonCopyDefaultMsgs: TButton
        Left = 3
        Top = 395
        Width = 130
        Height = 25
        Caption = 'Copy default messages'
        TabOrder = 2
        OnClick = buttonCopyDefaultMsgsClick
      end
      object buttonClearAll: TButton
        Left = 139
        Top = 395
        Width = 94
        Height = 26
        Caption = 'Clear all'
        TabOrder = 3
        OnClick = buttonClearAllClick
      end
    end
    object tabsheetVoiceFiles: TTabSheet
      Caption = 'PHONE'
      ImageIndex = 1
      object groupVoiceFiles2: TGroupBox
        Left = 3
        Top = 298
        Width = 357
        Height = 71
        Caption = 'Additional CQ Messages'
        TabOrder = 0
        object Label5: TLabel
          Left = 8
          Top = 22
          Width = 21
          Height = 13
          Caption = 'CQ2'
        end
        object Label6: TLabel
          Left = 8
          Top = 44
          Width = 21
          Height = 13
          Caption = 'CQ3'
        end
        object editCQMessage2: TEdit
          Left = 40
          Top = 19
          Width = 286
          Height = 21
          TabOrder = 0
        end
        object editCQMessage3: TEdit
          Left = 40
          Top = 41
          Width = 286
          Height = 21
          TabOrder = 2
        end
        object buttonCQMessage2Ref: TButton
          Tag = 2
          Left = 329
          Top = 19
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 1
          OnClick = buttonCQMessageRefClick
        end
        object buttonCQMessage3Ref: TButton
          Tag = 3
          Left = 329
          Top = 41
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 3
          OnClick = buttonCQMessageRefClick
        end
      end
      object groupVoiceFiles1: TGroupBox
        Left = 3
        Top = 3
        Width = 357
        Height = 289
        Caption = 'Voice Files'
        TabOrder = 1
        object Label20: TLabel
          Left = 8
          Top = 22
          Width = 13
          Height = 13
          Caption = '#1'
        end
        object Label21: TLabel
          Left = 8
          Top = 44
          Width = 13
          Height = 13
          Caption = '#2'
        end
        object Label22: TLabel
          Left = 8
          Top = 66
          Width = 13
          Height = 13
          Caption = '#3'
        end
        object Label23: TLabel
          Left = 8
          Top = 88
          Width = 13
          Height = 13
          Caption = '#4'
        end
        object Label24: TLabel
          Left = 8
          Top = 110
          Width = 13
          Height = 13
          Caption = '#5'
        end
        object Label25: TLabel
          Left = 8
          Top = 132
          Width = 13
          Height = 13
          Caption = '#6'
        end
        object Label26: TLabel
          Left = 8
          Top = 154
          Width = 13
          Height = 13
          Caption = '#7'
        end
        object Label27: TLabel
          Left = 8
          Top = 176
          Width = 13
          Height = 13
          Caption = '#8'
        end
        object Label72: TLabel
          Left = 8
          Top = 198
          Width = 13
          Height = 13
          Caption = '#9'
        end
        object Label73: TLabel
          Left = 8
          Top = 220
          Width = 19
          Height = 13
          Caption = '#10'
        end
        object Label77: TLabel
          Left = 8
          Top = 242
          Width = 19
          Height = 13
          Caption = '#11'
        end
        object Label78: TLabel
          Left = 8
          Top = 264
          Width = 19
          Height = 13
          Caption = '#12'
        end
        object buttonVoiceRef01: TButton
          Tag = 1
          Left = 329
          Top = 19
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 0
          OnClick = buttonVoiceRefClick
        end
        object buttonVoiceRef02: TButton
          Tag = 2
          Left = 329
          Top = 41
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 1
          OnClick = buttonVoiceRefClick
        end
        object buttonVoiceRef03: TButton
          Tag = 3
          Left = 329
          Top = 63
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 2
          OnClick = buttonVoiceRefClick
        end
        object buttonVoiceRef04: TButton
          Tag = 4
          Left = 329
          Top = 85
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 3
          OnClick = buttonVoiceRefClick
        end
        object buttonVoiceRef05: TButton
          Tag = 5
          Left = 329
          Top = 107
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 4
          OnClick = buttonVoiceRefClick
        end
        object buttonVoiceRef06: TButton
          Tag = 6
          Left = 329
          Top = 129
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 5
          OnClick = buttonVoiceRefClick
        end
        object buttonVoiceRef07: TButton
          Tag = 7
          Left = 329
          Top = 151
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 6
          OnClick = buttonVoiceRefClick
        end
        object buttonVoiceRef08: TButton
          Tag = 8
          Left = 329
          Top = 173
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 7
          OnClick = buttonVoiceRefClick
        end
        object buttonVoiceRef09: TButton
          Tag = 9
          Left = 329
          Top = 195
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 8
          OnClick = buttonVoiceRefClick
        end
        object buttonVoiceRef10: TButton
          Tag = 10
          Left = 329
          Top = 217
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 9
          OnClick = buttonVoiceRefClick
        end
        object buttonVoiceRef11: TButton
          Tag = 11
          Left = 329
          Top = 239
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 10
          OnClick = buttonVoiceRefClick
        end
        object buttonVoiceRef12: TButton
          Tag = 12
          Left = 329
          Top = 261
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 11
          OnClick = buttonVoiceRefClick
        end
        object editVoiceFile01: TEdit
          Left = 40
          Top = 19
          Width = 286
          Height = 21
          TabOrder = 12
        end
        object editVoiceFile02: TEdit
          Left = 40
          Top = 41
          Width = 286
          Height = 21
          TabOrder = 13
        end
        object editVoiceFile03: TEdit
          Left = 40
          Top = 63
          Width = 286
          Height = 21
          TabOrder = 14
        end
        object editVoiceFile04: TEdit
          Left = 40
          Top = 85
          Width = 286
          Height = 21
          TabOrder = 15
        end
        object editVoiceFile05: TEdit
          Left = 40
          Top = 107
          Width = 286
          Height = 21
          TabOrder = 16
        end
        object editVoiceFile06: TEdit
          Left = 40
          Top = 129
          Width = 286
          Height = 21
          TabOrder = 17
        end
        object editVoiceFile07: TEdit
          Left = 40
          Top = 151
          Width = 286
          Height = 21
          TabOrder = 18
        end
        object editVoiceFile08: TEdit
          Left = 40
          Top = 173
          Width = 286
          Height = 21
          TabOrder = 19
        end
        object editVoiceFile09: TEdit
          Left = 40
          Top = 195
          Width = 286
          Height = 21
          TabOrder = 20
        end
        object editVoiceFile10: TEdit
          Left = 40
          Top = 217
          Width = 286
          Height = 21
          TabOrder = 21
        end
        object editVoiceFile11: TEdit
          Left = 40
          Top = 239
          Width = 286
          Height = 21
          TabOrder = 22
        end
        object editVoiceFile12: TEdit
          Left = 40
          Top = 261
          Width = 286
          Height = 21
          TabOrder = 23
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 373
    Height = 85
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 391
    object groupOpsInfo: TGroupBox
      Left = 4
      Top = 4
      Width = 365
      Height = 74
      Caption = 'Operator Info.'
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 24
        Width = 36
        Height = 13
        Caption = 'Callsign'
      end
      object Label2: TLabel
        Left = 8
        Top = 47
        Width = 30
        Height = 13
        Caption = 'Power'
      end
      object Label3: TLabel
        Left = 292
        Top = 47
        Width = 19
        Height = 13
        Caption = 'Age'
      end
      object Label4: TLabel
        Left = 185
        Top = 47
        Width = 80
        Height = 13
        Caption = '(Exclude WARC)'
      end
      object editCallsign: TEdit
        Left = 58
        Top = 21
        Width = 81
        Height = 21
        CharCase = ecUpperCase
        ImeMode = imDisable
        TabOrder = 0
      end
      object editPower: TEdit
        Left = 58
        Top = 44
        Width = 123
        Height = 21
        Hint = 'Double click here to power code editor'
        CharCase = ecUpperCase
        ImeMode = imDisable
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Text = 'HHHHHHHHHHHHH'
        TextHint = 'Double click here to power code editor'
        OnDblClick = editPowerDblClick
        OnExit = editPowerExit
      end
      object editAge: TEdit
        Left = 317
        Top = 44
        Width = 42
        Height = 21
        ImeMode = imDisable
        TabOrder = 2
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'WAV'
    Filter = 'Wave Files|*.wav|MP3 Files|*.mp|All Files|*.*'
    FilterIndex = 0
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofNoTestFileCreate, ofEnableSizing]
    Title = 'Select a voice file'
    Left = 304
    Top = 457
  end
end
