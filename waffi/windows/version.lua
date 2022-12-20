require( 'waffi.headers.windows' )
local ffi = require( 'ffi' )
ffi.cdef [[
  BOOL  GetFileVersionInfoA(       LPCSTR lptstrFilename, DWORD dwHandle, DWORD dwLen, LPVOID lpData);
  BOOL  GetFileVersionInfoW(       LPCWSTR lptstrFilename, DWORD dwHandle, DWORD dwLen, LPVOID lpData);
  BOOL  GetFileVersionInfoExA(     DWORD dwFlags, LPCSTR lptstrFilename, DWORD dwHandle, DWORD dwLen, LPVOID lpData);
  BOOL  GetFileVersionInfoExW(     DWORD dwFlags, LPCWSTR lptstrFilename, DWORD dwHandle, DWORD dwLen, LPVOID lpData);
  DWORD GetFileVersionInfoSizeA(   LPCSTR lptstrFilename, LPDWORD lpdwHandle);
  DWORD GetFileVersionInfoSizeW(   LPCWSTR lptstrFilename, LPDWORD lpdwHandle);
  DWORD GetFileVersionInfoSizeExA( DWORD dwFlags, LPCSTR lptstrFilename, LPDWORD lpdwHandle);
  DWORD GetFileVersionInfoSizeExW( DWORD dwFlags, LPCWSTR lptstrFilename, LPDWORD lpdwHandle);
  DWORD VerFindFileA(              DWORD dwFlags, LPCSTR szFileName, LPCSTR szWinDir, LPCSTR szAppDir, LPCSTR szCurDir, PUINT lpuCurDirLen, LPSTR szDestDir, PUINT lpuDestDirLen);
  DWORD VerFindFileW(              DWORD dwFlags, LPCWSTR szFileName, LPCWSTR szWinDir, LPCWSTR szAppDir, LPCSTR szCurDir, PUINT lpuCurDirLen, LPWSTR szDestDir, PUINT lpuDestDirLen);
  DWORD VerInstallFileA(           DWORD uFlags, LPCSTR szSrcFileName, LPCSTR szDestFileName, LPCSTR szSrcDir, LPCSTR szDestDir, LPCSTR szCurDir, LPSTR szTmpFile, PUINT lpuTmpFileLen);
  DWORD VerInstallFileW(           DWORD uFlags, LPCWSTR szSrcFileName, LPCWSTR szDestFileName, LPCWSTR szSrcDir, LPCWSTR szDestDir, LPCWSTR szCurDir, LPWSTR szTmpFile, PUINT lpuTmpFileLen);
  BOOL  VerQueryValueA(            LPCVOID pBlock, LPCSTR lpSubBlock, LPVOID* lplpBuffer, PUINT puLen);
  BOOL  VerQueryValueW(            LPCVOID pBlock, LPCWSTR lpSubBlock, LPVOID* lplpBuffer, PUINT puLen);
]]
return ffi.load( 'version.dll' )
