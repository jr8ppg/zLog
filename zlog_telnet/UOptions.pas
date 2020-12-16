unit UOptions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TOptions = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    comboClusterHost: TComboBox;
    editClusterPort: TEdit;
    Label3: TLabel;
    comboClusterLineBreak: TComboBox;
    comboZServerHost: TComboBox;
    editZServerPort: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    editSpotExpire: TEdit;
    updownSpotExpire: TUpDown;
    Label7: TLabel;
    buttonOK: TButton;
    buttonCancel: TButton;
    Label8: TLabel;
    editZServerClientName: TEdit;
    GroupBox4: TGroupBox;
    radioCmdSpot: TRadioButton;
    radioCmdSpot2: TRadioButton;
    radioCmdSpot3: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
  private
    { Private êÈåæ }
    function GetSpotExpire(): Integer;
    procedure SetSpotExpire(v: Integer);
    function GetSpotGroup(): Integer;
    procedure SetSpotGroup(v: Integer);
    function GetClusterHost(): string;
    procedure SetClusterHost(v: string);
    function GetClusterPort(): string;
    procedure SetClusterPort(v: string);
    function GetClusterLineBreak(): Integer;
    procedure SetClusterLineBreak(v: Integer);
    function GetZServerHost(): string;
    procedure SetZServerHost(v: string);
    function GetZServerPort(): string;
    procedure SetZServerPort(v: string);
    function GetZServerClientName(): string;
    procedure SetZServerClientName(v: string);
  public
    { Public êÈåæ }
    property SportExpireMin: Integer read GetSpotExpire write SetSpotExpire;
    property SpotGroup: Integer read GetSpotGroup write SetSpotGroup;
    property ClusterHost: string read GetClusterHost write SetClusterHost;
    property ClusterPort: string read GetClusterPort write SetClusterPort;
    property ClusterLineBreak: Integer read GetClusterLineBreak write SetClusterLineBreak;
    property ZServerHost: string read GetZServerHost write SetZServerHost;
    property ZServerPort: string read GetZServerPort write SetZServerPort;
    property ZServerClientName: string read GetZServerClientName write SetZServerClientName;
  end;

implementation

{$R *.dfm}

procedure TOptions.FormCreate(Sender: TObject);
var
   fname: string;
begin
   updownSpotExpire.Position := 10;
   comboClusterHost.Text := '';
   editClusterPort.Text := '23';
   comboClusterLineBreak.ItemIndex := 0;

   fname := ExtractFilePath(Application.ExeName) + 'clusterlist.txt';
   if FileExists(fname) = True then begin
      comboClusterHost.Items.LoadFromFile(fname);
   end;
end;

procedure TOptions.FormDestroy(Sender: TObject);
begin
//
end;

procedure TOptions.buttonOKClick(Sender: TObject);
begin
   ModalResult := mrOK;
end;

function TOptions.GetSpotExpire(): Integer;
begin
   Result := updownSpotExpire.Position;
end;

procedure TOptions.SetSpotExpire(v: Integer);
begin
   updownSpotExpire.Position := v;
end;

function TOptions.GetSpotGroup(): Integer;
begin
   if radioCmdSpot.Checked = True then begin
      Result := 1;
   end
   else if radioCmdSpot2.Checked = True then begin
      Result := 2;
   end
   else if radioCmdSpot3.Checked = True then begin
      Result := 3;
   end
   else begin
      Result := 1;
   end;
end;

procedure TOptions.SetSpotGroup(v: Integer);
begin
   if v = 1 then begin
      radioCmdSpot.Checked := True;
   end
   else if v = 2 then begin
      radioCmdSpot2.Checked := True;
   end
   else if v = 3 then begin
      radioCmdSpot3.Checked := True;
   end
   else begin
      radioCmdSpot.Checked := True;
   end;
end;

function TOptions.GetClusterHost(): string;
begin
   Result := comboClusterHost.Text;
end;

procedure TOptions.SetClusterHost(v: string);
var
   Index: Integer;
begin
   Index := comboClusterHost.Items.IndexOf(v);
   if Index = -1 then begin
      comboClusterHost.Text := v;
   end
   else begin
      comboClusterHost.ItemIndex := Index;
   end;
end;

function TOptions.GetClusterPort(): string;
begin
   Result := editClusterPort.Text;
end;

procedure TOptions.SetClusterPort(v: string);
begin
   editClusterPort.Text := v;
end;

function TOptions.GetClusterLineBreak(): Integer;
begin
   Result := comboClusterLineBreak.ItemIndex;
end;

procedure TOptions.SetClusterLineBreak(v: Integer);
begin
   comboClusterLineBreak.ItemIndex := v;
end;

function TOptions.GetZServerHost(): string;
begin
   Result := comboZServerHost.Text;
end;

procedure TOptions.SetZServerHost(v: string);
var
   Index: Integer;
begin
   Index := comboZServerHost.Items.IndexOf(v);
   if Index = -1 then begin
      comboZServerHost.Text := v;
   end
   else begin
      comboZServerHost.ItemIndex := Index;
   end;
end;

function TOptions.GetZServerPort(): string;
begin
   Result := editZServerPort.Text;
end;

procedure TOptions.SetZServerPort(v: string);
begin
   editZServerPort.Text := v;
end;

function TOptions.GetZServerClientName(): string;
begin
   Result := editZServerClientName.Text;
end;

procedure TOptions.SetZServerClientName(v: string);
begin
   editZServerClientName.Text := v;
end;

end.
