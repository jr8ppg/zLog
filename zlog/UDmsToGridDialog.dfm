object formDmsToGridDialog: TformDmsToGridDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'DMS to GRID'
  ClientHeight = 267
  ClientWidth = 287
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 269
    Height = 85
    Caption = 'DMS'
    Color = clBtnFace
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object Label2: TLabel
      Left = 127
      Top = 25
      Width = 7
      Height = 13
      Caption = #176' '
    end
    object Label3: TLabel
      Left = 183
      Top = 25
      Width = 5
      Height = 13
      Caption = #39' '
    end
    object Label4: TLabel
      Left = 239
      Top = 25
      Width = 4
      Height = 13
      Caption = #39#39
    end
    object Label8: TLabel
      Left = 16
      Top = 27
      Width = 38
      Height = 13
      Caption = 'Latitude'
    end
    object Label9: TLabel
      Left = 16
      Top = 54
      Width = 47
      Height = 13
      Caption = 'Longitude'
    end
    object Label1: TLabel
      Left = 127
      Top = 52
      Width = 7
      Height = 13
      Caption = #176' '
    end
    object Label5: TLabel
      Left = 183
      Top = 52
      Width = 5
      Height = 13
      Caption = #39' '
    end
    object Label6: TLabel
      Left = 239
      Top = 52
      Width = 4
      Height = 13
      Caption = #39#39
    end
    object editLatitudeD: TEdit
      Left = 80
      Top = 22
      Width = 41
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 0
      Text = '138'
    end
    object editLatitudeM: TEdit
      Left = 148
      Top = 22
      Width = 29
      Height = 21
      MaxLength = 2
      NumbersOnly = True
      TabOrder = 1
      Text = '10'
    end
    object editLatitudeS: TEdit
      Left = 204
      Top = 22
      Width = 29
      Height = 21
      MaxLength = 2
      NumbersOnly = True
      TabOrder = 2
      Text = '10'
    end
    object editLongitudeD: TEdit
      Left = 80
      Top = 49
      Width = 41
      Height = 21
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 3
      Text = '138'
    end
    object editLongitudeM: TEdit
      Left = 148
      Top = 49
      Width = 29
      Height = 21
      MaxLength = 2
      NumbersOnly = True
      TabOrder = 4
      Text = '10'
    end
    object editLongitudeS: TEdit
      Left = 204
      Top = 49
      Width = 29
      Height = 21
      MaxLength = 2
      NumbersOnly = True
      TabOrder = 5
      Text = '10'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 233
    Width = 287
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 127
    ExplicitWidth = 271
    DesignSize = (
      287
      34)
    object buttonOK: TButton
      Left = 137
      Top = 4
      Width = 69
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 121
    end
    object buttonCancel: TButton
      Left = 212
      Top = 4
      Width = 69
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 196
    end
  end
  object buttonCalc: TButton
    Left = 88
    Top = 99
    Width = 117
    Height = 21
    Caption = 'Calculation'
    TabOrder = 1
    OnClick = buttonCalcClick
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 126
    Width = 269
    Height = 103
    Caption = 'Result'
    TabOrder = 2
    object Label39: TLabel
      Left = 16
      Top = 48
      Width = 38
      Height = 13
      Caption = 'Latitude'
    end
    object Label42: TLabel
      Left = 16
      Top = 75
      Width = 47
      Height = 13
      Caption = 'Longitude'
    end
    object Label56: TLabel
      Left = 16
      Top = 21
      Width = 51
      Height = 13
      Caption = 'GRID Loc.'
    end
    object editMyLatitude: TEdit
      Left = 96
      Top = 45
      Width = 81
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object editMyLongitude: TEdit
      Left = 96
      Top = 72
      Width = 81
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object editMyGridLoc: TEdit
      Left = 96
      Top = 18
      Width = 81
      Height = 21
      MaxLength = 6
      ReadOnly = True
      TabOrder = 0
    end
  end
end
