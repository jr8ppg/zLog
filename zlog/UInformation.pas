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
    panelRigInfo: TPanel;
    Panel1: TPanel;
    ledPtt: TJvLED;
    Label1: TLabel;
    buttonAutoRigSwitch: TSpeedButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonAutoRigSwitchClick(Sender: TObject);
    procedure panelCQModeClick(Sender: TObject);
  private
    { Private �錾 }
    function GetCQMode(): Boolean;
    procedure SetCQMode(fCQ: Boolean);
    function GetWPM(): Integer;
    procedure SetWPM(nWpm: Integer);
    procedure SetTime(T: string);
    procedure SetPtt(fOn: Boolean);
    function GetAutoRigSwitch(): Boolean;
    procedure SetAutoRigSwitch(fOn: Boolean);
    procedure SetRigNo(rig: Integer);
  public
    { Public �錾 }
    property CQMode: Boolean read GetCQMode write SetCQMode;
    property WPM: Integer read GetWPM write SetWPM;
    property Time: string write SetTime;
    property Ptt: Boolean write SetPtt;
    property AutoRigSwitch: Boolean read GetAutoRigSwitch write SetAutoRigSwitch;
    property RigNo: Integer write SetRigNo;
  end;

implementation

{$R *.dfm}

uses
  Main;

procedure TformInformation.buttonAutoRigSwitchClick(Sender: TObject);
begin
   MainForm.LastFocus.SetFocus;
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
         MainForm.LastFocus.SetFocus;
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
   MainForm.LastFocus.SetFocus;
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

procedure TformInformation.SetRigNo(rig: Integer);
begin
   panelRigInfo.Caption := 'R' + IntToStr(rig);
end;

end.