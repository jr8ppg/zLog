object SuperCheck: TSuperCheck
  Left = 472
  Top = 79
  ActiveControl = SpinEdit
  Caption = 'Super Check'
  ClientHeight = 112
  ClientWidth = 238
  Color = clBtnFace
  Constraints.MinHeight = 150
  Constraints.MinWidth = 250
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 77
    Width = 238
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 76
    ExplicitWidth = 234
    DesignSize = (
      238
      35)
    object Label1: TLabel
      Left = 149
      Top = 12
      Width = 40
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #21015#25968
      Layout = tlCenter
      ExplicitLeft = 153
    end
    object Button3: TButton
      Left = 4
      Top = 7
      Width = 63
      Height = 21
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button3Click
    end
    object StayOnTop: TCheckBox
      Left = 71
      Top = 9
      Width = 100
      Height = 17
      Caption = #25163#21069#12395#34920#31034
      TabOrder = 1
      OnClick = StayOnTopClick
    end
    object SpinEdit: TSpinEdit
      Left = 193
      Top = 8
      Width = 33
      Height = 22
      Anchors = [akTop, akRight]
      MaxValue = 5
      MinValue = 1
      TabOrder = 2
      Value = 1
      OnChange = SpinEditChange
      ExplicitLeft = 189
    end
  end
  object Grid: TStringGrid
    Left = 0
    Top = 0
    Width = 238
    Height = 77
    Align = alClient
    DefaultDrawing = False
    FixedCols = 0
    FixedRows = 0
    GridLineWidth = 0
    ScrollBars = ssVertical
    TabOrder = 1
    OnDblClick = GridDblClick
    OnDrawCell = GridDrawCell
    ExplicitWidth = 234
    ExplicitHeight = 76
  end
end
