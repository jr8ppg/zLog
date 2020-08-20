unit UVoiceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MPlayer, ExtCtrls;

type
  TVoiceForm = class(TForm)
    MP: TMediaPlayer;
    Timer: TTimer;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private éŒ¾ }
    FCtrlZCQLoopVoice: Boolean;
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
  end;

implementation

{$R *.dfm}

uses
  UzLogKeyer, UzLogGlobal;

procedure TVoiceForm.FormCreate(Sender: TObject);
begin
   FCtrlZCQLoopVoice := False;
end;

procedure TVoiceForm.SendVoice(i: integer);
var
   filename: string;
begin
   if i > 10 then begin
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

   dmZLogKeyer.SetVoiceFlag(1);
   if dmZLogGlobal.Settings._pttenabled then begin
      dmZLogKeyer.ControlPTT(True);
   end;

   LoopInterval := 0;
   MP.Play;
   Timer.Enabled := True;
end;

procedure TVoiceForm.StopVoice();
begin
   try
      if Playing then begin
         MP.Stop;
      end;
   except
      on EMCIDeviceError do begin
         Timer.Enabled := False;

         dmZLogKeyer.SetVoiceFlag(0);
         if dmZLogGlobal.Settings._pttenabled then begin
            dmZLogKeyer.ControlPTT(False);
         end;

         Exit;
      end;
   end;

   MP.Rewind;
   Timer.Enabled := False;

   dmZLogKeyer.SetVoiceFlag(0);

   if dmZLogGlobal.Settings._pttenabled then begin
      dmZLogKeyer.ControlPTT(False);
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

   dmZLogKeyer.SetVoiceFlag(1);

   if dmZLogGlobal.Settings._pttenabled then begin
      dmZLogKeyer.ControlPTT(True);
   end;

   MP.Play;
   Timer.Enabled := True;
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

   dmZlogKeyer.SetVoiceFlag(0);

   if dmZLogGlobal.Settings._pttenabled then begin
      dmZlogKeyer.ControlPTT(False);
   end;

   if LoopInterval > 0 then begin
      if LoopCount > 0 then begin
         dec(LoopCount);
      end
      else begin // end of wait time
         LoopCount := LoopInterval div 100;
         dmZlogKeyer.SetVoiceFlag(1);

         if dmZLogGlobal.Settings._pttenabled then begin
            dmZlogKeyer.ControlPTT(True);
         end;

         MP.Rewind;
         MP.Play;
      end;

      Exit;
   end;

   Timer.Enabled := False;
end;

end.
