unit UJIDXScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, Buttons,
  UzLogConst, UzLogGlobal, UzLogQSO, UWWScore;

type
  TJIDXScore = class(TWWScore)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddNoUpdate(var aQSO : TQSO);  override;
  end;

implementation

{$R *.DFM}

procedure TJIDXScore.AddNoUpdate(var aQSO : TQSO);
var
   band : TBand;
begin
   if aQSO.Dupe then begin
      Exit;
   end;

   Inherited AddNoUpdate(aQSO);

   band := aQSO.band;
   if aQSO.NewMulti2 then begin
      Inc(Multi2[band]);
   end;

   case aQSO.Band of
      b19 : aQSO.Points := 4;
      b35 : aQSO.Points := 2;
      b7..b21 : aQSO.Points := 1;
      b28 : aQSO.Points := 2;
      else
         aQSO.Points := 0;
   end;

   Inc(Points[band], aQSO.Points);
end;

end.
