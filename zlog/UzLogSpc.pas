unit UzLogSpc;

{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, System.Math, Generics.Collections, Generics.Defaults,
  System.Character,
  UzLogConst, UzLogGlobal, UzLogQSO;

type
  TSuperData = class(TObject)
  private
    FDate: TDateTime;
    FCallsign : string;
    FNumber : string;
    function GetText(): string;
  public
    constructor Create(); overload;
    constructor Create(D: TDateTime; C, N: string); overload;
    property Date: TDateTime read FDate write FDate;
    property Callsign: string read FCallsign write FCallsign;
    property Number: string read FNumber write FNumber;
    property Text: string read GetText;
  end;

  TSuperListComparer1 = class(TComparer<TSuperData>)
  public
    function Compare(const Left, Right: TSuperData): Integer; override;
  end;

  TSuperList = class(TObjectList<TSuperData>)
  private
    FCallsignComparer: TSuperListComparer1;
  public
    constructor Create(OwnsObjects: Boolean = True);
    destructor Destroy(); override;
    function IndexOf(SD: TSuperData): Integer;
    function ObjectOf(SD: TSuperData): TSuperData;
    procedure SortByCallsign();
    procedure AddData(D: TDateTime; C, N: string);
    procedure SaveToFile(filename: string);
  end;
  PTSuperList = ^TSuperList;

  TSuperListTwoLetterMatrix = array[0..255, 0..255] of TSuperList;
  PTSuperListTwoLetterMatrix = ^TSuperListTwoLetterMatrix;

  TSuperCheckNPlusOneThread = class(TThread)
    procedure Execute(); override;
  private
    FSuperList: TSuperList;
    FListBox: TListBox;
    FPartialStr: string;
  public
    constructor Create(ASuperList: TSuperList; AListBox: TListBox; APartialStr: string);
    property SuperList: TSuperList read FSuperList write FSuperList;
    property ListBox: TListBox read FListBox write FListBox;
    property PartialStr: string read FPartialStr write FPartialStr;
  end;

  TSuperCheckDataLoadThread = class(TThread)
    procedure Execute(); override;
  private
    FSuperList: TSuperList;
    FPSuperListTwoLetterMatrix: PTSuperListTwoLetterMatrix;
    procedure LoadSpcFiles(strStartFoler: string);
    procedure LoadSpcFile(strStartFoler: string; strFileName: string);
    procedure LoadLogFiles(strStartFoler: string);
    procedure ListToTwoMatrix(L: TQSOList);
    procedure SetTwoMatrix(D: TDateTime; C, N: string);
    function IsAsciiStr(str: string): Boolean;
  public
    constructor Create(ASuperList: TSuperList; APSuperListTwoLetterMatrix: PTSuperListTwoLetterMatrix);
    property SuperList: TSuperList read FSuperList write FSuperList;
  end;

  TSuperResult = class(TObject)
     FPartialStr: string;
     FEditDistance: Integer;
     FScore: Extended;
  public
    constructor Create(); overload;
    constructor Create(str: string; editdistance: Integer; score: Extended); overload;
    property PartialStr: string read FPartialStr write FPartialStr;
    property EditDistance: Integer read FEditDistance write FEditDistance;
    property Score: Extended read FScore write FScore;
  end;

  TSuperResultComparer1 = class(TComparer<TSuperResult>)
  public
    function Compare(const Left, Right: TSuperResult): Integer; override;
  end;

  TSuperResultList = class(TObjectList<TSuperResult>)
  private
    FScoreComparer: TSuperResultComparer1;
  public
    constructor Create(OwnsObjects: Boolean = True);
    destructor Destroy(); override;
    procedure SortByScore();
  end;

const
  SPC_LOADING_TEXT = 'Loading...';

implementation

uses
  Main;

{ TSuperData }

constructor TSuperData.Create();
begin
   Inherited;
   FDate := 0;
   FCallsign := '';
   FNumber := '';
end;

constructor TSuperData.Create(D: TDateTime; C, N: string);
begin
   Inherited Create();
   FDate := D;
   FCallsign := C;
   FNumber := N;
end;

function TSuperData.GetText(): string;
begin
   Result := FillRight(callsign, 11) + number;
end;

{ TSuperList }

constructor TSuperList.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
   FCallsignComparer := TSuperListComparer1.Create();
end;

destructor TSuperList.Destroy();
begin
   Inherited;
   FCallsignComparer.Free();
end;

function TSuperList.IndexOf(SD: TSuperData): Integer;
var
   Index: Integer;
//   i: Integer;
begin
{
   for i := 0 to Count - 1 do begin
      if SD.Callsign = Items[i].Callsign then begin
         Result := i;
         Exit;
      end;
   end;
   Result := -1;
}
   if BinarySearch(SD, Index, FCallsignComparer) = True then begin
      Result := Index;
   end
   else begin
      Result := -1;
   end;
end;

function TSuperList.ObjectOf(SD: TSuperData): TSuperData;
var
   Index: Integer;
//   i: Integer;
begin
{
   for i := 0 to Count - 1 do begin
      if SD.Callsign = Items[i].Callsign then begin
         Result := Items[i];
         Exit;
      end;
   end;
   Result := nil;
}

   if BinarySearch(SD, Index, FCallsignComparer) = True then begin
      Result := Items[Index];
   end
   else begin
      Result := nil;
   end;
end;

procedure TSuperList.SortByCallsign();
begin
   Sort(FCallsignComparer);
end;

procedure TSuperList.AddData(D: TDateTime; C, N: string);
var
   O: TSuperData;
   SD: TSuperData;
   Index: Integer;
begin
   SD := TSuperData.Create(D, C, N);
   if BinarySearch(SD, Index, FCallsignComparer) = True then begin
      O := Items[Index];
      if O.Date < SD.Date then begin
         O.Date := SD.Date;
         O.Number := SD.Number;
      end;
      SD.Free();
   end
   else begin
      Insert(Index, SD);
   end;
end;

procedure TSuperList.SaveToFile(filename: string);
var
   F: TextFile;
   i: Integer;
begin
   AssignFile(F, filename);
   ReWrite(F);

   for i := 0 to Count - 1 do begin
      WriteLn(F, items[i].Callsign);
   end;

   CloseFile(F);
end;

{ TSuperListComparer1 }

function TSuperListComparer1.Compare(const Left, Right: TSuperData): Integer;
begin
   Result := CompareText(Left.Callsign, Right.Callsign);
end;

{ TSuperCheckNPlusOneThread }

constructor TSuperCheckNPlusOneThread.Create(ASuperList: TSuperList; AListBox: TListBox; APartialStr: string);
begin
   FSuperList := ASuperList;
   FListBox := AListBox;
   FPartialStr := APartialStr;
   Inherited Create();
end;

procedure TSuperCheckNPlusOneThread.Execute();
var
   i: Integer;
   sd: TSuperData;
   maxhit: Integer;
   n: Integer;
   score: Extended;
   L: TSuperResultList;
   R: TSuperResult;
begin
   L := TSuperResultList.Create();
   try
      ListBox.Items.Clear();
      maxhit := dmZlogGlobal.Settings._maxsuperhit;
      for i := 0 to FSuperList.Count - 1 do begin
         if Terminated = True then begin
            Break;
         end;

         sd := TSuperData(FSuperList[i]);

         // レーベンシュタイン距離を求める
         n := LD_dp(sd.Callsign, FPartialStr);

         // レーベンシュタイン距離から類似度を算出
         score := n / Max(Length(sd.Callsign), Length(FPartialStr));

         // 0なら一致
         // 0.1667 １文字不一致
         // 0.3333 ２文字不一致
         // 0.5000 ３文字不一致
         if score < 0.3 then begin
            R := TSuperResult.Create(sd.Callsign, n, score);
            L.Add(R);
         end;
      end;

      // スコア順に並び替え
      L.SortByScore();

      for i := 0 to Min(l.Count - 1, maxhit) do begin
         if L[i].EditDistance = 0 then begin
            ListBox.Items.Add('*' + L[i].PartialStr);
         end
         else begin
            ListBox.Items.Add(L[i].PartialStr);
         end;
      end;
   finally
      L.Free();
   end;
end;

{ TSuperCheckDataLoadThread }

constructor TSuperCheckDataLoadThread.Create(ASuperList: TSuperList; APSuperListTwoLetterMatrix: PTSuperListTwoLetterMatrix);
begin
   FSuperList := ASuperList;
   FPSuperListTwoLetterMatrix := APSuperListTwoLetterMatrix;
   Inherited Create();
end;

procedure TSuperCheckDataLoadThread.Execute();
var
   strFolder: string;
   //x, y: Integer;
   {$IFDEF DEBUG}
   dwTick: DWORD;
   {$ENDIF}
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- BEGIN TSuperCheckDataLoadThread ---'));
   dwTick := GetTickCount();
   {$ENDIF}
   try

      strFolder := dmZlogGlobal.Settings.FSuperCheck.FSuperCheckFolder;

      case dmZlogGlobal.Settings.FSuperCheck.FSuperCheckMethod of
         // SPC
         0: begin
            LoadSpcFiles(strFolder);
            LoadSpcFile(strFolder, 'MASTER.SCP');
         end;

         // ZLO
         1: begin
            LoadLogFiles(strFolder);
         end

         // Both
         else begin
            LoadSpcFiles(strFolder);
            LoadSpcFile(strFolder, 'MASTER.SCP');
            LoadLogFiles(strFolder);
         end;
      end;

      //FSuperList.SaveToFile('superlist.txt');
   finally
      {$IFDEF DEBUG}
      OutputDebugString(PChar('--- END TSuperCheckDataLoadThread --- time=' + IntToStr(GetTickCount() - dwTick) + 'ms'));
      {$ENDIF}
      PostMessage(MainForm.Handle, WM_ZLOG_SPCDATALOADED, 0, 0);
   end;
end;

procedure TSuperCheckDataLoadThread.LoadSpcFiles(strStartFoler: string);
var
   ret: Integer;
   F: TSearchRec;
   S: string;
   slFiles: TStringList;
   i: Integer;
begin
   slFiles := TStringList.Create();
   try
      if strStartFoler = '' then begin
         strStartFoler := ExtractFilePath(Application.ExeName);
      end;

      S := IncludeTrailingPathDelimiter(strStartFoler);

      // *.SPCのファイルリスト作成
      ret := FindFirst(S + '*.SPC', faAnyFile, F);
      while ret = 0 do begin
         if Terminated = True then begin
            Break;
         end;

         if ((F.Attr and faDirectory) = 0) and
            ((F.Attr and faVolumeID) = 0) and
            ((F.Attr and faSysFile) = 0) then begin
            slFiles.Add(F.Name);
         end;

         // 次のファイル
         ret := FindNext(F);
      end;

      FindClose(F);

      // ソートして
      slFiles.Sort();

      // 各ファイルの内容をロードする
      for i := 0 to slFiles.Count - 1 do begin
         LoadSpcFile(strStartFoler, slFiles[i]);
      end;

   finally
      slFiles.Free();
   end;
end;

procedure TSuperCheckDataLoadThread.LoadSpcFile(strStartFoler: string; strFileName: string);
var
   F: TextFile;
   filename: string;
   C, N: string;
   i: Integer;
   str: string;
   dtNow: TDateTime;
   {$IFDEF DEBUG}
   dwTick: DWORD;
   {$ENDIF}
begin
   // 指定フォルダ優先
   filename := IncludeTrailingPathDelimiter(strStartFoler) + strFileName;
   if (strStartFoler = '') or (FileExists(filename) = False) then begin
      // 無ければZLOG.EXEを同じ場所（従来通り）
      filename := ExtractFilePath(Application.EXEName) + strFileName;
      if FileExists(filename) = False then begin
         Exit;
      end;
   end;

   {$IFDEF DEBUG}
   dwTick := GetTickCount();
   {$ENDIF}

   dtNow := Now;

   AssignFile(F, filename);
   Reset(F);

   while not(EOF(F)) do begin
      if Terminated = True then begin
         Break;
      end;

      // 1行読み込み
      ReadLn(F, str);

      // 空行除く
      if str = '' then begin
         Continue;
      end;

      // 先頭;はコメント行
      if (str[1] = ';') or (str[1] = '#') then begin
         Continue;
      end;

      // spaceでコールとナンバーの分割
      i := Pos(' ', str);
      if i = 0 then begin
         C := str;
         N := '';
      end
      else begin
         C := copy(str, 1, i - 1);
         N := TrimLeft(copy(str, i, 30));
      end;

      // CALLSIGNが全てAsciiか検査
      if IsAsciiStr(C) = False then begin
         Continue;
      end;

      SetTwoMatrix(dtNow, C, N);
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('[' + filename + '] loading time = ' + IntToStr(GetTickCount() - dwTick)));
   {$ENDIF}

   CloseFile(F);
end;

procedure TSuperCheckDataLoadThread.LoadLogFiles(strStartFoler: string);
var
   ret: Integer;
   F: TSearchRec;
   S: string;
   L: TQSOList;
   ext: string;
begin
   if strStartFoler = '' then begin
      Exit;
   end;

   L := TQSOList.Create();
   try
      S := IncludeTrailingPathDelimiter(strStartFoler);

      ret := FindFirst(S + '*.ZLO?', faAnyFile, F);
      while ret = 0 do begin
         if Terminated = True then begin
            Break;
         end;

         ext := ExtractFileExt(UpperCase(F.Name));

         if ((F.Attr and faDirectory) = 0) and
            ((F.Attr and faVolumeID) = 0) and
            ((F.Attr and faSysFile) = 0) and
            ((ext = '.ZLO') or (ext = '.ZLOX')) then begin

            L.Clear();

            // listにロードする
            L.MergeFile(S + F.Name, False);

            {$IFDEF DEBUG}
            OutputDebugString(PChar(F.Name + ' L=' + IntToStr(L.Count)));
            {$ENDIF}

            // TwoMatrixに展開
            ListToTwoMatrix(L);
         end;

         // 次のファイル
         ret := FindNext(F);
      end;

      FindClose(F);
   finally
      L.Free();
   end;
end;

procedure TSuperCheckDataLoadThread.ListToTwoMatrix(L: TQSOList);
var
   i: Integer;
   Q: TQSO;
begin
   for i := 1 to L.Count - 1 do begin
      if Terminated = True then begin
         Break;
      end;

      Q := L[i];
      SetTwoMatrix(Q.Time, Q.Callsign, Q.NrRcvd);
   end;
end;

procedure TSuperCheckDataLoadThread.SetTwoMatrix(D: TDateTime; C, N: string);
var
   i: Integer;
   x: Integer;
   y: Integer;
begin
   // リストに追加
   FSuperList.AddData(D, C, N);

   // TwoLetterリストに追加
   for i := 1 to Length(C) - 1 do begin
      if Terminated = True then begin
         Break;
      end;

      x := Ord(C[i]);
      y := Ord(C[i + 1]);

      FPSuperListTwoLetterMatrix^[x, y].AddData(D, C, N);
   end;
end;

function TSuperCheckDataLoadThread.IsAsciiStr(str: string): Boolean;
var
   i: Integer;
   ch: Char;
begin
   for i := 1 to Length(str) do begin
      ch := str[i];
      if (Ord(ch) > $7F) then begin
         Result := False;
         Exit;
      end;
   end;

   Result := True;
end;

constructor TSuperResult.Create();
begin
   Inherited;
   FPartialStr := '';
   FEditDistance := 0;
   FScore := 0;
end;

constructor TSuperResult.Create(str: string; editdistance: Integer; score: Extended);
begin
   Inherited Create();
   FPartialStr := str;
   FEditDistance := editdistance;
   FScore := score;
end;

function TSuperResultComparer1.Compare(const Left, Right: TSuperResult): Integer;
var
   r: Extended;
begin
   r := Left.Score - Right.Score;
   if r < 0 then begin
      Result := -1;
   end
   else if r > 0 then begin
      Result := 1;
   end
   else begin
      Result := 0;
   end;
end;

constructor TSuperResultList.Create(OwnsObjects: Boolean = True);
begin
   Inherited Create(OwnsObjects);
   FScoreComparer := TSuperResultComparer1.Create();
end;

destructor TSuperResultList.Destroy();
begin
   Inherited;
   FScoreComparer.Free();
end;

procedure TSuperResultList.SortByScore();
begin
   Sort(FScoreComparer);
end;

end.
