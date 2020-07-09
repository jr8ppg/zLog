object CwMessagePad: TCwMessagePad
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'CW Message Pad'
  ClientHeight = 402
  ClientWidth = 179
  Color = clBtnFace
  Constraints.MinHeight = 150
  Constraints.MinWidth = 195
  Font.Charset = ANSI_CHARSET
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
  object CategoryButtons1: TCategoryButtons
    Left = 0
    Top = 0
    Width = 179
    Height = 402
    Align = alClient
    ButtonFlow = cbfVertical
    ButtonWidth = 150
    ButtonOptions = [boAllowReorder, boAllowCopyingButtons, boGradientFill, boShowCaptions, boBoldCaptions]
    Categories = <>
    PopupMenu = PopupMenu1
    RegularButtonColor = clWhite
    SelectedButtonColor = 15132390
    ShowHint = True
    TabOrder = 0
    OnButtonClicked = CategoryButtons1ButtonClicked
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 28
    Top = 212
    object menuEdit: TMenuItem
      Caption = #32232#38598
      OnClick = menuEditClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object menuLoadFromFile: TMenuItem
      Caption = #12501#12449#12452#12523#12363#12425#35501#12415#36796#12415
      OnClick = menuLoadFromFileClick
    end
    object menuSaveToFile: TMenuItem
      Caption = #12501#12449#12452#12523#12395#20445#23384
      OnClick = menuSaveToFileClick
    end
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    DefaultExt = '*.txt'
    Filter = #12486#12461#12473#12488#12501#12449#12452#12523'(*.txt)|*.txt|'#20840#12390#12398#12501#12449#12452#12523'(*.*)|*.*'
    FilterIndex = 0
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 60
    Top = 268
  end
  object SaveTextFileDialog1: TSaveTextFileDialog
    DefaultExt = '*.txt'
    Filter = #12486#12461#12473#12488#12501#12449#12452#12523'(*.txt)|*.txt|'#20840#12390#12398#12501#12449#12452#12523'(*.*)|*.*'
    Left = 56
    Top = 332
  end
end
