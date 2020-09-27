unit UVoiceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MPlayer, ExtCtrls, UzLogConst;

type
  TVoiceForm = class(TForm)
    MP: TMediaPlayer;
    Timer: TTimer;
    Timer2: TTimer;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private éŒ¾ }
    FCtrlZCQLoopVoice: Boolean;
    FOnNotifyStarted: TNotifyEvent;
    FOnNotifyFinished: TNotifyEvent;

    procedure VoiceControl(fOn: Boolean);
  public
    { Public éŒ¾ }
    LoopInterval : integer; // in milliseconds;
    LoopCount : integer;
    procedure SetLoopInterval(Intvl : integer);
    function Playing : boolean;
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
begin
   FCtrlZCQLoopVoice := False;
   FOnNotifyStarted := nil;
   FOnNotifyFinished := nil;
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

   if Playing then begin
      MP.Stop;
   end;

   MP.filename := filename;
   MP.Open;

   VoiceControl(True);

   LoopInterval := 0;
   MP.Play;

   if Assigned(FOnNotifyStarted) then begin
      FOnNotifyStarted(MP);
   end;

   Timer.Enabled := True;
   Timer2.Enabled := True;
end;

procedure TVoiceForm.StopVoice();
begin
   try
   try
      if MP.FileName = '' then begin
         Exit;
      end;

      if Playing then begin
         MP.Stop;
      end;

      MP.Rewind;
   except
      on EMCIDeviceError do begin
         Exit;
      end;
   end;

   finally
      Timer.Enabled := False;
      VoiceControl(False);
   end;
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

   if Playing then begin
      MP.Stop;
   end;

   MP.filename := filename;
   MP.Open;

   VoiceControl(True);

   MP.Play;

   if Assigned(FOnNotifyStarted) then begin
      FOnNotifyStarted(MP);
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
   Result := MP.Mode = mpPlaying;
end;

procedure TVoiceForm.TimerTimer(Sender: TObject);
begin
   if MP.Mode = mpPlaying then begin
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

         MP.Rewind;
         MP.Play;

         if Assigned(FOnNotifyStarted) then begin
            FOnNotifyStarted(MP);
         end;

         Timer2.Enabled := True;
      end;

      Exit;
   end;

   Timer.Enabled := False;
end;

procedure TVoiceForm.Timer2Timer(Sender: TObject);
begin
   if MP.Mode = mpPlaying then begin
      Exit;
   end;

   Timer2.Enabled := False;

   if Assigned(FOnNotifyFinished) then begin
      FOnNotifyFinished(MP);
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
