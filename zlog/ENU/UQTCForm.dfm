object QTCForm: TQTCForm
  Left = 578
  Top = 204
  Caption = 'QTC'
  ClientHeight = 316
  ClientWidth = 249
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poOwnerFormCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 24
    Top = 56
    Width = 43
    Height = 17
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
    Top = 32
    Width = 43
    Height = 17
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
    Width = 136
    Height = 17
    Caption = '# of QTCs to be sent'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object btnSend: TButton
    Left = 22
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Send'
    Default = True
    TabOrder = 0
    OnClick = btnSendClick
  end
  object btnBack: TButton
    Left = 112
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Back (BS)'
    TabOrder = 1
    OnClick = btnBackClick
  end
  object SpinEdit: TSpinEdit
    Left = 176
    Top = 7
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
    Left = 21
    Top = 80
    Width = 212
    Height = 177
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
