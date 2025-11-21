inherited GeneralScore: TGeneralScore
  Left = 133
  Top = 136
  Caption = 'Score'
  ClientWidth = 200
  ExplicitWidth = 216
  TextHeight = 12
  inherited Panel1: TPanel
    Width = 200
    ExplicitWidth = 196
    DesignSize = (
      200
      33)
    inherited CWButton: TSpeedButton
      Left = 156
      ExplicitLeft = 160
    end
    inherited StayOnTop: TCheckBox
      Caption = 'Stay on Top'
    end
  end
  object Grid: TStringGrid [1]
    Left = 0
    Top = 0
    Width = 200
    Height = 202
    Align = alClient
    ColCount = 8
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
    PopupMenu = popupExtraInfo
    ScrollBars = ssNone
    TabOrder = 1
    OnDrawCell = GridDrawCell
    ExplicitWidth = 196
    ExplicitHeight = 201
    ColWidths = (
      64
      64
      64
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
