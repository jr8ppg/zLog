unit UMMTTY;

interface

uses
  Windows, ShellAPI, SysUtils, Forms;

var
   MSG_MMTTY: UINT = 0;
   MMTTY_ThreadId: UINT;
   MMTTY_Handle: UINT;
   MyHandle: UINT;

var
   MMTTYRunning: Boolean = False;
   MMTTYInitialized: Boolean = False;
   MMTTYBuffer: string = '';

const
   RXM_HANDLE = 0;
   RXM_REQHANDLE = 1;
   RXM_EXIT = 2;
   RXM_PTT = 3;
   RXM_CHAR = 4;
   RXM_WINPOS = 5;
   RXM_WIDTH = 6;
   RXM_REQPARA = 7;
   RXM_SETBAUD = 8;
   RXM_SETMARK = 9;
   RXM_SETSPACE = 10;
   RXM_SETSWITCH = 11;
   RXM_SETHAM = 12;
   RXM_SHOWSETUP = 13;
   RXM_SETVIEW = 14;
   RXM_SETSQLVL = 15;
   RXM_SHOW = 16;
   RXM_SETFIG = 17;
   RXM_SETRESO = 18;
   RXM_SETLPF = 19;
   RXM_SETTXDELAY = 20;
   RXM_UPDATECOM = 21;
   RXM_SUSPEND = 22;

const
   TXM_HANDLE = $8000;
   TXM_REQHANDLE = $8001;
   TXM_START = $8002;
   TXM_CHAR = $8003;
   TXM_PTTEVENT = $8004;
   TXM_WIDTH = $8005;
   TXM_BAUD = $8006;
   TXM_MARK = $8007;
   TXM_SPACE = $8008;
   TXM_SWITCH = $8009;
   TXM_VIEW = $800A;
   TXM_LEVEL = $800B;
   TXM_RESO = $800C;
   TXM_THREAD = $800D;

var
   MMTTY_TX: Boolean = False;

procedure InitializeMMTTY(_Handle : THandle);
procedure ExitMMTTY;
procedure mm_TX;
procedure mm_RX;
procedure mm_RX_after_tx;
procedure mm_SendStr(S : string; RX : Boolean);
procedure ProcessMMTTYMessage(Msg : TMsg; var Handled : Boolean);

implementation

procedure InitializeMMTTY(_Handle: THandle);
var
   strMmtty: string;
   si: STARTUPINFO;
   pi: PROCESS_INFORMATION;
   strCurDir: string;
begin
   if MMTTYRunning then begin
      Exit;
   end;

   GetStartupInfo(si);

   strCurDir := ExtractFilePath(Application.ExeName);
   strMmtty :=  strCurDir + 'mmtty.exe';
   if FileExists(strMmtty) = False then begin
      Application.MessageBox(PChar('MMTTY not exists' + #13#10 + strMmtty), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      Exit;
   end;

   if CreateProcess(nil, PChar(strMmtty + ' -r'), nil, nil, False, 0, nil, PChar(strCurDir), si, pi) = False then begin
      Application.MessageBox(PChar('can not execute MMTTY'), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      Exit;
   end;

   CloseHandle(pi.hProcess);

   MyHandle := _Handle;
   MSG_MMTTY := RegisterWindowMessage('MMTTY');
   MMTTYInitialized := True;
end;

procedure ExitMMTTY;
begin
   PostMessage(MMTTY_Handle, MSG_MMTTY, RXM_EXIT, 0);
   MMTTYRunning := False;
   MMTTYInitialized := False;
end;

procedure mm_TX;
begin
   PostMessage(MMTTY_Handle, MSG_MMTTY, RXM_PTT, 2);
end;

procedure mm_RX;
begin
   PostMessage(MMTTY_Handle, MSG_MMTTY, RXM_PTT, 0);
end;

procedure mm_RX_after_tx;
begin
   PostMessage(MMTTY_Handle, MSG_MMTTY, RXM_PTT, 1);
end;

procedure mm_SendStr(S: string; RX: Boolean);
var
   i: integer;
begin
   mm_TX;
   for i := 1 to length(S) do begin
      PostMessage(MMTTY_Handle, MSG_MMTTY, RXM_CHAR, ord(S[i]));
   end;

   if RX then begin
      mm_RX_after_tx;
   end;
end;

procedure ProcessMMTTYMessage(Msg: TMsg; var Handled: Boolean);

begin
   if Msg.message <> MSG_MMTTY then begin
      exit;
   end;

   case Msg.wParam of
      TXM_THREAD: begin
         MMTTY_ThreadId := Msg.lParam;
      end;

      TXM_HANDLE: begin
         MMTTY_Handle := Msg.lParam;
      end;

      TXM_START: begin
         PostMessage(MMTTY_Handle, MSG_MMTTY, RXM_HANDLE, MyHandle);
         MMTTYRunning := True;
      end;

      TXM_CHAR: begin
         MMTTYBuffer := MMTTYBuffer + Chr(Msg.lParam);
      end;

      TXM_PTTEVENT: begin
         case Msg.lParam of
            0:
               MMTTY_TX := False;
            1:
               MMTTY_TX := True;
         end;
      end;
   end;
end;

end.
