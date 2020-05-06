unit UCheckCall2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UCheckWin, StdCtrls, ExtCtrls,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TCheckCall2 = class(TCheckWin)
  private
    { Private declarations }
  public
    procedure Renew(aQSO : TQSO); override;
    { Public declarations }
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TCheckCall2.Renew(aQSO: TQSO);
var
   B: TBand;
   aQ, Q: TQSO;
begin
   ResetListBox;

   if pos(',', aQSO.Callsign) = 1 then
      exit;

   aQ := TQSO.Create;
   aQ.Assign(aQSO);
   for B := b19 to HiBand do begin
      if BandRow[B] >= 0 then begin
         aQ.Band := B;
         Q := Log.QuickDupe(aQ);
         if Q <> nil then begin
            ListBox.Items.Delete(BandRow[B]);
            ListBox.Items.Insert(BandRow[B], Main.MyContest.CheckWinSummary(Q));
         end;
      end;
   end;

   aQ.Free;
end;

end.
