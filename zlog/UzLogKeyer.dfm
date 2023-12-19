object dmZLogKeyer: TdmZLogKeyer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 175
  Width = 299
  object ZComKeying1: TCommPortDriver
    Tag = 1
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
  object ZComKeying2: TCommPortDriver
    Tag = 2
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
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfNONE
    InBufSize = 4096
    EnableDTROnOpen = False
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
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfNONE
    InBufSize = 4096
    EnableDTROnOpen = False
    Left = 27
    Top = 116
  end
  object ZComKeying4: TCommPortDriver
    Tag = 4
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfNONE
    InBufSize = 4096
    EnableDTROnOpen = False
    OnReceiveData = ZComKeying1ReceiveData
    Left = 151
    Top = 76
  end
  object ZComKeying5: TCommPortDriver
    Tag = 5
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfNONE
    InBufSize = 4096
    EnableDTROnOpen = False
    OnReceiveData = ZComKeying1ReceiveData
    Left = 211
    Top = 76
  end
end
