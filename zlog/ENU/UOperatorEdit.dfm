object formOperatorEdit: TformOperatorEdit
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Operator'
  ClientHeight = 495
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
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
    Top = 458
    Width = 369
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      369
      37)
    object buttonOK: TButton
      Left = 111
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = buttonOKClick
    end
    object buttonCancel: TButton
      Left = 191
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 84
    Width = 357
    Height = 288
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
      Top = 153
      Width = 13
      Height = 13
      Caption = '#7'
    end
    object Label27: TLabel
      Left = 8
      Top = 175
      Width = 13
      Height = 13
      Caption = '#8'
    end
    object Label72: TLabel
      Left = 8
      Top = 197
      Width = 13
      Height = 13
      Caption = '#9'
    end
    object Label73: TLabel
      Left = 8
      Top = 219
      Width = 19
      Height = 13
      Caption = '#10'
    end
    object Label77: TLabel
      Left = 8
      Top = 241
      Width = 19
      Height = 13
      Caption = '#11'
    end
    object Label78: TLabel
      Left = 8
      Top = 263
      Width = 19
      Height = 13
      Caption = '#12'
    end
    object editVoiceFile01: TEdit
      Left = 40
      Top = 19
      Width = 280
      Height = 21
      TabOrder = 0
    end
    object editVoiceFile02: TEdit
      Left = 40
      Top = 41
      Width = 280
      Height = 21
      TabOrder = 2
    end
    object editVoiceFile03: TEdit
      Left = 40
      Top = 63
      Width = 280
      Height = 21
      TabOrder = 4
    end
    object editVoiceFile04: TEdit
      Left = 40
      Top = 85
      Width = 280
      Height = 21
      TabOrder = 6
    end
    object editVoiceFile05: TEdit
      Left = 40
      Top = 107
      Width = 280
      Height = 21
      TabOrder = 8
    end
    object editVoiceFile06: TEdit
      Left = 40
      Top = 129
      Width = 280
      Height = 21
      TabOrder = 10
    end
    object editVoiceFile07: TEdit
      Left = 40
      Top = 150
      Width = 280
      Height = 21
      TabOrder = 12
    end
    object editVoiceFile08: TEdit
      Left = 40
      Top = 172
      Width = 280
      Height = 21
      TabOrder = 14
    end
    object editVoiceFile09: TEdit
      Left = 40
      Top = 194
      Width = 280
      Height = 21
      TabOrder = 16
    end
    object editVoiceFile10: TEdit
      Left = 40
      Top = 216
      Width = 280
      Height = 21
      TabOrder = 18
    end
    object editVoiceFile11: TEdit
      Left = 40
      Top = 238
      Width = 280
      Height = 21
      TabOrder = 20
    end
    object editVoiceFile12: TEdit
      Left = 40
      Top = 260
      Width = 280
      Height = 21
      TabOrder = 22
    end
    object buttonVoiceRef01: TButton
      Tag = 1
      Left = 323
      Top = 19
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = buttonVoiceRefClick
    end
    object buttonVoiceRef02: TButton
      Tag = 2
      Left = 323
      Top = 41
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 3
      OnClick = buttonVoiceRefClick
    end
    object buttonVoiceRef03: TButton
      Tag = 3
      Left = 323
      Top = 63
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 5
      OnClick = buttonVoiceRefClick
    end
    object buttonVoiceRef04: TButton
      Tag = 4
      Left = 323
      Top = 85
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 7
      OnClick = buttonVoiceRefClick
    end
    object buttonVoiceRef05: TButton
      Tag = 5
      Left = 323
      Top = 107
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 9
      OnClick = buttonVoiceRefClick
    end
    object buttonVoiceRef06: TButton
      Tag = 6
      Left = 323
      Top = 129
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 11
      OnClick = buttonVoiceRefClick
    end
    object buttonVoiceRef07: TButton
      Tag = 7
      Left = 323
      Top = 150
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 13
      OnClick = buttonVoiceRefClick
    end
    object buttonVoiceRef08: TButton
      Tag = 8
      Left = 323
      Top = 172
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 15
      OnClick = buttonVoiceRefClick
    end
    object buttonVoiceRef09: TButton
      Tag = 9
      Left = 323
      Top = 194
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 17
      OnClick = buttonVoiceRefClick
    end
    object buttonVoiceRef10: TButton
      Tag = 10
      Left = 323
      Top = 216
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 19
      OnClick = buttonVoiceRefClick
    end
    object buttonVoiceRef11: TButton
      Tag = 11
      Left = 323
      Top = 238
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 21
      OnClick = buttonVoiceRefClick
    end
    object buttonVoiceRef12: TButton
      Tag = 12
      Left = 323
      Top = 260
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 23
      OnClick = buttonVoiceRefClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 4
    Top = 4
    Width = 357
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
      Left = 279
      Top = 47
      Width = 19
      Height = 13
      Caption = 'Age'
    end
    object Label4: TLabel
      Left = 181
      Top = 47
      Width = 80
      Height = 13
      Caption = '(Exclude WARC)'
    end
    object editCallsign: TEdit
      Left = 52
      Top = 21
      Width = 81
      Height = 21
      CharCase = ecUpperCase
      ImeMode = imDisable
      TabOrder = 0
    end
    object editPower: TEdit
      Left = 52
      Top = 44
      Width = 123
      Height = 21
      CharCase = ecUpperCase
      ImeMode = imDisable
      TabOrder = 1
      Text = 'HHHHHHHHHHHHH'
      OnExit = editPowerExit
    end
    object editAge: TEdit
      Left = 304
      Top = 44
      Width = 42
      Height = 21
      ImeMode = imDisable
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 4
    Top = 378
    Width = 357
    Height = 71
    Caption = 'Additional CQ Messages'
    TabOrder = 2
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
      Width = 280
      Height = 21
      TabOrder = 0
    end
    object editCQMessage3: TEdit
      Left = 40
      Top = 41
      Width = 280
      Height = 21
      TabOrder = 2
    end
    object buttonCQMessage2Ref: TButton
      Tag = 2
      Left = 323
      Top = 19
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = buttonCQMessageRefClick
    end
    object buttonCQMessage3Ref: TButton
      Tag = 3
      Left = 323
      Top = 41
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 3
      OnClick = buttonCQMessageRefClick
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
