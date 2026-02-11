object formHamlogLookup: TformHamlogLookup
  Left = 0
  Top = 0
  Caption = 'HamlogLookup'
  ClientHeight = 191
  ClientWidth = 484
  Color = clBtnFace
  Constraints.MinHeight = 250
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Menu = MainMenu1
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 484
    Height = 33
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 10
      Width = 66
      Height = 12
      Caption = #12467#12540#12523#12469#12452#12531
    end
    object buttonQuery: TButton
      Left = 215
      Top = 5
      Width = 58
      Height = 25
      Caption = #29031#20250
      TabOrder = 1
      OnClick = buttonQueryClick
    end
    object editCallsign: TEdit
      Left = 80
      Top = 7
      Width = 129
      Height = 20
      CharCase = ecUpperCase
      TabOrder = 0
      OnChange = editCallsignChange
      OnEnter = editCallsignEnter
      OnExit = editCallsignExit
    end
    object checkZlog: TCheckBox
      Left = 288
      Top = 9
      Width = 81
      Height = 17
      Caption = 'zLog'#36899#21205
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 2
      OnClick = checkZlogClick
    end
    object checkStayOnTop: TCheckBox
      Left = 375
      Top = 9
      Width = 105
      Height = 17
      Caption = #24120#12395#25163#21069#12395#34920#31034
      TabOrder = 3
      OnClick = checkStayOnTopClick
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 33
    Width = 484
    Height = 139
    Align = alClient
    Columns = <
      item
        Caption = 'CALLSIGN'
        Width = 80
      end
      item
        Caption = 'Date'
        Width = 100
      end
      item
        Caption = 'Time'
        Width = 80
      end
      item
        Caption = 'Freq'
        Width = 80
      end
      item
        Caption = 'Mode'
      end
      item
        Caption = 'Code'
        Width = 80
      end
      item
        Caption = 'Name'
        Width = 80
      end
      item
        Caption = 'QTH'
        Width = 100
      end
      item
        Caption = 'Rmk1'
        Width = 80
      end
      item
        Caption = 'Rmk2'
        Width = 100
      end
      item
        Caption = 'QSL'
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    GridLines = True
    OwnerDraw = True
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 1
    ViewStyle = vsReport
    OnAdvancedCustomDrawItem = ListView1AdvancedCustomDrawItem
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 172
    Width = 484
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Width = 80
      end
      item
        Alignment = taCenter
        Width = 80
      end
      item
        Alignment = taCenter
        Width = 120
      end
      item
        Alignment = taCenter
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object timerLogSync: TTimer
    Enabled = False
    Interval = 500
    OnTimer = timerLogSyncTimer
    Left = 688
  end
  object MainMenu1: TMainMenu
    Left = 716
    object F1: TMenuItem
      Caption = #12501#12449#12452#12523'(&F)'
      object menuOptions: TMenuItem
        Caption = #12458#12503#12471#12519#12531'(&O)'
        GroupIndex = 1
        OnClick = menuOptionsClick
      end
      object N1: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object menuExit: TMenuItem
        Caption = #32066#20102'(&X)'
        GroupIndex = 1
        OnClick = menuExitClick
      end
    end
  end
end
