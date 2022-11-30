object ACAGMulti: TACAGMulti
  Left = 331
  Top = 79
  Caption = 'Multipliers Info'
  ClientHeight = 305
  ClientWidth = 361
  Color = clBtnFace
  Constraints.MinHeight = 150
  Constraints.MinWidth = 377
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
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
    Top = 264
    Width = 361
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      361
      41)
    object buttonGo: TButton
      Left = 293
      Top = 11
      Width = 57
      Height = 21
      Anchors = [akRight, akBottom]
      Caption = 'Go'
      TabOrder = 1
      OnClick = GoButtonClick2
      ExplicitLeft = 292
    end
    object Edit1: TEdit
      Left = 226
      Top = 11
      Width = 61
      Height = 21
      Anchors = [akRight, akBottom]
      CharCase = ecUpperCase
      TabOrder = 0
      OnChange = Edit1Change
      OnEnter = Edit1Enter
      OnExit = Edit1Exit
      ExplicitLeft = 225
    end
    object StayOnTop: TCheckBox
      Left = 8
      Top = 13
      Width = 81
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = #25163#21069#12395#34920#31034
      TabOrder = 2
      OnClick = StayOnTopClick
    end
    object checkIncremental: TCheckBox
      Left = 90
      Top = 13
      Width = 130
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = #12452#12531#12463#12522#12513#12531#12479#12523#12469#12540#12481
      TabOrder = 3
    end
  end
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 361
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 360
    object Label1R9: TRotateLabel
      Left = 174
      Top = 20
      Width = 15
      Height = 14
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
      Width = 15
      Height = 14
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
      Width = 6
      Height = 14
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
      Width = 12
      Height = 14
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
      Width = 12
      Height = 14
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
      Width = 12
      Height = 14
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
      Width = 12
      Height = 14
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
      Width = 18
      Height = 14
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
      Width = 18
      Height = 14
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
      Width = 24
      Height = 14
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
      Width = 24
      Height = 14
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
      Width = 24
      Height = 14
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
      Width = 26
      Height = 14
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
      Width = 142
      Height = 17
      Caption = #26368#24460#12398#12510#12523#12481#12408#12472#12515#12531#12503
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
  end
  object Grid: TStringGrid
    Left = 0
    Top = 41
    Width = 361
    Height = 223
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
    ExplicitWidth = 360
    ExplicitHeight = 200
  end
end
