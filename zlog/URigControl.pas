unit URigControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, AnsiStrings, Vcl.Grids, System.Math, System.StrUtils,
  System.SyncObjs, Generics.Collections, Vcl.Buttons, Vcl.WinXCtrls,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogKeyer, CPDrv, OmniRig_TLB,
  URigCtrlLib, URigCtrlIcom, URigCtrlKenwood, URigCtrlYaesu;

type
  TRigControl = class(TForm)
    buttonReconnectRigs: TButton;
    RigLabel: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    PollingTimer1: TTimer;
    ZCom1: TCommPortDriver;
    ZCom2: TCommPortDriver;
    dispFreqA: TLabel;
    dispFreqB: TLabel;
    buttonOmniRig: TButton;
    PollingTimer2: TTimer;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    buttonJumpLastFreq: TSpeedButton;
    ToggleSwitch1: TToggleSwitch;
    Panel4: TPanel;
    dispMode: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    dispVFO: TLabel;
    dispLastFreq: TLabel;
    ZCom3: TCommPortDriver;
    ZCom4: TCommPortDriver;
    PollingTimer3: TTimer;
    PollingTimer4: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonReconnectRigsClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PollingTimerTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ZCom1ReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: Cardinal);
    procedure buttonOmniRigClick(Sender: TObject);
    procedure buttonJumpLastFreqClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToggleSwitch1Click(Sender: TObject);
  private
    { Private declarations }
    FRigs: TRigArray;
    FCurrentRig : TRig;
    FPrevVfo: array[0..1] of TFrequency;
    FOnVFOChanged: TNotifyEvent;
    FFreqLabel: array[0..1] of TLabel;
    FPollingTimer: array[1..4] of TTimer;

    FCurrentRigNumber: Integer;  // 1 or 2
    FMaxRig: Integer;            // default = 2.  may be larger with virtual rigs

    FOmniRig: TOmniRigX;
    procedure VisibleChangeEvent(Sender: TObject);
    procedure RigTypeChangeEvent(Sender: TObject; RigNumber: Integer);
    procedure StatusChangeEvent(Sender: TObject; RigNumber: Integer);
    procedure ParamsChangeEvent(Sender: TObject; RigNumber: Integer; Params: Integer);
    procedure CustomReplyEvent(Sender: TObject; RigNumber: Integer; Command, Reply: OleVariant);
    function BuildRigObject(rignum: Integer): TRig;
    procedure OnUpdateStatusProc(Sender: TObject; rigno: Integer; currentvfo, VfoA, VfoB, Last: TFrequency; curband: TBand; curmode: TMode);
    procedure OnErrorProc(Sender: TObject; msg: string);
    procedure UpdateFreq(currentvfo, VfoA, VfoB, Last: TFrequency; b: TBand; m: TMode);
    procedure SetSendFreq();
    function FreqStr(Hz: TFrequency): string;
    procedure PowerOn();
    procedure PowerOff();
  public
    { Public declarations }
    TempFreq: TFreqArray; //  temp. freq storage when rig is not connected. in kHz
    function StatusSummaryFreq(kHz : TFrequency): string; // returns current rig's band freq mode
    function StatusSummaryFreqHz(Hz : TFrequency): string; // returns current rig's band freq mode
    function StatusSummary: string; // returns current rig's band freq mode
    procedure ImplementOptions(rig: Integer = 1);
    procedure Stop();
    function SetCurrentRig(N : integer): Boolean;
    function GetCurrentRig : integer;
    function CheckSameBand(B : TBand) : boolean; // returns true if inactive rig is in B
    function IsAvailableBand(B: TBand): Boolean;

//    procedure SetRit(fOnOff: Boolean);
//    procedure SetXit(fOnOff: Boolean);
//    procedure SetRitOffset(offset: Integer);

//    property Rig: TRig read FCurrentRig;
    property Rigs: TRigArray read FRigs;
    property MaxRig: Integer read FMaxRig write FMaxRig;
    property CurrentRigNumber: Integer read FCurrentRigNumber;

    function GetRig(setno: Integer; b: TBand): TRig;

    property OnVFOChanged: TNotifyEvent read FOnVFOChanged write FOnVFOChanged;

    procedure ForcePowerOff();
    procedure ForcePowerOn();
  end;

resourcestring
  RECONNECT_ALL_RIGS = 'Reconnect all RIGs?';

implementation

uses
  UOptions, Main, UFreqList, UZLinkForm, UBandScope2;

{$R *.DFM}

procedure TRigControl.FormCreate(Sender: TObject);
var
   B: TBand;
begin
   RigLabel.Caption := '';
   FCurrentRig := nil;
   FRigs[1] := nil;
   FRigs[2] := nil;
   FRigs[3] := nil;
   FRigs[4] := nil;
   FRigs[5] := nil;
   FPrevVfo[0] := 0;
   FPrevVfo[1] := 0;
   FOnVFOChanged := nil;
   FFreqLabel[0] := dispFreqA;
   FFreqLabel[1] := dispFreqB;

   FCurrentRigNumber := 1;
   FMaxRig := 3;

   for B := b19 to HiBand do begin
      TempFreq[B] := 0;
   end;

   FOmniRig := TOmniRigX.Create(Self);

   FPollingTimer[1] := PollingTimer1;
   FPollingTimer[2] := PollingTimer2;
   FPollingTimer[3] := PollingTimer3;
   FPollingTimer[4] := PollingTimer4;
end;

procedure TRigControl.FormDestroy(Sender: TObject);
begin
   FCurrentRig := nil;
   Stop();
end;

procedure TRigControl.buttonReconnectRigsClick(Sender: TObject);
begin
   if MessageBox(Handle, PChar(RECONNECT_ALL_RIGS), PChar(Application.Title), MB_YESNO or MB_ICONEXCLAMATION or MB_DEFBUTTON2) = IDNO then begin
      Exit;
   end;

   MainForm.WriteStatusLine('', False);

   PowerOff();

   PowerOn();
end;

procedure TRigControl.buttonJumpLastFreqClick(Sender: TObject);
begin
   if FCurrentRig <> nil then begin
      FCurrentRig.MoveToLastFreq();
   end;

   MainForm.CallsignEdit.SetFocus;
   MainForm.SetLastFocus();
end;

procedure TRigControl.ToggleSwitch1Click(Sender: TObject);
begin
   if ToggleSwitch1.State = tssOff then begin
      PowerOff();
   end
   else begin
      PowerOn();
   end;

   MainForm.SetLastFocus();
end;

procedure TRigControl.Timer1Timer(Sender: TObject);
begin
   Timer1.Enabled := False;
   try
      MainForm.ZLinkForm.SendRigStatus;
   finally
      Timer1.Enabled := True;
   end;
end;

procedure TRigControl.PollingTimerTimer(Sender: TObject);
var
   nRigNo: Integer;
begin
   nRigNo := TTimer(Sender).Tag;
   FRigs[nRigNo].PollingProcess();
end;

procedure TRigControl.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

procedure TRigControl.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);
end;

procedure TRigControl.ZCom1ReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: Cardinal);
var
   i: Integer;
   ptr: PAnsiChar;
   str: AnsiString;
   n: Integer;
begin
   str := '';
   ptr := PAnsiChar(DataPtr);

   for i := 0 to DataSize - 1 do begin
      str := str + AnsiChar(ptr[i]);
   end;

   n := TCommPortDriver(Sender).Tag;
   if (n >= Low(FRigs)) and (n <= High(FRigs)) then begin
      if Assigned(FRigs[n]) then begin
         FRigs[n].PassOnRxData(str)
      end;
   end;
end;

procedure TRigControl.buttonOmniRigClick(Sender: TObject);
begin
   FOmniRig.DialogVisible := True;
end;

function TRigControl.FreqStr(Hz: TFrequency): string;
var
   S: string;
begin
   S := IntToStr(Hz mod 1000);
   while length(S) < 3 do begin
      S := '0' + S;
   end;

   S := IntToStr(Hz div 1000) + '.' + S;

   Result := S;
end;

function TRigControl.StatusSummaryFreq(kHz: TFrequency): string; // returns current rig's band freq mode
var
   S, ss: string;
begin
   S := '';

   if (dmZLogGlobal.IsMultiStation() = True) then begin
      ss := '30';
   end
   else begin
      ss := IntToStr(Ord(Main.CurrentQSO.Band));
   end;

   ss := FillRight(ss, 3);

   S := ss + S;
   S := S + FillRight(MHzString[Main.CurrentQSO.Band], 5);
   S := S + FillRight(IntToStr(kHz), 8);
   S := S + FillRight(ModeString[Main.CurrentQSO.Mode], 5);

   ss := TimeToStr(CurrentTime);
   if Main.CurrentQSO.CQ then begin
      ss := 'CQ ' + ss + ' ';
   end
   else begin
      ss := 'SP ' + ss + ' ';
   end;

   S := S + ss + ' [' + dmZlogGlobal.Settings._pcname + ']';

   Result := S;
end;

function TRigControl.StatusSummaryFreqHz(Hz: TFrequency): string; // returns current rig's band freq mode
var
   S, ss: string;
begin
   S := '';

   if (dmZLogGlobal.IsMultiStation() = True) then begin
      ss := '30';
   end
   else begin
      ss := IntToStr(Ord(Main.CurrentQSO.Band));
   end;

   ss := FillRight(ss, 3);
   S := ss + S;
   S := S + FillRight(MHzString[Main.CurrentQSO.Band], 5);
   S := S + FillRight(FloatToStrF(Hz / 1000.0, ffFixed, 12, 1), 8);
   S := S + FillRight(ModeString[Main.CurrentQSO.Mode], 5);
   ss := TimeToStr(CurrentTime);

   if Main.CurrentQSO.CQ then begin
      ss := 'CQ ' + ss + ' ';
   end
   else begin
      ss := 'SP ' + ss + ' ';
   end;

   S := S + ss + ' [' + dmZlogGlobal.Settings._pcname + ']';

   Result := S;
end;

function TRigControl.StatusSummary: string; // returns current rig's band freq mode
begin
   Result := '';
   if FCurrentRig = nil then begin
      Exit;
   end;

   if FCurrentRig.CurrentFreqKHz > 60000 then begin
      Result := StatusSummaryFreq(FCurrentRig.CurrentFreqKHz);
   end
   else begin
      Result := StatusSummaryFreqHz(FCurrentRig.CurrentFreqHz);
   end;
end;

function TRigControl.CheckSameBand(B: TBand): Boolean; // returns true if inactive rig is in B
var
   R: TRig;
begin
   Result := False;

   R := FRigs[FCurrentRigNumber];

   if R <> nil then begin
      if R.CurrentBand = B then begin
         Result := True;
      end;
   end;
end;

function TRigControl.IsAvailableBand(B: TBand): Boolean;
begin
//   if Rig = nil then begin
//      Result := True;
//      Exit;
//   end;
//
//   if (Rig.MinBand <= B) and (B <= Rig.MaxBand) then begin
//      Result := True;
//   end
//   else begin
//      Result := False;
//   end;
   Result := True;
end;

function TRigControl.SetCurrentRig(N: Integer): Boolean;
   procedure SetRigName(rigno: Integer; rigname: string);
   begin
      RigLabel.Caption := 'Current rig : ' + IntToStr(rigno) + ' (' + rigname + ')';
   end;
begin
//   if (N > FMaxRig) or (N < 0) then begin
//      Result := False;
//      Exit;
//   end;

   // RIG切り替え
   FCurrentRigNumber := N;
   if ((N = 1) or (N = 2) or (N = 3) or (N = 4) or (N = 5)) and (FRigs[N] <> nil) then begin
      FCurrentRig := FRigs[FCurrentRigNumber];
      FCurrentRig.InquireStatus;

      SetRigName(FCurrentRigNumber, FCurrentRig.Name);
      FCurrentRig.UpdateStatus;
   end
   else begin
      FCurrentRig := nil;
      SetRigName(FCurrentRigNumber, '(none)');
   end;

   Result := True;
end;

function TRigControl.GetCurrentRig: Integer;
begin
   Result := FCurrentRigNumber;
end;

function TRigControl.BuildRigObject(rignum: Integer): TRig;
var
   rname: string;
   i: Integer;
   rig: TRig;
   Comm: TCommPortDriver;
   Timer: TTimer;
   Port: Integer;
begin
   rig := nil;
   try
      if dmZlogGlobal.RigNameStr[rignum] = 'Omni-Rig' then begin
         rig := TOmni.Create(rignum, FOmniRig);
         rig.MinBand := b19;
         rig.MaxBand := b1200;

         ZCom1.Disconnect;
         ZCom2.Disconnect;
         FOmniRig.OnVisibleChange := VisibleChangeEvent;
         FOmniRig.OnRigTypeChange := RigTypeChangeEvent;
         FOmniRig.OnStatusChange := StatusChangeEvent;
         FOmniRig.OnParamsChange := ParamsChangeEvent;
         FOmniRig.OnCustomReply := CustomReplyEvent;

         if rignum = 1 then begin
            rig.Name := 'Omni-Rig: ' + FOmniRig.Rig1.Get_RigType;
         end
         else begin
            rig.Name := 'Omni-Rig: ' + FOmniRig.Rig2.Get_RigType;
         end;

         buttonOmniRig.Enabled := True;
      end
      else begin
         buttonOmniRig.Enabled := False;
      end;

      if dmZlogGlobal.Settings.FRigControl[rignum].FControlPort in [1 .. 20] then begin
         rname := dmZlogGlobal.RigNameStr[rignum];
         if rname = 'None' then begin
            Exit;
         end;

         if rignum = 1 then begin
            Port := dmZlogGlobal.Settings.FRigControl[1].FControlPort;
            Comm := ZCom1;
            Timer := PollingTimer1;
         end
         else if rignum = 2 then begin
            Port := dmZlogGlobal.Settings.FRigControl[2].FControlPort;
            Comm := ZCom2;
            Timer := PollingTimer2;
         end
         else if rignum = 3 then begin
            Port := dmZlogGlobal.Settings.FRigControl[3].FControlPort;
            Comm := ZCom3;
            Timer := PollingTimer3;
         end
         else begin
            Port := dmZlogGlobal.Settings.FRigControl[4].FControlPort;
            Comm := ZCom4;
            Timer := PollingTimer4;
         end;

         if rname = 'TS-690/450' then begin
            rig := TTS690.Create(rignum, Port, Comm, Timer, b19, b50);
         end;
         if rname = 'TS-850' then begin
            rig := TTS690.Create(rignum, Port, Comm, Timer, b19, b28);
         end;
         if rname = 'TS-790' then begin
            rig := TTS690.Create(rignum, Port, Comm, Timer, b144, b1200);
         end;

         if rname = 'TS-570' then begin
            rig := TTS570.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if rname = 'TS-590/890' then begin
            rig := TTS2000.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if rname = 'TS990' then begin
            rig := TTS990.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if rname = 'TS-2000' then begin
            rig := TTS2000.Create(rignum, Port, Comm, Timer, b19, b2400);
         end;

         if rname = 'TS-2000/P' then begin
            rig := TTS2000P.Create(rignum, Port, Comm, Timer, b19, b2400);
         end;

         if rname = 'FT-2000' then begin
            rig:= TFT2000.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if rname = 'FT-1000MP' then begin
            rig:= TFT1000MP.Create(rignum, Port, Comm, Timer, b19, b28);
         end;

         if rname = 'MarkV/FT-1000MP' then begin
            rig:= TMARKV.Create(rignum, Port, Comm, Timer, b19, b28);
         end;

         if rname = 'FT-1000MP Mark-V Field' then begin
            rig := TMARKVF.Create(rignum, Port, Comm, Timer, b19, b28);
         end;

         if rname = 'FT-1000' then begin
            rig := TFT1000.Create(rignum, Port, Comm, Timer, b19, b28);
         end;

         if rname = 'FT-1011(PC->RIG)' then begin
            rig := TFT1011.Create(rignum, Port, Comm, Timer, b19, b28);
         end;

         if rname = 'FT-920' then begin
            rig := TFT920.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if rname = 'FT-100' then begin
            rig := TFT100.Create(rignum, Port, Comm, Timer, b19, b430);
         end;

         if rname = 'FT-847' then begin
            rig := TFT847.Create(rignum, Port, Comm, Timer, b19, b430);
         end;

         if rname = 'FT-817' then begin
            rig := TFT817.Create(rignum, Port, Comm, Timer, b19, b430);
         end;

         if rname = 'FT-991' then begin
            rig:= TFT991.Create(rignum, Port, Comm, Timer, b19, b430);
         end;

         if rname = 'FTDX-3000' then begin
            rig:= TFTDX3000.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if rname = 'FTDX-5000/9000' then begin
            rig:= TFTDX5000.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if rname = 'FT-710' then begin
            rig:= TFT710.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if rname = 'JST-145' then begin
            rig := TJST145.Create(rignum, Port, Comm, Timer, b19, b28);
         end;

         if rname = 'JST-245' then begin
            rig := TJST145.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if pos('IC-', rname) = 1 then begin
            for i := 1 to MAXICOM do begin
               if rname = ICOMLIST[i].name then begin
                  break;
               end;
            end;

            if (pos('IC-775', rname) = 1) or (pos('IC-756', rname) = 1) then begin
               rig := TIC756.Create(rignum, Port, Comm, Timer, ICOMLIST[i].minband, ICOMLIST[i].maxband);
            end
            else if (rname = 'IC-7851') then begin
               rig := TIC7851.Create(rignum, Port, Comm, Timer, ICOMLIST[i].minband, ICOMLIST[i].maxband);
            end
            else begin
               rig := TICOM.Create(rignum, Port, Comm, Timer, ICOMLIST[i].minband, ICOMLIST[i].maxband);
            end;
            TICOM(rig).UseTransceiveMode := dmZLogGlobal.Settings._use_transceive_mode;
            TICOM(rig).GetBandAndModeFlag := dmZLogGlobal.Settings._icom_polling_freq_and_mode;

            TICOM(rig).RigAddr := ICOMLIST[i].addr;
            TICOM(rig).RitCtrlSupported := ICOMLIST[i].RitCtrl;
            TICOM(rig).XitCtrlSupported := ICOMLIST[i].XitCtrl;

            if Pos('IC-731', rname) > 0 then begin
               TICOM(rig).Freq4Bytes := True;
            end;
         end;

         rig.Name := rname;
      end;
      rig.OnUpdateStatus := OnUpdateStatusProc;
      rig.OnError := OnErrorProc;
   finally
      Result := rig;
   end;
end;

procedure TRigControl.ImplementOptions(rig: Integer);
var
   i: Integer;
begin
   Stop();

   if (dmZLogGlobal.Settings._so2r_type = so2rNone) or (dmZLogGlobal.Settings._so2r_use_rig3 = False) then begin
      FMaxRig := 2;
   end
   else begin
      FMaxRig := 3;
   end;

   FRigs[1] := BuildRigObject(1);
   FRigs[2] := BuildRigObject(2);
   FRigs[3] := BuildRigObject(3);
   FRigs[4] := BuildRigObject(4);
   FRigs[5] := TVirtualRig.Create(5);

   // RIGコントロールのCOMポートと、CWキーイングのポートが同じなら
   // CWキーイングのCPDrvをRIGコントロールの物にすり替える
   for i := 1 to 4 do begin
      if (FRigs[i] <> nil) and (dmZlogGlobal.Settings.FRigControl[i].FControlPort = dmZlogGlobal.Settings.FRigControl[i].FKeyingPort) then begin
         FPollingTimer[i].Enabled := False;
         dmZLogKeyer.SetCommPortDriver(i - 1, FRigs[i].CommPortDriver);
         FPollingTimer[i].Enabled := True;
      end
      else begin
         dmZLogKeyer.ResetCommPortDriver(i - 1, TKeyingPort(dmZlogGlobal.Settings.FRigControl[i].FKeyingPort));
      end;
   end;

(*
   if ((FRigs[1] <> nil) and (dmZlogGlobal.Settings.FRigControl[1].FControlPort = dmZlogGlobal.Settings.FRigControl[1].FKeyingPort)) and
      ((FRigs[2] <> nil) and (dmZlogGlobal.Settings.FRigControl[2].FControlPort = dmZlogGlobal.Settings.FRigControl[2].FKeyingPort)) then begin
      PollingTimer1.Enabled := False;
      dmZLogKeyer.SetCommPortDriver(0, FRigs[1].CommPortDriver);
      PollingTimer1.Enabled := True;

      PollingTimer2.Enabled := False;
      dmZLogKeyer.SetCommPortDriver(1, FRigs[2].CommPortDriver);
      PollingTimer2.Enabled := True;
   end
   else if (FRigs[1] <> nil) and (dmZlogGlobal.Settings.FRigControl[1].FControlPort = dmZlogGlobal.Settings.FRigControl[1].FKeyingPort) then begin
      PollingTimer1.Enabled := False;
      dmZLogKeyer.SetCommPortDriver(0, FRigs[1].CommPortDriver);
      PollingTimer1.Enabled := True;

      dmZLogKeyer.ResetCommPortDriver(1, TKeyingPort(dmZlogGlobal.Settings.FRigControl[2].FKeyingPort));
   end
   else if (FRigs[2] <> nil) and (dmZlogGlobal.Settings.FRigControl[2].FControlPort = dmZlogGlobal.Settings.FRigControl[2].FKeyingPort) then begin
      dmZLogKeyer.ResetCommPortDriver(0, TKeyingPort(dmZlogGlobal.Settings.FRigControl[1].FKeyingPort));

      PollingTimer2.Enabled := False;
      dmZLogKeyer.SetCommPortDriver(1, FRigs[2].CommPortDriver);
      PollingTimer2.Enabled := True;
   end
   else begin
      dmZLogKeyer.ResetCommPortDriver(0, TKeyingPort(dmZlogGlobal.Settings.FRigControl[1].FKeyingPort));
      dmZLogKeyer.ResetCommPortDriver(1, TKeyingPort(dmZlogGlobal.Settings.FRigControl[2].FKeyingPort));
   end;
*)

   for i := 1 to 4 do begin
      if FRigs[i] <> nil then begin
         if dmZlogGlobal.Settings.FRigControl[i].FUseTransverter then begin
            FRigs[i].FreqOffset := 1000 * dmZlogGlobal.Settings.FRigControl[i].FTransverterOffset;
         end
         else begin
            FRigs[i].FreqOffset := 0;
         end;

         // Initialize & Start
         FRigs[i].Initialize();
      end;
   end;

   SetCurrentRig(rig);

   SetSendFreq();
end;

procedure TRigControl.Stop();
var
   i: Integer;
begin
   for i := 1 to 3 do begin
      if Assigned(FRigs[i]) then begin
         FRigs[i].StopRequest();
      end;
   end;

   Timer1.Enabled := False;
   PollingTimer1.Enabled := False;
   PollingTimer2.Enabled := False;
   PollingTimer3.Enabled := False;
   PollingTimer4.Enabled := False;

   for i := 1 to 5 do begin
      if Assigned(FRigs[i]) then begin
         FreeAndNil(FRigs[i]);
      end;
   end;
   FCurrentRig := nil;
end;

procedure TRigControl.VisibleChangeEvent(Sender: TObject);
begin
end;

procedure TRigControl.RigTypeChangeEvent(Sender: TObject; RigNumber: Integer);
begin
end;

procedure TRigControl.StatusChangeEvent(Sender: TObject; RigNumber: Integer);
begin
end;

procedure TRigControl.ParamsChangeEvent(Sender: TObject; RigNumber: Integer; Params: Integer);
var
   b: TBand;
   o_RIG: IRigX;
   R: TRig;
   O: TOmniRigX;
begin
   O := TOmniRigX(Sender);
   if O = nil then begin
      Exit;
   end;

   if RigNumber = 1 then begin
      if O.Rig1.Status <> ST_ONLINE then Exit;
      o_RIG := O.Rig1;
      R := FRigs[1];
   end
   else if RigNumber = 2 then begin
      if O.Rig2.Status <> ST_ONLINE then Exit;
      o_RIG := O.Rig2;
      R := FRigs[2];
   end
   else begin
      Exit;
   end;

   case o_RIG.Vfo of
      PM_VFOA:
         R.CurrentVFO := 0;
      PM_VFOB:
         R.CurrentVFO := 1;
   end;

   R.CurrentFreq[0] := o_RIG.FreqA;
   R.CurrentFreq[1] := o_RIG.FreqB;

   case o_RIG.Mode of
      PM_CW_U, PM_CW_L:
         R.CurrentMode := mCW;
      PM_SSB_U, PM_SSB_L:
         R.CurrentMode := mSSB;
      PM_DIG_U, PM_DIG_L:
         R.CurrentMode := mOther;
      PM_AM:
         R.CurrentMode := mAM;
      PM_FM:
         R.CurrentMode := mFM;
   end;

   if R.CurrentVFO = 0 then begin
      b := dmZLogGlobal.BandPlan.FreqToBand(R.CurrentFreq[0]);
      if b <> bUnknown then begin
         R.CurrentBand := b;
      end;
      R.FreqMem[R.CurrentBand, R.CurrentMode] := R.CurrentFreq[0];
   end;

   if R.CurrentVFO = 1 then begin
      b := dmZLogGlobal.BandPlan.FreqToBand(R.CurrentFreq[1]);
      if b <> bUnknown then begin
         R.CurrentBand := b;
      end;
      R.FreqMem[R.CurrentBand, R.CurrentMode] := R.CurrentFreq[1];
   end;

   if R.Selected then
      R.UpdateStatus;
end;

procedure TRigControl.CustomReplyEvent(Sender: TObject; RigNumber: Integer; Command, Reply: OleVariant);
begin
end;

procedure TRigControl.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   MainForm.DelTaskbar(Handle);
end;

procedure TRigControl.SetSendFreq();
var
   sec: Integer;
begin
   sec := dmZLogGlobal.Settings._send_freq_interval;

   Timer1.Interval := sec * 1000;
   Timer1.Enabled := False;

   if sec = 0 then begin
      exit;
   end;

   if FRigs[1] <> nil then begin
      if dmZLogGlobal.Settings._zlinkport <> 0 then begin
         Timer1.Enabled := True;
      end;
   end;
end;

procedure TRigControl.OnUpdateStatusProc(Sender: TObject; rigno: Integer; currentvfo, VfoA, VfoB, Last: TFrequency; curband: TBand; curmode: TMode);
var
   S: string;
begin
   dispVFO.Caption := VFOString[currentvfo];
   if curmode <> CurrentQSO.Mode then begin
      MainForm.UpdateMode(curmode);
   end;

   dispMode.Caption := ModeString[curmode];
   if curband <> CurrentQSO.Band then begin
      MainForm.UpdateBand(curband);
   end;

   UpdateFreq(currentvfo, VfoA, VfoB, Last, CurrentQSO.Band, CurrentQSO.Mode);

   S := 'R' + IntToStr(rigno) + ' ' + 'V';
   if currentvfo = 0 then begin
      S := S + 'A';
   end
   else begin
      S := S + 'B';
   end;

   MainForm.ShowRigControlInfo(S);

   if (currentvfo = 0) then begin
      MainForm.BandScopeMarkCurrentFreq(curband, VfoA);
   end
   else begin
      MainForm.BandScopeMarkCurrentFreq(curband, VfoB);
   end;

   // OmniRigの場合
   if Sender is TOmni then begin
      if rigno = 1 then begin
         if FOmniRig.Rig1.Status <> ST_ONLINE then Exit;
         S := FOmniRig.Rig1.RigType;
      end
      else begin
         if FOmniRig.Rig2.Status <> ST_ONLINE then Exit;
         S := FOmniRig.Rig2.RigType;
      end;

      RigLabel.Caption := 'Current rig : ' + IntToStr(MainForm.RigControl.CurrentRigNumber) + ' Omni-Rig: ' + S;
   end;
end;

procedure TRigControl.OnErrorProc(Sender: TObject; msg: string);
begin
   MainForm.WriteStatusLineRed(msg, True);
end;

procedure TRigControl.UpdateFreq(currentvfo, VfoA, VfoB, Last: TFrequency; b: TBand; m: TMode);
var
   vfo: array[0..1] of TFrequency;
begin
   vfo[0] := VfoA;
   vfo[1] := VfoB;

   if (FPrevVfo[currentvfo] > 0) and
      (Abs(FPrevVfo[currentvfo] - vfo[currentvfo]) > 20) then begin
      if Assigned(FOnVFOChanged) then begin
         FOnVFOChanged(TObject(currentvfo));
      end;
   end;

   dispFreqA.Caption := FreqStr(VfoA) + ' kHz';
   dispFreqB.Caption := FreqStr(VfoB) + ' kHz';
   dispLastFreq.Caption := FreqStr(Last) + ' kHz';
   FPrevVfo[0] := VfoA;
   FPrevVfo[1] := VfoB;

   if dmZLogGlobal.BandPlan.IsInBand(b, m, vfo[currentvfo]) = True then begin
      FFreqLabel[currentvfo].Font.Color := clBlack;
   end
   else begin
      FFreqLabel[currentvfo].Font.Color := clRed;
   end;

   if currentvfo = 0 then begin
      FFreqLabel[0].Font.Style := [fsBold];
      FFreqLabel[1].Font.Style := [];
   end
   else begin
      FFreqLabel[0].Font.Style := [];
      FFreqLabel[1].Font.Style := [fsBold];
   end;

   dispLastFreq.Font.Color := clBlack;
   dispMode.Font.Color := clBlack;
   dispVFO.Font.Color := clBlack;
end;

//procedure TRigControl.SetRit(fOnOff: Boolean);
//begin
//   if Rig = nil then begin
//      Exit;
//   end;
//
//   Rig.Rit := fOnOff;
//end;
//
//procedure TRigControl.SetXit(fOnOff: Boolean);
//begin
//   if Rig = nil then begin
//      Exit;
//   end;
//
//   Rig.Xit := fOnOff;
//end;
//
//procedure TRigControl.SetRitOffset(offset: Integer);
//begin
//   if Rig = nil then begin
//      Exit;
//   end;
//
//   if offset = 0 then begin
//      Rig.RitClear();
//   end
//   else begin
//      Rig.RitOffset := offset;
//   end;
//end;

function TRigControl.GetRig(setno: Integer; b: TBand): TRig;
var
   rigno: Integer;
begin
   if b = bUnknown then begin
      Result := nil;
      Exit;
   end;

   if setno = 3 then begin
      Result := FRigs[5];
   end
   else begin
      rigno := dmZLogGlobal.Settings.FRigSet[setno].FRig[b];
      if rigno = 0 then begin
         Result := FRigs[5];  // nil
      end
      else begin
         Result := FRigs[rigno];
      end;
   end;
end;

procedure TRigControl.PowerOn();
var
   rigno: Integer;
begin
   rigno := GetCurrentRig();
   ImplementOptions(rigno);
   ToggleSwitch1.FrameColor := clBlack;
   ToggleSwitch1.ThumbColor := clBlack;
   dmZLogKeyer.Open();
   if (FRigs[1].Name = 'Omni-Rig') or (FRigs[2].Name = 'Omni-Rig') then begin
      buttonOmniRig.Enabled := True;
   end
   else begin
      buttonOmniRig.Enabled := False;
   end;
   buttonReconnectRigs.Enabled := True;
   buttonJumpLastFreq.Enabled := True;
end;

procedure TRigControl.PowerOff();
begin
   dmZLogKeyer.ClrBuffer();
   dmZLogKeyer.Close();
   dmZLogKeyer.ResetCommPortDriver(0, TKeyingPort(dmZlogGlobal.Settings.FRigControl[1].FKeyingPort));
   dmZLogKeyer.ResetCommPortDriver(1, TKeyingPort(dmZlogGlobal.Settings.FRigControl[2].FKeyingPort));
   dmZLogKeyer.ResetCommPortDriver(2, TKeyingPort(dmZlogGlobal.Settings.FRigControl[3].FKeyingPort));
   dmZLogKeyer.ResetCommPortDriver(3, TKeyingPort(dmZlogGlobal.Settings.FRigControl[4].FKeyingPort));
   dmZLogKeyer.ResetCommPortDriver(4, TKeyingPort(dmZlogGlobal.Settings.FRigControl[5].FKeyingPort));
   Stop();
   ToggleSwitch1.FrameColor := clSilver;
   ToggleSwitch1.ThumbColor := clSilver;

   // グレー表示
   dispFreqA.Caption := FreqStr(0) + ' kHz';
   dispFreqB.Caption := FreqStr(0) + ' kHz';
   dispLastFreq.Caption := FreqStr(0) + ' kHz';
   FFreqLabel[0].Font.Color := clSilver;
   FFreqLabel[1].Font.Color := clSilver;
   FFreqLabel[0].Font.Style := [];
   FFreqLabel[1].Font.Style := [];
   dispLastFreq.Font.Color := clSilver;
   dispMode.Font.Color := clSilver;
   dispVFO.Font.Color := clSilver;
   buttonOmniRig.Enabled := False;
   buttonReconnectRigs.Enabled := False;
   buttonJumpLastFreq.Enabled := False;
end;

procedure TRigControl.ForcePowerOff();
begin
   ToggleSwitch1.State := tssOff;
end;

procedure TRigControl.ForcePowerOn();
begin
   ToggleSwitch1.State := tssOn;
end;

end.
