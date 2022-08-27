object WWZone: TWWZone
  Left = 29
  Top = 373
  Caption = 'CQ Zones'
  ClientHeight = 158
  ClientWidth = 577
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 118
    Width = 577
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
  object Grid: TStringGrid
    Left = 0
    Top = 0
    Width = 577
    Height = 118
    Align = alClient
    ColCount = 41
    DefaultColWidth = 18
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 7
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    Options = [goVertLine, goHorzLine]
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 1
    OnDrawCell = GridDrawCell
    RowHeights = (
      24
      24
      24
      24
      24
      24
      24)
  end
end
