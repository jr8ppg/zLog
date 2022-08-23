inherited FreqList: TFreqList
  Caption = 'Running Frequencies'
  PixelsPerInch = 96
  TextHeight = 12
  inherited Panel1: TPanel
    inherited StayOnTop: TCheckBox
      Left = 216
      ExplicitLeft = 216
    end
    object ClearBtn: TButton
      Left = 80
      Top = 7
      Width = 63
      Height = 21
      Caption = 'Clear'
      TabOrder = 2
      OnClick = ClearBtnClick
    end
  end
end
