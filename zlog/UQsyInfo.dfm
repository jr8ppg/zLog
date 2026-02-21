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
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
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
    StyleElements = []
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 157
      Height = 73
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Layout = tlCenter
      WordWrap = True
      StyleElements = []
      ExplicitTop = 6
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
    StyleElements = []
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
      StyleElements = []
      ExplicitHeight = 35
    end
  end
end
