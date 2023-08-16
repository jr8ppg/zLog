unit UMessageManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Generics.Collections,
  UzLogQSO, UzLogConst, UzLogCW, UzLogSound, UzLogOperatorInfo, Vcl.Grids;

const
  WM_MSGMAN_PLAYQUEUE = (WM_USER + 10);

type
  TPlayMessage = class(TObject)
    FCmd: Integer;
    FWParam: WPARAM;
    FLParam: LPARAM;
    FRigID: Integer;
    FMode: TMode;
    FText: string;
    FCallsign: string;
    FBank: Integer;
    FMsgNo: Integer;
    FVoiceNo: Integer;
  private
    function GetText(): string;
  public
    constructor Create();
    destructor Destroy(); override;
    property Text: string read GetText;
    procedure Assign(src: TPlayMessage);
  end;

  TformMessageManager = class(TForm)
    Memo1: TMemo;
    Timer2: TTimer;
    Label1: TLabel;
    PaintBox1: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormResize(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
  private
    { Private �錾 }
    FMessageQueue: TList<TPlayMessage>;
    FInProgress: Boolean;

    FWaveSound: array[1..maxmessage + 2] of TWaveSound;
    FCurrentOperator: TOperatorInfo;
    FCurrentVoice: Integer;
    FOnNotifyStarted: TNotifyEvent;
    FOnNotifyFinished: TPlayMessageFinishedProc;

    FSendText: string;
    FSendIndex: Integer;

    procedure WMPlayQueue( var Message: TMessage ); message WM_MSGMAN_PLAYQUEUE;
    procedure SendVoice(i: integer);
  public
    { Public �錾 }
    property InProgress: Boolean read FInProgress write FInProgress;
    procedure AddQue(nCmd: Integer; wp: WPARAM; lp: LPARAM); overload;
    procedure AddQue(nID: Integer; S: string; aQSO: TQSO); overload;
    procedure AddQue(nID: Integer; nVoiceNo: Integer); overload;
    procedure AddQue(msg: TPlayMessage); overload;
    procedure ContinueQue();
    procedure ClearQue();
    procedure ClearQue2();
    procedure StopCW();
    procedure ClearText();
    procedure SetSendingText(rigno: Integer; s: string);
    procedure ClearSendingText();
    procedure OneCharSentProc();

    // Voice
    procedure Init();
    procedure StopVoice();
    procedure SetOperator(op: TOperatorInfo);

    function IsPlaying(): Boolean;
    function IsIdle(): Boolean;

    property OnNotifyStarted: TNotifyEvent read FOnNotifyStarted write FOnNotifyStarted;
    property OnNotifyFinished: TPlayMessageFinishedProc read FOnNotifyFinished write FOnNotifyFinished;
  end;


implementation

{$R *.dfm}

uses
  Main, UzLogKeyer, UzLogGlobal;

procedure TformMessageManager.FormCreate(Sender: TObject);
var
   i: Integer;
begin
   FMessageQueue := TList<TPlayMessage>.Create();
   Memo1.Clear();

   FOnNotifyStarted := nil;
   FOnNotifyFinished := nil;
   FCurrentVoice := 0;
   FCurrentOperator := nil;
   FInProgress := False;

   for i := 1 to High(FWaveSound) do begin
      FWaveSound[i] := TWaveSound.Create();
   end;

   FSendText := '';
   FSendIndex := 0;
end;

procedure TformMessageManager.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);
end;

procedure TformMessageManager.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   MainForm.DelTaskbar(Handle);
end;

procedure TformMessageManager.FormDestroy(Sender: TObject);
var
   i: Integer;
begin
   FMessageQueue.Free();

   for i := 1 to High(FWaveSound) do begin
      FWaveSound[i].Free();
   end;
end;

procedure TformMessageManager.FormResize(Sender: TObject);
begin
//   Grid.ColWidths[0] := Grid.Width - 4;
//   Grid.RowHeights[0] := Grid.Height - 4;
end;

procedure TformMessageManager.AddQue(nCmd: Integer; wp: WPARAM; lp: LPARAM);
var
   msg: TPlayMessage;
begin
   msg := TPlayMessage.Create();
   msg.FCmd := nCmd;
   msg.FWParam := wp;
   msg.FLParam := lp;

   AddQue(msg);
end;

procedure TformMessageManager.AddQue(nID: Integer; S: string; aQSO: TQSO);
var
   msg: TPlayMessage;
   strCallsign: string;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('>>> Enter - TformMessageManager.AddQue(' + IntToStr(nID) + ',''' + S + ''');'));
   {$ENDIF}

   if Assigned(aQSO) then begin
      if aQSO.Mode = mCW then begin
         S := SetStr(S, aQSO);
      end;
      if aQSO.Mode = mRTTY then begin
         S := SetStrNoAbbrev(S, aQSO);
      end;
      strCallsign := aQSO.Callsign;
   end
   else begin
      //S := '';
      strCallsign := '';
   end;

   msg := TPlayMessage.Create();
   msg.FRigID := nID;
   msg.FMode := mCW;
   msg.FText := S;
   msg.FCallsign := strCallsign;

   AddQue(msg);

   {$IFDEF DEBUG}
   OutputDebugString(PChar('<<< Leave - TformMessageManager.AddQue();'));
   {$ENDIF}
end;

procedure TformMessageManager.AddQue(nID: Integer; nVoiceNo: Integer);
var
   msg: TPlayMessage;
begin

   msg := TPlayMessage.Create();
   msg.FMode := mSSB;
   msg.FVoiceNo := nVoiceNo;

   AddQue(msg);
end;

procedure TformMessageManager.AddQue(msg: TPlayMessage);
var
   i: Integer;
   m: TPlayMessage;
begin
   for i := 0 to FMessageQueue.Count - 1 do begin
      m := FMessageQueue[i];

      if (m <> nil) and
         (m.FCmd = msg.FCmd) and
         (m.FWParam = msg.FWParam) and
         (m.FLParam = msg.FLParam) and
         (m.FRigID = msg.FRigID) then begin
         Exit;
      end;
   end;

   // �����ɒǉ�
   FMessageQueue.Add(msg);

   // �\��
   Memo1.Lines.Add(msg.Text);

   // �������Ă��Ȃ���Α��M
//   if (dmZLogKeyer.IsPlaying = False) and (IsPlaying = False) then begin
//      PostMessage(Handle, WM_MSGMAN_PLAYQUEUE, 0, 0);
//   end;
end;

procedure TformMessageManager.ClearQue();
var
   i: Integer;
   msg: TPlayMessage;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('>>> Enter - TformMessageManager.ClearQue();'));
   {$ENDIF}
   StopCW();
   StopVoice();

   for i := 0 to FMessageQueue.Count - 1 do begin
      msg := FMessageQueue[i];
      msg.Free();
   end;
   FMessageQueue.Clear();
   Memo1.Clear();
   {$IFDEF DEBUG}
   OutputDebugString(PChar('<<< Leave - TformMessageManager.ClearQue();'));
   {$ENDIF}
end;

procedure TformMessageManager.ClearQue2();
var
   i: Integer;
   msg: TPlayMessage;
begin
   for i := 0 to FMessageQueue.Count - 1 do begin
      msg := FMessageQueue[i];
      msg.Free();
   end;
   FMessageQueue.Clear();
   Memo1.Clear();
end;

procedure TformMessageManager.StopCW();
begin
   if dmZLogKeyer.IsPlaying = False then begin
      Exit;
   end;

   dmZLogKeyer.ClrBuffer;
   dmZLogKeyer.PauseCW();
   if dmZLogKeyer.UseWinKeyer = True then begin
      dmZLogKeyer.WinKeyerClear();
   end;
end;

procedure TformMessageManager.WMPlayQueue( var Message: TMessage );
var
   msg: TPlayMessage;
   msg2: TPlayMessage;
   nID: Integer;
   function GetCallsign(): string;
   var
      callsign_atom: ATOM;
      dwResult: DWORD;
      szWindowText: array[0..255] of Char;
   begin
      ZeroMemory(@szWindowText, SizeOf(szWindowText));
      dwResult := SendMessage(MainForm.Handle, WM_ZLOG_SETCURRENTQSO, nID, 0);
      callsign_atom := LOWORD(dwResult);

      GlobalGetAtomName(callsign_atom, PChar(@szWindowText), SizeOf(szWindowText));
      GlobalDeleteAtom(callsign_atom);
      Result := StrPas(szWindowText);
   end;
begin
   // QUEUE������o��
   if FMessageQueue.Count = 0 then begin
      Exit;
   end;

   // �擪��MSG�����o��
   msg := FMessageQueue[0];
   if msg = nil then begin
      Exit;
   end;

   // �폜�\��
   FMessageQueue[0] := nil;

   msg2 := TPlayMessage.Create();
   msg2.Assign(msg);
   msg.Free();
   try
      {$IFDEF DEBUG}
      OutputDebugString(PChar('***' + msg2.Text + '***'));
      {$ENDIF}

      if msg2.FCmd = 0 then begin
         // TODO:���M����
         case msg2.FMode of
            mCW: begin
               if msg2.FRigID = 0 then begin
                  nID := MainForm.CurrentTX;
                  msg2.FCallsign := GetCallsign();
               end
               else if msg2.FRigID = 1 then begin
                  nID := MainForm.CurrentRX;
                  msg2.FCallsign := GetCallsign();
               end
               else begin
                  nID := msg2.FRigID - 10;
               end;

               zLogSendStr(nID, msg2.FText, msg2.FCallsign);
            end;

            mSSB, mFM, mAM: begin
               SendVoice(msg2.FVoiceNo);
            end;

            mRTTY: begin

            end;

            else begin
            end;
         end;

         FMessageQueue.Pack();

//         if FMessageQueue.Count > 0 then begin
//            FMessageQueue.Delete(0);
//         end;
      end
      else if msg2.FCmd = WM_ZLOG_AFTER_DELAY then begin
         Sleep(dmZLogGlobal.Settings._so2r_rigsw_after_delay);

         if Memo1.Lines.Count > 0 then begin
            Memo1.Lines.Delete(0);
         end;

         FMessageQueue.Pack();

//         if FMessageQueue.Count > 0 then begin
//            FMessageQueue.Delete(0);
//         end;

         ContinueQue();
      end
      else begin
         {$IFDEF DEBUG}
         OutputDebugString(PChar('@@@ Call = [' + msg2.Text + ']@@@'));
         {$ENDIF}

         SendMessage(MainForm.Handle, msg2.FCmd, msg2.FWParam, msg2.FLParam);

         if Memo1.Lines.Count > 0 then begin
            Memo1.Lines.Delete(0);
         end;

         FMessageQueue.Pack();

//         if FMessageQueue.Count > 0 then begin
//            FMessageQueue.Delete(0);
//         end;

         ContinueQue();
      end;
   finally
      msg2.Free();
   end;
end;

procedure TformMessageManager.ContinueQue();
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('>>> Enter - TformMessageManager.ContinueQue();'));
   {$ENDIF}

   // ��������Α��M
   if (dmZLogKeyer.IsPlaying = False) and (IsPlaying = False) and
      (FMessageQueue.Count > 0) then begin
      {$IFDEF DEBUG}
      OutputDebugString(PChar('@@@ Posted = [WM_MSGMAN_PLAYQUEUE]@@@'));
      {$ENDIF}
      PostMessage(Handle, WM_MSGMAN_PLAYQUEUE, 0, 0);
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('<<< Leave - TformMessageManager.ContinueQue();'));
   {$ENDIF}
end;

procedure TformMessageManager.ClearText();
begin
//   if FMessageQueue.Count > 0 then begin
//      FMessageQueue.Delete(0);
//   end;
   if Memo1.Lines.Count > 0 then begin
      Memo1.Lines.Delete(0);
   end;
end;

{ TPlayMessage }

constructor TPlayMessage.Create();
begin
   inherited;
   FCmd := 0;
   FRigID := 0;
   FMode := mCW;
   FText := '';
   FCallsign := '';
   FBank := 0;
   FMsgNo := 0;
   FVoiceNo := 0;
end;

destructor TPlayMessage.Destroy();
begin
   //
end;

// [TX#] [MODE] [MSG]
function TPlayMessage.GetText(): string;
var
   strCmdText: string;
begin
   if FCmd = 0 then begin
      case FMode of
         mCW, mRTTY: begin
            Result := '[' + IntToStr(FRigID + 1) + '] [' + ModeString[FMode] + '] ' + FText;
         end;

         mSSB, mFM, mAM: begin
            Result := '[' + IntToStr(FRigID + 1) + '] [' + ModeString[FMode] + '] Play Voice (' + IntToStr(FVoiceNo) + ')';
         end;

         else Result := 'Unknown Command';
      end;
   end
   else begin
      case FCmd of
         WM_ZLOG_CQREPEAT_CONTINUE: strCmdText := 'CQRepeat';
         WM_ZLOG_SWITCH_RIG:        strCmdText := 'SwitchRig';
         WM_ZLOG_RESET_TX:          strCmdText := 'ResetTx';
         WM_ZLOG_INVERT_TX:         strCmdText := 'InvertTx';
         WM_ZLOG_SWITCH_RX:         strCmdText := 'SwitchRx';
         WM_ZLOG_SWITCH_TXRX:       strCmdText := 'SwitchTxRx';
         WM_ZLOG_AFTER_DELAY:       strCmdText := 'AfterDelay';
//         WM_ZLOG_SET_LOOP_PAUSE:    strCmdText := 'SetLoopPause';
         WM_ZLOG_SET_CQ_LOOP:       strCmdText := 'SetCqLoop';
         WM_ZLOG_CALLSIGNSENT:      strCmdText := 'CallsignSent';
         WM_ZLOG_TABKEYPRESS:       strCmdText := 'TabKeyPress';
         WM_ZLOG_DOWNKEYPRESS:      strCmdText := 'DownKeyPress';
      end;

      Result := 'EXEC CMD [' + strCmdText + '][' + IntToStr(FWParam) + '][' + IntToStr(FLParam) + ']';
   end;
end;

procedure TPlayMessage.Assign(src: TPlayMessage);
begin
   FCmd := src.FCmd;
   FWParam := src.FWParam;
   FLParam := src.FLParam;
   FRigID := src.FRigID;
   FMode := src.FMode;
   FText := src.FText;
   FCallsign := src.FCallsign;
   FBank := src.FBank;
   FMsgNo := src.FMsgNo;
   FVoiceNo := src.FVoiceNo;
end;

procedure TformMessageManager.Init();
var
   i: Integer;
begin
   for i := 1 to High(FWaveSound) do begin
      FWaveSound[i].Close();
   end;
   FCurrentVoice := 0;
end;

procedure TformMessageManager.SendVoice(i: integer);
var
   filename: string;
begin
   if FCurrentOperator = nil then begin
      case i of
         1..12: begin
            filename := dmZLogGlobal.Settings.FSoundFiles[i];
         end;

         101: begin
            filename := dmZLogGlobal.Settings.FSoundFiles[1];
            i := 1;
         end;

         102: begin
            filename := dmZLogGlobal.Settings.FAdditionalSoundFiles[2];
            i := 13;
         end;

         103: begin
            filename := dmZLogGlobal.Settings.FAdditionalSoundFiles[3];
            i := 14;
         end;
      end;
   end
   else begin
      case i of
         1..12: begin
            filename := FCurrentOperator.VoiceFiles[i];
         end;

         101: begin
            filename := FCurrentOperator.VoiceFiles[1];
            i := 1;
         end;

         102: begin
            filename := FCurrentOperator.AdditionalVoiceFiles[2];
            i := 13;
         end;

         103: begin
            filename := FCurrentOperator.AdditionalVoiceFiles[3];
            i := 14;
         end;
      end;
   end;

   // �t�@�C�������󂩁A�t�@�C�����Ȃ���Ή������Ȃ�
   if (filename = '') or (FileExists(filename) = False) then begin
//      if Assigned(FOnNotifyStarted) then begin
//         FOnNotifyStarted(nil);
//      end;
      if Assigned(FOnNotifyFinished) then begin
         FOnNotifyFinished(nil, mSSB, False);
      end;
      Exit;
   end;

   // �O��Sound�ƕς������
   if FWaveSound[i].FileName <> filename then begin
      FWaveSound[i].Close();
   end;

   if FWaveSound[i].IsLoaded = False then begin
      FWaveSound[i].Open(filename, dmZLogGlobal.Settings.FSoundDevice);
   end;
   FWaveSound[i].Stop();

   if Assigned(FOnNotifyStarted) then begin
      FOnNotifyStarted(FWaveSound[i]);
   end;

   FCurrentVoice := i;
   FWaveSound[i].Play();

   Timer2.Enabled := True;
end;

procedure TformMessageManager.StopVoice();
begin
   Timer2.Enabled := False;
   if FCurrentVoice <> 0 then begin
      FWaveSound[FCurrentVoice].Stop();
   end;

   if Assigned(FOnNotifyFinished) then begin
      // Stop����Finish�C�x���g�͕s�v
      //FOnNotifyFinished(nil, mSSB, True);
   end;
end;

procedure TformMessageManager.GridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   S: string;
begin
   with TStringGrid(Sender).Canvas do begin
      Brush.Color := clBtnFace;
      Brush.Style := bsSolid;
      Pen.Color := clBtnFace;
      Pen.Style := psSolid;
      FillRect(Rect);
      Rectangle(Rect);

      if FSendText = '' then begin
         Exit;
      end;

      Font.Color := clBlack;
      TextRect(Rect, FSendText, [tfLeft, tfVerticalCenter, tfSingleLine]);

      if FSendIndex > 0 then begin
         S := Copy(FSendText, 1, FSendIndex);
         Brush.Color := clBlue;
         Brush.Style := bsSolid;
         Pen.Style := psClear;
         Font.Color := clWhite;
//         Font.style := Font.Style + [fsUnderline];
         TextRect(Rect, S, [tfLeft, tfVerticalCenter, tfSingleLine]);
      end;
   end;
end;

procedure TformMessageManager.SetOperator(op: TOperatorInfo);
begin
   FCurrentOperator := op;
   Init();
end;

function TformMessageManager.IsPlaying(): Boolean;
begin
   if FCurrentVoice = 0 then begin
      Result := False;
   end
   else begin
      Result := FWaveSound[FCurrentVoice].Playing;
   end;
end;

function TformMessageManager.IsIdle(): Boolean;
begin
   Result := FMessageQueue.Count = 0;
end;

// Voice�Đ��I���܂ő҂^�C�}�[
procedure TformMessageManager.Timer2Timer(Sender: TObject);
begin
   if IsPlaying() = True then begin
      Exit;
   end;
   Timer2.Enabled := False;

   if Assigned(FOnNotifyFinished) then begin
      FOnNotifyFinished(FWaveSound[FCurrentVoice], mSSB, False);
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('---Voice Play finished!! ---'));
   {$ENDIF}
end;

procedure TformMessageManager.SetSendingText(rigno: Integer; s: string);
begin
//   editSendingNow.Text := '[' + IntToStr(rigno) + ']' + s;
   FSendText := s;
   FSendIndex := 1;
   PaintBox1.Refresh();
end;

procedure TformMessageManager.ClearSendingText();
begin
   FSendText := '';
   FSendIndex := 1;
   PaintBox1.Refresh();
end;

procedure TformMessageManager.OneCharSentProc();
begin
   Inc(FSendIndex);
   PaintBox1.Refresh();
end;

procedure TformMessageManager.PaintBox1Paint(Sender: TObject);
var
   S: string;
   Rect: TRect;
begin
   with TPaintBox(Sender).Canvas do begin
      Rect.Top := 0;
      Rect.Bottom := TPaintBox(Sender).Height - 2;
      Rect.Left := 0;
      Rect.Right := TPaintBox(Sender).Width - 1;

      Brush.Color := clBtnFace;
      Brush.Style := bsSolid;
      Pen.Color := clGray;
      Pen.Style := psSolid;
      FillRect(Rect);
      Rectangle(Rect);

      if FSendText = '' then begin
         Exit;
      end;

      Rect.Left := 2;
      Rect.Right := Rect.Right - 2;
      Font.Color := clBlack;
      TextRect(Rect, FSendText, [tfLeft, tfVerticalCenter, tfSingleLine]);

      if FSendIndex > 0 then begin
         S := Copy(FSendText, 1, FSendIndex);
         Brush.Color := clBlue;
         Brush.Style := bsSolid;
         Pen.Style := psClear;
         Font.Color := clWhite;
//         Font.style := Font.Style + [fsUnderline];
         TextRect(Rect, S, [tfLeft, tfVerticalCenter, tfSingleLine]);
      end;
   end;
end;

end.
