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

    FCommThread: TIcomCommThread;
    FCommandList: TList<AnsiString>;

    FFreq4Bytes: Boolean;
  public
    constructor Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand); override;
    destructor Destroy; override;
    procedure AntSelect(no: Integer); override;
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
    procedure SetVFO(i : integer); override;
    procedure StartPolling();
    procedure StopRequest(); override;

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

   FFreq4Bytes := False;
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

   // �v���A���u���`�F�b�N
   Index := pos(AnsiChar($FE) + AnsiChar($FE), ss);
   if Index = 0 then begin
      Exit;
   end;

   // �v���A���u���ȑO�̃S�~�f�[�^�폜
   if Index > 1 then begin
      Delete(ss, 1, Index - 1);
   end;

   // �Œ�U�o�C�g�K�v
   if Length(ss) < 6 then begin
      Exit;
   end;

   // ����A�h���X�`�F�b�N
   if not(Ord(ss[3]) in [0, FMyAddr]) then begin
      Exit;
   end;

   // ���M���A�h���X�`�F�b�N
   if ss[4] <> AnsiChar(FRigAddr) then begin
      Exit;
   end;

   try
      // �v���A���u���A����A�h���X�A���M���A�h���X�폜
      Delete(ss, 1, 4);

      // �|�X�g�A���u���폜
      Delete(ss, length(ss), 1);

      // �R�}���h��肾��
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

            // �����^�C�~���O�ɂ���āA_currentfreq��_currentband�̐H���Ⴂ���N����̂�
            // ��v���Ă���ꍇ��FreqMem���X�V����
            if dmZLogGlobal.BandPlan.FreqToBand(_currentfreq[_currentvfo]) = _currentband then begin
               FreqMem[_currentband, M] := _currentfreq[_currentvfo];
            end;

            if Selected then begin
               UpdateStatus;
            end;
         end;

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
            _currentfreq[_currentvfo] := freq;
            freq := freq + _freqoffset;

            UpdateFreqMem(_currentvfo, freq, _currentmode);

            if Selected then begin
               UpdateStatus;
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

   // �R�}���h���M���̓|�[�����O���~
   FPollingTimer.Enabled := False;

   // �R�}���h�L���[�ɒǉ�
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
      if (FPollingCount and 1) = 0 then begin
         ICOMWriteData(AnsiChar($03));
      end
      else begin
         ICOMWriteData(AnsiChar($04));
      end;
   end;

   Inc(FPollingCount);
   if FPollingCount < 0 then begin
      FPollingCount := 1;
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

   // �g�����V�[�u���[�h�g��Ȃ����̓|�[�����O�ĊJ
   if (FUseTransceiveMode = False) then begin
      FPollingTimer.Enabled := True;
   end;

   // �g�����V�[�u���[�h�g���ꍇ�͂P�񂩂Q��|�[�����O����
   if (FUseTransceiveMode = True) then begin
      if ((FGetBandAndMode = True) and  (FPollingCount < 2)) or
         ((FGetBandAndMode = False) and  (FPollingCount < 1)) then begin
         FPollingTimer.Enabled := True;
      end;
   end;
end;

procedure TICOM.StopRequest();
begin
   Inherited;
   FCommThread.Terminate();
   FCommThread.WaitFor();
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
      // �R�}���h�Ȃ�
      if FRig.FCommandList.Count = 0 then begin
         Sleep(50);
         Continue;
      end;

      // �R�}���h��肾��
      IcomLock.Enter();
      S := FRig.FCommandList.Items[0];
      proc := FRig.FComm.OnReceiveData;
      FRig.FComm.OnReceiveData := nil;
      IcomLock.Leave();

      {$IFDEF DEBUG}
//      DebugDump('�R�}���h', S, E);
      {$ENDIF}

      // ���M
      S := AnsiChar($FE) + AnsiChar($FE) + AnsiChar(FRig.FRigAddr) + AnsiChar(FRig.FMyAddr) + S + AnsiChar($FD);
      FRig.WriteData(S);
      {$IFDEF DEBUG}
      DebugDump('���M�R�}���h', S, E);
      {$ENDIF}

      // ������Ƒ҂���
      Sleep(10);

      // �ŏ��̉����d����M
      R := RecvText(E);

      {$IFDEF DEBUG}
      if E >= 0 then begin
         DebugDump('��M�@', R, E);
      end;
      {$ENDIF}

      // ����̓G�R�[�o�b�N���H
      if S = R then begin
         // �{���̉����d����M
         R := RecvText(E);

         {$IFDEF DEBUG}
         if E >= 0 then begin
            DebugDump('��M�A', R, E);
         end;
         {$ENDIF}
      end;

      // �G���[�L��
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
         // ���X�|���X����
         FResponse := R;
         Synchronize(SyncProc);
      end;

      // �R�}���h�폜
      {$IFDEF DEBUG}
      OutputDebugString(PChar('*** �R�}���h�폜 ***'));
      {$ENDIF}
      IcomLock.Enter();
      FRig.FCommandList.Delete(0);
      IcomLock.Leave();

      // �|�[�����O�ĊJ
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
   // ������M FE�`FD�܂Ŏ�M
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
         // �^�C���A�E�g����P�����ڂ�����܂�
         if (c = 0) and
            ((GetTickCount() - dwTick) > DWORD(dmZLogGlobal.Settings._icom_response_timeout)) then begin
            {$IFDEF DEBUG}
            OutputDebugString(PChar('*** ���X�|���X�Ȃ� ***'));
            {$ENDIF}
            Result := '';
            nErrorCode := -1;
            Exit;
         end;

         // �Q�����ڈȍ~
         if (c >= 1) then begin
            {$IFDEF DEBUG}
            OutputDebugString(PChar('*** ����ȍ~�f�[�^�Ȃ� ***'));
            {$ENDIF}
            nErrorCode := 1;
            Break;
         end;
      end;

      // �X�^�[�g�L�����N�^�҂�
      if (fStart = False) then begin
         if (CH = #$FE) then begin
            fStart := True;
         end
         else begin
            Continue;
         end;
      end;

      // �X�^�[�g������o�b�t�@�Ɋi�[
      if fStart = True then begin
         Result := Result + CH;
         Inc(c);
      end;

      // �I�[�����܂Ŏ�M������I��
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
