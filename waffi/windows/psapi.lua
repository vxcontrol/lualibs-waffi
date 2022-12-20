require( 'waffi.headers.windows' )
require( 'waffi.headers.processes' )
local ffi = require( 'ffi' )
ffi.cdef [[
  BOOL  EmptyWorkingSet(             WINAPI_ProcessHandle hProcess);
  BOOL  EnumDeviceDrivers(           LPVOID* lpImageBase, DWORD cb, LPDWORD lpcbNeeded);
  BOOL  EnumPageFilesA(              PENUM_PAGE_CALLBACK pCallbackRoutine, LPVOID lpContext);
  BOOL  EnumPageFilesW(              PENUM_PAGE_CALLBACK pCallbackRoutine, LPVOID lpContext);
  BOOL  EnumProcesses(               DWORD* pProcessIds, DWORD cb, DWORD* pBytesReturned);
  BOOL  EnumProcessModules(          WINAPI_ProcessHandle hProcess, HMODULE* lphModule, DWORD cb, LPDWORD lpcbNeeded);
  BOOL  EnumProcessModulesEx(        WINAPI_ProcessHandle hProcess, HMODULE* lphModule, DWORD cb, LPDWORD lpcbNeeded, DWORD dwFilterFlag);
  DWORD GetDeviceDriverBaseNameA(    LPVOID ImageBase, LPSTR lpBaseName, DWORD nSize);
  DWORD GetDeviceDriverFileNameW(    LPVOID ImageBase, LPWSTR lpFilename, DWORD nSize);
  DWORD GetMappedFileNameA(          WINAPI_ProcessHandle hProcess, LPVOID lpv, LPSTR lpFilename, DWORD nSize);
  DWORD GetMappedFileNameW(          WINAPI_ProcessHandle hProcess, LPVOID lpv, LPWSTR lpFilename, DWORD nSize);
  DWORD GetModuleBaseNameA(          WINAPI_ProcessHandle hProcess, HMODULE hModule, LPSTR lpBaseName, DWORD nSize);
  DWORD GetModuleBaseNameW(          WINAPI_ProcessHandle hProcess, HMODULE hModule, LPWSTR lpBaseName, DWORD nSize);
  DWORD GetModuleFileNameExA(        WINAPI_ProcessHandle hProcess, HMODULE hModule, LPSTR lpFilename, DWORD nSize);
  DWORD GetModuleFileNameExW(        WINAPI_ProcessHandle hProcess, HMODULE hModule, LPWSTR lpFilename, DWORD nSize);
  BOOL  GetModuleInformation(        WINAPI_ProcessHandle hProcess, HMODULE hModule, LPMODULEINFO lpmodinfo, DWORD cb);
  BOOL  GetPerformanceInfo(          PPERFORMANCE_INFORMATION pPerformanceInformation, DWORD cb);
  DWORD GetProcessImageFileNameA(    WINAPI_ProcessHandle hProcess, LPSTR lpImageFileName, DWORD nSize);
  DWORD GetProcessImageFileNameW(    WINAPI_ProcessHandle hProcess, LPWSTR lpImageFileName, DWORD nSize);
  BOOL  GetProcessMemoryInfo(        HANDLE Process, PPROCESS_MEMORY_COUNTERS ppsmemCounters, DWORD cb);
  BOOL  GetWsChanges(                WINAPI_ProcessHandle hProcess, PPSAPI_WS_WATCH_INFORMATION lpWatchInfo, DWORD cb);
  BOOL  GetWsChangesEx(              WINAPI_ProcessHandle hProcess, PPSAPI_WS_WATCH_INFORMATION_EX lpWatchInfoEx, DWORD cb);
  BOOL  InitializeProcessForWsWatch( WINAPI_ProcessHandle hProcess);
  BOOL  QueryWorkingSet(             WINAPI_ProcessHandle hProcess, PVOID pv, DWORD cb);
  BOOL  QueryWorkingSetEx(           WINAPI_ProcessHandle hProcess, PVOID pv, DWORD cb);
]]
return ffi.load( 'Psapi.dll' )
