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
    button2bsiq: TSpeedButton;
    panelTxInfo: TPanel;
    buttonWait: TSpeedButton;
    ledWait: TJvLED;
    Label2: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure button2bsiqClick(Sender: TObject);
    procedure panelCQModeClick(Sender: TObject);
  private
    { Private êÈåæ }
    function GetCQMode(): Boolean;
    procedure SetCQMode(fCQ: Boolean);
    function GetWPM(): Integer;
    procedure SetWPM(nWpm: Integer);
    procedure SetTime(T: string);
    procedure SetPtt(fOn: Boolean);
    procedure SetWait(fOn: Boolean);
    function GetIsWait(): Boolean;
    procedure SetIsWait(fOn: Boolean);
    function GetIs2bsiq(): Boolean;
    procedure SetIs2bsiq(fOn: Boolean);
    procedure SetRx(rx: Integer);
    procedure SetTx(tx: Integer);
  public
    { Public êÈåæ }
    property CQMode: Boolean read GetCQMode write SetCQMode;
    property WPM: Integer read GetWPM write SetWPM;
    property Time: string write SetTime;
    property Ptt: Boolean write SetPtt;
    property Wait: Boolean write SetWait;
    property Is2bsiq: Boolean read GetIs2bsiq write SetIs2bsiq;
    property IsWait: Boolean read GetIsWait write SetIsWait;
    property Rx: Integer write SetRx;
    property Tx: Integer write SetTx;
  end;

implementation

{$R *.dfm}

uses
  Main;

procedure TformInformation.button2bsiqClick(Sender: TObject);
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

procedure TformInformation.SetWait(fOn: Boolean);
begin
   ledWait.Status := fOn;
end;

function TformInformation.GetIs2bsiq(): Boolean;
begin
   Result := button2bsiq.Down;
end;

procedure TformInformation.SetIs2bsiq(fOn: Boolean);
begin
   button2bsiq.Down := fOn;
end;

function TformInformation.GetIsWait(): Boolean;
begin
   Result := buttonWait.Down;
end;

procedure TformInformation.SetIsWait(fOn: Boolean);
begin
   buttonWait.Down := fOn;
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
