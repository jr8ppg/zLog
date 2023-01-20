object BasicScore: TBasicScore
  Left = 271
  Top = 308
  Caption = 'BasicScore'
  ClientHeight = 235
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 202
    Width = 281
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      281
      33)
    object CWButton: TSpeedButton
      Left = 241
      Top = 4
      Width = 33
      Height = 25
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 33
      Caption = 'CW'
      Visible = False
      OnClick = CWButtonClick
    end
    object Button1: TButton
      Left = 8
      Top = 6
      Width = 57
      Height = 21
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = Button1Click
    end
    object StayOnTop: TCheckBox
      Left = 72
      Top = 8
      Width = 81
      Height = 17
      Caption = 'Stay on top'
      TabOrder = 1
      OnClick = StayOnTopClick
    end
  end
  object popupExtraInfo: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 176
    Top = 128
    object menuMultiRate: TMenuItem
      AutoCheck = True
      Caption = 'Multi/QSO %(Rate)'
      Checked = True
      GroupIndex = 1
      RadioItem = True
      OnClick = menuExtraInfoClick
    end
    object menuPtsPerMulti: TMenuItem
      AutoCheck = True
      Caption = 'Points/Multi'
      GroupIndex = 1
      RadioItem = True
      OnClick = menuExtraInfoClick
    end
    object menuPtsPerQSO: TMenuItem
      AutoCheck = True
      Caption = 'Points/QSO(AVG)'
      GroupIndex = 1
      RadioItem = True
      OnClick = menuExtraInfoClick
    end
  end
end
