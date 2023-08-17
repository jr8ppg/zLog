object formCWMonitor: TformCWMonitor
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight]
  Caption = 'CW Monitor'
  ClientHeight = 49
  ClientWidth = 224
  Color = clBtnFace
  Constraints.MaxHeight = 88
  Constraints.MinHeight = 88
  Constraints.MinWidth = 150
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    224
    49)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 4
    Width = 64
    Height = 12
    Caption = 'Sending text'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
  end
  object PaintBox1: TPaintBox
    Left = 4
    Top = 17
    Width = 216
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    OnPaint = PaintBox1Paint
    ExplicitWidth = 207
  end
end
