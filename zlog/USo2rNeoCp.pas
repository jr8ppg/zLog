unit USo2rNeoCp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls,
  System.Actions, Vcl.ActnList, JvExControls, JvLED, Vcl.WinXCtrls;

type
  TformSo2rNeoCp = class(TForm)
    groupAfControl: TGroupBox;
    buttonAfBlend: TSpeedButton;
    trackBlendRatio: TTrackBar;
    groupRxSelect: TGroupBox;
    buttonRig1: TSpeedButton;
    buttonRig2: TSpeedButton;
    ActionList1: TActionList;
    actionSo2rNeoSelRx1: TAction;
    actionSo2rNeoSelRx2: TAction;
    actionSo2rNeoSelRxBoth: TAction;
    buttonRigBoth: TSpeedButton;
    buttonPer100: TSpeedButton;
    buttonPer0: TSpeedButton;
    buttonPer50: TSpeedButton;
    ledPtt: TJvLED;
    Label1: TLabel;
    ledCancelRxSel: TJvLED;
    Label2: TLabel;
    ledRig1: TJvLED;
    ledRig2: TJvLED;
    ledRig3: TJvLED;
    ToggleSwitch1: TToggleSwitch;
    actionSo2rNeoToggleAutoRxSelect: TAction;
    procedure FormCreate(Sender: TObject);
    procedure buttonRigClick(Sender: TObject);
    procedure actionSo2rNeoSelRx1Execute(Sender: TObject);
    procedure actionSo2rNeoSelRx2Execute(Sender: TObject);
    procedure actionSo2rNeoSelRxBothExecute(Sender: TObject);
    procedure buttonAfBlendClick(Sender: TObject);
    procedure trackBlendRatioChange(Sender: TObject);
    procedure buttonPerNClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ToggleSwitch1Click(Sender: TObject);
    procedure actionSo2rNeoToggleAutoRxSelectExecute(Sender: TObject);
  private
    { Private êÈåæ }
    function GetRx(): Integer;
    procedure SetRx(rx: Integer);
    function GetPtt(): Boolean;
    procedure SetPtt(ptt: Boolean);
    function GetCanRxSel(): Boolean;
    procedure SetCanRxSel(flag: Boolean);
    function GetUseRxSelect(): Boolean;
    procedure SetUseRxSelect(flag: Boolean);
    procedure DispRig1State();
    procedure DispRig2State();
    procedure DispRigBothState();
  public
    { Public êÈåæ }
    property Rx: Integer read GetRx write SetRx;
    property Ptt: Boolean read GetPtt write SetPtt;
    property CanRxSel: Boolean read GetCanRxSel write SetCanRxSel;
    property UseRxSelect: Boolean read GetUseRxSelect write SetUseRxSelect;
    procedure ToggleRxSelect();
  end;

implementation

uses
  Main, UzLogKeyer;

{$R *.dfm}

procedure TformSo2rNeoCp.FormCreate(Sender: TObject);
begin
   ToggleSwitch1.State := tssOn;
   buttonRig1.Down := True;
   buttonRig2.Down := False;
   buttonRigBoth.Down := False;

   actionSo2rNeoSelRx1.ShortCut := MainForm.actionSo2rNeoSelRx1.ShortCut;
   actionSo2rNeoSelRx2.ShortCut := MainForm.actionSo2rNeoSelRx2.ShortCut;
   actionSo2rNeoSelRxBoth.ShortCut := MainForm.actionSo2rNeoSelRxBoth.ShortCut;
   actionSo2rNeoToggleAutoRxSelect.ShortCut := MainForm.actionSo2rNeoToggleAutoRxSelect.ShortCut;
   actionSo2rNeoSelRx1.SecondaryShortCuts.Assign(MainForm.actionSo2rNeoSelRx1.SecondaryShortCuts);
   actionSo2rNeoSelRx2.SecondaryShortCuts.Assign(MainForm.actionSo2rNeoSelRx2.SecondaryShortCuts);
   actionSo2rNeoSelRxBoth.SecondaryShortCuts.Assign(MainForm.actionSo2rNeoSelRxBoth.SecondaryShortCuts);
   actionSo2rNeoToggleAutoRxSelect.SecondaryShortCuts.Assign(MainForm.actionSo2rNeoToggleAutoRxSelect.SecondaryShortCuts);
end;

procedure TformSo2rNeoCp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.LastFocus.SetFocus;
      // VK_ALT
   end;
end;

procedure TformSo2rNeoCp.buttonAfBlendClick(Sender: TObject);
var
   fOn: Boolean;
   ratio: Byte;
begin
   fOn := buttonAfBlend.Down;

   dmZLogKeyer.So2rNeoSetAudioBlendMode(fOn);
   if fOn then begin
      ratio := trackBlendRatio.Position;
      dmZLogKeyer.So2rNeoSetAudioBlendRatio(ratio);
   end;

   MainForm.LastFocus.SetFocus;
end;

procedure TformSo2rNeoCp.buttonPerNClick(Sender: TObject);
begin
   trackBlendRatio.Position := TSpeedButton(Sender).Tag;

   MainForm.LastFocus.SetFocus;
end;

procedure TformSo2rNeoCp.trackBlendRatioChange(Sender: TObject);
var
   ratio: Byte;
begin
   ratio := trackBlendRatio.Position;
   dmZLogKeyer.So2rNeoSetAudioBlendRatio(ratio);

   MainForm.LastFocus.SetFocus;
end;

procedure TformSo2rNeoCp.buttonRigClick(Sender: TObject);
begin
   if (buttonRig1.Down = True) then begin
      actionSo2rNeoSelRx1.Execute();
      DispRig1State();
   end
   else if (buttonRig2.Down = True) then begin
      actionSo2rNeoSelRx2.Execute();
      DispRig2State();
   end
   else if (buttonRigBoth.Down = True) then begin
      actionSo2rNeoSelRxBoth.Execute();
      DispRigBothState();
   end;

   MainForm.LastFocus.SetFocus;
end;

procedure TformSo2rNeoCp.actionSo2rNeoSelRx1Execute(Sender: TObject);
var
   tx: Integer;
begin
   tx := MainForm.CurrentRigID;
   dmZLogKeyer.So2rNeoSwitchRig(tx, 0);

   MainForm.LastFocus.SetFocus;
end;

procedure TformSo2rNeoCp.actionSo2rNeoSelRx2Execute(Sender: TObject);
var
   tx: Integer;
begin
   tx := MainForm.CurrentRigID;
   dmZLogKeyer.So2rNeoSwitchRig(tx, 1);

   MainForm.LastFocus.SetFocus;
end;

procedure TformSo2rNeoCp.actionSo2rNeoSelRxBothExecute(Sender: TObject);
var
   tx: Integer;
begin
   tx := MainForm.CurrentRigID;
   dmZLogKeyer.So2rNeoSwitchRig(tx, 2);

   MainForm.LastFocus.SetFocus;
end;

procedure TformSo2rNeoCp.actionSo2rNeoToggleAutoRxSelectExecute(Sender: TObject);
begin
   ToggleRxSelect();

   MainForm.LastFocus.SetFocus;
end;

function TformSo2rNeoCp.GetRx(): Integer;
begin
   if (buttonRig1.Down = True) then begin
      Result := 0;
   end
   else if (buttonRig2.Down = True) then begin
      Result := 1;
   end
   else begin
      Result := 2;
   end;
end;

procedure TformSo2rNeoCp.SetRx(rx: Integer);
begin
   case rx of
      0: begin buttonRig1.Down := True; DispRig1State(); end;
      1: begin buttonRig2.Down := True; DispRig2State(); end;
      2: begin buttonRigBoth.Down := True; DispRigBothState(); end;
   end;
end;

procedure TformSo2rNeoCp.ToggleSwitch1Click(Sender: TObject);
begin
   if ToggleSwitch1.State = tssOff then begin
      dmZLogKeyer.So2rNeoUseRxSelect := False;
   end
   else begin
      dmZLogKeyer.So2rNeoUseRxSelect := True;
   end;

   if MainForm.Visible then begin
      MainForm.LastFocus.SetFocus;
   end;
end;

function TformSo2rNeoCp.GetPtt(): Boolean;
begin
   Result := ledPtt.Status;
end;

procedure TformSo2rNeoCp.SetPtt(ptt: Boolean);
begin
   ledPtt.Status := ptt;
end;

function TformSo2rNeoCp.GetCanRxSel(): Boolean;
begin
   Result := ledCancelRxSel.Status;
end;

procedure TformSo2rNeoCp.SetCanRxSel(flag: Boolean);
begin
   ledCancelRxSel.Status := flag;
end;

function TformSo2rNeoCp.GetUseRxSelect(): Boolean;
begin
   if ToggleSwitch1.State = tssOff then begin
      Result := False;
   end
   else begin
      Result := True;
   end;
end;

procedure TformSo2rNeoCp.SetUseRxSelect(flag: Boolean);
begin
   if flag = True then begin
      ToggleSwitch1.State := tssOn;
   end
   else begin
      ToggleSwitch1.State := tssOff;
   end;
end;

procedure TformSo2rNeoCp.ToggleRxSelect();
begin
   if ToggleSwitch1.State = tssOff then begin
      ToggleSwitch1.State := tssOn;
   end
   else begin
      ToggleSwitch1.State := tssOff;
   end;
end;

procedure TformSo2rNeoCp.DispRig1State();
begin
   buttonAfBlend.Down := False;
   buttonAfBlend.Click();
   groupAfControl.Enabled := False;
   ledRig1.Status := True;
   ledRig2.Status := False;
   ledRig3.Status := False;
end;

procedure TformSo2rNeoCp.DispRig2State();
begin
   buttonAfBlend.Down := False;
   buttonAfBlend.Click();
   groupAfControl.Enabled := False;
   ledRig1.Status := False;
   ledRig2.Status := True;
   ledRig3.Status := False;
end;

procedure TformSo2rNeoCp.DispRigBothState();
begin
   groupAfControl.Enabled := True;
   buttonAfBlend.Down := True;
   buttonAfBlend.Click();
   ledRig1.Status := False;
   ledRig2.Status := False;
   ledRig3.Status := True;
end;

end.
