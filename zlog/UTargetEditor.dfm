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
  Font.Name = 'MS UI Gothic'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object ScoreGrid: TStringGrid
    Left = 0
    Top = 41
    Width = 1008
    Height = 488
    Align = alClient
    ColCount = 50
    DefaultDrawing = False
    RowCount = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goDrawFocusSelected, goEditing]
    ParentFont = False
    PopupMenu = popupScore
    TabOrder = 0
    OnDrawCell = ScoreGridDrawCell
    OnSelectCell = ScoreGridSelectCell
    OnSetEditText = ScoreGridSetEditText
    OnTopLeftChanged = ScoreGridTopLeftChanged
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
      Width = 136
      Height = 33
      Caption = 'ZLO'#12501#12449#12452#12523#12434#12525#12540#12489
      TabOrder = 0
      OnClick = buttonLoadZLOClick
    end
    object buttonAdjust5: TButton
      Tag = 5
      Left = 332
      Top = 5
      Width = 118
      Height = 33
      Caption = '5'#23616#21336#20301#12395#35519#25972
      TabOrder = 1
      OnClick = buttonAdjustClick
    end
    object buttonAdjust10: TButton
      Tag = 10
      Left = 455
      Top = 5
      Width = 118
      Height = 33
      Caption = '10'#23616#21336#20301#12395#35519#25972
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
      Left = 814
      Top = 9
      Width = 90
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'OK'
      TabOrder = 0
      OnClick = buttonOKClick
    end
    object buttonCancel: TButton
      Left = 908
      Top = 9
      Width = 90
      Height = 33
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
    end
    object checkShowWarc: TCheckBox
      Left = 13
      Top = 13
      Width = 144
      Height = 25
      Caption = 'WARC'#12496#12531#12489#12434#34920#31034
      TabOrder = 2
      OnClick = checkShowWarcClick
    end
    object checkShowZero: TCheckBox
      Left = 163
      Top = 13
      Width = 90
      Height = 25
      Caption = '0'#23616#12434#34920#31034
      TabOrder = 3
      OnClick = checkShowZeroClick
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'ZLO'
    Filter = 'zLog binary file|*.ZLO;*.ZLOX|any file|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 344
    Top = 537
  end
  object popupScore: TPopupMenu
    OnPopup = popupScorePopup
    Left = 536
    Top = 349
    object menuCopy: TMenuItem
      Caption = #12467#12500#12540'(&C)'
      ShortCut = 16451
      OnClick = menuCopyClick
    end
    object menuPaste: TMenuItem
      Caption = #36028#12426#20184#12369'(&P)'
      ShortCut = 16470
      OnClick = menuPasteClick
    end
  end
end
