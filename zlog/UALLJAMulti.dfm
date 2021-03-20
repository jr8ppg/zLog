object ALLJAMulti: TALLJAMulti
  Left = 138
  Top = 161
  Caption = 'Multipliers'
  ClientHeight = 337
  ClientWidth = 332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Scaled = False
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 332
    Height = 301
    ActivePage = TabALL
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = PageControlChange
    object TabALL: TTabSheet
      Tag = 99
      Caption = 'ALL'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      object Panel: TPanel
        Left = 0
        Top = 0
        Width = 324
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object RotateLabel2: TRotateLabel
          Left = 95
          Top = 4
          Width = 14
          Height = 15
          Escapement = 90
          TextStyle = tsNone
          Caption = '3.5'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object RotateLabel3: TRotateLabel
          Left = 107
          Top = 13
          Width = 14
          Height = 6
          Escapement = 90
          TextStyle = tsNone
          Caption = '7'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object RotateLabel4: TRotateLabel
          Left = 119
          Top = 7
          Width = 14
          Height = 12
          Escapement = 90
          TextStyle = tsNone
          Caption = '14'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object RotateLabel5: TRotateLabel
          Left = 131
          Top = 7
          Width = 14
          Height = 12
          Escapement = 90
          TextStyle = tsNone
          Caption = '21'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object RotateLabel6: TRotateLabel
          Left = 143
          Top = 7
          Width = 14
          Height = 12
          Escapement = 90
          TextStyle = tsNone
          Caption = '28'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object RotateLabel7: TRotateLabel
          Left = 155
          Top = 7
          Width = 14
          Height = 12
          Escapement = 90
          TextStyle = tsNone
          Caption = '50'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object RotateLabel1: TRotateLabel
          Left = 82
          Top = 4
          Width = 14
          Height = 15
          Escapement = 90
          TextStyle = tsNone
          Caption = '1.9'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object Grid: TStringGrid
        Left = 0
        Top = 25
        Width = 324
        Height = 248
        Align = alClient
        ColCount = 1
        DefaultColWidth = 500
        DefaultDrawing = False
        FixedCols = 0
        RowCount = 61
        FixedRows = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #65325#65331' '#12468#12471#12483#12463
        Font.Style = []
        Options = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 1
        OnDrawCell = GridDrawCell
      end
    end
    object Tab19: TTabSheet
      Caption = '1.9MHz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ImageIndex = 7
      ParentFont = False
    end
    object Tab35: TTabSheet
      Tag = 1
      Caption = '3.5MHz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Tab7: TTabSheet
      Tag = 2
      Caption = '7MHz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Tab14: TTabSheet
      Tag = 4
      Caption = '14MHz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Tab21: TTabSheet
      Tag = 6
      Caption = '21MHz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Tab28: TTabSheet
      Tag = 8
      Caption = '28MHz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
    object Tab50: TTabSheet
      Tag = 9
      Caption = '50MHz'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 301
    Width = 332
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Button2: TButton
      Left = 8
      Top = 8
      Width = 65
      Height = 22
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button2Click
    end
    object cbStayOnTop: TCheckBox
      Left = 88
      Top = 10
      Width = 97
      Height = 17
      Caption = 'Stay on top'
      TabOrder = 1
      OnClick = cbStayOnTopClick
    end
  end
end
