unit USuperCheck;

{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin,
  Generics.Collections, Generics.Defaults,
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
  end;

  TSuperCheck = class(TForm)
    Panel1: TPanel;
    Button3: TButton;
    ListBox: TListBox;
    StayOnTop: TCheckBox;
    SpinEdit: TSpinEdit;
    Label1: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ListBoxDblClick(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
    procedure SpinEditChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FSuperCheckList: TSuperList;
    FTwoLetterMatrix: array[0..255, 0..255] of TSuperList; // 2.1f
    function PartialMatch(A, B: string): boolean;
    procedure LoadSpcFile(strStartFoler: string);
    procedure LoadLogFiles(strStartFoler: string);
    procedure ListToTwoMatrix(L: TQSOList);
    procedure SetTwoMatrix(D: TDateTime; C, N: string);
    procedure FreeData();
    function GetFontSize(): Integer;
    procedure SetFontSize(v: Integer);
  public
    { Public declarations }
    HitCall: string;
    HitNumber: integer;
    FirstDataCall: string;
    Rcvd_Estimate: string;
    procedure CheckSuper(aQSO : TQSO);
    procedure Renew();
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

implementation

uses
  Main, UOptions;

{$R *.DFM}

procedure TSuperCheck.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TSuperCheck.FormCreate(Sender: TObject);
var
   i, j: integer;
begin
   Rcvd_Estimate := '';
   FirstDataCall := '';
   FSuperCheckList := nil;
   for i := 0 to 255 do begin
      for j := 0 to 255 do begin
         FTwoLetterMatrix[i, j] := nil;
      end;
   end;

   Renew();
end;

procedure TSuperCheck.FormDestroy(Sender: TObject);
begin
   FreeData();
end;

procedure TSuperCheck.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.LastFocus.SetFocus;
   end;
end;

procedure TSuperCheck.Button3Click(Sender: TObject);
begin
   Close;
end;

function TSuperCheck.PartialMatch(A, B: string): boolean;
var
   i: integer;
begin
   Result := False;
   if (Pos('.', A) = 0) { and (Pos('?',A)=0) } then begin
      Result := (Pos(A, B) > 0);
   end
   else begin
      if length(A) > length(B) then begin
         Exit;
      end;

      for i := 1 to length(A) do begin
         if A[i] <> '.' then begin
            if A[i] <> B[i] then begin
               Exit;
            end;
         end;
      end;

      Result := True;
   end;
end;

procedure TSuperCheck.CheckSuper(aQSO: TQSO);
var
   PartialStr: string;
   i: integer;
   maxhit, hit: integer;
   sd, FirstData: TSuperData;
   L: TSuperList;
begin
   HitNumber := 0;
   HitCall := '';
   ListBox.Items.Clear;
   PartialStr := aQSO.callsign;
   FirstData := nil;

   // 検索対象がserchafter以下 searchafterは0,1,2
   if dmZlogGlobal.Settings._searchafter >= length(PartialStr) then begin
      Exit;
   end;

   // ,で始まるコマンド
   if Pos(',', PartialStr) = 1 then begin
      Exit;
   end;

   // Max super check search デフォルトは1
   maxhit := dmZlogGlobal.Settings._maxsuperhit;

   // 検索対象無し
   if PartialStr = '' then begin
      Exit;
   end;

   ListBox.Enabled := False;
   hit := 0;

   if (length(PartialStr) >= 2) and (Pos('.', PartialStr) = 0) then begin
      L := FTwoLetterMatrix[Ord(PartialStr[1]), Ord(PartialStr[2])];
   end
   else begin
      L := FSuperCheckList;
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('[' + PartialStr + '] L=' + IntToStr(L.Count)));
   {$ENDIF}

   for i := 0 to L.Count - 1 do begin
      sd := TSuperData(L[i]);
      if ListBox.Items.Count = 0 then begin
         FirstData := sd;
      end;

      if PartialMatch(PartialStr, sd.callsign) then begin
         if hit = 0 then begin
            HitCall := sd.callsign;
         end;

         ListBox.Items.Add(sd.Text);

         inc(hit);
         if hit >= maxhit then begin
            break;
         end;
      end;
   end;

   HitNumber := hit;

   FirstDataCall := '';
   Rcvd_Estimate := '';

   if HitNumber > 0 then begin
      FirstDataCall := FirstData.callsign;
      Rcvd_Estimate := FirstData.number;
   end;

   ListBox.Enabled := True;
end;

procedure TSuperCheck.Renew();
var
   i: Integer;
   j: Integer;
   strFolder: string;
begin
   ListBox.Clear();

   FreeData();

   FSuperCheckList := TSuperList.Create(True);

   for i := 0 to 255 do begin // 2.1f
      for j := 0 to 255 do begin
         FTwoLetterMatrix[i, j] := TSuperList.Create(True);
      end;
   end;

   strFolder := dmZlogGlobal.Settings.FSuperCheck.FSuperCheckFolder;

   case dmZlogGlobal.Settings.FSuperCheck.FSuperCheckMethod of
      // SPC
      0: begin
         LoadSpcFile(strFolder);
      end;

      // ZLO
      1: begin
         LoadLogFiles(strFolder);
      end

      // Both
      else begin
         LoadSpcFile(strFolder);
         LoadLogFiles(strFolder);
      end;
   end;
end;

procedure TSuperCheck.FreeData();
var
   i: Integer;
   j: Integer;
begin
   if Assigned(FSuperCheckList) then begin
      FreeAndNil(FSuperCheckList);
   end;

   for i := 0 to 255 do begin // 2.1f
      for j := 0 to 255 do begin
         if Assigned(FTwoLetterMatrix[i, j]) then begin
            FreeAndNil(FTwoLetterMatrix[i, j]);
         end;
      end;
   end;
end;

function TSuperCheck.GetFontSize(): Integer;
begin
   Result := ListBox.Font.Size;
end;

procedure TSuperCheck.SetFontSize(v: Integer);
begin
   ListBox.Font.Size := v;
end;

procedure TSuperCheck.ListBoxDblClick(Sender: TObject);
var
   i, j: integer;
   str: string;
begin
   i := ListBox.ItemIndex;
   str := ListBox.Items[i];

   j := Pos(' ', str);
   if j > 0 then begin
      str := copy(str, 1, j - 1);
   end;

   MainForm.CallsignEdit.Text := str;
end;

procedure TSuperCheck.StayOnTopClick(Sender: TObject);
begin
   If StayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
end;

procedure TSuperCheck.SpinEditChange(Sender: TObject);
begin
   if SpinEdit.Value <= 1 then
      ListBox.Columns := 0
   else
      ListBox.Columns := SpinEdit.Value;
end;

procedure TSuperCheck.LoadSpcFile(strStartFoler: string);
var
   F: TextFile;
   filename: string;
   C, N: string;
   i: Integer;
   str: string;
   dtNow: TDateTime;
begin
   // 指定フォルダ優先
   filename := IncludeTrailingPathDelimiter(strStartFoler) + 'ZLOG.SPC';
   if FileExists(filename) = False then begin
      // 無ければZLOG.EXEを同じ場所（従来通り）
      filename := ExtractFilePath(Application.EXEName) + 'ZLOG.SPC';
      if FileExists(filename) = False then begin
         Exit;
      end;
   end;

   dtNow := Now;

   AssignFile(F, filename);
   Reset(F);

   while not(EOF(F)) do begin
      // 1行読み込み
      ReadLn(F, str);

      // 空行除く
      if str = '' then begin
         Continue;
      end;

      // 先頭;はコメント行
      if str[1] = ';' then begin
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

      SetTwoMatrix(dtNow, C, N);
   end;

   CloseFile(F);
end;

procedure TSuperCheck.LoadLogFiles(strStartFoler: string);
var
   ret: Integer;
   F: TSearchRec;
   S: string;
   L: TQSOList;
begin
   if strStartFoler = '' then begin
      Exit;
   end;

   L := TQSOList.Create();
   try
      S := IncludeTrailingPathDelimiter(strStartFoler);

      ret := FindFirst(S + '*.ZLO', faAnyFile, F);
      while ret = 0 do begin
         if ((F.Attr and faDirectory) = 0) and
            ((F.Attr and faVolumeID) = 0) and
            ((F.Attr and faSysFile) = 0) then begin

            L.Clear();

            // listにロードする
            L.MergeFile(S + F.Name);

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

procedure TSuperCheck.ListToTwoMatrix(L: TQSOList);
var
   i: Integer;
   Q: TQSO;
begin
   for i := 1 to L.Count - 1 do begin
      Q := L[i];
      SetTwoMatrix(Q.Time, Q.Callsign, Q.NrRcvd);
   end;
end;

procedure TSuperCheck.SetTwoMatrix(D: TDateTime; C, N: string);
var
   sd1: TSuperData;
   sd2: TSuperData;
   i: Integer;
   x: Integer;
   y: Integer;
   O: TSuperData;
begin
   sd1 := TSuperData.Create(D, C, N);

   // リストに追加
   O := FSuperCheckList.ObjectOf(sd1);
   if O = nil then begin
      FSuperCheckList.Add(sd1);
      FSuperCheckList.SortByCallsign();
   end
   else begin
      if O.Date < D then begin
         O.Date := D;
         O.Number := N;
      end;
      sd1.Free();
   end;

   // TwoLetterリストに追加
   for i := 1 to length(C) - 1 do begin
      sd2 := TSuperData.Create(D, C, N);
      x := Ord(sd2.callsign[i]);
      y := Ord(sd2.callsign[i + 1]);
      O := FTwoLetterMatrix[x, y].ObjectOf(sd2);
      if O = nil then begin
         FTwoLetterMatrix[x, y].Add(sd2);
         FTwoLetterMatrix[x, y].SortByCallsign();
      end
      else begin
         if O.Date < D then begin
            O.Date := D;
            O.Number := N;
         end;
         sd2.Free();
      end;
   end;
end;

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
begin
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
begin
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

{ TSuperListComparer1 }

function TSuperListComparer1.Compare(const Left, Right: TSuperData): Integer;
begin
   Result := CompareText(Left.Callsign, Right.Callsign);
end;

end.
