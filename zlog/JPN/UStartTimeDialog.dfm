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
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
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
    Caption = #12467#12531#12486#12473#12488#38283#22987#26085#26178#12434#20837#21147#12375#12390#19979#12373#12356
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
    Time = 45053.894611794000000000
    TimeFormat = 'hhmm'
  end
  object DatePicker1: TDatePicker
    Left = 8
    Top = 35
    Width = 129
    Height = 33
    Date = 45053
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
    Caption = #12461#12515#12531#12475#12523
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
