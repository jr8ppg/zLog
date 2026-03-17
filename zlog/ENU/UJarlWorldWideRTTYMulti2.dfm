inherited JarlWorldWideRTTYMulti2: TJarlWorldWideRTTYMulti2
  Left = 322
  Top = 81
  Caption = 'Call area multipliers'
  ClientWidth = 413
  Font.Height = -12
  Font.Name = 'Arial'
  StyleElements = [seFont, seClient, seBorder]
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  ExplicitWidth = 429
  TextHeight = 15
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 413
    Height = 37
    Align = alTop
    TabOrder = 0
    object RotateLabel2: TRotateLabel
      Left = 264
      Top = 15
      Width = 14
      Height = 15
      Escapement = 90
      TextStyle = tsNone
      Caption = '3.5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object RotateLabel3: TRotateLabel
      Left = 276
      Top = 24
      Width = 14
      Height = 6
      Escapement = 90
      TextStyle = tsNone
      Caption = '7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object RotateLabel4: TRotateLabel
      Left = 287
      Top = 18
      Width = 14
      Height = 12
      Escapement = 90
      TextStyle = tsNone
      Caption = '14'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object RotateLabel5: TRotateLabel
      Left = 299
      Top = 18
      Width = 14
      Height = 12
      Escapement = 90
      TextStyle = tsNone
      Caption = '21'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object RotateLabel6: TRotateLabel
      Left = 311
      Top = 18
      Width = 14
      Height = 12
      Escapement = 90
      TextStyle = tsNone
      Caption = '28'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
  end
  object Grid: TStringGrid
    Left = 0
    Top = 37
    Width = 413
    Height = 184
    Align = alClient
    ColCount = 1
    DefaultColWidth = 500
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 61
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    Options = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    OnDrawCell = GridDrawCell
    OnTopLeftChanged = GridTopLeftChanged
  end
  object Panel1: TPanel
    Left = 0
    Top = 221
    Width = 413
    Height = 41
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      413
      41)
    object buttonGo: TButton
      Left = 346
      Top = 11
      Width = 57
      Height = 21
      Anchors = [akTop, akRight]
      Caption = 'Go'
      TabOrder = 0
      OnClick = GoButtonClick
    end
    object Edit1: TEdit
      Left = 278
      Top = 11
      Width = 61
      Height = 21
      Anchors = [akTop, akRight]
      AutoSize = False
      CharCase = ecUpperCase
      ImeMode = imClose
      TabOrder = 1
      OnChange = Edit1Change
      OnEnter = Edit1Enter
      OnExit = Edit1Exit
    end
    object StayOnTop: TCheckBox
      Left = 8
      Top = 13
      Width = 81
      Height = 17
      Caption = 'Stay on top'
      TabOrder = 2
      OnClick = StayOnTopClick
    end
  end
end
