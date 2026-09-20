object TTYConsole: TTTYConsole
  Left = 175
  Top = 167
  Caption = 'RTTY Console'
  ClientHeight = 391
  ClientWidth = 434
  Color = clBtnFace
  Constraints.MinHeight = 450
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OnActivate = FormActivate
  OnClick = buttonSendClick
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 13
  object TPanel
    Left = 161
    Top = 0
    Width = 273
    Height = 391
    Align = alClient
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 207
      Width = 271
      Height = 4
      Cursor = crVSplit
      Align = alBottom
      MinSize = 1
      ExplicitTop = 196
      ExplicitWidth = 364
    end
    object panelTx: TPanel
      Left = 1
      Top = 211
      Width = 271
      Height = 179
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object TXLog: TMemo
        Left = 0
        Top = 24
        Width = 271
        Height = 68
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Consolas'
        Font.Style = []
        ImeMode = imDisable
        Lines.Strings = (
          'txlog')
        ParentFont = False
        TabOrder = 0
        OnKeyDown = TXLogKeyDown
        OnKeyPress = TXLogKeyPress
      end
      object panelTxHeader: TPanel
        Left = 0
        Top = 0
        Width = 271
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          271
          24)
        object Label1: TLabel
          Left = 4
          Top = 5
          Width = 35
          Height = 13
          Caption = 'TX '#12525#12464
        end
        object buttonTXLogClear: TButton
          Left = 195
          Top = 3
          Width = 70
          Height = 19
          Anchors = [akTop, akRight]
          Caption = #12463#12522#12450
          TabOrder = 0
          OnClick = buttonTXLogClearClick
        end
        object checkAutoPttOff: TCheckBox
          Left = 95
          Top = 4
          Width = 97
          Height = 17
          Anchors = [akTop, akRight]
          Caption = 'Auto PTT OFF'
          TabOrder = 1
        end
      end
      object panelTxMessages: TPanel
        Left = 0
        Top = 92
        Width = 271
        Height = 87
        Align = alBottom
        TabOrder = 2
        DesignSize = (
          271
          87)
        object buttonCallMessage1: TSpeedButton
          Left = 244
          Top = 6
          Width = 21
          Height = 21
          Anchors = [akTop, akRight]
          ImageIndex = 1
          Images = ImageList1
          OnClick = buttonCallMessageClick
          ExplicitLeft = 329
        end
        object buttonCallMessage2: TSpeedButton
          Tag = 1
          Left = 244
          Top = 33
          Width = 21
          Height = 21
          Anchors = [akTop, akRight]
          ImageIndex = 1
          Images = ImageList1
          OnClick = buttonCallMessageClick
          ExplicitLeft = 329
        end
        object buttonCallMessage3: TSpeedButton
          Tag = 2
          Left = 244
          Top = 60
          Width = 21
          Height = 21
          Anchors = [akTop, akRight]
          ImageIndex = 1
          Images = ImageList1
          OnClick = buttonCallMessageClick
          ExplicitLeft = 329
        end
        object editMessage1: TEdit
          Left = 28
          Top = 6
          Width = 210
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          OnKeyPress = editMessageKeyPress
        end
        object editMessage2: TEdit
          Tag = 1
          Left = 28
          Top = 33
          Width = 210
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
          OnKeyPress = editMessageKeyPress
        end
        object editMessage3: TEdit
          Tag = 2
          Left = 28
          Top = 60
          Width = 210
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 5
          OnKeyPress = editMessageKeyPress
        end
        object buttonSend1: TButton
          Left = 4
          Top = 6
          Width = 21
          Height = 21
          Caption = 'S'
          TabOrder = 0
          OnClick = buttonSendClick
        end
        object buttonSend2: TButton
          Tag = 1
          Left = 4
          Top = 33
          Width = 21
          Height = 21
          Caption = 'S'
          TabOrder = 2
          OnClick = buttonSendClick
        end
        object buttonSend3: TButton
          Tag = 2
          Left = 4
          Top = 60
          Width = 21
          Height = 21
          Caption = 'S'
          TabOrder = 4
          OnClick = buttonSendClick
        end
      end
    end
    object panelRx: TPanel
      Left = 1
      Top = 1
      Width = 271
      Height = 206
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object panelRxHeader: TPanel
        Left = 0
        Top = 0
        Width = 271
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          271
          24)
        object Label2: TLabel
          Left = 4
          Top = 5
          Width = 36
          Height = 13
          Caption = 'RX '#12525#12464
        end
        object buttonRXLogClear: TButton
          Left = 195
          Top = 3
          Width = 70
          Height = 19
          Anchors = [akTop, akRight]
          Caption = #12463#12522#12450
          TabOrder = 0
          OnClick = buttonRXLogClearClick
        end
      end
      object RXLog: TColorConsole2
        Left = 0
        Top = 24
        Width = 271
        Height = 182
        Align = alClient
        ParentColor = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Consolas'
        Font.Style = []
        TextColor = clWindowText
        BackgroundColor = clWindow
        OnSelected = RXLogSelected
        LineBreak = CRLF
      end
    end
  end
  object panelLeft: TPanel
    Left = 0
    Top = 0
    Width = 161
    Height = 391
    Align = alLeft
    TabOrder = 1
    object CallsignList: TListBox
      Left = 1
      Top = 25
      Width = 159
      Height = 365
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Consolas'
      Font.Style = []
      ImeMode = imDisable
      ItemHeight = 14
      ParentFont = False
      PopupMenu = popupCallsignList
      TabOrder = 0
      OnClick = CallsignListClick
      OnDblClick = CallsignListDblClick
    end
    object panelLeftHeader: TPanel
      Left = 1
      Top = 1
      Width = 159
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label3: TLabel
        Left = 4
        Top = 5
        Width = 51
        Height = 13
        Caption = #12467#12540#12523#12469#12452#12531#12522#12473#12488
      end
      object buttonCallListClear: TButton
        Left = 100
        Top = 3
        Width = 56
        Height = 19
        Caption = #12463#12522#12450
        TabOrder = 0
        OnClick = buttonCallListClearClick
      end
    end
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 96
    Top = 256
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 48
    Top = 264
    object menuConsole: TMenuItem
      Caption = #12467#12531#12477#12540#12523'(&C)'
      object menuClearRxLog: TMenuItem
        Caption = 'RX '#12525#12464#12434#12463#12522#12450'(&R)'
        OnClick = menuClearRxLogClick
      end
      object menuClearTxLog: TMenuItem
        Caption = 'TX '#12525#12464#12434#12463#12522#12450'(&T)'
        OnClick = menuClearTxLogClick
      end
      object menuClearCallsignlist: TMenuItem
        Caption = #12467#12540#12523#12469#12452#12531#12522#12473#12488#12434#12463#12522#12450'(&C)'
        OnClick = menuClearCallsignlistClick
      end
      object menuClearEverything: TMenuItem
        Caption = #20840#12390#12463#12522#12450
        OnClick = menuClearEverythingClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object menuOptions: TMenuItem
        Caption = #35373#23450'(&O)'
        OnClick = menuOptionsClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object menuStayOnTop: TMenuItem
        Caption = #25163#21069#12395#34920#31034'(&S)'
        OnClick = menuStayOnTopClick
      end
    end
  end
  object ActionList1: TActionList
    State = asSuspended
    Left = 308
    Top = 60
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
    object actionControlPTT: TAction
      Caption = 'actionControlPTT'
      OnExecute = actionControlPTTExecute
    end
    object actionRttyGrab: TAction
      Caption = 'Set callsign'
      OnExecute = actionRttyGrabExecute
    end
  end
  object popupCallsignList: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    OnPopup = popupCallsignListPopup
    Left = 76
    Top = 168
    object actionRttyGrab1: TMenuItem
      Action = actionRttyGrab
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object menuCallsignDelete: TMenuItem
      Caption = 'Delete'
      OnClick = menuCallsignDeleteClick
    end
    object menuDebugSep: TMenuItem
      Caption = '-'
    end
    object menuLoadList: TMenuItem
      Caption = 'Load'
      OnClick = menuLoadListClick
    end
    object menuSaveList: TMenuItem
      Caption = 'Save'
      OnClick = menuSaveListClick
    end
  end
  object ImageList1: TImageList
    Left = 176
    Top = 100
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
  object popupMessageList: TPopupMenu
    Left = 100
    Top = 332
  end
end
