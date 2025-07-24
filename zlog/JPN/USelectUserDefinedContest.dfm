object SelectUserDefinedContest: TSelectUserDefinedContest
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #12518#12540#12470#12540#23450#32681#12467#12531#12486#12473#12488#12398#36984#25246
  ClientHeight = 346
  ClientWidth = 784
  Color = clBtnFace
  Constraints.MinWidth = 800
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
    Top = 302
    Width = 784
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 740
    DesignSize = (
      784
      44)
    object buttonOK: TButton
      Left = 612
      Top = 8
      Width = 81
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      Enabled = False
      TabOrder = 0
      OnClick = buttonOKClick
      ExplicitLeft = 568
    end
    object buttonCancel: TButton
      Left = 699
      Top = 8
      Width = 81
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 655
    end
    object checkImportProvCity: TCheckBox
      Left = 10
      Top = 6
      Width = 100
      Height = 13
      Caption = 'prov,city'#21462#36796
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object checkImportCwMessage1: TCheckBox
      Left = 10
      Top = 25
      Width = 68
      Height = 13
      Caption = 'f1'#21462#36796
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object checkImportCwMessage2: TCheckBox
      Left = 92
      Top = 25
      Width = 68
      Height = 13
      Caption = 'f2'#21462#36796
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object checkImportCwMessage3: TCheckBox
      Left = 174
      Top = 25
      Width = 68
      Height = 13
      Caption = 'f3'#21462#36796
      TabOrder = 7
    end
    object checkImportCwMessage4: TCheckBox
      Left = 256
      Top = 25
      Width = 68
      Height = 13
      Caption = 'f4'#21462#36796
      TabOrder = 8
    end
    object buttonCFGEdit: TButton
      Left = 534
      Top = 8
      Width = 70
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'CFG'#32232#38598
      Enabled = False
      TabOrder = 10
      OnClick = buttonCFGEditClick
      ExplicitLeft = 490
    end
    object checkImportCQMessage2: TCheckBox
      Left = 174
      Top = 6
      Width = 80
      Height = 13
      Caption = 'CQ2'#21462#36796
      TabOrder = 3
    end
    object checkImportCQMessage3: TCheckBox
      Left = 256
      Top = 6
      Width = 80
      Height = 13
      Caption = 'CQ3'#21462#36796
      TabOrder = 4
    end
    object checkAllowTempChanges: TCheckBox
      Left = 373
      Top = 16
      Width = 156
      Height = 13
      Caption = #19968#26178#22793#26356#12434#35377#21487#12377#12427
      TabOrder = 9
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 740
    DesignSize = (
      784
      26)
    object Label1: TLabel
      Left = 224
      Top = 7
      Width = 50
      Height = 13
      Caption = 'CFG'#12501#12457#12523#12480
    end
    object editCfgFolder: TEdit
      Left = 296
      Top = 3
      Width = 427
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object buttonCfgFolderRef: TButton
      Left = 726
      Top = 2
      Width = 54
      Height = 22
      Anchors = [akTop, akRight]
      Caption = #21442#29031'...'
      TabOrder = 2
      OnClick = buttonCfgFolderRefClick
      ExplicitLeft = 682
    end
    object editFilterText: TEdit
      Left = 0
      Top = 4
      Width = 210
      Height = 20
      AutoSize = False
      TabOrder = 0
      TextHint = #26908#32034#25991#23383#21015
      OnChange = editFilterTextChange
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 26
    Width = 784
    Height = 276
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
    ExplicitWidth = 740
  end
end
