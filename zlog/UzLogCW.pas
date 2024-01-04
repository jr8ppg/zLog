unit UzLogCW;

interface

uses
  System.SysUtils, System.StrUtils,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogKeyer, UOptions, URigCtrlLib;

const tabstate_normal = 0;
      tabstate_tabpressedbutnotedited = 1;
      tabstate_tabpressedandedited = 2;

var
   EditedSinceTABPressed : integer = 0;

function LastCallsign : string;
function SetStr(sendtext: string; aQSO : TQSO) : String;
function SetStrNoAbbrev(sendtext: string; aQSO : TQSO) : String; {for QSO.NrSent}
procedure zLogSendStr(nID: Integer; S: string; C: string = '');
procedure zLogSendStr2(nID: Integer; S: string; aQSO: TQSO);
procedure zLogSetSendText(nID: Integer; S, C: string);

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

function SetStr(sendtext : string; aQSO : TQSO) : string;
var
   temp: string;
   S: string;
begin
   temp := sendtext;

   temp := StringReplace(temp, '[AR]', 'a', [rfReplaceAll]);
   temp := StringReplace(temp, '[SK]', 's', [rfReplaceAll]);
   temp := StringReplace(temp, '[VA]', 's', [rfReplaceAll]);
   temp := StringReplace(temp, '[KN]', 'k', [rfReplaceAll]);
   temp := StringReplace(temp, '[BK]', '~', [rfReplaceAll]);

   temp := StringReplace(temp, '$X', dmZLogGlobal.Settings._sentstr, [rfReplaceAll]);
   temp := StringReplace(temp, '$x', LowerCase(dmZLogGlobal.Settings._sentstr), [rfReplaceAll]);

   S := aQSO.Callsign;
   temp := StringReplace(temp, '$B', S, [rfReplaceAll]);
   temp := StringReplace(temp, '$b', S, [rfReplaceAll]);

   S := aQSO.RSTSentStr;
   temp := StringReplace(temp, '$R', Abbreviate(S), [rfReplaceAll]);
   temp := StringReplace(temp, '$r', S, [rfReplaceAll]);

   S := aQSO.NrRcvd;
   temp := StringReplace(temp, '$F', Abbreviate(S), [rfReplaceAll]);
   temp := StringReplace(temp, '$f', S, [rfReplaceAll]);

   S := dmZLogGlobal.Settings._cqzone;
   temp := StringReplace(temp, '$Z', Abbreviate(S), [rfReplaceAll]);
   temp := StringReplace(temp, '$z', S, [rfReplaceAll]);

   S := dmZLogGlobal.Settings._iaruzone;
   temp := StringReplace(temp, '$I', Abbreviate(S), [rfReplaceAll]);
   temp := StringReplace(temp, '$i', S, [rfReplaceAll]);

   S := MyContest.QTHString(aQSO);
   temp := StringReplace(temp, '$Q', Abbreviate(S), [rfReplaceAll]);
   temp := StringReplace(temp, '$q', S, [rfReplaceAll]);

   S := dmZLogGlobal.Settings._prov;
   temp := StringReplace(temp, '$V', Abbreviate(S), [rfReplaceAll]);
   temp := StringReplace(temp, '$v', S, [rfReplaceAll]);

   S := aQSO.Operator;
   temp := StringReplace(temp, '$O', S, [rfReplaceAll]);
   temp := StringReplace(temp, '$o', S, [rfReplaceAll]);

   if dmZLogGlobal.Settings.CW._not_send_leading_zeros = False then begin
      S := aQSO.SerialStr;
      temp := StringReplace(temp, '$S', Abbreviate(S), [rfReplaceAll]);
      temp := StringReplace(temp, '$s', S, [rfReplaceAll]);
   end
   else begin
      S := IntToStr(aQSO.Serial);
      temp := StringReplace(temp, '$S', Abbreviate(S), [rfReplaceAll]);
      temp := StringReplace(temp, '$s', S, [rfReplaceAll]);
   end;

   S := aQSO.NewPowerStr;
   temp := StringReplace(temp, '$P', S, [rfReplaceAll]);
   temp := StringReplace(temp, '$p', S, [rfReplaceAll]);

   S := UpperCase(dmZLogGlobal.GetAge(aQSO));
   temp := StringReplace(temp, '$A', Abbreviate(S), [rfReplaceAll]);
   temp := StringReplace(temp, '$a', S, [rfReplaceAll]);

   S := aQSO.PowerStr;
   temp := StringReplace(temp, '$N', Abbreviate(S), [rfReplaceAll]);
   temp := StringReplace(temp, '$n', S, [rfReplaceAll]);

   S := LastCallSign;
   temp := StringReplace(temp, '$L', S, [rfReplaceAll]);
   temp := StringReplace(temp, '$l', S, [rfReplaceAll]);

   S := dmZLogGlobal.GetGreetingsCode();
   temp := StringReplace(temp, '$G', S, [rfReplaceAll]);
   temp := StringReplace(temp, '$g', S, [rfReplaceAll]);

   if aQSO.mode = mRTTY then begin
      S := aQSO.Callsign;
   end
   else begin
      if dmZLogKeyer.UseWinKeyer = True then begin
         S := '$C';  //aQSO.Callsign;
      end
      else begin
         S := ':***************';
      end;
   end;
   temp := StringReplace(temp, '$C', S, [rfReplaceAll]);
   temp := StringReplace(temp, '$c', S, [rfReplaceAll]);

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
      S := LastCallsign;
   end
   else if EditedSinceTABPressed = tabstate_tabpressedandedited then begin
      S := aQSO.Callsign;
   end
   else begin
      S := '';
   end;
   temp := StringReplace(temp, '$E', S, [rfReplaceAll]);

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

   S := UpperCase(dmZLogGlobal.MyCall);
   temp := StringReplace(temp, '$M', S, [rfReplaceAll]);
   temp := StringReplace(temp, '$m', S, [rfReplaceAll]);

   Result := UpperCase(temp);
end;

function SetStrNoAbbrev(sendtext: string; aQSO : TQSO) : string;
var
   temp: string;
begin
   temp := UpperCase(sendtext);

   temp := StringReplace(temp, '[AR]', '', [rfReplaceAll]);
   temp := StringReplace(temp, '[SK]', '', [rfReplaceAll]);
   temp := StringReplace(temp, '[VA]', '', [rfReplaceAll]);
   temp := StringReplace(temp, '[KN]', '', [rfReplaceAll]);
   temp := StringReplace(temp, '[BK]', '', [rfReplaceAll]);

   temp := StringReplace(temp, '$B', aQSO.Callsign, [rfReplaceAll]);
   temp := StringReplace(temp, '$X', dmZLogGlobal.Settings._sentstr, [rfReplaceAll]);
   temp := StringReplace(temp, '$R', aQSO.RSTSentStr, [rfReplaceAll]);
   temp := StringReplace(temp, '$F', aQSO.NrRcvd, [rfReplaceAll]);
   temp := StringReplace(temp, '$Z', dmZLogGlobal.Settings._cqzone, [rfReplaceAll]);
   temp := StringReplace(temp, '$I', dmZLogGlobal.Settings._iaruzone, [rfReplaceAll]);
   temp := StringReplace(temp, '$Q', MyContest.QTHString(aQSO), [rfReplaceAll]);
   temp := StringReplace(temp, '$V', dmZLogGlobal.Settings._prov, [rfReplaceAll]);
   temp := StringReplace(temp, '$O', aQSO.Operator, [rfReplaceAll]);

   if dmZLogGlobal.Settings.CW._not_send_leading_zeros = False then begin
      temp := StringReplace(temp, '$S', aQSO.SerialStr, [rfReplaceAll]);
   end
   else begin
      temp := StringReplace(temp, '$S', IntToStr(aQSO.Serial), [rfReplaceAll]);
   end;

   temp := StringReplace(temp, '$P', aQSO.NewPowerStr, [rfReplaceAll]);
   temp := StringReplace(temp, '$A', UpperCase(dmZLogGlobal.GetAge(aQSO)), [rfReplaceAll]);
   temp := StringReplace(temp, '$N', aQSO.PowerStr, [rfReplaceAll]);
   temp := StringReplace(temp, '$L', LastCallSign, [rfReplaceAll]);
   temp := StringReplace(temp, '$G', dmZLogGlobal.GetGreetingsCode(), [rfReplaceAll]);

   temp := StringReplace(temp, '$C', aQSO.Callsign, [rfReplaceAll]);

   Result := temp;
end;

procedure zLogSendStr(nID: Integer; S: string; C: string);
var
   rig: TRig;
begin
   dmZLogKeyer.ResetSpeed();
   zLogSetSendText(nID, S, C);

   if dmZLogKeyer.UseWinKeyer = True then begin

      if dmZLogGlobal.Settings._so2r_type = so2rNeo then begin
         dmZLogKeyer.So2rNeoReverseRx(nID)
      end;

      dmZLogKeyer.WinKeyerClear();
      dmZLogKeyer.ControlPTT(nID, True);
      dmZLogKeyer.WinKeyerSendStr2(S);
   end
   else if dmZLogKeyer.KeyingPort[nID] = tkpRIG then begin
      rig := MainForm.RigControl.Rigs[nID + 1];
      if rig <> nil then begin
         rig.SetWPM(dmZLogKeyer.WPM);
         rig.PlayMessageCW(S);
         dmZLogKeyer.OnSendFinishProc(dmZLogKeyer, mCW, False);
      end;
   end
   else begin
      dmZLogKeyer.PauseCW;

      if dmZLogGlobal.Settings.CW._FIFO then begin
         dmZLogKeyer.SendStrFIFO(nID, S);
      end
      else begin
         dmZLogKeyer.ClrBuffer();
         dmZLogKeyer.SendStr(nID, S);
      end;

      if C <> '' then begin
         if dmZLogGlobal.Settings._so2r_type = so2rNone then begin
            dmZLogKeyer.SetCallSign(C);
         end
         else begin
            dmZLogKeyer.SetCallSign(C);
         end;
      end;
      dmZLogKeyer.ResumeCW;
   end;
end;

procedure zLogSendStr2(nID: Integer; S: string; aQSO: TQSO);
begin
   if aQSO.Mode = mCW then begin
      S := SetStr(S, aQSO);
   end;
   if aQSO.Mode = mRTTY then begin
      S := SetStrNoAbbrev(S, aQSO);
   end;

   zLogSendStr(nID, S, aQSO.Callsign);
end;

procedure zLogSetSendText(nID: Integer; S, C: string);
begin
   if C = '' then begin
      MainForm.CWMonitor.SetSendingText(nID + 1, S);
   end
   else begin
      S := StringReplace(S, ':***************', C + DupeString('*', 16 - Length(C)), [rfReplaceAll]);
      MainForm.CWMonitor.SetSendingText(nID + 1, S);
   end;
end;

end.
