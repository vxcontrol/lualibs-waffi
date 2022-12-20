require( 'waffi.headers.windows' )
local ffi = require( 'ffi' )
ffi.cdef [[
  typedef LPVOID PLDAPSearch; //Alias
  typedef struct WINAPI_LDAP_s {
    UINT_PTR sb_sd;
    UCHAR Reserved1[41];
    ULONG_PTR sb_naddr;
    UCHAR Reserved2[24];
  } WINAPI_LDAP_s;
  typedef struct LDAP {
    WINAPI_LDAP_s ld_sb;
    PCHAR ld_host;
    ULONG ld_version;
    UCHAR ld_lberoptions;
    ULONG ld_deref;
    ULONG ld_timelimit;
    ULONG ld_sizelimit;
    ULONG ld_errno;
    PCHAR ld_matched;
    PCHAR ld_error;
    ULONG ld_msgid;
    UCHAR Reserved3[25];
    ULONG ld_cldaptries;
    ULONG ld_cldaptimeout;
    ULONG ld_refhoplimit;
    ULONG ld_options;
  } LDAP;
  typedef LDAP *PLDAP; //Pointer
  typedef struct LDAPMessage {
    ULONG lm_msgid;
    ULONG lm_msgtype;
    PVOID lm_ber;
    LPVOID lm_chain;
    LPVOID lm_next;
    ULONG lm_time;
    PLDAP Connection;
    PVOID Request;
    ULONG lm_returncode;
    USHORT lm_referral;
    BOOLEAN lm_chased;
    BOOLEAN lm_eom;
    BOOLEAN ConnectionReferenced;
  } LDAPMessage;
  typedef LDAPMessage *PLDAPMessage; //Pointer
  typedef struct berval {
    ULONG bv_len;
    PCHAR bv_val;
  } berval;
  typedef berval BERVAL; //Pointer
  typedef BERVAL *PBERVAL; //Pointer
  typedef struct LDAPControlA {
    PCHAR ldctl_oid;
    struct berval ldctl_value;
    BOOLEAN ldctl_iscritical;
  } LDAPControlA;
  typedef LDAPControlA *PLDAPControlA; //Pointer
  typedef struct LDAPControlW {
    PWCHAR ldctl_oid;
    struct berval ldctl_value;
    BOOLEAN ldctl_iscritical;
  } LDAPControlW;
  typedef LDAPControlW *PLDAPControlW; //Pointer
  typedef struct LDAP_TIMEVAL {
    LONG tv_sec;
    LONG tv_usec;
  } LDAP_TIMEVAL;
  typedef LDAP_TIMEVAL l_timeval; //Alias
  typedef struct LDAPSortKeyA {
    PCHAR sk_attrtype;
    PCHAR sk_matchruleoid;
    BOOLEAN sk_reverseorder;
  } LDAPSortKeyA;
  typedef LDAPSortKeyA *PLDAPSortKeyA; //Pointer
  typedef struct LDAPSortKeyW {
    PWCHAR sk_attrtype;
    PWCHAR sk_matchruleoid;
    BOOLEAN sk_reverseorder;
  } LDAPSortKeyW;
  typedef LDAPSortKeyW *PLDAPSortKeyW; //Pointer
  typedef struct LDAPVLVInfo {
    int ldvlv_version;
    ULONG ldvlv_before_count;
    ULONG ldvlv_after_count;
    ULONG ldvlv_offset;
    ULONG ldvlv_count;
    PBERVAL ldvlv_attrvalue;
    PBERVAL ldvlv_context;
    VOID* ldvlv_extradata;
  } LDAPVLVInfo;
  typedef struct BerElement {
    PCHAR opaque;
  } BerElement;
  LDAP*           cldap_openA(                PCHAR HostName, ULONG PortNumber);
  LDAP*           cldap_openW(                PWCHAR HostName, ULONG PortNumber);
  LDAP*           ldap_openA(                 PCHAR HostName, ULONG PortNumber);
  LDAP*           ldap_openW(                 PWCHAR HostName, ULONG PortNumber);
  ULONG           ldap_bindA(                 LDAP* ld, PCHAR dn, PCHAR cred, ULONG method);
  ULONG           ldap_bindW(                 LDAP* ld, PWCHAR dn, PWCHAR cred, ULONG method);
  ULONG           ldap_bind_sA(               LDAP* ld, PCHAR dn, PCHAR cred, ULONG method);
  ULONG           ldap_bind_sW(               LDAP* ld, PWCHAR dn, PWCHAR cred, ULONG method);
  ULONG           ldap_simple_bindA(          LDAP* ld, PCHAR dn, PCHAR passwd);
  ULONG           ldap_simple_bindW(          LDAP* ld, PWCHAR dn, PWCHAR passwd);
  ULONG           ldap_simple_bind_sA(        LDAP* ld, PCHAR dn, PCHAR passwd);
  ULONG           ldap_simple_bind_sW(        LDAP* ld, PWCHAR dn, PWCHAR passwd);
  ULONG           ldap_sasl_bindA(            LDAP* ExternalHandle, const PCHAR DistName, const PCHAR AuthMechanism, const BERVAL* cred, PLDAPControlA* ServerCtrls, PLDAPControlA* ClientCtrls, int* MessageNumber);
  ULONG           ldap_sasl_bindW(            LDAP* ExternalHandle, const PWCHAR DistName, const PWCHAR AuthMechanism, const BERVAL* cred, PLDAPControlW* ServerCtrls, PLDAPControlW* ClientCtrls, int* MessageNumber);
  ULONG           ldap_sasl_bind_sA(          LDAP* ExternalHandle, const PCHAR DistName, const PCHAR AuthMechanism, const BERVAL* cred, PLDAPControlA* ServerCtrls, PLDAPControlA* ClientCtrls, PBERVAL* ServerData);
  ULONG           ldap_sasl_bind_sW(          LDAP* ExternalHandle, const PWCHAR DistName, const PWCHAR AuthMechanism, const BERVAL* cred, PLDAPControlW* ServerCtrls, PLDAPControlW* ClientCtrls, PBERVAL* ServerData);
  ULONG           ldap_connect(               LDAP* ld, LDAP_TIMEVAL* timeout);
  LDAP*           ldap_initA(                 PCHAR HostName, ULONG PortNumber);
  LDAP*           ldap_initW(                 PWCHAR HostName, ULONG PortNumber);
  LDAP*           ldap_sslinitA(              PCHAR HostName, ULONG PortNumber, int secure);
  LDAP*           ldap_sslinitW(              PWCHAR HostName, ULONG PortNumber, int secure);
  ULONG           ldap_get_optionA(           LDAP* ld, int option, void* outvalue);
  ULONG           ldap_get_optionW(           LDAP* ld, int option, void* outvalue);
  ULONG           ldap_set_optionA(           LDAP* ld, int option, void* invalue);
  ULONG           ldap_set_optionW(           LDAP* ld, int option, void* invalue);
  ULONG           ldap_abandon(               LDAP* ld, ULONG msgid);
  ULONG           ldap_unbind(                LDAP* ld);
  ULONG           ldap_unbind_s(              LDAP* ld);
  ULONG           ldap_addA(                  LDAP* ld, PCHAR dn);
  ULONG           ldap_addW(                  LDAP* ld, PWCHAR dn);
  ULONG           ldap_add_extA(              LDAP* ld, PCHAR dn, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls, ULONG* MessageNumber);
  ULONG           ldap_add_extW(              LDAP* ld, PWCHAR dn, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls, ULONG* MessageNumber);
  ULONG           ldap_add_sA(                LDAP* ld, PCHAR dn);
  ULONG           ldap_add_sW(                LDAP* ld, PWCHAR dn);
  ULONG           ldap_add_ext_sA(            LDAP* ld, PCHAR dn, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls);
  ULONG           ldap_add_ext_sW(            LDAP* ld, PWCHAR dn, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls);
  ULONG           ldap_compareA(              LDAP* ld, PCHAR dn, PCHAR attr, PCHAR value);
  ULONG           ldap_compareW(              LDAP* ld, PWCHAR dn, PWCHAR attr, PWCHAR value);
  ULONG           ldap_compare_extA(          LDAP* ld, PCHAR dn, PCHAR Attr, PCHAR Value, struct berval* Data, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls, ULONG* MessageNumber);
  ULONG           ldap_compare_extW(          LDAP* ld, PWCHAR dn, PWCHAR Attr, PWCHAR Value, struct berval* Data, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls, ULONG* MessageNumber);
  ULONG           ldap_compare_sA(            LDAP* ld, PCHAR dn, PCHAR attr, PCHAR value);
  ULONG           ldap_compare_sW(            LDAP* ld, PWCHAR dn, PWCHAR attr, PWCHAR value);
  ULONG           ldap_compare_ext_sA(        LDAP* ld, PCHAR dn, PCHAR Attr, PCHAR Value, struct berval* Data, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls);
  ULONG           ldap_compare_ext_sW(        LDAP* ld, PWCHAR dn, PWCHAR Attr, PWCHAR Value, struct berval* Data, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls);
  ULONG           ldap_deleteA(               LDAP* ld, PCHAR dn);
  ULONG           ldap_deleteW(               LDAP* ld, PWCHAR dn);
  ULONG           ldap_delete_extA(           LDAP* ld, PCHAR dn, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls, ULONG* MessageNumber);
  ULONG           ldap_delete_extW(           LDAP* ld, PWCHAR dn, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls, ULONG* MessageNumber);
  ULONG           ldap_delete_sA(             LDAP* ld, PCHAR dn);
  ULONG           ldap_delete_sW(             LDAP* ld, PWCHAR dn);
  ULONG           ldap_delete_ext_sA(         LDAP* ld, PCHAR dn, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls);
  ULONG           ldap_delete_ext_sW(         LDAP* ld, PWCHAR dn, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls);
  ULONG           ldap_extended_operation_sA( LDAP* ld, PCHAR Oid, struct berval* Data, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls, PCHAR* ReturnedOid, struct berval** ReturnedData);
  ULONG           ldap_extended_operation_sW( LDAP* ld, PWCHAR Oid, struct berval* Data, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls, PCHAR* ReturnedOid, struct berval** ReturnedData);
  ULONG           ldap_extended_operationA(   LDAP* ld, PCHAR Oid, struct berval* Data, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls, ULONG* MessageNumber);
  ULONG           ldap_extended_operationW(   LDAP* ld, PWCHAR Oid, struct berval* Data, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls, ULONG* MessageNumber);
  ULONG           ldap_close_extended_op(     LDAP* ld, ULONG MessageNumber);
  ULONG           ldap_modifyA(               LDAP* ld, PCHAR dn);
  ULONG           ldap_modifyW(               LDAP* ld, PWCHAR dn);
  ULONG           ldap_modify_extA(           LDAP* ld, PCHAR dn, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls, ULONG* MessageNumber);
  ULONG           ldap_modify_extW(           LDAP* ld, PWCHAR dn, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls, ULONG* MessageNumber);
  ULONG           ldap_modify_sA(             LDAP* ld, PCHAR dn);
  ULONG           ldap_modify_sW(             LDAP* ld, PWCHAR dn);
  ULONG           ldap_modify_ext_sA(         LDAP* ld, PCHAR dn, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls);
  ULONG           ldap_modify_ext_sW(         LDAP* ld, PWCHAR dn, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls);
  ULONG           ldap_check_filterA(         LDAP* ld, PCHAR SearchFilter);
  ULONG           ldap_check_filterW(         LDAP* ld, PWCHAR SearchFilter);
  ULONG           ldap_count_entries(         LDAP* ld, LDAPMessage* res);
  ULONG           ldap_count_references(      LDAP* ld, LDAPMessage* res);
  ULONG           ldap_count_valuesA(         PCHAR* vals);
  ULONG           ldap_count_valuesW(         PWCHAR* vals);
  ULONG           ldap_count_values_len(      struct berval** vals);
  ULONG           ldap_create_page_controlA(  PLDAP ExternalHandle, ULONG PageSize, struct berval* Cookie, UCHAR IsCritical, PLDAPControlA* Control);
  ULONG           ldap_create_page_controlW(  PLDAP ExternalHandle, ULONG PageSize, struct berval* Cookie, UCHAR IsCritical, PLDAPControlW* Control);
  ULONG           ldap_create_sort_controlA(  PLDAP ExternalHandle, PLDAPSortKeyA* SortKeys, UCHAR IsCritical, PLDAPControlA* Control);
  ULONG           ldap_create_sort_controlW(  PLDAP ExternalHandle, PLDAPSortKeyW* SortKeys, UCHAR IsCritical, PLDAPControlW* Control);
  INT             ldap_create_vlv_controlA(   LDAP* ld, LDAPVLVInfo* Vlvinfop, char IsCritical, LDAPControlA** ctrlp);
  INT             ldap_create_vlv_controlW(   LDAP* ld, LDAPVLVInfo* Vlvinfop, char IsCritical, LDAPControlW** ctrlp);
  ULONG           ldap_encode_sort_controlA(  PLDAP ExternalHandle, PLDAPSortKeyA* SortKeys, PLDAPControlA Control, BOOLEAN IsCritical);
  ULONG           ldap_encode_sort_controlW(  PLDAP ExternalHandle, PLDAPSortKeyW* SortKeys, PLDAPControlW Control, BOOLEAN IsCritical);
  ULONG           ldap_escape_filter_elementA(PCHAR sourceFilterElement, ULONG sourceLength, PCHAR destFilterElement, ULONG destLength);
  ULONG           ldap_escape_filter_elementW(PWCHAR sourceFilterElement, ULONG sourceLength, PCHAR destFilterElement, ULONG destLength);
  PCHAR           ldap_first_attributeA(      LDAP* ld, LDAPMessage* entry, BerElement** ptr);
  PWCHAR          ldap_first_attributeW(      LDAP* ld, LDAPMessage* entry, BerElement** ptr);
  PCHAR           ldap_next_attributeA(       LDAP* ld, LDAPMessage* entry, BerElement* ptr);
  PWCHAR          ldap_next_attributeW(       LDAP* ld, LDAPMessage* entry, BerElement* ptr);
  LDAPMessage*    ldap_first_entry(           LDAP* ld, LDAPMessage* res);
  LDAPMessage*    ldap_next_entry(            LDAP* ld, LDAPMessage* entry);
  LDAPMessage*    ldap_first_reference(       LDAP* ld, LDAPMessage* res);
  LDAPMessage*    ldap_next_reference(        LDAP* ld, LDAPMessage* entry);
  ULONG           ldap_get_next_page(         PLDAP ExternalHandle, PLDAPSearch SearchHandle, ULONG PageSize, ULONG* MessageNumber);
  ULONG           ldap_get_next_page_s(       PLDAP ExternalHandle, PLDAPSearch SearchHandle, struct l_timeval* timeout, ULONG PageSize, ULONG* TotalCount, LDAPMessage** Results);
  ULONG           ldap_get_paged_count(       PLDAP ExternalHandle, PLDAPSearch SearchBlock, ULONG* TotalCount, PLDAPMessage Results);
  PCHAR*          ldap_get_valuesA(           LDAP* ld, LDAPMessage* entry, PCHAR attr);
  PWCHAR*         ldap_get_valuesW(           LDAP* ld, LDAPMessage* entry, PWCHAR attr);
  struct berval** ldap_get_values_lenA(       LDAP* ExternalHandle, LDAPMessage* Message, PCHAR attr);
  struct berval** ldap_get_values_lenW(       LDAP* ExternalHandle, LDAPMessage* Message, PWCHAR attr);
  ULONG           ldap_parse_extended_resultA(LDAP* Connection, LDAPMessage* ResultMessage, PCHAR* ResultOID, struct berval** ResultData, BOOLEAN Freeit);
  ULONG           ldap_parse_extended_resultW(LDAP* Connection, LDAPMessage* ResultMessage, PWCHAR* ResultOID, struct berval** ResultData, BOOLEAN Freeit);
  ULONG           ldap_parse_page_controlA(   PLDAP ExternalHandle, PLDAPControlA* ServerControls, ULONG* TotalCount, struct berval** Cookie);
  ULONG           ldap_parse_page_controlW(   PLDAP ExternalHandle, PLDAPControlW* ServerControls, ULONG* TotalCount, struct berval** Cookie);
  ULONG           ldap_parse_referenceA(      LDAP* Connection, LDAPMessage* ResultMessage, PCHAR** Referrals);
  ULONG           ldap_parse_referenceW(      LDAP* Connection, LDAPMessage* ResultMessage, PWCHAR** Referrals);
  ULONG           ldap_parse_resultA(         LDAP* Connection, LDAPMessage* ResultMessage, ULONG* ReturnCode, PCHAR* MatchedDNs, PCHAR* ErrorMessage, PCHAR** Referrals, PLDAPControlA** ServerControls, BOOLEAN Freeit);
  ULONG           ldap_parse_resultW(         LDAP* Connection, LDAPMessage* ResultMessage, ULONG* ReturnCode, PWCHAR* MatchedDNs, PWCHAR* ErrorMessage, PWCHAR** Referrals, PLDAPControlW** ServerControls, BOOLEAN Freeit);
  ULONG           ldap_parse_sort_controlA(   PLDAP ExternalHandle, PLDAPControlA* Control, ULONG* Result, PCHAR* Attribute);
  ULONG           ldap_parse_sort_controlW(   PLDAP ExternalHandle, PLDAPControlW* Control, ULONG* Result, PWCHAR* Attribute);
  int             ldap_parse_vlv_controlA(    LDAP* ld, LDAPControlA** ctrls, unsigned long* target_posp, unsigned long* list_countp, struct berval** contextp, int* errcodep);
  int             ldap_parse_vlv_controlW(    LDAP* ld, LDAPControlW** ctrls, unsigned long* target_posp, unsigned long* list_countp, struct berval** contextp, int* errcodep);
  ULONG           ldap_result(                LDAP* ld, ULONG msgid, ULONG all, struct l_timeval* timeout, LDAPMessage** res);
  ULONG           ldap_searchA(               LDAP* ld, PCHAR base, ULONG scope, PCHAR filter, ULONG attrsonly);
  ULONG           ldap_searchW(               LDAP* ld, PWCHAR base, ULONG scope, PWCHAR filter, ULONG attrsonly);
  ULONG           ldap_search_sA(             LDAP* ld, PCHAR base, ULONG scope, PCHAR filter, ULONG attrsonly, LDAPMessage** res);
  ULONG           ldap_search_sW(             LDAP* ld, PWCHAR base, ULONG scope, PWCHAR filter, ULONG attrsonly, LDAPMessage** res);
  ULONG           ldap_search_stA(            LDAP* ld, PCHAR base, ULONG scope, PCHAR filter, ULONG attrsonly, struct l_timeval* timeout, LDAPMessage** res);
  ULONG           ldap_search_stW(            LDAP* ld, PWCHAR base, ULONG scope, PWCHAR filter, ULONG attrsonly, struct l_timeval* timeout, LDAPMessage** res);
  ULONG           ldap_search_extA(           LDAP* ld, PCHAR base, ULONG scope, PCHAR filter, ULONG attrsonly, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls, ULONG TimeLimit, ULONG SizeLimit, ULONG* MessageNumber);
  ULONG           ldap_search_extW(           LDAP* ld, PWCHAR base, ULONG scope, PWCHAR filter, ULONG attrsonly, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls, ULONG TimeLimit, ULONG SizeLimit, ULONG* MessageNumber);
  ULONG           ldap_search_ext_sA(         LDAP* ld, PCHAR base, ULONG scope, PCHAR filter, ULONG attrsonly, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls, struct l_timeval* timeout, ULONG SizeLimit, LDAPMessage** res);
  ULONG           ldap_search_ext_sW(         LDAP* ld, PWCHAR base, ULONG scope, PWCHAR filter, ULONG attrsonly, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls, struct l_timeval* timeout, ULONG SizeLimit, LDAPMessage** res);
  PLDAPSearch     ldap_search_init_pageA(     PLDAP ExternalHandle, PCHAR DistinguishedName, ULONG ScopeOfSearch, PCHAR SearchFilter, ULONG AttributesOnly, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls, ULONG PageTimeLimit, ULONG TotalSizeLimit, PLDAPSortKeyA* SortKeys);
  PLDAPSearch     ldap_search_init_pageW(     PLDAP ExternalHandle, PWCHAR DistinguishedName, ULONG ScopeOfSearch, PWCHAR SearchFilter, ULONG AttributesOnly, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls, ULONG PageTimeLimit, ULONG TotalSizeLimit, PLDAPSortKeyW* SortKeys);
  ULONG           ldap_search_abandon_page(   PLDAP ExternalHandle, PLDAPSearch SearchBlock);
  PCHAR           ldap_err2stringA(           ULONG err);
  PWCHAR          ldap_err2stringW(           ULONG err);
  ULONG           LdapGetLastError(           );
  ULONG           LdapMapErrorToWin32(        ULONG LdapError);
  ULONG           ldap_result2error(          LDAP* ld, LDAPMessage* res, ULONG freeit);
  ULONG           ldap_control_freeA(         LDAPControlA* Control);
  ULONG           ldap_control_freeW(         LDAPControlW* Control);
  ULONG           ldap_controls_freeA(        LDAPControlA** Controls);
  ULONG           ldap_controls_freeW(        LDAPControlW** Controls);
  VOID            ldap_memfreeA(              PCHAR Block);
  VOID            ldap_memfreeW(              PWCHAR Block);
  ULONG           ldap_msgfree(               LDAPMessage* res);
  ULONG           ldap_value_freeA(           PCHAR* vals);
  ULONG           ldap_value_freeW(           PWCHAR* vals);
  ULONG           ldap_value_free_len(        struct berval** vals);
  PCHAR           ldap_dn2ufnA(               PCHAR dn);
  PWCHAR          ldap_dn2ufnW(               PWCHAR dn);
  ULONG           ldap_ufn2dnA(               PCHAR ufn, PCHAR* pDn);
  ULONG           ldap_ufn2dnW(               PWCHAR ufn, PWCHAR* pDn);
  PCHAR*          ldap_explode_dnA(           PCHAR dn, ULONG notypes);
  PWCHAR*         ldap_explode_dnW(           PWCHAR dn, ULONG notypes);
  PCHAR           ldap_get_dnA(               LDAP* ld, LDAPMessage* entry);
  PWCHAR          ldap_get_dnW(               LDAP* ld, LDAPMessage* entry);
  LDAP*           ldap_conn_from_msg(         LDAP* PrimaryConn, LDAPMessage* res);
  ULONG           ldap_modrdn2A(              LDAP* ExternalHandle, PCHAR DistinguishedName, PCHAR NewDistinguishedName, INT DeleteOldRdn);
  ULONG           ldap_modrdn2W(              LDAP* ExternalHandle, PWCHAR DistinguishedName, PWCHAR NewDistinguishedName, INT DeleteOldRdn);
  ULONG           ldap_modrdn2_sA(            LDAP* ExternalHandle, PCHAR DistinguishedName, PCHAR NewDistinguishedName, INT DeleteOldRdn);
  ULONG           ldap_modrdn2_sW(            LDAP* ExternalHandle, PWCHAR DistinguishedName, PWCHAR NewDistinguishedName, INT DeleteOldRdn);
  ULONG           ldap_rename_extA(           LDAP* ld, PCHAR dn, PCHAR NewRDN, PCHAR NewParent, INT DeleteOldRdn, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls, ULONG* MessageNumber);
  ULONG           ldap_rename_extW(           LDAP* ld, PWCHAR dn, PWCHAR NewRDN, PWCHAR NewParent, INT DeleteOldRdn, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls, ULONG* MessageNumber);
  ULONG           ldap_rename_ext_sA(         LDAP* ld, PCHAR dn, PCHAR NewRDN, PCHAR NewParent, INT DeleteOldRdn, PLDAPControlA* ServerControls, PLDAPControlA* ClientControls);
  ULONG           ldap_rename_ext_sW(         LDAP* ld, PWCHAR dn, PWCHAR NewRDN, PWCHAR NewParent, INT DeleteOldRdn, PLDAPControlW* ServerControls, PLDAPControlW* ClientControls);
  int             LdapUnicodeToUTF8(          LPCWSTR lpSrcStr, int cchSrc, LPSTR lpDestStr, int cchDest);
  int             LdapUTF8ToUnicode(          LPCSTR lpSrcStr, int cchSrc, LPWSTR lpDestStr, int cchDest);
  BerElement*     ber_init(                   BERVAL* pBerVal);
  void            ber_free(                   BerElement* pBerElement, INT fbuf);
  void            ber_bvfree(                 BERVAL* pBerVal);
  void            ber_bvecfree(               PBERVAL* pBerVal);
  BERVAL*         ber_bvdup(                  BERVAL* pBerVal);
  BerElement*     ber_alloc_t(                INT options);
  ULONG           ber_skip_tag(               BerElement* pBerElement, ULONG* pLen);
  ULONG           ber_peek_tag(               BerElement* pBerElement, ULONG* pLen);
  ULONG           ber_first_element(          BerElement* pBerElement, ULONG* pLen, CHAR** ppOpaque);
  ULONG           ber_next_element(           BerElement* pBerElement, ULONG* pLen, CHAR* opaque);
  INT             ber_flatten(                BerElement* pBerElement, PBERVAL* pBerVal);
  INT             ber_printf(                 BerElement* pBerElement, PCHAR fmt);
  INT             ber_scanf(                  BerElement* pBerElement, PCHAR fmt);
]]
return ffi.load( 'Wldap32.dll' )
