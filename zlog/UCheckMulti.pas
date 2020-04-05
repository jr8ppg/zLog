unit UCheckMulti;  // not used right now

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UCheckWin, StdCtrls, ExtCtrls, Main, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TCheckMulti = class(TCheckWin)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Renew(aQSO : TQSO); override;
  end;

var
  CheckMulti: TCheckMulti;

implementation

{$R *.DFM}

procedure TCheckMulti.Renew(aQSO : TQSO);
var str : string;
    i : LongInt;
    B : TBand;
    r : integer;
begin
  ResetListBox;
  str := Main.MyContest.MultiForm.ExtractMulti(aQSO);
  if str <> '' then
    caption := str
  else
    caption := 'Check multiplier';
  if str <> '' then
    begin
      for i := Log.TotalQSO downto 1 do
        if str = TQSO(Log.List[i]).multi1 then
          begin
            B := TQSO(Log.List[i]).Band;
            r := BandRow[B];

            if (r >= 0) and ListCWandPh then
              if TQSO(Log.List[i]).Mode = mCW then
                r := r * 2
              else
                r := r * 2 + 1;

            if r >= 0 then
              begin
                if length(ListBox.Items[r]) < 15 then
                  begin
                    ListBox.Items.Delete(r);
                    ListBox.Items.Insert(r, Main.MyContest.CheckWinSummary(TQSO(Log.List[i])));
                  end;
              end;
          end;
    end;
end;

end.
