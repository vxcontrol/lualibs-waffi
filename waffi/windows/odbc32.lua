require( 'waffi.headers.odbc' )
local ffi = require( 'ffi' )
ffi.cdef [[
  typedef short SQLSMALLINT; //Alias
  typedef unsigned short SQLUSMALLINT; //Alias
  typedef void* SQLPOINTER; //Alias
  typedef long SQLINTEGER; //Alias
  typedef INT_PTR SQLLEN; //Alias
  typedef UINT_PTR SQLULEN; //Alias
  typedef UINT_PTR SQLSETPOSIROW; //Alias
  typedef HWND SQLHWND; //Alias
  typedef void* SQLHANDLE; //Alias
  typedef SQLHANDLE SQLHENV; //Alias
  typedef SQLHANDLE SQLHDBC; //Alias
  typedef SQLHANDLE SQLHSTMT; //Alias
  typedef SQLHANDLE SQLHDESC; //Alias
  typedef CHAR SQLCHAR; //Alias
  typedef WCHAR SQLWCHAR; //Alias
  typedef SQLSMALLINT SQLRETURN; //Alias
  static const SQLRETURN SQL_SUCCESS = 0;
  static const SQLRETURN SQL_SUCCESS_WITH_INFO = 1;
  static const SQLRETURN SQL_NO_DATA = 100;
  static const SQLRETURN SQL_PARAM_DATA_AVAILABLE = 101;
  static const SQLRETURN SQL_ERROR = -1;
  static const SQLRETURN SQL_INVALID_HANDLE = -2;
  static const SQLRETURN SQL_STILL_EXECUTING = 2;
  static const SQLRETURN SQL_NEED_DATA = 99;
  typedef SQLUSMALLINT WINAPI_SQL_DRIVER_COMPLETION; //Alias
  static const WINAPI_SQL_DRIVER_COMPLETION SQL_DRIVER_NOPROMPT = 0;
  static const WINAPI_SQL_DRIVER_COMPLETION SQL_DRIVER_COMPLETE = 1;
  static const WINAPI_SQL_DRIVER_COMPLETION SQL_DRIVER_PROMPT = 2;
  static const WINAPI_SQL_DRIVER_COMPLETION SQL_DRIVER_COMPLETE_REQUIRED = 3;
  typedef SQLSMALLINT WINAPI_SQL_ENDTRAN_OPTION; //Alias
  static const WINAPI_SQL_ENDTRAN_OPTION SQL_COMMIT = 0;
  static const WINAPI_SQL_ENDTRAN_OPTION SQL_ROLLBACK = 1;
  typedef SQLSMALLINT WINAPI_SQL_FETCH_TYPE; //Alias
  static const WINAPI_SQL_FETCH_TYPE SQL_FETCH_NEXT = 1;
  static const WINAPI_SQL_FETCH_TYPE SQL_FETCH_FIRST = 2;
  static const WINAPI_SQL_FETCH_TYPE SQL_FETCH_LAST = 3;
  static const WINAPI_SQL_FETCH_TYPE SQL_FETCH_PRIOR = 4;
  static const WINAPI_SQL_FETCH_TYPE SQL_FETCH_ABSOLUTE = 5;
  static const WINAPI_SQL_FETCH_TYPE SQL_FETCH_RELATIVE = 6;
  typedef SQLSMALLINT WINAPI_SQL_HANDLE_TYPE; //Alias
  static const WINAPI_SQL_HANDLE_TYPE SQL_HANDLE_ENV = 1;
  static const WINAPI_SQL_HANDLE_TYPE SQL_HANDLE_DBC = 2;
  static const WINAPI_SQL_HANDLE_TYPE SQL_HANDLE_STMT = 3;
  static const WINAPI_SQL_HANDLE_TYPE SQL_HANDLE_DESC = 4;
  typedef SQLUSMALLINT WINAPI_SQL_FREESTMT_OPTION; //Alias
  static const WINAPI_SQL_FREESTMT_OPTION SQL_CLOSE = 0;
  static const WINAPI_SQL_FREESTMT_OPTION SQL_DROP = 1;
  static const WINAPI_SQL_FREESTMT_OPTION SQL_UNBIND = 2;
  static const WINAPI_SQL_FREESTMT_OPTION SQL_RESET_PARAMS = 3;
  SQLRETURN SQLAllocConnect(     SQLHENV EnvironmentHandle, SQLHDBC* ConnectionHandle);
  SQLRETURN SQLAllocEnv(         SQLHENV* EnvironmentHandle);
  SQLRETURN SQLAllocHandle(      WINAPI_SQL_HANDLE_TYPE HandleType, SQLHANDLE InputHandle, SQLHANDLE* OutputHandlePtr);
  SQLRETURN SQLAllocStmt(        SQLHDBC ConnectionHandle, SQLHSTMT* StatementHandle);
  SQLRETURN SQLBindCol(          SQLHSTMT StatementHandle, SQLUSMALLINT ColumnNumber, SQLSMALLINT TargetType, SQLPOINTER TargetValuePtr, SQLLEN BufferLength, SQLLEN* StrLen_or_Ind);
  SQLRETURN SQLBindParam(        SQLHSTMT StatementHandle, SQLUSMALLINT ParameterNumber, SQLSMALLINT ValueType, SQLSMALLINT ParameterType, SQLULEN LengthPrecision, SQLSMALLINT ParameterScale, SQLPOINTER ParameterValue, SQLLEN* StrLen_or_IndPtr);
  SQLRETURN SQLBindParameter(    SQLHSTMT StatementHandle, SQLUSMALLINT ParameterNumber, SQLSMALLINT InputOutputType, SQLSMALLINT ValueType, SQLSMALLINT ParameterType, SQLULEN ColumnSize, SQLSMALLINT DecimalDigits, SQLPOINTER ParameterValuePtr, SQLLEN BufferLength, SQLLEN* StrLen_or_IndPtr);
  SQLRETURN SQLBrowseConnectA(   SQLHDBC ConnectionHandle, SQLCHAR* InConnectionString, SQLSMALLINT StringLength1, SQLCHAR* OutConnectionString, SQLSMALLINT BufferLength, SQLSMALLINT* StringLength2Ptr);
  SQLRETURN SQLBrowseConnectW(   SQLHDBC ConnectionHandle, SQLWCHAR* InConnectionString, SQLSMALLINT StringLength1, SQLWCHAR* OutConnectionString, SQLSMALLINT BufferLength, SQLSMALLINT* StringLength2Ptr);
  SQLRETURN SQLBulkOperations(   SQLHSTMT StatementHandle, SQLUSMALLINT Operation);
  SQLRETURN SQLCancel(           SQLHSTMT StatementHandle);
  SQLRETURN SQLCancelHandle(     WINAPI_SQL_HANDLE_TYPE HandleType, SQLHANDLE Handle);
  SQLRETURN SQLCloseCursor(      SQLHSTMT StatementHandle);
  SQLRETURN SQLColAttributeA(     SQLHSTMT StatementHandle, SQLUSMALLINT ColumnNumber, SQLUSMALLINT FieldIdentifier, SQLPOINTER CharacterAttributePtr, SQLSMALLINT BufferLength, SQLSMALLINT* StringLengthPtr, SQLLEN* NumericAttributePtr);
  SQLRETURN SQLColAttributeW(     SQLHSTMT StatementHandle, SQLUSMALLINT ColumnNumber, SQLUSMALLINT FieldIdentifier, SQLPOINTER CharacterAttributePtr, SQLSMALLINT BufferLength, SQLSMALLINT* StringLengthPtr, SQLLEN* NumericAttributePtr);
  SQLRETURN SQLColAttributesA(   SQLHSTMT hstmt, SQLUSMALLINT icol, SQLUSMALLINT fDescType, SQLPOINTER rgbDesc, SQLSMALLINT cbDescMax, SQLSMALLINT* pcbDesc, SQLLEN* pfDesc);
  SQLRETURN SQLColAttributesW(   SQLHSTMT hstmt, SQLUSMALLINT icol, SQLUSMALLINT fDescType, SQLPOINTER rgbDesc, SQLSMALLINT cbDescMax, SQLSMALLINT* pcbDesc, SQLLEN* pfDesc);
  SQLRETURN SQLColumnPrivilegesA(SQLHSTMT StatementHandle, SQLCHAR* CatalogName, SQLSMALLINT NameLength1, SQLCHAR* SchemaName, SQLSMALLINT NameLength2, SQLCHAR* TableName, SQLSMALLINT NameLength3, SQLCHAR* ColumnName, SQLSMALLINT NameLength4);
  SQLRETURN SQLColumnPrivilegesW(SQLHSTMT StatementHandle, SQLWCHAR* CatalogName, SQLSMALLINT NameLength1, SQLWCHAR* SchemaName, SQLSMALLINT NameLength2, SQLWCHAR* TableName, SQLSMALLINT NameLength3, SQLWCHAR* ColumnName, SQLSMALLINT NameLength4);
  SQLRETURN SQLColumnsA(         SQLHSTMT StatementHandle, SQLCHAR* CatalogName, SQLSMALLINT NameLength1, SQLCHAR* SchemaName, SQLSMALLINT NameLength2, SQLCHAR* TableName, SQLSMALLINT NameLength3, SQLCHAR* ColumnName, SQLSMALLINT NameLength4);
  SQLRETURN SQLColumnsW(         SQLHSTMT StatementHandle, SQLWCHAR* CatalogName, SQLSMALLINT NameLength1, SQLWCHAR* SchemaName, SQLSMALLINT NameLength2, SQLWCHAR* TableName, SQLSMALLINT NameLength3, SQLWCHAR* ColumnName, SQLSMALLINT NameLength4);
  SQLRETURN SQLCompleteAsync(    SQLSMALLINT HandleType, SQLHANDLE Handle, RETCODE* AsyncRetCodePtr);
  SQLRETURN SQLConnectA(         SQLHDBC ConnectionHandle, SQLCHAR* ServerName, SQLSMALLINT NameLength1, SQLCHAR* UserName, SQLSMALLINT NameLength2, SQLCHAR* Authentication, SQLSMALLINT NameLength3);
  SQLRETURN SQLConnectW(         SQLHDBC ConnectionHandle, SQLWCHAR* ServerName, SQLSMALLINT NameLength1, SQLWCHAR* UserName, SQLSMALLINT NameLength2, SQLWCHAR* Authentication, SQLSMALLINT NameLength3);
  SQLRETURN SQLCopyDesc(         SQLHDESC SourceDescHandle, SQLHDESC TargetDescHandle);
  SQLRETURN SQLDataSourcesA(     SQLHENV EnvironmentHandle, SQLUSMALLINT Direction, SQLCHAR* ServerName, SQLSMALLINT BufferLength1, SQLSMALLINT* NameLength1Ptr, SQLCHAR* Description, SQLSMALLINT BufferLength2, SQLSMALLINT* NameLength2Ptr);
  SQLRETURN SQLDataSourcesW(     SQLHENV EnvironmentHandle, SQLUSMALLINT Direction, SQLWCHAR* ServerName, SQLSMALLINT BufferLength1, SQLSMALLINT* NameLength1Ptr, SQLWCHAR* Description, SQLSMALLINT BufferLength2, SQLSMALLINT* NameLength2Ptr);
  SQLRETURN SQLDescribeColA(     SQLHSTMT StatementHandle, SQLUSMALLINT ColumnNumber, SQLCHAR* ColumnName, SQLSMALLINT BufferLength, SQLSMALLINT* NameLengthPtr, SQLSMALLINT* DataTypePtr, SQLULEN* ColumnSizePtr, SQLSMALLINT* DecimalDigitsPtr, SQLSMALLINT* NullablePtr);
  SQLRETURN SQLDescribeColW(     SQLHSTMT StatementHandle, SQLUSMALLINT ColumnNumber, SQLWCHAR* ColumnName, SQLSMALLINT BufferLength, SQLSMALLINT* NameLengthPtr, SQLSMALLINT* DataTypePtr, SQLULEN* ColumnSizePtr, SQLSMALLINT* DecimalDigitsPtr, SQLSMALLINT* NullablePtr);
  SQLRETURN SQLDescribeParam(    SQLHSTMT StatementHandle, SQLUSMALLINT ParameterNumber, SQLSMALLINT* DataTypePtr, SQLULEN* ParameterSizePtr, SQLSMALLINT* DecimalDigitsPtr, SQLSMALLINT* NullablePtr);
  SQLRETURN SQLDisconnect(       SQLHDBC ConnectionHandle);
  SQLRETURN SQLDriverConnectA(   SQLHDBC ConnectionHandle, SQLHWND WindowHandle, SQLCHAR* InConnectionString, SQLSMALLINT StringLength1, SQLCHAR* OutConnectionString, SQLSMALLINT BufferLength, SQLSMALLINT* StringLength2Ptr, WINAPI_SQL_DRIVER_COMPLETION DriverCompletion);
  SQLRETURN SQLDriverConnectW(   SQLHDBC ConnectionHandle, SQLHWND WindowHandle, SQLWCHAR* InConnectionString, SQLSMALLINT StringLength1, SQLWCHAR* OutConnectionString, SQLSMALLINT BufferLength, SQLSMALLINT* StringLength2Ptr, WINAPI_SQL_DRIVER_COMPLETION DriverCompletion);
  SQLRETURN SQLDriversA(         SQLHENV EnvironmentHandle, SQLUSMALLINT Direction, SQLCHAR* DriverDescription, SQLSMALLINT BufferLength1, SQLSMALLINT* DescriptionLengthPtr, SQLCHAR* DriverAttributes, SQLSMALLINT BufferLength2, SQLSMALLINT* AttributesLengthPtr);
  SQLRETURN SQLDriversW(         SQLHENV EnvironmentHandle, SQLUSMALLINT Direction, SQLWCHAR* DriverDescription, SQLSMALLINT BufferLength1, SQLSMALLINT* DescriptionLengthPtr, SQLWCHAR* DriverAttributes, SQLSMALLINT BufferLength2, SQLSMALLINT* AttributesLengthPtr);
  SQLRETURN SQLEndTran(          WINAPI_SQL_HANDLE_TYPE HandleType, SQLHANDLE Handle, WINAPI_SQL_ENDTRAN_OPTION CompletionType);
  SQLRETURN SQLErrorA(           SQLHENV EnvironmentHandle, SQLHDBC ConnectionHandle, SQLHSTMT StatementHandle, SQLCHAR* SQLState, SQLINTEGER* NativeError, SQLCHAR* MessageText, SQLSMALLINT BufferLength, SQLSMALLINT* TextLength);
  SQLRETURN SQLErrorW(           SQLHENV EnvironmentHandle, SQLHDBC ConnectionHandle, SQLHSTMT StatementHandle, SQLWCHAR* SQLState, SQLINTEGER* NativeError, SQLWCHAR* MessageText, SQLSMALLINT BufferLength, SQLSMALLINT* TextLength);
  SQLRETURN SQLExecDirectA(      SQLHSTMT StatementHandle, SQLCHAR* StatementText, SQLINTEGER TextLength);
  SQLRETURN SQLExecDirectW(      SQLHSTMT StatementHandle, SQLWCHAR* StatementText, SQLINTEGER TextLength);
  SQLRETURN SQLExecute(          SQLHSTMT StatementHandle);
  SQLRETURN SQLExtendedFetch(    SQLHSTMT StatementHandle, SQLUSMALLINT FetchOrientation, SQLLEN FetchOffset, SQLULEN* RowCountPtr, SQLUSMALLINT* RowStatusArray);
  SQLRETURN SQLFetch(            SQLHSTMT StatementHandle);
  SQLRETURN SQLFetchScroll(      SQLHSTMT StatementHandle, WINAPI_SQL_FETCH_TYPE FetchOrientation, SQLLEN FetchOffset);
  SQLRETURN SQLForeignKeysA(     SQLHSTMT StatementHandle, SQLCHAR* PKCatalogName, SQLSMALLINT NameLength1, SQLCHAR* PKSchemaName, SQLSMALLINT NameLength2, SQLCHAR* PKTableName, SQLSMALLINT NameLength3, SQLCHAR* FKCatalogName, SQLSMALLINT NameLength4, SQLCHAR* FKSchemaName, SQLSMALLINT NameLength5, SQLCHAR* FKTableName, SQLSMALLINT NameLength6);
  SQLRETURN SQLForeignKeysW(     SQLHSTMT StatementHandle, SQLWCHAR* PKCatalogName, SQLSMALLINT NameLength1, SQLWCHAR* PKSchemaName, SQLSMALLINT NameLength2, SQLWCHAR* PKTableName, SQLSMALLINT NameLength3, SQLWCHAR* FKCatalogName, SQLSMALLINT NameLength4, SQLWCHAR* FKSchemaName, SQLSMALLINT NameLength5, SQLWCHAR* FKTableName, SQLSMALLINT NameLength6);
  SQLRETURN SQLFreeConnect(      SQLHDBC ConnectionHandle);
  SQLRETURN SQLFreeEnv(          SQLHENV EnvironmentHandle);
  SQLRETURN SQLFreeHandle(       WINAPI_SQL_HANDLE_TYPE HandleType, SQLHANDLE Handle);
  SQLRETURN SQLFreeStmt(         SQLHSTMT StatementHandle, WINAPI_SQL_FREESTMT_OPTION Option);
  SQLRETURN SQLGetConnectAttrA(  SQLHDBC ConnectionHandle, SQLINTEGER Attribute, SQLPOINTER ValuePtr, SQLINTEGER BufferLength, SQLINTEGER* StringLengthPtr);
  SQLRETURN SQLGetConnectAttrW(  SQLHDBC ConnectionHandle, SQLINTEGER Attribute, SQLPOINTER ValuePtr, SQLINTEGER BufferLength, SQLINTEGER* StringLengthPtr);
  SQLRETURN SQLGetConnectOptionA(SQLHDBC ConnectionHandle, SQLUSMALLINT Option, SQLPOINTER Value);
  SQLRETURN SQLGetConnectOptionW(SQLHDBC ConnectionHandle, SQLUSMALLINT Option, SQLPOINTER Value);
  SQLRETURN SQLGetCursorNameA(   SQLHSTMT StatementHandle, SQLCHAR* CursorName, SQLSMALLINT BufferLength, SQLSMALLINT* NameLengthPtr);
  SQLRETURN SQLGetCursorNameW(   SQLHSTMT StatementHandle, SQLWCHAR* CursorName, SQLSMALLINT BufferLength, SQLSMALLINT* NameLengthPtr);
  SQLRETURN SQLGetData(          SQLHSTMT StatementHandle, SQLUSMALLINT Col_or_Param_Num, SQLSMALLINT TargetType, SQLPOINTER TargetValuePtr, SQLLEN BufferLength, SQLLEN* StrLen_or_IndPtr);
  SQLRETURN SQLGetDescFieldA(    SQLHDESC DescriptorHandle, SQLSMALLINT RecNumber, SQLSMALLINT FieldIdentifier, SQLPOINTER ValuePtr, SQLINTEGER BufferLength, SQLINTEGER* StringLengthPtr);
  SQLRETURN SQLGetDescFieldW(    SQLHDESC DescriptorHandle, SQLSMALLINT RecNumber, SQLSMALLINT FieldIdentifier, SQLPOINTER ValuePtr, SQLINTEGER BufferLength, SQLINTEGER* StringLengthPtr);
  SQLRETURN SQLGetDescRecA(      SQLHDESC DescriptorHandle, SQLSMALLINT RecNumber, SQLCHAR* Name, SQLSMALLINT BufferLength, SQLSMALLINT* StringLengthPtr, SQLSMALLINT* TypePtr, SQLSMALLINT* SubTypePtr, SQLLEN* LengthPtr, SQLSMALLINT* PrecisionPtr, SQLSMALLINT* ScalePtr, SQLSMALLINT* NullablePtr);
  SQLRETURN SQLGetDescRecW(      SQLHDESC DescriptorHandle, SQLSMALLINT RecNumber, SQLWCHAR* Name, SQLSMALLINT BufferLength, SQLSMALLINT* StringLengthPtr, SQLSMALLINT* TypePtr, SQLSMALLINT* SubTypePtr, SQLLEN* LengthPtr, SQLSMALLINT* PrecisionPtr, SQLSMALLINT* ScalePtr, SQLSMALLINT* NullablePtr);
  SQLRETURN SQLGetDiagFieldA(    WINAPI_SQL_HANDLE_TYPE HandleType, SQLHANDLE Handle, SQLSMALLINT RecNumber, SQLSMALLINT DiagIdentifier, SQLPOINTER DiagInfoPtr, SQLSMALLINT BufferLength, SQLSMALLINT* StringLengthPtr);
  SQLRETURN SQLGetDiagFieldW(    WINAPI_SQL_HANDLE_TYPE HandleType, SQLHANDLE Handle, SQLSMALLINT RecNumber, SQLSMALLINT DiagIdentifier, SQLPOINTER DiagInfoPtr, SQLSMALLINT BufferLength, SQLSMALLINT* StringLengthPtr);
  SQLRETURN SQLGetDiagRecA(      WINAPI_SQL_HANDLE_TYPE HandleType, SQLHANDLE Handle, SQLSMALLINT RecNumber, SQLCHAR* SQLState, SQLINTEGER* NativeErrorPtr, SQLCHAR* MessageText, SQLSMALLINT BufferLength, SQLSMALLINT* TextLengthPtr);
  SQLRETURN SQLGetDiagRecW(      WINAPI_SQL_HANDLE_TYPE HandleType, SQLHANDLE Handle, SQLSMALLINT RecNumber, SQLWCHAR* SQLState, SQLINTEGER* NativeErrorPtr, SQLWCHAR* MessageText, SQLSMALLINT BufferLength, SQLSMALLINT* TextLengthPtr);
  SQLRETURN SQLGetEnvAttr(       SQLHENV EnvironmentHandle, SQLINTEGER Attribute, SQLPOINTER ValuePtr, SQLINTEGER BufferLength, SQLINTEGER* StringLengthPtr);
  SQLRETURN SQLGetFunctions(     SQLHDBC ConnectionHandle, SQLUSMALLINT FunctionId, SQLUSMALLINT* SupportedPtr);
  SQLRETURN SQLGetInfoA(         SQLHDBC ConnectionHandle, SQLUSMALLINT InfoType, SQLPOINTER InfoValuePtr, SQLSMALLINT BufferLength, SQLSMALLINT* StringLengthPtr);
  SQLRETURN SQLGetInfoW(         SQLHDBC ConnectionHandle, SQLUSMALLINT InfoType, SQLPOINTER InfoValuePtr, SQLSMALLINT BufferLength, SQLSMALLINT* StringLengthPtr);
  SQLRETURN SQLGetStmtAttrA(     SQLHSTMT StatementHandle, SQLINTEGER Attribute, SQLPOINTER ValuePtr, SQLINTEGER BufferLength, SQLINTEGER* StringLengthPtr);
  SQLRETURN SQLGetStmtAttrW(     SQLHSTMT StatementHandle, SQLINTEGER Attribute, SQLPOINTER ValuePtr, SQLINTEGER BufferLength, SQLINTEGER* StringLengthPtr);
  SQLRETURN SQLGetStmtOption(    SQLHSTMT StatementHandle, SQLUSMALLINT Option, SQLPOINTER Value);
  SQLRETURN SQLGetTypeInfoA(     SQLHSTMT StatementHandle, SQLSMALLINT DataType);
  SQLRETURN SQLGetTypeInfoW(     SQLHSTMT StatementHandle, SQLSMALLINT DataType);
  SQLRETURN SQLMoreResults(      SQLHSTMT StatementHandle);
  SQLRETURN SQLNativeSqlA(       SQLHDBC ConnectionHandle, SQLCHAR* InStatementText, SQLINTEGER TextLength1, SQLCHAR* OutStatementText, SQLINTEGER BufferLength, SQLINTEGER* TextLength2Ptr);
  SQLRETURN SQLNativeSqlW(       SQLHDBC ConnectionHandle, SQLWCHAR* InStatementText, SQLINTEGER TextLength1, SQLWCHAR* OutStatementText, SQLINTEGER BufferLength, SQLINTEGER* TextLength2Ptr);
  SQLRETURN SQLNumParams(        SQLHSTMT StatementHandle, SQLSMALLINT* ParameterCountPtr);
  SQLRETURN SQLNumResultCols(    SQLHSTMT StatementHandle, SQLSMALLINT* ColumnCountPtr);
  SQLRETURN SQLParamData(        SQLHSTMT StatementHandle, SQLPOINTER* ValuePtrPtr);
  SQLRETURN SQLParamOptions(     SQLHSTMT hstmt, SQLULEN crow, SQLULEN* pirow);
  SQLRETURN SQLPrepareA(         SQLHSTMT StatementHandle, SQLCHAR* StatementText, SQLINTEGER TextLength);
  SQLRETURN SQLPrepareW(         SQLHSTMT StatementHandle, SQLWCHAR* StatementText, SQLINTEGER TextLength);
  SQLRETURN SQLPrimaryKeysA(     SQLHSTMT StatementHandle, SQLCHAR* CatalogName, SQLSMALLINT NameLength1, SQLCHAR* SchemaName, SQLSMALLINT NameLength2, SQLCHAR* TableName, SQLSMALLINT NameLength3);
  SQLRETURN SQLPrimaryKeysW(     SQLHSTMT StatementHandle, SQLWCHAR* CatalogName, SQLSMALLINT NameLength1, SQLWCHAR* SchemaName, SQLSMALLINT NameLength2, SQLWCHAR* TableName, SQLSMALLINT NameLength3);
  SQLRETURN SQLProcedureColumnsA(SQLHSTMT StatementHandle, SQLCHAR* CatalogName, SQLSMALLINT NameLength1, SQLCHAR* SchemaName, SQLSMALLINT NameLength2, SQLCHAR* ProcName, SQLSMALLINT NameLength3, SQLCHAR* ColumnName, SQLSMALLINT NameLength4);
  SQLRETURN SQLProcedureColumnsW(SQLHSTMT StatementHandle, SQLWCHAR* CatalogName, SQLSMALLINT NameLength1, SQLWCHAR* SchemaName, SQLSMALLINT NameLength2, SQLWCHAR* ProcName, SQLSMALLINT NameLength3, SQLWCHAR* ColumnName, SQLSMALLINT NameLength4);
  SQLRETURN SQLProceduresA(      SQLHSTMT StatementHandle, SQLCHAR* CatalogName, SQLSMALLINT NameLength1, SQLCHAR* SchemaName, SQLSMALLINT NameLength2, SQLCHAR* ProcName, SQLSMALLINT NameLength3);
  SQLRETURN SQLProceduresW(      SQLHSTMT StatementHandle, SQLWCHAR* CatalogName, SQLSMALLINT NameLength1, SQLWCHAR* SchemaName, SQLSMALLINT NameLength2, SQLWCHAR* ProcName, SQLSMALLINT NameLength3);
  SQLRETURN SQLPutData(          SQLHSTMT StatementHandle, SQLPOINTER DataPtr, SQLLEN StrLen_or_Ind);
  SQLRETURN SQLRowCount(         SQLHSTMT StatementHandle, SQLLEN* RowCountPtr);
  SQLRETURN SQLSetConnectAttrA(  SQLHDBC ConnectionHandle, SQLINTEGER Attribute, SQLPOINTER ValuePtr, SQLINTEGER StringLength);
  SQLRETURN SQLSetConnectAttrW(  SQLHDBC ConnectionHandle, SQLINTEGER Attribute, SQLPOINTER ValuePtr, SQLINTEGER StringLength);
  SQLRETURN SQLSetConnectOption( SQLHDBC ConnectionHandle, SQLUSMALLINT Option, SQLULEN Value);
  SQLRETURN SQLSetConnectOption( SQLHDBC ConnectionHandle, SQLUSMALLINT Option, SQLULEN Value);
  SQLRETURN SQLSetCursorNameA(   SQLHSTMT StatementHandle, SQLCHAR* CursorName, SQLSMALLINT NameLength);
  SQLRETURN SQLSetCursorNameW(   SQLHSTMT StatementHandle, SQLWCHAR* CursorName, SQLSMALLINT NameLength);
  SQLRETURN SQLSetDescFieldA(    SQLHDESC DescriptorHandle, SQLSMALLINT RecNumber, SQLSMALLINT FieldIdentifier, SQLPOINTER ValuePtr, SQLINTEGER BufferLength);
  SQLRETURN SQLSetDescFieldW(    SQLHDESC DescriptorHandle, SQLSMALLINT RecNumber, SQLSMALLINT FieldIdentifier, SQLPOINTER ValuePtr, SQLINTEGER BufferLength);
  SQLRETURN SQLSetDescRec(       SQLHDESC DescriptorHandle, SQLSMALLINT RecNumber, SQLSMALLINT Type, SQLSMALLINT SubType, SQLLEN Length, SQLSMALLINT Precision, SQLSMALLINT Scale, SQLPOINTER DataPtr, SQLLEN* StringLengthPtr, SQLLEN* IndicatorPtr);
  SQLRETURN SQLSetEnvAttr(       SQLHENV EnvironmentHandle, SQLINTEGER Attribute, SQLPOINTER ValuePtr, SQLINTEGER StringLength);
  SQLRETURN SQLSetParam(         SQLHSTMT StatementHandle, SQLUSMALLINT ParameterNumber, SQLSMALLINT ValueType, SQLSMALLINT ParameterType, SQLULEN LengthPrecision, SQLSMALLINT ParameterScale, SQLPOINTER ParameterValue, SQLLEN* StrLen_or_Ind);
  SQLRETURN SQLSetPos(           SQLHSTMT StatementHandle, SQLSETPOSIROW RowNumber, SQLUSMALLINT Operation, SQLUSMALLINT LockType);
  SQLRETURN SQLSetScrollOptions( SQLHSTMT hstmt, SQLUSMALLINT fConcurrency, SQLLEN crowKeyset, SQLUSMALLINT crowRowset);
  SQLRETURN SQLSetStmtAttrA(     SQLHSTMT StatementHandle, SQLINTEGER Attribute, SQLPOINTER ValuePtr, SQLINTEGER StringLength);
  SQLRETURN SQLSetStmtAttrW(     SQLHSTMT StatementHandle, SQLINTEGER Attribute, SQLPOINTER ValuePtr, SQLINTEGER StringLength);
  SQLRETURN SQLSetStmtOption(    SQLHSTMT StatementHandle, SQLUSMALLINT Option, SQLULEN Value);
  SQLRETURN SQLSpecialColumnsA(  SQLHSTMT StatementHandle, SQLSMALLINT IdentifierType, SQLCHAR* CatalogName, SQLSMALLINT NameLength1, SQLCHAR* SchemaName, SQLSMALLINT NameLength2, SQLCHAR* TableName, SQLSMALLINT NameLength3, SQLSMALLINT Scope, SQLSMALLINT Nullable);
  SQLRETURN SQLSpecialColumnsW(  SQLHSTMT StatementHandle, SQLSMALLINT IdentifierType, SQLWCHAR* CatalogName, SQLSMALLINT NameLength1, SQLWCHAR* SchemaName, SQLSMALLINT NameLength2, SQLWCHAR* TableName, SQLSMALLINT NameLength3, SQLSMALLINT Scope, SQLSMALLINT Nullable);
  SQLRETURN SQLStatisticsA(      SQLHSTMT StatementHandle, SQLCHAR* CatalogName, SQLSMALLINT NameLength1, SQLCHAR* SchemaName, SQLSMALLINT NameLength2, SQLCHAR* TableName, SQLSMALLINT NameLength3, SQLUSMALLINT Unique, SQLUSMALLINT Reserved);
  SQLRETURN SQLStatisticsW(      SQLHSTMT StatementHandle, SQLWCHAR* CatalogName, SQLSMALLINT NameLength1, SQLWCHAR* SchemaName, SQLSMALLINT NameLength2, SQLWCHAR* TableName, SQLSMALLINT NameLength3, SQLUSMALLINT Unique, SQLUSMALLINT Reserved);
  SQLRETURN SQLTablePrivilegesA( SQLHSTMT StatementHandle, SQLCHAR* CatalogName, SQLSMALLINT NameLength1, SQLCHAR* SchemaName, SQLSMALLINT NameLength2, SQLCHAR* TableName, SQLSMALLINT NameLength3);
  SQLRETURN SQLTablePrivilegesW( SQLHSTMT StatementHandle, SQLWCHAR* CatalogName, SQLSMALLINT NameLength1, SQLWCHAR* SchemaName, SQLSMALLINT NameLength2, SQLWCHAR* TableName, SQLSMALLINT NameLength3);
  SQLRETURN SQLTablesA(          SQLHSTMT StatementHandle, SQLCHAR* CatalogName, SQLSMALLINT NameLength1, SQLCHAR* SchemaName, SQLSMALLINT NameLength2, SQLCHAR* TableName, SQLSMALLINT NameLength3, SQLCHAR* TableType, SQLSMALLINT NameLength4);
  SQLRETURN SQLTablesW(          SQLHSTMT StatementHandle, SQLWCHAR* CatalogName, SQLSMALLINT NameLength1, SQLWCHAR* SchemaName, SQLSMALLINT NameLength2, SQLWCHAR* TableName, SQLSMALLINT NameLength3, SQLWCHAR* TableType, SQLSMALLINT NameLength4);
  SQLRETURN SQLTransact(         SQLHENV EnvironmentHandle, SQLHDBC ConnectionHandle, SQLUSMALLINT CompletionType);
]]
return ffi.load( 'ODBC32.DLL' )
