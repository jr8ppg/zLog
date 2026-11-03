object formRttyOptions: TformRttyOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'RTTY Options'
  ClientHeight = 489
  ClientWidth = 471
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
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 452
    Width = 471
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      471
      37)
    object buttonOK: TButton
      Left = 158
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object buttonCancel: TButton
      Left = 239
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 471
    Height = 452
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #12467#12531#12477#12540#12523
      object groupDefaultColor: TGroupBox
        Left = 6
        Top = 4
        Width = 451
        Height = 57
        Caption = #22522#26412#12398#33394
        TabOrder = 0
        object radioNormal: TRadioButton
          Left = 12
          Top = 24
          Width = 75
          Height = 17
          Caption = #12494#12540#12510#12523
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = radioNormalClick
        end
        object radioDark: TRadioButton
          Left = 93
          Top = 24
          Width = 75
          Height = 17
          Caption = #12480#12540#12463
          TabOrder = 1
          OnClick = radioDarkClick
        end
        object radioGreen: TRadioButton
          Left = 174
          Top = 24
          Width = 75
          Height = 17
          Caption = #12464#12522#12540#12531
          TabOrder = 2
          OnClick = radioGreenClick
        end
        object radioAmber: TRadioButton
          Left = 255
          Top = 24
          Width = 75
          Height = 17
          Caption = #12458#12524#12531#12472
          TabOrder = 3
          OnClick = radioAmberClick
        end
        object editConsoleSample: TEdit
          Left = 347
          Top = 22
          Width = 92
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 4
          Text = 'SAMPLE TEXT'
        end
      end
      object groupColorCoding: TGroupBox
        Left = 6
        Top = 67
        Width = 451
        Height = 78
        Caption = #33394#20998#12369#35373#23450
        TabOrder = 1
        object Label1: TLabel
          Left = 12
          Top = 23
          Width = 41
          Height = 13
          Caption = #12461#12540#12527#12540#12489
        end
        object Label2: TLabel
          Left = 12
          Top = 50
          Width = 35
          Height = 13
          Caption = #12469#12531#12503#12523#34920#31034
        end
        object editCCSample: TEdit
          Left = 95
          Top = 47
          Width = 128
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 4
          Text = 'SAMPLE TEXT'
        end
        object buttonCCFgColor: TButton
          Left = 230
          Top = 21
          Width = 61
          Height = 20
          Caption = #25991#23383#33394
          TabOrder = 1
          OnClick = buttonCCFgColorClick
        end
        object checkCCBold: TCheckBox
          Tag = 1
          Left = 308
          Top = 22
          Width = 53
          Height = 17
          Caption = #22826#23383
          TabOrder = 2
          OnClick = checkCCBoldClick
        end
        object checkCCItalic: TCheckBox
          Tag = 1
          Left = 372
          Top = 22
          Width = 53
          Height = 17
          Caption = #26012#20307
          TabOrder = 3
          OnClick = checkCCItalicClick
        end
        object editCCKeyword: TEdit
          Left = 95
          Top = 20
          Width = 128
          Height = 21
          TabOrder = 0
          OnChange = editCCKeywordChange
        end
      end
      object buttonCCAdd: TButton
        Left = 154
        Top = 159
        Width = 73
        Height = 27
        Caption = #36861#21152
        TabOrder = 2
        OnClick = buttonCCAddClick
      end
      object buttonCCEdit: TButton
        Left = 237
        Top = 159
        Width = 73
        Height = 27
        Caption = #20462#27491
        TabOrder = 3
        OnClick = buttonCCEditClick
      end
      object groupColorCodingList: TGroupBox
        Left = 6
        Top = 192
        Width = 449
        Height = 157
        Caption = #33394#20998#12369#35373#23450#12522#12473#12488
        TabOrder = 4
        object buttonCCDelete: TButton
          Left = 368
          Top = 21
          Width = 71
          Height = 27
          Caption = #21066#38500
          TabOrder = 1
          OnClick = buttonCCDeleteClick
        end
        object listColorCoding: TListBox
          Left = 12
          Top = 21
          Width = 350
          Height = 124
          Style = lbOwnerDrawVariable
          TabOrder = 0
          OnClick = listColorCodingClick
          OnDrawItem = listColorCodingDrawItem
        end
      end
      object groupCallsignExtraction: TGroupBox
        Left = 6
        Top = 360
        Width = 449
        Height = 57
        Caption = #12467#12540#12523#12469#12452#12531#25277#20986
        TabOrder = 5
        object Label3: TLabel
          Left = 12
          Top = 28
          Width = 22
          Height = 13
          Caption = #12501#12451#12523#12479#12540
        end
        object editFilter: TEdit
          Left = 70
          Top = 25
          Width = 369
          Height = 21
          TabOrder = 0
        end
      end
    end
  end
  object ColorDialog1: TColorDialog
    Left = 380
    Top = 427
  end
end
