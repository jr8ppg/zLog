object formSelectClusterLog: TformSelectClusterLog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select cluster log'
  ClientHeight = 190
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object listLogFiles: TCheckListBox
    Left = 8
    Top = 8
    Width = 291
    Height = 145
    ItemHeight = 13
    Items.Strings = (
      'zlog_telnet_log_20250207.txt'
      'zlog_telnet_log_20250207.txt'
      'zlog_telnet_log_20250207.txt'
      'zlog_telnet_log_20250207.txt'
      'zlog_telnet_log_20250207.txt'
      'zlog_telnet_log_20250207.txt'
      'zlog_telnet_log_20250207.txt'
      'zlog_telnet_log_20250207.txt'
      'zlog_telnet_log_20250207.txt'
      'zlog_telnet_log_20250207.txt')
    TabOrder = 0
    OnClickCheck = listLogFilesClickCheck
  end
  object Panel1: TPanel
    Left = 0
    Top = 157
    Width = 307
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 216
    object buttonOK: TButton
      Left = 90
      Top = 3
      Width = 65
      Height = 25
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object buttonCancel: TButton
      Left = 161
      Top = 3
      Width = 65
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
