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
  Font.Name = 'MS Sans Serif'
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
    Caption = 'Output settings for HAMLOG'
    TabOrder = 0
    object groupRemarks1: TGroupBox
      Left = 12
      Top = 24
      Width = 501
      Height = 130
      Caption = 'Output for Remarks1'
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
        Caption = 'Input'
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
        Caption = 'Nothing'
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
      Caption = 'Output for Remarks2'
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
        Caption = 'Input'
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
        Caption = 'Nothing'
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
      Caption = 'Output for Mark of QSL'
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
        Caption = 'None'
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
      Caption = 'Operation Place of UR'
      TabOrder = 2
      object radioCodeOpt0: TRadioButton
        Left = 25
        Top = 23
        Width = 92
        Height = 13
        Caption = 'Nothing'
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
        Caption = 'Received NR'
        TabOrder = 1
        OnClick = radioRemarks1Opt3Click
      end
    end
    object groupName: TGroupBox
      Left = 191
      Top = 302
      Width = 170
      Height = 71
      Caption = 'Name of UR'
      TabOrder = 3
      object radioNameOpt0: TRadioButton
        Left = 25
        Top = 23
        Width = 92
        Height = 13
        Caption = 'Nothing'
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
        Caption = 'Received NR'
        TabOrder = 1
        OnClick = radioRemarks1Opt3Click
      end
    end
    object groupTime: TGroupBox
      Left = 191
      Top = 381
      Width = 170
      Height = 96
      Caption = 'Output for QSO time'
      TabOrder = 5
      object radioTimeOpt0: TRadioButton
        Left = 25
        Top = 23
        Width = 92
        Height = 13
        Caption = 'Don'#39't care'
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
        Caption = 'Change to JST'
        TabOrder = 1
        OnClick = radioRemarks1Opt3Click
      end
      object radioTimeOpt2: TRadioButton
        Left = 25
        Top = 69
        Width = 92
        Height = 13
        Caption = 'Change to UTC'
        TabOrder = 2
        OnClick = radioRemarks1Opt3Click
      end
    end
    object checkInquireJarlMemberInfo: TCheckBox
      Left = 376
      Top = 448
      Width = 151
      Height = 17
      Caption = 'Inquire JARL member info.'
      TabOrder = 6
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
      Caption = 'Cancel'
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
      Caption = '$URCALL  Ur callsign'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword1: TMenuItem
      Tag = 1
      Caption = '$MYCALL  My callsign'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword2: TMenuItem
      Tag = 2
      Caption = '$RSTSENT Sent RST'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword3: TMenuItem
      Tag = 3
      Caption = '$RSTRECV Recieved RST'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword4: TMenuItem
      Tag = 4
      Caption = '$NRSENT  Sent NR'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword5: TMenuItem
      Tag = 5
      Caption = '$NRRECV  Recieved NR'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword6: TMenuItem
      Tag = 6
      Caption = '$MEMO    Contents of Memo'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword7: TMenuItem
      Tag = 7
      Caption = '$CTNAME  Contest name'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword8: TMenuItem
      Tag = 8
      Caption = '$DATE    QSO date(ex. yyyy/mm/dd)'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword9: TMenuItem
      Tag = 9
      Caption = '$TIME    QSO time(ex. HH:MM)'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword10: TMenuItem
      Tag = 10
      Caption = '$FREQ    Frequency(ex. 71000.0)'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword11: TMenuItem
      Tag = 11
      Caption = '$BANDF   Band by frequency(ex. 7M)'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword12: TMenuItem
      Tag = 12
      Caption = '$BANDW   Band by wavelength(ex. 40m)'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword13: TMenuItem
      Tag = 13
      Caption = '$MODE    Mode(ex. SSB)'
      OnClick = menuReplaceKeywordClick
    end
    object menuReplaceKeyword15: TMenuItem
      Tag = 15
      Caption = '$OP      Operator name'
      OnClick = menuReplaceKeywordClick
    end
  end
end
