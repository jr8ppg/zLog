unit HamlogIf;

interface

uses
  System.SysUtils, System.Classes, StrUtils, IniFiles, Forms, Windows, Menus,
  System.DateUtils, Generics.Collections, Generics.Defaults, System.AnsiStrings,
  Hamlog50;

type
  THamlogQso = class(TObject)
	 FCallsign: string;
	 FDate: string;
	 FTime: string;
	 FCode: string;
	 FGrid: string;
	 FQsl: string;
	 FFlag1: WORD;
    FHisRst: string;
    FMyRst: string;
    FFreq: string;
    FMode: string;
    FName: string;
    FQth: string;
    FRmk1: string;
    FRmk2: string;
    function GetDateTime(): TDateTime;
    procedure SetDateTime(v: TDateTime);
    function GetBand(): Integer;
    function GetIsUTC(): Boolean;
  public
    constructor Create(); overload;
    constructor Create(pbuff: pTQsoBuff); overload;
    procedure Parse(pbuff: pTQsoBuff);
    property Callsign: string read FCallsign write FCallsign;
    property Date: string read FDate write FDate;
    property Time: string read FTime write FTime;
    property Code: string read FCode write FCode;
    property Grid: string read FGrid write FGrid;
    property Qsl: string read FQsl write FQsl;
    property Flag1: WORD read FFlag1 write FFlag1;
    property HisRst: string read FHisRst write FHisRst;
    property MyRst: string read FMyRst write FMyRst;
    property Freq: string read FFreq write FFreq;
    property Mode: string read FMode write FMode;
    property Name: string read FName write FName;
    property Qth: string read FQth write FQth;
    property Rmk1: string read FRmk1 write FRmk1;
    property Rmk2: string read FRmk2 write FRmk2;

    property DateTime: TDateTime read GetDateTime write SetDateTime;
    property Band: Integer read GetBand;
    property IsUTC: Boolean read GetIsUTC;
  end;

  THamlogDataProgress = procedure(Sender: TObject; progress: Integer);

  THamlogData = class(TObjectList<THamlogQso>)
  private
    FTh: TThLog;
    FLastError: Long;
    FOnProgress: THamlogDataProgress;
    function GetRecordCount(): Longint;
  public
    constructor Create(OwnsObjects: Boolean = True);
    destructor Destroy(); override;
    function Open(filename: string): Boolean;
    procedure Close();
    function FindFirst(callsign: string): Boolean;
    function FindNext(): Boolean;
    function Top(): THamlogQso;
    function Bottom(): THamlogQso;
    function Next(): THamlogQso;
    function Read(rno: Longint): THamlogQso;
    function LoadAll(): Boolean;
    property RecordCount: Longint read GetRecordCount;
  end;

  TQSODateAscComparer = class(TComparer<THamlogQso>)
  public
    function Compare(const Left, Right: THamlogQso): Integer; override;
  end;

  TQSODateDescComparer = class(TComparer<THamlogQso>)
  public
    function Compare(const Left, Right: THamlogQso): Integer; override;
  end;

  THamlogQsoList = class(TObjectList<THamlogQso>)
  private
    FDateAscComparer: TQSODateAscComparer;
    FDateDescComparer: TQSODateDescComparer;
  public
    constructor Create(OwnsObjects: Boolean = True);
    destructor Destroy(); override;
    procedure SortByDate(fAsc: Boolean);
  end;

implementation

{ THamlogQso }

constructor THamlogQso.Create();
begin
   Inherited;
   FCallsign := '';
   FDate := '';
	FTime := '';
	FCode := '';
	FGrid := '';
	FQsl := '';
	FFlag1 := 0;
   FHisRst := '';
   FMyRst := '';
   FFreq := '';
   FMode := '';
   FName := '';
   FQth := '';
   FRmk1 := '';
   FRmk2 := '';
end;

constructor THamlogQso.Create(pbuff: pTQsoBuff);
begin
   Inherited Create();
   Parse(pbuff);
end;

procedure THamlogQso.Parse(pbuff: pTQsoBuff);

   function AnsiStrToStr(P: PAnsiChar; L: Integer): string;
   var
      temp: array[0..200] of AnsiChar;
   begin
      ZeroMemory(@temp, SizeOf(temp));
      System.AnsiStrings.StrLCopy(PAnsiChar(@temp), P, L);
      Result := string(System.AnsiStrings.StrPas(PAnsiChar(@temp)));
   end;
begin
   FCallsign   := AnsiStrToStr(pbuff^.Calls, 20);
   FDate       := AnsiStrToStr(pbuff^.Date, 8);
	FTime       := AnsiStrToStr(pbuff^.Time, 6);
	FCode       := AnsiStrToStr(pbuff^.Code, 6);
	FGrid       := AnsiStrToStr(pbuff^.Glid, 6);
	FQsl        := AnsiStrToStr(pbuff^.Qsl, 3);
	FFlag1      := pbuff^.Flag1;
   FHisRst     := AnsiStrToStr(pBuff^.Hiss, pBuff^.HissLen);
   FMyRst      := AnsiStrToStr(pbuff^.Myrs, pbuff^.MyrsLen);
   FFreq       := AnsiStrToStr(pbuff^.Freq, pbuff^.FreqLen);
   FMode       := AnsiStrToStr(pbuff^.Mode, pbuff^.ModeLen);
   FName       := AnsiStrToStr(pbuff^._Name, pbuff^.NameLen);
   FQth        := AnsiStrToStr(pbuff^.Qth, pbuff^.QthLen);
   FRmk1       := AnsiStrToStr(pbuff^.Rmk1, pbuff^.Rmk1Len);
   FRmk2       := AnsiStrToStr(pbuff^.Rmk2, pbuff^.Rmk2Len);
end;

function THamlogQso.GetDateTime(): TDateTime;
var
   yy, mm, dd: Integer;
   h, m: Integer;
begin
   // YY/MM/DD
   yy := StrToIntDef(Copy(FDate, 1, 2), 0);
   if yy >= 70 then begin
      yy := yy + 1900;
   end
   else begin
      yy := yy + 2000;
   end;

   mm := StrToIntDef(Copy(FDate, 4, 2), 0);
   dd := StrToIntDef(Copy(FDate, 7, 2), 0);

   // HH:MMJ
   h := StrToIntDef(Copy(FTime, 1, 2), 0);
   m := StrToIntDef(Copy(FTime, 4, 2), 0);

   Result := EncodeDateTime(yy, mm, dd, h, m, 0, 0);

   if IsUTC = True then begin
      Result := IncHour(Result, 9);
   end;
end;

procedure THamlogQso.SetDateTime(v: TDateTime);
begin
   FDate := FormatDateTime('yy/mm/dd', v);
   FTime := FormatDateTime('hh:nn', v) + 'J';
end;

function THamlogQso.GetBand(): Integer;
begin
   Result := FreqPCheck(PAnsiChar(AnsiString(FFreq)));
end;

function THamlogQso.GetIsUTC(): Boolean;
begin
   Result := (Copy(FTime, 6, 1) = 'Z');
end;

{ THamlogData }

constructor THamlogData.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
end;

destructor THamlogData.Destroy();
begin
   Inherited;
end;

function THamlogData.Open(filename: string): Boolean;
var
   fname: AnsiString;
begin
   fname := AnsiString(filename);
   FLastError := HamlogOpen(nil, FTh, PAnsiChar(fname), 0);
   if FLastError = SUCCESS then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure THamlogData.Close();
begin
   FLastError := SUCCESS;
   if FTh.ldbf.fHandle = 0 then begin
      Exit;
   end;
   HamlogClose(FTh, 0);
end;

function THamlogData.FindFirst(callsign: string): Boolean;
var
   Q: THamlogQso;
   call: AnsiString;
begin
   if FTh.ldbf.fHandle = 0 then begin
      Result := False;
      FLastError := NOPEN;
      Exit;
   end;

   call := AnsiString(callsign);
   FLastError := THW_seek(FTh, PAnsiChar(call), DbsCallDX or DUP__CHECK);
   if FLastError <> SUCCESS then begin
      Result := False;
      Exit;
   end;

   Q := THamlogQso.Create(@FTh.Qso);
   Add(Q);

   Result := True;
end;

function THamlogData.FindNext(): Boolean;
var
   Q: THamlogQso;
begin
   if FTh.ldbf.fHandle = 0 then begin
      Result := False;
      FLastError := NOPEN;
      Exit;
   end;

   FLastError := THW_skip(FTh, 1, DbsCallDX or DUP__CHECK);
   if FLastError <> SUCCESS then begin
      Result := False;
      Exit;
   end;

   Q := THamlogQso.Create(@FTh.Qso);
   Add(Q);

   Result := True;
end;

function THamlogData.Top(): THamlogQso;
var
   Q: THamlogQso;
begin
   if FTh.ldbf.fHandle = 0 then begin
      Result := nil;
      FLastError := NOPEN;
      Exit;
   end;

   FLastError := THW_top(FTh, DbsNoNDX);
   if FLastError <> SUCCESS then begin
      Result := nil;
      Exit;
   end;

   Q := THamlogQso.Create(@FTh.Qso);

   Result := Q;
end;

function THamlogData.Bottom(): THamlogQso;
var
   Q: THamlogQso;
begin
   if FTh.ldbf.fHandle = 0 then begin
      Result := nil;
      FLastError := NOPEN;
      Exit;
   end;

   FLastError := THW_btm(FTh, DbsNoNDX);
   if FLastError <> SUCCESS then begin
      Result := nil;
      Exit;
   end;

   Q := THamlogQso.Create(@FTh.Qso);

   Result := Q;
end;

function THamlogData.Next(): THamlogQso;
var
   Q: THamlogQso;
begin
   if FTh.ldbf.fHandle = 0 then begin
      Result := nil;
      FLastError := NOPEN;
      Exit;
   end;

   FLastError := THW_skip(FTh, 1, DbsNoNDX);
   if FLastError <> SUCCESS then begin
      Result := nil;
      Exit;
   end;

   Q := THamlogQso.Create(@FTh.Qso);

   Result := Q;
end;

function THamlogData.Read(rno: Longint): THamlogQso;
var
   Q: THamlogQso;
begin
   if FTh.ldbf.fHandle = 0 then begin
      Result := nil;
      FLastError := NOPEN;
      Exit;
   end;

   FLastError := THW_Read(FTh, rno, 0);
   if FLastError <> SUCCESS then begin
      Result := nil;
      Exit;
   end;

   Q := THamlogQso.Create(@FTh.Qso);

   Result := Q;
end;

function THamlogData.LoadAll(): Boolean;
var
   Q: THamlogQso;
   c: Integer;
   progress: Integer;
begin
   Clear();

   Q := Top();
   if Q = nil then begin
      Result := False;
      Exit;
   end;

   Add(Q);
   c := 1;

   while True do begin
      if RecordCount = 0 then begin
         progress := 0;
      end
      else begin
         progress := Round(c / RecordCount);
      end;

      if Assigned(FOnProgress) then begin
         FOnProgress(Self, progress);
      end;

      Q := Next();
      if Q = nil then begin
         Result := False;
         Break;
      end;

      Add(Q);
      Inc(c);
   end;

   Result := True;
end;

function THamlogData.GetRecordCount(): Longint;
begin
   Result := FTh.ldbf.rcount;
end;

{ TQSODateAscComparer }

function TQSODateAscComparer.Compare(const Left, Right: THamlogQso): Integer;
begin
   Result := CompareText(Left.Date + Left.Time, Right.Date + Right.Time);
end;

{ TQSODateDescComparer }

function TQSODateDescComparer.Compare(const Left, Right: THamlogQso): Integer;
begin
   Result := CompareText(Left.Date + Left.Time, Right.Date + Right.Time) * -1;
end;

{ THamlogQsoList }

constructor THamlogQsoList.Create(OwnsObjects: Boolean = True);
begin
   Inherited;
   FDateAscComparer := TQSODateAscComparer.Create();
   FDateDescComparer := TQSODateDescComparer.Create();
end;

destructor THamlogQsoList.Destroy();
begin
   FDateAscComparer.Free();
   FDateDescComparer.Free();
end;

procedure THamlogQsoList.SortByDate(fAsc: Boolean);
begin
   if fAsc = True then begin
      Self.Sort(FDateAscComparer);
   end
   else begin
      Self.Sort(FDateDescComparer);
   end;
end;

end.
