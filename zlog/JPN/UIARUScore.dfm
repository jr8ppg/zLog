inherited IARUScore: TIARUScore
  Left = 225
  Top = 83
  Caption = 'Score'
  PixelsPerInch = 96
  TextHeight = 12
  inherited Panel1: TPanel
    TabOrder = 1
  end
  object Grid: TStringGrid [1]
    Left = 0
    Top = 0
    Width = 281
    Height = 202
    Align = alClient
    ColCount = 7
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
    TabOrder = 0
    OnDrawCell = GridDrawCell
    ExplicitWidth = 200
  end
end
