object ChatForm: TChatForm
  Left = 199
  Top = 287
  Caption = 'Z-Server Messages'
  ClientHeight = 152
  ClientWidth = 374
  Color = clBtnFace
  Constraints.MinHeight = 190
  Constraints.MinWidth = 390
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 118
    Width = 374
    Height = 34
    Align = alBottom
    TabOrder = 0
    ExplicitWidth = 354
    DesignSize = (
      374
      34)
    object Edit: TEdit
      Left = 76
      Top = 6
      Width = 291
      Height = 20
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyPress = EditKeyPress
      ExplicitWidth = 271
    end
    object Button1: TButton
      Left = 6
      Top = 6
      Width = 65
      Height = 21
      Caption = 'OK'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object ListBox: TListBox
    Left = 0
    Top = 25
    Width = 374
    Height = 93
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
    ItemHeight = 12
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 354
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 374
    Height = 25
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 354
    DesignSize = (
      374
      25)
    object checkPopup: TCheckBox
      Left = 8
      Top = 4
      Width = 145
      Height = 17
      Caption = 'Pop up on new message'
      TabOrder = 0
    end
    object Button2: TButton
      Left = 303
      Top = 4
      Width = 67
      Height = 18
      Anchors = [akTop, akRight]
      Caption = 'Clear'
      TabOrder = 1
      OnClick = Button2Click
    end
    object checkStayOnTop: TCheckBox
      Left = 155
      Top = 4
      Width = 79
      Height = 17
      Caption = 'Stay on top'
      TabOrder = 2
      OnClick = checkStayOnTopClick
    end
    object checkRecord: TCheckBox
      Left = 240
      Top = 4
      Width = 60
      Height = 17
      Caption = 'Record'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = checkStayOnTopClick
    end
  end
end
