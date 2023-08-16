object DateDialog: TDateDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Change date'
  ClientHeight = 116
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 20
    Width = 58
    Height = 13
    Caption = #29694#22312#12398#26085#20184
  end
  object Label2: TLabel
    Left = 146
    Top = 20
    Width = 46
    Height = 13
    Caption = #26032#12375#12356#26085#20184
  end
  object Label3: TLabel
    Left = 105
    Top = 39
    Width = 37
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = '==>'
  end
  object datetimeChange: TDateTimePicker
    Left = 146
    Top = 35
    Width = 80
    Height = 21
    Date = 44714
    Format = 'yyyy/MM/dd'
    Time = 0.882441875000950000
    TabOrder = 1
  end
  object panelFooter: TPanel
    Left = 0
    Top = 83
    Width = 250
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitLeft = -55
    ExplicitTop = 161
    ExplicitWidth = 692
    DesignSize = (
      250
      33)
    object buttonOK: TButton
      Left = 89
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 531
    end
    object buttonCancel: TButton
      Left = 170
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 612
    end
  end
  object datetimeCurrent: TDateTimePicker
    Left = 20
    Top = 35
    Width = 81
    Height = 21
    Date = 44714
    Format = 'yyyy/MM/dd'
    Time = 0.882441875000950000
    Enabled = False
    TabOrder = 0
  end
end
