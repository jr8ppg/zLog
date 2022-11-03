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
    Width = 372
    Height = 485
    Align = alClient
    Caption = 'Output settings for HAMLOG'
    TabOrder = 0
    object groupRemarks1: TGroupBox
      Left = 12
      Top = 24
      Width = 349
      Height = 130
      Caption = 'Output for Remarks1'
      TabOrder = 0
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
        Width = 241
        Height = 21
        TabOrder = 2
      end
    end
    object groupRemarks2: TGroupBox
      Left = 12
      Top = 163
      Width = 349
      Height = 130
      Caption = 'Output for Remarks2'
      TabOrder = 1
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
        Width = 241
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
      Caption = #12461#12515#12531#12475#12523
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
      OnClick = buttonOKClick
    end
  end
end
