object KCJZone: TKCJZone
  Left = 128
  Top = 72
  Caption = 'Multi map'
  ClientHeight = 453
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 413
    Width = 454
    Height = 40
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 73
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button1Click
    end
    object cbStayOnTop: TCheckBox
      Left = 88
      Top = 11
      Width = 97
      Height = 17
      Caption = 'Stay on top'
      TabOrder = 1
      OnClick = cbStayOnTopClick
    end
  end
  object Grid1: TStringGrid
    Left = 0
    Top = 0
    Width = 151
    Height = 413
    Align = alLeft
    ColCount = 8
    DefaultColWidth = 18
    DefaultRowHeight = 16
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 25
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
      18
      18
      18
      18
      18
      18
      18
      18)
    RowHeights = (
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16)
  end
  object Grid3: TStringGrid
    Tag = 48
    Left = 302
    Top = 0
    Width = 151
    Height = 413
    Align = alLeft
    ColCount = 8
    DefaultColWidth = 18
    DefaultRowHeight = 16
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 25
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    Options = [goHorzLine]
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 2
    OnDrawCell = GridDrawCell
    ColWidths = (
      18
      18
      18
      18
      18
      18
      18
      18)
    RowHeights = (
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16)
  end
  object Grid2: TStringGrid
    Tag = 24
    Left = 151
    Top = 0
    Width = 151
    Height = 413
    Align = alLeft
    ColCount = 8
    DefaultColWidth = 18
    DefaultRowHeight = 16
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 25
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    Options = [goHorzLine]
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 3
    OnDrawCell = GridDrawCell
    ColWidths = (
      18
      18
      18
      18
      18
      18
      18
      18)
    RowHeights = (
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16
      16)
  end
end
