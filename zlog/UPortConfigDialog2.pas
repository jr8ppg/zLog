unit UPortConfigDialog2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  UzLogConst, UzLogGlobal;

type
  TformPortConfig2 = class(TForm)
    groupPortConfig: TGroupBox;
    buttonOK: TButton;
    buttonCancel: TButton;
    radioRtsKeyDtrPtt: TRadioButton;
    radioRtsPttDtrKey: TRadioButton;
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

procedure TformPortConfig2.FormCreate(Sender: TObject);
begin
//
end;

function TformPortConfig2.GetPortName(): string;
begin
   Result := groupPortConfig.Caption;
end;

procedure TformPortConfig2.SetPortName(v: string);
begin
   groupPortConfig.Caption := v;
end;

function TformPortConfig2.GetPortConfig(): TPortConfig;
var
   pc: TPortConfig;
begin
   if radioRtsKeyDtrPtt.Checked = True then begin
      pc.FRts := paKey;
      pc.FDtr := paPtt;
   end
   else begin
      pc.FRts := paPtt;
      pc.FDtr := paKey;
   end;
   Result := pc;
end;

procedure TformPortConfig2.SetPortConfig(v: TPortConfig);
begin
   if v.FRts = paKey then begin
      radioRtsKeyDtrPtt.Checked := True;
   end
   else begin
      radioRtsPttDtrKey.Checked := True;
   end;
end;

end.
