unit URigCtrlYaesu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, AnsiStrings,
  System.Math, System.StrUtils, System.SyncObjs, Generics.Collections,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  URigCtrlLib, UzLogConst, UzLogGlobal, UzLogQSO, CPDrv;

const
  _nil2: AnsiString = AnsiChar($00) + AnsiChar($00);
  _nil3: AnsiString = AnsiChar($00) + AnsiChar($00) + AnsiChar($00);
  _nil4: AnsiString = AnsiChar($00) + AnsiChar($00) + AnsiChar($00) + AnsiChar($00);

type
  TFT1000MP = class(TRig)
    WaitSize : integer;
    constructor Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand); override;
    destructor Destroy; override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure Initialize(); override;
    procedure InquireStatus; override;
    procedure ParseBufferString; override;
    procedure PassOnRxData(S : AnsiString); override;
    procedure PollingProcess; override;
    procedure Reset; override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
    procedure SetVFO(i : integer); override;
  end;

  TFT2000 = class(TRig)
  protected
    procedure SetRit(flag: Boolean); override;
    procedure SetRitOffset(offset: Integer); override;
    procedure SetXit(flag: Boolean); override;
  public
    constructor Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand); override;
    destructor Destroy; override;
    procedure AntSelect(no: Integer); override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure Initialize(); override;
    procedure InquireStatus; override;
    procedure ParseBufferString; override;
    procedure PassOnRxData(S : AnsiString); override;
    procedure PollingProcess; override;
    procedure Reset; override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
    procedure SetVFO(i : integer); override;
  end;

  TMARKVF = class(TFT1000MP)
    procedure ExecuteCommand(S : AnsiString); override;
    procedure RitClear; override;
  end;

  TFT1000 = class(TFT1000MP)
    procedure ExecuteCommand(S: AnsiString); override;
    procedure RitClear; override;
    procedure SetVFO(i : integer); override;
  end;

  TFT1011 = class(TFT1000MP)
    procedure ExecuteCommand(S: AnsiString); override;
    procedure Initialize(); override;
    procedure PollingProcess(); override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
    procedure SetVFO(i : integer); override;
  end;

  TMARKV = class(TFT1000MP)
    procedure ExecuteCommand(S: AnsiString); override;
    procedure RitClear; override;
    procedure SetVFO(i : integer); override;
  end;

  TFT847 = class(TFT1000MP)
    FUseCatOnCommand: Boolean;
    constructor Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure PollingProcess; override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
    procedure SetVFO(i : integer); override;
  end;

  TFT817 = class(TFT847)
    Fchange: Boolean;
    destructor Destroy; override;
    procedure Initialize(); override;
    procedure PollingProcess; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
  end;

  TFT920 = class(TFT1000MP)
    constructor Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand); override;
    procedure ExecuteCommand(S: AnsiString); override;
  end;

  TFT100 = class(TFT1000MP)
    constructor Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand); override;
    procedure ExecuteCommand(S: AnsiString); override;
    procedure Initialize(); override;
    procedure RitClear; override;
    procedure SetVFO(i : integer); override;
  end;

  TFT991 = class(TFT2000)
    procedure ExecuteCommand(S: AnsiString); override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
  end;

  TFT710 = class(TFT991)
  protected
    procedure SetRit(flag: Boolean); override;
    procedure SetRitOffset(offset: Integer); override;
    procedure SetXit(flag: Boolean); override;
  public
    procedure AntSelect(no: Integer); override;
    procedure RitClear; override;
  end;

implementation

{ TFT1000MP }

constructor TFT1000MP.Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand);
begin
   inherited;
   WaitSize := 32;
   FComm.StopBits := sb2BITS;
end;

destructor TFT1000MP.Destroy;
begin
   inherited;
end;

procedure TFT1000MP.ExecuteCommand(S: AnsiString);
var
   i: TFrequency;
   M: TMode;
begin
   try
      if length(S) = 32 then begin
         if _currentvfo = 0 then
            i := Ord(S[8])
         else
            i := Ord(S[8 + 16]);

         case i of
            0, 1:
               M := mSSB;
            2:
               M := mCW;
            3:
               M := mAM;
            4:
               M := mFM;
            5:
               M := mRTTY;
            else
               M := mOther;
         end;
         _currentmode := M;

         i := Ord(S[2]) * 256 * 256 * 256 + Ord(S[3]) * 256 * 256 + Ord(S[4]) * 256 + Ord(S[5]);
         i := round(i / 1.60);
         _currentfreq[0] := i;
         i := i + _freqoffset;

         if _currentvfo = 0 then begin
            UpdateFreqMem(0, i);
         end;

         i := Ord(S[18]) * 256 * 256 * 256 + Ord(S[19]) * 256 * 256 + Ord(S[20]) * 256 + Ord(S[21]);
         i := round(i / 1.60);
         _currentfreq[1] := i;
         i := i + _freqoffset;

         if _currentvfo = 1 then begin
            UpdateFreqMem(1, i);
         end;
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT1000MP.Initialize();
begin
   Inherited;
   FPollingTimer.Enabled := True;
end;

procedure TFT1000MP.InquireStatus;
begin
//
end;

procedure TFT1000MP.ParseBufferString;
var
   temp: AnsiString;
begin
   if length(BufferString) > 2048 then begin
      BufferString := '';
   end;

   if WaitSize = 0 then begin
      Exit;
   end;

   if length(BufferString) >= WaitSize then begin
      temp := copy(BufferString, 1, WaitSize);
      ExecuteCommand(temp);
      Delete(BufferString, 1, WaitSize);
   end;
end;

procedure TFT1000MP.PassOnRxData(S: AnsiString);
var
   i: Integer;
begin
   if FFILO then begin
      for i := length(S) downto 1 do begin
         BufferString := S[i] + BufferString;
      end;
   end
   else begin
      BufferString := BufferString + S;
   end;

   ParseBufferString;
end;

procedure TFT1000MP.PollingProcess;
begin
   FPollingTimer.Enabled := False;
   if FStopRequest = True then begin
      Exit;
   end;

   WriteData(_nil3 + AnsiChar($03) + AnsiChar($10));
end;

procedure TFT1000MP.Reset;
begin
   BufferString := '';
end;

procedure TFT1000MP.RitClear;
begin
   Inherited;
   WriteData(_nil2 + AnsiChar($0F) + AnsiChar($0) + AnsiChar($09));
end;

procedure TFT1000MP.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   fstr: AnsiString;
   i, j: TFrequency;
begin
   Inherited SetFreq(Hz, fSetLastFreq);

   i := Hz;
   i := i div 10;

   j := i mod 100;
   fstr := AnsiChar(dec2hex(j));
   i := i div 100;

   j := i mod 100;
   fstr := fstr + AnsiChar(dec2hex(j));
   i := i div 100;

   j := i mod 100;
   fstr := fstr + AnsiChar(dec2hex(j));
   i := i div 100;

   j := i mod 100;
   fstr := fstr + AnsiChar(dec2hex(j));
   // i := i div 100;

   fstr := fstr + AnsiChar($0A);

   WriteData(fstr);
end;

procedure TFT1000MP.SetMode(Q: TQSO);
var
   Command: AnsiString;
   para: byte;
begin
   Inherited SetMode(Q);

   para := 0;

   case Q.Mode of
      mSSB:
         if Q.Band <= b7 then
            para := 0
         else
            para := 1;
      mCW:
         para := 2;
      mFM:
         para := 6;
      mAM:
         para := 4;
      mRTTY:
         para := 8;
      mOther:
         para := $0A;
   end;

   Command := _nil3 + AnsiChar(para) + AnsiChar($0C);
   WriteData(Command);
end;

procedure TFT1000MP.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      WriteData(_nil3 + AnsiChar(0) + AnsiChar($05))
   else
      WriteData(_nil3 + AnsiChar(2) + AnsiChar($05));

   if Selected then begin
      UpdateStatus;
   end;
end;

{ TFT2000 }

constructor TFT2000.Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand);
begin
   Inherited;
   TerminatorCode := ';';
   FComm.StopBits := sb2BITS;
   FComm.DataBits := db8BITS;
end;

destructor TFT2000.Destroy;
begin
   FPollingTimer.Enabled := False;
   Inherited;
end;

//
// ANTENNA NUMBER
// SET    A N P1 P2 ;
// READ   A N P1 ;
// ANSWER A N P1 P3 P4 ;
// P1:0(fixed) P2:1/2/5 P3:1/2 P4 0/1
//
procedure TFT2000.AntSelect(no: Integer);
begin
   case no of
      0: Exit;
      1: WriteData('AN01;');
      2: WriteData('AN02;');
   end;
end;

// こちらでRIG情報を処理する
// 00000 00001111 11111 12 2222222223
// 12345 67890123 45678 90 1234567890
// IF001 07131790 +0000 10 140000;
procedure TFT2000.ExecuteCommand(S: AnsiString);
var
   M: TMode;
   i: Integer;
   strTemp: string;
begin
   try
      if Length(S) <> 27 then begin
         Exit;
      end;

      // Memory Channel
      // 3-5

      // モード
      strTemp := string(S[21]);
      case StrToIntDef(strTemp, 99) of
         1, 2: M := mSSB;
         3, 7: M := mCW;
         4:    M := mFM;
         5:    M := mAM;
         6, 9: M := mRTTY;
         else  M := mOther;
      end;
      _currentmode := M;

      // 周波数(Hz)
      strTemp := string(Copy(S, 6, 8));
      i := StrToIntDef(strTemp, 0);
      _currentfreq[0] := i;

      // バンド(VFO-A)
      if _currentvfo = 0 then begin
         UpdateFreqMem(0, i);
      end;

      // RIT/XIT offset
      strTemp := string(Copy(S, 14, 5));
      FRitOffset := StrToIntDef(strTemp, 0);

      // RIT Status
      strTemp := string(Copy(S, 19, 1));
      FRit := StrToBoolDef(strTemp, False);

      // XIT Status
      strTemp := string(Copy(S, 20, 1));
      FXit := StrToBoolDef(strTemp, False);

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT2000.Initialize();
begin
   Inherited;
   FPollingTimer.Enabled := True;
end;

procedure TFT2000.InquireStatus;
begin
//
end;

// TerminatorCodeを受信するまで待って、
// 到着するとExecuteCommand実行
procedure TFT2000.ParseBufferString;
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('***FT-2000 [' + string(BufferString) + ']'));
   {$ENDIF}

   if AnsiStrings.RightStr(BufferString, 1) <> TerminatorCode then begin
      Exit;
   end;

   ExecuteCommand(BufferString);

   Reset();
end;

procedure TFT2000.PassOnRxData(S: AnsiString);
begin
   Inherited PassOnRxData(S);//でよさそう
end;

//
// INFORMATION
//        0 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27
// SET
// READ   I F ;
// ANSWER I F ;  P1 P1 P1 P2 P2 P2 P2 P2 P2 P2 P2 P3 P3 P3 P3 P3 P4 P5 P6 P7 P8 P9 P9 P10 ;
// P1: Memory Channel(001-117)
// P2: VFO-A Frequency
// P3: CLAR DIRECTION(+/-) + CLAR OFFSET(0000-9999)Hz
// P4: RX CLAR 0:OFF 1:ON
// P5: TX CLAR 0:OFF 1:ON
// P6: MODE
// P7: 0:VFO 1:Memory 2:Memory Tune 3:QMB 4:QMB-MT
// P8: 0:CTCSS-OFF 1:CTCSS ENC/DEC 2:CTCSS ENC
// P9: Tone Number
// P10: 0:Simplex 1:Plus Shift 2:Minus Shift
//
procedure TFT2000.PollingProcess;
begin
   FPollingTimer.Enabled := False;
   if FStopRequest = True then begin
      Exit;
   end;

   WriteData('IF;');
end;

procedure TFT2000.Reset;
begin
   BufferString := '';
end;

//
// CLAR CLEAR
// SET    R C ;
//
procedure TFT2000.RitClear;
begin
   Inherited;
   WriteData('RC;');
end;

//
// FREQUENCY VFO-A/B
//        0 1  2  3  4  5  6  7  8  9 10 11
// SET    F A P1 P1 P1 P1 P1 P1 P1 P1 P1 ;
// READ   F A ;
// ANSWER F A P1 P1 P1 P1 P1 P1 P1 P1 P1 ;
//
procedure TFT2000.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
const
   cmd: array[0..1] of AnsiString = ( 'FA', 'FB' );
var
   freq: AnsiString;
begin
   Inherited SetFreq(Hz, fSetLastFreq);

   freq := AnsiStrings.RightStr(AnsiString(DupeString('0', 8)) + AnsiString(IntToStr(Hz)), 8);
   WriteData(cmd[_currentvfo] + freq + ';');
end;

//
// OPERATING MODE
//        0 1  2  3  4  5  6  7  8  9 10 11
// SET    M D P1 P2 ;
// READ   M D P1 ;
// ANSWER M D P1 P2 ;
// P1: 0:MAIN 1:SUB
// P2: 1:LSB 2:USB 3:CW 4:FM 5:AM 6:RTTY-L 7:CW-R 8:PKT-L 9:RTTY-U A:PKT-FM B:FM-N C:PKY-U
//
procedure TFT2000.SetMode(Q: TQSO);
var
   m: Integer;
begin
   Inherited SetMode(Q);

   case Q.Mode of
      mCW: m := 3;

      mSSB: begin
         if Q.Band <= b7 then begin
            m := 1;
         end
         else begin
            m := 2;
         end;
      end;

      mFM: m := 4;
      mAM: m := 5;
      mRTTY: m := 6;
      else begin
         Exit;
      end;
   end;

   WriteData(AnsiString('MD') + AnsiChar(Ord('0') + _currentvfo) + AnsiChar(Ord('0') + m) + AnsiString(';'));
end;

procedure TFT2000.SetRit(flag: Boolean);
begin
   Inherited;
   if flag = True then begin
      WriteData('RT1;');
   end
   else begin
      WriteData('RT0;');
   end;
end;

procedure TFT2000.SetRitOffset(offset: Integer);
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
      CMD := AnsiString('RD' + RightStr('0000' + IntToStr(Abs(offset)), 4) + ';');
      WriteData(CMD);
   end
   else if offset > 0 then begin
      WriteData('RC;');
      CMD := AnsiString('RU' + RightStr('0000' + IntToStr(Abs(offset)), 4) + ';');
      WriteData(CMD);
   end;

   Inherited;
end;

//
// VFO SELECT
// SET    V S P1 ;
// READ   V S ;
// ANSWER V S P1 ;
// P1: 0:VFO-A  1:VFO-B
//
procedure TFT2000.SetVFO(i: Integer);
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   WriteData(AnsiString('VS') + AnsiChar(Ord('0') + i) + AnsiString(';'));
end;

procedure TFT2000.SetXit(flag: Boolean);
begin
   Inherited;
   if flag = True then begin
      WriteData('XT1;');
   end
   else begin
      WriteData('XT0;');
   end;
end;

{ TMARKVF }

procedure TMARKVF.ExecuteCommand(S: AnsiString);
var
   i: TFrequency;
   M: TMode;
begin
   try
      if length(S) = 32 then begin
         if _currentvfo = 0 then begin
            i := Ord(S[8])
         end
         else begin
            i := Ord(S[8 + 16]);
         end;

         case i of
            0, 1:
               M := mSSB;
            2:
               M := mCW;
            3:
               M := mAM;
            4:
               M := mFM;
            5:
               M := mRTTY;
            else
               M := mOther;
         end;
         _currentmode := M;

         i := Ord(S[2]) * 256 * 256 * 256 + Ord(S[3]) * 256 * 256 + Ord(S[4]) * 256 + Ord(S[5]);
         i := i * 10;
         _currentfreq[0] := i;
         i := i + _freqoffset;

         if _currentvfo = 0 then begin
            UpdateFreqMem(0, i);
         end;

         i := Ord(S[18]) * 256 * 256 * 256 + Ord(S[19]) * 256 * 256 + Ord(S[20]) * 256 + Ord(S[21]);
         i := i * 10;
         _currentfreq[1] := i;
         i := i + _freqoffset;

         if _currentvfo = 1 then begin
            UpdateFreqMem(1, i);
         end;
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TMARKVF.RitClear;
begin
   Inherited;
   WriteData(_nil3 + AnsiChar($FF) + AnsiChar($09));
end;


{ TFT1000 }

procedure TFT1000.ExecuteCommand(S: AnsiString);
var
   i: TFrequency;
   M: TMode;
begin
   try
      if length(S) = 32 then begin
         if _currentvfo = 0 then
            i := Ord(S[8])
         else
            i := Ord(S[8 + 16]);

         case i of
            0, 1:
               M := mSSB;
            2:
               M := mCW;
            3:
               M := mAM;
            4:
               M := mFM;
            5:
               M := mRTTY;
            else
               M := mOther;
         end;
         _currentmode := M;

         i := Ord(S[2]) * 256 * 256 + Ord(S[3]) * 256 + Ord(S[4]);
         i := i * 10;
         _currentfreq[0] := i;
         i := i + _freqoffset;

         if _currentvfo = 0 then begin
            UpdateFreqMem(0, i);
         end;

         i := Ord(S[18]) * 256 * 256 + Ord(S[19]) * 256 + Ord(S[20]);
         i := i * 10;
         _currentfreq[1] := i;
         i := i + _freqoffset;

         if _currentvfo = 1 then begin
            UpdateFreqMem(1, i);
         end;
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT1000.RitClear;
begin
   Inherited;
   WriteData(_nil3 + AnsiChar($FF) + AnsiChar($09));
end;

procedure TFT1000.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      WriteData(_nil3 + AnsiChar(0) + AnsiChar($05))
   else
      WriteData(_nil3 + AnsiChar(1) + AnsiChar($05));

   if Selected then begin
      UpdateStatus;
   end;
end;

{ TFT1011 }

procedure TFT1011.ExecuteCommand(S: AnsiString);
begin
   try
      _currentfreq[0] := 0;
      _currentfreq[1] := 0;
      UpdateFreqMem(0, 0);
      UpdateFreqMem(1, 0);

      if Selected then begin
         UpdateStatus;
      end;
   finally
//      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT1011.Initialize();
begin
   Inherited;
   FPollingTimer.Enabled := False;
end;

procedure TFT1011.PollingProcess;
begin
   FPollingTimer.Enabled := False;
   if FStopRequest = True then begin
      Exit;
   end;

   ExecuteCommand('');
end;

procedure TFT1011.RitClear;
begin
   Inherited;
   WriteData(_nil3 + AnsiChar($FF) + AnsiChar($09));
end;

procedure TFT1011.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   fstr: AnsiString;
   i, j: TFrequency;
begin
   i := Hz;
   i := i div 10;

   j := i mod 100;
   fstr := AnsiChar(dec2hex(j));
   i := i div 100;

   j := i mod 100;
   fstr := fstr + AnsiChar(dec2hex(j));
   i := i div 100;

   j := i mod 100;
   fstr := fstr + AnsiChar(dec2hex(j));
   i := i div 100;

   j := i mod 100;
   fstr := fstr + AnsiChar(dec2hex(j));
   // i := i div 100;

   fstr := fstr + AnsiChar($0A);

   WriteData(fstr);

   _currentfreq[_currentvfo] := Hz;
   UpdateFreqMem(_currentvfo, Hz);
   if Selected then begin
      UpdateStatus;
   end;

   Inherited SetFreq(Hz, fSetLastFreq);

   FPollingTimer.Enabled := True;
end;

procedure TFT1011.SetMode(Q: TQSO);
var
   Command: AnsiString;
   para: byte;
begin
   Inherited SetMode(Q);

   para := 0;

   case Q.Mode of
      mSSB:
         if Q.Band <= b7 then
            para := 0
         else
            para := 1;
      mCW:
         para := 2;
      mFM:
         para := 6;
      mAM:
         para := 4;
      mRTTY:
         para := 8;
      mOther:
         para := $0A;
   end;

   Command := _nil3 + AnsiChar(para) + AnsiChar($0C);
   WriteData(Command);

   _currentmode := Q.Mode;
   if Selected then begin
      UpdateStatus;
   end;
end;

procedure TFT1011.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      WriteData(_nil3 + AnsiChar(0) + AnsiChar($05))
   else
      WriteData(_nil3 + AnsiChar(1) + AnsiChar($05));

   if Selected then begin
      UpdateStatus;
   end;
end;

{ TMARKV }

procedure TMARKV.ExecuteCommand(S: AnsiString);
var
   i: TFrequency;
   M: TMode;
begin
   try
      if length(S) = 32 then begin
         if _currentvfo = 0 then
            i := Ord(S[8])
         else
            i := Ord(S[8 + 16]);

         case i of
            0, 1:
               M := mSSB;
            2:
               M := mCW;
            3:
               M := mAM;
            4:
               M := mFM;
            5:
               M := mRTTY;
            else
               M := mOther;
         end;
         _currentmode := M;

         i := (Ord(S[5]) mod 16) * 100000000 + (Ord(S[5]) div 16) * 10000000 + (Ord(S[4]) mod 16) * 1000000 + (Ord(S[4]) div 16) * 100000 +
           (Ord(S[3]) mod 16) * 10000 + (Ord(S[3]) div 16) * 1000 + (Ord(S[2]) mod 16) * 100 + (Ord(S[2]) div 16) * 10;
         _currentfreq[0] := i;
         i := i + _freqoffset;

         if _currentvfo = 0 then begin
            UpdateFreqMem(0, i);
         end;

         i := (Ord(S[21]) div 16) * 100000000 + (Ord(S[21]) mod 16) * 10000000 + (Ord(S[20]) div 16) * 1000000 + (Ord(S[20]) mod 16) * 100000 +
           (Ord(S[19]) div 16) * 10000 + (Ord(S[19]) mod 16) * 1000 + (Ord(S[18]) div 16) * 100 + (Ord(S[18]) mod 16) * 10;
         _currentfreq[1] := i;
         i := i + _freqoffset;

         if _currentvfo = 1 then begin
            UpdateFreqMem(1, i);
         end;
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TMARKV.RitClear;
begin
   Inherited;
   WriteData(_nil3 + AnsiChar($FF) + AnsiChar($09));
end;

procedure TMARKV.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      WriteData(_nil3 + AnsiChar(0) + AnsiChar($05))
   else
      WriteData(_nil3 + AnsiChar(1) + AnsiChar($05));
   if Selected then
      UpdateStatus;
end;

{ TFT847 }

constructor TFT847.Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand);
begin
   inherited;
   WaitSize := 5;
   FComm.StopBits := sb2BITS;
   FUseCatOnCommand := True;
end;

destructor TFT847.Destroy;
begin
   if FUseCatOnCommand = True then begin
      WriteData(_nil4 + AnsiChar($80));   // CAT OFF
   end;
   inherited;
end;

procedure TFT847.ExecuteCommand(S: AnsiString);
var
   i: TFrequency;
   M: TMode;
begin
   try
      {$IFDEF DEBUG}
      // 7.035.0 CWの場合
      // 00 70 35 00 02 と受信するはず
      OutputDebugString(PChar('FT847 受信電文長=' + IntToStr(Length(S))));
      OutputDebugString(PChar(
      IntToHex(Ord(S[1])) + ' ' +
      IntToHex(Ord(S[2])) + ' ' +
      IntToHex(Ord(S[3])) + ' ' +
      IntToHex(Ord(S[4])) + ' ' +
      IntToHex(Ord(S[5]))
      ));
      {$ENDIF}

      if length(S) = WaitSize then begin
         case Ord(S[5]) mod 16 of // ord(S[5]) and $7?
            0, 1:
               M := mSSB;
            2, 3:
               M := mCW;
            4:
               M := mAM;
            8:
               M := mFM;
            else
               M := mOther;
         end;
         _currentmode := M;

         i := (Ord(S[1]) div 16) * 100000000 +
              (Ord(S[1]) mod 16) * 10000000 +
              (Ord(S[2]) div 16) * 1000000 +
              (Ord(S[2]) mod 16) * 100000 +
              (Ord(S[3]) div 16) * 10000 +
              (Ord(S[3]) mod 16) * 1000 +
              (Ord(S[4]) div 16) * 100 +
              (Ord(S[4]) mod 16) * 10;
         _currentfreq[_currentvfo] := i;
         i := i + _freqoffset;

         UpdateFreqMem(0, i);
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT847.Initialize();
begin
   Inherited;
   if FUseCatOnCommand = True then begin
      WriteData(AnsiChar($00) + AnsiChar($00) + AnsiChar($00) + AnsiChar($00) + AnsiChar($00)); // CAT ON
   end;
   FPollingTimer.Enabled := True;
end;

procedure TFT847.PollingProcess;
begin
   FPollingTimer.Enabled := False;
   if FStopRequest = True then begin
      Exit;
   end;

   WriteData(_nil4 + AnsiChar($03));
end;

procedure TFT847.RitClear;
begin
   Inherited;
end;

procedure TFT847.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
var
   fstr: AnsiString;
   i, j: TFrequency;
begin
   Inherited SetFreq(Hz, fSetLastFreq);

   i := Hz;
   i := i div 10;

   j := i mod 100;
   fstr := AnsiChar(dec2hex(j));
   i := i div 100;

   j := i mod 100;
   fstr := AnsiChar(dec2hex(j)) + fstr;
   i := i div 100;

   j := i mod 100;
   fstr := AnsiChar(dec2hex(j)) + fstr;
   i := i div 100;

   j := i mod 100;
   fstr := AnsiChar(dec2hex(j)) + fstr;
   // i := i div 100;

   fstr := fstr + AnsiChar($01);

   WriteData(fstr);
end;

procedure TFT847.SetMode(Q: TQSO);
var
   Command: AnsiString;
   para: byte;
begin
   Inherited SetMode(Q);

   case Q.Mode of
      mSSB:
         if Q.Band <= b7 then
            para := 0
         else
            para := 1;
      mCW:
         para := 2;
      mFM:
         para := 8;
      mAM:
         para := 4;
      else
         para := 0;
   end;

   Command := AnsiChar(para) + _nil3 + AnsiChar($07);
   WriteData(Command);
end;

procedure TFT847.SetVFO(i: Integer);
begin
//
end;

{ TFT817 }

destructor TFT817.Destroy;
begin
   inherited;
end;

procedure TFT817.Initialize();
begin
   FUseCatOnCommand := False;
   Fchange := False;
   Inherited;
end;

procedure TFT817.PollingProcess;
begin
   FPollingTimer.Enabled := False;
   if FStopRequest = True then begin
      Exit;
   end;

   if Fchange then begin
      BufferString :='';
      Fchange := False;
   end;
   WriteData(_nil4 + AnsiChar($03));
end;

procedure TFT817.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
begin
   Inherited SetFreq(Hz, fSetLastFreq);

   FPollingTimer.Enabled := False;
   Fchange := True;
   sleep(130);    //waitがないとコマンド連投時に後のコマンドが欠落する
   FPollingTimer.Enabled := True;
end;

procedure TFT817.SetMode(Q: TQSO);
begin
   Inherited SetMode(Q);

   FPollingTimer.Enabled := False;
   Fchange := True;
   sleep(130);  //waitがないとコマンド連投時に後のコマンドが欠落する
   FPollingTimer.Enabled := True;
end;

{ TFT920 }

constructor TFT920.Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand);
begin
   Inherited;
   WaitSize := 28;
end;

procedure TFT920.ExecuteCommand(S: AnsiString);
var
   i: TFrequency;
   M: TMode;
begin
   try
      if length(S) = 28 then begin
         if _currentvfo = 0 then
            i := Ord(S[8])
         else
            i := Ord(S[8 + 14]);

         case i and $07 of
            0:
               M := mSSB;
            1:
               M := mCW;
            2:
               M := mAM;
            3:
               M := mFM;
            4, 5:
               M := mRTTY;
            else
               M := mOther;
         end;
         _currentmode := M;

         i := Ord(S[2]) * 256 * 256 * 256 + Ord(S[3]) * 256 * 256 + Ord(S[4]) * 256 + Ord(S[5]);
         // i := round(i / 1.60);
         _currentfreq[0] := i;
         i := i + _freqoffset;

         if _currentvfo = 0 then begin
            UpdateFreqMem(0, i);
         end;

         i := Ord(S[16]) * 256 * 256 * 256 + Ord(S[17]) * 256 * 256 + Ord(S[18]) * 256 + Ord(S[19]);
         // i := round(i / 1.60);
         _currentfreq[1] := i;
         i := i + _freqoffset;

         if _currentvfo = 1 then begin
            UpdateFreqMem(1, i);
         end;
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

{ TFT100 }

constructor TFT100.Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand);
begin
   Inherited;
   WaitSize := 32;
end;

procedure TFT100.ExecuteCommand(S: AnsiString);
var
   i: TFrequency;
   M: TMode;
begin
   try
      if length(S) = WaitSize then begin
         case Ord(S[6]) and $7 of
            0, 1:
               M := mSSB;
            2, 3:
               M := mCW;
            4:
               M := mAM;
            6, 7:
               M := mFM;
            5:
               M := mRTTY;
            else
               M := mOther;
         end;
         _currentmode := M;

         i := Ord(S[2]) * 256 * 256 * 256 + Ord(S[3]) * 256 * 256 + Ord(S[4]) * 256 + Ord(S[5]);
         i := round(i * 1.25);
         _currentfreq[0] := i;
         i := Ord(S[18]) * 256 * 256 * 256 + Ord(S[19]) * 256 * 256 + Ord(S[20]) * 256 + Ord(S[21]);
         i := round(i * 1.25);
         _currentfreq[1] := i;

         i := _currentfreq[_currentvfo] + _freqoffset;

         UpdateFreqMem(0, i);
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT100.Initialize();
begin
   Inherited;
end;

procedure TFT100.RitClear;
begin
   Inherited;
end;

procedure TFT100.SetVFO(i: Integer); // A:0, B:1
begin
   if (i > 1) or (i < 0) then begin
      Exit;
   end;

   _currentvfo := i;
   if i = 0 then
      WriteData(_nil3 + AnsiChar(0) + AnsiChar($05))
   else
      WriteData(_nil3 + AnsiChar(1) + AnsiChar($05));
   if Selected then
      UpdateStatus;
end;

{ TFT991 }

//   FT-991対応
//  基本はFT-2000と同じ。違いは下記。
//  FT-991の周波数桁数は9桁。なのでmode情報は、1文字後ろへ。
//  rigの状態取得と周波数変更の2点をoverride
//
procedure TFT991.ExecuteCommand(S: AnsiString);
var
   M: TMode;
   i: Integer;
   strTemp: string;
begin
   try
      if Length(S) <> 28 then begin   //全長28文字
         Exit;
      end;

      // モード
      strTemp := string(S[22]);      //22文字目
      case StrToIntDef(strTemp, 99) of
         1, 2: M := mSSB;
         3, 7: M := mCW;
         4:    M := mFM;
         5:    M := mAM;
         6, 9: M := mRTTY;
         else  M := mOther;
      end;
      _currentmode := M;

      // 周波数(Hz)
      strTemp := string(Copy(S, 6, 9));        // 6桁目から9文字
      i := StrToIntDef(strTemp, 0);
      _currentfreq[0] := i;

      // バンド(VFO-A)
      if _currentvfo = 0 then begin
         UpdateFreqMem(0, i);
      end;

      if Selected then begin
         UpdateStatus;
      end;
   finally
      FPollingTimer.Enabled := True;
   end;
end;

procedure TFT991.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
const
   cmd: array[0..1] of AnsiString = ( 'FA', 'FB' );
var
   freq: AnsiString;
begin
   Inherited SetFreq(Hz, fSetLastFreq);

   freq := AnsiStrings.RightStr(AnsiString(DupeString('0', 9)) + AnsiString(IntToStr(Hz)), 9);  // freq 9桁
   WriteData(cmd[_currentvfo] + freq + ';');
end;

{ TFT710 }

procedure TFT710.AntSelect(no: Integer);
begin
//
end;

//
// CLAR
//        0 1  2  3  4  5  6  7  8  9 10
// SET    C F P1 P2 P3 P4 P5 P6 P7 P8 ;
// READ   C F P1 P2 P3;
// ANSWER C F P1 P2 P3 P4 P5 P6 P7 P8 ;
// P1: 0:MAIN 1:SUB
// P2: 0:固定
// P3: 0:CLAR設定 1:CLAR周波数
// P3 = 0
//     P4: 0:RX CLAR OFF 1:RX CLAR ON
//     P5: 0:TX CLAR OFF 1:TX CLAR ON
//     P6-P8: 0(固定)
// P3 = 1
//     P4: +:プラスシフト
//         -:マイナスシフト
//     P5-P8: 0000-9999Hz
//
procedure TFT710.RitClear;
begin
   Inherited;
   WriteData('CF001+0000;');
end;

procedure TFT710.SetRit(flag: Boolean);
begin
   Inherited;
   if flag = True then begin
      WriteData('CF00010000;');
   end
   else begin
      WriteData('CF00000000;');
   end;
end;

procedure TFT710.SetRitOffset(offset: Integer);
var
   CMD: AnsiString;
begin
   if FRitOffset = offset then begin
      Exit;
   end;

   if offset = 0 then begin
      WriteData('CF001+0000;');
   end
   else if offset < 0 then begin
      WriteData('CF001+0000;');
      CMD := AnsiString('CF001-' + RightStr('0000' + IntToStr(Abs(offset)), 4) + ';');
      WriteData(CMD);
   end
   else if offset > 0 then begin
      WriteData('CF001+0000;');
      CMD := AnsiString('CF001+' + RightStr('0000' + IntToStr(Abs(offset)), 4) + ';');
      WriteData(CMD);
   end;

   Inherited;
end;

procedure TFT710.SetXit(flag: Boolean);
begin
   Inherited;
   if flag = True then begin
      WriteData('CF00001000;');
   end
   else begin
      WriteData('CF00000000;');
   end;
end;

end.
