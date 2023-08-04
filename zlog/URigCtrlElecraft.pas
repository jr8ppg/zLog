unit URigCtrlElecraft;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, AnsiStrings,
  System.Math, System.StrUtils, System.SyncObjs, Generics.Collections,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  URigCtrlLib, UzLogConst, UzLogGlobal, UzLogQSO, CPDrv;

type
  // K3S/K3/KX3/KX2
  TElecraft = class(TRig)
  protected
    procedure SetRit(flag: Boolean); override;
    procedure SetXit(flag: Boolean); override;
    procedure SetRitOffset(offset: Integer); override;
  private
    FCwReverse: Boolean; // CW-R flag
  public
    constructor Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand); override;
    destructor Destroy; override;
    procedure AntSelect(no: Integer); override;
    procedure ExecuteCommand(S : AnsiString); override;
    procedure Initialize(); override;
    procedure InquireStatus; override;
    procedure ParseBufferString; override;
    procedure Reset; override;
    procedure RitClear; override;
    procedure SetFreq(Hz: TFrequency; fSetLastFreq: Boolean); override;
    procedure SetMode(Q : TQSO); override;
    procedure SetVFO(i : integer); override;
  end;

implementation

// Serial Port Setup: Set CONFIG:RS232 for the
// desired baud rate. Software should be set up at the
// same rate; 8 data bits, no parity, 1 stop bit.
constructor TElecraft.Create(RigNum: Integer; APort: Integer; AComm: TCommPortDriver; ATimer: TTimer; MinBand, MaxBand: TBand);
begin
   Inherited;
   TerminatorCode := ';';
   FComm.DataBits := db8BITS;
   FComm.StopBits := sb1BITS;
   FComm.Parity := ptNONE;
   FComm.HwFlow := hfNONE;
   FComm.SwFlow := sfNONE;
   FComm.EnableDTROnOpen := False;
   FCwReverse := False;
end;

destructor TElecraft.Destroy;
begin
   inherited;
end;

procedure TElecraft.AntSelect(no: Integer);
begin
   case no of
      0: Exit;
      1: WriteData('AN1;');
      2: WriteData('AN2;');
   end;
end;

procedure TElecraft.ExecuteCommand(S: AnsiString);
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

   // 000000000111111111122222222223333333
   // 123456789012345678901234567890123456
   // IF12345678901*****+yyyyrx*00tmvspbd1*;
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
            FCwReverse := False;
         end;

         '7': begin
            M := mCW;
            FCwReverse := True;
         end;

         '4': begin
            M := mFM;
         end;

         '5': begin
            M := mAM;
         end;

         '6', '9': begin
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
               FCwReverse := False;
            end;
         '7': begin
               M := mCW;
               FCwReverse := True;
            end;
         '4':
            M := mFM;
         '5':
            M := mAM;
         '6', '9':
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
end;

// AI (Auto-Information; GET/SET)
// SET/RSP format: AIn; where n is 0-3. See Meta-commands for details. Note: The AI power-up default is
// normally AI0, corresponding to K3 menu setting CONFIG:AUTOINF = NOR. AUTOINF can also be set to
// AUTO 1, which makes the default AI1 on power-up. This is useful for K3s controlling a StepIR antenna, etc.
procedure TElecraft.Initialize();
begin
   Inherited;
   WriteData('AI1;');
end;

// IF (Transceiver Information; GET only)
// RSP format: IF[f]*****+yyyyrx*00tmvspbd1*; where the fields are defined as follows:
// [f] Operating frequency, excluding any RIT/XIT offset (11 digits; see FA command format)
// * represents a space (BLANK, or ASCII 0x20)
// + either "+" or "-" (sign of RIT/XIT offset)
// yyyy RIT/XIT offset in Hz (range is -9999 to +9999 Hz when computer-controlled)
// r 1 if RIT is on, 0 if off
// x 1 if XIT is on, 0 if off
// t 1 if the K3 is in transmit mode, 0 if receive
// m operating mode (see MD command)
// v receive-mode VFO selection, 0 for VFO A, 1 for VFO B
// s 1 if scan is in progress, 0 otherwise
// p 1 if the transceiver is in split mode, 0 otherwise
// b Basic RSP format: always 0; K2 Extended RSP format (K22): 1 if present IF response
// is due to a band change; 0 otherwise
// d Basic RSP format: always 0; K3 Extended RSP format (K31): DATA sub-mode,
// if applicable (0=DATA A, 1=AFSK A, 2= FSK D, 3=PSK D)
// The fixed-value fields (space, 0, and 1) are provided for syntactic compatibility with existing software.
procedure TElecraft.InquireStatus;
begin
   WriteData('IF;');
end;

procedure TElecraft.ParseBufferString; // same as ts690
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

procedure TElecraft.Reset;
begin
end;

procedure TElecraft.RitClear;
begin
   Inherited;
   WriteData('RC;');
end;

// FA and FB (VFO A/B Frequency; GET/SET)
// SET/RSP format: FAxxxxxxxxxxx; or FBxxxxxxxxxxx; where xxxxxxxxxxx is the frequency in Hz. Example:
// FA00014060000; sets VFO A to 14060 kHz. The Hz digit is ignored if the K3 is not in FINE mode (1-Hz tuning;
// use SWT49). If the specified frequency is in a different amateur band than the present one, the K3 will change to
// the new band, and will automatically report the new values of parameters that may have changed7
// . Notes: (1) Band
// changes typically take 0.5 seconds; all command handling is deferred until this process is complete. (2) If the
// specified frequency is over 30 MHz and is within a valid transverter band (as specified by the operator using the
// K3's XVTR menu entries), the K3 will switch to that transverter band. If the specified frequency is outside the
// range of 500 kHz-30 MHz and 48-54 MHz, the K3 will switch to the amateur band closest to the requested one, and
// the last-used VFO A and VFO B values for that band will be retrieved. (KSYN3A extends low range to 100 kHz.)
// If the VFOs are linked (non-SPLIT), FA also sets VFO B to the same frequency as VFO A.
procedure TElecraft.SetFreq(Hz: TFrequency; fSetLastFreq: Boolean);
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

// MD $ (Operating Mode; GET/SET)
// SET/RSP format: MDn; or MD$n; where n is 1 (LSB), 2 (USB), 3 (CW), 4 (FM), 5 (AM), 6 (DATA), 7 (CWREV), or 9 (DATA-REV). Notes: (1) K3 only: In Diversity Mode (accessed by holding SUB), sending MDn;
// sets both main and sub mode to n. (2) DATA and DATA-REV select the data sub-mode that was last in effect on
// the present band. (To read/set data sub-mode, use DT.) The norm/rev conditions for the K3fs data sub-modes are
// handled in two pairs at present: DATA A/PSK D, and AFSK A/FSK D. E.g., if the radio is set up for DATA A
// mode, alternating between MD6 and MD9 will cause both DATA A and PSK D to be set to the same
// normal/reverse condition. In K2 command modes 1 and 3 (K21 and K23), the RSP message converts modes 6 and
// 7 (DATA and DATA-REV) to modes 1 and 2 (LSB and USB). This may be useful with existing software
// applications that don't handle DATA modes correctly. (3) If a KX3/KX2 is in DUAL RX (dual watch) mode, MD$
// returns the value for MD. (4) FM mode does not apply to the KX2.
procedure TElecraft.SetMode(Q: TQSO);
var
   Command: AnsiString;
   para: AnsiChar;
begin
   Inherited SetMode(Q);

   { 1=LSB, 2=USB, 3=CW, 4=FM, 5=AM, 6=DATA, 7=CW-R, 9=DATA=R }
   para := '3';
   case Q.Mode of
      mSSB:
         if Q.Band <= b7 then
            para := '1'
         else
            para := '2';
      mCW:
         if FCwReverse then
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

// RT (RIT Control; GET/SET)
// SET/RSP format: RTn; where n is 0 (RIT OFF) or 1 (RIT ON). RIT is disabled in QRQ CW mode.
procedure TElecraft.SetRit(flag: Boolean);
begin
   Inherited;

   if flag = True then begin
      WriteData('RT1;');
   end
   else begin
      WriteData('RT0;');
   end;
end;

// RO (RIT/XIT Offset, Absolute; GET/SET)
// SET/RSP format: ROsnnnn; where s is +/- and nnnn is 0000-9999. s can also be a space in lieu of +.
procedure TElecraft.SetRitOffset(offset: Integer);
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

      CMD := AnsiString('RO-' + RightStr('0000' + IntToStr(Abs(offset)), 4) + ';');
      WriteData(CMD);
   end
   else if offset > 0 then begin
      WriteData('RC;');

      CMD := AnsiString('RO+' + RightStr('0000' + IntToStr(Abs(offset)), 4) + ';');
      WriteData(CMD);
   end;

   Inherited;
end;

// FR (RX VFO Assignment [K2 only] and SPLIT Cancel; GET/SET)
// SET/RSP format: FRn; where n is ignored in the K3 case because VFO A is always active for receive mode (the
// K3 cannot emulate the K2fs VFO A/B behavior). Any FR SET cancels SPLIT mode.
// FT (TX VFO Assignment and optional SPLIT Enable; GET/SET)
// SET/RSP format: FTn; where n specifies the transmit-mode VFO assignment: 0 for VFO A, 1 for VFO B.
// If B (1) is selected for transmit, the K3 will enter SPLIT (except when split is N/A). Use FR0; to cancel SPLIT.
procedure TElecraft.SetVFO(i: Integer); // A:0, B:1
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

// XT (XIT Control; GET/SET)
// SET/RSP format: XTn; where n is 0 (XIT OFF) or 1 (XIT ON). XIT is disabled in QRQ CW mode.
procedure TElecraft.SetXit(flag: Boolean);
begin
   Inherited;

   if flag = True then begin
      WriteData('XT1;');
   end
   else begin
      WriteData('XT0;');
   end;
end;

end.
