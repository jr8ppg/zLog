object PackageLoader: TPackageLoader
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Downloading'
  ClientHeight = 121
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object MsgLabel: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 474
    Height = 54
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    Caption = 'Downloading...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
    ExplicitWidth = 85
    ExplicitHeight = 16
  end
  object ProgressBar: TProgressBar
    AlignWithMargins = True
    Left = 10
    Top = 84
    Width = 474
    Height = 17
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 20
    Align = alBottom
    TabOrder = 0
  end
end
