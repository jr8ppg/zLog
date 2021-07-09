object TargetEditor: TTargetEditor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Target Editor'
  ClientHeight = 577
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object ScoreGrid: TStringGrid
    Left = 0
    Top = 41
    Width = 1008
    Height = 488
    Align = alClient
    ColCount = 26
    DefaultDrawing = False
    RowCount = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
    ParentFont = False
    TabOrder = 0
    OnDrawCell = ScoreGridDrawCell
    OnSetEditText = ScoreGridSetEditText
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1008
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object buttonLoadZLO: TButton
      Left = 13
      Top = 5
      Width = 84
      Height = 33
      Caption = 'Load ZLO'
      TabOrder = 0
      OnClick = buttonLoadZLOClick
    end
    object buttonAdjust5: TButton
      Tag = 5
      Left = 333
      Top = 5
      Width = 84
      Height = 33
      Caption = 'Adjust 5'
      TabOrder = 1
      OnClick = buttonAdjustClick
    end
    object buttonAdjust10: TButton
      Tag = 10
      Left = 423
      Top = 5
      Width = 84
      Height = 33
      Caption = 'Adjust 10'
      TabOrder = 2
      OnClick = buttonAdjustClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 529
    Width = 1008
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      1008
      48)
    object buttonOK: TButton
      Left = 829
      Top = 9
      Width = 81
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'OK'
      TabOrder = 0
      OnClick = buttonOKClick
    end
    object buttonCancel: TButton
      Left = 916
      Top = 9
      Width = 81
      Height = 33
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object checkShowWarc: TCheckBox
      Left = 13
      Top = 13
      Width = 105
      Height = 25
      Caption = 'Show WARC'
      TabOrder = 2
      OnClick = checkShowWarcClick
    end
    object checkShowZero: TCheckBox
      Left = 141
      Top = 13
      Width = 105
      Height = 25
      Caption = 'Show Zero'
      TabOrder = 3
      OnClick = checkShowZeroClick
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'ZLO'
    Filter = 'zLog binary file|*.ZLO|any file|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 344
    Top = 537
  end
end
