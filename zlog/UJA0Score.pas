unit UJA0Score;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, StdCtrls, ExtCtrls, Buttons,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TJA0Score = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    JA0Band : TBand;
    procedure Reset; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure Update; override;
    function IsJA0(aQSO : TQSO) : boolean;
    procedure SetBand(B : TBand);
  end;

implementation

uses Main;

{$R *.DFM}

procedure TJA0Score.Reset;
var
   band : TBand;
begin
   for band := b19 to HiBand do begin
      QSO[band] := 0;
      Points[band] := 0;
      Multi[band] := 0;
   end;
end;

function TJA0Score.IsJA0(aQSO : TQSO) : boolean;
begin
   if Pos('0',aQSO.CallSign) > 0 then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TJA0Score.AddNoUpdate(var aQSO : TQSO);
begin
   inherited;

   if aQSO.Dupe then begin
      Exit;
   end;

   if IsJA0(aQSO) then begin
      aQSO.Points := 3;
   end
   else begin
      aQSO.Points := 1;
   end;

   Inc(Points[aQSO.band], aQSO.Points);
end;

procedure TJA0Score.Update;
begin
   // å©èoÇµçs
   Grid.Cells[0,0] := 'MHz';
   Grid.Cells[1,0] := 'QSO';
   Grid.Cells[2,0] := 'Points';
   Grid.Cells[3,0] := 'Multi';

   if (JA0Band = b21) or (JA0Band = b28) then begin
      Grid.Cells[1, 1] := IntToStr3(QSO[b21]);
      Grid.Cells[2, 1] := IntToStr3(Points[b21]);
      Grid.Cells[3, 1] := IntToStr3(Multi[b21]);
      Grid.Cells[1, 2] := IntToStr3(QSO[b28]);
      Grid.Cells[2, 2] := IntToStr3(Points[b28]);
      Grid.Cells[3, 2] := IntToStr3(Multi[b28]);
      Grid.Cells[3, 3] := IntToStr3((Points[b21] + Points[b28]) * (Multi[b21] + Multi[b28]));
   end
   else begin
      Grid.Cells[1, 1] := IntToStr3(QSO[JA0Band]);
      Grid.Cells[2, 1] := IntToStr3(Points[JA0Band]);
      Grid.Cells[3, 1] := IntToStr3(Multi[JA0Band]);
      Grid.Cells[1, 2] := '';
      Grid.Cells[2, 2] := '';
      Grid.Cells[3, 2] := IntToStr3(Points[JA0Band] * Multi[JA0Band]);
      Grid.Cells[3, 3] := '';
   end;
end;

procedure TJA0Score.SetBand(B : TBand);
begin
   JA0Band := B;
   if (B = b21) or (B = b28) then begin
      Grid.RowCount := 4;
      Grid.Cells[0, 1] := MHzString[b21];
      Grid.Cells[0, 2] := MHzString[b28];
      Grid.Cells[0, 3] := 'Score';
   end
   else begin
      Grid.RowCount := 3;
      Grid.Cells[0, 1] := MHzString[JA0Band];
      Grid.Cells[0, 2] := 'Score';
      Grid.Cells[0, 3] := '';
   end;

   ClientWidth := (Grid.DefaultColWidth * Grid.ColCount) + (Grid.ColCount * Grid.GridLineWidth);
   ClientHeight := (Grid.DefaultRowHeight * Grid.RowCount) + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
end;

procedure TJA0Score.FormShow(Sender: TObject);
begin
   inherited;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.Row := 1;
   CWButton.Visible := False;
end;

procedure TJA0Score.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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
      Font.Size := 11;

      if Copy(strText, 1, 1) = '*' then begin
         strText := Copy(strText, 2);
         Font.Color := clBlue;
      end
      else begin
         Font.Color := clBlack;
      end;

      TextRect(Rect, strText, [tfRight,tfVerticalCenter,tfSingleLine]);
   end;
end;

end.
