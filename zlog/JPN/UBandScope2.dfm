object BandScope2: TBandScope2
  Left = 48
  Top = 125
  BorderStyle = bsSizeToolWin
  Caption = 'Band Scope'
  ClientHeight = 416
  ClientWidth = 194
  Color = clBtnFace
  Constraints.MinHeight = 140
  Constraints.MinWidth = 210
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
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 19
    Width = 194
    Height = 397
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 4
    BorderStyle = bsSingle
    Color = clRed
    ParentBackground = False
    TabOrder = 0
    object Grid: TStringGrid
      Left = 4
      Top = 4
      Width = 182
      Height = 385
      Align = alClient
      ColCount = 1
      DefaultColWidth = 188
      DefaultDrawing = False
      DoubleBuffered = True
      FixedCols = 0
      FixedRows = 0
      Options = []
      ParentDoubleBuffered = False
      ParentShowHint = False
      PopupMenu = BSMenu
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 0
      OnDblClick = GridDblClick
      OnDrawCell = GridDrawCell
      OnMouseMove = GridMouseMove
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 194
    Height = 19
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object checkSyncVfo: TCheckBox
      Left = 4
      Top = 3
      Width = 133
      Height = 13
      Caption = 'VFO'#21516#26399
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = checkSyncVfoClick
    end
  end
  object BSMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 48
    Top = 48
    object mnDelete: TMenuItem
      Caption = #21066#38500
      OnClick = mnDeleteClick
    end
    object Deleteallworkedstations1: TMenuItem
      Caption = #20132#20449#28168#12415#12434#20840#12390#21066#38500
      OnClick = Deleteallworkedstations1Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 56
    Top = 112
  end
  object ImageList1: TImageList
    Left = 56
    Top = 176
  end
  object timerCleanup: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = timerCleanupTimer
    Left = 112
    Top = 136
  end
end
