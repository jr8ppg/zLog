object RateDialogEx: TRateDialogEx
  Left = 69
  Top = 213
  ActiveControl = ShowLastCombo
  Caption = 'QSO Rate Ex'
  ClientHeight = 262
  ClientWidth = 390
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 350
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 390
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 386
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 35
      Height = 13
      Caption = 'Last 10'
    end
    object Label2: TLabel
      Left = 8
      Top = 20
      Width = 41
      Height = 13
      Caption = 'Last 100'
    end
    object Last10: TLabel
      Left = 64
      Top = 8
      Width = 66
      Height = 13
      Caption = '0.00 QSOs/hr'
    end
    object Last100: TLabel
      Left = 64
      Top = 20
      Width = 66
      Height = 13
      Caption = '0.00 QSOs/hr'
    end
    object Max10: TLabel
      Left = 152
      Top = 8
      Width = 66
      Height = 13
      Caption = '0.00 QSOs/hr'
    end
    object Max100: TLabel
      Left = 152
      Top = 20
      Width = 66
      Height = 13
      Caption = '0.00 QSOs/hr'
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 37
    Width = 390
    Height = 225
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 386
    ExplicitHeight = 224
    object TabSheet1: TTabSheet
      Caption = #12464#12521#12501
      object Panel2: TPanel
        Left = 0
        Top = 167
        Width = 382
        Height = 30
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitTop = 166
        ExplicitWidth = 378
        DesignSize = (
          382
          30)
        object Label4: TLabel
          Left = 299
          Top = 9
          Width = 26
          Height = 13
          Anchors = [akRight]
          Caption = #26178#38291
          ExplicitLeft = 255
        end
        object Label3: TLabel
          Left = 203
          Top = 9
          Width = 46
          Height = 13
          Anchors = [akRight]
          Caption = #26368#24460#12363#12425
          ExplicitLeft = 159
        end
        object ShowLastCombo: TComboBox
          Left = 253
          Top = 5
          Width = 41
          Height = 21
          Style = csDropDownList
          Anchors = [akRight]
          Ctl3D = True
          ItemIndex = 2
          ParentCtl3D = False
          TabOrder = 0
          Text = '12'
          OnChange = ShowLastComboChange
          Items.Strings = (
            '3'
            '6'
            '12'
            '18'
            '24'
            '36'
            '48')
          ExplicitLeft = 249
        end
        object check3D: TCheckBox
          Left = 339
          Top = 6
          Width = 33
          Height = 17
          Anchors = [akTop, akRight]
          Caption = '3D'
          TabOrder = 1
          OnClick = check3DClick
          ExplicitLeft = 335
        end
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 157
          Height = 33
          BevelOuter = bvNone
          TabOrder = 2
          object radioOriginCurrentTime: TRadioButton
            Left = 52
            Top = 6
            Width = 54
            Height = 17
            Caption = #29694#22312
            Checked = True
            TabOrder = 1
            TabStop = True
            OnClick = radioOriginClick
          end
          object radioOriginLastQSO: TRadioButton
            Left = 96
            Top = 6
            Width = 40
            Height = 17
            Caption = #26368#24460
            TabOrder = 2
            OnClick = radioOriginClick
          end
          object radioOriginFirstQSO: TRadioButton
            Left = 8
            Top = 6
            Width = 39
            Height = 17
            Caption = #26368#21021
            TabOrder = 0
            OnClick = radioOriginClick
          end
        end
      end
      object Chart1: TChart
        Left = 0
        Top = 0
        Width = 382
        Height = 167
        LeftWall.Color = clWhite
        Legend.Visible = False
        Title.Text.Strings = (
          'TChart')
        BottomAxis.MinorTickCount = 0
        LeftAxis.AxisValuesFormat = '#,###'
        LeftAxis.MinorTickCount = 0
        Panning.MouseWheel = pmwNone
        RightAxis.MinorTickCount = 0
        View3D = False
        Zoom.Allow = False
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitWidth = 378
        ExplicitHeight = 166
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series1: TBarSeries
          HoverElement = []
          Marks.Font.Color = 14811135
          Marks.Transparent = True
          Marks.Style = smsValue
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.Visible = False
          ValueFormat = '#,###'
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          TickLines.Color = clDefault
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series2: TBarSeries
          HoverElement = []
          Marks.Font.Color = clWhite
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.BackColor = clWhite
          Marks.Callout.Arrow.Visible = False
          Marks.Color = clWhite
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series3: TBarSeries
          HoverElement = []
          Marks.Transparent = True
          Marks.Style = smsValue
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.Visible = False
          Marks.SoftClip = True
          Marks.UseSeriesTransparency = False
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series4: TBarSeries
          HoverElement = []
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.Visible = False
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series5: TBarSeries
          HoverElement = []
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.Visible = False
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series6: TBarSeries
          HoverElement = []
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.Visible = False
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series7: TBarSeries
          HoverElement = []
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.Visible = False
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series8: TBarSeries
          HoverElement = []
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.Visible = False
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series9: TBarSeries
          HoverElement = []
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.Visible = False
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series10: TBarSeries
          HoverElement = []
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.Visible = False
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series11: TBarSeries
          HoverElement = []
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.Visible = False
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series12: TBarSeries
          HoverElement = []
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.Visible = False
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series13: TBarSeries
          HoverElement = []
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.Visible = False
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series14: TBarSeries
          HoverElement = []
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.Visible = False
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series15: TBarSeries
          HoverElement = []
          Marks.Font.Color = clWhite
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.Visible = False
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series16: TBarSeries
          HoverElement = []
          BarBrush.Color = -1
          Marks.Font.Color = clRed
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.BackColor = clRed
          Marks.Callout.Arrow.Visible = False
          Marks.Color = clRed
          SeriesColor = 8454143
          BarWidthPercent = 75
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          Sides = 3
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object Series17: TBarSeries
          HoverElement = []
          Marks.Font.Color = clWhite
          Marks.Transparent = True
          Marks.Arrow.Visible = False
          Marks.BackColor = clWhite
          Marks.Callout.Arrow.Visible = False
          Marks.Color = clWhite
          MarksLocation = mlCenter
          MarksOnBar = True
          MultiBar = mbStacked
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object SeriesActualTotals: TLineSeries
          HoverElement = [heCurrent]
          SeriesColor = 33023
          Title = 'SeriesActualTotals'
          Brush.BackColor = clDefault
          Pointer.HorizSize = 3
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.VertSize = 3
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object SeriesTargetTotals: TLineSeries
          HoverElement = [heCurrent]
          SeriesColor = 11627079
          Title = 'SeriesTargetTotals'
          Brush.BackColor = clDefault
          Pointer.HorizSize = 3
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 3
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'ZAQ'
      ImageIndex = 1
      object ScoreGrid: TStringGrid
        Left = 0
        Top = 0
        Width = 382
        Height = 197
        Align = alClient
        ColCount = 27
        DefaultDrawing = False
        RowCount = 36
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #65325#65331' '#12468#12471#12483#12463
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine]
        ParentFont = False
        PopupMenu = popupScore
        TabOrder = 0
        OnDrawCell = ScoreGridDrawCell
        OnSelectCell = ScoreGridSelectCell
        OnTopLeftChanged = ScoreGridTopLeftChanged
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'ZAQ2'
      ImageIndex = 2
      object ScoreGrid2: TStringGrid
        Left = 0
        Top = 0
        Width = 382
        Height = 197
        Align = alClient
        ColCount = 28
        DefaultDrawing = False
        RowCount = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #65325#65331' '#12468#12471#12483#12463
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine]
        ParentFont = False
        PopupMenu = popupScore
        TabOrder = 0
        OnDrawCell = ScoreGrid2DrawCell
        OnSelectCell = ScoreGridSelectCell
        OnTopLeftChanged = ScoreGridTopLeftChanged
      end
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = TimerTimer
    Left = 288
    Top = 12
  end
  object popupScore: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 200
    Top = 153
    object menuDispAlternating: TMenuItem
      Caption = #12496#12531#12489#38918#12395#23455#32318#20516#65292#30446#27161#20516#12398#38918
      Checked = True
      GroupIndex = 1
      RadioItem = True
      OnClick = menuDispAlternatingClick
    end
    object menuDispOrder: TMenuItem
      Caption = #23455#32318#20516#12496#12531#12489#38918#65292#30446#27161#20516#12496#12531#12489#38918
      GroupIndex = 1
      RadioItem = True
      OnClick = menuDispAlternatingClick
    end
    object N1: TMenuItem
      Caption = '-'
      GroupIndex = 2
    end
    object menuAchievementRate: TMenuItem
      Caption = #36948#25104#29575#34920#31034
      Checked = True
      GroupIndex = 2
      RadioItem = True
      OnClick = menuAchievementRateClick
    end
    object menuWinLoss: TMenuItem
      Caption = #21213#12385#36000#12369#34920#31034
      GroupIndex = 2
      RadioItem = True
      OnClick = menuAchievementRateClick
    end
  end
  object timerRefresh: TTimer
    Enabled = False
    Interval = 180000
    OnTimer = timerRefreshTimer
    Left = 240
    Top = 16
  end
end
