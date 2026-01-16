inherited WPXMulti: TWPXMulti
  Left = 322
  Top = 81
  Caption = 'Prefixes worked'
  StyleElements = [seFont, seClient, seBorder]
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel: TPanel
    Visible = False
    StyleElements = [seFont, seClient, seBorder]
    inherited RotateLabel1: TRotateLabel
      Width = 15
      Height = 14
      ExplicitWidth = 15
      ExplicitHeight = 14
    end
    inherited RotateLabel2: TRotateLabel
      Width = 15
      Height = 14
      ExplicitWidth = 15
      ExplicitHeight = 14
    end
    inherited RotateLabel3: TRotateLabel
      Width = 6
      Height = 14
      ExplicitWidth = 6
      ExplicitHeight = 14
    end
    inherited RotateLabel4: TRotateLabel
      Width = 12
      Height = 14
      ExplicitWidth = 12
      ExplicitHeight = 14
    end
    inherited RotateLabel5: TRotateLabel
      Width = 12
      Height = 14
      ExplicitWidth = 12
      ExplicitHeight = 14
    end
    inherited RotateLabel6: TRotateLabel
      Width = 12
      Height = 14
      ExplicitWidth = 12
      ExplicitHeight = 14
    end
  end
  inherited Panel1: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited Edit1: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
end
