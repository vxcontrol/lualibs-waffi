require( 'waffi.headers.windows' )
local ffi = require( 'ffi' )
ffi.cdef [[
  typedef struct WTS_PROCESS_INFOA {
    DWORD SessionId;
    DWORD ProcessId;
    LPSTR pProcessName;
    PSID pUserSid;
  } WTS_PROCESS_INFOA;
  typedef WTS_PROCESS_INFOA *PWTS_PROCESS_INFOA; //Pointer
  typedef struct WTS_PROCESS_INFOW {
    DWORD SessionId;
    DWORD ProcessId;
    LPWSTR pProcessName;
    PSID pUserSid;
  } WTS_PROCESS_INFOW;
  typedef WTS_PROCESS_INFOW *PWTS_PROCESS_INFOW; //Pointer
  typedef UINT WTS_CONNECTSTATE_CLASS; //Alias
  static const WTS_CONNECTSTATE_CLASS WTSActive = 0;
  static const WTS_CONNECTSTATE_CLASS WTSConnected = 1;
  static const WTS_CONNECTSTATE_CLASS WTSConnectQuery = 2;
  static const WTS_CONNECTSTATE_CLASS WTSShadow = 3;
  static const WTS_CONNECTSTATE_CLASS WTSDisconnected = 4;
  static const WTS_CONNECTSTATE_CLASS WTSIdle = 5;
  static const WTS_CONNECTSTATE_CLASS WTSListen = 6;
  static const WTS_CONNECTSTATE_CLASS WTSReset = 7;
  static const WTS_CONNECTSTATE_CLASS WTSDown = 8;
  static const WTS_CONNECTSTATE_CLASS WTSInit = 9;
  typedef struct WTS_SESSION_INFOA {
    DWORD SessionId;
    LPSTR pWinStationName;
    WTS_CONNECTSTATE_CLASS State;
  } WTS_SESSION_INFOA;
  typedef WTS_SESSION_INFOA *PWTS_SESSION_INFOA; //Pointer
  typedef struct WTS_SESSION_INFOW {
    DWORD SessionId;
    LPWSTR pWinStationName;
    WTS_CONNECTSTATE_CLASS State;
  } WTS_SESSION_INFOW;
  typedef WTS_SESSION_INFOW *PWTS_SESSION_INFOW; //Pointer
  typedef UINT WTS_INFO_CLASS; //Alias
  static const WTS_INFO_CLASS WTSInitialProgram = 0;
  static const WTS_INFO_CLASS WTSApplicationName = 1;
  static const WTS_INFO_CLASS WTSWorkingDirectory = 2;
  static const WTS_INFO_CLASS WTSOEMId = 3;
  static const WTS_INFO_CLASS WTSSessionId = 4;
  static const WTS_INFO_CLASS WTSUserName = 5;
  static const WTS_INFO_CLASS WTSWinStationName = 6;
  static const WTS_INFO_CLASS WTSDomainName = 7;
  static const WTS_INFO_CLASS WTSConnectState = 8;
  static const WTS_INFO_CLASS WTSClientBuildNumber = 9;
  static const WTS_INFO_CLASS WTSClientName = 10;
  static const WTS_INFO_CLASS WTSClientDirectory = 11;
  static const WTS_INFO_CLASS WTSClientProductId = 12;
  static const WTS_INFO_CLASS WTSClientHardwareId = 13;
  static const WTS_INFO_CLASS WTSClientAddress = 14;
  static const WTS_INFO_CLASS WTSClientDisplay = 15;
  static const WTS_INFO_CLASS WTSClientProtocolType = 16;
  static const WTS_INFO_CLASS WTSIdleTime = 17;
  static const WTS_INFO_CLASS WTSLogonTime = 18;
  static const WTS_INFO_CLASS WTSIncomingBytes = 19;
  static const WTS_INFO_CLASS WTSOutgoingBytes = 20;
  static const WTS_INFO_CLASS WTSIncomingFrames = 21;
  static const WTS_INFO_CLASS WTSOutgoingFrames = 22;
  typedef UINT WTS_CONFIG_CLASS; //Alias
  static const WTS_CONFIG_CLASS WTSUserConfigInitialProgram = 0;
  static const WTS_CONFIG_CLASS WTSUserConfigWorkingDirectory = 1;
  static const WTS_CONFIG_CLASS WTSUserConfigfInheritInitialProgram = 2;
  static const WTS_CONFIG_CLASS WTSUserConfigfAllowLogonTerminalServer = 3;
  static const WTS_CONFIG_CLASS WTSUserConfigTimeoutSettingsConnections = 4;
  static const WTS_CONFIG_CLASS WTSUserConfigTimeoutSettingsDisconnections = 5;
  static const WTS_CONFIG_CLASS WTSUserConfigTimeoutSettingsIdle = 6;
  static const WTS_CONFIG_CLASS WTSUserConfigfDeviceClientDrives = 7;
  static const WTS_CONFIG_CLASS WTSUserConfigfDeviceClientPrinters = 8;
  static const WTS_CONFIG_CLASS WTSUserConfigfDeviceClientDefaultPrinter = 9;
  static const WTS_CONFIG_CLASS WTSUserConfigBrokenTimeoutSettings = 10;
  static const WTS_CONFIG_CLASS WTSUserConfigReconnectSettings = 11;
  static const WTS_CONFIG_CLASS WTSUserConfigModemCallbackSettings = 12;
  static const WTS_CONFIG_CLASS WTSUserConfigModemCallbackPhoneNumber = 13;
  static const WTS_CONFIG_CLASS WTSUserConfigShadowingSettings = 14;
  static const WTS_CONFIG_CLASS WTSUserConfigTerminalServerProfilePath = 15;
  static const WTS_CONFIG_CLASS WTSUserConfigTerminalServerHomeDir = 16;
  static const WTS_CONFIG_CLASS WTSUserConfigTerminalServerHomeDirDrive = 17;
  static const WTS_CONFIG_CLASS WTSUserConfigfTerminalServerRemoteHomeDir = 18;
  typedef UINT WTS_VIRTUAL_CLASS; //Alias
  static const WTS_VIRTUAL_CLASS WTSVirtualClientData = 0;
  static const WTS_VIRTUAL_CLASS WTSVirtualFileHandle = 1;
  typedef DWORD WINAPI_ConsoleNotificationFlags; //Alias
  static const WINAPI_ConsoleNotificationFlags NOTIFY_FOR_ALL_SESSIONS = 1;
  static const WINAPI_ConsoleNotificationFlags NOTIFY_FOR_THIS_SESSION = 0;
  typedef HANDLE WINAPI_WtsServerHandle; //Alias
  typedef HANDLE_ WINAPI_WtsServerHandle_; //Alias max ffi ptr
  static const WINAPI_WtsServerHandle_ WTS_CURRENT_SERVER_HANDLE = 0;
  typedef DWORD WINAPI_WtsEventFlags; //Alias
  void   WTSCloseServer(                     WINAPI_WtsServerHandle hServer);
  BOOL   WTSConnectSessionA(                 ULONG LogonId, ULONG TargetLogonId, PSTR pPassword, BOOL bWait);
  BOOL   WTSConnectSessionW(                 ULONG LogonId, ULONG TargetLogonId, PWSTR pPassword, BOOL bWait);
  BOOL   WTSDisconnectSession(               WINAPI_WtsServerHandle hServer, DWORD SessionId, BOOL bWait);
  BOOL   WTSEnumerateProcessesA(             WINAPI_WtsServerHandle hServer, DWORD Reserved, DWORD Version, PWTS_PROCESS_INFOA* ppProcessInfo, DWORD* pCount);
  BOOL   WTSEnumerateProcessesW(             WINAPI_WtsServerHandle hServer, DWORD Reserved, DWORD Version, PWTS_PROCESS_INFOW* ppProcessInfo, DWORD* pCount);
  BOOL   WTSEnumerateSessionsA(              WINAPI_WtsServerHandle hServer, DWORD Reserved, DWORD Version, PWTS_SESSION_INFOA* ppSessionInfo, DWORD* pCount);
  BOOL   WTSEnumerateSessionsW(              WINAPI_WtsServerHandle hServer, DWORD Reserved, DWORD Version, PWTS_SESSION_INFOW* ppSessionInfo, DWORD* pCount);
  void   WTSFreeMemory(                      PVOID pMemory);
  BOOL   WTSLogoffSession(                   WINAPI_WtsServerHandle hServer, DWORD SessionId, BOOL bWait);
  HANDLE WTSOpenServerA(                     LPSTR pServerName);
  HANDLE WTSOpenServerW(                     LPWSTR pServerName);
  BOOL   WTSQuerySessionInformationA(        WINAPI_WtsServerHandle hServer, DWORD SessionId, WTS_INFO_CLASS WTSInfoClass, LPSTR* ppBuffer, DWORD* pBytesReturned);
  BOOL   WTSQuerySessionInformationW(        WINAPI_WtsServerHandle hServer, DWORD SessionId, WTS_INFO_CLASS WTSInfoClass, LPWSTR* ppBuffer, DWORD* pBytesReturned);
  BOOL   WTSQueryUserConfigA(                LPSTR pServerName, LPSTR pUserName, WTS_CONFIG_CLASS WTSConfigClass, LPSTR* ppBuffer, DWORD* pBytesReturned);
  BOOL   WTSQueryUserConfigW(                LPWSTR pServerName, LPWSTR pUserName, WTS_CONFIG_CLASS WTSConfigClass, LPWSTR* ppBuffer, DWORD* pBytesReturned);
  BOOL   WTSQueryUserToken(                  ULONG SessionId, PHANDLE phToken);
  BOOL   WTSRegisterSessionNotification(     HWND hWnd, WINAPI_ConsoleNotificationFlags dwFlags);
  BOOL   WTSRegisterSessionNotificationEx(   WINAPI_WtsServerHandle hServer, HWND hWnd, WINAPI_ConsoleNotificationFlags dwFlags);
  BOOL   WTSSendMessageA(                    WINAPI_WtsServerHandle hServer, DWORD SessionId, LPSTR pTitle, DWORD TitleLength, LPSTR pMessage, DWORD MessageLength, DWORD Style, DWORD Timeout, DWORD* pResponse, BOOL bWait);
  BOOL   WTSSendMessageW(                    WINAPI_WtsServerHandle hServer, DWORD SessionId, LPWSTR pTitle, DWORD TitleLength, LPWSTR pMessage, DWORD MessageLength, DWORD Style, DWORD Timeout, DWORD* pResponse, BOOL bWait);
  BOOL   WTSSetUserConfigA(                  LPSTR pServerName, LPSTR pUserName, WTS_CONFIG_CLASS WTSConfigClass, LPSTR pBuffer, DWORD DataLength);
  BOOL   WTSSetUserConfigW(                  LPWSTR pServerName, LPWSTR pUserName, WTS_CONFIG_CLASS WTSConfigClass, LPWSTR pBuffer, DWORD DataLength);
  BOOL   WTSShutdownSystem(                  WINAPI_WtsServerHandle hServer, DWORD ShutdownFlag);
  BOOL   WTSStartRemoteControlSessionA(      LPSTR pTargetServerName, ULONG TargetLogonId, BYTE HotkeyVk, USHORT HotkeyModifiers);
  BOOL   WTSStartRemoteControlSessionW(      LPWSTR pTargetServerName, ULONG TargetLogonId, BYTE HotkeyVk, USHORT HotkeyModifiers);
  BOOL   WTSStopRemoteControlSession(        ULONG LogonId);
  BOOL   WTSTerminateProcess(                WINAPI_WtsServerHandle hServer, DWORD ProcessId, DWORD ExitCode);
  BOOL   WTSUnRegisterSessionNotification(   HWND hWnd);
  BOOL   WTSUnRegisterSessionNotificationEx( WINAPI_WtsServerHandle hServer, HWND hWnd);
  BOOL   WTSVirtualChannelClose(             HANDLE hChannelHandle);
  HANDLE WTSVirtualChannelOpen(              WINAPI_WtsServerHandle hServer, DWORD SessionId, LPSTR pVirtualName);
  BOOL   WTSVirtualChannelPurgeInput(        HANDLE hChannelHandle);
  BOOL   WTSVirtualChannelPurgeOutput(       HANDLE hChannelHandle);
  BOOL   WTSVirtualChannelQuery(             HANDLE hChannelHandle, WTS_VIRTUAL_CLASS WtsVirtualClass, PVOID* ppBuffer, DWORD* pBytesReturned);
  BOOL   WTSVirtualChannelRead(              HANDLE hChannelHandle, ULONG TimeOut, LPVOID Buffer, ULONG BufferSize, PULONG pBytesRead);
  BOOL   WTSVirtualChannelWrite(             HANDLE hChannelHandle, LPVOID Buffer, ULONG Length, PULONG pBytesWritten);
  BOOL   WTSWaitSystemEvent(                 WINAPI_WtsServerHandle hServer, WINAPI_WtsEventFlags EventMask, WINAPI_WtsEventFlags* pEventFlags);
]]
return ffi.load( 'Wtsapi32.dll' )
