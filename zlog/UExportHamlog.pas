unit UExportHamlog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.IniFiles;

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
    radioRemarks1Opt0: TRadioButton;
    radioRemarks2Opt0: TRadioButton;
    Panel1: TPanel;
    groupQslMark: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    editQslNone: TEdit;
    editPseQsl: TEdit;
    editNoQsl: TEdit;
    groupCode: TGroupBox;
    radioCodeOpt0: TRadioButton;
    radioCodeOpt1: TRadioButton;
    groupName: TGroupBox;
    radioNameOpt0: TRadioButton;
    radioNameOpt1: TRadioButton;
    groupTime: TGroupBox;
    radioTimeOpt0: TRadioButton;
    radioTimeOpt1: TRadioButton;
    radioTimeOpt2: TRadioButton;
    procedure radioRemarks1Opt1Click(Sender: TObject);
    procedure radioRemarks1Opt2Click(Sender: TObject);
    procedure radioRemarks1Opt3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure radioRemarks2Opt1Click(Sender: TObject);
    procedure radioRemarks2Opt2Click(Sender: TObject);
    procedure radioRemarks2Opt3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private êÈåæ }
    function GetRemarks1Option(): Integer;
    procedure SetRemarks1Option(v: Integer);
    function GetRemarks2Option(): Integer;
    procedure SetRemarks2Option(v: Integer);
    function GetRemarks1(): string;
    procedure SetRemarks1(v: string);
    function GetRemarks2(): string;
    procedure SetRemarks2(v: string);
    function GetCodeOption(): Integer;
    procedure SetCodeOption(v: Integer);
    function GetNameOption(): Integer;
    procedure SetNameOption(v: Integer);
    function GetTimeOption(): Integer;
    procedure SetTimeOption(v: Integer);
    function GetQslStateText(): string;
    procedure SetQslStateText(v: string);
    procedure Save();
    procedure Load();
  public
    { Public êÈåæ }
    property Remarks1Option: Integer read GetRemarks1Option write SetRemarks1Option;
    property Remarks2Option: Integer read GetRemarks2Option write SetRemarks2Option;
    property Remarks1: string read GetRemarks1 write SetRemarks1;
    property Remarks2: string read GetRemarks2 write SetRemarks2;
    property CodeOption: Integer read GetCodeOption write SetCodeOption;
    property NameOption: Integer read GetNameOption write SetNameOption;
    property TimeOption: Integer read GetTimeOption write SetTimeOption;
    property QslStateText: string read GetQslStateText write SetQslStateText;
  end;

implementation

{$R *.dfm}

procedure TformExportHamlog.FormCreate(Sender: TObject);
begin
   Load();
end;

procedure TformExportHamlog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Save();
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
      Result := 1;
   end
   else if radioRemarks1Opt2.Checked = True then begin
      Result := 2;
   end
   else if radioRemarks1Opt3.Checked = True then begin
      Result := 3;
   end
   else begin
      Result := 0;
   end;
end;

procedure TformExportHamlog.SetRemarks1Option(v: Integer);
begin
   case v of
      0: radioRemarks1Opt0.Checked := True;
      1: radioRemarks1Opt1.Checked := True;
      2: radioRemarks1Opt2.Checked := True;
      3: radioRemarks1Opt3.Checked := True;
      else radioRemarks1Opt0.Checked := True;
   end;
end;

function TformExportHamlog.GetRemarks2Option(): Integer;
begin
   if radioRemarks2Opt1.Checked = True then begin
      Result := 1;
   end
   else if radioRemarks2Opt2.Checked = True then begin
      Result := 2;
   end
   else if radioRemarks2Opt3.Checked = True then begin
      Result := 3;
   end
   else begin
      Result := 0;
   end;
end;

procedure TformExportHamlog.SetRemarks2Option(v: Integer);
begin
   case v of
      0: radioRemarks2Opt0.Checked := True;
      1: radioRemarks2Opt1.Checked := True;
      2: radioRemarks2Opt2.Checked := True;
      3: radioRemarks2Opt3.Checked := True;
      else radioRemarks2Opt0.Checked := True;
   end;
end;

function TformExportHamlog.GetRemarks1(): string;
begin
   Result := editRemarks1Opt1.Text;
end;

procedure TformExportHamlog.SetRemarks1(v: string);
begin
   editRemarks1Opt1.Text := v;
end;

function TformExportHamlog.GetRemarks2(): string;
begin
   Result := editRemarks2Opt1.Text;
end;

procedure TformExportHamlog.SetRemarks2(v: string);
begin
   editRemarks2Opt1.Text := v;
end;

function TformExportHamlog.GetCodeOption(): Integer;
begin
   if radioCodeOpt1.Checked = True then begin
      Result := 1;
   end
   else begin
      Result := 0;
   end;
end;

procedure TformExportHamlog.SetCodeOption(v: Integer);
begin
   case v of
      0: radioCodeOpt0.Checked := True;
      1: radioCodeOpt1.Checked := True;
      else radioCodeOpt0.Checked := True;
   end;
end;

function TformExportHamlog.GetNameOption(): Integer;
begin
   if radioNameOpt1.Checked = True then begin
      Result := 1;
   end
   else begin
      Result := 0;
   end;
end;

procedure TformExportHamlog.SetNameOption(v: Integer);
begin
   case v of
      0: radioNameOpt0.Checked := True;
      1: radioNameOpt1.Checked := True;
      else radioNameOpt0.Checked := True;
   end;
end;

function TformExportHamlog.GetTimeOption(): Integer;
begin
   if radioTimeOpt1.Checked = True then begin
      Result := 1;
   end
   else if radioTimeOpt2.Checked = True then begin
      Result := 2;
   end
   else begin
      Result := 0;
   end;
end;

procedure TformExportHamlog.SetTimeOption(v: Integer);
begin
   case v of
      0: radioTimeOpt0.Checked := True;
      1: radioTimeOpt1.Checked := True;
      2: radioTimeOpt2.Checked := True;
      else radioTimeOpt0.Checked := True;
   end;
end;

function TformExportHamlog.GetQslStateText(): string;
var
   text: string;
begin
   if editQslNone.Text = '' then begin
      text := text + ' ';
   end
   else begin
      text := text + Copy(editQslNone.Text, 1, 1);
   end;

   if editPseQsl.Text = '' then begin
      text := text + 'J';
   end
   else begin
      text := text + Copy(editPseQsl.Text, 1, 1);
   end;

   if editNoQsl.Text = '' then begin
      text := text + 'N';
   end
   else begin
      text := text + Copy(editNoQsl.Text, 1, 1);
   end;

   Result := text;
end;

procedure TformExportHamlog.SetQslStateText(v: string);
begin
   v := v + '   ';
   editQslNone.Text := Trim(Copy(v, 1, 1));
   editPseQsl.Text  := Trim(Copy(v, 2, 1));
   editNoQsl.Text   := Trim(Copy(v, 3, 1));
end;

procedure TformExportHamlog.Save();
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'hamlogexport.ini');
   try
      ini.WriteInteger('OPTION', 'remarks1option', Remarks1Option);
      ini.WriteString('OPTION', 'remarks1text', Remarks1);
      ini.WriteInteger('OPTION', 'remarks2option', Remarks2Option);
      ini.WriteString('OPTION', 'remarks2text', Remarks2);
      ini.WriteInteger('OPTION', 'codeoption', CodeOption);
      ini.WriteInteger('OPTION', 'nameoption', NameOption);
      ini.WriteInteger('OPTION', 'timeoption', TimeOption);
   finally
      ini.Free();
   end;
end;

procedure TformExportHamlog.Load();
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'hamlogexport.ini');
   try
      Remarks1Option := ini.ReadInteger('OPTION', 'remarks1option', 2);
      Remarks1 := ini.ReadString('OPTION', 'remarks1text', '');
      Remarks2Option := ini.ReadInteger('OPTION', 'remarks2option', 3);
      Remarks2 := ini.ReadString('OPTION', 'remarks2text', '');
      CodeOption := ini.ReadInteger('OPTION', 'codeoption', 0);
      NameOption := ini.ReadInteger('OPTION', 'nameoption', 0);
      TimeOption := ini.ReadInteger('OPTION', 'timeoption', 0);
   finally
      ini.Free();
   end;
end;

end.
