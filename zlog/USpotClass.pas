unit USpotClass;

interface

uses
  SysUtils, Windows, Classes,
  Generics.Collections, Generics.Defaults,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogSpc;

type
  TSpotSource = ( ssSelf = 0, ssCluster, ssSelfFromZServer, ssClusterFromZServer );

  TBaseSpot = class
    Time : TDateTime; // moved from TBSdata 2.6e
    Call : string;
    Number : string;
    FreqHz : LongInt;
    CtyIndex : integer;
    Zone : integer;
    NewCty : boolean;
    NewZone : boolean;
    Worked : boolean;
    Band : TBand;
    Mode : TMode;
    SpotSource: TSpotSource;
    CQ: Boolean;
    NewJaMulti: Boolean;
    constructor Create; virtual;
    function FreqKHzStr : string;
    function NewMulti : boolean; // newcty or newzone
    function InText : string; virtual; abstract;
    procedure FromText(S : string); virtual; abstract;
  end;

  TSpot = class(TBaseSpot)
    ReportedBy : string;
    TimeStr : string;
    Comment : string;
    constructor Create; override;
    function Analyze(S : string) : boolean; // true if successful
    function ClusterSummary : string;
    function InText : string; override;
    procedure FromText(S : string); override;
  end;

  TBSData = class(TBaseSpot)
    //Time : TDateTime; 2.6e
    LabelRect : TRect;
    Bold : boolean;
    constructor Create; override;
    function LabelStr : string;
    function InText : string; override;
    procedure FromText(S : string); override;
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
   Time := Now;
   Call := '';
   Number := '';
   FreqHz := 0;
   NewCty := false;
   NewZone := false;
   CtyIndex := 0;
   Zone := 0;
   Worked := False;
   Band := b19;
   Mode := mCW;
   SpotSource := ssSelf;
   CQ := False;
   NewJaMulti := False;
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
   LabelRect.Top := 0;
   LabelRect.Right := 0;
   LabelRect.Left := 0;
   LabelRect.Bottom := 0;
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
      Band := TBand(GetBandIndex(FreqHz, 0));

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
      Band := TBand(GetBandIndex(FreqHz, 0));

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
             FillRight(Self.Call, 11) + ' ' + Self.TimeStr + ' ' +
             FillLeft(Self.Comment, 30) + '<'+ Self.ReportedBy + '>';
end;

function TSpot.InText : string;
begin
   Result := '';
end;

procedure TSpot.FromText(S : string);
begin
   //
end;

Function TBaseSpot.NewMulti : boolean;
begin
   Result := NewCty or NewZone or NewJaMulti;
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
      SL.DelimitedText := S + '%%%%%%';
      Call := SL[0];
      FreqHz := StrToIntDef(SL[1], 0);
      Band := TBand(StrToIntDef(SL[2], Integer(b19)));
      Mode := TMode(StrToIntDef(SL[3], Integer(mCW)));
      Time := StrToFloatDef(SL[4], 0);
      CQ := ZStrToBool(SL[5]);
   finally
      SL.Free();
   end;
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
      Sp.NewJaMulti := Log.IsNewMulti(Sp.Band, Sp.Number);
   end;
end;

end.
