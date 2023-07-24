object formExportHamlog: TformExportHamlog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Export'
  ClientHeight = 514
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331#12288#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 530
    Height = 485
    Align = alClient
    Caption = 'HAMLOG'#29992#20986#21147#35373#23450
    TabOrder = 0
    object groupRemarks1: TGroupBox
      Left = 12
      Top = 24
      Width = 501
      Height = 130
      Caption = 'Remarks1'#12398#20986#21147#20869#23481
      TabOrder = 0
      object buttonShowReplaceKeywords1: TSpeedButton
        Left = 469
        Top = 45
        Width = 21
        Height = 21
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
          00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        OnClick = buttonShowReplaceKeywordsClick
      end
      object radioRemarks1Opt1: TRadioButton
        Left = 25
        Top = 49
        Width = 60
        Height = 13
        Caption = #20837#21147
        TabOrder = 1
        OnClick = radioRemarks1Opt1Click
      end
      object radioRemarks1Opt2: TRadioButton
        Left = 25
        Top = 75
        Width = 69
        Height = 13
        Caption = 'Operator'
        TabOrder = 3
        OnClick = radioRemarks1Opt2Click
      end
      object radioRemarks1Opt3: TRadioButton
        Left = 25
        Top = 101
        Width = 69
        Height = 13
        Caption = 'Memo'
        TabOrder = 4
        OnClick = radioRemarks1Opt3Click
      end
      object radioRemarks1Opt0: TRadioButton
        Left = 25
        Top = 23
        Width = 92
        Height = 13
        Caption = #20309#12418#20986#12373#12394#12356
        TabOrder = 0
        OnClick = radioRemarks1Opt3Click
      end
      object editRemarks1Opt1: TEdit
        Left = 100
        Top = 45
        Width = 366
        Height = 21
        TabOrder = 2
      end
    end
    object groupRemarks2: TGroupBox
      Left = 12
      Top = 163
      Width = 501
      Height = 130
      Caption = 'Remarks2'#12398#20986#21147#20869#23481
      TabOrder = 1
      object buttonShowReplaceKeywords2: TSpeedButton
        Tag = 1
        Left = 469
        Top = 45
        Width = 21
        Height = 21
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
          00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        OnClick = buttonShowReplaceKeywordsClick
      end
      object radioRemarks2Opt1: TRadioButton
        Left = 25
        Top = 49
        Width = 56
        Height = 13
        Caption = #20837#21147
        TabOrder = 1
        OnClick = radioRemarks2Opt1Click
      end
      object radioRemarks2Opt2: TRadioButton
        Left = 25
        Top = 75
        Width = 69
        Height = 13
        Caption = 'Operator'
        TabOrder = 3
        OnClick = radioRemarks2Opt2Click
      end
      object radioRemarks2Opt3: TRadioButton
        Left = 25
        Top = 101
        Width = 69
        Height = 13
        Caption = 'Memo'
        TabOrder = 4
        OnClick = radioRemarks2Opt3Click
      end
      object radioRemarks2Opt0: TRadioButton
        Left = 25
        Top = 23
        Width = 92
        Height = 13
        Caption = #20309#12418#20986#12373#12394#12356
        TabOrder = 0
        OnClick = radioRemarks2Opt3Click
      end
      object editRemarks2Opt1: TEdit
        Left = 100
        Top = 45
        Width = 366
        Height = 21
        TabOrder = 2
      end
    end
    object groupQslMark: TGroupBox
      Left = 12
      Top = 381
      Width = 170
      Height = 96
      Caption = 'QSL'#12510#12540#12463#12398#20986#21147#20869#23481
      TabOrder = 4
      object Label1: TLabel
        Left = 25
        Top = 46
        Width = 45
        Height = 13
        Caption = 'PSE QSL'
      end
      object Label2: TLabel
        Left = 25
        Top = 23
        Width = 26
        Height = 13
        Caption = #35373#23450#28961#12375'(None)'
      end
      object Label3: TLabel
        Left = 25
        Top = 69
        Width = 40
        Height = 13
        Caption = 'NO QSL'
      end
      object editQslNone: TEdit
        Left = 121
        Top = 20
        Width = 25
        Height = 21
        MaxLength = 1
        TabOrder = 0
      end
      object editPseQsl: TEdit
        Left = 121
        Top = 43
        Width = 25
        Height = 21
        MaxLength = 1
        TabOrder = 1
        Text = 'J'
      end
      object editNoQsl: TEdit
        Left = 121
        Top = 66
        Width = 25
        Height = 21
        MaxLength = 1
        TabOrder = 2
        Text = 'N'
      end
    end
    object groupCode: TGroupBox
      Left = 12
      Top = 302
      Width = 170
      Height = 71
      Caption = #30456#25163#23616#12398#36939#29992#22320#12467#12540#12489
      TabOrder = 2
      object radioCodeOpt0: TRadioButton
        Left = 25
        Top = 23
        Width = 92
        Height = 13
        Caption = #20309#12418#20986#12373#12394#12356
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = radioRemarks1Opt3Click
      end
      object radioCodeOpt1: TRadioButton
        Left = 25
        Top = 48
        Width = 92
        Height = 13
        Caption = #21463#20449#12490#12531#12496#12540
        TabOrder = 1
        OnClick = radioRemarks1Opt3Click
      end
    end
    object groupName: TGroupBox
      Left = 191
      Top = 302
      Width = 170
      Height = 71
      Caption = #30456#25163#23616#12398#21517#21069#12539#21517#31216
      TabOrder = 3
      object radioNameOpt0: TRadioButton
        Left = 25
        Top = 23
        Width = 92
        Height = 13
        Caption = #20309#12418#20986#12373#12394#12356
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = radioRemarks1Opt3Click
      end
      object radioNameOpt1: TRadioButton
        Left = 25
        Top = 48
        Width = 92
        Height = 13
        Caption = #21463#20449#12490#12531#12496#12540
        TabOrder = 1
        OnClick = radioRemarks1Opt3Click
      end
    end
    object groupTime: TGroupBox
      Left = 191
      Top = 381
      Width = 170
      Height = 96
      Caption = #20132#20449#26178#20998#12398#20986#21147#20869#23481
      TabOrder = 5
      object radioTimeOpt0: TRadioButton
        Left = 25
        Top = 23
        Width = 92
        Height = 13
        Caption = #12381#12398#12414#12414
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = radioRemarks1Opt3Click
      end
      object radioTimeOpt1: TRadioButton
        Left = 25
        Top = 46
        Width = 92
        Height = 13
        Caption = 'JST'#12395#32113#19968
        TabOrder = 1
        OnClick = radioRemarks1Opt3Click
      end
      object radioTimeOpt2: TRadioButton
        Left = 25
        Top = 69
        Width = 92
        Height = 13
        Caption = 'UTC'#12395#32113#19968
        TabOrder = 2
        OnClick = radioRemarks1Opt3Click
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 485
    Width = 530
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 483
    DesignSize = (
      530
      29)
    object buttonCancel: TButton
      Left = 268
      Top = 2
      Width = 90
      Height = 25
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 0
    end
    object buttonOK: TButton
      Left = 172
      Top = 2
      Width = 90
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 1
      OnClick = buttonOKClick
    end
  end
  object popupReplaceKeywords: TPopupMenu
    Tag = 15
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 328
    Top = 16
    object menuReplaceKeyword0: TMenuItem
      AutoHotkeys = maManual
      AutoLineReduction = maManual
      Caption = '$URCALL '#30456#25163#12467#12540#12523#12469#12452#12531
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword1: TMenuItem
      Tag = 1
      Caption = '$MYCALL '#33258#20998#12398#12467#12540#12523#12469#12452#12531
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword2: TMenuItem
      Tag = 2
      Caption = '$RSTSENT '#36865#12387#12383'RST'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword3: TMenuItem
      Tag = 3
      Caption = '$RSTRECV '#12418#12425#12387#12383'RST'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword4: TMenuItem
      Tag = 4
      Caption = '$NRSENT  '#36865#12387#12383'NR'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword5: TMenuItem
      Tag = 5
      Caption = '$NRRECV  '#12418#12425#12387#12383'NR'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword6: TMenuItem
      Tag = 6
      Caption = '$MEMO Memo'#27396#12398#20869#23481
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword7: TMenuItem
      Tag = 7
      Caption = '$CTNAME '#12467#12531#12486#12473#12488#21517
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword8: TMenuItem
      Tag = 8
      Caption = '$DATE '#20132#20449#26085#20184'(ex. yyyy/mm/dd)'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword9: TMenuItem
      Tag = 9
      Caption = '$TIME '#20132#20449#26178#21051'(ex. HH:MM)'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword10: TMenuItem
      Tag = 10
      Caption = '$FREQ '#21608#27874#25968'(ex. 71000.0)'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword11: TMenuItem
      Tag = 11
      Caption = '$BANDF '#12496#12531#12489#12434#21608#27874#25968#24418#24335'(ex. 7M)'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword12: TMenuItem
      Tag = 12
      Caption = '$BANDF '#12496#12531#12489#12434#27874#38263#24418#24335'(ex. 40m)'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword13: TMenuItem
      Tag = 13
      Caption = '$MODE '#12514#12540#12489'(ex. SSB)'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword14: TMenuItem
      Tag = 14
      Caption = '$QSL QSL'#12473#12486#12540#12479#12473#25991#23383'(ex. " JN")'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword15: TMenuItem
      Tag = 15
      Caption = '$OP   OP'#21517
      OnClick = menuReplaceKeywordClick
    end
  end
end
