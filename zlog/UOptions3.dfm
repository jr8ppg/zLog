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
  Font.Name = 'MS Sans Serif'
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
    ActivePage = tabsheetWindowStyle
    Align = alClient
    TabOrder = 0
    object tabsheetRbnOptions: TTabSheet
      Caption = 'RBN'
      ImageIndex = 11
      object groupQsoListColors: TGroupBox
        Left = 6
        Top = 91
        Width = 423
        Height = 86
        Caption = 'QSO list'
        TabOrder = 1
        object Label61: TLabel
          Left = 8
          Top = 23
          Width = 33
          Height = 13
          Caption = 'Normal'
        end
        object Label68: TLabel
          Left = 8
          Top = 50
          Width = 61
          Height = 13
          Caption = 'RBN Verified'
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
          Caption = 'Back...'
          TabOrder = 2
          OnClick = buttonListBackClick
        end
        object buttonListReset1: TButton
          Tag = 1
          Left = 368
          Top = 21
          Width = 45
          Height = 20
          Caption = 'Reset'
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
          Caption = 'Back...'
          TabOrder = 7
          OnClick = buttonListBackClick
        end
        object buttonListReset2: TButton
          Tag = 2
          Left = 368
          Top = 48
          Width = 45
          Height = 20
          Caption = 'Reset'
          TabOrder = 9
          OnClick = buttonListResetClick
        end
        object buttonListFore1: TButton
          Tag = 1
          Left = 221
          Top = 21
          Width = 45
          Height = 20
          Caption = 'Fore...'
          TabOrder = 1
          OnClick = buttonListForeClick
        end
        object checkListBold1: TCheckBox
          Tag = 1
          Left = 321
          Top = 22
          Width = 41
          Height = 17
          Caption = 'Bold'
          TabOrder = 3
          OnClick = checkListBoldClick
        end
        object buttonListFore2: TButton
          Tag = 2
          Left = 221
          Top = 48
          Width = 45
          Height = 20
          Caption = 'Fore...'
          TabOrder = 6
          OnClick = buttonListForeClick
        end
        object checkListBold2: TCheckBox
          Tag = 2
          Left = 321
          Top = 49
          Width = 41
          Height = 17
          Caption = 'Bold'
          TabOrder = 8
          OnClick = checkListBoldClick
        end
      end
      object groupGeneral: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 81
        Caption = 'General'
        TabOrder = 0
        object Label1: TLabel
          Left = 11
          Top = 52
          Width = 217
          Height = 13
          Caption = 'RBN spot count threshold for RBN verification'
        end
        object Label2: TLabel
          Left = 287
          Top = 52
          Width = 24
          Height = 13
          Caption = 'times'
        end
        object checkUseSpcData: TCheckBox
          Left = 11
          Top = 22
          Width = 217
          Height = 17
          Caption = 'Use Spot to SuperCheck'
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
      Caption = 'Usability'
      ImageIndex = 1
      object groupUsabilityGeneral: TGroupBox
        Left = 6
        Top = 4
        Width = 423
        Height = 53
        Caption = 'General'
        TabOrder = 0
        object checkUseMultiLineTabs: TCheckBox
          Left = 11
          Top = 22
          Width = 217
          Height = 17
          Caption = 'Use Multiline Tabs'
          TabOrder = 0
        end
      end
      object groupUsabilityAfterQsoEdit: TGroupBox
        Left = 6
        Top = 63
        Width = 423
        Height = 94
        Caption = 'Focus Position After QSO Edit'
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
            Caption = 'On OK Click'
          end
          object radioOnOkFocusToQsoList: TRadioButton
            Left = 107
            Top = 5
            Width = 73
            Height = 17
            Caption = 'QSO List'
            TabOrder = 0
          end
          object radioOnOkFocusToNewQso: TRadioButton
            Left = 195
            Top = 5
            Width = 73
            Height = 17
            Caption = 'New QSO'
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
            Caption = 'On Cancel Click'
          end
          object radioOnCancelFocusToQsoList: TRadioButton
            Left = 107
            Top = 5
            Width = 73
            Height = 17
            Caption = 'QSO List'
            TabOrder = 0
          end
          object radioOnCancelFocusToNewQso: TRadioButton
            Left = 195
            Top = 5
            Width = 73
            Height = 17
            Caption = 'New QSO'
            TabOrder = 1
          end
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
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = buttonCancelClick
    end
  end
  object ColorDialog1: TColorDialog
    Left = 292
    Top = 428
  end
end
