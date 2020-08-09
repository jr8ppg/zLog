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
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 204
    Height = 416
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
      Width = 192
      Height = 404
      Align = alClient
      ColCount = 1
      DefaultColWidth = 500
      DefaultDrawing = False
      DoubleBuffered = True
      FixedCols = 0
      FixedRows = 0
      Options = []
      ParentDoubleBuffered = False
      PopupMenu = BSMenu
      ScrollBars = ssVertical
      TabOrder = 0
      OnDblClick = GridDblClick
      OnDrawCell = GridDrawCell
      OnMouseEnter = GridMouseEnter
      OnMouseLeave = GridMouseLeave
      OnMouseMove = GridMouseMove
    end
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
  object BalloonHint1: TBalloonHint
    Delay = 100
    Left = 88
    Top = 320
  end
end
