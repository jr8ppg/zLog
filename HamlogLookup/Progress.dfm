object formProgress: TformProgress
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'In Progress...'
  ClientHeight = 84
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    405
    84)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 20
    Width = 374
    Height = 13
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Label1'
    ExplicitWidth = 433
  end
  object buttonAbort: TButton
    Left = 168
    Top = 48
    Width = 65
    Height = 24
    Caption = #20013#27490
    TabOrder = 0
    OnClick = buttonAbortClick
  end
end
