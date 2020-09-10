object dmZLogKeyer: TdmZLogKeyer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object HidController: TJvHidDeviceController
    OnEnumerate = DoEnumeration
    OnDeviceChange = DoDeviceChanges
    OnDeviceData = HidControllerDeviceData
    Left = 24
    Top = 16
  end
  object ZComKeying: TCommPortDriver
    Tag = 3
    Port = pnCustom
    PortName = '\\.\COM2'
    HwFlow = hfNONE
    InBufSize = 4096
    EnableDTROnOpen = False
    Left = 91
    Top = 16
  end
end
