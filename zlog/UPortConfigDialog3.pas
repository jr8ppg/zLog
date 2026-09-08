unit UPortConfigDialog3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  UzLogConst, UzLogGlobal;

type
  TformPortConfig3 = class(TForm)
    groupPortConfig: TGroupBox;
    buttonOK: TButton;
    buttonCancel: TButton;
    radioRtsKeyDtrPtt: TRadioButton;
    radioRtsPttDtrKey: TRadioButton;
    radioTxDKeyRtsPtt: TRadioButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private êÈåæ }
    function GetPortName(): string;
    procedure SetPortName(v: string);
    function GetPortConfig(): TPortConfig;
    procedure SetPortConfig(v: TPortConfig);
  public
    { Public êÈåæ }
    property PortName: string read GetPortName write SetPortName;
    property PortConfig: TPortConfig read GetPortConfig write SetPortConfig;
  end;

implementation

{$R *.dfm}

procedure TformPortConfig3.FormCreate(Sender: TObject);
begin
//
end;

function TformPortConfig3.GetPortName(): string;
begin
   Result := groupPortConfig.Caption;
end;

procedure TformPortConfig3.SetPortName(v: string);
begin
   groupPortConfig.Caption := v;
end;

function TformPortConfig3.GetPortConfig(): TPortConfig;
var
   pc: TPortConfig;
begin
   if radioTxDKeyRtsPtt.Checked = True then begin
      pc.FRts := paPtt;
      pc.FDtr := paPtt;
      pc.FTxD := paKey;
   end
   else if radioRtsKeyDtrPtt.Checked = True then begin
      pc.FRts := paKey;
      pc.FDtr := paPtt;
      pc.FTxD := paNone;
   end
   else begin
      pc.FRts := paPtt;
      pc.FDtr := paKey;
      pc.FTxD := paNone;
   end;
   Result := pc;
end;

procedure TformPortConfig3.SetPortConfig(v: TPortConfig);
begin
   if v.FTxD = paKey then begin
      radioTxDKeyRtsPtt.Checked := True;
   end
   else if v.FRts = paKey then begin
      radioRtsKeyDtrPtt.Checked := True;
   end
   else begin
      radioRtsPttDtrKey.Checked := True;
   end;
end;

end.
