inherited GeneralScore: TGeneralScore
  Left = 133
  Top = 136
  Caption = 'Score'
  ClientHeight = 235
  ClientWidth = 200
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 212
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 200
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 196
    Top = 202
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
  inherited Grid: TStringGrid
    Width = 200
    ExplicitWidth = 200
  end
end
