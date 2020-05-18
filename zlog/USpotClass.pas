unit USpotClass;

interface

uses SysUtils, Windows, Classes, UzLogConst, UzLogGlobal, UzLogQSO;

type
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
    ClusterData : boolean; // true if data from PacketCluster
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

var
  BSList2 : TList;

implementation

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
   ClusterData := False;
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

   temp := TrimRight(TrimLeft(S));

   i := pos('DX de', temp);
   if i > 1 then begin
      Delete(temp, 1, i);
   end;

   if pos('DX de', temp) = 1 then begin
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

      i := pos(' ', temp);
      if i > 0 then begin
         Call := copy(temp, 1, i - 1);
      end
      else begin
         exit;
      end;

      Delete(temp, 1, i);

      for i := length(temp) downto 1 do begin
         if temp[i] = ' ' then begin
            break;
         end;
      end;

      TimeStr := copy(temp, i + 1, 5);

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
   Result := NewCty or NewZone;
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
   S : string;
const
   xx = '%';
begin
   S := Call + xx + IntToStr(FreqHz) + xx + IntToStr(Ord(Band)) + xx + IntToStr(Ord(Mode)) + xx + FloatToStr(Time);
   Result := S;
end;

procedure TBSData.FromText(S : string);
var
   str, wstr : string;
   p : integer;
begin
   str := S;

   p := pos('%', str);
   wstr := copy(str, 1, p-1);
   Call := wstr;
   Delete(str, 1, p);

   p := pos('%', str);
   wstr := copy(str, 1, p-1);
   FreqHz := StrToIntDef(wstr, 0);
   Delete(str, 1, p);

   p := pos('%', str);
   wstr := copy(str, 1, p-1);
   Band := TBand(StrToIntDef(wstr, Integer(b19)));
   Delete(str, 1, p);

   p := pos('%', str);
   wstr := copy(str, 1, p-1);
   Mode := TMode(StrToIntDef(wstr, Integer(mCW)));

   wstr := str;
   try
      Time := StrToFloat(wstr);
   except
   end;
end;

procedure FreeBSList();
var
   i: Integer;
begin
   for i := 0 to BSList2.Count - 1 do begin
      TSpot(BSList2[i]).Free();
   end;
   BSList2.Free();
end;

initialization
   BSList2 := TList.Create;

finalization
   FreeBSList();

end.
