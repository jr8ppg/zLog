unit UPortConfigDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  UzLogConst, UzLogGlobal;

type
  TformPortConfig = class(TForm)
    groupPortConfig: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    comboRts: TComboBox;
    comboDtr: TComboBox;
    buttonOK: TButton;
    buttonCancel: TButton;
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

procedure TformPortConfig.FormCreate(Sender: TObject);
begin
   comboRts.Items.CommaText := PortActionList;
   comboRts.ItemIndex := 0;
   comboDtr.Items.CommaText := PortActionList;
   comboDtr.ItemIndex := 0;
end;

function TformPortConfig.GetPortName(): string;
begin
   Result := groupPortConfig.Caption;
end;

procedure TformPortConfig.SetPortName(v: string);
begin
   groupPortConfig.Caption := v;
end;

function TformPortConfig.GetPortConfig(): TPortConfig;
var
   pc: TPortConfig;
begin
   pc.FRts := TPortAction(comboRts.ItemIndex);
   pc.FDtr := TPortAction(comboDtr.ItemIndex);
   Result := pc;
end;

procedure TformPortConfig.SetPortConfig(v: TPortConfig);
begin
   comboRts.ItemIndex := Integer(v.FRts);
   comboDtr.ItemIndex := Integer(v.FDtr);
end;

end.
