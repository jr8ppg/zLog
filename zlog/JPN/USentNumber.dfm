object formSentNumber: TformSentNumber
  Left = 0
  Top = 0
  Caption = #12467#12531#12486#12473#12488#12490#12531#12496#12540
  ClientHeight = 120
  ClientWidth = 300
  Color = clBtnFace
  Constraints.MinHeight = 130
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poDesigned
  Scaled = False
  DesignSize = (
    300
    120)
  TextHeight = 13
  object panelSentNumber: TPanel
    Left = 8
    Top = 8
    Width = 284
    Height = 81
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvLowered
    Caption = '599 010103H'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 97
    Width = 300
    Height = 23
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      300
      23)
    object StayOnTop: TCheckBox
      Left = 8
      Top = 2
      Width = 81
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = #25163#21069#12395#34920#31034
      TabOrder = 0
      OnClick = StayOnTopClick
    end
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 208
    Top = 12
    object menuFont: TMenuItem
      Caption = #12501#12457#12531#12488#35373#23450
      OnClick = menuFontClick
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = [fdEffects, fdForceFontExist]
    Left = 244
    Top = 16
  end
end
