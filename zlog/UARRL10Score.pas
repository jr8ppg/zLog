unit UARRL10Score;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, Grids, Cologrid, StdCtrls, ExtCtrls,  Buttons,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TARRL10Score = class(TBasicScore)
    Grid: TMgrid;
    procedure FormCreate(Sender: TObject);
    procedure GridSetting(ARow, Acol: Integer; var Fcolor: Integer;
      var Bold, Italic, underline: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateData; override;
    procedure AddNoUpdate(var aQSO : TQSO);  override;
  end;

implementation

{$R *.DFM}

procedure TARRL10Score.UpdateData;
begin
   Grid.Cells[1, 0] := IntToStr(QSO[b28]);
   Grid.Cells[1, 1] := IntToStr(QSO[b28] - CWQSO[b28]);
   Grid.Cells[1, 2] := IntToStr(CWQSO[b28]);
   Grid.Cells[1, 3] := IntToStr(Points[b28]);
   Grid.Cells[1, 4] := IntToStr(Multi[b28]);
   Grid.Cells[1, 5] := IntToStr(Points[b28] * Multi[b28]);
end;

procedure TARRL10Score.AddNoUpdate(var aQSO: TQSO);
var
   i: Integer;
begin
   { BasicScore.AddNoUpdate(aQSO); }
   inherited;

   aQSO.Points := 0;
   if aQSO.Dupe then
      exit;

   if aQSO.Mode = mCW then begin
      i := length(aQSO.Callsign) - 1;
      if (pos('/N', aQSO.Callsign) = i) or (pos('/T', aQSO.Callsign) = i) then
         aQSO.Points := 8 // novice or technician cw qso : 8pts
      else
         aQSO.Points := 4;
   end
   else if aQSO.Mode in [mSSB, mFM, mAM] then begin
      aQSO.Points := 2;
   end;

   inc(Points[b28], aQSO.Points);
end;

procedure TARRL10Score.FormCreate(Sender: TObject);
begin
   inherited;
   with Grid do begin
      RowCount := 6;
      ColCount := 2;
      Cells[0, 0] := 'QSO';
      Cells[0, 1] := 'Ph';
      Cells[0, 2] := 'CW';
      Cells[0, 3] := 'Pts';
      Cells[0, 4] := 'Multi';
      Cells[0, 5] := 'Score';
      ColWidths[1] := 80;
      Height := GridHeight;
      Width := GridWidth;
   end;

   ClientHeight := Grid.Height + Panel1.Height + 10;
end;

procedure TARRL10Score.GridSetting(ARow, Acol: Integer; var Fcolor: Integer; var Bold, Italic, underline: Boolean);
begin
   inherited;
   if Acol = 0 then
      Fcolor := clBlue
   else
      Fcolor := clBlack;
end;

end.
