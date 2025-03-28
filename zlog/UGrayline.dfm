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
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 7
    Width = 480
    Height = 255
    Anchors = [akLeft, akTop, akRight, akBottom]
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
      Caption = 'Show grayline'
      Checked = True
      OnClick = menuShowGraylineClick
    end
    object menuShowMeridians: TMenuItem
      Caption = 'Show meridians'
      OnClick = menuShowMeridiansClick
    end
    object menuShowEquator: TMenuItem
      Caption = 'Show equator'
      OnClick = menuShowEquatorClick
    end
    object menuShowMyLocation: TMenuItem
      Caption = 'Show my location'
      OnClick = menuShowMyLocationClick
    end
  end
end
