inherited ScratchSheet: TScratchSheet
  Left = 234
  Top = 250
  Caption = 'Scratch sheet'
  KeyPreview = True
  PopupMenu = PopupMenu
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  inherited ListBox: TListBox
    PopupMenu = PopupMenu
  end
  inherited Panel1: TPanel
    inherited Edit: TEdit
      Left = 6
      Width = 250
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecNormal
      ExplicitLeft = 6
      ExplicitWidth = 250
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
