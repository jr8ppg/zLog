object formOptions3: TformOptions3
  Left = 532
  Top = 236
  BorderStyle = bsDialog
  Caption = 'Labs options'
  ClientHeight = 471
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 444
    Height = 434
    ActivePage = tabsheetRbnOptions
    Align = alClient
    TabOrder = 0
    object tabsheetRbnOptions: TTabSheet
      Caption = 'RBN'
      ImageIndex = 11
      object groupQsoListColors: TGroupBox
        Left = 6
        Top = 91
        Width = 423
        Height = 134
        Caption = #20132#20449#12522#12473#12488
        TabOrder = 1
        object Label61: TLabel
          Left = 8
          Top = 23
          Width = 33
          Height = 13
          Caption = #36890#24120#34920#31034
        end
        object Label68: TLabel
          Left = 8
          Top = 50
          Width = 61
          Height = 13
          Caption = 'RBN Verified'#34920#31034
        end
        object Label5: TLabel
          Left = 8
          Top = 77
          Width = 94
          Height = 13
          Caption = #36984#25246#33394'('#12501#12457#12540#12459#12473#26377')'
        end
        object Label6: TLabel
          Left = 8
          Top = 104
          Width = 91
          Height = 13
          Caption = #36984#25246#33394'('#12501#12457#12540#12459#12473#28961')'
        end
        object editListColor1: TEdit
          Left = 118
          Top = 20
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'TEXT'
        end
        object buttonListBack1: TButton
          Tag = 1
          Left = 270
          Top = 21
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 2
          OnClick = buttonListBackClick
        end
        object buttonListReset1: TButton
          Tag = 1
          Left = 368
          Top = 21
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 4
          OnClick = buttonListResetClick
        end
        object editListColor2: TEdit
          Left = 118
          Top = 47
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 5
          Text = 'TEXT'
        end
        object buttonListBack2: TButton
          Tag = 2
          Left = 270
          Top = 48
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 7
          OnClick = buttonListBackClick
        end
        object buttonListReset2: TButton
          Tag = 2
          Left = 368
          Top = 48
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 9
          OnClick = buttonListResetClick
        end
        object buttonListFore1: TButton
          Tag = 1
          Left = 221
          Top = 21
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 1
          OnClick = buttonListForeClick
        end
        object checkListBold1: TCheckBox
          Tag = 1
          Left = 321
          Top = 22
          Width = 41
          Height = 17
          Caption = #22826#23383
          TabOrder = 3
          OnClick = checkListBoldClick
        end
        object buttonListFore2: TButton
          Tag = 2
          Left = 221
          Top = 48
          Width = 45
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 6
          OnClick = buttonListForeClick
        end
        object checkListBold2: TCheckBox
          Tag = 2
          Left = 321
          Top = 49
          Width = 41
          Height = 17
          Caption = #22826#23383
          TabOrder = 8
          OnClick = checkListBoldClick
        end
        object editListColor3: TEdit
          Left = 118
          Top = 74
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 10
          Text = 'TEXT'
        end
        object buttonListBack3: TButton
          Tag = 3
          Left = 270
          Top = 75
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 11
          OnClick = buttonListBackClick
        end
        object buttonListReset3: TButton
          Tag = 3
          Left = 368
          Top = 75
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 12
          OnClick = buttonListResetClick
        end
        object editListColor4: TEdit
          Left = 118
          Top = 101
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 13
          Text = 'TEXT'
        end
        object buttonListBack4: TButton
          Tag = 4
          Left = 270
          Top = 102
          Width = 45
          Height = 20
          Caption = #32972#26223#33394
          TabOrder = 14
          OnClick = buttonListBackClick
        end
        object buttonListReset4: TButton
          Tag = 4
          Left = 368
          Top = 102
          Width = 45
          Height = 20
          Caption = #12522#12475#12483#12488
          TabOrder = 15
          OnClick = buttonListResetClick
        end
      end
      object groupGeneral: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 81
        Caption = #20840#33324
        TabOrder = 0
        object Label1: TLabel
          Left = 11
          Top = 52
          Width = 217
          Height = 13
          Caption = 'RBN Verified'#12392#12377#12427'RBN'#22577#21578#22238#25968
        end
        object Label2: TLabel
          Left = 287
          Top = 52
          Width = 24
          Height = 13
          Caption = #22238#20197#19978
        end
        object checkUseSpcData: TCheckBox
          Left = 11
          Top = 22
          Width = 250
          Height = 17
          Caption = #12473#12509#12483#12488#24773#22577#12434#12473#12540#12497#12540#12481#12455#12483#12463#12395#20351#29992#12377#12427
          TabOrder = 0
        end
        object spNumOfRbnCount: TSpinEdit
          Left = 245
          Top = 49
          Width = 36
          Height = 22
          MaxValue = 9
          MinValue = 1
          TabOrder = 1
          Value = 1
        end
      end
    end
    object tabsheetWindowStyle: TTabSheet
      Caption = #25805#20316#24615
      ImageIndex = 1
      object groupUsabilityGeneral: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 53
        Caption = #20840#33324
        TabOrder = 0
        object checkUseMultiLineTabs: TCheckBox
          Left = 11
          Top = 22
          Width = 217
          Height = 17
          Caption = #12479#12502#12434#35079#25968#34892#34920#31034#12377#12427
          TabOrder = 0
        end
      end
      object groupUsabilityAfterQsoEdit: TGroupBox
        Left = 6
        Top = 63
        Width = 423
        Height = 94
        Caption = 'QSOEdit'#24460#12398#12501#12457#12540#12459#12473#20301#32622
        TabOrder = 1
        object Panel2: TPanel
          Left = 11
          Top = 24
          Width = 302
          Height = 25
          BevelOuter = bvNone
          TabOrder = 0
          object Label3: TLabel
            Left = 9
            Top = 6
            Width = 58
            Height = 13
            Caption = 'OK'#12463#12522#12483#12463#24460
          end
          object radioOnOkFocusToQsoList: TRadioButton
            Left = 137
            Top = 5
            Width = 73
            Height = 17
            Caption = #20132#20449#12522#12473#12488
            TabOrder = 0
          end
          object radioOnOkFocusToNewQso: TRadioButton
            Left = 225
            Top = 5
            Width = 73
            Height = 17
            Caption = #27425#12398'QSO'
            TabOrder = 1
          end
        end
        object Panel3: TPanel
          Left = 11
          Top = 55
          Width = 302
          Height = 25
          BevelOuter = bvNone
          TabOrder = 1
          object Label4: TLabel
            Left = 9
            Top = 6
            Width = 76
            Height = 13
            Caption = #12461#12515#12531#12475#12523#12463#12522#12483#12463#24460
          end
          object radioOnCancelFocusToQsoList: TRadioButton
            Left = 137
            Top = 5
            Width = 73
            Height = 17
            Caption = #20132#20449#12522#12473#12488
            TabOrder = 0
          end
          object radioOnCancelFocusToNewQso: TRadioButton
            Left = 225
            Top = 5
            Width = 73
            Height = 17
            Caption = #27425#12398'QSO'
            TabOrder = 1
          end
        end
      end
    end
    object tabsheetBandScope3: TTabSheet
      Caption = 'BandScope3'
      ImageIndex = 2
      object groupBandscopeSpotReliability: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 108
        Caption = 'Spot Reliability'
        TabOrder = 0
        object Label28: TLabel
          Left = 8
          Top = 23
          Width = 22
          Height = 13
          Caption = 'High'
        end
        object Label29: TLabel
          Left = 8
          Top = 50
          Width = 31
          Height = 13
          Caption = 'Middle'
        end
        object Label30: TLabel
          Left = 8
          Top = 77
          Width = 20
          Height = 13
          Caption = 'Low'
        end
        object editBSColorSrHigh: TEdit
          Tag = 13
          Left = 118
          Top = 20
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 0
          Text = 'TEXT'
        end
        object editBSColorSrMiddle: TEdit
          Tag = 14
          Left = 118
          Top = 47
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 3
          Text = 'TEXT'
        end
        object editBSColorSrLow: TEdit
          Tag = 15
          Left = 118
          Top = 74
          Width = 100
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 6
          Text = 'TEXT'
        end
        object buttonBSBackSrHigh: TButton
          Tag = 13
          Left = 270
          Top = 21
          Width = 45
          Height = 20
          Caption = 'Back...'
          TabOrder = 1
          OnClick = buttonBSBackSqClick
        end
        object buttonBSBackSrMiddle: TButton
          Tag = 14
          Left = 270
          Top = 48
          Width = 45
          Height = 20
          Caption = 'Back...'
          TabOrder = 4
          OnClick = buttonBSBackSqClick
        end
        object buttonBSBackSrLow: TButton
          Tag = 15
          Left = 270
          Top = 75
          Width = 45
          Height = 20
          Caption = 'Back...'
          TabOrder = 7
          OnClick = buttonBSBackSqClick
        end
        object buttonBSResetSrHigh: TButton
          Tag = 13
          Left = 368
          Top = 21
          Width = 45
          Height = 20
          Caption = 'Reset'
          TabOrder = 2
          OnClick = buttonBSResetClick
        end
        object buttonBSResetSrMiddle: TButton
          Tag = 14
          Left = 368
          Top = 48
          Width = 45
          Height = 20
          Caption = 'Reset'
          TabOrder = 5
          OnClick = buttonBSResetClick
        end
        object buttonBSResetSrLow: TButton
          Tag = 15
          Left = 368
          Top = 75
          Width = 45
          Height = 20
          Caption = 'Reset'
          TabOrder = 8
          OnClick = buttonBSResetClick
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 434
    Width = 444
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      444
      37)
    object buttonOK: TButton
      Left = 149
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = buttonOKClick
    end
    object buttonCancel: TButton
      Left = 229
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
      OnClick = buttonCancelClick
    end
  end
  object ColorDialog1: TColorDialog
    Left = 292
    Top = 428
  end
  object ColorDialog2: TColorDialog
    Left = 300
    Top = 436
  end
end
