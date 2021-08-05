object formQsyInfo: TformQsyInfo
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'QSY Indicator'
  ClientHeight = 63
  ClientWidth = 184
  Color = clBtnFace
  Constraints.MinHeight = 100
  Constraints.MinWidth = 100
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 184
    Height = 63
    Align = alClient
    BevelOuter = bvNone
    Caption = 'QSY OK'
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -40
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    ExplicitTop = 32
    ExplicitWidth = 185
    ExplicitHeight = 41
  end
end
