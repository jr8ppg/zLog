inherited CwMessageEditor: TCwMessageEditor
  Caption = 'TextEditor'
  PixelsPerInch = 96
  TextHeight = 12
  inherited Memo1: TMemo
    HideSelection = False
    OnKeyPress = Memo1KeyPress
  end
end
