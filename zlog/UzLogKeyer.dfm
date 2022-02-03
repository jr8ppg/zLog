object dmZLogKeyer: TdmZLogKeyer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 175
  Width = 299
  object ZComKeying1: TCommPortDriver
    Tag = 3
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfNONE
    InBufSize = 4096
    EnableDTROnOpen = False
    InputTimeout = 500
    OnReceiveData = ZComKeying1ReceiveData
    Left = 91
    Top = 16
  end
  object RepeatTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = RepeatTimerTimer
    Left = 136
    Top = 96
  end
  object ZComKeying2: TCommPortDriver
    Tag = 3
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfNONE
    InBufSize = 4096
    EnableDTROnOpen = False
    OnReceiveData = ZComKeying1ReceiveData
    Left = 151
    Top = 16
  end
  object ZComRxRigSelect: TCommPortDriver
    Tag = 3
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfNONE
    InBufSize = 4096
    EnableDTROnOpen = False
    OnReceiveData = ZComKeying1ReceiveData
    Left = 27
    Top = 64
  end
  object ZComKeying3: TCommPortDriver
    Tag = 3
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfNONE
    InBufSize = 4096
    EnableDTROnOpen = False
    OnReceiveData = ZComKeying1ReceiveData
    Left = 211
    Top = 16
  end
  object ZComTxRigSelect: TCommPortDriver
    Tag = 3
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfNONE
    InBufSize = 4096
    EnableDTROnOpen = False
    OnReceiveData = ZComKeying1ReceiveData
    Left = 27
    Top = 116
  end
end
