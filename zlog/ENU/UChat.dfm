object ChatForm: TChatForm
  Left = 199
  Top = 287
  Caption = 'Z-Server Messages'
  ClientHeight = 152
  ClientWidth = 378
  Color = clBtnFace
  Constraints.MinHeight = 190
  Constraints.MinWidth = 390
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 124
    Width = 378
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 123
    ExplicitWidth = 374
    DesignSize = (
      378
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
      ExplicitWidth = 234
    end
    object buttonSend: TButton
      Left = 320
      Top = 4
      Width = 51
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'Send'
      TabOrder = 1
      OnClick = buttonSendClick
      ExplicitLeft = 316
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
    Width = 378
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
    ExplicitWidth = 374
    ExplicitHeight = 98
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 378
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 374
    DesignSize = (
      378
      25)
    object checkPopup: TCheckBox
      Left = 4
      Top = 4
      Width = 145
      Height = 17
      Caption = 'Pop up on new message'
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
      ExplicitLeft = 300
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
      OnClick = comboPromptTypeChange
    end
  end
end
