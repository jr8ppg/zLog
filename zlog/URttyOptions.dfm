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
  Font.Name = 'MS Sans Serif'
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
    ExplicitTop = 435
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
      Caption = 'Cancel'
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
    ExplicitHeight = 435
    object TabSheet1: TTabSheet
      Caption = 'Console'
      object groupDefaultColor: TGroupBox
        Left = 6
        Top = 4
        Width = 451
        Height = 57
        Caption = 'Default color'
        TabOrder = 0
        object radioNormal: TRadioButton
          Left = 12
          Top = 24
          Width = 75
          Height = 17
          Caption = 'Normal'
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
          Caption = 'Dark'
          TabOrder = 1
          OnClick = radioDarkClick
        end
        object radioGreen: TRadioButton
          Left = 174
          Top = 24
          Width = 75
          Height = 17
          Caption = 'Green'
          TabOrder = 2
          OnClick = radioGreenClick
        end
        object radioAmber: TRadioButton
          Left = 255
          Top = 24
          Width = 75
          Height = 17
          Caption = 'Amber'
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
        Caption = 'Color Coding'
        TabOrder = 1
        object Label1: TLabel
          Left = 12
          Top = 23
          Width = 41
          Height = 13
          Caption = 'Keyword'
        end
        object Label2: TLabel
          Left = 12
          Top = 50
          Width = 35
          Height = 13
          Caption = 'Sample'
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
          Caption = 'Fore...'
          TabOrder = 1
          OnClick = buttonCCFgColorClick
        end
        object checkCCBold: TCheckBox
          Tag = 1
          Left = 308
          Top = 22
          Width = 53
          Height = 17
          Caption = 'Bold'
          TabOrder = 2
          OnClick = checkCCBoldClick
        end
        object checkCCItalic: TCheckBox
          Tag = 1
          Left = 372
          Top = 22
          Width = 53
          Height = 17
          Caption = 'Italic'
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
        Caption = 'Add'
        TabOrder = 2
        OnClick = buttonCCAddClick
      end
      object buttonCCEdit: TButton
        Left = 237
        Top = 159
        Width = 73
        Height = 27
        Caption = 'Edit'
        TabOrder = 3
        OnClick = buttonCCEditClick
      end
      object groupColorCodingList: TGroupBox
        Left = 6
        Top = 192
        Width = 449
        Height = 224
        Caption = 'Color Coding List'
        TabOrder = 4
        object buttonCCDelete: TButton
          Left = 368
          Top = 21
          Width = 71
          Height = 27
          Caption = 'Delete'
          TabOrder = 1
          OnClick = buttonCCDeleteClick
        end
        object listColorCoding: TListBox
          Left = 12
          Top = 21
          Width = 350
          Height = 189
          Style = lbOwnerDrawVariable
          TabOrder = 0
          OnClick = listColorCodingClick
          OnDrawItem = listColorCodingDrawItem
        end
      end
    end
  end
  object ColorDialog1: TColorDialog
    Left = 380
    Top = 427
  end
end
