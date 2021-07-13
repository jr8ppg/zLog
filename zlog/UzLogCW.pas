unit UzLogCW;

interface

uses
  SysUtils, UzLogConst, UzLogGlobal, UzLogQSO, UzLogKeyer, UOptions;

var CtrlZCQLoop : boolean;

const tabstate_normal = 0;
      tabstate_tabpressedbutnotedited = 1;
      tabstate_tabpressedandedited = 2;

var
   EditedSinceTABPressed : integer = 0;

function LastCallsign : string;
function SetStr(S : string; aQSO : TQSO) : String;
function SetStrNoAbbrev(S : string; aQSO : TQSO) : String; {for QSO.NrSent}
procedure zLogSendStr(S: string);
procedure zLogSendStr2(S: string; aQSO: TQSO);
procedure CtrlZBreak;

implementation

uses Main;

function LastCallsign : string;
var txnr, i : integer;
begin
  Result := '';
  txnr := dmZLogGlobal.Settings._txnr;
  for i := Log.TotalQSO downto 1 do
    begin
      if Log.QsoList[i].TX = txnr then
        Result := Log.QsoList[i].Callsign;
      exit;
    end;
end;

function Abbreviate(S: string): string;
var
  ss: string;
  i: integer;
begin
  SS := S;

  for i := 1 to length(SS) do begin
    case SS[i] of
      '0' : SS[i] := dmZLogGlobal.Settings.CW._zero;
      '1' : SS[i] := dmZLogGlobal.Settings.CW._one;
      '9' : SS[i] := dmZLogGlobal.Settings.CW._nine;
    end;
  end;

  Result := SS;
end;

function SetStr(S : string; aQSO : TQSO) : string;
var
   temp: string;
begin
   temp := UpperCase(S);

   temp := StringReplace(temp, '[AR]', 'a', [rfReplaceAll]);
   temp := StringReplace(temp, '[SK]', 's', [rfReplaceAll]);
   temp := StringReplace(temp, '[VA]', 's', [rfReplaceAll]);
   temp := StringReplace(temp, '[KN]', 'k', [rfReplaceAll]);
   temp := StringReplace(temp, '[BK]', '~', [rfReplaceAll]);

   temp := StringReplace(temp, '$B', Main.CurrentQSO.Callsign, [rfReplaceAll]);
   temp := StringReplace(temp, '$X', dmZLogGlobal.Settings._sentstr, [rfReplaceAll]);
   temp := StringReplace(temp, '$R', Abbreviate(aQSO.RSTSentStr), [rfReplaceAll]);
   temp := StringReplace(temp, '$F', Abbreviate(aQSO.NrRcvd), [rfReplaceAll]);
   temp := StringReplace(temp, '$Z', Abbreviate(dmZLogGlobal.Settings._cqzone), [rfReplaceAll]);
   temp := StringReplace(temp, '$I', Abbreviate(dmZLogGlobal.Settings._iaruzone), [rfReplaceAll]);
   temp := StringReplace(temp, '$Q', Abbreviate(MyContest.QTHString(aQSO)), [rfReplaceAll]);
   temp := StringReplace(temp, '$V', Abbreviate(dmZLogGlobal.Settings._prov), [rfReplaceAll]);
   temp := StringReplace(temp, '$O', aQSO.Operator, [rfReplaceAll]);
   temp := StringReplace(temp, '$S', Abbreviate(aQSO.SerialStr), [rfReplaceAll]);
   temp := StringReplace(temp, '$P', aQSO.NewPowerStr, [rfReplaceAll]);
   temp := StringReplace(temp, '$A', Abbreviate(UpperCase(dmZLogGlobal.GetAge(aQSO))), [rfReplaceAll]);
   temp := StringReplace(temp, '$N', Abbreviate(aQSO.PowerStr), [rfReplaceAll]);
   temp := StringReplace(temp, '$L', LastCallSign, [rfReplaceAll]);
   temp := StringReplace(temp, '$G', dmZLogGlobal.GetGreetingsCode(), [rfReplaceAll]);

   if aQSO.mode = mRTTY then begin
      temp := StringReplace(temp, '$C', aQSO.Callsign, [rfReplaceAll]);
   end
   else begin
      if dmZLogKeyer.UseWinKeyer = True then begin
         temp := StringReplace(temp, '$C', aQSO.Callsign, [rfReplaceAll]);
      end
      else begin
         temp := StringReplace(temp, '$C', ':***************', [rfReplaceAll]);
      end;
   end;

//  while Pos('$C',temp) > 0 do
//    begin
//      i := Pos('$C',temp);
//      Delete(temp, i, 2);
//      if aQSO.mode = mRTTY then
//        Insert(aQSO.Callsign, temp, i)
//      else
//        Insert(':***************', temp, i);
//    end;

   if aQSO.Callsign = '' then begin
      temp := StringReplace(temp, '$E', LastCallsign, [rfReplaceAll]);
   end
   else if EditedSinceTABPressed = tabstate_tabpressedandedited then begin
      temp := StringReplace(temp, '$E', aQSO.Callsign, [rfReplaceAll]);
   end
   else begin
      temp := StringReplace(temp, '$E', '', [rfReplaceAll]);
   end;

//  while Pos('$E',temp) > 0 do
//    begin
//      i := Pos('$E',temp);
//      Delete(temp, i, 2);
//
//      if aQSO.Callsign = '' then
//        insert(LastCallsign, temp, i);
//
//      if EditedSinceTABPressed = tabstate_tabpressedandedited then
//        Insert(aQSO.Callsign, temp, i);
//    end;

   temp := StringReplace(temp, '$M', UpperCase(dmZLogGlobal.MyCall), [rfReplaceAll]);

   Result := temp;
end;

function SetStrNoAbbrev(S : string; aQSO : TQSO) : string;
var
   temp: string;
begin
   temp := UpperCase(S);

   temp := StringReplace(temp, '[AR]', '', [rfReplaceAll]);
   temp := StringReplace(temp, '[SK]', '', [rfReplaceAll]);
   temp := StringReplace(temp, '[VA]', '', [rfReplaceAll]);
   temp := StringReplace(temp, '[KN]', '', [rfReplaceAll]);
   temp := StringReplace(temp, '[BK]', '', [rfReplaceAll]);

   temp := StringReplace(temp, '$B', Main.CurrentQSO.Callsign, [rfReplaceAll]);
   temp := StringReplace(temp, '$X', dmZLogGlobal.Settings._sentstr, [rfReplaceAll]);
   temp := StringReplace(temp, '$R', aQSO.RSTSentStr, [rfReplaceAll]);
   temp := StringReplace(temp, '$F', aQSO.NrRcvd, [rfReplaceAll]);
   temp := StringReplace(temp, '$Z', dmZLogGlobal.Settings._cqzone, [rfReplaceAll]);
   temp := StringReplace(temp, '$I', dmZLogGlobal.Settings._iaruzone, [rfReplaceAll]);
   temp := StringReplace(temp, '$Q', MyContest.QTHString(aQSO), [rfReplaceAll]);
   temp := StringReplace(temp, '$V', dmZLogGlobal.Settings._prov, [rfReplaceAll]);
   temp := StringReplace(temp, '$O', aQSO.Operator, [rfReplaceAll]);
   temp := StringReplace(temp, '$S', aQSO.SerialStr, [rfReplaceAll]);
   temp := StringReplace(temp, '$P', aQSO.NewPowerStr, [rfReplaceAll]);
   temp := StringReplace(temp, '$A', UpperCase(dmZLogGlobal.GetAge(aQSO)), [rfReplaceAll]);
   temp := StringReplace(temp, '$N', aQSO.PowerStr, [rfReplaceAll]);
   temp := StringReplace(temp, '$L', LastCallSign, [rfReplaceAll]);
   temp := StringReplace(temp, '$G', dmZLogGlobal.GetGreetingsCode(), [rfReplaceAll]);

   temp := StringReplace(temp, '$C', aQSO.Callsign, [rfReplaceAll]);

   Result := temp;
end;

procedure zLogSendStr(S: string);
begin
   if dmZLogKeyer.UseWinKeyer = True then begin
      dmZLogKeyer.WinKeyerClear();
      dmZLogKeyer.WinKeyerSendStr(S);
   end
   else begin
      dmZLogKeyer.PauseCW;

      if dmZLogGlobal.FIFO then begin
         dmZLogKeyer.SendStrFIFO(S);
      end
      else begin
         dmZLogKeyer.SendStr(S);
      end;

      dmZLogKeyer.SetCallSign(Main.CurrentQSO.Callsign);
      dmZLogKeyer.ResumeCW;
   end;
end;

procedure zLogSendStr2(S: string; aQSO: TQSO);
begin
   if aQSO.Mode = mCW then begin
      S := SetStr(S, aQSO);
   end;
   if aQSO.Mode = mRTTY then begin
      S := SetStrNoAbbrev(S, aQSO);
   end;

   zLogSendStr(S);
end;

procedure CtrlZBreak;
begin
  CtrlZCQLoop := False;
  dmZLogKeyer.ClrBuffer;
end;

initialization
  CtrlZCQLoop := False;
//  QTHString := '';
end.
