inherited ScratchSheet: TScratchSheet
  Left = 234
  Top = 250
  Caption = 'Scratch sheet'
  PopupMenu = PopupMenu
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  inherited ListBox: TListBox
    PopupMenu = PopupMenu
  end
  inherited Panel1: TPanel
    inherited Edit: TEdit
      CharCase = ecNormal
    end
  end
  object PopupMenu: TPopupMenu
    Left = 72
    Top = 48
    object LocalOnly: TMenuItem
      Caption = 'Show local memo only'
      OnClick = LocalOnlyClick
    end
    object Clear1: TMenuItem
      Caption = 'Clear'
      OnClick = Clear1Click
    end
  end
end
