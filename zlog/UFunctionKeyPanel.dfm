object formFunctionKeyPanel: TformFunctionKeyPanel
  Left = 0
  Top = 0
  Caption = 'Function Key'
  ClientHeight = 55
  ClientWidth = 730
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object ButtonGroup1: TButtonGroup
    Left = 0
    Top = 0
    Width = 730
    Height = 55
    Align = alClient
    BorderStyle = bsNone
    ButtonWidth = 120
    Items = <
      item
        Caption = 'F1:'
        OnClick = ButtonGroup1Items0Click
      end
      item
        Caption = 'F2:'
        OnClick = ButtonGroup1Items1Click
      end
      item
        Caption = 'F3:'
        OnClick = ButtonGroup1Items2Click
      end
      item
        Caption = 'F4:'
        OnClick = ButtonGroup1Items3Click
      end
      item
        Caption = 'F5:'
        OnClick = ButtonGroup1Items4Click
      end
      item
        Caption = 'F6:'
        OnClick = ButtonGroup1Items5Click
      end
      item
        Caption = 'F7:'
        OnClick = ButtonGroup1Items6Click
      end
      item
        Caption = 'F8:'
        OnClick = ButtonGroup1Items7Click
      end
      item
        Caption = 'F9:'
        OnClick = ButtonGroup1Items8Click
      end
      item
        Caption = 'F10:'
        OnClick = ButtonGroup1Items9Click
      end
      item
        Caption = 'F11:'
        OnClick = ButtonGroup1Items10Click
      end
      item
        Caption = 'F12:'
        OnClick = ButtonGroup1Items11Click
      end>
    TabOrder = 0
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 464
    Top = 16
  end
end
