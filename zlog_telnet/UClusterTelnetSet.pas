unit UClusterTelnetSet;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Spin, UTelnetSetting;

type
  TformClusterTelnetSet = class(TForm)
    buttonOK: TButton;
    buttonCancel: TButton;
    comboHostName: TComboBox;
    comboLineBreak: TComboBox;
    checkLocalEcho: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    spPortNumber: TSpinEdit;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    editSettingName: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    editLoginId: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
  private
    { Private declarations }
    function GetHostName(): string;
    procedure SetHostName(v: string);
    function GetLineBreak(): Integer;
    procedure SetLineBreak(v: Integer);
    function GetPortNumber(): Integer;
    procedure SetPortNumber(v: Integer);
    function GetLocalEcho(): Boolean;
    procedure SetLocalEcho(v: Boolean);
    function GetSetting(): TTelnetSetting;
    procedure SetSetting(v: TTelnetSetting);
  public
    { Public declarations }
    property HostName: string read GetHostName write SetHostName;
    property LineBreak: Integer read GetLineBreak write SetLineBreak;
    property PortNumber: Integer read GetPortNumber write SetPortNumber;
    property LocalEcho: Boolean read GetLocalEcho write SetLocalEcho;
    property Setting: TTelnetSetting read GetSetting write SetSetting;
  end;

implementation

{$R *.DFM}

procedure TformClusterTelnetSet.FormCreate(Sender: TObject);
var
   strFileName: string;
begin
   strFileName := ExtractFilePath(Application.ExeName) + 'clusterlist.txt';
   if FileExists(strFileName) = True then begin
      comboHostName.Items.LoadFromFile(strFileName);
   end;
end;

procedure TformClusterTelnetSet.buttonOKClick(Sender: TObject);
var
   strFileName: string;
begin
   if comboHostName.Text = '' then begin
      Exit;
   end;

   strFileName := ExtractFilePath(Application.ExeName) + 'clusterlist.txt';
   if comboHostName.Items.IndexOf(comboHostName.Text) = -1 then begin
      comboHostName.Items.Add(comboHostName.Text);
   end;

   comboHostName.Items.SaveToFile(strFileName);

   ModalResult := mrOK;
end;

function TformClusterTelnetSet.GetHostName(): string;
begin
   Result := comboHostName.Text;
end;

procedure TformClusterTelnetSet.SetHostName(v: string);
begin
   comboHostName.Text := v;
end;

function TformClusterTelnetSet.GetLineBreak(): Integer;
begin
   Result := comboLineBreak.ItemIndex;
end;

procedure TformClusterTelnetSet.SetLineBreak(v: Integer);
begin
   comboLineBreak.ItemIndex := v;
end;

function TformClusterTelnetSet.GetPortNumber(): Integer;
begin
   Result := spPortNumber.Value;
end;

procedure TformClusterTelnetSet.SetPortNumber(v: Integer);
begin
   spPortNumber.Value := v;
end;

function TformClusterTelnetSet.GetLocalEcho(): Boolean;
begin
   Result := checkLocalEcho.Checked;
end;

procedure TformClusterTelnetSet.SetLocalEcho(v: Boolean);
begin
   checkLocalEcho.Checked := v;
end;

function TformClusterTelnetSet.GetSetting(): TTelnetSetting;
var
   obj: TTelnetSetting;
begin
   obj := TTelnetSetting.Create();
   obj.Name := editSettingName.Text;
   obj.HostName := comboHostName.Text;
   obj.PortNumber := spPortNumber.Value;
   obj.LineBreak := comboLineBreak.ItemIndex;
   obj.LocalEcho := checkLocalEcho.Checked;
   obj.LoginId := editLoginId.Text;
   Result := obj;
end;

procedure TformClusterTelnetSet.SetSetting(v: TTelnetSetting);
begin
   editSettingName.Text := v.Name;
   comboHostName.Text := v.HostName;
   spPortNumber.Value := v.PortNumber;
   comboLineBreak.ItemIndex := v.LineBreak;
   checkLocalEcho.Checked := v.LocalEcho;
   editLoginId.Text := v.LoginId;
end;

end.