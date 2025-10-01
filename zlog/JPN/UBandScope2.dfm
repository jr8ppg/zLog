object BandScope2: TBandScope2
  Left = 48
  Top = 125
  Anchors = [akTop, akRight]
  BorderStyle = bsSizeToolWin
  Caption = 'Band Scope'
  ClientHeight = 404
  ClientWidth = 247
  Color = clBtnFace
  Constraints.MinHeight = 140
  Constraints.MinWidth = 255
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 38
    Width = 247
    Height = 366
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
      Width = 235
      Height = 354
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
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 0
      OnContextPopup = GridContextPopup
      OnDblClick = GridDblClick
      OnDrawCell = GridDrawCell
      OnMouseMove = GridMouseMove
      OnMouseWheelDown = GridMouseWheelDown
      OnMouseWheelUp = GridMouseWheelUp
    end
  end
  object panelStandardOption: TPanel
    Left = 0
    Top = 0
    Width = 247
    Height = 19
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      247
      19)
    object buttonShowWorked: TSpeedButton
      Left = 186
      Top = 0
      Width = 60
      Height = 19
      Hint = #20132#20449#28168#12415#12434#34920#31034#12375#12414#12377
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 1
      Caption = #20132#20449#28168#12415
      ParentShowHint = False
      ShowHint = True
      OnClick = buttonShowWorkedClick
      ExplicitLeft = 181
    end
    object buttonSyncVfo: TSpeedButton
      Left = 60
      Top = 0
      Width = 60
      Height = 19
      Hint = 'VFO'#12395#21516#26399#12375#12390#34920#31034#12375#12414#12377
      GroupIndex = 4
      Caption = 'VFO'#21516#26399
      ParentShowHint = False
      ShowHint = True
      OnClick = buttonShowWorkedClick
    end
    object buttonFreqCenter: TSpeedButton
      Left = 119
      Top = 0
      Width = 60
      Height = 19
      Hint = #20013#22830#12395#21608#27874#25968#12434#22266#23450#12375#12414#12377
      GroupIndex = 4
      Caption = #20013#22830#22266#23450
      ParentShowHint = False
      ShowHint = True
      OnClick = buttonShowWorkedClick
    end
    object buttonNormalMode: TSpeedButton
      Left = 1
      Top = 0
      Width = 60
      Height = 19
      Hint = #21608#27874#25968#12399'VFO'#12392#21516#26399#12375#12414#12379#12435
      GroupIndex = 4
      Down = True
      Caption = #12494#12540#12510#12523
      ParentShowHint = False
      ShowHint = True
      OnClick = buttonShowWorkedClick
    end
  end
  object panelAllBandsOption: TPanel
    Left = 0
    Top = 19
    Width = 247
    Height = 19
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    Visible = False
    object buttonSortByFreq: TSpeedButton
      Left = 1
      Top = 0
      Width = 50
      Height = 19
      GroupIndex = 5
      Caption = #21608#27874#25968
      Images = ImageList2
      OnClick = buttonSortByFreqClick
    end
    object buttonSortByTime: TSpeedButton
      Left = 50
      Top = 0
      Width = 50
      Height = 19
      GroupIndex = 5
      Caption = #26178#38291
      Images = ImageList2
      OnClick = buttonSortByTimeClick
    end
  end
  object tabctrlBandSelector: TTabControl
    Left = 0
    Top = 38
    Width = 247
    Height = 366
    Align = alClient
    TabOrder = 3
    Visible = False
    OnChange = tabctrlBandSelectorChange
    OnChanging = tabctrlBandSelectorChanging
    ExplicitLeft = 1
    ExplicitTop = 44
  end
  object BSMenu: TPopupMenu
    Tag = 15
    AutoHotkeys = maManual
    AutoPopup = False
    OnPopup = BSMenuPopup
    Left = 48
    Top = 48
    object menuDeleteSpot: TMenuItem
      Caption = #12371#12398#12473#12509#12483#12488#12434#21066#38500
      OnClick = menuDeleteSpotClick
    end
    object menuDeleteAllWorkedStations: TMenuItem
      Caption = #20132#20449#28168#12415#12473#12509#12483#12488#12434#20840#12390#21066#38500
      OnClick = menuDeleteAllWorkedStationsClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object menuAddToDenyList: TMenuItem
      Caption = #12371#12398#22577#21578#32773#12434#25298#21542#12522#12473#12488#12395#36861#21152
      OnClick = menuAddToDenyListClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object menuAddBlockList: TMenuItem
      Caption = #12502#12525#12483#12463#12522#12473#12488#12395#36861#21152
      OnClick = menuAddBlockListClick
    end
    object menuEditBlockList: TMenuItem
      Caption = #12502#12525#12483#12463#12522#12473#12488#12398#32232#38598
      OnClick = menuEditBlockListClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object menuBSCurrent: TMenuItem
      AutoCheck = True
      Caption = #29694#22312#12496#12531#12489
      OnClick = menuBSCurrentClick
    end
    object menuBSAllBands: TMenuItem
      AutoCheck = True
      Caption = #20840#12496#12531#12489
      OnClick = menuBSAllBandsClick
    end
    object menuBSNewMulti: TMenuItem
      AutoCheck = True
      Caption = #12491#12517#12540#12510#12523#12481
      OnClick = menuBSNewMultiClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object menuBS00: TMenuItem
      AutoCheck = True
      Caption = '1.9'
      OnClick = menuBS00Click
    end
    object menuBS01: TMenuItem
      Tag = 1
      AutoCheck = True
      Caption = '3.5'
      OnClick = menuBS00Click
    end
    object menuBS02: TMenuItem
      Tag = 2
      AutoCheck = True
      Caption = '7'
      OnClick = menuBS00Click
    end
    object menuBS03: TMenuItem
      Tag = 3
      AutoCheck = True
      Caption = '10'
      OnClick = menuBS00Click
    end
    object menuBS04: TMenuItem
      Tag = 4
      AutoCheck = True
      Caption = '14'
      OnClick = menuBS00Click
    end
    object menuBS05: TMenuItem
      Tag = 5
      AutoCheck = True
      Caption = '18'
      OnClick = menuBS00Click
    end
    object menuBS06: TMenuItem
      Tag = 6
      AutoCheck = True
      Caption = '21'
      OnClick = menuBS00Click
    end
    object menuBS07: TMenuItem
      Tag = 7
      AutoCheck = True
      Caption = '24'
      OnClick = menuBS00Click
    end
    object menuBS08: TMenuItem
      Tag = 8
      AutoCheck = True
      Caption = '28'
      OnClick = menuBS00Click
    end
    object menuBS09: TMenuItem
      Tag = 9
      AutoCheck = True
      Caption = '50'
      OnClick = menuBS00Click
    end
    object menuBS10: TMenuItem
      Tag = 10
      AutoCheck = True
      Caption = '144'
      OnClick = menuBS00Click
    end
    object menuBS11: TMenuItem
      Tag = 11
      AutoCheck = True
      Caption = '430'
      OnClick = menuBS00Click
    end
    object menuBS12: TMenuItem
      Tag = 12
      AutoCheck = True
      Caption = '1200'
      OnClick = menuBS00Click
    end
    object menuBS13: TMenuItem
      Tag = 13
      AutoCheck = True
      Caption = '2400'
      OnClick = menuBS00Click
    end
    object menuBS14: TMenuItem
      Tag = 14
      AutoCheck = True
      Caption = '5600'
      OnClick = menuBS00Click
    end
    object menuBS15: TMenuItem
      Tag = 15
      AutoCheck = True
      Caption = '10G'
      OnClick = menuBS00Click
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
  object ActionList1: TActionList
    State = asSuspended
    Left = 118
    Top = 68
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
    object actionPlayMessageA11: TAction
      Tag = 11
      Caption = 'actionPlayMessageA11'
      ShortCut = 122
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayMessageA12: TAction
      Tag = 12
      Caption = 'actionPlayMessageA12'
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
    object actionPlayMessageB11: TAction
      Tag = 11
      Caption = 'actionPlayMessageB11'
      ShortCut = 8314
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayMessageB12: TAction
      Tag = 12
      Caption = 'actionPlayMessageB12'
      ShortCut = 8315
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayCQA1: TAction
      Tag = 101
      Caption = 'actionPlayCQA1'
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayCQA2: TAction
      Tag = 102
      Caption = 'actionPlayCQA2'
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayCQA3: TAction
      Tag = 103
      Caption = 'actionPlayCQA3'
      OnExecute = actionPlayMessageAExecute
    end
    object actionPlayCQB1: TAction
      Tag = 101
      Caption = 'actionPlayCQB1'
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayCQB2: TAction
      Tag = 102
      Caption = 'actionPlayCQB2'
      OnExecute = actionPlayMessageBExecute
    end
    object actionPlayCQB3: TAction
      Tag = 103
      Caption = 'actionPlayCQB3'
      OnExecute = actionPlayMessageBExecute
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
  end
  object ImageList2: TImageList
    Left = 56
    Top = 236
    Bitmap = {
      494C010102000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000
      F00FFE7F00000000F81FFC3F00000000FC3FF81F00000000FE7FF00F00000000
      FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
