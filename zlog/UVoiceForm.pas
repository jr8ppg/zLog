unit UVoiceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MPlayer, ExtCtrls, UzLogConst, UzLogSound, UzLogOperatorInfo;

type
  TVoiceForm = class(TForm)
    Timer2: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private 宣言 }
    FWaveSound: array[1..maxmessage + 2] of TWaveSound;
    FCurrentOperator: TOperatorInfo;
    FCurrentVoice: Integer;
    FOnNotifyStarted: TNotifyEvent;
    FOnNotifyFinished: TPlayMessageFinishedProc;
  public
    { Public 宣言 }
    procedure Init();
    procedure SendVoice(i: integer);
    procedure StopVoice();
    procedure SetOperator(op: TOperatorInfo);

    function IsPlaying(): Boolean;

    property OnNotifyStarted: TNotifyEvent read FOnNotifyStarted write FOnNotifyStarted;
    property OnNotifyFinished: TPlayMessageFinishedProc read FOnNotifyFinished write FOnNotifyFinished;
  end;

implementation

{$R *.dfm}

uses
  UzLogKeyer, UzLogGlobal;

procedure TVoiceForm.FormCreate(Sender: TObject);
var
   i: Integer;
begin
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
            filename := FCurrentOperator.VoiceFiles[i];
         end;

         101: begin
            filename := FCurrentOperator.VoiceFiles[1];
            i := 1;
         end;

         102: begin
            filename := FCurrentOperator.AdditionalVoiceFiles[2];
            i := 13;
         end;

         103: begin
            filename := FCurrentOperator.AdditionalVoiceFiles[3];
            i := 14;
         end;
      end;
   end;

   // ファイル名が空か、ファイルがなければ何もしない
   if (filename = '') or (FileExists(filename) = False) then begin
//      if Assigned(FOnNotifyStarted) then begin
//         FOnNotifyStarted(nil);
//      end;
      if Assigned(FOnNotifyFinished) then begin
         FOnNotifyFinished(nil, mSSB, False);
      end;
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

   if Assigned(FOnNotifyStarted) then begin
      FOnNotifyStarted(FWaveSound[i]);
   end;

   FCurrentVoice := i;
   FWaveSound[i].Play();

   Timer2.Enabled := True;
end;

procedure TVoiceForm.StopVoice();
begin
   Timer2.Enabled := False;
   if FCurrentVoice <> 0 then begin
      FWaveSound[FCurrentVoice].Stop();
   end;

   if Assigned(FOnNotifyFinished) then begin
      // Stop時のFinishイベントは不要
      //FOnNotifyFinished(nil, mSSB, True);
   end;
end;

procedure TVoiceForm.SetOperator(op: TOperatorInfo);
begin
   FCurrentOperator := op;
   Init();
end;

function TVoiceForm.IsPlaying(): Boolean;
begin
   Result := FWaveSound[FCurrentVoice].Playing;
end;

// Voice再生終了まで待つタイマー
procedure TVoiceForm.Timer2Timer(Sender: TObject);
begin
   if IsPlaying() = True then begin
      Exit;
   end;
   Timer2.Enabled := False;

   if Assigned(FOnNotifyFinished) then begin
      FOnNotifyFinished(FWaveSound[FCurrentVoice], mSSB, False);
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('---Voice Play finished!! ---'));
   {$ENDIF}
end;

end.
