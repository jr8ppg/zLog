unit UOptions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Samples.Spin, UTelnetSetting, UClusterTelnetSet, USpotterListDlg;

type
  TOptions = class(TForm)
    GroupBox2: TGroupBox;
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
    Panel1: TPanel;
    groupPacketCluster: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    buttonSpotterList: TButton;
    listviewPacketCluster: TListView;
    buttonClusterAdd: TButton;
    buttonClusterEdit: TButton;
    buttonClusterDelete: TButton;
    spForceReconnectIntervalHour: TSpinEdit;
    spMaxAutoReconnect: TSpinEdit;
    spAutoReconnectIntervalSec: TSpinEdit;
    checkAutoLogin: TCheckBox;
    checkAutoReconnect: TCheckBox;
    checkRecordLogs: TCheckBox;
    checkUseAllowDenyLists: TCheckBox;
    checkForceReconnect: TCheckBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    checkUseSecure: TCheckBox;
    editUserPassword: TEdit;
    editUserId: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure buttonClusterAddClick(Sender: TObject);
    procedure buttonClusterEditClick(Sender: TObject);
    procedure buttonClusterDeleteClick(Sender: TObject);
    procedure buttonSpotterListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure listviewPacketClusterDblClick(Sender: TObject);
    procedure listviewPacketClusterSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private êÈåæ }
    FPacketClusterList: TTelnetSettingList;
    function GetSpotExpire(): Integer;
    procedure SetSpotExpire(v: Integer);
    function GetSpotGroup(): Integer;
    procedure SetSpotGroup(v: Integer);
    function GetClusterAutoLogin(): Boolean;
    procedure SetClusterAutoLogin(v: Boolean);
    function GetClusterAutoReconnect(): Boolean;
    procedure SetClusterAutoReconnect(v: Boolean);
    function GetClusterRecordLogs(): Boolean;
    procedure SetClusterRecordLogs(v: Boolean);

    function GetReConnectMax(): Integer;
    procedure SetReConnectMax(v: Integer);
    function GetRetryIntervalSec(): Integer;
    procedure SetRetryIntervalSec(v: Integer);
    function GetUseForceReconnect(): Boolean;
    procedure SetUseForceReconnect(v: Boolean);
    function GetForceReconnectIntervalMin(): Integer;
    procedure SetForceReconnectIntervalMin(v: Integer);

    function GetClusterUseAllowDenyLists(): Boolean;
    procedure SetClusterUseAllowDenyLists(v: Boolean);
    function GetZServerHost(): string;
    procedure SetZServerHost(v: string);
    function GetZServerPort(): string;
    procedure SetZServerPort(v: string);
    function GetZServerClientName(): string;
    procedure SetZServerClientName(v: string);
    procedure PacketClusterListToListView();
    procedure PacketClusterListViewToList();
    procedure AddPacketClusterList(setting: TTelnetSetting);
    procedure ListViewClear();
    function GetZServerUseSecure(): Boolean;
    procedure SetZServerUseSecure(v: Boolean);
    function GetZServerLoginID(): string;
    procedure SetZServerLoginID(v: string);
    function GetZServerLoginPassword(): string;
    procedure SetZServerLoginPassword(v: string);
  public
    { Public êÈåæ }
    property SportExpireMin: Integer read GetSpotExpire write SetSpotExpire;
    property SpotGroup: Integer read GetSpotGroup write SetSpotGroup;
    property ClusterAutoLogin: Boolean read GetClusterAutoLogin write SetClusterAutoLogin;
    property ClusterAutoReconnect: Boolean read GetClusterAutoReconnect write SetClusterAutoReconnect;
    property ClusterRecordLogs: Boolean read GetClusterRecordLogs write SetClusterRecordLogs;
    property ClusterUseAllowDenyLists: Boolean read GetClusterUseAllowDenyLists write SetClusterUseAllowDenyLists;

    property ReConnectMax: Integer read GetReConnectMax write SetReConnectMax;
    property RetryIntervalSec: Integer read GetRetryIntervalSec write SetRetryIntervalSec;
    property UseForceReconnect: Boolean read GetUseForceReconnect write SetUseForceReconnect;
    property ForceReconnectIntervalMin: Integer read GetForceReconnectIntervalMin write SetForceReconnectIntervalMin;

    property PacketClusterList: TTelnetSettingList read FPacketClusterList write FPacketClusterList;
    property ZServerHost: string read GetZServerHost write SetZServerHost;
    property ZServerPort: string read GetZServerPort write SetZServerPort;
    property ZServerClientName: string read GetZServerClientName write SetZServerClientName;
    property ZServerUseSecure: Boolean read GetZServerUseSecure write SetZServerUseSecure;
    property ZServerLoginID: string read GetZServerLoginID write SetZServerLoginID;
    property ZServerLoginPassword: string read GetZServerLoginPassword write SetZServerLoginPassword;
  end;

implementation

{$R *.dfm}

procedure TOptions.FormCreate(Sender: TObject);
begin
   updownSpotExpire.Position := 10;
   FPacketClusterList := nil;
end;

procedure TOptions.FormDestroy(Sender: TObject);
begin
   //
end;

procedure TOptions.FormShow(Sender: TObject);
begin
   PacketClusterListToListView();
end;

procedure TOptions.buttonOKClick(Sender: TObject);
begin
   PacketClusterListViewToList();
   ModalResult := mrOK;
end;

procedure TOptions.buttonClusterAddClick(Sender: TObject);
var
   f: TformClusterTelnetSet;
   setting: TTelnetSetting;
begin
   f := TformClusterTelnetSet.Create(Self);
   try
      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      setting := f.Setting;

      AddPacketClusterList(setting);
   finally
      f.Release();
   end;
end;

procedure TOptions.buttonClusterEditClick(Sender: TObject);
var
   f: TformClusterTelnetSet;
   setting: TTelnetSetting;
   listitem: TListItem;
begin
   listitem := listviewPacketCluster.Selected;
   setting := TTelnetSetting(listitem.Data);
   f := TformClusterTelnetSet.Create(Self);
   try
      f.Setting := setting;

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      setting.Free();
      setting := f.Setting;

      if setting.Name = '' then begin
         setting.Name := listitem.Caption;
      end;

      listitem.SubItems[0] := setting.Name;
      listitem.SubItems[1] := setting.HostName;
      listitem.SubItems[2] := setting.LoginId;
      listitem.Data := setting;
   finally
      f.Release();
   end;
end;

procedure TOptions.buttonClusterDeleteClick(Sender: TObject);
var
   setting: TTelnetSetting;
   listitem: TListItem;
   i: Integer;
begin
   listitem := listviewPacketCluster.Selected;
   setting := TTelnetSetting(listitem.Data);
   setting.Free();
   listitem.Delete();

   for i := 0 to listviewPacketCluster.Items.Count - 1 do begin
      listitem := listviewPacketCluster.Items[i];
      listitem.Caption := '#' + IntToStr(i + 1);
   end;
end;

procedure TOptions.buttonSpotterListClick(Sender: TObject);
var
   dlg: TformSpotterListDlg;
begin
   dlg := TformSpotterListDlg.Create(Self);
   try

      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

   finally
      dlg.Release();
   end;
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

function TOptions.GetClusterAutoLogin(): Boolean;
begin
   Result := checkAutoLogin.Checked;
end;

procedure TOptions.SetClusterAutoLogin(v: Boolean);
begin
   checkAutoLogin.Checked := v;
end;

function TOptions.GetClusterAutoReconnect(): Boolean;
begin
   Result := checkAutoReconnect.Checked;
end;

procedure TOptions.SetClusterAutoReconnect(v: Boolean);
begin
   checkAutoReconnect.Checked := v;
end;

function TOptions.GetClusterRecordLogs(): Boolean;
begin
   Result := checkRecordLogs.Checked;
end;

procedure TOptions.SetClusterRecordLogs(v: Boolean);
begin
   checkRecordLogs.Checked := v;
end;

function TOptions.GetReConnectMax(): Integer;
begin
   Result := spMaxAutoReconnect.Value;
end;

procedure TOptions.SetReConnectMax(v: Integer);
begin
   spMaxAutoReconnect.Value := v;
end;

function TOptions.GetRetryIntervalSec(): Integer;
begin
   Result := spAutoReconnectIntervalSec.Value;
end;

procedure TOptions.SetRetryIntervalSec(v: Integer);
begin
   spAutoReconnectIntervalSec.Value := v;
end;

function TOptions.GetUseForceReconnect(): Boolean;
begin
   Result := checkForceReconnect.Checked;
end;

procedure TOptions.SetUseForceReconnect(v: Boolean);
begin
   checkForceReconnect.Checked := v;
end;

function TOptions.GetForceReconnectIntervalMin(): Integer;
begin
   Result := spForceReconnectIntervalHour.Value * 60;
end;

procedure TOptions.SetForceReconnectIntervalMin(v: Integer);
begin
   spForceReconnectIntervalHour.Value := v div 60;
end;

function TOptions.GetClusterUseAllowDenyLists(): Boolean;
begin
   Result := checkUseAllowDenyLists.Checked;
end;

procedure TOptions.SetClusterUseAllowDenyLists(v: Boolean);
begin
   checkUseAllowDenyLists.Checked := v;
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

function TOptions.GetZServerUseSecure(): Boolean;
begin
   Result := checkUseSecure.Checked;
end;

procedure TOptions.SetZServerUseSecure(v: Boolean);
begin
   checkUseSecure.Checked := v;
end;

function TOptions.GetZServerLoginID(): string;
begin
   Result := editUserId.Text;
end;

procedure TOptions.SetZServerLoginID(v: string);
begin
   editUserId.Text := v;
end;

function TOptions.GetZServerLoginPassword(): string;
begin
   Result := editUserPassword.Text;
end;

procedure TOptions.SetZServerLoginPassword(v: string);
begin
   editUserPassword.Text := v;
end;

procedure TOptions.PacketClusterListToListView();
var
   i: Integer;
   obj: TTelnetSetting;
begin
   ListViewClear();

   for i := 0 to FPacketClusterList.Count - 1 do begin
      obj := TTelnetSetting.Create();
      obj.Assign(FPacketClusterList[i]);
      AddPacketClusterList(obj);
   end;
end;

procedure TOptions.PacketClusterListViewToList();
var
   i: Integer;
   obj: TTelnetSetting;
begin
   FPacketClusterList.Clear();
   for i := 0 to listviewPacketCluster.Items.Count - 1 do begin
      obj := TTelnetSetting.Create();
      obj.Assign(TTelnetSetting(listviewPacketCluster.Items[i].Data));
      FPacketClusterList.Add(obj);
   end;
end;

procedure TOptions.AddPacketClusterList(setting: TTelnetSetting);
var
   listitem: TListItem;
begin
   listitem := listviewPacketCluster.Items.Add();
   listitem.Caption := '#' + IntToStr(listviewPacketCluster.Items.Count);

   if setting.Name = '' then begin
      setting.Name := listitem.Caption;
   end;

   listitem.SubItems.Add(setting.Name);
   listitem.SubItems.Add(setting.HostName);
   listitem.SubItems.Add(setting.LoginId);
   listitem.Data := setting;
end;

procedure TOptions.ListViewClear();
var
   i: Integer;
begin
   for i := 0 to listviewPacketCluster.Items.Count - 1 do begin
      TTelnetSetting(listviewPacketCluster.Items[i].Data).Free();
   end;
   listviewPacketCluster.Items.Clear();
end;

procedure TOptions.listviewPacketClusterDblClick(Sender: TObject);
begin
   if listviewPacketCluster.Selected = nil then begin
      Exit;
   end;

   buttonClusterEdit.Click();
end;

procedure TOptions.listviewPacketClusterSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
   buttonClusterEdit.Enabled := Selected;
   buttonClusterDelete.Enabled := Selected;
end;

end.
