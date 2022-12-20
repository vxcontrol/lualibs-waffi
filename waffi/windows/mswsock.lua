require( 'waffi.headers.windows' )
require( 'waffi.headers.sockets' )
local ffi = require( 'ffi' )
ffi.cdef [[
  typedef LPVOID LPSERVICE_CALLBACK_PROC; //Alias
  typedef DWORD WINAPI_SERVICE_ADDRESS_FLAG; //Alias
  typedef struct SERVICE_ADDRESS {
    WINAPI_AddressFamily dwAddressType;
    WINAPI_SERVICE_ADDRESS_FLAG dwAddressFlags;
    DWORD dwAddressLength;
    DWORD dwPrincipalLength;
    BYTE* lpAddress;
    BYTE* lpPrincipal;
  } SERVICE_ADDRESS;
  typedef struct SERVICE_ADDRESSES {
    DWORD dwAddressCount;
    SERVICE_ADDRESS Addresses[1];
  } SERVICE_ADDRESSES;
  typedef SERVICE_ADDRESSES *LPSERVICE_ADDRESSES; //Pointer
  typedef struct SERVICE_ASYNC_INFO {
    LPSERVICE_CALLBACK_PROC lpServiceCallbackProc;
    LPARAM lParam;
    HANDLE hAsyncTaskHandle;
  } SERVICE_ASYNC_INFO;
  typedef SERVICE_ASYNC_INFO *LPSERVICE_ASYNC_INFO; //Pointer
  typedef struct SERVICE_INFOA {
    LPGUID lpServiceType;
    LPSTR lpServiceName;
    LPSTR lpComment;
    LPSTR lpLocale;
    DWORD dwDisplayHint;
    DWORD dwVersion;
    DWORD dwTime;
    LPSTR lpMachineName;
    LPSERVICE_ADDRESSES lpServiceAddress;
    BLOB ServiceSpecificInfo;
  } SERVICE_INFOA;
  typedef SERVICE_INFOA *LPSERVICE_INFOA; //Pointer
  typedef struct SERVICE_INFOW {
    LPGUID lpServiceType;
    LPWSTR lpServiceName;
    LPWSTR lpComment;
    LPWSTR lpLocale;
    DWORD dwDisplayHint;
    DWORD dwVersion;
    DWORD dwTime;
    LPWSTR lpMachineName;
    LPSERVICE_ADDRESSES lpServiceAddress;
    BLOB ServiceSpecificInfo;
  } SERVICE_INFOW;
  typedef SERVICE_INFOW *LPSERVICE_INFOW; //Pointer
  typedef struct TRANSMIT_FILE_BUFFERS {
    LPVOID Head;
    DWORD HeadLength;
    LPVOID Tail;
    DWORD TailLength;
  } TRANSMIT_FILE_BUFFERS;
  typedef TRANSMIT_FILE_BUFFERS *LPTRANSMIT_FILE_BUFFERS; //Pointer
  WINAPI_SocketCode_INT EnumProtocolsA(       LPINT lpiProtocols, LPVOID lpProtocolBuffer, LPDWORD lpdwBufferLength);
  WINAPI_SocketCode_INT EnumProtocolsW(       LPINT lpiProtocols, LPVOID lpProtocolBuffer, LPDWORD lpdwBufferLength);
  void                  GetAcceptExSockaddrs( PVOID lpOutputBuffer, DWORD dwReceiveDataLength, DWORD dwLocalAddressLength, DWORD dwRemoteAddressLength, LPSOCKADDR* LocalSockaddr, LPINT LocalSockaddrLength, LPSOCKADDR* RemoteSockaddr, LPINT RemoteSockaddrLength);
  BOOL                  AcceptEx(             SOCKET sListenSocket, SOCKET sAcceptSocket, PVOID lpOutputBuffer, DWORD dwReceiveDataLength, DWORD dwLocalAddressLength, DWORD dwRemoteAddressLength, LPDWORD lpdwBytesReceived, LPOVERLAPPED lpOverlapped);
  INT                   GetAddressByNameA(    WINAPI_NameSpaceFlags dwNameSpace, LPGUID lpServiceType, LPSTR lpServiceName, LPINT lpiProtocols, WINAPI_ResolutionFlags dwResolution, LPSERVICE_ASYNC_INFO lpServiceAsyncInfo, LPVOID lpCsaddrBuffer, LPDWORD lpdwBufferLength, LPSTR lpAliasBuffer, LPDWORD lpdwAliasBufferLength);
  INT                   GetAddressByNameW(    WINAPI_NameSpaceFlags dwNameSpace, LPGUID lpServiceType, LPWSTR lpServiceName, LPINT lpiProtocols, WINAPI_ResolutionFlags dwResolution, LPSERVICE_ASYNC_INFO lpServiceAsyncInfo, LPVOID lpCsaddrBuffer, LPDWORD lpdwBufferLength, LPWSTR lpAliasBuffer, LPDWORD lpdwAliasBufferLength);
  WINAPI_SocketCode_INT GetNameByTypeA(       LPGUID lpServiceType, LPSTR lpServiceName, DWORD dwNameLength);
  WINAPI_SocketCode_INT GetNameByTypeW(       LPGUID lpServiceType, LPWSTR lpServiceName, DWORD dwNameLength);
  WINAPI_SocketCode_INT GetServiceA(          WINAPI_NameSpaceFlags dwNameSpace, PGUID lpGuid, LPSTR lpServiceName, WINAPI_GetService_Props dwProperties, LPVOID lpBuffer, LPDWORD lpdwBufferSize, LPSERVICE_ASYNC_INFO lpServiceAsyncInfo);
  WINAPI_SocketCode_INT GetServiceW(          WINAPI_NameSpaceFlags dwNameSpace, PGUID lpGuid, LPWSTR lpServiceName, WINAPI_GetService_Props dwProperties, LPVOID lpBuffer, LPDWORD lpdwBufferSize, LPSERVICE_ASYNC_INFO lpServiceAsyncInfo);
  WINAPI_SocketCode_INT GetTypeByNameA(       LPSTR lpServiceName, PGUID lpServiceType);
  WINAPI_SocketCode_INT GetTypeByNameW(       LPWSTR lpServiceName, PGUID lpServiceType);
  WINAPI_SocketCode_INT SetServiceA(          WINAPI_NameSpaceFlags dwNameSpace, WINAPI_SetService_Operation dwOperation, WINAPI_SetService_Flags dwFlags, LPSERVICE_INFOA lpServiceInfo, LPSERVICE_ASYNC_INFO lpServiceAsyncInfo, WINAPI_SetService_FlagsOut* lpdwStatusFlags);
  WINAPI_SocketCode_INT SetServiceW(          WINAPI_NameSpaceFlags dwNameSpace, WINAPI_SetService_Operation dwOperation, WINAPI_SetService_Flags dwFlags, LPSERVICE_INFOW lpServiceInfo, LPSERVICE_ASYNC_INFO lpServiceAsyncInfo, WINAPI_SetService_FlagsOut* lpdwStatusFlags);
  BOOL                  TransmitFile(         SOCKET hSocket, HANDLE hFile, DWORD nNumberOfBytesToWrite, DWORD nNumberOfBytesPerSend, LPOVERLAPPED lpOverlapped, LPTRANSMIT_FILE_BUFFERS lpTransmitBuffers, WINAPI_TransmitFile_Flags dwFlags);
  WINAPI_SocketCode_int WSARecvEx(            SOCKET s, char* buf, int len, int* flags);
]]
return ffi.load( 'Mswsock.dll' )
