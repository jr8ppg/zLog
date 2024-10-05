object QTCForm: TQTCForm
  Left = 578
  Top = 204
  BorderStyle = bsDialog
  Caption = 'QTC'
  ClientHeight = 316
  ClientWidth = 279
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  TextHeight = 12
  object Label1: TLabel
    Left = 24
    Top = 57
    Width = 233
    Height = 17
    AutoSize = False
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 34
    Width = 233
    Height = 17
    AutoSize = False
    Caption = 'Label2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 11
    Width = 186
    Height = 17
    AutoSize = False
    Caption = '# of QTCs to be sent'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object btnSend: TButton
    Left = 8
    Top = 283
    Width = 75
    Height = 25
    Caption = 'Send'
    Default = True
    TabOrder = 0
    OnClick = btnSendClick
  end
  object btnBack: TButton
    Left = 193
    Top = 283
    Width = 75
    Height = 25
    Caption = 'Back (BS)'
    TabOrder = 1
    OnClick = btnBackClick
  end
  object SpinEdit: TSpinEdit
    Left = 216
    Top = 8
    Width = 41
    Height = 26
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MaxValue = 10
    MinValue = 0
    ParentFont = False
    TabOrder = 2
    Value = 0
    OnChange = SpinEditChange
  end
  object ListBox: TListBox
    Left = 8
    Top = 96
    Width = 260
    Height = 169
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Items.Strings = (
      'line1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10')
    ParentFont = False
    TabOrder = 3
  end
end
