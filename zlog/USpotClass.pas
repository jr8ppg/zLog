unit USpotClass;

interface

uses
  SysUtils, Windows, Classes,
  Generics.Collections, Generics.Defaults,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogSpc;

type
  TSpotSource = ( ssSelf = 0, ssCluster, ssSelfFromZServer, ssClusterFromZServer );

  TBaseSpot = class
  protected
    FTime : TDateTime; // moved from TBSdata 2.6e
    FCall : string;
    FNumber : string;
    FFreqHz : Int64;
    FCtyIndex : integer;
    FZone : integer;
    FNewCty : boolean;
    FNewZone : boolean;
    FWorked : boolean;
    FBand : TBand;
    FMode : TMode;
    FSpotSource: TSpotSource;
    FSpotGroup: Integer;
    FCQ: Boolean;
    FNewJaMulti: Boolean;
    FReportedBy: string;
  public
    constructor Create; virtual;
    function FreqKHzStr : string;
    function NewMulti : boolean; // newcty or newzone
    function InText : string; virtual; abstract;
    procedure FromText(S : string); virtual; abstract;
    procedure Assign(O: TBaseSpot); virtual;

    property Time: TDateTime read FTime write FTime;
    property Call: string read FCall write FCall;
    property Number: string read FNumber write FNumber;
    property FreqHz: Int64 read FFreqHz write FFreqHz;
    property CtyIndex: Integer read FCtyIndex write FCtyIndex;
    property Zone: Integer read FZone write FZone;
    property NewCty: Boolean read FNewCty write FNewCty;
    property NewZone: Boolean read FNewZone write FNewZone;
    property Worked: Boolean read FWorked write FWorked;
    property Band: TBand read FBand write FBand;
    property Mode: TMode read FMode write FMode;
    property SpotSource: TSpotSource read FSpotSource write FSpotSource;
    property SpotGroup: Integer read FSpotGroup write FSpotGroup;
    property CQ: Boolean read FCQ write FCQ;
    property NewJaMulti: Boolean read FNewJaMulti write FNewJaMulti;
    property ReportedBy: string read FReportedBy write FReportedBy;
  end;

  TSpot = class(TBaseSpot)
  protected
    FTimeStr : string;
    FComment : string;
  public
    constructor Create; override;
    function Analyze(S : string) : boolean; // true if successful
    function ClusterSummary : string;
    function InText : string; override;
    procedure FromText(S : string); override;
    procedure Assign(O: TBaseSpot); override;

    property TimeStr: string read FTimeStr write FTimeStr;
    property Comment: string read FComment write FComment;
  end;

  TBSData = class(TBaseSpot)
  protected
    FBold : boolean;
  public
    constructor Create; override;
    function LabelStr : string;
    function InText : string; override;
    procedure FromText(S : string); override;
    procedure Assign(O: TBaseSpot); override;

    property Bold: Boolean read FBold write FBold;
  end;

  TSpotList = class(TObjectList<TSpot>)
  public
    constructor Create(OwnsObjects: Boolean = True);
  end;

  TBSList = class(TObjectList<TBSData>)
  public
    constructor Create(OwnsObjects: Boolean = True);
  end;

  procedure SpotCheckWorked(Sp: TBaseSpot);

implementation

uses
  Main;

constructor TBaseSpot.Create;
begin
   FTime := Now;
   FCall := '';
   FNumber := '';
   FFreqHz := 0;
   FNewCty := false;
   FNewZone := false;
   FCtyIndex := 0;
   FZone := 0;
   FWorked := False;
   FBand := b19;
   FMode := mCW;
   FSpotSource := ssSelf;
   FSpotGroup := 1;
   FCQ := False;
   FNewJaMulti := False;
   FReportedBy := '';
end;

constructor TSpot.Create;
begin
   inherited;
   ReportedBy := '';
   TimeStr := '0000Z';
   Comment := '';
end;

constructor TBSData.Create;
begin
   inherited;
   FBold := False;
end;

function TBSData.LabelStr : string;
begin
   Result := FreqkHzStr + ' ' + Call;

   if Number <> '' then begin
      Result := Result + ' [' + Number + ']';
   end;
end;

function TSpot.Analyze(S : string) : boolean;
var
   temp, temp2 : string;
   i : integer;
   b: TBand;
begin
   Result := False;

   if length(S) < 5 then
      exit;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('[' + S + ']'));
   {$ENDIF}

   temp := TrimRight(TrimLeft(S));

   i := pos('DX de', temp);
   if i > 1 then begin
      Delete(temp, 1, i);
   end;

   if pos('DX de', temp) = 1 then begin
      //0000000001111111111222222222233333333334444444444555555555566666666667
      //1234567890123456789012345678901234567890123456789012345678901234567890
      //DX de W1NT-6-#:  14045.0  V3MIWTJ      CW 16 dB 21 WPM CQ             1208Z
      //DX de W3LPL-#:   14010.6  SM5DYC       CW 14 dB 22 WPM CQ             1208Z
      i := pos(':', temp);
      if i > 0 then begin
         temp2 := copy(temp, 7, i - 7);
         ReportedBy := temp2;
      end
      else begin
         exit;
      end;

      Delete(temp, 1, i);
      temp := TrimLeft(temp);

      // Freq.
      i := pos(' ', temp);
      if i > 0 then begin
         temp2 := copy(temp, 1, i - 1);
      end
      else begin
         exit;
      end;

      try
         FreqHz := Round(StrToFloat(temp2)*1000);
      except
         on EConvertError do
            exit;
      end;

      b := dmZLogGlobal.BandPlan.FreqToBand(FreqHz);
      if b = bUnknown then begin
         Exit;
      end;

      Band := b;

      Delete(temp, 1, i);
      temp := TrimLeft(temp);

      // Callsign
      i := pos(' ', temp);
      if i > 0 then begin
         Call := copy(temp, 1, i - 1);
      end
      else begin
         exit;
      end;

      Delete(temp, 1, i);

      // CQ/DE
      // Callsignの後ろに'CQ 'の文字があればCQとみなす
      i := Pos('CQ ', temp);
      if i > 0 then begin
         CQ := True;
      end;

      // 後ろから見て、時間を取得
      for i := length(temp) downto 1 do begin
         if temp[i] = ' ' then begin
            break;
         end;
      end;

      TimeStr := copy(temp, i + 1, 5);

      // 時間を削除した残りはコメントとする
      Delete(temp, i, 255);
      Comment := temp;

      Result := True;
   end
   else begin    // check for SH/DX responses
      i := length(temp);
      if i = 0 then begin
         exit;
      end;

      if temp[i] = '>' then begin
         i := pos(' <', temp);
         if i > 0 then begin
            ReportedBy := copy(temp, i+2, 255);
            ReportedBy := copy(ReportedBy, 1, length(ReportedBy)-1);
         end
         else begin
            exit;
         end;

         Delete(temp, i, 255);
      end
      else begin
         exit;
      end;

      i := pos(' ', temp);
      if i > 0 then begin
         temp2 := copy(temp, 1, i - 1);
      end
      else begin
         exit;
      end;

      try
         FreqHz := Round(StrToFloat(temp2) * 1000);
      except
         on EConvertError do
            exit;
      end;

      b := dmZLogGlobal.BandPlan.FreqToBand(FreqHz);
      if b = bUnknown then begin
         Exit;
      end;

      Band := b;

      Delete(temp, 1, i);
      temp := TrimLeft(temp);
      i := pos(' ', temp);
      if i > 0 then begin
         Call := copy(temp, 1, i - 1);
      end
      else begin
         exit;
      end;

      Delete(temp, 1, i);
      temp := TrimLeft(temp);
      i := pos(' ', temp);
      if i > 0 then begin
         Delete(temp, 1, i);
      end
      else begin
         exit;
      end;

      temp := TrimLeft(temp);
      if pos('Z', temp) = 5 then begin
         TimeStr := copy(temp, 1, 5);
         Delete(temp, 1, 6);
         Comment := temp;
      end
      else begin
         exit;
      end;

      Result := True;
   end;
end;

Function TBaseSpot.FreqKHzStr : string;
begin
   Result := kHzStr(FreqHz);
end;

Function TSpot.ClusterSummary : string;
begin
   Result := FillLeft(FreqKHzStr, 8) +  ' ' +
             FillRight(FCall, 11) + ' ' + FTimeStr + ' ' +
             FillLeft(FComment, 30) + '<'+ FReportedBy + '>';
end;

function TSpot.InText : string;
begin
   Result := '';
end;

procedure TSpot.FromText(S : string);
begin
   //
end;

procedure TSpot.Assign(O: TBaseSpot);
begin
   Inherited Assign(O);
   FReportedBy := TSpot(O).FReportedBy;
   FTimeStr := TSpot(O).FTimeStr;
   FComment := TSpot(O).FComment;
end;

Function TBaseSpot.NewMulti : boolean;
begin
   Result := NewCty or NewZone or NewJaMulti;
end;

procedure TBaseSpot.Assign(O: TBaseSpot);
begin
   FTime := O.FTime;
   FCall := O.FCall;
   FNumber := O.FNumber;
   FFreqHz := O.FFreqHz;
   FCtyIndex := O.FCtyIndex;
   FZone := O.FZone;
   FNewCty := O.FNewCty;
   FNewZone := O.FNewZone;;
   FWorked := O.FWorked;
   FBand := O.FBand;;
   FMode := O.FMode;;
   FSpotSource := O.FSpotSource;
   FSpotGroup := O.FSpotGroup;
   FCQ := O.FCQ;
   FNewJaMulti := O.FNewJaMulti;
   FReportedBy := O.ReportedBy;
end;

function TBSData.InText : string;
(*  Call : string;
    FreqHz : LongInt;
    CtyIndex : integer;
    Zone : integer;
    NewCty : boolean;
    NewZone : boolean;
    Worked : boolean;
    Band : TBand;
    Mode : TMode;
    Time : TDateTime;
    LabelRect : TRect;  *)
var
   SL: TStringList;
begin
   SL := TStringList.Create();
   SL.Delimiter := '%';
   SL.StrictDelimiter := True;
   try
      SL.Add(Call);
      SL.Add(IntToStr(FreqHz));
      SL.Add(IntToStr(Ord(Band)));
      SL.Add(IntToStr(Ord(Mode)));
      SL.Add(FloatToStr(Time));
      SL.Add(ZBoolToStr(CQ));
      SL.Add(Number);
      Result := SL.DelimitedText;
   finally
      SL.Free();
   end;
end;

procedure TBSData.FromText(S : string);
var
   SL: TStringList;
begin
   SL := TStringList.Create();
   SL.Delimiter := '%';
   SL.StrictDelimiter := True;
   try
      SL.DelimitedText := S + '%%%%%%%';
      Call := SL[0];
      FreqHz := StrToIntDef(SL[1], 0);
      Band := TBand(StrToIntDef(SL[2], Integer(b19)));
      Mode := TMode(StrToIntDef(SL[3], Integer(mCW)));
      Time := StrToFloatDef(SL[4], 0);
      CQ := ZStrToBool(SL[5]);
      Number := SL[6];
   finally
      SL.Free();
   end;
end;

procedure TBSData.Assign(O: TBaseSpot);
begin
   Inherited Assign(O);
   FBold := TBSData(O).FBold;
end;

constructor TSpotList.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
end;

constructor TBSList.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
end;

procedure SpotCheckWorked(Sp: TBaseSpot);
var
   multi: string;
   SD, SD2: TSuperData;
   Q: TQSO;
begin
   // 交信済みか確認する
   Sp.Worked := Log.IsWorked(Sp.Call, Sp.Band);

   // NR未入力の場合
   if Sp.Number = '' then begin
      // 他のバンドで交信済みならマルチを取得
      if Log.IsOtherBandWorked(Sp.Call, Sp.Band, multi) = True then begin
         Sp.Number := multi;
      end
      else begin
         // 他のバンドで未交信ならSPCデータよりマルチを取得
         SD := TSuperData.Create();
         Sd.Callsign := Sp.Call;
         SD2 := MainForm.SuperCheckList.ObjectOf(SD);
         if SD2 <> nil then begin
            Sp.Number := SD2.Number;
         end;
         SD.Free();
      end;
   end;

   // そのマルチはSp.BandでNEW MULTIか
   if Sp.Number <> '' then begin
      Q := TQSO.Create();
      try
         Q.Callsign := Sp.Call;
         Q.Band := Sp.Band;
         Q.Mode := Sp.Mode;
         Q.NrRcvd := Sp.Number;
         multi := MyContest.MultiForm.ExtractMulti(Q);
         Sp.NewJaMulti := Log.IsNewMulti(Sp.Band, multi);
      finally
         Q.Free();
      end;
   end;
end;

end.
