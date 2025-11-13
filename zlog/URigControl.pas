unit URigControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, AnsiStrings, Vcl.Grids, System.Math, System.StrUtils,
  System.SyncObjs, Generics.Collections, Vcl.Buttons, Vcl.WinXCtrls,
  Vcl.ButtonGroup, Vcl.Menus, System.IniFiles,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogKeyer, CPDrv, OmniRig_TLB,
  URigCtrlLib, URigCtrlIcom, URigCtrlKenwood, URigCtrlYaesu, URigCtrlElecraft,
  JvExControls, JvLED;

type
  TRigControl = class(TForm)
    RigLabel: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    PollingTimer1: TTimer;
    ZCom1: TCommPortDriver;
    ZCom2: TCommPortDriver;
    dispFreqA: TLabel;
    dispFreqB: TLabel;
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
    panelBody: TPanel;
    panelHeader: TPanel;
    dispVFO: TLabel;
    dispLastFreq: TLabel;
    ZCom3: TCommPortDriver;
    ZCom4: TCommPortDriver;
    PollingTimer3: TTimer;
    PollingTimer4: TTimer;
    buttongrpFreqMemory: TButtonGroup;
    buttonMemoryWrite: TSpeedButton;
    buttonMemoryClear: TSpeedButton;
    popupMemoryCh: TPopupMenu;
    menuM1: TMenuItem;
    menuM2: TMenuItem;
    menuM3: TMenuItem;
    menuM4: TMenuItem;
    menuM5: TMenuItem;
    buttonMemScan: TSpeedButton;
    buttonImportAuto: TSpeedButton;
    buttonImportRigA: TSpeedButton;
    buttonImportRigB: TSpeedButton;
    Label5: TLabel;
    panelSpotImport: TPanel;
    panelMemScan: TPanel;
    buttonMemScanAuto: TSpeedButton;
    buttonMemScanRigA: TSpeedButton;
    buttonMemScanRigB: TSpeedButton;
    ledMemScan: TJvLED;
    labelMemScan: TLabel;
    menuM6: TMenuItem;
    labelScanMemChNo: TLabel;
    buttonOmniRig: TSpeedButton;
    buttonReconnectRigs: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonReconnectRigsClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PollingTimerTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ZCom1ReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: DWORD);
    procedure buttonOmniRigClick(Sender: TObject);
    procedure buttonJumpLastFreqClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToggleSwitch1Click(Sender: TObject);
    procedure buttongrpFreqMemoryItems0Click(Sender: TObject);
    procedure buttongrpFreqMemoryItems1Click(Sender: TObject);
    procedure buttongrpFreqMemoryItems2Click(Sender: TObject);
    procedure buttongrpFreqMemoryItems3Click(Sender: TObject);
    procedure buttongrpFreqMemoryItems4Click(Sender: TObject);
    procedure buttonMemoryWriteClick(Sender: TObject);
    procedure menuMnClick(Sender: TObject);
    procedure popupMemoryChPopup(Sender: TObject);
    procedure buttonMemScanClick(Sender: TObject);
    procedure buttongrpFreqMemoryItems5Click(Sender: TObject);
  private
    { Private declarations }
    FRigs: TRigArray;
    FCurrentRig : TRig;
    FPrevVfo: array[0..1] of TFrequency;
    FOnVFOChanged: TNotifyEvent;
    FOnBandChanged: TNotifyEvent;
    FFreqLabel: array[0..1] of TLabel;
    FPollingTimer: array[1..4] of TTimer;

    FCurrentRigNumber: Integer;  // 1 or 2
    FMaxRig: Integer;            // default = 2.  may be larger with virtual rigs

    FOmniRig: TOmniRigX;

    // Freq Memory
    FMemEditMode: Integer;
    FMenuMn: array[1..6] of TMenuItem;
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

    procedure SetLastFreq(v: TFrequency);
    function GetLastFreq(): TFrequency;
    procedure ShowMemCh();
    procedure SaveMemCh(rig: TRig);
    procedure LoadMemCh(rig: TRig);

    procedure SetPrevVFO(Index: Integer; fFreq: TFrequency);
    function GetPrevVFO(Index: Integer): TFrequency;

    procedure SetImportTo(no: Integer);
    function GetImportTo(): Integer;

    procedure SetMemScanRigNo(no: Integer);
    function GetMemScanRigNo(): Integer;
  public
    { Public declarations }
    function StatusSummaryFreqHz(b: TBand; m: TMode; Hz : TFrequency): string; // returns current rig's band freq mode
    function StatusSummary: string; // returns current rig's band freq mode
    procedure ImplementOptions(rig: Integer = 1);
    procedure Stop();
    function SetCurrentRig(N : integer): Boolean;
    function GetCurrentRig : integer;
    function CheckSameBand(B : TBand) : boolean; // returns true if inactive rig is in B
    function IsAvailableBand(B: TBand): Boolean;

    property PrevVFO[Index: Integer]: TFrequency read GetPrevVFO write SetPrevVFO;

//    procedure SetRit(fOnOff: Boolean);
//    procedure SetXit(fOnOff: Boolean);
//    procedure SetRitOffset(offset: Integer);

//    property Rig: TRig read FCurrentRig;
    property Rigs: TRigArray read FRigs;
    property MaxRig: Integer read FMaxRig write FMaxRig;
    property CurrentRigNumber: Integer read FCurrentRigNumber;

    function GetRig(setno: Integer; b: TBand): TRig;

    property OnVFOChanged: TNotifyEvent read FOnVFOChanged write FOnVFOChanged;
    property OnBandChanged: TNotifyEvent read FOnBandChanged write FOnBandChanged;

    procedure ForcePowerOff();
    procedure ForcePowerOn();

    procedure ToggleMemScan();
    procedure MemScanOff();
    property MemScanRigNo: Integer read GetMemScanRigNo write SetMemScanRigNo;

    property LastFreq: TFrequency read GetLastFreq write SetLastFreq;
    property ImportRigNo: Integer read GetImportTo write SetImportTo;
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

   FOmniRig := TOmniRigX.Create(Self);

   FPollingTimer[1] := PollingTimer1;
   FPollingTimer[2] := PollingTimer2;
   FPollingTimer[3] := PollingTimer3;
   FPollingTimer[4] := PollingTimer4;

   FMemEditMode := 0;
   FMenuMn[1] := menuM1;
   FMenuMn[2] := menuM2;
   FMenuMn[3] := menuM3;
   FMenuMn[4] := menuM4;
   FMenuMn[5] := menuM5;
   FMenuMn[6] := menuM6;

   labelMemScan.Caption := '';
   labelScanMemchNo.Caption := '';
   buttonImportAuto.Down := True;
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
   MainForm.CallsignEdit.SetFocus;
   MainForm.SetLastFocus();
   PostMessage(MainForm.Handle, WM_ZLOG_MOVELASTFREQ, 0, 0);
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
   fActive: Boolean;
begin
   nRigNo := TTimer(Sender).Tag;
   fActive := (FCurrentRig = FRigs[nRigNo]);
   if (fActive = True) or (FRigs[nRigNo].MemScan = False) then begin
      FRigs[nRigNo].PollingProcess();
   end
   else begin
      FRigs[nRigNo].MemScanProcess();
      labelScanMemchNo.Caption := 'M' + IntToStr(FRigs[nRigNo].MemScanNo);
   end;
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

procedure TRigControl.ZCom1ReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: DWORD);
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

function TRigControl.StatusSummaryFreqHz(b: TBand; m: TMode; Hz: TFrequency): string; // returns current rig's band freq mode
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
   S := S + FillRight(MHzString[b], 5);
   S := S + FillLeft(FloatToStrF(Hz / 1000.0, ffFixed, 12, 1), 10) + ' ';
   S := S + FillRight(ModeString[m], 5);
   ss := FormatDateTime('hh:nn:ss', CurrentTime);

   if Main.CurrentQSO.CQ then begin
      ss := 'CQ ' + ss + ' ';
   end
   else begin
      ss := 'SP ' + ss + ' ';
   end;

   S := S + ss + ' [' + dmZLogGlobal.Settings._pcname + ']';

   Result := S;
end;

function TRigControl.StatusSummary: string; // returns current rig's band freq mode
begin
   Result := '';
   if FCurrentRig = nil then begin
      Exit;
   end;

   Result := StatusSummaryFreqHz(FCurrentRig.CurrentBand, FCurrentRig.CurrentMode, FCurrentRig.CurrentFreqHz);
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

procedure TRigControl.SetPrevVFO(Index: Integer; fFreq: TFrequency);
begin
   FPrevVfo[Index] := fFreq;
end;

function TRigControl.GetPrevVFO(Index: Integer): TFrequency;
begin
   Result := FPrevVfo[Index];
end;

function TRigControl.SetCurrentRig(N: Integer): Boolean;
   procedure SetRigName(rigno: Integer; rigname: string);
   begin
      RigLabel.Caption := 'RIG-' + IntToStr(rigno) + ':' + rigname;
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
      LoadMemCh(FCurrentRig);
   end
   else begin
      FCurrentRig := nil;
      SetRigName(FCurrentRigNumber, '(none)');
   end;

   ShowMemCh();

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
   UsePolling: Boolean;
begin
   rig := nil;
   try
      if dmZLogGlobal.RigNameStr[rignum] = 'Omni-Rig' then begin
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
      end;

      if dmZLogGlobal.Settings.FRigControl[rignum].FControlPort in [1 .. 20] then begin
         rname := dmZLogGlobal.RigNameStr[rignum];
         if rname = 'None' then begin
            Exit;
         end;

         if rignum = 1 then begin
            Port := dmZLogGlobal.Settings.FRigControl[1].FControlPort;
            UsePolling := dmZLogGlobal.Settings.FRigControl[1].FUsePolling;
            Comm := ZCom1;
            Timer := PollingTimer1;
         end
         else if rignum = 2 then begin
            Port := dmZLogGlobal.Settings.FRigControl[2].FControlPort;
            UsePolling := dmZLogGlobal.Settings.FRigControl[2].FUsePolling;
            Comm := ZCom2;
            Timer := PollingTimer2;
         end
         else if rignum = 3 then begin
            Port := dmZLogGlobal.Settings.FRigControl[3].FControlPort;
            UsePolling := dmZLogGlobal.Settings.FRigControl[3].FUsePolling;
            Comm := ZCom3;
            Timer := PollingTimer3;
         end
         else begin
            Port := dmZLogGlobal.Settings.FRigControl[4].FControlPort;
            UsePolling := dmZLogGlobal.Settings.FRigControl[4].FUsePolling;
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

         if rname = 'TS-590' then begin
            rig := TTS2000.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if rname = 'TS-890' then begin
            rig := TTS890.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if rname = 'TS-990' then begin
            rig := TTS990.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if rname = 'TS-2000' then begin
            rig := TTS2000.Create(rignum, Port, Comm, Timer, b19, b2400);
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

         if rname = 'FTDX-101' then begin
            rig:= TFTDX101.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if rname = 'FT-710' then begin
            rig:= TFT710.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if rname = 'FTX-1' then begin
            rig:= TFT710.Create(rignum, Port, Comm, Timer, b19, b430);
         end;

         if rname = 'JST-145' then begin
            rig := TJST145.Create(rignum, Port, Comm, Timer, b19, b28);
         end;

         if rname = 'JST-245' then begin
            rig := TJST145.Create(rignum, Port, Comm, Timer, b19, b50);
         end;

         if rname = 'Elecraft K3S/K3/KX3/KX2' then begin
            rig := TElecraft.Create(rignum, Port, Comm, Timer, b19, b50);
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
            TICOM(rig).GetBandAndModeFlag := dmZLogGlobal.Settings._icom_polling_freq_and_mode;

            TICOM(rig).RigAddr := ICOMLIST[i].addr;
            TICOM(rig).RitCtrlSupported := ICOMLIST[i].RitCtrl;
            TICOM(rig).XitCtrlSupported := ICOMLIST[i].XitCtrl;
            TICOM(rig).PlayMessageCwSupported := ICOMLIST[i].PlayCW;
            TICOM(rig).PlayMessagePhSupported := ICOMLIST[i].PlayPh;
            TICOM(rig).FixEdgeSelectSupported := ICOMLIST[i].FixEdgeSel;

            if Pos('IC-731', rname) > 0 then begin
               TICOM(rig).Freq4Bytes := True;
            end;
         end;

         rig.UsePolling := UsePolling;
      end;

      if Assigned(rig) then begin
         rig.Name := rname;
         rig.OnUpdateStatus := OnUpdateStatusProc;
         rig.OnError := OnErrorProc;
         rig.IgnoreMode := dmZLogGlobal.Settings._ignore_rig_mode;
      end;
   finally
      Result := rig;
   end;
end;

procedure TRigControl.ImplementOptions(rig: Integer);
var
   i: Integer;
begin
   Stop();

   // OmniRigは最初にOFFにしておく
   // その後、OmniRigがあればBuildRigObject()でONになる
   buttonOmniRig.Enabled := False;

   // RIGの準備
   FRigs[1] := BuildRigObject(1);
   FRigs[2] := BuildRigObject(2);
   FRigs[3] := BuildRigObject(3);
   FRigs[4] := BuildRigObject(4);
   FRigs[5] := TVirtualRig.Create(5);

   // 最大RIG数の設定
   if (dmZLogGlobal.Settings._operate_style = os1Radio) then begin
      FMaxRig := 2;

      for i := 4 downto 1 do begin
         if FRigs[i] <> nil then begin
            FMaxRig := i;
            Break;
         end;
      end;
   end
   else begin
      if (dmZLogGlobal.Settings._so2r_use_rig3 = False) then begin
         FMaxRig := 2;
      end
      else begin
         FMaxRig := 3;
      end;
   end;

   // RIGコントロールのCOMポートと、CWキーイングのポートが同じなら
   // CWキーイングのCPDrvをRIGコントロールの物にすり替える
   for i := 1 to 4 do begin
      if (FRigs[i] <> nil) and (dmZLogGlobal.Settings.FRigControl[i].FControlPort = dmZLogGlobal.Settings.FRigControl[i].FKeyingPort) then begin
         FPollingTimer[i].Enabled := False;
         dmZLogKeyer.SetCommPortDriver(i - 1, FRigs[i].CommPortDriver);
         FPollingTimer[i].Enabled := True;
      end
      else begin
         dmZLogKeyer.ResetCommPortDriver(i - 1, TKeyingPort(dmZLogGlobal.Settings.FRigControl[i].FKeyingPort));
      end;
   end;

(*
   if ((FRigs[1] <> nil) and (dmZLogGlobal.Settings.FRigControl[1].FControlPort = dmZLogGlobal.Settings.FRigControl[1].FKeyingPort)) and
      ((FRigs[2] <> nil) and (dmZLogGlobal.Settings.FRigControl[2].FControlPort = dmZLogGlobal.Settings.FRigControl[2].FKeyingPort)) then begin
      PollingTimer1.Enabled := False;
      dmZLogKeyer.SetCommPortDriver(0, FRigs[1].CommPortDriver);
      PollingTimer1.Enabled := True;

      PollingTimer2.Enabled := False;
      dmZLogKeyer.SetCommPortDriver(1, FRigs[2].CommPortDriver);
      PollingTimer2.Enabled := True;
   end
   else if (FRigs[1] <> nil) and (dmZLogGlobal.Settings.FRigControl[1].FControlPort = dmZLogGlobal.Settings.FRigControl[1].FKeyingPort) then begin
      PollingTimer1.Enabled := False;
      dmZLogKeyer.SetCommPortDriver(0, FRigs[1].CommPortDriver);
      PollingTimer1.Enabled := True;

      dmZLogKeyer.ResetCommPortDriver(1, TKeyingPort(dmZLogGlobal.Settings.FRigControl[2].FKeyingPort));
   end
   else if (FRigs[2] <> nil) and (dmZLogGlobal.Settings.FRigControl[2].FControlPort = dmZLogGlobal.Settings.FRigControl[2].FKeyingPort) then begin
      dmZLogKeyer.ResetCommPortDriver(0, TKeyingPort(dmZLogGlobal.Settings.FRigControl[1].FKeyingPort));

      PollingTimer2.Enabled := False;
      dmZLogKeyer.SetCommPortDriver(1, FRigs[2].CommPortDriver);
      PollingTimer2.Enabled := True;
   end
   else begin
      dmZLogKeyer.ResetCommPortDriver(0, TKeyingPort(dmZLogGlobal.Settings.FRigControl[1].FKeyingPort));
      dmZLogKeyer.ResetCommPortDriver(1, TKeyingPort(dmZLogGlobal.Settings.FRigControl[2].FKeyingPort));
   end;
*)

   for i := 1 to 4 do begin
      if FRigs[i] <> nil then begin
         if dmZLogGlobal.Settings.FRigControl[i].FUseTransverter then begin
            FRigs[i].FreqOffset := 1000 * dmZLogGlobal.Settings.FRigControl[i].FTransverterOffset;
         end
         else begin
            FRigs[i].FreqOffset := 0;
         end;

         FRigs[i].PortConfig := dmZLogGlobal.Settings.FRigControl[i].FControlPortConfig;

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

   if R = nil then begin
      Exit;
   end;

   case o_RIG.Vfo of
      PM_VFOA, PM_VFOAA: begin
         R.CurrentVFO := 0;
         R.CurrentFreq[0] := o_RIG.FreqA;
      end;

      PM_VFOB, PM_VFOAB: begin
         R.CurrentVFO := 1;
         R.CurrentFreq[1] := o_RIG.FreqB;
      end;

      else begin
         R.CurrentVFO := 0;
         R.CurrentFreq[0] := o_RIG.Freq;
      end;
   end;

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
   if FRigs[rigno].IgnoreMode = False then begin
      dispVFO.Caption := VFOString[currentvfo];
      if curmode <> CurrentQSO.Mode then begin
         MainForm.UpdateMode(curmode);
      end;
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

      RigLabel.Caption := 'RIG-' + IntToStr(MainForm.RigControl.CurrentRigNumber) + ':Omni-Rig(' + S + ')';
   end;

   // DEBUG:RIT情報表示
   if dmZLogGlobal.Settings.FRigShowRitInfo = True then begin
      if currentvfo = 0 then begin
         if TRig(Sender).Rit = True then begin
            S := 'RIT ON ' + IntTostr(TRig(Sender).RitOffset);
         end
         else begin
            S := 'RIT OFF';
         end;

         Caption := 'Rig Control ' + S;
      end;
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

   if (FPrevVfo[currentvfo] > 0) then begin
      if (Abs(FPrevVfo[currentvfo] - vfo[currentvfo]) > 20) then begin
         if Assigned(FOnVFOChanged) then begin
            FOnVFOChanged(TObject(currentvfo));
         end;
      end;

      if (dmZLogGlobal.BandPlan.FreqToBand(FPrevVfo[currentvfo]) <> b) then begin
         if Assigned(FOnBandChanged) then begin
            FOnBandChanged(TObject(currentvfo));
         end;
      end;
   end;

   dispFreqA.Caption := FreqStr(VfoA) + ' kHz';
   dispFreqB.Caption := FreqStr(VfoB) + ' kHz';
//   dispLastFreq.Caption := FreqStr(Last) + ' kHz';
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

   ShowMemCh();
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
   if dmZLogGlobal.Settings._operate_style = os1Radio then begin
      Result := FRigs[setno];
   end
   else begin
      if setno = 3 then begin
         Result := FRigs[5];
      end
      else begin
         if b = bUnknown then begin
            Result := nil;
            Exit;
         end;

         rigno := dmZLogGlobal.Settings.FRigSet[setno].FRig[b];
         if rigno = 0 then begin
            Result := FRigs[5];  // nil
         end
         else begin
            Result := FRigs[rigno];
         end;
      end;
   end;
end;

procedure TRigControl.PowerOn();
var
   rigno: Integer;
begin
   // リグ設定を反映
   rigno := GetCurrentRig();
   ImplementOptions(rigno);

   // RIG1/2両方,CW1/2/3全て設定無しならOFFにする
   if (FRigs[1] = nil) and (FRigs[2] = nil) and
      (FRigs[3] = nil) and (FRigs[4] = nil) and
      (dmZLogKeyer.KeyingPort[0] = tkpNone) and
      (dmZLogKeyer.KeyingPort[1] = tkpNone) and
      (dmZLogKeyer.KeyingPort[2] = tkpNone) and
      (dmZLogKeyer.KeyingPort[3] = tkpNone) and
      (dmZLogKeyer.KeyingPort[4] = tkpNone) then begin
      ForcePowerOff();
      Exit;
   end;

   // ONの場合の色
   ToggleSwitch1.FrameColor := clBlack;
   ToggleSwitch1.ThumbColor := clBlack;
   buttonReconnectRigs.Enabled := True;
   buttonJumpLastFreq.Enabled := True;
   buttonMemoryWrite.Enabled := True;
   buttonMemoryClear.Enabled := True;
   buttonMemScan.Enabled := True;
   buttongrpFreqMemory.Enabled := True;

   FFreqLabel[0].Font.Color := clBlack;
   FFreqLabel[1].Font.Color := clBlack;

   // CW開始
   dmZLogKeyer.Open();
end;

procedure TRigControl.PowerOff();
begin
   // CW停止
   dmZLogKeyer.ClrBuffer();
   dmZLogKeyer.Close();
   dmZLogKeyer.ResetCommPortDriver(0, TKeyingPort(dmZLogGlobal.Settings.FRigControl[1].FKeyingPort));
   dmZLogKeyer.ResetCommPortDriver(1, TKeyingPort(dmZLogGlobal.Settings.FRigControl[2].FKeyingPort));
   dmZLogKeyer.ResetCommPortDriver(2, TKeyingPort(dmZLogGlobal.Settings.FRigControl[3].FKeyingPort));
   dmZLogKeyer.ResetCommPortDriver(3, TKeyingPort(dmZLogGlobal.Settings.FRigControl[4].FKeyingPort));
   dmZLogKeyer.ResetCommPortDriver(4, TKeyingPort(dmZLogGlobal.Settings.FRigControl[5].FKeyingPort));

   // リグコン停止
   Stop();

   // OFFの色
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
   buttonMemoryWrite.Enabled := False;
   buttonMemoryClear.Enabled := False;
   buttonMemScan.Enabled := False;
   buttonMemScan.Down := False;
   buttongrpFreqMemory.Enabled := False;

   ledMemScan.Active := False;
   ledMemScan.Status := False;
end;

procedure TRigControl.ForcePowerOff();
begin
   ToggleSwitch1.State := tssOff;
end;

procedure TRigControl.ForcePowerOn();
begin
   ToggleSwitch1.State := tssOn;
end;

procedure TRigControl.SetLastFreq(v: TFrequency);
begin
   dispLastFreq.Caption := FreqStr(v) + ' kHz';
end;

function TRigControl.GetLastFreq(): TFrequency;
begin
   Result := 0;
end;

procedure TRigControl.buttongrpFreqMemoryItems0Click(Sender: TObject);
begin
   if FCurrentRig = nil then begin
      Exit;
   end;
   FCurrentRig.MemCh[1].Call();
end;

procedure TRigControl.buttongrpFreqMemoryItems1Click(Sender: TObject);
begin
   if FCurrentRig = nil then begin
      Exit;
   end;
   FCurrentRig.MemCh[2].Call();
end;

procedure TRigControl.buttongrpFreqMemoryItems2Click(Sender: TObject);
begin
   if FCurrentRig = nil then begin
      Exit;
   end;
   FCurrentRig.MemCh[3].Call();
end;

procedure TRigControl.buttongrpFreqMemoryItems3Click(Sender: TObject);
begin
   if FCurrentRig = nil then begin
      Exit;
   end;
   FCurrentRig.MemCh[4].Call();
end;

procedure TRigControl.buttongrpFreqMemoryItems4Click(Sender: TObject);
begin
   if FCurrentRig = nil then begin
      Exit;
   end;
   FCurrentRig.MemCh[5].Call();
end;

procedure TRigControl.buttongrpFreqMemoryItems5Click(Sender: TObject);
begin
   if FCurrentRig = nil then begin
      Exit;
   end;
   FCurrentRig.MemCh[6].Call();
end;

procedure TRigControl.buttonMemoryWriteClick(Sender: TObject);
var
   pt: TPoint;
begin
   FMemEditMode := TSpeedButton(Sender).Tag;
   pt.X := TSpeedButton(Sender).Left + TSpeedButton(Sender).Width;
   pt.Y := TSpeedButton(Sender).Top;
   pt := panelBody.ClientToScreen(pt);
   popupMemoryCh.Popup(pt.X, pt.Y);
end;

procedure TRigControl.buttonMemScanClick(Sender: TObject);
var
   rig: TRig;
   i: Integer;
   scanrigset: Integer;
   b: TBand;
begin
   if FCurrentRig = nil then begin
      Exit;
   end;

   if buttonMemScan.Down = True then begin

      case MemScanRigNo of
         // AUTO
         0: begin
            case (MainForm.CurrentRigID + 1) of
               1: scanrigset := 2;
               2: scanrigset := 1;
               else Exit;
            end;
         end;

         // RIG-A
         1: begin
            scanrigset := 1;
            if (MainForm.CurrentRigID + 1) = scanrigset then begin
               SendMessage(MainForm.Handle, WM_ZLOG_SWITCH_RIG, 2, 2);
            end;
         end;

         // RIG-B
         2: begin
            scanrigset := 2;
            if (MainForm.CurrentRigID + 1) = scanrigset then begin
               SendMessage(MainForm.Handle, WM_ZLOG_SWITCH_RIG, 1, 2);
            end;
         end;
      end;

      b := TextToBand(MainForm.EditPanel[scanrigset - 1].BandEdit.Text);

      rig := GetRig(scanrigset, b);
      if rig = nil then begin
         Exit;
      end;

      LoadMemCh(FRigs[rig.RigNumber]);

      labelMemScan.Caption := 'RIG-' + IntToStr(rig.RigNumber);

      FRigs[rig.RigNumber].MemScan := buttonMemScan.Down;

      ledMemScan.Active := True;
      ledMemScan.Status := True;
   end
   else begin
      for i := Low(FRigs) to High(FRigs) do begin
         if FRigs[i] <> nil then begin
            FRigs[i].MemScan := False;
         end;
      end;

      labelMemScan.Caption := '';
      labelScanMemChNo.Caption := '';

      ledMemScan.Active := False;
      ledMemScan.Status := False;
   end;
end;

procedure TRigControl.popupMemoryChPopup(Sender: TObject);
var
   i: Integer;
   f: TFrequency;
   m: TMode;
begin
   for i := 1 to 6 do begin
      f := FCurrentRig.MemCh[i].FFreq;
      m := FCurrentRig.MemCh[i].FMode;
      if f = 0 then begin
         FMenuMn[i].Caption := 'M' + IntToStr(i);
      end
      else begin
         FMenuMn[i].Caption := 'M' + IntToStr(i) + ': ' + kHzStr(f) + ' ' + ModeString[m];
      end;
   end;
end;

procedure TRigControl.menuMnClick(Sender: TObject);
var
   n: Integer;
   f: TFrequency;
   m: TMode;
begin
   if FCurrentRig = nil then begin
      Exit;
   end;

   n := TMenuItem(Sender).Tag;

   // write
   if FMemEditMode = 1 then begin
      f := FCurrentRig.CurrentFreqHz;
      m := FCurrentRig.CurrentMode;
      FCurrentRig.MemCh[n].Write(f, m);
   end;

   // clear
   if FMemEditMode = 2 then begin
      FCurrentRig.MemCh[n].Clear();
   end;

   ShowMemCh();

   SaveMemCh(FCurrentRig);
end;

procedure TRigControl.ShowMemCh();
var
   i: Integer;
   f: TFrequency;
   m: TMode;
   b: TBand;
begin
   if (FCurrentRig <> nil) and (FCurrentRig.UseMemChScan = True) then begin
      buttonMemoryWrite.Enabled := True;
      buttonMemoryClear.Enabled := True;
      buttonMemScan.Enabled := True;
      buttongrpFreqMemory.Enabled := True;
   end
   else begin
      buttonMemoryWrite.Enabled := False;
      buttonMemoryClear.Enabled := False;
      buttonMemScan.Enabled := False;
      buttongrpFreqMemory.Enabled := False;
      for i := 1 to 6 do begin
         buttongrpFreqMemory.Items[i - 1].Caption := 'M' + IntToStr(i);
         buttongrpFreqMemory.Items[i - 1].Hint := '';
      end;
      Exit;
   end;

   for i := 1 to 6 do begin
      f := FCurrentRig.MemCh[i].FFreq;
      m := FCurrentRig.MemCh[i].FMode;
      b := dmZLogGlobal.BandPlan.FreqToBand(f);

      if f = 0 then begin
         buttongrpFreqMemory.Items[i - 1].Caption := 'M' + IntToStr(i);
         buttongrpFreqMemory.Items[i - 1].Hint := '';
      end
      else begin
         buttongrpFreqMemory.Items[i - 1].Caption := 'M' + IntToStr(i) + ':' + BandToText(b) + ' ' + ModeString[m];
         buttongrpFreqMemory.Items[i - 1].Hint := kHzStr(f);
      end;
   end;
end;

procedure TRigControl.SaveMemCh(rig: TRig);
var
   i: Integer;
   f: TFrequency;
   m: TMode;
   ini: TMemIniFile;
   strKey: string;
   fname: string;
begin
   if rig = nil then begin
      Exit;
   end;

   if rig.UseMemChScan = False then begin
      Exit;
   end;

   fname := ExtractFilePath(Application.ExeName) + 'zlog_rigcontrol.ini';
   ini := TMemIniFile.Create(fname);
   try
      for i := 1 to 6 do begin
         f := rig.MemCh[i].FFreq;
         m := rig.MemCh[i].FMode;
         strKey := 'M' + IntToStr(i);

         ini.WriteInt64(rig.Name, strKey + '_freq', f);
         ini.WriteInteger(rig.Name, strKey + '_mode', Integer(m));
      end;

      ini.UpdateFile();
   finally
      ini.Free();
   end;
end;

procedure TRigControl.LoadMemCh(rig: TRig);
var
   i: Integer;
   ini: TMemIniFile;
   strKey: string;
   fname: string;
begin
   if rig = nil then begin
      Exit;
   end;

   if rig.UseMemChScan = False then begin
      Exit;
   end;

   fname := ExtractFilePath(Application.ExeName) + 'zlog_rigcontrol.ini';
   ini := TMemIniFile.Create(fname);
   try
      for i := 1 to 6 do begin
         strKey := 'M' + IntToStr(i);

         rig.MemCh[i].FFreq := ini.ReadInt64(rig.Name, strKey + '_freq', 0);
         rig.MemCh[i].FMode := TMode(ini.ReadInteger(rig.Name, strKey + '_mode', Integer(mCW)));
      end;
   finally
      ini.Free();
   end;
end;

procedure TRigControl.ToggleMemScan();
begin
   buttonMemScan.Down := not buttonMemScan.Down;
   buttonMemScanClick(nil);
end;

procedure TRigControl.MemScanOff();
begin
   if buttonMemScan.Down = True then begin
      buttonMemScan.Down := False;
      buttonMemScanClick(nil);
   end;
end;

procedure TRigControl.SetImportTo(no: Integer);
begin
   case no of
      0: buttonImportAuto.Down := True;
      1: buttonImportRigA.Down := True;
      2: buttonImportRigB.Down := True;
   end;
end;

function TRigControl.GetImportTo(): Integer;
begin
   if buttonImportAuto.Down = True then begin
      Result := 0;
   end
   else if buttonImportRigA.Down = True then begin
      Result := 1;
   end
   else if buttonImportRigB.Down = True then begin
      Result := 2;
   end
   else begin
      Result := 0;
   end;
end;

procedure TRigControl.SetMemScanRigNo(no: Integer);
begin
   case no of
      0: buttonMemScanAuto.Down := True;
      1: buttonMemScanRigA.Down := True;
      2: buttonMemScanRigB.Down := True;
   end;
end;

function TRigControl.GetMemScanRigNo(): Integer;
begin
   if buttonMemScanAuto.Down = True then begin
      Result := 0;
   end
   else if buttonMemScanRigA.Down = True then begin
      Result := 1;
   end
   else if buttonMemScanRigB.Down = True then begin
      Result := 2;
   end
   else begin
      Result := 0;
   end;
end;

end.
