unit UClusterTelnetSet;

interface

uses
  WinApi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Samples.Spin,
  UTelnetSetting, UzLogGlobal;

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
    Label6: TLabel;
    memoCommands: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure editSettingNameExit(Sender: TObject);
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

procedure TformClusterTelnetSet.editSettingNameExit(Sender: TObject);
begin
   JudgeFileNameCharactor(Self, editSettingName);
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
   i: Integer;
begin
   obj := TTelnetSetting.Create();
   obj.Name := editSettingName.Text;
   obj.HostName := comboHostName.Text;
   obj.PortNumber := spPortNumber.Value;
   obj.LineBreak := comboLineBreak.ItemIndex;
   obj.LocalEcho := checkLocalEcho.Checked;
   obj.LoginId := editLoginId.Text;
   for i := memoCommands.Lines.Count - 1 downto 0 do begin
      if Trim(memoCommands.Lines[i]) = '' then begin
         memoCommands.Lines.Delete(i);
      end;
   end;
   obj.CommandList := memoCommands.Lines.CommaText;
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
   memoCommands.Lines.CommaText := v.CommandList;
end;

end.
