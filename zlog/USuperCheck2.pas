unit USuperCheck2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogSpc;

type
  TSuperCheck2 = class(TForm)
    Panel1: TPanel;
    Button3: TButton;
    ListBox: TListBox;
    StayOnTop: TCheckBox;
    SpinEdit: TSpinEdit;
    Label1: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListBoxDblClick(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
    procedure SpinEditChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBoxMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure ListBoxDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
    procedure BeginUpdate();
    procedure Add(text: string);
    procedure EndUpdate();
    property Items: TStringList read GetItems;
    property FontSize: Integer read GetFontSize write SetFontSize;
    property Columns: Integer read GetColumns write SetColumns;
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TSuperCheck2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   MainForm.DelTaskbar(Handle);
end;

procedure TSuperCheck2.FormCreate(Sender: TObject);
begin
   ListBox.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
end;

procedure TSuperCheck2.FormDestroy(Sender: TObject);
begin
//
end;

procedure TSuperCheck2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

procedure TSuperCheck2.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);
end;

procedure TSuperCheck2.Button3Click(Sender: TObject);
begin
   Close;
end;

function TSuperCheck2.GetItems(): TStringList;
begin
   Result := TStringList(ListBox.Items);
end;

function TSuperCheck2.GetFontSize(): Integer;
begin
   Result := ListBox.Font.Size;
end;

procedure TSuperCheck2.SetFontSize(v: Integer);
begin
   ListBox.Font.Size := v;
end;

function TSuperCheck2.GetColumns(): Integer;
begin
   Result := ListBox.Columns;
end;

procedure TSuperCheck2.SetColumns(v: Integer);
begin
   ListBox.Columns := v;
   SpinEdit.Value := v;
end;

procedure TSuperCheck2.ListBoxDblClick(Sender: TObject);
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

procedure TSuperCheck2.ListBoxDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
   XOffSet: Integer;
   YOffSet: Integer;
   S: string;
   H: Integer;
begin
   with (Control as TListBox).Canvas do begin
      FillRect(Rect); { clear the rectangle }
      XOffSet := 2; { provide default offset }

      H := Rect.Bottom - Rect.Top;
      YOffset := (H - Abs(TListBox(Control).Font.Height)) div 2;
      S := (Control as TListBox).Items[Index];

      if S[1] = '*' then begin
         Delete(S, 1, 1);
         if odSelected in State then begin
            Font.Color := clYellow;
//            Brush.Color := clWhite;
         end
         else begin
            Font.Color := clWindowText;
            if (dmZlogGlobal.Settings.FSuperCheck.FFullMatchHighlight = True) then begin
               Brush.Color := dmZlogGlobal.Settings.FSuperCheck.FFullMatchColor;
            end;
         end;

//         Font.Style := Font.Style + [fsBold];
         MainForm.HighlightCallsign(True);
      end
      else begin
         if odSelected in State then begin
            Font.Color := clWhite;
         end
         else begin
            Font.Color := clWindowText;
         end;
      end;

      TextOut(Rect.Left + XOffSet, Rect.Top + YOffSet, S) { display the text }
   end;
end;

procedure TSuperCheck2.ListBoxMeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
   Height := Abs(TListBox(Control).Font.Height) + 2;
end;

procedure TSuperCheck2.StayOnTopClick(Sender: TObject);
begin
   If StayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
end;

procedure TSuperCheck2.SpinEditChange(Sender: TObject);
begin
   if SpinEdit.Value <= 1 then begin
      ListBox.Columns := 0;
   end
   else begin
      ListBox.Columns := SpinEdit.Value;
   end;
end;

procedure TSuperCheck2.Clear();
begin
   ListBox.Items.Clear();
end;

function TSuperCheck2.Count(): Integer;
begin
   Result := ListBox.Items.Count;
end;

procedure TSuperCheck2.BeginUpdate();
begin
   ListBox.Items.BeginUpdate();
end;

procedure TSuperCheck2.Add(text: string);
begin
   ListBox.Items.Add(text);
end;

procedure TSuperCheck2.EndUpdate();
begin
   ListBox.Items.EndUpdate();
end;

end.
