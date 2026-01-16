inherited IARUMulti: TIARUMulti
  Left = 404
  Top = 179
  Caption = 'IARU HF Multipliers'
  StyleElements = [seFont, seClient, seBorder]
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited RotateLabel1: TRotateLabel
      Left = 145
      Width = 15
      Height = 14
      ExplicitLeft = 145
      ExplicitWidth = 15
      ExplicitHeight = 14
    end
    inherited RotateLabel2: TRotateLabel
      Left = 157
      Width = 15
      Height = 14
      ExplicitLeft = 157
      ExplicitWidth = 15
      ExplicitHeight = 14
    end
    inherited RotateLabel3: TRotateLabel
      Left = 169
      Width = 6
      Height = 14
      ExplicitLeft = 169
      ExplicitWidth = 6
      ExplicitHeight = 14
    end
    inherited RotateLabel4: TRotateLabel
      Left = 180
      Width = 12
      Height = 14
      ExplicitLeft = 180
      ExplicitWidth = 12
      ExplicitHeight = 14
    end
    inherited RotateLabel5: TRotateLabel
      Left = 192
      Width = 12
      Height = 14
      ExplicitLeft = 192
      ExplicitWidth = 12
      ExplicitHeight = 14
    end
    inherited RotateLabel6: TRotateLabel
      Left = 204
      Width = 12
      Height = 14
      ExplicitLeft = 204
      ExplicitWidth = 12
      ExplicitHeight = 14
    end
    inherited SortBy: TRadioGroup
      Visible = False
    end
  end
  inherited Panel1: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited Edit1: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
end
