object formSpcViewer: TformSpcViewer
  Left = 0
  Top = 0
  Caption = 'SPC Viewer'
  ClientHeight = 441
  ClientWidth = 468
  Color = clBtnFace
  Constraints.MinHeight = 100
  Constraints.MinWidth = 480
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnResize = FormResize
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 408
    Width = 468
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object buttonOK: TButton
      Left = 189
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
    Width = 468
    Height = 408
    Align = alClient
    Columns = <
      item
        Caption = 'No.'
      end
      item
        Caption = 'Callsign'
        Width = 80
      end
      item
        Alignment = taRightJustify
        Caption = 'RBN count'
        Width = 40
      end
      item
        Alignment = taCenter
        Caption = 'NR#1'
      end
      item
        Alignment = taCenter
        Caption = 'NR#2'
      end
      item
        Alignment = taCenter
        Caption = 'NR#3'
      end
      item
        Alignment = taCenter
        Caption = 'NR#4'
      end
      item
        Caption = 'NR#5'
      end
      item
        Alignment = taRightJustify
        Caption = '1.9'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Caption = '3.5'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Caption = '7'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Caption = '14'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Caption = '21'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Caption = '28'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Caption = '50'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Caption = '144'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Caption = '430'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Caption = '1200'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Caption = '2400'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Caption = '5600'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Caption = '10G'
        Width = 40
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
end
