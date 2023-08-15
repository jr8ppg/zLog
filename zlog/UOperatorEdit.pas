unit UOperatorEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.StrUtils,
  UzlogConst, UzLogOperatorInfo, UOperatorPowerDialog, Vcl.ComCtrls;

type
  TformOperatorEdit = class(TForm)
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    groupVoiceFiles1: TGroupBox;
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
    groupOpsInfo: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    editCallsign: TEdit;
    editPower: TEdit;
    Label3: TLabel;
    editAge: TEdit;
    Label4: TLabel;
    OpenDialog1: TOpenDialog;
    groupVoiceFiles2: TGroupBox;
    editCQMessage2: TEdit;
    editCQMessage3: TEdit;
    buttonCQMessage2Ref: TButton;
    buttonCQMessage3Ref: TButton;
    PageControl1: TPageControl;
    tabsheetCwMessages: TTabSheet;
    tabsheetVoiceFiles: TTabSheet;
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
    Label5: TLabel;
    Label6: TLabel;
    groupCwMessages1: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    editCwMessageA01: TEdit;
    editCwMessageA02: TEdit;
    editCwMessageA03: TEdit;
    editCwMessageA04: TEdit;
    editCwMessageA05: TEdit;
    editCwMessageA06: TEdit;
    editCwMessageA07: TEdit;
    editCwMessageA08: TEdit;
    editCwMessageA09: TEdit;
    editCwMessageA10: TEdit;
    editCwMessageA11: TEdit;
    editCwMessageA12: TEdit;
    groupCwMessages2: TGroupBox;
    Label19: TLabel;
    Label28: TLabel;
    editAdditionalCwMessage2: TEdit;
    editAdditionalCwMessage3: TEdit;
    Panel2: TPanel;
    buttonCopyDefaultMsgs: TButton;
    buttonClearAll: TButton;
    editCwMessageB01: TEdit;
    editCwMessageB02: TEdit;
    editCwMessageB03: TEdit;
    editCwMessageB04: TEdit;
    editCwMessageB05: TEdit;
    editCwMessageB06: TEdit;
    editCwMessageB07: TEdit;
    editCwMessageB08: TEdit;
    editCwMessageB09: TEdit;
    editCwMessageB10: TEdit;
    editCwMessageB11: TEdit;
    editCwMessageB12: TEdit;
    Label29: TLabel;
    Label30: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonVoiceRefClick(Sender: TObject);
    procedure editPowerExit(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buttonCQMessageRefClick(Sender: TObject);
    procedure editPowerDblClick(Sender: TObject);
    procedure buttonCopyDefaultMsgsClick(Sender: TObject);
    procedure buttonClearAllClick(Sender: TObject);
  private
    { Private êÈåæ }
    // CW
    FCwMessageAEdit: array[1..maxmessage] of TEdit;
    FCwMessageBEdit: array[1..maxmessage] of TEdit;
    FAdditionalCwMessageEdit: array[2..3] of TEdit;

    // PHONE
    FVoiceFileEdit: array[1..maxmessage] of TEdit;
    FVoiceRefButton: array[1..maxmessage] of TButton;
    FAdditionalVoiceFileEdit: array[2..3] of TEdit;
    FAdditionalVoiceRefButton: array[2..3] of TButton;
    procedure CopyCwMessages();
    procedure ClearCwMessages();
  public
    { Public êÈåæ }
    procedure GetObject(obj: TOperatorInfo);
    procedure SetObject(obj: TOperatorInfo);
  end;

resourcestring
  PLEASE_ENTER_OPS_CALLSIGN = 'Please enter the operator''s callsign';

implementation

uses
  UzLogGlobal;

{$R *.dfm}

procedure TformOperatorEdit.FormCreate(Sender: TObject);
var
   i: Integer;
begin
   editCallsign.Text := '';
   editPower.Text := '';
   editAge.Text := '';

   FCwMessageAEdit[1] := editCwMessageA01;
   FCwMessageAEdit[2] := editCwMessageA02;
   FCwMessageAEdit[3] := editCwMessageA03;
   FCwMessageAEdit[4] := editCwMessageA04;
   FCwMessageAEdit[5] := editCwMessageA05;
   FCwMessageAEdit[6] := editCwMessageA06;
   FCwMessageAEdit[7] := editCwMessageA07;
   FCwMessageAEdit[8] := editCwMessageA08;
   FCwMessageAEdit[9] := editCwMessageA09;
   FCwMessageAEdit[10] := editCwMessageA10;
   FCwMessageAEdit[11] := editCwMessageA11;
   FCwMessageAEdit[12] := editCwMessageA12;
   FCwMessageBEdit[1] := editCwMessageB01;
   FCwMessageBEdit[2] := editCwMessageB02;
   FCwMessageBEdit[3] := editCwMessageB03;
   FCwMessageBEdit[4] := editCwMessageB04;
   FCwMessageBEdit[5] := editCwMessageB05;
   FCwMessageBEdit[6] := editCwMessageB06;
   FCwMessageBEdit[7] := editCwMessageB07;
   FCwMessageBEdit[8] := editCwMessageB08;
   FCwMessageBEdit[9] := editCwMessageB09;
   FCwMessageBEdit[10] := editCwMessageB10;
   FCwMessageBEdit[11] := editCwMessageB11;
   FCwMessageBEdit[12] := editCwMessageB12;
   FAdditionalCwMessageEdit[2] := editAdditionalCwMessage2;
   FAdditionalCwMessageEdit[3] := editAdditionalCwMessage3;

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

   ClearCwMessages();

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

procedure TformOperatorEdit.buttonOKClick(Sender: TObject);
begin
   if editCallsign.Text = '' then begin
      Application.MessageBox(PChar(PLEASE_ENTER_OPS_CALLSIGN), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
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

procedure TformOperatorEdit.buttonClearAllClick(Sender: TObject);
begin
   ClearCwMessages();
end;

procedure TformOperatorEdit.buttonCopyDefaultMsgsClick(Sender: TObject);
begin
   CopyCwMessages();
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

procedure TformOperatorEdit.editPowerDblClick(Sender: TObject);
var
   dlg: TOperatorPowerDialog;
begin
   dlg := TOperatorPowerDialog.Create(Self);
   try
      dlg.Power := editPower.Text;

      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

      editPower.Text := dlg.Power;
   finally
      dlg.Release();
   end;
end;

procedure TformOperatorEdit.editPowerExit(Sender: TObject);
begin
   if editPower.Text <> '' then begin
      editPower.Text := Copy(editPower.Text + DupeString('-', 13), 1, 13);
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
      obj.CwMessages[1, i] := FCwMessageAEdit[i].Text;
      obj.CwMessages[2, i] := FCwMessageBEdit[i].Text;
   end;
   obj.AdditionalCwMessages[2] := FAdditionalCwMessageEdit[2].Text;
   obj.AdditionalCwMessages[3] := FAdditionalCwMessageEdit[3].Text;

   for i := 1 to maxmessage do begin
      obj.VoiceFiles[i] := FVoiceFileEdit[i].Text;
   end;
   obj.AdditionalVoiceFiles[2] := FAdditionalVoiceFileEdit[2].Text;
   obj.AdditionalVoiceFiles[3] := FAdditionalVoiceFileEdit[3].Text;
end;

procedure TformOperatorEdit.SetObject(obj: TOperatorInfo);
var
   i: Integer;
begin
   editCallsign.Text := obj.Callsign;
   editPower.Text := obj.Power;
   editAge.Text := obj.Age;

   for i := 1 to maxmessage do begin
      FCwMessageAEdit[i].Text := obj.CwMessages[1, i];
      FCwMessageBEdit[i].Text := obj.CwMessages[2, i];
   end;
   FAdditionalCwMessageEdit[2].Text := obj.AdditionalCwMessages[2];
   FAdditionalCwMessageEdit[3].Text := obj.AdditionalCwMessages[3];

   for i := 1 to maxmessage do begin
      FVoiceFileEdit[i].Text := obj.VoiceFiles[i];
   end;
   FAdditionalVoiceFileEdit[2].Text := obj.AdditionalVoiceFiles[2];
   FAdditionalVoiceFileEdit[3].Text := obj.AdditionalVoiceFiles[3];

   editCallsign.ReadOnly := True;
   editCallsign.Color := clBtnFace;
end;

procedure TformOperatorEdit.CopyCwMessages();
var
   i: Integer;
begin
   for i := 1 to maxmessage do begin
      if FCwMessageAEdit[i].Text = '' then begin
         FCwMessageAEdit[i].Text := dmZLogGlobal.Settings.CW.CWStrBank[1, i];
      end;
      if FCwMessageBEdit[i].Text = '' then begin
         FCwMessageBEdit[i].Text := dmZLogGlobal.Settings.CW.CWStrBank[2, i];
      end;
   end;
   if FAdditionalCwMessageEdit[2].Text = '' then begin
      FAdditionalCwMessageEdit[2].Text := dmZLogGlobal.Settings.CW.AdditionalCQMessages[2];
   end;
   if FAdditionalCwMessageEdit[3].Text = '' then begin
      FAdditionalCwMessageEdit[3].Text := dmZLogGlobal.Settings.CW.AdditionalCQMessages[3];
   end;
end;

procedure TformOperatorEdit.ClearCwMessages();
var
   i: Integer;
begin
   for i := 1 to maxmessage do begin
      FCwMessageAEdit[i].Text := '';
      FCwMessageBEdit[i].Text := '';
   end;
   FAdditionalCwMessageEdit[2].Text := '';
   FAdditionalCwMessageEdit[3].Text := '';
end;

end.
