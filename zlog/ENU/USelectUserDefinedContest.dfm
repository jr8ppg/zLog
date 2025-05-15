object SelectUserDefinedContest: TSelectUserDefinedContest
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select User Defined Contest'
  ClientHeight = 346
  ClientWidth = 740
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
    Top = 313
    Width = 740
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      740
      33)
    object buttonOK: TButton
      Left = 568
      Top = 2
      Width = 81
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      Enabled = False
      TabOrder = 0
      OnClick = buttonOKClick
    end
    object buttonCancel: TButton
      Left = 655
      Top = 2
      Width = 81
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
    end
    object checkImportProvCity: TCheckBox
      Left = 4
      Top = 10
      Width = 93
      Height = 13
      Caption = 'prov,city'#21462#36796
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object checkImportCwMessage1: TCheckBox
      Left = 99
      Top = 10
      Width = 58
      Height = 13
      Caption = 'f1'#21462#36796
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object checkImportCwMessage2: TCheckBox
      Left = 159
      Top = 10
      Width = 58
      Height = 13
      Caption = 'f2'#21462#36796
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object checkImportCwMessage3: TCheckBox
      Left = 219
      Top = 10
      Width = 58
      Height = 13
      Caption = 'f3'#21462#36796
      TabOrder = 5
    end
    object checkImportCwMessage4: TCheckBox
      Left = 279
      Top = 10
      Width = 58
      Height = 13
      Caption = 'f4'#21462#36796
      TabOrder = 6
    end
    object buttonCFGEdit: TButton
      Left = 486
      Top = 2
      Width = 70
      Height = 29
      Anchors = [akLeft, akBottom]
      Caption = 'CFG'#32232#38598
      Enabled = False
      TabOrder = 9
      OnClick = buttonCFGEditClick
    end
    object checkImportCQMessage2: TCheckBox
      Left = 339
      Top = 10
      Width = 66
      Height = 13
      Caption = 'CQ2'#21462#36796
      TabOrder = 7
    end
    object checkImportCQMessage3: TCheckBox
      Left = 409
      Top = 10
      Width = 66
      Height = 13
      Caption = 'CQ3'#21462#36796
      TabOrder = 8
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 740
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      740
      26)
    object Label1: TLabel
      Left = 224
      Top = 7
      Width = 66
      Height = 12
      Caption = 'CFG'#12501#12457#12523#12480
    end
    object editCfgFolder: TEdit
      Left = 296
      Top = 3
      Width = 381
      Height = 20
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object buttonCfgFolderRef: TButton
      Left = 683
      Top = 2
      Width = 49
      Height = 22
      Anchors = [akTop, akRight]
      Caption = #21442#29031'...'
      TabOrder = 2
      OnClick = buttonCfgFolderRefClick
    end
    object editFilterText: TEdit
      Left = 0
      Top = 4
      Width = 210
      Height = 20
      AutoSize = False
      TabOrder = 0
      TextHint = 'Search text'
      OnChange = editFilterTextChange
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 26
    Width = 740
    Height = 287
    Align = alClient
    Columns = <
      item
        Caption = #12501#12449#12452#12523#21517
        Width = 100
      end
      item
        Caption = #12467#12531#12486#12473#12488#21517
        Width = 180
      end
      item
        Caption = 'prov'
      end
      item
        Caption = 'city'
      end
      item
        Caption = 'f1_a'
        Width = 80
      end
      item
        Caption = 'f2_a'
        Width = 80
      end
      item
        Caption = 'f3_a'
        Width = 80
      end
      item
        Caption = 'f4_a'
        Width = 80
      end
      item
        Caption = 'CQ2'
        Width = 80
      end
      item
        Caption = 'CQ3'
        Width = 80
      end>
    DoubleBuffered = True
    GridLines = True
    ReadOnly = True
    RowSelect = True
    ParentDoubleBuffered = False
    TabOrder = 2
    ViewStyle = vsReport
    OnDblClick = ListView1DblClick
    OnMouseEnter = ListView1MouseEnter
    OnSelectItem = ListView1SelectItem
  end
end
