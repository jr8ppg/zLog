unit USuperCheck2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin, Vcl.Grids,
  UzLogConst, UzLogGlobal;

type
  TSuperCheck2 = class(TForm)
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

procedure TSuperCheck2.FormCreate(Sender: TObject);
begin
   FList := TStringList.Create();
   Grid.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
end;

procedure TSuperCheck2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   MainForm.DelTaskbar(Handle);
end;

procedure TSuperCheck2.FormDestroy(Sender: TObject);
begin
   FList.Free();
end;

procedure TSuperCheck2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

procedure TSuperCheck2.FormResize(Sender: TObject);
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
   h := Abs(Grid.Font.Height) + 0;

   Grid.DefaultColWidth := w;
   for i := 0 to Grid.ColCount - 1 do begin
      Grid.ColWidths[i] := w;
   end;

   Grid.DefaultRowHeight := h;
   for i := 0 to Grid.RowCount - 1 do begin
      Grid.RowHeights[i] := h;
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
   Result := FList;
end;

procedure TSuperCheck2.GridDblClick(Sender: TObject);
var
   str: string;
   c, r: Integer;
begin
   c := Grid.Col;
   r := Grid.Row;
   str := Grid.Cells[c, r];

   if str = SPC_LOADING_TEXT then begin
      Exit;
   end;

   str := StringReplace(str, ' ', '', [rfReplaceAll]);
   str := StringReplace(str, '*', '', [rfReplaceAll]);

   MainForm.SetYourCallsign(str, '');
end;

procedure TSuperCheck2.GridDrawCell(Sender: TObject; ACol, ARow: Integer;
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

      if (txt <> '') and (txt[1] = '*') then begin
         Delete(txt, 1, 1);
         if (dmZlogGlobal.Settings.FSuperCheck.FFullMatchHighlight = True) then begin
            Brush.Color := dmZlogGlobal.Settings.FSuperCheck.FFullMatchColor;
            MainForm.HighlightCallsign(True);
         end
         else begin
            Brush.Color := bg;
         end;
      end
      else begin
         Brush.Color := bg;
      end;

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

function TSuperCheck2.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TSuperCheck2.SetFontSize(v: Integer);
begin
   Grid.Font.Size := v;
end;

function TSuperCheck2.GetColumns(): Integer;
begin
   Result := SpinEdit.Value;
end;

procedure TSuperCheck2.SetColumns(v: Integer);
begin
   SpinEdit.Value := v;
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
   FormResize(nil);
end;

procedure TSuperCheck2.DataLoad();
begin
   BeginUpdate();
   FList.Add(SPC_LOADING_TEXT);
   EndUpdate();
end;

procedure TSuperCheck2.Clear();
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

function TSuperCheck2.Count(): Integer;
begin
   Result := FList.Count;
end;

procedure TSuperCheck2.BeginUpdate();
begin
   Grid.BeginUpdate();
   Clear();
end;

procedure TSuperCheck2.Add(text: string);
begin
   FList.Add(text);
end;

procedure TSuperCheck2.EndUpdate();
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
