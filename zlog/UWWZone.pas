unit UWWZone;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TWWZone = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    cbStayOnTop: TCheckBox;
    Grid: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbStayOnTopClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Reset;
    procedure Mark(B : TBand; Zone : integer);
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TWWZone.Reset;
var
   R: Integer;
   Z: Integer;
   band: TBand;
begin
   Grid.ColWidths[0] := 24;

   R := 1;
   for band := b19 to b28 do begin
      // WARC除外
      if IsWARC(band) = True then begin
         Continue;
      end;

      // QRVできないバンドは除外
      if dmZlogGlobal.Settings._activebands[band] = False then begin
         Continue;
      end;

      Grid.Cells[0, R] := MHzString[band];
      for Z := 1 to 40 do begin
         Grid.Cells[Z, 0] := IntToStr(Z);
         Grid.Cells[Z, R] := '.';
      end;

      Inc(R);
   end;

   Grid.RowCount := R;

   ClientWidth := (Grid.DefaultColWidth * Grid.ColCount) + (Grid.ColCount * Grid.GridLineWidth) + 6;
   ClientHeight := (Grid.DefaultRowHeight * Grid.RowCount) + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
end;

procedure TWWZone.Mark(B : TBand; Zone : integer);
begin
   Grid.Cells[Zone, OldBandOrd(B)+1] := '*';
end;

procedure TWWZone.Button1Click(Sender: TObject);
begin
   Close;
end;

procedure TWWZone.FormResize(Sender: TObject);
begin
//   if Self.Width > MaxWidth then begin
//      Self.Width := MaxWidth;
//   end;
end;

procedure TWWZone.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);
end;

procedure TWWZone.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   MainForm.DelTaskbar(Handle);
end;

procedure TWWZone.FormCreate(Sender: TObject);
begin
//  Width := MaxWidth;
end;

procedure TWWZone.cbStayOnTopClick(Sender: TObject);
begin
   if cbStayOnTop.Checked then begin
      FormStyle := fsStayOnTop;
   end
   else begin
      FormStyle := fsNormal;
   end;
end;

procedure TWWZone.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

procedure TWWZone.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   strText: string;
begin
   inherited;
   strText := TStringGrid(Sender).Cells[ACol, ARow];

   with TStringGrid(Sender).Canvas do begin
      Brush.Color := TStringGrid(Sender).Color;
      Brush.Style := bsSolid;
      FillRect(Rect);

      Font.Name := 'ＭＳ ゴシック';
      Font.Size := 10;

      if Copy(strText, 1, 1) = '*' then begin
         Font.Color := clRed;
      end
      else begin
         Font.Color := clBlack;
      end;

      if ACol = 0 then begin
         TextRect(Rect, strText, [tfRight,tfVerticalCenter,tfSingleLine]);
      end
      else begin
         TextRect(Rect, strText, [tfCenter,tfVerticalCenter,tfSingleLine]);
      end;
   end;
end;

end.
