object VoiceForm: TVoiceForm
  Left = 675
  Top = 184
  Caption = 'Voice Control'
  ClientHeight = 28
  ClientWidth = 264
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object MP: TMediaPlayer
    Left = 0
    Top = 0
    Width = -4
    Height = 30
    VisibleButtons = [btPlay, btPause, btStop, btBack, btRecord]
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
  end
  object Timer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerTimer
    Left = 240
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer2Timer
    Left = 196
  end
end
