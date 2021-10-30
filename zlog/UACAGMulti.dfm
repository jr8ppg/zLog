object ACAGMulti: TACAGMulti
  Left = 331
  Top = 79
  Caption = 'Multipliers Info'
  ClientHeight = 282
  ClientWidth = 360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 241
    Width = 360
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      360
      41)
    object buttonGo: TButton
      Left = 292
      Top = 11
      Width = 57
      Height = 21
      Anchors = [akRight, akBottom]
      Caption = 'Go'
      TabOrder = 1
      OnClick = GoButtonClick2
    end
    object Edit1: TEdit
      Left = 225
      Top = 11
      Width = 61
      Height = 21
      Anchors = [akRight, akBottom]
      TabOrder = 0
      OnChange = Edit1Change
      OnEnter = Edit1Enter
      OnExit = Edit1Exit
    end
    object StayOnTop: TCheckBox
      Left = 8
      Top = 13
      Width = 81
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Stay on top'
      TabOrder = 2
      OnClick = StayOnTopClick
    end
    object checkIncremental: TCheckBox
      Left = 95
      Top = 13
      Width = 81
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Incremental'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = StayOnTopClick
    end
  end
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 360
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1R9: TRotateLabel
      Left = 174
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
    object Label3R5: TRotateLabel
      Left = 186
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
    object Label7: TRotateLabel
      Left = 198
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
    object Label14: TRotateLabel
      Left = 210
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
    object Label21: TRotateLabel
      Left = 222
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
    object Label28: TRotateLabel
      Left = 234
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
    object Label50: TRotateLabel
      Left = 247
      Top = 23
      Width = 14
      Height = 12
      Escapement = 90
      TextStyle = tsNone
      Caption = '50'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label144: TRotateLabel
      Left = 259
      Top = 17
      Width = 14
      Height = 18
      Escapement = 90
      TextStyle = tsNone
      Caption = '144'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label430: TRotateLabel
      Left = 271
      Top = 17
      Width = 14
      Height = 18
      Escapement = 90
      TextStyle = tsNone
      Caption = '430'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1200: TRotateLabel
      Left = 283
      Top = 11
      Width = 14
      Height = 24
      Escapement = 90
      TextStyle = tsNone
      Caption = '1200'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2400: TRotateLabel
      Left = 295
      Top = 11
      Width = 14
      Height = 24
      Escapement = 90
      TextStyle = tsNone
      Caption = '2400'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5600: TRotateLabel
      Left = 307
      Top = 11
      Width = 14
      Height = 24
      Escapement = 90
      TextStyle = tsNone
      Caption = '5600'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label10g: TRotateLabel
      Left = 319
      Top = 9
      Width = 14
      Height = 26
      Escapement = 90
      TextStyle = tsNone
      Caption = '10G+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object checkJumpLatestMulti: TCheckBox
      Left = 8
      Top = 13
      Width = 121
      Height = 17
      Caption = 'Jump to Latest Multi'
      Checked = True
      State = cbChecked
      TabOrder = 0
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
  end
end
