inherited ARRL10Multi: TARRL10Multi
  Left = 87
  Top = 140
  Caption = 'Multipliers'
  ClientWidth = 368
  OnDestroy = FormDestroy
  ExplicitWidth = 384
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel: TPanel
    Width = 368
    ExplicitWidth = 368
    inherited RotateLabel1: TRotateLabel
      Left = 316
      Width = 14
      Height = 12
      Caption = 'Ph'
      Visible = False
      ExplicitLeft = 316
      ExplicitWidth = 14
      ExplicitHeight = 12
    end
    inherited RotateLabel2: TRotateLabel
      Left = 328
      Width = 14
      Height = 17
      Caption = 'CW'
      Visible = False
      ExplicitLeft = 328
      ExplicitWidth = 14
      ExplicitHeight = 17
    end
    inherited RotateLabel3: TRotateLabel
      Left = 292
      Top = 13
      Width = 14
      Height = 6
      Visible = False
      ExplicitLeft = 292
      ExplicitTop = 13
      ExplicitWidth = 14
      ExplicitHeight = 6
    end
    inherited RotateLabel4: TRotateLabel
      Left = 303
      Top = 7
      Width = 14
      Height = 12
      Visible = False
      ExplicitLeft = 303
      ExplicitTop = 7
      ExplicitWidth = 14
      ExplicitHeight = 12
    end
    inherited RotateLabel5: TRotateLabel
      Left = 315
      Top = 7
      Width = 14
      Height = 12
      Visible = False
      ExplicitLeft = 315
      ExplicitTop = 7
      ExplicitWidth = 14
      ExplicitHeight = 12
    end
    inherited RotateLabel6: TRotateLabel
      Left = 327
      Top = 7
      Width = 14
      Height = 12
      Visible = False
      ExplicitLeft = 327
      ExplicitTop = 7
      ExplicitWidth = 14
      ExplicitHeight = 12
    end
    object Label1: TLabel [6]
      Left = 240
      Top = 24
      Width = 13
      Height = 13
      Caption = 'Ph'
    end
    object Label2: TLabel [7]
      Left = 256
      Top = 24
      Width = 18
      Height = 13
      Caption = 'CW'
    end
    inherited SortBy: TRadioGroup
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Width = 368
    ExplicitWidth = 368
  end
  inherited Grid: TStringGrid
    Width = 368
    ExplicitWidth = 368
  end
end
