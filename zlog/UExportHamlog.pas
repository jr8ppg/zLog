unit UExportHamlog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TformExportHamlog = class(TForm)
    buttonOK: TButton;
    buttonCancel: TButton;
    editRemarks1Opt1: TMemo;
    editRemarks2Opt1: TMemo;
    radioRemarks1Opt2: TRadioButton;
    radioRemarks1Opt3: TRadioButton;
    radioRemarks1Opt1: TRadioButton;
    GroupBox1: TGroupBox;
    groupRemarks1: TGroupBox;
    groupRemarks2: TGroupBox;
    radioRemarks2Opt1: TRadioButton;
    radioRemarks2Opt2: TRadioButton;
    radioRemarks2Opt3: TRadioButton;
    procedure radioRemarks1Opt1Click(Sender: TObject);
    procedure radioRemarks1Opt2Click(Sender: TObject);
    procedure radioRemarks1Opt3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure radioRemarks2Opt1Click(Sender: TObject);
    procedure radioRemarks2Opt2Click(Sender: TObject);
    procedure radioRemarks2Opt3Click(Sender: TObject);
  private
    { Private êÈåæ }
    function GetRemarks1Option(): Integer;
    function GetRemarks2Option(): Integer;
    function GetRemarks1(): string;
    function GetRemarks2(): string;
  public
    { Public êÈåæ }
    property Remarks1Option: Integer read GetRemarks1Option;
    property Remarks2Option: Integer read GetRemarks2Option;
    property Remarks1: string read GetRemarks1;
    property Remarks2: string read GetRemarks2;
  end;

implementation

{$R *.dfm}

procedure TformExportHamlog.FormCreate(Sender: TObject);
begin
   radioRemarks1Opt2.Checked := True;
   radioRemarks2Opt3.Checked := True;
end;

procedure TformExportHamlog.FormShow(Sender: TObject);
begin
   radioRemarks1Opt2Click(nil);
   radioRemarks2Opt3Click(nil);
end;

procedure TformExportHamlog.radioRemarks1Opt1Click(Sender: TObject);
begin
   editRemarks1Opt1.Enabled := True;
   editRemarks1Opt1.SetFocus();
end;

procedure TformExportHamlog.radioRemarks1Opt2Click(Sender: TObject);
begin
   editRemarks1Opt1.Enabled := False;
end;

procedure TformExportHamlog.radioRemarks1Opt3Click(Sender: TObject);
begin
   editRemarks1Opt1.Enabled := False;
end;

procedure TformExportHamlog.radioRemarks2Opt1Click(Sender: TObject);
begin
   editRemarks2Opt1.Enabled := True;
   editRemarks2Opt1.SetFocus();
end;

procedure TformExportHamlog.radioRemarks2Opt2Click(Sender: TObject);
begin
   editRemarks2Opt1.Enabled := False;
end;

procedure TformExportHamlog.radioRemarks2Opt3Click(Sender: TObject);
begin
   editRemarks2Opt1.Enabled := False;
end;

function TformExportHamlog.GetRemarks1Option(): Integer;
begin
   if radioRemarks1Opt1.Checked = True then begin
      Result := 0;
   end
   else if radioRemarks1Opt2.Checked = True then begin
      Result := 1;
   end
   else begin
      Result := 2;
   end;
end;

function TformExportHamlog.GetRemarks2Option(): Integer;
begin
   if radioRemarks2Opt1.Checked = True then begin
      Result := 0;
   end
   else if radioRemarks2Opt2.Checked = True then begin
      Result := 1;
   end
   else begin
      Result := 2;
   end;
end;

function TformExportHamlog.GetRemarks1(): string;
begin
   Result := editRemarks1Opt1.Text;
end;

function TformExportHamlog.GetRemarks2(): string;
begin
   Result := editRemarks2Opt1.Text;
end;

end.
