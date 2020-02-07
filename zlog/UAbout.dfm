object AboutBox: TAboutBox
  Left = 345
  Top = 271
  BorderStyle = bsDialog
  Caption = 'About zLog for Windows'
  ClientHeight = 309
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    321
    309)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 305
    Height = 161
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object ProgramIcon: TImage
      Left = 8
      Top = 8
      Width = 73
      Height = 73
      Picture.Data = {
        07544269746D617076020000424D760200000000000076000000280000002000
        0000200000000100040000000000000200000000000000000000100000001000
        000000000000000080000080000000808000800000008000800080800000C0C0
        C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777888888888888888888888888888
        88870000000000000000000000000000000000F00F0000000000000000000000
        0000000000000000000880000000880880000000000000000080080000008808
        8000008808808800008008000000000000000088088088000008800000000009
        0900000000000000000000000000000000000009090900000000000000000009
        090000EEEEEEEEEEEEEEEE0AAAAAA000000000EE444EE44EEE4E4E09999AA009
        090000EEEEEEEEEEEEEEEE0AAAAAA00000000000000000000000000000000000
        0000000000000000000000000000000000008888888888888888888888888888
        8888700000000000000000000000000000077770000000000000000000000000
        0777777770000000000000000000000777777777777000000000000000000777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777}
      Stretch = True
      Transparent = True
      IsControl = True
    end
    object ProductName: TLabel
      Left = 104
      Top = 16
      Width = 156
      Height = 24
      Caption = 'zLog for Windows'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      IsControl = True
    end
    object Version: TLabel
      Left = 104
      Top = 48
      Width = 59
      Height = 13
      Caption = 'Version 2.2h'
      IsControl = True
    end
    object Copyright: TLabel
      Left = 8
      Top = 80
      Width = 287
      Height = 13
      Caption = 'Copyright 1997-2005 by Yohei Yokobayashi JJ1MED/AD6AJ'
      IsControl = True
    end
    object Comments: TLabel
      Left = 8
      Top = 104
      Width = 158
      Height = 13
      Caption = 'Mail comments to : zlog@zlog.org'
      WordWrap = True
      IsControl = True
    end
    object Label1: TLabel
      Left = 8
      Top = 136
      Width = 65
      Height = 13
      Caption = 'May 23, 2005'
    end
    object Label2: TLabel
      Left = 112
      Top = 136
      Width = 33
      Height = 12
      Caption = 'Label2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 120
      Width = 100
      Height = 13
      Caption = 'http://www.zlog.org/'
      WordWrap = True
      IsControl = True
    end
    object Label4: TLabel
      Left = 195
      Top = 48
      Width = 3
      Height = 13
    end
  end
  object OKButton: TButton
    Left = 128
    Top = 284
    Width = 65
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = OKButtonClick
  end
  object Panel2: TPanel
    Left = 8
    Top = 175
    Width = 305
    Height = 106
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    object Label6: TLabel
      Left = 8
      Top = 9
      Width = 287
      Height = 26
      AutoSize = False
      Caption = 'zLog for Windows Version 2.3.0.0 '#20196#21644' Edition based on 2.2h'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      WordWrap = True
      IsControl = True
    end
    object Label7: TLabel
      Left = 8
      Top = 41
      Width = 287
      Height = 13
      Caption = 'Portions created by JR8PPG are Copyright (C) 2020 JR8PPG'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      IsControl = True
    end
    object Label5: TLabel
      Left = 8
      Top = 80
      Width = 247
      Height = 12
      Caption = #21332#21147':JH1KVQ,JE1BJP,JR8VSE,JG8LOL,JR8LRQ'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object LinkLabel1: TLinkLabel
      Left = 8
      Top = 59
      Width = 164
      Height = 16
      Caption = 
        '<A HREF="https://github.com/jr8ppg/zLog">https://github.com/jr8p' +
        'pg/zLog</A>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnLinkClick = LinkLabel1LinkClick
    end
  end
end
