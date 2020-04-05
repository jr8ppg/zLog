unit UIOTAMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UACAGMulti, Grids, Cologrid, StdCtrls, JLLabel, ExtCtrls,
  UzLogConst, UzLogGlobal, UzLogQSO, UMultipliers, UzLogCW;

type
  TIsland = class
    RefNumber : string[7];
    Name : string;
    Worked : array[b19..HiBand, mCW..mSSB] of boolean;
    constructor Create;
    function Summary : string;
  end;

  TIslandList = class
    List : TList;
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromFile(filename : string);
    procedure SaveToFile(filename : string);
  end;

  TIOTAMulti = class(TACAGMulti)
    procedure FormCreate(Sender: TObject);
    procedure GridSetting(ARow, Acol: Integer; var Fcolor: Integer;
      var Bold, Italic, underline: Boolean);
    procedure GoButtonClick2(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    IslandList : TIslandList;
    CountryList : TCountryList;
    PrefixList : TPrefixList;
  public
    MyIOTA, MyDXCC : string;
    function ExtractMulti(aQSO : TQSO) : string; override;
    procedure Reset; override;
    procedure Update; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
    procedure CheckMulti(aQSO : TQSO); override;
    { Public declarations }
  end;

implementation

uses Main, UNewIOTARef, UOptions, UIOTACategory;

{$R *.DFM}

function TIOTAMulti.ValidMulti(aQSO : TQSO) : boolean;
begin
  Result := True;
end;

constructor TIsland.Create;
var B : TBand;
    M : TMode;
begin
  RefNumber := '';
  Name := '';
  for B := b19 to HiBand do
    for M := mCW to mSSB do
      Worked[B, M] := False;
end;

function TIsland.Summary : string;
var str : string;
    strname : string[30];
    B : TBand;
    M : TMode;
begin
  strname := Name;
  str := FillRight(RefNumber,6) + FillRight(strname, 31);
  for B := b35 to b28 do
    if NotWARC(B) then
      for M := mCW to mSSB do
        if Worked[B, M] = True then
          str := str + '* '
        else
          str := str + '. ';
  Result := str;
end;

constructor TIslandList.Create;
begin
  List := TList.Create;
end;

destructor TIslandList.Destroy;
var i : integer;
begin
  for i := 0 to List.Count - 1 do
    begin
      if List[i] <> nil then
        TIsland(List[i]).Free;
    end;
  List.Free;
end;

procedure TIslandList.LoadFromFile(filename : string);
var f : textfile;
    str : string;
    I : TIsland;
begin
  assign(f, filename);
  try
    reset(f);
  except
    on EFOpenError do
      begin
        MessageDlg('DAT file '+filename+' cannot be opened', mtError,
                   [mbOK], 0);
        exit;    {Alert that the file cannot be opened \\}
      end;
  end;
  readln(f, str);
  while not(eof(f)) do
    begin
      readln(f, str);
      if Pos('end of file', LowerCase(str))>0 then break;
      I := TIsland.Create;
      I.RefNumber := Copy(str, 1, 5);
      Delete(str, 1, 6);
      I.Name := str;
      List.Add(I);
    end;
  system.close(f);
end;

procedure TIslandList.SaveToFile(filename : string);
var f : textfile;
    str : string;
    I : TIsland;
    j : integer;
begin
  assign(f, filename);
  try
    rewrite(f);
  except
    on EFOpenError do
      begin
        MessageDlg('DAT file '+filename+' cannot be opened', mtError,
                   [mbOK], 0);
        exit;    {Alert that the file cannot be opened \\}
      end;
  end;
  for j := 0 to List.Count - 1 do
    begin
      I := TIsland(List[j]);
      str := I.RefNumber + ' ' + I.Name;
      writeln(f, str);
    end;
  system.close(f);
end;

function TIOTAMulti.ExtractMulti(aQSO : TQSO) : string;
var i, k : integer;
    S, work, cont : string;
begin
  S := aQSO.NrRcvd;
  Result := '';
  for i := 1 to length(S) do
    if S[i] in ['A'..'Z'] then
      begin
        work := S;
        Delete(work, 1, i - 1);
        if pos('-',work) > 0 then
          Delete(work, pos('-',work), 1);

        cont := copy(work, 1, 2);
        if pos(cont, 'AF;AS;AN;EU;OC;NA;SA') = 0 then
          exit;
        Delete(work,1,2);
        if length(work) in [1..3] then
          begin
            try
              k := StrToInt(work);
            except
              on EConvertError do
                exit; // not a number
            end;
            case k of
              0..9 : work := '00'+IntToStr(k);
              10..99 : work := '0'+IntToStr(k);
            else
              work := IntToStr(k);
            end;
            work := cont + work;
          end
        else // not one to three digit
          exit;
        {
        if length(work) <> 5 then
          exit;
        for j := 3 to 5 do
          if not(work[j] in ['0'..'9']) then
            exit; }
        Result := work;
      end;
end;

procedure TIOTAMulti.AddNoUpdate(var aQSO : TQSO);
var str, str2 : string;
    i, j : integer;
    C : TIsland;
    P : TPrefix;
   F: TNewIOTARef;
begin
   F := TNewIOTARef.Create(Self);
   try
      aQSO.NewMulti1 := False;
      str := ExtractMulti(aQSO);

      if str = '' then
         aQSO.Points := 3
      else
         if str = MyIOTA then
            aQSO.Points := 3
         else
            aQSO.Points := 15;

      aQSO.Multi1 := str;

      if aQSO.Dupe then
         exit;

      if str = '' then
         exit;

      for i := 0 to IslandList.List.Count-1 do begin
         C := TIsland(IslandList.List[i]);
         if str = C.RefNumber then begin
            if C.Worked[aQSO.band, aQSO.Mode] = False then begin
               C.Worked[aQSO.band, aQSO.Mode] := True;
               aQSO.NewMulti1 := True;
            end;
            LatestMultiAddition := i;
            Exit;
         end;
      end;

      F.SetNewRef(str);
      if F.ShowModal <> mrOK then begin
         Exit;
      end;

      C := TIsland.Create;
      C.Name := F.GetName;
      C.RefNumber := str;
      C.Worked[aQSO.band, aQSO.Mode] := True;
      aQSO.NewMulti1 := True;

      // Å´Ç«Ç§çlÇ¶ÇƒÇ‡ÉoÉOÇ¡ÇƒÇ¢ÇÈ
      for i := 0 to IslandList.List.Count-1 do begin
         if StrMore(str, TIsland(IslandList.List[i]).RefNumber) = False then begin
            IslandList.List.Insert(i,C);
            IslandList.SaveToFile('IOTA.DAT');
            Exit;
         end;

         IslandList.List.Add(C);
         IslandList.SaveToFile('IOTA.DAT');
         Exit;
      end;
   finally
      F.Release();
   end;
end;

procedure TIOTAMulti.Reset;
var i, j : integer;
    M : TMode;
    B : TBand;
    str : string;
begin
  if IslandList.List.Count = 0 then exit;
  j := Grid.TopRow;
  Grid.RowCount := 0;
  Grid.RowCount := IslandList.List.Count;
  for i := 0 to IslandList.List.Count-1 do
    begin
      for B := b19 to HiBand do
        for M := mCW to mSSB do
          TIsland(IslandList.List[i]).Worked[B, M] := false;
      str := TIsland(IslandList.List[i]).Summary;
      Grid.Cells[0,i] := str;
    end;
  Grid.TopRow := j;
end;

procedure TIOTAMulti.Update;
var i : integer;
    C : TIsland;
    str : string;
begin
  for i := 0 to IslandList.List.Count-1 do
    begin
      C := TIsland(IslandList.List[i]);
      str := C.Summary;
      Grid.Cells[0,i] := str;
    end;
  Grid.TopRow := LatestMultiAddition;
end;

procedure TIOTAMulti.FormCreate(Sender: TObject);
var Q : TQSO;
    P : TPrefix;
begin
  //inherited;
  IslandList := TIslandList.Create;
  IslandList.LoadFromFile('IOTA.DAT');
  Reset;

  CountryList := TCountryLIst.Create;
  PrefixList := TPrefixList.Create;

  if FileExists('CTY.DAT') then
    begin
      LoadCTY_DAT(testDXCCWWZone, CountryList, PrefixList);
      MainForm.WriteStatusLine('Loaded CTY.DAT', true);
    end
  else
    LoadCountryDataFromFile('DXCC.DAT', CountryList, PrefixList);

  if CountryList.List.Count = 0 then exit;

  Q := TQSO.Create;
  Q.Callsign := UpperCase(dmZLogGlobal.MyCall);
  P := GetPrefixX(Q, PrefixList);
  MyDXCC := TCountry(CountryList.List[P.Index]).Country;
  Q.Free;

  MyIOTA := '';

  Application.CreateForm(TIOTACategory, IOTACategory);
  IOTACategory.Label1.Caption := MyDXCC;

  if IOTACategory.ShowModal = mrOK then
    MyIOTA := IOTACategory.GetIOTA;

  IOTACategory.Free;

  UzLogCW.QTHString := MyIOTA;
end;

procedure TIOTAMulti.GridSetting(ARow, Acol: Integer; var Fcolor: Integer;
  var Bold, Italic, underline: Boolean);
var B : TBand;
    M : TMode;
begin
  //inherited;
  B := Main.CurrentQSO.Band;
  M := Main.CurrentQSO.Mode;
  if TIsland(IslandList.List[ARow]).Worked[B, M] then
    FColor := clRed
  else
    FColor := clBlack;
end;

procedure TIOTAMulti.GoButtonClick2(Sender: TObject);
var temp : string;
    i : integer;
begin
  temp := Edit1.Text;
  for i := 0 to IslandList.List.Count-1 do
    begin
      if pos(temp,TIsland(IslandList.List[i]).RefNumber) = 1 then
        begin
          Grid.TopRow := i;
          break;
        end;
    end;
end;

procedure TIOTAMulti.FormDestroy(Sender: TObject);
begin
  inherited;
  PrefixList.Destroy;
  CountryList.Destroy;
  IslandList.Destroy;
end;

procedure TIOTAMulti.CheckMulti(aQSO : TQSO);
var str : string;
    i : integer;
    C : TIsland;
begin
  str := ExtractMulti(aQSO);
  if str = '' then
    exit;
  for i := 0 to IslandList.List.Count-1 do
    begin
      C := TIsland(IslandList.List[i]);
      if str = C.RefNumber then
        begin
          //ListBox.TopIndex := i;
          Grid.TopRow := i;
          str := C.Summary;
          if C.Worked[aQSO.Band, aQSO.Mode] then
            str := str + 'Worked on this band/mode.'
          else
            str := str + 'Needed on this band/mode.';
          MainForm.WriteStatusLine(str, false);
          exit;
        end;
    end;
  MainForm.WriteStatusLine('Invalid number', false);
end;


end.
