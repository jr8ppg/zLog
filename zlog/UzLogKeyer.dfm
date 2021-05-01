object dmZLogKeyer: TdmZLogKeyer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object ZComKeying: TCommPortDriver
    Tag = 3
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfNONE
    InBufSize = 4096
    EnableDTROnOpen = False
    OnReceiveData = ZComKeyingReceiveData
    Left = 91
    Top = 16
  end
  object RepeatTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = RepeatTimerTimer
    Left = 88
    Top = 88
  end
end
