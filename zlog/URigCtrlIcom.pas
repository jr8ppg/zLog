unit URigCtrlIcom;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, AnsiStrings,
  System.Math, System.StrUtils, System.SyncObjs, Generics.Collections,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  URigCtrlLib, UzLogConst, UzLogGlobal, UzLogQSO, CPDrv;

type
  TIcomCommThread = class;

  TICOM = class(TRig) // Icom CI-V
  protected
    procedure SetRit(flag: Boolean); override;
    procedure SetXit(flag: Boolean); override;
    procedure SetRitOffset(offset: Integer); override;
  private
    FMyAddr: Byte;
    FRigAddr: Byte;
    FUseTransceiveMode: Boolean;
    FGetBandAndMode: Boolean;
    FPollingCount: Integer;
    FInitialPolling: Boolean;

    FCommThread: TIcomCommThread;
    FCommandList: TList<AnsiString>;

    FMinWPM: Integer;      // 6
    FMaxWPM: Integer;      // 48

    FFreq4Bytes: Boolean;
  public
    constructor Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand); override;
    destructor Destroy; override;
    procedure AntSelect(no: Integer); override;
    procedure FixEdgeSelect(no: Integer); override;
    procedure ExecuteCommand(S : AnsiString); override;
    procedure ICOMWriteData(S : AnsiString);
    procedure Initialize(); override;
    procedure InquireStatus; override;
    procedure ParseBufferString; override;
    procedure PollingProcess; override;
    procedure Reset; override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
    procedure SetDataMode(fOn: Boolean); override;
    procedure SetVFO(i : integer); override;
    procedure StartPolling();
    procedure StopRequest(); override;

    procedure SetWPM(wpm: Integer); override;
    procedure PlayMessageCW(msg: string); override;
    procedure StopMessageCW(); override;
    procedure ControlPTT(fOn: Boolean); override;

    property UseTransceiveMode: Boolean read FUseTransceiveMode write FUseTransceiveMode;
    property GetBandAndModeFlag: Boolean read FGetBandAndMode write FGetBandAndMode;
    property MyAddr: Byte read FMyAddr write FMyAddr;
    property RigAddr: Byte read FRigAddr write FRigAddr;
    property Freq4Bytes: Boolean read FFreq4Bytes write FFreq4Bytes;
  end;

  TIcomCommThread = class(TThread)
  private
    FRig: TICOM;
    FResponse: AnsiString;
  protected
    procedure Execute(); override;
    function RecvText(var nErrorCode: Integer): AnsiString;
    procedure SyncProc();
  public
    constructor Create(rig: TICOM);
  end;

  TIC756 = class(TICOM)
    procedure Initialize(); override;
    procedure SetVFO(i : integer); override;
  end;

  TIC7851 = class(TICOM)
  public
    procedure AntSelect(no: Integer); override;
  end;

var
  IcomLock: TCriticalSection;

implementation

{ TICOM CI-V }

constructor TICOM.Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand);
begin
   Inherited;
   FPollingCount := 0;
   FInitialPolling := False;
   FUseTransceiveMode := True;
   FComm.StopBits := sb1BITS;
   FComm.HwFlow := hfNONE;
   FComm.SwFlow := sfNONE;
   FComm.EnableDTROnOpen := False;
   TerminatorCode := AnsiChar($FD);

   FMyAddr := $E0;
   FRigAddr := $01;

   FCommandList := TList<AnsiString>.Create();
   FCommThread := TIcomCommThread.Create(Self);

   FMinWPM := 6;
   FMaxWPM := 48;

   FFreq4Bytes := False;

   FControlPTTSupported := True;
end;

destructor TICOM.Destroy;
begin
   inherited;
   FCommThread.Terminate();
   FCommThread.WaitFor();
   FCommThread.Free();
   FCommandList.Free();
end;

procedure TICOM.AntSelect(no: Integer);
begin
   case no of
      0: Exit;
      1: ICOMWriteData(AnsiChar($12) + AnsiChar($00) + AnsiChar($00));
      2: ICOMWriteData(AnsiChar($12) + AnsiChar($01) + AnsiChar($00));
   end;
end;

procedure TICOM.FixEdgeSelect(no: Integer);
begin
   if FFixEdgeSelectSupported = False then begin
      Exit;
   end;

   case no of
      0: Exit;
      1: ICOMWriteData(AnsiChar($27) + AnsiChar($16) + AnsiChar($00) + AnsiChar($01));
      2: ICOMWriteData(AnsiChar($27) + AnsiChar($16) + AnsiChar($00) + AnsiChar($02));
      3: ICOMWriteData(AnsiChar($27) + AnsiChar($16) + AnsiChar($00) + AnsiChar($03));
      4: ICOMWriteData(AnsiChar($27) + AnsiChar($16) + AnsiChar($00) + AnsiChar($04));
   end;
end;

procedure TICOM.ExecuteCommand(S: AnsiString);
var
   Command: byte;
   temp: byte;
   freq, i1, i2, i3, i4, i5, i6: TFrequency;
   M: TMode;
   ss: AnsiString;
   Index: Integer;
   {$IFDEF DEBUG}
   debug_ss: AnsiString;
   {$ENDIF}
begin
   ss := S;

   // プリアンブルチェック
   Index := pos(AnsiChar($FE) + AnsiChar($FE), ss);
   if Index = 0 then begin
      Exit;
   end;

   // プリアンブル以前のゴミデータ削除
   if Index > 1 then begin
      Delete(ss, 1, Index - 1);
   end;

   // 最低６バイト必要
   if Length(ss) < 6 then begin
      Exit;
   end;

   // 宛先アドレスチェック
   if not(Ord(ss[3]) in [0, FMyAddr]) then begin
      Exit;
   end;

   // 送信元アドレスチェック
   if ss[4] <> AnsiChar(FRigAddr) then begin
      Exit;
   end;

   try
      // プリアンブル、宛先アドレス、送信元アドレス削除
      Delete(ss, 1, 4);

      // ポストアンブル削除
      Delete(ss, length(ss), 1);

      // コマンド取りだし
      Command := Ord(ss[1]);

      if Length(ss) = 1 then begin
         case Command of
            // NG
            $FA: begin
               Exit;
            end;

            // OK
            $FB: begin
               Exit;
            end;
         end;
         Exit;
      end;

      case Command of
         // MODE
         $01, $04: begin
            temp := Ord(ss[2]);
            case temp of
               0, 1:
                  M := mSSB;
               3, 7:
                  M := mCW;
               5, 6:
                  M := mFM;
               2:
                  M := mAM;
               4, 8:
                  M := mRTTY;
               else
                  M := mOther;
            end;

            if FIgnoreRigMode = False then begin
               _currentmode := M;
            end;

            if length(ss) >= 3 then begin
               if Ord(ss[3]) in [1 .. 3] then begin
                  ModeWidth[M] := Ord(ss[3]); // IF width
               end;
            end;

            // 処理タイミングによって、_currentfreqと_currentbandの食い違いが起きるので
            // 一致している場合にFreqMemを更新する
            if dmZLogGlobal.BandPlan.FreqToBand(_currentfreq[_currentvfo]) = _currentband then begin
               FreqMem[_currentband, M] := _currentfreq[_currentvfo];
            end;

            if Selected then begin
               UpdateStatus;
            end;
         end;

         // FREQ
         $00, $03: begin
            if Length(ss) < 4 then begin
               Exit;
            end;

            Delete(ss, 1, 1);

            {$IFDEF DEBUG}
            debug_ss := ss + AnsiChar(0) + AnsiChar(0);
            OutputDebugString(PChar(
            IntToHex(Ord(debug_ss[6])) + ' ' +
            IntToHex(Ord(debug_ss[5])) + ' ' +
            IntToHex(Ord(debug_ss[4])) + ' ' +
            IntToHex(Ord(debug_ss[3])) + ' ' +
            IntToHex(Ord(debug_ss[2])) + ' ' +
            IntToHex(Ord(debug_ss[1]))
            ));
            {$ENDIF}

            i1 := (Ord(ss[1]) mod 16) + (Ord(ss[1]) div 16) * 10;
            i2 := (Ord(ss[2]) mod 16) + (Ord(ss[2]) div 16) * 10;
            i3 := (Ord(ss[3]) mod 16) + (Ord(ss[3]) div 16) * 10;
            i4 := (Ord(ss[4]) mod 16) + (Ord(ss[4]) div 16) * 10;

            if Length(ss) >= 5 then begin
               i5 := (Ord(ss[5]) mod 16) + (Ord(ss[5]) div 16) * 10;
            end
            else begin
               i5 := 0;
            end;

            if Length(ss) >= 6 then begin
               i6 := (Ord(ss[6]) mod 16) + (Ord(ss[6]) div 16) * 10;
            end
            else begin
               i6 := 0;
            end;

            freq := i1 + 100 * i2 + 10000 * i3 + 1000000 * i4 + 100000000 * i5 + 10000000000 * i6;

            // 周波数有効範囲チェック
            if ((freq < 1800000) or (freq > 10245000000)) then begin
               Exit;
            end;

            _currentfreq[_currentvfo] := freq;
            freq := freq + _freqoffset;

            UpdateFreqMem(_currentvfo, freq, _currentmode);

            if Selected then begin
               UpdateStatus;
            end;
         end;

         // RIT
         $21: begin
            if (Length(ss) >= 5) and (Ord(ss[2]) = 0) then begin  // RIT周波数問合せ
               i1 := Ord(ss[3]) and $0f;
               i2 := (Ord(ss[3]) and $f0) shr 4;
               i3 := Ord(ss[4]) and $0f;
               i4 := (Ord(ss[4]) and $f0) shr 4;
               FRitOffset := (i4 * 1000) + (i3 * 100) + (i2 * 10) + i1;
               if Ord(ss[5]) = 1 then begin
                  FRitOffset := FRitOffset * -1;
               end;
               {$IFDEF DEBUG}
               OutputDebugString(PChar('RIT=' + IntToStr(FRitOffset)));
               {$ENDIF}
            end
            else if Length(ss) >= 3 then begin  // RIT ON/OFF問合せ
               if Ord(ss[3]) = 1 then begin
                  FRit := True;
               end
               else begin
                  FRIt := False;
               end;
            end;
         end;
      end;
   finally
   end;
end;

procedure TICOM.ICOMWriteData(S: AnsiString);
begin
   if FComm.Connected = False then begin
      {$IFDEF DEBUG}
      OutputDebugString(PChar('[' + IntToStr(_rignumber) + '] @@@not connected@@@'));
      {$ENDIF}
      Exit;
   end;

   // コマンド送信時はポーリング中止
   FPollingTimer.Enabled := False;

   // コマンドキューに追加
   IcomLock.Enter();
   FCommandList.Add(S);
   IcomLock.Leave();
end;

procedure TICOM.RitClear;
var
   Command: AnsiString;
begin
   Inherited;

   if FRitCtrlSupported = False then begin
      Exit;
   end;

   Command := AnsiChar($21) + AnsiChar($00) +
              // 10Hz  1Hz    1KHz  100Hz
              AnsiChar($00) + AnsiChar($00) +
              // 00:+   01:-
              AnsiChar($00);

   ICOMWriteData(Command);
end;

procedure TICOM.Initialize();
begin
   Inherited;
   FCommThread.Start();
   SetVFO(0);
   FPollingTimer.Enabled := True;
end;

procedure TICOM.InquireStatus;
begin
end;

procedure TICOM.ParseBufferString; // same as ts690
var
   i: Integer;
   temp: AnsiString;
begin
   i := pos(TerminatorCode, BufferString);

   while i > 0 do begin
      temp := copy(BufferString, 1, i);
      Delete(BufferString, 1, i);

      ExecuteCommand(temp); // string formatted at excecutecommand
      i := pos(TerminatorCode, BufferString);
   end;
end;

procedure TICOM.PollingProcess;
begin
   FPollingTimer.Enabled := False;

   if FStopRequest = True then begin
      Exit;
   end;

   if FGetBandAndMode = False then begin
      ICOMWriteData(AnsiChar($03));
   end
   else begin
      if FRitCtrlSupported = False then begin
         if (FPollingCount and 1) = 0 then begin
            ICOMWriteData(AnsiChar($03));
         end
         else begin
            ICOMWriteData(AnsiChar($04));
         end;
      end
      else begin
         case FPollingCount of
            0: ICOMWriteData(AnsiChar($03));
            1: ICOMWriteData(AnsiChar($04));
            2: ICOMWriteData(AnsiChar($21) + AnsiChar($01));
            3: ICOMWriteData(AnsiChar($21) + AnsiChar($00));
         end;
      end;
   end;

   Inc(FPollingCount);
   if FRitCtrlSupported = False then begin
      if FPollingCount > 1 then begin
         FPollingCount := 0;
      end;
   end
   else begin
      if FPollingCount > 3 then begin
         FPollingCount := 0;
      end;
   end;
end;

procedure TICOM.Reset;
begin
end;

procedure TICOM.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   fstr: AnsiString;
   freq, i: TFrequency;
begin
   Inherited SetFreq(Hz, fSetLastFreq);

   FPollingTimer.Enabled := False;
   try
      freq := Hz;
      fstr := '';

      // 100GHz / 10GHz
      if (freq >= 10000000000) then begin
         i := freq mod 100;
         fstr := fstr + AnsiChar((i div 10) * 16 + (i mod 10));
         freq := freq div 100;
      end;

      // 1000MHz / 100MHz (exclude IC-731)
      if FFreq4Bytes = False then begin
         i := freq mod 100;
         fstr := fstr + AnsiChar((i div 10) * 16 + (i mod 10));
         freq := freq div 100;
      end;

      // 10MHz / 1MHz
      i := freq mod 100;
      fstr := fstr + AnsiChar((i div 10) * 16 + (i mod 10));
      freq := freq div 100;

      // 100KHz / 10KHz
      i := freq mod 100;
      fstr := fstr + AnsiChar((i div 10) * 16 + (i mod 10));
      freq := freq div 100;

      // 1KHz / 100Hz
      i := freq mod 100;
      fstr := fstr + AnsiChar((i div 10) * 16 + (i mod 10));
      freq := freq div 100;

      // 10Hz / 1Hz
      i := freq mod 100;
      fstr := fstr + AnsiChar((i div 10) * 16 + (i mod 10));

      fstr := AnsiChar($05) + fstr;
      ICOMWriteData(fstr);
   finally
      FPollingCount := 0;
      FPollingTimer.Enabled := True;
   end;
end;

procedure TICOM.SetMode(Q: TQSO);
var
   Command: AnsiString;
   para: byte;
begin
   Inherited SetMode(Q);

   FPollingTimer.Enabled := False;
   try
      case Q.Mode of
         mSSB:
            if Q.Band <= b7 then
               para := 0
            else
               para := 1;
         mCW:
            para := 3;
         mFM:
            para := 5;
         mAM:
            para := 2;
         mRTTY:
            para := 4;
         else
            Exit;
      end;

      Command := AnsiChar($06) + AnsiChar(para);

      if ModeWidth[Q.Mode] in [1 .. 3] then begin
         Command := Command + AnsiChar(ModeWidth[Q.Mode]);
      end;

      ICOMWriteData(Command);
   finally
      FPollingCount := 0;
      FPollingTimer.Enabled := True;
   end;
end;

procedure TICOM.SetDataMode(fOn:Boolean);
var
   cmd: AnsiString;
   datamode: AnsiString;
   filter: AnsiString;
   n: Integer;
begin
   if fOn = True then begin
      n := RigNumber;

      case dmZLogGlobal.Settings._f2a_datamode[n] of
         0: datamode := AnsiChar($01);
         1: datamode := AnsiChar($02);
         2: datamode := AnsiChar($03);
         else datamode := AnsiChar($01);
      end;

      case dmZLogGlobal.Settings._f2a_filter[n] of
         0: filter := AnsiChar($01);
         1: filter := AnsiChar($02);
         2: filter := AnsiChar($03);
         else filter := AnsiChar($01);
      end;

      cmd := AnsiChar($1A) + AnsiChar($06) + datamode + filter;
   end
   else begin
      cmd := AnsiChar($1A) + AnsiChar($06) + AnsiChar($00) + AnsiChar($00);
   end;

   ICOMWriteData(cmd);
end;

procedure TICOM.SetRit(flag: Boolean);
begin
   Inherited;

   if FRitCtrlSupported = False then begin
      Exit;
   end;

   if flag = True then begin
      ICOMWriteData(AnsiChar($21) + AnsiChar($01) + AnsiChar($01));
   end
   else begin
      ICOMWriteData(AnsiChar($21) + AnsiChar($01) + AnsiChar($00));
   end;
end;

procedure TICOM.SetRitOffset(offset: Integer);
var
   CMD: AnsiString;
   sign: AnsiString;
   freq: Integer;
   i: Integer;
begin
   if FRitOffset = offset then begin
      Exit;
   end;

   if (FRitCtrlSupported = False) and (FXitCtrlSupported = False) then begin
      Exit;
   end;

   if offset < 0 then begin
      freq := offset * -1;
      sign := AnsiChar($01);
   end
   else begin
      freq := offset;
      sign := AnsiChar($00);
   end;

   CMD := AnsiChar($21) + AnsiChar($00);

   // 10Hz  1Hz
   i := freq mod 100;
   CMD := CMD + AnsiChar((i div 10) * 16 + (i mod 10));
   freq := freq div 100;

   // 1KHz  100Hz
   i := freq mod 100;
   CMD := CMD + AnsiChar((i div 10) * 16 + (i mod 10));
//   freq := freq div 100;

   // plus/minus
   CMD := CMD + sign;

   ICOMWriteData(CMD);

   Inherited;
end;

procedure TICOM.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      ICOMWriteData(AnsiChar($07) + AnsiChar($00))
   else
      ICOMWriteData(AnsiChar($07) + AnsiChar($01));

   if Selected then begin
      UpdateStatus;
   end;
end;

procedure TICOM.SetXit(flag: Boolean);
begin
   Inherited;

   if FXitCtrlSupported = False then begin
      Exit;
   end;

   if flag = True then begin
      ICOMWriteData(AnsiChar($21) + AnsiChar($02) + AnsiChar($01));
   end
   else begin
      ICOMWriteData(AnsiChar($21) + AnsiChar($02) + AnsiChar($00));
   end;
end;

procedure TICOM.StartPolling();
begin
   if FStopRequest = True then begin
      FPollingTimer.Enabled := False;
      Exit;
   end;

   // トランシーブモード使わない時はポーリング再開
   if (FUseTransceiveMode = False) then begin
      FPollingTimer.Enabled := True;
   end;

   // トランシーブモード使う場合は１回か２回ポーリングする
   if (FUseTransceiveMode = True) then begin
      if ((FGetBandAndMode = True) and  (FPollingCount < 2)) or
         ((FGetBandAndMode = False) and  (FPollingCount < 1)) then begin
         if FInitialPolling = False then begin
            FPollingTimer.Enabled := True;
            FInitialPolling := True;
         end;
      end;
   end;
end;

procedure TICOM.StopRequest();
begin
   Inherited;
   FCommThread.Terminate();
   FCommThread.WaitFor();
end;

// 14 0C 00 00
//       02 55
procedure TICOM.SetWPM(wpm: Integer);
var
   b: Integer;
   S: string;
   X1: Byte;
   X2: Byte;
begin
   if FPlayMessageCwSupported = False then begin
      Exit;
   end;

   b := Ceil((wpm - FMinWpm) / ((FMaxWPM - FMinWPM) / 255));
   S := RightStr('0000' + IntToStr(b), 4);

   X1 := StrToIntDef(Copy(S, 1, 1), 0) shl 4;
   X1 := X1 or StrToIntDef(Copy(S, 2, 1), 0);
   X2 := StrToIntDef(Copy(S, 3, 1), 0) shl 4;
   X2 := X2 or StrToIntDef(Copy(S, 4, 1), 0);

   ICOMWriteData(AnsiChar($14) + AnsiChar($0c) + AnsiChar(X1) + AnsiChar(X2));
end;

procedure TICOM.PlayMessageCW(msg: string);
var
   CMD: AnsiString;
   Index: Integer;
begin
   if FPlayMessageCwSupported = False then begin
      Exit;
   end;

   if Length(msg) > 30 then begin
      Exit;
   end;

   msg := ConvertProsignsStr(msg);

   msg := StringReplace(msg, 'a', '^AR', [rfReplaceAll]);  // AR
   msg := StringReplace(msg, 's', '^SK', [rfReplaceAll]);  // SK
   msg := StringReplace(msg, 'v', '^VA', [rfReplaceAll]);  // VA
   msg := StringReplace(msg, 'k', '^KN', [rfReplaceAll]);  // KN
   msg := StringReplace(msg, 'b', '^BK', [rfReplaceAll]);  // BK
   msg := StringReplace(msg, '~', '^BK', [rfReplaceAll]);  // BK
   msg := StringReplace(msg, 't', '^BT', [rfReplaceAll]);  // BT
   msg := StringReplace(msg, '.', '?',   [rfReplaceAll]);  // .

   Index := Pos('?', msg);
   if Index > 0 then begin
      msg := Copy(msg, 1, Index);
   end;

   if msg = '' then begin
      Exit;
   end;

   CMD := AnsiChar($17) + AnsiString(msg);
   ICOMWriteData(CMD);
end;

procedure TICOM.StopMessageCW();
begin
   if FPlayMessageCwSupported = False then begin
      Exit;
   end;

   ICOMWriteData(AnsiChar($17) + AnsiChar($ff));
end;

procedure TICOM.ControlPTT(fOn: Boolean);
begin
   if fOn = True then begin
      ICOMWriteData(AnsiChar($1c) + AnsiChar($00) + AnsiChar($01));
   end
   else begin
      ICOMWriteData(AnsiChar($1c) + AnsiChar($00) + AnsiChar($00));
   end;
end;

{ TIC756 }

procedure TIC756.Initialize();
begin
   Inherited;
end;

procedure TIC756.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   if _currentvfo <> i then begin
      _currentvfo := i;
      ICOMWriteData(AnsiChar($07) + AnsiChar($B0));
   end;

   if Selected then begin
      UpdateStatus;
   end;
end;

{ TIC7851 }

procedure TIC7851.AntSelect(no: Integer);
begin
   case no of
      0: Exit;
      1: ICOMWriteData(AnsiChar($12) + AnsiChar($00) + AnsiChar($00));
      2: ICOMWriteData(AnsiChar($12) + AnsiChar($01) + AnsiChar($00));
      3: ICOMWriteData(AnsiChar($12) + AnsiChar($02) + AnsiChar($00));
      4: ICOMWriteData(AnsiChar($12) + AnsiChar($03) + AnsiChar($00));
   end;
end;

{ TIcomCommThread }

constructor TIcomCommThread.Create(rig: TICOM);
begin
   Inherited Create(True);
   FRig := rig;
end;

procedure TIcomCommThread.Execute();
var
   S: AnsiString;
   R: AnsiString;
   msg: string;
   proc: TReceiveDataEvent;
   E: Integer;

   {$IFDEF DEBUG}
   procedure DebugDump(T: string; S: AnsiString; E: Integer);
   var
      str: string;
      i: Integer;
      L: Integer;
   begin
      L := Length(S);
      str := '';
      for i := 1 to L do begin
         str := str + IntToHex(Byte(S[i]),2) + ' ';
      end;
      str := Trim(str);
      OutputDebugString(PChar('*** ' + T + '=[' +
      IntToStr(L) + '][' + str + '] *** (' + IntToStr(E) + ')'));
   end;
   {$ENDIF}
begin
   FRig.FComm.InputTimeout := 200;
   while Terminated = False do begin
      // コマンドなし
      if FRig.FCommandList.Count = 0 then begin
         Sleep(50);
         Continue;
      end;

      // コマンド取りだし
      IcomLock.Enter();
      S := FRig.FCommandList.Items[0];
      proc := FRig.FComm.OnReceiveData;
      FRig.FComm.OnReceiveData := nil;
      IcomLock.Leave();

      {$IFDEF DEBUG}
//      DebugDump('コマンド', S, E);
      {$ENDIF}

      // 送信
      S := AnsiChar($FE) + AnsiChar($FE) + AnsiChar(FRig.FRigAddr) + AnsiChar(FRig.FMyAddr) + S + AnsiChar($FD);
      FRig.WriteData(S);
      {$IFDEF DEBUG}
      DebugDump('送信コマンド', S, E);
      {$ENDIF}

      // ちょっと待って
      Sleep(10);

      // 最初の応答電文受信
      R := RecvText(E);

      {$IFDEF DEBUG}
      if E >= 0 then begin
         DebugDump('受信①', R, E);
      end;
      {$ENDIF}

      // それはエコーバックか？
      if S = R then begin
         // 本当の応答電文受信
         R := RecvText(E);

         {$IFDEF DEBUG}
         if E >= 0 then begin
            DebugDump('受信②', R, E);
         end;
         {$ENDIF}
      end;

      // エラー有り
      if E = -1 then begin
         msg := 'No response from ' + FRig.Name;
         {$IFDEF DEBUG}
         msg := msg + ' (' + IntToHex(Byte(S[5])) + ')';
         OutputDebugString(PChar('[' + IntToStr(FRig._rignumber) + '] ' + msg));
         {$ENDIF}

         if Assigned(FRig.OnError) then begin
            FRig.OnError(FRig, msg);
         end;
      end
      else begin
         // レスポンス処理
         FResponse := R;
         Synchronize(SyncProc);
      end;

      // コマンド削除
      {$IFDEF DEBUG}
      OutputDebugString(PChar('*** コマンド削除 ***'));
      {$ENDIF}
      IcomLock.Enter();
      FRig.FCommandList.Delete(0);
      IcomLock.Leave();

      // ポーリング再開
      FRig.StartPolling();

      IcomLock.Enter();
      FRig.FComm.OnReceiveData := proc;
      IcomLock.Leave();
   end;
end;

function TIcomCommThread.RecvText(var nErrorCode: Integer): AnsiString;
var
   c: Integer;
   dwTick: DWORD;
   fStart: Boolean;
   fResult: Boolean;
   CH: AnsiChar;
begin
   // 応答受信 FE～FDまで受信
   nErrorCode := 0;
   fStart := False;
   c := 0;
   dwTick := GetTickCount();
   Result := '';
   while True do begin
      Sleep(0);
      CH := #00;
      fResult := FRig.FComm.ReadChar(CH);
      if fResult = False then begin
         // タイムアウト判定１文字目が来るまで
         if (c = 0) and
            ((GetTickCount() - dwTick) > DWORD(dmZLogGlobal.Settings._icom_response_timeout)) then begin
            {$IFDEF DEBUG}
            OutputDebugString(PChar('*** レスポンスなし ***'));
            {$ENDIF}
            Result := '';
            nErrorCode := -1;
            Exit;
         end;

         // ２文字目以降
         if (c >= 1) then begin
            {$IFDEF DEBUG}
            OutputDebugString(PChar('*** これ以降データなし ***'));
            {$ENDIF}
            nErrorCode := 1;
            Break;
         end;
      end;

      // スタートキャラクタ待ち
      if (fStart = False) then begin
         if (CH = #$FE) then begin
            fStart := True;
         end
         else begin
            Continue;
         end;
      end;

      // スタートしたらバッファに格納
      if fStart = True then begin
         Result := Result + CH;
         Inc(c);
      end;

      // 終端文字まで受信したら終了
      if CH = FRig.TerminatorCode then begin
         nErrorCode := 0;
         Break;
      end;
   end;
end;

procedure TIcomCommThread.SyncProc();
begin
   FRig.ExecuteCommand(FResponse);
end;

initialization
   IcomLock := TCriticalSection.Create();

finalization
   IcomLock.Free();

end.
