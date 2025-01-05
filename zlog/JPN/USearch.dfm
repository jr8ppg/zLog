object formSearch: TformSearch
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'QSO Search'
  ClientHeight = 36
  ClientWidth = 317
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
  object labelCallsign: TLabel
    Left = 4
    Top = 7
    Width = 36
    Height = 13
    Caption = #12467#12540#12523#12469#12452#12531
  end
  object editCallsign: TEdit
    Left = 54
    Top = 4
    Width = 124
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 10
    TabOrder = 0
    OnChange = editCallsignChange
  end
  object buttonFindNext: TButton
    Left = 187
    Top = 4
    Width = 60
    Height = 21
    Caption = #27425'(&N)'
    Default = True
    TabOrder = 1
    OnClick = buttonFindNextClick
  end
  object buttonFindPrev: TButton
    Left = 251
    Top = 4
    Width = 60
    Height = 21
    Caption = #21069'(&P)'
    TabOrder = 2
    OnClick = buttonFindPrevClick
  end
end
