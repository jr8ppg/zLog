unit UVoiceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MPlayer, ExtCtrls, UzLogConst, UzLogSound, UzLogOperatorInfo;

type
  TVoiceForm = class(TForm)
    Timer: TTimer;
    Timer2: TTimer;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private 宣言 }
    FWaveSound: array[1..maxmessage + 2] of TWaveSound;
    FCurrentOperator: TOperatorInfo;
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
    { Public 宣言 }
    procedure Init();
    procedure SendVoice(i: integer);
    procedure StopVoice();
    procedure CQLoopVoice(no: Integer);
    procedure CtrlZBreakVoice();
    procedure SetOperator(op: TOperatorInfo);

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
   FCurrentVoice := 0;
   FCurrentOperator := nil;

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
   FCurrentVoice := 0;
end;

procedure TVoiceForm.SendVoice(i: integer);
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
            filename := FCurrentOperator.VoiceFile[i];
         end;

         101: begin
            filename := FCurrentOperator.VoiceFile[1];
            i := 1;
         end;

         102: begin
            filename := FCurrentOperator.AdditionalVoiceFile[2];
            i := 13;
         end;

         103: begin
            filename := FCurrentOperator.AdditionalVoiceFile[3];
            i := 14;
         end;
      end;
   end;

   // ファイル名が空は何もしない
   if filename = '' then begin
      Exit;
   end;

   // ファイルが無ければ何もしない
   if FileExists(filename) = False then begin
      Exit;
   end;

   // 前回Soundと変わったか
   if FWaveSound[i].FileName <> filename then begin
      FWaveSound[i].Close();
   end;

   if FWaveSound[i].IsLoaded = False then begin
      FWaveSound[i].Open(filename, dmZLogGlobal.Settings.FSoundDevice);
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
   if FCurrentVoice <> 0 then begin
      FWaveSound[FCurrentVoice].Stop();
   end;
   VoiceControl(False);
end;

// no は 1,2,..12,101,102,103
procedure TVoiceForm.CQLoopVoice(no: Integer);
var
   filename: string;
   Interval: integer;
begin
   filename := '';
   StopVoice;

   if FCurrentOperator = nil then begin
      case no of
         101: filename := dmZLogGlobal.Settings.FSoundFiles[1];
         102: filename := dmZLogGlobal.Settings.FAdditionalSoundFiles[2];
         103: filename := dmZLogGlobal.Settings.FAdditionalSoundFiles[3];
      end;
   end
   else begin
      case no of
         101: filename := FCurrentOperator.VoiceFile[1];
         102: filename := FCurrentOperator.AdditionalVoiceFile[2];
         103: filename := FCurrentOperator.AdditionalVoiceFile[3];
      end;
   end;

   Interval := Trunc(1000 * dmZLogGlobal.Settings.CW._cqrepeat);
   SetLoopInterval(Interval);

   if filename = '' then begin
      Exit;
   end;
   if FileExists(filename) = False then begin
      Exit;
   end;

   // 前回Soundと変わったか
   if FWaveSound[1].FileName <> filename then begin
      FWaveSound[1].Close();
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

procedure TVoiceForm.SetOperator(op: TOperatorInfo);
begin
   FCurrentOperator := op;
   Init();
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
