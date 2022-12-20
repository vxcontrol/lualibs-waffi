require( 'waffi.headers.windows' )
local ffi = require( 'ffi' )
ffi.cdef [[
  typedef WORD WINAPI_OpenFlags; //Alias
  INT  GetExpandedNameA(LPSTR lpszSource, LPSTR lpszBuffer);
  INT  GetExpandedNameW(LPWSTR lpszSource, LPWSTR lpszBuffer);
  void LZClose(         INT hFile);
  LONG LZCopy(          INT hfSource, INT hfDest);
  INT  LZInit(          INT hfSource);
  INT  LZOpenFileA(     LPSTR lpFileName, LPOFSTRUCT lpReOpenBuf, WINAPI_OpenFlags wStyle);
  INT  LZOpenFileW(     LPWSTR lpFileName, LPOFSTRUCT lpReOpenBuf, WINAPI_OpenFlags wStyle);
  INT  LZRead(          INT hFile, LPBYTE lpBuffer, INT cbRead);
  LONG LZSeek(          INT hFile, LONG lOffset, INT iOrigin);
]]
return ffi.load( 'Lz32.dll' )
