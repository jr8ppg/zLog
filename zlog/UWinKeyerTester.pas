unit UWinKeyerTester;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TformWinkeyerTester = class(TForm)
    groupPinCfg: TGroupBox;
    buttonPinCfgB7: TSpeedButton;
    buttonPinCfgB6: TSpeedButton;
    buttonPinCfgB5: TSpeedButton;
    buttonPinCfgB4: TSpeedButton;
    buttonPinCfgB3: TSpeedButton;
    buttonPinCfgB2: TSpeedButton;
    buttonPinCfgB1: TSpeedButton;
    buttonPinCfgB0: TSpeedButton;
    Label1: TLabel;
    buttonSetPinCfg: TButton;
    panelPinCfgParam: TPanel;
    groupPtt: TGroupBox;
    buttonPttCmd: TSpeedButton;
    groupMessage: TGroupBox;
    editMessage: TEdit;
    buttonSendMessage: TButton;
    GroupBox1: TGroupBox;
    buttonUsbif4cwP02: TSpeedButton;
    buttonUsbif4cwP03: TSpeedButton;
    buttonUsbif4cwP04: TSpeedButton;
    SpeedButton1: TSpeedButton;
    procedure buttonPinCfgBitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonPttCmdClick(Sender: TObject);
    procedure buttonSetPinCfgClick(Sender: TObject);
    procedure buttonSendMessageClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buttonUsbif4cwP00Click(Sender: TObject);
  private
    { Private êÈåæ }
    FPinCfgBit: array[0..7] of TSpeedButton;
    function GetPinCfgParam(): Byte;
  public
    { Public êÈåæ }
  end;


implementation

uses
  UzLogKeyer, WinKeyer;

{$R *.dfm}

procedure TformWinkeyerTester.buttonPttCmdClick(Sender: TObject);
var
   p: Byte;
begin
   if TSpeedButton(Sender).Down = True then begin
      p := 1;
   end
   else begin
      p := 0;
   end;

   dmZLogKeyer.WinKeyerSendCommand(WK_PTT_CMD, p);
end;

procedure TformWinkeyerTester.FormCreate(Sender: TObject);
begin
   FPinCfgBit[0] := buttonPinCfgB0;
   FPinCfgBit[1] := buttonPinCfgB1;
   FPinCfgBit[2] := buttonPinCfgB2;
   FPinCfgBit[3] := buttonPinCfgB3;
   FPinCfgBit[4] := buttonPinCfgB4;
   FPinCfgBit[5] := buttonPinCfgB5;
   FPinCfgBit[6] := buttonPinCfgB6;
   FPinCfgBit[7] := buttonPinCfgB7;
end;

procedure TformWinkeyerTester.FormShow(Sender: TObject);
begin
   buttonPinCfgBitClick(nil);
end;

procedure TformWinkeyerTester.buttonSendMessageClick(Sender: TObject);
begin
   dmZLogKeyer.WinKeyerSendMessage(editMessage.Text);
end;

procedure TformWinkeyerTester.buttonPinCfgBitClick(Sender: TObject);
var
   p: Integer;
begin
   p := GetPinCfgParam();
   panelPinCfgParam.Caption := IntToHex(p, 2);
end;

procedure TformWinkeyerTester.buttonSetPinCfgClick(Sender: TObject);
var
   p: Byte;
begin
   p := GetPinCfgParam();
   dmZLogKeyer.WinKeyerSendCommand(WK_SET_PINCFG_CMD, p);

   dmZLogKeyer.WinKeyerSendCommand(WK_PTT_CMD, 0);
end;

procedure TformWinkeyerTester.buttonUsbif4cwP00Click(Sender: TObject);
var
   port: Integer;
begin
   port := TSpeedButton(Sender).Tag;
   if (TSpeedButton(Sender).Down = True) then begin
      dmZLogKeyer.usbif4cwSetPort(port, True);
   end
   else begin
      dmZLogKeyer.usbif4cwSetPort(port, False);
   end;
end;

function TformWinKeyerTester.GetPinCfgParam(): Byte;
var
   i: Integer;
   b: Integer;
   p: Byte;
begin
   p := 0;
   for i := 0 to 7 do begin
      if FPinCfgBit[i].Down = True then begin
         b := FPinCfgBit[i].Tag;
         p := p or ($01 shl b);
      end;
   end;

   Result := p;
end;

end.
