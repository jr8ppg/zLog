unit UCheckCall2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UCheckWin, StdCtrls, ExtCtrls, Main,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TCheckCall2 = class(TCheckWin)
  private
    { Private declarations }
  public
    procedure Renew(aQSO : TQSO); override;
    { Public declarations }
  end;

var
  CheckCall2: TCheckCall2;

implementation

{$R *.DFM}

procedure TCheckCall2.Renew(aQSO : TQSO);
var PartialStr : string;
    i : LongInt;
    B : TBand;
    aQ, Q : TQSO;
begin
  ResetListBox;

  if pos(',',aQSO.Callsign) = 1 then
    exit;

  aQ := TQSO.Create;
  aQ.Assign(aQSO);
  for B := b19 to HiBand do
    if BandRow[B] >= 0 then
      begin
        aQ.Band := B;
        Q := Log.QuickDupe(aQ);
        if Q <> nil then
          begin
            ListBox.Items.Delete(BandRow[B]);
            ListBox.Items.Insert(BandRow[B], Main.MyContest.CheckWinSummary(Q));
          end;
      end;
  aQ.Free;
end;

(*
function TCheckCall2.ALLJA_JA1ZLOMessage(aQSO : TQSO) : string;
var PartialStr : string;
    T : integer;
    B : TBand;
    Needed : set of TBand;
    aQ, Q : TQSO;
begin
  Result := '';
  if aQSO.Callsign <> 'JA1ZLO' then
    exit;
  aQ := TQSO.Create;
  aQ.QSO := aQSO.QSO;
  T := 0;
  Needed := [];
  for B := b35 to b50 do
    begin
      if B in [b35, b7, b14, b21, b28, b50] then
        begin
          aQ.QSO.Band := B;
          Q := Log.QuickDupe(aQ);
          if Q <> nil then
            begin
              inc(T);
            end
          else
            Needed := Needed + B;
        end;
    end;
  if T = 5 then
    begin

    end;
  aQ.Free;
end;
*)


end.
