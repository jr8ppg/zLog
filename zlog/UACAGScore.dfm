inherited ACAGScore: TACAGScore
  Left = 190
  Top = 394
  Caption = 'Score'
  ClientHeight = 415
  OnShow = FormShow
  ExplicitHeight = 454
  PixelsPerInch = 96
  TextHeight = 12
  inherited Panel1: TPanel
    Top = 382
    ExplicitTop = 382
  end
  object Grid: TStringGrid [1]
    Left = 0
    Top = 0
    Width = 281
    Height = 382
    Align = alClient
    ColCount = 6
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 16
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    Options = [goHorzLine]
    ParentFont = False
    PopupMenu = popupExtraInfo
    ScrollBars = ssNone
    TabOrder = 1
    OnDrawCell = GridDrawCell
  end
end
