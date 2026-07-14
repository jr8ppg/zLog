unit SetupApi;

interface

uses
  Winapi.Windows;

const
  DIGCF_DEFAULT         = $00000001;
  DIGCF_PRESENT         = $00000002;
  DIGCF_ALLCLASSES      = $00000004;
  DIGCF_PROFILE         = $00000008;
  DIGCF_DEVICEINTERFACE = $00000010;

  SPDRP_HARDWAREID      = $00000001;

  MAX_DEVICE_ID_LEN     = 200;

type
  HDEVINFO = THandle;

  PSP_DEVINFO_DATA = ^SP_DEVINFO_DATA;
  SP_DEVINFO_DATA = record
    cbSize: DWORD;
    ClassGuid: TGUID;
    DevInst: DWORD;
    Reserved: ULONG_PTR;
  end;

function SetupDiGetClassDevs(
  ClassGuid: PGUID;
  Enumerator: PChar;
  hwndParent: HWND;
  Flags: DWORD): HDEVINFO; stdcall;

function SetupDiEnumDeviceInfo(
  DeviceInfoSet: HDEVINFO;
  MemberIndex: DWORD;
  var DeviceInfoData: SP_DEVINFO_DATA): BOOL; stdcall;

function SetupDiGetDeviceRegistryProperty(
  DeviceInfoSet: HDEVINFO;
  var DeviceInfoData: SP_DEVINFO_DATA;
  Property_: DWORD;
  PropertyRegDataType: PDWORD;
  PropertyBuffer: PBYTE;
  PropertyBufferSize: DWORD;
  RequiredSize: PDWORD): BOOL; stdcall;

function SetupDiGetDeviceInstanceId(
  DeviceInfoSet: HDEVINFO;
  var DeviceInfoData: SP_DEVINFO_DATA;
  DeviceInstanceId: PChar;
  DeviceInstanceIdSize: DWORD;
  RequiredSize: PDWORD): BOOL; stdcall;

function SetupDiDestroyDeviceInfoList(
  DeviceInfoSet: HDEVINFO): BOOL; stdcall;

implementation

const
  setupapidll = 'setupapi.dll';

function SetupDiGetClassDevs; external setupapidll name 'SetupDiGetClassDevsW';
function SetupDiEnumDeviceInfo; external setupapidll name 'SetupDiEnumDeviceInfo';
function SetupDiGetDeviceRegistryProperty; external setupapidll name 'SetupDiGetDeviceRegistryPropertyW';
function SetupDiGetDeviceInstanceId; external setupapidll name 'SetupDiGetDeviceInstanceIdW';
function SetupDiDestroyDeviceInfoList; external setupapidll name 'SetupDiDestroyDeviceInfoList';

end.

