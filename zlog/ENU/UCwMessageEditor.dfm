inherited CwMessageEditor: TCwMessageEditor
  Caption = 'TextEditor'
  PixelsPerInch = 96
  TextHeight = 12
  inherited Memo1: TMemo
    HideSelection = False
    WordWrap = False
    OnKeyPress = Memo1KeyPress
    ExplicitHeight = 320
  end
end
