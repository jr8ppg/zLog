object TextEditor: TTextEditor
  Left = 569
  Top = 310
  Caption = #12486#12461#12473#12488#12456#12487#12451#12479
  ClientHeight = 352
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 320
    Width = 554
    Height = 32
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      554
      32)
    object buttonOK: TButton
      Left = 400
      Top = 3
      Width = 72
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      OnClick = buttonOKClick
    end
    object buttonCancel: TButton
      Left = 478
      Top = 3
      Width = 72
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 554
    Height = 320
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    WantTabs = True
    OnKeyDown = Memo1KeyDown
    ExplicitHeight = 314
  end
  object ActionList1: TActionList
    Left = 20
    Top = 260
    object actionSelectAll: TAction
      Caption = 'actionSelectAll'
      ShortCut = 16449
      OnExecute = actionSelectAllExecute
    end
  end
end
