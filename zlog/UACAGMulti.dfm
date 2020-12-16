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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 241
    Width = 360
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitWidth = 344
    DesignSize = (
      360
      41)
    object Button3: TButton
      Left = 292
      Top = 11
      Width = 57
      Height = 21
      Anchors = [akRight, akBottom]
      Caption = 'Go'
      TabOrder = 0
      OnClick = GoButtonClick2
      ExplicitLeft = 276
    end
    object Edit1: TEdit
      Left = 244
      Top = 11
      Width = 33
      Height = 21
      Anchors = [akRight, akBottom]
      TabOrder = 1
      OnKeyPress = Edit1KeyPress
      ExplicitLeft = 228
    end
    object Button1: TButton
      Left = 8
      Top = 11
      Width = 65
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = 'OK'
      TabOrder = 2
      OnClick = Button1Click
    end
    object StayOnTop: TCheckBox
      Left = 80
      Top = 13
      Width = 81
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Stay on top'
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
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitTop = -6
    ExplicitWidth = 344
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
  object Grid: TMgrid
    Left = 0
    Top = 41
    Width = 360
    Height = 200
    Align = alClient
    ColCount = 1
    DefaultColWidth = 500
    DefaultRowHeight = 14
    FixedCols = 0
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    GridLineWidth = 0
    Options = [goRowSelect, goThumbTracking]
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
    Alignment = taLeftJustify
    BorderColor = clSilver
    OddRowColor = clWindow
    EvenRowColor = clWindow
    OnSetting = GridSetting
    ExplicitWidth = 344
    ColWidths = (
      500)
    RowHeights = (
      14
      14
      14
      14
      14)
  end
end
