unit DialogHook;

interface

uses
  Windows, Messages, SysUtils;

type
  HINSTANCE = THandle;

type
  CREATESTRUCT = record
    lpCreateParams: LPVOID;
    hInstance: HINSTANCE;
    hMenu: HMENU;
    hwndParent: HWND;
    cy: Integer;
    cx: Integer;
    y: Integer;
    x: Integer;
    style: LONG;
    lpszName: LPCTSTR;
    lpszClass: LPCTSTR;
    dwExStyle: DWORD;
  end;
  LPCREATESTRUCT = ^CREATESTRUCT;

  CBT_CREATEWND = record
    lpcs: LPCREATESTRUCT;
    hwndInsertAfter: HWND;
  end;
  LPCBT_CREATEWND = ^CBT_CREATEWND;
  LONG_PTR = ^LONG;

const
  GWLP_WNDPROC: Integer =  (-4);
  GWLP_HINSTANCE: Integer = (-6);
  GWLP_HWNDPARENT: Integer = (-8);
  GWLP_USERDATA: Integer = (-21);
  GWLP_ID: Integer = (-12);

function SetWindowLongPtr(wnd: HWND; nIndex: Integer; dwNewLong: LONG_PTR): LONG_PTR stdcall;
function GetWindowLongPtr(wnd: HWND; nIndex: Integer): LONG_PTR stdcall;

implementation

const
  PROP_OLD_WNDPROC_NAME = 'prop_old_wndproc';

var
  hHookHandle: HHOOK;

function SetWindowLongPtr; external 'user32.dll' name 'SetWindowLongW';
function GetWindowLongPtr; external 'user32.dll' name 'GetWindowLongW';

function HookWndProc(wnd: HWND; nMsg: UINT; wpara: WPARAM; lPara: LPARAM): LRESULT stdcall;
var
   oldWndProc: TFNWndProc;
   x, y, w, h: Integer;
   r1, r2: TRect;
   hParentWnd: HWND;
begin
   if wnd = 0 then begin
      Result := DefWindowProc(wnd, nMsg, wPara, lPara);
      Exit;
   end;

   oldWndProc := Pointer(GetProp(wnd, PROP_OLD_WNDPROC_NAME));
   if oldWndProc = nil then begin
      Result := DefWindowProc(wnd, nMsg, wPara, lPara);
      Exit;
   end;

   if nMsg = WM_NCDESTROY then begin
      SetWindowLongPtr(wnd, GWLP_WNDPROC, oldWndProc);
   end;

{
   if nMsg = WM_INITDIALOG then begin
      x := 0;
      y := 0;
   end;
}

	Result := CallWindowProc(oldWndProc, wnd, nMsg, wPara, lPara);

   if nMsg = WM_INITDIALOG then begin
      hParentWnd := GetParent(wnd);
      if hParentWnd = 0 then begin
         Exit;
      end;

      GetWindowRect(hParentWnd, r1);

      GetWindowRect(wnd, r2);

      x := r1.Left + ((r1.Right - r1.Left) div 2) - ((r2.Right - r2.Left) div 2);
      y := r1.Top + ((r1.Bottom - r1.Top) div 2) - ((r2.Bottom - r2.Top) div 2);

      w := r2.Right - r2.Left;
      h := r2.Bottom - r2.Top;
      MoveWindow(wnd, x, y, w, h, true);
   end;
end;

function CbtFilterHook(nCode: Integer; wPara: WPARAM; lPara: LPARAM): LRESULT stdcall;
var
   lpcs: LPCREATESTRUCT;
   wnd: HWND;
   oldWndProc: pointer;
begin
	if (nCode <> HCBT_CREATEWND) then begin
		Result := CallNextHookEx(hHookHandle, nCode, wPara, lPara);
      Exit;
   end;

   lpcs := LPCBT_CREATEWND(lPara)^.lpcs;
   wnd := HWND(wPara);

   if (lpcs.style and WS_CHILD) = WS_CHILD then begin
//        if (GetClassLong(wnd, GCL_STYLE) and CS_IME) = CS_IME then begin
//    		result := CallNextHookEx(hook_handle, nCode, wPara, lPara);
//            exit;
//        end;
      SetProp(wnd, PROP_OLD_WNDPROC_NAME, THandle(0));
   end
   else begin
      oldWndProc := SetWindowLongPtr(wnd, GWLP_WNDPROC, LONG_PTR(@HookWndProc));
      SetProp(wnd, PROP_OLD_WNDPROC_NAME, THandle(oldWndProc));
   end;

   Result := CallNextHookEx(hHookHandle, nCode, wPara, lPara);
end;

initialization
   hHookHandle := SetWindowsHookEx(WH_CBT, CbtFilterHook, 0, GetCurrentThreadId());

finalization
   UnhookWindowsHookEx(hHookHandle);

end.
