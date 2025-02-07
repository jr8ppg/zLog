object formSpcViewer: TformSpcViewer
  Left = 0
  Top = 0
  Caption = 'SPC Viewer'
  ClientHeight = 442
  ClientWidth = 388
  Color = clBtnFace
  Constraints.MaxWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 409
    Width = 388
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 408
    ExplicitWidth = 384
    object buttonOK: TButton
      Left = 149
      Top = 3
      Width = 92
      Height = 25
      Caption = 'Close'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 388
    Height = 409
    Align = alClient
    Columns = <
      item
        Caption = 'No.'
      end
      item
        Caption = 'Main callsign'
        Width = 80
      end
      item
        Alignment = taCenter
        Caption = 'Serial'
        Width = 40
      end
      item
        Caption = 'Sub callsign'
        Width = 80
      end
      item
        Caption = 'NR'
      end
      item
        Alignment = taRightJustify
        Caption = 'RBN count'
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    ExplicitWidth = 338
    ExplicitHeight = 408
  end
end
