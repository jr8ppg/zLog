unit UOptions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Samples.Spin;

type
  TformOptions = class(TForm)
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    GroupBox2: TGroupBox;
    editHamlogDatabase: TEdit;
    buttonHamlogRef: TButton;
    OpenDialog1: TOpenDialog;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    spinMaxCount: TSpinEdit;
    Label2: TLabel;
    checkIncremental: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    spinPastYears: TSpinEdit;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buttonHamlogRefClick(Sender: TObject);
  private
    { Private êÈåæ }
    function GetDatabaseName(): string;
    procedure SetDatabaseName(v: string);
    function GetDisplayCount(): Integer;
    procedure SetDisplayCount(v: Integer);
    function GetPastYears(): Integer;
    procedure SetPastYears(v: Integer);
    function GetIncremental(): Boolean;
    procedure SetIncremental(v: Boolean);
  public
    { Public êÈåæ }
    property DatabaseName: string read GetDatabaseName write SetDatabaseName;
    property DisplayCount: Integer read GetDisplayCount write SetDisplayCount;
    property PastYears: Integer read GetPastYears write SetPastYears;
    property Incremental: Boolean read GetIncremental write SetIncremental;
  end;

implementation

{$R *.dfm}

procedure TformOptions.FormCreate(Sender: TObject);
begin
//
end;

procedure TformOptions.FormDestroy(Sender: TObject);
begin
//
end;

procedure TformOptions.FormShow(Sender: TObject);
begin
//
end;

procedure TformOptions.buttonHamlogRefClick(Sender: TObject);
begin
   if editHamlogDatabase.Text = '' then begin
      OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
   end
   else begin
      OpenDialog1.InitialDir := ExtractFilePath(editHamlogDatabase.Text);
   end;

   if OpenDialog1.Execute(Handle) = False then begin
      Exit;
   end;

   editHamlogDatabase.Text := OpenDialog1.FileName;
end;

function TformOptions.GetDatabaseName(): string;
begin
   Result := editHamlogDatabase.Text;
end;

procedure TformOptions.SetDatabaseName(v: string);
begin
   editHamlogDatabase.Text := v;
end;

function TformOptions.GetDisplayCount(): Integer;
begin
   Result := spinMaxCount.Value;
end;

procedure TformOptions.SetDisplayCount(v: Integer);
begin
   spinMaxCount.Value := v;
end;

function TformOptions.GetPastYears(): Integer;
begin
   Result := spinPastYears.Value;
end;

procedure TformOptions.SetPastYears(v: Integer);
begin
   spinPastYears.Value := v;
end;

function TformOptions.GetIncremental(): Boolean;
begin
   Result := checkIncremental.Checked;
end;

procedure TformOptions.SetIncremental(v: Boolean);
begin
   checkIncremental.Checked := v;
end;

end.
