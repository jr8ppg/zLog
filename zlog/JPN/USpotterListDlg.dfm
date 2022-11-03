object formSpotterListDlg: TformSpotterListDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Spotter List'
  ClientHeight = 323
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 288
    Width = 472
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      472
      35)
    object buttonOK: TButton
      Left = 158
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = buttonOKClick
    end
    object buttonCancel: TButton
      Left = 239
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 472
    Height = 288
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 340
      Top = 8
      Width = 40
      Height = 13
      Caption = #21463#20837#35377#21487#12522#12473#12488
    end
    object Label2: TLabel
      Left = 340
      Top = 153
      Width = 40
      Height = 13
      Caption = #21463#20837#25298#21542#12522#12473#12488
    end
    object Label3: TLabel
      Left = 12
      Top = 8
      Width = 34
      Height = 13
      Caption = #12473#12509#12483#12479#12540
    end
    object listAllow: TListBox
      Left = 340
      Top = 23
      Width = 120
      Height = 105
      ItemHeight = 13
      Sorted = True
      TabOrder = 3
      OnClick = listAllowClick
      OnDblClick = listAllowDblClick
    end
    object listDeny: TListBox
      Left = 340
      Top = 171
      Width = 120
      Height = 105
      ItemHeight = 13
      Sorted = True
      TabOrder = 6
      OnClick = listDenyClick
      OnDblClick = listDenyDblClick
    end
    object buttonAddToAllowList: TButton
      Left = 172
      Top = 52
      Width = 133
      Height = 21
      Caption = #35377#21487#12522#12473#12488#12408#36861#21152
      TabOrder = 1
      OnClick = buttonAddToAllowListClick
    end
    object buttonRemoveFromAllowList: TButton
      Left = 172
      Top = 84
      Width = 133
      Height = 21
      Caption = #35377#21487#12522#12473#12488#12363#12425#21066#38500
      TabOrder = 2
      OnClick = buttonRemoveFromAllowListClick
    end
    object comboSpotter: TComboBox
      Left = 12
      Top = 23
      Width = 120
      Height = 259
      Style = csSimple
      CharCase = ecUpperCase
      Sorted = True
      TabOrder = 0
      OnChange = comboSpotterChange
      OnDblClick = comboSpotterDblClick
    end
    object buttonAddToDenyList: TButton
      Left = 172
      Top = 188
      Width = 133
      Height = 21
      Caption = #25298#21542#12522#12473#12488#12408#36861#21152
      TabOrder = 4
      OnClick = buttonAddToDenyListClick
    end
    object buttonRemoveFromDenyList: TButton
      Left = 172
      Top = 220
      Width = 133
      Height = 21
      Caption = #25298#21542#12522#12473#12488#12363#12425#21066#38500
      TabOrder = 5
      OnClick = buttonRemoveFromDenyListClick
    end
  end
end
