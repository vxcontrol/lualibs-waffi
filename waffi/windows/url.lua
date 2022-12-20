require( 'waffi.headers.windows' )
local ffi = require( 'ffi' )
ffi.cdef [[
  BOOL    InetIsOffline(         DWORD dwFlags);
  HRESULT MIMEAssociationDialogA(HWND hwndParent, DWORD dwInFlags, LPCSTR pcszFile, LPCSTR pcszMIMEContentType, LPSTR pszAppBuf, UINT ucAppBufLen);
  HRESULT MIMEAssociationDialogW(HWND hwndParent, DWORD dwInFlags, LPCWSTR pcszFile, LPCWSTR pcszMIMEContentType, LPWSTR pszAppBuf, UINT ucAppBufLen);
  HRESULT TranslateURLA(         LPCSTR pcszURL, DWORD dwInFlags, LPSTR* ppszTranslatedURL);
  HRESULT TranslateURLW(         LPCWSTR pcszURL, DWORD dwInFlags, LPWSTR* ppszTranslatedURL);
  HRESULT URLAssociationDialogA( HWND hwndParent, DWORD dwInFlags, LPCSTR pcszFile, LPCSTR pcszURL, LPSTR pszAppBuf, UINT ucAppBufLen);
  HRESULT URLAssociationDialogW( HWND hwndParent, DWORD dwInFlags, LPCWSTR pcszFile, LPCWSTR pcszURL, LPWSTR pszAppBuf, UINT ucAppBufLen);
]]
return ffi.load( 'url.dll' )
