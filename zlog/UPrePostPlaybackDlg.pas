unit UPrePostPlaybackDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  UzLogConst, URigCtrlLib;

type
  TformPrePostPlaybackDlg = class(TForm)
    groupCommand: TGroupBox;
    radioCommandNone: TRadioButton;
    radioCommand163: TRadioButton;
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private êÈåæ }
    FCommand: array[0..1] of TRadioButton;
    function GetCommand(): string;
    procedure SetCommand(v: string);
  public
    { Public êÈåæ }
    property Command: string read GetCommand write SetCommand;
  end;

implementation

{$R *.dfm}

procedure TformPrePostPlaybackDlg.FormCreate(Sender: TObject);
begin
   FCommand[0] := radioCommandNone;
   FCommand[1] := radioCommand163;
end;

procedure TformPrePostPlaybackDlg.FormDestroy(Sender: TObject);
begin
//
end;

procedure TformPrePostPlaybackDlg.FormShow(Sender: TObject);
begin
//
end;

function TformPrePostPlaybackDlg.GetCommand(): string;
var
   i: Integer;
begin
   for i := Low(FCommand) to High(FCommand) do begin
      if FCommand[i].Checked = True then begin
         Result := IntToStr(FCommand[i].Tag);
         Exit;
      end;
   end;

   Result := '';
end;

procedure TformPrePostPlaybackDlg.SetCommand(v: string);
var
   i: Integer;
begin
   for i := Low(FCommand) to High(FCommand) do begin
      if IntToStr(FCommand[i].Tag) = v then begin
         FCommand[i].Checked := True;
         Exit;
      end;
   end;
   FCommand[0].Checked := True;
end;

end.
