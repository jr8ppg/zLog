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
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 124
    Width = 374
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      374
      28)
    object editMessage: TEdit
      Left = 80
      Top = 4
      Width = 238
      Height = 20
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnEnter = editMessageEnter
      OnExit = editMessageExit
      OnKeyPress = editMessageKeyPress
    end
    object buttonSend: TButton
      Left = 320
      Top = 4
      Width = 51
      Height = 20
      Anchors = [akTop, akRight]
      Caption = #36865#20449
      TabOrder = 1
      OnClick = buttonSendClick
    end
    object comboPromptType: TComboBox
      Left = 4
      Top = 4
      Width = 73
      Height = 20
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 2
      Text = 'Band'
      OnChange = comboPromptTypeChange
      Items.Strings = (
        'Band'
        'PCNAME'
        'OPNAME'
        'CALL')
    end
  end
  object ListBox: TListBox
    Left = 0
    Top = 25
    Width = 374
    Height = 99
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    ItemHeight = 12
    ParentFont = False
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 374
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      374
      25)
    object checkPopup: TCheckBox
      Left = 4
      Top = 4
      Width = 155
      Height = 17
      Caption = #26032#12513#12483#12475#12540#12472#12391#12509#12483#12503#12450#12483#12503
      TabOrder = 0
      OnClick = comboPromptTypeChange
    end
    object Button2: TButton
      Left = 304
      Top = 4
      Width = 67
      Height = 18
      Anchors = [akTop, akRight]
      Caption = 'Clear'
      TabOrder = 1
      OnClick = Button2Click
    end
    object checkStayOnTop: TCheckBox
      Left = 165
      Top = 4
      Width = 95
      Height = 17
      Caption = #26368#21069#38754#12395#34920#31034
      TabOrder = 2
      OnClick = checkStayOnTopClick
    end
    object checkRecord: TCheckBox
      Left = 260
      Top = 4
      Width = 40
      Height = 17
      Caption = #35352#37682
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = comboPromptTypeChange
    end
  end
end
