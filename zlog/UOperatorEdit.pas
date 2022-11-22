unit UOperatorEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.StrUtils,
  UzlogConst, UzLogOperatorInfo;

type
  TformOperatorEdit = class(TForm)
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    GroupBox1: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    editVoiceFile01: TEdit;
    editVoiceFile02: TEdit;
    editVoiceFile03: TEdit;
    editVoiceFile04: TEdit;
    editVoiceFile05: TEdit;
    editVoiceFile06: TEdit;
    editVoiceFile07: TEdit;
    editVoiceFile08: TEdit;
    editVoiceFile09: TEdit;
    editVoiceFile10: TEdit;
    editVoiceFile11: TEdit;
    editVoiceFile12: TEdit;
    buttonVoiceRef01: TButton;
    buttonVoiceRef02: TButton;
    buttonVoiceRef03: TButton;
    buttonVoiceRef04: TButton;
    buttonVoiceRef05: TButton;
    buttonVoiceRef06: TButton;
    buttonVoiceRef07: TButton;
    buttonVoiceRef08: TButton;
    buttonVoiceRef09: TButton;
    buttonVoiceRef10: TButton;
    buttonVoiceRef11: TButton;
    buttonVoiceRef12: TButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    editCallsign: TEdit;
    editPower: TEdit;
    Label3: TLabel;
    editAge: TEdit;
    Label4: TLabel;
    OpenDialog1: TOpenDialog;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    editCQMessage2: TEdit;
    editCQMessage3: TEdit;
    buttonCQMessage2Ref: TButton;
    buttonCQMessage3Ref: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonVoiceRefClick(Sender: TObject);
    procedure editPowerExit(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buttonCQMessageRefClick(Sender: TObject);
  private
    { Private êÈåæ }
    FVoiceFileEdit: array[1..maxmessage] of TEdit;
    FVoiceRefButton: array[1..maxmessage] of TButton;
    FAdditionalVoiceFileEdit: array[2..3] of TEdit;
    FAdditionalVoiceRefButton: array[2..3] of TButton;
  public
    { Public êÈåæ }
    procedure GetObject(obj: TOperatorInfo);
    procedure SetObject(obj: TOperatorInfo);
  end;

implementation

uses
  UzLogGlobal;

{$R *.dfm}

procedure TformOperatorEdit.buttonOKClick(Sender: TObject);
begin
   if editCallsign.Text = '' then begin
      Application.MessageBox('Please enter the operator''s callsign', PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      editCallsign.SetFocus();
      Exit;
   end;

   ModalResult := mrOK;
end;

procedure TformOperatorEdit.buttonVoiceRefClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;
   OpenDialog1.InitialDir := dmZLogGlobal.SoundPath;
   if OpenDialog1.Execute(Self.Handle) = False then begin
      Exit;
   end;

   FVoiceFileEdit[n].Text := OpenDialog1.FileName;
end;

procedure TformOperatorEdit.buttonCQMessageRefClick(Sender: TObject);
var
   n: Integer;
begin
   n := TButton(Sender).Tag;
   OpenDialog1.InitialDir := dmZLogGlobal.SoundPath;
   if OpenDialog1.Execute(Self.Handle) = False then begin
      Exit;
   end;

   FAdditionalVoiceFileEdit[n].Text := OpenDialog1.FileName;
end;

procedure TformOperatorEdit.editPowerExit(Sender: TObject);
begin
   if editPower.Text <> '' then begin
      editPower.Text := Copy(editPower.Text + DupeString('-', 13), 1, 13);
   end;
end;

procedure TformOperatorEdit.FormCreate(Sender: TObject);
var
   i: Integer;
begin
   editCallsign.Text := '';
   editPower.Text := '';
   editAge.Text := '';

   FVoiceFileEdit[1] := editVoiceFile01;
   FVoiceFileEdit[2] := editVoiceFile02;
   FVoiceFileEdit[3] := editVoiceFile03;
   FVoiceFileEdit[4] := editVoiceFile04;
   FVoiceFileEdit[5] := editVoiceFile05;
   FVoiceFileEdit[6] := editVoiceFile06;
   FVoiceFileEdit[7] := editVoiceFile07;
   FVoiceFileEdit[8] := editVoiceFile08;
   FVoiceFileEdit[9] := editVoiceFile09;
   FVoiceFileEdit[10] := editVoiceFile10;
   FVoiceFileEdit[11] := editVoiceFile11;
   FVoiceFileEdit[12] := editVoiceFile12;
   FAdditionalVoiceFileEdit[2] := editCQMessage2;
   FAdditionalVoiceFileEdit[3] := editCQMessage3;

   FVoiceRefButton[1] := buttonVoiceRef01;
   FVoiceRefButton[2] := buttonVoiceRef02;
   FVoiceRefButton[3] := buttonVoiceRef03;
   FVoiceRefButton[4] := buttonVoiceRef04;
   FVoiceRefButton[5] := buttonVoiceRef05;
   FVoiceRefButton[6] := buttonVoiceRef06;
   FVoiceRefButton[7] := buttonVoiceRef07;
   FVoiceRefButton[8] := buttonVoiceRef08;
   FVoiceRefButton[9] := buttonVoiceRef09;
   FVoiceRefButton[10] := buttonVoiceRef10;
   FVoiceRefButton[11] := buttonVoiceRef11;
   FVoiceRefButton[12] := buttonVoiceRef12;
   FAdditionalVoiceRefButton[2] := buttonCQMessage2Ref;
   FAdditionalVoiceRefButton[3] := buttonCQMessage3Ref;

   for i := 1 to High(FVoiceFileEdit) do begin
      FVoiceFileEdit[i].Text := '';
   end;
   FAdditionalVoiceFileEdit[2].Text := '';
   FAdditionalVoiceFileEdit[3].Text := '';
end;

procedure TformOperatorEdit.FormDestroy(Sender: TObject);
begin
//
end;

procedure TformOperatorEdit.FormShow(Sender: TObject);
begin
   if editCallsign.ReadOnly = True then begin
      editPower.SetFocus();
   end
   else begin
      editCallsign.SetFocus();
   end;
end;

procedure TformOperatorEdit.GetObject(obj: TOperatorInfo);
var
   i: Integer;
begin
   obj.Callsign := editCallsign.Text;
   obj.Power := editPower.Text;
   obj.Age := editAge.Text;
   for i := 1 to maxmessage do begin
      obj.VoiceFile[i] := FVoiceFileEdit[i].Text;
   end;
   obj.AdditionalVoiceFile[2] := FAdditionalVoiceFileEdit[2].Text;
   obj.AdditionalVoiceFile[3] := FAdditionalVoiceFileEdit[3].Text;
end;

procedure TformOperatorEdit.SetObject(obj: TOperatorInfo);
var
   i: Integer;
begin
   editCallsign.Text := obj.Callsign;
   editPower.Text := obj.Power;
   editAge.Text := obj.Age;
   for i := 1 to maxmessage do begin
      FVoiceFileEdit[i].Text := obj.VoiceFile[i];
   end;
   FAdditionalVoiceFileEdit[2].Text := obj.AdditionalVoiceFile[2];
   FAdditionalVoiceFileEdit[3].Text := obj.AdditionalVoiceFile[3];

   editCallsign.ReadOnly := True;
   editCallsign.Color := clBtnFace;
end;

end.
