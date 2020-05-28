unit UIOTAMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UACAGMulti, Grids, Cologrid, StdCtrls, JLLabel, ExtCtrls, UITypes,
  UzLogConst, UzLogGlobal, UzLogQSO, UMultipliers, UzLogCW;

type
  TIsland = class
    RefNumber : string;
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
  public
    { Public declarations }
    MyIOTA, MyDXCC : string;
    function ExtractMulti(aQSO : TQSO) : string; override;
    procedure Reset; override;
    procedure UpdateData; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
    procedure CheckMulti(aQSO : TQSO); override;
  end;

implementation

uses Main, UNewIOTARef, UOptions, UIOTACategory;

{$R *.DFM}

function TIOTAMulti.ValidMulti(aQSO: TQSO): boolean;
begin
   Result := True;
end;

constructor TIsland.Create;
var
   B: TBand;
   M: TMode;
begin
   RefNumber := '';
   Name := '';
   for B := b19 to HiBand do
      for M := mCW to mSSB do
         Worked[B, M] := False;
end;

function TIsland.Summary: string;
var
   str: string;
   strname: string;
   B: TBand;
   M: TMode;
begin
   strname := Name;
   str := FillRight(RefNumber, 6) + FillRight(strname, 31);
   for B := b35 to b28 do begin
      if NotWARC(B) then begin
         for M := mCW to mSSB do begin
            if Worked[B, M] = True then
               str := str + '* '
            else
               str := str + '. ';
         end;
      end;
   end;

   Result := str;
end;

constructor TIslandList.Create;
begin
   List := TList.Create;
end;

destructor TIslandList.Destroy;
var
   i: Integer;
begin
   for i := 0 to List.Count - 1 do begin
      if List[i] <> nil then
         TIsland(List[i]).Free;
   end;
   List.Free;
end;

procedure TIslandList.LoadFromFile(filename: string);
var
   f: textfile;
   str: string;
   i: TIsland;
begin
   assign(f, filename);
   try
      Reset(f);
   except
      on EFOpenError do begin
         MessageDlg('DAT file ' + filename + ' cannot be opened', mtError, [mbOK], 0);
         exit; { Alert that the file cannot be opened \\ }
      end;
   end;
   readln(f, str);
   while not(eof(f)) do begin
      readln(f, str);
      if Pos('end of file', LowerCase(str)) > 0 then
         break;
      i := TIsland.Create;
      i.RefNumber := Copy(str, 1, 5);
      Delete(str, 1, 6);
      i.Name := str;
      List.Add(i);
   end;
   system.close(f);
end;

procedure TIslandList.SaveToFile(filename: string);
var
   f: textfile;
   str: string;
   i: TIsland;
   j: Integer;
begin
   assign(f, filename);
   try
      rewrite(f);
   except
      on EFOpenError do begin
         MessageDlg('DAT file ' + filename + ' cannot be opened', mtError, [mbOK], 0);
         exit; { Alert that the file cannot be opened \\ }
      end;
   end;
   for j := 0 to List.Count - 1 do begin
      i := TIsland(List[j]);
      str := i.RefNumber + ' ' + i.Name;
      writeln(f, str);
   end;
   system.close(f);
end;

function TIOTAMulti.ExtractMulti(aQSO: TQSO): string;
var
   i, k: Integer;
   S, work, cont: string;
begin
   S := aQSO.NrRcvd;
   Result := '';

   for i := 1 to length(S) do begin
      if CharInSet(S[i], ['A' .. 'Z']) then begin
         work := S;
         Delete(work, 1, i - 1);
         if Pos('-', work) > 0 then
            Delete(work, Pos('-', work), 1);

         cont := Copy(work, 1, 2);
         if Pos(cont, 'AF;AS;AN;EU;OC;NA;SA') = 0 then
            exit;
         Delete(work, 1, 2);
         if length(work) in [1 .. 3] then begin
            try
               k := StrToInt(work);
            except
               on EConvertError do
                  exit; // not a number
            end;

            case k of
               0 .. 9:
                  work := '00' + IntToStr(k);
               10 .. 99:
                  work := '0' + IntToStr(k);
               else
                  work := IntToStr(k);
            end;
            work := cont + work;
         end
         else begin // not one to three digit
            exit;
         end;

         Result := work;
      end;
   end;
end;

procedure TIOTAMulti.AddNoUpdate(var aQSO: TQSO);
var
   str: string;
   i: Integer;
   C: TIsland;
   f: TNewIOTARef;
begin
   f := TNewIOTARef.Create(Self);
   try
      aQSO.NewMulti1 := False;
      str := ExtractMulti(aQSO);

      if str = '' then
         aQSO.Points := 3
      else if str = MyIOTA then
         aQSO.Points := 3
      else
         aQSO.Points := 15;

      aQSO.Multi1 := str;

      if aQSO.Dupe then
         exit;

      if str = '' then
         exit;

      for i := 0 to IslandList.List.Count - 1 do begin
         C := TIsland(IslandList.List[i]);
         if str = C.RefNumber then begin
            if C.Worked[aQSO.band, aQSO.Mode] = False then begin
               C.Worked[aQSO.band, aQSO.Mode] := True;
               aQSO.NewMulti1 := True;
            end;
            LatestMultiAddition := i;
            exit;
         end;
      end;

      f.SetNewRef(str);
      if f.ShowModal <> mrOK then begin
         exit;
      end;

      C := TIsland.Create;
      C.Name := f.GetName;
      C.RefNumber := str;
      C.Worked[aQSO.band, aQSO.Mode] := True;
      aQSO.NewMulti1 := True;

      // Å´Ç«Ç§çlÇ¶ÇƒÇ‡ÉoÉOÇ¡ÇƒÇ¢ÇÈ
      for i := 0 to IslandList.List.Count - 1 do begin
         if StrMore(str, TIsland(IslandList.List[i]).RefNumber) = False then begin
            IslandList.List.Insert(i, C);
            IslandList.SaveToFile('IOTA.DAT');
            exit;
         end;

         IslandList.List.Add(C);
         IslandList.SaveToFile('IOTA.DAT');
         exit;
      end;
   finally
      f.Release();
   end;
end;

procedure TIOTAMulti.Reset;
var
   i, j: Integer;
   M: TMode;
   B: TBand;
   str: string;
begin
   if IslandList.List.Count = 0 then
      exit;

   j := Grid.TopRow;
   Grid.RowCount := 0;
   Grid.RowCount := IslandList.List.Count;
   for i := 0 to IslandList.List.Count - 1 do begin
      for B := b19 to HiBand do
         for M := mCW to mSSB do
            TIsland(IslandList.List[i]).Worked[B, M] := False;
      str := TIsland(IslandList.List[i]).Summary;
      Grid.Cells[0, i] := str;
   end;
   Grid.TopRow := j;
end;

procedure TIOTAMulti.UpdateData;
var
   i: Integer;
   C: TIsland;
   str: string;
begin
   for i := 0 to IslandList.List.Count - 1 do begin
      C := TIsland(IslandList.List[i]);
      str := C.Summary;
      Grid.Cells[0, i] := str;
   end;
   Grid.TopRow := LatestMultiAddition;
end;

procedure TIOTAMulti.FormCreate(Sender: TObject);
var
   Q: TQSO;
   P: TPrefix;
   dlg: TIOTACategory;
begin
   // inherited;
   IslandList := TIslandList.Create;
   IslandList.LoadFromFile('IOTA.DAT');
   Reset;

   CountryList := TCountryList.Create;
   PrefixList := TPrefixList.Create;

   if LoadCTY_DAT() = False then begin
      Exit;
   end;

   MainForm.WriteStatusLine('Loaded CTY.DAT', true);

   if CountryList.Count = 0 then begin
      Exit;
   end;

   Q := TQSO.Create;
   try
      Q.Callsign := UpperCase(dmZLogGlobal.MyCall);
      P := GetPrefix(Q);
      MyDXCC := P.Country.Country;
   finally
      Q.Free;
   end;

   dlg := TIOTACategory.Create(MainForm);
   try
      dlg.Label1.Caption := MyDXCC;

      if dlg.ShowModal = mrOK then begin // OKÇµÇ©Ç»Ç¢ÇØÇ«...
         MyIOTA := dlg.GetIOTA;
      end
      else begin
         MyIOTA := '';
      end;
   finally
      dlg.Release();
   end;

   UzLogCW.QTHString := MyIOTA;
end;

procedure TIOTAMulti.GridSetting(ARow, Acol: Integer; var Fcolor: Integer; var Bold, Italic, underline: boolean);
var
   B: TBand;
   M: TMode;
begin
   // inherited;
   B := Main.CurrentQSO.band;
   M := Main.CurrentQSO.Mode;
   if TIsland(IslandList.List[ARow]).Worked[B, M] then
      Fcolor := clRed
   else
      Fcolor := clBlack;
end;

procedure TIOTAMulti.GoButtonClick2(Sender: TObject);
var
   temp: string;
   i: Integer;
begin
   temp := Edit1.Text;
   for i := 0 to IslandList.List.Count - 1 do begin
      if Pos(temp, TIsland(IslandList.List[i]).RefNumber) = 1 then begin
         Grid.TopRow := i;
         break;
      end;
   end;
end;

procedure TIOTAMulti.FormDestroy(Sender: TObject);
begin
   inherited;
   PrefixList.Free();
   CountryList.Free();
   IslandList.Free();
end;

procedure TIOTAMulti.CheckMulti(aQSO: TQSO);
var
   str: string;
   i: Integer;
   C: TIsland;
begin
   str := ExtractMulti(aQSO);
   if str = '' then
      exit;
   for i := 0 to IslandList.List.Count - 1 do begin
      C := TIsland(IslandList.List[i]);
      if str = C.RefNumber then begin
         // ListBox.TopIndex := i;
         Grid.TopRow := i;
         str := C.Summary;
         if C.Worked[aQSO.band, aQSO.Mode] then
            str := str + 'Worked on this band/mode.'
         else
            str := str + 'Needed on this band/mode.';
         MainForm.WriteStatusLine(str, False);
         exit;
      end;
   end;

   MainForm.WriteStatusLine('Invalid number', False);
end;

end.
