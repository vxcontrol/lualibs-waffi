require( 'waffi.headers.windows' )
require( 'waffi.headers.cryptography' )
local ffi = require( 'ffi' )
ffi.cdef [[
  typedef LPVOID PFNCMHOOKPROC; //Alias
  typedef LPVOID PFNCMFILTERPROC; //Alias
  typedef struct CERT_SELECT_STRUCT_A {
    DWORD dwSize;
    HWND hwndParent;
    HINSTANCE hInstance;
    LPCSTR pTemplateName;
    DWORD dwFlags;
    LPCSTR szTitle;
    DWORD cCertStore;
    HCERTSTORE* arrayCertStore;
    LPCSTR szPurposeOid;
    DWORD cCertContext;
    PCCERT_CONTEXT* arrayCertContext;
    LPARAM lCustData;
    PFNCMHOOKPROC pfnHook;
    PFNCMFILTERPROC pfnFilter;
    LPCSTR szHelpFileName;
    DWORD dwHelpId;
    HCRYPTPROV hprov;
  } CERT_SELECT_STRUCT_A;
  typedef CERT_SELECT_STRUCT_A *PCERT_SELECT_STRUCT_A; //Pointer
  typedef struct CERT_SELECT_STRUCT_W {
    DWORD dwSize;
    HWND hwndParent;
    HINSTANCE hInstance;
    LPCWSTR pTemplateName;
    DWORD dwFlags;
    LPCWSTR szTitle;
    DWORD cCertStore;
    HCERTSTORE* arrayCertStore;
    LPCWSTR szPurposeOid;
    DWORD cCertContext;
    PCCERT_CONTEXT* arrayCertContext;
    LPARAM lCustData;
    PFNCMHOOKPROC pfnHook;
    PFNCMFILTERPROC pfnFilter;
    LPCWSTR szHelpFileName;
    DWORD dwHelpId;
    HCRYPTPROV hprov;
  } CERT_SELECT_STRUCT_W;
  typedef CERT_SELECT_STRUCT_W *PCERT_SELECT_STRUCT_W; //Pointer
  typedef struct CTL_MODIFY_REQUEST {
    PCCERT_CONTEXT pccert;
    DWORD dwOperation;
    DWORD dwError;
  } CTL_MODIFY_REQUEST;
  typedef CTL_MODIFY_REQUEST *PCTL_MODIFY_REQUEST; //Pointer
  BOOL    CertSelectCertificateA(        PCERT_SELECT_STRUCT_A pCertSelectInfo);
  BOOL    CertSelectCertificateW(        PCERT_SELECT_STRUCT_W pCertSelectInfo);
  DWORD   GetFriendlyNameOfCertA(        PCCERT_CONTEXT pccert, LPSTR pchBuffer, DWORD cchBuffer);
  DWORD   GetFriendlyNameOfCertW(        PCCERT_CONTEXT pccert, LPWSTR pchBuffer, DWORD cchBuffer);
  HRESULT CertModifyCertificatesToTrust( int cCerts, PCTL_MODIFY_REQUEST rgCerts, LPCSTR szPurpose, HWND hwnd, HCERTSTORE hcertstoreTrust, PCCERT_CONTEXT pccertSigner);
]]
return ffi.load( 'CryptDlg.dll' )
