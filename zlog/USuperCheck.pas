unit USuperCheck;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogSpc;

type
  TSuperCheck = class(TForm)
    Panel1: TPanel;
    Button3: TButton;
    ListBox: TListBox;
    StayOnTop: TCheckBox;
    SpinEdit: TSpinEdit;
    Label1: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ListBoxDblClick(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
    procedure SpinEditChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function GetItems(): TStringList;
    function GetFontSize(): Integer;
    procedure SetFontSize(v: Integer);
    function GetColumns(): Integer;
    procedure SetColumns(v: Integer);
  public
    { Public declarations }
    procedure Clear();
    function Count(): Integer;
    procedure Add(text: string);
    property Items: TStringList read GetItems;
    property FontSize: Integer read GetFontSize write SetFontSize;
    property Columns: Integer read GetColumns write SetColumns;
  end;

implementation

uses
  Main, UOptions;

{$R *.DFM}

procedure TSuperCheck.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TSuperCheck.FormCreate(Sender: TObject);
begin
//
end;

procedure TSuperCheck.FormDestroy(Sender: TObject);
begin
//
end;

procedure TSuperCheck.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

procedure TSuperCheck.FormShow(Sender: TObject);
begin
//
end;

procedure TSuperCheck.Button3Click(Sender: TObject);
begin
   Close;
end;

function TSuperCheck.GetItems(): TStringList;
begin
   Result := TStringList(ListBox.Items);
end;

function TSuperCheck.GetFontSize(): Integer;
begin
   Result := ListBox.Font.Size;
end;

procedure TSuperCheck.SetFontSize(v: Integer);
begin
   ListBox.Font.Size := v;
end;

function TSuperCheck.GetColumns(): Integer;
begin
   Result := ListBox.Columns;
end;

procedure TSuperCheck.SetColumns(v: Integer);
begin
   ListBox.Columns := v;
   SpinEdit.Value := v;
end;

procedure TSuperCheck.ListBoxDblClick(Sender: TObject);
var
   i, j: integer;
   str: string;
begin
   i := ListBox.ItemIndex;
   str := ListBox.Items[i];

   if str = SPC_LOADING_TEXT then begin
      Exit;
   end;

   j := Pos(' ', str);
   if j > 0 then begin
      str := copy(str, 1, j - 1);
   end;

   MainForm.SetYourCallsign(str, '');
end;

procedure TSuperCheck.StayOnTopClick(Sender: TObject);
begin
   If StayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
end;

procedure TSuperCheck.SpinEditChange(Sender: TObject);
begin
   if SpinEdit.Value <= 1 then begin
      ListBox.Columns := 0;
   end
   else begin
      ListBox.Columns := SpinEdit.Value;
   end;
end;

procedure TSuperCheck.Clear();
begin
   ListBox.Items.Clear();
end;

function TSuperCheck.Count(): Integer;
begin
   Result := ListBox.Items.Count;
end;

procedure TSuperCheck.Add(text: string);
begin
   ListBox.Items.Add(text);
end;

end.
