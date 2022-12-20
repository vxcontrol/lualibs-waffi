require( 'waffi.headers.odbc' )
local ffi = require( 'ffi' )
ffi.cdef [[
  BOOL    SQLConfigDataSource(          HWND hwndParent, WINAPI_ODBC_DSN_REQUEST fRequest, LPCSTR lpszDriver, LPCSTR lpszAttributes);
  BOOL    SQLConfigDataSourceW(         HWND hwndParent, WINAPI_ODBC_DSN_REQUEST fRequest, LPCWSTR lpszDriver, LPCWSTR lpszAttributes);
  BOOL    SQLConfigDriver(              HWND hwndParent, WINAPI_ODBC_DRIVER_REQUEST fRequest, LPCSTR lpszDriver, LPCSTR lpszArgs, LPSTR lpszMsg, WORD cbMsgMax, WORD* pcbMsgOut);
  BOOL    SQLConfigDriverW(             HWND hwndParent, WINAPI_ODBC_DRIVER_REQUEST fRequest, LPCWSTR lpszDriver, LPCWSTR lpszArgs, LPWSTR lpszMsg, WORD cbMsgMax, WORD* pcbMsgOut);
  BOOL    SQLCreateDataSource(          HWND hwnd, LPSTR lpszDS);
  BOOL    SQLCreateDataSourceW(         HWND hwnd, LPWSTR lpszDS);
  BOOL    SQLGetConfigMode(             WINAPI_ODBC_CONFIG_MODE* pwConfigMode);
  BOOL    SQLGetInstalledDrivers(       LPSTR lpszBuf, WORD cbBufMax, WORD* pcbBufOut);
  BOOL    SQLGetInstalledDriversW(      LPWSTR lpszBuf, WORD cbBufMax, WORD* pcbBufOut);
  int     SQLGetPrivateProfileString(   LPCSTR lpszSection, LPCSTR lpszEntry, LPCSTR lpszDefault, LPCSTR RetBuffer, INT cbRetBuffer, LPCSTR lpszFilename);
  int     SQLGetPrivateProfileStringW(  LPCWSTR lpszSection, LPCWSTR lpszEntry, LPCWSTR lpszDefault, LPCWSTR RetBuffer, INT cbRetBuffer, LPCWSTR lpszFilename);
  BOOL    SQLGetTranslator(             HWND hwndParent, LPSTR lpszName, WORD cbNameMax, WORD* pcbNameOut, LPSTR lpszPath, WORD cbPathMax, WORD* pcbPathOut, DWORD* pvOption);
  BOOL    SQLGetTranslatorW(            HWND hwndParent, LPWSTR lpszName, WORD cbNameMax, WORD* pcbNameOut, LPWSTR lpszPath, WORD cbPathMax, WORD* pcbPathOut, DWORD* pvOption);
  BOOL    SQLInstallDriverEx(           LPCSTR lpszDriver, LPCSTR lpszPathIn, LPSTR lpszPathOut, WORD cbPathOutMax, WORD* pcbPathOut, WINAPI_ODBC_INSTALL_REQUEST fRequest, LPDWORD lpdwUsageCount);
  BOOL    SQLInstallDriverExW(          LPCWSTR lpszDriver, LPCWSTR lpszPathIn, LPWSTR lpszPathOut, WORD cbPathOutMax, WORD* pcbPathOut, WINAPI_ODBC_INSTALL_REQUEST fRequest, LPDWORD lpdwUsageCount);
  BOOL    SQLInstallDriverManager(      LPSTR lpszPath, WORD cbPathMax, WORD* pcbPathOut);
  BOOL    SQLInstallDriverManagerW(     LPWSTR lpszPath, WORD cbPathMax, WORD* pcbPathOut);
  RETCODE SQLInstallerError(            WORD iError, WINAPI_ODBC_ERROR_CODE* pfErrorCode, LPSTR lpszErrorMsg, WORD cbErrorMsgMax, WORD* pcbErrorMsg);
  RETCODE SQLInstallerErrorW(           WORD iError, WINAPI_ODBC_ERROR_CODE* pfErrorCode, LPWSTR lpszErrorMsg, WORD cbErrorMsgMax, WORD* pcbErrorMsg);
  BOOL    SQLInstallTranslator(         LPCSTR lpszInfFile, LPCSTR lpszTranslator, LPCSTR lpszPathIn, LPSTR lpszPathOut, WORD cbPathOutMax, WORD* pcbPathOut, WORD fRequest, LPDWORD lpdwUsageCount);
  BOOL    SQLInstallTranslatorW(        LPCWSTR lpszInfFile, LPCWSTR lpszTranslator, LPCWSTR lpszPathIn, LPWSTR lpszPathOut, WORD cbPathOutMax, WORD* pcbPathOut, WORD fRequest, LPDWORD lpdwUsageCount);
  BOOL    SQLInstallTranslatorEx(       LPCSTR lpszTranslator, LPCSTR lpszPathIn, LPSTR lpszPathOut, WORD cbPathOutMax, WORD* pcbPathOut, WORD fRequest, LPDWORD lpdwUsageCount);
  BOOL    SQLInstallTranslatorExW(      LPCWSTR lpszTranslator, LPCWSTR lpszPathIn, LPWSTR lpszPathOut, WORD cbPathOutMax, WORD* pcbPathOut, WORD fRequest, LPDWORD lpdwUsageCount);
  BOOL    SQLManageDataSources(         HWND hwnd);
  RETCODE SQLPostInstallerError(        WINAPI_ODBC_ERROR_CODE fErrorCode, LPSTR szErrorMsg);
  RETCODE SQLPostInstallerErrorW(       WINAPI_ODBC_ERROR_CODE fErrorCode, LPWSTR szErrorMsg);
  BOOL    SQLReadFileDSN(               LPCSTR lpszFileName, LPCSTR lpszAppName, LPCSTR lpszKeyName, LPSTR lpszString, WORD cbString, WORD* pcbString);
  BOOL    SQLReadFileDSNW(              LPCWSTR lpszFileName, LPCWSTR lpszAppName, LPCWSTR lpszKeyName, LPWSTR lpszString, WORD cbString, WORD* pcbString);
  BOOL    SQLRemoveDriver(              LPCSTR lpszDriver, BOOL fRemoveDSN, LPDWORD lpdwUsageCount);
  BOOL    SQLRemoveDriverW(             LPCWSTR lpszDriver, BOOL fRemoveDSN, LPDWORD lpdwUsageCount);
  BOOL    SQLRemoveDriverManager(       LPDWORD pdwUsageCount);
  BOOL    SQLRemoveDSNFromIni(          LPCSTR lpszDSN);
  BOOL    SQLRemoveDSNFromIniW(         LPCWSTR lpszDSN);
  BOOL    SQLRemoveTranslator(          LPCSTR lpszTranslator, LPDWORD lpdwUsageCount);
  BOOL    SQLRemoveTranslatorW(         LPCWSTR lpszTranslator, LPDWORD lpdwUsageCount);
  BOOL    SQLSetConfigMode(             WINAPI_ODBC_CONFIG_MODE wConfigMode);
  BOOL    SQLValidDSN(                  LPCSTR lpszDSN);
  BOOL    SQLValidDSNW(                 LPCWSTR lpszDSN);
  BOOL    SQLWriteDSNToIni(             LPCSTR lpszDSN, LPCSTR lpszDriver);
  BOOL    SQLWriteDSNToIniW(            LPCWSTR lpszDSN, LPCWSTR lpszDriver);
  BOOL    SQLWriteFileDSN(              LPCSTR lpszFileName, LPCSTR lpszAppName, LPCSTR lpszKeyName, LPCSTR lpszString);
  BOOL    SQLWriteFileDSNW(             LPCWSTR lpszFileName, LPCWSTR lpszAppName, LPCWSTR lpszKeyName, LPCWSTR lpszString);
  BOOL    SQLWritePrivateProfileString( LPCSTR lpszSection, LPCSTR lpszEntry, LPCSTR lpszString, LPCSTR lpszFilename);
  BOOL    SQLWritePrivateProfileStringW(LPCWSTR lpszSection, LPCWSTR lpszEntry, LPCWSTR lpszString, LPCWSTR lpszFilename);
]]
return ffi.load( 'ODBCCP32.DLL' )
