unit USuperCheck;

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

  TSuperList = class(TObjectList<TSuperData>)
  private
  public
    constructor Create(OwnsObjects: Boolean = True);
    function IndexOf(SD: TSuperData): Integer;
    function ObjectOf(SD: TSuperData): TSuperData;
    procedure SortByCallsign();
  end;

  TSuperListComparer1 = class(TComparer<TSuperData>)
  public
    function Compare(const Left, Right: TSuperData): Integer; override;
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
    procedure LoadSpcFile();
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

var
  SuperCheck: TSuperCheck;

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
         exit;
      end;

      for i := 1 to length(A) do begin
         if A[i] <> '.' then begin
            if A[i] <> B[i] then begin
               exit;
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
      exit;
   end;

   // ,で始まるコマンド
   if Pos(',', PartialStr) = 1 then begin
      exit;
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
begin
   ListBox.Clear();

   FreeData();

   FSuperCheckList := TSuperList.Create(True);

   for i := 0 to 255 do begin // 2.1f
      for j := 0 to 255 do begin
         FTwoLetterMatrix[i, j] := TSuperList.Create(False);
      end;
   end;

   case dmZlogGlobal.Settings.FSuperCheck.FSuperCheckMethod of
      // SPC
      0: begin
         LoadSpcFile();
      end;

      // ZLO
      1: begin
         LoadLogFiles(dmZlogGlobal.Settings.FSuperCheck.FSuperCheckFolder);
      end

      // Both
      else begin
         LoadSpcFile();
         LoadLogFiles(dmZlogGlobal.Settings.FSuperCheck.FSuperCheckFolder);
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
   if j > 0 then
      str := copy(str, 1, j - 1);

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

procedure TSuperCheck.LoadSpcFile();
var
   F: TextFile;
   filename: string;
   C, N: string;
   i: Integer;
   str: string;
begin
   filename := ExtractFilePath(Application.EXEName) + 'ZLOG.SPC';
   if FileExists(filename) = False then begin
      exit;
   end;

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

      SetTwoMatrix(0, C, N);
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

   L := TQSOList.Create('');
   try
      S := IncludeTrailingPathDelimiter(strStartFoler);

      ret := FindFirst(S + '*.ZLO', faAnyFile, F);
      while ret = 0 do begin
         if ((F.Attr and faDirectory) = 0) and
            ((F.Attr and faVolumeID) = 0) and
            ((F.Attr and faSysFile) = 0) then begin

            L.Clear();

            // listにロードする
            L.LoadFromFile(S + F.Name);

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
   sd: TSuperData;
   i: Integer;
   x: Integer;
   y: Integer;
begin
   sd := TSuperData.Create(D, C, N);

   // リストに追加
   if FSuperCheckList.IndexOf(sd) = -1 then begin
      FSuperCheckList.Add(sd);
      FSuperCheckList.SortByCallsign();
   end;

   // TwoLetterリストに追加
   for i := 1 to length(sd.callsign) - 1 do begin
      x := Ord(sd.callsign[i]);
      y := Ord(sd.callsign[i + 1]);
      if FTwoLetterMatrix[x, y].IndexOf(sd) = -1 then begin
         FTwoLetterMatrix[x, y].Add(sd);
         FTwoLetterMatrix[x, y].SortByCallsign();
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
end;

function TSuperList.IndexOf(SD: TSuperData): Integer;
var
   Index: Integer;
begin
   if BinarySearch(SD, Index, TSuperListComparer1.Create()) = True then begin
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
   if BinarySearch(SD, Index, TSuperListComparer1.Create()) = True then begin
      Result := Items[Index];
   end
   else begin
      Result := nil;
   end;
end;

procedure TSuperList.SortByCallsign();
begin
   Sort(TSuperListComparer1.Create());
end;

{ TSuperListComparer1 }

function TSuperListComparer1.Compare(const Left, Right: TSuperData): Integer;
begin
   Result := CompareText(Left.Callsign, Right.Callsign);
end;

end.
