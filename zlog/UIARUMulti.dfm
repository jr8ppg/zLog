inherited IARUMulti: TIARUMulti
  Left = 404
  Top = 179
  Caption = 'IARU HF Multipliers'
  StyleElements = [seFont, seClient, seBorder]
  OnDestroy = FormDestroy
  TextHeight = 13
  inherited Panel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited RotateLabel1: TRotateLabel
      Left = 145
      ExplicitLeft = 145
    end
    inherited RotateLabel2: TRotateLabel
      Left = 157
      ExplicitLeft = 157
    end
    inherited RotateLabel3: TRotateLabel
      Left = 169
      ExplicitLeft = 169
    end
    inherited RotateLabel4: TRotateLabel
      Left = 180
      ExplicitLeft = 180
    end
    inherited RotateLabel5: TRotateLabel
      Left = 192
      ExplicitLeft = 192
    end
    inherited RotateLabel6: TRotateLabel
      Left = 204
      ExplicitLeft = 204
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
