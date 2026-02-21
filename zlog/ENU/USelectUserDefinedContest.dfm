object SelectUserDefinedContest: TSelectUserDefinedContest
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select User Defined Contest'
  ClientHeight = 346
  ClientWidth = 784
  Color = clBtnFace
  Constraints.MinWidth = 800
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
    Top = 302
    Width = 784
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
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
    end
    object buttonCancel: TButton
      Left = 699
      Top = 8
      Width = 81
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object buttonCFGEdit: TButton
      Left = 534
      Top = 8
      Width = 70
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Edit CFG'
      Enabled = False
      TabOrder = 2
      Visible = False
      OnClick = buttonCFGEditClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      784
      26)
    object Label1: TLabel
      Left = 224
      Top = 7
      Width = 50
      Height = 13
      Caption = 'CFG folder'
    end
    object editCfgFolder: TEdit
      Left = 296
      Top = 3
      Width = 427
      Height = 21
      TabStop = False
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
      Caption = 'Browse...'
      TabOrder = 2
      TabStop = False
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
    Width = 784
    Height = 276
    Align = alClient
    Columns = <
      item
        Caption = 'File name'
        Width = 100
      end
      item
        Caption = 'Contest name'
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
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = ListView1DblClick
    OnMouseEnter = ListView1MouseEnter
    OnSelectItem = ListView1SelectItem
  end
end
