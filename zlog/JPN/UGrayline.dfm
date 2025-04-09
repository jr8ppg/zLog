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
      Caption = #12464#12524#12452#12521#12452#12531#12434#34920#31034
      Checked = True
      OnClick = menuShowGraylineClick
    end
    object menuShowMeridians: TMenuItem
      AutoCheck = True
      Caption = #23376#21320#32218#12434#34920#31034
      OnClick = menuShowMeridiansClick
    end
    object menuShowEquator: TMenuItem
      AutoCheck = True
      Caption = #36196#36947#12434#34920#31034
      OnClick = menuShowEquatorClick
    end
    object menuShowMyLocation: TMenuItem
      AutoCheck = True
      Caption = #33258#23616#20301#32622#12434#34920#31034
      OnClick = menuShowMyLocationClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object menuStayOnTop: TMenuItem
      AutoCheck = True
      Caption = #25163#21069#12395#34920#31034
      OnClick = menuStayOnTopClick
    end
  end
end
