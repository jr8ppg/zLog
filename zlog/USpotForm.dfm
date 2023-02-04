object SpotForm: TSpotForm
  Left = 109
  Top = 202
  BorderStyle = bsDialog
  Caption = 'Send DX Spot'
  ClientHeight = 74
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 6
    Top = 4
    Width = 53
    Height = 12
    Caption = 'Frequency'
  end
  object Label2: TLabel
    Left = 84
    Top = 4
    Width = 45
    Height = 12
    Caption = 'Call sign'
  end
  object Label3: TLabel
    Left = 160
    Top = 4
    Width = 48
    Height = 12
    Caption = 'Comment'
  end
  object FreqEdit: TEdit
    Left = 6
    Top = 18
    Width = 73
    Height = 20
    TabOrder = 0
    Text = 'Freq'
  end
  object CallsignEdit: TEdit
    Left = 84
    Top = 18
    Width = 70
    Height = 20
    TabOrder = 1
    Text = 'Callsign'
  end
  object CommentEdit: TEdit
    Left = 160
    Top = 18
    Width = 149
    Height = 20
    TabOrder = 2
    Text = 'Comment'
  end
  object Panel1: TPanel
    Left = 0
    Top = 45
    Width = 315
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object SendButton: TButton
      Left = 177
      Top = 2
      Width = 65
      Height = 24
      Caption = 'Send'
      Default = True
      TabOrder = 0
      OnClick = SendButtonClick
    end
    object CancelButton: TButton
      Left = 244
      Top = 2
      Width = 65
      Height = 24
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = CancelButtonClick
    end
  end
end
