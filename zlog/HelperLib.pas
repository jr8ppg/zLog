unit HelperLib;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.CategoryButtons;

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

  TCategoryButtonsHelper = class helper for TCategoryButtons
  public
    procedure LoadFromFile(filename: string; Encoding: TEncoding);
    procedure SaveToFile(filename: string; Encoding: TEncoding);
    procedure LoadFromText(TXT: TStringList);
    procedure SaveToText(TXT: TStringList);
  end;

implementation

{ TListBoxHelper }

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

{ TStringGridHelper }

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

{ TCategoryButtonsHelper }

procedure TCategoryButtonsHelper.LoadFromFile(filename: string; Encoding: TEncoding);
var
   L: TStringList;
begin
   L := TStringList.Create();
   try
      L.LoadFromFile(filename, Encoding);
      LoadFromText(L);
   finally
      L.Free();
   end;
end;

procedure TCategoryButtonsHelper.SaveToFile(filename: string; Encoding: TEncoding);
var
   L: TStringList;
begin
   L := TStringList.Create();
   try
      SaveToText(L);
      L.SaveToFile(filename, Encoding);
   finally
      L.Free();
   end;
end;

procedure TCategoryButtonsHelper.LoadFromText(TXT: TStringList);
var
   i: Integer;
   strLine: string;
   strText: string;
   C: TButtonCategory;
   B: TButtonItem;
begin
   C := nil;
   Categories.Clear();
   for i := 0 to TXT.Count - 1 do begin
      strLine := TXT[i];
      if strLine[1] = Chr($09) then begin
         if C = nil then begin
            C := Categories.Add();
            C.Caption := 'ƒ^ƒCƒgƒ‹–³‚µ';
         end;
         strText := Trim(Copy(strLine, 2));
         B := C.Items.Add();
         B.Caption := strText;
         B.Hint := strText;
      end
      else begin
         C := Categories.Add();
         C.Caption := strLine;
      end;
   end;
end;

procedure TCategoryButtonsHelper.SaveToText(TXT: TStringList);
var
   i: Integer;
   j: Integer;
   C: TButtonCategory;
   B: TButtonItem;
begin
   for i := 0 to Categories.Count - 1 do begin
      C := Categories[i];
      TXT.Add(C.Caption);
      for j := 0 to C.Items.Count - 1 do begin
         B := C.Items[j];
         TXT.Add(Chr($09) + B.Caption);
      end;
   end;
end;

end.
