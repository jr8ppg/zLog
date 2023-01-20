unit UTTYConsole;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, UMMTTY, UzLogConst, UzLogGlobal, Console2, UzLogCW;

const ttyMMTTY = 0;
      ttyPSK31 = 1;

type
  TTTYConsole = class(TForm)
    Panel1: TPanel;
    CallsignList: TListBox;
    Splitter1: TSplitter;
    Timer1: TTimer;
    RXLog: TColorConsole2;
    MainMenu1: TMainMenu;
    mnConsole: TMenuItem;
    ClearRXlog1: TMenuItem;
    ClearTXlog1: TMenuItem;
    ClearCallsignlist1: TMenuItem;
    Cleareverything1: TMenuItem;
    mnStayOnTop: TMenuItem;
    TXLog: TMemo;
    procedure TXLogKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TXLogKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StayOnTopClick(Sender: TObject);
    procedure ClearRXlog1Click(Sender: TObject);
    procedure ClearTXlog1Click(Sender: TObject);
    procedure ClearCallsignlist1Click(Sender: TObject);
    procedure Cleareverything1Click(Sender: TObject);
    procedure CallsignListClick(Sender: TObject);
    procedure CallsignListDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    TTYMode : integer;
    TTYSendBuffer: string;
    TTYLineBuffer: string; // line buffer for rx data
    procedure SetTTYMode(i : integer);
    procedure RXChar(C: AnsiChar);
    procedure TXChar(C: AnsiChar);
    procedure SendStrNow(S: String);
    function Sending : boolean;
    { Public declarations }
  end;

implementation

uses Main, UOptions;

{$R *.DFM}

procedure TTTYConsole.SetTTYMode(i: integer);
begin
   if (i >= 2) or (i < 0) then
      TTYMode := 0
   else
      TTYMode := i;

   if TTYMode = 0 then
      Caption := 'RTTY Console';

   if TTYMode = 1 then
      Caption := 'PSK31 Console';
end;

procedure TTTYConsole.RXChar(C: AnsiChar);
var
   i, j: integer;
   S: string;
label
   xxxx;
begin
   if C in [AnsiChar(0) .. AnsiChar($09), AnsiChar($0B) .. AnsiChar($0C), AnsiChar($0E) .. AnsiChar($1F), AnsiChar($80) .. AnsiChar($FF)] then
      exit;

   RXLog.WriteChar(C);

   if (C = ' ') or (C = _CR) then begin
      i := pos('DE ', TTYLineBuffer);
      if i > 0 then begin
         S := TTYLineBuffer;
         Delete(S, 1, i - 1); // S = DE XX1XXX
         if length(S) > 5 then begin
            Delete(S, 1, 3);
            S := TrimLeft(S);
            i := pos(' ', S);
            if i > 0 then
               S := copy(S, 1, i - 1);
            if (length(S) >= 3) and (length(S) <= 15) then begin
               for j := 0 to CallsignList.Items.Count - 1 do begin
                  if CallsignList.Items[j] = S then
                     goto xxxx;
               end;
               CallsignList.Items.Add(S);
               // TTYLineBuffer := '';
            end;
         end;
      end;

   xxxx:
      i := pos('599', TTYLineBuffer);
      if i > 0 then begin
         S := TTYLineBuffer;
         Delete(S, 1, i + 2);
         S := TrimLeft(S);
         // Caption := Caption + '*' + S;
         if S <> '' then begin
            if CharInSet(S[1], [' ', '/', '-', '|']) then
               Delete(S, 1, 1);

            for i := 1 to length(S) do
               if CharInSet(S[i], ['-', '/']) then
                  S[i] := ' ';

            i := pos(' ', S);
            if i > 0 then
               S := copy(S, 1, i - 1);
            if length(S) > 0 then begin
               if MainForm.NumberEdit.Text <> S then begin
                  MainForm.NumberEdit.Text := S;
                  MainForm.NumberEdit.SelectAll;
               end;
               // TTYLineBuffer := '';
            end;
         end;
      end;
   end;

   if C = _CR then begin
      TTYLineBuffer := '';
   end
   else begin
      TTYLineBuffer := TTYLineBuffer + Char(C);
   end;
end;

procedure TTTYConsole.TXChar(C: AnsiChar);
begin
   // Clipboard.AsText := C;
   // TXLog.PasteFromClipboard;
   TXLog.Text := TXLog.Text + Char(C);
end;

procedure TTTYConsole.TXLogKeyPress(Sender: TObject; var Key: Char);
begin
   case TTYMode of
      ttyMMTTY: begin
         if Key = Chr($08) then begin
            if TTYSendBuffer = '' then begin
               if MMTTY_TX then
                  mm_SendStr('X', False);
               Key := 'X';
               exit;
            end
            else begin
               TTYSendBuffer := copy(TTYSendBuffer, 1, length(TTYSendBuffer) - 1);
               exit;
            end;
         end;

         if MMTTY_TX then
            UMMTTY.mm_SendStr(Key, False)
         else begin
            TTYSendBuffer := TTYSendBuffer + Key;
         end;
      end;

      ttyPSK31:
         exit;
   end;
end;

procedure TTTYConsole.SendStrNow(S: String);
begin
   case TTYMode of
      ttyMMTTY: begin
         UMMTTY.mm_SendStr(_CR + _LF + S + _CR + _LF, True);
         TXLog.Lines.Add(S);
      end;

      ttyPSK31:
         exit;
   end;
end;

procedure TTTYConsole.Timer1Timer(Sender: TObject);
var
   i: integer;
begin
   Timer1.Enabled := False;
   try
      case TTYMode of
         ttyMMTTY: begin
            if MMTTYBuffer = '' then
               exit;

            // RXLog.Text := RXLog.Text + MMTTYBuffer;
            for i := 1 to length(MMTTYBuffer) do
               RXChar(AnsiChar(MMTTYBuffer[i]));

            MMTTYBuffer := '';
         end;

         ttyPSK31:
            exit;
      end;
   finally
      Timer1.Enabled := True;
   end;
end;

procedure TTTYConsole.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   MainForm.DelTaskbar(Handle);
end;

procedure TTTYConsole.FormCreate(Sender: TObject);
begin
   RXLog.ClrScr;
   TTYSendBuffer := '';
   TTYLineBuffer := '';
   TTYMode := 0;
end;

procedure TTTYConsole.TXLogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case TTYMode of
      ttyMMTTY: begin
         case Key of
            VK_RIGHT, VK_LEFT, VK_UP, VK_DOWN, VK_DELETE:
               Key := 0;

            VK_RETURN: begin
               if MMTTY_TX then
                  UMMTTY.mm_SendStr(_CR + _LF, False)
               else begin
                  TTYSendBuffer := TTYSendBuffer + _CR + _LF;
               end;
            end;

            VK_F9: begin
               if MMTTY_TX then
                  mm_RX
               else begin
                  if TTYSendBuffer <> '' then begin
                     mm_SendStr(TTYSendBuffer, False);
                     TTYSendBuffer := '';
                  end
                  else
                     mm_TX;
               end;
            end;
         end;
      end;

      ttyPSK31: begin
      end;
   end;
end;

procedure TTTYConsole.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   i: integer;
   S: string;
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();

      VK_F1 .. VK_F8, VK_F11, VK_F12: begin
         i := Key - VK_F1 + 1;
         S := dmZLogGlobal.CWMessage(3, i);
         S := SetStrNoAbbrev(S, Main.CurrentQSO);
         SendStrNow(S);
      end;
   end;
end;

procedure TTTYConsole.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);
end;

procedure TTTYConsole.StayOnTopClick(Sender: TObject);
begin
   mnStayOnTop.Checked := not(mnStayOnTop.Checked);
   if mnStayOnTop.Checked then begin
      FormStyle := fsStayOnTop;
      mnStayOnTop.Checked := True;
   end
   else begin
      FormStyle := fsNormal;
      mnStayOnTop.Checked := False;
   end;
end;

procedure TTTYConsole.ClearRXlog1Click(Sender: TObject);
begin
   RXLog.ClrScr;
end;

procedure TTTYConsole.ClearTXlog1Click(Sender: TObject);
begin
   TXLog.Clear;
end;

procedure TTTYConsole.ClearCallsignlist1Click(Sender: TObject);
begin
   CallsignList.Clear;
end;

procedure TTTYConsole.Cleareverything1Click(Sender: TObject);
begin
   CallsignList.Clear;
   RXLog.ClrScr;
   TXLog.Clear;
end;

procedure TTTYConsole.CallsignListClick(Sender: TObject);
begin
   if CallsignList.ItemIndex >= 0 then begin
      MainForm.CallsignEdit.Text := CallsignList.Items[CallsignList.ItemIndex];
      MainForm.CallsignEdit.SelectAll;
   end;
end;

procedure TTTYConsole.CallsignListDblClick(Sender: TObject);
begin
   if CallsignList.ItemIndex >= 0 then begin
      MainForm.CallsignEdit.Text := CallsignList.Items[CallsignList.ItemIndex];
      MainForm.CallsignEdit.SelectAll;
      MainForm.CallsignEdit.SetFocus;
   end;
end;

function TTTYConsole.Sending: boolean;
begin
   Result := False;
   case TTYMode of
      ttyMMTTY: begin
         Result := MMTTY_TX;
      end;

      ttyPSK31:
         Result := False;
   end;
end;

end.
