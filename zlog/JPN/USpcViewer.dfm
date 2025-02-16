object formSpcViewer: TformSpcViewer
  Left = 0
  Top = 0
  Caption = 'SPC Viewer'
  ClientHeight = 441
  ClientWidth = 464
  Color = clBtnFace
  Constraints.MinHeight = 100
  Constraints.MinWidth = 480
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnResize = FormResize
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 408
    Width = 464
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object buttonOK: TButton
      Left = 189
      Top = 3
      Width = 92
      Height = 25
      Caption = #38281#12376#12427
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 464
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
        Caption = '1.9'
      end
      item
        Caption = '3.5'
      end
      item
        Caption = '7'
      end
      item
        Caption = '14'
      end
      item
        Caption = '21'
      end
      item
        Caption = '28'
      end
      item
        Caption = '50'
      end
      item
        Caption = '144'
      end
      item
        Caption = '430'
      end
      item
        Caption = '1200'
      end
      item
        Caption = '2400'
      end
      item
        Caption = '5600'
      end
      item
        Caption = '10G'
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
end
