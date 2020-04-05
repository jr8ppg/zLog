unit UKCJZone;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TKCJZone = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    cbStayOnTop: TCheckBox;
    Grid1: TStringGrid;
    Grid3: TStringGrid;
    Grid2: TStringGrid;
    procedure cbStayOnTopClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    function BandToCol(B: TBand): Integer;
    function ColToBand(col: Integer): TBand;
  public
    { Public declarations }
    MultiForm: TForm;
    procedure Update;
  end;

implementation

uses
  UKCJMulti;

{$R *.DFM}

function TKCJZone.BandToCol(B: TBand): integer;
begin
   case B of
      b19:
         Result := 1;
      b35:
         Result := 2;
      b7:
         Result := 3;
      b14:
         Result := 4;
      b21:
         Result := 5;
      b28:
         Result := 6;
      b50:
         Result := 7;
      else
         Result := 1;
   end;
end;

function TKCJZone.ColToBand(col: Integer): TBand;
begin
   case col of
      1: Result := b19;
      2: Result := b35;
      3: Result := b7;
      4: Result := b14;
      5: Result := b21;
      6: Result := b28;
      7: Result := b50;
      else Result := b19;
   end;
end;

procedure TKCJZone.Update;
var
   i: integer;
   B: TBand;
begin
   for i := 0 to 23 do begin
      for B := b19 to b50 do begin
         if NotWARC(B) then begin
            if TKCJMulti(MultiForm).MultiArray[B, i] then begin
               Grid1.Cells[BandToCol(B), i] := '*';
            end
            else begin
               Grid1.Cells[BandToCol(B), i] := '.';
            end;
         end;
      end;
   end;
   for i := 24 to 47 do begin
      for B := b19 to b50 do begin
         if NotWARC(B) then begin
            if TKCJMulti(MultiForm).MultiArray[B, i] then begin
               Grid2.Cells[BandToCol(B), i - 24] := '*';
            end
            else begin
               Grid2.Cells[BandToCol(B), i - 24] := '.';
            end;
         end;
      end;
   end;
   for i := 48 to maxindex do begin
      for B := b19 to b50 do begin
         if NotWARC(B) then begin
            if TKCJMulti(MultiForm).MultiArray[B, i] then begin
               Grid3.Cells[BandToCol(B), i - 48] := '*';
            end
            else begin
               Grid3.Cells[BandToCol(B), i - 48] := '.';
            end;
         end;
      end;
   end;
end;

procedure TKCJZone.cbStayOnTopClick(Sender: TObject);
begin
   if cbStayOnTop.Checked then begin
      FormStyle := fsStayOnTop;
   end
   else begin
      FormStyle := fsNormal;
   end;
end;

procedure TKCJZone.Button1Click(Sender: TObject);
begin
   Close;
end;

procedure TKCJZone.FormShow(Sender: TObject);
var
   R: Integer;
   B: TBand;
begin
   for R := 0 to 23 do begin
      for B := b19 to b50 do begin
         Grid1.Cells[0, R] := Copy(KenNames[R], 1, 2)
      end;
   end;

   for R := 24 to 47 do begin
      for B := b19 to b50 do begin
         Grid2.Cells[0, R - 24] := Copy(KenNames[R], 1, 2);
      end;
   end;

   for R := 48 to maxindex do begin
      for B := b19 to b50 do begin
         Grid3.Cells[0, R - 48] := Copy(KenNames[R], 1, 2);
      end;
   end;

   Update;
end;

procedure TKCJZone.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   strText: string;
   i: Integer;
   CL: TColor;
   tf: TTextFormat;
begin
   if ACol = 0 then begin  // KCJCODE
      CL := clBlack;
      strText := TStringGrid(Sender).Cells[ACol, ARow];
      tf := [tfLeft, tfVerticalCenter, tfSingleLine];
   end
   else begin
      i := ARow + TStringGrid(Sender).Tag;
      if (i >= 0) and (i <= maxindex) then begin

         if TKCJMulti(MultiForm).MultiArray[ColToBand(ACol), i] = True then begin
            CL := clRed;
            strText := '*';
         end
         else begin
            CL := clBlack;
            strText := '.';
         end;
      end
      else begin
         CL := clBlack;
         strText := '';
      end;

      tf := [tfCenter, tfVerticalCenter, tfSingleLine];
   end;

   with TStringGrid(Sender).Canvas do begin
      Brush.Color := TStringGrid(Sender).Color;
      Brush.Style := bsSolid;
      FillRect(Rect);

      Font.Name := '‚l‚r ƒSƒVƒbƒN';
      Font.Size := 11;
      Font.Color := CL;

      TextRect(Rect, strText, tf);
   end;
end;

end.

