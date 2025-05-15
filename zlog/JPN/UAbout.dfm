object AboutBox: TAboutBox
  Left = 345
  Top = 271
  BorderStyle = bsDialog
  Caption = 'About zLog for Windows'
  ClientHeight = 402
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    321
    402)
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
      Width = 209
      Height = 13
      Caption = 'Copyright 1997-2005 by Yohei Yokobayashi '
      IsControl = True
    end
    object Comments: TLabel
      Left = 8
      Top = 104
      Width = 91
      Height = 13
      Caption = 'Mail comments to : '
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
    object Label4: TLabel
      Left = 104
      Top = 61
      Width = 191
      Height = 13
      AutoSize = False
      Caption = 'CW I/F Information'
    end
    object LinkLabel2: TLinkLabel
      Left = 8
      Top = 119
      Width = 104
      Height = 17
      Caption = '<A HREF="http://www.zlog.org/">http://www.zlog.org/</A>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnLinkClick = LinkLabel1LinkClick
    end
    object LinkLabel3: TLinkLabel
      Left = 101
      Top = 104
      Width = 71
      Height = 17
      Caption = '<A HREF="mailto:zlog@zlog.org">zlog@zlog.org</A>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnLinkClick = LinkLabel1LinkClick
    end
  end
  object OKButton: TButton
    Left = 128
    Top = 377
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
    Height = 193
    Anchors = [akLeft, akTop, akBottom]
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
    DesignSize = (
      305
      193)
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
      Caption = 'Portions created by JR8PPG are Copyright (C) 2025 JR8PPG'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      IsControl = True
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
    object Memo1: TMemo
      Left = 8
      Top = 81
      Width = 287
      Height = 99
      Anchors = [akLeft, akTop, akBottom]
      BorderStyle = bsNone
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      Lines.Strings = (
        #21332#21147#65288#38918#19981#21516#65289':'
        'JH1KVQ, JE1BJP, JR8VSE, JG8LOL, JR8LRQ, '
        'JL1LNC, 7M4KSC, JA1ABC, JO3JYE, JE1CKA, '
        'JH5GHM, JS6RTJ, JJ1CVH, JS2GGD, JE3VRJ, '
        'JJ8DAN, 7N4LNK, JI0VWL, JK1JHU, JS1OYN, '
        'JI1XSE, JG1VPP, JS2FVO, JN2AMD, JJ3TBB,'
        'JF1SXL, ZLOG-REIWA ML'#21442#21152#32773#12398#12415#12394#12373#12435
        'JA1ZLO'#12398#12415#12394#12373#12435)
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
  end
end
