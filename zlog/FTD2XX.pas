unit FTD2XX;

//
// FTD2XX.pas
//
// Interface definition for FTD2XX.DLL
//

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes;

type
  FT_STATUS = Integer;
  FT_HANDLE = THandle;
  PFT_HANDLE = ^FT_HANDLE;

type
  // Device Info Node structure for info list functions
  TFT_Device_Info_Node = record
    Flags: DWORD;
    DeviceType: DWORD;
    ID: DWORD;
    LocID: DWORD;
    SerialNumber: array [0 .. 15] of AnsiChar;
    Description: array [0 .. 63] of AnsiChar;
    DeviceHandle: DWORD;
  end;

  // Structure to hold EEPROM data for FT_EE_Program function
  TFT_Program_Data = record
    Signature1: DWORD;
    Signature2: DWORD;
    Version: DWORD;
    VendorID: WORD;
    ProductID: WORD;
    Manufacturer: PAnsiChar;
    ManufacturerID: PAnsiChar;
    Description: PAnsiChar;
    SerialNumber: PAnsiChar;
    MaxPower: WORD;
    PnP: WORD;
    SelfPowered: WORD;
    RemoteWakeup: WORD;
    // Rev4 extensions
    Rev4: BYTE;
    IsoIn: BYTE;
    IsoOut: BYTE;
    PullDownEnable: BYTE;
    SerNumEnable: BYTE;
    USBVersionEnable: BYTE;
    USBVersion: WORD;
    // FT2232C extensions
    Rev5: BYTE;
    IsoInA: BYTE;
    IsoInB: BYTE;
    IsoOutA: BYTE;
    IsoOutB: BYTE;
    PullDownEnable5: BYTE;
    SerNumEnable5: BYTE;
    USBVersionEnable5: BYTE;
    USBVersion5: WORD;
    AIsHighCurrent: BYTE;
    BIsHighCurrent: BYTE;
    IFAIsFifo: BYTE;
    IFAIsFifoTar: BYTE;
    IFAIsFastSer: BYTE;
    AIsVCP: BYTE;
    IFBIsFifo: BYTE;
    IFBIsFifoTar: BYTE;
    IFBIsFastSer: BYTE;
    BIsVCP: BYTE;
    // FT232R extensions
    UseExtOsc: BYTE;
    HighDriveIOs: BYTE;
    EndpointSize: BYTE;
    PullDownEnableR: BYTE;
    SerNumEnableR: BYTE;
    InvertTXD: BYTE;
    InvertRXD: BYTE;
    InvertRTS: BYTE;
    InvertCTS: BYTE;
    InvertDTR: BYTE;
    InvertDSR: BYTE;
    InvertDCD: BYTE;
    InvertRI: BYTE;
    Cbus0: BYTE;
    Cbus1: BYTE;
    Cbus2: BYTE;
    Cbus3: BYTE;
    Cbus4: BYTE;
    RIsVCP: BYTE;
  end;

const
   FT_DEVICE_NAME = 'FT245R USB FIFO';

   // FT_Result Values
   FT_OK = 0;
   FT_INVALID_HANDLE = 1;
   FT_DEVICE_NOT_FOUND = 2;
   FT_DEVICE_NOT_OPENED = 3;
   FT_IO_ERROR = 4;
   FT_INSUFFICIENT_RESOURCES = 5;
   FT_INVALID_PARAMETER = 6;
   FT_SUCCESS = FT_OK;
   FT_INVALID_BAUD_RATE = 7;
   FT_DEVICE_NOT_OPENED_FOR_ERASE = 8;
   FT_DEVICE_NOT_OPENED_FOR_WRITE = 9;
   FT_FAILED_TO_WRITE_DEVICE = 10;
   FT_EEPROM_READ_FAILED = 11;
   FT_EEPROM_WRITE_FAILED = 12;
   FT_EEPROM_ERASE_FAILED = 13;
   FT_EEPROM_NOT_PRESENT = 14;
   FT_EEPROM_NOT_PROGRAMMED = 15;
   FT_INVALID_ARGS = 16;
   FT_OTHER_ERROR = 17;

   // FT_Open_Ex Flags
   FT_OPEN_BY_SERIAL_NUMBER = 1;
   FT_OPEN_BY_DESCRIPTION = 2;
   FT_OPEN_BY_LOCATION = 4;

   // FT_List_Devices Flags
   FT_LIST_NUMBER_ONLY = $80000000;
   FT_LIST_BY_INDEX = $40000000;
   FT_LIST_ALL = $20000000;

   // Baud Rate Selection
   FT_BAUD_300 = 300;
   FT_BAUD_600 = 600;
   FT_BAUD_1200 = 1200;
   FT_BAUD_2400 = 2400;
   FT_BAUD_4800 = 4800;
   FT_BAUD_9600 = 9600;
   FT_BAUD_14400 = 14400;
   FT_BAUD_19200 = 19200;
   FT_BAUD_38400 = 38400;
   FT_BAUD_57600 = 57600;
   FT_BAUD_115200 = 115200;
   FT_BAUD_230400 = 230400;
   FT_BAUD_460800 = 460800;
   FT_BAUD_921600 = 921600;

   // Data Bits Selection
   FT_DATA_BITS_7 = 7;
   FT_DATA_BITS_8 = 8;

   // Stop Bits Selection
   FT_STOP_BITS_1 = 0;
   FT_STOP_BITS_2 = 2;

   // Parity Selection
   FT_PARITY_NONE = 0;
   FT_PARITY_ODD = 1;
   FT_PARITY_EVEN = 2;
   FT_PARITY_MARK = 3;
   FT_PARITY_SPACE = 4;

   // Flow Control Selection
   FT_FLOW_NONE = $0000;
   FT_FLOW_RTS_CTS = $0100;
   FT_FLOW_DTR_DSR = $0200;
   FT_FLOW_XON_XOFF = $0400;

   // Purge Commands
   FT_PURGE_RX = 1;
   FT_PURGE_TX = 2;

   // Notification Events
   FT_EVENT_RXCHAR = 1;
   FT_EVENT_MODEM_STATUS = 2;

   // Modem Status
   CTS = $10;
   DSR = $20;
   RI = $40;
   DCD = $80;

   // IO Buffer Sizes
   FT_In_Buffer_Size = $10000; // 64k
   FT_In_Buffer_Index = FT_In_Buffer_Size - 1;
   FT_Out_Buffer_Size = $10000; // 64k
   FT_Out_Buffer_Index = FT_Out_Buffer_Size - 1;

   // DLL Name
   FT_DLL_Name = 'FTD2XX.DLL';

type
  // function型の定義
  // Classic functions
  TFT_GetNumDevicesProc = function(pvArg1: Pointer; pvArg2: Pointer; dwFlags: DWORD): FT_STATUS; stdcall;
  TFT_ListDevicesProc = function(pvArg1: DWORD; pvArg2: Pointer; dwFlags: DWORD): FT_STATUS; stdcall;
  TFT_OpenProc = function(Index: Integer; ftHandle: PFT_HANDLE): FT_STATUS; stdcall;
  TFT_OpenExProc = function(pvArg1: Pointer; dwFlags: DWORD; ftHandle: PFT_HANDLE): FT_STATUS; stdcall;
  TFT_OpenByLocationProc = function(pvArg1: DWORD; dwFlags: DWORD; ftHandle: PFT_HANDLE): FT_STATUS; stdcall;
  TFT_CloseProc = function(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
  TFT_ReadProc = function(ftHandle: FT_HANDLE; lpBuffer: LPVOID; dwBytesToRead: DWORD; lpdwBytesReturned: LPDWORD): FT_STATUS; stdcall;
  TFT_WriteProc = function(ftHandle: FT_HANDLE; lpBuffer: LPVOID; dwBytesToWrite: DWORD; lpdwBytesWritten: LPDWORD): FT_STATUS; stdcall;
  TFT_ResetDeviceProc = function(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
  TFT_SetBaudRateProc = function(ftHandle: FT_HANDLE; BaudRate: DWORD): FT_STATUS; stdcall;
  TFT_SetDivisorProc = function(ftHandle: FT_HANDLE; Divisor: DWORD): FT_STATUS; stdcall;
  TFT_SetDataCharacteristicsProc = function(ftHandle: FT_HANDLE; WordLength, StopBits, Parity: BYTE): FT_STATUS; stdcall;
  TFT_SetFlowControlProc = function(ftHandle: FT_HANDLE; FlowControl: WORD; XonChar, XoffChar: BYTE): FT_STATUS; stdcall;
  TFT_SetDtrProc = function(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
  TFT_ClrDtrProc = function(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
  TFT_SetRtsProc = function(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
  TFT_ClrRtsProc = function(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
  TFT_GetModemStatusProc = function(ftHandle: FT_HANDLE; ModemStatus: Pointer): FT_STATUS; stdcall;
  TFT_SetCharsProc = function(ftHandle: FT_HANDLE; EventChar, EventCharEnabled, ErrorChar, ErrorCharEnabled: BYTE): FT_STATUS; stdcall;
  TFT_PurgeProc = function(ftHandle: FT_HANDLE; Mask: DWORD): FT_STATUS; stdcall;
  TFT_SetTimeoutsProc = function(ftHandle: FT_HANDLE; ReadTimeOut, WriteTimeOut: DWORD): FT_STATUS; stdcall;
  TFT_GetQueueStatusProc = function(ftHandle: FT_HANDLE; RxBytes: Pointer): FT_STATUS; stdcall;
  TFT_SetBreakOnProc = function(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
  TFT_SetBreakOffProc = function(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
  TFT_GetStatusProc = function(ftHandle: FT_HANDLE; RxBytes, TxBytes, EventStatus: Pointer): FT_STATUS; stdcall;
  TFT_SetEventNotificationProc = function(ftHandle: FT_HANDLE; EventMask: DWORD; pvArgs: Pointer): FT_STATUS; stdcall;
  TFT_GetDeviceInfoProc = function(ftHandle: FT_HANDLE; DevType, ID, SerNum, Desc, pvDummy: Pointer): FT_STATUS; stdcall;
  TFT_SetResetPipeRetryCountProc = function(ftHandle: FT_HANDLE; RetryCount: DWORD): FT_STATUS; stdcall;
  TFT_StopInTaskProc = function(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
  TFT_RestartInTaskProc = function(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
  TFT_ResetPortProc = function(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
  TFT_CyclePortProc = function(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
  TFT_CreateDeviceInfoListProc = function(NumDevs: Pointer): FT_STATUS; stdcall;
  TFT_GetDeviceInfoListProc = function(pFT_Device_Info_List: Pointer; NumDevs: Pointer): FT_STATUS; stdcall;
  TFT_GetDeviceInfoDetailProc = function(Index: DWORD; Flags, DevType, ID, LocID, SerialNumber, Description, DevHandle: Pointer): FT_STATUS; stdcall;
  TFT_GetDriverVersionProc = function(ftHandle: FT_HANDLE; DrVersion: Pointer): FT_STATUS; stdcall;
  TFT_GetLibraryVersionProc = function(LbVersion: Pointer): FT_STATUS; stdcall;

  // EEPROM s
  TFT_EE_ReadProc = function(ftHandle: FT_HANDLE; pEEData: Pointer): FT_STATUS; stdcall;
  TFT_EE_ProgramProc = function(ftHandle: FT_HANDLE; pEEData: Pointer): FT_STATUS; stdcall;

  // EEPROM primitives - you need an NDA for EEPROM checksum
  TFT_ReadEEProc = function(ftHandle: FT_HANDLE; WordAddr: DWORD; WordRead: Pointer): FT_STATUS; stdcall;
  TFT_WriteEEProc = function(ftHandle: FT_HANDLE; WordAddr: DWORD; WordData: WORD): FT_STATUS; stdcall;
  TFT_EraseEEProc = function(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
  TFT_EE_UAReadProc = function(ftHandle: FT_HANDLE; Data: Pointer; DataLen: DWORD; BytesRead: Pointer): FT_STATUS; stdcall;
  TFT_EE_UAWriteProc = function(ftHandle: FT_HANDLE; Data: Pointer; DataLen: DWORD): FT_STATUS; stdcall;
  TFT_EE_UASizeProc = function(ftHandle: FT_HANDLE; UASize: Pointer): FT_STATUS; stdcall;

  // FT2232C, FT232BM and FT245BM Extended API s
  TFT_GetLatencyTimerProc = function(ftHandle: FT_HANDLE; pucTimer: PUCHAR): FT_STATUS; stdcall;
  TFT_SetLatencyTimerProc = function(ftHandle: FT_HANDLE; ucTimer: UCHAR): FT_STATUS; stdcall;
  TFT_GetBitModeProc = function(ftHandle: FT_HANDLE; pucMode: PUCHAR): FT_STATUS; stdcall;
  TFT_SetBitModeProc = function(ftHandle: FT_HANDLE; ucMask, ucMode: UCHAR): FT_STATUS; stdcall;
  TFT_SetUSBParametersProc = function(ftHandle: FT_HANDLE; dwInTransferSize: DWORD; dwOutTransferSize: DWORD): FT_STATUS; stdcall;

var
  hD2XXLibrary: THandle = 0;

  // 関数ポインタ
  // Classic functions
  fnTFT_GetNumDevicesProc: TFT_GetNumDevicesProc;
  fnTFT_ListDevicesProc: TFT_ListDevicesProc;
  fnTFT_OpenProc: TFT_OpenProc;
  fnTFT_OpenExProc: TFT_OpenExProc;
  fnTFT_OpenByLocationProc: TFT_OpenByLocationProc;
  fnTFT_CloseProc: TFT_CloseProc;
  fnTFT_ReadProc: TFT_ReadProc;
  fnTFT_WriteProc: TFT_WriteProc;
  fnTFT_ResetDeviceProc: TFT_ResetDeviceProc;
  fnTFT_SetBaudRateProc: TFT_SetBaudRateProc;
  fnTFT_SetDivisorProc: TFT_SetDivisorProc;
  fnTFT_SetDataCharacteristicsProc: TFT_SetDataCharacteristicsProc;
  fnTFT_SetFlowControlProc: TFT_SetFlowControlProc;
  fnTFT_SetDtrProc: TFT_SetDtrProc;
  fnTFT_ClrDtrProc: TFT_ClrDtrProc;
  fnTFT_SetRtsProc: TFT_SetRtsProc;
  fnTFT_ClrRtsProc: TFT_ClrRtsProc;
  fnTFT_GetModemStatusProc: TFT_GetModemStatusProc;
  fnTFT_SetCharsProc: TFT_SetCharsProc;
  fnTFT_PurgeProc: TFT_PurgeProc;
  fnTFT_SetTimeoutsProc: TFT_SetTimeoutsProc;
  fnTFT_GetQueueStatusProc: TFT_GetQueueStatusProc;
  fnTFT_SetBreakOnProc: TFT_SetBreakOnProc;
  fnTFT_SetBreakOffProc: TFT_SetBreakOffProc;
  fnTFT_GetStatusProc: TFT_GetStatusProc;
  fnTFT_SetEventNotificationProc: TFT_SetEventNotificationProc;
  fnTFT_GetDeviceInfoProc: TFT_GetDeviceInfoProc;
  fnTFT_SetResetPipeRetryCountProc: TFT_SetResetPipeRetryCountProc;
  fnTFT_StopInTaskProc: TFT_StopInTaskProc;
  fnTFT_RestartInTaskProc: TFT_RestartInTaskProc;
  fnTFT_ResetPortProc: TFT_ResetPortProc;
  fnTFT_CyclePortProc: TFT_CyclePortProc;
  fnTFT_CreateDeviceInfoListProc: TFT_CreateDeviceInfoListProc;
  fnTFT_GetDeviceInfoListProc: TFT_GetDeviceInfoListProc;
  fnTFT_GetDeviceInfoDetailProc: TFT_GetDeviceInfoDetailProc;
  fnTFT_GetDriverVersionProc: TFT_GetDriverVersionProc;
  fnTFT_GetLibraryVersionProc: TFT_GetLibraryVersionProc;

  // EEPROM s
  fnTFT_EE_ReadProc: TFT_EE_ReadProc;
  fnTFT_EE_ProgramProc: TFT_EE_ProgramProc;

  // EEPROM primitives - you need an NDA for EEPROM checksum
  fnTFT_ReadEEProc: TFT_ReadEEProc;
  fnTFT_WriteEEProc: TFT_WriteEEProc;
  fnTFT_EraseEEProc: TFT_EraseEEProc;
  fnTFT_EE_UAReadProc: TFT_EE_UAReadProc;
  fnTFT_EE_UAWriteProc: TFT_EE_UAWriteProc;
  fnTFT_EE_UASizeProc: TFT_EE_UASizeProc;

  // FT2232C, FT232BM and FT245BM Extended API s
  fnTFT_GetLatencyTimerProc: TFT_GetLatencyTimerProc;
  fnTFT_SetLatencyTimerProc: TFT_SetLatencyTimerProc;
  fnTFT_GetBitModeProc: TFT_GetBitModeProc;
  fnTFT_SetBitModeProc: TFT_SetBitModeProc;
  fnTFT_SetUSBParametersProc: TFT_SetUSBParametersProc;

// function定義
function IsFTD2XXLoaded(): Boolean;
function FT_GetNumDevices(pvArg1: Pointer; pvArg2: Pointer; dwFlags: DWORD): FT_STATUS; stdcall;
function FT_ListDevices(pvArg1: DWORD; pvArg2: Pointer; dwFlags: DWORD): FT_STATUS; stdcall;
function FT_Open(Index: Integer; ftHandle: PFT_HANDLE): FT_STATUS; stdcall;
function FT_OpenEx(pvArg1: Pointer; dwFlags: DWORD; ftHandle: PFT_HANDLE): FT_STATUS; stdcall;
function FT_OpenByLocation(pvArg1: DWORD; dwFlags: DWORD; ftHandle: PFT_HANDLE): FT_STATUS; stdcall;
function FT_Close(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
function FT_Read(ftHandle: FT_HANDLE; lpBuffer: LPVOID; dwBytesToRead: DWORD; lpdwBytesReturned: LPDWORD): FT_STATUS; stdcall;
function FT_Write(ftHandle: FT_HANDLE; lpBuffer: LPVOID; dwBytesToWrite: DWORD; lpdwBytesWritten: LPDWORD): FT_STATUS; stdcall;
function FT_ResetDevice(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
function FT_SetBaudRate(ftHandle: FT_HANDLE; BaudRate: DWORD): FT_STATUS; stdcall;
function FT_SetDivisor(ftHandle: FT_HANDLE; Divisor: DWORD): FT_STATUS; stdcall;
function FT_SetDataCharacteristics(ftHandle: FT_HANDLE; WordLength, StopBits, Parity: BYTE): FT_STATUS; stdcall;
function FT_SetFlowControl(ftHandle: FT_HANDLE; FlowControl: WORD; XonChar, XoffChar: BYTE): FT_STATUS; stdcall;
function FT_SetDtr(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
function FT_ClrDtr(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
function FT_SetRts(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
function FT_ClrRts(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
function FT_GetModemStatus(ftHandle: FT_HANDLE; ModemStatus: Pointer): FT_STATUS; stdcall;
function FT_SetChars(ftHandle: FT_HANDLE; EventChar, EventCharEnabled, ErrorChar, ErrorCharEnabled: BYTE): FT_STATUS; stdcall;
function FT_Purge(ftHandle: FT_HANDLE; Mask: DWORD): FT_STATUS; stdcall;
function FT_SetTimeouts(ftHandle: FT_HANDLE; ReadTimeOut, WriteTimeOut: DWORD): FT_STATUS; stdcall;
function FT_GetQueueStatus(ftHandle: FT_HANDLE; RxBytes: Pointer): FT_STATUS; stdcall;
function FT_SetBreakOn(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
function FT_SetBreakOff(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
function FT_GetStatus(ftHandle: FT_HANDLE; RxBytes, TxBytes, EventStatus: Pointer): FT_STATUS; stdcall;
function FT_SetEventNotification(ftHandle: FT_HANDLE; EventMask: DWORD; pvArgs: Pointer): FT_STATUS; stdcall;
function FT_GetDeviceInfo(ftHandle: FT_HANDLE; DevType, ID, SerNum, Desc, pvDummy: Pointer): FT_STATUS; stdcall;
function FT_SetResetPipeRetryCount(ftHandle: FT_HANDLE; RetryCount: DWORD): FT_STATUS; stdcall;
function FT_StopInTask(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
function FT_RestartInTask(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
function FT_ResetPort(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
function FT_CyclePort(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
function FT_CreateDeviceInfoList(NumDevs: Pointer): FT_STATUS; stdcall;
function FT_GetDeviceInfoList(pFT_Device_Info_List: Pointer; NumDevs: Pointer): FT_STATUS; stdcall;
function FT_GetDeviceInfoDetail(Index: DWORD; Flags, DevType, ID, LocID, SerialNumber, Description, DevHandle: Pointer): FT_STATUS; stdcall;
function FT_GetDriverVersion(ftHandle: FT_HANDLE; DrVersion: Pointer): FT_STATUS; stdcall;
function FT_GetLibraryVersion(LbVersion: Pointer): FT_STATUS; stdcall;

// EEPROM functions
function FT_EE_Read(ftHandle: FT_HANDLE; pEEData: Pointer): FT_STATUS; stdcall;
function FT_EE_Program(ftHandle: FT_HANDLE; pEEData: Pointer): FT_STATUS; stdcall;

// EEPROM primitives - you need an NDA for EEPROM checksum
function FT_ReadEE(ftHandle: FT_HANDLE; WordAddr: DWORD; WordRead: Pointer): FT_STATUS; stdcall;
function FT_WriteEE(ftHandle: FT_HANDLE; WordAddr: DWORD; WordData: WORD): FT_STATUS; stdcall;
function FT_EraseEE(ftHandle: FT_HANDLE): FT_STATUS; stdcall;
function FT_EE_UARead(ftHandle: FT_HANDLE; Data: Pointer; DataLen: DWORD; BytesRead: Pointer): FT_STATUS; stdcall;
function FT_EE_UAWrite(ftHandle: FT_HANDLE; Data: Pointer; DataLen: DWORD): FT_STATUS; stdcall;
function FT_EE_UASize(ftHandle: FT_HANDLE; UASize: Pointer): FT_STATUS; stdcall;

// FT2232C, FT232BM and FT245BM Extended API Functions
function FT_GetLatencyTimer(ftHandle: FT_HANDLE; pucTimer: PUCHAR): FT_STATUS; stdcall;
function FT_SetLatencyTimer(ftHandle: FT_HANDLE; ucTimer: UCHAR): FT_STATUS; stdcall;
function FT_GetBitMode(ftHandle: FT_HANDLE; pucMode: PUCHAR): FT_STATUS;
function FT_SetBitMode(ftHandle: FT_HANDLE; ucMask, ucMode: UCHAR): FT_STATUS; stdcall;
function FT_SetUSBParameters(ftHandle: FT_HANDLE; dwInTransferSize: DWORD; dwOutTransferSize: DWORD): FT_STATUS; stdcall;

function FT_ErrorString(FTStatus: Integer): string;

implementation

function IsFTD2XXLoaded(): Boolean;
begin
   Result := (hD2XXLibrary <> 0);
end;

function D2XX_Initialize(): Boolean;
begin
   hD2XXLibrary := LoadLibrary(FT_DLL_Name);
   if hD2XXLibrary = 0 then begin
      Result := False;
      Exit;
   end;

   // Classic functions
   @fnTFT_GetNumDevicesProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_ListDevices'));
   @fnTFT_ListDevicesProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_ListDevices'));
   @fnTFT_OpenProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_Open'));
   @fnTFT_OpenExProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_OpenEx'));
   @fnTFT_OpenByLocationProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_OpenByLocation'));
   @fnTFT_CloseProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_Close'));
   @fnTFT_ReadProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_Read'));
   @fnTFT_WriteProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_Write'));
   @fnTFT_ResetDeviceProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_ResetDevice'));
   @fnTFT_SetBaudRateProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetBaudRate'));
   @fnTFT_SetDivisorProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetDivisor'));
   @fnTFT_SetDataCharacteristicsProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetDataCharacteristics'));
   @fnTFT_SetFlowControlProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetFlowControl'));
   @fnTFT_SetDtrProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetDtr'));
   @fnTFT_ClrDtrProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_ClrDtr'));
   @fnTFT_SetRtsProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetRts'));
   @fnTFT_ClrRtsProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_ClrRts'));
   @fnTFT_GetModemStatusProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_GetModemStatus'));
   @fnTFT_SetCharsProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetChars'));
   @fnTFT_PurgeProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_Purge'));
   @fnTFT_SetTimeoutsProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetTimeouts'));
   @fnTFT_GetQueueStatusProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_GetQueueStatus'));
   @fnTFT_SetBreakOnProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetBreakOn'));
   @fnTFT_SetBreakOffProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetBreakOff'));
   @fnTFT_GetStatusProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_GetStatus'));
   @fnTFT_SetEventNotificationProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetEventNotification'));
   @fnTFT_GetDeviceInfoProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_GetDeviceInfo'));
   @fnTFT_SetResetPipeRetryCountProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetResetPipeRetryCount'));
   @fnTFT_StopInTaskProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_StopInTask'));
   @fnTFT_RestartInTaskProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_RestartInTask'));
   @fnTFT_ResetPortProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_ResetPort'));
   @fnTFT_CyclePortProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_CyclePort'));
   @fnTFT_CreateDeviceInfoListProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_CreateDeviceInfoList'));
   @fnTFT_GetDeviceInfoListProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_GetDeviceInfoList'));
   @fnTFT_GetDeviceInfoDetailProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_GetDeviceInfoDetail'));
   @fnTFT_GetDriverVersionProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_GetDriverVersion'));
   @fnTFT_GetLibraryVersionProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_GetLibraryVersion'));

   // EEPROM s
   @fnTFT_EE_ReadProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_EE_Read'));
   @fnTFT_EE_ProgramProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_EE_Program'));

   // EEPROM primitives - you need an NDA for EEPROM checksum
   @fnTFT_ReadEEProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_ReadEE'));
   @fnTFT_WriteEEProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_WriteEE'));
   @fnTFT_EraseEEProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_EraseEE'));
   @fnTFT_EE_UAReadProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_EE_UARead'));
   @fnTFT_EE_UAWriteProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_EE_UAWrite'));
   @fnTFT_EE_UASizeProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_EE_UASize'));

   // FT2232C, FT232BM and FT245BM Extended API s
   @fnTFT_GetLatencyTimerProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_GetLatencyTimer'));
   @fnTFT_SetLatencyTimerProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetLatencyTimer'));
   @fnTFT_GetBitModeProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_GetBitMode'));
   @fnTFT_SetBitModeProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetBitMode'));
   @fnTFT_SetUSBParametersProc := GetProcAddress(hD2XXLibrary, PAnsiChar('FT_SetUSBParameters'));

   Result := True;
end;

procedure D2XX_Terminate();
begin
   if hD2XXLibrary <> 0 then begin
      FreeLibrary(hD2XXLibrary);
   end;
end;

// Classic functions
function FT_GetNumDevices(pvArg1: Pointer; pvArg2: Pointer; dwFlags: DWORD): FT_STATUS;
begin
   Result := fnTFT_GetNumDevicesProc(pvArg1, pvArg2, dwFlags);
end;

function FT_ListDevices(pvArg1: DWORD; pvArg2: Pointer; dwFlags: DWORD): FT_STATUS;
begin
   Result := fnTFT_ListDevicesProc(pvArg1, pvArg2, dwFlags);
end;

function FT_Open(Index: Integer; ftHandle: PFT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_OpenProc(Index, ftHandle);
end;

function FT_OpenEx(pvArg1: Pointer; dwFlags: DWORD; ftHandle: PFT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_OpenExProc(pvArg1, dwFlags, ftHandle);
end;

function FT_OpenByLocation(pvArg1: DWORD; dwFlags: DWORD; ftHandle: PFT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_OpenByLocationProc(pvArg1, dwFlags, ftHandle);
end;

function FT_Close(ftHandle: FT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_CloseProc(ftHandle);
end;

function FT_Read(ftHandle: FT_HANDLE; lpBuffer: LPVOID; dwBytesToRead: DWORD; lpdwBytesReturned: LPDWORD): FT_STATUS;
begin
   Result := fnTFT_ReadProc(ftHandle, lpBuffer, dwBytesToRead, lpdwBytesReturned);
end;

function FT_Write(ftHandle: FT_HANDLE; lpBuffer: LPVOID; dwBytesToWrite: DWORD; lpdwBytesWritten: LPDWORD): FT_STATUS;
begin
   Result := fnTFT_WriteProc(ftHandle, lpBuffer, dwBytesToWrite, lpdwBytesWritten);
end;

function FT_ResetDevice(ftHandle: FT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_ResetDeviceProc(ftHandle);
end;

function FT_SetBaudRate(ftHandle: FT_HANDLE; BaudRate: DWORD): FT_STATUS;
begin
   Result := fnTFT_SetBaudRateProc(ftHandle, BaudRate);
end;

function FT_SetDivisor(ftHandle: FT_HANDLE; Divisor: DWORD): FT_STATUS;
begin
   Result := fnTFT_SetDivisorProc(ftHandle, Divisor);
end;

function FT_SetDataCharacteristics(ftHandle: FT_HANDLE; WordLength, StopBits, Parity: BYTE): FT_STATUS;
begin
   Result := fnTFT_SetDataCharacteristicsProc(ftHandle, WordLength, StopBits, Parity);
end;

function FT_SetFlowControl(ftHandle: FT_HANDLE; FlowControl: WORD; XonChar, XoffChar: BYTE): FT_STATUS;
begin
   Result := fnTFT_SetFlowControlProc(ftHandle, FlowControl, XonChar, XoffChar);
end;

function FT_SetDtr(ftHandle: FT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_SetDtrProc(ftHandle);
end;

function FT_ClrDtr(ftHandle: FT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_ClrDtrProc(ftHandle);
end;

function FT_SetRts(ftHandle: FT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_SetRtsProc(ftHandle);
end;

function FT_ClrRts(ftHandle: FT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_ClrRtsProc(ftHandle);
end;

function FT_GetModemStatus(ftHandle: FT_HANDLE; ModemStatus: Pointer): FT_STATUS;
begin
   Result := fnTFT_GetModemStatusProc(ftHandle, ModemStatus);
end;

function FT_SetChars(ftHandle: FT_HANDLE; EventChar, EventCharEnabled, ErrorChar, ErrorCharEnabled: BYTE): FT_STATUS;
begin
   Result := fnTFT_SetCharsProc(ftHandle, EventChar, EventCharEnabled, ErrorChar, ErrorCharEnabled);
end;

function FT_Purge(ftHandle: FT_HANDLE; Mask: DWORD): FT_STATUS;
begin
   Result := fnTFT_PurgeProc(ftHandle, Mask);
end;

function FT_SetTimeouts(ftHandle: FT_HANDLE; ReadTimeOut, WriteTimeOut: DWORD): FT_STATUS;
begin
   Result := fnTFT_SetTimeoutsProc(ftHandle, ReadTimeOut, WriteTimeOut);
end;

function FT_GetQueueStatus(ftHandle: FT_HANDLE; RxBytes: Pointer): FT_STATUS;
begin
   Result := fnTFT_GetQueueStatusProc(ftHandle, RxBytes);
end;

function FT_SetBreakOn(ftHandle: FT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_SetBreakOnProc(ftHandle);
end;

function FT_SetBreakOff(ftHandle: FT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_SetBreakOffProc(ftHandle);
end;

function FT_GetStatus(ftHandle: FT_HANDLE; RxBytes, TxBytes, EventStatus: Pointer): FT_STATUS;
begin
   Result := fnTFT_GetStatusProc(ftHandle, RxBytes, TxBytes, EventStatus);
end;

function FT_SetEventNotification(ftHandle: FT_HANDLE; EventMask: DWORD; pvArgs: Pointer): FT_STATUS;
begin
   Result := fnTFT_SetEventNotificationProc(ftHandle, EventMask, pvArgs);
end;

function FT_GetDeviceInfo(ftHandle: FT_HANDLE; DevType, ID, SerNum, Desc, pvDummy: Pointer): FT_STATUS;
begin
   Result := fnTFT_GetDeviceInfoProc(ftHandle, DevType, ID, SerNum, Desc, pvDummy);
end;

function FT_SetResetPipeRetryCount(ftHandle: FT_HANDLE; RetryCount: DWORD): FT_STATUS;
begin
   Result := fnTFT_SetResetPipeRetryCountProc(ftHandle, RetryCount);
end;

function FT_StopInTask(ftHandle: FT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_StopInTaskProc(ftHandle);
end;

function FT_RestartInTask(ftHandle: FT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_RestartInTaskProc(ftHandle);
end;

function FT_ResetPort(ftHandle: FT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_ResetPortProc(ftHandle);
end;

function FT_CyclePort(ftHandle: FT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_CyclePortProc(ftHandle);
end;

function FT_CreateDeviceInfoList(NumDevs: Pointer): FT_STATUS;
begin
   Result := fnTFT_CreateDeviceInfoListProc(NumDevs);
end;

function FT_GetDeviceInfoList(pFT_Device_Info_List: Pointer; NumDevs: Pointer): FT_STATUS;
begin
   Result := fnTFT_GetDeviceInfoListProc(pFT_Device_Info_List, NumDevs);
end;

function FT_GetDeviceInfoDetail(Index: DWORD; Flags, DevType, ID, LocID, SerialNumber, Description, DevHandle: Pointer): FT_STATUS;
begin
   Result := fnTFT_GetDeviceInfoDetailProc(Index, Flags, DevType, ID, LocID, SerialNumber, Description, DevHandle);
end;

function FT_GetDriverVersion(ftHandle: FT_HANDLE; DrVersion: Pointer): FT_STATUS;
begin
   Result := fnTFT_GetDriverVersionProc(ftHandle, DrVersion);
end;

function FT_GetLibraryVersion(LbVersion: Pointer): FT_STATUS;
begin
   Result := fnTFT_GetLibraryVersionProc(LbVersion);
end;

// EEPROM functions
function FT_EE_Read(ftHandle: FT_HANDLE; pEEData: Pointer): FT_STATUS;
begin
   Result := fnTFT_EE_ReadProc(ftHandle, pEEData);
end;

function FT_EE_Program(ftHandle: FT_HANDLE; pEEData: Pointer): FT_STATUS;
begin
   Result := fnTFT_EE_ProgramProc(ftHandle, pEEData);
end;

// EEPROM primitives - you need an NDA for EEPROM checksum
function FT_ReadEE(ftHandle: FT_HANDLE; WordAddr: DWORD; WordRead: Pointer): FT_STATUS;
begin
   Result := fnTFT_ReadEEProc(ftHandle, WordAddr, WordRead);
end;

function FT_WriteEE(ftHandle: FT_HANDLE; WordAddr: DWORD; WordData: WORD): FT_STATUS;
begin
   Result := fnTFT_WriteEEProc(ftHandle, WordAddr, WordData);
end;

function FT_EraseEE(ftHandle: FT_HANDLE): FT_STATUS;
begin
   Result := fnTFT_EraseEEProc(ftHandle);
end;

function FT_EE_UARead(ftHandle: FT_HANDLE; Data: Pointer; DataLen: DWORD; BytesRead: Pointer): FT_STATUS;
begin
   Result := fnTFT_EE_UAReadProc(ftHandle, Data, DataLen, BytesRead);
end;

function FT_EE_UAWrite(ftHandle: FT_HANDLE; Data: Pointer; DataLen: DWORD): FT_STATUS;
begin
   Result := fnTFT_EE_UAWriteProc(ftHandle, Data, DataLen);
end;

function FT_EE_UASize(ftHandle: FT_HANDLE; UASize: Pointer): FT_STATUS;
begin
   Result := fnTFT_EE_UASizeProc(ftHandle, UASize);
end;

// FT2232C, FT232BM and FT245BM Extended API Functions
function FT_GetLatencyTimer(ftHandle: FT_HANDLE; pucTimer: PUCHAR): FT_STATUS;
begin
   Result := fnTFT_GetLatencyTimerProc(ftHandle, pucTimer);
end;

function FT_SetLatencyTimer(ftHandle: FT_HANDLE; ucTimer: UCHAR): FT_STATUS;
begin
   Result := fnTFT_SetLatencyTimerProc(ftHandle, ucTimer);
end;

function FT_GetBitMode(ftHandle: FT_HANDLE; pucMode: PUCHAR): FT_STATUS;
begin
   Result := fnTFT_GetBitModeProc(ftHandle, pucMode);
end;

function FT_SetBitMode(ftHandle: FT_HANDLE; ucMask, ucMode: UCHAR): FT_STATUS;
begin
   Result := fnTFT_SetBitModeProc(ftHandle, ucMask, ucMode);
end;

function FT_SetUSBParameters(ftHandle: FT_HANDLE; dwInTransferSize: DWORD; dwOutTransferSize: DWORD): FT_STATUS;
begin
   Result := fnTFT_SetUSBParametersProc(ftHandle, dwInTransferSize, dwOutTransferSize);
end;

function FT_ErrorString(FTStatus: Integer): string;
var
   Str: string;
begin
   Case FTStatus of
      FT_OK:
         Str := '';
      FT_INVALID_HANDLE:
         Str := 'Invalid handle';
      FT_DEVICE_NOT_FOUND:
         Str := 'Device not found';
      FT_DEVICE_NOT_OPENED:
         Str := 'Device not opened';
      FT_IO_ERROR:
         Str := 'General IO error';
      FT_INSUFFICIENT_RESOURCES:
         Str := 'Insufficient resources';
      FT_INVALID_PARAMETER:
         Str := 'Invalid parameter';
      FT_INVALID_BAUD_RATE:
         Str := 'Invalid baud rate';
      FT_DEVICE_NOT_OPENED_FOR_ERASE:
         Str := 'Device not opened for erase';
      FT_DEVICE_NOT_OPENED_FOR_WRITE:
         Str := 'Device not opened for write';
      FT_FAILED_TO_WRITE_DEVICE:
         Str := 'Failed to write';
      FT_EEPROM_READ_FAILED:
         Str := 'EEPROM read failed';
      FT_EEPROM_WRITE_FAILED:
         Str := 'EEPROM write failed';
      FT_EEPROM_ERASE_FAILED:
         Str := 'EEPROM erase failed';
      FT_EEPROM_NOT_PRESENT:
         Str := 'EEPROM not present';
      FT_EEPROM_NOT_PROGRAMMED:
         Str := 'EEPROM not programmed';
      FT_INVALID_ARGS:
         Str := 'Invalid arguments';
      FT_OTHER_ERROR:
         Str := 'Other error';
   end;

   Result := Str;
end;

initialization
   D2XX_Initialize();

finalization
   D2XX_Terminate();

end.
