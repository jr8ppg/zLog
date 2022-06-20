object formExportHamlog: TformExportHamlog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Export'
  ClientHeight = 514
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 372
    Height = 485
    Align = alClient
    Caption = 'HAMLOG'#20986#21147#35373#23450
    TabOrder = 0
    object groupRemarks1: TGroupBox
      Left = 12
      Top = 24
      Width = 349
      Height = 130
      Caption = 'Remarks1'#12398#20986#21147#20869#23481
      TabOrder = 0
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
        Checked = True
        TabOrder = 3
        TabStop = True
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
      object editRemarks1Opt1: TMemo
        Left = 100
        Top = 45
        Width = 241
        Height = 20
        TabOrder = 2
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
    end
    object groupRemarks2: TGroupBox
      Left = 12
      Top = 163
      Width = 349
      Height = 130
      Caption = 'Remarks2'#12398#20986#21147#20869#23481
      TabOrder = 1
      object editRemarks2Opt1: TMemo
        Left = 96
        Top = 46
        Width = 241
        Height = 20
        TabOrder = 2
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
        Checked = True
        TabOrder = 4
        TabStop = True
        OnClick = radioRemarks2Opt3Click
      end
      object radioRemarks2Opt0: TRadioButton
        Left = 25
        Top = 23
        Width = 92
        Height = 13
        Caption = #20309#12418#20986#12373#12394#12356
        TabOrder = 0
        OnClick = radioRemarks1Opt3Click
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
        Top = 45
        Width = 46
        Height = 12
        Caption = 'PSE QSL'
      end
      object Label2: TLabel
        Left = 25
        Top = 22
        Width = 79
        Height = 12
        Caption = #35373#23450#28961#12375'(None)'
      end
      object Label3: TLabel
        Left = 25
        Top = 68
        Width = 41
        Height = 12
        Caption = 'NO QSL'
      end
      object editQslNone: TEdit
        Left = 121
        Top = 19
        Width = 25
        Height = 20
        MaxLength = 1
        TabOrder = 0
      end
      object editPseQsl: TEdit
        Left = 121
        Top = 42
        Width = 25
        Height = 20
        MaxLength = 1
        TabOrder = 1
        Text = 'J'
      end
      object editNoQsl: TEdit
        Left = 121
        Top = 65
        Width = 25
        Height = 20
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
        Top = 19
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
        Top = 44
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
        Top = 19
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
        Top = 44
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
        Top = 19
        Width = 92
        Height = 13
        Caption = #12381#12398#12414#12414#20986#21147
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = radioRemarks1Opt3Click
      end
      object radioTimeOpt1: TRadioButton
        Left = 25
        Top = 42
        Width = 92
        Height = 13
        Caption = 'JST'#12395#32113#19968
        TabOrder = 1
        OnClick = radioRemarks1Opt3Click
      end
      object radioTimeOpt2: TRadioButton
        Left = 25
        Top = 65
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
    Width = 372
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      372
      29)
    object buttonCancel: TButton
      Left = 189
      Top = 1
      Width = 90
      Height = 25
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object buttonOK: TButton
      Left = 93
      Top = 1
      Width = 90
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 1
    end
  end
end
