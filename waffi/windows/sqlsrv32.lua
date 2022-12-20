require( 'waffi.headers.odbc' )
local ffi = require( 'ffi' )
ffi.cdef [[
  BOOL ConfigDriver(     HWND hwndParent, WINAPI_ODBC_DRIVER_REQUEST fRequest, LPCSTR lpszDriver, LPCSTR lpszArgs, LPSTR lpszMsg, WORD cbMsgMax, WORD* pcbMsgOut);
  BOOL ConfigDriverW(    HWND hwndParent, WINAPI_ODBC_DRIVER_REQUEST fRequest, LPCWSTR lpszDriver, LPCWSTR lpszArgs, LPWSTR lpszMsg, WORD cbMsgMax, WORD* pcbMsgOut);
  BOOL ConfigDSN(        HWND hwndParent, WINAPI_ODBC_DSN_REQUEST fRequest, LPCSTR lpszDriver, LPCSTR lpszAttributes);
  BOOL ConfigDSNW(       HWND hwndParent, WINAPI_ODBC_DSN_REQUEST fRequest, LPWSTR lpszDriver, LPCWSTR lpszAttributes);
  BOOL ConfigTranslator( HWND hwndParent, DWORD* pvOption);
]]
return ffi.load( 'SQLSRV32.DLL' )
