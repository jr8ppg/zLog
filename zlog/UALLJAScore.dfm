inherited ALLJAScore: TALLJAScore
  Left = 291
  Top = 30
  Caption = 'Score'
  ClientWidth = 200
  OnShow = FormShow
  ExplicitWidth = 216
  PixelsPerInch = 96
  TextHeight = 12
  inherited Panel1: TPanel
    Width = 200
    ExplicitWidth = 200
    inherited CWButton: TSpeedButton
      Left = 160
      ExplicitLeft = 160
    end
  end
  object Grid: TStringGrid [1]
    Left = 0
    Top = 0
    Width = 200
    Height = 202
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
