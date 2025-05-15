unit URigCtrlKenwood;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, AnsiStrings,
  System.Math, System.StrUtils, System.SyncObjs, Generics.Collections,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  URigCtrlLib, UzLogConst, UzLogGlobal, UzLogQSO, CPDrv;

type
  TTS690 = class(TRig) // TS-450 as well
  protected
    procedure SetRit(flag: Boolean); override;
    procedure SetRitOffset(offset: Integer); override;
    procedure SetXit(flag: Boolean); override;
  private
    FFineStep: Boolean;
  public
    _CWR : boolean; // CW-R flag
    constructor Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand); override;
    destructor Destroy; override;
    procedure AntSelect(no: Integer); override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure Initialize(); override;
    procedure InquireStatus; override;
    procedure ParseBufferString; override;
    procedure RitClear; override;
    procedure Reset; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
    procedure SetVFO(i : integer); override;
    procedure ControlPTT(fOn: Boolean); override;
  end;

  // TS-2000,TS-480,TS-590,TS-890
  TTS2000 = class(TTS690)
  protected
    procedure SetRitOffset(offset: Integer); override;
  public
    constructor Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand); override;
    procedure Initialize(); override;
    procedure SetWPM(wpm: Integer); override;
    procedure PlayMessageCW(msg: string); override;
    procedure StopMessageCW(); override;
  end;

  TTS2000P = class(TTS2000)
    constructor Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    procedure PollingProcess; override;
  end;

  TTS570 = class(TTS690)
    constructor Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand); override;
    procedure Initialize(); override;
  end;

  TTS890 = class(TTS2000)
  public
    procedure FixEdgeSelect(no: Integer); override;
  end;

  TTS990 = class(TTS2000)
  public
    procedure AntSelect(no: Integer); override;
  end;

implementation

{ TTS690 }

constructor TTS690.Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand);
begin
   Inherited;
   TerminatorCode := ';';
   FComm.StopBits := sb2BITS;
   _CWR := False;
   FFineStep := False;
   FControlPTTSupported := True;
end;

destructor TTS690.Destroy;
begin
   WriteData('AI0;');
   inherited;
end;

procedure TTS690.AntSelect(no: Integer);
begin
   case no of
      0: Exit;
      1: WriteData('AN1;');
      2: WriteData('AN2;');
   end;
end;

procedure TTS690.ExecuteCommand(S: AnsiString);
var
   Command: AnsiString;
   strTemp: string;
   i: TFrequency;
   aa: Integer;
   M: TMode;
   b: TBand;
begin
   // RigControl.label1.caption := S;
   if length(S) < 2 then begin
      Exit;
   end;

   Command := S[1] + S[2];

   if (Command = 'FA') or (Command = 'FB') then begin
      if Command = 'FA' then
         aa := 0
      else
         aa := 1;

      strTemp := string(Copy(S, 3, 11));
      i := StrToIntDef(strTemp, 0);
      _currentfreq[aa] := i;
//      i := i + _freqoffset; // transverter

      if _currentvfo = aa then begin
         UpdateFreqMem(aa, _currentfreq[aa], _currentmode);
      end;

      if Selected then
         UpdateStatus;
   end;

   if (Command = 'FT') or (Command = 'FR') then begin // 2.1j
      if S[3] = '0' then
         aa := 0
      else if S[3] = '1' then
         aa := 1
      else
         Exit;

      _currentvfo := aa;

      UpdateFreqMem(aa, _currentfreq[aa], _currentmode);

      if Selected then
         UpdateStatus;
   end;

   if Command = 'IF' then begin
      if length(S) < 38 then
         Exit;

      case S[31] of
         '0':
            _currentvfo := 0;
         '1':
            _currentvfo := 1;
         // '2' : memory
      end;

      strTemp := string(copy(S, 3, 11));
      i := StrToIntDef(strTemp, 0);
      _currentfreq[_currentvfo] := i;
      i := i + _freqoffset; // transverter

      b := dmZLogGlobal.BandPlan.FreqToBand(i);
      if b <> bUnknown then begin
         _currentband := b;
      end;

      case S[30] of
         '1', '2': begin
            M := mSSB;
         end;

         '3': begin
            M := mCW;
            _CWR := False;
         end;

         '7': begin
            M := mCW;
            _CWR := True;
         end;

         '4': begin
            M := mFM;
         end;

         '5': begin
            M := mAM;
         end;

         '6', '8': begin
            M := mRTTY;
         end;

         else begin
            M := mOther;
         end;
      end;

      if FIgnoreRigMode = False then begin
         _currentmode := M;
      end;

      FreqMem[_currentband, M] := _currentfreq[_currentvfo];

      // RIT/XIT offset
      strTemp := string(Copy(S, 19, 5));
      FRitOffset := StrToIntDef(strTemp, 0);

      // RIT Status
      strTemp := string(Copy(S, 24, 1));
      FRit := StrToBoolDef(strTemp, False);

      // XIT Status
      strTemp := string(Copy(S, 25, 1));
      FXit := StrToBoolDef(strTemp, False);

      if Selected then begin
         UpdateStatus;
      end;
   end;

   if Command = 'MD' then begin
      case S[3] of
         '1', '2':
            M := mSSB;
         '3': begin
               M := mCW;
               _CWR := False;
            end;
         '7': begin
               M := mCW;
               _CWR := True;
            end;
         '4':
            M := mFM;
         '5':
            M := mAM;
         '6', '8':
            M := mRTTY;
         else
            M := mOther;
      end;

      if FIgnoreRigMode = False then begin
         _currentmode := M;
      end;

      FreqMem[_currentband, M] := _currentfreq[_currentvfo];

      if Selected then
         UpdateStatus;
   end;

   if Command = 'FS' then begin
      if S[3] = '1' then begin
         FFineStep := True;
      end
      else begin
         FFineStep := False;
      end;
   end;
end;

procedure TTS690.Initialize();
begin
   Inherited;
   WriteData('AI1;');
end;

procedure TTS690.InquireStatus;
begin
   WriteData('IF;');
end;

procedure TTS690.ParseBufferString;
var
   i: Integer;
   temp: AnsiString;
begin
   i := pos(TerminatorCode, BufferString);
   while i > 0 do begin
      temp := copy(BufferString, 1, i);
      Delete(BufferString, 1, i);
      ExecuteCommand(temp);
      i := pos(TerminatorCode, BufferString);
   end;
end;

procedure TTS690.Reset;
begin
end;

procedure TTS690.RitClear;
begin
   Inherited;
   WriteData('RC;');
end;

procedure TTS690.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   fstr: AnsiString;
begin
   Inherited SetFreq(Hz, fSetLastFreq);

   fstr := AnsiString(IntToStr(Hz));
   while length(fstr) < 11 do begin
      fstr := '0' + fstr;
   end;

   if _currentvfo = 0 then
      WriteData('FA' + fstr + ';')
   else
      WriteData('FB' + fstr + ';');
end;

procedure TTS690.SetMode(Q: TQSO);
var
   Command: AnsiString;
   para: AnsiChar;
begin
   Inherited SetMode(Q);

   { 1=LSB, 2=USB, 3=CW, 4=FM, 5=AM, 6=FSK, 7=CW-R, 8=FSK=R }
   para := '3';
   case Q.Mode of
      mSSB:
         if Q.Band <= b7 then
            para := '1'
         else
            para := '2';
      mCW:
         if _CWR then
            para := '7'
         else
            para := '3';
      mFM:
         para := '4';
      mAM:
         para := '5';
      mRTTY:
         para := '6';
   end;

   Command := AnsiString('MD') + para + TerminatorCode;
   WriteData(Command);
end;

procedure TTS690.SetRit(flag: Boolean);
begin
   Inherited;
   if flag = True then begin
      WriteData('RT1;');
   end
   else begin
      WriteData('RT0;');
   end;
end;

procedure TTS690.SetRitOffset(offset: Integer);
var
//   CMD: AnsiString;
   i: Integer;
   n: Integer;
begin
   if FRitOffset = offset then begin
      Exit;
   end;

   if offset = 0 then begin
      WriteData('RC;');
   end
   else if offset < 0 then begin
      WriteData('RC;');

      offset := offset * -1;

      if FFineStep = True then begin
         n := offset;
      end
      else begin
         n := offset div 10;
      end;

      for i := 1 to n do begin
         WriteData('RD;');
      end;

//      CMD := AnsiString('RD' + RightStr('00000' + IntToStr(Abs(offset)), 5) + ';');
//      WriteData(CMD);
   end
   else if offset > 0 then begin
      WriteData('RC;');

      if FFineStep = True then begin
         n := offset;
      end
      else begin
         n := offset div 10;
      end;

      for i := 1 to n do begin
         WriteData('RU;');
      end;

//      CMD := AnsiString('RU' + RightStr('00000' + IntToStr(Abs(offset)), 5) + ';');
//      WriteData(CMD);
   end;

   Inherited;
end;

procedure TTS690.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      WriteData('FR0;FT0;')
   else
      WriteData('FR1;FT1;');

   if Selected then begin
      UpdateStatus;
   end;
end;

procedure TTS690.SetXit(flag: Boolean);
begin
   Inherited;
   if flag = True then begin
      WriteData('XT1;');
   end
   else begin
      WriteData('XT0;');
   end;
end;

procedure TTS690.ControlPTT(fOn: Boolean);
begin
   if fOn = True then begin
      WriteData('TX;');
   end
   else begin
      WriteData('RX;');
   end;
end;

{ TS2000 }

constructor TTS2000.Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand);
begin
   Inherited;
   TerminatorCode := ';';
   FComm.StopBits := sb1BITS;
   FPlayMessageCwSupported := True;
end;

destructor TTS2000P.Destroy;
begin
   WriteData('AI0;');
   inherited;
end;

procedure TTS2000.Initialize();
begin
   Inherited;
   WriteData('TC 1;');
   WriteData('AI2;');
   WriteData('IF;');
end;

procedure TTS2000.SetRitOffset(offset: Integer);
var
   CMD: AnsiString;
begin
   if FRitOffset = offset then begin
      Exit;
   end;

   if offset = 0 then begin
      WriteData('RC;');
   end
   else if offset < 0 then begin
      WriteData('RC;');
      CMD := AnsiString('RD' + RightStr('00000' + IntToStr(Abs(offset)), 5) + ';');
      WriteData(CMD);
   end
   else if offset > 0 then begin
      WriteData('RC;');
      CMD := AnsiString('RU' + RightStr('00000' + IntToStr(Abs(offset)), 5) + ';');
      WriteData(CMD);
   end;

   Inherited;
end;

procedure TTS2000.SetWPM(wpm: Integer);
var
   CMD: AnsiString;
begin
   CMD := AnsiString('KS' + RightStr('000' + IntToStr(wpm), 3) + ';');
   WriteData(CMD);
end;

// 0  0  0  0  0000011111111112222222 2  2
// 1  2  3  4  5678901234567890123456 7  8
// K  Y  P1 P2                        P2 ;   max 24 characters
procedure TTS2000.PlayMessageCW(msg: string);
var
   CMD: AnsiString;
   Index: Integer;
begin
   if Length(msg) > 24 then begin
      Exit;
   end;

   msg := ConvertProsignsStr(msg);

   msg := StringReplace(msg, 'a', '_', [rfReplaceAll]);  // AR
   msg := StringReplace(msg, 's', '>', [rfReplaceAll]);  // SK
   msg := StringReplace(msg, 'v', '>', [rfReplaceAll]);  // VA
   msg := StringReplace(msg, 'k', ']', [rfReplaceAll]);  // KN
   msg := StringReplace(msg, 'b', '\', [rfReplaceAll]);  // BK
   msg := StringReplace(msg, '~', '\', [rfReplaceAll]);  // BK
   msg := StringReplace(msg, 't', '[', [rfReplaceAll]);  // BT
   msg := StringReplace(msg, '.', '?', [rfReplaceAll]);  // .

   Index := Pos('?', msg);
   if Index > 0 then begin
      msg := Copy(msg, 1, Index);
   end;

   if msg = '' then begin
      Exit;
   end;

   CMD := AnsiString('KY' + ' ' + LeftStr(msg + DupeString(' ', 24), 24) + ';');
   WriteData(CMD);
end;

procedure TTS2000.StopMessageCW();
var
   CMD: AnsiString;
begin
   CMD := AnsiString('KY0;');
   WriteData(CMD);
end;

{ TS2000(Polling) }

constructor TTS2000P.Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand);
begin
   Inherited;
end;

procedure TTS2000P.Initialize();
begin
   Inherited;
   FPollingTimer.Enabled := True;
end;

procedure TTS2000P.PollingProcess;
begin
   FPollingTimer.Enabled := False;
   if FStopRequest = True then begin
      Exit;
   end;

   WriteData('IF;');
end;

{ TTS570 }

constructor TTS570.Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand);
begin
   Inherited;
   TerminatorCode := ';';
   FComm.StopBits := sb1BITS;
end;

procedure TTS570.Initialize();
begin
   Inherited;
   WriteData('TC 1;');
   WriteData('AI2;');
   WriteData('IF;');
end;

{ TTS890 }

procedure TTS890.FixEdgeSelect(no: Integer);
begin
   case no of
      0: Exit;
      1: WriteData('BS51;');
      2: WriteData('BS52;');
      3: WriteData('BS53;');
   end;
end;

{ TTS990 }

procedure TTS990.AntSelect(no: Integer);
begin
   case no of
      0: Exit;
      1: WriteData('AN1;');
      2: WriteData('AN2;');
      3: WriteData('AN3;');
      4: WriteData('AN4;');
   end;
end;

end.
