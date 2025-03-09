object formSearch: TformSearch
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'QSO Search'
  ClientHeight = 36
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 13
  object labelSearchString: TLabel
    Left = 4
    Top = 7
    Width = 62
    Height = 13
    Caption = #26908#32034#25991#23383#21015
  end
  object editCallsign: TEdit
    Left = 74
    Top = 4
    Width = 124
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 10
    TabOrder = 0
    OnChange = editCallsignChange
  end
  object buttonFindNext: TButton
    Left = 207
    Top = 4
    Width = 60
    Height = 21
    Caption = #27425'(&N)'
    Default = True
    TabOrder = 1
    OnClick = buttonFindNextClick
  end
  object buttonFindPrev: TButton
    Left = 271
    Top = 4
    Width = 60
    Height = 21
    Caption = #21069'(&P)'
    TabOrder = 2
    OnClick = buttonFindPrevClick
  end
end
