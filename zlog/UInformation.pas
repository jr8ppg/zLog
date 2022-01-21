unit UInformation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  JvExControls, JvLED;

type
  TformInformation = class(TForm)
    panelCQMode: TPanel;
    panelWpmInfo: TPanel;
    panelTime: TPanel;
    panelRigInfo: TPanel;
    Panel1: TPanel;
    ledPtt: TJvLED;
    Label1: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private êÈåæ }
    function GetCQMode(): Boolean;
    procedure SetCQMode(fCQ: Boolean);
    function GetWPM(): Integer;
    procedure SetWPM(nWpm: Integer);
    procedure SetTime(T: string);
    procedure SetRigInfo(S: string);
    procedure SetPtt(fOn: Boolean);
  public
    { Public êÈåæ }
    property CQMode: Boolean read GetCQMode write SetCQMode;
    property WPM: Integer read GetWPM write SetWPM;
    property Time: string write SetTime;
    property RigInfo: string write SetRigInfo;
    property Ptt: Boolean write SetPtt;
  end;

implementation

{$R *.dfm}

uses
  Main;

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

procedure TformInformation.SetWPM(nWpm: Integer);
begin
   panelWpmInfo.Caption := IntToStr(nWpm) + ' wpm';
end;

procedure TformInformation.SetTime(T: string);
begin
   panelTime.Caption := T;
end;

procedure TformInformation.SetRigInfo(S: string);
begin
   panelRigInfo.Caption := S;
end;

procedure TformInformation.SetPtt(fOn: Boolean);
begin
   ledPtt.Status := fOn;
end;

end.
