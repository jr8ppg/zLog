unit UIOTAMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UACAGMulti, Grids, StdCtrls, JLLabel, ExtCtrls, UITypes,
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
    procedure GoButtonClick2(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  protected
    procedure UpdateLabelPos(); override;
    function GetIsIncrementalSearchPresent(): Boolean; override;
  private
    { Private declarations }
    IslandList : TIslandList;
    procedure GoForwardMatch(strCode: string);
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
   str := FillRight(RefNumber, 6) +
          StringReplace(FillRight(strname, 31), '&', '&&', [rfReplaceAll]);

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

procedure TIOTAMulti.Edit1Change(Sender: TObject);
begin
   if (checkIncremental.Checked = True) then begin
      GoForwardMatch(Edit1.Text);
   end;
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
      for B := b19 to HiBand do begin
         for M := mCW to mSSB do begin
            TIsland(IslandList.List[i]).Worked[B, M] := False;
         end;
      end;

      str := TIsland(IslandList.List[i]).Summary;
      Grid.Cells[0, i] := str;
   end;

   Grid.TopRow := j;
end;

procedure TIOTAMulti.UpdateData;
var
   i: Integer;
   C: TIsland;
   B: TBand;
   M: TMode;
begin
   B := Main.CurrentQSO.Band;
   if B = bUnknown then begin
      Exit;
   end;

   M := Main.CurrentQSO.Mode;

   for i := 0 to IslandList.List.Count - 1 do begin
      C := TIsland(IslandList.List[i]);

      if C.Worked[B, M] then begin
         Grid.Cells[0, i] := '~' + C.Summary;
      end
      else begin
         Grid.Cells[0, i] := C.Summary;
      end;
   end;

   Grid.TopRow := LatestMultiAddition;
end;

procedure TIOTAMulti.FormCreate(Sender: TObject);
var
   P: TPrefix;
   dlg: TIOTACategory;
   strCallsign: string;
begin
   // inherited;
   IslandList := TIslandList.Create;
   IslandList.LoadFromFile('IOTA.DAT');
   Reset;

   strCallsign := UpperCase(dmZLogGlobal.MyCall);
   P := dmZLogGlobal.GetPrefix(strCallsign);
   MyDXCC := P.Country.Country;

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
end;

procedure TIOTAMulti.GoButtonClick2(Sender: TObject);
begin
   GoForwardMatch(Edit1.Text);
end;

procedure TIOTAMulti.GoForwardMatch(strCode: string);
var
   i: Integer;
   l: Integer;
begin
   l := Length(strCode);
   for i := 0 to IslandList.List.Count - 1 do begin
      if (strCode = Copy(TIsland(IslandList.List[i]).RefNumber, 1, l)) then begin
         Grid.TopRow := i;
         Break;
      end;
   end;
end;

procedure TIOTAMulti.FormDestroy(Sender: TObject);
begin
   inherited;
   IslandList.Free();
end;

procedure TIOTAMulti.CheckMulti(aQSO: TQSO);
var
   str: string;
   i: Integer;
   C: TIsland;
begin
   Edit1.Text := aQSO.NrRcvd;

   if aQSO.NrRcvd = '' then begin
      MainForm.WriteStatusLine('', False);
      Exit;
   end;

   str := ExtractMulti(aQSO);
   if str = '' then begin
      Exit;
   end;

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

   MainForm.WriteStatusLine(TMainForm_Invalid_number, False);
end;

procedure TIOTAMulti.UpdateLabelPos();
var
   w, l: Integer;
begin
   w := Grid.Canvas.TextWidth('X');
   l := (w * 37) - 2;
   Label1R9.Left  := l;
   Label3R5.Left  := Label1R9.Left + (w * 2);
   Label7.Left    := Label3R5.Left + (w * 2);
   Label14.Left   := Label7.Left + (w * 2);
   Label21.Left   := Label14.Left + (w * 2);
   Label28.Left   := Label21.Left + (w * 2);
   Label50.Left   := Label28.Left + (w * 2);
   Label144.Left  := Label50.Left + (w * 2);
   Label430.Left  := Label144.Left + (w * 2);
   Label1200.Left := Label430.Left + (w * 2);
end;

function TIOTAMulti.GetIsIncrementalSearchPresent(): Boolean;
begin
   Result := checkIncremental.Checked;
end;

end.
