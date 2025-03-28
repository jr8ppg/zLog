object formGrayline: TformGrayline
  Left = 0
  Top = 0
  Caption = 'Grayline'
  ClientHeight = 275
  ClientWidth = 497
  Color = clBtnFace
  Constraints.MinHeight = 314
  Constraints.MinWidth = 513
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
  TextHeight = 16
  object Image1: TImage
    Left = 8
    Top = 7
    Width = 480
    Height = 255
    Anchors = [akLeft, akTop, akRight, akBottom]
    PopupMenu = PopupMenu1
    Stretch = True
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
      Caption = #12464#12524#12452#12521#12452#12531#12434#34920#31034
      Checked = True
      OnClick = menuShowGraylineClick
      AutoCheck = True
    end
    object menuShowMeridians: TMenuItem
      Caption = #23376#21320#32218#12434#34920#31034
      OnClick = menuShowMeridiansClick
      AutoCheck = True
    end
    object menuShowEquator: TMenuItem
      Caption = #36196#36947#12434#34920#31034
      OnClick = menuShowEquatorClick
      AutoCheck = True
    end
    object menuShowMyLocation: TMenuItem
      Caption = #33258#23616#20301#32622#12434#34920#31034
      OnClick = menuShowMyLocationClick
      AutoCheck = True
    end
  end
end
