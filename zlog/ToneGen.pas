unit ToneGen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  ,mmsystem,Math;

//default values
const
     AttDef=10;
     HoldDef=5;
     DecDef=20;
     SusDef=50;
     RelDef=30;
     DurDef=100;
     FreDef=440;
     VolDef=100;
     AMLevels=7;
     MaxFreq=20000;
     MinFreq=20;



type
  TTGPercentage = 0..100;
  TTGWave = (tgSine,tgSquare,tgTriangle,tgSawtooth,tgNoise);
  TTGResolution = (tg16Bit,tg8Bit);
  TTGQuality = (tgHiQ,tgLoQ);
  TTGAMLevel = (tgAMLevel1,tgAMLevel2,tgAMLevel3,tgAMLevel4,tgAMLevel5,tgAMLevel6,tgAMLevel7,tgAMLevel8);
  TToneGen = class(TComponent)

  private
    { Private declarations }
    HasChanged: bool;
    HasADSRChanged: bool;
    HasToneChanged: bool;
    HasStopped: bool;
    Buffer: PAnsiChar;
    BufferSize: Integer;
    fFrequency: Smallint;
    fDuration: Smallint;
    fWaveform: TTGWave;
    fAttack: Smallint;
    fHold: Smallint;
    fDecay: Smallint;
    fSustain: Smallint;
    fRelease: Smallint;
    fAsync: bool;
    fLoop: bool;
    fResolution: TTGResolution;
    fQuality: TTGQuality;
    fLeftVolume: Smallint;
    fRightVolume: Smallint;
    DeviceID: Integer;
    fStereo: bool;
    fAMAmplitude: Smallint;
    fAMWaveform: TTGWave;
    fAMFrequency: Single;
    fAMUseMultiplier: bool;
    Octave: Integer;

    fAMLevel: TTGAMLevel;
    AMAmpArray: array[0..AMLevels] of Smallint;
    AMWaveArray: array[0..AMLevels] of TTGWave;
    AMFreqArray: array[0..AMLevels] of Single;
    AMOctaves: array[0..AMLevels] of Integer;

    hWave_out: THandle;

    procedure SetFrequency(Freq: Smallint);
    procedure SetDuration(Dur: Smallint);
    procedure SetWaveform(Wave: TTGWave);
    procedure SetAttack(Att: Smallint);
    procedure SetHold(Hld: Smallint);
    procedure SetDecay(Decy: Smallint);
    procedure SetSustain(Sus: Smallint);
    procedure SetRelease(Rel: Smallint);
    procedure SetResolution(Res: TTGResolution);
    procedure SetQuality(Qual: TTGQuality);
    function GetVolume: DWORD;
    procedure SetVolume;
    procedure SetLeftVolume(LVol: Smallint);
    procedure SetRightVolume(RVol: Smallint);
    function CreateWaveform(DoADSR: bool): bool;
    procedure ADSRWaveform(Buf: PAnsiChar;BufSize: Integer; DoStereo: bool);
    procedure PlayWave;
    function LimitValue(lower,upper,val: Smallint):Smallint;
    function GetPercentage(PC: Smallint): Smallint;
    procedure SetStereo(bstereo: bool);
    procedure SetAMLevel(level: TTGAMLevel);
    procedure SetAMAmplitude(Amp: Smallint);
    procedure SetAMWaveform(Wave: TTGWave);
    procedure SetAMFrequency(Freq: Single);
    procedure SetAMMultiplier(setit: bool);

    //DefineProperties procedures
    procedure ReadAMArrayData(Stream: TStream);
    procedure WriteAMArrayData(Stream: TStream);

    class function InstanceCount: Integer;
    class function GetOriginalVolume: DWORD;


  protected
    { Protected declarations }
    //write array data
    procedure DefineProperties(Filer:TFiler);override;
  public
    { Public declarations }

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property Frequency: Smallint read fFrequency write SetFrequency default FreDef;
    property Duration: Smallint read fDuration write SetDuration default DurDef;
    property Waveform: TTGWave read fWaveform write SetWaveform default tgSine;
    property Attack: Smallint read fAttack write SetAttack default AttDef;
    property Hold: Smallint read fHold write SetHold default HoldDef;
    property Decay: Smallint read fDecay write SetDecay default DecDef;
    property Sustain: Smallint read fSustain write SetSustain default SusDef;
    property Release: Smallint read fRelease write SetRelease default RelDef;
    property Async: bool read fAsync write fAsync default true;
    property Loop: bool read fLoop write fLoop default false;
    property Resolution: TTGResolution read fResolution write SetResolution default tg16Bit;
    property Quality: TTGQuality read fQuality write SetQuality default tgHiQ;
    property LeftVolume: Smallint read fLeftVolume write SetLeftVolume default VolDef;
    property RightVolume: Smallint read fRightVolume write SetRightVolume default VolDef;
    property Stereo: bool read fStereo write SetStereo default false;
    property AMLevel: TTGAMLevel read fAMLevel write SetAMLevel default tgAMLevel1;
    property AMAmplitude: Smallint read fAMAmplitude write SetAMAmplitude nodefault;
    property AMWaveform: TTGWave read fAMWaveform write SetAMWaveform nodefault;
    property AMFrequency: Single read fAMFrequency write SetAMFrequency nodefault;
    property AMUseMultiplier: bool read fAMUseMultiplier write SetAMMultiplier default true;

    procedure PlayTest();
    procedure Play;
    procedure PlayADSR;
    procedure Stop;
    procedure PresetVolume;
    procedure Prepare;
    procedure PrepareADSR;
    procedure ResetAM;
    procedure SetAMParameter(Level: TTGAMLevel;Freq: Single; Amp: Smallint; Wav:TTGWave);
    function GetDataBuffer: PAnsiChar;
    function ExportFile(FileName: String): bool;
    function SetNote(NoteString:String): Integer;
    function SetAMNote(Level: TTGAMLevel;NoteString:String): Single;

    procedure SaveToStream(Stream: TStream);
  end;

type
{ format of WAV file header }
 TWavHeader = record         { parameter description }
  rId             : longint; { 'RIFF'  4 characters }
  rLen            : longint; { length of DATA + FORMAT chunk }
  { FORMAT CHUNK }
  wId             : longint; { 'WAVE' }
  fId             : longint; { 'fmt ' }
  fLen            : longint; { length of FORMAT DATA = 16 }
  { format data }
  wFormatTag      : word;    { $01 = PCM }
  nChannels       : word;    { 1 = mono, 2 = stereo }
  nSamplesPerSec  : longint; { Sample frequency ie 11025}
  nAvgBytesPerSec : longint; { = nChannels * nSamplesPerSec *
                                (nBitsPerSample/8) }
  nBlockAlign     : word;    { = nChannels * (nBitsPerSAmple / 8 }
  wBitsPerSample  : word;    { 8 or 16 }
  { DATA CHUNK }
  dId             : longint; { 'data' }
  wSampleLength   : longint; { length of SAMPLE DATA }
  { sample data : offset 44 }
   { for 8 bit mono = s[0],s[1]... :byte}
   { for 8 bit stereo = sleft[0],sright[0],sleft[1],sright[1]... :byte}
   { for 16 bit mono = s[0],s[1]... :word}
   { for 16 bit stereo = sleft[0],sright[0],sleft[1],sright[1]... :word}
 end;
 PTWavHeader = ^TWavHeader;

procedure Register;

implementation

var
   TTGCount: Integer=0;
   OriginalVolume: DWORD=0;

procedure Register;
begin
  RegisterComponents('Samples', [TToneGen]);
end;


//limit value
function TToneGen.LimitValue(lower,upper,val: Smallint):Smallint;
var
   msg:String;

begin
if (val>=lower) and (val<=upper) then
   begin
   Result:=val;
   Exit;
   end;

//error message?
if csDesigning in ComponentState then
   begin
   msg:='Value must be between '+IntToStr(lower)+' and '+IntToStr(upper);
   MessageBox(0,PChar(msg),'Error',MB_OK or MB_ICONERROR);
   end;

if val>upper then
   Result:=upper
else
   Result:=lower;


end;


//limit values  0 to 100 **********************************************
//if designing give warning
//force to limits
function TToneGen.GetPercentage(PC: Smallint):Smallint;
begin

Result:=LimitValue(0,100,PC);
end;

//preset tone and volume settings **********************************************
procedure TToneGen.Prepare;
begin

//setup volume
SetVolume;

//create wave
CreateWaveform(false);

end;

//set mono or stereo **********************************************
procedure TToneGen.SetStereo(bstereo: bool);
begin
HasChanged:=true;
fStereo:=bstereo;
end;

//preset ADSR and volume settings **********************************************
procedure TToneGen.PrepareADSR;
begin

//setup volume
SetVolume;

//create wave
CreateWaveform(true);

end;

//preset volume levels **********************************************
procedure TToneGen.PresetVolume;
begin

//setup volume
SetVolume;

end;

//play sound **********************************************
procedure TToneGen.PlayWave;
var
   Flags: DWORD;

begin

//stop any sounds first
Stop;

//setup volume
SetVolume;

Flags:=SND_SYNC;

if fAsync then Flags:=SND_ASYNC;

if fLoop then Flags:=SND_ASYNC or SND_LOOP;

Flags:=Flags or SND_MEMORY;


//play data in buffer
if Buffer<>nil then
   PlaySound(PChar(Buffer), 0, Flags);

end;

procedure TToneGen.PlayTest();
var
   status: MMRESULT;
   pcm: TWaveFormatEx;
   pwh: PTWavHeader;
   wh: TWaveHdr;
   err_text: array [0..100] of char;
begin
//   PlaySound(PChar(Buffer), 0, SND_ASYNC or SND_LOOP or SND_MEMORY);
   pcm.wFormatTag          := PTWavHeader(Buffer)^.wFormatTag;
   pcm.nChannels           := PTWavHeader(Buffer)^.nChannels;
   pcm.nSamplesPerSec      := PTWavHeader(Buffer)^.nSamplesPerSec;
   pcm.nAvgBytesPerSec     := PTWavHeader(Buffer)^.nAvgBytesPerSec;
   pcm.nBlockAlign         := PTWavHeader(Buffer)^.nBlockAlign;
   pcm.wBitsPerSample      := PTWavHeader(Buffer)^.wBitsPerSample;

   status := waveOutOpen(@hWave_out, wave_mapper, @pcm, 0, 0, CALLBACK_NULL);
   if status <> MMSYSERR_NOERROR then begin
      MessageBox(0, 'erro waveOutOpen()', PChar('TEST'), MB_OK);
      Exit;
   end;

   wh.lpData := PAnsiChar(Buffer + SizeOf(TWavHeader));
   wh.dwBufferLength := BufferSize - (SizeOf(TWavHeader) + 32);
   wh.dwBytesRecorded := 0;   //wh.dwBufferLength;
   wh.dwUser := 0;
   wh.dwFlags := 0;  //WHDR_BEGINLOOP or WHDR_ENDLOOP;
   wh.dwLoops := 1;
   wh.lpNext := nil;
   wh.reserved := 0;

   waveOutPrepareHeader(hWave_out, @wh, SizeOf (TWaveHdr));

   status := waveOutWrite(hWave_out, @wh, SizeOf(TWaveHdr));
//   waveOutReset(hWave_out);
   if status <> MMSYSERR_NOERROR then begin
      waveOutGetErrorText (status, err_text, SizeOf (err_text));
      MessageBox(0, PChar('erro waveOutWrite()' + err_text), PChar('TEST'), MB_OK);
      Exit;
   end;
end;

//play simple tone **********************************************
procedure TToneGen.Play;
begin

if HasChanged or HasToneChanged then
   CreateWaveform(false);

HasStopped:=false;

PlayWave;

//flag as having finished?
HasStopped:=not(Async or Loop);

end;

//play enveloped tone **********************************************
procedure TToneGen.PlayADSR;
begin

if HasChanged or HasADSRChanged then
   CreateWaveform(true);

HasStopped:=false;

PlayWave;

//flag as having finished?
HasStopped:=not(Async or Loop);

end;

//stop sound **********************************************
procedure TToneGen.Stop;
begin

waveOutReset(hWave_out);

//stop any sounds
PlaySound(nil, 0, 0);

//flag as having finished
HasStopped:=true;
end;


//get waveform volume **********************************************
function TToneGen.GetVolume: DWORD;
var
   vol: DWORD;
   wocs: WAVEOUTCAPS;
   CanDoLR: bool;

begin
vol:=0;

//can do left & right?
waveOutGetDevCaps(DeviceID,@wocs,sizeof(WAVEOUTCAPS));
if(wocs.dwFormats and WAVECAPS_LRVOLUME)>0 then
    CanDoLR:=true
else
    CanDoLR:=false;

//get volume?
waveOutGetVolume(DeviceID,@vol);

//copy mono level to right channel?
if not CanDoLR then
   vol:=vol+(vol shl $10);

Result:=vol;
end;

//set waveform volume **********************************************
procedure TToneGen.SetVolume;
var
   newvol: DWORD;
begin
//combine percentages
newvol:=(($ffff * fLeftVolume) div 100)+((($ffff * fRightVolume) div 100) shl $10);

//set volume
waveOutSetVolume(DeviceID,newvol);
end;

//return original volume setting **********************************************
class function TToneGen.GetOriginalVolume: DWORD;
begin
Result:=OriginalVolume;
end;

//constructor **********************************************
constructor TToneGen.Create(AOwner: TComponent);
var
   i: Integer;

begin
Inherited Create(AOwner);

HasChanged:=true;
HasADSRChanged:=true;
HasToneChanged:=true;
HasStopped:=true;

Buffer:=nil;
BufferSize:=0;

fFrequency:=FreDef;
fDuration:=DurDef;
fWaveform:=tgSine;
fAttack:=AttDef;
fHold:=HoldDef;
fDecay:=DecDef;
fSustain:=SusDef;
fRelease:=RelDef;
fAsync:=true;
fLoop:=false;
fResolution:=tg16Bit;
fQuality:=tgHiQ;
fLeftVolume:=VolDef;
fRightVolume:=VolDef;
fStereo:=false;
fAMUseMultiplier:=true;
Octave:=4;


//amplitude modulation settings
fAMLevel:=tgAMLevel1;
ResetAM;
fAMFrequency:=AMFreqArray[Integer(fAMLevel)];
fAMWaveform:=AMWaveArray[Integer(fAMLevel)];
fAMAmplitude:=AMAmpArray[Integer(fAMLevel)];
for i:=0 to AMLevels do
    begin
    AMOctaves[i]:=Octave;
    end;

DeviceID:=0;

//store volume settings
if (InstanceCount=0) and not(csDesigning in ComponentState)then
   begin
   //store original settings
   OriginalVolume:=GetVolume;

   //initialise volume
   SetVolume;

   end;

//increment instance count
Inc(TTGCount);


end;

//destructor **********************************************
destructor TToneGen.Destroy;
var
   OV: DWORD;

begin

//stop playing
Stop;

//de-allocate memory
If Buffer<>nil then
   begin
   FreeMem(Buffer);
   Buffer:=nil;
   BufferSize:=0;
   end;

//decrement instance count
Dec(TTGCount);

//restore volume settings
if (TTGCount=0)  and not(csDesigning in ComponentState) then
   begin
   OV:=GetOriginalVolume;
   waveOutSetVolume(DeviceID,OV);
   end;


inherited Destroy;
end;

//instance count **********************************************
class function TToneGen.InstanceCount: Integer;
begin
Result:=TTGCount;
end;

//set left volume **********************************************
procedure TToneGen.SetLeftVolume(LVol: Smallint);
begin
fLeftVolume:=GetPercentage(LVol);

//initialise volume
if (csLoading in ComponentState) or HasStopped then
   SetVolume;

end;

//set right volume **********************************************
procedure TToneGen.SetRightVolume(RVol: Smallint);
begin
fRightVolume:=GetPercentage(RVol);

//initialise volume
if (csLoading in ComponentState) or HasStopped then
   SetVolume;

end;

//set frequency **********************************************
procedure TToneGen.SetFrequency(Freq: Smallint);
begin
HasChanged:=true;
fFrequency:=LimitValue(MinFreq,MaxFreq,Freq);
end;

//duration **********************************************
procedure TToneGen.SetDuration(Dur: Smallint);
begin
HasChanged:=true;
fDuration:=LimitValue(10,$7FFF,Dur);
end;

//wave type **********************************************
procedure TToneGen.SetWaveform(Wave: TTGWave);
begin
HasChanged:=true;
fWaveform:=Wave;
end;

//attack **********************************************
procedure TToneGen.SetAttack(Att: Smallint);
begin
HasADSRChanged:=true;
fAttack:=GetPercentage(Att);
end;

//hold **********************************************
procedure TToneGen.SetHold(Hld: Smallint);
begin
HasADSRChanged:=true;
fHold:=GetPercentage(Hld);
end;

//decay **********************************************
procedure TToneGen.SetDecay(Decy: Smallint);
begin
HasADSRChanged:=true;
fDecay:=GetPercentage(Decy);
end;

//sustain **********************************************
procedure TToneGen.SetSustain(Sus: Smallint);
begin
HasADSRChanged:=true;
fSustain:=GetPercentage(Sus);
end;

//release **********************************************
procedure TToneGen.SetRelease(Rel: Smallint);
begin
HasADSRChanged:=true;
fRelease:=GetPercentage(Rel);
end;

//8 or 16 bit **********************************************
procedure TToneGen.SetResolution(Res: TTGResolution);
begin
HasChanged:=true;
fResolution:=Res;
end;

//quality **********************************************
procedure TToneGen.SetQuality(Qual: TTGQuality);
begin
HasChanged:=true;
fQuality:=Qual;
end;


//create wave header ****************************************
procedure CreateWavHeader( stereo: bool;{ t=stereo  f=mono }
                     hires : bool;    { t=16bits, f=8 }
                     hirate       : bool; { sample rate t=44100 f=22050}
                     datasize: longint; {date block size}
                     var wh: TWavHeader { Wavheader ref } );
var
   resolution,channels: word;
   rate: longint;

begin

//stereo/mono?
if stereo=true then
   channels:=2
else
   channels:=1;

//16bit/8bit?
if hires=true then
   resolution:=16
else
    resolution:=8;

//44100/22050 bps?
if hirate=true then
   rate:=96000
else
    rate:=44100;

 wh.rId             := $46464952; { 'RIFF' }
 wh.rLen            := datasize+36;        { length of sample + format }
 wh.wId             := $45564157; { 'WAVE' }
 wh.fId             := $20746d66; { 'fmt ' }
 wh.fLen            := 16;        { length of format chunk }
 wh.wFormatTag      := 1;         { PCM data }
 wh.nChannels       := channels;  { mono/stereo }
 wh.nSamplesPerSec  := rate;      { sample rate }
 wh.nAvgBytesPerSec := channels*rate*(resolution div 8);
 wh.nBlockAlign     := channels*(resolution div 8);
 wh.wBitsPerSample  := resolution;{ resolution 8/16 }
 wh.dId             := $61746164; { 'data' }
 wh.wSampleLength   := datasize;         { sample size }

end;

//**********************************************************************
//modify data to ADSR settings
procedure TToneGen.ADSRWaveform(Buf: PAnsiChar;BufSize: Integer; DoStereo: bool);
var
   Total,i: Integer;
   Start,Samples,Cnt: Cardinal;
   BufValue: Integer;
   SampleFactor,SusFactor: Real;
   Env,EnvDur: Cardinal;
   SusDuration: Cardinal;
   iBuffer: ^SmallInt;
   ResFactor: Integer;
   HoldV,AttackV,DecayV,SustainV,ReleaseV: Integer;
   HiRes: bool;
   ByteVal: AnsiChar;
   WordVal: Smallint;
begin
   iBuffer := nil;
   SampleFactor := 0;

if fResolution=tg16Bit then
   begin
   HiRes:=true;
   end
else
   begin
   HiRes:=false;
   end;

AttackV:=fAttack;
HoldV:=fHold;
DecayV:=fDecay;
SustainV:=fSustain;
ReleaseV:=fRelease;

//1/2 no of samples for 16bit
if HiRes then
   ResFactor:=2
else
   ResFactor:=1;

//1/2 no of samples for stereo
if DoStereo then
   ResFactor:=ResFactor*2;

Total:=AttackV+HoldV+DecayV+ReleaseV;

//normalise percentages
if Total>100 then
   begin
   AttackV:=AttackV * 100 div Total;
   HoldV:=HoldV * 100 div Total;
   DecayV:=DecayV * 100 div Total;
   ReleaseV:=100-(AttackV+HoldV+DecayV);
//   SusDuration:=0;
   end;

SusDuration:=100-(AttackV+HoldV+DecayV+ReleaseV);
Samples:=SusDuration * BufSize div (100 * ResFactor);

//sustain level
SusFactor:=SustainV/100;

if Samples<1 then
    begin
    //SustainV:=0;
    end;

Start:=0;

if HiRes then
  begin
  //create 16bit pointer
  iBuffer:=Pointer(Buf);
end;


for Env:=0 to 4 do
 begin

 //envelope entry
 case Env of
      0://Attack
        begin
        EnvDur:=AttackV;
        Samples:=EnvDur * BufSize div (100 * ResFactor);
        if Samples>0 then
           SampleFactor:=1/Samples
        else
            EnvDur:=0;
        end;

      1: //Hold
        begin
        EnvDur:=HoldV;
        Samples:=EnvDur * BufSize div (100 * ResFactor);
        if Samples>0 then
           SampleFactor:=1
        else
            EnvDur:=0;
         end;

      2://Decay
        begin
        EnvDur:=DecayV;
        Samples:=EnvDur * BufSize div (100 * ResFactor);
        if Samples>0 then
           SampleFactor:=(100-SustainV)/Samples/100
        else
            EnvDur:=0;
         end;
      3://Sustain
        begin
        EnvDur:=SusDuration;
        if ReleaseV=0 then
           begin
           Samples:=BufSize div ResFactor;
           if DoStereo then
              Samples:=max(0,Samples-(Start div 2))
           else
              Samples:=max(0,Samples-Start);
           end
        else
           begin
           Samples:=EnvDur * BufSize div (100 * ResFactor);
           end;

        SampleFactor:=SusFactor;
        end;
      else//Release
          begin
          EnvDur:=ReleaseV;
          Samples:=BufSize div ResFactor;

          if DoStereo then
             Samples:=Samples-(Start div 2)
          else
              Samples:=Samples-Start;

          if Samples>0 then
             SampleFactor:=SusFactor/Samples
          else
             begin
             EnvDur:=0;
             Samples:=0;
             end;

          end;
 end;

 //process envelope entry
 if EnvDur >0 then
    begin
    if DoStereo then Samples:=Samples*2;
      Cnt:=0;
      i:=min(Start,BufSize);
      while i<=min(BufSize,Start+Samples) do
        begin

        if HiRes then //16bit
           begin
           BufValue:=((iBuffer)^);
           end
        else//8bit
           begin
           BufValue:=Integer((Buf+i)^);
           BufValue:=BufValue-$80;
           end;

        case Env of
             0://Attack
               begin
               BufValue:=Trunc(Cnt * BufValue * SampleFactor);
               end;

             1://Hold
               begin
               //no change to value
               end;

             2://Decay
               begin
               BufValue:=BufValue-Trunc(Cnt * BufValue * SampleFactor);
               end;

             3://Sustain
               begin
               BufValue:=Trunc(BufValue * SampleFactor);
               end;

             4://Release
               begin
               if DoStereo then
                  BufValue:=Trunc(((Samples div 2)-Cnt) * BufValue * SampleFactor)
               else
                  BufValue:=Trunc((Samples-Cnt) * BufValue * SampleFactor);
               end;

        end;

        if HiRes then //16bit
           begin
           WordVal:=SmallInt(BufValue);
           (iBuffer)^:=WordVal;
           Inc(iBuffer);

           //stereo?
           if DoStereo then
              begin
              (iBuffer)^:=WordVal;
              Inc(iBuffer);
              Inc(i);
              end;

           end
        else//8bit
            begin
            ByteVal := AnsiChar($80+BufValue);
            (Buf+i)^ := AnsiChar(ByteVal);

            //stereo?
            if DoStereo then
               begin
               Inc(i);
               (Buf+i)^ := ByteVal;
               end;

            end;

        Inc(i);
        Inc(Cnt);

        end;

    Start:=Start+Samples+1;

    end;
 end;

HasADSRChanged:=false;
HasChanged:=false;
HasToneChanged:=true;

end;


//**********************************************************************
//create waveform
function TToneGen.CreateWaveform(DoADSR: bool): bool;
var
   wh: TWavHeader;
   AllocSize,BufSize,HdrSize,i: Integer;
   DataBuf: PAnsiChar;
   MidValue,MaxVal,MinVal,CalcVal: Real;
   BytesPerSample,SampsPerInterval: Cardinal;
   DoStereo: bool;
   CycleCount,cnt,CycleMidPoint,SamplesPerCycle: Cardinal;
   FPSamplesPerCycle,FPVerticalStep,FPVerticalAdd :Real;
   HiRes,HiQ: bool;
   ByteVal: Integer;
   iBuffer: ^SmallInt;
   WordVal: Smallint;
   AmpPC: Integer;
   Levels,Total: Integer;
   wFrequency: Smallint;
   wWaveform: TTGWave;
   OldRandSeed: Longint;
   //wfh: Integer;
begin
   DataBuf := nil;

//same random pattern each time
OldRandSeed:=RandSeed;
RandSeed:=1;

//mono or stereo?
DoStereo:=fStereo;

//size of header record
HdrSize:=sizeof(TWavHeader);

//no of bytes per sample
if fResolution=tg16Bit then
   begin
   BytesPerSample:=2;
   HiRes:=true;
   MidValue:=0;
   end
else
    begin
    BytesPerSample:=1;
    HiRes:=false;
    MidValue:=128;
    end;

//no of samples per S/100
if fQuality=tgHiQ then
   begin
   SampsPerInterval:=960;
   HiQ:=true;
   end
else
   begin
   SampsPerInterval:=441;
   HiQ:=false;
   end;


//buffer size
BufSize:=(BytesPerSample * Duration * SampsPerInterval) div 10;

//twice as big for stereo
if DoStereo then BufSize:=BufSize*2;

//create header
CreateWavHeader(DoStereo,HiRes,HiQ,BufSize,wh);

//allocate memory for data buffer
if Buffer<>nil then
   begin
   FreeMem(Buffer);
   Buffer:=nil;
   BufferSize:=0;
   end;

//stop any sounds
PlaySound(nil, 0, 0);

try
   AllocSize:=BufSize+HdrSize+32;
   Buffer:=AllocMem(AllocSize);
except
   Result:=false;
   Exit;
end;

if (Buffer=nil) or (BufSize=0) then
   begin
   Result:=false;
   Exit;
   end;

//initialise
BufferSize:=AllocSize;
FillMemory(Buffer,AllocSize,Trunc(MidValue));
//FillMemory(Buffer, AllocSize, 0);

//copy header data to start of buffer
CopyMemory(Buffer,@wh,HdrSize);

//amplitude percentages
Total:=0;
for i:=0 to AMLevels do
    begin
    Total:=Total+AMAmpArray[i];
    end;

//-------------------------------
//start of creation loop
for Levels:=-1 to AMLevels do
    begin

    if Levels=-1 then //base frequency
       begin
       AmpPC:=100-Total;
       wFrequency:=Frequency;
       wWaveform:=fWaveForm;
       end
    else //AM levels
       begin
       AmpPC:=AMAmpArray[Levels];
       if Total>100 then AmpPC:=AmpPC*100 div Total;

       //frequency mutiplier or absolute?
       if AMUseMultiplier then
          begin
          wFrequency:=LimitValue(MinFreq,MaxFreq,Trunc(AMFreqArray[Levels]*fFrequency));
          end
       else //absolute
           begin
           wFrequency:=Trunc(AMFreqArray[Levels]);
           end;

       //waveform
       wWaveform:=AMWaveArray[Levels];

       end;

    //loop again if no amplitude
    if (AmpPC<=0) or (wFrequency<=0) then Continue;

    if fResolution=tg16Bit then
       begin
       MaxVal:=65534 * AmpPC /100;
       MinVal:=-32767 * AmpPC /100;
       end
    else
        begin
        MaxVal:=254 * AmpPC /100;
        MinVal:=-127 * AmpPC /100;
        end;

    //floating point samples per cycle
    FPSamplesPerCycle:=(SampsPerInterval*100)/wFrequency;

    //samples per cycle
    SamplesPerCycle:=Trunc(FPSamplesPerCycle);

    //CycleMidPoint of cycle
    //CycleMidPoint:=SamplesPerCycle div 2;
    CycleMidPoint:=Trunc(FPSamplesPerCycle+0.5) div 2;

    //offset to data area
    DataBuf:=Buffer+HdrSize;

    //counter to step through cycles
    CycleCount:=1;

    FPVerticalStep:=0;
    FPVerticalAdd:=0;

    //write wav data to buffer

    //sine step values
    if wWaveform=tgSine then
       begin
       FPVerticalStep:=(pi*2)/SamplesPerCycle;

       end;

    //sq step values
    if wWaveform=tgSquare then
       begin
       MaxVal:=MaxVal / 2;;
       end;

    //triangle vertical step size
    if wWaveform=tgTriangle then
       begin
       FPVerticalStep:=MinVal;
       FPVerticalAdd:=(MaxVal / CycleMidPoint);

       end;

    //sawtooth vertical step size
    if wWaveform=tgSawtooth then
       begin
       FPVerticalStep:=MinVal;
       FPVerticalAdd:=(MaxVal/SamplesPerCycle);

       end;


    cnt:=0;
    i:=0;
    while i<BufSize do begin
          //select wave type
          case wWaveform of
              //sine
                  tgSine:
                  begin
                  CalcVal:=Trunc((sin(cnt * FPVerticalStep))/2*MaxVal);
                  end;

                  //square
                  tgSquare:
                  begin
                  if cnt<CycleMidPoint then
                     CalcVal:=MinVal
                  else
                     CalcVal:=MaxVal;

                  end;

                  //triangle
                  tgTriangle:
                  begin
                  if cnt<CycleMidPoint then
                     begin
                     CalcVal:=Trunc(FPVerticalStep);
                     FPVerticalStep:=FPVerticalStep+FPVerticalAdd;
                     end
                  else
                      begin
                      CalcVal:=Trunc(FPVerticalStep);
                      FPVerticalStep:=FPVerticalStep-FPVerticalAdd;
                      if FPVerticalStep<MinVal then FPVerticalStep:=MinVal;
                      //if (CalcVal+MidValue)>MaxVal then CalcVal:=MaxVal+MidValue;
                      end;
                  end;

                  //sawtooth
                  tgSawtooth:
                  begin

                  CalcVal:=Trunc(FPVerticalStep);
                  FPVerticalStep:=FPVerticalStep+FPVerticalAdd;

                  end;

                  //noise
                  else
                      CalcVal:=random(Trunc(MaxVal+1))+MinVal

          end;

          //offset
          CalcVal:=MidValue+CalcVal;

          //8bit or 16?
          if HiRes then begin
                     iBuffer := Pointer(DataBuf + i);
                     WordVal := iBuffer^;
                     WordVal := WordVal + Trunc(CalcVal);
                     iBuffer^ := WordVal;
                     Inc(i,2);

                     //stereo?
                     if DoStereo then
                         begin
                         iBuffer := Pointer(DataBuf + i);
                         (iBuffer)^ := WordVal;
                         Inc(i,2);
                         end

                     end
          else //8bit
                      begin
                      ByteVal := Integer((DataBuf + i)^) - Trunc(MidValue);
                      ByteVal := ByteVal + Trunc(CalcVal);
                      (DataBuf + i)^ := AnsiChar(ByteVal);

                      //stereo?
                      if DoStereo then
                         begin
                         (DataBuf+i+1)^:=(DataBuf+i)^;
                         Inc(i);
                         end;

                      Inc(i);
                      end;

                  Inc(cnt);

                  if cnt=SamplesPerCycle then
                     begin
                     cnt:=0;
                     if wWaveform<>tgSine then
                        begin
                        FPVerticalStep:=MinVal;
                        end;

                     Inc(CycleCount);

                     //update samples per cycle
                     SamplesPerCycle:=Trunc((FPSamplesPerCycle*CycleCount)-(Trunc(FPSamplesPerCycle*(CycleCount-1))));

                     //CycleMidPoint of cycle
                     //CycleMidPoint:=SamplesPerCycle div 2;
                     CycleMidPoint:=Trunc(FPSamplesPerCycle+0.5) div 2;
                     end;
          end;
    end;

HasADSRChanged:=true;
HasChanged:=false;
HasToneChanged:=false;

//pass to ADSR routine
if DoADSR then
   begin

   ADSRWaveform(DataBuf,BufSize,DoStereo);

   end;

//restore random seed value
RandSeed:=OldRandSeed;

//temporary
{wfh:=FileCreate('c:\test.wav');
if wfh<>-1 then
   begin
   FileWrite(wfh,Buffer^,BufSize+HdrSize);
   FileClose(wfh);
   end;}
//******

Result:=true;

end;

//**********************************************************************
//set AM Level selection
procedure TToneGen.SetAMLevel(level: TTGAMLevel);
begin
fAMLevel:=level;
AMAmplitude:=AMAmpArray[Integer(level)];
AMWaveform:=AMWaveArray[Integer(level)];
AMFrequency:=AMFreqArray[Integer(level)];
end;


//**********************************************************************
//AM frequency = multiplier or absolute?
procedure TToneGen.SetAMMultiplier(setit: bool);
begin

fAMUseMultiplier:=setit;
HasChanged:=true;

end;

//**********************************************************************
//set selected AM Amplitude
procedure TToneGen.SetAMAmplitude(Amp: Smallint);
begin
fAMAmplitude:=GetPercentage(Amp);
AMAmpArray[Integer(fAMLevel)]:=fAMAmplitude;
HasChanged:=true;
end;

//**********************************************************************
//AM Waveform
procedure TToneGen.SetAMWaveform(Wave: TTGWave);
begin
fAMWaveform:=Wave;
AMWaveArray[Integer(fAMLevel)]:=fAMWaveform;
HasChanged:=true;
end;

//**********************************************************************
//AM Frequency
procedure TToneGen.SetAMFrequency(Freq: Single);
begin
fAMFrequency:=Freq;
AMFreqArray[Integer(fAMLevel)]:=fAMFrequency;
HasChanged:=true;
end;

//**********************************************************************
//DefineProperties procedures
//register defineproerties proc's
procedure TToneGen.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('AMArrayData', ReadAMArrayData, WriteAMArrayData,true);
end;

//**********************************************************************
//write AM array
procedure TToneGen.WriteAMArrayData(Stream: TStream);
var
  i: Integer;
  Temp: integer;
  STemp: Single;

begin
  with Stream do
       begin
       Temp := AMLevels;
       WriteBuffer(Temp, SizeOf(Temp));
       for i := 0 to AMLevels do
           begin
           //amplitude
           Temp := AMAmpArray[i];
           WriteBuffer(Temp,sizeof(temp));

           //waveform
           Temp := Integer(AMWaveArray[i]);
           WriteBuffer(Temp,sizeof(temp));

           //frequency
           STemp := AMFreqArray[i];
           WriteBuffer(STemp,sizeof(STemp));

           end;
       end;
end;

//**********************************************************************
//read AM array
procedure TToneGen.ReadAMArrayData(Stream: TStream);
var
  i, Temp, Levels: Integer;
  STemp: Single;
begin
  with Stream do
  begin
    Levels := 0;
    ReadBuffer(Levels, SizeOf(Levels));
    for i := 0 to Levels do
        begin
        //amplitude
        Temp := 0;
        ReadBuffer(Temp, SizeOf(Temp));
        AMAmpArray[i]:=Temp;

        //waveform
        Temp := 0;
        ReadBuffer(Temp, SizeOf(Temp));
        AMWaveArray[i]:=TTGWave(Temp);

        //frquency
        STemp := 0;
        ReadBuffer(STemp, SizeOf(STemp));
        AMFreqArray[i]:=STemp;

        end;
  end;
end;

//**********************************************************************
//reset AM parameters to defaults
procedure TToneGen.ResetAM;
var
   i: Integer;

begin

for i:=0 to AMLevels do
    begin
    //amplitude
    AMAmpArray[i]:=0;

    //wave
    AMWaveArray[i]:=tgSine;

    //frequency
    AMFreqArray[i]:=(i+1.0) / 2;

    end;

HasChanged:=true;

end;

//**********************************************************************
//set an AM parameter
procedure TToneGen.SetAMParameter(Level: TTGAMLevel;Freq: Single; Amp: Smallint; Wav:TTGWave);
begin

//frequency
AMFreqArray[Integer(Level)]:=Freq;

//wave
AMWaveArray[Integer(Level)]:=Wav;

//amplitude
AMAmpArray[Integer(Level)]:=Amp;

HasChanged:=true;

end;

//**********************************************************************
//return data buffer pointer
function TToneGen.GetDataBuffer: PAnsiChar;
begin
Result:=Buffer;
end;

//**********************************************************************
//export data
function TToneGen.ExportFile(FileName: String): bool;
var
   Success,FileHandle: Integer;

begin
Result:=false;

if Buffer=nil then Exit;

FileHandle:=FileCreate(FileName);
if FileHandle<>-1 then
   begin
   Success:=FileWrite(Filehandle,Buffer^,BufferSize);
   FileClose(FileHandle);

   if Success<>-1 then Result:=true;

   end;

end;

//**********************************************************************
//set frequency to note value
function SetNoteToFreq(NoteString: String;var pOctave: Integer): Integer;
var
   i,tOctave,Freq,Base,TempNote,NoteValue,MaxNoteVal: Integer;
begin
Result:=0;
Base:=440;
MaxNoteVal:=121;
NoteValue:=-1;
tOctave:=pOctave;

NoteString:=AnsiUppercase(Trim(NoteString));

//direct note entry 'Nxx'
if AnsiPos('N',NoteString)=1 then
   begin
   //delete 'N'
   Delete(NoteString,1,1);
   NoteValue:=StrToIntDef(NoteString,-1);

   if NoteValue>MaxNoteVal then NoteValue:=-1;

   NoteString:='';

   end
else
    begin
    if AnsiPos('O',NoteString)=1 then //Octave 'Ox'
       begin
       //delete 'O'
       Delete(NoteString,1,1);
       tOctave:=StrToIntDef(NoteString[1],-1);

       if tOctave=-1 then Exit;

       //delete 'x'
       Delete(NoteString,1,1);
       end
    // > or <
    else if (AnsiPos('<',NoteString)=1) or (AnsiPos('>',NoteString)=1) then
         begin
         while(AnsiPos('<',NoteString)=1) or (AnsiPos('>',NoteString)=1) do
            begin
            if AnsiPos('<',NoteString)=1 then
               begin
               Dec(tOctave);
               if tOctave<0 then tOctave:=0;
               end
            else
                begin
                Inc(tOctave);
                if tOctave>9 then tOctave:=9;
                end;

            Delete(NoteString,1,1);
            end;

         end;

    //extract note
    for i:=0 to 6 do
       begin
       //search for note (A - G)
       if AnsiPos(Char(Integer('A')+i),NoteString)=1 then
          begin
          NoteValue:=i;

          //delete note character
          Delete(NoteString,1,1);
          Break;
          end;

       end;

    //accidental # + -
    if NoteValue>-1 then
       begin

       //insert semitones
       TempNote:=NoteValue*2;

       //correct for BC & EF
       if NoteValue>4 then
          Dec(TempNote);

       if NoteValue>1 then
          Dec(TempNote);

       NoteValue:=TempNote;

       //# or +
       if (AnsiPos('+',NoteString)=1) or (AnsiPos('#',NoteString)=1) then
          begin
          Delete(NoteString,1,1);

          //B or E
          if (NoteValue=2) or (NoteValue=7) then
             NoteValue:=-1
          else
              Inc(NoteValue);
          end
       //-
       else if AnsiPos('-',NoteString)=1 then
          begin
          Delete(NoteString,1,1);

          //C or F
          if (NoteValue=3) or (NoteValue=8) then
             NoteValue:=-1
          else
              begin
              Dec(NoteValue);

              //A- = G# in previous octave
              if NoteValue<0 then
                 begin
                 NoteValue:=11;//G#
                 Dec(tOctave);

                 if tOctave<0 then NoteValue:=-1;
                 end;
              end;

          end;

       end;

   if NoteValue>-1 then
      begin
      NoteValue:=12*tOctave+NoteValue;
      end;

   end;

//should be empty now
if Length(NoteString)>0 then NoteValue:=-1;

if NoteValue>-1 then
   begin
   pOctave:=tOctave;

   NoteValue:=NoteValue-48;
   Freq:=Trunc(Base * Power(2,NoteValue/12)+0.5);

   if (Freq>=MinFreq) and (Freq<=MaxFreq) then
      begin
      Result:=Freq;
      end;

   end;
end;

//**********************************************************************
//set frequency to note value
function TToneGen.SetNote(NoteString: String): Integer;
var
   Freq,pOctave: Integer;

begin
Result:=0;
pOctave:=Octave;

Freq:=SetNoteToFreq(NoteString,pOctave);

if Freq>0 then
   begin
   Frequency:=Freq;
   Octave:=pOctave;
   HasChanged:=true;
   Result:=Freq;
   end;

end;

//**********************************************************************
//set AM frequency to note value
function TToneGen.SetAMNote(Level: TTGAMLevel;NoteString:String): Single;
var
   Freq,pOctave: Integer;
   fFreq: Single;

begin
Result:=0;
pOctave:=AMOctaves[Integer(Level)];

Freq:=SetNoteToFreq(NoteString,pOctave);
fFreq:=Freq;
if Freq>0 then
   begin
   //absolute or multiply?
   if fAMUseMultiplier then
      fFreq:=fFreq/fFrequency;

   AMFreqArray[Integer(Level)]:=fFreq;

   AMOctaves[Integer(Level)]:=pOctave;
   HasChanged:=true;
   Result:=fFreq;
   end;

end;

procedure TToneGen.SaveToStream(Stream: TStream);
begin
   if Buffer = nil then Exit;

   Stream.Position := 0;
   Stream.Write(Buffer^, BufferSize);
end;

end.
