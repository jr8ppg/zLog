object formSpotterListDlg: TformSpotterListDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Spotter List'
  ClientHeight = 379
  ClientWidth = 472
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
    Top = 344
    Width = 472
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 343
    ExplicitWidth = 468
    DesignSize = (
      472
      35)
    object buttonOK: TButton
      Left = 163
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = buttonOKClick
      ExplicitLeft = 159
    end
    object buttonCancel: TButton
      Left = 244
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 240
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 472
    Height = 344
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 468
    ExplicitHeight = 343
    object Label1: TLabel
      Left = 340
      Top = 8
      Width = 88
      Height = 13
      Caption = 'Allow list1 (reliable)'
    end
    object Label2: TLabel
      Left = 340
      Top = 231
      Width = 40
      Height = 13
      Caption = 'Deny list'
    end
    object Label3: TLabel
      Left = 12
      Top = 8
      Width = 34
      Height = 13
      Caption = 'Spotter'
    end
    object Label4: TLabel
      Left = 340
      Top = 120
      Width = 103
      Height = 13
      Caption = 'Allow list 2 (unreliable)'
    end
    object listAllow1: TListBox
      Left = 340
      Top = 23
      Width = 120
      Height = 90
      ItemHeight = 13
      Sorted = True
      TabOrder = 3
      OnClick = listAllow1Click
      OnDblClick = listAllow1DblClick
    end
    object listDeny: TListBox
      Left = 340
      Top = 245
      Width = 120
      Height = 90
      ItemHeight = 13
      Sorted = True
      TabOrder = 9
      OnClick = listDenyClick
      OnDblClick = listDenyDblClick
    end
    object buttonAddToAllowList: TButton
      Left = 172
      Top = 36
      Width = 133
      Height = 21
      Caption = 'Add to allow list1'
      TabOrder = 1
      OnClick = buttonAddToAllowListClick
    end
    object buttonRemoveFromAllowList: TButton
      Left = 172
      Top = 68
      Width = 133
      Height = 21
      Caption = 'Remove from allow list1'
      TabOrder = 2
      OnClick = buttonRemoveFromAllowListClick
    end
    object comboSpotter: TComboBox
      Left = 12
      Top = 23
      Width = 120
      Height = 315
      Style = csSimple
      CharCase = ecUpperCase
      Sorted = True
      TabOrder = 0
      OnChange = comboSpotterChange
      OnDblClick = comboSpotterDblClick
    end
    object buttonAddToDenyList: TButton
      Left = 172
      Top = 254
      Width = 133
      Height = 21
      Caption = 'Add to deny list'
      TabOrder = 7
      OnClick = buttonAddToDenyListClick
    end
    object buttonRemoveFromDenyList: TButton
      Left = 172
      Top = 286
      Width = 133
      Height = 21
      Caption = 'Remove from deny list'
      TabOrder = 8
      OnClick = buttonRemoveFromDenyListClick
    end
    object listAllow2: TListBox
      Left = 340
      Top = 135
      Width = 120
      Height = 90
      ItemHeight = 13
      Sorted = True
      TabOrder = 6
      OnClick = listAllow2Click
      OnDblClick = listAllow2DblClick
    end
    object buttonAddToAllowList2: TButton
      Left = 172
      Top = 144
      Width = 133
      Height = 21
      Caption = 'Add to allow list2'
      TabOrder = 4
      OnClick = buttonAddToAllowList2Click
    end
    object buttonRemoveFromAllowList2: TButton
      Left = 172
      Top = 176
      Width = 133
      Height = 21
      Caption = 'Remove from allow list2'
      TabOrder = 5
      OnClick = buttonRemoveFromAllowList2Click
    end
  end
end
