local ffi = require( 'ffi' )
ffi.cdef [[
  typedef unsigned int WINAPI_ExceptionCode; //Alias
  static const WINAPI_ExceptionCode EXCEPTION_ACCESS_VIOLATION = 0xC0000005;
  static const WINAPI_ExceptionCode EXCEPTION_ARRAY_BOUNDS_EXCEEDED = 0xC000008C;
  static const WINAPI_ExceptionCode EXCEPTION_BREAKPOINT = 0x80000003;
  static const WINAPI_ExceptionCode EXCEPTION_DATATYPE_MISALIGNMENT = 0xC00002C5;
  static const WINAPI_ExceptionCode EXCEPTION_FLT_DENORMAL_OPERAND = 0xC000008D;
  static const WINAPI_ExceptionCode EXCEPTION_FLT_DIVIDE_BY_ZERO = 0xC000008E;
  static const WINAPI_ExceptionCode EXCEPTION_FLT_INEXACT_RESULT = 0xC000008F;
  static const WINAPI_ExceptionCode EXCEPTION_FLT_INVALID_OPERATION = 0xC0000090;
  static const WINAPI_ExceptionCode EXCEPTION_FLT_OVERFLOW = 0xC0000091;
  static const WINAPI_ExceptionCode EXCEPTION_FLT_STACK_CHECK = 0xC0000092;
  static const WINAPI_ExceptionCode EXCEPTION_FLT_UNDERFLOW = 0xC0000093;
  static const WINAPI_ExceptionCode EXCEPTION_GUARD_PAGE = 0x80000001;
  static const WINAPI_ExceptionCode EXCEPTION_ILLEGAL_INSTRUCTION = 0xC000001D;
  static const WINAPI_ExceptionCode EXCEPTION_IN_PAGE_ERROR = 0xC0000006;
  static const WINAPI_ExceptionCode EXCEPTION_INT_DIVIDE_BY_ZERO = 0xC0000094;
  static const WINAPI_ExceptionCode EXCEPTION_INT_OVERFLOW = 0xC0000095;
  static const WINAPI_ExceptionCode EXCEPTION_INVALID_DISPOSITION = 0xC0000026;
  static const WINAPI_ExceptionCode EXCEPTION_INVALID_HANDLE = 0xC0000008;
  static const WINAPI_ExceptionCode EXCEPTION_NONCONTINUABLE_EXCEPTION = 0xC0000025;
  static const WINAPI_ExceptionCode EXCEPTION_PRIV_INSTRUCTION = 0xC0000096;
  static const WINAPI_ExceptionCode EXCEPTION_SINGLE_STEP = 0x80000004;
  static const WINAPI_ExceptionCode EXCEPTION_STACK_OVERFLOW = 0xC00000FD;
//static const WINAPI_ExceptionCode STATUS_UNWIND_CONSOLIDATE = 0x80000029;
]]
