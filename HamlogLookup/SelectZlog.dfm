object formSelectZLog: TformSelectZLog
  Left = 0
  Top = 0
  Caption = 'Select zLog'
  ClientHeight = 151
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    430
    151)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 194
    Height = 15
    Caption = #25509#32154#12377#12427'zLog'#12434#36984#25246#12375#12390#19979#12373#12356
  end
  object ListBox1: TListBox
    Left = 8
    Top = 29
    Width = 414
    Height = 78
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    ItemHeight = 15
    ParentFont = False
    TabOrder = 0
    OnDblClick = ListBox1DblClick
    ExplicitWidth = 489
    ExplicitHeight = 161
  end
  object Panel1: TPanel
    Left = 0
    Top = 113
    Width = 430
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 196
    ExplicitWidth = 505
    DesignSize = (
      430
      38)
    object buttonOK: TButton
      Left = 254
      Top = 2
      Width = 81
      Height = 33
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = buttonOKClick
      ExplicitLeft = 329
    end
    object buttonCancel: TButton
      Left = 341
      Top = 2
      Width = 81
      Height = 33
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 416
    end
  end
end
