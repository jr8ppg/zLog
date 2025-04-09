object formGrayline: TformGrayline
  Left = 0
  Top = 0
  Caption = 'Grayline'
  ClientHeight = 275
  ClientWidth = 497
  Color = clBtnFace
  Constraints.MinHeight = 294
  Constraints.MinWidth = 496
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    497
    275)
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 497
    Height = 275
    Anchors = [akLeft, akTop, akRight, akBottom]
    Stretch = True
    ExplicitWidth = 480
    ExplicitHeight = 255
  end
  object ActivityIndicator1: TActivityIndicator
    Left = 264
    Top = 128
    IndicatorSize = aisLarge
    IndicatorType = aitRotatingLines
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 184
    Top = 104
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 320
    Top = 184
    object menuShowGrayline: TMenuItem
      AutoCheck = True
      Caption = 'Show grayline'
      Checked = True
      OnClick = menuShowGraylineClick
    end
    object menuShowMeridians: TMenuItem
      AutoCheck = True
      Caption = 'Show meridians'
      OnClick = menuShowMeridiansClick
    end
    object menuShowEquator: TMenuItem
      AutoCheck = True
      Caption = 'Show equator'
      OnClick = menuShowEquatorClick
    end
    object menuShowMyLocation: TMenuItem
      AutoCheck = True
      Caption = 'Show my location'
      OnClick = menuShowMyLocationClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object menuStayOnTop: TMenuItem
      AutoCheck = True
      Caption = 'Stay on top'
      OnClick = menuStayOnTopClick
    end
  end
end
