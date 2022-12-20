require( 'waffi.headers.windows' )
require( 'waffi.headers.shell' )
require( 'waffi.headers.gdi' )
require( 'waffi.headers.security' )
require( 'waffi.windows.kernel32' )
local ffi = require( 'ffi' )
ffi.cdef [[
  typedef LPVOID PMENUBARINFO; //Alias
  typedef LPVOID PMENUTEMPLATE; //Alias
  typedef LPVOID DLGPROC; //Alias
  typedef LPVOID WNDPROC; //Alias
  typedef LPVOID MSGBOXCALLBACK; //Alias
  typedef HANDLE HDESK; //Alias
  typedef LPVOID SENDASYNCPROC; //Alias
  typedef LPVOID WNDENUMPROC; //Alias
  typedef PVOID HDEVNOTIFY; //Alias
  typedef HANDLE HCONV; //Alias
  typedef HANDLE HDDEDATA; //Alias
  typedef HANDLE HSZ; //Alias
  typedef HANDLE HCONVLIST; //Alias
  typedef LPVOID PFNCALLBACK; //Alias
  typedef HANDLE HHOOK; //Alias
  typedef LPVOID HOOKPROC; //Alias
  typedef LPVOID MONITORENUMPROC; //Alias
  typedef LPVOID DRAWSTATEPROC; //Alias
  typedef LPVOID GRAYSTRINGPROC; //Alias
  typedef PVOID HPOWERNOTIFY; //Alias
  typedef HANDLE HRAWINPUT; //Alias
  typedef LPVOID TIMERPROC; //Alias
  typedef LPVOID PROPENUMPROC; //Alias
  typedef LPVOID PROPENUMPROCEX; //Alias
  typedef LPVOID WINSTAENUMPROC; //Alias
  typedef LPVOID DESKTOPENUMPROC; //Alias
  typedef LPVOID WINEVENTPROC; //Alias
  typedef HANDLE HWINSTA; //Alias
  typedef HANDLE HWINEVENTHOOK; //Alias
  typedef HANDLE HTOUCHINPUT; //Alias
  typedef HANDLE HGESTUREINFO; //Alias
  enum { CCHILDREN_TITLEBAR_plus_1 = 6 };
  enum { CCHILDREN_SCROLLBAR_plus_1 = 6 };
  typedef struct TITLEBARINFO {
    DWORD cbSize;
    RECT rcTitleBar;
    DWORD rgstate[CCHILDREN_TITLEBAR_plus_1];
  } TITLEBARINFO;
  typedef TITLEBARINFO *PTITLEBARINFO; //Pointer
  typedef DWORD WINAPI_DISPLAY_DEVICE_STATE; //Alias
  typedef struct DISPLAY_DEVICEA {
    DWORD cb;
    CHAR DeviceName[32];
    CHAR DeviceString[128];
    WINAPI_DISPLAY_DEVICE_STATE StateFlags;
    CHAR DeviceID[128];
    CHAR DeviceKey[128];
  } DISPLAY_DEVICEA;
  typedef DISPLAY_DEVICEA *PDISPLAY_DEVICEA; //Pointer
  typedef struct DISPLAY_DEVICEW {
    DWORD cb;
    WCHAR DeviceName[32];
    WCHAR DeviceString[128];
    WINAPI_DISPLAY_DEVICE_STATE StateFlags;
    WCHAR DeviceID[128];
    WCHAR DeviceKey[128];
  } DISPLAY_DEVICEW;
  typedef DISPLAY_DEVICEW *PDISPLAY_DEVICEW; //Pointer
  typedef struct ICONINFOEXA {
    DWORD cbSize;
    BOOL fIcon;
    DWORD xHotspot;
    DWORD yHotspot;
    HBITMAP hbmMask;
    HBITMAP hbmColor;
    WORD wResID;
    CHAR szModName[MAX_PATH];
    CHAR szResName[MAX_PATH];
  } ICONINFOEXA;
  typedef ICONINFOEXA *PICONINFOEXA; //Pointer
  typedef struct ICONINFOEXW {
    DWORD cbSize;
    BOOL fIcon;
    DWORD xHotspot;
    DWORD yHotspot;
    HBITMAP hbmMask;
    HBITMAP hbmColor;
    WORD wResID;
    WCHAR szModName[MAX_PATH];
    WCHAR szResName[MAX_PATH];
  } ICONINFOEXW;
  typedef ICONINFOEXW *PICONINFOEXW; //Pointer
  typedef struct PAINTSTRUCT {
    HDC hdc;
    BOOL fErase;
    RECT rcPaint;
    BOOL fRestore;
    BOOL fIncUpdate;
    BYTE rgbReserved[32];
  } PAINTSTRUCT;
  typedef PAINTSTRUCT *LPPAINTSTRUCT; //Pointer
  typedef struct SCROLLBARINFO {
    DWORD cbSize;
    RECT rcScrollBar;
    int dxyLineButton;
    int xyThumbTop;
    int xyThumbBottom;
    int reserved;
    DWORD rgstate[CCHILDREN_SCROLLBAR_plus_1];
  } SCROLLBARINFO;
  typedef SCROLLBARINFO *PSCROLLBARINFO; //Pointer
  typedef DWORD WINAPI_MOUSEINPUT_Data; //Alias
  typedef DWORD WINAPI_MOUSEEVENTF; //Alias
  typedef struct MOUSEINPUT {
    LONG dx;
    LONG dy;
    WINAPI_MOUSEINPUT_Data mouseData;
    WINAPI_MOUSEEVENTF dwFlags;
    DWORD time;
    ULONG_PTR dwExtraInfo;
  } MOUSEINPUT;
  typedef DWORD WINAPI_KEYEVENTF; //Alias
  typedef struct KEYBDINPUT {
    WINAPI_VirtKeyCode wVk;
    WORD wScan;
    WINAPI_KEYEVENTF dwFlags;
    DWORD time;
    ULONG_PTR dwExtraInfo;
  } KEYBDINPUT;
  typedef struct HARDWAREINPUT {
    DWORD uMsg;
    WORD wParamL;
    WORD wParamH;
  } HARDWAREINPUT;
  typedef union WINAPI_INPUT_u {
    MOUSEINPUT mi;
    KEYBDINPUT ki;
    HARDWAREINPUT hi;
  } WINAPI_INPUT_u;
  typedef DWORD WINAPI_INPUT_Type; //Alias
  static const WINAPI_INPUT_Type INPUT_MOUSE = 0;
  static const WINAPI_INPUT_Type INPUT_KEYBOARD = 1;
  static const WINAPI_INPUT_Type INPUT_HARDWARE = 2;
  typedef struct INPUT {
    WINAPI_INPUT_Type type;
    WINAPI_INPUT_u ;
  } INPUT;
  typedef INPUT *LPINPUT; //Pointer
  typedef DWORD WINAPI_WindowStyle; //Alias
  typedef DWORD WINAPI_WindowExStyle; //Alias
  typedef DWORD WINAPI_DialogStyle; //Alias
# pragma pack( push, 2 )
  typedef struct DLGTEMPLATE {
    WINAPI_DialogStyle style;
    WINAPI_WindowExStyle dwExtendedStyle;
    WORD cdit;
    short x;
    short y;
    short cx;
    short cy;
  } DLGTEMPLATE;
# pragma pack( pop )
  typedef DLGTEMPLATE *LPCDLGTEMPLATE; //Pointer
  typedef struct MSGBOXPARAMSA {
    UINT cbSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    LPCSTR lpszText;
    LPCSTR lpszCaption;
    DWORD dwStyle;
    LPCSTR lpszIcon;
    DWORD_PTR dwContextHelpId;
    MSGBOXCALLBACK lpfnMsgBoxCallback;
    DWORD dwLanguageId;
  } MSGBOXPARAMSA;
  typedef MSGBOXPARAMSA *LPMSGBOXPARAMSA; //Pointer
  typedef struct MSGBOXPARAMSW {
    UINT cbSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    LPCWSTR lpszText;
    LPCWSTR lpszCaption;
    DWORD dwStyle;
    LPCWSTR lpszIcon;
    DWORD_PTR dwContextHelpId;
    MSGBOXCALLBACK lpfnMsgBoxCallback;
    DWORD dwLanguageId;
  } MSGBOXPARAMSW;
  typedef MSGBOXPARAMSW *LPMSGBOXPARAMSW; //Pointer
  typedef struct BSMINFO {
    UINT cbSize;
    HDESK hdesk;
    HWND hwnd;
    LUID luid;
  } BSMINFO;
  typedef BSMINFO *PBSMINFO; //Pointer
  typedef struct CHANGEFILTERSTRUCT {
    DWORD cbSize;
    DWORD ExtStatus;
  } CHANGEFILTERSTRUCT;
  typedef CHANGEFILTERSTRUCT *PCHANGEFILTERSTRUCT; //Pointer
  typedef struct ALTTABINFO {
    DWORD cbSize;
    int cItems;
    int cColumns;
    int cRows;
    int iColFocus;
    int iRowFocus;
    int cxItem;
    int cyItem;
    POINT ptStart;
  } ALTTABINFO;
  typedef ALTTABINFO *PALTTABINFO; //Pointer
  typedef DWORD WINAPI_GUITHREADINFO_Flags; //Alias
  typedef struct GUITHREADINFO {
    DWORD cbSize;
    WINAPI_GUITHREADINFO_Flags flags;
    HWND hwndActive;
    HWND hwndFocus;
    HWND hwndCapture;
    HWND hwndMenuOwner;
    HWND hwndMoveSize;
    HWND hwndCaret;
    RECT rcCaret;
  } GUITHREADINFO;
  typedef GUITHREADINFO *LPGUITHREADINFO; //Pointer
  typedef struct WINDOWINFO {
    DWORD cbSize;
    RECT rcWindow;
    RECT rcClient;
    WINAPI_WindowStyle dwStyle;
    WINAPI_WindowExStyle dwExStyle;
    DWORD dwWindowStatus;
    UINT cxWindowBorders;
    UINT cyWindowBorders;
    ATOM atomWindowType;
    WORD wCreatorVersion;
  } WINDOWINFO;
  typedef WINDOWINFO *PWINDOWINFO; //Pointer
  typedef UINT WINAPI_WPF_Flags; //Alias
  typedef struct WINDOWPLACEMENT {
    UINT length;
    WINAPI_WPF_Flags flags;
    UINT showCmd;
    POINT ptMinPosition;
    POINT ptMaxPosition;
    RECT rcNormalPosition;
  } WINDOWPLACEMENT;
  typedef struct UPDATELAYEREDWINDOWINFO {
    DWORD cbSize;
    HDC hdcDst;
    POINT* pptDst;
    SIZE* psize;
    HDC hdcSrc;
    POINT* pptSrc;
    COLORREF crKey;
    BLENDFUNCTION* pblend;
    DWORD dwFlags;
    RECT* prcDirty;
  } UPDATELAYEREDWINDOWINFO;
  typedef struct COMBOBOXINFO {
    DWORD cbSize;
    RECT rcItem;
    RECT rcButton;
    DWORD stateButton;
    HWND hwndCombo;
    HWND hwndItem;
    HWND hwndList;
  } COMBOBOXINFO;
  typedef COMBOBOXINFO *PCOMBOBOXINFO; //Pointer
  typedef DWORD WINAPI_CursorFlags; //Alias
  typedef struct CURSORINFO {
    DWORD cbSize;
    WINAPI_CursorFlags flags;
    HCURSOR hCursor;
    POINT ptScreenPos;
  } CURSORINFO;
  typedef CURSORINFO *PCURSORINFO; //Pointer
  typedef struct CONVCONTEXT {
    UINT cb;
    UINT wFlags;
    UINT wCountryID;
    int iCodePage;
    DWORD dwLangID;
    DWORD dwSecurity;
    SECURITY_QUALITY_OF_SERVICE qos;
  } CONVCONTEXT;
  typedef CONVCONTEXT *PCONVCONTEXT; //Pointer
  typedef UINT WINAPI_CONVINFO_XTYP; //Alias
  static const WINAPI_CONVINFO_XTYP XTYP_ERROR = 0x8002;
  static const WINAPI_CONVINFO_XTYP XTYP_ADVDATA = 0x4010;
  static const WINAPI_CONVINFO_XTYP XTYP_ADVREQ = 0x2022;
  static const WINAPI_CONVINFO_XTYP XTYP_ADVSTART = 0x1030;
  static const WINAPI_CONVINFO_XTYP XTYP_ADVSTOP = 0x8040;
  static const WINAPI_CONVINFO_XTYP XTYP_EXECUTE = 0x4050;
  static const WINAPI_CONVINFO_XTYP XTYP_CONNECT = 0x1062;
  static const WINAPI_CONVINFO_XTYP XTYP_MONITOR = 0x80F2;
  static const WINAPI_CONVINFO_XTYP XTYP_CONNECT_CONFIRM = 0x8072;
  static const WINAPI_CONVINFO_XTYP XTYP_XACT_COMPLETE = 0x8080;
  static const WINAPI_CONVINFO_XTYP XTYP_POKE = 0x4090;
  static const WINAPI_CONVINFO_XTYP XTYP_REGISTER = 0x80A2;
  static const WINAPI_CONVINFO_XTYP XTYP_REQUEST = 0x20B0;
  static const WINAPI_CONVINFO_XTYP XTYP_DISCONNECT = 0x80C2;
  static const WINAPI_CONVINFO_XTYP XTYP_UNREGISTER = 0x80D2;
  static const WINAPI_CONVINFO_XTYP XTYP_WILDCONNECT = 0x20E2;
  typedef UINT WINAPI_CONVINFO_STATUS; //Alias
  static const WINAPI_CONVINFO_STATUS ST_CONNECTED = 0x0001;
  static const WINAPI_CONVINFO_STATUS ST_ADVISE = 0x0002;
  static const WINAPI_CONVINFO_STATUS ST_ISLOCAL = 0x0004;
  static const WINAPI_CONVINFO_STATUS ST_BLOCKED = 0x0008;
  static const WINAPI_CONVINFO_STATUS ST_CLIENT = 0x0010;
  static const WINAPI_CONVINFO_STATUS ST_TERMINATED = 0x0020;
  static const WINAPI_CONVINFO_STATUS ST_INLIST = 0x0040;
  static const WINAPI_CONVINFO_STATUS ST_BLOCKNEXT = 0x0080;
  static const WINAPI_CONVINFO_STATUS ST_ISSELF = 0x0100;
  typedef UINT WINAPI_CONVINFO_STATE; //Alias
  static const WINAPI_CONVINFO_STATE XST_NULL = 0;
  static const WINAPI_CONVINFO_STATE XST_INCOMPLETE = 1;
  static const WINAPI_CONVINFO_STATE XST_CONNECTED = 2;
  static const WINAPI_CONVINFO_STATE XST_INIT1 = 3;
  static const WINAPI_CONVINFO_STATE XST_INIT2 = 4;
  static const WINAPI_CONVINFO_STATE XST_REQSENT = 5;
  static const WINAPI_CONVINFO_STATE XST_DATARCVD = 6;
  static const WINAPI_CONVINFO_STATE XST_POKESENT = 7;
  static const WINAPI_CONVINFO_STATE XST_POKEACKRCVD = 8;
  static const WINAPI_CONVINFO_STATE XST_EXECSENT = 9;
  static const WINAPI_CONVINFO_STATE XST_EXECACKRCVD = 10;
  static const WINAPI_CONVINFO_STATE XST_ADVSENT = 11;
  static const WINAPI_CONVINFO_STATE XST_UNADVSENT = 12;
  static const WINAPI_CONVINFO_STATE XST_ADVACKRCVD = 13;
  static const WINAPI_CONVINFO_STATE XST_UNADVACKRCVD = 14;
  static const WINAPI_CONVINFO_STATE XST_ADVDATASENT = 15;
  static const WINAPI_CONVINFO_STATE XST_ADVDATAACKRCVD = 16;
  typedef struct CONVINFO {
    DWORD cb;
    DWORD_PTR hUser;
    HCONV hConvPartner;
    HSZ hszSvcPartner;
    HSZ hszServiceReq;
    HSZ hszTopic;
    HSZ hszItem;
    UINT wFmt;
    WINAPI_CONVINFO_XTYP wType;
    WINAPI_CONVINFO_STATUS wStatus;
    WINAPI_CONVINFO_STATE wConvst;
    UINT wLastError;
    HCONVLIST hConvList;
    CONVCONTEXT ConvCtxt;
    HWND hwnd;
    HWND hwndPartner;
  } CONVINFO;
  typedef CONVINFO *PCONVINFO; //Pointer
  typedef DWORD WINAPI_FLASHWINFO_Flags; //Alias
  typedef struct FLASHWINFO {
    UINT cbSize;
    HWND hwnd;
    WINAPI_FLASHWINFO_Flags dwFlags;
    UINT uCount;
    DWORD dwTimeout;
  } FLASHWINFO;
  typedef FLASHWINFO *PFLASHWINFO; //Pointer
  typedef struct ICONINFO {
    BOOL fIcon;
    DWORD xHotspot;
    DWORD yHotspot;
    HBITMAP hbmMask;
    HBITMAP hbmColor;
  } ICONINFO;
  typedef ICONINFO *PICONINFO; //Pointer
  typedef BYTE WINAPI_ACCEL_Flags; //Alias
  typedef struct ACCEL {
    WINAPI_ACCEL_Flags fVirt;
    WINAPI_VirtKeyCode key;
    WORD cmd;
  } ACCEL;
  typedef ACCEL *LPACCEL; //Pointer
  typedef struct LASTINPUTINFO {
    UINT cbSize;
    DWORD dwTime;
  } LASTINPUTINFO;
  typedef LASTINPUTINFO *PLASTINPUTINFO; //Pointer
  typedef DWORD WINAPI_MENUINFO_Mask; //Alias
  typedef DWORD WINAPI_MENUINFO_Style; //Alias
  typedef struct MENUINFO {
    DWORD cbSize;
    WINAPI_MENUINFO_Mask fMask;
    WINAPI_MENUINFO_Style dwStyle;
    UINT cyMax;
    HBRUSH hbrBack;
    DWORD dwContextHelpID;
    ULONG_PTR dwMenuData;
  } MENUINFO;
  typedef MENUINFO *LPCMENUINFO; //Pointer
  typedef UINT WINAPI_MENUITEMINFO_MASK; //Alias
  typedef UINT WINAPI_MENUITEM_TYPE; //Alias
  typedef UINT WINAPI_MENUITEM_STATE; //Alias
  typedef HBITMAP WINAPI_HBMMENU; //Alias
  typedef struct MENUITEMINFOA {
    UINT cbSize;
    WINAPI_MENUITEMINFO_MASK fMask;
    WINAPI_MENUITEM_TYPE fType;
    WINAPI_MENUITEM_STATE fState;
    UINT wID;
    HMENU hSubMenu;
    HBITMAP hbmpChecked;
    HBITMAP hbmpUnchecked;
    ULONG_PTR dwItemData;
    LPSTR dwTypeData;
    UINT cch;
    WINAPI_HBMMENU hbmpItem;
  } MENUITEMINFOA;
  typedef MENUITEMINFOA *LPMENUITEMINFOA; //Pointer
  typedef MENUITEMINFOA *LPCMENUITEMINFOA; //Pointer
  typedef struct MENUITEMINFOW {
    UINT cbSize;
    WINAPI_MENUITEMINFO_MASK fMask;
    WINAPI_MENUITEM_TYPE fType;
    WINAPI_MENUITEM_STATE fState;
    UINT wID;
    HMENU hSubMenu;
    HBITMAP hbmpChecked;
    HBITMAP hbmpUnchecked;
    ULONG_PTR dwItemData;
    LPWSTR dwTypeData;
    UINT cch;
    WINAPI_HBMMENU hbmpItem;
  } MENUITEMINFOW;
  typedef MENUITEMINFOW *LPMENUITEMINFOW; //Pointer
  typedef MENUITEMINFOW *LPCMENUITEMINFOW; //Pointer
  typedef struct TPMPARAMS {
    UINT cbSize;
    RECT rcExclude;
  } TPMPARAMS;
  typedef TPMPARAMS *LPTPMPARAMS; //Pointer
  typedef struct MOUSEMOVEPOINT {
    int x;
    int y;
    DWORD time;
    ULONG_PTR dwExtraInfo;
  } MOUSEMOVEPOINT;
  typedef MOUSEMOVEPOINT *LPMOUSEMOVEPOINT; //Pointer
  typedef struct MONITORINFO {
    DWORD cbSize;
    RECT rcMonitor;
    RECT rcWork;
    WINAPI_MONITORINFO_Flags dwFlags;
  } MONITORINFO;
  typedef MONITORINFO *LPMONITORINFO; //Pointer
  typedef DWORD WINAPI_RAWINPUTDEVICE_Flags; //Alias
  typedef struct RAWINPUTDEVICE {
    USHORT usUsagePage;
    USHORT usUsage;
    WINAPI_RAWINPUTDEVICE_Flags dwFlags;
    HWND hwndTarget;
  } RAWINPUTDEVICE;
  typedef RAWINPUTDEVICE *PRAWINPUTDEVICE; //Pointer
  typedef RAWINPUTDEVICE *PCRAWINPUTDEVICE; //Pointer
  typedef DWORD WINAPI_RIM_TYPE; //Alias
  static const WINAPI_RIM_TYPE RIM_TYPEMOUSE = 0;
  static const WINAPI_RIM_TYPE RIM_TYPEKEYBOARD = 1;
  static const WINAPI_RIM_TYPE RIM_TYPEHID = 2;
  typedef struct RAWINPUTDEVICELIST {
    HANDLE hDevice;
    WINAPI_RIM_TYPE dwType;
  } RAWINPUTDEVICELIST;
  typedef RAWINPUTDEVICELIST *PRAWINPUTDEVICELIST; //Pointer
  typedef UINT WINAPI_ClassStyle; //Alias
  typedef struct WNDCLASSA {
    WINAPI_ClassStyle style;
    WNDPROC lpfnWndProc;
    int cbClsExtra;
    int cbWndExtra;
    HINSTANCE hInstance;
    HICON hIcon;
    HCURSOR hCursor;
    HBRUSH hbrBackground;
    LPCSTR lpszMenuName;
    LPCSTR lpszClassName;
  } WNDCLASSA;
  typedef WNDCLASSA *LPWNDCLASSA; //Pointer
  typedef struct WNDCLASSW {
    WINAPI_ClassStyle style;
    WNDPROC lpfnWndProc;
    int cbClsExtra;
    int cbWndExtra;
    HINSTANCE hInstance;
    HICON hIcon;
    HCURSOR hCursor;
    HBRUSH hbrBackground;
    LPCWSTR lpszMenuName;
    LPCWSTR lpszClassName;
  } WNDCLASSW;
  typedef WNDCLASSW *LPWNDCLASSW; //Pointer
  typedef struct WNDCLASSEXA {
    UINT cbSize;
    WINAPI_ClassStyle style;
    WNDPROC lpfnWndProc;
    int cbClsExtra;
    int cbWndExtra;
    HINSTANCE hInstance;
    HICON hIcon;
    HCURSOR hCursor;
    HBRUSH hbrBackground;
    LPCSTR lpszMenuName;
    LPCSTR lpszClassName;
    HICON hIconSm;
  } WNDCLASSEXA;
  typedef WNDCLASSEXA *LPWNDCLASSEXA; //Pointer
  typedef struct WNDCLASSEXW {
    UINT cbSize;
    WINAPI_ClassStyle style;
    WNDPROC lpfnWndProc;
    int cbClsExtra;
    int cbWndExtra;
    HINSTANCE hInstance;
    HICON hIcon;
    HCURSOR hCursor;
    HBRUSH hbrBackground;
    LPCWSTR lpszMenuName;
    LPCWSTR lpszClassName;
    HICON hIconSm;
  } WNDCLASSEXW;
  typedef WNDCLASSEXW *LPWNDCLASSEXW; //Pointer
  typedef UINT WINAPI_ExitWindowsExFlags; //Alias
  static const WINAPI_ExitWindowsExFlags EWX_LOGOFF = 0;
  static const WINAPI_ExitWindowsExFlags EWX_POWEROFF = 0x00000008;
  static const WINAPI_ExitWindowsExFlags EWX_REBOOT = 0x00000002;
  static const WINAPI_ExitWindowsExFlags EWX_RESTARTAPPS = 0x00000040;
  static const WINAPI_ExitWindowsExFlags EWX_SHUTDOWN = 0x00000001;
  typedef DWORD WINAPI_ExitWindowsExReason; //Alias
  static const WINAPI_ExitWindowsExReason EWX_FORCE = 0x00000004;
  static const WINAPI_ExitWindowsExReason EWX_FORCEIFHUNG = 0x00000010;
  typedef int WINAPI_WindowLongIndex; //Alias
  static const WINAPI_WindowLongIndex GWL_WNDPROC = -4;
  static const WINAPI_WindowLongIndex GWL_HINSTANCE = -6;
  static const WINAPI_WindowLongIndex GWL_HWNDPARENT = -8;
  static const WINAPI_WindowLongIndex GWL_ID = -12;
  static const WINAPI_WindowLongIndex GWL_STYLE = -16;
  static const WINAPI_WindowLongIndex GWL_EXSTYLE = -20;
  static const WINAPI_WindowLongIndex GWL_USERDATA = -21;
  static const WINAPI_WindowLongIndex DWL_MSGRESULT = 0;
  static const WINAPI_WindowLongIndex DWL_DLGPROC = 4;
  static const WINAPI_WindowLongIndex DWL_USER = 8;
  typedef int WINAPI_ClassLongIndex; //Alias
  static const WINAPI_ClassLongIndex GCL_MENUNAME = -8;
  static const WINAPI_ClassLongIndex GCL_HBRBACKGROUND = -10;
  static const WINAPI_ClassLongIndex GCL_HCURSOR = -12;
  static const WINAPI_ClassLongIndex GCL_HICON = -14;
  static const WINAPI_ClassLongIndex GCL_HMODULE = -16;
  static const WINAPI_ClassLongIndex GCL_CBWNDEXTRA = -18;
  static const WINAPI_ClassLongIndex GCL_CBCLSEXTRA = -20;
  static const WINAPI_ClassLongIndex GCL_WNDPROC = -24;
  static const WINAPI_ClassLongIndex GCL_STYLE = -26;
  static const WINAPI_ClassLongIndex GCW_ATOM = -32;
  static const WINAPI_ClassLongIndex GCL_HICONSM = -34;
  typedef int WINAPI_SystemMetricIndex; //Alias
  static const WINAPI_SystemMetricIndex SM_CXSCREEN = 0;
  static const WINAPI_SystemMetricIndex SM_CYSCREEN = 1;
  static const WINAPI_SystemMetricIndex SM_CXVSCROLL = 2;
  static const WINAPI_SystemMetricIndex SM_CYHSCROLL = 3;
  static const WINAPI_SystemMetricIndex SM_CYCAPTION = 4;
  static const WINAPI_SystemMetricIndex SM_CXBORDER = 5;
  static const WINAPI_SystemMetricIndex SM_CYBORDER = 6;
  static const WINAPI_SystemMetricIndex SM_CXDLGFRAME = 7;
  static const WINAPI_SystemMetricIndex SM_CYDLGFRAME = 8;
  static const WINAPI_SystemMetricIndex SM_CYVTHUMB = 9;
  static const WINAPI_SystemMetricIndex SM_CXHTHUMB = 10;
  static const WINAPI_SystemMetricIndex SM_CXICON = 11;
  static const WINAPI_SystemMetricIndex SM_CYICON = 12;
  static const WINAPI_SystemMetricIndex SM_CXCURSOR = 13;
  static const WINAPI_SystemMetricIndex SM_CYCURSOR = 14;
  static const WINAPI_SystemMetricIndex SM_CYMENU = 15;
  static const WINAPI_SystemMetricIndex SM_CXFULLSCREEN = 16;
  static const WINAPI_SystemMetricIndex SM_CYFULLSCREEN = 17;
  static const WINAPI_SystemMetricIndex SM_CYKANJIWINDOW = 18;
  static const WINAPI_SystemMetricIndex SM_MOUSEPRESENT = 19;
  static const WINAPI_SystemMetricIndex SM_CYVSCROLL = 20;
  static const WINAPI_SystemMetricIndex SM_CXHSCROLL = 21;
  static const WINAPI_SystemMetricIndex SM_DEBUG = 22;
  static const WINAPI_SystemMetricIndex SM_SWAPBUTTON = 23;
  static const WINAPI_SystemMetricIndex SM_RESERVED1 = 24;
  static const WINAPI_SystemMetricIndex SM_RESERVED2 = 25;
  static const WINAPI_SystemMetricIndex SM_RESERVED3 = 26;
  static const WINAPI_SystemMetricIndex SM_RESERVED4 = 27;
  static const WINAPI_SystemMetricIndex SM_CXMIN = 28;
  static const WINAPI_SystemMetricIndex SM_CYMIN = 29;
  static const WINAPI_SystemMetricIndex SM_CXSIZE = 30;
  static const WINAPI_SystemMetricIndex SM_CYSIZE = 31;
  static const WINAPI_SystemMetricIndex SM_CXFRAME = 32;
  static const WINAPI_SystemMetricIndex SM_CYFRAME = 33;
  static const WINAPI_SystemMetricIndex SM_CXMINTRACK = 34;
  static const WINAPI_SystemMetricIndex SM_CYMINTRACK = 35;
  static const WINAPI_SystemMetricIndex SM_CXDOUBLECLK = 36;
  static const WINAPI_SystemMetricIndex SM_CYDOUBLECLK = 37;
  static const WINAPI_SystemMetricIndex SM_CXICONSPACING = 38;
  static const WINAPI_SystemMetricIndex SM_CYICONSPACING = 39;
  static const WINAPI_SystemMetricIndex SM_MENUDROPALIGNMENT = 40;
  static const WINAPI_SystemMetricIndex SM_PENWINDOWS = 41;
  static const WINAPI_SystemMetricIndex SM_DBCSENABLED = 42;
  static const WINAPI_SystemMetricIndex SM_CMOUSEBUTTONS = 43;
  static const WINAPI_SystemMetricIndex SM_SECURE = 44;
  static const WINAPI_SystemMetricIndex SM_CXEDGE = 45;
  static const WINAPI_SystemMetricIndex SM_CYEDGE = 46;
  static const WINAPI_SystemMetricIndex SM_CXMINSPACING = 47;
  static const WINAPI_SystemMetricIndex SM_CYMINSPACING = 48;
  static const WINAPI_SystemMetricIndex SM_CXSMICON = 49;
  static const WINAPI_SystemMetricIndex SM_CYSMICON = 50;
  static const WINAPI_SystemMetricIndex SM_CYSMCAPTION = 51;
  static const WINAPI_SystemMetricIndex SM_CXSMSIZE = 52;
  static const WINAPI_SystemMetricIndex SM_CYSMSIZE = 53;
  static const WINAPI_SystemMetricIndex SM_CXMENUSIZE = 54;
  static const WINAPI_SystemMetricIndex SM_CYMENUSIZE = 55;
  static const WINAPI_SystemMetricIndex SM_ARRANGE = 56;
  static const WINAPI_SystemMetricIndex SM_CXMINIMIZED = 57;
  static const WINAPI_SystemMetricIndex SM_CYMINIMIZED = 58;
  static const WINAPI_SystemMetricIndex SM_CXMAXTRACK = 59;
  static const WINAPI_SystemMetricIndex SM_CYMAXTRACK = 60;
  static const WINAPI_SystemMetricIndex SM_CXMAXIMIZED = 61;
  static const WINAPI_SystemMetricIndex SM_CYMAXIMIZED = 62;
  static const WINAPI_SystemMetricIndex SM_NETWORK = 63;
  static const WINAPI_SystemMetricIndex SM_CLEANBOOT = 67;
  static const WINAPI_SystemMetricIndex SM_CXDRAG = 68;
  static const WINAPI_SystemMetricIndex SM_CYDRAG = 69;
  static const WINAPI_SystemMetricIndex SM_SHOWSOUNDS = 70;
  static const WINAPI_SystemMetricIndex SM_CXMENUCHECK = 71;
  static const WINAPI_SystemMetricIndex SM_CYMENUCHECK = 72;
  static const WINAPI_SystemMetricIndex SM_SLOWMACHINE = 73;
  static const WINAPI_SystemMetricIndex SM_MIDEASTENABLED = 74;
  static const WINAPI_SystemMetricIndex SM_MOUSEWHEELPRESENT = 75;
  static const WINAPI_SystemMetricIndex SM_XVIRTUALSCREEN = 76;
  static const WINAPI_SystemMetricIndex SM_YVIRTUALSCREEN = 77;
  static const WINAPI_SystemMetricIndex SM_CXVIRTUALSCREEN = 78;
  static const WINAPI_SystemMetricIndex SM_CYVIRTUALSCREEN = 79;
  static const WINAPI_SystemMetricIndex SM_CMONITORS = 80;
  static const WINAPI_SystemMetricIndex SM_SAMEDISPLAYFORMAT = 81;
  static const WINAPI_SystemMetricIndex SM_IMMENABLED = 82;
  static const WINAPI_SystemMetricIndex SM_CXFOCUSBORDER = 83;
  static const WINAPI_SystemMetricIndex SM_CYFOCUSBORDER = 84;
  static const WINAPI_SystemMetricIndex SM_TABLETPC = 86;
  static const WINAPI_SystemMetricIndex SM_MEDIACENTER = 87;
  static const WINAPI_SystemMetricIndex SM_STARTER = 88;
  static const WINAPI_SystemMetricIndex SM_SERVERR2 = 89;
  static const WINAPI_SystemMetricIndex SM_MOUSEHORIZONTALWHEELPRESENT = 91;
  static const WINAPI_SystemMetricIndex SM_CXPADDEDBORDER = 92;
  typedef UINT WINAPI_PeekMessageFlag; //Alias
  typedef DWORD WINAPI_QueueStatusFlag; //Alias
  typedef DWORD WINAPI_WindowMessageFilterEnum; //Alias
  static const WINAPI_WindowMessageFilterEnum MSGFLT_ADD = 1;
  static const WINAPI_WindowMessageFilterEnum MSGFLT_REMOVE = 2;
  typedef int WINAPI_UserObjectInformationEnum; //Alias
  static const WINAPI_UserObjectInformationEnum UOI_FLAGS = 1;
  static const WINAPI_UserObjectInformationEnum UOI_NAME = 2;
  static const WINAPI_UserObjectInformationEnum UOI_TYPE = 3;
  static const WINAPI_UserObjectInformationEnum UOI_USER_SID = 4;
  static const WINAPI_UserObjectInformationEnum UOI_HEAPSIZE = 5;
  static const WINAPI_UserObjectInformationEnum UOI_IO = 6;
  typedef UINT WINAPI_GetAncestorEnum; //Alias
  static const WINAPI_GetAncestorEnum GA_PARENT = 1;
  static const WINAPI_GetAncestorEnum GA_ROOT = 2;
  static const WINAPI_GetAncestorEnum GA_ROOTOWNER = 3;
  typedef UINT WINAPI_GetWindowEnum; //Alias
  static const WINAPI_GetWindowEnum GW_HWNDFIRST = 0;
  static const WINAPI_GetWindowEnum GW_HWNDLAST = 1;
  static const WINAPI_GetWindowEnum GW_HWNDNEXT = 2;
  static const WINAPI_GetWindowEnum GW_HWNDPREV = 3;
  static const WINAPI_GetWindowEnum GW_OWNER = 4;
  static const WINAPI_GetWindowEnum GW_CHILD = 5;
  static const WINAPI_GetWindowEnum GW_ENABLEDPOPUP = 6;
  typedef DWORD WINAPI_DCExFlags; //Alias
  typedef DWORD WINAPI_EnumDisplayDevicesFlags; //Alias
  typedef UINT WINAPI_WinEventFlags; //Alias
  typedef UINT WINAPI_RedrawWindowFlags; //Alias
  typedef DWORD WINAPI_AnimateWindowFlags; //Alias
  typedef UINT WINAPI_SetWindowPosFlags; //Alias
  typedef UINT WINAPI_SendMessageTimeoutFlags; //Alias
  typedef UINT WINAPI_DrawIconFlags; //Alias
  typedef LONG WINAPI_ObjectIdEnum; //Alias
  static const WINAPI_ObjectIdEnum OBJID_WINDOW = 0x00000000;
  static const WINAPI_ObjectIdEnum OBJID_SYSMENU = 0xFFFFFFFF;
  static const WINAPI_ObjectIdEnum OBJID_TITLEBAR = 0xFFFFFFFE;
  static const WINAPI_ObjectIdEnum OBJID_MENU = 0xFFFFFFFD;
  static const WINAPI_ObjectIdEnum OBJID_CLIENT = 0xFFFFFFFC;
  static const WINAPI_ObjectIdEnum OBJID_VSCROLL = 0xFFFFFFFB;
  static const WINAPI_ObjectIdEnum OBJID_HSCROLL = 0xFFFFFFFA;
  static const WINAPI_ObjectIdEnum OBJID_SIZEGRIP = 0xFFFFFFF9;
  static const WINAPI_ObjectIdEnum OBJID_CARET = 0xFFFFFFF8;
  static const WINAPI_ObjectIdEnum OBJID_CURSOR = 0xFFFFFFF7;
  static const WINAPI_ObjectIdEnum OBJID_ALERT = 0xFFFFFFF6;
  static const WINAPI_ObjectIdEnum OBJID_SOUND = 0xFFFFFFF5;
  static const WINAPI_ObjectIdEnum OBJID_QUERYCLASSNAMEIDX = 0xFFFFFFF4;
  static const WINAPI_ObjectIdEnum OBJID_NATIVEOM = 0xFFFFFFF0;
  typedef UINT WINAPI_DrawStateFlags; //Alias
  typedef UINT WINAPI_MenuCommandPosFlag; //Alias
  static const WINAPI_MenuCommandPosFlag MF_BYCOMMAND = 0x00000000;
  static const WINAPI_MenuCommandPosFlag MF_BYPOSITION = 0x00000400;
  typedef UINT WINAPI_InsertMenuFlags; //Alias
  typedef UINT WINAPI_EnableMenuItemFlag; //Alias
  typedef int WINAPI_EnableMenuItemResult; //Alias
  static const WINAPI_EnableMenuItemResult MF_ENABLED = 0x00000000;
  static const WINAPI_EnableMenuItemResult MF_GRAYED = 0x00000001;
  static const WINAPI_EnableMenuItemResult MF_DISABLED = 0x00000002;
  typedef UINT WINAPI_CheckMenuItemFlag; //Alias
  typedef UINT WINAPI_ClipboardFormat; //Alias
  static const WINAPI_ClipboardFormat CF_TEXT = 1;
  static const WINAPI_ClipboardFormat CF_BITMAP = 2;
  static const WINAPI_ClipboardFormat CF_METAFILEPICT = 3;
  static const WINAPI_ClipboardFormat CF_SYLK = 4;
  static const WINAPI_ClipboardFormat CF_DIF = 5;
  static const WINAPI_ClipboardFormat CF_TIFF = 6;
  static const WINAPI_ClipboardFormat CF_OEMTEXT = 7;
  static const WINAPI_ClipboardFormat CF_DIB = 8;
  static const WINAPI_ClipboardFormat CF_PALETTE = 9;
  static const WINAPI_ClipboardFormat CF_PENDATA = 10;
  static const WINAPI_ClipboardFormat CF_RIFF = 11;
  static const WINAPI_ClipboardFormat CF_WAVE = 12;
  static const WINAPI_ClipboardFormat CF_UNICODETEXT = 13;
  static const WINAPI_ClipboardFormat CF_ENHMETAFILE = 14;
  static const WINAPI_ClipboardFormat CF_HDROP = 15;
  static const WINAPI_ClipboardFormat CF_LOCALE = 16;
  static const WINAPI_ClipboardFormat CF_DIBV5 = 17;
  static const WINAPI_ClipboardFormat CF_OWNERDISPLAY = 0x0080;
  static const WINAPI_ClipboardFormat CF_DSPTEXT = 0x0081;
  static const WINAPI_ClipboardFormat CF_DSPBITMAP = 0x0082;
  static const WINAPI_ClipboardFormat CF_DSPMETAFILEPICT = 0x0083;
  static const WINAPI_ClipboardFormat CF_DSPENHMETAFILE = 0x008E;
  typedef HWND WINAPI_HwndInsertAfterEnum; //Alias
  typedef int WINAPI_WindowsHook; //Alias
  static const WINAPI_WindowsHook WH_MSGFILTER = -1;
  static const WINAPI_WindowsHook WH_JOURNALRECORD = 0;
  static const WINAPI_WindowsHook WH_JOURNALPLAYBACK = 1;
  static const WINAPI_WindowsHook WH_KEYBOARD = 2;
  static const WINAPI_WindowsHook WH_GETMESSAGE = 3;
  static const WINAPI_WindowsHook WH_CALLWNDPROC = 4;
  static const WINAPI_WindowsHook WH_CBT = 5;
  static const WINAPI_WindowsHook WH_SYSMSGFILTER = 6;
  static const WINAPI_WindowsHook WH_MOUSE = 7;
  static const WINAPI_WindowsHook WH_HARDWARE = 8;
  static const WINAPI_WindowsHook WH_DEBUG = 9;
  static const WINAPI_WindowsHook WH_SHELL = 10;
  static const WINAPI_WindowsHook WH_FOREGROUNDIDLE = 11;
  static const WINAPI_WindowsHook WH_CALLWNDPROCRET = 12;
  static const WINAPI_WindowsHook WH_KEYBOARD_LL = 13;
  static const WINAPI_WindowsHook WH_MOUSE_LL = 14;
  typedef DWORD WINAPI_MsgWaitForMultipleObjectsFlags; //Alias
  typedef HKL WINAPI_KeyboardLayoutHandle; //Alias
  typedef HKL_ WINAPI_KeyboardLayoutHandle_; //Alias
  static const WINAPI_KeyboardLayoutHandle_ HKL_PREV = 0;
  static const WINAPI_KeyboardLayoutHandle_ HKL_NEXT = 1;
  typedef UINT WINAPI_KeyboardLayoutFlags; //Alias
  typedef DWORD WINAPI_MonitorFlags; //Alias
  typedef UINT WINAPI_ScrollWindowFlags; //Alias
  typedef DWORD WINAPI_EnumDisplaySettingsEnum; //Alias
  static const WINAPI_EnumDisplaySettingsEnum ENUM_CURRENT_SETTINGS = -1;
  static const WINAPI_EnumDisplaySettingsEnum ENUM_REGISTRY_SETTINGS = -2;
  typedef UINT WINAPI_ButtonState; //Alias
  static const WINAPI_ButtonState BST_UNCHECKED = 0x0000;
  static const WINAPI_ButtonState BST_CHECKED = 0x0001;
  static const WINAPI_ButtonState BST_INDETERMINATE = 0x0002;
  static const WINAPI_ButtonState BST_PUSHED = 0x0004;
  static const WINAPI_ButtonState BST_FOCUS = 0x0008;
  typedef DWORD WINAPI_LayeredWindowAttribute; //Alias
  typedef DWORD WINAPI_UpdateLayeredWindowFlags; //Alias
  typedef UINT WINAPI_MapVirtualKeyType; //Alias
  static const WINAPI_MapVirtualKeyType MAPVK_VK_TO_VSC = 0;
  static const WINAPI_MapVirtualKeyType MAPVK_VSC_TO_VK = 1;
  static const WINAPI_MapVirtualKeyType MAPVK_VK_TO_CHAR = 2;
  static const WINAPI_MapVirtualKeyType MAPVK_VSC_TO_VK_EX = 3;
  static const WINAPI_MapVirtualKeyType MAPVK_VK_TO_VSC_EX = 4;
  typedef DWORD WINAPI_DesktopFlags; //Alias
  static const WINAPI_DesktopFlags DF_ALLOWOTHERACCOUNTHOOK = 0x0001;
  typedef ACCESS_MASK WINAPI_DESKTOP_ACCESS_MASK; //Alias
  typedef DWORD WINAPI_WindowStationAccessRights; //Alias
  typedef DWORD WINAPI_CreateWindowStationFlags; //Alias
  static const WINAPI_CreateWindowStationFlags CWF_CREATE_ONLY = 0x00000001;
  typedef UINT WINAPI_LockSetForegroundWindowCode; //Alias
  static const WINAPI_LockSetForegroundWindowCode LSFW_LOCK = 1;
  static const WINAPI_LockSetForegroundWindowCode LSFW_UNLOCK = 2;
  typedef DWORD WINAPI_DeviceNotificationFlags; //Alias
  typedef UINT WINAPI_TrackPopupMenuFlags; //Alias
  typedef UINT WINAPI_GetMenuDefaultItemFlags; //Alias
  typedef uintptr_t WINAPI_LoadImageString_LPCTSTR; //Alias
  typedef UINT_PTR_ WINAPI_LoadImageString_LPCTSTR_; //Alias max ffi ptr
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_CLOSE = 32754;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_UPARROW = 32753;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_DNARROW = 32752;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_RGARROW = 32751;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_LFARROW = 32750;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_REDUCE = 32749;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_ZOOM = 32748;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_RESTORE = 32747;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_REDUCED = 32746;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_ZOOMD = 32745;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_RESTORED = 32744;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_UPARROWD = 32743;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_DNARROWD = 32742;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_RGARROWD = 32741;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_LFARROWD = 32740;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_MNARROW = 32739;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_COMBO = 32738;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_UPARROWI = 32737;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_DNARROWI = 32736;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_RGARROWI = 32735;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_LFARROWI = 32734;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_OLD_CLOSE = 32767;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_SIZE = 32766;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_OLD_UPARROW = 32765;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_OLD_DNARROW = 32764;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_OLD_RGARROW = 32763;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_OLD_LFARROW = 32762;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_BTSIZE = 32761;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_CHECK = 32760;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_CHECKBOXES = 32759;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_BTNCORNERS = 32758;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_OLD_REDUCE = 32757;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_OLD_ZOOM = 32756;
  static const WINAPI_LoadImageString_LPCTSTR_ OBM_OLD_RESTORE = 32755;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_NORMAL = 32512;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_IBEAM = 32513;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_WAIT = 32514;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_CROSS = 32515;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_UP = 32516;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_SIZE = 32640;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_ICON = 32641;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_SIZENWSE = 32642;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_SIZENESW = 32643;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_SIZEWE = 32644;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_SIZENS = 32645;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_SIZEALL = 32646;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_ICOCUR = 32647;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_NO = 32648;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_HAND = 32649;
  static const WINAPI_LoadImageString_LPCTSTR_ OCR_APPSTARTING = 32650;
  static const WINAPI_LoadImageString_LPCTSTR_ OIC_SAMPLE = 32512;
  static const WINAPI_LoadImageString_LPCTSTR_ OIC_ERROR = 32513;
  static const WINAPI_LoadImageString_LPCTSTR_ OIC_QUES = 32514;
  static const WINAPI_LoadImageString_LPCTSTR_ OIC_WARNING = 32515;
  static const WINAPI_LoadImageString_LPCTSTR_ OIC_INFORMATION = 32516;
  static const WINAPI_LoadImageString_LPCTSTR_ OIC_WINLOGO = 32517;
  static const WINAPI_LoadImageString_LPCTSTR_ OIC_SHIELD = 32518;
  typedef uintptr_t WINAPI_LoadBitmapString_LPCTSTR; //Alias
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_CLOSE = 32754;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_UPARROW = 32753;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_DNARROW = 32752;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_RGARROW = 32751;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_LFARROW = 32750;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_REDUCE = 32749;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_ZOOM = 32748;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_RESTORE = 32747;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_REDUCED = 32746;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_ZOOMD = 32745;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_RESTORED = 32744;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_UPARROWD = 32743;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_DNARROWD = 32742;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_RGARROWD = 32741;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_LFARROWD = 32740;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_MNARROW = 32739;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_COMBO = 32738;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_UPARROWI = 32737;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_DNARROWI = 32736;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_RGARROWI = 32735;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_LFARROWI = 32734;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_OLD_CLOSE = 32767;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_SIZE = 32766;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_OLD_UPARROW = 32765;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_OLD_DNARROW = 32764;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_OLD_RGARROW = 32763;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_OLD_LFARROW = 32762;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_BTSIZE = 32761;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_CHECK = 32760;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_CHECKBOXES = 32759;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_BTNCORNERS = 32758;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_OLD_REDUCE = 32757;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_OLD_ZOOM = 32756;
//static const WINAPI_LoadBitmapString_LPCTSTR OBM_OLD_RESTORE = 32755;
  typedef uintptr_t WINAPI_LoadCursorString_LPCTSTR; //Alias
  typedef UINT_PTR_ WINAPI_LoadCursorString_LPCTSTR_; //Alias max ffi ptr
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_ARROW = 32512;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_IBEAM = 32513;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_WAIT = 32514;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_CROSS = 32515;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_UPARROW = 32516;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_SIZE = 32640;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_ICON = 32641;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_SIZENWSE = 32642;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_SIZENESW = 32643;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_SIZEWE = 32644;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_SIZENS = 32645;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_SIZEALL = 32646;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_NO = 32648;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_HAND = 32649;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_APPSTARTING = 32650;
  static const WINAPI_LoadCursorString_LPCTSTR_ IDC_HELP = 32651;
  typedef uintptr_t WINAPI_LoadIconString_LPCTSTR; //Alias
  typedef UINT_PTR_ WINAPI_LoadIconString_LPCTSTR_; //Alias max ffi ptr
  static const WINAPI_LoadIconString_LPCTSTR_ IDI_APPLICATION = 32512;
  static const WINAPI_LoadIconString_LPCTSTR_ IDI_ERROR = 32513;
  static const WINAPI_LoadIconString_LPCTSTR_ IDI_QUESTION = 32514;
  static const WINAPI_LoadIconString_LPCTSTR_ IDI_WARNING = 32515;
  static const WINAPI_LoadIconString_LPCTSTR_ IDI_INFORMATION = 32516;
  static const WINAPI_LoadIconString_LPCTSTR_ IDI_WINLOGO = 32517;
  static const WINAPI_LoadIconString_LPCTSTR_ IDI_SHIELD = 32518;
  typedef DWORD WINAPI_CursorId; //Alias
//static const WINAPI_CursorId OCR_NORMAL = 32512;
//static const WINAPI_CursorId OCR_IBEAM = 32513;
//static const WINAPI_CursorId OCR_WAIT = 32514;
//static const WINAPI_CursorId OCR_CROSS = 32515;
//static const WINAPI_CursorId OCR_UP = 32516;
//static const WINAPI_CursorId OCR_SIZE = 32640;
//static const WINAPI_CursorId OCR_ICON = 32641;
//static const WINAPI_CursorId OCR_SIZENWSE = 32642;
//static const WINAPI_CursorId OCR_SIZENESW = 32643;
//static const WINAPI_CursorId OCR_SIZEWE = 32644;
//static const WINAPI_CursorId OCR_SIZENS = 32645;
//static const WINAPI_CursorId OCR_SIZEALL = 32646;
//static const WINAPI_CursorId OCR_ICOCUR = 32647;
//static const WINAPI_CursorId OCR_NO = 32648;
//static const WINAPI_CursorId OCR_HAND = 32649;
//static const WINAPI_CursorId OCR_APPSTARTING = 32650;
  typedef int WINAPI_WindowRegion; //Alias
  static const WINAPI_WindowRegion ERROR = 0;
  static const WINAPI_WindowRegion NULLREGION = 1;
  static const WINAPI_WindowRegion SIMPLEREGION = 2;
  static const WINAPI_WindowRegion COMPLEXREGION = 3;
  typedef DWORD WINAPI_TOUCHINPUT_Flags; //Alias
  typedef DWORD WINAPI_TOUCHINPUT_Mask; //Alias
  typedef struct TOUCHINPUT {
    LONG x;
    LONG y;
    HANDLE hSource;
    DWORD dwID;
    WINAPI_TOUCHINPUT_Flags dwFlags;
    WINAPI_TOUCHINPUT_Mask dwMask;
    DWORD dwTime;
    ULONG_PTR dwExtraInfo;
    DWORD cxContact;
    DWORD cyContact;
  } TOUCHINPUT;
  typedef TOUCHINPUT *PTOUCHINPUT; //Pointer
  typedef DWORD WINAPI_GestureId; //Alias
  typedef struct GESTURECONFIG {
    WINAPI_GestureId dwID;
    DWORD dwWant;
    DWORD dwBlock;
  } GESTURECONFIG;
  typedef GESTURECONFIG *PGESTURECONFIG; //Pointer
  typedef struct POINTS {
    SHORT x;
    SHORT y;
  } POINTS;
  typedef DWORD WINAPI_GESTUREINFO_Flags; //Alias
  typedef struct GESTUREINFO {
    UINT cbSize;
    WINAPI_GESTUREINFO_Flags dwFlags;
    DWORD dwID;
    HWND hwndTarget;
    POINTS ptsLocation;
    DWORD dwInstanceID;
    DWORD dwSequenceID;
    ULONGLONG ullArguments;
    UINT cbExtraArgs;
  } GESTUREINFO;
  typedef GESTUREINFO *PGESTUREINFO; //Pointer
  typedef struct RAWINPUTHEADER {
    WINAPI_RIM_TYPE dwType;
    DWORD dwSize;
    HANDLE hDevice;
    WPARAM wParam;
  } RAWINPUTHEADER;
  typedef USHORT WINAPI_RAWMOUSE_STATE; //Alias
  typedef struct WINAPI_RAWMOUSE_u_s {
    WINAPI_RAWMOUSE_STATE usButtonFlags;
    USHORT usButtonData;
  } WINAPI_RAWMOUSE_u_s;
  typedef union WINAPI_RAWMOUSE_u {
    ULONG ulButtons;
    WINAPI_RAWMOUSE_u_s ;
  } WINAPI_RAWMOUSE_u;
  typedef USHORT WINAPI_RAWMOUSE_FLAGS; //Alias
  typedef struct RAWMOUSE {
    WINAPI_RAWMOUSE_FLAGS usFlags;
    WINAPI_RAWMOUSE_u ;
    ULONG ulRawButtons;
    LONG lLastX;
    LONG lLastY;
    ULONG ulExtraInformation;
  } RAWMOUSE;
  typedef USHORT WINAPI_RAWKEYBOARD_FLAGS; //Alias
  typedef struct RAWKEYBOARD {
    USHORT MakeCode;
    WINAPI_RAWKEYBOARD_FLAGS Flags;
    USHORT Reserved;
    WINAPI_VirtKeyCode VKey;
    WINAPI_WinMsg Message;
    ULONG ExtraInformation;
  } RAWKEYBOARD;
  typedef struct RAWHID {
    DWORD dwSizeHid;
    DWORD dwCount;
    BYTE bRawData[1];
  } RAWHID;
  typedef union WINAPI_RAWINPUT_u {
    RAWMOUSE mouse;
    RAWKEYBOARD keyboard;
    RAWHID hid;
  } WINAPI_RAWINPUT_u;
  typedef struct RAWINPUT {
    RAWINPUTHEADER header;
    WINAPI_RAWINPUT_u data;
  } RAWINPUT;
  typedef RAWINPUT *PRAWINPUT; //Pointer
  typedef int WINAPI_CreateWindow_CW; //Alias
  static const WINAPI_CreateWindow_CW CW_USEDEFAULT = 0x80000000;
  typedef struct WINCOMPATTRDATA {
    WINAPI_DwmWindowAttr attribute;
    PVOID pData;
    ULONG dataSize;
  } WINCOMPATTRDATA;
  HWND                        CreateDialogIndirectParamA(         HINSTANCE hInstance, LPCDLGTEMPLATE lpTemplate, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM lParamInit);
  HWND                        CreateDialogIndirectParamW(         HINSTANCE hInstance, LPCDLGTEMPLATE lpTemplate, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM lParamInit);
  HWND                        CreateDialogParamA(                 HINSTANCE hInstance, LPCSTR lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM lParamInit);
  HWND                        CreateDialogParamW(                 HINSTANCE hInstance, LPCWSTR lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM lParamInit);
  LRESULT                     DefDlgProcA(                        HWND hDlg, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  LRESULT                     DefDlgProcW(                        HWND hDlg, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  INT_PTR                     DialogBoxIndirectParamA(            HINSTANCE hInstance, LPCDLGTEMPLATE hDialogTemplate, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM dwInitParam);
  INT_PTR                     DialogBoxIndirectParamW(            HINSTANCE hInstance, LPCDLGTEMPLATE hDialogTemplate, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM dwInitParam);
  INT_PTR                     DialogBoxParamA(                    HINSTANCE hInstance, LPCSTR lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM dwInitParam);
  INT_PTR                     DialogBoxParamW(                    HINSTANCE hInstance, LPCWSTR lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM dwInitParam);
  BOOL                        EndDialog(                          HWND hDlg, INT_PTR nResult);
  LONG                        GetDialogBaseUnits(                 );
  int                         GetDlgCtrlID(                       HWND hwndCtl);
  HWND                        GetDlgItem(                         HWND hDlg, int nIDDlgItem);
  UINT                        GetDlgItemInt(                      HWND hDlg, int nIDDlgItem, BOOL* lpTranslated, BOOL bSigned);
  UINT                        GetDlgItemTextA(                    HWND hDlg, int nIDDlgItem, LPSTR lpString, int nMaxCount);
  UINT                        GetDlgItemTextW(                    HWND hDlg, int nIDDlgItem, LPWSTR lpString, int nMaxCount);
  HWND                        GetNextDlgGroupItem(                HWND hDlg, HWND hCtl, BOOL bPrevious);
  HWND                        GetNextDlgTabItem(                  HWND hDlg, HWND hCtl, BOOL bPrevious);
  BOOL                        IsDialogMessage(                    HWND hDlg, LPMSG lpMsg);
  BOOL                        MapDialogRect(                      HWND hDlg, LPRECT lpRect);
  WINAPI_MessageBoxResult     MessageBoxA(                        HWND hWnd, LPCSTR lpText, LPCSTR lpCaption, WINAPI_MessageBoxType uType);
  WINAPI_MessageBoxResult     MessageBoxW(                        HWND hWnd, LPCWSTR lpText, LPCWSTR lpCaption, WINAPI_MessageBoxType uType);
  WINAPI_MessageBoxResult     MessageBoxExA(                      HWND hWnd, LPCSTR lpText, LPCSTR lpCaption, WINAPI_MessageBoxType uType, WORD wLanguageId);
  WINAPI_MessageBoxResult     MessageBoxExW(                      HWND hWnd, LPCWSTR lpText, LPCWSTR lpCaption, WINAPI_MessageBoxType uType, WORD wLanguageId);
  int                         MessageBoxIndirectA(                const LPMSGBOXPARAMSA lpMsgBoxParams);
  int                         MessageBoxIndirectW(                const LPMSGBOXPARAMSW lpMsgBoxParams);
  WINAPI_MessageBoxResult     MessageBoxTimeoutA(                 HWND hWnd, LPCSTR lpText, LPCSTR lpCaption, WINAPI_MessageBoxType uType, WORD wLanguageId, WINAPI_WaitTimeout dwMilliseconds);
  WINAPI_MessageBoxResult     MessageBoxTimeoutW(                 HWND hWnd, LPCWSTR lpText, LPCWSTR lpCaption, WINAPI_MessageBoxType uType, WORD wLanguageId, WINAPI_WaitTimeout dwMilliseconds);
  LRESULT                     SendDlgItemMessageA(                HWND hDlg, int nIDDlgItem, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  LRESULT                     SendDlgItemMessageW(                HWND hDlg, int nIDDlgItem, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  BOOL                        SetDlgItemInt(                      HWND hDlg, int nIDDlgItem, UINT uValue, BOOL bSigned);
  BOOL                        SetDlgItemTextA(                    HWND hDlg, int nIDDlgItem, LPCSTR lpString);
  BOOL                        SetDlgItemTextW(                    HWND hDlg, int nIDDlgItem, LPCWSTR lpString);
  long                        BroadcastSystemMessage(             DWORD dwFlags, LPDWORD lpdwRecipients, UINT uiMessage, WPARAM wParam, LPARAM lParam);
  long                        BroadcastSystemMessageExA(          DWORD dwFlags, LPDWORD lpdwRecipients, UINT uiMessage, WPARAM wParam, LPARAM lParam, PBSMINFO pBSMInfo);
  long                        BroadcastSystemMessageExW(          DWORD dwFlags, LPDWORD lpdwRecipients, UINT uiMessage, WPARAM wParam, LPARAM lParam, PBSMINFO pBSMInfo);
  LRESULT                     DispatchMessageA(                   const MSG* lpmsg);
  LRESULT                     DispatchMessageW(                   const MSG* lpmsg);
  BOOL                        GetInputState(                      );
  BOOL                        GetMessageA(                        LPMSG lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax);
  BOOL                        GetMessageW(                        LPMSG lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax);
  LPARAM                      GetMessageExtraInfo(                );
  DWORD                       GetMessagePos(                      );
  LONG                        GetMessageTime(                     );
  DWORD                       GetQueueStatus(                     WINAPI_QueueStatusFlag flags);
  BOOL                        InSendMessage(                      );
  DWORD                       InSendMessageEx(                    LPVOID lpReserved);
  BOOL                        PeekMessageA(                       LPMSG lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax, WINAPI_PeekMessageFlag wRemoveMsg);
  BOOL                        PeekMessageW(                       LPMSG lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax, WINAPI_PeekMessageFlag wRemoveMsg);
  BOOL                        PostMessageA(                       HWND hWnd, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  BOOL                        PostMessageW(                       HWND hWnd, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  VOID                        PostQuitMessage(                    int nExitCode);
  BOOL                        PostThreadMessageA(                 DWORD idThread, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  BOOL                        PostThreadMessageW(                 DWORD idThread, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  UINT                        RegisterWindowMessageA(             LPCSTR lpString);
  UINT                        RegisterWindowMessageW(             LPCWSTR lpString);
  BOOL                        ReplyMessage(                       LRESULT lResult);
  LRESULT                     SendMessageA(                       HWND hWnd, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  LRESULT                     SendMessageW(                       HWND hWnd, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  BOOL                        SendMessageCallbackA(               HWND hWnd, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam, SENDASYNCPROC lpCallBack, ULONG_PTR dwData);
  BOOL                        SendMessageCallbackW(               HWND hWnd, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam, SENDASYNCPROC lpCallBack, ULONG_PTR dwData);
  LRESULT                     SendMessageTimeoutA(                HWND hWnd, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam, WINAPI_SendMessageTimeoutFlags fuFlags, UINT uTimeout, PDWORD_PTR lpdwResult);
  LRESULT                     SendMessageTimeoutW(                HWND hWnd, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam, WINAPI_SendMessageTimeoutFlags fuFlags, UINT uTimeout, PDWORD_PTR lpdwResult);
  BOOL                        SendNotifyMessageA(                 HWND hWnd, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  BOOL                        SendNotifyMessageW(                 HWND hWnd, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  LPARAM                      SetMessageExtraInfo(                LPARAM lParam);
  BOOL                        TranslateMessage(                   const MSG* lpMsg);
  BOOL                        WaitMessage(                        );
  DWORD                       GetGuiResources(                    WINAPI_ProcessHandle hProcess, DWORD uiFlags);
  BOOL                        AttachThreadInput(                  DWORD idAttach, DWORD idAttachTo, BOOL fAttach);
  DWORD                       WaitForInputIdle(                   WINAPI_ProcessHandle hProcess, WINAPI_WaitTimeout dwMilliseconds);
  BOOL                        IsWow64Message(                     );
  BOOL                        UserHandleGrantAccess(              HANDLE hUserHandle, HANDLE hJob, BOOL bGrant);
  BOOL                        AdjustWindowRect(                   LPRECT lpRect, WINAPI_WindowStyle dwStyle, BOOL bMenu);
  BOOL                        AdjustWindowRectEx(                 LPRECT lpRect, WINAPI_WindowStyle dwStyle, BOOL bMenu, WINAPI_WindowExStyle dwExStyle);
  VOID                        AllowActivateDetachQueuesSetFocus(  );
  BOOL                        AllowSetForegroundWindow(           DWORD dwProcessId);
  BOOL                        AnimateWindow(                      HWND hwnd, DWORD dwTime, WINAPI_AnimateWindowFlags dwFlags);
  BOOL                        AnyPopup(                           );
  UINT                        ArrangeIconicWindows(               HWND hWnd);
  HDWP                        BeginDeferWindowPos(                int nNumWindows);
  BOOL                        BringWindowToTop(                   HWND hWnd);
  BOOL                        CalculatePopupWindowPosition(       const POINT* anchorPoint, const SIZE* windowSize, WINAPI_TrackPopupMenuFlags flags, RECT* excludeRect, RECT* popupWindowPosition);
  WORD                        CascadeWindows(                     HWND hwndParent, UINT wHow, const RECT* lpRect, UINT cKids, const HWND* lpKids);
  BOOL                        ChangeWindowMessageFilter(          UINT message, WINAPI_WindowMessageFilterEnum dwFlag);
  BOOL                        ChangeWindowMessageFilterEx(        HWND hWnd, UINT message, DWORD action, PCHANGEFILTERSTRUCT pChangeFilterStruct);
  HWND                        ChildWindowFromPoint(               HWND hWndParent, POINT Point);
  HWND                        ChildWindowFromPointEx(             HWND hwndParent, POINT pt, UINT uFlags);
  BOOL                        CloseWindow(                        HWND hWnd);
  HWND                        CreateWindowA(                      LPCSTR lpClassName, LPCSTR lpWindowName, DWORD dwStyle, WINAPI_CreateWindow_CW x, WINAPI_CreateWindow_CW y, WINAPI_CreateWindow_CW nWidth, WINAPI_CreateWindow_CW nHeight, HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, LPVOID lpParam);
  HWND                        CreateWindowW(                      LPCWSTR lpClassName, LPCWSTR lpWindowName, DWORD dwStyle, WINAPI_CreateWindow_CW x, WINAPI_CreateWindow_CW y, WINAPI_CreateWindow_CW nWidth, WINAPI_CreateWindow_CW nHeight, HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, LPVOID lpParam);
  HWND                        CreateWindowExA(                    WINAPI_WindowExStyle dwExStyle, LPCSTR lpClassName, LPCSTR lpWindowName, WINAPI_WindowStyle dwStyle, WINAPI_CreateWindow_CW x, WINAPI_CreateWindow_CW y, WINAPI_CreateWindow_CW nWidth, WINAPI_CreateWindow_CW nHeight, HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, LPVOID lpParam);
  HWND                        CreateWindowExW(                    WINAPI_WindowExStyle dwExStyle, LPCWSTR lpClassName, LPCWSTR lpWindowName, WINAPI_WindowStyle dwStyle, WINAPI_CreateWindow_CW x, WINAPI_CreateWindow_CW y, WINAPI_CreateWindow_CW nWidth, WINAPI_CreateWindow_CW nHeight, HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, LPVOID lpParam);
  HDWP                        DeferWindowPos(                     HDWP hWinPosInfo, HWND hWnd, WINAPI_HwndInsertAfterEnum hWndInsertAfter, int x, int y, int cx, int cy, WINAPI_SetWindowPosFlags uFlags);
  BOOL                        DeregisterShellHookWindow(          HWND hWnd);
  BOOL                        DestroyWindow(                      HWND hWnd);
  BOOL                        EndDeferWindowPos(                  HDWP hWinPosInfo);
  BOOL                        EndTask(                            HWND hWnd, BOOL fShutDown, BOOL fForce);
  BOOL                        EnumChildWindows(                   HWND hWndParent, WNDENUMPROC lpEnumFunc, LPARAM lParam);
  BOOL                        EnumThreadWindows(                  DWORD dwThreadId, WNDENUMPROC lpfn, LPARAM lParam);
  BOOL                        EnumWindows(                        WNDENUMPROC lpEnumFunc, LPARAM lParam);
  HWND                        FindWindowA(                        LPCSTR lpClassName, LPCSTR lpWindowName);
  HWND                        FindWindowW(                        LPCWSTR lpClassName, LPCWSTR lpWindowName);
  HWND                        FindWindowExA(                      HWND hwndParent, HWND hwndChildAfter, LPCSTR lpszClass, LPCSTR lpszWindow);
  HWND                        FindWindowExW(                      HWND hwndParent, HWND hwndChildAfter, LPCWSTR lpszClass, LPCWSTR lpszWindow);
  BOOL                        GetAltTabInfoA(                     HWND hwnd, int iItem, PALTTABINFO pati, LPSTR pszItemText, UINT cchItemText);
  BOOL                        GetAltTabInfoW(                     HWND hwnd, int iItem, PALTTABINFO pati, LPWSTR pszItemText, UINT cchItemText);
  HWND                        GetAncestor(                        HWND hwnd, WINAPI_GetAncestorEnum gaFlags);
  BOOL                        GetClientRect(                      HWND hWnd, LPRECT lpRect);
  HWND                        GetDesktopWindow(                   );
  HWND                        GetForegroundWindow(                );
  BOOL                        GetGUIThreadInfo(                   DWORD idThread, LPGUITHREADINFO lpgui);
  HWND                        GetLastActivePopup(                 HWND hWnd);
  BOOL                        GetLayeredWindowAttributes(         HWND hwnd, COLORREF* pcrKey, BYTE* pbAlpha, WINAPI_LayeredWindowAttribute* pdwFlags);
  HWND                        GetParent(                          HWND hWnd);
  BOOL                        GetProcessDefaultLayout(            DWORD* pdwDefaultLayout);
  HWND                        GetShellWindow(                     );
  BOOL                        GetTitleBarInfo(                    HWND hwnd, PTITLEBARINFO pti);
  HWND                        GetTopWindow(                       HWND hWnd);
  HWND                        GetWindow(                          HWND hWnd, WINAPI_GetWindowEnum uCmd);
  BOOL                        GetWindowDisplayAffinity(           HWND hWnd, DWORD* dwAffinity);
  BOOL                        GetWindowInfo(                      HWND hwnd, PWINDOWINFO pwi);
  UINT                        GetWindowModuleFileNameA(           HWND hwnd, LPSTR lpszFileName, UINT cchFileNameMax);
  UINT                        GetWindowModuleFileNameW(           HWND hwnd, LPWSTR lpszFileName, UINT cchFileNameMax);
  BOOL                        GetWindowPlacement(                 HWND hWnd, WINDOWPLACEMENT* lpwndpl);
  BOOL                        GetWindowRect(                      HWND hWnd, LPRECT lpRect);
  int                         GetWindowTextA(                     HWND hWnd, LPSTR lpString, int nMaxCount);
  int                         GetWindowTextW(                     HWND hWnd, LPWSTR lpString, int nMaxCount);
  int                         GetWindowTextLengthA(               HWND hWnd);
  int                         GetWindowTextLengthW(               HWND hWnd);
  DWORD                       GetWindowThreadProcessId(           HWND hWnd, LPDWORD lpdwProcessId);
  int                         InternalGetWindowText(              HWND hWnd, LPWSTR lpString, int nMaxCount);
  BOOL                        IsChild(                            HWND hWndParent, HWND hWnd);
  BOOL                        IsGUIThread(                        BOOL bConvert);
  BOOL                        IsHungAppWindow(                    HWND hWnd);
  BOOL                        IsIconic(                           HWND hWnd);
  BOOL                        IsProcessDPIAware(                  );
  BOOL                        IsWindow(                           HWND hWnd);
  BOOL                        IsWindowUnicode(                    HWND hWnd);
  BOOL                        IsWindowVisible(                    HWND hWnd);
  BOOL                        IsZoomed(                           HWND hWnd);
  BOOL                        LockSetForegroundWindow(            WINAPI_LockSetForegroundWindowCode uLockCode);
  void                        LogicalToPhysicalPoint(             HWND hWnd, LPPOINT lpPoint);
  BOOL                        MoveWindow(                         HWND hWnd, int X, int Y, int nWidth, int nHeight, BOOL bRepaint);
  BOOL                        OpenIcon(                           HWND hWnd);
  void                        PhysicalToLogicalPoint(             HWND hWnd, LPPOINT lpPoint);
  HWND                        RealChildWindowFromPoint(           HWND hwndParent, POINT ptParentClientCoords);
  UINT                        RealGetWindowClassA(                HWND hwnd, LPSTR pszType, UINT cchType);
  UINT                        RealGetWindowClassW(                HWND hwnd, LPWSTR pszType, UINT cchType);
  BOOL                        RegisterShellHookWindow(            HWND hWnd);
  BOOL                        SetForegroundWindow(                HWND hWnd);
  BOOL                        SetLayeredWindowAttributes(         HWND hwnd, COLORREF crKey, BYTE bAlpha, WINAPI_LayeredWindowAttribute dwFlags);
  HWND                        SetParent(                          HWND hWndChild, HWND hWndNewParent);
  BOOL                        SetProcessDefaultLayout(            DWORD dwDefaultLayout);
  BOOL                        SetProcessDPIAware(                 );
  BOOL                        SetWindowDisplayAffinity(           HWND hWnd, DWORD dwAffinity);
  BOOL                        SetWindowPlacement(                 HWND hWnd, WINDOWPLACEMENT* lpwndpl);
  BOOL                        SetWindowPos(                       HWND hWnd, WINAPI_HwndInsertAfterEnum hWndInsertAfter, int X, int Y, int cx, int cy, WINAPI_SetWindowPosFlags uFlags);
  BOOL                        SetWindowTextA(                     HWND hWnd, LPCSTR lpString);
  BOOL                        SetWindowTextW(                     HWND hWnd, LPCWSTR lpString);
  BOOL                        ShowOwnedPopups(                    HWND hWnd, BOOL fShow);
  BOOL                        ShowWindow(                         HWND hWnd, WINAPI_ShowWindowCmd nCmdShow);
  BOOL                        ShowWindowAsync(                    HWND hWnd, int nCmdShow);
  BOOL                        SoundSentry(                        );
  VOID                        SwitchToThisWindow(                 HWND hWnd, BOOL fAltTab);
  WORD                        TileWindows(                        HWND hwndParent, UINT wHow, RECT* lpRect, UINT cKids, const HWND* lpKids);
  BOOL                        UpdateLayeredWindow(                HWND hwnd, HDC hdcDst, POINT* pptDst, SIZE* psize, HDC hdcSrc, POINT* pptSrc, COLORREF crKey, BLENDFUNCTION* pblend, WINAPI_UpdateLayeredWindowFlags dwFlags);
  BOOL                        UpdateLayeredWindowIndirect(        HWND hwnd, const UPDATELAYEREDWINDOWINFO* pULWInfo);
  HWND                        WindowFromPhysicalPoint(            POINT Point);
  HWND                        WindowFromPoint(                    POINT Point);
  BOOL                        ExitWindowsEx(                      WINAPI_ExitWindowsExFlags uFlags, WINAPI_ExitWindowsExReason dwReason);
  BOOL                        LockWorkStation(                    );
  BOOL                        ShutdownBlockReasonCreate(          HWND hWnd, LPCWSTR pwszReason);
  BOOL                        ShutdownBlockReasonDestroy(         HWND hWnd);
  BOOL                        ShutdownBlockReasonQuery(           HWND hWnd, LPWSTR pwszBuff, DWORD* pcchBuff);
  HBITMAP                     LoadBitmapA(                        HINSTANCE hInstance, WINAPI_LoadBitmapString_LPCTSTR lpBitmapName);
  HBITMAP                     LoadBitmapW(                        HINSTANCE hInstance, WINAPI_LoadBitmapString_LPCTSTR lpBitmapName);
  HBRUSH                      GetSysColorBrush(                   WINAPI_SysColorIndex nIndex);
  BOOL                        CheckDlgButton(                     HWND hDlg, int nIDButton, WINAPI_ButtonState uCheck);
  BOOL                        CheckRadioButton(                   HWND hDlg, int nIDFirstButton, int nIDLastButton, int nIDCheckButton);
  UINT                        IsDlgButtonChecked(                 HWND hDlg, int nIDButton);
  BOOL                        CreateCaret(                        HWND hWnd, HBITMAP hBitmap, int nWidth, int nHeight);
  BOOL                        DestroyCaret(                       );
  UINT                        GetCaretBlinkTime(                  );
  BOOL                        GetCaretPos(                        LPPOINT lpPoint);
  BOOL                        HideCaret(                          HWND hWnd);
  BOOL                        SetCaretBlinkTime(                  UINT uMSeconds);
  BOOL                        SetCaretPos(                        int X, int Y);
  BOOL                        ShowCaret(                          HWND hWnd);
  BOOL                        AddClipboardFormatListener(         HWND hwnd);
  BOOL                        ChangeClipboardChain(               HWND hWndRemove, HWND hWndNewNext);
  BOOL                        CloseClipboard(                     );
  int                         CountClipboardFormats(              );
  BOOL                        EmptyClipboard(                     );
  UINT                        EnumClipboardFormats(               UINT format);
  HANDLE                      GetClipboardData(                   WINAPI_ClipboardFormat uFormat);
  int                         GetClipboardFormatNameA(            UINT format, LPSTR lpszFormatName, int cchMaxCount);
  int                         GetClipboardFormatNameW(            UINT format, LPWSTR lpszFormatName, int cchMaxCount);
  HWND                        GetClipboardOwner(                  );
  DWORD                       GetClipboardSequenceNumber(         );
  HWND                        GetClipboardViewer(                 );
  HWND                        GetOpenClipboardWindow(             );
  int                         GetPriorityClipboardFormat(         UINT* paFormatPriorityList, int cFormats);
  BOOL                        GetUpdatedClipboardFormats(         PUINT lpuiFormats, UINT cFormats, PUINT pcFormatsOut);
  BOOL                        IsClipboardFormatAvailable(         WINAPI_ClipboardFormat format);
  BOOL                        OpenClipboard(                      HWND hWndNewOwner);
  UINT                        RegisterClipboardFormatA(           LPCSTR lpszFormat);
  UINT                        RegisterClipboardFormatW(           LPCWSTR lpszFormat);
  BOOL                        RemoveClipboardFormatListener(      HWND hwnd);
  HANDLE                      SetClipboardData(                   WINAPI_ClipboardFormat uFormat, HANDLE hMem);
  HWND                        SetClipboardViewer(                 HWND hWndNewViewer);
  int                         DlgDirListComboBoxA(                HWND hDlg, LPSTR lpPathSpec, int nIDComboBox, int nIDStaticPath, UINT uFiletype);
  int                         DlgDirListComboBoxW(                HWND hDlg, LPWSTR lpPathSpec, int nIDComboBox, int nIDStaticPath, UINT uFiletype);
  BOOL                        DlgDirSelectComboBoxExA(            HWND hDlg, LPSTR lpString, int nCount, int nIDComboBox);
  BOOL                        DlgDirSelectComboBoxExW(            HWND hDlg, LPWSTR lpString, int nCount, int nIDComboBox);
  BOOL                        GetComboBoxInfo(                    HWND hwndCombo, PCOMBOBOXINFO pcbi);
  BOOL                        ClientToScreen(                     HWND hWnd, LPPOINT lpPoint);
  int                         MapWindowPoints(                    HWND hWndFrom, HWND hWndTo, LPPOINT lpPoints, UINT cPoints);
  BOOL                        ScreenToClient(                     HWND hWnd, LPPOINT lpPoint);
  BOOL                        ClipCursor(                         const RECT* lpRect);
  HCURSOR                     CopyCursorA(                        HCURSOR pcur);
  HCURSOR                     CopyCursorW(                        HCURSOR pcur);
  HCURSOR                     CreateCursor(                       HINSTANCE hInst, int xHotSpot, int yHotSpot, int nWidth, int nHeight, const VOID* pvANDPlane, const VOID* pvXORPlane);
  BOOL                        DestroyCursor(                      HCURSOR hCursor);
  BOOL                        GetClipCursor(                      LPRECT lpRect);
  HCURSOR                     GetCursor(                          );
  BOOL                        GetCursorInfo(                      PCURSORINFO pci);
  BOOL                        GetCursorPos(                       LPPOINT lpPoint);
  BOOL                        GetPhysicalCursorPos(               LPPOINT lpPoint);
  HCURSOR                     LoadCursorA(                        HINSTANCE hInstance, WINAPI_LoadCursorString_LPCTSTR lpCursorName);
  HCURSOR                     LoadCursorW(                        HINSTANCE hInstance, WINAPI_LoadCursorString_LPCTSTR lpCursorName);
  HCURSOR                     LoadCursorFromFileA(                LPCSTR lpFileName);
  HCURSOR                     LoadCursorFromFileW(                LPCWSTR lpFileName);
  HCURSOR                     SetCursor(                          HCURSOR hCursor);
  BOOL                        SetCursorPos(                       int X, int Y);
  BOOL                        SetPhysicalCursorPos(               int X, int Y);
  BOOL                        SetSystemCursor(                    HCURSOR hcur, WINAPI_CursorId id);
  int                         ShowCursor(                         BOOL bShow);
  LONG                        ChangeDisplaySettingsA(             DEVMODEA* lpDevMode, DWORD dwflags);
  LONG                        ChangeDisplaySettingsW(             DEVMODEW* lpDevMode, DWORD dwflags);
  LONG                        ChangeDisplaySettingsExA(           LPCSTR lpszDeviceName, DEVMODEA* lpDevMode, HWND hwnd, DWORD dwflags, LPVOID lParam);
  LONG                        ChangeDisplaySettingsExW(           LPCWSTR lpszDeviceName, DEVMODEW* lpDevMode, HWND hwnd, DWORD dwflags, LPVOID lParam);
  BOOL                        EnumDisplayDevicesA(                LPCSTR lpDevice, DWORD iDevNum, PDISPLAY_DEVICEA lpDisplayDevice, WINAPI_EnumDisplayDevicesFlags dwFlags);
  BOOL                        EnumDisplayDevicesW(                LPCWSTR lpDevice, DWORD iDevNum, PDISPLAY_DEVICEW lpDisplayDevice, WINAPI_EnumDisplayDevicesFlags dwFlags);
  BOOL                        EnumDisplaySettingsA(               LPCSTR lpszDeviceName, WINAPI_EnumDisplaySettingsEnum iModeNum, DEVMODEA* lpDevMode);
  BOOL                        EnumDisplaySettingsW(               LPCWSTR lpszDeviceName, WINAPI_EnumDisplaySettingsEnum iModeNum, DEVMODEW* lpDevMode);
  BOOL                        EnumDisplaySettingsExA(             LPCSTR lpszDeviceName, DWORD iModeNum, DEVMODEA* lpDevMode, DWORD dwFlags);
  BOOL                        EnumDisplaySettingsExW(             LPCWSTR lpszDeviceName, DWORD iModeNum, DEVMODEW* lpDevMode, DWORD dwFlags);
  HDC                         GetDC(                              HWND hWnd);
  HDC                         GetDCEx(                            HWND hWnd, HRGN hrgnClip, WINAPI_DCExFlags flags);
  int                         ReleaseDC(                          HWND hWnd, HDC hDC);
  HDEVNOTIFY                  RegisterDeviceNotificationA(        HANDLE hRecipient, LPVOID NotificationFilter, WINAPI_DeviceNotificationFlags Flags);
  HDEVNOTIFY                  RegisterDeviceNotificationW(        HANDLE hRecipient, LPVOID NotificationFilter, WINAPI_DeviceNotificationFlags Flags);
  BOOL                        UnregisterDeviceNotification(       HDEVNOTIFY Handle);
  BOOL                        DdeSetQualityOfService(             HWND hwndClient, const SECURITY_QUALITY_OF_SERVICE* pqosNew, PSECURITY_QUALITY_OF_SERVICE pqosPrev);
  BOOL                        FreeDDElParam(                      UINT msg, LPARAM lParam);
  BOOL                        ImpersonateDdeClientWindow(         HWND hWndClient, HWND hWndServer);
  LPARAM                      PackDDElParam(                      UINT msg, UINT_PTR uiLo, UINT_PTR uiHi);
  LPARAM                      ReuseDDElParam(                     LPARAM lParam, UINT msgIn, UINT msgOut, UINT_PTR uiLo, UINT_PTR uiHi);
  BOOL                        UnpackDDElParam(                    UINT msg, LPARAM lParam, PUINT_PTR puiLo, PUINT_PTR puiHi);
  BOOL                        DdeAbandonTransaction(              DWORD idInst, HCONV hConv, DWORD idTransaction);
  LPBYTE                      DdeAccessData(                      HDDEDATA hData, LPDWORD pcbDataSize);
  HDDEDATA                    DdeAddData(                         HDDEDATA hData, LPBYTE pSrc, DWORD cb, DWORD cbOff);
  HDDEDATA                    DdeClientTransaction(               LPBYTE pData, DWORD cbData, HCONV hConv, HSZ hszItem, UINT wFmt, UINT wType, DWORD dwTimeout, LPDWORD pdwResult);
  int                         DdeCmpStringHandles(                HSZ hsz1, HSZ hsz2);
  HCONV                       DdeConnect(                         DWORD idInst, HSZ hszService, HSZ hszTopic, PCONVCONTEXT pCC);
  HCONVLIST                   DdeConnectList(                     DWORD idInst, HSZ hszService, HSZ hszTopic, HCONVLIST hConvList, PCONVCONTEXT pCC);
  HDDEDATA                    DdeCreateDataHandle(                DWORD idInst, LPBYTE pSrc, DWORD cb, DWORD cbOff, HSZ hszItem, UINT wFmt, UINT afCmd);
  HSZ                         DdeCreateStringHandleA(             DWORD idInst, LPSTR psz, int iCodePage);
  HSZ                         DdeCreateStringHandleW(             DWORD idInst, LPWSTR psz, int iCodePage);
  BOOL                        DdeDisconnect(                      HCONV hConv);
  BOOL                        DdeDisconnectList(                  HCONVLIST hConvList);
  BOOL                        DdeEnableCallback(                  DWORD idInst, HCONV hConv, UINT wCmd);
  BOOL                        DdeFreeDataHandle(                  HDDEDATA hData);
  BOOL                        DdeFreeStringHandle(                DWORD idInst, HSZ hsz);
  DWORD                       DdeGetData(                         HDDEDATA hData, LPBYTE pDst, DWORD cbMax, DWORD cbOff);
  UINT                        DdeGetLastError(                    DWORD idInst);
  BOOL                        DdeImpersonateClient(               HCONV hConv);
  UINT                        DdeInitializeA(                     LPDWORD pidInst, PFNCALLBACK pfnCallback, DWORD afCmd, DWORD ulRes);
  UINT                        DdeInitializeW(                     LPDWORD pidInst, PFNCALLBACK pfnCallback, DWORD afCmd, DWORD ulRes);
  BOOL                        DdeKeepStringHandle(                DWORD idInst, HSZ hsz);
  HDDEDATA                    DdeNameService(                     DWORD idInst, UINT hsz1, UINT hsz2, UINT afCmd);
  BOOL                        DdePostAdvise(                      DWORD idInst, HSZ hszTopic, HSZ hszItem);
  UINT                        DdeQueryConvInfo(                   HCONV hConv, DWORD idTransaction, PCONVINFO pConvInfo);
  HCONV                       DdeQueryNextServer(                 HCONVLIST hConvList, HCONV hConvPrev);
  DWORD                       DdeQueryStringA(                    DWORD idInst, HSZ hsz, LPSTR psz, DWORD cchMax, int iCodePage);
  DWORD                       DdeQueryStringW(                    DWORD idInst, HSZ hsz, LPWSTR psz, DWORD cchMax, int iCodePage);
  HCONV                       DdeReconnect(                       HCONV hConv);
  BOOL                        DdeSetUserHandle(                   HCONV hConv, DWORD id, DWORD_PTR hUser);
  BOOL                        DdeUnaccessData(                    HDDEDATA hData);
  BOOL                        DdeUninitialize(                    DWORD idInst);
  BOOL                        FlashWindow(                        HWND hWnd, BOOL bInvert);
  BOOL                        FlashWindowEx(                      PFLASHWINFO pfwi);
  BOOL                        MessageBeep(                        UINT uType);
  void                        SetLastErrorEx(                     WINAPI_ERROR_CODE dwErrCode, WINAPI_SET_LAST_ERROR_EX_TYPE dwType);
  int                         FillRect(                           HDC hDC, const RECT* lprc, HBRUSH hbr);
  int                         FrameRect(                          HDC hDC, const RECT* lprc, HBRUSH hbr);
  BOOL                        InvertRect(                         HDC hDC, const RECT* lprc);
  int                         DrawTextA(                          HDC hDC, LPCSTR lpchText, int nCount, LPRECT lpRect, WINAPI_DrawTextFlags uFormat);
  int                         DrawTextW(                          HDC hDC, LPCWSTR lpchText, int nCount, LPRECT lpRect, WINAPI_DrawTextFlags uFormat);
  int                         DrawTextExA(                        HDC hdc, LPSTR lpchText, int cchText, LPRECT lprc, WINAPI_DrawTextFlags dwDTFormat, LPDRAWTEXTPARAMS lpDTParams);
  int                         DrawTextExW(                        HDC hdc, LPWSTR lpchText, int cchText, LPRECT lprc, WINAPI_DrawTextFlags dwDTFormat, LPDRAWTEXTPARAMS lpDTParams);
  DWORD                       GetTabbedTextExtentA(               HDC hDC, LPCSTR lpString, int nCount, int nTabPositions, const LPINT lpnTabStopPositions);
  DWORD                       GetTabbedTextExtentW(               HDC hDC, LPCWSTR lpString, int nCount, int nTabPositions, const LPINT lpnTabStopPositions);
  LONG                        TabbedTextOutA(                     HDC hDC, int X, int Y, LPCSTR lpString, int nCount, int nTabPositions, const LPINT lpnTabStopPositions, int nTabOrigin);
  LONG                        TabbedTextOutW(                     HDC hDC, int X, int Y, LPCWSTR lpString, int nCount, int nTabPositions, const LPINT lpnTabStopPositions, int nTabOrigin);
  BOOL                        CallMsgFilter(                      LPMSG lpMsg, int nCode);
  LRESULT                     CallNextHookEx(                     HHOOK hhk, int nCode, WPARAM wParam, LPARAM lParam);
  HHOOK                       SetWindowsHookExA(                  WINAPI_WindowsHook idHook, HOOKPROC lpfn, HINSTANCE hMod, DWORD dwThreadId);
  HHOOK                       SetWindowsHookExW(                  WINAPI_WindowsHook idHook, HOOKPROC lpfn, HINSTANCE hMod, DWORD dwThreadId);
  BOOL                        UnhookWindowsHookEx(                HHOOK hhk);
  HICON                       CopyIcon(                           HICON hIcon);
  HICON                       CreateIcon(                         HINSTANCE hInstance, int nWidth, int nHeight, BYTE cPlanes, BYTE cBitsPixel, const BYTE* lpbANDbits, const BYTE* lpbXORbits);
  HICON                       CreateIconFromResource(             PBYTE presbits, DWORD dwResSize, BOOL fIcon, DWORD dwVer);
  HICON                       CreateIconFromResourceEx(           PBYTE pbIconBits, DWORD cbIconBits, BOOL fIcon, DWORD dwVersion, int cxDesired, int cyDesired, UINT uFlags);
  HICON                       CreateIconIndirect(                 PICONINFO piconinfo);
  BOOL                        DestroyIcon(                        HICON hIcon);
  BOOL                        DrawIcon(                           HDC hDC, int X, int Y, HICON hIcon);
  BOOL                        DrawIconEx(                         HDC hdc, int xLeft, int yTop, HICON hIcon, int cxWidth, int cyWidth, UINT istepIfAniCur, HBRUSH hbrFlickerFreeDraw, WINAPI_DrawIconFlags diFlags);
  BOOL                        GetIconInfo(                        HICON hIcon, PICONINFO piconinfo);
  BOOL                        GetIconInfoExA(                     HICON hIcon, PICONINFOEXA piconinfoex);
  BOOL                        GetIconInfoExW(                     HICON hIcon, PICONINFOEXW piconinfoex);
  HICON                       LoadIconA(                          HINSTANCE hInstance, WINAPI_LoadIconString_LPCTSTR lpIconName);
  HICON                       LoadIconW(                          HINSTANCE hInstance, WINAPI_LoadIconString_LPCTSTR lpIconName);
  int                         LookupIconIdFromDirectory(          PBYTE presbits, BOOL fIcon);
  int                         LookupIconIdFromDirectoryEx(        PBYTE presbits, BOOL fIcon, int cxDesired, int cyDesired, WINAPI_LRFlags Flags);
  UINT                        PrivateExtractIconsA(               LPCSTR lpszFile, int nIconIndex, int cxIcon, int cyIcon, HICON* phicon, UINT* piconid, UINT nIcons, WINAPI_LRFlags flags);
  UINT                        PrivateExtractIconsW(               LPCWSTR lpszFile, int nIconIndex, int cxIcon, int cyIcon, HICON* phicon, UINT* piconid, UINT nIcons, WINAPI_LRFlags flags);
  int                         CopyAcceleratorTableA(              HACCEL hAccelSrc, LPACCEL lpAccelDst, int cAccelEntries);
  int                         CopyAcceleratorTableW(              HACCEL hAccelSrc, LPACCEL lpAccelDst, int cAccelEntries);
  HACCEL                      CreateAcceleratorTableA(            LPACCEL lpaccl, int cEntries);
  HACCEL                      CreateAcceleratorTableW(            LPACCEL lpaccl, int cEntries);
  BOOL                        DestroyAcceleratorTable(            HACCEL hAccel);
  HACCEL                      LoadAcceleratorsA(                  HINSTANCE hInstance, LPCSTR lpTableName);
  HACCEL                      LoadAcceleratorsW(                  HINSTANCE hInstance, LPCWSTR lpTableName);
  int                         TranslateAccelerator(               HWND hWnd, HACCEL hAccTable, LPMSG lpMsg);
  HKL                         ActivateKeyboardLayout(             WINAPI_KeyboardLayoutHandle hkl, WINAPI_KeyboardLayoutFlags Flags);
  BOOL                        BlockInput(                         BOOL fBlockIt);
  BOOL                        EnableWindow(                       HWND hWnd, BOOL bEnable);
  HWND                        GetActiveWindow(                    );
  SHORT                       GetAsyncKeyState(                   WINAPI_VirtKeyCode vKey);
  HWND                        GetFocus(                           );
  UINT                        GetKBCodePage(                      );
  HKL                         GetKeyboardLayout(                  DWORD idThread);
  UINT                        GetKeyboardLayoutList(              int nBuff, HKL* lpList);
  BOOL                        GetKeyboardLayoutNameA(             LPSTR pwszKLID);
  BOOL                        GetKeyboardLayoutNameW(             LPWSTR pwszKLID);
  BOOL                        GetKeyboardState(                   PBYTE lpKeyState);
  int                         GetKeyNameTextA(                    LONG lParam, LPSTR lpString, int nSize);
  int                         GetKeyNameTextW(                    LONG lParam, LPWSTR lpString, int nSize);
  SHORT                       GetKeyState(                        WINAPI_VirtKeyCode nVirtKey);
  BOOL                        GetLastInputInfo(                   PLASTINPUTINFO plii);
  BOOL                        IsWindowEnabled(                    HWND hWnd);
  VOID                        keybd_event(                        BYTE bVk, BYTE bScan, DWORD dwFlags, ULONG_PTR dwExtraInfo);
  HKL                         LoadKeyboardLayoutA(                LPCSTR pwszKLID, WINAPI_KeyboardLayoutFlags Flags);
  HKL                         LoadKeyboardLayoutW(                LPCWSTR pwszKLID, WINAPI_KeyboardLayoutFlags Flags);
  UINT                        MapVirtualKeyA(                     UINT uCode, WINAPI_MapVirtualKeyType uMapType);
  UINT                        MapVirtualKeyW(                     UINT uCode, WINAPI_MapVirtualKeyType uMapType);
  UINT                        MapVirtualKeyExA(                   UINT uCode, WINAPI_MapVirtualKeyType uMapType, HKL dwhkl);
  UINT                        MapVirtualKeyExW(                   UINT uCode, WINAPI_MapVirtualKeyType uMapType, HKL dwhkl);
  DWORD                       OemKeyScan(                         WORD wOemChar);
  BOOL                        RegisterHotKey(                     HWND hWnd, int id, UINT fsModifiers, UINT vk);
  UINT                        SendInput(                          UINT nInputs, LPINPUT pInputs, int cbSize);
  HWND                        SetActiveWindow(                    HWND hWnd);
  HWND                        SetFocus(                           HWND hWnd);
  BOOL                        SetKeyboardState(                   LPBYTE lpKeyState);
  int                         ToAscii(                            UINT uVirtKey, UINT uScanCode, PBYTE lpKeyState, LPWORD lpChar, UINT uFlags);
  int                         ToAsciiEx(                          UINT uVirtKey, UINT uScanCode, PBYTE lpKeyState, LPWORD lpChar, UINT uFlags, HKL dwhkl);
  int                         ToUnicode(                          UINT wVirtKey, UINT wScanCode, const PBYTE lpKeyState, LPWSTR pwszBuff, int cchBuff, UINT wFlags);
  int                         ToUnicodeEx(                        UINT wVirtKey, UINT wScanCode, const PBYTE lpKeyState, LPWSTR pwszBuff, int cchBuff, UINT wFlags, HKL dwhkl);
  BOOL                        UnloadKeyboardLayout(               HKL hkl);
  BOOL                        UnregisterHotKey(                   HWND hWnd, int id);
  SHORT                       VkKeyScanA(                         CHAR ch);
  SHORT                       VkKeyScanW(                         WCHAR ch);
  SHORT                       VkKeyScanExA(                       CHAR ch, HKL dwhkl);
  SHORT                       VkKeyScanExW(                       WCHAR ch, HKL dwhkl);
  int                         DlgDirListA(                        HWND hDlg, LPSTR lpPathSpec, int nIDListBox, int nIDStaticPath, UINT uFileType);
  int                         DlgDirListW(                        HWND hDlg, LPWSTR lpPathSpec, int nIDListBox, int nIDStaticPath, UINT uFileType);
  BOOL                        DlgDirSelectExA(                    HWND hDlg, LPSTR lpString, int nCount, int nIDListBox);
  BOOL                        DlgDirSelectExW(                    HWND hDlg, LPWSTR lpString, int nCount, int nIDListBox);
  DWORD                       GetListBoxInfo(                     HWND hwnd);
  BOOL                        AppendMenuA(                        HMENU hMenu, UINT uFlags, UINT_PTR uIDNewItem, LPCSTR lpNewItem);
  BOOL                        AppendMenuW(                        HMENU hMenu, UINT uFlags, UINT_PTR uIDNewItem, LPCWSTR lpNewItem);
  DWORD                       CheckMenuItem(                      HMENU hmenu, UINT uIDCheckItem, WINAPI_CheckMenuItemFlag uCheck);
  BOOL                        CheckMenuRadioItem(                 HMENU hmenu, UINT idFirst, UINT idLast, UINT idCheck, WINAPI_MenuCommandPosFlag uFlags);
  HMENU                       CreateMenu(                         );
  HMENU                       CreatePopupMenu(                    );
  BOOL                        DeleteMenu(                         HMENU hMenu, UINT uPosition, WINAPI_MenuCommandPosFlag uFlags);
  BOOL                        DestroyMenu(                        HMENU hMenu);
  BOOL                        DrawMenuBar(                        HWND hWnd);
  WINAPI_EnableMenuItemResult EnableMenuItem(                     HMENU hMenu, UINT uIDEnableItem, WINAPI_EnableMenuItemFlag uEnable);
  BOOL                        EndMenu(                            );
  HMENU                       GetMenu(                            HWND hWnd);
  BOOL                        GetMenuBarInfo(                     HWND hwnd, WINAPI_ObjectIdEnum idObject, LONG idItem, PMENUBARINFO pmbi);
  LONG                        GetMenuCheckMarkDimensions(         );
  UINT                        GetMenuDefaultItem(                 HMENU hMenu, UINT fByPos, WINAPI_GetMenuDefaultItemFlags gmdiFlags);
  BOOL                        GetMenuInfo(                        HMENU hmenu, LPCMENUINFO lpcmi);
  int                         GetMenuItemCount(                   HMENU hMenu);
  UINT                        GetMenuItemID(                      HMENU hMenu, int nPos);
  BOOL                        GetMenuItemInfoA(                   HMENU hMenu, UINT uItem, BOOL fByPosition, LPMENUITEMINFOA lpmii);
  BOOL                        GetMenuItemInfoW(                   HMENU hMenu, UINT uItem, BOOL fByPosition, LPMENUITEMINFOW lpmii);
  BOOL                        GetMenuItemRect(                    HWND hWnd, HMENU hMenu, UINT uItem, LPRECT lprcItem);
  UINT                        GetMenuState(                       HMENU hMenu, UINT uId, WINAPI_MenuCommandPosFlag uFlags);
  int                         GetMenuStringA(                     HMENU hMenu, UINT uIDItem, LPSTR lpString, int nMaxCount, UINT uFlag);
  int                         GetMenuStringW(                     HMENU hMenu, UINT uIDItem, LPWSTR lpString, int nMaxCount, UINT uFlag);
  HMENU                       GetSubMenu(                         HMENU hMenu, int nPos);
  HMENU                       GetSystemMenu(                      HWND hWnd, BOOL bRevert);
  BOOL                        HiliteMenuItem(                     HWND hwnd, HMENU hmenu, UINT uItemHilite, UINT uHilite);
  BOOL                        InsertMenuA(                        HMENU hMenu, UINT uPosition, WINAPI_InsertMenuFlags uFlags, UINT_PTR uIDNewItem, LPCSTR lpNewItem);
  BOOL                        InsertMenuW(                        HMENU hMenu, UINT uPosition, WINAPI_InsertMenuFlags uFlags, UINT_PTR uIDNewItem, LPCWSTR lpNewItem);
  BOOL                        InsertMenuItemA(                    HMENU hMenu, UINT uItem, BOOL fByPosition, LPCMENUITEMINFOA lpmii);
  BOOL                        InsertMenuItemW(                    HMENU hMenu, UINT uItem, BOOL fByPosition, LPCMENUITEMINFOW lpmii);
  BOOL                        IsMenu(                             HMENU hMenu);
  HMENU                       LoadMenuA(                          HINSTANCE hInstance, LPCSTR lpMenuName);
  HMENU                       LoadMenuW(                          HINSTANCE hInstance, LPCWSTR lpMenuName);
  HMENU                       LoadMenuIndirectA(                  const PMENUTEMPLATE lpMenuTemplate);
  HMENU                       LoadMenuIndirectW(                  const PMENUTEMPLATE lpMenuTemplate);
  int                         MenuItemFromPoint(                  HWND hWnd, HMENU hMenu, POINT ptScreen);
  BOOL                        ModifyMenuA(                        HMENU hMnu, UINT uPosition, UINT uFlags, UINT_PTR uIDNewItem, LPCSTR lpNewItem);
  BOOL                        ModifyMenuW(                        HMENU hMnu, UINT uPosition, UINT uFlags, UINT_PTR uIDNewItem, LPCWSTR lpNewItem);
  BOOL                        RemoveMenu(                         HMENU hMenu, UINT uPosition, WINAPI_MenuCommandPosFlag uFlags);
  BOOL                        SetMenu(                            HWND hWnd, HMENU hMenu);
  BOOL                        SetMenuDefaultItem(                 HMENU hMenu, UINT uItem, UINT fByPos);
  BOOL                        SetMenuInfo(                        HMENU hmenu, LPCMENUINFO lpcmi);
  BOOL                        SetMenuItemBitmaps(                 HMENU hMenu, UINT uPosition, UINT uFlags, HBITMAP hBitmapUnchecked, HBITMAP hBitmapChecked);
  BOOL                        SetMenuItemInfoA(                   HMENU hMenu, UINT uItem, BOOL fByPosition, LPMENUITEMINFOA lpmii);
  BOOL                        SetMenuItemInfoW(                   HMENU hMenu, UINT uItem, BOOL fByPosition, LPMENUITEMINFOW lpmii);
  BOOL                        TrackPopupMenu(                     HMENU hMenu, WINAPI_TrackPopupMenuFlags uFlags, int x, int y, int nReserved, HWND hWnd, const RECT* prcRect);
  BOOL                        TrackPopupMenuEx(                   HMENU hmenu, WINAPI_TrackPopupMenuFlags fuFlags, int x, int y, HWND hwnd, LPTPMPARAMS lptpm);
  BOOL                        DragDetect(                         HWND hwnd, POINT pt);
  HWND                        GetCapture(                         );
  UINT                        GetDoubleClickTime(                 );
  int                         GetMouseMovePointsEx(               UINT cbSize, LPMOUSEMOVEPOINT lppt, LPMOUSEMOVEPOINT lpptBuf, int nBufPoints, DWORD resolution);
  VOID                        mouse_event(                        DWORD dwFlags, DWORD dx, DWORD dy, DWORD dwData, ULONG_PTR dwExtraInfo);
  BOOL                        ReleaseCapture(                     );
  HWND                        SetCapture(                         HWND hWnd);
  BOOL                        SetDoubleClickTime(                 UINT uInterval);
  BOOL                        SwapMouseButton(                    BOOL fSwap);
  BOOL                        TrackMouseEvent(                    LPTRACKMOUSEEVENT lpEventTrack);
  BOOL                        EnumDisplayMonitors(                HDC hdc, LPCRECT lprcClip, MONITORENUMPROC lpfnEnum, LPARAM dwData);
  BOOL                        GetMonitorInfoA(                    HMONITOR hMonitor, LPMONITORINFO lpmi);
  BOOL                        GetMonitorInfoW(                    HMONITOR hMonitor, LPMONITORINFO lpmi);
  HMONITOR                    MonitorFromPoint(                   POINT pt, WINAPI_MonitorFlags dwFlags);
  HMONITOR                    MonitorFromRect(                    LPCRECT lprc, WINAPI_MonitorFlags dwFlags);
  HMONITOR                    MonitorFromWindow(                  HWND hwnd, WINAPI_MonitorFlags dwFlags);
  HWND                        CreateMDIWindowA(                   LPCSTR lpClassName, LPCSTR lpWindowName, DWORD dwStyle, int X, int Y, int nWidth, int nHeight, HWND hWndParent, HINSTANCE hInstance, LPARAM lParam);
  HWND                        CreateMDIWindowW(                   LPCWSTR lpClassName, LPCWSTR lpWindowName, DWORD dwStyle, int X, int Y, int nWidth, int nHeight, HWND hWndParent, HINSTANCE hInstance, LPARAM lParam);
  LRESULT                     DefFrameProcA(                      HWND hWnd, HWND hWndMDIClient, UINT uMsg, WPARAM wParam, LPARAM lParam);
  LRESULT                     DefFrameProcW(                      HWND hWnd, HWND hWndMDIClient, UINT uMsg, WPARAM wParam, LPARAM lParam);
  LRESULT                     DefMDIChildProcA(                   HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);
  LRESULT                     DefMDIChildProcW(                   HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);
  BOOL                        TranslateMDISysAccel(               HWND hWndClient, LPMSG lpMsg);
  HDC                         BeginPaint(                         HWND hwnd, LPPAINTSTRUCT lpPaint);
  BOOL                        DrawAnimatedRects(                  HWND hwnd, int idAni, const RECT* lprcFrom, const RECT* lprcTo);
  BOOL                        DrawCaption(                        HWND hwnd, HDC hdc, LPCRECT lprc, UINT uFlags);
  BOOL                        DrawEdge(                           HDC hdc, LPRECT qrc, WINAPI_BorderEdge edge, WINAPI_BorderFlag grfFlags);
  BOOL                        DrawFocusRect(                      HDC hDC, const RECT* lprc);
  BOOL                        DrawFrameControl(                   HDC hdc, LPRECT lprc, UINT uType, UINT uState);
  BOOL                        DrawStateA(                         HDC hdc, HBRUSH hbr, DRAWSTATEPROC lpOutputFunc, LPARAM lData, WPARAM wData, int x, int y, int cx, int cy, WINAPI_DrawStateFlags fuFlags);
  BOOL                        DrawStateW(                         HDC hdc, HBRUSH hbr, DRAWSTATEPROC lpOutputFunc, LPARAM lData, WPARAM wData, int x, int y, int cx, int cy, WINAPI_DrawStateFlags fuFlags);
  BOOL                        EndPaint(                           HWND hWnd, const PAINTSTRUCT* lpPaint);
  WINAPI_WindowRegion         ExcludeUpdateRgn(                   HDC hDC, HWND hWnd);
  BOOL                        GetUpdateRect(                      HWND hWnd, LPRECT lpRect, BOOL bErase);
  WINAPI_WindowRegion         GetUpdateRgn(                       HWND hWnd, HRGN hRgn, BOOL bErase);
  HDC                         GetWindowDC(                        HWND hWnd);
  WINAPI_WindowRegion         GetWindowRgn(                       HWND hWnd, HRGN hRgn);
  WINAPI_WindowRegion         GetWindowRgnBox(                    HWND hWnd, LPRECT lprc);
  BOOL                        GrayStringA(                        HDC hDC, HBRUSH hBrush, GRAYSTRINGPROC lpOutputFunc, LPARAM lpData, int nCount, int X, int Y, int nWidth, int nHeight);
  BOOL                        GrayStringW(                        HDC hDC, HBRUSH hBrush, GRAYSTRINGPROC lpOutputFunc, LPARAM lpData, int nCount, int X, int Y, int nWidth, int nHeight);
  BOOL                        InvalidateRect(                     HWND hWnd, const RECT* lpRect, BOOL bErase);
  BOOL                        InvalidateRgn(                      HWND hWnd, HRGN hRgn, BOOL bErase);
  BOOL                        LockWindowUpdate(                   HWND hWndLock);
  BOOL                        PaintDesktop(                       HDC hdc);
  BOOL                        RedrawWindow(                       HWND hWnd, const RECT* lprcUpdate, HRGN hrgnUpdate, WINAPI_RedrawWindowFlags flags);
  int                         SetWindowRgn(                       HWND hWnd, HRGN hRgn, BOOL bRedraw);
  BOOL                        UpdateWindow(                       HWND hWnd);
  BOOL                        ValidateRect(                       HWND hWnd, const RECT* lpRect);
  BOOL                        ValidateRgn(                        HWND hWnd, HRGN hRgn);
  HWND                        WindowFromDC(                       HDC hDC);
  HPOWERNOTIFY                RegisterPowerSettingNotification(   HANDLE hRecipient, LPCGUID PowerSettingGuid, WINAPI_DeviceNotificationFlags Flags);
  BOOL                        UnregisterPowerSettingNotification( HPOWERNOTIFY Handle);
  BOOL                        PrintWindow(                        HWND hwnd, HDC hdcBlt, UINT nFlags);
  LRESULT                     DefRawInputProc(                    PRAWINPUT* paRawInput, INT nInput, UINT cbSizeHeader);
  UINT                        GetRawInputBuffer(                  PRAWINPUT pData, PUINT pcbSize, UINT cbSizeHeader);
  UINT                        GetRawInputData(                    HRAWINPUT hRawInput, UINT uiCommand, LPVOID pData, PUINT pcbSize, UINT cbSizeHeader);
  UINT                        GetRawInputDeviceInfoA(             HANDLE hDevice, UINT uiCommand, LPVOID pData, PUINT pcbSize);
  UINT                        GetRawInputDeviceInfoW(             HANDLE hDevice, UINT uiCommand, LPVOID pData, PUINT pcbSize);
  UINT                        GetRawInputDeviceList(              PRAWINPUTDEVICELIST pRawInputDeviceList, PUINT puiNumDevices, UINT cbSize);
  UINT                        GetRegisteredRawInputDevices(       PRAWINPUTDEVICE pRawInputDevices, PUINT puiNumDevices, UINT cbSize);
  BOOL                        RegisterRawInputDevices(            PCRAWINPUTDEVICE pRawInputDevices, UINT uiNumDevices, UINT cbSize);
  BOOL                        CopyRect(                           LPRECT lprcDst, const RECT* lprcSrc);
  BOOL                        EqualRect(                          const RECT* lprc1, const RECT* lprc2);
  BOOL                        InflateRect(                        LPRECT lprc, int dx, int dy);
  BOOL                        IntersectRect(                      LPRECT lprcDst, const RECT* lprcSrc1, const RECT* lprcSrc2);
  BOOL                        IsRectEmpty(                        const RECT* lprc);
  BOOL                        OffsetRect(                         LPRECT lprc, int dx, int dy);
  BOOL                        PtInRect(                           const RECT* lprc, POINT pt);
  BOOL                        SetRect(                            LPRECT lprc, int xLeft, int yTop, int xRight, int yBottom);
  BOOL                        SetRectEmpty(                       LPRECT lprc);
  BOOL                        SubtractRect(                       LPRECT lprcDst, const RECT* lprcSrc1, const RECT* lprcSrc2);
  BOOL                        UnionRect(                          LPRECT lprcDst, const RECT* lprcSrc1, const RECT* lprcSrc2);
  HANDLE                      CopyImage(                          HANDLE hImage, WINAPI_ImageType uType, int cxDesired, int cyDesired, WINAPI_LRFlags fuFlags);
  HANDLE                      LoadImageA(                         HINSTANCE hinst, WINAPI_LoadImageString_LPCTSTR lpszName, WINAPI_ImageType uType, int cxDesired, int cyDesired, WINAPI_LRFlags fuLoad);
  HANDLE                      LoadImageW(                         HINSTANCE hinst, WINAPI_LoadImageString_LPCTSTR lpszName, WINAPI_ImageType uType, int cxDesired, int cyDesired, WINAPI_LRFlags fuLoad);
  BOOL                        EnableScrollBar(                    HWND hWnd, UINT wSBflags, UINT wArrows);
  BOOL                        GetScrollBarInfo(                   HWND hwnd, WINAPI_ObjectIdEnum idObject, PSCROLLBARINFO psbi);
  BOOL                        GetScrollInfo(                      HWND hwnd, WINAPI_SBType fnBar, LPSCROLLINFO lpsi);
  int                         GetScrollPos(                       HWND hWnd, WINAPI_SBType nBar);
  BOOL                        GetScrollRange(                     HWND hWnd, WINAPI_SBType nBar, LPINT lpMinPos, LPINT lpMaxPos);
  BOOL                        ScrollDC(                           HDC hDC, int dx, int dy, const RECT* lprcScroll, const RECT* lprcClip, HRGN hrgnUpdate, LPRECT lprcUpdate);
  BOOL                        ScrollWindow(                       HWND hWnd, int XAmount, int YAmount, const RECT* lpRect, const RECT* lpClipRect);
  int                         ScrollWindowEx(                     HWND hWnd, int dx, int dy, const RECT* prcScroll, const RECT* prcClip, HRGN hrgnUpdate, LPRECT prcUpdate, WINAPI_ScrollWindowFlags flags);
  int                         SetScrollInfo(                      HWND hwnd, WINAPI_SBType fnBar, LPCSCROLLINFO lpsi, BOOL fRedraw);
  int                         SetScrollPos(                       HWND hWnd, WINAPI_SBType nBar, int nPos, BOOL bRedraw);
  BOOL                        SetScrollRange(                     HWND hWnd, WINAPI_SBType nBar, int nMinPos, int nMaxPos, BOOL bRedraw);
  BOOL                        ShowScrollBar(                      HWND hWnd, WINAPI_SBType wBar, BOOL bShow);
  LPSTR                       CharLowerA(                         LPSTR lpsz);
  LPWSTR                      CharLowerW(                         LPWSTR lpsz);
  DWORD                       CharLowerBuffA(                     LPSTR lpsz, DWORD cchLength);
  DWORD                       CharLowerBuffW(                     LPWSTR lpsz, DWORD cchLength);
  LPSTR                       CharNextA(                          LPCSTR lpsz);
  LPWSTR                      CharNextW(                          LPCWSTR lpsz);
  LPSTR                       CharNextExA(                        WINAPI_CodePageEnum CodePage, LPCSTR lpCurrentChar, DWORD dwFlags);
  LPSTR                       CharPrevA(                          LPCSTR lpszStart, LPCSTR lpszCurrent);
  LPWSTR                      CharPrevW(                          LPCWSTR lpszStart, LPCWSTR lpszCurrent);
  LPSTR                       CharPrevExA(                        WINAPI_CodePageEnum CodePage, LPCSTR lpStart, LPCSTR lpCurrentChar, DWORD dwFlags);
  BOOL                        CharToOemA(                         LPCSTR lpszSrc, LPSTR lpszDst);
  BOOL                        CharToOemW(                         LPCWSTR lpszSrc, LPSTR lpszDst);
  BOOL                        CharToOemBuffA(                     LPCSTR lpszSrc, LPSTR lpszDst, DWORD cchDstLength);
  BOOL                        CharToOemBuffW(                     LPCWSTR lpszSrc, LPSTR lpszDst, DWORD cchDstLength);
  LPSTR                       CharUpperA(                         LPSTR lpsz);
  LPWSTR                      CharUpperW(                         LPWSTR lpsz);
  DWORD                       CharUpperBuffA(                     LPSTR lpsz, DWORD cchLength);
  DWORD                       CharUpperBuffW(                     LPWSTR lpsz, DWORD cchLength);
  BOOL                        IsCharAlphaA(                       CHAR ch);
  BOOL                        IsCharAlphaW(                       WCHAR ch);
  BOOL                        IsCharAlphaNumericA(                CHAR ch);
  BOOL                        IsCharAlphaNumericW(                WCHAR ch);
  BOOL                        IsCharLowerA(                       CHAR ch);
  BOOL                        IsCharLowerW(                       WCHAR ch);
  BOOL                        IsCharUpperA(                       CHAR ch);
  BOOL                        IsCharUpperW(                       WCHAR ch);
  int                         LoadStringA(                        HINSTANCE hInstance, UINT uID, LPSTR lpBuffer, int nBufferMax);
  int                         LoadStringW(                        HINSTANCE hInstance, UINT uID, LPWSTR lpBuffer, int nBufferMax);
  BOOL                        OemToCharA(                         LPCSTR lpszSrc, LPSTR lpszDst);
  BOOL                        OemToCharW(                         LPCWSTR lpszSrc, LPWSTR lpszDst);
  BOOL                        OemToCharBuffA(                     LPCSTR lpszSrc, LPSTR lpszDst, DWORD cchDstLength);
  BOOL                        OemToCharBuffW(                     LPCWSTR lpszSrc, LPWSTR lpszDst, DWORD cchDstLength);
  int                         wsprintfA(                          LPSTR lpOut, LPCSTR lpFmt);
  int                         wsprintfW(                          LPWSTR lpOut, LPCWSTR lpFmt);
  int                         wvsprintfA(                         LPSTR lpOutput, LPCSTR lpFmt, va_list arglist);
  int                         wvsprintfW(                         LPWSTR lpOutput, LPCWSTR lpFmt, va_list arglist);
  WINAPI_WAIT_RESULT          MsgWaitForMultipleObjects(          DWORD nCount, const HANDLE* pHandles, BOOL bWaitAll, WINAPI_WaitTimeout dwMilliseconds, WINAPI_QueueStatusFlag dwWakeMask);
  WINAPI_WAIT_RESULT          MsgWaitForMultipleObjectsEx(        DWORD nCount, const HANDLE* pHandles, WINAPI_WaitTimeout dwMilliseconds, WINAPI_QueueStatusFlag dwWakeMask, WINAPI_MsgWaitForMultipleObjectsFlags dwFlags);
  int                         GetKeyboardType(                    int nTypeFlag);
  DWORD                       GetSysColor(                        WINAPI_SysColorIndex nIndex);
  int                         GetSystemMetrics(                   WINAPI_SystemMetricIndex nIndex);
  BOOL                        SetSysColors(                       int cElements, const INT* lpaElements, const COLORREF* lpaRgbValues);
  BOOL                        SystemParametersInfoA(              WINAPI_SystemParametersInfoEnum uiAction, UINT uiParam, PVOID pvParam, WINAPI_SystemParametersInfoFlags fWinIni);
  BOOL                        SystemParametersInfoW(              WINAPI_SystemParametersInfoEnum uiAction, UINT uiParam, PVOID pvParam, WINAPI_SystemParametersInfoFlags fWinIni);
  BOOL                        KillTimer(                          HWND hWnd, UINT_PTR uIDEvent);
  UINT_PTR                    SetTimer(                           HWND hWnd, UINT_PTR nIDEvent, UINT uElapse, TIMERPROC lpTimerFunc);
  BOOL                        GetClassInfoA(                      HINSTANCE hInstance, LPCSTR lpClassName, LPWNDCLASSA lpWndClass);
  BOOL                        GetClassInfoW(                      HINSTANCE hInstance, LPCWSTR lpClassName, LPWNDCLASSW lpWndClass);
  BOOL                        GetClassInfoExA(                    HINSTANCE hinst, LPCSTR lpszClass, LPWNDCLASSEXA lpwcx);
  BOOL                        GetClassInfoExW(                    HINSTANCE hinst, LPCWSTR lpszClass, LPWNDCLASSEXW lpwcx);
  DWORD                       GetClassLongA(                      HWND hWnd, WINAPI_ClassLongIndex nIndex);
  DWORD                       GetClassLongW(                      HWND hWnd, WINAPI_ClassLongIndex nIndex);
  int                         GetClassNameA(                      HWND hWnd, LPSTR lpClassName, int nMaxCount);
  int                         GetClassNameW(                      HWND hWnd, LPWSTR lpClassName, int nMaxCount);
  WORD                        GetClassWord(                       HWND hWnd, WINAPI_ClassLongIndex nIndex);
  LONG                        GetWindowLongA(                     HWND hWnd, WINAPI_WindowLongIndex nIndex);
  LONG                        GetWindowLongW(                     HWND hWnd, WINAPI_WindowLongIndex nIndex);
  ATOM                        RegisterClassA(                     const WNDCLASSA* lpWndClass);
  ATOM                        RegisterClassW(                     const WNDCLASSW* lpWndClass);
  ATOM                        RegisterClassExA(                   const WNDCLASSEXA* lpwcx);
  ATOM                        RegisterClassExW(                   const WNDCLASSEXW* lpwcx);
  DWORD                       SetClassLongA(                      HWND hWnd, WINAPI_ClassLongIndex nIndex, LONG dwNewLong);
  DWORD                       SetClassLongW(                      HWND hWnd, WINAPI_ClassLongIndex nIndex, LONG dwNewLong);
  WORD                        SetClassWord(                       HWND hWnd, WINAPI_ClassLongIndex nIndex, WORD wNewWord);
  LONG                        SetWindowLongA(                     HWND hWnd, WINAPI_WindowLongIndex nIndex, LONG dwNewLong);
  LONG                        SetWindowLongW(                     HWND hWnd, WINAPI_WindowLongIndex nIndex, LONG dwNewLong);
  BOOL                        UnregisterClassA(                   LPCSTR lpClassName, HINSTANCE hInstance);
  BOOL                        UnregisterClassW(                   LPCWSTR lpClassName, HINSTANCE hInstance);
  LRESULT                     CallWindowProcA(                    WNDPROC lpPrevWndFunc, HWND hWnd, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  LRESULT                     CallWindowProcW(                    WNDPROC lpPrevWndFunc, HWND hWnd, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  LRESULT                     DefWindowProcA(                     HWND hWnd, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  LRESULT                     DefWindowProcW(                     HWND hWnd, WINAPI_WinMsg Msg, WPARAM wParam, LPARAM lParam);
  int                         EnumPropsA(                         HWND hWnd, PROPENUMPROC lpEnumFunc);
  int                         EnumPropsW(                         HWND hWnd, PROPENUMPROC lpEnumFunc);
  int                         EnumPropsExA(                       HWND hWnd, PROPENUMPROCEX lpEnumFunc, LPARAM lParam);
  int                         EnumPropsExW(                       HWND hWnd, PROPENUMPROCEX lpEnumFunc, LPARAM lParam);
  HANDLE                      GetPropA(                           HWND hWnd, LPCSTR lpString);
  HANDLE                      GetPropW(                           HWND hWnd, LPCWSTR lpString);
  HANDLE                      RemovePropA(                        HWND hWnd, LPCSTR lpString);
  HANDLE                      RemovePropW(                        HWND hWnd, LPCWSTR lpString);
  BOOL                        SetPropA(                           HWND hWnd, LPCSTR lpString, HANDLE hData);
  BOOL                        SetPropW(                           HWND hWnd, LPCWSTR lpString, HANDLE hData);
  BOOL                        CloseWindowStation(                 HWINSTA hWinSta);
  HWINSTA                     CreateWindowStationA(               LPCSTR lpwinsta, WINAPI_CreateWindowStationFlags dwFlags, WINAPI_WindowStationAccessRights dwDesiredAccess, LPSECURITY_ATTRIBUTES lpsa);
  HWINSTA                     CreateWindowStationW(               LPCWSTR lpwinsta, WINAPI_CreateWindowStationFlags dwFlags, WINAPI_WindowStationAccessRights dwDesiredAccess, LPSECURITY_ATTRIBUTES lpsa);
  BOOL                        EnumWindowStationsA(                WINSTAENUMPROC lpEnumFunc, LPARAM lParam);
  BOOL                        EnumWindowStationsW(                WINSTAENUMPROC lpEnumFunc, LPARAM lParam);
  HWINSTA                     GetProcessWindowStation(            );
  BOOL                        GetUserObjectInformationA(          HANDLE hObj, WINAPI_UserObjectInformationEnum nIndex, PVOID pvInfo, DWORD nLength, LPDWORD lpnLengthNeeded);
  BOOL                        GetUserObjectInformationW(          HANDLE hObj, WINAPI_UserObjectInformationEnum nIndex, PVOID pvInfo, DWORD nLength, LPDWORD lpnLengthNeeded);
  HWINSTA                     OpenWindowStationA(                 LPSTR lpszWinSta, BOOL fInherit, WINAPI_WindowStationAccessRights dwDesiredAccess);
  HWINSTA                     OpenWindowStationW(                 LPWSTR lpszWinSta, BOOL fInherit, WINAPI_WindowStationAccessRights dwDesiredAccess);
  BOOL                        SetProcessWindowStation(            HWINSTA hWinSta);
  BOOL                        CloseDesktop(                       HDESK hDesktop);
  HDESK                       CreateDesktopA(                     LPCSTR lpszDesktop, LPCSTR lpszDevice, LPDEVMODEA pDevmode, WINAPI_DesktopFlags dwFlags, WINAPI_DESKTOP_ACCESS_MASK dwDesiredAccess, LPSECURITY_ATTRIBUTES lpsa);
  HDESK                       CreateDesktopW(                     LPCWSTR lpszDesktop, LPCWSTR lpszDevice, LPDEVMODEW pDevmode, WINAPI_DesktopFlags dwFlags, WINAPI_DESKTOP_ACCESS_MASK dwDesiredAccess, LPSECURITY_ATTRIBUTES lpsa);
  HDESK                       CreateDesktopExA(                   LPCSTR lpszDesktop, LPCSTR lpszDevice, LPDEVMODEA pDevmode, WINAPI_DesktopFlags dwFlags, WINAPI_DESKTOP_ACCESS_MASK dwDesiredAccess, LPSECURITY_ATTRIBUTES lpsa, ULONG ulHeapSize, PVOID pvoid);
  HDESK                       CreateDesktopExW(                   LPCWSTR lpszDesktop, LPCWSTR lpszDevice, LPDEVMODEW pDevmode, WINAPI_DesktopFlags dwFlags, WINAPI_DESKTOP_ACCESS_MASK dwDesiredAccess, LPSECURITY_ATTRIBUTES lpsa, ULONG ulHeapSize, PVOID pvoid);
  BOOL                        EnumDesktopsA(                      HWINSTA hwinsta, DESKTOPENUMPROC lpEnumFunc, LPARAM lParam);
  BOOL                        EnumDesktopsW(                      HWINSTA hwinsta, DESKTOPENUMPROC lpEnumFunc, LPARAM lParam);
  BOOL                        EnumDesktopWindows(                 HDESK hDesktop, WNDENUMPROC lpfn, LPARAM lParam);
  HDESK                       GetThreadDesktop(                   DWORD dwThreadId);
  HDESK                       OpenDesktopA(                       LPSTR lpszDesktop, WINAPI_DesktopFlags dwFlags, BOOL fInherit, WINAPI_DESKTOP_ACCESS_MASK dwDesiredAccess);
  HDESK                       OpenDesktopW(                       LPWSTR lpszDesktop, WINAPI_DesktopFlags dwFlags, BOOL fInherit, WINAPI_DESKTOP_ACCESS_MASK dwDesiredAccess);
  HDESK                       OpenInputDesktop(                   WINAPI_DesktopFlags dwFlags, BOOL fInherit, WINAPI_DESKTOP_ACCESS_MASK dwDesiredAccess);
  BOOL                        SetThreadDesktop(                   HDESK hDesktop);
  BOOL                        SetUserObjectInformationA(          HANDLE hObj, WINAPI_UserObjectInformationEnum nIndex, PVOID pvInfo, DWORD nLength);
  BOOL                        SetUserObjectInformationW(          HANDLE hObj, WINAPI_UserObjectInformationEnum nIndex, PVOID pvInfo, DWORD nLength);
  BOOL                        SwitchDesktop(                      HDESK hDesktop);
  DWORD                       GetMenuContextHelpId(               HMENU hmenu);
  DWORD                       GetWindowContextHelpId(             HWND hwnd);
  BOOL                        SetMenuContextHelpId(               HMENU hmenu, DWORD dwContextHelpId);
  BOOL                        SetWindowContextHelpId(             HWND hwnd, DWORD dwContextHelpId);
  BOOL                        WinHelpA(                           HWND hWndMain, LPCSTR lpszHelp, UINT uCommand, ULONG_PTR dwData);
  BOOL                        WinHelpW(                           HWND hWndMain, LPCWSTR lpszHelp, UINT uCommand, ULONG_PTR dwData);
  BOOL                        GetUserObjectSecurity(              HANDLE hObj, PSECURITY_INFORMATION pSIRequested, PSECURITY_DESCRIPTOR pSD, DWORD nLength, LPDWORD lpnLengthNeeded);
  BOOL                        SetUserObjectSecurity(              HANDLE hObj, PSECURITY_INFORMATION pSIRequested, PSECURITY_DESCRIPTOR pSID);
  HWINEVENTHOOK               SetWinEventHook(                    UINT eventMin, UINT eventMax, HMODULE hmodWinEventProc, WINEVENTPROC lpfnWinEventProc, DWORD idProcess, DWORD idThread, WINAPI_WinEventFlags dwflags);
  BOOL                        UnhookWinEvent(                     HWINEVENTHOOK hWinEventHook);
  BOOL                        IsWinEventHookInstalled(            DWORD event);
  void                        NotifyWinEvent(                     DWORD event, HWND hwnd, WINAPI_ObjectIdEnum idObject, LONG idChild);
  BOOL                        CloseTouchInputHandle(              HTOUCHINPUT hTouchInput);
  BOOL                        GetTouchInputInfo(                  HTOUCHINPUT hTouchInput, UINT cInputs, PTOUCHINPUT pInputs, int cbSize);
  BOOL                        IsTouchWindow(                      HWND hWnd, PULONG pulFlags);
  BOOL                        RegisterTouchWindow(                HWND hWnd, ULONG ulFlags);
  BOOL                        UnregisterTouchWindow(              HWND hWnd);
  BOOL                        CloseGestureInfoHandle(             HGESTUREINFO hGestureInfo);
  BOOL                        GetGestureExtraArgs(                HGESTUREINFO hGestureInfo, UINT cbExtraArgs, PBYTE pExtraArgs);
  BOOL                        GetGestureInfo(                     HGESTUREINFO hGestureInfo, PGESTUREINFO pGestureInfo);
  BOOL                        GetGestureConfig(                   HWND hwnd, DWORD dwReserved, DWORD dwFlags, PUINT pcIDs, PGESTURECONFIG pGestureConfig, UINT cbSize);
  BOOL                        SetGestureConfig(                   HWND hwnd, DWORD dwReserved, UINT cIDs, PGESTURECONFIG pGestureConfig, UINT cbSize);
  BOOL                        DesktopHasWatermarkText(            );
  HWND                        FrostCrashedWindow(                 HWND hwndToReplace, HWND hwndErrorReportOwnerWnd);
  HWND                        GetSendMessageReceiver(             DWORD threadId);
  BOOL                        GetWindowCompositionAttribute(      HWND hwnd, WINCOMPATTRDATA* pAttrData);
  HWND                        GhostWindowFromHungWindow(          HWND hwndGhost);
  HWND                        HungWindowFromGhostWindow(          HWND hwndGhost);
  BOOL                        IsSETEnabled(                       );
  BOOL                        IsServerSideWindow(                 HWND hwnd);
  BOOL                        IsThreadDesktopComposited(          );
  BOOL                        IsWindowInDestroy(                  HWND hwnd);
  LPCWSTR                     MB_GetString(                       int strId);
  BOOL                        NtUserSetChildWindowNoActivate(     HWND hwndChild);
  BOOL                        QuerySendMessage(                   MSG* pMsg);
  BOOL                        SetWindowCompositionAttribute(      HWND hwnd, WINCOMPATTRDATA* pAttrData);
]]
return ffi.load( 'User32.dll' )
