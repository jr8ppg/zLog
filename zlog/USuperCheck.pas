unit USuperCheck;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin, Vcl.Grids,
  UzLogConst, UzLogGlobal, Vcl.Menus;

type
  TSuperCheck = class(TForm)
    Panel1: TPanel;
    Button3: TButton;
    StayOnTop: TCheckBox;
    SpinEdit: TSpinEdit;
    Label1: TLabel;
    Grid: TStringGrid;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StayOnTopClick(Sender: TObject);
    procedure SpinEditChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure GridDblClick(Sender: TObject);
  private
    { Private declarations }
    FList: TStringList;
    function GetItems(): TStringList;
    function GetFontSize(): Integer;
    procedure SetFontSize(v: Integer);
    function GetColumns(): Integer;
    procedure SetColumns(v: Integer);
  public
    { Public declarations }
    procedure DataLoad();
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
  Main, UzLogSpc;

{$R *.DFM}

procedure TSuperCheck.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   MainForm.DelTaskbar(Handle);
end;

procedure TSuperCheck.FormCreate(Sender: TObject);
begin
   FList := TStringList.Create();
   Grid.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
end;

procedure TSuperCheck.FormDestroy(Sender: TObject);
begin
   FList.Free();
end;

procedure TSuperCheck.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

procedure TSuperCheck.FormResize(Sender: TObject);
var
   w: Integer;
   h: Integer;
   i: Integer;
   c: Integer;
   r: Integer;
begin
   c := SpinEdit.Value;
   r := FList.Count div c;
   if (FList.Count mod c) > 0 then begin
      Inc(r);
   end;

   Grid.ColCount := c;
   w := (Grid.ClientWidth - GetSystemMetrics(SM_CXVSCROLL)) div c;

   Grid.RowCount := r;
   h := Grid.Canvas.TextHeight('A');

   Grid.DefaultColWidth := w;
   for i := 0 to Grid.ColCount - 1 do begin
      Grid.ColWidths[i] := w;
   end;

   Grid.DefaultRowHeight := h;
   for i := 0 to Grid.RowCount - 1 do begin
      Grid.RowHeights[i] := h;
   end;
end;

procedure TSuperCheck.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);
end;

procedure TSuperCheck.Button3Click(Sender: TObject);
begin
   Close;
end;

function TSuperCheck.GetItems(): TStringList;
begin
   Result := FList;
end;

procedure TSuperCheck.GridDblClick(Sender: TObject);
var
   str, strCall, strNumber, strComment: string;
   c, r: Integer;
   I: Integer;
begin
   c := Grid.Col;
   r := Grid.Row;
   str := Grid.Cells[c, r];

   if str = SPC_LOADING_TEXT then begin
      Exit;
   end;

   str := StringReplace(str, '*', '', [rfReplaceAll]);

   I := Pos(' ', str);
   if I = 0 then begin
      strCall := str;
      strNumber := '';
   end
   else begin
      strCall := Copy(str, 1, I - 1);
      str := Trim(Copy(str, I));

      I := Pos(' ', str);
      if I = 0 then begin
         strNumber := str;
      end
      else begin
         strNumber := Copy(str, 1, I - 1);
      end;
   end;

   MainForm.SetYourCallsign(strCall, strNumber);
end;

procedure TSuperCheck.GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
   fg: TColor;
   bg: TColor;
   txt: string;
begin
   txt := Grid.Cells[ACol, ARow];
   with Grid.Canvas do begin
      fg := clBlack;
      bg := clWhite;

      Pen.Color := bg;
      Pen.Style := psSolid;
      Brush.Color := bg;
      Brush.Style := bsSolid;
      FillRect(Rect);

      Font.Color := fg;
      Font.Size := Grid.Font.Size;
      Font.Name := Grid.Font.Name;
      TextRect(Rect, txt, [tfLeft, tfVerticalCenter]);

      if (gdSelected in State) and (gdFocused in State) and (FList.Count > 0) then begin
         DrawFocusRect(Rect);
      end;
   end;
end;

function TSuperCheck.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TSuperCheck.SetFontSize(v: Integer);
begin
   Grid.Font.Size := v;
end;

function TSuperCheck.GetColumns(): Integer;
begin
   Result := SpinEdit.Value;
end;

procedure TSuperCheck.SetColumns(v: Integer);
begin
   SpinEdit.Value := v;
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
   FormResize(nil);
end;

procedure TSuperCheck.Clear();
var
   r, c: Integer;
begin
   FList.Clear();
   for r := 0 to Grid.RowCount - 1 do begin
      for c := 0 to Grid.ColCount - 1 do begin
         Grid.Cells[c, r] := '';
      end;
   end;
   Grid.Col := 0;
   Grid.Row := 0;
   Grid.Refresh();
end;

procedure TSuperCheck.DataLoad();
begin
   BeginUpdate();
   FList.Add(SPC_LOADING_TEXT);
   EndUpdate();
end;

function TSuperCheck.Count(): Integer;
begin
   Result := FList.Count;
end;

procedure TSuperCheck.BeginUpdate();
begin
   Grid.BeginUpdate();
   Clear();
end;

procedure TSuperCheck.Add(text: string);
begin
   FList.Add(text);
end;

procedure TSuperCheck.EndUpdate();
var
   c, r, n: Integer;
   cols: Integer;
begin
   FormResize(nil);

   cols := SpinEdit.Value;
   for n := 0 to FList.Count -1 do begin
      r := n div cols;
      c := n mod cols;
      Grid.Cells[c, r] := FList[n];
   end;

   Grid.EndUpdate();
   Grid.Refresh();
end;

end.
