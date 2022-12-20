require( 'waffi.headers.windows' )
require( 'waffi.headers.security' )
local ffi = require( 'ffi' )
ffi.cdef [[
  typedef void* IWbemServices; //Interface
  typedef void* IWbemClassObject; //Interface
  typedef GUID* REFGPEXTENSIONID; //Alias
  typedef UINT_PTR ASYNCCOMPLETIONHANDLE; //Alias
  typedef PVOID PRSOPTOKEN; //Alias
  typedef UINT GPO_LINK; //Alias
  static const GPO_LINK GPLinkUnknown = 0;
  static const GPO_LINK GPLinkMachine = 1;
  static const GPO_LINK GPLinkSite = 2;
  static const GPO_LINK GPLinkDomain = 3;
  static const GPO_LINK GPLinkOrganizationalUnit = 4;
  typedef DWORD WINAPI_GPO_FLAG; //Alias
  typedef struct GROUP_POLICY_OBJECTA {
    WINAPI_GPO_FLAG dwOptions;
    DWORD dwVersion;
    LPSTR lpDSPath;
    LPSTR lpFileSysPath;
    LPSTR lpDisplayName;
    CHAR szGPOName[50];
    GPO_LINK GPOLink;
    LPARAM lParam;
    LPVOID pNext;
    LPVOID pPrev;
    LPSTR lpExtensions;
    LPARAM lParam2;
    LPSTR lpLink;
  } GROUP_POLICY_OBJECTA;
  typedef GROUP_POLICY_OBJECTA *PGROUP_POLICY_OBJECTA; //Pointer
  typedef struct GROUP_POLICY_OBJECTW {
    WINAPI_GPO_FLAG dwOptions;
    DWORD dwVersion;
    LPWSTR lpDSPath;
    LPWSTR lpFileSysPath;
    LPWSTR lpDisplayName;
    WCHAR szGPOName[50];
    GPO_LINK GPOLink;
    LPARAM lParam;
    LPVOID pNext;
    LPVOID pPrev;
    LPWSTR lpExtensions;
    LPARAM lParam2;
    LPWSTR lpLink;
  } GROUP_POLICY_OBJECTW;
  typedef GROUP_POLICY_OBJECTW *PGROUP_POLICY_OBJECTW; //Pointer
  typedef UINT SETTINGSTATUS; //Alias
  static const SETTINGSTATUS RSOPUnspecified = 0;
  static const SETTINGSTATUS RSOPApplied = 1;
  static const SETTINGSTATUS RSOPIgnored = 2;
  static const SETTINGSTATUS RSOPFailed = 3;
  static const SETTINGSTATUS RSOPSubsettingFailed = 4;
  typedef struct POLICYSETTINGSTATUSINFO {
    LPWSTR szKey;
    LPWSTR szEventSource;
    LPWSTR szEventLogName;
    DWORD dwEventID;
    DWORD dwErrorCode;
    SETTINGSTATUS status;
    SYSTEMTIME timeLogged;
  } POLICYSETTINGSTATUSINFO;
  typedef struct PROFILEINFOA {
    DWORD dwSize;
    DWORD dwFlags;
    LPSTR lpUserName;
    LPSTR lpProfilePath;
    LPSTR lpDefaultPath;
    LPSTR lpServerName;
    LPSTR lpPolicyPath;
    HANDLE hProfile;
  } PROFILEINFOA;
  typedef PROFILEINFOA *LPPROFILEINFOA; //Pointer
  typedef struct PROFILEINFOW {
    DWORD dwSize;
    DWORD dwFlags;
    LPWSTR lpUserName;
    LPWSTR lpProfilePath;
    LPWSTR lpDefaultPath;
    LPWSTR lpServerName;
    LPWSTR lpPolicyPath;
    HANDLE hProfile;
  } PROFILEINFOW;
  typedef PROFILEINFOW *LPPROFILEINFOW; //Pointer
  typedef DWORD WINAPI_ProfileType; //Alias
  HANDLE  EnterCriticalPolicySection(      BOOL bMachine);
  BOOL    FreeGPOListA(                    PGROUP_POLICY_OBJECTA pGPOList);
  BOOL    FreeGPOListW(                    PGROUP_POLICY_OBJECTW pGPOList);
  DWORD   GetAppliedGPOListA(              DWORD dwFlags, LPCSTR pMachineName, PSID pSidUser, GUID* pGuidExtension, PGROUP_POLICY_OBJECTA* ppGPOList);
  DWORD   GetAppliedGPOListW(              DWORD dwFlags, LPCWSTR pMachineName, PSID pSidUser, GUID* pGuidExtension, PGROUP_POLICY_OBJECTW* ppGPOList);
  BOOL    GetGPOListA(                     HANDLE hToken, LPCSTR lpName, LPCSTR lpHostName, LPCSTR lpComputerName, DWORD dwFlags, PGROUP_POLICY_OBJECTA* pGPOList);
  BOOL    GetGPOListW(                     HANDLE hToken, LPCWSTR lpName, LPCWSTR lpHostName, LPCWSTR lpComputerName, DWORD dwFlags, PGROUP_POLICY_OBJECTW* pGPOList);
  BOOL    LeaveCriticalPolicySection(      HANDLE hSection);
  DWORD   ProcessGroupPolicyCompleted(     REFGPEXTENSIONID extensionId, ASYNCCOMPLETIONHANDLE pAsyncHandle, DWORD dwStatus);
  DWORD   ProcessGroupPolicyCompletedEx(   REFGPEXTENSIONID extensionId, ASYNCCOMPLETIONHANDLE pAsyncHandle, DWORD dwStatus, HRESULT RsopStatus);
  BOOL    RefreshPolicy(                   BOOL bMachine);
  BOOL    RefreshPolicyEx(                 BOOL bMachine, DWORD dwOptions);
  BOOL    RegisterGPNotification(          HANDLE hEvent, BOOL bMachine);
  HRESULT RsopAccessCheckByType(           PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID pPrincipalSelfSid, PRSOPTOKEN pRsopToken, DWORD dwDesiredAccessMask, POBJECT_TYPE_LIST pObjectTypeList, DWORD ObjectTypeListLength, PGENERIC_MAPPING pGenericMapping, PPRIVILEGE_SET pPrivilegeSet, LPDWORD pdwPrivilegeSetLength, LPDWORD pdwGrantedAccessMask, LPBOOL pbAccessStatus);
  HRESULT RsopFileAccessCheck(             LPWSTR pszFileName, PRSOPTOKEN pRsopToken, DWORD dwDesiredAccessMask, LPDWORD pdwGrantedAccessMask, LPBOOL pbAccessStatus);
  HRESULT RsopResetPolicySettingStatus(    DWORD dwFlags, IWbemServices* pServices, IWbemClassObject* pSettingInstance);
  HRESULT RsopSetPolicySettingStatus(      DWORD dwFlags, IWbemServices* pServices, IWbemClassObject* pSettingInstance, DWORD nInfo, POLICYSETTINGSTATUSINFO* pStatus);
  BOOL    UnregisterGPNotification(        HANDLE hEvent);
  BOOL    CreateEnvironmentBlock(          LPVOID* lpEnvironment, HANDLE hToken, BOOL bInherit);
  HRESULT CreateProfile(                   LPCWSTR pszUserSid, LPCWSTR pszUserName, LPWSTR pszProfilePath, DWORD cchProfilePath);
  BOOL    CreateUserProfileExA(            PSID pSid, LPCSTR lpUserName, LPCSTR lpUserHive, LPSTR lpProfileDir, DWORD dwDirSize, BOOL bWin9xUpg);
  BOOL    CreateUserProfileExW(            PSID pSid, LPCWSTR lpUserName, LPCWSTR lpUserHive, LPWSTR lpProfileDir, DWORD dwDirSize, BOOL bWin9xUpg);
  BOOL    DeleteProfileA(                  LPCSTR lpSidString, LPCSTR lpProfilePath, LPCSTR lpComputerName);
  BOOL    DeleteProfileW(                  LPCWSTR lpSidString, LPCWSTR lpProfilePath, LPCWSTR lpComputerName);
  BOOL    DestroyEnvironmentBlock(         LPVOID lpEnvironment);
  BOOL    ExpandEnvironmentStringsForUserA(HANDLE hToken, LPCSTR lpSrc, LPSTR lpDest, DWORD dwSize);
  BOOL    ExpandEnvironmentStringsForUserW(HANDLE hToken, LPCWSTR lpSrc, LPWSTR lpDest, DWORD dwSize);
  BOOL    GetAllUsersProfileDirectoryA(    LPSTR lpProfileDir, LPDWORD lpcchSize);
  BOOL    GetAllUsersProfileDirectoryW(    LPWSTR lpProfileDir, LPDWORD lpcchSize);
  BOOL    GetDefaultUserProfileDirectoryA( LPSTR lpProfileDir, LPDWORD lpcchSize);
  BOOL    GetDefaultUserProfileDirectoryW( LPWSTR lpProfileDir, LPDWORD lpcchSize);
  BOOL    GetProfilesDirectoryA(           LPSTR lpProfilesDir, LPDWORD lpcchSize);
  BOOL    GetProfilesDirectoryW(           LPWSTR lpProfilesDir, LPDWORD lpcchSize);
  BOOL    GetProfileType(                  WINAPI_ProfileType* pdwFlags);
  BOOL    GetUserProfileDirectoryA(        HANDLE hToken, LPSTR lpProfileDir, LPDWORD lpcchSize);
  BOOL    GetUserProfileDirectoryW(        HANDLE hToken, LPWSTR lpProfileDir, LPDWORD lpcchSize);
  BOOL    LoadUserProfileA(                HANDLE hToken, LPPROFILEINFOA lpProfileInfo);
  BOOL    LoadUserProfileW(                HANDLE hToken, LPPROFILEINFOW lpProfileInfo);
  BOOL    UnloadUserProfile(               HANDLE hToken, HANDLE hProfile);
]]
return ffi.load( 'Userenv.dll' )
