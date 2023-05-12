object StartTimeDialog: TStartTimeDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Start time'
  ClientHeight = 115
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    284
    115)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 236
    Height = 17
    Caption = 'Enter the contest start date and time'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object TimePicker1: TTimePicker
    Left = 143
    Top = 35
    Width = 74
    Height = 33
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Consolas'
    Font.Style = []
    TabOrder = 0
    Time = 45053.894611793990000000
    TimeFormat = 'hhmm'
  end
  object DatePicker1: TDatePicker
    Left = 8
    Top = 35
    Width = 129
    Height = 33
    Date = 45053.000000000000000000
    DateFormat = 'yyyy/MM/dd'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Consolas'
    Font.Style = []
    TabOrder = 1
  end
  object OKBtn: TButton
    Left = 128
    Top = 86
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitLeft = 126
  end
  object CancelBtn: TButton
    Left = 204
    Top = 86
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    ExplicitLeft = 202
  end
  object panelTimeZone: TPanel
    Left = 223
    Top = 35
    Width = 50
    Height = 33
    BevelOuter = bvLowered
    Caption = 'JST'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
end
