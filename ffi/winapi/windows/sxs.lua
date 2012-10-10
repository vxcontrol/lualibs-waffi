require( 'ffi/winapi/headers/windows' )
require( 'ffi/winapi/headers/dotnet' )
local ffi = require( 'ffi' )
ffi.cdef [[
  typedef DWORD CreateAsmNameObjFlags; //Alias
  HRESULT CreateAssemblyCache(      IAssemblyCache** ppAsmCache, DWORD dwReserved);
  HRESULT CreateAssemblyNameObject( LPASSEMBLYNAME* ppAssemblyNameObj, LPCWSTR szAssemblyName, CreateAsmNameObjFlags dwFlags, LPVOID pvReserved);
]]
ffi.load( 'SxS.dll' )
