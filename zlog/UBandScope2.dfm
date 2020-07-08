object BandScope2: TBandScope2
  Left = 48
  Top = 125
  Caption = 'Band Scope'
  ClientHeight = 416
  ClientWidth = 116
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 116
    Height = 25
    Align = alTop
    TabOrder = 0
    Visible = False
  end
  object Grid: TMgrid
    Left = 0
    Top = 25
    Width = 116
    Height = 391
    Align = alClient
    ColCount = 1
    DefaultColWidth = 500
    DefaultRowHeight = 14
    FixedCols = 0
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Pitch = fpFixed
    Font.Style = []
    GridLineWidth = 0
    Options = [goRangeSelect, goRowSelect, goThumbTracking]
    ParentFont = False
    Popupmenu = BSMenu
    ScrollBars = ssVertical
    TabOrder = 1
    OnDblClick = GridDblClick
    Alignment = taLeftJustify
    BorderColor = clSilver
    OddRowColor = clWindow
    EvenRowColor = clWindow
    OnSetting = GridSetting
  end
  object BSMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 48
    Top = 48
    object mnDelete: TMenuItem
      Caption = 'Delete'
      OnClick = mnDeleteClick
    end
    object Deleteallworkedstations1: TMenuItem
      Caption = 'Delete all worked stations'
      OnClick = Deleteallworkedstations1Click
    end
    object Mode1: TMenuItem
      Caption = 'Mode...'
      object mnCurrentRig: TMenuItem
        Caption = 'Current Rig'
        OnClick = ModeClick
      end
      object Rig11: TMenuItem
        Tag = 1
        Caption = 'Rig 1'
        OnClick = ModeClick
      end
      object Rig21: TMenuItem
        Tag = 2
        Caption = 'Rig 2'
        OnClick = ModeClick
      end
      object Fixedband1: TMenuItem
        Caption = 'Fixed band'
        object N19MHz1: TMenuItem
          Caption = '1.9 MHz'
          OnClick = FixedBandClick
        end
        object N35MHz1: TMenuItem
          Tag = 1
          Caption = '3.5 MHz'
          OnClick = FixedBandClick
        end
        object N7MHz1: TMenuItem
          Tag = 2
          Caption = '7 MHz'
          OnClick = FixedBandClick
        end
        object N14MHz1: TMenuItem
          Tag = 4
          Caption = '14 MHz'
          OnClick = FixedBandClick
        end
        object N21MHz1: TMenuItem
          Tag = 6
          Caption = '21 MHz'
          OnClick = FixedBandClick
        end
        object N28MHz1: TMenuItem
          Tag = 8
          Caption = '28 MHz'
          OnClick = FixedBandClick
        end
        object N50MHz1: TMenuItem
          Tag = 9
          Caption = '50 MHz'
          OnClick = FixedBandClick
        end
      end
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 56
    Top = 112
  end
end
