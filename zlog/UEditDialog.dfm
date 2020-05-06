object EditDialog: TEditDialog
  Left = 118
  Top = 386
  BorderStyle = bsDialog
  Caption = 'Dialog'
  ClientHeight = 84
  ClientWidth = 553
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 7
    Top = 52
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 95
    Top = 52
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = CancelBtnClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 553
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object SerialLabel: TLabel
      Left = 8
      Top = 0
      Width = 24
      Height = 12
      Caption = 'ser#'
    end
    object TimeLabel: TLabel
      Left = 48
      Top = 0
      Width = 24
      Height = 12
      Caption = 'time'
    end
    object rcvdRSTLabel: TLabel
      Left = 104
      Top = 0
      Width = 18
      Height = 12
      Caption = 'RST'
    end
    object CallsignLabel: TLabel
      Left = 72
      Top = 0
      Width = 24
      Height = 12
      Caption = 'call'
    end
    object PointLabel: TLabel
      Left = 336
      Top = 0
      Width = 18
      Height = 12
      Caption = 'pts'
    end
    object BandLabel: TLabel
      Left = 224
      Top = 0
      Width = 24
      Height = 12
      Caption = 'band'
    end
    object NumberLabel: TLabel
      Left = 176
      Top = 0
      Width = 24
      Height = 12
      Caption = 'rcvd'
    end
    object ModeLabel: TLabel
      Left = 256
      Top = 0
      Width = 24
      Height = 12
      Caption = 'mode'
    end
    object PowerLabel: TLabel
      Left = 480
      Top = 0
      Width = 18
      Height = 12
      Caption = 'pwr'
      Visible = False
    end
    object OpLabel: TLabel
      Left = 416
      Top = 0
      Width = 12
      Height = 12
      Caption = 'op'
    end
    object MemoLabel: TLabel
      Left = 368
      Top = 0
      Width = 24
      Height = 12
      Caption = 'memo'
    end
    object TimeEdit: TEdit
      Left = 8
      Top = 15
      Width = 49
      Height = 18
      AutoSize = False
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      TabOrder = 10
      OnChange = TimeEditChange
      OnDblClick = DateEditDblClick
    end
    object CallsignEdit: TEdit
      Left = 117
      Top = 15
      Width = 76
      Height = 18
      AutoSelect = False
      AutoSize = False
      CharCase = ecUpperCase
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      MaxLength = 12
      TabOrder = 0
      OnChange = CallsignEditChange
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
    object RcvdRSTEdit: TEdit
      Left = 181
      Top = 15
      Width = 52
      Height = 18
      AutoSize = False
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      TabOrder = 1
      OnChange = RcvdRSTEditChange
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
    object NumberEdit: TEdit
      Left = 197
      Top = 15
      Width = 100
      Height = 18
      AutoSelect = False
      AutoSize = False
      CharCase = ecUpperCase
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      TabOrder = 2
      OnChange = NumberEditChange
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
    object BandEdit: TEdit
      Left = 176
      Top = 15
      Width = 73
      Height = 18
      TabStop = False
      AutoSize = False
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      PopupMenu = BandMenu
      ReadOnly = True
      TabOrder = 3
      OnClick = BandEditClick
    end
    object ModeEdit: TEdit
      Left = 328
      Top = 15
      Width = 33
      Height = 18
      TabStop = False
      AutoSize = False
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      PopupMenu = ModeMenu
      ReadOnly = True
      TabOrder = 4
      OnClick = ModeEditClick
    end
    object MemoEdit: TEdit
      Left = 344
      Top = 15
      Width = 121
      Height = 18
      AutoSize = False
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      TabOrder = 8
      OnChange = MemoEditChange
      OnKeyDown = EditKeyDown
      OnKeyPress = EditKeyPress
    end
    object PointEdit: TEdit
      Left = 256
      Top = 15
      Width = 81
      Height = 18
      AutoSize = False
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      TabOrder = 5
    end
    object PowerEdit: TEdit
      Left = 397
      Top = 15
      Width = 44
      Height = 18
      AutoSize = False
      CharCase = ecUpperCase
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      MaxLength = 4
      TabOrder = 6
      OnChange = PowerEditChange
    end
    object OpEdit: TEdit
      Left = 472
      Top = 15
      Width = 65
      Height = 18
      AutoSize = False
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      PopupMenu = OpMenu
      ReadOnly = True
      TabOrder = 7
      OnClick = OpEditClick
    end
    object SerialEdit: TEdit
      Left = 32
      Top = 15
      Width = 49
      Height = 18
      AutoSize = False
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      TabOrder = 9
      Visible = False
    end
    object DateEdit: TEdit
      Left = 48
      Top = 15
      Width = 81
      Height = 18
      AutoSize = False
      CharCase = ecUpperCase
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      TabOrder = 11
      Visible = False
      OnChange = DateEditChange
      OnDblClick = DateEditDblClick
    end
    object NewPowerEdit: TEdit
      Left = 437
      Top = 15
      Width = 44
      Height = 18
      AutoSize = False
      ImeName = 'MS-IME97 '#26085#26412#35486#20837#21147#65404#65405#65411#65425
      PopupMenu = NewPowerMenu
      ReadOnly = True
      TabOrder = 12
      Visible = False
      OnClick = NewPowerEditClick
    end
  end
  object BandMenu: TPopupMenu
    Left = 368
    Top = 40
  end
  object ModeMenu: TPopupMenu
    Left = 400
    Top = 40
  end
  object OpMenu: TPopupMenu
    Left = 432
    Top = 40
  end
  object NewPowerMenu: TPopupMenu
    Left = 296
    Top = 48
  end
  object MainMenu1: TMainMenu
    Left = 224
    Top = 48
    object edit1: TMenuItem
      Caption = 'edit'
      Visible = False
      object op1: TMenuItem
        Caption = 'op'
        ShortCut = 32847
        Visible = False
        OnClick = op1Click
      end
    end
  end
end
