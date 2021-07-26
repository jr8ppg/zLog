object ChatForm: TChatForm
  Left = 199
  Top = 287
  Caption = 'Z-Server Messages'
  ClientHeight = 152
  ClientWidth = 354
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 118
    Width = 354
    Height = 34
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      354
      34)
    object Edit: TEdit
      Left = 76
      Top = 6
      Width = 271
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
    Width = 354
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
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 354
    Height = 25
    Align = alTop
    TabOrder = 2
    DesignSize = (
      354
      25)
    object CheckBox: TCheckBox
      Left = 8
      Top = 4
      Width = 161
      Height = 17
      Caption = 'Pop up on new message'
      TabOrder = 0
    end
    object Button2: TButton
      Left = 284
      Top = 4
      Width = 67
      Height = 18
      Anchors = [akTop, akRight]
      Caption = 'Clear'
      TabOrder = 1
      OnClick = Button2Click
    end
    object cbStayOnTop: TCheckBox
      Left = 168
      Top = 4
      Width = 97
      Height = 17
      Caption = 'Stay on top'
      TabOrder = 2
      OnClick = cbStayOnTopClick
    end
  end
end
