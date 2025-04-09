unit UFreqMemDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  UzLogConst, UFreqPanel, UzFreqMemory;

type
  TformFreqMemDialog = class(TForm)
    Label54: TLabel;
    Label33: TLabel;
    Label62: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    comboQuickQsyBand01: TComboBox;
    comboQuickQsyMode01: TComboBox;
    comboQuickQsyRig01: TComboBox;
    editQuickQsyCommand01: TEdit;
    editQuickQsyFixEdge01: TEdit;
    groupQuickQSY: TGroupBox;
    buttonOK: TButton;
    buttonCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure comboQuickQsyBandDropDown(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
  private
    { Private éŒ¾ }
    FTempFreqMemList: TFreqMemoryList;
    function GetFrequency(): TFrequency;
    procedure SetFrequency(v: TFrequency);
    function GetMode(): TMode;
    procedure SetMode(v: TMode);
    function GetRigNo(): Integer;
    procedure SetRigNo(v: Integer);
    function GetCommand(): string;
    procedure SetCommand(v: string);
    function GetFixEdgeNo(): Integer;
    procedure SetFixEdgeNo(v: Integer);
  public
    { Public éŒ¾ }
    property TempFreqMemList: TFreqMemoryList read FTempFreqMemList write FTempFreqMemList;
    property Frequency: TFrequency read GetFrequency write SetFrequency;
    property Mode: TMode read GetMode write SetMode;
    property RigNo: Integer read GetRigNo write SetRigNo;
    property Command: string read GetCommand write SetCommand;
    property FixEdgeNo: Integer read GetFixEdgeNo write SetFixEdgeNo;
  end;

resourcestring
  THE_COMMAND_IS_ALREADY_IN_USE = 'The command is already in use.';

implementation

uses
  UzLogGlobal;

{$R *.dfm}

procedure TformFreqMemDialog.FormCreate(Sender: TObject);
var
   m: TMode;
begin
   for m := Low(ModeString) to High(ModeString) do begin
      comboQuickQsyMode01.Items.Add(MODEString[m]);
   end;
end;

procedure TformFreqMemDialog.buttonOKClick(Sender: TObject);
begin
   if FTempFreqMemList.IndexOf(editQuickQsyCommand01.Text) >= 0 then begin
      MessageBox(Handle, PChar(THE_COMMAND_IS_ALREADY_IN_USE), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      Exit;
   end;

   ModalResult := mrOK;
end;

procedure TformFreqMemDialog.comboQuickQsyBandDropDown(Sender: TObject);
var
   dlg: TformFreqPanel;
   pt: TPoint;
   no: Integer;
begin
   dlg := TformFreqPanel.Create(Self);
   try
      pt.X := TComboBox(Sender).Left;
      pt.Y := TComboBox(Sender).Top + TComboBox(Sender).Height;
      pt := groupQuickQSY.ClientToScreen(pt);
      AdjustWindowPosInsideMonitor(dlg, pt.X, pt.Y);

      no := TComboBox(Sender).Tag;

      if (dlg.Left + dlg.Width) > (Self.Left + Self.Width) then dlg.Left := (Self.Left + Self.Width) - dlg.Width;
      if (dlg.Top + dlg.Height) > (Self.Top + Self.Height) then dlg.Top := (Self.Top + Self.Height) - dlg.Height;

      dlg.Freq := StrToIntDef(TComboBox(Sender).Text, 0);

      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;

      comboQuickQsyBand01.Text := IntToStr(dlg.Freq);  // dlg.Freq;

   finally
      dlg.Release();
   end;
end;

function TformFreqMemDialog.GetFrequency(): TFrequency;
begin
   Result := StrToIntDef(comboQuickQsyBand01.Text, 0);
end;

procedure TformFreqMemDialog.SetFrequency(v: TFrequency);
begin
   comboQuickQsyBand01.Text := IntTostr(v);
end;

function TformFreqMemDialog.GetMode(): TMode;
begin
   Result := StrToModeDef(comboQuickQsyMode01.Text, mSSB);
end;

procedure TformFreqMemDialog.SetMode(v: TMode);
var
   i: Integer;
begin
   i := comboQuickQsyMode01.Items.IndexOf(ModeString[v]);
   if i >= 0 then begin
      comboQuickQsyMode01.ItemIndex := i;
   end
   else begin
      comboQuickQsyMode01.ItemIndex := 0;
   end;
end;

function TformFreqMemDialog.GetRigNo(): Integer;
begin
   Result := comboQuickQsyRig01.ItemIndex;
end;

procedure TformFreqMemDialog.SetRigNo(v: Integer);
begin
   comboQuickQsyRig01.ItemIndex := v;
end;

function TformFreqMemDialog.GetCommand(): string;
begin
   Result := editQuickQsyCommand01.Text;
end;

procedure TformFreqMemDialog.SetCommand(v: string);
begin
   editQuickQsyCommand01.Text := v;
end;

function TformFreqMemDialog.GetFixEdgeNo(): Integer;
begin
   Result := StrToIntDef(editQuickQsyFixEdge01.Text, 0);
end;

procedure TformFreqMemDialog.SetFixEdgeNo(v: Integer);
begin
   editQuickQsyFixEdge01.Text := IntToStr(v);
end;

end.
