unit UAllAsianScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UIARUScore, Grids, Cologrid, StdCtrls, ExtCtrls, Buttons,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TAllAsianScore = class(TIARUScore)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddNoUpdate(var aQSO : TQSO);  override;
    procedure CalcPoints(var aQSO : TQSO);
  end;

var
  AllAsianScore: TAllAsianScore;

implementation

{$R *.DFM}

procedure TAllAsianScore.CalcPoints(var aQSO : TQSO);
begin
  case aQSO.Band of
    b19 : aQSO.Points := 3;
    b35 : aQSO.Points := 2;
  else
    aQSO.Points := 1;
  end;
end;

procedure TAllAsianScore.AddNoUpdate(var aQSO : TQSO);
var B : TBand;
begin
  //BasicScore.AddNoUpdate(aQSO);
  B := aQSO.band;
  inc(QSO[B]);
  if aQSO.mode = mCW then
    inc(CWQSO[B]);
  if aQSO.NewMulti1 then
    inc(Multi[B]);
  //inherited;
  //aQSO.Points := 0;
  if aQSO.Dupe then
    exit;
  //B := aQSO.band;
  //CalcPoints(aQSO);
  {
  case B of
    b19 : aQSO.Points := 3;
    b35 : aQSO.Points := 2;
  else
    aQSO.Points := 1;
  end;
  }
  {if aQSO.NewMulti2 then
    inc(Multi2[band]);}
  inc(Points[B], aQSO.Points);
end;


end.
