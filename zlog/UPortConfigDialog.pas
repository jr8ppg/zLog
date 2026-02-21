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
   comboRts.Items.CommaText := RigPortActionList;
   comboRts.ItemIndex := 0;
   comboDtr.Items.CommaText := RigPortActionList;
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
const
   RigPortAction: array[0..3] of TPortAction = ( paNone, paAlwaysOn, paAlwaysOff, paHandshake );
var
   pc: TPortConfig;
begin
   pc.FRts := RigPortAction[comboRts.ItemIndex];
   pc.FDtr := RigPortAction[comboDtr.ItemIndex];
   Result := pc;
end;

procedure TformPortConfig.SetPortConfig(v: TPortConfig);
const
   RevRigPortOption: array[paNone..paHandshake] of Integer = ( 0, 0, 0, 1, 2, 3 );
begin
   comboRts.ItemIndex := RevRigPortOption[v.FRts];
   comboDtr.ItemIndex := RevRigPortOption[v.FDtr];
end;

end.
