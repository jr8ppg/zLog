unit HelperLib;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids;

type
  TListBoxHelper = class helper for TListBox
  public
    procedure ShowFirst();
    procedure ShowLast();
  end;

  TStringGridHelper = class helper for TStringGrid
  public
    procedure ShowFirst();
    procedure ShowLast(datarows: Integer = -1);
  end;


implementation

procedure TListBoxHelper.ShowFirst();
begin
   TopIndex := 0;
end;

procedure TListBoxHelper.ShowLast();
var
   line_height: Integer;
   lines: Integer;
begin
   if Style = lbOwnerDrawFixed then begin
      line_height := ItemHeight;
   end
   else begin
      line_height := Abs(Font.Height) + 2;
   end;
   lines := Height div line_height;

   if Items.Count < lines then begin
      TopIndex := 0;
   end
   else begin
      TopIndex := Items.Count - lines;
   end;
end;

procedure TStringGridHelper.ShowFirst();
begin
   TopRow := FixedRows;
end;

procedure TStringGridHelper.ShowLast(datarows: Integer);
begin
   if datarows <= VisibleRowCount then begin
      TopRow := FixedRows;
   end
   else begin
      if datarows = -1 then begin
         TopRow := RowCount - VisibleRowCount;
      end
      else begin
         TopRow := (datarows + FixedRows) - VisibleRowCount;
      end;
   end;
end;

end.
