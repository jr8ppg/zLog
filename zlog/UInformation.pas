unit UInformation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  JvExControls, JvLED, Vcl.Buttons;

type
  TformInformation = class(TForm)
    panelCQMode: TPanel;
    panelWpmInfo: TPanel;
    panelTime: TPanel;
    panelRxInfo: TPanel;
    Panel1: TPanel;
    ledPtt: TJvLED;
    Label1: TLabel;
    buttonAutoRigSwitch: TSpeedButton;
    panelTxInfo: TPanel;
    buttonCqInvert: TSpeedButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonAutoRigSwitchClick(Sender: TObject);
    procedure panelCQModeClick(Sender: TObject);
  private
    { Private êÈåæ }
    function GetCQMode(): Boolean;
    procedure SetCQMode(fCQ: Boolean);
    function GetWPM(): Integer;
    procedure SetWPM(nWpm: Integer);
    procedure SetTime(T: string);
    procedure SetPtt(fOn: Boolean);
    function GetAutoRigSwitch(): Boolean;
    procedure SetAutoRigSwitch(fOn: Boolean);
    function GetCqInvert(): Boolean;
    procedure SetCqInvert(fOn: Boolean);
    procedure SetRx(rx: Integer);
    procedure SetTx(tx: Integer);
  public
    { Public êÈåæ }
    property CQMode: Boolean read GetCQMode write SetCQMode;
    property WPM: Integer read GetWPM write SetWPM;
    property Time: string write SetTime;
    property Ptt: Boolean write SetPtt;
    property AutoRigSwitch: Boolean read GetAutoRigSwitch write SetAutoRigSwitch;
    property CqInvert: Boolean read GetCqInvert write SetCqInvert;
    property Rx: Integer write SetRx;
    property Tx: Integer write SetTx;
  end;

implementation

{$R *.dfm}

uses
  Main;

procedure TformInformation.buttonAutoRigSwitchClick(Sender: TObject);
begin
   MainForm.SetLastFocus();
end;

procedure TformInformation.FormCreate(Sender: TObject);
begin
//
end;

procedure TformInformation.FormDestroy(Sender: TObject);
begin
//
end;

procedure TformInformation.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
      // VK_ALT
   end;
end;

function TformInformation.GetCQMode(): Boolean;
begin
   if panelCQMode.Caption = 'CQ' then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TformInformation.SetCQMode(fCQ: Boolean);
begin
   if fCQ = True then begin
      panelCQMode.Caption := 'CQ';
      panelCQMode.Font.Color := clBlue;
   end
   else begin
      panelCQMode.Caption := 'SP';
      panelCQMode.Font.Color := clFuchsia;
   end;
end;

function TformInformation.GetWPM(): Integer;
begin
   Result := 0;
end;

procedure TformInformation.panelCQModeClick(Sender: TObject);
begin
   MainForm.actionToggleCqSpExecute(nil);
   MainForm.SetLastFocus();
end;

procedure TformInformation.SetWPM(nWpm: Integer);
begin
   panelWpmInfo.Caption := IntToStr(nWpm) + ' wpm';
end;

procedure TformInformation.SetTime(T: string);
begin
   panelTime.Caption := T;
end;

procedure TformInformation.SetPtt(fOn: Boolean);
begin
   ledPtt.Status := fOn;
end;

function TformInformation.GetAutoRigSwitch(): Boolean;
begin
   Result := buttonAutoRigSwitch.Down;
end;

procedure TformInformation.SetAutoRigSwitch(fOn: Boolean);
begin
   buttonAutoRigSwitch.Down := fOn;
end;

function TformInformation.GetCqInvert(): Boolean;
begin
   Result := buttonCqInvert.Down;
end;

procedure TformInformation.SetCqInvert(fOn: Boolean);
begin
   buttonCqInvert.Down := fOn;
end;

procedure TformInformation.SetRx(rx: Integer);
begin
   panelRxInfo.Caption := 'R' + IntToStr(rx + 1);
end;

procedure TformInformation.SetTx(tx: Integer);
begin
   panelTxInfo.Caption := 'T' + IntToStr(tx + 1);
end;

end.
