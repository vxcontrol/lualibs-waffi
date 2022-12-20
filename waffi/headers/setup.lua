require( 'waffi.headers.windows' )
local ffi = require( 'ffi' )
ffi.cdef [[
  enum { LINE_LEN = 256 };
  typedef DWORD WINAPI_DiDriverType; //Alias
  typedef struct SP_DRVINFO_DATA_A {
    DWORD cbSize;
    WINAPI_DiDriverType DriverType;
    ULONG_PTR Reserved;
    CHAR Description[LINE_LEN];
    CHAR MfgName[LINE_LEN];
    CHAR ProviderName[LINE_LEN];
    FILETIME DriverDate;
    DWORDLONG DriverVersion;
  } SP_DRVINFO_DATA_A;
  typedef SP_DRVINFO_DATA_A *PSP_DRVINFO_DATA_A; //Pointer
  typedef struct SP_DRVINFO_DATA_W {
    DWORD cbSize;
    WINAPI_DiDriverType DriverType;
    ULONG_PTR Reserved;
    WCHAR Description[LINE_LEN];
    WCHAR MfgName[LINE_LEN];
    WCHAR ProviderName[LINE_LEN];
    FILETIME DriverDate;
    DWORDLONG DriverVersion;
  } SP_DRVINFO_DATA_W;
  typedef SP_DRVINFO_DATA_W *PSP_DRVINFO_DATA_W; //Pointer
]]
