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
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Reset;
    procedure Mark(B : TBand; Zone : integer);
  end;

//const
//  MaxWidth = 592;

implementation

uses Main;

{$R *.DFM}

procedure TWWZone.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
//  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TWWZone.Reset;
var
   R: Integer;
   Z: Integer;
   B : TBand;
begin
   Grid.ColWidths[0] := 24;
   R := 1;
   for B := b19 to b28 do begin
      if NotWARC(B) then begin
         Grid.Cells[0, R] := MHzString[B];
         for Z := 1 to 40 do begin
            Grid.Cells[Z, 0] := IntToStr(Z);
            Grid.Cells[Z, R] := '.';
         end;

         Inc(R);
      end;
   end;

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
      VK_ESCAPE : MainForm.LastFocus.SetFocus;
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

      Font.Name := 'ÇlÇr ÉSÉVÉbÉN';
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
