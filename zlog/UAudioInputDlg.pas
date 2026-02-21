unit UAudioInputDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  UzLogConst, URigCtrlLib;

type
  TformAudioInputDlg = class(TForm)
    groupAudioInput: TGroupBox;
    radioPreInputDontCare: TRadioButton;
    radioPreInputMic: TRadioButton;
    radioPreInputUsb: TRadioButton;
    radioPreInputAcc: TRadioButton;
    radioPreInputMicUsb: TRadioButton;
    radioPreInputMicAcc: TRadioButton;
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    GroupBox1: TGroupBox;
    radioPostInputDontCare: TRadioButton;
    radioPostInputMic: TRadioButton;
    radioPostInputUsb: TRadioButton;
    radioPostInputAcc: TRadioButton;
    radioPostInputMicUsb: TRadioButton;
    radioPostInputMicAcc: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private êÈåæ }
    FPrePlayback: array[0..5] of TRadioButton;
    FPostPlayback: array[0..5] of TRadioButton;

    function GetPrePlayback(): TAudioInput;
    procedure SetPrePlayback(v: TAudioInput);
    function GetPostPlayback(): TAudioInput;
    procedure SetPostPlayback(v: TAudioInput);
  public
    { Public êÈåæ }
    property PrePlayback: TAudioInput read GetPrePlayback write SetPrePlayback;
    property PostPlayback: TAudioInput read GetPostPlayback write SetPostPlayback;
  end;

implementation

{$R *.dfm}

procedure TformAudioInputDlg.FormCreate(Sender: TObject);
begin
   FPrePlayback[0] := radioPreInputDontCare;
   FPrePlayback[1] := radioPreInputMic;
   FPrePlayback[2] := radioPreInputUsb;
   FPrePlayback[3] := radioPreInputAcc;
   FPrePlayback[4] := radioPreInputMicUsb;
   FPrePlayback[5] := radioPreInputMicAcc;
   FPostPlayback[0] := radioPostInputDontCare;
   FPostPlayback[1] := radioPostInputMic;
   FPostPlayback[2] := radioPostInputUsb;
   FPostPlayback[3] := radioPostInputAcc;
   FPostPlayback[4] := radioPostInputMicUsb;
   FPostPlayback[5] := radioPostInputMicAcc;
end;

procedure TformAudioInputDlg.FormDestroy(Sender: TObject);
begin
//
end;

procedure TformAudioInputDlg.FormShow(Sender: TObject);
begin
//
end;

function TformAudioInputDlg.GetPrePlayback(): TAudioInput;
var
   i: Integer;
begin
   for i := Low(FPrePlayback) to High(FPrePlayback) do begin
      if FPrePlayback[i].Checked = True then begin
         Result := TAudioInput(FPrePlayback[i].Tag);
         Exit;
      end;
   end;

   Result := aiDontCare;
end;

procedure TformAudioInputDlg.SetPrePlayback(v: TAudioInput);
var
   i: Integer;
begin
   for i := Low(FPrePlayback) to High(FPrePlayback) do begin
      if TAudioInput(FPrePlayback[i].Tag) = v then begin
         FPrePlayback[i].Checked := True;
         Exit;
      end;
   end;
   FPrePlayback[0].Checked := True;
end;

function TformAudioInputDlg.GetPostPlayback(): TAudioInput;
var
   i: Integer;
begin
   for i := Low(FPostPlayback) to High(FPostPlayback) do begin
      if FPostPlayback[i].Checked = True then begin
         Result := TAudioInput(FPostPlayback[i].Tag);
         Exit;
      end;
   end;

   Result := aiDontCare;
end;

procedure TformAudioInputDlg.SetPostPlayback(v: TAudioInput);
var
   i: Integer;
begin
   for i := Low(FPostPlayback) to High(FPostPlayback) do begin
      if TAudioInput(FPostPlayback[i].Tag) = v then begin
         FPostPlayback[i].Checked := True;
         Exit;
      end;
   end;
   FPostPlayback[0].Checked := True;
end;

end.
