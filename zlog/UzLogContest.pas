unit UzLogContest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StrUtils,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, Grids,
  UzLogGlobal, UzLogConst, UzLogQSO, UBasicMulti, UBasicScore, UQTCForm,
  UserDefinedContest, UWWZone;

type
  TWanted = class
    Multi : string;
    Bands : set of TBand;
    constructor Create;
  end;

  TContest = class
  protected
    FNeedCtyDat: Boolean;
    FUseCoeff: Boolean;
  private
    FContestName : string;
    FSerialType: TSerialType;
    FSentStr: string;
    FMultiFound : Boolean; // used in spacebarproc
    FBandLow: TBand;
    FBandHigh: TBand;
    FBandPlan: string;

    FUseContestPeriod: Boolean;
    FStartTime: Integer;   // äJénéûä‘ 21Ç‚0Ç»Ç« UTCÇ©Ç«Ç§Ç©ÇÕLog.QsoList[0].RSTsentÇ≈îªífÇ∑ÇÈ
    FPeriod: Integer;      // ä˙ä‘ 12,24,48Ç»Ç«
    FUseUTC: Boolean;      // False:JST True:UTC
    FSingle10G: Boolean;   // False:10.1GÇ∆10.4GÇÕï ÉoÉìÉh True:10.1GÇ∆10.4GÇÕÇPÇ¬ÇÃÉoÉìÉh
    FAdifContestId: string;

    FColWidths: array[0..16] of Integer;

    // Display exchange on other bands
    FSameExchange: Boolean; // true by default. false when serial number etc

    function DispExchangeOnOtherBands(strCallsign: string; aBand: TBand): string; virtual;
    function GetUseUTC(): Boolean;
    procedure SetUseUTC(v: Boolean);
    function GetUseContestPeriod(): Boolean;
    function GetColWidths(Index: Integer): Integer;
  public
    WantedList : TList;

    MultiForm: TBasicMulti;
    ScoreForm: TBasicScore;
    ZoneForm: TWWZone;

    constructor Create(AOwner: TComponent; N : string); virtual;
    destructor Destroy; override;
    procedure PostWanted(S : string);
    procedure DelWanted(S : string);
    procedure ClearWanted;
    function QTHString(aQSO: TQSO) : string; virtual;
    procedure LogQSO(var aQSO : TQSO; Local : Boolean); virtual;
    procedure ShowScore; virtual;
    procedure ShowMulti; virtual;
    procedure Renew; virtual;

    function SpaceBarProc(strCallsign: string; strNumber: string; b: TBand): string; virtual; {called when space is pressed when Callsign Edit
                                      is in focus AND the callsign is not DUPE}
    procedure SetNrSent(aQSO: TQSO); virtual;
    procedure SetPoints(aQSO: TQSO); virtual; {Sets QSO.points according to band/mode}
                                                {called from ChangeBand/ChangeMode}
    procedure SetBand(B : TBand); virtual; {JA0}
    procedure WriteSummary(filename : string); // creates summary file
    function CheckWinSummary(aQSO : TQSO) : string; virtual; // returns summary for checkcall etc.
    function ADIF_ExchangeRX_FieldName : string; virtual;
    function ADIF_ExchangeRX(aQSO : TQSO) : string; virtual;
    function ADIF_ExtraFieldName : string; virtual;
    function ADIF_ExtraField(aQSO : TQSO) : string; virtual;
    procedure ADIF_Export(FileName : string);
    procedure RenewScoreAndMulti();
    function GetNewMulti1(aQSO : TQSO) : string; virtual;
    function GetNewMulti2(aQSO: TQSO): string; virtual;

    property Name: string read FContestName;
    property NeedCtyDat: Boolean read FNeedCtyDat;
    property UseCoeff: Boolean read FUseCoeff;
    property MultiFound: Boolean read FMultiFound write FMultiFound;
    property BandLow: TBand read FBandLow;
    property BandHigh: TBand read FBandHigh;
    property BandPlan: string read FBandPlan;
    property Single10G: Boolean read FSingle10G write FSingle10G;

    property UseContestPeriod: Boolean read GetUseContestPeriod write FUseContestPeriod;
    property StartTime: Integer read FStartTime write FStartTime;
    property Period: Integer read FPeriod write FPeriod;
    property UseUTC: Boolean read GetUseUTC write SetUseUTC;
    property AdifContestId: string read FAdifContestId write FAdifContestId;
    property SerialType: TSerialType read FSerialType write FSerialType;

    property ColWidths[Index: Integer]: Integer read GetColWidths;
    property SentStr: string read FSentStr;
    property SameExchange: Boolean read FSameExchange;
  end;

  TPedi = class(TContest)
    constructor Create(AOwner: TComponent; N : string); override;
    function GetNewMulti1(aQSO: TQSO): string; override;
    function GetNewMulti2(aQSO: TQSO): string; override;
  end;

  TALLJAContest = class(TContest)
  public
    constructor Create(AOwner: TComponent; N : string); override;
    function QTHString(aQSO: TQSO): string; override;
    function CheckWinSummary(aQSO : TQSO) : string; override;
    function GetNewMulti1(aQSO: TQSO): string; override;
  end;

  TACAGContest = class(TContest)
  public
    constructor Create(AOwner: TComponent; N : string); override;
  end;

  TFDContest = class(TContest)
  private
    function DispExchangeOnOtherBands(strCallsign: string; aBand: TBand): string; override;
  public
    constructor Create(AOwner: TComponent; N : string); override;
    function QTHString(aQSO: TQSO): string; override;
  end;

  TSixDownContest = class(TContest)
  private
    function DispExchangeOnOtherBands(strCallsign: string; aBand: TBand): string; override;
  public
    constructor Create(AOwner: TComponent; N : string); override;
    function QTHString(aQSO: TQSO): string; override;
  end;

  TGeneralContest = class(TContest)
    FConfig: TUserDefinedContest;
    FUserDatLoaded: Boolean;
  public
    constructor Create(AOwner: TComponent; N, CFGFileName: string); reintroduce;
    destructor Destroy(); override;
    procedure SetPoints(aQSO : TQSO); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
    function GetNewMulti2(aQSO : TQSO) : string; override;

    property Config: TUserDefinedContest read FConfig;
    property UserDatLoaded: Boolean read FUserDatLoaded;
  end;

  TCQWPXContest = class(TContest)
    constructor Create(AOwner: TComponent; N : string; M: TContestMode); reintroduce;
    function ADIF_ExtraFieldName : string; override;
    function ADIF_ExtraField(aQSO : TQSO) : string; override;
    function GetNewMulti1(aQSO: TQSO): string; override;
  end;

  TWAEContest = class(TContest)
    QTCForm: TQTCForm;
    constructor Create(AOwner: TComponent; N : string; M: TContestMode); reintroduce;
    destructor Destroy(); override;
    function GetNewMulti1(aQSO: TQSO): string; override;
  end;

  TIOTAContest = class(TContest)
    constructor Create(AOwner: TComponent; N : string); override;
    function QTHString(aQSO: TQSO): string; override;
    function SpaceBarProc(strCallsign: string; strNumber: string; b: TBand): string; override;
    function GetNewMulti1(aQSO: TQSO): string; override;
  end;

  TARRL10Contest = class(TContest)
    constructor Create(AOwner: TComponent; N : string); override;
    function CheckWinSummary(aQSO : TQSO) : string; override;
    function GetNewMulti1(aQSO: TQSO): string; override;
  end;

  TJA0Contest = class(TContest)
    constructor Create(AOwner: TComponent; N : string); override;
  end;

  TJA0ContestZero = class(TJA0Contest)
    constructor Create(AOwner: TComponent; N : string); override;
  end;

  TAPSprint = class(TContest)
    constructor Create(AOwner: TComponent; N : string); override;
    function GetNewMulti1(aQSO: TQSO): string; override;
  end;

  TCQWWContest = class(TContest)
    constructor Create(AOwner: TComponent; N : string; M: TContestMode; fJIDX: Boolean = False); reintroduce;
    function SpaceBarProc(strCallsign: string; strNumber: string; b: TBand): string; override;
    procedure ShowMulti; override;
    function CheckWinSummary(aQSO : TQSO) : string; override;
    function ADIF_ExchangeRX_FieldName : string; override;
    function GetNewMulti1(aQSO: TQSO): string; override;
  end;

  TIARUContest = class(TContest)
    constructor Create(AOwner: TComponent; N : string); override;
    function SpaceBarProc(strCallsign: string; strNumber: string; b: TBand): string; override;
    function ADIF_ExchangeRX_FieldName : string; override;
    function GetNewMulti1(aQSO: TQSO): string; override;
  end;

  TJIDXContest = class(TCQWWContest)
    constructor Create(AOwner: TComponent; N : string; M: TContestMode); reintroduce;
    procedure SetPoints(aQSO : TQSO); override;
    function GetNewMulti1(aQSO: TQSO): string; override;
  end;

  TJIDXContestDX = class(TContest)
    constructor Create(AOwner: TComponent; N : string; M: TContestMode); reintroduce;
    procedure SetPoints(aQSO : TQSO); override;
    function GetNewMulti1(aQSO: TQSO): string; override;
  end;

  TARRLDXContestDX = class(TContest)
    constructor Create(AOwner: TComponent; N : string; M: TContestMode); reintroduce;
    function ADIF_ExchangeRX_FieldName : string; override;
    function GetNewMulti1(aQSO: TQSO): string; override;
  end;

  TARRLDXContestW = class(TContest)
    constructor Create(AOwner: TComponent; N : string; M: TContestMode); reintroduce;
    function ADIF_ExchangeRX_FieldName : string; override;
    function GetNewMulti1(aQSO: TQSO): string; override;
  end;

  TAllAsianContest = class(TContest)
    constructor Create(AOwner: TComponent; N : string; M: TContestMode); reintroduce;
    procedure SetPoints(aQSO : TQSO); override;
    function ADIF_ExchangeRX_FieldName : string; override;
    function GetNewMulti1(aQSO: TQSO): string; override;
  end;

implementation

uses
  UzLogCW, URenewThread,
  UIOTAMulti, UJIDXMulti, UJIDXScore2, UWWMulti, UWWScore,
  UARRLDXMulti, UARRLDXScore, UAPSprintScore, UJA0Score, UJA0Multi,
  UARRLWMulti, UAllAsianScore, UJIDX_DX_Multi, UJIDX_DX_Score,
  UWPXMulti, UWPXScore, UWAEMulti, UWAEScore, UIARUMulti, UIARUScore,
  UARRL10Multi, UARRL10Score, UPediScore, UALLJAMulti, UALLJAScore,
  UACAGMulti, UFDMulti, USixDownMulti, UGeneralMulti2, UGeneralScore;

constructor TContest.Create(AOwner: TComponent; N: string);
begin
   MultiForm := nil;
   ScoreForm := nil;
   ZoneForm := nil;
   WantedList := TList.Create;

   FSameExchange := True;
   FContestName := N;

   Log.AcceptDifferentMode := False;
   Log.CountHigherPoints := False;

   Log.QsoList[0].Callsign := dmZlogGlobal.Settings._mycall; // Callsign
   Log.QsoList[0].Memo := N; // Contest name
   Log.QsoList[0].RSTRcvd := 100; // or Field Day coefficient

   FSentStr := '';

   FNeedCtyDat := False;
   FUseCoeff := False;

   FBandLow := b19;
   FBandHigh := b50;

   FBandPlan := 'JA';

   FUseContestPeriod := True;
   FStartTime := 21;
   FPeriod := 18;
   UseUTC := False;

   AdifContestId := '';
   FSingle10G := True;

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 4;      // Sent RST
   FColWidths[5] := 10;     // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 3;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

destructor TContest.Destroy;
begin
   inherited;

   WantedList.Free();

   if Assigned(MultiForm) then begin
      MultiForm.Release();
   end;
   if Assigned(ScoreForm) then begin
      ScoreForm.Release();
   end;
   if Assigned(ZoneForm) then begin
      ZoneForm.Release();
   end;
end;

procedure TContest.PostWanted(S: string);
var
   ss, mm: string;
   i, BB: Integer;
   W: TWanted;

begin
   ss := copy(S, 1, 2);
   ss := TrimRight(ss);

   BB := StrToInt(ss);
   if BB <= Ord(HiBand) then begin
      mm := copy(S, 3, 255);
      mm := TrimLeft(mm);
      mm := TrimRight(mm);
      for i := 0 to WantedList.Count - 1 do begin
         W := TWanted(WantedList[i]);
         if W.Multi = mm then begin
            W.Bands := W.Bands + [TBand(BB)];
            exit;
         end;
      end;
      W := TWanted.Create;
      W.Multi := mm;
      W.Bands := [TBand(BB)];
      WantedList.Add(W);
   end;
end;

procedure TContest.DelWanted(S: string);
var
   ss, mm: string;
   i, BB: Integer;
   W: TWanted;
begin
   ss := copy(S, 1, 2);
   ss := TrimRight(ss);

   BB := StrToInt(ss);
   if BB <= Ord(HiBand) then begin
      mm := copy(S, 3, 255);
      mm := TrimLeft(mm);
      mm := TrimRight(mm);
      for i := 0 to WantedList.Count - 1 do begin
         W := TWanted(WantedList[i]);
         if W.Multi = mm then begin
            W.Bands := W.Bands - [TBand(BB)];
            if W.Bands = [] then begin
               W.Free;
               WantedList.Delete(i);
               WantedList.Pack;
            end;
            exit;
         end;
      end;
   end;
end;

procedure TContest.ClearWanted;
var
   W: TWanted;
   i: Integer;
begin
   for i := 0 to WantedList.Count - 1 do begin
      W := TWanted(WantedList[i]);
      W.Free;
   end;
   WantedList.Clear;
end;

function TContest.QTHString(aQSO: TQSO): string;
begin
   Result := dmZlogGlobal.Settings._city;
end;

procedure TContest.LogQSO(var aQSO: TQSO; Local: Boolean);
begin
   if aQSO.Invalid = False then begin
      if Local = False then
         aQSO.Reserve2 := $AA; // some multi form and editscreen uses this flag

      MultiForm.AddNoUpdate(aQSO);

      aQSO.Reserve2 := $00;
      ScoreForm.AddNoUpdate(aQSO);
   end;

   aQSO.Reserve := actAdd;
   Log.AddQue(aQSO);
   Log.ProcessQue;

   MultiForm.UpdateData;
   ScoreForm.UpdateData;
end;

procedure TContest.ShowScore;
begin
   FormShowAndRestore(ScoreForm);
end;

procedure TContest.ShowMulti;
begin
   FormShowAndRestore(MultiForm);
end;

procedure TContest.Renew;
begin
   if dmZlogGlobal.Settings._renewbythread then begin
      RequestRenewThread;
      exit;
   end;

   RenewScoreAndMulti();

   MultiForm.UpdateData;
   ScoreForm.UpdateData;
end;

function TContest.SpaceBarProc(strCallsign: string; strNumber: string; b: TBand): string;
var
   strNewNumber: string;
begin
   FMultiFound := False;

   if {(strNumber = '') and} (FSameExchange = True) then begin
      strNewNumber := DispExchangeOnOtherBands(strCallsign, b);

      if strNewNumber <> '' then begin
         FMultiFound := True;
         strNumber := strNewNumber;
      end;
   end;

   Result := strNumber;
end;

procedure TContest.SetNrSent(aQSO: TQSO);
var
   S: string;
begin
   // ÉZÉbÉgÇ∑ÇÈílÇ™ñ≥Ç¢Ç»ÇÁÉZÉbÉgÇµÇ»Ç¢
   if (Pos('$Q', dmZlogGlobal.Settings._sentstr) > 0) and (QTHString(aQSO) = '') then begin
      Exit;
   end;
   if (Pos('$V', dmZlogGlobal.Settings._sentstr) > 0) and (dmZLogGlobal.Settings._prov = '') then begin
      Exit;
   end;
   if (Pos('$Z', dmZlogGlobal.Settings._sentstr) > 0) and (dmZLogGlobal.Settings._cqzone = '') then begin
      Exit;
   end;
   if (Pos('$I', dmZlogGlobal.Settings._sentstr) > 0) and (dmZLogGlobal.Settings._iaruzone = '') then begin
      Exit;
   end;
   if (Pos('$P', dmZlogGlobal.Settings._sentstr) > 0) and (aQSO.NewPowerStr = '') then begin
      Exit;
   end;

   S := SetStrNoAbbrev(dmZlogGlobal.Settings._sentstr, aQSO);

   S := StringReplace(S, '_', '', [rfReplaceAll]);

   aQSO.NrSent := S;
end;

procedure TContest.SetPoints(aQSO: TQSO);
begin
end;

procedure TContest.SetBand(B: TBand);
begin
end;

procedure TContest.WriteSummary(filename: string); // creates summary file
var
   f: textfile;
   S: string;
begin
   if Log.Year = 0 then
      exit;

   AssignFile(f, filename);
   Rewrite(f);

   S := FillRight('Year:', 12) + IntToStr(Log.Year);
   WriteLn(f, S);
   WriteLn(f);
   WriteLn(f, FContestName);
   WriteLn(f);
   S := FillRight('Callsign:', 12) + dmZlogGlobal.MyCall;
   WriteLn(f, S);
   WriteLn(f);
   WriteLn(f, 'Country: ');
   WriteLn(f);
   S := FillRight('Category:', 12);

   if dmZlogGlobal.ContestCategory = ccSingleOp then begin
      S := S + 'Single Operator  ';
   end
   else begin
      S := S + 'Multi Operator  ';
   end;

   if dmZlogGlobal.ContestBand = 0 then
      S := S + 'All band'
   else
      S := S + MHzString[TBand(Ord(dmZlogGlobal.ContestBand) - 1)];

   S := S + '  ';
   case dmZlogGlobal.ContestMode of
      cmMix:
         S := S + 'Phone/CW';
      cmCw:
         S := S + 'CW';
      cmPh:
         S := S + 'Phone';
   end;

   WriteLn(f, S);
   WriteLn(f);
   WriteLn(f, 'Band(MHz)      QSOs         Points       Multi.');

   WriteLn(f, 'Total');
   WriteLn(f, 'Score');

   WriteLn(f);

   CloseFile(f);
end;

function TContest.CheckWinSummary(aQSO: TQSO): string; // returns summary for checkcall etc.
begin
   Result := aQSO.CheckCallSummary;
end;

function TContest.ADIF_ExchangeRX_FieldName: string;
begin
//   if SerialContestType <> 0 then
//      Result := 'srx'
//   else
//      Result := 'srx_string';
   Result := '';
end;

function TContest.ADIF_ExchangeRX(aQSO: TQSO): string;
begin
   Result := aQSO.NrRcvd;
end;

function TContest.ADIF_ExtraFieldName: string;
begin
   Result := '';
end;

function TContest.ADIF_ExtraField(aQSO: TQSO): string;
begin
   Result := '';
end;

procedure TContest.ADIF_Export(filename: string);
var
   f: textfile;
   Header, S, temp: string;
   i: Integer;
   aQSO: TQSO;
   offsetmin: Integer;
   dbl: double;

   function AdifField(F, V: string): string;
   begin
      if F = '' then begin
         Result := '';
      end
      else begin
         Result := '<' + F + ':' + IntToStr(Length(V)) + '>' + V;
      end;
   end;
begin
   Header := 'ADIF export from zLog for Windows'; // +dmZlogGlobal.Settings._mycall;

   AssignFile(f, filename);
   Rewrite(f);

   { str := 'zLog for Windows Text File'; }
   WriteLn(f, Header);
   WriteLn(f, 'All times in UTC');
   WriteLn(f, '<eoh>');

   offsetmin := Log.QsoList[0].RSTsent;
   { if offsetmin = 0 then // default JST for older versions
     offsetmin := -1*9*60; }
   if offsetmin = _USEUTC then // already recorded in utc
      offsetmin := 0;
   dbl := offsetmin / (24 * 60);

   for i := 1 to Log.TotalQSO do begin
      aQSO := Log.QsoList[i];

      S := AdifField('qso_date', FormatDateTime('yyyymmdd', aQSO.Time + dbl));
      S := S + AdifField('time_on', FormatDateTime('hhnn', aQSO.Time + dbl));
      S := S + AdifField('time_off', FormatDateTime('hhnn', aQSO.Time + dbl));

      S := S + AdifField('call', aQSO.Callsign);

      S := S + AdifField('rst_sent', IntToStr(aQSO.RSTsent));

      if FSerialType = stNone then begin
         S := S + AdifField('stx_string', aQSO.NrSent);
      end
      else begin
         S := S + AdifField('stx', IntToStr(aQSO.Serial));
      end;

      S := S + AdifField('rst_rcvd', IntToStr(aQSO.RSTRcvd));

      if FSerialType = stNone then begin
         S := S + AdifField('srx_string', aQSO.NrRcvd);
      end
      else begin
         S := S + AdifField('srx', aQSO.NrRcvd);
      end;

      S := S + AdifField(ADIF_ExchangeRX_FieldName, ADIF_ExchangeRX(aQSO));

      temp := ADIF_ExtraField(aQSO);
      if temp <> '' then begin
         S := S + AdifField(ADIF_ExtraFieldName, temp);
      end;

      S := S + AdifField('band', ADIFBandString[aQSO.Band]);
      S := S + AdifField('mode', ModeString[aQSO.mode]);

      if aQSO.Operator <> '' then begin
         S := S + AdifField('operator', aQSO.Operator);
      end;

      if aQSO.Memo <> '' then begin
         S := S + AdifField('comment', aQSO.Memo);
      end;

      temp := aQSO.FreqStr2;
      if temp <> '' then begin
         S := S + AdifField('freq', temp);
      end;

      temp := AdifContestId;
      if temp <> '' then begin
         S := S + AdifField('contest_id', temp);
      end;

      S := S + '<eor>';

      WriteLn(f, S);
   end;

   CloseFile(f);
end;

procedure TContest.RenewScoreAndMulti();
var
   i: Integer;
   aQSO: TQSO;
begin
   MultiForm.Reset();
   ScoreForm.Reset();

   // DUPEçƒåvéZ
   Log.SetDupeFlags;

   // Score&NewMultiçƒåvéZ
   for i := 1 to Log.TotalQSO do begin
      aQSO := Log.QsoList[i];

      if Log.CountHigherPoints = True then begin
         Log.IsDupe(aQSO); // called to set log.differentmodepointer
      end;

      aQSO.NewMulti1 := False;
      aQSO.NewMulti2 := False;

      if aQSO.Invalid = False then begin
         MultiForm.AddNoUpdate(aQSO);
         ScoreForm.AddNoUpdate(aQSO);
      end;
   end;
end;

function TContest.GetNewMulti1(aQSO: TQSO): string;
begin
   if aQSO.NewMulti1 then begin
      Result := '*';
   end
   else begin
      Result := '';
   end;
end;

function TContest.GetNewMulti2(aQSO: TQSO): string;
begin
   if aQSO.NewMulti2 then begin
      Result := '*';
   end
   else begin
      Result := '';
   end;
end;

function TContest.DispExchangeOnOtherBands(strCallsign: string; aBand: TBand): string;
var
   Q: TQSO;
begin
   Q := Log.ObjectOf(strCallsign);
   if Q = nil then begin
      Result := '';
      Exit;
   end;

   Result := Q.NrRcvd;
end;

function TContest.GetUseUTC(): Boolean;
begin
   Result := FUseUTC;   //(Log.QsoList[0].RSTsent = _USEUTC);
end;

procedure TContest.SetUseUTC(v: Boolean);
begin
   FUseUTC := v;

   if FUseUTC then begin
      Log.QsoList[0].RSTsent := _USEUTC;
   end
   else begin
      Log.QsoList[0].RSTsent := UTCOffset();
   end;
end;

function TContest.GetUseContestPeriod(): Boolean;
begin
   if dmZLogGlobal.Settings._use_contest_period = False then begin
      Result := False;
   end
   else begin
      Result := FUseContestPeriod;
   end;
end;

function TContest.GetColWidths(Index: Integer): Integer;
begin
   Result := FColWidths[Index];
end;

{ TPedi }

constructor TPedi.Create(AOwner: TComponent; N: string);
begin
   inherited;
   MultiForm := TBasicMulti.Create(AOwner);
   ScoreForm := TPediScore.Create(AOwner);

   Log.AcceptDifferentMode := True;

   if UseUTC then
      Log.QsoList[0].RSTsent := _USEUTC
   else
      Log.QsoList[0].RSTsent := UTCOffset;

   FSentStr := '';

   FBandLow := b19;
   FBandHigh := HiBand;

   FUseContestPeriod := False;
   FStartTime := -1;
   FPeriod := 0;
   FNeedCtyDat := True;

   AdifContestId := '';

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 4;      // Sent RST
   FColWidths[5] := 10;     // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 0;     // point
   FColWidths[13] := 0;     // multi1
   FColWidths[14] := 0;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

function TPedi.GetNewMulti1(aQSO: TQSO): string;
begin
   Result := '';
end;

function TPedi.GetNewMulti2(aQSO: TQSO): string;
begin
   Result := '';
end;

{ TALLJAContest }

constructor TALLJAContest.Create(AOwner: TComponent; N: string);
begin
   inherited;
   MultiForm := TALLJAMulti.Create(AOwner);
   ScoreForm := TALLJAScore.Create(AOwner, b19, b50);
   FSentStr := '$V$P';
   FStartTime := 21;
   FPeriod := 24;
   AdifContestId := 'JA_DOMESTIC';

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 0;      // Sent RST
   FColWidths[5] := 0;      // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 0;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

function TALLJAContest.QTHString(aQSO: TQSO): string;
begin
   Result := dmZlogGlobal.Settings._prov;
end;

function TALLJAContest.CheckWinSummary(aQSO: TQSO): string;
var
   S: string;
begin
   S := '';
   S := S + FillRight(aQSO.BandStr, 5);
   S := S + aQSO.TimeStr + ' ';
   S := S + FillRight(aQSO.Callsign, 12);
   S := S + FillRight(aQSO.NrRcvd, 5);
   S := S + FillRight(aQSO.ModeStr, 4);
   Result := S;
end;

function TALLJAContest.GetNewMulti1(aQSO: TQSO): string;
begin
   if aQSO.NewMulti1 then begin
      Result := aQSO.Multi1;
   end
   else begin
      Result := '';
   end;
end;

{ TACAGContest }

constructor TACAGContest.Create(AOwner: TComponent; N: string);
begin
   inherited;
   MultiForm := TACAGMulti.Create(AOwner);
   ScoreForm := TALLJAScore.Create(AOwner, b19, HiBand);
   FSentStr := '$Q$P';
   FBandLow := b19;
   FBandHigh := HiBand;
   FStartTime := 21;
   FPeriod := 24;
   AdifContestId := 'JA_DOMESTIC';

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 0;      // Sent RST
   FColWidths[5] := 0;      // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 0;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

{ TFDContest }

constructor TFDContest.Create(AOwner: TComponent; N: string);
begin
   inherited;
   MultiForm := TFDMulti.Create(AOwner);
   ScoreForm := TALLJAScore.Create(AOwner, b19, HiBand);
   FSentStr := '$Q$P';
   FUseCoeff := True;
   FBandLow := b19;
   FBandHigh := HiBand;
   FStartTime := 21;
   FPeriod := 18;
   AdifContestId := 'JA_DOMESTIC';

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 0;      // Sent RST
   FColWidths[5] := 0;      // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 0;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

function TFDContest.QTHString(aQSO: TQSO): string;
begin
   if aQSO.Band <= b1200 then
      Result := dmZlogGlobal.Settings._prov
   else
      Result := dmZlogGlobal.Settings._city;
end;

function TFDContest.DispExchangeOnOtherBands(strCallsign: string; aBand: TBand): string;
var
   j: Integer;
   str: string;
   currshf: Boolean;
   pastQSO, tempQSO: TQSO;
begin
   currshf := IsSHF(aBand);
   pastQSO := nil;
   tempQSO := nil;

   for j := 1 to Log.TotalQSO do begin
      if strCallsign = Log.QsoList[j].Callsign then begin
         if currshf = IsSHF(Log.QsoList[j].Band) then begin
            pastQSO := Log.QsoList[j];
            break;
         end
         else begin
            tempQSO := Log.QsoList[j];
         end;
      end;
   end;

   if pastQSO <> nil then begin
      Result := pastQSO.NrRcvd;
   end
   else begin
      if tempQSO <> nil then begin
         if currshf = True then begin
            if length(tempQSO.NrRcvd) > 3 then
               str := '01' + ExtractPower(tempQSO.NrRcvd)
            else
               str := tempQSO.NrRcvd;

            Result := str;
         end
         else begin
            str := ExtractKenNr(tempQSO.NrRcvd) + ExtractPower(tempQSO.NrRcvd);
            Result := str;
         end;
      end
      else // if tempQSO = nil
      begin
         Result := '';
      end;
   end;
end;

{ TSixDownContest }

constructor TSixDownContest.Create(AOwner: TComponent; N: string);
begin
   inherited;
   MultiForm := TSixDownMulti.Create(AOwner);
   ScoreForm := TALLJAScore.Create(AOwner, b50, HiBand);
   TALLJAScore(ScoreForm).PointTable[b2400] := 2;
   TALLJAScore(ScoreForm).PointTable[b5600] := 2;
   TALLJAScore(ScoreForm).PointTable[b10g] := 2;
   TALLJAScore(ScoreForm).PointTable[b104g] := 0;
   TALLJAScore(ScoreForm).PointTable[b24g] := 2;
   TALLJAScore(ScoreForm).PointTable[b47g] := 2;
   TALLJAScore(ScoreForm).PointTable[b77g] := 2;
   TALLJAScore(ScoreForm).PointTable[b135g] := 2;
   TALLJAScore(ScoreForm).PointTable[b248g] := 2;
   FSentStr := '$Q$P';
   FBandLow := b50;
   FBandHigh := HiBand;
   FStartTime := 21;
   FPeriod := 18;
   AdifContestId := 'JA_DOMESTIC';

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 0;      // Sent RST
   FColWidths[5] := 0;      // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 0;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

function TSixDownContest.QTHString(aQSO: TQSO): string;
begin
   if aQSO.Band <= b1200 then
      Result := dmZlogGlobal.Settings._prov
   else
      Result := dmZlogGlobal.Settings._city;
end;

function TSixDownContest.DispExchangeOnOtherBands(strCallsign: string; aBand: TBand): string;
var
   j: Integer;
   str: string;
   currshf: Boolean;
   pastQSO, tempQSO: TQSO;
begin
   currshf := IsSHF(aBand);
   pastQSO := nil;
   tempQSO := nil;

   for j := 1 to Log.TotalQSO do begin
      if strCallsign = Log.QsoList[j].Callsign then begin
         if currshf = IsSHF(Log.QsoList[j].Band) then begin
            pastQSO := Log.QsoList[j];
            break;
         end
         else begin
            tempQSO := Log.QsoList[j];
         end;
      end;
   end;

   if pastQSO <> nil then begin
      Result := pastQSO.NrRcvd;
   end
   else begin
      if tempQSO <> nil then begin
         if currshf = True then begin
            if length(tempQSO.NrRcvd) > 3 then
               str := '01' + ExtractPower(tempQSO.NrRcvd)
            else
               str := tempQSO.NrRcvd;

            Result := str;
         end
         else begin
            str := ExtractKenNr(tempQSO.NrRcvd) + ExtractPower(tempQSO.NrRcvd);
            Result := str;
         end;
      end
      else // if tempQSO = nil
      begin
         Result := '';
      end;
   end;
end;

{ TGeneralContest }

constructor TGeneralContest.Create(AOwner: TComponent; N, CFGFileName: string);
begin
   inherited Create(AOwner, N);
   FUserDatLoaded := False;
   MultiForm := TGeneralMulti2.Create(AOwner);
   ScoreForm := TGeneralScore.Create(AOwner);
   TGeneralScore(ScoreForm).formMulti := TGeneralMulti2(MultiForm);

   FConfig := TUserDefinedContest.Parse(CFGFileName);
   TGeneralScore(ScoreForm).Config := FConfig;
   TGeneralMulti2(MultiForm).Config := FConfig;

   if FConfig.DatFileName <> '' then begin
      TGeneralMulti2(MultiForm).LoadDAT(FConfig.DatFileFullPath);
      if TGeneralMulti2(MultiForm).MultiList.List.Count > 0 then begin
         FUserDatLoaded := True;
      end;
   end
   else begin
      FUserDatLoaded := True;
   end;

   dmZlogGlobal.Settings._sentstr         := FConfig.Sent;

   Log.AcceptDifferentMode                := FConfig.AcceptDifferentMode;
   Log.AllPhone                           := FConfig.AllPhone;
   Log.CountHigherPoints                  := FConfig.CountHigherPoints;

   if FConfig.UseUTC = True then begin
      UseUTC := True;
      Log.QsoList[0].RSTSent := _USEUTC; // JST = 0; UTC = $FFFF
   end;

   FSerialType := FConfig.SerialContestType;

   FSentStr := dmZlogGlobal.Settings._sentstr;

   FNeedCtyDat := FConfig.UseCtyDat;
   FUseCoeff   := FConfig.Coeff;

   FBandLow := FConfig.BandLow;
   FBandHigh := FConfig.BandHigh;

   if FConfig.BandPlan <> '' then begin
      FBandPlan := FConfig.BandPlan;
   end;

   FUseContestPeriod := FConfig.UseContestPeriod;
   FStartTime := FConfig.StartTime;
   FPeriod := FConfig.Period;
   Log.QsoList[0].Serial := $01; // uses serial number
   FSameExchange := FConfig.SameExchange;
   AdifContestId := FConfig.ContestId;

   FSingle10G := FConfig.Single10G;

   if SerialType = stNone then begin
      // ëóêMÇmÇq
      if FConfig.UseSentRST = True then begin
         FColWidths[4] := 4;
         FColWidths[4] := 10;
      end
      else begin
         FColWidths[4] := 0;
         FColWidths[4] := 0;
      end;

      // É}ÉãÉ`ÇQ
      if FConfig.UseMulti2 = True then begin
         FColWidths[14] := 3;
      end
      else begin
         FColWidths[14] := 0;
      end;
   end
   else begin
      // ëóêMÇmÇq
      if FConfig.UseSentRST = True then begin
         FColWidths[4] := 4;
         FColWidths[4] := 10;
      end
      else begin
         FColWidths[4] := 0;
         FColWidths[4] := 0;
      end;

      // É}ÉãÉ`ÇQ
      if FConfig.UseMulti2 = True then begin
         FColWidths[14] := 3;
      end
      else begin
         FColWidths[14] := 0;
      end;
   end;
end;

destructor TGeneralContest.Destroy();
begin
   Inherited;
   FConfig.Free();
end;

procedure TGeneralContest.SetPoints(aQSO: TQSO);
begin
   TGeneralScore(ScoreForm).CalcPoints(aQSO);
end;

function TGeneralContest.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   Result := '';

   if SerialType = stNone then begin
      if aQSO.NewMulti1 then
         temp := aQSO.Multi1
      else
         temp := '';
   end
   else begin
      if FConfig.PXMulti = 0 then begin
         if aQSO.NewMulti1 then
            Result := aQSO.Multi1;
      end
      else begin
         temp := '  ' + aQSO.Multi1;
         if aQSO.NewMulti1 then
            temp[1] := '*';
         Result := temp;
      end;
   end;

   Result := temp;
end;

function TGeneralContest.GetNewMulti2(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.NewMulti2 then
      temp := aQSO.Multi2
   else
      temp := '';
   Result := temp;
end;

{ TCQWPXContest }

constructor TCQWPXContest.Create(AOwner: TComponent; N: string; M: TContestMode);
begin
   inherited Create(AOwner, N);

   MultiForm := TWPXMulti.Create(AOwner);
   ScoreForm := TWPXScore.Create(AOwner);
   ZoneForm := nil;
   MultiForm.Reset();

   TWPXScore(ScoreForm).MultiForm := TWPXMulti(MultiForm);

   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   Log.QsoList[0].Serial := $01; // uses serial number
   FSerialType := stAll;
   FSameExchange := False;
   FSentStr := '$S';
   FNeedCtyDat := True;

   FBandLow := b19;
   FBandHigh := b28;
   FBandPlan := 'DX';

   FStartTime := 0;  // UTC
   FPeriod := 48;

   case M of
      cmMix: AdifContestId := '';
      cmCw: AdifContestId := 'CQWPX-CW';
      cmPh: AdifContestId := 'CQWPX-SSB';
      else AdifContestId := 'CQWPX-RTTY';
   end;

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 4;      // Sent RST
   FColWidths[5] := 10;     // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 3;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

function TCQWPXContest.ADIF_ExtraFieldName: string;
begin
   Result := 'pfx';
end;

function TCQWPXContest.ADIF_ExtraField(aQSO: TQSO): string;
begin
   Result := aQSO.Multi1;
end;

function TCQWPXContest.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   temp := '  ' + aQSO.Multi1;

   if aQSO.NewMulti1 then begin
      temp[1] := '*';
   end;

   Result := temp;
end;

constructor TWAEContest.Create(AOwner: TComponent; N: string; M: TContestMode);
begin
   inherited Create(AOwner, N);

   MultiForm := TWAEMulti.Create(AOwner);
   ScoreForm := TWAEScore.Create(AOwner);
   ZoneForm := TWWZone.Create(AOwner);
   QTCForm := TQTCForm.Create(AOwner);

   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   Log.QsoList[0].Serial := $01; // uses serial number
   FSerialType := stAll;
   FSameExchange := False;
   FSentStr := '$S';
   FNeedCtyDat := True;

   FBandLow := b19;
   FBandHigh := b28;
   FBandPlan := 'DX';

   FStartTime := 0;  // UTC
   FPeriod := 48;

   case M of
      cmMix: AdifContestId := '';
      cmCw: AdifContestId := 'DARC-WAEDC-CW';
      cmPh: AdifContestId := 'DARC-WAEDC-SSB';
      else AdifContestId := 'DARC-WAEDC-RTTY';
   end;

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 4;      // Sent RST
   FColWidths[5] := 10;     // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 3;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

destructor TWAEContest.Destroy();
begin
   QTCForm.Release();
end;

function TWAEContest.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   temp := '  ' + aQSO.Multi1;

   if aQSO.NewMulti1 then begin
      temp[1] := '*';
   end;

   Result := temp;
end;

{ TIOTAContest }

constructor TIOTAContest.Create(AOwner: TComponent; N: string);
begin
   inherited;

   MultiForm := TIOTAMulti.Create(AOwner);
   ScoreForm := TIARUScore.Create(AOwner);
   TIARUScore(ScoreForm).InitGrid(b35, b28);

   UseUTC := True;
   Log.AcceptDifferentMode := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   Log.QsoList[0].Serial := $01; // uses serial number
   FSerialType := stAll;
   FSentStr := '$S$Q';
   FNeedCtyDat := True;

   FBandLow := b35;
   FBandHigh := b28;
   FBandPlan := 'DX';

   FStartTime := 12; // UTC
   FPeriod := 24;

   AdifContestId := 'RSGB-IOTA';

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 4;      // Sent RST
   FColWidths[5] := 10;     // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 6;     // multi1
   FColWidths[14] := 0;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

function TIOTAContest.QTHString(aQSO: TQSO): string;
begin
   Result := TIOTAMulti(MultiForm).MyIOTA;
end;

function TIOTAContest.SpaceBarProc(strCallsign: string; strNumber: string; b: TBand): string;
var
   Q: TQSO;
begin
   strNumber := inherited SpaceBarProc(strCallsign, strNumber, b);

   Q := TQSO.Create();
   Q.Callsign := strCallsign;
   Q.NrRcvd := strNumber;

   if FMultiFound and (TIOTAMulti(MultiForm).ExtractMulti(Q) = '') then begin // serial number
      strNumber := '';
   end;

   Result := strNumber;

   Q.Free();
end;

function TIOTAContest.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   // temp := '  '+aQSO.Multi1;
   if aQSO.NewMulti1 then
      temp := aQSO.Multi1;
   Result := temp;
end;

{ TARRL10Contest }

constructor TARRL10Contest.Create(AOwner: TComponent; N: string);
begin
   inherited;

   MultiForm := TARRL10Multi.Create(AOwner);
   ScoreForm := TARRL10Score.Create(AOwner);
   ZoneForm := TWWZone.Create(AOwner);

   UseUTC := True;
   Log.AcceptDifferentMode := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   Log.QsoList[0].Serial := $01; // uses serial number
   FSerialType := stAll;
   FSameExchange := False;
   FNeedCtyDat := True;

   FBandLow := b28;
   FBandHigh := b28;
   FBandPlan := 'DX';

   FStartTime := 0;  // UTC
   FPeriod := 48;

   AdifContestId := 'ARRL-10';

   if dmZLogGlobal.IsUSA() then begin
      FSentStr := '$V';
      FColWidths[0] := 3;      // status
      FColWidths[1] := 6;      // date
      FColWidths[2] := 6;      // time
      FColWidths[3] := 12;     // callsign
      FColWidths[4] := 4;      // Sent RST
      FColWidths[5] := 10;     // Sent Number
      FColWidths[6] := 4;      // Rcvd RST
      FColWidths[7] := 10;     // Rcvd Number
      FColWidths[8] := 4;      // band
      FColWidths[9] := 4;      // mode
      FColWidths[10] := 6;     // op
      FColWidths[11] := 7;     // memo
      FColWidths[12] := 4;     // point
      FColWidths[13] := 3;     // multi1
      FColWidths[14] := 3;     // multi2
      FColWidths[15] := 10;    // freq
      FColWidths[16] := 0;     // QSOID
   end
   else begin
      FSentStr := '$S';
      FColWidths[0] := 3;      // status
      FColWidths[1] := 6;      // date
      FColWidths[2] := 6;      // time
      FColWidths[3] := 12;     // callsign
      FColWidths[4] := 4;      // Sent RST
      FColWidths[5] := 10;     // Sent Number
      FColWidths[6] := 4;      // Rcvd RST
      FColWidths[7] := 10;     // Rcvd Number
      FColWidths[8] := 4;      // band
      FColWidths[9] := 4;      // mode
      FColWidths[10] := 6;     // op
      FColWidths[11] := 7;     // memo
      FColWidths[12] := 4;     // point
      FColWidths[13] := 6;     // multi1
      FColWidths[14] := 0;     // multi2
      FColWidths[15] := 10;    // freq
      FColWidths[16] := 0;     // QSOID
   end;
end;

function TARRL10Contest.CheckWinSummary(aQSO: TQSO): string; // returns summary for checkcall etc.
var
   str: string;
begin
   str := aQSO.CheckCallSummary;
   if aQSO.mode = mCW then
      Insert('CW ', str, 5)
   else
      Insert('Ph ', str, 5);

   Result := str;
end;

function TARRL10Contest.GetNewMulti1(aQSO: TQSO): string;
begin
   if aQSO.NewMulti1 then
      Result := aQSO.Multi1
   else
      Result := '';
end;

{ TJA0Contest }

constructor TJA0Contest.Create(AOwner: TComponent; N: string);
begin
   inherited;
   MultiForm := TJA0Multi.Create(AOwner);
   ScoreForm := TJA0Score.Create(AOwner);

   Log.QsoList[0].Serial := $01; // uses serial number
   FSerialType := stAll;
   FSameExchange := False;
   FSentStr := '$S';

   FBandLow := b19;
   FBandHigh := b28;
   FBandPlan := 'JA';

   FUseContestPeriod := False;
   FStartTime := -1;
   FPeriod := 0;

   AdifContestId := 'JA_DOMESTIC';

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 4;      // Sent RST
   FColWidths[5] := 10;     // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 0;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

{ TJA0ContestZero }

constructor TJA0ContestZero.Create(AOwner: TComponent; N: string);
begin
   inherited;

   TJA0Multi(MultiForm).JA0 := True;

   Log.QsoList[0].Serial := $01; // uses serial number
   FSerialType := stAll;
   FSameExchange := False;
   FSentStr := '$S';

   AdifContestId := 'JA_DOMESTIC';
end;

{ TAPSprint }

constructor TAPSprint.Create(AOwner: TComponent; N: string);
begin
   inherited;
   MultiForm := TWPXMulti.Create(AOwner);
   ScoreForm := TAPSprintScore.Create(AOwner);
   ZoneForm := TWWZone.Create(AOwner);

   TAPSprintScore(ScoreForm).MultiForm := TWPXMulti(MultiForm);

   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   Log.QsoList[0].Serial := $01; // uses serial number
   FSerialType := stAll;

   FSameExchange := False;
   FSentStr := '$S';

   FBandLow := b19;
   FBandHigh := b28;
   FBandPlan := 'DX';

   FUseContestPeriod := False;
   FStartTime := -1;
   FPeriod := 0;

   AdifContestId := 'AP-SPRINT';

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 4;      // Sent RST
   FColWidths[5] := 10;     // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 3;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

function TAPSprint.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   temp := '  ' + aQSO.Multi1;

   if aQSO.NewMulti1 then begin
      temp[1] := '*';
   end;

   Result := temp;
end;

{ TCQWWContest }

constructor TCQWWContest.Create(AOwner: TComponent; N: string; M: TContestMode; fJIDX: Boolean);
begin
   inherited Create(AOwner, N);

   if fJIDX = False then begin
      MultiForm := TWWMulti.Create(AOwner);
      ScoreForm := TWWScore.Create(AOwner);
      ZoneForm := TWWZone.Create(AOwner);
      TWWMulti(MultiForm).ZoneForm := ZoneForm;
      MultiForm.Reset();
   end;

   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   FSentStr := '$Z';
   FNeedCtyDat := True;

   FBandLow := b19;
   FBandHigh := b28;
   FBandPlan := 'DX';

   FStartTime := 0;  // UTC
   FPeriod := 48;

   case M of
      cmMIx: AdifContestId := '';
      cmCw: AdifContestId := 'CQWW-CW';
      cmPh: AdifContestId := 'CQWW-SSB';
      else AdifContestId := 'CQWW-RTTY';
   end;

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 0;      // Sent RST
   FColWidths[5] := 0;      // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 3;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

function TCQWWContest.SpaceBarProc(strCallsign: string; strNumber: string; b: TBand): string;
var
   temp: string;
begin
   temp := MultiForm.GuessZone(strCallsign);
   Result := temp;

   DispExchangeOnOtherBands(strCallsign, b);
end;

procedure TCQWWContest.ShowMulti;
begin
   MultiForm.Show;
   ZoneForm.Show;
end;

function TCQWWContest.CheckWinSummary(aQSO: TQSO): string;
var
   S: string;
begin
   S := '';
   S := S + FillRight(aQSO.BandStr, 5);
   S := S + aQSO.TimeStr + ' ';
   S := S + FillRight(aQSO.Callsign, 12);
   S := S + FillRight(aQSO.NrRcvd, 4);
   Result := S;
end;

function TCQWWContest.ADIF_ExchangeRX_FieldName: string;
begin
   Result := 'cqz';
end;

function TCQWWContest.GetNewMulti1(aQSO: TQSO): string;
var
   str: string;
begin
   if aQSO.NewMulti1 then
      str := FillRight(aQSO.Multi1, 3)
   else
      str := '   ';
   if aQSO.NewMulti2 then
      str := str + aQSO.Multi2;
   Result := str;
end;

{ TIARUContest }

constructor TIARUContest.Create(AOwner: TComponent; N: string);
begin
   inherited;

   MultiForm := TIARUMulti.Create(AOwner);
   ScoreForm := TIARUScore.Create(AOwner);
   ZoneForm := TWWZone.Create(AOwner);

   UseUTC := True;
   Log.AcceptDifferentMode := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   FSentStr := '$I';
   FNeedCtyDat := True;

   FBandLow := b19;
   FBandHigh := b28;
   FBandPlan := 'DX';

   FStartTime := 12; // UTC
   FPeriod := 24;

   AdifContestId := 'IARU-HF';

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 0;      // Sent RST
   FColWidths[5] := 0;      // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 4;     // multi1
   FColWidths[14] := 0;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

function TIARUContest.SpaceBarProc(strCallsign: string; strNumber: string; b: TBand): string;
var
   temp: string;
begin
   Result := inherited SpaceBarProc(strCallsign, strNumber, b);

   if (FMultiFound = False) and (strNumber = '') then begin
      temp := MultiForm.GuessZone(strCallsign);
      Result := temp;
   end;
end;

function TIARUContest.ADIF_ExchangeRX_FieldName: string;
begin
   Result := 'ituz';
end;

function TIARUContest.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.NewMulti1 then
      temp := aQSO.Multi1
   else
      temp := '';
   Result := temp;
end;

{ TJIDXContest }

constructor TJIDXContest.Create(AOwner: TComponent; N: string; M: TContestMode);
begin
   inherited Create(AOwner, N, M, True);    //   <-TCQWWContestÇ©ÇÁÇÃåpè≥Ç»ÇÃÇ≈inheritedïsâ¬
   MultiForm := TJIDXMulti.Create(AOwner);
   ScoreForm := TJIDXScore2.Create(AOwner);
   ZoneForm := TWWZone.Create(AOwner);
   TJIDXMulti(MultiForm).ZoneForm := ZoneForm;
   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   FSentStr := '$V';
   FNeedCtyDat := True;

   FBandLow := b19;
   FBandHigh := b28;
   FBandPlan := 'DX';

   FStartTime := 7;  // UTC
   FPeriod := 6;

   case M of
      cmMix: AdifContestId := '';
      cmCw: AdifContestId := 'JIDX-CW';
      cmPh: AdifContestId := 'JIDX-SSB';
      else AdifContestId := '';
   end;

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 0;      // Sent RST
   FColWidths[5] := 0;      // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 3;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

procedure TJIDXContest.SetPoints(aQSO: TQSO);
begin
   TJIDXScore2(ScoreForm).CalcPoints(aQSO);
end;

function TJIDXContest.GetNewMulti1(aQSO: TQSO): string;
var
   str: string;
begin
   if aQSO.NewMulti1 then
      str := FillRight(aQSO.Multi1, 3)
   else
      str := '   ';
   if aQSO.NewMulti2 then
      str := str + aQSO.Multi2;
   Result := str;
end;

{ TJIDXContestDX }

constructor TJIDXContestDX.Create(AOwner: TComponent; N: string; M: TContestMode);
begin
   inherited Create(AOwner, N);

   MultiForm := TJIDX_DX_Multi.Create(AOwner);
   ScoreForm := TJIDX_DX_Score.Create(AOwner);
   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   FSentStr := '$V';
   FNeedCtyDat := True;
   FBandPlan := 'DX';

   FStartTime := 7;  // UTC
   FPeriod := 6;

   case M of
      cmMix: AdifContestId := '';
      cmCw: AdifContestId := 'JIDX-CW';
      cmPh: AdifContestId := 'JIDX-SSB';
      else AdifContestId := '';
   end;

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 0;      // Sent RST
   FColWidths[5] := 0;      // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 3;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

procedure TJIDXContestDX.SetPoints(aQSO: TQSO);
begin
   TJIDX_DX_Score(ScoreForm).CalcPoints(aQSO);
end;

function TJIDXContestDX.GetNewMulti1(aQSO: TQSO): string;
begin
   if aQSO.NewMulti1 then begin
      Result := aQSO.Multi1;
   end
   else begin
      Result := '';
   end;
end;

{ TARRLDXContestDX }

constructor TARRLDXContestDX.Create(AOwner: TComponent; N: string; M: TContestMode);
begin
   inherited Create(AOwner, N);
   MultiForm := TARRLDXMulti.Create(AOwner);
   ScoreForm := TARRLDXScore.Create(AOwner);

   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   FSentStr := '$N';
   FNeedCtyDat := False;

   FBandLow := b19;
   FBandHigh := b28;
   FBandPlan := 'DX';

   FStartTime := 0;  // UTC
   FPeriod := 48;

   case M of
      cmMix: AdifContestId := '';
      cmCw: AdifContestId := 'ARRLDX-CW';
      cmPh: AdifContestId := 'ARRLSX-SSB';
      else AdifContestId := '';
   end;

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 4;      // Sent RST
   FColWidths[5] := 10;     // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 3;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

function TARRLDXContestDX.ADIF_ExchangeRX_FieldName: string;
begin
   Result := 'state';
end;

function TARRLDXContestDX.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.NewMulti1 then
      temp := aQSO.Multi1
   else
      temp := '';
   Result := temp;
end;

constructor TARRLDXContestW.Create(AOwner: TComponent; N: string; M: TContestMode);
begin
   inherited Create(AOwner, N);
   MultiForm := TARRLWMulti.Create(AOwner);
   TARRLWMulti(MultiForm).ALLASIANFLAG := False;
   ScoreForm := TARRLDXScore.Create(AOwner);
   ZoneForm := TWWZone.Create(AOwner);

   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   FSentStr := '$V';
   FNeedCtyDat := True;

   FBandLow := b19;
   FBandHigh := b28;
   FBandPlan := 'DX';

   FStartTime := 0;  // UTC
   FPeriod := 48;

   case M of
      cmMix: AdifContestId := '';
      cmCw: AdifContestId := 'ARRLDX-CW';
      cmPh: AdifContestId := 'ARRLSX-SSB';
      else AdifContestId := '';
   end;

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 4;      // Sent RST
   FColWidths[5] := 10;     // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 3;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

function TARRLDXContestW.ADIF_ExchangeRX_FieldName: string;
begin
   Result := 'rx_pwr';
end;

function TARRLDXContestW.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.NewMulti1 then
      temp := aQSO.Multi1
   else
      temp := '';
   Result := temp;
end;

{ TAllAsianContest }

constructor TAllAsianContest.Create(AOwner: TComponent; N: string; M: TContestMode);
begin
   inherited Create(AOwner, N);

   MultiForm := TARRLWMulti.Create(AOwner);
   TARRLWMulti(MultiForm).ALLASIANFLAG := True;
   ScoreForm := TAllAsianScore.Create(AOwner);
   ZoneForm := TWWZone.Create(AOwner);

   UseUTC := True;
   Log.QsoList[0].RSTsent := _USEUTC; // JST = 0; UTC = $FFFF
   FSentStr := '$A';

   FBandLow := b19;
   FBandHigh := b28;
   FBandPlan := 'DX';

   FNeedCtyDat := True;
   FStartTime := 0;  // UTC
   FPeriod := 48;

   case M of
      cmMix: AdifContestId := '';
      cmCw: AdifContestId := 'ALL-ASIAN-DX-CW';
      cmPh: AdifContestId := 'ALL-ASIAN-DX-SSB';
      else AdifContestId := '';
   end;

   FColWidths[0] := 3;      // status
   FColWidths[1] := 6;      // date
   FColWidths[2] := 6;      // time
   FColWidths[3] := 12;     // callsign
   FColWidths[4] := 4;      // Sent RST
   FColWidths[5] := 10;     // Sent Number
   FColWidths[6] := 4;      // Rcvd RST
   FColWidths[7] := 10;     // Rcvd Number
   FColWidths[8] := 4;      // band
   FColWidths[9] := 4;      // mode
   FColWidths[10] := 6;     // op
   FColWidths[11] := 7;     // memo
   FColWidths[12] := 4;     // point
   FColWidths[13] := 3;     // multi1
   FColWidths[14] := 3;     // multi2
   FColWidths[15] := 10;    // freq
   FColWidths[16] := 0;     // QSOID
end;

procedure TAllAsianContest.SetPoints(aQSO: TQSO);
begin
   TAllAsianScore(ScoreForm).CalcPoints(aQSO);
end;

function TAllAsianContest.ADIF_ExchangeRX_FieldName: string;
begin
   Result := 'age';
end;

function TAllAsianContest.GetNewMulti1(aQSO: TQSO): string;
begin
   if aQSO.NewMulti1 then
      Result := aQSO.Multi1
   else
      Result := '';
end;

{ TWanted }

constructor TWanted.Create;
begin
   Multi := '';
   Bands := [];
end;

end.
