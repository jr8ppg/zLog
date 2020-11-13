unit UVoiceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MPlayer, ExtCtrls, UzLogConst, UzLogSound;

type
  TVoiceForm = class(TForm)
    Timer: TTimer;
    Timer2: TTimer;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private éŒ¾ }
    FWaveSound: array[1..maxmessage] of TWaveSound;
    FCurrentVoice: Integer;
    FCtrlZCQLoopVoice: Boolean;
    FOnNotifyStarted: TNotifyEvent;
    FOnNotifyFinished: TNotifyEvent;

    LoopInterval : integer; // in milliseconds;
    LoopCount : integer;
    function Playing : boolean;
    procedure SetLoopInterval(Intvl : integer);
    procedure VoiceControl(fOn: Boolean);
  public
    { Public éŒ¾ }
    procedure Init();
    procedure SendVoice(i: integer);
    procedure StopVoice();
    procedure CQLoopVoice();
    procedure CtrlZBreakVoice();

    property CtrlZCQLoopVoice: Boolean read FCtrlZCQLoopVoice write FCtrlZCQLoopVoice;

    property OnNotifyStarted: TNotifyEvent read FOnNotifyStarted write FOnNotifyStarted;
    property OnNotifyFinished: TNotifyEvent read FOnNotifyFinished write FOnNotifyFinished;
  end;

implementation

{$R *.dfm}

uses
  UzLogKeyer, UzLogGlobal;

procedure TVoiceForm.FormCreate(Sender: TObject);
var
   i: Integer;
begin
   FCtrlZCQLoopVoice := False;
   FOnNotifyStarted := nil;
   FOnNotifyFinished := nil;

   for i := 1 to High(FWaveSound) do begin
      FWaveSound[i] := TWaveSound.Create();
   end;
end;

procedure TVoiceForm.FormDestroy(Sender: TObject);
var
   i: Integer;
begin
   for i := 1 to High(FWaveSound) do begin
      FWaveSound[i].Free();
   end;
end;

procedure TVoiceForm.Init();
var
   i: Integer;
begin
   for i := 1 to High(FWaveSound) do begin
      FWaveSound[i].Close();
   end;
end;

procedure TVoiceForm.SendVoice(i: integer);
var
   filename: string;
begin
   if i > maxmessage then begin
      exit;
   end;

   filename := dmZLogGlobal.Settings.FSoundFiles[i];
   if filename = '' then begin
      Exit;
   end;
   if FileExists(filename) = False then begin
      Exit;
   end;

   if FWaveSound[i].IsLoaded = False then begin
      FWaveSound[i].Open(filename, dmZLogGlobal.Settings.FSoundDevice);
//      FWaveSound[i].OnDone := FOnNotifyFinished;
   end;
   FWaveSound[i].Stop();

   VoiceControl(True);

   LoopInterval := 0;
   FCurrentVoice := i;
   FWaveSound[i].Play();

   if Assigned(FOnNotifyStarted) then begin
      FOnNotifyStarted(FWaveSound[i]);
   end;

   Timer.Enabled := True;
   Timer2.Enabled := True;
end;

procedure TVoiceForm.StopVoice();
begin
   Timer.Enabled := False;
   FWaveSound[FCurrentVoice].Stop();
   VoiceControl(False);
end;

procedure TVoiceForm.CQLoopVoice;
var
   filename: string;
   Interval: integer;
begin
   StopVoice;

   filename := dmZLogGlobal.Settings.FSoundFiles[1];
   Interval := Trunc(1000 * dmZLogGlobal.Settings.CW._cqrepeat);
   SetLoopInterval(Interval);

   if filename = '' then begin
      Exit;
   end;
   if FileExists(filename) = False then begin
      Exit;
   end;

   if FWaveSound[1].IsLoaded = False then begin
      FWaveSound[1].Open(filename, dmZLogGlobal.Settings.FSoundDevice);
   end;
   FWaveSound[1].Stop();

   VoiceControl(True);

   FCurrentVoice := 1;
   FWaveSound[1].Play();

   if Assigned(FOnNotifyStarted) then begin
      FOnNotifyStarted(FWaveSound[1]);
   end;

   Timer.Enabled := True;
   Timer2.Enabled := True;
end;

procedure TVoiceForm.CtrlZBreakVoice();
begin
   CtrlZCQLoopVoice := False;
   StopVoice;
end;

procedure TVoiceForm.SetLoopInterval(Intvl: integer);
begin
   LoopInterval := Intvl;
   LoopCount := Intvl div 100;
end;

function TVoiceForm.Playing: boolean;
begin
   Result := FWaveSound[FCurrentVoice].Playing;
end;

procedure TVoiceForm.TimerTimer(Sender: TObject);
begin
   if Playing = True then begin
      Exit;
   end;

   VoiceControl(False);

   if LoopInterval > 0 then begin
      if LoopCount > 0 then begin
         dec(LoopCount);
      end
      else begin // end of wait time
         LoopCount := LoopInterval div 100;

         VoiceControl(True);

         FWaveSound[FCurrentVoice].Play();

         if Assigned(FOnNotifyStarted) then begin
            FOnNotifyStarted(FWaveSound[FCurrentVoice]);
         end;

         Timer2.Enabled := True;
      end;

      Exit;
   end;

   Timer.Enabled := False;
end;

procedure TVoiceForm.Timer2Timer(Sender: TObject);
begin
   if Playing = True then begin
      Exit;
   end;

   Timer2.Enabled := False;

   if Assigned(FOnNotifyFinished) then begin
      FOnNotifyFinished(FWaveSound[FCurrentVoice]);
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('---Voice Play finished!! ---'));
   {$ENDIF}
end;

procedure TVoiceForm.VoiceControl(fOn: Boolean);
begin
   if fOn = True then begin
      dmZlogKeyer.SetVoiceFlag(1);

      if dmZLogGlobal.Settings._pttenabled then begin
         dmZlogKeyer.ControlPTT(True);
      end;
   end
   else begin
      dmZlogKeyer.SetVoiceFlag(0);

      if dmZLogGlobal.Settings._pttenabled then begin
         dmZlogKeyer.ControlPTT(False);
      end;
   end;
end;

end.
