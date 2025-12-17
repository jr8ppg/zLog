inherited WPXMulti: TWPXMulti
  Left = 322
  Top = 81
  Caption = 'Prefixes worked'
  StyleElements = [seFont, seClient, seBorder]
  OnDestroy = FormDestroy
  TextHeight = 13
  inherited Panel: TPanel
    Visible = False
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited Panel1: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited Edit1: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
end
