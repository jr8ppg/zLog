unit UFreqPanel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrequency = Int64;

type
  TformFreqPanel = class(TForm)
    Panel1: TPanel;
    buttonCancel: TButton;
    buttonOK: TButton;
    Panel2: TPanel;
    buttonBand01: TSpeedButton;
    buttonBand02: TSpeedButton;
    buttonBand03: TSpeedButton;
    buttonBand04: TSpeedButton;
    buttonBand05: TSpeedButton;
    buttonBand06: TSpeedButton;
    buttonBand07: TSpeedButton;
    buttonBand08: TSpeedButton;
    buttonBand09: TSpeedButton;
    buttonBand10: TSpeedButton;
    buttonBand11: TSpeedButton;
    buttonBand12: TSpeedButton;
    buttonBand13: TSpeedButton;
    buttonBand14: TSpeedButton;
    buttonBand15: TSpeedButton;
    buttonBand16: TSpeedButton;
    editMHz: TEdit;
    editKHz: TEdit;
    editHz: TEdit;
    procedure buttonBandClick(Sender: TObject);
    procedure editKHzChange(Sender: TObject);
    procedure editKHzExit(Sender: TObject);
  private
    { Private êÈåæ }
    procedure SetFreq(freq: TFrequency);
    function GetFreq(): TFrequency;
  public
    { Public êÈåæ }
    property Freq: TFrequency read GetFreq write SetFreq;
  end;

implementation

{$R *.dfm}

procedure TformFreqPanel.buttonBandClick(Sender: TObject);
var
   m, k: TFrequency;
begin
   m := TSpeedButton(Sender).Tag div 1000;
   k := TSpeedButton(Sender).Tag mod 1000;

   editMHz.Text := IntToStr(m);
   editKHz.Text := RightStr('000' + IntToStr(k), 3);
   editHz.Text := '000';
   editKhz.SetFocus();
end;

procedure TformFreqPanel.editKHzChange(Sender: TObject);
var
   l: Integer;
begin
   if Visible = False then begin
      Exit;
   end;

   l := Length(TEdit(Sender).Text);
   if l = 3 then begin
      editHz.SetFocus();
   end;
end;

procedure TformFreqPanel.editKHzExit(Sender: TObject);
var
   S: string;
begin
   S := TEdit(Sender).Text;
   S := RightStr('000' + S, 3);
   TEdit(Sender).Text := S;
end;

procedure TformFreqPanel.SetFreq(freq: TFrequency);
var
   m, k, h: TFrequency;
begin
   m := freq div 1000000;
   k := (freq mod 1000000) div 1000;
   h := (freq mod 1000000) mod 1000;

   editMHz.Text := IntToStr(m);
   editKHz.Text := RightStr('000' + IntToStr(k), 3);
   editHz.Text := RightStr('000' + IntToStr(h), 3);
end;

function TformFreqPanel.GetFreq(): TFrequency;
var
   m, k, h: TFrequency;
begin
   m := StrToIntDef(editMHz.Text, 7);
   k := StrToIntDef(editKHz.Text, 0);
   h := StrToIntDef(editHz.Text, 0);
   Result := (m * 1000000) + (k * 1000) + h;
end;

end.
