inherited KCJMulti: TKCJMulti
  Left = 577
  Top = 55
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Multipliers info'
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 222
    Width = 314
    Height = 40
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 57
      Height = 23
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button1Click
    end
    object cbStayOnTop: TCheckBox
      Left = 144
      Top = 11
      Width = 81
      Height = 17
      Caption = 'Stay on top'
      TabOrder = 1
      OnClick = cbStayOnTopClick
    end
    object combBand: TComboBox
      Left = 224
      Top = 9
      Width = 73
      Height = 21
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      TabOrder = 2
      Text = 'combBand'
      OnChange = combBandChange
      Items.Strings = (
        '1.9 MHz'
        '3.5 MHz'
        '7 MHz'
        '14 MHz'
        '21 MHz'
        '28 MHz'
        '50 MHz')
    end
    object Button2: TButton
      Left = 77
      Top = 8
      Width = 57
      Height = 23
      Caption = 'Multi map'
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object Grid: TStringGrid
    Left = 0
    Top = 0
    Width = 314
    Height = 222
    Align = alClient
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 15
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    Options = [goHorzLine]
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 1
    OnDrawCell = GridDrawCell
    ColWidths = (
      64
      64
      64
      64
      64)
    RowHeights = (
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24)
  end
end
