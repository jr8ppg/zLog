object BandScope2: TBandScope2
  Left = 48
  Top = 125
  BorderStyle = bsSizeToolWin
  Caption = 'Band Scope'
  ClientHeight = 416
  ClientWidth = 204
  Color = clBtnFace
  Constraints.MinHeight = 140
  Constraints.MinWidth = 210
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Grid: TMgrid
    Left = 0
    Top = 0
    Width = 204
    Height = 416
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
    TabOrder = 0
    OnDblClick = GridDblClick
    Alignment = taLeftJustify
    BorderColor = clSilver
    OddRowColor = clWindow
    EvenRowColor = clWindow
    OnSetting = GridSetting
    ExplicitTop = 25
    ExplicitWidth = 120
    ExplicitHeight = 391
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
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 56
    Top = 112
  end
end
