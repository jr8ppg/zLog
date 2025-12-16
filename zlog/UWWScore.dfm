inherited WWScore: TWWScore
  Left = 311
  Top = 182
  Caption = 'Score'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 12
  inherited Panel1: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  object Grid: TStringGrid [1]
    Left = 0
    Top = 0
    Width = 281
    Height = 202
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
  end
end
