unit UZlinkTelnetSet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TformZLinkTelnetSet = class(TForm)
    Label1: TLabel;
    buttonOK: TButton;
    buttonCancel: TButton;
    comboHostName: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    checkUseSecure: TCheckBox;
    Label2: TLabel;
    editUserPassword: TEdit;
    editUserId: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    comboPort: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
  private
    { Private declarations }
    function GetHostName(): string;
    procedure SetHostName(v: string);
    function GetPort(): string;
    procedure SetPort(v: string);
    function GetUseSecure(): Boolean;
    procedure SetUseSecure(v: Boolean);
    function GetLoginID(): string;
    procedure SetLoginID(v: string);
    function GetLoginPassword(): string;
    procedure SetLoginPassword(v: string);
  public
    { Public declarations }
    property HostName: string read GetHostName write SetHostName;
    property Port: string read GetPort write SetPort;
    property UseSecure: Boolean read GetUseSecure write SetUseSecure;
    property LoginID: string read GetLoginID write SetLoginID;
    property LoginPassword: string read GetLoginPassword write SetLoginPassword;
  end;

implementation

{$R *.DFM}

procedure TformZLinkTelnetSet.FormCreate(Sender: TObject);
var
   strFileName: string;
begin
   strFileName := ExtractFilePath(Application.ExeName) + 'zlinklist.txt';
   if FileExists(strFileName) = True then begin
      comboHostName.Items.LoadFromFile(strFileName);
   end;
end;

procedure TformZLinkTelnetSet.buttonOKClick(Sender: TObject);
var
   strFileName: string;
begin
   if comboHostName.Text = '' then begin
      Exit;
   end;

   strFileName := ExtractFilePath(Application.ExeName) + 'zlinklist.txt';
   if comboHostName.Items.IndexOf(comboHostName.Text) = -1 then begin
      comboHostName.Items.Add(comboHostName.Text);
   end;

   comboHostName.Items.SaveToFile(strFileName);

   ModalResult := mrOK;
end;

function TformZLinkTelnetSet.GetHostName(): string;
begin
   Result := comboHostName.Text;
end;

procedure TformZLinkTelnetSet.SetHostName(v: string);
begin
   comboHostName.Text := v;
end;

function TformZLinkTelnetSet.GetPort(): string;
begin
   Result := comboPort.Text;
end;

procedure TformZLinkTelnetSet.SetPort(v: string);
var
   Index: Integer;
begin
   Index := comboPort.Items.IndexOf(v);
   if Index = -1 then begin
      comboPort.Text := v;
   end
   else begin
      comboPort.ItemIndex := Index;
   end;
end;

function TformZLinkTelnetSet.GetUseSecure(): Boolean;
begin
   Result := checkUseSecure.Checked;
end;

procedure TformZLinkTelnetSet.SetUseSecure(v: Boolean);
begin
   checkUseSecure.Checked := v;
end;

function TformZLinkTelnetSet.GetLoginID(): string;
begin
   Result := editUserId.Text;
end;

procedure TformZLinkTelnetSet.SetLoginID(v: string);
begin
   editUserId.Text := v;
end;

function TformZLinkTelnetSet.GetLoginPassword(): string;
begin
   Result := editUserPassword.Text;
end;

procedure TformZLinkTelnetSet.SetLoginPassword(v: string);
begin
   editUserPassword.Text := v;
end;

end.
