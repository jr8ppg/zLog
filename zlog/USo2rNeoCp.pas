unit USo2rNeoCp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls,
  System.Actions, Vcl.ActnList, JvExControls, JvLED;

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
    procedure FormCreate(Sender: TObject);
    procedure buttonRigClick(Sender: TObject);
    procedure actionSo2rNeoSelRx1Execute(Sender: TObject);
    procedure actionSo2rNeoSelRx2Execute(Sender: TObject);
    procedure actionSo2rNeoSelRxBothExecute(Sender: TObject);
    procedure buttonAfBlendClick(Sender: TObject);
    procedure trackBlendRatioChange(Sender: TObject);
    procedure buttonPerNClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private êÈåæ }
    function GetRx(): Integer;
    procedure SetRx(rx: Integer);
    function GetPtt(): Boolean;
    procedure SetPtt(ptt: Boolean);
    function GetCanRxSel(): Boolean;
    procedure SetCanRxSel(flag: Boolean);
  public
    { Public êÈåæ }
    property Rx: Integer read GetRx write SetRx;
    property Ptt: Boolean read GetPtt write SetPtt;
    property CanRxSel: Boolean read GetCanRxSel write SetCanRxSel;
  end;

implementation

uses
  Main, UzLogKeyer;

{$R *.dfm}

procedure TformSo2rNeoCp.FormCreate(Sender: TObject);
begin
   buttonRig1.Down := True;
   buttonRig2.Down := False;

   actionSo2rNeoSelRx1.ShortCut := MainForm.actionSo2rNeoSelRx1.ShortCut;
   actionSo2rNeoSelRx2.ShortCut := MainForm.actionSo2rNeoSelRx2.ShortCut;
   actionSo2rNeoSelRxBoth.ShortCut := MainForm.actionSo2rNeoSelRxBoth.ShortCut;
   actionSo2rNeoSelRx1.SecondaryShortCuts.Assign(MainForm.actionSo2rNeoSelRx1.SecondaryShortCuts);
   actionSo2rNeoSelRx2.SecondaryShortCuts.Assign(MainForm.actionSo2rNeoSelRx2.SecondaryShortCuts);
   actionSo2rNeoSelRxBoth.SecondaryShortCuts.Assign(MainForm.actionSo2rNeoSelRxBoth.SecondaryShortCuts);
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
      buttonAfBlend.Down := False;
      buttonAfBlend.Click();
      groupAfControl.Enabled := False;
   end
   else if (buttonRig2.Down = True) then begin
      actionSo2rNeoSelRx2.Execute();
      buttonAfBlend.Down := False;
      buttonAfBlend.Click();
      groupAfControl.Enabled := False;
   end
   else if (buttonRigBoth.Down = True) then begin
      actionSo2rNeoSelRxBoth.Execute();
      groupAfControl.Enabled := True;
      buttonAfBlend.Down := True;
      buttonAfBlend.Click();
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
      0: buttonRig1.Down := True;
      1: buttonRig2.Down := True;
      2: buttonRigBoth.Down := True;
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

end.
