require( 'waffi.headers.windows' )
require( 'waffi.headers.setup' )
local ffi = require( 'ffi' )
ffi.cdef [[
  BOOL InstallNewDevice(                  HWND hwndParent, LPGUID ClassGuid, PDWORD pReboot);
  BOOL DiInstallDevice(                   HWND hwndParent, HDEVINFO DeviceInfoSet, PSP_DEVINFO_DATA DeviceInfoData, PSP_DRVINFO_DATA_W DriverInfoData, DWORD Flags, PBOOL NeedReboot);
  BOOL DiInstallDriverA(                  HWND hwndParent, LPCSTR FullInfPath, DWORD Flags, PBOOL NeedReboot);
  BOOL DiInstallDriverW(                  HWND hwndParent, LPCWSTR FullInfPath, DWORD Flags, PBOOL NeedReboot);
  BOOL DiRollbackDriver(                  HDEVINFO DeviceInfoSet, PSP_DEVINFO_DATA DeviceInfoData, HWND hwndParent, DWORD Flags, PBOOL NeedReboot);
  BOOL DiShowUpdateDevice(                HWND hwndParent, HDEVINFO DeviceInfoSet, PSP_DEVINFO_DATA DeviceInfoData, DWORD Flags, PBOOL NeedReboot);
  BOOL DiUninstallDevice(                 HWND hwndParent, HDEVINFO DeviceInfoSet, PSP_DEVINFO_DATA DeviceInfoData, DWORD Flags, PBOOL NeedReboot);
  BOOL UpdateDriverForPlugAndPlayDevicesA(HWND hwndParent, LPCSTR HardwareId, LPCSTR FullInfPath, DWORD InstallFlags, PBOOL bRebootRequired);
  BOOL UpdateDriverForPlugAndPlayDevicesW(HWND hwndParent, LPCWSTR HardwareId, LPCWSTR FullInfPath, DWORD InstallFlags, PBOOL bRebootRequired);
  BOOL InstallSelectedDriver(             HWND hwndParent, HDEVINFO DeviceInfoSet, LPCWSTR Reserved, BOOL Backup, PDWORD bReboot);
]]
return ffi.load( 'Newdev.dll' )
