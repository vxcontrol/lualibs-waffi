require( 'waffi.headers.windows' )
require( 'waffi.headers.registry' )
require( 'waffi.headers.events' )
require( 'waffi.headers.services' )
require( 'waffi.headers.cryptography' )
require( 'waffi.headers.security' )
require( 'waffi.headers.native' )
require( 'waffi.headers.network' )
require( 'waffi.headers.processes' )
require( 'waffi.headers.shell' )
local ffi = require( 'ffi' )
ffi.cdef [[
  enum { HW_PROFILE_GUIDLEN = 39 };
  enum { MAX_PROFILE_LEN = 80 };
  enum { WCT_OBJNAME_LENGTH = 128 };
  typedef WINAPI_ERROR_CODE WINAPI_REG_ERROR; //Alias
  typedef struct HW_PROFILE_INFOA {
    DWORD dwDockInfo;
    CHAR szHwProfileGuid[HW_PROFILE_GUIDLEN];
    CHAR szHwProfileName[MAX_PROFILE_LEN];
  } HW_PROFILE_INFOA;
  typedef HW_PROFILE_INFOA *LPHW_PROFILE_INFOA; //Pointer
  typedef struct HW_PROFILE_INFOW {
    DWORD dwDockInfo;
    WCHAR szHwProfileGuid[HW_PROFILE_GUIDLEN];
    WCHAR szHwProfileName[MAX_PROFILE_LEN];
  } HW_PROFILE_INFOW;
  typedef HW_PROFILE_INFOW *LPHW_PROFILE_INFOW; //Pointer
  typedef UINT WCT_OBJECT_TYPE; //Alias
  static const WCT_OBJECT_TYPE WctCriticalSectionType = 1;
  static const WCT_OBJECT_TYPE WctSendMessageType = 2;
  static const WCT_OBJECT_TYPE WctMutexType = 3;
  static const WCT_OBJECT_TYPE WctAlpcType = 4;
  static const WCT_OBJECT_TYPE WctComType = 5;
  static const WCT_OBJECT_TYPE WctThreadWaitType = 6;
  static const WCT_OBJECT_TYPE WctProcessWaitType = 7;
  static const WCT_OBJECT_TYPE WctThreadType = 8;
  static const WCT_OBJECT_TYPE WctComActivationType = 9;
  static const WCT_OBJECT_TYPE WctUnknownType = 10;
  static const WCT_OBJECT_TYPE WctSocketIoType = 11;
  static const WCT_OBJECT_TYPE WctSmbIoType = 12;
  typedef UINT WCT_OBJECT_STATUS; //Alias
  static const WCT_OBJECT_STATUS WctStatusNoAccess = 1;
  static const WCT_OBJECT_STATUS WctStatusRunning = 2;
  static const WCT_OBJECT_STATUS WctStatusBlocked = 3;
  static const WCT_OBJECT_STATUS WctStatusPidOnly = 4;
  static const WCT_OBJECT_STATUS WctStatusPidOnlyRpcss = 5;
  static const WCT_OBJECT_STATUS WctStatusOwned = 6;
  static const WCT_OBJECT_STATUS WctStatusNotOwned = 7;
  static const WCT_OBJECT_STATUS WctStatusAbandoned = 8;
  static const WCT_OBJECT_STATUS WctStatusUnknown = 9;
  static const WCT_OBJECT_STATUS WctStatusError = 10;
  typedef struct WINAPI_WAITCHAIN_NODE_INFO_u_s1 {
    WCHAR ObjectName[WCT_OBJNAME_LENGTH];
    LARGE_INTEGER Timeout;
    BOOL Alertable;
  } WINAPI_WAITCHAIN_NODE_INFO_u_s1;
  typedef struct WINAPI_WAITCHAIN_NODE_INFO_u_s2 {
    DWORD ProcessId;
    DWORD ThreadId;
    DWORD WaitTime;
    DWORD ContextSwitches;
  } WINAPI_WAITCHAIN_NODE_INFO_u_s2;
  typedef union WINAPI_WAITCHAIN_NODE_INFO_u {
    WINAPI_WAITCHAIN_NODE_INFO_u_s1 LockObject;
    WINAPI_WAITCHAIN_NODE_INFO_u_s2 ThreadObject;
  } WINAPI_WAITCHAIN_NODE_INFO_u;
  typedef struct WAITCHAIN_NODE_INFO {
    WCT_OBJECT_TYPE ObjectType;
    WCT_OBJECT_STATUS ObjectStatus;
    WINAPI_WAITCHAIN_NODE_INFO_u ObjectStatus;
  } WAITCHAIN_NODE_INFO;
  typedef WAITCHAIN_NODE_INFO *PWAITCHAIN_NODE_INFO; //Pointer
  typedef UINT SC_ENUM_TYPE; //Alias
  static const SC_ENUM_TYPE SC_ENUM_PROCESS_INFO = 0;
  typedef UINT TRACE_INFO_CLASS; //Alias
  static const TRACE_INFO_CLASS TraceGuidQueryList = 0;
  static const TRACE_INFO_CLASS TraceGuidQueryInfo = 1;
  static const TRACE_INFO_CLASS TraceGuidQueryProcess = 2;
  static const TRACE_INFO_CLASS TraceStackTracingInfo = 3;
  static const TRACE_INFO_CLASS TraceSystemTraceEnableFlagsInfo = 4;
  static const TRACE_INFO_CLASS TraceSampledProfileIntervalInfo = 5;
  static const TRACE_INFO_CLASS TraceProfileSourceConfigInfo = 6;
  static const TRACE_INFO_CLASS TraceProfileSourceListInfo = 7;
  static const TRACE_INFO_CLASS TracePmcEventListInfo = 8;
  static const TRACE_INFO_CLASS TracePmcCounterListInfo = 9;
  typedef TRACE_INFO_CLASS TRACE_QUERY_INFO_CLASS; //Alias
  typedef UINT PROG_INVOKE_SETTING; //Alias
  static const PROG_INVOKE_SETTING ProgressInvokeNever = 1;
  static const PROG_INVOKE_SETTING ProgressInvokeEveryObject = 2;
  static const PROG_INVOKE_SETTING ProgressInvokeOnError = 3;
  static const PROG_INVOKE_SETTING ProgressCancelOperation = 4;
  static const PROG_INVOKE_SETTING ProgressRetryOperation = 5;
  static const PROG_INVOKE_SETTING ProgressInvokePrePostError = 6;
  typedef UINT TRUSTED_INFORMATION_CLASS; //Alias
  static const TRUSTED_INFORMATION_CLASS TrustedDomainNameInformation = 1;
  static const TRUSTED_INFORMATION_CLASS TrustedControllersInformation = 2;
  static const TRUSTED_INFORMATION_CLASS TrustedPosixOffsetInformation = 3;
  static const TRUSTED_INFORMATION_CLASS TrustedPasswordInformation = 4;
  static const TRUSTED_INFORMATION_CLASS TrustedDomainInformationBasic = 5;
  static const TRUSTED_INFORMATION_CLASS TrustedDomainInformationEx = 6;
  static const TRUSTED_INFORMATION_CLASS TrustedDomainAuthInformation = 7;
  static const TRUSTED_INFORMATION_CLASS TrustedDomainFullInformation = 8;
  static const TRUSTED_INFORMATION_CLASS TrustedDomainAuthInformationInternal = 9;
  static const TRUSTED_INFORMATION_CLASS TrustedDomainFullInformationInternal = 10;
  static const TRUSTED_INFORMATION_CLASS TrustedDomainInformationEx2Internal = 11;
  static const TRUSTED_INFORMATION_CLASS TrustedDomainFullInformation2Internal = 12;
  static const TRUSTED_INFORMATION_CLASS TrustedDomainSupportedEncryptionTypes = 13;
  typedef DWORD WINAPI_SDRevision; //Alias
  static const WINAPI_SDRevision SECURITY_DESCRIPTOR_REVISION = 1;
  typedef DWORD WINAPI_SDDL_Revision; //Alias
  typedef ULONG WINAPI_SEF_Flags; //Alias
  typedef DWORD WINAPI_SaferScopeId; //Alias
  static const WINAPI_SaferScopeId SAFER_SCOPEID_MACHINE = 1;
  static const WINAPI_SaferScopeId SAFER_SCOPEID_USER = 2;
  typedef DWORD WINAPI_MandatoryPolicyFlags; //Alias
  typedef DWORD WINAPI_LogonFlags; //Alias
  typedef DWORD WINAPI_LogonType; //Alias
  static const WINAPI_LogonType LOGON32_LOGON_INTERACTIVE = 2;
  static const WINAPI_LogonType LOGON32_LOGON_NETWORK = 3;
  static const WINAPI_LogonType LOGON32_LOGON_BATCH = 4;
  static const WINAPI_LogonType LOGON32_LOGON_SERVICE = 5;
  static const WINAPI_LogonType LOGON32_LOGON_UNLOCK = 7;
  static const WINAPI_LogonType LOGON32_LOGON_NETWORK_CLEARTEXT = 8;
  static const WINAPI_LogonType LOGON32_LOGON_NEW_CREDENTIALS = 9;
  typedef DWORD WINAPI_LogonProvider; //Alias
  static const WINAPI_LogonProvider LOGON32_PROVIDER_DEFAULT = 0;
  static const WINAPI_LogonProvider LOGON32_PROVIDER_WINNT35 = 1;
  static const WINAPI_LogonProvider LOGON32_PROVIDER_WINNT40 = 2;
  static const WINAPI_LogonProvider LOGON32_PROVIDER_WINNT50 = 3;
  typedef DWORD WINAPI_TreeSecAction; //Alias
  typedef DWORD WINAPI_CredGetTargetInfoFlags; //Alias
  typedef DWORD WINAPI_CredType; //Alias
  static const WINAPI_CredType CRED_TYPE_GENERIC = 1;
  static const WINAPI_CredType CRED_TYPE_DOMAIN_PASSWORD = 2;
  static const WINAPI_CredType CRED_TYPE_DOMAIN_CERTIFICATE = 3;
  static const WINAPI_CredType CRED_TYPE_DOMAIN_VISIBLE_PASSWORD = 4;
  static const WINAPI_CredType CRED_TYPE_GENERIC_CERTIFICATE = 5;
  typedef DWORD WINAPI_CredEnumerateFlags; //Alias
  typedef DWORD WINAPI_CreateRestrictedTokenFlags; //Alias
  typedef UINT POLICY_INFORMATION_CLASS; //Alias
  static const POLICY_INFORMATION_CLASS PolicyAuditLogInformation = 1;
  static const POLICY_INFORMATION_CLASS PolicyAuditEventsInformation = 2;
  static const POLICY_INFORMATION_CLASS PolicyPrimaryDomainInformation = 3;
  static const POLICY_INFORMATION_CLASS PolicyPdAccountInformation = 4;
  static const POLICY_INFORMATION_CLASS PolicyAccountDomainInformation = 5;
  static const POLICY_INFORMATION_CLASS PolicyLsaServerRoleInformation = 6;
  static const POLICY_INFORMATION_CLASS PolicyReplicaSourceInformation = 7;
  static const POLICY_INFORMATION_CLASS PolicyDefaultQuotaInformation = 8;
  static const POLICY_INFORMATION_CLASS PolicyModificationInformation = 9;
  static const POLICY_INFORMATION_CLASS PolicyAuditFullSetInformation = 11;
  static const POLICY_INFORMATION_CLASS PolicyAuditFullQueryInformation = 11;
  static const POLICY_INFORMATION_CLASS PolicyDnsDomainInformation = 12;
  static const POLICY_INFORMATION_CLASS PolicyDnsDomainInformationInt = 13;
  static const POLICY_INFORMATION_CLASS PolicyLocalAccountDomainInformation = 14;
  typedef UINT POLICY_DOMAIN_INFORMATION_CLASS; //Alias
  static const POLICY_DOMAIN_INFORMATION_CLASS PolicyDomainQualityOfServiceInformation = 1;
  static const POLICY_DOMAIN_INFORMATION_CLASS PolicyDomainEfsInformation = 2;
  static const POLICY_DOMAIN_INFORMATION_CLASS PolicyDomainKerberosTicketInformation = 3;
  typedef struct EFS_HASH_BLOB {
    DWORD cbData;
    PBYTE pbData;
  } EFS_HASH_BLOB;
  typedef EFS_HASH_BLOB *PEFS_HASH_BLOB; //Pointer
  typedef struct ENCRYPTION_CERTIFICATE_HASH {
    DWORD cbTotalLength;
    SID* pUserSid;
    PEFS_HASH_BLOB pHash;
    LPWSTR lpDisplayInformation;
  } ENCRYPTION_CERTIFICATE_HASH;
  typedef ENCRYPTION_CERTIFICATE_HASH *PENCRYPTION_CERTIFICATE_HASH; //Pointer
  typedef struct ENCRYPTION_CERTIFICATE_HASH_LIST {
    DWORD nCert_Hash;
    PENCRYPTION_CERTIFICATE_HASH* pUsers;
  } ENCRYPTION_CERTIFICATE_HASH_LIST;
  typedef ENCRYPTION_CERTIFICATE_HASH_LIST *PENCRYPTION_CERTIFICATE_HASH_LIST; //Pointer
  typedef UINT INSTALLSPECTYPE; //Alias
  static const INSTALLSPECTYPE APPNAME = 1;
  static const INSTALLSPECTYPE FILEEXT = 2;
  static const INSTALLSPECTYPE PROGID = 3;
  static const INSTALLSPECTYPE COMCLASS = 4;
  typedef struct WINAPI_INSTALLSPEC_s1 {
    WCHAR* Name;
    GUID GPOId;
  } WINAPI_INSTALLSPEC_s1;
  typedef struct WINAPI_INSTALLSPEC_s2 {
    GUID Clsid;
    WINAPI_CLSCTX ClsCtx;
  } WINAPI_INSTALLSPEC_s2;
  typedef union INSTALLSPEC {
    WINAPI_INSTALLSPEC_s1 AppName;
    WCHAR* FileExt;
    WCHAR* ProgId;
    WINAPI_INSTALLSPEC_s2 COMClass;
  } INSTALLSPEC;
  typedef struct INSTALLDATA {
    INSTALLSPECTYPE Type;
    INSTALLSPEC Spec;
  } INSTALLDATA;
  typedef INSTALLDATA *PINSTALLDATA; //Pointer
  typedef struct VALENTA {
    LPSTR ve_valuename;
    DWORD ve_valuelen;
    DWORD_PTR ve_valueptr;
    DWORD ve_type;
  } VALENTA;
  typedef VALENTA *PVALENTA; //Pointer
  typedef struct VALENTW {
    LPWSTR ve_valuename;
    DWORD ve_valuelen;
    DWORD_PTR ve_valueptr;
    DWORD ve_type;
  } VALENTW;
  typedef VALENTW *PVALENTW; //Pointer
  typedef struct EFS_CERTIFICATE_BLOB {
    DWORD dwCertEncodingType;
    DWORD cbData;
    PBYTE pbData;
  } EFS_CERTIFICATE_BLOB;
  typedef EFS_CERTIFICATE_BLOB *PEFS_CERTIFICATE_BLOB; //Pointer
  typedef struct ENCRYPTION_CERTIFICATE {
    DWORD cbTotalLength;
    SID* pUserSid;
    PEFS_CERTIFICATE_BLOB pCertBlob;
  } ENCRYPTION_CERTIFICATE;
  typedef ENCRYPTION_CERTIFICATE *PENCRYPTION_CERTIFICATE; //Pointer
  typedef struct ENCRYPTION_CERTIFICATE_LIST {
    DWORD nUsers;
    PENCRYPTION_CERTIFICATE* pUsers;
  } ENCRYPTION_CERTIFICATE_LIST;
  typedef ENCRYPTION_CERTIFICATE_LIST *PENCRYPTION_CERTIFICATE_LIST; //Pointer
  typedef DWORD WINAPI_LocalState; //Alias
  typedef struct LOCALMANAGEDAPPLICATION {
    LPWSTR pszDeploymentName;
    LPWSTR pszPolicyName;
    LPWSTR pszProductId;
    WINAPI_LocalState dwState;
  } LOCALMANAGEDAPPLICATION;
  typedef LOCALMANAGEDAPPLICATION *PLOCALMANAGEDAPPLICATION; //Pointer
  typedef struct MANAGEDAPPLICATION {
    LPWSTR pszPackageName;
    LPWSTR pszPublisher;
    DWORD dwVersionHi;
    DWORD dwVersionLo;
    DWORD dwRevision;
    GUID GpoId;
    LPWSTR pszPolicyName;
    GUID ProductId;
    LANGID Language;
    LPWSTR pszOwner;
    LPWSTR pszCompany;
    LPWSTR pszComments;
    LPWSTR pszContact;
    LPWSTR pszSupportUrl;
    DWORD dwPathType;
    BOOL bInstalled;
  } MANAGEDAPPLICATION;
  typedef MANAGEDAPPLICATION *PMANAGEDAPPLICATION; //Pointer
  typedef struct PERF_COUNTERSET_INSTANCE {
    GUID CounterSetGuid;
    ULONG dwSize;
    ULONG InstanceId;
    ULONG InstanceNameOffset;
    ULONG InstanceNameSize;
  } PERF_COUNTERSET_INSTANCE;
  typedef PERF_COUNTERSET_INSTANCE *PPERF_COUNTERSET_INSTANCE; //Pointer
  typedef struct PERF_COUNTERSET_INFO {
    GUID CounterSetGuid;
    GUID ProviderGuid;
    ULONG NumCounters;
    ULONG InstanceType;
  } PERF_COUNTERSET_INFO;
  typedef PERF_COUNTERSET_INFO *PPERF_COUNTERSET_INFO; //Pointer
  typedef LPVOID PERFLIBREQUEST; //Alias
  typedef LPVOID PERF_MEM_ALLOC; //Alias
  typedef LPVOID PERF_MEM_FREE; //Alias
  typedef struct PERF_PROVIDER_CONTEXT {
    DWORD ContextSize;
    DWORD Reserved;
    PERFLIBREQUEST ControlCallback;
    PERF_MEM_ALLOC MemAllocRoutine;
    PERF_MEM_FREE MemFreeRoutine;
    LPVOID pMemContext;
  } PERF_PROVIDER_CONTEXT;
  typedef PERF_PROVIDER_CONTEXT *PPERF_PROVIDER_CONTEXT; //Pointer
  typedef LPVOID PEVENT_FILTER_DESCRIPTOR; //Alias
  typedef struct ENABLE_TRACE_PARAMETERS {
    ULONG Version;
    ULONG EnableProperty;
    ULONG ControlFlags;
    GUID SourceId;
    PEVENT_FILTER_DESCRIPTOR EnableFilterDesc;
  } ENABLE_TRACE_PARAMETERS;
  typedef ENABLE_TRACE_PARAMETERS *PENABLE_TRACE_PARAMETERS; //Pointer
  typedef struct TRACE_GUID_PROPERTIES {
    GUID Guid;
    ULONG GuidType;
    ULONG LoggerId;
    ULONG EnableLevel;
    ULONG EnableFlags;
    BOOLEAN IsEnable;
  } TRACE_GUID_PROPERTIES;
  typedef TRACE_GUID_PROPERTIES *PTRACE_GUID_PROPERTIES; //Pointer
  typedef struct TRACE_GUID_REGISTRATION {
    LPCGUID Guid;
    HANDLE RegHandle;
  } TRACE_GUID_REGISTRATION;
  typedef TRACE_GUID_REGISTRATION *PTRACE_GUID_REGISTRATION; //Pointer
  typedef struct INHERITED_FROMA {
    LONG GenerationGap;
    LPSTR AncestorName;
  } INHERITED_FROMA;
  typedef INHERITED_FROMA *PINHERITED_FROMA; //Pointer
  typedef struct INHERITED_FROMW {
    LONG GenerationGap;
    LPWSTR AncestorName;
  } INHERITED_FROMW;
  typedef INHERITED_FROMW *PINHERITED_FROMW; //Pointer
  typedef struct FN_OBJECT_MGR_FUNCTS {
    ULONG Placeholder;
  } FN_OBJECT_MGR_FUNCTS;
  typedef FN_OBJECT_MGR_FUNCTS *PFN_OBJECT_MGR_FUNCTS; //Pointer
  typedef struct LSA_TRANSLATED_SID {
    SID_NAME_USE Use;
    ULONG RelativeId;
    LONG DomainIndex;
  } LSA_TRANSLATED_SID;
  typedef LSA_TRANSLATED_SID *PLSA_TRANSLATED_SID; //Pointer
  typedef struct LSA_TRANSLATED_SID2 {
    SID_NAME_USE Use;
    PSID Sid;
    LONG DomainIndex;
    ULONG Flags;
  } LSA_TRANSLATED_SID2;
  typedef LSA_TRANSLATED_SID2 *PLSA_TRANSLATED_SID2; //Pointer
  typedef struct LSA_TRANSLATED_NAME {
    SID_NAME_USE Use;
    LSA_UNICODE_STRING Name;
    LONG DomainIndex;
  } LSA_TRANSLATED_NAME;
  typedef LSA_TRANSLATED_NAME *PLSA_TRANSLATED_NAME; //Pointer
  typedef struct TRUSTED_DOMAIN_INFORMATION_EX {
    LSA_UNICODE_STRING Name;
    LSA_UNICODE_STRING FlatName;
    PSID Sid;
    ULONG TrustDirection;
    ULONG TrustType;
    ULONG TrustAttributes;
  } TRUSTED_DOMAIN_INFORMATION_EX;
  typedef TRUSTED_DOMAIN_INFORMATION_EX *PTRUSTED_DOMAIN_INFORMATION_EX; //Pointer
  typedef ULONG WINAPI_LsaAuthType; //Alias
  static const WINAPI_LsaAuthType TRUST_AUTH_TYPE_NONE = 0;
  static const WINAPI_LsaAuthType TRUST_AUTH_TYPE_NT4OWF = 1;
  static const WINAPI_LsaAuthType TRUST_AUTH_TYPE_CLEAR = 2;
  static const WINAPI_LsaAuthType TRUST_AUTH_TYPE_VERSION = 3;
  typedef struct LSA_AUTH_INFORMATION {
    LARGE_INTEGER LastUpdateTime;
    WINAPI_LsaAuthType AuthType;
    ULONG AuthInfoLength;
    PUCHAR AuthInfo;
  } LSA_AUTH_INFORMATION;
  typedef LSA_AUTH_INFORMATION *PLSA_AUTH_INFORMATION; //Pointer
  typedef struct TRUSTED_DOMAIN_AUTH_INFORMATION {
    ULONG IncomingAuthInfos;
    PLSA_AUTH_INFORMATION IncomingAuthenticationInformation;
    PLSA_AUTH_INFORMATION IncomingPreviousAuthenticationInformation;
    ULONG OutgoingAuthInfos;
    PLSA_AUTH_INFORMATION OutgoingAuthenticationInformation;
    PLSA_AUTH_INFORMATION OutgoingPreviousAuthenticationInformation;
  } TRUSTED_DOMAIN_AUTH_INFORMATION;
  typedef TRUSTED_DOMAIN_AUTH_INFORMATION *PTRUSTED_DOMAIN_AUTH_INFORMATION; //Pointer
  typedef ULONG WINAPI_TRACE_MESSAGE_FLAGS; //Alias
  typedef ULONG WINAPI_LSA_LOOKUP_FLAGS; //Alias
  typedef LPVOID PFE_EXPORT_FUNC; //Alias
  typedef LPVOID PFE_IMPORT_FUNC; //Alias
  typedef LPVOID LPHANDLER_FUNCTION; //Alias
  typedef LPVOID LPHANDLER_FUNCTION_EX; //Alias
  typedef ULONG64 TRACEHANDLE; //Alias
  typedef TRACEHANDLE *PTRACEHANDLE; //Pointer
  typedef LPVOID WMIDPREQUEST; //Alias
  typedef LPVOID ENABLECALLBACK; //Alias
  typedef LPVOID FN_PROGRESS; //Alias
  typedef PVOID LSA_HANDLE; //Alias
  typedef LSA_HANDLE *PLSA_HANDLE; //Pointer
  typedef ULONG LSA_ENUMERATION_HANDLE; //Alias
  typedef LSA_ENUMERATION_HANDLE *PLSA_ENUMERATION_HANDLE; //Pointer
  typedef LPVOID HWCT; //Alias
  typedef LPVOID PWAITCHAINCALLBACK; //Alias
  typedef LPVOID PCOGETCALLSTATE; //Alias
  typedef LPVOID PCOGETACTIVATIONSTATE; //Alias
  typedef ULONGLONG REGHANDLE; //Alias
  typedef REGHANDLE *PREGHANDLE; //Pointer
  typedef OBJECT_ATTRIBUTES *PLSA_OBJECT_ATTRIBUTES; //Pointer
  typedef DWORD WINAPI_SHUTDOWN_FLAGS; //Alias
  typedef DWORD WINAPI_SHTDN_REASON; //Alias
  typedef WINAPI_TOKEN_ACCESS_MASK WINAPI_TOKEN_ACCESS_MASK_DWORD; //Alias
  WINAPI_REG_ERROR          RegCloseKey(                                         HKEY hKey);
  WINAPI_REG_ERROR          RegConnectRegistryA(                                 LPCSTR lpMachineName, HKEY hKey, PHKEY phkResult);
  WINAPI_REG_ERROR          RegConnectRegistryW(                                 LPCWSTR lpMachineName, HKEY hKey, PHKEY phkResult);
  WINAPI_REG_ERROR          RegCopyTreeA(                                        HKEY hKeySrc, LPCSTR lpSubKey, HKEY hKeyDest);
  WINAPI_REG_ERROR          RegCopyTreeW(                                        HKEY hKeySrc, LPCWSTR lpSubKey, HKEY hKeyDest);
  WINAPI_REG_ERROR          RegCreateKeyExA(                                     HKEY hKey, LPCSTR lpSubKey, DWORD Reserved, LPSTR lpClass, WINAPI_RegOptions dwOptions, REGSAM samDesired, LPSECURITY_ATTRIBUTES lpSecurityAttributes, PHKEY phkResult, WINAPI_RegDisposition* lpdwDisposition);
  WINAPI_REG_ERROR          RegCreateKeyExW(                                     HKEY hKey, LPCWSTR lpSubKey, DWORD Reserved, LPWSTR lpClass, WINAPI_RegOptions dwOptions, REGSAM samDesired, LPSECURITY_ATTRIBUTES lpSecurityAttributes, PHKEY phkResult, WINAPI_RegDisposition* lpdwDisposition);
  WINAPI_REG_ERROR          RegCreateKeyTransactedA(                             HKEY hKey, LPCSTR lpSubKey, DWORD Reserved, LPSTR lpClass, WINAPI_RegOptions dwOptions, REGSAM samDesired, const LPSECURITY_ATTRIBUTES lpSecurityAttributes, PHKEY phkResult, WINAPI_RegDisposition* lpdwDisposition, HANDLE hTransaction, PVOID pExtendedParemeter);
  WINAPI_REG_ERROR          RegCreateKeyTransactedW(                             HKEY hKey, LPCWSTR lpSubKey, DWORD Reserved, LPWSTR lpClass, WINAPI_RegOptions dwOptions, REGSAM samDesired, const LPSECURITY_ATTRIBUTES lpSecurityAttributes, PHKEY phkResult, WINAPI_RegDisposition* lpdwDisposition, HANDLE hTransaction, PVOID pExtendedParemeter);
  WINAPI_REG_ERROR          RegDeleteKeyA(                                       HKEY hKey, LPCSTR lpSubKey);
  WINAPI_REG_ERROR          RegDeleteKeyW(                                       HKEY hKey, LPCWSTR lpSubKey);
  WINAPI_REG_ERROR          RegDeleteKeyExA(                                     HKEY hKey, LPCSTR lpSubKey, REGSAM samDesired, DWORD Reserved);
  WINAPI_REG_ERROR          RegDeleteKeyExW(                                     HKEY hKey, LPCWSTR lpSubKey, REGSAM samDesired, DWORD Reserved);
  WINAPI_REG_ERROR          RegDeleteKeyTransactedA(                             HKEY hKey, LPCSTR lpSubKey, REGSAM samDesired, DWORD Reserved, HANDLE hTransaction, PVOID pExtendedParameter);
  WINAPI_REG_ERROR          RegDeleteKeyTransactedW(                             HKEY hKey, LPCWSTR lpSubKey, REGSAM samDesired, DWORD Reserved, HANDLE hTransaction, PVOID pExtendedParameter);
  WINAPI_REG_ERROR          RegDeleteKeyValueA(                                  HKEY hKey, LPCSTR lpSubKey, LPCSTR lpValueName);
  WINAPI_REG_ERROR          RegDeleteKeyValueW(                                  HKEY hKey, LPCWSTR lpSubKey, LPCWSTR lpValueName);
  WINAPI_REG_ERROR          RegDeleteTreeA(                                      HKEY hKey, LPCSTR lpSubKey);
  WINAPI_REG_ERROR          RegDeleteTreeW(                                      HKEY hKey, LPCWSTR lpSubKey);
  WINAPI_REG_ERROR          RegDeleteValueA(                                     HKEY hKey, LPCSTR lpValueName);
  WINAPI_REG_ERROR          RegDeleteValueW(                                     HKEY hKey, LPCWSTR lpValueName);
  WINAPI_REG_ERROR          RegDisablePredefinedCache(                           );
  WINAPI_REG_ERROR          RegDisablePredefinedCacheEx(                         );
  WINAPI_REG_ERROR          RegDisableReflectionKey(                             HKEY hBase);
  WINAPI_REG_ERROR          RegEnableReflectionKey(                              HKEY hBase);
  WINAPI_REG_ERROR          RegEnumKeyExA(                                       HKEY hKey, DWORD dwIndex, LPSTR lpName, LPDWORD lpcName, LPDWORD lpReserved, LPSTR lpClass, LPDWORD lpcClass, PFILETIME lpftLastWriteTime);
  WINAPI_REG_ERROR          RegEnumKeyExW(                                       HKEY hKey, DWORD dwIndex, LPWSTR lpName, LPDWORD lpcName, LPDWORD lpReserved, LPWSTR lpClass, LPDWORD lpcClass, PFILETIME lpftLastWriteTime);
  WINAPI_REG_ERROR          RegEnumValueA(                                       HKEY hKey, DWORD dwIndex, LPSTR lpValueName, LPDWORD lpcchValueName, LPDWORD lpReserved, WINAPI_RegType* lpType, LPBYTE lpData, LPDWORD lpcbData);
  WINAPI_REG_ERROR          RegEnumValueW(                                       HKEY hKey, DWORD dwIndex, LPWSTR lpValueName, LPDWORD lpcchValueName, LPDWORD lpReserved, WINAPI_RegType* lpType, LPBYTE lpData, LPDWORD lpcbData);
  WINAPI_REG_ERROR          RegFlushKey(                                         HKEY hKey);
  WINAPI_REG_ERROR          RegGetValueA(                                        HKEY hkey, LPCSTR lpSubKey, LPCSTR lpValue, DWORD dwFlags, WINAPI_RegType* pdwType, PVOID pvData, LPDWORD pcbData);
  WINAPI_REG_ERROR          RegGetValueW(                                        HKEY hkey, LPCWSTR lpSubKey, LPCWSTR lpValue, DWORD dwFlags, WINAPI_RegType* pdwType, PVOID pvData, LPDWORD pcbData);
  WINAPI_REG_ERROR          RegLoadKeyA(                                         HKEY hKey, LPCSTR lpSubKey, LPCSTR lpFile);
  WINAPI_REG_ERROR          RegLoadKeyW(                                         HKEY hKey, LPCWSTR lpSubKey, LPCWSTR lpFile);
  WINAPI_REG_ERROR          RegLoadMUIStringA(                                   HKEY hKey, LPCSTR pszValue, LPSTR pszOutBuf, DWORD cbOutBuf, LPDWORD pcbData, WINAPI_RegMuiFlags Flags, LPCSTR pszDirectory);
  WINAPI_REG_ERROR          RegLoadMUIStringW(                                   HKEY hKey, LPCWSTR pszValue, LPWSTR pszOutBuf, DWORD cbOutBuf, LPDWORD pcbData, WINAPI_RegMuiFlags Flags, LPCWSTR pszDirectory);
  WINAPI_REG_ERROR          RegNotifyChangeKeyValue(                             HKEY hKey, BOOL bWatchSubtree, WINAPI_RegNotifyFlags dwNotifyFilter, HANDLE hEvent, BOOL fAsynchronous);
  WINAPI_REG_ERROR          RegOpenCurrentUser(                                  REGSAM samDesired, PHKEY phkResult);
  WINAPI_REG_ERROR          RegOpenKeyExA(                                       HKEY hKey, LPCSTR lpSubKey, DWORD ulOptions, REGSAM samDesired, PHKEY phkResult);
  WINAPI_REG_ERROR          RegOpenKeyExW(                                       HKEY hKey, LPCWSTR lpSubKey, DWORD ulOptions, REGSAM samDesired, PHKEY phkResult);
  WINAPI_REG_ERROR          RegOpenKeyTransactedA(                               HKEY hKey, LPCSTR lpSubKey, DWORD ulOptions, REGSAM samDesired, PHKEY phkResult, HANDLE hTransaction, PVOID pExtendedParameter);
  WINAPI_REG_ERROR          RegOpenKeyTransactedW(                               HKEY hKey, LPCWSTR lpSubKey, DWORD ulOptions, REGSAM samDesired, PHKEY phkResult, HANDLE hTransaction, PVOID pExtendedParameter);
  WINAPI_REG_ERROR          RegOpenUserClassesRoot(                              HANDLE hToken, DWORD dwOptions, REGSAM samDesired, PHKEY phkResult);
  WINAPI_REG_ERROR          RegOverridePredefKey(                                HKEY hKey, HKEY hNewHKey);
  WINAPI_REG_ERROR          RegQueryInfoKeyA(                                    HKEY hKey, LPSTR lpClass, LPDWORD lpcClass, LPDWORD lpReserved, LPDWORD lpcSubKeys, LPDWORD lpcMaxSubKeyLen, LPDWORD lpcMaxClassLen, LPDWORD lpcValues, LPDWORD lpcMaxValueNameLen, LPDWORD lpcMaxValueLen, LPDWORD lpcbSecurityDescriptor, PFILETIME lpftLastWriteTime);
  WINAPI_REG_ERROR          RegQueryInfoKeyW(                                    HKEY hKey, LPWSTR lpClass, LPDWORD lpcClass, LPDWORD lpReserved, LPDWORD lpcSubKeys, LPDWORD lpcMaxSubKeyLen, LPDWORD lpcMaxClassLen, LPDWORD lpcValues, LPDWORD lpcMaxValueNameLen, LPDWORD lpcMaxValueLen, LPDWORD lpcbSecurityDescriptor, PFILETIME lpftLastWriteTime);
  WINAPI_REG_ERROR          RegQueryMultipleValuesA(                             HKEY hKey, PVALENTA val_list, DWORD num_vals, LPVOID lpValueBuf, LPDWORD ldwTotsize);
  WINAPI_REG_ERROR          RegQueryMultipleValuesW(                             HKEY hKey, PVALENTW val_list, DWORD num_vals, LPVOID lpValueBuf, LPDWORD ldwTotsize);
  WINAPI_REG_ERROR          RegQueryReflectionKey(                               HKEY hBase, BOOL* bIsReflectionDisabled);
  WINAPI_REG_ERROR          RegQueryValueExA(                                    HKEY hKey, LPCSTR lpValueName, LPDWORD lpReserved, WINAPI_RegType* lpType, LPBYTE lpData, LPDWORD lpcbData);
  WINAPI_REG_ERROR          RegQueryValueExW(                                    HKEY hKey, LPCWSTR lpValueName, LPDWORD lpReserved, WINAPI_RegType* lpType, LPBYTE lpData, LPDWORD lpcbData);
  WINAPI_REG_ERROR          RegReplaceKeyA(                                      HKEY hKey, LPCSTR lpSubKey, LPCSTR lpNewFile, LPCSTR lpOldFile);
  WINAPI_REG_ERROR          RegReplaceKeyW(                                      HKEY hKey, LPCWSTR lpSubKey, LPCWSTR lpNewFile, LPCWSTR lpOldFile);
  WINAPI_REG_ERROR          RegRestoreKeyA(                                      HKEY hKey, LPCSTR lpFile, DWORD dwFlags);
  WINAPI_REG_ERROR          RegRestoreKeyW(                                      HKEY hKey, LPCWSTR lpFile, DWORD dwFlags);
  WINAPI_REG_ERROR          RegSaveKeyA(                                         HKEY hKey, LPCSTR lpFile, LPSECURITY_ATTRIBUTES lpSecurityAttributes);
  WINAPI_REG_ERROR          RegSaveKeyW(                                         HKEY hKey, LPCWSTR lpFile, LPSECURITY_ATTRIBUTES lpSecurityAttributes);
  WINAPI_REG_ERROR          RegSaveKeyExA(                                       HKEY hKey, LPCSTR lpFile, LPSECURITY_ATTRIBUTES lpSecurityAttributes, DWORD Flags);
  WINAPI_REG_ERROR          RegSaveKeyExW(                                       HKEY hKey, LPCWSTR lpFile, LPSECURITY_ATTRIBUTES lpSecurityAttributes, DWORD Flags);
  WINAPI_REG_ERROR          RegSetKeyValueA(                                     HKEY hKey, LPCSTR lpSubKey, LPCSTR lpValueName, WINAPI_RegType dwType, LPCVOID lpData, DWORD cbData);
  WINAPI_REG_ERROR          RegSetKeyValueW(                                     HKEY hKey, LPCWSTR lpSubKey, LPCWSTR lpValueName, WINAPI_RegType dwType, LPCVOID lpData, DWORD cbData);
  WINAPI_REG_ERROR          RegSetValueExA(                                      HKEY hKey, LPCSTR lpValueName, DWORD Reserved, WINAPI_RegType dwType, const BYTE* lpData, DWORD cbData);
  WINAPI_REG_ERROR          RegSetValueExW(                                      HKEY hKey, LPCWSTR lpValueName, DWORD Reserved, WINAPI_RegType dwType, const BYTE* lpData, DWORD cbData);
  WINAPI_REG_ERROR          RegUnLoadKeyA(                                       HKEY hKey, LPCSTR lpSubKey);
  WINAPI_REG_ERROR          RegUnLoadKeyW(                                       HKEY hKey, LPCWSTR lpSubKey);
  WINAPI_REG_ERROR          RegCreateKeyA(                                       HKEY hKey, LPCSTR lpSubKey, PHKEY phkResult);
  WINAPI_REG_ERROR          RegCreateKeyW(                                       HKEY hKey, LPCWSTR lpSubKey, PHKEY phkResult);
  WINAPI_REG_ERROR          RegEnumKeyA(                                         HKEY hKey, DWORD dwIndex, LPSTR lpName, DWORD cchName);
  WINAPI_REG_ERROR          RegEnumKeyW(                                         HKEY hKey, DWORD dwIndex, LPWSTR lpName, DWORD cchName);
  WINAPI_REG_ERROR          RegOpenKeyA(                                         HKEY hKey, LPCSTR lpSubKey, PHKEY phkResult);
  WINAPI_REG_ERROR          RegOpenKeyW(                                         HKEY hKey, LPCWSTR lpSubKey, PHKEY phkResult);
  WINAPI_REG_ERROR          RegQueryValueA(                                      HKEY hKey, LPCSTR lpSubKey, LPSTR lpValue, PLONG lpcbValue);
  WINAPI_REG_ERROR          RegQueryValueW(                                      HKEY hKey, LPCWSTR lpSubKey, LPWSTR lpValue, PLONG lpcbValue);
  WINAPI_REG_ERROR          RegSetValueA(                                        HKEY hKey, LPCSTR lpSubKey, WINAPI_RegType dwType, LPCSTR lpData, DWORD cbData);
  WINAPI_REG_ERROR          RegSetValueW(                                        HKEY hKey, LPCWSTR lpSubKey, WINAPI_RegType dwType, LPCWSTR lpData, DWORD cbData);
  WINAPI_ERROR_CODE         AddUsersToEncryptedFile(                             LPCWSTR lpFileName, PENCRYPTION_CERTIFICATE_LIST pUsers);
  void                      CloseEncryptedFileRaw(                               PVOID pvContext);
  BOOL                      DecryptFileA(                                        LPCSTR lpFileName, DWORD dwReserved);
  BOOL                      DecryptFileW(                                        LPCWSTR lpFileName, DWORD dwReserved);
  WINAPI_ERROR_CODE         DuplicateEncryptionInfoFile(                         LPCWSTR SrcFileName, LPCWSTR DstFileName, DWORD dwCreationDistribution, DWORD dwAttributes, const LPSECURITY_ATTRIBUTES lpSecurityAttributes);
  BOOL                      EncryptFileA(                                        LPCSTR lpFileName);
  BOOL                      EncryptFileW(                                        LPCWSTR lpFileName);
  BOOL                      EncryptionDisable(                                   LPCWSTR DirPath, BOOL Disable);
  BOOL                      FileEncryptionStatusA(                               LPCSTR lpFileName, LPDWORD lpStatus);
  BOOL                      FileEncryptionStatusW(                               LPCWSTR lpFileName, LPDWORD lpStatus);
  void                      FreeEncryptionCertificateHashList(                   PENCRYPTION_CERTIFICATE_HASH_LIST pHashes);
  WINAPI_ERROR_CODE         OpenEncryptedFileRawA(                               LPCSTR lpFileName, ULONG ulFlags, PVOID* pvContext);
  WINAPI_ERROR_CODE         OpenEncryptedFileRawW(                               LPCWSTR lpFileName, ULONG ulFlags, PVOID* pvContext);
  WINAPI_ERROR_CODE         QueryRecoveryAgentsOnEncryptedFile(                  LPCWSTR lpFileName, PENCRYPTION_CERTIFICATE_HASH_LIST* pRecoveryAgents);
  WINAPI_ERROR_CODE         QueryUsersOnEncryptedFile(                           LPCWSTR lpFileName, PENCRYPTION_CERTIFICATE_HASH_LIST* pUsers);
  WINAPI_ERROR_CODE         ReadEncryptedFileRaw(                                PFE_EXPORT_FUNC pfExportCallback, PVOID pvCallbackContext, PVOID pvContext);
  WINAPI_ERROR_CODE         RemoveUsersFromEncryptedFile(                        LPCWSTR lpFileName, PENCRYPTION_CERTIFICATE_HASH_LIST pHashes);
  WINAPI_ERROR_CODE         SetUserFileEncryptionKey(                            PENCRYPTION_CERTIFICATE pEncryptionCertificate);
  WINAPI_ERROR_CODE         WriteEncryptedFileRaw(                               PFE_IMPORT_FUNC pfImportCallback, PVOID pvCallbackContext, PVOID pvContext);
  BOOL                      CreateProcessAsUserA(                                HANDLE hToken, LPCSTR lpApplicationName, LPSTR lpCommandLine, LPSECURITY_ATTRIBUTES lpProcessAttributes, LPSECURITY_ATTRIBUTES lpThreadAttributes, BOOL bInheritHandles, WINAPI_CreateProcessFlags dwCreationFlags, LPVOID lpEnvironment, LPCSTR lpCurrentDirectory, LPSTARTUPINFOA lpStartupInfo, LPPROCESS_INFORMATION lpProcessInformation);
  BOOL                      CreateProcessAsUserW(                                HANDLE hToken, LPCWSTR lpApplicationName, LPWSTR lpCommandLine, LPSECURITY_ATTRIBUTES lpProcessAttributes, LPSECURITY_ATTRIBUTES lpThreadAttributes, BOOL bInheritHandles, WINAPI_CreateProcessFlags dwCreationFlags, LPVOID lpEnvironment, LPCWSTR lpCurrentDirectory, LPSTARTUPINFOW lpStartupInfo, LPPROCESS_INFORMATION lpProcessInformation);
  BOOL                      CreateProcessWithLogonW(                             LPCWSTR lpUsername, LPCWSTR lpDomain, LPCWSTR lpPassword, WINAPI_LogonFlags dwLogonFlags, LPCWSTR lpApplicationName, LPWSTR lpCommandLine, WINAPI_CreateProcessFlags dwCreationFlags, LPVOID lpEnvironment, LPCWSTR lpCurrentDirectory, LPSTARTUPINFOW lpStartupInfo, LPPROCESS_INFORMATION lpProcessInfo);
  BOOL                      CreateProcessWithTokenW(                             HANDLE hToken, WINAPI_LogonFlags dwLogonFlags, LPCWSTR lpApplicationName, LPWSTR lpCommandLine, WINAPI_CreateProcessFlags dwCreationFlags, LPVOID lpEnvironment, LPCWSTR lpCurrentDirectory, LPSTARTUPINFOW lpStartupInfo, LPPROCESS_INFORMATION lpProcessInfo);
  WINAPI_ERROR_CODE         GetLocalManagedApplications(                         BOOL bUserApps, LPDWORD pdwApps, PLOCALMANAGEDAPPLICATION* prgLocalApps);
  WINAPI_ERROR_CODE         GetManagedApplications(                              GUID* pCategory, DWORD dwQueryFlags, DWORD dwInfoLevel, LPDWORD pdwApps, PMANAGEDAPPLICATION* prgManagedApps);
  WINAPI_ERROR_CODE         GetManagedApplicationCategories(                     DWORD dwReserved, APPCATEGORYINFOLIST* pAppCategory);
  WINAPI_ERROR_CODE         InstallApplication(                                  PINSTALLDATA* pInstallInfo);
  WINAPI_ERROR_CODE         UninstallApplication(                                WCHAR* ProductCode, DWORD dwStatus);
  BOOL                      AbortSystemShutdownA(                                LPSTR lpMachineName);
  BOOL                      AbortSystemShutdownW(                                LPWSTR lpMachineName);
  WINAPI_ERROR_CODE         InitiateShutdownA(                                   LPSTR lpMachineName, LPSTR lpMessage, DWORD dwGracePeriod, WINAPI_SHUTDOWN_FLAGS dwShutdownFlags, WINAPI_SHTDN_REASON dwReason);
  WINAPI_ERROR_CODE         InitiateShutdownW(                                   LPWSTR lpMachineName, LPWSTR lpMessage, DWORD dwGracePeriod, WINAPI_SHUTDOWN_FLAGS dwShutdownFlags, WINAPI_SHTDN_REASON dwReason);
  BOOL                      InitiateSystemShutdownA(                             LPSTR lpMachineName, LPSTR lpMessage, DWORD dwTimeout, BOOL bForceAppsClosed, BOOL bRebootAfterShutdown);
  BOOL                      InitiateSystemShutdownW(                             LPWSTR lpMachineName, LPWSTR lpMessage, DWORD dwTimeout, BOOL bForceAppsClosed, BOOL bRebootAfterShutdown);
  BOOL                      InitiateSystemShutdownExA(                           LPSTR lpMachineName, LPSTR lpMessage, DWORD dwTimeout, BOOL bForceAppsClosed, BOOL bRebootAfterShutdown, WINAPI_SHTDN_REASON dwReason);
  BOOL                      InitiateSystemShutdownExW(                           LPWSTR lpMachineName, LPWSTR lpMessage, DWORD dwTimeout, BOOL bForceAppsClosed, BOOL bRebootAfterShutdown, WINAPI_SHTDN_REASON dwReason);
  BOOL                      BackupEventLogA(                                     HANDLE hEventLog, LPCSTR lpBackupFileName);
  BOOL                      BackupEventLogW(                                     HANDLE hEventLog, LPCWSTR lpBackupFileName);
  BOOL                      ClearEventLogA(                                      HANDLE hEventLog, LPCSTR lpBackupFileName);
  BOOL                      ClearEventLogW(                                      HANDLE hEventLog, LPCWSTR lpBackupFileName);
  BOOL                      CloseEventLog(                                       HANDLE hEventLog);
  BOOL                      DeregisterEventSource(                               HANDLE hEventLog);
  BOOL                      GetEventLogInformation(                              HANDLE hEventLog, DWORD dwInfoLevel, LPVOID lpBuffer, DWORD cbBufSize, LPDWORD pcbBytesNeeded);
  BOOL                      GetNumberOfEventLogRecords(                          HANDLE hEventLog, PDWORD NumberOfRecords);
  BOOL                      GetOldestEventLogRecord(                             HANDLE hEventLog, PDWORD OldestRecord);
  BOOL                      NotifyChangeEventLog(                                HANDLE hEventLog, HANDLE hEvent);
  HANDLE                    OpenBackupEventLogA(                                 LPCSTR lpUNCServerName, LPCSTR lpFileName);
  HANDLE                    OpenBackupEventLogW(                                 LPCWSTR lpUNCServerName, LPCWSTR lpFileName);
  HANDLE                    OpenEventLogA(                                       LPCSTR lpUNCServerName, LPCSTR lpSourceName);
  HANDLE                    OpenEventLogW(                                       LPCWSTR lpUNCServerName, LPCWSTR lpSourceName);
  BOOL                      ReadEventLogA(                                       HANDLE hEventLog, DWORD dwReadFlags, DWORD dwRecordOffset, LPVOID lpBuffer, DWORD nNumberOfBytesToRead, DWORD* pnBytesRead, DWORD* pnMinNumberOfBytesNeeded);
  BOOL                      ReadEventLogW(                                       HANDLE hEventLog, DWORD dwReadFlags, DWORD dwRecordOffset, LPVOID lpBuffer, DWORD nNumberOfBytesToRead, DWORD* pnBytesRead, DWORD* pnMinNumberOfBytesNeeded);
  HANDLE                    RegisterEventSourceA(                                LPCSTR lpUNCServerName, LPCSTR lpSourceName);
  HANDLE                    RegisterEventSourceW(                                LPCWSTR lpUNCServerName, LPCWSTR lpSourceName);
  BOOL                      ReportEventA(                                        HANDLE hEventLog, WINAPI_EventLogType wType, WORD wCategory, DWORD dwEventID, PSID lpUserSid, WORD wNumStrings, DWORD dwDataSize, LPCSTR* lpStrings, LPVOID lpRawData);
  BOOL                      ReportEventW(                                        HANDLE hEventLog, WINAPI_EventLogType wType, WORD wCategory, DWORD dwEventID, PSID lpUserSid, WORD wNumStrings, DWORD dwDataSize, LPCWSTR* lpStrings, LPVOID lpRawData);
  PPERF_COUNTERSET_INSTANCE PerfCreateInstance(                                  HANDLE hProvider, LPCGUID CounterSetGuid, LPCWSTR szInstanceName, ULONG dwInstance);
  WINAPI_ERROR_CODE_ULONG   PerfDecrementULongCounterValue(                      HANDLE hProvider, PPERF_COUNTERSET_INSTANCE pInstance, ULONG CounterId, ULONG lValue);
  WINAPI_ERROR_CODE_ULONG   PerfDecrementULongLongCounterValue(                  HANDLE hProvider, PPERF_COUNTERSET_INSTANCE pInstance, ULONG CounterId, ULONGLONG llValue);
  WINAPI_ERROR_CODE_ULONG   PerfDeleteInstance(                                  HANDLE hProvider, PPERF_COUNTERSET_INSTANCE InstanceBlock);
  WINAPI_ERROR_CODE_ULONG   PerfIncrementULongCounterValue(                      HANDLE hProvider, PPERF_COUNTERSET_INSTANCE pInstance, ULONG CounterId, ULONG lValue);
  WINAPI_ERROR_CODE_ULONG   PerfIncrementULongLongCounterValue(                  HANDLE hProvider, PPERF_COUNTERSET_INSTANCE pInstance, ULONG CounterId, ULONGLONG llValue);
  PPERF_COUNTERSET_INSTANCE PerfQueryInstance(                                   HANDLE hProvider, LPCGUID CounterSetGuid, LPCWSTR szInstance, ULONG dwInstance);
  WINAPI_ERROR_CODE_ULONG   PerfSetCounterSetInfo(                               HANDLE hProvider, PPERF_COUNTERSET_INFO pTemplate, ULONG dwTemplateSize);
  WINAPI_ERROR_CODE_ULONG   PerfSetULongCounterValue(                            HANDLE hProvider, PPERF_COUNTERSET_INSTANCE pInstance, ULONG CounterId, ULONG lValue);
  WINAPI_ERROR_CODE_ULONG   PerfSetULongLongCounterValue(                        HANDLE hProvider, PPERF_COUNTERSET_INSTANCE pInstance, ULONG CounterId, ULONGLONG llValue);
  WINAPI_ERROR_CODE_ULONG   PerfSetCounterRefValue(                              HANDLE hProvider, PPERF_COUNTERSET_INSTANCE pInstance, ULONG CounterId, PVOID lpAddr);
  WINAPI_ERROR_CODE_ULONG   PerfStartProvider(                                   LPGUID ProviderGuid, PERFLIBREQUEST ControlCallback, HANDLE* phProvider);
  WINAPI_ERROR_CODE_ULONG   PerfStartProviderEx(                                 LPGUID ProviderGuid, PPERF_PROVIDER_CONTEXT ProviderContext, HANDLE* phProvider);
  WINAPI_ERROR_CODE_ULONG   PerfStopProvider(                                    HANDLE hProvider);
  SERVICE_STATUS_HANDLE     RegisterServiceCtrlHandlerA(                         LPCSTR lpServiceName, LPHANDLER_FUNCTION lpHandlerProc);
  SERVICE_STATUS_HANDLE     RegisterServiceCtrlHandlerW(                         LPCWSTR lpServiceName, LPHANDLER_FUNCTION lpHandlerProc);
  SERVICE_STATUS_HANDLE     RegisterServiceCtrlHandlerExA(                       LPCSTR lpServiceName, LPHANDLER_FUNCTION_EX lpHandlerProc, LPVOID lpContext);
  SERVICE_STATUS_HANDLE     RegisterServiceCtrlHandlerExW(                       LPCWSTR lpServiceName, LPHANDLER_FUNCTION_EX lpHandlerProc, LPVOID lpContext);
  BOOL                      SetServiceBits(                                      SERVICE_STATUS_HANDLE hServiceStatus, DWORD dwServiceBits, BOOL bSetBitsOn, BOOL bUpdateImmediately);
  BOOL                      SetServiceStatus(                                    SERVICE_STATUS_HANDLE hServiceStatus, LPSERVICE_STATUS lpServiceStatus);
  BOOL                      StartServiceCtrlDispatcherA(                         const SERVICE_TABLE_ENTRYA* lpServiceTable);
  BOOL                      StartServiceCtrlDispatcherW(                         const SERVICE_TABLE_ENTRYW* lpServiceTable);
  BOOL                      ChangeServiceConfigA(                                SC_HANDLE hService, WINAPI_ServiceType dwServiceType, WINAPI_ServiceStartType dwStartType, WINAPI_ServiceErrorControl dwErrorControl, LPCSTR lpBinaryPathName, LPCSTR lpLoadOrderGroup, LPDWORD lpdwTagId, LPCSTR lpDependencies, LPCSTR lpServiceStartName, LPCSTR lpPassword, LPCSTR lpDisplayName);
  BOOL                      ChangeServiceConfigW(                                SC_HANDLE hService, WINAPI_ServiceType dwServiceType, WINAPI_ServiceStartType dwStartType, WINAPI_ServiceErrorControl dwErrorControl, LPCWSTR lpBinaryPathName, LPCWSTR lpLoadOrderGroup, LPDWORD lpdwTagId, LPCWSTR lpDependencies, LPCWSTR lpServiceStartName, LPCWSTR lpPassword, LPCWSTR lpDisplayName);
  BOOL                      ChangeServiceConfig2A(                               SC_HANDLE hService, WINAPI_ServiceInfoLevel dwInfoLevel, LPVOID lpInfo);
  BOOL                      ChangeServiceConfig2W(                               SC_HANDLE hService, WINAPI_ServiceInfoLevel dwInfoLevel, LPVOID lpInfo);
  BOOL                      CloseServiceHandle(                                  SC_HANDLE hSCObject);
  BOOL                      ControlService(                                      SC_HANDLE hService, WINAPI_ServiceControl dwControl, LPSERVICE_STATUS lpServiceStatus);
  BOOL                      ControlServiceExA(                                   SC_HANDLE hService, DWORD dwControl, DWORD dwInfoLevel, PVOID pControlParams);
  BOOL                      ControlServiceExW(                                   SC_HANDLE hService, DWORD dwControl, DWORD dwInfoLevel, PVOID pControlParams);
  SC_HANDLE                 CreateServiceA(                                      SC_HANDLE hSCManager, LPCSTR lpServiceName, LPCSTR lpDisplayName, WINAPI_ServiceAccess dwDesiredAccess, WINAPI_ServiceType dwServiceType, WINAPI_ServiceStartType dwStartType, WINAPI_ServiceErrorControl dwErrorControl, LPCSTR lpBinaryPathName, LPCSTR lpLoadOrderGroup, LPDWORD lpdwTagId, LPCSTR lpDependencies, LPCSTR lpServiceStartName, LPCSTR lpPassword);
  SC_HANDLE                 CreateServiceW(                                      SC_HANDLE hSCManager, LPCWSTR lpServiceName, LPCWSTR lpDisplayName, WINAPI_ServiceAccess dwDesiredAccess, WINAPI_ServiceType dwServiceType, WINAPI_ServiceStartType dwStartType, WINAPI_ServiceErrorControl dwErrorControl, LPCWSTR lpBinaryPathName, LPCWSTR lpLoadOrderGroup, LPDWORD lpdwTagId, LPCWSTR lpDependencies, LPCWSTR lpServiceStartName, LPCWSTR lpPassword);
  BOOL                      DeleteService(                                       SC_HANDLE hService);
  BOOL                      EnumDependentServicesA(                              SC_HANDLE hService, WINAPI_ServiceState dwServiceState, LPENUM_SERVICE_STATUSA lpServices, DWORD cbBufSize, LPDWORD pcbBytesNeeded, LPDWORD lpServicesReturned);
  BOOL                      EnumDependentServicesW(                              SC_HANDLE hService, WINAPI_ServiceState dwServiceState, LPENUM_SERVICE_STATUSW lpServices, DWORD cbBufSize, LPDWORD pcbBytesNeeded, LPDWORD lpServicesReturned);
  BOOL                      EnumServicesStatusExA(                               SC_HANDLE hSCManager, SC_ENUM_TYPE InfoLevel, WINAPI_ServiceType dwServiceType, WINAPI_ServiceState dwServiceState, LPBYTE lpServices, DWORD cbBufSize, LPDWORD pcbBytesNeeded, LPDWORD lpServicesReturned, LPDWORD lpResumeHandle, LPCSTR pszGroupName);
  BOOL                      EnumServicesStatusExW(                               SC_HANDLE hSCManager, SC_ENUM_TYPE InfoLevel, WINAPI_ServiceType dwServiceType, WINAPI_ServiceState dwServiceState, LPBYTE lpServices, DWORD cbBufSize, LPDWORD pcbBytesNeeded, LPDWORD lpServicesReturned, LPDWORD lpResumeHandle, LPCWSTR pszGroupName);
  BOOL                      GetServiceDisplayNameA(                              SC_HANDLE hSCManager, LPCSTR lpServiceName, LPSTR lpDisplayName, LPDWORD lpcchBuffer);
  BOOL                      GetServiceDisplayNameW(                              SC_HANDLE hSCManager, LPCWSTR lpServiceName, LPWSTR lpDisplayName, LPDWORD lpcchBuffer);
  BOOL                      GetServiceKeyNameA(                                  SC_HANDLE hSCManager, LPCSTR lpDisplayName, LPSTR lpServiceName, LPDWORD lpcchBuffer);
  BOOL                      GetServiceKeyNameW(                                  SC_HANDLE hSCManager, LPCWSTR lpDisplayName, LPWSTR lpServiceName, LPDWORD lpcchBuffer);
  BOOL                      NotifyBootConfigStatus(                              BOOL BootAcceptable);
  WINAPI_ERROR_CODE         NotifyServiceStatusChangeA(                          SC_HANDLE hService, WINAPI_ServiceNotifyMask dwNotifyMask, PSERVICE_NOTIFYA pNotifyBuffer);
  WINAPI_ERROR_CODE         NotifyServiceStatusChangeW(                          SC_HANDLE hService, WINAPI_ServiceNotifyMask dwNotifyMask, PSERVICE_NOTIFYW pNotifyBuffer);
  SC_HANDLE                 OpenSCManagerA(                                      LPCSTR lpMachineName, LPCSTR lpDatabaseName, WINAPI_SCManagerAccess dwDesiredAccess);
  SC_HANDLE                 OpenSCManagerW(                                      LPCWSTR lpMachineName, LPCWSTR lpDatabaseName, WINAPI_SCManagerAccess dwDesiredAccess);
  SC_HANDLE                 OpenServiceA(                                        SC_HANDLE hSCManager, LPCSTR lpServiceName, WINAPI_ServiceAccess dwDesiredAccess);
  SC_HANDLE                 OpenServiceW(                                        SC_HANDLE hSCManager, LPCWSTR lpServiceName, WINAPI_ServiceAccess dwDesiredAccess);
  BOOL                      QueryServiceConfigA(                                 SC_HANDLE hService, LPQUERY_SERVICE_CONFIGA lpServiceConfig, DWORD cbBufSize, LPDWORD pcbBytesNeeded);
  BOOL                      QueryServiceConfigW(                                 SC_HANDLE hService, LPQUERY_SERVICE_CONFIGW lpServiceConfig, DWORD cbBufSize, LPDWORD pcbBytesNeeded);
  BOOL                      QueryServiceConfig2A(                                SC_HANDLE hService, WINAPI_ServiceInfoLevel dwInfoLevel, LPBYTE lpBuffer, DWORD cbBufSize, LPDWORD pcbBytesNeeded);
  BOOL                      QueryServiceConfig2W(                                SC_HANDLE hService, WINAPI_ServiceInfoLevel dwInfoLevel, LPBYTE lpBuffer, DWORD cbBufSize, LPDWORD pcbBytesNeeded);
  BOOL                      QueryServiceStatus(                                  SC_HANDLE hService, LPSERVICE_STATUS lpServiceStatus);
  BOOL                      QueryServiceStatusEx(                                SC_HANDLE hService, SC_STATUS_TYPE InfoLevel, LPBYTE lpBuffer, DWORD cbBufSize, LPDWORD pcbBytesNeeded);
  BOOL                      StartServiceA(                                       SC_HANDLE hService, DWORD dwNumServiceArgs, LPCSTR* lpServiceArgVectors);
  BOOL                      StartServiceW(                                       SC_HANDLE hService, DWORD dwNumServiceArgs, LPCWSTR* lpServiceArgVectors);
  BOOL                      EnumServicesStatusA(                                 SC_HANDLE hSCManager, WINAPI_ServiceType dwServiceType, WINAPI_ServiceState dwServiceState, LPENUM_SERVICE_STATUSA lpServices, DWORD cbBufSize, LPDWORD pcbBytesNeeded, LPDWORD lpServicesReturned, LPDWORD lpResumeHandle);
  BOOL                      EnumServicesStatusW(                                 SC_HANDLE hSCManager, WINAPI_ServiceType dwServiceType, WINAPI_ServiceState dwServiceState, LPENUM_SERVICE_STATUSW lpServices, DWORD cbBufSize, LPDWORD pcbBytesNeeded, LPDWORD lpServicesReturned, LPDWORD lpResumeHandle);
  SC_LOCK                   LockServiceDatabase(                                 SC_HANDLE hSCManager);
  BOOL                      QueryServiceLockStatusA(                             SC_HANDLE hSCManager, LPQUERY_SERVICE_LOCK_STATUSA lpLockStatus, DWORD cbBufSize, LPDWORD pcbBytesNeeded);
  BOOL                      QueryServiceLockStatusW(                             SC_HANDLE hSCManager, LPQUERY_SERVICE_LOCK_STATUSW lpLockStatus, DWORD cbBufSize, LPDWORD pcbBytesNeeded);
  BOOL                      UnlockServiceDatabase(                               SC_LOCK ScLock);
  BOOL                      GetCurrentHwProfileA(                                LPHW_PROFILE_INFOA lpHwProfileInfo);
  BOOL                      GetCurrentHwProfileW(                                LPHW_PROFILE_INFOW lpHwProfileInfo);
  BOOL                      GetUserNameA(                                        LPSTR lpBuffer, LPDWORD lpnSize);
  BOOL                      GetUserNameW(                                        LPWSTR lpBuffer, LPDWORD lpnSize);
  BOOL                      IsTextUnicode(                                       const VOID* lpv, int iSize, WINAPI_IsTextUnicodeFlags* lpiResult);
  BOOL                      CryptAcquireContextA(                                HCRYPTPROV* phProv, LPCSTR pszContainer, LPCSTR pszProvider, WINAPI_CryptProv dwProvType, WINAPI_CryptAcquireContextFlags dwFlags);
  BOOL                      CryptAcquireContextW(                                HCRYPTPROV* phProv, LPCWSTR pszContainer, LPCWSTR pszProvider, WINAPI_CryptProv dwProvType, WINAPI_CryptAcquireContextFlags dwFlags);
  BOOL                      CryptContextAddRef(                                  HCRYPTPROV hProv, DWORD* pdwReserved, DWORD dwFlags);
  BOOL                      CryptEnumProvidersA(                                 DWORD dwIndex, DWORD* pdwReserved, DWORD dwFlags, WINAPI_CryptProv* pdwProvType, LPSTR pszProvName, DWORD* pcbProvName);
  BOOL                      CryptEnumProvidersW(                                 DWORD dwIndex, DWORD* pdwReserved, DWORD dwFlags, WINAPI_CryptProv* pdwProvType, LPWSTR pszProvName, DWORD* pcbProvName);
  BOOL                      CryptEnumProviderTypesA(                             DWORD dwIndex, DWORD* pdwReserved, DWORD dwFlags, WINAPI_CryptProv* pdwProvType, LPSTR pszTypeName, DWORD* pcbTypeName);
  BOOL                      CryptEnumProviderTypesW(                             DWORD dwIndex, DWORD* pdwReserved, DWORD dwFlags, WINAPI_CryptProv* pdwProvType, LPWSTR pszTypeName, DWORD* pcbTypeName);
  BOOL                      CryptGetDefaultProviderA(                            WINAPI_CryptProv dwProvType, DWORD* pdwReserved, DWORD dwFlags, LPSTR pszProvName, DWORD* pcbProvName);
  BOOL                      CryptGetDefaultProviderW(                            WINAPI_CryptProv dwProvType, DWORD* pdwReserved, DWORD dwFlags, LPWSTR pszProvName, DWORD* pcbProvName);
  BOOL                      CryptGetProvParam(                                   HCRYPTPROV hProv, WINAPI_CryptGetProvParam dwParam, BYTE* pbData, DWORD* pdwDataLen, DWORD dwFlags);
  BOOL                      CryptReleaseContext(                                 HCRYPTPROV hProv, DWORD dwFlags);
  BOOL                      CryptSetProviderA(                                   LPCSTR pszProvName, WINAPI_CryptProv dwProvType);
  BOOL                      CryptSetProviderW(                                   LPCWSTR pszProvName, WINAPI_CryptProv dwProvType);
  BOOL                      CryptSetProviderExA(                                 LPCSTR pszProvName, WINAPI_CryptProv dwProvType, DWORD* pdwReserved, DWORD dwFlags);
  BOOL                      CryptSetProviderExW(                                 LPCWSTR pszProvName, WINAPI_CryptProv dwProvType, DWORD* pdwReserved, DWORD dwFlags);
  BOOL                      CryptSetProvParam(                                   HCRYPTPROV hProv, WINAPI_CryptSetProvParam dwParam, const BYTE* pbData, DWORD dwFlags);
  BOOL                      CryptDeriveKey(                                      HCRYPTPROV hProv, ALG_ID Algid, HCRYPTHASH hBaseData, DWORD dwFlags, HCRYPTKEY* phKey);
  BOOL                      CryptDestroyKey(                                     HCRYPTKEY hKey);
  BOOL                      CryptDuplicateKey(                                   HCRYPTKEY hKey, DWORD* pdwReserved, DWORD dwFlags, HCRYPTKEY* phKey);
  BOOL                      CryptExportKey(                                      HCRYPTKEY hKey, HCRYPTKEY hExpKey, WINAPI_CryptBlobType dwBlobType, WINAPI_CryptExportKeyFlags dwFlags, BYTE* pbData, DWORD* pdwDataLen);
  BOOL                      CryptGenKey(                                         HCRYPTPROV hProv, ALG_ID Algid, DWORD dwFlags, HCRYPTKEY* phKey);
  BOOL                      CryptGenRandom(                                      HCRYPTPROV hProv, DWORD dwLen, BYTE* pbBuffer);
  BOOL                      CryptGetKeyParam(                                    HCRYPTKEY hKey, WINAPI_CryptKeyParam dwParam, BYTE* pbData, DWORD* pdwDataLen, DWORD dwFlags);
  BOOL                      CryptGetUserKey(                                     HCRYPTPROV hProv, WINAPI_CryptKeySpec dwKeySpec, HCRYPTKEY* phUserKey);
  BOOL                      CryptImportKey(                                      HCRYPTPROV hProv, BYTE* pbData, DWORD dwDataLen, HCRYPTKEY hPubKey, WINAPI_CryptImportKeyFlags dwFlags, HCRYPTKEY* phKey);
  BOOL                      CryptSetKeyParam(                                    HCRYPTKEY hKey, WINAPI_CryptKeyParam dwParam, const BYTE* pbData, DWORD dwFlags);
  BOOL                      CryptDecrypt(                                        HCRYPTKEY hKey, HCRYPTHASH hHash, BOOL Final, DWORD dwFlags, BYTE* pbData, DWORD* pdwDataLen);
  BOOL                      CryptEncrypt(                                        HCRYPTKEY hKey, HCRYPTHASH hHash, BOOL Final, DWORD dwFlags, BYTE* pbData, DWORD* pdwDataLen, DWORD dwBufLen);
  BOOL                      CryptCreateHash(                                     HCRYPTPROV hProv, ALG_ID Algid, HCRYPTKEY hKey, WINAPI_CryptCreateHashFlags dwFlags, HCRYPTHASH* phHash);
  BOOL                      CryptDestroyHash(                                    HCRYPTHASH hHash);
  BOOL                      CryptDuplicateHash(                                  HCRYPTHASH hHash, DWORD* pdwReserved, DWORD dwFlags, HCRYPTHASH* phHash);
  BOOL                      CryptGetHashParam(                                   HCRYPTHASH hHash, WINAPI_CryptHashParam dwParam, BYTE* pbData, DWORD* pdwDataLen, DWORD dwFlags);
  BOOL                      CryptHashData(                                       HCRYPTHASH hHash, BYTE* pbData, DWORD dwDataLen, WINAPI_CryptHashDataFlags dwFlags);
  BOOL                      CryptHashSessionKey(                                 HCRYPTHASH hHash, HCRYPTKEY hKey, DWORD dwFlags);
  BOOL                      CryptSetHashParam(                                   HCRYPTHASH hHash, WINAPI_CryptHashParam dwParam, const BYTE* pbData, DWORD dwFlags);
  BOOL                      CryptSignHashA(                                      HCRYPTHASH hHash, WINAPI_CryptKeySpec dwKeySpec, LPCSTR sDescription, WINAPI_CryptSignFlags dwFlags, BYTE* pbSignature, DWORD* pdwSigLen);
  BOOL                      CryptSignHashW(                                      HCRYPTHASH hHash, WINAPI_CryptKeySpec dwKeySpec, LPCWSTR sDescription, WINAPI_CryptSignFlags dwFlags, BYTE* pbSignature, DWORD* pdwSigLen);
  BOOL                      CryptVerifySignatureA(                               HCRYPTHASH hHash, BYTE* pbSignature, DWORD dwSigLen, HCRYPTKEY hPubKey, LPCSTR sDescription, WINAPI_CryptSignFlags dwFlags);
  BOOL                      CryptVerifySignatureW(                               HCRYPTHASH hHash, BYTE* pbSignature, DWORD dwSigLen, HCRYPTKEY hPubKey, LPCWSTR sDescription, WINAPI_CryptSignFlags dwFlags);
  WINAPI_ERROR_CODE_ULONG   ControlTraceA(                                       TRACEHANDLE SessionHandle, LPCSTR SessionName, PEVENT_TRACE_PROPERTIES Properties, ULONG ControlCode);
  WINAPI_ERROR_CODE_ULONG   ControlTraceW(                                       TRACEHANDLE SessionHandle, LPCWSTR SessionName, PEVENT_TRACE_PROPERTIES Properties, ULONG ControlCode);
  WINAPI_ERROR_CODE_ULONG   EnableTrace(                                         ULONG Enable, ULONG EnableFlag, ULONG EnableLevel, LPCGUID ControlGuid, TRACEHANDLE SessionHandle);
  WINAPI_ERROR_CODE_ULONG   EnableTraceEx(                                       LPCGUID ProviderId, LPCGUID SourceId, TRACEHANDLE TraceHandle, ULONG IsEnabled, UCHAR Level, ULONGLONG MatchAnyKeyword, ULONGLONG MatchAllKeyword, ULONG EnableProperty, PEVENT_FILTER_DESCRIPTOR EnableFilterDesc);
  WINAPI_ERROR_CODE_ULONG   EnableTraceEx2(                                      TRACEHANDLE TraceHandle, LPCGUID ProviderId, ULONG ControlCode, UCHAR Level, ULONGLONG MatchAnyKeyword, ULONGLONG MatchAllKeyword, ULONG Timeout, PENABLE_TRACE_PARAMETERS EnableParameters);
  WINAPI_ERROR_CODE_ULONG   EnumerateTraceGuids(                                 PTRACE_GUID_PROPERTIES* GuidPropertiesArray, ULONG PropertyArrayCount, PULONG GuidCount);
  WINAPI_ERROR_CODE_ULONG   EnumerateTraceGuidsEx(                               TRACE_QUERY_INFO_CLASS TraceQueryInfoClass, PVOID InBuffer, ULONG InBufferSize, PVOID OutBuffer, ULONG OutBufferSize, PULONG ReturnLength);
  WINAPI_ERROR_CODE_ULONG   FlushTraceA(                                         TRACEHANDLE SessionHandle, LPCSTR SessionName, PEVENT_TRACE_PROPERTIES Properties);
  WINAPI_ERROR_CODE_ULONG   FlushTraceW(                                         TRACEHANDLE SessionHandle, LPCWSTR SessionName, PEVENT_TRACE_PROPERTIES Properties);
  WINAPI_ERROR_CODE_ULONG   QueryAllTracesA(                                     PEVENT_TRACE_PROPERTIES* PropertyArray, ULONG PropertyArrayCount, PULONG SessionCount);
  WINAPI_ERROR_CODE_ULONG   QueryAllTracesW(                                     PEVENT_TRACE_PROPERTIES* PropertyArray, ULONG PropertyArrayCount, PULONG SessionCount);
  WINAPI_ERROR_CODE_ULONG   QueryTraceA(                                         TRACEHANDLE SessionHandle, LPCSTR SessionName, PEVENT_TRACE_PROPERTIES Properties);
  WINAPI_ERROR_CODE_ULONG   QueryTraceW(                                         TRACEHANDLE SessionHandle, LPCWSTR SessionName, PEVENT_TRACE_PROPERTIES Properties);
  WINAPI_ERROR_CODE_ULONG   StartTraceA(                                         PTRACEHANDLE SessionHandle, LPCSTR SessionName, PEVENT_TRACE_PROPERTIES Properties);
  WINAPI_ERROR_CODE_ULONG   StartTraceW(                                         PTRACEHANDLE SessionHandle, LPCWSTR SessionName, PEVENT_TRACE_PROPERTIES Properties);
  WINAPI_ERROR_CODE_ULONG   StopTraceA(                                          TRACEHANDLE SessionHandle, LPCSTR SessionName, PEVENT_TRACE_PROPERTIES Properties);
  WINAPI_ERROR_CODE_ULONG   StopTraceW(                                          TRACEHANDLE SessionHandle, LPCWSTR SessionName, PEVENT_TRACE_PROPERTIES Properties);
  WINAPI_ERROR_CODE_ULONG   TraceSetInformation(                                 TRACEHANDLE SessionHandle, TRACE_INFO_CLASS InformationClass, PVOID TraceInformation, ULONG InformationLength);
  WINAPI_ERROR_CODE_ULONG   UpdateTraceA(                                        TRACEHANDLE SessionHandle, LPCSTR SessionName, PEVENT_TRACE_PROPERTIES Properties);
  WINAPI_ERROR_CODE_ULONG   UpdateTraceW(                                        TRACEHANDLE SessionHandle, LPCWSTR SessionName, PEVENT_TRACE_PROPERTIES Properties);
  WINAPI_ERROR_CODE_ULONG   CreateTraceInstanceId(                               HANDLE RegHandle, PEVENT_INSTANCE_INFO pInstInfo);
  WINAPI_ERROR_CODE_ULONG   GetTraceEnableFlags(                                 TRACEHANDLE SessionHandle);
  UCHAR                     GetTraceEnableLevel(                                 TRACEHANDLE SessionHandle);
  TRACEHANDLE               GetTraceLoggerHandle(                                PVOID Buffer);
  WINAPI_ERROR_CODE_ULONG   RegisterTraceGuidsA(                                 WMIDPREQUEST RequestAddress, PVOID RequestContext, LPCGUID ControlGuid, ULONG GuidCount, PTRACE_GUID_REGISTRATION TraceGuidReg, LPCSTR MofImagePath, LPCSTR MofResourceName, PTRACEHANDLE RegistrationHandle);
  WINAPI_ERROR_CODE_ULONG   RegisterTraceGuidsW(                                 WMIDPREQUEST RequestAddress, PVOID RequestContext, LPCGUID ControlGuid, ULONG GuidCount, PTRACE_GUID_REGISTRATION TraceGuidReg, LPCWSTR MofImagePath, LPCWSTR MofResourceName, PTRACEHANDLE RegistrationHandle);
  WINAPI_ERROR_CODE_ULONG   TraceEvent(                                          TRACEHANDLE SessionHandle, PEVENT_TRACE_HEADER EventTrace);
  WINAPI_ERROR_CODE_ULONG   TraceEventInstance(                                  TRACEHANDLE SessionHandle, PEVENT_INSTANCE_HEADER EventTrace, PEVENT_INSTANCE_INFO pInstInfo, PEVENT_INSTANCE_INFO pParentInstInfo);
  WINAPI_ERROR_CODE_ULONG   TraceMessage(                                        TRACEHANDLE SessionHandle, WINAPI_TRACE_MESSAGE_FLAGS MessageFlags, LPGUID MessageGuid, USHORT MessageNumber);
  WINAPI_ERROR_CODE_ULONG   TraceMessageVa(                                      TRACEHANDLE SessionHandle, ULONG MessageFlags, LPGUID MessageGuid, USHORT MessageNumber, va_list MessageArgList);
  WINAPI_ERROR_CODE_ULONG   UnregisterTraceGuids(                                TRACEHANDLE RegistrationHandle);
  WINAPI_ERROR_CODE_ULONG   EventActivityIdControl(                              WINAPI_EventActivity ControlCode, LPGUID ActivityId);
  WINAPI_ERROR_CODE_ULONG   EventWriteTransfer(                                  REGHANDLE RegHandle, PCEVENT_DESCRIPTOR EventDescriptor, LPCGUID ActivityId, LPCGUID RelatedActivityId, ULONG UserDataCount, PEVENT_DATA_DESCRIPTOR UserData);
  BOOLEAN                   EventEnabled(                                        REGHANDLE RegHandle, PCEVENT_DESCRIPTOR EventDescriptor);
  BOOLEAN                   EventProviderEnabled(                                REGHANDLE RegHandle, UCHAR Level, ULONGLONG Keyword);
  WINAPI_ERROR_CODE_ULONG   EventRegister(                                       LPCGUID ProviderId, ENABLECALLBACK EnableCallback, PVOID CallbackContext, PREGHANDLE RegHandle);
  WINAPI_ERROR_CODE_ULONG   EventUnregister(                                     REGHANDLE RegHandle);
  WINAPI_ERROR_CODE_ULONG   EventWrite(                                          REGHANDLE RegHandle, PCEVENT_DESCRIPTOR EventDescriptor, ULONG UserDataCount, PEVENT_DATA_DESCRIPTOR UserData);
  WINAPI_ERROR_CODE_ULONG   EventWriteString(                                    REGHANDLE RegHandle, UCHAR Level, ULONGLONG Keyword, PCWSTR String);
  WINAPI_ERROR_CODE_ULONG   CloseTrace(                                          TRACEHANDLE TraceHandle);
  TRACEHANDLE               OpenTraceA(                                           PEVENT_TRACE_LOGFILEA Logfile);
  TRACEHANDLE               OpenTraceW(                                           PEVENT_TRACE_LOGFILEW Logfile);
  WINAPI_ERROR_CODE_ULONG   ProcessTrace(                                        PTRACEHANDLE HandleArray, ULONG HandleCount, LPFILETIME StartTime, LPFILETIME EndTime);
  WINAPI_ERROR_CODE_ULONG   RemoveTraceCallback(                                 LPCGUID pGuid);
  WINAPI_ERROR_CODE_ULONG   SetTraceCallback(                                    LPCGUID pGuid, PEVENT_CALLBACK EventCallback);
  WINAPI_ERROR_CODE_ULONG   EventAccessControl(                                  LPGUID Guid, ULONG Operation, PSID Sid, ULONG Rights, BOOLEAN AllowOrDeny);
  WINAPI_ERROR_CODE_ULONG   EventAccessQuery(                                    LPGUID Guid, PSECURITY_DESCRIPTOR Buffer, PULONG BufferSize);
  WINAPI_ERROR_CODE_ULONG   EventAccessRemove(                                   LPGUID Guid);
  BOOL                      AccessCheck(                                         PSECURITY_DESCRIPTOR pSecurityDescriptor, HANDLE ClientToken, DWORD DesiredAccess, PGENERIC_MAPPING GenericMapping, PPRIVILEGE_SET PrivilegeSet, LPDWORD PrivilegeSetLength, LPDWORD GrantedAccess, LPBOOL AccessStatus);
  BOOL                      AccessCheckByType(                                   PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID PrincipalSelfSid, HANDLE ClientToken, DWORD DesiredAccess, POBJECT_TYPE_LIST ObjectTypeList, DWORD ObjectTypeListLength, PGENERIC_MAPPING GenericMapping, PPRIVILEGE_SET PrivilegeSet, LPDWORD PrivilegeSetLength, LPDWORD GrantedAccess, LPBOOL AccessStatus);
  BOOL                      AccessCheckByTypeResultList(                         PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID PrincipalSelfSid, HANDLE ClientToken, DWORD DesiredAccess, POBJECT_TYPE_LIST ObjectTypeList, DWORD ObjectTypeListLength, PGENERIC_MAPPING GenericMapping, PPRIVILEGE_SET PrivilegeSet, LPDWORD PrivilegeSetLength, LPDWORD GrantedAccessList, LPDWORD AccessStatusList);
  BOOL                      AdjustTokenGroups(                                   HANDLE TokenHandle, BOOL ResetToDefault, PTOKEN_GROUPS NewState, DWORD BufferLength, PTOKEN_GROUPS PreviousState, PDWORD ReturnLength);
  BOOL                      AdjustTokenPrivileges(                               HANDLE TokenHandle, BOOL DisableAllPrivileges, PTOKEN_PRIVILEGES NewState, DWORD BufferLength, PTOKEN_PRIVILEGES PreviousState, PDWORD ReturnLength);
  BOOL                      AllocateAndInitializeSid(                            PSID_IDENTIFIER_AUTHORITY pIdentifierAuthority, BYTE nSubAuthorityCount, DWORD dwSubAuthority0, DWORD dwSubAuthority1, DWORD dwSubAuthority2, DWORD dwSubAuthority3, DWORD dwSubAuthority4, DWORD dwSubAuthority5, DWORD dwSubAuthority6, DWORD dwSubAuthority7, PSID* pSid);
  BOOL                      AllocateLocallyUniqueId(                             PLUID Luid);
  VOID                      BuildExplicitAccessWithNameA(                        PEXPLICIT_ACCESS_A pExplicitAccess, LPSTR pTrusteeName, DWORD AccessPermissions, ACCESS_MODE AccessMode, WINAPI_AceFlags Inheritance);
  VOID                      BuildExplicitAccessWithNameW(                        PEXPLICIT_ACCESS_W pExplicitAccess, LPWSTR pTrusteeName, DWORD AccessPermissions, ACCESS_MODE AccessMode, WINAPI_AceFlags Inheritance);
  VOID                      BuildTrusteeWithNameA(                               PTRUSTEE_A pTrustee, LPSTR pName);
  VOID                      BuildTrusteeWithNameW(                               PTRUSTEE_W pTrustee, LPWSTR pName);
  void                      BuildTrusteeWithObjectsAndNameA(                     PTRUSTEE_A pTrustee, POBJECTS_AND_NAME_A pObjName, SE_OBJECT_TYPE ObjectType, LPSTR ObjectTypeName, LPSTR InheritedObjectTypeName, LPSTR Name);
  void                      BuildTrusteeWithObjectsAndNameW(                     PTRUSTEE_W pTrustee, POBJECTS_AND_NAME_W pObjName, SE_OBJECT_TYPE ObjectType, LPWSTR ObjectTypeName, LPWSTR InheritedObjectTypeName, LPSTR Name);
  void                      BuildTrusteeWithObjectsAndSidA(                      PTRUSTEE_A pTrustee, POBJECTS_AND_SID pObjSid, GUID* pObjectGuid, GUID* pInheritedObjectGuid, PSID pSid);
  void                      BuildTrusteeWithObjectsAndSidW(                      PTRUSTEE_W pTrustee, POBJECTS_AND_SID pObjSid, GUID* pObjectGuid, GUID* pInheritedObjectGuid, PSID pSid);
  VOID                      BuildTrusteeWithSidA(                                PTRUSTEE_A pTrustee, PSID pSid);
  VOID                      BuildTrusteeWithSidW(                                PTRUSTEE_W pTrustee, PSID pSid);
  BOOL                      CheckTokenMembership(                                HANDLE TokenHandle, PSID SidToCheck, PBOOL IsMember);
  BOOL                      ConvertSecurityDescriptorToStringSecurityDescriptorA(PSECURITY_DESCRIPTOR SecurityDescriptor, WINAPI_SDDL_Revision RequestedStringSDRevision, SECURITY_INFORMATION SecurityInformation, LPSTR* StringSecurityDescriptor, PULONG StringSecurityDescriptorLen);
  BOOL                      ConvertSecurityDescriptorToStringSecurityDescriptorW(PSECURITY_DESCRIPTOR SecurityDescriptor, WINAPI_SDDL_Revision RequestedStringSDRevision, SECURITY_INFORMATION SecurityInformation, LPWSTR* StringSecurityDescriptor, PULONG StringSecurityDescriptorLen);
  BOOL                      ConvertSidToStringSidA(                              PSID Sid, LPSTR* StringSid);
  BOOL                      ConvertSidToStringSidW(                              PSID Sid, LPWSTR* StringSid);
  BOOL                      ConvertStringSecurityDescriptorToSecurityDescriptorA(LPCSTR StringSecurityDescriptor, WINAPI_SDDL_Revision StringSDRevision, PSECURITY_DESCRIPTOR* SecurityDescriptor, PULONG SecurityDescriptorSize);
  BOOL                      ConvertStringSecurityDescriptorToSecurityDescriptorW(LPCWSTR StringSecurityDescriptor, WINAPI_SDDL_Revision StringSDRevision, PSECURITY_DESCRIPTOR* SecurityDescriptor, PULONG SecurityDescriptorSize);
  BOOL                      ConvertStringSidToSidA(                              LPCSTR StringSid, PSID* Sid);
  BOOL                      ConvertStringSidToSidW(                              LPCWSTR StringSid, PSID* Sid);
  BOOL                      CopySid(                                             DWORD nDestinationSidLength, PSID pDestinationSid, PSID pSourceSid);
  BOOL                      CreateRestrictedToken(                               HANDLE ExistingTokenHandle, WINAPI_CreateRestrictedTokenFlags Flags, DWORD DisableSidCount, PSID_AND_ATTRIBUTES SidsToDisable, DWORD DeletePrivilegeCount, PLUID_AND_ATTRIBUTES PrivilegesToDelete, DWORD RestrictedSidCount, PSID_AND_ATTRIBUTES SidsToRestrict, PHANDLE NewTokenHandle);
  BOOL                      CreateWellKnownSid(                                  WELL_KNOWN_SID_TYPE WellKnownSidType, PSID DomainSid, PSID pSid, DWORD* cbSid);
  BOOL                      DuplicateToken(                                      HANDLE ExistingTokenHandle, SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, PHANDLE DuplicateTokenHandle);
  BOOL                      DuplicateTokenEx(                                    HANDLE hExistingToken, WINAPI_TOKEN_ACCESS_MASK_DWORD dwDesiredAccess, LPSECURITY_ATTRIBUTES lpTokenAttributes, SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, TOKEN_TYPE TokenType, PHANDLE phNewToken);
  BOOL                      EqualDomainSid(                                      PSID pSid1, PSID pSid2, BOOL* pfEqual);
  BOOL                      EqualPrefixSid(                                      PSID pSid1, PSID pSid2);
  BOOL                      EqualSid(                                            PSID pSid1, PSID pSid2);
  PVOID                     FreeSid(                                             PSID pSid);
  WINAPI_ERROR_CODE         GetAuditedPermissionsFromAclA(                       PACL pacl, PTRUSTEE_A pTrustee, PACCESS_MASK pSuccessfulAuditedRights, PACCESS_MASK pFailedAuditRights);
  WINAPI_ERROR_CODE         GetAuditedPermissionsFromAclW(                       PACL pacl, PTRUSTEE_W pTrustee, PACCESS_MASK pSuccessfulAuditedRights, PACCESS_MASK pFailedAuditRights);
  WINAPI_ERROR_CODE         GetEffectiveRightsFromAclA(                          PACL pacl, PTRUSTEE_A pTrustee, PACCESS_MASK pAccessRights);
  WINAPI_ERROR_CODE         GetEffectiveRightsFromAclW(                          PACL pacl, PTRUSTEE_W pTrustee, PACCESS_MASK pAccessRights);
  WINAPI_ERROR_CODE         GetExplicitEntriesFromAclA(                          PACL pacl, PULONG pcCountOfExplicitEntries, PEXPLICIT_ACCESS_A* pListOfExplicitEntries);
  WINAPI_ERROR_CODE         GetExplicitEntriesFromAclW(                          PACL pacl, PULONG pcCountOfExplicitEntries, PEXPLICIT_ACCESS_W* pListOfExplicitEntries);
  DWORD                     GetLengthSid(                                        PSID pSid);
  WINAPI_ERROR_CODE         GetNamedSecurityInfoA(                               LPSTR pObjectName, SE_OBJECT_TYPE ObjectType, SECURITY_INFORMATION SecurityInfo, PSID* ppsidOwner, PSID* ppsidGroup, PACL* ppDacl, PACL* ppSacl, PSECURITY_DESCRIPTOR_RELATIVE* ppSecurityDescriptor);
  WINAPI_ERROR_CODE         GetNamedSecurityInfoW(                               LPWSTR pObjectName, SE_OBJECT_TYPE ObjectType, SECURITY_INFORMATION SecurityInfo, PSID* ppsidOwner, PSID* ppsidGroup, PACL* ppDacl, PACL* ppSacl, PSECURITY_DESCRIPTOR_RELATIVE* ppSecurityDescriptor);
  BOOL                      GetSecurityDescriptorControl(                        PSECURITY_DESCRIPTOR pSecurityDescriptor, PSECURITY_DESCRIPTOR_CONTROL pControl, WINAPI_SDDL_Revision* lpdwRevision);
  WINAPI_ERROR_CODE         GetSecurityInfo(                                     HANDLE handle, SE_OBJECT_TYPE ObjectType, SECURITY_INFORMATION SecurityInfo, PSID* ppsidOwner, PSID* ppsidGroup, PACL* ppDacl, PACL* ppSacl, PSECURITY_DESCRIPTOR* ppSecurityDescriptor);
  PSID_IDENTIFIER_AUTHORITY GetSidIdentifierAuthority(                           PSID pSid);
  DWORD                     GetSidLengthRequired(                                UCHAR nSubAuthorityCount);
  PDWORD                    GetSidSubAuthority(                                  PSID pSid, DWORD nSubAuthority);
  PUCHAR                    GetSidSubAuthorityCount(                             PSID pSid);
  BOOL                      GetTokenInformation(                                 HANDLE TokenHandle, TOKEN_INFORMATION_CLASS TokenInformationClass, LPVOID TokenInformation, DWORD TokenInformationLength, PDWORD ReturnLength);
  TRUSTEE_FORM              GetTrusteeFormA(                                     PTRUSTEE_A pTrustee);
  TRUSTEE_FORM              GetTrusteeFormW(                                     PTRUSTEE_W pTrustee);
  LPSTR                     GetTrusteeNameA(                                     PTRUSTEE_A pTrustee);
  LPWSTR                    GetTrusteeNameW(                                     PTRUSTEE_W pTrustee);
  TRUSTEE_TYPE              GetTrusteeTypeA(                                     PTRUSTEE_A pTrustee);
  TRUSTEE_TYPE              GetTrusteeTypeW(                                     PTRUSTEE_W pTrustee);
  BOOL                      GetWindowsAccountDomainSid(                          PSID pSid, PSID ppDomainSid, DWORD* cbSid);
  BOOL                      InitializeSid(                                       PSID Sid, PSID_IDENTIFIER_AUTHORITY pIdentifierAuthority, BYTE nSubAuthorityCount);
  BOOL                      IsTokenRestricted(                                   HANDLE TokenHandle);
  BOOL                      IsValidSid(                                          PSID pSid);
  BOOL                      IsWellKnownSid(                                      PSID pSid, WELL_KNOWN_SID_TYPE WellKnownSidType);
  BOOL                      LookupAccountNameA(                                  LPCSTR lpSystemName, LPCSTR lpAccountName, PSID Sid, LPDWORD cbSid, LPSTR ReferencedDomainName, LPDWORD cchReferencedDomainName, PSID_NAME_USE peUse);
  BOOL                      LookupAccountNameW(                                  LPCWSTR lpSystemName, LPCWSTR lpAccountName, PSID Sid, LPDWORD cbSid, LPWSTR ReferencedDomainName, LPDWORD cchReferencedDomainName, PSID_NAME_USE peUse);
  BOOL                      LookupAccountSidA(                                   LPCSTR lpSystemName, PSID lpSid, LPSTR lpName, LPDWORD cchName, LPSTR lpReferencedDomainName, LPDWORD cchReferencedDomainName, PSID_NAME_USE peUse);
  BOOL                      LookupAccountSidW(                                   LPCWSTR lpSystemName, PSID lpSid, LPWSTR lpName, LPDWORD cchName, LPWSTR lpReferencedDomainName, LPDWORD cchReferencedDomainName, PSID_NAME_USE peUse);
  BOOL                      LookupPrivilegeDisplayNameA(                         LPCSTR lpSystemName, LPCSTR lpName, LPSTR lpDisplayName, LPDWORD cchDisplayName, LPDWORD lpLanguageId);
  BOOL                      LookupPrivilegeDisplayNameW(                         LPCWSTR lpSystemName, LPCWSTR lpName, LPWSTR lpDisplayName, LPDWORD cchDisplayName, LPDWORD lpLanguageId);
  BOOL                      LookupPrivilegeNameA(                                LPCSTR lpSystemName, PLUID lpLuid, LPSTR lpName, LPDWORD cchName);
  BOOL                      LookupPrivilegeNameW(                                LPCWSTR lpSystemName, PLUID lpLuid, LPWSTR lpName, LPDWORD cchName);
  BOOL                      LookupPrivilegeValueA(                               LPCSTR lpSystemName, LPCSTR lpName, PLUID lpLuid);
  BOOL                      LookupPrivilegeValueW(                               LPCWSTR lpSystemName, LPCWSTR lpName, PLUID lpLuid);
  BOOL                      OpenProcessToken(                                    WINAPI_ProcessHandle ProcessHandle, WINAPI_TOKEN_ACCESS_MASK_DWORD DesiredAccess, PHANDLE TokenHandle);
  BOOL                      OpenThreadToken(                                     WINAPI_ThreadHandle ThreadHandle, WINAPI_TOKEN_ACCESS_MASK_DWORD DesiredAccess, BOOL OpenAsSelf, PHANDLE TokenHandle);
  VOID                      QuerySecurityAccessMask(                             SECURITY_INFORMATION SecurityInformation, LPDWORD DesiredAccess);
  WINAPI_ERROR_CODE         SetEntriesInAclA(                                    ULONG cCountOfExplicitEntries, PEXPLICIT_ACCESS_A pListOfExplicitEntries, PACL OldAcl, PACL* NewAcl);
  WINAPI_ERROR_CODE         SetEntriesInAclW(                                    ULONG cCountOfExplicitEntries, PEXPLICIT_ACCESS_W pListOfExplicitEntries, PACL OldAcl, PACL* NewAcl);
  WINAPI_ERROR_CODE         SetNamedSecurityInfoA(                               LPSTR pObjectName, SE_OBJECT_TYPE ObjectType, SECURITY_INFORMATION SecurityInfo, PSID psidOwner, PSID psidGroup, PACL pDacl, PACL pSacl);
  WINAPI_ERROR_CODE         SetNamedSecurityInfoW(                               LPWSTR pObjectName, SE_OBJECT_TYPE ObjectType, SECURITY_INFORMATION SecurityInfo, PSID psidOwner, PSID psidGroup, PACL pDacl, PACL pSacl);
  VOID                      SetSecurityAccessMask(                               SECURITY_INFORMATION SecurityInformation, LPDWORD DesiredAccess);
  BOOL                      SetSecurityDescriptorControl(                        PSECURITY_DESCRIPTOR pSecurityDescriptor, SECURITY_DESCRIPTOR_CONTROL ControlBitsOfInterest, SECURITY_DESCRIPTOR_CONTROL ControlBitsToSet);
  WINAPI_ERROR_CODE         SetSecurityInfo(                                     HANDLE handle, SE_OBJECT_TYPE ObjectType, SECURITY_INFORMATION SecurityInfo, PSID psidOwner, PSID psidGroup, PACL pDacl, PACL pSacl);
  BOOL                      SetThreadToken(                                      PHANDLE Thread, HANDLE Token);
  BOOL                      SetTokenInformation(                                 HANDLE TokenHandle, TOKEN_INFORMATION_CLASS TokenInformationClass, LPVOID TokenInformation, DWORD TokenInformationLength);
  WINAPI_ERROR_CODE         TreeResetNamedSecurityInfoA(                         LPSTR pObjectName, SE_OBJECT_TYPE ObjectType, SECURITY_INFORMATION SecurityInfo, PSID pOwner, PSID pGroup, PACL pDacl, PACL pSacl, BOOL KeepExplicit, FN_PROGRESS fnProgress, PROG_INVOKE_SETTING ProgressInvokeSetting, PVOID Args);
  WINAPI_ERROR_CODE         TreeResetNamedSecurityInfoW(                         LPWSTR pObjectName, SE_OBJECT_TYPE ObjectType, SECURITY_INFORMATION SecurityInfo, PSID pOwner, PSID pGroup, PACL pDacl, PACL pSacl, BOOL KeepExplicit, FN_PROGRESS fnProgress, PROG_INVOKE_SETTING ProgressInvokeSetting, PVOID Args);
  WINAPI_ERROR_CODE         TreeSetNamedSecurityInfoA(                           LPSTR pObjectName, SE_OBJECT_TYPE ObjectType, SECURITY_INFORMATION SecurityInfo, PSID pOwner, PSID pGroup, PACL pDacl, PACL pSacl, WINAPI_TreeSecAction dwAction, FN_PROGRESS fnProgress, PROG_INVOKE_SETTING ProgressInvokeSetting, PVOID Args);
  WINAPI_ERROR_CODE         TreeSetNamedSecurityInfoW(                           LPWSTR pObjectName, SE_OBJECT_TYPE ObjectType, SECURITY_INFORMATION SecurityInfo, PSID pOwner, PSID pGroup, PACL pDacl, PACL pSacl, WINAPI_TreeSecAction dwAction, FN_PROGRESS fnProgress, PROG_INVOKE_SETTING ProgressInvokeSetting, PVOID Args);
  BOOL                      AreAllAccessesGranted(                               DWORD GrantedAccess, DWORD DesiredAccess);
  BOOL                      AreAnyAccessesGranted(                               DWORD GrantedAccess, DWORD DesiredAccess);
  WINAPI_ERROR_CODE         BuildSecurityDescriptorA(                            PTRUSTEE_A pOwner, PTRUSTEE_A pGroup, ULONG cCountOfAccessEntries, PEXPLICIT_ACCESS_A pListOfAccessEntries, ULONG cCountOfAuditEntries, PEXPLICIT_ACCESS_A pListOfAuditEntries, PSECURITY_DESCRIPTOR pOldSD, PULONG pSizeNewSD, PSECURITY_DESCRIPTOR* pNewSD);
  WINAPI_ERROR_CODE         BuildSecurityDescriptorW(                            PTRUSTEE_W pOwner, PTRUSTEE_W pGroup, ULONG cCountOfAccessEntries, PEXPLICIT_ACCESS_W pListOfAccessEntries, ULONG cCountOfAuditEntries, PEXPLICIT_ACCESS_W pListOfAuditEntries, PSECURITY_DESCRIPTOR pOldSD, PULONG pSizeNewSD, PSECURITY_DESCRIPTOR* pNewSD);
  BOOL                      ConvertToAutoInheritPrivateObjectSecurity(           PSECURITY_DESCRIPTOR ParentDescriptor, PSECURITY_DESCRIPTOR CurrentSecurityDescriptor, PSECURITY_DESCRIPTOR* NewSecurityDescriptor, GUID* ObjectType, BOOLEAN IsDirectoryObject, PGENERIC_MAPPING GenericMapping);
  BOOL                      CreatePrivateObjectSecurity(                         PSECURITY_DESCRIPTOR ParentDescriptor, PSECURITY_DESCRIPTOR CreatorDescriptor, PSECURITY_DESCRIPTOR* NewDescriptor, BOOL IsDirectoryObject, HANDLE Token, PGENERIC_MAPPING GenericMapping);
  BOOL                      CreatePrivateObjectSecurityEx(                       PSECURITY_DESCRIPTOR ParentDescriptor, PSECURITY_DESCRIPTOR CreatorDescriptor, PSECURITY_DESCRIPTOR* NewDescriptor, GUID* ObjectType, BOOL IsContainerObject, WINAPI_SEF_Flags AutoInheritFlags, HANDLE Token, PGENERIC_MAPPING GenericMapping);
  BOOL                      CreatePrivateObjectSecurityWithMultipleInheritance(  PSECURITY_DESCRIPTOR ParentDescriptor, PSECURITY_DESCRIPTOR CreatorDescriptor, PSECURITY_DESCRIPTOR* NewDescriptor, GUID** ObjectTypes, ULONG GuidCount, BOOL IsContainerObject, WINAPI_SEF_Flags AutoInheritFlags, HANDLE Token, PGENERIC_MAPPING GenericMapping);
  BOOL                      DestroyPrivateObjectSecurity(                        PSECURITY_DESCRIPTOR* ObjectDescriptor);
  BOOL                      GetPrivateObjectSecurity(                            PSECURITY_DESCRIPTOR ObjectDescriptor, SECURITY_INFORMATION SecurityInformation, PSECURITY_DESCRIPTOR ResultantDescriptor, DWORD DescriptorLength, PDWORD ReturnLength);
  BOOL                      ImpersonateAnonymousToken(                           WINAPI_ThreadHandle ThreadHandle);
  BOOL                      ImpersonateLoggedOnUser(                             HANDLE hToken);
  BOOL                      ImpersonateNamedPipeClient(                          HANDLE hNamedPipe);
  BOOL                      ImpersonateSelf(                                     SECURITY_IMPERSONATION_LEVEL ImpersonationLevel);
  WINAPI_ERROR_CODE         LookupSecurityDescriptorPartsA(                      PTRUSTEE_A* pOwner, PTRUSTEE_A* pGroup, PULONG cCountOfAccessEntries, PEXPLICIT_ACCESS_A* pListOfAccessEntries, PULONG cCountOfAuditEntries, PEXPLICIT_ACCESS_A* pListOfAuditEntries, PSECURITY_DESCRIPTOR pSD);
  WINAPI_ERROR_CODE         LookupSecurityDescriptorPartsW(                      PTRUSTEE_W* pOwner, PTRUSTEE_W* pGroup, PULONG cCountOfAccessEntries, PEXPLICIT_ACCESS_W* pListOfAccessEntries, PULONG cCountOfAuditEntries, PEXPLICIT_ACCESS_W* pListOfAuditEntries, PSECURITY_DESCRIPTOR pSD);
  VOID                      MapGenericMask(                                      PDWORD AccessMask, PGENERIC_MAPPING GenericMapping);
  BOOL                      ObjectCloseAuditAlarmA(                              LPCSTR SubsystemName, LPVOID HandleId, BOOL GenerateOnClose);
  BOOL                      ObjectCloseAuditAlarmW(                              LPCWSTR SubsystemName, LPVOID HandleId, BOOL GenerateOnClose);
  BOOL                      ObjectDeleteAuditAlarmA(                             LPCSTR SubsystemName, LPVOID HandleId, BOOL GenerateOnClose);
  BOOL                      ObjectDeleteAuditAlarmW(                             LPCWSTR SubsystemName, LPVOID HandleId, BOOL GenerateOnClose);
  BOOL                      ObjectOpenAuditAlarmA(                               LPCSTR SubsystemName, LPVOID HandleId, LPSTR ObjectTypeName, LPSTR ObjectName, PSECURITY_DESCRIPTOR pSecurityDescriptor, HANDLE ClientToken, DWORD DesiredAccess, DWORD GrantedAccess, PPRIVILEGE_SET Privileges, BOOL ObjectCreation, BOOL AccessGranted, LPBOOL GenerateOnClose);
  BOOL                      ObjectOpenAuditAlarmW(                               LPCWSTR SubsystemName, LPVOID HandleId, LPWSTR ObjectTypeName, LPWSTR ObjectName, PSECURITY_DESCRIPTOR pSecurityDescriptor, HANDLE ClientToken, DWORD DesiredAccess, DWORD GrantedAccess, PPRIVILEGE_SET Privileges, BOOL ObjectCreation, BOOL AccessGranted, LPBOOL GenerateOnClose);
  BOOL                      ObjectPrivilegeAuditAlarmA(                          LPCSTR SubsystemName, LPVOID HandleId, HANDLE ClientToken, DWORD DesiredAccess, PPRIVILEGE_SET Privileges, BOOL AccessGranted);
  BOOL                      ObjectPrivilegeAuditAlarmW(                          LPCWSTR SubsystemName, LPVOID HandleId, HANDLE ClientToken, DWORD DesiredAccess, PPRIVILEGE_SET Privileges, BOOL AccessGranted);
  BOOL                      PrivilegeCheck(                                      HANDLE ClientToken, PPRIVILEGE_SET RequiredPrivileges, LPBOOL pfResult);
  BOOL                      PrivilegedServiceAuditAlarmA(                        LPCSTR SubsystemName, LPCSTR ServiceName, HANDLE ClientToken, PPRIVILEGE_SET Privileges, BOOL AccessGranted);
  BOOL                      PrivilegedServiceAuditAlarmW(                        LPCWSTR SubsystemName, LPCWSTR ServiceName, HANDLE ClientToken, PPRIVILEGE_SET Privileges, BOOL AccessGranted);
  BOOL                      RevertToSelf(                                        );
  BOOL                      SetPrivateObjectSecurity(                            SECURITY_INFORMATION SecurityInformation, PSECURITY_DESCRIPTOR ModificationDescriptor, PSECURITY_DESCRIPTOR* ObjectsSecurityDescriptor, PGENERIC_MAPPING GenericMapping, HANDLE Token);
  BOOL                      SetPrivateObjectSecurityEx(                          SECURITY_INFORMATION SecurityInformation, PSECURITY_DESCRIPTOR ModificationDescriptor, PSECURITY_DESCRIPTOR* ObjectsSecurityDescriptor, WINAPI_SEF_Flags AutoInheritFlags, PGENERIC_MAPPING GenericMapping, HANDLE Token);
  WINAPI_ERROR_CODE         SetSecurityDescriptorRMControl(                      PSECURITY_DESCRIPTOR SecurityDescriptor, PUCHAR RMControl);
  BOOL                      AccessCheckAndAuditAlarmA(                           LPCSTR SubsystemName, LPVOID HandleId, LPSTR ObjectTypeName, LPSTR ObjectName, PSECURITY_DESCRIPTOR SecurityDescriptor, DWORD DesiredAccess, PGENERIC_MAPPING GenericMapping, BOOL ObjectCreation, LPDWORD GrantedAccess, LPBOOL AccessStatus, LPBOOL pfGenerateOnClose);
  BOOL                      AccessCheckAndAuditAlarmW(                           LPCWSTR SubsystemName, LPVOID HandleId, LPWSTR ObjectTypeName, LPWSTR ObjectName, PSECURITY_DESCRIPTOR SecurityDescriptor, DWORD DesiredAccess, PGENERIC_MAPPING GenericMapping, BOOL ObjectCreation, LPDWORD GrantedAccess, LPBOOL AccessStatus, LPBOOL pfGenerateOnClose);
  BOOL                      AccessCheckByTypeAndAuditAlarmA(                     LPCSTR SubsystemName, LPVOID HandleId, LPCSTR ObjectTypeName, LPCSTR ObjectName, PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID PrincipalSelfSid, DWORD DesiredAccess, AUDIT_EVENT_TYPE AuditType, DWORD Flags, POBJECT_TYPE_LIST ObjectTypeList, DWORD ObjectTypeListLength, PGENERIC_MAPPING GenericMapping, BOOL ObjectCreation, LPDWORD GrantedAccess, LPBOOL AccessStatus, LPBOOL pfGenerateOnClose);
  BOOL                      AccessCheckByTypeAndAuditAlarmW(                     LPCWSTR SubsystemName, LPVOID HandleId, LPCWSTR ObjectTypeName, LPCWSTR ObjectName, PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID PrincipalSelfSid, DWORD DesiredAccess, AUDIT_EVENT_TYPE AuditType, DWORD Flags, POBJECT_TYPE_LIST ObjectTypeList, DWORD ObjectTypeListLength, PGENERIC_MAPPING GenericMapping, BOOL ObjectCreation, LPDWORD GrantedAccess, LPBOOL AccessStatus, LPBOOL pfGenerateOnClose);
  BOOL                      AccessCheckByTypeResultListAndAuditAlarmA(           LPCSTR SubsystemName, LPVOID HandleId, LPCSTR ObjectTypeName, LPCSTR ObjectName, PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID PrincipalSelfSid, DWORD DesiredAccess, AUDIT_EVENT_TYPE AuditType, DWORD Flags, POBJECT_TYPE_LIST ObjectTypeList, DWORD ObjectTypeListLength, PGENERIC_MAPPING GenericMapping, BOOL ObjectCreation, LPDWORD GrantedAccess, LPDWORD AccessStatusList, LPBOOL pfGenerateOnClose);
  BOOL                      AccessCheckByTypeResultListAndAuditAlarmW(           LPCWSTR SubsystemName, LPVOID HandleId, LPCWSTR ObjectTypeName, LPCWSTR ObjectName, PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID PrincipalSelfSid, DWORD DesiredAccess, AUDIT_EVENT_TYPE AuditType, DWORD Flags, POBJECT_TYPE_LIST ObjectTypeList, DWORD ObjectTypeListLength, PGENERIC_MAPPING GenericMapping, BOOL ObjectCreation, LPDWORD GrantedAccess, LPDWORD AccessStatusList, LPBOOL pfGenerateOnClose);
  BOOL                      AccessCheckByTypeResultListAndAuditAlarmByHandleA(   LPCSTR SubsystemName, LPVOID HandleId, HANDLE ClientToken, LPCSTR ObjectTypeName, LPCSTR ObjectName, PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID PrincipalSelfSid, DWORD DesiredAccess, AUDIT_EVENT_TYPE AuditType, DWORD Flags, POBJECT_TYPE_LIST ObjectTypeList, DWORD ObjectTypeListLength, PGENERIC_MAPPING GenericMapping, BOOL ObjectCreation, LPDWORD GrantedAccess, LPDWORD AccessStatusList, LPBOOL pfGenerateOnClose);
  BOOL                      AccessCheckByTypeResultListAndAuditAlarmByHandleW(   LPCWSTR SubsystemName, LPVOID HandleId, HANDLE ClientToken, LPCWSTR ObjectTypeName, LPCWSTR ObjectName, PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID PrincipalSelfSid, DWORD DesiredAccess, AUDIT_EVENT_TYPE AuditType, DWORD Flags, POBJECT_TYPE_LIST ObjectTypeList, DWORD ObjectTypeListLength, PGENERIC_MAPPING GenericMapping, BOOL ObjectCreation, LPDWORD GrantedAccess, LPDWORD AccessStatusList, LPBOOL pfGenerateOnClose);
  BOOL                      AddAccessAllowedAce(                                 PACL pAcl, WINAPI_AclRevision dwAceRevision, DWORD AccessMask, PSID pSid);
  BOOL                      AddAccessAllowedAceEx(                               PACL pAcl, WINAPI_AclRevision dwAceRevision, WINAPI_AceFlags AceFlags, DWORD AccessMask, PSID pSid);
  BOOL                      AddAccessAllowedObjectAce(                           PACL pAcl, WINAPI_AclRevision dwAceRevision, DWORD AceFlags, DWORD AccessMask, GUID* ObjectTypeGuid, GUID* InheritedObjectTypeGuid, PSID pSid);
  BOOL                      AddAccessDeniedAce(                                  PACL pAcl, WINAPI_AclRevision dwAceRevision, DWORD AccessMask, PSID pSid);
  BOOL                      AddAccessDeniedAceEx(                                PACL pAcl, WINAPI_AclRevision dwAceRevision, DWORD AceFlags, DWORD AccessMask, PSID pSid);
  BOOL                      AddAccessDeniedObjectAce(                            PACL pAcl, WINAPI_AclRevision dwAceRevision, DWORD AceFlags, DWORD AccessMask, GUID* ObjectTypeGuid, GUID* InheritedObjectTypeGuid, PSID pSid);
  BOOL                      AddAce(                                              PACL pAcl, WINAPI_AclRevision dwAceRevision, DWORD dwStartingAceIndex, LPVOID pAceList, DWORD nAceListLength);
  BOOL                      AddAuditAccessAce(                                   PACL pAcl, WINAPI_AclRevision dwAceRevision, DWORD dwAccessMask, PSID pSid, BOOL bAuditSuccess, BOOL bAuditFailure);
  BOOL                      AddAuditAccessAceEx(                                 PACL pAcl, WINAPI_AclRevision dwAceRevision, DWORD AceFlags, DWORD dwAccessMask, PSID pSid, BOOL bAuditSuccess, BOOL bAuditFailure);
  BOOL                      AddAuditAccessObjectAce(                             PACL pAcl, WINAPI_AclRevision dwAceRevision, DWORD AceFlags, DWORD AccessMask, GUID* ObjectTypeGuid, GUID* InheritedObjectTypeGuid, PSID pSid, BOOL bAuditSuccess, BOOL bAuditFailure);
  BOOL                      AddMandatoryAce(                                     PACL pAcl, WINAPI_AclRevision dwAceRevision, WINAPI_AceFlags AceFlags, WINAPI_MandatoryPolicyFlags MandatoryPolicy, PSID pLabelSid);
  BOOL                      DeleteAce(                                           PACL pAcl, DWORD dwAceIndex);
  BOOL                      FindFirstFreeAce(                                    PACL pAcl, PACE* pAce);
  WINAPI_ERROR_CODE         FreeInheritedFromArray(                              PINHERITED_FROMW pInheritArray, USHORT AceCnt, PFN_OBJECT_MGR_FUNCTS pfnArray);
  BOOL                      GetAce(                                              PACL pAcl, DWORD dwAceIndex, PACE* pAce);
  BOOL                      GetAclInformation(                                   PACL pAcl, LPVOID pAclInformation, DWORD nAclInformationLength, ACL_INFORMATION_CLASS dwAclInformationClass);
  BOOL                      GetFileSecurityA(                                    LPCSTR lpFileName, SECURITY_INFORMATION RequestedInformation, PSECURITY_DESCRIPTOR pSecurityDescriptor, DWORD nLength, LPDWORD lpnLengthNeeded);
  BOOL                      GetFileSecurityW(                                    LPCWSTR lpFileName, SECURITY_INFORMATION RequestedInformation, PSECURITY_DESCRIPTOR pSecurityDescriptor, DWORD nLength, LPDWORD lpnLengthNeeded);
  WINAPI_ERROR_CODE         GetInheritanceSourceA(                               LPSTR pObjectName, SE_OBJECT_TYPE ObjectType, SECURITY_INFORMATION SecurityInfo, BOOL Container, GUID** pObjectClassGuids, DWORD GuidCount, PACL pAcl, PFN_OBJECT_MGR_FUNCTS pfnArray, PGENERIC_MAPPING pGenericMapping, PINHERITED_FROMA pInheritArray);
  WINAPI_ERROR_CODE         GetInheritanceSourceW(                               LPWSTR pObjectName, SE_OBJECT_TYPE ObjectType, SECURITY_INFORMATION SecurityInfo, BOOL Container, GUID** pObjectClassGuids, DWORD GuidCount, PACL pAcl, PFN_OBJECT_MGR_FUNCTS pfnArray, PGENERIC_MAPPING pGenericMapping, PINHERITED_FROMW pInheritArray);
  BOOL                      GetKernelObjectSecurity(                             HANDLE Handle, SECURITY_INFORMATION RequestedInformation, PISECURITY_DESCRIPTOR_RELATIVE pSecurityDescriptor, DWORD nLength, LPDWORD lpnLengthNeeded);
  BOOL                      GetSecurityDescriptorDacl(                           PSECURITY_DESCRIPTOR pSecurityDescriptor, LPBOOL lpbDaclPresent, PACL* pDacl, LPBOOL lpbDaclDefaulted);
  BOOL                      GetSecurityDescriptorGroup(                          PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID* pGroup, LPBOOL lpbGroupDefaulted);
  DWORD                     GetSecurityDescriptorLength(                         PSECURITY_DESCRIPTOR pSecurityDescriptor);
  BOOL                      GetSecurityDescriptorOwner(                          PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID* pOwner, LPBOOL lpbOwnerDefaulted);
  BOOL                      GetSecurityDescriptorSacl(                           PSECURITY_DESCRIPTOR pSecurityDescriptor, LPBOOL lpbSaclPresent, PACL* pSacl, LPBOOL lpbSaclDefaulted);
  BOOL                      InitializeAcl(                                       PACL pAcl, DWORD nAclLength, WINAPI_AclRevision dwAclRevision);
  BOOL                      InitializeSecurityDescriptor(                        PSECURITY_DESCRIPTOR pSecurityDescriptor, WINAPI_SDRevision dwRevision);
  BOOL                      IsValidAcl(                                          PACL pAcl);
  BOOL                      IsValidSecurityDescriptor(                           PSECURITY_DESCRIPTOR pSecurityDescriptor);
  BOOL                      MakeAbsoluteSD(                                      PSECURITY_DESCRIPTOR_RELATIVE pSelfRelativeSD, PSECURITY_DESCRIPTOR pAbsoluteSD, LPDWORD lpdwAbsoluteSDSize, PACL pDacl, LPDWORD lpdwDaclSize, PACL pSacl, LPDWORD lpdwSaclSize, PSID pOwner, LPDWORD lpdwOwnerSize, PSID pPrimaryGroup, LPDWORD lpdwPrimaryGroupSize);
  BOOL                      MakeSelfRelativeSD(                                  PSECURITY_DESCRIPTOR pAbsoluteSD, PSECURITY_DESCRIPTOR pSelfRelativeSD, LPDWORD lpdwBufferLength);
  BOOL                      QueryServiceObjectSecurity(                          SC_HANDLE hService, SECURITY_INFORMATION dwSecurityInformation, PSECURITY_DESCRIPTOR lpSecurityDescriptor, DWORD cbBufSize, LPDWORD pcbBytesNeeded);
  WINAPI_REG_ERROR          RegGetKeySecurity(                                   HKEY hKey, SECURITY_INFORMATION SecurityInformation, PSECURITY_DESCRIPTOR pSecurityDescriptor, LPDWORD lpcbSecurityDescriptor);
  WINAPI_REG_ERROR          RegSetKeySecurity(                                   HKEY hKey, SECURITY_INFORMATION SecurityInformation, PSECURITY_DESCRIPTOR pSecurityDescriptor);
  BOOL                      SetAclInformation(                                   PACL pAcl, LPVOID pAclInformation, DWORD nAclInformationLength, ACL_INFORMATION_CLASS dwAclInformationClass);
  BOOL                      SetFileSecurityA(                                    LPCSTR lpFileName, SECURITY_INFORMATION SecurityInformation, PSECURITY_DESCRIPTOR pSecurityDescriptor);
  BOOL                      SetFileSecurityW(                                    LPCWSTR lpFileName, SECURITY_INFORMATION SecurityInformation, PSECURITY_DESCRIPTOR pSecurityDescriptor);
  BOOL                      SetKernelObjectSecurity(                             HANDLE Handle, SECURITY_INFORMATION SecurityInformation, PSECURITY_DESCRIPTOR SecurityDescriptor);
  BOOL                      SetSecurityDescriptorDacl(                           PSECURITY_DESCRIPTOR pSecurityDescriptor, BOOL bDaclPresent, PACL pDacl, BOOL bDaclDefaulted);
  BOOL                      SetSecurityDescriptorGroup(                          PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID pGroup, BOOL bGroupDefaulted);
  BOOL                      SetSecurityDescriptorOwner(                          PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID pOwner, BOOL bOwnerDefaulted);
  BOOL                      SetSecurityDescriptorSacl(                           PSECURITY_DESCRIPTOR pSecurityDescriptor, BOOL bSaclPresent, PACL pSacl, BOOL bSaclDefaulted);
  BOOL                      SetServiceObjectSecurity(                            SC_HANDLE hService, SECURITY_INFORMATION dwSecurityInformation, PSECURITY_DESCRIPTOR lpSecurityDescriptor);
  BOOLEAN                   AuditComputeEffectivePolicyBySid(                    const PSID pSid, const GUID* pSubCategoryGuids, ULONG PolicyCount, PAUDIT_POLICY_INFORMATION* ppAuditPolicy);
  BOOLEAN                   AuditComputeEffectivePolicyByToken(                  HANDLE hTokenHandle, const GUID* pSubCategoryGuids, ULONG PolicyCount, PAUDIT_POLICY_INFORMATION* ppAuditPolicy);
  BOOLEAN                   AuditEnumerateCategories(                            GUID** ppAuditCategoriesArray, PULONG pCountReturned);
  BOOLEAN                   AuditEnumeratePerUserPolicy(                         PPOLICY_AUDIT_SID_ARRAY* ppAuditSidArray);
  BOOLEAN                   AuditEnumerateSubCategories(                         const GUID* pAuditCategoryGuid, BOOLEAN bRetrieveAllSubCategories, GUID** ppAuditSubCategoriesArray, PULONG pCountReturned);
  VOID                      AuditFree(                                           PVOID Buffer);
  BOOLEAN                   AuditLookupCategoryGuidFromCategoryId(               POLICY_AUDIT_EVENT_TYPE AuditCategoryId, GUID* pAuditCategoryGuid);
  BOOLEAN                   AuditLookupCategoryIdFromCategoryGuid(               const GUID* pAuditCategoryGuid, PPOLICY_AUDIT_EVENT_TYPE pAuditCategoryId);
  BOOLEAN                   AuditLookupCategoryNameA(                            const GUID* pAuditCategoryGuid, PSTR* ppszCategoryName);
  BOOLEAN                   AuditLookupCategoryNameW(                            const GUID* pAuditCategoryGuid, PWSTR* ppszCategoryName);
  BOOLEAN                   AuditLookupSubCategoryNameA(                         const GUID* pAuditSubCategoryGuid, PSTR* ppszSubCategoryName);
  BOOLEAN                   AuditLookupSubCategoryNameW(                         const GUID* pAuditSubCategoryGuid, PWSTR* ppszSubCategoryName);
  BOOLEAN                   AuditQueryPerUserPolicy(                             const PSID pSid, const GUID* pSubCategoryGuids, ULONG PolicyCount, PAUDIT_POLICY_INFORMATION* ppAuditPolicy);
  BOOLEAN                   AuditQuerySystemPolicy(                              const GUID* pSubCategoryGuids, ULONG PolicyCount, PAUDIT_POLICY_INFORMATION* ppAuditPolicy);
  BOOLEAN                   AuditSetPerUserPolicy(                               const PSID pSid, PCAUDIT_POLICY_INFORMATION pAuditPolicy, ULONG PolicyCount);
  BOOLEAN                   AuditSetSystemPolicy(                                PCAUDIT_POLICY_INFORMATION pAuditPolicy, ULONG PolicyCount);
  BOOLEAN                   AuditQuerySecurity(                                  SECURITY_INFORMATION SecurityInformation, PSECURITY_DESCRIPTOR* ppSecurityDescriptor);
  BOOLEAN                   AuditSetSecurity(                                    SECURITY_INFORMATION SecurityInformation, PSECURITY_DESCRIPTOR pSecurityDescriptor);
  BOOL                      AddConditionalAce(                                   PACL pAcl, WINAPI_AclRevision dwAceRevision, WINAPI_AceFlags AceFlags, UCHAR AceType, DWORD AccessMask, PSID pSid, PWCHAR ConditionStr, DWORD* ReturnLength);
  BOOL                      LogonUserA(                                          LPSTR lpszUsername, LPSTR lpszDomain, LPSTR lpszPassword, WINAPI_LogonType dwLogonType, WINAPI_LogonProvider dwLogonProvider, PHANDLE phToken);
  BOOL                      LogonUserW(                                          LPWSTR lpszUsername, LPWSTR lpszDomain, LPWSTR lpszPassword, WINAPI_LogonType dwLogonType, WINAPI_LogonProvider dwLogonProvider, PHANDLE phToken);
  BOOL                      LogonUserExA(                                        LPSTR lpszUsername, LPSTR lpszDomain, LPSTR lpszPassword, WINAPI_LogonType dwLogonType, WINAPI_LogonProvider dwLogonProvider, PHANDLE phToken, PSID* ppLogonSid, PVOID* ppProfileBuffer, LPDWORD pdwProfileLength, PQUOTA_LIMITS pQuotaLimits);
  BOOL                      LogonUserExW(                                        LPWSTR lpszUsername, LPWSTR lpszDomain, LPWSTR lpszPassword, WINAPI_LogonType dwLogonType, WINAPI_LogonProvider dwLogonProvider, PHANDLE phToken, PSID* ppLogonSid, PVOID* ppProfileBuffer, LPDWORD pdwProfileLength, PQUOTA_LIMITS pQuotaLimits);
  BOOL                      LogonUserExExW(                                      LPWSTR lpszUsername, LPWSTR lpszDomain, LPWSTR lpszPassword, WINAPI_LogonType dwLogonType, PTOKEN_GROUPS pTokenGroups, WINAPI_LogonProvider dwLogonProvider, PHANDLE phToken, PSID* ppLogonSid, PVOID* ppProfileBuffer, LPDWORD pdwProfileLength, PQUOTA_LIMITS pQuotaLimits);
  BOOL                      CredDeleteA(                                         LPCSTR TargetName, DWORD Type, DWORD Flags);
  BOOL                      CredDeleteW(                                         LPCWSTR TargetName, DWORD Type, DWORD Flags);
  BOOL                      CredEnumerateA(                                      LPCSTR Filter, WINAPI_CredEnumerateFlags Flags, DWORD* Count, PCREDENTIALA** Credentials);
  BOOL                      CredEnumerateW(                                      LPCWSTR Filter, WINAPI_CredEnumerateFlags Flags, DWORD* Count, PCREDENTIALW** Credentials);
  BOOL                      CredFindBestCredentialA(                             LPCSTR TargetName, DWORD Type, DWORD Flags, PCREDENTIALA* Credential);
  BOOL                      CredFindBestCredentialW(                             LPCWSTR TargetName, DWORD Type, DWORD Flags, PCREDENTIALW* Credential);
  VOID                      CredFree(                                            PVOID Buffer);
  BOOL                      CredGetSessionTypes(                                 DWORD MaximumPersistCount, LPDWORD MaximumPersist);
  BOOL                      CredGetTargetInfoA(                                  LPCSTR TargetName, WINAPI_CredGetTargetInfoFlags Flags, PCREDENTIAL_TARGET_INFORMATIONA* TargetInfo);
  BOOL                      CredGetTargetInfoW(                                  LPCWSTR TargetName, WINAPI_CredGetTargetInfoFlags Flags, PCREDENTIAL_TARGET_INFORMATIONW* TargetInfo);
  BOOL                      CredIsProtectedA(                                    LPSTR pszProtectedCredentials, CRED_PROTECTION_TYPE* pProtectionType);
  BOOL                      CredIsProtectedW(                                    LPWSTR pszProtectedCredentials, CRED_PROTECTION_TYPE* pProtectionType);
  BOOL                      CredProtectA(                                        BOOL fAsSelf, LPSTR pszCredentials, DWORD cchCredentials, LPSTR pszProtectedCredentials, DWORD* pcchMaxChars, CRED_PROTECTION_TYPE* ProtectionType);
  BOOL                      CredProtectW(                                        BOOL fAsSelf, LPWSTR pszCredentials, DWORD cchCredentials, LPWSTR pszProtectedCredentials, DWORD* pcchMaxChars, CRED_PROTECTION_TYPE* ProtectionType);
  BOOL                      CredMarshalCredentialA(                              CRED_MARSHAL_TYPE CredType, PVOID Credential, LPSTR* MarshaledCredential);
  BOOL                      CredMarshalCredentialW(                              CRED_MARSHAL_TYPE CredType, PVOID Credential, LPWSTR* MarshaledCredential);
  BOOL                      CredReadA(                                           LPCSTR TargetName, WINAPI_CredType Type, DWORD Flags, PCREDENTIALA* Credential);
  BOOL                      CredReadW(                                           LPCWSTR TargetName, WINAPI_CredType Type, DWORD Flags, PCREDENTIALW* Credential);
  BOOL                      CredReadDomainCredentialsA(                          PCREDENTIAL_TARGET_INFORMATIONA TargetInfo, DWORD Flags, DWORD* Count, PCREDENTIALA** Credentials);
  BOOL                      CredReadDomainCredentialsW(                          PCREDENTIAL_TARGET_INFORMATIONW TargetInfo, DWORD Flags, DWORD* Count, PCREDENTIALW** Credentials);
  BOOL                      CredRenameA(                                         LPCSTR OldTargetName, LPCSTR NewTargetName, DWORD Type, DWORD Flags);
  BOOL                      CredRenameW(                                         LPCWSTR OldTargetName, LPCWSTR NewTargetName, DWORD Type, DWORD Flags);
  BOOL                      CredUnmarshalCredentialA(                            LPCSTR MarshaledCredential, PCRED_MARSHAL_TYPE CredType, PVOID* Credential);
  BOOL                      CredUnmarshalCredentialW(                            LPCWSTR MarshaledCredential, PCRED_MARSHAL_TYPE CredType, PVOID* Credential);
  BOOL                      CredUnprotectA(                                      BOOL fAsSelf, LPSTR pszProtectedCredentials, DWORD cchCredentials, LPSTR pszCredentials, DWORD* pcchMaxChars);
  BOOL                      CredUnprotectW(                                      BOOL fAsSelf, LPWSTR pszProtectedCredentials, DWORD cchCredentials, LPWSTR pszCredentials, DWORD* pcchMaxChars);
  BOOL                      CredWriteA(                                          PCREDENTIALA Credential, DWORD Flags);
  BOOL                      CredWriteW(                                          PCREDENTIALW Credential, DWORD Flags);
  BOOL                      CredWriteDomainCredentialsA(                         PCREDENTIAL_TARGET_INFORMATIONA TargetInfo, PCREDENTIALA Credential, DWORD Flags);
  BOOL                      CredWriteDomainCredentialsW(                         PCREDENTIAL_TARGET_INFORMATIONW TargetInfo, PCREDENTIALW Credential, DWORD Flags);
  BOOL                      CredIsMarshaledCredentialA(                          LPSTR MarshaledCredential);
  BOOL                      CredIsMarshaledCredentialW(                          LPWSTR MarshaledCredential);
  NTSTATUS                  LsaEnumerateAccountsWithUserRight(                   LSA_HANDLE PolicyHandle, PLSA_UNICODE_STRING UserRights, PVOID* EnumerationBuffer, PULONG CountReturned);
  NTSTATUS                  LsaEnumerateTrustedDomainsEx(                        LSA_HANDLE PolicyHandle, PLSA_ENUMERATION_HANDLE EnumerationContext, PVOID* Buffer, ULONG PreferredMaximumLength, PULONG CountReturned);
  NTSTATUS                  LsaLookupNames(                                      LSA_HANDLE PolicyHandle, ULONG Count, PLSA_UNICODE_STRING Names, PLSA_REFERENCED_DOMAIN_LIST* ReferencedDomains, PLSA_TRANSLATED_SID* Sids);
  NTSTATUS                  LsaLookupNames2(                                     LSA_HANDLE PolicyHandle, WINAPI_LSA_LOOKUP_FLAGS Flags, ULONG Count, PLSA_UNICODE_STRING Names, PLSA_REFERENCED_DOMAIN_LIST* ReferencedDomains, PLSA_TRANSLATED_SID2* Sids);
  NTSTATUS                  LsaLookupPrivilegeValue(                             LSA_HANDLE PolicyHandle, PUNICODE_STRING Name, PLUID Value);
  NTSTATUS                  LsaLookupSids(                                       LSA_HANDLE PolicyHandle, ULONG Count, PSID* Sids, PLSA_REFERENCED_DOMAIN_LIST* ReferencedDomains, PLSA_TRANSLATED_NAME* Names);
  NTSTATUS                  LsaAddAccountRights(                                 LSA_HANDLE PolicyHandle, PSID AccountSid, PLSA_UNICODE_STRING UserRights, ULONG CountOfRights);
  NTSTATUS                  LsaEnumerateAccountRights(                           LSA_HANDLE PolicyHandle, PSID AccountSid, PLSA_UNICODE_STRING* UserRights, PULONG CountOfRights);
  NTSTATUS                  LsaRemoveAccountRights(                              LSA_HANDLE PolicyHandle, PSID AccountSid, BOOLEAN AllRights, PLSA_UNICODE_STRING UserRights, ULONG CountOfRights);
  NTSTATUS                  LsaCreateTrustedDomainEx(                            LSA_HANDLE PolicyHandle, PTRUSTED_DOMAIN_INFORMATION_EX TrustedDomainInformation, PTRUSTED_DOMAIN_AUTH_INFORMATION AuthenticationInformation, ACCESS_MASK DesiredAccess, PLSA_HANDLE TrustedDomainHandle);
  NTSTATUS                  LsaDeleteTrustedDomain(                              LSA_HANDLE PolicyHandle, PSID TrustedDomainSid);
  NTSTATUS                  LsaEnumerateTrustedDomains(                          LSA_HANDLE PolicyHandle, PLSA_ENUMERATION_HANDLE EnumerationContext, PVOID* Buffer, ULONG PreferedMaximumLength, PULONG CountReturned);
  NTSTATUS                  LsaOpenTrustedDomainByName(                          LSA_HANDLE PolicyHandle, PLSA_UNICODE_STRING TrustedDomainName, ACCESS_MASK DesiredAccess, PLSA_HANDLE TrustedDomainHandle);
  NTSTATUS                  LsaQueryTrustedDomainInfo(                           LSA_HANDLE PolicyHandle, PSID TrustedDomainSid, TRUSTED_INFORMATION_CLASS InformationClass, PVOID* Buffer);
  NTSTATUS                  LsaQueryTrustedDomainInfoByName(                     LSA_HANDLE PolicyHandle, PLSA_UNICODE_STRING TrustedDomainName, TRUSTED_INFORMATION_CLASS InformationClass, PVOID* Buffer);
  NTSTATUS                  LsaSetTrustedDomainInfoByName(                       LSA_HANDLE PolicyHandle, PLSA_UNICODE_STRING TrustedDomainName, TRUSTED_INFORMATION_CLASS InformationClass, PVOID Buffer);
  NTSTATUS                  LsaSetTrustedDomainInformation(                      LSA_HANDLE PolicyHandle, PSID TrustedDomainSid, TRUSTED_INFORMATION_CLASS InformationClass, PVOID Buffer);
  NTSTATUS                  LsaRetrievePrivateData(                              LSA_HANDLE PolicyHandle, PLSA_UNICODE_STRING KeyName, PLSA_UNICODE_STRING* PrivateData);
  NTSTATUS                  LsaStorePrivateData(                                 LSA_HANDLE PolicyHandle, PLSA_UNICODE_STRING KeyName, PLSA_UNICODE_STRING PrivateData);
  NTSTATUS                  LsaClose(                                            LSA_HANDLE ObjectHandle);
  NTSTATUS                  LsaFreeMemory(                                       PVOID Buffer);
  ULONG                     LsaNtStatusToWinError(                               NTSTATUS Status);
  BOOL                      SaferCloseLevel(                                     SAFER_LEVEL_HANDLE hLevelHandle);
  BOOL                      SaferIdentifyLevel(                                  DWORD dwNumProperties, PSAFER_CODE_PROPERTIES pCodeProperties, SAFER_LEVEL_HANDLE* pLevelHandle, LPVOID lpReserved);
  BOOL                      SaferComputeTokenFromLevel(                          SAFER_LEVEL_HANDLE LevelHandle, HANDLE InAccessToken, PHANDLE OutAccessToken, DWORD dwFlags, LPVOID lpReserved);
  BOOL                      SaferCreateLevel(                                    WINAPI_SaferScopeId dwScopeId, DWORD dwLevelId, DWORD OpenFlags, SAFER_LEVEL_HANDLE* pLevelHandle, LPVOID lpReserved);
  BOOL                      SaferGetLevelInformation(                            SAFER_LEVEL_HANDLE LevelHandle, SAFER_OBJECT_INFO_CLASS dwInfoType, LPVOID lpQueryBuffer, DWORD dwInBufferSize, LPDWORD lpdwOutBufferSize);
  BOOL                      SaferGetPolicyInformation(                           WINAPI_SaferScopeId dwScopeId, SAFER_POLICY_INFO_CLASS SaferPolicyInfoClass, DWORD InfoBufferSize, PVOID InfoBuffer, PDWORD InfoBufferRetSize, LPVOID lpReserved);
  BOOL                      SaferiIsExecutableFileType(                          LPCWSTR szFullPath, BOOLEAN bFromShellExecute);
  BOOL                      SaferRecordEventLogEntry(                            SAFER_LEVEL_HANDLE hLevel, LPCWSTR szTargetPath, LPVOID lpReserved);
  VOID                      CloseThreadWaitChainSession(                         HWCT WctHandle);
  BOOL                      GetThreadWaitChain(                                  HWCT WctHandle, DWORD_PTR Context, DWORD Flags, DWORD ThreadId, LPDWORD NodeCount, PWAITCHAIN_NODE_INFO NodeInfoArray, LPBOOL IsCycle);
  HWCT                      OpenThreadWaitChainSession(                          DWORD Flags, PWAITCHAINCALLBACK callback);
  VOID                      RegisterWaitChainCOMCallback(                        PCOGETCALLSTATE CallStateCallback, PCOGETACTIVATIONSTATE ActivationStateCallback);
  NTSTATUS                  LsaOpenPolicy(                                       PLSA_UNICODE_STRING SystemName, PLSA_OBJECT_ATTRIBUTES ObjectAttributes, ACCESS_MASK DesiredAccess, PLSA_HANDLE PolicyHandle);
  NTSTATUS                  LsaQueryInformationPolicy(                           LSA_HANDLE PolicyHandle, POLICY_INFORMATION_CLASS InformationClass, PVOID* Buffer);
  NTSTATUS                  LsaSetInformationPolicy(                             LSA_HANDLE PolicyHandle, POLICY_INFORMATION_CLASS InformationClass, PVOID Buffer);
  NTSTATUS                  LsaQueryDomainInformationPolicy(                     LSA_HANDLE PolicyHandle, POLICY_DOMAIN_INFORMATION_CLASS InformationClass, PVOID* Buffer);
  NTSTATUS                  LsaQueryForestTrustInformation(                      LSA_HANDLE PolicyHandle, PLSA_UNICODE_STRING TrustedDomainName, PLSA_FOREST_TRUST_INFORMATION* ForestTrustInfo);
  NTSTATUS                  LsaSetDomainInformationPolicy(                       LSA_HANDLE PolicyHandle, POLICY_DOMAIN_INFORMATION_CLASS InformationClass, PVOID Buffer);
  NTSTATUS                  LsaSetForestTrustInformation(                        LSA_HANDLE PolicyHandle, PLSA_UNICODE_STRING TrustedDomainName, PLSA_FOREST_TRUST_INFORMATION ForestTrustInfo, BOOLEAN CheckOnly, PLSA_FOREST_TRUST_COLLISION_INFORMATION* CollisionInfo);
]]
return ffi.load( 'Advapi32.dll' )
