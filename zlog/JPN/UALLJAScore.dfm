inherited ALLJAScore: TALLJAScore
  Left = 291
  Top = 30
  Caption = 'Score'
  ClientWidth = 200
  StyleElements = [seFont, seClient, seBorder]
  OnShow = FormShow
  ExplicitWidth = 216
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 200
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 200
    inherited CWButton: TSpeedButton
      Left = 160
      ExplicitLeft = 160
    end
  end
  inherited Grid: TStringGrid
    Width = 200
    ExplicitWidth = 200
  end
end
