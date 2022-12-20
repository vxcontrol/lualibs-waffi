require( 'waffi.headers.windows' )
local ffi = require( 'ffi' )
ffi.cdef [[
  typedef LPVOID PFN_SC_NOTIFY_CALLBACK; //Alias
  typedef HANDLE SERVICE_STATUS_HANDLE; //Alias
  typedef HANDLE SC_HANDLE; //Alias
  typedef LPVOID SC_LOCK; //Alias
  typedef UINT SC_STATUS_TYPE; //Alias
  static const SC_STATUS_TYPE SC_STATUS_PROCESS_INFO = 0;
  typedef DWORD WINAPI_ServiceType; //Alias
  static const WINAPI_ServiceType SERVICE_KERNEL_DRIVER = 0x00000001;
  static const WINAPI_ServiceType SERVICE_FILE_SYSTEM_DRIVER = 0x00000002;
  static const WINAPI_ServiceType SERVICE_WIN32_OWN_PROCESS = 0x00000010;
  static const WINAPI_ServiceType SERVICE_WIN32_SHARE_PROCESS = 0x00000020;
  typedef DWORD WINAPI_ServiceState; //Alias
  static const WINAPI_ServiceState SERVICE_ACTIVE = 0x00000001;
  static const WINAPI_ServiceState SERVICE_INACTIVE = 0x00000002;
  static const WINAPI_ServiceState SERVICE_STATE_ALL = 0x00000003;
  typedef DWORD WINAPI_ServiceCurrentState; //Alias
  static const WINAPI_ServiceCurrentState SERVICE_STOPPED = 0x00000001;
  static const WINAPI_ServiceCurrentState SERVICE_START_PENDING = 0x00000002;
  static const WINAPI_ServiceCurrentState SERVICE_STOP_PENDING = 0x00000003;
  static const WINAPI_ServiceCurrentState SERVICE_RUNNING = 0x00000004;
  static const WINAPI_ServiceCurrentState SERVICE_CONTINUE_PENDING = 0x00000005;
  static const WINAPI_ServiceCurrentState SERVICE_PAUSE_PENDING = 0x00000006;
  static const WINAPI_ServiceCurrentState SERVICE_PAUSED = 0x00000007;
  typedef DWORD WINAPI_ServiceStartType; //Alias
  static const WINAPI_ServiceStartType SERVICE_BOOT_START = 0x00000000;
  static const WINAPI_ServiceStartType SERVICE_SYSTEM_START = 0x00000001;
  static const WINAPI_ServiceStartType SERVICE_AUTO_START = 0x00000002;
  static const WINAPI_ServiceStartType SERVICE_DEMAND_START = 0x00000003;
  static const WINAPI_ServiceStartType SERVICE_DISABLED = 0x00000004;
  static const WINAPI_ServiceStartType SERVICE_NO_CHANGE = 0xffffffff;
  typedef DWORD WINAPI_ServiceErrorControl; //Alias
  static const WINAPI_ServiceErrorControl SERVICE_ERROR_IGNORE = 0x00000000;
  static const WINAPI_ServiceErrorControl SERVICE_ERROR_NORMAL = 0x00000001;
  static const WINAPI_ServiceErrorControl SERVICE_ERROR_SEVERE = 0x00000002;
  static const WINAPI_ServiceErrorControl SERVICE_ERROR_CRITICAL = 0x00000003;
//static const WINAPI_ServiceErrorControl SERVICE_NO_CHANGE = 0xffffffff;
  typedef DWORD WINAPI_ServiceInfoLevel; //Alias
  static const WINAPI_ServiceInfoLevel SERVICE_CONFIG_DESCRIPTION = 1;
  static const WINAPI_ServiceInfoLevel SERVICE_CONFIG_FAILURE_ACTIONS = 2;
  static const WINAPI_ServiceInfoLevel SERVICE_CONFIG_DELAYED_AUTO_START_INFO = 3;
  static const WINAPI_ServiceInfoLevel SERVICE_CONFIG_FAILURE_ACTIONS_FLAG = 4;
  static const WINAPI_ServiceInfoLevel SERVICE_CONFIG_SERVICE_SID_INFO = 5;
  static const WINAPI_ServiceInfoLevel SERVICE_CONFIG_REQUIRED_PRIVILEGES_INFO = 6;
  static const WINAPI_ServiceInfoLevel SERVICE_CONFIG_PRESHUTDOWN_INFO = 7;
  static const WINAPI_ServiceInfoLevel SERVICE_CONFIG_TRIGGER_INFO = 8;
  static const WINAPI_ServiceInfoLevel SERVICE_CONFIG_PREFERRED_NODE = 9;
  typedef DWORD WINAPI_SCManagerAccess; //Alias
  static const WINAPI_SCManagerAccess SC_MANAGER_CONNECT = 0x0001;
  static const WINAPI_SCManagerAccess SC_MANAGER_CREATE_SERVICE = 0x0002;
  static const WINAPI_SCManagerAccess SC_MANAGER_ENUMERATE_SERVICE = 0x0004;
  static const WINAPI_SCManagerAccess SC_MANAGER_LOCK = 0x0008;
  static const WINAPI_SCManagerAccess SC_MANAGER_QUERY_LOCK_STATUS = 0x0010;
  static const WINAPI_SCManagerAccess SC_MANAGER_MODIFY_BOOT_CONFIG = 0x0020;
  static const WINAPI_SCManagerAccess SC_MANAGER_ALL_ACCESS = 0x000F003F;
  typedef DWORD WINAPI_ServiceAccess; //Alias
  static const WINAPI_ServiceAccess SERVICE_QUERY_CONFIG = 0x0001;
  static const WINAPI_ServiceAccess SERVICE_CHANGE_CONFIG = 0x0002;
  static const WINAPI_ServiceAccess SERVICE_QUERY_STATUS = 0x0004;
  static const WINAPI_ServiceAccess SERVICE_ENUMERATE_DEPENDENTS = 0x0008;
  static const WINAPI_ServiceAccess SERVICE_START = 0x0010;
  static const WINAPI_ServiceAccess SERVICE_STOP = 0x0020;
  static const WINAPI_ServiceAccess SERVICE_PAUSE_CONTINUE = 0x0040;
  static const WINAPI_ServiceAccess SERVICE_INTERROGATE = 0x0080;
  static const WINAPI_ServiceAccess SERVICE_USER_DEFINED_CONTROL = 0x0100;
  static const WINAPI_ServiceAccess SERVICE_ALL_ACCESS = 0x000F1FF;
  typedef DWORD WINAPI_ServiceControl; //Alias
  static const WINAPI_ServiceControl SERVICE_CONTROL_STOP = 0x00000001;
  static const WINAPI_ServiceControl SERVICE_CONTROL_PAUSE = 0x00000002;
  static const WINAPI_ServiceControl SERVICE_CONTROL_CONTINUE = 0x00000003;
  static const WINAPI_ServiceControl SERVICE_CONTROL_INTERROGATE = 0x00000004;
  static const WINAPI_ServiceControl SERVICE_CONTROL_SHUTDOWN = 0x00000005;
  static const WINAPI_ServiceControl SERVICE_CONTROL_PARAMCHANGE = 0x00000006;
  static const WINAPI_ServiceControl SERVICE_CONTROL_NETBINDADD = 0x00000007;
  static const WINAPI_ServiceControl SERVICE_CONTROL_NETBINDREMOVE = 0x00000008;
  static const WINAPI_ServiceControl SERVICE_CONTROL_NETBINDENABLE = 0x00000009;
  static const WINAPI_ServiceControl SERVICE_CONTROL_NETBINDDISABLE = 0x0000000A;
  static const WINAPI_ServiceControl SERVICE_CONTROL_DEVICEEVENT = 0x0000000B;
  static const WINAPI_ServiceControl SERVICE_CONTROL_HARDWAREPROFILECHANGE = 0x0000000C;
  static const WINAPI_ServiceControl SERVICE_CONTROL_POWEREVENT = 0x0000000D;
  static const WINAPI_ServiceControl SERVICE_CONTROL_SESSIONCHANGE = 0x0000000E;
  static const WINAPI_ServiceControl SERVICE_CONTROL_PRESHUTDOWN = 0x0000000F;
  typedef DWORD WINAPI_ServiceAcceptControls; //Alias
  static const WINAPI_ServiceAcceptControls SERVICE_ACCEPT_STOP = 0x00000001;
  static const WINAPI_ServiceAcceptControls SERVICE_ACCEPT_PAUSE_CONTINUE = 0x00000002;
  static const WINAPI_ServiceAcceptControls SERVICE_ACCEPT_SHUTDOWN = 0x00000004;
  static const WINAPI_ServiceAcceptControls SERVICE_ACCEPT_PARAMCHANGE = 0x00000008;
  static const WINAPI_ServiceAcceptControls SERVICE_ACCEPT_NETBINDCHANGE = 0x00000010;
  static const WINAPI_ServiceAcceptControls SERVICE_ACCEPT_HARDWAREPROFILECHANGE = 0x00000020;
  static const WINAPI_ServiceAcceptControls SERVICE_ACCEPT_POWEREVENT = 0x00000040;
  static const WINAPI_ServiceAcceptControls SERVICE_ACCEPT_SESSIONCHANGE = 0x00000080;
  typedef DWORD WINAPI_ServiceNotifyMask; //Alias
  static const WINAPI_ServiceNotifyMask SERVICE_NOTIFY_STOPPED = 0x00000001;
  static const WINAPI_ServiceNotifyMask SERVICE_NOTIFY_START_PENDING = 0x00000002;
  static const WINAPI_ServiceNotifyMask SERVICE_NOTIFY_STOP_PENDING = 0x00000004;
  static const WINAPI_ServiceNotifyMask SERVICE_NOTIFY_RUNNING = 0x00000008;
  static const WINAPI_ServiceNotifyMask SERVICE_NOTIFY_CONTINUE_PENDING = 0x00000010;
  static const WINAPI_ServiceNotifyMask SERVICE_NOTIFY_PAUSE_PENDING = 0x00000020;
  static const WINAPI_ServiceNotifyMask SERVICE_NOTIFY_PAUSED = 0x00000040;
  static const WINAPI_ServiceNotifyMask SERVICE_NOTIFY_CREATED = 0x00000080;
  static const WINAPI_ServiceNotifyMask SERVICE_NOTIFY_DELETED = 0x00000100;
  static const WINAPI_ServiceNotifyMask SERVICE_NOTIFY_DELETE_PENDING = 0x00000200;
  typedef DWORD WINAPI_ServiceFlags; //Alias
  static const WINAPI_ServiceAcceptControls SERVICE_RUNS_IN_NOT_SYSTEM_PROCESS = 0x0000;
  static const WINAPI_ServiceAcceptControls SERVICE_RUNS_IN_SYSTEM_PROCESS = 0x0001;
  typedef struct SERVICE_STATUS_PROCESS {
    WINAPI_ServiceType dwServiceType;
    WINAPI_ServiceCurrentState dwCurrentState;
    WINAPI_ServiceAcceptControls dwControlsAccepted;
    DWORD dwWin32ExitCode;
    DWORD dwServiceSpecificExitCode;
    DWORD dwCheckPoint;
    DWORD dwWaitHint;
    DWORD dwProcessId;
    WINAPI_ServiceFlags dwServiceFlags;
  } SERVICE_STATUS_PROCESS;
  typedef struct SERVICE_NOTIFYA {
    DWORD dwVersion;
    PFN_SC_NOTIFY_CALLBACK pfnNotifyCallback;
    PVOID pContext;
    DWORD dwNotificationStatus;
    SERVICE_STATUS_PROCESS ServiceStatus;
    DWORD dwNotificationTriggered;
    LPSTR pszServiceNames;
  } SERVICE_NOTIFYA;
  typedef SERVICE_NOTIFYA *PSERVICE_NOTIFYA; //Pointer
  typedef struct SERVICE_NOTIFYW {
    DWORD dwVersion;
    PFN_SC_NOTIFY_CALLBACK pfnNotifyCallback;
    PVOID pContext;
    DWORD dwNotificationStatus;
    SERVICE_STATUS_PROCESS ServiceStatus;
    DWORD dwNotificationTriggered;
    LPWSTR pszServiceNames;
  } SERVICE_NOTIFYW;
  typedef SERVICE_NOTIFYW *PSERVICE_NOTIFYW; //Pointer
  typedef struct SERVICE_STATUS {
    WINAPI_ServiceType dwServiceType;
    WINAPI_ServiceCurrentState dwCurrentState;
    WINAPI_ServiceAcceptControls dwControlsAccepted;
    DWORD dwWin32ExitCode;
    DWORD dwServiceSpecificExitCode;
    DWORD dwCheckPoint;
    DWORD dwWaitHint;
  } SERVICE_STATUS;
  typedef SERVICE_STATUS *LPSERVICE_STATUS; //Pointer
  typedef LPVOID LPSERVICE_MAIN_FUNCTION; //Alias
  typedef struct SERVICE_TABLE_ENTRYA {
    LPSTR lpServiceName;
    LPSERVICE_MAIN_FUNCTION lpServiceProc;
  } SERVICE_TABLE_ENTRYA;
  typedef struct SERVICE_TABLE_ENTRYW {
    LPWSTR lpServiceName;
    LPSERVICE_MAIN_FUNCTION lpServiceProc;
  } SERVICE_TABLE_ENTRYW;
  typedef struct ENUM_SERVICE_STATUSA {
    LPSTR lpServiceName;
    LPSTR lpDisplayName;
    SERVICE_STATUS ServiceStatus;
  } ENUM_SERVICE_STATUSA;
  typedef ENUM_SERVICE_STATUSA *LPENUM_SERVICE_STATUSA; //Pointer
  typedef struct ENUM_SERVICE_STATUSW {
    LPWSTR lpServiceName;
    LPWSTR lpDisplayName;
    SERVICE_STATUS ServiceStatus;
  } ENUM_SERVICE_STATUSW;
  typedef ENUM_SERVICE_STATUSW *LPENUM_SERVICE_STATUSW; //Pointer
  typedef struct QUERY_SERVICE_CONFIGA {
    WINAPI_ServiceType dwServiceType;
    WINAPI_ServiceStartType dwStartType;
    WINAPI_ServiceErrorControl dwErrorControl;
    LPSTR lpBinaryPathName;
    LPSTR lpLoadOrderGroup;
    DWORD dwTagId;
    LPSTR lpDependencies;
    LPSTR lpServiceStartName;
    LPSTR lpDisplayName;
  } QUERY_SERVICE_CONFIGA;
  typedef QUERY_SERVICE_CONFIGA *LPQUERY_SERVICE_CONFIGA; //Pointer
  typedef struct QUERY_SERVICE_CONFIGW {
    WINAPI_ServiceType dwServiceType;
    WINAPI_ServiceStartType dwStartType;
    WINAPI_ServiceErrorControl dwErrorControl;
    LPWSTR lpBinaryPathName;
    LPWSTR lpLoadOrderGroup;
    DWORD dwTagId;
    LPWSTR lpDependencies;
    LPWSTR lpServiceStartName;
    LPWSTR lpDisplayName;
  } QUERY_SERVICE_CONFIGW;
  typedef QUERY_SERVICE_CONFIGW *LPQUERY_SERVICE_CONFIGW; //Pointer
  typedef struct QUERY_SERVICE_LOCK_STATUSA {
    DWORD fIsLocked;
    LPSTR lpLockOwner;
    DWORD dwLockDuration;
  } QUERY_SERVICE_LOCK_STATUSA;
  typedef QUERY_SERVICE_LOCK_STATUSA *LPQUERY_SERVICE_LOCK_STATUSA; //Pointer
  typedef struct QUERY_SERVICE_LOCK_STATUSW {
    DWORD fIsLocked;
    LPWSTR lpLockOwner;
    DWORD dwLockDuration;
  } QUERY_SERVICE_LOCK_STATUSW;
  typedef QUERY_SERVICE_LOCK_STATUSW *LPQUERY_SERVICE_LOCK_STATUSW; //Pointer
]]
