require( 'waffi.headers.ole' )
require( 'waffi.headers.windows' )
local ffi = require( 'ffi' )
ffi.cdef [[
  typedef HANDLE HICON; //Alias
  typedef HANDLE HMENU; //Alias
  typedef HANDLE HDC; //Alias
  typedef HANDLE HPALETTE; //Alias
  typedef HICON HCURSOR; //Alias
  typedef HANDLE HMONITOR; //Alias
  typedef LPVOID HIMAGELIST; //Alias
  typedef HANDLE HRGN; //Alias
  typedef HANDLE HMETAFILE; //Alias
  typedef HANDLE HBRUSH; //Alias
  typedef HANDLE HFONT; //Alias
  typedef LPVOID LPCCHOOKPROC; //Alias
  typedef LPVOID LPCFHOOKPROC; //Alias
  typedef LPVOID LPPAGESETUPHOOK; //Alias
  typedef LPVOID LPPAGEPAINTHOOK; //Alias
  typedef LPVOID LPFRHOOKPROC; //Alias
  typedef LPVOID LPPRINTHOOKPROC; //Alias
  typedef LPVOID LPSETUPHOOKPROC; //Alias
  typedef LONGLONG REFERENCE_TIME; //Alias
  enum { LF_FACESIZE = 32 };
  typedef struct RGBQUAD {
    BYTE rgbBlue;
    BYTE rgbGreen;
    BYTE rgbRed;
    BYTE rgbReserved;
  } RGBQUAD;
  typedef DWORD WINAPI_RegionType; //Alias
  static const WINAPI_RegionType RDH_RECTANGLES = 1;
  typedef struct RGNDATAHEADER {
    DWORD dwSize;
    WINAPI_RegionType iType;
    DWORD nCount;
    DWORD nRgnSize;
    RECT rcBound;
  } RGNDATAHEADER;
  typedef struct RGNDATA {
    RGNDATAHEADER rdh;
    char Buffer;
  } RGNDATA;
  typedef RGNDATA *LPRGNDATA; //Pointer
  typedef DWORD COLORREF; //Alias
  static const COLORREF CLR_INVALID = 0xFFFFFFFF;
  typedef struct SIZE {
    LONG cx;
    LONG cy;
  } SIZE;
  typedef SIZE* LPSIZE; //Alias
  typedef SIZE* PSIZE; //Alias
  typedef SIZE SIZEL; //Alias
  typedef SIZEL *LPSIZEL; //Pointer
  typedef DWORD WINAPI_ChooseColorFlags; //Alias
  typedef struct CHOOSECOLORA {
    DWORD lStructSize;
    HWND hwndOwner;
    HWND hInstance;
    COLORREF rgbResult;
    COLORREF* lpCustColors;
    WINAPI_ChooseColorFlags Flags;
    LPARAM lCustData;
    LPCCHOOKPROC lpfnHook;
    LPCSTR lpTemplateName;
  } CHOOSECOLORA;
  typedef CHOOSECOLORA *LPCHOOSECOLORA; //Pointer
  typedef struct CHOOSECOLORW {
    DWORD lStructSize;
    HWND hwndOwner;
    HWND hInstance;
    COLORREF rgbResult;
    COLORREF* lpCustColors;
    WINAPI_ChooseColorFlags Flags;
    LPARAM lCustData;
    LPCCHOOKPROC lpfnHook;
    LPCWSTR lpTemplateName;
  } CHOOSECOLORW;
  typedef CHOOSECOLORW *LPCHOOSECOLORW; //Pointer
  typedef DWORD WINAPI_ChoooseFontFlags; //Alias
  typedef WORD WINAPI_FontType; //Alias
  typedef LONG WINAPI_FontWeight; //Alias
  static const WINAPI_FontWeight FW_DONTCARE = 0;
  static const WINAPI_FontWeight FW_THIN = 100;
  static const WINAPI_FontWeight FW_EXTRALIGHT = 200;
  static const WINAPI_FontWeight FW_LIGHT = 300;
  static const WINAPI_FontWeight FW_NORMAL = 400;
  static const WINAPI_FontWeight FW_MEDIUM = 500;
  static const WINAPI_FontWeight FW_SEMIBOLD = 600;
  static const WINAPI_FontWeight FW_BOLD = 700;
  static const WINAPI_FontWeight FW_EXTRABOLD = 800;
  static const WINAPI_FontWeight FW_HEAVY = 900;
  typedef BYTE WINAPI_FontCharset; //Alias
  static const WINAPI_FontCharset ANSI_CHARSET = 0;
  static const WINAPI_FontCharset DEFAULT_CHARSET = 1;
  static const WINAPI_FontCharset SYMBOL_CHARSET = 2;
  static const WINAPI_FontCharset SHIFTJIS_CHARSET = 128;
  static const WINAPI_FontCharset HANGEUL_CHARSET = 129;
  static const WINAPI_FontCharset HANGUL_CHARSET = 129;
  static const WINAPI_FontCharset GB2312_CHARSET = 134;
  static const WINAPI_FontCharset CHINESEBIG5_CHARSET = 136;
  static const WINAPI_FontCharset OEM_CHARSET = 255;
  static const WINAPI_FontCharset JOHAB_CHARSET = 130;
  static const WINAPI_FontCharset HEBREW_CHARSET = 177;
  static const WINAPI_FontCharset ARABIC_CHARSET = 178;
  static const WINAPI_FontCharset GREEK_CHARSET = 161;
  static const WINAPI_FontCharset TURKISH_CHARSET = 162;
  static const WINAPI_FontCharset VIETNAMESE_CHARSET = 163;
  static const WINAPI_FontCharset THAI_CHARSET = 222;
  static const WINAPI_FontCharset EASTEUROPE_CHARSET = 238;
  static const WINAPI_FontCharset RUSSIAN_CHARSET = 204;
  static const WINAPI_FontCharset MAC_CHARSET = 77;
  static const WINAPI_FontCharset BALTIC_CHARSET = 186;
  typedef BYTE WINAPI_FontOutputPrecision; //Alias
  static const WINAPI_FontOutputPrecision OUT_DEFAULT_PRECIS = 0;
  static const WINAPI_FontOutputPrecision OUT_STRING_PRECIS = 1;
  static const WINAPI_FontOutputPrecision OUT_CHARACTER_PRECIS = 2;
  static const WINAPI_FontOutputPrecision OUT_STROKE_PRECIS = 3;
  static const WINAPI_FontOutputPrecision OUT_TT_PRECIS = 4;
  static const WINAPI_FontOutputPrecision OUT_DEVICE_PRECIS = 5;
  static const WINAPI_FontOutputPrecision OUT_RASTER_PRECIS = 6;
  static const WINAPI_FontOutputPrecision OUT_TT_ONLY_PRECIS = 7;
  static const WINAPI_FontOutputPrecision OUT_OUTLINE_PRECIS = 8;
  static const WINAPI_FontOutputPrecision OUT_SCREEN_OUTLINE_PRECIS = 9;
  static const WINAPI_FontOutputPrecision OUT_PS_ONLY_PRECIS = 10;
  typedef BYTE WINAPI_FontClipPrecision; //Alias
  static const WINAPI_FontClipPrecision CLIP_DEFAULT_PRECIS = 0;
  static const WINAPI_FontClipPrecision CLIP_CHARACTER_PRECIS = 1;
  static const WINAPI_FontClipPrecision CLIP_STROKE_PRECIS = 2;
  static const WINAPI_FontClipPrecision CLIP_MASK = 0xf;
  static const WINAPI_FontClipPrecision CLIP_LH_ANGLES = 0x10;
  static const WINAPI_FontClipPrecision CLIP_TT_ALWAYS = 0x20;
  static const WINAPI_FontClipPrecision CLIP_DFA_DISABLE = 0x40;
  static const WINAPI_FontClipPrecision CLIP_EMBEDDED = 0x80;
  typedef BYTE WINAPI_FontQuality; //Alias
  static const WINAPI_FontQuality DEFAULT_QUALITY = 0;
  static const WINAPI_FontQuality DRAFT_QUALITY = 1;
  static const WINAPI_FontQuality PROOF_QUALITY = 2;
  static const WINAPI_FontQuality NONANTIALIASED_QUALITY = 3;
  static const WINAPI_FontQuality ANTIALIASED_QUALITY = 4;
  static const WINAPI_FontQuality CLEARTYPE_QUALITY = 5;
  static const WINAPI_FontQuality CLEARTYPE_NATURAL_QUALITY = 6;
  typedef BYTE WINAPI_FontPitchAndFamily; //Alias
  typedef struct LOGFONTA {
    LONG lfHeight;
    LONG lfWidth;
    LONG lfEscapement;
    LONG lfOrientation;
    WINAPI_FontWeight lfWeight;
    BYTE lfItalic;
    BYTE lfUnderline;
    BYTE lfStrikeOut;
    WINAPI_FontCharset lfCharSet;
    WINAPI_FontOutputPrecision lfOutPrecision;
    WINAPI_FontClipPrecision lfClipPrecision;
    WINAPI_FontQuality lfQuality;
    WINAPI_FontPitchAndFamily lfPitchAndFamily;
    CHAR lfFaceName[LF_FACESIZE];
  } LOGFONTA;
  typedef LOGFONTA *LPLOGFONTA; //Pointer
  typedef struct LOGFONTW {
    LONG lfHeight;
    LONG lfWidth;
    LONG lfEscapement;
    LONG lfOrientation;
    WINAPI_FontWeight lfWeight;
    BYTE lfItalic;
    BYTE lfUnderline;
    BYTE lfStrikeOut;
    WINAPI_FontCharset lfCharSet;
    WINAPI_FontOutputPrecision lfOutPrecision;
    WINAPI_FontClipPrecision lfClipPrecision;
    WINAPI_FontQuality lfQuality;
    WINAPI_FontPitchAndFamily lfPitchAndFamily;
    WCHAR lfFaceName[LF_FACESIZE];
  } LOGFONTW;
  typedef LOGFONTW *LPLOGFONTW; //Pointer
  typedef struct CHOOSEFONTA {
    DWORD lStructSize;
    HWND hwndOwner;
    HDC hDC;
    LPLOGFONTA lpLogFont;
    INT iPointSize;
    WINAPI_ChoooseFontFlags Flags;
    COLORREF rgbColors;
    LPARAM lCustData;
    LPCFHOOKPROC lpfnHook;
    LPCSTR lpTemplateName;
    HINSTANCE hInstance;
    LPSTR lpszStyle;
    WINAPI_FontType nFontType;
    WORD ___MISSING_ALIGNMENT__;
    INT nSizeMin;
    INT nSizeMax;
  } CHOOSEFONTA;
  typedef CHOOSEFONTA *LPCHOOSEFONTA; //Pointer
  typedef struct CHOOSEFONTW {
    DWORD lStructSize;
    HWND hwndOwner;
    HDC hDC;
    LPLOGFONTW lpLogFont;
    INT iPointSize;
    WINAPI_ChoooseFontFlags Flags;
    COLORREF rgbColors;
    LPARAM lCustData;
    LPCFHOOKPROC lpfnHook;
    LPCWSTR lpTemplateName;
    HINSTANCE hInstance;
    LPWSTR lpszStyle;
    WINAPI_FontType nFontType;
    WORD ___MISSING_ALIGNMENT__;
    INT nSizeMin;
    INT nSizeMax;
  } CHOOSEFONTW;
  typedef CHOOSEFONTW *LPCHOOSEFONTW; //Pointer
  typedef DWORD WINAPI_FindReplaceFlags; //Alias
  typedef struct FINDREPLACEA {
    DWORD lStructSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    WINAPI_FindReplaceFlags Flags;
    LPSTR lpstrFindWhat;
    LPSTR lpstrReplaceWith;
    WORD wFindWhatLen;
    WORD wReplaceWithLen;
    LPARAM lCustData;
    LPFRHOOKPROC lpfnHook;
    LPCSTR lpTemplateName;
  } FINDREPLACEA;
  typedef FINDREPLACEA *LPFINDREPLACEA; //Pointer
  typedef struct FINDREPLACEW {
    DWORD lStructSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    WINAPI_FindReplaceFlags Flags;
    LPWSTR lpstrFindWhat;
    LPWSTR lpstrReplaceWith;
    WORD wFindWhatLen;
    WORD wReplaceWithLen;
    LPARAM lCustData;
    LPFRHOOKPROC lpfnHook;
    LPCWSTR lpTemplateName;
  } FINDREPLACEW;
  typedef FINDREPLACEW *LPFINDREPLACEW; //Pointer
  typedef DWORD WINAPI_OfnFlags; //Alias
  typedef DWORD WINAPI_OfnFlagsEx; //Alias
  typedef struct OPENFILENAMEA {
    DWORD lStructSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    LPCSTR lpstrFilter;
    LPSTR lpstrCustomFilter;
    DWORD nMaxCustFilter;
    DWORD nFilterIndex;
    LPSTR lpstrFile;
    DWORD nMaxFile;
    LPSTR lpstrFileTitle;
    DWORD nMaxFileTitle;
    LPCSTR lpstrInitialDir;
    LPCSTR lpstrTitle;
    WINAPI_OfnFlags Flags;
    WORD nFileOffset;
    WORD nFileExtension;
    LPCSTR lpstrDefExt;
    LPARAM lCustData;
    LPVOID lpfnHook;
    LPCSTR lpTemplateName;
    void* pvReserved;
    DWORD dwReserved;
    WINAPI_OfnFlagsEx FlagsEx;
  } OPENFILENAMEA;
  typedef OPENFILENAMEA *LPOPENFILENAMEA; //Pointer
  typedef struct OPENFILENAMEW {
    DWORD lStructSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    LPCWSTR lpstrFilter;
    LPWSTR lpstrCustomFilter;
    DWORD nMaxCustFilter;
    DWORD nFilterIndex;
    LPWSTR lpstrFile;
    DWORD nMaxFile;
    LPWSTR lpstrFileTitle;
    DWORD nMaxFileTitle;
    LPCWSTR lpstrInitialDir;
    LPCWSTR lpstrTitle;
    WINAPI_OfnFlags Flags;
    WORD nFileOffset;
    WORD nFileExtension;
    LPCWSTR lpstrDefExt;
    LPARAM lCustData;
    LPVOID lpfnHook;
    LPCWSTR lpTemplateName;
    void* pvReserved;
    DWORD dwReserved;
    WINAPI_OfnFlagsEx FlagsEx;
  } OPENFILENAMEW;
  typedef OPENFILENAMEW *LPOPENFILENAMEW; //Pointer
  typedef DWORD WINAPI_PageSetupDialogFlags; //Alias
  typedef struct PAGESETUPDLGA {
    DWORD lStructSize;
    HWND hwndOwner;
    HGLOBAL hDevMode;
    HGLOBAL hDevNames;
    WINAPI_PageSetupDialogFlags Flags;
    POINT ptPaperSize;
    RECT rtMinMargin;
    RECT rtMargin;
    HINSTANCE hInstance;
    LPARAM lCustData;
    LPPAGESETUPHOOK lpfnPageSetupHook;
    LPPAGEPAINTHOOK lpfnPagePaintHook;
    LPCSTR lpPageSetupTemplateName;
    HGLOBAL hPageSetupTemplate;
  } PAGESETUPDLGA;
  typedef PAGESETUPDLGA *LPPAGESETUPDLGA; //Pointer
  typedef struct PAGESETUPDLGW {
    DWORD lStructSize;
    HWND hwndOwner;
    HGLOBAL hDevMode;
    HGLOBAL hDevNames;
    WINAPI_PageSetupDialogFlags Flags;
    POINT ptPaperSize;
    RECT rtMinMargin;
    RECT rtMargin;
    HINSTANCE hInstance;
    LPARAM lCustData;
    LPPAGESETUPHOOK lpfnPageSetupHook;
    LPPAGEPAINTHOOK lpfnPagePaintHook;
    LPCWSTR lpPageSetupTemplateName;
    HGLOBAL hPageSetupTemplate;
  } PAGESETUPDLGW;
  typedef PAGESETUPDLGW *LPPAGESETUPDLGW; //Pointer
  typedef DWORD WINAPI_PrintDlgFlags; //Alias
  typedef struct PRINTDLGA {
    DWORD lStructSize;
    HWND hwndOwner;
    HGLOBAL hDevMode;
    HGLOBAL hDevNames;
    HDC hDC;
    WINAPI_PrintDlgFlags Flags;
    WORD nFromPage;
    WORD nToPage;
    WORD nMinPage;
    WORD nMaxPage;
    WORD nCopies;
    HINSTANCE hInstance;
    LPARAM lCustData;
    LPPRINTHOOKPROC lpfnPrintHook;
    LPSETUPHOOKPROC lpfnSetupHook;
    LPCSTR lpPrintTemplateName;
    LPCSTR lpSetupTemplateName;
    HGLOBAL hPrintTemplate;
    HGLOBAL hSetupTemplate;
  } PRINTDLGA;
  typedef PRINTDLGA *LPPRINTDLGA; //Pointer
  typedef struct PRINTDLGW {
    DWORD lStructSize;
    HWND hwndOwner;
    HGLOBAL hDevMode;
    HGLOBAL hDevNames;
    HDC hDC;
    WINAPI_PrintDlgFlags Flags;
    WORD nFromPage;
    WORD nToPage;
    WORD nMinPage;
    WORD nMaxPage;
    WORD nCopies;
    HINSTANCE hInstance;
    LPARAM lCustData;
    LPPRINTHOOKPROC lpfnPrintHook;
    LPSETUPHOOKPROC lpfnSetupHook;
    LPCWSTR lpPrintTemplateName;
    LPCWSTR lpSetupTemplateName;
    HGLOBAL hPrintTemplate;
    HGLOBAL hSetupTemplate;
  } PRINTDLGW;
  typedef PRINTDLGW *LPPRINTDLGW; //Pointer
  typedef struct PRINTPAGERANGE {
    DWORD nFromPage;
    DWORD nToPage;
  } PRINTPAGERANGE;
  typedef PRINTPAGERANGE *LPPRINTPAGERANGE; //Pointer
  typedef struct PRINTDLGEXA {
    DWORD lStructSize;
    HWND hwndOwner;
    HGLOBAL hDevMode;
    HGLOBAL hDevNames;
    HDC hDC;
    WINAPI_PrintDlgFlags Flags;
    DWORD Flags2;
    DWORD ExclusionFlags;
    DWORD nPageRanges;
    DWORD nMaxPageRanges;
    LPPRINTPAGERANGE lpPageRanges;
    DWORD nMinPage;
    DWORD nMaxPage;
    DWORD nCopies;
    HINSTANCE hInstance;
    LPCSTR lpPrintTemplateName;
    LPUNKNOWN lpCallback;
    DWORD nPropertyPages;
    HPROPSHEETPAGE* lphPropertyPages;
    DWORD nStartPage;
    DWORD dwResultAction;
  } PRINTDLGEXA;
  typedef PRINTDLGEXA *LPPRINTDLGEXA; //Pointer
  typedef struct PRINTDLGEXW {
    DWORD lStructSize;
    HWND hwndOwner;
    HGLOBAL hDevMode;
    HGLOBAL hDevNames;
    HDC hDC;
    WINAPI_PrintDlgFlags Flags;
    DWORD Flags2;
    DWORD ExclusionFlags;
    DWORD nPageRanges;
    DWORD nMaxPageRanges;
    LPPRINTPAGERANGE lpPageRanges;
    DWORD nMinPage;
    DWORD nMaxPage;
    DWORD nCopies;
    HINSTANCE hInstance;
    LPCWSTR lpPrintTemplateName;
    LPUNKNOWN lpCallback;
    DWORD nPropertyPages;
    HPROPSHEETPAGE* lphPropertyPages;
    DWORD nStartPage;
    DWORD dwResultAction;
  } PRINTDLGEXW;
  typedef PRINTDLGEXW *LPPRINTDLGEXW; //Pointer
  typedef struct DRAWTEXTPARAMS {
    UINT cbSize;
    int iTabLength;
    int iLeftMargin;
    int iRightMargin;
    UINT uiLengthDrawn;
  } DRAWTEXTPARAMS;
  typedef DRAWTEXTPARAMS *LPDRAWTEXTPARAMS; //Pointer
  typedef DWORD WINAPI_TRACKMOUSEEVENT_Flags; //Alias
  typedef struct TRACKMOUSEEVENT {
    DWORD cbSize;
    WINAPI_TRACKMOUSEEVENT_Flags dwFlags;
    HWND hwndTrack;
    DWORD dwHoverTime;
  } TRACKMOUSEEVENT;
  typedef TRACKMOUSEEVENT *LPTRACKMOUSEEVENT; //Pointer
  typedef UINT WINAPI_SCROLLINFO_Flags; //Alias
  typedef struct SCROLLINFO {
    UINT cbSize;
    WINAPI_SCROLLINFO_Flags fMask;
    int nMin;
    int nMax;
    UINT nPage;
    int nPos;
    int nTrackPos;
  } SCROLLINFO;
  typedef SCROLLINFO *LPSCROLLINFO; //Pointer
  typedef SCROLLINFO *LPCSCROLLINFO; //Pointer
  typedef struct MARGINS {
    int cxLeftWidth;
    int cxRightWidth;
    int cyTopHeight;
    int cyBottomHeight;
  } MARGINS;
  typedef struct BLENDFUNCTION {
    BYTE BlendOp;
    BYTE BlendFlags;
    BYTE SourceConstantAlpha;
    BYTE AlphaFormat;
  } BLENDFUNCTION;
  typedef struct BITMAPINFOHEADER {
    DWORD biSize;
    LONG biWidth;
    LONG biHeight;
    WORD biPlanes;
    WORD biBitCount;
    DWORD biCompression;
    DWORD biSizeImage;
    LONG biXPelsPerMeter;
    LONG biYPelsPerMeter;
    DWORD biClrUsed;
    DWORD biClrImportant;
  } BITMAPINFOHEADER;
  typedef BITMAPINFOHEADER *LPBITMAPINFOHEADER; //Pointer
  typedef struct BITMAPINFO {
    BITMAPINFOHEADER bmiHeader;
    RGBQUAD bmiColors[1];
  } BITMAPINFO;
  typedef BITMAPINFO *LPBITMAPINFO; //Pointer
  typedef BYTE WINAPI_TEXTMETRIC_Pitch; //Alias
# pragma pack( push, 4 )
  typedef struct TEXTMETRICA {
    LONG tmHeight;
    LONG tmAscent;
    LONG tmDescent;
    LONG tmInternalLeading;
    LONG tmExternalLeading;
    LONG tmAveCharWidth;
    LONG tmMaxCharWidth;
    LONG tmWeight;
    LONG tmOverhang;
    LONG tmDigitizedAspectX;
    LONG tmDigitizedAspectY;
    CHAR tmFirstChar;
    CHAR tmLastChar;
    CHAR tmDefaultChar;
    CHAR tmBreakChar;
    BYTE tmItalic;
    BYTE tmUnderlined;
    BYTE tmStruckOut;
    WINAPI_TEXTMETRIC_Pitch tmPitchAndFamily;
    WINAPI_FontCharset tmCharSet;
  } TEXTMETRICA;
  typedef struct TEXTMETRICW {
    LONG tmHeight;
    LONG tmAscent;
    LONG tmDescent;
    LONG tmInternalLeading;
    LONG tmExternalLeading;
    LONG tmAveCharWidth;
    LONG tmMaxCharWidth;
    LONG tmWeight;
    LONG tmOverhang;
    LONG tmDigitizedAspectX;
    LONG tmDigitizedAspectY;
    WCHAR tmFirstChar;
    WCHAR tmLastChar;
    WCHAR tmDefaultChar;
    WCHAR tmBreakChar;
    BYTE tmItalic;
    BYTE tmUnderlined;
    BYTE tmStruckOut;
    WINAPI_TEXTMETRIC_Pitch tmPitchAndFamily;
    WINAPI_FontCharset tmCharSet;
  } TEXTMETRICW;
# pragma pack( pop )
  typedef TEXTMETRICA *LPTEXTMETRICA; //Pointer
  typedef TEXTMETRICW *LPTEXTMETRICW; //Pointer
  typedef DWORD WINAPI_MONITORINFO_Flags; //Alias
  typedef struct VIDEOINFOHEADER {
    RECT rcSource;
    RECT rcTarget;
    DWORD dwBitRate;
    DWORD dwBitErrorRate;
    REFERENCE_TIME AvgTimePerFrame;
    BITMAPINFOHEADER bmiHeader;
  } VIDEOINFOHEADER;
  typedef DWORD WINAPI_AMINTERLACE_FLAGS; //Alias
  typedef DWORD WINAPI_AMCOPYPROTECT_FLAGS; //Alias
  typedef DWORD WINAPI_AMCONTROL_FLAGS; //Alias
  typedef struct VIDEOINFOHEADER2 {
    RECT rcSource;
    RECT rcTarget;
    DWORD dwBitRate;
    DWORD dwBitErrorRate;
    REFERENCE_TIME AvgTimePerFrame;
    WINAPI_AMINTERLACE_FLAGS dwInterlaceFlags;
    WINAPI_AMCOPYPROTECT_FLAGS dwCopyProtectFlags;
    DWORD dwPictAspectRatioX;
    DWORD dwPictAspectRatioY;
    WINAPI_AMCONTROL_FLAGS dwControlFlags;
    DWORD dwReserved2;
    BITMAPINFOHEADER bmiHeader;
  } VIDEOINFOHEADER2;
  typedef UINT PixelFormat; //Alias
  static const PixelFormat PixelFormat4bppIndexed = 0x30402;
  static const PixelFormat PixelFormat8bppIndexed = 0x30803;
  static const PixelFormat PixelFormat16bppGrayScale = 0x101004;
  static const PixelFormat PixelFormat16bppRGB555 = 0x21005;
  static const PixelFormat PixelFormat16bppRGB565 = 0x21006;
  static const PixelFormat PixelFormat16bppARGB1555 = 0x61007;
  static const PixelFormat PixelFormat24bppRGB = 0x21808;
  static const PixelFormat PixelFormat32bppRGB = 0x22009;
  static const PixelFormat PixelFormat32bppARGB = 0x26200a;
  static const PixelFormat PixelFormat32bppPARGB = 0xe200b;
  static const PixelFormat PixelFormat48bppRGB = 0x10300c;
  static const PixelFormat PixelFormat64bppARGB = 0x34400d;
  static const PixelFormat PixelFormat64bppPARGB = 0x1c400e;
  static const PixelFormat PixelFormat32bppCMYK = 0x200f;
  typedef UINT InterpolationMode; //Alias
  static const InterpolationMode InterpolationModeInvalid = -1;
  static const InterpolationMode InterpolationModeDefault = 0;
  static const InterpolationMode InterpolationModeLowQuality = 1;
  static const InterpolationMode InterpolationModeHighQuality = 2;
  static const InterpolationMode InterpolationModeBilinear = 3;
  static const InterpolationMode InterpolationModeBicubic = 4;
  static const InterpolationMode InterpolationModeNearestNeighbor = 5;
  static const InterpolationMode InterpolationModeHighQualityBilinear = 6;
  static const InterpolationMode InterpolationModeHighQualityBicubic = 7;
  typedef ULONG EncoderParameterValueType; //Alias
  static const EncoderParameterValueType EncoderParameterValueTypeByte = 1;
  static const EncoderParameterValueType EncoderParameterValueTypeASCII = 2;
  static const EncoderParameterValueType EncoderParameterValueTypeShort = 3;
  static const EncoderParameterValueType EncoderParameterValueTypeLong = 4;
  static const EncoderParameterValueType EncoderParameterValueTypeRational = 5;
  static const EncoderParameterValueType EncoderParameterValueTypeLongRange = 6;
  static const EncoderParameterValueType EncoderParameterValueTypeUndefined = 7;
  static const EncoderParameterValueType EncoderParameterValueTypeRationalRange = 8;
  static const EncoderParameterValueType EncoderParameterValueTypePointer = 9;
  typedef struct EncoderParameter {
    GUID Guid;
    ULONG NumberOfValues;
    EncoderParameterValueType Type;
    VOID* Value;
  } EncoderParameter;
  typedef struct EncoderParameters {
    UINT Count;
    EncoderParameter Parameter[1];
  } EncoderParameters;
  typedef struct ABC {
    int abcA;
    UINT abcB;
    int abcC;
  } ABC;
  typedef ABC *LPABC; //Pointer
]]
