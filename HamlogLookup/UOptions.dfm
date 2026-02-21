object formOptions: TformOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #12458#12503#12471#12519#12531
  ClientHeight = 231
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 197
    Width = 529
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 180
    DesignSize = (
      529
      34)
    object buttonOK: TButton
      Left = 369
      Top = 4
      Width = 73
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object buttonCancel: TButton
      Left = 448
      Top = 4
      Width = 73
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 513
    Height = 57
    Caption = 'HAMLOG'#12487#12540#12479#12505#12540#12473
    TabOrder = 0
    object editHamlogDatabase: TEdit
      Left = 16
      Top = 24
      Width = 433
      Height = 20
      TabOrder = 0
    end
    object buttonHamlogRef: TButton
      Left = 455
      Top = 22
      Width = 41
      Height = 25
      Caption = #21442#29031
      TabOrder = 1
      OnClick = buttonHamlogRefClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 71
    Width = 513
    Height = 118
    Caption = #35373#23450
    TabOrder = 2
    object Label1: TLabel
      Left = 24
      Top = 28
      Width = 70
      Height = 12
      Caption = #34920#31034#12377#12427#20214#25968
    end
    object Label2: TLabel
      Left = 171
      Top = 28
      Width = 12
      Height = 12
      Caption = #20214
    end
    object Label3: TLabel
      Left = 24
      Top = 55
      Width = 48
      Height = 12
      Caption = #23550#35937#26399#38291
    end
    object Label4: TLabel
      Left = 171
      Top = 55
      Width = 12
      Height = 12
      Caption = #24180
    end
    object Label5: TLabel
      Left = 86
      Top = 55
      Width = 24
      Height = 12
      Caption = #36942#21435
    end
    object spinMaxCount: TSpinEdit
      Left = 116
      Top = 25
      Width = 49
      Height = 21
      MaxLength = 2
      MaxValue = 99
      MinValue = 1
      TabOrder = 0
      Value = 1
    end
    object checkIncremental: TCheckBox
      Left = 24
      Top = 84
      Width = 177
      Height = 17
      Caption = #12452#12531#12463#12522#12513#12531#12479#12523#12469#12540#12481
      TabOrder = 2
    end
    object spinPastYears: TSpinEdit
      Left = 116
      Top = 52
      Width = 49
      Height = 21
      MaxLength = 2
      MaxValue = 99
      MinValue = 1
      TabOrder = 1
      Value = 3
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'HAMLOG'#12487#12540#12479#12505#12540#12473'|*.hdb|'#20840#12390#12398#12501#12449#12452#12523'|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 292
    Top = 4
  end
end
