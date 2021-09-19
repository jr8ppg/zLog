unit UExportHamlog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TformExportHamlog = class(TForm)
    buttonOK: TButton;
    buttonCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    memoRemarks1: TMemo;
    memoRemarks2: TMemo;
    radioMemo1: TRadioButton;
    radioMemo2: TRadioButton;
    radioMemo0: TRadioButton;
    GroupBox1: TGroupBox;
    procedure radioMemo0Click(Sender: TObject);
    procedure radioMemo1Click(Sender: TObject);
    procedure radioMemo2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private êÈåæ }
    function GetMemoOutputTo(): Integer;
    function GetRemarks1(): string;
    function GetRemarks2(): string;
  public
    { Public êÈåæ }
    property MemoOutputTo: Integer read GetMemoOutputTo;
    property Remarks1: string read GetRemarks1;
    property Remarks2: string read GetRemarks2;
  end;

implementation

{$R *.dfm}

procedure TformExportHamlog.FormCreate(Sender: TObject);
begin
   radioMemo0.Checked := True;
end;

procedure TformExportHamlog.FormShow(Sender: TObject);
begin
   radioMemo0Click(nil);
end;

procedure TformExportHamlog.radioMemo0Click(Sender: TObject);
begin
   memoRemarks1.Enabled := True;
   memoRemarks2.Enabled := True;
end;

procedure TformExportHamlog.radioMemo1Click(Sender: TObject);
begin
   memoRemarks1.Enabled := False;
   memoRemarks2.Enabled := True;
end;

procedure TformExportHamlog.radioMemo2Click(Sender: TObject);
begin
   memoRemarks1.Enabled := True;
   memoRemarks2.Enabled := False;
end;

function TformExportHamlog.GetMemoOutputTo(): Integer;
begin
   if radioMemo0.Checked = True then begin
      Result := 0;
   end
   else if radioMemo1.Checked = True then begin
      Result := 1;
   end
   else begin
      Result := 2;
   end;
end;

function TformExportHamlog.GetRemarks1(): string;
begin
   Result := memoRemarks1.Text;
end;

function TformExportHamlog.GetRemarks2(): string;
begin
   Result := memoRemarks2.Text;
end;

end.
