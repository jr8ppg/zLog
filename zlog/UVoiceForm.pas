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
    FTxID: Integer;
    FOnNotifyStarted: TNotifyEvent;
    FOnNotifyFinished: TNotifyEvent;

    function Playing : boolean;
    procedure VoiceControl(nID: Integer; fOn: Boolean);
  public
    { Public 宣言 }
    procedure Init();
    procedure SendVoice(i: integer);
    procedure StopVoice();
    procedure SetOperator(op: TOperatorInfo);

    property Tx: Integer read FTxID write FTxID;

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

   VoiceControl(FTxID, True);

   FCurrentVoice := i;
   FWaveSound[i].Play();

   if Assigned(FOnNotifyStarted) then begin
      FOnNotifyStarted(FWaveSound[i]);
   end;

   Timer2.Enabled := True;
end;

procedure TVoiceForm.StopVoice();
begin
   Timer2.Enabled := False;
   if FCurrentVoice <> 0 then begin
      FWaveSound[FCurrentVoice].Stop();
   end;
   VoiceControl(FTxID, False);
end;

procedure TVoiceForm.SetOperator(op: TOperatorInfo);
begin
   FCurrentOperator := op;
   Init();
end;

function TVoiceForm.Playing: boolean;
begin
   Result := FWaveSound[FCurrentVoice].Playing;
end;

// Voice再生終了まで待つタイマー
procedure TVoiceForm.Timer2Timer(Sender: TObject);
begin
   if Playing = True then begin
      Exit;
   end;
   Timer2.Enabled := False;

   VoiceControl(FTxID, False);

   if Assigned(FOnNotifyFinished) then begin
      FOnNotifyFinished(FWaveSound[FCurrentVoice]);
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('---Voice Play finished!! ---'));
   {$ENDIF}
end;

procedure TVoiceForm.VoiceControl(nID: Integer; fOn: Boolean);
begin
   if fOn = True then begin
      dmZlogKeyer.SetVoiceFlag(1);

      if dmZLogGlobal.Settings._pttenabled then begin
         dmZlogKeyer.ControlPTT(nID, True);
      end;
   end
   else begin
      dmZlogKeyer.SetVoiceFlag(0);

      if dmZLogGlobal.Settings._pttenabled then begin
         dmZlogKeyer.ControlPTT(nID, False);
      end;
   end;
end;

end.
