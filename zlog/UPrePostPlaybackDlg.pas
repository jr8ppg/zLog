unit UPrePostPlaybackDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  UzLogConst, URigCtrlLib;

type
  TformPrePostPlaybackDlg = class(TForm)
    groupAudioInput: TGroupBox;
    radioInputDontCare: TRadioButton;
    radioInputMic: TRadioButton;
    radioInputUsb: TRadioButton;
    radioInputAcc: TRadioButton;
    radioInputMicUsb: TRadioButton;
    radioInputMicAcc: TRadioButton;
    groupCommand: TGroupBox;
    radioCommandNone: TRadioButton;
    radioCommand163: TRadioButton;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private êÈåæ }
    FAudioInput: array[0..5] of TRadioButton;
    FCommand: array[0..1] of TRadioButton;

    function GetAudioInput(): TAudioInput;
    procedure SetAudioInput(v: TAudioInput);
    function GetCommand(): string;
    procedure SetCommand(v: string);
  public
    { Public êÈåæ }
    property AudioInput: TAudioInput read GetAudioInput write SetAudioInput;
    property Command: string read GetCommand write SetCommand;
  end;

implementation

{$R *.dfm}

procedure TformPrePostPlaybackDlg.FormCreate(Sender: TObject);
begin
   FAudioInput[0] := radioInputDontCare;
   FAudioInput[1] := radioInputMic;
   FAudioInput[2] := radioInputUsb;
   FAudioInput[3] := radioInputAcc;
   FAudioInput[4] := radioInputMicUsb;
   FAudioInput[5] := radioInputMicAcc;
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

function TformPrePostPlaybackDlg.GetAudioInput(): TAudioInput;
var
   i: Integer;
begin
   for i := Low(FAudioInput) to High(FAudioInput) do begin
      if FAudioInput[i].Checked = True then begin
         Result := TAudioInput(FAudioInput[i].Tag);
         Exit;
      end;
   end;

   Result := aiDontCare;
end;

procedure TformPrePostPlaybackDlg.SetAudioInput(v: TAudioInput);
var
   i: Integer;
begin
   for i := Low(FAudioInput) to High(FAudioInput) do begin
      if TAudioInput(FAudioInput[i].Tag) = v then begin
         FAudioInput[i].Checked := True;
         Exit;
      end;
   end;
   FAudioInput[0].Checked := True;
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
