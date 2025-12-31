inherited GeneralScore: TGeneralScore
  Left = 133
  Top = 136
  Caption = 'Score'
  ClientWidth = 200
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 216
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 200
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 200
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
  end
end
