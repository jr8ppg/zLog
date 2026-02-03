object formSentNumber: TformSentNumber
  Left = 0
  Top = 0
  Caption = 'Sent number'
  ClientHeight = 120
  ClientWidth = 300
  Color = clBtnFace
  Constraints.MinHeight = 130
  Constraints.MinWidth = 300
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
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
    Font.Charset = ANSI_CHARSET
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
      Caption = 'Stay on top'
      TabOrder = 0
      OnClick = StayOnTopClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 208
    Top = 12
    object menuFont: TMenuItem
      Caption = 'Font settings'
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
