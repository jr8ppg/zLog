object MainForm: TMainForm
  Left = 276
  Top = 138
  VertScrollBar.Visible = False
  Caption = 'zLog for Windows'
  ClientHeight = 423
  ClientWidth = 528
  Color = clBtnFace
  Constraints.MinWidth = 540
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS '#12468#12471#12483#12463
  Font.Style = []
  Menu = MainMenu
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 13
  object TLabel
    Left = 235
    Top = 197
    Width = 3
    Height = 13
  end
  object StatusLine: TStatusBar
    Left = 0
    Top = 403
    Width = 528
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -12
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    Panels = <
      item
        Style = psOwnerDraw
        Width = 500
      end
      item
        Alignment = taCenter
        Width = 50
      end
      item
        Alignment = taCenter
        Width = 50
      end
      item
        Alignment = taCenter
        Width = 50
      end>
    SizeGrip = False
    UseSystemFont = False
    OnDrawPanel = StatusLineDrawPanel
    OnResize = StatusLineResize
    ExplicitTop = 402
    ExplicitWidth = 524
  end
  object MainPanel: TPanel
    Left = 0
    Top = 122
    Width = 528
    Height = 281
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 524
    ExplicitHeight = 280
    object EditPanel1R: TPanel
      Left = 0
      Top = 171
      Width = 528
      Height = 27
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitTop = 170
      ExplicitWidth = 524
      object RcvdRSTEdit1: TEdit
        Left = 117
        Top = 4
        Width = 52
        Height = 18
        TabStop = False
        AutoSize = False
        ImeMode = imDisable
        TabOrder = 0
        OnChange = RcvdRSTEdit1Change
        OnKeyDown = EditKeyDown
        OnKeyPress = EditKeyPress
      end
      object BandEdit1: TEdit
        Left = 368
        Top = 4
        Width = 73
        Height = 18
        TabStop = False
        AutoSize = False
        ImeMode = imDisable
        PopupMenu = BandMenu
        ReadOnly = True
        TabOrder = 1
        Text = 'BandEdit1'
        OnClick = BandEdit1Click
        OnKeyDown = EditKeyDown
      end
      object ModeEdit1: TEdit
        Left = 192
        Top = 4
        Width = 33
        Height = 18
        TabStop = False
        AutoSize = False
        ImeMode = imDisable
        PopupMenu = ModeMenu
        ReadOnly = True
        TabOrder = 2
        OnClick = ModeEdit1Click
        OnKeyDown = EditKeyDown
      end
      object PointEdit1: TEdit
        Left = 320
        Top = 4
        Width = 70
        Height = 18
        TabStop = False
        AutoSize = False
        ImeMode = imDisable
        TabOrder = 3
        Text = 'PointEdit1'
        OnKeyDown = EditKeyDown
        OnKeyPress = EditKeyPress
      end
      object OpEdit1: TEdit
        Left = 37
        Top = 4
        Width = 124
        Height = 18
        TabStop = False
        AutoSize = False
        ImeMode = imDisable
        ParentShowHint = False
        PopupMenu = OpMenu
        ReadOnly = True
        ShowHint = False
        TabOrder = 4
        OnClick = OpEdit1Click
        OnKeyDown = EditKeyDown
      end
      object SerialEdit1: TEdit
        Left = 32
        Top = 4
        Width = 73
        Height = 18
        TabStop = False
        AutoSize = False
        ImeMode = imDisable
        TabOrder = 5
        Visible = False
        OnChange = SerialEdit1Change
        OnKeyDown = EditKeyDown
      end
      object PowerEdit1: TEdit
        Left = 416
        Top = 4
        Width = 49
        Height = 18
        TabStop = False
        AutoSize = False
        ImeMode = imDisable
        PopupMenu = NewPowerMenu
        TabOrder = 6
        Visible = False
        OnClick = PowerEdit1Click
        OnKeyDown = EditKeyDown
      end
      object CallsignEdit1: TOvrEdit
        Left = 144
        Top = 4
        Width = 121
        Height = 18
        TabStop = False
        AutoSelect = False
        AutoSize = False
        CharCase = ecUpperCase
        ImeMode = imDisable
        TabOrder = 7
        OnChange = CallsignEdit1Change
        OnEnter = EditEnter
        OnExit = EditExit
        OnKeyDown = EditKeyDown
        OnKeyPress = EditKeyPress
        OnKeyUp = CallsignEdit1KeyUp
        TabOnEnter = False
      end
      object NumberEdit1: TOvrEdit
        Left = 136
        Top = 4
        Width = 73
        Height = 18
        TabStop = False
        AutoSelect = False
        AutoSize = False
        CharCase = ecUpperCase
        ImeMode = imDisable
        TabOrder = 8
        Text = 'NUMBER'
        OnChange = NumberEdit1Change
        OnEnter = EditEnter
        OnExit = EditExit
        OnKeyDown = EditKeyDown
        OnKeyPress = EditKeyPress
        OnKeyUp = NumberEdit1KeyUp
        TabOnEnter = False
      end
      object MemoEdit1: TOvrEdit
        Tag = 1000
        Left = 432
        Top = 4
        Width = 73
        Height = 18
        TabStop = False
        AutoSize = False
        TabOrder = 9
        OnChange = MemoEdit1Change
        OnEnter = EditEnter
        OnExit = EditExit
        OnKeyDown = EditKeyDown
        OnKeyPress = EditKeyPress
        TabOnEnter = False
      end
      object TimeEdit1: TOvrEdit
        Left = 64
        Top = 4
        Width = 57
        Height = 18
        TabStop = False
        AutoSize = False
        ImeMode = imDisable
        TabOrder = 10
        Text = 'TIME'
        OnChange = TimeEdit1Change
        OnDblClick = TimeEdit1DblClick
        OnKeyDown = EditKeyDown
        OnKeyPress = EditKeyPress
        TabOnEnter = False
      end
      object DateEdit1: TOvrEdit
        Left = 8
        Top = 4
        Width = 57
        Height = 18
        TabStop = False
        AutoSize = False
        ImeMode = imDisable
        TabOrder = 11
        Text = 'date'
        Visible = False
        OnChange = DateEdit1Change
        OnDblClick = TimeEdit1DblClick
        OnKeyDown = EditKeyDown
        OnKeyPress = EditKeyPress
        TabOnEnter = False
      end
    end
    object EditPanel2R: TPanel
      Left = 0
      Top = 198
      Width = 528
      Height = 83
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitTop = 197
      ExplicitWidth = 524
      object RigPanelC: TPanel
        Left = 1
        Top = 54
        Width = 526
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitWidth = 522
        DesignSize = (
          526
          28)
        object RigPanelShape2C: TShape
          Tag = 3
          Left = 0
          Top = 0
          Width = 526
          Height = 28
          Align = alClient
          Brush.Style = bsClear
          Pen.Width = 2
          ExplicitLeft = 1
          ExplicitWidth = 499
        end
        object ledTx2C: TJvLED
          Left = 71
          Top = 5
          ColorOff = clSilver
          Status = False
        end
        object labelRig3Title: TLabel
          Left = 25
          Top = 5
          Width = 40
          Height = 18
          Caption = 'RIG-C'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
          OnClick = labelRig3TitleClick
        end
        object CallsignEdit2C: TOvrEdit
          Tag = 3
          Left = 93
          Top = 4
          Width = 80
          Height = 20
          TabStop = False
          AutoSelect = False
          AutoSize = False
          CharCase = ecUpperCase
          ImeMode = imDisable
          TabOrder = 0
          OnChange = CallsignEdit1Change
          OnEnter = EditEnter
          OnExit = EditExit
          OnKeyDown = EditKeyDown
          OnKeyPress = EditKeyPress
          OnKeyUp = CallsignEdit1KeyUp
          TabOnEnter = False
        end
        object NumberEdit2C: TOvrEdit
          Tag = 3
          Left = 213
          Top = 4
          Width = 70
          Height = 20
          TabStop = False
          AutoSelect = False
          AutoSize = False
          CharCase = ecUpperCase
          ImeMode = imDisable
          TabOrder = 2
          OnChange = NumberEdit1Change
          OnEnter = EditEnter
          OnExit = EditExit
          OnKeyDown = EditKeyDown
          OnKeyPress = EditKeyPress
          OnKeyUp = NumberEdit1KeyUp
          TabOnEnter = False
        end
        object RcvdRSTEdit2C: TEdit
          Tag = 3
          Left = 176
          Top = 4
          Width = 34
          Height = 20
          TabStop = False
          AutoSize = False
          ImeMode = imDisable
          TabOrder = 1
          OnChange = RcvdRSTEdit1Change
          OnKeyDown = EditKeyDown
          OnKeyPress = EditKeyPress
        end
        object BandEdit2C: TEdit
          Tag = 3
          Left = 286
          Top = 4
          Width = 50
          Height = 20
          TabStop = False
          AutoSize = False
          ImeMode = imDisable
          PopupMenu = BandMenu
          ReadOnly = True
          TabOrder = 3
          OnClick = BandEdit1Click
          OnKeyDown = EditKeyDown
        end
        object ModeEdit2C: TEdit
          Tag = 3
          Left = 339
          Top = 4
          Width = 50
          Height = 20
          TabStop = False
          AutoSize = False
          ImeMode = imDisable
          PopupMenu = ModeMenu
          ReadOnly = True
          TabOrder = 4
          OnClick = ModeEdit1Click
          OnKeyDown = EditKeyDown
        end
        object SerialEdit2C: TEdit
          Tag = 3
          Left = 392
          Top = 4
          Width = 45
          Height = 20
          TabStop = False
          AutoSize = False
          ImeMode = imDisable
          TabOrder = 5
          Visible = False
          OnChange = SerialEdit1Change
          OnKeyDown = EditKeyDown
        end
        object checkUseRig3: TCheckBox
          Left = 7
          Top = 6
          Width = 18
          Height = 15
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 8
          OnClick = checkUseRig3Click
        end
        object checkWithRig1: TCheckBox
          Left = 451
          Top = 6
          Width = 34
          Height = 15
          TabStop = False
          Anchors = [akTop, akRight]
          Caption = 'A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnClick = checkWithRigClick
          ExplicitLeft = 447
        end
        object checkWithRig2: TCheckBox
          Tag = 1
          Left = 488
          Top = 6
          Width = 34
          Height = 15
          TabStop = False
          Anchors = [akTop, akRight]
          Caption = 'B'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial Black'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnClick = checkWithRigClick
          ExplicitLeft = 484
        end
      end
      object EditUpperLeftPanel: TPanel
        Left = 1
        Top = 1
        Width = 65
        Height = 53
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object DateEdit2: TOvrEdit
          Left = 5
          Top = 27
          Width = 57
          Height = 20
          TabStop = False
          AutoSize = False
          ImeMode = imDisable
          TabOrder = 0
          Text = 'date'
          Visible = False
          OnChange = DateEdit1Change
          OnDblClick = TimeEdit1DblClick
          OnKeyDown = EditKeyDown
          OnKeyPress = EditKeyPress
          TabOnEnter = False
        end
        object TimeEdit2: TOvrEdit
          Left = 5
          Top = 27
          Width = 57
          Height = 20
          TabStop = False
          AutoSize = False
          ImeMode = imDisable
          TabOrder = 1
          Text = 'TIME'
          OnChange = TimeEdit1Change
          OnDblClick = TimeEdit1DblClick
          OnKeyDown = EditKeyDown
          OnKeyPress = EditKeyPress
          TabOnEnter = False
        end
      end
      object EditUpperRightPanel: TGridPanel
        Left = 66
        Top = 1
        Width = 461
        Height = 53
        Align = alClient
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 50
          end
          item
            Value = 50
          end>
        ControlCollection = <
          item
            Column = 0
            Control = RigPanelA
            Row = 0
          end
          item
            Column = 1
            Control = RigPanelB
            Row = 0
          end>
        RowCollection = <
          item
            Value = 100
          end>
        TabOrder = 2
        ExplicitWidth = 457
        object RigPanelA: TPanel
          Left = 0
          Top = 0
          Width = 230
          Height = 53
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object RigPanelShape2A: TShape
            Tag = 1
            Left = 0
            Top = 0
            Width = 230
            Height = 53
            Align = alClient
            Brush.Style = bsClear
            Pen.Width = 2
            ExplicitLeft = -1
            ExplicitWidth = 217
            ExplicitHeight = 51
          end
          object ledTx2A: TJvLED
            Left = 6
            Top = 28
            ColorOff = clSilver
            Status = False
          end
          object labelRig1Title: TLabel
            Left = 6
            Top = 5
            Width = 40
            Height = 18
            Caption = 'RIG-A'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial Black'
            Font.Style = []
            ParentFont = False
          end
          object CallsignEdit2A: TOvrEdit
            Tag = 1
            Left = 28
            Top = 27
            Width = 80
            Height = 20
            TabStop = False
            AutoSelect = False
            AutoSize = False
            CharCase = ecUpperCase
            ImeMode = imDisable
            TabOrder = 0
            OnChange = CallsignEdit1Change
            OnEnter = EditEnter
            OnExit = EditExit
            OnKeyDown = EditKeyDown
            OnKeyPress = EditKeyPress
            OnKeyUp = CallsignEdit1KeyUp
            TabOnEnter = False
          end
          object NumberEdit2A: TOvrEdit
            Tag = 1
            Left = 148
            Top = 27
            Width = 70
            Height = 20
            TabStop = False
            AutoSelect = False
            AutoSize = False
            CharCase = ecUpperCase
            ImeMode = imDisable
            TabOrder = 2
            OnChange = NumberEdit1Change
            OnEnter = EditEnter
            OnExit = EditExit
            OnKeyDown = EditKeyDown
            OnKeyPress = EditKeyPress
            OnKeyUp = NumberEdit1KeyUp
            TabOnEnter = False
          end
          object RcvdRSTEdit2A: TEdit
            Tag = 1
            Left = 111
            Top = 27
            Width = 34
            Height = 20
            TabStop = False
            AutoSize = False
            ImeMode = imDisable
            TabOrder = 1
            OnChange = RcvdRSTEdit1Change
            OnKeyDown = EditKeyDown
            OnKeyPress = EditKeyPress
          end
          object BandEdit2A: TEdit
            Tag = 1
            Left = 111
            Top = 5
            Width = 50
            Height = 20
            TabStop = False
            AutoSize = False
            ImeMode = imDisable
            PopupMenu = BandMenu
            ReadOnly = True
            TabOrder = 3
            OnClick = BandEdit1Click
            OnKeyDown = EditKeyDown
          end
          object ModeEdit2A: TEdit
            Tag = 1
            Left = 165
            Top = 5
            Width = 50
            Height = 20
            TabStop = False
            AutoSize = False
            ImeMode = imDisable
            PopupMenu = ModeMenu
            ReadOnly = True
            TabOrder = 4
            OnClick = ModeEdit1Click
            OnKeyDown = EditKeyDown
          end
          object SerialEdit2A: TEdit
            Tag = 1
            Left = 63
            Top = 5
            Width = 45
            Height = 20
            TabStop = False
            AutoSize = False
            ImeMode = imDisable
            TabOrder = 5
            Visible = False
            OnChange = SerialEdit1Change
            OnKeyDown = EditKeyDown
          end
        end
        object RigPanelB: TPanel
          Left = 230
          Top = 0
          Width = 231
          Height = 53
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object RigPanelShape2B: TShape
            Tag = 2
            Left = 0
            Top = 0
            Width = 231
            Height = 53
            Align = alClient
            Brush.Style = bsClear
            Pen.Width = 2
            ExplicitLeft = -1
            ExplicitWidth = 217
            ExplicitHeight = 51
          end
          object ledTx2B: TJvLED
            Left = 6
            Top = 28
            ColorOff = clSilver
            Status = False
          end
          object labelRig2Title: TLabel
            Left = 5
            Top = 5
            Width = 40
            Height = 18
            Caption = 'RIG-B'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial Black'
            Font.Style = []
            ParentFont = False
          end
          object CallsignEdit2B: TOvrEdit
            Tag = 2
            Left = 28
            Top = 27
            Width = 80
            Height = 20
            TabStop = False
            AutoSelect = False
            AutoSize = False
            CharCase = ecUpperCase
            ImeMode = imDisable
            TabOrder = 0
            OnChange = CallsignEdit1Change
            OnEnter = EditEnter
            OnExit = EditExit
            OnKeyDown = EditKeyDown
            OnKeyPress = EditKeyPress
            OnKeyUp = CallsignEdit1KeyUp
            TabOnEnter = False
          end
          object NumberEdit2B: TOvrEdit
            Tag = 2
            Left = 148
            Top = 27
            Width = 70
            Height = 20
            TabStop = False
            AutoSelect = False
            AutoSize = False
            CharCase = ecUpperCase
            ImeMode = imDisable
            TabOrder = 1
            OnChange = NumberEdit1Change
            OnEnter = EditEnter
            OnExit = EditExit
            OnKeyDown = EditKeyDown
            OnKeyPress = EditKeyPress
            OnKeyUp = NumberEdit1KeyUp
            TabOnEnter = False
          end
          object RcvdRSTEdit2B: TEdit
            Tag = 2
            Left = 111
            Top = 27
            Width = 34
            Height = 20
            TabStop = False
            AutoSize = False
            ImeMode = imDisable
            TabOrder = 2
            OnChange = RcvdRSTEdit1Change
            OnKeyDown = EditKeyDown
            OnKeyPress = EditKeyPress
          end
          object BandEdit2B: TEdit
            Tag = 2
            Left = 111
            Top = 5
            Width = 50
            Height = 20
            TabStop = False
            AutoSize = False
            ImeMode = imDisable
            PopupMenu = BandMenu
            ReadOnly = True
            TabOrder = 3
            OnClick = BandEdit1Click
            OnKeyDown = EditKeyDown
          end
          object ModeEdit2B: TEdit
            Tag = 2
            Left = 165
            Top = 5
            Width = 50
            Height = 20
            TabStop = False
            AutoSize = False
            ImeMode = imDisable
            PopupMenu = ModeMenu
            ReadOnly = True
            TabOrder = 4
            OnClick = ModeEdit1Click
            OnKeyDown = EditKeyDown
          end
          object SerialEdit2B: TEdit
            Tag = 2
            Left = 63
            Top = 5
            Width = 45
            Height = 20
            TabStop = False
            AutoSize = False
            ImeMode = imDisable
            TabOrder = 5
            Visible = False
            OnChange = SerialEdit1Change
            OnKeyDown = EditKeyDown
          end
        end
      end
    end
    object Grid: TStringGrid
      Left = 0
      Top = 0
      Width = 528
      Height = 171
      TabStop = False
      Align = alClient
      ColCount = 10
      DefaultRowHeight = 16
      FixedCols = 0
      RowCount = 101
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect, goThumbTracking]
      ParentFont = False
      PopupMenu = GridMenu
      ScrollBars = ssVertical
      TabOrder = 2
      OnClick = GridClick
      OnDblClick = GridDblClick
      OnEnter = GridEnter
      OnExit = GridExit
      OnKeyDown = GridKeyDown
      OnKeyPress = GridKeyPress
      OnMouseUp = GridMouseUp
      OnSelectCell = GridSelectCell
      OnTopLeftChanged = GridTopLeftChanged
      ExplicitWidth = 524
      ExplicitHeight = 170
      ColWidths = (
        38
        65
        37
        44
        36
        33
        46
        64
        64
        64)
      RowHeights = (
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16
        16)
    end
  end
  object ToolBarPanel: TPanel
    Left = 0
    Top = 0
    Width = 528
    Height = 66
    Align = alTop
    BevelOuter = bvNone
    DoubleBuffered = False
    ParentDoubleBuffered = False
    TabOrder = 2
    ExplicitWidth = 524
    object CWToolBar: TPanel
      Left = 0
      Top = 0
      Width = 528
      Height = 33
      Align = alTop
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Visible = False
      ExplicitWidth = 524
      object CWStopButton: TSpeedButton
        Left = 312
        Top = 4
        Width = 25
        Height = 25
        Hint = 'Stop CW'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          333333333333333333333333333333333333333333333333333333333FFFFFFF
          333333333FFFFFFF333333339999999F333333338888888F333333339999999F
          333333338888888F333333339999999F333333338888888F333333339999999F
          333333338888888F333333339999999F333333338888888F333333339999999F
          333333338888888F333333339999999333333333888888833333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        OnClick = CWStopButtonClick
      end
      object CWPauseButton: TSpeedButton
        Left = 336
        Top = 4
        Width = 25
        Height = 25
        Hint = 'Pause CW'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          333333333333333333333333FFF33FFF33333333FFF333FFF333333999F3999F
          3333333888F33888F333333999F3999F3333333888F33888F333333999F3999F
          3333333888F33888F333333999F3999F3333333888F33888F333333999F3999F
          3333333888F33888F333333999F3999F3333333888F33888F333333999F3999F
          3333333888F33888F33333399933999333333338883338883333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        OnClick = CWPauseButtonClick
      end
      object buttonCwKeyboard: TSpeedButton
        Left = 390
        Top = 4
        Width = 25
        Height = 25
        Hint = 'CW keyboard'
        Glyph.Data = {
          42010000424D4201000000000000760000002800000011000000110000000100
          040000000000CC00000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
          DDDDD0000000DDDDDDDDDDDDDDDDD0000000DDDDDDDDDDDDDDDDD0000000DDDD
          DDDDDDDDDDDDD0000000DDDDD0000000000000000000DDDDD000000000000000
          0000DDDDD00000000000000000008888DDBDFFD000DFF0000000D0088DBDFFD0
          00DFF0000000D00D888888800088800000000000D8888880F08880000000D00D
          DDDDFFD000DFF0000000DDDDDDDDDDDD0DDDD0000000DDDDDDDDDDDDDDDDD000
          0000DDDDDDDDDDDDDDDDD0000000DDDDDDDDDDDDDDDDD0000000DDDDDDDDDDDD
          DDDDD0000000}
        OnClick = buttonCwKeyboardClick
      end
      object SpeedLabel: TLabel
        Left = 476
        Top = 9
        Width = 44
        Height = 15
        Caption = '25 wpm'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object CWPlayButton: TSpeedButton
        Left = 336
        Top = 4
        Width = 25
        Height = 25
        Hint = 'Resume CW'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          333333333333333333333333333F333333333333333F333333333333339FF333
          33333333338FF333333333333399FF33333333333388FF333333333333999FF3
          3333333333888FF333333333339999FF33333333338888FF3333333333999993
          3333333333888883333333333399993333333333338888333333333333999333
          3333333333888333333333333399333333333333338833333333333333933333
          3333333333833333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        Visible = False
        OnClick = CWPlayButtonClick
      end
      object CWF1: THemisphereButton
        Tag = 1
        Left = 4
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '1'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CWFButtonClick
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C002C002
          C002000000008002600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E002E002E00200000000C002A00260022002E001C0018001DE7BBD77
          200010421042000300030003000300030003000000000003C002800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300030003000000000003
          C002800240022002E001A0019C739C730800CE39CE3920032003200320030000
          2003000000000003E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400300000000000000000003E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400340030000000000000003E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600340034003000000000003
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010001
          200100000000400160018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E000E000E00000000000000120016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C000C000C00000000000C000000140018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C000C000C00000000000C000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A0000000
          A00000000000C000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          8000800080000000000000000000C000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD358000800080008000000000000000C000E000000140018001
          A001396739675A6B1600ADB5AD35AD356000600080008000800000000000C000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object CWF2: THemisphereButton
        Tag = 2
        Left = 22
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '2'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CWFButtonClick
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C0020000
          0000000000000000600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E00200000000E002C002C002A00260022002E001C0018001DE7BBD77
          200010421042000300030003000300030000000000030003C002800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300030003000000000003
          C002800240022002E001A0019C739C730800CE39CE3920032003200320032003
          2003200300000000E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400340032003200300000000E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400300000000200300000000E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600340030000000000000003
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010000
          000000000000000060018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E00000000000E0000001000120016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C000C00000000000C000C000000140018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C000C000C00000000000C000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A000A000
          A000A00000000000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          8000800080008000A000A00000000000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD3580008000800000000000A00000000000E000000140018001
          A001396739675A6B1600ADB5AD35AD356000600080008000000000000000C000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object CWF3: THemisphereButton
        Tag = 3
        Left = 40
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '3'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CWFButtonClick
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C002C002
          0000000000008002600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E00200000000E00200000000A00260022002E001C0018001DE7BBD77
          200010421042000300030003000300030003000300000000C002800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300030003000300000000
          C002800240022002E001A0019C739C730800CE39CE3920032003200320032003
          2003000000000003E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400340032003200300000000E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400300000000200300000000E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600340030000000000000003
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010001
          000000000000400160018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E00000000000E0000000000020016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C000C000C000C00000000000000140018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C000C000C000C00000000000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A000A000
          A00000000000C000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          8000800080008000A000A00000000000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD3580008000800000000000A00000000000E000000140018001
          A001396739675A6B1600ADB5AD35AD356000600080008000000000000000C000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object CWF4: THemisphereButton
        Tag = 4
        Left = 58
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '4'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CWFButtonClick
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C002C002
          C002A00200000000600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E002E002E002E00200000000A00260022002E001C0018001DE7BBD77
          2000104210420003000300030003000000000000000000000000800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300000003000300000000
          C002800240022002E001A0019C739C730800CE39CE3920032003200320032003
          0000200300000000E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400340030000200300000000E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400340034003000000000000E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600340034003200300000000
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010001
          200120010000000060018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E000E000E000E0000000000020016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C00000000000000000000000000040018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C0000000C000C00000000000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A000A000
          0000A00000000000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          80008000800080000000A00000000000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD3580008000800080008000000000000000E000000140018001
          A001396739675A6B1600ADB5AD35AD3560006000800080008000A00000000000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object CWF5: THemisphereButton
        Tag = 5
        Left = 77
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '5'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CWFButtonClick
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C002C002
          0000000000008002600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E00200000000E00200000000A00260022002E001C0018001DE7BBD77
          200010421042000300030003000300030003000300000000C002800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300000003000300000000
          C002800240022002E001A0019C739C730800CE39CE3920032003200320030000
          0000000000000003E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400300000000200300030003E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400340030000000000030003E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600340030000000000000000
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010001
          000000000000400160018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E00000000000E0000000000020016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C000C000C000C00000000000000140018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C0000000C000C00000000000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A0000000
          000000000000C000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          80008000800000000000A000C000C000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD35800080008000800000000000C000C000E000000140018001
          A001396739675A6B1600ADB5AD35AD3560006000800080000000000000000000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object CWF6: THemisphereButton
        Tag = 6
        Left = 95
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '6'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CWFButtonClick
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C002C002
          0000000000008002600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E00200000000E00200000000A00260022002E001C0018001DE7BBD77
          200010421042000300030003000300000000000300000000C002800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300000000000300000000
          C002800240022002E001A0019C739C730800CE39CE3920032003200320030000
          0000000000000003E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400300000000200300030003E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400300000000200300000000E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600340030000000000000003
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010001
          000000000000400160018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E00000000000E0000000000020016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C00000000000C00000000000000140018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C00000000000C00000000000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A0000000
          000000000000C000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          80008000800000000000A000C000C000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD3580008000800000000000A00000000000E000000140018001
          A001396739675A6B1600ADB5AD35AD356000600080008000000000000000C000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object CWF7: THemisphereButton
        Tag = 7
        Left = 113
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '7'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CWFButtonClick
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C002C002
          0000000080028002600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E002E00200000000C002C002A00260022002E001C0018001DE7BBD77
          200010421042000300030003000300030000000000030003C002800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300030000000000030003
          C002800240022002E001A0019C739C730800CE39CE3920032003200320032003
          2003000000000003E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400340032003000000000003E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400340034003200300000000E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600300000000000000000000
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010001
          000000004001400160018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E000E000000000000001000120016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C000C00000000000C000C000000140018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C000C00000000000C000C000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A000A000
          A00000000000C000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          8000800080008000A00000000000C000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD3580008000800080008000A00000000000E000000140018001
          A001396739675A6B1600ADB5AD35AD3560006000800000000000000000000000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object CWF8: THemisphereButton
        Tag = 8
        Left = 131
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '8'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CWFButtonClick
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C002C002
          0000000000008002600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E00200000000E00200000000A00260022002E001C0018001DE7BBD77
          200010421042000300030003000300000000000300000000C002800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300000000000300000000
          C002800240022002E001A0019C739C730800CE39CE3920032003200320032003
          0000000000000003E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400300000000200300000000E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400300000000200300000000E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600340030000000000000003
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010001
          000000000000400160018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E00000000000E0000000000020016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C00000000000C00000000000000140018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C00000000000C00000000000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A000A000
          000000000000C000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          80008000800000000000A00000000000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD3580008000800000000000A00000000000E000000140018001
          A001396739675A6B1600ADB5AD35AD356000600080008000000000000000C000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object CWCQ1: THemisphereButton
        Tag = 101
        Left = 225
        Top = 3
        Width = 28
        Height = 28
        Hint = 'CQ once'
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = 'CQ'
        Down = False
        FaceColor = clPurple
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CWFButtonClick
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFFFFFFFFFFFFF39E739E75AEB5A6B7B6F7B6F9C739C739C73
          BD77BD77BD77DE7BDE7BDEFBDEFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF18E3396739675A6B5A6B7B6F9C739C739C73BD77BD77BD77DE7B
          DE7BDE7BDE7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF7DEF75E1863
          396739675A6B0C300B2C0B2C0A280A28092408200820DE7BDE7BDE7BFF7FFF7F
          FF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF75EF75E186318630E380E380D34
          0D340C300C300B2C0A280A2809240820071CDE7BFF7FFF7FFF7FFF7FFFFFFFFF
          FFFFFFFFB5D6B5D6D6DAD65AF75EF75E0F3C0F3C0F3C0F3C0E380E380D340C30
          0C300B2C0A2809240820071CFF7FFF7FFF7FFF7FFFFFFFFFFFFFFFFF94D2B5D6
          B556D65AD65A114411441040104010400F3C0F3C0E380E380D340C300B2C0A28
          09240820071CFF7FFF7FFF7FFF7FFFFFFFFF73CE94D29452B556B55612481248
          12481248114411441144104010400F3C0E380E380D340C300B2C0A280924071C
          FF7FFF7FFF7FFF7FFFFF73CE73CE94529452134C134C134C134C134C12481248
          124811441144104010400F3C0E380D340C300B2C0A280820071CFF7FFF7FFF7F
          DEFB52CA734E734E1450145014501450145014501450134C134C134C12481248
          114410400F3C0E380D340C300B2C09240820071CDE7BDE7BDE7B52CA524A524A
          15541554155415541554155415541554145014501450134C1248114410400F3C
          0E380D340C300A2809240820DE7BDE7BDE7B31C6314616581658165816581658
          165816581658165816581554155414501450134C1248104000000E380D340B2C
          0A2809240820DE7BDE7B10C21042175C175C175C175C175C0000000000000000
          175C165816581658000000000000000010400F3C0E380C300B2C0A280820BD77
          BD7710C210421860186018601860000000001860186000000000175C175C0000
          0000155400000000114410400E380D340C300A280924BD77BD7710C210421860
          186018600000000018601860186018601860186000000000175C000014500000
          000010400F3C0E380C300B2C0A28BD77BD77EFBDEF3D19641964196400000000
          19641964196419641964196400000000175C1658155400000000114410400E38
          0D340C300A289C739C73CEB9CE391A681A681964000000001964196419641964
          1964196400000000175C1658155400000000114410400F3C0E380C300B2C7B6F
          7B6FCEB9CE391A681A681A68000000001A681A681A681A681964196400000000
          1860175C165800000000124811440F3C0E380D340B2C7B6F7B6FADB5AD351B6C
          1A681A681A68000000001A681A68000000001964196400000000175C00000000
          134C1248114410400F3C0D340C305A6B5A6BADB5AD35AD351B6C1B6C1B6C1B6C
          00000000000000001A6819641964186000000000000015541450124811441040
          0F3C0E38396739673967ADB5ADB5AD351B6C1B6C1B6C1B6C1B6C1B6C1A681A68
          1A681964196418601860175C165815541450134C124810400F3C0E3818633967
          39E7ADB5ADB5AD358C311B6C1B6C1B6C1B6C1B6C1B6C1A681A68196419641860
          1860175C165815541450134C124811440F3CF75E1863186318E3ADB5ADB58CB1
          8C318C311C701B6C1B6C1B6C1B6C1A681A681964196418601860175C16581554
          1450134C12481144D65AF75EF75EF7DE18E3FFFF8CB18CB18CB18C318C311C70
          1B6C1B6C1B6C1A681A681964196418601860175C165815541450134C1248B556
          D65AD65AF7DEF7DEFFFFFFFF8CB18CB18CB18C318C318C311B6C1B6C1B6C1A68
          1A681964196418601860175C165815541450134C9452B556B556D65AD6DAD6DA
          FFFFFFFFFFFFFFFF8CB18CB18C31AD35AD351B6C1B6C1A681A681A6819641860
          1860175C165815541450734E94529452B556B5D6FFFFFFFFFFFFFFFFFFFFFFFF
          8CB18CB1ADB5ADB5AD35AD35AD351B6C1A681A68196418601860175C16583146
          524A734E734E94D294D2B5D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5
          ADB5ADB5AD35CE39CE39EF3DEF3DEF3D1042104231463146524A52CA73CEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5ADB5ADB5CEB9CEB9
          CEB9EFBDEFBDEFBD10C210C231C631C652CA52CA73CEFFFFFFFFFFFFFFFFFFFF
          FFFF}
        ImageIn = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFFFFFFFFFFFFF39E739E75AEB5A6B7B6F7B6F9C739C739C73
          BD77BD77BD77DE7BDE7BDEFBDEFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF18E3396739675A6B5A6B7B6F9C739C739C73BD77BD77BD77DE7B
          DE7BDE7BDE7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF7DEF75E1863
          396739675A6B1248134C134C1450145015541658175CDE7BDE7BDE7BFF7FFF7F
          FF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF75EF75E18631863104011441144
          114412481248134C1450145015541658175CDE7BFF7FFF7FFF7FFF7FFFFFFFFF
          FFFFFFFFB5D6B5D6D6DAD65AF75EF75E0F3C0F3C0F3C10401040114411441248
          1248134C145015541658175CFF7FFF7FFF7FFF7FFFFFFFFFFFFFFFFF94D2B5D6
          B556D65AD65A0D340D340E380E380E380F3C0F3C1040104011441248134C1450
          15541658175CFF7FFF7FFF7FFF7FFFFFFFFF73CE94D29452B556B5560C300C30
          0C300D340D340D340D340E380E380F3C1040114411441248134C14501658175C
          FF7FFF7FFF7FFF7FFFFF73CE73CE945294520B2C0B2C0B2C0B2C0B2C0C300C30
          0C300D340D340E380E380F3C104011441248134C14501658175CFF7FFF7FFF7F
          DEFB52CA734E734E0A280A280A280A280A280A280A280B2C0B2C0B2C0C300C30
          0D340E380F3C104011441248134C15541658175CDE7BDE7BDE7B52CA524A524A
          09240924092409240924092409240A280A280A280B2C0B2C0C300D340E380F3C
          104011441248145015541658DE7BDE7BDE7B31C6314608200820082008200820
          08200820082008200924092409240A280B2C0C300D340E38000010401144134C
          14501554175CDE7BDE7B10C21042071C071C071C071C071C0000000000000000
          082008200820082000000000000000000E380F3C11441248134C14501658BD77
          BD7710C21042071C071C071C071C00000000071C071C00000000071C071C0000
          00000924000000000D340E3810401144124814501554BD77BD7710C210420618
          061806180000000006180618061806180618061800000000071C00000A280000
          00000E380F3C10401248134C1450BD77BD77EFBDEF3D05140514051400000000
          05140514051405140514051400000000071C08200924000000000D340E381040
          1144124814509C739C73CEB9CE39051405140514000000000514051405140514
          0514051400000000071C08200924000000000D340E380F3C11441248134C7B6F
          7B6FCEB9CE390410041004100000000004100410041005140514051400000000
          071C08200924000000000C300D340F3C10401144134C7B6F7B6FADB5AD350410
          0410041004100000000004100410000000000514051400000000071C00000000
          0B2C0C300D340E381040114412485A6B5A6BADB5AD35AD35030C030C030C030C
          0000000000000000041005140514061800000000000009240A280C300D340E38
          0F3C1144396739673967ADB5ADB5AD35030C030C030C030C030C041004100410
          0410051405140618071C071C082009240A280B2C0D340E380F3C104018633967
          39E7ADB5ADB5AD358C31030C030C030C030C030C041004100410051405140618
          071C071C082009240A280B2C0C300D340F3CF75E1863186318E3ADB5ADB58CB1
          8C318C31030C030C030C030C030C04100410051405140618071C071C08200924
          0A280B2C0C300D34D65AF75EF75EF7DE18E3FFFF8CB18CB18CB18C318C31030C
          030C030C030C04100410051405140618071C071C082009240A280B2C0C30B556
          D65AD65AF7DEF7DEFFFFFFFF8CB18CB18CB18C318C318C31030C030C030C0410
          0410051405140618071C071C082009240A280B2C9452B556B556D65AD6DAD6DA
          FFFFFFFFFFFFFFFF8CB18CB18C31AD35AD35030C030C04100410051405140618
          071C071C082009240A28734E94529452B556B5D6FFFFFFFFFFFFFFFFFFFFFFFF
          8CB18CB1ADB5ADB5AD35AD35AD3504100410051405140618071C071C08203146
          524A734E734E94D294D2B5D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5
          ADB5ADB5AD35CE39CE39EF3DEF3DEF3D1042104231463146524A52CA73CEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5ADB5ADB5CEB9CEB9
          CEB9EFBDEFBDEFBD10C210C231C631C652CA52CA73CEFFFFFFFFFFFFFFFFFFFF
          FFFF}
        ImageMask = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7F000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
          000000000000000000000000000000000000000000000000000000000000FF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000FF7FFF7FFF7FFF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000FF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          FF7FFF7F00000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7F00000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF7F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF7F000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000FF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          FF7FFF7F00000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7FFF7F0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF7FFF7FFF7FFF7FFF7F0000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          00000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7F0000000000000000000000000000000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
          0000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7F}
      end
      object CWCQ2: THemisphereButton
        Tag = 102
        Left = 253
        Top = 3
        Width = 28
        Height = 28
        Hint = 'Repeat CQ, hit ESC to stop'
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = 'CQ~'
        Down = False
        FaceColor = clOlive
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CQRepeatClick1
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFFFFFFFFFFFFF39E739E75AEB5A6B7B6F7B6F9C739C739C73
          BD77BD77BD77DE7BDE7BDEFBDEFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF18E3396739675A6B5A6B7B6F9C739C739C73BD77BD77BD77DE7B
          DE7BDE7BDE7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF7DEF75E1863
          396739675A6B8031602D602D40294029202500210021DE7BDE7BDE7BFF7FFF7F
          FF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF75EF75E18631863C039C039A035
          A03580318031602D4029402920250021E01CDE7BFF7FFF7FFF7FFF7FFFFFFFFF
          FFFFFFFFB5D6B5D6D6DAD65AF75EF75EE03DE03DE03DE03DC039C039A0358031
          8031602D402920250021E01CFF7FFF7FFF7FFF7FFFFFFFFFFFFFFFFF94D2B5D6
          B556D65AD65A20462046004200420042E03DE03DC039C039A0358031602D4029
          20250021E01CFF7FFF7FFF7FFF7FFFFFFFFF73CE94D29452B556B556404A404A
          404A404A20462046204600420042E03DC039C039A0358031602D40292025E01C
          FF7FFF7FFF7FFF7FFFFF73CE73CE94529452604E604E604E604E604E404A404A
          404A2046204600420042E03DC039A0358031602D40290021E01CFF7FFF7FFF7F
          DEFB52CA734E734E8052805280528052805280528052604E604E604E404A404A
          20460042E03DC039A0358031602D20250021E01CDE7BDE7BDE7B52CA524A524A
          A056A056A056A056A056A056A056A056805280528052604E404A20460042E03D
          C039A0358031402920250021DE7BDE7BDE7B31C63146C05AC05AC05AC05AC05A
          C05AC05AC05AC05AC05AA056A056805280520000404A0042E03DC039A035602D
          402920250021DE7BDE7B10C21042E05EE05E0000000000000000E05EE05EE05E
          E05E00000000000000008052604E20460042E03DC0398031602D40290021BD77
          BD7710C2104200630000000000630063000000000063006300000000E05E0000
          0000A0568052404A20460042C039A035803140292025BD77BD7710C210420000
          000000630063006300630063006300000000006300000063000000008052604E
          404A0042E03DC0398031602D4029BD77BD77EFBDEF3D00000000206720672067
          2067206720670000000020672067006300000000A0560000404A20460000C039
          A035803140299C739C73CEB9CE39000000002067206720672067206720670000
          000020672067006300000000A05680520000000000420000C0398031602D7B6F
          7B6FCEB9CE3900000000406B406B406B406B406B406B00000000206720670063
          00000000C05A8052604E404A2046E03DC039A035602D7B6F7B6FADB5AD35606F
          00000000406B406B00000000406B406B00000000206700000000E05EC05AA056
          604E404A20460042E03DA03580315A6B5A6BADB5AD35AD35606F000000000000
          0000406B406B406B406B0000000000000063E05EC05AA0568052404A20460042
          E03DC039396739673967ADB5ADB5AD35606F606F606F606F606F606F406B406B
          406B2067206700630063E05EC05AA0568052604E404A0042E03DC03918633967
          39E7ADB5ADB5AD358C31606F606F606F606F606F606F406B406B206720670063
          0063E05EC05AA0568052604E404A2046E03DF75E1863186318E3ADB5ADB58CB1
          8C318C318073606F606F606F606F406B406B2067206700630063E05EC05AA056
          8052604E404A2046D65AF75EF75EF7DE18E3FFFF8CB18CB18CB18C318C318073
          606F606F606F406B406B2067206700630063E05EC05AA0568052604E404AB556
          D65AD65AF7DEF7DEFFFFFFFF8CB18CB18CB18C318C318C31606F606F606F406B
          406B2067206700630063E05EC05AA0568052604E9452B556B556D65AD6DAD6DA
          FFFFFFFFFFFFFFFF8CB18CB18C31AD35AD35606F606F406B406B406B20670063
          0063E05EC05AA0568052734E94529452B556B5D6FFFFFFFFFFFFFFFFFFFFFFFF
          8CB18CB1ADB5ADB5AD35AD35AD35606F406B406B206700630063E05EC05A3146
          524A734E734E94D294D2B5D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5
          ADB5ADB5AD35CE39CE39EF3DEF3DEF3D1042104231463146524A52CA73CEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5ADB5ADB5CEB9CEB9
          CEB9EFBDEFBDEFBD10C210C231C631C652CA52CA73CEFFFFFFFFFFFFFFFFFFFF
          FFFF}
        ImageIn = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFFFFFFFFFFFFF39E739E75AEB5A6B7B6F7B6F9C739C739C73
          BD77BD77BD77DE7BDE7BDEFBDEFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF18E3396739675A6B5A6B7B6F9C739C739C73BD77BD77BD77DE7B
          DE7BDE7BDE7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF7DEF75E1863
          396739675A6B404A604E604E80528052A056C05AE05EDE7BDE7BDE7BFF7FFF7F
          FF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF75EF75E18631863004220462046
          2046404A404A604E80528052A056C05AE05EDE7BFF7FFF7FFF7FFF7FFFFFFFFF
          FFFFFFFFB5D6B5D6D6DAD65AF75EF75EE03DE03DE03D0042004220462046404A
          404A604E8052A056C05AE05EFF7FFF7FFF7FFF7FFFFFFFFFFFFFFFFF94D2B5D6
          B556D65AD65AA035A035C039C039C039E03DE03D004200422046404A604E8052
          A056C05AE05EFF7FFF7FFF7FFF7FFFFFFFFF73CE94D29452B556B55680318031
          8031A035A035A035A035C039C039E03D004220462046404A604E8052C05AE05E
          FF7FFF7FFF7FFF7FFFFF73CE73CE94529452602D602D602D602D602D80318031
          8031A035A035C039C039E03D00422046404A604E8052C05AE05EFF7FFF7FFF7F
          DEFB52CA734E734E4029402940294029402940294029602D602D602D80318031
          A035C039E03D00422046404A604EA056C05AE05EDE7BDE7BDE7B52CA524A524A
          2025202520252025202520252025402940294029602D602D8031A035C039E03D
          00422046404A8052A056C05ADE7BDE7BDE7B31C6314600210021002100210021
          00210021002100212025202520254029602D0000A035C039E03D00422046604E
          8052A056E05EDE7BDE7B10C21042E01CE01C0000000000000000E01CE01CE01C
          0021000000000000000040298031A035C039E03D2046404A604E8052C05ABD77
          BD7710C21042E01C00000000E01CE01C00000000E01CE01C00000000E01C0000
          00002025602D8031A035C03900422046404A8052A056BD77BD7710C210420000
          0000C018C018C018C018C018C01800000000C0180000C018000000004029602D
          8031C039E03D0042404A604E8052BD77BD77EFBDEF3D00000000A014A014A014
          A014A014A01400000000A014A014C01800000000202500008031A03500000042
          2046404A80529C739C73CEB9CE3900000000A014A014A014A014A014A0140000
          0000A014A014C018000000002025402900000000C03900002046404A604E7B6F
          7B6FCEB9CE390000000080108010801080108010801000000000A014A014C018
          0000000020254029602D8031A035E03D00422046604E7B6F7B6FADB5AD358010
          0000000080108010000000008010801000000000A01400000000E01C00214029
          602D8031A035C03900422046404A5A6B5A6BADB5AD35AD35600C000000000000
          00008010801080108010000000000000E01CE01C0021202540298031A035C039
          E03D2046396739673967ADB5ADB5AD35600C600C600C600C600C801080108010
          8010A014A014C018E01CE01C002120254029602DA035C039E03D004218633967
          39E7ADB5ADB5AD358C31600C600C600C600C600C801080108010A014A014C018
          E01CE01C002120254029602D8031A035E03DF75E1863186318E3ADB5ADB58CB1
          8C318C31600C600C600C600C600C80108010A014A014C018E01CE01C00212025
          4029602D8031A035D65AF75EF75EF7DE18E3FFFF8CB18CB18CB18C318C31600C
          600C600C600C80108010A014A014C018E01CE01C002120254029602D8031B556
          D65AD65AF7DEF7DEFFFFFFFF8CB18CB18CB18C318C318C31600C600C600C8010
          8010A014A014C018E01CE01C002120254029602D9452B556B556D65AD6DAD6DA
          FFFFFFFFFFFFFFFF8CB18CB18C31AD35AD35600C600C80108010A014A014C018
          E01CE01C002120254029734E94529452B556B5D6FFFFFFFFFFFFFFFFFFFFFFFF
          8CB18CB1ADB5ADB5AD35AD35AD3580108010A014A014C018E01CE01C00213146
          524A734E734E94D294D2B5D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5
          ADB5ADB5AD35CE39CE39EF3DEF3DEF3D1042104231463146524A52CA73CEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5ADB5ADB5CEB9CEB9
          CEB9EFBDEFBDEFBD10C210C231C631C652CA52CA73CEFFFFFFFFFFFFFFFFFFFF
          FFFF}
        ImageMask = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7F000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
          000000000000000000000000000000000000000000000000000000000000FF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000FF7FFF7FFF7FFF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000FF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          FF7FFF7F00000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7F00000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF7F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF7F000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000FF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          FF7FFF7F00000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7FFF7F0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF7FFF7FFF7FFF7FFF7F0000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          00000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7F0000000000000000000000000000000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
          0000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7F}
      end
      object CWCQ3: THemisphereButton
        Tag = 103
        Left = 281
        Top = 3
        Width = 28
        Height = 28
        Hint = 'Repeat CQ, enter call sign to stop'
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = 'CQ~'
        Down = False
        FaceColor = clTeal
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CQRepeatClick2
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFFFFFFFFFFFFF39E739E75AEB5A6B7B6F7B6F9C739C739C73
          BD77BD77BD77DE7BDE7BDEFBDEFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF18E3396739675A6B5A6B7B6F9C739C739C73BD77BD77BD77DE7B
          DE7BDE7BDE7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF7DEF75E1863
          396739675A6B8C016B016B014A014A01290108010801DE7BDE7BDE7BFF7FFF7F
          FF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF75EF75E18631863CE01CE01AD01
          AD018C018C016B014A014A0129010801E700DE7BFF7FFF7FFF7FFF7FFFFFFFFF
          FFFFFFFFB5D6B5D6D6DAD65AF75EF75EEF01EF01EF01EF01CE01CE01AD018C01
          8C016B014A0129010801E700FF7FFF7FFF7FFF7FFFFFFFFFFFFFFFFF94D2B5D6
          B556D65AD65A31023102100210021002EF01EF01CE01CE01AD018C016B014A01
          29010801E700FF7FFF7FFF7FFF7FFFFFFFFF73CE94D29452B556B55652025202
          5202520231023102310210021002EF01CE01CE01AD018C016B014A012901E700
          FF7FFF7FFF7FFF7FFFFF73CE73CE945294527302730273027302730252025202
          52023102310210021002EF01CE01AD018C016B014A010801E700FF7FFF7FFF7F
          DEFB52CA734E734E940294029402940294029402940273027302730252025202
          31021002EF01CE01AD018C016B0129010801E700DE7BDE7BDE7B52CA524A524A
          B502B502B502B502B502B502B502B5029402940294027302520231021002EF01
          CE01AD018C014A0129010801DE7BDE7BDE7B31C63146D602D602D602D602D602
          D602D602D602D602D602B502B50294029402000052021002EF01CE01AD016B01
          4A0129010801DE7BDE7B10C21042F702F7020000000000000000F702F702F702
          F70200000000000000009402730231021002EF01CE018C016B014A010801BD77
          BD7710C2104218030000000018031803000000001803180300000000F7020000
          0000B5029402520231021002CE01AD018C014A012901BD77BD7710C210420000
          0000180318031803180318031803000000001803000018030000000094027302
          52021002EF01CE018C016B014A01BD77BD77EFBDEF3D00000000390339033903
          3903390339030000000039033903180300000000B5020000520231020000CE01
          AD018C014A019C739C73CEB9CE39000000003903390339033903390339030000
          000039033903180300000000B50294020000000010020000CE018C016B017B6F
          7B6FCEB9CE39000000005A035A035A035A035A035A0300000000390339031803
          00000000D6029402730252023102EF01CE01AD016B017B6F7B6FADB5AD357B03
          000000005A035A03000000005A035A0300000000390300000000F702D602B502
          7302520231021002EF01AD018C015A6B5A6BADB5AD35AD357B03000000000000
          00005A035A035A035A030000000000001803F702D602B5029402520231021002
          EF01CE01396739673967ADB5ADB5AD357B037B037B037B037B037B035A035A03
          5A033903390318031803F702D602B5029402730252021002EF01CE0118633967
          39E7ADB5ADB5AD358C317B037B037B037B037B037B035A035A03390339031803
          1803F702D602B5029402730252023102EF01F75E1863186318E3ADB5ADB58CB1
          8C318C319C037B037B037B037B035A035A033903390318031803F702D602B502
          9402730252023102D65AF75EF75EF7DE18E3FFFF8CB18CB18CB18C318C319C03
          7B037B037B035A035A033903390318031803F702D602B502940273025202B556
          D65AD65AF7DEF7DEFFFFFFFF8CB18CB18CB18C318C318C317B037B037B035A03
          5A033903390318031803F702D602B502940273029452B556B556D65AD6DAD6DA
          FFFFFFFFFFFFFFFF8CB18CB18C31AD35AD357B037B035A035A035A0339031803
          1803F702D602B5029402734E94529452B556B5D6FFFFFFFFFFFFFFFFFFFFFFFF
          8CB18CB1ADB5ADB5AD35AD35AD357B035A035A03390318031803F702D6023146
          524A734E734E94D294D2B5D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5
          ADB5ADB5AD35CE39CE39EF3DEF3DEF3D1042104231463146524A52CA73CEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5ADB5ADB5CEB9CEB9
          CEB9EFBDEFBDEFBD10C210C231C631C652CA52CA73CEFFFFFFFFFFFFFFFFFFFF
          FFFF}
        ImageIn = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFFFFFFFFFFFFF39E739E75AEB5A6B7B6F7B6F9C739C739C73
          BD77BD77BD77DE7BDE7BDEFBDEFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF18E3396739675A6B5A6B7B6F9C739C739C73BD77BD77BD77DE7B
          DE7BDE7BDE7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF7DEF75E1863
          396739675A6B52027302730294029402B502D602F702DE7BDE7BDE7BFF7FFF7F
          FF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF75EF75E18631863100231023102
          310252025202730294029402B502D602F702DE7BFF7FFF7FFF7FFF7FFFFFFFFF
          FFFFFFFFB5D6B5D6D6DAD65AF75EF75EEF01EF01EF0110021002310231025202
          520273029402B502D602F702FF7FFF7FFF7FFF7FFFFFFFFFFFFFFFFF94D2B5D6
          B556D65AD65AAD01AD01CE01CE01CE01EF01EF01100210023102520273029402
          B502D602F702FF7FFF7FFF7FFF7FFFFFFFFF73CE94D29452B556B5568C018C01
          8C01AD01AD01AD01AD01CE01CE01EF01100231023102520273029402D602F702
          FF7FFF7FFF7FFF7FFFFF73CE73CE945294526B016B016B016B016B018C018C01
          8C01AD01AD01CE01CE01EF0110023102520273029402D602F702FF7FFF7FFF7F
          DEFB52CA734E734E4A014A014A014A014A014A014A016B016B016B018C018C01
          AD01CE01EF011002310252027302B502D602F702DE7BDE7BDE7B52CA524A524A
          29012901290129012901290129014A014A014A016B016B018C01AD01CE01EF01
          1002310252029402B502D602DE7BDE7BDE7B31C6314608010801080108010801
          08010801080108012901290129014A016B010000AD01CE01EF01100231027302
          9402B502F702DE7BDE7B10C21042E700E7000000000000000000E700E700E700
          080100000000000000004A018C01AD01CE01EF013102520273029402D602BD77
          BD7710C21042E70000000000E700E70000000000E700E70000000000E7000000
          000029016B018C01AD01CE011002310252029402B502BD77BD7710C210420000
          0000C600C600C600C600C600C60000000000C6000000C600000000004A016B01
          8C01CE01EF011002520273029402BD77BD77EFBDEF3D00000000A500A500A500
          A500A500A50000000000A500A500C60000000000290100008C01AD0100001002
          3102520294029C739C73CEB9CE3900000000A500A500A500A500A500A5000000
          0000A500A500C6000000000029014A0100000000CE0100003102520273027B6F
          7B6FCEB9CE390000000084008400840084008400840000000000A500A500C600
          0000000029014A016B018C01AD01EF011002310273027B6F7B6FADB5AD358400
          0000000084008400000000008400840000000000A50000000000E70008014A01
          6B018C01AD01CE011002310252025A6B5A6BADB5AD35AD356300000000000000
          00008400840084008400000000000000E700E700080129014A018C01AD01CE01
          EF013102396739673967ADB5ADB5AD3563006300630063006300840084008400
          8400A500A500C600E700E700080129014A016B01AD01CE01EF01100218633967
          39E7ADB5ADB5AD358C3163006300630063006300840084008400A500A500C600
          E700E700080129014A016B018C01AD01EF01F75E1863186318E3ADB5ADB58CB1
          8C318C316300630063006300630084008400A500A500C600E700E70008012901
          4A016B018C01AD01D65AF75EF75EF7DE18E3FFFF8CB18CB18CB18C318C316300
          63006300630084008400A500A500C600E700E700080129014A016B018C01B556
          D65AD65AF7DEF7DEFFFFFFFF8CB18CB18CB18C318C318C316300630063008400
          8400A500A500C600E700E700080129014A016B019452B556B556D65AD6DAD6DA
          FFFFFFFFFFFFFFFF8CB18CB18C31AD35AD356300630084008400A500A500C600
          E700E700080129014A01734E94529452B556B5D6FFFFFFFFFFFFFFFFFFFFFFFF
          8CB18CB1ADB5ADB5AD35AD35AD3584008400A500A500C600E700E70008013146
          524A734E734E94D294D2B5D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5
          ADB5ADB5AD35CE39CE39EF3DEF3DEF3D1042104231463146524A52CA73CEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5ADB5ADB5CEB9CEB9
          CEB9EFBDEFBDEFBD10C210C231C631C652CA52CA73CEFFFFFFFFFFFFFFFFFFFF
          FFFF}
        ImageMask = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7F000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
          000000000000000000000000000000000000000000000000000000000000FF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000FF7FFF7FFF7FFF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000FF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          FF7FFF7F00000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7F00000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF7F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF7F000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000FF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          FF7FFF7F00000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7FFF7F0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF7FFF7FFF7FFF7FFF7F0000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          00000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7F0000000000000000000000000000000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
          0000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7F}
      end
      object CWF9: THemisphereButton
        Tag = 9
        Left = 149
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '9'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CWFButtonClick
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F0000FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F0200FF7FB556D65AF75E186339675A6B
          E001C001A001A0018001FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75E4002200220020002E001E001C001A0016001FF7FFF7FFF7FFF7FFF7F
          970194529452B556B55680026002600260024002200220020002E001A0018001
          FF7FFF7FFF7FFF7FAD02734E734E9452A002A002A002A0028002800260026002
          40020002E001A0016001FF7FFF7FFF7F6C01524A524A734EE002C002C002C002
          600000000000C001800240020002E001A001FF7FFF7FDE7B0600314631460003
          00030003000300020000E001E00100004002800240020002C0018001DE7BDE7B
          200010421042200320032003200320032003200320030000E001A00260022002
          E001A001BD77BD77020010421042200320032003200320030001000000008000
          6001A00260022002E001A001BD77BD770800EF3DEF3D4003400340034003A001
          0000A002A00200008001C002800240020002C0019C739C730200CE39CE394003
          400340034003000100004003200300008001C002800260022002E0017B6F7B6F
          7D02CE39CE39CE39600360036003A0010000A002000200008002C002A0026002
          20025A6B5A6B5A6BBF03AD35AD35AD3580036003600360030001000000000002
          0003C002A002600240023967396739670300AD35AD35AD35AD35800360036003
          40034003200320030003C002A0028002F75E1863186339675A01AD35AD35AD35
          AD35AD358003600340034003200320030003E002A002B556D65AF75EF75E1863
          B481FF7FAD35AD35AD35AD35AD35CE3940034003200320030003734E9452B556
          B556D65AF75EFF7F2000FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F3E01FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7F3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F2201FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F3E01FF7FB556D65AF75E186339675A6B
          00022002400240026002FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75EC001C001C001E00100020002200240028002FF7FFF7FFF7FFF7FFF7F
          BF0394529452B556B556800180018001A001A001C001C001E001200240028002
          FF7FFF7FFF7FFF7F0200734E734E945240014001400140016001600180018001
          A001E001000240028002FF7FFF7FFF7F0200524A524A734E2001200120012001
          200000000000E0006001A001E00120024002FF7FFF7FDE7B9B0131463146E000
          E000E000E000A0000000A000A000000000016001A001E00120026002DE7BDE7B
          7B0310421042C000C000C000C000C000C000C000C0000000A00040018001C001
          00024002BD77BD773E0110421042C000C000C000C000C0004000000000002000
          800040018001C00100024002BD77BD777200EF3DEF3DA000A000A000A0006000
          0000A000A0000000800020016001A001E00120029C739C731300CE39CE39A000
          A000A000A00020000000C000C0000000800020016001A001C00100027B6F7B6F
          B400CE39CE39CE3980008000800040000000A00080000000C000200140018001
          C0015A6B5A6B5A6B1600AD35AD35AD3580008000800080002000000000008000
          E000200140018001C001396739673967EE00AD35AD35AD35AD35600080008000
          A000A000C000C000E000200140018001F75E1863186339672201AD35AD35AD35
          AD35AD3580008000A000A000C000C000E00020014001B556D65AF75EF75E1863
          0200FF7FAD35AD35AD35AD35AD35CE39A000A000C000C000E000734E9452B556
          B556D65AF75EFF7F1E00FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F9800FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7FB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object CWF10: THemisphereButton
        Tag = 10
        Left = 167
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '10'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CWFButtonClick
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F0000FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F0200FF7FB556D65AF75E186339675A6B
          E001C001A001A0018001FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75E4002200220020002E001E001C001A0016001FF7FFF7FFF7FFF7FFF7F
          970194529452B556B55680026002600260024002200220020002E001A0018001
          FF7FFF7FFF7FFF7FAD02734E734E9452A002A002A002A0028002800260026002
          40020002E001A0016001FF7FFF7FFF7F6C01524A524A734EE002E0010000E001
          C002C00240010000000080010002E001A001FF7FFF7FDE7B0600314631460003
          0003000200000002000360020000E001C0010000E0010002C0018001DE7BDE7B
          2000104210422003200300020000000220038001000020036002000080012002
          E001A001BD77BD77020010421042200320030002000000022003000100002003
          6002000020012002E001A001BD77BD770800EF3DEF3DA0020001200200002002
          400300010000200360020000400140020002C0019C739C730200CE39CE39C002
          00000000000020024003A0010000200380020000A00160022002E0017B6F7B6F
          7D02CE39CE39CE39C0020000000040024003A0020000A0020002000020026002
          20025A6B5A6B5A6BBF03AD35AD35AD358003E002000040024003400380010000
          0000E001A002600240023967396739670300AD35AD35AD35AD35800360036003
          40034003200320030003C002A0028002F75E1863186339675A01AD35AD35AD35
          AD35AD358003600340034003200320030003E002A002B556D65AF75EF75E1863
          B481FF7FAD35AD35AD35AD35AD35CE3940034003200320030003734E9452B556
          B556D65AF75EFF7F2000FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F3E01FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7F3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F2201FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F3E01FF7FB556D65AF75E186339675A6B
          00022002400240026002FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75EC001C001C001E00100020002200240028002FF7FFF7FFF7FFF7FFF7F
          BF0394529452B556B556800180018001A001A001C001C001E001200240028002
          FF7FFF7FFF7FFF7F0200734E734E945240014001400140016001600180018001
          A001E001000240028002FF7FFF7FFF7F0200524A524A734E2001C0000000C000
          20012001A000000000000001E00120024002FF7FFF7FDE7B9B0131463146E000
          E000A0000000A0000001C0000000A000C00000006001E00120026002DE7BDE7B
          7B0310421042C000C000800000008000C00060000000C000E00000000001C001
          00024002BD77BD773E0110421042C000C000800000008000C00040000000C000
          E0000000C000C00100024002BD77BD777200EF3DEF3D80004000600000008000
          C00040000000C000C0000000A000A001E00120029C739C731300CE39CE398000
          0000000000006000A00060000000C000C0000000E000A001C00100027B6F7B6F
          B400CE39CE39CE396000000000006000A000A0000000A000A000000020018001
          C0015A6B5A6B5A6B1600AD35AD35AD358000600000006000A000A00060000000
          0000C00040018001C001396739673967EE00AD35AD35AD35AD35600080008000
          A000A000C000C000E000200140018001F75E1863186339672201AD35AD35AD35
          AD35AD3580008000A000A000C000C000E00020014001B556D65AF75EF75E1863
          0200FF7FAD35AD35AD35AD35AD35CE39A000A000C000C000E000734E9452B556
          B556D65AF75EFF7F1E00FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F9800FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7FB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object CWF11: THemisphereButton
        Tag = 11
        Left = 185
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '11'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CWFButtonClick
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F0000FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F0200FF7FB556D65AF75E186339675A6B
          E001C001A001A0018001FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75E4002200220020002E001E001C001A0016001FF7FFF7FFF7FFF7FFF7F
          970194529452B556B55680026002600260024002200220020002E001A0018001
          FF7FFF7FFF7FFF7FAD02734E734E9452A002A002A002A0028002800260026002
          40020002E001A0016001FF7FFF7FFF7F6C01524A524A734EE002000200000002
          C002C002A002E0010000A0010002E001A001FF7FFF7FDE7B0600314631460003
          00032002000020020003E002E00200020000C00140020002C0018001DE7BDE7B
          2000104210422003200340020000400220032003200340020000E00160022002
          E001A001BD77BD77020010421042200320034002000040022003200320034002
          0000E00160022002E001A001BD77BD770800EF3DEF3DC0024001400200004002
          4003C002400140020000E001800240020002C0019C739C730200CE39CE39E002
          00000000000060024003C0020000000000000002800260022002E0017B6F7B6F
          7D02CE39CE39CE396002000000006002400340034002000000000002A0026002
          20025A6B5A6B5A6BBF03AD35AD35AD358003E00200006002400340032003A002
          00000002A002600240023967396739670300AD35AD35AD35AD35800360036003
          40034003200320030003C002A0028002F75E1863186339675A01AD35AD35AD35
          AD35AD358003600340034003200320030003E002A002B556D65AF75EF75E1863
          B481FF7FAD35AD35AD35AD35AD35CE3940034003200320030003734E9452B556
          B556D65AF75EFF7F2000FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F3E01FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7F3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F2201FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F3E01FF7FB556D65AF75E186339675A6B
          00022002400240026002FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75EC001C001C001E00100020002200240028002FF7FFF7FFF7FFF7FFF7F
          BF0394529452B556B556800180018001A001A001C001C001E001200240028002
          FF7FFF7FFF7FFF7F0200734E734E945240014001400140016001600180018001
          A001E001000240028002FF7FFF7FFF7F0200524A524A734E2001C0000000C000
          200120014001E00000002001E00120024002FF7FFF7FDE7B9B0131463146E000
          E000A0000000A000000100010001C00000000001A001E00120026002DE7BDE7B
          7B0310421042C000C000800000008000C000C000C00080000000E0008001C001
          00024002BD77BD773E0110421042C000C000800000008000C000C000C0008000
          0000E0008001C00100024002BD77BD777200EF3DEF3DA0004000800000008000
          C000A000400080000000E0006001A001E00120029C739C731300CE39CE398000
          0000000000006000A000A000000000000000C0006001A001C00100027B6F7B6F
          B400CE39CE39CE396000000000006000A000C000800000000000C00040018001
          C0015A6B5A6B5A6B1600AD35AD35AD358000600000006000A000A000C000A000
          0000C00040018001C001396739673967EE00AD35AD35AD35AD35600080008000
          A000A000C000C000E000200140018001F75E1863186339672201AD35AD35AD35
          AD35AD3580008000A000A000C000C000E00020014001B556D65AF75EF75E1863
          0200FF7FAD35AD35AD35AD35AD35CE39A000A000C000C000E000734E9452B556
          B556D65AF75EFF7F1E00FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F9800FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7FB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object CWF12: THemisphereButton
        Tag = 12
        Left = 203
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '12'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CWFButtonClick
        OnMouseDown = CWFMouseDown
        ParentFont = False
        PopupMenu = CWFMenu
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F0000FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F0200FF7FB556D65AF75E186339675A6B
          E001C001A001A0018001FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75E4002200220020002E001E001C001A0016001FF7FFF7FFF7FFF7FFF7F
          970194529452B556B55680026002600260024002200220020002E001A0018001
          FF7FFF7FFF7FFF7FAD02734E734E9452A002A002A002A0028002800260026002
          40020002E001A0016001FF7FFF7FFF7F6C01524A524A734EE002000200000002
          C002800100000000000000002001E001A001FF7FFF7FDE7B0600314631460003
          00032002000020020003800200000000A002800240020002C0018001DE7BDE7B
          2000104210422003200340020000400220032003C0010000A000A00260022002
          E001A001BD77BD77020010421042200320034002000040022003200320034001
          0000800060022002E001A001BD77BD770800EF3DEF3DC0024001400200004002
          400320032003200320010000C00140020002C0019C739C730200CE39CE39E002
          0000000000006002400340032003200380020000600160022002E0017B6F7B6F
          7D02CE39CE39CE396002000000006002400340020000400280020000E0016002
          20025A6B5A6B5A6BBF03AD35AD35AD358003E002000060024003400340010000
          00002001A002600240023967396739670300AD35AD35AD35AD35800360036003
          40034003200320030003C002A0028002F75E1863186339675A01AD35AD35AD35
          AD35AD358003600340034003200320030003E002A002B556D65AF75EF75E1863
          B481FF7FAD35AD35AD35AD35AD35CE3940034003200320030003734E9452B556
          B556D65AF75EFF7F2000FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F3E01FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7F3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F2201FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F3E01FF7FB556D65AF75E186339675A6B
          00022002400240026002FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75EC001C001C001E00100020002200240028002FF7FFF7FFF7FFF7FFF7F
          BF0394529452B556B556800180018001A001A001C001C001E001200240028002
          FF7FFF7FFF7FFF7F0200734E734E945240014001400140016001600180018001
          A001E001000240028002FF7FFF7FFF7F0200524A524A734E2001C0000000C000
          2001A0000000000000000000000120024002FF7FFF7FDE7B9B0131463146E000
          E000A0000000A0000001E0000000000040016001A001E00120026002DE7BDE7B
          7B0310421042C000C000800000008000C000C00060000000400040018001C001
          00024002BD77BD773E0110421042C000C000800000008000C000C000C0004000
          000040008001C00100024002BD77BD777200EF3DEF3DA0004000800000008000
          C000C000C000C000600000000001A001E00120029C739C731300CE39CE398000
          0000000000006000A000C000C000C000E0000000C000A001C00100027B6F7B6F
          B400CE39CE39CE396000000000006000A000800000008000C0000000E0008001
          C0015A6B5A6B5A6B1600AD35AD35AD358000600000006000A000A00040000000
          0000600040018001C001396739673967EE00AD35AD35AD35AD35600080008000
          A000A000C000C000E000200140018001F75E1863186339672201AD35AD35AD35
          AD35AD3580008000A000A000C000C000E00020014001B556D65AF75EF75E1863
          0200FF7FAD35AD35AD35AD35AD35CE39A000A000C000C000E000734E9452B556
          B556D65AF75EFF7F1E00FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F9800FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7FB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object SideToneButton: TSpeedButton
        Left = 366
        Top = 4
        Width = 25
        Height = 25
        Hint = 'Side tone'
        AllowAllUp = True
        GroupIndex = 99
        Down = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333333FFF3333F333333300033339333333337773F33733333330008033
          933333333737F7F37333333307078733333933337337373F3337333077088803
          33933337F37F337F3373333077088803393333F7337FF37F3733300777008803
          9333377F33773F7F733307088808087333337F7F337F7F7F3FFF070777080873
          99997F7F337F7F7F77770808880808733333737F337F737F3F33300888008803
          93333773F377337F73F333308807880339333337F37F337F373F333088077803
          339333373F73F37333733333087777333339333373F7F7F33F37333330807033
          933333333737F73373F333333300033339333333337773333733}
        NumGlyphs = 2
        OnClick = SideToneButtonClick
      end
      object SpeedBar: TTrackBar
        Left = 414
        Top = 6
        Width = 63
        Height = 24
        Hint = 'CW speed'
        Max = 50
        Min = 5
        PageSize = 1
        Frequency = 10
        Position = 5
        TabOrder = 0
        TabStop = False
        OnChange = SpeedBarChange
      end
    end
    object SSBToolBar: TPanel
      Left = 0
      Top = 33
      Width = 528
      Height = 33
      Align = alTop
      TabOrder = 1
      ExplicitWidth = 524
      object VoiceStopButton: TSpeedButton
        Left = 312
        Top = 4
        Width = 25
        Height = 25
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          333333333333333333333333333333333333333333333333333333333FFFFFFF
          333333333FFFFFFF333333339999999F333333338888888F333333339999999F
          333333338888888F333333339999999F333333338888888F333333339999999F
          333333338888888F333333339999999F333333338888888F333333339999999F
          333333338888888F333333339999999333333333888888833333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        OnClick = VoiceStopButtonClick
      end
      object VoicePauseButton: TSpeedButton
        Left = 336
        Top = 4
        Width = 25
        Height = 25
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          333333333333333333333333FFF33FFF33333333FFF333FFF333333999F3999F
          3333333888F33888F333333999F3999F3333333888F33888F333333999F3999F
          3333333888F33888F333333999F3999F3333333888F33888F333333999F3999F
          3333333888F33888F333333999F3999F3333333888F33888F333333999F3999F
          3333333888F33888F33333399933999333333338883338883333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        Visible = False
      end
      object buttonVoiceOption: TSpeedButton
        Left = 390
        Top = 4
        Width = 25
        Height = 25
        Hint = 'Voice options'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555550FF0559
          1950555FF75F7557F7F757000FF055591903557775F75557F77570FFFF055559
          1933575FF57F5557F7FF0F00FF05555919337F775F7F5557F7F700550F055559
          193577557F7F55F7577F07550F0555999995755575755F7FFF7F5570F0755011
          11155557F755F777777555000755033305555577755F75F77F55555555503335
          0555555FF5F75F757F5555005503335505555577FF75F7557F55505050333555
          05555757F75F75557F5505000333555505557F777FF755557F55000000355557
          07557777777F55557F5555000005555707555577777FF5557F55553000075557
          0755557F7777FFF5755555335000005555555577577777555555}
        NumGlyphs = 2
        Visible = False
        OnClick = buttonVoiceOptionClick
      end
      object VoicePlayButton: TSpeedButton
        Left = 336
        Top = 4
        Width = 25
        Height = 25
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          333333333333333333333333333F333333333333333F333333333333339FF333
          33333333338FF333333333333399FF33333333333388FF333333333333999FF3
          3333333333888FF333333333339999FF33333333338888FF3333333333999993
          3333333333888883333333333399993333333333338888333333333333999333
          3333333333888333333333333399333333333333338833333333333333933333
          3333333333833333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        Visible = False
      end
      object VoiceF1: THemisphereButton
        Tag = 1
        Left = 4
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '1'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = VoiceFButtonClick
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C002C002
          C002000000008002600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E002E002E00200000000C002A00260022002E001C0018001DE7BBD77
          200010421042000300030003000300030003000000000003C002800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300030003000000000003
          C002800240022002E001A0019C739C730800CE39CE3920032003200320030000
          2003000000000003E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400300000000000000000003E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400340030000000000000003E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600340034003000000000003
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010001
          200100000000400160018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E000E000E00000000000000120016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C000C000C00000000000C000000140018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C000C000C00000000000C000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A0000000
          A00000000000C000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          8000800080000000000000000000C000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD358000800080008000000000000000C000E000000140018001
          A001396739675A6B1600ADB5AD35AD356000600080008000800000000000C000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object VoiceF3: THemisphereButton
        Tag = 3
        Left = 40
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '3'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = VoiceFButtonClick
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C002C002
          0000000000008002600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E00200000000E00200000000A00260022002E001C0018001DE7BBD77
          200010421042000300030003000300030003000300000000C002800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300030003000300000000
          C002800240022002E001A0019C739C730800CE39CE3920032003200320032003
          2003000000000003E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400340032003200300000000E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400300000000200300000000E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600340030000000000000003
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010001
          000000000000400160018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E00000000000E0000000000020016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C000C000C000C00000000000000140018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C000C000C000C00000000000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A000A000
          A00000000000C000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          8000800080008000A000A00000000000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD3580008000800000000000A00000000000E000000140018001
          A001396739675A6B1600ADB5AD35AD356000600080008000000000000000C000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object VoiceF2: THemisphereButton
        Tag = 2
        Left = 22
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '2'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = VoiceFButtonClick
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C0020000
          0000000000000000600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E00200000000E002C002C002A00260022002E001C0018001DE7BBD77
          200010421042000300030003000300030000000000030003C002800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300030003000000000003
          C002800240022002E001A0019C739C730800CE39CE3920032003200320032003
          2003200300000000E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400340032003200300000000E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400300000000200300000000E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600340030000000000000003
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010000
          000000000000000060018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E00000000000E0000001000120016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C000C00000000000C000C000000140018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C000C000C00000000000C000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A000A000
          A000A00000000000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          8000800080008000A000A00000000000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD3580008000800000000000A00000000000E000000140018001
          A001396739675A6B1600ADB5AD35AD356000600080008000000000000000C000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object VoiceF4: THemisphereButton
        Tag = 4
        Left = 58
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '4'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = VoiceFButtonClick
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C002C002
          C002A00200000000600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E002E002E002E00200000000A00260022002E001C0018001DE7BBD77
          2000104210420003000300030003000000000000000000000000800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300000003000300000000
          C002800240022002E001A0019C739C730800CE39CE3920032003200320032003
          0000200300000000E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400340030000200300000000E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400340034003000000000000E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600340034003200300000000
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010001
          200120010000000060018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E000E000E000E0000000000020016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C00000000000000000000000000040018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C0000000C000C00000000000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A000A000
          0000A00000000000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          80008000800080000000A00000000000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD3580008000800080008000000000000000E000000140018001
          A001396739675A6B1600ADB5AD35AD3560006000800080008000A00000000000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object VoiceF5: THemisphereButton
        Tag = 5
        Left = 77
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '5'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = VoiceFButtonClick
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C002C002
          0000000000008002600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E00200000000E00200000000A00260022002E001C0018001DE7BBD77
          200010421042000300030003000300030003000300000000C002800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300000003000300000000
          C002800240022002E001A0019C739C730800CE39CE3920032003200320030000
          0000000000000003E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400300000000200300030003E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400340030000000000030003E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600340030000000000000000
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010001
          000000000000400160018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E00000000000E0000000000020016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C000C000C000C00000000000000140018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C0000000C000C00000000000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A0000000
          000000000000C000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          80008000800000000000A000C000C000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD35800080008000800000000000C000C000E000000140018001
          A001396739675A6B1600ADB5AD35AD3560006000800080000000000000000000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object VoiceF6: THemisphereButton
        Tag = 6
        Left = 95
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '6'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = VoiceFButtonClick
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C002C002
          0000000000008002600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E00200000000E00200000000A00260022002E001C0018001DE7BBD77
          200010421042000300030003000300000000000300000000C002800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300000000000300000000
          C002800240022002E001A0019C739C730800CE39CE3920032003200320030000
          0000000000000003E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400300000000200300030003E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400300000000200300000000E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600340030000000000000003
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010001
          000000000000400160018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E00000000000E0000000000020016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C00000000000C00000000000000140018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C00000000000C00000000000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A0000000
          000000000000C000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          80008000800000000000A000C000C000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD3580008000800000000000A00000000000E000000140018001
          A001396739675A6B1600ADB5AD35AD356000600080008000000000000000C000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object VoiceF7: THemisphereButton
        Tag = 7
        Left = 113
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '7'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = VoiceFButtonClick
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C002C002
          0000000080028002600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E002E00200000000C002C002A00260022002E001C0018001DE7BBD77
          200010421042000300030003000300030000000000030003C002800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300030000000000030003
          C002800240022002E001A0019C739C730800CE39CE3920032003200320032003
          2003000000000003E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400340032003000000000003E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400340034003200300000000E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600300000000000000000000
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010001
          000000004001400160018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E000E000000000000001000120016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C000C00000000000C000C000000140018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C000C00000000000C000C000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A000A000
          A00000000000C000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          8000800080008000A00000000000C000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD3580008000800080008000A00000000000E000000140018001
          A001396739675A6B1600ADB5AD35AD3560006000800000000000000000000000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object VoiceF8: THemisphereButton
        Tag = 8
        Left = 131
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '8'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = VoiceFButtonClick
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF0000FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF0200FFFFB5D6D65AD65AF75E18633967
          C001C001A001A0018001DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65A200220020002E001E001E001C00180016001FF7FFF7FFF7FFF7FFF7F
          970173CE94529452B5566002600240024002200220022002E001C001A0016001
          FF7FFF7FFF7FDE7BAD02524A734E734EA002A002800280028002600240024002
          20020002C001A0016001FF7FDE7BDE7B6C013146524A524AC002C002C002C002
          0000000000008002600240020002C0018001DE7BDE7BDE7B060031463146E002
          E002E002E00200000000E00200000000A00260022002E001C0018001DE7BBD77
          200010421042000300030003000300000000000300000000C002800240022002
          E001A001BD77BD770200EF3DEF3D000300030003000300000000000300000000
          C002800240022002E001A0019C739C730800CE39CE3920032003200320032003
          0000000000000003E002A00260022002E001C0017B6F7B6F0200CE39CE394003
          40034003400300000000200300000000E002C002800240020002C0015A6B7B6F
          7D02AD35AD35AD3560034003400300000000200300000000E002C00280024002
          2002396739675A6BBF03ADB5AD35AD3560036003600340030000000000000003
          E002C0028002600220021863396739670300ADB5AD358C318C31600360034003
          4003200300030003E002C002A0026002D65AF75E186318635A01ADB58CB18C31
          8C318C31600360034003200300030003E002C002A002B556D65AD65AF75EF7DE
          B481FFFF8CB18CB18C318C31AD35AD354003200300030003E002524A734E9452
          B556D65AD6DAFFFF2000FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF3E01FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFF3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFF7DE186339675A6B7B6F7B6F9C73BD77BD77DE7BDE7BDE7B
          FF7FFFFFFFFFFFFF2201FFFFFFFFD6DAF75E1863396739675A6B7B6F9C73BD77
          DE7BDE7BDE7BFF7FFF7FFF7FFFFFFFFF3E01FFFFB5D6D65AD65AF75E18633967
          00022002200220026002DE7BFF7FFF7FFF7FFF7FFF7FFFFF3E0194D29452B556
          D65AD65AA001A001C001E00100020002200240026002FF7FFF7FFF7FFF7FFF7F
          BF0373CE94529452B5566001600180018001A001C001C001E001000220026002
          FF7FFF7FFF7FDE7B0200524A734E734E20014001400140014001600180018001
          A001C001000220026002FF7FDE7BDE7B02003146524A524A0001000100010001
          000000000000400160018001C00100024002DE7BDE7BDE7B9B0131463146E000
          E000E000E00000000000E0000000000020016001A001E00120026002DE7BBD77
          7B0310421042C000C000C000C00000000000C00000000000000140018001C001
          00022002BD77BD773E01EF3DEF3DC000C000C000C00000000000C00000000000
          000140018001C001000220029C739C737200CE39CE39A000A000A000A000A000
          000000000000C000E00020016001A001E00120027B6F7B6F1300CE39CE398000
          80008000800000000000A00000000000E000200140018001C00100025A6B7B6F
          B400AD35AD35AD3580008000800000000000A00000000000E000000140018001
          A001396739675A6B1600ADB5AD35AD356000600080008000000000000000C000
          E000000140016001A001186339673967EE00ADB5AD358C318C31600060008000
          8000A000C000C000E000000140016001D65AF75E186318632201ADB58CB18C31
          8C318C31600080008000A000C000C000E00000012001B556D65AD65AF75EF7DE
          0200FFFF8CB18CB18C318C31AD35AD358000A000C000C000E000524A734E9452
          B556D65AD6DAFFFF1E00FFFFFFFF8CB18CB1AD35AD35AD35CE39CE39EF3D1042
          3146524A734E94529452B5D6FFFFFFFF9800FFFFFFFFFFFFADB5ADB5ADB5ADB5
          CEB9CEB9EFBD10C231C631C652CA73CE94D2FFFFFFFFFFFFB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object VoiceCQ1: THemisphereButton
        Tag = 101
        Left = 225
        Top = 3
        Width = 28
        Height = 28
        Hint = 'CQ once'
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = 'CQ'
        Down = False
        FaceColor = clPurple
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = VoiceFButtonClick
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFFFFFFFFFFFFF39E739E75AEB5A6B7B6F7B6F9C739C739C73
          BD77BD77BD77DE7BDE7BDEFBDEFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF18E3396739675A6B5A6B7B6F9C739C739C73BD77BD77BD77DE7B
          DE7BDE7BDE7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF7DEF75E1863
          396739675A6B0C300B2C0B2C0A280A28092408200820DE7BDE7BDE7BFF7FFF7F
          FF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF75EF75E186318630E380E380D34
          0D340C300C300B2C0A280A2809240820071CDE7BFF7FFF7FFF7FFF7FFFFFFFFF
          FFFFFFFFB5D6B5D6D6DAD65AF75EF75E0F3C0F3C0F3C0F3C0E380E380D340C30
          0C300B2C0A2809240820071CFF7FFF7FFF7FFF7FFFFFFFFFFFFFFFFF94D2B5D6
          B556D65AD65A114411441040104010400F3C0F3C0E380E380D340C300B2C0A28
          09240820071CFF7FFF7FFF7FFF7FFFFFFFFF73CE94D29452B556B55612481248
          12481248114411441144104010400F3C0E380E380D340C300B2C0A280924071C
          FF7FFF7FFF7FFF7FFFFF73CE73CE94529452134C134C134C134C134C12481248
          124811441144104010400F3C0E380D340C300B2C0A280820071CFF7FFF7FFF7F
          DEFB52CA734E734E1450145014501450145014501450134C134C134C12481248
          114410400F3C0E380D340C300B2C09240820071CDE7BDE7BDE7B52CA524A524A
          15541554155415541554155415541554145014501450134C1248114410400F3C
          0E380D340C300A2809240820DE7BDE7BDE7B31C6314616581658165816581658
          165816581658165816581554155414501450134C1248104000000E380D340B2C
          0A2809240820DE7BDE7B10C21042175C175C175C175C175C0000000000000000
          175C165816581658000000000000000010400F3C0E380C300B2C0A280820BD77
          BD7710C210421860186018601860000000001860186000000000175C175C0000
          0000155400000000114410400E380D340C300A280924BD77BD7710C210421860
          186018600000000018601860186018601860186000000000175C000014500000
          000010400F3C0E380C300B2C0A28BD77BD77EFBDEF3D19641964196400000000
          19641964196419641964196400000000175C1658155400000000114410400E38
          0D340C300A289C739C73CEB9CE391A681A681964000000001964196419641964
          1964196400000000175C1658155400000000114410400F3C0E380C300B2C7B6F
          7B6FCEB9CE391A681A681A68000000001A681A681A681A681964196400000000
          1860175C165800000000124811440F3C0E380D340B2C7B6F7B6FADB5AD351B6C
          1A681A681A68000000001A681A68000000001964196400000000175C00000000
          134C1248114410400F3C0D340C305A6B5A6BADB5AD35AD351B6C1B6C1B6C1B6C
          00000000000000001A6819641964186000000000000015541450124811441040
          0F3C0E38396739673967ADB5ADB5AD351B6C1B6C1B6C1B6C1B6C1B6C1A681A68
          1A681964196418601860175C165815541450134C124810400F3C0E3818633967
          39E7ADB5ADB5AD358C311B6C1B6C1B6C1B6C1B6C1B6C1A681A68196419641860
          1860175C165815541450134C124811440F3CF75E1863186318E3ADB5ADB58CB1
          8C318C311C701B6C1B6C1B6C1B6C1A681A681964196418601860175C16581554
          1450134C12481144D65AF75EF75EF7DE18E3FFFF8CB18CB18CB18C318C311C70
          1B6C1B6C1B6C1A681A681964196418601860175C165815541450134C1248B556
          D65AD65AF7DEF7DEFFFFFFFF8CB18CB18CB18C318C318C311B6C1B6C1B6C1A68
          1A681964196418601860175C165815541450134C9452B556B556D65AD6DAD6DA
          FFFFFFFFFFFFFFFF8CB18CB18C31AD35AD351B6C1B6C1A681A681A6819641860
          1860175C165815541450734E94529452B556B5D6FFFFFFFFFFFFFFFFFFFFFFFF
          8CB18CB1ADB5ADB5AD35AD35AD351B6C1A681A68196418601860175C16583146
          524A734E734E94D294D2B5D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5
          ADB5ADB5AD35CE39CE39EF3DEF3DEF3D1042104231463146524A52CA73CEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5ADB5ADB5CEB9CEB9
          CEB9EFBDEFBDEFBD10C210C231C631C652CA52CA73CEFFFFFFFFFFFFFFFFFFFF
          FFFF}
        ImageIn = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFFFFFFFFFFFFF39E739E75AEB5A6B7B6F7B6F9C739C739C73
          BD77BD77BD77DE7BDE7BDEFBDEFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF18E3396739675A6B5A6B7B6F9C739C739C73BD77BD77BD77DE7B
          DE7BDE7BDE7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF7DEF75E1863
          396739675A6B1248134C134C1450145015541658175CDE7BDE7BDE7BFF7FFF7F
          FF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF75EF75E18631863104011441144
          114412481248134C1450145015541658175CDE7BFF7FFF7FFF7FFF7FFFFFFFFF
          FFFFFFFFB5D6B5D6D6DAD65AF75EF75E0F3C0F3C0F3C10401040114411441248
          1248134C145015541658175CFF7FFF7FFF7FFF7FFFFFFFFFFFFFFFFF94D2B5D6
          B556D65AD65A0D340D340E380E380E380F3C0F3C1040104011441248134C1450
          15541658175CFF7FFF7FFF7FFF7FFFFFFFFF73CE94D29452B556B5560C300C30
          0C300D340D340D340D340E380E380F3C1040114411441248134C14501658175C
          FF7FFF7FFF7FFF7FFFFF73CE73CE945294520B2C0B2C0B2C0B2C0B2C0C300C30
          0C300D340D340E380E380F3C104011441248134C14501658175CFF7FFF7FFF7F
          DEFB52CA734E734E0A280A280A280A280A280A280A280B2C0B2C0B2C0C300C30
          0D340E380F3C104011441248134C15541658175CDE7BDE7BDE7B52CA524A524A
          09240924092409240924092409240A280A280A280B2C0B2C0C300D340E380F3C
          104011441248145015541658DE7BDE7BDE7B31C6314608200820082008200820
          08200820082008200924092409240A280B2C0C300D340E38000010401144134C
          14501554175CDE7BDE7B10C21042071C071C071C071C071C0000000000000000
          082008200820082000000000000000000E380F3C11441248134C14501658BD77
          BD7710C21042071C071C071C071C00000000071C071C00000000071C071C0000
          00000924000000000D340E3810401144124814501554BD77BD7710C210420618
          061806180000000006180618061806180618061800000000071C00000A280000
          00000E380F3C10401248134C1450BD77BD77EFBDEF3D05140514051400000000
          05140514051405140514051400000000071C08200924000000000D340E381040
          1144124814509C739C73CEB9CE39051405140514000000000514051405140514
          0514051400000000071C08200924000000000D340E380F3C11441248134C7B6F
          7B6FCEB9CE390410041004100000000004100410041005140514051400000000
          071C08200924000000000C300D340F3C10401144134C7B6F7B6FADB5AD350410
          0410041004100000000004100410000000000514051400000000071C00000000
          0B2C0C300D340E381040114412485A6B5A6BADB5AD35AD35030C030C030C030C
          0000000000000000041005140514061800000000000009240A280C300D340E38
          0F3C1144396739673967ADB5ADB5AD35030C030C030C030C030C041004100410
          0410051405140618071C071C082009240A280B2C0D340E380F3C104018633967
          39E7ADB5ADB5AD358C31030C030C030C030C030C041004100410051405140618
          071C071C082009240A280B2C0C300D340F3CF75E1863186318E3ADB5ADB58CB1
          8C318C31030C030C030C030C030C04100410051405140618071C071C08200924
          0A280B2C0C300D34D65AF75EF75EF7DE18E3FFFF8CB18CB18CB18C318C31030C
          030C030C030C04100410051405140618071C071C082009240A280B2C0C30B556
          D65AD65AF7DEF7DEFFFFFFFF8CB18CB18CB18C318C318C31030C030C030C0410
          0410051405140618071C071C082009240A280B2C9452B556B556D65AD6DAD6DA
          FFFFFFFFFFFFFFFF8CB18CB18C31AD35AD35030C030C04100410051405140618
          071C071C082009240A28734E94529452B556B5D6FFFFFFFFFFFFFFFFFFFFFFFF
          8CB18CB1ADB5ADB5AD35AD35AD3504100410051405140618071C071C08203146
          524A734E734E94D294D2B5D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5
          ADB5ADB5AD35CE39CE39EF3DEF3DEF3D1042104231463146524A52CA73CEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5ADB5ADB5CEB9CEB9
          CEB9EFBDEFBDEFBD10C210C231C631C652CA52CA73CEFFFFFFFFFFFFFFFFFFFF
          FFFF}
        ImageMask = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7F000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
          000000000000000000000000000000000000000000000000000000000000FF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000FF7FFF7FFF7FFF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000FF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          FF7FFF7F00000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7F00000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF7F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF7F000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000FF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          FF7FFF7F00000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7FFF7F0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF7FFF7FFF7FFF7FFF7F0000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          00000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7F0000000000000000000000000000000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
          0000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7F}
      end
      object VoiceCQ2: THemisphereButton
        Tag = 102
        Left = 253
        Top = 3
        Width = 28
        Height = 28
        Hint = 'Repeat CQ, hit ESC to stop'
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = 'CQ~'
        Down = False
        FaceColor = clOlive
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CQRepeatClick1
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFFFFFFFFFFFFF39E739E75AEB5A6B7B6F7B6F9C739C739C73
          BD77BD77BD77DE7BDE7BDEFBDEFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF18E3396739675A6B5A6B7B6F9C739C739C73BD77BD77BD77DE7B
          DE7BDE7BDE7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF7DEF75E1863
          396739675A6B8031602D602D40294029202500210021DE7BDE7BDE7BFF7FFF7F
          FF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF75EF75E18631863C039C039A035
          A03580318031602D4029402920250021E01CDE7BFF7FFF7FFF7FFF7FFFFFFFFF
          FFFFFFFFB5D6B5D6D6DAD65AF75EF75EE03DE03DE03DE03DC039C039A0358031
          8031602D402920250021E01CFF7FFF7FFF7FFF7FFFFFFFFFFFFFFFFF94D2B5D6
          B556D65AD65A20462046004200420042E03DE03DC039C039A0358031602D4029
          20250021E01CFF7FFF7FFF7FFF7FFFFFFFFF73CE94D29452B556B556404A404A
          404A404A20462046204600420042E03DC039C039A0358031602D40292025E01C
          FF7FFF7FFF7FFF7FFFFF73CE73CE94529452604E604E604E604E604E404A404A
          404A2046204600420042E03DC039A0358031602D40290021E01CFF7FFF7FFF7F
          DEFB52CA734E734E8052805280528052805280528052604E604E604E404A404A
          20460042E03DC039A0358031602D20250021E01CDE7BDE7BDE7B52CA524A524A
          A056A056A056A056A056A056A056A056805280528052604E404A20460042E03D
          C039A0358031402920250021DE7BDE7BDE7B31C63146C05AC05AC05AC05AC05A
          C05AC05AC05AC05AC05AA056A056805280520000404A0042E03DC039A035602D
          402920250021DE7BDE7B10C21042E05EE05E0000000000000000E05EE05EE05E
          E05E00000000000000008052604E20460042E03DC0398031602D40290021BD77
          BD7710C2104200630000000000630063000000000063006300000000E05E0000
          0000A0568052404A20460042C039A035803140292025BD77BD7710C210420000
          000000630063006300630063006300000000006300000063000000008052604E
          404A0042E03DC0398031602D4029BD77BD77EFBDEF3D00000000206720672067
          2067206720670000000020672067006300000000A0560000404A20460000C039
          A035803140299C739C73CEB9CE39000000002067206720672067206720670000
          000020672067006300000000A05680520000000000420000C0398031602D7B6F
          7B6FCEB9CE3900000000406B406B406B406B406B406B00000000206720670063
          00000000C05A8052604E404A2046E03DC039A035602D7B6F7B6FADB5AD35606F
          00000000406B406B00000000406B406B00000000206700000000E05EC05AA056
          604E404A20460042E03DA03580315A6B5A6BADB5AD35AD35606F000000000000
          0000406B406B406B406B0000000000000063E05EC05AA0568052404A20460042
          E03DC039396739673967ADB5ADB5AD35606F606F606F606F606F606F406B406B
          406B2067206700630063E05EC05AA0568052604E404A0042E03DC03918633967
          39E7ADB5ADB5AD358C31606F606F606F606F606F606F406B406B206720670063
          0063E05EC05AA0568052604E404A2046E03DF75E1863186318E3ADB5ADB58CB1
          8C318C318073606F606F606F606F406B406B2067206700630063E05EC05AA056
          8052604E404A2046D65AF75EF75EF7DE18E3FFFF8CB18CB18CB18C318C318073
          606F606F606F406B406B2067206700630063E05EC05AA0568052604E404AB556
          D65AD65AF7DEF7DEFFFFFFFF8CB18CB18CB18C318C318C31606F606F606F406B
          406B2067206700630063E05EC05AA0568052604E9452B556B556D65AD6DAD6DA
          FFFFFFFFFFFFFFFF8CB18CB18C31AD35AD35606F606F406B406B406B20670063
          0063E05EC05AA0568052734E94529452B556B5D6FFFFFFFFFFFFFFFFFFFFFFFF
          8CB18CB1ADB5ADB5AD35AD35AD35606F406B406B206700630063E05EC05A3146
          524A734E734E94D294D2B5D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5
          ADB5ADB5AD35CE39CE39EF3DEF3DEF3D1042104231463146524A52CA73CEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5ADB5ADB5CEB9CEB9
          CEB9EFBDEFBDEFBD10C210C231C631C652CA52CA73CEFFFFFFFFFFFFFFFFFFFF
          FFFF}
        ImageIn = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFFFFFFFFFFFFF39E739E75AEB5A6B7B6F7B6F9C739C739C73
          BD77BD77BD77DE7BDE7BDEFBDEFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF18E3396739675A6B5A6B7B6F9C739C739C73BD77BD77BD77DE7B
          DE7BDE7BDE7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF7DEF75E1863
          396739675A6B404A604E604E80528052A056C05AE05EDE7BDE7BDE7BFF7FFF7F
          FF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF75EF75E18631863004220462046
          2046404A404A604E80528052A056C05AE05EDE7BFF7FFF7FFF7FFF7FFFFFFFFF
          FFFFFFFFB5D6B5D6D6DAD65AF75EF75EE03DE03DE03D0042004220462046404A
          404A604E8052A056C05AE05EFF7FFF7FFF7FFF7FFFFFFFFFFFFFFFFF94D2B5D6
          B556D65AD65AA035A035C039C039C039E03DE03D004200422046404A604E8052
          A056C05AE05EFF7FFF7FFF7FFF7FFFFFFFFF73CE94D29452B556B55680318031
          8031A035A035A035A035C039C039E03D004220462046404A604E8052C05AE05E
          FF7FFF7FFF7FFF7FFFFF73CE73CE94529452602D602D602D602D602D80318031
          8031A035A035C039C039E03D00422046404A604E8052C05AE05EFF7FFF7FFF7F
          DEFB52CA734E734E4029402940294029402940294029602D602D602D80318031
          A035C039E03D00422046404A604EA056C05AE05EDE7BDE7BDE7B52CA524A524A
          2025202520252025202520252025402940294029602D602D8031A035C039E03D
          00422046404A8052A056C05ADE7BDE7BDE7B31C6314600210021002100210021
          00210021002100212025202520254029602D0000A035C039E03D00422046604E
          8052A056E05EDE7BDE7B10C21042E01CE01C0000000000000000E01CE01CE01C
          0021000000000000000040298031A035C039E03D2046404A604E8052C05ABD77
          BD7710C21042E01C00000000E01CE01C00000000E01CE01C00000000E01C0000
          00002025602D8031A035C03900422046404A8052A056BD77BD7710C210420000
          0000C018C018C018C018C018C01800000000C0180000C018000000004029602D
          8031C039E03D0042404A604E8052BD77BD77EFBDEF3D00000000A014A014A014
          A014A014A01400000000A014A014C01800000000202500008031A03500000042
          2046404A80529C739C73CEB9CE3900000000A014A014A014A014A014A0140000
          0000A014A014C018000000002025402900000000C03900002046404A604E7B6F
          7B6FCEB9CE390000000080108010801080108010801000000000A014A014C018
          0000000020254029602D8031A035E03D00422046604E7B6F7B6FADB5AD358010
          0000000080108010000000008010801000000000A01400000000E01C00214029
          602D8031A035C03900422046404A5A6B5A6BADB5AD35AD35600C000000000000
          00008010801080108010000000000000E01CE01C0021202540298031A035C039
          E03D2046396739673967ADB5ADB5AD35600C600C600C600C600C801080108010
          8010A014A014C018E01CE01C002120254029602DA035C039E03D004218633967
          39E7ADB5ADB5AD358C31600C600C600C600C600C801080108010A014A014C018
          E01CE01C002120254029602D8031A035E03DF75E1863186318E3ADB5ADB58CB1
          8C318C31600C600C600C600C600C80108010A014A014C018E01CE01C00212025
          4029602D8031A035D65AF75EF75EF7DE18E3FFFF8CB18CB18CB18C318C31600C
          600C600C600C80108010A014A014C018E01CE01C002120254029602D8031B556
          D65AD65AF7DEF7DEFFFFFFFF8CB18CB18CB18C318C318C31600C600C600C8010
          8010A014A014C018E01CE01C002120254029602D9452B556B556D65AD6DAD6DA
          FFFFFFFFFFFFFFFF8CB18CB18C31AD35AD35600C600C80108010A014A014C018
          E01CE01C002120254029734E94529452B556B5D6FFFFFFFFFFFFFFFFFFFFFFFF
          8CB18CB1ADB5ADB5AD35AD35AD3580108010A014A014C018E01CE01C00213146
          524A734E734E94D294D2B5D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5
          ADB5ADB5AD35CE39CE39EF3DEF3DEF3D1042104231463146524A52CA73CEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5ADB5ADB5CEB9CEB9
          CEB9EFBDEFBDEFBD10C210C231C631C652CA52CA73CEFFFFFFFFFFFFFFFFFFFF
          FFFF}
        ImageMask = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7F000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
          000000000000000000000000000000000000000000000000000000000000FF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000FF7FFF7FFF7FFF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000FF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          FF7FFF7F00000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7F00000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF7F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF7F000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000FF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          FF7FFF7F00000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7FFF7F0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF7FFF7FFF7FFF7FFF7F0000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          00000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7F0000000000000000000000000000000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
          0000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7F}
      end
      object VoiceCQ3: THemisphereButton
        Tag = 103
        Left = 281
        Top = 3
        Width = 28
        Height = 28
        Hint = 'Repeat CQ, enter call sign to stop'
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = 'CQ~'
        Down = False
        FaceColor = clTeal
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = CQRepeatClick2
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFFFFFFFFFFFFF39E739E75AEB5A6B7B6F7B6F9C739C739C73
          BD77BD77BD77DE7BDE7BDEFBDEFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF18E3396739675A6B5A6B7B6F9C739C739C73BD77BD77BD77DE7B
          DE7BDE7BDE7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF7DEF75E1863
          396739675A6B8C016B016B014A014A01290108010801DE7BDE7BDE7BFF7FFF7F
          FF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF75EF75E18631863CE01CE01AD01
          AD018C018C016B014A014A0129010801E700DE7BFF7FFF7FFF7FFF7FFFFFFFFF
          FFFFFFFFB5D6B5D6D6DAD65AF75EF75EEF01EF01EF01EF01CE01CE01AD018C01
          8C016B014A0129010801E700FF7FFF7FFF7FFF7FFFFFFFFFFFFFFFFF94D2B5D6
          B556D65AD65A31023102100210021002EF01EF01CE01CE01AD018C016B014A01
          29010801E700FF7FFF7FFF7FFF7FFFFFFFFF73CE94D29452B556B55652025202
          5202520231023102310210021002EF01CE01CE01AD018C016B014A012901E700
          FF7FFF7FFF7FFF7FFFFF73CE73CE945294527302730273027302730252025202
          52023102310210021002EF01CE01AD018C016B014A010801E700FF7FFF7FFF7F
          DEFB52CA734E734E940294029402940294029402940273027302730252025202
          31021002EF01CE01AD018C016B0129010801E700DE7BDE7BDE7B52CA524A524A
          B502B502B502B502B502B502B502B5029402940294027302520231021002EF01
          CE01AD018C014A0129010801DE7BDE7BDE7B31C63146D602D602D602D602D602
          D602D602D602D602D602B502B50294029402000052021002EF01CE01AD016B01
          4A0129010801DE7BDE7B10C21042F702F7020000000000000000F702F702F702
          F70200000000000000009402730231021002EF01CE018C016B014A010801BD77
          BD7710C2104218030000000018031803000000001803180300000000F7020000
          0000B5029402520231021002CE01AD018C014A012901BD77BD7710C210420000
          0000180318031803180318031803000000001803000018030000000094027302
          52021002EF01CE018C016B014A01BD77BD77EFBDEF3D00000000390339033903
          3903390339030000000039033903180300000000B5020000520231020000CE01
          AD018C014A019C739C73CEB9CE39000000003903390339033903390339030000
          000039033903180300000000B50294020000000010020000CE018C016B017B6F
          7B6FCEB9CE39000000005A035A035A035A035A035A0300000000390339031803
          00000000D6029402730252023102EF01CE01AD016B017B6F7B6FADB5AD357B03
          000000005A035A03000000005A035A0300000000390300000000F702D602B502
          7302520231021002EF01AD018C015A6B5A6BADB5AD35AD357B03000000000000
          00005A035A035A035A030000000000001803F702D602B5029402520231021002
          EF01CE01396739673967ADB5ADB5AD357B037B037B037B037B037B035A035A03
          5A033903390318031803F702D602B5029402730252021002EF01CE0118633967
          39E7ADB5ADB5AD358C317B037B037B037B037B037B035A035A03390339031803
          1803F702D602B5029402730252023102EF01F75E1863186318E3ADB5ADB58CB1
          8C318C319C037B037B037B037B035A035A033903390318031803F702D602B502
          9402730252023102D65AF75EF75EF7DE18E3FFFF8CB18CB18CB18C318C319C03
          7B037B037B035A035A033903390318031803F702D602B502940273025202B556
          D65AD65AF7DEF7DEFFFFFFFF8CB18CB18CB18C318C318C317B037B037B035A03
          5A033903390318031803F702D602B502940273029452B556B556D65AD6DAD6DA
          FFFFFFFFFFFFFFFF8CB18CB18C31AD35AD357B037B035A035A035A0339031803
          1803F702D602B5029402734E94529452B556B5D6FFFFFFFFFFFFFFFFFFFFFFFF
          8CB18CB1ADB5ADB5AD35AD35AD357B035A035A03390318031803F702D6023146
          524A734E734E94D294D2B5D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5
          ADB5ADB5AD35CE39CE39EF3DEF3DEF3D1042104231463146524A52CA73CEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5ADB5ADB5CEB9CEB9
          CEB9EFBDEFBDEFBD10C210C231C631C652CA52CA73CEFFFFFFFFFFFFFFFFFFFF
          FFFF}
        ImageIn = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FFFFFFFFFFFFFFFFFFFFFFFF39E739E75AEB5A6B7B6F7B6F9C739C739C73
          BD77BD77BD77DE7BDE7BDEFBDEFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF18E3396739675A6B5A6B7B6F9C739C739C73BD77BD77BD77DE7B
          DE7BDE7BDE7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF7DEF75E1863
          396739675A6B52027302730294029402B502D602F702DE7BDE7BDE7BFF7FFF7F
          FF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6DAF75EF75E18631863100231023102
          310252025202730294029402B502D602F702DE7BFF7FFF7FFF7FFF7FFFFFFFFF
          FFFFFFFFB5D6B5D6D6DAD65AF75EF75EEF01EF01EF0110021002310231025202
          520273029402B502D602F702FF7FFF7FFF7FFF7FFFFFFFFFFFFFFFFF94D2B5D6
          B556D65AD65AAD01AD01CE01CE01CE01EF01EF01100210023102520273029402
          B502D602F702FF7FFF7FFF7FFF7FFFFFFFFF73CE94D29452B556B5568C018C01
          8C01AD01AD01AD01AD01CE01CE01EF01100231023102520273029402D602F702
          FF7FFF7FFF7FFF7FFFFF73CE73CE945294526B016B016B016B016B018C018C01
          8C01AD01AD01CE01CE01EF0110023102520273029402D602F702FF7FFF7FFF7F
          DEFB52CA734E734E4A014A014A014A014A014A014A016B016B016B018C018C01
          AD01CE01EF011002310252027302B502D602F702DE7BDE7BDE7B52CA524A524A
          29012901290129012901290129014A014A014A016B016B018C01AD01CE01EF01
          1002310252029402B502D602DE7BDE7BDE7B31C6314608010801080108010801
          08010801080108012901290129014A016B010000AD01CE01EF01100231027302
          9402B502F702DE7BDE7B10C21042E700E7000000000000000000E700E700E700
          080100000000000000004A018C01AD01CE01EF013102520273029402D602BD77
          BD7710C21042E70000000000E700E70000000000E700E70000000000E7000000
          000029016B018C01AD01CE011002310252029402B502BD77BD7710C210420000
          0000C600C600C600C600C600C60000000000C6000000C600000000004A016B01
          8C01CE01EF011002520273029402BD77BD77EFBDEF3D00000000A500A500A500
          A500A500A50000000000A500A500C60000000000290100008C01AD0100001002
          3102520294029C739C73CEB9CE3900000000A500A500A500A500A500A5000000
          0000A500A500C6000000000029014A0100000000CE0100003102520273027B6F
          7B6FCEB9CE390000000084008400840084008400840000000000A500A500C600
          0000000029014A016B018C01AD01EF011002310273027B6F7B6FADB5AD358400
          0000000084008400000000008400840000000000A50000000000E70008014A01
          6B018C01AD01CE011002310252025A6B5A6BADB5AD35AD356300000000000000
          00008400840084008400000000000000E700E700080129014A018C01AD01CE01
          EF013102396739673967ADB5ADB5AD3563006300630063006300840084008400
          8400A500A500C600E700E700080129014A016B01AD01CE01EF01100218633967
          39E7ADB5ADB5AD358C3163006300630063006300840084008400A500A500C600
          E700E700080129014A016B018C01AD01EF01F75E1863186318E3ADB5ADB58CB1
          8C318C316300630063006300630084008400A500A500C600E700E70008012901
          4A016B018C01AD01D65AF75EF75EF7DE18E3FFFF8CB18CB18CB18C318C316300
          63006300630084008400A500A500C600E700E700080129014A016B018C01B556
          D65AD65AF7DEF7DEFFFFFFFF8CB18CB18CB18C318C318C316300630063008400
          8400A500A500C600E700E700080129014A016B019452B556B556D65AD6DAD6DA
          FFFFFFFFFFFFFFFF8CB18CB18C31AD35AD356300630084008400A500A500C600
          E700E700080129014A01734E94529452B556B5D6FFFFFFFFFFFFFFFFFFFFFFFF
          8CB18CB1ADB5ADB5AD35AD35AD3584008400A500A500C600E700E70008013146
          524A734E734E94D294D2B5D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5
          ADB5ADB5AD35CE39CE39EF3DEF3DEF3D1042104231463146524A52CA73CEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADB5ADB5ADB5CEB9CEB9
          CEB9EFBDEFBDEFBD10C210C231C631C652CA52CA73CEFFFFFFFFFFFFFFFFFFFF
          FFFF}
        ImageMask = {
          424D620600000000000042000000280000001C0000001C000000010010000300
          00002006000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7F000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
          000000000000000000000000000000000000000000000000000000000000FF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000FF7FFF7FFF7FFF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000FF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          FF7FFF7F00000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7F00000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000FF7F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF7F000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000FF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          FF7FFF7F00000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000FF7FFF7FFF7F0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF7FFF7FFF7FFF7FFF7F0000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          00000000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7F0000000000000000000000000000000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
          0000000000000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7F}
      end
      object VoiceF9: THemisphereButton
        Tag = 9
        Left = 149
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '9'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = VoiceFButtonClick
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F0000FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F0200FF7FB556D65AF75E186339675A6B
          E001C001A001A0018001FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75E4002200220020002E001E001C001A0016001FF7FFF7FFF7FFF7FFF7F
          970194529452B556B55680026002600260024002200220020002E001A0018001
          FF7FFF7FFF7FFF7FAD02734E734E9452A002A002A002A0028002800260026002
          40020002E001A0016001FF7FFF7FFF7F6C01524A524A734EE002C002C002C002
          600000000000C001800240020002E001A001FF7FFF7FDE7B0600314631460003
          00030003000300020000E001E00100004002800240020002C0018001DE7BDE7B
          200010421042200320032003200320032003200320030000E001A00260022002
          E001A001BD77BD77020010421042200320032003200320030001000000008000
          6001A00260022002E001A001BD77BD770800EF3DEF3D4003400340034003A001
          0000A002A00200008001C002800240020002C0019C739C730200CE39CE394003
          400340034003000100004003200300008001C002800260022002E0017B6F7B6F
          7D02CE39CE39CE39600360036003A0010000A002000200008002C002A0026002
          20025A6B5A6B5A6BBF03AD35AD35AD3580036003600360030001000000000002
          0003C002A002600240023967396739670300AD35AD35AD35AD35800360036003
          40034003200320030003C002A0028002F75E1863186339675A01AD35AD35AD35
          AD35AD358003600340034003200320030003E002A002B556D65AF75EF75E1863
          B481FF7FAD35AD35AD35AD35AD35CE3940034003200320030003734E9452B556
          B556D65AF75EFF7F2000FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F3E01FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7F3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F2201FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F3E01FF7FB556D65AF75E186339675A6B
          00022002400240026002FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75EC001C001C001E00100020002200240028002FF7FFF7FFF7FFF7FFF7F
          BF0394529452B556B556800180018001A001A001C001C001E001200240028002
          FF7FFF7FFF7FFF7F0200734E734E945240014001400140016001600180018001
          A001E001000240028002FF7FFF7FFF7F0200524A524A734E2001200120012001
          200000000000E0006001A001E00120024002FF7FFF7FDE7B9B0131463146E000
          E000E000E000A0000000A000A000000000016001A001E00120026002DE7BDE7B
          7B0310421042C000C000C000C000C000C000C000C0000000A00040018001C001
          00024002BD77BD773E0110421042C000C000C000C000C0004000000000002000
          800040018001C00100024002BD77BD777200EF3DEF3DA000A000A000A0006000
          0000A000A0000000800020016001A001E00120029C739C731300CE39CE39A000
          A000A000A00020000000C000C0000000800020016001A001C00100027B6F7B6F
          B400CE39CE39CE3980008000800040000000A00080000000C000200140018001
          C0015A6B5A6B5A6B1600AD35AD35AD3580008000800080002000000000008000
          E000200140018001C001396739673967EE00AD35AD35AD35AD35600080008000
          A000A000C000C000E000200140018001F75E1863186339672201AD35AD35AD35
          AD35AD3580008000A000A000C000C000E00020014001B556D65AF75EF75E1863
          0200FF7FAD35AD35AD35AD35AD35CE39A000A000C000C000E000734E9452B556
          B556D65AF75EFF7F1E00FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F9800FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7FB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object VoiceF10: THemisphereButton
        Tag = 10
        Left = 167
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '10'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = VoiceFButtonClick
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F0000FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F0200FF7FB556D65AF75E186339675A6B
          E001C001A001A0018001FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75E4002200220020002E001E001C001A0016001FF7FFF7FFF7FFF7FFF7F
          970194529452B556B55680026002600260024002200220020002E001A0018001
          FF7FFF7FFF7FFF7FAD02734E734E9452A002A002A002A0028002800260026002
          40020002E001A0016001FF7FFF7FFF7F6C01524A524A734EE002E0010000E001
          C002C00240010000000080010002E001A001FF7FFF7FDE7B0600314631460003
          0003000200000002000360020000E001C0010000E0010002C0018001DE7BDE7B
          2000104210422003200300020000000220038001000020036002000080012002
          E001A001BD77BD77020010421042200320030002000000022003000100002003
          6002000020012002E001A001BD77BD770800EF3DEF3DA0020001200200002002
          400300010000200360020000400140020002C0019C739C730200CE39CE39C002
          00000000000020024003A0010000200380020000A00160022002E0017B6F7B6F
          7D02CE39CE39CE39C0020000000040024003A0020000A0020002000020026002
          20025A6B5A6B5A6BBF03AD35AD35AD358003E002000040024003400380010000
          0000E001A002600240023967396739670300AD35AD35AD35AD35800360036003
          40034003200320030003C002A0028002F75E1863186339675A01AD35AD35AD35
          AD35AD358003600340034003200320030003E002A002B556D65AF75EF75E1863
          B481FF7FAD35AD35AD35AD35AD35CE3940034003200320030003734E9452B556
          B556D65AF75EFF7F2000FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F3E01FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7F3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F2201FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F3E01FF7FB556D65AF75E186339675A6B
          00022002400240026002FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75EC001C001C001E00100020002200240028002FF7FFF7FFF7FFF7FFF7F
          BF0394529452B556B556800180018001A001A001C001C001E001200240028002
          FF7FFF7FFF7FFF7F0200734E734E945240014001400140016001600180018001
          A001E001000240028002FF7FFF7FFF7F0200524A524A734E2001C0000000C000
          20012001A000000000000001E00120024002FF7FFF7FDE7B9B0131463146E000
          E000A0000000A0000001C0000000A000C00000006001E00120026002DE7BDE7B
          7B0310421042C000C000800000008000C00060000000C000E00000000001C001
          00024002BD77BD773E0110421042C000C000800000008000C00040000000C000
          E0000000C000C00100024002BD77BD777200EF3DEF3D80004000600000008000
          C00040000000C000C0000000A000A001E00120029C739C731300CE39CE398000
          0000000000006000A00060000000C000C0000000E000A001C00100027B6F7B6F
          B400CE39CE39CE396000000000006000A000A0000000A000A000000020018001
          C0015A6B5A6B5A6B1600AD35AD35AD358000600000006000A000A00060000000
          0000C00040018001C001396739673967EE00AD35AD35AD35AD35600080008000
          A000A000C000C000E000200140018001F75E1863186339672201AD35AD35AD35
          AD35AD3580008000A000A000C000C000E00020014001B556D65AF75EF75E1863
          0200FF7FAD35AD35AD35AD35AD35CE39A000A000C000C000E000734E9452B556
          B556D65AF75EFF7F1E00FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F9800FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7FB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object VoiceF11: THemisphereButton
        Tag = 11
        Left = 185
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '11'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = VoiceFButtonClick
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F0000FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F0200FF7FB556D65AF75E186339675A6B
          E001C001A001A0018001FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75E4002200220020002E001E001C001A0016001FF7FFF7FFF7FFF7FFF7F
          970194529452B556B55680026002600260024002200220020002E001A0018001
          FF7FFF7FFF7FFF7FAD02734E734E9452A002A002A002A0028002800260026002
          40020002E001A0016001FF7FFF7FFF7F6C01524A524A734EE002000200000002
          C002C002A002E0010000A0010002E001A001FF7FFF7FDE7B0600314631460003
          00032002000020020003E002E00200020000C00140020002C0018001DE7BDE7B
          2000104210422003200340020000400220032003200340020000E00160022002
          E001A001BD77BD77020010421042200320034002000040022003200320034002
          0000E00160022002E001A001BD77BD770800EF3DEF3DC0024001400200004002
          4003C002400140020000E001800240020002C0019C739C730200CE39CE39E002
          00000000000060024003C0020000000000000002800260022002E0017B6F7B6F
          7D02CE39CE39CE396002000000006002400340034002000000000002A0026002
          20025A6B5A6B5A6BBF03AD35AD35AD358003E00200006002400340032003A002
          00000002A002600240023967396739670300AD35AD35AD35AD35800360036003
          40034003200320030003C002A0028002F75E1863186339675A01AD35AD35AD35
          AD35AD358003600340034003200320030003E002A002B556D65AF75EF75E1863
          B481FF7FAD35AD35AD35AD35AD35CE3940034003200320030003734E9452B556
          B556D65AF75EFF7F2000FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F3E01FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7F3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F2201FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F3E01FF7FB556D65AF75E186339675A6B
          00022002400240026002FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75EC001C001C001E00100020002200240028002FF7FFF7FFF7FFF7FFF7F
          BF0394529452B556B556800180018001A001A001C001C001E001200240028002
          FF7FFF7FFF7FFF7F0200734E734E945240014001400140016001600180018001
          A001E001000240028002FF7FFF7FFF7F0200524A524A734E2001C0000000C000
          200120014001E00000002001E00120024002FF7FFF7FDE7B9B0131463146E000
          E000A0000000A000000100010001C00000000001A001E00120026002DE7BDE7B
          7B0310421042C000C000800000008000C000C000C00080000000E0008001C001
          00024002BD77BD773E0110421042C000C000800000008000C000C000C0008000
          0000E0008001C00100024002BD77BD777200EF3DEF3DA0004000800000008000
          C000A000400080000000E0006001A001E00120029C739C731300CE39CE398000
          0000000000006000A000A000000000000000C0006001A001C00100027B6F7B6F
          B400CE39CE39CE396000000000006000A000C000800000000000C00040018001
          C0015A6B5A6B5A6B1600AD35AD35AD358000600000006000A000A000C000A000
          0000C00040018001C001396739673967EE00AD35AD35AD35AD35600080008000
          A000A000C000C000E000200140018001F75E1863186339672201AD35AD35AD35
          AD35AD3580008000A000A000C000C000E00020014001B556D65AF75EF75E1863
          0200FF7FAD35AD35AD35AD35AD35CE39A000A000C000C000E000734E9452B556
          B556D65AF75EFF7F1E00FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F9800FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7FB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
      object VoiceF12: THemisphereButton
        Tag = 12
        Left = 203
        Top = 8
        Width = 19
        Height = 19
        AllowAllUp = False
        AttenControl = 1
        BevelInner = hbNone
        BevelOuter = hbLowered
        BevelWidth = 2
        BorderColor = clGray
        BorderStyle = bsNone
        Caption = '12'
        Down = False
        FaceColor = clGreen
        FaceShaded = True
        FaceTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlyphIndex = 1
        GlyphShaded = True
        GlyphMapped = False
        GlyphTransparent = True
        GroupIndex = 0
        NumGlyphs = 1
        OnClick = VoiceFButtonClick
        OnMouseDown = VoiceFMouseDown
        ParentFont = False
        ParentShowHint = False
        PopupMenu = VoiceFMenu
        ShowHint = True
        GlyphValid = False
        ImageOut = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F0000FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F0200FF7FB556D65AF75E186339675A6B
          E001C001A001A0018001FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75E4002200220020002E001E001C001A0016001FF7FFF7FFF7FFF7FFF7F
          970194529452B556B55680026002600260024002200220020002E001A0018001
          FF7FFF7FFF7FFF7FAD02734E734E9452A002A002A002A0028002800260026002
          40020002E001A0016001FF7FFF7FFF7F6C01524A524A734EE002000200000002
          C002800100000000000000002001E001A001FF7FFF7FDE7B0600314631460003
          00032002000020020003800200000000A002800240020002C0018001DE7BDE7B
          2000104210422003200340020000400220032003C0010000A000A00260022002
          E001A001BD77BD77020010421042200320034002000040022003200320034001
          0000800060022002E001A001BD77BD770800EF3DEF3DC0024001400200004002
          400320032003200320010000C00140020002C0019C739C730200CE39CE39E002
          0000000000006002400340032003200380020000600160022002E0017B6F7B6F
          7D02CE39CE39CE396002000000006002400340020000400280020000E0016002
          20025A6B5A6B5A6BBF03AD35AD35AD358003E002000060024003400340010000
          00002001A002600240023967396739670300AD35AD35AD35AD35800360036003
          40034003200320030003C002A0028002F75E1863186339675A01AD35AD35AD35
          AD35AD358003600340034003200320030003E002A002B556D65AF75EF75E1863
          B481FF7FAD35AD35AD35AD35AD35CE3940034003200320030003734E9452B556
          B556D65AF75EFF7F2000FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F3E01FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7F3E01}
        ImageIn = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7F1863396739675A6B7B6F9C73BD77BD77DE7BDE7BFF7FFF7F
          FF7FFF7FFF7FFF7F2201FF7FFF7FF75EF75E186339675A6B7B6F9C73BD77BD77
          DE7BFF7FFF7FFF7FFF7FFF7FFF7FFF7F3E01FF7FB556D65AF75E186339675A6B
          00022002400240026002FF7FFF7FFF7FFF7FFF7FFF7FFF7F3E019452B556B556
          D65AF75EC001C001C001E00100020002200240028002FF7FFF7FFF7FFF7FFF7F
          BF0394529452B556B556800180018001A001A001C001C001E001200240028002
          FF7FFF7FFF7FFF7F0200734E734E945240014001400140016001600180018001
          A001E001000240028002FF7FFF7FFF7F0200524A524A734E2001C0000000C000
          2001A0000000000000000000000120024002FF7FFF7FDE7B9B0131463146E000
          E000A0000000A0000001E0000000000040016001A001E00120026002DE7BDE7B
          7B0310421042C000C000800000008000C000C00060000000400040018001C001
          00024002BD77BD773E0110421042C000C000800000008000C000C000C0004000
          000040008001C00100024002BD77BD777200EF3DEF3DA0004000800000008000
          C000C000C000C000600000000001A001E00120029C739C731300CE39CE398000
          0000000000006000A000C000C000C000E0000000C000A001C00100027B6F7B6F
          B400CE39CE39CE396000000000006000A000800000008000C0000000E0008001
          C0015A6B5A6B5A6B1600AD35AD35AD358000600000006000A000A00040000000
          0000600040018001C001396739673967EE00AD35AD35AD35AD35600080008000
          A000A000C000C000E000200140018001F75E1863186339672201AD35AD35AD35
          AD35AD3580008000A000A000C000C000E00020014001B556D65AF75EF75E1863
          0200FF7FAD35AD35AD35AD35AD35CE39A000A000C000C000E000734E9452B556
          B556D65AF75EFF7F1E00FF7FFF7FAD35AD35AD35AD35CE39CE39EF3D10421042
          3146524A734E9452B556B556FF7FFF7F9800FF7FFF7FFF7FAD35AD35AD35CE39
          CE39EF3D104210423146524A734E94529452FF7FFF7FFF7FB400}
        ImageMask = {
          424D3A0300000000000042000000280000001300000013000000010010000300
          0000F802000000000000000000000000000000000000007C0000E00300001F00
          0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FFF7FFF7F
          FF7FFF7FFF7FFF7F9B01FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0200FF7FFF7FFF7F0000000000000000
          000000000000000000000000000000000000FF7FFF7FFF7F7B03FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          007CFF7FFF7F0000000000000000000000000000000000000000000000000000
          00000000FF7FFF7FFF7FFF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7F0000FF7F000000000000000000000000
          00000000000000000000000000000000000000000000FF7FB581000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          7E01000000000000000000000000000000000000000000000000000000000000
          0000000000000000070200000000000000000000000000000000000000000000
          000000000000000000000000000000007C010000000000000000000000000000
          0000000000000000000000000000000000000000000000007502000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          A001FF7F00000000000000000000000000000000000000000000000000000000
          000000000000FF7FAB02FF7F0000000000000000000000000000000000000000
          0000000000000000000000000000FF7FC501FF7FFF7F00000000000000000000
          0000000000000000000000000000000000000000FF7FFF7F1000FF7FFF7F0000
          00000000000000000000000000000000000000000000000000000000FF7FFF7F
          0E00FF7FFF7FFF7F000000000000000000000000000000000000000000000000
          0000FF7FFF7FFF7FDF00FF7FFF7FFF7FFF7FFF7F000000000000000000000000
          000000000000FF7FFF7FFF7FFF7FFF7F0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F
          00000000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000}
      end
    end
    object MainToolBar: TPanel
      Left = 0
      Top = 33
      Width = 528
      Height = 33
      Align = alBottom
      TabOrder = 2
      ExplicitWidth = 524
      DesignSize = (
        528
        33)
      object SpeedButton4: TSpeedButton
        Left = 8
        Top = 4
        Width = 25
        Height = 25
        Hint = 'Open|Open a new file'
        Glyph.Data = {
          96090000424D9609000000000000360000002800000028000000140000000100
          1800000000006009000000000000000000000000000000000000007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF007F7F007F7F007F7F007F7F007F7F
          7F7F7F0000000000000000000000000000000000000000000000000000000000
          00000000000000000000007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F7F
          7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F
          7F7F7F7F7F7F007F7FFFFFFF007F7F007F7F007F7F007F7F000000000000BFBF
          BF00FFFFBFBFBF00FFFFBFBFBF00FFFFBFBFBF00FFFFBFBFBF00FFFFBFBFBF00
          FFFF000000007F7F007F7F007F7F007F7F007F7F7F7F7F7F7F7F007F7FFFFFFF
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F
          7FFFFFFF007F7F007F7F007F7F007F7F000000FFFFFF000000BFBFBF00FFFFBF
          BFBF00FFFFBFBFBF00FFFFBFBFBF00FFFFBFBFBF00FFFFBFBFBF000000007F7F
          007F7F007F7F007F7F007F7F7F7F7FFFFFFF7F7F7FFFFFFF007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F007F7FFFFFFF00
          7F7F007F7F007F7F00000000FFFF00000000FFFFBFBFBF00FFFFBFBFBF00FFFF
          BFBFBF00FFFFBFBFBF00FFFFBFBFBF00FFFFBFBFBF000000007F7F007F7F007F
          7F007F7F7F7F7FFFFFFF7F7F7F007F7FFFFFFF007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F
          000000FFFFFF00FFFF00000000FFFFBFBFBF00FFFFBFBFBF00FFFFBFBFBF00FF
          FFBFBFBF00FFFFBFBFBF00FFFF000000007F7F007F7F007F7F007F7F7F7F7FFF
          FFFF007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F7F7F7F007F7FFFFFFF007F7F007F7F00000000FFFFFFFF
          FF000000BFBFBF00FFFFBFBFBF00FFFFBFBFBF00FFFFBFBFBF00FFFFBFBFBF00
          FFFFBFBFBF00FFFF000000007F7F007F7F007F7F7F7F7FFFFFFF007F7F7F7F7F
          007F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF007F7F007F7F007F7F007F7F007F
          7F007F7F7F7F7FFFFFFF007F7F007F7F000000FFFFFF00FFFFFFFFFF00000000
          0000000000000000000000BFBFBF00FFFFBFBFBF00FFFFBFBFBF00FFFFBFBFBF
          000000007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F7F7F7F7F7F7F7F7F
          7F7F7F7F7F7F7F007F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F00
          7F7F007F7F007F7F00000000FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF
          FFFFFF000000000000000000000000000000000000000000007F7F007F7F007F
          7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F
          7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F007F7F007F7F007F7F007F7F
          000000FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FF
          FFFFFFFF00FFFF000000007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFF
          FFFF007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F00000000FFFFFFFF
          FF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00
          0000007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F
          007F7F007F7F007F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F007F
          7F007F7F007F7F007F7F007F7F007F7F000000FFFFFF00FFFFFFFFFF00FFFFFF
          FFFF000000000000000000000000000000000000000000007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F7F7F7FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFF7F7F
          7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F000000000000000000000000000000007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = FileOpen
      end
      object SpeedButton5: TSpeedButton
        Left = 32
        Top = 4
        Width = 25
        Height = 25
        Hint = 'Save|Save current file'
        Glyph.Data = {
          96090000424D9609000000000000360000002800000028000000140000000100
          1800000000006009000000000000000000000000000000000000007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7FFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF007F7F007F7F00
          7F7F007F7F007F7F007F7F7F7F7F000000000000000000000000000000000000
          0000000000000000000000000000000000007F7F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F
          7F7F7F7F7F7F7F7F7F7F7F7F7F7F007F7FFFFFFF007F7F007F7F007F7F007F7F
          007F7F000000FF0000FF00000000007F7F7FFF0000FF0000FFFFFFBFBFBFBFBF
          BF000000FF0000FF0000000000007F7F007F7F007F7F007F7F007F7F007F7F7F
          7F7FFFFFFF007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F7F7F7F
          FFFFFF007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F000000FF00
          00FF00000000007F7F7FFF0000FF0000FFFFFFBFBFBFBFBFBF000000FF0000FF
          0000000000007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F
          7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F7F7F
          7FFFFFFF007F7F007F7F007F7F007F7F007F7F000000FF0000FF0000000000BF
          BFBF7F7F7F7F7F7FBFBFBFBFBFBFBFBFBF000000FF0000FF0000000000007F7F
          007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F7F7F7FFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F007F7F007F7F7F7F7FFFFFFF007F7F00
          7F7F007F7F007F7F007F7F000000FF0000FF00007F7F00000000000000000000
          0000000000000000007F7F00FF0000FF0000000000007F7F007F7F007F7F007F
          7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F7F7F7F7F7F7F7F7F7F7F7F7F7F
          7F7F7F7F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F
          007F7F000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
          00FF0000FF0000FF0000000000007F7F007F7F007F7F007F7F007F7F007F7F7F
          7F7FFFFFFF007F7F007F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F000000FF00
          007F7F000000000000000000000000000000000000000000000000007F7F00FF
          0000000000007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F
          7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F007F7FFFFFFF7F7F
          7FFFFFFF007F7F007F7F007F7F007F7F007F7F000000FF0000000000FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF0000000000007F7F
          007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF7F7F7FFFFFFF007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF7F7F7FFFFFFF007F7F00
          7F7F007F7F007F7F007F7F000000FF0000000000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF000000FF0000000000007F7F007F7F007F7F007F
          7F007F7F007F7F7F7F7FFFFFFF7F7F7FFFFFFF007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F7F7F7FFFFFFF7F7F7FFFFFFF007F7F007F7F007F7F007F7F
          007F7F000000FF0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF000000FF0000000000007F7F007F7F007F7F007F7F007F7F007F7F7F
          7F7FFFFFFF7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          7F7F7FFFFFFF7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F000000FF00
          00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
          0000000000007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF7F7F7F
          FFFFFF007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF7F7F
          7FFFFFFF007F7F007F7F007F7F007F7F007F7F000000000000000000FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000007F7F
          007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF7F7F7FFFFFFF007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF7F7F7FFFFFFF007F7F00
          7F7F007F7F007F7F007F7F000000FF0000000000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF000000FF0000000000007F7F007F7F007F7F007F
          7F007F7F007F7F7F7F7FFFFFFF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF7F7F7FFFFFFF7F7F7F007F7F007F7F007F7F007F7F007F7F
          007F7F7F7F7F0000000000000000000000000000000000000000000000000000
          000000000000000000007F7F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F
          7F7F7F7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = FileSave
      end
      object SpeedButton6: TSpeedButton
        Left = 68
        Top = 4
        Width = 25
        Height = 25
        Hint = 'Exit|Exit zLog'
        Glyph.Data = {
          96090000424D9609000000000000360000002800000028000000140000000100
          1800000000006009000000000000000000000000000000000000007F7FBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF007F7FFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF007F7F
          007F7F007F7F007F7F007F7F007F7FFFFFFF7F7F7F7F7F7F7F7F7F7F7F7F7F7F
          7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7FFFFFFFBFBFBFFFFFFFBF
          BFBFFFFFFFBFBFBF7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F
          7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F007F7F007F7F007F7F007F7F007F
          7F007F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F
          7F7F7F7F7F7F7F7F7F7F7FBFBFBFBFBFBFFFFFFFBFBFBFFFFFFFBFBFBF7F7F7F
          7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F
          7F7F7F7F7F7F7FFFFFFF007F7F007F7F007F7FFFFFFFFFFFFF7F7F7F7F7F7F7F
          7F7F7F00007F00007F00007F00007F00007F00000000000000007F7F7F7F7F7F
          7F7F7FFFFFFFFFFFFFFFFFFF7F00007F00007F00007F00007F00007F00007F7F
          7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F00
          7F7F007F7F007F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F007F7F007F7F007F7F
          007F7F007F7F007F7F7F0000FF00FF7F007F000000000000BFBFBFFFFFFFFFFF
          FFFFFFFF7F0000007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F7F7F7FFFFFFF7F7F7F7F7F7F7F7F7FFFFFFF007F7F007F7F007F7F
          7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F7F00007F007FFF00FF7F007F000000FFFFFFFFFFFFFFFFFFFFFFFF7F000000
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F
          7F7F7FBFBFBF7F7F7F7F7F7FFFFFFF007F7F007F7F007F7F7F7F7FFFFFFF007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F0000FF00FF7F
          007FFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFF7F0000007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF7F7F7FBFBF
          BF7F7F7FFFFFFF007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F7F00007F007FFF00FF7F007F000000
          FFFFFFFFFF00FFFFFFFFFF007F0000007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F7F7F7F7F7F7FBFBFBF7F7F7F7F7F7FFFFFFF00
          7F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F7F0000FF00FF7F007FFF00FF000000FFFFFFFFFFFFFFFF
          FFFFFFFF7F0000007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F7F7F7FFFFFFF7F7F7FBFBFBF7F7F7FFFFFFF007F7F007F7F007F7F
          7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F7F00007F007FFF00FF7F007F000000FFFFFFFFFF00FFFFFFFFFF007F000000
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F
          7F7F7FBFBFBF7F7F7F7F7F7FFFFFFF007F7F007F7F007F7F7F7F7FFFFFFF007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F0000FF00FF7F
          007FFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFF7F0000007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF7F7F7FBFBF
          BF7F7F7FFFFFFF007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F7F00007F007FFF00FF7F007F000000
          FFFFFFFFFF00FFFFFFFFFF007F0000007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F7F7F7F7F7F7FBFBFBF7F7F7F7F7F7FFFFFFF00
          7F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F7F0000FF00FF7F007FFF00FF000000FFFF00FFFFFFFFFF
          00FFFFFF7F0000007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F7F7F7FFFFFFF7F7F7FBFBFBF7F7F7FFFFFFF007F7F007F7F007F7F
          7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F7F00007F007FFF00FF7F007F000000FFFFFFFFFF00FFFFFFFFFF007F000000
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F
          7F7F7FBFBFBF7F7F7F7F7F7FFFFFFF007F7F007F7F007F7F7F7F7FFFFFFF007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F0000FF00FF7F
          007FFF00FF000000FFFF00FFFFFFFFFF00FFFFFF7F0000007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF7F7F7FFFFF
          FF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FFFFFFF007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F7F00007F00007F00007F00007F0000
          7F00007F00007F00007F00007F0000007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F
          7F7F7F7F7F7F7F7F7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F000000000000000000000000000000000000007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
          007F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7FFFFFFF007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
          000000FF0000FF0000FF0000FF00000000007F7F007F7F007F7F007F7F007F7F
          007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFF
          FFFFFFFFFFFFFFFFFFFF7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F00
          7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F000000000000000000
          000000000000000000007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
          7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F7F7F7F7F7F7F7F7F7F7F
          7F7F7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = FileExit
      end
      object PartialCheckButton: TSpeedButton
        Left = 184
        Top = 4
        Width = 25
        Height = 25
        Glyph.Data = {
          42010000424D4201000000000000760000002800000011000000110000000100
          040000000000CC00000000000000000000001000000010000000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          77777000000070000000007777777000000070FFFFFFF07777700000000070F7
          7777F07777000000000070F77777F07770007000000070F77780008700077000
          000070F7700FFF0000777000000070F708FFFF0807777000000070F80E000F07
          08777000000070F0EFEFEF0770777000000070F0F0000F077077700000007000
          EFEFFF0770777000000077780000000708777000000077770077777807777000
          0000777770077700777770000000777777800087777770000000777777777777
          777770000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = actionShowCheckPartialExecute
      end
      object ScoreButton: TSpeedButton
        Left = 104
        Top = 4
        Width = 25
        Height = 25
        Hint = 'Score'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333333333333333333FFFFFFFFFFF33330000000000
          03333377777777777F33333003333330033333377FF333377F33333300333333
          0333333377FF33337F3333333003333303333333377FF3337333333333003333
          333333333377FF3333333333333003333333333333377FF33333333333330033
          3333333333337733333333333330033333333333333773333333333333003333
          33333333337733333F3333333003333303333333377333337F33333300333333
          03333333773333337F33333003333330033333377FFFFFF77F33330000000000
          0333337777777777733333333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = actionShowScoreExecute
      end
      object MultiButton: TSpeedButton
        Left = 128
        Top = 4
        Width = 25
        Height = 25
        Hint = 'Multiplier info'
        Caption = 'X'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = actionShowMultipliersExecute
      end
      object RateButton: TSpeedButton
        Left = 152
        Top = 4
        Width = 25
        Height = 25
        Hint = 'QSO rate'
        Glyph.Data = {
          42010000424D4201000000000000760000002800000011000000110000000100
          040000000000CC00000000000000000000001000000010000000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
          DDDDD0000000DDDDDDDDDDDDDDDDD0000000DDDDDDDDDDDDDDDDD0000000DD00
          00000000000DD0000000DDDDD22D44D11DDDD0000000DD1DD22D44D11DDDD000
          0000DDDDD22D44D11DDDD0000000DD1DD22D44D11DDDD0000000DDDDD22D44D1
          1DDDD0000000DD1DDDDD44D11DDDD0000000DDDDDDDD44D11DDDD0000000DD1D
          DDDD44DDDDDDD0000000DDDDDDDD44DDDDDDD0000000DD1DDDDDDDDDDDDDD000
          0000DDDDDDDDDDDDDDDDD0000000DDDDDDDDDDDDDDDDD0000000DDDDDDDDDDDD
          DDDDD0000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = actionShowQsoRateExecute
      end
      object LogButton: TSpeedButton
        Left = 250
        Top = 4
        Width = 25
        Height = 25
        Hint = 'Log a QSO'
        Glyph.Data = {
          42010000424D4201000000000000760000002800000011000000110000000100
          040000000000CC00000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777C87777
          77777000000077777CC877777777700000007777CCC88888887770000000777C
          CCCCCCCCC8877000000077CCCCCCCCCCCC88700000007CCCCCCCCCCCCCC88000
          000077CCCCCCCCCCCCCC80000000777CCCCCCCCCCCCC800000007777CCC877CC
          CCCC8000000077777CC8777CCCCC80000000777777C7777CCCCC800000007777
          7777777CCCCC8000000077777777777CCCCC8000000077777777777CCCCC8000
          000077777777777CCCCC8000000077777777777CCCCC70000000777777777777
          777770000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = LogButtonClick
      end
      object Options2Button: TSpeedButton
        Left = 308
        Top = 4
        Width = 25
        Height = 25
        Hint = 'Operation settings'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555550FF0559
          1950555FF75F7557F7F757000FF055591903557775F75557F77570FFFF055559
          1933575FF57F5557F7FF0F00FF05555919337F775F7F5557F7F700550F055559
          193577557F7F55F7577F07550F0555999995755575755F7FFF7F5570F0755011
          11155557F755F777777555000755033305555577755F75F77F55555555503335
          0555555FF5F75F757F5555005503335505555577FF75F7557F55505050333555
          05555757F75F75557F5505000333555505557F777FF755557F55000000355557
          07557777777F55557F5555000005555707555577777FF5557F55553000075557
          0755557F7777FFF5755555335000005555555577577777555555}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = menuOptionsClick
      end
      object SuperCheckButtpn: TSpeedButton
        Left = 208
        Top = 4
        Width = 25
        Height = 25
        Glyph.Data = {
          42010000424D4201000000000000760000002800000011000000110000000100
          040000000000CC00000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          77777000000070000000007777777000000070FFFFFFF07777799000000070F7
          7777F07777999000000070F77777F07779997000000070F77789998799977000
          000070F7799FFF0999777000000070F798FFFF0897777000000070F89E000F07
          98777000000070F9EFEFEF0779777000000070F9F0000F077977700000007009
          EFEFFF0779777000000077789000000798777000000077779977777897777000
          0000777779977799777770000000777777899987777770000000777777777777
          777770000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = actionShowSuperCheckExecute
      end
      object PacketClusterButton: TSpeedButton
        Left = 355
        Top = 4
        Width = 25
        Height = 25
        Hint = 'Packet Cluster'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          5555555555FFFFF555555555544C4C5555555555F888885FF5555554C444C444
          5555555885FF55885F55554C4AA4444445555585588F55558FF554C4CAA4C4C4
          AA5558F5588FF55588F554CCCAAA4444AA5558555888F555885FCCCCCAAACCC4
          C4458F55F888F555558F4CCAAAAACCC444C58F588888F5F5558FC4AAAAAACAC4
          CCC58F888888F8FF558F4CCAAAAAAAAC4C458F588888888F558FCCCAACC4AAAC
          C4C585F8855F888FF5855CCCCCAAAAAA4C5558F5FF888888F8F554CAAAAAAAAA
          CC55585888888888F85555AAAACCACAAC5555588885585888555555AACC4C4CC
          5555555885FFFF88555555555C4CCC5555555555588888555555}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = actionShowPacketClusterExecute
      end
      object ZServerIcon: TImage
        Left = 387
        Top = 4
        Width = 30
        Height = 25
        Picture.Data = {
          07544269746D617056070000424D560700000000000036040000280000001E00
          0000190000000100080000000000200300000000000000000000000100000001
          0000000000004000000080000000FF000000002000004020000080200000FF20
          0000004000004040000080400000FF400000006000004060000080600000FF60
          0000008000004080000080800000FF80000000A0000040A0000080A00000FFA0
          000000C0000040C0000080C00000FFC0000000FF000040FF000080FF0000FFFF
          0000000020004000200080002000FF002000002020004020200080202000FF20
          2000004020004040200080402000FF402000006020004060200080602000FF60
          2000008020004080200080802000FF80200000A0200040A0200080A02000FFA0
          200000C0200040C0200080C02000FFC0200000FF200040FF200080FF2000FFFF
          2000000040004000400080004000FF004000002040004020400080204000FF20
          4000004040004040400080404000FF404000006040004060400080604000FF60
          4000008040004080400080804000FF80400000A0400040A0400080A04000FFA0
          400000C0400040C0400080C04000FFC0400000FF400040FF400080FF4000FFFF
          4000000060004000600080006000FF006000002060004020600080206000FF20
          6000004060004040600080406000FF406000006060004060600080606000FF60
          6000008060004080600080806000FF80600000A0600040A0600080A06000FFA0
          600000C0600040C0600080C06000FFC0600000FF600040FF600080FF6000FFFF
          6000000080004000800080008000FF008000002080004020800080208000FF20
          8000004080004040800080408000FF408000006080004060800080608000FF60
          8000008080004080800080808000FF80800000A0800040A0800080A08000FFA0
          800000C0800040C0800080C08000FFC0800000FF800040FF800080FF8000FFFF
          80000000A0004000A0008000A000FF00A0000020A0004020A0008020A000FF20
          A0000040A0004040A0008040A000FF40A0000060A0004060A0008060A000FF60
          A0000080A0004080A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0
          A00000C0A00040C0A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFF
          A0000000C0004000C0008000C000FF00C0000020C0004020C0008020C000FF20
          C0000040C0004040C0008040C000FF40C0000060C0004060C0008060C000FF60
          C0000080C0004080C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0
          C00000C0C00040C0C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFF
          C0000000FF004000FF008000FF00FF00FF000020FF004020FF008020FF00FF20
          FF000040FF004040FF008040FF00FF40FF000060FF004060FF008060FF00FF60
          FF000080FF004080FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0
          FF0000C0FF0040C0FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFF
          FF000C0000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          000000480048004800E0E0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          000000000000000000000000E0E00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0000001F1F1F001C00E0E0000CE00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0000000000000000000000000CE00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          00000C48484848484848480C0CE00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          00000C0C0000000000000C0C0CE00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0D
          00000C0C0C0C0C0C0C0C0C0C0CE00C0CB6B6B6B6B60CB6B6B6B6B6B6B6B6B66D
          00000C0C0C0C0C0C0C0C0C0C0CE00C0CB6B6B6B6B66D0C6D6DB6B6B66D6D6D6D
          0000000000000000000000000CE00C0CB6B6B6B6B66D0C0C0CB6B6B66D0C0C0C
          000000480048004800E0E0000CE00C0CB6B6B6B6B66DB6B6B6B6B6B6B6B6B60C
          000000000000000000000000E0E0E0E0B6B6B6B6B66DB603030303030303B66D
          0000001F1F1F001C00E0E0000CE00C0CB6B6B6B6B66DB603030303030303B66D
          0000000000000000000000000CE00C0CB6B6B6B6B66DB603030303030303B66D
          00000C48484848484848480C0CE00C0CB6B6B6B6B66DB603030303030303B66D
          00000C0C0000000000000C0C0CE00C0CB6B61CB61C6DB603030303030303B66D
          00000C0C0C0C0C0C0C0C0C0C0CE00C0CB6B6B6B6B66DB603030303030303B66D
          00000C0C0C0C0C0C0C0C0C0C0CE00C0CB6B6B6B6B66DB6B6B6B6B6B6B6B6B66D
          0000000000000000000000000CE00C0C0C6D6D6D6D6D0C6D6D6D6D6D6D6D6D6D
          000000480048004800E0E0000CE00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          000000000000000000000000E0E00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0000001F1F1F001C00E0E0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          00000C48484848484848480C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          00000C0C0000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0000}
        Stretch = True
        Transparent = True
        Visible = False
      end
      object OptionsButton: TSpeedButton
        Left = 284
        Top = 4
        Width = 25
        Height = 25
        Hint = 'Hardware settings'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF8D8E8F191A1A191A1A282828D4D6D7FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF191A1AFF
          00FFFF00FF8D8E8F8D8E8FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          A6A8A9BEC0C1FF00FFD3D6D7373838FF00FFFF00FFA7A8A9636464FF00FFFF00
          FF9A9B9CD4D6D7FF00FFFF00FFB2B4B5454646454646373838282828A7A8A9FF
          00FFFF00FFFF00FF454646565657282828636464454646FF00FFFF00FF282828
          C9CBCCFF00FFC9CBCCD4D6D7FF00FFFF00FFFF00FFFF00FFFF00FFBEC0C1FF00
          FFFF00FF6364648D8E8FBEC0C1454646FF00FFFF00FFFF00FFFF00FF9A9B9C37
          38381A1A1A636464D4D6D7FF00FFFF00FFFF00FFB2B4B5565657FF00FF636464
          454646FF00FFFF00FFB2B4B5454646D4D6D7FF00FF9A9B9C454646FF00FFFF00
          FFA7A8A9282828C9CBCCFF00FFFF00FF6364649A9B9CFF00FF636464B2B4B5FF
          00FFFF00FFFF00FF454646C9CBCCFF00FF282828C9CBCCFF00FFFF00FFFF00FF
          6364649A9B9CFF00FF636464B2B4B5FF00FFFF00FFFF00FF454646C9CBCCFF00
          FF282828C9CBCCFF00FFFF00FF727374454646FF00FFFF00FFB2B4B5454646D4
          D6D7FF00FF9A9B9C454646FF00FFFF00FFA7A8A9282828BEC0C1BEC0C1454646
          FF00FFFF00FFFF00FFFF00FF9A9B9C3738381A1A1A636464D4D6D7FF00FFFF00
          FFFF00FFB2B4B5565657FF00FF282828C8CBCCFF00FFD3D6D7D3D6D7FF00FFFF
          00FFFF00FFFF00FFFF00FFBEC0C1FF00FFFF00FF6364648D8E8FFF00FFB2B4B5
          454646454646373838282828A6A8A9FF00FFFF00FFFF00FF4546464546462828
          28636464454646FF00FFFF00FFFF00FFA6A8A9B2B4B5FF00FFD3D6D7373838FF
          00FFFF00FFA6A8A9636464FF00FFFF00FF999B9CD3D6D7FF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF191A1AFF00FFFF00FF8D8E8F8D8E8FFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF80828219
          1A1A191A1A282828D3D6D7FF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentShowHint = False
        ShowHint = True
        OnClick = menuHardwareSettingsClick
      end
      object panelCQMode: TPanel
        Left = 494
        Top = 1
        Width = 33
        Height = 31
        Align = alRight
        BevelOuter = bvLowered
        Caption = 'CQ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = panelCQModeClick
        ExplicitLeft = 490
      end
      object comboBandPlan: TComboBox
        Left = 424
        Top = 6
        Width = 65
        Height = 21
        Style = csDropDownList
        Anchors = [akTop, akRight]
        ImeMode = imDisable
        TabOrder = 1
        TabStop = False
        OnChange = comboBandPlanChange
        ExplicitLeft = 420
      end
    end
  end
  object panelOutOfPeriod: TPanel
    Left = 0
    Top = 66
    Width = 528
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    Caption = #12467#12531#12486#12473#12488#26399#38291#22806#12391#12377#12290
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    Visible = False
    ExplicitWidth = 524
    DesignSize = (
      528
      28)
    object buttonCancelOutOfPeriod: TSpeedButton
      Left = 502
      Top = 5
      Width = 20
      Height = 20
      Anchors = [akTop, akRight]
      Caption = #215
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = buttonCancelOutOfPeriodClick
    end
  end
  object panelShowInfo: TPanel
    Left = 0
    Top = 94
    Width = 528
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    Color = clAqua
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
    Visible = False
    ExplicitWidth = 524
    object linklabelInfo: TLinkLabel
      Left = 117
      Top = 5
      Width = 150
      Height = 20
      Caption = 'new qso data arrived'
      TabOrder = 0
    end
  end
  object MainMenu: TMainMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 24
    Top = 144
    object FileMenu: TMenuItem
      Caption = #12501#12449#12452#12523'(&F)'
      OnClick = FileMenuClick
      object FileNewItem: TMenuItem
        Caption = #26032#12375#12356#12467#12531#12486#12473#12488'(&N)'
        Hint = 'Create a new file'
        OnClick = FileNew
      end
      object FileOpenItem: TMenuItem
        Caption = #12467#12531#12486#12473#12488#12434#38283#12367'(&O)'
        Hint = 'Open an existing file'
        OnClick = FileOpen
      end
      object FileSaveItem: TMenuItem
        Caption = #20445#23384'(&S)'
        Hint = 'Save current file'
        OnClick = FileSave
      end
      object FileSaveAsItem: TMenuItem
        Caption = #21517#21069#12434#20184#12369#12390#20445#23384'(&A)'
        Hint = 'Save current file under a new name'
        OnClick = FileSaveAs
      end
      object MergeFile1: TMenuItem
        Caption = #12452#12531#12509#12540#12488'...(&I)'
        OnClick = MergeFile1Click
      end
      object Backup1: TMenuItem
        Action = actionBackup
      end
      object Export1: TMenuItem
        Caption = #12456#12463#12473#12509#12540#12488'...(&E)'
        OnClick = Export1Click
      end
      object mSummaryFile: TMenuItem
        Caption = #12469#12510#12522#12540#12501#12449#12452#12523#12398#20316#25104
        OnClick = mSummaryFileClick
      end
      object mPXListWPX: TMenuItem
        Caption = #12503#12522#12501#12451#12483#12463#12473#12522#12473#12488'(WPX)'
        Visible = False
        OnClick = mPXListWPXClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object menuCorrectStartTime: TMenuItem
        Caption = #38283#22987#26085#26178#12398#20462#27491
        OnClick = menuCorrectStartTimeClick
      end
      object menuCorrectNR: TMenuItem
        Action = actionCorrectSentNr
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object FilePrintItem: TMenuItem
        Caption = #12525#12464#12398#21360#21047'(&P)(ZPRINT)'
        Hint = 'Print current file'
        Visible = False
        OnClick = FilePrint
      end
      object CreateELogJARL1: TMenuItem
        Caption = 'JARL E-Log 1.0'#12398#20316#25104
        Visible = False
        OnClick = CreateELogJARL1Click
      end
      object CreateELogJARL2: TMenuItem
        Caption = 'JARL E-Log 2.1'#12398#20316#25104
        Visible = False
        OnClick = CreateELogJARL2Click
      end
      object CreateJARLELog: TMenuItem
        Caption = 'Create JARL E-Log'
        OnClick = CreateJARLELogClick
      end
      object CreateCabrillo: TMenuItem
        Caption = 'Create Cabrillo'
        OnClick = CreateCabrilloClick
      end
      object CreateDupeCheckSheetZPRINT1: TMenuItem
        Caption = #12487#12517#12540#12503#12481#12455#12483#12463#12522#12473#12488#12398#20316#25104'(ZLIST)'
        Visible = False
        OnClick = CreateDupeCheckSheetZPRINT1Click
      end
      object mnMMTTY: TMenuItem
        Caption = 'MMTTY'#12398#12525#12540#12489
        OnClick = mnMMTTYClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object FileExitItem: TMenuItem
        Caption = #32066#20102'(&X)'
        Hint = 'Exit this application'
        ShortCut = 32883
        OnClick = FileExit
      end
    end
    object Windows1: TMenuItem
      Caption = #12454#12452#12531#12489#12454'(&W)'
      object Score1: TMenuItem
        Action = actionShowScore
      end
      object Multipliers1: TMenuItem
        Action = actionShowMultipliers
      end
      object QSOrate1: TMenuItem
        Action = actionShowQsoRate
      end
      object QSORateEx1: TMenuItem
        Action = actionShowQsoRateEx
      end
      object SuperCheck1: TMenuItem
        Action = actionShowSuperCheck
      end
      object N11: TMenuItem
        Action = actionShowSuperCheck2
      end
      object PartialCheck1: TMenuItem
        Action = actionShowCheckPartial
      end
      object CheckCall1: TMenuItem
        Action = actionShowCheckCall
      end
      object mnCheckMulti: TMenuItem
        Action = actionShowCheckMulti
      end
      object mnCheckCountry: TMenuItem
        Action = actionShowCheckCountry
      end
      object CWKeyboard1: TMenuItem
        Action = actionShowCWKeyboard
      end
      object CWMessagePad1: TMenuItem
        Action = actionCwMessagePad
      end
      object RigControl1: TMenuItem
        Action = actionShowRigControl
      end
      object PacketCluster1: TMenuItem
        Action = actionShowPacketCluster
      end
      object ZLinkmonitor1: TMenuItem
        Action = actionShowZlinkMonitor
      end
      object ZServer1: TMenuItem
        Action = actionShowZServerChat
      end
      object Console1: TMenuItem
        Action = actionShowConsolePad
      end
      object Scratchsheet1: TMenuItem
        Action = actionShowScratchSheet
      end
      object Bandscope1: TMenuItem
        Action = actionShowBandScope
      end
      object RunningFrequencies1: TMenuItem
        Action = actionShowFreqList
      end
      object mnTTYConsole: TMenuItem
        Action = actionShowTeletypeConsole
        Visible = False
      end
      object menuAnalyze: TMenuItem
        Action = actionShowAnalyze
      end
      object menuShowFunctionKeyPanel: TMenuItem
        Action = actionFunctionKeyPanel
      end
      object menuShowQSYInfo: TMenuItem
        Action = actionShowQsyInfo
      end
      object menuShowSO2RNeoCp: TMenuItem
        Action = actionShowSo2rNeoCp
      end
      object menuShowInformation: TMenuItem
        Action = actionShowInformation
      end
      object ShowMessageManagerSO2R1: TMenuItem
        Action = actionShowMsgMgr
      end
      object menuShowCWMonitor: TMenuItem
        Action = actionShowCWMonitor
      end
    end
    object menuSettings: TMenuItem
      Caption = #21508#31278#35373#23450'(&S)'
      object menuHardwareSettings: TMenuItem
        Caption = #12495#12540#12489#12454#12455#12450#35373#23450'(&H)'
        OnClick = menuHardwareSettingsClick
      end
      object menuOptions: TMenuItem
        Caption = #36939#29992#35373#23450'(&O)'
        OnClick = menuOptionsClick
      end
      object menuBandPlanSettings: TMenuItem
        Caption = #12496#12531#12489#12503#12521#12531'(&B)'
        OnClick = menuBandPlanSettingsClick
      end
      object menuQSORateSettings: TMenuItem
        Caption = 'QSO'#12524#12540#12488'(&R)'
        OnClick = menuQSORateSettingsClick
      end
      object menuTargetEditor: TMenuItem
        Caption = #30446#27161#12456#12487#12451#12479'(&T)'
        OnClick = menuTargetEditorClick
      end
      object menuPluginManager: TMenuItem
        Caption = #12503#12521#12464#12452#12531#12510#12493#12540#12472#12515'(&P)'
        OnClick = menuPluginManagerClick
      end
    end
    object Network1: TMenuItem
      Caption = #12493#12483#12488#12527#12540#12463'(&N)'
      object menuConnectToZServer: TMenuItem
        Caption = 'Z-Server'#12395#25509#32154
        OnClick = menuConnectToZServerClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object menuDownloadAllLogs: TMenuItem
        Caption = 'Z-Server'#12424#12426#12525#12464#12434#12480#12454#12531#12525#12540#12489'('#12525#12464#12399#28040#21435#12373#12428#12414#12377')'
        Enabled = False
        OnClick = menuDownloadAllLogsClick
      end
      object menuMergeAllLogs: TMenuItem
        Caption = 'Z-Server'#12408#12525#12464#12434#12450#12483#12503#12525#12540#12489
        Enabled = False
        OnClick = menuMergeAllLogsClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object menuDownloadOplist: TMenuItem
        Caption = 'Z-Server'#12424#12426#12458#12506#12524#12540#12479#12540#12522#12473#12488#12434#12480#12454#12531#12525#12540#12489
        Enabled = False
        OnClick = menuDownloadOplistClick
      end
      object menuDownloadSounds: TMenuItem
        Caption = 'Z-Server'#12424#12426#38899#22768#12501#12449#12452#12523#12434#12480#12454#12531#12525#12540#12489
        Enabled = False
        OnClick = menuDownloadSoundsClick
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object menuUploadOplist: TMenuItem
        Caption = 'Z-Server'#12408#12458#12506#12524#12540#12479#12540#12522#12473#12488#12434#12450#12483#12503#12525#12540#12489
        Enabled = False
        OnClick = menuUploadOplistClick
      end
      object menuUploadSounds: TMenuItem
        Caption = 'Z-Server'#12408#38899#22768#12501#12449#12452#12523#12434#12450#12483#12503#12525#12540#12489
        Enabled = False
        OnClick = menuUploadSoundsClick
      end
    end
    object PluginMenu: TMenuItem
      Caption = #12503#12521#12464#12452#12531'(&P)'
      Visible = False
    end
    object View1: TMenuItem
      Caption = #34920#31034'(&V)'
      OnClick = View1Click
      object menuShowCurrentBandOnly: TMenuItem
        Action = actionShowCurrentBandOnly
        GroupIndex = 1
      end
      object menuShowThisTXonly: TMenuItem
        Action = actionShowCurrentTxOnly
        GroupIndex = 1
      end
      object menuShowOnlySpecifiedTX: TMenuItem
        Caption = #25351#23450#12398'TX'#12398#12415#12434#34920#31034
        GroupIndex = 1
        object menuShowTx0: TMenuItem
          AutoCheck = True
          Caption = '#0'
          GroupIndex = 2
          RadioItem = True
          OnClick = menuShowOnlyTxClick
        end
        object menuShowTx1: TMenuItem
          Tag = 1
          AutoCheck = True
          Caption = '#1'
          GroupIndex = 2
          RadioItem = True
          OnClick = menuShowOnlyTxClick
        end
        object menuShowTx2: TMenuItem
          Tag = 2
          AutoCheck = True
          Caption = '#2'
          GroupIndex = 2
          RadioItem = True
          OnClick = menuShowOnlyTxClick
        end
        object menuShowTx3: TMenuItem
          Tag = 3
          AutoCheck = True
          Caption = '#3'
          GroupIndex = 2
          RadioItem = True
          OnClick = menuShowOnlyTxClick
        end
        object menuShowTx4: TMenuItem
          Tag = 4
          AutoCheck = True
          Caption = '#4'
          GroupIndex = 2
          RadioItem = True
          OnClick = menuShowOnlyTxClick
        end
        object menuShowTx5: TMenuItem
          Tag = 5
          AutoCheck = True
          Caption = '#5'
          GroupIndex = 2
          RadioItem = True
          OnClick = menuShowOnlyTxClick
        end
        object menuShowTx6: TMenuItem
          Tag = 6
          AutoCheck = True
          Caption = '#6'
          GroupIndex = 2
          RadioItem = True
          OnClick = menuShowOnlyTxClick
        end
        object menuShowTx7: TMenuItem
          Tag = 7
          AutoCheck = True
          Caption = '#7'
          GroupIndex = 2
          RadioItem = True
          OnClick = menuShowOnlyTxClick
        end
        object menuShowTx8: TMenuItem
          Tag = 8
          AutoCheck = True
          Caption = '#8'
          GroupIndex = 2
          RadioItem = True
          OnClick = menuShowOnlyTxClick
        end
        object menuShowTx9: TMenuItem
          Tag = 9
          AutoCheck = True
          Caption = '#9'
          GroupIndex = 2
          RadioItem = True
          OnClick = menuShowOnlyTxClick
        end
      end
      object N10: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object Sort1: TMenuItem
        Caption = #20006#12403#26367#12360
        GroupIndex = 1
        object menuSortByCallsign: TMenuItem
          Caption = #12467#12540#12523#12469#12452#12531#12391#20006#12403#26367#12360
          OnClick = menuSortByClick
        end
        object menuSortByTime: TMenuItem
          Tag = 1
          Caption = #26178#38291#12391#20006#12403#26367#12360
          OnClick = menuSortByClick
        end
        object menuSortByBand: TMenuItem
          Tag = 2
          Caption = #12496#12531#12489#12391#20006#12403#26367#12360
          OnClick = menuSortByClick
        end
        object menuSortByMode: TMenuItem
          Tag = 3
          Caption = #12514#12540#12489#12391#20006#12403#26367#12360
          OnClick = menuSortByClick
        end
        object menuSortByPower: TMenuItem
          Tag = 4
          Caption = #38651#21147#12391#20006#12403#26367#12360
          OnClick = menuSortByClick
        end
        object menuSortByTxNo: TMenuItem
          Tag = 5
          Caption = 'TX#'#12391#20006#12403#26367#12360
          OnClick = menuSortByClick
        end
        object menuSortByPoint: TMenuItem
          Tag = 6
          Caption = #28857#25968#12391#20006#12403#26367#12360
          OnClick = menuSortByClick
        end
        object menuSortByOperator: TMenuItem
          Tag = 7
          Caption = #12458#12506#12524#12540#12479#12391#20006#12403#26367#12360
          OnClick = menuSortByClick
        end
        object menuSortByMemo: TMenuItem
          Tag = 8
          Caption = #12513#12514#27396#12391#20006#12403#26367#12360
          OnClick = menuSortByClick
        end
      end
      object N9: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object mnHideCWPhToolBar: TMenuItem
        Caption = 'CW/Ph'#12484#12540#12523#12496#12540#12434#34920#31034#12375#12394#12356
        GroupIndex = 1
        OnClick = mnHideCWPhToolBarClick
      end
      object mnHideMenuToolbar: TMenuItem
        Caption = 'Menu'#12484#12540#12523#12496#12540#12434#34920#31034#12375#12394#12356
        GroupIndex = 1
        OnClick = mnHideMenuToolbarClick
      end
      object N12: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object IncreaseFontSize1: TMenuItem
        Action = actionIncreaseFontSize
        GroupIndex = 1
      end
      object DecreaseFontSize1: TMenuItem
        Action = actionDecreaseFontSize
        GroupIndex = 1
      end
    end
    object Help1: TMenuItem
      Caption = #12504#12523#12503'(&H)'
      object menuAbout: TMenuItem
        Caption = 'zLog'#12395#12388#12356#12390'...(&A)'
        Hint = 'Show program information'
        OnClick = menuAboutClick
      end
      object menuQuickReference: TMenuItem
        Caption = #12463#12452#12483#12463#12522#12501#12449#12524#12531#12473'(&Q)'
        OnClick = menuQuickReferenceClick
      end
      object N5: TMenuItem
        Caption = '-'
        Visible = False
      end
      object menuPortal: TMenuItem
        Caption = 'zLog'#12509#12540#12479#12523#12469#12452#12488'(&P)'
        OnClick = menuPortalClick
      end
      object menuUsersGuide: TMenuItem
        Caption = 'zLog'#12518#12540#12470#12540#12474#12460#12452#12489'(&U)'
        OnClick = menuUsersGuideClick
      end
      object HelpZyLO: TMenuItem
        Caption = 'ZyLO'#12503#12521#12464#12452#12531#38283#30330#12510#12491#12517#12450#12523'(&Z)'
        Hint = 'How to make ZyLO plugin'
        OnClick = HelpZyLOClick
      end
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'ZLO'
    Filter = 'zLog'#12501#12449#12452#12523'|*.ZLO|zLog'#25313#24373#12501#12449#12452#12523'|*.ZLOX|'#20840#12390#12398#12501#12449#12452#12523'|*.*'
    Left = 418
    Top = 207
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'ZLO'
    Filter = 'zLog'#12501#12449#12452#12523'|*.ZLO|zLog'#25313#24373#12501#12449#12452#12523'|*.ZLOX'
    Left = 376
    Top = 213
  end
  object BandMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 88
    Top = 212
    object N19MHz: TMenuItem
      Caption = '1.9MHz'
      OnClick = BandMenuClick
    end
    object N35MHz: TMenuItem
      Tag = 1
      Caption = '3.5MHz'
      OnClick = BandMenuClick
    end
    object N7MHz: TMenuItem
      Tag = 2
      Caption = '7MHz'
      OnClick = BandMenuClick
    end
    object N10MHz1: TMenuItem
      Tag = 3
      Caption = '10 MHz'
      OnClick = BandMenuClick
    end
    object N14MHz: TMenuItem
      Tag = 4
      Caption = '14MHz'
      OnClick = BandMenuClick
    end
    object N18MHz1: TMenuItem
      Tag = 5
      Caption = '18 MHz'
      OnClick = BandMenuClick
    end
    object N21MHz: TMenuItem
      Tag = 6
      Caption = '21MHz'
      OnClick = BandMenuClick
    end
    object N24MHz1: TMenuItem
      Tag = 7
      Caption = '24 MHz'
      OnClick = BandMenuClick
    end
    object N28MHz: TMenuItem
      Tag = 8
      Caption = '28MHz'
      OnClick = BandMenuClick
    end
    object N50MHz: TMenuItem
      Tag = 9
      Caption = '50MHz'
      OnClick = BandMenuClick
    end
    object N144MHz: TMenuItem
      Tag = 10
      Caption = '144MHz'
      OnClick = BandMenuClick
    end
    object N430MHz: TMenuItem
      Tag = 11
      Caption = '430MHz'
      OnClick = BandMenuClick
    end
    object N1200MHz: TMenuItem
      Tag = 12
      Caption = '1200MHz'
      OnClick = BandMenuClick
    end
    object N2400MHz: TMenuItem
      Tag = 13
      Caption = '2400MHz'
      OnClick = BandMenuClick
    end
    object N5600MHz: TMenuItem
      Tag = 14
      Caption = '5600MHz'
      OnClick = BandMenuClick
    end
    object N10GHzup1: TMenuItem
      Tag = 15
      Caption = '10GHz&&up'
      OnClick = BandMenuClick
    end
  end
  object ModeMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 120
    Top = 212
    object CW1: TMenuItem
      Caption = 'CW'
      OnClick = ModeMenuClick
    end
    object SSB1: TMenuItem
      Tag = 1
      Caption = 'SSB'
      OnClick = ModeMenuClick
    end
    object FM1: TMenuItem
      Tag = 2
      Caption = 'FM'
      OnClick = ModeMenuClick
    end
    object AM1: TMenuItem
      Tag = 3
      Caption = 'AM'
      OnClick = ModeMenuClick
    end
    object RTTY1: TMenuItem
      Tag = 4
      Caption = 'RTTY'
      OnClick = ModeMenuClick
    end
    object FT41: TMenuItem
      Tag = 5
      Caption = 'FT4'
      OnClick = ModeMenuClick
    end
    object FT81: TMenuItem
      Tag = 6
      Caption = 'FT8'
      OnClick = ModeMenuClick
    end
    object Other1: TMenuItem
      Tag = 7
      Caption = 'Other'
      OnClick = ModeMenuClick
    end
  end
  object GridMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    OnPopup = GridMenuPopup
    Left = 56
    Top = 212
    object EditQSO: TMenuItem
      Caption = 'QSO'#12398#20462#27491'(&E)'
      OnClick = EditQSOClick
    end
    object DeleteQSO1: TMenuItem
      Caption = 'QSO'#12398#21066#38500'(&D)'
      OnClick = DeleteQSO1Click
    end
    object InsertQSO1: TMenuItem
      Caption = 'QSO'#12398#25407#20837'(&I)'
      OnClick = InsertQSO1Click
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object menuChangeBand: TMenuItem
      Caption = 'Change &Band'
      object G1R9MHz: TMenuItem
        Caption = '1.9 MHz'
        OnClick = GridBandChangeClick
      end
      object G3R5MHz: TMenuItem
        Tag = 1
        Caption = '3.5 MHz'
        OnClick = GridBandChangeClick
      end
      object G7MHz: TMenuItem
        Tag = 2
        Caption = '7 MHz'
        OnClick = GridBandChangeClick
      end
      object G10MHz: TMenuItem
        Tag = 3
        Caption = '10 MHz'
        Visible = False
        OnClick = GridBandChangeClick
      end
      object G14MHz: TMenuItem
        Tag = 4
        Caption = '14 MHz'
        OnClick = GridBandChangeClick
      end
      object G18MHz: TMenuItem
        Tag = 5
        Caption = '18 MHz'
        Visible = False
        OnClick = GridBandChangeClick
      end
      object G21MHz: TMenuItem
        Tag = 6
        Caption = '21 MHz'
        OnClick = GridBandChangeClick
      end
      object G24MHz: TMenuItem
        Tag = 7
        Caption = '24 MHz'
        Visible = False
        OnClick = GridBandChangeClick
      end
      object G28MHz: TMenuItem
        Tag = 8
        Caption = '28 MHz'
        OnClick = GridBandChangeClick
      end
      object G50MHz: TMenuItem
        Tag = 9
        Caption = '50 MHz'
        OnClick = GridBandChangeClick
      end
      object G144MHz: TMenuItem
        Tag = 10
        Caption = '144 MHz'
        OnClick = GridBandChangeClick
      end
      object G430MHz: TMenuItem
        Tag = 11
        Caption = '430 MHz'
        OnClick = GridBandChangeClick
      end
      object G1200MHz: TMenuItem
        Tag = 12
        Caption = '1200 MHz'
        OnClick = GridBandChangeClick
      end
      object G2400MHz: TMenuItem
        Tag = 13
        Caption = '2400 MHz'
        OnClick = GridBandChangeClick
      end
      object G5600MHz: TMenuItem
        Tag = 14
        Caption = '5600 MHz'
        OnClick = GridBandChangeClick
      end
      object G10GHz: TMenuItem
        Tag = 15
        Caption = '10 GHz && up'
        OnClick = GridBandChangeClick
      end
    end
    object menuChangeMode: TMenuItem
      Caption = 'Change &Mode'
      object CW2: TMenuItem
        Caption = 'CW'
        OnClick = GridModeChangeClick
      end
      object SSB2: TMenuItem
        Tag = 1
        Caption = 'SSB'
        OnClick = GridModeChangeClick
      end
      object FM2: TMenuItem
        Tag = 2
        Caption = 'FM'
        OnClick = GridModeChangeClick
      end
      object AM2: TMenuItem
        Tag = 3
        Caption = 'AM'
        OnClick = GridModeChangeClick
      end
      object RTTY2: TMenuItem
        Tag = 4
        Caption = 'RTTY'
        OnClick = GridModeChangeClick
      end
      object Other2: TMenuItem
        Tag = 5
        Caption = 'Other'
        OnClick = GridModeChangeClick
      end
    end
    object menuChangePower: TMenuItem
      Caption = 'Change &Power'
      object H2: TMenuItem
        Caption = 'P (QRP)'
        OnClick = GridPowerChangeClick
      end
      object M2: TMenuItem
        Tag = 1
        Caption = 'L (Low)'
        OnClick = GridPowerChangeClick
      end
      object L2: TMenuItem
        Tag = 2
        Caption = 'M (Medium)'
        OnClick = GridPowerChangeClick
      end
      object P2: TMenuItem
        Tag = 3
        Caption = 'H (High)'
        OnClick = GridPowerChangeClick
      end
    end
    object menuChangeOperator: TMenuItem
      Caption = 'Change &Operator'
      object Clear1: TMenuItem
        Caption = 'Clear'
        OnClick = GridOperatorClick
      end
    end
    object menuChangeTXNr: TMenuItem
      Caption = 'Change &TX#'
    end
    object menuChangeSentNr: TMenuItem
      Caption = 'Change Sent &NR'
      OnClick = menuChangeSentNrClick
    end
    object menuChangeDate: TMenuItem
      Caption = 'Change Da&te'
      OnClick = menuChangeDateClick
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object menuEditStatus: TMenuItem
      Caption = #12473#12486#12540#12479#12473#20462#27491
      OnClick = menuEditStatusClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object SendSpot1: TMenuItem
      Caption = #12473#12509#12483#12488#24773#22577#12398#36865#20449'(&S)'
      OnClick = SendSpot1Click
    end
    object mnGridAddNewPX: TMenuItem
      Caption = #26032#12375#12356#12503#12522#12501#12451#12483#12463#12473#12398#36861#21152'(&A)'
      OnClick = mnGridAddNewPXClick
    end
  end
  object OpMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 184
    Top = 212
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 16
    Top = 212
  end
  object FileExportDialog: TSaveDialog
    Filter = 
      'ALL bands|*.all|zLog DOS compatible text|*.txt|TX#|*.tx|ADIF|*.a' +
      'di|Cabrillo|*.CBR|zLog CSV|*.csv|HAMLOG|*.csv'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Export'
    OnTypeChange = FileExportDialogTypeChange
    Left = 472
    Top = 196
  end
  object CWFMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 376
    Top = 137
    object Edit1: TMenuItem
      Caption = 'Edit'
      OnClick = Edit1Click
    end
  end
  object NewPowerMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 152
    Top = 212
    object P1: TMenuItem
      Caption = 'P (QRP)'
      OnClick = NewPowerMenuClick
    end
    object L1: TMenuItem
      Tag = 1
      Caption = 'L (Low)'
      OnClick = NewPowerMenuClick
    end
    object M1: TMenuItem
      Tag = 2
      Caption = 'M (Medium)'
      OnClick = NewPowerMenuClick
    end
    object H1: TMenuItem
      Tag = 3
      Caption = 'H (High)'
      OnClick = NewPowerMenuClick
    end
  end
  object GeneralSaveDialog: TSaveDialog
    Left = 268
    Top = 208
  end
  object ActionList1: TActionList
    Left = 108
    Top = 144
    object actionQuickQSY01: TAction
      Tag = 1
      Caption = 'actionQuickQSY01'
      ShortCut = 16496
      OnExecute = actionQuickQSYExecute
    end
    object actionQuickQSY02: TAction
      Tag = 2
      Caption = 'actionQuickQSY02'
      ShortCut = 16497
      OnExecute = actionQuickQSYExecute
    end
    object actionQuickQSY03: TAction
      Tag = 3
      Caption = 'actionQuickQSY03'
      ShortCut = 16498
      OnExecute = actionQuickQSYExecute
    end
    object actionQuickQSY04: TAction
      Tag = 4
      Caption = 'actionQuickQSY04'
      ShortCut = 16499
      OnExecute = actionQuickQSYExecute
    end
    object actionQuickQSY05: TAction
      Tag = 5
      Caption = 'actionQuickQSY05'
      ShortCut = 16500
      OnExecute = actionQuickQSYExecute
    end
    object actionQuickQSY06: TAction
      Tag = 6
      Caption = 'actionQuickQSY06'
      ShortCut = 16501
      OnExecute = actionQuickQSYExecute
    end
    object actionQuickQSY07: TAction
      Tag = 7
      Caption = 'actionQuickQSY07'
      ShortCut = 16502
      OnExecute = actionQuickQSYExecute
    end
    object actionQuickQSY08: TAction
      Tag = 8
      Caption = 'actionQuickQSY08'
      ShortCut = 16503
      OnExecute = actionQuickQSYExecute
    end
    object actionShowSuperCheck: TAction
      Caption = #12473#12540#12497#12540#12481#12455#12483#12463
      ShortCut = 16505
      OnExecute = actionShowSuperCheckExecute
    end
    object actionShowZlinkMonitor: TAction
      Caption = '&Z-Link'#12514#12491#12479#12540
      ShortCut = 16507
      OnExecute = actionShowZlinkMonitorExecute
    end
    object actionPlayMessageA01: TAction
      Tag = 1
      Caption = 'actionPlayMessageA01'
      ShortCut = 112
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA02: TAction
      Tag = 2
      Caption = 'actionPlayMessageA02'
      ShortCut = 113
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA03: TAction
      Tag = 3
      Caption = 'actionPlayMessageA03'
      ShortCut = 114
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA04: TAction
      Tag = 4
      Caption = 'actionPlayMessageA04'
      ShortCut = 115
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA05: TAction
      Tag = 5
      Caption = 'actionPlayMessageA05'
      ShortCut = 116
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA06: TAction
      Tag = 6
      Caption = 'actionPlayMessageA06'
      ShortCut = 117
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA07: TAction
      Tag = 7
      Caption = 'actionPlayMessageA07'
      ShortCut = 118
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA08: TAction
      Tag = 8
      Caption = 'actionPlayMessageA08'
      ShortCut = 119
      OnExecute = actionPlayMessageAExecute
    end
    object actionCheckMulti: TAction
      Caption = #12510#12523#12481#12481#12455#12483#12463
      OnExecute = actionCheckMultiExecute
    end
    object actionShowCheckPartial: TAction
      Caption = #12497#12540#12471#12515#12523#12481#12455#12483#12463
      OnExecute = actionShowCheckPartialExecute
    end
    object actionPlayCQA2: TAction
      Tag = 102
      Caption = 'actionPlayCQA2'
      ShortCut = 122
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayCQA3: TAction
      Tag = 103
      Caption = 'actionPlayCQA3'
      ShortCut = 123
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageB01: TAction
      Tag = 1
      Caption = 'actionPlayMessageB01'
      ShortCut = 8304
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB02: TAction
      Tag = 2
      Caption = 'actionPlayMessageB02'
      ShortCut = 8305
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB03: TAction
      Tag = 3
      Caption = 'actionPlayMessageB03'
      ShortCut = 8306
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB04: TAction
      Tag = 4
      Caption = 'actionPlayMessageB04'
      ShortCut = 8307
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB05: TAction
      Tag = 5
      Caption = 'actionPlayMessageB05'
      ShortCut = 8308
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB06: TAction
      Tag = 6
      Caption = 'actionPlayMessageB06'
      ShortCut = 8309
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB07: TAction
      Tag = 7
      Caption = 'actionPlayMessageB07'
      ShortCut = 8310
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB08: TAction
      Tag = 8
      Caption = 'actionPlayMessageB08'
      ShortCut = 8311
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayCQB2: TAction
      Tag = 102
      Caption = 'actionPlayCQB2'
      ShortCut = 8314
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayCQB3: TAction
      Tag = 103
      Caption = 'actionPlayCQB3'
      ShortCut = 8315
      OnExecute = actionPlayMessageBExecute
    end
    object actionInsertBandScope: TAction
      Caption = 'actionInsertBandScope'
      ShortCut = 16397
      OnExecute = actionInsertBandScopeExecute
    end
    object actionInsertBandScope2: TAction
      Caption = 'actionInsertBandScope2'
      ShortCut = 16462
      OnExecute = actionInsertBandScopeExecute
    end
    object actionInsertBandScope3: TAction
      Caption = 'actionInsertBandScope3'
      ShortCut = 24654
      OnExecute = actionInsertBandScope3Execute
    end
    object actionIncreaseFontSize: TAction
      Caption = #12501#12457#12531#12488#12434#22823#12365#12367
      ShortCut = 16467
      OnExecute = actionIncreaseFontSizeExecute
    end
    object actionDecreaseFontSize: TAction
      Caption = #12501#12457#12531#12488#12434#23567#12373#12367
      ShortCut = 24659
      OnExecute = actionDecreaseFontSizeExecute
    end
    object actionPageUp: TAction
      Caption = 'actionPageUp'
      ShortCut = 33
      OnExecute = actionPageUpExecute
    end
    object actionPageDown: TAction
      Caption = 'actionPageDown'
      ShortCut = 34
      OnExecute = actionPageDownExecute
    end
    object actionMoveTop: TAction
      Caption = 'actionMoveTop'
      ShortCut = 16449
      OnExecute = actionMoveTopExecute
    end
    object actionMoveLeft: TAction
      Caption = 'actionMoveLeft'
      ShortCut = 16450
      OnExecute = actionMoveLeftExecute
    end
    object actionDeleteOneChar: TAction
      Caption = 'actionDeleteOneChar'
      ShortCut = 16452
      OnExecute = actionDeleteOneCharExecute
    end
    object actionMoveLast: TAction
      Caption = 'actionMoveLast'
      ShortCut = 16453
      OnExecute = actionMoveLastExecute
    end
    object actionMoveRight: TAction
      Caption = 'actionMoveRight'
      ShortCut = 16454
      OnExecute = actionMoveRightExecute
    end
    object actionPullQso: TAction
      Caption = 'pull qso'
      ShortCut = 16455
      OnExecute = actionPullQsoExecute
    end
    object actionDeleteLeftOneChar: TAction
      Caption = 'actionDeleteLeftOneChar'
      ShortCut = 16456
      OnExecute = actionDeleteLeftOneCharExecute
    end
    object actionGetPartialCheck: TAction
      Caption = 'actionGetPartialCheck'
      ShortCut = 16457
      OnExecute = actionGetPartialCheckExecute
    end
    object actionDeleteRight: TAction
      Caption = 'actionDeleteRight'
      ShortCut = 16458
      OnExecute = actionDeleteRightExecute
    end
    object actionClearCallAndRpt: TAction
      Caption = 'actionClearCallAndRpt'
      ShortCut = 16459
      OnExecute = actionClearCallAndRptExecute
    end
    object actionShowCurrentBandOnly: TAction
      Caption = #29694#22312#12496#12531#12489#12398#12415#12434#34920#31034
      ShortCut = 16460
      OnExecute = actionShowCurrentBandOnlyExecute
    end
    object actionDecreaseTime: TAction
      Caption = 'actionDecreaseTime'
      ShortCut = 16463
      OnExecute = actionDecreaseTimeExecute
    end
    object actionIncreaseTime: TAction
      Caption = 'actionIncreaseTime'
      ShortCut = 16464
      OnExecute = actionIncreaseTimeExecute
    end
    object actionQTC: TAction
      Caption = 'QTC'
      ShortCut = 16465
      OnExecute = actionQTCExecute
    end
    object actionReversePaddle: TAction
      Caption = 'actionReversePaddle'
      ShortCut = 16466
      OnExecute = actionReversePaddleExecute
    end
    object actionCwTune: TAction
      Caption = 'actionCwTune'
      ShortCut = 16468
      OnExecute = actionCwTuneExecute
    end
    object actionPushQso: TAction
      Caption = 'push qso'
      ShortCut = 16469
      OnExecute = actionPushQsoExecute
    end
    object actionFieldClear: TAction
      Caption = 'actionFieldClear'
      ShortCut = 16471
      OnExecute = actionFieldClearExecute
    end
    object actionCQRepeat: TAction
      Caption = 'actionCQRepeat'
      ShortCut = 16474
      OnExecute = actionCQRepeatExecute
    end
    object actionBackup: TAction
      Caption = #12496#12483#12463#12450#12483#12503'(&B)'
      ShortCut = 32834
      OnExecute = actionBackupExecute
    end
    object actionFocusCallsign: TAction
      Caption = 'actionFocusCallsign'
      ShortCut = 32835
      OnExecute = actionFocusCallsignExecute
    end
    object actionShowCWKeyboard: TAction
      Caption = '&CW Keyboard'
      ShortCut = 32843
      OnExecute = actionShowCWKeyboardExecute
    end
    object actionFocusMemo: TAction
      Caption = 'actionFocusMemo'
      ShortCut = 32845
      OnExecute = actionFocusMemoExecute
    end
    object actionFocusNumber: TAction
      Caption = 'actionFocusNumber'
      ShortCut = 32846
      OnExecute = actionFocusNumberExecute
    end
    object actionFocusOp: TAction
      Caption = 'actionFocusOp'
      ShortCut = 32847
      OnExecute = actionFocusOpExecute
    end
    object actionShowPacketCluster: TAction
      Caption = 'Packet Cluster(&P)'
      ShortCut = 32848
      OnExecute = actionShowPacketClusterExecute
    end
    object actionShowConsolePad: TAction
      Caption = 'Console'
      ShortCut = 32849
      OnExecute = actionShowConsolePadExecute
    end
    object actionFocusRst: TAction
      Caption = 'actionFocusRst'
      ShortCut = 32850
      OnExecute = actionFocusRstExecute
    end
    object actionShowScratchSheet: TAction
      Caption = #12473#12463#12521#12483#12481#12471#12540#12488
      ShortCut = 32851
      OnExecute = actionShowScratchSheetExecute
    end
    object actionShowRigControl: TAction
      Caption = #12522#12464#12467#12531#12488#12525#12540#12523
      ShortCut = 32852
      OnExecute = actionShowRigControlExecute
    end
    object actoinClearCallAndNumAftFocus: TAction
      Caption = 'actoinClearCallAndNumAftFocus'
      ShortCut = 32855
      OnExecute = actoinClearCallAndNumAftFocusExecute
    end
    object actionShowZServerChat: TAction
      Caption = 'Z-Server'#12513#12483#12475#12540#12472
      ShortCut = 32858
      OnExecute = actionShowZServerChatExecute
    end
    object actionToggleRig: TAction
      Caption = 'actionToggleRig'
      ShortCut = 8280
      OnExecute = actionToggleRigExecute
    end
    object actionShowBandScope: TAction
      Caption = #12496#12531#12489#12473#12467#12540#12503'(&B)'
      OnExecute = actionShowBandScopeExecute
    end
    object actionShowFreqList: TAction
      Caption = 'Running'#21608#27874#25968
      OnExecute = actionShowFreqListExecute
    end
    object actionShowTeletypeConsole: TAction
      Caption = 'Teletype Console'
      OnExecute = actionShowTeletypeConsoleExecute
    end
    object actionShowAnalyze: TAction
      Caption = #20998#26512
      OnExecute = actionShowAnalyzeExecute
    end
    object actionShowScore: TAction
      Caption = #12473#12467#12450'(&S)'
      OnExecute = actionShowScoreExecute
    end
    object actionShowMultipliers: TAction
      Caption = #12510#12523#12481#12503#12521#12452#12516#12540'(&M)'
      OnExecute = actionShowMultipliersExecute
    end
    object actionShowQsoRate: TAction
      Caption = 'QSO'#12524#12540#12488'(&R)'
      OnExecute = actionShowQsoRateExecute
    end
    object actionShowCheckCall: TAction
      Caption = #12467#12540#12523#12469#12452#12531#12481#12455#12483#12463
      OnExecute = actionShowCheckCallExecute
    end
    object actionShowCheckMulti: TAction
      Caption = #12510#12523#12481#12481#12455#12483#12463
      OnExecute = actionShowCheckMultiExecute
    end
    object actionShowCheckCountry: TAction
      Caption = #12459#12531#12488#12522#12540#12481#12455#12483#12463
      OnExecute = actionShowCheckCountryExecute
    end
    object actionQsoStart: TAction
      Tag = 1
      Caption = 'actionQsoStart'
      ShortCut = 9
      OnExecute = actionQsoStartExecute
    end
    object actionQsoComplete: TAction
      Tag = 1
      Caption = 'actionQsoComplete'
      SecondaryShortCuts.Strings = (
        ';')
      ShortCut = 40
      OnExecute = actionQsoCompleteExecute
    end
    object actionNop: TAction
      Caption = 'actionNop'
      ShortCut = 16461
      OnExecute = actionNopExecute
    end
    object actionRegNewPrefix: TAction
      Caption = 'actionRegNewPrefix'
      SecondaryShortCuts.Strings = (
        '@')
      OnExecute = actionRegNewPrefixExecute
    end
    object actionControlPTT: TAction
      Caption = 'actionControlPTT'
      SecondaryShortCuts.Strings = (
        '\')
      OnExecute = actionControlPTTExecute
    end
    object actionShowSuperCheck2: TAction
      Caption = #65326#65291#65297
      OnExecute = actionShowSuperCheck2Execute
    end
    object actionGetSuperCheck2: TAction
      Caption = 'actionGetSuperCheck2'
      ShortCut = 24649
      OnExecute = actionGetSuperCheck2Execute
    end
    object actionChangeBand: TAction
      Caption = 'actionChangeBand'
      ShortCut = 8258
      OnExecute = actionChangeBandExecute
    end
    object actionChangeMode: TAction
      Caption = 'actionChangeMode'
      ShortCut = 8269
      OnExecute = actionChangeModeExecute
    end
    object actionChangePower: TAction
      Caption = 'actionChangePower'
      ShortCut = 8272
      OnExecute = actionChangePowerExecute
    end
    object actionChangeCwBank: TAction
      Caption = 'actionChangeCwBank'
      ShortCut = 8262
      OnExecute = actionChangeCwBankExecute
    end
    object actionChangeR: TAction
      Caption = 'actionChangeR'
      ShortCut = 8274
      OnExecute = actionChangeRExecute
    end
    object actionChangeS: TAction
      Caption = 'actionChangeS'
      ShortCut = 8275
      OnExecute = actionChangeSExecute
    end
    object actionSetCurTime: TAction
      Caption = 'actionSetCurTime'
      ShortCut = 8276
      OnExecute = actionSetCurTimeExecute
    end
    object actionDecreaseCwSpeed: TAction
      Caption = 'actionDecreaseCwSpeed'
      ShortCut = 8277
      OnExecute = actionDecreaseCwSpeedExecute
    end
    object actionIncreaseCwSpeed: TAction
      Caption = 'actionIncreaseCwSpeed'
      ShortCut = 8281
      OnExecute = actionIncreaseCwSpeedExecute
    end
    object actionCQRepeat2: TAction
      Caption = 'actionCQRepeat2'
      ShortCut = 8282
      OnExecute = actionCQRepeat2Execute
    end
    object actionToggleVFO: TAction
      Caption = 'actionToggleVFO'
      OnExecute = actionToggleVFOExecute
    end
    object actionEditLastQSO: TAction
      Caption = 'actionEditLastQSO'
      ShortCut = 32844
      OnExecute = actionEditLastQSOExecute
    end
    object actionQuickMemo1: TAction
      Tag = 1
      Caption = 'PSE QSL'
      OnExecute = actionQuickMemo3Execute
    end
    object actionQuickMemo2: TAction
      Tag = 2
      Caption = 'NO QSL'
      OnExecute = actionQuickMemo3Execute
    end
    object actionCwMessagePad: TAction
      Caption = 'CW Message Pad'
      OnExecute = actionCwMessagePadExecute
    end
    object actionCorrectSentNr: TAction
      Caption = #36865#20449'NR'#12398#20462#27491
      OnExecute = actionCorrectSentNrExecute
    end
    object actionSetLastFreq: TAction
      Caption = 'actionSetLastFreq'
      OnExecute = actionSetLastFreqExecute
    end
    object actionQuickMemo3: TAction
      Tag = 3
      Caption = 'actionQuickMemo3'
      OnExecute = actionQuickMemo3Execute
    end
    object actionQuickMemo4: TAction
      Tag = 4
      Caption = 'actionQuickMemo4'
      OnExecute = actionQuickMemo3Execute
    end
    object actionQuickMemo5: TAction
      Tag = 5
      Caption = 'actionQuickMemo5'
      OnExecute = actionQuickMemo3Execute
    end
    object actionPlayMessageA09: TAction
      Tag = 9
      Caption = 'actionPlayMessageA09'
      ShortCut = 120
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA10: TAction
      Tag = 10
      Caption = 'actionPlayMessageA10'
      ShortCut = 121
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageB09: TAction
      Tag = 9
      Caption = 'actionPlayMessageB09'
      ShortCut = 8312
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB10: TAction
      Tag = 10
      Caption = 'actionPlayMessageB10'
      ShortCut = 8313
      OnExecute = actionPlayMessageBExecute
    end
    object actionCQAbort: TAction
      Caption = 'actionCQAbort'
      ShortCut = 27
      OnExecute = actionCQAbortExecute
    end
    object actionPlayMessageA11: TAction
      Tag = 11
      Caption = 'actionPlayMessageA11'
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA12: TAction
      Tag = 12
      Caption = 'actionPlayMessageA12'
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayCQA1: TAction
      Tag = 101
      Caption = 'actionPlayCQA1'
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageB11: TAction
      Tag = 11
      Caption = 'actionPlayMessageB11'
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB12: TAction
      Tag = 12
      Caption = 'actionPlayMessageB12'
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayCQB1: TAction
      Tag = 101
      Caption = 'actionPlayCQB1'
      OnExecute = actionPlayMessageBExecute
    end
    object actionToggleCqSp: TAction
      Caption = 'actionToggleCqSp'
      OnExecute = actionToggleCqSpExecute
    end
    object actionCQRepeatIntervalUp: TAction
      Caption = 'actionCQRepeatIntervalUp'
      OnExecute = actionCQRepeatIntervalUpExecute
    end
    object actionCQRepeatIntervalDown: TAction
      Caption = 'actionCQRepeatIntervalDown'
      OnExecute = actionCQRepeatIntervalDownExecute
    end
    object actionSetCQMessage1: TAction
      Tag = 101
      Caption = 'actionSetCQMessage1'
      OnExecute = actionSetCQMessageExecute
    end
    object actionSetCQMessage2: TAction
      Tag = 102
      Caption = 'actionSetCQMessage2'
      OnExecute = actionSetCQMessageExecute
    end
    object actionSetCQMessage3: TAction
      Tag = 103
      Caption = 'actionSetCQMessage3'
      OnExecute = actionSetCQMessageExecute
    end
    object actionToggleRit: TAction
      Caption = 'actionToggleRit'
      OnExecute = actionToggleRitExecute
    end
    object actionToggleXit: TAction
      Caption = 'actionToggleXit'
      OnExecute = actionToggleXitExecute
    end
    object actionRitClear: TAction
      Caption = 'actionRitClear'
      OnExecute = actionRitClearExecute
    end
    object actionToggleAntiZeroin: TAction
      Caption = 'actionToggleAntiZeroin'
      OnExecute = actionToggleAntiZeroinExecute
    end
    object actionAntiZeroin: TAction
      Caption = 'actionAntiZeroin'
      OnExecute = actionAntiZeroinExecute
    end
    object actionFunctionKeyPanel: TAction
      Caption = 'Function Key Panel'
      OnExecute = actionFunctionKeyPanelExecute
    end
    object actionShowQsoRateEx: TAction
      Caption = 'QSO'#12524#12540#12488'Ex'
      OnExecute = actionShowQsoRateExExecute
    end
    object actionShowQsyInfo: TAction
      Caption = 'QSY Indicator'
      OnExecute = actionShowQsyInfoExecute
    end
    object actionShowSo2rNeoCp: TAction
      Caption = 'SO2R Neo Control Panel'
      OnExecute = actionShowSo2rNeoCpExecute
    end
    object actionSo2rNeoSelRx1: TAction
      Caption = 'actionSo2rNeoSelRx1'
      OnExecute = actionSo2rNeoSelRxExecute
    end
    object actionSo2rNeoSelRx2: TAction
      Tag = 1
      Caption = 'actionSo2rNeoSelRx2'
      OnExecute = actionSo2rNeoSelRxExecute
    end
    object actionSo2rNeoSelRxBoth: TAction
      Tag = 2
      Caption = 'actionSo2rNeoSelRxBoth'
      OnExecute = actionSo2rNeoSelRxExecute
    end
    object actionSelectRig1: TAction
      Tag = 1
      Caption = 'actionSelectRig1'
      OnExecute = actionSelectRigExecute
    end
    object actionSelectRig2: TAction
      Tag = 2
      Caption = 'actionSelectRig2'
      OnExecute = actionSelectRigExecute
    end
    object actionSelectRig3: TAction
      Tag = 3
      Caption = 'actionSelectRig3'
      OnExecute = actionSelectRigExecute
    end
    object actionSo2rNeoCanRxSel: TAction
      Caption = 'actionSo2rNeoCanRxSel'
      OnExecute = actionSo2rNeoCanRxSelExecute
    end
    object actionShowInformation: TAction
      Caption = #24773#22577#12454#12452#12531#12489#12454
      OnExecute = actionShowInformationExecute
    end
    object actionToggleSo2r2bsiq: TAction
      Caption = 'actionToggleSo2r2bsiq'
      OnExecute = actionToggleSo2r2bsiqExecute
    end
    object actionSo2rNeoToggleAutoRxSelect: TAction
      Caption = 'actionSo2rNeoToggleAutoRxSelect'
      OnExecute = actionSo2rNeoToggleAutoRxSelectExecute
    end
    object actionToggleTx: TAction
      Caption = 'actionToggleTx'
      OnExecute = actionToggleTxExecute
    end
    object actionToggleSo2rWait: TAction
      Caption = 'actionToggleSo2rWait'
      OnExecute = actionToggleSo2rWaitExecute
    end
    object actionToggleRx: TAction
      Caption = 'actionToggleRx'
      OnExecute = actionToggleRxExecute
    end
    object actionMatchRxToTx: TAction
      Caption = 'actionMatchRxToTx'
      OnExecute = actionMatchRxToTxExecute
    end
    object actionMatchTxToRx: TAction
      Caption = 'actionMatchTxToRx'
      OnExecute = actionMatchTxToRxExecute
    end
    object actionSo2rToggleRigPair: TAction
      Caption = 'actionSo2rToggleRigPair'
      OnExecute = actionSo2rToggleRigPairExecute
    end
    object actionChangeTxNr0: TAction
      Caption = 'actionChangeTxNr0'
      OnExecute = actionChangeTxNrExecute
    end
    object actionChangeTxNr1: TAction
      Tag = 1
      Caption = 'actionChangeTxNr1'
      OnExecute = actionChangeTxNrExecute
    end
    object actionChangeTxNr2: TAction
      Tag = 2
      Caption = 'actionChangeTxNr2'
      OnExecute = actionChangeTxNrExecute
    end
    object actionPseQsl: TAction
      Caption = 'actionPseQsl'
      OnExecute = actionPseQslExecute
    end
    object actionNoQsl: TAction
      Caption = 'actionNoQsl'
      OnExecute = actionNoQslExecute
    end
    object actionShowMsgMgr: TAction
      Caption = 'Message Manager (SO2R)'
      OnExecute = actionShowMsgMgrExecute
    end
    object actionChangeBand2: TAction
      Tag = 1
      Caption = 'actionChangeBand2'
      OnExecute = actionChangeBandExecute
    end
    object actionChangeMode2: TAction
      Tag = 1
      Caption = 'actionChangeMode2'
      OnExecute = actionChangeModeExecute
    end
    object actionChangePower2: TAction
      Tag = 1
      Caption = 'actionChangePower2'
      OnExecute = actionChangePowerExecute
    end
    object actionToggleTxNr: TAction
      Caption = 'actionToggleTxNr'
      ShortCut = 32857
      OnExecute = actionToggleTxNrExecute
    end
    object actionShowCWMonitor: TAction
      Caption = 'CW'#12514#12491#12479#12540
      OnExecute = actionShowCWMonitorExecute
    end
    object actionShowCurrentTxOnly: TAction
      Caption = #12371#12398'TX'#12398#12415#12434#34920#31034
      OnExecute = actionShowCurrentTxOnlyExecute
    end
    object actionLogging: TAction
      Caption = 'actionLogging'
      OnExecute = actionLoggingExecute
    end
    object actionSetRigWPM: TAction
      Caption = #12522#12464#12395'WPM'#12467#12510#12531#12489#12434#36865#20449
      OnExecute = actionSetRigWPMExecute
    end
  end
  object SPCMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 184
    Top = 144
  end
  object VoiceFMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 420
    Top = 137
    object menuVoiceEdit: TMenuItem
      Caption = #20462#27491
      OnClick = menuVoiceEditClick
    end
  end
  object timerCqRepeat: TTimer
    Enabled = False
    Interval = 100
    OnTimer = timerCqRepeatTimer
    Left = 240
    Top = 171
  end
  object FileImportDialog: TOpenDialog
    Filter = 'zLog'#12501#12449#12452#12523'|*.ZLO|zLog'#25313#24373#12501#12449#12452#12523'|*.ZLOX|zLog CSV|*.csv'
    Title = 'Import'
    Left = 472
    Top = 144
  end
  object timerOutOfPeriod: TTimer
    Enabled = False
    Interval = 20
    OnTimer = timerOutOfPeriodTimer
    Left = 304
    Top = 147
  end
  object timerShowInfo: TTimer
    Enabled = False
    Interval = 20
    OnTimer = timerShowInfoTimer
    Left = 320
    Top = 195
  end
end
