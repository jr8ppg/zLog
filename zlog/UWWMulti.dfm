inherited WWMulti: TWWMulti
  Left = 153
  Top = 98
  Caption = 'CQ WW Country Multipliers'
  ClientHeight = 282
  ClientWidth = 360
  OnResize = FormResize
  OnShow = FormShow
  ExplicitWidth = 376
  ExplicitHeight = 320
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 360
    Height = 41
    Align = alTop
    TabOrder = 0
    object RotateLabel1: TRotateLabel
      Left = 252
      Top = 20
      Width = 14
      Height = 15
      Escapement = 90
      TextStyle = tsNone
      Caption = '1.9'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object RotateLabel2: TRotateLabel
      Left = 264
      Top = 20
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
      Top = 29
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
      Top = 23
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
      Top = 23
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
      Top = 23
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
    object SortBy: TRadioGroup
      Left = 8
      Top = 3
      Width = 209
      Height = 30
      Caption = 'Sort by'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Prefix'
        'Zone'
        'Continent')
      TabOrder = 0
      OnClick = SortByClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 241
    Width = 360
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      360
      41)
    object buttonGo: TButton
      Left = 293
      Top = 11
      Width = 57
      Height = 21
      Anchors = [akTop, akRight]
      Caption = 'Go'
      TabOrder = 0
      OnClick = GoButtonClick
    end
    object Edit1: TEdit
      Left = 225
      Top = 11
      Width = 61
      Height = 21
      Anchors = [akTop, akRight]
      AutoSize = False
      CharCase = ecUpperCase
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
  object Grid: TStringGrid
    Left = 0
    Top = 41
    Width = 360
    Height = 200
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
    TabOrder = 2
    OnDrawCell = GridDrawCell
    OnTopLeftChanged = GridTopLeftChanged
  end
end
