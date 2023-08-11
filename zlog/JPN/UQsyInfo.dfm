object formQsyInfo: TformQsyInfo
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'QSY Indicator'
  ClientHeight = 114
  ClientWidth = 157
  Color = clBtnFace
  Constraints.MinHeight = 150
  Constraints.MinWidth = 150
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clRed
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 157
    Height = 73
    Align = alClient
    BevelOuter = bvNone
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -40
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 157
      Height = 26
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Layout = tlCenter
      WordWrap = True
      ExplicitTop = 6
      ExplicitHeight = 73
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 157
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -29
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    ShowCaption = False
    TabOrder = 1
    object Label2: TLabel
      Left = 0
      Top = 0
      Width = 157
      Height = 41
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Layout = tlCenter
      WordWrap = True
      ExplicitHeight = 35
    end
  end
end
